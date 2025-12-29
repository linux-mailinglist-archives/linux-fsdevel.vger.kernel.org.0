Return-Path: <linux-fsdevel+bounces-72174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1789CE6C9F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 13:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7892F302D917
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 12:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F96314D30;
	Mon, 29 Dec 2025 12:47:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679F93148BC
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 12:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767012456; cv=none; b=YZJDK9Gmd9zUimKu98FOo1kHhrR2/oxSdmuASdS1YNoQWLdoaEScmhOejIYpLSmMlYKmIyoN/Ykd0RxShPqimYB969Ba7/OdGgbgxFy059QyYqTw3YRvTnj6QAGCRwTwzcRUz7Y8lLTNkNObx/dzcOmOqqWz6OytQlamhQvTs3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767012456; c=relaxed/simple;
	bh=pWJnzZcJEWpcE1XJZsj82T5Z8SaIiyObojX7c2DPZUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E3Jsha73/NzWR5TdY1r1Ss/nAdht/0vITqeionXVD9bI06Lia2ZFIEBANq/4/CK2hHZxl4W+14w8BDTf0eVBfEIFn5y7mdxhhQxFiHDJf3OqODfYb2N4BUUlxXqsLfWcIzo6m4sap0xFLf1ru+rSt03FgI2aBjGkhxJL9oY52wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-941063da73eso5842095241.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 04:47:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767012450; x=1767617250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rOwQLMiyqBAdrmM5SDDZ+b8raSHvWeln5FTv4r+UnVc=;
        b=lGCm1ykcQzeaUkz9MOMDZ1XJv1biBVjw1vWyGT3XLhrdVtUJpRrnSKhVAh4ffQaQr9
         za6YkpVXhZXusLNaa0bhGCsxoBkU3YadKObatCrJi037NYeF+nye7rb/+CKYSr/oVXcC
         JdX5T7S+hLlfyiqA8KuyAaXVQajJvrVbEIANWryP9saHZJgb2eCVk0if/SFWV7tRNKQb
         mMNyb33qMX552/Do0zSW3W5rnQr1QVElDrbXHeirCxShmYa4qvrmZzH+Ntln6d8EW+Gz
         20OJz9gwLzE3MnAdvy0b6N1vKJIoLBoa1q/DOtyuta9Mp8x7OYRFag3RqECwMl7DEQVf
         tabg==
X-Gm-Message-State: AOJu0Yw/CnpcCQy05aGQDbPf7ggHFMO8SBmv4+WRtKCpdvNbbPFkop9x
	1QQ1H48cnxIgTuzAsRRLytGMRXN0PgyDT6xmLN9JR3Jst74at5DZrIvx7iQfBA==
X-Gm-Gg: AY/fxX4RB73BNXbGRsFD/cU4hE6iOkKXOopsnKJKlcJ4geQkV/1pICqdHv70LxNpDJ8
	+ctcNogxXn7UV8edyni45PewM2xDtsDK9nJxZyCm3klpnjgoCr28h0dGIe+UZnOWLWqLLv7obRc
	94UBW0FdWC3C7YdVCy6Ok578q0TCX7/u2WAh/0aSd/IHBC430YJvpiP5wHePB+fC0Mt4s+jrxY+
	4dBlLovC+5lW4v2u2x7xd1iZ4KhCHDaYs/pTSD4dOpGkl92gDv7hEk2QIOD5POk8ExfYlC4kIo6
	ekVciB8HsbUN2n+JDQI3jRPgHq8MZ1DFFE9GwoDGSCRrH2TpEYF7zKKXrS5mYD2dt54bD/vQCFy
	JngyILQJEvE5IFH8njb1d4QETl/+PplpJHaQkCYrmMYtHK9kDirSmau66rA0IeRH69CYq7NptbK
	YAUiXvFmXg63Pe0g1mN+1yDddiHI0nNZsAJIu3
X-Google-Smtp-Source: AGHT+IGCOmJXWcPAr1/h9y7UT46RpbzBt6q65OuSh29exvAA+Ibsm8WdqCZ8VjTU/G+iIY+gbkQRMA==
X-Received: by 2002:a05:6a00:1f14:b0:7e8:4398:b36e with SMTP id d2e1a72fcca58-7ff66c6b034mr23072440b3a.65.1767006084157;
        Mon, 29 Dec 2025 03:01:24 -0800 (PST)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7aa328basm29320722b3a.11.2025.12.29.03.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 03:01:23 -0800 (PST)
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
	Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Subject: [PATCH v3 06/14] ntfs: update file operations
Date: Mon, 29 Dec 2025 19:59:24 +0900
Message-Id: <20251229105932.11360-7-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251229105932.11360-1-linkinjeon@kernel.org>
References: <20251229105932.11360-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This updates the implementation of file operations

Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ntfs/file.c | 2855 +++++++++++++++++-------------------------------
 1 file changed, 1000 insertions(+), 1855 deletions(-)

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 297c0b9db621..245489f6558d 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -1,32 +1,30 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * file.c - NTFS kernel file operations.  Part of the Linux-NTFS project.
+ * NTFS kernel file operations. Part of the Linux-NTFS project.
  *
  * Copyright (c) 2001-2015 Anton Altaparmakov and Tuxera Inc.
+ * Copyright (c) 2025 LG Electronics Co., Ltd.
  */
 
+#include <linux/writeback.h>
 #include <linux/blkdev.h>
-#include <linux/backing-dev.h>
-#include <linux/buffer_head.h>
-#include <linux/gfp.h>
-#include <linux/pagemap.h>
-#include <linux/pagevec.h>
-#include <linux/sched/signal.h>
-#include <linux/swap.h>
+#include <linux/fs.h>
+#include <linux/iomap.h>
 #include <linux/uio.h>
-#include <linux/writeback.h>
+#include <linux/posix_acl.h>
+#include <linux/posix_acl_xattr.h>
+#include <linux/compat.h>
+#include <linux/falloc.h>
+#include <uapi/linux/ntfs.h>
 
-#include <asm/page.h>
-#include <linux/uaccess.h>
-
-#include "attrib.h"
-#include "bitmap.h"
-#include "inode.h"
-#include "debug.h"
 #include "lcnalloc.h"
-#include "malloc.h"
-#include "mft.h"
 #include "ntfs.h"
+#include "aops.h"
+#include "reparse.h"
+#include "ea.h"
+#include "iomap.h"
+#include "bitmap.h"
+#include "malloc.h"
 
 /**
  * ntfs_file_open - called when an inode is about to be opened
@@ -48,1948 +46,1095 @@
  */
 static int ntfs_file_open(struct inode *vi, struct file *filp)
 {
+	struct ntfs_inode *ni = NTFS_I(vi);
+
+	if (NVolShutdown(ni->vol))
+		return -EIO;
+
 	if (sizeof(unsigned long) < 8) {
 		if (i_size_read(vi) > MAX_LFS_FILESIZE)
 			return -EOVERFLOW;
 	}
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
 	return generic_file_open(vi, filp);
 }
 
-#ifdef NTFS_RW
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
+		s64 vcn_ds = NTFS_B_TO_CLU(vol, aligned_data_size);
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
+				ni->allocated_size = NTFS_CLU_TO_B(vol, vcn_tr);
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
 
 /**
- * ntfs_attr_extend_initialized - extend the initialized size of an attribute
- * @ni:			ntfs inode of the attribute to extend
- * @new_init_size:	requested new initialized size in bytes
- *
- * Extend the initialized size of an attribute described by the ntfs inode @ni
- * to @new_init_size bytes.  This involves zeroing any non-sparse space between
- * the old initialized size and @new_init_size both in the page cache and on
- * disk (if relevant complete pages are already uptodate in the page cache then
- * these are simply marked dirty).
+ * ntfs_file_fsync - sync a file to disk
+ * @filp:	file to be synced
+ * @start:	start offset to be synced
+ * @end:	end offset to be synced
+ * @datasync:	if non-zero only flush user data and not metadata
  *
- * As a side-effect, the file size (vfs inode->i_size) may be incremented as,
- * in the resident attribute case, it is tied to the initialized size and, in
- * the non-resident attribute case, it may not fall below the initialized size.
+ * Data integrity sync of a file to disk.  Used for fsync, fdatasync, and msync
+ * system calls.  This function is inspired by fs/buffer.c::file_fsync().
  *
- * Note that if the attribute is resident, we do not need to touch the page
- * cache at all.  This is because if the page cache page is not uptodate we
- * bring it uptodate later, when doing the write to the mft record since we
- * then already have the page mapped.  And if the page is uptodate, the
- * non-initialized region will already have been zeroed when the page was
- * brought uptodate and the region may in fact already have been overwritten
- * with new data via mmap() based writes, so we cannot just zero it.  And since
- * POSIX specifies that the behaviour of resizing a file whilst it is mmap()ped
- * is unspecified, we choose not to do zeroing and thus we do not need to touch
- * the page at all.  For a more detailed explanation see ntfs_truncate() in
- * fs/ntfs/inode.c.
+ * If @datasync is false, write the mft record and all associated extent mft
+ * records as well as the $DATA attribute and then sync the block device.
  *
- * Return 0 on success and -errno on error.  In the case that an error is
- * encountered it is possible that the initialized size will already have been
- * incremented some way towards @new_init_size but it is guaranteed that if
- * this is the case, the necessary zeroing will also have happened and that all
- * metadata is self-consistent.
+ * If @datasync is true and the attribute is non-resident, we skip the writing
+ * of the mft record and all associated extent mft records (this might still
+ * happen due to the write_inode_now() call).
  *
- * Locking: i_mutex on the vfs inode corrseponsind to the ntfs inode @ni must be
- *	    held by the caller.
+ * Also, if @datasync is true, we do not wait on the inode to be written out
+ * but we always wait on the page cache pages to be written out.
  */
