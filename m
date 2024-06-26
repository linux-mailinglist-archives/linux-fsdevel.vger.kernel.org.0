Return-Path: <linux-fsdevel+bounces-22503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0BB91813F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 14:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2D62B23A1B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 12:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2869187540;
	Wed, 26 Jun 2024 12:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="cxfCdSBi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A52186E4E;
	Wed, 26 Jun 2024 12:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719405806; cv=none; b=bkmg+5uBo/u4PV7FypJ2p2g5NUGcGTx3LFhCbX7wnEXuyA1JOADc1zFyVatmTRORCB2nY3E9vgAHnXQKY5wueQ/U0KGvaxmJnJLj8+TPWi7FH5tC7BUWd2RiHI6s7AZmPs2tjiXdUxxebYCAtUcVZzkcuye89NADDCoS8puuuxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719405806; c=relaxed/simple;
	bh=kEu+hizF5vvV9gvME30D0ujvRetJzFkSWFs8AjkPFzs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mG9lsWcTzXKZBzC99TfrG96QZw6C31P2A1IM+4TZ4Vn+R/Uy1+y/keAroO4pp3Lj/44nn1trX6aDTBrxSOhg0YnPF/F7VYlJMEFFnm5op96gxuJc3pdKpEd0KRtusBnIQ4Ym9QACr6fBwuIyBF5z5s+1VSYn8AiurPuNFIEqsfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=cxfCdSBi; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 6FDB8217E;
	Wed, 26 Jun 2024 12:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1719405319;
	bh=r891SvDVsOcmR7bIXrUZtQUOnVwUkR/qppT5vNtznFg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=cxfCdSBiFzghTsXGtpe2PUtdaDxHP/gcVIzWHEBGJoPX5q8bvr9mUNaqh9PjEnNSH
	 32xwZfqWbssDpxf3azP4AU7j/GdEB40kJxot76IY45x3HgPjsxWvk0lp9Pg2s10/P+
	 L+x7An6Wm5ivAxmylh1sQeClR5ONO52CXfRs+b/U=
Received: from ntfs3vm.paragon-software.com (192.168.211.129) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 26 Jun 2024 15:43:22 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Huacai Chen
	<chenhuacai@loongson.cn>
Subject: [PATCH 11/11] fs/ntfs3: Fix formatting, change comments, renaming
Date: Wed, 26 Jun 2024 15:42:58 +0300
Message-ID: <20240626124258.7264-12-almaz.alexandrovich@paragon-software.com>
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

Huacai Chen:
	The label end_reply is obviously a typo. It should be "replay" in this
	context. So rename end_reply to end_replay.

