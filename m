Return-Path: <linux-fsdevel+bounces-17823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B618B2942
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 21:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A5E61C21669
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 19:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F8315253E;
	Thu, 25 Apr 2024 19:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="XPLhXr+O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9852215250B;
	Thu, 25 Apr 2024 19:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714075138; cv=none; b=M/I8q1vMa4dgx5ubXIlDqhx2umixvXpaM9wccq+RhT0ZpLZtB6JGjJBkW1CWLkN10/UqvdJI2mW5ZWEVmzqMtvq66N02p6Cj8EukJ/AOEQOi98z//FfDuePWIRmQy5rlMr0gTPNsGnY7m6Eryf7bhD2Xac4hnpUWf68T4dS5UW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714075138; c=relaxed/simple;
	bh=WDT/dTkivdYIrjf4w2Wfj0vmD95CfrPDpbyxrWm3jyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXk8cbuh7Rz6erAtkT5FuTcHx4f5SuQo8lyh3R0WSaIXZeZV/CUCBRzNTMBEoZwYciACO88Pi55eU5a3/AjoMt7Q2v6oAzM9KLzo5arkd9MB0MacQ7hz7KJ4BFwhe31tL+Vwj7A32avavHEYmtpsOuQFeXnIl3ZE3uXZVSwNaB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=XPLhXr+O; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RjYlGHqRc8avntqUChmflXMmzq573kuSQzLEMSPxDZA=; b=XPLhXr+OlQdDx5hrm8XisM5Pv1
	qCddBvsqpiuWp68lF1UaqcgfCyMMvyHuJvoWmwUxu256/r8BAG8ocAAx0XEyo/PHrFLiEXAO5wKqG
	sACEEZjewlJ2KT4qvyx1v2v0FRCEG39JhRfv4ykgoWA+wtqpp7DIfLFsO2l1zjh2N1pOAxaSrNsSp
	6foDtl1X8mf2IRc6jBWOXrIzG+lZnH8LMofzyA87QIIWZ6yGAG+WLD4PffT6y/yNt7QUDKGFIkpxL
	Hne6xWGHqdk9dQeiqHRYAy3mI/eOL4ltsLuZSC1adAjJMuuCQeSxeZrN8rPx3+hViUH0k00+fndjm
	N4K/FkkA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s05F0-004KU2-0f;
	Thu, 25 Apr 2024 19:58:46 +0000
Date: Thu, 25 Apr 2024 20:58:46 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz, hch@lst.de,
	brauner@kernel.org, axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, yukuai3@huawei.com
Subject: erofs: mechanically convert erofs_read_metabuf() to offsets
Message-ID: <20240425195846.GC1031757@ZenIV>
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
 <20240406090930.2252838-9-yukuai1@huaweicloud.com>
 <20240407040531.GA1791215@ZenIV>
 <a660a238-2b7e-423f-b5aa-6f5777259f4d@linux.alibaba.com>
 <20240425195641.GJ2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425195641.GJ2118490@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

just lift the call of erofs_pos() into the callers; it will
collapse in most of them, but that's better done caller-by-caller.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/erofs/data.c     | 8 ++++----
 fs/erofs/fscache.c  | 2 +-
 fs/erofs/inode.c    | 4 ++--
 fs/erofs/internal.h | 2 +-
 fs/erofs/super.c    | 2 +-
 fs/erofs/zdata.c    | 2 +-
 fs/erofs/zmap.c     | 6 +++---
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index e1a170e45c70..82a196e02b5c 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -72,10 +72,10 @@ void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
 }
 
 void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
