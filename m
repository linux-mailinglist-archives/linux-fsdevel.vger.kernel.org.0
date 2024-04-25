Return-Path: <linux-fsdevel+bounces-17824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD93F8B294B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 21:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9190DB23008
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 19:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B388B152DE7;
	Thu, 25 Apr 2024 19:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="HtDZ97MK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261A5152166;
	Thu, 25 Apr 2024 19:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714075166; cv=none; b=XQwQ9K4fXs2qlTOahDw8Vn3JSqxyiCy8oBM4D2hYI/ZAe0wtTx6htkFaAl0YRw+X1zfjGEXRwUfqE+MiHFkabuM0tSLmC1hQ+a+V9t9o2sCvovZn9znuzmEXun76HsJE7u95QrC3meYAJKYG9wEpuEl4WRWBtZ4oO2RGWr26eQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714075166; c=relaxed/simple;
	bh=kFlbBEiL22voI97PVU/DoT48kmzvaw42LvKkXcCKfUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lazv/ZPvAJMRNKyieDcJ8YIRkCEI6hB3Z0AaJsCnZV7XiTT17AMVabMkqt3lFx4h/jrfHX3siQZ5esNa6X8iL44ufGUuvWE0tPgu/kPy7UYvL6XhLSKNxuohsX7mSRwAM9lqOgo9XQmYkPTR4CNM62uxdLHPdZzXPfudyKTCloE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=HtDZ97MK; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oETcXxZ+PmslcrJt3u5E2BJoe4Qnj53CLY/P5riwlPw=; b=HtDZ97MKmBSIH67B6qmQ3GqDbL
	awX9Fy7rvaW01IqyAqAVcel8ZijA5CtxieB8LeCROulGfLzeT858o0Zm2xFKacAnXM8j8ADJPTjzu
	LKxq33wpa0zOFSaapq3aSW4vukn/ZI5rX2gE6GPzoQfNKgl4+T1QFA3nAHbFEnoyjrNi6rtPpOIad
	LYIhNfY5YJbr8uMn7parlDLJBbsL+tfrUhHp749lwNF/cZ+NTEF+c3z6WRvo7nYsWjsKB5z9oKseJ
	JqN+4b5ndHFFd1kf+yRq+ou4ZtzuPIEHo+1/rItChrYG6/WYukQoFGk/NPFrhyllQh+oYckUWuJUH
	MQATC9OA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s05FT-004KVQ-2D;
	Thu, 25 Apr 2024 19:59:15 +0000
Date: Thu, 25 Apr 2024 20:59:15 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz, hch@lst.de,
	brauner@kernel.org, axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, yukuai3@huawei.com
Subject: [PATCH 4/6] erofs: don't align offset for erofs_read_metabuf()
 (simple cases)
Message-ID: <20240425195915.GD1031757@ZenIV>
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

Most of the callers of erofs_read_metabuf() have the following form:

	block = erofs_blknr(sb, offset);
	off = erofs_blkoff(sb, offset);
	p = erofs_read_metabuf(...., erofs_pos(sb, block), ...);
	if (IS_ERR(p))
		return PTR_ERR(p);
	q = p + off;
	// no further uses of p, block or off.

The value passed to erofs_read_metabuf() is offset rounded down to block
size, i.e. offset - off.  Passing offset as-is would increase the return
value by off in case of success and keep the return value unchanged in
in case of error.  In other words, the same could be achieved by

	q = erofs_read_metabuf(...., offset, ...);
	if (IS_ERR(q))
		return PTR_ERR(q);

This commit convert these simple cases.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/erofs/data.c    | 11 +++++------
 fs/erofs/fscache.c | 12 +++---------
 fs/erofs/super.c   |  8 +++-----
 fs/erofs/zmap.c    |  8 +++-----
 4 files changed, 14 insertions(+), 25 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 82a196e02b5c..604d0bc82a0e 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -152,7 +152,7 @@ int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
 	pos = ALIGN(erofs_iloc(inode) + vi->inode_isize +
 		    vi->xattr_isize, unit) + unit * chunknr;
 
