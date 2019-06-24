Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 893CF50ED3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 16:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbfFXOmq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 10:42:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:50414 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729005AbfFXOmE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:42:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1A55FAF3B;
        Mon, 24 Jun 2019 14:42:03 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Roman Penyaev <rpenyaev@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 09/14] epoll: support polling from userspace for ep_remove()
Date:   Mon, 24 Jun 2019 16:41:46 +0200
Message-Id: <20190624144151.22688-10-rpenyaev@suse.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190624144151.22688-1-rpenyaev@suse.de>
References: <20190624144151.22688-1-rpenyaev@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On ep_remove() simply mark a user item with EPOLLREMOVE if the item was
ready (i.e. has some bits set).  That will prevent further user index
entry creation on item ->bit reuse.

Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/eventpoll.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index d0c057b73ea1..df96569d3b5a 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -900,12 +900,30 @@ static __poll_t ep_scan_ready_list(struct eventpoll *ep,
 	return res;
 }
 
-static void epi_rcu_free(struct rcu_head *head)
+static void epi_rcu_free_cb(struct rcu_head *head)
 {
 	struct epitem *epi = container_of(head, struct epitem, rcu);
 	kmem_cache_free(epi_cache, epi);
 }
 
+static void uepi_rcu_free_cb(struct rcu_head *head)
+{
+	struct epitem *epi = container_of(head, struct epitem, rcu);
+	kmem_cache_free(uepi_cache, uep_item_from_epi(epi));
+}
+
+static void epi_rcu_free(struct eventpoll *ep, struct epitem *epi)
+{
+	/*
+	 * Check if `ep` is polled by user here, in this function, not
+	 * in the callback, in order not to control lifetime of the 'ep'.
+	 */
+	if (ep_polled_by_user(ep))
+		call_rcu(&epi->rcu, uepi_rcu_free_cb);
+	else
+		call_rcu(&epi->rcu, epi_rcu_free_cb);
+}
+
 static inline int ep_get_bit(struct eventpoll *ep)
 {
 	bool was_set;
@@ -1177,10 +1195,14 @@ static int ep_remove(struct eventpoll *ep, struct epitem *epi)
 
 	rb_erase_cached(&epi->rbn, &ep->rbr);
 
-	write_lock_irq(&ep->lock);
-	if (ep_is_linked(epi))
-		list_del_init(&epi->rdllink);
-	write_unlock_irq(&ep->lock);
+	if (ep_polled_by_user(ep)) {
+		ep_remove_user_item(epi);
+	} else {
+		write_lock_irq(&ep->lock);
+		if (ep_is_linked(epi))
+			list_del_init(&epi->rdllink);
+		write_unlock_irq(&ep->lock);
+	}
 
 	wakeup_source_unregister(ep_wakeup_source(epi));
 	/*
@@ -1190,7 +1212,7 @@ static int ep_remove(struct eventpoll *ep, struct epitem *epi)
 	 * ep->mtx. The rcu read side, reverse_path_check_proc(), does not make
 	 * use of the rbn field.
 	 */
-	call_rcu(&epi->rcu, epi_rcu_free);
+	epi_rcu_free(ep, epi);
 
 	atomic_long_dec(&ep->user->epoll_watches);
 
-- 
2.21.0

