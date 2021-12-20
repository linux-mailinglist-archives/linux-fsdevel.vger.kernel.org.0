Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A365B47A66E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Dec 2021 09:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238186AbhLTI6o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Dec 2021 03:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234894AbhLTI6n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Dec 2021 03:58:43 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A651C06173F
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Dec 2021 00:58:43 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id v16so8685344pjn.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Dec 2021 00:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZrLB05wu75xtprEgkWCOZKZLcRJIsJQvvD7shKptZC8=;
        b=p75duGBHD+hgKaVEl9+L5IXqWpMUnqqbaTE/oyZCHx69y4q+9TfwEzSkT6+AxDMZua
         9AvQflMkkj5S9Qkw9ZSAD+Dh0v72TS4p+rZXc1DsaIySlZ8+IlGOAfBKjs4uXTFa18Mr
         RaCmkpN8pOW3zcxdid4hA5au2Mwogr+tedqOIBtfSD30eGZ+ESsT7DgZeSBg25Aowrb1
         DPhavswlObDAqkXM3G0dgy8iNjMvg5yzVw5396JoDpZFzMvxS1855wqUOtWoNy6qtVw5
         R4j7KoXEaR3A5HOnGG0b1Ea79G5dnd3iebDBhOixd2XPesajczf1TgKqH2WPImoBmE4Q
         i76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZrLB05wu75xtprEgkWCOZKZLcRJIsJQvvD7shKptZC8=;
        b=0vUIIFOyJsx2ftEAdQqEkKGxdGdf4la5qSbZa+gYSdWf9rnDoO82NC9xpD2ylLQJhi
         CuX3CC7mDVbG088X/q1UZNCjnA5chTkMiu1mifCDOIrvRon+JOxqlUvg0vOOGR1jfXl1
         ECC1lcFg7+o7TLf9z3jPZD4RL/a8/u6ZWSK7tnvTnTNuUKmbQ0laatf2ReQOvV1RMi8a
         Nvza7htwmBhmUVVvKJ4PMw43G+mWk4iA5mE+Bgg+z9fgV8aRrVQL1Hs8+XipSdGpUsjH
         wEWQ4v/kmHTU0YLIOR7lUeS6aC7VrnwqKP47LyEclO19h6YPCqTUeBZGMGuudD5oyaaq
         ping==
X-Gm-Message-State: AOAM533wbw+VIBZ2/Aw+9o00+jdUS/SAjH+JSV0GNA/cCIctNrCW4KJP
        AdQ07odZa9ONISiKKud883zKEQ==
X-Google-Smtp-Source: ABdhPJxY/dg4Nptrmuy7cfP9oqGxE6ii/4/y1M4sUYuSr+7yNONpRSggWvhJsU16nw1CXt3VUH25Qw==
X-Received: by 2002:a17:90a:2a8f:: with SMTP id j15mr27155484pjd.204.1639990722630;
        Mon, 20 Dec 2021 00:58:42 -0800 (PST)
Received: from localhost.localdomain ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id m11sm18441647pfk.27.2021.12.20.00.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 00:58:42 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        jaegeuk@kernel.org, chao@kernel.org, kari.argillander@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 08/16] xarray: use kmem_cache_alloc_lru to allocate xa_node
Date:   Mon, 20 Dec 2021 16:56:41 +0800
Message-Id: <20211220085649.8196-9-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20211220085649.8196-1-songmuchun@bytedance.com>
References: <20211220085649.8196-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The workingset will add the xa_node to the shadow_nodes list. So the
allocation of xa_node should be done by kmem_cache_alloc_lru(). Using
xas_set_lru() to pass the list_lru which we want to insert xa_node
into to set up the xa_node reclaim context correctly.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/swap.h   |  5 ++++-
 include/linux/xarray.h |  9 ++++++++-
 lib/xarray.c           | 10 +++++-----
 mm/workingset.c        |  2 +-
 4 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index d1ea44b31f19..1ae9d3473c02 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -334,9 +334,12 @@ void workingset_activation(struct folio *folio);
 
 /* Only track the nodes of mappings with shadow entries */
 void workingset_update_node(struct xa_node *node);
+extern struct list_lru shadow_nodes;
 #define mapping_set_update(xas, mapping) do {				\
