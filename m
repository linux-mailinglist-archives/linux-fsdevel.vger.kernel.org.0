Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEE6282832
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Oct 2020 04:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgJDCk1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Oct 2020 22:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbgJDCji (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Oct 2020 22:39:38 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451ADC0613AB;
        Sat,  3 Oct 2020 19:39:34 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOtvw-00BUrW-UO; Sun, 04 Oct 2020 02:39:32 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: [RFC PATCH 20/27] ep_insert(): we only need tep->mtx around the insertion itself
Date:   Sun,  4 Oct 2020 03:39:22 +0100
Message-Id: <20201004023929.2740074-20-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201004023929.2740074-1-viro@ZenIV.linux.org.uk>
References: <20201004023608.GM3421308@ZenIV.linux.org.uk>
 <20201004023929.2740074-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

We do need ep->mtx (and we are holding it all along), but that's
the lock on the epoll we are inserting into; locking of the
epoll being inserted is not needed for most of that work -
as the matter of fact, we only need it to provide barriers
for the fastpath check (for now).

Move taking and releasing it into ep_insert().  The caller
(do_epoll_ctl()) doesn't need to bother with that at all.
Moreover, that way we kill the kludge in ep_item_poll() - now
it's always called with tep unlocked.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/eventpoll.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index c987b61701e4..39947b71f7af 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -731,8 +731,6 @@ static int ep_eventpoll_release(struct inode *inode, struct file *file)
 
 static __poll_t ep_read_events_proc(struct eventpoll *ep, struct list_head *head,
 			       int depth);
-static void ep_ptable_queue_proc(struct file *file, wait_queue_head_t *whead,
-				 poll_table *pt);
 
 /*
  * Differs from ep_eventpoll_poll() in that internal callers already have
@@ -745,7 +743,6 @@ static __poll_t ep_item_poll(const struct epitem *epi, poll_table *pt,
 	struct eventpoll *ep;
 	LIST_HEAD(txlist);
 	__poll_t res;
-	bool locked;
 
 	pt->_key = epi->event.events;
 	if (!is_file_epoll(epi->ffd.file))
@@ -754,15 +751,11 @@ static __poll_t ep_item_poll(const struct epitem *epi, poll_table *pt,
 	ep = epi->ffd.file->private_data;
 	poll_wait(epi->ffd.file, &ep->poll_wait, pt);
 
-	// kludge: ep_insert() calls us with ep->mtx already locked
-	locked = pt && (pt->_qproc == ep_ptable_queue_proc);
-	if (!locked)
-		mutex_lock_nested(&ep->mtx, depth);
+	mutex_lock_nested(&ep->mtx, depth);
 	ep_start_scan(ep, &txlist);
 	res = ep_read_events_proc(ep, &txlist, depth + 1);
 	ep_done_scan(ep, &txlist);
-	if (!locked)
-		mutex_unlock(&ep->mtx);
+	mutex_unlock(&ep->mtx);
 	return res & epi->event.events;
 }
 
@@ -1365,6 +1358,10 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 	long user_watches;
 	struct epitem *epi;
 	struct ep_pqueue epq;
+	struct eventpoll *tep = NULL;
+
+	if (is_file_epoll(tfile))
+		tep = tfile->private_data;
 
 	lockdep_assert_irqs_enabled();
 
@@ -1394,6 +1391,8 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 
 	atomic_long_inc(&ep->user->epoll_watches);
 
+	if (tep)
+		mutex_lock(&tep->mtx);
 	/* Add the current item to the list of active epoll hook for this file */
 	spin_lock(&tfile->f_lock);
 	list_add_tail_rcu(&epi->fllink, &tfile->f_ep_links);
@@ -1404,6 +1403,8 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 	 * protected by "mtx", and ep_insert() is called with "mtx" held.
 	 */
 	ep_rbtree_insert(ep, epi);
+	if (tep)
+		mutex_unlock(&tep->mtx);
 
 	/* now check if we've created too many backpaths */
 	if (unlikely(full_check && reverse_path_check())) {
@@ -2034,13 +2035,6 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 			error = epoll_mutex_lock(&ep->mtx, 0, nonblock);
 			if (error)
 				goto error_tgt_fput;
-			if (is_file_epoll(tf.file)) {
-				error = epoll_mutex_lock(&tep->mtx, 1, nonblock);
-				if (error) {
-					mutex_unlock(&ep->mtx);
-					goto error_tgt_fput;
-				}
-			}
 		}
 	}
 
@@ -2076,8 +2070,6 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 			error = -ENOENT;
 		break;
 	}
-	if (tep != NULL)
-		mutex_unlock(&tep->mtx);
 	mutex_unlock(&ep->mtx);
 
 error_tgt_fput:
-- 
2.11.0

