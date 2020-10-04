Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63965282821
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Oct 2020 04:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgJDCjw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Oct 2020 22:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgJDCjd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Oct 2020 22:39:33 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658B5C0613A6;
        Sat,  3 Oct 2020 19:39:33 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOtvv-00BUqu-TM; Sun, 04 Oct 2020 02:39:31 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: [RFC PATCH 15/27] lift the calls of ep_read_events_proc() into the callers
Date:   Sun,  4 Oct 2020 03:39:17 +0100
Message-Id: <20201004023929.2740074-15-viro@ZenIV.linux.org.uk>
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

Expand the calls of ep_scan_ready_list() that get ep_read_events_proc().
As a side benefit we can pass depth to ep_read_events_proc() by value
and not by address - the latter used to be forced by the signature
expected from ep_scan_ready_list() callback.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/eventpoll.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index eb012fdc152e..9b9e29e0c85f 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -774,7 +774,7 @@ static int ep_eventpoll_release(struct inode *inode, struct file *file)
 }
 
 static __poll_t ep_read_events_proc(struct eventpoll *ep, struct list_head *head,
-			       void *priv);
+			       int depth);
 static void ep_ptable_queue_proc(struct file *file, wait_queue_head_t *whead,
 				 poll_table *pt);
 
@@ -787,6 +787,8 @@ static __poll_t ep_item_poll(const struct epitem *epi, poll_table *pt,
 				 int depth)
 {
 	struct eventpoll *ep;
+	LIST_HEAD(txlist);
+	__poll_t res;
 	bool locked;
 
 	pt->_key = epi->event.events;
@@ -797,20 +799,19 @@ static __poll_t ep_item_poll(const struct epitem *epi, poll_table *pt,
 	poll_wait(epi->ffd.file, &ep->poll_wait, pt);
 	locked = pt && (pt->_qproc == ep_ptable_queue_proc);
 
-	return ep_scan_ready_list(epi->ffd.file->private_data,
-				  ep_read_events_proc, &depth, depth,
-				  locked) & epi->event.events;
+	ep_start_scan(ep, depth, locked, &txlist);
+	res = ep_read_events_proc(ep, &txlist, depth + 1);
+	ep_done_scan(ep, depth, locked, &txlist);
+	return res & epi->event.events;
 }
 
 static __poll_t ep_read_events_proc(struct eventpoll *ep, struct list_head *head,
-			       void *priv)
+			       int depth)
 {
 	struct epitem *epi, *tmp;
 	poll_table pt;
-	int depth = *(int *)priv;
 
 	init_poll_funcptr(&pt, NULL);
-	depth++;
 
 	list_for_each_entry_safe(epi, tmp, head, rdllink) {
 		if (ep_item_poll(epi, &pt, depth)) {
@@ -832,7 +833,8 @@ static __poll_t ep_read_events_proc(struct eventpoll *ep, struct list_head *head
 static __poll_t ep_eventpoll_poll(struct file *file, poll_table *wait)
 {
 	struct eventpoll *ep = file->private_data;
-	int depth = 0;
+	LIST_HEAD(txlist);
+	__poll_t res;
 
 	/* Insert inside our poll wait queue */
 	poll_wait(file, &ep->poll_wait, wait);
@@ -841,8 +843,10 @@ static __poll_t ep_eventpoll_poll(struct file *file, poll_table *wait)
 	 * Proceed to find out if wanted events are really available inside
 	 * the ready list.
 	 */
-	return ep_scan_ready_list(ep, ep_read_events_proc,
-				  &depth, depth, false);
+	ep_start_scan(ep, 0, false, &txlist);
+	res = ep_read_events_proc(ep, &txlist, 1);
+	ep_done_scan(ep, 0, false, &txlist);
+	return res;
 }
 
 #ifdef CONFIG_PROC_FS
-- 
2.11.0

