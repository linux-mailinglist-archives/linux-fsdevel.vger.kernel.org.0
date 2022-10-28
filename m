Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFCF6118B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 19:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiJ1RER (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 13:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiJ1RDz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:03:55 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C6176751;
        Fri, 28 Oct 2022 10:02:22 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 1B1B7218D;
        Fri, 28 Oct 2022 16:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1666976382;
        bh=PM/O9yWZe1oGRmYJjiRyWgrKQ6k0lSNAUmnZBGKHpOU=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=NadQuD2oJM7haqauMfuv2DMoD8b2h88XZ/+DtM+Hx85CHRt8rL6qcbQCC3c3Ni4Dn
         6NrcDiwPDCB9ZRamaY2t0hyX1p+iq/6vP4L0qT+gQREBqvRaLZy3v+yYO43rGIPcnS
         b+UVWOYdEWHNiIyWOSbc/kmhmIkDNhIcusC4OooA=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 28 Oct 2022 20:02:20 +0300
Message-ID: <9aac3e4d-399d-335e-10dc-2742408720f7@paragon-software.com>
Date:   Fri, 28 Oct 2022 20:02:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: [PATCH 02/14] fs/ntfs3: Change new sparse cluster processing
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <fc5957cc-a71b-cfa3-f291-cb63b23800d1@paragon-software.com>
In-Reply-To: <fc5957cc-a71b-cfa3-f291-cb63b23800d1@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove ntfs_sparse_cluster.
Zero clusters in attr_allocate_clusters.
Fixes xfstest generic/263

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/attrib.c  | 176 +++++++++++++++++++++++++++++++--------------
  fs/ntfs3/file.c    | 146 +++++++++----------------------------
  fs/ntfs3/frecord.c |   2 +-
  fs/ntfs3/index.c   |   4 +-
  fs/ntfs3/inode.c   |  12 ++--
  fs/ntfs3/ntfs_fs.h |   7 +-
  6 files changed, 166 insertions(+), 181 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 7c00656151fb..eda83a37a0c3 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -149,7 +149,7 @@ static int run_deallocate_ex(struct ntfs_sb_info *sbi, struct runs_tree *run,
  int attr_allocate_clusters(struct ntfs_sb_info *sbi, struct runs_tree *run,
  			   CLST vcn, CLST lcn, CLST len, CLST *pre_alloc,
  			   enum ALLOCATE_OPT opt, CLST *alen, const size_t fr,
-			   CLST *new_lcn)
+			   CLST *new_lcn, CLST *new_len)
  {
  	int err;
  	CLST flen, vcn0 = vcn, pre = pre_alloc ? *pre_alloc : 0;
@@ -169,20 +169,36 @@ int attr_allocate_clusters(struct ntfs_sb_info *sbi, struct runs_tree *run,
  		if (err)
  			goto out;
  
-		if (new_lcn && vcn == vcn0)
-			*new_lcn = lcn;
+		if (vcn == vcn0) {
+			/* Return the first fragment. */
+			if (new_lcn)
+				*new_lcn = lcn;
+			if (new_len)
+				*new_len = flen;
+		}
  
  		/* Add new fragment into run storage. */
-		if (!run_add_entry(run, vcn, lcn, flen, opt == ALLOCATE_MFT)) {
+		if (!run_add_entry(run, vcn, lcn, flen, opt & ALLOCATE_MFT)) {
  			/* Undo last 'ntfs_look_for_free_space' */
  			mark_as_free_ex(sbi, lcn, len, false);
  			err = -ENOMEM;
  			goto out;
  		}
  
+		if (opt & ALLOCATE_ZERO) {
+			u8 shift = sbi->cluster_bits - SECTOR_SHIFT;
+
+			err = blkdev_issue_zeroout(sbi->sb->s_bdev,
+						   (sector_t)lcn << shift,
+						   (sector_t)flen << shift,
+						   GFP_NOFS, 0);
+			if (err)
+				goto out;
+		}
+
  		vcn += flen;
  
-		if (flen >= len || opt == ALLOCATE_MFT ||
+		if (flen >= len || (opt & ALLOCATE_MFT) ||
  		    (fr && run->count - cnt >= fr)) {
  			*alen = vcn - vcn0;
  			return 0;
@@ -257,7 +273,8 @@ int attr_make_nonresident(struct ntfs_inode *ni, struct ATTRIB *attr,
  		const char *data = resident_data(attr);
  
  		err = attr_allocate_clusters(sbi, run, 0, 0, len, NULL,
-					     ALLOCATE_DEF, &alen, 0, NULL);
+					     ALLOCATE_DEF, &alen, 0, NULL,
+					     NULL);
  		if (err)
  			goto out1;
  
@@ -552,13 +569,13 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
  			/* ~3 bytes per fragment. */
  			err = attr_allocate_clusters(
  				sbi, run, vcn, lcn, to_allocate, &pre_alloc,
-				is_mft ? ALLOCATE_MFT : 0, &alen,
+				is_mft ? ALLOCATE_MFT : ALLOCATE_DEF, &alen,
  				is_mft ? 0
  				       : (sbi->record_size -
  					  le32_to_cpu(rec->used) + 8) /
  							 3 +
  						 1,
-				NULL);
+				NULL, NULL);
  			if (err)
  				goto out;
  		}
@@ -855,8 +872,19 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
  	return err;
  }
  
+/*
+ * attr_data_get_block - Returns 'lcn' and 'len' for given 'vcn'.
+ *
+ * @new == NULL means just to get current mapping for 'vcn'
+ * @new != NULL means allocate real cluster if 'vcn' maps to hole
+ * @zero - zeroout new allocated clusters
+ *
+ *  NOTE:
+ *  - @new != NULL is called only for sparsed or compressed attributes.
+ *  - new allocated clusters are zeroed via blkdev_issue_zeroout.
+ */
  int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
-			CLST *len, bool *new)
+			CLST *len, bool *new, bool zero)
  {
  	int err = 0;
  	struct runs_tree *run = &ni->file.run;
@@ -865,29 +893,27 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
  	struct ATTRIB *attr = NULL, *attr_b;
  	struct ATTR_LIST_ENTRY *le, *le_b;
  	struct mft_inode *mi, *mi_b;
-	CLST hint, svcn, to_alloc, evcn1, next_svcn, asize, end;
+	CLST hint, svcn, to_alloc, evcn1, next_svcn, asize, end, vcn0, alen;
+	unsigned fr;
  	u64 total_size;
-	u32 clst_per_frame;
-	bool ok;
  
  	if (new)
  		*new = false;
  
+	/* Try to find in cache. */
  	down_read(&ni->file.run_lock);
-	ok = run_lookup_entry(run, vcn, lcn, len, NULL);
+	if (!run_lookup_entry(run, vcn, lcn, len, NULL))
+		*len = 0;
  	up_read(&ni->file.run_lock);
  
-	if (ok && (*lcn != SPARSE_LCN || !new)) {
-		/* Normal way. */
-		return 0;
+	if (*len) {
+		if (*lcn != SPARSE_LCN || !new)
+			return 0; /* Fast normal way without allocation. */
+		else if (clen > *len)
+			clen = *len;
  	}
  
-	if (!clen)
-		clen = 1;
-
-	if (ok && clen > *len)
-		clen = *len;
-
+	/* No cluster in cache or we need to allocate cluster in hole. */
  	sbi = ni->mi.sbi;
  	cluster_bits = sbi->cluster_bits;
  
@@ -913,12 +939,6 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
  		goto out;
  	}
  
-	clst_per_frame = 1u << attr_b->nres.c_unit;
-	to_alloc = (clen + clst_per_frame - 1) & ~(clst_per_frame - 1);
-
-	if (vcn + to_alloc > asize)
-		to_alloc = asize - vcn;
-
  	svcn = le64_to_cpu(attr_b->nres.svcn);
  	evcn1 = le64_to_cpu(attr_b->nres.evcn) + 1;
  
@@ -937,36 +957,68 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
  		evcn1 = le64_to_cpu(attr->nres.evcn) + 1;
  	}
  
+	/* Load in cache actual information. */
  	err = attr_load_runs(attr, ni, run, NULL);
  	if (err)
  		goto out;
  
-	if (!ok) {
-		ok = run_lookup_entry(run, vcn, lcn, len, NULL);
-		if (ok && (*lcn != SPARSE_LCN || !new)) {
-			/* Normal way. */
-			err = 0;
-			goto ok;
-		}
+	if (!*len) {
+		if (run_lookup_entry(run, vcn, lcn, len, NULL)) {
+			if (*lcn != SPARSE_LCN || !new)
+				goto ok; /* Slow normal way without allocation. */
  
-		if (!ok && !new) {
-			*len = 0;
-			err = 0;
+			if (clen > *len)
+				clen = *len;
+		} else if (!new) {
+			/* Here we may return -ENOENT.
+			 * In any case caller gets zero length. */
  			goto ok;
  		}
-
-		if (ok && clen > *len) {
-			clen = *len;
-			to_alloc = (clen + clst_per_frame - 1) &
-				   ~(clst_per_frame - 1);
-		}
  	}
  
  	if (!is_attr_ext(attr_b)) {
+		/* The code below only for sparsed or compressed attributes. */
  		err = -EINVAL;
  		goto out;
  	}
  
+	vcn0 = vcn;
+	to_alloc = clen;
+	fr = (sbi->record_size - le32_to_cpu(mi->mrec->used) + 8) / 3 + 1;
+	/* Allocate frame aligned clusters.
+	 * ntfs.sys usually uses 16 clusters per frame for sparsed or compressed.
+	 * ntfs3 uses 1 cluster per frame for new created sparsed files. */
+	if (attr_b->nres.c_unit) {
+		CLST clst_per_frame = 1u << attr_b->nres.c_unit;
+		CLST cmask = ~(clst_per_frame - 1);
+
+		/* Get frame aligned vcn and to_alloc. */
+		vcn = vcn0 & cmask;
+		to_alloc = ((vcn0 + clen + clst_per_frame - 1) & cmask) - vcn;
+		if (fr < clst_per_frame)
+			fr = clst_per_frame;
+		zero = true;
+
+		/* Check if 'vcn' and 'vcn0' in different attribute segments. */
+		if (vcn < svcn || evcn1 <= vcn) {
+			/* Load attribute for truncated vcn. */
+			attr = ni_find_attr(ni, attr_b, &le, ATTR_DATA, NULL, 0,
+					    &vcn, &mi);
+			if (!attr) {
+				err = -EINVAL;
+				goto out;
+			}
+			svcn = le64_to_cpu(attr->nres.svcn);
+			evcn1 = le64_to_cpu(attr->nres.evcn) + 1;
+			err = attr_load_runs(attr, ni, run, NULL);
+			if (err)
+				goto out;
+		}
+	}
+
+	if (vcn + to_alloc > asize)
+		to_alloc = asize - vcn;
+
  	/* Get the last LCN to allocate from. */
  	hint = 0;
  
@@ -980,18 +1032,33 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
  		hint = -1;
  	}
  
-	err = attr_allocate_clusters(
-		sbi, run, vcn, hint + 1, to_alloc, NULL, 0, len,
-		(sbi->record_size - le32_to_cpu(mi->mrec->used) + 8) / 3 + 1,
-		lcn);
+	/* Allocate and zeroout new clusters. */
+	err = attr_allocate_clusters(sbi, run, vcn, hint + 1, to_alloc, NULL,
+				     zero ? ALLOCATE_ZERO : ALLOCATE_DEF, &alen,
+				     fr, lcn, len);
  	if (err)
  		goto out;
  	*new = true;
  
-	end = vcn + *len;
-
+	end = vcn + alen;
  	total_size = le64_to_cpu(attr_b->nres.total_size) +
-		     ((u64)*len << cluster_bits);
+		     ((u64)alen << cluster_bits);
+
+	if (vcn != vcn0) {
+		if (!run_lookup_entry(run, vcn0, lcn, len, NULL)) {
+			err = -EINVAL;
+			goto out;
+		}
+		if (*lcn == SPARSE_LCN) {
+			/* Internal error. Should not happened. */
+			WARN_ON(1);
+			err = -EINVAL;
+			goto out;
+		}
+		/* Check case when vcn0 + len overlaps new allocated clusters. */
+		if (vcn0 + *len > end)
+			*len = end - vcn0;
+	}
  
  repack:
  	err = mi_pack_runs(mi, attr, run, max(end, evcn1) - svcn);
@@ -1516,7 +1583,7 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
  	struct ATTRIB *attr = NULL, *attr_b;
  	struct ATTR_LIST_ENTRY *le, *le_b;
  	struct mft_inode *mi, *mi_b;
-	CLST svcn, evcn1, next_svcn, lcn, len;
+	CLST svcn, evcn1, next_svcn, len;
  	CLST vcn, end, clst_data;
  	u64 total_size, valid_size, data_size;
  
@@ -1592,8 +1659,9 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
  		}
  
  		err = attr_allocate_clusters(sbi, run, vcn + clst_data,
-					     hint + 1, len - clst_data, NULL, 0,
-					     &alen, 0, &lcn);
+					     hint + 1, len - clst_data, NULL,
+					     ALLOCATE_DEF, &alen, 0, NULL,
+					     NULL);
  		if (err)
  			goto out;
  
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 96ba3f5a8470..63aef132e529 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -122,8 +122,8 @@ static int ntfs_extend_initialized_size(struct file *file,
  			bits = sbi->cluster_bits;
  			vcn = pos >> bits;
  
-			err = attr_data_get_block(ni, vcn, 0, &lcn, &clen,
-						  NULL);
+			err = attr_data_get_block(ni, vcn, 1, &lcn, &clen, NULL,
+						  false);
  			if (err)
  				goto out;
  
@@ -180,18 +180,18 @@ static int ntfs_zero_range(struct inode *inode, u64 vbo, u64 vbo_to)
  	struct address_space *mapping = inode->i_mapping;
  	u32 blocksize = 1 << inode->i_blkbits;
  	pgoff_t idx = vbo >> PAGE_SHIFT;
-	u32 z_start = vbo & (PAGE_SIZE - 1);
+	u32 from = vbo & (PAGE_SIZE - 1);
  	pgoff_t idx_end = (vbo_to + PAGE_SIZE - 1) >> PAGE_SHIFT;
  	loff_t page_off;
  	struct buffer_head *head, *bh;
-	u32 bh_next, bh_off, z_end;
+	u32 bh_next, bh_off, to;
  	sector_t iblock;
  	struct page *page;
  
-	for (; idx < idx_end; idx += 1, z_start = 0) {
+	for (; idx < idx_end; idx += 1, from = 0) {
  		page_off = (loff_t)idx << PAGE_SHIFT;
-		z_end = (page_off + PAGE_SIZE) > vbo_to ? (vbo_to - page_off)
-							: PAGE_SIZE;
+		to = (page_off + PAGE_SIZE) > vbo_to ? (vbo_to - page_off)
+						     : PAGE_SIZE;
  		iblock = page_off >> inode->i_blkbits;
  
  		page = find_or_create_page(mapping, idx,
@@ -208,7 +208,7 @@ static int ntfs_zero_range(struct inode *inode, u64 vbo, u64 vbo_to)
  		do {
  			bh_next = bh_off + blocksize;
  
-			if (bh_next <= z_start || bh_off >= z_end)
+			if (bh_next <= from || bh_off >= to)
  				continue;
  
  			if (!buffer_mapped(bh)) {
@@ -242,7 +242,7 @@ static int ntfs_zero_range(struct inode *inode, u64 vbo, u64 vbo_to)
  		} while (bh_off = bh_next, iblock += 1,
  			 head != (bh = bh->b_this_page));
  
-		zero_user_segment(page, z_start, z_end);
+		zero_user_segment(page, from, to);
  
  		unlock_page(page);
  		put_page(page);
@@ -253,80 +253,6 @@ static int ntfs_zero_range(struct inode *inode, u64 vbo, u64 vbo_to)
  	return err;
  }
  
-/*
- * ntfs_sparse_cluster - Helper function to zero a new allocated clusters.
- *
- * NOTE: 512 <= cluster size <= 2M
- */
-void ntfs_sparse_cluster(struct inode *inode, struct page *page0, CLST vcn,
-			 CLST len)
-{
-	struct address_space *mapping = inode->i_mapping;
-	struct ntfs_sb_info *sbi = inode->i_sb->s_fs_info;
-	u8 cluster_bits = sbi->cluster_bits;
-	u64 vbo = (u64)vcn << cluster_bits;
-	u64 bytes = (u64)len << cluster_bits;
-	u32 blocksize = 1 << inode->i_blkbits;
-	pgoff_t idx0 = page0 ? page0->index : -1;
-	loff_t vbo_clst = vbo & sbi->cluster_mask_inv;
-	loff_t end = ntfs_up_cluster(sbi, vbo + bytes);
-	pgoff_t idx = vbo_clst >> PAGE_SHIFT;
-	u32 from = vbo_clst & (PAGE_SIZE - 1);
-	pgoff_t idx_end = (end + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	loff_t page_off;
-	u32 to;
-	bool partial;
-	struct page *page;
-
-	for (; idx < idx_end; idx += 1, from = 0) {
-		page = idx == idx0 ? page0 : grab_cache_page(mapping, idx);
-
-		if (!page)
-			continue;
-
-		page_off = (loff_t)idx << PAGE_SHIFT;
-		to = (page_off + PAGE_SIZE) > end ? (end - page_off)
-						  : PAGE_SIZE;
-		partial = false;
-
-		if ((from || PAGE_SIZE != to) &&
-		    likely(!page_has_buffers(page))) {
-			create_empty_buffers(page, blocksize, 0);
-		}
-
-		if (page_has_buffers(page)) {
-			struct buffer_head *head, *bh;
-			u32 bh_off = 0;
-
-			bh = head = page_buffers(page);
-			do {
-				u32 bh_next = bh_off + blocksize;
-
-				if (from <= bh_off && bh_next <= to) {
-					set_buffer_uptodate(bh);
-					mark_buffer_dirty(bh);
-				} else if (!buffer_uptodate(bh)) {
-					partial = true;
-				}
-				bh_off = bh_next;
-			} while (head != (bh = bh->b_this_page));
-		}
-
-		zero_user_segment(page, from, to);
-
-		if (!partial)
-			SetPageUptodate(page);
-		flush_dcache_page(page);
-		set_page_dirty(page);
-
-		if (idx != idx0) {
-			unlock_page(page);
-			put_page(page);
-		}
-		cond_resched();
-	}
-}
-
  /*
   * ntfs_file_mmap - file_operations::mmap
   */
@@ -368,13 +294,9 @@ static int ntfs_file_mmap(struct file *file, struct vm_area_struct *vma)
  
  			for (; vcn < end; vcn += len) {
  				err = attr_data_get_block(ni, vcn, 1, &lcn,
-							  &len, &new);
+							  &len, &new, true);
  				if (err)
  					goto out;
-
-				if (!new)
-					continue;
-				ntfs_sparse_cluster(inode, NULL, vcn, 1);
  			}
  		}
  
@@ -518,7 +440,8 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
  	struct ntfs_sb_info *sbi = sb->s_fs_info;
  	struct ntfs_inode *ni = ntfs_i(inode);
  	loff_t end = vbo + len;
-	loff_t vbo_down = round_down(vbo, PAGE_SIZE);
+	loff_t vbo_down = round_down(vbo, max_t(unsigned long,
+						sbi->cluster_size, PAGE_SIZE));
  	bool is_supported_holes = is_sparsed(ni) || is_compressed(ni);
  	loff_t i_size, new_size;
  	bool map_locked;
@@ -571,7 +494,8 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
  		u32 frame_size;
  		loff_t mask, vbo_a, end_a, tmp;
  
-		err = filemap_write_and_wait_range(mapping, vbo, LLONG_MAX);
+		err = filemap_write_and_wait_range(mapping, vbo_down,
+						   LLONG_MAX);
  		if (err)
  			goto out;
  
@@ -672,39 +596,35 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
  			goto out;
  
  		if (is_supported_holes) {
-			CLST vcn_v = bytes_to_cluster(sbi, ni->i_valid);
  			CLST vcn = vbo >> sbi->cluster_bits;
  			CLST cend = bytes_to_cluster(sbi, end);
+			CLST cend_v = bytes_to_cluster(sbi, ni->i_valid);
  			CLST lcn, clen;
  			bool new;
  
+			if (cend_v > cend)
+				cend_v = cend;
+
  			/*
-			 * Allocate but do not zero new clusters. (see below comments)
-			 * This breaks security: One can read unused on-disk areas.
+			 * Allocate and zero new clusters.
  			 * Zeroing these clusters may be too long.
-			 * Maybe we should check here for root rights?
+			 */
+			for (; vcn < cend_v; vcn += clen) {
+				err = attr_data_get_block(ni, vcn, cend_v - vcn,
+							  &lcn, &clen, &new,
+							  true);
+				if (err)
+					goto out;
+			}
+			/*
+			 * Allocate but not zero new clusters.
  			 */
  			for (; vcn < cend; vcn += clen) {
  				err = attr_data_get_block(ni, vcn, cend - vcn,
-							  &lcn, &clen, &new);
+							  &lcn, &clen, &new,
+							  false);
  				if (err)
  					goto out;
-				if (!new || vcn >= vcn_v)
-					continue;
-
-				/*
-				 * Unwritten area.
-				 * NTFS is not able to store several unwritten areas.
-				 * Activate 'ntfs_sparse_cluster' to zero new allocated clusters.
-				 *
-				 * Dangerous in case:
-				 * 1G of sparsed clusters + 1 cluster of data =>
-				 * valid_size == 1G + 1 cluster
-				 * fallocate(1G) will zero 1G and this can be very long
-				 * xfstest 016/086 will fail without 'ntfs_sparse_cluster'.
-				 */
-				ntfs_sparse_cluster(inode, NULL, vcn,
-						    min(vcn_v - vcn, clen));
  			}
  		}
  
@@ -925,8 +845,8 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
  		frame_vbo = valid & ~(frame_size - 1);
  		off = valid & (frame_size - 1);
  
-		err = attr_data_get_block(ni, frame << NTFS_LZNT_CUNIT, 0, &lcn,
-					  &clen, NULL);
+		err = attr_data_get_block(ni, frame << NTFS_LZNT_CUNIT, 1, &lcn,
+					  &clen, NULL, false);
  		if (err)
  			goto out;
  
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index a7aed31e7c93..370c6398a044 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2224,7 +2224,7 @@ int ni_decompress_file(struct ntfs_inode *ni)
  
  		for (vcn = vbo >> sbi->cluster_bits; vcn < end; vcn += clen) {
  			err = attr_data_get_block(ni, vcn, cend - vcn, &lcn,
-						  &clen, &new);
+						  &clen, &new, false);
  			if (err)
  				goto out;
  		}
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 50c90d7e8a78..bc9ab93db1d0 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1347,8 +1347,8 @@ static int indx_create_allocate(struct ntfs_index *indx, struct ntfs_inode *ni,
  
  	run_init(&run);
  
-	err = attr_allocate_clusters(sbi, &run, 0, 0, len, NULL, 0, &alen, 0,
-				     NULL);
+	err = attr_allocate_clusters(sbi, &run, 0, 0, len, NULL, ALLOCATE_DEF,
+				     &alen, 0, NULL, NULL);
  	if (err)
  		goto out;
  
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index f487d36c9b78..18edbc7b35df 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -576,7 +576,8 @@ static noinline int ntfs_get_block_vbo(struct inode *inode, u64 vbo,
  	off = vbo & sbi->cluster_mask;
  	new = false;
  
-	err = attr_data_get_block(ni, vcn, 1, &lcn, &len, create ? &new : NULL);
+	err = attr_data_get_block(ni, vcn, 1, &lcn, &len, create ? &new : NULL,
+				  create && sbi->cluster_size > PAGE_SIZE);
  	if (err)
  		goto out;
  
@@ -594,11 +595,8 @@ static noinline int ntfs_get_block_vbo(struct inode *inode, u64 vbo,
  		WARN_ON(1);
  	}
  
-	if (new) {
+	if (new)
  		set_buffer_new(bh);
-		if ((len << cluster_bits) > block_size)
-			ntfs_sparse_cluster(inode, page, vcn, len);
-	}
  
  	lbo = ((u64)lcn << cluster_bits) + off;
  
@@ -1529,8 +1527,8 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
  				cpu_to_le64(ntfs_up_cluster(sbi, nsize));
  
  			err = attr_allocate_clusters(sbi, &ni->file.run, 0, 0,
-						     clst, NULL, 0, &alen, 0,
-						     NULL);
+						     clst, NULL, ALLOCATE_DEF,
+						     &alen, 0, NULL, NULL);
  			if (err)
  				goto out5;
  
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index e9f6898ec924..c45a411f82f6 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -126,6 +126,7 @@ struct ntfs_buffers {
  enum ALLOCATE_OPT {
  	ALLOCATE_DEF = 0, // Allocate all clusters.
  	ALLOCATE_MFT = 1, // Allocate for MFT.
+	ALLOCATE_ZERO = 2, // Zeroout new allocated clusters
  };
  
  enum bitmap_mutex_classes {
@@ -414,7 +415,7 @@ enum REPARSE_SIGN {
  int attr_allocate_clusters(struct ntfs_sb_info *sbi, struct runs_tree *run,
  			   CLST vcn, CLST lcn, CLST len, CLST *pre_alloc,
  			   enum ALLOCATE_OPT opt, CLST *alen, const size_t fr,
-			   CLST *new_lcn);
+			   CLST *new_lcn, CLST *new_len);
  int attr_make_nonresident(struct ntfs_inode *ni, struct ATTRIB *attr,
  			  struct ATTR_LIST_ENTRY *le, struct mft_inode *mi,
  			  u64 new_size, struct runs_tree *run,
@@ -424,7 +425,7 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
  		  u64 new_size, const u64 *new_valid, bool keep_prealloc,
  		  struct ATTRIB **ret);
  int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
-			CLST *len, bool *new);
+			CLST *len, bool *new, bool zero);
  int attr_data_read_resident(struct ntfs_inode *ni, struct page *page);
  int attr_data_write_resident(struct ntfs_inode *ni, struct page *page);
  int attr_load_runs_vcn(struct ntfs_inode *ni, enum ATTR_TYPE type,
@@ -489,8 +490,6 @@ extern const struct file_operations ntfs_dir_operations;
  /* Globals from file.c */
  int ntfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
  		 struct kstat *stat, u32 request_mask, u32 flags);
-void ntfs_sparse_cluster(struct inode *inode, struct page *page0, CLST vcn,
-			 CLST len);
  int ntfs3_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
  		  struct iattr *attr);
  int ntfs_file_open(struct inode *inode, struct file *file);
-- 
2.37.0


