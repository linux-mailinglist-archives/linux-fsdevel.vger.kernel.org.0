Return-Path: <linux-fsdevel+bounces-9040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E49983D50B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 09:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B84851F256F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 08:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A072B1AAC4;
	Fri, 26 Jan 2024 07:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Xjb5OzC/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BDB29CEB;
	Fri, 26 Jan 2024 07:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706253688; cv=none; b=EsLhLSIrcaHYdwWarDXeZ3r7V/PEvt/XAWYVQLGTEAiVeIO4nNMNvgeiZUEFUyf4wAgFs/JZ3Yz3uvEo7UuaI+cKS/m18o6UXgrKR6jdKSLTXIsgwwKulujjkQ4YpzaWzvOU0r1IKAFUhg8GfSa/ofxzeP0EbphwkohG7ofR3x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706253688; c=relaxed/simple;
	bh=COyy1DJiB/eIbsONRHi+Oz1etgAGUzR7mzSxa4AmNuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HRiq6XxGl0CJsje+e+Q6FtCyceBg2H3QkZ8VEHlaClf/4dWo4jAQMOCAnWTO22dlq8YO8DvjcRIZOVPX1nbrKOY9aCTMtiQmWsf7xQgXgM2XyLimvITb+98uAZDoqBqCUGVG7T+1Vkuy1kkEfblulk32ZHEzaFhzUblaIE8HPb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Xjb5OzC/; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706253681; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=vBYVt2s6HvfR/oouT1QKkutgOgH1lvtbeCB5EqxVH0c=;
	b=Xjb5OzC/IpQNxe/HkEiSnKNPhd4EULfe6LUBFsBWbkqyaR5lzeyVjBCAeuPG5Xe+nFTkA/7xawlKBjXkrCDlExvnJX1AoEbMqZZ+W/YTwOHgts6NayMP7NYPVTCWTaWTka/5XcWyEJT5TFFAkubMyA7O0YALNy+uQXXn3awgpYI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W.MyK51_1706253680;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W.MyK51_1706253680)
          by smtp.aliyun-inc.com;
          Fri, 26 Jan 2024 15:21:21 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	amir73il@gmail.com
Subject: [PATCH v2] fuse: add support for explicit export disabling
Date: Fri, 26 Jan 2024 15:21:20 +0800
Message-Id: <20240126072120.71867-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

open_by_handle_at(2) can fail with -ESTALE with a valid handle returned
by a previous name_to_handle_at(2) for evicted fuse inodes, which is
especially common when entry_valid_timeout is 0, e.g. when the fuse
daemon is in "cache=none" mode.

The time sequence is like:

	name_to_handle_at(2)	# succeed
	evict fuse inode
	open_by_handle_at(2)	# fail

The root cause is that, with 0 entry_valid_timeout, the dput() called in
name_to_handle_at(2) will trigger iput -> evict(), which will send
FUSE_FORGET to the daemon.  The following open_by_handle_at(2) will send
a new FUSE_LOOKUP request upon inode cache miss since the previous inode
eviction.  Then the fuse daemon may fail the FUSE_LOOKUP request with
-ENOENT as the cached metadata of the requested inode has already been
cleaned up during the previous FUSE_FORGET.  The returned -ENOENT is
treated as -ESTALE when open_by_handle_at(2) returns.

This confuses the application somehow, as open_by_handle_at(2) fails
when the previous name_to_handle_at(2) succeeds.  The returned errno is
also confusing as the requested file is not deleted and already there.
It is reasonable to fail name_to_handle_at(2) early in this case, after
which the application can fallback to open(2) to access files.

Since this issue typically appears when entry_valid_timeout is 0 which
is configured by the fuse daemon, the fuse daemon is the right person to
explicitly disable the export when required.

Also considering FUSE_EXPORT_SUPPORT actually indicates the support for
lookups of "." and "..", and there are existing fuse daemons supporting
export without FUSE_EXPORT_SUPPORT set, for compatibility, we add a new
INIT flag for such purpose.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
v2:
- rename to "fuse_export_fid_operations"
- bump FUSE_KERNEL_MINOR_VERSION

