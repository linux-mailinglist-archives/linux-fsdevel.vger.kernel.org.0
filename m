Return-Path: <linux-fsdevel+bounces-64637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B0381BEF0DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 04:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E41564E558A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 02:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E561FAC4B;
	Mon, 20 Oct 2025 02:09:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FCE1F461A
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 02:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760926150; cv=none; b=fWjJoddMRuMCfud3jKF8eTkDTF4G2gvq+oWgGF+e8Cz6HHuVN0prduA16ork4TMi0D4pLtpmqdY8HCbjbif8borlpbq1laQfyYk+k9fxzKyzFHbeWfWM4DU3ElpXTPCKUrNjazVvLElE3os9aOv0b2OuUtwctvgeFlpnB2cXXm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760926150; c=relaxed/simple;
	bh=f4Q3pvvCUdNZYH7W+YlvsV8Sq5PTDGzenP5AEADMmhI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OB3YrAQkGLkOUhNCl/hEefvji3U1QjES0ilRm2WGl4aUYpqXHoIvjC5X9vgUTorr+pWbqHrA6NECLIiwY7DbIdufe3jwDXcYJ/kk1E7pNze41jAHFMouiPfPccA52I3NDzceEfo3r5u4kJoykg+YZ59pmLaEM9a1f0z8e7wlKIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-781db5068b8so2922820b3a.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Oct 2025 19:08:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760926138; x=1761530938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5uOjE0Z1Qgi3+hAUlDxGQPBdlKN8zBENqwFuxwEA1c=;
        b=WPAPnm7cc5SyCgan5Fj0KosvL5F7Za/5vsjc/fsq6bEsblbNvzJVB4URB8fZA52EqV
         x3rOPJwrHx8A5d6x8In3vMFCzVkhLMxD7SdZyjSkVewgd92ZqwF0+fxaY4W6tGlChwnY
         ZrGYoL1uN1WyaUOc6+5oPPRdTKv+h/VQBuiE8hDA+xJtMmA4SD2fXsPzy9YcD4hTOJcy
         6ISQyTlaY1Kg3KVW4sn30oRRFZl+T0+oW2dibfpT+Y8jwTHxbMrTRRtsvlOavWnvzFkJ
         Zc4xqzcwih2HL+2sB6CveozFIKtaErsHGhVA8shzSh6FEfQSNVxAy1Ods6BM3HmWl9DI
         u/MA==
X-Gm-Message-State: AOJu0Yy6EbWFv9N6xXSjIajiQ6o6vZfZtoN7bneC+LZzH88WwQFEFZ8a
	IBoktAaednUACLlqa6j+4E8qwBaE12paD8jygxdJ4v/kcIRoJDL0fSRx
X-Gm-Gg: ASbGncvyi/NgBiGFTEroSEJAL6bXXgWmOW2mb8rV6PdiT9BXGVSyAwQnuTyGCfVStg4
	82rorQsAcv8l2BaRBf3JiGqH6b8vpv0D8Njo9bOCI5oWiN0f3oNk/U8+oJA58rfSN2Zqd0n9TDm
	4ZThgbjuDHa1nwBrud2mBqjLQ5pUiZvk2xBHFpqCYUrwtpJyz4DQnDX98IIebvdra/Dr7kfi6a6
	KpHSL5G7xXIWYa7mVkzuBI37PazbbjnfLTBMzn1lZoE0FjNxHFUE5g6RZIciGpRDTh2qJpZsQzf
	8JYmhSKwFB5SuqR+vHHCX0AoIYu8JE5UrXa4I6HdN6khcoxoFkJGrvefFJh+YyNvCAbVig8ypFR
	/VDphlel8F92FU5cd5Vz8gAkZJsHTnf+Q1WplLW1xGf70nlY1JMl/eoUMGc2kkqiHujuZT6D/W3
	TQuS/6fhXHS1R0IrkTKY6Zpr002A==
X-Google-Smtp-Source: AGHT+IE3MHEcZ6fW0uhoVrxvDzTR9XWmUm9l9MWeL3fnH68W4IpRMn6PdWysGVUxn1LyjXGK/6MWZw==
X-Received: by 2002:a05:6a20:748a:b0:262:9461:2e5b with SMTP id adf61e73a8af0-334a864a02bmr13920654637.53.1760926136948;
        Sun, 19 Oct 2025 19:08:56 -0700 (PDT)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23010df83sm6722300b3a.59.2025.10.19.19.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 19:08:55 -0700 (PDT)
From: Namjae Jeon <linkinjeon@kernel.org>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	hch@infradead.org,
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
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 03/11] ntfsplus: add inode operations
Date: Mon, 20 Oct 2025 11:07:41 +0900
Message-Id: <20251020020749.5522-4-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251020020749.5522-1-linkinjeon@kernel.org>
References: <20251020020749.5522-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the implementation of inode operations for ntfsplus.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ntfsplus/inode.c | 3705 +++++++++++++++++++++++++++++++++++++++++++
 fs/ntfsplus/mft.c   | 2630 ++++++++++++++++++++++++++++++
 fs/ntfsplus/mst.c   |  195 +++
 fs/ntfsplus/namei.c | 1606 +++++++++++++++++++
 4 files changed, 8136 insertions(+)
 create mode 100644 fs/ntfsplus/inode.c
 create mode 100644 fs/ntfsplus/mft.c
 create mode 100644 fs/ntfsplus/mst.c
 create mode 100644 fs/ntfsplus/namei.c

