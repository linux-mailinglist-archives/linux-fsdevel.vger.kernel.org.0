Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6A728281E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Oct 2020 04:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgJDCjw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Oct 2020 22:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbgJDCjd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Oct 2020 22:39:33 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D70C0613E9;
        Sat,  3 Oct 2020 19:39:33 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOtvv-00BUqn-Nk; Sun, 04 Oct 2020 02:39:31 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: [RFC PATCH 14/27] ep_scan_ready_list(): prepare to splitup
Date:   Sun,  4 Oct 2020 03:39:16 +0100
Message-Id: <20201004023929.2740074-14-viro@ZenIV.linux.org.uk>
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

take the stuff done before and after the callback into separate helpers

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/eventpoll.c | 63 +++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 36 insertions(+), 27 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index e971e3ace557..eb012fdc152e 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -561,28 +561,10 @@ static inline void ep_pm_stay_awake_rcu(struct epitem *epi)
 	rcu_read_unlock();
 }
 
-/**
- * ep_scan_ready_list - Scans the ready list in a way that makes possible for
- *                      the scan code, to call f_op->poll(). Also allows for
- *                      O(NumReady) performance.
- *
- * @ep: Pointer to the epoll private data structure.
- * @sproc: Pointer to the scan callback.
- * @priv: Private opaque data passed to the @sproc callback.
- * @depth: The current depth of recursive f_op->poll calls.
- * @ep_locked: caller already holds ep->mtx
- *
- * Returns: The same integer error code returned by the @sproc callback.
- */
-static __poll_t ep_scan_ready_list(struct eventpoll *ep,
-			      __poll_t (*sproc)(struct eventpoll *,
-					   struct list_head *, void *),
-			      void *priv, int depth, bool ep_locked)
+static void ep_start_scan(struct eventpoll *ep,
+			  int depth, bool ep_locked,
+			  struct list_head *txlist)
 {
-	__poll_t res;
-	struct epitem *epi, *nepi;
-	LIST_HEAD(txlist);
-
 	lockdep_assert_irqs_enabled();
 
 	/*
@@ -602,14 +584,16 @@ static __poll_t ep_scan_ready_list(struct eventpoll *ep,
 	 * in a lockless way.
 	 */
 	write_lock_irq(&ep->lock);
-	list_splice_init(&ep->rdllist, &txlist);
+	list_splice_init(&ep->rdllist, txlist);
 	WRITE_ONCE(ep->ovflist, NULL);
 	write_unlock_irq(&ep->lock);
+}
 
-	/*
-	 * Now call the callback function.
-	 */
-	res = (*sproc)(ep, &txlist, priv);
+static void ep_done_scan(struct eventpoll *ep,
+			 int depth, bool ep_locked,
+			 struct list_head *txlist)
+{
+	struct epitem *epi, *nepi;
 
 	write_lock_irq(&ep->lock);
 	/*
@@ -644,13 +628,38 @@ static __poll_t ep_scan_ready_list(struct eventpoll *ep,
 	/*
 	 * Quickly re-inject items left on "txlist".
 	 */
-	list_splice(&txlist, &ep->rdllist);
+	list_splice(txlist, &ep->rdllist);
 	__pm_relax(ep->ws);
 	write_unlock_irq(&ep->lock);
 
 	if (!ep_locked)
 		mutex_unlock(&ep->mtx);
+}
 
+/**
+ * ep_scan_ready_list - Scans the ready list in a way that makes possible for
+ *                      the scan code, to call f_op->poll(). Also allows for
+ *                      O(NumReady) performance.
+ *
+ * @ep: Pointer to the epoll private data structure.
+ * @sproc: Pointer to the scan callback.
+ * @priv: Private opaque data passed to the @sproc callback.
+ * @depth: The current depth of recursive f_op->poll calls.
+ * @ep_locked: caller already holds ep->mtx
+ *
+ * Returns: The same integer error code returned by the @sproc callback.
+ */
+static __poll_t ep_scan_ready_list(struct eventpoll *ep,
+			      __poll_t (*sproc)(struct eventpoll *,
+					   struct list_head *, void *),
+			      void *priv, int depth, bool ep_locked)
+{
+	__poll_t res;
+	LIST_HEAD(txlist);
+
+	ep_start_scan(ep, depth, ep_locked, &txlist);
+	res = (*sproc)(ep, &txlist, priv);
+	ep_done_scan(ep, depth, ep_locked, &txlist);
 	return res;
 }
 
-- 
2.11.0

