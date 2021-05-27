Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9735C39277B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 08:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbhE0G1f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 02:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbhE0G1R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 02:27:17 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF46EC061342
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 23:25:43 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id kr9so2141750pjb.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 23:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O9BJLsBD6jksCciTZGdmyHq2qkXc8II2TIDnrT2cyiU=;
        b=FJZgs1UL1z0my49Azq2hr0n8sscr/I33Tt7ZJ7/5pTqF5PlVpBytz21l20UwTaaemz
         Cd6gjsbyJXnE+z24F+l394YMOknHJU5R6Y+0cOJDFyj5Ke5qYdZN2D1h7Bw0EIehRYXM
         jk0UzBbqZKDtPyY7z3heDw5ZjzO6v48H5oHEZEolFWJOHBodu60/IpFdEgb9/Yfs8/fS
         g+aP04+BW6pXtvUTWQTF5eC/9hij+e/aN/5dOfYQKWFX4eqOktY2ufGeFIUm7MdDPF55
         9VR3qK8PckMO5KDm2CkCvtwgNvlVKOH4hTYMiuusDXg7pQns30ASKdicpuxO1E7i65b+
         1/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O9BJLsBD6jksCciTZGdmyHq2qkXc8II2TIDnrT2cyiU=;
        b=WZ5H5UNoeFBj6FUc2oneyBoleEN0AfyJn9Sj+crtDWutpIdmeUlhxtlnOLUo2X7TMN
         cLBZHdEjsUu0Yom7GgB3hZgwUB+GPrRxbAUhLKJ6+CFFylxZbSrQzBzP0ZoG6CwmFIL4
         3h+qSkWEsreuDFStzvoFySQKoPafBdKDErU/WuHsGg7CjZ495ekRoIOPGnu1K8WxClGS
         yZr0zqe3u+WM/cQymKWELxiIyYWS0AD29AYDwlF6QyKL6kLJGS9ohOX/oMyU46xanSwg
         vZaQy6B+Ww8OdcJewHTkw/6wLY6deDze+sBY3BS8gacwIe9D3KPY4hKRfbEc43Y6zri1
         GKsw==
X-Gm-Message-State: AOAM5318NBPytL2JnNB8Wp25K0KEm22FkFDoQmAkNQW7a5YDLnltBkDO
        itOXQfFnWeP064Au3ASkmAUT8Q==
X-Google-Smtp-Source: ABdhPJyITgWwJf3ArkmGB8EQB+3oU5oRfWiZaxjGohk/rm3HWIHqMNYrh4zk1ZJe4Tz/8GzmJpP71g==
X-Received: by 2002:a17:90a:bd01:: with SMTP id y1mr7650173pjr.166.1622096743377;
        Wed, 26 May 2021 23:25:43 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id m5sm882971pgl.75.2021.05.26.23.25.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 May 2021 23:25:43 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 12/21] xarray: use kmem_cache_alloc_lru to allocate xa_node
Date:   Thu, 27 May 2021 14:21:39 +0800
Message-Id: <20210527062148.9361-13-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210527062148.9361-1-songmuchun@bytedance.com>
References: <20210527062148.9361-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The workingset will add the xa_node to the shadow_nodes list. So the
allocation of xa_node should be done by kmem_cache_alloc_lru(). The
workingset can use xas_set_lru() to pass the list_lru.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/xarray.h |  9 ++++++++-
 lib/xarray.c           | 10 +++++-----
 2 files changed, 13 insertions(+), 6 deletions(-)

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
-- 
2.11.0

