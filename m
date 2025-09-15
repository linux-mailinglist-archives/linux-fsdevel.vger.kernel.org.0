Return-Path: <linux-fsdevel+bounces-61388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8219EB57C19
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 336A316A742
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B07288C1E;
	Mon, 15 Sep 2025 12:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alH2z4oC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0753530BBB9
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 12:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757941063; cv=none; b=Spgqiaxazl60Gd6AAMfp7DebSSOWrI8xfl6DHetzEy7jezKRy9xLsACxl6WnE1kyi+rVQr0tHo+RHjv2yStaPYVQLgl11uiA7nAVQOZdfi2zMdXxmztSW2v2/e2lx2HCsRDypR2XcoUkQmSbHO6ypirnSsLH6PxJm8uw7kXapmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757941063; c=relaxed/simple;
	bh=jcVHviv/gB/HDpNwDk4TGCMQxJYeFOOotimZTALkvsU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r+3vWYk2MmRTBeF3Cs4ZS9geCw33+mLuurF8O0qLIdinNl75uvW3bVhb6wHUr4NjyEu+GleGfBTobm75U6doLPFvDAF1Qoz3tDhJmyOhsyRQ8ytFZURCPWppx83Viw2wEMvKv8n7YnhBKuAAa2Yg7Xy65Q9Qfx1YHvokVRXrqAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alH2z4oC; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ea3e223ba2so1156786f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 05:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757941059; x=1758545859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=swU0AsWVZwizv13Clp65jy6VbAC9/F0YRx/vbJM2Spc=;
        b=alH2z4oCTkfDE2+rHfJ6Y85suOMqHDlybv88Fs0pFz6rENF+nq1F81CrjG/01/om4l
         O02ugydVpcudEOjo+Rwc6wHUNWV7zU4OX8SKBzJGpsy/sUWvVETPXzxO+BlDJo11onIN
         E4cWDTULP9l0TvnLyt1oVOCFBEO2oHPLr2RhesDgAGzXD2Tp3q5oQEJ+tkir7NUkYcNR
         FemuNYCAPcznv/+kvq6/u4o4OBjd8xB7x8CVawOLdyWvcjWv2UMRV1tFdIfWA5eLkemz
         dZgJgHY+Gdp6KbkxQP1BaSXHD964l9hyw+3+w/lsVtZUX/R/ZioOV1S2AhG1W1Ch1cyq
         9i0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757941059; x=1758545859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=swU0AsWVZwizv13Clp65jy6VbAC9/F0YRx/vbJM2Spc=;
        b=SrvSdS3ilBFeEQ0dCp8lr930sgoWT418cTpT7q/+CHnWrnZvNlRjOiuMhCqb8MnOQ3
         +K1Hf5L1YyqSKJts3lX5Qi/XiAnDPrOPzbZbj2TBReQ7afew7wPHtiqBH/isUrBV7ECn
         Sxgmkiivv9mvQbDVCMmrlNr7McHeAg0Ukkxouk7xgKyXCDuKjcZ5/A/F82sHt/2X6h7y
         NeSmbc0EOOqA4xWsR6kyqUMp2Mf0Mg6YzDRHbOT1XxJtL4s19KN62Lle5i8hJfjFWa8x
         UroTuxpy9E1b7SXAON3gdoLUSx6BU/apo3HoCRlbUR1TDIGVa6dASuUWP6vkz+aCY3AY
         rXaA==
X-Forwarded-Encrypted: i=1; AJvYcCXrxbsWhozA/Z7/TGfKT5qGisONgojXpl2W54hIv/63g2G+DVZJiOBPAk7CnZzBGcJJ8SymoZXRozvX/Yf6@vger.kernel.org
X-Gm-Message-State: AOJu0YxHklVRatzQxMeO9qhztGjLJ+UJ1JuLEdi1m45ddgSBVxPYGvLJ
	bPhwBSnGdX3sze1ZBIibzoI+BjNAc1Z54IC5XYh7rWCT8/UOSQXsM0Eo3VPkCQ==
