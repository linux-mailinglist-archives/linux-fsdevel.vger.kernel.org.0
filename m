Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5444728283B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Oct 2020 04:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgJDCkm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Oct 2020 22:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgJDCjd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Oct 2020 22:39:33 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA953C0613E7;
        Sat,  3 Oct 2020 19:39:32 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOtvv-00BUqZ-DY; Sun, 04 Oct 2020 02:39:31 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: [RFC PATCH 12/27] get rid of ep_push_nested()
Date:   Sun,  4 Oct 2020 03:39:14 +0100
Message-Id: <20201004023929.2740074-12-viro@ZenIV.linux.org.uk>
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

The only remaining user is loop checking.  But there we only need
to check that we have not walked into the epoll we are inserting
into - we are adding an edge to acyclic graph, so any loop being
created will have to pass through the source of that edge.

So we don't need that array of cookies - we have only one eventpoll
to watch out for.  RIP ep_push_nested(), along with the cookies
array.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/eventpoll.c | 29 ++++-------------------------
 1 file changed, 4 insertions(+), 25 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 9edea3933790..6b1990b8b9a0 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -254,8 +254,7 @@ static DEFINE_MUTEX(epmutex);
 static u64 loop_check_gen = 0;
 
 /* Used to check for epoll file descriptor inclusion loops */
-static void *cookies[EP_MAX_NESTS + 1];
-static int nesting;
+static struct eventpoll *inserting_into;
 
 /* Slab cache used to allocate "struct epitem" */
 static struct kmem_cache *epi_cache __read_mostly;
@@ -424,21 +423,6 @@ static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
 
 #endif /* CONFIG_NET_RX_BUSY_POLL */
 
-static bool ep_push_nested(void *cookie)
-{
-	int i;
-
-	if (nesting > EP_MAX_NESTS) /* too deep nesting */
-		return false;
-
-	for (i = 0; i < nesting; i++) {
-		if (cookies[i] == cookie) /* loop detected */
-			return false;
-	}
-	cookies[nesting++] = cookie;
-	return true;
-}
-
 /*
  * As described in commit 0ccf831cb lockdep: annotate epoll
  * the use of wait queues used by epoll is done in a very controlled
@@ -1885,12 +1869,11 @@ static int ep_loop_check_proc(void *priv, void *cookie, int depth)
 			ep_tovisit = epi->ffd.file->private_data;
 			if (ep_tovisit->gen == loop_check_gen)
 				continue;
-			if (!ep_push_nested(ep_tovisit)) {
+			if (ep_tovisit == inserting_into || depth > EP_MAX_NESTS) {
 				error = -1;
 			} else {
 				error = ep_loop_check_proc(epi->ffd.file, ep_tovisit,
 						   depth + 1);
-				nesting--;
 			}
 			if (error != 0)
 				break;
@@ -1928,12 +1911,8 @@ static int ep_loop_check_proc(void *priv, void *cookie, int depth)
  */
 static int ep_loop_check(struct eventpoll *ep, struct file *file)
 {
-	int err;
-
-	ep_push_nested(ep); // can't fail
-	err = ep_loop_check_proc(file, ep, 0);
-	nesting--;
-	return err;
+	inserting_into = ep;
+	return ep_loop_check_proc(file, ep, 0);
 }
 
 static void clear_tfile_check_list(void)
-- 
2.11.0

