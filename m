Return-Path: <linux-fsdevel+bounces-12745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B167A8668DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 04:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA7DF1C216C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 03:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBB8199B8;
	Mon, 26 Feb 2024 03:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gTQKO4vv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDA9134B2;
	Mon, 26 Feb 2024 03:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708919688; cv=none; b=AfUp6ReRfprjfjaTsaJbI93buoUvhvf6ZEs1RPy8vaJJlzH4Z5veX5A68vpFK+Qp23aA3/DRdyk3dMN2/5LbfWjJRXhYGFDr6KByvGjbamgw0d852IBK74Cepu/hMOEXUJw+h54IyWYuHsig9x7ZlKqzOiIyxbSuCTQFReoGrqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708919688; c=relaxed/simple;
	bh=GXUfu3cwq5GRWXrnV144EJYNBllZKet9blYItIvgItM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kF+dRRotXGc2kcxGIvy2AfNb1Q6TjcIyKQlLQozF7BVB1D6VVEJRykZFmwnPR9PcTVqawd8RdsZL78e2ZIExqmJu8xthK6Lj4BL6EC81MAgfdR4PCwB4vCPmJgemUAzg0+dKZMowJ+6duo7QQv0AmzjKwpY/PfnfXx2HhqLEq7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gTQKO4vv; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708919677; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Zki5BlZ1UuJ2xtG5/ByiOc/gza7b7VV4+0LoubRXfeA=;
	b=gTQKO4vv3y7Nda/sQ8sGg2DMALTXDPx5H1JIbgzaoJl9llXQrcRcUe2BS9dtEqjdLDkxz6DoPcOZ9+WvKnVsZkhp2sZwljo3mOpNPQ+lwXDoOLSyFxIBnsLOGwcu2D+JGLI88nFN7DtsbUMRNA/1jixPKklTY7sCnKfxC+1pi24=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W1AMbWk_1708919675;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W1AMbWk_1708919675)
          by smtp.aliyun-inc.com;
          Mon, 26 Feb 2024 11:54:36 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	amir73il@gmail.com
Subject: [RESEND PATCH v2] fuse: add support for explicit export disabling
Date: Mon, 26 Feb 2024 11:54:35 +0800
Message-Id: <20240226035435.60194-1-jefflexu@linux.alibaba.com>
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

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
RESEND v2:
- rebase to fuse/for-next and resolve the code base conflict since the
  passthrough feature (no logic change since original v2)
- add "Reviewed-by" tag

v2: https://lore.kernel.org/all/20240126072120.71867-1-jefflexu@linux.alibaba.com/
v1: https://lore.kernel.org/linux-fsdevel/20240124113042.44300-1-jefflexu@linux.alibaba.com/
RFC: https://lore.kernel.org/all/20240123093701.94166-1-jefflexu@linux.alibaba.com/
---
 fs/fuse/inode.c           | 11 ++++++++++-
 include/uapi/linux/fuse.h |  3 +++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index c26a84439934..fb9a9a9c1f1b 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1119,6 +1119,11 @@ static struct dentry *fuse_get_parent(struct dentry *child)
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
@@ -1311,6 +1316,8 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 				fc->max_stack_depth = arg->max_stack_depth;
 				fm->sb->s_stack_depth = arg->max_stack_depth;
 			}
+			if (flags & FUSE_NO_EXPORT_SUPPORT)
+				fm->sb->s_export_op = &fuse_export_fid_operations;
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -1357,7 +1364,8 @@ void fuse_send_init(struct fuse_mount *fm)
 		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
 		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_INIT_EXT |
 		FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP |
-		FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP;
+		FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP |
+		FUSE_NO_EXPORT_SUPPORT;
 #ifdef CONFIG_FUSE_DAX
 	if (fm->fc->dax)
 		flags |= FUSE_MAP_ALIGNMENT;
@@ -1558,6 +1566,7 @@ static int fuse_fill_super_submount(struct super_block *sb,
 	sb->s_bdi = bdi_get(parent_sb->s_bdi);
 
 	sb->s_xattr = parent_sb->s_xattr;
+	sb->s_export_op = parent_sb->s_export_op;
 	sb->s_time_gran = parent_sb->s_time_gran;
 	sb->s_blocksize = parent_sb->s_blocksize;
 	sb->s_blocksize_bits = parent_sb->s_blocksize_bits;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 1162a47b6a42..a86c2cad65ad 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -215,6 +215,7 @@
  *  7.40
  *  - add max_stack_depth to fuse_init_out, add FUSE_PASSTHROUGH init flag
  *  - add backing_id to fuse_open_out, add FOPEN_PASSTHROUGH open flag
+ *  - add FUSE_NO_EXPORT_SUPPORT init flag
  */
 
 #ifndef _LINUX_FUSE_H
@@ -416,6 +417,7 @@ struct fuse_file_lock {
  *			symlink and mknod (single group that matches parent)
  * FUSE_HAS_EXPIRE_ONLY: kernel supports expiry-only entry invalidation
  * FUSE_DIRECT_IO_ALLOW_MMAP: allow shared mmap in FOPEN_DIRECT_IO mode.
+ * FUSE_NO_EXPORT_SUPPORT: explicitly disable export support
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -456,6 +458,7 @@ struct fuse_file_lock {
 #define FUSE_HAS_EXPIRE_ONLY	(1ULL << 35)
 #define FUSE_DIRECT_IO_ALLOW_MMAP (1ULL << 36)
 #define FUSE_PASSTHROUGH	(1ULL << 37)
+#define FUSE_NO_EXPORT_SUPPORT	(1ULL << 38)
 
 /* Obsolete alias for FUSE_DIRECT_IO_ALLOW_MMAP */
 #define FUSE_DIRECT_IO_RELAX	FUSE_DIRECT_IO_ALLOW_MMAP
-- 
2.19.1.6.gb485710b


