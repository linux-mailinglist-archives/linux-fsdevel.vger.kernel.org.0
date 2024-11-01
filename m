Return-Path: <linux-fsdevel+bounces-33451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9C29B8D00
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 09:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520571F22E5A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 08:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B6015886C;
	Fri,  1 Nov 2024 08:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="aS5OYCVK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0D8156678;
	Fri,  1 Nov 2024 08:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730449590; cv=none; b=N4H2gu0QDN/UVIllT6zN7JD7tK0Ro5xuCmQMKwUavWZ2MTP/z1v2nIXuMDVHRDz4oA+5oLgMr+EMk1njQZ4Tb289l5UKjE/dF1IBxZiJacZ3VwPkaQCWq34sZaKEbEDuYrVb5PY0IEhrgIOReL8ewloZn2yz3hywsD/Bpza6M3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730449590; c=relaxed/simple;
	bh=+6/v9Azv9t0zjKhmI02pkI6wOoHelWUtYk6iSp1338A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OpxuFBInX9a2V+l62k6kXnvJJIWr051Uqf/ejuaFV3iiXF3xFg9f1reaOg/xsUMh+pRVTnzaapH2uecwAzBPwd5qI+YfZThK7fAlpjXIptr8rqQesI3buUHBRZ8/gq9wJJIMJdt3IAW/ZX3AnSbrbfbtIcZvqlW6r1L5v+3mK/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=aS5OYCVK; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 8CEB1218D;
	Fri,  1 Nov 2024 08:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1730448622;
	bh=EMJxi7gPPcRhavvgBEOenfkgLt+8pGTZpnPW3BV4h5M=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=aS5OYCVKxGlCERKclGyOdvhSNxtAa9uWVo+AZr/1ZiNOEbWHJS9OORcm4377uj4dx
	 a0KDkO1TL3GrkoGMfANRAXkGn8KUC1YwW+2u9athn8I7qa22pwoxFfqFO2z0AffkTr
	 vOBURBi4I29D5EN2VadRROticCDVFS/LjAMplBI0=
Received: from ntfs3vm.paragon-software.com (192.168.211.142) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 1 Nov 2024 11:18:05 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	<syzbot+1c25748a40fe79b8a119@syzkaller.appspotmail.com>
Subject: [PATCH 1/7] fs/ntfs3: Fix warning in ni_fiemap
Date: Fri, 1 Nov 2024 11:17:47 +0300
Message-ID: <20241101081753.10585-2-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241101081753.10585-1-almaz.alexandrovich@paragon-software.com>
References: <20241101081753.10585-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Use local runs_tree instead of cached. This way excludes rw_semaphore lock.

Reported-by: syzbot+1c25748a40fe79b8a119@syzkaller.appspotmail.com
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/attrib.c  |   9 ++--
 fs/ntfs3/frecord.c | 103 +++++++--------------------------------------
 fs/ntfs3/ntfs_fs.h |   3 +-
 3 files changed, 21 insertions(+), 94 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 0763202d00c9..8d789b017fa9 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -977,7 +977,7 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
 
 	/* Check for compressed frame. */
 	err = attr_is_frame_compressed(ni, attr_b, vcn >> NTFS_LZNT_CUNIT,
-				       &hint);
+				       &hint, run);
 	if (err)
 		goto out;
 