-static int ntfs_attr_extend_initialized(ntfs_inode *ni, const s64 new_init_size)
+static int ntfs_file_fsync(struct file *filp, loff_t start, loff_t end,
+			   int datasync)
 {
-	s64 old_init_size;
-	loff_t old_i_size;
-	pgoff_t index, end_index;
-	unsigned long flags;
-	struct inode *vi = VFS_I(ni);
-	ntfs_inode *base_ni;
-	MFT_RECORD *m = NULL;
-	ATTR_RECORD *a;
-	ntfs_attr_search_ctx *ctx = NULL;
-	struct address_space *mapping;
-	struct page *page = NULL;
-	u8 *kattr;
-	int err;
-	u32 attr_len;
+	struct inode *vi = filp->f_mapping->host;
+	struct ntfs_inode *ni = NTFS_I(vi);
+	struct ntfs_volume *vol = ni->vol;
+	int err, ret = 0;
+	struct inode *parent_vi, *ia_vi;
+	struct ntfs_attr_search_ctx *ctx;
 
-	read_lock_irqsave(&ni->size_lock, flags);
-	old_init_size = ni->initialized_size;
-	old_i_size = i_size_read(vi);
-	BUG_ON(new_init_size > ni->allocated_size);
-	read_unlock_irqrestore(&ni->size_lock, flags);
-	ntfs_debug("Entering for i_ino 0x%lx, attribute type 0x%x, "
-			"old_initialized_size 0x%llx, "
-			"new_initialized_size 0x%llx, i_size 0x%llx.",
-			vi->i_ino, (unsigned)le32_to_cpu(ni->type),
-			(unsigned long long)old_init_size,
-			(unsigned long long)new_init_size, old_i_size);
-	if (!NInoAttr(ni))
-		base_ni = ni;
-	else
-		base_ni = ni->ext.base_ntfs_ino;
-	/* Use goto to reduce indentation and we need the label below anyway. */
-	if (NInoNonResident(ni))
-		goto do_non_resident_extend;
-	BUG_ON(old_init_size != old_i_size);
-	m = map_mft_record(base_ni);
-	if (IS_ERR(m)) {
-		err = PTR_ERR(m);
-		m = NULL;
-		goto err_out;
-	}
-	ctx = ntfs_attr_get_search_ctx(base_ni, m);
-	if (unlikely(!ctx)) {
-		err = -ENOMEM;
-		goto err_out;
-	}
-	err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
-			CASE_SENSITIVE, 0, NULL, 0, ctx);
-	if (unlikely(err)) {
-		if (err == -ENOENT)
-			err = -EIO;
-		goto err_out;
-	}
-	m = ctx->mrec;
-	a = ctx->attr;
-	BUG_ON(a->non_resident);
-	/* The total length of the attribute value. */
-	attr_len = le32_to_cpu(a->data.resident.value_length);
-	BUG_ON(old_i_size != (loff_t)attr_len);
-	/*
-	 * Do the zeroing in the mft record and update the attribute size in
-	 * the mft record.
-	 */
-	kattr = (u8*)a + le16_to_cpu(a->data.resident.value_offset);
-	memset(kattr + attr_len, 0, new_init_size - attr_len);
-	a->data.resident.value_length = cpu_to_le32((u32)new_init_size);
-	/* Finally, update the sizes in the vfs and ntfs inodes. */
-	write_lock_irqsave(&ni->size_lock, flags);
-	i_size_write(vi, new_init_size);
-	ni->initialized_size = new_init_size;
-	write_unlock_irqrestore(&ni->size_lock, flags);
-	goto done;
-do_non_resident_extend:
-	/*
-	 * If the new initialized size @new_init_size exceeds the current file
-	 * size (vfs inode->i_size), we need to extend the file size to the
-	 * new initialized size.
-	 */
-	if (new_init_size > old_i_size) {
-		m = map_mft_record(base_ni);
-		if (IS_ERR(m)) {
-			err = PTR_ERR(m);
-			m = NULL;
-			goto err_out;
-		}
-		ctx = ntfs_attr_get_search_ctx(base_ni, m);
-		if (unlikely(!ctx)) {
-			err = -ENOMEM;
-			goto err_out;
-		}
-		err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
-				CASE_SENSITIVE, 0, NULL, 0, ctx);
-		if (unlikely(err)) {
-			if (err == -ENOENT)
-				err = -EIO;
-			goto err_out;
-		}
-		m = ctx->mrec;
-		a = ctx->attr;
-		BUG_ON(!a->non_resident);
-		BUG_ON(old_i_size != (loff_t)
-				sle64_to_cpu(a->data.non_resident.data_size));
-		a->data.non_resident.data_size = cpu_to_sle64(new_init_size);
-		flush_dcache_mft_record_page(ctx->ntfs_ino);
-		mark_mft_record_dirty(ctx->ntfs_ino);
-		/* Update the file size in the vfs inode. */
-		i_size_write(vi, new_init_size);
-		ntfs_attr_put_search_ctx(ctx);
-		ctx = NULL;
-		unmap_mft_record(base_ni);
-		m = NULL;
-	}
-	mapping = vi->i_mapping;
-	index = old_init_size >> PAGE_SHIFT;
-	end_index = (new_init_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	do {
-		/*
-		 * Read the page.  If the page is not present, this will zero
-		 * the uninitialized regions for us.
-		 */
-		page = read_mapping_page(mapping, index, NULL);
-		if (IS_ERR(page)) {
-			err = PTR_ERR(page);
-			goto init_err_out;
-		}
-		/*
-		 * Update the initialized size in the ntfs inode.  This is
-		 * enough to make ntfs_writepage() work.
-		 */
-		write_lock_irqsave(&ni->size_lock, flags);
-		ni->initialized_size = (s64)(index + 1) << PAGE_SHIFT;
-		if (ni->initialized_size > new_init_size)
-			ni->initialized_size = new_init_size;
-		write_unlock_irqrestore(&ni->size_lock, flags);
-		/* Set the page dirty so it gets written out. */
-		set_page_dirty(page);
-		put_page(page);
-		/*
-		 * Play nice with the vm and the rest of the system.  This is
-		 * very much needed as we can potentially be modifying the
-		 * initialised size from a very small value to a really huge
-		 * value, e.g.
-		 *	f = open(somefile, O_TRUNC);
-		 *	truncate(f, 10GiB);
-		 *	seek(f, 10GiB);
-		 *	write(f, 1);
-		 * And this would mean we would be marking dirty hundreds of
-		 * thousands of pages or as in the above example more than
-		 * two and a half million pages!
-		 *
-		 * TODO: For sparse pages could optimize this workload by using
-		 * the FsMisc / MiscFs page bit as a "PageIsSparse" bit.  This
-		 * would be set in read_folio for sparse pages and here we would
-		 * not need to mark dirty any pages which have this bit set.
-		 * The only caveat is that we have to clear the bit everywhere
-		 * where we allocate any clusters that lie in the page or that
-		 * contain the page.
-		 *
-		 * TODO: An even greater optimization would be for us to only
-		 * call read_folio() on pages which are not in sparse regions as
-		 * determined from the runlist.  This would greatly reduce the
-		 * number of pages we read and make dirty in the case of sparse
-		 * files.
-		 */
-		balance_dirty_pages_ratelimited(mapping);
-		cond_resched();
-	} while (++index < end_index);
-	read_lock_irqsave(&ni->size_lock, flags);
-	BUG_ON(ni->initialized_size != new_init_size);
-	read_unlock_irqrestore(&ni->size_lock, flags);
-	/* Now bring in sync the initialized_size in the mft record. */
-	m = map_mft_record(base_ni);
-	if (IS_ERR(m)) {
-		err = PTR_ERR(m);
-		m = NULL;
-		goto init_err_out;
-	}
-	ctx = ntfs_attr_get_search_ctx(base_ni, m);
-	if (unlikely(!ctx)) {
-		err = -ENOMEM;
-		goto init_err_out;
-	}
-	err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
-			CASE_SENSITIVE, 0, NULL, 0, ctx);
-	if (unlikely(err)) {
-		if (err == -ENOENT)
-			err = -EIO;
-		goto init_err_out;
-	}
-	m = ctx->mrec;
-	a = ctx->attr;
-	BUG_ON(!a->non_resident);
-	a->data.non_resident.initialized_size = cpu_to_sle64(new_init_size);
-done:
-	flush_dcache_mft_record_page(ctx->ntfs_ino);
-	mark_mft_record_dirty(ctx->ntfs_ino);
-	if (ctx)
-		ntfs_attr_put_search_ctx(ctx);
-	if (m)
-		unmap_mft_record(base_ni);
-	ntfs_debug("Done, initialized_size 0x%llx, i_size 0x%llx.",
-			(unsigned long long)new_init_size, i_size_read(vi));
-	return 0;
-init_err_out:
-	write_lock_irqsave(&ni->size_lock, flags);
-	ni->initialized_size = old_init_size;
-	write_unlock_irqrestore(&ni->size_lock, flags);
-err_out:
-	if (ctx)
-		ntfs_attr_put_search_ctx(ctx);
-	if (m)
-		unmap_mft_record(base_ni);
-	ntfs_debug("Failed.  Returning error code %i.", err);
-	return err;
-}
+	ntfs_debug("Entering for inode 0x%lx.", vi->i_ino);
 
-static ssize_t ntfs_prepare_file_for_write(struct kiocb *iocb,
-		struct iov_iter *from)
-{
-	loff_t pos;
-	s64 end, ll;
-	ssize_t err;
-	unsigned long flags;
-	struct file *file = iocb->ki_filp;
-	struct inode *vi = file_inode(file);
-	ntfs_inode *ni = NTFS_I(vi);
-	ntfs_volume *vol = ni->vol;
-
-	ntfs_debug("Entering for i_ino 0x%lx, attribute type 0x%x, pos "
-			"0x%llx, count 0x%zx.", vi->i_ino,
-			(unsigned)le32_to_cpu(ni->type),
-			(unsigned long long)iocb->ki_pos,
-			iov_iter_count(from));
-	err = generic_write_checks(iocb, from);
-	if (unlikely(err <= 0))
-		goto out;
-	/*
-	 * All checks have passed.  Before we start doing any writing we want
-	 * to abort any totally illegal writes.
-	 */
-	BUG_ON(NInoMstProtected(ni));
-	BUG_ON(ni->type != AT_DATA);
-	/* If file is encrypted, deny access, just like NT4. */
-	if (NInoEncrypted(ni)) {
-		/* Only $DATA attributes can be encrypted. */
-		/*
-		 * Reminder for later: Encrypted files are _always_
-		 * non-resident so that the content can always be encrypted.
-		 */
-		ntfs_debug("Denying write access to encrypted file.");
-		err = -EACCES;
-		goto out;
-	}
-	if (NInoCompressed(ni)) {
-		/* Only unnamed $DATA attribute can be compressed. */
-		BUG_ON(ni->name_len);
-		/*
-		 * Reminder for later: If resident, the data is not actually
-		 * compressed.  Only on the switch to non-resident does
-		 * compression kick in.  This is in contrast to encrypted files
-		 * (see above).
-		 */
-		ntfs_error(vi->i_sb, "Writing to compressed files is not "
-				"implemented yet.  Sorry.");
-		err = -EOPNOTSUPP;
-		goto out;
-	}
-	err = file_remove_privs(file);
-	if (unlikely(err))
-		goto out;
-	/*
-	 * Our ->update_time method always succeeds thus file_update_time()
-	 * cannot fail either so there is no need to check the return code.
-	 */
-	file_update_time(file);
-	pos = iocb->ki_pos;
-	/* The first byte after the last cluster being written to. */
-	end = (pos + iov_iter_count(from) + vol->cluster_size_mask) &
-			~(u64)vol->cluster_size_mask;
-	/*
-	 * If the write goes beyond the allocated size, extend the allocation
-	 * to cover the whole of the write, rounded up to the nearest cluster.
-	 */
-	read_lock_irqsave(&ni->size_lock, flags);
-	ll = ni->allocated_size;
-	read_unlock_irqrestore(&ni->size_lock, flags);
-	if (end > ll) {
-		/*
-		 * Extend the allocation without changing the data size.
-		 *
-		 * Note we ensure the allocation is big enough to at least
-		 * write some data but we do not require the allocation to be
-		 * complete, i.e. it may be partial.
-		 */
-		ll = ntfs_attr_extend_allocation(ni, end, -1, pos);
-		if (likely(ll >= 0)) {
-			BUG_ON(pos >= ll);
-			/* If the extension was partial truncate the write. */
-			if (end > ll) {
-				ntfs_debug("Truncating write to inode 0x%lx, "
-						"attribute type 0x%x, because "
-						"the allocation was only "
-						"partially extended.",
-						vi->i_ino, (unsigned)
-						le32_to_cpu(ni->type));
-				iov_iter_truncate(from, ll - pos);
-			}
-		} else {
-			err = ll;
-			read_lock_irqsave(&ni->size_lock, flags);
-			ll = ni->allocated_size;
-			read_unlock_irqrestore(&ni->size_lock, flags);
-			/* Perform a partial write if possible or fail. */
-			if (pos < ll) {
-				ntfs_debug("Truncating write to inode 0x%lx "
-						"attribute type 0x%x, because "
-						"extending the allocation "
-						"failed (error %d).",
-						vi->i_ino, (unsigned)
-						le32_to_cpu(ni->type),
-						(int)-err);
-				iov_iter_truncate(from, ll - pos);
-			} else {
-				if (err != -ENOSPC)
-					ntfs_error(vi->i_sb, "Cannot perform "
-							"write to inode "
-							"0x%lx, attribute "
-							"type 0x%x, because "
-							"extending the "
-							"allocation failed "
-							"(error %ld).",
-							vi->i_ino, (unsigned)
-							le32_to_cpu(ni->type),
-							(long)-err);
-				else
-					ntfs_debug("Cannot perform write to "
-							"inode 0x%lx, "
-							"attribute type 0x%x, "
-							"because there is not "
-							"space left.",
-							vi->i_ino, (unsigned)
-							le32_to_cpu(ni->type));
-				goto out;
+	if (NVolShutdown(vol))
+		return -EIO;
+
+	err = file_write_and_wait_range(filp, start, end);
+	if (err)
+		return err;
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
 			}
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
+			if (inode_state_read_once(attr_vi) & I_DIRTY_PAGES) {
+				spin_unlock(&attr_vi->i_lock);
+				filemap_write_and_wait(attr_vi->i_mapping);
+			} else
+				spin_unlock(&attr_vi->i_lock);
+			iput(attr_vi);
 		}
 	}
+	mutex_unlock(&ni->mrec_lock);
+	ntfs_attr_put_search_ctx(ctx);
+
+	write_inode_now(vol->mftbmp_ino, 1);
+	down_write(&vol->lcnbmp_lock);
+	write_inode_now(vol->lcnbmp_ino, 1);
+	up_write(&vol->lcnbmp_lock);
+	write_inode_now(vol->mft_ino, 1);
+
 	/*
-	 * If the write starts beyond the initialized size, extend it up to the
-	 * beginning of the write and initialize all non-sparse space between
-	 * the old initialized size and the new one.  This automatically also
-	 * increments the vfs inode->i_size to keep it above or equal to the
-	 * initialized_size.
+	 * NOTE: If we were to use mapping->private_list (see ext2 and
+	 * fs/buffer.c) for dirty blocks then we could optimize the below to be
+	 * sync_mapping_buffers(vi->i_mapping).
 	 */
-	read_lock_irqsave(&ni->size_lock, flags);
-	ll = ni->initialized_size;
-	read_unlock_irqrestore(&ni->size_lock, flags);
-	if (pos > ll) {
-		/*
-		 * Wait for ongoing direct i/o to complete before proceeding.
-		 * New direct i/o cannot start as we hold i_mutex.
-		 */
-		inode_dio_wait(vi);
-		err = ntfs_attr_extend_initialized(ni, pos);
-		if (unlikely(err < 0))
-			ntfs_error(vi->i_sb, "Cannot perform write to inode "
-					"0x%lx, attribute type 0x%x, because "
-					"extending the initialized size "
-					"failed (error %d).", vi->i_ino,
-					(unsigned)le32_to_cpu(ni->type),
-					(int)-err);
-	}
-out:
-	return err;
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
 }
 
 /**
- * __ntfs_grab_cache_pages - obtain a number of locked pages
- * @mapping:	address space mapping from which to obtain page cache pages
- * @index:	starting index in @mapping at which to begin obtaining pages
- * @nr_pages:	number of page cache pages to obtain
- * @pages:	array of pages in which to return the obtained page cache pages
- * @cached_page: allocated but as yet unused page
+ * ntfsp_setattr - called from notify_change() when an attribute is being changed
+ * @idmap:	idmap of the mount the inode was found from
+ * @dentry:	dentry whose attributes to change
+ * @attr:	structure describing the attributes and the changes
  *
- * Obtain @nr_pages locked page cache pages from the mapping @mapping and
- * starting at index @index.
+ * We have to trap VFS attempts to truncate the file described by @dentry as
+ * soon as possible, because we do not implement changes in i_size yet.  So we
+ * abort all i_size changes here.
  *
- * If a page is newly created, add it to lru list
- *
- * Note, the page locks are obtained in ascending page index order.
+ * We also abort all changes of user, group, and mode as we do not implement
+ * the NTFS ACLs yet.
  */
