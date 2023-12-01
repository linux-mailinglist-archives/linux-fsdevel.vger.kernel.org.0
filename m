Return-Path: <linux-fsdevel+bounces-4628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E775801683
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 23:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D94B81F2101C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A3C3F8C7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="FOeEoXdB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84659128
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 14:12:07 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5d226f51f71so29284707b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 14:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701468727; x=1702073527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rRbP9jVi3V5fXBhoYCeWMR54boR3Ggluqw/tdmkCHt8=;
        b=FOeEoXdBUcQcUQhTHvg4lPlfvCc2NZFGERqTONBj2ZCsuBFFzp1MBUvbK95ZPoKsUZ
         1sujR3Z9lvq2lgtCtMYswPK8R9/j9sbg1hv0qlQQTXtBgteQMzQ+puzto9TnvNkIGyC8
         jTh3nV/cunbRtSwJ1UZWuhWTqkHApF1YkvrxPabaLLsTVNY8vfJKn+luOvqXgymHwg3O
         43xU0P5mclLIpODC2qqV3uB6XZHZEXoR33qz58Rqa/yTL7w4mzm2wE1g5O4wPIVLdzo5
         0Q+sZVQa6Sv3I4BbuOMmuNefNWAW4ev6ETrLpLv8K7cK5njyhBt2KaoueuNlEdr7pDIL
         gD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701468727; x=1702073527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rRbP9jVi3V5fXBhoYCeWMR54boR3Ggluqw/tdmkCHt8=;
        b=srtEL73G3CSkDjiSkysjDJtR1i8Mr3iuApmPg4iqwL7PO3Mx61mnigM9NqZZROVQRP
         jk1tngc3wdG5GIqibJ0asDXh75qfFFCjwrmQUNCCSbQVMpQ99g/KUWItnSFIAZ7PyPnh
         XN7a1L0bgQiKtsY42wGgEnRr5HN1lcErhSVEV68gO1XR5h6Jx44ZEl8i8YK4uYy9aFBO
         CjPf2CrsHA7Hl8NBMILELywru9QcYB3kIvgq95OcD4e32/apYRN27fHrusgKD71UclFQ
         w9pLcURtS6s98DefSHmJFjZh+VKypd7oITl/JNjwVZ7QOB37MPFvDvbfRG+iOz7KItls
         e4gw==
X-Gm-Message-State: AOJu0YwJLGzKR89cX99qkmWnMSyNCfQSYYRubbAjv7VnfRvRCuuJ6s/m
	XdPAnl68QnX259l6olNvuOELPg==
X-Google-Smtp-Source: AGHT+IEonFB4vJNrURhy4u8oG0ufEWKbxLiQ4StU7oLAaK2if3peCC8nEoAmo+Y2x2OLNC6hVzBdRg==
X-Received: by 2002:a05:690c:3509:b0:5d7:a3f:fce3 with SMTP id fq9-20020a05690c350900b005d70a3ffce3mr593515ywb.8.1701468726712;
        Fri, 01 Dec 2023 14:12:06 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id t6-20020a81c246000000b005845e6f9b50sm1367552ywg.113.2023.12.01.14.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:12:06 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 08/46] btrfs: add infrastructure for safe em freeing
Date: Fri,  1 Dec 2023 17:11:05 -0500
Message-ID: <d376f64ca9a67c6b73d2cffb3558d0c72f6f78c1.1701468306.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1701468305.git.josef@toxicpanda.com>
References: <cover.1701468305.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When we add fscrypt support we're going to have fscrypt objects hanging
off of extent_maps.  This includes a block key, which if we're the last
one freeing the key we may have to unregister it from the block layer.
This requires taking a semaphore in the block layer, which means we
can't free em's under the extent map tree lock.

Thankfully we only do this in two places, one where we're dropping a
range of extent maps, and when we're freeing logged extents.  Add a
free_extent_map_safe() which will add the em to a list in the em_tree if
we free'd the object.  Currently this is unconditional but will be
changed to conditional on the fscrypt object we will add in a later
patch.

To process these delayed objects add a free_pending_extent_maps() that
is called after the lock has been dropped on the em_tree.  This will
process the extent maps on the freed list and do the appropriate freeing
work in a safe manner.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_map.c | 69 +++++++++++++++++++++++++++++++++++++++++--
 fs/btrfs/extent_map.h | 10 +++++++
 fs/btrfs/tree-log.c   |  6 ++--
 3 files changed, 81 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index c956b1ced69f..20d347fa6f8a 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -35,7 +35,9 @@ void __cold extent_map_exit(void)
 void extent_map_tree_init(struct extent_map_tree *tree)
 {
 	tree->map = RB_ROOT_CACHED;
+	tree->flags = 0;
 	INIT_LIST_HEAD(&tree->modified_extents);
+	INIT_LIST_HEAD(&tree->freed_extents);
 	rwlock_init(&tree->lock);
 }
 
@@ -53,6 +55,7 @@ struct extent_map *alloc_extent_map(void)
 	em->compress_type = BTRFS_COMPRESS_NONE;
 	refcount_set(&em->refs, 1);
 	INIT_LIST_HEAD(&em->list);
+	INIT_LIST_HEAD(&em->free_list);
 	return em;
 }
 