Suggested-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/attrib.c |  6 +++---
 fs/ntfs3/file.c   | 14 +++++++++-----
 fs/ntfs3/fslog.c  |  8 ++++----
 fs/ntfs3/inode.c  |  7 ++++---
 fs/ntfs3/namei.c  |  4 +---
 5 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 1d63e1c9469b..6ede3e924dec 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -291,9 +291,9 @@ int attr_make_nonresident(struct ntfs_inode *ni, struct ATTRIB *attr,
 			struct address_space *mapping = ni->vfs_inode.i_mapping;
 			struct folio *folio;
 
-			folio = __filemap_get_folio(mapping, 0,
-					FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
-					mapping_gfp_mask(mapping));
+			folio = __filemap_get_folio(
+				mapping, 0, FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
+				mapping_gfp_mask(mapping));
 			if (IS_ERR(folio)) {
 				err = PTR_ERR(folio);
 				goto out2;
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 1ba837b27497..ca1ddc46bd86 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -105,6 +105,9 @@ int ntfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
 	return 0;
 }
 
+/*
+ * ntfs_ioctl - file_operations::unlocked_ioctl
+ */
 long ntfs_ioctl(struct file *filp, u32 cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
@@ -260,9 +263,9 @@ static int ntfs_zero_range(struct inode *inode, u64 vbo, u64 vbo_to)
 						       PAGE_SIZE;
 		iblock = page_off >> inode->i_blkbits;
 
-		folio = __filemap_get_folio(mapping, idx,
-				FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
-				mapping_gfp_constraint(mapping, ~__GFP_FS));
+		folio = __filemap_get_folio(
+			mapping, idx, FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
+			mapping_gfp_constraint(mapping, ~__GFP_FS));
 		if (IS_ERR(folio))
 			return PTR_ERR(folio);
 
@@ -887,7 +890,8 @@ static int ntfs_get_frame_pages(struct address_space *mapping, pgoff_t index,
 		struct folio *folio;
 
 		folio = __filemap_get_folio(mapping, index,
-				FGP_LOCK | FGP_ACCESSED | FGP_CREAT, gfp_mask);
+					    FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
+					    gfp_mask);
 		if (IS_ERR(folio)) {
 			while (npages--) {
 				folio = page_folio(pages[npages]);
@@ -1258,7 +1262,7 @@ static int ntfs_file_release(struct inode *inode, struct file *file)
 }
 
 /*
- * ntfs_fiemap - file_operations::fiemap
+ * ntfs_fiemap - inode_operations::fiemap
  */
 int ntfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		__u64 start, __u64 len)
diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index f8da043be169..1f71849996ea 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -724,8 +724,8 @@ static bool check_rstbl(const struct RESTART_TABLE *rt, size_t bytes)
 
 	if (!rsize || rsize > bytes ||
 	    rsize + sizeof(struct RESTART_TABLE) > bytes || bytes < ts ||
-	    le16_to_cpu(rt->total) > ne ||
-			ff > ts - sizeof(__le32) || lf > ts - sizeof(__le32) ||
+	    le16_to_cpu(rt->total) > ne || ff > ts - sizeof(__le32) ||
+	    lf > ts - sizeof(__le32) ||
 	    (ff && ff < sizeof(struct RESTART_TABLE)) ||
 	    (lf && lf < sizeof(struct RESTART_TABLE))) {
 		return false;
@@ -4687,7 +4687,7 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 	 * table are not empty.
 	 */
 	if ((!dptbl || !dptbl->total) && (!trtbl || !trtbl->total))
-		goto end_reply;
+		goto end_replay;
 
 	sbi->flags |= NTFS_FLAGS_NEED_REPLAY;
 	if (is_ro)
@@ -5116,7 +5116,7 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 
 	sbi->flags &= ~NTFS_FLAGS_NEED_REPLAY;
 
-end_reply:
+end_replay:
 
 	err = 0;
 	if (is_ro)
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 77ae0dccbd5c..6b0bdc474e76 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -578,6 +578,7 @@ static noinline int ntfs_get_block_vbo(struct inode *inode, u64 vbo,
 		bh->b_blocknr = RESIDENT_LCN;
 		bh->b_size = block_size;
 		if (!folio) {
+			/* direct io (read) or bmap call */
 			err = 0;
 		} else {
 			ni_lock(ni);
@@ -911,9 +912,9 @@ int ntfs_write_begin(struct file *file, struct address_space *mapping,
 
 	*pagep = NULL;
 	if (is_resident(ni)) {
-		struct folio *folio = __filemap_get_folio(mapping,
-				pos >> PAGE_SHIFT, FGP_WRITEBEGIN,
-				mapping_gfp_mask(mapping));
+		struct folio *folio = __filemap_get_folio(
+			mapping, pos >> PAGE_SHIFT, FGP_WRITEBEGIN,
+			mapping_gfp_mask(mapping));
 
 		if (IS_ERR(folio)) {
 			err = PTR_ERR(folio);
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index cc04be9a4394..f16d318c4372 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -112,9 +112,7 @@ static int ntfs_create(struct mnt_idmap *idmap, struct inode *dir,
 }
 
 /*
- * ntfs_mknod
- *
- * inode_operations::mknod
+ * ntfs_mknod - inode_operations::mknod
  */
 static int ntfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *dentry, umode_t mode, dev_t rdev)
-- 
2.34.1


