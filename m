Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14FAC71142
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2019 07:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbfGWFg0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jul 2019 01:36:26 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39639 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfGWFg0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jul 2019 01:36:26 -0400
Received: by mail-io1-f66.google.com with SMTP id f4so79239571ioh.6;
        Mon, 22 Jul 2019 22:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bRU0cjTa08e/p52b5y5nL1d1323iBABGlPTDO+DIpBA=;
        b=Fo+PsHO+KeG2xguakssGRc9y0fjr346kbBonhdR0hVOwFanbliNTu3z57vxrCFdv7U
         js2idgS+JYPYcmmzv3iOfGpENdtQsosuzOIHYhf0LkYzE8f4J1RxA3dYlvCWwIlt4KrF
         4Wle9otalLel1zwVctP7Q2MUsMnRihsrwPut6L+wxiksAA8yr6odEwjspo8Du9r0mJA5
         Glsqy/ALsKnGHTTq0LU3zyCKUc+BTRnoh7Gfh7NtEA6mhkv9ZCJPzUIX26x6xemN6O28
         D+uS0/OzSd7pKtp5syda3uv09ciKhDPoE4Jpbx9U48FaQP8XlOVRJqqCIW3hVKe7src1
         +sqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=bRU0cjTa08e/p52b5y5nL1d1323iBABGlPTDO+DIpBA=;
        b=cbX1JU46ZHvo7KBcwVJR4TZyRouL7GoeMsOSxw0GEsZUxX98BbUgHUdBjemuNVR0sm
         OIO/0BHVG0UaamJoUNU2mZIug+nxsoTtsMFazqibScJAfbmS1DNVDcLlSTcwG1/+M+eI
         2RcjFhvNJZonMn5QArhPHtS6JLkgXsohTK9bSyQGSAlWQxUzKH5a+gZ22ftN2QZLO+5a
         UCR9+R9JfIF/uzV6nAEx/yI2l1mvg+K6696LyQEdFPsRKp0CzDFTqn1JNAc/jMzHFM9P
         5+hFJX3WnAtYuORS4+F79xqkxdJawlrcUhtHlT4eKehdsu040bMg9KNwx5k1RveLBgVl
         U86w==
X-Gm-Message-State: APjAAAXBRzxFDNiXTl7JCBh3+JRkt5vZtHrysHl8WKAqg2v3/DbSNK5a
        3jsYcSzob0pwugUkqJQDlXszGFiJ4i7LAw==
X-Google-Smtp-Source: APXvYqxFkJlJ3+KNQOIj+07cH8QWvYl/FT+kn4CDCosOb9uy1SYTIHF/ObIqKy6C/2OjP7zV7VUJcA==
X-Received: by 2002:a02:7121:: with SMTP id n33mr75368393jac.19.1563860185255;
        Mon, 22 Jul 2019 22:36:25 -0700 (PDT)
Received: from sultan-box.localdomain (ip-174-149-195-86.englco.spcsdns.net. [174.149.195.86])
        by smtp.gmail.com with ESMTPSA id l2sm29874615ioh.20.2019.07.22.22.36.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 22:36:24 -0700 (PDT)
From:   Sultan Alsawaf <sultan@kerneltoast.com>
X-Google-Original-From: Sultan Alsawaf
Cc:     Sultan Alsawaf <sultan@kerneltoast.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mbcache: Speed up cache entry creation
Date:   Mon, 22 Jul 2019 23:35:49 -0600
Message-Id: <20190723053549.14465-1-sultan@kerneltoast.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Sultan Alsawaf <sultan@kerneltoast.com>

In order to prevent redundant entry creation by racing against itself,
mb_cache_entry_create scans through a hash-list of all current entries
in order to see if another allocation for the requested new entry has
been made. Furthermore, it allocates memory for a new entry before
scanning through this hash-list, which results in that allocated memory
being discarded when the requested new entry is already present.

Speed up cache entry creation by keeping a small linked list of
requested new entries in progress, and scanning through that first
instead of the large hash-list. And don't allocate memory for a new
entry until it's known that the allocated memory will be used.

Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
---
 fs/mbcache.c | 82 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 57 insertions(+), 25 deletions(-)

