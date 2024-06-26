Return-Path: <linux-fsdevel+bounces-22498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F97918132
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 14:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AFCF1F23771
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 12:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CED185E6A;
	Wed, 26 Jun 2024 12:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="RX/4unrL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8176B183081;
	Wed, 26 Jun 2024 12:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719405801; cv=none; b=rZAxJ2WH/P8g8xtzbKwNrLKT+yA/TWu6X4YifHhljQogDkoe1WjKGSt7O5LkClFEz6kb6VVAVktVQjnwQtfaxV7TKICxsO1PSeCIbflh1u5UzSSmlb/g0RrvBf3CLwWp4aITJy6y7gkDJKDQgCgUEQfeaoPZfV5wukkajiiCwjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719405801; c=relaxed/simple;
	bh=MbZ8R2HHzmKQtPGot0WT26KJPRmSoT6T57hKlfdAsK4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M6BNAbluEoBSMYN8+hVUE/SYY17JB41wr6UnY+vgyjLSdRJ9JHPpAHtuY5kDZ+6swIYraNdys/GkdZ3ZYYkfcWojINCE8O/Y0eOh27xAQa3DcGMP9u18vF0iTS/kphO4rClg7jVMwvuk4sTlgoQcGTB5K/K+hHJm9WDR95cZ0Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=RX/4unrL; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id A4E102187;
	Wed, 26 Jun 2024 12:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1719405312;
	bh=ZVfqifPRHEIBllJYgrG6P5zH4UzeV0EKg1Qvy7/20/s=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=RX/4unrLsFw54OCyqAlxlbyK/3Y9+v8UmikBXoq6GfaZSULjPuwNMhLJJaWcR20rI
	 3Bzjo+HxX6bf1AE+vAJ2+y1nLAuwtfbvgbGrrJnif8E+aBDfQXxNptEUnzxA8rZNkS
	 JqrhSAvEmI2s1W1AxpU7kUaOgGPdwPxrtxv3Ue3g=
Received: from ntfs3vm.paragon-software.com (192.168.211.129) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 26 Jun 2024 15:43:15 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	<syzbot+36bb70085ef6edc2ebb9@syzkaller.appspotmail.com>
Subject: [PATCH 05/11] fs/ntfs3: Do copy_to_user out of run_lock
Date: Wed, 26 Jun 2024 15:42:52 +0300
Message-ID: <20240626124258.7264-6-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626124258.7264-1-almaz.alexandrovich@paragon-software.com>
References: <20240626124258.7264-1-almaz.alexandrovich@paragon-software.com>
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

In order not to call copy_to_user (from fiemap_fill_next_extent)
we allocate memory in the kernel, fill it and copy it to user memory
after up_read(run_lock).

Reported-by: syzbot+36bb70085ef6edc2ebb9@syzkaller.appspotmail.com
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/frecord.c | 75 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 72 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index d792908c85f4..a469c608a394 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -1898,6 +1898,47 @@ enum REPARSE_SIGN ni_parse_reparse(struct ntfs_inode *ni, struct ATTRIB *attr,
 	return REPARSE_LINK;
 }
 
+/*
+ * fiemap_fill_next_extent_k - a copy of fiemap_fill_next_extent
+ * but it accepts kernel address for fi_extents_start
+ */
+static int fiemap_fill_next_extent_k(struct fiemap_extent_info *fieinfo,
+				     u64 logical, u64 phys, u64 len, u32 flags)
+{
+	struct fiemap_extent extent;
+	struct fiemap_extent __user *dest = fieinfo->fi_extents_start;
+
+	/* only count the extents */
+	if (fieinfo->fi_extents_max == 0) {
+		fieinfo->fi_extents_mapped++;
+		return (flags & FIEMAP_EXTENT_LAST) ? 1 : 0;
+	}
+
+	if (fieinfo->fi_extents_mapped >= fieinfo->fi_extents_max)
+		return 1;
+
+	if (flags & FIEMAP_EXTENT_DELALLOC)
+		flags |= FIEMAP_EXTENT_UNKNOWN;
+	if (flags & FIEMAP_EXTENT_DATA_ENCRYPTED)
+		flags |= FIEMAP_EXTENT_ENCODED;
+	if (flags & (FIEMAP_EXTENT_DATA_TAIL | FIEMAP_EXTENT_DATA_INLINE))
+		flags |= FIEMAP_EXTENT_NOT_ALIGNED;
+
+	memset(&extent, 0, sizeof(extent));
+	extent.fe_logical = logical;
+	extent.fe_physical = phys;
+	extent.fe_length = len;
+	extent.fe_flags = flags;
+
+	dest += fieinfo->fi_extents_mapped;
+	memcpy(dest, &extent, sizeof(extent));
+
+	fieinfo->fi_extents_mapped++;
+	if (fieinfo->fi_extents_mapped == fieinfo->fi_extents_max)
+		return 1;
+	return (flags & FIEMAP_EXTENT_LAST) ? 1 : 0;
+}
+
 /*
  * ni_fiemap - Helper for file_fiemap().
  *
@@ -1908,6 +1949,8 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 	      __u64 vbo, __u64 len)
 {
 	int err = 0;
+	struct fiemap_extent __user *fe_u = fieinfo->fi_extents_start;
+	struct fiemap_extent *fe_k = NULL;
 	struct ntfs_sb_info *sbi = ni->mi.sbi;
 	u8 cluster_bits = sbi->cluster_bits;
 	struct runs_tree *run;
@@ -1955,6 +1998,18 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 		goto out;
 	}
 
+	/*
+	 * To avoid lock problems replace pointer to user memory by pointer to kernel memory.
+	 */
+	fe_k = kmalloc_array(fieinfo->fi_extents_max,
+			     sizeof(struct fiemap_extent),
+			     GFP_NOFS | __GFP_ZERO);
+	if (!fe_k) {
+		err = -ENOMEM;
+		goto out;
+	}
+	fieinfo->fi_extents_start = fe_k;
+
 	end = vbo + len;
 	alloc_size = le64_to_cpu(attr->nres.alloc_size);
 	if (end > alloc_size)
@@ -2043,8 +2098,9 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 			if (vbo + dlen >= end)
 				flags |= FIEMAP_EXTENT_LAST;
 
-			err = fiemap_fill_next_extent(fieinfo, vbo, lbo, dlen,
-						      flags);
+			err = fiemap_fill_next_extent_k(fieinfo, vbo, lbo, dlen,
+							flags);
+
 			if (err < 0)
 				break;
 			if (err == 1) {
@@ -2064,7 +2120,8 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 		if (vbo + bytes >= end)
 			flags |= FIEMAP_EXTENT_LAST;
 
-		err = fiemap_fill_next_extent(fieinfo, vbo, lbo, bytes, flags);
+		err = fiemap_fill_next_extent_k(fieinfo, vbo, lbo, bytes,
+						flags);
 		if (err < 0)
 			break;
 		if (err == 1) {
@@ -2077,7 +2134,19 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 
 	up_read(run_lock);
 
+	/*
+	 * Copy to user memory out of lock
+	 */
+	if (copy_to_user(fe_u, fe_k,
+			 fieinfo->fi_extents_max *
+				 sizeof(struct fiemap_extent))) {
+		err = -EFAULT;
+	}
+
 out:
+	/* Restore original pointer. */
+	fieinfo->fi_extents_start = fe_u;
+	kfree(fe_k);
 	return err;
 }
 
-- 
2.34.1