X-Gm-Gg: ASbGncszZBQY1FJ6brxH5tZlTxySny0gtrfq2d8CQJVTdw1WabYhredubF66FuW4p/Y
	at384Xxku0Xbjdx9nTtipYAckZb2mjBWuSGKcHzvk9l1C4+gNV81BZvJy3MkoysZBADZClSem3s
	WCBLgPrIEnYzf8RKXHhb2bO0xtvoA+j5w2SuZjCRvXVtHVNuMpw1opKyYtEmBwdOQCraf0Cpytn
	NFKzIs3TGz9Le/tBKlBrC4DsVN69rtvqsLemSjri7guhPyjV+zEs0b1I6Mcz1QltTX3nC+NNj1V
	V5eVNwEv4vcTpJUFBz6pag8LuxG9c14TQoglVUO6N2cn9TC0fHPEfxwgBO0e9o1uyrDATEzfJGM
	+X6OmZ1M3I6U82+CC/njd5+uAS+yPZAfp6vlWvRmQZNOgBkE9e3HnUfwodizZdvlhLvZyGN1Kna
	HA78i7D7baHC5+dXNw7w==
X-Google-Smtp-Source: AGHT+IEWqm0YcguIT1BBJFv+zF1F8vsCHbMKfo9H+kl6Ldkc6eNvo82ZEkR38f/MhmLCANUz320ezg==
X-Received: by 2002:a05:6000:2203:b0:3ea:b91f:8f4e with SMTP id ffacd0b85a97d-3eab91f942fmr3163865f8f.21.1757941058884;
        Mon, 15 Sep 2025 05:57:38 -0700 (PDT)
Received: from f.. (cst-prg-67-222.cust.vodafone.cz. [46.135.67.222])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0152ffc1sm93984575e9.3.2025.09.15.05.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 05:57:38 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: rename generic_delete_inode() and generic_drop_inode()
Date: Mon, 15 Sep 2025 14:57:29 +0200
Message-ID: <20250915125729.2027639-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

generic_delete_inode() is rather misleading for what the routine is
doing. inode_just_drop() should be much clearer.

The new naming is inconsistent with generic_drop_inode(), so rename that
one as well with inode_ as the suffix.

No functional changes.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

Generated on top of master with:
git grep --files-with-matches -E '(generic_delete_inode|generic_drop_inode)' | xargs sed -i 's/generic_delete_inode/inode_just_drop/; s/generic_drop_inode/inode_generic_drop/'

[is there a handier way?]

I'm not going to argue for the names and I'm not going to protest if
someone else submits their own sedpatch.

 Documentation/filesystems/porting.rst | 4 ++--
 Documentation/filesystems/vfs.rst     | 4 ++--
 block/bdev.c                          | 2 +-
 drivers/dax/super.c                   | 2 +-
 drivers/misc/ibmasm/ibmasmfs.c        | 2 +-
 drivers/usb/gadget/function/f_fs.c    | 2 +-
 drivers/usb/gadget/legacy/inode.c     | 2 +-
 fs/9p/vfs_super.c                     | 2 +-
 fs/afs/inode.c                        | 4 ++--
 fs/btrfs/inode.c                      | 2 +-
 fs/ceph/super.c                       | 2 +-
 fs/configfs/mount.c                   | 2 +-
 fs/efivarfs/super.c                   | 2 +-
 fs/ext4/super.c                       | 2 +-
 fs/f2fs/super.c                       | 2 +-
 fs/fuse/inode.c                       | 2 +-
 fs/gfs2/super.c                       | 2 +-
 fs/hostfs/hostfs_kern.c               | 2 +-
 fs/inode.c                            | 6 +++---
 fs/kernfs/mount.c                     | 2 +-
 fs/nfs/inode.c                        | 2 +-
 fs/ocfs2/dlmfs/dlmfs.c                | 2 +-
 fs/orangefs/super.c                   | 2 +-
 fs/overlayfs/super.c                  | 2 +-
 fs/pidfs.c                            | 2 +-
 fs/proc/inode.c                       | 2 +-
 fs/pstore/inode.c                     | 2 +-
 fs/ramfs/inode.c                      | 2 +-
 fs/smb/client/cifsfs.c                | 2 +-
 fs/ubifs/super.c                      | 2 +-
 fs/xfs/xfs_super.c                    | 2 +-
 include/linux/fs.h                    | 4 ++--
 kernel/bpf/inode.c                    | 2 +-
 mm/shmem.c                            | 2 +-
 34 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 85f590254f07..b5db45c0094c 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -340,8 +340,8 @@ of those. Caller makes sure async writeback cannot be running for the inode whil
 
 ->drop_inode() returns int now; it's called on final iput() with
 inode->i_lock held and it returns true if filesystems wants the inode to be
