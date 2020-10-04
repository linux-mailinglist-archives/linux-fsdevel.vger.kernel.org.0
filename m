Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3805328282E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Oct 2020 04:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgJDCk0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Oct 2020 22:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgJDCji (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Oct 2020 22:39:38 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDC7C0613AD;
        Sat,  3 Oct 2020 19:39:34 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOtvx-00BUrk-Ad; Sun, 04 Oct 2020 02:39:33 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: [RFC PATCH 22/27] fold ep_read_events_proc() into the only caller
Date:   Sun,  4 Oct 2020 03:39:24 +0100
Message-Id: <20201004023929.2740074-22-viro@ZenIV.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/eventpoll.c | 49 ++++++++++++++++++++-----------------------------
 1 file changed, 20 insertions(+), 29 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index a50b48d26c55..1efe8a1a022a 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -729,14 +729,17 @@ static int ep_eventpoll_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static __poll_t ep_read_events_proc(struct eventpoll *ep, struct list_head *head,
-			       int depth);
+static __poll_t ep_item_poll(const struct epitem *epi, poll_table *pt, int depth);
 
 static __poll_t __ep_eventpoll_poll(struct file *file, poll_table *wait, int depth)
 {
 	struct eventpoll *ep = file->private_data;
 	LIST_HEAD(txlist);
-	__poll_t res;
+	struct epitem *epi, *tmp;
+	poll_table pt;
+	__poll_t res = 0;
+
+	init_poll_funcptr(&pt, NULL);
 
 	/* Insert inside our poll wait queue */
 	poll_wait(file, &ep->poll_wait, wait);
@@ -747,7 +750,20 @@ static __poll_t __ep_eventpoll_poll(struct file *file, poll_table *wait, int dep
 	 */
 	mutex_lock_nested(&ep->mtx, depth);
 	ep_start_scan(ep, &txlist);
-	res = ep_read_events_proc(ep, &txlist, depth + 1);
+	list_for_each_entry_safe(epi, tmp, &txlist, rdllink) {
+		if (ep_item_poll(epi, &pt, depth + 1)) {
+			res = EPOLLIN | EPOLLRDNORM;
+			break;
+		} else {
+			/*
+			 * Item has been dropped into the ready list by the poll
+			 * callback, but it's not actually ready, as far as
+			 * caller requested events goes. We can remove it here.
+			 */
+			__pm_relax(ep_wakeup_source(epi));
+			list_del_init(&epi->rdllink);
+		}
+	}
 	ep_done_scan(ep, &txlist);
 	mutex_unlock(&ep->mtx);
 	return res;
@@ -772,31 +788,6 @@ static __poll_t ep_item_poll(const struct epitem *epi, poll_table *pt,
 	return res & epi->event.events;
 }
 
-static __poll_t ep_read_events_proc(struct eventpoll *ep, struct list_head *head,
-			       int depth)
-{
-	struct epitem *epi, *tmp;
-	poll_table pt;
-
-	init_poll_funcptr(&pt, NULL);
-
-	list_for_each_entry_safe(epi, tmp, head, rdllink) {
-		if (ep_item_poll(epi, &pt, depth)) {
-			return EPOLLIN | EPOLLRDNORM;
-		} else {
-			/*
-			 * Item has been dropped into the ready list by the poll
-			 * callback, but it's not actually ready, as far as
-			 * caller requested events goes. We can remove it here.
-			 */
-			__pm_relax(ep_wakeup_source(epi));
-			list_del_init(&epi->rdllink);
-		}
-	}
-
-	return 0;
-}
-
 static __poll_t ep_eventpoll_poll(struct file *file, poll_table *wait)
 {
 	return __ep_eventpoll_poll(file, wait, 0);
-- 
2.11.0