diff --git a/fs/ntfsplus/inode.c b/fs/ntfsplus/inode.c
new file mode 100644
index 000000000000..2b8e0d67cf62
--- /dev/null
+++ b/fs/ntfsplus/inode.c
@@ -0,0 +1,3705 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/**
+ * NTFS kernel inode handling.
+ *
+ * Copyright (c) 2001-2014 Anton Altaparmakov and Tuxera Inc.
+ * Copyright (c) 2025 LG Electronics Co., Ltd.
+ */
+
+#include <linux/writeback.h>
+#include <linux/seq_file.h>
+
+#include "lcnalloc.h"
+#include "misc.h"
+#include "ntfs.h"
+#include "index.h"
+#include "attrlist.h"
+#include "reparse.h"
+#include "ea.h"
+#include "attrib.h"
+#include "ntfs_iomap.h"
+
+/**
+ * ntfs_test_inode - compare two (possibly fake) inodes for equality
+ * @vi:		vfs inode which to test
+ * @data:	data which is being tested with
+ *
+ * Compare the ntfs attribute embedded in the ntfs specific part of the vfs
+ * inode @vi for equality with the ntfs attribute @data.
+ *
+ * If searching for the normal file/directory inode, set @na->type to AT_UNUSED.
+ * @na->name and @na->name_len are then ignored.
+ *
+ * Return 1 if the attributes match and 0 if not.
+ *
+ * NOTE: This function runs with the inode_hash_lock spin lock held so it is not
+ * allowed to sleep.
+ */
+int ntfs_test_inode(struct inode *vi, void *data)
+{
+	struct ntfs_attr *na = (struct ntfs_attr *)data;
+	struct ntfs_inode *ni;
+
+	if (vi->i_ino != na->mft_no)
+		return 0;
+
+	ni = NTFS_I(vi);
+
+	/* If !NInoAttr(ni), @vi is a normal file or directory inode. */
+	if (likely(!NInoAttr(ni))) {
+		/* If not looking for a normal inode this is a mismatch. */
+		if (unlikely(na->type != AT_UNUSED))
+			return 0;
+	} else {
+		/* A fake inode describing an attribute. */
+		if (ni->type != na->type)
+			return 0;
+		if (ni->name_len != na->name_len)
+			return 0;
+		if (na->name_len && memcmp(ni->name, na->name,
+				na->name_len * sizeof(__le16)))
+			return 0;
+		if (!ni->ext.base_ntfs_ino)
+			return 0;
+	}
+
+	/* Match! */
+	return 1;
+}
+
+/**
+ * ntfs_init_locked_inode - initialize an inode
+ * @vi:		vfs inode to initialize
+ * @data:	data which to initialize @vi to
+ *
+ * Initialize the vfs inode @vi with the values from the ntfs attribute @data in
+ * order to enable ntfs_test_inode() to do its work.
+ *
+ * If initializing the normal file/directory inode, set @na->type to AT_UNUSED.
+ * In that case, @na->name and @na->name_len should be set to NULL and 0,
+ * respectively. Although that is not strictly necessary as
+ * ntfs_read_locked_inode() will fill them in later.
+ *
+ * Return 0 on success and error.
+ *
+ * NOTE: This function runs with the inode->i_lock spin lock held so it is not
+ * allowed to sleep. (Hence the GFP_ATOMIC allocation.)
+ */
+static int ntfs_init_locked_inode(struct inode *vi, void *data)
+{
+	struct ntfs_attr *na = (struct ntfs_attr *)data;
+	struct ntfs_inode *ni = NTFS_I(vi);
+
+	vi->i_ino = na->mft_no;
+
+	if (na->type == AT_INDEX_ALLOCATION)
+		NInoSetMstProtected(ni);
+	else
+		ni->type = na->type;
+
+	ni->name = na->name;
+	ni->name_len = na->name_len;
+	ni->folio = NULL;
+	atomic_set(&ni->count, 1);
+
+	/* If initializing a normal inode, we are done. */
+	if (likely(na->type == AT_UNUSED)) {
+		BUG_ON(na->name);
+		BUG_ON(na->name_len);
+		return 0;
+	}
+
+	/* It is a fake inode. */
+	NInoSetAttr(ni);
+
+	/*
+	 * We have I30 global constant as an optimization as it is the name
+	 * in >99.9% of named attributes! The other <0.1% incur a GFP_ATOMIC
+	 * allocation but that is ok. And most attributes are unnamed anyway,
+	 * thus the fraction of named attributes with name != I30 is actually
+	 * absolutely tiny.
+	 */
+	if (na->name_len && na->name != I30) {
+		unsigned int i;
+
+		BUG_ON(!na->name);
+		i = na->name_len * sizeof(__le16);
+		ni->name = kmalloc(i + sizeof(__le16), GFP_ATOMIC);
+		if (!ni->name)
+			return -ENOMEM;
+		memcpy(ni->name, na->name, i);
+		ni->name[na->name_len] = 0;
+	}
+	return 0;
+}
+
+static int ntfs_read_locked_inode(struct inode *vi);
+static int ntfs_read_locked_attr_inode(struct inode *base_vi, struct inode *vi);
+static int ntfs_read_locked_index_inode(struct inode *base_vi,
+		struct inode *vi);
+
+/**
+ * ntfs_iget - obtain a struct inode corresponding to a specific normal inode
+ * @sb:		super block of mounted volume
+ * @mft_no:	mft record number / inode number to obtain
+ *
+ * Obtain the struct inode corresponding to a specific normal inode (i.e. a
+ * file or directory).
+ *
+ * If the inode is in the cache, it is just returned with an increased
+ * reference count. Otherwise, a new struct inode is allocated and initialized,
+ * and finally ntfs_read_locked_inode() is called to read in the inode and
+ * fill in the remainder of the inode structure.
+ *
+ * Return the struct inode on success. Check the return value with IS_ERR() and
+ * if true, the function failed and the error code is obtained from PTR_ERR().
+ */
+struct inode *ntfs_iget(struct super_block *sb, unsigned long mft_no)
+{
+	struct inode *vi;
+	int err;
+	struct ntfs_attr na;
+
+	na.mft_no = mft_no;
+	na.type = AT_UNUSED;
+	na.name = NULL;
+	na.name_len = 0;
+
+	vi = iget5_locked(sb, mft_no, ntfs_test_inode,
+			ntfs_init_locked_inode, &na);
+	if (unlikely(!vi))
+		return ERR_PTR(-ENOMEM);
+
+	err = 0;
+
+	/* If this is a freshly allocated inode, need to read it now. */
+	if (vi->i_state & I_NEW) {
+		err = ntfs_read_locked_inode(vi);
+		unlock_new_inode(vi);
+	}
+	/*
+	 * There is no point in keeping bad inodes around if the failure was
+	 * due to ENOMEM. We want to be able to retry again later.
+	 */
+	if (unlikely(err == -ENOMEM)) {
+		iput(vi);
+		vi = ERR_PTR(err);
+	}
+	return vi;
+}
+
+/**
+ * ntfs_attr_iget - obtain a struct inode corresponding to an attribute
+ * @base_vi:	vfs base inode containing the attribute
+ * @type:	attribute type
+ * @name:	Unicode name of the attribute (NULL if unnamed)
+ * @name_len:	length of @name in Unicode characters (0 if unnamed)
+ *
+ * Obtain the (fake) struct inode corresponding to the attribute specified by
+ * @type, @name, and @name_len, which is present in the base mft record
+ * specified by the vfs inode @base_vi.
+ *
+ * If the attribute inode is in the cache, it is just returned with an
+ * increased reference count. Otherwise, a new struct inode is allocated and
+ * initialized, and finally ntfs_read_locked_attr_inode() is called to read the
+ * attribute and fill in the inode structure.
+ *
+ * Note, for index allocation attributes, you need to use ntfs_index_iget()
+ * instead of ntfs_attr_iget() as working with indices is a lot more complex.
+ *
+ * Return the struct inode of the attribute inode on success. Check the return
+ * value with IS_ERR() and if true, the function failed and the error code is
+ * obtained from PTR_ERR().
+ */
+struct inode *ntfs_attr_iget(struct inode *base_vi, __le32 type,
+		__le16 *name, u32 name_len)
+{
+	struct inode *vi;
+	int err;
+	struct ntfs_attr na;
+
+	/* Make sure no one calls ntfs_attr_iget() for indices. */
+	BUG_ON(type == AT_INDEX_ALLOCATION);
+
+	na.mft_no = base_vi->i_ino;
+	na.type = type;
+	na.name = name;
+	na.name_len = name_len;
+
+	vi = iget5_locked(base_vi->i_sb, na.mft_no, ntfs_test_inode,
+			ntfs_init_locked_inode, &na);
+	if (unlikely(!vi))
+		return ERR_PTR(-ENOMEM);
+	err = 0;
+
+	/* If this is a freshly allocated inode, need to read it now. */
+	if (vi->i_state & I_NEW) {
+		err = ntfs_read_locked_attr_inode(base_vi, vi);
+		unlock_new_inode(vi);
+	}
+	/*
+	 * There is no point in keeping bad attribute inodes around. This also
+	 * simplifies things in that we never need to check for bad attribute
+	 * inodes elsewhere.
+	 */
+	if (unlikely(err)) {
+		iput(vi);
+		vi = ERR_PTR(err);
+	}
+	return vi;
+}
+
+/**
+ * ntfs_index_iget - obtain a struct inode corresponding to an index
+ * @base_vi:	vfs base inode containing the index related attributes
+ * @name:	Unicode name of the index
+ * @name_len:	length of @name in Unicode characters
+ *
+ * Obtain the (fake) struct inode corresponding to the index specified by @name
+ * and @name_len, which is present in the base mft record specified by the vfs
+ * inode @base_vi.
+ *
+ * If the index inode is in the cache, it is just returned with an increased
+ * reference count.  Otherwise, a new struct inode is allocated and
+ * initialized, and finally ntfs_read_locked_index_inode() is called to read
+ * the index related attributes and fill in the inode structure.
+ *
+ * Return the struct inode of the index inode on success. Check the return
+ * value with IS_ERR() and if true, the function failed and the error code is
+ * obtained from PTR_ERR().
+ */
+struct inode *ntfs_index_iget(struct inode *base_vi, __le16 *name,
+		u32 name_len)
+{
+	struct inode *vi;
+	int err;
+	struct ntfs_attr na;
+
+	na.mft_no = base_vi->i_ino;
+	na.type = AT_INDEX_ALLOCATION;
+	na.name = name;
+	na.name_len = name_len;
+
+	vi = iget5_locked(base_vi->i_sb, na.mft_no, ntfs_test_inode,
+			ntfs_init_locked_inode, &na);
+	if (unlikely(!vi))
+		return ERR_PTR(-ENOMEM);
+
+	err = 0;
+
+	/* If this is a freshly allocated inode, need to read it now. */
+	if (vi->i_state & I_NEW) {
+		err = ntfs_read_locked_index_inode(base_vi, vi);
+		unlock_new_inode(vi);
+	}
+	/*
+	 * There is no point in keeping bad index inodes around.  This also
+	 * simplifies things in that we never need to check for bad index
+	 * inodes elsewhere.
+	 */
+	if (unlikely(err)) {
+		iput(vi);
+		vi = ERR_PTR(err);
+	}
+	return vi;
+}
+
+struct inode *ntfs_alloc_big_inode(struct super_block *sb)
+{
+	struct ntfs_inode *ni;
+
+	ntfs_debug("Entering.");
+	ni = alloc_inode_sb(sb, ntfs_big_inode_cache, GFP_NOFS);
+	if (likely(ni != NULL)) {
+		ni->state = 0;
+		ni->type = 0;
+		ni->mft_no = 0;
+		return VFS_I(ni);
+	}
+	ntfs_error(sb, "Allocation of NTFS big inode structure failed.");
+	return NULL;
+}
+
+void ntfs_free_big_inode(struct inode *inode)
+{
+	kmem_cache_free(ntfs_big_inode_cache, NTFS_I(inode));
+}
+
+static int ntfs_non_resident_dealloc_clusters(struct ntfs_inode *ni)
+{
+	struct super_block *sb = ni->vol->sb;
+	struct ntfs_attr_search_ctx *actx;
+	int err = 0;
+
+	actx = ntfs_attr_get_search_ctx(ni, NULL);
+	if (!actx)
+		return -ENOMEM;
+	BUG_ON(actx->mrec->link_count != 0);
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
+	if (!inode_unhashed(inode) && inode->i_state & I_SYNC) {
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
+{
+	struct ntfs_inode *ni;
+
+	ntfs_debug("Entering.");
+	ni = kmem_cache_alloc(ntfs_inode_cache, GFP_NOFS);
+	if (likely(ni != NULL)) {
+		ni->state = 0;
+		return ni;
+	}
+	ntfs_error(NULL, "Allocation of NTFS inode structure failed.");
+	return NULL;
+}
+
+static void ntfs_destroy_extent_inode(struct ntfs_inode *ni)
+{
+	ntfs_debug("Entering.");
+
+	if (!atomic_dec_and_test(&ni->count))
+		BUG();
+	if (ni->folio)
+		ntfs_unmap_folio(ni->folio, NULL);
+	kfree(ni->mrec);
+	kmem_cache_free(ntfs_inode_cache, ni);
+}
+
+static struct lock_class_key attr_inode_mrec_lock_class;
+static struct lock_class_key attr_list_inode_mrec_lock_class;
+
+/*
+ * The attribute runlist lock has separate locking rules from the
+ * normal runlist lock, so split the two lock-classes:
+ */
+static struct lock_class_key attr_list_rl_lock_class;
+
+/**
+ * __ntfs_init_inode - initialize ntfs specific part of an inode
+ * @sb:		super block of mounted volume
+ * @ni:		freshly allocated ntfs inode which to initialize
+ *
+ * Initialize an ntfs inode to defaults.
+ *
+ * NOTE: ni->mft_no, ni->state, ni->type, ni->name, and ni->name_len are left
+ * untouched. Make sure to initialize them elsewhere.
+ */
+void __ntfs_init_inode(struct super_block *sb, struct ntfs_inode *ni)
+{
+	ntfs_debug("Entering.");
+	rwlock_init(&ni->size_lock);
+	ni->initialized_size = ni->allocated_size = 0;
+	ni->seq_no = 0;
+	atomic_set(&ni->count, 1);
+	ni->vol = NTFS_SB(sb);
+	ntfs_init_runlist(&ni->runlist);
+	ni->lcn_seek_trunc = LCN_RL_NOT_MAPPED;
+	mutex_init(&ni->mrec_lock);
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
+	ni->attr_list_size = 0;
+	ni->attr_list = NULL;
+	ni->itype.index.block_size = 0;
+	ni->itype.index.vcn_size = 0;
+	ni->itype.index.collation_rule = 0;
+	ni->itype.index.block_size_bits = 0;
+	ni->itype.index.vcn_size_bits = 0;
+	mutex_init(&ni->extent_lock);
+	ni->nr_extents = 0;
+	ni->ext.base_ntfs_ino = NULL;
+	ni->flags = 0;
+	ni->mft_lcn[0] = LCN_RL_NOT_MAPPED;
+	ni->mft_lcn_count = 0;
+	ni->target = NULL;
+	ni->i_dealloc_clusters = 0;
+}
+
+/*
+ * Extent inodes get MFT-mapped in a nested way, while the base inode
+ * is still mapped. Teach this nesting to the lock validator by creating
+ * a separate class for nested inode's mrec_lock's:
+ */
+static struct lock_class_key extent_inode_mrec_lock_key;
+
+inline struct ntfs_inode *ntfs_new_extent_inode(struct super_block *sb,
+		unsigned long mft_no)
+{
+	struct ntfs_inode *ni = ntfs_alloc_extent_inode();
+
+	ntfs_debug("Entering.");
+	if (likely(ni != NULL)) {
+		__ntfs_init_inode(sb, ni);
+		lockdep_set_class(&ni->mrec_lock, &extent_inode_mrec_lock_key);
+		ni->mft_no = mft_no;
+		ni->type = AT_UNUSED;
+		ni->name = NULL;
+		ni->name_len = 0;
+	}
+	return ni;
+}
+
+/**
+ * ntfs_is_extended_system_file - check if a file is in the $Extend directory
+ * @ctx:	initialized attribute search context
+ *
+ * Search all file name attributes in the inode described by the attribute
+ * search context @ctx and check if any of the names are in the $Extend system
+ * directory.
+ *
+ * Return values:
+ *	   1: file is in $Extend directory
+ *	   0: file is not in $Extend directory
+ *    -errno: failed to determine if the file is in the $Extend directory
+ */
+static int ntfs_is_extended_system_file(struct ntfs_attr_search_ctx *ctx)
+{
+	int nr_links, err;
+
+	/* Restart search. */
+	ntfs_attr_reinit_search_ctx(ctx);
+
+	/* Get number of hard links. */
+	nr_links = le16_to_cpu(ctx->mrec->link_count);
+
+	/* Loop through all hard links. */
+	while (!(err = ntfs_attr_lookup(AT_FILE_NAME, NULL, 0, 0, 0, NULL, 0,
+			ctx))) {
+		struct file_name_attr *file_name_attr;
+		struct attr_record *attr = ctx->attr;
+		u8 *p, *p2;
+
+		nr_links--;
+		/*
+		 * Maximum sanity checking as we are called on an inode that
+		 * we suspect might be corrupt.
+		 */
+		p = (u8 *)attr + le32_to_cpu(attr->length);
+		if (p < (u8 *)ctx->mrec || (u8 *)p > (u8 *)ctx->mrec +
+				le32_to_cpu(ctx->mrec->bytes_in_use)) {
+err_corrupt_attr:
+			ntfs_error(ctx->ntfs_ino->vol->sb,
+					"Corrupt file name attribute. You should run chkdsk.");
+			return -EIO;
+		}
+		if (attr->non_resident) {
+			ntfs_error(ctx->ntfs_ino->vol->sb,
+					"Non-resident file name. You should run chkdsk.");
+			return -EIO;
+		}
+		if (attr->flags) {
+			ntfs_error(ctx->ntfs_ino->vol->sb,
+					"File name with invalid flags. You should run chkdsk.");
+			return -EIO;
+		}
+		if (!(attr->data.resident.flags & RESIDENT_ATTR_IS_INDEXED)) {
+			ntfs_error(ctx->ntfs_ino->vol->sb,
+					"Unindexed file name. You should run chkdsk.");
+			return -EIO;
+		}
+		file_name_attr = (struct file_name_attr *)((u8 *)attr +
+				le16_to_cpu(attr->data.resident.value_offset));
+		p2 = (u8 *)file_name_attr + le32_to_cpu(attr->data.resident.value_length);
+		if (p2 < (u8 *)attr || p2 > p)
+			goto err_corrupt_attr;
+		/* This attribute is ok, but is it in the $Extend directory? */
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
+			return 1;	/* YES, it's an extended system file. */
+		}
+	}
+	if (unlikely(err != -ENOENT))
+		return err;
+	if (unlikely(nr_links)) {
+		ntfs_error(ctx->ntfs_ino->vol->sb,
+			"Inode hard link count doesn't match number of name attributes. You should run chkdsk.");
+		return -EIO;
+	}
+	return 0;	/* NO, it is not an extended system file. */
+}
+
+static struct lock_class_key ntfs_dir_inval_lock_key;
+
+void ntfs_set_vfs_operations(struct inode *inode, mode_t mode, dev_t dev)
+{
+	if (S_ISDIR(mode)) {
+		if (!NInoAttr(NTFS_I(inode))) {
+			inode->i_op = &ntfs_dir_inode_ops;
+			inode->i_fop = &ntfs_dir_ops;
+		}
+		if (NInoMstProtected(NTFS_I(inode)))
+			inode->i_mapping->a_ops = &ntfs_mst_aops;
+		else
+			inode->i_mapping->a_ops = &ntfs_normal_aops;
+		lockdep_set_class(&inode->i_mapping->invalidate_lock,
+				  &ntfs_dir_inval_lock_key);
+	} else if (S_ISLNK(mode)) {
+		inode->i_op = &ntfs_symlink_inode_operations;
+		inode->i_mapping->a_ops = &ntfs_normal_aops;
+	} else if (S_ISCHR(mode) || S_ISBLK(mode) || S_ISFIFO(mode) || S_ISSOCK(mode)) {
+		inode->i_op = &ntfs_special_inode_operations;
+		init_special_inode(inode, inode->i_mode, dev);
+	} else {
+		if (!NInoAttr(NTFS_I(inode))) {
+			inode->i_op = &ntfs_file_inode_ops;
+			inode->i_fop = &ntfs_file_ops;
+		}
+		if (NInoMstProtected(NTFS_I(inode)))
+			inode->i_mapping->a_ops = &ntfs_mst_aops;
+		else if (NInoCompressed(NTFS_I(inode)))
+			inode->i_mapping->a_ops = &ntfs_compressed_aops;
+		else
+			inode->i_mapping->a_ops = &ntfs_normal_aops;
+	}
+}
+
+__le16 R[3] = { cpu_to_le16('$'), cpu_to_le16('R'), 0 };
+
+/**
+ * ntfs_read_locked_inode - read an inode from its device
+ * @vi:		inode to read
+ *
+ * ntfs_read_locked_inode() is called from ntfs_iget() to read the inode
+ * described by @vi into memory from the device.
+ *
+ * The only fields in @vi that we need to/can look at when the function is
+ * called are i_sb, pointing to the mounted device's super block, and i_ino,
+ * the number of the inode to load.
+ *
+ * ntfs_read_locked_inode() maps, pins and locks the mft record number i_ino
+ * for reading and sets up the necessary @vi fields as well as initializing
+ * the ntfs inode.
+ *
+ * Q: What locks are held when the function is called?
+ * A: i_state has I_NEW set, hence the inode is locked, also
+ *    i_count is set to 1, so it is not going to go away
+ *    i_flags is set to 0 and we have no business touching it.  Only an ioctl()
+ *    is allowed to write to them. We should of course be honouring them but
+ *    we need to do that using the IS_* macros defined in include/linux/fs.h.
+ *    In any case ntfs_read_locked_inode() has nothing to do with i_flags.
+ *
+ * Return 0 on success and -errno on error.
+ */
+static int ntfs_read_locked_inode(struct inode *vi)
+{
+	struct ntfs_volume *vol = NTFS_SB(vi->i_sb);
+	struct ntfs_inode *ni;
+	struct mft_record *m;
+	struct attr_record *a;
+	struct standard_information *si;
+	struct ntfs_attr_search_ctx *ctx;
+	int err = 0;
+	__le16 *name = I30;
+	unsigned int name_len = 4, flags = 0;
+	int extend_sys = 0;
+	dev_t dev = 0;
+	bool vol_err = true;
+
+	ntfs_debug("Entering for i_ino 0x%lx.", vi->i_ino);
+
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
+
+	/*
+	 * Initialize the ntfs specific part of @vi special casing
+	 * FILE_MFT which we need to do at mount time.
+	 */
+	if (vi->i_ino != FILE_MFT)
+		ntfs_init_big_inode(vi);
+	ni = NTFS_I(vi);
+
+	m = map_mft_record(ni);
+	if (IS_ERR(m)) {
+		err = PTR_ERR(m);
+		goto err_out;
+	}
+
+	ctx = ntfs_attr_get_search_ctx(ni, m);
+	if (!ctx) {
+		err = -ENOMEM;
+		goto unm_err_out;
+	}
+
+	if (!(m->flags & MFT_RECORD_IN_USE)) {
+		err = -ENOENT;
+		vol_err = false;
+		goto unm_err_out;
+	}
+
+	if (m->base_mft_record) {
+		ntfs_error(vi->i_sb, "Inode is an extent inode!");
+		goto unm_err_out;
+	}
+
+	/* Transfer information from mft record into vfs and ntfs inodes. */
+	vi->i_generation = ni->seq_no = le16_to_cpu(m->sequence_number);
+
+	if (le16_to_cpu(m->link_count) < 1) {
+		ntfs_error(vi->i_sb, "Inode link count is 0!");
+		goto unm_err_out;
+	}
+	set_nlink(vi, le16_to_cpu(m->link_count));
+
+	/* If read-only, no one gets write permissions. */
+	if (IS_RDONLY(vi))
+		vi->i_mode &= ~0222;
+
+	/*
+	 * Find the standard information attribute in the mft record. At this
+	 * stage we haven't setup the attribute list stuff yet, so this could
+	 * in fact fail if the standard information is in an extent record, but
+	 * I don't think this actually ever happens.
+	 */
+	ntfs_attr_reinit_search_ctx(ctx);
+	err = ntfs_attr_lookup(AT_STANDARD_INFORMATION, NULL, 0, 0, 0, NULL, 0,
+			ctx);
+	if (unlikely(err)) {
+		if (err == -ENOENT)
+			ntfs_error(vi->i_sb, "$STANDARD_INFORMATION attribute is missing.");
+		goto unm_err_out;
+	}
+	a = ctx->attr;
+	/* Get the standard information attribute value. */
+	if ((u8 *)a + le16_to_cpu(a->data.resident.value_offset)
+			+ le32_to_cpu(a->data.resident.value_length) >
+			(u8 *)ctx->mrec + vol->mft_record_size) {
+		ntfs_error(vi->i_sb, "Corrupt standard information attribute in inode.");
+		goto unm_err_out;
+	}
+	si = (struct standard_information *)((u8 *)a +
+			le16_to_cpu(a->data.resident.value_offset));
+
+	/* Transfer information from the standard information into vi. */
+	/*
+	 * Note: The i_?times do not quite map perfectly onto the NTFS times,
+	 * but they are close enough, and in the end it doesn't really matter
+	 * that much...
+	 */
+	/*
+	 * mtime is the last change of the data within the file. Not changed
+	 * when only metadata is changed, e.g. a rename doesn't affect mtime.
+	 */
+	ni->i_crtime = ntfs2utc(si->creation_time);
+
+	inode_set_mtime_to_ts(vi, ntfs2utc(si->last_data_change_time));
+	/*
+	 * ctime is the last change of the metadata of the file. This obviously
+	 * always changes, when mtime is changed. ctime can be changed on its
+	 * own, mtime is then not changed, e.g. when a file is renamed.
+	 */
+	inode_set_ctime_to_ts(vi, ntfs2utc(si->last_mft_change_time));
+	/*
+	 * Last access to the data within the file. Not changed during a rename
+	 * for example but changed whenever the file is written to.
+	 */
+	inode_set_atime_to_ts(vi, ntfs2utc(si->last_access_time));
+	ni->flags = si->file_attributes;
+
+	/* Find the attribute list attribute if present. */
+	ntfs_attr_reinit_search_ctx(ctx);
+	err = ntfs_attr_lookup(AT_ATTRIBUTE_LIST, NULL, 0, 0, 0, NULL, 0, ctx);
+	if (err) {
+		if (unlikely(err != -ENOENT)) {
+			ntfs_error(vi->i_sb, "Failed to lookup attribute list attribute.");
+			goto unm_err_out;
+		}
+	} else {
+		if (vi->i_ino == FILE_MFT)
+			goto skip_attr_list_load;
+		ntfs_debug("Attribute list found in inode 0x%lx.", vi->i_ino);
+		NInoSetAttrList(ni);
+		a = ctx->attr;
+		if (a->flags & ATTR_COMPRESSION_MASK) {
+			ntfs_error(vi->i_sb,
+				"Attribute list attribute is compressed.");
+			goto unm_err_out;
+		}
+		if (a->flags & ATTR_IS_ENCRYPTED ||
+				a->flags & ATTR_IS_SPARSE) {
+			if (a->non_resident) {
+				ntfs_error(vi->i_sb,
+					"Non-resident attribute list attribute is encrypted/sparse.");
+				goto unm_err_out;
+			}
+			ntfs_warning(vi->i_sb,
+				"Resident attribute list attribute in inode 0x%lx is marked encrypted/sparse which is not true.  However, Windows allows this and chkdsk does not detect or correct it so we will just ignore the invalid flags and pretend they are not set.",
+				vi->i_ino);
+		}
+		/* Now allocate memory for the attribute list. */
+		ni->attr_list_size = (u32)ntfs_attr_size(a);
+		if (!ni->attr_list_size) {
+			ntfs_error(vi->i_sb, "Attr_list_size is zero");
+			goto unm_err_out;
+		}
+		ni->attr_list = ntfs_malloc_nofs(ni->attr_list_size);
+		if (!ni->attr_list) {
+			ntfs_error(vi->i_sb,
+				"Not enough memory to allocate buffer for attribute list.");
+			err = -ENOMEM;
+			goto unm_err_out;
+		}
+		if (a->non_resident) {
+			NInoSetAttrListNonResident(ni);
+			if (a->data.non_resident.lowest_vcn) {
+				ntfs_error(vi->i_sb, "Attribute list has non zero lowest_vcn.");
+				goto unm_err_out;
+			}
+
+			/* Now load the attribute list. */
+			err = load_attribute_list(ni, ni->attr_list, ni->attr_list_size);
+			if (err) {
+				ntfs_error(vi->i_sb, "Failed to load attribute list attribute.");
+				goto unm_err_out;
+			}
+		} else /* if (!a->non_resident) */ {
+			if ((u8 *)a + le16_to_cpu(a->data.resident.value_offset)
+					+ le32_to_cpu(
+					a->data.resident.value_length) >
+					(u8 *)ctx->mrec + vol->mft_record_size) {
+				ntfs_error(vi->i_sb, "Corrupt attribute list in inode.");
+				goto unm_err_out;
+			}
+			/* Now copy the attribute list. */
+			memcpy(ni->attr_list, (u8 *)a + le16_to_cpu(
+					a->data.resident.value_offset),
+					le32_to_cpu(
+					a->data.resident.value_length));
+		}
+	}
+skip_attr_list_load:
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
+	/*
+	 * If an attribute list is present we now have the attribute list value
+	 * in ntfs_ino->attr_list and it is ntfs_ino->attr_list_size bytes.
+	 */
+	if (S_ISDIR(vi->i_mode)) {
+		struct index_root *ir;
+		u8 *ir_end, *index_end;
+
+view_index_meta:
+		/* It is a directory, find index root attribute. */
+		ntfs_attr_reinit_search_ctx(ctx);
+		err = ntfs_attr_lookup(AT_INDEX_ROOT, name, name_len, CASE_SENSITIVE,
+				0, NULL, 0, ctx);
+		if (unlikely(err)) {
+			if (err == -ENOENT)
+				ntfs_error(vi->i_sb, "$INDEX_ROOT attribute is missing.");
+			goto unm_err_out;
+		}
+		a = ctx->attr;
+		/* Set up the state. */
+		if (unlikely(a->non_resident)) {
+			ntfs_error(vol->sb,
+				"$INDEX_ROOT attribute is not resident.");
+			goto unm_err_out;
+		}
+		/* Ensure the attribute name is placed before the value. */
+		if (unlikely(a->name_length && (le16_to_cpu(a->name_offset) >=
+				le16_to_cpu(a->data.resident.value_offset)))) {
+			ntfs_error(vol->sb,
+				"$INDEX_ROOT attribute name is placed after the attribute value.");
+			goto unm_err_out;
+		}
+		/*
+		 * Compressed/encrypted index root just means that the newly
+		 * created files in that directory should be created compressed/
+		 * encrypted. However index root cannot be both compressed and
+		 * encrypted.
+		 */
+		if (a->flags & ATTR_COMPRESSION_MASK) {
+			NInoSetCompressed(ni);
+			ni->flags |= FILE_ATTR_COMPRESSED;
+		}
+		if (a->flags & ATTR_IS_ENCRYPTED) {
+			if (a->flags & ATTR_COMPRESSION_MASK) {
+				ntfs_error(vi->i_sb, "Found encrypted and compressed attribute.");
+				goto unm_err_out;
+			}
+			NInoSetEncrypted(ni);
+			ni->flags |= FILE_ATTR_ENCRYPTED;
+		}
+		if (a->flags & ATTR_IS_SPARSE) {
+			NInoSetSparse(ni);
+			ni->flags |= FILE_ATTR_SPARSE_FILE;
+		}
+		ir = (struct index_root *)((u8 *)a +
+				le16_to_cpu(a->data.resident.value_offset));
+		ir_end = (u8 *)ir + le32_to_cpu(a->data.resident.value_length);
+		if (ir_end > (u8 *)ctx->mrec + vol->mft_record_size) {
+			ntfs_error(vi->i_sb, "$INDEX_ROOT attribute is corrupt.");
+			goto unm_err_out;
+		}
+		index_end = (u8 *)&ir->index +
+				le32_to_cpu(ir->index.index_length);
+		if (index_end > ir_end) {
+			ntfs_error(vi->i_sb, "Directory index is corrupt.");
+			goto unm_err_out;
+		}
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
+		}
+
+		ni->itype.index.collation_rule = ir->collation_rule;
+		ni->itype.index.block_size = le32_to_cpu(ir->index_block_size);
+		if (ni->itype.index.block_size &
+				(ni->itype.index.block_size - 1)) {
+			ntfs_error(vi->i_sb, "Index block size (%u) is not a power of two.",
+					ni->itype.index.block_size);
+			goto unm_err_out;
+		}
+		if (ni->itype.index.block_size > PAGE_SIZE) {
+			ntfs_error(vi->i_sb,
+				"Index block size (%u) > PAGE_SIZE (%ld) is not supported.",
+				ni->itype.index.block_size,
+				PAGE_SIZE);
+			err = -EOPNOTSUPP;
+			goto unm_err_out;
+		}
+		if (ni->itype.index.block_size < NTFS_BLOCK_SIZE) {
+			ntfs_error(vi->i_sb,
+				"Index block size (%u) < NTFS_BLOCK_SIZE (%i) is not supported.",
+				ni->itype.index.block_size,
+				NTFS_BLOCK_SIZE);
+			err = -EOPNOTSUPP;
+			goto unm_err_out;
+		}
+		ni->itype.index.block_size_bits =
+				ffs(ni->itype.index.block_size) - 1;
+		/* Determine the size of a vcn in the directory index. */
+		if (vol->cluster_size <= ni->itype.index.block_size) {
+			ni->itype.index.vcn_size = vol->cluster_size;
+			ni->itype.index.vcn_size_bits = vol->cluster_size_bits;
+		} else {
+			ni->itype.index.vcn_size = vol->sector_size;
+			ni->itype.index.vcn_size_bits = vol->sector_size_bits;
+		}
+
+		/* Setup the index allocation attribute, even if not present. */
+		ni->type = AT_INDEX_ROOT;
+		ni->name = name;
+		ni->name_len = name_len;
+		vi->i_size = ni->initialized_size = ni->data_size =
+			le32_to_cpu(a->data.resident.value_length);
+		ni->allocated_size = (ni->data_size + 7) & ~7;
+		/* We are done with the mft record, so we release it. */
+		ntfs_attr_put_search_ctx(ctx);
+		unmap_mft_record(ni);
+		m = NULL;
+		ctx = NULL;
+		/* Setup the operations for this inode. */
+		ntfs_set_vfs_operations(vi, S_IFDIR, 0);
+		if (ir->index.flags & LARGE_INDEX)
+			NInoSetIndexAllocPresent(ni);
+	} else {
+		/* It is a file. */
+		ntfs_attr_reinit_search_ctx(ctx);
+
+		/* Setup the data attribute, even if not present. */
+		ni->type = AT_DATA;
+		ni->name = AT_UNNAMED;
+		ni->name_len = 0;
+
+		/* Find first extent of the unnamed data attribute. */
+		err = ntfs_attr_lookup(AT_DATA, NULL, 0, 0, 0, NULL, 0, ctx);
+		if (unlikely(err)) {
+			vi->i_size = ni->initialized_size =
+					ni->allocated_size = 0;
+			if (err != -ENOENT) {
+				ntfs_error(vi->i_sb, "Failed to lookup $DATA attribute.");
+				goto unm_err_out;
+			}
+			/*
+			 * FILE_Secure does not have an unnamed $DATA
+			 * attribute, so we special case it here.
+			 */
+			if (vi->i_ino == FILE_Secure)
+				goto no_data_attr_special_case;
+			/*
+			 * Most if not all the system files in the $Extend
+			 * system directory do not have unnamed data
+			 * attributes so we need to check if the parent
+			 * directory of the file is FILE_Extend and if it is
+			 * ignore this error. To do this we need to get the
+			 * name of this inode from the mft record as the name
+			 * contains the back reference to the parent directory.
+			 */
+			extend_sys = ntfs_is_extended_system_file(ctx);
+			if (extend_sys > 0) {
+				if (m->flags & MFT_RECORD_IS_VIEW_INDEX &&
+				    extend_sys == 2) {
+					name = R;
+					name_len = 2;
+					goto view_index_meta;
+				}
+				goto no_data_attr_special_case;
+			}
+
+			err = extend_sys;
+			ntfs_error(vi->i_sb, "$DATA attribute is missing, err : %d", err);
+			goto unm_err_out;
+		}
+		a = ctx->attr;
+		/* Setup the state. */
+		if (a->flags & (ATTR_COMPRESSION_MASK | ATTR_IS_SPARSE)) {
+			if (a->flags & ATTR_COMPRESSION_MASK) {
+				NInoSetCompressed(ni);
+				ni->flags |= FILE_ATTR_COMPRESSED;
+				if (vol->cluster_size > 4096) {
+					ntfs_error(vi->i_sb,
+						"Found compressed data but compression is disabled due to cluster size (%i) > 4kiB.",
+						vol->cluster_size);
+					goto unm_err_out;
+				}
+				if ((a->flags & ATTR_COMPRESSION_MASK)
+						!= ATTR_IS_COMPRESSED) {
+					ntfs_error(vi->i_sb,
+						"Found unknown compression method or corrupt file.");
+					goto unm_err_out;
+				}
+			}
+			if (a->flags & ATTR_IS_SPARSE) {
+				NInoSetSparse(ni);
+				ni->flags |= FILE_ATTR_SPARSE_FILE;
+			}
+		}
+		if (a->flags & ATTR_IS_ENCRYPTED) {
+			if (NInoCompressed(ni)) {
+				ntfs_error(vi->i_sb, "Found encrypted and compressed data.");
+				goto unm_err_out;
+			}
+			NInoSetEncrypted(ni);
+			ni->flags |= FILE_ATTR_ENCRYPTED;
+		}
+		if (a->non_resident) {
+			NInoSetNonResident(ni);
+			if (NInoCompressed(ni) || NInoSparse(ni)) {
+				if (NInoCompressed(ni) &&
+				    a->data.non_resident.compression_unit != 4) {
+					ntfs_error(vi->i_sb,
+						"Found non-standard compression unit (%u instead of 4).  Cannot handle this.",
+						a->data.non_resident.compression_unit);
+					err = -EOPNOTSUPP;
+					goto unm_err_out;
+				}
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
+				if (a->data.non_resident.compression_unit) {
+					ni->itype.compressed.block_size = 1U <<
+							(a->data.non_resident.compression_unit +
+							vol->cluster_size_bits);
+					ni->itype.compressed.block_size_bits =
+							ffs(ni->itype.compressed.block_size) - 1;
+					ni->itype.compressed.block_clusters =
+							1U << a->data.non_resident.compression_unit;
+				} else {
+					ni->itype.compressed.block_size = 0;
+					ni->itype.compressed.block_size_bits =
+							0;
+					ni->itype.compressed.block_clusters =
+							0;
+				}
+				ni->itype.compressed.size = le64_to_cpu(
+						a->data.non_resident.compressed_size);
+			}
+			if (a->data.non_resident.lowest_vcn) {
+				ntfs_error(vi->i_sb,
+					"First extent of $DATA attribute has non zero lowest_vcn.");
+				goto unm_err_out;
+			}
+			vi->i_size = ni->data_size = le64_to_cpu(a->data.non_resident.data_size);
+			ni->initialized_size = le64_to_cpu(a->data.non_resident.initialized_size);
+			ni->allocated_size = le64_to_cpu(a->data.non_resident.allocated_size);
+		} else { /* Resident attribute. */
+			vi->i_size = ni->data_size = ni->initialized_size = le32_to_cpu(
+					a->data.resident.value_length);
+			ni->allocated_size = le32_to_cpu(a->length) -
+					le16_to_cpu(
+					a->data.resident.value_offset);
+			if (vi->i_size > ni->allocated_size) {
+				ntfs_error(vi->i_sb,
+					"Resident data attribute is corrupt (size exceeds allocation).");
+				goto unm_err_out;
+			}
+		}
+no_data_attr_special_case:
+		/* We are done with the mft record, so we release it. */
+		ntfs_attr_put_search_ctx(ctx);
+		unmap_mft_record(ni);
+		m = NULL;
+		ctx = NULL;
+		/* Setup the operations for this inode. */
+		ntfs_set_vfs_operations(vi, vi->i_mode, dev);
+	}
+	/*
+	 * The number of 512-byte blocks used on disk (for stat). This is in so
+	 * far inaccurate as it doesn't account for any named streams or other
+	 * special non-resident attributes, but that is how Windows works, too,
+	 * so we are at least consistent with Windows, if not entirely
+	 * consistent with the Linux Way. Doing it the Linux Way would cause a
+	 * significant slowdown as it would involve iterating over all
+	 * attributes in the mft record and adding the allocated/compressed
+	 * sizes of all non-resident attributes present to give us the Linux
+	 * correct size that should go into i_blocks (after division by 512).
+	 */
+	if (S_ISREG(vi->i_mode) && (NInoCompressed(ni) || NInoSparse(ni)))
+		vi->i_blocks = ni->itype.compressed.size >> 9;
+	else
+		vi->i_blocks = ni->allocated_size >> 9;
+
+	ntfs_debug("Done.");
+	return 0;
+unm_err_out:
+	if (!err)
+		err = -EIO;
+	if (ctx)
+		ntfs_attr_put_search_ctx(ctx);
+	if (m)
+		unmap_mft_record(ni);
+err_out:
+	if (err != -EOPNOTSUPP && err != -ENOMEM && vol_err == true) {
+		ntfs_error(vol->sb,
+			"Failed with error code %i.  Marking corrupt inode 0x%lx as bad.  Run chkdsk.",
+			err, vi->i_ino);
+		NVolSetErrors(vol);
+	}
+	return err;
+}
+
+/**
+ * ntfs_read_locked_attr_inode - read an attribute inode from its base inode
+ * @base_vi:	base inode
+ * @vi:		attribute inode to read
+ *
+ * ntfs_read_locked_attr_inode() is called from ntfs_attr_iget() to read the
+ * attribute inode described by @vi into memory from the base mft record
+ * described by @base_ni.
+ *
+ * ntfs_read_locked_attr_inode() maps, pins and locks the base inode for
+ * reading and looks up the attribute described by @vi before setting up the
+ * necessary fields in @vi as well as initializing the ntfs inode.
+ *
+ * Q: What locks are held when the function is called?
+ * A: i_state has I_NEW set, hence the inode is locked, also
+ *    i_count is set to 1, so it is not going to go away
+ *
+ * Return 0 on success and -errno on error.
+ *
+ * Note this cannot be called for AT_INDEX_ALLOCATION.
+ */
+static int ntfs_read_locked_attr_inode(struct inode *base_vi, struct inode *vi)
+{
+	struct ntfs_volume *vol = NTFS_SB(vi->i_sb);
+	struct ntfs_inode *ni = NTFS_I(vi), *base_ni = NTFS_I(base_vi);
+	struct mft_record *m;
+	struct attr_record *a;
+	struct ntfs_attr_search_ctx *ctx;
+	int err = 0;
+
+	ntfs_debug("Entering for i_ino 0x%lx.", vi->i_ino);
+
+	ntfs_init_big_inode(vi);
+
+	/* Just mirror the values from the base inode. */
+	vi->i_uid	= base_vi->i_uid;
+	vi->i_gid	= base_vi->i_gid;
+	set_nlink(vi, base_vi->i_nlink);
+	inode_set_mtime_to_ts(vi, inode_get_mtime(base_vi));
+	inode_set_ctime_to_ts(vi, inode_get_ctime(base_vi));
+	inode_set_atime_to_ts(vi, inode_get_atime(base_vi));
+	vi->i_generation = ni->seq_no = base_ni->seq_no;
+
+	/* Set inode type to zero but preserve permissions. */
+	vi->i_mode	= base_vi->i_mode & ~S_IFMT;
+
+	m = map_mft_record(base_ni);
+	if (IS_ERR(m)) {
+		err = PTR_ERR(m);
+		goto err_out;
+	}
+	ctx = ntfs_attr_get_search_ctx(base_ni, m);
+	if (!ctx) {
+		err = -ENOMEM;
+		goto unm_err_out;
+	}
+	/* Find the attribute. */
+	err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
+			CASE_SENSITIVE, 0, NULL, 0, ctx);
+	if (unlikely(err))
+		goto unm_err_out;
+	a = ctx->attr;
+	if (a->flags & (ATTR_COMPRESSION_MASK | ATTR_IS_SPARSE)) {
+		if (a->flags & ATTR_COMPRESSION_MASK) {
+			NInoSetCompressed(ni);
+			ni->flags |= FILE_ATTR_COMPRESSED;
+			if ((ni->type != AT_DATA) || (ni->type == AT_DATA &&
+					ni->name_len)) {
+				ntfs_error(vi->i_sb,
+					   "Found compressed non-data or named data attribute.");
+				goto unm_err_out;
+			}
+			if (vol->cluster_size > 4096) {
+				ntfs_error(vi->i_sb,
+					"Found compressed attribute but compression is disabled due to cluster size (%i) > 4kiB.",
+					vol->cluster_size);
+				goto unm_err_out;
+			}
+			if ((a->flags & ATTR_COMPRESSION_MASK) !=
+					ATTR_IS_COMPRESSED) {
+				ntfs_error(vi->i_sb, "Found unknown compression method.");
+				goto unm_err_out;
+			}
+		}
+		/*
+		 * The compressed/sparse flag set in an index root just means
+		 * to compress all files.
+		 */
+		if (NInoMstProtected(ni) && ni->type != AT_INDEX_ROOT) {
+			ntfs_error(vi->i_sb,
+				"Found mst protected attribute but the attribute is %s.",
+				NInoCompressed(ni) ? "compressed" : "sparse");
+			goto unm_err_out;
+		}
+		if (a->flags & ATTR_IS_SPARSE) {
+			NInoSetSparse(ni);
+			ni->flags |= FILE_ATTR_SPARSE_FILE;
+		}
+	}
+	if (a->flags & ATTR_IS_ENCRYPTED) {
+		if (NInoCompressed(ni)) {
+			ntfs_error(vi->i_sb, "Found encrypted and compressed data.");
+			goto unm_err_out;
+		}
+		/*
+		 * The encryption flag set in an index root just means to
+		 * encrypt all files.
+		 */
+		if (NInoMstProtected(ni) && ni->type != AT_INDEX_ROOT) {
+			ntfs_error(vi->i_sb,
+				"Found mst protected attribute but the attribute is encrypted.");
+			goto unm_err_out;
+		}
+		if (ni->type != AT_DATA) {
+			ntfs_error(vi->i_sb,
+				"Found encrypted non-data attribute.");
+			goto unm_err_out;
+		}
+		NInoSetEncrypted(ni);
+		ni->flags |= FILE_ATTR_ENCRYPTED;
+	}
+	if (!a->non_resident) {
+		/* Ensure the attribute name is placed before the value. */
+		if (unlikely(a->name_length && (le16_to_cpu(a->name_offset) >=
+				le16_to_cpu(a->data.resident.value_offset)))) {
+			ntfs_error(vol->sb,
+				"Attribute name is placed after the attribute value.");
+			goto unm_err_out;
+		}
+		if (NInoMstProtected(ni)) {
+			ntfs_error(vi->i_sb,
+				"Found mst protected attribute but the attribute is resident.");
+			goto unm_err_out;
+		}
+		vi->i_size = ni->initialized_size = ni->data_size = le32_to_cpu(
+				a->data.resident.value_length);
+		ni->allocated_size = le32_to_cpu(a->length) -
+				le16_to_cpu(a->data.resident.value_offset);
+		if (vi->i_size > ni->allocated_size) {
+			ntfs_error(vi->i_sb,
+				"Resident attribute is corrupt (size exceeds allocation).");
+			goto unm_err_out;
+		}
+	} else {
+		NInoSetNonResident(ni);
+		/*
+		 * Ensure the attribute name is placed before the mapping pairs
+		 * array.
+		 */
+		if (unlikely(a->name_length && (le16_to_cpu(a->name_offset) >=
+				le16_to_cpu(
+				a->data.non_resident.mapping_pairs_offset)))) {
+			ntfs_error(vol->sb,
+				"Attribute name is placed after the mapping pairs array.");
+			goto unm_err_out;
+		}
+		if (NInoCompressed(ni) || NInoSparse(ni)) {
+			if (NInoCompressed(ni) && a->data.non_resident.compression_unit != 4) {
+				ntfs_error(vi->i_sb,
+					"Found non-standard compression unit (%u instead of 4).  Cannot handle this.",
+					a->data.non_resident.compression_unit);
+				err = -EOPNOTSUPP;
+				goto unm_err_out;
+			}
+			if (a->data.non_resident.compression_unit) {
+				ni->itype.compressed.block_size = 1U <<
+						(a->data.non_resident.compression_unit +
+						vol->cluster_size_bits);
+				ni->itype.compressed.block_size_bits =
+						ffs(ni->itype.compressed.block_size) - 1;
+				ni->itype.compressed.block_clusters = 1U <<
+						a->data.non_resident.compression_unit;
+			} else {
+				ni->itype.compressed.block_size = 0;
+				ni->itype.compressed.block_size_bits = 0;
+				ni->itype.compressed.block_clusters = 0;
+			}
+			ni->itype.compressed.size = le64_to_cpu(
+					a->data.non_resident.compressed_size);
+		}
+		if (a->data.non_resident.lowest_vcn) {
+			ntfs_error(vi->i_sb, "First extent of attribute has non-zero lowest_vcn.");
+			goto unm_err_out;
+		}
+		vi->i_size = ni->data_size = le64_to_cpu(a->data.non_resident.data_size);
+		ni->initialized_size = le64_to_cpu(a->data.non_resident.initialized_size);
+		ni->allocated_size = le64_to_cpu(a->data.non_resident.allocated_size);
+	}
+	vi->i_mapping->a_ops = &ntfs_normal_aops;
+	if (NInoMstProtected(ni))
+		vi->i_mapping->a_ops = &ntfs_mst_aops;
+	else if (NInoCompressed(ni))
+		vi->i_mapping->a_ops = &ntfs_compressed_aops;
+	if ((NInoCompressed(ni) || NInoSparse(ni)) && ni->type != AT_INDEX_ROOT)
+		vi->i_blocks = ni->itype.compressed.size >> 9;
+	else
+		vi->i_blocks = ni->allocated_size >> 9;
+	/*
+	 * Make sure the base inode does not go away and attach it to the
+	 * attribute inode.
+	 */
+	if (!igrab(base_vi)) {
+		err = -ENOENT;
+		goto unm_err_out;
+	}
+	ni->ext.base_ntfs_ino = base_ni;
+	ni->nr_extents = -1;
+
+	ntfs_attr_put_search_ctx(ctx);
+	unmap_mft_record(base_ni);
+
+	ntfs_debug("Done.");
+	return 0;
+
+unm_err_out:
+	if (!err)
+		err = -EIO;
+	if (ctx)
+		ntfs_attr_put_search_ctx(ctx);
+	unmap_mft_record(base_ni);
+err_out:
+	if (err != -ENOENT)
+		ntfs_error(vol->sb,
+			"Failed with error code %i while reading attribute inode (mft_no 0x%lx, type 0x%x, name_len %i).  Marking corrupt inode and base inode 0x%lx as bad.  Run chkdsk.",
+			err, vi->i_ino, ni->type, ni->name_len,
+			base_vi->i_ino);
+	if (err != -ENOENT && err != -ENOMEM)
+		NVolSetErrors(vol);
+	return err;
+}
+
+/**
+ * ntfs_read_locked_index_inode - read an index inode from its base inode
+ * @base_vi:	base inode
+ * @vi:		index inode to read
+ *
+ * ntfs_read_locked_index_inode() is called from ntfs_index_iget() to read the
+ * index inode described by @vi into memory from the base mft record described
+ * by @base_ni.
+ *
+ * ntfs_read_locked_index_inode() maps, pins and locks the base inode for
+ * reading and looks up the attributes relating to the index described by @vi
+ * before setting up the necessary fields in @vi as well as initializing the
+ * ntfs inode.
+ *
+ * Note, index inodes are essentially attribute inodes (NInoAttr() is true)
+ * with the attribute type set to AT_INDEX_ALLOCATION.  Apart from that, they
+ * are setup like directory inodes since directories are a special case of
+ * indices ao they need to be treated in much the same way.  Most importantly,
+ * for small indices the index allocation attribute might not actually exist.
+ * However, the index root attribute always exists but this does not need to
+ * have an inode associated with it and this is why we define a new inode type
+ * index.  Also, like for directories, we need to have an attribute inode for
+ * the bitmap attribute corresponding to the index allocation attribute and we
+ * can store this in the appropriate field of the inode, just like we do for
+ * normal directory inodes.
+ *
+ * Q: What locks are held when the function is called?
+ * A: i_state has I_NEW set, hence the inode is locked, also
+ *    i_count is set to 1, so it is not going to go away
+ *
+ * Return 0 on success and -errno on error.
+ */
+static int ntfs_read_locked_index_inode(struct inode *base_vi, struct inode *vi)
+{
+	loff_t bvi_size;
+	struct ntfs_volume *vol = NTFS_SB(vi->i_sb);
+	struct ntfs_inode *ni = NTFS_I(vi), *base_ni = NTFS_I(base_vi), *bni;
+	struct inode *bvi;
+	struct mft_record *m;
+	struct attr_record *a;
+	struct ntfs_attr_search_ctx *ctx;
+	struct index_root *ir;
+	u8 *ir_end, *index_end;
+	int err = 0;
+
+	ntfs_debug("Entering for i_ino 0x%lx.", vi->i_ino);
+	lockdep_assert_held(&base_ni->mrec_lock);
+
+	ntfs_init_big_inode(vi);
+	/* Just mirror the values from the base inode. */
+	vi->i_uid	= base_vi->i_uid;
+	vi->i_gid	= base_vi->i_gid;
+	set_nlink(vi, base_vi->i_nlink);
+	inode_set_mtime_to_ts(vi, inode_get_mtime(base_vi));
+	inode_set_ctime_to_ts(vi, inode_get_ctime(base_vi));
+	inode_set_atime_to_ts(vi, inode_get_atime(base_vi));
+	vi->i_generation = ni->seq_no = base_ni->seq_no;
+	/* Set inode type to zero but preserve permissions. */
+	vi->i_mode	= base_vi->i_mode & ~S_IFMT;
+	/* Map the mft record for the base inode. */
+	m = map_mft_record(base_ni);
+	if (IS_ERR(m)) {
+		err = PTR_ERR(m);
+		goto err_out;
+	}
+	ctx = ntfs_attr_get_search_ctx(base_ni, m);
+	if (!ctx) {
+		err = -ENOMEM;
+		goto unm_err_out;
+	}
+	/* Find the index root attribute. */
+	err = ntfs_attr_lookup(AT_INDEX_ROOT, ni->name, ni->name_len,
+			CASE_SENSITIVE, 0, NULL, 0, ctx);
+	if (unlikely(err)) {
+		if (err == -ENOENT)
+			ntfs_error(vi->i_sb, "$INDEX_ROOT attribute is missing.");
+		goto unm_err_out;
+	}
+	a = ctx->attr;
+	/* Set up the state. */
+	if (unlikely(a->non_resident)) {
+		ntfs_error(vol->sb, "$INDEX_ROOT attribute is not resident.");
+		goto unm_err_out;
+	}
+	/* Ensure the attribute name is placed before the value. */
+	if (unlikely(a->name_length && (le16_to_cpu(a->name_offset) >=
+			le16_to_cpu(a->data.resident.value_offset)))) {
+		ntfs_error(vol->sb,
+			"$INDEX_ROOT attribute name is placed after the attribute value.");
+		goto unm_err_out;
+	}
+
+	ir = (struct index_root *)((u8 *)a + le16_to_cpu(a->data.resident.value_offset));
+	ir_end = (u8 *)ir + le32_to_cpu(a->data.resident.value_length);
+	if (ir_end > (u8 *)ctx->mrec + vol->mft_record_size) {
+		ntfs_error(vi->i_sb, "$INDEX_ROOT attribute is corrupt.");
+		goto unm_err_out;
+	}
+	index_end = (u8 *)&ir->index + le32_to_cpu(ir->index.index_length);
+	if (index_end > ir_end) {
+		ntfs_error(vi->i_sb, "Index is corrupt.");
+		goto unm_err_out;
+	}
+
+	ni->itype.index.collation_rule = ir->collation_rule;
+	ntfs_debug("Index collation rule is 0x%x.",
+			le32_to_cpu(ir->collation_rule));
+	ni->itype.index.block_size = le32_to_cpu(ir->index_block_size);
+	if (!is_power_of_2(ni->itype.index.block_size)) {
+		ntfs_error(vi->i_sb, "Index block size (%u) is not a power of two.",
+				ni->itype.index.block_size);
+		goto unm_err_out;
+	}
+	if (ni->itype.index.block_size > PAGE_SIZE) {
+		ntfs_error(vi->i_sb, "Index block size (%u) > PAGE_SIZE (%ld) is not supported.",
+				ni->itype.index.block_size, PAGE_SIZE);
+		err = -EOPNOTSUPP;
+		goto unm_err_out;
+	}
+	if (ni->itype.index.block_size < NTFS_BLOCK_SIZE) {
+		ntfs_error(vi->i_sb,
+				"Index block size (%u) < NTFS_BLOCK_SIZE (%i) is not supported.",
+				ni->itype.index.block_size, NTFS_BLOCK_SIZE);
+		err = -EOPNOTSUPP;
+		goto unm_err_out;
+	}
+	ni->itype.index.block_size_bits = ffs(ni->itype.index.block_size) - 1;
+	/* Determine the size of a vcn in the index. */
+	if (vol->cluster_size <= ni->itype.index.block_size) {
+		ni->itype.index.vcn_size = vol->cluster_size;
+		ni->itype.index.vcn_size_bits = vol->cluster_size_bits;
+	} else {
+		ni->itype.index.vcn_size = vol->sector_size;
+		ni->itype.index.vcn_size_bits = vol->sector_size_bits;
+	}
+
+	/* Find index allocation attribute. */
+	ntfs_attr_reinit_search_ctx(ctx);
+	err = ntfs_attr_lookup(AT_INDEX_ALLOCATION, ni->name, ni->name_len,
+			CASE_SENSITIVE, 0, NULL, 0, ctx);
+	if (unlikely(err)) {
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
+		goto unm_err_out;
+	}
+	NInoSetIndexAllocPresent(ni);
+	NInoSetNonResident(ni);
+	ni->type = AT_INDEX_ALLOCATION;
+
+	a = ctx->attr;
+	if (!a->non_resident) {
+		ntfs_error(vi->i_sb, "$INDEX_ALLOCATION attribute is resident.");
+		goto unm_err_out;
+	}
+	/*
+	 * Ensure the attribute name is placed before the mapping pairs array.
+	 */
+	if (unlikely(a->name_length && (le16_to_cpu(a->name_offset) >=
+			le16_to_cpu(a->data.non_resident.mapping_pairs_offset)))) {
+		ntfs_error(vol->sb,
+			"$INDEX_ALLOCATION attribute name is placed after the mapping pairs array.");
+		goto unm_err_out;
+	}
+	if (a->flags & ATTR_IS_ENCRYPTED) {
+		ntfs_error(vi->i_sb, "$INDEX_ALLOCATION attribute is encrypted.");
+		goto unm_err_out;
+	}
+	if (a->flags & ATTR_IS_SPARSE) {
+		ntfs_error(vi->i_sb, "$INDEX_ALLOCATION attribute is sparse.");
+		goto unm_err_out;
+	}
+	if (a->flags & ATTR_COMPRESSION_MASK) {
+		ntfs_error(vi->i_sb,
+			"$INDEX_ALLOCATION attribute is compressed.");
+		goto unm_err_out;
+	}
+	if (a->data.non_resident.lowest_vcn) {
+		ntfs_error(vi->i_sb,
+			"First extent of $INDEX_ALLOCATION attribute has non zero lowest_vcn.");
+		goto unm_err_out;
+	}
+	vi->i_size = ni->data_size = le64_to_cpu(a->data.non_resident.data_size);
+	ni->initialized_size = le64_to_cpu(a->data.non_resident.initialized_size);
+	ni->allocated_size = le64_to_cpu(a->data.non_resident.allocated_size);
+	/*
+	 * We are done with the mft record, so we release it.  Otherwise
+	 * we would deadlock in ntfs_attr_iget().
+	 */
+	ntfs_attr_put_search_ctx(ctx);
+	unmap_mft_record(base_ni);
+	m = NULL;
+	ctx = NULL;
+	/* Get the index bitmap attribute inode. */
+	bvi = ntfs_attr_iget(base_vi, AT_BITMAP, ni->name, ni->name_len);
+	if (IS_ERR(bvi)) {
+		ntfs_error(vi->i_sb, "Failed to get bitmap attribute.");
+		err = PTR_ERR(bvi);
+		goto unm_err_out;
+	}
+	bni = NTFS_I(bvi);
+	if (NInoCompressed(bni) || NInoEncrypted(bni) ||
+			NInoSparse(bni)) {
+		ntfs_error(vi->i_sb,
+			"$BITMAP attribute is compressed and/or encrypted and/or sparse.");
+		goto iput_unm_err_out;
+	}
+	/* Consistency check bitmap size vs. index allocation size. */
+	bvi_size = i_size_read(bvi);
+	if ((bvi_size << 3) < (vi->i_size >> ni->itype.index.block_size_bits)) {
+		ntfs_error(vi->i_sb,
+			"Index bitmap too small (0x%llx) for index allocation (0x%llx).",
+			bvi_size << 3, vi->i_size);
+		goto iput_unm_err_out;
+	}
+	iput(bvi);
+skip_large_index_stuff:
+	/* Setup the operations for this index inode. */
+	ntfs_set_vfs_operations(vi, S_IFDIR, 0);
+	vi->i_blocks = ni->allocated_size >> 9;
+	/*
+	 * Make sure the base inode doesn't go away and attach it to the
+	 * index inode.
+	 */
+	if (!igrab(base_vi))
+		goto unm_err_out;
+	ni->ext.base_ntfs_ino = base_ni;
+	ni->nr_extents = -1;
+
+	ntfs_debug("Done.");
+	return 0;
+iput_unm_err_out:
+	iput(bvi);
+unm_err_out:
+	if (!err)
+		err = -EIO;
+	if (ctx)
+		ntfs_attr_put_search_ctx(ctx);
+	if (m)
+		unmap_mft_record(base_ni);
+err_out:
+	ntfs_error(vi->i_sb,
+		"Failed with error code %i while reading index inode (mft_no 0x%lx, name_len %i.",
+		err, vi->i_ino, ni->name_len);
+	if (err != -EOPNOTSUPP && err != -ENOMEM)
+		NVolSetErrors(vol);
+	return err;
+}
+
+/**
+ * load_attribute_list_mount - load an attribute list into memory
+ * @vol:		ntfs volume from which to read
+ * @runlist:		runlist of the attribute list
+ * @al_start:		destination buffer
+ * @size:		size of the destination buffer in bytes
+ * @initialized_size:	initialized size of the attribute list
+ *
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
+		rl_byte_off = lcn << vol->cluster_size_bits;
+		rl_byte_len = rl->length << vol->cluster_size_bits;
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
+ * held from within the read_super() code path.
+ *
+ * This function exists because when it is called the page cache for $MFT/$DATA
+ * is not initialized and hence we cannot get at the contents of mft records
+ * by calling map_mft_record*().
+ *
+ * Further it needs to cope with the circular references problem, i.e. cannot
+ * load any attributes other than $ATTRIBUTE_LIST until $DATA is loaded, because
+ * we do not know where the other extent mft records are yet and again, because
+ * we cannot call map_mft_record*() yet.  Obviously this applies only when an
+ * attribute list is actually present in $MFT inode.
+ *
+ * We solve these problems by starting with the $DATA attribute before anything
+ * else and iterating using ntfs_attr_lookup($DATA) over all extents.  As each
+ * extent is found, we ntfs_mapping_pairs_decompress() including the implied
+ * ntfs_runlists_merge().  Each step of the iteration necessarily provides
+ * sufficient information for the next step to complete.
+ *
+ * This should work but there are two possible pit falls (see inline comments
+ * below), but only time will tell if they are real pits or just smoke...
+ */
+int ntfs_read_inode_mount(struct inode *vi)
+{
+	s64 next_vcn, last_vcn, highest_vcn;
+	struct super_block *sb = vi->i_sb;
+	struct ntfs_volume *vol = NTFS_SB(sb);
+	struct ntfs_inode *ni;
+	struct mft_record *m = NULL;
+	struct attr_record *a;
+	struct ntfs_attr_search_ctx *ctx;
+	unsigned int i, nr_blocks;
+	int err;
+	size_t new_rl_count;
+
+	ntfs_debug("Entering.");
+
+	/* Initialize the ntfs specific part of @vi. */
+	ntfs_init_big_inode(vi);
+
+	ni = NTFS_I(vi);
+
+	/* Setup the data attribute. It is special as it is mst protected. */
+	NInoSetNonResident(ni);
+	NInoSetMstProtected(ni);
+	NInoSetSparseDisabled(ni);
+	ni->type = AT_DATA;
+	ni->name = AT_UNNAMED;
+	ni->name_len = 0;
+	/*
+	 * This sets up our little cheat allowing us to reuse the async read io
+	 * completion handler for directories.
+	 */
+	ni->itype.index.block_size = vol->mft_record_size;
+	ni->itype.index.block_size_bits = vol->mft_record_size_bits;
+
+	/* Very important! Needed to be able to call map_mft_record*(). */
+	vol->mft_ino = vi;
+
+	/* Allocate enough memory to read the first mft record. */
+	if (vol->mft_record_size > 64 * 1024) {
+		ntfs_error(sb, "Unsupported mft record size %i (max 64kiB).",
+				vol->mft_record_size);
+		goto err_out;
+	}
+
+	i = vol->mft_record_size;
+	if (i < sb->s_blocksize)
+		i = sb->s_blocksize;
+
+	m = (struct mft_record *)ntfs_malloc_nofs(i);
+	if (!m) {
+		ntfs_error(sb, "Failed to allocate buffer for $MFT record 0.");
+		goto err_out;
+	}
+
+	/* Determine the first block of the $MFT/$DATA attribute. */
+	nr_blocks = vol->mft_record_size >> sb->s_blocksize_bits;
+	if (!nr_blocks)
+		nr_blocks = 1;
+
+	/* Load $MFT/$DATA's first mft record. */
+	err = ntfs_dev_read(sb, m, vol->mft_lcn << vol->cluster_size_bits, i);
+	if (err) {
+		ntfs_error(sb, "Device read failed.");
+		goto err_out;
+	}
+
+	if (le32_to_cpu(m->bytes_allocated) != vol->mft_record_size) {
+		ntfs_error(sb, "Incorrect mft record size %u in superblock, should be %u.",
+				le32_to_cpu(m->bytes_allocated), vol->mft_record_size);
+		goto err_out;
+	}
+
+	/* Apply the mst fixups. */
+	if (post_read_mst_fixup((struct ntfs_record *)m, vol->mft_record_size)) {
+		ntfs_error(sb, "MST fixup failed. $MFT is corrupt.");
+		goto err_out;
+	}
+
+	if (ntfs_mft_record_check(vol, m, FILE_MFT)) {
+		ntfs_error(sb, "ntfs_mft_record_check failed. $MFT is corrupt.");
+		goto err_out;
+	}
+
+	/* Need this to sanity check attribute list references to $MFT. */
+	vi->i_generation = ni->seq_no = le16_to_cpu(m->sequence_number);
+
+	/* Provides read_folio() for map_mft_record(). */
+	vi->i_mapping->a_ops = &ntfs_mst_aops;
+
+	ctx = ntfs_attr_get_search_ctx(ni, m);
+	if (!ctx) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	/* Find the attribute list attribute if present. */
+	err = ntfs_attr_lookup(AT_ATTRIBUTE_LIST, NULL, 0, 0, 0, NULL, 0, ctx);
+	if (err) {
+		if (unlikely(err != -ENOENT)) {
+			ntfs_error(sb,
+				"Failed to lookup attribute list attribute. You should run chkdsk.");
+			goto put_err_out;
+		}
+	} else /* if (!err) */ {
+		struct attr_list_entry *al_entry, *next_al_entry;
+		u8 *al_end;
+		static const char *es = "  Not allowed.  $MFT is corrupt.  You should run chkdsk.";
+
+		ntfs_debug("Attribute list attribute found in $MFT.");
+		NInoSetAttrList(ni);
+		a = ctx->attr;
+		if (a->flags & ATTR_COMPRESSION_MASK) {
+			ntfs_error(sb,
+				"Attribute list attribute is compressed.%s",
+				es);
+			goto put_err_out;
+		}
+		if (a->flags & ATTR_IS_ENCRYPTED ||
+				a->flags & ATTR_IS_SPARSE) {
+			if (a->non_resident) {
+				ntfs_error(sb,
+					"Non-resident attribute list attribute is encrypted/sparse.%s",
+					es);
+				goto put_err_out;
+			}
+			ntfs_warning(sb,
+				"Resident attribute list attribute in $MFT system file is marked encrypted/sparse which is not true.  However, Windows allows this and chkdsk does not detect or correct it so we will just ignore the invalid flags and pretend they are not set.");
+		}
+		/* Now allocate memory for the attribute list. */
+		ni->attr_list_size = (u32)ntfs_attr_size(a);
+		if (!ni->attr_list_size) {
+			ntfs_error(sb, "Attr_list_size is zero");
+			goto put_err_out;
+		}
+		ni->attr_list = ntfs_malloc_nofs(ni->attr_list_size);
+		if (!ni->attr_list) {
+			ntfs_error(sb, "Not enough memory to allocate buffer for attribute list.");
+			goto put_err_out;
+		}
+		if (a->non_resident) {
+			struct runlist_element *rl;
+			size_t new_rl_count;
+
+			NInoSetAttrListNonResident(ni);
+			if (a->data.non_resident.lowest_vcn) {
+				ntfs_error(sb,
+					"Attribute list has non zero lowest_vcn. $MFT is corrupt. You should run chkdsk.");
+				goto put_err_out;
+			}
+
+			rl = ntfs_mapping_pairs_decompress(vol, a, NULL, &new_rl_count);
+			if (IS_ERR(rl)) {
+				err = PTR_ERR(rl);
+				ntfs_error(sb,
+					   "Mapping pairs decompression failed with error code %i.",
+					   -err);
+				goto put_err_out;
+			}
+
+			err = load_attribute_list_mount(vol, rl, ni->attr_list, ni->attr_list_size,
+					le64_to_cpu(a->data.non_resident.initialized_size));
+			ntfs_free(rl);
+			if (err) {
+				ntfs_error(sb,
+					   "Failed to load attribute list with error code %i.",
+					   -err);
+				goto put_err_out;
+			}
+		} else /* if (!ctx.attr->non_resident) */ {
+			if ((u8 *)a + le16_to_cpu(
+					a->data.resident.value_offset) +
+					le32_to_cpu(a->data.resident.value_length) >
+					(u8 *)ctx->mrec + vol->mft_record_size) {
+				ntfs_error(sb, "Corrupt attribute list attribute.");
+				goto put_err_out;
+			}
+			/* Now copy the attribute list. */
+			memcpy(ni->attr_list, (u8 *)a + le16_to_cpu(
+					a->data.resident.value_offset),
+					le32_to_cpu(a->data.resident.value_length));
+		}
+		/* The attribute list is now setup in memory. */
+		al_entry = (struct attr_list_entry *)ni->attr_list;
+		al_end = (u8 *)al_entry + ni->attr_list_size;
+		for (;; al_entry = next_al_entry) {
+			/* Out of bounds check. */
+			if ((u8 *)al_entry < ni->attr_list ||
+					(u8 *)al_entry > al_end)
+				goto em_put_err_out;
+			/* Catch the end of the attribute list. */
+			if ((u8 *)al_entry == al_end)
+				goto em_put_err_out;
+			if (!al_entry->length)
+				goto em_put_err_out;
+			if ((u8 *)al_entry + 6 > al_end ||
+			    (u8 *)al_entry + le16_to_cpu(al_entry->length) > al_end)
+				goto em_put_err_out;
+			next_al_entry = (struct attr_list_entry *)((u8 *)al_entry +
+					le16_to_cpu(al_entry->length));
+			if (le32_to_cpu(al_entry->type) > le32_to_cpu(AT_DATA))
+				goto em_put_err_out;
+			if (al_entry->type != AT_DATA)
+				continue;
+			/* We want an unnamed attribute. */
+			if (al_entry->name_length)
+				goto em_put_err_out;
+			/* Want the first entry, i.e. lowest_vcn == 0. */
+			if (al_entry->lowest_vcn)
+				goto em_put_err_out;
+			/* First entry has to be in the base mft record. */
+			if (MREF_LE(al_entry->mft_reference) != vi->i_ino) {
+				/* MFT references do not match, logic fails. */
+				ntfs_error(sb,
+					"BUG: The first $DATA extent of $MFT is not in the base mft record.");
+				goto put_err_out;
+			} else {
+				/* Sequence numbers must match. */
+				if (MSEQNO_LE(al_entry->mft_reference) !=
+						ni->seq_no)
+					goto em_put_err_out;
+				/* Got it. All is ok. We can stop now. */
+				break;
+			}
+		}
+	}
+
+	ntfs_attr_reinit_search_ctx(ctx);
+
+	/* Now load all attribute extents. */
+	a = NULL;
+	next_vcn = last_vcn = highest_vcn = 0;
+	while (!(err = ntfs_attr_lookup(AT_DATA, NULL, 0, 0, next_vcn, NULL, 0,
+			ctx))) {
+		struct runlist_element *nrl;
+
+		/* Cache the current attribute. */
+		a = ctx->attr;
+		/* $MFT must be non-resident. */
+		if (!a->non_resident) {
+			ntfs_error(sb,
+				"$MFT must be non-resident but a resident extent was found. $MFT is corrupt. Run chkdsk.");
+			goto put_err_out;
+		}
+		/* $MFT must be uncompressed and unencrypted. */
+		if (a->flags & ATTR_COMPRESSION_MASK ||
+				a->flags & ATTR_IS_ENCRYPTED ||
+				a->flags & ATTR_IS_SPARSE) {
+			ntfs_error(sb,
+				"$MFT must be uncompressed, non-sparse, and unencrypted but a compressed/sparse/encrypted extent was found. $MFT is corrupt. Run chkdsk.");
+			goto put_err_out;
+		}
+		/*
+		 * Decompress the mapping pairs array of this extent and merge
+		 * the result into the existing runlist. No need for locking
+		 * as we have exclusive access to the inode at this time and we
+		 * are a mount in progress task, too.
+		 */
+		nrl = ntfs_mapping_pairs_decompress(vol, a, &ni->runlist,
+						    &new_rl_count);
+		if (IS_ERR(nrl)) {
+			ntfs_error(sb,
+				"ntfs_mapping_pairs_decompress() failed with error code %ld.",
+				PTR_ERR(nrl));
+			goto put_err_out;
+		}
+		ni->runlist.rl = nrl;
+		ni->runlist.count = new_rl_count;
+
+		/* Are we in the first extent? */
+		if (!next_vcn) {
+			if (a->data.non_resident.lowest_vcn) {
+				ntfs_error(sb,
+					"First extent of $DATA attribute has non zero lowest_vcn. $MFT is corrupt. You should run chkdsk.");
+				goto put_err_out;
+			}
+			/* Get the last vcn in the $DATA attribute. */
+			last_vcn = le64_to_cpu(a->data.non_resident.allocated_size) >>
+				vol->cluster_size_bits;
+			/* Fill in the inode size. */
+			vi->i_size = le64_to_cpu(a->data.non_resident.data_size);
+			ni->initialized_size = le64_to_cpu(a->data.non_resident.initialized_size);
+			ni->allocated_size = le64_to_cpu(a->data.non_resident.allocated_size);
+			/*
+			 * Verify the number of mft records does not exceed
+			 * 2^32 - 1.
+			 */
+			if ((vi->i_size >> vol->mft_record_size_bits) >=
+					(1ULL << 32)) {
+				ntfs_error(sb, "$MFT is too big! Aborting.");
+				goto put_err_out;
+			}
+			/*
+			 * We have got the first extent of the runlist for
+			 * $MFT which means it is now relatively safe to call
+			 * the normal ntfs_read_inode() function.
+			 * Complete reading the inode, this will actually
+			 * re-read the mft record for $MFT, this time entering
+			 * it into the page cache with which we complete the
+			 * kick start of the volume. It should be safe to do
+			 * this now as the first extent of $MFT/$DATA is
+			 * already known and we would hope that we don't need
+			 * further extents in order to find the other
+			 * attributes belonging to $MFT. Only time will tell if
+			 * this is really the case. If not we will have to play
+			 * magic at this point, possibly duplicating a lot of
+			 * ntfs_read_inode() at this point. We will need to
+			 * ensure we do enough of its work to be able to call
+			 * ntfs_read_inode() on extents of $MFT/$DATA. But lets
+			 * hope this never happens...
+			 */
+			err = ntfs_read_locked_inode(vi);
+			if (err) {
+				ntfs_error(sb, "ntfs_read_inode() of $MFT failed.\n");
+				ntfs_attr_put_search_ctx(ctx);
+				/* Revert to the safe super operations. */
+				ntfs_free(m);
+				return -1;
+			}
+			/*
+			 * Re-initialize some specifics about $MFT's inode as
+			 * ntfs_read_inode() will have set up the default ones.
+			 */
+			/* Set uid and gid to root. */
+			vi->i_uid = GLOBAL_ROOT_UID;
+			vi->i_gid = GLOBAL_ROOT_GID;
+			/* Regular file. No access for anyone. */
+			vi->i_mode = S_IFREG;
+			/* No VFS initiated operations allowed for $MFT. */
+			vi->i_op = &ntfs_empty_inode_ops;
+			vi->i_fop = &ntfs_empty_file_ops;
+		}
+
+		/* Get the lowest vcn for the next extent. */
+		highest_vcn = le64_to_cpu(a->data.non_resident.highest_vcn);
+		next_vcn = highest_vcn + 1;
+
+		/* Only one extent or error, which we catch below. */
+		if (next_vcn <= 0)
+			break;
+
+		/* Avoid endless loops due to corruption. */
+		if (next_vcn < le64_to_cpu(a->data.non_resident.lowest_vcn)) {
+			ntfs_error(sb, "$MFT has corrupt attribute list attribute. Run chkdsk.");
+			goto put_err_out;
+		}
+	}
+	if (err != -ENOENT) {
+		ntfs_error(sb, "Failed to lookup $MFT/$DATA attribute extent. Run chkdsk.\n");
+		goto put_err_out;
+	}
+	if (!a) {
+		ntfs_error(sb, "$MFT/$DATA attribute not found. $MFT is corrupt. Run chkdsk.");
+		goto put_err_out;
+	}
+	if (highest_vcn && highest_vcn != last_vcn - 1) {
+		ntfs_error(sb, "Failed to load the complete runlist for $MFT/$DATA. Run chkdsk.");
+		ntfs_debug("highest_vcn = 0x%llx, last_vcn - 1 = 0x%llx",
+				(unsigned long long)highest_vcn,
+				(unsigned long long)last_vcn - 1);
+		goto put_err_out;
+	}
+	ntfs_attr_put_search_ctx(ctx);
+	ntfs_debug("Done.");
+	ntfs_free(m);
+
+	/*
+	 * Split the locking rules of the MFT inode from the
+	 * locking rules of other inodes:
+	 */
+	lockdep_set_class(&ni->runlist.lock, &mft_ni_runlist_lock_key);
+	lockdep_set_class(&ni->mrec_lock, &mft_ni_mrec_lock_key);
+
+	return 0;
+
+em_put_err_out:
+	ntfs_error(sb,
+		"Couldn't find first extent of $DATA attribute in attribute list. $MFT is corrupt. Run chkdsk.");
+put_err_out:
+	ntfs_attr_put_search_ctx(ctx);
+err_out:
+	ntfs_error(sb, "Failed. Marking inode as bad.");
+	ntfs_free(m);
+	return -1;
+}
+
+static void __ntfs_clear_inode(struct ntfs_inode *ni)
+{
+	/* Free all alocated memory. */
+	if (NInoNonResident(ni) && ni->runlist.rl) {
+		ntfs_free(ni->runlist.rl);
+		ni->runlist.rl = NULL;
+	}
+
+	if (ni->attr_list) {
+		ntfs_free(ni->attr_list);
+		ni->attr_list = NULL;
+	}
+
+	if (ni->name_len && ni->name != I30 &&
+	    ni->name != reparse_index_name &&
+	    ni->name != R) {
+		/* Catch bugs... */
+		BUG_ON(!ni->name);
+		kfree(ni->name);
+	}
+}
+
+void ntfs_clear_extent_inode(struct ntfs_inode *ni)
+{
+	ntfs_debug("Entering for inode 0x%lx.", ni->mft_no);
+
+	BUG_ON(NInoAttr(ni));
+	BUG_ON(ni->nr_extents != -1);
+
+	__ntfs_clear_inode(ni);
+	ntfs_destroy_extent_inode(ni);
+}
+
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
+/**
+ * ntfs_evict_big_inode - clean up the ntfs specific part of an inode
+ * @vi:		vfs inode pending annihilation
+ *
+ * When the VFS is going to remove an inode from memory, ntfs_clear_big_inode()
+ * is called, which deallocates all memory belonging to the NTFS specific part
+ * of the inode and returns.
+ *
+ * If the MFT record is dirty, we commit it before doing anything else.
+ */
+void ntfs_evict_big_inode(struct inode *vi)
+{
+	struct ntfs_inode *ni = NTFS_I(vi);
+
+	truncate_inode_pages_final(&vi->i_data);
+
+	if (!vi->i_nlink) {
+		if (!NInoAttr(ni)) {
+			/* Never called with extent inodes */
+			BUG_ON(ni->nr_extents == -1);
+			ntfs_delete_base_inode(ni);
+		}
+		goto release;
+	}
+
+	if (NInoDirty(ni)) {
+		/* Committing the inode also commits all extent inodes. */
+		ntfs_commit_inode(vi);
+
+		if (NInoDirty(ni)) {
+			ntfs_debug("Failed to commit dirty inode 0x%lx.  Losing data!",
+				   vi->i_ino);
+			NInoClearAttrListDirty(ni);
+			NInoClearDirty(ni);
+		}
+	}
+
+	/* No need to lock at this stage as no one else has a reference. */
+	if (ni->nr_extents > 0) {
+		int i;
+
+		for (i = 0; i < ni->nr_extents; i++) {
+			if (ni->ext.extent_ntfs_inos[i])
+				ntfs_clear_extent_inode(ni->ext.extent_ntfs_inos[i]);
+		}
+		ni->nr_extents = 0;
+		ntfs_free(ni->ext.extent_ntfs_inos);
+	}
+
+release:
+	clear_inode(vi);
+	__ntfs_clear_inode(ni);
+
+	if (NInoAttr(ni)) {
+		/* Release the base inode if we are holding it. */
+		if (ni->nr_extents == -1) {
+			iput(VFS_I(ni->ext.base_ntfs_ino));
+			ni->nr_extents = 0;
+			ni->ext.base_ntfs_ino = NULL;
+		}
+	}
+
+	if (!atomic_dec_and_test(&ni->count))
+		BUG();
+	if (ni->folio)
+		ntfs_unmap_folio(ni->folio, NULL);
+	kfree(ni->mrec);
+	ntfs_free(ni->target);
+}
+
+/**
+ * ntfs_show_options - show mount options in /proc/mounts
+ * @sf:		seq_file in which to write our mount options
+ * @root:	root of the mounted tree whose mount options to display
+ *
+ * Called by the VFS once for each mounted ntfs volume when someone reads
+ * /proc/mounts in order to display the NTFS specific mount options of each
+ * mount. The mount options of fs specified by @root are written to the seq file
+ * @sf and success is returned.
+ */
+int ntfs_show_options(struct seq_file *sf, struct dentry *root)
+{
+	struct ntfs_volume *vol = NTFS_SB(root->d_sb);
+	int i;
+
+	seq_printf(sf, ",uid=%i", from_kuid_munged(&init_user_ns, vol->uid));
+	seq_printf(sf, ",gid=%i", from_kgid_munged(&init_user_ns, vol->gid));
+	if (vol->fmask == vol->dmask)
+		seq_printf(sf, ",umask=0%o", vol->fmask);
+	else {
+		seq_printf(sf, ",fmask=0%o", vol->fmask);
+		seq_printf(sf, ",dmask=0%o", vol->dmask);
+	}
+	seq_printf(sf, ",nls=%s", vol->nls_map->charset);
+	if (NVolCaseSensitive(vol))
+		seq_puts(sf, ",case_sensitive");
+	if (NVolShowSystemFiles(vol))
+		seq_puts(sf, ",show_sys_files");
+	for (i = 0; on_errors_arr[i].val; i++) {
+		if (on_errors_arr[i].val == vol->on_errors)
+			seq_printf(sf, ",errors=%s", on_errors_arr[i].str);
+	}
+	seq_printf(sf, ",mft_zone_multiplier=%i", vol->mft_zone_multiplier);
+	return 0;
+}
+
+int ntfs_extend_initialized_size(struct inode *vi, const loff_t offset,
+		const loff_t new_size)
+{
+	struct ntfs_inode *ni = NTFS_I(vi);
+	loff_t old_init_size;
+	unsigned long flags;
+	int err;
+
+	read_lock_irqsave(&ni->size_lock, flags);
+	old_init_size = ni->initialized_size;
+	read_unlock_irqrestore(&ni->size_lock, flags);
+
+	if (!NInoNonResident(ni))
+		return -EINVAL;
+	if (old_init_size >= new_size)
+		return 0;
+
+	err = ntfs_attr_map_whole_runlist(ni);
+	if (err)
+		return err;
+
+	if (!NInoCompressed(ni) && old_init_size < offset) {
+		err = iomap_zero_range(vi, old_init_size,
+				       offset - old_init_size,
+				       NULL, &ntfs_read_iomap_ops,
+				       &ntfs_iomap_folio_ops, NULL);
+		if (err)
+			return err;
+	}
+
+
+	mutex_lock(&ni->mrec_lock);
+	err = ntfs_attr_set_initialized_size(ni, new_size);
+	mutex_unlock(&ni->mrec_lock);
+	if (err)
+		truncate_setsize(vi, old_init_size);
+	return err;
+}
+
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
+}
+
+/**
+ * ntfs_inode_sync_standard_information - update standard information attribute
+ * @vi:	inode to update standard information
+ * @m:	mft record
+ *
+ * Return 0 on success or -errno on error.
+ */
+static int ntfs_inode_sync_standard_information(struct inode *vi, struct mft_record *m)
+{
+	struct ntfs_inode *ni = NTFS_I(vi);
+	struct ntfs_attr_search_ctx *ctx;
+	struct standard_information *si;
+	__le64 nt;
+	int err = 0;
+	bool modified = false;
+
+	/* Update the access times in the standard information attribute. */
+	ctx = ntfs_attr_get_search_ctx(ni, m);
+	if (unlikely(!ctx))
+		return -ENOMEM;
+	err = ntfs_attr_lookup(AT_STANDARD_INFORMATION, NULL, 0,
+			CASE_SENSITIVE, 0, NULL, 0, ctx);
+	if (unlikely(err)) {
+		ntfs_attr_put_search_ctx(ctx);
+		return err;
+	}
+	si = (struct standard_information *)((u8 *)ctx->attr +
+			le16_to_cpu(ctx->attr->data.resident.value_offset));
+	si->file_attributes = ni->flags;
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
+		}
+		ntfs_attr_reinit_search_ctx(ctx);
+	}
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
+	return err;
+}
+
+/**
+ * __ntfs_write_inode - write out a dirty inode
+ * @vi:		inode to write out
+ * @sync:	if true, write out synchronously
+ *
+ * Write out a dirty inode to disk including any extent inodes if present.
+ *
+ * If @sync is true, commit the inode to disk and wait for io completion.  This
+ * is done using write_mft_record().
+ *
+ * If @sync is false, just schedule the write to happen but do not wait for i/o
+ * completion.
+ *
+ * Return 0 on success and -errno on error.
+ */
+int __ntfs_write_inode(struct inode *vi, int sync)
+{
+	struct ntfs_inode *ni = NTFS_I(vi);
+	struct mft_record *m;
+	int err = 0;
+	bool need_iput = false;
+
+	ntfs_debug("Entering for %sinode 0x%lx.", NInoAttr(ni) ? "attr " : "",
+			vi->i_ino);
+
+	if (NVolShutdown(ni->vol))
+		return -EIO;
+
+	/*
+	 * Dirty attribute inodes are written via their real inodes so just
+	 * clean them here.  Access time updates are taken care off when the
+	 * real inode is written.
+	 */
+	if (NInoAttr(ni) || ni->nr_extents == -1) {
+		NInoClearDirty(ni);
+		ntfs_debug("Done.");
+		return 0;
+	}
+
+	/* igrab prevents vi from being evicted while mrec_lock is hold. */
+	if (igrab(vi) != NULL)
+		need_iput = true;
+
+	mutex_lock_nested(&ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL);
+	/* Map, pin, and lock the mft record belonging to the inode. */
+	m = map_mft_record(ni);
+	if (IS_ERR(m)) {
+		mutex_unlock(&ni->mrec_lock);
+		err = PTR_ERR(m);
+		goto err_out;
+	}
+
+	if (NInoNonResident(ni) && NInoRunlistDirty(ni)) {
+		BUG_ON(!NInoFullyMapped(ni));
+		down_write(&ni->runlist.lock);
+		err = ntfs_attr_update_mapping_pairs(ni, 0);
+		if (!err)
+			NInoClearRunlistDirty(ni);
+		up_write(&ni->runlist.lock);
+	}
+
+	err = ntfs_inode_sync_standard_information(vi, m);
+	if (err)
+		goto unm_err_out;
+
+	/*
+	 * when being umounted and inodes are evicted, write_inode()
+	 * is called with all inodes being marked with I_FREEING.
+	 * then ntfs_inode_sync_filename() waits infinitly because
+	 * of ntfs_iget. This situation happens only where sync_filesysem()
+	 * from umount fails because of a disk unplug and etc.
+	 * the absent of SB_ACTIVE means umounting.
+	 */
+	if ((vi->i_sb->s_flags & SB_ACTIVE) && NInoTestClearFileNameDirty(ni))
+		ntfs_inode_sync_filename(ni);
+
+	/* Now the access times are updated, write the base mft record. */
+	if (NInoDirty(ni)) {
+		err = write_mft_record(ni, m, sync);
+		if (err)
+			ntfs_error(vi->i_sb, "write_mft_record failed, err : %d\n", err);
+	}
+	unmap_mft_record(ni);
+
+	/* Write all attached extent mft records. */
+	mutex_lock(&ni->extent_lock);
+	if (ni->nr_extents > 0) {
+		struct ntfs_inode **extent_nis = ni->ext.extent_ntfs_inos;
+		int i;
+
+		ntfs_debug("Writing %i extent inodes.", ni->nr_extents);
+		for (i = 0; i < ni->nr_extents; i++) {
+			struct ntfs_inode *tni = extent_nis[i];
+
+			if (NInoDirty(tni)) {
+				struct mft_record *tm;
+				int ret;
+
+				mutex_lock(&tni->mrec_lock);
+				tm = map_mft_record(tni);
+				if (IS_ERR(tm)) {
+					mutex_unlock(&tni->mrec_lock);
+					if (!err || err == -ENOMEM)
+						err = PTR_ERR(tm);
+					continue;
+				}
+
+				ret = write_mft_record(tni, tm, sync);
+				unmap_mft_record(tni);
+				mutex_unlock(&tni->mrec_lock);
+
+				if (unlikely(ret)) {
+					if (!err || err == -ENOMEM)
+						err = ret;
+				}
+			}
+		}
+	}
+	mutex_unlock(&ni->extent_lock);
+	mutex_unlock(&ni->mrec_lock);
+
+	if (unlikely(err))
+		goto err_out;
+	if (need_iput)
+		iput(vi);
+	ntfs_debug("Done.");
+	return 0;
+unm_err_out:
+	unmap_mft_record(ni);
+	mutex_unlock(&ni->mrec_lock);
+err_out:
+	if (err == -ENOMEM)
+		mark_inode_dirty(vi);
+	else {
+		ntfs_error(vi->i_sb, "Failed (error %i):  Run chkdsk.", -err);
+		NVolSetErrors(ni->vol);
+	}
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
+	return err;
+}
+
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
+				else
+					err = -ENOSPC;
+				goto put_err_out;
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
+	u32 attr_len, total = 0, offset, index;
+	int err = 0;
+
+	BUG_ON(!ni);
+	BUG_ON(!NInoAttr(ni));
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
+	index = (u32)(pos / PAGE_SIZE);
+	do {
+		/* Update @index and get the next folio. */
+		folio = ntfs_read_mapping_folio(mapping, index);
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
+	BUG_ON(NInoNonResident(ni));
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
+	BUG_ON(!NInoNonResident(ni));
+
+	index = pos >> PAGE_SHIFT;
+	while (count) {
+		folio = ntfs_read_mapping_folio(mapping, index);
+		if (IS_ERR(folio)) {
+			ret = PTR_ERR(folio);
+			ntfs_error(vi->i_sb, "Failed to read a page %lu for attr %#x: %ld",
+				   index, ni->type, PTR_ERR(folio));
+			break;
+		}
+
+		folio_lock(folio);
+		offset = offset_in_folio(folio, pos);
+		attr_len = min_t(size_t, (size_t)count, folio_size(folio) - offset);
+
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
+			lcn_count = max_t(s64, 1, attr_len >> vol->cluster_size_bits);
+			vcn = (s64)folio->index << PAGE_SHIFT >> vol->cluster_size_bits;
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
+				bio = ntfs_setup_bio(vol, REQ_OP_WRITE, lcn,
+						lcn_folio_off);
+				if (!bio) {
+					ret = -ENOMEM;
+					goto err_unlock_folio;
+				}
+
+				length = min_t(unsigned long,
+					       rl_length << vol->cluster_size_bits,
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
+		} else
+			folio_mark_dirty(folio);
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
+	BUG_ON(!NInoAttr(ni));
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
diff --git a/fs/ntfsplus/mft.c b/fs/ntfsplus/mft.c
new file mode 100644
index 000000000000..166cdf9ec0da
--- /dev/null
+++ b/fs/ntfsplus/mft.c
@@ -0,0 +1,2630 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/**
+ * NTFS kernel mft record operations. Part of the Linux-NTFS project.
+ * Part of this file is based on code from the NTFS-3G project.
+ *
+ * Copyright (c) 2001-2012 Anton Altaparmakov and Tuxera Inc.
+ * Copyright (c) 2002 Richard Russon
+ * Copyright (c) 2025 LG Electronics Co., Ltd.
+ */
+
+#include <linux/bio.h>
+
+#include "aops.h"
+#include "bitmap.h"
+#include "lcnalloc.h"
+#include "misc.h"
+#include "mft.h"
+#include "ntfs.h"
+
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
+
+/**
+ * map_mft_record_page - map the page in which a specific mft record resides
+ * @ni:		ntfs inode whose mft record page to map
+ *
+ * This maps the page in which the mft record of the ntfs inode @ni is situated
+ * and returns a pointer to the mft record within the mapped page.
+ *
+ * Return value needs to be checked with IS_ERR() and if that is true PTR_ERR()
+ * contains the negative error code returned.
+ */
+static inline struct mft_record *map_mft_record_folio(struct ntfs_inode *ni)
+{
+	loff_t i_size;
+	struct ntfs_volume *vol = ni->vol;
+	struct inode *mft_vi = vol->mft_ino;
+	struct folio *folio;
+	unsigned long index, end_index;
+	unsigned int ofs;
+
+	BUG_ON(ni->folio);
+	/*
+	 * The index into the page cache and the offset within the page cache
+	 * page of the wanted mft record.
+	 */
+	index = (u64)ni->mft_no << vol->mft_record_size_bits >>
+			PAGE_SHIFT;
+	ofs = (ni->mft_no << vol->mft_record_size_bits) & ~PAGE_MASK;
+
+	i_size = i_size_read(mft_vi);
+	/* The maximum valid index into the page cache for $MFT's data. */
+	end_index = i_size >> PAGE_SHIFT;
+
+	/* If the wanted index is out of bounds the mft record doesn't exist. */
+	if (unlikely(index >= end_index)) {
+		if (index > end_index || (i_size & ~PAGE_MASK) < ofs +
+				vol->mft_record_size) {
+			folio = ERR_PTR(-ENOENT);
+			ntfs_error(vol->sb,
+				"Attempt to read mft record 0x%lx, which is beyond the end of the mft. This is probably a bug in the ntfs driver.",
+				ni->mft_no);
+			goto err_out;
+		}
+	}
+
+	/* Read, map, and pin the folio. */
+	folio = ntfs_read_mapping_folio(mft_vi->i_mapping, index);
+	if (!IS_ERR(folio)) {
+		u8 *addr;
+
+		ni->mrec = kmalloc(vol->mft_record_size, GFP_NOFS);
+		if (!ni->mrec) {
+			ntfs_unmap_folio(folio, NULL);
+			folio = ERR_PTR(-ENOMEM);
+			goto err_out;
+		}
+
+		addr = kmap_local_folio(folio, 0);
+		memcpy(ni->mrec, addr + ofs, vol->mft_record_size);
+		post_read_mst_fixup((struct ntfs_record *)ni->mrec, vol->mft_record_size);
+
+		/* Catch multi sector transfer fixup errors. */
+		if (!ntfs_mft_record_check(vol, (struct mft_record *)ni->mrec, ni->mft_no)) {
+			kunmap_local(addr);
+			ni->folio = folio;
+			ni->folio_ofs = ofs;
+			return ni->mrec;
+		}
+		ntfs_unmap_folio(folio, addr);
+		kfree(ni->mrec);
+		ni->mrec = NULL;
+		folio = ERR_PTR(-EIO);
+		NVolSetErrors(vol);
+	}
+err_out:
+	ni->folio = NULL;
+	ni->folio_ofs = 0;
+	return (void *)folio;
+}
+
+/**
+ * map_mft_record - map, pin and lock an mft record
+ * @ni:		ntfs inode whose MFT record to map
+ *
+ * First, take the mrec_lock mutex.  We might now be sleeping, while waiting
+ * for the mutex if it was already locked by someone else.
+ *
+ * The page of the record is mapped using map_mft_record_folio() before being
+ * returned to the caller.
+ *
+ * This in turn uses ntfs_read_mapping_folio() to get the page containing the wanted mft
+ * record (it in turn calls read_cache_page() which reads it in from disk if
+ * necessary, increments the use count on the page so that it cannot disappear
+ * under us and returns a reference to the page cache page).
+ *
+ * If read_cache_page() invokes ntfs_readpage() to load the page from disk, it
+ * sets PG_locked and clears PG_uptodate on the page. Once I/O has completed
+ * and the post-read mst fixups on each mft record in the page have been
+ * performed, the page gets PG_uptodate set and PG_locked cleared (this is done
+ * in our asynchronous I/O completion handler end_buffer_read_mft_async()).
+ * ntfs_read_mapping_folio() waits for PG_locked to become clear and checks if
+ * PG_uptodate is set and returns an error code if not. This provides
+ * sufficient protection against races when reading/using the page.
+ *
+ * However there is the write mapping to think about. Doing the above described
+ * checking here will be fine, because when initiating the write we will set
+ * PG_locked and clear PG_uptodate making sure nobody is touching the page
+ * contents. Doing the locking this way means that the commit to disk code in
+ * the page cache code paths is automatically sufficiently locked with us as
+ * we will not touch a page that has been locked or is not uptodate. The only
+ * locking problem then is them locking the page while we are accessing it.
+ *
+ * So that code will end up having to own the mrec_lock of all mft
+ * records/inodes present in the page before I/O can proceed. In that case we
+ * wouldn't need to bother with PG_locked and PG_uptodate as nobody will be
+ * accessing anything without owning the mrec_lock mutex.  But we do need to
+ * use them because of the read_cache_page() invocation and the code becomes so
+ * much simpler this way that it is well worth it.
+ *
+ * The mft record is now ours and we return a pointer to it. You need to check
+ * the returned pointer with IS_ERR() and if that is true, PTR_ERR() will return
+ * the error code.
+ *
+ * NOTE: Caller is responsible for setting the mft record dirty before calling
+ * unmap_mft_record(). This is obviously only necessary if the caller really
+ * modified the mft record...
+ * Q: Do we want to recycle one of the VFS inode state bits instead?
+ * A: No, the inode ones mean we want to change the mft record, not we want to
+ * write it out.
+ */
+struct mft_record *map_mft_record(struct ntfs_inode *ni)
+{
+	struct mft_record *m;
+
+	if (!ni)
+		return ERR_PTR(-EINVAL);
+
+	ntfs_debug("Entering for mft_no 0x%lx.", ni->mft_no);
+
+	/* Make sure the ntfs inode doesn't go away. */
+	atomic_inc(&ni->count);
+
+	if (ni->folio)
+		return (struct mft_record *)ni->mrec;
+
+	m = map_mft_record_folio(ni);
+	if (!IS_ERR(m))
+		return m;
+
+	atomic_dec(&ni->count);
+	ntfs_error(ni->vol->sb, "Failed with error code %lu.", -PTR_ERR(m));
+	return m;
+}
+
+/**
+ * unmap_mft_record - release a mapped mft record
+ * @ni:		ntfs inode whose MFT record to unmap
+ *
+ * We release the page mapping and the mrec_lock mutex which unmaps the mft
+ * record and releases it for others to get hold of. We also release the ntfs
+ * inode by decrementing the ntfs inode reference count.
+ *
+ * NOTE: If caller has modified the mft record, it is imperative to set the mft
+ * record dirty BEFORE calling unmap_mft_record().
+ */
+void unmap_mft_record(struct ntfs_inode *ni)
+{
+	struct folio *folio;
+
+	if (!ni)
+		return;
+
+	ntfs_debug("Entering for mft_no 0x%lx.", ni->mft_no);
+
+	folio = ni->folio;
+	if (atomic_dec_return(&ni->count) > 1)
+		return;
+	BUG_ON(!folio);
+}
+
+/**
+ * map_extent_mft_record - load an extent inode and attach it to its base
+ * @base_ni:	base ntfs inode
+ * @mref:	mft reference of the extent inode to load
+ * @ntfs_ino:	on successful return, pointer to the struct ntfs_inode structure
+ *
+ * Load the extent mft record @mref and attach it to its base inode @base_ni.
+ * Return the mapped extent mft record if IS_ERR(result) is false.  Otherwise
+ * PTR_ERR(result) gives the negative error code.
+ *
+ * On successful return, @ntfs_ino contains a pointer to the ntfs_inode
+ * structure of the mapped extent inode.
+ */
+struct mft_record *map_extent_mft_record(struct ntfs_inode *base_ni, u64 mref,
+		struct ntfs_inode **ntfs_ino)
+{
+	struct mft_record *m;
+	struct ntfs_inode *ni = NULL;
+	struct ntfs_inode **extent_nis = NULL;
+	int i;
+	unsigned long mft_no = MREF(mref);
+	u16 seq_no = MSEQNO(mref);
+	bool destroy_ni = false;
+
+	ntfs_debug("Mapping extent mft record 0x%lx (base mft record 0x%lx).",
+			mft_no, base_ni->mft_no);
+	/* Make sure the base ntfs inode doesn't go away. */
+	atomic_inc(&base_ni->count);
+	/*
+	 * Check if this extent inode has already been added to the base inode,
+	 * in which case just return it. If not found, add it to the base
+	 * inode before returning it.
+	 */
+	mutex_lock(&base_ni->extent_lock);
+	if (base_ni->nr_extents > 0) {
+		extent_nis = base_ni->ext.extent_ntfs_inos;
+		for (i = 0; i < base_ni->nr_extents; i++) {
+			if (mft_no != extent_nis[i]->mft_no)
+				continue;
+			ni = extent_nis[i];
+			/* Make sure the ntfs inode doesn't go away. */
+			atomic_inc(&ni->count);
+			break;
+		}
+	}
+	if (likely(ni != NULL)) {
+		mutex_unlock(&base_ni->extent_lock);
+		atomic_dec(&base_ni->count);
+		/* We found the record; just have to map and return it. */
+		m = map_mft_record(ni);
+		/* map_mft_record() has incremented this on success. */
+		atomic_dec(&ni->count);
+		if (!IS_ERR(m)) {
+			/* Verify the sequence number. */
+			if (likely(le16_to_cpu(m->sequence_number) == seq_no)) {
+				ntfs_debug("Done 1.");
+				*ntfs_ino = ni;
+				return m;
+			}
+			unmap_mft_record(ni);
+			ntfs_error(base_ni->vol->sb,
+					"Found stale extent mft reference! Corrupt filesystem. Run chkdsk.");
+			return ERR_PTR(-EIO);
+		}
+map_err_out:
+		ntfs_error(base_ni->vol->sb,
+				"Failed to map extent mft record, error code %ld.",
+				-PTR_ERR(m));
+		return m;
+	}
+	/* Record wasn't there. Get a new ntfs inode and initialize it. */
+	ni = ntfs_new_extent_inode(base_ni->vol->sb, mft_no);
+	if (unlikely(!ni)) {
+		mutex_unlock(&base_ni->extent_lock);
+		atomic_dec(&base_ni->count);
+		return ERR_PTR(-ENOMEM);
+	}
+	ni->vol = base_ni->vol;
+	ni->seq_no = seq_no;
+	ni->nr_extents = -1;
+	ni->ext.base_ntfs_ino = base_ni;
+	/* Now map the record. */
+	m = map_mft_record(ni);
+	if (IS_ERR(m)) {
+		mutex_unlock(&base_ni->extent_lock);
+		atomic_dec(&base_ni->count);
+		ntfs_clear_extent_inode(ni);
+		goto map_err_out;
+	}
+	/* Verify the sequence number if it is present. */
+	if (seq_no && (le16_to_cpu(m->sequence_number) != seq_no)) {
+		ntfs_error(base_ni->vol->sb,
+				"Found stale extent mft reference! Corrupt filesystem. Run chkdsk.");
+		destroy_ni = true;
+		m = ERR_PTR(-EIO);
+		goto unm_err_out;
+	}
+	/* Attach extent inode to base inode, reallocating memory if needed. */
+	if (!(base_ni->nr_extents & 3)) {
+		struct ntfs_inode **tmp;
+		int new_size = (base_ni->nr_extents + 4) * sizeof(struct ntfs_inode *);
+
+		tmp = ntfs_malloc_nofs(new_size);
+		if (unlikely(!tmp)) {
+			ntfs_error(base_ni->vol->sb, "Failed to allocate internal buffer.");
+			destroy_ni = true;
+			m = ERR_PTR(-ENOMEM);
+			goto unm_err_out;
+		}
+		if (base_ni->nr_extents) {
+			BUG_ON(!base_ni->ext.extent_ntfs_inos);
+			memcpy(tmp, base_ni->ext.extent_ntfs_inos, new_size -
+					4 * sizeof(struct ntfs_inode *));
+			ntfs_free(base_ni->ext.extent_ntfs_inos);
+		}
+		base_ni->ext.extent_ntfs_inos = tmp;
+	}
+	base_ni->ext.extent_ntfs_inos[base_ni->nr_extents++] = ni;
+	mutex_unlock(&base_ni->extent_lock);
+	atomic_dec(&base_ni->count);
+	ntfs_debug("Done 2.");
+	*ntfs_ino = ni;
+	return m;
+unm_err_out:
+	unmap_mft_record(ni);
+	mutex_unlock(&base_ni->extent_lock);
+	atomic_dec(&base_ni->count);
+	/*
+	 * If the extent inode was not attached to the base inode we need to
+	 * release it or we will leak memory.
+	 */
+	if (destroy_ni)
+		ntfs_clear_extent_inode(ni);
+	return m;
+}
+
+/**
+ * __mark_mft_record_dirty - set the mft record and the page containing it dirty
+ * @ni:		ntfs inode describing the mapped mft record
+ *
+ * Internal function.  Users should call mark_mft_record_dirty() instead.
+ *
+ * Set the mapped (extent) mft record of the (base or extent) ntfs inode @ni,
+ * as well as the page containing the mft record, dirty.  Also, mark the base
+ * vfs inode dirty.  This ensures that any changes to the mft record are
+ * written out to disk.
+ *
+ * NOTE:  We only set I_DIRTY_DATASYNC (and not I_DIRTY_PAGES)
+ * on the base vfs inode, because even though file data may have been modified,
+ * it is dirty in the inode meta data rather than the data page cache of the
+ * inode, and thus there are no data pages that need writing out.  Therefore, a
+ * full mark_inode_dirty() is overkill.  A mark_inode_dirty_sync(), on the
+ * other hand, is not sufficient, because ->write_inode needs to be called even
+ * in case of fdatasync. This needs to happen or the file data would not
+ * necessarily hit the device synchronously, even though the vfs inode has the
+ * O_SYNC flag set.  Also, I_DIRTY_DATASYNC simply "feels" better than just
+ * I_DIRTY_SYNC, since the file data has not actually hit the block device yet,
+ * which is not what I_DIRTY_SYNC on its own would suggest.
+ */
+void __mark_mft_record_dirty(struct ntfs_inode *ni)
+{
+	struct ntfs_inode *base_ni;
+
+	ntfs_debug("Entering for inode 0x%lx.", ni->mft_no);
+	BUG_ON(NInoAttr(ni));
+	/* Determine the base vfs inode and mark it dirty, too. */
+	if (likely(ni->nr_extents >= 0))
+		base_ni = ni;
+	else
+		base_ni = ni->ext.base_ntfs_ino;
+	__mark_inode_dirty(VFS_I(base_ni), I_DIRTY_DATASYNC);
+}
+
+/**
+ * ntfs_sync_mft_mirror - synchronize an mft record to the mft mirror
+ * @vol:	ntfs volume on which the mft record to synchronize resides
+ * @mft_no:	mft record number of mft record to synchronize
+ * @m:		mapped, mst protected (extent) mft record to synchronize
+ *
+ * Write the mapped, mst protected (extent) mft record @m with mft record
+ * number @mft_no to the mft mirror ($MFTMirr) of the ntfs volume @vol.
+ *
+ * On success return 0.  On error return -errno and set the volume errors flag
+ * in the ntfs volume @vol.
+ *
+ * NOTE:  We always perform synchronous i/o and ignore the @sync parameter.
+ */
+int ntfs_sync_mft_mirror(struct ntfs_volume *vol, const unsigned long mft_no,
+		struct mft_record *m)
+{
+	u8 *kmirr = NULL;
+	struct folio *folio;
+	unsigned int folio_ofs, lcn_folio_off = 0;
+	int err = 0;
+	struct bio *bio;
+
+	ntfs_debug("Entering for inode 0x%lx.", mft_no);
+
+	if (unlikely(!vol->mftmirr_ino)) {
+		/* This could happen during umount... */
+		err = -EIO;
+		goto err_out;
+	}
+	/* Get the page containing the mirror copy of the mft record @m. */
+	folio = ntfs_read_mapping_folio(vol->mftmirr_ino->i_mapping, mft_no >>
+			(PAGE_SHIFT - vol->mft_record_size_bits));
+	if (IS_ERR(folio)) {
+		ntfs_error(vol->sb, "Failed to map mft mirror page.");
+		err = PTR_ERR(folio);
+		goto err_out;
+	}
+
+	folio_lock(folio);
+	BUG_ON(!folio_test_uptodate(folio));
+	folio_clear_uptodate(folio);
+	/* Offset of the mft mirror record inside the page. */
+	folio_ofs = (mft_no << vol->mft_record_size_bits) & ~PAGE_MASK;
+	/* The address in the page of the mirror copy of the mft record @m. */
+	kmirr = kmap_local_folio(folio, 0) + folio_ofs;
+	/* Copy the mst protected mft record to the mirror. */
+	memcpy(kmirr, m, vol->mft_record_size);
+
+	if (vol->cluster_size_bits > PAGE_SHIFT) {
+		lcn_folio_off = folio->index << PAGE_SHIFT;
+		lcn_folio_off &= vol->cluster_size_mask;
+	}
+
+	bio = ntfs_setup_bio(vol, REQ_OP_WRITE, vol->mftmirr_lcn,
+			     lcn_folio_off + folio_ofs);
+	if (!bio) {
+		err = -ENOMEM;
+		goto unlock_folio;
+	}
+
+	if (!bio_add_folio(bio, folio, vol->mft_record_size, folio_ofs)) {
+		err = -EIO;
+		bio_put(bio);
+		goto unlock_folio;
+	}
+
+	submit_bio_wait(bio);
+	bio_put(bio);
+	/* Current state: all buffers are clean, unlocked, and uptodate. */
+	flush_dcache_folio(folio);
+	folio_mark_uptodate(folio);
+
+unlock_folio:
+	folio_unlock(folio);
+	ntfs_unmap_folio(folio, kmirr);
+	if (likely(!err)) {
+		ntfs_debug("Done.");
+	} else {
+		ntfs_error(vol->sb, "I/O error while writing mft mirror record 0x%lx!", mft_no);
+err_out:
+		ntfs_error(vol->sb,
+			"Failed to synchronize $MFTMirr (error code %i).  Volume will be left marked dirty on umount.  Run chkdsk on the partition after umounting to correct this.",
+			err);
+		NVolSetErrors(vol);
+	}
+	return err;
+}
+
+/**
+ * write_mft_record_nolock - write out a mapped (extent) mft record
+ * @ni:		ntfs inode describing the mapped (extent) mft record
+ * @m:		mapped (extent) mft record to write
+ * @sync:	if true, wait for i/o completion
+ *
+ * Write the mapped (extent) mft record @m described by the (regular or extent)
+ * ntfs inode @ni to backing store.  If the mft record @m has a counterpart in
+ * the mft mirror, that is also updated.
+ *
+ * We only write the mft record if the ntfs inode @ni is dirty and the first
+ * buffer belonging to its mft record is dirty, too.  We ignore the dirty state
+ * of subsequent buffers because we could have raced with
+ * fs/ntfs/aops.c::mark_ntfs_record_dirty().
+ *
+ * On success, clean the mft record and return 0.  On error, leave the mft
+ * record dirty and return -errno.
+ *
+ * NOTE:  We always perform synchronous i/o and ignore the @sync parameter.
+ * However, if the mft record has a counterpart in the mft mirror and @sync is
+ * true, we write the mft record, wait for i/o completion, and only then write
+ * the mft mirror copy.  This ensures that if the system crashes either the mft
+ * or the mft mirror will contain a self-consistent mft record @m.  If @sync is
+ * false on the other hand, we start i/o on both and then wait for completion
+ * on them.  This provides a speedup but no longer guarantees that you will end
+ * up with a self-consistent mft record in the case of a crash but if you asked
+ * for asynchronous writing you probably do not care about that anyway.
+ */
+int write_mft_record_nolock(struct ntfs_inode *ni, struct mft_record *m, int sync)
+{
+	struct ntfs_volume *vol = ni->vol;
+	struct folio *folio = ni->folio;
+	unsigned int lcn_folio_off = 0;
+	int err = 0, i = 0;
+	u8 *kaddr;
+	struct mft_record *fixup_m;
+	struct bio *bio;
+	unsigned int offset = 0, folio_size;
+
+	ntfs_debug("Entering for inode 0x%lx.", ni->mft_no);
+
+	BUG_ON(NInoAttr(ni));
+	BUG_ON(!folio_test_locked(folio));
+
+	/*
+	 * If the struct ntfs_inode is clean no need to do anything.  If it is dirty,
+	 * mark it as clean now so that it can be redirtied later on if needed.
+	 * There is no danger of races since the caller is holding the locks
+	 * for the mft record @m and the page it is in.
+	 */
+	if (!NInoTestClearDirty(ni))
+		goto done;
+
+	if (ni->mft_lcn[0] == LCN_RL_NOT_MAPPED) {
+		sector_t iblock;
+		s64 vcn;
+		unsigned char blocksize_bits = vol->sb->s_blocksize_bits;
+		struct runlist_element *rl;
+
+		iblock = (s64)folio->index << (PAGE_SHIFT - blocksize_bits);
+		vcn = ((s64)iblock << blocksize_bits) >> vol->cluster_size_bits;
+
+		down_read(&NTFS_I(vol->mft_ino)->runlist.lock);
+		rl = NTFS_I(vol->mft_ino)->runlist.rl;
+		BUG_ON(!rl);
+
+		/* Seek to element containing target vcn. */
+		while (rl->length && rl[1].vcn <= vcn)
+			rl++;
+		ni->mft_lcn[0] = ntfs_rl_vcn_to_lcn(rl, vcn);
+		ni->mft_lcn_count++;
+
+		if (vol->cluster_size < vol->mft_record_size &&
+		    (rl->length - (vcn - rl->vcn)) <= 1) {
+			rl++;
+			ni->mft_lcn[1] = ntfs_rl_vcn_to_lcn(rl, vcn + 1);
+			ni->mft_lcn_count++;
+		}
+		up_read(&NTFS_I(vol->mft_ino)->runlist.lock);
+	}
+
+	kaddr = kmap_local_folio(folio, 0);
+	fixup_m = (struct mft_record *)(kaddr + ni->folio_ofs);
+	memcpy(fixup_m, m, vol->mft_record_size);
+
+	/* Apply the mst protection fixups. */
+	err = pre_write_mst_fixup((struct ntfs_record *)fixup_m, vol->mft_record_size);
+	if (err) {
+		ntfs_error(vol->sb, "Failed to apply mst fixups!");
+		goto err_out;
+	}
+
+	while (i < ni->mft_lcn_count) {
+		folio_size = vol->mft_record_size / ni->mft_lcn_count;
+
+		flush_dcache_folio(folio);
+
+		if (vol->cluster_size_bits > PAGE_SHIFT) {
+			lcn_folio_off = folio->index << PAGE_SHIFT;
+			lcn_folio_off &= vol->cluster_size_mask;
+		}
+
+		bio = ntfs_setup_bio(vol, REQ_OP_WRITE, ni->mft_lcn[i],
+				lcn_folio_off + ni->folio_ofs);
+		if (!bio) {
+			err = -ENOMEM;
+			goto err_out;
+		}
+
+		if (!bio_add_folio(bio, folio, folio_size,
+				   ni->folio_ofs + offset)) {
+			err = -EIO;
+			goto put_bio_out;
+		}
+
+		/* Synchronize the mft mirror now if not @sync. */
+		if (!sync && ni->mft_no < vol->mftmirr_size)
+			ntfs_sync_mft_mirror(vol, ni->mft_no, fixup_m);
+
+		submit_bio_wait(bio);
+		bio_put(bio);
+		offset += vol->cluster_size;
+		i++;
+	}
+
+	/* If @sync, now synchronize the mft mirror. */
+	if (sync && ni->mft_no < vol->mftmirr_size)
+		ntfs_sync_mft_mirror(vol, ni->mft_no, fixup_m);
+	kunmap_local(kaddr);
+	if (unlikely(err)) {
+		/* I/O error during writing.  This is really bad! */
+		ntfs_error(vol->sb,
+			"I/O error while writing mft record 0x%lx!  Marking base inode as bad.  You should unmount the volume and run chkdsk.",
+			ni->mft_no);
+		goto err_out;
+	}
+done:
+	ntfs_debug("Done.");
+	return 0;
+put_bio_out:
+	bio_put(bio);
+err_out:
+	/*
+	 * Current state: all buffers are clean, unlocked, and uptodate.
+	 * The caller should mark the base inode as bad so that no more i/o
+	 * happens.  ->clear_inode() will still be invoked so all extent inodes
+	 * and other allocated memory will be freed.
+	 */
+	if (err == -ENOMEM) {
+		ntfs_error(vol->sb,
+			"Not enough memory to write mft record. Redirtying so the write is retried later.");
+		mark_mft_record_dirty(ni);
+		err = 0;
+	} else
+		NVolSetErrors(vol);
+	return err;
+}
+
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
+	if (vi->i_state & I_CREATING) {
+		spin_unlock(&vi->i_lock);
+		na->state = NI_BeingCreated;
+		return -1;
+	}
+	spin_unlock(&vi->i_lock);
+
+	return igrab(vi) ? 1 : -1;
+}
+
+/**
+ * ntfs_may_write_mft_record - check if an mft record may be written out
+ * @vol:	[IN]  ntfs volume on which the mft record to check resides
+ * @mft_no:	[IN]  mft record number of the mft record to check
+ * @m:		[IN]  mapped mft record to check
+ * @locked_ni:	[OUT] caller has to unlock this ntfs inode if one is returned
+ *
+ * Check if the mapped (base or extent) mft record @m with mft record number
+ * @mft_no belonging to the ntfs volume @vol may be written out.  If necessary
+ * and possible the ntfs inode of the mft record is locked and the base vfs
+ * inode is pinned.  The locked ntfs inode is then returned in @locked_ni.  The
+ * caller is responsible for unlocking the ntfs inode and unpinning the base
+ * vfs inode.
+ *
+ * Return 'true' if the mft record may be written out and 'false' if not.
+ *
+ * The caller has locked the page and cleared the uptodate flag on it which
+ * means that we can safely write out any dirty mft records that do not have
+ * their inodes in icache as determined by ilookup5() as anyone
+ * opening/creating such an inode would block when attempting to map the mft
+ * record in read_cache_page() until we are finished with the write out.
+ *
+ * Here is a description of the tests we perform:
+ *
+ * If the inode is found in icache we know the mft record must be a base mft
+ * record.  If it is dirty, we do not write it and return 'false' as the vfs
+ * inode write paths will result in the access times being updated which would
+ * cause the base mft record to be redirtied and written out again.  (We know
+ * the access time update will modify the base mft record because Windows
+ * chkdsk complains if the standard information attribute is not in the base
+ * mft record.)
+ *
+ * If the inode is in icache and not dirty, we attempt to lock the mft record
+ * and if we find the lock was already taken, it is not safe to write the mft
+ * record and we return 'false'.
+ *
+ * If we manage to obtain the lock we have exclusive access to the mft record,
+ * which also allows us safe writeout of the mft record.  We then set
+ * @locked_ni to the locked ntfs inode and return 'true'.
+ *
+ * Note we cannot just lock the mft record and sleep while waiting for the lock
+ * because this would deadlock due to lock reversal (normally the mft record is
+ * locked before the page is locked but we already have the page locked here
+ * when we try to lock the mft record).
+ *
+ * If the inode is not in icache we need to perform further checks.
+ *
+ * If the mft record is not a FILE record or it is a base mft record, we can
+ * safely write it and return 'true'.
+ *
+ * We now know the mft record is an extent mft record.  We check if the inode
+ * corresponding to its base mft record is in icache and obtain a reference to
+ * it if it is.  If it is not, we can safely write it and return 'true'.
+ *
+ * We now have the base inode for the extent mft record.  We check if it has an
+ * ntfs inode for the extent mft record attached and if not it is safe to write
+ * the extent mft record and we return 'true'.
+ *
+ * The ntfs inode for the extent mft record is attached to the base inode so we
+ * attempt to lock the extent mft record and if we find the lock was already
+ * taken, it is not safe to write the extent mft record and we return 'false'.
+ *
+ * If we manage to obtain the lock we have exclusive access to the extent mft
+ * record, which also allows us safe writeout of the extent mft record.  We
+ * set the ntfs inode of the extent mft record clean and then set @locked_ni to
+ * the now locked ntfs inode and return 'true'.
+ *
+ * Note, the reason for actually writing dirty mft records here and not just
+ * relying on the vfs inode dirty code paths is that we can have mft records
+ * modified without them ever having actual inodes in memory.  Also we can have
+ * dirty mft records with clean ntfs inodes in memory.  None of the described
+ * cases would result in the dirty mft records being written out if we only
+ * relied on the vfs inode dirty code paths.  And these cases can really occur
+ * during allocation of new mft records and in particular when the
+ * initialized_size of the $MFT/$DATA attribute is extended and the new space
+ * is initialized using ntfs_mft_record_format().  The clean inode can then
+ * appear if the mft record is reused for a new inode before it got written
+ * out.
+ */
+bool ntfs_may_write_mft_record(struct ntfs_volume *vol, const unsigned long mft_no,
+		const struct mft_record *m, struct ntfs_inode **locked_ni)
+{
+	struct super_block *sb = vol->sb;
+	struct inode *mft_vi = vol->mft_ino;
+	struct inode *vi;
+	struct ntfs_inode *ni, *eni, **extent_nis;
+	int i;
+	struct ntfs_attr na = {0};
+
+	ntfs_debug("Entering for inode 0x%lx.", mft_no);
+	/*
+	 * Normally we do not return a locked inode so set @locked_ni to NULL.
+	 */
+	BUG_ON(!locked_ni);
+	*locked_ni = NULL;
+	/*
+	 * Check if the inode corresponding to this mft record is in the VFS
+	 * inode cache and obtain a reference to it if it is.
+	 */
+	ntfs_debug("Looking for inode 0x%lx in icache.", mft_no);
+	na.mft_no = mft_no;
+	na.type = AT_UNUSED;
+	/*
+	 * Optimize inode 0, i.e. $MFT itself, since we have it in memory and
+	 * we get here for it rather often.
+	 */
+	if (!mft_no) {
+		/* Balance the below iput(). */
+		vi = igrab(mft_vi);
+		BUG_ON(vi != mft_vi);
+	} else {
+		/*
+		 * Have to use find_inode_nowait() since ilookup5_nowait()
+		 * waits for inode with I_FREEING, which causes ntfs to deadlock
+		 * when inodes are unlinked concurrently
+		 */
+		vi = find_inode_nowait(sb, mft_no, ntfs_test_inode_wb, &na);
+		if (na.state == NI_BeingDeleted || na.state == NI_BeingCreated)
+			return false;
+	}
+	if (vi) {
+		ntfs_debug("Base inode 0x%lx is in icache.", mft_no);
+		/* The inode is in icache. */
+		ni = NTFS_I(vi);
+		/* Take a reference to the ntfs inode. */
+		atomic_inc(&ni->count);
+		/* If the inode is dirty, do not write this record. */
+		if (NInoDirty(ni)) {
+			ntfs_debug("Inode 0x%lx is dirty, do not write it.",
+					mft_no);
+			atomic_dec(&ni->count);
+			iput(vi);
+			return false;
+		}
+		ntfs_debug("Inode 0x%lx is not dirty.", mft_no);
+		/* The inode is not dirty, try to take the mft record lock. */
+		if (unlikely(!mutex_trylock(&ni->mrec_lock))) {
+			ntfs_debug("Mft record 0x%lx is already locked, do not write it.", mft_no);
+			atomic_dec(&ni->count);
+			iput(vi);
+			return false;
+		}
+		ntfs_debug("Managed to lock mft record 0x%lx, write it.",
+				mft_no);
+		/*
+		 * The write has to occur while we hold the mft record lock so
+		 * return the locked ntfs inode.
+		 */
+		*locked_ni = ni;
+		return true;
+	}
+	ntfs_debug("Inode 0x%lx is not in icache.", mft_no);
+	/* The inode is not in icache. */
+	/* Write the record if it is not a mft record (type "FILE"). */
+	if (!ntfs_is_mft_record(m->magic)) {
+		ntfs_debug("Mft record 0x%lx is not a FILE record, write it.",
+				mft_no);
+		return true;
+	}
+	/* Write the mft record if it is a base inode. */
+	if (!m->base_mft_record) {
+		ntfs_debug("Mft record 0x%lx is a base record, write it.",
+				mft_no);
+		return true;
+	}
+	/*
+	 * This is an extent mft record.  Check if the inode corresponding to
+	 * its base mft record is in icache and obtain a reference to it if it
+	 * is.
+	 */
+	na.mft_no = MREF_LE(m->base_mft_record);
+	na.state = 0;
+	ntfs_debug("Mft record 0x%lx is an extent record.  Looking for base inode 0x%lx in icache.",
+			mft_no, na.mft_no);
+	if (!na.mft_no) {
+		/* Balance the below iput(). */
+		vi = igrab(mft_vi);
+		BUG_ON(vi != mft_vi);
+	} else {
+		vi = find_inode_nowait(sb, mft_no, ntfs_test_inode_wb, &na);
+		if (na.state == NI_BeingDeleted || na.state == NI_BeingCreated)
+			return false;
+	}
+
+	if (!vi)
+		return false;
+	ntfs_debug("Base inode 0x%lx is in icache.", na.mft_no);
+	/*
+	 * The base inode is in icache.  Check if it has the extent inode
+	 * corresponding to this extent mft record attached.
+	 */
+	ni = NTFS_I(vi);
+	mutex_lock(&ni->extent_lock);
+	if (ni->nr_extents <= 0) {
+		/*
+		 * The base inode has no attached extent inodes, write this
+		 * extent mft record.
+		 */
+		mutex_unlock(&ni->extent_lock);
+		iput(vi);
+		ntfs_debug("Base inode 0x%lx has no attached extent inodes, write the extent record.",
+				na.mft_no);
+		return true;
+	}
+	/* Iterate over the attached extent inodes. */
+	extent_nis = ni->ext.extent_ntfs_inos;
+	for (eni = NULL, i = 0; i < ni->nr_extents; ++i) {
+		if (mft_no == extent_nis[i]->mft_no) {
+			/*
+			 * Found the extent inode corresponding to this extent
+			 * mft record.
+			 */
+			eni = extent_nis[i];
+			break;
+		}
+	}
+	/*
+	 * If the extent inode was not attached to the base inode, write this
+	 * extent mft record.
+	 */
+	if (!eni) {
+		mutex_unlock(&ni->extent_lock);
+		iput(vi);
+		ntfs_debug("Extent inode 0x%lx is not attached to its base inode 0x%lx, write the extent record.",
+				mft_no, na.mft_no);
+		return true;
+	}
+	ntfs_debug("Extent inode 0x%lx is attached to its base inode 0x%lx.",
+			mft_no, na.mft_no);
+	/* Take a reference to the extent ntfs inode. */
+	atomic_inc(&eni->count);
+	mutex_unlock(&ni->extent_lock);
+
+	/* if extent inode is dirty, write_inode will write it */
+	if (NInoDirty(eni)) {
+		atomic_dec(&eni->count);
+		iput(vi);
+		return false;
+	}
+
+	/*
+	 * Found the extent inode coresponding to this extent mft record.
+	 * Try to take the mft record lock.
+	 */
+	if (unlikely(!mutex_trylock(&eni->mrec_lock))) {
+		atomic_dec(&eni->count);
+		iput(vi);
+		ntfs_debug("Extent mft record 0x%lx is already locked, do not write it.",
+				mft_no);
+		return false;
+	}
+	ntfs_debug("Managed to lock extent mft record 0x%lx, write it.",
+			mft_no);
+	/*
+	 * The write has to occur while we hold the mft record lock so return
+	 * the locked extent ntfs inode.
+	 */
+	*locked_ni = eni;
+	return true;
+}
+
+static const char *es = "  Leaving inconsistent metadata.  Unmount and run chkdsk.";
+
+/**
+ * ntfs_mft_bitmap_find_and_alloc_free_rec_nolock - see name
+ * @vol:	volume on which to search for a free mft record
+ * @base_ni:	open base inode if allocating an extent mft record or NULL
+ *
+ * Search for a free mft record in the mft bitmap attribute on the ntfs volume
+ * @vol.
+ *
+ * If @base_ni is NULL start the search at the default allocator position.
+ *
+ * If @base_ni is not NULL start the search at the mft record after the base
+ * mft record @base_ni.
+ *
+ * Return the free mft record on success and -errno on error.  An error code of
+ * -ENOSPC means that there are no free mft records in the currently
+ * initialized mft bitmap.
+ *
+ * Locking: Caller must hold vol->mftbmp_lock for writing.
+ */
+static int ntfs_mft_bitmap_find_and_alloc_free_rec_nolock(struct ntfs_volume *vol,
+		struct ntfs_inode *base_ni)
+{
+	s64 pass_end, ll, data_pos, pass_start, ofs, bit;
+	unsigned long flags;
+	struct address_space *mftbmp_mapping;
+	u8 *buf = NULL, *byte;
+	struct folio *folio;
+	unsigned int folio_ofs, size;
+	u8 pass, b;
+
+	ntfs_debug("Searching for free mft record in the currently initialized mft bitmap.");
+	mftbmp_mapping = vol->mftbmp_ino->i_mapping;
+	/*
+	 * Set the end of the pass making sure we do not overflow the mft
+	 * bitmap.
+	 */
+	read_lock_irqsave(&NTFS_I(vol->mft_ino)->size_lock, flags);
+	pass_end = NTFS_I(vol->mft_ino)->allocated_size >>
+			vol->mft_record_size_bits;
+	read_unlock_irqrestore(&NTFS_I(vol->mft_ino)->size_lock, flags);
+	read_lock_irqsave(&NTFS_I(vol->mftbmp_ino)->size_lock, flags);
+	ll = NTFS_I(vol->mftbmp_ino)->initialized_size << 3;
+	read_unlock_irqrestore(&NTFS_I(vol->mftbmp_ino)->size_lock, flags);
+	if (pass_end > ll)
+		pass_end = ll;
+	pass = 1;
+	if (!base_ni)
+		data_pos = vol->mft_data_pos;
+	else
+		data_pos = base_ni->mft_no + 1;
+	if (data_pos < 24)
+		data_pos = 24;
+	if (data_pos >= pass_end) {
+		data_pos = 24;
+		pass = 2;
+		/* This happens on a freshly formatted volume. */
+		if (data_pos >= pass_end)
+			return -ENOSPC;
+	}
+	pass_start = data_pos;
+	ntfs_debug("Starting bitmap search: pass %u, pass_start 0x%llx, pass_end 0x%llx, data_pos 0x%llx.",
+			pass, pass_start, pass_end, data_pos);
+	/* Loop until a free mft record is found. */
+	for (; pass <= 2;) {
+		/* Cap size to pass_end. */
+		ofs = data_pos >> 3;
+		folio_ofs = ofs & ~PAGE_MASK;
+		size = PAGE_SIZE - folio_ofs;
+		ll = ((pass_end + 7) >> 3) - ofs;
+		if (size > ll)
+			size = ll;
+		size <<= 3;
+		/*
+		 * If we are still within the active pass, search the next page
+		 * for a zero bit.
+		 */
+		if (size) {
+			folio = ntfs_read_mapping_folio(mftbmp_mapping,
+					ofs >> PAGE_SHIFT);
+			if (IS_ERR(folio)) {
+				ntfs_error(vol->sb, "Failed to read mft bitmap, aborting.");
+				return PTR_ERR(folio);
+			}
+			folio_lock(folio);
+			buf = (u8 *)kmap_local_folio(folio, 0) + folio_ofs;
+			bit = data_pos & 7;
+			data_pos &= ~7ull;
+			ntfs_debug("Before inner for loop: size 0x%x, data_pos 0x%llx, bit 0x%llx",
+					size, data_pos, bit);
+			for (; bit < size && data_pos + bit < pass_end;
+					bit &= ~7ull, bit += 8) {
+				byte = buf + (bit >> 3);
+				if (*byte == 0xff)
+					continue;
+				b = ffz((unsigned long)*byte);
+				if (b < 8 && b >= (bit & 7)) {
+					ll = data_pos + (bit & ~7ull) + b;
+					if (unlikely(ll > (1ll << 32))) {
+						folio_unlock(folio);
+						ntfs_unmap_folio(folio, buf);
+						return -ENOSPC;
+					}
+					*byte |= 1 << b;
+					flush_dcache_folio(folio);
+					folio_mark_dirty(folio);
+					folio_unlock(folio);
+					ntfs_unmap_folio(folio, buf);
+					ntfs_debug("Done.  (Found and allocated mft record 0x%llx.)",
+							ll);
+					return ll;
+				}
+			}
+			ntfs_debug("After inner for loop: size 0x%x, data_pos 0x%llx, bit 0x%llx",
+					size, data_pos, bit);
+			data_pos += size;
+			folio_unlock(folio);
+			ntfs_unmap_folio(folio, buf);
+			/*
+			 * If the end of the pass has not been reached yet,
+			 * continue searching the mft bitmap for a zero bit.
+			 */
+			if (data_pos < pass_end)
+				continue;
+		}
+		/* Do the next pass. */
+		if (++pass == 2) {
+			/*
+			 * Starting the second pass, in which we scan the first
+			 * part of the zone which we omitted earlier.
+			 */
+			pass_end = pass_start;
+			data_pos = pass_start = 24;
+			ntfs_debug("pass %i, pass_start 0x%llx, pass_end 0x%llx.",
+					pass, pass_start, pass_end);
+			if (data_pos >= pass_end)
+				break;
+		}
+	}
+	/* No free mft records in currently initialized mft bitmap. */
+	ntfs_debug("Done.  (No free mft records left in currently initialized mft bitmap.)");
+	return -ENOSPC;
+}
+
+/**
+ * ntfs_mft_bitmap_extend_allocation_nolock - extend mft bitmap by a cluster
+ * @vol:	volume on which to extend the mft bitmap attribute
+ *
+ * Extend the mft bitmap attribute on the ntfs volume @vol by one cluster.
+ *
+ * Note: Only changes allocated_size, i.e. does not touch initialized_size or
+ * data_size.
+ *
+ * Return 0 on success and -errno on error.
+ *
+ * Locking: - Caller must hold vol->mftbmp_lock for writing.
+ *	    - This function takes NTFS_I(vol->mftbmp_ino)->runlist.lock for
+ *	      writing and releases it before returning.
+ *	    - This function takes vol->lcnbmp_lock for writing and releases it
+ *	      before returning.
+ */
+static int ntfs_mft_bitmap_extend_allocation_nolock(struct ntfs_volume *vol)
+{
+	s64 lcn;
+	s64 ll;
+	unsigned long flags;
+	struct folio *folio;
+	struct ntfs_inode *mft_ni, *mftbmp_ni;
+	struct runlist_element *rl, *rl2 = NULL;
+	struct ntfs_attr_search_ctx *ctx = NULL;
+	struct mft_record *mrec;
+	struct attr_record *a = NULL;
+	int ret, mp_size;
+	u32 old_alen = 0;
+	u8 *b, tb;
+	struct {
+		u8 added_cluster:1;
+		u8 added_run:1;
+		u8 mp_rebuilt:1;
+	} status = { 0, 0, 0 };
+	size_t new_rl_count;
+
+	ntfs_debug("Extending mft bitmap allocation.");
+	mft_ni = NTFS_I(vol->mft_ino);
+	mftbmp_ni = NTFS_I(vol->mftbmp_ino);
+	/*
+	 * Determine the last lcn of the mft bitmap.  The allocated size of the
+	 * mft bitmap cannot be zero so we are ok to do this.
+	 */
+	down_write(&mftbmp_ni->runlist.lock);
+	read_lock_irqsave(&mftbmp_ni->size_lock, flags);
+	ll = mftbmp_ni->allocated_size;
+	read_unlock_irqrestore(&mftbmp_ni->size_lock, flags);
+	rl = ntfs_attr_find_vcn_nolock(mftbmp_ni,
+			(ll - 1) >> vol->cluster_size_bits, NULL);
+	if (IS_ERR(rl) || unlikely(!rl->length || rl->lcn < 0)) {
+		up_write(&mftbmp_ni->runlist.lock);
+		ntfs_error(vol->sb,
+			"Failed to determine last allocated cluster of mft bitmap attribute.");
+		if (!IS_ERR(rl))
+			ret = -EIO;
+		else
+			ret = PTR_ERR(rl);
+		return ret;
+	}
+	lcn = rl->lcn + rl->length;
+	ntfs_debug("Last lcn of mft bitmap attribute is 0x%llx.",
+			(long long)lcn);
+	/*
+	 * Attempt to get the cluster following the last allocated cluster by
+	 * hand as it may be in the MFT zone so the allocator would not give it
+	 * to us.
+	 */
+	ll = lcn >> 3;
+	folio = ntfs_read_mapping_folio(vol->lcnbmp_ino->i_mapping,
+			ll >> PAGE_SHIFT);
+	if (IS_ERR(folio)) {
+		up_write(&mftbmp_ni->runlist.lock);
+		ntfs_error(vol->sb, "Failed to read from lcn bitmap.");
+		return PTR_ERR(folio);
+	}
+
+	down_write(&vol->lcnbmp_lock);
+	folio_lock(folio);
+	b = (u8 *)kmap_local_folio(folio, 0) + (ll & ~PAGE_MASK);
+	tb = 1 << (lcn & 7ull);
+	if (*b != 0xff && !(*b & tb)) {
+		/* Next cluster is free, allocate it. */
+		*b |= tb;
+		flush_dcache_folio(folio);
+		folio_mark_dirty(folio);
+		folio_unlock(folio);
+		ntfs_unmap_folio(folio, b);
+		up_write(&vol->lcnbmp_lock);
+		/* Update the mft bitmap runlist. */
+		rl->length++;
+		rl[1].vcn++;
+		status.added_cluster = 1;
+		ntfs_debug("Appending one cluster to mft bitmap.");
+	} else {
+		folio_unlock(folio);
+		ntfs_unmap_folio(folio, b);
+		up_write(&vol->lcnbmp_lock);
+		/* Allocate a cluster from the DATA_ZONE. */
+		rl2 = ntfs_cluster_alloc(vol, rl[1].vcn, 1, lcn, DATA_ZONE,
+				true, false, false);
+		if (IS_ERR(rl2)) {
+			up_write(&mftbmp_ni->runlist.lock);
+			ntfs_error(vol->sb,
+					"Failed to allocate a cluster for the mft bitmap.");
+			return PTR_ERR(rl2);
+		}
+		rl = ntfs_runlists_merge(&mftbmp_ni->runlist, rl2, 0, &new_rl_count);
+		if (IS_ERR(rl)) {
+			up_write(&mftbmp_ni->runlist.lock);
+			ntfs_error(vol->sb, "Failed to merge runlists for mft bitmap.");
+			if (ntfs_cluster_free_from_rl(vol, rl2)) {
+				ntfs_error(vol->sb, "Failed to deallocate allocated cluster.%s",
+						es);
+				NVolSetErrors(vol);
+			}
+			ntfs_free(rl2);
+			return PTR_ERR(rl);
+		}
+		mftbmp_ni->runlist.rl = rl;
+		mftbmp_ni->runlist.count = new_rl_count;
+		status.added_run = 1;
+		ntfs_debug("Adding one run to mft bitmap.");
+		/* Find the last run in the new runlist. */
+		for (; rl[1].length; rl++)
+			;
+	}
+	/*
+	 * Update the attribute record as well.  Note: @rl is the last
+	 * (non-terminator) runlist element of mft bitmap.
+	 */
+	mrec = map_mft_record(mft_ni);
+	if (IS_ERR(mrec)) {
+		ntfs_error(vol->sb, "Failed to map mft record.");
+		ret = PTR_ERR(mrec);
+		goto undo_alloc;
+	}
+	ctx = ntfs_attr_get_search_ctx(mft_ni, mrec);
+	if (unlikely(!ctx)) {
+		ntfs_error(vol->sb, "Failed to get search context.");
+		ret = -ENOMEM;
+		goto undo_alloc;
+	}
+	ret = ntfs_attr_lookup(mftbmp_ni->type, mftbmp_ni->name,
+			mftbmp_ni->name_len, CASE_SENSITIVE, rl[1].vcn, NULL,
+			0, ctx);
+	if (unlikely(ret)) {
+		ntfs_error(vol->sb,
+			"Failed to find last attribute extent of mft bitmap attribute.");
+		if (ret == -ENOENT)
+			ret = -EIO;
+		goto undo_alloc;
+	}
+	a = ctx->attr;
+	ll = le64_to_cpu(a->data.non_resident.lowest_vcn);
+	/* Search back for the previous last allocated cluster of mft bitmap. */
+	for (rl2 = rl; rl2 > mftbmp_ni->runlist.rl; rl2--) {
+		if (ll >= rl2->vcn)
+			break;
+	}
+	BUG_ON(ll < rl2->vcn);
+	BUG_ON(ll >= rl2->vcn + rl2->length);
+	/* Get the size for the new mapping pairs array for this extent. */
+	mp_size = ntfs_get_size_for_mapping_pairs(vol, rl2, ll, -1, -1);
+	if (unlikely(mp_size <= 0)) {
+		ntfs_error(vol->sb,
+			"Get size for mapping pairs failed for mft bitmap attribute extent.");
+		ret = mp_size;
+		if (!ret)
+			ret = -EIO;
+		goto undo_alloc;
+	}
+	/* Expand the attribute record if necessary. */
+	old_alen = le32_to_cpu(a->length);
+	ret = ntfs_attr_record_resize(ctx->mrec, a, mp_size +
+			le16_to_cpu(a->data.non_resident.mapping_pairs_offset));
+	if (unlikely(ret)) {
+		if (ret != -ENOSPC) {
+			ntfs_error(vol->sb,
+				"Failed to resize attribute record for mft bitmap attribute.");
+			goto undo_alloc;
+		}
+		/*
+		 * Note: It will need to be a special mft record and if none of
+		 * those are available it gets rather complicated...
+		 */
+		ntfs_error(vol->sb,
+			"Not enough space in this mft record to accommodate extended mft bitmap attribute extent.  Cannot handle this yet.");
+		ret = -EOPNOTSUPP;
+		goto undo_alloc;
+	}
+	status.mp_rebuilt = 1;
+	/* Generate the mapping pairs array directly into the attr record. */
+	ret = ntfs_mapping_pairs_build(vol, (u8 *)a +
+			le16_to_cpu(a->data.non_resident.mapping_pairs_offset),
+			mp_size, rl2, ll, -1, NULL, NULL, NULL);
+	if (unlikely(ret)) {
+		ntfs_error(vol->sb,
+			"Failed to build mapping pairs array for mft bitmap attribute.");
+		goto undo_alloc;
+	}
+	/* Update the highest_vcn. */
+	a->data.non_resident.highest_vcn = cpu_to_le64(rl[1].vcn - 1);
+	/*
+	 * We now have extended the mft bitmap allocated_size by one cluster.
+	 * Reflect this in the struct ntfs_inode structure and the attribute record.
+	 */
+	if (a->data.non_resident.lowest_vcn) {
+		/*
+		 * We are not in the first attribute extent, switch to it, but
+		 * first ensure the changes will make it to disk later.
+		 */
+		mark_mft_record_dirty(ctx->ntfs_ino);
+		ntfs_attr_reinit_search_ctx(ctx);
+		ret = ntfs_attr_lookup(mftbmp_ni->type, mftbmp_ni->name,
+				mftbmp_ni->name_len, CASE_SENSITIVE, 0, NULL,
+				0, ctx);
+		if (unlikely(ret)) {
+			ntfs_error(vol->sb,
+				"Failed to find first attribute extent of mft bitmap attribute.");
+			goto restore_undo_alloc;
+		}
+		a = ctx->attr;
+	}
+	write_lock_irqsave(&mftbmp_ni->size_lock, flags);
+	mftbmp_ni->allocated_size += vol->cluster_size;
+	a->data.non_resident.allocated_size =
+			cpu_to_le64(mftbmp_ni->allocated_size);
+	write_unlock_irqrestore(&mftbmp_ni->size_lock, flags);
+	/* Ensure the changes make it to disk. */
+	mark_mft_record_dirty(ctx->ntfs_ino);
+	ntfs_attr_put_search_ctx(ctx);
+	unmap_mft_record(mft_ni);
+	up_write(&mftbmp_ni->runlist.lock);
+	ntfs_debug("Done.");
+	return 0;
+
+restore_undo_alloc:
+	ntfs_attr_reinit_search_ctx(ctx);
+	if (ntfs_attr_lookup(mftbmp_ni->type, mftbmp_ni->name,
+			mftbmp_ni->name_len, CASE_SENSITIVE, rl[1].vcn, NULL,
+			0, ctx)) {
+		ntfs_error(vol->sb,
+			"Failed to find last attribute extent of mft bitmap attribute.%s", es);
+		write_lock_irqsave(&mftbmp_ni->size_lock, flags);
+		mftbmp_ni->allocated_size += vol->cluster_size;
+		write_unlock_irqrestore(&mftbmp_ni->size_lock, flags);
+		ntfs_attr_put_search_ctx(ctx);
+		unmap_mft_record(mft_ni);
+		up_write(&mftbmp_ni->runlist.lock);
+		/*
+		 * The only thing that is now wrong is ->allocated_size of the
+		 * base attribute extent which chkdsk should be able to fix.
+		 */
+		NVolSetErrors(vol);
+		return ret;
+	}
+	a = ctx->attr;
+	a->data.non_resident.highest_vcn = cpu_to_le64(rl[1].vcn - 2);
+undo_alloc:
+	if (status.added_cluster) {
+		/* Truncate the last run in the runlist by one cluster. */
+		rl->length--;
+		rl[1].vcn--;
+	} else if (status.added_run) {
+		lcn = rl->lcn;
+		/* Remove the last run from the runlist. */
+		rl->lcn = rl[1].lcn;
+		rl->length = 0;
+	}
+	/* Deallocate the cluster. */
+	down_write(&vol->lcnbmp_lock);
+	if (ntfs_bitmap_clear_bit(vol->lcnbmp_ino, lcn)) {
+		ntfs_error(vol->sb, "Failed to free allocated cluster.%s", es);
+		NVolSetErrors(vol);
+	} else
+		ntfs_inc_free_clusters(vol, 1);
+	up_write(&vol->lcnbmp_lock);
+	if (status.mp_rebuilt) {
+		if (ntfs_mapping_pairs_build(vol, (u8 *)a + le16_to_cpu(
+				a->data.non_resident.mapping_pairs_offset),
+				old_alen - le16_to_cpu(
+				a->data.non_resident.mapping_pairs_offset),
+				rl2, ll, -1, NULL, NULL, NULL)) {
+			ntfs_error(vol->sb, "Failed to restore mapping pairs array.%s", es);
+			NVolSetErrors(vol);
+		}
+		if (ntfs_attr_record_resize(ctx->mrec, a, old_alen)) {
+			ntfs_error(vol->sb, "Failed to restore attribute record.%s", es);
+			NVolSetErrors(vol);
+		}
+		mark_mft_record_dirty(ctx->ntfs_ino);
+	}
+	if (ctx)
+		ntfs_attr_put_search_ctx(ctx);
+	if (!IS_ERR(mrec))
+		unmap_mft_record(mft_ni);
+	up_write(&mftbmp_ni->runlist.lock);
+	return ret;
+}
+
+/**
+ * ntfs_mft_bitmap_extend_initialized_nolock - extend mftbmp initialized data
+ * @vol:	volume on which to extend the mft bitmap attribute
+ *
+ * Extend the initialized portion of the mft bitmap attribute on the ntfs
+ * volume @vol by 8 bytes.
+ *
+ * Note:  Only changes initialized_size and data_size, i.e. requires that
+ * allocated_size is big enough to fit the new initialized_size.
+ *
+ * Return 0 on success and -error on error.
+ *
+ * Locking: Caller must hold vol->mftbmp_lock for writing.
+ */
+static int ntfs_mft_bitmap_extend_initialized_nolock(struct ntfs_volume *vol)
+{
+	s64 old_data_size, old_initialized_size;
+	unsigned long flags;
+	struct inode *mftbmp_vi;
+	struct ntfs_inode *mft_ni, *mftbmp_ni;
+	struct ntfs_attr_search_ctx *ctx;
+	struct mft_record *mrec;
+	struct attr_record *a;
+	int ret;
+
+	ntfs_debug("Extending mft bitmap initiailized (and data) size.");
+	mft_ni = NTFS_I(vol->mft_ino);
+	mftbmp_vi = vol->mftbmp_ino;
+	mftbmp_ni = NTFS_I(mftbmp_vi);
+	/* Get the attribute record. */
+	mrec = map_mft_record(mft_ni);
+	if (IS_ERR(mrec)) {
+		ntfs_error(vol->sb, "Failed to map mft record.");
+		return PTR_ERR(mrec);
+	}
+	ctx = ntfs_attr_get_search_ctx(mft_ni, mrec);
+	if (unlikely(!ctx)) {
+		ntfs_error(vol->sb, "Failed to get search context.");
+		ret = -ENOMEM;
+		goto unm_err_out;
+	}
+	ret = ntfs_attr_lookup(mftbmp_ni->type, mftbmp_ni->name,
+			mftbmp_ni->name_len, CASE_SENSITIVE, 0, NULL, 0, ctx);
+	if (unlikely(ret)) {
+		ntfs_error(vol->sb,
+			"Failed to find first attribute extent of mft bitmap attribute.");
+		if (ret == -ENOENT)
+			ret = -EIO;
+		goto put_err_out;
+	}
+	a = ctx->attr;
+	write_lock_irqsave(&mftbmp_ni->size_lock, flags);
+	old_data_size = i_size_read(mftbmp_vi);
+	old_initialized_size = mftbmp_ni->initialized_size;
+	/*
+	 * We can simply update the initialized_size before filling the space
+	 * with zeroes because the caller is holding the mft bitmap lock for
+	 * writing which ensures that no one else is trying to access the data.
+	 */
+	mftbmp_ni->initialized_size += 8;
+	a->data.non_resident.initialized_size =
+			cpu_to_le64(mftbmp_ni->initialized_size);
+	if (mftbmp_ni->initialized_size > old_data_size) {
+		i_size_write(mftbmp_vi, mftbmp_ni->initialized_size);
+		a->data.non_resident.data_size =
+				cpu_to_le64(mftbmp_ni->initialized_size);
+	}
+	write_unlock_irqrestore(&mftbmp_ni->size_lock, flags);
+	/* Ensure the changes make it to disk. */
+	mark_mft_record_dirty(ctx->ntfs_ino);
+	ntfs_attr_put_search_ctx(ctx);
+	unmap_mft_record(mft_ni);
+	/* Initialize the mft bitmap attribute value with zeroes. */
+	ret = ntfs_attr_set(mftbmp_ni, old_initialized_size, 8, 0);
+	if (likely(!ret)) {
+		ntfs_debug("Done.  (Wrote eight initialized bytes to mft bitmap.");
+		ntfs_inc_free_mft_records(vol, 8 * 8);
+		return 0;
+	}
+	ntfs_error(vol->sb, "Failed to write to mft bitmap.");
+	/* Try to recover from the error. */
+	mrec = map_mft_record(mft_ni);
+	if (IS_ERR(mrec)) {
+		ntfs_error(vol->sb, "Failed to map mft record.%s", es);
+		NVolSetErrors(vol);
+		return ret;
+	}
+	ctx = ntfs_attr_get_search_ctx(mft_ni, mrec);
+	if (unlikely(!ctx)) {
+		ntfs_error(vol->sb, "Failed to get search context.%s", es);
+		NVolSetErrors(vol);
+		goto unm_err_out;
+	}
+	if (ntfs_attr_lookup(mftbmp_ni->type, mftbmp_ni->name,
+			mftbmp_ni->name_len, CASE_SENSITIVE, 0, NULL, 0, ctx)) {
+		ntfs_error(vol->sb,
+			"Failed to find first attribute extent of mft bitmap attribute.%s", es);
+		NVolSetErrors(vol);
+put_err_out:
+		ntfs_attr_put_search_ctx(ctx);
+unm_err_out:
+		unmap_mft_record(mft_ni);
+		goto err_out;
+	}
+	a = ctx->attr;
+	write_lock_irqsave(&mftbmp_ni->size_lock, flags);
+	mftbmp_ni->initialized_size = old_initialized_size;
+	a->data.non_resident.initialized_size =
+			cpu_to_le64(old_initialized_size);
+	if (i_size_read(mftbmp_vi) != old_data_size) {
+		i_size_write(mftbmp_vi, old_data_size);
+		a->data.non_resident.data_size = cpu_to_le64(old_data_size);
+	}
+	write_unlock_irqrestore(&mftbmp_ni->size_lock, flags);
+	mark_mft_record_dirty(ctx->ntfs_ino);
+	ntfs_attr_put_search_ctx(ctx);
+	unmap_mft_record(mft_ni);
+#ifdef DEBUG
+	read_lock_irqsave(&mftbmp_ni->size_lock, flags);
+	ntfs_debug("Restored status of mftbmp: allocated_size 0x%llx, data_size 0x%llx, initialized_size 0x%llx.",
+			mftbmp_ni->allocated_size, i_size_read(mftbmp_vi),
+			mftbmp_ni->initialized_size);
+	read_unlock_irqrestore(&mftbmp_ni->size_lock, flags);
+#endif /* DEBUG */
+err_out:
+	return ret;
+}
+
+/**
+ * ntfs_mft_data_extend_allocation_nolock - extend mft data attribute
+ * @vol:	volume on which to extend the mft data attribute
+ *
+ * Extend the mft data attribute on the ntfs volume @vol by 16 mft records
+ * worth of clusters or if not enough space for this by one mft record worth
+ * of clusters.
+ *
+ * Note:  Only changes allocated_size, i.e. does not touch initialized_size or
+ * data_size.
+ *
+ * Return 0 on success and -errno on error.
+ *
+ * Locking: - Caller must hold vol->mftbmp_lock for writing.
+ *	    - This function takes NTFS_I(vol->mft_ino)->runlist.lock for
+ *	      writing and releases it before returning.
+ *	    - This function calls functions which take vol->lcnbmp_lock for
+ *	      writing and release it before returning.
+ */
+static int ntfs_mft_data_extend_allocation_nolock(struct ntfs_volume *vol)
+{
+	s64 lcn;
+	s64 old_last_vcn;
+	s64 min_nr, nr, ll;
+	unsigned long flags;
+	struct ntfs_inode *mft_ni;
+	struct runlist_element *rl, *rl2;
+	struct ntfs_attr_search_ctx *ctx = NULL;
+	struct mft_record *mrec;
+	struct attr_record *a = NULL;
+	int ret, mp_size;
+	u32 old_alen = 0;
+	bool mp_rebuilt = false;
+	size_t new_rl_count;
+
+	ntfs_debug("Extending mft data allocation.");
+	mft_ni = NTFS_I(vol->mft_ino);
+	/*
+	 * Determine the preferred allocation location, i.e. the last lcn of
+	 * the mft data attribute.  The allocated size of the mft data
+	 * attribute cannot be zero so we are ok to do this.
+	 */
+	down_write(&mft_ni->runlist.lock);
+	read_lock_irqsave(&mft_ni->size_lock, flags);
+	ll = mft_ni->allocated_size;
+	read_unlock_irqrestore(&mft_ni->size_lock, flags);
+	rl = ntfs_attr_find_vcn_nolock(mft_ni,
+			(ll - 1) >> vol->cluster_size_bits, NULL);
+	if (IS_ERR(rl) || unlikely(!rl->length || rl->lcn < 0)) {
+		up_write(&mft_ni->runlist.lock);
+		ntfs_error(vol->sb,
+			"Failed to determine last allocated cluster of mft data attribute.");
+		if (!IS_ERR(rl))
+			ret = -EIO;
+		else
+			ret = PTR_ERR(rl);
+		return ret;
+	}
+	lcn = rl->lcn + rl->length;
+	ntfs_debug("Last lcn of mft data attribute is 0x%llx.", lcn);
+	/* Minimum allocation is one mft record worth of clusters. */
+	min_nr = vol->mft_record_size >> vol->cluster_size_bits;
+	if (!min_nr)
+		min_nr = 1;
+	/* Want to allocate 16 mft records worth of clusters. */
+	nr = vol->mft_record_size << 4 >> vol->cluster_size_bits;
+	if (!nr)
+		nr = min_nr;
+	/* Ensure we do not go above 2^32-1 mft records. */
+	read_lock_irqsave(&mft_ni->size_lock, flags);
+	ll = mft_ni->allocated_size;
+	read_unlock_irqrestore(&mft_ni->size_lock, flags);
+	if (unlikely((ll + (nr << vol->cluster_size_bits)) >>
+			vol->mft_record_size_bits >= (1ll << 32))) {
+		nr = min_nr;
+		if (unlikely((ll + (nr << vol->cluster_size_bits)) >>
+				vol->mft_record_size_bits >= (1ll << 32))) {
+			ntfs_warning(vol->sb,
+				"Cannot allocate mft record because the maximum number of inodes (2^32) has already been reached.");
+			up_write(&mft_ni->runlist.lock);
+			return -ENOSPC;
+		}
+	}
+	ntfs_debug("Trying mft data allocation with %s cluster count %lli.",
+			nr > min_nr ? "default" : "minimal", (long long)nr);
+	old_last_vcn = rl[1].vcn;
+	/*
+	 * We can release the mft_ni runlist lock, Because this function is
+	 * the only one that expends $MFT data attribute and is called with
+	 * mft_ni->mrec_lock.
+	 * This is required for the lock order, vol->lcnbmp_lock =>
+	 * mft_ni->runlist.lock.
+	 */
+	up_write(&mft_ni->runlist.lock);
+
+	do {
+		rl2 = ntfs_cluster_alloc(vol, old_last_vcn, nr, lcn, MFT_ZONE,
+				true, false, false);
+		if (!IS_ERR(rl2))
+			break;
+		if (PTR_ERR(rl2) != -ENOSPC || nr == min_nr) {
+			ntfs_error(vol->sb,
+				"Failed to allocate the minimal number of clusters (%lli) for the mft data attribute.",
+				nr);
+			return PTR_ERR(rl2);
+		}
+		/*
+		 * There is not enough space to do the allocation, but there
+		 * might be enough space to do a minimal allocation so try that
+		 * before failing.
+		 */
+		nr = min_nr;
+		ntfs_debug("Retrying mft data allocation with minimal cluster count %lli.", nr);
+	} while (1);
+
+	down_write(&mft_ni->runlist.lock);
+	rl = ntfs_runlists_merge(&mft_ni->runlist, rl2, 0, &new_rl_count);
+	if (IS_ERR(rl)) {
+		up_write(&mft_ni->runlist.lock);
+		ntfs_error(vol->sb, "Failed to merge runlists for mft data attribute.");
+		if (ntfs_cluster_free_from_rl(vol, rl2)) {
+			ntfs_error(vol->sb,
+				"Failed to deallocate clusters from the mft data attribute.%s", es);
+			NVolSetErrors(vol);
+		}
+		ntfs_free(rl2);
+		return PTR_ERR(rl);
+	}
+	mft_ni->runlist.rl = rl;
+	mft_ni->runlist.count = new_rl_count;
+	ntfs_debug("Allocated %lli clusters.", (long long)nr);
+	/* Find the last run in the new runlist. */
+	for (; rl[1].length; rl++)
+		;
+	up_write(&mft_ni->runlist.lock);
+
+	/* Update the attribute record as well. */
+	mrec = map_mft_record(mft_ni);
+	if (IS_ERR(mrec)) {
+		ntfs_error(vol->sb, "Failed to map mft record.");
+		ret = PTR_ERR(mrec);
+		down_write(&mft_ni->runlist.lock);
+		goto undo_alloc;
+	}
+	ctx = ntfs_attr_get_search_ctx(mft_ni, mrec);
+	if (unlikely(!ctx)) {
+		ntfs_error(vol->sb, "Failed to get search context.");
+		ret = -ENOMEM;
+		down_write(&mft_ni->runlist.lock);
+		goto undo_alloc;
+	}
+	ret = ntfs_attr_lookup(mft_ni->type, mft_ni->name, mft_ni->name_len,
+			CASE_SENSITIVE, rl[1].vcn, NULL, 0, ctx);
+	if (unlikely(ret)) {
+		ntfs_error(vol->sb, "Failed to find last attribute extent of mft data attribute.");
+		if (ret == -ENOENT)
+			ret = -EIO;
+		down_write(&mft_ni->runlist.lock);
+		goto undo_alloc;
+	}
+	a = ctx->attr;
+	ll = le64_to_cpu(a->data.non_resident.lowest_vcn);
+
+	down_write(&mft_ni->runlist.lock);
+	/* Search back for the previous last allocated cluster of mft bitmap. */
+	for (rl2 = rl; rl2 > mft_ni->runlist.rl; rl2--) {
+		if (ll >= rl2->vcn)
+			break;
+	}
+	BUG_ON(ll < rl2->vcn);
+	BUG_ON(ll >= rl2->vcn + rl2->length);
+	/* Get the size for the new mapping pairs array for this extent. */
+	mp_size = ntfs_get_size_for_mapping_pairs(vol, rl2, ll, -1, -1);
+	if (unlikely(mp_size <= 0)) {
+		ntfs_error(vol->sb,
+			"Get size for mapping pairs failed for mft data attribute extent.");
+		ret = mp_size;
+		if (!ret)
+			ret = -EIO;
+		goto undo_alloc;
+	}
+	/* Expand the attribute record if necessary. */
+	old_alen = le32_to_cpu(a->length);
+	ret = ntfs_attr_record_resize(ctx->mrec, a, mp_size +
+			le16_to_cpu(a->data.non_resident.mapping_pairs_offset));
+	if (unlikely(ret)) {
+		if (ret != -ENOSPC) {
+			ntfs_error(vol->sb,
+				"Failed to resize attribute record for mft data attribute.");
+			goto undo_alloc;
+		}
+		/*
+		 * Note: Use the special reserved mft records and ensure that
+		 * this extent is not required to find the mft record in
+		 * question.  If no free special records left we would need to
+		 * move an existing record away, insert ours in its place, and
+		 * then place the moved record into the newly allocated space
+		 * and we would then need to update all references to this mft
+		 * record appropriately.  This is rather complicated...
+		 */
+		ntfs_error(vol->sb,
+			"Not enough space in this mft record to accommodate extended mft data attribute extent.  Cannot handle this yet.");
+		ret = -EOPNOTSUPP;
+		goto undo_alloc;
+	}
+	mp_rebuilt = true;
+	/* Generate the mapping pairs array directly into the attr record. */
+	ret = ntfs_mapping_pairs_build(vol, (u8 *)a +
+			le16_to_cpu(a->data.non_resident.mapping_pairs_offset),
+			mp_size, rl2, ll, -1, NULL, NULL, NULL);
+	if (unlikely(ret)) {
+		ntfs_error(vol->sb, "Failed to build mapping pairs array of mft data attribute.");
+		goto undo_alloc;
+	}
+	/* Update the highest_vcn. */
+	a->data.non_resident.highest_vcn = cpu_to_le64(rl[1].vcn - 1);
+	/*
+	 * We now have extended the mft data allocated_size by nr clusters.
+	 * Reflect this in the struct ntfs_inode structure and the attribute record.
+	 * @rl is the last (non-terminator) runlist element of mft data
+	 * attribute.
+	 */
+	up_write(&mft_ni->runlist.lock);
+	if (a->data.non_resident.lowest_vcn) {
+		/*
+		 * We are not in the first attribute extent, switch to it, but
+		 * first ensure the changes will make it to disk later.
+		 */
+		mark_mft_record_dirty(ctx->ntfs_ino);
+		ntfs_attr_reinit_search_ctx(ctx);
+		ret = ntfs_attr_lookup(mft_ni->type, mft_ni->name,
+				mft_ni->name_len, CASE_SENSITIVE, 0, NULL, 0,
+				ctx);
+		if (unlikely(ret)) {
+			ntfs_error(vol->sb,
+				"Failed to find first attribute extent of mft data attribute.");
+			goto restore_undo_alloc;
+		}
+		a = ctx->attr;
+	}
+	write_lock_irqsave(&mft_ni->size_lock, flags);
+	mft_ni->allocated_size += nr << vol->cluster_size_bits;
+	a->data.non_resident.allocated_size =
+			cpu_to_le64(mft_ni->allocated_size);
+	write_unlock_irqrestore(&mft_ni->size_lock, flags);
+	/* Ensure the changes make it to disk. */
+	mark_mft_record_dirty(ctx->ntfs_ino);
+	ntfs_attr_put_search_ctx(ctx);
+	unmap_mft_record(mft_ni);
+	ntfs_debug("Done.");
+	return 0;
+restore_undo_alloc:
+	ntfs_attr_reinit_search_ctx(ctx);
+	if (ntfs_attr_lookup(mft_ni->type, mft_ni->name, mft_ni->name_len,
+			CASE_SENSITIVE, rl[1].vcn, NULL, 0, ctx)) {
+		ntfs_error(vol->sb,
+			"Failed to find last attribute extent of mft data attribute.%s", es);
+		write_lock_irqsave(&mft_ni->size_lock, flags);
+		mft_ni->allocated_size += nr << vol->cluster_size_bits;
+		write_unlock_irqrestore(&mft_ni->size_lock, flags);
+		ntfs_attr_put_search_ctx(ctx);
+		unmap_mft_record(mft_ni);
+		up_write(&mft_ni->runlist.lock);
+		/*
+		 * The only thing that is now wrong is ->allocated_size of the
+		 * base attribute extent which chkdsk should be able to fix.
+		 */
+		NVolSetErrors(vol);
+		return ret;
+	}
+	ctx->attr->data.non_resident.highest_vcn =
+			cpu_to_le64(old_last_vcn - 1);
+undo_alloc:
+	if (ntfs_cluster_free(mft_ni, old_last_vcn, -1, ctx) < 0) {
+		ntfs_error(vol->sb, "Failed to free clusters from mft data attribute.%s", es);
+		NVolSetErrors(vol);
+	}
+
+	if (ntfs_rl_truncate_nolock(vol, &mft_ni->runlist, old_last_vcn)) {
+		ntfs_error(vol->sb, "Failed to truncate mft data attribute runlist.%s", es);
+		NVolSetErrors(vol);
+	}
+	up_write(&mft_ni->runlist.lock);
+	if (ctx) {
+		a = ctx->attr;
+		if (mp_rebuilt && !IS_ERR(ctx->mrec)) {
+			if (ntfs_mapping_pairs_build(vol, (u8 *)a + le16_to_cpu(
+				a->data.non_resident.mapping_pairs_offset),
+				old_alen - le16_to_cpu(
+					a->data.non_resident.mapping_pairs_offset),
+				rl2, ll, -1, NULL, NULL, NULL)) {
+				ntfs_error(vol->sb, "Failed to restore mapping pairs array.%s", es);
+				NVolSetErrors(vol);
+			}
+			if (ntfs_attr_record_resize(ctx->mrec, a, old_alen)) {
+				ntfs_error(vol->sb, "Failed to restore attribute record.%s", es);
+				NVolSetErrors(vol);
+			}
+			mark_mft_record_dirty(ctx->ntfs_ino);
+		} else if (IS_ERR(ctx->mrec)) {
+			ntfs_error(vol->sb, "Failed to restore attribute search context.%s", es);
+			NVolSetErrors(vol);
+		}
+		ntfs_attr_put_search_ctx(ctx);
+	}
+	if (!IS_ERR(mrec))
+		unmap_mft_record(mft_ni);
+	return ret;
+}
+
+/**
+ * ntfs_mft_record_layout - layout an mft record into a memory buffer
+ * @vol:	volume to which the mft record will belong
+ * @mft_no:	mft reference specifying the mft record number
+ * @m:		destination buffer of size >= @vol->mft_record_size bytes
+ *
+ * Layout an empty, unused mft record with the mft record number @mft_no into
+ * the buffer @m.  The volume @vol is needed because the mft record structure
+ * was modified in NTFS 3.1 so we need to know which volume version this mft
+ * record will be used on.
+ *
+ * Return 0 on success and -errno on error.
+ */
+static int ntfs_mft_record_layout(const struct ntfs_volume *vol, const s64 mft_no,
+		struct mft_record *m)
+{
+	struct attr_record *a;
+
+	ntfs_debug("Entering for mft record 0x%llx.", (long long)mft_no);
+	if (mft_no >= (1ll << 32)) {
+		ntfs_error(vol->sb, "Mft record number 0x%llx exceeds maximum of 2^32.",
+				(long long)mft_no);
+		return -ERANGE;
+	}
+	/* Start by clearing the whole mft record to gives us a clean slate. */
+	memset(m, 0, vol->mft_record_size);
+	/* Aligned to 2-byte boundary. */
+	if (vol->major_ver < 3 || (vol->major_ver == 3 && !vol->minor_ver))
+		m->usa_ofs = cpu_to_le16((sizeof(struct mft_record_old) + 1) & ~1);
+	else {
+		m->usa_ofs = cpu_to_le16((sizeof(struct mft_record) + 1) & ~1);
+		/*
+		 * Set the NTFS 3.1+ specific fields while we know that the
+		 * volume version is 3.1+.
+		 */
+		m->reserved = 0;
+		m->mft_record_number = cpu_to_le32((u32)mft_no);
+	}
+	m->magic = magic_FILE;
+	if (vol->mft_record_size >= NTFS_BLOCK_SIZE)
+		m->usa_count = cpu_to_le16(vol->mft_record_size /
+				NTFS_BLOCK_SIZE + 1);
+	else {
+		m->usa_count = cpu_to_le16(1);
+		ntfs_warning(vol->sb,
+			"Sector size is bigger than mft record size.  Setting usa_count to 1.  If chkdsk reports this as corruption");
+	}
+	/* Set the update sequence number to 1. */
+	*(__le16 *)((u8 *)m + le16_to_cpu(m->usa_ofs)) = cpu_to_le16(1);
+	m->lsn = 0;
+	m->sequence_number = cpu_to_le16(1);
+	m->link_count = 0;
+	/*
+	 * Place the attributes straight after the update sequence array,
+	 * aligned to 8-byte boundary.
+	 */
+	m->attrs_offset = cpu_to_le16((le16_to_cpu(m->usa_ofs) +
+			(le16_to_cpu(m->usa_count) << 1) + 7) & ~7);
+	m->flags = 0;
+	/*
+	 * Using attrs_offset plus eight bytes (for the termination attribute).
+	 * attrs_offset is already aligned to 8-byte boundary, so no need to
+	 * align again.
+	 */
+	m->bytes_in_use = cpu_to_le32(le16_to_cpu(m->attrs_offset) + 8);
+	m->bytes_allocated = cpu_to_le32(vol->mft_record_size);
+	m->base_mft_record = 0;
+	m->next_attr_instance = 0;
+	/* Add the termination attribute. */
+	a = (struct attr_record *)((u8 *)m + le16_to_cpu(m->attrs_offset));
+	a->type = AT_END;
+	a->length = 0;
+	ntfs_debug("Done.");
+	return 0;
+}
+
+/**
+ * ntfs_mft_record_format - format an mft record on an ntfs volume
+ * @vol:	volume on which to format the mft record
+ * @mft_no:	mft record number to format
+ *
+ * Format the mft record @mft_no in $MFT/$DATA, i.e. lay out an empty, unused
+ * mft record into the appropriate place of the mft data attribute.  This is
+ * used when extending the mft data attribute.
+ *
+ * Return 0 on success and -errno on error.
+ */
+static int ntfs_mft_record_format(const struct ntfs_volume *vol, const s64 mft_no)
+{
+	loff_t i_size;
+	struct inode *mft_vi = vol->mft_ino;
+	struct folio *folio;
+	struct mft_record *m;
+	pgoff_t index, end_index;
+	unsigned int ofs;
+	int err;
+
+	ntfs_debug("Entering for mft record 0x%llx.", (long long)mft_no);
+	/*
+	 * The index into the page cache and the offset within the page cache
+	 * page of the wanted mft record.
+	 */
+	index = mft_no << vol->mft_record_size_bits >> PAGE_SHIFT;
+	ofs = (mft_no << vol->mft_record_size_bits) & ~PAGE_MASK;
+	/* The maximum valid index into the page cache for $MFT's data. */
+	i_size = i_size_read(mft_vi);
+	end_index = i_size >> PAGE_SHIFT;
+	if (unlikely(index >= end_index)) {
+		if (unlikely(index > end_index ||
+			     ofs + vol->mft_record_size > (i_size & ~PAGE_MASK))) {
+			ntfs_error(vol->sb, "Tried to format non-existing mft record 0x%llx.",
+					(long long)mft_no);
+			return -ENOENT;
+		}
+	}
+
+	/* Read, map, and pin the folio containing the mft record. */
+	folio = ntfs_read_mapping_folio(mft_vi->i_mapping, index);
+	if (IS_ERR(folio)) {
+		ntfs_error(vol->sb, "Failed to map page containing mft record to format 0x%llx.",
+				(long long)mft_no);
+		return PTR_ERR(folio);
+	}
+	folio_lock(folio);
+	BUG_ON(!folio_test_uptodate(folio));
+	folio_clear_uptodate(folio);
+	m = (struct mft_record *)((u8 *)kmap_local_folio(folio, 0) + ofs);
+	err = ntfs_mft_record_layout(vol, mft_no, m);
+	if (unlikely(err)) {
+		ntfs_error(vol->sb, "Failed to layout mft record 0x%llx.",
+				(long long)mft_no);
+		folio_mark_uptodate(folio);
+		folio_unlock(folio);
+		ntfs_unmap_folio(folio, m);
+		return err;
+	}
+	pre_write_mst_fixup((struct ntfs_record *)m, vol->mft_record_size);
+	flush_dcache_folio(folio);
+	folio_mark_uptodate(folio);
+	/*
+	 * Make sure the mft record is written out to disk.  We could use
+	 * ilookup5() to check if an inode is in icache and so on but this is
+	 * unnecessary as ntfs_writepage() will write the dirty record anyway.
+	 */
+	mark_ntfs_record_dirty(folio);
+	folio_unlock(folio);
+	ntfs_unmap_folio(folio, m);
+	ntfs_debug("Done.");
+	return 0;
+}
+
+/**
+ * ntfs_mft_record_alloc - allocate an mft record on an ntfs volume
+ * @vol:	[IN]  volume on which to allocate the mft record
+ * @mode:	[IN]  mode if want a file or directory, i.e. base inode or 0
+ * @base_ni:	[IN]  open base inode if allocating an extent mft record or NULL
+ * @ni_mrec:	[OUT] on successful return this is the mapped mft record
+ *
+ * Allocate an mft record in $MFT/$DATA of an open ntfs volume @vol.
+ *
+ * If @base_ni is NULL make the mft record a base mft record, i.e. a file or
+ * direvctory inode, and allocate it at the default allocator position.  In
+ * this case @mode is the file mode as given to us by the caller.  We in
+ * particular use @mode to distinguish whether a file or a directory is being
+ * created (S_IFDIR(mode) and S_IFREG(mode), respectively).
+ *
+ * If @base_ni is not NULL make the allocated mft record an extent record,
+ * allocate it starting at the mft record after the base mft record and attach
+ * the allocated and opened ntfs inode to the base inode @base_ni.  In this
+ * case @mode must be 0 as it is meaningless for extent inodes.
+ *
+ * You need to check the return value with IS_ERR().  If false, the function
+ * was successful and the return value is the now opened ntfs inode of the
+ * allocated mft record.  *@mrec is then set to the allocated, mapped, pinned,
+ * and locked mft record.  If IS_ERR() is true, the function failed and the
+ * error code is obtained from PTR_ERR(return value).  *@mrec is undefined in
+ * this case.
+ *
+ * Allocation strategy:
+ *
+ * To find a free mft record, we scan the mft bitmap for a zero bit.  To
+ * optimize this we start scanning at the place specified by @base_ni or if
+ * @base_ni is NULL we start where we last stopped and we perform wrap around
+ * when we reach the end.  Note, we do not try to allocate mft records below
+ * number 24 because numbers 0 to 15 are the defined system files anyway and 16
+ * to 24 are special in that they are used for storing extension mft records
+ * for the $DATA attribute of $MFT.  This is required to avoid the possibility
+ * of creating a runlist with a circular dependency which once written to disk
+ * can never be read in again.  Windows will only use records 16 to 24 for
+ * normal files if the volume is completely out of space.  We never use them
+ * which means that when the volume is really out of space we cannot create any
+ * more files while Windows can still create up to 8 small files.  We can start
+ * doing this at some later time, it does not matter much for now.
+ *
+ * When scanning the mft bitmap, we only search up to the last allocated mft
+ * record.  If there are no free records left in the range 24 to number of
+ * allocated mft records, then we extend the $MFT/$DATA attribute in order to
+ * create free mft records.  We extend the allocated size of $MFT/$DATA by 16
+ * records at a time or one cluster, if cluster size is above 16kiB.  If there
+ * is not sufficient space to do this, we try to extend by a single mft record
+ * or one cluster, if cluster size is above the mft record size.
+ *
+ * No matter how many mft records we allocate, we initialize only the first
+ * allocated mft record, incrementing mft data size and initialized size
+ * accordingly, open an struct ntfs_inode for it and return it to the caller, unless
+ * there are less than 24 mft records, in which case we allocate and initialize
+ * mft records until we reach record 24 which we consider as the first free mft
+ * record for use by normal files.
+ *
+ * If during any stage we overflow the initialized data in the mft bitmap, we
+ * extend the initialized size (and data size) by 8 bytes, allocating another
+ * cluster if required.  The bitmap data size has to be at least equal to the
+ * number of mft records in the mft, but it can be bigger, in which case the
+ * superfluous bits are padded with zeroes.
+ *
+ * Thus, when we return successfully (IS_ERR() is false), we will have:
+ *	- initialized / extended the mft bitmap if necessary,
+ *	- initialized / extended the mft data if necessary,
+ *	- set the bit corresponding to the mft record being allocated in the
+ *	  mft bitmap,
+ *	- opened an struct ntfs_inode for the allocated mft record, and we will have
+ *	- returned the struct ntfs_inode as well as the allocated mapped, pinned, and
+ *	  locked mft record.
+ *
+ * On error, the volume will be left in a consistent state and no record will
+ * be allocated.  If rolling back a partial operation fails, we may leave some
+ * inconsistent metadata in which case we set NVolErrors() so the volume is
+ * left dirty when unmounted.
+ *
+ * Note, this function cannot make use of most of the normal functions, like
+ * for example for attribute resizing, etc, because when the run list overflows
+ * the base mft record and an attribute list is used, it is very important that
+ * the extension mft records used to store the $DATA attribute of $MFT can be
+ * reached without having to read the information contained inside them, as
+ * this would make it impossible to find them in the first place after the
+ * volume is unmounted.  $MFT/$BITMAP probably does not need to follow this
+ * rule because the bitmap is not essential for finding the mft records, but on
+ * the other hand, handling the bitmap in this special way would make life
+ * easier because otherwise there might be circular invocations of functions
+ * when reading the bitmap.
+ */
+int ntfs_mft_record_alloc(struct ntfs_volume *vol, const int mode,
+			  struct ntfs_inode **ni, struct ntfs_inode *base_ni,
+			  struct mft_record **ni_mrec)
+{
+	s64 ll, bit, old_data_initialized, old_data_size;
+	unsigned long flags;
+	struct folio *folio;
+	struct ntfs_inode *mft_ni, *mftbmp_ni;
+	struct ntfs_attr_search_ctx *ctx;
+	struct mft_record *m = NULL;
+	struct attr_record *a;
+	pgoff_t index;
+	unsigned int ofs;
+	int err;
+	__le16 seq_no, usn;
+	bool record_formatted = false;
+	unsigned int memalloc_flags;
+
+	if (base_ni && *ni)
+		return -EINVAL;
+
+	if (base_ni) {
+		ntfs_debug("Entering (allocating an extent mft record for base mft record 0x%llx).",
+				(long long)base_ni->mft_no);
+		/* @mode and @base_ni are mutually exclusive. */
+		BUG_ON(mode);
+	} else
+		ntfs_debug("Entering (allocating a base mft record).");
+	if (mode) {
+		/* @mode and @base_ni are mutually exclusive. */
+		BUG_ON(base_ni);
+	}
+
+	memalloc_flags = memalloc_nofs_save();
+
+	mft_ni = NTFS_I(vol->mft_ino);
+	mutex_lock(&mft_ni->mrec_lock);
+	mftbmp_ni = NTFS_I(vol->mftbmp_ino);
+search_free_rec:
+	down_write(&vol->mftbmp_lock);
+	bit = ntfs_mft_bitmap_find_and_alloc_free_rec_nolock(vol, base_ni);
+	if (bit >= 0) {
+		ntfs_debug("Found and allocated free record (#1), bit 0x%llx.",
+				(long long)bit);
+		goto have_alloc_rec;
+	}
+	if (bit != -ENOSPC) {
+		up_write(&vol->mftbmp_lock);
+		mutex_unlock(&mft_ni->mrec_lock);
+		memalloc_nofs_restore(memalloc_flags);
+		return bit;
+	}
+
+	/*
+	 * No free mft records left.  If the mft bitmap already covers more
+	 * than the currently used mft records, the next records are all free,
+	 * so we can simply allocate the first unused mft record.
+	 * Note: We also have to make sure that the mft bitmap at least covers
+	 * the first 24 mft records as they are special and whilst they may not
+	 * be in use, we do not allocate from them.
+	 */
+	read_lock_irqsave(&mft_ni->size_lock, flags);
+	ll = mft_ni->initialized_size >> vol->mft_record_size_bits;
+	read_unlock_irqrestore(&mft_ni->size_lock, flags);
+	read_lock_irqsave(&mftbmp_ni->size_lock, flags);
+	old_data_initialized = mftbmp_ni->initialized_size;
+	read_unlock_irqrestore(&mftbmp_ni->size_lock, flags);
+	if (old_data_initialized << 3 > ll && old_data_initialized > 3) {
+		bit = ll;
+		if (bit < 24)
+			bit = 24;
+		if (unlikely(bit >= (1ll << 32)))
+			goto max_err_out;
+		ntfs_debug("Found free record (#2), bit 0x%llx.",
+				(long long)bit);
+		goto found_free_rec;
+	}
+	/*
+	 * The mft bitmap needs to be expanded until it covers the first unused
+	 * mft record that we can allocate.
+	 * Note: The smallest mft record we allocate is mft record 24.
+	 */
+	bit = old_data_initialized << 3;
+	if (unlikely(bit >= (1ll << 32)))
+		goto max_err_out;
+	read_lock_irqsave(&mftbmp_ni->size_lock, flags);
+	old_data_size = mftbmp_ni->allocated_size;
+	ntfs_debug("Status of mftbmp before extension: allocated_size 0x%llx, data_size 0x%llx, initialized_size 0x%llx.",
+			old_data_size, i_size_read(vol->mftbmp_ino),
+			old_data_initialized);
+	read_unlock_irqrestore(&mftbmp_ni->size_lock, flags);
+	if (old_data_initialized + 8 > old_data_size) {
+		/* Need to extend bitmap by one more cluster. */
+		ntfs_debug("mftbmp: initialized_size + 8 > allocated_size.");
+		err = ntfs_mft_bitmap_extend_allocation_nolock(vol);
+		if (unlikely(err)) {
+			up_write(&vol->mftbmp_lock);
+			goto err_out;
+		}
+#ifdef DEBUG
+		read_lock_irqsave(&mftbmp_ni->size_lock, flags);
+		ntfs_debug("Status of mftbmp after allocation extension: allocated_size 0x%llx, data_size 0x%llx, initialized_size 0x%llx.",
+				mftbmp_ni->allocated_size,
+				i_size_read(vol->mftbmp_ino),
+				mftbmp_ni->initialized_size);
+		read_unlock_irqrestore(&mftbmp_ni->size_lock, flags);
+#endif /* DEBUG */
+	}
+	/*
+	 * We now have sufficient allocated space, extend the initialized_size
+	 * as well as the data_size if necessary and fill the new space with
+	 * zeroes.
+	 */
+	err = ntfs_mft_bitmap_extend_initialized_nolock(vol);
+	if (unlikely(err)) {
+		up_write(&vol->mftbmp_lock);
+		goto err_out;
+	}
+#ifdef DEBUG
+	read_lock_irqsave(&mftbmp_ni->size_lock, flags);
+	ntfs_debug("Status of mftbmp after initialized extension: allocated_size 0x%llx, data_size 0x%llx, initialized_size 0x%llx.",
+			mftbmp_ni->allocated_size,
+			i_size_read(vol->mftbmp_ino),
+			mftbmp_ni->initialized_size);
+	read_unlock_irqrestore(&mftbmp_ni->size_lock, flags);
+#endif /* DEBUG */
+	ntfs_debug("Found free record (#3), bit 0x%llx.", (long long)bit);
+found_free_rec:
+	/* @bit is the found free mft record, allocate it in the mft bitmap. */
+	ntfs_debug("At found_free_rec.");
+	err = ntfs_bitmap_set_bit(vol->mftbmp_ino, bit);
+	if (unlikely(err)) {
+		ntfs_error(vol->sb, "Failed to allocate bit in mft bitmap.");
+		up_write(&vol->mftbmp_lock);
+		goto err_out;
+	}
+	ntfs_debug("Set bit 0x%llx in mft bitmap.", (long long)bit);
+have_alloc_rec:
+	/*
+	 * The mft bitmap is now uptodate.  Deal with mft data attribute now.
+	 * Note, we keep hold of the mft bitmap lock for writing until all
+	 * modifications to the mft data attribute are complete, too, as they
+	 * will impact decisions for mft bitmap and mft record allocation done
+	 * by a parallel allocation and if the lock is not maintained a
+	 * parallel allocation could allocate the same mft record as this one.
+	 */
+	ll = (bit + 1) << vol->mft_record_size_bits;
+	read_lock_irqsave(&mft_ni->size_lock, flags);
+	old_data_initialized = mft_ni->initialized_size;
+	read_unlock_irqrestore(&mft_ni->size_lock, flags);
+	if (ll <= old_data_initialized) {
+		ntfs_debug("Allocated mft record already initialized.");
+		goto mft_rec_already_initialized;
+	}
+	ntfs_debug("Initializing allocated mft record.");
+	/*
+	 * The mft record is outside the initialized data.  Extend the mft data
+	 * attribute until it covers the allocated record.  The loop is only
+	 * actually traversed more than once when a freshly formatted volume is
+	 * first written to so it optimizes away nicely in the common case.
+	 */
+	read_lock_irqsave(&mft_ni->size_lock, flags);
+	ntfs_debug("Status of mft data before extension: allocated_size 0x%llx, data_size 0x%llx, initialized_size 0x%llx.",
+			mft_ni->allocated_size, i_size_read(vol->mft_ino),
+			mft_ni->initialized_size);
+	while (ll > mft_ni->allocated_size) {
+		read_unlock_irqrestore(&mft_ni->size_lock, flags);
+		err = ntfs_mft_data_extend_allocation_nolock(vol);
+		if (unlikely(err)) {
+			ntfs_error(vol->sb, "Failed to extend mft data allocation.");
+			goto undo_mftbmp_alloc_nolock;
+		}
+		read_lock_irqsave(&mft_ni->size_lock, flags);
+		ntfs_debug("Status of mft data after allocation extension: allocated_size 0x%llx, data_size 0x%llx, initialized_size 0x%llx.",
+				mft_ni->allocated_size, i_size_read(vol->mft_ino),
+				mft_ni->initialized_size);
+	}
+	read_unlock_irqrestore(&mft_ni->size_lock, flags);
+	/*
+	 * Extend mft data initialized size (and data size of course) to reach
+	 * the allocated mft record, formatting the mft records allong the way.
+	 * Note: We only modify the struct ntfs_inode structure as that is all that is
+	 * needed by ntfs_mft_record_format().  We will update the attribute
+	 * record itself in one fell swoop later on.
+	 */
+	write_lock_irqsave(&mft_ni->size_lock, flags);
+	old_data_initialized = mft_ni->initialized_size;
+	old_data_size = vol->mft_ino->i_size;
+	while (ll > mft_ni->initialized_size) {
+		s64 new_initialized_size, mft_no;
+
+		new_initialized_size = mft_ni->initialized_size +
+				vol->mft_record_size;
+		mft_no = mft_ni->initialized_size >> vol->mft_record_size_bits;
+		if (new_initialized_size > i_size_read(vol->mft_ino))
+			i_size_write(vol->mft_ino, new_initialized_size);
+		write_unlock_irqrestore(&mft_ni->size_lock, flags);
+		ntfs_debug("Initializing mft record 0x%llx.",
+				(long long)mft_no);
+		err = ntfs_mft_record_format(vol, mft_no);
+		if (unlikely(err)) {
+			ntfs_error(vol->sb, "Failed to format mft record.");
+			goto undo_data_init;
+		}
+		write_lock_irqsave(&mft_ni->size_lock, flags);
+		mft_ni->initialized_size = new_initialized_size;
+	}
+	write_unlock_irqrestore(&mft_ni->size_lock, flags);
+	record_formatted = true;
+	/* Update the mft data attribute record to reflect the new sizes. */
+	m = map_mft_record(mft_ni);
+	if (IS_ERR(m)) {
+		ntfs_error(vol->sb, "Failed to map mft record.");
+		err = PTR_ERR(m);
+		goto undo_data_init;
+	}
+	ctx = ntfs_attr_get_search_ctx(mft_ni, m);
+	if (unlikely(!ctx)) {
+		ntfs_error(vol->sb, "Failed to get search context.");
+		err = -ENOMEM;
+		unmap_mft_record(mft_ni);
+		goto undo_data_init;
+	}
+	err = ntfs_attr_lookup(mft_ni->type, mft_ni->name, mft_ni->name_len,
+			CASE_SENSITIVE, 0, NULL, 0, ctx);
+	if (unlikely(err)) {
+		ntfs_error(vol->sb, "Failed to find first attribute extent of mft data attribute.");
+		ntfs_attr_put_search_ctx(ctx);
+		unmap_mft_record(mft_ni);
+		goto undo_data_init;
+	}
+	a = ctx->attr;
+	read_lock_irqsave(&mft_ni->size_lock, flags);
+	a->data.non_resident.initialized_size =
+			cpu_to_le64(mft_ni->initialized_size);
+	a->data.non_resident.data_size =
+			cpu_to_le64(i_size_read(vol->mft_ino));
+	read_unlock_irqrestore(&mft_ni->size_lock, flags);
+	/* Ensure the changes make it to disk. */
+	mark_mft_record_dirty(ctx->ntfs_ino);
+	ntfs_attr_put_search_ctx(ctx);
+	unmap_mft_record(mft_ni);
+	read_lock_irqsave(&mft_ni->size_lock, flags);
+	ntfs_debug("Status of mft data after mft record initialization: allocated_size 0x%llx, data_size 0x%llx, initialized_size 0x%llx.",
+			mft_ni->allocated_size,	i_size_read(vol->mft_ino),
+			mft_ni->initialized_size);
+	BUG_ON(i_size_read(vol->mft_ino) > mft_ni->allocated_size);
+	BUG_ON(mft_ni->initialized_size > i_size_read(vol->mft_ino));
+	read_unlock_irqrestore(&mft_ni->size_lock, flags);
+mft_rec_already_initialized:
+	/*
+	 * We can finally drop the mft bitmap lock as the mft data attribute
+	 * has been fully updated.  The only disparity left is that the
+	 * allocated mft record still needs to be marked as in use to match the
+	 * set bit in the mft bitmap but this is actually not a problem since
+	 * this mft record is not referenced from anywhere yet and the fact
+	 * that it is allocated in the mft bitmap means that no-one will try to
+	 * allocate it either.
+	 */
+	up_write(&vol->mftbmp_lock);
+	/*
+	 * We now have allocated and initialized the mft record.  Calculate the
+	 * index of and the offset within the page cache page the record is in.
+	 */
+	index = bit << vol->mft_record_size_bits >> PAGE_SHIFT;
+	ofs = (bit << vol->mft_record_size_bits) & ~PAGE_MASK;
+	/* Read, map, and pin the folio containing the mft record. */
+	folio = ntfs_read_mapping_folio(vol->mft_ino->i_mapping, index);
+	if (IS_ERR(folio)) {
+		ntfs_error(vol->sb, "Failed to map page containing allocated mft record 0x%llx.",
+				bit);
+		err = PTR_ERR(folio);
+		goto undo_mftbmp_alloc;
+	}
+	folio_lock(folio);
+	BUG_ON(!folio_test_uptodate(folio));
+	folio_clear_uptodate(folio);
+	m = (struct mft_record *)((u8 *)kmap_local_folio(folio, 0) + ofs);
+	/* If we just formatted the mft record no need to do it again. */
+	if (!record_formatted) {
+		/* Sanity check that the mft record is really not in use. */
+		if (ntfs_is_file_record(m->magic) &&
+				(m->flags & MFT_RECORD_IN_USE)) {
+			ntfs_warning(vol->sb,
+				"Mft record 0x%llx was marked free in mft bitmap but is marked used itself. Unmount and run chkdsk.",
+				bit);
+			folio_mark_uptodate(folio);
+			folio_unlock(folio);
+			ntfs_unmap_folio(folio, m);
+			NVolSetErrors(vol);
+			goto search_free_rec;
+		}
+		/*
+		 * We need to (re-)format the mft record, preserving the
+		 * sequence number if it is not zero as well as the update
+		 * sequence number if it is not zero or -1 (0xffff).  This
+		 * means we do not need to care whether or not something went
+		 * wrong with the previous mft record.
+		 */
+		seq_no = m->sequence_number;
+		usn = *(__le16 *)((u8 *)m + le16_to_cpu(m->usa_ofs));
+		err = ntfs_mft_record_layout(vol, bit, m);
+		if (unlikely(err)) {
+			ntfs_error(vol->sb, "Failed to layout allocated mft record 0x%llx.",
+					bit);
+			folio_mark_uptodate(folio);
+			folio_unlock(folio);
+			ntfs_unmap_folio(folio, m);
+			goto undo_mftbmp_alloc;
+		}
+		if (seq_no)
+			m->sequence_number = seq_no;
+		if (usn && le16_to_cpu(usn) != 0xffff)
+			*(__le16 *)((u8 *)m + le16_to_cpu(m->usa_ofs)) = usn;
+		pre_write_mst_fixup((struct ntfs_record *)m, vol->mft_record_size);
+	}
+	/* Set the mft record itself in use. */
+	m->flags |= MFT_RECORD_IN_USE;
+	if (S_ISDIR(mode))
+		m->flags |= MFT_RECORD_IS_DIRECTORY;
+	flush_dcache_folio(folio);
+	folio_mark_uptodate(folio);
+	if (base_ni) {
+		struct mft_record *m_tmp;
+
+		/*
+		 * Setup the base mft record in the extent mft record.  This
+		 * completes initialization of the allocated extent mft record
+		 * and we can simply use it with map_extent_mft_record().
+		 */
+		m->base_mft_record = MK_LE_MREF(base_ni->mft_no,
+				base_ni->seq_no);
+		/*
+		 * Allocate an extent inode structure for the new mft record,
+		 * attach it to the base inode @base_ni and map, pin, and lock
+		 * its, i.e. the allocated, mft record.
+		 */
+		m_tmp = map_extent_mft_record(base_ni,
+					      MK_MREF(bit, le16_to_cpu(m->sequence_number)),
+					      ni);
+		if (IS_ERR(m_tmp)) {
+			ntfs_error(vol->sb, "Failed to map allocated extent mft record 0x%llx.",
+					bit);
+			err = PTR_ERR(m_tmp);
+			/* Set the mft record itself not in use. */
+			m->flags &= cpu_to_le16(
+					~le16_to_cpu(MFT_RECORD_IN_USE));
+			flush_dcache_folio(folio);
+			/* Make sure the mft record is written out to disk. */
+			mark_ntfs_record_dirty(folio);
+			folio_unlock(folio);
+			ntfs_unmap_folio(folio, m);
+			goto undo_mftbmp_alloc;
+		}
+
+		/*
+		 * Make sure the allocated mft record is written out to disk.
+		 * No need to set the inode dirty because the caller is going
+		 * to do that anyway after finishing with the new extent mft
+		 * record (e.g. at a minimum a new attribute will be added to
+		 * the mft record.
+		 */
+		mark_ntfs_record_dirty(folio);
+		folio_unlock(folio);
+		/*
+		 * Need to unmap the page since map_extent_mft_record() mapped
+		 * it as well so we have it mapped twice at the moment.
+		 */
+		ntfs_unmap_folio(folio, m);
+	} else {
+		/*
+		 * Manually map, pin, and lock the mft record as we already
+		 * have its page mapped and it is very easy to do.
+		 */
+		(*ni)->seq_no = le16_to_cpu(m->sequence_number);
+		/*
+		 * Make sure the allocated mft record is written out to disk.
+		 * NOTE: We do not set the ntfs inode dirty because this would
+		 * fail in ntfs_write_inode() because the inode does not have a
+		 * standard information attribute yet.  Also, there is no need
+		 * to set the inode dirty because the caller is going to do
+		 * that anyway after finishing with the new mft record (e.g. at
+		 * a minimum some new attributes will be added to the mft
+		 * record.
+		 */
+
+		(*ni)->mrec = kmalloc(vol->mft_record_size, GFP_NOFS);
+		if (!(*ni)->mrec) {
+			folio_unlock(folio);
+			ntfs_unmap_folio(folio, m);
+			goto undo_mftbmp_alloc;
+		}
+
+		memcpy((*ni)->mrec, m, vol->mft_record_size);
+		post_read_mst_fixup((struct ntfs_record *)(*ni)->mrec, vol->mft_record_size);
+		mark_ntfs_record_dirty(folio);
+		folio_unlock(folio);
+		(*ni)->folio = folio;
+		(*ni)->folio_ofs = ofs;
+		atomic_inc(&(*ni)->count);
+		/* Update the default mft allocation position. */
+		vol->mft_data_pos = bit + 1;
+	}
+	mutex_unlock(&NTFS_I(vol->mft_ino)->mrec_lock);
+	memalloc_nofs_restore(memalloc_flags);
+
+	/*
+	 * Return the opened, allocated inode of the allocated mft record as
+	 * well as the mapped, pinned, and locked mft record.
+	 */
+	ntfs_debug("Returning opened, allocated %sinode 0x%llx.",
+			base_ni ? "extent " : "", bit);
+	(*ni)->mft_no = bit;
+	if (ni_mrec)
+		*ni_mrec = (*ni)->mrec;
+	ntfs_dec_free_mft_records(vol, 1);
+	return 0;
+undo_data_init:
+	write_lock_irqsave(&mft_ni->size_lock, flags);
+	mft_ni->initialized_size = old_data_initialized;
+	i_size_write(vol->mft_ino, old_data_size);
+	write_unlock_irqrestore(&mft_ni->size_lock, flags);
+	goto undo_mftbmp_alloc_nolock;
+undo_mftbmp_alloc:
+	down_write(&vol->mftbmp_lock);
+undo_mftbmp_alloc_nolock:
+	if (ntfs_bitmap_clear_bit(vol->mftbmp_ino, bit)) {
+		ntfs_error(vol->sb, "Failed to clear bit in mft bitmap.%s", es);
+		NVolSetErrors(vol);
+	}
+	up_write(&vol->mftbmp_lock);
+err_out:
+	mutex_unlock(&mft_ni->mrec_lock);
+	memalloc_nofs_restore(memalloc_flags);
+	return err;
+max_err_out:
+	ntfs_warning(vol->sb,
+		"Cannot allocate mft record because the maximum number of inodes (2^32) has already been reached.");
+	up_write(&vol->mftbmp_lock);
+	mutex_unlock(&NTFS_I(vol->mft_ino)->mrec_lock);
+	memalloc_nofs_restore(memalloc_flags);
+	return -ENOSPC;
+}
+
+/**
+ * ntfs_mft_record_free - free an mft record on an ntfs volume
+ * @vol:	volume on which to free the mft record
+ * @ni:		open ntfs inode of the mft record to free
+ *
+ * Free the mft record of the open inode @ni on the mounted ntfs volume @vol.
+ * Note that this function calls ntfs_inode_close() internally and hence you
+ * cannot use the pointer @ni any more after this function returns success.
+ *
+ * On success return 0 and on error return -1 with errno set to the error code.
+ */
+int ntfs_mft_record_free(struct ntfs_volume *vol, struct ntfs_inode *ni)
+{
+	u64 mft_no;
+	int err;
+	u16 seq_no;
+	__le16 old_seq_no;
+	struct mft_record *ni_mrec;
+	unsigned int memalloc_flags;
+
+	ntfs_debug("Entering for inode 0x%llx.\n", (long long)ni->mft_no);
+
+	if (!vol || !ni)
+		return -EINVAL;
+
+	ni_mrec = map_mft_record(ni);
+	if (IS_ERR(ni_mrec))
+		return -EIO;
+
+	/* Cache the mft reference for later. */
+	mft_no = ni->mft_no;
+
+	/* Mark the mft record as not in use. */
+	ni_mrec->flags &= ~MFT_RECORD_IN_USE;
+
+	/* Increment the sequence number, skipping zero, if it is not zero. */
+	old_seq_no = ni_mrec->sequence_number;
+	seq_no = le16_to_cpu(old_seq_no);
+	if (seq_no == 0xffff)
+		seq_no = 1;
+	else if (seq_no)
+		seq_no++;
+	ni_mrec->sequence_number = cpu_to_le16(seq_no);
+
+	/*
+	 * Set the ntfs inode dirty and write it out.  We do not need to worry
+	 * about the base inode here since whatever caused the extent mft
+	 * record to be freed is guaranteed to do it already.
+	 */
+	NInoSetDirty(ni);
+	err = write_mft_record(ni, ni_mrec, 0);
+	if (err)
+		goto sync_rollback;
+
+	/* Clear the bit in the $MFT/$BITMAP corresponding to this record. */
+	memalloc_flags = memalloc_nofs_save();
+	down_write(&vol->mftbmp_lock);
+	err = ntfs_bitmap_clear_bit(vol->mftbmp_ino, mft_no);
+	up_write(&vol->mftbmp_lock);
+	memalloc_nofs_restore(memalloc_flags);
+	if (err)
+		goto bitmap_rollback;
+
+	unmap_mft_record(ni);
+	ntfs_inc_free_mft_records(vol, 1);
+	return 0;
+
+	/* Rollback what we did... */
+bitmap_rollback:
+	memalloc_flags = memalloc_nofs_save();
+	down_write(&vol->mftbmp_lock);
+	if (ntfs_bitmap_set_bit(vol->mftbmp_ino, mft_no))
+		ntfs_error(vol->sb, "ntfs_bitmap_set_bit failed in bitmap_rollback\n");
+	up_write(&vol->mftbmp_lock);
+	memalloc_nofs_restore(memalloc_flags);
+sync_rollback:
+	ntfs_error(vol->sb,
+		"Eeek! Rollback failed in %s. Leaving inconsistent metadata!\n", __func__);
+	ni_mrec->flags |= MFT_RECORD_IN_USE;
+	ni_mrec->sequence_number = old_seq_no;
+	NInoSetDirty(ni);
+	write_mft_record(ni, ni_mrec, 0);
+	unmap_mft_record(ni);
+	return err;
+}
diff --git a/fs/ntfsplus/mst.c b/fs/ntfsplus/mst.c
new file mode 100644
index 000000000000..e88f52831cb8
--- /dev/null
+++ b/fs/ntfsplus/mst.c
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * NTFS multi sector transfer protection handling code.
+ * Part of the Linux-NTFS project.
+ *
+ * Copyright (c) 2001-2004 Anton Altaparmakov
+ */
+
+#include <linux/ratelimit.h>
+
+#include "ntfs.h"
+
+/**
+ * post_read_mst_fixup - deprotect multi sector transfer protected data
+ * @b:		pointer to the data to deprotect
+ * @size:	size in bytes of @b
+ *
+ * Perform the necessary post read multi sector transfer fixup and detect the
+ * presence of incomplete multi sector transfers. - In that case, overwrite the
+ * magic of the ntfs record header being processed with "BAAD" (in memory only!)
+ * and abort processing.
+ *
+ * Return 0 on success and -EINVAL on error ("BAAD" magic will be present).
+ *
+ * NOTE: We consider the absence / invalidity of an update sequence array to
+ * mean that the structure is not protected at all and hence doesn't need to
+ * be fixed up. Thus, we return success and not failure in this case. This is
+ * in contrast to pre_write_mst_fixup(), see below.
+ */
+int post_read_mst_fixup(struct ntfs_record *b, const u32 size)
+{
+	u16 usa_ofs, usa_count, usn;
+	u16 *usa_pos, *data_pos;
+
+	/* Setup the variables. */
+	usa_ofs = le16_to_cpu(b->usa_ofs);
+	/* Decrement usa_count to get number of fixups. */
+	usa_count = le16_to_cpu(b->usa_count) - 1;
+	/* Size and alignment checks. */
+	if (size & (NTFS_BLOCK_SIZE - 1) || usa_ofs & 1	||
+	    usa_ofs + (usa_count * 2) > size ||
+	    (size >> NTFS_BLOCK_SIZE_BITS) != usa_count)
+		return 0;
+	/* Position of usn in update sequence array. */
+	usa_pos = (u16 *)b + usa_ofs/sizeof(u16);
+	/*
+	 * The update sequence number which has to be equal to each of the
+	 * u16 values before they are fixed up. Note no need to care for
+	 * endianness since we are comparing and moving data for on disk
+	 * structures which means the data is consistent. - If it is
+	 * consistenty the wrong endianness it doesn't make any difference.
+	 */
+	usn = *usa_pos;
+	/*
+	 * Position in protected data of first u16 that needs fixing up.
+	 */
+	data_pos = (u16 *)b + NTFS_BLOCK_SIZE / sizeof(u16) - 1;
+	/*
+	 * Check for incomplete multi sector transfer(s).
+	 */
+	while (usa_count--) {
+		if (*data_pos != usn) {
+			struct mft_record *m = (struct mft_record *)b;
+
+			pr_err_ratelimited("ntfs: Incomplete multi sector transfer detected! (Record magic : 0x%x, mft number : 0x%x, base mft number : 0x%lx, mft in use : %d, data : 0x%x, usn 0x%x)\n",
+					le32_to_cpu(m->magic), le32_to_cpu(m->mft_record_number),
+					MREF_LE(m->base_mft_record), m->flags & MFT_RECORD_IN_USE,
+					*data_pos, usn);
+			/*
+			 * Incomplete multi sector transfer detected! )-:
+			 * Set the magic to "BAAD" and return failure.
+			 * Note that magic_BAAD is already converted to le32.
+			 */
+			b->magic = magic_BAAD;
+			return -EINVAL;
+		}
+		data_pos += NTFS_BLOCK_SIZE / sizeof(u16);
+	}
+	/* Re-setup the variables. */
+	usa_count = le16_to_cpu(b->usa_count) - 1;
+	data_pos = (u16 *)b + NTFS_BLOCK_SIZE / sizeof(u16) - 1;
+	/* Fixup all sectors. */
+	while (usa_count--) {
+		/*
+		 * Increment position in usa and restore original data from
+		 * the usa into the data buffer.
+		 */
+		*data_pos = *(++usa_pos);
+		/* Increment position in data as well. */
+		data_pos += NTFS_BLOCK_SIZE/sizeof(u16);
+	}
+	return 0;
+}
+
+/**
+ * pre_write_mst_fixup - apply multi sector transfer protection
+ * @b:		pointer to the data to protect
+ * @size:	size in bytes of @b
+ *
+ * Perform the necessary pre write multi sector transfer fixup on the data
+ * pointer to by @b of @size.
+ *
+ * Return 0 if fixup applied (success) or -EINVAL if no fixup was performed
+ * (assumed not needed). This is in contrast to post_read_mst_fixup() above.
+ *
+ * NOTE: We consider the absence / invalidity of an update sequence array to
+ * mean that the structure is not subject to protection and hence doesn't need
+ * to be fixed up. This means that you have to create a valid update sequence
+ * array header in the ntfs record before calling this function, otherwise it
+ * will fail (the header needs to contain the position of the update sequence
+ * array together with the number of elements in the array). You also need to
+ * initialise the update sequence number before calling this function
+ * otherwise a random word will be used (whatever was in the record at that
+ * position at that time).
+ */
+int pre_write_mst_fixup(struct ntfs_record *b, const u32 size)
+{
+	__le16 *usa_pos, *data_pos;
+	u16 usa_ofs, usa_count, usn;
+	__le16 le_usn;
+
+	/* Sanity check + only fixup if it makes sense. */
+	if (!b || ntfs_is_baad_record(b->magic) ||
+	    ntfs_is_hole_record(b->magic))
+		return -EINVAL;
+	/* Setup the variables. */
+	usa_ofs = le16_to_cpu(b->usa_ofs);
+	/* Decrement usa_count to get number of fixups. */
+	usa_count = le16_to_cpu(b->usa_count) - 1;
+	/* Size and alignment checks. */
+	if (size & (NTFS_BLOCK_SIZE - 1) || usa_ofs & 1	||
+	    usa_ofs + (usa_count * 2) > size ||
+	    (size >> NTFS_BLOCK_SIZE_BITS) != usa_count)
+		return -EINVAL;
+	/* Position of usn in update sequence array. */
+	usa_pos = (__le16 *)((u8 *)b + usa_ofs);
+	/*
+	 * Cyclically increment the update sequence number
+	 * (skipping 0 and -1, i.e. 0xffff).
+	 */
+	usn = le16_to_cpup(usa_pos) + 1;
+	if (usn == 0xffff || !usn)
+		usn = 1;
+	le_usn = cpu_to_le16(usn);
+	*usa_pos = le_usn;
+	/* Position in data of first u16 that needs fixing up. */
+	data_pos = (__le16 *)b + NTFS_BLOCK_SIZE/sizeof(__le16) - 1;
+	/* Fixup all sectors. */
+	while (usa_count--) {
+		/*
+		 * Increment the position in the usa and save the
+		 * original data from the data buffer into the usa.
+		 */
+		*(++usa_pos) = *data_pos;
+		/* Apply fixup to data. */
+		*data_pos = le_usn;
+		/* Increment position in data as well. */
+		data_pos += NTFS_BLOCK_SIZE / sizeof(__le16);
+	}
+	return 0;
+}
+
+/**
+ * post_write_mst_fixup - fast deprotect multi sector transfer protected data
+ * @b:		pointer to the data to deprotect
+ *
+ * Perform the necessary post write multi sector transfer fixup, not checking
+ * for any errors, because we assume we have just used pre_write_mst_fixup(),
+ * thus the data will be fine or we would never have gotten here.
+ */
+void post_write_mst_fixup(struct ntfs_record *b)
+{
+	__le16 *usa_pos, *data_pos;
+
+	u16 usa_ofs = le16_to_cpu(b->usa_ofs);
+	u16 usa_count = le16_to_cpu(b->usa_count) - 1;
+
+	/* Position of usn in update sequence array. */
+	usa_pos = (__le16 *)b + usa_ofs/sizeof(__le16);
+
+	/* Position in protected data of first u16 that needs fixing up. */
+	data_pos = (__le16 *)b + NTFS_BLOCK_SIZE/sizeof(__le16) - 1;
+
+	/* Fixup all sectors. */
+	while (usa_count--) {
+		/*
+		 * Increment position in usa and restore original data from
+		 * the usa into the data buffer.
+		 */
+		*data_pos = *(++usa_pos);
+
+		/* Increment position in data as well. */
+		data_pos += NTFS_BLOCK_SIZE/sizeof(__le16);
+	}
+}
diff --git a/fs/ntfsplus/namei.c b/fs/ntfsplus/namei.c
new file mode 100644
index 000000000000..d3f9dc629563
--- /dev/null
+++ b/fs/ntfsplus/namei.c
@@ -0,0 +1,1606 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * NTFS kernel directory inode operations.
+ * Part of the Linux-NTFS project.
+ *
+ * Copyright (c) 2001-2006 Anton Altaparmakov
+ * Copyright (c) 2025 LG Electronics Co., Ltd.
+ */
+
+#include <linux/exportfs.h>
+#include <linux/iversion.h>
+
+#include "ntfs.h"
+#include "misc.h"
+#include "index.h"
+#include "reparse.h"
+#include "ea.h"
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
+/**
+ * ntfs_lookup - find the inode represented by a dentry in a directory inode
+ * @dir_ino:	directory inode in which to look for the inode
+ * @dent:	dentry representing the inode to look for
+ * @flags:	lookup flags
+ *
+ * In short, ntfs_lookup() looks for the inode represented by the dentry @dent
+ * in the directory inode @dir_ino and if found attaches the inode to the
+ * dentry @dent.
+ *
+ * In more detail, the dentry @dent specifies which inode to look for by
+ * supplying the name of the inode in @dent->d_name.name. ntfs_lookup()
+ * converts the name to Unicode and walks the contents of the directory inode
+ * @dir_ino looking for the converted Unicode name. If the name is found in the
+ * directory, the corresponding inode is loaded by calling ntfs_iget() on its
+ * inode number and the inode is associated with the dentry @dent via a call to
+ * d_splice_alias().
+ *
+ * If the name is not found in the directory, a NULL inode is inserted into the
+ * dentry @dent via a call to d_add(). The dentry is then termed a negative
+ * dentry.
+ *
+ * Only if an actual error occurs, do we return an error via ERR_PTR().
+ *
+ * In order to handle the case insensitivity issues of NTFS with regards to the
+ * dcache and the dcache requiring only one dentry per directory, we deal with
+ * dentry aliases that only differ in case in ->ntfs_lookup() while maintaining
+ * a case sensitive dcache. This means that we get the full benefit of dcache
+ * speed when the file/directory is looked up with the same case as returned by
+ * ->ntfs_readdir() but that a lookup for any other case (or for the short file
+ * name) will not find anything in dcache and will enter ->ntfs_lookup()
+ * instead, where we search the directory for a fully matching file name
+ * (including case) and if that is not found, we search for a file name that
+ * matches with different case and if that has non-POSIX semantics we return
+ * that. We actually do only one search (case sensitive) and keep tabs on
+ * whether we have found a case insensitive match in the process.
+ *
+ * To simplify matters for us, we do not treat the short vs long filenames as
+ * two hard links but instead if the lookup matches a short filename, we
+ * return the dentry for the corresponding long filename instead.
+ *
+ * There are three cases we need to distinguish here:
+ *
+ * 1) @dent perfectly matches (i.e. including case) a directory entry with a
+ *    file name in the WIN32 or POSIX namespaces. In this case
+ *    ntfs_lookup_inode_by_name() will return with name set to NULL and we
+ *    just d_splice_alias() @dent.
+ * 2) @dent matches (not including case) a directory entry with a file name in
+ *    the WIN32 namespace. In this case ntfs_lookup_inode_by_name() will return
+ *    with name set to point to a kmalloc()ed ntfs_name structure containing
+ *    the properly cased little endian Unicode name. We convert the name to the
+ *    current NLS code page, search if a dentry with this name already exists
+ *    and if so return that instead of @dent.  At this point things are
+ *    complicated by the possibility of 'disconnected' dentries due to NFS
+ *    which we deal with appropriately (see the code comments).  The VFS will
+ *    then destroy the old @dent and use the one we returned.  If a dentry is
+ *    not found, we allocate a new one, d_splice_alias() it, and return it as
+ *    above.
+ * 3) @dent matches either perfectly or not (i.e. we don't care about case) a
+ *    directory entry with a file name in the DOS namespace. In this case
+ *    ntfs_lookup_inode_by_name() will return with name set to point to a
+ *    kmalloc()ed ntfs_name structure containing the mft reference (cpu endian)
+ *    of the inode. We use the mft reference to read the inode and to find the
+ *    file name in the WIN32 namespace corresponding to the matched short file
+ *    name. We then convert the name to the current NLS code page, and proceed
+ *    searching for a dentry with this name, etc, as in case 2), above.
+ *
+ * Locking: Caller must hold i_mutex on the directory.
+ */
+static struct dentry *ntfs_lookup(struct inode *dir_ino, struct dentry *dent,
+		unsigned int flags)
+{
+	struct ntfs_volume *vol = NTFS_SB(dir_ino->i_sb);
+	struct inode *dent_inode;
+	__le16 *uname;
+	struct ntfs_name *name = NULL;
+	u64 mref;
+	unsigned long dent_ino;
+	int uname_len;
+
+	ntfs_debug("Looking up %pd in directory inode 0x%lx.",
+			dent, dir_ino->i_ino);
+	/* Convert the name of the dentry to Unicode. */
+	uname_len = ntfs_nlstoucs(vol, dent->d_name.name, dent->d_name.len,
+				  &uname, NTFS_MAX_NAME_LEN);
+	if (uname_len < 0) {
+		if (uname_len != -ENAMETOOLONG)
+			ntfs_debug("Failed to convert name to Unicode.");
+		return ERR_PTR(uname_len);
+	}
+	mutex_lock(&NTFS_I(dir_ino)->mrec_lock);
+	mref = ntfs_lookup_inode_by_name(NTFS_I(dir_ino), uname, uname_len,
+			&name);
+	mutex_unlock(&NTFS_I(dir_ino)->mrec_lock);
+	kmem_cache_free(ntfs_name_cache, uname);
+	if (!IS_ERR_MREF(mref)) {
+		dent_ino = MREF(mref);
+		ntfs_debug("Found inode 0x%lx. Calling ntfs_iget.", dent_ino);
+		dent_inode = ntfs_iget(vol->sb, dent_ino);
+		if (!IS_ERR(dent_inode)) {
+			/* Consistency check. */
+			if (MSEQNO(mref) == NTFS_I(dent_inode)->seq_no ||
+			    dent_ino == FILE_MFT) {
+				/* Perfect WIN32/POSIX match. -- Case 1. */
+				if (!name) {
+					ntfs_debug("Done.  (Case 1.)");
+					return d_splice_alias(dent_inode, dent);
+				}
+				/*
+				 * We are too indented.  Handle imperfect
+				 * matches and short file names further below.
+				 */
+				goto handle_name;
+			}
+			ntfs_error(vol->sb,
+				"Found stale reference to inode 0x%lx (reference sequence number = 0x%x, inode sequence number = 0x%x), returning -EIO. Run chkdsk.",
+				dent_ino, MSEQNO(mref),
+				NTFS_I(dent_inode)->seq_no);
+			iput(dent_inode);
+			dent_inode = ERR_PTR(-EIO);
+		} else
+			ntfs_error(vol->sb, "ntfs_iget(0x%lx) failed with error code %li.",
+					dent_ino, PTR_ERR(dent_inode));
+		kfree(name);
+		/* Return the error code. */
+		return ERR_CAST(dent_inode);
+	}
+	kfree(name);
+	/* It is guaranteed that @name is no longer allocated at this point. */
+	if (MREF_ERR(mref) == -ENOENT) {
+		ntfs_debug("Entry was not found, adding negative dentry.");
+		/* The dcache will handle negative entries. */
+		d_add(dent, NULL);
+		ntfs_debug("Done.");
+		return NULL;
+	}
+	ntfs_error(vol->sb, "ntfs_lookup_ino_by_name() failed with error code %i.",
+			-MREF_ERR(mref));
+	return ERR_PTR(MREF_ERR(mref));
+handle_name:
+	{
+		struct mft_record *m;
+		struct ntfs_attr_search_ctx *ctx;
+		struct ntfs_inode *ni = NTFS_I(dent_inode);
+		int err;
+		struct qstr nls_name;
+
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
+
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
+			goto err_out;
+		}
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
+	vi->i_state = I_NEW | I_CREATING;
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
+			err = -ENOMEM;
+			goto err_out;
+		}
+		ir->type = AT_FILE_NAME;
+		ir->collation_rule = COLLATION_FILE_NAME;
+		ir->index_block_size = cpu_to_le32(ni->vol->index_record_size);
+		if (ni->vol->cluster_size <= ni->vol->index_record_size)
+			ir->clusters_per_index_block =
+				ni->vol->index_record_size >> ni->vol->cluster_size_bits;
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
+	if (!S_ISREG(mode) && !S_ISDIR(mode))
+		fn->file_attributes = FILE_ATTR_SYSTEM;
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
+	/* Set the sequence number. */
+	vi->i_generation = ni->seq_no;
+	set_nlink(vi, 1);
+	ntfs_set_vfs_operations(vi, mode, dev);
+
+#ifdef CONFIG_NTFSPLUS_FS_POSIX_ACL
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
+	err = ntfs_check_bad_char(uname, uname_len);
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
+ * @ni is always closed after the call to this function (even if it failed),
+ * user does not need to call ntfs_inode_close himself.
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
+		mutex_unlock(&dir_ni->mrec_lock);
+		mutex_unlock(&ni->mrec_lock);
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
+			}
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
+
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
+	mutex_unlock(&dir_ni->mrec_lock);
+	mutex_unlock(&ni->mrec_lock);
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
+
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
+	err = ntfs_check_bad_char(uname, uname_len);
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
+	err = ntfs_check_bad_char(uname, uname_len);
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
+	err = ntfs_check_bad_char(uname, uname_len);
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
+ * NOTE: At present we allow creating hardlinks to directories, we use them
+ * in a temporary state during rename. But it's defenitely bad idea to have
+ * hard links to directories as a result of operation.
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
+		goto err_out;
+	}
+
+	/* Create FILE_NAME attribute. */
+	fn_len = sizeof(struct file_name_attr) + name_len * sizeof(__le16);
+	fn = ntfs_malloc_nofs(fn_len);
+	if (!fn) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
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
+err_out:
+	ntfs_free(fn);
+	if (!IS_ERR_OR_NULL(ni_mrec))
+		unmap_mft_record(ni);
+	return err;
+}
+
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
+	err = ntfs_check_bad_char(uname_new, new_name_len);
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
+	err = ntfs_check_bad_char(usrc, usrc_len);
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
+	err = ntfs_check_bad_char(uname, uname_len);
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
+ * Inode operations for directories.
+ */
+const struct inode_operations ntfs_dir_inode_ops = {
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
+};
+
+/**
+ * ntfs_get_parent - find the dentry of the parent of a given directory dentry
+ * @child_dent:		dentry of the directory whose parent directory to find
+ *
+ * Find the dentry for the parent directory of the directory specified by the
+ * dentry @child_dent.  This function is called from
+ * fs/exportfs/expfs.c::find_exported_dentry() which in turn is called from the
+ * default ->decode_fh() which is export_decode_fh() in the same file.
+ *
+ * Note: ntfs_get_parent() is called with @d_inode(child_dent)->i_mutex down.
+ *
+ * Return the dentry of the parent directory on success or the error code on
+ * error (IS_ERR() is true).
+ */
+static struct dentry *ntfs_get_parent(struct dentry *child_dent)
+{
+	struct inode *vi = d_inode(child_dent);
+	struct ntfs_inode *ni = NTFS_I(vi);
+	struct mft_record *mrec;
+	struct ntfs_attr_search_ctx *ctx;
+	struct attr_record *attr;
+	struct file_name_attr *fn;
+	unsigned long parent_ino;
+	int err;
+
+	ntfs_debug("Entering for inode 0x%lx.", vi->i_ino);
+	/* Get the mft record of the inode belonging to the child dentry. */
+	mrec = map_mft_record(ni);
+	if (IS_ERR(mrec))
+		return ERR_CAST(mrec);
+	/* Find the first file name attribute in the mft record. */
+	ctx = ntfs_attr_get_search_ctx(ni, mrec);
+	if (unlikely(!ctx)) {
+		unmap_mft_record(ni);
+		return ERR_PTR(-ENOMEM);
+	}
+try_next:
+	err = ntfs_attr_lookup(AT_FILE_NAME, NULL, 0, CASE_SENSITIVE, 0, NULL,
+			0, ctx);
+	if (unlikely(err)) {
+		ntfs_attr_put_search_ctx(ctx);
+		unmap_mft_record(ni);
+		if (err == -ENOENT)
+			ntfs_error(vi->i_sb,
+				   "Inode 0x%lx does not have a file name attribute.  Run chkdsk.",
+				   vi->i_ino);
+		return ERR_PTR(err);
+	}
+	attr = ctx->attr;
+	if (unlikely(attr->non_resident))
+		goto try_next;
+	fn = (struct file_name_attr *)((u8 *)attr +
+			le16_to_cpu(attr->data.resident.value_offset));
+	if (unlikely((u8 *)fn + le32_to_cpu(attr->data.resident.value_length) >
+	    (u8 *)attr + le32_to_cpu(attr->length)))
+		goto try_next;
+	/* Get the inode number of the parent directory. */
+	parent_ino = MREF_LE(fn->parent_directory);
+	/* Release the search context and the mft record of the child. */
+	ntfs_attr_put_search_ctx(ctx);
+	unmap_mft_record(ni);
+
+	return d_obtain_alias(ntfs_iget(vi->i_sb, parent_ino));
+}
+
+static struct inode *ntfs_nfs_get_inode(struct super_block *sb,
+		u64 ino, u32 generation)
+{
+	struct inode *inode;
+
+	inode = ntfs_iget(sb, ino);
+	if (!IS_ERR(inode)) {
+		if (inode->i_generation != generation) {
+			iput(inode);
+			inode = ERR_PTR(-ESTALE);
+		}
+	}
+
+	return inode;
+}
+
+static struct dentry *ntfs_fh_to_dentry(struct super_block *sb, struct fid *fid,
+		int fh_len, int fh_type)
+{
+	return generic_fh_to_dentry(sb, fid, fh_len, fh_type,
+				    ntfs_nfs_get_inode);
+}
+
+static struct dentry *ntfs_fh_to_parent(struct super_block *sb, struct fid *fid,
+		int fh_len, int fh_type)
+{
+	return generic_fh_to_parent(sb, fid, fh_len, fh_type,
+				    ntfs_nfs_get_inode);
+}
+
+/**
+ * Export operations allowing NFS exporting of mounted NTFS partitions.
+ */
+const struct export_operations ntfs_export_ops = {
+	.encode_fh = generic_encode_ino32_fh,
+	.get_parent	= ntfs_get_parent,	/* Find the parent of a given directory. */
+	.fh_to_dentry	= ntfs_fh_to_dentry,
+	.fh_to_parent	= ntfs_fh_to_parent,
+};
-- 
2.34.1