-dropped.  As before, generic_drop_inode() is still the default and it's been
-updated appropriately.  generic_delete_inode() is also alive and it consists
+dropped.  As before, inode_generic_drop() is still the default and it's been
+updated appropriately.  inode_just_drop() is also alive and it consists
 simply of return 1.  Note that all actual eviction work is done by caller after
 ->drop_inode() returns.
 
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 486a91633474..7a314eee6305 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -327,11 +327,11 @@ or bottom half).
 	inode->i_lock spinlock held.
 
 	This method should be either NULL (normal UNIX filesystem
-	semantics) or "generic_delete_inode" (for filesystems that do
+	semantics) or "inode_just_drop" (for filesystems that do
 	not want to cache inodes - causing "delete_inode" to always be
 	called regardless of the value of i_nlink)
 
-	The "generic_delete_inode()" behavior is equivalent to the old
+	The "inode_just_drop()" behavior is equivalent to the old
 	practice of using "force_delete" in the put_inode() case, but
 	does not have the races that the "force_delete()" approach had.
 
diff --git a/block/bdev.c b/block/bdev.c
index b77ddd12dc06..810707cca970 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -412,7 +412,7 @@ static const struct super_operations bdev_sops = {
 	.statfs = simple_statfs,
 	.alloc_inode = bdev_alloc_inode,
 	.free_inode = bdev_free_inode,
-	.drop_inode = generic_delete_inode,
+	.drop_inode = inode_just_drop,
 	.evict_inode = bdev_evict_inode,
 };
 
diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 54c480e874cb..d7714d8afb0f 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -388,7 +388,7 @@ static const struct super_operations dax_sops = {
 	.alloc_inode = dax_alloc_inode,
 	.destroy_inode = dax_destroy_inode,
 	.free_inode = dax_free_inode,
-	.drop_inode = generic_delete_inode,
+	.drop_inode = inode_just_drop,
 };
 
 static int dax_init_fs_context(struct fs_context *fc)
