Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A68B28283F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Oct 2020 04:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgJDCjb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Oct 2020 22:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgJDCja (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Oct 2020 22:39:30 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB78C0613D0;
        Sat,  3 Oct 2020 19:39:30 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOtvt-00BUpP-Bv; Sun, 04 Oct 2020 02:39:29 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: [RFC PATCH 01/27] epoll: switch epitem->pwqlist to single-linked list
Date:   Sun,  4 Oct 2020 03:39:03 +0100
Message-Id: <20201004023929.2740074-1-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201004023608.GM3421308@ZenIV.linux.org.uk>
References: <20201004023608.GM3421308@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

We only traverse it once to destroy all associated eppoll_entry at
epitem destruction time.  The order of traversal is irrelevant there.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/eventpoll.c | 51 +++++++++++++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 4df61129566d..ae41868d9b35 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -128,6 +128,24 @@ struct nested_calls {
 	spinlock_t lock;
 };
 
+/* Wait structure used by the poll hooks */
+struct eppoll_entry {
+	/* List header used to link this structure to the "struct epitem" */
+	struct eppoll_entry *next;
+
+	/* The "base" pointer is set to the container "struct epitem" */
+	struct epitem *base;
+
+	/*
+	 * Wait queue item that will be linked to the target file wait
+	 * queue head.
+	 */
+	wait_queue_entry_t wait;
+
+	/* The wait queue head that linked the "wait" wait queue item */
+	wait_queue_head_t *whead;
+};
+
 /*
  * Each file descriptor added to the eventpoll interface will
  * have an entry of this type linked to the "rbr" RB tree.
@@ -158,7 +176,7 @@ struct epitem {
 	int nwait;
 
 	/* List containing poll wait queues */
-	struct list_head pwqlist;
+	struct eppoll_entry *pwqlist;
 
 	/* The "container" of this item */
 	struct eventpoll *ep;
@@ -231,24 +249,6 @@ struct eventpoll {
 #endif
 };
 
-/* Wait structure used by the poll hooks */
-struct eppoll_entry {
-	/* List header used to link this structure to the "struct epitem" */
-	struct list_head llink;
-
-	/* The "base" pointer is set to the container "struct epitem" */
-	struct epitem *base;
-
-	/*
-	 * Wait queue item that will be linked to the target file wait
-	 * queue head.
-	 */
-	wait_queue_entry_t wait;
-
-	/* The wait queue head that linked the "wait" wait queue item */
-	wait_queue_head_t *whead;
-};
-
 /* Wrapper struct used by poll queueing */
 struct ep_pqueue {
 	poll_table pt;
@@ -617,13 +617,11 @@ static void ep_remove_wait_queue(struct eppoll_entry *pwq)
  */
 static void ep_unregister_pollwait(struct eventpoll *ep, struct epitem *epi)
 {
-	struct list_head *lsthead = &epi->pwqlist;
+	struct eppoll_entry **p = &epi->pwqlist;
 	struct eppoll_entry *pwq;
 
-	while (!list_empty(lsthead)) {
-		pwq = list_first_entry(lsthead, struct eppoll_entry, llink);
-
-		list_del(&pwq->llink);
+	while ((pwq = *p) != NULL) {
+		*p = pwq->next;
 		ep_remove_wait_queue(pwq);
 		kmem_cache_free(pwq_cache, pwq);
 	}
@@ -1320,7 +1318,8 @@ static void ep_ptable_queue_proc(struct file *file, wait_queue_head_t *whead,
 			add_wait_queue_exclusive(whead, &pwq->wait);
 		else
 			add_wait_queue(whead, &pwq->wait);
-		list_add_tail(&pwq->llink, &epi->pwqlist);
+		pwq->next = epi->pwqlist;
+		epi->pwqlist = pwq;
 		epi->nwait++;
 	} else {
 		/* We have to signal that an error occurred */
@@ -1507,7 +1506,7 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 	/* Item initialization follow here ... */
 	INIT_LIST_HEAD(&epi->rdllink);
 	INIT_LIST_HEAD(&epi->fllink);
-	INIT_LIST_HEAD(&epi->pwqlist);
+	epi->pwqlist = NULL;
 	epi->ep = ep;
 	ep_set_ffd(&epi->ffd, tfile, fd);
 	epi->event = *event;
-- 
2.11.0

