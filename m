Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6349282814
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Oct 2020 04:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgJDCjc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Oct 2020 22:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgJDCjb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Oct 2020 22:39:31 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CA2C0613E7;
        Sat,  3 Oct 2020 19:39:31 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOtvt-00BUpf-Pb; Sun, 04 Oct 2020 02:39:29 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: [RFC PATCH 04/27] untangling ep_call_nested(): it's all serialized on epmutex.
Date:   Sun,  4 Oct 2020 03:39:06 +0100
Message-Id: <20201004023929.2740074-4-viro@ZenIV.linux.org.uk>
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

IOW,
	* no locking is needed to protect the list
	* the list is actually a stack
	* no need to check ->ctx
	* it can bloody well be a static 5-element array - nobody is
going to be accessing it in parallel.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/eventpoll.c | 80 ++++++++--------------------------------------------------
 1 file changed, 11 insertions(+), 69 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index ef73d71a5dc8..43aecae0935c 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -109,25 +109,6 @@ struct epoll_filefd {
 	int fd;
 } __packed;
 
-/*
- * Structure used to track possible nested calls, for too deep recursions
- * and loop cycles.
- */
-struct nested_call_node {
-	struct list_head llink;
-	void *cookie;
-	void *ctx;
-};
-
-/*
- * This structure is used as collector for nested calls, to check for
- * maximum recursion dept and loop cycles.
- */
-struct nested_calls {
-	struct list_head tasks_call_list;
-	spinlock_t lock;
-};
-
 /* Wait structure used by the poll hooks */
 struct eppoll_entry {
 	/* List header used to link this structure to the "struct epitem" */
@@ -273,7 +254,8 @@ static DEFINE_MUTEX(epmutex);
 static u64 loop_check_gen = 0;
 
 /* Used to check for epoll file descriptor inclusion loops */
-static struct nested_calls poll_loop_ncalls;
+static void *cookies[EP_MAX_NESTS + 1];
+static int nesting;
 
 /* Slab cache used to allocate "struct epitem" */
 static struct kmem_cache *epi_cache __read_mostly;
@@ -348,13 +330,6 @@ static inline struct epitem *ep_item_from_wait(wait_queue_entry_t *p)
 	return container_of(p, struct eppoll_entry, wait)->base;
 }
 
-/* Initialize the poll safe wake up structure */
-static void ep_nested_calls_init(struct nested_calls *ncalls)
-{
-	INIT_LIST_HEAD(&ncalls->tasks_call_list);
-	spin_lock_init(&ncalls->lock);
-}
-
 /**
  * ep_events_available - Checks if ready events might be available.
  *
@@ -465,47 +440,20 @@ static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
 static int ep_call_nested(int (*nproc)(void *, void *, int), void *priv,
 			  void *cookie)
 {
-	int error, call_nests = 0;
-	unsigned long flags;
-	struct nested_calls *ncalls = &poll_loop_ncalls;
-	struct list_head *lsthead = &ncalls->tasks_call_list;
-	struct nested_call_node *tncur;
-	struct nested_call_node tnode;
+	int error, i;
 
-	spin_lock_irqsave(&ncalls->lock, flags);
+	if (nesting > EP_MAX_NESTS) /* too deep nesting */
+		return -1;
 
-	/*
-	 * Try to see if the current task is already inside this wakeup call.
-	 * We use a list here, since the population inside this set is always
-	 * very much limited.
-	 */
-	list_for_each_entry(tncur, lsthead, llink) {
-		if (tncur->ctx == current &&
-		    (tncur->cookie == cookie || ++call_nests > EP_MAX_NESTS)) {
-			/*
-			 * Ops ... loop detected or maximum nest level reached.
-			 * We abort this wake by breaking the cycle itself.
-			 */
-			error = -1;
-			goto out_unlock;
-		}
+	for (i = 0; i < nesting; i++) {
+		if (cookies[i] == cookie) /* loop detected */
+			return -1;
 	}
-
-	/* Add the current task and cookie to the list */
-	tnode.ctx = current;
-	tnode.cookie = cookie;
-	list_add(&tnode.llink, lsthead);
-
-	spin_unlock_irqrestore(&ncalls->lock, flags);
+	cookies[nesting++] = cookie;
 
 	/* Call the nested function */
-	error = (*nproc)(priv, cookie, call_nests);
-
-	/* Remove the current task from the list */
-	spin_lock_irqsave(&ncalls->lock, flags);
-	list_del(&tnode.llink);
-out_unlock:
-	spin_unlock_irqrestore(&ncalls->lock, flags);
+	error = (*nproc)(priv, cookie, nesting - 1);
+	nesting--;
 
 	return error;
 }
@@ -2380,12 +2328,6 @@ static int __init eventpoll_init(void)
 	BUG_ON(max_user_watches < 0);
 
 	/*
-	 * Initialize the structure used to perform epoll file descriptor
-	 * inclusion loops checks.
-	 */
-	ep_nested_calls_init(&poll_loop_ncalls);
-
-	/*
 	 * We can have many thousands of epitems, so prevent this from
 	 * using an extra cache line on 64-bit (and smaller) CPUs
 	 */
-- 
2.11.0

