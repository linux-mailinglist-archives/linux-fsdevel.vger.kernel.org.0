Return-Path: <linux-fsdevel+bounces-73599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DCDD1C904
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 06:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A76D31D6A74
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 04:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2026032ABF9;
	Wed, 14 Jan 2026 04:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="sydw1VNi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7887C2ECD32;
	Wed, 14 Jan 2026 04:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768365166; cv=none; b=FB0wqHXToKnjvA6g2YIA7IMDjuktjQDrwVzZRySb3ofgDhZu6SaO4CSgynzvtJ1dtYBEsjiy3XN+ygZ6M9M56fKPgTus1IA0QezWfO6U7Vu0dLTo812S6J4hlwwRq9boZFJGizyX7SFG3nmQAk1tBLqNIx07Hn/wsVg201hkfog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768365166; c=relaxed/simple;
	bh=dE58klLdJyYeLgmYgH2S9UY8ti9ZdbpVbR2JG3eQ58s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pv0tQv7xFPpZ7Q84rmqaURCkz81S5mYNTbPBHhm9WUPDnqR1B51MknQjZLfC11kV1dxmQ30+fZ/XaXAOexxyJ9S/cpZnEfSAJnNTKjUH1s1mPFKjVM4VnZsOSksTq8kIAffKWgDBY5Wbmx7QGLTLOjkQJvjLkFIz5IE8oqNSiNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=sydw1VNi; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NoKL1OH7YXcP+lrXLXeIuIs7vol+bgLYWcjnamU1jiw=; b=sydw1VNiFb7DVAa9E1+U17CpJc
	jlx9yqIBUtkJFonN/bbjdrl5pxrwEwonpw+81suoKR9Ss14c6LM40rxZ4aM9DSU1pdmB5mqONmf6Y
	e8DH98O3v+IDOwIocQNTzKDuNvF1mduFTb5a1kOu1W2R9y0coS39h7ohYsK7IH4i+GLNkmOS2ONy0
	lUKgHn4l+1eGxAq+ZRgxNZTb6aGT9559DI7Rz5Kw84srvxDTbJ6Ef+WEeJlhjNxRmiTaJzYjjuGIG
	lH+aC2EjuzXfM5P/ieRqYx4bbkjuKnbI/rNWqNzdM5rH87nFG1/DoHek81fis3zusa7SrADMbewS2
	1RBfnIDw==;
Received: from [177.139.22.247] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vfsYT-0057lT-Rz; Wed, 14 Jan 2026 05:32:26 +0100
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Wed, 14 Jan 2026 01:31:41 -0300
Subject: [PATCH 1/3] exportfs: Rename get_uuid() to get_disk_uuid()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260114-tonyk-get_disk_uuid-v1-1-e6a319e25d57@igalia.com>
References: <20260114-tonyk-get_disk_uuid-v1-0-e6a319e25d57@igalia.com>
In-Reply-To: <20260114-tonyk-get_disk_uuid-v1-0-e6a319e25d57@igalia.com>
To: Christoph Hellwig <hch@lst.de>, Chuck Lever <chuck.lever@oracle.com>, 
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Carlos Maiolino <cem@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Chris Mason <clm@fb.com>, 
 David Sterba <dsterba@suse.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
 kernel-dev@igalia.com, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.3

