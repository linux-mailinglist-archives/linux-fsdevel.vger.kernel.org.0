Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A165282847
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Oct 2020 04:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgJDClO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Oct 2020 22:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgJDCjb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Oct 2020 22:39:31 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D673CC0613E7;
        Sat,  3 Oct 2020 19:39:30 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOtvt-00BUpS-HI; Sun, 04 Oct 2020 02:39:29 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: [RFC PATCH 02/27] epoll: get rid of epitem->nwait
Date:   Sun,  4 Oct 2020 03:39:04 +0100
Message-Id: <20201004023929.2740074-2-viro@ZenIV.linux.org.uk>
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

we use it only to indicate allocation failures within queueing
callback back to ep_insert().  Might as well use epq.epi for that
reporting...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/eventpoll.c | 46 ++++++++++++++++++++--------------------------
 1 file changed, 20 insertions(+), 26 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index ae41868d9b35..44aca681d897 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -172,9 +172,6 @@ struct epitem {
 	/* The file descriptor information this item refers to */
 	struct epoll_filefd ffd;
 
-	/* Number of active wait queue attached to poll operations */
-	int nwait;
-
 	/* List containing poll wait queues */
 	struct eppoll_entry *pwqlist;
 
@@ -351,12 +348,6 @@ static inline struct epitem *ep_item_from_wait(wait_queue_entry_t *p)
 	return container_of(p, struct eppoll_entry, wait)->base;
 }
 
-/* Get the "struct epitem" from an epoll queue wrapper */
-static inline struct epitem *ep_item_from_epqueue(poll_table *p)
-{
-	return container_of(p, struct ep_pqueue, pt)->epi;
-}
-
 /* Initialize the poll safe wake up structure */
 static void ep_nested_calls_init(struct nested_calls *ncalls)
 {
@@ -1307,24 +1298,28 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 static void ep_ptable_queue_proc(struct file *file, wait_queue_head_t *whead,
 				 poll_table *pt)
 {
-	struct epitem *epi = ep_item_from_epqueue(pt);
+	struct ep_pqueue *epq = container_of(pt, struct ep_pqueue, pt);
+	struct epitem *epi = epq->epi;
 	struct eppoll_entry *pwq;
 
-	if (epi->nwait >= 0 && (pwq = kmem_cache_alloc(pwq_cache, GFP_KERNEL))) {
-		init_waitqueue_func_entry(&pwq->wait, ep_poll_callback);
-		pwq->whead = whead;
-		pwq->base = epi;
-		if (epi->event.events & EPOLLEXCLUSIVE)
-			add_wait_queue_exclusive(whead, &pwq->wait);
-		else
-			add_wait_queue(whead, &pwq->wait);
-		pwq->next = epi->pwqlist;
-		epi->pwqlist = pwq;
-		epi->nwait++;
-	} else {
-		/* We have to signal that an error occurred */
-		epi->nwait = -1;
+	if (unlikely(!epi))	// an earlier allocation has failed
+		return;
+
+	pwq = kmem_cache_alloc(pwq_cache, GFP_KERNEL);
+	if (unlikely(!pwq)) {
+		epq->epi = NULL;
+		return;
 	}
+
+	init_waitqueue_func_entry(&pwq->wait, ep_poll_callback);
+	pwq->whead = whead;
+	pwq->base = epi;
+	if (epi->event.events & EPOLLEXCLUSIVE)
+		add_wait_queue_exclusive(whead, &pwq->wait);
+	else
+		add_wait_queue(whead, &pwq->wait);
+	pwq->next = epi->pwqlist;
+	epi->pwqlist = pwq;
 }
 
 static void ep_rbtree_insert(struct eventpoll *ep, struct epitem *epi)
@@ -1510,7 +1505,6 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 	epi->ep = ep;
 	ep_set_ffd(&epi->ffd, tfile, fd);
 	epi->event = *event;
-	epi->nwait = 0;
 	epi->next = EP_UNACTIVE_PTR;
 	if (epi->event.events & EPOLLWAKEUP) {
 		error = ep_create_wakeup_source(epi);
@@ -1555,7 +1549,7 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 	 * high memory pressure.
 	 */
 	error = -ENOMEM;
-	if (epi->nwait < 0)
+	if (!epq.epi)
 		goto error_unregister;
 
 	/* We have to drop the new item inside our item list to keep track of it */
-- 
2.11.0