v1: https://lore.kernel.org/linux-fsdevel/20240124113042.44300-1-jefflexu@linux.alibaba.com/
RFC: https://lore.kernel.org/all/20240123093701.94166-1-jefflexu@linux.alibaba.com/
---
 fs/fuse/inode.c           | 11 ++++++++++-
 include/uapi/linux/fuse.h |  7 ++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 2a6d44f91729..eee200308482 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1110,6 +1110,11 @@ static struct dentry *fuse_get_parent(struct dentry *child)
 	return parent;
 }
 
+/* only for fid encoding; no support for file handle */
+static const struct export_operations fuse_export_fid_operations = {
+	.encode_fh	= fuse_encode_fh,
+};
+
 static const struct export_operations fuse_export_operations = {
 	.fh_to_dentry	= fuse_fh_to_dentry,
 	.fh_to_parent	= fuse_fh_to_parent,
@@ -1284,6 +1289,8 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 				fc->create_supp_group = 1;
 			if (flags & FUSE_DIRECT_IO_ALLOW_MMAP)
 				fc->direct_io_allow_mmap = 1;
+			if (flags & FUSE_NO_EXPORT_SUPPORT)
+				fm->sb->s_export_op = &fuse_export_fid_operations;
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -1330,7 +1337,8 @@ void fuse_send_init(struct fuse_mount *fm)
 		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
 		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_INIT_EXT |
 		FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP |
-		FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP;
+		FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP |
+		FUSE_NO_EXPORT_SUPPORT;
 #ifdef CONFIG_FUSE_DAX
 	if (fm->fc->dax)
 		flags |= FUSE_MAP_ALIGNMENT;
@@ -1527,6 +1535,7 @@ static int fuse_fill_super_submount(struct super_block *sb,
 	sb->s_bdi = bdi_get(parent_sb->s_bdi);
 
 	sb->s_xattr = parent_sb->s_xattr;
+	sb->s_export_op = parent_sb->s_export_op;
 	sb->s_time_gran = parent_sb->s_time_gran;
 	sb->s_blocksize = parent_sb->s_blocksize;
 	sb->s_blocksize_bits = parent_sb->s_blocksize_bits;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index e7418d15fe39..38d9f285a599 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -211,6 +211,9 @@
  *  7.39
  *  - add FUSE_DIRECT_IO_ALLOW_MMAP
  *  - add FUSE_STATX and related structures
+ *
+ *  7.40
+ *  - add FUSE_NO_EXPORT_SUPPORT
  */
 
 #ifndef _LINUX_FUSE_H
@@ -246,7 +249,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 39
+#define FUSE_KERNEL_MINOR_VERSION 40
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -410,6 +413,7 @@ struct fuse_file_lock {
  *			symlink and mknod (single group that matches parent)
  * FUSE_HAS_EXPIRE_ONLY: kernel supports expiry-only entry invalidation
  * FUSE_DIRECT_IO_ALLOW_MMAP: allow shared mmap in FOPEN_DIRECT_IO mode.
+ * FUSE_NO_EXPORT_SUPPORT: explicitly disable export support
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -449,6 +453,7 @@ struct fuse_file_lock {
 #define FUSE_CREATE_SUPP_GROUP	(1ULL << 34)
 #define FUSE_HAS_EXPIRE_ONLY	(1ULL << 35)
 #define FUSE_DIRECT_IO_ALLOW_MMAP (1ULL << 36)
+#define FUSE_NO_EXPORT_SUPPORT	(1ULL << 37)
 
 /* Obsolete alias for FUSE_DIRECT_IO_ALLOW_MMAP */
 #define FUSE_DIRECT_IO_RELAX	FUSE_DIRECT_IO_ALLOW_MMAP
-- 
2.19.1.6.gb485710b


