Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAE528281A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Oct 2020 04:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgJDCjn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Oct 2020 22:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgJDCji (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Oct 2020 22:39:38 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD634C0613A8;
        Sat,  3 Oct 2020 19:39:33 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOtvw-00BUrC-Ct; Sun, 04 Oct 2020 02:39:32 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: [RFC PATCH 17/27] ep_send_events_proc(): fold into the caller
Date:   Sun,  4 Oct 2020 03:39:19 +0100
Message-Id: <20201004023929.2740074-17-viro@ZenIV.linux.org.uk>
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

... and get rid of struct ep_send_events_data - not needed anymore.
The weird way of passing the arguments in (and real return value
out - nominal return value of ep_send_events_proc() is ignored)
was due to the signature forced on ep_scan_ready_list() callbacks.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/eventpoll.c | 60 ++++++++++++++++++++--------------------------------------
 1 file changed, 20 insertions(+), 40 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 3b3a862f8014..ac996b959e94 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -233,13 +233,6 @@ struct ep_pqueue {
 	struct epitem *epi;
 };
 
-/* Used by the ep_send_events() function as callback private data */
-struct ep_send_events_data {
-	int maxevents;
-	struct epoll_event __user *events;
-	int res;
-};
-
 /*
  * Configuration options available inside /proc/sys/fs/epoll/
  */
@@ -1570,18 +1563,17 @@ static int ep_modify(struct eventpoll *ep, struct epitem *epi,
 	return 0;
 }
 
-static __poll_t ep_send_events_proc(struct eventpoll *ep, struct list_head *head,
-			       void *priv)
+static int ep_send_events(struct eventpoll *ep,
+			  struct epoll_event __user *events, int maxevents)
 {
-	struct ep_send_events_data *esed = priv;
-	__poll_t revents;
 	struct epitem *epi, *tmp;
-	struct epoll_event __user *uevent = esed->events;
-	struct wakeup_source *ws;
+	LIST_HEAD(txlist);
 	poll_table pt;
+	int res = 0;
 
 	init_poll_funcptr(&pt, NULL);
-	esed->res = 0;
+
+	ep_start_scan(ep, 0, false, &txlist);
 
 	/*
 	 * We can loop without lock because we are passed a task private list.
@@ -1590,8 +1582,11 @@ static __poll_t ep_send_events_proc(struct eventpoll *ep, struct list_head *head
 	 */
 	lockdep_assert_held(&ep->mtx);
 
-	list_for_each_entry_safe(epi, tmp, head, rdllink) {
-		if (esed->res >= esed->maxevents)
+	list_for_each_entry_safe(epi, tmp, &txlist, rdllink) {
+		struct wakeup_source *ws;
+		__poll_t revents;
+
+		if (res >= maxevents)
 			break;
 
 		/*
@@ -1622,16 +1617,16 @@ static __poll_t ep_send_events_proc(struct eventpoll *ep, struct list_head *head
 		if (!revents)
 			continue;
 
-		if (__put_user(revents, &uevent->events) ||
-		    __put_user(epi->event.data, &uevent->data)) {
-			list_add(&epi->rdllink, head);
+		if (__put_user(revents, &events->events) ||
+		    __put_user(epi->event.data, &events->data)) {
+			list_add(&epi->rdllink, &txlist);
 			ep_pm_stay_awake(epi);
-			if (!esed->res)
-				esed->res = -EFAULT;
-			return 0;
+			if (!res)
+				res = -EFAULT;
+			break;
 		}
-		esed->res++;
-		uevent++;
+		res++;
+		events++;
 		if (epi->event.events & EPOLLONESHOT)
 			epi->event.events &= EP_PRIVATE_BITS;
 		else if (!(epi->event.events & EPOLLET)) {
@@ -1650,24 +1645,9 @@ static __poll_t ep_send_events_proc(struct eventpoll *ep, struct list_head *head
 			ep_pm_stay_awake(epi);
 		}
 	}
-
-	return 0;
-}
-
-static int ep_send_events(struct eventpoll *ep,
-			  struct epoll_event __user *events, int maxevents)
-{
-	struct ep_send_events_data esed;
-	LIST_HEAD(txlist);
-
-	esed.maxevents = maxevents;
-	esed.events = events;
-
-	ep_start_scan(ep, 0, false, &txlist);
-	ep_send_events_proc(ep, &txlist, &esed);
 	ep_done_scan(ep, 0, false, &txlist);
 
-	return esed.res;
+	return res;
 }
 
 static inline struct timespec64 ep_set_mstimeout(long ms)
-- 
2.11.0

