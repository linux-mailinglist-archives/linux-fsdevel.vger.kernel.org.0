Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB5928282B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Oct 2020 04:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgJDCkG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Oct 2020 22:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgJDCji (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Oct 2020 22:39:38 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22B2C0613AE;
        Sat,  3 Oct 2020 19:39:34 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOtvx-00BUrr-Dk; Sun, 04 Oct 2020 02:39:33 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: [RFC PATCH 23/27] ep_insert(): move creation of wakeup source past the fl_ep_links insertion
Date:   Sun,  4 Oct 2020 03:39:25 +0100
Message-Id: <20201004023929.2740074-23-viro@ZenIV.linux.org.uk>
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

That's the beginning of preparations for taking f_ep_links out of struct file.
If insertion might fail, we will need a new failure exit.  Having wakeup
source creation done after that point will simplify life there; ep_remove()
can (and commonly does) live with NULL epi->ws, so it can be used for
cleanup after ep_create_wakeup_source() failure.  It can't be used before
the rbtree insertion, though, so if we are to unify all old failure exits,
we need to move that thing down.  Then we would be free to do simple
kmem_cache_free() on the failure to insert into f_ep_links - no wakeup source
to leak on that failure exit.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/eventpoll.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 1efe8a1a022a..66da645d5eb4 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1356,26 +1356,16 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 	user_watches = atomic_long_read(&ep->user->epoll_watches);
 	if (unlikely(user_watches >= max_user_watches))
 		return -ENOSPC;
-	if (!(epi = kmem_cache_alloc(epi_cache, GFP_KERNEL)))
+	if (!(epi = kmem_cache_zalloc(epi_cache, GFP_KERNEL)))
 		return -ENOMEM;
 
 	/* Item initialization follow here ... */
 	INIT_LIST_HEAD(&epi->rdllink);
 	INIT_LIST_HEAD(&epi->fllink);
-	epi->pwqlist = NULL;
 	epi->ep = ep;
 	ep_set_ffd(&epi->ffd, tfile, fd);
 	epi->event = *event;
 	epi->next = EP_UNACTIVE_PTR;
-	if (epi->event.events & EPOLLWAKEUP) {
-		error = ep_create_wakeup_source(epi);
-		if (error) {
-			kmem_cache_free(epi_cache, epi);
-			return error;
-		}
-	} else {
-		RCU_INIT_POINTER(epi->ws, NULL);
-	}
 
 	atomic_long_inc(&ep->user->epoll_watches);
 
@@ -1400,6 +1390,14 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 		return -EINVAL;
 	}
 
+	if (epi->event.events & EPOLLWAKEUP) {
+		error = ep_create_wakeup_source(epi);
+		if (error) {
+			ep_remove(ep, epi);
+			return error;
+		}
+	}
+
 	/* Initialize the poll table using the queue callback */
 	epq.epi = epi;
 	init_poll_funcptr(&epq.pt, ep_ptable_queue_proc);
-- 
2.11.0

