Return-Path: <linux-fsdevel+bounces-72349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8153CF06D5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 03 Jan 2026 23:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 209D630191AF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jan 2026 22:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD56C253958;
	Sat,  3 Jan 2026 22:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcX/RfeA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AB91F12F8;
	Sat,  3 Jan 2026 22:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767481091; cv=none; b=D8uYLoLgAw4ExbUIpSnF8TzBpl05+pytrIKZH2A/mkYBXPwoQKKRCUMMttDhSCtJSG+98XO6FdwH+ffZvCY0vfGqvyLqDetXoyztDDgKi6zlEhQOx8uGutvAPeAhjHh6TIcN1cRzGZfQIyZ+TjRLgQIS9sb4WJd27JsX2ZIFHtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767481091; c=relaxed/simple;
	bh=eydUNsVn4uNA6W9nGSWyD5GSyY6LRr3xiGBG32BGNZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQEHSics2Igj1HyOMlI2nbVxQlPSiUGyp4Cp6qw/zG5MyKo4wokyjBhdW5PI0yfrFZBbg8NlgWtE9AG1YEm0Kg5+sSduSBKk+1e3mGegJakdA0oh07UAQo0cz9p8UrFMfctUzk+gcQ95sDHDG9+Raq6zylRgT7Sj46uP2MAztm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcX/RfeA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C68DC113D0;
	Sat,  3 Jan 2026 22:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767481087;
	bh=eydUNsVn4uNA6W9nGSWyD5GSyY6LRr3xiGBG32BGNZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RcX/RfeAQ7yjcV6QFtSfyzGoyRoBAo/e4Xqc0azUDWIXZ0GChy5yoJFdqSo2tTbwS
	 9iUMjWRberD2NWEkCjT8xZ+sTT48oHmlD7xLQWiiVFp1Q1fJhzr9iRWcgY7nNCJ+Cv
	 wK+oO1NooDAajPC8hmyZ2jS/pdYRiSI/BGFzXl6EqynCeituG7gbJK7ykjRZYas2fi
	 6Be9Miky9AdkonohtJyRkgWLWV9Crck8cYAqLSFgoQe21FswwQAsOEHZNtSKMjxc/2
	 USg/GhG5eBJGVB4buNhVyapJkn4pVtgj3sBbSKOfeLBFrf6p9n3wldQwBg11DUkIxo
	 HCbI0F64WdT2Q==
Date: Sat, 3 Jan 2026 17:58:05 -0500
From: Sasha Levin <sashal@kernel.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/ntfs3: implement iomap-based file operations
Message-ID: <aVme_c-zcjEurLJ3@laps>
References: <20251226174451.16019-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251226174451.16019-1-almaz.alexandrovich@paragon-software.com>

