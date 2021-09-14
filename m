Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456CE40A86A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 09:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237359AbhINHqq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 03:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237513AbhINHqD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:46:03 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2494C061198
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:41:04 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id v19so5572041pjh.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O9BJLsBD6jksCciTZGdmyHq2qkXc8II2TIDnrT2cyiU=;
        b=cxJV9i43g6uZ64FMZlPy6vGws06VDwvTYOU9J60k2oXFzhujZG9VoAPuhPBT9r/YiN
         Ab4AAog0W/jtZekEXv66wyjDw/oUvI6mkO/SwrMoxubzvfuSs5P3/mKXw5Ff1Qv1lf5e
         wGbXHU8HJ++y2FEg8o0rWeAje5ppyGGqA+8+Qj7gMUt8/QY/Twi8JOWRYK231oLK0Dbr
         6UC70hV6iVuq0zR8hkLYicw2UTucdi71woBs/u4D5EMK5j2JkEiT2CIcRJNdGWq1OJgm
         wdfAiWYT1P8R0LwJqfenct+YSLo6jk7+r2UgPIqEnNhykvt01imNPXAoq1BZ5CYBeLac
         2otg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O9BJLsBD6jksCciTZGdmyHq2qkXc8II2TIDnrT2cyiU=;
        b=choZXmRisSHHCBjgEwsjiZx8Tc41/wWCrxJLlNwjIfe+nMaIwHX/1A1DEExk104G+4
         eGQEhxg2QwCBAmM4WzB4K02uYIbIKRFtTaON0yDPChokRcgB5G6+gMQmdlJeDdwKJz03
         /D1CJbuxFgD37y63LlM9Z0mqBaAvrfyONgMPwjSiPr4MeFC4y8xjm3/IGigNKb9ZiAS0
         LbKYUpNyIgjWTl+jnJihPADkGh5DtfKhYuIVGCMLfQSv3R04MpiLiNom97dohR6yD+Mz
         0sfC45OAmolSe/SjTVa9oUMJHsopqloyLQ8l2J4EFufYkM44k3QC3GisKo+j1julZRbz
         UWnQ==
X-Gm-Message-State: AOAM532wMqZg1LNFtSRJuNcXzKQ9YO31OhH3epZVA8PcEHzCQyFcCyzp
        amVaxmOusgTl8t7NqAbWGUor1Q==
X-Google-Smtp-Source: ABdhPJwYxpqxp3oj2dLcwakc4I2z7loWq7/YRxBwPe8CJLXtMsP9qjDSPfIdzINHdcZRHHPu0VRRwA==
X-Received: by 2002:a17:90b:3890:: with SMTP id mu16mr605394pjb.78.1631605264454;
        Tue, 14 Sep 2021 00:41:04 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.40.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:41:04 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 68/76] xarray: use kmem_cache_alloc_lru to allocate xa_node
Date:   Tue, 14 Sep 2021 15:29:30 +0800
Message-Id: <20210914072938.6440-69-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210914072938.6440-1-songmuchun@bytedance.com>
References: <20210914072938.6440-1-songmuchun@bytedance.com>
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