-static inline int __ntfs_grab_cache_pages(struct address_space *mapping,
-		pgoff_t index, const unsigned nr_pages, struct page **pages,
-		struct page **cached_page)
+int ntfsp_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
+		 struct iattr *attr)
 {
-	int err, nr;
-
-	BUG_ON(!nr_pages);
-	err = nr = 0;
-	do {
-		pages[nr] = find_get_page_flags(mapping, index, FGP_LOCK |
-				FGP_ACCESSED);
-		if (!pages[nr]) {
-			if (!*cached_page) {
-				*cached_page = page_cache_alloc(mapping);
-				if (unlikely(!*cached_page)) {
-					err = -ENOMEM;
-					goto err_out;
-				}
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
 			}
-			err = add_to_page_cache_lru(*cached_page, mapping,
-				   index,
-				   mapping_gfp_constraint(mapping, GFP_KERNEL));
-			if (unlikely(err)) {
-				if (err == -EEXIST)
-					continue;
-				goto err_out;
+
+			if (NInoNonResident(ni) && attr->ia_size > old_size &&
+				old_size % PAGE_SIZE != 0) {
+				loff_t len = min_t(loff_t,
+							round_up(old_size, PAGE_SIZE) - old_size,
+							attr->ia_size - old_size);
+				err = iomap_zero_range(vi, old_size, len,
+						       NULL, &ntfs_read_iomap_ops,
+						       &ntfs_iomap_folio_ops, NULL);
 			}
-			pages[nr] = *cached_page;
-			*cached_page = NULL;
 		}
-		index++;
-		nr++;
-	} while (nr < nr_pages);
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
 out:
 	return err;
-err_out:
-	while (nr > 0) {
-		unlock_page(pages[--nr]);
-		put_page(pages[nr]);
-	}
-	goto out;
 }
 
-static inline void ntfs_submit_bh_for_read(struct buffer_head *bh)
+int ntfsp_getattr(struct mnt_idmap *idmap, const struct path *path,
+		struct kstat *stat, unsigned int request_mask,
+		unsigned int query_flags)
 {
-	lock_buffer(bh);
-	get_bh(bh);
-	bh->b_end_io = end_buffer_read_sync;
-	submit_bh(REQ_OP_READ, bh);
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
 }
 
-/**
- * ntfs_prepare_pages_for_non_resident_write - prepare pages for receiving data
- * @pages:	array of destination pages
- * @nr_pages:	number of pages in @pages
- * @pos:	byte position in file at which the write begins
- * @bytes:	number of bytes to be written
- *
- * This is called for non-resident attributes from ntfs_file_buffered_write()
- * with i_mutex held on the inode (@pages[0]->mapping->host).  There are
- * @nr_pages pages in @pages which are locked but not kmap()ped.  The source
- * data has not yet been copied into the @pages.
- * 
- * Need to fill any holes with actual clusters, allocate buffers if necessary,
- * ensure all the buffers are mapped, and bring uptodate any buffers that are
- * only partially being written to.
- *
- * If @nr_pages is greater than one, we are guaranteed that the cluster size is
- * greater than PAGE_SIZE, that all pages in @pages are entirely inside
- * the same cluster and that they are the entirety of that cluster, and that
- * the cluster is sparse, i.e. we need to allocate a cluster to fill the hole.
- *
- * i_size is not to be modified yet.
- *
- * Return 0 on success or -errno on error.
- */
-static int ntfs_prepare_pages_for_non_resident_write(struct page **pages,
-		unsigned nr_pages, s64 pos, size_t bytes)
+static loff_t ntfs_file_llseek(struct file *file, loff_t offset, int whence)
 {
-	VCN vcn, highest_vcn = 0, cpos, cend, bh_cpos, bh_cend;
-	LCN lcn;
-	s64 bh_pos, vcn_len, end, initialized_size;
-	sector_t lcn_block;
-	struct folio *folio;
-	struct inode *vi;
-	ntfs_inode *ni, *base_ni = NULL;
-	ntfs_volume *vol;
-	runlist_element *rl, *rl2;
-	struct buffer_head *bh, *head, *wait[2], **wait_bh = wait;
-	ntfs_attr_search_ctx *ctx = NULL;
-	MFT_RECORD *m = NULL;
-	ATTR_RECORD *a = NULL;
-	unsigned long flags;
-	u32 attr_rec_len = 0;
-	unsigned blocksize, u;
-	int err, mp_size;
-	bool rl_write_locked, was_hole, is_retry;
-	unsigned char blocksize_bits;
-	struct {
-		u8 runlist_merged:1;
-		u8 mft_attr_mapped:1;
-		u8 mp_rebuilt:1;
-		u8 attr_switched:1;
-	} status = { 0, 0, 0, 0 };
-
-	BUG_ON(!nr_pages);
-	BUG_ON(!pages);
-	BUG_ON(!*pages);
-	vi = pages[0]->mapping->host;
-	ni = NTFS_I(vi);
-	vol = ni->vol;
-	ntfs_debug("Entering for inode 0x%lx, attribute type 0x%x, start page "
-			"index 0x%lx, nr_pages 0x%x, pos 0x%llx, bytes 0x%zx.",
-			vi->i_ino, ni->type, pages[0]->index, nr_pages,
-			(long long)pos, bytes);
-	blocksize = vol->sb->s_blocksize;
-	blocksize_bits = vol->sb->s_blocksize_bits;
-	rl_write_locked = false;
-	rl = NULL;
-	err = 0;
-	vcn = lcn = -1;
-	vcn_len = 0;
-	lcn_block = -1;
-	was_hole = false;
-	cpos = pos >> vol->cluster_size_bits;
-	end = pos + bytes;
-	cend = (end + vol->cluster_size - 1) >> vol->cluster_size_bits;
-	/*
-	 * Loop over each buffer in each folio.  Use goto to
-	 * reduce indentation.
-	 */
-	u = 0;
-do_next_folio:
-	folio = page_folio(pages[u]);
-	bh_pos = folio_pos(folio);
-	head = folio_buffers(folio);
-	if (!head)
-		/*
-		 * create_empty_buffers() will create uptodate/dirty
-		 * buffers if the folio is uptodate/dirty.
-		 */
-		head = create_empty_buffers(folio, blocksize, 0);
-	bh = head;
-	do {
-		VCN cdelta;
-		s64 bh_end;
-		unsigned bh_cofs;
-
-		/* Clear buffer_new on all buffers to reinitialise state. */
-		if (buffer_new(bh))
-			clear_buffer_new(bh);
-		bh_end = bh_pos + blocksize;
-		bh_cpos = bh_pos >> vol->cluster_size_bits;
-		bh_cofs = bh_pos & vol->cluster_size_mask;
-		if (buffer_mapped(bh)) {
-			/*
-			 * The buffer is already mapped.  If it is uptodate,
-			 * ignore it.
-			 */
-			if (buffer_uptodate(bh))
-				continue;
-			/*
-			 * The buffer is not uptodate.  If the folio is uptodate
-			 * set the buffer uptodate and otherwise ignore it.
-			 */
-			if (folio_test_uptodate(folio)) {
-				set_buffer_uptodate(bh);
-				continue;
-			}
-			/*
-			 * Neither the folio nor the buffer are uptodate.  If
-			 * the buffer is only partially being written to, we
-			 * need to read it in before the write, i.e. now.
-			 */
-			if ((bh_pos < pos && bh_end > pos) ||
-					(bh_pos < end && bh_end > end)) {
-				/*
-				 * If the buffer is fully or partially within
-				 * the initialized size, do an actual read.
-				 * Otherwise, simply zero the buffer.
-				 */
-				read_lock_irqsave(&ni->size_lock, flags);
-				initialized_size = ni->initialized_size;
-				read_unlock_irqrestore(&ni->size_lock, flags);
-				if (bh_pos < initialized_size) {
-					ntfs_submit_bh_for_read(bh);
-					*wait_bh++ = bh;
-				} else {
-					folio_zero_range(folio, bh_offset(bh),
-							blocksize);
-					set_buffer_uptodate(bh);
-				}
-			}
-			continue;
-		}
-		/* Unmapped buffer.  Need to map it. */
-		bh->b_bdev = vol->sb->s_bdev;
-		/*
-		 * If the current buffer is in the same clusters as the map
-		 * cache, there is no need to check the runlist again.  The
-		 * map cache is made up of @vcn, which is the first cached file
-		 * cluster, @vcn_len which is the number of cached file
-		 * clusters, @lcn is the device cluster corresponding to @vcn,
-		 * and @lcn_block is the block number corresponding to @lcn.
-		 */
-		cdelta = bh_cpos - vcn;
-		if (likely(!cdelta || (cdelta > 0 && cdelta < vcn_len))) {
-map_buffer_cached:
-			BUG_ON(lcn < 0);
-			bh->b_blocknr = lcn_block +
-					(cdelta << (vol->cluster_size_bits -
-					blocksize_bits)) +
-					(bh_cofs >> blocksize_bits);
-			set_buffer_mapped(bh);
-			/*
-			 * If the folio is uptodate so is the buffer.  If the
-			 * buffer is fully outside the write, we ignore it if
-			 * it was already allocated and we mark it dirty so it
-			 * gets written out if we allocated it.  On the other
-			 * hand, if we allocated the buffer but we are not
-			 * marking it dirty we set buffer_new so we can do
-			 * error recovery.
-			 */
-			if (folio_test_uptodate(folio)) {
-				if (!buffer_uptodate(bh))
-					set_buffer_uptodate(bh);
-				if (unlikely(was_hole)) {
-					/* We allocated the buffer. */
-					clean_bdev_bh_alias(bh);
-					if (bh_end <= pos || bh_pos >= end)
-						mark_buffer_dirty(bh);
-					else
-						set_buffer_new(bh);
-				}
-				continue;
-			}
-			/* Page is _not_ uptodate. */
-			if (likely(!was_hole)) {
-				/*
-				 * Buffer was already allocated.  If it is not
-				 * uptodate and is only partially being written
-				 * to, we need to read it in before the write,
-				 * i.e. now.
-				 */
-				if (!buffer_uptodate(bh) && bh_pos < end &&
-						bh_end > pos &&
-						(bh_pos < pos ||
-						bh_end > end)) {
-					/*
-					 * If the buffer is fully or partially
-					 * within the initialized size, do an
-					 * actual read.  Otherwise, simply zero
-					 * the buffer.
-					 */
-					read_lock_irqsave(&ni->size_lock,
-							flags);
-					initialized_size = ni->initialized_size;
-					read_unlock_irqrestore(&ni->size_lock,
-							flags);
-					if (bh_pos < initialized_size) {
-						ntfs_submit_bh_for_read(bh);
-						*wait_bh++ = bh;
-					} else {
-						folio_zero_range(folio,
-								bh_offset(bh),
-								blocksize);
-						set_buffer_uptodate(bh);
-					}
-				}
-				continue;
-			}
-			/* We allocated the buffer. */
-			clean_bdev_bh_alias(bh);
-			/*
-			 * If the buffer is fully outside the write, zero it,
-			 * set it uptodate, and mark it dirty so it gets
-			 * written out.  If it is partially being written to,
-			 * zero region surrounding the write but leave it to
-			 * commit write to do anything else.  Finally, if the
-			 * buffer is fully being overwritten, do nothing.
-			 */
-			if (bh_end <= pos || bh_pos >= end) {
-				if (!buffer_uptodate(bh)) {
-					folio_zero_range(folio, bh_offset(bh),
-							blocksize);
-					set_buffer_uptodate(bh);
-				}
-				mark_buffer_dirty(bh);
-				continue;
-			}
-			set_buffer_new(bh);
-			if (!buffer_uptodate(bh) &&
-					(bh_pos < pos || bh_end > end)) {
-				u8 *kaddr;
-				unsigned pofs;
-					
-				kaddr = kmap_local_folio(folio, 0);
-				if (bh_pos < pos) {
-					pofs = bh_pos & ~PAGE_MASK;
-					memset(kaddr + pofs, 0, pos - bh_pos);
-				}
-				if (bh_end > end) {
-					pofs = end & ~PAGE_MASK;
-					memset(kaddr + pofs, 0, bh_end - end);
-				}
-				kunmap_local(kaddr);
-				flush_dcache_folio(folio);
-			}
-			continue;
-		}
-		/*
-		 * Slow path: this is the first buffer in the cluster.  If it
-		 * is outside allocated size and is not uptodate, zero it and
-		 * set it uptodate.
-		 */
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
 		read_lock_irqsave(&ni->size_lock, flags);
-		initialized_size = ni->allocated_size;
+		end_off = ni->data_size;
 		read_unlock_irqrestore(&ni->size_lock, flags);
-		if (bh_pos > initialized_size) {
-			if (folio_test_uptodate(folio)) {
-				if (!buffer_uptodate(bh))
-					set_buffer_uptodate(bh);
-			} else if (!buffer_uptodate(bh)) {
-				folio_zero_range(folio, bh_offset(bh),
-						blocksize);
-				set_buffer_uptodate(bh);
-			}
-			continue;
-		}
-		is_retry = false;
-		if (!rl) {
-			down_read(&ni->runlist.lock);
-retry_remap:
-			rl = ni->runlist.rl;
+
+		if (offset < 0 || offset >= end_off)
+			goto error;
+
+		if (!NInoNonResident(ni)) {
+			if (whence == SEEK_HOLE)
+				offset = end_off;
+			goto found_no_runlist_lock;
 		}
-		if (likely(rl != NULL)) {
-			/* Seek to element containing target cluster. */
-			while (rl->length && rl[1].vcn <= bh_cpos)
-				rl++;
-			lcn = ntfs_rl_vcn_to_lcn(rl, bh_cpos);
-			if (likely(lcn >= 0)) {
-				/*
-				 * Successful remap, setup the map cache and
-				 * use that to deal with the buffer.
-				 */
-				was_hole = false;
-				vcn = bh_cpos;
-				vcn_len = rl[1].vcn - vcn;
-				lcn_block = lcn << (vol->cluster_size_bits -
-						blocksize_bits);
-				cdelta = 0;
-				/*
-				 * If the number of remaining clusters touched
-				 * by the write is smaller or equal to the
-				 * number of cached clusters, unlock the
-				 * runlist as the map cache will be used from
-				 * now on.
-				 */
-				if (likely(vcn + vcn_len >= cend)) {
-					if (rl_write_locked) {
-						up_write(&ni->runlist.lock);
-						rl_write_locked = false;
-					} else
-						up_read(&ni->runlist.lock);
-					rl = NULL;
-				}
-				goto map_buffer_cached;
-			}
-		} else
-			lcn = LCN_RL_NOT_MAPPED;
-		/*
-		 * If it is not a hole and not out of bounds, the runlist is
-		 * probably unmapped so try to map it now.
-		 */
-		if (unlikely(lcn != LCN_HOLE && lcn != LCN_ENOENT)) {
-			if (likely(!is_retry && lcn == LCN_RL_NOT_MAPPED)) {
-				/* Attempt to map runlist. */
-				if (!rl_write_locked) {
-					/*
-					 * We need the runlist locked for
-					 * writing, so if it is locked for
-					 * reading relock it now and retry in
-					 * case it changed whilst we dropped
-					 * the lock.
-					 */
+
+		vcn = NTFS_B_TO_CLU(vol, offset);
+		vcn_off = NTFS_B_TO_CLU_OFS(vol, offset);
+
+		down_read(&ni->runlist.lock);
+		rl = ni->runlist.rl;
+		i = 0;
+
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
 					up_read(&ni->runlist.lock);
-					down_write(&ni->runlist.lock);
-					rl_write_locked = true;
-					goto retry_remap;
-				}
-				err = ntfs_map_runlist_nolock(ni, bh_cpos,
-						NULL);
-				if (likely(!err)) {
-					is_retry = true;
-					goto retry_remap;
-				}
-				/*
-				 * If @vcn is out of bounds, pretend @lcn is
-				 * LCN_ENOENT.  As long as the buffer is out
-				 * of bounds this will work fine.
-				 */
-				if (err == -ENOENT) {
-					lcn = LCN_ENOENT;
-					err = 0;
-					goto rl_not_mapped_enoent;
-				}
-			} else
-				err = -EIO;
-			/* Failed to map the buffer, even after retrying. */
-			bh->b_blocknr = -1;
-			ntfs_error(vol->sb, "Failed to write to inode 0x%lx, "
-					"attribute type 0x%x, vcn 0x%llx, "
-					"vcn offset 0x%x, because its "
-					"location on disk could not be "
-					"determined%s (error code %i).",
-					ni->mft_no, ni->type,
-					(unsigned long long)bh_cpos,
-					(unsigned)bh_pos &
-					vol->cluster_size_mask,
-					is_retry ? " even after retrying" : "",
-					err);
-			break;
-		}
-rl_not_mapped_enoent:
-		/*
-		 * The buffer is in a hole or out of bounds.  We need to fill
-		 * the hole, unless the buffer is in a cluster which is not
-		 * touched by the write, in which case we just leave the buffer
-		 * unmapped.  This can only happen when the cluster size is
-		 * less than the page cache size.
-		 */
-		if (unlikely(vol->cluster_size < PAGE_SIZE)) {
-			bh_cend = (bh_end + vol->cluster_size - 1) >>
-					vol->cluster_size_bits;
-			if ((bh_cend <= cpos || bh_cpos >= cend)) {
-				bh->b_blocknr = -1;
-				/*
-				 * If the buffer is uptodate we skip it.  If it
-				 * is not but the folio is uptodate, we can set
-				 * the buffer uptodate.  If the folio is not
-				 * uptodate, we can clear the buffer and set it
-				 * uptodate.  Whether this is worthwhile is
-				 * debatable and this could be removed.
-				 */
-				if (folio_test_uptodate(folio)) {
-					if (!buffer_uptodate(bh))
-						set_buffer_uptodate(bh);
-				} else if (!buffer_uptodate(bh)) {
-					folio_zero_range(folio, bh_offset(bh),
-						blocksize);
-					set_buffer_uptodate(bh);
+					goto error;
+				} else {
+					offset = end_off;
+					goto found;
 				}
-				continue;
-			}
-		}
-		/*
-		 * Out of bounds buffer is invalid if it was not really out of
-		 * bounds.
-		 */
-		BUG_ON(lcn != LCN_HOLE);
-		/*
-		 * We need the runlist locked for writing, so if it is locked
-		 * for reading relock it now and retry in case it changed
-		 * whilst we dropped the lock.
-		 */
-		BUG_ON(!rl);
-		if (!rl_write_locked) {
-			up_read(&ni->runlist.lock);
-			down_write(&ni->runlist.lock);
-			rl_write_locked = true;
-			goto retry_remap;
-		}
-		/* Find the previous last allocated cluster. */
-		BUG_ON(rl->lcn != LCN_HOLE);
-		lcn = -1;
-		rl2 = rl;
-		while (--rl2 >= ni->runlist.rl) {
-			if (rl2->lcn >= 0) {
-				lcn = rl2->lcn + rl2->length;
-				break;
-			}
-		}
-		rl2 = ntfs_cluster_alloc(vol, bh_cpos, 1, lcn, DATA_ZONE,
-				false);
-		if (IS_ERR(rl2)) {
-			err = PTR_ERR(rl2);
-			ntfs_debug("Failed to allocate cluster, error code %i.",
-					err);
-			break;
-		}
-		lcn = rl2->lcn;
-		rl = ntfs_runlists_merge(ni->runlist.rl, rl2);
-		if (IS_ERR(rl)) {
-			err = PTR_ERR(rl);
-			if (err != -ENOMEM)
-				err = -EIO;
-			if (ntfs_cluster_free_from_rl(vol, rl2)) {
-				ntfs_error(vol->sb, "Failed to release "
-						"allocated cluster in error "
-						"code path.  Run chkdsk to "
-						"recover the lost cluster.");
-				NVolSetErrors(vol);
-			}
-			ntfs_free(rl2);
-			break;
-		}
-		ni->runlist.rl = rl;
-		status.runlist_merged = 1;
-		ntfs_debug("Allocated cluster, lcn 0x%llx.",
-				(unsigned long long)lcn);
-		/* Map and lock the mft record and get the attribute record. */
-		if (!NInoAttr(ni))
-			base_ni = ni;
-		else
-			base_ni = ni->ext.base_ntfs_ino;
-		m = map_mft_record(base_ni);
-		if (IS_ERR(m)) {
-			err = PTR_ERR(m);
-			break;
-		}
-		ctx = ntfs_attr_get_search_ctx(base_ni, m);
-		if (unlikely(!ctx)) {
-			err = -ENOMEM;
-			unmap_mft_record(base_ni);
-			break;
-		}
-		status.mft_attr_mapped = 1;
-		err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
-				CASE_SENSITIVE, bh_cpos, NULL, 0, ctx);
-		if (unlikely(err)) {
-			if (err == -ENOENT)
-				err = -EIO;
-			break;
-		}
-		m = ctx->mrec;
-		a = ctx->attr;
-		/*
-		 * Find the runlist element with which the attribute extent
-		 * starts.  Note, we cannot use the _attr_ version because we
-		 * have mapped the mft record.  That is ok because we know the
-		 * runlist fragment must be mapped already to have ever gotten
-		 * here, so we can just use the _rl_ version.
-		 */
-		vcn = sle64_to_cpu(a->data.non_resident.lowest_vcn);
-		rl2 = ntfs_rl_find_vcn_nolock(rl, vcn);
-		BUG_ON(!rl2);
-		BUG_ON(!rl2->length);
-		BUG_ON(rl2->lcn < LCN_HOLE);
-		highest_vcn = sle64_to_cpu(a->data.non_resident.highest_vcn);
-		/*
-		 * If @highest_vcn is zero, calculate the real highest_vcn
-		 * (which can really be zero).
-		 */
-		if (!highest_vcn)
-			highest_vcn = (sle64_to_cpu(
-					a->data.non_resident.allocated_size) >>
-					vol->cluster_size_bits) - 1;
-		/*
-		 * Determine the size of the mapping pairs array for the new
-		 * extent, i.e. the old extent with the hole filled.
-		 */
-		mp_size = ntfs_get_size_for_mapping_pairs(vol, rl2, vcn,
-				highest_vcn);
-		if (unlikely(mp_size <= 0)) {
-			if (!(err = mp_size))
-				err = -EIO;
-			ntfs_debug("Failed to get size for mapping pairs "
-					"array, error code %i.", err);
-			break;
-		}
-		/*
-		 * Resize the attribute record to fit the new mapping pairs
-		 * array.
-		 */
-		attr_rec_len = le32_to_cpu(a->length);
-		err = ntfs_attr_record_resize(m, a, mp_size + le16_to_cpu(
-				a->data.non_resident.mapping_pairs_offset));
-		if (unlikely(err)) {
-			BUG_ON(err != -ENOSPC);
-			// TODO: Deal with this by using the current attribute
-			// and fill it with as much of the mapping pairs
-			// array as possible.  Then loop over each attribute
-			// extent rewriting the mapping pairs arrays as we go
-			// along and if when we reach the end we have not
-			// enough space, try to resize the last attribute
-			// extent and if even that fails, add a new attribute
-			// extent.
-			// We could also try to resize at each step in the hope
-			// that we will not need to rewrite every single extent.
-			// Note, we may need to decompress some extents to fill
-			// the runlist as we are walking the extents...
-			ntfs_error(vol->sb, "Not enough space in the mft "
-					"record for the extended attribute "
-					"record.  This case is not "
-					"implemented yet.");
-			err = -EOPNOTSUPP;
-			break ;
-		}
-		status.mp_rebuilt = 1;
-		/*
-		 * Generate the mapping pairs array directly into the attribute
-		 * record.
-		 */
-		err = ntfs_mapping_pairs_build(vol, (u8*)a + le16_to_cpu(
-				a->data.non_resident.mapping_pairs_offset),
-				mp_size, rl2, vcn, highest_vcn, NULL);
-		if (unlikely(err)) {
-			ntfs_error(vol->sb, "Cannot fill hole in inode 0x%lx, "
-					"attribute type 0x%x, because building "
-					"the mapping pairs failed with error "
-					"code %i.", vi->i_ino,
-					(unsigned)le32_to_cpu(ni->type), err);
-			err = -EIO;
-			break;
-		}
-		/* Update the highest_vcn but only if it was not set. */
-		if (unlikely(!a->data.non_resident.highest_vcn))
-			a->data.non_resident.highest_vcn =
-					cpu_to_sle64(highest_vcn);
-		/*
-		 * If the attribute is sparse/compressed, update the compressed
-		 * size in the ntfs_inode structure and the attribute record.
-		 */
-		if (likely(NInoSparse(ni) || NInoCompressed(ni))) {
-			/*
-			 * If we are not in the first attribute extent, switch
-			 * to it, but first ensure the changes will make it to
-			 * disk later.
-			 */
-			if (a->data.non_resident.lowest_vcn) {
-				flush_dcache_mft_record_page(ctx->ntfs_ino);
-				mark_mft_record_dirty(ctx->ntfs_ino);
-				ntfs_attr_reinit_search_ctx(ctx);
-				err = ntfs_attr_lookup(ni->type, ni->name,
-						ni->name_len, CASE_SENSITIVE,
-						0, NULL, 0, ctx);
-				if (unlikely(err)) {
-					status.attr_switched = 1;
-					break;
+			} else if (rl[i + 1].vcn > vcn) {
+				if ((whence == SEEK_DATA && (rl[i].lcn >= 0 ||
+						rl[i].lcn == LCN_DELALLOC)) ||
+				   (whence == SEEK_HOLE && rl[i].lcn == LCN_HOLE)) {
+					offset = NTFS_CLU_TO_B(vol, vcn) + vcn_off;
+					if (offset < ni->data_size)
+						goto found;
 				}
-				/* @m is not used any more so do not set it. */
-				a = ctx->attr;
+				vcn = rl[i + 1].vcn;
+				vcn_off = 0;
 			}
-			write_lock_irqsave(&ni->size_lock, flags);
-			ni->itype.compressed.size += vol->cluster_size;
-			a->data.non_resident.compressed_size =
-					cpu_to_sle64(ni->itype.compressed.size);
-			write_unlock_irqrestore(&ni->size_lock, flags);
+			i++;
 		}
-		/* Ensure the changes make it to disk. */
-		flush_dcache_mft_record_page(ctx->ntfs_ino);
-		mark_mft_record_dirty(ctx->ntfs_ino);
-		ntfs_attr_put_search_ctx(ctx);
-		unmap_mft_record(base_ni);
-		/* Successfully filled the hole. */
-		status.runlist_merged = 0;
-		status.mft_attr_mapped = 0;
-		status.mp_rebuilt = 0;
-		/* Setup the map cache and use that to deal with the buffer. */
-		was_hole = true;
-		vcn = bh_cpos;
-		vcn_len = 1;
-		lcn_block = lcn << (vol->cluster_size_bits - blocksize_bits);
-		cdelta = 0;
-		/*
-		 * If the number of remaining clusters in the @pages is smaller
-		 * or equal to the number of cached clusters, unlock the
-		 * runlist as the map cache will be used from now on.
-		 */
-		if (likely(vcn + vcn_len >= cend)) {
-			up_write(&ni->runlist.lock);
-			rl_write_locked = false;
-			rl = NULL;
-		}
-		goto map_buffer_cached;
-	} while (bh_pos += blocksize, (bh = bh->b_this_page) != head);
-	/* If there are no errors, do the next page. */
-	if (likely(!err && ++u < nr_pages))
-		goto do_next_folio;
-	/* If there are no errors, release the runlist lock if we took it. */
-	if (likely(!err)) {
-		if (unlikely(rl_write_locked)) {
-			up_write(&ni->runlist.lock);
-			rl_write_locked = false;
-		} else if (unlikely(rl))
-			up_read(&ni->runlist.lock);
-		rl = NULL;
-	}
-	/* If we issued read requests, let them complete. */
-	read_lock_irqsave(&ni->size_lock, flags);
-	initialized_size = ni->initialized_size;
-	read_unlock_irqrestore(&ni->size_lock, flags);
-	while (wait_bh > wait) {
-		bh = *--wait_bh;
-		wait_on_buffer(bh);
-		if (likely(buffer_uptodate(bh))) {
-			folio = bh->b_folio;
-			bh_pos = folio_pos(folio) + bh_offset(bh);
-			/*
-			 * If the buffer overflows the initialized size, need
-			 * to zero the overflowing region.
-			 */
-			if (unlikely(bh_pos + blocksize > initialized_size)) {
-				int ofs = 0;
-
-				if (likely(bh_pos < initialized_size))
-					ofs = initialized_size - bh_pos;
-				folio_zero_segment(folio, bh_offset(bh) + ofs,
-						blocksize);
-			}
-		} else /* if (unlikely(!buffer_uptodate(bh))) */
-			err = -EIO;
-	}
-	if (likely(!err)) {
-		/* Clear buffer_new on all buffers. */
-		u = 0;
-		do {
-			bh = head = page_buffers(pages[u]);
-			do {
-				if (buffer_new(bh))
-					clear_buffer_new(bh);
-			} while ((bh = bh->b_this_page) != head);
-		} while (++u < nr_pages);
-		ntfs_debug("Done.");
-		return err;
+		up_read(&ni->runlist.lock);
+		inode_unlock_shared(vi);
+		return -EIO;
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
 	}
-	if (status.attr_switched) {
-		/* Get back to the attribute extent we modified. */
-		ntfs_attr_reinit_search_ctx(ctx);
-		if (ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
-				CASE_SENSITIVE, bh_cpos, NULL, 0, ctx)) {
-			ntfs_error(vol->sb, "Failed to find required "
-					"attribute extent of attribute in "
-					"error code path.  Run chkdsk to "
-					"recover.");
-			write_lock_irqsave(&ni->size_lock, flags);
-			ni->itype.compressed.size += vol->cluster_size;
-			write_unlock_irqrestore(&ni->size_lock, flags);
-			flush_dcache_mft_record_page(ctx->ntfs_ino);
-			mark_mft_record_dirty(ctx->ntfs_ino);
-			/*
-			 * The only thing that is now wrong is the compressed
-			 * size of the base attribute extent which chkdsk
-			 * should be able to fix.
-			 */
-			NVolSetErrors(vol);
-		} else {
-			m = ctx->mrec;
-			a = ctx->attr;
-			status.attr_switched = 0;
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
 		}
+
+		file_accessed(iocb->ki_filp);
+		ret = iomap_dio_rw(iocb, to, &ntfs_read_iomap_ops, NULL, IOMAP_DIO_PARTIAL,
+				NULL, 0);
+	} else {
+		ret = generic_file_read_iter(iocb, to);
 	}
-	/*
-	 * If the runlist has been modified, need to restore it by punching a
-	 * hole into it and we then need to deallocate the on-disk cluster as
-	 * well.  Note, we only modify the runlist if we are able to generate a
-	 * new mapping pairs array, i.e. only when the mapped attribute extent
-	 * is not switched.
-	 */
-	if (status.runlist_merged && !status.attr_switched) {
-		BUG_ON(!rl_write_locked);
-		/* Make the file cluster we allocated sparse in the runlist. */
-		if (ntfs_rl_punch_nolock(vol, &ni->runlist, bh_cpos, 1)) {
-			ntfs_error(vol->sb, "Failed to punch hole into "
-					"attribute runlist in error code "
-					"path.  Run chkdsk to recover the "
-					"lost cluster.");
-			NVolSetErrors(vol);
-		} else /* if (success) */ {
-			status.runlist_merged = 0;
-			/*
-			 * Deallocate the on-disk cluster we allocated but only
-			 * if we succeeded in punching its vcn out of the
-			 * runlist.
-			 */
-			down_write(&vol->lcnbmp_lock);
-			if (ntfs_bitmap_clear_bit(vol->lcnbmp_ino, lcn)) {
-				ntfs_error(vol->sb, "Failed to release "
-						"allocated cluster in error "
-						"code path.  Run chkdsk to "
-						"recover the lost cluster.");
-				NVolSetErrors(vol);
-			}
-			up_write(&vol->lcnbmp_lock);
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
 		}
 	}
-	/*
-	 * Resize the attribute record to its old size and rebuild the mapping
-	 * pairs array.  Note, we only can do this if the runlist has been
-	 * restored to its old state which also implies that the mapped
-	 * attribute extent is not switched.
-	 */
-	if (status.mp_rebuilt && !status.runlist_merged) {
-		if (ntfs_attr_record_resize(m, a, attr_rec_len)) {
-			ntfs_error(vol->sb, "Failed to restore attribute "
-					"record in error code path.  Run "
-					"chkdsk to recover.");
-			NVolSetErrors(vol);
-		} else /* if (success) */ {
-			if (ntfs_mapping_pairs_build(vol, (u8*)a +
-					le16_to_cpu(a->data.non_resident.
-					mapping_pairs_offset), attr_rec_len -
-					le16_to_cpu(a->data.non_resident.
-					mapping_pairs_offset), ni->runlist.rl,
-					vcn, highest_vcn, NULL)) {
-				ntfs_error(vol->sb, "Failed to restore "
-						"mapping pairs array in error "
-						"code path.  Run chkdsk to "
-						"recover.");
-				NVolSetErrors(vol);
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
 			}
-			flush_dcache_mft_record_page(ctx->ntfs_ino);
-			mark_mft_record_dirty(ctx->ntfs_ino);
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
 		}
+	} else {
+		ret = iomap_file_buffered_write(iocb, from, &ntfs_write_iomap_ops,
+				&ntfs_iomap_folio_ops, NULL);
 	}
-	/* Release the mft record and the attribute. */
-	if (status.mft_attr_mapped) {
-		ntfs_attr_put_search_ctx(ctx);
-		unmap_mft_record(base_ni);
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
 	}
-	/* Release the runlist lock. */
-	if (rl_write_locked)
-		up_write(&ni->runlist.lock);
-	else if (rl)
-		up_read(&ni->runlist.lock);
-	/*
-	 * Zero out any newly allocated blocks to avoid exposing stale data.
-	 * If BH_New is set, we know that the block was newly allocated above
-	 * and that it has not been fully zeroed and marked dirty yet.
-	 */
-	nr_pages = u;
-	u = 0;
-	end = bh_cpos << vol->cluster_size_bits;
-	do {
-		folio = page_folio(pages[u]);
-		bh = head = folio_buffers(folio);
-		do {
-			if (u == nr_pages &&
-			    folio_pos(folio) + bh_offset(bh) >= end)
-				break;
-			if (!buffer_new(bh))
-				continue;
-			clear_buffer_new(bh);
-			if (!buffer_uptodate(bh)) {
-				if (folio_test_uptodate(folio))
-					set_buffer_uptodate(bh);
-				else {
-					folio_zero_range(folio, bh_offset(bh),
-							blocksize);
-					set_buffer_uptodate(bh);
-				}
-			}
-			mark_buffer_dirty(bh);
-		} while ((bh = bh->b_this_page) != head);
-	} while (++u <= nr_pages);
-	ntfs_error(vol->sb, "Failed.  Returning error code %i.", err);
-	return err;
+out_lock:
+	inode_unlock(vi);
+	if (ret > 0)
+		ret = generic_write_sync(iocb, ret);
+	return ret;
 }
 
-static inline void ntfs_flush_dcache_pages(struct page **pages,
-		unsigned nr_pages)
+static vm_fault_t ntfs_filemap_page_mkwrite(struct vm_fault *vmf)
 {
-	BUG_ON(!nr_pages);
-	/*
-	 * Warning: Do not do the decrement at the same time as the call to
-	 * flush_dcache_page() because it is a NULL macro on i386 and hence the
-	 * decrement never happens so the loop never terminates.
-	 */
-	do {
-		--nr_pages;
-		flush_dcache_page(pages[nr_pages]);
-	} while (nr_pages > 0);
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
 }
 
-/**
- * ntfs_commit_pages_after_non_resident_write - commit the received data
- * @pages:	array of destination pages
- * @nr_pages:	number of pages in @pages
- * @pos:	byte position in file at which the write begins
- * @bytes:	number of bytes to be written
- *
- * See description of ntfs_commit_pages_after_write(), below.
- */
-static inline int ntfs_commit_pages_after_non_resident_write(
-		struct page **pages, const unsigned nr_pages,
-		s64 pos, size_t bytes)
+static const struct vm_operations_struct ntfs_file_vm_ops = {
+	.fault		= filemap_fault,
+	.map_pages	= filemap_map_pages,
+	.page_mkwrite	= ntfs_filemap_page_mkwrite,
+};
+
+static int ntfs_file_mmap_prepare(struct vm_area_desc *desc)
 {
-	s64 end, initialized_size;
-	struct inode *vi;
-	ntfs_inode *ni, *base_ni;
-	struct buffer_head *bh, *head;
-	ntfs_attr_search_ctx *ctx;
-	MFT_RECORD *m;
-	ATTR_RECORD *a;
-	unsigned long flags;
-	unsigned blocksize, u;
-	int err;
+	struct file *file = desc->file;
+	struct inode *inode = file_inode(file);
 
-	vi = pages[0]->mapping->host;
-	ni = NTFS_I(vi);
-	blocksize = vi->i_sb->s_blocksize;
-	end = pos + bytes;
-	u = 0;
-	do {
-		s64 bh_pos;
-		struct page *page;
-		bool partial;
-
-		page = pages[u];
-		bh_pos = (s64)page->index << PAGE_SHIFT;
-		bh = head = page_buffers(page);
-		partial = false;
-		do {
-			s64 bh_end;
-
-			bh_end = bh_pos + blocksize;
-			if (bh_end <= pos || bh_pos >= end) {
-				if (!buffer_uptodate(bh))
-					partial = true;
-			} else {
-				set_buffer_uptodate(bh);
-				mark_buffer_dirty(bh);
-			}
-		} while (bh_pos += blocksize, (bh = bh->b_this_page) != head);
-		/*
-		 * If all buffers are now uptodate but the page is not, set the
-		 * page uptodate.
-		 */
-		if (!partial && !PageUptodate(page))
-			SetPageUptodate(page);
-	} while (++u < nr_pages);
-	/*
-	 * Finally, if we do not need to update initialized_size or i_size we
-	 * are finished.
-	 */
-	read_lock_irqsave(&ni->size_lock, flags);
-	initialized_size = ni->initialized_size;
-	read_unlock_irqrestore(&ni->size_lock, flags);
-	if (end <= initialized_size) {
-		ntfs_debug("Done.");
-		return 0;
-	}
-	/*
-	 * Update initialized_size/i_size as appropriate, both in the inode and
-	 * the mft record.
-	 */
-	if (!NInoAttr(ni))
-		base_ni = ni;
-	else
-		base_ni = ni->ext.base_ntfs_ino;
-	/* Map, pin, and lock the mft record. */
-	m = map_mft_record(base_ni);
-	if (IS_ERR(m)) {
-		err = PTR_ERR(m);
-		m = NULL;
-		ctx = NULL;
-		goto err_out;
-	}
-	BUG_ON(!NInoNonResident(ni));
-	ctx = ntfs_attr_get_search_ctx(base_ni, m);
-	if (unlikely(!ctx)) {
-		err = -ENOMEM;
-		goto err_out;
-	}
-	err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
-			CASE_SENSITIVE, 0, NULL, 0, ctx);
-	if (unlikely(err)) {
-		if (err == -ENOENT)
-			err = -EIO;
-		goto err_out;
-	}
-	a = ctx->attr;
-	BUG_ON(!a->non_resident);
-	write_lock_irqsave(&ni->size_lock, flags);
-	BUG_ON(end > ni->allocated_size);
-	ni->initialized_size = end;
-	a->data.non_resident.initialized_size = cpu_to_sle64(end);
-	if (end > i_size_read(vi)) {
-		i_size_write(vi, end);
-		a->data.non_resident.data_size =
-				a->data.non_resident.initialized_size;
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
 	}
-	write_unlock_irqrestore(&ni->size_lock, flags);
-	/* Mark the mft record dirty, so it gets written back. */
-	flush_dcache_mft_record_page(ctx->ntfs_ino);
-	mark_mft_record_dirty(ctx->ntfs_ino);
-	ntfs_attr_put_search_ctx(ctx);
-	unmap_mft_record(base_ni);
-	ntfs_debug("Done.");
+
+
+	file_accessed(file);
+	desc->vm_ops = &ntfs_file_vm_ops;
 	return 0;
-err_out:
-	if (ctx)
-		ntfs_attr_put_search_ctx(ctx);
-	if (m)
-		unmap_mft_record(base_ni);
-	ntfs_error(vi->i_sb, "Failed to update initialized_size/i_size (error "
-			"code %i).", err);
-	if (err != -ENOMEM)
-		NVolSetErrors(ni->vol);
-	return err;
 }
 