-	kaddr = erofs_read_metabuf(&buf, sb, erofs_pos(sb, erofs_blknr(sb, pos)), EROFS_KMAP);
+	kaddr = erofs_read_metabuf(&buf, sb, pos, EROFS_KMAP);
 	if (IS_ERR(kaddr)) {
 		err = PTR_ERR(kaddr);
 		goto out;
@@ -163,7 +163,7 @@ int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
 
 	/* handle block map */
 	if (!(vi->chunkformat & EROFS_CHUNK_FORMAT_INDEXES)) {
-		__le32 *blkaddr = kaddr + erofs_blkoff(sb, pos);
+		__le32 *blkaddr = kaddr;
 
 		if (le32_to_cpu(*blkaddr) == EROFS_NULL_ADDR) {
 			map->m_flags = 0;
@@ -174,7 +174,7 @@ int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
 		goto out_unlock;
 	}
 	/* parse chunk indexes */
-	idx = kaddr + erofs_blkoff(sb, pos);
+	idx = kaddr;
 	switch (le32_to_cpu(idx->blkaddr)) {
 	case EROFS_NULL_ADDR:
 		map->m_flags = 0;
@@ -294,11 +294,10 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 
 		iomap->type = IOMAP_INLINE;
-		ptr = erofs_read_metabuf(&buf, sb,
-				erofs_pos(sb, erofs_blknr(sb, mdev.m_pa)), EROFS_KMAP);
+		ptr = erofs_read_metabuf(&buf, sb, mdev.m_pa, EROFS_KMAP);
 		if (IS_ERR(ptr))
 			return PTR_ERR(ptr);
-		iomap->inline_data = ptr + erofs_blkoff(sb, mdev.m_pa);
+		iomap->inline_data = ptr;
 		iomap->private = buf.base;
 	} else {
 		iomap->type = IOMAP_MAPPED;
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 4df4617d99f2..c1b42392b854 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -273,21 +273,15 @@ static int erofs_fscache_data_read_slice(struct erofs_fscache_rq *req)
 	if (map.m_flags & EROFS_MAP_META) {
 		struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 		struct iov_iter iter;
-		erofs_blk_t blknr;
-		size_t offset, size;
+		size_t size = map.m_llen;
 		void *src;
 
-		/* For tail packing layout, the offset may be non-zero. */
-		offset = erofs_blkoff(sb, map.m_pa);
-		blknr = erofs_blknr(sb, map.m_pa);
-		size = map.m_llen;
-
-		src = erofs_read_metabuf(&buf, sb, erofs_pos(sb, blknr), EROFS_KMAP);
+		src = erofs_read_metabuf(&buf, sb, map.m_pa, EROFS_KMAP);
 		if (IS_ERR(src))
 			return PTR_ERR(src);
 
 		iov_iter_xarray(&iter, ITER_DEST, &mapping->i_pages, pos, PAGE_SIZE);
-		if (copy_to_iter(src + offset, size, &iter) != size) {
+		if (copy_to_iter(src, size, &iter) != size) {
 			erofs_put_metabuf(&buf);
 			return -EFAULT;
 		}
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 5466118c7e2d..49dc34ea70b2 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -178,12 +178,10 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 	struct erofs_fscache *fscache;
 	struct erofs_deviceslot *dis;
 	struct file *bdev_file;
-	void *ptr;
 
-	ptr = erofs_read_metabuf(buf, sb, erofs_pos(sb, erofs_blknr(sb, *pos)), EROFS_KMAP);
-	if (IS_ERR(ptr))
-		return PTR_ERR(ptr);
-	dis = ptr + erofs_blkoff(sb, *pos);
+	dis = erofs_read_metabuf(buf, sb, *pos, EROFS_KMAP);
+	if (IS_ERR(dis))
+		return PTR_ERR(dis);
 
 	if (!sbi->devs->flatdev && !dif->path) {
 		if (!dis->tag[0]) {
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index bd8dfe8c65ae..7c7151c22067 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -580,7 +580,6 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 	int err, headnr;
 	erofs_off_t pos;
 	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
-	void *kaddr;
 	struct z_erofs_map_header *h;
 
 	if (test_bit(EROFS_I_Z_INITED_BIT, &vi->flags)) {
@@ -600,13 +599,12 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 		goto out_unlock;
 
 	pos = ALIGN(erofs_iloc(inode) + vi->inode_isize + vi->xattr_isize, 8);
-	kaddr = erofs_read_metabuf(&buf, sb, erofs_pos(sb, erofs_blknr(sb, pos)), EROFS_KMAP);
-	if (IS_ERR(kaddr)) {
-		err = PTR_ERR(kaddr);
+	h = erofs_read_metabuf(&buf, sb, pos, EROFS_KMAP);
+	if (IS_ERR(h)) {
+		err = PTR_ERR(h);
 		goto out_unlock;
 	}
 
-	h = kaddr + erofs_blkoff(sb, pos);
 	/*
 	 * if the highest bit of the 8-byte map header is set, the whole file
 	 * is stored in the packed inode. The rest bits keeps z_fragmentoff.
-- 
2.39.2