@@ -71,6 +74,65 @@ void free_extent_map(struct extent_map *em)
 	}
 }
 
+/*
+ * Drop a ref for the extent map in the given tree.
+ *
+ * @tree:	tree that the em is a part of.
+ * @em:		the em to drop the reference to.
+ *
+ * Drop the reference count on @em by one, if the reference count hits 0 and
+ * there is an object on the em that can't be safely freed in the current
+ * context (if we are holding the extent_map_tree->lock for example), then add
+ * it to the freed_extents list on the extent_map_tree for later processing.
+ *
+ * This must be followed by a free_pending_extent_maps() to clear the pending
+ * frees.
+ */
+void free_extent_map_safe(struct extent_map_tree *tree,
+			  struct extent_map *em)
+{
+	lockdep_assert_held_write(&tree->lock);
+
+	if (!em)
+		return;
+
+	if (refcount_dec_and_test(&em->refs)) {
+		WARN_ON(extent_map_in_tree(em));
+		WARN_ON(!list_empty(&em->list));
+		list_add_tail(&em->free_list, &tree->freed_extents);
+		set_bit(EXTENT_MAP_TREE_PENDING_FREES, &tree->flags);
+	}
+}
+
+/*
+ * Free the em objects that exist on the em tree
+ *
+ * @tree:	the tree to free the objects from.
+ *
+ * If there are any objects on the em->freed_extents list go ahead and free them
+ * here in a safe way.  This is to be coupled with any uses of
+ * free_extent_map_safe().
+ */
+void free_pending_extent_maps(struct extent_map_tree *tree)
+{
+	struct extent_map *em;
+
+	/* Avoid taking the write lock if we don't have any pending frees. */
+	if (!test_and_clear_bit(EXTENT_MAP_TREE_PENDING_FREES, &tree->flags))
+		return;
+
+	write_lock(&tree->lock);
+	while ((em = list_first_entry_or_null(&tree->freed_extents,
+					      struct extent_map, free_list))) {
+		list_del_init(&em->free_list);
+		write_unlock(&tree->lock);
+		__free_extent_map(em);
+		cond_resched();
+		write_lock(&tree->lock);
+	}
+	write_unlock(&tree->lock);
+}
+
 /* Do the math around the end of an extent, handling wrapping. */
 static u64 range_end(u64 start, u64 len)
 {
@@ -645,10 +707,12 @@ static void drop_all_extent_maps_fast(struct extent_map_tree *tree)
 		clear_bit(EXTENT_FLAG_PINNED, &em->flags);
 		clear_bit(EXTENT_FLAG_LOGGING, &em->flags);
 		remove_extent_mapping(tree, em);
-		free_extent_map(em);
+		free_extent_map_safe(tree, em);
 		cond_resched_rwlock_write(&tree->lock);
 	}
 	write_unlock(&tree->lock);
+
+	free_pending_extent_maps(tree);
 }
 
 /*
@@ -869,13 +933,14 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 		free_extent_map(em);
 next:
 		/* Once for us (for our lookup reference). */
-		free_extent_map(em);
+		free_extent_map_safe(em_tree, em);
 
 		em = next_em;
 	}
 
 	write_unlock(&em_tree->lock);
 
+	free_pending_extent_maps(em_tree);
 	free_extent_map(split);
 	free_extent_map(split2);
 }
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index bae14af197ef..fb8905f88f7c 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -51,11 +51,18 @@ struct extent_map {
 	refcount_t refs;
 	unsigned int compress_type;
 	struct list_head list;
+	struct list_head free_list;
+};
+
+enum extent_map_flags {
+	EXTENT_MAP_TREE_PENDING_FREES,
 };
 
 struct extent_map_tree {
 	struct rb_root_cached map;
+	unsigned long flags;
 	struct list_head modified_extents;
+	struct list_head freed_extents;
 	rwlock_t lock;
 };
 
@@ -84,6 +91,9 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 
 struct extent_map *alloc_extent_map(void);
 void free_extent_map(struct extent_map *em);
+void free_extent_map_safe(struct extent_map_tree *tree,
+			  struct extent_map *em);
+void free_pending_extent_maps(struct extent_map_tree *tree);
 int __init extent_map_init(void);
 void __cold extent_map_exit(void);
 int unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64 len, u64 gen);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 7d6729d9fd2f..00b6f0c71e1d 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4883,7 +4883,7 @@ static int btrfs_log_changed_extents(struct btrfs_trans_handle *trans,
 		 */
 		if (ret) {
 			clear_em_logging(tree, em);
-			free_extent_map(em);
+			free_extent_map_safe(tree, em);
 			continue;
 		}
 
@@ -4892,11 +4892,13 @@ static int btrfs_log_changed_extents(struct btrfs_trans_handle *trans,
 		ret = log_one_extent(trans, inode, em, path, ctx);
 		write_lock(&tree->lock);
 		clear_em_logging(tree, em);
-		free_extent_map(em);
+		free_extent_map_safe(tree, em);
 	}
 	WARN_ON(!list_empty(&extents));
 	write_unlock(&tree->lock);
 
+	free_pending_extent_maps(tree);
+
 	if (!ret)
 		ret = btrfs_log_prealloc_extents(trans, inode, path);
 	if (ret)
-- 
2.41.0