diff --git a/drivers/misc/ibmasm/ibmasmfs.c b/drivers/misc/ibmasm/ibmasmfs.c
index c44de892a61e..5372ed2a363e 100644
--- a/drivers/misc/ibmasm/ibmasmfs.c
+++ b/drivers/misc/ibmasm/ibmasmfs.c
@@ -94,7 +94,7 @@ static int ibmasmfs_init_fs_context(struct fs_context *fc)
 
 static const struct super_operations ibmasmfs_s_ops = {
 	.statfs		= simple_statfs,
-	.drop_inode	= generic_delete_inode,
+	.drop_inode	= inode_just_drop,
 };
 
 static const struct file_operations *ibmasmfs_dir_ops = &simple_dir_operations;
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 08a251df20c4..5246fa6af3d6 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1891,7 +1891,7 @@ static struct dentry *ffs_sb_create_file(struct super_block *sb,
 /* Super block */
 static const struct super_operations ffs_sb_operations = {
 	.statfs =	simple_statfs,
-	.drop_inode =	generic_delete_inode,
+	.drop_inode =	inode_just_drop,
 };
 
 struct ffs_sb_fill_data {
diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index b51e132b0cd2..13c3da49348c 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -2011,7 +2011,7 @@ gadgetfs_create_file (struct super_block *sb, char const *name,
 
 static const struct super_operations gadget_fs_operations = {
 	.statfs =	simple_statfs,
-	.drop_inode =	generic_delete_inode,
+	.drop_inode =	inode_just_drop,
 };
 
 static int
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 795c6388744c..1581ebac5bb4 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -252,7 +252,7 @@ static int v9fs_drop_inode(struct inode *inode)
 
 	v9ses = v9fs_inode2v9ses(inode);
 	if (v9ses->cache & (CACHE_META|CACHE_LOOSE))
-		return generic_drop_inode(inode);
+		return inode_generic_drop(inode);
 	/*
 	 * in case of non cached mode always drop the
 	 * inode because we want the inode attribute
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index e9538e91f848..e1cb17b85791 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -723,9 +723,9 @@ int afs_drop_inode(struct inode *inode)
 	_enter("");
 
 	if (test_bit(AFS_VNODE_PSEUDODIR, &AFS_FS_I(inode)->flags))
-		return generic_delete_inode(inode);
+		return inode_just_drop(inode);
 	else
-		return generic_drop_inode(inode);
+		return inode_generic_drop(inode);
 }
 
 /*
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e7218e78bff4..188e9eb9714b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7974,7 +7974,7 @@ int btrfs_drop_inode(struct inode *inode)
 	if (btrfs_root_refs(&root->root_item) == 0)
 		return 1;
 	else
-		return generic_drop_inode(inode);
+		return inode_generic_drop(inode);
 }
 
 static void init_once(void *foo)
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index c3eb651862c5..70dc9467f6a0 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -1042,7 +1042,7 @@ static const struct super_operations ceph_super_ops = {
 	.alloc_inode	= ceph_alloc_inode,
 	.free_inode	= ceph_free_inode,
 	.write_inode    = ceph_write_inode,
-	.drop_inode	= generic_delete_inode,
+	.drop_inode	= inode_just_drop,
 	.evict_inode	= ceph_evict_inode,
 	.sync_fs        = ceph_sync_fs,
 	.put_super	= ceph_put_super,
diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index 740f18b60c9d..456c4a2efb53 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -36,7 +36,7 @@ static void configfs_free_inode(struct inode *inode)
 
 static const struct super_operations configfs_ops = {
 	.statfs		= simple_statfs,
-	.drop_inode	= generic_delete_inode,
+	.drop_inode	= inode_just_drop,
 	.free_inode	= configfs_free_inode,
 };
 
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 4bb4002e3cdf..1f4d8ce56667 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -127,7 +127,7 @@ static int efivarfs_unfreeze_fs(struct super_block *sb);
 
 static const struct super_operations efivarfs_ops = {
 	.statfs = efivarfs_statfs,
-	.drop_inode = generic_delete_inode,
+	.drop_inode = inode_just_drop,
 	.alloc_inode = efivarfs_alloc_inode,
 	.free_inode = efivarfs_free_inode,
 	.show_options = efivarfs_show_options,
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 699c15db28a8..caac4067f777 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1417,7 +1417,7 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
 
 static int ext4_drop_inode(struct inode *inode)
 {
-	int drop = generic_drop_inode(inode);
+	int drop = inode_generic_drop(inode);
 
 	if (!drop)
 		drop = fscrypt_drop_inode(inode);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index e16c4e2830c2..63cf73409da6 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1768,7 +1768,7 @@ static int f2fs_drop_inode(struct inode *inode)
 		trace_f2fs_drop_inode(inode, 0);
 		return 0;
 	}
-	ret = generic_drop_inode(inode);
+	ret = inode_generic_drop(inode);
 	if (!ret)
 		ret = fscrypt_drop_inode(inode);
 	trace_f2fs_drop_inode(inode, ret);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 7ddfd2b3cc9c..fdecd5a90dee 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1209,7 +1209,7 @@ static const struct super_operations fuse_super_operations = {
 	.free_inode     = fuse_free_inode,
 	.evict_inode	= fuse_evict_inode,
 	.write_inode	= fuse_write_inode,
-	.drop_inode	= generic_delete_inode,
+	.drop_inode	= inode_just_drop,
 	.umount_begin	= fuse_umount_begin,
 	.statfs		= fuse_statfs,
 	.sync_fs	= fuse_sync_fs,
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index b42e2110084b..644b2d1e7276 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1050,7 +1050,7 @@ static int gfs2_drop_inode(struct inode *inode)
 	if (test_bit(SDF_EVICTING, &sdp->sd_flags))
 		return 1;
 
-	return generic_drop_inode(inode);
+	return inode_generic_drop(inode);
 }
 
 /**
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 01e516175bcd..1e1acf5775ab 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -261,7 +261,7 @@ static int hostfs_show_options(struct seq_file *seq, struct dentry *root)
 static const struct super_operations hostfs_sbops = {
 	.alloc_inode	= hostfs_alloc_inode,
 	.free_inode	= hostfs_free_inode,
-	.drop_inode	= generic_delete_inode,
+	.drop_inode	= inode_just_drop,
 	.evict_inode	= hostfs_evict_inode,
 	.statfs		= hostfs_statfs,
 	.show_options	= hostfs_show_options,
diff --git a/fs/inode.c b/fs/inode.c
index 01ebdc40021e..e580a0eb4992 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1838,11 +1838,11 @@ int insert_inode_locked4(struct inode *inode, unsigned long hashval,
 EXPORT_SYMBOL(insert_inode_locked4);
 
 
-int generic_delete_inode(struct inode *inode)
+int inode_just_drop(struct inode *inode)
 {
 	return 1;
 }
-EXPORT_SYMBOL(generic_delete_inode);
+EXPORT_SYMBOL(inode_just_drop);
 
 /*
  * Called when we're dropping the last reference
@@ -1866,7 +1866,7 @@ static void iput_final(struct inode *inode)
 	if (op->drop_inode)
 		drop = op->drop_inode(inode);
 	else
-		drop = generic_drop_inode(inode);
+		drop = inode_generic_drop(inode);
 
 	if (!drop &&
 	    !(inode->i_state & I_DONTCACHE) &&
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index e384a69fbece..76eaf64b9d9e 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -57,7 +57,7 @@ static int kernfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 
 const struct super_operations kernfs_sops = {
 	.statfs		= kernfs_statfs,
-	.drop_inode	= generic_delete_inode,
+	.drop_inode	= inode_just_drop,
 	.evict_inode	= kernfs_evict_inode,
 
 	.show_options	= kernfs_sop_show_options,
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 49df9debb1a6..43f09d8eb5e3 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -108,7 +108,7 @@ u64 nfs_compat_user_ino64(u64 fileid)
 
 int nfs_drop_inode(struct inode *inode)
 {
-	return NFS_STALE(inode) || generic_drop_inode(inode);
+	return NFS_STALE(inode) || inode_generic_drop(inode);
 }
 EXPORT_SYMBOL_GPL(nfs_drop_inode);
 
diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
index 5130ec44e5e1..807e2b758a5c 100644
--- a/fs/ocfs2/dlmfs/dlmfs.c
+++ b/fs/ocfs2/dlmfs/dlmfs.c
@@ -547,7 +547,7 @@ static const struct super_operations dlmfs_ops = {
 	.alloc_inode	= dlmfs_alloc_inode,
 	.free_inode	= dlmfs_free_inode,
 	.evict_inode	= dlmfs_evict_inode,
-	.drop_inode	= generic_delete_inode,
+	.drop_inode	= inode_just_drop,
 };
 
 static const struct inode_operations dlmfs_file_inode_operations = {
diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
index f3da840758e7..b46100a4f529 100644
--- a/fs/orangefs/super.c
+++ b/fs/orangefs/super.c
@@ -306,7 +306,7 @@ static const struct super_operations orangefs_s_ops = {
 	.free_inode = orangefs_free_inode,
 	.destroy_inode = orangefs_destroy_inode,
 	.write_inode = orangefs_write_inode,
-	.drop_inode = generic_delete_inode,
+	.drop_inode = inode_just_drop,
 	.statfs = orangefs_statfs,
 	.show_options = orangefs_show_options,
 };
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index df85a76597e9..bd3d7ba8fb95 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -280,7 +280,7 @@ static const struct super_operations ovl_super_operations = {
 	.alloc_inode	= ovl_alloc_inode,
 	.free_inode	= ovl_free_inode,
 	.destroy_inode	= ovl_destroy_inode,
-	.drop_inode	= generic_delete_inode,
+	.drop_inode	= inode_just_drop,
 	.put_super	= ovl_put_super,
 	.sync_fs	= ovl_sync_fs,
 	.statfs		= ovl_statfs,
diff --git a/fs/pidfs.c b/fs/pidfs.c
index 108e7527f837..d01729c5263a 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -718,7 +718,7 @@ static void pidfs_evict_inode(struct inode *inode)
 }
 
 static const struct super_operations pidfs_sops = {
-	.drop_inode	= generic_delete_inode,
+	.drop_inode	= inode_just_drop,
 	.evict_inode	= pidfs_evict_inode,
 	.statfs		= simple_statfs,
 };
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 129490151be1..d9b7ef122343 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -187,7 +187,7 @@ static int proc_show_options(struct seq_file *seq, struct dentry *root)
 const struct super_operations proc_sops = {
 	.alloc_inode	= proc_alloc_inode,
 	.free_inode	= proc_free_inode,
-	.drop_inode	= generic_delete_inode,
+	.drop_inode	= inode_just_drop,
 	.evict_inode	= proc_evict_inode,
 	.statfs		= simple_statfs,
 	.show_options	= proc_show_options,
diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 1a2e1185426c..b4e55c90f8dc 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -282,7 +282,7 @@ static int pstore_reconfigure(struct fs_context *fc)
 
 static const struct super_operations pstore_ops = {
 	.statfs		= simple_statfs,
-	.drop_inode	= generic_delete_inode,
+	.drop_inode	= inode_just_drop,
 	.evict_inode	= pstore_evict_inode,
 	.show_options	= pstore_show_options,
 };
diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index f8874c3b8c1e..41f9995da7ca 100644
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -215,7 +215,7 @@ static int ramfs_show_options(struct seq_file *m, struct dentry *root)
 
 static const struct super_operations ramfs_ops = {
 	.statfs		= simple_statfs,
-	.drop_inode	= generic_delete_inode,
+	.drop_inode	= inode_just_drop,
 	.show_options	= ramfs_show_options,
 };
 
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index e1848276bab4..b0e84ca5d268 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -857,7 +857,7 @@ static int cifs_drop_inode(struct inode *inode)
 
 	/* no serverino => unconditional eviction */
 	return !(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SERVER_INUM) ||
-		generic_drop_inode(inode);
+		inode_generic_drop(inode);
 }
 
 static const struct super_operations cifs_super_ops = {
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index f3e3b2068608..733fd1e5a9a2 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -335,7 +335,7 @@ static int ubifs_write_inode(struct inode *inode, struct writeback_control *wbc)
 
 static int ubifs_drop_inode(struct inode *inode)
 {
-	int drop = generic_drop_inode(inode);
+	int drop = inode_generic_drop(inode);
 
 	if (!drop)
 		drop = fscrypt_drop_inode(inode);
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index bb0a82635a77..a05ff68748dc 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -778,7 +778,7 @@ xfs_fs_drop_inode(
 		return 0;
 	}
 
-	return generic_drop_inode(inode);
+	return inode_generic_drop(inode);
 }
 
 STATIC void
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 601d036a6c78..72fe62a65a38 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3314,8 +3314,8 @@ extern void address_space_init_once(struct address_space *mapping);
 extern struct inode * igrab(struct inode *);
 extern ino_t iunique(struct super_block *, ino_t);
 extern int inode_needs_sync(struct inode *inode);
-extern int generic_delete_inode(struct inode *inode);
-static inline int generic_drop_inode(struct inode *inode)
+extern int inode_just_drop(struct inode *inode);
+static inline int inode_generic_drop(struct inode *inode)
 {
 	return !inode->i_nlink || inode_unhashed(inode);
 }
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 5c2e96b19392..6d021d18afa6 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -788,7 +788,7 @@ static void bpf_free_inode(struct inode *inode)
 
 const struct super_operations bpf_super_ops = {
 	.statfs		= simple_statfs,
-	.drop_inode	= generic_delete_inode,
+	.drop_inode	= inode_just_drop,
 	.show_options	= bpf_show_options,
 	.free_inode	= bpf_free_inode,
 };
diff --git a/mm/shmem.c b/mm/shmem.c
index e2c76a30802b..932727247c64 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -5341,7 +5341,7 @@ static const struct super_operations shmem_ops = {
 	.get_dquots	= shmem_get_dquots,
 #endif
 	.evict_inode	= shmem_evict_inode,
-	.drop_inode	= generic_delete_inode,
+	.drop_inode	= inode_just_drop,
 	.put_super	= shmem_put_super,
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	.nr_cached_objects	= shmem_unused_huge_count,
-- 
2.43.0


