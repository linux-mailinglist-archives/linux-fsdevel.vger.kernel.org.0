Return-Path: <linux-fsdevel+bounces-64639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7733CBEF0E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 04:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CA743E1E20
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 02:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE211EA7CC;
	Mon, 20 Oct 2025 02:09:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22AA1FA272
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 02:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760926157; cv=none; b=SuEy/HdzRjw+rcuNNiw+vFrm/CSqlb4mQxW4TugPkfVKG8slqWHETuiqj2IzfnzjE0/3wIuogcGATpMsxjF1e3t+0qSFrNrM+hAz8SyYZwk4vwhATQqmv0Cd94uzky7BaCKWY8/VIPJyaytbOSgjrZwZAkD7WnEdkZZ+i7P2XDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760926157; c=relaxed/simple;
	bh=zDhLHjEzW2BIiOyf8dvEiNlyXPXNoltCbA+4xpZfD1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bO2AnOXoJ0oRwNSY/X1UkRbUQ4F4N4DZ+PbAozPCaZsw7pCGK7FOkv014vPDjLD5qwC7di6zziU+MENAZxBzea/TqROVsGijdIv2yaGxyU3wgLSJrA+qPshmMC99uggMeWAUEgfKeGEiC2hokvhYplcu3hooHmXGtzEwLPKv4Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so3428455b3a.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Oct 2025 19:09:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760926153; x=1761530953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ANiEX9779qnDwzIDVI/lSZKKNVsi0TI2fHIaZbivsQ=;
        b=AnxoNY//7oHTfFC1W6VUUNnI+rJa0EXI2AgrEmkc4We5a2DfK0+QkXFNKqBJbqkRsa
         3CE89iWbxEGfnhaasKpfvC46hYZDZLpq90lOmhSKHmXZvbI8puVzihDeEo0qo7VH3VFp
         vN7X8VBv/iwBOOb99oivKTn1IN1faFIW1ek6yA4uHALNhfGE2u9iAZhiHxYnUbAV8sQL
         LU6nxk2yuH9C0hI7s46tAkPoqjPnd38Nt6rAej1ru/77wjeWNBHG0iraEmbU/1I6qrm5
         cnNYVhSPmBo4CmrbtEga/pwcMLMd2ZZxrdf04GpvkK1GMx6DRQ40pO0/6DPV1ZkdjS9P
         0GYw==
X-Gm-Message-State: AOJu0YxzeIFoy1w4u6sxIKsbAi7S8N6eY6Ci16grFKYrNo4tynSGZd1I
	dAkWPlTsYzU18nnkXuJBAULYcYe2w3FczXWYxfN9h2Ibbo8DIyiIIXvX
X-Gm-Gg: ASbGncvq7dAehCwiFOcTuLaQCfgU7UqSmFq5UTYHrzShPohcjqICqb2gLtUDMd3i9lG
	1lKOaAzvlo6kyCFuVC2l0YVLzrM5TRnBWeeDr76DNc+/Izp8lMdVpYuaR2PGzQ+StY1F5/DIcEA
	+UscR97h92ycrzRnDdKBe+BVgb8tzp0OtLSJSvESsvn51e29CW2wiu/Oa7ZqLXmdPQOqmk2/5cB
	odJogPDyp1Ousp60qkk4z1E4eevFTaLNdFGtD3GExb6xfAfP58dwdV8acRXEPh+4rm35PJSfvJW
	IcCZBKRj9dCaE0tSuXp3L18ZRj0rcZBNcA9f0wIebB0keW0nf6l6oehlAEZcXxKtOS1RbPykGmh
	1Q73lKDjp1Z6kMHD3NiHYoOZJPnKCsMlKxHFn6JTnxtLWUyRZ14Upp5SpWcIr+fvMbYDhtvwovh
	GRNNWunpHz49mOrlMLea+8udiKWmlYNbLxrxY7
X-Google-Smtp-Source: AGHT+IG427T736tLo8ecKxoEEjP7f6Mwooi+Yx6wJokVhFKJFppeV3EZU1t2dum35rinu3t201+/UA==
X-Received: by 2002:a05:6a00:b8f:b0:77e:4534:7f1c with SMTP id d2e1a72fcca58-7a21f76888amr13350660b3a.0.1760926152833;
        Sun, 19 Oct 2025 19:09:12 -0700 (PDT)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23010df83sm6722300b3a.59.2025.10.19.19.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 19:09:12 -0700 (PDT)
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
Subject: [PATCH 05/11] ntfsplus: add file operations
Date: Mon, 20 Oct 2025 11:07:43 +0900
Message-Id: <20251020020749.5522-6-linkinjeon@kernel.org>
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

This adds the implementation of file operations for ntfsplus.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ntfsplus/file.c | 1056 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 1056 insertions(+)
 create mode 100644 fs/ntfsplus/file.c

