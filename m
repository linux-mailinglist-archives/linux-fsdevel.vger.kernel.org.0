Return-Path: <linux-fsdevel+bounces-28387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D44B496A032
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 16:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04C1D1C2338C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 14:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1486F31C;
	Tue,  3 Sep 2024 14:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="Fjmh1NiK";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="o7uaFkk+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBFE626CB;
	Tue,  3 Sep 2024 14:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373195; cv=none; b=g0OmRoJIgsTb+F3Ib9+o7GgJXJYRV5sx9xLAkv0JK914um9vgfdLbFMtwJrAsp5CXeTaz2PV39uFfNWVSCLpPrChNTUV+xFFb/ITHgP1hdWZ+5ZfAxByQGN3X8i9PWK7bqU00fmpR2CJlRZacE4vRhTszHximRbJDoyNp+PzQYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373195; c=relaxed/simple;
	bh=m9h16UYK6VrodXkfwFXX8YBOZhgH7dvUHnJmBo2jgow=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ij8AT79NyIJH1US2iPbMqc0xCtDgaeGB+7iZQ2PJUIx8pEGLtXze4Fok3l5MBNCKlB8NJhluB7MugVNo5wcvGl/iOYekOCxEcLqLdFFhrJoPKpyV4/L9Ghb8+WT8oVyCQL935CKLD7NN2u+cez5PR82u0bCBUlb2pJVFd4lrrVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=Fjmh1NiK; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=o7uaFkk+; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id DFC6B21F8;
	Tue,  3 Sep 2024 14:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1725372722;
	bh=lb7cGFCjC+Kuzri59R3hcR62KcT5/hnyzDqin22FzGA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Fjmh1NiKj/Y30UEJPV1m1fsj3KD9I5/K1nC3WxYSlM69czvmohEpeNBFZrobaU/ei
	 k59sBG98WsP04JavjbCmqwmBgyO5KWZqEECug4sasBjeOrfj2pG6DWVCRRjujRWlno
	 CMsms/94rXeIpeasz6mXLkA6sHPq1mOrl1K7fOtE=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 2C0A22213;
	Tue,  3 Sep 2024 14:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1725373190;
	bh=lb7cGFCjC+Kuzri59R3hcR62KcT5/hnyzDqin22FzGA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=o7uaFkk+1QwMl00Zmi+gPIvU8PIpuyg/LTsv+PtZiTcLMMt7K951pVXCKoIbTSIqy
	 kYlMTAbm1FsWshWBWrywTxHMj1VxDqgNhJ+Rv/TnELEJNY+kg+tnne7aGG+4Pq3eOl
	 yDMfBMJ8qpi8dAX8o6BW+rnBrP4Fhwpkr49V+Y18=
Received: from ntfs3vm.paragon-software.com (192.168.211.161) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 3 Sep 2024 17:19:49 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, kernel test
 robot <lkp@intel.com>
Subject: [PATCH v2] fs/ntfs3: Fix sparse warning in ni_fiemap
Date: Tue, 3 Sep 2024 17:19:42 +0300
Message-ID: <20240903141942.25596-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822155207.600355-7-almaz.alexandrovich@paragon-software.com>
References: <20240822155207.600355-7-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

The interface of fiemap_fill_next_extent_k() was modified
to eliminate the sparse warning.

Fixes: d57431c6f511 ("fs/ntfs3: Do copy_to_user out of run_lock")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406271920.hndE8N6D-lkp@intel.com/
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/frecord.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index a469c608a394..60c975ac38e6 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -1900,13 +1900,13 @@ enum REPARSE_SIGN ni_parse_reparse(struct ntfs_inode *ni, struct ATTRIB *attr,
 
 /*
  * fiemap_fill_next_extent_k - a copy of fiemap_fill_next_extent
- * but it accepts kernel address for fi_extents_start
+ * but it uses 'fe_k' instead of fieinfo->fi_extents_start
  */
 static int fiemap_fill_next_extent_k(struct fiemap_extent_info *fieinfo,
-				     u64 logical, u64 phys, u64 len, u32 flags)
+				     struct fiemap_extent *fe_k, u64 logical,
+				     u64 phys, u64 len, u32 flags)
 {
 	struct fiemap_extent extent;
-	struct fiemap_extent __user *dest = fieinfo->fi_extents_start;
 
 	/* only count the extents */
 	if (fieinfo->fi_extents_max == 0) {
@@ -1930,8 +1930,7 @@ static int fiemap_fill_next_extent_k(struct fiemap_extent_info *fieinfo,
 	extent.fe_length = len;
 	extent.fe_flags = flags;
 
-	dest += fieinfo->fi_extents_mapped;
-	memcpy(dest, &extent, sizeof(extent));
+	memcpy(fe_k + fieinfo->fi_extents_mapped, &extent, sizeof(extent));
 
 	fieinfo->fi_extents_mapped++;
 	if (fieinfo->fi_extents_mapped == fieinfo->fi_extents_max)
@@ -1949,7 +1948,6 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 	      __u64 vbo, __u64 len)
 {
 	int err = 0;
-	struct fiemap_extent __user *fe_u = fieinfo->fi_extents_start;
 	struct fiemap_extent *fe_k = NULL;
 	struct ntfs_sb_info *sbi = ni->mi.sbi;
 	u8 cluster_bits = sbi->cluster_bits;
@@ -2008,7 +2006,6 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 		err = -ENOMEM;
 		goto out;
 	}
-	fieinfo->fi_extents_start = fe_k;
 
 	end = vbo + len;
 	alloc_size = le64_to_cpu(attr->nres.alloc_size);
@@ -2098,8 +2095,8 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 			if (vbo + dlen >= end)
 				flags |= FIEMAP_EXTENT_LAST;
 
-			err = fiemap_fill_next_extent_k(fieinfo, vbo, lbo, dlen,
-							flags);
+			err = fiemap_fill_next_extent_k(fieinfo, fe_k, vbo, lbo,
+							dlen, flags);
 
 			if (err < 0)
 				break;
@@ -2120,7 +2117,7 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 		if (vbo + bytes >= end)
 			flags |= FIEMAP_EXTENT_LAST;
 
-		err = fiemap_fill_next_extent_k(fieinfo, vbo, lbo, bytes,
+		err = fiemap_fill_next_extent_k(fieinfo, fe_k, vbo, lbo, bytes,
 						flags);
 		if (err < 0)
 			break;
@@ -2137,15 +2134,13 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 	/*
 	 * Copy to user memory out of lock
 	 */
-	if (copy_to_user(fe_u, fe_k,
+	if (copy_to_user(fieinfo->fi_extents_start, fe_k,
 			 fieinfo->fi_extents_max *
 				 sizeof(struct fiemap_extent))) {
 		err = -EFAULT;
 	}
 
 out:
-	/* Restore original pointer. */
-	fieinfo->fi_extents_start = fe_u;
 	kfree(fe_k);
 	return err;
 }
-- 
2.34.1