-/**
- * ntfs_commit_pages_after_write - commit the received data
- * @pages:	array of destination pages
- * @nr_pages:	number of pages in @pages
- * @pos:	byte position in file at which the write begins
- * @bytes:	number of bytes to be written
- *
- * This is called from ntfs_file_buffered_write() with i_mutex held on the inode
- * (@pages[0]->mapping->host).  There are @nr_pages pages in @pages which are
- * locked but not kmap()ped.  The source data has already been copied into the
- * @page.  ntfs_prepare_pages_for_non_resident_write() has been called before
- * the data was copied (for non-resident attributes only) and it returned
- * success.
- *
- * Need to set uptodate and mark dirty all buffers within the boundary of the
- * write.  If all buffers in a page are uptodate we set the page uptodate, too.
- *
- * Setting the buffers dirty ensures that they get written out later when
- * ntfs_writepage() is invoked by the VM.
- *
- * Finally, we need to update i_size and initialized_size as appropriate both
- * in the inode and the mft record.
- *
- * This is modelled after fs/buffer.c::generic_commit_write(), which marks
- * buffers uptodate and dirty, sets the page uptodate if all buffers in the
- * page are uptodate, and updates i_size if the end of io is beyond i_size.  In
- * that case, it also marks the inode dirty.
- *
- * If things have gone as outlined in
- * ntfs_prepare_pages_for_non_resident_write(), we do not need to do any page
- * content modifications here for non-resident attributes.  For resident
- * attributes we need to do the uptodate bringing here which we combine with
- * the copying into the mft record which means we save one atomic kmap.
- *
- * Return 0 on success or -errno on error.
- */
-static int ntfs_commit_pages_after_write(struct page **pages,
-		const unsigned nr_pages, s64 pos, size_t bytes)
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
 {
-	s64 end, initialized_size;
-	loff_t i_size;
-	struct inode *vi;
-	ntfs_inode *ni, *base_ni;
-	struct page *page;
-	ntfs_attr_search_ctx *ctx;
-	MFT_RECORD *m;
-	ATTR_RECORD *a;
-	char *kattr, *kaddr;
-	unsigned long flags;
-	u32 attr_len;
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
+static int ntfs_ioctl_get_volume_label(struct file *filp, unsigned long arg)
+{
+	struct ntfs_volume *vol = NTFS_SB(file_inode(filp)->i_sb);
+	char __user *buf = (char __user *)arg;
+
+	if (!vol->volume_label) {
+		if (copy_to_user(buf, "", 1))
+			return -EFAULT;
+	} else if (copy_to_user(buf, vol->volume_label,
+				MIN(FSLABEL_MAX, strlen(vol->volume_label) + 1)))
+		return -EFAULT;
+	return 0;
+}
+
+static int ntfs_ioctl_set_volume_label(struct file *filp, unsigned long arg)
+{
+	struct ntfs_volume *vol = NTFS_SB(file_inode(filp)->i_sb);
+	char *label;
+	int ret;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	label = strndup_user((const char __user *)arg, FSLABEL_MAX);
+	if (IS_ERR(label))
+		return PTR_ERR(label);
+
+	ret = mnt_want_write_file(filp);
+	if (ret)
+		goto out;
+
+	ret = ntfs_write_volume_label(vol, label);
+	mnt_drop_write_file(filp);
+out:
+	kfree(label);
+	return ret;
+}
+
+static int ntfs_ioctl_fitrim(struct ntfs_volume *vol, unsigned long arg)
+{
+	struct fstrim_range __user *user_range;
+	struct fstrim_range range;
+	struct block_device *dev;
 	int err;
 
-	BUG_ON(!nr_pages);
-	BUG_ON(!pages);
-	page = pages[0];
-	BUG_ON(!page);
-	vi = page->mapping->host;
-	ni = NTFS_I(vi);
-	ntfs_debug("Entering for inode 0x%lx, attribute type 0x%x, start page "
-			"index 0x%lx, nr_pages 0x%x, pos 0x%llx, bytes 0x%zx.",
-			vi->i_ino, ni->type, page->index, nr_pages,
-			(long long)pos, bytes);
-	if (NInoNonResident(ni))
-		return ntfs_commit_pages_after_non_resident_write(pages,
-				nr_pages, pos, bytes);
-	BUG_ON(nr_pages > 1);
-	/*
-	 * Attribute is resident, implying it is not compressed, encrypted, or
-	 * sparse.
-	 */
-	if (!NInoAttr(ni))
-		base_ni = ni;
-	else
-		base_ni = ni->ext.base_ntfs_ino;
-	BUG_ON(NInoNonResident(ni));
-	/* Map, pin, and lock the mft record. */
-	m = map_mft_record(base_ni);
-	if (IS_ERR(m)) {
-		err = PTR_ERR(m);
-		m = NULL;
-		ctx = NULL;
-		goto err_out;
-	}
-	ctx = ntfs_attr_get_search_ctx(base_ni, m);
-	if (unlikely(!ctx)) {
-		err = -ENOMEM;
-		goto err_out;
-	}
-	err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
-			CASE_SENSITIVE, 0, NULL, 0, ctx);
-	if (unlikely(err)) {
-		if (err == -ENOENT)
-			err = -EIO;
-		goto err_out;
-	}
-	a = ctx->attr;
-	BUG_ON(a->non_resident);
-	/* The total length of the attribute value. */
-	attr_len = le32_to_cpu(a->data.resident.value_length);
-	i_size = i_size_read(vi);
-	BUG_ON(attr_len != i_size);
-	BUG_ON(pos > attr_len);
-	end = pos + bytes;
-	BUG_ON(end > le32_to_cpu(a->length) -
-			le16_to_cpu(a->data.resident.value_offset));
-	kattr = (u8*)a + le16_to_cpu(a->data.resident.value_offset);
-	kaddr = kmap_atomic(page);
-	/* Copy the received data from the page to the mft record. */
-	memcpy(kattr + pos, kaddr + pos, bytes);
-	/* Update the attribute length if necessary. */
-	if (end > attr_len) {
-		attr_len = end;
-		a->data.resident.value_length = cpu_to_le32(attr_len);
-	}
-	/*
-	 * If the page is not uptodate, bring the out of bounds area(s)
-	 * uptodate by copying data from the mft record to the page.
-	 */
-	if (!PageUptodate(page)) {
-		if (pos > 0)
-			memcpy(kaddr, kattr, pos);
-		if (end < attr_len)
-			memcpy(kaddr + end, kattr + end, attr_len - end);
-		/* Zero the region outside the end of the attribute value. */
-		memset(kaddr + attr_len, 0, PAGE_SIZE - attr_len);
-		flush_dcache_page(page);
-		SetPageUptodate(page);
-	}
-	kunmap_atomic(kaddr);
-	/* Update initialized_size/i_size if necessary. */
-	read_lock_irqsave(&ni->size_lock, flags);
-	initialized_size = ni->initialized_size;
-	BUG_ON(end > ni->allocated_size);
-	read_unlock_irqrestore(&ni->size_lock, flags);
-	BUG_ON(initialized_size != i_size);
-	if (end > initialized_size) {
-		write_lock_irqsave(&ni->size_lock, flags);
-		ni->initialized_size = end;
-		i_size_write(vi, end);
-		write_unlock_irqrestore(&ni->size_lock, flags);
-	}
-	/* Mark the mft record dirty, so it gets written back. */
-	flush_dcache_mft_record_page(ctx->ntfs_ino);
-	mark_mft_record_dirty(ctx->ntfs_ino);
-	ntfs_attr_put_search_ctx(ctx);
-	unmap_mft_record(base_ni);
-	ntfs_debug("Done.");
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	dev = vol->sb->s_bdev;
+	if (!bdev_max_discard_sectors(dev))
+		return -EOPNOTSUPP;
+
+	user_range = (struct fstrim_range __user *)arg;
+	if (copy_from_user(&range, user_range, sizeof(range)))
+		return -EFAULT;
+
+	if (range.len == 0)
+		return -EINVAL;
+
+	if (range.len < vol->cluster_size)
+		return -EINVAL;
+
+	range.minlen = max_t(u32, range.minlen, bdev_discard_granularity(dev));
+
+	err = ntfsp_trim_fs(vol, &range);
+	if (err < 0)
+		return err;
+
+	if (copy_to_user(user_range, &range, sizeof(range)))
+		return -EFAULT;
+
 	return 0;
-err_out:
-	if (err == -ENOMEM) {
-		ntfs_warning(vi->i_sb, "Error allocating memory required to "
-				"commit the write.");
-		if (PageUptodate(page)) {
-			ntfs_warning(vi->i_sb, "Page is uptodate, setting "
-					"dirty so the write will be retried "
-					"later on by the VM.");
-			/*
-			 * Put the page on mapping->dirty_pages, but leave its
-			 * buffers' dirty state as-is.
-			 */
-			__set_page_dirty_nobuffers(page);
-			err = 0;
-		} else
-			ntfs_error(vi->i_sb, "Page is not uptodate.  Written "
-					"data has been lost.");
-	} else {
-		ntfs_error(vi->i_sb, "Resident attribute commit write failed "
-				"with error %i.", err);
-		NVolSetErrors(ni->vol);
+}
+
+long ntfsp_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	switch (cmd) {
+	case NTFS_IOC_SHUTDOWN:
+		return ntfs_ioctl_shutdown(file_inode(filp)->i_sb, arg);
+	case FS_IOC_GETFSLABEL:
+		return ntfs_ioctl_get_volume_label(filp, arg);
+	case FS_IOC_SETFSLABEL:
+		return ntfs_ioctl_set_volume_label(filp, arg);
+	case FITRIM:
+		return ntfs_ioctl_fitrim(NTFS_SB(file_inode(filp)->i_sb), arg);
+	default:
+		return -ENOTTY;
 	}
-	if (ctx)
-		ntfs_attr_put_search_ctx(ctx);
-	if (m)
-		unmap_mft_record(base_ni);
-	return err;
 }
 
