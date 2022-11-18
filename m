Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2584D62FBE9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Nov 2022 18:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242329AbiKRRpk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Nov 2022 12:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242180AbiKRRph (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Nov 2022 12:45:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5E12C13B
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Nov 2022 09:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668793479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mo4IzVlRYj0qYTU0BWEImpuZnJeYQClJ9ltMhXF4z+U=;
        b=MMyYhp7ZkcuZEcp7oWQ/jBBHXhdu4gBS1GcC7gHb9Fn8KqDC+FiSPubPl1QkmEA0dlOlKz
        ylOHy6+SZiw1ii2u8hK3bOe0xWGVrV0S8ubZkYxnpfhAImTPz4Q3bAkQkT5TaFYOxkcRa4
        6tRdtAHEk4zHm5ev/q8QBY6Fm5wqCQQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-80-kr8jK1B5OUOH0pYLa5UUOg-1; Fri, 18 Nov 2022 12:44:38 -0500
X-MC-Unique: kr8jK1B5OUOH0pYLa5UUOg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 21330185A78B;
        Fri, 18 Nov 2022 17:44:38 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2ED4E40C6EC3;
        Fri, 18 Nov 2022 17:44:37 +0000 (UTC)
From:   Paolo Abeni <pabeni@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Carlos Maiolino <cmaiolino@redhat.com>
Subject: [PATCH] epoll: use refcount to reduce ep_mutex contention
Date:   Fri, 18 Nov 2022 18:44:03 +0100
Message-Id: <d83b1962271d06c18d97f05266ea37241ee435e2.1668793437.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We are observing huge contention on the epmutex during an http
connection/rate test:

 83.17% 0.25%  nginx            [kernel.kallsyms]         [k] entry_SYSCALL_64_after_hwframe
[...]
           |--66.96%--__fput
                      |--60.04%--eventpoll_release_file
                                 |--58.41%--__mutex_lock.isra.6
                                           |--56.56%--osq_lock

The application is multi-threaded, creates a new epoll entry for
each incoming connection, and does not delete it before the
connection shutdown - that is, before the connection's fd close().

Many different threads compete frequently for the epmutex lock,
affecting the overall performance.

To reduce the contention this patch introduces explicit reference counting
for the eventpoll struct. Each registered event acquires a reference,
and references are released at ep_remove() time. ep_free() doesn't touch
anymore the event RB tree, it just unregisters the existing callbacks
and drops a reference to the ep struct. The struct itself is freed when
the reference count reaches 0. The reference count updates are protected
by the mtx mutex so no additional atomic operations are needed.

Since ep_free() can't compete anymore with eventpoll_release_file()
for epitems removal, we can drop the epmutex usage at disposal time.

With the patched kernel, in the same connection/rate scenario, the mutex
operations disappear from the perf report, and the measured connections/rate
grows by ~60%.

Tested-by: Xiumei Mu <xmu@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
Similar patches have been already posted in the past:

https://lore.kernel.org/linux-fsdevel/20190727113542.162213-1-cj.chengjian@huawei.com/
https://lkml.org/lkml/2017/10/28/81

but as far as I can see they generated little discussion.

I'd like to understand if this kind of approach is suitable for the
fs subsystem. The contention problem could possibly be solved with
application-level changes, invoking epoll_ctl(EPOLL_CTL_DEL) on the
connection file descriptor before closing it.

Still I think it would be nicer to avoid an additional syscall, that
could possibly cause regressions in other scenarios, especially given
the ever increasing cost to do the kernel-space/user-space transition.
---
 fs/eventpoll.c | 113 ++++++++++++++++++++++++++++---------------------
 1 file changed, 64 insertions(+), 49 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 52954d4637b5..6e415287aeb8 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -226,6 +226,12 @@ struct eventpoll {
 	/* tracks wakeup nests for lockdep validation */
 	u8 nests;
 #endif
+
+	/*
+	 * protected by mtx, used to avoid races between ep_free() and
+	 * ep_eventpoll_release()
+	 */
+	unsigned int refcount;
 };
 
 /* Wrapper struct used by poll queueing */
@@ -240,9 +246,6 @@ struct ep_pqueue {
 /* Maximum number of epoll watched descriptors, per user */
 static long max_user_watches __read_mostly;
 
-/*
- * This mutex is used to serialize ep_free() and eventpoll_release_file().
- */
 static DEFINE_MUTEX(epmutex);
 
 static u64 loop_check_gen = 0;
@@ -555,8 +558,7 @@ static void ep_remove_wait_queue(struct eppoll_entry *pwq)
 
 /*
  * This function unregisters poll callbacks from the associated file
- * descriptor.  Must be called with "mtx" held (or "epmutex" if called from
- * ep_free).
+ * descriptor.  Must be called with "mtx" held.
  */
 static void ep_unregister_pollwait(struct eventpoll *ep, struct epitem *epi)
 {
@@ -679,11 +681,37 @@ static void epi_rcu_free(struct rcu_head *head)
 	kmem_cache_free(epi_cache, epi);
 }
 
+static void ep_get(struct eventpoll *ep)
+{
+	ep->refcount++;
+}
+
+/*
+ * Returns true if the event poll can be disposed
+ */
+static bool ep_put(struct eventpoll *ep)
+{
+	if (--ep->refcount)
+		return false;
+
+	WARN_ON_ONCE(!RB_EMPTY_ROOT(&ep->rbr.rb_root));
+	return true;
+}
+
+static void ep_dispose(struct eventpoll *ep)
+{
+	mutex_destroy(&ep->mtx);
+	free_uid(ep->user);
+	wakeup_source_unregister(ep->ws);
+	kfree(ep);
+}
+
 /*
  * Removes a "struct epitem" from the eventpoll RB tree and deallocates
  * all the associated resources. Must be called with "mtx" held.
+ * Returns true if the eventpoll can be disposed.
  */
-static int ep_remove(struct eventpoll *ep, struct epitem *epi)
+static bool ep_remove(struct eventpoll *ep, struct epitem *epi)
 {
 	struct file *file = epi->ffd.file;
 	struct epitems_head *to_free;
@@ -731,28 +759,20 @@ static int ep_remove(struct eventpoll *ep, struct epitem *epi)
 	call_rcu(&epi->rcu, epi_rcu_free);
 
 	percpu_counter_dec(&ep->user->epoll_watches);
-
-	return 0;
+	return ep_put(ep);
 }
 
 static void ep_free(struct eventpoll *ep)
 {
 	struct rb_node *rbp;
 	struct epitem *epi;
+	bool dispose;
 
 	/* We need to release all tasks waiting for these file */
 	if (waitqueue_active(&ep->poll_wait))
 		ep_poll_safewake(ep, NULL);
 
-	/*
-	 * We need to lock this because we could be hit by
-	 * eventpoll_release_file() while we're freeing the "struct eventpoll".
-	 * We do not need to hold "ep->mtx" here because the epoll file
-	 * is on the way to be removed and no one has references to it
-	 * anymore. The only hit might come from eventpoll_release_file() but
-	 * holding "epmutex" is sufficient here.
-	 */
-	mutex_lock(&epmutex);
+	mutex_lock(&ep->mtx);
 
 	/*
 	 * Walks through the whole tree by unregistering poll callbacks.
@@ -765,26 +785,14 @@ static void ep_free(struct eventpoll *ep)
 	}
 
 	/*
-	 * Walks through the whole tree by freeing each "struct epitem". At this
-	 * point we are sure no poll callbacks will be lingering around, and also by
-	 * holding "epmutex" we can be sure that no file cleanup code will hit
-	 * us during this operation. So we can avoid the lock on "ep->lock".
-	 * We do not need to lock ep->mtx, either, we only do it to prevent
-	 * a lockdep warning.
+	 * epitems in the rb tree are freed either with EPOLL_CTL_DEL
+	 * or at the relevant file close time by eventpoll_release_file()
 	 */
-	mutex_lock(&ep->mtx);
-	while ((rbp = rb_first_cached(&ep->rbr)) != NULL) {
-		epi = rb_entry(rbp, struct epitem, rbn);
-		ep_remove(ep, epi);
-		cond_resched();
-	}
+	dispose = ep_put(ep);
 	mutex_unlock(&ep->mtx);
 
-	mutex_unlock(&epmutex);
-	mutex_destroy(&ep->mtx);
-	free_uid(ep->user);
-	wakeup_source_unregister(ep->ws);
-	kfree(ep);
+	if (dispose)
+		ep_dispose(ep);
 }
 
 static int ep_eventpoll_release(struct inode *inode, struct file *file)
@@ -905,6 +913,7 @@ void eventpoll_release_file(struct file *file)
 	struct eventpoll *ep;
 	struct epitem *epi;
 	struct hlist_node *next;
+	bool dispose;
 
 	/*
 	 * We don't want to get "file->f_lock" because it is not
@@ -912,25 +921,18 @@ void eventpoll_release_file(struct file *file)
 	 * cleanup path, and this means that no one is using this file anymore.
 	 * So, for example, epoll_ctl() cannot hit here since if we reach this
 	 * point, the file counter already went to zero and fget() would fail.
-	 * The only hit might come from ep_free() but by holding the mutex
-	 * will correctly serialize the operation. We do need to acquire
-	 * "ep->mtx" after "epmutex" because ep_remove() requires it when called
-	 * from anywhere but ep_free().
 	 *
 	 * Besides, ep_remove() acquires the lock, so we can't hold it here.
 	 */
-	mutex_lock(&epmutex);
-	if (unlikely(!file->f_ep)) {
-		mutex_unlock(&epmutex);
-		return;
-	}
 	hlist_for_each_entry_safe(epi, next, file->f_ep, fllink) {
 		ep = epi->ep;
-		mutex_lock_nested(&ep->mtx, 0);
-		ep_remove(ep, epi);
+		mutex_lock(&ep->mtx);
+		dispose = ep_remove(ep, epi);
 		mutex_unlock(&ep->mtx);
+
+		if (dispose)
+			ep_dispose(ep);
 	}
-	mutex_unlock(&epmutex);
 }
 
 static int ep_alloc(struct eventpoll **pep)
@@ -953,6 +955,7 @@ static int ep_alloc(struct eventpoll **pep)
 	ep->rbr = RB_ROOT_CACHED;
 	ep->ovflist = EP_UNACTIVE_PTR;
 	ep->user = user;
+	ep->refcount = 1;
 
 	*pep = ep;
 
@@ -1494,6 +1497,12 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 	if (tep)
 		mutex_unlock(&tep->mtx);
 
+	/*
+	 * ep_remove() calls in the later error paths can't lead to ep_dispose()
+	 * as overall will lead to no refcount changes
+	 */
+	ep_get(ep);
+
 	/* now check if we've created too many backpaths */
 	if (unlikely(full_check && reverse_path_check())) {
 		ep_remove(ep, epi);
@@ -2165,10 +2174,16 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 			error = -EEXIST;
 		break;
 	case EPOLL_CTL_DEL:
-		if (epi)
-			error = ep_remove(ep, epi);
-		else
+		if (epi) {
+			/*
+			 * The eventpoll itself is still alive: the refcount
+			 * can't go to zero here.
+			 */
+			WARN_ON_ONCE(ep_remove(ep, epi));
+			error = 0;
+		} else {
 			error = -ENOENT;
+		}
 		break;
 	case EPOLL_CTL_MOD:
 		if (epi) {
-- 
2.38.1

