Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F260B4C6C32
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 13:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236340AbiB1MYK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 07:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236313AbiB1MXz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:23:55 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB327033D
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 04:23:07 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id c9so10599788pll.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 04:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W7N2ct9tvwpvEjrUOuEEAnTDqNZXNpAiEvvqkroYr+g=;
        b=KkiGb7Pdw1ydl11Dl3qV5P0aGMZh9PcwBwSXXbMOqJ1IVhP7TYoPH6Ir6xqn+/3aEp
         DuSqdDLytjLHGFKPt03t23ihHcjWxTFYlX2aXol49Yvjgx8yjokCxShrlEPO+/3ChyLP
         LEGnEl20CzF078t+1B0Oi9vuk9MfZ2LQM5dTW5ZQhfciSvzOuoehO+IfG8q4UukWi2nX
         QEEOzgbeN82NGwiBEM8hSi2o0Y3QBlj5zyBxklZMRXDi4b7iQLkj/LGMu+32vEKc7aOu
         syIJw5XXba+Zd5ZGMjkZP/Vna94ZPQ0ORPgYsOm+I9TBx9PcUhpF+GqyJY7i1XHl0Ida
         FLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W7N2ct9tvwpvEjrUOuEEAnTDqNZXNpAiEvvqkroYr+g=;
        b=uJZ//ya9sOEB3mBLDOp8ef+X2iM/Ssz1OpC2SfRmAz9468xtEOeShIpHW07PHThZXs
         4sty6kkZFkNWpQZ/tq9mZqy1520xCA77Fta0g8yPcZRU98p6m15G79P7oFpnTk7NFbJ+
         k+saesoVrJJKp+y23PR0RBwsr6N+aPUpKm94yxZeKqkNna4qYohMov3fpG0MFK+/ifrc
         N01pVVm8vUt2LeLxTHELvF7D6bWDRJJJxhayApnT8PHWppgETx4GRhsNyGrA3324DcFC
         qtD3gRl+FKu49fJrb3cUiyXxD931XCUHwatTEgyMEwPWNabq2KxoHDT692PwhTtDs3jh
         0lUw==
X-Gm-Message-State: AOAM5321G6CcphVU5sAVJ3z07oyMVc64CqxIShr50ist3em+gjMGiyTm
        XN00Ees42/O0nPMPi9lElV2nQw==
X-Google-Smtp-Source: ABdhPJy2O/UK2533uxkLDGlF5W6RsWluHD1/MUiuZcqt+i/pTIK5YRHC2V4KQvLpyDf0rDuWQAJu6A==
X-Received: by 2002:a17:902:be14:b0:14f:ce67:d0a1 with SMTP id r20-20020a170902be1400b0014fce67d0a1mr20044235pls.29.1646050987224;
        Mon, 28 Feb 2022 04:23:07 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id ep22-20020a17090ae65600b001b92477db10sm10466753pjb.29.2022.02.28.04.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 04:23:06 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        roman.gushchin@linux.dev, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        jaegeuk@kernel.org, chao@kernel.org, kari.argillander@gmail.com,
        vbabka@suse.cz
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v6 06/16] nfs42: use a specific kmem_cache to allocate nfs4_xattr_entry
Date:   Mon, 28 Feb 2022 20:21:16 +0800
Message-Id: <20220228122126.37293-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220228122126.37293-1-songmuchun@bytedance.com>
References: <20220228122126.37293-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we want to add the allocated objects to its list_lru, we should use
kmem_cache_alloc_lru() to allocate objects. So intruduce
nfs4_xattr_entry_cachep which is used to allocate nfs4_xattr_entry.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/nfs/nfs42xattr.c | 95 ++++++++++++++++++++++++++---------------------------
 1 file changed, 47 insertions(+), 48 deletions(-)