-	if (!dax_mapping(mapping) && !shmem_mapping(mapping))		\
+	if (!dax_mapping(mapping) && !shmem_mapping(mapping)) {		\
 		xas_set_update(xas, workingset_update_node);		\
+		xas_set_lru(xas, &shadow_nodes);			\
+	}								\
 } while (0)
 
 /* linux/mm/page_alloc.c */
diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index a91e3d90df8a..31f3e5ef3c7b 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -1317,6 +1317,7 @@ struct xa_state {
 	struct xa_node *xa_node;
 	struct xa_node *xa_alloc;
 	xa_update_node_t xa_update;
+	struct list_lru *xa_lru;
 };
 
 /*
@@ -1336,7 +1337,8 @@ struct xa_state {
 	.xa_pad = 0,					\
 	.xa_node = XAS_RESTART,				\
 	.xa_alloc = NULL,				\
-	.xa_update = NULL				\
+	.xa_update = NULL,				\
+	.xa_lru = NULL,					\
 }
 
 /**
@@ -1613,6 +1615,11 @@ static inline void xas_set_update(struct xa_state *xas, xa_update_node_t update)
 	xas->xa_update = update;
 }
 
+static inline void xas_set_lru(struct xa_state *xas, struct list_lru *lru)
+{
+	xas->xa_lru = lru;
+}
+
 /**
  * xas_next_entry() - Advance iterator to next present entry.
  * @xas: XArray operation state.
diff --git a/lib/xarray.c b/lib/xarray.c
index f5d8f54907b4..e9b818abc823 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -302,7 +302,7 @@ bool xas_nomem(struct xa_state *xas, gfp_t gfp)
 	}
 	if (xas->xa->xa_flags & XA_FLAGS_ACCOUNT)
 		gfp |= __GFP_ACCOUNT;
-	xas->xa_alloc = kmem_cache_alloc(radix_tree_node_cachep, gfp);
+	xas->xa_alloc = kmem_cache_alloc_lru(radix_tree_node_cachep, xas->xa_lru, gfp);
 	if (!xas->xa_alloc)
 		return false;
 	xas->xa_alloc->parent = NULL;
@@ -334,10 +334,10 @@ static bool __xas_nomem(struct xa_state *xas, gfp_t gfp)
 		gfp |= __GFP_ACCOUNT;
 	if (gfpflags_allow_blocking(gfp)) {
 		xas_unlock_type(xas, lock_type);
-		xas->xa_alloc = kmem_cache_alloc(radix_tree_node_cachep, gfp);
+		xas->xa_alloc = kmem_cache_alloc_lru(radix_tree_node_cachep, xas->xa_lru, gfp);
 		xas_lock_type(xas, lock_type);
 	} else {
-		xas->xa_alloc = kmem_cache_alloc(radix_tree_node_cachep, gfp);
+		xas->xa_alloc = kmem_cache_alloc_lru(radix_tree_node_cachep, xas->xa_lru, gfp);
 	}
 	if (!xas->xa_alloc)
 		return false;
@@ -371,7 +371,7 @@ static void *xas_alloc(struct xa_state *xas, unsigned int shift)
 		if (xas->xa->xa_flags & XA_FLAGS_ACCOUNT)
 			gfp |= __GFP_ACCOUNT;
 
-		node = kmem_cache_alloc(radix_tree_node_cachep, gfp);
+		node = kmem_cache_alloc_lru(radix_tree_node_cachep, xas->xa_lru, gfp);
 		if (!node) {
 			xas_set_err(xas, -ENOMEM);
 			return NULL;
@@ -1014,7 +1014,7 @@ void xas_split_alloc(struct xa_state *xas, void *entry, unsigned int order,
 		void *sibling = NULL;
 		struct xa_node *node;
 
-		node = kmem_cache_alloc(radix_tree_node_cachep, gfp);
+		node = kmem_cache_alloc_lru(radix_tree_node_cachep, xas->xa_lru, gfp);
 		if (!node)
 			goto nomem;
 		node->array = xas->xa;
diff --git a/mm/workingset.c b/mm/workingset.c
index 8c03afe1d67c..979c7130c266 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -429,7 +429,7 @@ void workingset_activation(struct folio *folio)
  * point where they would still be useful.
  */
 
-static struct list_lru shadow_nodes;
+struct list_lru shadow_nodes;
 
 void workingset_update_node(struct xa_node *node)
 {
-- 
2.11.0

