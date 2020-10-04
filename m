Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7726282837
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Oct 2020 04:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgJDCkn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Oct 2020 22:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgJDCjd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Oct 2020 22:39:33 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BF5C0613A7;
        Sat,  3 Oct 2020 19:39:33 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOtvw-00BUr2-80; Sun, 04 Oct 2020 02:39:32 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: [RFC PATCH 16/27] lift the calls of ep_send_events_proc() into the callers
Date:   Sun,  4 Oct 2020 03:39:18 +0100
Message-Id: <20201004023929.2740074-16-viro@ZenIV.linux.org.uk>
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

... and kill ep_scan_ready_list()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/eventpoll.c | 33 +++++----------------------------
 1 file changed, 5 insertions(+), 28 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 9b9e29e0c85f..3b3a862f8014 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -636,33 +636,6 @@ static void ep_done_scan(struct eventpoll *ep,
 		mutex_unlock(&ep->mtx);
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
-{
-	__poll_t res;
-	LIST_HEAD(txlist);
-
-	ep_start_scan(ep, depth, ep_locked, &txlist);
-	res = (*sproc)(ep, &txlist, priv);
-	ep_done_scan(ep, depth, ep_locked, &txlist);
-	return res;
-}
-
 static void epi_rcu_free(struct rcu_head *head)
 {
 	struct epitem *epi = container_of(head, struct epitem, rcu);
@@ -1685,11 +1658,15 @@ static int ep_send_events(struct eventpoll *ep,
 			  struct epoll_event __user *events, int maxevents)
 {
 	struct ep_send_events_data esed;
+	LIST_HEAD(txlist);
 
 	esed.maxevents = maxevents;
 	esed.events = events;
 
-	ep_scan_ready_list(ep, ep_send_events_proc, &esed, 0, false);
+	ep_start_scan(ep, 0, false, &txlist);
+	ep_send_events_proc(ep, &txlist, &esed);
+	ep_done_scan(ep, 0, false, &txlist);
+
 	return esed.res;
 }
 
-- 
2.11.0

