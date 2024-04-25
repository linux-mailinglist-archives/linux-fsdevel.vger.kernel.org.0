Return-Path: <linux-fsdevel+bounces-17821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6F38B293B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 21:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D5A9B2277E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 19:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3897152537;
	Thu, 25 Apr 2024 19:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="a3J1B5ml"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F99152166;
	Thu, 25 Apr 2024 19:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714075082; cv=none; b=KuAiBSrkgooIZ9j89p+mcYqqSTc5OI/bRpMcdLeUYT0wTGRcu0DegB9tz+pnzqvCjNIgr36OjiRuaof72bjEWen0rWYKswngB5vN0Cdr3vszV+b6k8ueczNEUjO4513oGUUOrbXyFqvqa3a6j8ovmI8/JZJAUq3EgynWwyJIOdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714075082; c=relaxed/simple;
	bh=Qei2dkGmLEsg/EqlWXkSpfcNCaa4+kxD1t9jtdMOCPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lioj6jHD0lCthnzidG3H/MkCJmlG9C9YEN9m2kgvlAegy/9gJ6/Kd59njZvRD7Ke8i/RY3jVT7/Y+xOc6cRN+lrioQWbR00PaXhmpLAs2jE6SdgCMrjUyJ+Cbs4B3bRZqEKTdLDXGzk7CHqd37llVBzaRqoGi1sMjGjbZvMtfJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=a3J1B5ml; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tmbsSLx1iFob20jdGtwskP1wQ/r0zfeicuEAyANX69E=; b=a3J1B5mlDlwQztc/1g5YXPHhCL
	9ISJmLS3MMKuYW00ko4AZ1cleNfVu+k3US7l2AJJHkrsq5UX9khFlf+faLN0EPbxcCtpgJABqLgPF
	wXQ5MtknKBhUTR7kgFdy1vpongDnGas3+MOACCOz3GZV+ryfSX3/6IlyhkHDQEReria6Lit7MwWVx
	g/YvALObYFG38ZrcM4n8uC7wdi8xueghfKL53Kq8+7tm/2anPtzAi2oesWFirse9BjoOfjeurk8Bz
	LiKVM6ujt+KTatSOKvKjkfBJ8vxE1kIVFxo4YrzafeptJYImhiJkWVVO3Iee7TpmyqokyElFyccN9
	FyGMuZJg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s05E5-004KRO-09;
	Thu, 25 Apr 2024 19:57:49 +0000
Date: Thu, 25 Apr 2024 20:57:49 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz, hch@lst.de,
	brauner@kernel.org, axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, yukuai3@huawei.com
Subject: [PATCH 1/6] erofs: switch erofs_bread() to passing offset instead of
 block number
Message-ID: <20240425195749.GA1031757@ZenIV>
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

Callers are happier that way, especially since we no longer need to
play with splitting offset into block number and offset within block,
passing the former to erofs_bread(), then adding the latter...

erofs_bread() always reads entire pages, anyway.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/erofs/data.c     |  5 ++---
 fs/erofs/dir.c      |  2 +-
 fs/erofs/internal.h |  2 +-
 fs/erofs/namei.c    |  2 +-
 fs/erofs/super.c    |  8 ++++----
 fs/erofs/xattr.c    | 35 +++++++++++++----------------------
 fs/erofs/zdata.c    |  4 ++--
 7 files changed, 24 insertions(+), 34 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 52524bd9698b..d3c446dda2ff 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -29,11 +29,10 @@ void erofs_put_metabuf(struct erofs_buf *buf)
  * Derive the block size from inode->i_blkbits to make compatible with
  * anonymous inode in fscache mode.
  */