-/*
- * Copy as much as we can into the pages and return the number of bytes which
- * were successfully copied.  If a fault is encountered then clear the pages
- * out to (ofs + bytes) and return the number of bytes which were copied.
- */
-static size_t ntfs_copy_from_user_iter(struct page **pages, unsigned nr_pages,
-		unsigned ofs, struct iov_iter *i, size_t bytes)
+#ifdef CONFIG_COMPAT
+long ntfsp_compat_ioctl(struct file *filp, unsigned int cmd,
+		unsigned long arg)
 {
-	struct page **last_page = pages + nr_pages;
-	size_t total = 0;
-	unsigned len, copied;
-
-	do {
-		len = PAGE_SIZE - ofs;
-		if (len > bytes)
-			len = bytes;
-		copied = copy_page_from_iter_atomic(*pages, ofs, len, i);
-		total += copied;
-		bytes -= copied;
-		if (!bytes)
-			break;
-		if (copied < len)
-			goto err;
-		ofs = 0;
-	} while (++pages < last_page);
-out:
-	return total;
-err:
-	/* Zero the rest of the target like __copy_from_user(). */
-	len = PAGE_SIZE - copied;
-	do {
-		if (len > bytes)
-			len = bytes;
-		zero_user(*pages, copied, len);
-		bytes -= len;
-		copied = 0;
-		len = PAGE_SIZE;
-	} while (++pages < last_page);
-	goto out;
+	return ntfsp_ioctl(filp, cmd, (unsigned long)compat_ptr(arg));
 }
