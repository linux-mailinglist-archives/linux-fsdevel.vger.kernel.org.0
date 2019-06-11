Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2C313CFC8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2019 16:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbfFKOzq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jun 2019 10:55:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:52648 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404201AbfFKOzX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:55:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BD149ABD2;
        Tue, 11 Jun 2019 14:55:21 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Roman Penyaev <rpenyaev@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/14] epoll: support polling from userspace for ep_poll()
Date:   Tue, 11 Jun 2019 16:54:55 +0200
Message-Id: <20190611145458.9540-12-rpenyaev@suse.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190611145458.9540-1-rpenyaev@suse.de>
References: <20190611145458.9540-1-rpenyaev@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rule of thumb for epfd polled from userspace is simple: epfd has
events if ->head != ->tail, no traversing of each item is performed.

Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/eventpoll.c | 69 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 59 insertions(+), 10 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 9f0d48eb360e..e42ddf580556 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -460,6 +460,13 @@ static inline bool ep_polled_by_user(struct eventpoll *ep)
 	return !!ep->user_header;
 }
 
+static inline bool ep_uring_events_available(struct eventpoll *ep)
+{
+	return ep_polled_by_user(ep) &&
+		READ_ONCE(ep->user_header->head) !=
+		READ_ONCE(ep->user_header->tail);
+}
+
 /**
  * ep_events_available - Checks if ready events might be available.
  *
@@ -471,7 +478,8 @@ static inline bool ep_polled_by_user(struct eventpoll *ep)
 static inline int ep_events_available(struct eventpoll *ep)
 {
 	return !list_empty_careful(&ep->rdllist) ||
-		READ_ONCE(ep->ovflist) != EP_UNACTIVE_PTR;
+		READ_ONCE(ep->ovflist) != EP_UNACTIVE_PTR ||
+		ep_uring_events_available(ep);
 }
 
 #ifdef CONFIG_NET_RX_BUSY_POLL
@@ -1309,7 +1317,7 @@ static void ep_ptable_queue_proc(struct file *file, wait_queue_head_t *whead,
 static __poll_t ep_item_poll(const struct epitem *epi, poll_table *pt,
 				 int depth)
 {
-	struct eventpoll *ep;
+	struct eventpoll *ep, *tep;
 	bool locked;
 
 	pt->_key = epi->event.events;
@@ -1318,6 +1326,26 @@ static __poll_t ep_item_poll(const struct epitem *epi, poll_table *pt,
 
 	ep = epi->ffd.file->private_data;
 	poll_wait(epi->ffd.file, &ep->poll_wait, pt);
+
+	tep = epi->ffd.file->private_data;
+	if (ep_polled_by_user(tep)) {
+		/*
+		 * The behaviour differs comparing to full scan of ready
+		 * list for original epoll.  If descriptor is pollable
+		 * from userspace we don't do scan of all ready user items:
+		 * firstly because we can't do reverse search of epi by
+		 * uitem bit, secondly this is simply waste of time for
+		 * edge triggered descriptors (user code should be prepared
+		 * to deal with EAGAIN returned from read() or write() on
+		 * inserted file descriptor) and thirdly once event is put
+		 * into user index ring do not touch it from kernel, what
+		 * we do is mark it as EPOLLREMOVED on ep_remove() and
+		 * that's it.
+		 */
+		return ep_uring_events_available(tep) ?
+			EPOLLIN | EPOLLRDNORM : 0;
+	}
+
 	locked = pt && (pt->_qproc == ep_ptable_queue_proc);
 
 	return ep_scan_ready_list(epi->ffd.file->private_data,
@@ -1360,6 +1388,12 @@ static __poll_t ep_eventpoll_poll(struct file *file, poll_table *wait)
 	/* Insert inside our poll wait queue */
 	poll_wait(file, &ep->poll_wait, wait);
 
+	if (ep_polled_by_user(ep)) {
+		/* Please read detailed comments inside ep_item_poll() */
+		return ep_uring_events_available(ep) ?
+			EPOLLIN | EPOLLRDNORM : 0;
+	}
+
 	/*
 	 * Proceed to find out if wanted events are really available inside
 	 * the ready list.
@@ -2419,6 +2453,8 @@ static int ep_send_events(struct eventpoll *ep,
 {
 	struct ep_send_events_data esed;
 
+	WARN_ON(ep_polled_by_user(ep));
+
 	esed.maxevents = maxevents;
 	esed.events = events;
 
@@ -2465,6 +2501,12 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 
 	lockdep_assert_irqs_enabled();
 
+	if (ep_polled_by_user(ep)) {
+		if (ep_uring_events_available(ep))
+			/* Firstly all events from ring have to be consumed */
+			return -ESTALE;
+	}
+
 	if (timeout > 0) {
 		struct timespec64 end_time = ep_set_mstimeout(timeout);
 
@@ -2553,14 +2595,21 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 	__set_current_state(TASK_RUNNING);
 
 send_events:
-	/*
-	 * Try to transfer events to user space. In case we get 0 events and
-	 * there's still timeout left over, we go trying again in search of
-	 * more luck.
-	 */
-	if (!res && eavail &&
-	    !(res = ep_send_events(ep, events, maxevents)) && !timed_out)
-		goto fetch_events;
+	if (!res && eavail) {
+		if (!ep_polled_by_user(ep)) {
+			/*
+			 * Try to transfer events to user space. In case we get
+			 * 0 events and there's still timeout left over, we go
+			 * trying again in search of more luck.
+			 */
+			res = ep_send_events(ep, events, maxevents);
+			if (!res && !timed_out)
+				goto fetch_events;
+		} else {
+			/* User has to deal with the ring himself */
+			res = -ESTALE;
+		}
+	}
 
 	if (waiter) {
 		spin_lock_irq(&ep->wq.lock);
-- 
2.21.0

