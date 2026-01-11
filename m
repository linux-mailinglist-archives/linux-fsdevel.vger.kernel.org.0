Return-Path: <linux-fsdevel+bounces-73160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCC5D0F101
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jan 2026 15:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5865E300BA02
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jan 2026 14:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731C4340A6C;
	Sun, 11 Jan 2026 14:11:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9FB33EAE0
	for <linux-fsdevel@vger.kernel.org>; Sun, 11 Jan 2026 14:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768140688; cv=none; b=iM0961yafrDIX+zBVGTtpHvBxpo+RHFmOM907VaWNsChfjJ6HE94o9ucBKlZuT2OaoBcK8mJ912E52vcxyPQwGiJgS7c/TiXwZs6wwBvrObQ9eM6nbWc9cJLgjbVmOf7WidmHrjQVuBfp16ZiFez6DeW8deMdeYhRICMA6iSeaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768140688; c=relaxed/simple;
	bh=551nbSNM08bYm2TGhrSi0BoxTVY80wTjRRF9Kr7VuVM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tk2O4+GK56gThDLHVxaL+Z3/gxmFuTq6HkwNAbSZh+SMvRoc8xTZAQATrB92PMFW/HRcnPkml7lMFw+w/eQ/H4N6wIKENtjqjEr6qJ0ZyxzYjllKnt9Nldw7eWJu4qhW/+H3cYyIYlqueTJYAY+8YPFKdNGeNO8OGVaoRZvL1RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c46d68f2b4eso3484844a12.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Jan 2026 06:11:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768140676; x=1768745476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=txwwVXPNzO9MnYvQQ+vxE2Mfu+6nuSlmpeWBIkRXAkI=;
        b=e9/BUMRRuc5JmkZ+OrbqSDWnB86RcgSeMrV1X8YwmM+U8++s5d1ogyP4Ekt0VDl4nQ
         jE4JJEE6u7VYqUgtYDY53AJokMM0SqJwjHPOq3F3Fs2CAXTZ+iVCJMndwR3JVfFyw8pf
         AnVdBEUmUIopnRA0YAJbT3gmFmIJOshiri+oaJm2OafMa45qfYaiNwriPJtjDzO4j02d
         ekXD58obhrKz9OMkaiWkGe4fmwEFc+1GCpuDDIsmC6UhCX4XE8LTbkMwvtKlYtAOOJU2
         MKycsuL8VAOc3/4xMmQohpM1xXb2KhbUBxX1IIkeK8GDYvqBaZrRitgnj7nOXX6ahN/R
         oJZw==
X-Gm-Message-State: AOJu0YyF9Njjhz/NEcn5nlxctV8BeXo8lGTYaRReCnIxGBQ4m2FIisQu
	RqIx0AbbPDm5TrxAQEW0tlY6IlGC6mzm4PWoIkIa02dUYh3uGb8DqzTB
X-Gm-Gg: AY/fxX7xoNsWoDLpJZ0BY7+9FyfoL3esyEUK4CKk0lTjxhwugKvOJ8SZPn3HkMwuIm8
	su65OAAbBpKhBTbzSYQ9Il6+9xoQh3Ug9iwUGqP4R5NcmbntWsrTBWty1EvXX4tCqExmG/2c4y4
	YxBIjrvAsNyshgzICPcyXb8W2xHLvpJmtEYIxXK20bI1tuajQV93P98GuMZRWsmX8dWa34LcORs
	woyjKAnwpHzxOh4VFtvsysPm0zCmbDDPRqAsbu28xDAix6TlKbY+ybBWmCyQ8Om6YA6V+Ry6BcE
	aSQ8qjL0bO81Zz4sTucPYXsFj6GU5GF0c0xMdjXE06m5+up6pIQLTWg0RX5Pzgf+8Ax0hGG031P
	FY3MoNpVFgJNJggLEg2G5g4PLeR1Q3quNSD5FZ/ouOjK3it9vg1hYzOBc6StW0pYd/vQ3Or9lvF
	20W2/67yHj1TPaeFbvMXvuB0ZDhQ==
X-Google-Smtp-Source: AGHT+IGQzsBvGnkH1ZXl6qijZCeafoyOT14egs80yFRLkVk3X4pj5BIBpPvDd/xquf/sMoI7axARvQ==
X-Received: by 2002:a05:6a20:12ca:b0:35b:b97f:7471 with SMTP id adf61e73a8af0-3898f8cccfamr14284582637.4.1768140675167;
        Sun, 11 Jan 2026 06:11:15 -0800 (PST)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cc02ecfccsm14887077a12.13.2026.01.11.06.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 06:11:12 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	hch@lst.de,
	tytso@mit.edu,
	willy@infradead.org,
	jack@suse.cz,
	djwong@kernel.org,
	josef@toxicpanda.com,
	sandeen@sandeen.net,
	rgoldwyn@suse.com,
	xiang@kernel.org,
	dsterba@suse.com,
	pali@kernel.org,
	ebiggers@kernel.org,
	neil@brown.name,
	amir73il@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iamjoonsoo.kim@lge.com,
	cheol.lee@lge.com,
	jay.sim@lge.com,
	gunho.lee@lge.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Subject: [PATCH v5 04/14] ntfs: update inode operations
Date: Sun, 11 Jan 2026 23:03:34 +0900
Message-Id: <20260111140345.3866-5-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260111140345.3866-1-linkinjeon@kernel.org>
References: <20260111140345.3866-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This updates the implementation of inode operations.

Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ntfs/inode.c | 3601 ++++++++++++++++++++++++++++-------------------
 fs/ntfs/mft.c   | 2189 +++++++++++++---------------
 fs/ntfs/mst.c   |   60 +-
 fs/ntfs/namei.c | 1586 +++++++++++++++++++--
 4 files changed, 4585 insertions(+), 2851 deletions(-)

diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index aba1e22db4e9..1de379d6622a 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -1,31 +1,24 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * inode.c - NTFS kernel inode handling.
+ * NTFS kernel inode handling.
  *
  * Copyright (c) 2001-2014 Anton Altaparmakov and Tuxera Inc.
+ * Copyright (c) 2025 LG Electronics Co., Ltd.
  */
 
-#include <linux/buffer_head.h>
-#include <linux/fs.h>
-#include <linux/mm.h>
-#include <linux/mount.h>
-#include <linux/mutex.h>
-#include <linux/pagemap.h>
-#include <linux/quotaops.h>
-#include <linux/slab.h>
-#include <linux/log2.h>
-
-#include "aops.h"
-#include "attrib.h"
-#include "bitmap.h"
-#include "dir.h"
-#include "debug.h"
-#include "inode.h"
+#include <linux/writeback.h>
+#include <linux/seq_file.h>
+
 #include "lcnalloc.h"
 #include "malloc.h"
-#include "mft.h"
 #include "time.h"
 #include "ntfs.h"
+#include "index.h"
+#include "attrlist.h"
+#include "reparse.h"
+#include "ea.h"
+#include "attrib.h"
+#include "iomap.h"
 
 /**
  * ntfs_test_inode - compare two (possibly fake) inodes for equality
@@ -45,12 +38,14 @@
  */
 int ntfs_test_inode(struct inode *vi, void *data)
 {
-	ntfs_attr *na = (ntfs_attr *)data;
-	ntfs_inode *ni;
+	struct ntfs_attr *na = (struct ntfs_attr *)data;
+	struct ntfs_inode *ni;
 
 	if (vi->i_ino != na->mft_no)
 		return 0;
+
 	ni = NTFS_I(vi);
+
 	/* If !NInoAttr(ni), @vi is a normal file or directory inode. */
 	if (likely(!NInoAttr(ni))) {
 		/* If not looking for a normal inode this is a mismatch. */
@@ -63,9 +58,12 @@ int ntfs_test_inode(struct inode *vi, void *data)
 		if (ni->name_len != na->name_len)
 			return 0;
 		if (na->name_len && memcmp(ni->name, na->name,
-				na->name_len * sizeof(ntfschar)))
+				na->name_len * sizeof(__le16)))
+			return 0;
+		if (!ni->ext.base_ntfs_ino)
 			return 0;
 	}
+
 	/* Match! */
 	return 1;
 }
@@ -83,31 +81,31 @@ int ntfs_test_inode(struct inode *vi, void *data)
  * respectively. Although that is not strictly necessary as
  * ntfs_read_locked_inode() will fill them in later.
  *
- * Return 0 on success and -errno on error.
+ * Return 0 on success and error.
  *
  * NOTE: This function runs with the inode->i_lock spin lock held so it is not
  * allowed to sleep. (Hence the GFP_ATOMIC allocation.)
  */
 static int ntfs_init_locked_inode(struct inode *vi, void *data)
 {
-	ntfs_attr *na = (ntfs_attr *)data;
-	ntfs_inode *ni = NTFS_I(vi);
+	struct ntfs_attr *na = (struct ntfs_attr *)data;
+	struct ntfs_inode *ni = NTFS_I(vi);
 
 	vi->i_ino = na->mft_no;
 
-	ni->type = na->type;
 	if (na->type == AT_INDEX_ALLOCATION)
 		NInoSetMstProtected(ni);
+	else
+		ni->type = na->type;
 
 	ni->name = na->name;
 	ni->name_len = na->name_len;
+	ni->folio = NULL;
+	atomic_set(&ni->count, 1);
 
 	/* If initializing a normal inode, we are done. */
-	if (likely(na->type == AT_UNUSED)) {
-		BUG_ON(na->name);
-		BUG_ON(na->name_len);
+	if (likely(na->type == AT_UNUSED))
 		return 0;
-	}
 
 	/* It is a fake inode. */
 	NInoSetAttr(ni);
@@ -122,9 +120,8 @@ static int ntfs_init_locked_inode(struct inode *vi, void *data)
 	if (na->name_len && na->name != I30) {
 		unsigned int i;
 
-		BUG_ON(!na->name);
-		i = na->name_len * sizeof(ntfschar);
-		ni->name = kmalloc(i + sizeof(ntfschar), GFP_ATOMIC);
+		i = na->name_len * sizeof(__le16);
+		ni->name = kmalloc(i + sizeof(__le16), GFP_ATOMIC);
 		if (!ni->name)
 			return -ENOMEM;
 		memcpy(ni->name, na->name, i);
@@ -158,7 +155,7 @@ struct inode *ntfs_iget(struct super_block *sb, unsigned long mft_no)
 {
 	struct inode *vi;
 	int err;
-	ntfs_attr na;
+	struct ntfs_attr na;
 
 	na.mft_no = mft_no;
 	na.type = AT_UNUSED;
@@ -173,7 +170,7 @@ struct inode *ntfs_iget(struct super_block *sb, unsigned long mft_no)
 	err = 0;
 
 	/* If this is a freshly allocated inode, need to read it now. */
-	if (vi->i_state & I_NEW) {
+	if (inode_state_read_once(vi) & I_NEW) {
 		err = ntfs_read_locked_inode(vi);
 		unlock_new_inode(vi);
 	}
@@ -211,15 +208,15 @@ struct inode *ntfs_iget(struct super_block *sb, unsigned long mft_no)
  * value with IS_ERR() and if true, the function failed and the error code is
  * obtained from PTR_ERR().
  */
-struct inode *ntfs_attr_iget(struct inode *base_vi, ATTR_TYPE type,
-		ntfschar *name, u32 name_len)
+struct inode *ntfs_attr_iget(struct inode *base_vi, __le32 type,
+		__le16 *name, u32 name_len)
 {
 	struct inode *vi;
 	int err;
-	ntfs_attr na;
+	struct ntfs_attr na;
 
 	/* Make sure no one calls ntfs_attr_iget() for indices. */
-	BUG_ON(type == AT_INDEX_ALLOCATION);
+	WARN_ON(type == AT_INDEX_ALLOCATION);
 
 	na.mft_no = base_vi->i_ino;
 	na.type = type;
@@ -230,11 +227,10 @@ struct inode *ntfs_attr_iget(struct inode *base_vi, ATTR_TYPE type,
 			ntfs_init_locked_inode, &na);
 	if (unlikely(!vi))
 		return ERR_PTR(-ENOMEM);
-
 	err = 0;
 
 	/* If this is a freshly allocated inode, need to read it now. */
-	if (vi->i_state & I_NEW) {
+	if (inode_state_read_once(vi) & I_NEW) {
 		err = ntfs_read_locked_attr_inode(base_vi, vi);
 		unlock_new_inode(vi);
 	}
@@ -269,12 +265,12 @@ struct inode *ntfs_attr_iget(struct inode *base_vi, ATTR_TYPE type,
  * value with IS_ERR() and if true, the function failed and the error code is
  * obtained from PTR_ERR().
  */
-struct inode *ntfs_index_iget(struct inode *base_vi, ntfschar *name,
+struct inode *ntfs_index_iget(struct inode *base_vi, __le16 *name,
 		u32 name_len)
 {
 	struct inode *vi;
 	int err;
-	ntfs_attr na;
+	struct ntfs_attr na;
 
 	na.mft_no = base_vi->i_ino;
 	na.type = AT_INDEX_ALLOCATION;
@@ -289,7 +285,7 @@ struct inode *ntfs_index_iget(struct inode *base_vi, ntfschar *name,
 	err = 0;
 
 	/* If this is a freshly allocated inode, need to read it now. */
-	if (vi->i_state & I_NEW) {
+	if (inode_state_read_once(vi) & I_NEW) {
 		err = ntfs_read_locked_index_inode(base_vi, vi);
 		unlock_new_inode(vi);
 	}
@@ -307,12 +303,14 @@ struct inode *ntfs_index_iget(struct inode *base_vi, ntfschar *name,
 
 struct inode *ntfs_alloc_big_inode(struct super_block *sb)
 {
-	ntfs_inode *ni;
+	struct ntfs_inode *ni;
 
 	ntfs_debug("Entering.");
 	ni = alloc_inode_sb(sb, ntfs_big_inode_cache, GFP_NOFS);
 	if (likely(ni != NULL)) {
 		ni->state = 0;
+		ni->type = 0;
+		ni->mft_no = 0;
 		return VFS_I(ni);
 	}
 	ntfs_error(sb, "Allocation of NTFS big inode structure failed.");
@@ -324,9 +322,97 @@ void ntfs_free_big_inode(struct inode *inode)
 	kmem_cache_free(ntfs_big_inode_cache, NTFS_I(inode));
 }
 
-static inline ntfs_inode *ntfs_alloc_extent_inode(void)
+static int ntfs_non_resident_dealloc_clusters(struct ntfs_inode *ni)
+{
+	struct super_block *sb = ni->vol->sb;
+	struct ntfs_attr_search_ctx *actx;
+	int err = 0;
+
+	actx = ntfs_attr_get_search_ctx(ni, NULL);
+	if (!actx)
+		return -ENOMEM;
+	WARN_ON(actx->mrec->link_count != 0);
+
+	/**
+	 * ntfs_truncate_vfs cannot be called in evict() context due
+	 * to some limitations, which are the @ni vfs inode is marked
+	 * with I_FREEING, and etc.
+	 */
+	if (NInoRunlistDirty(ni)) {
+		err = ntfs_cluster_free_from_rl(ni->vol, ni->runlist.rl);
+		if (err)
+			ntfs_error(sb,
+					"Failed to free clusters. Leaving inconsistent metadata.\n");
+	}
+
+	while ((err = ntfs_attrs_walk(actx)) == 0) {
+		if (actx->attr->non_resident &&
+				(!NInoRunlistDirty(ni) || actx->attr->type != AT_DATA)) {
+			struct runlist_element *rl;
+			size_t new_rl_count;
+
+			rl = ntfs_mapping_pairs_decompress(ni->vol, actx->attr, NULL,
+					&new_rl_count);
+			if (IS_ERR(rl)) {
+				err = PTR_ERR(rl);
+				ntfs_error(sb,
+					   "Failed to decompress runlist. Leaving inconsistent metadata.\n");
+				continue;
+			}
+
+			err = ntfs_cluster_free_from_rl(ni->vol, rl);
+			if (err)
+				ntfs_error(sb,
+					   "Failed to free attribute clusters. Leaving inconsistent metadata.\n");
+			ntfs_free(rl);
+		}
+	}
+
+	ntfs_release_dirty_clusters(ni->vol, ni->i_dealloc_clusters);
+	ntfs_attr_put_search_ctx(actx);
+	return err;
+}
+
+int ntfs_drop_big_inode(struct inode *inode)
+{
+	struct ntfs_inode *ni = NTFS_I(inode);
+
+	if (!inode_unhashed(inode) && inode_state_read_once(inode) & I_SYNC) {
+		if (ni->type == AT_DATA || ni->type == AT_INDEX_ALLOCATION) {
+			if (!inode->i_nlink) {
+				struct ntfs_inode *ni = NTFS_I(inode);
+
+				if (ni->data_size == 0)
+					return 0;
+
+				/* To avoid evict_inode call simultaneously */
+				atomic_inc(&inode->i_count);
+				spin_unlock(&inode->i_lock);
+
+				truncate_setsize(VFS_I(ni), 0);
+				ntfs_truncate_vfs(VFS_I(ni), 0, 1);
+
+				sb_start_intwrite(inode->i_sb);
+				i_size_write(inode, 0);
+				ni->allocated_size = ni->initialized_size = ni->data_size = 0;
+
+				truncate_inode_pages_final(inode->i_mapping);
+				sb_end_intwrite(inode->i_sb);
+
+				spin_lock(&inode->i_lock);
+				atomic_dec(&inode->i_count);
+			}
+			return 0;
+		} else if (ni->type == AT_INDEX_ROOT)
+			return 0;
+	}
+
+	return inode_generic_drop(inode);
+}
+
+static inline struct ntfs_inode *ntfs_alloc_extent_inode(void)
 {
-	ntfs_inode *ni;
+	struct ntfs_inode *ni;
 
 	ntfs_debug("Entering.");
 	ni = kmem_cache_alloc(ntfs_inode_cache, GFP_NOFS);
@@ -338,15 +424,21 @@ static inline ntfs_inode *ntfs_alloc_extent_inode(void)
 	return NULL;
 }
 
-static void ntfs_destroy_extent_inode(ntfs_inode *ni)
+static void ntfs_destroy_extent_inode(struct ntfs_inode *ni)
 {
 	ntfs_debug("Entering.");
-	BUG_ON(ni->page);
+
 	if (!atomic_dec_and_test(&ni->count))
-		BUG();
+		WARN_ON(1);
+	if (ni->folio)
+		folio_put(ni->folio);
+	kfree(ni->mrec);
 	kmem_cache_free(ntfs_inode_cache, ni);
 }
 
+static struct lock_class_key attr_inode_mrec_lock_class;
+static struct lock_class_key attr_list_inode_mrec_lock_class;
+
 /*
  * The attribute runlist lock has separate locking rules from the
  * normal runlist lock, so split the two lock-classes:
@@ -362,10 +454,8 @@ static struct lock_class_key attr_list_rl_lock_class;
  *
  * NOTE: ni->mft_no, ni->state, ni->type, ni->name, and ni->name_len are left
  * untouched. Make sure to initialize them elsewhere.
- *
- * Return zero on success and -ENOMEM on error.
  */
-void __ntfs_init_inode(struct super_block *sb, ntfs_inode *ni)
+void __ntfs_init_inode(struct super_block *sb, struct ntfs_inode *ni)
 {
 	ntfs_debug("Entering.");
 	rwlock_init(&ni->size_lock);
@@ -374,14 +464,23 @@ void __ntfs_init_inode(struct super_block *sb, ntfs_inode *ni)
 	atomic_set(&ni->count, 1);
 	ni->vol = NTFS_SB(sb);
 	ntfs_init_runlist(&ni->runlist);
+	ni->lcn_seek_trunc = LCN_RL_NOT_MAPPED;
 	mutex_init(&ni->mrec_lock);
-	ni->page = NULL;
-	ni->page_ofs = 0;
+	if (ni->type == AT_ATTRIBUTE_LIST) {
+		lockdep_set_class(&ni->mrec_lock,
+				  &attr_list_inode_mrec_lock_class);
+		lockdep_set_class(&ni->runlist.lock,
+				  &attr_list_rl_lock_class);
+	} else if (NInoAttr(ni)) {
+		lockdep_set_class(&ni->mrec_lock,
+				  &attr_inode_mrec_lock_class);
+	}
+
+	ni->folio = NULL;
+	ni->folio_ofs = 0;
+	ni->mrec = NULL;
 	ni->attr_list_size = 0;
 	ni->attr_list = NULL;
-	ntfs_init_runlist(&ni->attr_list_rl);
-	lockdep_set_class(&ni->attr_list_rl.lock,
-				&attr_list_rl_lock_class);
 	ni->itype.index.block_size = 0;
 	ni->itype.index.vcn_size = 0;
 	ni->itype.index.collation_rule = 0;
@@ -390,6 +489,11 @@ void __ntfs_init_inode(struct super_block *sb, ntfs_inode *ni)
 	mutex_init(&ni->extent_lock);
 	ni->nr_extents = 0;
 	ni->ext.base_ntfs_ino = NULL;
+	ni->flags = 0;
+	ni->mft_lcn[0] = LCN_RL_NOT_MAPPED;
+	ni->mft_lcn_count = 0;
+	ni->target = NULL;
+	ni->i_dealloc_clusters = 0;
 }
 
 /*
@@ -399,10 +503,10 @@ void __ntfs_init_inode(struct super_block *sb, ntfs_inode *ni)
  */
 static struct lock_class_key extent_inode_mrec_lock_key;
 
-inline ntfs_inode *ntfs_new_extent_inode(struct super_block *sb,
+inline struct ntfs_inode *ntfs_new_extent_inode(struct super_block *sb,
 		unsigned long mft_no)
 {
-	ntfs_inode *ni = ntfs_alloc_extent_inode();
+	struct ntfs_inode *ni = ntfs_alloc_extent_inode();
 
 	ntfs_debug("Entering.");
 	if (likely(ni != NULL)) {
@@ -429,7 +533,7 @@ inline ntfs_inode *ntfs_new_extent_inode(struct super_block *sb,
  *	   0: file is not in $Extend directory
  *    -errno: failed to determine if the file is in the $Extend directory
  */
-static int ntfs_is_extended_system_file(ntfs_attr_search_ctx *ctx)
+static int ntfs_is_extended_system_file(struct ntfs_attr_search_ctx *ctx)
 {
 	int nr_links, err;
 
@@ -442,8 +546,8 @@ static int ntfs_is_extended_system_file(ntfs_attr_search_ctx *ctx)
 	/* Loop through all hard links. */
 	while (!(err = ntfs_attr_lookup(AT_FILE_NAME, NULL, 0, 0, 0, NULL, 0,
 			ctx))) {
-		FILE_NAME_ATTR *file_name_attr;
-		ATTR_RECORD *attr = ctx->attr;
+		struct file_name_attr *file_name_attr;
+		struct attr_record *attr = ctx->attr;
 		u8 *p, *p2;
 
 		nr_links--;
@@ -451,50 +555,90 @@ static int ntfs_is_extended_system_file(ntfs_attr_search_ctx *ctx)
 		 * Maximum sanity checking as we are called on an inode that
 		 * we suspect might be corrupt.
 		 */
-		p = (u8*)attr + le32_to_cpu(attr->length);
-		if (p < (u8*)ctx->mrec || (u8*)p > (u8*)ctx->mrec +
+		p = (u8 *)attr + le32_to_cpu(attr->length);
+		if (p < (u8 *)ctx->mrec || (u8 *)p > (u8 *)ctx->mrec +
 				le32_to_cpu(ctx->mrec->bytes_in_use)) {
 err_corrupt_attr:
-			ntfs_error(ctx->ntfs_ino->vol->sb, "Corrupt file name "
-					"attribute. You should run chkdsk.");
+			ntfs_error(ctx->ntfs_ino->vol->sb,
+					"Corrupt file name attribute. You should run chkdsk.");
 			return -EIO;
 		}
 		if (attr->non_resident) {
-			ntfs_error(ctx->ntfs_ino->vol->sb, "Non-resident file "
-					"name. You should run chkdsk.");
+			ntfs_error(ctx->ntfs_ino->vol->sb,
+					"Non-resident file name. You should run chkdsk.");
 			return -EIO;
 		}
 		if (attr->flags) {
-			ntfs_error(ctx->ntfs_ino->vol->sb, "File name with "
-					"invalid flags. You should run "
-					"chkdsk.");
+			ntfs_error(ctx->ntfs_ino->vol->sb,
+					"File name with invalid flags. You should run chkdsk.");
 			return -EIO;
 		}
 		if (!(attr->data.resident.flags & RESIDENT_ATTR_IS_INDEXED)) {
-			ntfs_error(ctx->ntfs_ino->vol->sb, "Unindexed file "
-					"name. You should run chkdsk.");
+			ntfs_error(ctx->ntfs_ino->vol->sb,
+					"Unindexed file name. You should run chkdsk.");
 			return -EIO;
 		}
-		file_name_attr = (FILE_NAME_ATTR*)((u8*)attr +
+		file_name_attr = (struct file_name_attr *)((u8 *)attr +
 				le16_to_cpu(attr->data.resident.value_offset));
 		p2 = (u8 *)file_name_attr + le32_to_cpu(attr->data.resident.value_length);
-		if (p2 < (u8*)attr || p2 > p)
+		if (p2 < (u8 *)attr || p2 > p)
 			goto err_corrupt_attr;
 		/* This attribute is ok, but is it in the $Extend directory? */
-		if (MREF_LE(file_name_attr->parent_directory) == FILE_Extend)
+		if (MREF_LE(file_name_attr->parent_directory) == FILE_Extend) {
+			unsigned char *s;
+
+			s = ntfs_attr_name_get(ctx->ntfs_ino->vol,
+					file_name_attr->file_name,
+					file_name_attr->file_name_length);
+			if (!s)
+				return 1;
+			if (!strcmp("$Reparse", s)) {
+				ntfs_attr_name_free(&s);
+				return 2; /* it's reparse point file */
+			}
+			ntfs_attr_name_free(&s);
 			return 1;	/* YES, it's an extended system file. */
+		}
 	}
 	if (unlikely(err != -ENOENT))
 		return err;
 	if (unlikely(nr_links)) {
-		ntfs_error(ctx->ntfs_ino->vol->sb, "Inode hard link count "
-				"doesn't match number of name attributes. You "
-				"should run chkdsk.");
+		ntfs_error(ctx->ntfs_ino->vol->sb,
+			"Inode hard link count doesn't match number of name attributes. You should run chkdsk.");
 		return -EIO;
 	}
 	return 0;	/* NO, it is not an extended system file. */
 }
 
+static struct lock_class_key ntfs_dir_inval_lock_key;
+
+void ntfs_set_vfs_operations(struct inode *inode, mode_t mode, dev_t dev)
+{
+	if (S_ISDIR(mode)) {
+		if (!NInoAttr(NTFS_I(inode))) {
+			inode->i_op = &ntfs_dir_inode_ops;
+			inode->i_fop = &ntfs_dir_ops;
+		}
+		inode->i_mapping->a_ops = &ntfs_aops;
+		lockdep_set_class(&inode->i_mapping->invalidate_lock,
+				  &ntfs_dir_inval_lock_key);
+	} else if (S_ISLNK(mode)) {
+		inode->i_op = &ntfs_symlink_inode_operations;
+		inode->i_mapping->a_ops = &ntfs_aops;
+	} else if (S_ISCHR(mode) || S_ISBLK(mode) || S_ISFIFO(mode) || S_ISSOCK(mode)) {
+		inode->i_op = &ntfs_special_inode_operations;
+		init_special_inode(inode, inode->i_mode, dev);
+	} else {
+		if (!NInoAttr(NTFS_I(inode))) {
+			inode->i_op = &ntfs_file_inode_ops;
+			inode->i_fop = &ntfs_file_ops;
+		}
+		inode->i_mapping->a_ops = &ntfs_aops;
+	}
+}
+
+__le16 R[3] = { cpu_to_le16('$'), cpu_to_le16('R'), 0 };
+
 /**
  * ntfs_read_locked_inode - read an inode from its device
  * @vi:		inode to read
@@ -518,26 +662,38 @@ static int ntfs_is_extended_system_file(ntfs_attr_search_ctx *ctx)
  *    we need to do that using the IS_* macros defined in include/linux/fs.h.
  *    In any case ntfs_read_locked_inode() has nothing to do with i_flags.
  *
- * Return 0 on success and -errno on error.  In the error case, the inode will
- * have had make_bad_inode() executed on it.
+ * Return 0 on success and -errno on error.
  */
 static int ntfs_read_locked_inode(struct inode *vi)
 {
-	ntfs_volume *vol = NTFS_SB(vi->i_sb);
-	ntfs_inode *ni;
-	struct inode *bvi;
-	MFT_RECORD *m;
-	ATTR_RECORD *a;
-	STANDARD_INFORMATION *si;
-	ntfs_attr_search_ctx *ctx;
+	struct ntfs_volume *vol = NTFS_SB(vi->i_sb);
+	struct ntfs_inode *ni;
+	struct mft_record *m;
+	struct attr_record *a;
+	struct standard_information *si;
+	struct ntfs_attr_search_ctx *ctx;
 	int err = 0;
+	__le16 *name = I30;
+	unsigned int name_len = 4, flags = 0;
+	int extend_sys = 0;
+	dev_t dev = 0;
+	bool vol_err = true;
 
 	ntfs_debug("Entering for i_ino 0x%lx.", vi->i_ino);
 
-	/* Setup the generic vfs inode parts now. */
-	vi->i_uid = vol->uid;
-	vi->i_gid = vol->gid;
-	vi->i_mode = 0;
+	if (uid_valid(vol->uid)) {
+		vi->i_uid = vol->uid;
+		flags |= NTFS_VOL_UID;
+	} else
+		vi->i_uid = GLOBAL_ROOT_UID;
+
+	if (gid_valid(vol->gid)) {
+		vi->i_gid = vol->gid;
+		flags |= NTFS_VOL_GID;
+	} else
+		vi->i_gid = GLOBAL_ROOT_GID;
+
+	vi->i_mode = 0777;
 
 	/*
 	 * Initialize the ntfs specific part of @vi special casing
@@ -552,6 +708,7 @@ static int ntfs_read_locked_inode(struct inode *vi)
 		err = PTR_ERR(m);
 		goto err_out;
 	}
+
 	ctx = ntfs_attr_get_search_ctx(ni, m);
 	if (!ctx) {
 		err = -ENOMEM;
@@ -559,9 +716,11 @@ static int ntfs_read_locked_inode(struct inode *vi)
 	}
 
 	if (!(m->flags & MFT_RECORD_IN_USE)) {
-		ntfs_error(vi->i_sb, "Inode is not in use!");
+		err = -ENOENT;
+		vol_err = false;
 		goto unm_err_out;
 	}
+
 	if (m->base_mft_record) {
 		ntfs_error(vi->i_sb, "Inode is an extent inode!");
 		goto unm_err_out;
@@ -570,61 +729,28 @@ static int ntfs_read_locked_inode(struct inode *vi)
 	/* Transfer information from mft record into vfs and ntfs inodes. */
 	vi->i_generation = ni->seq_no = le16_to_cpu(m->sequence_number);
 
-	/*
-	 * FIXME: Keep in mind that link_count is two for files which have both
-	 * a long file name and a short file name as separate entries, so if
-	 * we are hiding short file names this will be too high. Either we need
-	 * to account for the short file names by subtracting them or we need
-	 * to make sure we delete files even though i_nlink is not zero which
-	 * might be tricky due to vfs interactions. Need to think about this
-	 * some more when implementing the unlink command.
-	 */
+	if (le16_to_cpu(m->link_count) < 1) {
+		ntfs_error(vi->i_sb, "Inode link count is 0!");
+		goto unm_err_out;
+	}
 	set_nlink(vi, le16_to_cpu(m->link_count));
-	/*
-	 * FIXME: Reparse points can have the directory bit set even though
-	 * they would be S_IFLNK. Need to deal with this further below when we
-	 * implement reparse points / symbolic links but it will do for now.
-	 * Also if not a directory, it could be something else, rather than
-	 * a regular file. But again, will do for now.
-	 */
-	/* Everyone gets all permissions. */
-	vi->i_mode |= S_IRWXUGO;
+
 	/* If read-only, no one gets write permissions. */
 	if (IS_RDONLY(vi))
-		vi->i_mode &= ~S_IWUGO;
-	if (m->flags & MFT_RECORD_IS_DIRECTORY) {
-		vi->i_mode |= S_IFDIR;
-		/*
-		 * Apply the directory permissions mask set in the mount
-		 * options.
-		 */
-		vi->i_mode &= ~vol->dmask;
-		/* Things break without this kludge! */
-		if (vi->i_nlink > 1)
-			set_nlink(vi, 1);
-	} else {
-		vi->i_mode |= S_IFREG;
-		/* Apply the file permissions mask set in the mount options. */
-		vi->i_mode &= ~vol->fmask;
-	}
+		vi->i_mode &= ~0222;
+
 	/*
 	 * Find the standard information attribute in the mft record. At this
 	 * stage we haven't setup the attribute list stuff yet, so this could
 	 * in fact fail if the standard information is in an extent record, but
 	 * I don't think this actually ever happens.
 	 */
+	ntfs_attr_reinit_search_ctx(ctx);
 	err = ntfs_attr_lookup(AT_STANDARD_INFORMATION, NULL, 0, 0, 0, NULL, 0,
 			ctx);
 	if (unlikely(err)) {
-		if (err == -ENOENT) {
-			/*
-			 * TODO: We should be performing a hot fix here (if the
-			 * recover mount option is set) by creating a new
-			 * attribute.
-			 */
-			ntfs_error(vi->i_sb, "$STANDARD_INFORMATION attribute "
-					"is missing.");
-		}
+		if (err == -ENOENT)
+			ntfs_error(vi->i_sb, "$STANDARD_INFORMATION attribute is missing.");
 		goto unm_err_out;
 	}
 	a = ctx->attr;
@@ -635,7 +761,7 @@ static int ntfs_read_locked_inode(struct inode *vi)
 		ntfs_error(vi->i_sb, "Corrupt standard information attribute in inode.");
 		goto unm_err_out;
 	}
-	si = (STANDARD_INFORMATION*)((u8*)a +
+	si = (struct standard_information *)((u8 *)a +
 			le16_to_cpu(a->data.resident.value_offset));
 
 	/* Transfer information from the standard information into vi. */
@@ -648,6 +774,8 @@ static int ntfs_read_locked_inode(struct inode *vi)
 	 * mtime is the last change of the data within the file. Not changed
 	 * when only metadata is changed, e.g. a rename doesn't affect mtime.
 	 */
+	ni->i_crtime = ntfs2utc(si->creation_time);
+
 	inode_set_mtime_to_ts(vi, ntfs2utc(si->last_data_change_time));
 	/*
 	 * ctime is the last change of the metadata of the file. This obviously
@@ -660,135 +788,143 @@ static int ntfs_read_locked_inode(struct inode *vi)
 	 * for example but changed whenever the file is written to.
 	 */
 	inode_set_atime_to_ts(vi, ntfs2utc(si->last_access_time));
+	ni->flags = si->file_attributes;
 
 	/* Find the attribute list attribute if present. */
 	ntfs_attr_reinit_search_ctx(ctx);
 	err = ntfs_attr_lookup(AT_ATTRIBUTE_LIST, NULL, 0, 0, 0, NULL, 0, ctx);
 	if (err) {
 		if (unlikely(err != -ENOENT)) {
-			ntfs_error(vi->i_sb, "Failed to lookup attribute list "
-					"attribute.");
+			ntfs_error(vi->i_sb, "Failed to lookup attribute list attribute.");
 			goto unm_err_out;
 		}
-	} else /* if (!err) */ {
+	} else {
 		if (vi->i_ino == FILE_MFT)
 			goto skip_attr_list_load;
 		ntfs_debug("Attribute list found in inode 0x%lx.", vi->i_ino);
 		NInoSetAttrList(ni);
 		a = ctx->attr;
 		if (a->flags & ATTR_COMPRESSION_MASK) {
-			ntfs_error(vi->i_sb, "Attribute list attribute is "
-					"compressed.");
+			ntfs_error(vi->i_sb,
+				"Attribute list attribute is compressed.");
 			goto unm_err_out;
 		}
 		if (a->flags & ATTR_IS_ENCRYPTED ||
 				a->flags & ATTR_IS_SPARSE) {
 			if (a->non_resident) {
-				ntfs_error(vi->i_sb, "Non-resident attribute "
-						"list attribute is encrypted/"
-						"sparse.");
+				ntfs_error(vi->i_sb,
+					"Non-resident attribute list attribute is encrypted/sparse.");
 				goto unm_err_out;
 			}
-			ntfs_warning(vi->i_sb, "Resident attribute list "
-					"attribute in inode 0x%lx is marked "
-					"encrypted/sparse which is not true.  "
-					"However, Windows allows this and "
-					"chkdsk does not detect or correct it "
-					"so we will just ignore the invalid "
-					"flags and pretend they are not set.",
-					vi->i_ino);
+			ntfs_warning(vi->i_sb,
+				"Resident attribute list attribute in inode 0x%lx is marked encrypted/sparse which is not true.  However, Windows allows this and chkdsk does not detect or correct it so we will just ignore the invalid flags and pretend they are not set.",
+				vi->i_ino);
 		}
 		/* Now allocate memory for the attribute list. */
 		ni->attr_list_size = (u32)ntfs_attr_size(a);
+		if (!ni->attr_list_size) {
+			ntfs_error(vi->i_sb, "Attr_list_size is zero");
+			goto unm_err_out;
+		}
 		ni->attr_list = ntfs_malloc_nofs(ni->attr_list_size);
 		if (!ni->attr_list) {
-			ntfs_error(vi->i_sb, "Not enough memory to allocate "
-					"buffer for attribute list.");
+			ntfs_error(vi->i_sb,
+				"Not enough memory to allocate buffer for attribute list.");
 			err = -ENOMEM;
 			goto unm_err_out;
 		}
 		if (a->non_resident) {
 			NInoSetAttrListNonResident(ni);
 			if (a->data.non_resident.lowest_vcn) {
-				ntfs_error(vi->i_sb, "Attribute list has non "
-						"zero lowest_vcn.");
-				goto unm_err_out;
-			}
-			/*
-			 * Setup the runlist. No need for locking as we have
-			 * exclusive access to the inode at this time.
-			 */
-			ni->attr_list_rl.rl = ntfs_mapping_pairs_decompress(vol,
-					a, NULL);
-			if (IS_ERR(ni->attr_list_rl.rl)) {
-				err = PTR_ERR(ni->attr_list_rl.rl);
-				ni->attr_list_rl.rl = NULL;
-				ntfs_error(vi->i_sb, "Mapping pairs "
-						"decompression failed.");
+				ntfs_error(vi->i_sb, "Attribute list has non zero lowest_vcn.");
 				goto unm_err_out;
 			}
+
 			/* Now load the attribute list. */
-			if ((err = load_attribute_list(vol, &ni->attr_list_rl,
-					ni->attr_list, ni->attr_list_size,
-					sle64_to_cpu(a->data.non_resident.
-					initialized_size)))) {
-				ntfs_error(vi->i_sb, "Failed to load "
-						"attribute list attribute.");
+			err = load_attribute_list(ni, ni->attr_list, ni->attr_list_size);
+			if (err) {
+				ntfs_error(vi->i_sb, "Failed to load attribute list attribute.");
 				goto unm_err_out;
 			}
 		} else /* if (!a->non_resident) */ {
-			if ((u8*)a + le16_to_cpu(a->data.resident.value_offset)
+			if ((u8 *)a + le16_to_cpu(a->data.resident.value_offset)
 					+ le32_to_cpu(
 					a->data.resident.value_length) >
-					(u8*)ctx->mrec + vol->mft_record_size) {
-				ntfs_error(vi->i_sb, "Corrupt attribute list "
-						"in inode.");
+					(u8 *)ctx->mrec + vol->mft_record_size) {
+				ntfs_error(vi->i_sb, "Corrupt attribute list in inode.");
 				goto unm_err_out;
 			}
 			/* Now copy the attribute list. */
-			memcpy(ni->attr_list, (u8*)a + le16_to_cpu(
+			memcpy(ni->attr_list, (u8 *)a + le16_to_cpu(
 					a->data.resident.value_offset),
 					le32_to_cpu(
 					a->data.resident.value_length));
 		}
 	}
 skip_attr_list_load:
+	err = ntfs_attr_lookup(AT_EA_INFORMATION, NULL, 0, 0, 0, NULL, 0, ctx);
+	if (!err)
+		NInoSetHasEA(ni);
+
+	ntfs_ea_get_wsl_inode(vi, &dev, flags);
+
+	if (m->flags & MFT_RECORD_IS_DIRECTORY) {
+		vi->i_mode |= S_IFDIR;
+		/*
+		 * Apply the directory permissions mask set in the mount
+		 * options.
+		 */
+		vi->i_mode &= ~vol->dmask;
+		/* Things break without this kludge! */
+		if (vi->i_nlink > 1)
+			set_nlink(vi, 1);
+	} else {
+		if (ni->flags & FILE_ATTR_REPARSE_POINT) {
+			unsigned int mode;
+
+			mode = ntfs_make_symlink(ni);
+			if (mode)
+				vi->i_mode |= mode;
+			else {
+				vi->i_mode &= ~S_IFLNK;
+				vi->i_mode |= S_IFREG;
+			}
+		} else
+			vi->i_mode |= S_IFREG;
+		/* Apply the file permissions mask set in the mount options. */
+		vi->i_mode &= ~vol->fmask;
+	}
+
 	/*
 	 * If an attribute list is present we now have the attribute list value
 	 * in ntfs_ino->attr_list and it is ntfs_ino->attr_list_size bytes.
 	 */
 	if (S_ISDIR(vi->i_mode)) {
-		loff_t bvi_size;
-		ntfs_inode *bni;
-		INDEX_ROOT *ir;
+		struct index_root *ir;
 		u8 *ir_end, *index_end;
 
+view_index_meta:
 		/* It is a directory, find index root attribute. */
 		ntfs_attr_reinit_search_ctx(ctx);
-		err = ntfs_attr_lookup(AT_INDEX_ROOT, I30, 4, CASE_SENSITIVE,
+		err = ntfs_attr_lookup(AT_INDEX_ROOT, name, name_len, CASE_SENSITIVE,
 				0, NULL, 0, ctx);
 		if (unlikely(err)) {
-			if (err == -ENOENT) {
-				// FIXME: File is corrupt! Hot-fix with empty
-				// index root attribute if recovery option is
-				// set.
-				ntfs_error(vi->i_sb, "$INDEX_ROOT attribute "
-						"is missing.");
-			}
+			if (err == -ENOENT)
+				ntfs_error(vi->i_sb, "$INDEX_ROOT attribute is missing.");
 			goto unm_err_out;
 		}
 		a = ctx->attr;
 		/* Set up the state. */
 		if (unlikely(a->non_resident)) {
-			ntfs_error(vol->sb, "$INDEX_ROOT attribute is not "
-					"resident.");
+			ntfs_error(vol->sb,
+				"$INDEX_ROOT attribute is not resident.");
 			goto unm_err_out;
 		}
 		/* Ensure the attribute name is placed before the value. */
 		if (unlikely(a->name_length && (le16_to_cpu(a->name_offset) >=
 				le16_to_cpu(a->data.resident.value_offset)))) {
-			ntfs_error(vol->sb, "$INDEX_ROOT attribute name is "
-					"placed after the attribute value.");
+			ntfs_error(vol->sb,
+				"$INDEX_ROOT attribute name is placed after the attribute value.");
 			goto unm_err_out;
 		}
 		/*
@@ -797,66 +933,75 @@ static int ntfs_read_locked_inode(struct inode *vi)
 		 * encrypted. However index root cannot be both compressed and
 		 * encrypted.
 		 */
-		if (a->flags & ATTR_COMPRESSION_MASK)
+		if (a->flags & ATTR_COMPRESSION_MASK) {
 			NInoSetCompressed(ni);
+			ni->flags |= FILE_ATTR_COMPRESSED;
+		}
 		if (a->flags & ATTR_IS_ENCRYPTED) {
 			if (a->flags & ATTR_COMPRESSION_MASK) {
-				ntfs_error(vi->i_sb, "Found encrypted and "
-						"compressed attribute.");
+				ntfs_error(vi->i_sb, "Found encrypted and compressed attribute.");
 				goto unm_err_out;
 			}
 			NInoSetEncrypted(ni);
+			ni->flags |= FILE_ATTR_ENCRYPTED;
 		}
-		if (a->flags & ATTR_IS_SPARSE)
+		if (a->flags & ATTR_IS_SPARSE) {
 			NInoSetSparse(ni);
-		ir = (INDEX_ROOT*)((u8*)a +
+			ni->flags |= FILE_ATTR_SPARSE_FILE;
+		}
+		ir = (struct index_root *)((u8 *)a +
 				le16_to_cpu(a->data.resident.value_offset));
-		ir_end = (u8*)ir + le32_to_cpu(a->data.resident.value_length);
-		if (ir_end > (u8*)ctx->mrec + vol->mft_record_size) {
-			ntfs_error(vi->i_sb, "$INDEX_ROOT attribute is "
-					"corrupt.");
+		ir_end = (u8 *)ir + le32_to_cpu(a->data.resident.value_length);
+		if (ir_end > (u8 *)ctx->mrec + vol->mft_record_size) {
+			ntfs_error(vi->i_sb, "$INDEX_ROOT attribute is corrupt.");
 			goto unm_err_out;
 		}
-		index_end = (u8*)&ir->index +
+		index_end = (u8 *)&ir->index +
 				le32_to_cpu(ir->index.index_length);
 		if (index_end > ir_end) {
 			ntfs_error(vi->i_sb, "Directory index is corrupt.");
 			goto unm_err_out;
 		}
-		if (ir->type != AT_FILE_NAME) {
-			ntfs_error(vi->i_sb, "Indexed attribute is not "
-					"$FILE_NAME.");
-			goto unm_err_out;
-		}
-		if (ir->collation_rule != COLLATION_FILE_NAME) {
-			ntfs_error(vi->i_sb, "Index collation rule is not "
-					"COLLATION_FILE_NAME.");
-			goto unm_err_out;
+
+		if (extend_sys) {
+			if (ir->type) {
+				ntfs_error(vi->i_sb, "Indexed attribute is not zero.");
+				goto unm_err_out;
+			}
+		} else {
+			if (ir->type != AT_FILE_NAME) {
+				ntfs_error(vi->i_sb, "Indexed attribute is not $FILE_NAME.");
+				goto unm_err_out;
+			}
+
+			if (ir->collation_rule != COLLATION_FILE_NAME) {
+				ntfs_error(vi->i_sb,
+					"Index collation rule is not COLLATION_FILE_NAME.");
+				goto unm_err_out;
+			}
 		}
+
 		ni->itype.index.collation_rule = ir->collation_rule;
 		ni->itype.index.block_size = le32_to_cpu(ir->index_block_size);
 		if (ni->itype.index.block_size &
 				(ni->itype.index.block_size - 1)) {
-			ntfs_error(vi->i_sb, "Index block size (%u) is not a "
-					"power of two.",
+			ntfs_error(vi->i_sb, "Index block size (%u) is not a power of two.",
 					ni->itype.index.block_size);
 			goto unm_err_out;
 		}
 		if (ni->itype.index.block_size > PAGE_SIZE) {
-			ntfs_error(vi->i_sb, "Index block size (%u) > "
-					"PAGE_SIZE (%ld) is not "
-					"supported.  Sorry.",
-					ni->itype.index.block_size,
-					PAGE_SIZE);
+			ntfs_error(vi->i_sb,
+				"Index block size (%u) > PAGE_SIZE (%ld) is not supported.",
+				ni->itype.index.block_size,
+				PAGE_SIZE);
 			err = -EOPNOTSUPP;
 			goto unm_err_out;
 		}
 		if (ni->itype.index.block_size < NTFS_BLOCK_SIZE) {
-			ntfs_error(vi->i_sb, "Index block size (%u) < "
-					"NTFS_BLOCK_SIZE (%i) is not "
-					"supported.  Sorry.",
-					ni->itype.index.block_size,
-					NTFS_BLOCK_SIZE);
+			ntfs_error(vi->i_sb,
+				"Index block size (%u) < NTFS_BLOCK_SIZE (%i) is not supported.",
+				ni->itype.index.block_size,
+				NTFS_BLOCK_SIZE);
 			err = -EOPNOTSUPP;
 			goto unm_err_out;
 		}
@@ -872,127 +1017,28 @@ static int ntfs_read_locked_inode(struct inode *vi)
 		}
 
 		/* Setup the index allocation attribute, even if not present. */
-		NInoSetMstProtected(ni);
-		ni->type = AT_INDEX_ALLOCATION;
-		ni->name = I30;
-		ni->name_len = 4;
-
-		if (!(ir->index.flags & LARGE_INDEX)) {
-			/* No index allocation. */
-			vi->i_size = ni->initialized_size =
-					ni->allocated_size = 0;
-			/* We are done with the mft record, so we release it. */
-			ntfs_attr_put_search_ctx(ctx);
-			unmap_mft_record(ni);
-			m = NULL;
-			ctx = NULL;
-			goto skip_large_dir_stuff;
-		} /* LARGE_INDEX: Index allocation present. Setup state. */
-		NInoSetIndexAllocPresent(ni);
-		/* Find index allocation attribute. */
-		ntfs_attr_reinit_search_ctx(ctx);
-		err = ntfs_attr_lookup(AT_INDEX_ALLOCATION, I30, 4,
-				CASE_SENSITIVE, 0, NULL, 0, ctx);
-		if (unlikely(err)) {
-			if (err == -ENOENT)
-				ntfs_error(vi->i_sb, "$INDEX_ALLOCATION "
-						"attribute is not present but "
-						"$INDEX_ROOT indicated it is.");
-			else
-				ntfs_error(vi->i_sb, "Failed to lookup "
-						"$INDEX_ALLOCATION "
-						"attribute.");
-			goto unm_err_out;
-		}
-		a = ctx->attr;
-		if (!a->non_resident) {
-			ntfs_error(vi->i_sb, "$INDEX_ALLOCATION attribute "
-					"is resident.");
-			goto unm_err_out;
-		}
-		/*
-		 * Ensure the attribute name is placed before the mapping pairs
-		 * array.
-		 */
-		if (unlikely(a->name_length && (le16_to_cpu(a->name_offset) >=
-				le16_to_cpu(
-				a->data.non_resident.mapping_pairs_offset)))) {
-			ntfs_error(vol->sb, "$INDEX_ALLOCATION attribute name "
-					"is placed after the mapping pairs "
-					"array.");
-			goto unm_err_out;
-		}
-		if (a->flags & ATTR_IS_ENCRYPTED) {
-			ntfs_error(vi->i_sb, "$INDEX_ALLOCATION attribute "
-					"is encrypted.");
-			goto unm_err_out;
-		}
-		if (a->flags & ATTR_IS_SPARSE) {
-			ntfs_error(vi->i_sb, "$INDEX_ALLOCATION attribute "
-					"is sparse.");
-			goto unm_err_out;
-		}
-		if (a->flags & ATTR_COMPRESSION_MASK) {
-			ntfs_error(vi->i_sb, "$INDEX_ALLOCATION attribute "
-					"is compressed.");
-			goto unm_err_out;
-		}
-		if (a->data.non_resident.lowest_vcn) {
-			ntfs_error(vi->i_sb, "First extent of "
-					"$INDEX_ALLOCATION attribute has non "
-					"zero lowest_vcn.");
-			goto unm_err_out;
-		}
-		vi->i_size = sle64_to_cpu(a->data.non_resident.data_size);
-		ni->initialized_size = sle64_to_cpu(
-				a->data.non_resident.initialized_size);
-		ni->allocated_size = sle64_to_cpu(
-				a->data.non_resident.allocated_size);
-		/*
-		 * We are done with the mft record, so we release it. Otherwise
-		 * we would deadlock in ntfs_attr_iget().
-		 */
+		ni->type = AT_INDEX_ROOT;
+		ni->name = name;
+		ni->name_len = name_len;
+		vi->i_size = ni->initialized_size = ni->data_size =
+			le32_to_cpu(a->data.resident.value_length);
+		ni->allocated_size = (ni->data_size + 7) & ~7;
+		/* We are done with the mft record, so we release it. */
 		ntfs_attr_put_search_ctx(ctx);
 		unmap_mft_record(ni);
 		m = NULL;
 		ctx = NULL;
-		/* Get the index bitmap attribute inode. */
-		bvi = ntfs_attr_iget(vi, AT_BITMAP, I30, 4);
-		if (IS_ERR(bvi)) {
-			ntfs_error(vi->i_sb, "Failed to get bitmap attribute.");
-			err = PTR_ERR(bvi);
-			goto unm_err_out;
-		}
-		bni = NTFS_I(bvi);
-		if (NInoCompressed(bni) || NInoEncrypted(bni) ||
-				NInoSparse(bni)) {
-			ntfs_error(vi->i_sb, "$BITMAP attribute is compressed "
-					"and/or encrypted and/or sparse.");
-			goto iput_unm_err_out;
-		}
-		/* Consistency check bitmap size vs. index allocation size. */
-		bvi_size = i_size_read(bvi);
-		if ((bvi_size << 3) < (vi->i_size >>
-				ni->itype.index.block_size_bits)) {
-			ntfs_error(vi->i_sb, "Index bitmap too small (0x%llx) "
-					"for index allocation (0x%llx).",
-					bvi_size << 3, vi->i_size);
-			goto iput_unm_err_out;
-		}
-		/* No longer need the bitmap attribute inode. */
-		iput(bvi);
-skip_large_dir_stuff:
 		/* Setup the operations for this inode. */
-		vi->i_op = &ntfs_dir_inode_ops;
-		vi->i_fop = &ntfs_dir_ops;
-		vi->i_mapping->a_ops = &ntfs_mst_aops;
+		ntfs_set_vfs_operations(vi, S_IFDIR, 0);
+		if (ir->index.flags & LARGE_INDEX)
+			NInoSetIndexAllocPresent(ni);
 	} else {
 		/* It is a file. */
 		ntfs_attr_reinit_search_ctx(ctx);
 
 		/* Setup the data attribute, even if not present. */
 		ni->type = AT_DATA;
-		ni->name = NULL;
+		ni->name = AT_UNNAMED;
 		ni->name_len = 0;
 
 		/* Find first extent of the unnamed data attribute. */
@@ -1001,8 +1047,7 @@ static int ntfs_read_locked_inode(struct inode *vi)
 			vi->i_size = ni->initialized_size =
 					ni->allocated_size = 0;
 			if (err != -ENOENT) {
-				ntfs_error(vi->i_sb, "Failed to lookup $DATA "
-						"attribute.");
+				ntfs_error(vi->i_sb, "Failed to lookup $DATA attribute.");
 				goto unm_err_out;
 			}
 			/*
@@ -1020,11 +1065,19 @@ static int ntfs_read_locked_inode(struct inode *vi)
 			 * name of this inode from the mft record as the name
 			 * contains the back reference to the parent directory.
 			 */
-			if (ntfs_is_extended_system_file(ctx) > 0)
+			extend_sys = ntfs_is_extended_system_file(ctx);
+			if (extend_sys > 0) {
+				if (m->flags & MFT_RECORD_IS_VIEW_INDEX &&
+				    extend_sys == 2) {
+					name = R;
+					name_len = 2;
+					goto view_index_meta;
+				}
 				goto no_data_attr_special_case;
-			// FIXME: File is corrupt! Hot-fix with empty data
-			// attribute if recovery option is set.
-			ntfs_error(vi->i_sb, "$DATA attribute is missing.");
+			}
+
+			err = extend_sys;
+			ntfs_error(vi->i_sb, "$DATA attribute is missing, err : %d", err);
 			goto unm_err_out;
 		}
 		a = ctx->attr;
@@ -1032,63 +1085,66 @@ static int ntfs_read_locked_inode(struct inode *vi)
 		if (a->flags & (ATTR_COMPRESSION_MASK | ATTR_IS_SPARSE)) {
 			if (a->flags & ATTR_COMPRESSION_MASK) {
 				NInoSetCompressed(ni);
+				ni->flags |= FILE_ATTR_COMPRESSED;
 				if (vol->cluster_size > 4096) {
-					ntfs_error(vi->i_sb, "Found "
-							"compressed data but "
-							"compression is "
-							"disabled due to "
-							"cluster size (%i) > "
-							"4kiB.",
-							vol->cluster_size);
+					ntfs_error(vi->i_sb,
+						"Found compressed data but compression is disabled due to cluster size (%i) > 4kiB.",
+						vol->cluster_size);
 					goto unm_err_out;
 				}
 				if ((a->flags & ATTR_COMPRESSION_MASK)
 						!= ATTR_IS_COMPRESSED) {
-					ntfs_error(vi->i_sb, "Found unknown "
-							"compression method "
-							"or corrupt file.");
+					ntfs_error(vi->i_sb,
+						"Found unknown compression method or corrupt file.");
 					goto unm_err_out;
 				}
 			}
-			if (a->flags & ATTR_IS_SPARSE)
+			if (a->flags & ATTR_IS_SPARSE) {
 				NInoSetSparse(ni);
+				ni->flags |= FILE_ATTR_SPARSE_FILE;
+			}
 		}
 		if (a->flags & ATTR_IS_ENCRYPTED) {
 			if (NInoCompressed(ni)) {
-				ntfs_error(vi->i_sb, "Found encrypted and "
-						"compressed data.");
+				ntfs_error(vi->i_sb, "Found encrypted and compressed data.");
 				goto unm_err_out;
 			}
 			NInoSetEncrypted(ni);
+			ni->flags |= FILE_ATTR_ENCRYPTED;
 		}
 		if (a->non_resident) {
 			NInoSetNonResident(ni);
 			if (NInoCompressed(ni) || NInoSparse(ni)) {
-				if (NInoCompressed(ni) && a->data.non_resident.
-						compression_unit != 4) {
-					ntfs_error(vi->i_sb, "Found "
-							"non-standard "
-							"compression unit (%u "
-							"instead of 4).  "
-							"Cannot handle this.",
-							a->data.non_resident.
-							compression_unit);
+				if (NInoCompressed(ni) &&
+				    a->data.non_resident.compression_unit != 4) {
+					ntfs_error(vi->i_sb,
+						"Found non-standard compression unit (%u instead of 4).  Cannot handle this.",
+						a->data.non_resident.compression_unit);
 					err = -EOPNOTSUPP;
 					goto unm_err_out;
 				}
+
+				if (NInoSparse(ni) &&
+				    a->data.non_resident.compression_unit &&
+				    a->data.non_resident.compression_unit !=
+				     vol->sparse_compression_unit) {
+					ntfs_error(vi->i_sb,
+						   "Found non-standard compression unit (%u instead of 0 or %d).  Cannot handle this.",
+						   a->data.non_resident.compression_unit,
+						   vol->sparse_compression_unit);
+					err = -EOPNOTSUPP;
+					goto unm_err_out;
+				}
+
+
 				if (a->data.non_resident.compression_unit) {
 					ni->itype.compressed.block_size = 1U <<
-							(a->data.non_resident.
-							compression_unit +
+							(a->data.non_resident.compression_unit +
 							vol->cluster_size_bits);
 					ni->itype.compressed.block_size_bits =
-							ffs(ni->itype.
-							compressed.
-							block_size) - 1;
+							ffs(ni->itype.compressed.block_size) - 1;
 					ni->itype.compressed.block_clusters =
-							1U << a->data.
-							non_resident.
-							compression_unit;
+							1U << a->data.non_resident.compression_unit;
 				} else {
 					ni->itype.compressed.block_size = 0;
 					ni->itype.compressed.block_size_bits =
@@ -1096,32 +1152,26 @@ static int ntfs_read_locked_inode(struct inode *vi)
 					ni->itype.compressed.block_clusters =
 							0;
 				}
-				ni->itype.compressed.size = sle64_to_cpu(
-						a->data.non_resident.
-						compressed_size);
+				ni->itype.compressed.size = le64_to_cpu(
+						a->data.non_resident.compressed_size);
 			}
 			if (a->data.non_resident.lowest_vcn) {
-				ntfs_error(vi->i_sb, "First extent of $DATA "
-						"attribute has non zero "
-						"lowest_vcn.");
+				ntfs_error(vi->i_sb,
+					"First extent of $DATA attribute has non zero lowest_vcn.");
 				goto unm_err_out;
 			}
-			vi->i_size = sle64_to_cpu(
-					a->data.non_resident.data_size);
-			ni->initialized_size = sle64_to_cpu(
-					a->data.non_resident.initialized_size);
-			ni->allocated_size = sle64_to_cpu(
-					a->data.non_resident.allocated_size);
+			vi->i_size = ni->data_size = le64_to_cpu(a->data.non_resident.data_size);
+			ni->initialized_size = le64_to_cpu(a->data.non_resident.initialized_size);
+			ni->allocated_size = le64_to_cpu(a->data.non_resident.allocated_size);
 		} else { /* Resident attribute. */
-			vi->i_size = ni->initialized_size = le32_to_cpu(
+			vi->i_size = ni->data_size = ni->initialized_size = le32_to_cpu(
 					a->data.resident.value_length);
 			ni->allocated_size = le32_to_cpu(a->length) -
 					le16_to_cpu(
 					a->data.resident.value_offset);
 			if (vi->i_size > ni->allocated_size) {
-				ntfs_error(vi->i_sb, "Resident data attribute "
-						"is corrupt (size exceeds "
-						"allocation).");
+				ntfs_error(vi->i_sb,
+					"Resident data attribute is corrupt (size exceeds allocation).");
 				goto unm_err_out;
 			}
 		}
@@ -1132,14 +1182,13 @@ static int ntfs_read_locked_inode(struct inode *vi)
 		m = NULL;
 		ctx = NULL;
 		/* Setup the operations for this inode. */
-		vi->i_op = &ntfs_file_inode_ops;
-		vi->i_fop = &ntfs_file_ops;
-		vi->i_mapping->a_ops = &ntfs_normal_aops;
-		if (NInoMstProtected(ni))
-			vi->i_mapping->a_ops = &ntfs_mst_aops;
-		else if (NInoCompressed(ni))
-			vi->i_mapping->a_ops = &ntfs_compressed_aops;
+		ntfs_set_vfs_operations(vi, vi->i_mode, dev);
 	}
+
+	if (NVolSysImmutable(vol) && (ni->flags & FILE_ATTR_SYSTEM) &&
+	    !S_ISFIFO(vi->i_mode) && !S_ISSOCK(vi->i_mode) && !S_ISLNK(vi->i_mode))
+		vi->i_flags |= S_IMMUTABLE;
+
 	/*
 	 * The number of 512-byte blocks used on disk (for stat). This is in so
 	 * far inaccurate as it doesn't account for any named streams or other
@@ -1155,10 +1204,9 @@ static int ntfs_read_locked_inode(struct inode *vi)
 		vi->i_blocks = ni->itype.compressed.size >> 9;
 	else
 		vi->i_blocks = ni->allocated_size >> 9;
+
 	ntfs_debug("Done.");
 	return 0;
-iput_unm_err_out:
-	iput(bvi);
 unm_err_out:
 	if (!err)
 		err = -EIO;
@@ -1167,11 +1215,12 @@ static int ntfs_read_locked_inode(struct inode *vi)
 	if (m)
 		unmap_mft_record(ni);
 err_out:
-	ntfs_error(vol->sb, "Failed with error code %i.  Marking corrupt "
-			"inode 0x%lx as bad.  Run chkdsk.", err, vi->i_ino);
-	make_bad_inode(vi);
-	if (err != -EOPNOTSUPP && err != -ENOMEM)
+	if (err != -EOPNOTSUPP && err != -ENOMEM && vol_err == true) {
+		ntfs_error(vol->sb,
+			"Failed with error code %i.  Marking corrupt inode 0x%lx as bad.  Run chkdsk.",
+			err, vi->i_ino);
 		NVolSetErrors(vol);
+	}
 	return err;
 }
 
@@ -1192,27 +1241,23 @@ static int ntfs_read_locked_inode(struct inode *vi)
  * A: i_state has I_NEW set, hence the inode is locked, also
  *    i_count is set to 1, so it is not going to go away
  *
- * Return 0 on success and -errno on error.  In the error case, the inode will
- * have had make_bad_inode() executed on it.
+ * Return 0 on success and -errno on error.
  *
  * Note this cannot be called for AT_INDEX_ALLOCATION.
  */
 static int ntfs_read_locked_attr_inode(struct inode *base_vi, struct inode *vi)
 {
-	ntfs_volume *vol = NTFS_SB(vi->i_sb);
-	ntfs_inode *ni, *base_ni;
-	MFT_RECORD *m;
-	ATTR_RECORD *a;
-	ntfs_attr_search_ctx *ctx;
+	struct ntfs_volume *vol = NTFS_SB(vi->i_sb);
+	struct ntfs_inode *ni = NTFS_I(vi), *base_ni = NTFS_I(base_vi);
+	struct mft_record *m;
+	struct attr_record *a;
+	struct ntfs_attr_search_ctx *ctx;
 	int err = 0;
 
 	ntfs_debug("Entering for i_ino 0x%lx.", vi->i_ino);
 
 	ntfs_init_big_inode(vi);
 
-	ni	= NTFS_I(vi);
-	base_ni = NTFS_I(base_vi);
-
 	/* Just mirror the values from the base inode. */
 	vi->i_uid	= base_vi->i_uid;
 	vi->i_gid	= base_vi->i_gid;
@@ -1244,28 +1289,22 @@ static int ntfs_read_locked_attr_inode(struct inode *base_vi, struct inode *vi)
 	if (a->flags & (ATTR_COMPRESSION_MASK | ATTR_IS_SPARSE)) {
 		if (a->flags & ATTR_COMPRESSION_MASK) {
 			NInoSetCompressed(ni);
+			ni->flags |= FILE_ATTR_COMPRESSED;
 			if ((ni->type != AT_DATA) || (ni->type == AT_DATA &&
 					ni->name_len)) {
-				ntfs_error(vi->i_sb, "Found compressed "
-						"non-data or named data "
-						"attribute.  Please report "
-						"you saw this message to "
-						"linux-ntfs-dev@lists."
-						"sourceforge.net");
+				ntfs_error(vi->i_sb,
+					   "Found compressed non-data or named data attribute.");
 				goto unm_err_out;
 			}
 			if (vol->cluster_size > 4096) {
-				ntfs_error(vi->i_sb, "Found compressed "
-						"attribute but compression is "
-						"disabled due to cluster size "
-						"(%i) > 4kiB.",
-						vol->cluster_size);
+				ntfs_error(vi->i_sb,
+					"Found compressed attribute but compression is disabled due to cluster size (%i) > 4kiB.",
+					vol->cluster_size);
 				goto unm_err_out;
 			}
 			if ((a->flags & ATTR_COMPRESSION_MASK) !=
 					ATTR_IS_COMPRESSED) {
-				ntfs_error(vi->i_sb, "Found unknown "
-						"compression method.");
+				ntfs_error(vi->i_sb, "Found unknown compression method.");
 				goto unm_err_out;
 			}
 		}
@@ -1274,21 +1313,19 @@ static int ntfs_read_locked_attr_inode(struct inode *base_vi, struct inode *vi)
 		 * to compress all files.
 		 */
 		if (NInoMstProtected(ni) && ni->type != AT_INDEX_ROOT) {
-			ntfs_error(vi->i_sb, "Found mst protected attribute "
-					"but the attribute is %s.  Please "
-					"report you saw this message to "
-					"linux-ntfs-dev@lists.sourceforge.net",
-					NInoCompressed(ni) ? "compressed" :
-					"sparse");
+			ntfs_error(vi->i_sb,
+				"Found mst protected attribute but the attribute is %s.",
+				NInoCompressed(ni) ? "compressed" : "sparse");
 			goto unm_err_out;
 		}
-		if (a->flags & ATTR_IS_SPARSE)
+		if (a->flags & ATTR_IS_SPARSE) {
 			NInoSetSparse(ni);
+			ni->flags |= FILE_ATTR_SPARSE_FILE;
+		}
 	}
 	if (a->flags & ATTR_IS_ENCRYPTED) {
 		if (NInoCompressed(ni)) {
-			ntfs_error(vi->i_sb, "Found encrypted and compressed "
-					"data.");
+			ntfs_error(vi->i_sb, "Found encrypted and compressed data.");
 			goto unm_err_out;
 		}
 		/*
@@ -1296,42 +1333,38 @@ static int ntfs_read_locked_attr_inode(struct inode *base_vi, struct inode *vi)
 		 * encrypt all files.
 		 */
 		if (NInoMstProtected(ni) && ni->type != AT_INDEX_ROOT) {
-			ntfs_error(vi->i_sb, "Found mst protected attribute "
-					"but the attribute is encrypted.  "
-					"Please report you saw this message "
-					"to linux-ntfs-dev@lists.sourceforge."
-					"net");
+			ntfs_error(vi->i_sb,
+				"Found mst protected attribute but the attribute is encrypted.");
 			goto unm_err_out;
 		}
 		if (ni->type != AT_DATA) {
-			ntfs_error(vi->i_sb, "Found encrypted non-data "
-					"attribute.");
+			ntfs_error(vi->i_sb,
+				"Found encrypted non-data attribute.");
 			goto unm_err_out;
 		}
 		NInoSetEncrypted(ni);
+		ni->flags |= FILE_ATTR_ENCRYPTED;
 	}
 	if (!a->non_resident) {
 		/* Ensure the attribute name is placed before the value. */
 		if (unlikely(a->name_length && (le16_to_cpu(a->name_offset) >=
 				le16_to_cpu(a->data.resident.value_offset)))) {
-			ntfs_error(vol->sb, "Attribute name is placed after "
-					"the attribute value.");
+			ntfs_error(vol->sb,
+				"Attribute name is placed after the attribute value.");
 			goto unm_err_out;
 		}
 		if (NInoMstProtected(ni)) {
-			ntfs_error(vi->i_sb, "Found mst protected attribute "
-					"but the attribute is resident.  "
-					"Please report you saw this message to "
-					"linux-ntfs-dev@lists.sourceforge.net");
+			ntfs_error(vi->i_sb,
+				"Found mst protected attribute but the attribute is resident.");
 			goto unm_err_out;
 		}
-		vi->i_size = ni->initialized_size = le32_to_cpu(
+		vi->i_size = ni->initialized_size = ni->data_size = le32_to_cpu(
 				a->data.resident.value_length);
 		ni->allocated_size = le32_to_cpu(a->length) -
 				le16_to_cpu(a->data.resident.value_offset);
 		if (vi->i_size > ni->allocated_size) {
-			ntfs_error(vi->i_sb, "Resident attribute is corrupt "
-					"(size exceeds allocation).");
+			ntfs_error(vi->i_sb,
+				"Resident attribute is corrupt (size exceeds allocation).");
 			goto unm_err_out;
 		}
 	} else {
@@ -1343,56 +1376,43 @@ static int ntfs_read_locked_attr_inode(struct inode *base_vi, struct inode *vi)
 		if (unlikely(a->name_length && (le16_to_cpu(a->name_offset) >=
 				le16_to_cpu(
 				a->data.non_resident.mapping_pairs_offset)))) {
-			ntfs_error(vol->sb, "Attribute name is placed after "
-					"the mapping pairs array.");
+			ntfs_error(vol->sb,
+				"Attribute name is placed after the mapping pairs array.");
 			goto unm_err_out;
 		}
 		if (NInoCompressed(ni) || NInoSparse(ni)) {
-			if (NInoCompressed(ni) && a->data.non_resident.
-					compression_unit != 4) {
-				ntfs_error(vi->i_sb, "Found non-standard "
-						"compression unit (%u instead "
-						"of 4).  Cannot handle this.",
-						a->data.non_resident.
-						compression_unit);
+			if (NInoCompressed(ni) && a->data.non_resident.compression_unit != 4) {
+				ntfs_error(vi->i_sb,
+					"Found non-standard compression unit (%u instead of 4).  Cannot handle this.",
+					a->data.non_resident.compression_unit);
 				err = -EOPNOTSUPP;
 				goto unm_err_out;
 			}
 			if (a->data.non_resident.compression_unit) {
 				ni->itype.compressed.block_size = 1U <<
-						(a->data.non_resident.
-						compression_unit +
+						(a->data.non_resident.compression_unit +
 						vol->cluster_size_bits);
 				ni->itype.compressed.block_size_bits =
-						ffs(ni->itype.compressed.
-						block_size) - 1;
+						ffs(ni->itype.compressed.block_size) - 1;
 				ni->itype.compressed.block_clusters = 1U <<
-						a->data.non_resident.
-						compression_unit;
+						a->data.non_resident.compression_unit;
 			} else {
 				ni->itype.compressed.block_size = 0;
 				ni->itype.compressed.block_size_bits = 0;
 				ni->itype.compressed.block_clusters = 0;
 			}
-			ni->itype.compressed.size = sle64_to_cpu(
+			ni->itype.compressed.size = le64_to_cpu(
 					a->data.non_resident.compressed_size);
 		}
 		if (a->data.non_resident.lowest_vcn) {
-			ntfs_error(vi->i_sb, "First extent of attribute has "
-					"non-zero lowest_vcn.");
+			ntfs_error(vi->i_sb, "First extent of attribute has non-zero lowest_vcn.");
 			goto unm_err_out;
 		}
-		vi->i_size = sle64_to_cpu(a->data.non_resident.data_size);
-		ni->initialized_size = sle64_to_cpu(
-				a->data.non_resident.initialized_size);
-		ni->allocated_size = sle64_to_cpu(
-				a->data.non_resident.allocated_size);
-	}
-	vi->i_mapping->a_ops = &ntfs_normal_aops;
-	if (NInoMstProtected(ni))
-		vi->i_mapping->a_ops = &ntfs_mst_aops;
-	else if (NInoCompressed(ni))
-		vi->i_mapping->a_ops = &ntfs_compressed_aops;
+		vi->i_size = ni->data_size = le64_to_cpu(a->data.non_resident.data_size);
+		ni->initialized_size = le64_to_cpu(a->data.non_resident.initialized_size);
+		ni->allocated_size = le64_to_cpu(a->data.non_resident.allocated_size);
+	}
+	vi->i_mapping->a_ops = &ntfs_aops;
 	if ((NInoCompressed(ni) || NInoSparse(ni)) && ni->type != AT_INDEX_ROOT)
 		vi->i_blocks = ni->itype.compressed.size >> 9;
 	else
@@ -1401,7 +1421,10 @@ static int ntfs_read_locked_attr_inode(struct inode *base_vi, struct inode *vi)
 	 * Make sure the base inode does not go away and attach it to the
 	 * attribute inode.
 	 */
-	igrab(base_vi);
+	if (!igrab(base_vi)) {
+		err = -ENOENT;
+		goto unm_err_out;
+	}
 	ni->ext.base_ntfs_ino = base_ni;
 	ni->nr_extents = -1;
 
@@ -1418,13 +1441,12 @@ static int ntfs_read_locked_attr_inode(struct inode *base_vi, struct inode *vi)
 		ntfs_attr_put_search_ctx(ctx);
 	unmap_mft_record(base_ni);
 err_out:
-	ntfs_error(vol->sb, "Failed with error code %i while reading attribute "
-			"inode (mft_no 0x%lx, type 0x%x, name_len %i).  "
-			"Marking corrupt inode and base inode 0x%lx as bad.  "
-			"Run chkdsk.", err, vi->i_ino, ni->type, ni->name_len,
+	if (err != -ENOENT)
+		ntfs_error(vol->sb,
+			"Failed with error code %i while reading attribute inode (mft_no 0x%lx, type 0x%x, name_len %i).  Marking corrupt inode and base inode 0x%lx as bad.  Run chkdsk.",
+			err, vi->i_ino, ni->type, ni->name_len,
 			base_vi->i_ino);
-	make_bad_inode(vi);
-	if (err != -ENOMEM)
+	if (err != -ENOENT && err != -ENOMEM)
 		NVolSetErrors(vol);
 	return err;
 }
@@ -1459,26 +1481,25 @@ static int ntfs_read_locked_attr_inode(struct inode *base_vi, struct inode *vi)
  * A: i_state has I_NEW set, hence the inode is locked, also
  *    i_count is set to 1, so it is not going to go away
  *
- * Return 0 on success and -errno on error.  In the error case, the inode will
- * have had make_bad_inode() executed on it.
+ * Return 0 on success and -errno on error.
  */
 static int ntfs_read_locked_index_inode(struct inode *base_vi, struct inode *vi)
 {
 	loff_t bvi_size;
-	ntfs_volume *vol = NTFS_SB(vi->i_sb);
-	ntfs_inode *ni, *base_ni, *bni;
+	struct ntfs_volume *vol = NTFS_SB(vi->i_sb);
+	struct ntfs_inode *ni = NTFS_I(vi), *base_ni = NTFS_I(base_vi), *bni;
 	struct inode *bvi;
-	MFT_RECORD *m;
-	ATTR_RECORD *a;
-	ntfs_attr_search_ctx *ctx;
-	INDEX_ROOT *ir;
+	struct mft_record *m;
+	struct attr_record *a;
+	struct ntfs_attr_search_ctx *ctx;
+	struct index_root *ir;
 	u8 *ir_end, *index_end;
 	int err = 0;
 
 	ntfs_debug("Entering for i_ino 0x%lx.", vi->i_ino);
+	lockdep_assert_held(&base_ni->mrec_lock);
+
 	ntfs_init_big_inode(vi);
-	ni	= NTFS_I(vi);
-	base_ni = NTFS_I(base_vi);
 	/* Just mirror the values from the base inode. */
 	vi->i_uid	= base_vi->i_uid;
 	vi->i_gid	= base_vi->i_gid;
@@ -1505,8 +1526,7 @@ static int ntfs_read_locked_index_inode(struct inode *base_vi, struct inode *vi)
 			CASE_SENSITIVE, 0, NULL, 0, ctx);
 	if (unlikely(err)) {
 		if (err == -ENOENT)
-			ntfs_error(vi->i_sb, "$INDEX_ROOT attribute is "
-					"missing.");
+			ntfs_error(vi->i_sb, "$INDEX_ROOT attribute is missing.");
 		goto unm_err_out;
 	}
 	a = ctx->attr;
@@ -1518,55 +1538,41 @@ static int ntfs_read_locked_index_inode(struct inode *base_vi, struct inode *vi)
 	/* Ensure the attribute name is placed before the value. */
 	if (unlikely(a->name_length && (le16_to_cpu(a->name_offset) >=
 			le16_to_cpu(a->data.resident.value_offset)))) {
-		ntfs_error(vol->sb, "$INDEX_ROOT attribute name is placed "
-				"after the attribute value.");
-		goto unm_err_out;
-	}
-	/*
-	 * Compressed/encrypted/sparse index root is not allowed, except for
-	 * directories of course but those are not dealt with here.
-	 */
-	if (a->flags & (ATTR_COMPRESSION_MASK | ATTR_IS_ENCRYPTED |
-			ATTR_IS_SPARSE)) {
-		ntfs_error(vi->i_sb, "Found compressed/encrypted/sparse index "
-				"root attribute.");
+		ntfs_error(vol->sb,
+			"$INDEX_ROOT attribute name is placed after the attribute value.");
 		goto unm_err_out;
 	}
-	ir = (INDEX_ROOT*)((u8*)a + le16_to_cpu(a->data.resident.value_offset));
-	ir_end = (u8*)ir + le32_to_cpu(a->data.resident.value_length);
-	if (ir_end > (u8*)ctx->mrec + vol->mft_record_size) {
+
+	ir = (struct index_root *)((u8 *)a + le16_to_cpu(a->data.resident.value_offset));
+	ir_end = (u8 *)ir + le32_to_cpu(a->data.resident.value_length);
+	if (ir_end > (u8 *)ctx->mrec + vol->mft_record_size) {
 		ntfs_error(vi->i_sb, "$INDEX_ROOT attribute is corrupt.");
 		goto unm_err_out;
 	}
-	index_end = (u8*)&ir->index + le32_to_cpu(ir->index.index_length);
+	index_end = (u8 *)&ir->index + le32_to_cpu(ir->index.index_length);
 	if (index_end > ir_end) {
 		ntfs_error(vi->i_sb, "Index is corrupt.");
 		goto unm_err_out;
 	}
-	if (ir->type) {
-		ntfs_error(vi->i_sb, "Index type is not 0 (type is 0x%x).",
-				le32_to_cpu(ir->type));
-		goto unm_err_out;
-	}
+
 	ni->itype.index.collation_rule = ir->collation_rule;
 	ntfs_debug("Index collation rule is 0x%x.",
 			le32_to_cpu(ir->collation_rule));
 	ni->itype.index.block_size = le32_to_cpu(ir->index_block_size);
 	if (!is_power_of_2(ni->itype.index.block_size)) {
-		ntfs_error(vi->i_sb, "Index block size (%u) is not a power of "
-				"two.", ni->itype.index.block_size);
+		ntfs_error(vi->i_sb, "Index block size (%u) is not a power of two.",
+				ni->itype.index.block_size);
 		goto unm_err_out;
 	}
 	if (ni->itype.index.block_size > PAGE_SIZE) {
-		ntfs_error(vi->i_sb, "Index block size (%u) > PAGE_SIZE "
-				"(%ld) is not supported.  Sorry.",
+		ntfs_error(vi->i_sb, "Index block size (%u) > PAGE_SIZE (%ld) is not supported.",
 				ni->itype.index.block_size, PAGE_SIZE);
 		err = -EOPNOTSUPP;
 		goto unm_err_out;
 	}
 	if (ni->itype.index.block_size < NTFS_BLOCK_SIZE) {
-		ntfs_error(vi->i_sb, "Index block size (%u) < NTFS_BLOCK_SIZE "
-				"(%i) is not supported.  Sorry.",
+		ntfs_error(vi->i_sb,
+				"Index block size (%u) < NTFS_BLOCK_SIZE (%i) is not supported.",
 				ni->itype.index.block_size, NTFS_BLOCK_SIZE);
 		err = -EOPNOTSUPP;
 		goto unm_err_out;
@@ -1580,51 +1586,45 @@ static int ntfs_read_locked_index_inode(struct inode *base_vi, struct inode *vi)
 		ni->itype.index.vcn_size = vol->sector_size;
 		ni->itype.index.vcn_size_bits = vol->sector_size_bits;
 	}
-	/* Check for presence of index allocation attribute. */
-	if (!(ir->index.flags & LARGE_INDEX)) {
-		/* No index allocation. */
-		vi->i_size = ni->initialized_size = ni->allocated_size = 0;
-		/* We are done with the mft record, so we release it. */
-		ntfs_attr_put_search_ctx(ctx);
-		unmap_mft_record(base_ni);
-		m = NULL;
-		ctx = NULL;
-		goto skip_large_index_stuff;
-	} /* LARGE_INDEX:  Index allocation present.  Setup state. */
-	NInoSetIndexAllocPresent(ni);
+
 	/* Find index allocation attribute. */
 	ntfs_attr_reinit_search_ctx(ctx);
 	err = ntfs_attr_lookup(AT_INDEX_ALLOCATION, ni->name, ni->name_len,
 			CASE_SENSITIVE, 0, NULL, 0, ctx);
 	if (unlikely(err)) {
-		if (err == -ENOENT)
-			ntfs_error(vi->i_sb, "$INDEX_ALLOCATION attribute is "
-					"not present but $INDEX_ROOT "
-					"indicated it is.");
-		else
-			ntfs_error(vi->i_sb, "Failed to lookup "
-					"$INDEX_ALLOCATION attribute.");
+		if (err == -ENOENT) {
+			/* No index allocation. */
+			vi->i_size = ni->initialized_size = ni->allocated_size = 0;
+			/* We are done with the mft record, so we release it. */
+			ntfs_attr_put_search_ctx(ctx);
+			unmap_mft_record(base_ni);
+			m = NULL;
+			ctx = NULL;
+			goto skip_large_index_stuff;
+		} else
+			ntfs_error(vi->i_sb, "Failed to lookup $INDEX_ALLOCATION attribute.");
 		goto unm_err_out;
 	}
+	NInoSetIndexAllocPresent(ni);
+	NInoSetNonResident(ni);
+	ni->type = AT_INDEX_ALLOCATION;
+
 	a = ctx->attr;
 	if (!a->non_resident) {
-		ntfs_error(vi->i_sb, "$INDEX_ALLOCATION attribute is "
-				"resident.");
+		ntfs_error(vi->i_sb, "$INDEX_ALLOCATION attribute is resident.");
 		goto unm_err_out;
 	}
 	/*
 	 * Ensure the attribute name is placed before the mapping pairs array.
 	 */
 	if (unlikely(a->name_length && (le16_to_cpu(a->name_offset) >=
-			le16_to_cpu(
-			a->data.non_resident.mapping_pairs_offset)))) {
-		ntfs_error(vol->sb, "$INDEX_ALLOCATION attribute name is "
-				"placed after the mapping pairs array.");
+			le16_to_cpu(a->data.non_resident.mapping_pairs_offset)))) {
+		ntfs_error(vol->sb,
+			"$INDEX_ALLOCATION attribute name is placed after the mapping pairs array.");
 		goto unm_err_out;
 	}
 	if (a->flags & ATTR_IS_ENCRYPTED) {
-		ntfs_error(vi->i_sb, "$INDEX_ALLOCATION attribute is "
-				"encrypted.");
+		ntfs_error(vi->i_sb, "$INDEX_ALLOCATION attribute is encrypted.");
 		goto unm_err_out;
 	}
 	if (a->flags & ATTR_IS_SPARSE) {
@@ -1632,19 +1632,18 @@ static int ntfs_read_locked_index_inode(struct inode *base_vi, struct inode *vi)
 		goto unm_err_out;
 	}
 	if (a->flags & ATTR_COMPRESSION_MASK) {
-		ntfs_error(vi->i_sb, "$INDEX_ALLOCATION attribute is "
-				"compressed.");
+		ntfs_error(vi->i_sb,
+			"$INDEX_ALLOCATION attribute is compressed.");
 		goto unm_err_out;
 	}
 	if (a->data.non_resident.lowest_vcn) {
-		ntfs_error(vi->i_sb, "First extent of $INDEX_ALLOCATION "
-				"attribute has non zero lowest_vcn.");
+		ntfs_error(vi->i_sb,
+			"First extent of $INDEX_ALLOCATION attribute has non zero lowest_vcn.");
 		goto unm_err_out;
 	}
-	vi->i_size = sle64_to_cpu(a->data.non_resident.data_size);
-	ni->initialized_size = sle64_to_cpu(
-			a->data.non_resident.initialized_size);
-	ni->allocated_size = sle64_to_cpu(a->data.non_resident.allocated_size);
+	vi->i_size = ni->data_size = le64_to_cpu(a->data.non_resident.data_size);
+	ni->initialized_size = le64_to_cpu(a->data.non_resident.initialized_size);
+	ni->allocated_size = le64_to_cpu(a->data.non_resident.allocated_size);
 	/*
 	 * We are done with the mft record, so we release it.  Otherwise
 	 * we would deadlock in ntfs_attr_iget().
@@ -1663,28 +1662,29 @@ static int ntfs_read_locked_index_inode(struct inode *base_vi, struct inode *vi)
 	bni = NTFS_I(bvi);
 	if (NInoCompressed(bni) || NInoEncrypted(bni) ||
 			NInoSparse(bni)) {
-		ntfs_error(vi->i_sb, "$BITMAP attribute is compressed and/or "
-				"encrypted and/or sparse.");
+		ntfs_error(vi->i_sb,
+			"$BITMAP attribute is compressed and/or encrypted and/or sparse.");
 		goto iput_unm_err_out;
 	}
 	/* Consistency check bitmap size vs. index allocation size. */
 	bvi_size = i_size_read(bvi);
 	if ((bvi_size << 3) < (vi->i_size >> ni->itype.index.block_size_bits)) {
-		ntfs_error(vi->i_sb, "Index bitmap too small (0x%llx) for "
-				"index allocation (0x%llx).", bvi_size << 3,
-				vi->i_size);
+		ntfs_error(vi->i_sb,
+			"Index bitmap too small (0x%llx) for index allocation (0x%llx).",
+			bvi_size << 3, vi->i_size);
 		goto iput_unm_err_out;
 	}
 	iput(bvi);
 skip_large_index_stuff:
 	/* Setup the operations for this index inode. */
-	vi->i_mapping->a_ops = &ntfs_mst_aops;
+	ntfs_set_vfs_operations(vi, S_IFDIR, 0);
 	vi->i_blocks = ni->allocated_size >> 9;
 	/*
 	 * Make sure the base inode doesn't go away and attach it to the
 	 * index inode.
 	 */
-	igrab(base_vi);
+	if (!igrab(base_vi))
+		goto unm_err_out;
 	ni->ext.base_ntfs_ino = base_ni;
 	ni->nr_extents = -1;
 
@@ -1700,29 +1700,110 @@ static int ntfs_read_locked_index_inode(struct inode *base_vi, struct inode *vi)
 	if (m)
 		unmap_mft_record(base_ni);
 err_out:
-	ntfs_error(vi->i_sb, "Failed with error code %i while reading index "
-			"inode (mft_no 0x%lx, name_len %i.", err, vi->i_ino,
-			ni->name_len);
-	make_bad_inode(vi);
+	ntfs_error(vi->i_sb,
+		"Failed with error code %i while reading index inode (mft_no 0x%lx, name_len %i.",
+		err, vi->i_ino, ni->name_len);
 	if (err != -EOPNOTSUPP && err != -ENOMEM)
 		NVolSetErrors(vol);
 	return err;
 }
 
-/*
- * The MFT inode has special locking, so teach the lock validator
- * about this by splitting off the locking rules of the MFT from
- * the locking rules of other inodes. The MFT inode can never be
- * accessed from the VFS side (or even internally), only by the
- * map_mft functions.
- */
-static struct lock_class_key mft_ni_runlist_lock_key, mft_ni_mrec_lock_key;
-
 /**
- * ntfs_read_inode_mount - special read_inode for mount time use only
- * @vi:		inode to read
+ * load_attribute_list_mount - load an attribute list into memory
+ * @vol:		ntfs volume from which to read
+ * @runlist:		runlist of the attribute list
+ * @al_start:		destination buffer
+ * @size:		size of the destination buffer in bytes
+ * @initialized_size:	initialized size of the attribute list
  *
- * Read inode FILE_MFT at mount time, only called with super_block lock
+ * Walk the runlist @runlist and load all clusters from it copying them into
+ * the linear buffer @al. The maximum number of bytes copied to @al is @size
+ * bytes. Note, @size does not need to be a multiple of the cluster size. If
+ * @initialized_size is less than @size, the region in @al between
+ * @initialized_size and @size will be zeroed and not read from disk.
+ *
+ * Return 0 on success or -errno on error.
+ */
+static int load_attribute_list_mount(struct ntfs_volume *vol,
+		struct runlist_element *rl, u8 *al_start, const s64 size,
+		const s64 initialized_size)
+{
+	s64 lcn;
+	u8 *al = al_start;
+	u8 *al_end = al + initialized_size;
+	struct super_block *sb;
+	int err = 0;
+	loff_t rl_byte_off, rl_byte_len;
+
+	ntfs_debug("Entering.");
+	if (!vol || !rl || !al || size <= 0 || initialized_size < 0 ||
+			initialized_size > size)
+		return -EINVAL;
+	if (!initialized_size) {
+		memset(al, 0, size);
+		return 0;
+	}
+	sb = vol->sb;
+
+	/* Read all clusters specified by the runlist one run at a time. */
+	while (rl->length) {
+		lcn = ntfs_rl_vcn_to_lcn(rl, rl->vcn);
+		ntfs_debug("Reading vcn = 0x%llx, lcn = 0x%llx.",
+				(unsigned long long)rl->vcn,
+				(unsigned long long)lcn);
+		/* The attribute list cannot be sparse. */
+		if (lcn < 0) {
+			ntfs_error(sb, "ntfs_rl_vcn_to_lcn() failed. Cannot read attribute list.");
+			goto err_out;
+		}
+
+		rl_byte_off = NTFS_CLU_TO_B(vol, lcn);
+		rl_byte_len = NTFS_CLU_TO_B(vol, rl->length);
+
+		if (al + rl_byte_len > al_end)
+			rl_byte_len = al_end - al;
+
+		err = ntfs_dev_read(sb, al, rl_byte_off, rl_byte_len);
+		if (err) {
+			ntfs_error(sb, "Cannot read attribute list.");
+			goto err_out;
+		}
+
+		if (al + rl_byte_len >= al_end) {
+			if (initialized_size < size)
+				goto initialize;
+			goto done;
+		}
+
+		al += rl_byte_len;
+		rl++;
+	}
+	if (initialized_size < size) {
+initialize:
+		memset(al_start + initialized_size, 0, size - initialized_size);
+	}
+done:
+	return err;
+	/* Real overflow! */
+	ntfs_error(sb, "Attribute list buffer overflow. Read attribute list is truncated.");
+err_out:
+	err = -EIO;
+	goto done;
+}
+/*
+ * The MFT inode has special locking, so teach the lock validator
+ * about this by splitting off the locking rules of the MFT from
+ * the locking rules of other inodes. The MFT inode can never be
+ * accessed from the VFS side (or even internally), only by the
+ * map_mft functions.
+ */
+static struct lock_class_key mft_ni_runlist_lock_key, mft_ni_mrec_lock_key;
+
+/**
+ * ntfs_read_inode_mount - special read_inode for mount time use only
+ * @vi:		inode to read
+ *
+ * Read inode FILE_MFT at mount time, only called with super_block lock
  * held from within the read_super() code path.
  *
  * This function exists because when it is called the page cache for $MFT/$DATA
@@ -1746,17 +1827,16 @@ static struct lock_class_key mft_ni_runlist_lock_key, mft_ni_mrec_lock_key;
  */
 int ntfs_read_inode_mount(struct inode *vi)
 {
-	VCN next_vcn, last_vcn, highest_vcn;
-	s64 block;
+	s64 next_vcn, last_vcn, highest_vcn;
 	struct super_block *sb = vi->i_sb;
-	ntfs_volume *vol = NTFS_SB(sb);
-	struct buffer_head *bh;
-	ntfs_inode *ni;
-	MFT_RECORD *m = NULL;
-	ATTR_RECORD *a;
-	ntfs_attr_search_ctx *ctx;
+	struct ntfs_volume *vol = NTFS_SB(sb);
+	struct ntfs_inode *ni;
+	struct mft_record *m = NULL;
+	struct attr_record *a;
+	struct ntfs_attr_search_ctx *ctx;
 	unsigned int i, nr_blocks;
 	int err;
+	size_t new_rl_count;
 
 	ntfs_debug("Entering.");
 
@@ -1770,7 +1850,7 @@ int ntfs_read_inode_mount(struct inode *vi)
 	NInoSetMstProtected(ni);
 	NInoSetSparseDisabled(ni);
 	ni->type = AT_DATA;
-	ni->name = NULL;
+	ni->name = AT_UNNAMED;
 	ni->name_len = 0;
 	/*
 	 * This sets up our little cheat allowing us to reuse the async read io
@@ -1788,32 +1868,27 @@ int ntfs_read_inode_mount(struct inode *vi)
 				vol->mft_record_size);
 		goto err_out;
 	}
+
 	i = vol->mft_record_size;
 	if (i < sb->s_blocksize)
 		i = sb->s_blocksize;
-	m = (MFT_RECORD*)ntfs_malloc_nofs(i);
+
+	m = (struct mft_record *)ntfs_malloc_nofs(i);
 	if (!m) {
 		ntfs_error(sb, "Failed to allocate buffer for $MFT record 0.");
 		goto err_out;
 	}
 
 	/* Determine the first block of the $MFT/$DATA attribute. */
-	block = vol->mft_lcn << vol->cluster_size_bits >>
-			sb->s_blocksize_bits;
-	nr_blocks = vol->mft_record_size >> sb->s_blocksize_bits;
+	nr_blocks = NTFS_B_TO_SECTOR(vol, vol->mft_record_size);
 	if (!nr_blocks)
 		nr_blocks = 1;
 
 	/* Load $MFT/$DATA's first mft record. */
-	for (i = 0; i < nr_blocks; i++) {
-		bh = sb_bread(sb, block++);
-		if (!bh) {
-			ntfs_error(sb, "Device read failed.");
-			goto err_out;
-		}
-		memcpy((char*)m + (i << sb->s_blocksize_bits), bh->b_data,
-				sb->s_blocksize);
-		brelse(bh);
+	err = ntfs_dev_read(sb, m, NTFS_CLU_TO_B(vol, vol->mft_lcn), i);
+	if (err) {
+		ntfs_error(sb, "Device read failed.");
+		goto err_out;
 	}
 
 	if (le32_to_cpu(m->bytes_allocated) != vol->mft_record_size) {
@@ -1823,16 +1898,13 @@ int ntfs_read_inode_mount(struct inode *vi)
 	}
 
 	/* Apply the mst fixups. */
-	if (post_read_mst_fixup((NTFS_RECORD*)m, vol->mft_record_size)) {
-		/* FIXME: Try to use the $MFTMirr now. */
+	if (post_read_mst_fixup((struct ntfs_record *)m, vol->mft_record_size)) {
 		ntfs_error(sb, "MST fixup failed. $MFT is corrupt.");
 		goto err_out;
 	}
 
-	/* Sanity check offset to the first attribute */
-	if (le16_to_cpu(m->attrs_offset) >= le32_to_cpu(m->bytes_allocated)) {
-		ntfs_error(sb, "Incorrect mft offset to the first attribute %u in superblock.",
-			       le16_to_cpu(m->attrs_offset));
+	if (ntfs_mft_record_check(vol, m, FILE_MFT)) {
+		ntfs_error(sb, "ntfs_mft_record_check failed. $MFT is corrupt.");
 		goto err_out;
 	}
 
@@ -1840,7 +1912,7 @@ int ntfs_read_inode_mount(struct inode *vi)
 	vi->i_generation = ni->seq_no = le16_to_cpu(m->sequence_number);
 
 	/* Provides read_folio() for map_mft_record(). */
-	vi->i_mapping->a_ops = &ntfs_mst_aops;
+	vi->i_mapping->a_ops = &ntfs_aops;
 
 	ctx = ntfs_attr_get_search_ctx(ni, m);
 	if (!ctx) {
@@ -1852,39 +1924,34 @@ int ntfs_read_inode_mount(struct inode *vi)
 	err = ntfs_attr_lookup(AT_ATTRIBUTE_LIST, NULL, 0, 0, 0, NULL, 0, ctx);
 	if (err) {
 		if (unlikely(err != -ENOENT)) {
-			ntfs_error(sb, "Failed to lookup attribute list "
-					"attribute. You should run chkdsk.");
+			ntfs_error(sb,
+				"Failed to lookup attribute list attribute. You should run chkdsk.");
 			goto put_err_out;
 		}
 	} else /* if (!err) */ {
-		ATTR_LIST_ENTRY *al_entry, *next_al_entry;
+		struct attr_list_entry *al_entry, *next_al_entry;
 		u8 *al_end;
-		static const char *es = "  Not allowed.  $MFT is corrupt.  "
-				"You should run chkdsk.";
+		static const char *es = "  Not allowed.  $MFT is corrupt.  You should run chkdsk.";
 
 		ntfs_debug("Attribute list attribute found in $MFT.");
 		NInoSetAttrList(ni);
 		a = ctx->attr;
 		if (a->flags & ATTR_COMPRESSION_MASK) {
-			ntfs_error(sb, "Attribute list attribute is "
-					"compressed.%s", es);
+			ntfs_error(sb,
+				"Attribute list attribute is compressed.%s",
+				es);
 			goto put_err_out;
 		}
 		if (a->flags & ATTR_IS_ENCRYPTED ||
 				a->flags & ATTR_IS_SPARSE) {
 			if (a->non_resident) {
-				ntfs_error(sb, "Non-resident attribute list "
-						"attribute is encrypted/"
-						"sparse.%s", es);
+				ntfs_error(sb,
+					"Non-resident attribute list attribute is encrypted/sparse.%s",
+					es);
 				goto put_err_out;
 			}
-			ntfs_warning(sb, "Resident attribute list attribute "
-					"in $MFT system file is marked "
-					"encrypted/sparse which is not true.  "
-					"However, Windows allows this and "
-					"chkdsk does not detect or correct it "
-					"so we will just ignore the invalid "
-					"flags and pretend they are not set.");
+			ntfs_warning(sb,
+				"Resident attribute list attribute in $MFT system file is marked encrypted/sparse which is not true.  However, Windows allows this and chkdsk does not detect or correct it so we will just ignore the invalid flags and pretend they are not set.");
 		}
 		/* Now allocate memory for the attribute list. */
 		ni->attr_list_size = (u32)ntfs_attr_size(a);
@@ -1894,87 +1961,72 @@ int ntfs_read_inode_mount(struct inode *vi)
 		}
 		ni->attr_list = ntfs_malloc_nofs(ni->attr_list_size);
 		if (!ni->attr_list) {
-			ntfs_error(sb, "Not enough memory to allocate buffer "
-					"for attribute list.");
+			ntfs_error(sb, "Not enough memory to allocate buffer for attribute list.");
 			goto put_err_out;
 		}
 		if (a->non_resident) {
+			struct runlist_element *rl;
+			size_t new_rl_count;
+
 			NInoSetAttrListNonResident(ni);
 			if (a->data.non_resident.lowest_vcn) {
-				ntfs_error(sb, "Attribute list has non zero "
-						"lowest_vcn. $MFT is corrupt. "
-						"You should run chkdsk.");
+				ntfs_error(sb,
+					"Attribute list has non zero lowest_vcn. $MFT is corrupt. You should run chkdsk.");
 				goto put_err_out;
 			}
-			/* Setup the runlist. */
-			ni->attr_list_rl.rl = ntfs_mapping_pairs_decompress(vol,
-					a, NULL);
-			if (IS_ERR(ni->attr_list_rl.rl)) {
-				err = PTR_ERR(ni->attr_list_rl.rl);
-				ni->attr_list_rl.rl = NULL;
-				ntfs_error(sb, "Mapping pairs decompression "
-						"failed with error code %i.",
-						-err);
+
+			rl = ntfs_mapping_pairs_decompress(vol, a, NULL, &new_rl_count);
+			if (IS_ERR(rl)) {
+				err = PTR_ERR(rl);
+				ntfs_error(sb,
+					   "Mapping pairs decompression failed with error code %i.",
+					   -err);
 				goto put_err_out;
 			}
-			/* Now load the attribute list. */
-			if ((err = load_attribute_list(vol, &ni->attr_list_rl,
-					ni->attr_list, ni->attr_list_size,
-					sle64_to_cpu(a->data.
-					non_resident.initialized_size)))) {
-				ntfs_error(sb, "Failed to load attribute list "
-						"attribute with error code %i.",
-						-err);
+
+			err = load_attribute_list_mount(vol, rl, ni->attr_list, ni->attr_list_size,
+					le64_to_cpu(a->data.non_resident.initialized_size));
+			ntfs_free(rl);
+			if (err) {
+				ntfs_error(sb,
+					   "Failed to load attribute list with error code %i.",
+					   -err);
 				goto put_err_out;
 			}
 		} else /* if (!ctx.attr->non_resident) */ {
-			if ((u8*)a + le16_to_cpu(
+			if ((u8 *)a + le16_to_cpu(
 					a->data.resident.value_offset) +
-					le32_to_cpu(
-					a->data.resident.value_length) >
-					(u8*)ctx->mrec + vol->mft_record_size) {
-				ntfs_error(sb, "Corrupt attribute list "
-						"attribute.");
+					le32_to_cpu(a->data.resident.value_length) >
+					(u8 *)ctx->mrec + vol->mft_record_size) {
+				ntfs_error(sb, "Corrupt attribute list attribute.");
 				goto put_err_out;
 			}
 			/* Now copy the attribute list. */
-			memcpy(ni->attr_list, (u8*)a + le16_to_cpu(
+			memcpy(ni->attr_list, (u8 *)a + le16_to_cpu(
 					a->data.resident.value_offset),
-					le32_to_cpu(
-					a->data.resident.value_length));
+					le32_to_cpu(a->data.resident.value_length));
 		}
 		/* The attribute list is now setup in memory. */
-		/*
-		 * FIXME: I don't know if this case is actually possible.
-		 * According to logic it is not possible but I have seen too
-		 * many weird things in MS software to rely on logic... Thus we
-		 * perform a manual search and make sure the first $MFT/$DATA
-		 * extent is in the base inode. If it is not we abort with an
-		 * error and if we ever see a report of this error we will need
-		 * to do some magic in order to have the necessary mft record
-		 * loaded and in the right place in the page cache. But
-		 * hopefully logic will prevail and this never happens...
-		 */
-		al_entry = (ATTR_LIST_ENTRY*)ni->attr_list;
-		al_end = (u8*)al_entry + ni->attr_list_size;
+		al_entry = (struct attr_list_entry *)ni->attr_list;
+		al_end = (u8 *)al_entry + ni->attr_list_size;
 		for (;; al_entry = next_al_entry) {
 			/* Out of bounds check. */
-			if ((u8*)al_entry < ni->attr_list ||
-					(u8*)al_entry > al_end)
+			if ((u8 *)al_entry < ni->attr_list ||
+					(u8 *)al_entry > al_end)
 				goto em_put_err_out;
 			/* Catch the end of the attribute list. */
-			if ((u8*)al_entry == al_end)
+			if ((u8 *)al_entry == al_end)
 				goto em_put_err_out;
 			if (!al_entry->length)
 				goto em_put_err_out;
-			if ((u8*)al_entry + 6 > al_end || (u8*)al_entry +
-					le16_to_cpu(al_entry->length) > al_end)
+			if ((u8 *)al_entry + 6 > al_end ||
+			    (u8 *)al_entry + le16_to_cpu(al_entry->length) > al_end)
 				goto em_put_err_out;
-			next_al_entry = (ATTR_LIST_ENTRY*)((u8*)al_entry +
+			next_al_entry = (struct attr_list_entry *)((u8 *)al_entry +
 					le16_to_cpu(al_entry->length));
 			if (le32_to_cpu(al_entry->type) > le32_to_cpu(AT_DATA))
 				goto em_put_err_out;
-			if (AT_DATA != al_entry->type)
+			if (al_entry->type != AT_DATA)
 				continue;
 			/* We want an unnamed attribute. */
 			if (al_entry->name_length)
@@ -1985,12 +2037,8 @@ int ntfs_read_inode_mount(struct inode *vi)
 			/* First entry has to be in the base mft record. */
 			if (MREF_LE(al_entry->mft_reference) != vi->i_ino) {
 				/* MFT references do not match, logic fails. */
-				ntfs_error(sb, "BUG: The first $DATA extent "
-						"of $MFT is not in the base "
-						"mft record. Please report "
-						"you saw this message to "
-						"linux-ntfs-dev@lists."
-						"sourceforge.net");
+				ntfs_error(sb,
+					"BUG: The first $DATA extent of $MFT is not in the base mft record.");
 				goto put_err_out;
 			} else {
 				/* Sequence numbers must match. */
@@ -2010,26 +2058,22 @@ int ntfs_read_inode_mount(struct inode *vi)
 	next_vcn = last_vcn = highest_vcn = 0;
 	while (!(err = ntfs_attr_lookup(AT_DATA, NULL, 0, 0, next_vcn, NULL, 0,
 			ctx))) {
-		runlist_element *nrl;
+		struct runlist_element *nrl;
 
 		/* Cache the current attribute. */
 		a = ctx->attr;
 		/* $MFT must be non-resident. */
 		if (!a->non_resident) {
-			ntfs_error(sb, "$MFT must be non-resident but a "
-					"resident extent was found. $MFT is "
-					"corrupt. Run chkdsk.");
+			ntfs_error(sb,
+				"$MFT must be non-resident but a resident extent was found. $MFT is corrupt. Run chkdsk.");
 			goto put_err_out;
 		}
 		/* $MFT must be uncompressed and unencrypted. */
 		if (a->flags & ATTR_COMPRESSION_MASK ||
 				a->flags & ATTR_IS_ENCRYPTED ||
 				a->flags & ATTR_IS_SPARSE) {
-			ntfs_error(sb, "$MFT must be uncompressed, "
-					"non-sparse, and unencrypted but a "
-					"compressed/sparse/encrypted extent "
-					"was found. $MFT is corrupt. Run "
-					"chkdsk.");
+			ntfs_error(sb,
+				"$MFT must be uncompressed, non-sparse, and unencrypted but a compressed/sparse/encrypted extent was found. $MFT is corrupt. Run chkdsk.");
 			goto put_err_out;
 		}
 		/*
@@ -2038,35 +2082,31 @@ int ntfs_read_inode_mount(struct inode *vi)
 		 * as we have exclusive access to the inode at this time and we
 		 * are a mount in progress task, too.
 		 */
-		nrl = ntfs_mapping_pairs_decompress(vol, a, ni->runlist.rl);
+		nrl = ntfs_mapping_pairs_decompress(vol, a, &ni->runlist,
+						    &new_rl_count);
 		if (IS_ERR(nrl)) {
-			ntfs_error(sb, "ntfs_mapping_pairs_decompress() "
-					"failed with error code %ld.  $MFT is "
-					"corrupt.", PTR_ERR(nrl));
+			ntfs_error(sb,
+				"ntfs_mapping_pairs_decompress() failed with error code %ld.",
+				PTR_ERR(nrl));
 			goto put_err_out;
 		}
 		ni->runlist.rl = nrl;
+		ni->runlist.count = new_rl_count;
 
 		/* Are we in the first extent? */
 		if (!next_vcn) {
 			if (a->data.non_resident.lowest_vcn) {
-				ntfs_error(sb, "First extent of $DATA "
-						"attribute has non zero "
-						"lowest_vcn. $MFT is corrupt. "
-						"You should run chkdsk.");
+				ntfs_error(sb,
+					"First extent of $DATA attribute has non zero lowest_vcn. $MFT is corrupt. You should run chkdsk.");
 				goto put_err_out;
 			}
 			/* Get the last vcn in the $DATA attribute. */
-			last_vcn = sle64_to_cpu(
-					a->data.non_resident.allocated_size)
-					>> vol->cluster_size_bits;
+			last_vcn = NTFS_B_TO_CLU(vol,
+					le64_to_cpu(a->data.non_resident.allocated_size));
 			/* Fill in the inode size. */
-			vi->i_size = sle64_to_cpu(
-					a->data.non_resident.data_size);
-			ni->initialized_size = sle64_to_cpu(
-					a->data.non_resident.initialized_size);
-			ni->allocated_size = sle64_to_cpu(
-					a->data.non_resident.allocated_size);
+			vi->i_size = le64_to_cpu(a->data.non_resident.data_size);
+			ni->initialized_size = le64_to_cpu(a->data.non_resident.initialized_size);
+			ni->allocated_size = le64_to_cpu(a->data.non_resident.allocated_size);
 			/*
 			 * Verify the number of mft records does not exceed
 			 * 2^32 - 1.
@@ -2095,15 +2135,9 @@ int ntfs_read_inode_mount(struct inode *vi)
 			 * ntfs_read_inode() on extents of $MFT/$DATA. But lets
 			 * hope this never happens...
 			 */
-			ntfs_read_locked_inode(vi);
-			if (is_bad_inode(vi)) {
-				ntfs_error(sb, "ntfs_read_inode() of $MFT "
-						"failed. BUG or corrupt $MFT. "
-						"Run chkdsk and if no errors "
-						"are found, please report you "
-						"saw this message to "
-						"linux-ntfs-dev@lists."
-						"sourceforge.net");
+			err = ntfs_read_locked_inode(vi);
+			if (err) {
+				ntfs_error(sb, "ntfs_read_inode() of $MFT failed.\n");
 				ntfs_attr_put_search_ctx(ctx);
 				/* Revert to the safe super operations. */
 				ntfs_free(m);
@@ -2124,7 +2158,7 @@ int ntfs_read_inode_mount(struct inode *vi)
 		}
 
 		/* Get the lowest vcn for the next extent. */
-		highest_vcn = sle64_to_cpu(a->data.non_resident.highest_vcn);
+		highest_vcn = le64_to_cpu(a->data.non_resident.highest_vcn);
 		next_vcn = highest_vcn + 1;
 
 		/* Only one extent or error, which we catch below. */
@@ -2132,27 +2166,21 @@ int ntfs_read_inode_mount(struct inode *vi)
 			break;
 
 		/* Avoid endless loops due to corruption. */
-		if (next_vcn < sle64_to_cpu(
-				a->data.non_resident.lowest_vcn)) {
-			ntfs_error(sb, "$MFT has corrupt attribute list "
-					"attribute. Run chkdsk.");
+		if (next_vcn < le64_to_cpu(a->data.non_resident.lowest_vcn)) {
+			ntfs_error(sb, "$MFT has corrupt attribute list attribute. Run chkdsk.");
 			goto put_err_out;
 		}
 	}
 	if (err != -ENOENT) {
-		ntfs_error(sb, "Failed to lookup $MFT/$DATA attribute extent. "
-				"$MFT is corrupt. Run chkdsk.");
+		ntfs_error(sb, "Failed to lookup $MFT/$DATA attribute extent. Run chkdsk.\n");
 		goto put_err_out;
 	}
 	if (!a) {
-		ntfs_error(sb, "$MFT/$DATA attribute not found. $MFT is "
-				"corrupt. Run chkdsk.");
+		ntfs_error(sb, "$MFT/$DATA attribute not found. $MFT is corrupt. Run chkdsk.");
 		goto put_err_out;
 	}
 	if (highest_vcn && highest_vcn != last_vcn - 1) {
-		ntfs_error(sb, "Failed to load the complete runlist for "
-				"$MFT/$DATA. Driver bug or corrupt $MFT. "
-				"Run chkdsk.");
+		ntfs_error(sb, "Failed to load the complete runlist for $MFT/$DATA. Run chkdsk.");
 		ntfs_debug("highest_vcn = 0x%llx, last_vcn - 1 = 0x%llx",
 				(unsigned long long)highest_vcn,
 				(unsigned long long)last_vcn - 1);
@@ -2172,68 +2200,77 @@ int ntfs_read_inode_mount(struct inode *vi)
 	return 0;
 
 em_put_err_out:
-	ntfs_error(sb, "Couldn't find first extent of $DATA attribute in "
-			"attribute list. $MFT is corrupt. Run chkdsk.");
+	ntfs_error(sb,
+		"Couldn't find first extent of $DATA attribute in attribute list. $MFT is corrupt. Run chkdsk.");
 put_err_out:
 	ntfs_attr_put_search_ctx(ctx);
 err_out:
 	ntfs_error(sb, "Failed. Marking inode as bad.");
-	make_bad_inode(vi);
 	ntfs_free(m);
 	return -1;
 }
 
-static void __ntfs_clear_inode(ntfs_inode *ni)
+static void __ntfs_clear_inode(struct ntfs_inode *ni)
 {
 	/* Free all alocated memory. */
-	down_write(&ni->runlist.lock);
-	if (ni->runlist.rl) {
+	if (NInoNonResident(ni) && ni->runlist.rl) {
 		ntfs_free(ni->runlist.rl);
 		ni->runlist.rl = NULL;
 	}
-	up_write(&ni->runlist.lock);
 
 	if (ni->attr_list) {
 		ntfs_free(ni->attr_list);
 		ni->attr_list = NULL;
 	}
 
-	down_write(&ni->attr_list_rl.lock);
-	if (ni->attr_list_rl.rl) {
-		ntfs_free(ni->attr_list_rl.rl);
-		ni->attr_list_rl.rl = NULL;
-	}
-	up_write(&ni->attr_list_rl.lock);
-
-	if (ni->name_len && ni->name != I30) {
-		/* Catch bugs... */
-		BUG_ON(!ni->name);
+	if (ni->name_len && ni->name != I30 &&
+	    ni->name != reparse_index_name &&
+	    ni->name != R) {
+		WARN_ON(!ni->name);
 		kfree(ni->name);
 	}
 }
 
-void ntfs_clear_extent_inode(ntfs_inode *ni)
+void ntfs_clear_extent_inode(struct ntfs_inode *ni)
 {
 	ntfs_debug("Entering for inode 0x%lx.", ni->mft_no);
 
-	BUG_ON(NInoAttr(ni));
-	BUG_ON(ni->nr_extents != -1);
-
-#ifdef NTFS_RW
-	if (NInoDirty(ni)) {
-		if (!is_bad_inode(VFS_I(ni->ext.base_ntfs_ino)))
-			ntfs_error(ni->vol->sb, "Clearing dirty extent inode!  "
-					"Losing data!  This is a BUG!!!");
-		// FIXME:  Do something!!!
-	}
-#endif /* NTFS_RW */
+	WARN_ON(NInoAttr(ni));
+	WARN_ON(ni->nr_extents != -1);
 
 	__ntfs_clear_inode(ni);
-
-	/* Bye, bye... */
 	ntfs_destroy_extent_inode(ni);
 }
 
+static int ntfs_delete_base_inode(struct ntfs_inode *ni)
+{
+	struct super_block *sb = ni->vol->sb;
+	int err;
+
+	if (NInoAttr(ni) || ni->nr_extents == -1)
+		return 0;
+
+	err = ntfs_non_resident_dealloc_clusters(ni);
+
+	/*
+	 * Deallocate extent mft records and free extent inodes.
+	 * No need to lock as no one else has a reference.
+	 */
+	while (ni->nr_extents) {
+		err = ntfs_mft_record_free(ni->vol, *(ni->ext.extent_ntfs_inos));
+		if (err)
+			ntfs_error(sb,
+				"Failed to free extent MFT record. Leaving inconsistent metadata.\n");
+		ntfs_inode_close(*(ni->ext.extent_ntfs_inos));
+	}
+
+	/* Deallocate base mft record */
+	err = ntfs_mft_record_free(ni->vol, ni);
+	if (err)
+		ntfs_error(sb, "Failed to free base MFT record. Leaving inconsistent metadata.\n");
+	return err;
+}
+
 /**
  * ntfs_evict_big_inode - clean up the ntfs specific part of an inode
  * @vi:		vfs inode pending annihilation
@@ -2246,35 +2283,45 @@ void ntfs_clear_extent_inode(ntfs_inode *ni)
  */
 void ntfs_evict_big_inode(struct inode *vi)
 {
-	ntfs_inode *ni = NTFS_I(vi);
+	struct ntfs_inode *ni = NTFS_I(vi);
 
 	truncate_inode_pages_final(&vi->i_data);
-	clear_inode(vi);
 
-#ifdef NTFS_RW
-	if (NInoDirty(ni)) {
-		bool was_bad = (is_bad_inode(vi));
+	if (!vi->i_nlink) {
+		if (!NInoAttr(ni)) {
+			/* Never called with extent inodes */
+			WARN_ON(ni->nr_extents == -1);
+			ntfs_delete_base_inode(ni);
+		}
+		goto release;
+	}
 
+	if (NInoDirty(ni)) {
 		/* Committing the inode also commits all extent inodes. */
 		ntfs_commit_inode(vi);
 
-		if (!was_bad && (is_bad_inode(vi) || NInoDirty(ni))) {
-			ntfs_error(vi->i_sb, "Failed to commit dirty inode "
-					"0x%lx.  Losing data!", vi->i_ino);
-			// FIXME:  Do something!!!
+		if (NInoDirty(ni)) {
+			ntfs_debug("Failed to commit dirty inode 0x%lx.  Losing data!",
+				   vi->i_ino);
+			NInoClearAttrListDirty(ni);
+			NInoClearDirty(ni);
 		}
 	}
-#endif /* NTFS_RW */
 
 	/* No need to lock at this stage as no one else has a reference. */
 	if (ni->nr_extents > 0) {
 		int i;
 
-		for (i = 0; i < ni->nr_extents; i++)
-			ntfs_clear_extent_inode(ni->ext.extent_ntfs_inos[i]);
-		kfree(ni->ext.extent_ntfs_inos);
+		for (i = 0; i < ni->nr_extents; i++) {
+			if (ni->ext.extent_ntfs_inos[i])
+				ntfs_clear_extent_inode(ni->ext.extent_ntfs_inos[i]);
+		}
+		ni->nr_extents = 0;
+		ntfs_free(ni->ext.extent_ntfs_inos);
 	}
 
+release:
+	clear_inode(vi);
 	__ntfs_clear_inode(ni);
 
 	if (NInoAttr(ni)) {
@@ -2285,10 +2332,13 @@ void ntfs_evict_big_inode(struct inode *vi)
 			ni->ext.base_ntfs_ino = NULL;
 		}
 	}
-	BUG_ON(ni->page);
+
 	if (!atomic_dec_and_test(&ni->count))
-		BUG();
-	return;
+		WARN_ON(1);
+	if (ni->folio)
+		folio_put(ni->folio);
+	kfree(ni->mrec);
+	ntfs_free(ni->target);
 }
 
 /**
@@ -2303,639 +2353,358 @@ void ntfs_evict_big_inode(struct inode *vi)
  */
 int ntfs_show_options(struct seq_file *sf, struct dentry *root)
 {
-	ntfs_volume *vol = NTFS_SB(root->d_sb);
+	struct ntfs_volume *vol = NTFS_SB(root->d_sb);
 	int i;
 
-	seq_printf(sf, ",uid=%i", from_kuid_munged(&init_user_ns, vol->uid));
-	seq_printf(sf, ",gid=%i", from_kgid_munged(&init_user_ns, vol->gid));
+	if (uid_valid(vol->uid))
+		seq_printf(sf, ",uid=%i", from_kuid_munged(&init_user_ns, vol->uid));
+	if (gid_valid(vol->gid))
+		seq_printf(sf, ",gid=%i", from_kgid_munged(&init_user_ns, vol->gid));
 	if (vol->fmask == vol->dmask)
 		seq_printf(sf, ",umask=0%o", vol->fmask);
 	else {
 		seq_printf(sf, ",fmask=0%o", vol->fmask);
 		seq_printf(sf, ",dmask=0%o", vol->dmask);
 	}
-	seq_printf(sf, ",nls=%s", vol->nls_map->charset);
+	seq_printf(sf, ",iocharset=%s", vol->nls_map->charset);
 	if (NVolCaseSensitive(vol))
-		seq_printf(sf, ",case_sensitive");
+		seq_puts(sf, ",case_sensitive");
+	else
+		seq_puts(sf, ",nocase");
 	if (NVolShowSystemFiles(vol))
-		seq_printf(sf, ",show_sys_files");
-	if (!NVolSparseEnabled(vol))
-		seq_printf(sf, ",disable_sparse");
+		seq_puts(sf, ",show_sys_files,showmeta");
 	for (i = 0; on_errors_arr[i].val; i++) {
-		if (on_errors_arr[i].val & vol->on_errors)
+		if (on_errors_arr[i].val == vol->on_errors)
 			seq_printf(sf, ",errors=%s", on_errors_arr[i].str);
 	}
 	seq_printf(sf, ",mft_zone_multiplier=%i", vol->mft_zone_multiplier);
+	if (NVolSysImmutable(vol))
+		seq_puts(sf, ",sys_immutable");
+	if (!NVolShowHiddenFiles(vol))
+		seq_puts(sf, ",nohidden");
+	if (NVolHideDotFiles(vol))
+		seq_puts(sf, ",hide_dot_files");
+	if (NVolCheckWindowsNames(vol))
+		seq_puts(sf, ",windows_names");
+	if (NVolDiscard(vol))
+		seq_puts(sf, ",discard");
+	if (NVolDisableSparse(vol))
+		seq_puts(sf, ",disable_sparse");
+	if (vol->sb->s_flags & SB_POSIXACL)
+		seq_puts(sf, ",acl");
 	return 0;
 }
 
-#ifdef NTFS_RW
-
-static const char *es = "  Leaving inconsistent metadata.  Unmount and run "
-		"chkdsk.";
-
-/**
- * ntfs_truncate - called when the i_size of an ntfs inode is changed
- * @vi:		inode for which the i_size was changed
- *
- * We only support i_size changes for normal files at present, i.e. not
- * compressed and not encrypted.  This is enforced in ntfs_setattr(), see
- * below.
- *
- * The kernel guarantees that @vi is a regular file (S_ISREG() is true) and
- * that the change is allowed.
- *
- * This implies for us that @vi is a file inode rather than a directory, index,
- * or attribute inode as well as that @vi is a base inode.
- *
- * Returns 0 on success or -errno on error.
- *
- * Called with ->i_mutex held.
- */
-int ntfs_truncate(struct inode *vi)
+int ntfs_extend_initialized_size(struct inode *vi, const loff_t offset,
+		const loff_t new_size)
 {
-	s64 new_size, old_size, nr_freed, new_alloc_size, old_alloc_size;
-	VCN highest_vcn;
+	struct ntfs_inode *ni = NTFS_I(vi);
+	loff_t old_init_size;
 	unsigned long flags;
-	ntfs_inode *base_ni, *ni = NTFS_I(vi);
-	ntfs_volume *vol = ni->vol;
-	ntfs_attr_search_ctx *ctx;
-	MFT_RECORD *m;
-	ATTR_RECORD *a;
-	const char *te = "  Leaving file length out of sync with i_size.";
-	int err, mp_size, size_change, alloc_change;
-
-	ntfs_debug("Entering for inode 0x%lx.", vi->i_ino);
-	BUG_ON(NInoAttr(ni));
-	BUG_ON(S_ISDIR(vi->i_mode));
-	BUG_ON(NInoMstProtected(ni));
-	BUG_ON(ni->nr_extents < 0);
-retry_truncate:
-	/*
-	 * Lock the runlist for writing and map the mft record to ensure it is
-	 * safe to mess with the attribute runlist and sizes.
-	 */
-	down_write(&ni->runlist.lock);
-	if (!NInoAttr(ni))
-		base_ni = ni;
-	else
-		base_ni = ni->ext.base_ntfs_ino;
-	m = map_mft_record(base_ni);
-	if (IS_ERR(m)) {
-		err = PTR_ERR(m);
-		ntfs_error(vi->i_sb, "Failed to map mft record for inode 0x%lx "
-				"(error code %d).%s", vi->i_ino, err, te);
-		ctx = NULL;
-		m = NULL;
-		goto old_bad_out;
-	}
-	ctx = ntfs_attr_get_search_ctx(base_ni, m);
-	if (unlikely(!ctx)) {
-		ntfs_error(vi->i_sb, "Failed to allocate a search context for "
-				"inode 0x%lx (not enough memory).%s",
-				vi->i_ino, te);
-		err = -ENOMEM;
-		goto old_bad_out;
-	}
-	err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
-			CASE_SENSITIVE, 0, NULL, 0, ctx);
-	if (unlikely(err)) {
-		if (err == -ENOENT) {
-			ntfs_error(vi->i_sb, "Open attribute is missing from "
-					"mft record.  Inode 0x%lx is corrupt.  "
-					"Run chkdsk.%s", vi->i_ino, te);
-			err = -EIO;
-		} else
-			ntfs_error(vi->i_sb, "Failed to lookup attribute in "
-					"inode 0x%lx (error code %d).%s",
-					vi->i_ino, err, te);
-		goto old_bad_out;
-	}
-	m = ctx->mrec;
-	a = ctx->attr;
-	/*
-	 * The i_size of the vfs inode is the new size for the attribute value.
-	 */
-	new_size = i_size_read(vi);
-	/* The current size of the attribute value is the old size. */
-	old_size = ntfs_attr_size(a);
-	/* Calculate the new allocated size. */
-	if (NInoNonResident(ni))
-		new_alloc_size = (new_size + vol->cluster_size - 1) &
-				~(s64)vol->cluster_size_mask;
-	else
-		new_alloc_size = (new_size + 7) & ~7;
-	/* The current allocated size is the old allocated size. */
+	int err;
+
 	read_lock_irqsave(&ni->size_lock, flags);
-	old_alloc_size = ni->allocated_size;
+	old_init_size = ni->initialized_size;
 	read_unlock_irqrestore(&ni->size_lock, flags);
-	/*
-	 * The change in the file size.  This will be 0 if no change, >0 if the
-	 * size is growing, and <0 if the size is shrinking.
-	 */
-	size_change = -1;
-	if (new_size - old_size >= 0) {
-		size_change = 1;
-		if (new_size == old_size)
-			size_change = 0;
-	}
-	/* As above for the allocated size. */
-	alloc_change = -1;
-	if (new_alloc_size - old_alloc_size >= 0) {
-		alloc_change = 1;
-		if (new_alloc_size == old_alloc_size)
-			alloc_change = 0;
-	}
-	/*
-	 * If neither the size nor the allocation are being changed there is
-	 * nothing to do.
-	 */
-	if (!size_change && !alloc_change)
-		goto unm_done;
-	/* If the size is changing, check if new size is allowed in $AttrDef. */
-	if (size_change) {
-		err = ntfs_attr_size_bounds_check(vol, ni->type, new_size);
-		if (unlikely(err)) {
-			if (err == -ERANGE) {
-				ntfs_error(vol->sb, "Truncate would cause the "
-						"inode 0x%lx to %simum size "
-						"for its attribute type "
-						"(0x%x).  Aborting truncate.",
-						vi->i_ino,
-						new_size > old_size ? "exceed "
-						"the max" : "go under the min",
-						le32_to_cpu(ni->type));
-				err = -EFBIG;
-			} else {
-				ntfs_error(vol->sb, "Inode 0x%lx has unknown "
-						"attribute type 0x%x.  "
-						"Aborting truncate.",
-						vi->i_ino,
-						le32_to_cpu(ni->type));
-				err = -EIO;
-			}
-			/* Reset the vfs inode size to the old size. */
-			i_size_write(vi, old_size);
-			goto err_out;
-		}
-	}
-	if (NInoCompressed(ni) || NInoEncrypted(ni)) {
-		ntfs_warning(vi->i_sb, "Changes in inode size are not "
-				"supported yet for %s files, ignoring.",
-				NInoCompressed(ni) ? "compressed" :
-				"encrypted");
-		err = -EOPNOTSUPP;
-		goto bad_out;
-	}
-	if (a->non_resident)
-		goto do_non_resident_truncate;
-	BUG_ON(NInoNonResident(ni));
-	/* Resize the attribute record to best fit the new attribute size. */
-	if (new_size < vol->mft_record_size &&
-			!ntfs_resident_attr_value_resize(m, a, new_size)) {
-		/* The resize succeeded! */
-		flush_dcache_mft_record_page(ctx->ntfs_ino);
-		mark_mft_record_dirty(ctx->ntfs_ino);
-		write_lock_irqsave(&ni->size_lock, flags);
-		/* Update the sizes in the ntfs inode and all is done. */
-		ni->allocated_size = le32_to_cpu(a->length) -
-				le16_to_cpu(a->data.resident.value_offset);
-		/*
-		 * Note ntfs_resident_attr_value_resize() has already done any
-		 * necessary data clearing in the attribute record.  When the
-		 * file is being shrunk vmtruncate() will already have cleared
-		 * the top part of the last partial page, i.e. since this is
-		 * the resident case this is the page with index 0.  However,
-		 * when the file is being expanded, the page cache page data
-		 * between the old data_size, i.e. old_size, and the new_size
-		 * has not been zeroed.  Fortunately, we do not need to zero it
-		 * either since on one hand it will either already be zero due
-		 * to both read_folio and writepage clearing partial page data
-		 * beyond i_size in which case there is nothing to do or in the
-		 * case of the file being mmap()ped at the same time, POSIX
-		 * specifies that the behaviour is unspecified thus we do not
-		 * have to do anything.  This means that in our implementation
-		 * in the rare case that the file is mmap()ped and a write
-		 * occurred into the mmap()ped region just beyond the file size
-		 * and writepage has not yet been called to write out the page
-		 * (which would clear the area beyond the file size) and we now
-		 * extend the file size to incorporate this dirty region
-		 * outside the file size, a write of the page would result in
-		 * this data being written to disk instead of being cleared.
-		 * Given both POSIX and the Linux mmap(2) man page specify that
-		 * this corner case is undefined, we choose to leave it like
-		 * that as this is much simpler for us as we cannot lock the
-		 * relevant page now since we are holding too many ntfs locks
-		 * which would result in a lock reversal deadlock.
-		 */
-		ni->initialized_size = new_size;
-		write_unlock_irqrestore(&ni->size_lock, flags);
-		goto unm_done;
-	}
-	/* If the above resize failed, this must be an attribute extension. */
-	BUG_ON(size_change < 0);
-	/*
-	 * We have to drop all the locks so we can call
-	 * ntfs_attr_make_non_resident().  This could be optimised by try-
-	 * locking the first page cache page and only if that fails dropping
-	 * the locks, locking the page, and redoing all the locking and
-	 * lookups.  While this would be a huge optimisation, it is not worth
-	 * it as this is definitely a slow code path as it only ever can happen
-	 * once for any given file.
-	 */
-	ntfs_attr_put_search_ctx(ctx);
-	unmap_mft_record(base_ni);
-	up_write(&ni->runlist.lock);
-	/*
-	 * Not enough space in the mft record, try to make the attribute
-	 * non-resident and if successful restart the truncation process.
-	 */
-	err = ntfs_attr_make_non_resident(ni, old_size);
-	if (likely(!err))
-		goto retry_truncate;
-	/*
-	 * Could not make non-resident.  If this is due to this not being
-	 * permitted for this attribute type or there not being enough space,
-	 * try to make other attributes non-resident.  Otherwise fail.
-	 */
-	if (unlikely(err != -EPERM && err != -ENOSPC)) {
-		ntfs_error(vol->sb, "Cannot truncate inode 0x%lx, attribute "
-				"type 0x%x, because the conversion from "
-				"resident to non-resident attribute failed "
-				"with error code %i.", vi->i_ino,
-				(unsigned)le32_to_cpu(ni->type), err);
-		if (err != -ENOMEM)
-			err = -EIO;
-		goto conv_err_out;
-	}
-	/* TODO: Not implemented from here, abort. */
-	if (err == -ENOSPC)
-		ntfs_error(vol->sb, "Not enough space in the mft record/on "
-				"disk for the non-resident attribute value.  "
-				"This case is not implemented yet.");
-	else /* if (err == -EPERM) */
-		ntfs_error(vol->sb, "This attribute type may not be "
-				"non-resident.  This case is not implemented "
-				"yet.");
-	err = -EOPNOTSUPP;
-	goto conv_err_out;
-#if 0
-	// TODO: Attempt to make other attributes non-resident.
-	if (!err)
-		goto do_resident_extend;
-	/*
-	 * Both the attribute list attribute and the standard information
-	 * attribute must remain in the base inode.  Thus, if this is one of
-	 * these attributes, we have to try to move other attributes out into
-	 * extent mft records instead.
-	 */
-	if (ni->type == AT_ATTRIBUTE_LIST ||
-			ni->type == AT_STANDARD_INFORMATION) {
-		// TODO: Attempt to move other attributes into extent mft
-		// records.
-		err = -EOPNOTSUPP;
-		if (!err)
-			goto do_resident_extend;
-		goto err_out;
-	}
-	// TODO: Attempt to move this attribute to an extent mft record, but
-	// only if it is not already the only attribute in an mft record in
-	// which case there would be nothing to gain.
-	err = -EOPNOTSUPP;
-	if (!err)
-		goto do_resident_extend;
-	/* There is nothing we can do to make enough space. )-: */
-	goto err_out;
-#endif
-do_non_resident_truncate:
-	BUG_ON(!NInoNonResident(ni));
-	if (alloc_change < 0) {
-		highest_vcn = sle64_to_cpu(a->data.non_resident.highest_vcn);
-		if (highest_vcn > 0 &&
-				old_alloc_size >> vol->cluster_size_bits >
-				highest_vcn + 1) {
-			/*
-			 * This attribute has multiple extents.  Not yet
-			 * supported.
-			 */
-			ntfs_error(vol->sb, "Cannot truncate inode 0x%lx, "
-					"attribute type 0x%x, because the "
-					"attribute is highly fragmented (it "
-					"consists of multiple extents) and "
-					"this case is not implemented yet.",
-					vi->i_ino,
-					(unsigned)le32_to_cpu(ni->type));
-			err = -EOPNOTSUPP;
-			goto bad_out;
-		}
-	}
-	/*
-	 * If the size is shrinking, need to reduce the initialized_size and
-	 * the data_size before reducing the allocation.
-	 */
-	if (size_change < 0) {
-		/*
-		 * Make the valid size smaller (i_size is already up-to-date).
-		 */
-		write_lock_irqsave(&ni->size_lock, flags);
-		if (new_size < ni->initialized_size) {
-			ni->initialized_size = new_size;
-			a->data.non_resident.initialized_size =
-					cpu_to_sle64(new_size);
-		}
-		a->data.non_resident.data_size = cpu_to_sle64(new_size);
-		write_unlock_irqrestore(&ni->size_lock, flags);
-		flush_dcache_mft_record_page(ctx->ntfs_ino);
-		mark_mft_record_dirty(ctx->ntfs_ino);
-		/* If the allocated size is not changing, we are done. */
-		if (!alloc_change)
-			goto unm_done;
-		/*
-		 * If the size is shrinking it makes no sense for the
-		 * allocation to be growing.
-		 */
-		BUG_ON(alloc_change > 0);
-	} else /* if (size_change >= 0) */ {
-		/*
-		 * The file size is growing or staying the same but the
-		 * allocation can be shrinking, growing or staying the same.
-		 */
-		if (alloc_change > 0) {
-			/*
-			 * We need to extend the allocation and possibly update
-			 * the data size.  If we are updating the data size,
-			 * since we are not touching the initialized_size we do
-			 * not need to worry about the actual data on disk.
-			 * And as far as the page cache is concerned, there
-			 * will be no pages beyond the old data size and any
-			 * partial region in the last page between the old and
-			 * new data size (or the end of the page if the new
-			 * data size is outside the page) does not need to be
-			 * modified as explained above for the resident
-			 * attribute truncate case.  To do this, we simply drop
-			 * the locks we hold and leave all the work to our
-			 * friendly helper ntfs_attr_extend_allocation().
-			 */
-			ntfs_attr_put_search_ctx(ctx);
-			unmap_mft_record(base_ni);
-			up_write(&ni->runlist.lock);
-			err = ntfs_attr_extend_allocation(ni, new_size,
-					size_change > 0 ? new_size : -1, -1);
-			/*
-			 * ntfs_attr_extend_allocation() will have done error
-			 * output already.
-			 */
-			goto done;
-		}
-		if (!alloc_change)
-			goto alloc_done;
-	}
-	/* alloc_change < 0 */
-	/* Free the clusters. */
-	nr_freed = ntfs_cluster_free(ni, new_alloc_size >>
-			vol->cluster_size_bits, -1, ctx);
-	m = ctx->mrec;
-	a = ctx->attr;
-	if (unlikely(nr_freed < 0)) {
-		ntfs_error(vol->sb, "Failed to release cluster(s) (error code "
-				"%lli).  Unmount and run chkdsk to recover "
-				"the lost cluster(s).", (long long)nr_freed);
-		NVolSetErrors(vol);
-		nr_freed = 0;
-	}
-	/* Truncate the runlist. */
-	err = ntfs_rl_truncate_nolock(vol, &ni->runlist,
-			new_alloc_size >> vol->cluster_size_bits);
-	/*
-	 * If the runlist truncation failed and/or the search context is no
-	 * longer valid, we cannot resize the attribute record or build the
-	 * mapping pairs array thus we mark the inode bad so that no access to
-	 * the freed clusters can happen.
-	 */
-	if (unlikely(err || IS_ERR(m))) {
-		ntfs_error(vol->sb, "Failed to %s (error code %li).%s",
-				IS_ERR(m) ?
-				"restore attribute search context" :
-				"truncate attribute runlist",
-				IS_ERR(m) ? PTR_ERR(m) : err, es);
-		err = -EIO;
-		goto bad_out;
-	}
-	/* Get the size for the shrunk mapping pairs array for the runlist. */
-	mp_size = ntfs_get_size_for_mapping_pairs(vol, ni->runlist.rl, 0, -1);
-	if (unlikely(mp_size <= 0)) {
-		ntfs_error(vol->sb, "Cannot shrink allocation of inode 0x%lx, "
-				"attribute type 0x%x, because determining the "
-				"size for the mapping pairs failed with error "
-				"code %i.%s", vi->i_ino,
-				(unsigned)le32_to_cpu(ni->type), mp_size, es);
-		err = -EIO;
-		goto bad_out;
-	}
-	/*
-	 * Shrink the attribute record for the new mapping pairs array.  Note,
-	 * this cannot fail since we are making the attribute smaller thus by
-	 * definition there is enough space to do so.
-	 */
-	err = ntfs_attr_record_resize(m, a, mp_size +
-			le16_to_cpu(a->data.non_resident.mapping_pairs_offset));
-	BUG_ON(err);
-	/*
-	 * Generate the mapping pairs array directly into the attribute record.
-	 */
-	err = ntfs_mapping_pairs_build(vol, (u8*)a +
-			le16_to_cpu(a->data.non_resident.mapping_pairs_offset),
-			mp_size, ni->runlist.rl, 0, -1, NULL);
-	if (unlikely(err)) {
-		ntfs_error(vol->sb, "Cannot shrink allocation of inode 0x%lx, "
-				"attribute type 0x%x, because building the "
-				"mapping pairs failed with error code %i.%s",
-				vi->i_ino, (unsigned)le32_to_cpu(ni->type),
-				err, es);
-		err = -EIO;
-		goto bad_out;
-	}
-	/* Update the allocated/compressed size as well as the highest vcn. */
-	a->data.non_resident.highest_vcn = cpu_to_sle64((new_alloc_size >>
-			vol->cluster_size_bits) - 1);
-	write_lock_irqsave(&ni->size_lock, flags);
-	ni->allocated_size = new_alloc_size;
-	a->data.non_resident.allocated_size = cpu_to_sle64(new_alloc_size);
-	if (NInoSparse(ni) || NInoCompressed(ni)) {
-		if (nr_freed) {
-			ni->itype.compressed.size -= nr_freed <<
-					vol->cluster_size_bits;
-			BUG_ON(ni->itype.compressed.size < 0);
-			a->data.non_resident.compressed_size = cpu_to_sle64(
-					ni->itype.compressed.size);
-			vi->i_blocks = ni->itype.compressed.size >> 9;
-		}
-	} else
-		vi->i_blocks = new_alloc_size >> 9;
-	write_unlock_irqrestore(&ni->size_lock, flags);
-	/*
-	 * We have shrunk the allocation.  If this is a shrinking truncate we
-	 * have already dealt with the initialized_size and the data_size above
-	 * and we are done.  If the truncate is only changing the allocation
-	 * and not the data_size, we are also done.  If this is an extending
-	 * truncate, need to extend the data_size now which is ensured by the
-	 * fact that @size_change is positive.
-	 */
-alloc_done:
-	/*
-	 * If the size is growing, need to update it now.  If it is shrinking,
-	 * we have already updated it above (before the allocation change).
-	 */
-	if (size_change > 0)
-		a->data.non_resident.data_size = cpu_to_sle64(new_size);
-	/* Ensure the modified mft record is written out. */
-	flush_dcache_mft_record_page(ctx->ntfs_ino);
-	mark_mft_record_dirty(ctx->ntfs_ino);
-unm_done:
-	ntfs_attr_put_search_ctx(ctx);
-	unmap_mft_record(base_ni);
-	up_write(&ni->runlist.lock);
-done:
-	/* Update the mtime and ctime on the base inode. */
-	/* normally ->truncate shouldn't update ctime or mtime,
-	 * but ntfs did before so it got a copy & paste version
-	 * of file_update_time.  one day someone should fix this
-	 * for real.
-	 */
-	if (!IS_NOCMTIME(VFS_I(base_ni)) && !IS_RDONLY(VFS_I(base_ni))) {
-		struct timespec64 now = current_time(VFS_I(base_ni));
-		struct timespec64 ctime = inode_get_ctime(VFS_I(base_ni));
-		struct timespec64 mtime = inode_get_mtime(VFS_I(base_ni));
-		int sync_it = 0;
 
-		if (!timespec64_equal(&mtime, &now) ||
-		    !timespec64_equal(&ctime, &now))
-			sync_it = 1;
-		inode_set_ctime_to_ts(VFS_I(base_ni), now);
-		inode_set_mtime_to_ts(VFS_I(base_ni), now);
+	if (!NInoNonResident(ni))
+		return -EINVAL;
+	if (old_init_size >= new_size)
+		return 0;
 
-		if (sync_it)
-			mark_inode_dirty_sync(VFS_I(base_ni));
-	}
+	err = ntfs_attr_map_whole_runlist(ni);
+	if (err)
+		return err;
 
-	if (likely(!err)) {
-		NInoClearTruncateFailed(ni);
-		ntfs_debug("Done.");
+	if (!NInoCompressed(ni) && old_init_size < offset) {
+		err = iomap_zero_range(vi, old_init_size,
+				       offset - old_init_size,
+				       NULL, &ntfs_read_iomap_ops,
+				       &ntfs_iomap_folio_ops, NULL);
+		if (err)
+			return err;
 	}
+
+
+	mutex_lock(&ni->mrec_lock);
+	err = ntfs_attr_set_initialized_size(ni, new_size);
+	mutex_unlock(&ni->mrec_lock);
+	if (err)
+		truncate_setsize(vi, old_init_size);
 	return err;
-old_bad_out:
-	old_size = -1;
-bad_out:
-	if (err != -ENOMEM && err != -EOPNOTSUPP)
-		NVolSetErrors(vol);
-	if (err != -EOPNOTSUPP)
-		NInoSetTruncateFailed(ni);
-	else if (old_size >= 0)
-		i_size_write(vi, old_size);
-err_out:
-	if (ctx)
-		ntfs_attr_put_search_ctx(ctx);
-	if (m)
-		unmap_mft_record(base_ni);
-	up_write(&ni->runlist.lock);
-out:
-	ntfs_debug("Failed.  Returning error code %i.", err);
-	return err;
-conv_err_out:
-	if (err != -ENOMEM && err != -EOPNOTSUPP)
-		NVolSetErrors(vol);
-	if (err != -EOPNOTSUPP)
-		NInoSetTruncateFailed(ni);
-	else
-		i_size_write(vi, old_size);
-	goto out;
 }
 
-/**
- * ntfs_truncate_vfs - wrapper for ntfs_truncate() that has no return value
- * @vi:		inode for which the i_size was changed
- *
- * Wrapper for ntfs_truncate() that has no return value.
- *
- * See ntfs_truncate() description above for details.
- */
-#ifdef NTFS_RW
-void ntfs_truncate_vfs(struct inode *vi) {
-	ntfs_truncate(vi);
+int ntfs_truncate_vfs(struct inode *vi, loff_t new_size, loff_t i_size)
+{
+	struct ntfs_inode *ni = NTFS_I(vi);
+	int err;
+
+	mutex_lock(&ni->mrec_lock);
+	err = __ntfs_attr_truncate_vfs(ni, new_size, i_size);
+	mutex_unlock(&ni->mrec_lock);
+	if (err < 0)
+		return err;
+
+	inode_set_mtime_to_ts(vi, inode_set_ctime_current(vi));
+	return 0;
 }
-#endif
 
 /**
- * ntfs_setattr - called from notify_change() when an attribute is being changed
- * @idmap:	idmap of the mount the inode was found from
- * @dentry:	dentry whose attributes to change
- * @attr:	structure describing the attributes and the changes
- *
- * We have to trap VFS attempts to truncate the file described by @dentry as
- * soon as possible, because we do not implement changes in i_size yet.  So we
- * abort all i_size changes here.
- *
- * We also abort all changes of user, group, and mode as we do not implement
- * the NTFS ACLs yet.
+ * ntfs_inode_sync_standard_information - update standard information attribute
+ * @vi:	inode to update standard information
+ * @m:	mft record
  *
- * Called with ->i_mutex held.
+ * Return 0 on success or -errno on error.
  */
-int ntfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
-		 struct iattr *attr)
+static int ntfs_inode_sync_standard_information(struct inode *vi, struct mft_record *m)
 {
-	struct inode *vi = d_inode(dentry);
-	int err;
-	unsigned int ia_valid = attr->ia_valid;
+	struct ntfs_inode *ni = NTFS_I(vi);
+	struct ntfs_attr_search_ctx *ctx;
+	struct standard_information *si;
+	__le64 nt;
+	int err = 0;
+	bool modified = false;
 
-	err = setattr_prepare(&nop_mnt_idmap, dentry, attr);
-	if (err)
-		goto out;
-	/* We do not support NTFS ACLs yet. */
-	if (ia_valid & (ATTR_UID | ATTR_GID | ATTR_MODE)) {
-		ntfs_warning(vi->i_sb, "Changes in user/group/mode are not "
-				"supported yet, ignoring.");
-		err = -EOPNOTSUPP;
-		goto out;
+	/* Update the access times in the standard information attribute. */
+	ctx = ntfs_attr_get_search_ctx(ni, m);
+	if (unlikely(!ctx))
+		return -ENOMEM;
+	err = ntfs_attr_lookup(AT_STANDARD_INFORMATION, NULL, 0,
+			CASE_SENSITIVE, 0, NULL, 0, ctx);
+	if (unlikely(err)) {
+		ntfs_attr_put_search_ctx(ctx);
+		return err;
 	}
-	if (ia_valid & ATTR_SIZE) {
-		if (attr->ia_size != i_size_read(vi)) {
-			ntfs_inode *ni = NTFS_I(vi);
-			/*
-			 * FIXME: For now we do not support resizing of
-			 * compressed or encrypted files yet.
-			 */
-			if (NInoCompressed(ni) || NInoEncrypted(ni)) {
-				ntfs_warning(vi->i_sb, "Changes in inode size "
-						"are not supported yet for "
-						"%s files, ignoring.",
-						NInoCompressed(ni) ?
-						"compressed" : "encrypted");
-				err = -EOPNOTSUPP;
-			} else {
-				truncate_setsize(vi, attr->ia_size);
-				ntfs_truncate_vfs(vi);
-			}
-			if (err || ia_valid == ATTR_SIZE)
-				goto out;
-		} else {
-			/*
-			 * We skipped the truncate but must still update
-			 * timestamps.
-			 */
-			ia_valid |= ATTR_MTIME | ATTR_CTIME;
+	si = (struct standard_information *)((u8 *)ctx->attr +
+			le16_to_cpu(ctx->attr->data.resident.value_offset));
+	if (si->file_attributes != ni->flags) {
+		si->file_attributes = ni->flags;
+		modified = true;
+	}
+
+	/* Update the creation times if they have changed. */
+	nt = utc2ntfs(ni->i_crtime);
+	if (si->creation_time != nt) {
+		ntfs_debug("Updating creation time for inode 0x%lx: old = 0x%llx, new = 0x%llx",
+				vi->i_ino, le64_to_cpu(si->creation_time),
+				le64_to_cpu(nt));
+		si->creation_time = nt;
+		modified = true;
+	}
+
+	/* Update the access times if they have changed. */
+	nt = utc2ntfs(inode_get_mtime(vi));
+	if (si->last_data_change_time != nt) {
+		ntfs_debug("Updating mtime for inode 0x%lx: old = 0x%llx, new = 0x%llx",
+				vi->i_ino, le64_to_cpu(si->last_data_change_time),
+				le64_to_cpu(nt));
+		si->last_data_change_time = nt;
+		modified = true;
+	}
+
+	nt = utc2ntfs(inode_get_ctime(vi));
+	if (si->last_mft_change_time != nt) {
+		ntfs_debug("Updating ctime for inode 0x%lx: old = 0x%llx, new = 0x%llx",
+				vi->i_ino, le64_to_cpu(si->last_mft_change_time),
+				le64_to_cpu(nt));
+		si->last_mft_change_time = nt;
+		modified = true;
+	}
+	nt = utc2ntfs(inode_get_atime(vi));
+	if (si->last_access_time != nt) {
+		ntfs_debug("Updating atime for inode 0x%lx: old = 0x%llx, new = 0x%llx",
+				vi->i_ino,
+				le64_to_cpu(si->last_access_time),
+				le64_to_cpu(nt));
+		si->last_access_time = nt;
+		modified = true;
+	}
+
+	/*
+	 * If we just modified the standard information attribute we need to
+	 * mark the mft record it is in dirty.  We do this manually so that
+	 * mark_inode_dirty() is not called which would redirty the inode and
+	 * hence result in an infinite loop of trying to write the inode.
+	 * There is no need to mark the base inode nor the base mft record
+	 * dirty, since we are going to write this mft record below in any case
+	 * and the base mft record may actually not have been modified so it
+	 * might not need to be written out.
+	 * NOTE: It is not a problem when the inode for $MFT itself is being
+	 * written out as mark_ntfs_record_dirty() will only set I_DIRTY_PAGES
+	 * on the $MFT inode and hence ntfs_write_inode() will not be
+	 * re-invoked because of it which in turn is ok since the dirtied mft
+	 * record will be cleaned and written out to disk below, i.e. before
+	 * this function returns.
+	 */
+	if (modified)
+		NInoSetDirty(ctx->ntfs_ino);
+	ntfs_attr_put_search_ctx(ctx);
+
+	return err;
+}
+
+/**
+ * ntfs_inode_sync_filename - update FILE_NAME attributes
+ * @ni:	ntfs inode to update FILE_NAME attributes
+ *
+ * Update all FILE_NAME attributes for inode @ni in the index.
+ *
+ * Return 0 on success or error.
+ */
+int ntfs_inode_sync_filename(struct ntfs_inode *ni)
+{
+	struct inode *index_vi;
+	struct super_block *sb = VFS_I(ni)->i_sb;
+	struct ntfs_attr_search_ctx *ctx = NULL;
+	struct ntfs_index_context *ictx;
+	struct ntfs_inode *index_ni;
+	struct file_name_attr *fn;
+	struct file_name_attr *fnx;
+	struct reparse_point *rpp;
+	__le32 reparse_tag;
+	int err = 0;
+	unsigned long flags;
+
+	ntfs_debug("Entering for inode %lld\n", (long long)ni->mft_no);
+
+	ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	if (!ctx)
+		return -ENOMEM;
+
+	/* Collect the reparse tag, if any */
+	reparse_tag = cpu_to_le32(0);
+	if (ni->flags & FILE_ATTR_REPARSE_POINT) {
+		if (!ntfs_attr_lookup(AT_REPARSE_POINT, NULL,
+					0, CASE_SENSITIVE, 0, NULL, 0, ctx)) {
+			rpp = (struct reparse_point *)((u8 *)ctx->attr +
+					le16_to_cpu(ctx->attr->data.resident.value_offset));
+			reparse_tag = rpp->reparse_tag;
 		}
+		ntfs_attr_reinit_search_ctx(ctx);
 	}
-	if (ia_valid & ATTR_ATIME)
-		inode_set_atime_to_ts(vi, attr->ia_atime);
-	if (ia_valid & ATTR_MTIME)
-		inode_set_mtime_to_ts(vi, attr->ia_mtime);
-	if (ia_valid & ATTR_CTIME)
-		inode_set_ctime_to_ts(vi, attr->ia_ctime);
-	mark_inode_dirty(vi);
-out:
+
+	/* Walk through all FILE_NAME attributes and update them. */
+	while (!(err = ntfs_attr_lookup(AT_FILE_NAME, NULL, 0, 0, 0, NULL, 0, ctx))) {
+		fn = (struct file_name_attr *)((u8 *)ctx->attr +
+				le16_to_cpu(ctx->attr->data.resident.value_offset));
+		if (MREF_LE(fn->parent_directory) == ni->mft_no)
+			continue;
+
+		index_vi = ntfs_iget(sb, MREF_LE(fn->parent_directory));
+		if (IS_ERR(index_vi)) {
+			ntfs_error(sb, "Failed to open inode %lld with index",
+					(long long)MREF_LE(fn->parent_directory));
+			continue;
+		}
+
+		index_ni = NTFS_I(index_vi);
+
+		mutex_lock_nested(&index_ni->mrec_lock, NTFS_INODE_MUTEX_PARENT);
+		if (NInoBeingDeleted(ni)) {
+			iput(index_vi);
+			mutex_unlock(&index_ni->mrec_lock);
+			continue;
+		}
+
+		ictx = ntfs_index_ctx_get(index_ni, I30, 4);
+		if (!ictx) {
+			ntfs_error(sb, "Failed to get index ctx, inode %lld",
+					(long long)index_ni->mft_no);
+			iput(index_vi);
+			mutex_unlock(&index_ni->mrec_lock);
+			continue;
+		}
+
+		err = ntfs_index_lookup(fn, sizeof(struct file_name_attr), ictx);
+		if (err) {
+			ntfs_debug("Index lookup failed, inode %lld",
+					(long long)index_ni->mft_no);
+			ntfs_index_ctx_put(ictx);
+			iput(index_vi);
+			mutex_unlock(&index_ni->mrec_lock);
+			continue;
+		}
+		/* Update flags and file size. */
+		fnx = (struct file_name_attr *)ictx->data;
+		fnx->file_attributes =
+			(fnx->file_attributes & ~FILE_ATTR_VALID_FLAGS) |
+			(ni->flags & FILE_ATTR_VALID_FLAGS);
+		if (ctx->mrec->flags & MFT_RECORD_IS_DIRECTORY)
+			fnx->data_size = fnx->allocated_size = 0;
+		else {
+			read_lock_irqsave(&ni->size_lock, flags);
+			if (NInoSparse(ni) || NInoCompressed(ni))
+				fnx->allocated_size = cpu_to_le64(ni->itype.compressed.size);
+			else
+				fnx->allocated_size = cpu_to_le64(ni->allocated_size);
+			fnx->data_size = cpu_to_le64(ni->data_size);
+
+			/*
+			 * The file name record has also to be fixed if some
+			 * attribute update implied the unnamed data to be
+			 * made non-resident
+			 */
+			fn->allocated_size = fnx->allocated_size;
+			fn->data_size = fnx->data_size;
+			read_unlock_irqrestore(&ni->size_lock, flags);
+		}
+
+		/* update or clear the reparse tag in the index */
+		fnx->type.rp.reparse_point_tag = reparse_tag;
+		fnx->creation_time = fn->creation_time;
+		fnx->last_data_change_time = fn->last_data_change_time;
+		fnx->last_mft_change_time = fn->last_mft_change_time;
+		fnx->last_access_time = fn->last_access_time;
+		ntfs_index_entry_mark_dirty(ictx);
+		ntfs_icx_ib_sync_write(ictx);
+		NInoSetDirty(ctx->ntfs_ino);
+		ntfs_index_ctx_put(ictx);
+		mutex_unlock(&index_ni->mrec_lock);
+		iput(index_vi);
+	}
+	/* Check for real error occurred. */
+	if (err != -ENOENT) {
+		ntfs_error(sb, "Attribute lookup failed, err : %d, inode %lld", err,
+				(long long)ni->mft_no);
+	} else
+		err = 0;
+
+	ntfs_attr_put_search_ctx(ctx);
 	return err;
 }
 
+int ntfs_get_block_mft_record(struct ntfs_inode *mft_ni, struct ntfs_inode *ni)
+{
+	s64 vcn;
+	struct runlist_element *rl;
+
+	if (ni->mft_lcn[0] != LCN_RL_NOT_MAPPED)
+		return 0;
+
+	vcn = (s64)ni->mft_no << mft_ni->vol->mft_record_size_bits >>
+	      mft_ni->vol->cluster_size_bits;
+
+	rl = mft_ni->runlist.rl;
+	if (!rl) {
+		ntfs_error(mft_ni->vol->sb, "$MFT runlist is not present");
+		return -EIO;
+	}
+
+	/* Seek to element containing target vcn. */
+	while (rl->length && rl[1].vcn <= vcn)
+		rl++;
+	ni->mft_lcn[0] = ntfs_rl_vcn_to_lcn(rl, vcn);
+	ni->mft_lcn_count = 1;
+
+	if (mft_ni->vol->cluster_size < mft_ni->vol->mft_record_size &&
+	    (rl->length - (vcn - rl->vcn)) <= 1) {
+		rl++;
+		ni->mft_lcn[1] = ntfs_rl_vcn_to_lcn(rl, vcn + 1);
+		ni->mft_lcn_count++;
+	}
+	return 0;
+}
+
 /**
  * __ntfs_write_inode - write out a dirty inode
  * @vi:		inode to write out
@@ -2947,130 +2716,132 @@ int ntfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
  * is done using write_mft_record().
  *
  * If @sync is false, just schedule the write to happen but do not wait for i/o
- * completion.  In 2.6 kernels, scheduling usually happens just by virtue of
- * marking the page (and in this case mft record) dirty but we do not implement
- * this yet as write_mft_record() largely ignores the @sync parameter and
- * always performs synchronous writes.
+ * completion.
  *
  * Return 0 on success and -errno on error.
  */
 int __ntfs_write_inode(struct inode *vi, int sync)
 {
-	sle64 nt;
-	ntfs_inode *ni = NTFS_I(vi);
-	ntfs_attr_search_ctx *ctx;
-	MFT_RECORD *m;
-	STANDARD_INFORMATION *si;
+	struct ntfs_inode *ni = NTFS_I(vi);
+	struct ntfs_inode *mft_ni = NTFS_I(ni->vol->mft_ino);
+	struct mft_record *m;
 	int err = 0;
-	bool modified = false;
+	bool need_iput = false;
 
 	ntfs_debug("Entering for %sinode 0x%lx.", NInoAttr(ni) ? "attr " : "",
 			vi->i_ino);
+
+	if (NVolShutdown(ni->vol))
+		return -EIO;
+
 	/*
 	 * Dirty attribute inodes are written via their real inodes so just
 	 * clean them here.  Access time updates are taken care off when the
 	 * real inode is written.
 	 */
-	if (NInoAttr(ni)) {
+	if (NInoAttr(ni) || ni->nr_extents == -1) {
 		NInoClearDirty(ni);
 		ntfs_debug("Done.");
 		return 0;
 	}
+
+	/* igrab prevents vi from being evicted while mrec_lock is hold. */
+	if (igrab(vi) != NULL)
+		need_iput = true;
+
+	mutex_lock_nested(&ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL);
 	/* Map, pin, and lock the mft record belonging to the inode. */
 	m = map_mft_record(ni);
 	if (IS_ERR(m)) {
+		mutex_unlock(&ni->mrec_lock);
 		err = PTR_ERR(m);
 		goto err_out;
 	}
-	/* Update the access times in the standard information attribute. */
-	ctx = ntfs_attr_get_search_ctx(ni, m);
-	if (unlikely(!ctx)) {
-		err = -ENOMEM;
-		goto unm_err_out;
+
+	if (NInoNonResident(ni) && NInoRunlistDirty(ni)) {
+		down_write(&ni->runlist.lock);
+		err = ntfs_attr_update_mapping_pairs(ni, 0);
+		if (!err)
+			NInoClearRunlistDirty(ni);
+		up_write(&ni->runlist.lock);
 	}
-	err = ntfs_attr_lookup(AT_STANDARD_INFORMATION, NULL, 0,
-			CASE_SENSITIVE, 0, NULL, 0, ctx);
-	if (unlikely(err)) {
-		ntfs_attr_put_search_ctx(ctx);
+
+	err = ntfs_inode_sync_standard_information(vi, m);
+	if (err)
 		goto unm_err_out;
-	}
-	si = (STANDARD_INFORMATION*)((u8*)ctx->attr +
-			le16_to_cpu(ctx->attr->data.resident.value_offset));
-	/* Update the access times if they have changed. */
-	nt = utc2ntfs(inode_get_mtime(vi));
-	if (si->last_data_change_time != nt) {
-		ntfs_debug("Updating mtime for inode 0x%lx: old = 0x%llx, "
-				"new = 0x%llx", vi->i_ino, (long long)
-				sle64_to_cpu(si->last_data_change_time),
-				(long long)sle64_to_cpu(nt));
-		si->last_data_change_time = nt;
-		modified = true;
-	}
-	nt = utc2ntfs(inode_get_ctime(vi));
-	if (si->last_mft_change_time != nt) {
-		ntfs_debug("Updating ctime for inode 0x%lx: old = 0x%llx, "
-				"new = 0x%llx", vi->i_ino, (long long)
-				sle64_to_cpu(si->last_mft_change_time),
-				(long long)sle64_to_cpu(nt));
-		si->last_mft_change_time = nt;
-		modified = true;
-	}
-	nt = utc2ntfs(inode_get_atime(vi));
-	if (si->last_access_time != nt) {
-		ntfs_debug("Updating atime for inode 0x%lx: old = 0x%llx, "
-				"new = 0x%llx", vi->i_ino,
-				(long long)sle64_to_cpu(si->last_access_time),
-				(long long)sle64_to_cpu(nt));
-		si->last_access_time = nt;
-		modified = true;
-	}
+
 	/*
-	 * If we just modified the standard information attribute we need to
-	 * mark the mft record it is in dirty.  We do this manually so that
-	 * mark_inode_dirty() is not called which would redirty the inode and
-	 * hence result in an infinite loop of trying to write the inode.
-	 * There is no need to mark the base inode nor the base mft record
-	 * dirty, since we are going to write this mft record below in any case
-	 * and the base mft record may actually not have been modified so it
-	 * might not need to be written out.
-	 * NOTE: It is not a problem when the inode for $MFT itself is being
-	 * written out as mark_ntfs_record_dirty() will only set I_DIRTY_PAGES
-	 * on the $MFT inode and hence __ntfs_write_inode() will not be
-	 * re-invoked because of it which in turn is ok since the dirtied mft
-	 * record will be cleaned and written out to disk below, i.e. before
-	 * this function returns.
+	 * when being umounted and inodes are evicted, write_inode()
+	 * is called with all inodes being marked with I_FREEING.
+	 * then ntfs_inode_sync_filename() waits infinitly because
+	 * of ntfs_iget. This situation happens only where sync_filesysem()
+	 * from umount fails because of a disk unplug and etc.
+	 * the absent of SB_ACTIVE means umounting.
 	 */
-	if (modified) {
-		flush_dcache_mft_record_page(ctx->ntfs_ino);
-		if (!NInoTestSetDirty(ctx->ntfs_ino))
-			mark_ntfs_record_dirty(ctx->ntfs_ino->page,
-					ctx->ntfs_ino->page_ofs);
-	}
-	ntfs_attr_put_search_ctx(ctx);
+	if ((vi->i_sb->s_flags & SB_ACTIVE) && NInoTestClearFileNameDirty(ni))
+		ntfs_inode_sync_filename(ni);
+
 	/* Now the access times are updated, write the base mft record. */
-	if (NInoDirty(ni))
+	if (NInoDirty(ni)) {
+		down_read(&mft_ni->runlist.lock);
+		err = ntfs_get_block_mft_record(mft_ni, ni);
+		up_read(&mft_ni->runlist.lock);
+		if (err)
+			goto unm_err_out;
+
 		err = write_mft_record(ni, m, sync);
+		if (err)
+			ntfs_error(vi->i_sb, "write_mft_record failed, err : %d\n", err);
+	}
+	unmap_mft_record(ni);
+
+	/* Map any unmapped extent mft records with LCNs. */
+	down_read(&mft_ni->runlist.lock);
+	mutex_lock(&ni->extent_lock);
+	if (ni->nr_extents > 0) {
+		int i;
+
+		for (i = 0; i < ni->nr_extents; i++) {
+			err = ntfs_get_block_mft_record(mft_ni,
+						   ni->ext.extent_ntfs_inos[i]);
+			if (err) {
+				mutex_unlock(&ni->extent_lock);
+				up_read(&mft_ni->runlist.lock);
+				mutex_unlock(&ni->mrec_lock);
+				goto err_out;
+			}
+		}
+	}
+	mutex_unlock(&ni->extent_lock);
+	up_read(&mft_ni->runlist.lock);
+
 	/* Write all attached extent mft records. */
 	mutex_lock(&ni->extent_lock);
 	if (ni->nr_extents > 0) {
-		ntfs_inode **extent_nis = ni->ext.extent_ntfs_inos;
+		struct ntfs_inode **extent_nis = ni->ext.extent_ntfs_inos;
 		int i;
 
 		ntfs_debug("Writing %i extent inodes.", ni->nr_extents);
 		for (i = 0; i < ni->nr_extents; i++) {
-			ntfs_inode *tni = extent_nis[i];
+			struct ntfs_inode *tni = extent_nis[i];
 
 			if (NInoDirty(tni)) {
-				MFT_RECORD *tm = map_mft_record(tni);
+				struct mft_record *tm;
 				int ret;
 
+				mutex_lock(&tni->mrec_lock);
+				tm = map_mft_record(tni);
 				if (IS_ERR(tm)) {
+					mutex_unlock(&tni->mrec_lock);
 					if (!err || err == -ENOMEM)
 						err = PTR_ERR(tm);
 					continue;
 				}
+
 				ret = write_mft_record(tni, tm, sync);
 				unmap_mft_record(tni);
+				mutex_unlock(&tni->mrec_lock);
+
 				if (unlikely(ret)) {
 					if (!err || err == -ENOMEM)
 						err = ret;
@@ -3079,24 +2850,944 @@ int __ntfs_write_inode(struct inode *vi, int sync)
 		}
 	}
 	mutex_unlock(&ni->extent_lock);
-	unmap_mft_record(ni);
+	mutex_unlock(&ni->mrec_lock);
+
 	if (unlikely(err))
 		goto err_out;
+	if (need_iput)
+		iput(vi);
 	ntfs_debug("Done.");
 	return 0;
 unm_err_out:
 	unmap_mft_record(ni);
+	mutex_unlock(&ni->mrec_lock);
 err_out:
-	if (err == -ENOMEM) {
-		ntfs_warning(vi->i_sb, "Not enough memory to write inode.  "
-				"Marking the inode dirty again, so the VFS "
-				"retries later.");
+	if (err == -ENOMEM)
 		mark_inode_dirty(vi);
-	} else {
+	else {
 		ntfs_error(vi->i_sb, "Failed (error %i):  Run chkdsk.", -err);
 		NVolSetErrors(ni->vol);
 	}
+	if (need_iput)
+		iput(vi);
+	return err;
+}
+
+/**
+ * ntfs_extent_inode_open - load an extent inode and attach it to its base
+ * @base_ni:	base ntfs inode
+ * @mref:	mft reference of the extent inode to load (in little endian)
+ *
+ * First check if the extent inode @mref is already attached to the base ntfs
+ * inode @base_ni, and if so, return a pointer to the attached extent inode.
+ *
+ * If the extent inode is not already attached to the base inode, allocate an
+ * ntfs_inode structure and initialize it for the given inode @mref. @mref
+ * specifies the inode number / mft record to read, including the sequence
+ * number, which can be 0 if no sequence number checking is to be performed.
+ *
+ * Then, allocate a buffer for the mft record, read the mft record from the
+ * volume @base_ni->vol, and attach it to the ntfs_inode structure (->mrec).
+ * The mft record is mst deprotected and sanity checked for validity and we
+ * abort if deprotection or checks fail.
+ *
+ * Finally attach the ntfs inode to its base inode @base_ni and return a
+ * pointer to the ntfs_inode structure on success or NULL on error, with errno
+ * set to the error code.
+ *
+ * Note, extent inodes are never closed directly. They are automatically
+ * disposed off by the closing of the base inode.
+ */
+static struct ntfs_inode *ntfs_extent_inode_open(struct ntfs_inode *base_ni,
+		const __le64 mref)
+{
+	u64 mft_no = MREF_LE(mref);
+	struct ntfs_inode *ni = NULL;
+	struct ntfs_inode **extent_nis;
+	int i;
+	struct mft_record *ni_mrec;
+	struct super_block *sb;
+
+	if (!base_ni)
+		return NULL;
+
+	sb = base_ni->vol->sb;
+	ntfs_debug("Opening extent inode %lld (base mft record %lld).\n",
+			(unsigned long long)mft_no,
+			(unsigned long long)base_ni->mft_no);
+
+	/* Is the extent inode already open and attached to the base inode? */
+	if (base_ni->nr_extents > 0) {
+		extent_nis = base_ni->ext.extent_ntfs_inos;
+		for (i = 0; i < base_ni->nr_extents; i++) {
+			u16 seq_no;
+
+			ni = extent_nis[i];
+			if (mft_no != ni->mft_no)
+				continue;
+			ni_mrec = map_mft_record(ni);
+			if (IS_ERR(ni_mrec)) {
+				ntfs_error(sb, "failed to map mft record for %lu",
+						ni->mft_no);
+				goto out;
+			}
+			/* Verify the sequence number if given. */
+			seq_no = MSEQNO_LE(mref);
+			if (seq_no &&
+			    seq_no != le16_to_cpu(ni_mrec->sequence_number)) {
+				ntfs_error(sb, "Found stale extent mft reference mft=%lld",
+						(long long)ni->mft_no);
+				unmap_mft_record(ni);
+				goto out;
+			}
+			unmap_mft_record(ni);
+			goto out;
+		}
+	}
+	/* Wasn't there, we need to load the extent inode. */
+	ni = ntfs_new_extent_inode(base_ni->vol->sb, mft_no);
+	if (!ni)
+		goto out;
+
+	ni->seq_no = (u16)MSEQNO_LE(mref);
+	ni->nr_extents = -1;
+	ni->ext.base_ntfs_ino = base_ni;
+	/* Attach extent inode to base inode, reallocating memory if needed. */
+	if (!(base_ni->nr_extents & 3)) {
+		i = (base_ni->nr_extents + 4) * sizeof(struct ntfs_inode *);
+
+		extent_nis = ntfs_malloc_nofs(i);
+		if (!extent_nis)
+			goto err_out;
+		if (base_ni->nr_extents) {
+			memcpy(extent_nis, base_ni->ext.extent_ntfs_inos,
+					i - 4 * sizeof(struct ntfs_inode *));
+			ntfs_free(base_ni->ext.extent_ntfs_inos);
+		}
+		base_ni->ext.extent_ntfs_inos = extent_nis;
+	}
+	base_ni->ext.extent_ntfs_inos[base_ni->nr_extents++] = ni;
+
+out:
+	ntfs_debug("\n");
+	return ni;
+err_out:
+	ntfs_destroy_ext_inode(ni);
+	ni = NULL;
+	goto out;
+}
+
+/**
+ * ntfs_inode_attach_all_extents - attach all extents for target inode
+ * @ni:		opened ntfs inode for which perform attach
+ *
+ * Return 0 on success and error.
+ */
+int ntfs_inode_attach_all_extents(struct ntfs_inode *ni)
+{
+	struct attr_list_entry *ale;
+	u64 prev_attached = 0;
+
+	if (!ni) {
+		ntfs_debug("Invalid arguments.\n");
+		return -EINVAL;
+	}
+
+	if (NInoAttr(ni))
+		ni = ni->ext.base_ntfs_ino;
+
+	ntfs_debug("Entering for inode 0x%llx.\n", (long long) ni->mft_no);
+
+	/* Inode haven't got attribute list, thus nothing to attach. */
+	if (!NInoAttrList(ni))
+		return 0;
+
+	if (!ni->attr_list) {
+		ntfs_debug("Corrupt in-memory struct.\n");
+		return -EINVAL;
+	}
+
+	/* Walk through attribute list and attach all extents. */
+	ale = (struct attr_list_entry *)ni->attr_list;
+	while ((u8 *)ale < ni->attr_list + ni->attr_list_size) {
+		if (ni->mft_no != MREF_LE(ale->mft_reference) &&
+				prev_attached != MREF_LE(ale->mft_reference)) {
+			if (!ntfs_extent_inode_open(ni, ale->mft_reference)) {
+				ntfs_debug("Couldn't attach extent inode.\n");
+				return -1;
+			}
+			prev_attached = MREF_LE(ale->mft_reference);
+		}
+		ale = (struct attr_list_entry *)((u8 *)ale + le16_to_cpu(ale->length));
+	}
+	return 0;
+}
+
+/**
+ * ntfs_inode_add_attrlist - add attribute list to inode and fill it
+ * @ni: opened ntfs inode to which add attribute list
+ *
+ * Return 0 on success or error.
+ */
+int ntfs_inode_add_attrlist(struct ntfs_inode *ni)
+{
+	int err;
+	struct ntfs_attr_search_ctx *ctx;
+	u8 *al = NULL, *aln;
+	int al_len = 0;
+	struct attr_list_entry *ale = NULL;
+	struct mft_record *ni_mrec;
+	u32 attr_al_len;
+
+	if (!ni)
+		return -EINVAL;
+
+	ntfs_debug("inode %llu\n", (unsigned long long) ni->mft_no);
+
+	if (NInoAttrList(ni) || ni->nr_extents) {
+		ntfs_error(ni->vol->sb, "Inode already has attribute list");
+		return -EEXIST;
+	}
+
+	ni_mrec = map_mft_record(ni);
+	if (IS_ERR(ni_mrec))
+		return -EIO;
+
+	/* Form attribute list. */
+	ctx = ntfs_attr_get_search_ctx(ni, ni_mrec);
+	if (!ctx) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	/* Walk through all attributes. */
+	while (!(err = ntfs_attr_lookup(AT_UNUSED, NULL, 0, 0, 0, NULL, 0, ctx))) {
+		int ale_size;
+
+		if (ctx->attr->type == AT_ATTRIBUTE_LIST) {
+			err = -EIO;
+			ntfs_error(ni->vol->sb, "Attribute list already present");
+			goto put_err_out;
+		}
+
+		ale_size = (sizeof(struct attr_list_entry) + sizeof(__le16) *
+				ctx->attr->name_length + 7) & ~7;
+		al_len += ale_size;
+
+		aln = ntfs_realloc_nofs(al, al_len, al_len-ale_size);
+		if (!aln) {
+			err = -ENOMEM;
+			ntfs_error(ni->vol->sb, "Failed to realloc %d bytes", al_len);
+			goto put_err_out;
+		}
+		ale = (struct attr_list_entry *)(aln + ((u8 *)ale - al));
+		al = aln;
+
+		memset(ale, 0, ale_size);
+
+		/* Add attribute to attribute list. */
+		ale->type = ctx->attr->type;
+		ale->length = cpu_to_le16((sizeof(struct attr_list_entry) +
+					sizeof(__le16) * ctx->attr->name_length + 7) & ~7);
+		ale->name_length = ctx->attr->name_length;
+		ale->name_offset = (u8 *)ale->name - (u8 *)ale;
+		if (ctx->attr->non_resident)
+			ale->lowest_vcn =
+				ctx->attr->data.non_resident.lowest_vcn;
+		else
+			ale->lowest_vcn = 0;
+		ale->mft_reference = MK_LE_MREF(ni->mft_no,
+				le16_to_cpu(ni_mrec->sequence_number));
+		ale->instance = ctx->attr->instance;
+		memcpy(ale->name, (u8 *)ctx->attr +
+				le16_to_cpu(ctx->attr->name_offset),
+				ctx->attr->name_length * sizeof(__le16));
+		ale = (struct attr_list_entry *)(al + al_len);
+	}
+
+	/* Check for real error occurred. */
+	if (err != -ENOENT) {
+		ntfs_error(ni->vol->sb, "%s: Attribute lookup failed, inode %lld",
+				__func__, (long long)ni->mft_no);
+		goto put_err_out;
+	}
+
+	/* Set in-memory attribute list. */
+	ni->attr_list = al;
+	ni->attr_list_size = al_len;
+	NInoSetAttrList(ni);
+
+	attr_al_len = offsetof(struct attr_record, data.resident.reserved) + 1 +
+		((al_len + 7) & ~7);
+	/* Free space if there is not enough it for $ATTRIBUTE_LIST. */
+	if (le32_to_cpu(ni_mrec->bytes_allocated) -
+			le32_to_cpu(ni_mrec->bytes_in_use) < attr_al_len) {
+		if (ntfs_inode_free_space(ni, (int)attr_al_len)) {
+			/* Failed to free space. */
+			err = -ENOSPC;
+			ntfs_error(ni->vol->sb, "Failed to free space for attrlist");
+			goto rollback;
+		}
+	}
+
+	/* Add $ATTRIBUTE_LIST to mft record. */
+	err = ntfs_resident_attr_record_add(ni, AT_ATTRIBUTE_LIST, AT_UNNAMED, 0,
+					    NULL, al_len, 0);
+	if (err < 0) {
+		ntfs_error(ni->vol->sb, "Couldn't add $ATTRIBUTE_LIST to MFT");
+		goto rollback;
+	}
+
+	err = ntfs_attrlist_update(ni);
+	if (err < 0)
+		goto remove_attrlist_record;
+
+	ntfs_attr_put_search_ctx(ctx);
+	unmap_mft_record(ni);
+	return 0;
+
+remove_attrlist_record:
+	/* Prevent ntfs_attr_recorm_rm from freeing attribute list. */
+	ni->attr_list = NULL;
+	NInoClearAttrList(ni);
+	/* Remove $ATTRIBUTE_LIST record. */
+	ntfs_attr_reinit_search_ctx(ctx);
+	if (!ntfs_attr_lookup(AT_ATTRIBUTE_LIST, NULL, 0,
+				CASE_SENSITIVE, 0, NULL, 0, ctx)) {
+		if (ntfs_attr_record_rm(ctx))
+			ntfs_error(ni->vol->sb, "Rollback failed to remove attrlist");
+	} else {
+		ntfs_error(ni->vol->sb, "Rollback failed to find attrlist");
+	}
+
+	/* Setup back in-memory runlist. */
+	ni->attr_list = al;
+	ni->attr_list_size = al_len;
+	NInoSetAttrList(ni);
+rollback:
+	/*
+	 * Scan attribute list for attributes that placed not in the base MFT
+	 * record and move them to it.
+	 */
+	ntfs_attr_reinit_search_ctx(ctx);
+	ale = (struct attr_list_entry *)al;
+	while ((u8 *)ale < al + al_len) {
+		if (MREF_LE(ale->mft_reference) != ni->mft_no) {
+			if (!ntfs_attr_lookup(ale->type, ale->name,
+						ale->name_length,
+						CASE_SENSITIVE,
+						le64_to_cpu(ale->lowest_vcn),
+						NULL, 0, ctx)) {
+				if (ntfs_attr_record_move_to(ctx, ni))
+					ntfs_error(ni->vol->sb,
+							"Rollback failed to move attribute");
+			} else {
+				ntfs_error(ni->vol->sb, "Rollback failed to find attr");
+			}
+			ntfs_attr_reinit_search_ctx(ctx);
+		}
+		ale = (struct attr_list_entry *)((u8 *)ale + le16_to_cpu(ale->length));
+	}
+
+	/* Remove in-memory attribute list. */
+	ni->attr_list = NULL;
+	ni->attr_list_size = 0;
+	NInoClearAttrList(ni);
+	NInoClearAttrListDirty(ni);
+put_err_out:
+	ntfs_attr_put_search_ctx(ctx);
+err_out:
+	ntfs_free(al);
+	unmap_mft_record(ni);
 	return err;
 }
 
-#endif /* NTFS_RW */
+/**
+ * ntfs_inode_close - close an ntfs inode and free all associated memory
+ * @ni:		ntfs inode to close
+ *
+ * Make sure the ntfs inode @ni is clean.
+ *
+ * If the ntfs inode @ni is a base inode, close all associated extent inodes,
+ * then deallocate all memory attached to it, and finally free the ntfs inode
+ * structure itself.
+ *
+ * If it is an extent inode, we disconnect it from its base inode before we
+ * destroy it.
+ *
+ * It is OK to pass NULL to this function, it is just noop in this case.
+ *
+ * Return 0 on success or error.
+ */
+int ntfs_inode_close(struct ntfs_inode *ni)
+{
+	int err = -1;
+	struct ntfs_inode **tmp_nis;
+	struct ntfs_inode *base_ni;
+	s32 i;
+
+	if (!ni)
+		return 0;
+
+	ntfs_debug("Entering for inode %lld\n", (long long)ni->mft_no);
+
+	/* Is this a base inode with mapped extent inodes? */
+	/*
+	 * If the inode is an extent inode, disconnect it from the
+	 * base inode before destroying it.
+	 */
+	base_ni = ni->ext.base_ntfs_ino;
+	for (i = 0; i < base_ni->nr_extents; ++i) {
+		tmp_nis = base_ni->ext.extent_ntfs_inos;
+		if (tmp_nis[i] != ni)
+			continue;
+		/* Found it. Disconnect. */
+		memmove(tmp_nis + i, tmp_nis + i + 1,
+				(base_ni->nr_extents - i - 1) *
+				sizeof(struct ntfs_inode *));
+		/* Buffer should be for multiple of four extents. */
+		if ((--base_ni->nr_extents) & 3) {
+			i = -1;
+			break;
+		}
+		/*
+		 * ElectricFence is unhappy with realloc(x,0) as free(x)
+		 * thus we explicitly separate these two cases.
+		 */
+		if (base_ni->nr_extents) {
+			/* Resize the memory buffer. */
+			tmp_nis = ntfs_realloc_nofs(tmp_nis, base_ni->nr_extents *
+					sizeof(struct ntfs_inode *), base_ni->nr_extents *
+					sizeof(struct ntfs_inode *));
+			/* Ignore errors, they don't really matter. */
+			if (tmp_nis)
+				base_ni->ext.extent_ntfs_inos = tmp_nis;
+		} else if (tmp_nis) {
+			ntfs_free(tmp_nis);
+			base_ni->ext.extent_ntfs_inos = NULL;
+		}
+		/* Allow for error checking. */
+		i = -1;
+		break;
+	}
+
+	if (NInoDirty(ni))
+		ntfs_error(ni->vol->sb, "Releasing dirty inode %lld!\n",
+				(long long)ni->mft_no);
+	if (NInoAttrList(ni) && ni->attr_list)
+		ntfs_free(ni->attr_list);
+	ntfs_destroy_ext_inode(ni);
+	err = 0;
+	ntfs_debug("\n");
+	return err;
+}
+
+void ntfs_destroy_ext_inode(struct ntfs_inode *ni)
+{
+	ntfs_debug("Entering.");
+	if (ni == NULL)
+		return;
+
+	ntfs_attr_close(ni);
+
+	if (NInoDirty(ni))
+		ntfs_error(ni->vol->sb, "Releasing dirty ext inode %lld!\n",
+				(long long)ni->mft_no);
+	if (NInoAttrList(ni) && ni->attr_list)
+		ntfs_free(ni->attr_list);
+	kfree(ni->mrec);
+	kmem_cache_free(ntfs_inode_cache, ni);
+}
+
+static struct ntfs_inode *ntfs_inode_base(struct ntfs_inode *ni)
+{
+	if (ni->nr_extents == -1)
+		return ni->ext.base_ntfs_ino;
+	return ni;
+}
+
+static int ntfs_attr_position(__le32 type, struct ntfs_attr_search_ctx *ctx)
+{
+	int err;
+
+	err = ntfs_attr_lookup(type, NULL, 0, CASE_SENSITIVE, 0, NULL,
+				0, ctx);
+	if (err) {
+		__le32 atype;
+
+		if (err != -ENOENT)
+			return err;
+
+		atype = ctx->attr->type;
+		if (atype == AT_END)
+			return -ENOSPC;
+
+		/*
+		 * if ntfs_external_attr_lookup return -ENOENT, ctx->al_entry
+		 * could point to an attribute in an extent mft record, but
+		 * ctx->attr and ctx->ntfs_ino always points to an attibute in
+		 * a base mft record.
+		 */
+		if (ctx->al_entry &&
+		    MREF_LE(ctx->al_entry->mft_reference) != ctx->ntfs_ino->mft_no) {
+			ntfs_attr_reinit_search_ctx(ctx);
+			err = ntfs_attr_lookup(atype, NULL, 0, CASE_SENSITIVE, 0, NULL,
+					       0, ctx);
+			if (err)
+				return err;
+		}
+	}
+	return 0;
+}
+
+/**
+ * ntfs_inode_free_space - free space in the MFT record of inode
+ * @ni:		ntfs inode in which MFT record free space
+ * @size:	amount of space needed to free
+ *
+ * Return 0 on success or error.
+ */
+int ntfs_inode_free_space(struct ntfs_inode *ni, int size)
+{
+	struct ntfs_attr_search_ctx *ctx;
+	int freed, err;
+	struct mft_record *ni_mrec;
+	struct super_block *sb;
+
+	if (!ni || size < 0)
+		return -EINVAL;
+	ntfs_debug("Entering for inode %lld, size %d\n",
+			(unsigned long long)ni->mft_no, size);
+
+	sb = ni->vol->sb;
+	ni_mrec = map_mft_record(ni);
+	if (IS_ERR(ni_mrec))
+		return -EIO;
+
+	freed = (le32_to_cpu(ni_mrec->bytes_allocated) -
+			le32_to_cpu(ni_mrec->bytes_in_use));
+
+	unmap_mft_record(ni);
+
+	if (size <= freed)
+		return 0;
+
+	ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	if (!ctx) {
+		ntfs_error(sb, "%s, Failed to get search context", __func__);
+		return -ENOMEM;
+	}
+
+	/*
+	 * Chkdsk complain if $STANDARD_INFORMATION is not in the base MFT
+	 * record.
+	 *
+	 * Also we can't move $ATTRIBUTE_LIST from base MFT_RECORD, so position
+	 * search context on first attribute after $STANDARD_INFORMATION and
+	 * $ATTRIBUTE_LIST.
+	 *
+	 * Why we reposition instead of simply skip this attributes during
+	 * enumeration? Because in case we have got only in-memory attribute
+	 * list ntfs_attr_lookup will fail when it will try to find
+	 * $ATTRIBUTE_LIST.
+	 */
+	err = ntfs_attr_position(AT_FILE_NAME, ctx);
+	if (err)
+		goto put_err_out;
+
+	while (1) {
+		int record_size;
+
+		/*
+		 * Check whether attribute is from different MFT record. If so,
+		 * find next, because we don't need such.
+		 */
+		while (ctx->ntfs_ino->mft_no != ni->mft_no) {
+retry:
+			err = ntfs_attr_lookup(AT_UNUSED, NULL, 0, CASE_SENSITIVE,
+						0, NULL, 0, ctx);
+			if (err) {
+				if (err != -ENOENT)
+					ntfs_error(sb, "Attr lookup failed #2");
+				else if (ctx->attr->type == AT_END)
+					err = -ENOSPC;
+				else
+					err = 0;
+
+				if (err)
+					goto put_err_out;
+			}
+		}
+
+		if (ntfs_inode_base(ctx->ntfs_ino)->mft_no == FILE_MFT &&
+				ctx->attr->type == AT_DATA)
+			goto retry;
+
+		if (ctx->attr->type == AT_INDEX_ROOT)
+			goto retry;
+
+		record_size = le32_to_cpu(ctx->attr->length);
+
+		/* Move away attribute. */
+		err = ntfs_attr_record_move_away(ctx, 0);
+		if (err) {
+			ntfs_error(sb, "Failed to move out attribute #2");
+			break;
+		}
+		freed += record_size;
+
+		/* Check whether we done. */
+		if (size <= freed) {
+			ntfs_attr_put_search_ctx(ctx);
+			return 0;
+		}
+
+		/*
+		 * Reposition to first attribute after $STANDARD_INFORMATION and
+		 * $ATTRIBUTE_LIST (see comments upwards).
+		 */
+		ntfs_attr_reinit_search_ctx(ctx);
+		err = ntfs_attr_position(AT_FILE_NAME, ctx);
+		if (err)
+			break;
+	}
+put_err_out:
+	ntfs_attr_put_search_ctx(ctx);
+	if (err == -ENOSPC)
+		ntfs_debug("No attributes left that can be moved out.\n");
+	return err;
+}
+
+s64 ntfs_inode_attr_pread(struct inode *vi, s64 pos, s64 count, u8 *buf)
+{
+	struct address_space *mapping = vi->i_mapping;
+	struct folio *folio;
+	struct ntfs_inode *ni = NTFS_I(vi);
+	s64 isize;
+	u32 attr_len, total = 0, offset;
+	pgoff_t index;
+	int err = 0;
+
+	WARN_ON(!NInoAttr(ni));
+	if (!count)
+		return 0;
+
+	mutex_lock(&ni->mrec_lock);
+	isize = i_size_read(vi);
+	if (pos > isize) {
+		mutex_unlock(&ni->mrec_lock);
+		return -EINVAL;
+	}
+	if (pos + count > isize)
+		count = isize - pos;
+
+	if (!NInoNonResident(ni)) {
+		struct ntfs_attr_search_ctx *ctx;
+		u8 *attr;
+
+		ctx = ntfs_attr_get_search_ctx(ni->ext.base_ntfs_ino, NULL);
+		if (!ctx) {
+			ntfs_error(vi->i_sb, "Failed to get attr search ctx");
+			err = -ENOMEM;
+			mutex_unlock(&ni->mrec_lock);
+			goto out;
+		}
+
+		err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len, CASE_SENSITIVE,
+				       0, NULL, 0, ctx);
+		if (err) {
+			ntfs_error(vi->i_sb, "Failed to look up attr %#x", ni->type);
+			ntfs_attr_put_search_ctx(ctx);
+			mutex_unlock(&ni->mrec_lock);
+			goto out;
+		}
+
+		attr = (u8 *)ctx->attr + le16_to_cpu(ctx->attr->data.resident.value_offset);
+		memcpy(buf, (u8 *)attr + pos, count);
+		ntfs_attr_put_search_ctx(ctx);
+		mutex_unlock(&ni->mrec_lock);
+		return count;
+	}
+	mutex_unlock(&ni->mrec_lock);
+
+	index = pos >> PAGE_SHIFT;
+	do {
+		/* Update @index and get the next folio. */
+		folio = read_mapping_folio(mapping, index, NULL);
+		if (IS_ERR(folio))
+			break;
+
+		offset = offset_in_folio(folio, pos);
+		attr_len = min_t(size_t, (size_t)count, folio_size(folio) - offset);
+
+		folio_lock(folio);
+		memcpy_from_folio(buf, folio, offset, attr_len);
+		folio_unlock(folio);
+		folio_put(folio);
+
+		total += attr_len;
+		buf += attr_len;
+		pos += attr_len;
+		count -= attr_len;
+		index++;
+	} while (count);
+out:
+	return err ? (s64)err : total;
+}
+
+static inline int ntfs_enlarge_attribute(struct inode *vi, s64 pos, s64 count,
+					 struct ntfs_attr_search_ctx *ctx)
+{
+	struct ntfs_inode *ni = NTFS_I(vi);
+	struct super_block *sb = vi->i_sb;
+	int ret;
+
+	if (pos + count <= ni->initialized_size)
+		return 0;
+
+	if (NInoEncrypted(ni) && NInoNonResident(ni))
+		return -EACCES;
+
+	if (NInoCompressed(ni))
+		return -EOPNOTSUPP;
+
+	if (pos + count > ni->data_size) {
+		if (ntfs_attr_truncate(ni, pos + count)) {
+			ntfs_debug("Failed to truncate attribute");
+			return -1;
+		}
+
+		ntfs_attr_reinit_search_ctx(ctx);
+		ret = ntfs_attr_lookup(ni->type,
+				       ni->name, ni->name_len, CASE_SENSITIVE,
+				       0, NULL, 0, ctx);
+		if (ret) {
+			ntfs_error(sb, "Failed to look up attr %#x", ni->type);
+			return ret;
+		}
+	}
+
+	if (!NInoNonResident(ni)) {
+		if (likely(i_size_read(vi) < ni->data_size))
+			i_size_write(vi, ni->data_size);
+		return 0;
+	}
+
+	if (pos + count > ni->initialized_size) {
+		ctx->attr->data.non_resident.initialized_size = cpu_to_le64(pos + count);
+		mark_mft_record_dirty(ctx->ntfs_ino);
+		ni->initialized_size = pos + count;
+		if (i_size_read(vi) < ni->initialized_size)
+			i_size_write(vi, ni->initialized_size);
+	}
+	return 0;
+}
+
+static s64 __ntfs_inode_resident_attr_pwrite(struct inode *vi,
+					     s64 pos, s64 count, u8 *buf,
+					     struct ntfs_attr_search_ctx *ctx)
+{
+	struct ntfs_inode *ni = NTFS_I(vi);
+	struct folio *folio;
+	struct address_space *mapping = vi->i_mapping;
+	u8 *addr;
+	int err = 0;
+
+	WARN_ON(NInoNonResident(ni));
+	if (pos + count > PAGE_SIZE) {
+		ntfs_error(vi->i_sb, "Out of write into resident attr %#x", ni->type);
+		return -EINVAL;
+	}
+
+	/* Copy to mft record page */
+	addr = (u8 *)ctx->attr + le16_to_cpu(ctx->attr->data.resident.value_offset);
+	memcpy(addr + pos, buf, count);
+	mark_mft_record_dirty(ctx->ntfs_ino);
+
+	/* Keep the first page clean and uptodate */
+	folio = __filemap_get_folio(mapping, 0, FGP_WRITEBEGIN | FGP_NOFS,
+				   mapping_gfp_mask(mapping));
+	if (IS_ERR(folio)) {
+		err = PTR_ERR(folio);
+		ntfs_error(vi->i_sb, "Failed to read a page 0 for attr %#x: %d",
+			   ni->type, err);
+		goto out;
+	}
+	if (!folio_test_uptodate(folio)) {
+		u32 len = le32_to_cpu(ctx->attr->data.resident.value_length);
+
+		memcpy_to_folio(folio, 0, addr, len);
+		folio_zero_segment(folio, offset_in_folio(folio, len),
+				   folio_size(folio) - len);
+	} else {
+		memcpy_to_folio(folio, offset_in_folio(folio, pos), buf, count);
+	}
+	folio_mark_uptodate(folio);
+	folio_unlock(folio);
+	folio_put(folio);
+out:
+	return err ? err : count;
+}
+
+static s64 __ntfs_inode_non_resident_attr_pwrite(struct inode *vi,
+						 s64 pos, s64 count, u8 *buf,
+						 struct ntfs_attr_search_ctx *ctx,
+						 bool sync)
+{
+	struct ntfs_inode *ni = NTFS_I(vi);
+	struct address_space *mapping = vi->i_mapping;
+	struct folio *folio;
+	pgoff_t index;
+	unsigned long offset, length;
+	size_t attr_len;
+	s64 ret = 0, written = 0;
+
+	WARN_ON(!NInoNonResident(ni));
+
+	index = pos >> PAGE_SHIFT;
+	while (count) {
+		if (count == PAGE_SIZE) {
+			folio = __filemap_get_folio(vi->i_mapping, index,
+					FGP_CREAT | FGP_LOCK,
+					mapping_gfp_mask(mapping));
+			if (IS_ERR(folio)) {
+				ret = -ENOMEM;
+				break;
+			}
+		} else {
+			folio = read_mapping_folio(mapping, index, NULL);
+			if (IS_ERR(folio)) {
+				ret = PTR_ERR(folio);
+				ntfs_error(vi->i_sb, "Failed to read a page %lu for attr %#x: %ld",
+						index, ni->type, PTR_ERR(folio));
+				break;
+			}
+
+			folio_lock(folio);
+		}
+
+		if (count == PAGE_SIZE) {
+			offset = 0;
+			attr_len = count;
+		} else {
+			offset = offset_in_folio(folio, pos);
+			attr_len = min_t(size_t, (size_t)count, folio_size(folio) - offset);
+		}
+		memcpy_to_folio(folio, offset, buf, attr_len);
+
+		if (sync) {
+			struct ntfs_volume *vol = ni->vol;
+			s64 lcn, lcn_count;
+			unsigned int lcn_folio_off = 0;
+			struct bio *bio;
+			u64 rl_length = 0;
+			s64 vcn;
+			struct runlist_element *rl;
+
+			lcn_count = max_t(s64, 1, NTFS_B_TO_CLU(vol, attr_len));
+			vcn = NTFS_PIDX_TO_CLU(vol, folio->index);
+
+			do {
+				down_write(&ni->runlist.lock);
+				rl = ntfs_attr_vcn_to_rl(ni, vcn, &lcn);
+				if (IS_ERR(rl)) {
+					ret = PTR_ERR(rl);
+					up_write(&ni->runlist.lock);
+					goto err_unlock_folio;
+				}
+
+				rl_length = rl->length - (vcn - rl->vcn);
+				if (rl_length < lcn_count) {
+					lcn_count -= rl_length;
+				} else {
+					rl_length = lcn_count;
+					lcn_count = 0;
+				}
+				up_write(&ni->runlist.lock);
+
+				if (vol->cluster_size_bits > PAGE_SHIFT) {
+					lcn_folio_off = folio->index << PAGE_SHIFT;
+					lcn_folio_off &= vol->cluster_size_mask;
+				}
+
+				bio = bio_alloc(vol->sb->s_bdev, 1, REQ_OP_WRITE,
+						GFP_NOIO);
+				bio->bi_iter.bi_sector =
+					NTFS_B_TO_SECTOR(vol, NTFS_CLU_TO_B(vol, lcn) +
+							 lcn_folio_off);
+
+				length = min_t(unsigned long,
+					       NTFS_CLU_TO_B(vol, rl_length),
+					       folio_size(folio));
+				if (!bio_add_folio(bio, folio, length, offset)) {
+					ret = -EIO;
+					bio_put(bio);
+					goto err_unlock_folio;
+				}
+
+				submit_bio_wait(bio);
+				bio_put(bio);
+				vcn += rl_length;
+				offset += length;
+			} while (lcn_count != 0);
+
+			folio_mark_uptodate(folio);
+		} else {
+			folio_mark_uptodate(folio);
+			folio_mark_dirty(folio);
+		}
+err_unlock_folio:
+		folio_unlock(folio);
+		folio_put(folio);
+
+		if (ret)
+			break;
+
+		written += attr_len;
+		buf += attr_len;
+		pos += attr_len;
+		count -= attr_len;
+		index++;
+
+		cond_resched();
+	}
+
+	return ret ? ret : written;
+}
+
+s64 ntfs_inode_attr_pwrite(struct inode *vi, s64 pos, s64 count, u8 *buf, bool sync)
+{
+	struct ntfs_inode *ni = NTFS_I(vi);
+	struct ntfs_attr_search_ctx *ctx;
+	s64 ret;
+
+	WARN_ON(!NInoAttr(ni));
+
+	ctx = ntfs_attr_get_search_ctx(ni->ext.base_ntfs_ino, NULL);
+	if (!ctx) {
+		ntfs_error(vi->i_sb, "Failed to get attr search ctx");
+		return -ENOMEM;
+	}
+
+	ret = ntfs_attr_lookup(ni->type, ni->name, ni->name_len, CASE_SENSITIVE,
+			       0, NULL, 0, ctx);
+	if (ret) {
+		ntfs_attr_put_search_ctx(ctx);
+		ntfs_error(vi->i_sb, "Failed to look up attr %#x", ni->type);
+		return ret;
+	}
+
+	mutex_lock(&ni->mrec_lock);
+	ret = ntfs_enlarge_attribute(vi, pos, count, ctx);
+	mutex_unlock(&ni->mrec_lock);
+	if (ret)
+		goto out;
+
+	if (NInoNonResident(ni))
+		ret = __ntfs_inode_non_resident_attr_pwrite(vi, pos, count, buf, ctx, sync);
+	else
+		ret = __ntfs_inode_resident_attr_pwrite(vi, pos, count, buf, ctx);
+out:
+	ntfs_attr_put_search_ctx(ctx);
+	return ret;
+}
diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index 6fd1dc4b08c8..a0043a0676e2 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -1,57 +1,119 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * mft.c - NTFS kernel mft record operations. Part of the Linux-NTFS project.
+ * NTFS kernel mft record operations. Part of the Linux-NTFS project.
+ * Part of this file is based on code from the NTFS-3G project.
  *
  * Copyright (c) 2001-2012 Anton Altaparmakov and Tuxera Inc.
  * Copyright (c) 2002 Richard Russon
+ * Copyright (c) 2025 LG Electronics Co., Ltd.
  */
 
-#include <linux/buffer_head.h>
-#include <linux/slab.h>
-#include <linux/swap.h>
 #include <linux/bio.h>
 
-#include "attrib.h"
 #include "aops.h"
 #include "bitmap.h"
-#include "debug.h"
-#include "dir.h"
 #include "lcnalloc.h"
 #include "malloc.h"
 #include "mft.h"
 #include "ntfs.h"
 
-#define MAX_BHS	(PAGE_SIZE / NTFS_BLOCK_SIZE)
+/*
+ * ntfs_mft_record_check - Check the consistency of an MFT record
+ *
+ * Make sure its general fields are safe, then examine all its
+ * attributes and apply generic checks to them.
+ *
+ * Returns 0 if the checks are successful. If not, return -EIO.
+ */
+int ntfs_mft_record_check(const struct ntfs_volume *vol, struct mft_record *m,
+		unsigned long mft_no)
+{
+	struct attr_record *a;
+	struct super_block *sb = vol->sb;
+
+	if (!ntfs_is_file_record(m->magic)) {
+		ntfs_error(sb, "Record %llu has no FILE magic (0x%x)\n",
+				(unsigned long long)mft_no, le32_to_cpu(*(__le32 *)m));
+		goto err_out;
+	}
+
+	if ((m->usa_ofs & 0x1) ||
+	    (vol->mft_record_size >> NTFS_BLOCK_SIZE_BITS) + 1 != le16_to_cpu(m->usa_count) ||
+	    le16_to_cpu(m->usa_ofs) + le16_to_cpu(m->usa_count) * 2 > vol->mft_record_size) {
+		ntfs_error(sb, "Record %llu has corrupt fix-up values fields\n",
+				(unsigned long long)mft_no);
+		goto err_out;
+	}
+
+	if (le32_to_cpu(m->bytes_allocated) != vol->mft_record_size) {
+		ntfs_error(sb, "Record %llu has corrupt allocation size (%u <> %u)\n",
+				(unsigned long long)mft_no,
+				vol->mft_record_size,
+				le32_to_cpu(m->bytes_allocated));
+		goto err_out;
+	}
+
+	if (le32_to_cpu(m->bytes_in_use) > vol->mft_record_size) {
+		ntfs_error(sb, "Record %llu has corrupt in-use size (%u > %u)\n",
+				(unsigned long long)mft_no,
+				le32_to_cpu(m->bytes_in_use),
+				vol->mft_record_size);
+		goto err_out;
+	}
+
+	if (le16_to_cpu(m->attrs_offset) & 7) {
+		ntfs_error(sb, "Attributes badly aligned in record %llu\n",
+				(unsigned long long)mft_no);
+		goto err_out;
+	}
+
+	a = (struct attr_record *)((char *)m + le16_to_cpu(m->attrs_offset));
+	if ((char *)a < (char *)m || (char *)a > (char *)m + vol->mft_record_size) {
+		ntfs_error(sb, "Record %llu is corrupt\n",
+				(unsigned long long)mft_no);
+		goto err_out;
+	}
+
+	return 0;
+
+err_out:
+	return -EIO;
+}
 
 /**
  * map_mft_record_page - map the page in which a specific mft record resides
  * @ni:		ntfs inode whose mft record page to map
  *
- * This maps the page in which the mft record of the ntfs inode @ni is situated
- * and returns a pointer to the mft record within the mapped page.
+ * This maps the folio in which the mft record of the ntfs inode @ni is
+ * situated.
  *
- * Return value needs to be checked with IS_ERR() and if that is true PTR_ERR()
- * contains the negative error code returned.
+ * This allocates a new buffer (@ni->mrec), copies the MFT record data from
+ * the mapped folio into this buffer, and applies the MST (Multi Sector
+ * Transfer) fixups on the copy.
+ *
+ * The folio is pinned (referenced) in @ni->folio to ensure the data remains
+ * valid in the page cache, but the returned pointer is the allocated copy.
+ *
+ * Return: A pointer to the allocated and fixed-up mft record (@ni->mrec).
+ * The return value needs to be checked with IS_ERR(). If it is true,
+ * PTR_ERR() contains the negative error code.
  */
-static inline MFT_RECORD *map_mft_record_page(ntfs_inode *ni)
+static inline struct mft_record *map_mft_record_folio(struct ntfs_inode *ni)
 {
 	loff_t i_size;
-	ntfs_volume *vol = ni->vol;
+	struct ntfs_volume *vol = ni->vol;
 	struct inode *mft_vi = vol->mft_ino;
-	struct page *page;
+	struct folio *folio;
 	unsigned long index, end_index;
-	unsigned ofs;
+	unsigned int ofs;
 
-	BUG_ON(ni->page);
+	WARN_ON(ni->folio);
 	/*
 	 * The index into the page cache and the offset within the page cache
-	 * page of the wanted mft record. FIXME: We need to check for
-	 * overflowing the unsigned long, but I don't think we would ever get
-	 * here if the volume was that big...
+	 * page of the wanted mft record.
 	 */
-	index = (u64)ni->mft_no << vol->mft_record_size_bits >>
-			PAGE_SHIFT;
-	ofs = (ni->mft_no << vol->mft_record_size_bits) & ~PAGE_MASK;
+	index = NTFS_MFT_NR_TO_PIDX(vol, ni->mft_no);
+	ofs = NTFS_MFT_NR_TO_POFS(vol, ni->mft_no);
 
 	i_size = i_size_read(mft_vi);
 	/* The maximum valid index into the page cache for $MFT's data. */
@@ -61,169 +123,126 @@ static inline MFT_RECORD *map_mft_record_page(ntfs_inode *ni)
 	if (unlikely(index >= end_index)) {
 		if (index > end_index || (i_size & ~PAGE_MASK) < ofs +
 				vol->mft_record_size) {
-			page = ERR_PTR(-ENOENT);
-			ntfs_error(vol->sb, "Attempt to read mft record 0x%lx, "
-					"which is beyond the end of the mft.  "
-					"This is probably a bug in the ntfs "
-					"driver.", ni->mft_no);
+			folio = ERR_PTR(-ENOENT);
+			ntfs_error(vol->sb,
+				"Attempt to read mft record 0x%lx, which is beyond the end of the mft. This is probably a bug in the ntfs driver.",
+				ni->mft_no);
 			goto err_out;
 		}
 	}
-	/* Read, map, and pin the page. */
-	page = ntfs_map_page(mft_vi->i_mapping, index);
-	if (!IS_ERR(page)) {
+
+	/* Read, map, and pin the folio. */
+	folio = read_mapping_folio(mft_vi->i_mapping, index, NULL);
+	if (!IS_ERR(folio)) {
+		u8 *addr;
+
+		ni->mrec = kmalloc(vol->mft_record_size, GFP_NOFS);
+		if (!ni->mrec) {
+			folio_put(folio);
+			folio = ERR_PTR(-ENOMEM);
+			goto err_out;
+		}
+
+		addr = kmap_local_folio(folio, 0);
+		memcpy(ni->mrec, addr + ofs, vol->mft_record_size);
+		post_read_mst_fixup((struct ntfs_record *)ni->mrec, vol->mft_record_size);
+
 		/* Catch multi sector transfer fixup errors. */
-		if (likely(ntfs_is_mft_recordp((le32*)(page_address(page) +
-				ofs)))) {
-			ni->page = page;
-			ni->page_ofs = ofs;
-			return page_address(page) + ofs;
+		if (!ntfs_mft_record_check(vol, (struct mft_record *)ni->mrec, ni->mft_no)) {
+			kunmap_local(addr);
+			ni->folio = folio;
+			ni->folio_ofs = ofs;
+			return ni->mrec;
 		}
-		ntfs_error(vol->sb, "Mft record 0x%lx is corrupt.  "
-				"Run chkdsk.", ni->mft_no);
-		ntfs_unmap_page(page);
-		page = ERR_PTR(-EIO);
+		kunmap_local(addr);
+		folio_put(folio);
+		kfree(ni->mrec);
+		ni->mrec = NULL;
+		folio = ERR_PTR(-EIO);
 		NVolSetErrors(vol);
 	}
 err_out:
-	ni->page = NULL;
-	ni->page_ofs = 0;
-	return (void*)page;
+	ni->folio = NULL;
+	ni->folio_ofs = 0;
+	return (void *)folio;
 }
 
 /**
- * map_mft_record - map, pin and lock an mft record
+ * map_mft_record - map and pin an mft record
  * @ni:		ntfs inode whose MFT record to map
  *
- * First, take the mrec_lock mutex.  We might now be sleeping, while waiting
- * for the mutex if it was already locked by someone else.
- *
- * The page of the record is mapped using map_mft_record_page() before being
- * returned to the caller.
- *
- * This in turn uses ntfs_map_page() to get the page containing the wanted mft
- * record (it in turn calls read_cache_page() which reads it in from disk if
- * necessary, increments the use count on the page so that it cannot disappear
- * under us and returns a reference to the page cache page).
- *
- * If read_cache_page() invokes ntfs_readpage() to load the page from disk, it
- * sets PG_locked and clears PG_uptodate on the page. Once I/O has completed
- * and the post-read mst fixups on each mft record in the page have been
- * performed, the page gets PG_uptodate set and PG_locked cleared (this is done
- * in our asynchronous I/O completion handler end_buffer_read_mft_async()).
- * ntfs_map_page() waits for PG_locked to become clear and checks if
- * PG_uptodate is set and returns an error code if not. This provides
- * sufficient protection against races when reading/using the page.
- *
- * However there is the write mapping to think about. Doing the above described
- * checking here will be fine, because when initiating the write we will set
- * PG_locked and clear PG_uptodate making sure nobody is touching the page
- * contents. Doing the locking this way means that the commit to disk code in
- * the page cache code paths is automatically sufficiently locked with us as
- * we will not touch a page that has been locked or is not uptodate. The only
- * locking problem then is them locking the page while we are accessing it.
- *
- * So that code will end up having to own the mrec_lock of all mft
- * records/inodes present in the page before I/O can proceed. In that case we
- * wouldn't need to bother with PG_locked and PG_uptodate as nobody will be
- * accessing anything without owning the mrec_lock mutex.  But we do need to
- * use them because of the read_cache_page() invocation and the code becomes so
- * much simpler this way that it is well worth it.
- *
- * The mft record is now ours and we return a pointer to it. You need to check
- * the returned pointer with IS_ERR() and if that is true, PTR_ERR() will return
- * the error code.
- *
- * NOTE: Caller is responsible for setting the mft record dirty before calling
- * unmap_mft_record(). This is obviously only necessary if the caller really
- * modified the mft record...
- * Q: Do we want to recycle one of the VFS inode state bits instead?
- * A: No, the inode ones mean we want to change the mft record, not we want to
- * write it out.
+ * This function ensures the MFT record for the given inode is mapped and
+ * accessible.
+ *
+ * It increments the reference count of the ntfs inode. If the record is
+ * already mapped (@ni->folio is set), it returns the cached record
+ * immediately.
+ *
+ * Otherwise, it calls map_mft_record_folio() to read the folio from disk
+ * (if necessary via read_mapping_folio), allocate a buffer, and copy the
+ * record data.
+ *
+ * Return: A pointer to the mft record. You need to check the returned
+ * pointer with IS_ERR().
  */
-MFT_RECORD *map_mft_record(ntfs_inode *ni)
+struct mft_record *map_mft_record(struct ntfs_inode *ni)
 {
-	MFT_RECORD *m;
+	struct mft_record *m;
+
+	if (!ni)
+		return ERR_PTR(-EINVAL);
 
 	ntfs_debug("Entering for mft_no 0x%lx.", ni->mft_no);
 
 	/* Make sure the ntfs inode doesn't go away. */
 	atomic_inc(&ni->count);
 
-	/* Serialize access to this mft record. */
-	mutex_lock(&ni->mrec_lock);
+	if (ni->folio)
+		return (struct mft_record *)ni->mrec;
 
-	m = map_mft_record_page(ni);
+	m = map_mft_record_folio(ni);
 	if (!IS_ERR(m))
 		return m;
 
-	mutex_unlock(&ni->mrec_lock);
 	atomic_dec(&ni->count);
 	ntfs_error(ni->vol->sb, "Failed with error code %lu.", -PTR_ERR(m));
 	return m;
 }
 
 /**
- * unmap_mft_record_page - unmap the page in which a specific mft record resides
- * @ni:		ntfs inode whose mft record page to unmap
- *
- * This unmaps the page in which the mft record of the ntfs inode @ni is
- * situated and returns. This is a NOOP if highmem is not configured.
- *
- * The unmap happens via ntfs_unmap_page() which in turn decrements the use
- * count on the page thus releasing it from the pinned state.
- *
- * We do not actually unmap the page from memory of course, as that will be
- * done by the page cache code itself when memory pressure increases or
- * whatever.
- */
-static inline void unmap_mft_record_page(ntfs_inode *ni)
-{
-	BUG_ON(!ni->page);
-
-	// TODO: If dirty, blah...
-	ntfs_unmap_page(ni->page);
-	ni->page = NULL;
-	ni->page_ofs = 0;
-	return;
-}
-
-/**
- * unmap_mft_record - release a mapped mft record
+ * unmap_mft_record - release a reference to a mapped mft record
  * @ni:		ntfs inode whose MFT record to unmap
  *
- * We release the page mapping and the mrec_lock mutex which unmaps the mft
- * record and releases it for others to get hold of. We also release the ntfs
- * inode by decrementing the ntfs inode reference count.
+ * This decrements the reference count of the ntfs inode.
+ *
+ * It releases the caller's hold on the inode. If the reference count indicates
+ * that there are still other users (count > 1), the function returns
+ * immediately, keeping the resources (folio and mrec buffer) pinned for
+ * those users.
  *
  * NOTE: If caller has modified the mft record, it is imperative to set the mft
  * record dirty BEFORE calling unmap_mft_record().
  */
-void unmap_mft_record(ntfs_inode *ni)
+void unmap_mft_record(struct ntfs_inode *ni)
 {
-	struct page *page = ni->page;
+	struct folio *folio;
 
-	BUG_ON(!page);
+	if (!ni)
+		return;
 
 	ntfs_debug("Entering for mft_no 0x%lx.", ni->mft_no);
 
-	unmap_mft_record_page(ni);
-	mutex_unlock(&ni->mrec_lock);
-	atomic_dec(&ni->count);
-	/*
-	 * If pure ntfs_inode, i.e. no vfs inode attached, we leave it to
-	 * ntfs_clear_extent_inode() in the extent inode case, and to the
-	 * caller in the non-extent, yet pure ntfs inode case, to do the actual
-	 * tear down of all structures and freeing of all allocated memory.
-	 */
-	return;
+	folio = ni->folio;
+	if (atomic_dec_return(&ni->count) > 1)
+		return;
+	WARN_ON(!folio);
 }
 
 /**
  * map_extent_mft_record - load an extent inode and attach it to its base
  * @base_ni:	base ntfs inode
  * @mref:	mft reference of the extent inode to load
- * @ntfs_ino:	on successful return, pointer to the ntfs_inode structure
+ * @ntfs_ino:	on successful return, pointer to the struct ntfs_inode structure
  *
  * Load the extent mft record @mref and attach it to its base inode @base_ni.
  * Return the mapped extent mft record if IS_ERR(result) is false.  Otherwise
@@ -232,12 +251,12 @@ void unmap_mft_record(ntfs_inode *ni)
  * On successful return, @ntfs_ino contains a pointer to the ntfs_inode
  * structure of the mapped extent inode.
  */
-MFT_RECORD *map_extent_mft_record(ntfs_inode *base_ni, MFT_REF mref,
-		ntfs_inode **ntfs_ino)
+struct mft_record *map_extent_mft_record(struct ntfs_inode *base_ni, u64 mref,
+		struct ntfs_inode **ntfs_ino)
 {
-	MFT_RECORD *m;
-	ntfs_inode *ni = NULL;
-	ntfs_inode **extent_nis = NULL;
+	struct mft_record *m;
+	struct ntfs_inode *ni = NULL;
+	struct ntfs_inode **extent_nis = NULL;
 	int i;
 	unsigned long mft_no = MREF(mref);
 	u16 seq_no = MSEQNO(mref);
@@ -252,6 +271,7 @@ MFT_RECORD *map_extent_mft_record(ntfs_inode *base_ni, MFT_REF mref,
 	 * in which case just return it. If not found, add it to the base
 	 * inode before returning it.
 	 */
+retry:
 	mutex_lock(&base_ni->extent_lock);
 	if (base_ni->nr_extents > 0) {
 		extent_nis = base_ni->ext.extent_ntfs_inos;
@@ -279,20 +299,21 @@ MFT_RECORD *map_extent_mft_record(ntfs_inode *base_ni, MFT_REF mref,
 				return m;
 			}
 			unmap_mft_record(ni);
-			ntfs_error(base_ni->vol->sb, "Found stale extent mft "
-					"reference! Corrupt filesystem. "
-					"Run chkdsk.");
+			ntfs_error(base_ni->vol->sb,
+					"Found stale extent mft reference! Corrupt filesystem. Run chkdsk.");
 			return ERR_PTR(-EIO);
 		}
 map_err_out:
-		ntfs_error(base_ni->vol->sb, "Failed to map extent "
-				"mft record, error code %ld.", -PTR_ERR(m));
+		ntfs_error(base_ni->vol->sb,
+				"Failed to map extent mft record, error code %ld.",
+				-PTR_ERR(m));
 		return m;
 	}
+	mutex_unlock(&base_ni->extent_lock);
+
 	/* Record wasn't there. Get a new ntfs inode and initialize it. */
 	ni = ntfs_new_extent_inode(base_ni->vol->sb, mft_no);
 	if (unlikely(!ni)) {
-		mutex_unlock(&base_ni->extent_lock);
 		atomic_dec(&base_ni->count);
 		return ERR_PTR(-ENOMEM);
 	}
@@ -303,37 +324,44 @@ MFT_RECORD *map_extent_mft_record(ntfs_inode *base_ni, MFT_REF mref,
 	/* Now map the record. */
 	m = map_mft_record(ni);
 	if (IS_ERR(m)) {
-		mutex_unlock(&base_ni->extent_lock);
 		atomic_dec(&base_ni->count);
 		ntfs_clear_extent_inode(ni);
 		goto map_err_out;
 	}
 	/* Verify the sequence number if it is present. */
 	if (seq_no && (le16_to_cpu(m->sequence_number) != seq_no)) {
-		ntfs_error(base_ni->vol->sb, "Found stale extent mft "
-				"reference! Corrupt filesystem. Run chkdsk.");
+		ntfs_error(base_ni->vol->sb,
+				"Found stale extent mft reference! Corrupt filesystem. Run chkdsk.");
 		destroy_ni = true;
 		m = ERR_PTR(-EIO);
-		goto unm_err_out;
+		goto unm_nolock_err_out;
+	}
+
+	mutex_lock(&base_ni->extent_lock);
+	for (i = 0; i < base_ni->nr_extents; i++) {
+		if (mft_no == extent_nis[i]->mft_no) {
+			mutex_unlock(&base_ni->extent_lock);
+			ntfs_clear_extent_inode(ni);
+			goto retry;
+		}
 	}
 	/* Attach extent inode to base inode, reallocating memory if needed. */
 	if (!(base_ni->nr_extents & 3)) {
-		ntfs_inode **tmp;
-		int new_size = (base_ni->nr_extents + 4) * sizeof(ntfs_inode *);
+		struct ntfs_inode **tmp;
+		int new_size = (base_ni->nr_extents + 4) * sizeof(struct ntfs_inode *);
 
-		tmp = kmalloc(new_size, GFP_NOFS);
+		tmp = ntfs_malloc_nofs(new_size);
 		if (unlikely(!tmp)) {
-			ntfs_error(base_ni->vol->sb, "Failed to allocate "
-					"internal buffer.");
+			ntfs_error(base_ni->vol->sb, "Failed to allocate internal buffer.");
 			destroy_ni = true;
 			m = ERR_PTR(-ENOMEM);
 			goto unm_err_out;
 		}
 		if (base_ni->nr_extents) {
-			BUG_ON(!base_ni->ext.extent_ntfs_inos);
+			WARN_ON(!base_ni->ext.extent_ntfs_inos);
 			memcpy(tmp, base_ni->ext.extent_ntfs_inos, new_size -
-					4 * sizeof(ntfs_inode *));
-			kfree(base_ni->ext.extent_ntfs_inos);
+					4 * sizeof(struct ntfs_inode *));
+			ntfs_free(base_ni->ext.extent_ntfs_inos);
 		}
 		base_ni->ext.extent_ntfs_inos = tmp;
 	}
@@ -344,8 +372,9 @@ MFT_RECORD *map_extent_mft_record(ntfs_inode *base_ni, MFT_REF mref,
 	*ntfs_ino = ni;
 	return m;
 unm_err_out:
-	unmap_mft_record(ni);
 	mutex_unlock(&base_ni->extent_lock);
+unm_nolock_err_out:
+	unmap_mft_record(ni);
 	atomic_dec(&base_ni->count);
 	/*
 	 * If the extent inode was not attached to the base inode we need to
@@ -356,18 +385,14 @@ MFT_RECORD *map_extent_mft_record(ntfs_inode *base_ni, MFT_REF mref,
 	return m;
 }
 
-#ifdef NTFS_RW
-
 /**
- * __mark_mft_record_dirty - set the mft record and the page containing it dirty
+ * __mark_mft_record_dirty - mark the base vfs inode dirty
  * @ni:		ntfs inode describing the mapped mft record
  *
  * Internal function.  Users should call mark_mft_record_dirty() instead.
  *
- * Set the mapped (extent) mft record of the (base or extent) ntfs inode @ni,
- * as well as the page containing the mft record, dirty.  Also, mark the base
- * vfs inode dirty.  This ensures that any changes to the mft record are
- * written out to disk.
+ * This function determines the base ntfs inode (in case @ni is an extent
+ * inode) and marks the corresponding VFS inode dirty.
  *
  * NOTE:  We only set I_DIRTY_DATASYNC (and not I_DIRTY_PAGES)
  * on the base vfs inode, because even though file data may have been modified,
@@ -381,64 +406,25 @@ MFT_RECORD *map_extent_mft_record(ntfs_inode *base_ni, MFT_REF mref,
  * I_DIRTY_SYNC, since the file data has not actually hit the block device yet,
  * which is not what I_DIRTY_SYNC on its own would suggest.
  */
-void __mark_mft_record_dirty(ntfs_inode *ni)
+void __mark_mft_record_dirty(struct ntfs_inode *ni)
 {
-	ntfs_inode *base_ni;
+	struct ntfs_inode *base_ni;
 
 	ntfs_debug("Entering for inode 0x%lx.", ni->mft_no);
-	BUG_ON(NInoAttr(ni));
-	mark_ntfs_record_dirty(ni->page, ni->page_ofs);
+	WARN_ON(NInoAttr(ni));
 	/* Determine the base vfs inode and mark it dirty, too. */
-	mutex_lock(&ni->extent_lock);
 	if (likely(ni->nr_extents >= 0))
 		base_ni = ni;
 	else
 		base_ni = ni->ext.base_ntfs_ino;
-	mutex_unlock(&ni->extent_lock);
 	__mark_inode_dirty(VFS_I(base_ni), I_DIRTY_DATASYNC);
 }
 
-static const char *ntfs_please_email = "Please email "
-		"linux-ntfs-dev@lists.sourceforge.net and say that you saw "
-		"this message.  Thank you.";
-
-/**
- * ntfs_sync_mft_mirror_umount - synchronise an mft record to the mft mirror
- * @vol:	ntfs volume on which the mft record to synchronize resides
- * @mft_no:	mft record number of mft record to synchronize
- * @m:		mapped, mst protected (extent) mft record to synchronize
- *
- * Write the mapped, mst protected (extent) mft record @m with mft record
- * number @mft_no to the mft mirror ($MFTMirr) of the ntfs volume @vol,
- * bypassing the page cache and the $MFTMirr inode itself.
- *
- * This function is only for use at umount time when the mft mirror inode has
- * already been disposed off.  We BUG() if we are called while the mft mirror
- * inode is still attached to the volume.
- *
- * On success return 0.  On error return -errno.
- *
- * NOTE:  This function is not implemented yet as I am not convinced it can
- * actually be triggered considering the sequence of commits we do in super.c::
- * ntfs_put_super().  But just in case we provide this place holder as the
- * alternative would be either to BUG() or to get a NULL pointer dereference
- * and Oops.
- */
-static int ntfs_sync_mft_mirror_umount(ntfs_volume *vol,
-		const unsigned long mft_no, MFT_RECORD *m)
-{
-	BUG_ON(vol->mftmirr_ino);
-	ntfs_error(vol->sb, "Umount time mft mirror syncing is not "
-			"implemented yet.  %s", ntfs_please_email);
-	return -EOPNOTSUPP;
-}
-
 /**
  * ntfs_sync_mft_mirror - synchronize an mft record to the mft mirror
  * @vol:	ntfs volume on which the mft record to synchronize resides
  * @mft_no:	mft record number of mft record to synchronize
  * @m:		mapped, mst protected (extent) mft record to synchronize
- * @sync:	if true, wait for i/o completion
  *
  * Write the mapped, mst protected (extent) mft record @m with mft record
  * number @mft_no to the mft mirror ($MFTMirr) of the ntfs volume @vol.
@@ -446,181 +432,76 @@ static int ntfs_sync_mft_mirror_umount(ntfs_volume *vol,
  * On success return 0.  On error return -errno and set the volume errors flag
  * in the ntfs volume @vol.
  *
- * NOTE:  We always perform synchronous i/o and ignore the @sync parameter.
- *
- * TODO:  If @sync is false, want to do truly asynchronous i/o, i.e. just
- * schedule i/o via ->writepage or do it via kntfsd or whatever.
+ * NOTE:  We always perform synchronous i/o.
  */
-int ntfs_sync_mft_mirror(ntfs_volume *vol, const unsigned long mft_no,
-		MFT_RECORD *m, int sync)
+int ntfs_sync_mft_mirror(struct ntfs_volume *vol, const unsigned long mft_no,
+		struct mft_record *m)
 {
-	struct page *page;
-	unsigned int blocksize = vol->sb->s_blocksize;
-	int max_bhs = vol->mft_record_size / blocksize;
-	struct buffer_head *bhs[MAX_BHS];
-	struct buffer_head *bh, *head;
-	u8 *kmirr;
-	runlist_element *rl;
-	unsigned int block_start, block_end, m_start, m_end, page_ofs;
-	int i_bhs, nr_bhs, err = 0;
-	unsigned char blocksize_bits = vol->sb->s_blocksize_bits;
+	u8 *kmirr = NULL;
+	struct folio *folio;
+	unsigned int folio_ofs, lcn_folio_off = 0;
+	int err = 0;
+	struct bio *bio;
 
 	ntfs_debug("Entering for inode 0x%lx.", mft_no);
-	BUG_ON(!max_bhs);
-	if (WARN_ON(max_bhs > MAX_BHS))
-		return -EINVAL;
+
 	if (unlikely(!vol->mftmirr_ino)) {
 		/* This could happen during umount... */
-		err = ntfs_sync_mft_mirror_umount(vol, mft_no, m);
-		if (likely(!err))
-			return err;
+		err = -EIO;
 		goto err_out;
 	}
 	/* Get the page containing the mirror copy of the mft record @m. */
-	page = ntfs_map_page(vol->mftmirr_ino->i_mapping, mft_no >>
-			(PAGE_SHIFT - vol->mft_record_size_bits));
-	if (IS_ERR(page)) {
+	folio = read_mapping_folio(vol->mftmirr_ino->i_mapping,
+			NTFS_MFT_NR_TO_PIDX(vol, mft_no), NULL);
+	if (IS_ERR(folio)) {
 		ntfs_error(vol->sb, "Failed to map mft mirror page.");
-		err = PTR_ERR(page);
+		err = PTR_ERR(folio);
 		goto err_out;
 	}
-	lock_page(page);
-	BUG_ON(!PageUptodate(page));
-	ClearPageUptodate(page);
+
+	folio_lock(folio);
+	folio_clear_uptodate(folio);
 	/* Offset of the mft mirror record inside the page. */
-	page_ofs = (mft_no << vol->mft_record_size_bits) & ~PAGE_MASK;
+	folio_ofs = NTFS_MFT_NR_TO_POFS(vol, mft_no);
 	/* The address in the page of the mirror copy of the mft record @m. */
-	kmirr = page_address(page) + page_ofs;
+	kmirr = kmap_local_folio(folio, 0) + folio_ofs;
 	/* Copy the mst protected mft record to the mirror. */
 	memcpy(kmirr, m, vol->mft_record_size);
-	/* Create uptodate buffers if not present. */
-	if (unlikely(!page_has_buffers(page))) {
-		struct buffer_head *tail;
-
-		bh = head = alloc_page_buffers(page, blocksize, true);
-		do {
-			set_buffer_uptodate(bh);
-			tail = bh;
-			bh = bh->b_this_page;
-		} while (bh);
-		tail->b_this_page = head;
-		attach_page_private(page, head);
-	}
-	bh = head = page_buffers(page);
-	BUG_ON(!bh);
-	rl = NULL;
-	nr_bhs = 0;
-	block_start = 0;
-	m_start = kmirr - (u8*)page_address(page);
-	m_end = m_start + vol->mft_record_size;
-	do {
-		block_end = block_start + blocksize;
-		/* If the buffer is outside the mft record, skip it. */
-		if (block_end <= m_start)
-			continue;
-		if (unlikely(block_start >= m_end))
-			break;
-		/* Need to map the buffer if it is not mapped already. */
-		if (unlikely(!buffer_mapped(bh))) {
-			VCN vcn;
-			LCN lcn;
-			unsigned int vcn_ofs;
-
-			bh->b_bdev = vol->sb->s_bdev;
-			/* Obtain the vcn and offset of the current block. */
-			vcn = ((VCN)mft_no << vol->mft_record_size_bits) +
-					(block_start - m_start);
-			vcn_ofs = vcn & vol->cluster_size_mask;
-			vcn >>= vol->cluster_size_bits;
-			if (!rl) {
-				down_read(&NTFS_I(vol->mftmirr_ino)->
-						runlist.lock);
-				rl = NTFS_I(vol->mftmirr_ino)->runlist.rl;
-				/*
-				 * $MFTMirr always has the whole of its runlist
-				 * in memory.
-				 */
-				BUG_ON(!rl);
-			}
-			/* Seek to element containing target vcn. */
-			while (rl->length && rl[1].vcn <= vcn)
-				rl++;
-			lcn = ntfs_rl_vcn_to_lcn(rl, vcn);
-			/* For $MFTMirr, only lcn >= 0 is a successful remap. */
-			if (likely(lcn >= 0)) {
-				/* Setup buffer head to correct block. */
-				bh->b_blocknr = ((lcn <<
-						vol->cluster_size_bits) +
-						vcn_ofs) >> blocksize_bits;
-				set_buffer_mapped(bh);
-			} else {
-				bh->b_blocknr = -1;
-				ntfs_error(vol->sb, "Cannot write mft mirror "
-						"record 0x%lx because its "
-						"location on disk could not "
-						"be determined (error code "
-						"%lli).", mft_no,
-						(long long)lcn);
-				err = -EIO;
-			}
-		}
-		BUG_ON(!buffer_uptodate(bh));
-		BUG_ON(!nr_bhs && (m_start != block_start));
-		BUG_ON(nr_bhs >= max_bhs);
-		bhs[nr_bhs++] = bh;
-		BUG_ON((nr_bhs >= max_bhs) && (m_end != block_end));
-	} while (block_start = block_end, (bh = bh->b_this_page) != head);
-	if (unlikely(rl))
-		up_read(&NTFS_I(vol->mftmirr_ino)->runlist.lock);
-	if (likely(!err)) {
-		/* Lock buffers and start synchronous write i/o on them. */
-		for (i_bhs = 0; i_bhs < nr_bhs; i_bhs++) {
-			struct buffer_head *tbh = bhs[i_bhs];
-
-			if (!trylock_buffer(tbh))
-				BUG();
-			BUG_ON(!buffer_uptodate(tbh));
-			clear_buffer_dirty(tbh);
-			get_bh(tbh);
-			tbh->b_end_io = end_buffer_write_sync;
-			submit_bh(REQ_OP_WRITE, tbh);
-		}
-		/* Wait on i/o completion of buffers. */
-		for (i_bhs = 0; i_bhs < nr_bhs; i_bhs++) {
-			struct buffer_head *tbh = bhs[i_bhs];
 
-			wait_on_buffer(tbh);
-			if (unlikely(!buffer_uptodate(tbh))) {
-				err = -EIO;
-				/*
-				 * Set the buffer uptodate so the page and
-				 * buffer states do not become out of sync.
-				 */
-				set_buffer_uptodate(tbh);
-			}
-		}
-	} else /* if (unlikely(err)) */ {
-		/* Clean the buffers. */
-		for (i_bhs = 0; i_bhs < nr_bhs; i_bhs++)
-			clear_buffer_dirty(bhs[i_bhs]);
+	if (vol->cluster_size_bits > PAGE_SHIFT) {
+		lcn_folio_off = folio->index << PAGE_SHIFT;
+		lcn_folio_off &= vol->cluster_size_mask;
 	}
+
+	bio = bio_alloc(vol->sb->s_bdev, 1, REQ_OP_WRITE, GFP_NOIO);
+	bio->bi_iter.bi_sector =
+		NTFS_B_TO_SECTOR(vol, NTFS_CLU_TO_B(vol, vol->mftmirr_lcn) +
+				 lcn_folio_off + folio_ofs);
+
+	if (!bio_add_folio(bio, folio, vol->mft_record_size, folio_ofs)) {
+		err = -EIO;
+		bio_put(bio);
+		goto unlock_folio;
+	}
+
+	bio->bi_end_io = ntfs_bio_end_io;
+	submit_bio(bio);
 	/* Current state: all buffers are clean, unlocked, and uptodate. */
-	/* Remove the mst protection fixups again. */
-	post_write_mst_fixup((NTFS_RECORD*)kmirr);
-	flush_dcache_page(page);
-	SetPageUptodate(page);
-	unlock_page(page);
-	ntfs_unmap_page(page);
+	flush_dcache_folio(folio);
+	folio_mark_uptodate(folio);
+
+unlock_folio:
+	folio_unlock(folio);
+	kunmap_local(kmirr);
+	folio_put(folio);
 	if (likely(!err)) {
 		ntfs_debug("Done.");
 	} else {
-		ntfs_error(vol->sb, "I/O error while writing mft mirror "
-				"record 0x%lx!", mft_no);
+		ntfs_error(vol->sb, "I/O error while writing mft mirror record 0x%lx!", mft_no);
 err_out:
-		ntfs_error(vol->sb, "Failed to synchronize $MFTMirr (error "
-				"code %i).  Volume will be left marked dirty "
-				"on umount.  Run ntfsfix on the partition "
-				"after umounting to correct this.", -err);
+		ntfs_error(vol->sb,
+			"Failed to synchronize $MFTMirr (error code %i).  Volume will be left marked dirty on umount.  Run chkdsk on the partition after umounting to correct this.",
+			err);
 		NVolSetErrors(vol);
 	}
 	return err;
@@ -636,191 +517,95 @@ int ntfs_sync_mft_mirror(ntfs_volume *vol, const unsigned long mft_no,
  * ntfs inode @ni to backing store.  If the mft record @m has a counterpart in
  * the mft mirror, that is also updated.
  *
- * We only write the mft record if the ntfs inode @ni is dirty and the first
- * buffer belonging to its mft record is dirty, too.  We ignore the dirty state
- * of subsequent buffers because we could have raced with
- * fs/ntfs/aops.c::mark_ntfs_record_dirty().
- *
- * On success, clean the mft record and return 0.  On error, leave the mft
- * record dirty and return -errno.
- *
- * NOTE:  We always perform synchronous i/o and ignore the @sync parameter.
- * However, if the mft record has a counterpart in the mft mirror and @sync is
- * true, we write the mft record, wait for i/o completion, and only then write
- * the mft mirror copy.  This ensures that if the system crashes either the mft
- * or the mft mirror will contain a self-consistent mft record @m.  If @sync is
- * false on the other hand, we start i/o on both and then wait for completion
- * on them.  This provides a speedup but no longer guarantees that you will end
- * up with a self-consistent mft record in the case of a crash but if you asked
- * for asynchronous writing you probably do not care about that anyway.
- *
- * TODO:  If @sync is false, want to do truly asynchronous i/o, i.e. just
- * schedule i/o via ->writepage or do it via kntfsd or whatever.
+ * We only write the mft record if the ntfs inode @ni is dirty.
+ *
+ * On success, clean the mft record and return 0.
+ * On error (specifically ENOMEM), we redirty the record so it can be retried.
+ * For other errors, we mark the volume with errors.
  */
-int write_mft_record_nolock(ntfs_inode *ni, MFT_RECORD *m, int sync)
+int write_mft_record_nolock(struct ntfs_inode *ni, struct mft_record *m, int sync)
 {
-	ntfs_volume *vol = ni->vol;
-	struct page *page = ni->page;
-	unsigned int blocksize = vol->sb->s_blocksize;
-	unsigned char blocksize_bits = vol->sb->s_blocksize_bits;
-	int max_bhs = vol->mft_record_size / blocksize;
-	struct buffer_head *bhs[MAX_BHS];
-	struct buffer_head *bh, *head;
-	runlist_element *rl;
-	unsigned int block_start, block_end, m_start, m_end;
-	int i_bhs, nr_bhs, err = 0;
+	struct ntfs_volume *vol = ni->vol;
+	struct folio *folio = ni->folio;
+	int err = 0, i = 0;
+	u8 *kaddr;
+	struct mft_record *fixup_m;
+	struct bio *bio;
+	unsigned int offset = 0, folio_size;
 
 	ntfs_debug("Entering for inode 0x%lx.", ni->mft_no);
-	BUG_ON(NInoAttr(ni));
-	BUG_ON(!max_bhs);
-	BUG_ON(!PageLocked(page));
-	if (WARN_ON(max_bhs > MAX_BHS)) {
-		err = -EINVAL;
-		goto err_out;
-	}
+
+	WARN_ON(NInoAttr(ni));
+	WARN_ON(!folio_test_locked(folio));
+
 	/*
-	 * If the ntfs_inode is clean no need to do anything.  If it is dirty,
+	 * If the struct ntfs_inode is clean no need to do anything.  If it is dirty,
 	 * mark it as clean now so that it can be redirtied later on if needed.
 	 * There is no danger of races since the caller is holding the locks
 	 * for the mft record @m and the page it is in.
 	 */
 	if (!NInoTestClearDirty(ni))
 		goto done;
-	bh = head = page_buffers(page);
-	BUG_ON(!bh);
-	rl = NULL;
-	nr_bhs = 0;
-	block_start = 0;
-	m_start = ni->page_ofs;
-	m_end = m_start + vol->mft_record_size;
-	do {
-		block_end = block_start + blocksize;
-		/* If the buffer is outside the mft record, skip it. */
-		if (block_end <= m_start)
-			continue;
-		if (unlikely(block_start >= m_end))
-			break;
-		/*
-		 * If this block is not the first one in the record, we ignore
-		 * the buffer's dirty state because we could have raced with a
-		 * parallel mark_ntfs_record_dirty().
-		 */
-		if (block_start == m_start) {
-			/* This block is the first one in the record. */
-			if (!buffer_dirty(bh)) {
-				BUG_ON(nr_bhs);
-				/* Clean records are not written out. */
-				break;
-			}
-		}
-		/* Need to map the buffer if it is not mapped already. */
-		if (unlikely(!buffer_mapped(bh))) {
-			VCN vcn;
-			LCN lcn;
-			unsigned int vcn_ofs;
-
-			bh->b_bdev = vol->sb->s_bdev;
-			/* Obtain the vcn and offset of the current block. */
-			vcn = ((VCN)ni->mft_no << vol->mft_record_size_bits) +
-					(block_start - m_start);
-			vcn_ofs = vcn & vol->cluster_size_mask;
-			vcn >>= vol->cluster_size_bits;
-			if (!rl) {
-				down_read(&NTFS_I(vol->mft_ino)->runlist.lock);
-				rl = NTFS_I(vol->mft_ino)->runlist.rl;
-				BUG_ON(!rl);
-			}
-			/* Seek to element containing target vcn. */
-			while (rl->length && rl[1].vcn <= vcn)
-				rl++;
-			lcn = ntfs_rl_vcn_to_lcn(rl, vcn);
-			/* For $MFT, only lcn >= 0 is a successful remap. */
-			if (likely(lcn >= 0)) {
-				/* Setup buffer head to correct block. */
-				bh->b_blocknr = ((lcn <<
-						vol->cluster_size_bits) +
-						vcn_ofs) >> blocksize_bits;
-				set_buffer_mapped(bh);
-			} else {
-				bh->b_blocknr = -1;
-				ntfs_error(vol->sb, "Cannot write mft record "
-						"0x%lx because its location "
-						"on disk could not be "
-						"determined (error code %lli).",
-						ni->mft_no, (long long)lcn);
-				err = -EIO;
-			}
-		}
-		BUG_ON(!buffer_uptodate(bh));
-		BUG_ON(!nr_bhs && (m_start != block_start));
-		BUG_ON(nr_bhs >= max_bhs);
-		bhs[nr_bhs++] = bh;
-		BUG_ON((nr_bhs >= max_bhs) && (m_end != block_end));
-	} while (block_start = block_end, (bh = bh->b_this_page) != head);
-	if (unlikely(rl))
-		up_read(&NTFS_I(vol->mft_ino)->runlist.lock);
-	if (!nr_bhs)
-		goto done;
-	if (unlikely(err))
-		goto cleanup_out;
+
+	kaddr = kmap_local_folio(folio, 0);
+	fixup_m = (struct mft_record *)(kaddr + ni->folio_ofs);
+	memcpy(fixup_m, m, vol->mft_record_size);
+
 	/* Apply the mst protection fixups. */
-	err = pre_write_mst_fixup((NTFS_RECORD*)m, vol->mft_record_size);
+	err = pre_write_mst_fixup((struct ntfs_record *)fixup_m, vol->mft_record_size);
 	if (err) {
 		ntfs_error(vol->sb, "Failed to apply mst fixups!");
-		goto cleanup_out;
-	}
-	flush_dcache_mft_record_page(ni);
-	/* Lock buffers and start synchronous write i/o on them. */
-	for (i_bhs = 0; i_bhs < nr_bhs; i_bhs++) {
-		struct buffer_head *tbh = bhs[i_bhs];
-
-		if (!trylock_buffer(tbh))
-			BUG();
-		BUG_ON(!buffer_uptodate(tbh));
-		clear_buffer_dirty(tbh);
-		get_bh(tbh);
-		tbh->b_end_io = end_buffer_write_sync;
-		submit_bh(REQ_OP_WRITE, tbh);
-	}
-	/* Synchronize the mft mirror now if not @sync. */
-	if (!sync && ni->mft_no < vol->mftmirr_size)
-		ntfs_sync_mft_mirror(vol, ni->mft_no, m, sync);
-	/* Wait on i/o completion of buffers. */
-	for (i_bhs = 0; i_bhs < nr_bhs; i_bhs++) {
-		struct buffer_head *tbh = bhs[i_bhs];
-
-		wait_on_buffer(tbh);
-		if (unlikely(!buffer_uptodate(tbh))) {
+		goto err_out;
+	}
+
+	folio_size = vol->mft_record_size / ni->mft_lcn_count;
+	while (i < ni->mft_lcn_count) {
+		unsigned int clu_off;
+
+		clu_off = (unsigned int)((s64)ni->mft_no * vol->mft_record_size + offset) &
+			vol->cluster_size_mask;
+
+		flush_dcache_folio(folio);
+
+		bio = bio_alloc(vol->sb->s_bdev, 1, REQ_OP_WRITE, GFP_NOIO);
+		bio->bi_iter.bi_sector =
+			NTFS_B_TO_SECTOR(vol, NTFS_CLU_TO_B(vol, ni->mft_lcn[i]) +
+					 clu_off);
+
+		if (!bio_add_folio(bio, folio, folio_size,
+				   ni->folio_ofs + offset)) {
 			err = -EIO;
-			/*
-			 * Set the buffer uptodate so the page and buffer
-			 * states do not become out of sync.
-			 */
-			if (PageUptodate(page))
-				set_buffer_uptodate(tbh);
+			goto put_bio_out;
 		}
+
+		/* Synchronize the mft mirror now if not @sync. */
+		if (!sync && ni->mft_no < vol->mftmirr_size)
+			ntfs_sync_mft_mirror(vol, ni->mft_no, fixup_m);
+
+		folio_get(folio);
+		bio->bi_private = folio;
+		bio->bi_end_io = ntfs_bio_end_io;
+		submit_bio(bio);
+		offset += vol->cluster_size;
+		i++;
 	}
+
 	/* If @sync, now synchronize the mft mirror. */
 	if (sync && ni->mft_no < vol->mftmirr_size)
-		ntfs_sync_mft_mirror(vol, ni->mft_no, m, sync);
-	/* Remove the mst protection fixups again. */
-	post_write_mst_fixup((NTFS_RECORD*)m);
-	flush_dcache_mft_record_page(ni);
+		ntfs_sync_mft_mirror(vol, ni->mft_no, fixup_m);
+	kunmap_local(kaddr);
 	if (unlikely(err)) {
 		/* I/O error during writing.  This is really bad! */
-		ntfs_error(vol->sb, "I/O error while writing mft record "
-				"0x%lx!  Marking base inode as bad.  You "
-				"should unmount the volume and run chkdsk.",
-				ni->mft_no);
+		ntfs_error(vol->sb,
+			"I/O error while writing mft record 0x%lx!  Marking base inode as bad.  You should unmount the volume and run chkdsk.",
+			ni->mft_no);
 		goto err_out;
 	}
 done:
 	ntfs_debug("Done.");
 	return 0;
-cleanup_out:
-	/* Clean the buffers. */
-	for (i_bhs = 0; i_bhs < nr_bhs; i_bhs++)
-		clear_buffer_dirty(bhs[i_bhs]);
+put_bio_out:
+	bio_put(bio);
 err_out:
 	/*
 	 * Current state: all buffers are clean, unlocked, and uptodate.
@@ -829,8 +614,8 @@ int write_mft_record_nolock(ntfs_inode *ni, MFT_RECORD *m, int sync)
 	 * and other allocated memory will be freed.
 	 */
 	if (err == -ENOMEM) {
-		ntfs_error(vol->sb, "Not enough memory to write mft record.  "
-				"Redirtying so the write is retried later.");
+		ntfs_error(vol->sb,
+			"Not enough memory to write mft record. Redirtying so the write is retried later.");
 		mark_mft_record_dirty(ni);
 		err = 0;
 	} else
@@ -838,6 +623,39 @@ int write_mft_record_nolock(ntfs_inode *ni, MFT_RECORD *m, int sync)
 	return err;
 }
 
+static int ntfs_test_inode_wb(struct inode *vi, unsigned long ino, void *data)
+{
+	struct ntfs_attr *na = (struct ntfs_attr *)data;
+
+	if (!ntfs_test_inode(vi, na))
+		return 0;
+
+	/*
+	 * Without this, ntfs_write_mst_block() could call iput_final()
+	 * , and ntfs_evict_big_inode() could try to unlink this inode
+	 * and the contex could be blocked infinitly in map_mft_record().
+	 */
+	if (NInoBeingDeleted(NTFS_I(vi))) {
+		na->state = NI_BeingDeleted;
+		return -1;
+	}
+
+	/*
+	 * This condition can prevent ntfs_write_mst_block()
+	 * from applying/undo fixups while ntfs_create() being
+	 * called
+	 */
+	spin_lock(&vi->i_lock);
+	if (inode_state_read_once(vi) & I_CREATING) {
+		spin_unlock(&vi->i_lock);
+		na->state = NI_BeingCreated;
+		return -1;
+	}
+	spin_unlock(&vi->i_lock);
+
+	return igrab(vi) ? 1 : -1;
+}
+
 /**
  * ntfs_may_write_mft_record - check if an mft record may be written out
  * @vol:	[IN]  ntfs volume on which the mft record to check resides
@@ -856,19 +674,14 @@ int write_mft_record_nolock(ntfs_inode *ni, MFT_RECORD *m, int sync)
  *
  * The caller has locked the page and cleared the uptodate flag on it which
  * means that we can safely write out any dirty mft records that do not have
- * their inodes in icache as determined by ilookup5() as anyone
- * opening/creating such an inode would block when attempting to map the mft
- * record in read_cache_page() until we are finished with the write out.
+ * their inodes in icache as determined by find_inode_nowait().
  *
  * Here is a description of the tests we perform:
  *
  * If the inode is found in icache we know the mft record must be a base mft
  * record.  If it is dirty, we do not write it and return 'false' as the vfs
  * inode write paths will result in the access times being updated which would
- * cause the base mft record to be redirtied and written out again.  (We know
- * the access time update will modify the base mft record because Windows
- * chkdsk complains if the standard information attribute is not in the base
- * mft record.)
+ * cause the base mft record to be redirtied and written out again.
  *
  * If the inode is in icache and not dirty, we attempt to lock the mft record
  * and if we find the lock was already taken, it is not safe to write the mft
@@ -879,9 +692,7 @@ int write_mft_record_nolock(ntfs_inode *ni, MFT_RECORD *m, int sync)
  * @locked_ni to the locked ntfs inode and return 'true'.
  *
  * Note we cannot just lock the mft record and sleep while waiting for the lock
- * because this would deadlock due to lock reversal (normally the mft record is
- * locked before the page is locked but we already have the page locked here
- * when we try to lock the mft record).
+ * because this would deadlock due to lock reversal.
  *
  * If the inode is not in icache we need to perform further checks.
  *
@@ -889,49 +700,36 @@ int write_mft_record_nolock(ntfs_inode *ni, MFT_RECORD *m, int sync)
  * safely write it and return 'true'.
  *
  * We now know the mft record is an extent mft record.  We check if the inode
- * corresponding to its base mft record is in icache and obtain a reference to
- * it if it is.  If it is not, we can safely write it and return 'true'.
+ * corresponding to its base mft record is in icache. If it is not, we cannot
+ * safely determine the state of the extent inode, so we return 'false'.
  *
  * We now have the base inode for the extent mft record.  We check if it has an
- * ntfs inode for the extent mft record attached and if not it is safe to write
+ * ntfs inode for the extent mft record attached. If not, it is safe to write
  * the extent mft record and we return 'true'.
  *
- * The ntfs inode for the extent mft record is attached to the base inode so we
- * attempt to lock the extent mft record and if we find the lock was already
- * taken, it is not safe to write the extent mft record and we return 'false'.
+ * If the extent inode is attached, we check if it is dirty. If so, we return
+ * 'false' (letting the standard write_inode path handle it).
+ *
+ * If it is not dirty, we attempt to lock the extent mft record. If the lock
+ * was already taken, it is not safe to write and we return 'false'.
  *
  * If we manage to obtain the lock we have exclusive access to the extent mft
- * record, which also allows us safe writeout of the extent mft record.  We
- * set the ntfs inode of the extent mft record clean and then set @locked_ni to
- * the now locked ntfs inode and return 'true'.
- *
- * Note, the reason for actually writing dirty mft records here and not just
- * relying on the vfs inode dirty code paths is that we can have mft records
- * modified without them ever having actual inodes in memory.  Also we can have
- * dirty mft records with clean ntfs inodes in memory.  None of the described
- * cases would result in the dirty mft records being written out if we only
- * relied on the vfs inode dirty code paths.  And these cases can really occur
- * during allocation of new mft records and in particular when the
- * initialized_size of the $MFT/$DATA attribute is extended and the new space
- * is initialized using ntfs_mft_record_format().  The clean inode can then
- * appear if the mft record is reused for a new inode before it got written
- * out.
+ * record. We set @locked_ni to the now locked ntfs inode and return 'true'.
  */
-bool ntfs_may_write_mft_record(ntfs_volume *vol, const unsigned long mft_no,
-		const MFT_RECORD *m, ntfs_inode **locked_ni)
+bool ntfs_may_write_mft_record(struct ntfs_volume *vol, const unsigned long mft_no,
+		const struct mft_record *m, struct ntfs_inode **locked_ni)
 {
 	struct super_block *sb = vol->sb;
 	struct inode *mft_vi = vol->mft_ino;
 	struct inode *vi;
-	ntfs_inode *ni, *eni, **extent_nis;
+	struct ntfs_inode *ni, *eni, **extent_nis;
 	int i;
-	ntfs_attr na;
+	struct ntfs_attr na = {0};
 
 	ntfs_debug("Entering for inode 0x%lx.", mft_no);
 	/*
 	 * Normally we do not return a locked inode so set @locked_ni to NULL.
 	 */
-	BUG_ON(!locked_ni);
 	*locked_ni = NULL;
 	/*
 	 * Check if the inode corresponding to this mft record is in the VFS
@@ -939,8 +737,6 @@ bool ntfs_may_write_mft_record(ntfs_volume *vol, const unsigned long mft_no,
 	 */
 	ntfs_debug("Looking for inode 0x%lx in icache.", mft_no);
 	na.mft_no = mft_no;
-	na.name = NULL;
-	na.name_len = 0;
 	na.type = AT_UNUSED;
 	/*
 	 * Optimize inode 0, i.e. $MFT itself, since we have it in memory and
@@ -949,16 +745,16 @@ bool ntfs_may_write_mft_record(ntfs_volume *vol, const unsigned long mft_no,
 	if (!mft_no) {
 		/* Balance the below iput(). */
 		vi = igrab(mft_vi);
-		BUG_ON(vi != mft_vi);
+		WARN_ON(vi != mft_vi);
 	} else {
 		/*
-		 * Have to use ilookup5_nowait() since ilookup5() waits for the
-		 * inode lock which causes ntfs to deadlock when a concurrent
-		 * inode write via the inode dirty code paths and the page
-		 * dirty code path of the inode dirty code path when writing
-		 * $MFT occurs.
+		 * Have to use find_inode_nowait() since ilookup5_nowait()
+		 * waits for inode with I_FREEING, which causes ntfs to deadlock
+		 * when inodes are unlinked concurrently
 		 */
-		vi = ilookup5_nowait(sb, mft_no, ntfs_test_inode, &na);
+		vi = find_inode_nowait(sb, mft_no, ntfs_test_inode_wb, &na);
+		if (na.state == NI_BeingDeleted || na.state == NI_BeingCreated)
+			return false;
 	}
 	if (vi) {
 		ntfs_debug("Base inode 0x%lx is in icache.", mft_no);
@@ -977,8 +773,7 @@ bool ntfs_may_write_mft_record(ntfs_volume *vol, const unsigned long mft_no,
 		ntfs_debug("Inode 0x%lx is not dirty.", mft_no);
 		/* The inode is not dirty, try to take the mft record lock. */
 		if (unlikely(!mutex_trylock(&ni->mrec_lock))) {
-			ntfs_debug("Mft record 0x%lx is already locked, do "
-					"not write it.", mft_no);
+			ntfs_debug("Mft record 0x%lx is already locked, do not write it.", mft_no);
 			atomic_dec(&ni->count);
 			iput(vi);
 			return false;
@@ -1012,24 +807,21 @@ bool ntfs_may_write_mft_record(ntfs_volume *vol, const unsigned long mft_no,
 	 * is.
 	 */
 	na.mft_no = MREF_LE(m->base_mft_record);
-	ntfs_debug("Mft record 0x%lx is an extent record.  Looking for base "
-			"inode 0x%lx in icache.", mft_no, na.mft_no);
+	na.state = 0;
+	ntfs_debug("Mft record 0x%lx is an extent record.  Looking for base inode 0x%lx in icache.",
+			mft_no, na.mft_no);
 	if (!na.mft_no) {
 		/* Balance the below iput(). */
 		vi = igrab(mft_vi);
-		BUG_ON(vi != mft_vi);
-	} else
-		vi = ilookup5_nowait(sb, na.mft_no, ntfs_test_inode,
-				&na);
-	if (!vi) {
-		/*
-		 * The base inode is not in icache, write this extent mft
-		 * record.
-		 */
-		ntfs_debug("Base inode 0x%lx is not in icache, write the "
-				"extent record.", na.mft_no);
-		return true;
+		WARN_ON(vi != mft_vi);
+	} else {
+		vi = find_inode_nowait(sb, mft_no, ntfs_test_inode_wb, &na);
+		if (na.state == NI_BeingDeleted || na.state == NI_BeingCreated)
+			return false;
 	}
+
+	if (!vi)
+		return false;
 	ntfs_debug("Base inode 0x%lx is in icache.", na.mft_no);
 	/*
 	 * The base inode is in icache.  Check if it has the extent inode
@@ -1044,8 +836,8 @@ bool ntfs_may_write_mft_record(ntfs_volume *vol, const unsigned long mft_no,
 		 */
 		mutex_unlock(&ni->extent_lock);
 		iput(vi);
-		ntfs_debug("Base inode 0x%lx has no attached extent inodes, "
-				"write the extent record.", na.mft_no);
+		ntfs_debug("Base inode 0x%lx has no attached extent inodes, write the extent record.",
+				na.mft_no);
 		return true;
 	}
 	/* Iterate over the attached extent inodes. */
@@ -1067,8 +859,7 @@ bool ntfs_may_write_mft_record(ntfs_volume *vol, const unsigned long mft_no,
 	if (!eni) {
 		mutex_unlock(&ni->extent_lock);
 		iput(vi);
-		ntfs_debug("Extent inode 0x%lx is not attached to its base "
-				"inode 0x%lx, write the extent record.",
+		ntfs_debug("Extent inode 0x%lx is not attached to its base inode 0x%lx, write the extent record.",
 				mft_no, na.mft_no);
 		return true;
 	}
@@ -1077,6 +868,14 @@ bool ntfs_may_write_mft_record(ntfs_volume *vol, const unsigned long mft_no,
 	/* Take a reference to the extent ntfs inode. */
 	atomic_inc(&eni->count);
 	mutex_unlock(&ni->extent_lock);
+
+	/* if extent inode is dirty, write_inode will write it */
+	if (NInoDirty(eni)) {
+		atomic_dec(&eni->count);
+		iput(vi);
+		return false;
+	}
+
 	/*
 	 * Found the extent inode coresponding to this extent mft record.
 	 * Try to take the mft record lock.
@@ -1084,15 +883,12 @@ bool ntfs_may_write_mft_record(ntfs_volume *vol, const unsigned long mft_no,
 	if (unlikely(!mutex_trylock(&eni->mrec_lock))) {
 		atomic_dec(&eni->count);
 		iput(vi);
-		ntfs_debug("Extent mft record 0x%lx is already locked, do "
-				"not write it.", mft_no);
+		ntfs_debug("Extent mft record 0x%lx is already locked, do not write it.",
+				mft_no);
 		return false;
 	}
 	ntfs_debug("Managed to lock extent mft record 0x%lx, write it.",
 			mft_no);
-	if (NInoTestClearDirty(eni))
-		ntfs_debug("Extent inode 0x%lx is dirty, marking it clean.",
-				mft_no);
 	/*
 	 * The write has to occur while we hold the mft record lock so return
 	 * the locked extent ntfs inode.
@@ -1101,8 +897,9 @@ bool ntfs_may_write_mft_record(ntfs_volume *vol, const unsigned long mft_no,
 	return true;
 }
 
-static const char *es = "  Leaving inconsistent metadata.  Unmount and run "
-		"chkdsk.";
+static const char *es = "  Leaving inconsistent metadata.  Unmount and run chkdsk.";
+
+#define RESERVED_MFT_RECORDS	64
 
 /**
  * ntfs_mft_bitmap_find_and_alloc_free_rec_nolock - see name
@@ -1123,19 +920,18 @@ static const char *es = "  Leaving inconsistent metadata.  Unmount and run "
  *
  * Locking: Caller must hold vol->mftbmp_lock for writing.
  */
-static int ntfs_mft_bitmap_find_and_alloc_free_rec_nolock(ntfs_volume *vol,
-		ntfs_inode *base_ni)
+static int ntfs_mft_bitmap_find_and_alloc_free_rec_nolock(struct ntfs_volume *vol,
+		struct ntfs_inode *base_ni)
 {
 	s64 pass_end, ll, data_pos, pass_start, ofs, bit;
 	unsigned long flags;
 	struct address_space *mftbmp_mapping;
-	u8 *buf, *byte;
-	struct page *page;
-	unsigned int page_ofs, size;
+	u8 *buf = NULL, *byte;
+	struct folio *folio;
+	unsigned int folio_ofs, size;
 	u8 pass, b;
 
-	ntfs_debug("Searching for free mft record in the currently "
-			"initialized mft bitmap.");
+	ntfs_debug("Searching for free mft record in the currently initialized mft bitmap.");
 	mftbmp_mapping = vol->mftbmp_ino->i_mapping;
 	/*
 	 * Set the end of the pass making sure we do not overflow the mft
@@ -1155,26 +951,30 @@ static int ntfs_mft_bitmap_find_and_alloc_free_rec_nolock(ntfs_volume *vol,
 		data_pos = vol->mft_data_pos;
 	else
 		data_pos = base_ni->mft_no + 1;
-	if (data_pos < 24)
-		data_pos = 24;
+	if (data_pos < RESERVED_MFT_RECORDS)
+		data_pos = RESERVED_MFT_RECORDS;
 	if (data_pos >= pass_end) {
-		data_pos = 24;
+		data_pos = RESERVED_MFT_RECORDS;
 		pass = 2;
 		/* This happens on a freshly formatted volume. */
 		if (data_pos >= pass_end)
 			return -ENOSPC;
 	}
+
+	if (base_ni && base_ni->mft_no == FILE_MFT) {
+		data_pos = 0;
+		pass = 2;
+	}
+
 	pass_start = data_pos;
-	ntfs_debug("Starting bitmap search: pass %u, pass_start 0x%llx, "
-			"pass_end 0x%llx, data_pos 0x%llx.", pass,
-			(long long)pass_start, (long long)pass_end,
-			(long long)data_pos);
+	ntfs_debug("Starting bitmap search: pass %u, pass_start 0x%llx, pass_end 0x%llx, data_pos 0x%llx.",
+			pass, pass_start, pass_end, data_pos);
 	/* Loop until a free mft record is found. */
 	for (; pass <= 2;) {
 		/* Cap size to pass_end. */
 		ofs = data_pos >> 3;
-		page_ofs = ofs & ~PAGE_MASK;
-		size = PAGE_SIZE - page_ofs;
+		folio_ofs = ofs & ~PAGE_MASK;
+		size = PAGE_SIZE - folio_ofs;
 		ll = ((pass_end + 7) >> 3) - ofs;
 		if (size > ll)
 			size = ll;
@@ -1184,21 +984,32 @@ static int ntfs_mft_bitmap_find_and_alloc_free_rec_nolock(ntfs_volume *vol,
 		 * for a zero bit.
 		 */
 		if (size) {
-			page = ntfs_map_page(mftbmp_mapping,
-					ofs >> PAGE_SHIFT);
-			if (IS_ERR(page)) {
-				ntfs_error(vol->sb, "Failed to read mft "
-						"bitmap, aborting.");
-				return PTR_ERR(page);
+			folio = read_mapping_folio(mftbmp_mapping,
+					ofs >> PAGE_SHIFT, NULL);
+			if (IS_ERR(folio)) {
+				ntfs_error(vol->sb, "Failed to read mft bitmap, aborting.");
+				return PTR_ERR(folio);
 			}
-			buf = (u8*)page_address(page) + page_ofs;
+			folio_lock(folio);
+			buf = (u8 *)kmap_local_folio(folio, 0) + folio_ofs;
 			bit = data_pos & 7;
 			data_pos &= ~7ull;
-			ntfs_debug("Before inner for loop: size 0x%x, "
-					"data_pos 0x%llx, bit 0x%llx", size,
-					(long long)data_pos, (long long)bit);
+			ntfs_debug("Before inner for loop: size 0x%x, data_pos 0x%llx, bit 0x%llx",
+					size, data_pos, bit);
 			for (; bit < size && data_pos + bit < pass_end;
 					bit &= ~7ull, bit += 8) {
+				/*
+				 * If we're extending $MFT and running out of the first
+				 * mft record (base record) then give up searching since
+				 * no guarantee that the found record will be accessible.
+				 */
+				if (base_ni && base_ni->mft_no == FILE_MFT && bit > 400) {
+					folio_unlock(folio);
+					kunmap_local(buf);
+					folio_put(folio);
+					return -ENOSPC;
+				}
+
 				byte = buf + (bit >> 3);
 				if (*byte == 0xff)
 					continue;
@@ -1206,25 +1017,28 @@ static int ntfs_mft_bitmap_find_and_alloc_free_rec_nolock(ntfs_volume *vol,
 				if (b < 8 && b >= (bit & 7)) {
 					ll = data_pos + (bit & ~7ull) + b;
 					if (unlikely(ll > (1ll << 32))) {
-						ntfs_unmap_page(page);
+						folio_unlock(folio);
+						kunmap_local(buf);
+						folio_put(folio);
 						return -ENOSPC;
 					}
 					*byte |= 1 << b;
-					flush_dcache_page(page);
-					set_page_dirty(page);
-					ntfs_unmap_page(page);
-					ntfs_debug("Done.  (Found and "
-							"allocated mft record "
-							"0x%llx.)",
-							(long long)ll);
+					flush_dcache_folio(folio);
+					folio_mark_dirty(folio);
+					folio_unlock(folio);
+					kunmap_local(buf);
+					folio_put(folio);
+					ntfs_debug("Done.  (Found and allocated mft record 0x%llx.)",
+							ll);
 					return ll;
 				}
 			}
-			ntfs_debug("After inner for loop: size 0x%x, "
-					"data_pos 0x%llx, bit 0x%llx", size,
-					(long long)data_pos, (long long)bit);
+			ntfs_debug("After inner for loop: size 0x%x, data_pos 0x%llx, bit 0x%llx",
+					size, data_pos, bit);
 			data_pos += size;
-			ntfs_unmap_page(page);
+			folio_unlock(folio);
+			kunmap_local(buf);
+			folio_put(folio);
 			/*
 			 * If the end of the pass has not been reached yet,
 			 * continue searching the mft bitmap for a zero bit.
@@ -1239,20 +1053,47 @@ static int ntfs_mft_bitmap_find_and_alloc_free_rec_nolock(ntfs_volume *vol,
 			 * part of the zone which we omitted earlier.
 			 */
 			pass_end = pass_start;
-			data_pos = pass_start = 24;
-			ntfs_debug("pass %i, pass_start 0x%llx, pass_end "
-					"0x%llx.", pass, (long long)pass_start,
-					(long long)pass_end);
+			data_pos = pass_start = RESERVED_MFT_RECORDS;
+			ntfs_debug("pass %i, pass_start 0x%llx, pass_end 0x%llx.",
+					pass, pass_start, pass_end);
 			if (data_pos >= pass_end)
 				break;
 		}
 	}
 	/* No free mft records in currently initialized mft bitmap. */
-	ntfs_debug("Done.  (No free mft records left in currently initialized "
-			"mft bitmap.)");
+	ntfs_debug("Done.  (No free mft records left in currently initialized mft bitmap.)");
 	return -ENOSPC;
 }
 
+static int ntfs_mft_attr_extend(struct ntfs_inode *ni)
+{
+	int ret = 0;
+	struct ntfs_inode *base_ni;
+
+	if (NInoAttr(ni))
+		base_ni = ni->ext.base_ntfs_ino;
+	else
+		base_ni = ni;
+
+	if (!NInoAttrList(base_ni)) {
+		ret = ntfs_inode_add_attrlist(base_ni);
+		if (ret) {
+			pr_err("Can not add attrlist\n");
+			goto out;
+		} else {
+			ret = -EAGAIN;
+			goto out;
+		}
+	}
+
+	ret = ntfs_attr_update_mapping_pairs(ni, 0);
+	if (ret)
+		pr_err("MP update failed\n");
+
+out:
+	return ret;
+}
+
 /**
  * ntfs_mft_bitmap_extend_allocation_nolock - extend mft bitmap by a cluster
  * @vol:	volume on which to extend the mft bitmap attribute
@@ -1270,17 +1111,17 @@ static int ntfs_mft_bitmap_find_and_alloc_free_rec_nolock(ntfs_volume *vol,
  *	    - This function takes vol->lcnbmp_lock for writing and releases it
  *	      before returning.
  */
-static int ntfs_mft_bitmap_extend_allocation_nolock(ntfs_volume *vol)
+static int ntfs_mft_bitmap_extend_allocation_nolock(struct ntfs_volume *vol)
 {
-	LCN lcn;
+	s64 lcn;
 	s64 ll;
 	unsigned long flags;
-	struct page *page;
-	ntfs_inode *mft_ni, *mftbmp_ni;
-	runlist_element *rl, *rl2 = NULL;
-	ntfs_attr_search_ctx *ctx = NULL;
-	MFT_RECORD *mrec;
-	ATTR_RECORD *a = NULL;
+	struct folio *folio;
+	struct ntfs_inode *mft_ni, *mftbmp_ni;
+	struct runlist_element *rl, *rl2 = NULL;
+	struct ntfs_attr_search_ctx *ctx = NULL;
+	struct mft_record *mrec;
+	struct attr_record *a = NULL;
 	int ret, mp_size;
 	u32 old_alen = 0;
 	u8 *b, tb;
@@ -1288,7 +1129,9 @@ static int ntfs_mft_bitmap_extend_allocation_nolock(ntfs_volume *vol)
 		u8 added_cluster:1;
 		u8 added_run:1;
 		u8 mp_rebuilt:1;
-	} status = { 0, 0, 0 };
+		u8 mp_extended:1;
+	} status = { 0, 0, 0, 0 };
+	size_t new_rl_count;
 
 	ntfs_debug("Extending mft bitmap allocation.");
 	mft_ni = NTFS_I(vol->mft_ino);
@@ -1302,11 +1145,11 @@ static int ntfs_mft_bitmap_extend_allocation_nolock(ntfs_volume *vol)
 	ll = mftbmp_ni->allocated_size;
 	read_unlock_irqrestore(&mftbmp_ni->size_lock, flags);
 	rl = ntfs_attr_find_vcn_nolock(mftbmp_ni,
-			(ll - 1) >> vol->cluster_size_bits, NULL);
+			NTFS_B_TO_CLU(vol, ll - 1), NULL);
 	if (IS_ERR(rl) || unlikely(!rl->length || rl->lcn < 0)) {
 		up_write(&mftbmp_ni->runlist.lock);
-		ntfs_error(vol->sb, "Failed to determine last allocated "
-				"cluster of mft bitmap attribute.");
+		ntfs_error(vol->sb,
+			"Failed to determine last allocated cluster of mft bitmap attribute.");
 		if (!IS_ERR(rl))
 			ret = -EIO;
 		else
@@ -1322,54 +1165,60 @@ static int ntfs_mft_bitmap_extend_allocation_nolock(ntfs_volume *vol)
 	 * to us.
 	 */
 	ll = lcn >> 3;
-	page = ntfs_map_page(vol->lcnbmp_ino->i_mapping,
-			ll >> PAGE_SHIFT);
-	if (IS_ERR(page)) {
+	folio = read_mapping_folio(vol->lcnbmp_ino->i_mapping,
+			ll >> PAGE_SHIFT, NULL);
+	if (IS_ERR(folio)) {
 		up_write(&mftbmp_ni->runlist.lock);
 		ntfs_error(vol->sb, "Failed to read from lcn bitmap.");
-		return PTR_ERR(page);
+		return PTR_ERR(folio);
 	}
-	b = (u8*)page_address(page) + (ll & ~PAGE_MASK);
-	tb = 1 << (lcn & 7ull);
+
 	down_write(&vol->lcnbmp_lock);
+	folio_lock(folio);
+	b = (u8 *)kmap_local_folio(folio, 0) + (ll & ~PAGE_MASK);
+	tb = 1 << (lcn & 7ull);
 	if (*b != 0xff && !(*b & tb)) {
 		/* Next cluster is free, allocate it. */
 		*b |= tb;
-		flush_dcache_page(page);
-		set_page_dirty(page);
+		flush_dcache_folio(folio);
+		folio_mark_dirty(folio);
+		folio_unlock(folio);
+		kunmap_local(b);
+		folio_put(folio);
 		up_write(&vol->lcnbmp_lock);
-		ntfs_unmap_page(page);
 		/* Update the mft bitmap runlist. */
 		rl->length++;
 		rl[1].vcn++;
 		status.added_cluster = 1;
 		ntfs_debug("Appending one cluster to mft bitmap.");
 	} else {
+		folio_unlock(folio);
+		kunmap_local(b);
+		folio_put(folio);
 		up_write(&vol->lcnbmp_lock);
-		ntfs_unmap_page(page);
 		/* Allocate a cluster from the DATA_ZONE. */
 		rl2 = ntfs_cluster_alloc(vol, rl[1].vcn, 1, lcn, DATA_ZONE,
-				true);
+				true, false, false);
 		if (IS_ERR(rl2)) {
 			up_write(&mftbmp_ni->runlist.lock);
-			ntfs_error(vol->sb, "Failed to allocate a cluster for "
-					"the mft bitmap.");
+			ntfs_error(vol->sb,
+					"Failed to allocate a cluster for the mft bitmap.");
 			return PTR_ERR(rl2);
 		}
-		rl = ntfs_runlists_merge(mftbmp_ni->runlist.rl, rl2);
+		rl = ntfs_runlists_merge(&mftbmp_ni->runlist, rl2, 0, &new_rl_count);
 		if (IS_ERR(rl)) {
 			up_write(&mftbmp_ni->runlist.lock);
-			ntfs_error(vol->sb, "Failed to merge runlists for mft "
-					"bitmap.");
+			ntfs_error(vol->sb, "Failed to merge runlists for mft bitmap.");
 			if (ntfs_cluster_free_from_rl(vol, rl2)) {
-				ntfs_error(vol->sb, "Failed to deallocate "
-						"allocated cluster.%s", es);
+				ntfs_error(vol->sb, "Failed to deallocate allocated cluster.%s",
+						es);
 				NVolSetErrors(vol);
 			}
 			ntfs_free(rl2);
 			return PTR_ERR(rl);
 		}
 		mftbmp_ni->runlist.rl = rl;
+		mftbmp_ni->runlist.count = new_rl_count;
 		status.added_run = 1;
 		ntfs_debug("Adding one run to mft bitmap.");
 		/* Find the last run in the new runlist. */
@@ -1396,26 +1245,26 @@ static int ntfs_mft_bitmap_extend_allocation_nolock(ntfs_volume *vol)
 			mftbmp_ni->name_len, CASE_SENSITIVE, rl[1].vcn, NULL,
 			0, ctx);
 	if (unlikely(ret)) {
-		ntfs_error(vol->sb, "Failed to find last attribute extent of "
-				"mft bitmap attribute.");
+		ntfs_error(vol->sb,
+			"Failed to find last attribute extent of mft bitmap attribute.");
 		if (ret == -ENOENT)
 			ret = -EIO;
 		goto undo_alloc;
 	}
 	a = ctx->attr;
-	ll = sle64_to_cpu(a->data.non_resident.lowest_vcn);
+	ll = le64_to_cpu(a->data.non_resident.lowest_vcn);
 	/* Search back for the previous last allocated cluster of mft bitmap. */
 	for (rl2 = rl; rl2 > mftbmp_ni->runlist.rl; rl2--) {
 		if (ll >= rl2->vcn)
 			break;
 	}
-	BUG_ON(ll < rl2->vcn);
-	BUG_ON(ll >= rl2->vcn + rl2->length);
+	WARN_ON(ll < rl2->vcn);
+	WARN_ON(ll >= rl2->vcn + rl2->length);
 	/* Get the size for the new mapping pairs array for this extent. */
-	mp_size = ntfs_get_size_for_mapping_pairs(vol, rl2, ll, -1);
+	mp_size = ntfs_get_size_for_mapping_pairs(vol, rl2, ll, -1, -1);
 	if (unlikely(mp_size <= 0)) {
-		ntfs_error(vol->sb, "Get size for mapping pairs failed for "
-				"mft bitmap attribute extent.");
+		ntfs_error(vol->sb,
+			"Get size for mapping pairs failed for mft bitmap attribute extent.");
 		ret = mp_size;
 		if (!ret)
 			ret = -EIO;
@@ -1426,76 +1275,67 @@ static int ntfs_mft_bitmap_extend_allocation_nolock(ntfs_volume *vol)
 	ret = ntfs_attr_record_resize(ctx->mrec, a, mp_size +
 			le16_to_cpu(a->data.non_resident.mapping_pairs_offset));
 	if (unlikely(ret)) {
-		if (ret != -ENOSPC) {
-			ntfs_error(vol->sb, "Failed to resize attribute "
-					"record for mft bitmap attribute.");
-			goto undo_alloc;
-		}
-		// TODO: Deal with this by moving this extent to a new mft
-		// record or by starting a new extent in a new mft record or by
-		// moving other attributes out of this mft record.
-		// Note: It will need to be a special mft record and if none of
-		// those are available it gets rather complicated...
-		ntfs_error(vol->sb, "Not enough space in this mft record to "
-				"accommodate extended mft bitmap attribute "
-				"extent.  Cannot handle this yet.");
-		ret = -EOPNOTSUPP;
+		ret = ntfs_mft_attr_extend(mftbmp_ni);
+		if (!ret)
+			goto extended_ok;
+		status.mp_extended = 1;
 		goto undo_alloc;
 	}
 	status.mp_rebuilt = 1;
 	/* Generate the mapping pairs array directly into the attr record. */
-	ret = ntfs_mapping_pairs_build(vol, (u8*)a +
+	ret = ntfs_mapping_pairs_build(vol, (u8 *)a +
 			le16_to_cpu(a->data.non_resident.mapping_pairs_offset),
-			mp_size, rl2, ll, -1, NULL);
+			mp_size, rl2, ll, -1, NULL, NULL, NULL);
 	if (unlikely(ret)) {
-		ntfs_error(vol->sb, "Failed to build mapping pairs array for "
-				"mft bitmap attribute.");
+		ntfs_error(vol->sb,
+			"Failed to build mapping pairs array for mft bitmap attribute.");
 		goto undo_alloc;
 	}
 	/* Update the highest_vcn. */
-	a->data.non_resident.highest_vcn = cpu_to_sle64(rl[1].vcn - 1);
+	a->data.non_resident.highest_vcn = cpu_to_le64(rl[1].vcn - 1);
 	/*
 	 * We now have extended the mft bitmap allocated_size by one cluster.
-	 * Reflect this in the ntfs_inode structure and the attribute record.
+	 * Reflect this in the struct ntfs_inode structure and the attribute record.
 	 */
 	if (a->data.non_resident.lowest_vcn) {
 		/*
 		 * We are not in the first attribute extent, switch to it, but
 		 * first ensure the changes will make it to disk later.
 		 */
-		flush_dcache_mft_record_page(ctx->ntfs_ino);
 		mark_mft_record_dirty(ctx->ntfs_ino);
 		ntfs_attr_reinit_search_ctx(ctx);
 		ret = ntfs_attr_lookup(mftbmp_ni->type, mftbmp_ni->name,
 				mftbmp_ni->name_len, CASE_SENSITIVE, 0, NULL,
 				0, ctx);
 		if (unlikely(ret)) {
-			ntfs_error(vol->sb, "Failed to find first attribute "
-					"extent of mft bitmap attribute.");
+			ntfs_error(vol->sb,
+				"Failed to find first attribute extent of mft bitmap attribute.");
 			goto restore_undo_alloc;
 		}
 		a = ctx->attr;
 	}
+
+extended_ok:
 	write_lock_irqsave(&mftbmp_ni->size_lock, flags);
 	mftbmp_ni->allocated_size += vol->cluster_size;
 	a->data.non_resident.allocated_size =
-			cpu_to_sle64(mftbmp_ni->allocated_size);
+			cpu_to_le64(mftbmp_ni->allocated_size);
 	write_unlock_irqrestore(&mftbmp_ni->size_lock, flags);
 	/* Ensure the changes make it to disk. */
-	flush_dcache_mft_record_page(ctx->ntfs_ino);
 	mark_mft_record_dirty(ctx->ntfs_ino);
 	ntfs_attr_put_search_ctx(ctx);
 	unmap_mft_record(mft_ni);
 	up_write(&mftbmp_ni->runlist.lock);
 	ntfs_debug("Done.");
 	return 0;
+
 restore_undo_alloc:
 	ntfs_attr_reinit_search_ctx(ctx);
 	if (ntfs_attr_lookup(mftbmp_ni->type, mftbmp_ni->name,
 			mftbmp_ni->name_len, CASE_SENSITIVE, rl[1].vcn, NULL,
 			0, ctx)) {
-		ntfs_error(vol->sb, "Failed to find last attribute extent of "
-				"mft bitmap attribute.%s", es);
+		ntfs_error(vol->sb,
+			"Failed to find last attribute extent of mft bitmap attribute.%s", es);
 		write_lock_irqsave(&mftbmp_ni->size_lock, flags);
 		mftbmp_ni->allocated_size += vol->cluster_size;
 		write_unlock_irqrestore(&mftbmp_ni->size_lock, flags);
@@ -1510,7 +1350,7 @@ static int ntfs_mft_bitmap_extend_allocation_nolock(ntfs_volume *vol)
 		return ret;
 	}
 	a = ctx->attr;
-	a->data.non_resident.highest_vcn = cpu_to_sle64(rl[1].vcn - 2);
+	a->data.non_resident.highest_vcn = cpu_to_le64(rl[1].vcn - 2);
 undo_alloc:
 	if (status.added_cluster) {
 		/* Truncate the last run in the runlist by one cluster. */
@@ -1521,31 +1361,33 @@ static int ntfs_mft_bitmap_extend_allocation_nolock(ntfs_volume *vol)
 		/* Remove the last run from the runlist. */
 		rl->lcn = rl[1].lcn;
 		rl->length = 0;
+		mftbmp_ni->runlist.count--;
 	}
 	/* Deallocate the cluster. */
 	down_write(&vol->lcnbmp_lock);
 	if (ntfs_bitmap_clear_bit(vol->lcnbmp_ino, lcn)) {
 		ntfs_error(vol->sb, "Failed to free allocated cluster.%s", es);
 		NVolSetErrors(vol);
-	}
+	} else
+		ntfs_inc_free_clusters(vol, 1);
 	up_write(&vol->lcnbmp_lock);
 	if (status.mp_rebuilt) {
-		if (ntfs_mapping_pairs_build(vol, (u8*)a + le16_to_cpu(
+		if (ntfs_mapping_pairs_build(vol, (u8 *)a + le16_to_cpu(
 				a->data.non_resident.mapping_pairs_offset),
 				old_alen - le16_to_cpu(
 				a->data.non_resident.mapping_pairs_offset),
-				rl2, ll, -1, NULL)) {
-			ntfs_error(vol->sb, "Failed to restore mapping pairs "
-					"array.%s", es);
+				rl2, ll, -1, NULL, NULL, NULL)) {
+			ntfs_error(vol->sb, "Failed to restore mapping pairs array.%s", es);
 			NVolSetErrors(vol);
 		}
 		if (ntfs_attr_record_resize(ctx->mrec, a, old_alen)) {
-			ntfs_error(vol->sb, "Failed to restore attribute "
-					"record.%s", es);
+			ntfs_error(vol->sb, "Failed to restore attribute record.%s", es);
 			NVolSetErrors(vol);
 		}
-		flush_dcache_mft_record_page(ctx->ntfs_ino);
 		mark_mft_record_dirty(ctx->ntfs_ino);
+	} else if (status.mp_extended && ntfs_attr_update_mapping_pairs(mftbmp_ni, 0)) {
+		ntfs_error(vol->sb, "Failed to restore mapping pairs.%s", es);
+		NVolSetErrors(vol);
 	}
 	if (ctx)
 		ntfs_attr_put_search_ctx(ctx);
@@ -1569,15 +1411,15 @@ static int ntfs_mft_bitmap_extend_allocation_nolock(ntfs_volume *vol)
  *
  * Locking: Caller must hold vol->mftbmp_lock for writing.
  */
-static int ntfs_mft_bitmap_extend_initialized_nolock(ntfs_volume *vol)
+static int ntfs_mft_bitmap_extend_initialized_nolock(struct ntfs_volume *vol)
 {
 	s64 old_data_size, old_initialized_size;
 	unsigned long flags;
 	struct inode *mftbmp_vi;
-	ntfs_inode *mft_ni, *mftbmp_ni;
-	ntfs_attr_search_ctx *ctx;
-	MFT_RECORD *mrec;
-	ATTR_RECORD *a;
+	struct ntfs_inode *mft_ni, *mftbmp_ni;
+	struct ntfs_attr_search_ctx *ctx;
+	struct mft_record *mrec;
+	struct attr_record *a;
 	int ret;
 
 	ntfs_debug("Extending mft bitmap initiailized (and data) size.");
@@ -1599,8 +1441,8 @@ static int ntfs_mft_bitmap_extend_initialized_nolock(ntfs_volume *vol)
 	ret = ntfs_attr_lookup(mftbmp_ni->type, mftbmp_ni->name,
 			mftbmp_ni->name_len, CASE_SENSITIVE, 0, NULL, 0, ctx);
 	if (unlikely(ret)) {
-		ntfs_error(vol->sb, "Failed to find first attribute extent of "
-				"mft bitmap attribute.");
+		ntfs_error(vol->sb,
+			"Failed to find first attribute extent of mft bitmap attribute.");
 		if (ret == -ENOENT)
 			ret = -EIO;
 		goto put_err_out;
@@ -1616,23 +1458,22 @@ static int ntfs_mft_bitmap_extend_initialized_nolock(ntfs_volume *vol)
 	 */
 	mftbmp_ni->initialized_size += 8;
 	a->data.non_resident.initialized_size =
-			cpu_to_sle64(mftbmp_ni->initialized_size);
+			cpu_to_le64(mftbmp_ni->initialized_size);
 	if (mftbmp_ni->initialized_size > old_data_size) {
 		i_size_write(mftbmp_vi, mftbmp_ni->initialized_size);
 		a->data.non_resident.data_size =
-				cpu_to_sle64(mftbmp_ni->initialized_size);
+				cpu_to_le64(mftbmp_ni->initialized_size);
 	}
 	write_unlock_irqrestore(&mftbmp_ni->size_lock, flags);
 	/* Ensure the changes make it to disk. */
-	flush_dcache_mft_record_page(ctx->ntfs_ino);
 	mark_mft_record_dirty(ctx->ntfs_ino);
 	ntfs_attr_put_search_ctx(ctx);
 	unmap_mft_record(mft_ni);
 	/* Initialize the mft bitmap attribute value with zeroes. */
 	ret = ntfs_attr_set(mftbmp_ni, old_initialized_size, 8, 0);
 	if (likely(!ret)) {
-		ntfs_debug("Done.  (Wrote eight initialized bytes to mft "
-				"bitmap.");
+		ntfs_debug("Done.  (Wrote eight initialized bytes to mft bitmap.");
+		ntfs_inc_free_mft_records(vol, 8 * 8);
 		return 0;
 	}
 	ntfs_error(vol->sb, "Failed to write to mft bitmap.");
@@ -1651,8 +1492,8 @@ static int ntfs_mft_bitmap_extend_initialized_nolock(ntfs_volume *vol)
 	}
 	if (ntfs_attr_lookup(mftbmp_ni->type, mftbmp_ni->name,
 			mftbmp_ni->name_len, CASE_SENSITIVE, 0, NULL, 0, ctx)) {
-		ntfs_error(vol->sb, "Failed to find first attribute extent of "
-				"mft bitmap attribute.%s", es);
+		ntfs_error(vol->sb,
+			"Failed to find first attribute extent of mft bitmap attribute.%s", es);
 		NVolSetErrors(vol);
 put_err_out:
 		ntfs_attr_put_search_ctx(ctx);
@@ -1664,23 +1505,20 @@ static int ntfs_mft_bitmap_extend_initialized_nolock(ntfs_volume *vol)
 	write_lock_irqsave(&mftbmp_ni->size_lock, flags);
 	mftbmp_ni->initialized_size = old_initialized_size;
 	a->data.non_resident.initialized_size =
-			cpu_to_sle64(old_initialized_size);
+			cpu_to_le64(old_initialized_size);
 	if (i_size_read(mftbmp_vi) != old_data_size) {
 		i_size_write(mftbmp_vi, old_data_size);
-		a->data.non_resident.data_size = cpu_to_sle64(old_data_size);
+		a->data.non_resident.data_size = cpu_to_le64(old_data_size);
 	}
 	write_unlock_irqrestore(&mftbmp_ni->size_lock, flags);
-	flush_dcache_mft_record_page(ctx->ntfs_ino);
 	mark_mft_record_dirty(ctx->ntfs_ino);
 	ntfs_attr_put_search_ctx(ctx);
 	unmap_mft_record(mft_ni);
 #ifdef DEBUG
 	read_lock_irqsave(&mftbmp_ni->size_lock, flags);
-	ntfs_debug("Restored status of mftbmp: allocated_size 0x%llx, "
-			"data_size 0x%llx, initialized_size 0x%llx.",
-			(long long)mftbmp_ni->allocated_size,
-			(long long)i_size_read(mftbmp_vi),
-			(long long)mftbmp_ni->initialized_size);
+	ntfs_debug("Restored status of mftbmp: allocated_size 0x%llx, data_size 0x%llx, initialized_size 0x%llx.",
+			mftbmp_ni->allocated_size, i_size_read(mftbmp_vi),
+			mftbmp_ni->initialized_size);
 	read_unlock_irqrestore(&mftbmp_ni->size_lock, flags);
 #endif /* DEBUG */
 err_out:
@@ -1706,20 +1544,21 @@ static int ntfs_mft_bitmap_extend_initialized_nolock(ntfs_volume *vol)
  *	    - This function calls functions which take vol->lcnbmp_lock for
  *	      writing and release it before returning.
  */
-static int ntfs_mft_data_extend_allocation_nolock(ntfs_volume *vol)
+static int ntfs_mft_data_extend_allocation_nolock(struct ntfs_volume *vol)
 {
-	LCN lcn;
-	VCN old_last_vcn;
+	s64 lcn;
+	s64 old_last_vcn;
 	s64 min_nr, nr, ll;
 	unsigned long flags;
-	ntfs_inode *mft_ni;
-	runlist_element *rl, *rl2;
-	ntfs_attr_search_ctx *ctx = NULL;
-	MFT_RECORD *mrec;
-	ATTR_RECORD *a = NULL;
+	struct ntfs_inode *mft_ni;
+	struct runlist_element *rl, *rl2;
+	struct ntfs_attr_search_ctx *ctx = NULL;
+	struct mft_record *mrec;
+	struct attr_record *a = NULL;
 	int ret, mp_size;
 	u32 old_alen = 0;
-	bool mp_rebuilt = false;
+	bool mp_rebuilt = false, mp_extended = false;
+	size_t new_rl_count;
 
 	ntfs_debug("Extending mft data allocation.");
 	mft_ni = NTFS_I(vol->mft_ino);
@@ -1733,11 +1572,11 @@ static int ntfs_mft_data_extend_allocation_nolock(ntfs_volume *vol)
 	ll = mft_ni->allocated_size;
 	read_unlock_irqrestore(&mft_ni->size_lock, flags);
 	rl = ntfs_attr_find_vcn_nolock(mft_ni,
-			(ll - 1) >> vol->cluster_size_bits, NULL);
+			NTFS_B_TO_CLU(vol, ll - 1), NULL);
 	if (IS_ERR(rl) || unlikely(!rl->length || rl->lcn < 0)) {
 		up_write(&mft_ni->runlist.lock);
-		ntfs_error(vol->sb, "Failed to determine last allocated "
-				"cluster of mft data attribute.");
+		ntfs_error(vol->sb,
+			"Failed to determine last allocated cluster of mft data attribute.");
 		if (!IS_ERR(rl))
 			ret = -EIO;
 		else
@@ -1745,9 +1584,9 @@ static int ntfs_mft_data_extend_allocation_nolock(ntfs_volume *vol)
 		return ret;
 	}
 	lcn = rl->lcn + rl->length;
-	ntfs_debug("Last lcn of mft data attribute is 0x%llx.", (long long)lcn);
+	ntfs_debug("Last lcn of mft data attribute is 0x%llx.", lcn);
 	/* Minimum allocation is one mft record worth of clusters. */
-	min_nr = vol->mft_record_size >> vol->cluster_size_bits;
+	min_nr = NTFS_B_TO_CLU(vol, vol->mft_record_size);
 	if (!min_nr)
 		min_nr = 1;
 	/* Want to allocate 16 mft records worth of clusters. */
@@ -1758,14 +1597,13 @@ static int ntfs_mft_data_extend_allocation_nolock(ntfs_volume *vol)
 	read_lock_irqsave(&mft_ni->size_lock, flags);
 	ll = mft_ni->allocated_size;
 	read_unlock_irqrestore(&mft_ni->size_lock, flags);
-	if (unlikely((ll + (nr << vol->cluster_size_bits)) >>
+	if (unlikely((ll + NTFS_CLU_TO_B(vol, nr)) >>
 			vol->mft_record_size_bits >= (1ll << 32))) {
 		nr = min_nr;
-		if (unlikely((ll + (nr << vol->cluster_size_bits)) >>
+		if (unlikely((ll + NTFS_CLU_TO_B(vol, nr)) >>
 				vol->mft_record_size_bits >= (1ll << 32))) {
-			ntfs_warning(vol->sb, "Cannot allocate mft record "
-					"because the maximum number of inodes "
-					"(2^32) has already been reached.");
+			ntfs_warning(vol->sb,
+				"Cannot allocate mft record because the maximum number of inodes (2^32) has already been reached.");
 			up_write(&mft_ni->runlist.lock);
 			return -ENOSPC;
 		}
@@ -1773,16 +1611,24 @@ static int ntfs_mft_data_extend_allocation_nolock(ntfs_volume *vol)
 	ntfs_debug("Trying mft data allocation with %s cluster count %lli.",
 			nr > min_nr ? "default" : "minimal", (long long)nr);
 	old_last_vcn = rl[1].vcn;
+	/*
+	 * We can release the mft_ni runlist lock, Because this function is
+	 * the only one that expends $MFT data attribute and is called with
+	 * mft_ni->mrec_lock.
+	 * This is required for the lock order, vol->lcnbmp_lock =>
+	 * mft_ni->runlist.lock.
+	 */
+	up_write(&mft_ni->runlist.lock);
+
 	do {
 		rl2 = ntfs_cluster_alloc(vol, old_last_vcn, nr, lcn, MFT_ZONE,
-				true);
+				true, false, false);
 		if (!IS_ERR(rl2))
 			break;
 		if (PTR_ERR(rl2) != -ENOSPC || nr == min_nr) {
-			ntfs_error(vol->sb, "Failed to allocate the minimal "
-					"number of clusters (%lli) for the "
-					"mft data attribute.", (long long)nr);
-			up_write(&mft_ni->runlist.lock);
+			ntfs_error(vol->sb,
+				"Failed to allocate the minimal number of clusters (%lli) for the mft data attribute.",
+				nr);
 			return PTR_ERR(rl2);
 		}
 		/*
@@ -1791,32 +1637,36 @@ static int ntfs_mft_data_extend_allocation_nolock(ntfs_volume *vol)
 		 * before failing.
 		 */
 		nr = min_nr;
-		ntfs_debug("Retrying mft data allocation with minimal cluster "
-				"count %lli.", (long long)nr);
+		ntfs_debug("Retrying mft data allocation with minimal cluster count %lli.", nr);
 	} while (1);
-	rl = ntfs_runlists_merge(mft_ni->runlist.rl, rl2);
+
+	down_write(&mft_ni->runlist.lock);
+	rl = ntfs_runlists_merge(&mft_ni->runlist, rl2, 0, &new_rl_count);
 	if (IS_ERR(rl)) {
 		up_write(&mft_ni->runlist.lock);
-		ntfs_error(vol->sb, "Failed to merge runlists for mft data "
-				"attribute.");
+		ntfs_error(vol->sb, "Failed to merge runlists for mft data attribute.");
 		if (ntfs_cluster_free_from_rl(vol, rl2)) {
-			ntfs_error(vol->sb, "Failed to deallocate clusters "
-					"from the mft data attribute.%s", es);
+			ntfs_error(vol->sb,
+				"Failed to deallocate clusters from the mft data attribute.%s", es);
 			NVolSetErrors(vol);
 		}
 		ntfs_free(rl2);
 		return PTR_ERR(rl);
 	}
 	mft_ni->runlist.rl = rl;
+	mft_ni->runlist.count = new_rl_count;
 	ntfs_debug("Allocated %lli clusters.", (long long)nr);
 	/* Find the last run in the new runlist. */
 	for (; rl[1].length; rl++)
 		;
+	up_write(&mft_ni->runlist.lock);
+
 	/* Update the attribute record as well. */
 	mrec = map_mft_record(mft_ni);
 	if (IS_ERR(mrec)) {
 		ntfs_error(vol->sb, "Failed to map mft record.");
 		ret = PTR_ERR(mrec);
+		down_write(&mft_ni->runlist.lock);
 		goto undo_alloc;
 	}
 	ctx = ntfs_attr_get_search_ctx(mft_ni, mrec);
@@ -1828,72 +1678,60 @@ static int ntfs_mft_data_extend_allocation_nolock(ntfs_volume *vol)
 	ret = ntfs_attr_lookup(mft_ni->type, mft_ni->name, mft_ni->name_len,
 			CASE_SENSITIVE, rl[1].vcn, NULL, 0, ctx);
 	if (unlikely(ret)) {
-		ntfs_error(vol->sb, "Failed to find last attribute extent of "
-				"mft data attribute.");
+		ntfs_error(vol->sb, "Failed to find last attribute extent of mft data attribute.");
 		if (ret == -ENOENT)
 			ret = -EIO;
 		goto undo_alloc;
 	}
 	a = ctx->attr;
-	ll = sle64_to_cpu(a->data.non_resident.lowest_vcn);
+	ll = le64_to_cpu(a->data.non_resident.lowest_vcn);
+
+	down_write(&mft_ni->runlist.lock);
 	/* Search back for the previous last allocated cluster of mft bitmap. */
 	for (rl2 = rl; rl2 > mft_ni->runlist.rl; rl2--) {
 		if (ll >= rl2->vcn)
 			break;
 	}
-	BUG_ON(ll < rl2->vcn);
-	BUG_ON(ll >= rl2->vcn + rl2->length);
+	WARN_ON(ll < rl2->vcn);
+	WARN_ON(ll >= rl2->vcn + rl2->length);
 	/* Get the size for the new mapping pairs array for this extent. */
-	mp_size = ntfs_get_size_for_mapping_pairs(vol, rl2, ll, -1);
+	mp_size = ntfs_get_size_for_mapping_pairs(vol, rl2, ll, -1, -1);
 	if (unlikely(mp_size <= 0)) {
-		ntfs_error(vol->sb, "Get size for mapping pairs failed for "
-				"mft data attribute extent.");
+		ntfs_error(vol->sb,
+			"Get size for mapping pairs failed for mft data attribute extent.");
 		ret = mp_size;
 		if (!ret)
 			ret = -EIO;
+		up_write(&mft_ni->runlist.lock);
 		goto undo_alloc;
 	}
+	up_write(&mft_ni->runlist.lock);
+
 	/* Expand the attribute record if necessary. */
 	old_alen = le32_to_cpu(a->length);
 	ret = ntfs_attr_record_resize(ctx->mrec, a, mp_size +
 			le16_to_cpu(a->data.non_resident.mapping_pairs_offset));
 	if (unlikely(ret)) {
-		if (ret != -ENOSPC) {
-			ntfs_error(vol->sb, "Failed to resize attribute "
-					"record for mft data attribute.");
-			goto undo_alloc;
-		}
-		// TODO: Deal with this by moving this extent to a new mft
-		// record or by starting a new extent in a new mft record or by
-		// moving other attributes out of this mft record.
-		// Note: Use the special reserved mft records and ensure that
-		// this extent is not required to find the mft record in
-		// question.  If no free special records left we would need to
-		// move an existing record away, insert ours in its place, and
-		// then place the moved record into the newly allocated space
-		// and we would then need to update all references to this mft
-		// record appropriately.  This is rather complicated...
-		ntfs_error(vol->sb, "Not enough space in this mft record to "
-				"accommodate extended mft data attribute "
-				"extent.  Cannot handle this yet.");
-		ret = -EOPNOTSUPP;
+		ret = ntfs_mft_attr_extend(mft_ni);
+		if (!ret)
+			goto extended_ok;
+		mp_extended = true;
 		goto undo_alloc;
 	}
 	mp_rebuilt = true;
 	/* Generate the mapping pairs array directly into the attr record. */
-	ret = ntfs_mapping_pairs_build(vol, (u8*)a +
+	ret = ntfs_mapping_pairs_build(vol, (u8 *)a +
 			le16_to_cpu(a->data.non_resident.mapping_pairs_offset),
-			mp_size, rl2, ll, -1, NULL);
+			mp_size, rl2, ll, -1, NULL, NULL, NULL);
 	if (unlikely(ret)) {
-		ntfs_error(vol->sb, "Failed to build mapping pairs array of "
-				"mft data attribute.");
+		ntfs_error(vol->sb, "Failed to build mapping pairs array of mft data attribute.");
 		goto undo_alloc;
 	}
 	/* Update the highest_vcn. */
-	a->data.non_resident.highest_vcn = cpu_to_sle64(rl[1].vcn - 1);
+	a->data.non_resident.highest_vcn = cpu_to_le64(rl[1].vcn - 1);
 	/*
 	 * We now have extended the mft data allocated_size by nr clusters.
-	 * Reflect this in the ntfs_inode structure and the attribute record.
+	 * Reflect this in the struct ntfs_inode structure and the attribute record.
 	 * @rl is the last (non-terminator) runlist element of mft data
 	 * attribute.
 	 */
@@ -1902,40 +1740,39 @@ static int ntfs_mft_data_extend_allocation_nolock(ntfs_volume *vol)
 		 * We are not in the first attribute extent, switch to it, but
 		 * first ensure the changes will make it to disk later.
 		 */
-		flush_dcache_mft_record_page(ctx->ntfs_ino);
 		mark_mft_record_dirty(ctx->ntfs_ino);
 		ntfs_attr_reinit_search_ctx(ctx);
 		ret = ntfs_attr_lookup(mft_ni->type, mft_ni->name,
 				mft_ni->name_len, CASE_SENSITIVE, 0, NULL, 0,
 				ctx);
 		if (unlikely(ret)) {
-			ntfs_error(vol->sb, "Failed to find first attribute "
-					"extent of mft data attribute.");
+			ntfs_error(vol->sb,
+				"Failed to find first attribute extent of mft data attribute.");
 			goto restore_undo_alloc;
 		}
 		a = ctx->attr;
 	}
+
+extended_ok:
 	write_lock_irqsave(&mft_ni->size_lock, flags);
-	mft_ni->allocated_size += nr << vol->cluster_size_bits;
+	mft_ni->allocated_size += NTFS_CLU_TO_B(vol, nr);
 	a->data.non_resident.allocated_size =
-			cpu_to_sle64(mft_ni->allocated_size);
+			cpu_to_le64(mft_ni->allocated_size);
 	write_unlock_irqrestore(&mft_ni->size_lock, flags);
 	/* Ensure the changes make it to disk. */
-	flush_dcache_mft_record_page(ctx->ntfs_ino);
 	mark_mft_record_dirty(ctx->ntfs_ino);
 	ntfs_attr_put_search_ctx(ctx);
 	unmap_mft_record(mft_ni);
-	up_write(&mft_ni->runlist.lock);
 	ntfs_debug("Done.");
 	return 0;
 restore_undo_alloc:
 	ntfs_attr_reinit_search_ctx(ctx);
 	if (ntfs_attr_lookup(mft_ni->type, mft_ni->name, mft_ni->name_len,
 			CASE_SENSITIVE, rl[1].vcn, NULL, 0, ctx)) {
-		ntfs_error(vol->sb, "Failed to find last attribute extent of "
-				"mft data attribute.%s", es);
+		ntfs_error(vol->sb,
+			"Failed to find last attribute extent of mft data attribute.%s", es);
 		write_lock_irqsave(&mft_ni->size_lock, flags);
-		mft_ni->allocated_size += nr << vol->cluster_size_bits;
+		mft_ni->allocated_size += NTFS_CLU_TO_B(vol, nr);
 		write_unlock_irqrestore(&mft_ni->size_lock, flags);
 		ntfs_attr_put_search_ctx(ctx);
 		unmap_mft_record(mft_ni);
@@ -1948,17 +1785,20 @@ static int ntfs_mft_data_extend_allocation_nolock(ntfs_volume *vol)
 		return ret;
 	}
 	ctx->attr->data.non_resident.highest_vcn =
-			cpu_to_sle64(old_last_vcn - 1);
+			cpu_to_le64(old_last_vcn - 1);
 undo_alloc:
 	if (ntfs_cluster_free(mft_ni, old_last_vcn, -1, ctx) < 0) {
-		ntfs_error(vol->sb, "Failed to free clusters from mft data "
-				"attribute.%s", es);
+		ntfs_error(vol->sb, "Failed to free clusters from mft data attribute.%s", es);
 		NVolSetErrors(vol);
 	}
 
 	if (ntfs_rl_truncate_nolock(vol, &mft_ni->runlist, old_last_vcn)) {
-		ntfs_error(vol->sb, "Failed to truncate mft data attribute "
-				"runlist.%s", es);
+		ntfs_error(vol->sb, "Failed to truncate mft data attribute runlist.%s", es);
+		NVolSetErrors(vol);
+	}
+	if (mp_extended && ntfs_attr_update_mapping_pairs(mft_ni, 0)) {
+		ntfs_error(vol->sb, "Failed to restore mapping pairs.%s",
+			   es);
 		NVolSetErrors(vol);
 	}
 	if (ctx) {
@@ -1968,28 +1808,23 @@ static int ntfs_mft_data_extend_allocation_nolock(ntfs_volume *vol)
 				a->data.non_resident.mapping_pairs_offset),
 				old_alen - le16_to_cpu(
 					a->data.non_resident.mapping_pairs_offset),
-				rl2, ll, -1, NULL)) {
-				ntfs_error(vol->sb, "Failed to restore mapping pairs "
-					"array.%s", es);
+				rl2, ll, -1, NULL, NULL, NULL)) {
+				ntfs_error(vol->sb, "Failed to restore mapping pairs array.%s", es);
 				NVolSetErrors(vol);
 			}
 			if (ntfs_attr_record_resize(ctx->mrec, a, old_alen)) {
-				ntfs_error(vol->sb, "Failed to restore attribute "
-					"record.%s", es);
+				ntfs_error(vol->sb, "Failed to restore attribute record.%s", es);
 				NVolSetErrors(vol);
 			}
-			flush_dcache_mft_record_page(ctx->ntfs_ino);
 			mark_mft_record_dirty(ctx->ntfs_ino);
 		} else if (IS_ERR(ctx->mrec)) {
-			ntfs_error(vol->sb, "Failed to restore attribute search "
-				"context.%s", es);
+			ntfs_error(vol->sb, "Failed to restore attribute search context.%s", es);
 			NVolSetErrors(vol);
 		}
 		ntfs_attr_put_search_ctx(ctx);
 	}
 	if (!IS_ERR(mrec))
 		unmap_mft_record(mft_ni);
-	up_write(&mft_ni->runlist.lock);
 	return ret;
 }
 
@@ -2006,24 +1841,24 @@ static int ntfs_mft_data_extend_allocation_nolock(ntfs_volume *vol)
  *
  * Return 0 on success and -errno on error.
  */
-static int ntfs_mft_record_layout(const ntfs_volume *vol, const s64 mft_no,
-		MFT_RECORD *m)
+static int ntfs_mft_record_layout(const struct ntfs_volume *vol, const s64 mft_no,
+		struct mft_record *m)
 {
-	ATTR_RECORD *a;
+	struct attr_record *a;
 
 	ntfs_debug("Entering for mft record 0x%llx.", (long long)mft_no);
 	if (mft_no >= (1ll << 32)) {
-		ntfs_error(vol->sb, "Mft record number 0x%llx exceeds "
-				"maximum of 2^32.", (long long)mft_no);
+		ntfs_error(vol->sb, "Mft record number 0x%llx exceeds maximum of 2^32.",
+				(long long)mft_no);
 		return -ERANGE;
 	}
 	/* Start by clearing the whole mft record to gives us a clean slate. */
 	memset(m, 0, vol->mft_record_size);
 	/* Aligned to 2-byte boundary. */
 	if (vol->major_ver < 3 || (vol->major_ver == 3 && !vol->minor_ver))
-		m->usa_ofs = cpu_to_le16((sizeof(MFT_RECORD_OLD) + 1) & ~1);
+		m->usa_ofs = cpu_to_le16((sizeof(struct mft_record_old) + 1) & ~1);
 	else {
-		m->usa_ofs = cpu_to_le16((sizeof(MFT_RECORD) + 1) & ~1);
+		m->usa_ofs = cpu_to_le16((sizeof(struct mft_record) + 1) & ~1);
 		/*
 		 * Set the NTFS 3.1+ specific fields while we know that the
 		 * volume version is 3.1+.
@@ -2037,16 +1872,11 @@ static int ntfs_mft_record_layout(const ntfs_volume *vol, const s64 mft_no,
 				NTFS_BLOCK_SIZE + 1);
 	else {
 		m->usa_count = cpu_to_le16(1);
-		ntfs_warning(vol->sb, "Sector size is bigger than mft record "
-				"size.  Setting usa_count to 1.  If chkdsk "
-				"reports this as corruption, please email "
-				"linux-ntfs-dev@lists.sourceforge.net stating "
-				"that you saw this message and that the "
-				"modified filesystem created was corrupt.  "
-				"Thank you.");
+		ntfs_warning(vol->sb,
+			"Sector size is bigger than mft record size.  Setting usa_count to 1.  If chkdsk reports this as corruption");
 	}
 	/* Set the update sequence number to 1. */
-	*(le16*)((u8*)m + le16_to_cpu(m->usa_ofs)) = cpu_to_le16(1);
+	*(__le16 *)((u8 *)m + le16_to_cpu(m->usa_ofs)) = cpu_to_le16(1);
 	m->lsn = 0;
 	m->sequence_number = cpu_to_le16(1);
 	m->link_count = 0;
@@ -2067,7 +1897,7 @@ static int ntfs_mft_record_layout(const ntfs_volume *vol, const s64 mft_no,
 	m->base_mft_record = 0;
 	m->next_attr_instance = 0;
 	/* Add the termination attribute. */
-	a = (ATTR_RECORD*)((u8*)m + le16_to_cpu(m->attrs_offset));
+	a = (struct attr_record *)((u8 *)m + le16_to_cpu(m->attrs_offset));
 	a->type = AT_END;
 	a->length = 0;
 	ntfs_debug("Done.");
@@ -2085,12 +1915,12 @@ static int ntfs_mft_record_layout(const ntfs_volume *vol, const s64 mft_no,
  *
  * Return 0 on success and -errno on error.
  */
-static int ntfs_mft_record_format(const ntfs_volume *vol, const s64 mft_no)
+static int ntfs_mft_record_format(const struct ntfs_volume *vol, const s64 mft_no)
 {
 	loff_t i_size;
 	struct inode *mft_vi = vol->mft_ino;
-	struct page *page;
-	MFT_RECORD *m;
+	struct folio *folio;
+	struct mft_record *m;
 	pgoff_t index, end_index;
 	unsigned int ofs;
 	int err;
@@ -2100,49 +1930,52 @@ static int ntfs_mft_record_format(const ntfs_volume *vol, const s64 mft_no)
 	 * The index into the page cache and the offset within the page cache
 	 * page of the wanted mft record.
 	 */
-	index = mft_no << vol->mft_record_size_bits >> PAGE_SHIFT;
-	ofs = (mft_no << vol->mft_record_size_bits) & ~PAGE_MASK;
+	index = NTFS_MFT_NR_TO_PIDX(vol, mft_no);
+	ofs = NTFS_MFT_NR_TO_POFS(vol, mft_no);
 	/* The maximum valid index into the page cache for $MFT's data. */
 	i_size = i_size_read(mft_vi);
 	end_index = i_size >> PAGE_SHIFT;
 	if (unlikely(index >= end_index)) {
-		if (unlikely(index > end_index || ofs + vol->mft_record_size >=
-				(i_size & ~PAGE_MASK))) {
-			ntfs_error(vol->sb, "Tried to format non-existing mft "
-					"record 0x%llx.", (long long)mft_no);
+		if (unlikely(index > end_index ||
+			     ofs + vol->mft_record_size > (i_size & ~PAGE_MASK))) {
+			ntfs_error(vol->sb, "Tried to format non-existing mft record 0x%llx.",
+					(long long)mft_no);
 			return -ENOENT;
 		}
 	}
-	/* Read, map, and pin the page containing the mft record. */
-	page = ntfs_map_page(mft_vi->i_mapping, index);
-	if (IS_ERR(page)) {
-		ntfs_error(vol->sb, "Failed to map page containing mft record "
-				"to format 0x%llx.", (long long)mft_no);
-		return PTR_ERR(page);
-	}
-	lock_page(page);
-	BUG_ON(!PageUptodate(page));
-	ClearPageUptodate(page);
-	m = (MFT_RECORD*)((u8*)page_address(page) + ofs);
+
+	/* Read, map, and pin the folio containing the mft record. */
+	folio = read_mapping_folio(mft_vi->i_mapping, index, NULL);
+	if (IS_ERR(folio)) {
+		ntfs_error(vol->sb, "Failed to map page containing mft record to format 0x%llx.",
+				(long long)mft_no);
+		return PTR_ERR(folio);
+	}
+	folio_lock(folio);
+	folio_clear_uptodate(folio);
+	m = (struct mft_record *)((u8 *)kmap_local_folio(folio, 0) + ofs);
 	err = ntfs_mft_record_layout(vol, mft_no, m);
 	if (unlikely(err)) {
 		ntfs_error(vol->sb, "Failed to layout mft record 0x%llx.",
 				(long long)mft_no);
-		SetPageUptodate(page);
-		unlock_page(page);
-		ntfs_unmap_page(page);
+		folio_mark_uptodate(folio);
+		folio_unlock(folio);
+		kunmap_local(m);
+		folio_put(folio);
 		return err;
 	}
-	flush_dcache_page(page);
-	SetPageUptodate(page);
-	unlock_page(page);
+	pre_write_mst_fixup((struct ntfs_record *)m, vol->mft_record_size);
+	flush_dcache_folio(folio);
+	folio_mark_uptodate(folio);
 	/*
 	 * Make sure the mft record is written out to disk.  We could use
 	 * ilookup5() to check if an inode is in icache and so on but this is
 	 * unnecessary as ntfs_writepage() will write the dirty record anyway.
 	 */
-	mark_ntfs_record_dirty(page, ofs);
-	ntfs_unmap_page(page);
+	mark_ntfs_record_dirty(folio);
+	folio_unlock(folio);
+	kunmap_local(m);
+	folio_put(folio);
 	ntfs_debug("Done.");
 	return 0;
 }
@@ -2152,7 +1985,7 @@ static int ntfs_mft_record_format(const ntfs_volume *vol, const s64 mft_no)
  * @vol:	[IN]  volume on which to allocate the mft record
  * @mode:	[IN]  mode if want a file or directory, i.e. base inode or 0
  * @base_ni:	[IN]  open base inode if allocating an extent mft record or NULL
- * @mrec:	[OUT] on successful return this is the mapped mft record
+ * @ni_mrec:	[OUT] on successful return this is the mapped mft record
  *
  * Allocate an mft record in $MFT/$DATA of an open ntfs volume @vol.
  *
@@ -2180,8 +2013,8 @@ static int ntfs_mft_record_format(const ntfs_volume *vol, const s64 mft_no)
  * optimize this we start scanning at the place specified by @base_ni or if
  * @base_ni is NULL we start where we last stopped and we perform wrap around
  * when we reach the end.  Note, we do not try to allocate mft records below
- * number 24 because numbers 0 to 15 are the defined system files anyway and 16
- * to 24 are special in that they are used for storing extension mft records
+ * number 64 because numbers 0 to 15 are the defined system files anyway and 16
+ * to 64 are special in that they are used for storing extension mft records
  * for the $DATA attribute of $MFT.  This is required to avoid the possibility
  * of creating a runlist with a circular dependency which once written to disk
  * can never be read in again.  Windows will only use records 16 to 24 for
@@ -2191,7 +2024,7 @@ static int ntfs_mft_record_format(const ntfs_volume *vol, const s64 mft_no)
  * doing this at some later time, it does not matter much for now.
  *
  * When scanning the mft bitmap, we only search up to the last allocated mft
- * record.  If there are no free records left in the range 24 to number of
+ * record.  If there are no free records left in the range 64 to number of
  * allocated mft records, then we extend the $MFT/$DATA attribute in order to
  * create free mft records.  We extend the allocated size of $MFT/$DATA by 16
  * records at a time or one cluster, if cluster size is above 16kiB.  If there
@@ -2200,24 +2033,24 @@ static int ntfs_mft_record_format(const ntfs_volume *vol, const s64 mft_no)
  *
  * No matter how many mft records we allocate, we initialize only the first
  * allocated mft record, incrementing mft data size and initialized size
- * accordingly, open an ntfs_inode for it and return it to the caller, unless
- * there are less than 24 mft records, in which case we allocate and initialize
- * mft records until we reach record 24 which we consider as the first free mft
+ * accordingly, open an struct ntfs_inode for it and return it to the caller, unless
+ * there are less than 64 mft records, in which case we allocate and initialize
+ * mft records until we reach record 64 which we consider as the first free mft
  * record for use by normal files.
  *
  * If during any stage we overflow the initialized data in the mft bitmap, we
  * extend the initialized size (and data size) by 8 bytes, allocating another
  * cluster if required.  The bitmap data size has to be at least equal to the
  * number of mft records in the mft, but it can be bigger, in which case the
- * superflous bits are padded with zeroes.
+ * superfluous bits are padded with zeroes.
  *
  * Thus, when we return successfully (IS_ERR() is false), we will have:
  *	- initialized / extended the mft bitmap if necessary,
  *	- initialized / extended the mft data if necessary,
  *	- set the bit corresponding to the mft record being allocated in the
  *	  mft bitmap,
- *	- opened an ntfs_inode for the allocated mft record, and we will have
- *	- returned the ntfs_inode as well as the allocated mapped, pinned, and
+ *	- opened an struct ntfs_inode for the allocated mft record, and we will have
+ *	- returned the struct ntfs_inode as well as the allocated mapped, pinned, and
  *	  locked mft record.
  *
  * On error, the volume will be left in a consistent state and no record will
@@ -2237,42 +2070,46 @@ static int ntfs_mft_record_format(const ntfs_volume *vol, const s64 mft_no)
  * easier because otherwise there might be circular invocations of functions
  * when reading the bitmap.
  */
-ntfs_inode *ntfs_mft_record_alloc(ntfs_volume *vol, const int mode,
-		ntfs_inode *base_ni, MFT_RECORD **mrec)
+int ntfs_mft_record_alloc(struct ntfs_volume *vol, const int mode,
+			  struct ntfs_inode **ni, struct ntfs_inode *base_ni,
+			  struct mft_record **ni_mrec)
 {
 	s64 ll, bit, old_data_initialized, old_data_size;
 	unsigned long flags;
-	struct inode *vi;
-	struct page *page;
-	ntfs_inode *mft_ni, *mftbmp_ni, *ni;
-	ntfs_attr_search_ctx *ctx;
-	MFT_RECORD *m;
-	ATTR_RECORD *a;
+	struct folio *folio;
+	struct ntfs_inode *mft_ni, *mftbmp_ni;
+	struct ntfs_attr_search_ctx *ctx;
+	struct mft_record *m = NULL;
+	struct attr_record *a;
 	pgoff_t index;
 	unsigned int ofs;
 	int err;
-	le16 seq_no, usn;
+	__le16 seq_no, usn;
 	bool record_formatted = false;
+	unsigned int memalloc_flags;
 
-	if (base_ni) {
-		ntfs_debug("Entering (allocating an extent mft record for "
-				"base mft record 0x%llx).",
+	if (base_ni && *ni)
+		return -EINVAL;
+
+	/* @mode and @base_ni are mutually exclusive. */
+	if (mode && base_ni)
+		return -EINVAL;
+
+	if (base_ni)
+		ntfs_debug("Entering (allocating an extent mft record for base mft record 0x%llx).",
 				(long long)base_ni->mft_no);
-		/* @mode and @base_ni are mutually exclusive. */
-		BUG_ON(mode);
-	} else
+	else
 		ntfs_debug("Entering (allocating a base mft record).");
-	if (mode) {
-		/* @mode and @base_ni are mutually exclusive. */
-		BUG_ON(base_ni);
-		/* We only support creation of normal files and directories. */
-		if (!S_ISREG(mode) && !S_ISDIR(mode))
-			return ERR_PTR(-EOPNOTSUPP);
-	}
-	BUG_ON(!mrec);
+
+	memalloc_flags = memalloc_nofs_save();
+
 	mft_ni = NTFS_I(vol->mft_ino);
+	if (!base_ni || base_ni->mft_no != FILE_MFT)
+		mutex_lock(&mft_ni->mrec_lock);
 	mftbmp_ni = NTFS_I(vol->mftbmp_ino);
-	down_write(&vol->mftbmp_lock);
+search_free_rec:
+	if (!base_ni || base_ni->mft_no != FILE_MFT)
+		down_write(&vol->mftbmp_lock);
 	bit = ntfs_mft_bitmap_find_and_alloc_free_rec_nolock(vol, base_ni);
 	if (bit >= 0) {
 		ntfs_debug("Found and allocated free record (#1), bit 0x%llx.",
@@ -2280,9 +2117,19 @@ ntfs_inode *ntfs_mft_record_alloc(ntfs_volume *vol, const int mode,
 		goto have_alloc_rec;
 	}
 	if (bit != -ENOSPC) {
-		up_write(&vol->mftbmp_lock);
-		return ERR_PTR(bit);
+		if (!base_ni || base_ni->mft_no != FILE_MFT) {
+			up_write(&vol->mftbmp_lock);
+			mutex_unlock(&mft_ni->mrec_lock);
+		}
+		memalloc_nofs_restore(memalloc_flags);
+		return bit;
 	}
+
+	if (base_ni && base_ni->mft_no == FILE_MFT) {
+		memalloc_nofs_restore(memalloc_flags);
+		return bit;
+	}
+
 	/*
 	 * No free mft records left.  If the mft bitmap already covers more
 	 * than the currently used mft records, the next records are all free,
@@ -2297,10 +2144,11 @@ ntfs_inode *ntfs_mft_record_alloc(ntfs_volume *vol, const int mode,
 	read_lock_irqsave(&mftbmp_ni->size_lock, flags);
 	old_data_initialized = mftbmp_ni->initialized_size;
 	read_unlock_irqrestore(&mftbmp_ni->size_lock, flags);
-	if (old_data_initialized << 3 > ll && old_data_initialized > 3) {
+	if (old_data_initialized << 3 > ll &&
+	    old_data_initialized > RESERVED_MFT_RECORDS / 8) {
 		bit = ll;
-		if (bit < 24)
-			bit = 24;
+		if (bit < RESERVED_MFT_RECORDS)
+			bit = RESERVED_MFT_RECORDS;
 		if (unlikely(bit >= (1ll << 32)))
 			goto max_err_out;
 		ntfs_debug("Found free record (#2), bit 0x%llx.",
@@ -2317,28 +2165,28 @@ ntfs_inode *ntfs_mft_record_alloc(ntfs_volume *vol, const int mode,
 		goto max_err_out;
 	read_lock_irqsave(&mftbmp_ni->size_lock, flags);
 	old_data_size = mftbmp_ni->allocated_size;
-	ntfs_debug("Status of mftbmp before extension: allocated_size 0x%llx, "
-			"data_size 0x%llx, initialized_size 0x%llx.",
-			(long long)old_data_size,
-			(long long)i_size_read(vol->mftbmp_ino),
-			(long long)old_data_initialized);
+	ntfs_debug("Status of mftbmp before extension: allocated_size 0x%llx, data_size 0x%llx, initialized_size 0x%llx.",
+			old_data_size, i_size_read(vol->mftbmp_ino),
+			old_data_initialized);
 	read_unlock_irqrestore(&mftbmp_ni->size_lock, flags);
 	if (old_data_initialized + 8 > old_data_size) {
 		/* Need to extend bitmap by one more cluster. */
 		ntfs_debug("mftbmp: initialized_size + 8 > allocated_size.");
 		err = ntfs_mft_bitmap_extend_allocation_nolock(vol);
+		if (err == -EAGAIN)
+			err = ntfs_mft_bitmap_extend_allocation_nolock(vol);
+
 		if (unlikely(err)) {
-			up_write(&vol->mftbmp_lock);
+			if (!base_ni || base_ni->mft_no != FILE_MFT)
+				up_write(&vol->mftbmp_lock);
 			goto err_out;
 		}
 #ifdef DEBUG
 		read_lock_irqsave(&mftbmp_ni->size_lock, flags);
-		ntfs_debug("Status of mftbmp after allocation extension: "
-				"allocated_size 0x%llx, data_size 0x%llx, "
-				"initialized_size 0x%llx.",
-				(long long)mftbmp_ni->allocated_size,
-				(long long)i_size_read(vol->mftbmp_ino),
-				(long long)mftbmp_ni->initialized_size);
+		ntfs_debug("Status of mftbmp after allocation extension: allocated_size 0x%llx, data_size 0x%llx, initialized_size 0x%llx.",
+				mftbmp_ni->allocated_size,
+				i_size_read(vol->mftbmp_ino),
+				mftbmp_ni->initialized_size);
 		read_unlock_irqrestore(&mftbmp_ni->size_lock, flags);
 #endif /* DEBUG */
 	}
@@ -2349,17 +2197,16 @@ ntfs_inode *ntfs_mft_record_alloc(ntfs_volume *vol, const int mode,
 	 */
 	err = ntfs_mft_bitmap_extend_initialized_nolock(vol);
 	if (unlikely(err)) {
-		up_write(&vol->mftbmp_lock);
+		if (!base_ni || base_ni->mft_no != FILE_MFT)
+			up_write(&vol->mftbmp_lock);
 		goto err_out;
 	}
 #ifdef DEBUG
 	read_lock_irqsave(&mftbmp_ni->size_lock, flags);
-	ntfs_debug("Status of mftbmp after initialized extension: "
-			"allocated_size 0x%llx, data_size 0x%llx, "
-			"initialized_size 0x%llx.",
-			(long long)mftbmp_ni->allocated_size,
-			(long long)i_size_read(vol->mftbmp_ino),
-			(long long)mftbmp_ni->initialized_size);
+	ntfs_debug("Status of mftbmp after initialized extension: allocated_size 0x%llx, data_size 0x%llx, initialized_size 0x%llx.",
+			mftbmp_ni->allocated_size,
+			i_size_read(vol->mftbmp_ino),
+			mftbmp_ni->initialized_size);
 	read_unlock_irqrestore(&mftbmp_ni->size_lock, flags);
 #endif /* DEBUG */
 	ntfs_debug("Found free record (#3), bit 0x%llx.", (long long)bit);
@@ -2369,7 +2216,8 @@ ntfs_inode *ntfs_mft_record_alloc(ntfs_volume *vol, const int mode,
 	err = ntfs_bitmap_set_bit(vol->mftbmp_ino, bit);
 	if (unlikely(err)) {
 		ntfs_error(vol->sb, "Failed to allocate bit in mft bitmap.");
-		up_write(&vol->mftbmp_lock);
+		if (!base_ni || base_ni->mft_no != FILE_MFT)
+			up_write(&vol->mftbmp_lock);
 		goto err_out;
 	}
 	ntfs_debug("Set bit 0x%llx in mft bitmap.", (long long)bit);
@@ -2397,34 +2245,35 @@ ntfs_inode *ntfs_mft_record_alloc(ntfs_volume *vol, const int mode,
 	 * actually traversed more than once when a freshly formatted volume is
 	 * first written to so it optimizes away nicely in the common case.
 	 */
-	read_lock_irqsave(&mft_ni->size_lock, flags);
-	ntfs_debug("Status of mft data before extension: "
-			"allocated_size 0x%llx, data_size 0x%llx, "
-			"initialized_size 0x%llx.",
-			(long long)mft_ni->allocated_size,
-			(long long)i_size_read(vol->mft_ino),
-			(long long)mft_ni->initialized_size);
-	while (ll > mft_ni->allocated_size) {
-		read_unlock_irqrestore(&mft_ni->size_lock, flags);
-		err = ntfs_mft_data_extend_allocation_nolock(vol);
-		if (unlikely(err)) {
-			ntfs_error(vol->sb, "Failed to extend mft data "
-					"allocation.");
-			goto undo_mftbmp_alloc_nolock;
-		}
+	if (!base_ni || base_ni->mft_no != FILE_MFT) {
 		read_lock_irqsave(&mft_ni->size_lock, flags);
-		ntfs_debug("Status of mft data after allocation extension: "
-				"allocated_size 0x%llx, data_size 0x%llx, "
-				"initialized_size 0x%llx.",
-				(long long)mft_ni->allocated_size,
-				(long long)i_size_read(vol->mft_ino),
-				(long long)mft_ni->initialized_size);
+		ntfs_debug("Status of mft data before extension: allocated_size 0x%llx, data_size 0x%llx, initialized_size 0x%llx.",
+				mft_ni->allocated_size, i_size_read(vol->mft_ino),
+				mft_ni->initialized_size);
+		while (ll > mft_ni->allocated_size) {
+			read_unlock_irqrestore(&mft_ni->size_lock, flags);
+			err = ntfs_mft_data_extend_allocation_nolock(vol);
+			if (err == -EAGAIN)
+				err = ntfs_mft_data_extend_allocation_nolock(vol);
+
+			if (unlikely(err)) {
+				ntfs_error(vol->sb, "Failed to extend mft data allocation.");
+				goto undo_mftbmp_alloc_nolock;
+			}
+			read_lock_irqsave(&mft_ni->size_lock, flags);
+			ntfs_debug("Status of mft data after allocation extension: allocated_size 0x%llx, data_size 0x%llx, initialized_size 0x%llx.",
+					mft_ni->allocated_size, i_size_read(vol->mft_ino),
+					mft_ni->initialized_size);
+		}
+		read_unlock_irqrestore(&mft_ni->size_lock, flags);
+	} else if (ll > mft_ni->allocated_size) {
+		err = -ENOSPC;
+		goto undo_mftbmp_alloc_nolock;
 	}
-	read_unlock_irqrestore(&mft_ni->size_lock, flags);
 	/*
 	 * Extend mft data initialized size (and data size of course) to reach
 	 * the allocated mft record, formatting the mft records allong the way.
-	 * Note: We only modify the ntfs_inode structure as that is all that is
+	 * Note: We only modify the struct ntfs_inode structure as that is all that is
 	 * needed by ntfs_mft_record_format().  We will update the attribute
 	 * record itself in one fell swoop later on.
 	 */
@@ -2433,7 +2282,7 @@ ntfs_inode *ntfs_mft_record_alloc(ntfs_volume *vol, const int mode,
 	old_data_size = vol->mft_ino->i_size;
 	while (ll > mft_ni->initialized_size) {
 		s64 new_initialized_size, mft_no;
-		
+
 		new_initialized_size = mft_ni->initialized_size +
 				vol->mft_record_size;
 		mft_no = mft_ni->initialized_size >> vol->mft_record_size_bits;
@@ -2469,8 +2318,7 @@ ntfs_inode *ntfs_mft_record_alloc(ntfs_volume *vol, const int mode,
 	err = ntfs_attr_lookup(mft_ni->type, mft_ni->name, mft_ni->name_len,
 			CASE_SENSITIVE, 0, NULL, 0, ctx);
 	if (unlikely(err)) {
-		ntfs_error(vol->sb, "Failed to find first attribute extent of "
-				"mft data attribute.");
+		ntfs_error(vol->sb, "Failed to find first attribute extent of mft data attribute.");
 		ntfs_attr_put_search_ctx(ctx);
 		unmap_mft_record(mft_ni);
 		goto undo_data_init;
@@ -2478,24 +2326,20 @@ ntfs_inode *ntfs_mft_record_alloc(ntfs_volume *vol, const int mode,
 	a = ctx->attr;
 	read_lock_irqsave(&mft_ni->size_lock, flags);
 	a->data.non_resident.initialized_size =
-			cpu_to_sle64(mft_ni->initialized_size);
+			cpu_to_le64(mft_ni->initialized_size);
 	a->data.non_resident.data_size =
-			cpu_to_sle64(i_size_read(vol->mft_ino));
+			cpu_to_le64(i_size_read(vol->mft_ino));
 	read_unlock_irqrestore(&mft_ni->size_lock, flags);
 	/* Ensure the changes make it to disk. */
-	flush_dcache_mft_record_page(ctx->ntfs_ino);
 	mark_mft_record_dirty(ctx->ntfs_ino);
 	ntfs_attr_put_search_ctx(ctx);
 	unmap_mft_record(mft_ni);
 	read_lock_irqsave(&mft_ni->size_lock, flags);
-	ntfs_debug("Status of mft data after mft record initialization: "
-			"allocated_size 0x%llx, data_size 0x%llx, "
-			"initialized_size 0x%llx.",
-			(long long)mft_ni->allocated_size,
-			(long long)i_size_read(vol->mft_ino),
-			(long long)mft_ni->initialized_size);
-	BUG_ON(i_size_read(vol->mft_ino) > mft_ni->allocated_size);
-	BUG_ON(mft_ni->initialized_size > i_size_read(vol->mft_ino));
+	ntfs_debug("Status of mft data after mft record initialization: allocated_size 0x%llx, data_size 0x%llx, initialized_size 0x%llx.",
+			mft_ni->allocated_size,	i_size_read(vol->mft_ino),
+			mft_ni->initialized_size);
+	WARN_ON(i_size_read(vol->mft_ino) > mft_ni->allocated_size);
+	WARN_ON(mft_ni->initialized_size > i_size_read(vol->mft_ino));
 	read_unlock_irqrestore(&mft_ni->size_lock, flags);
 mft_rec_already_initialized:
 	/*
@@ -2507,41 +2351,39 @@ ntfs_inode *ntfs_mft_record_alloc(ntfs_volume *vol, const int mode,
 	 * that it is allocated in the mft bitmap means that no-one will try to
 	 * allocate it either.
 	 */
-	up_write(&vol->mftbmp_lock);
+	if (!base_ni || base_ni->mft_no != FILE_MFT)
+		up_write(&vol->mftbmp_lock);
 	/*
 	 * We now have allocated and initialized the mft record.  Calculate the
 	 * index of and the offset within the page cache page the record is in.
 	 */
-	index = bit << vol->mft_record_size_bits >> PAGE_SHIFT;
-	ofs = (bit << vol->mft_record_size_bits) & ~PAGE_MASK;
-	/* Read, map, and pin the page containing the mft record. */
-	page = ntfs_map_page(vol->mft_ino->i_mapping, index);
-	if (IS_ERR(page)) {
-		ntfs_error(vol->sb, "Failed to map page containing allocated "
-				"mft record 0x%llx.", (long long)bit);
-		err = PTR_ERR(page);
+	index = NTFS_MFT_NR_TO_PIDX(vol, bit);
+	ofs = NTFS_MFT_NR_TO_POFS(vol, bit);
+	/* Read, map, and pin the folio containing the mft record. */
+	folio = read_mapping_folio(vol->mft_ino->i_mapping, index, NULL);
+	if (IS_ERR(folio)) {
+		ntfs_error(vol->sb, "Failed to map page containing allocated mft record 0x%llx.",
+				bit);
+		err = PTR_ERR(folio);
 		goto undo_mftbmp_alloc;
 	}
-	lock_page(page);
-	BUG_ON(!PageUptodate(page));
-	ClearPageUptodate(page);
-	m = (MFT_RECORD*)((u8*)page_address(page) + ofs);
+	folio_lock(folio);
+	folio_clear_uptodate(folio);
+	m = (struct mft_record *)((u8 *)kmap_local_folio(folio, 0) + ofs);
 	/* If we just formatted the mft record no need to do it again. */
 	if (!record_formatted) {
 		/* Sanity check that the mft record is really not in use. */
 		if (ntfs_is_file_record(m->magic) &&
 				(m->flags & MFT_RECORD_IN_USE)) {
-			ntfs_error(vol->sb, "Mft record 0x%llx was marked "
-					"free in mft bitmap but is marked "
-					"used itself.  Corrupt filesystem.  "
-					"Unmount and run chkdsk.",
-					(long long)bit);
-			err = -EIO;
-			SetPageUptodate(page);
-			unlock_page(page);
-			ntfs_unmap_page(page);
+			ntfs_warning(vol->sb,
+				"Mft record 0x%llx was marked free in mft bitmap but is marked used itself. Unmount and run chkdsk.",
+				bit);
+			folio_mark_uptodate(folio);
+			folio_unlock(folio);
+			kunmap_local(m);
+			folio_put(folio);
 			NVolSetErrors(vol);
-			goto undo_mftbmp_alloc;
+			goto search_free_rec;
 		}
 		/*
 		 * We need to (re-)format the mft record, preserving the
@@ -2551,29 +2393,31 @@ ntfs_inode *ntfs_mft_record_alloc(ntfs_volume *vol, const int mode,
 		 * wrong with the previous mft record.
 		 */
 		seq_no = m->sequence_number;
-		usn = *(le16*)((u8*)m + le16_to_cpu(m->usa_ofs));
+		usn = *(__le16 *)((u8 *)m + le16_to_cpu(m->usa_ofs));
 		err = ntfs_mft_record_layout(vol, bit, m);
 		if (unlikely(err)) {
-			ntfs_error(vol->sb, "Failed to layout allocated mft "
-					"record 0x%llx.", (long long)bit);
-			SetPageUptodate(page);
-			unlock_page(page);
-			ntfs_unmap_page(page);
+			ntfs_error(vol->sb, "Failed to layout allocated mft record 0x%llx.",
+					bit);
+			folio_mark_uptodate(folio);
+			folio_unlock(folio);
+			kunmap_local(m);
+			folio_put(folio);
 			goto undo_mftbmp_alloc;
 		}
 		if (seq_no)
 			m->sequence_number = seq_no;
 		if (usn && le16_to_cpu(usn) != 0xffff)
-			*(le16*)((u8*)m + le16_to_cpu(m->usa_ofs)) = usn;
+			*(__le16 *)((u8 *)m + le16_to_cpu(m->usa_ofs)) = usn;
+		pre_write_mst_fixup((struct ntfs_record *)m, vol->mft_record_size);
 	}
 	/* Set the mft record itself in use. */
 	m->flags |= MFT_RECORD_IN_USE;
 	if (S_ISDIR(mode))
 		m->flags |= MFT_RECORD_IS_DIRECTORY;
-	flush_dcache_page(page);
-	SetPageUptodate(page);
+	flush_dcache_folio(folio);
+	folio_mark_uptodate(folio);
 	if (base_ni) {
-		MFT_RECORD *m_tmp;
+		struct mft_record *m_tmp;
 
 		/*
 		 * Setup the base mft record in the extent mft record.  This
@@ -2587,22 +2431,25 @@ ntfs_inode *ntfs_mft_record_alloc(ntfs_volume *vol, const int mode,
 		 * attach it to the base inode @base_ni and map, pin, and lock
 		 * its, i.e. the allocated, mft record.
 		 */
-		m_tmp = map_extent_mft_record(base_ni, bit, &ni);
+		m_tmp = map_extent_mft_record(base_ni,
+					      MK_MREF(bit, le16_to_cpu(m->sequence_number)),
+					      ni);
 		if (IS_ERR(m_tmp)) {
-			ntfs_error(vol->sb, "Failed to map allocated extent "
-					"mft record 0x%llx.", (long long)bit);
+			ntfs_error(vol->sb, "Failed to map allocated extent mft record 0x%llx.",
+					bit);
 			err = PTR_ERR(m_tmp);
 			/* Set the mft record itself not in use. */
 			m->flags &= cpu_to_le16(
 					~le16_to_cpu(MFT_RECORD_IN_USE));
-			flush_dcache_page(page);
+			flush_dcache_folio(folio);
 			/* Make sure the mft record is written out to disk. */
-			mark_ntfs_record_dirty(page, ofs);
-			unlock_page(page);
-			ntfs_unmap_page(page);
+			mark_ntfs_record_dirty(folio);
+			folio_unlock(folio);
+			kunmap_local(m);
+			folio_put(folio);
 			goto undo_mftbmp_alloc;
 		}
-		BUG_ON(m != m_tmp);
+
 		/*
 		 * Make sure the allocated mft record is written out to disk.
 		 * No need to set the inode dirty because the caller is going
@@ -2610,96 +2457,20 @@ ntfs_inode *ntfs_mft_record_alloc(ntfs_volume *vol, const int mode,
 		 * record (e.g. at a minimum a new attribute will be added to
 		 * the mft record.
 		 */
-		mark_ntfs_record_dirty(page, ofs);
-		unlock_page(page);
+		mark_ntfs_record_dirty(folio);
+		folio_unlock(folio);
 		/*
 		 * Need to unmap the page since map_extent_mft_record() mapped
 		 * it as well so we have it mapped twice at the moment.
 		 */
-		ntfs_unmap_page(page);
+		kunmap_local(m);
+		folio_put(folio);
 	} else {
-		/*
-		 * Allocate a new VFS inode and set it up.  NOTE: @vi->i_nlink
-		 * is set to 1 but the mft record->link_count is 0.  The caller
-		 * needs to bear this in mind.
-		 */
-		vi = new_inode(vol->sb);
-		if (unlikely(!vi)) {
-			err = -ENOMEM;
-			/* Set the mft record itself not in use. */
-			m->flags &= cpu_to_le16(
-					~le16_to_cpu(MFT_RECORD_IN_USE));
-			flush_dcache_page(page);
-			/* Make sure the mft record is written out to disk. */
-			mark_ntfs_record_dirty(page, ofs);
-			unlock_page(page);
-			ntfs_unmap_page(page);
-			goto undo_mftbmp_alloc;
-		}
-		vi->i_ino = bit;
-
-		/* The owner and group come from the ntfs volume. */
-		vi->i_uid = vol->uid;
-		vi->i_gid = vol->gid;
-
-		/* Initialize the ntfs specific part of @vi. */
-		ntfs_init_big_inode(vi);
-		ni = NTFS_I(vi);
-		/*
-		 * Set the appropriate mode, attribute type, and name.  For
-		 * directories, also setup the index values to the defaults.
-		 */
-		if (S_ISDIR(mode)) {
-			vi->i_mode = S_IFDIR | S_IRWXUGO;
-			vi->i_mode &= ~vol->dmask;
-
-			NInoSetMstProtected(ni);
-			ni->type = AT_INDEX_ALLOCATION;
-			ni->name = I30;
-			ni->name_len = 4;
-
-			ni->itype.index.block_size = 4096;
-			ni->itype.index.block_size_bits = ntfs_ffs(4096) - 1;
-			ni->itype.index.collation_rule = COLLATION_FILE_NAME;
-			if (vol->cluster_size <= ni->itype.index.block_size) {
-				ni->itype.index.vcn_size = vol->cluster_size;
-				ni->itype.index.vcn_size_bits =
-						vol->cluster_size_bits;
-			} else {
-				ni->itype.index.vcn_size = vol->sector_size;
-				ni->itype.index.vcn_size_bits =
-						vol->sector_size_bits;
-			}
-		} else {
-			vi->i_mode = S_IFREG | S_IRWXUGO;
-			vi->i_mode &= ~vol->fmask;
-
-			ni->type = AT_DATA;
-			ni->name = NULL;
-			ni->name_len = 0;
-		}
-		if (IS_RDONLY(vi))
-			vi->i_mode &= ~S_IWUGO;
-
-		/* Set the inode times to the current time. */
-		simple_inode_init_ts(vi);
-		/*
-		 * Set the file size to 0, the ntfs inode sizes are set to 0 by
-		 * the call to ntfs_init_big_inode() below.
-		 */
-		vi->i_size = 0;
-		vi->i_blocks = 0;
-
-		/* Set the sequence number. */
-		vi->i_generation = ni->seq_no = le16_to_cpu(m->sequence_number);
 		/*
 		 * Manually map, pin, and lock the mft record as we already
 		 * have its page mapped and it is very easy to do.
 		 */
-		atomic_inc(&ni->count);
-		mutex_lock(&ni->mrec_lock);
-		ni->page = page;
-		ni->page_ofs = ofs;
+		(*ni)->seq_no = le16_to_cpu(m->sequence_number);
 		/*
 		 * Make sure the allocated mft record is written out to disk.
 		 * NOTE: We do not set the ntfs inode dirty because this would
@@ -2710,23 +2481,40 @@ ntfs_inode *ntfs_mft_record_alloc(ntfs_volume *vol, const int mode,
 		 * a minimum some new attributes will be added to the mft
 		 * record.
 		 */
-		mark_ntfs_record_dirty(page, ofs);
-		unlock_page(page);
 
-		/* Add the inode to the inode hash for the superblock. */
-		insert_inode_hash(vi);
+		(*ni)->mrec = kmalloc(vol->mft_record_size, GFP_NOFS);
+		if (!(*ni)->mrec) {
+			folio_unlock(folio);
+			kunmap_local(m);
+			folio_put(folio);
+			goto undo_mftbmp_alloc;
+		}
 
+		memcpy((*ni)->mrec, m, vol->mft_record_size);
+		post_read_mst_fixup((struct ntfs_record *)(*ni)->mrec, vol->mft_record_size);
+		mark_ntfs_record_dirty(folio);
+		folio_unlock(folio);
+		(*ni)->folio = folio;
+		(*ni)->folio_ofs = ofs;
+		atomic_inc(&(*ni)->count);
 		/* Update the default mft allocation position. */
 		vol->mft_data_pos = bit + 1;
 	}
+	if (!base_ni || base_ni->mft_no != FILE_MFT)
+		mutex_unlock(&mft_ni->mrec_lock);
+	memalloc_nofs_restore(memalloc_flags);
+
 	/*
 	 * Return the opened, allocated inode of the allocated mft record as
 	 * well as the mapped, pinned, and locked mft record.
 	 */
 	ntfs_debug("Returning opened, allocated %sinode 0x%llx.",
-			base_ni ? "extent " : "", (long long)bit);
-	*mrec = m;
-	return ni;
+			base_ni ? "extent " : "", bit);
+	(*ni)->mft_no = bit;
+	if (ni_mrec)
+		*ni_mrec = (*ni)->mrec;
+	ntfs_dec_free_mft_records(vol, 1);
+	return 0;
 undo_data_init:
 	write_lock_irqsave(&mft_ni->size_lock, flags);
 	mft_ni->initialized_size = old_data_initialized;
@@ -2734,114 +2522,83 @@ ntfs_inode *ntfs_mft_record_alloc(ntfs_volume *vol, const int mode,
 	write_unlock_irqrestore(&mft_ni->size_lock, flags);
 	goto undo_mftbmp_alloc_nolock;
 undo_mftbmp_alloc:
-	down_write(&vol->mftbmp_lock);
+	if (!base_ni || base_ni->mft_no != FILE_MFT)
+		down_write(&vol->mftbmp_lock);
 undo_mftbmp_alloc_nolock:
 	if (ntfs_bitmap_clear_bit(vol->mftbmp_ino, bit)) {
 		ntfs_error(vol->sb, "Failed to clear bit in mft bitmap.%s", es);
 		NVolSetErrors(vol);
 	}
-	up_write(&vol->mftbmp_lock);
+	if (!base_ni || base_ni->mft_no != FILE_MFT)
+		up_write(&vol->mftbmp_lock);
 err_out:
-	return ERR_PTR(err);
+	if (!base_ni || base_ni->mft_no != FILE_MFT)
+		mutex_unlock(&mft_ni->mrec_lock);
+	memalloc_nofs_restore(memalloc_flags);
+	return err;
 max_err_out:
-	ntfs_warning(vol->sb, "Cannot allocate mft record because the maximum "
-			"number of inodes (2^32) has already been reached.");
-	up_write(&vol->mftbmp_lock);
-	return ERR_PTR(-ENOSPC);
+	ntfs_warning(vol->sb,
+		"Cannot allocate mft record because the maximum number of inodes (2^32) has already been reached.");
+	if (!base_ni || base_ni->mft_no != FILE_MFT) {
+		up_write(&vol->mftbmp_lock);
+		mutex_unlock(&mft_ni->mrec_lock);
+	}
+	memalloc_nofs_restore(memalloc_flags);
+	return -ENOSPC;
 }
 
 /**
- * ntfs_extent_mft_record_free - free an extent mft record on an ntfs volume
- * @ni:		ntfs inode of the mapped extent mft record to free
- * @m:		mapped extent mft record of the ntfs inode @ni
- *
- * Free the mapped extent mft record @m of the extent ntfs inode @ni.
+ * ntfs_mft_record_free - free an mft record on an ntfs volume
+ * @vol:	volume on which to free the mft record
+ * @ni:		open ntfs inode of the mft record to free
  *
- * Note that this function unmaps the mft record and closes and destroys @ni
- * internally and hence you cannot use either @ni nor @m any more after this
- * function returns success.
+ * Free the mft record of the open inode @ni on the mounted ntfs volume @vol.
+ * Note that this function calls ntfs_inode_close() internally and hence you
+ * cannot use the pointer @ni any more after this function returns success.
  *
- * On success return 0 and on error return -errno.  @ni and @m are still valid
- * in this case and have not been freed.
- *
- * For some errors an error message is displayed and the success code 0 is
- * returned and the volume is then left dirty on umount.  This makes sense in
- * case we could not rollback the changes that were already done since the
- * caller no longer wants to reference this mft record so it does not matter to
- * the caller if something is wrong with it as long as it is properly detached
- * from the base inode.
+ * On success return 0 and on error return -1 with errno set to the error code.
  */
-int ntfs_extent_mft_record_free(ntfs_inode *ni, MFT_RECORD *m)
+int ntfs_mft_record_free(struct ntfs_volume *vol, struct ntfs_inode *ni)
 {
-	unsigned long mft_no = ni->mft_no;
-	ntfs_volume *vol = ni->vol;
-	ntfs_inode *base_ni;
-	ntfs_inode **extent_nis;
-	int i, err;
-	le16 old_seq_no;
+	u64 mft_no;
+	int err;
 	u16 seq_no;
-	
-	BUG_ON(NInoAttr(ni));
-	BUG_ON(ni->nr_extents != -1);
-
-	mutex_lock(&ni->extent_lock);
-	base_ni = ni->ext.base_ntfs_ino;
-	mutex_unlock(&ni->extent_lock);
-
-	BUG_ON(base_ni->nr_extents <= 0);
-
-	ntfs_debug("Entering for extent inode 0x%lx, base inode 0x%lx.\n",
-			mft_no, base_ni->mft_no);
-
-	mutex_lock(&base_ni->extent_lock);
-
-	/* Make sure we are holding the only reference to the extent inode. */
-	if (atomic_read(&ni->count) > 2) {
-		ntfs_error(vol->sb, "Tried to free busy extent inode 0x%lx, "
-				"not freeing.", base_ni->mft_no);
-		mutex_unlock(&base_ni->extent_lock);
-		return -EBUSY;
-	}
+	__le16 old_seq_no;
+	struct mft_record *ni_mrec;
+	unsigned int memalloc_flags;
+	struct ntfs_inode *base_ni;
 
-	/* Dissociate the ntfs inode from the base inode. */
-	extent_nis = base_ni->ext.extent_ntfs_inos;
-	err = -ENOENT;
-	for (i = 0; i < base_ni->nr_extents; i++) {
-		if (ni != extent_nis[i])
-			continue;
-		extent_nis += i;
-		base_ni->nr_extents--;
-		memmove(extent_nis, extent_nis + 1, (base_ni->nr_extents - i) *
-				sizeof(ntfs_inode*));
-		err = 0;
-		break;
-	}
+	if (!vol || !ni)
+		return -EINVAL;
 
-	mutex_unlock(&base_ni->extent_lock);
+	ntfs_debug("Entering for inode 0x%llx.\n", (long long)ni->mft_no);
 
-	if (unlikely(err)) {
-		ntfs_error(vol->sb, "Extent inode 0x%lx is not attached to "
-				"its base inode 0x%lx.", mft_no,
-				base_ni->mft_no);
-		BUG();
-	}
+	ni_mrec = map_mft_record(ni);
+	if (IS_ERR(ni_mrec))
+		return -EIO;
 
-	/*
-	 * The extent inode is no longer attached to the base inode so no one
-	 * can get a reference to it any more.
-	 */
+	/* Cache the mft reference for later. */
+	mft_no = ni->mft_no;
 
 	/* Mark the mft record as not in use. */
-	m->flags &= ~MFT_RECORD_IN_USE;
+	ni_mrec->flags &= ~MFT_RECORD_IN_USE;
 
 	/* Increment the sequence number, skipping zero, if it is not zero. */
-	old_seq_no = m->sequence_number;
+	old_seq_no = ni_mrec->sequence_number;
 	seq_no = le16_to_cpu(old_seq_no);
 	if (seq_no == 0xffff)
 		seq_no = 1;
 	else if (seq_no)
 		seq_no++;
-	m->sequence_number = cpu_to_le16(seq_no);
+	ni_mrec->sequence_number = cpu_to_le16(seq_no);
+
+	down_read(&NTFS_I(vol->mft_ino)->runlist.lock);
+	err = ntfs_get_block_mft_record(NTFS_I(vol->mft_ino), ni);
+	up_read(&NTFS_I(vol->mft_ino)->runlist.lock);
+	if (err) {
+		unmap_mft_record(ni);
+		return err;
+	}
 
 	/*
 	 * Set the ntfs inode dirty and write it out.  We do not need to worry
@@ -2849,59 +2606,47 @@ int ntfs_extent_mft_record_free(ntfs_inode *ni, MFT_RECORD *m)
 	 * record to be freed is guaranteed to do it already.
 	 */
 	NInoSetDirty(ni);
-	err = write_mft_record(ni, m, 0);
-	if (unlikely(err)) {
-		ntfs_error(vol->sb, "Failed to write mft record 0x%lx, not "
-				"freeing.", mft_no);
-		goto rollback;
-	}
-rollback_error:
-	/* Unmap and throw away the now freed extent inode. */
-	unmap_extent_mft_record(ni);
-	ntfs_clear_extent_inode(ni);
+	err = write_mft_record(ni, ni_mrec, 0);
+	if (err)
+		goto sync_rollback;
+
+	if (likely(ni->nr_extents >= 0))
+		base_ni = ni;
+	else
+		base_ni = ni->ext.base_ntfs_ino;
 
 	/* Clear the bit in the $MFT/$BITMAP corresponding to this record. */
-	down_write(&vol->mftbmp_lock);
+	memalloc_flags = memalloc_nofs_save();
+	if (base_ni->mft_no != FILE_MFT)
+		down_write(&vol->mftbmp_lock);
 	err = ntfs_bitmap_clear_bit(vol->mftbmp_ino, mft_no);
-	up_write(&vol->mftbmp_lock);
-	if (unlikely(err)) {
-		/*
-		 * The extent inode is gone but we failed to deallocate it in
-		 * the mft bitmap.  Just emit a warning and leave the volume
-		 * dirty on umount.
-		 */
-		ntfs_error(vol->sb, "Failed to clear bit in mft bitmap.%s", es);
-		NVolSetErrors(vol);
-	}
+	if (base_ni->mft_no != FILE_MFT)
+		up_write(&vol->mftbmp_lock);
+	memalloc_nofs_restore(memalloc_flags);
+	if (err)
+		goto bitmap_rollback;
+
+	unmap_mft_record(ni);
+	ntfs_inc_free_mft_records(vol, 1);
 	return 0;
-rollback:
-	/* Rollback what we did... */
-	mutex_lock(&base_ni->extent_lock);
-	extent_nis = base_ni->ext.extent_ntfs_inos;
-	if (!(base_ni->nr_extents & 3)) {
-		int new_size = (base_ni->nr_extents + 4) * sizeof(ntfs_inode*);
 
-		extent_nis = kmalloc(new_size, GFP_NOFS);
-		if (unlikely(!extent_nis)) {
-			ntfs_error(vol->sb, "Failed to allocate internal "
-					"buffer during rollback.%s", es);
-			mutex_unlock(&base_ni->extent_lock);
-			NVolSetErrors(vol);
-			goto rollback_error;
-		}
-		if (base_ni->nr_extents) {
-			BUG_ON(!base_ni->ext.extent_ntfs_inos);
-			memcpy(extent_nis, base_ni->ext.extent_ntfs_inos,
-					new_size - 4 * sizeof(ntfs_inode*));
-			kfree(base_ni->ext.extent_ntfs_inos);
-		}
-		base_ni->ext.extent_ntfs_inos = extent_nis;
-	}
-	m->flags |= MFT_RECORD_IN_USE;
-	m->sequence_number = old_seq_no;
-	extent_nis[base_ni->nr_extents++] = ni;
-	mutex_unlock(&base_ni->extent_lock);
-	mark_mft_record_dirty(ni);
+	/* Rollback what we did... */
+bitmap_rollback:
+	memalloc_flags = memalloc_nofs_save();
+	if (base_ni->mft_no != FILE_MFT)
+		down_write(&vol->mftbmp_lock);
+	if (ntfs_bitmap_set_bit(vol->mftbmp_ino, mft_no))
+		ntfs_error(vol->sb, "ntfs_bitmap_set_bit failed in bitmap_rollback\n");
+	if (base_ni->mft_no != FILE_MFT)
+		up_write(&vol->mftbmp_lock);
+	memalloc_nofs_restore(memalloc_flags);
+sync_rollback:
+	ntfs_error(vol->sb,
+		"Eeek! Rollback failed in %s. Leaving inconsistent metadata!\n", __func__);
+	ni_mrec->flags |= MFT_RECORD_IN_USE;
+	ni_mrec->sequence_number = old_seq_no;
+	NInoSetDirty(ni);
+	write_mft_record(ni, ni_mrec, 0);
+	unmap_mft_record(ni);
 	return err;
 }
-#endif /* NTFS_RW */
diff --git a/fs/ntfs/mst.c b/fs/ntfs/mst.c
index 16b3c884abfc..e88f52831cb8 100644
--- a/fs/ntfs/mst.c
+++ b/fs/ntfs/mst.c
@@ -1,11 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * mst.c - NTFS multi sector transfer protection handling code. Part of the
- *	   Linux-NTFS project.
+ * NTFS multi sector transfer protection handling code.
+ * Part of the Linux-NTFS project.
  *
  * Copyright (c) 2001-2004 Anton Altaparmakov
  */
 
+#include <linux/ratelimit.h>
+
 #include "ntfs.h"
 
 /**
@@ -25,7 +27,7 @@
  * be fixed up. Thus, we return success and not failure in this case. This is
  * in contrast to pre_write_mst_fixup(), see below.
  */
-int post_read_mst_fixup(NTFS_RECORD *b, const u32 size)
+int post_read_mst_fixup(struct ntfs_record *b, const u32 size)
 {
 	u16 usa_ofs, usa_count, usn;
 	u16 *usa_pos, *data_pos;
@@ -35,13 +37,12 @@ int post_read_mst_fixup(NTFS_RECORD *b, const u32 size)
 	/* Decrement usa_count to get number of fixups. */
 	usa_count = le16_to_cpu(b->usa_count) - 1;
 	/* Size and alignment checks. */
-	if ( size & (NTFS_BLOCK_SIZE - 1)	||
-	     usa_ofs & 1			||
-	     usa_ofs + (usa_count * 2) > size	||
-	     (size >> NTFS_BLOCK_SIZE_BITS) != usa_count)
+	if (size & (NTFS_BLOCK_SIZE - 1) || usa_ofs & 1	||
+	    usa_ofs + (usa_count * 2) > size ||
+	    (size >> NTFS_BLOCK_SIZE_BITS) != usa_count)
 		return 0;
 	/* Position of usn in update sequence array. */
-	usa_pos = (u16*)b + usa_ofs/sizeof(u16);
+	usa_pos = (u16 *)b + usa_ofs/sizeof(u16);
 	/*
 	 * The update sequence number which has to be equal to each of the
 	 * u16 values before they are fixed up. Note no need to care for
@@ -53,12 +54,18 @@ int post_read_mst_fixup(NTFS_RECORD *b, const u32 size)
 	/*
 	 * Position in protected data of first u16 that needs fixing up.
 	 */
-	data_pos = (u16*)b + NTFS_BLOCK_SIZE/sizeof(u16) - 1;
+	data_pos = (u16 *)b + NTFS_BLOCK_SIZE / sizeof(u16) - 1;
 	/*
 	 * Check for incomplete multi sector transfer(s).
 	 */
 	while (usa_count--) {
 		if (*data_pos != usn) {
+			struct mft_record *m = (struct mft_record *)b;
+
+			pr_err_ratelimited("ntfs: Incomplete multi sector transfer detected! (Record magic : 0x%x, mft number : 0x%x, base mft number : 0x%lx, mft in use : %d, data : 0x%x, usn 0x%x)\n",
+					le32_to_cpu(m->magic), le32_to_cpu(m->mft_record_number),
+					MREF_LE(m->base_mft_record), m->flags & MFT_RECORD_IN_USE,
+					*data_pos, usn);
 			/*
 			 * Incomplete multi sector transfer detected! )-:
 			 * Set the magic to "BAAD" and return failure.
@@ -67,11 +74,11 @@ int post_read_mst_fixup(NTFS_RECORD *b, const u32 size)
 			b->magic = magic_BAAD;
 			return -EINVAL;
 		}
-		data_pos += NTFS_BLOCK_SIZE/sizeof(u16);
+		data_pos += NTFS_BLOCK_SIZE / sizeof(u16);
 	}
 	/* Re-setup the variables. */
 	usa_count = le16_to_cpu(b->usa_count) - 1;
-	data_pos = (u16*)b + NTFS_BLOCK_SIZE/sizeof(u16) - 1;
+	data_pos = (u16 *)b + NTFS_BLOCK_SIZE / sizeof(u16) - 1;
 	/* Fixup all sectors. */
 	while (usa_count--) {
 		/*
@@ -106,28 +113,27 @@ int post_read_mst_fixup(NTFS_RECORD *b, const u32 size)
  * otherwise a random word will be used (whatever was in the record at that
  * position at that time).
  */
-int pre_write_mst_fixup(NTFS_RECORD *b, const u32 size)
+int pre_write_mst_fixup(struct ntfs_record *b, const u32 size)
 {
-	le16 *usa_pos, *data_pos;
+	__le16 *usa_pos, *data_pos;
 	u16 usa_ofs, usa_count, usn;
-	le16 le_usn;
+	__le16 le_usn;
 
 	/* Sanity check + only fixup if it makes sense. */
 	if (!b || ntfs_is_baad_record(b->magic) ||
-			ntfs_is_hole_record(b->magic))
+	    ntfs_is_hole_record(b->magic))
 		return -EINVAL;
 	/* Setup the variables. */
 	usa_ofs = le16_to_cpu(b->usa_ofs);
 	/* Decrement usa_count to get number of fixups. */
 	usa_count = le16_to_cpu(b->usa_count) - 1;
 	/* Size and alignment checks. */
-	if ( size & (NTFS_BLOCK_SIZE - 1)	||
-	     usa_ofs & 1			||
-	     usa_ofs + (usa_count * 2) > size	||
-	     (size >> NTFS_BLOCK_SIZE_BITS) != usa_count)
+	if (size & (NTFS_BLOCK_SIZE - 1) || usa_ofs & 1	||
+	    usa_ofs + (usa_count * 2) > size ||
+	    (size >> NTFS_BLOCK_SIZE_BITS) != usa_count)
 		return -EINVAL;
 	/* Position of usn in update sequence array. */
-	usa_pos = (le16*)((u8*)b + usa_ofs);
+	usa_pos = (__le16 *)((u8 *)b + usa_ofs);
 	/*
 	 * Cyclically increment the update sequence number
 	 * (skipping 0 and -1, i.e. 0xffff).
@@ -138,7 +144,7 @@ int pre_write_mst_fixup(NTFS_RECORD *b, const u32 size)
 	le_usn = cpu_to_le16(usn);
 	*usa_pos = le_usn;
 	/* Position in data of first u16 that needs fixing up. */
-	data_pos = (le16*)b + NTFS_BLOCK_SIZE/sizeof(le16) - 1;
+	data_pos = (__le16 *)b + NTFS_BLOCK_SIZE/sizeof(__le16) - 1;
 	/* Fixup all sectors. */
 	while (usa_count--) {
 		/*
@@ -149,7 +155,7 @@ int pre_write_mst_fixup(NTFS_RECORD *b, const u32 size)
 		/* Apply fixup to data. */
 		*data_pos = le_usn;
 		/* Increment position in data as well. */
-		data_pos += NTFS_BLOCK_SIZE/sizeof(le16);
+		data_pos += NTFS_BLOCK_SIZE / sizeof(__le16);
 	}
 	return 0;
 }
@@ -162,18 +168,18 @@ int pre_write_mst_fixup(NTFS_RECORD *b, const u32 size)
  * for any errors, because we assume we have just used pre_write_mst_fixup(),
  * thus the data will be fine or we would never have gotten here.
  */
-void post_write_mst_fixup(NTFS_RECORD *b)
+void post_write_mst_fixup(struct ntfs_record *b)
 {
-	le16 *usa_pos, *data_pos;
+	__le16 *usa_pos, *data_pos;
 
 	u16 usa_ofs = le16_to_cpu(b->usa_ofs);
 	u16 usa_count = le16_to_cpu(b->usa_count) - 1;
 
 	/* Position of usn in update sequence array. */
-	usa_pos = (le16*)b + usa_ofs/sizeof(le16);
+	usa_pos = (__le16 *)b + usa_ofs/sizeof(__le16);
 
 	/* Position in protected data of first u16 that needs fixing up. */
-	data_pos = (le16*)b + NTFS_BLOCK_SIZE/sizeof(le16) - 1;
+	data_pos = (__le16 *)b + NTFS_BLOCK_SIZE/sizeof(__le16) - 1;
 
 	/* Fixup all sectors. */
 	while (usa_count--) {
@@ -184,6 +190,6 @@ void post_write_mst_fixup(NTFS_RECORD *b)
 		*data_pos = *(++usa_pos);
 
 		/* Increment position in data as well. */
-		data_pos += NTFS_BLOCK_SIZE/sizeof(le16);
+		data_pos += NTFS_BLOCK_SIZE/sizeof(__le16);
 	}
 }
diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
index d7498ddc4a72..c69eac30e3cf 100644
--- a/fs/ntfs/namei.c
+++ b/fs/ntfs/namei.c
@@ -1,21 +1,102 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * namei.c - NTFS kernel directory inode operations. Part of the Linux-NTFS
- *	     project.
+ * NTFS kernel directory inode operations.
+ * Part of the Linux-NTFS project.
  *
  * Copyright (c) 2001-2006 Anton Altaparmakov
+ * Copyright (c) 2025 LG Electronics Co., Ltd.
  */
 
-#include <linux/dcache.h>
 #include <linux/exportfs.h>
-#include <linux/security.h>
-#include <linux/slab.h>
+#include <linux/iversion.h>
 
-#include "attrib.h"
-#include "debug.h"
-#include "dir.h"
-#include "mft.h"
 #include "ntfs.h"
+#include "malloc.h"
+#include "time.h"
+#include "index.h"
+#include "reparse.h"
+#include "ea.h"
+
+static const __le16 aux_name_le[3] = {
+	cpu_to_le16('A'), cpu_to_le16('U'), cpu_to_le16('X')
+};
+
+static const __le16 con_name_le[3] = {
+	cpu_to_le16('C'), cpu_to_le16('O'), cpu_to_le16('N')
+};
+
+static const __le16 com_name_le[3] = {
+	cpu_to_le16('C'), cpu_to_le16('O'), cpu_to_le16('M')
+};
+
+static const __le16 lpt_name_le[3] = {
+	cpu_to_le16('L'), cpu_to_le16('P'), cpu_to_le16('T')
+};
+
+static const __le16 nul_name_le[3] = {
+	cpu_to_le16('N'), cpu_to_le16('U'), cpu_to_le16('L')
+};
+
+static const __le16 prn_name_le[3] = {
+	cpu_to_le16('P'), cpu_to_le16('R'), cpu_to_le16('N')
+};
+
+static inline int ntfs_check_bad_char(const unsigned short *wc,
+		unsigned int wc_len)
+{
+	int i;
+
+	for (i = 0; i < wc_len; i++) {
+		if ((wc[i] < 0x0020) ||
+		    (wc[i] == 0x0022) || (wc[i] == 0x002A) || (wc[i] == 0x002F) ||
+		    (wc[i] == 0x003A) || (wc[i] == 0x003C) || (wc[i] == 0x003E) ||
+		    (wc[i] == 0x003F) || (wc[i] == 0x005C) || (wc[i] == 0x007C))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ntfs_check_bad_windows_name(struct ntfs_volume *vol,
+				       const unsigned short *wc,
+				       unsigned int wc_len)
+{
+	if (ntfs_check_bad_char(wc, wc_len))
+		return -EINVAL;
+
+	if (!NVolCheckWindowsNames(vol))
+		return 0;
+
+	/* Check for trailing space or dot. */
+	if (wc_len > 0 &&
+	    (wc[wc_len - 1] == cpu_to_le16(' ') ||
+	    wc[wc_len - 1] == cpu_to_le16('.')))
+		return -EINVAL;
+
+	if (wc_len == 3 || (wc_len > 3 && wc[3] == cpu_to_le16('.'))) {
+		__le16 *upcase = vol->upcase;
+		u32 size = vol->upcase_len;
+
+		if (ntfs_are_names_equal(wc, 3, aux_name_le, 3, IGNORE_CASE, upcase, size) ||
+		    ntfs_are_names_equal(wc, 3, con_name_le, 3, IGNORE_CASE, upcase, size) ||
+		    ntfs_are_names_equal(wc, 3, nul_name_le, 3, IGNORE_CASE, upcase, size) ||
+		    ntfs_are_names_equal(wc, 3, prn_name_le, 3, IGNORE_CASE, upcase, size))
+			return -EINVAL;
+	}
+
+	if (wc_len == 4 || (wc_len > 4 && wc[4] == cpu_to_le16('.'))) {
+		__le16 *upcase = vol->upcase;
+		u32 size = vol->upcase_len, port;
+
+		if (ntfs_are_names_equal(wc, 3, com_name_le, 3, IGNORE_CASE, upcase, size) ||
+		    ntfs_are_names_equal(wc, 3, lpt_name_le, 3, IGNORE_CASE, upcase, size)) {
+			port = le16_to_cpu(wc[3]);
+			if (port >= '1' && port <= '9')
+				return -EINVAL;
+		}
+	}
+	return 0;
+}
 
 /**
  * ntfs_lookup - find the inode represented by a dentry in a directory inode
@@ -89,11 +170,11 @@
 static struct dentry *ntfs_lookup(struct inode *dir_ino, struct dentry *dent,
 		unsigned int flags)
 {
-	ntfs_volume *vol = NTFS_SB(dir_ino->i_sb);
+	struct ntfs_volume *vol = NTFS_SB(dir_ino->i_sb);
 	struct inode *dent_inode;
-	ntfschar *uname;
-	ntfs_name *name = NULL;
-	MFT_REF mref;
+	__le16 *uname;
+	struct ntfs_name *name = NULL;
+	u64 mref;
 	unsigned long dent_ino;
 	int uname_len;
 
@@ -101,15 +182,16 @@ static struct dentry *ntfs_lookup(struct inode *dir_ino, struct dentry *dent,
 			dent, dir_ino->i_ino);
 	/* Convert the name of the dentry to Unicode. */
 	uname_len = ntfs_nlstoucs(vol, dent->d_name.name, dent->d_name.len,
-			&uname);
+				  &uname, NTFS_MAX_NAME_LEN);
 	if (uname_len < 0) {
 		if (uname_len != -ENAMETOOLONG)
-			ntfs_error(vol->sb, "Failed to convert name to "
-					"Unicode.");
+			ntfs_debug("Failed to convert name to Unicode.");
 		return ERR_PTR(uname_len);
 	}
+	mutex_lock(&NTFS_I(dir_ino)->mrec_lock);
 	mref = ntfs_lookup_inode_by_name(NTFS_I(dir_ino), uname, uname_len,
 			&name);
+	mutex_unlock(&NTFS_I(dir_ino)->mrec_lock);
 	kmem_cache_free(ntfs_name_cache, uname);
 	if (!IS_ERR_MREF(mref)) {
 		dent_ino = MREF(mref);
@@ -117,9 +199,8 @@ static struct dentry *ntfs_lookup(struct inode *dir_ino, struct dentry *dent,
 		dent_inode = ntfs_iget(vol->sb, dent_ino);
 		if (!IS_ERR(dent_inode)) {
 			/* Consistency check. */
-			if (is_bad_inode(dent_inode) || MSEQNO(mref) ==
-					NTFS_I(dent_inode)->seq_no ||
-					dent_ino == FILE_MFT) {
+			if (MSEQNO(mref) == NTFS_I(dent_inode)->seq_no ||
+			    dent_ino == FILE_MFT) {
 				/* Perfect WIN32/POSIX match. -- Case 1. */
 				if (!name) {
 					ntfs_debug("Done.  (Case 1.)");
@@ -131,22 +212,20 @@ static struct dentry *ntfs_lookup(struct inode *dir_ino, struct dentry *dent,
 				 */
 				goto handle_name;
 			}
-			ntfs_error(vol->sb, "Found stale reference to inode "
-					"0x%lx (reference sequence number = "
-					"0x%x, inode sequence number = 0x%x), "
-					"returning -EIO. Run chkdsk.",
-					dent_ino, MSEQNO(mref),
-					NTFS_I(dent_inode)->seq_no);
+			ntfs_error(vol->sb,
+				"Found stale reference to inode 0x%lx (reference sequence number = 0x%x, inode sequence number = 0x%x), returning -EIO. Run chkdsk.",
+				dent_ino, MSEQNO(mref),
+				NTFS_I(dent_inode)->seq_no);
 			iput(dent_inode);
 			dent_inode = ERR_PTR(-EIO);
 		} else
-			ntfs_error(vol->sb, "ntfs_iget(0x%lx) failed with "
-					"error code %li.", dent_ino,
-					PTR_ERR(dent_inode));
+			ntfs_error(vol->sb, "ntfs_iget(0x%lx) failed with error code %li.",
+					dent_ino, PTR_ERR(dent_inode));
 		kfree(name);
 		/* Return the error code. */
 		return ERR_CAST(dent_inode);
 	}
+	kfree(name);
 	/* It is guaranteed that @name is no longer allocated at this point. */
 	if (MREF_ERR(mref) == -ENOENT) {
 		ntfs_debug("Entry was not found, adding negative dentry.");
@@ -155,115 +234,1348 @@ static struct dentry *ntfs_lookup(struct inode *dir_ino, struct dentry *dent,
 		ntfs_debug("Done.");
 		return NULL;
 	}
-	ntfs_error(vol->sb, "ntfs_lookup_ino_by_name() failed with error "
-			"code %i.", -MREF_ERR(mref));
+	ntfs_error(vol->sb, "ntfs_lookup_ino_by_name() failed with error code %i.",
+			-MREF_ERR(mref));
 	return ERR_PTR(MREF_ERR(mref));
-	// TODO: Consider moving this lot to a separate function! (AIA)
 handle_name:
-   {
-	MFT_RECORD *m;
-	ntfs_attr_search_ctx *ctx;
-	ntfs_inode *ni = NTFS_I(dent_inode);
-	int err;
-	struct qstr nls_name;
-
-	nls_name.name = NULL;
-	if (name->type != FILE_NAME_DOS) {			/* Case 2. */
-		ntfs_debug("Case 2.");
-		nls_name.len = (unsigned)ntfs_ucstonls(vol,
-				(ntfschar*)&name->name, name->len,
-				(unsigned char**)&nls_name.name, 0);
-		kfree(name);
-	} else /* if (name->type == FILE_NAME_DOS) */ {		/* Case 3. */
-		FILE_NAME_ATTR *fn;
+	{
+		struct mft_record *m;
+		struct ntfs_attr_search_ctx *ctx;
+		struct ntfs_inode *ni = NTFS_I(dent_inode);
+		int err;
+		struct qstr nls_name;
 
-		ntfs_debug("Case 3.");
-		kfree(name);
+		nls_name.name = NULL;
+		if (name->type != FILE_NAME_DOS) {			/* Case 2. */
+			ntfs_debug("Case 2.");
+			nls_name.len = (unsigned int)ntfs_ucstonls(vol,
+					(__le16 *)&name->name, name->len,
+					(unsigned char **)&nls_name.name, 0);
+			kfree(name);
+		} else /* if (name->type == FILE_NAME_DOS) */ {		/* Case 3. */
+			struct file_name_attr *fn;
+
+			ntfs_debug("Case 3.");
+			kfree(name);
+
+			/* Find the WIN32 name corresponding to the matched DOS name. */
+			ni = NTFS_I(dent_inode);
+			m = map_mft_record(ni);
+			if (IS_ERR(m)) {
+				err = PTR_ERR(m);
+				m = NULL;
+				ctx = NULL;
+				goto err_out;
+			}
+			ctx = ntfs_attr_get_search_ctx(ni, m);
+			if (unlikely(!ctx)) {
+				err = -ENOMEM;
+				goto err_out;
+			}
+			do {
+				struct attr_record *a;
+				u32 val_len;
 
-		/* Find the WIN32 name corresponding to the matched DOS name. */
-		ni = NTFS_I(dent_inode);
-		m = map_mft_record(ni);
-		if (IS_ERR(m)) {
-			err = PTR_ERR(m);
-			m = NULL;
-			ctx = NULL;
+				err = ntfs_attr_lookup(AT_FILE_NAME, NULL, 0, 0, 0,
+						NULL, 0, ctx);
+				if (unlikely(err)) {
+					ntfs_error(vol->sb,
+						"Inode corrupt: No WIN32 namespace counterpart to DOS file name. Run chkdsk.");
+					if (err == -ENOENT)
+						err = -EIO;
+					goto err_out;
+				}
+				/* Consistency checks. */
+				a = ctx->attr;
+				if (a->non_resident || a->flags)
+					goto eio_err_out;
+				val_len = le32_to_cpu(a->data.resident.value_length);
+				if (le16_to_cpu(a->data.resident.value_offset) +
+						val_len > le32_to_cpu(a->length))
+					goto eio_err_out;
+				fn = (struct file_name_attr *)((u8 *)ctx->attr + le16_to_cpu(
+							ctx->attr->data.resident.value_offset));
+				if ((u32)(fn->file_name_length * sizeof(__le16) +
+							sizeof(struct file_name_attr)) > val_len)
+					goto eio_err_out;
+			} while (fn->file_name_type != FILE_NAME_WIN32);
+
+			/* Convert the found WIN32 name to current NLS code page. */
+			nls_name.len = (unsigned int)ntfs_ucstonls(vol,
+					(__le16 *)&fn->file_name, fn->file_name_length,
+					(unsigned char **)&nls_name.name, 0);
+
+			ntfs_attr_put_search_ctx(ctx);
+			unmap_mft_record(ni);
+		}
+		m = NULL;
+		ctx = NULL;
+
+		/* Check if a conversion error occurred. */
+		if ((int)nls_name.len < 0) {
+			err = (int)nls_name.len;
 			goto err_out;
 		}
-		ctx = ntfs_attr_get_search_ctx(ni, m);
-		if (unlikely(!ctx)) {
+		nls_name.hash = full_name_hash(dent, nls_name.name, nls_name.len);
+
+		dent = d_add_ci(dent, dent_inode, &nls_name);
+		kfree(nls_name.name);
+		return dent;
+
+eio_err_out:
+		ntfs_error(vol->sb, "Illegal file name attribute. Run chkdsk.");
+		err = -EIO;
+err_out:
+		if (ctx)
+			ntfs_attr_put_search_ctx(ctx);
+		if (m)
+			unmap_mft_record(ni);
+		iput(dent_inode);
+		ntfs_error(vol->sb, "Failed, returning error code %i.", err);
+		return ERR_PTR(err);
+	}
+}
+
+static int ntfs_sd_add_everyone(struct ntfs_inode *ni)
+{
+	struct security_descriptor_relative *sd;
+	struct ntfs_acl *acl;
+	struct ntfs_ace *ace;
+	struct ntfs_sid *sid;
+	int ret, sd_len;
+
+	/* Create SECURITY_DESCRIPTOR attribute (everyone has full access). */
+	/*
+	 * Calculate security descriptor length. We have 2 sub-authorities in
+	 * owner and group SIDs, So add 8 bytes to every SID.
+	 */
+	sd_len = sizeof(struct security_descriptor_relative) + 2 *
+		(sizeof(struct ntfs_sid) + 8) + sizeof(struct ntfs_acl) +
+		sizeof(struct ntfs_ace) + 4;
+	sd = ntfs_malloc_nofs(sd_len);
+	if (!sd)
+		return -1;
+
+	sd->revision = 1;
+	sd->control = SE_DACL_PRESENT | SE_SELF_RELATIVE;
+
+	sid = (struct ntfs_sid *)((u8 *)sd + sizeof(struct security_descriptor_relative));
+	sid->revision = 1;
+	sid->sub_authority_count = 2;
+	sid->sub_authority[0] = cpu_to_le32(SECURITY_BUILTIN_DOMAIN_RID);
+	sid->sub_authority[1] = cpu_to_le32(DOMAIN_ALIAS_RID_ADMINS);
+	sid->identifier_authority.value[5] = 5;
+	sd->owner = cpu_to_le32((u8 *)sid - (u8 *)sd);
+
+	sid = (struct ntfs_sid *)((u8 *)sid + sizeof(struct ntfs_sid) + 8);
+	sid->revision = 1;
+	sid->sub_authority_count = 2;
+	sid->sub_authority[0] = cpu_to_le32(SECURITY_BUILTIN_DOMAIN_RID);
+	sid->sub_authority[1] = cpu_to_le32(DOMAIN_ALIAS_RID_ADMINS);
+	sid->identifier_authority.value[5] = 5;
+	sd->group = cpu_to_le32((u8 *)sid - (u8 *)sd);
+
+	acl = (struct ntfs_acl *)((u8 *)sid + sizeof(struct ntfs_sid) + 8);
+	acl->revision = 2;
+	acl->size = cpu_to_le16(sizeof(struct ntfs_acl) + sizeof(struct ntfs_ace) + 4);
+	acl->ace_count = cpu_to_le16(1);
+	sd->dacl = cpu_to_le32((u8 *)acl - (u8 *)sd);
+
+	ace = (struct ntfs_ace *)((u8 *)acl + sizeof(struct ntfs_acl));
+	ace->type = ACCESS_ALLOWED_ACE_TYPE;
+	ace->flags = OBJECT_INHERIT_ACE | CONTAINER_INHERIT_ACE;
+	ace->size = cpu_to_le16(sizeof(struct ntfs_ace) + 4);
+	ace->mask = cpu_to_le32(0x1f01ff);
+	ace->sid.revision = 1;
+	ace->sid.sub_authority_count = 1;
+	ace->sid.sub_authority[0] = 0;
+	ace->sid.identifier_authority.value[5] = 1;
+
+	ret = ntfs_attr_add(ni, AT_SECURITY_DESCRIPTOR, AT_UNNAMED, 0, (u8 *)sd,
+			sd_len);
+	if (ret)
+		ntfs_error(ni->vol->sb, "Failed to add SECURITY_DESCRIPTOR\n");
+
+	ntfs_free(sd);
+	return ret;
+}
+
+static struct ntfs_inode *__ntfs_create(struct mnt_idmap *idmap, struct inode *dir,
+		__le16 *name, u8 name_len, mode_t mode, dev_t dev,
+		__le16 *target, int target_len)
+{
+	struct ntfs_inode *dir_ni = NTFS_I(dir);
+	struct ntfs_volume *vol = dir_ni->vol;
+	struct ntfs_inode *ni;
+	bool rollback_data = false, rollback_sd = false, rollback_reparse = false;
+	struct file_name_attr *fn = NULL;
+	struct standard_information *si = NULL;
+	int err = 0, fn_len, si_len;
+	struct inode *vi;
+	struct mft_record *ni_mrec, *dni_mrec;
+	struct super_block *sb = dir_ni->vol->sb;
+	__le64 parent_mft_ref;
+	u64 child_mft_ref;
+	__le16 ea_size;
+
+	vi = new_inode(vol->sb);
+	if (!vi)
+		return ERR_PTR(-ENOMEM);
+
+	ntfs_init_big_inode(vi);
+	ni = NTFS_I(vi);
+	ni->vol = dir_ni->vol;
+	ni->name_len = 0;
+	ni->name = NULL;
+
+	/*
+	 * Set the appropriate mode, attribute type, and name.  For
+	 * directories, also setup the index values to the defaults.
+	 */
+	if (S_ISDIR(mode)) {
+		mode &= ~vol->dmask;
+
+		NInoSetMstProtected(ni);
+		ni->itype.index.block_size = 4096;
+		ni->itype.index.block_size_bits = ntfs_ffs(4096) - 1;
+		ni->itype.index.collation_rule = COLLATION_FILE_NAME;
+		if (vol->cluster_size <= ni->itype.index.block_size) {
+			ni->itype.index.vcn_size = vol->cluster_size;
+			ni->itype.index.vcn_size_bits =
+				vol->cluster_size_bits;
+		} else {
+			ni->itype.index.vcn_size = vol->sector_size;
+			ni->itype.index.vcn_size_bits =
+				vol->sector_size_bits;
+		}
+	} else {
+		mode &= ~vol->fmask;
+	}
+
+	if (IS_RDONLY(vi))
+		mode &= ~0222;
+
+	inode_init_owner(idmap, vi, dir, mode);
+
+	if (uid_valid(vol->uid))
+		vi->i_uid = vol->uid;
+
+	if (gid_valid(vol->gid))
+		vi->i_gid = vol->gid;
+
+	/*
+	 * Set the file size to 0, the ntfs inode sizes are set to 0 by
+	 * the call to ntfs_init_big_inode() below.
+	 */
+	vi->i_size = 0;
+	vi->i_blocks = 0;
+
+	inode_inc_iversion(vi);
+
+	simple_inode_init_ts(vi);
+	ni->i_crtime = inode_get_ctime(vi);
+
+	inode_set_mtime_to_ts(dir, ni->i_crtime);
+	inode_set_ctime_to_ts(dir, ni->i_crtime);
+	mark_inode_dirty(dir);
+
+	err = ntfs_mft_record_alloc(dir_ni->vol, mode, &ni, NULL,
+				    &ni_mrec);
+	if (err) {
+		iput(vi);
+		return ERR_PTR(err);
+	}
+
+	/*
+	 * Prevent iget and writeback from finding this inode.
+	 * Caller must call d_instantiate_new instead of d_instantiate.
+	 */
+	spin_lock(&vi->i_lock);
+	inode_state_set(vi, I_NEW | I_CREATING);
+	spin_unlock(&vi->i_lock);
+
+	/* Add the inode to the inode hash for the superblock. */
+	vi->i_ino = ni->mft_no;
+	inode_set_iversion(vi, 1);
+	insert_inode_hash(vi);
+
+	mutex_lock_nested(&ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL);
+	mutex_lock_nested(&dir_ni->mrec_lock, NTFS_INODE_MUTEX_PARENT);
+	if (NInoBeingDeleted(dir_ni)) {
+		err = -ENOENT;
+		goto err_out;
+	}
+
+	dni_mrec = map_mft_record(dir_ni);
+	if (IS_ERR(dni_mrec)) {
+		ntfs_error(dir_ni->vol->sb, "failed to map mft record for file %ld.\n",
+			   dir_ni->mft_no);
+		err = -EIO;
+		goto err_out;
+	}
+	parent_mft_ref = MK_LE_MREF(dir_ni->mft_no,
+				    le16_to_cpu(dni_mrec->sequence_number));
+	unmap_mft_record(dir_ni);
+
+	/*
+	 * Create STANDARD_INFORMATION attribute. Write STANDARD_INFORMATION
+	 * version 1.2, windows will upgrade it to version 3 if needed.
+	 */
+	si_len = offsetof(struct standard_information, file_attributes) +
+		sizeof(__le32) + 12;
+	si = ntfs_malloc_nofs(si_len);
+	if (!si) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	si->creation_time = si->last_data_change_time = utc2ntfs(ni->i_crtime);
+	si->last_mft_change_time = si->last_access_time = si->creation_time;
+
+	if (!S_ISREG(mode) && !S_ISDIR(mode))
+		si->file_attributes = FILE_ATTR_SYSTEM;
+
+	/* Add STANDARD_INFORMATION to inode. */
+	err = ntfs_attr_add(ni, AT_STANDARD_INFORMATION, AT_UNNAMED, 0, (u8 *)si,
+			si_len);
+	if (err) {
+		ntfs_error(sb, "Failed to add STANDARD_INFORMATION attribute.\n");
+		goto err_out;
+	}
+
+	err = ntfs_sd_add_everyone(ni);
+	if (err)
+		goto err_out;
+	rollback_sd = true;
+
+	if (S_ISDIR(mode)) {
+		struct index_root *ir = NULL;
+		struct index_entry *ie;
+		int ir_len, index_len;
+
+		/* Create struct index_root attribute. */
+		index_len = sizeof(struct index_header) + sizeof(struct index_entry_header);
+		ir_len = offsetof(struct index_root, index) + index_len;
+		ir = ntfs_malloc_nofs(ir_len);
+		if (!ir) {
 			err = -ENOMEM;
 			goto err_out;
 		}
-		do {
-			ATTR_RECORD *a;
-			u32 val_len;
-
-			err = ntfs_attr_lookup(AT_FILE_NAME, NULL, 0, 0, 0,
-					NULL, 0, ctx);
-			if (unlikely(err)) {
-				ntfs_error(vol->sb, "Inode corrupt: No WIN32 "
-						"namespace counterpart to DOS "
-						"file name. Run chkdsk.");
-				if (err == -ENOENT)
-					err = -EIO;
-				goto err_out;
+		ir->type = AT_FILE_NAME;
+		ir->collation_rule = COLLATION_FILE_NAME;
+		ir->index_block_size = cpu_to_le32(ni->vol->index_record_size);
+		if (ni->vol->cluster_size <= ni->vol->index_record_size)
+			ir->clusters_per_index_block =
+				NTFS_B_TO_CLU(vol, ni->vol->index_record_size);
+		else
+			ir->clusters_per_index_block =
+				ni->vol->index_record_size >> ni->vol->sector_size_bits;
+		ir->index.entries_offset = cpu_to_le32(sizeof(struct index_header));
+		ir->index.index_length = cpu_to_le32(index_len);
+		ir->index.allocated_size = cpu_to_le32(index_len);
+		ie = (struct index_entry *)((u8 *)ir + sizeof(struct index_root));
+		ie->length = cpu_to_le16(sizeof(struct index_entry_header));
+		ie->key_length = 0;
+		ie->flags = INDEX_ENTRY_END;
+
+		/* Add struct index_root attribute to inode. */
+		err = ntfs_attr_add(ni, AT_INDEX_ROOT, I30, 4, (u8 *)ir, ir_len);
+		if (err) {
+			ntfs_free(ir);
+			ntfs_error(vi->i_sb, "Failed to add struct index_root attribute.\n");
+			goto err_out;
+		}
+		ntfs_free(ir);
+		err = ntfs_attr_open(ni, AT_INDEX_ROOT, I30, 4);
+		if (err)
+			goto err_out;
+	} else {
+		/* Add DATA attribute to inode. */
+		err = ntfs_attr_add(ni, AT_DATA, AT_UNNAMED, 0, NULL, 0);
+		if (err) {
+			ntfs_error(dir_ni->vol->sb, "Failed to add DATA attribute.\n");
+			goto err_out;
+		}
+		rollback_data = true;
+
+		err = ntfs_attr_open(ni, AT_DATA, AT_UNNAMED, 0);
+		if (err)
+			goto err_out;
+
+		if (S_ISLNK(mode)) {
+			err = ntfs_reparse_set_wsl_symlink(ni, target, target_len);
+			if (!err)
+				rollback_reparse = true;
+		} else if (S_ISBLK(mode) || S_ISCHR(mode) || S_ISSOCK(mode) ||
+			   S_ISFIFO(mode)) {
+			si->file_attributes = FILE_ATTRIBUTE_RECALL_ON_OPEN;
+			ni->flags = FILE_ATTRIBUTE_RECALL_ON_OPEN;
+			err = ntfs_reparse_set_wsl_not_symlink(ni, mode);
+			if (!err)
+				rollback_reparse = true;
+		}
+		if (err)
+			goto err_out;
+	}
+
+	err = ntfs_ea_set_wsl_inode(vi, dev, &ea_size,
+			NTFS_EA_UID | NTFS_EA_GID | NTFS_EA_MODE);
+	if (err)
+		goto err_out;
+
+	/* Create FILE_NAME attribute. */
+	fn_len = sizeof(struct file_name_attr) + name_len * sizeof(__le16);
+	fn = ntfs_malloc_nofs(fn_len);
+	if (!fn) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	fn->file_attributes |= ni->flags;
+	fn->parent_directory = parent_mft_ref;
+	fn->file_name_length = name_len;
+	fn->file_name_type = FILE_NAME_POSIX;
+	fn->type.ea.packed_ea_size = ea_size;
+	if (S_ISDIR(mode)) {
+		fn->file_attributes = FILE_ATTR_DUP_FILE_NAME_INDEX_PRESENT;
+		fn->allocated_size = fn->data_size = 0;
+	} else {
+		fn->data_size = cpu_to_le64(ni->data_size);
+		fn->allocated_size = cpu_to_le64(ni->allocated_size);
+	}
+	if (!S_ISREG(mode) && !S_ISDIR(mode)) {
+		fn->file_attributes = FILE_ATTR_SYSTEM;
+		if (rollback_reparse)
+			fn->file_attributes |= FILE_ATTR_REPARSE_POINT;
+	}
+	if (NVolHideDotFiles(vol) && (name_len > 0 && name[0] == '.'))
+		fn->file_attributes |= FILE_ATTR_HIDDEN;
+	fn->creation_time = fn->last_data_change_time = utc2ntfs(ni->i_crtime);
+	fn->last_mft_change_time = fn->last_access_time = fn->creation_time;
+	memcpy(fn->file_name, name, name_len * sizeof(__le16));
+
+	/* Add FILE_NAME attribute to inode. */
+	err = ntfs_attr_add(ni, AT_FILE_NAME, AT_UNNAMED, 0, (u8 *)fn, fn_len);
+	if (err) {
+		ntfs_error(sb, "Failed to add FILE_NAME attribute.\n");
+		goto err_out;
+	}
+
+	child_mft_ref = MK_MREF(ni->mft_no,
+				le16_to_cpu(ni_mrec->sequence_number));
+	/* Set hard links count and directory flag. */
+	ni_mrec->link_count = cpu_to_le16(1);
+	mark_mft_record_dirty(ni);
+
+	/* Add FILE_NAME attribute to index. */
+	err = ntfs_index_add_filename(dir_ni, fn, child_mft_ref);
+	if (err) {
+		ntfs_debug("Failed to add entry to the index");
+		goto err_out;
+	}
+
+	unmap_mft_record(ni);
+	mutex_unlock(&dir_ni->mrec_lock);
+	mutex_unlock(&ni->mrec_lock);
+
+	ni->flags = fn->file_attributes;
+	/* Set the sequence number. */
+	vi->i_generation = ni->seq_no;
+	set_nlink(vi, 1);
+	ntfs_set_vfs_operations(vi, mode, dev);
+
+#ifdef CONFIG_NTFS_FS_POSIX_ACL
+	if (!S_ISLNK(mode) && (sb->s_flags & SB_POSIXACL)) {
+		err = ntfs_init_acl(idmap, vi, dir);
+		if (err)
+			goto err_out;
+	} else
+#endif
+	{
+		vi->i_flags |= S_NOSEC;
+	}
+
+	/* Done! */
+	ntfs_free(fn);
+	ntfs_free(si);
+	ntfs_debug("Done.\n");
+	return ni;
+
+err_out:
+	if (rollback_sd)
+		ntfs_attr_remove(ni, AT_SECURITY_DESCRIPTOR, AT_UNNAMED, 0);
+
+	if (rollback_data)
+		ntfs_attr_remove(ni, AT_DATA, AT_UNNAMED, 0);
+
+	if (rollback_reparse)
+		ntfs_delete_reparse_index(ni);
+	/*
+	 * Free extent MFT records (should not exist any with current
+	 * ntfs_create implementation, but for any case if something will be
+	 * changed in the future).
+	 */
+	while (ni->nr_extents != 0) {
+		int err2;
+
+		err2 = ntfs_mft_record_free(ni->vol, *(ni->ext.extent_ntfs_inos));
+		if (err2)
+			ntfs_error(sb,
+				"Failed to free extent MFT record. Leaving inconsistent metadata.\n");
+		ntfs_inode_close(*(ni->ext.extent_ntfs_inos));
+	}
+	if (ntfs_mft_record_free(ni->vol, ni))
+		ntfs_error(sb,
+			"Failed to free MFT record. Leaving inconsistent metadata. Run chkdsk.\n");
+	unmap_mft_record(ni);
+	ntfs_free(fn);
+	ntfs_free(si);
+
+	mutex_unlock(&dir_ni->mrec_lock);
+	mutex_unlock(&ni->mrec_lock);
+
+	remove_inode_hash(vi);
+	discard_new_inode(vi);
+	return ERR_PTR(err);
+}
+
+static int ntfs_create(struct mnt_idmap *idmap, struct inode *dir,
+		struct dentry *dentry, umode_t mode, bool excl)
+{
+	struct ntfs_volume *vol = NTFS_SB(dir->i_sb);
+	struct ntfs_inode *ni;
+	__le16 *uname;
+	int uname_len, err;
+
+	if (NVolShutdown(vol))
+		return -EIO;
+
+	uname_len = ntfs_nlstoucs(vol, dentry->d_name.name, dentry->d_name.len,
+				  &uname, NTFS_MAX_NAME_LEN);
+	if (uname_len < 0) {
+		if (uname_len != -ENAMETOOLONG)
+			ntfs_error(vol->sb, "Failed to convert name to unicode.");
+		return uname_len;
+	}
+
+	err = ntfs_check_bad_windows_name(vol, uname, uname_len);
+	if (err) {
+		kmem_cache_free(ntfs_name_cache, uname);
+		return err;
+	}
+
+	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
+		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
+
+	ni = __ntfs_create(idmap, dir, uname, uname_len, S_IFREG | mode, 0, NULL, 0);
+	kmem_cache_free(ntfs_name_cache, uname);
+	if (IS_ERR(ni))
+		return PTR_ERR(ni);
+
+	d_instantiate_new(dentry, VFS_I(ni));
+
+	return 0;
+}
+
+static int ntfs_check_unlinkable_dir(struct ntfs_attr_search_ctx *ctx, struct file_name_attr *fn)
+{
+	int link_count;
+	int ret;
+	struct ntfs_inode *ni = ctx->base_ntfs_ino ? ctx->base_ntfs_ino : ctx->ntfs_ino;
+	struct mft_record *ni_mrec = ctx->base_mrec ? ctx->base_mrec : ctx->mrec;
+
+	ret = ntfs_check_empty_dir(ni, ni_mrec);
+	if (!ret || ret != -ENOTEMPTY)
+		return ret;
+
+	link_count = le16_to_cpu(ni_mrec->link_count);
+	/*
+	 * Directory is non-empty, so we can unlink only if there is more than
+	 * one "real" hard link, i.e. links aren't different DOS and WIN32 names
+	 */
+	if ((link_count == 1) ||
+	    (link_count == 2 && fn->file_name_type == FILE_NAME_DOS)) {
+		ret = -ENOTEMPTY;
+		ntfs_debug("Non-empty directory without hard links\n");
+		goto no_hardlink;
+	}
+
+	ret = 0;
+no_hardlink:
+	return ret;
+}
+
+static int ntfs_test_inode_attr(struct inode *vi, void *data)
+{
+	struct ntfs_inode *ni = NTFS_I(vi);
+	unsigned long mft_no = (unsigned long)data;
+
+	if (ni->mft_no != mft_no)
+		return 0;
+	if (NInoAttr(ni) || ni->nr_extents == -1)
+		return 1;
+	else
+		return 0;
+}
+
+/**
+ * ntfs_delete - delete file or directory from ntfs volume
+ * @ni:         ntfs inode for object to delte
+ * @dir_ni:     ntfs inode for directory in which delete object
+ * @name:       unicode name of the object to delete
+ * @name_len:   length of the name in unicode characters
+ * @need_lock:  whether mrec lock is needed or not
+ *
+ * Delete the specified name from the directory index @dir_ni and decrement
+ * the link count of the target inode @ni.
+ */
+static int ntfs_delete(struct ntfs_inode *ni, struct ntfs_inode *dir_ni,
+		__le16 *name, u8 name_len, bool need_lock)
+{
+	struct ntfs_attr_search_ctx *actx = NULL;
+	struct file_name_attr *fn = NULL;
+	bool looking_for_dos_name = false, looking_for_win32_name = false;
+	bool case_sensitive_match = true;
+	int err = 0;
+	struct mft_record *ni_mrec;
+	struct super_block *sb;
+	bool link_count_zero = false;
+
+	ntfs_debug("Entering.\n");
+
+	if (need_lock == true) {
+		mutex_lock_nested(&ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL);
+		mutex_lock_nested(&dir_ni->mrec_lock, NTFS_INODE_MUTEX_PARENT);
+	}
+
+	sb = dir_ni->vol->sb;
+
+	if (ni->nr_extents == -1)
+		ni = ni->ext.base_ntfs_ino;
+	if (dir_ni->nr_extents == -1)
+		dir_ni = dir_ni->ext.base_ntfs_ino;
+	/*
+	 * Search for FILE_NAME attribute with such name. If it's in POSIX or
+	 * WIN32_AND_DOS namespace, then simply remove it from index and inode.
+	 * If filename in DOS or in WIN32 namespace, then remove DOS name first,
+	 * only then remove WIN32 name.
+	 */
+	actx = ntfs_attr_get_search_ctx(ni, NULL);
+	if (!actx) {
+		ntfs_error(sb, "%s, Failed to get search context", __func__);
+		if (need_lock) {
+			mutex_unlock(&dir_ni->mrec_lock);
+			mutex_unlock(&ni->mrec_lock);
+		}
+		return -ENOMEM;
+	}
+search:
+	while ((err = ntfs_attr_lookup(AT_FILE_NAME, AT_UNNAMED, 0, CASE_SENSITIVE,
+				0, NULL, 0, actx)) == 0) {
+#ifdef DEBUG
+		unsigned char *s;
+#endif
+		bool case_sensitive = IGNORE_CASE;
+
+		fn = (struct file_name_attr *)((u8 *)actx->attr +
+				le16_to_cpu(actx->attr->data.resident.value_offset));
+#ifdef DEBUG
+		s = ntfs_attr_name_get(ni->vol, fn->file_name, fn->file_name_length);
+		ntfs_debug("name: '%s'  type: %d  dos: %d  win32: %d case: %d\n",
+				s, fn->file_name_type,
+				looking_for_dos_name, looking_for_win32_name,
+				case_sensitive_match);
+		ntfs_attr_name_free(&s);
+#endif
+		if (looking_for_dos_name) {
+			if (fn->file_name_type == FILE_NAME_DOS)
+				break;
+			continue;
+		}
+		if (looking_for_win32_name) {
+			if  (fn->file_name_type == FILE_NAME_WIN32)
+				break;
+			continue;
+		}
+
+		/* Ignore hard links from other directories */
+		if (dir_ni->mft_no != MREF_LE(fn->parent_directory)) {
+			ntfs_debug("MFT record numbers don't match (%lu != %lu)\n",
+					dir_ni->mft_no,
+					MREF_LE(fn->parent_directory));
+			continue;
+		}
+
+		if (fn->file_name_type == FILE_NAME_POSIX || case_sensitive_match)
+			case_sensitive = CASE_SENSITIVE;
+
+		if (ntfs_names_are_equal(fn->file_name, fn->file_name_length,
+					name, name_len, case_sensitive,
+					ni->vol->upcase, ni->vol->upcase_len)) {
+			if (fn->file_name_type == FILE_NAME_WIN32) {
+				looking_for_dos_name = true;
+				ntfs_attr_reinit_search_ctx(actx);
+				continue;
 			}
-			/* Consistency checks. */
-			a = ctx->attr;
-			if (a->non_resident || a->flags)
-				goto eio_err_out;
-			val_len = le32_to_cpu(a->data.resident.value_length);
-			if (le16_to_cpu(a->data.resident.value_offset) +
-					val_len > le32_to_cpu(a->length))
-				goto eio_err_out;
-			fn = (FILE_NAME_ATTR*)((u8*)ctx->attr + le16_to_cpu(
-					ctx->attr->data.resident.value_offset));
-			if ((u32)(fn->file_name_length * sizeof(ntfschar) +
-					sizeof(FILE_NAME_ATTR)) > val_len)
-				goto eio_err_out;
-		} while (fn->file_name_type != FILE_NAME_WIN32);
-
-		/* Convert the found WIN32 name to current NLS code page. */
-		nls_name.len = (unsigned)ntfs_ucstonls(vol,
-				(ntfschar*)&fn->file_name, fn->file_name_length,
-				(unsigned char**)&nls_name.name, 0);
+			if (fn->file_name_type == FILE_NAME_DOS)
+				looking_for_dos_name = true;
+			break;
+		}
+	}
+	if (err) {
+		/*
+		 * If case sensitive search failed, then try once again
+		 * ignoring case.
+		 */
+		if (err == -ENOENT && case_sensitive_match) {
+			case_sensitive_match = false;
+			ntfs_attr_reinit_search_ctx(actx);
+			goto search;
+		}
+		goto err_out;
+	}
 
-		ntfs_attr_put_search_ctx(ctx);
-		unmap_mft_record(ni);
+	err = ntfs_check_unlinkable_dir(actx, fn);
+	if (err)
+		goto err_out;
+
+	err = ntfs_index_remove(dir_ni, fn, le32_to_cpu(actx->attr->data.resident.value_length));
+	if (err)
+		goto err_out;
+
+	err = ntfs_attr_record_rm(actx);
+	if (err)
+		goto err_out;
+
+	ni_mrec = actx->base_mrec ? actx->base_mrec : actx->mrec;
+	ni_mrec->link_count = cpu_to_le16(le16_to_cpu(ni_mrec->link_count) - 1);
+	drop_nlink(VFS_I(ni));
+
+	mark_mft_record_dirty(ni);
+	if (looking_for_dos_name) {
+		looking_for_dos_name = false;
+		looking_for_win32_name = true;
+		ntfs_attr_reinit_search_ctx(actx);
+		goto search;
+	}
+
+	/*
+	 * If hard link count is not equal to zero then we are done. In other
+	 * case there are no reference to this inode left, so we should free all
+	 * non-resident attributes and mark all MFT record as not in use.
+	 */
+	if (ni_mrec->link_count == 0) {
+		NInoSetBeingDeleted(ni);
+		ntfs_delete_reparse_index(ni);
+		link_count_zero = true;
+	}
+
+	ntfs_attr_put_search_ctx(actx);
+	if (need_lock == true) {
+		mutex_unlock(&dir_ni->mrec_lock);
+		mutex_unlock(&ni->mrec_lock);
+	}
+
+	/*
+	 * If hard link count is not equal to zero then we are done. In other
+	 * case there are no reference to this inode left, so we should free all
+	 * non-resident attributes and mark all MFT record as not in use.
+	 */
+	if (link_count_zero == true) {
+		struct inode *attr_vi;
+
+		while ((attr_vi = ilookup5(sb, ni->mft_no, ntfs_test_inode_attr,
+					   (void *)ni->mft_no)) != NULL) {
+			clear_nlink(attr_vi);
+			iput(attr_vi);
+		}
+	}
+	ntfs_debug("Done.\n");
+	return 0;
+err_out:
+	ntfs_attr_put_search_ctx(actx);
+	if (need_lock) {
+		mutex_unlock(&dir_ni->mrec_lock);
+		mutex_unlock(&ni->mrec_lock);
 	}
-	m = NULL;
-	ctx = NULL;
+	return err;
+}
+
+static int ntfs_unlink(struct inode *dir, struct dentry *dentry)
+{
+	struct inode *vi = dentry->d_inode;
+	struct super_block *sb = dir->i_sb;
+	struct ntfs_volume *vol = NTFS_SB(sb);
+	int err = 0;
+	struct ntfs_inode *ni = NTFS_I(vi);
+	__le16 *uname = NULL;
+	int uname_len;
 
-	/* Check if a conversion error occurred. */
-	if ((signed)nls_name.len < 0) {
-		err = (signed)nls_name.len;
+	if (NVolShutdown(vol))
+		return -EIO;
+
+	uname_len = ntfs_nlstoucs(vol, dentry->d_name.name, dentry->d_name.len,
+				  &uname, NTFS_MAX_NAME_LEN);
+	if (uname_len < 0) {
+		if (uname_len != -ENAMETOOLONG)
+			ntfs_error(sb, "Failed to convert name to Unicode.");
+		return -ENOMEM;
+	}
+
+	err = ntfs_check_bad_windows_name(vol, uname, uname_len);
+	if (err) {
+		kmem_cache_free(ntfs_name_cache, uname);
+		return err;
+	}
+
+	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
+		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
+
+	err = ntfs_delete(ni, NTFS_I(dir), uname, uname_len, true);
+	if (err)
+		goto out;
+
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
+	mark_inode_dirty(dir);
+	inode_set_ctime_to_ts(vi, inode_get_ctime(dir));
+	if (vi->i_nlink)
+		mark_inode_dirty(vi);
+out:
+	kmem_cache_free(ntfs_name_cache, uname);
+	return err;
+}
+
+static struct dentry *ntfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+		struct dentry *dentry, umode_t mode)
+{
+	struct super_block *sb = dir->i_sb;
+	struct ntfs_volume *vol = NTFS_SB(sb);
+	int err = 0;
+	struct ntfs_inode *ni;
+	__le16 *uname;
+	int uname_len;
+
+	if (NVolShutdown(vol))
+		return ERR_PTR(-EIO);
+
+	uname_len = ntfs_nlstoucs(vol, dentry->d_name.name, dentry->d_name.len,
+				  &uname, NTFS_MAX_NAME_LEN);
+	if (uname_len < 0) {
+		if (uname_len != -ENAMETOOLONG)
+			ntfs_error(sb, "Failed to convert name to unicode.");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	err = ntfs_check_bad_windows_name(vol, uname, uname_len);
+	if (err) {
+		kmem_cache_free(ntfs_name_cache, uname);
+		return ERR_PTR(err);
+	}
+
+	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
+		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
+
+	ni = __ntfs_create(idmap, dir, uname, uname_len, S_IFDIR | mode, 0, NULL, 0);
+	kmem_cache_free(ntfs_name_cache, uname);
+	if (IS_ERR(ni)) {
+		err = PTR_ERR(ni);
+		return ERR_PTR(err);
+	}
+
+	d_instantiate_new(dentry, VFS_I(ni));
+	return ERR_PTR(err);
+}
+
+static int ntfs_rmdir(struct inode *dir, struct dentry *dentry)
+{
+	struct inode *vi = dentry->d_inode;
+	struct super_block *sb = dir->i_sb;
+	struct ntfs_volume *vol = NTFS_SB(sb);
+	int err = 0;
+	struct ntfs_inode *ni;
+	__le16 *uname = NULL;
+	int uname_len;
+
+	if (NVolShutdown(vol))
+		return -EIO;
+
+	ni = NTFS_I(vi);
+	uname_len = ntfs_nlstoucs(vol, dentry->d_name.name, dentry->d_name.len,
+				  &uname, NTFS_MAX_NAME_LEN);
+	if (uname_len < 0) {
+		if (uname_len != -ENAMETOOLONG)
+			ntfs_error(sb, "Failed to convert name to unicode.");
+		return -ENOMEM;
+	}
+
+	err = ntfs_check_bad_windows_name(vol, uname, uname_len);
+	if (err) {
+		kmem_cache_free(ntfs_name_cache, uname);
+		return err;
+	}
+
+	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
+		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
+
+	err = ntfs_delete(ni, NTFS_I(dir), uname, uname_len, true);
+	if (err)
+		goto out;
+
+	inode_set_mtime_to_ts(vi, inode_set_atime_to_ts(vi, current_time(vi)));
+out:
+	kmem_cache_free(ntfs_name_cache, uname);
+	return err;
+}
+
+/**
+ * __ntfs_link - create hard link for file or directory
+ * @ni:		ntfs inode for object to create hard link
+ * @dir_ni:	ntfs inode for directory in which new link should be placed
+ * @name:	unicode name of the new link
+ * @name_len:	length of the name in unicode characters
+ *
+ * Create a new hard link. This involves adding an entry to the directory
+ * index and adding a new FILE_NAME attribute to the target inode.
+ */
+static int __ntfs_link(struct ntfs_inode *ni, struct ntfs_inode *dir_ni,
+		__le16 *name, u8 name_len)
+{
+	struct super_block *sb;
+	struct inode *vi = VFS_I(ni);
+	struct file_name_attr *fn = NULL;
+	int fn_len, err = 0;
+	struct mft_record *dir_mrec = NULL, *ni_mrec = NULL;
+
+	ntfs_debug("Entering.\n");
+
+	sb = dir_ni->vol->sb;
+	if (NInoBeingDeleted(dir_ni) || NInoBeingDeleted(ni))
+		return -ENOENT;
+
+	ni_mrec = map_mft_record(ni);
+	if (IS_ERR(ni_mrec)) {
+		err = -EIO;
+		goto err_out;
+	}
+
+	if (le16_to_cpu(ni_mrec->link_count) == 0) {
+		err = -ENOENT;
 		goto err_out;
 	}
-	nls_name.hash = full_name_hash(dent, nls_name.name, nls_name.len);
 
-	dent = d_add_ci(dent, dent_inode, &nls_name);
-	kfree(nls_name.name);
-	return dent;
+	/* Create FILE_NAME attribute. */
+	fn_len = sizeof(struct file_name_attr) + name_len * sizeof(__le16);
+	fn = ntfs_malloc_nofs(fn_len);
+	if (!fn) {
+		err = -ENOMEM;
+		goto err_out;
+	}
 
-eio_err_out:
-	ntfs_error(vol->sb, "Illegal file name attribute. Run chkdsk.");
-	err = -EIO;
+	dir_mrec = map_mft_record(dir_ni);
+	if (IS_ERR(dir_mrec)) {
+		err = -EIO;
+		goto err_out;
+	}
+
+	fn->parent_directory = MK_LE_MREF(dir_ni->mft_no,
+			le16_to_cpu(dir_mrec->sequence_number));
+	unmap_mft_record(dir_ni);
+	fn->file_name_length = name_len;
+	fn->file_name_type = FILE_NAME_POSIX;
+	fn->file_attributes = ni->flags;
+	if (ni_mrec->flags & MFT_RECORD_IS_DIRECTORY) {
+		fn->file_attributes |= FILE_ATTR_DUP_FILE_NAME_INDEX_PRESENT;
+		fn->allocated_size = fn->data_size = 0;
+	} else {
+		if (NInoSparse(ni) || NInoCompressed(ni))
+			fn->allocated_size =
+				cpu_to_le64(ni->itype.compressed.size);
+		else
+			fn->allocated_size = cpu_to_le64(ni->allocated_size);
+		fn->data_size = cpu_to_le64(ni->data_size);
+	}
+	if (NVolHideDotFiles(dir_ni->vol) && (name_len > 0 && name[0] == '.'))
+		fn->file_attributes |= FILE_ATTR_HIDDEN;
+
+	fn->creation_time = utc2ntfs(ni->i_crtime);
+	fn->last_data_change_time = utc2ntfs(inode_get_mtime(vi));
+	fn->last_mft_change_time = utc2ntfs(inode_get_ctime(vi));
+	fn->last_access_time = utc2ntfs(inode_get_atime(vi));
+	memcpy(fn->file_name, name, name_len * sizeof(__le16));
+
+	/* Add FILE_NAME attribute to index. */
+	err = ntfs_index_add_filename(dir_ni, fn, MK_MREF(ni->mft_no,
+					le16_to_cpu(ni_mrec->sequence_number)));
+	if (err) {
+		ntfs_error(sb, "Failed to add filename to the index");
+		goto err_out;
+	}
+	/* Add FILE_NAME attribute to inode. */
+	err = ntfs_attr_add(ni, AT_FILE_NAME, AT_UNNAMED, 0, (u8 *)fn, fn_len);
+	if (err) {
+		ntfs_error(sb, "Failed to add FILE_NAME attribute.\n");
+		/* Try to remove just added attribute from index. */
+		if (ntfs_index_remove(dir_ni, fn, fn_len))
+			goto rollback_failed;
+		goto err_out;
+	}
+	/* Increment hard links count. */
+	ni_mrec->link_count = cpu_to_le16(le16_to_cpu(ni_mrec->link_count) + 1);
+	inc_nlink(VFS_I(ni));
+
+	/* Done! */
+	mark_mft_record_dirty(ni);
+	ntfs_free(fn);
+	unmap_mft_record(ni);
+
+	ntfs_debug("Done.\n");
+
+	return 0;
+rollback_failed:
+	ntfs_error(sb, "Rollback failed. Leaving inconsistent metadata.\n");
 err_out:
-	if (ctx)
-		ntfs_attr_put_search_ctx(ctx);
-	if (m)
+	ntfs_free(fn);
+	if (!IS_ERR_OR_NULL(ni_mrec))
 		unmap_mft_record(ni);
-	iput(dent_inode);
-	ntfs_error(vol->sb, "Failed, returning error code %i.", err);
-	return ERR_PTR(err);
-   }
+	return err;
 }
 
-/*
+static int ntfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
+		struct dentry *old_dentry, struct inode *new_dir,
+		struct dentry *new_dentry, unsigned int flags)
+{
+	struct inode *old_inode, *new_inode = NULL;
+	int err = 0;
+	int is_dir;
+	struct super_block *sb = old_dir->i_sb;
+	__le16 *uname_new = NULL;
+	__le16 *uname_old = NULL;
+	int new_name_len;
+	int old_name_len;
+	struct ntfs_volume *vol = NTFS_SB(sb);
+	struct ntfs_inode *old_ni, *new_ni = NULL;
+	struct ntfs_inode *old_dir_ni = NTFS_I(old_dir), *new_dir_ni = NTFS_I(new_dir);
+
+	if (NVolShutdown(old_dir_ni->vol))
+		return -EIO;
+
+	if (flags & (RENAME_EXCHANGE | RENAME_WHITEOUT))
+		return -EINVAL;
+
+	new_name_len = ntfs_nlstoucs(NTFS_I(new_dir)->vol, new_dentry->d_name.name,
+				     new_dentry->d_name.len, &uname_new,
+				     NTFS_MAX_NAME_LEN);
+	if (new_name_len < 0) {
+		if (new_name_len != -ENAMETOOLONG)
+			ntfs_error(sb, "Failed to convert name to unicode.");
+		return -ENOMEM;
+	}
+
+	err = ntfs_check_bad_windows_name(vol, uname_new, new_name_len);
+	if (err) {
+		kmem_cache_free(ntfs_name_cache, uname_new);
+		return err;
+	}
+
+	old_name_len = ntfs_nlstoucs(NTFS_I(old_dir)->vol, old_dentry->d_name.name,
+				     old_dentry->d_name.len, &uname_old,
+				     NTFS_MAX_NAME_LEN);
+	if (old_name_len < 0) {
+		kmem_cache_free(ntfs_name_cache, uname_new);
+		if (old_name_len != -ENAMETOOLONG)
+			ntfs_error(sb, "Failed to convert name to unicode.");
+		return -ENOMEM;
+	}
+
+	old_inode = old_dentry->d_inode;
+	new_inode = new_dentry->d_inode;
+	old_ni = NTFS_I(old_inode);
+
+	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
+		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
+
+	mutex_lock_nested(&old_ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL);
+	mutex_lock_nested(&old_dir_ni->mrec_lock, NTFS_INODE_MUTEX_PARENT);
+
+	if (NInoBeingDeleted(old_ni) || NInoBeingDeleted(old_dir_ni)) {
+		err = -ENOENT;
+		goto unlock_old;
+	}
+
+	is_dir = S_ISDIR(old_inode->i_mode);
+
+	if (new_inode) {
+		new_ni = NTFS_I(new_inode);
+		mutex_lock_nested(&new_ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL_2);
+		if (old_dir != new_dir) {
+			mutex_lock_nested(&new_dir_ni->mrec_lock, NTFS_INODE_MUTEX_PARENT_2);
+			if (NInoBeingDeleted(new_dir_ni)) {
+				err = -ENOENT;
+				goto err_out;
+			}
+		}
+
+		if (NInoBeingDeleted(new_ni)) {
+			err = -ENOENT;
+			goto err_out;
+		}
+
+		if (is_dir) {
+			struct mft_record *ni_mrec;
+
+			ni_mrec = map_mft_record(NTFS_I(new_inode));
+			if (IS_ERR(ni_mrec)) {
+				err = -EIO;
+				goto err_out;
+			}
+			err = ntfs_check_empty_dir(NTFS_I(new_inode), ni_mrec);
+			unmap_mft_record(NTFS_I(new_inode));
+			if (err)
+				goto err_out;
+		}
+
+		err = ntfs_delete(new_ni, new_dir_ni, uname_new, new_name_len, false);
+		if (err)
+			goto err_out;
+	} else {
+		if (old_dir != new_dir) {
+			mutex_lock_nested(&new_dir_ni->mrec_lock, NTFS_INODE_MUTEX_PARENT_2);
+			if (NInoBeingDeleted(new_dir_ni)) {
+				err = -ENOENT;
+				goto err_out;
+			}
+		}
+	}
+
+	err = __ntfs_link(old_ni, new_dir_ni, uname_new, new_name_len);
+	if (err)
+		goto err_out;
+
+	err = ntfs_delete(old_ni, old_dir_ni, uname_old, old_name_len, false);
+	if (err) {
+		int err2;
+
+		ntfs_error(sb, "Failed to delete old ntfs inode(%ld) in old dir, err : %d\n",
+				old_ni->mft_no, err);
+		err2 = ntfs_delete(old_ni, new_dir_ni, uname_new, new_name_len, false);
+		if (err2)
+			ntfs_error(sb, "Failed to delete old ntfs inode in new dir, err : %d\n",
+					err2);
+		goto err_out;
+	}
+
+	simple_rename_timestamp(old_dir, old_dentry, new_dir, new_dentry);
+	mark_inode_dirty(old_inode);
+	mark_inode_dirty(old_dir);
+	if (old_dir != new_dir)
+		mark_inode_dirty(new_dir);
+	if (new_inode)
+		mark_inode_dirty(old_inode);
+
+	inode_inc_iversion(new_dir);
+
+err_out:
+	if (old_dir != new_dir)
+		mutex_unlock(&new_dir_ni->mrec_lock);
+	if (new_inode)
+		mutex_unlock(&new_ni->mrec_lock);
+
+unlock_old:
+	mutex_unlock(&old_dir_ni->mrec_lock);
+	mutex_unlock(&old_ni->mrec_lock);
+	if (uname_new)
+		kmem_cache_free(ntfs_name_cache, uname_new);
+	if (uname_old)
+		kmem_cache_free(ntfs_name_cache, uname_old);
+
+	return err;
+}
+
+static int ntfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
+		struct dentry *dentry, const char *symname)
+{
+	struct super_block *sb = dir->i_sb;
+	struct ntfs_volume *vol = NTFS_SB(sb);
+	struct inode *vi;
+	int err = 0;
+	struct ntfs_inode *ni;
+	__le16 *usrc;
+	__le16 *utarget;
+	int usrc_len;
+	int utarget_len;
+	int symlen = strlen(symname);
+
+	if (NVolShutdown(vol))
+		return -EIO;
+
+	usrc_len = ntfs_nlstoucs(vol, dentry->d_name.name,
+				 dentry->d_name.len, &usrc, NTFS_MAX_NAME_LEN);
+	if (usrc_len < 0) {
+		if (usrc_len != -ENAMETOOLONG)
+			ntfs_error(sb, "Failed to convert name to Unicode.");
+		err =  -ENOMEM;
+		goto out;
+	}
+
+	err = ntfs_check_bad_windows_name(vol, usrc, usrc_len);
+	if (err) {
+		kmem_cache_free(ntfs_name_cache, usrc);
+		goto out;
+	}
+
+	utarget_len = ntfs_nlstoucs(vol, symname, symlen, &utarget,
+				    PATH_MAX);
+	if (utarget_len < 0) {
+		if (utarget_len != -ENAMETOOLONG)
+			ntfs_error(sb, "Failed to convert target name to Unicode.");
+		err =  -ENOMEM;
+		kmem_cache_free(ntfs_name_cache, usrc);
+		goto out;
+	}
+
+	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
+		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
+
+	ni = __ntfs_create(idmap, dir, usrc, usrc_len, S_IFLNK | 0777, 0,
+			utarget, utarget_len);
+	kmem_cache_free(ntfs_name_cache, usrc);
+	kvfree(utarget);
+	if (IS_ERR(ni)) {
+		err = PTR_ERR(ni);
+		goto out;
+	}
+
+	vi = VFS_I(ni);
+	vi->i_size = symlen;
+	d_instantiate_new(dentry, vi);
+out:
+	return err;
+}
+
+static int ntfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
+		struct dentry *dentry, umode_t mode, dev_t rdev)
+{
+	struct super_block *sb = dir->i_sb;
+	struct ntfs_volume *vol = NTFS_SB(sb);
+	int err = 0;
+	struct ntfs_inode *ni;
+	__le16 *uname = NULL;
+	int uname_len;
+
+	if (NVolShutdown(vol))
+		return -EIO;
+
+	uname_len = ntfs_nlstoucs(vol, dentry->d_name.name,
+			dentry->d_name.len, &uname, NTFS_MAX_NAME_LEN);
+	if (uname_len < 0) {
+		if (uname_len != -ENAMETOOLONG)
+			ntfs_error(sb, "Failed to convert name to Unicode.");
+		return -ENOMEM;
+	}
+
+	err = ntfs_check_bad_windows_name(vol, uname, uname_len);
+	if (err) {
+		kmem_cache_free(ntfs_name_cache, uname);
+		return err;
+	}
+
+	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
+		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
+
+	switch (mode & S_IFMT) {
+	case S_IFCHR:
+	case S_IFBLK:
+		ni = __ntfs_create(idmap, dir, uname, uname_len,
+				mode, rdev, NULL, 0);
+		break;
+	default:
+		ni = __ntfs_create(idmap, dir, uname, uname_len,
+				mode, 0, NULL, 0);
+	}
+
+	kmem_cache_free(ntfs_name_cache, uname);
+	if (IS_ERR(ni)) {
+		err = PTR_ERR(ni);
+		goto out;
+	}
+
+	d_instantiate_new(dentry, VFS_I(ni));
+out:
+	return err;
+}
+
+static int ntfs_link(struct dentry *old_dentry, struct inode *dir,
+		struct dentry *dentry)
+{
+	struct inode *vi = old_dentry->d_inode;
+	struct super_block *sb = vi->i_sb;
+	struct ntfs_volume *vol = NTFS_SB(sb);
+	__le16 *uname = NULL;
+	int uname_len;
+	int err;
+	struct ntfs_inode *ni = NTFS_I(vi), *dir_ni = NTFS_I(dir);
+
+	if (NVolShutdown(vol))
+		return -EIO;
+
+	uname_len = ntfs_nlstoucs(vol, dentry->d_name.name,
+			dentry->d_name.len, &uname, NTFS_MAX_NAME_LEN);
+	if (uname_len < 0) {
+		if (uname_len != -ENAMETOOLONG)
+			ntfs_error(sb, "Failed to convert name to unicode.");
+		err = -ENOMEM;
+		goto out;
+	}
+
+	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
+		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
+
+	ihold(vi);
+	mutex_lock_nested(&ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL);
+	mutex_lock_nested(&dir_ni->mrec_lock, NTFS_INODE_MUTEX_PARENT);
+	err = __ntfs_link(NTFS_I(vi), NTFS_I(dir), uname, uname_len);
+	if (err) {
+		mutex_unlock(&dir_ni->mrec_lock);
+		mutex_unlock(&ni->mrec_lock);
+		iput(vi);
+		pr_err("failed to create link, err = %d\n", err);
+		goto out;
+	}
+
+	inode_inc_iversion(dir);
+	simple_inode_init_ts(dir);
+
+	inode_inc_iversion(vi);
+	simple_inode_init_ts(vi);
+
+	/* timestamp is already written, so mark_inode_dirty() is unneeded. */
+	d_instantiate(dentry, vi);
+	mutex_unlock(&dir_ni->mrec_lock);
+	mutex_unlock(&ni->mrec_lock);
+
+out:
+	ntfs_free(uname);
+	return err;
+}
+
+/**
  * Inode operations for directories.
  */
 const struct inode_operations ntfs_dir_inode_ops = {
-	.lookup	= ntfs_lookup,	/* VFS: Lookup directory. */
+	.lookup		= ntfs_lookup,	/* VFS: Lookup directory. */
+	.create		= ntfs_create,
+	.unlink		= ntfs_unlink,
+	.mkdir		= ntfs_mkdir,
+	.rmdir		= ntfs_rmdir,
+	.rename		= ntfs_rename,
+	.get_acl	= ntfs_get_acl,
+	.set_acl	= ntfs_set_acl,
+	.listxattr	= ntfs_listxattr,
+	.setattr	= ntfs_setattr,
+	.getattr	= ntfs_getattr,
+	.symlink	= ntfs_symlink,
+	.mknod		= ntfs_mknod,
+	.link		= ntfs_link,
 };
 
 /**
@@ -275,9 +1587,6 @@ const struct inode_operations ntfs_dir_inode_ops = {
  * fs/exportfs/expfs.c::find_exported_dentry() which in turn is called from the
  * default ->decode_fh() which is export_decode_fh() in the same file.
  *
- * The code is based on the ext3 ->get_parent() implementation found in
- * fs/ext3/namei.c::ext3_get_parent().
- *
  * Note: ntfs_get_parent() is called with @d_inode(child_dent)->i_mutex down.
  *
  * Return the dentry of the parent directory on success or the error code on
@@ -286,11 +1595,11 @@ const struct inode_operations ntfs_dir_inode_ops = {
 static struct dentry *ntfs_get_parent(struct dentry *child_dent)
 {
 	struct inode *vi = d_inode(child_dent);
-	ntfs_inode *ni = NTFS_I(vi);
-	MFT_RECORD *mrec;
-	ntfs_attr_search_ctx *ctx;
-	ATTR_RECORD *attr;
-	FILE_NAME_ATTR *fn;
+	struct ntfs_inode *ni = NTFS_I(vi);
+	struct mft_record *mrec;
+	struct ntfs_attr_search_ctx *ctx;
+	struct attr_record *attr;
+	struct file_name_attr *fn;
 	unsigned long parent_ino;
 	int err;
 
@@ -312,18 +1621,18 @@ static struct dentry *ntfs_get_parent(struct dentry *child_dent)
 		ntfs_attr_put_search_ctx(ctx);
 		unmap_mft_record(ni);
 		if (err == -ENOENT)
-			ntfs_error(vi->i_sb, "Inode 0x%lx does not have a "
-					"file name attribute.  Run chkdsk.",
-					vi->i_ino);
+			ntfs_error(vi->i_sb,
+				   "Inode 0x%lx does not have a file name attribute.  Run chkdsk.",
+				   vi->i_ino);
 		return ERR_PTR(err);
 	}
 	attr = ctx->attr;
 	if (unlikely(attr->non_resident))
 		goto try_next;
-	fn = (FILE_NAME_ATTR *)((u8 *)attr +
+	fn = (struct file_name_attr *)((u8 *)attr +
 			le16_to_cpu(attr->data.resident.value_offset));
 	if (unlikely((u8 *)fn + le32_to_cpu(attr->data.resident.value_length) >
-			(u8*)attr + le32_to_cpu(attr->length)))
+	    (u8 *)attr + le32_to_cpu(attr->length)))
 		goto try_next;
 	/* Get the inode number of the parent directory. */
 	parent_ino = MREF_LE(fn->parent_directory);
@@ -341,7 +1650,7 @@ static struct inode *ntfs_nfs_get_inode(struct super_block *sb,
 
 	inode = ntfs_iget(sb, ino);
 	if (!IS_ERR(inode)) {
-		if (is_bad_inode(inode) || inode->i_generation != generation) {
+		if (inode->i_generation != generation) {
 			iput(inode);
 			inode = ERR_PTR(-ESTALE);
 		}
@@ -364,29 +1673,12 @@ static struct dentry *ntfs_fh_to_parent(struct super_block *sb, struct fid *fid,
 				    ntfs_nfs_get_inode);
 }
 
-/*
+/**
  * Export operations allowing NFS exporting of mounted NTFS partitions.
- *
- * We use the default ->encode_fh() for now.  Note that they
- * use 32 bits to store the inode number which is an unsigned long so on 64-bit
- * architectures is usually 64 bits so it would all fail horribly on huge
- * volumes.  I guess we need to define our own encode and decode fh functions
- * that store 64-bit inode numbers at some point but for now we will ignore the
- * problem...
- *
- * We also use the default ->get_name() helper (used by ->decode_fh() via
- * fs/exportfs/expfs.c::find_exported_dentry()) as that is completely fs
- * independent.
- *
- * The default ->get_parent() just returns -EACCES so we have to provide our
- * own and the default ->get_dentry() is incompatible with NTFS due to not
- * allowing the inode number 0 which is used in NTFS for the system file $MFT
- * and due to using iget() whereas NTFS needs ntfs_iget().
  */
 const struct export_operations ntfs_export_ops = {
-	.encode_fh	= generic_encode_ino32_fh,
-	.get_parent	= ntfs_get_parent,	/* Find the parent of a given
-						   directory. */
+	.encode_fh = generic_encode_ino32_fh,
+	.get_parent	= ntfs_get_parent,	/* Find the parent of a given directory. */
 	.fh_to_dentry	= ntfs_fh_to_dentry,
 	.fh_to_parent	= ntfs_fh_to_parent,
 };
-- 
2.25.1


