Return-Path: <linux-fsdevel+bounces-17822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AF28B293D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 21:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47984B22D4A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 19:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBB1152537;
	Thu, 25 Apr 2024 19:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="XGKM8zIT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF22152166;
	Thu, 25 Apr 2024 19:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714075112; cv=none; b=tQYhfrEO3vgu66vqgBYMCvzZdZJyFvgNzx/JA2MudfUjCsrzh1ISKvlkPeI9zryKJJw6d8Pa8hKcmTp78azxhyZAntYKExXoJRBrM0JMGx7V3l2iq4YKM25s1nowoGmemqYG90XXKCBGW6dZskwVMTMSLZERQURUGooy9zk3NPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714075112; c=relaxed/simple;
	bh=nas/w08zyV0TZi8IdI5OI+D0kIt9HDk8qL3OoxETo9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAuvCpaPco4uhdqlxiqF0SsDDzzo3/4gO2qaa7mplSz+u95drMOQvE99uveVQ8PCK5tKqcbBAJqSBkCqLrOU3IC2uS8YOMtfGt4v9RL9mFM7tByZUhBEattw4FxyYMUx77EQr0I8GR0j0YhBKL4tqzEzyNoP0wPywdTz23i3xxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=XGKM8zIT; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ktqSjI1hUqgeMskeAz/m0WwXViXrpIEb5+pjPFdXFu0=; b=XGKM8zIT9prkwizrY6N6Pkm2uI
	SSwwDx+0s27EMJyvSfx7JBM6J8jOUAW7O3UgKxMs0Tjy6VD6f+kEqfpEMKch8XjXz6GQVZULa2yLK
	O3hGSC7g8m9ig4QB9QcQlIqmko4BZbLs5UVCrwgpWaPVPnbR+U8It0gNYimyzvz9wWNIw2wQOfjkh
	+IuRlLZcq31IYiNGjnUNMEpisANZpHpCvz0m41/tVPO85jBgiYBY4wvhAyXNUbzWRHXHZpr5F1Lbd
	q/5YogYs1anyKbgwf1YGNykJNjWaIgcWgCeRKMh/hh01t+d3YpWmwIEIxeu+7xgIKHlD1HXvGjmJI
	iQsN2g0Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s05Ea-004KT0-23;
	Thu, 25 Apr 2024 19:58:20 +0000
Date: Thu, 25 Apr 2024 20:58:20 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz, hch@lst.de,
	brauner@kernel.org, axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, yukuai3@huawei.com
Subject: [PATCH 2/6] erofs_buf: store address_space instead of inode
Message-ID: <20240425195820.GB1031757@ZenIV>
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

... seeing that ->i_mapping is the only thing we want from the inode.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/erofs/data.c     | 7 +++----
 fs/erofs/dir.c      | 2 +-
 fs/erofs/internal.h | 2 +-
 fs/erofs/namei.c    | 4 ++--
 fs/erofs/xattr.c    | 2 +-
 fs/erofs/zdata.c    | 2 +-
 6 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index d3c446dda2ff..e1a170e45c70 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -32,7 +32,6 @@ void erofs_put_metabuf(struct erofs_buf *buf)
 void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset,
 		  enum erofs_kmap_type type)
 {
-	struct inode *inode = buf->inode;
 	pgoff_t index = offset >> PAGE_SHIFT;
 	struct page *page = buf->page;
 	struct folio *folio;
@@ -42,7 +41,7 @@ void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset,
 		erofs_put_metabuf(buf);
 
 		nofs_flag = memalloc_nofs_save();
-		folio = read_cache_folio(inode->i_mapping, index, NULL, NULL);
+		folio = read_cache_folio(buf->mapping, index, NULL, NULL);
 		memalloc_nofs_restore(nofs_flag);
 		if (IS_ERR(folio))
 			return folio;
@@ -67,9 +66,9 @@ void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset,
 void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
 {
 	if (erofs_is_fscache_mode(sb))
-		buf->inode = EROFS_SB(sb)->s_fscache->inode;
+		buf->mapping = EROFS_SB(sb)->s_fscache->inode->i_mapping;
 	else
-		buf->inode = sb->s_bdev->bd_inode;
+		buf->mapping = sb->s_bdev->bd_inode->i_mapping;
 }
 
 void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
index 9d38f39bb4f7..2193a6710c8f 100644
--- a/fs/erofs/dir.c
+++ b/fs/erofs/dir.c
@@ -58,7 +58,7 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 	int err = 0;
 	bool initial = true;
 
-	buf.inode = dir;
+	buf.mapping = dir->i_mapping;
 	while (ctx->pos < dirsize) {
 		struct erofs_dirent *de;
 		unsigned int nameoff, maxsize;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 9e30c67c135c..12a179818897 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -223,7 +223,7 @@ enum erofs_kmap_type {
 };
 
 struct erofs_buf {
-	struct inode *inode;
+	struct address_space *mapping;
 	struct page *page;
 	void *base;
 	enum erofs_kmap_type kmap_type;
diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
index 11afa48996a3..c94d0c1608a8 100644
--- a/fs/erofs/namei.c
+++ b/fs/erofs/namei.c
@@ -99,7 +99,7 @@ static void *erofs_find_target_block(struct erofs_buf *target,
 		struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 		struct erofs_dirent *de;
 
-		buf.inode = dir;
+		buf.mapping = dir->i_mapping;
 		de = erofs_bread(&buf, erofs_pos(dir->i_sb, mid), EROFS_KMAP);
 		if (!IS_ERR(de)) {
 			const int nameoff = nameoff_from_disk(de->nameoff, bsz);
@@ -171,7 +171,7 @@ int erofs_namei(struct inode *dir, const struct qstr *name, erofs_nid_t *nid,
 
 	qn.name = name->name;
 	qn.end = name->name + name->len;
-	buf.inode = dir;
+	buf.mapping = dir->i_mapping;
 
 	ndirents = 0;
 	de = erofs_find_target_block(&buf, dir, &qn, &ndirents);
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index ec233917830a..a90d7d649739 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -483,7 +483,7 @@ int erofs_xattr_prefixes_init(struct super_block *sb)
 		return -ENOMEM;
 
 	if (sbi->packed_inode)
-		buf.inode = sbi->packed_inode;
+		buf.mapping = sbi->packed_inode->i_mapping;
 	else
 		erofs_init_metabuf(&buf, sb);
 
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 9ffdae7fcd5b..283c9c3a611d 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -936,7 +936,7 @@ static int z_erofs_read_fragment(struct super_block *sb, struct page *page,
 	if (!packed_inode)
 		return -EFSCORRUPTED;
 
-	buf.inode = packed_inode;
+	buf.mapping = packed_inode->i_mapping;
 	for (; cur < end; cur += cnt, pos += cnt) {
 		cnt = min_t(unsigned int, end - cur,
 			    sb->s_blocksize - erofs_blkoff(sb, pos));
-- 
2.39.2


