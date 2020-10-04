Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5DA28282A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Oct 2020 04:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgJDCkH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Oct 2020 22:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgJDCji (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Oct 2020 22:39:38 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1753FC0613AA;
        Sat,  3 Oct 2020 19:39:34 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOtvw-00BUrP-QS; Sun, 04 Oct 2020 02:39:32 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: [RFC PATCH 19/27] ep_insert(): don't open-code ep_remove() on failure exits
Date:   Sun,  4 Oct 2020 03:39:21 +0100
Message-Id: <20201004023929.2740074-19-viro@ZenIV.linux.org.uk>
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
 fs/eventpoll.c | 51 ++++++++++++++-------------------------------------
 1 file changed, 14 insertions(+), 37 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index f9c567af1f5f..c987b61701e4 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1384,12 +1384,16 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 	epi->next = EP_UNACTIVE_PTR;
 	if (epi->event.events & EPOLLWAKEUP) {
 		error = ep_create_wakeup_source(epi);
-		if (error)
-			goto error_create_wakeup_source;
+		if (error) {
+			kmem_cache_free(epi_cache, epi);
+			return error;
+		}
 	} else {
 		RCU_INIT_POINTER(epi->ws, NULL);
 	}
 
+	atomic_long_inc(&ep->user->epoll_watches);
+
 	/* Add the current item to the list of active epoll hook for this file */
 	spin_lock(&tfile->f_lock);
 	list_add_tail_rcu(&epi->fllink, &tfile->f_ep_links);
@@ -1402,9 +1406,10 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 	ep_rbtree_insert(ep, epi);
 
 	/* now check if we've created too many backpaths */
-	error = -EINVAL;
-	if (full_check && reverse_path_check())
-		goto error_remove_epi;
+	if (unlikely(full_check && reverse_path_check())) {
+		ep_remove(ep, epi);
+		return -EINVAL;
+	}
 
 	/* Initialize the poll table using the queue callback */
 	epq.epi = epi;
@@ -1424,9 +1429,10 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 	 * install process. Namely an allocation for a wait queue failed due
 	 * high memory pressure.
 	 */
-	error = -ENOMEM;
-	if (!epq.epi)
-		goto error_unregister;
+	if (unlikely(!epq.epi)) {
+		ep_remove(ep, epi);
+		return -ENOMEM;
+	}
 
 	/* We have to drop the new item inside our item list to keep track of it */
 	write_lock_irq(&ep->lock);
@@ -1448,40 +1454,11 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 
 	write_unlock_irq(&ep->lock);
 
-	atomic_long_inc(&ep->user->epoll_watches);
-
 	/* We have to call this outside the lock */
 	if (pwake)
 		ep_poll_safewake(ep, NULL);
 
 	return 0;
-
-error_unregister:
-	ep_unregister_pollwait(ep, epi);
-error_remove_epi:
-	spin_lock(&tfile->f_lock);
-	list_del_rcu(&epi->fllink);
-	spin_unlock(&tfile->f_lock);
-
-	rb_erase_cached(&epi->rbn, &ep->rbr);
-
-	/*
-	 * We need to do this because an event could have been arrived on some
-	 * allocated wait queue. Note that we don't care about the ep->ovflist
-	 * list, since that is used/cleaned only inside a section bound by "mtx".
-	 * And ep_insert() is called with "mtx" held.
-	 */
-	write_lock_irq(&ep->lock);
-	if (ep_is_linked(epi))
-		list_del_init(&epi->rdllink);
-	write_unlock_irq(&ep->lock);
-
-	wakeup_source_unregister(ep_wakeup_source(epi));
-
-error_create_wakeup_source:
-	kmem_cache_free(epi_cache, epi);
-
-	return error;
 }
 
 /*
-- 
2.11.0