diff --git a/fs/ntfsplus/file.c b/fs/ntfsplus/file.c
new file mode 100644
index 000000000000..b4114017b128
--- /dev/null
+++ b/fs/ntfsplus/file.c
@@ -0,0 +1,1056 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * NTFS kernel file operations. Part of the Linux-NTFS project.
+ *
+ * Copyright (c) 2001-2015 Anton Altaparmakov and Tuxera Inc.
+ * Copyright (c) 2025 LG Electronics Co., Ltd.
+ */
+
+#include <linux/writeback.h>
+#include <linux/blkdev.h>
+#include <linux/fs.h>
+#include <linux/iomap.h>
+#include <linux/uio.h>
+#include <linux/posix_acl.h>
+#include <linux/posix_acl_xattr.h>
+#include <linux/compat.h>
+#include <linux/falloc.h>
+#include <uapi/linux/ntfs.h>
+
+#include "lcnalloc.h"
+#include "ntfs.h"
+#include "aops.h"
+#include "reparse.h"
+#include "ea.h"
+#include "ntfs_iomap.h"
+#include "misc.h"
+
+/**
+ * ntfs_file_open - called when an inode is about to be opened
+ * @vi:		inode to be opened
+ * @filp:	file structure describing the inode
+ *
+ * Limit file size to the page cache limit on architectures where unsigned long
+ * is 32-bits. This is the most we can do for now without overflowing the page
+ * cache page index. Doing it this way means we don't run into problems because
+ * of existing too large files. It would be better to allow the user to read
+ * the beginning of the file but I doubt very much anyone is going to hit this
+ * check on a 32-bit architecture, so there is no point in adding the extra
+ * complexity required to support this.
+ *
+ * On 64-bit architectures, the check is hopefully optimized away by the
+ * compiler.
+ *
+ * After the check passes, just call generic_file_open() to do its work.
+ */
+static int ntfs_file_open(struct inode *vi, struct file *filp)
+{
+	struct ntfs_inode *ni = NTFS_I(vi);
+
+	if (NVolShutdown(ni->vol))
+		return -EIO;
+
+	if (sizeof(unsigned long) < 8) {
+		if (i_size_read(vi) > MAX_LFS_FILESIZE)
+			return -EOVERFLOW;
+	}
+
+	if (filp->f_flags & O_TRUNC && NInoNonResident(ni)) {
+		int err;
+
+		mutex_lock(&ni->mrec_lock);
+		down_read(&ni->runlist.lock);
+		if (!ni->runlist.rl) {
+			err = ntfs_attr_map_whole_runlist(ni);
+			if (err) {
+				up_read(&ni->runlist.lock);
+				mutex_unlock(&ni->mrec_lock);
+				return err;
+			}
+		}
+		ni->lcn_seek_trunc = ni->runlist.rl->lcn;
+		up_read(&ni->runlist.lock);
+		mutex_unlock(&ni->mrec_lock);
+	}
+
+	filp->f_mode |= FMODE_NOWAIT;
+
+	return generic_file_open(vi, filp);
+}
+
+static int ntfs_file_release(struct inode *vi, struct file *filp)
+{
+	struct ntfs_inode *ni = NTFS_I(vi);
+	struct ntfs_volume *vol = ni->vol;
+	s64 aligned_data_size = round_up(ni->data_size, vol->cluster_size);
+
+	if (NInoCompressed(ni))
+		return 0;
+
+	inode_lock(vi);
+	mutex_lock(&ni->mrec_lock);
+	down_write(&ni->runlist.lock);
+	if (aligned_data_size < ni->allocated_size) {
+		int err;
+		s64 vcn_ds = aligned_data_size >> vol->cluster_size_bits;
+		s64 vcn_tr = -1;
+		struct runlist_element *rl = ni->runlist.rl;
+		ssize_t rc = ni->runlist.count - 2;
+
+		while (rc >= 0 && rl[rc].lcn == LCN_HOLE && vcn_ds <= rl[rc].vcn) {
+			vcn_tr = rl[rc].vcn;
+			rc--;
+		}
+
+		if (vcn_tr >= 0) {
+			err = ntfs_rl_truncate_nolock(vol, &ni->runlist, vcn_tr);
+			if (err) {
+				ntfs_free(ni->runlist.rl);
+				ni->runlist.rl = NULL;
+				ntfs_error(vol->sb, "Preallocated block rollback failed");
+			} else {
+				ni->allocated_size = vcn_tr << vol->cluster_size_bits;
+				err = ntfs_attr_update_mapping_pairs(ni, 0);
+				if (err)
+					ntfs_error(vol->sb,
+						   "Failed to rollback mapping pairs for prealloc");
+			}
+		}
+	}
+	up_write(&ni->runlist.lock);
+	mutex_unlock(&ni->mrec_lock);
+	inode_unlock(vi);
+
+	return 0;
+}
+
+/**
+ * ntfs_file_fsync - sync a file to disk
+ * @filp:	file to be synced
+ * @start:	start offset to be synced
+ * @end:	end offset to be synced
+ * @datasync:	if non-zero only flush user data and not metadata
+ *
+ * Data integrity sync of a file to disk.  Used for fsync, fdatasync, and msync
+ * system calls.  This function is inspired by fs/buffer.c::file_fsync().
+ *
+ * If @datasync is false, write the mft record and all associated extent mft
+ * records as well as the $DATA attribute and then sync the block device.
+ *
+ * If @datasync is true and the attribute is non-resident, we skip the writing
+ * of the mft record and all associated extent mft records (this might still
+ * happen due to the write_inode_now() call).
+ *
+ * Also, if @datasync is true, we do not wait on the inode to be written out
+ * but we always wait on the page cache pages to be written out.
+ */
+static int ntfs_file_fsync(struct file *filp, loff_t start, loff_t end,
+			   int datasync)
+{
+	struct inode *vi = filp->f_mapping->host;
+	struct ntfs_inode *ni = NTFS_I(vi);
+	struct ntfs_volume *vol = ni->vol;
+	int err, ret = 0;
+	struct inode *parent_vi, *ia_vi;
+	struct ntfs_attr_search_ctx *ctx;
+
+	ntfs_debug("Entering for inode 0x%lx.", vi->i_ino);
+
+	if (NVolShutdown(vol))
+		return -EIO;
+
+	err = file_write_and_wait_range(filp, start, end);
+	if (err)
+		return err;
+
+	BUG_ON(S_ISDIR(vi->i_mode));
+
+	if (!datasync || !NInoNonResident(NTFS_I(vi)))
+		ret = __ntfs_write_inode(vi, 1);
+	write_inode_now(vi, !datasync);
+
+	ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	if (!ctx)
+		return -ENOMEM;
+
+	mutex_lock_nested(&ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL_2);
+	while (!(err = ntfs_attr_lookup(AT_UNUSED, NULL, 0, 0, 0, NULL, 0, ctx))) {
+		if (ctx->attr->type == AT_FILE_NAME) {
+			struct file_name_attr *fn = (struct file_name_attr *)((u8 *)ctx->attr +
+					le16_to_cpu(ctx->attr->data.resident.value_offset));
+
+			parent_vi = ntfs_iget(vi->i_sb, MREF_LE(fn->parent_directory));
+			if (IS_ERR(parent_vi))
+				continue;
+			mutex_lock_nested(&NTFS_I(parent_vi)->mrec_lock, NTFS_INODE_MUTEX_PARENT_2);
+			ia_vi = ntfs_index_iget(parent_vi, I30, 4);
+			mutex_unlock(&NTFS_I(parent_vi)->mrec_lock);
+			if (IS_ERR(ia_vi)) {
+				iput(parent_vi);
+				continue;
+			}
+			write_inode_now(ia_vi, 1);
+			iput(ia_vi);
+			write_inode_now(parent_vi, 1);
+			iput(parent_vi);
+		} else if (ctx->attr->non_resident) {
+			struct inode *attr_vi;
+			__le16 *name;
+
+			name = (__le16 *)((u8 *)ctx->attr + le16_to_cpu(ctx->attr->name_offset));
+			if (ctx->attr->type == AT_DATA && ctx->attr->name_length == 0)
+				continue;
+
+			attr_vi = ntfs_attr_iget(vi, ctx->attr->type,
+						 name, ctx->attr->name_length);
+			if (IS_ERR(attr_vi))
+				continue;
+			spin_lock(&attr_vi->i_lock);
+			if (attr_vi->i_state & I_DIRTY_PAGES) {
+				spin_unlock(&attr_vi->i_lock);
+				filemap_write_and_wait(attr_vi->i_mapping);
+			} else
+				spin_unlock(&attr_vi->i_lock);
+			iput(attr_vi);
+		}
+	}
+	mutex_unlock(&ni->mrec_lock);
+	ntfs_attr_put_search_ctx(ctx);
+
+	write_inode_now(vol->mftbmp_ino, 1);
+	down_write(&vol->lcnbmp_lock);
+	write_inode_now(vol->lcnbmp_ino, 1);
+	up_write(&vol->lcnbmp_lock);
+	write_inode_now(vol->mft_ino, 1);
+
+	/*
+	 * NOTE: If we were to use mapping->private_list (see ext2 and
+	 * fs/buffer.c) for dirty blocks then we could optimize the below to be
+	 * sync_mapping_buffers(vi->i_mapping).
+	 */
+	err = sync_blockdev(vi->i_sb->s_bdev);
+	if (unlikely(err && !ret))
+		ret = err;
+	if (likely(!ret))
+		ntfs_debug("Done.");
+	else
+		ntfs_warning(vi->i_sb,
+				"Failed to f%ssync inode 0x%lx.  Error %u.",
+				datasync ? "data" : "", vi->i_ino, -ret);
+	if (!ret)
+		blkdev_issue_flush(vi->i_sb->s_bdev);
+	return ret;
+}
+
+/**
+ * ntfs_setattr - called from notify_change() when an attribute is being changed
+ * @idmap:	idmap of the mount the inode was found from
+ * @dentry:	dentry whose attributes to change
+ * @attr:	structure describing the attributes and the changes
+ *
+ * We have to trap VFS attempts to truncate the file described by @dentry as
+ * soon as possible, because we do not implement changes in i_size yet.  So we
+ * abort all i_size changes here.
+ *
+ * We also abort all changes of user, group, and mode as we do not implement
+ * the NTFS ACLs yet.
+ */
+int ntfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
+		 struct iattr *attr)
+{
+	struct inode *vi = d_inode(dentry);
+	int err;
+	unsigned int ia_valid = attr->ia_valid;
+	struct ntfs_inode *ni = NTFS_I(vi);
+	struct ntfs_volume *vol = ni->vol;
+
+	if (NVolShutdown(vol))
+		return -EIO;
+
+	err = setattr_prepare(idmap, dentry, attr);
+	if (err)
+		goto out;
+
+	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
+		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
+
+	if (ia_valid & ATTR_SIZE) {
+		if (NInoCompressed(ni) || NInoEncrypted(ni)) {
+			ntfs_warning(vi->i_sb,
+				     "Changes in inode size are not supported yet for %s files, ignoring.",
+				     NInoCompressed(ni) ? "compressed" : "encrypted");
+			err = -EOPNOTSUPP;
+		} else {
+			loff_t old_size = vi->i_size;
+
+			err = inode_newsize_ok(vi, attr->ia_size);
+			if (err)
+				goto out;
+
+			inode_dio_wait(vi);
+			/* Serialize against page faults */
+			if (NInoNonResident(NTFS_I(vi)) &&
+			    attr->ia_size < old_size) {
+				err = iomap_truncate_page(vi, attr->ia_size, NULL,
+							  &ntfs_read_iomap_ops,
+							  &ntfs_iomap_folio_ops, NULL);
+				if (err)
+					goto out;
+			}
+
+			truncate_setsize(vi, attr->ia_size);
+			err = ntfs_truncate_vfs(vi, attr->ia_size, old_size);
+			if (err) {
+				i_size_write(vi, old_size);
+				goto out;
+			}
+
+			if (NInoNonResident(ni) && attr->ia_size > old_size &&
+				old_size % PAGE_SIZE != 0) {
+				loff_t len = min_t(loff_t,
+							round_up(old_size, PAGE_SIZE) - old_size,
+							attr->ia_size - old_size);
+				err = iomap_zero_range(vi, old_size, len,
+						       NULL, &ntfs_read_iomap_ops,
+						       &ntfs_iomap_folio_ops, NULL);
+			}
+		}
+		if (ia_valid == ATTR_SIZE)
+			goto out;
+		ia_valid |= ATTR_MTIME | ATTR_CTIME;
+	}
+
+	setattr_copy(idmap, vi, attr);
+
+	if (vol->sb->s_flags & SB_POSIXACL && !S_ISLNK(vi->i_mode)) {
+		err = posix_acl_chmod(idmap, dentry, vi->i_mode);
+		if (err)
+			goto out;
+	}
+
+	if (0222 & vi->i_mode)
+		ni->flags &= ~FILE_ATTR_READONLY;
+	else
+		ni->flags |= FILE_ATTR_READONLY;
+
+	if (ia_valid & (ATTR_UID | ATTR_GID | ATTR_MODE)) {
+		unsigned int flags = 0;
+
+		if (ia_valid & ATTR_UID)
+			flags |= NTFS_EA_UID;
+		if (ia_valid & ATTR_GID)
+			flags |= NTFS_EA_GID;
+		if (ia_valid & ATTR_MODE)
+			flags |= NTFS_EA_MODE;
+
+		if (S_ISDIR(vi->i_mode))
+			vi->i_mode &= ~vol->dmask;
+		else
+			vi->i_mode &= ~vol->fmask;
+
+		mutex_lock(&ni->mrec_lock);
+		ntfs_ea_set_wsl_inode(vi, 0, NULL, flags);
+		mutex_unlock(&ni->mrec_lock);
+	}
+
+	mark_inode_dirty(vi);
+out:
+	return err;
+}
+
+int ntfs_getattr(struct mnt_idmap *idmap, const struct path *path,
+		struct kstat *stat, unsigned int request_mask,
+		unsigned int query_flags)
+{
+	struct inode *inode = d_backing_inode(path->dentry);
+
+	generic_fillattr(idmap, request_mask, inode, stat);
+
+	stat->blksize = NTFS_SB(inode->i_sb)->cluster_size;
+	stat->blocks = (((u64)NTFS_I(inode)->i_dealloc_clusters <<
+			NTFS_SB(inode->i_sb)->cluster_size_bits) >> 9) + inode->i_blocks;
+	stat->result_mask |= STATX_BTIME;
+	stat->btime = NTFS_I(inode)->i_crtime;
+
+	return 0;
+}
+
+static loff_t ntfs_file_llseek(struct file *file, loff_t offset, int whence)
+{
+	struct inode *vi = file->f_mapping->host;
+
+	if (whence == SEEK_DATA || whence == SEEK_HOLE) {
+		struct ntfs_inode *ni = NTFS_I(vi);
+		struct ntfs_volume *vol = ni->vol;
+		struct runlist_element *rl;
+		s64 vcn;
+		unsigned int vcn_off;
+		loff_t end_off;
+		unsigned long flags;
+		int i;
+
+		inode_lock_shared(vi);
+
+		if (NInoCompressed(ni) || NInoEncrypted(ni))
+			goto error;
+
+		read_lock_irqsave(&ni->size_lock, flags);
+		end_off = ni->data_size;
+		read_unlock_irqrestore(&ni->size_lock, flags);
+
+		if (offset < 0 || offset >= end_off)
+			goto error;
+
+		if (!NInoNonResident(ni)) {
+			if (whence == SEEK_HOLE)
+				offset = end_off;
+			goto found_no_runlist_lock;
+		}
+
+		vcn = offset >> vol->cluster_size_bits;
+		vcn_off = offset & vol->cluster_size_mask;
+
+		down_read(&ni->runlist.lock);
+		rl = ni->runlist.rl;
+		i = 0;
+
+		BUG_ON(rl && rl[0].vcn > vcn);
+#ifdef DEBUG
+		ntfs_debug("init:");
+		ntfs_debug_dump_runlist(rl);
+#endif
+		while (1) {
+			if (!rl || !NInoFullyMapped(ni) || rl[i].lcn == LCN_RL_NOT_MAPPED) {
+				int ret;
+
+				up_read(&ni->runlist.lock);
+				ret = ntfs_map_runlist(ni, rl ? rl[i].vcn : 0);
+				if (ret)
+					goto error;
+				down_read(&ni->runlist.lock);
+				rl = ni->runlist.rl;
+#ifdef DEBUG
+				ntfs_debug("mapped:");
+				ntfs_debug_dump_runlist(ni->runlist.rl);
+#endif
+				continue;
+			} else if (rl[i].lcn == LCN_ENOENT) {
+				if (whence == SEEK_DATA) {
+					up_read(&ni->runlist.lock);
+					goto error;
+				} else {
+					offset = end_off;
+					goto found;
+				}
+			} else if (rl[i + 1].vcn > vcn) {
+				if ((whence == SEEK_DATA && (rl[i].lcn >= 0 ||
+						rl[i].lcn == LCN_DELALLOC)) ||
+				   (whence == SEEK_HOLE && rl[i].lcn == LCN_HOLE)) {
+					offset = (vcn << vol->cluster_size_bits) + vcn_off;
+					if (offset < ni->data_size)
+						goto found;
+				}
+				vcn = rl[i + 1].vcn;
+				vcn_off = 0;
+			}
+			i++;
+		}
+		up_read(&ni->runlist.lock);
+		inode_unlock_shared(vi);
+		BUG();
+found:
+		up_read(&ni->runlist.lock);
+found_no_runlist_lock:
+		inode_unlock_shared(vi);
+		return vfs_setpos(file, offset, vi->i_sb->s_maxbytes);
+error:
+		inode_unlock_shared(vi);
+		return -ENXIO;
+	} else {
+		return generic_file_llseek_size(file, offset, whence,
+						vi->i_sb->s_maxbytes,
+						i_size_read(vi));
+	}
+}
+
+static ssize_t ntfs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
+{
+	struct inode *vi = file_inode(iocb->ki_filp);
+	struct super_block *sb = vi->i_sb;
+	ssize_t ret;
+
+	if (NVolShutdown(NTFS_SB(sb)))
+		return -EIO;
+
+	if (NInoCompressed(NTFS_I(vi)) && iocb->ki_flags & IOCB_DIRECT)
+		return -EOPNOTSUPP;
+
+	inode_lock_shared(vi);
+
+	if (iocb->ki_flags & IOCB_DIRECT) {
+		size_t count = iov_iter_count(to);
+
+		if ((iocb->ki_pos | count) & (sb->s_blocksize - 1)) {
+			ret = -EINVAL;
+			goto inode_unlock;
+		}
+
+		file_accessed(iocb->ki_filp);
+		ret = iomap_dio_rw(iocb, to, &ntfs_read_iomap_ops, NULL, IOMAP_DIO_PARTIAL,
+				NULL, 0);
+	} else {
+		ret = generic_file_read_iter(iocb, to);
+	}
+
+inode_unlock:
+	inode_unlock_shared(vi);
+
+	return ret;
+}
+
+static int ntfs_file_write_dio_end_io(struct kiocb *iocb, ssize_t size,
+		int error, unsigned int flags)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	if (error)
+		return error;
+
+	if (size) {
+		if (i_size_read(inode) < iocb->ki_pos + size) {
+			i_size_write(inode, iocb->ki_pos + size);
+			mark_inode_dirty(inode);
+		}
+	}
+
+	return 0;
+}
+
+static const struct iomap_dio_ops ntfs_write_dio_ops = {
+	.end_io			= ntfs_file_write_dio_end_io,
+};
+
+static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct file *file = iocb->ki_filp;
+	struct inode *vi = file->f_mapping->host;
+	struct ntfs_inode *ni = NTFS_I(vi);
+	struct ntfs_volume *vol = ni->vol;
+	ssize_t ret;
+	ssize_t count;
+	loff_t pos;
+	int err;
+	loff_t old_data_size, old_init_size;
+
+	if (NVolShutdown(vol))
+		return -EIO;
+
+	if (NInoEncrypted(ni)) {
+		ntfs_error(vi->i_sb, "Writing for %s files is not supported yet",
+			   NInoCompressed(ni) ? "Compressed" : "Encrypted");
+		return -EOPNOTSUPP;
+	}
+
+	if (NInoCompressed(ni) && iocb->ki_flags & IOCB_DIRECT)
+		return -EOPNOTSUPP;
+
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!inode_trylock(vi))
+			return -EAGAIN;
+	} else
+		inode_lock(vi);
+
+	ret = generic_write_checks(iocb, from);
+	if (ret <= 0)
+		goto out_lock;
+
+	if (NInoNonResident(ni) && (iocb->ki_flags & IOCB_DIRECT) &&
+	    ((iocb->ki_pos | ret) & (vi->i_sb->s_blocksize - 1))) {
+		ret = -EINVAL;
+		goto out_lock;
+	}
+
+	err = file_modified(iocb->ki_filp);
+	if (err) {
+		ret = err;
+		goto out_lock;
+	}
+
+	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
+		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
+
+	pos = iocb->ki_pos;
+	count = ret;
+
+	old_data_size = ni->data_size;
+	old_init_size = ni->initialized_size;
+	if (iocb->ki_pos + ret > old_data_size) {
+		mutex_lock(&ni->mrec_lock);
+		if (!NInoCompressed(ni) && iocb->ki_pos + ret > ni->allocated_size &&
+		    iocb->ki_pos + ret < ni->allocated_size + vol->preallocated_size)
+			ret = ntfs_attr_expand(ni, iocb->ki_pos + ret,
+					ni->allocated_size + vol->preallocated_size);
+		else if (NInoCompressed(ni) && iocb->ki_pos + ret > ni->allocated_size)
+			ret = ntfs_attr_expand(ni, iocb->ki_pos + ret,
+				round_up(iocb->ki_pos + ret, ni->itype.compressed.block_size));
+		else
+			ret = ntfs_attr_expand(ni, iocb->ki_pos + ret, 0);
+		mutex_unlock(&ni->mrec_lock);
+		if (ret < 0)
+			goto out;
+	}
+
+	if (NInoNonResident(ni) && iocb->ki_pos + count > old_init_size) {
+		ret = ntfs_extend_initialized_size(vi, iocb->ki_pos,
+				iocb->ki_pos + count);
+		if (ret < 0)
+			goto out;
+	}
+
+	if (NInoNonResident(ni) && NInoCompressed(ni)) {
+		ret = ntfs_compress_write(ni, pos, count, from);
+		if (ret > 0)
+			iocb->ki_pos += ret;
+		goto out;
+	}
+
+	if (NInoNonResident(ni) && iocb->ki_flags & IOCB_DIRECT) {
+		ret = iomap_dio_rw(iocb, from, &ntfs_dio_iomap_ops,
+				   &ntfs_write_dio_ops, 0, NULL, 0);
+		if (ret == -ENOTBLK)
+			ret = 0;
+		else if (ret < 0)
+			goto out;
+
+		if (iov_iter_count(from)) {
+			loff_t offset, end;
+			ssize_t written;
+			int ret2;
+
+			offset = iocb->ki_pos;
+			iocb->ki_flags &= ~IOCB_DIRECT;
+			written = iomap_file_buffered_write(iocb, from,
+					&ntfs_write_iomap_ops, &ntfs_iomap_folio_ops,
+					NULL);
+			if (written < 0) {
+				err = written;
+				goto out;
+			}
+
+			ret += written;
+			end = iocb->ki_pos + written - 1;
+			ret2 = filemap_write_and_wait_range(iocb->ki_filp->f_mapping,
+							    offset, end);
+			if (ret2)
+				goto out_err;
+			if (!ret2)
+				invalidate_mapping_pages(iocb->ki_filp->f_mapping,
+							 offset >> PAGE_SHIFT,
+							 end >> PAGE_SHIFT);
+		}
+	} else {
+		ret = iomap_file_buffered_write(iocb, from, &ntfs_write_iomap_ops,
+				&ntfs_iomap_folio_ops, NULL);
+	}
+out:
+	if (ret < 0 && ret != -EIOCBQUEUED) {
+out_err:
+		if (ni->initialized_size != old_init_size) {
+			mutex_lock(&ni->mrec_lock);
+			ntfs_attr_set_initialized_size(ni, old_init_size);
+			mutex_unlock(&ni->mrec_lock);
+		}
+		if (ni->data_size != old_data_size) {
+			truncate_setsize(vi, old_data_size);
+			ntfs_attr_truncate(ni, old_data_size);
+		}
+	}
+out_lock:
+	inode_unlock(vi);
+	if (ret > 0)
+		ret = generic_write_sync(iocb, ret);
+	return ret;
+}
+
+static vm_fault_t ntfs_filemap_page_mkwrite(struct vm_fault *vmf)
+{
+	struct inode *inode = file_inode(vmf->vma->vm_file);
+	vm_fault_t ret;
+
+	if (unlikely(IS_IMMUTABLE(inode)))
+		return VM_FAULT_SIGBUS;
+
+	sb_start_pagefault(inode->i_sb);
+	file_update_time(vmf->vma->vm_file);
+
+	ret = iomap_page_mkwrite(vmf, &ntfs_page_mkwrite_iomap_ops, NULL);
+	sb_end_pagefault(inode->i_sb);
+	return ret;
+}
+
+static const struct vm_operations_struct ntfs_file_vm_ops = {
+	.fault		= filemap_fault,
+	.map_pages	= filemap_map_pages,
+	.page_mkwrite	= ntfs_filemap_page_mkwrite,
+};
+
+static int ntfs_file_mmap_prepare(struct vm_area_desc *desc)
+{
+	struct file *file = desc->file;
+	struct inode *inode = file_inode(file);
+
+	if (NVolShutdown(NTFS_SB(file->f_mapping->host->i_sb)))
+		return -EIO;
+
+	if (NInoCompressed(NTFS_I(inode)))
+		return -EOPNOTSUPP;
+
+	if (desc->vm_flags & VM_WRITE) {
+		struct inode *inode = file_inode(file);
+		loff_t from, to;
+		int err;
+
+		from = ((loff_t)desc->pgoff << PAGE_SHIFT);
+		to = min_t(loff_t, i_size_read(inode),
+			   from + desc->end - desc->start);
+
+		if (NTFS_I(inode)->initialized_size < to) {
+			err = ntfs_extend_initialized_size(inode, to, to);
+			if (err)
+				return err;
+		}
+	}
+
+
+	file_accessed(file);
+	desc->vm_ops = &ntfs_file_vm_ops;
+	return 0;
+}
+
+static int ntfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
+		u64 start, u64 len)
+{
+	return iomap_fiemap(inode, fieinfo, start, len, &ntfs_read_iomap_ops);
+}
+
+static const char *ntfs_get_link(struct dentry *dentry, struct inode *inode,
+		struct delayed_call *done)
+{
+	if (!NTFS_I(inode)->target)
+		return ERR_PTR(-EINVAL);
+
+	return NTFS_I(inode)->target;
+}
+
+static ssize_t ntfs_file_splice_read(struct file *in, loff_t *ppos,
+		struct pipe_inode_info *pipe, size_t len, unsigned int flags)
+{
+	if (NVolShutdown(NTFS_SB(in->f_mapping->host->i_sb)))
+		return -EIO;
+
+	return filemap_splice_read(in, ppos, pipe, len, flags);
+}
+
+static int ntfs_ioctl_shutdown(struct super_block *sb, unsigned long arg)
+{
+	u32 flags;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (get_user(flags, (__u32 __user *)arg))
+		return -EFAULT;
+
+	return ntfs_force_shutdown(sb, flags);
+}
+
+long ntfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	struct inode *inode = file_inode(filp);
+
+	switch (cmd) {
+	case NTFS_IOC_SHUTDOWN:
+		return ntfs_ioctl_shutdown(inode->i_sb, arg);
+	default:
+		return -ENOTTY;
+	}
+}
+
+#ifdef CONFIG_COMPAT
+long ntfs_compat_ioctl(struct file *filp, unsigned int cmd,
+		unsigned long arg)
+{
+	return ntfs_ioctl(filp, cmd, (unsigned long)compat_ptr(arg));
+}
+#endif
+
+static long ntfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
+{
+	struct inode *vi = file_inode(file);
+	struct ntfs_inode *ni = NTFS_I(vi);
+	struct ntfs_volume *vol = ni->vol;
+	int err = 0;
+	loff_t end_offset = offset + len;
+	loff_t old_size, new_size;
+	s64 start_vcn, end_vcn;
+	bool map_locked = false;
+
+	if (!S_ISREG(vi->i_mode))
+		return -EOPNOTSUPP;
+
+	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_INSERT_RANGE |
+		     FALLOC_FL_PUNCH_HOLE | FALLOC_FL_COLLAPSE_RANGE))
+		return -EOPNOTSUPP;
+
+	if (!NVolFreeClusterKnown(vol))
+		wait_event(vol->free_waitq, NVolFreeClusterKnown(vol));
+
+	if ((ni->vol->mft_zone_end - ni->vol->mft_zone_start) == 0)
+		return -ENOSPC;
+
+	if (NInoNonResident(ni) && !NInoFullyMapped(ni)) {
+		down_write(&ni->runlist.lock);
+		err = ntfs_attr_map_whole_runlist(ni);
+		up_write(&ni->runlist.lock);
+		if (err)
+			return err;
+	}
+
+	if (!(vol->vol_flags & VOLUME_IS_DIRTY)) {
+		err = ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
+		if (err)
+			return err;
+	}
+
+	old_size = i_size_read(vi);
+	new_size = max_t(loff_t, old_size, end_offset);
+	start_vcn = offset >> vol->cluster_size_bits;
+	end_vcn = ((end_offset - 1) >> vol->cluster_size_bits) + 1;
+
+	inode_lock(vi);
+	if (NInoCompressed(ni) || NInoEncrypted(ni)) {
+		err = -EOPNOTSUPP;
+		goto out;
+	}
+
+	inode_dio_wait(vi);
+	if (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_COLLAPSE_RANGE |
+		    FALLOC_FL_INSERT_RANGE)) {
+		filemap_invalidate_lock(vi->i_mapping);
+		map_locked = true;
+	}
+
+	if (mode & FALLOC_FL_INSERT_RANGE) {
+		loff_t offset_down = round_down(offset,
+						max_t(unsigned long, vol->cluster_size, PAGE_SIZE));
+		loff_t alloc_size;
+
+		if ((offset & vol->cluster_size_mask) ||
+		    (len & vol->cluster_size_mask) ||
+		    offset >= ni->allocated_size) {
+			err = -EINVAL;
+			goto out;
+		}
+
+		new_size = old_size +
+			((end_vcn - start_vcn) << vol->cluster_size_bits);
+		alloc_size = ni->allocated_size +
+			((end_vcn - start_vcn) << vol->cluster_size_bits);
+		if (alloc_size < 0) {
+			err = -EFBIG;
+			goto out;
+		}
+		err = inode_newsize_ok(vi, alloc_size);
+		if (err)
+			goto out;
+
+		err = filemap_write_and_wait_range(vi->i_mapping,
+						   offset_down, LLONG_MAX);
+		if (err)
+			goto out;
+
+		truncate_pagecache(vi, offset_down);
+
+		mutex_lock_nested(&ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL);
+		err = ntfs_non_resident_attr_insert_range(ni, start_vcn,
+							  end_vcn - start_vcn);
+		mutex_unlock(&ni->mrec_lock);
+		if (err)
+			goto out;
+	} else if (mode & FALLOC_FL_COLLAPSE_RANGE) {
+		loff_t offset_down = round_down(offset,
+						max_t(unsigned long, vol->cluster_size, PAGE_SIZE));
+
+		if ((offset & vol->cluster_size_mask) ||
+		    (len & vol->cluster_size_mask) ||
+		    offset >= ni->allocated_size) {
+			err = -EINVAL;
+			goto out;
+		}
+
+		if ((end_vcn << vol->cluster_size_bits) > ni->allocated_size)
+			end_vcn = DIV_ROUND_UP(ni->allocated_size - 1,
+					       vol->cluster_size) + 1;
+		new_size = old_size -
+			((end_vcn - start_vcn) << vol->cluster_size_bits);
+		if (new_size < 0)
+			new_size = 0;
+		err = filemap_write_and_wait_range(vi->i_mapping,
+						   offset_down, LLONG_MAX);
+		if (err)
+			goto out;
+
+		truncate_pagecache(vi, offset_down);
+
+		mutex_lock_nested(&ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL);
+		err = ntfs_non_resident_attr_collapse_range(ni, start_vcn,
+							    end_vcn - start_vcn);
+		mutex_unlock(&ni->mrec_lock);
+		if (err)
+			goto out;
+	} else if (mode & FALLOC_FL_PUNCH_HOLE) {
+		loff_t offset_down = round_down(offset, max_t(unsigned int,
+							      vol->cluster_size, PAGE_SIZE));
+
+		if (!(mode & FALLOC_FL_KEEP_SIZE)) {
+			err = -EINVAL;
+			goto out;
+		}
+
+		if (offset >= ni->data_size)
+			goto out;
+
+		if (offset + len > ni->data_size) {
+			end_offset = ni->data_size;
+			end_vcn = ((end_offset - 1) >> vol->cluster_size_bits) + 1;
+		}
+
+		err = filemap_write_and_wait_range(vi->i_mapping, offset_down, LLONG_MAX);
+		if (err)
+			goto out;
+		truncate_pagecache(vi, offset_down);
+
+		if (offset & vol->cluster_size_mask) {
+			loff_t to;
+
+			to = min_t(loff_t, (start_vcn + 1) << vol->cluster_size_bits,
+				   end_offset);
+			err = iomap_zero_range(vi, offset, to - offset, NULL,
+					       &ntfs_read_iomap_ops,
+					       &ntfs_iomap_folio_ops, NULL);
+			if (err < 0 || (end_vcn - start_vcn) == 1)
+				goto out;
+			start_vcn++;
+		}
+		if (end_offset & vol->cluster_size_mask) {
+			loff_t from;
+
+			from = (end_vcn - 1) << vol->cluster_size_bits;
+			err = iomap_zero_range(vi, from, end_offset - from, NULL,
+					       &ntfs_read_iomap_ops,
+					       &ntfs_iomap_folio_ops, NULL);
+			if (err < 0 || (end_vcn - start_vcn) == 1)
+				goto out;
+			end_vcn--;
+		}
+
+		mutex_lock_nested(&ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL);
+		err = ntfs_non_resident_attr_punch_hole(ni, start_vcn,
+							end_vcn - start_vcn);
+		mutex_unlock(&ni->mrec_lock);
+		if (err)
+			goto out;
+	} else if (mode == 0 || mode == FALLOC_FL_KEEP_SIZE) {
+		s64 need_space;
+
+		err = inode_newsize_ok(vi, new_size);
+		if (err)
+			goto out;
+
+		need_space = ni->allocated_size << vol->cluster_size_bits;
+		if (need_space > start_vcn)
+			need_space = end_vcn - need_space;
+		else
+			need_space = end_vcn - start_vcn;
+		if (need_space > 0 &&
+		    need_space > (atomic64_read(&vol->free_clusters) -
+			    atomic64_read(&vol->dirty_clusters))) {
+			err = -ENOSPC;
+			goto out;
+		}
+
+		err = ntfs_attr_fallocate(ni, offset, len,
+					  mode & FALLOC_FL_KEEP_SIZE ? true : false);
+		if (err)
+			goto out;
+	}
+
+	/* inode->i_blocks is already updated in ntfs_attr_update_mapping_pairs */
+	if (!(mode & FALLOC_FL_KEEP_SIZE) && new_size != old_size)
+		i_size_write(vi, ni->data_size);
+
+out:
+	if (map_locked)
+		filemap_invalidate_unlock(vi->i_mapping);
+	if (!err) {
+		if (mode == 0 && NInoNonResident(ni) &&
+		offset > old_size && old_size % PAGE_SIZE != 0) {
+			loff_t len = min_t(loff_t,
+					   round_up(old_size, PAGE_SIZE) - old_size,
+					   offset - old_size);
+			err = iomap_zero_range(vi, old_size, len, NULL,
+					       &ntfs_read_iomap_ops,
+					       &ntfs_iomap_folio_ops, NULL);
+		}
+		NInoSetFileNameDirty(ni);
+		inode_set_mtime_to_ts(vi, inode_set_ctime_current(vi));
+		mark_inode_dirty(vi);
+	}
+
+	inode_unlock(vi);
+	return err;
+}
+
+const struct file_operations ntfs_file_ops = {
+	.llseek		= ntfs_file_llseek,
+	.read_iter	= ntfs_file_read_iter,
+	.write_iter	= ntfs_file_write_iter,
+	.fsync		= ntfs_file_fsync,
+	.mmap_prepare	= ntfs_file_mmap_prepare,
+	.open		= ntfs_file_open,
+	.release	= ntfs_file_release,
+	.splice_read	= ntfs_file_splice_read,
+	.splice_write	= iter_file_splice_write,
+	.unlocked_ioctl	= ntfs_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= ntfs_compat_ioctl,
+#endif
+	.fallocate	= ntfs_fallocate,
+};
+
+const struct inode_operations ntfs_file_inode_ops = {
+	.setattr	= ntfs_setattr,
+	.getattr	= ntfs_getattr,
+	.listxattr	= ntfs_listxattr,
+	.get_acl	= ntfs_get_acl,
+	.set_acl	= ntfs_set_acl,
+	.fiemap		= ntfs_fiemap,
+};
+
+const struct inode_operations ntfs_symlink_inode_operations = {
+	.get_link	= ntfs_get_link,
+	.setattr	= ntfs_setattr,
+	.listxattr	= ntfs_listxattr,
+};
+
+const struct inode_operations ntfs_special_inode_operations = {
+	.setattr	= ntfs_setattr,
+	.getattr	= ntfs_getattr,
+	.listxattr	= ntfs_listxattr,
+	.get_acl	= ntfs_get_acl,
+	.set_acl	= ntfs_set_acl,
+};
+
+const struct file_operations ntfs_empty_file_ops = {};
+
+const struct inode_operations ntfs_empty_inode_ops = {};
-- 
2.34.1