To make clear which UUID is being returned, rename get_uuid() to
get_disk_uuid(). Expand the function documentation to note that this
function can be also used for filesystem that supports cloned devices
that might have different UUIDs for userspace tools, while having the
same UUID for internal usage.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 fs/nfsd/blocklayout.c    | 2 +-
 fs/nfsd/nfs4layouts.c    | 2 +-
 fs/xfs/xfs_export.c      | 2 +-
 fs/xfs/xfs_pnfs.c        | 2 +-
 fs/xfs/xfs_pnfs.h        | 2 +-
 include/linux/exportfs.h | 8 +++++---
 6 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index afa16d7a8013..713a1f69f8fe 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -218,7 +218,7 @@ nfsd4_block_get_device_info_simple(struct super_block *sb,
 
 	b->type = PNFS_BLOCK_VOLUME_SIMPLE;
 	b->simple.sig_len = PNFS_BLOCK_UUID_LEN;
-	return sb->s_export_op->get_uuid(sb, b->simple.sig, &b->simple.sig_len,
+	return sb->s_export_op->get_disk_uuid(sb, b->simple.sig, &b->simple.sig_len,
 			&b->simple.offset);
 }
 
diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index ad7af8cfcf1f..50bb29b2017c 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -136,7 +136,7 @@ void nfsd4_setup_layout_type(struct svc_export *exp)
 	exp->ex_layout_types |= 1 << LAYOUT_FLEX_FILES;
 #endif
 #ifdef CONFIG_NFSD_BLOCKLAYOUT
-	if (sb->s_export_op->get_uuid &&
+	if (sb->s_export_op->get_disk_uuid &&
 	    sb->s_export_op->map_blocks &&
 	    sb->s_export_op->commit_blocks)
 		exp->ex_layout_types |= 1 << LAYOUT_BLOCK_VOLUME;
diff --git a/fs/xfs/xfs_export.c b/fs/xfs/xfs_export.c
index 201489d3de08..d09570ba7445 100644
--- a/fs/xfs/xfs_export.c
+++ b/fs/xfs/xfs_export.c
@@ -244,7 +244,7 @@ const struct export_operations xfs_export_operations = {
 	.get_parent		= xfs_fs_get_parent,
 	.commit_metadata	= xfs_fs_nfs_commit_metadata,
 #ifdef CONFIG_EXPORTFS_BLOCK_OPS
-	.get_uuid		= xfs_fs_get_uuid,
+	.get_disk_uuid		= xfs_fs_get_disk_uuid,
 	.map_blocks		= xfs_fs_map_blocks,
 	.commit_blocks		= xfs_fs_commit_blocks,
 #endif
diff --git a/fs/xfs/xfs_pnfs.c b/fs/xfs/xfs_pnfs.c
index afe7497012d4..6ef7b29c4060 100644
--- a/fs/xfs/xfs_pnfs.c
+++ b/fs/xfs/xfs_pnfs.c
@@ -50,7 +50,7 @@ xfs_break_leased_layouts(
  * the exported device.
  */
 int
-xfs_fs_get_uuid(
+xfs_fs_get_disk_uuid(
 	struct super_block	*sb,
 	u8			*buf,
 	u32			*len,
diff --git a/fs/xfs/xfs_pnfs.h b/fs/xfs/xfs_pnfs.h
index 940c6c2ad88c..df82a6ba1a11 100644
--- a/fs/xfs/xfs_pnfs.h
+++ b/fs/xfs/xfs_pnfs.h
@@ -3,7 +3,7 @@
 #define _XFS_PNFS_H 1
 
 #ifdef CONFIG_EXPORTFS_BLOCK_OPS
-int xfs_fs_get_uuid(struct super_block *sb, u8 *buf, u32 *len, u64 *offset);
+int xfs_fs_get_disk_uuid(struct super_block *sb, u8 *buf, u32 *len, u64 *offset);
 int xfs_fs_map_blocks(struct inode *inode, loff_t offset, u64 length,
 		struct iomap *iomap, bool write, u32 *device_generation);
 int xfs_fs_commit_blocks(struct inode *inode, struct iomap *maps, int nr_maps,
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 262e24d83313..dc7029949a62 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -252,8 +252,10 @@ struct handle_to_path_ctx {
  * @commit_metadata:
  *    @commit_metadata should commit metadata changes to stable storage.
  *
- * @get_uuid:
- *    Get a filesystem unique signature exposed to clients.
+ * @get_disk_uuid:
+ *    Get a filesystem unique signature exposed to clients. It's also useful for
+ *    filesystems that support mounting cloned disks and export different UUIDs
+ *    for userspace, while being internally the same.
  *
  * @map_blocks:
  *    Map and, if necessary, allocate blocks for a layout.
@@ -282,7 +284,7 @@ struct export_operations {
 	struct dentry * (*get_parent)(struct dentry *child);
 	int (*commit_metadata)(struct inode *inode);
 
-	int (*get_uuid)(struct super_block *sb, u8 *buf, u32 *len, u64 *offset);
+	int (*get_disk_uuid)(struct super_block *sb, u8 *buf, u32 *len, u64 *offset);
 	int (*map_blocks)(struct inode *inode, loff_t offset,
 			  u64 len, struct iomap *iomap,
 			  bool write, u32 *device_generation);

-- 
2.52.0