diff --git a/fs/mbcache.c b/fs/mbcache.c
index 97c54d3a2227..289f3664061e 100644
--- a/fs/mbcache.c
+++ b/fs/mbcache.c
@@ -25,9 +25,14 @@
  * size hash table is used for fast key lookups.
  */
 
+struct mb_bucket {
+	struct hlist_bl_head hash;
+	struct list_head req_list;
+};
+
 struct mb_cache {
 	/* Hash table of entries */
-	struct hlist_bl_head	*c_hash;
+	struct mb_bucket	*c_bucket;
 	/* log2 of hash table size */
 	int			c_bucket_bits;
 	/* Maximum entries in cache to avoid degrading hash too much */
@@ -42,15 +47,21 @@ struct mb_cache {
 	struct work_struct	c_shrink_work;
 };
 
+struct mb_cache_req {
+	struct list_head lnode;
+	u32 key;
+	u64 value;
+};
+
 static struct kmem_cache *mb_entry_cache;
 
 static unsigned long mb_cache_shrink(struct mb_cache *cache,
 				     unsigned long nr_to_scan);
 
-static inline struct hlist_bl_head *mb_cache_entry_head(struct mb_cache *cache,
-							u32 key)
+static inline struct mb_bucket *mb_cache_entry_bucket(struct mb_cache *cache,
+						      u32 key)
 {
-	return &cache->c_hash[hash_32(key, cache->c_bucket_bits)];
+	return &cache->c_bucket[hash_32(key, cache->c_bucket_bits)];
 }
 
 /*
@@ -77,6 +88,8 @@ int mb_cache_entry_create(struct mb_cache *cache, gfp_t mask, u32 key,
 	struct mb_cache_entry *entry, *dup;
 	struct hlist_bl_node *dup_node;
 	struct hlist_bl_head *head;
+	struct mb_cache_req *tmp_req, req;
+	struct mb_bucket *bucket;
 
 	/* Schedule background reclaim if there are too many entries */
 	if (cache->c_entry_count >= cache->c_max_entries)
@@ -85,9 +98,33 @@ int mb_cache_entry_create(struct mb_cache *cache, gfp_t mask, u32 key,
 	if (cache->c_entry_count >= 2*cache->c_max_entries)
 		mb_cache_shrink(cache, SYNC_SHRINK_BATCH);
 
+	bucket = mb_cache_entry_bucket(cache, key);
+	head = &bucket->hash;
+	hlist_bl_lock(head);
+	list_for_each_entry(tmp_req, &bucket->req_list, lnode) {
+		if (tmp_req->key == key && tmp_req->value == value) {
+			hlist_bl_unlock(head);
+			return -EBUSY;
+		}
+	}
+	hlist_bl_for_each_entry(dup, dup_node, head, e_hash_list) {
+		if (dup->e_key == key && dup->e_value == value) {
+			hlist_bl_unlock(head);
+			return -EBUSY;
+		}
+	}
+	req.key = key;
+	req.value = value;
+	list_add(&req.lnode, &bucket->req_list);
+	hlist_bl_unlock(head);
+
 	entry = kmem_cache_alloc(mb_entry_cache, mask);
-	if (!entry)
+	if (!entry) {
+		hlist_bl_lock(head);
+		list_del(&req.lnode);
+		hlist_bl_unlock(head);
 		return -ENOMEM;
+	}
 
 	INIT_LIST_HEAD(&entry->e_list);
 	/* One ref for hash, one ref returned */
@@ -96,15 +133,9 @@ int mb_cache_entry_create(struct mb_cache *cache, gfp_t mask, u32 key,
 	entry->e_value = value;
 	entry->e_reusable = reusable;
 	entry->e_referenced = 0;
-	head = mb_cache_entry_head(cache, key);
+
 	hlist_bl_lock(head);
-	hlist_bl_for_each_entry(dup, dup_node, head, e_hash_list) {
-		if (dup->e_key == key && dup->e_value == value) {
-			hlist_bl_unlock(head);
-			kmem_cache_free(mb_entry_cache, entry);
-			return -EBUSY;
-		}
-	}
+	list_del(&req.lnode);
 	hlist_bl_add_head(&entry->e_hash_list, head);
 	hlist_bl_unlock(head);
 
@@ -133,7 +164,7 @@ static struct mb_cache_entry *__entry_find(struct mb_cache *cache,
 	struct hlist_bl_node *node;
 	struct hlist_bl_head *head;
 
-	head = mb_cache_entry_head(cache, key);
+	head = &mb_cache_entry_bucket(cache, key)->hash;
 	hlist_bl_lock(head);
 	if (entry && !hlist_bl_unhashed(&entry->e_hash_list))
 		node = entry->e_hash_list.next;
@@ -202,7 +233,7 @@ struct mb_cache_entry *mb_cache_entry_get(struct mb_cache *cache, u32 key,
 	struct hlist_bl_head *head;
 	struct mb_cache_entry *entry;
 
-	head = mb_cache_entry_head(cache, key);
+	head = &mb_cache_entry_bucket(cache, key)->hash;
 	hlist_bl_lock(head);
 	hlist_bl_for_each_entry(entry, node, head, e_hash_list) {
 		if (entry->e_key == key && entry->e_value == value) {
@@ -230,7 +261,7 @@ void mb_cache_entry_delete(struct mb_cache *cache, u32 key, u64 value)
 	struct hlist_bl_head *head;
 	struct mb_cache_entry *entry;
 
-	head = mb_cache_entry_head(cache, key);
+	head = &mb_cache_entry_bucket(cache, key)->hash;
 	hlist_bl_lock(head);
 	hlist_bl_for_each_entry(entry, node, head, e_hash_list) {
 		if (entry->e_key == key && entry->e_value == value) {
@@ -300,7 +331,7 @@ static unsigned long mb_cache_shrink(struct mb_cache *cache,
 		 * from under us.
 		 */
 		spin_unlock(&cache->c_list_lock);
-		head = mb_cache_entry_head(cache, entry->e_key);
+		head = &mb_cache_entry_bucket(cache, entry->e_key)->hash;
 		hlist_bl_lock(head);
 		if (!hlist_bl_unhashed(&entry->e_hash_list)) {
 			hlist_bl_del_init(&entry->e_hash_list);
@@ -354,21 +385,22 @@ struct mb_cache *mb_cache_create(int bucket_bits)
 	cache->c_max_entries = bucket_count << 4;
 	INIT_LIST_HEAD(&cache->c_list);
 	spin_lock_init(&cache->c_list_lock);
-	cache->c_hash = kmalloc_array(bucket_count,
-				      sizeof(struct hlist_bl_head),
-				      GFP_KERNEL);
-	if (!cache->c_hash) {
+	cache->c_bucket = kmalloc_array(bucket_count, sizeof(*cache->c_bucket),
+					GFP_KERNEL);
+	if (!cache->c_bucket) {
 		kfree(cache);
 		goto err_out;
 	}
-	for (i = 0; i < bucket_count; i++)
-		INIT_HLIST_BL_HEAD(&cache->c_hash[i]);
+	for (i = 0; i < bucket_count; i++) {
+		INIT_HLIST_BL_HEAD(&cache->c_bucket[i].hash);
+		INIT_LIST_HEAD(&cache->c_bucket[i].req_list);
+	}
 
 	cache->c_shrink.count_objects = mb_cache_count;
 	cache->c_shrink.scan_objects = mb_cache_scan;
 	cache->c_shrink.seeks = DEFAULT_SEEKS;
 	if (register_shrinker(&cache->c_shrink)) {
-		kfree(cache->c_hash);
+		kfree(cache->c_bucket);
 		kfree(cache);
 		goto err_out;
 	}
@@ -409,7 +441,7 @@ void mb_cache_destroy(struct mb_cache *cache)
 		WARN_ON(atomic_read(&entry->e_refcnt) != 1);
 		mb_cache_entry_put(cache, entry);
 	}
-	kfree(cache->c_hash);
+	kfree(cache->c_bucket);
 	kfree(cache);
 }
 EXPORT_SYMBOL(mb_cache_destroy);
-- 
2.22.0