-			 erofs_blk_t blkaddr, enum erofs_kmap_type type)
+			 erofs_off_t offset, enum erofs_kmap_type type)
 {
 	erofs_init_metabuf(buf, sb);
-	return erofs_bread(buf, erofs_pos(sb, blkaddr), type);
+	return erofs_bread(buf, offset, type);
 }
 
 static int erofs_map_blocks_flatmode(struct inode *inode,
@@ -152,7 +152,7 @@ int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
 	pos = ALIGN(erofs_iloc(inode) + vi->inode_isize +
 		    vi->xattr_isize, unit) + unit * chunknr;
 
-	kaddr = erofs_read_metabuf(&buf, sb, erofs_blknr(sb, pos), EROFS_KMAP);
+	kaddr = erofs_read_metabuf(&buf, sb, erofs_pos(sb, erofs_blknr(sb, pos)), EROFS_KMAP);
 	if (IS_ERR(kaddr)) {
 		err = PTR_ERR(kaddr);
 		goto out;
@@ -295,7 +295,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 
 		iomap->type = IOMAP_INLINE;
 		ptr = erofs_read_metabuf(&buf, sb,
-				erofs_blknr(sb, mdev.m_pa), EROFS_KMAP);
+				erofs_pos(sb, erofs_blknr(sb, mdev.m_pa)), EROFS_KMAP);
 		if (IS_ERR(ptr))
 			return PTR_ERR(ptr);
 		iomap->inline_data = ptr + erofs_blkoff(sb, mdev.m_pa);
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 8aff1a724805..4df4617d99f2 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -282,7 +282,7 @@ static int erofs_fscache_data_read_slice(struct erofs_fscache_rq *req)
 		blknr = erofs_blknr(sb, map.m_pa);
 		size = map.m_llen;
 
-		src = erofs_read_metabuf(&buf, sb, blknr, EROFS_KMAP);
+		src = erofs_read_metabuf(&buf, sb, erofs_pos(sb, blknr), EROFS_KMAP);
 		if (IS_ERR(src))
 			return PTR_ERR(src);
 
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 0eb0e6f933c3..5f6439a63af7 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -26,7 +26,7 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 	blkaddr = erofs_blknr(sb, inode_loc);
 	*ofs = erofs_blkoff(sb, inode_loc);
 
-	kaddr = erofs_read_metabuf(buf, sb, blkaddr, EROFS_KMAP);
+	kaddr = erofs_read_metabuf(buf, sb, erofs_pos(sb, blkaddr), EROFS_KMAP);
 	if (IS_ERR(kaddr)) {
 		erofs_err(sb, "failed to get inode (nid: %llu) page, err %ld",
 			  vi->nid, PTR_ERR(kaddr));
@@ -66,7 +66,7 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 				goto err_out;
 			}
 			memcpy(copied, dic, gotten);
-			kaddr = erofs_read_metabuf(buf, sb, blkaddr + 1,
+			kaddr = erofs_read_metabuf(buf, sb, erofs_pos(sb, blkaddr + 1),
 						   EROFS_KMAP);
 			if (IS_ERR(kaddr)) {
 				erofs_err(sb, "failed to get inode payload block (nid: %llu), err %ld",
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 12a179818897..f82a5eb79c8e 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -413,7 +413,7 @@ void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset,
 		  enum erofs_kmap_type type);
 void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb);
 void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
-			 erofs_blk_t blkaddr, enum erofs_kmap_type type);
+			 erofs_off_t offset, enum erofs_kmap_type type);
 int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *dev);
 int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		 u64 start, u64 len);
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index fdefc3772620..5466118c7e2d 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -180,7 +180,7 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 	struct file *bdev_file;
 	void *ptr;
 
-	ptr = erofs_read_metabuf(buf, sb, erofs_blknr(sb, *pos), EROFS_KMAP);
+	ptr = erofs_read_metabuf(buf, sb, erofs_pos(sb, erofs_blknr(sb, *pos)), EROFS_KMAP);
 	if (IS_ERR(ptr))
 		return PTR_ERR(ptr);
 	dis = ptr + erofs_blkoff(sb, *pos);
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 283c9c3a611d..d417e189f1a0 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -868,7 +868,7 @@ static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
 	} else {
 		void *mptr;
 
-		mptr = erofs_read_metabuf(&map->buf, sb, blknr, EROFS_NO_KMAP);
+		mptr = erofs_read_metabuf(&map->buf, sb, erofs_pos(sb, blknr), EROFS_NO_KMAP);
 		if (IS_ERR(mptr)) {
 			ret = PTR_ERR(mptr);
 			erofs_err(sb, "failed to get inline data %d", ret);
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index e313c936351d..bd8dfe8c65ae 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -34,7 +34,7 @@ static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m,
 	unsigned int advise, type;
 
 	m->kaddr = erofs_read_metabuf(&m->map->buf, inode->i_sb,
-				      erofs_blknr(inode->i_sb, pos), EROFS_KMAP);
+				      erofs_pos(inode->i_sb, erofs_blknr(inode->i_sb, pos)), EROFS_KMAP);
 	if (IS_ERR(m->kaddr))
 		return PTR_ERR(m->kaddr);
 
@@ -267,7 +267,7 @@ static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
 out:
 	pos += lcn * (1 << amortizedshift);
 	m->kaddr = erofs_read_metabuf(&m->map->buf, inode->i_sb,
-				      erofs_blknr(inode->i_sb, pos), EROFS_KMAP);
+				      erofs_pos(inode->i_sb, erofs_blknr(inode->i_sb, pos)), EROFS_KMAP);
 	if (IS_ERR(m->kaddr))
 		return PTR_ERR(m->kaddr);
 	return unpack_compacted_index(m, amortizedshift, pos, lookahead);
@@ -600,7 +600,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 		goto out_unlock;
 
 	pos = ALIGN(erofs_iloc(inode) + vi->inode_isize + vi->xattr_isize, 8);
-	kaddr = erofs_read_metabuf(&buf, sb, erofs_blknr(sb, pos), EROFS_KMAP);
+	kaddr = erofs_read_metabuf(&buf, sb, erofs_pos(sb, erofs_blknr(sb, pos)), EROFS_KMAP);
 	if (IS_ERR(kaddr)) {
 		err = PTR_ERR(kaddr);
 		goto out_unlock;
-- 
2.39.2