On Fri, Dec 26, 2025 at 06:44:51PM +0100, Konstantin Komarov wrote:
>This patch modifies the ntfs3 driver by replacing the buffer_head-based
>operations with the iomap ones.
>
>Implementation details:
>- Implements core iomap operations (ntfs_iomap_begin/end) for block mapping:
>    Proper handling of resident attributes via IOMAP_INLINE.
>    Support for sparse files through IOMAP_HOLE semantics.
>    Correct unwritten extent handling for zeroing operations.
>- Replaces custom implementations with standardized iomap helpers:
>    Converts buffered reads to use iomap_read_folio and iomap_readahead.
>    Implements iomap_file_buffered_write for write operations.
>    Uses iomap_dio_rw for direct I/O paths.
>    Migrates zero range operations to iomap_zero_range.
>- Preserves special handling paths for compressed files
>- Implements proper EOF/valid data size management during writes
>
>Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
>---
> fs/ntfs3/attrib.c  |  78 +++--
> fs/ntfs3/file.c    | 368 ++++++++++++-----------
> fs/ntfs3/frecord.c | 185 +-----------
> fs/ntfs3/fslog.c   |   2 +-
> fs/ntfs3/fsntfs.c  |  10 +-
> fs/ntfs3/inode.c   | 724 ++++++++++++++++++++++-----------------------
> fs/ntfs3/ntfs_fs.h |  16 +-
> fs/ntfs3/super.c   |  11 +-
> 8 files changed, 603 insertions(+), 791 deletions(-)
>
>diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
>index 3e188d6c229f..aa745fb226f5 100644
>--- a/fs/ntfs3/attrib.c
>+++ b/fs/ntfs3/attrib.c
>@@ -166,6 +166,12 @@ int attr_allocate_clusters(struct ntfs_sb_info *sbi, struct runs_tree *run,
> 			continue;
> 		}
>
>+		if (err == -ENOSPC && new_len && vcn - vcn0) {
>+			/* Keep already allocated clusters. */
>+			*alen = vcn - vcn0;
>+			return 0;
>+		}
>+
> 		if (err)
> 			goto out;
>
>@@ -886,7 +892,7 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
>  *  - new allocated clusters are zeroed via blkdev_issue_zeroout.
>  */
> int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
>-			CLST *len, bool *new, bool zero)
>+			CLST *len, bool *new, bool zero, void **res)
> {
> 	int err = 0;
> 	struct runs_tree *run = &ni->file.run;
>@@ -903,6 +909,8 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
>
> 	if (new)
> 		*new = false;
>+	if (res)
>+		*res = NULL;
>
> 	/* Try to find in cache. */
> 	down_read(&ni->file.run_lock);
>@@ -939,8 +947,15 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
> 	}
>
> 	if (!attr_b->non_res) {
>+		u32 data_size = le32_to_cpu(attr_b->res.data_size);
> 		*lcn = RESIDENT_LCN;
>-		*len = le32_to_cpu(attr_b->res.data_size);
>+		*len = data_size;
>+		if (res && data_size) {
>+			*res = kmemdup(resident_data(attr_b), data_size,
>+				       GFP_KERNEL);
>+			if (!*res)
>+				err = -ENOMEM;
>+		}
> 		goto out;
> 	}
>
>@@ -1028,7 +1043,8 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
> 		to_alloc = ((vcn0 + clen + clst_per_frame - 1) & cmask) - vcn;
> 		if (fr < clst_per_frame)
> 			fr = clst_per_frame;
>-		zero = true;
>+		if (vcn != vcn0)
>+			zero = true;
>
> 		/* Check if 'vcn' and 'vcn0' in different attribute segments. */
> 		if (vcn < svcn || evcn1 <= vcn) {
>@@ -1244,33 +1260,6 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
> 	goto out;
> }
>
>-int attr_data_read_resident(struct ntfs_inode *ni, struct folio *folio)
>-{
>-	u64 vbo;
>-	struct ATTRIB *attr;
>-	u32 data_size;
>-	size_t len;
>-
>-	attr = ni_find_attr(ni, NULL, NULL, ATTR_DATA, NULL, 0, NULL, NULL);
>-	if (!attr)
>-		return -EINVAL;
>-
>-	if (attr->non_res)
>-		return E_NTFS_NONRESIDENT;
>-
>-	vbo = folio->index << PAGE_SHIFT;
>-	data_size = le32_to_cpu(attr->res.data_size);
>-	if (vbo > data_size)
>-		len = 0;
>-	else
>-		len = min(data_size - vbo, folio_size(folio));
>-
>-	folio_fill_tail(folio, 0, resident_data(attr) + vbo, len);
>-	folio_mark_uptodate(folio);
>-
>-	return 0;
>-}
>-
> int attr_data_write_resident(struct ntfs_inode *ni, struct folio *folio)
> {
> 	u64 vbo;
>@@ -1287,7 +1276,7 @@ int attr_data_write_resident(struct ntfs_inode *ni, struct folio *folio)
> 		return E_NTFS_NONRESIDENT;
> 	}
>
>-	vbo = folio->index << PAGE_SHIFT;
>+	vbo = folio_pos(folio);
> 	data_size = le32_to_cpu(attr->res.data_size);
> 	if (vbo < data_size) {
> 		char *data = resident_data(attr);
>@@ -1360,21 +1349,20 @@ int attr_load_runs_range(struct ntfs_inode *ni, enum ATTR_TYPE type,
> 	int retry = 0;
>
> 	for (vcn = from >> cluster_bits; vcn <= vcn_last; vcn += clen) {
>-		if (!run_lookup_entry(run, vcn, &lcn, &clen, NULL)) {
>-			if (retry != 0) { /* Next run_lookup_entry(vcn) also failed. */
>-				err = -EINVAL;
>-				break;
>-			}
>-			err = attr_load_runs_vcn(ni, type, name, name_len, run,
>-						 vcn);
>-			if (err)
>-				break;
>-
>-			clen = 0; /* Next run_lookup_entry(vcn) must be success. */
>-			retry++;
>-		}
>-		else
>+		if (run_lookup_entry(run, vcn, &lcn, &clen, NULL)) {
> 			retry = 0;
>+			continue;
>+		}
>+		if (retry) {
>+			err = -EINVAL;
>+			break;
>+		}
>+		err = attr_load_runs_vcn(ni, type, name, name_len, run, vcn);
>+		if (err)
>+			break;
>+
>+		clen = 0; /* Next run_lookup_entry(vcn) must be success. */
>+		retry++;
> 	}
>
> 	return err;
>diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
>index c89b1e7e734c..58fa4da114bb 100644
>--- a/fs/ntfs3/file.c
>+++ b/fs/ntfs3/file.c
>@@ -14,6 +14,7 @@
> #include <linux/falloc.h>
> #include <linux/fiemap.h>
> #include <linux/fileattr.h>
>+#include <linux/iomap.h>
>
> #include "debug.h"
> #include "ntfs.h"
>@@ -189,9 +190,6 @@ static int ntfs_extend_initialized_size(struct file *file,
> 					const loff_t new_valid)
> {
> 	struct inode *inode = &ni->vfs_inode;
>-	struct address_space *mapping = inode->i_mapping;
>-	struct ntfs_sb_info *sbi = inode->i_sb->s_fs_info;
>-	loff_t pos = valid;
> 	int err;
>
> 	if (valid >= new_valid)
>@@ -204,140 +202,41 @@ static int ntfs_extend_initialized_size(struct file *file,
>
> 	WARN_ON(is_compressed(ni));
>
>-	for (;;) {
>-		u32 zerofrom, len;
>-		struct folio *folio;
>-		u8 bits;
>-		CLST vcn, lcn, clen;
>-
>-		if (is_sparsed(ni)) {
>-			bits = sbi->cluster_bits;
>-			vcn = pos >> bits;
>-
>-			err = attr_data_get_block(ni, vcn, 1, &lcn, &clen, NULL,
>-						  false);
>-			if (err)
>-				goto out;
>-
>-			if (lcn == SPARSE_LCN) {
>-				pos = ((loff_t)clen + vcn) << bits;
>-				ni->i_valid = pos;
>-				goto next;
>-			}
>-		}
>-
>-		zerofrom = pos & (PAGE_SIZE - 1);
>-		len = PAGE_SIZE - zerofrom;
>-
>-		if (pos + len > new_valid)
>-			len = new_valid - pos;
>-
>-		err = ntfs_write_begin(NULL, mapping, pos, len, &folio, NULL);
>-		if (err)
>-			goto out;
>-
>-		folio_zero_range(folio, zerofrom, folio_size(folio) - zerofrom);
>-
>-		err = ntfs_write_end(NULL, mapping, pos, len, len, folio, NULL);
>-		if (err < 0)
>-			goto out;
>-		pos += len;
>-
>-next:
>-		if (pos >= new_valid)
>-			break;
>-
>-		balance_dirty_pages_ratelimited(mapping);
>-		cond_resched();
>+	err = iomap_zero_range(inode, valid, new_valid - valid, NULL,
>+			       &ntfs_iomap_ops, &ntfs_iomap_folio_ops, NULL);
>+	if (err) {
>+		ni->i_valid = valid;
>+		ntfs_inode_warn(inode,
>+				"failed to extend initialized size to %llx.",
>+				new_valid);
>+		return err;
> 	}
>
> 	return 0;
>-
>-out:
>-	ni->i_valid = valid;
>-	ntfs_inode_warn(inode, "failed to extend initialized size to %llx.",
>-			new_valid);
>-	return err;
> }
>
>-/*
>- * ntfs_zero_range - Helper function for punch_hole.
>- *
>- * It zeroes a range [vbo, vbo_to).
>- */
>-static int ntfs_zero_range(struct inode *inode, u64 vbo, u64 vbo_to)
>+static void ntfs_filemap_close(struct vm_area_struct *vma)
> {
>-	int err = 0;
>-	struct address_space *mapping = inode->i_mapping;
>-	u32 blocksize = i_blocksize(inode);
>-	pgoff_t idx = vbo >> PAGE_SHIFT;
>-	u32 from = vbo & (PAGE_SIZE - 1);
>-	pgoff_t idx_end = (vbo_to + PAGE_SIZE - 1) >> PAGE_SHIFT;
>-	loff_t page_off;
>-	struct buffer_head *head, *bh;
>-	u32 bh_next, bh_off, to;
>-	sector_t iblock;
>-	struct folio *folio;
>-	bool dirty = false;
>-
>-	for (; idx < idx_end; idx += 1, from = 0) {
>-		page_off = (loff_t)idx << PAGE_SHIFT;
>-		to = (page_off + PAGE_SIZE) > vbo_to ? (vbo_to - page_off) :
>-						       PAGE_SIZE;
>-		iblock = page_off >> inode->i_blkbits;
>-
>-		folio = __filemap_get_folio(
>-			mapping, idx, FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
>-			mapping_gfp_constraint(mapping, ~__GFP_FS));
>-		if (IS_ERR(folio))
>-			return PTR_ERR(folio);
>-
>-		head = folio_buffers(folio);
>-		if (!head)
>-			head = create_empty_buffers(folio, blocksize, 0);
>-
>-		bh = head;
>-		bh_off = 0;
>-		do {
>-			bh_next = bh_off + blocksize;
>-
>-			if (bh_next <= from || bh_off >= to)
>-				continue;
>-
>-			if (!buffer_mapped(bh)) {
>-				ntfs_get_block(inode, iblock, bh, 0);
>-				/* Unmapped? It's a hole - nothing to do. */
>-				if (!buffer_mapped(bh))
>-					continue;
>-			}
>-
>-			/* Ok, it's mapped. Make sure it's up-to-date. */
>-			if (folio_test_uptodate(folio))
>-				set_buffer_uptodate(bh);
>-			else if (bh_read(bh, 0) < 0) {
>-				err = -EIO;
>-				folio_unlock(folio);
>-				folio_put(folio);
>-				goto out;
>-			}
>-
>-			mark_buffer_dirty(bh);
>-		} while (bh_off = bh_next, iblock += 1,
>-			 head != (bh = bh->b_this_page));
>-
>-		folio_zero_segment(folio, from, to);
>-		dirty = true;
>+	struct inode *inode = file_inode(vma->vm_file);
>+	struct ntfs_inode *ni = ntfs_i(inode);
>+	u64 from = (u64)vma->vm_pgoff << PAGE_SHIFT;
>+	u64 to = min_t(u64, i_size_read(inode),
>+		       from + vma->vm_end - vma->vm_start);
>
>-		folio_unlock(folio);
>-		folio_put(folio);
>-		cond_resched();
>-	}
>-out:
>-	if (dirty)
>+	if (ni->i_valid < to) {
>+		ni->i_valid = to;
> 		mark_inode_dirty(inode);
>-	return err;
>+	}
> }
>
>+/* Copy of generic_file_vm_ops. */
>+static const struct vm_operations_struct ntfs_file_vm_ops = {
>+	.close = ntfs_filemap_close,
>+	.fault = filemap_fault,
>+	.map_pages = filemap_map_pages,
>+	.page_mkwrite = filemap_page_mkwrite,
>+};
>+
> /*
>  * ntfs_file_mmap_prepare - file_operations::mmap_prepare
>  */
>@@ -346,7 +245,6 @@ static int ntfs_file_mmap_prepare(struct vm_area_desc *desc)
> 	struct file *file = desc->file;
> 	struct inode *inode = file_inode(file);
> 	struct ntfs_inode *ni = ntfs_i(inode);
>-	u64 from = ((u64)desc->pgoff << PAGE_SHIFT);
> 	bool rw = desc->vm_flags & VM_WRITE;
> 	int err;
>
>@@ -378,7 +276,8 @@ static int ntfs_file_mmap_prepare(struct vm_area_desc *desc)
> 	}
>
> 	if (rw) {
>-		u64 to = min_t(loff_t, i_size_read(inode),
>+		u64 from = (u64)desc->pgoff << PAGE_SHIFT;
>+		u64 to = min_t(u64, i_size_read(inode),
> 			       from + vma_desc_size(desc));
>
> 		if (is_sparsed(ni)) {
>@@ -391,7 +290,8 @@ static int ntfs_file_mmap_prepare(struct vm_area_desc *desc)
>
> 			for (; vcn < end; vcn += len) {
> 				err = attr_data_get_block(ni, vcn, 1, &lcn,
>-							  &len, &new, true);
>+							  &len, &new, true,
>+							  NULL);
> 				if (err)
> 					goto out;
> 			}
>@@ -411,6 +311,8 @@ static int ntfs_file_mmap_prepare(struct vm_area_desc *desc)
> 	}
>
> 	err = generic_file_mmap_prepare(desc);
>+	if (!err && rw)
>+		desc->vm_ops = &ntfs_file_vm_ops;
> out:
> 	return err;
> }
>@@ -465,7 +367,7 @@ static int ntfs_extend(struct inode *inode, loff_t pos, size_t count,
> 		 */
> 		for (; vcn < cend_v; vcn += clen) {
> 			err = attr_data_get_block(ni, vcn, cend_v - vcn, &lcn,
>-						  &clen, &new, true);
>+						  &clen, &new, true, NULL);
> 			if (err)
> 				goto out;
> 		}
>@@ -474,7 +376,7 @@ static int ntfs_extend(struct inode *inode, loff_t pos, size_t count,
> 		 */
> 		for (; vcn < cend; vcn += clen) {
> 			err = attr_data_get_block(ni, vcn, cend - vcn, &lcn,
>-						  &clen, &new, false);
>+						  &clen, &new, false, NULL);
> 			if (err)
> 				goto out;
> 		}
>@@ -503,25 +405,10 @@ static int ntfs_extend(struct inode *inode, loff_t pos, size_t count,
>
> static int ntfs_truncate(struct inode *inode, loff_t new_size)
> {
>-	struct super_block *sb = inode->i_sb;
>-	struct ntfs_inode *ni = ntfs_i(inode);
>-	u64 new_valid;
> 	int err;
>+	struct ntfs_inode *ni = ntfs_i(inode);
>+	u64 new_valid = min_t(u64, ni->i_valid, new_size);
>
>-	if (!S_ISREG(inode->i_mode))
>-		return 0;
>-
>-	if (is_compressed(ni)) {
>-		if (ni->i_valid > new_size)
>-			ni->i_valid = new_size;
>-	} else {
>-		err = block_truncate_page(inode->i_mapping, new_size,
>-					  ntfs_get_block);
>-		if (err)
>-			return err;
>-	}
>-
>-	new_valid = ntfs_up_block(sb, min_t(u64, ni->i_valid, new_size));
> 	truncate_setsize(inode, new_size);
>
> 	ni_lock(ni);
>@@ -531,11 +418,11 @@ static int ntfs_truncate(struct inode *inode, loff_t new_size)
> 			    &new_valid, ni->mi.sbi->options->prealloc, NULL);
> 	up_write(&ni->file.run_lock);
>
>-	if (new_valid < ni->i_valid)
>-		ni->i_valid = new_valid;
>+	ni->i_valid = new_valid;
>
> 	ni_unlock(ni);
>-	if (unlikely(err))
>+
>+	if (err)
> 		return err;
>
> 	ni->std_fa |= FILE_ATTRIBUTE_ARCHIVE;
>@@ -646,13 +533,17 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
>
> 		tmp = min(vbo_a, end);
> 		if (tmp > vbo) {
>-			err = ntfs_zero_range(inode, vbo, tmp);
>+			err = iomap_zero_range(inode, vbo, tmp - vbo, NULL,
>+					       &ntfs_iomap_ops,
>+					       &ntfs_iomap_folio_ops, NULL);
> 			if (err)
> 				goto out;
> 		}
>
> 		if (vbo < end_a && end_a < end) {
>-			err = ntfs_zero_range(inode, end_a, end);
>+			err = iomap_zero_range(inode, end_a, end - end_a, NULL,
>+					       &ntfs_iomap_ops,
>+					       &ntfs_iomap_folio_ops, NULL);
> 			if (err)
> 				goto out;
> 		}
>@@ -762,7 +653,7 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
> 			for (; vcn < cend_v; vcn += clen) {
> 				err = attr_data_get_block(ni, vcn, cend_v - vcn,
> 							  &lcn, &clen, &new,
>-							  true);
>+							  true, NULL);
> 				if (err)
> 					goto out;
> 			}
>@@ -772,7 +663,7 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
> 			for (; vcn < cend; vcn += clen) {
> 				err = attr_data_get_block(ni, vcn, cend - vcn,
> 							  &lcn, &clen, &new,
>-							  false);
>+							  false, NULL);
> 				if (err)
> 					goto out;
> 			}
>@@ -787,6 +678,7 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
> 			ni_unlock(ni);
> 			if (err)
> 				goto out;
>+			i_size_write(inode, i_size);
> 		} else if (new_size > i_size) {
> 			i_size_write(inode, new_size);
> 		}
>@@ -923,12 +815,16 @@ static ssize_t ntfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
> 	struct file *file = iocb->ki_filp;
> 	struct inode *inode = file_inode(file);
> 	struct ntfs_inode *ni = ntfs_i(inode);
>+	size_t bytes = iov_iter_count(iter);
> 	ssize_t err;
>
> 	err = check_read_restriction(inode);
> 	if (err)
> 		return err;
>
>+	if (!bytes)
>+		return 0; /* skip atime */
>+
> 	if (is_compressed(ni)) {
> 		if (iocb->ki_flags & IOCB_DIRECT) {
> 			ntfs_inode_warn(
>@@ -940,13 +836,58 @@ static ssize_t ntfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
> 	}
>
> 	/* Check minimum alignment for dio. */
>+	if ((iocb->ki_flags & IOCB_DIRECT) &&
>+	    (is_resident(ni) || ((iocb->ki_pos | iov_iter_alignment(iter)) &
>+				 ni->mi.sbi->bdev_blocksize_mask))) {
>+		/* Fallback to buffered I/O */
>+		iocb->ki_flags &= ~IOCB_DIRECT;
>+	}
>+
> 	if (iocb->ki_flags & IOCB_DIRECT) {
>-		struct super_block *sb = inode->i_sb;
>-		struct ntfs_sb_info *sbi = sb->s_fs_info;
>-		if ((iocb->ki_pos | iov_iter_alignment(iter)) &
>-		    sbi->bdev_blocksize_mask) {
>-			iocb->ki_flags &= ~IOCB_DIRECT;
>+		loff_t valid, i_size;
>+		loff_t vbo = iocb->ki_pos;
>+		loff_t end = vbo + bytes;
>+		unsigned int dio_flags = IOMAP_DIO_PARTIAL;
>+
>+		if (iocb->ki_flags & IOCB_NOWAIT) {
>+			if (!inode_trylock_shared(inode))
>+				return -EAGAIN;
>+		} else {
>+			inode_lock_shared(inode);
>+		}
>+
>+		valid = ni->i_valid;
>+		i_size = inode->i_size;
>+
>+		if (vbo < valid) {
>+			if (valid < end) {
>+				/* read cross 'valid' size. */
>+				dio_flags |= IOMAP_DIO_FORCE_WAIT;
>+			}
>+
>+			err = iomap_dio_rw(iocb, iter, &ntfs_iomap_ops, NULL,
>+					   dio_flags, NULL, 0);
>+
>+			if (err > 0) {
>+				end = vbo + err;
>+				if (valid < end) {
>+					size_t to_zero = end - valid;
>+					/* Fix iter. */
>+					iov_iter_revert(iter, to_zero);
>+					iov_iter_zero(to_zero, iter);
>+				}
>+			}
>+		} else if (vbo < i_size) {
>+			if (end > i_size)
>+				bytes = i_size - vbo;
>+			iov_iter_zero(bytes, iter);
>+			iocb->ki_pos += bytes;
>+			err = bytes;
> 		}
>+
>+		inode_unlock_shared(inode);
>+		file_accessed(iocb->ki_filp);
>+		return err;
> 	}
>
> 	return generic_file_read_iter(iocb, iter);
>@@ -1070,7 +1011,7 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
> 		off = valid & (frame_size - 1);
>
> 		err = attr_data_get_block(ni, frame << NTFS_LZNT_CUNIT, 1, &lcn,
>-					  &clen, NULL, false);
>+					  &clen, NULL, false, NULL);
> 		if (err)
> 			goto out;
>
>@@ -1273,8 +1214,9 @@ static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
> 	struct file *file = iocb->ki_filp;
> 	struct inode *inode = file_inode(file);
> 	struct ntfs_inode *ni = ntfs_i(inode);
>-	ssize_t ret;
>-	int err;
>+	struct super_block *sb = inode->i_sb;
>+	struct ntfs_sb_info *sbi = sb->s_fs_info;
>+	ssize_t ret, err;
>
> 	if (!inode_trylock(inode)) {
> 		if (iocb->ki_flags & IOCB_NOWAIT)
>@@ -1312,15 +1254,73 @@ static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
> 	if (ret)
> 		goto out;
>
>-	ret = is_compressed(ni) ? ntfs_compress_write(iocb, from) :
>-				  __generic_file_write_iter(iocb, from);
>+	if (is_compressed(ni)) {
>+		ret = ntfs_compress_write(iocb, from);
>+		goto out;
>+	}
>+
>+	/* Check minimum alignment for dio. */
>+	if ((iocb->ki_flags & IOCB_DIRECT) &&
>+	    (is_resident(ni) || ((iocb->ki_pos | iov_iter_alignment(from)) &
>+				 sbi->bdev_blocksize_mask))) {
>+		/* Fallback to buffered I/O */
>+		iocb->ki_flags &= ~IOCB_DIRECT;
>+	}
>+
>+	if (!(iocb->ki_flags & IOCB_DIRECT)) {
>+		ret = iomap_file_buffered_write(iocb, from, &ntfs_iomap_ops,
>+						&ntfs_iomap_folio_ops, NULL);
>+		inode_unlock(inode);
>+
>+		if (likely(ret > 0))
>+			ret = generic_write_sync(iocb, ret);
>+
>+		return ret;
>+	}
>+
>+	ret = iomap_dio_rw(iocb, from, &ntfs_iomap_ops, NULL, IOMAP_DIO_PARTIAL,
>+			   NULL, 0);
>+
>+	if (ret == -ENOTBLK) {
>+		/* Returns -ENOTBLK in case of a page invalidation failure for writes.*/
>+		/* The callers needs to fall back to buffered I/O in this case. */
>+		ret = 0;
>+	}
>+
>+	if (ret >= 0 && iov_iter_count(from)) {
>+		loff_t offset = iocb->ki_pos, endbyte;
>+
>+		iocb->ki_flags &= ~IOCB_DIRECT;
>+		err = iomap_file_buffered_write(iocb, from, &ntfs_iomap_ops,
>+						&ntfs_iomap_folio_ops, NULL);
>+		if (err < 0) {
>+			ret = err;
>+			goto out;
>+		}
>+
>+		/*
>+		* We need to ensure that the pages within the page cache for
>+		* the range covered by this I/O are written to disk and
>+		* invalidated. This is in attempt to preserve the expected
>+		* direct I/O semantics in the case we fallback to buffered I/O
>+		* to complete off the I/O request.
>+		*/
>+		ret += err;
>+		endbyte = offset + err - 1;
>+		err = filemap_write_and_wait_range(inode->i_mapping, offset,
>+						   endbyte);
>+		if (err) {
>+			ret = err;
>+			goto out;
>+		}
>+
>+		invalidate_mapping_pages(inode->i_mapping, offset >> PAGE_SHIFT,
>+					 endbyte >> PAGE_SHIFT);
>+	}
>
> out:
> 	inode_unlock(inode);
>
>-	if (ret > 0)
>-		ret = generic_write_sync(iocb, ret);
>-
> 	return ret;
> }
>
>@@ -1359,6 +1359,8 @@ int ntfs_file_open(struct inode *inode, struct file *file)
> #endif
> 	}
>
>+	file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
>+
> 	return generic_file_open(inode, file);
> }
>
>@@ -1408,16 +1410,30 @@ int ntfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> 	if (unlikely(is_bad_ni(ni)))
> 		return -EINVAL;
>
>-	err = fiemap_prep(inode, fieinfo, start, &len, ~FIEMAP_FLAG_XATTR);
>-	if (err)
>-		return err;
>+	if (is_compressed(ni)) {
>+		/* Unfortunately cp -r incorrectly treats compressed clusters. */
>+		ntfs_inode_warn(inode,
>+				"fiemap is not supported for compressed file");
>+		return -EOPNOTSUPP;
>+	}
>
>-	ni_lock(ni);
>+	if (S_ISDIR(inode->i_mode)) {
>+		/* TODO: add support for dirs (ATTR_ALLOC). */
>+		ntfs_inode_warn(inode,
>+				"fiemap is not supported for directories");
>+		return -EOPNOTSUPP;
>+	}
>
>-	err = ni_fiemap(ni, fieinfo, start, len);
>+	if (fieinfo->fi_flags & FIEMAP_FLAG_XATTR) {
>+		ntfs_inode_warn(inode, "fiemap(xattr) is not supported");
>+		return -EOPNOTSUPP;
>+	}
>
>-	ni_unlock(ni);
>+	inode_lock_shared(inode);
>+
>+	err = iomap_fiemap(inode, fieinfo, start, len, &ntfs_iomap_ops);
>
>+	inode_unlock_shared(inode);
> 	return err;
> }
>
>@@ -1463,7 +1479,7 @@ int ntfs_file_fsync(struct file *file, loff_t start, loff_t end, int datasync)
>
> 	if (!ret) {
> 		ntfs_set_state(sbi, NTFS_DIRTY_CLEAR);
>-		ntfs_update_mftmirr(sbi, false);
>+		ntfs_update_mftmirr(sbi);
> 	}
>
> 	err = sync_blockdev(sb->s_bdev);
>diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
>index 03dcb66b5f6c..0dc28815331e 100644
>--- a/fs/ntfs3/frecord.c
>+++ b/fs/ntfs3/frecord.c
>@@ -1850,183 +1850,11 @@ enum REPARSE_SIGN ni_parse_reparse(struct ntfs_inode *ni, struct ATTRIB *attr,
> 	return REPARSE_LINK;
> }
>
>-/*
>- * ni_fiemap - Helper for file_fiemap().
>- *
>- * Assumed ni_lock.
>- * TODO: Less aggressive locks.
>- */
>-int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
>-	      __u64 vbo, __u64 len)
>-{
>-	int err = 0;
>-	struct ntfs_sb_info *sbi = ni->mi.sbi;
>-	u8 cluster_bits = sbi->cluster_bits;
>-	struct runs_tree run;
>-	struct ATTRIB *attr;
>-	CLST vcn = vbo >> cluster_bits;
>-	CLST lcn, clen;
>-	u64 valid = ni->i_valid;
>-	u64 lbo, bytes;
>-	u64 end, alloc_size;
>-	size_t idx = -1;
>-	u32 flags;
>-	bool ok;
>-
>-	run_init(&run);
>-	if (S_ISDIR(ni->vfs_inode.i_mode)) {
>-		attr = ni_find_attr(ni, NULL, NULL, ATTR_ALLOC, I30_NAME,
>-				    ARRAY_SIZE(I30_NAME), NULL, NULL);
>-	} else {
>-		attr = ni_find_attr(ni, NULL, NULL, ATTR_DATA, NULL, 0, NULL,
>-				    NULL);
>-		if (!attr) {
>-			err = -EINVAL;
>-			goto out;
>-		}
>-		if (is_attr_compressed(attr)) {
>-			/* Unfortunately cp -r incorrectly treats compressed clusters. */
>-			err = -EOPNOTSUPP;
>-			ntfs_inode_warn(
>-				&ni->vfs_inode,
>-				"fiemap is not supported for compressed file (cp -r)");
>-			goto out;
>-		}
>-	}
>-
>-	if (!attr || !attr->non_res) {
>-		err = fiemap_fill_next_extent(
>-			fieinfo, 0, 0,
>-			attr ? le32_to_cpu(attr->res.data_size) : 0,
>-			FIEMAP_EXTENT_DATA_INLINE | FIEMAP_EXTENT_LAST |
>-				FIEMAP_EXTENT_MERGED);
>-		goto out;
>-	}
>-
>-	end = vbo + len;
>-	alloc_size = le64_to_cpu(attr->nres.alloc_size);
>-	if (end > alloc_size)
>-		end = alloc_size;
>-
>-	while (vbo < end) {
>-		if (idx == -1) {
>-			ok = run_lookup_entry(&run, vcn, &lcn, &clen, &idx);
>-		} else {
>-			CLST vcn_next = vcn;
>-
>-			ok = run_get_entry(&run, ++idx, &vcn, &lcn, &clen) &&
>-			     vcn == vcn_next;
>-			if (!ok)
>-				vcn = vcn_next;
>-		}
>-
>-		if (!ok) {
>-			err = attr_load_runs_vcn(ni, attr->type,
>-						 attr_name(attr),
>-						 attr->name_len, &run, vcn);
>-
>-			if (err)
>-				break;
>-
>-			ok = run_lookup_entry(&run, vcn, &lcn, &clen, &idx);
>-
>-			if (!ok) {
>-				err = -EINVAL;
>-				break;
>-			}
>-		}
>-
>-		if (!clen) {
>-			err = -EINVAL; // ?
>-			break;
>-		}
>-
>-		if (lcn == SPARSE_LCN) {
>-			vcn += clen;
>-			vbo = (u64)vcn << cluster_bits;
>-			continue;
>-		}
>-
>-		flags = FIEMAP_EXTENT_MERGED;
>-		if (S_ISDIR(ni->vfs_inode.i_mode)) {
>-			;
>-		} else if (is_attr_compressed(attr)) {
>-			CLST clst_data;
>-
>-			err = attr_is_frame_compressed(ni, attr,
>-						       vcn >> attr->nres.c_unit,
>-						       &clst_data, &run);
>-			if (err)
>-				break;
>-			if (clst_data < NTFS_LZNT_CLUSTERS)
>-				flags |= FIEMAP_EXTENT_ENCODED;
>-		} else if (is_attr_encrypted(attr)) {
>-			flags |= FIEMAP_EXTENT_DATA_ENCRYPTED;
>-		}
>-
>-		vbo = (u64)vcn << cluster_bits;
>-		bytes = (u64)clen << cluster_bits;
>-		lbo = (u64)lcn << cluster_bits;
>-
>-		vcn += clen;
>-
>-		if (vbo + bytes >= end)
>-			bytes = end - vbo;
>-
>-		if (vbo + bytes <= valid) {
>-			;
>-		} else if (vbo >= valid) {
>-			flags |= FIEMAP_EXTENT_UNWRITTEN;
>-		} else {
>-			/* vbo < valid && valid < vbo + bytes */
>-			u64 dlen = valid - vbo;
>-
>-			if (vbo + dlen >= end)
>-				flags |= FIEMAP_EXTENT_LAST;
>-
>-			err = fiemap_fill_next_extent(fieinfo, vbo, lbo, dlen,
>-						      flags);
>-
>-			if (err < 0)
>-				break;
>-			if (err == 1) {
>-				err = 0;
>-				break;
>-			}
>-
>-			vbo = valid;
>-			bytes -= dlen;
>-			if (!bytes)
>-				continue;
>-
>-			lbo += dlen;
>-			flags |= FIEMAP_EXTENT_UNWRITTEN;
>-		}
>-
>-		if (vbo + bytes >= end)
>-			flags |= FIEMAP_EXTENT_LAST;
>-
>-		err = fiemap_fill_next_extent(fieinfo, vbo, lbo, bytes, flags);
>-		if (err < 0)
>-			break;
>-		if (err == 1) {
>-			err = 0;
>-			break;
>-		}
>-
>-		vbo += bytes;
>-	}
>-
>-out:
>-	run_close(&run);
>-	return err;
>-}
>-
> static struct page *ntfs_lock_new_page(struct address_space *mapping,
>-		pgoff_t index, gfp_t gfp)
>+				       pgoff_t index, gfp_t gfp)
> {
>-	struct folio *folio = __filemap_get_folio(mapping, index,
>-			FGP_LOCK | FGP_ACCESSED | FGP_CREAT, gfp);
>+	struct folio *folio = __filemap_get_folio(
>+		mapping, index, FGP_LOCK | FGP_ACCESSED | FGP_CREAT, gfp);
> 	struct page *page;
>
> 	if (IS_ERR(folio))
>@@ -2107,7 +1935,9 @@ int ni_read_folio_cmpr(struct ntfs_inode *ni, struct folio *folio)
> 		pages[i] = pg;
> 	}
>
>+	ni_lock(ni);
> 	err = ni_read_frame(ni, frame_vbo, pages, pages_per_frame, 0);
>+	ni_unlock(ni);
>
> out1:
> 	for (i = 0; i < pages_per_frame; i++) {
>@@ -2184,7 +2014,7 @@ int ni_decompress_file(struct ntfs_inode *ni)
>
> 		for (vcn = vbo >> sbi->cluster_bits; vcn < end; vcn += clen) {
> 			err = attr_data_get_block(ni, vcn, cend - vcn, &lcn,
>-						  &clen, &new, false);
>+						  &clen, &new, false, NULL);
> 			if (err)
> 				goto out;
> 		}
>@@ -3015,7 +2845,8 @@ loff_t ni_seek_data_or_hole(struct ntfs_inode *ni, loff_t offset, bool data)
>
> 	/* Enumerate all fragments. */
> 	for (vcn = offset >> cluster_bits;; vcn += clen) {
>-		err = attr_data_get_block(ni, vcn, 1, &lcn, &clen, NULL, false);
>+		err = attr_data_get_block(ni, vcn, 1, &lcn, &clen, NULL, false,
>+					  NULL);
> 		if (err) {
> 			return err;
> 		}
>diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
>index ee24ef0dd725..464d661d9694 100644
>--- a/fs/ntfs3/fslog.c
>+++ b/fs/ntfs3/fslog.c
>@@ -5130,7 +5130,7 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
>
> undo_action_done:
>
>-	ntfs_update_mftmirr(sbi, 0);
>+	ntfs_update_mftmirr(sbi);
>
> 	sbi->flags &= ~NTFS_FLAGS_NEED_REPLAY;
>
>diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
>index ff0b2595f32a..e9c39c62aea4 100644
>--- a/fs/ntfs3/fsntfs.c
>+++ b/fs/ntfs3/fsntfs.c
>@@ -843,9 +843,8 @@ int ntfs_refresh_zone(struct ntfs_sb_info *sbi)
> /*
>  * ntfs_update_mftmirr - Update $MFTMirr data.
>  */
>-void ntfs_update_mftmirr(struct ntfs_sb_info *sbi, int wait)
>+void ntfs_update_mftmirr(struct ntfs_sb_info *sbi)
> {
>-	int err;
> 	struct super_block *sb = sbi->sb;
> 	u32 blocksize, bytes;
> 	sector_t block1, block2;
>@@ -884,12 +883,7 @@ void ntfs_update_mftmirr(struct ntfs_sb_info *sbi, int wait)
>
> 		put_bh(bh1);
> 		bh1 = NULL;
>-
>-		err = wait ? sync_dirty_buffer(bh2) : 0;
>-
> 		put_bh(bh2);
>-		if (err)
>-			return;
> 	}
>
> 	sbi->flags &= ~NTFS_FLAGS_MFTMIRR;
>@@ -1357,9 +1351,7 @@ int ntfs_get_bh(struct ntfs_sb_info *sbi, const struct runs_tree *run, u64 vbo,
> 					err = -ENOMEM;
> 					goto out;
> 				}
>-
> 				wait_on_buffer(bh);
>-
> 				lock_buffer(bh);
> 				if (!buffer_uptodate(bh)) {
> 					memset(bh->b_data, 0, blocksize);
>diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
>index ace9873adaae..b969ad7c3258 100644
>--- a/fs/ntfs3/inode.c
>+++ b/fs/ntfs3/inode.c
>@@ -12,6 +12,7 @@
> #include <linux/nls.h>
> #include <linux/uio.h>
> #include <linux/writeback.h>
>+#include <linux/iomap.h>
>
> #include "debug.h"
> #include "ntfs.h"
>@@ -166,9 +167,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
>
> 		std5 = Add2Ptr(attr, roff);
>
>-#ifdef STATX_BTIME
> 		nt2kernel(std5->cr_time, &ni->i_crtime);
>-#endif
> 		nt2kernel(std5->a_time, &ts);
> 		inode_set_atime_to_ts(inode, ts);
> 		nt2kernel(std5->c_time, &ts);
>@@ -555,167 +554,96 @@ struct inode *ntfs_iget5(struct super_block *sb, const struct MFT_REF *ref,
> 	return inode;
> }
>
>-enum get_block_ctx {
>-	GET_BLOCK_GENERAL = 0,
>-	GET_BLOCK_WRITE_BEGIN = 1,
>-	GET_BLOCK_DIRECT_IO_R = 2,
>-	GET_BLOCK_DIRECT_IO_W = 3,
>-	GET_BLOCK_BMAP = 4,
>-};
>-
>-static noinline int ntfs_get_block_vbo(struct inode *inode, u64 vbo,
>-				       struct buffer_head *bh, int create,
>-				       enum get_block_ctx ctx)
>+static sector_t ntfs_bmap(struct address_space *mapping, sector_t block)
> {
>-	struct super_block *sb = inode->i_sb;
>-	struct ntfs_sb_info *sbi = sb->s_fs_info;
>-	struct ntfs_inode *ni = ntfs_i(inode);
>-	struct folio *folio = bh->b_folio;
>-	u8 cluster_bits = sbi->cluster_bits;
>-	u32 block_size = sb->s_blocksize;
>-	u64 bytes, lbo, valid;
>-	u32 off;
>-	int err;
>-	CLST vcn, lcn, len;
>-	bool new;
>-
>-	/* Clear previous state. */
>-	clear_buffer_new(bh);
>-	clear_buffer_uptodate(bh);
>-
>-	if (is_resident(ni)) {
>-		bh->b_blocknr = RESIDENT_LCN;
>-		bh->b_size = block_size;
>-		if (!folio) {
>-			/* direct io (read) or bmap call */
>-			err = 0;
>-		} else {
>-			ni_lock(ni);
>-			err = attr_data_read_resident(ni, folio);
>-			ni_unlock(ni);
>+	return iomap_bmap(mapping, block, &ntfs_iomap_ops);
>+}
>
>-			if (!err)
>-				set_buffer_uptodate(bh);
>+static void ntfs_iomap_read_end_io(struct bio *bio)
>+{
>+	int error = blk_status_to_errno(bio->bi_status);
>+	struct folio_iter fi;
>+
>+	bio_for_each_folio_all(fi, bio) {
>+		struct folio *folio = fi.folio;
>+		struct inode *inode = folio->mapping->host;
>+		struct ntfs_inode *ni = ntfs_i(inode);
>+		u64 valid = ni->i_valid;
>+		u32 f_size = folio_size(folio);
>+		loff_t f_pos = folio_pos(folio);
>+
>+
>+		if (valid < f_pos + f_size) {
>+			u32 z_from = valid <= f_pos ?
>+					     0 :
>+					     offset_in_folio(folio, valid);
>+			/* The only thing ntfs_iomap_read_end_io used for. */
>+			folio_zero_segment(folio, z_from, f_size);
> 		}
>-		return err;
>-	}
>-
>-	vcn = vbo >> cluster_bits;
>-	off = vbo & sbi->cluster_mask;
>-	new = false;
>-
>-	err = attr_data_get_block(ni, vcn, 1, &lcn, &len, create ? &new : NULL,
>-				  create && sbi->cluster_size > PAGE_SIZE);
>-	if (err)
>-		goto out;
>-
>-	if (!len)
>-		return 0;
>-
>-	bytes = ((u64)len << cluster_bits) - off;
>
>-	if (lcn >= sbi->used.bitmap.nbits) {
>-		/* This case includes resident/compressed/sparse. */
>-		if (!create) {
>-			if (bh->b_size > bytes)
>-				bh->b_size = bytes;
>-			return 0;
>-		}
>-		WARN_ON(1);
>+		iomap_finish_folio_read(folio, fi.offset, fi.length, error);
> 	}
>+	bio_put(bio);
>+}
>
>-	if (new)
>-		set_buffer_new(bh);
>-
>-	lbo = ((u64)lcn << cluster_bits) + off;
>-
>-	set_buffer_mapped(bh);
>-	bh->b_bdev = sb->s_bdev;
>-	bh->b_blocknr = lbo >> sb->s_blocksize_bits;
>-
>-	valid = ni->i_valid;
>-
>-	if (ctx == GET_BLOCK_DIRECT_IO_W) {
>-		/* ntfs_direct_IO will update ni->i_valid. */
>-		if (vbo >= valid)
>-			set_buffer_new(bh);
>-	} else if (create) {
>-		/* Normal write. */
>-		if (bytes > bh->b_size)
>-			bytes = bh->b_size;
>-
>-		if (vbo >= valid)
>-			set_buffer_new(bh);
>-
>-		if (vbo + bytes > valid) {
>-			ni->i_valid = vbo + bytes;
>-			mark_inode_dirty(inode);
>-		}
>-	} else if (vbo >= valid) {
>-		/* Read out of valid data. */
>-		clear_buffer_mapped(bh);
>-	} else if (vbo + bytes <= valid) {
>-		/* Normal read. */
>-	} else if (vbo + block_size <= valid) {
>-		/* Normal short read. */
>-		bytes = block_size;
>-	} else {
>+/*
>+ * Copied from iomap/bio.c.
>+ */
>+static int ntfs_iomap_bio_read_folio_range(const struct iomap_iter *iter,
>+					   struct iomap_read_folio_ctx *ctx,
>+					   size_t plen)
>+{
>+	struct folio *folio = ctx->cur_folio;
>+	const struct iomap *iomap = &iter->iomap;
>+	loff_t pos = iter->pos;
>+	size_t poff = offset_in_folio(folio, pos);
>+	loff_t length = iomap_length(iter);
>+	sector_t sector;
>+	struct bio *bio = ctx->read_ctx;
>+
>+	sector = iomap_sector(iomap, pos);
>+	if (!bio || bio_end_sector(bio) != sector ||
>+	    !bio_add_folio(bio, folio, plen, poff)) {
>+		gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
>+		gfp_t orig_gfp = gfp;
>+		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
>+
>+		if (bio)
>+			submit_bio(bio);
>+
>+		if (ctx->rac) /* same as readahead_gfp_mask */
>+			gfp |= __GFP_NORETRY | __GFP_NOWARN;
>+		bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs), REQ_OP_READ,
>+				gfp);
> 		/*
>-		 * Read across valid size: vbo < valid && valid < vbo + block_size
>+		 * If the bio_alloc fails, try it again for a single page to
>+		 * avoid having to deal with partial page reads.  This emulates
>+		 * what do_mpage_read_folio does.
> 		 */
>-		bytes = block_size;
>-
>-		if (folio) {
>-			u32 voff = valid - vbo;
>-
>-			bh->b_size = block_size;
>-			off = vbo & (PAGE_SIZE - 1);
>-			folio_set_bh(bh, folio, off);
>-
>-			if (bh_read(bh, 0) < 0) {
>-				err = -EIO;
>-				goto out;
>-			}
>-			folio_zero_segment(folio, off + voff, off + block_size);
>-		}
>-	}
>-
>-	if (bh->b_size > bytes)
>-		bh->b_size = bytes;
>-
>-#ifndef __LP64__
>-	if (ctx == GET_BLOCK_DIRECT_IO_W || ctx == GET_BLOCK_DIRECT_IO_R) {
>-		static_assert(sizeof(size_t) < sizeof(loff_t));
>-		if (bytes > 0x40000000u)
>-			bh->b_size = 0x40000000u;
>+		if (!bio)
>+			bio = bio_alloc(iomap->bdev, 1, REQ_OP_READ, orig_gfp);
>+		if (ctx->rac)
>+			bio->bi_opf |= REQ_RAHEAD;
>+		bio->bi_iter.bi_sector = sector;
>+		bio->bi_end_io = ntfs_iomap_read_end_io;
>+		bio_add_folio_nofail(bio, folio, plen, poff);
>+		ctx->read_ctx = bio;
> 	}
>-#endif
>-
> 	return 0;
>-
>-out:
>-	return err;
> }
>
>-int ntfs_get_block(struct inode *inode, sector_t vbn,
>-		   struct buffer_head *bh_result, int create)
>+static void ntfs_iomap_bio_submit_read(struct iomap_read_folio_ctx *ctx)
> {
>-	return ntfs_get_block_vbo(inode, (u64)vbn << inode->i_blkbits,
>-				  bh_result, create, GET_BLOCK_GENERAL);
>-}
>+	struct bio *bio = ctx->read_ctx;
>
>-static int ntfs_get_block_bmap(struct inode *inode, sector_t vsn,
>-			       struct buffer_head *bh_result, int create)
>-{
>-	return ntfs_get_block_vbo(inode,
>-				  (u64)vsn << inode->i_sb->s_blocksize_bits,
>-				  bh_result, create, GET_BLOCK_BMAP);
>+	if (bio)
>+		submit_bio(bio);
> }
>
>-static sector_t ntfs_bmap(struct address_space *mapping, sector_t block)
>-{
>-	return generic_block_bmap(mapping, block, ntfs_get_block_bmap);
>-}
>+static const struct iomap_read_ops ntfs_iomap_bio_read_ops = {
>+	.read_folio_range = ntfs_iomap_bio_read_folio_range,
>+	.submit_read = ntfs_iomap_bio_submit_read,
>+};
>
> static int ntfs_read_folio(struct file *file, struct folio *folio)
> {
>@@ -724,6 +652,10 @@ static int ntfs_read_folio(struct file *file, struct folio *folio)
> 	struct inode *inode = mapping->host;
> 	struct ntfs_inode *ni = ntfs_i(inode);
> 	loff_t vbo = folio_pos(folio);
>+	struct iomap_read_folio_ctx ctx = {
>+		.cur_folio = folio,
>+		.ops = &ntfs_iomap_bio_read_ops,
>+	};
>
> 	if (unlikely(is_bad_ni(ni))) {
> 		folio_unlock(folio);
>@@ -737,25 +669,14 @@ static int ntfs_read_folio(struct file *file, struct folio *folio)
> 		return 0;
> 	}
>
>-	if (is_resident(ni)) {
>-		ni_lock(ni);
>-		err = attr_data_read_resident(ni, folio);
>-		ni_unlock(ni);
>-		if (err != E_NTFS_NONRESIDENT) {
>-			folio_unlock(folio);
>-			return err;
>-		}
>-	}
>-
> 	if (is_compressed(ni)) {
>-		ni_lock(ni);
>+		/* ni_lock is taken inside ni_read_folio_cmpr after page locks */
> 		err = ni_read_folio_cmpr(ni, folio);
>-		ni_unlock(ni);
> 		return err;
> 	}
>
>-	/* Normal + sparse files. */
>-	return mpage_read_folio(folio, ntfs_get_block);
>+	iomap_read_folio(&ntfs_iomap_ops, &ctx);
>+	return 0;
> }
>
> static void ntfs_readahead(struct readahead_control *rac)
>@@ -763,8 +684,10 @@ static void ntfs_readahead(struct readahead_control *rac)
> 	struct address_space *mapping = rac->mapping;
> 	struct inode *inode = mapping->host;
> 	struct ntfs_inode *ni = ntfs_i(inode);
>-	u64 valid;
>-	loff_t pos;
>+	struct iomap_read_folio_ctx ctx = {
>+		.ops = &ntfs_iomap_bio_read_ops,
>+		.rac = rac,
>+	};
>
> 	if (is_resident(ni)) {
> 		/* No readahead for resident. */
>@@ -776,115 +699,281 @@ static void ntfs_readahead(struct readahead_control *rac)
> 		return;
> 	}
>
>-	valid = ni->i_valid;
>-	pos = readahead_pos(rac);
>+	iomap_readahead(&ntfs_iomap_ops, &ctx);
>+}
>
>-	if (valid < i_size_read(inode) && pos <= valid &&
>-	    valid < pos + readahead_length(rac)) {
>-		/* Range cross 'valid'. Read it page by page. */
>-		return;
>+int ntfs_set_size(struct inode *inode, u64 new_size)
>+{
>+	struct super_block *sb = inode->i_sb;
>+	struct ntfs_sb_info *sbi = sb->s_fs_info;
>+	struct ntfs_inode *ni = ntfs_i(inode);
>+	int err;
>+
>+	/* Check for maximum file size. */
>+	if (is_sparsed(ni) || is_compressed(ni)) {
>+		if (new_size > sbi->maxbytes_sparse) {
>+			return -EFBIG;
>+		}
>+	} else if (new_size > sbi->maxbytes) {
>+		return -EFBIG;
> 	}
>
>-	mpage_readahead(rac, ntfs_get_block);
>-}
>+	ni_lock(ni);
>+	down_write(&ni->file.run_lock);
>
>-static int ntfs_get_block_direct_IO_R(struct inode *inode, sector_t iblock,
>-				      struct buffer_head *bh_result, int create)
>-{
>-	return ntfs_get_block_vbo(inode, (u64)iblock << inode->i_blkbits,
>-				  bh_result, create, GET_BLOCK_DIRECT_IO_R);
>-}
>+	err = attr_set_size(ni, ATTR_DATA, NULL, 0, &ni->file.run, new_size,
>+			    &ni->i_valid, true, NULL);
>
>-static int ntfs_get_block_direct_IO_W(struct inode *inode, sector_t iblock,
>-				      struct buffer_head *bh_result, int create)
>-{
>-	return ntfs_get_block_vbo(inode, (u64)iblock << inode->i_blkbits,
>-				  bh_result, create, GET_BLOCK_DIRECT_IO_W);
>+	if (!err) {
>+		i_size_write(inode, new_size);
>+		mark_inode_dirty(inode);
>+	}
>+
>+	up_write(&ni->file.run_lock);
>+	ni_unlock(ni);
>+
>+	return err;
> }
>
>-static ssize_t ntfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>+/*
>+ * Function to get mapping vbo -> lbo.
>+ * used with:
>+ * - iomap_zero_range
>+ * - iomap_truncate_page
>+ * - iomap_dio_rw
>+ * - iomap_file_buffered_write
>+ * - iomap_bmap
>+ * - iomap_fiemap
>+ * - iomap_bio_read_folio
>+ * - iomap_bio_readahead
>+ */
>+static int ntfs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>+			    unsigned int flags, struct iomap *iomap,
>+			    struct iomap *srcmap)
> {
>-	struct file *file = iocb->ki_filp;
>-	struct address_space *mapping = file->f_mapping;
>-	struct inode *inode = mapping->host;
> 	struct ntfs_inode *ni = ntfs_i(inode);
>-	loff_t vbo = iocb->ki_pos;
>-	loff_t end;
>-	int wr = iov_iter_rw(iter) & WRITE;
>-	size_t iter_count = iov_iter_count(iter);
>-	loff_t valid;
>-	ssize_t ret;
>+	struct ntfs_sb_info *sbi = ni->mi.sbi;
>+	u8 cluster_bits = sbi->cluster_bits;
>+	CLST vcn = offset >> cluster_bits;
>+	u32 off = offset & sbi->cluster_mask;
>+	bool rw = flags & IOMAP_WRITE;
>+	loff_t endbyte = offset + length;
>+	void *res = NULL;
>+	int err;
>+	CLST lcn, clen, clen_max;
>+	bool new_clst = false;
>+	if (unlikely(ntfs3_forced_shutdown(sbi->sb)))
>+		return -EIO;
>
>-	if (is_resident(ni)) {
>-		/* Switch to buffered write. */
>-		ret = 0;
>-		goto out;
>+	if ((flags & IOMAP_REPORT) && offset > ntfs_get_maxbytes(ni)) {
>+		/* called from fiemap/bmap. */
>+		return -EINVAL;
> 	}
>-	if (is_compressed(ni)) {
>-		ret = 0;
>-		goto out;
>+
>+	clen_max = rw ? (bytes_to_cluster(sbi, endbyte) - vcn) : 1;
>+
>+	err = attr_data_get_block(
>+		ni, vcn, clen_max, &lcn, &clen, rw ? &new_clst : NULL,
>+		flags == IOMAP_WRITE && (off || (endbyte & sbi->cluster_mask)),
>+		&res);
>+
>+	if (err) {
>+		return err;
> 	}
>
>-	ret = blockdev_direct_IO(iocb, inode, iter,
>-				 wr ? ntfs_get_block_direct_IO_W :
>-				      ntfs_get_block_direct_IO_R);
>+	if (lcn == EOF_LCN) {
>+		/* request out of file. */
>+		if (flags & IOMAP_REPORT) {
>+			/* special code for report. */
>+			return -ENOENT;
>+		}
>
>-	if (ret > 0)
>-		end = vbo + ret;
>-	else if (wr && ret == -EIOCBQUEUED)
>-		end = vbo + iter_count;
>-	else
>-		goto out;
>+		if (rw) {
>+			/* should never be here. */
>+			return -EINVAL;
>+		}
>+		lcn = SPARSE_LCN;
>+	}
>
>-	valid = ni->i_valid;
>-	if (wr) {
>-		if (end > valid && !S_ISBLK(inode->i_mode)) {
>-			ni->i_valid = end;
>-			mark_inode_dirty(inode);
>+	if (lcn == RESIDENT_LCN) {
>+		if (offset >= clen) {
>+			kfree(res);
>+			if (flags & IOMAP_REPORT) {
>+				/* special code for report. */
>+				return -ENOENT;
>+			}
>+			return -EFAULT;
> 		}
>-	} else if (vbo < valid && valid < end) {
>-		/* Fix page. */
>-		iov_iter_revert(iter, end - valid);
>-		iov_iter_zero(end - valid, iter);
>+
>+		iomap->private = iomap->inline_data = res;
>+		iomap->type = IOMAP_INLINE;
>+		iomap->offset = 0;
>+		iomap->length = clen; /* resident size in bytes. */
>+		iomap->flags = 0;
>+		return 0;
> 	}
>
>-out:
>-	return ret;
>+	if (!clen) {
>+		/* broken file? */
>+		return -EINVAL;
>+	}
>+
>+	if (lcn == COMPRESSED_LCN) {
>+		/* should never be here. */
>+		return -EOPNOTSUPP;
>+	}
>+
>+	iomap->flags = new_clst ? IOMAP_F_NEW : 0;
>+	iomap->bdev = inode->i_sb->s_bdev;
>+
>+	/* Translate clusters into bytes. */
>+	iomap->offset = offset;
>+	iomap->addr = ((loff_t)lcn << cluster_bits) + off;
>+	iomap->length = ((loff_t)clen << cluster_bits) - off;
>+	if (length && iomap->length > length)
>+		iomap->length = length;
>+	else
>+		endbyte = offset + iomap->length;
>+
>+	if (lcn == SPARSE_LCN) {
>+		iomap->addr = IOMAP_NULL_ADDR;
>+		iomap->type = IOMAP_HOLE;
>+	} else if (endbyte <= ni->i_valid) {
>+		iomap->type = IOMAP_MAPPED;
>+	} else if (offset < ni->i_valid) {
>+		iomap->type = IOMAP_MAPPED;
>+		if (flags & IOMAP_REPORT)
>+			iomap->length = ni->i_valid - offset;
>+	} else if (rw || (flags & IOMAP_ZERO)) {
>+		iomap->type = IOMAP_MAPPED;
>+	} else {
>+		iomap->type = IOMAP_UNWRITTEN;
>+	}
>+
>+	if ((flags & IOMAP_ZERO) && iomap->type == IOMAP_MAPPED) {
>+		/* Avoid too large requests. */
>+		u32 tail;
>+		u32 off_a = iomap->addr & (PAGE_SIZE - 1);
>+		if (off_a)
>+			tail = PAGE_SIZE - off_a;
>+		else
>+			tail = PAGE_SIZE;
>+
>+		if (iomap->length > tail)
>+			iomap->length = tail;
>+	}
>+
>+	return 0;
> }
>
>-int ntfs_set_size(struct inode *inode, u64 new_size)
>+static int ntfs_iomap_end(struct inode *inode, loff_t pos, loff_t length,
>+			  ssize_t written, unsigned int flags,
>+			  struct iomap *iomap)
> {
>-	struct super_block *sb = inode->i_sb;
>-	struct ntfs_sb_info *sbi = sb->s_fs_info;
>+	int err = 0;
> 	struct ntfs_inode *ni = ntfs_i(inode);
>-	int err;
>+	loff_t endbyte = pos + written;
>
>-	/* Check for maximum file size. */
>-	if (is_sparsed(ni) || is_compressed(ni)) {
>-		if (new_size > sbi->maxbytes_sparse) {
>-			err = -EFBIG;
>-			goto out;
>-		}
>-	} else if (new_size > sbi->maxbytes) {
>-		err = -EFBIG;
>-		goto out;
>-	}
>+	if ((flags & IOMAP_WRITE) || (flags & IOMAP_ZERO)) {
>+		if (iomap->type == IOMAP_INLINE) {
>+			u32 data_size;
>+			struct ATTRIB *attr;
>+			struct mft_inode *mi;
>
>-	ni_lock(ni);
>-	down_write(&ni->file.run_lock);
>+			attr = ni_find_attr(ni, NULL, NULL, ATTR_DATA, NULL, 0,
>+					    NULL, &mi);
>+			if (!attr || attr->non_res) {
>+				err = -EINVAL;
>+				goto out;
>+			}
>
>-	err = attr_set_size(ni, ATTR_DATA, NULL, 0, &ni->file.run, new_size,
>-			    &ni->i_valid, true, NULL);
>+			data_size = le32_to_cpu(attr->res.data_size);
>+			if (!(pos < data_size && endbyte <= data_size)) {
>+				err = -EINVAL;
>+				goto out;
>+			}
>
>-	up_write(&ni->file.run_lock);
>-	ni_unlock(ni);
>+			/* Update resident data. */
>+			memcpy(resident_data(attr) + pos,
>+			       iomap_inline_data(iomap, pos), written);
>+			mi->dirty = true;
>+			ni->i_valid = data_size;
>+		} else if (ni->i_valid < endbyte) {
>+			ni->i_valid = endbyte;
>+			mark_inode_dirty(inode);
>+		}
>+	}
>
>-	mark_inode_dirty(inode);
>+	if ((flags & IOMAP_ZERO) && iomap->type == IOMAP_MAPPED) {
>+		balance_dirty_pages_ratelimited(inode->i_mapping);
>+		cond_resched();
>+	}
>
> out:
>+	if (iomap->type == IOMAP_INLINE) {
>+		kfree(iomap->private);
>+		iomap->private = NULL;
>+	}
>+
> 	return err;
> }
>
>+/*
>+ * write_begin + put_folio + write_end.
>+ * iomap_zero_range
>+ * iomap_truncate_page
>+ * iomap_file_buffered_write
>+ */
>+static void ntfs_iomap_put_folio(struct inode *inode, loff_t pos,
>+				 unsigned int len, struct folio *folio)
>+{
>+	struct ntfs_inode *ni = ntfs_i(inode);
>+	loff_t end = pos + len;
>+	u32 f_size = folio_size(folio);
>+	loff_t f_pos = folio_pos(folio);
>+	loff_t f_end = f_pos + f_size;
>+
>+	if (ni->i_valid < end && end < f_end) {
>+		/* zero range [end - f_end). */
>+		/* The only thing ntfs_iomap_put_folio used for. */
>+		folio_zero_segment(folio, offset_in_folio(folio, end), f_size);
>+	}
>+	folio_unlock(folio);
>+	folio_put(folio);
>+}
>+
>+static ssize_t ntfs_writeback_range(struct iomap_writepage_ctx *wpc,
>+				    struct folio *folio, u64 offset,
>+				    unsigned int len, u64 end_pos)
>+{
>+	struct iomap *iomap = &wpc->iomap;
>+	struct inode *inode = wpc->inode;
>+
>+	/* Check iomap position. */
>+	if (!(iomap->offset <= offset &&
>+	      offset < iomap->offset + iomap->length)) {
>+		int err;
>+		struct ntfs_sb_info *sbi = ntfs_sb(inode->i_sb);
>+		loff_t i_size_up = ntfs_up_cluster(sbi, inode->i_size);
>+		loff_t len_max = i_size_up - offset;
>+
>+		err = ntfs_iomap_begin(inode, offset, len_max, IOMAP_WRITE,
>+				       iomap, NULL);
>+		if (err) {
>+			ntfs_set_state(sbi, NTFS_DIRTY_DIRTY);
>+			return err;
>+		}
>+	}
>+
>+	return iomap_add_to_ioend(wpc, folio, offset, end_pos, len);
>+}
>+
>+
>+const struct iomap_writeback_ops ntfs_writeback_ops = {
>+	.writeback_range = ntfs_writeback_range,
>+	.writeback_submit = iomap_ioend_writeback_submit,
>+};
>+
> static int ntfs_resident_writepage(struct folio *folio,
> 				   struct writeback_control *wbc)
> {
>@@ -912,40 +1001,15 @@ static int ntfs_resident_writepage(struct folio *folio,
>
> static int ntfs_writepages(struct address_space *mapping,
> 			   struct writeback_control *wbc)
>-{
>-	struct inode *inode = mapping->host;
>-
>-	/* Avoid any operation if inode is bad. */
>-	if (unlikely(is_bad_ni(ntfs_i(inode))))
>-		return -EINVAL;
>-
>-	if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
>-		return -EIO;
>-
>-	if (is_resident(ntfs_i(inode))) {
>-		struct folio *folio = NULL;
>-		int error;
>-
>-		while ((folio = writeback_iter(mapping, wbc, folio, &error)))
>-			error = ntfs_resident_writepage(folio, wbc);
>-		return error;

With the above ^

error: variable 'folio' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
  1021 |         if (is_resident(ni)) {
       |             ^~~~~~~~~~~~~~~
/builds/linux/fs/ntfs3/inode.c:1024:48: note: uninitialized use occurs here
  1024 |                 while ((folio = writeback_iter(mapping, wbc, folio, &err)))
       |                                                              ^~~~~
/builds/linux/fs/ntfs3/inode.c:1021:2: note: remove the 'if' if its condition is always false
  1021 |         if (is_resident(ni)) {
       |         ^~~~~~~~~~~~~~~~~~~~~~
  1022 |                 struct folio *folio;
       |                 ~~~~~~~~~~~~~~~~~~~~
  1023 | 
  1024 |                 while ((folio = writeback_iter(mapping, wbc, folio, &err)))
       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  1025 |                         err = ntfs_resident_writepage(folio, wbc);
       |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  1026 | 
  1027 |                 return err;
       |                 ~~~~~~~~~~~
  1028 |         }
       |         ~
/builds/linux/fs/ntfs3/inode.c:1022:22: note: initialize the variable 'folio' to silence this warning
  1022 |                 struct folio *folio;
       |                                    ^
       |                                     = NULL

-- 
Thanks,
Sasha