@@ -1521,16 +1521,16 @@ int attr_wof_frame_info(struct ntfs_inode *ni, struct ATTRIB *attr,
  * attr_is_frame_compressed - Used to detect compressed frame.
  *
  * attr - base (primary) attribute segment.
+ * run  - run to use, usually == &ni->file.run.
  * Only base segments contains valid 'attr->nres.c_unit'
  */
 int attr_is_frame_compressed(struct ntfs_inode *ni, struct ATTRIB *attr,
-			     CLST frame, CLST *clst_data)
+			     CLST frame, CLST *clst_data, struct runs_tree *run)
 {
 	int err;
 	u32 clst_frame;
 	CLST clen, lcn, vcn, alen, slen, vcn_next;
 	size_t idx;
-	struct runs_tree *run;
 
 	*clst_data = 0;
 
@@ -1542,7 +1542,6 @@ int attr_is_frame_compressed(struct ntfs_inode *ni, struct ATTRIB *attr,
 
 	clst_frame = 1u << attr->nres.c_unit;
 	vcn = frame * clst_frame;
-	run = &ni->file.run;
 
 	if (!run_lookup_entry(run, vcn, &lcn, &clen, &idx)) {
 		err = attr_load_runs_vcn(ni, attr->type, attr_name(attr),
@@ -1678,7 +1677,7 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
 	if (err)
 		goto out;
 
-	err = attr_is_frame_compressed(ni, attr_b, frame, &clst_data);
+	err = attr_is_frame_compressed(ni, attr_b, frame, &clst_data, run);
 	if (err)
 		goto out;
 
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 41c7ffad2790..c33e818b3164 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -1900,46 +1900,6 @@ enum REPARSE_SIGN ni_parse_reparse(struct ntfs_inode *ni, struct ATTRIB *attr,
 	return REPARSE_LINK;
 }
 
-/*
- * fiemap_fill_next_extent_k - a copy of fiemap_fill_next_extent
- * but it uses 'fe_k' instead of fieinfo->fi_extents_start
- */
-static int fiemap_fill_next_extent_k(struct fiemap_extent_info *fieinfo,
-				     struct fiemap_extent *fe_k, u64 logical,
-				     u64 phys, u64 len, u32 flags)
-{
-	struct fiemap_extent extent;
-
-	/* only count the extents */
-	if (fieinfo->fi_extents_max == 0) {
-		fieinfo->fi_extents_mapped++;
-		return (flags & FIEMAP_EXTENT_LAST) ? 1 : 0;
-	}
-
-	if (fieinfo->fi_extents_mapped >= fieinfo->fi_extents_max)
-		return 1;
-
-	if (flags & FIEMAP_EXTENT_DELALLOC)
-		flags |= FIEMAP_EXTENT_UNKNOWN;
-	if (flags & FIEMAP_EXTENT_DATA_ENCRYPTED)
-		flags |= FIEMAP_EXTENT_ENCODED;
-	if (flags & (FIEMAP_EXTENT_DATA_TAIL | FIEMAP_EXTENT_DATA_INLINE))
-		flags |= FIEMAP_EXTENT_NOT_ALIGNED;
-
-	memset(&extent, 0, sizeof(extent));
-	extent.fe_logical = logical;
-	extent.fe_physical = phys;
-	extent.fe_length = len;
-	extent.fe_flags = flags;
-
-	memcpy(fe_k + fieinfo->fi_extents_mapped, &extent, sizeof(extent));
-
-	fieinfo->fi_extents_mapped++;
-	if (fieinfo->fi_extents_mapped == fieinfo->fi_extents_max)
-		return 1;
-	return (flags & FIEMAP_EXTENT_LAST) ? 1 : 0;
-}
-
 /*
  * ni_fiemap - Helper for file_fiemap().
  *
@@ -1950,11 +1910,9 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 	      __u64 vbo, __u64 len)
 {
 	int err = 0;
-	struct fiemap_extent *fe_k = NULL;
 	struct ntfs_sb_info *sbi = ni->mi.sbi;
 	u8 cluster_bits = sbi->cluster_bits;
-	struct runs_tree *run;
-	struct rw_semaphore *run_lock;
+	struct runs_tree run;
 	struct ATTRIB *attr;
 	CLST vcn = vbo >> cluster_bits;
 	CLST lcn, clen;
@@ -1965,13 +1923,11 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 	u32 flags;
 	bool ok;
 
+	run_init(&run);
 	if (S_ISDIR(ni->vfs_inode.i_mode)) {
-		run = &ni->dir.alloc_run;
 		attr = ni_find_attr(ni, NULL, NULL, ATTR_ALLOC, I30_NAME,
 				    ARRAY_SIZE(I30_NAME), NULL, NULL);
-		run_lock = &ni->dir.run_lock;
 	} else {
-		run = &ni->file.run;
 		attr = ni_find_attr(ni, NULL, NULL, ATTR_DATA, NULL, 0, NULL,
 				    NULL);
 		if (!attr) {
@@ -1986,7 +1942,6 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 				"fiemap is not supported for compressed file (cp -r)");
 			goto out;
 		}
-		run_lock = &ni->file.run_lock;
 	}
 
 	if (!attr || !attr->non_res) {
@@ -1998,51 +1953,33 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 		goto out;
 	}
 
-	/*
-	 * To avoid lock problems replace pointer to user memory by pointer to kernel memory.
-	 */
-	fe_k = kmalloc_array(fieinfo->fi_extents_max,
-			     sizeof(struct fiemap_extent),
-			     GFP_NOFS | __GFP_ZERO);
-	if (!fe_k) {
-		err = -ENOMEM;
-		goto out;
-	}
-
 	end = vbo + len;
 	alloc_size = le64_to_cpu(attr->nres.alloc_size);
 	if (end > alloc_size)
 		end = alloc_size;
 
-	down_read(run_lock);
 
 	while (vbo < end) {
 		if (idx == -1) {
-			ok = run_lookup_entry(run, vcn, &lcn, &clen, &idx);
+			ok = run_lookup_entry(&run, vcn, &lcn, &clen, &idx);
 		} else {
 			CLST vcn_next = vcn;
 
-			ok = run_get_entry(run, ++idx, &vcn, &lcn, &clen) &&
+			ok = run_get_entry(&run, ++idx, &vcn, &lcn, &clen) &&
 			     vcn == vcn_next;
 			if (!ok)
 				vcn = vcn_next;
 		}
 
 		if (!ok) {
-			up_read(run_lock);
-			down_write(run_lock);
-
 			err = attr_load_runs_vcn(ni, attr->type,
 						 attr_name(attr),
-						 attr->name_len, run, vcn);
-
-			up_write(run_lock);
-			down_read(run_lock);
+						 attr->name_len, &run, vcn);
 
 			if (err)
 				break;
 
-			ok = run_lookup_entry(run, vcn, &lcn, &clen, &idx);
+			ok = run_lookup_entry(&run, vcn, &lcn, &clen, &idx);
 
 			if (!ok) {
 				err = -EINVAL;
@@ -2067,8 +2004,9 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 		} else if (is_attr_compressed(attr)) {
 			CLST clst_data;
 
-			err = attr_is_frame_compressed(
-				ni, attr, vcn >> attr->nres.c_unit, &clst_data);
+			err = attr_is_frame_compressed(ni, attr,
+						       vcn >> attr->nres.c_unit,
+						       &clst_data, &run);
 			if (err)
 				break;
 			if (clst_data < NTFS_LZNT_CLUSTERS)
@@ -2097,8 +2035,8 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 			if (vbo + dlen >= end)
 				flags |= FIEMAP_EXTENT_LAST;
 
-			err = fiemap_fill_next_extent_k(fieinfo, fe_k, vbo, lbo,
-							dlen, flags);
+			err = fiemap_fill_next_extent(fieinfo, vbo, lbo, dlen,
+						      flags);
 
 			if (err < 0)
 				break;
@@ -2119,8 +2057,7 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 		if (vbo + bytes >= end)
 			flags |= FIEMAP_EXTENT_LAST;
 
-		err = fiemap_fill_next_extent_k(fieinfo, fe_k, vbo, lbo, bytes,
-						flags);
+		err = fiemap_fill_next_extent(fieinfo, vbo, lbo, bytes, flags);
 		if (err < 0)
 			break;
 		if (err == 1) {
@@ -2131,19 +2068,8 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 		vbo += bytes;
 	}
 
-	up_read(run_lock);
-
-	/*
-	 * Copy to user memory out of lock
-	 */
-	if (copy_to_user(fieinfo->fi_extents_start, fe_k,
-			 fieinfo->fi_extents_max *
-				 sizeof(struct fiemap_extent))) {
-		err = -EFAULT;
-	}
-
 out:
-	kfree(fe_k);
+	run_close(&run);
 	return err;
 }
 
@@ -2672,7 +2598,8 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 		down_write(&ni->file.run_lock);
 		run_truncate_around(run, le64_to_cpu(attr->nres.svcn));
 		frame = frame_vbo >> (cluster_bits + NTFS_LZNT_CUNIT);
-		err = attr_is_frame_compressed(ni, attr, frame, &clst_data);
+		err = attr_is_frame_compressed(ni, attr, frame, &clst_data,
+					       run);
 		up_write(&ni->file.run_lock);
 		if (err)
 			goto out1;
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 26e1e1379c04..cd8e8374bb5a 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -446,7 +446,8 @@ int attr_wof_frame_info(struct ntfs_inode *ni, struct ATTRIB *attr,
 			struct runs_tree *run, u64 frame, u64 frames,
 			u8 frame_bits, u32 *ondisk_size, u64 *vbo_data);
 int attr_is_frame_compressed(struct ntfs_inode *ni, struct ATTRIB *attr,
-			     CLST frame, CLST *clst_data);
+			     CLST frame, CLST *clst_data,
+			     struct runs_tree *run);
 int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
 			u64 new_valid);
 int attr_collapse_range(struct ntfs_inode *ni, u64 vbo, u64 bytes);
-- 
2.34.1