-void *erofs_bread(struct erofs_buf *buf, erofs_blk_t blkaddr,
+void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset,
 		  enum erofs_kmap_type type)
 {
 	struct inode *inode = buf->inode;
-	erofs_off_t offset = (erofs_off_t)blkaddr << inode->i_blkbits;
 	pgoff_t index = offset >> PAGE_SHIFT;
 	struct page *page = buf->page;
 	struct folio *folio;
@@ -77,7 +76,7 @@ void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
 			 erofs_blk_t blkaddr, enum erofs_kmap_type type)
 {
 	erofs_init_metabuf(buf, sb);
-	return erofs_bread(buf, blkaddr, type);
+	return erofs_bread(buf, erofs_pos(sb, blkaddr), type);
 }
 
 static int erofs_map_blocks_flatmode(struct inode *inode,
diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
index b80abec0531a..9d38f39bb4f7 100644
--- a/fs/erofs/dir.c
+++ b/fs/erofs/dir.c
@@ -63,7 +63,7 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 		struct erofs_dirent *de;
 		unsigned int nameoff, maxsize;
 
-		de = erofs_bread(&buf, i, EROFS_KMAP);
+		de = erofs_bread(&buf, erofs_pos(sb, i), EROFS_KMAP);
 		if (IS_ERR(de)) {
 			erofs_err(sb, "fail to readdir of logical block %u of nid %llu",
 				  i, EROFS_I(dir)->nid);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 39c67119f43b..9e30c67c135c 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -409,7 +409,7 @@ void *erofs_read_metadata(struct super_block *sb, struct erofs_buf *buf,
 			  erofs_off_t *offset, int *lengthp);
 void erofs_unmap_metabuf(struct erofs_buf *buf);
 void erofs_put_metabuf(struct erofs_buf *buf);
-void *erofs_bread(struct erofs_buf *buf, erofs_blk_t blkaddr,
+void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset,
 		  enum erofs_kmap_type type);
 void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb);
 void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
index f0110a78acb2..11afa48996a3 100644
--- a/fs/erofs/namei.c
+++ b/fs/erofs/namei.c
@@ -100,7 +100,7 @@ static void *erofs_find_target_block(struct erofs_buf *target,
 		struct erofs_dirent *de;
 
 		buf.inode = dir;
-		de = erofs_bread(&buf, mid, EROFS_KMAP);
+		de = erofs_bread(&buf, erofs_pos(dir->i_sb, mid), EROFS_KMAP);
 		if (!IS_ERR(de)) {
 			const int nameoff = nameoff_from_disk(de->nameoff, bsz);
 			const int ndirents = nameoff / sizeof(*de);
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index c0eb139adb07..fdefc3772620 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -132,11 +132,11 @@ void *erofs_read_metadata(struct super_block *sb, struct erofs_buf *buf,
 	int len, i, cnt;
 
 	*offset = round_up(*offset, 4);
-	ptr = erofs_bread(buf, erofs_blknr(sb, *offset), EROFS_KMAP);
+	ptr = erofs_bread(buf, *offset, EROFS_KMAP);
 	if (IS_ERR(ptr))
 		return ptr;
 
-	len = le16_to_cpu(*(__le16 *)&ptr[erofs_blkoff(sb, *offset)]);
+	len = le16_to_cpu(*(__le16 *)ptr);
 	if (!len)
 		len = U16_MAX + 1;
 	buffer = kmalloc(len, GFP_KERNEL);
@@ -148,12 +148,12 @@ void *erofs_read_metadata(struct super_block *sb, struct erofs_buf *buf,
 	for (i = 0; i < len; i += cnt) {
 		cnt = min_t(int, sb->s_blocksize - erofs_blkoff(sb, *offset),
 			    len - i);
-		ptr = erofs_bread(buf, erofs_blknr(sb, *offset), EROFS_KMAP);
+		ptr = erofs_bread(buf, *offset, EROFS_KMAP);
 		if (IS_ERR(ptr)) {
 			kfree(buffer);
 			return ptr;
 		}
-		memcpy(buffer + i, ptr + erofs_blkoff(sb, *offset), cnt);
+		memcpy(buffer + i, ptr, cnt);
 		*offset += cnt;
 	}
 	return buffer;
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index b58316b49a43..ec233917830a 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -81,13 +81,13 @@ static int erofs_init_inode_xattrs(struct inode *inode)
 	it.pos = erofs_iloc(inode) + vi->inode_isize;
 
 	/* read in shared xattr array (non-atomic, see kmalloc below) */
-	it.kaddr = erofs_bread(&it.buf, erofs_blknr(sb, it.pos), EROFS_KMAP);
+	it.kaddr = erofs_bread(&it.buf, it.pos, EROFS_KMAP);
 	if (IS_ERR(it.kaddr)) {
 		ret = PTR_ERR(it.kaddr);
 		goto out_unlock;
 	}
 
-	ih = it.kaddr + erofs_blkoff(sb, it.pos);
+	ih = it.kaddr;
 	vi->xattr_name_filter = le32_to_cpu(ih->h_name_filter);
 	vi->xattr_shared_count = ih->h_shared_count;
 	vi->xattr_shared_xattrs = kmalloc_array(vi->xattr_shared_count,
@@ -102,16 +102,14 @@ static int erofs_init_inode_xattrs(struct inode *inode)
 	it.pos += sizeof(struct erofs_xattr_ibody_header);
 
 	for (i = 0; i < vi->xattr_shared_count; ++i) {
-		it.kaddr = erofs_bread(&it.buf, erofs_blknr(sb, it.pos),
-				       EROFS_KMAP);
+		it.kaddr = erofs_bread(&it.buf, it.pos, EROFS_KMAP);
 		if (IS_ERR(it.kaddr)) {
 			kfree(vi->xattr_shared_xattrs);
 			vi->xattr_shared_xattrs = NULL;
 			ret = PTR_ERR(it.kaddr);
 			goto out_unlock;
 		}
-		vi->xattr_shared_xattrs[i] = le32_to_cpu(*(__le32 *)
-				(it.kaddr + erofs_blkoff(sb, it.pos)));
+		vi->xattr_shared_xattrs[i] = le32_to_cpu(*(__le32 *)it.kaddr);
 		it.pos += sizeof(__le32);
 	}
 	erofs_put_metabuf(&it.buf);
@@ -185,12 +183,11 @@ static int erofs_xattr_copy_to_buffer(struct erofs_xattr_iter *it,
 	void *src;
 
 	for (processed = 0; processed < len; processed += slice) {
-		it->kaddr = erofs_bread(&it->buf, erofs_blknr(sb, it->pos),
-					EROFS_KMAP);
+		it->kaddr = erofs_bread(&it->buf, it->pos, EROFS_KMAP);
 		if (IS_ERR(it->kaddr))
 			return PTR_ERR(it->kaddr);
 
-		src = it->kaddr + erofs_blkoff(sb, it->pos);
+		src = it->kaddr;
 		slice = min_t(unsigned int, sb->s_blocksize -
 				erofs_blkoff(sb, it->pos), len - processed);
 		memcpy(it->buffer + it->buffer_ofs, src, slice);
@@ -208,8 +205,7 @@ static int erofs_listxattr_foreach(struct erofs_xattr_iter *it)
 	int err;
 
 	/* 1. handle xattr entry */
-	entry = *(struct erofs_xattr_entry *)
-			(it->kaddr + erofs_blkoff(it->sb, it->pos));
+	entry = *(struct erofs_xattr_entry *)it->kaddr;
 	it->pos += sizeof(struct erofs_xattr_entry);
 
 	base_index = entry.e_name_index;
@@ -259,8 +255,7 @@ static int erofs_getxattr_foreach(struct erofs_xattr_iter *it)
 	unsigned int slice, processed, value_sz;
 
 	/* 1. handle xattr entry */
-	entry = *(struct erofs_xattr_entry *)
-			(it->kaddr + erofs_blkoff(sb, it->pos));
+	entry = *(struct erofs_xattr_entry *)it->kaddr;
 	it->pos += sizeof(struct erofs_xattr_entry);
 	value_sz = le16_to_cpu(entry.e_value_size);
 
@@ -291,8 +286,7 @@ static int erofs_getxattr_foreach(struct erofs_xattr_iter *it)
 
 	/* 2. handle xattr name */
 	for (processed = 0; processed < entry.e_name_len; processed += slice) {
-		it->kaddr = erofs_bread(&it->buf, erofs_blknr(sb, it->pos),
-					EROFS_KMAP);
+		it->kaddr = erofs_bread(&it->buf, it->pos, EROFS_KMAP);
 		if (IS_ERR(it->kaddr))
 			return PTR_ERR(it->kaddr);
 
@@ -300,7 +294,7 @@ static int erofs_getxattr_foreach(struct erofs_xattr_iter *it)
 				sb->s_blocksize - erofs_blkoff(sb, it->pos),
 				entry.e_name_len - processed);
 		if (memcmp(it->name.name + it->infix_len + processed,
-			   it->kaddr + erofs_blkoff(sb, it->pos), slice))
+			   it->kaddr, slice))
 			return -ENOATTR;
 		it->pos += slice;
 	}
@@ -336,13 +330,11 @@ static int erofs_xattr_iter_inline(struct erofs_xattr_iter *it,
 	it->pos = erofs_iloc(inode) + vi->inode_isize + xattr_header_sz;
 
 	while (remaining) {
-		it->kaddr = erofs_bread(&it->buf, erofs_blknr(it->sb, it->pos),
-					EROFS_KMAP);
+		it->kaddr = erofs_bread(&it->buf, it->pos, EROFS_KMAP);
 		if (IS_ERR(it->kaddr))
 			return PTR_ERR(it->kaddr);
 
-		entry_sz = erofs_xattr_entry_size(it->kaddr +
-				erofs_blkoff(it->sb, it->pos));
+		entry_sz = erofs_xattr_entry_size(it->kaddr);
 		/* xattr on-disk corruption: xattr entry beyond xattr_isize */
 		if (remaining < entry_sz) {
 			DBG_BUGON(1);
@@ -375,8 +367,7 @@ static int erofs_xattr_iter_shared(struct erofs_xattr_iter *it,
 	for (i = 0; i < vi->xattr_shared_count; ++i) {
 		it->pos = erofs_pos(sb, sbi->xattr_blkaddr) +
 				vi->xattr_shared_xattrs[i] * sizeof(__le32);
-		it->kaddr = erofs_bread(&it->buf, erofs_blknr(sb, it->pos),
-					EROFS_KMAP);
+		it->kaddr = erofs_bread(&it->buf, it->pos, EROFS_KMAP);
 		if (IS_ERR(it->kaddr))
 			return PTR_ERR(it->kaddr);
 
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 3216b920d369..9ffdae7fcd5b 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -940,12 +940,12 @@ static int z_erofs_read_fragment(struct super_block *sb, struct page *page,
 	for (; cur < end; cur += cnt, pos += cnt) {
 		cnt = min_t(unsigned int, end - cur,
 			    sb->s_blocksize - erofs_blkoff(sb, pos));
-		src = erofs_bread(&buf, erofs_blknr(sb, pos), EROFS_KMAP);
+		src = erofs_bread(&buf, pos, EROFS_KMAP);
 		if (IS_ERR(src)) {
 			erofs_put_metabuf(&buf);
 			return PTR_ERR(src);
 		}
-		memcpy_to_page(page, cur, src + erofs_blkoff(sb, pos), cnt);
+		memcpy_to_page(page, cur, src, cnt);
 	}
 	erofs_put_metabuf(&buf);
 	return 0;
-- 
2.39.2