diff --git a/fs/nfs/nfs42xattr.c b/fs/nfs/nfs42xattr.c
index 1c4d2a05b401..5b7af9080db0 100644
--- a/fs/nfs/nfs42xattr.c
+++ b/fs/nfs/nfs42xattr.c
@@ -81,7 +81,7 @@ struct nfs4_xattr_entry {
 	struct hlist_node hnode;
 	struct list_head lru;
 	struct list_head dispose;
-	char *xattr_name;
+	const char *xattr_name;
 	void *xattr_value;
 	size_t xattr_size;
 	struct nfs4_xattr_bucket *bucket;
@@ -98,6 +98,7 @@ static struct list_lru nfs4_xattr_entry_lru;
 static struct list_lru nfs4_xattr_large_entry_lru;
 
 static struct kmem_cache *nfs4_xattr_cache_cachep;
+static struct kmem_cache *nfs4_xattr_entry_cachep;
 
 /*
  * Hashing helper functions.
@@ -177,49 +178,27 @@ nfs4_xattr_alloc_entry(const char *name, const void *value,
 {
 	struct nfs4_xattr_entry *entry;
 	void *valp;
-	char *namep;
-	size_t alloclen, slen;
-	char *buf;
-	uint32_t flags;
+	const char *namep;
+	uint32_t flags = len > PAGE_SIZE ? NFS4_XATTR_ENTRY_EXTVAL : 0;
+	gfp_t gfp = GFP_KERNEL_ACCOUNT | GFP_NOFS;
+	struct list_lru *lru;
 
 	BUILD_BUG_ON(sizeof(struct nfs4_xattr_entry) +
 	    XATTR_NAME_MAX + 1 > PAGE_SIZE);
 
-	alloclen = sizeof(struct nfs4_xattr_entry);
-	if (name != NULL) {
-		slen = strlen(name) + 1;
-		alloclen += slen;
-	} else
-		slen = 0;
-
-	if (alloclen + len <= PAGE_SIZE) {
-		alloclen += len;
-		flags = 0;
-	} else {
-		flags = NFS4_XATTR_ENTRY_EXTVAL;
-	}
-
-	buf = kmalloc(alloclen, GFP_KERNEL_ACCOUNT | GFP_NOFS);
-	if (buf == NULL)
+	lru = flags & NFS4_XATTR_ENTRY_EXTVAL ? &nfs4_xattr_large_entry_lru :
+	      &nfs4_xattr_entry_lru;
+	entry = kmem_cache_alloc_lru(nfs4_xattr_entry_cachep, lru, gfp);
+	if (!entry)
 		return NULL;
-	entry = (struct nfs4_xattr_entry *)buf;
-
-	if (name != NULL) {
-		namep = buf + sizeof(struct nfs4_xattr_entry);
-		memcpy(namep, name, slen);
-	} else {
-		namep = NULL;
-	}
-
-
-	if (flags & NFS4_XATTR_ENTRY_EXTVAL) {
-		valp = kvmalloc(len, GFP_KERNEL_ACCOUNT | GFP_NOFS);
-		if (valp == NULL) {
-			kfree(buf);
-			return NULL;
-		}
-	} else if (len != 0) {
-		valp = buf + sizeof(struct nfs4_xattr_entry) + slen;
+	namep = kstrdup_const(name, gfp);
+	if (!namep && name)
+		goto free_buf;
+
+	if (len != 0) {
+		valp = kvmalloc(len, gfp);
+		if (!valp)
+			goto free_name;
 	} else
 		valp = NULL;
 
@@ -232,23 +211,23 @@ nfs4_xattr_alloc_entry(const char *name, const void *value,
 
 	entry->flags = flags;
 	entry->xattr_value = valp;
-	kref_init(&entry->ref);
 	entry->xattr_name = namep;
 	entry->xattr_size = len;
-	entry->bucket = NULL;
-	INIT_LIST_HEAD(&entry->lru);
-	INIT_LIST_HEAD(&entry->dispose);
-	INIT_HLIST_NODE(&entry->hnode);
 
 	return entry;
+free_name:
+	kfree_const(namep);
+free_buf:
+	kmem_cache_free(nfs4_xattr_entry_cachep, entry);
+	return NULL;
 }
 
 static void
 nfs4_xattr_free_entry(struct nfs4_xattr_entry *entry)
 {
-	if (entry->flags & NFS4_XATTR_ENTRY_EXTVAL)
-		kvfree(entry->xattr_value);
-	kfree(entry);
+	kvfree(entry->xattr_value);
+	kfree_const(entry->xattr_name);
+	kmem_cache_free(nfs4_xattr_entry_cachep, entry);
 }
 
 static void
@@ -289,7 +268,7 @@ nfs4_xattr_alloc_cache(void)
 {
 	struct nfs4_xattr_cache *cache;
 
-	cache = kmem_cache_alloc(nfs4_xattr_cache_cachep,
+	cache = kmem_cache_alloc_lru(nfs4_xattr_cache_cachep, &nfs4_xattr_cache_lru,
 	    GFP_KERNEL_ACCOUNT | GFP_NOFS);
 	if (cache == NULL)
 		return NULL;
@@ -992,6 +971,17 @@ static void nfs4_xattr_cache_init_once(void *p)
 	INIT_LIST_HEAD(&cache->dispose);
 }
 
+static void nfs4_xattr_entry_init_once(void *p)
+{
+	struct nfs4_xattr_entry *entry = p;
+
+	kref_init(&entry->ref);
+	entry->bucket = NULL;
+	INIT_LIST_HEAD(&entry->lru);
+	INIT_LIST_HEAD(&entry->dispose);
+	INIT_HLIST_NODE(&entry->hnode);
+}
+
 int __init nfs4_xattr_cache_init(void)
 {
 	int ret = 0;
@@ -1003,6 +993,13 @@ int __init nfs4_xattr_cache_init(void)
 	if (nfs4_xattr_cache_cachep == NULL)
 		return -ENOMEM;
 
+	nfs4_xattr_entry_cachep = kmem_cache_create("nfs4_xattr_entry",
+			sizeof(struct nfs4_xattr_entry), 0,
+			(SLAB_RECLAIM_ACCOUNT | SLAB_MEM_SPREAD | SLAB_ACCOUNT),
+			nfs4_xattr_entry_init_once);
+	if (!nfs4_xattr_entry_cachep)
+		goto out5;
+
 	ret = list_lru_init_memcg(&nfs4_xattr_large_entry_lru,
 	    &nfs4_xattr_large_entry_shrinker);
 	if (ret)
@@ -1040,6 +1037,8 @@ int __init nfs4_xattr_cache_init(void)
 out3:
 	list_lru_destroy(&nfs4_xattr_large_entry_lru);
 out4:
+	kmem_cache_destroy(nfs4_xattr_entry_cachep);
+out5:
 	kmem_cache_destroy(nfs4_xattr_cache_cachep);
 
 	return ret;
-- 
2.11.0