+#endif
 
-/**
- * ntfs_perform_write - perform buffered write to a file
- * @file:	file to write to
- * @i:		iov_iter with data to write
- * @pos:	byte offset in file at which to begin writing to
- */
-static ssize_t ntfs_perform_write(struct file *file, struct iov_iter *i,
-		loff_t pos)
+static long ntfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 {
-	struct address_space *mapping = file->f_mapping;
-	struct inode *vi = mapping->host;
-	ntfs_inode *ni = NTFS_I(vi);
-	ntfs_volume *vol = ni->vol;
-	struct page *pages[NTFS_MAX_PAGES_PER_CLUSTER];
-	struct page *cached_page = NULL;
-	VCN last_vcn;
-	LCN lcn;
-	size_t bytes;
-	ssize_t status, written = 0;
-	unsigned nr_pages;
-
-	ntfs_debug("Entering for i_ino 0x%lx, attribute type 0x%x, pos "
-			"0x%llx, count 0x%lx.", vi->i_ino,
-			(unsigned)le32_to_cpu(ni->type),
-			(unsigned long long)pos,
-			(unsigned long)iov_iter_count(i));
-	/*
-	 * If a previous ntfs_truncate() failed, repeat it and abort if it
-	 * fails again.
-	 */
-	if (unlikely(NInoTruncateFailed(ni))) {
-		int err;
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
 
-		inode_dio_wait(vi);
-		err = ntfs_truncate(vi);
-		if (err || NInoTruncateFailed(ni)) {
-			if (!err)
-				err = -EIO;
-			ntfs_error(vol->sb, "Cannot perform write to inode "
-					"0x%lx, attribute type 0x%x, because "
-					"ntfs_truncate() failed (error code "
-					"%i).", vi->i_ino,
-					(unsigned)le32_to_cpu(ni->type), err);
+	if (NInoNonResident(ni) && !NInoFullyMapped(ni)) {
+		down_write(&ni->runlist.lock);
+		err = ntfs_attr_map_whole_runlist(ni);
+		up_write(&ni->runlist.lock);
+		if (err)
 			return err;
-		}
 	}
-	/*
-	 * Determine the number of pages per cluster for non-resident
-	 * attributes.
-	 */
-	nr_pages = 1;
-	if (vol->cluster_size > PAGE_SIZE && NInoNonResident(ni))
-		nr_pages = vol->cluster_size >> PAGE_SHIFT;
-	last_vcn = -1;
-	do {
-		VCN vcn;
-		pgoff_t start_idx;
-		unsigned ofs, do_pages, u;
-		size_t copied;
-
-		start_idx = pos >> PAGE_SHIFT;
-		ofs = pos & ~PAGE_MASK;
-		bytes = PAGE_SIZE - ofs;
-		do_pages = 1;
-		if (nr_pages > 1) {
-			vcn = pos >> vol->cluster_size_bits;
-			if (vcn != last_vcn) {
-				last_vcn = vcn;
-				/*
-				 * Get the lcn of the vcn the write is in.  If
-				 * it is a hole, need to lock down all pages in
-				 * the cluster.
-				 */
-				down_read(&ni->runlist.lock);
-				lcn = ntfs_attr_vcn_to_lcn_nolock(ni, pos >>
-						vol->cluster_size_bits, false);
-				up_read(&ni->runlist.lock);
-				if (unlikely(lcn < LCN_HOLE)) {
-					if (lcn == LCN_ENOMEM)
-						status = -ENOMEM;
-					else {
-						status = -EIO;
-						ntfs_error(vol->sb, "Cannot "
-							"perform write to "
-							"inode 0x%lx, "
-							"attribute type 0x%x, "
-							"because the attribute "
-							"is corrupt.",
-							vi->i_ino, (unsigned)
-							le32_to_cpu(ni->type));
-					}
-					break;
-				}
-				if (lcn == LCN_HOLE) {
-					start_idx = (pos & ~(s64)
-							vol->cluster_size_mask)
-							>> PAGE_SHIFT;
-					bytes = vol->cluster_size - (pos &
-							vol->cluster_size_mask);
-					do_pages = nr_pages;
-				}
-			}
+
+	if (!(vol->vol_flags & VOLUME_IS_DIRTY)) {
+		err = ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
+		if (err)
+			return err;
+	}
+
+	old_size = i_size_read(vi);
+	new_size = max_t(loff_t, old_size, end_offset);
+	start_vcn = NTFS_B_TO_CLU(vol, offset);
+	end_vcn = (NTFS_B_TO_CLU(vol, end_offset - 1)) + 1;
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
+		if (NVolDisableSparse(vol)) {
+			err = -EOPNOTSUPP;
+			goto out;
 		}
-		if (bytes > iov_iter_count(i))
-			bytes = iov_iter_count(i);
-again:
-		/*
-		 * Bring in the user page(s) that we will copy from _first_.
-		 * Otherwise there is a nasty deadlock on copying from the same
-		 * page(s) as we are writing to, without it/them being marked
-		 * up-to-date.  Note, at present there is nothing to stop the
-		 * pages being swapped out between us bringing them into memory
-		 * and doing the actual copying.
-		 */
-		if (unlikely(fault_in_iov_iter_readable(i, bytes))) {
-			status = -EFAULT;
-			break;
+
+		if ((offset & vol->cluster_size_mask) ||
+		    (len & vol->cluster_size_mask) ||
+		    offset >= ni->allocated_size) {
+			err = -EINVAL;
+			goto out;
 		}
-		/* Get and lock @do_pages starting at index @start_idx. */
-		status = __ntfs_grab_cache_pages(mapping, start_idx, do_pages,
-				pages, &cached_page);
-		if (unlikely(status))
-			break;
-		/*
-		 * For non-resident attributes, we need to fill any holes with
-		 * actual clusters and ensure all bufferes are mapped.  We also
-		 * need to bring uptodate any buffers that are only partially
-		 * being written to.
-		 */
-		if (NInoNonResident(ni)) {
-			status = ntfs_prepare_pages_for_non_resident_write(
-					pages, do_pages, pos, bytes);
-			if (unlikely(status)) {
-				do {
-					unlock_page(pages[--do_pages]);
-					put_page(pages[do_pages]);
-				} while (do_pages);
-				break;
-			}
+
+		new_size = old_size +
+			(NTFS_CLU_TO_B(vol, end_vcn - start_vcn));
+		alloc_size = ni->allocated_size +
+			(NTFS_CLU_TO_B(vol, end_vcn - start_vcn));
+		if (alloc_size < 0) {
+			err = -EFBIG;
+			goto out;
 		}
-		u = (pos >> PAGE_SHIFT) - pages[0]->index;
-		copied = ntfs_copy_from_user_iter(pages + u, do_pages - u, ofs,
-					i, bytes);
-		ntfs_flush_dcache_pages(pages + u, do_pages - u);
-		status = 0;
-		if (likely(copied == bytes)) {
-			status = ntfs_commit_pages_after_write(pages, do_pages,
-					pos, bytes);
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
 		}
-		do {
-			unlock_page(pages[--do_pages]);
-			put_page(pages[do_pages]);
-		} while (do_pages);
-		if (unlikely(status < 0)) {
-			iov_iter_revert(i, copied);
-			break;
+
+		if (NTFS_CLU_TO_B(vol, end_vcn) > ni->allocated_size)
+			end_vcn = (round_up(ni->allocated_size - 1, vol->cluster_size) >>
+					vol->cluster_size_bits) + 1;
+		new_size = old_size -
+			(NTFS_CLU_TO_B(vol, end_vcn - start_vcn));
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
+		if (NVolDisableSparse(vol)) {
+			err = -EOPNOTSUPP;
+			goto out;
 		}
-		cond_resched();
-		if (unlikely(copied < bytes)) {
-			iov_iter_revert(i, copied);
-			if (copied)
-				bytes = copied;
-			else if (bytes > PAGE_SIZE - ofs)
-				bytes = PAGE_SIZE - ofs;
-			goto again;
+
+		if (!(mode & FALLOC_FL_KEEP_SIZE)) {
+			err = -EINVAL;
+			goto out;
 		}
-		pos += copied;
-		written += copied;
-		balance_dirty_pages_ratelimited(mapping);
-		if (fatal_signal_pending(current)) {
-			status = -EINTR;
-			break;
+
+		if (offset >= ni->data_size)
+			goto out;
+
+		if (offset + len > ni->data_size) {
+			end_offset = ni->data_size;
+			end_vcn = (NTFS_B_TO_CLU(vol, end_offset - 1)) + 1;
 		}
-	} while (iov_iter_count(i));
-	if (cached_page)
-		put_page(cached_page);
-	ntfs_debug("Done.  Returning %s (written 0x%lx, status %li).",
-			written ? "written" : "status", (unsigned long)written,
-			(long)status);
-	return written ? written : status;
-}
 
-/**
- * ntfs_file_write_iter - simple wrapper for ntfs_file_write_iter_nolock()
- * @iocb:	IO state structure
- * @from:	iov_iter with data to write
- *
- * Basically the same as generic_file_write_iter() except that it ends up
- * up calling ntfs_perform_write() instead of generic_perform_write() and that
- * O_DIRECT is not implemented.
- */
-static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
-{
-	struct file *file = iocb->ki_filp;
-	struct inode *vi = file_inode(file);
-	ssize_t written = 0;
-	ssize_t err;
+		err = filemap_write_and_wait_range(vi->i_mapping, offset_down, LLONG_MAX);
+		if (err)
+			goto out;
+		truncate_pagecache(vi, offset_down);
 
-	inode_lock(vi);
-	/* We can write back this queue in page reclaim. */
-	err = ntfs_prepare_file_for_write(iocb, from);
-	if (iov_iter_count(from) && !err)
-		written = ntfs_perform_write(file, from, iocb->ki_pos);
-	inode_unlock(vi);
-	iocb->ki_pos += written;
-	if (likely(written > 0))
-		written = generic_write_sync(iocb, written);
-	return written ? written : err;
-}
+		if (offset & vol->cluster_size_mask) {
+			loff_t to;
 
-/**
- * ntfs_file_fsync - sync a file to disk
- * @filp:	file to be synced
- * @datasync:	if non-zero only flush user data and not metadata
- *
- * Data integrity sync of a file to disk.  Used for fsync, fdatasync, and msync
- * system calls.  This function is inspired by fs/buffer.c::file_fsync().
- *
- * If @datasync is false, write the mft record and all associated extent mft
- * records as well as the $DATA attribute and then sync the block device.
- *
- * If @datasync is true and the attribute is non-resident, we skip the writing
- * of the mft record and all associated extent mft records (this might still
- * happen due to the write_inode_now() call).
- *
- * Also, if @datasync is true, we do not wait on the inode to be written out
- * but we always wait on the page cache pages to be written out.
- *
- * Locking: Caller must hold i_mutex on the inode.
- *
- * TODO: We should probably also write all attribute/index inodes associated
- * with this inode but since we have no simple way of getting to them we ignore
- * this problem for now.
- */
-static int ntfs_file_fsync(struct file *filp, loff_t start, loff_t end,
-			   int datasync)
-{
-	struct inode *vi = filp->f_mapping->host;
-	int err, ret = 0;
+			to = min_t(loff_t, NTFS_CLU_TO_B(vol, start_vcn + 1),
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
 
-	ntfs_debug("Entering for inode 0x%lx.", vi->i_ino);
+			from = NTFS_CLU_TO_B(vol, end_vcn - 1);
+			err = iomap_zero_range(vi, from, end_offset - from, NULL,
+					       &ntfs_read_iomap_ops,
+					       &ntfs_iomap_folio_ops, NULL);
+			if (err < 0 || (end_vcn - start_vcn) == 1)
+				goto out;
+			end_vcn--;
+		}
 
-	err = file_write_and_wait_range(filp, start, end);
-	if (err)
-		return err;
-	inode_lock(vi);
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
+		need_space = NTFS_B_TO_CLU(vol, ni->allocated_size);
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
 
-	BUG_ON(S_ISDIR(vi->i_mode));
-	if (!datasync || !NInoNonResident(NTFS_I(vi)))
-		ret = __ntfs_write_inode(vi, 1);
-	write_inode_now(vi, !datasync);
-	/*
-	 * NOTE: If we were to use mapping->private_list (see ext2 and
-	 * fs/buffer.c) for dirty blocks then we could optimize the below to be
-	 * sync_mapping_buffers(vi->i_mapping).
-	 */
-	err = sync_blockdev(vi->i_sb->s_bdev);
-	if (unlikely(err && !ret))
-		ret = err;
-	if (likely(!ret))
-		ntfs_debug("Done.");
-	else
-		ntfs_warning(vi->i_sb, "Failed to f%ssync inode 0x%lx.  Error "
-				"%u.", datasync ? "data" : "", vi->i_ino, -ret);
 	inode_unlock(vi);
-	return ret;
+	return err;
 }
 
-#endif /* NTFS_RW */
-
 const struct file_operations ntfs_file_ops = {
-	.llseek		= generic_file_llseek,
-	.read_iter	= generic_file_read_iter,
-#ifdef NTFS_RW
+	.llseek		= ntfs_file_llseek,
+	.read_iter	= ntfs_file_read_iter,
 	.write_iter	= ntfs_file_write_iter,
 	.fsync		= ntfs_file_fsync,
-#endif /* NTFS_RW */
-	.mmap		= generic_file_mmap,
+	.mmap_prepare	= ntfs_file_mmap_prepare,
 	.open		= ntfs_file_open,
-	.splice_read	= filemap_splice_read,
+	.release	= ntfs_file_release,
+	.splice_read	= ntfs_file_splice_read,
+	.splice_write	= iter_file_splice_write,
+	.unlocked_ioctl	= ntfsp_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= ntfsp_compat_ioctl,
+#endif
+	.fallocate	= ntfs_fallocate,
 };
 
 const struct inode_operations ntfs_file_inode_ops = {
-#ifdef NTFS_RW
-	.setattr	= ntfs_setattr,
-#endif /* NTFS_RW */
+	.setattr	= ntfsp_setattr,
+	.getattr	= ntfsp_getattr,
+	.listxattr	= ntfsp_listxattr,
+	.get_acl	= ntfsp_get_acl,
+	.set_acl	= ntfsp_set_acl,
+	.fiemap		= ntfs_fiemap,
+};
+
+const struct inode_operations ntfs_symlink_inode_operations = {
+	.get_link	= ntfs_get_link,
+	.setattr	= ntfsp_setattr,
+	.listxattr	= ntfsp_listxattr,
+};
+
+const struct inode_operations ntfsp_special_inode_operations = {
+	.setattr	= ntfsp_setattr,
+	.getattr	= ntfsp_getattr,
+	.listxattr	= ntfsp_listxattr,
+	.get_acl	= ntfsp_get_acl,
+	.set_acl	= ntfsp_set_acl,
 };
 
 const struct file_operations ntfs_empty_file_ops = {};
-- 
2.25.1


