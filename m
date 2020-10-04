Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94ED328281D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Oct 2020 04:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgJDCjn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Oct 2020 22:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgJDCji (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Oct 2020 22:39:38 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF31CC0613A9;
        Sat,  3 Oct 2020 19:39:33 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOtvw-00BUrI-Hq; Sun, 04 Oct 2020 02:39:32 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: [RFC PATCH 18/27] lift locking/unlocking ep->mtx out of ep_{start,done}_scan()
Date:   Sun,  4 Oct 2020 03:39:20 +0100
Message-Id: <20201004023929.2740074-18-viro@ZenIV.linux.org.uk>
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

get rid of depth/ep_locked arguments there and document
the kludge in ep_item_poll() that has lead to ep_locked existence in
the first place

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/eventpoll.c | 57 ++++++++++++++++++++++++++-------------------------------
 1 file changed, 26 insertions(+), 31 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index ac996b959e94..f9c567af1f5f 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -554,20 +554,13 @@ static inline void ep_pm_stay_awake_rcu(struct epitem *epi)
 	rcu_read_unlock();
 }
 
-static void ep_start_scan(struct eventpoll *ep,
-			  int depth, bool ep_locked,
-			  struct list_head *txlist)
-{
-	lockdep_assert_irqs_enabled();
-
-	/*
-	 * We need to lock this because we could be hit by
-	 * eventpoll_release_file() and epoll_ctl().
-	 */
-
-	if (!ep_locked)
-		mutex_lock_nested(&ep->mtx, depth);
 
+/*
+ * ep->mutex needs to be held because we could be hit by
+ * eventpoll_release_file() and epoll_ctl().
+ */
+static void ep_start_scan(struct eventpoll *ep, struct list_head *txlist)
+{
 	/*
 	 * Steal the ready list, and re-init the original one to the
 	 * empty list. Also, set ep->ovflist to NULL so that events
@@ -576,6 +569,7 @@ static void ep_start_scan(struct eventpoll *ep,
 	 * because we want the "sproc" callback to be able to do it
 	 * in a lockless way.
 	 */
+	lockdep_assert_irqs_enabled();
 	write_lock_irq(&ep->lock);
 	list_splice_init(&ep->rdllist, txlist);
 	WRITE_ONCE(ep->ovflist, NULL);
@@ -583,7 +577,6 @@ static void ep_start_scan(struct eventpoll *ep,
 }
 
 static void ep_done_scan(struct eventpoll *ep,
-			 int depth, bool ep_locked,
 			 struct list_head *txlist)
 {
 	struct epitem *epi, *nepi;
@@ -624,9 +617,6 @@ static void ep_done_scan(struct eventpoll *ep,
 	list_splice(txlist, &ep->rdllist);
 	__pm_relax(ep->ws);
 	write_unlock_irq(&ep->lock);
-
-	if (!ep_locked)
-		mutex_unlock(&ep->mtx);
 }
 
 static void epi_rcu_free(struct rcu_head *head)
@@ -763,11 +753,16 @@ static __poll_t ep_item_poll(const struct epitem *epi, poll_table *pt,
 
 	ep = epi->ffd.file->private_data;
 	poll_wait(epi->ffd.file, &ep->poll_wait, pt);
-	locked = pt && (pt->_qproc == ep_ptable_queue_proc);
 
-	ep_start_scan(ep, depth, locked, &txlist);
+	// kludge: ep_insert() calls us with ep->mtx already locked
+	locked = pt && (pt->_qproc == ep_ptable_queue_proc);
+	if (!locked)
+		mutex_lock_nested(&ep->mtx, depth);
+	ep_start_scan(ep, &txlist);
 	res = ep_read_events_proc(ep, &txlist, depth + 1);
-	ep_done_scan(ep, depth, locked, &txlist);
+	ep_done_scan(ep, &txlist);
+	if (!locked)
+		mutex_unlock(&ep->mtx);
 	return res & epi->event.events;
 }
 
@@ -809,9 +804,11 @@ static __poll_t ep_eventpoll_poll(struct file *file, poll_table *wait)
 	 * Proceed to find out if wanted events are really available inside
 	 * the ready list.
 	 */
-	ep_start_scan(ep, 0, false, &txlist);
+	mutex_lock(&ep->mtx);
+	ep_start_scan(ep, &txlist);
 	res = ep_read_events_proc(ep, &txlist, 1);
-	ep_done_scan(ep, 0, false, &txlist);
+	ep_done_scan(ep, &txlist);
+	mutex_unlock(&ep->mtx);
 	return res;
 }
 
@@ -1573,15 +1570,13 @@ static int ep_send_events(struct eventpoll *ep,
 
 	init_poll_funcptr(&pt, NULL);
 
-	ep_start_scan(ep, 0, false, &txlist);
+	mutex_lock(&ep->mtx);
+	ep_start_scan(ep, &txlist);
 
 	/*
 	 * We can loop without lock because we are passed a task private list.
-	 * Items cannot vanish during the loop because ep_scan_ready_list() is
-	 * holding "mtx" during this call.
+	 * Items cannot vanish during the loop we are holding ep->mtx.
 	 */
-	lockdep_assert_held(&ep->mtx);
-
 	list_for_each_entry_safe(epi, tmp, &txlist, rdllink) {
 		struct wakeup_source *ws;
 		__poll_t revents;
@@ -1609,9 +1604,8 @@ static int ep_send_events(struct eventpoll *ep,
 
 		/*
 		 * If the event mask intersect the caller-requested one,
-		 * deliver the event to userspace. Again, ep_scan_ready_list()
-		 * is holding ep->mtx, so no operations coming from userspace
-		 * can change the item.
+		 * deliver the event to userspace. Again, we are holding ep->mtx,
+		 * so no operations coming from userspace can change the item.
 		 */
 		revents = ep_item_poll(epi, &pt, 1);
 		if (!revents)
@@ -1645,7 +1639,8 @@ static int ep_send_events(struct eventpoll *ep,
 			ep_pm_stay_awake(epi);
 		}
 	}
-	ep_done_scan(ep, 0, false, &txlist);
+	ep_done_scan(ep, &txlist);
+	mutex_unlock(&ep->mtx);
 
 	return res;
 }
-- 
2.11.0

