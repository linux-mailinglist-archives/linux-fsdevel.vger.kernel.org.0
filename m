Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51ECB47A668
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Dec 2021 09:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238177AbhLTI6X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Dec 2021 03:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238178AbhLTI6V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Dec 2021 03:58:21 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B49C06173E
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Dec 2021 00:58:21 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id u16so1497565plg.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Dec 2021 00:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W7N2ct9tvwpvEjrUOuEEAnTDqNZXNpAiEvvqkroYr+g=;
        b=QZXa/UkcMj7OIM0da+GzV5d/fUa7Ms0fpFshUq9dGaOgmBscFnDPbyob11rrtTYR7c
         J8yomK+Pdy7OyE7GLD0ChMNKFeIPWqed72C0+1Qv22iLqvZF+6xMyM06GPXOaalsDhDq
         x1gKDT/IajRhMChhO54psatBfyuW45+BQZrKeEl9gjcVooddKjnqU7d1dXbmi7VYNl3v
         dee+sTyBu28Z5iEea+Td8RQ9IA9tDnX2rczUyisXDIOLo2UiI/e8oB6UU9Vf7utA/oyY
         n0nPZZfXQh5BDTHLEidJiFgDq4GRfo6S51j3wQE9TjdJ+qH6j4sfS5DaUVrSQvuio1aG
         iXzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W7N2ct9tvwpvEjrUOuEEAnTDqNZXNpAiEvvqkroYr+g=;
        b=D8FsL8UgyTyURAk02pS4ymDruTWyUu4bhmESMqJZzuOpjCynX+GRUE/8G45VY9paDO
         5fkIGs3fTfWzzsaVEFmyJ03BKX5x6bYBAznL7hoFIPvZ0f8Dljj6Fs7o6FHLcU3lPPAw
         Fyszy3IJcU/BQnNwaKcgMk3rd4O3q8MNZENvdxW1w52BVDNnG5p3i/gX6xcD5JSDFsqp
         woZ7d7uPIAipSz/nbjG8Jzqn9dSq39Dd+fzEN6nZ6ljQqRobXWd1wMmvusN7nvUgeLSm
         XrIDHLzQEeBRvjNdpA2t8PQuCNod6uiVjXwSLgh5465XlAV2xAMogeHWWoAgoQN8Lxae
         9OPg==
X-Gm-Message-State: AOAM532yRhXty+qmdeLhOXdpkE+8/pEL067xZEY1ZTUzlj2nPKJ4UppA
        WvLjU1YL5SZsFSA7f/EDiAb6yA==
X-Google-Smtp-Source: ABdhPJwSQ/OS/edjn3SJrIgOS5QYli36TpUCxhaWSqiLQOQ0iTZPdTODZFhb2DYgjSwDx+rEcdt75g==
X-Received: by 2002:a17:902:b944:b0:148:be4b:66dd with SMTP id h4-20020a170902b94400b00148be4b66ddmr15867095pls.63.1639990700861;
        Mon, 20 Dec 2021 00:58:20 -0800 (PST)
Received: from localhost.localdomain ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id m11sm18441647pfk.27.2021.12.20.00.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 00:58:20 -0800 (PST)
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
Subject: [PATCH v5 06/16] nfs42: use a specific kmem_cache to allocate nfs4_xattr_entry
Date:   Mon, 20 Dec 2021 16:56:39 +0800
Message-Id: <20211220085649.8196-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20211220085649.8196-1-songmuchun@bytedance.com>
References: <20211220085649.8196-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

