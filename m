Return-Path: <linux-fsdevel+bounces-62241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C981B8A695
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 17:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 777151CC3B04
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 15:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEEC32126D;
	Fri, 19 Sep 2025 15:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RaP8P1n8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB899320A39
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 15:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758296968; cv=none; b=DPHq/yu/c2gRT97AC0UEN+MBqveEMoI5+UIe53Y4hv54aceGkzimd+wMZPU4b/mg8c8yMdBrxY+CDrbgcsNnENtzBm8Fcd0oFBMBdFrKXyDZDZBE1buw0gEQnQqXRgOXo30Q9QBpnVtHsF7V8uw/gGgWybbKeVz+pBkcisp7STQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758296968; c=relaxed/simple;
	bh=pM2xUJuNqKJd4XlX1NlEarESrghBDT/wxfRF9NIgh30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uBOnQW8JwO3QMegbA3Hg7+bRDvnhT7ZgP/LNHdxzw9rCLgYidUQd5X6lrxJnESJmRlNqFMNchNTIl62/RFQXgZcU7YXWHt6BlvPq7IHWxa/gcIH7MM0hCHCK5Cw+HXohMecgxIuHqAhsmGdimIL7KIQB09YuWykVhHH0P94k8PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RaP8P1n8; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4694ac46ae0so7013405e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 08:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758296960; x=1758901760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dv1hM5NYS+F2Eb5ms6/xtXEuAQvfscCpBEMVD649Tok=;
        b=RaP8P1n8mKfFksqhZ8UdzXuug8CH6axYLz1sUla7SghdK72EzUv6FEXoeYqFNdPDo8
         7VMMS6V6DcsgfvLPIMFOjiST12K7WSCzspdWZ7cS9+7nv1GSYB90YQBP2fN+ZZ6qUTxg
         rjfG1KZ6lAnzitUwRLJTGaIQaNiYGhvtdzuuH/mMKy5SJ1S1HOWD/fDJBZ/vM8Oy8S32
         m8k0jhh3Z1mQE1F9HO+bUfMNmTVJoYdsyfwo7n7aWShwXy/lDcan4rWqEq/8ER+hNr8M
         7pFP+YTjfE4xQiE93yKvAY5QnS5OOWcW3olRjMSKCuX1+kmDCQjVZ8fquHpTANNVyJcz
         GCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758296960; x=1758901760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dv1hM5NYS+F2Eb5ms6/xtXEuAQvfscCpBEMVD649Tok=;
        b=u9BXt8wodoFq+2vUIGdOuz7GklqKw0GRhhCN/WSdd9jepSJtYU8R5TvGCGU6/gAYYk
         s9wJ5zFThyof9LfKxH0/Wc3RnuJpmpL4/HoIOmtyfg7OPwWeCFWw+21lCNakpbKyVYzD
         IcH5+oG6dfRcDMjs5EYk0bOn60UsJQst+uVvLWvynu2J0W/BFNJRex6AKZDnpgcCHTEJ
         /afk83UVmH1VX+KN5GuqHsMBLglbu5JY/TU0F0Yyxgx4uVYL4k2kgk2eie9RRtLeBhkJ
         Sokjut4/nSXDj01YfCYRG5ouUTOezzhQnCo7mK6EKVVXGWm6wni/XXcouF9MTEZTo+v3
         memw==
X-Forwarded-Encrypted: i=1; AJvYcCWvJM7S1ihPhOSlQ+TQmJP7p+s/XzytaE3IwCnxpz39OFKV8HJSglGiRmbEOWFeUvy1OZfwp3d/b6xsGd5G@vger.kernel.org
X-Gm-Message-State: AOJu0YyzbxeKUcSIYxqLQqcK2PLB5scDV3KeWAzJHLpVDSXPsqbsU6WF
	Kk4UZseLFj6tOmMKfaeHM6mn502555tbW/7eE2aM6EDLEAw+UqwmNvq/
X-Gm-Gg: ASbGncv64/C3pEMozJNa3zH6o4KvbQwEwLLfADCAN/5Wtkvi+Vk2JHVe1oNmsANay64
	v5D9iKNyW8f66P3LDETuv24/EjNUMyT6x4+o5J/yXdiH6g7ZFcdnkvBmbSdrKdm4QoifKhlaHIv
	Al8O4hKI4sojEQ8n6u2SlT5ELtmU3r5cq9mF5J+bf53SViN49mRojFVn6soT6Z8+D8tmzEk4TCn
	W1l6XPSUsa4JT3QYWHi4qxeJJ9lI7/vJb80tRJ3r34i1Epsj7SZXNrhUt1cUuEd6Tvo4bv304Ps
	eD82na02HFy9naz+XKccWDs25LJGEPJjfw3vf1yHeQSXKEj/NSK/TwD1OcoSoMOEe7+3Qoxupl7
	5207x+CWPAGBP2nd2fjG8f4l0yKkOwANFXsm2kryR4+2bczOK8cZAbrpMijHAb1uAkblNVtoW
X-Google-Smtp-Source: AGHT+IEdtBhjbpwJEx3I7jx4pSgrpXq5MBRVQNXgRVP92tDrjE800a1wRKOD1fZI239kHyRFGbpqMw==
X-Received: by 2002:a05:600c:4ec9:b0:45c:17a:4c98 with SMTP id 5b1f17b1804b1-467f00c33bcmr29634125e9.19.1758296959209;
        Fri, 19 Sep 2025 08:49:19 -0700 (PDT)
Received: from f.. (cst-prg-88-146.cust.vodafone.cz. [46.135.88.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee073f53c4sm8446746f8f.3.2025.09.19.08.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 08:49:18 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com,
	kernel-team@fb.com,
	amir73il@gmail.com,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v5 2/4] Convert the kernel to use ->i_state accessors
Date: Fri, 19 Sep 2025 17:49:02 +0200
Message-ID: <20250919154905.2592318-3-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250919154905.2592318-1-mjguzik@gmail.com>
References: <20250919154905.2592318-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch fully generated with coccinelle with 2 small changes by hand.

Some spots failed to be converted, they are addressed in a separate
patch.

Both ext2 and nilfs2 have a field named ->i_state in their own
fs-private inodes. The script below also converts these spots resulting
in compilation failure (type mismatch). This was undone by hand.

The script:
@@
expression inode, flags;
@@

- inode->i_state & flags
+ inode_state_read(inode) & flags

@@
expression inode, flags;
@@

- inode->i_state &= ~flags
+ inode_state_del(inode, flags)

@@
expression inode, flag1, flag2;
@@

- inode->i_state &= ~flag1 & ~flag2
+ inode_state_del(inode, flag1 | flag2)

@@
expression inode, flags;
@@

- inode->i_state |= flags
+ inode_state_add(inode, flags)

@@
expression inode, flags;
@@

- inode->i_state = flags
+ inode_state_set(inode, flags)

@@
expression inode, flags;
@@

- flags = inode->i_state
+ flags = inode_state_read(inode)

@@
expression inode, flags;
@@

- READ_ONCE(inode->i_state) & flags
+ inode_state_read(inode) & flags

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 block/bdev.c                 |   4 +-
 drivers/dax/super.c          |   2 +-
 fs/9p/vfs_inode.c            |   2 +-
 fs/9p/vfs_inode_dotl.c       |   2 +-
 fs/affs/inode.c              |   2 +-
 fs/afs/dynroot.c             |   6 +-
 fs/afs/inode.c               |   6 +-
 fs/befs/linuxvfs.c           |   2 +-
 fs/bfs/inode.c               |   2 +-
 fs/btrfs/inode.c             |   2 +-
 fs/buffer.c                  |   4 +-
 fs/ceph/cache.c              |   2 +-
 fs/ceph/crypto.c             |   4 +-
 fs/ceph/file.c               |   4 +-
 fs/ceph/inode.c              |  28 ++++----
 fs/coda/cnode.c              |   4 +-
 fs/cramfs/inode.c            |   2 +-
 fs/crypto/keyring.c          |   2 +-
 fs/crypto/keysetup.c         |   2 +-
 fs/dcache.c                  |   6 +-
 fs/drop_caches.c             |   2 +-
 fs/ecryptfs/inode.c          |   6 +-
 fs/efs/inode.c               |   2 +-
 fs/erofs/inode.c             |   2 +-
 fs/ext2/inode.c              |   2 +-
 fs/ext4/inode.c              |  10 +--
 fs/ext4/orphan.c             |   4 +-
 fs/f2fs/data.c               |   2 +-
 fs/f2fs/inode.c              |   2 +-
 fs/f2fs/namei.c              |   4 +-
 fs/f2fs/super.c              |   2 +-
 fs/freevxfs/vxfs_inode.c     |   2 +-
 fs/fs-writeback.c            | 121 ++++++++++++++++++-----------------
 fs/fuse/inode.c              |   4 +-
 fs/gfs2/file.c               |   2 +-
 fs/gfs2/glops.c              |   2 +-
 fs/gfs2/inode.c              |   4 +-
 fs/gfs2/ops_fstype.c         |   2 +-
 fs/hfs/btree.c               |   2 +-
 fs/hfs/inode.c               |   2 +-
 fs/hfsplus/super.c           |   2 +-
 fs/hostfs/hostfs_kern.c      |   2 +-
 fs/hpfs/dir.c                |   2 +-
 fs/hpfs/inode.c              |   2 +-
 fs/inode.c                   |  92 +++++++++++++-------------
 fs/isofs/inode.c             |   2 +-
 fs/jffs2/fs.c                |   4 +-
 fs/jfs/file.c                |   4 +-
 fs/jfs/inode.c               |   2 +-
 fs/jfs/jfs_txnmgr.c          |   2 +-
 fs/kernfs/inode.c            |   2 +-
 fs/libfs.c                   |   6 +-
 fs/minix/inode.c             |   2 +-
 fs/namei.c                   |   8 +--
 fs/netfs/misc.c              |   8 +--
 fs/netfs/read_single.c       |   6 +-
 fs/nfs/inode.c               |   2 +-
 fs/nfs/pnfs.c                |   2 +-
 fs/nfsd/vfs.c                |   2 +-
 fs/nilfs2/cpfile.c           |   2 +-
 fs/nilfs2/dat.c              |   2 +-
 fs/nilfs2/ifile.c            |   2 +-
 fs/nilfs2/inode.c            |  10 +--
 fs/nilfs2/sufile.c           |   2 +-
 fs/notify/fsnotify.c         |   2 +-
 fs/ntfs3/inode.c             |   2 +-
 fs/ocfs2/dlmglue.c           |   2 +-
 fs/ocfs2/inode.c             |   8 +--
 fs/omfs/inode.c              |   2 +-
 fs/openpromfs/inode.c        |   2 +-
 fs/orangefs/inode.c          |   2 +-
 fs/orangefs/orangefs-utils.c |   6 +-
 fs/overlayfs/dir.c           |   2 +-
 fs/overlayfs/inode.c         |   6 +-
 fs/overlayfs/util.c          |  10 +--
 fs/pipe.c                    |   2 +-
 fs/qnx4/inode.c              |   2 +-
 fs/qnx6/inode.c              |   2 +-
 fs/quota/dquot.c             |   2 +-
 fs/romfs/super.c             |   2 +-
 fs/smb/client/cifsfs.c       |   2 +-
 fs/smb/client/inode.c        |  14 ++--
 fs/squashfs/inode.c          |   2 +-
 fs/sync.c                    |   2 +-
 fs/ubifs/file.c              |   2 +-
 fs/ubifs/super.c             |   2 +-
 fs/udf/inode.c               |   2 +-
 fs/ufs/inode.c               |   2 +-
 fs/xfs/scrub/common.c        |   2 +-
 fs/xfs/scrub/inode_repair.c  |   2 +-
 fs/xfs/scrub/parent.c        |   2 +-
 fs/xfs/xfs_bmap_util.c       |   2 +-
 fs/xfs/xfs_health.c          |   4 +-
 fs/xfs/xfs_icache.c          |   6 +-
 fs/xfs/xfs_inode.c           |   6 +-
 fs/xfs/xfs_inode_item.c      |   4 +-
 fs/xfs/xfs_iops.c            |   2 +-
 fs/zonefs/super.c            |   4 +-
 mm/backing-dev.c             |   2 +-
 security/landlock/fs.c       |   2 +-
 100 files changed, 279 insertions(+), 278 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index b77ddd12dc06..a25b8607039e 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -67,7 +67,7 @@ static void bdev_write_inode(struct block_device *bdev)
 	int ret;
 
 	spin_lock(&inode->i_lock);
-	while (inode->i_state & I_DIRTY) {
+	while (inode_state_read(inode) & I_DIRTY) {
 		spin_unlock(&inode->i_lock);
 		ret = write_inode_now(inode, true);
 		if (ret)
@@ -1265,7 +1265,7 @@ void sync_bdevs(bool wait)
 		struct block_device *bdev;
 
 		spin_lock(&inode->i_lock);
-		if (inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW) ||
+		if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW) ||
 		    mapping->nrpages == 0) {
 			spin_unlock(&inode->i_lock);
 			continue;
diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 54c480e874cb..a3c929158ace 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -433,7 +433,7 @@ static struct dax_device *dax_dev_get(dev_t devt)
 		return NULL;
 
 	dax_dev = to_dax_dev(inode);
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read(inode) & I_NEW) {
 		set_bit(DAXDEV_ALIVE, &dax_dev->flags);
 		inode->i_cdev = &dax_dev->cdev;
 		inode->i_mode = S_IFCHR;
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 399d455d50d6..bf43d6837da6 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -422,7 +422,7 @@ static struct inode *v9fs_qid_iget(struct super_block *sb,
 	inode = iget5_locked(sb, QID2INO(qid), test, v9fs_set_inode, st);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read(inode) & I_NEW))
 		return inode;
 	/*
 	 * initialize the inode with the stat info
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 5b5fda617b80..f65c406d3334 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -112,7 +112,7 @@ static struct inode *v9fs_qid_iget_dotl(struct super_block *sb,
 	inode = iget5_locked(sb, QID2INO(qid), test, v9fs_set_inode_dotl, st);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read(inode) & I_NEW))
 		return inode;
 	/*
 	 * initialize the inode with the stat info
diff --git a/fs/affs/inode.c b/fs/affs/inode.c
index 0210df8d3500..3a755303da15 100644
--- a/fs/affs/inode.c
+++ b/fs/affs/inode.c
@@ -29,7 +29,7 @@ struct inode *affs_iget(struct super_block *sb, unsigned long ino)
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read(inode) & I_NEW))
 		return inode;
 
 	pr_debug("affs_iget(%lu)\n", inode->i_ino);
diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index 8c6130789fde..d11aea57e2c4 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -64,7 +64,7 @@ static struct inode *afs_iget_pseudo_dir(struct super_block *sb, ino_t ino)
 
 	vnode = AFS_FS_I(inode);
 
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read(inode) & I_NEW) {
 		netfs_inode_init(&vnode->netfs, NULL, false);
 		simple_inode_init_ts(inode);
 		set_nlink(inode, 2);
@@ -258,7 +258,7 @@ static struct dentry *afs_lookup_atcell(struct inode *dir, struct dentry *dentry
 
 	vnode = AFS_FS_I(inode);
 
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read(inode) & I_NEW) {
 		netfs_inode_init(&vnode->netfs, NULL, false);
 		simple_inode_init_ts(inode);
 		set_nlink(inode, 1);
@@ -383,7 +383,7 @@ struct inode *afs_dynroot_iget_root(struct super_block *sb)
 	vnode = AFS_FS_I(inode);
 
 	/* there shouldn't be an existing inode */
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read(inode) & I_NEW) {
 		netfs_inode_init(&vnode->netfs, NULL, false);
 		simple_inode_init_ts(inode);
 		set_nlink(inode, 2);
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index e9538e91f848..c2dcd182a82c 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -579,7 +579,7 @@ struct inode *afs_iget(struct afs_operation *op, struct afs_vnode_param *vp)
 	       inode, vnode->fid.vid, vnode->fid.vnode, vnode->fid.unique);
 
 	/* deal with an existing inode */
-	if (!(inode->i_state & I_NEW)) {
+	if (!(inode_state_read(inode) & I_NEW)) {
 		_leave(" = %p", inode);
 		return inode;
 	}
@@ -639,7 +639,7 @@ struct inode *afs_root_iget(struct super_block *sb, struct key *key)
 
 	_debug("GOT ROOT INODE %p { vl=%llx }", inode, as->volume->vid);
 
-	BUG_ON(!(inode->i_state & I_NEW));
+	BUG_ON(!(inode_state_read(inode) & I_NEW));
 
 	vnode = AFS_FS_I(inode);
 	vnode->cb_v_check = atomic_read(&as->volume->cb_v_break);
@@ -748,7 +748,7 @@ void afs_evict_inode(struct inode *inode)
 
 	if ((S_ISDIR(inode->i_mode) ||
 	     S_ISLNK(inode->i_mode)) &&
-	    (inode->i_state & I_DIRTY) &&
+	    (inode_state_read(inode) & I_DIRTY) &&
 	    !sbi->dyn_root) {
 		struct writeback_control wbc = {
 			.sync_mode = WB_SYNC_ALL,
diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index 8f430ff8e445..ede8566503f0 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -307,7 +307,7 @@ static struct inode *befs_iget(struct super_block *sb, unsigned long ino)
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read(inode) & I_NEW))
 		return inode;
 
 	befs_ino = BEFS_I(inode);
diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
index 1d41ce477df5..367751102361 100644
--- a/fs/bfs/inode.c
+++ b/fs/bfs/inode.c
@@ -42,7 +42,7 @@ struct inode *bfs_iget(struct super_block *sb, unsigned long ino)
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read(inode) & I_NEW))
 		return inode;
 
 	if ((ino < BFS_ROOT_INO) || (ino > BFS_SB(inode->i_sb)->si_lasti)) {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5bcd8e25fa78..8e2ab3fb9070 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5317,7 +5317,7 @@ static void evict_inode_truncate_pages(struct inode *inode)
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	struct rb_node *node;
 
-	ASSERT(inode->i_state & I_FREEING);
+	ASSERT(inode_state_read(inode) & I_FREEING);
 	truncate_inode_pages_final(&inode->i_data);
 
 	btrfs_drop_extent_map_range(BTRFS_I(inode), 0, (u64)-1, false);
diff --git a/fs/buffer.c b/fs/buffer.c
index ead4dc85debd..0f95659cd2f6 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -611,9 +611,9 @@ int generic_buffers_fsync_noflush(struct file *file, loff_t start, loff_t end,
 		return err;
 
 	ret = sync_mapping_buffers(inode->i_mapping);
-	if (!(inode->i_state & I_DIRTY_ALL))
+	if (!(inode_state_read(inode) & I_DIRTY_ALL))
 		goto out;
-	if (datasync && !(inode->i_state & I_DIRTY_DATASYNC))
+	if (datasync && !(inode_state_read(inode) & I_DIRTY_DATASYNC))
 		goto out;
 
 	err = sync_inode_metadata(inode, 1);
diff --git a/fs/ceph/cache.c b/fs/ceph/cache.c
index 930fbd54d2c8..d99daae204b8 100644
--- a/fs/ceph/cache.c
+++ b/fs/ceph/cache.c
@@ -26,7 +26,7 @@ void ceph_fscache_register_inode_cookie(struct inode *inode)
 		return;
 
 	/* Only new inodes! */
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read(inode) & I_NEW))
 		return;
 
 	WARN_ON_ONCE(ci->netfs.cache);
diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index 7026e794813c..61d778c74b8b 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -329,7 +329,7 @@ int ceph_encode_encrypted_dname(struct inode *parent, char *buf, int elen)
 out:
 	kfree(cryptbuf);
 	if (dir != parent) {
-		if ((dir->i_state & I_NEW))
+		if ((inode_state_read(dir) & I_NEW))
 			discard_new_inode(dir);
 		else
 			iput(dir);
@@ -438,7 +438,7 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
 	fscrypt_fname_free_buffer(&_tname);
 out_inode:
 	if (dir != fname->dir) {
-		if ((dir->i_state & I_NEW))
+		if ((inode_state_read(dir) & I_NEW))
 			discard_new_inode(dir);
 		else
 			iput(dir);
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index c02f100f8552..21c6e0471325 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -744,7 +744,7 @@ static int ceph_finish_async_create(struct inode *dir, struct inode *inode,
 		      vino.ino, ceph_ino(dir), dentry->d_name.name);
 		ceph_dir_clear_ordered(dir);
 		ceph_init_inode_acls(inode, as_ctx);
-		if (inode->i_state & I_NEW) {
+		if (inode_state_read(inode) & I_NEW) {
 			/*
 			 * If it's not I_NEW, then someone created this before
 			 * we got here. Assume the server is aware of it at
@@ -907,7 +907,7 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 				new_inode = NULL;
 				goto out_req;
 			}
-			WARN_ON_ONCE(!(new_inode->i_state & I_NEW));
+			WARN_ON_ONCE(!(inode_state_read(new_inode) & I_NEW));
 
 			spin_lock(&dentry->d_lock);
 			di->flags |= CEPH_DENTRY_ASYNC_CREATE;
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 480cb3a1d639..0c269464eea1 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -86,7 +86,7 @@ struct inode *ceph_new_inode(struct inode *dir, struct dentry *dentry,
 			goto out_err;
 	}
 
-	inode->i_state = 0;
+	inode_state_set(inode, 0);
 	inode->i_mode = *mode;
 
 	err = ceph_security_init_secctx(dentry, *mode, as_ctx);
@@ -155,7 +155,7 @@ struct inode *ceph_get_inode(struct super_block *sb, struct ceph_vino vino,
 
 	doutc(cl, "on %llx=%llx.%llx got %p new %d\n",
 	      ceph_present_inode(inode), ceph_vinop(inode), inode,
-	      !!(inode->i_state & I_NEW));
+	      !!(inode_state_read(inode) & I_NEW));
 	return inode;
 }
 
@@ -182,7 +182,7 @@ struct inode *ceph_get_snapdir(struct inode *parent)
 		goto err;
 	}
 
-	if (!(inode->i_state & I_NEW) && !S_ISDIR(inode->i_mode)) {
+	if (!(inode_state_read(inode) & I_NEW) && !S_ISDIR(inode->i_mode)) {
 		pr_warn_once_client(cl, "bad snapdir inode type (mode=0%o)\n",
 				    inode->i_mode);
 		goto err;
@@ -215,7 +215,7 @@ struct inode *ceph_get_snapdir(struct inode *parent)
 		}
 	}
 #endif
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read(inode) & I_NEW) {
 		inode->i_op = &ceph_snapdir_iops;
 		inode->i_fop = &ceph_snapdir_fops;
 		ci->i_snap_caps = CEPH_CAP_PIN; /* so we can open */
@@ -224,7 +224,7 @@ struct inode *ceph_get_snapdir(struct inode *parent)
 
 	return inode;
 err:
-	if ((inode->i_state & I_NEW))
+	if ((inode_state_read(inode) & I_NEW))
 		discard_new_inode(inode);
 	else
 		iput(inode);
@@ -698,7 +698,7 @@ void ceph_evict_inode(struct inode *inode)
 
 	netfs_wait_for_outstanding_io(inode);
 	truncate_inode_pages_final(&inode->i_data);
-	if (inode->i_state & I_PINNING_NETFS_WB)
+	if (inode_state_read(inode) & I_PINNING_NETFS_WB)
 		ceph_fscache_unuse_cookie(inode, true);
 	clear_inode(inode);
 
@@ -967,7 +967,7 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 	      le64_to_cpu(info->version), ci->i_version);
 
 	/* Once I_NEW is cleared, we can't change type or dev numbers */
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read(inode) & I_NEW) {
 		inode->i_mode = mode;
 	} else {
 		if (inode_wrong_type(inode, mode)) {
@@ -1044,7 +1044,7 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 
 #ifdef CONFIG_FS_ENCRYPTION
 	if (iinfo->fscrypt_auth_len &&
-	    ((inode->i_state & I_NEW) || (ci->fscrypt_auth_len == 0))) {
+	    ((inode_state_read(inode) & I_NEW) || (ci->fscrypt_auth_len == 0))) {
 		kfree(ci->fscrypt_auth);
 		ci->fscrypt_auth_len = iinfo->fscrypt_auth_len;
 		ci->fscrypt_auth = iinfo->fscrypt_auth;
@@ -1638,13 +1638,13 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 			pr_err_client(cl, "badness %p %llx.%llx\n", in,
 				      ceph_vinop(in));
 			req->r_target_inode = NULL;
-			if (in->i_state & I_NEW)
+			if (inode_state_read(in) & I_NEW)
 				discard_new_inode(in);
 			else
 				iput(in);
 			goto done;
 		}
-		if (in->i_state & I_NEW)
+		if (inode_state_read(in) & I_NEW)
 			unlock_new_inode(in);
 	}
 
@@ -1830,11 +1830,11 @@ static int readdir_prepopulate_inodes_only(struct ceph_mds_request *req,
 			pr_err_client(cl, "inode badness on %p got %d\n", in,
 				      rc);
 			err = rc;
-			if (in->i_state & I_NEW) {
+			if (inode_state_read(in) & I_NEW) {
 				ihold(in);
 				discard_new_inode(in);
 			}
-		} else if (in->i_state & I_NEW) {
+		} else if (inode_state_read(in) & I_NEW) {
 			unlock_new_inode(in);
 		}
 
@@ -2046,7 +2046,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 			pr_err_client(cl, "badness on %p %llx.%llx\n", in,
 				      ceph_vinop(in));
 			if (d_really_is_negative(dn)) {
-				if (in->i_state & I_NEW) {
+				if (inode_state_read(in) & I_NEW) {
 					ihold(in);
 					discard_new_inode(in);
 				}
@@ -2056,7 +2056,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 			err = ret;
 			goto next_item;
 		}
-		if (in->i_state & I_NEW)
+		if (inode_state_read(in) & I_NEW)
 			unlock_new_inode(in);
 
 		if (d_really_is_negative(dn)) {
diff --git a/fs/coda/cnode.c b/fs/coda/cnode.c
index 62a3d2565c26..b44c0a47ead0 100644
--- a/fs/coda/cnode.c
+++ b/fs/coda/cnode.c
@@ -70,7 +70,7 @@ struct inode * coda_iget(struct super_block * sb, struct CodaFid * fid,
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read(inode) & I_NEW) {
 		cii = ITOC(inode);
 		/* we still need to set i_ino for things like stat(2) */
 		inode->i_ino = hash;
@@ -148,7 +148,7 @@ struct inode *coda_fid_to_inode(struct CodaFid *fid, struct super_block *sb)
 
 	/* we should never see newly created inodes because we intentionally
 	 * fail in the initialization callback */
-	BUG_ON(inode->i_state & I_NEW);
+	BUG_ON(inode_state_read(inode) & I_NEW);
 
 	return inode;
 }
diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index b002e9b734f9..68147192260d 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -95,7 +95,7 @@ static struct inode *get_cramfs_inode(struct super_block *sb,
 	inode = iget_locked(sb, cramino(cramfs_inode, offset));
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read(inode) & I_NEW))
 		return inode;
 
 	switch (cramfs_inode->mode & S_IFMT) {
diff --git a/fs/crypto/keyring.c b/fs/crypto/keyring.c
index 7557f6a88b8f..34beb60bc24e 100644
--- a/fs/crypto/keyring.c
+++ b/fs/crypto/keyring.c
@@ -957,7 +957,7 @@ static void evict_dentries_for_decrypted_inodes(struct fscrypt_master_key *mk)
 	list_for_each_entry(ci, &mk->mk_decrypted_inodes, ci_master_key_link) {
 		inode = ci->ci_inode;
 		spin_lock(&inode->i_lock);
-		if (inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW)) {
+		if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index c1f85715c276..b801c47f5699 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -859,7 +859,7 @@ int fscrypt_drop_inode(struct inode *inode)
 	 * userspace is still using the files, inodes can be dirtied between
 	 * then and now.  We mustn't lose any writes, so skip dirty inodes here.
 	 */
-	if (inode->i_state & I_DIRTY_ALL)
+	if (inode_state_read(inode) & I_DIRTY_ALL)
 		return 0;
 
 	/*
diff --git a/fs/dcache.c b/fs/dcache.c
index 60046ae23d51..0dd2ee8a3b47 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -794,7 +794,7 @@ void d_mark_dontcache(struct inode *inode)
 		de->d_flags |= DCACHE_DONTCACHE;
 		spin_unlock(&de->d_lock);
 	}
-	inode->i_state |= I_DONTCACHE;
+	inode_state_add(inode, I_DONTCACHE);
 	spin_unlock(&inode->i_lock);
 }
 EXPORT_SYMBOL(d_mark_dontcache);
@@ -1073,7 +1073,7 @@ struct dentry *d_find_alias_rcu(struct inode *inode)
 	spin_lock(&inode->i_lock);
 	// ->i_dentry and ->i_rcu are colocated, but the latter won't be
 	// used without having I_FREEING set, which means no aliases left
-	if (likely(!(inode->i_state & I_FREEING) && !hlist_empty(l))) {
+	if (likely(!(inode_state_read(inode) & I_FREEING) && !hlist_empty(l))) {
 		if (S_ISDIR(inode->i_mode)) {
 			de = hlist_entry(l->first, struct dentry, d_u.d_alias);
 		} else {
@@ -1980,7 +1980,7 @@ void d_instantiate_new(struct dentry *entry, struct inode *inode)
 	security_d_instantiate(entry, inode);
 	spin_lock(&inode->i_lock);
 	__d_instantiate(entry, inode);
-	WARN_ON(!(inode->i_state & I_NEW));
+	WARN_ON(!(inode_state_read(inode) & I_NEW));
 	inode->i_state &= ~I_NEW & ~I_CREATING;
 	/*
 	 * Pairs with the barrier in prepare_to_wait_event() to make sure
diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index 019a8b4eaaf9..49f56a598ecb 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -28,7 +28,7 @@ static void drop_pagecache_sb(struct super_block *sb, void *unused)
 		 * inodes without pages but we deliberately won't in case
 		 * we need to reschedule to avoid softlockups.
 		 */
-		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) ||
+		if ((inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) ||
 		    (mapping_empty(inode->i_mapping) && !need_resched())) {
 			spin_unlock(&inode->i_lock);
 			continue;
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 72fbe1316ab8..b0d3d58f38cd 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -95,7 +95,7 @@ static struct inode *__ecryptfs_get_inode(struct inode *lower_inode,
 		iput(lower_inode);
 		return ERR_PTR(-EACCES);
 	}
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read(inode) & I_NEW))
 		iput(lower_inode);
 
 	return inode;
@@ -106,7 +106,7 @@ struct inode *ecryptfs_get_inode(struct inode *lower_inode,
 {
 	struct inode *inode = __ecryptfs_get_inode(lower_inode, sb);
 
-	if (!IS_ERR(inode) && (inode->i_state & I_NEW))
+	if (!IS_ERR(inode) && (inode_state_read(inode) & I_NEW))
 		unlock_new_inode(inode);
 
 	return inode;
@@ -373,7 +373,7 @@ static struct dentry *ecryptfs_lookup_interpose(struct dentry *dentry,
 		}
 	}
 
-	if (inode->i_state & I_NEW)
+	if (inode_state_read(inode) & I_NEW)
 		unlock_new_inode(inode);
 	return d_splice_alias(inode, dentry);
 }
diff --git a/fs/efs/inode.c b/fs/efs/inode.c
index 462619e59766..10f10c154763 100644
--- a/fs/efs/inode.c
+++ b/fs/efs/inode.c
@@ -62,7 +62,7 @@ struct inode *efs_iget(struct super_block *super, unsigned long ino)
 	inode = iget_locked(super, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read(inode) & I_NEW))
 		return inode;
 
 	in = INODE_INFO(inode);
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 9a2f59721522..b9fda78ca8c2 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -297,7 +297,7 @@ struct inode *erofs_iget(struct super_block *sb, erofs_nid_t nid)
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read(inode) & I_NEW) {
 		int err = erofs_fill_inode(inode);
 
 		if (err) {
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index e10c376843d7..6c1fd5bf0cac 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1398,7 +1398,7 @@ struct inode *ext2_iget (struct super_block *sb, unsigned long ino)
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read(inode) & I_NEW))
 		return inode;
 
 	ei = EXT2_I(inode);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index ed54c4d0f2f9..f47ce12239c5 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -425,7 +425,7 @@ void ext4_check_map_extents_env(struct inode *inode)
 	if (!S_ISREG(inode->i_mode) ||
 	    IS_NOQUOTA(inode) || IS_VERITY(inode) ||
 	    is_special_ino(inode->i_sb, inode->i_ino) ||
-	    (inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW)) ||
+	    (inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) ||
 	    ext4_test_inode_flag(inode, EXT4_INODE_EA_INODE) ||
 	    ext4_verity_in_progress(inode))
 		return;
@@ -3473,7 +3473,7 @@ static bool ext4_inode_datasync_dirty(struct inode *inode)
 	/* Any metadata buffers to write? */
 	if (!list_empty(&inode->i_mapping->i_private_list))
 		return true;
-	return inode->i_state & I_DIRTY_DATASYNC;
+	return inode_state_read(inode) & I_DIRTY_DATASYNC;
 }
 
 static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
@@ -4581,7 +4581,7 @@ int ext4_truncate(struct inode *inode)
 	 * or it's a completely new inode. In those cases we might not
 	 * have i_rwsem locked because it's not necessary.
 	 */
-	if (!(inode->i_state & (I_NEW|I_FREEING)))
+	if (!(inode_state_read(inode) & (I_NEW | I_FREEING)))
 		WARN_ON(!inode_is_locked(inode));
 	trace_ext4_truncate_enter(inode);
 
@@ -5239,7 +5239,7 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW)) {
+	if (!(inode_state_read(inode) & I_NEW)) {
 		ret = check_igot_inode(inode, flags, function, line);
 		if (ret) {
 			iput(inode);
@@ -5570,7 +5570,7 @@ static void __ext4_update_other_inode_time(struct super_block *sb,
 	if (inode_is_dirtytime_only(inode)) {
 		struct ext4_inode_info	*ei = EXT4_I(inode);
 
-		inode->i_state &= ~I_DIRTY_TIME;
+		inode_state_del(inode, I_DIRTY_TIME);
 		spin_unlock(&inode->i_lock);
 
 		spin_lock(&ei->i_raw_lock);
diff --git a/fs/ext4/orphan.c b/fs/ext4/orphan.c
index 7c7f792ad6ab..1353a40c7bbc 100644
--- a/fs/ext4/orphan.c
+++ b/fs/ext4/orphan.c
@@ -107,7 +107,7 @@ int ext4_orphan_add(handle_t *handle, struct inode *inode)
 	if (!sbi->s_journal || is_bad_inode(inode))
 		return 0;
 
-	WARN_ON_ONCE(!(inode->i_state & (I_NEW | I_FREEING)) &&
+	WARN_ON_ONCE(!(inode_state_read(inode) & (I_NEW | I_FREEING)) &&
 		     !inode_is_locked(inode));
 	/*
 	 * Inode orphaned in orphan file or in orphan list?
@@ -236,7 +236,7 @@ int ext4_orphan_del(handle_t *handle, struct inode *inode)
 	if (!sbi->s_journal && !(sbi->s_mount_state & EXT4_ORPHAN_FS))
 		return 0;
 
-	WARN_ON_ONCE(!(inode->i_state & (I_NEW | I_FREEING)) &&
+	WARN_ON_ONCE(!(inode_state_read(inode) & (I_NEW | I_FREEING)) &&
 		     !inode_is_locked(inode));
 	if (ext4_test_inode_state(inode, EXT4_STATE_ORPHAN_FILE))
 		return ext4_orphan_file_del(handle, inode);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7961e0ddfca3..28a9aee88c29 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4241,7 +4241,7 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 
 	if (map.m_flags & F2FS_MAP_NEW)
 		iomap->flags |= IOMAP_F_NEW;
-	if ((inode->i_state & I_DIRTY_DATASYNC) ||
+	if ((inode_state_read(inode) & I_DIRTY_DATASYNC) ||
 	    offset + length > i_size_read(inode))
 		iomap->flags |= IOMAP_F_DIRTY;
 
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 8c4eafe9ffac..30ecd0273b1b 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -569,7 +569,7 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	if (!(inode->i_state & I_NEW)) {
+	if (!(inode_state_read(inode) & I_NEW)) {
 		if (is_meta_ino(sbi, ino)) {
 			f2fs_err(sbi, "inaccessible inode: %lu, run fsck to repair", ino);
 			set_sbi_flag(sbi, SBI_NEED_FSCK);
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index b882771e4699..7d977b80bae5 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -844,7 +844,7 @@ static int __f2fs_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 		f2fs_i_links_write(inode, false);
 
 		spin_lock(&inode->i_lock);
-		inode->i_state |= I_LINKABLE;
+		inode_state_add(inode, I_LINKABLE);
 		spin_unlock(&inode->i_lock);
 	} else {
 		if (file)
@@ -1057,7 +1057,7 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			goto put_out_dir;
 
 		spin_lock(&whiteout->i_lock);
-		whiteout->i_state &= ~I_LINKABLE;
+		inode_state_del(whiteout, I_LINKABLE);
 		spin_unlock(&whiteout->i_lock);
 
 		iput(whiteout);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 2045642cfe3b..d8db9a4084fa 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1747,7 +1747,7 @@ static int f2fs_drop_inode(struct inode *inode)
 	 *    - f2fs_gc -> iput -> evict
 	 *       - inode_wait_for_writeback(inode)
 	 */
-	if ((!inode_unhashed(inode) && inode->i_state & I_SYNC)) {
+	if ((!inode_unhashed(inode) && inode_state_read(inode) & I_SYNC)) {
 		if (!inode->i_nlink && !is_bad_inode(inode)) {
 			/* to avoid evict_inode call simultaneously */
 			__iget(inode);
diff --git a/fs/freevxfs/vxfs_inode.c b/fs/freevxfs/vxfs_inode.c
index 20600e9ea202..45bcfa35059a 100644
--- a/fs/freevxfs/vxfs_inode.c
+++ b/fs/freevxfs/vxfs_inode.c
@@ -258,7 +258,7 @@ vxfs_iget(struct super_block *sbp, ino_t ino)
 	ip = iget_locked(sbp, ino);
 	if (!ip)
 		return ERR_PTR(-ENOMEM);
-	if (!(ip->i_state & I_NEW))
+	if (!(inode_state_read(ip) & I_NEW))
 		return ip;
 
 	vip = VXFS_INO(ip);
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 6088a67b2aae..0e9e96f10dd4 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -121,7 +121,7 @@ static bool inode_io_list_move_locked(struct inode *inode,
 {
 	assert_spin_locked(&wb->list_lock);
 	assert_spin_locked(&inode->i_lock);
-	WARN_ON_ONCE(inode->i_state & I_FREEING);
+	WARN_ON_ONCE(inode_state_read(inode) & I_FREEING);
 
 	list_move(&inode->i_io_list, head);
 
@@ -304,9 +304,9 @@ static void inode_cgwb_move_to_attached(struct inode *inode,
 {
 	assert_spin_locked(&wb->list_lock);
 	assert_spin_locked(&inode->i_lock);
-	WARN_ON_ONCE(inode->i_state & I_FREEING);
+	WARN_ON_ONCE(inode_state_read(inode) & I_FREEING);
 
-	inode->i_state &= ~I_SYNC_QUEUED;
+	inode_state_del(inode, I_SYNC_QUEUED);
 	if (wb != &wb->bdi->wb)
 		list_move(&inode->i_io_list, &wb->b_attached);
 	else
@@ -408,7 +408,7 @@ static bool inode_do_switch_wbs(struct inode *inode,
 	 * Once I_FREEING or I_WILL_FREE are visible under i_lock, the eviction
 	 * path owns the inode and we shouldn't modify ->i_io_list.
 	 */
-	if (unlikely(inode->i_state & (I_FREEING | I_WILL_FREE)))
+	if (unlikely(inode_state_read(inode) & (I_FREEING | I_WILL_FREE)))
 		goto skip_switch;
 
 	trace_inode_switch_wbs(inode, old_wb, new_wb);
@@ -452,7 +452,7 @@ static bool inode_do_switch_wbs(struct inode *inode,
 	if (!list_empty(&inode->i_io_list)) {
 		inode->i_wb = new_wb;
 
-		if (inode->i_state & I_DIRTY_ALL) {
+		if (inode_state_read(inode) & I_DIRTY_ALL) {
 			struct inode *pos;
 
 			list_for_each_entry(pos, &new_wb->b_dirty, i_io_list)
@@ -478,7 +478,8 @@ static bool inode_do_switch_wbs(struct inode *inode,
 	 * Paired with load_acquire in unlocked_inode_to_wb_begin() and
 	 * ensures that the new wb is visible if they see !I_WB_SWITCH.
 	 */
-	smp_store_release(&inode->i_state, inode->i_state & ~I_WB_SWITCH);
+	smp_store_release(&inode->i_state,
+			  inode_state_read(inode) & ~I_WB_SWITCH);
 
 	xa_unlock_irq(&mapping->i_pages);
 	spin_unlock(&inode->i_lock);
@@ -560,12 +561,12 @@ static bool inode_prepare_wbs_switch(struct inode *inode,
 	/* while holding I_WB_SWITCH, no one else can update the association */
 	spin_lock(&inode->i_lock);
 	if (!(inode->i_sb->s_flags & SB_ACTIVE) ||
-	    inode->i_state & (I_WB_SWITCH | I_FREEING | I_WILL_FREE) ||
+	    inode_state_read(inode) & (I_WB_SWITCH | I_FREEING | I_WILL_FREE) ||
 	    inode_to_wb(inode) == new_wb) {
 		spin_unlock(&inode->i_lock);
 		return false;
 	}
-	inode->i_state |= I_WB_SWITCH;
+	inode_state_add(inode, I_WB_SWITCH);
 	__iget(inode);
 	spin_unlock(&inode->i_lock);
 
@@ -587,7 +588,7 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
 	struct inode_switch_wbs_context *isw;
 
 	/* noop if seems to be already in progress */
-	if (inode->i_state & I_WB_SWITCH)
+	if (inode_state_read(inode) & I_WB_SWITCH)
 		return;
 
 	/* avoid queueing a new switch if too many are already in flight */
@@ -1197,9 +1198,9 @@ static void inode_cgwb_move_to_attached(struct inode *inode,
 {
 	assert_spin_locked(&wb->list_lock);
 	assert_spin_locked(&inode->i_lock);
-	WARN_ON_ONCE(inode->i_state & I_FREEING);
+	WARN_ON_ONCE(inode_state_read(inode) & I_FREEING);
 
-	inode->i_state &= ~I_SYNC_QUEUED;
+	inode_state_del(inode, I_SYNC_QUEUED);
 	list_del_init(&inode->i_io_list);
 	wb_io_lists_depopulated(wb);
 }
@@ -1312,7 +1313,7 @@ void inode_io_list_del(struct inode *inode)
 	wb = inode_to_wb_and_lock_list(inode);
 	spin_lock(&inode->i_lock);
 
-	inode->i_state &= ~I_SYNC_QUEUED;
+	inode_state_del(inode, I_SYNC_QUEUED);
 	list_del_init(&inode->i_io_list);
 	wb_io_lists_depopulated(wb);
 
@@ -1370,13 +1371,13 @@ static void redirty_tail_locked(struct inode *inode, struct bdi_writeback *wb)
 {
 	assert_spin_locked(&inode->i_lock);
 
-	inode->i_state &= ~I_SYNC_QUEUED;
+	inode_state_del(inode, I_SYNC_QUEUED);
 	/*
 	 * When the inode is being freed just don't bother with dirty list
 	 * tracking. Flush worker will ignore this inode anyway and it will
 	 * trigger assertions in inode_io_list_move_locked().
 	 */
-	if (inode->i_state & I_FREEING) {
+	if (inode_state_read(inode) & I_FREEING) {
 		list_del_init(&inode->i_io_list);
 		wb_io_lists_depopulated(wb);
 		return;
@@ -1410,7 +1411,7 @@ static void inode_sync_complete(struct inode *inode)
 {
 	assert_spin_locked(&inode->i_lock);
 
-	inode->i_state &= ~I_SYNC;
+	inode_state_del(inode, I_SYNC);
 	/* If inode is clean an unused, put it into LRU now... */
 	inode_add_lru(inode);
 	/* Called with inode->i_lock which ensures memory ordering. */
@@ -1454,7 +1455,7 @@ static int move_expired_inodes(struct list_head *delaying_queue,
 		spin_lock(&inode->i_lock);
 		list_move(&inode->i_io_list, &tmp);
 		moved++;
-		inode->i_state |= I_SYNC_QUEUED;
+		inode_state_add(inode, I_SYNC_QUEUED);
 		spin_unlock(&inode->i_lock);
 		if (sb_is_blkdev_sb(inode->i_sb))
 			continue;
@@ -1540,14 +1541,14 @@ void inode_wait_for_writeback(struct inode *inode)
 
 	assert_spin_locked(&inode->i_lock);
 
-	if (!(inode->i_state & I_SYNC))
+	if (!(inode_state_read(inode) & I_SYNC))
 		return;
 
 	wq_head = inode_bit_waitqueue(&wqe, inode, __I_SYNC);
 	for (;;) {
 		prepare_to_wait_event(wq_head, &wqe.wq_entry, TASK_UNINTERRUPTIBLE);
 		/* Checking I_SYNC with inode->i_lock guarantees memory ordering. */
-		if (!(inode->i_state & I_SYNC))
+		if (!(inode_state_read(inode) & I_SYNC))
 			break;
 		spin_unlock(&inode->i_lock);
 		schedule();
@@ -1573,7 +1574,7 @@ static void inode_sleep_on_writeback(struct inode *inode)
 	wq_head = inode_bit_waitqueue(&wqe, inode, __I_SYNC);
 	prepare_to_wait_event(wq_head, &wqe.wq_entry, TASK_UNINTERRUPTIBLE);
 	/* Checking I_SYNC with inode->i_lock guarantees memory ordering. */
-	sleep = !!(inode->i_state & I_SYNC);
+	sleep = !!(inode_state_read(inode) & I_SYNC);
 	spin_unlock(&inode->i_lock);
 	if (sleep)
 		schedule();
@@ -1592,7 +1593,7 @@ static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
 			  struct writeback_control *wbc,
 			  unsigned long dirtied_before)
 {
-	if (inode->i_state & I_FREEING)
+	if (inode_state_read(inode) & I_FREEING)
 		return;
 
 	/*
@@ -1600,7 +1601,7 @@ static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
 	 * shot. If still dirty, it will be redirty_tail()'ed below.  Update
 	 * the dirty time to prevent enqueue and sync it again.
 	 */
-	if ((inode->i_state & I_DIRTY) &&
+	if ((inode_state_read(inode) & I_DIRTY) &&
 	    (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages))
 		inode->dirtied_when = jiffies;
 
@@ -1611,7 +1612,7 @@ static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
 		 * is odd for clean inodes, it can happen for some
 		 * filesystems so handle that gracefully.
 		 */
-		if (inode->i_state & I_DIRTY_ALL)
+		if (inode_state_read(inode) & I_DIRTY_ALL)
 			redirty_tail_locked(inode, wb);
 		else
 			inode_cgwb_move_to_attached(inode, wb);
@@ -1637,17 +1638,17 @@ static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
 			 */
 			redirty_tail_locked(inode, wb);
 		}
-	} else if (inode->i_state & I_DIRTY) {
+	} else if (inode_state_read(inode) & I_DIRTY) {
 		/*
 		 * Filesystems can dirty the inode during writeback operations,
 		 * such as delayed allocation during submission or metadata
 		 * updates after data IO completion.
 		 */
 		redirty_tail_locked(inode, wb);
-	} else if (inode->i_state & I_DIRTY_TIME) {
+	} else if (inode_state_read(inode) & I_DIRTY_TIME) {
 		inode->dirtied_when = jiffies;
 		inode_io_list_move_locked(inode, wb, &wb->b_dirty_time);
-		inode->i_state &= ~I_SYNC_QUEUED;
+		inode_state_del(inode, I_SYNC_QUEUED);
 	} else {
 		/* The inode is clean. Remove from writeback lists. */
 		inode_cgwb_move_to_attached(inode, wb);
@@ -1673,7 +1674,7 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
 	unsigned dirty;
 	int ret;
 
-	WARN_ON(!(inode->i_state & I_SYNC));
+	WARN_ON(!(inode_state_read(inode) & I_SYNC));
 
 	trace_writeback_single_inode_start(inode, wbc, nr_to_write);
 
@@ -1697,7 +1698,7 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
 	 * mark_inode_dirty_sync() to notify the filesystem about it and to
 	 * change I_DIRTY_TIME into I_DIRTY_SYNC.
 	 */
-	if ((inode->i_state & I_DIRTY_TIME) &&
+	if ((inode_state_read(inode) & I_DIRTY_TIME) &&
 	    (wbc->sync_mode == WB_SYNC_ALL ||
 	     time_after(jiffies, inode->dirtied_time_when +
 			dirtytime_expire_interval * HZ))) {
@@ -1712,8 +1713,8 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
 	 * after handling timestamp expiration, as that may dirty the inode too.
 	 */
 	spin_lock(&inode->i_lock);
-	dirty = inode->i_state & I_DIRTY;
-	inode->i_state &= ~dirty;
+	dirty = inode_state_read(inode) & I_DIRTY;
+	inode_state_del(inode, dirty);
 
 	/*
 	 * Paired with smp_mb() in __mark_inode_dirty().  This allows
@@ -1729,10 +1730,10 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
 	smp_mb();
 
 	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
-		inode->i_state |= I_DIRTY_PAGES;
-	else if (unlikely(inode->i_state & I_PINNING_NETFS_WB)) {
-		if (!(inode->i_state & I_DIRTY_PAGES)) {
-			inode->i_state &= ~I_PINNING_NETFS_WB;
+		inode_state_add(inode, I_DIRTY_PAGES);
+	else if (unlikely(inode_state_read(inode) & I_PINNING_NETFS_WB)) {
+		if (!(inode_state_read(inode) & I_DIRTY_PAGES)) {
+			inode_state_del(inode, I_PINNING_NETFS_WB);
 			wbc->unpinned_netfs_wb = true;
 			dirty |= I_PINNING_NETFS_WB; /* Cause write_inode */
 		}
@@ -1768,11 +1769,11 @@ static int writeback_single_inode(struct inode *inode,
 
 	spin_lock(&inode->i_lock);
 	if (!icount_read(inode))
-		WARN_ON(!(inode->i_state & (I_WILL_FREE|I_FREEING)));
+		WARN_ON(!(inode_state_read(inode) & (I_WILL_FREE | I_FREEING)));
 	else
-		WARN_ON(inode->i_state & I_WILL_FREE);
+		WARN_ON(inode_state_read(inode) & I_WILL_FREE);
 
-	if (inode->i_state & I_SYNC) {
+	if (inode_state_read(inode) & I_SYNC) {
 		/*
 		 * Writeback is already running on the inode.  For WB_SYNC_NONE,
 		 * that's enough and we can just return.  For WB_SYNC_ALL, we
@@ -1783,7 +1784,7 @@ static int writeback_single_inode(struct inode *inode,
 			goto out;
 		inode_wait_for_writeback(inode);
 	}
-	WARN_ON(inode->i_state & I_SYNC);
+	WARN_ON(inode_state_read(inode) & I_SYNC);
 	/*
 	 * If the inode is already fully clean, then there's nothing to do.
 	 *
@@ -1791,11 +1792,11 @@ static int writeback_single_inode(struct inode *inode,
 	 * still under writeback, e.g. due to prior WB_SYNC_NONE writeback.  If
 	 * there are any such pages, we'll need to wait for them.
 	 */
-	if (!(inode->i_state & I_DIRTY_ALL) &&
+	if (!(inode_state_read(inode) & I_DIRTY_ALL) &&
 	    (wbc->sync_mode != WB_SYNC_ALL ||
 	     !mapping_tagged(inode->i_mapping, PAGECACHE_TAG_WRITEBACK)))
 		goto out;
-	inode->i_state |= I_SYNC;
+	inode_state_add(inode, I_SYNC);
 	wbc_attach_and_unlock_inode(wbc, inode);
 
 	ret = __writeback_single_inode(inode, wbc);
@@ -1808,18 +1809,18 @@ static int writeback_single_inode(struct inode *inode,
 	 * If the inode is freeing, its i_io_list shoudn't be updated
 	 * as it can be finally deleted at this moment.
 	 */
-	if (!(inode->i_state & I_FREEING)) {
+	if (!(inode_state_read(inode) & I_FREEING)) {
 		/*
 		 * If the inode is now fully clean, then it can be safely
 		 * removed from its writeback list (if any). Otherwise the
 		 * flusher threads are responsible for the writeback lists.
 		 */
-		if (!(inode->i_state & I_DIRTY_ALL))
+		if (!(inode_state_read(inode) & I_DIRTY_ALL))
 			inode_cgwb_move_to_attached(inode, wb);
-		else if (!(inode->i_state & I_SYNC_QUEUED)) {
-			if ((inode->i_state & I_DIRTY))
+		else if (!(inode_state_read(inode) & I_SYNC_QUEUED)) {
+			if ((inode_state_read(inode) & I_DIRTY))
 				redirty_tail_locked(inode, wb);
-			else if (inode->i_state & I_DIRTY_TIME) {
+			else if (inode_state_read(inode) & I_DIRTY_TIME) {
 				inode->dirtied_when = jiffies;
 				inode_io_list_move_locked(inode,
 							  wb,
@@ -1928,12 +1929,12 @@ static long writeback_sb_inodes(struct super_block *sb,
 		 * kind writeout is handled by the freer.
 		 */
 		spin_lock(&inode->i_lock);
-		if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE)) {
+		if (inode_state_read(inode) & (I_NEW | I_FREEING | I_WILL_FREE)) {
 			redirty_tail_locked(inode, wb);
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-		if ((inode->i_state & I_SYNC) && wbc.sync_mode != WB_SYNC_ALL) {
+		if ((inode_state_read(inode) & I_SYNC) && wbc.sync_mode != WB_SYNC_ALL) {
 			/*
 			 * If this inode is locked for writeback and we are not
 			 * doing writeback-for-data-integrity, move it to
@@ -1955,14 +1956,14 @@ static long writeback_sb_inodes(struct super_block *sb,
 		 * are doing WB_SYNC_NONE writeback. So this catches only the
 		 * WB_SYNC_ALL case.
 		 */
-		if (inode->i_state & I_SYNC) {
+		if (inode_state_read(inode) & I_SYNC) {
 			/* Wait for I_SYNC. This function drops i_lock... */
 			inode_sleep_on_writeback(inode);
 			/* Inode may be gone, start again */
 			spin_lock(&wb->list_lock);
 			continue;
 		}
-		inode->i_state |= I_SYNC;
+		inode_state_add(inode, I_SYNC);
 		wbc_attach_and_unlock_inode(&wbc, inode);
 
 		write_chunk = writeback_chunk_size(wb, work);
@@ -2000,7 +2001,7 @@ static long writeback_sb_inodes(struct super_block *sb,
 		 */
 		tmp_wb = inode_to_wb_and_lock_list(inode);
 		spin_lock(&inode->i_lock);
-		if (!(inode->i_state & I_DIRTY_ALL))
+		if (!(inode_state_read(inode) & I_DIRTY_ALL))
 			total_wrote++;
 		requeue_inode(inode, tmp_wb, &wbc, dirtied_before);
 		inode_sync_complete(inode);
@@ -2506,10 +2507,10 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 		 * We tell ->dirty_inode callback that timestamps need to
 		 * be updated by setting I_DIRTY_TIME in flags.
 		 */
-		if (inode->i_state & I_DIRTY_TIME) {
+		if (inode_state_read(inode) & I_DIRTY_TIME) {
 			spin_lock(&inode->i_lock);
-			if (inode->i_state & I_DIRTY_TIME) {
-				inode->i_state &= ~I_DIRTY_TIME;
+			if (inode_state_read(inode) & I_DIRTY_TIME) {
+				inode_state_del(inode, I_DIRTY_TIME);
 				flags |= I_DIRTY_TIME;
 			}
 			spin_unlock(&inode->i_lock);
@@ -2546,16 +2547,16 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 	 */
 	smp_mb();
 
-	if ((inode->i_state & flags) == flags)
+	if ((inode_state_read(inode) & flags) == flags)
 		return;
 
 	spin_lock(&inode->i_lock);
-	if ((inode->i_state & flags) != flags) {
-		const int was_dirty = inode->i_state & I_DIRTY;
+	if ((inode_state_read(inode) & flags) != flags) {
+		const int was_dirty = inode_state_read(inode) & I_DIRTY;
 
 		inode_attach_wb(inode, NULL);
 
-		inode->i_state |= flags;
+		inode_state_add(inode, flags);
 
 		/*
 		 * Grab inode's wb early because it requires dropping i_lock and we
@@ -2574,7 +2575,7 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 		 * the inode it will place it on the appropriate superblock
 		 * list, based upon its state.
 		 */
-		if (inode->i_state & I_SYNC_QUEUED)
+		if (inode_state_read(inode) & I_SYNC_QUEUED)
 			goto out_unlock;
 
 		/*
@@ -2585,7 +2586,7 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 			if (inode_unhashed(inode))
 				goto out_unlock;
 		}
-		if (inode->i_state & I_FREEING)
+		if (inode_state_read(inode) & I_FREEING)
 			goto out_unlock;
 
 		/*
@@ -2600,7 +2601,7 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 			if (dirtytime)
 				inode->dirtied_time_when = jiffies;
 
-			if (inode->i_state & I_DIRTY)
+			if (inode_state_read(inode) & I_DIRTY)
 				dirty_list = &wb->b_dirty;
 			else
 				dirty_list = &wb->b_dirty_time;
@@ -2696,7 +2697,7 @@ static void wait_sb_inodes(struct super_block *sb)
 		spin_unlock_irq(&sb->s_inode_wblist_lock);
 
 		spin_lock(&inode->i_lock);
-		if (inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) {
+		if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) {
 			spin_unlock(&inode->i_lock);
 
 			spin_lock_irq(&sb->s_inode_wblist_lock);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index ecb869e895ab..d4f85ea7b049 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -161,7 +161,7 @@ static void fuse_evict_inode(struct inode *inode)
 	struct fuse_inode *fi = get_fuse_inode(inode);
 
 	/* Will write inode on close/munmap and in all other dirtiers */
-	WARN_ON(inode->i_state & I_DIRTY_INODE);
+	WARN_ON(inode_state_read(inode) & I_DIRTY_INODE);
 
 	if (FUSE_IS_DAX(inode))
 		dax_break_layout_final(inode);
@@ -506,7 +506,7 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 	if (!inode)
 		return NULL;
 
-	if ((inode->i_state & I_NEW)) {
+	if ((inode_state_read(inode) & I_NEW)) {
 		inode->i_flags |= S_NOATIME;
 		if (!fc->writeback_cache || !S_ISREG(attr->mode))
 			inode->i_flags |= S_NOCMTIME;
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 72d95185a39f..99696d9767fa 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -744,7 +744,7 @@ static int gfs2_fsync(struct file *file, loff_t start, loff_t end,
 {
 	struct address_space *mapping = file->f_mapping;
 	struct inode *inode = mapping->host;
-	int sync_state = inode->i_state & I_DIRTY;
+	int sync_state = inode_state_read(inode) & I_DIRTY;
 	struct gfs2_inode *ip = GFS2_I(inode);
 	int ret = 0, ret1 = 0;
 
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index fe0faad4892f..25911d94c0a2 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -394,7 +394,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 	u16 height, depth;
 	umode_t mode = be32_to_cpu(str->di_mode);
 	struct inode *inode = &ip->i_inode;
-	bool is_new = inode->i_state & I_NEW;
+	bool is_new = inode_state_read(inode) & I_NEW;
 
 	if (unlikely(ip->i_no_addr != be64_to_cpu(str->di_num.no_addr))) {
 		gfs2_consist_inode(ip);
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 8760e7e20c9d..0ffdddd08d59 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -127,7 +127,7 @@ struct inode *gfs2_inode_lookup(struct super_block *sb, unsigned int type,
 
 	ip = GFS2_I(inode);
 
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read(inode) & I_NEW) {
 		struct gfs2_sbd *sdp = GFS2_SB(inode);
 		struct gfs2_glock *io_gl;
 		int extra_flags = 0;
@@ -924,7 +924,7 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 	gfs2_dir_no_add(&da);
 	gfs2_glock_dq_uninit(&d_gh);
 	if (!IS_ERR_OR_NULL(inode)) {
-		if (inode->i_state & I_NEW)
+		if (inode_state_read(inode) & I_NEW)
 			iget_failed(inode);
 		else
 			iput(inode);
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index c770006f8889..2572ff9753b8 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1749,7 +1749,7 @@ static void gfs2_evict_inodes(struct super_block *sb)
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		spin_lock(&inode->i_lock);
-		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) &&
+		if ((inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) &&
 		    !need_resched()) {
 			spin_unlock(&inode->i_lock);
 			continue;
diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
index e86e1e235658..636723a50981 100644
--- a/fs/hfs/btree.c
+++ b/fs/hfs/btree.c
@@ -42,7 +42,7 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id, btree_keycmp ke
 	tree->inode = iget_locked(sb, id);
 	if (!tree->inode)
 		goto free_tree;
-	BUG_ON(!(tree->inode->i_state & I_NEW));
+	BUG_ON(!(inode_state_read(tree->inode) & I_NEW));
 	{
 	struct hfs_mdb *mdb = HFS_SB(sb)->mdb;
 	HFS_I(tree->inode)->flags = 0;
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index bf4cb7e78396..df61ba2782e7 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -401,7 +401,7 @@ struct inode *hfs_iget(struct super_block *sb, struct hfs_cat_key *key, hfs_cat_
 		return NULL;
 	}
 	inode = iget5_locked(sb, cnid, hfs_test_inode, hfs_read_inode, &data);
-	if (inode && (inode->i_state & I_NEW))
+	if (inode && (inode_state_read(inode) & I_NEW))
 		unlock_new_inode(inode);
 	return inode;
 }
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 86351bdc8985..812b9f60cd17 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -65,7 +65,7 @@ struct inode *hfsplus_iget(struct super_block *sb, unsigned long ino)
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read(inode) & I_NEW))
 		return inode;
 
 	INIT_LIST_HEAD(&HFSPLUS_I(inode)->open_dir_list);
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 01e516175bcd..7bdf71c60150 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -581,7 +581,7 @@ static struct inode *hostfs_iget(struct super_block *sb, char *name)
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read(inode) & I_NEW) {
 		unlock_new_inode(inode);
 	} else {
 		spin_lock(&inode->i_lock);
diff --git a/fs/hpfs/dir.c b/fs/hpfs/dir.c
index 49dd585c2b17..ee31b3bb0895 100644
--- a/fs/hpfs/dir.c
+++ b/fs/hpfs/dir.c
@@ -247,7 +247,7 @@ struct dentry *hpfs_lookup(struct inode *dir, struct dentry *dentry, unsigned in
 		result = ERR_PTR(-ENOMEM);
 		goto bail1;
 	}
-	if (result->i_state & I_NEW) {
+	if (inode_state_read(result) & I_NEW) {
 		hpfs_init_inode(result);
 		if (de->directory)
 			hpfs_read_inode(result);
diff --git a/fs/hpfs/inode.c b/fs/hpfs/inode.c
index 34008442ee26..9968b0d541f1 100644
--- a/fs/hpfs/inode.c
+++ b/fs/hpfs/inode.c
@@ -196,7 +196,7 @@ void hpfs_write_inode(struct inode *i)
 	parent = iget_locked(i->i_sb, hpfs_inode->i_parent_dir);
 	if (parent) {
 		hpfs_inode->i_dirty = 0;
-		if (parent->i_state & I_NEW) {
+		if (inode_state_read(parent) & I_NEW) {
 			hpfs_init_inode(parent);
 			hpfs_read_inode(parent);
 			unlock_new_inode(parent);
diff --git a/fs/inode.c b/fs/inode.c
index bf7503760206..2ed2367ecbae 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -233,7 +233,7 @@ int inode_init_always_gfp(struct super_block *sb, struct inode *inode, gfp_t gfp
 	inode->i_sb = sb;
 	inode->i_blkbits = sb->s_blocksize_bits;
 	inode->i_flags = 0;
-	inode->i_state = 0;
+	inode_state_set(inode, 0);
 	atomic64_set(&inode->i_sequence, 0);
 	atomic_set(&inode->i_count, 1);
 	inode->i_op = &empty_iops;
@@ -471,7 +471,7 @@ EXPORT_SYMBOL(set_nlink);
 void inc_nlink(struct inode *inode)
 {
 	if (unlikely(inode->i_nlink == 0)) {
-		WARN_ON(!(inode->i_state & I_LINKABLE));
+		WARN_ON(!(inode_state_read(inode) & I_LINKABLE));
 		atomic_long_dec(&inode->i_sb->s_remove_count);
 	}
 
@@ -532,7 +532,7 @@ EXPORT_SYMBOL(ihold);
 
 static void __inode_add_lru(struct inode *inode, bool rotate)
 {
-	if (inode->i_state & (I_DIRTY_ALL | I_SYNC | I_FREEING | I_WILL_FREE))
+	if (inode_state_read(inode) & (I_DIRTY_ALL | I_SYNC | I_FREEING | I_WILL_FREE))
 		return;
 	if (icount_read(inode))
 		return;
@@ -544,7 +544,7 @@ static void __inode_add_lru(struct inode *inode, bool rotate)
 	if (list_lru_add_obj(&inode->i_sb->s_inode_lru, &inode->i_lru))
 		this_cpu_inc(nr_unused);
 	else if (rotate)
-		inode->i_state |= I_REFERENCED;
+		inode_state_add(inode, I_REFERENCED);
 }
 
 struct wait_queue_head *inode_bit_waitqueue(struct wait_bit_queue_entry *wqe,
@@ -577,15 +577,15 @@ static void inode_lru_list_del(struct inode *inode)
 static void inode_pin_lru_isolating(struct inode *inode)
 {
 	lockdep_assert_held(&inode->i_lock);
-	WARN_ON(inode->i_state & (I_LRU_ISOLATING | I_FREEING | I_WILL_FREE));
-	inode->i_state |= I_LRU_ISOLATING;
+	WARN_ON(inode_state_read(inode) & (I_LRU_ISOLATING | I_FREEING | I_WILL_FREE));
+	inode_state_add(inode, I_LRU_ISOLATING);
 }
 
 static void inode_unpin_lru_isolating(struct inode *inode)
 {
 	spin_lock(&inode->i_lock);
-	WARN_ON(!(inode->i_state & I_LRU_ISOLATING));
-	inode->i_state &= ~I_LRU_ISOLATING;
+	WARN_ON(!(inode_state_read(inode) & I_LRU_ISOLATING));
+	inode_state_del(inode, I_LRU_ISOLATING);
 	/* Called with inode->i_lock which ensures memory ordering. */
 	inode_wake_up_bit(inode, __I_LRU_ISOLATING);
 	spin_unlock(&inode->i_lock);
@@ -597,7 +597,7 @@ static void inode_wait_for_lru_isolating(struct inode *inode)
 	struct wait_queue_head *wq_head;
 
 	lockdep_assert_held(&inode->i_lock);
-	if (!(inode->i_state & I_LRU_ISOLATING))
+	if (!(inode_state_read(inode) & I_LRU_ISOLATING))
 		return;
 
 	wq_head = inode_bit_waitqueue(&wqe, inode, __I_LRU_ISOLATING);
@@ -607,14 +607,14 @@ static void inode_wait_for_lru_isolating(struct inode *inode)
 		 * Checking I_LRU_ISOLATING with inode->i_lock guarantees
 		 * memory ordering.
 		 */
-		if (!(inode->i_state & I_LRU_ISOLATING))
+		if (!(inode_state_read(inode) & I_LRU_ISOLATING))
 			break;
 		spin_unlock(&inode->i_lock);
 		schedule();
 		spin_lock(&inode->i_lock);
 	}
 	finish_wait(wq_head, &wqe.wq_entry);
-	WARN_ON(inode->i_state & I_LRU_ISOLATING);
+	WARN_ON(inode_state_read(inode) & I_LRU_ISOLATING);
 }
 
 /**
@@ -761,11 +761,11 @@ void clear_inode(struct inode *inode)
 	 */
 	xa_unlock_irq(&inode->i_data.i_pages);
 	BUG_ON(!list_empty(&inode->i_data.i_private_list));
-	BUG_ON(!(inode->i_state & I_FREEING));
-	BUG_ON(inode->i_state & I_CLEAR);
+	BUG_ON(!(inode_state_read(inode) & I_FREEING));
+	BUG_ON(inode_state_read(inode) & I_CLEAR);
 	BUG_ON(!list_empty(&inode->i_wb_list));
 	/* don't need i_lock here, no concurrent mods to i_state */
-	inode->i_state = I_FREEING | I_CLEAR;
+	inode_state_set(inode, I_FREEING | I_CLEAR);
 }
 EXPORT_SYMBOL(clear_inode);
 
@@ -786,7 +786,7 @@ static void evict(struct inode *inode)
 {
 	const struct super_operations *op = inode->i_sb->s_op;
 
-	BUG_ON(!(inode->i_state & I_FREEING));
+	BUG_ON(!(inode_state_read(inode) & I_FREEING));
 	BUG_ON(!list_empty(&inode->i_lru));
 
 	if (!list_empty(&inode->i_io_list))
@@ -879,12 +879,12 @@ void evict_inodes(struct super_block *sb)
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-		if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE)) {
+		if (inode_state_read(inode) & (I_NEW | I_FREEING | I_WILL_FREE)) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
 
-		inode->i_state |= I_FREEING;
+		inode_state_add(inode, I_FREEING);
 		inode_lru_list_del(inode);
 		spin_unlock(&inode->i_lock);
 		list_add(&inode->i_lru, &dispose);
@@ -938,7 +938,7 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 	 * sync, or the last page cache deletion will requeue them.
 	 */
 	if (icount_read(inode) ||
-	    (inode->i_state & ~I_REFERENCED) ||
+	    (inode_state_read(inode) & ~I_REFERENCED) ||
 	    !mapping_shrinkable(&inode->i_data)) {
 		list_lru_isolate(lru, &inode->i_lru);
 		spin_unlock(&inode->i_lock);
@@ -947,8 +947,8 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 	}
 
 	/* Recently referenced inodes get one more pass */
-	if (inode->i_state & I_REFERENCED) {
-		inode->i_state &= ~I_REFERENCED;
+	if (inode_state_read(inode) & I_REFERENCED) {
+		inode_state_del(inode, I_REFERENCED);
 		spin_unlock(&inode->i_lock);
 		return LRU_ROTATE;
 	}
@@ -975,8 +975,8 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 		return LRU_RETRY;
 	}
 
-	WARN_ON(inode->i_state & I_NEW);
-	inode->i_state |= I_FREEING;
+	WARN_ON(inode_state_read(inode) & I_NEW);
+	inode_state_add(inode, I_FREEING);
 	list_lru_isolate_move(lru, &inode->i_lru, freeable);
 	spin_unlock(&inode->i_lock);
 
@@ -1025,11 +1025,11 @@ static struct inode *find_inode(struct super_block *sb,
 		if (!test(inode, data))
 			continue;
 		spin_lock(&inode->i_lock);
-		if (inode->i_state & (I_FREEING|I_WILL_FREE)) {
+		if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE)) {
 			__wait_on_freeing_inode(inode, is_inode_hash_locked);
 			goto repeat;
 		}
-		if (unlikely(inode->i_state & I_CREATING)) {
+		if (unlikely(inode_state_read(inode) & I_CREATING)) {
 			spin_unlock(&inode->i_lock);
 			rcu_read_unlock();
 			return ERR_PTR(-ESTALE);
@@ -1066,11 +1066,11 @@ static struct inode *find_inode_fast(struct super_block *sb,
 		if (inode->i_sb != sb)
 			continue;
 		spin_lock(&inode->i_lock);
-		if (inode->i_state & (I_FREEING|I_WILL_FREE)) {
+		if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE)) {
 			__wait_on_freeing_inode(inode, is_inode_hash_locked);
 			goto repeat;
 		}
-		if (unlikely(inode->i_state & I_CREATING)) {
+		if (unlikely(inode_state_read(inode) & I_CREATING)) {
 			spin_unlock(&inode->i_lock);
 			rcu_read_unlock();
 			return ERR_PTR(-ESTALE);
@@ -1180,8 +1180,8 @@ void unlock_new_inode(struct inode *inode)
 {
 	lockdep_annotate_inode_mutex_key(inode);
 	spin_lock(&inode->i_lock);
-	WARN_ON(!(inode->i_state & I_NEW));
-	inode->i_state &= ~I_NEW & ~I_CREATING;
+	WARN_ON(!(inode_state_read(inode) & I_NEW));
+	inode_state_del(inode, I_NEW | I_CREATING);
 	/*
 	 * Pairs with the barrier in prepare_to_wait_event() to make sure
 	 * ___wait_var_event() either sees the bit cleared or
@@ -1197,8 +1197,8 @@ void discard_new_inode(struct inode *inode)
 {
 	lockdep_annotate_inode_mutex_key(inode);
 	spin_lock(&inode->i_lock);
-	WARN_ON(!(inode->i_state & I_NEW));
-	inode->i_state &= ~I_NEW;
+	WARN_ON(!(inode_state_read(inode) & I_NEW));
+	inode_state_del(inode, I_NEW);
 	/*
 	 * Pairs with the barrier in prepare_to_wait_event() to make sure
 	 * ___wait_var_event() either sees the bit cleared or
@@ -1308,7 +1308,7 @@ struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
 	 * caller is responsible for filling in the contents
 	 */
 	spin_lock(&inode->i_lock);
-	inode->i_state |= I_NEW;
+	inode_state_add(inode, I_NEW);
 	hlist_add_head_rcu(&inode->i_hash, head);
 	spin_unlock(&inode->i_lock);
 
@@ -1445,7 +1445,7 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
 		if (!old) {
 			inode->i_ino = ino;
 			spin_lock(&inode->i_lock);
-			inode->i_state = I_NEW;
+			inode_state_set(inode, I_NEW);
 			hlist_add_head_rcu(&inode->i_hash, head);
 			spin_unlock(&inode->i_lock);
 			spin_unlock(&inode_hash_lock);
@@ -1538,7 +1538,7 @@ EXPORT_SYMBOL(iunique);
 struct inode *igrab(struct inode *inode)
 {
 	spin_lock(&inode->i_lock);
-	if (!(inode->i_state & (I_FREEING|I_WILL_FREE))) {
+	if (!(inode_state_read(inode) & (I_FREEING | I_WILL_FREE))) {
 		__iget(inode);
 		spin_unlock(&inode->i_lock);
 	} else {
@@ -1728,7 +1728,7 @@ struct inode *find_inode_rcu(struct super_block *sb, unsigned long hashval,
 
 	hlist_for_each_entry_rcu(inode, head, i_hash) {
 		if (inode->i_sb == sb &&
-		    !(READ_ONCE(inode->i_state) & (I_FREEING | I_WILL_FREE)) &&
+		    !(inode_state_read(inode) & (I_FREEING | I_WILL_FREE)) &&
 		    test(inode, data))
 			return inode;
 	}
@@ -1767,7 +1767,7 @@ struct inode *find_inode_by_ino_rcu(struct super_block *sb,
 	hlist_for_each_entry_rcu(inode, head, i_hash) {
 		if (inode->i_ino == ino &&
 		    inode->i_sb == sb &&
-		    !(READ_ONCE(inode->i_state) & (I_FREEING | I_WILL_FREE)))
+		    !(inode_state_read(inode) & (I_FREEING | I_WILL_FREE)))
 		    return inode;
 	}
 	return NULL;
@@ -1789,7 +1789,7 @@ int insert_inode_locked(struct inode *inode)
 			if (old->i_sb != sb)
 				continue;
 			spin_lock(&old->i_lock);
-			if (old->i_state & (I_FREEING|I_WILL_FREE)) {
+			if (inode_state_read(old) & (I_FREEING | I_WILL_FREE)) {
 				spin_unlock(&old->i_lock);
 				continue;
 			}
@@ -1797,13 +1797,13 @@ int insert_inode_locked(struct inode *inode)
 		}
 		if (likely(!old)) {
 			spin_lock(&inode->i_lock);
-			inode->i_state |= I_NEW | I_CREATING;
+			inode_state_add(inode, I_NEW | I_CREATING);
 			hlist_add_head_rcu(&inode->i_hash, head);
 			spin_unlock(&inode->i_lock);
 			spin_unlock(&inode_hash_lock);
 			return 0;
 		}
-		if (unlikely(old->i_state & I_CREATING)) {
+		if (unlikely(inode_state_read(old) & I_CREATING)) {
 			spin_unlock(&old->i_lock);
 			spin_unlock(&inode_hash_lock);
 			return -EBUSY;
@@ -1826,7 +1826,7 @@ int insert_inode_locked4(struct inode *inode, unsigned long hashval,
 {
 	struct inode *old;
 
-	inode->i_state |= I_CREATING;
+	inode_state_add(inode, I_CREATING);
 	old = inode_insert5(inode, hashval, test, NULL, data);
 
 	if (old != inode) {
@@ -1861,7 +1861,7 @@ static void iput_final(struct inode *inode)
 	unsigned long state;
 	int drop;
 
-	WARN_ON(inode->i_state & I_NEW);
+	WARN_ON(inode_state_read(inode) & I_NEW);
 
 	if (op->drop_inode)
 		drop = op->drop_inode(inode);
@@ -1869,14 +1869,14 @@ static void iput_final(struct inode *inode)
 		drop = generic_drop_inode(inode);
 
 	if (!drop &&
-	    !(inode->i_state & I_DONTCACHE) &&
+	    !(inode_state_read(inode) & I_DONTCACHE) &&
 	    (sb->s_flags & SB_ACTIVE)) {
 		__inode_add_lru(inode, true);
 		spin_unlock(&inode->i_lock);
 		return;
 	}
 
-	state = inode->i_state;
+	state = inode_state_read(inode);
 	if (!drop) {
 		WRITE_ONCE(inode->i_state, state | I_WILL_FREE);
 		spin_unlock(&inode->i_lock);
@@ -1884,7 +1884,7 @@ static void iput_final(struct inode *inode)
 		write_inode_now(inode, 1);
 
 		spin_lock(&inode->i_lock);
-		state = inode->i_state;
+		state = inode_state_read(inode);
 		WARN_ON(state & I_NEW);
 		state &= ~I_WILL_FREE;
 	}
@@ -1913,7 +1913,7 @@ void iput(struct inode *inode)
 
 retry:
 	lockdep_assert_not_held(&inode->i_lock);
-	VFS_BUG_ON_INODE(inode->i_state & I_CLEAR, inode);
+	VFS_BUG_ON_INODE(inode_state_read(inode) & I_CLEAR, inode);
 	/*
 	 * Note this assert is technically racy as if the count is bogusly
 	 * equal to one, then two CPUs racing to further drop it can both
@@ -1924,14 +1924,14 @@ void iput(struct inode *inode)
 	if (atomic_add_unless(&inode->i_count, -1, 1))
 		return;
 
-	if ((inode->i_state & I_DIRTY_TIME) && inode->i_nlink) {
+	if ((inode_state_read(inode) & I_DIRTY_TIME) && inode->i_nlink) {
 		trace_writeback_lazytime_iput(inode);
 		mark_inode_dirty_sync(inode);
 		goto retry;
 	}
 
 	spin_lock(&inode->i_lock);
-	if (unlikely((inode->i_state & I_DIRTY_TIME) && inode->i_nlink)) {
+	if (unlikely((inode_state_read(inode) & I_DIRTY_TIME) && inode->i_nlink)) {
 		spin_unlock(&inode->i_lock);
 		goto retry;
 	}
diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 6f0e6b19383c..8df4604f924e 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -1515,7 +1515,7 @@ struct inode *__isofs_iget(struct super_block *sb,
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read(inode) & I_NEW) {
 		ret = isofs_read_inode(inode, relocated);
 		if (ret < 0) {
 			iget_failed(inode);
diff --git a/fs/jffs2/fs.c b/fs/jffs2/fs.c
index d175cccb7c55..5accfde81c57 100644
--- a/fs/jffs2/fs.c
+++ b/fs/jffs2/fs.c
@@ -265,7 +265,7 @@ struct inode *jffs2_iget(struct super_block *sb, unsigned long ino)
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read(inode) & I_NEW))
 		return inode;
 
 	f = JFFS2_INODE_INFO(inode);
@@ -373,7 +373,7 @@ void jffs2_dirty_inode(struct inode *inode, int flags)
 {
 	struct iattr iattr;
 
-	if (!(inode->i_state & I_DIRTY_DATASYNC)) {
+	if (!(inode_state_read(inode) & I_DIRTY_DATASYNC)) {
 		jffs2_dbg(2, "%s(): not calling setattr() for ino #%lu\n",
 			  __func__, inode->i_ino);
 		return;
diff --git a/fs/jfs/file.c b/fs/jfs/file.c
index 2a4a288b821c..681d5aad2a31 100644
--- a/fs/jfs/file.c
+++ b/fs/jfs/file.c
@@ -26,8 +26,8 @@ int jfs_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 		return rc;
 
 	inode_lock(inode);
-	if (!(inode->i_state & I_DIRTY_ALL) ||
-	    (datasync && !(inode->i_state & I_DIRTY_DATASYNC))) {
+	if (!(inode_state_read(inode) & I_DIRTY_ALL) ||
+	    (datasync && !(inode_state_read(inode) & I_DIRTY_DATASYNC))) {
 		/* Make sure committed changes hit the disk */
 		jfs_flush_journal(JFS_SBI(inode->i_sb)->log, 1);
 		inode_unlock(inode);
diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
index fcedeb514e14..1bf1fe8bbb1d 100644
--- a/fs/jfs/inode.c
+++ b/fs/jfs/inode.c
@@ -29,7 +29,7 @@ struct inode *jfs_iget(struct super_block *sb, unsigned long ino)
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read(inode) & I_NEW))
 		return inode;
 
 	ret = diRead(inode);
diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
index be17e3c43582..0a117ab53f2b 100644
--- a/fs/jfs/jfs_txnmgr.c
+++ b/fs/jfs/jfs_txnmgr.c
@@ -1286,7 +1286,7 @@ int txCommit(tid_t tid,		/* transaction identifier */
 		 * to verify this, only a trivial s/I_LOCK/I_SYNC/ was done.
 		 * Joern
 		 */
-		if (tblk->u.ip->i_state & I_SYNC)
+		if (inode_state_read(tblk->u.ip) & I_SYNC)
 			tblk->xflag &= ~COMMIT_LAZY;
 	}
 
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 3c293a5a21b1..f4f46b32d7da 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -251,7 +251,7 @@ struct inode *kernfs_get_inode(struct super_block *sb, struct kernfs_node *kn)
 	struct inode *inode;
 
 	inode = iget_locked(sb, kernfs_ino(kn));
-	if (inode && (inode->i_state & I_NEW))
+	if (inode && (inode_state_read(inode) & I_NEW))
 		kernfs_init_inode(kn, inode);
 
 	return inode;
diff --git a/fs/libfs.c b/fs/libfs.c
index ce8c496a6940..0e00a153e9e3 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1542,9 +1542,9 @@ int __generic_file_fsync(struct file *file, loff_t start, loff_t end,
 
 	inode_lock(inode);
 	ret = sync_mapping_buffers(inode->i_mapping);
-	if (!(inode->i_state & I_DIRTY_ALL))
+	if (!(inode_state_read(inode) & I_DIRTY_ALL))
 		goto out;
-	if (datasync && !(inode->i_state & I_DIRTY_DATASYNC))
+	if (datasync && !(inode_state_read(inode) & I_DIRTY_DATASYNC))
 		goto out;
 
 	err = sync_inode_metadata(inode, 1);
@@ -1664,7 +1664,7 @@ struct inode *alloc_anon_inode(struct super_block *s)
 	 * list because mark_inode_dirty() will think
 	 * that it already _is_ on the dirty list.
 	 */
-	inode->i_state = I_DIRTY;
+	inode_state_set(inode, I_DIRTY);
 	/*
 	 * Historically anonymous inodes don't have a type at all and
 	 * userspace has come to rely on this.
diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index df9d11479caf..a5d93614dce6 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -583,7 +583,7 @@ struct inode *minix_iget(struct super_block *sb, unsigned long ino)
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read(inode) & I_NEW))
 		return inode;
 
 	if (INODE_VERSION(inode) == MINIX_V1)
diff --git a/fs/namei.c b/fs/namei.c
index cd43ff89fbaa..d1e381b83f14 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3948,7 +3948,7 @@ int vfs_tmpfile(struct mnt_idmap *idmap,
 	inode = file_inode(file);
 	if (!(open_flag & O_EXCL)) {
 		spin_lock(&inode->i_lock);
-		inode->i_state |= I_LINKABLE;
+		inode_state_add(inode, I_LINKABLE);
 		spin_unlock(&inode->i_lock);
 	}
 	security_inode_post_create_tmpfile(idmap, inode);
@@ -4844,7 +4844,7 @@ int vfs_link(struct dentry *old_dentry, struct mnt_idmap *idmap,
 
 	inode_lock(inode);
 	/* Make sure we don't allow creating hardlink to an unlinked file */
-	if (inode->i_nlink == 0 && !(inode->i_state & I_LINKABLE))
+	if (inode->i_nlink == 0 && !(inode_state_read(inode) & I_LINKABLE))
 		error =  -ENOENT;
 	else if (max_links && inode->i_nlink >= max_links)
 		error = -EMLINK;
@@ -4854,9 +4854,9 @@ int vfs_link(struct dentry *old_dentry, struct mnt_idmap *idmap,
 			error = dir->i_op->link(old_dentry, dir, new_dentry);
 	}
 
-	if (!error && (inode->i_state & I_LINKABLE)) {
+	if (!error && (inode_state_read(inode) & I_LINKABLE)) {
 		spin_lock(&inode->i_lock);
-		inode->i_state &= ~I_LINKABLE;
+		inode_state_del(inode, I_LINKABLE);
 		spin_unlock(&inode->i_lock);
 	}
 	inode_unlock(inode);
diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 20748bcfbf59..e9f880e9276b 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -147,10 +147,10 @@ bool netfs_dirty_folio(struct address_space *mapping, struct folio *folio)
 	if (!fscache_cookie_valid(cookie))
 		return true;
 
-	if (!(inode->i_state & I_PINNING_NETFS_WB)) {
+	if (!(inode_state_read(inode) & I_PINNING_NETFS_WB)) {
 		spin_lock(&inode->i_lock);
-		if (!(inode->i_state & I_PINNING_NETFS_WB)) {
-			inode->i_state |= I_PINNING_NETFS_WB;
+		if (!(inode_state_read(inode) & I_PINNING_NETFS_WB)) {
+			inode_state_add(inode, I_PINNING_NETFS_WB);
 			need_use = true;
 		}
 		spin_unlock(&inode->i_lock);
@@ -192,7 +192,7 @@ void netfs_clear_inode_writeback(struct inode *inode, const void *aux)
 {
 	struct fscache_cookie *cookie = netfs_i_cookie(netfs_inode(inode));
 
-	if (inode->i_state & I_PINNING_NETFS_WB) {
+	if (inode_state_read(inode) & I_PINNING_NETFS_WB) {
 		loff_t i_size = i_size_read(inode);
 		fscache_unuse_cookie(cookie, aux, &i_size);
 	}
diff --git a/fs/netfs/read_single.c b/fs/netfs/read_single.c
index fa622a6cd56d..f10bcf19e7cc 100644
--- a/fs/netfs/read_single.c
+++ b/fs/netfs/read_single.c
@@ -36,12 +36,12 @@ void netfs_single_mark_inode_dirty(struct inode *inode)
 
 	mark_inode_dirty(inode);
 
-	if (caching && !(inode->i_state & I_PINNING_NETFS_WB)) {
+	if (caching && !(inode_state_read(inode) & I_PINNING_NETFS_WB)) {
 		bool need_use = false;
 
 		spin_lock(&inode->i_lock);
-		if (!(inode->i_state & I_PINNING_NETFS_WB)) {
-			inode->i_state |= I_PINNING_NETFS_WB;
+		if (!(inode_state_read(inode) & I_PINNING_NETFS_WB)) {
+			inode_state_add(inode, I_PINNING_NETFS_WB);
 			need_use = true;
 		}
 		spin_unlock(&inode->i_lock);
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index b52805951856..e0b3e5ce3d9c 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -475,7 +475,7 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 		goto out_no_inode;
 	}
 
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read(inode) & I_NEW) {
 		struct nfs_inode *nfsi = NFS_I(inode);
 		unsigned long now = jiffies;
 
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index a3135b5af7ee..f157d43d1312 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -317,7 +317,7 @@ pnfs_put_layout_hdr(struct pnfs_layout_hdr *lo)
 			WARN_ONCE(1, "NFS: BUG unfreed layout segments.\n");
 		pnfs_detach_layout_hdr(lo);
 		/* Notify pnfs_destroy_layout_final() that we're done */
-		if (inode->i_state & (I_FREEING | I_CLEAR))
+		if (inode_state_read(inode) & (I_FREEING | I_CLEAR))
 			wake_up_var_locked(lo, &inode->i_lock);
 		spin_unlock(&inode->i_lock);
 		pnfs_free_layout_hdr(lo);
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 98ab55ba3ced..34adeb8495af 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1139,7 +1139,7 @@ static int wait_for_concurrent_writes(struct file *file)
 		dprintk("nfsd: write resume %d\n", task_pid_nr(current));
 	}
 
-	if (inode->i_state & I_DIRTY) {
+	if (inode_state_read(inode) & I_DIRTY) {
 		dprintk("nfsd: write sync %d\n", task_pid_nr(current));
 		err = vfs_fsync(file, 0);
 	}
diff --git a/fs/nilfs2/cpfile.c b/fs/nilfs2/cpfile.c
index bcc7d76269ac..bf76b1f889f4 100644
--- a/fs/nilfs2/cpfile.c
+++ b/fs/nilfs2/cpfile.c
@@ -1148,7 +1148,7 @@ int nilfs_cpfile_read(struct super_block *sb, size_t cpsize,
 	cpfile = nilfs_iget_locked(sb, NULL, NILFS_CPFILE_INO);
 	if (unlikely(!cpfile))
 		return -ENOMEM;
-	if (!(cpfile->i_state & I_NEW))
+	if (!(inode_state_read(cpfile) & I_NEW))
 		goto out;
 
 	err = nilfs_mdt_init(cpfile, NILFS_MDT_GFP, 0);
diff --git a/fs/nilfs2/dat.c b/fs/nilfs2/dat.c
index c664daba56ae..036783382045 100644
--- a/fs/nilfs2/dat.c
+++ b/fs/nilfs2/dat.c
@@ -506,7 +506,7 @@ int nilfs_dat_read(struct super_block *sb, size_t entry_size,
 	dat = nilfs_iget_locked(sb, NULL, NILFS_DAT_INO);
 	if (unlikely(!dat))
 		return -ENOMEM;
-	if (!(dat->i_state & I_NEW))
+	if (!(inode_state_read(dat) & I_NEW))
 		goto out;
 
 	err = nilfs_mdt_init(dat, NILFS_MDT_GFP, sizeof(*di));
diff --git a/fs/nilfs2/ifile.c b/fs/nilfs2/ifile.c
index c4cd4a4dedd0..ec0ce8c1bb0f 100644
--- a/fs/nilfs2/ifile.c
+++ b/fs/nilfs2/ifile.c
@@ -188,7 +188,7 @@ int nilfs_ifile_read(struct super_block *sb, struct nilfs_root *root,
 	ifile = nilfs_iget_locked(sb, root, NILFS_IFILE_INO);
 	if (unlikely(!ifile))
 		return -ENOMEM;
-	if (!(ifile->i_state & I_NEW))
+	if (!(inode_state_read(ifile) & I_NEW))
 		goto out;
 
 	err = nilfs_mdt_init(ifile, NILFS_MDT_GFP,
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 87ddde159f0c..097d7592d672 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -365,7 +365,7 @@ struct inode *nilfs_new_inode(struct inode *dir, umode_t mode)
 
  failed_after_creation:
 	clear_nlink(inode);
-	if (inode->i_state & I_NEW)
+	if (inode_state_read(inode) & I_NEW)
 		unlock_new_inode(inode);
 	iput(inode);  /*
 		       * raw_inode will be deleted through
@@ -562,7 +562,7 @@ struct inode *nilfs_iget(struct super_block *sb, struct nilfs_root *root,
 	if (unlikely(!inode))
 		return ERR_PTR(-ENOMEM);
 
-	if (!(inode->i_state & I_NEW)) {
+	if (!(inode_state_read(inode) & I_NEW)) {
 		if (!inode->i_nlink) {
 			iput(inode);
 			return ERR_PTR(-ESTALE);
@@ -591,7 +591,7 @@ struct inode *nilfs_iget_for_gc(struct super_block *sb, unsigned long ino,
 	inode = iget5_locked(sb, ino, nilfs_iget_test, nilfs_iget_set, &args);
 	if (unlikely(!inode))
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read(inode) & I_NEW))
 		return inode;
 
 	err = nilfs_init_gcinode(inode);
@@ -631,7 +631,7 @@ int nilfs_attach_btree_node_cache(struct inode *inode)
 				  nilfs_iget_set, &args);
 	if (unlikely(!btnc_inode))
 		return -ENOMEM;
-	if (btnc_inode->i_state & I_NEW) {
+	if (inode_state_read(btnc_inode) & I_NEW) {
 		nilfs_init_btnc_inode(btnc_inode);
 		unlock_new_inode(btnc_inode);
 	}
@@ -686,7 +686,7 @@ struct inode *nilfs_iget_for_shadow(struct inode *inode)
 			       nilfs_iget_set, &args);
 	if (unlikely(!s_inode))
 		return ERR_PTR(-ENOMEM);
-	if (!(s_inode->i_state & I_NEW))
+	if (!(inode_state_read(s_inode) & I_NEW))
 		return inode;
 
 	NILFS_I(s_inode)->i_flags = 0;
diff --git a/fs/nilfs2/sufile.c b/fs/nilfs2/sufile.c
index 330f269abedf..a4cb1b4c43fc 100644
--- a/fs/nilfs2/sufile.c
+++ b/fs/nilfs2/sufile.c
@@ -1226,7 +1226,7 @@ int nilfs_sufile_read(struct super_block *sb, size_t susize,
 	sufile = nilfs_iget_locked(sb, NULL, NILFS_SUFILE_INO);
 	if (unlikely(!sufile))
 		return -ENOMEM;
-	if (!(sufile->i_state & I_NEW))
+	if (!(inode_state_read(sufile) & I_NEW))
 		goto out;
 
 	err = nilfs_mdt_init(sufile, NILFS_MDT_GFP, sizeof(*sui));
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 46bfc543f946..d27ff5e5f165 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -52,7 +52,7 @@ static void fsnotify_unmount_inodes(struct super_block *sb)
 		 * the inode cannot have any associated watches.
 		 */
 		spin_lock(&inode->i_lock);
-		if (inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) {
+		if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 37cbbee7fa58..132fc2793ae3 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -536,7 +536,7 @@ struct inode *ntfs_iget5(struct super_block *sb, const struct MFT_REF *ref,
 		return ERR_PTR(-ENOMEM);
 
 	/* If this is a freshly allocated inode, need to read it now. */
-	if (inode->i_state & I_NEW)
+	if (inode_state_read(inode) & I_NEW)
 		inode = ntfs_read_mft(inode, name, ref);
 	else if (ref->seq != ntfs_i(inode)->mi.mrec->seq) {
 		/*
diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
index 92a6149da9c1..db8919b02d78 100644
--- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -2487,7 +2487,7 @@ int ocfs2_inode_lock_full_nested(struct inode *inode,
 	 * which hasn't been populated yet, so clear the refresh flag
 	 * and let the caller handle it.
 	 */
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read(inode) & I_NEW) {
 		status = 0;
 		if (lockres)
 			ocfs2_complete_lock_res_refresh(lockres, 0);
diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index 14bf440ea4df..7810c43392b0 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -153,7 +153,7 @@ struct inode *ocfs2_iget(struct ocfs2_super *osb, u64 blkno, unsigned flags,
 		goto bail;
 	}
 	trace_ocfs2_iget5_locked(inode->i_state);
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read(inode) & I_NEW) {
 		rc = ocfs2_read_locked_inode(inode, &args);
 		unlock_new_inode(inode);
 	}
@@ -1307,12 +1307,12 @@ int ocfs2_drop_inode(struct inode *inode)
 				inode->i_nlink, oi->ip_flags);
 
 	assert_spin_locked(&inode->i_lock);
-	inode->i_state |= I_WILL_FREE;
+	inode_state_add(inode, I_WILL_FREE);
 	spin_unlock(&inode->i_lock);
 	write_inode_now(inode, 1);
 	spin_lock(&inode->i_lock);
-	WARN_ON(inode->i_state & I_NEW);
-	inode->i_state &= ~I_WILL_FREE;
+	WARN_ON(inode_state_read(inode) & I_NEW);
+	inode_state_del(inode, I_WILL_FREE);
 
 	return 1;
 }
diff --git a/fs/omfs/inode.c b/fs/omfs/inode.c
index 135c49c5d848..a92d523a6ed6 100644
--- a/fs/omfs/inode.c
+++ b/fs/omfs/inode.c
@@ -212,7 +212,7 @@ struct inode *omfs_iget(struct super_block *sb, ino_t ino)
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read(inode) & I_NEW))
 		return inode;
 
 	bh = omfs_bread(inode->i_sb, ino);
diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
index 26ecda0e4d19..6876b8f24bd0 100644
--- a/fs/openpromfs/inode.c
+++ b/fs/openpromfs/inode.c
@@ -236,7 +236,7 @@ static struct dentry *openpromfs_lookup(struct inode *dir, struct dentry *dentry
 	mutex_unlock(&op_mutex);
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read(inode) & I_NEW) {
 		simple_inode_init_ts(inode);
 		ent_oi = OP_I(inode);
 		ent_oi->type = ent_type;
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index a01400cd41fd..a26f561793ca 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -1041,7 +1041,7 @@ struct inode *orangefs_iget(struct super_block *sb,
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read(inode) & I_NEW))
 		return inode;
 
 	error = orangefs_inode_getattr(inode, ORANGEFS_GETATTR_NEW);
diff --git a/fs/orangefs/orangefs-utils.c b/fs/orangefs/orangefs-utils.c
index 0fdceb00ca07..9ab1119ebd28 100644
--- a/fs/orangefs/orangefs-utils.c
+++ b/fs/orangefs/orangefs-utils.c
@@ -247,7 +247,7 @@ int orangefs_inode_getattr(struct inode *inode, int flags)
 	spin_lock(&inode->i_lock);
 	/* Must have all the attributes in the mask and be within cache time. */
 	if ((!flags && time_before(jiffies, orangefs_inode->getattr_time)) ||
-	    orangefs_inode->attr_valid || inode->i_state & I_DIRTY_PAGES) {
+	    orangefs_inode->attr_valid || inode_state_read(inode) & I_DIRTY_PAGES) {
 		if (orangefs_inode->attr_valid) {
 			spin_unlock(&inode->i_lock);
 			write_inode_now(inode, 1);
@@ -281,13 +281,13 @@ int orangefs_inode_getattr(struct inode *inode, int flags)
 	spin_lock(&inode->i_lock);
 	/* Must have all the attributes in the mask and be within cache time. */
 	if ((!flags && time_before(jiffies, orangefs_inode->getattr_time)) ||
-	    orangefs_inode->attr_valid || inode->i_state & I_DIRTY_PAGES) {
+	    orangefs_inode->attr_valid || inode_state_read(inode) & I_DIRTY_PAGES) {
 		if (orangefs_inode->attr_valid) {
 			spin_unlock(&inode->i_lock);
 			write_inode_now(inode, 1);
 			goto again2;
 		}
-		if (inode->i_state & I_DIRTY_PAGES) {
+		if (inode_state_read(inode) & I_DIRTY_PAGES) {
 			ret = 0;
 			goto out_unlock;
 		}
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 70b8687dc45e..eb3419c25dfc 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -659,7 +659,7 @@ static int ovl_create_object(struct dentry *dentry, int mode, dev_t rdev,
 		goto out_drop_write;
 
 	spin_lock(&inode->i_lock);
-	inode->i_state |= I_CREATING;
+	inode_state_add(inode, I_CREATING);
 	spin_unlock(&inode->i_lock);
 
 	inode_init_owner(&nop_mnt_idmap, inode, dentry->d_parent->d_inode, mode);
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index ecb9f2019395..45515e590c6a 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -1149,7 +1149,7 @@ struct inode *ovl_get_trap_inode(struct super_block *sb, struct dentry *dir)
 	if (!trap)
 		return ERR_PTR(-ENOMEM);
 
-	if (!(trap->i_state & I_NEW)) {
+	if (!(inode_state_read(trap) & I_NEW)) {
 		/* Conflicting layer roots? */
 		iput(trap);
 		return ERR_PTR(-ELOOP);
@@ -1240,7 +1240,7 @@ struct inode *ovl_get_inode(struct super_block *sb,
 		inode = ovl_iget5(sb, oip->newinode, key);
 		if (!inode)
 			goto out_err;
-		if (!(inode->i_state & I_NEW)) {
+		if (!(inode_state_read(inode) & I_NEW)) {
 			/*
 			 * Verify that the underlying files stored in the inode
 			 * match those in the dentry.
@@ -1299,7 +1299,7 @@ struct inode *ovl_get_inode(struct super_block *sb,
 	if (upperdentry)
 		ovl_check_protattr(inode, upperdentry);
 
-	if (inode->i_state & I_NEW)
+	if (inode_state_read(inode) & I_NEW)
 		unlock_new_inode(inode);
 out:
 	return inode;
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index a33115e7384c..cfc7a7b00fba 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1019,8 +1019,8 @@ bool ovl_inuse_trylock(struct dentry *dentry)
 	bool locked = false;
 
 	spin_lock(&inode->i_lock);
-	if (!(inode->i_state & I_OVL_INUSE)) {
-		inode->i_state |= I_OVL_INUSE;
+	if (!(inode_state_read(inode) & I_OVL_INUSE)) {
+		inode_state_add(inode, I_OVL_INUSE);
 		locked = true;
 	}
 	spin_unlock(&inode->i_lock);
@@ -1034,8 +1034,8 @@ void ovl_inuse_unlock(struct dentry *dentry)
 		struct inode *inode = d_inode(dentry);
 
 		spin_lock(&inode->i_lock);
-		WARN_ON(!(inode->i_state & I_OVL_INUSE));
-		inode->i_state &= ~I_OVL_INUSE;
+		WARN_ON(!(inode_state_read(inode) & I_OVL_INUSE));
+		inode_state_del(inode, I_OVL_INUSE);
 		spin_unlock(&inode->i_lock);
 	}
 }
@@ -1046,7 +1046,7 @@ bool ovl_is_inuse(struct dentry *dentry)
 	bool inuse;
 
 	spin_lock(&inode->i_lock);
-	inuse = (inode->i_state & I_OVL_INUSE);
+	inuse = (inode_state_read(inode) & I_OVL_INUSE);
 	spin_unlock(&inode->i_lock);
 
 	return inuse;
diff --git a/fs/pipe.c b/fs/pipe.c
index 731622d0738d..7a389c79df68 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -906,7 +906,7 @@ static struct inode * get_pipe_inode(void)
 	 * list because "mark_inode_dirty()" will think
 	 * that it already _is_ on the dirty list.
 	 */
-	inode->i_state = I_DIRTY;
+	inode_state_set(inode, I_DIRTY);
 	inode->i_mode = S_IFIFO | S_IRUSR | S_IWUSR;
 	inode->i_uid = current_fsuid();
 	inode->i_gid = current_fsgid();
diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
index e399e2dd3a12..ba8b91b61d22 100644
--- a/fs/qnx4/inode.c
+++ b/fs/qnx4/inode.c
@@ -290,7 +290,7 @@ struct inode *qnx4_iget(struct super_block *sb, unsigned long ino)
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read(inode) & I_NEW))
 		return inode;
 
 	qnx4_inode = qnx4_raw_inode(inode);
diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index 3310d1ad4d0e..46336d8710d3 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -521,7 +521,7 @@ struct inode *qnx6_iget(struct super_block *sb, unsigned ino)
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read(inode) & I_NEW))
 		return inode;
 
 	ei = QNX6_I(inode);
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index df4a9b348769..baf9c9173445 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -1030,7 +1030,7 @@ static int add_dquot_ref(struct super_block *sb, int type)
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		spin_lock(&inode->i_lock);
-		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) ||
+		if ((inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) ||
 		    !atomic_read(&inode->i_writecount) ||
 		    !dqinit_needed(inode, type)) {
 			spin_unlock(&inode->i_lock);
diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index 0addcc849ff2..751039ac5d8c 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -302,7 +302,7 @@ static struct inode *romfs_iget(struct super_block *sb, unsigned long pos)
 	if (!i)
 		return ERR_PTR(-ENOMEM);
 
-	if (!(i->i_state & I_NEW))
+	if (!(inode_state_read(i) & I_NEW))
 		return i;
 
 	/* precalculate the data offset */
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 3bd85ab2deb1..fe541ba94e3a 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -444,7 +444,7 @@ cifs_evict_inode(struct inode *inode)
 {
 	netfs_wait_for_outstanding_io(inode);
 	truncate_inode_pages_final(&inode->i_data);
-	if (inode->i_state & I_PINNING_NETFS_WB)
+	if (inode_state_read(inode) & I_PINNING_NETFS_WB)
 		cifs_fscache_unuse_inode_cookie(inode, true);
 	cifs_fscache_release_inode_cookie(inode);
 	clear_inode(inode);
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 211d5b8b42f4..03fab848c7c6 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -101,7 +101,7 @@ cifs_revalidate_cache(struct inode *inode, struct cifs_fattr *fattr)
 	cifs_dbg(FYI, "%s: revalidating inode %llu\n",
 		 __func__, cifs_i->uniqueid);
 
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read(inode) & I_NEW) {
 		cifs_dbg(FYI, "%s: inode %llu is new\n",
 			 __func__, cifs_i->uniqueid);
 		return;
@@ -146,7 +146,7 @@ cifs_nlink_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr)
 	 */
 	if (fattr->cf_flags & CIFS_FATTR_UNKNOWN_NLINK) {
 		/* only provide fake values on a new inode */
-		if (inode->i_state & I_NEW) {
+		if (inode_state_read(inode) & I_NEW) {
 			if (fattr->cf_cifsattrs & ATTR_DIRECTORY)
 				set_nlink(inode, 2);
 			else
@@ -167,12 +167,12 @@ cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr,
 	struct cifsInodeInfo *cifs_i = CIFS_I(inode);
 	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
 
-	if (!(inode->i_state & I_NEW) &&
+	if (!(inode_state_read(inode) & I_NEW) &&
 	    unlikely(inode_wrong_type(inode, fattr->cf_mode))) {
 		CIFS_I(inode)->time = 0; /* force reval */
 		return -ESTALE;
 	}
-	if (inode->i_state & I_NEW)
+	if (inode_state_read(inode) & I_NEW)
 		CIFS_I(inode)->netfs.zero_point = fattr->cf_eof;
 
 	cifs_revalidate_cache(inode, fattr);
@@ -194,7 +194,7 @@ cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr,
 	inode->i_gid = fattr->cf_gid;
 
 	/* if dynperm is set, don't clobber existing mode */
-	if (inode->i_state & I_NEW ||
+	if (inode_state_read(inode) & I_NEW ||
 	    !(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_DYNPERM))
 		inode->i_mode = fattr->cf_mode;
 
@@ -236,7 +236,7 @@ cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr,
 
 	if (fattr->cf_flags & CIFS_FATTR_JUNCTION)
 		inode->i_flags |= S_AUTOMOUNT;
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read(inode) & I_NEW) {
 		cifs_set_netfs_context(inode);
 		cifs_set_ops(inode);
 	}
@@ -1638,7 +1638,7 @@ cifs_iget(struct super_block *sb, struct cifs_fattr *fattr)
 		cifs_fattr_to_inode(inode, fattr, false);
 		if (sb->s_flags & SB_NOATIME)
 			inode->i_flags |= S_NOATIME | S_NOCMTIME;
-		if (inode->i_state & I_NEW) {
+		if (inode_state_read(inode) & I_NEW) {
 			inode->i_ino = hash;
 			cifs_fscache_get_inode_cookie(inode);
 			unlock_new_inode(inode);
diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index d5918eba27e3..29b78a15d3fb 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -82,7 +82,7 @@ struct inode *squashfs_iget(struct super_block *sb, long long ino,
 
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read(inode) & I_NEW))
 		return inode;
 
 	err = squashfs_read_inode(inode, ino);
diff --git a/fs/sync.c b/fs/sync.c
index 2955cd4c77a3..61f54a1ef8e9 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -182,7 +182,7 @@ int vfs_fsync_range(struct file *file, loff_t start, loff_t end, int datasync)
 
 	if (!file->f_op->fsync)
 		return -EINVAL;
-	if (!datasync && (inode->i_state & I_DIRTY_TIME))
+	if (!datasync && (inode_state_read(inode) & I_DIRTY_TIME))
 		mark_inode_dirty_sync(inode);
 	return file->f_op->fsync(file, start, end, datasync);
 }
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index e75a6cec67be..b9c9f8e2bf0a 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1323,7 +1323,7 @@ int ubifs_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	inode_lock(inode);
 
 	/* Synchronize the inode unless this is a 'datasync()' call. */
-	if (!datasync || (inode->i_state & I_DIRTY_DATASYNC)) {
+	if (!datasync || (inode_state_read(inode) & I_DIRTY_DATASYNC)) {
 		err = inode->i_sb->s_op->write_inode(inode, NULL);
 		if (err)
 			goto out;
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index a0269ba96e3d..3f0e53c45faa 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -114,7 +114,7 @@ struct inode *ubifs_iget(struct super_block *sb, unsigned long inum)
 	inode = iget_locked(sb, inum);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read(inode) & I_NEW))
 		return inode;
 	ui = ubifs_inode(inode);
 
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index f24aa98e6869..be7dda2ac12b 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -1962,7 +1962,7 @@ struct inode *__udf_iget(struct super_block *sb, struct kernel_lb_addr *ino,
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	if (!(inode->i_state & I_NEW)) {
+	if (!(inode_state_read(inode) & I_NEW)) {
 		if (UDF_I(inode)->i_hidden != hidden_inode) {
 			iput(inode);
 			return ERR_PTR(-EFSCORRUPTED);
diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index 8361c00e8fa6..24f7ee52bf2e 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -655,7 +655,7 @@ struct inode *ufs_iget(struct super_block *sb, unsigned long ino)
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read(inode) & I_NEW))
 		return inode;
 
 	ufsi = UFS_I(inode);
diff --git a/fs/xfs/scrub/common.c b/fs/xfs/scrub/common.c
index 2ef7742be7d3..e27cfbcfc5c9 100644
--- a/fs/xfs/scrub/common.c
+++ b/fs/xfs/scrub/common.c
@@ -1249,7 +1249,7 @@ xchk_irele(
 		 * hits do not clear DONTCACHE, so we must do it here.
 		 */
 		spin_lock(&VFS_I(ip)->i_lock);
-		VFS_I(ip)->i_state &= ~I_DONTCACHE;
+		inode_state_del(VFS_I(ip), I_DONTCACHE);
 		spin_unlock(&VFS_I(ip)->i_lock);
 	}
 
diff --git a/fs/xfs/scrub/inode_repair.c b/fs/xfs/scrub/inode_repair.c
index a90a011c7e5f..000287040a2c 100644
--- a/fs/xfs/scrub/inode_repair.c
+++ b/fs/xfs/scrub/inode_repair.c
@@ -1933,7 +1933,7 @@ xrep_inode_pptr(
 	 * Unlinked inodes that cannot be added to the directory tree will not
 	 * have a parent pointer.
 	 */
-	if (inode->i_nlink == 0 && !(inode->i_state & I_LINKABLE))
+	if (inode->i_nlink == 0 && !(inode_state_read(inode) & I_LINKABLE))
 		return 0;
 
 	/* Children of the superblock do not have parent pointers. */
diff --git a/fs/xfs/scrub/parent.c b/fs/xfs/scrub/parent.c
index 3b692c4acc1e..c55ef4338090 100644
--- a/fs/xfs/scrub/parent.c
+++ b/fs/xfs/scrub/parent.c
@@ -915,7 +915,7 @@ xchk_pptr_looks_zapped(
 	 * Temporary files that cannot be linked into the directory tree do not
 	 * have attr forks because they cannot ever have parents.
 	 */
-	if (inode->i_nlink == 0 && !(inode->i_state & I_LINKABLE))
+	if (inode->i_nlink == 0 && !(inode_state_read(inode) & I_LINKABLE))
 		return false;
 
 	/*
diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 06ca11731e43..cd156f19c3e7 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -514,7 +514,7 @@ xfs_can_free_eofblocks(
 	 * Caller must either hold the exclusive io lock; or be inactivating
 	 * the inode, which guarantees there are no other users of the inode.
 	 */
-	if (!(VFS_I(ip)->i_state & I_FREEING))
+	if (!(inode_state_read(VFS_I(ip)) & I_FREEING))
 		xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL);
 
 	/* prealloc/delalloc exists only on regular files */
diff --git a/fs/xfs/xfs_health.c b/fs/xfs/xfs_health.c
index 7c541fb373d5..c765a28b4556 100644
--- a/fs/xfs/xfs_health.c
+++ b/fs/xfs/xfs_health.c
@@ -285,7 +285,7 @@ xfs_inode_mark_sick(
 	 * is not the case here.
 	 */
 	spin_lock(&VFS_I(ip)->i_lock);
-	VFS_I(ip)->i_state &= ~I_DONTCACHE;
+	inode_state_del(VFS_I(ip), I_DONTCACHE);
 	spin_unlock(&VFS_I(ip)->i_lock);
 }
 
@@ -309,7 +309,7 @@ xfs_inode_mark_corrupt(
 	 * is not the case here.
 	 */
 	spin_lock(&VFS_I(ip)->i_lock);
-	VFS_I(ip)->i_state &= ~I_DONTCACHE;
+	inode_state_del(VFS_I(ip), I_DONTCACHE);
 	spin_unlock(&VFS_I(ip)->i_lock);
 }
 
diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 4cf7abe50143..a72c3ba3eafb 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -334,7 +334,7 @@ xfs_reinit_inode(
 	dev_t			dev = inode->i_rdev;
 	kuid_t			uid = inode->i_uid;
 	kgid_t			gid = inode->i_gid;
-	unsigned long		state = inode->i_state;
+	unsigned long		state = inode_state_read(inode);
 
 	error = inode_init_always(mp->m_super, inode);
 
@@ -345,7 +345,7 @@ xfs_reinit_inode(
 	inode->i_rdev = dev;
 	inode->i_uid = uid;
 	inode->i_gid = gid;
-	inode->i_state = state;
+	inode_state_set(inode, state);
 	mapping_set_folio_min_order(inode->i_mapping,
 				    M_IGEO(mp)->min_folio_order);
 	return error;
@@ -411,7 +411,7 @@ xfs_iget_recycle(
 	ip->i_flags |= XFS_INEW;
 	xfs_perag_clear_inode_tag(pag, XFS_INO_TO_AGINO(mp, ip->i_ino),
 			XFS_ICI_RECLAIM_TAG);
-	inode->i_state = I_NEW;
+	inode_state_set(inode, I_NEW);
 	spin_unlock(&ip->i_flags_lock);
 	spin_unlock(&pag->pag_ici_lock);
 
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index df8eab11dc48..e4689a5f149b 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -1569,7 +1569,7 @@ xfs_iunlink_reload_next(
 	next_ip->i_prev_unlinked = prev_agino;
 	trace_xfs_iunlink_reload_next(next_ip);
 rele:
-	ASSERT(!(VFS_I(next_ip)->i_state & I_DONTCACHE));
+	ASSERT(!(inode_state_read(VFS_I(next_ip)) & I_DONTCACHE));
 	if (xfs_is_quotacheck_running(mp) && next_ip)
 		xfs_iflags_set(next_ip, XFS_IQUOTAUNCHECKED);
 	xfs_irele(next_ip);
@@ -2093,7 +2093,7 @@ xfs_rename_alloc_whiteout(
 	 */
 	xfs_setup_iops(tmpfile);
 	xfs_finish_inode_setup(tmpfile);
-	VFS_I(tmpfile)->i_state |= I_LINKABLE;
+	inode_state_add(VFS_I(tmpfile), I_LINKABLE);
 
 	*wip = tmpfile;
 	return 0;
@@ -2319,7 +2319,7 @@ xfs_rename(
 		 * flag from the inode so it doesn't accidentally get misused in
 		 * future.
 		 */
-		VFS_I(du_wip.ip)->i_state &= ~I_LINKABLE;
+		inode_state_del(VFS_I(du_wip.ip), I_LINKABLE);
 	}
 
 out_commit:
diff --git a/fs/xfs/xfs_inode_item.c b/fs/xfs/xfs_inode_item.c
index 829675700fcd..aed644c008bc 100644
--- a/fs/xfs/xfs_inode_item.c
+++ b/fs/xfs/xfs_inode_item.c
@@ -113,9 +113,9 @@ xfs_inode_item_precommit(
 	 * to log the timestamps, or will clear already cleared fields in the
 	 * worst case.
 	 */
-	if (inode->i_state & I_DIRTY_TIME) {
+	if (inode_state_read(inode) & I_DIRTY_TIME) {
 		spin_lock(&inode->i_lock);
-		inode->i_state &= ~I_DIRTY_TIME;
+		inode_state_del(inode, I_DIRTY_TIME);
 		spin_unlock(&inode->i_lock);
 	}
 
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 149b5460fbfd..48b572346492 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1419,7 +1419,7 @@ xfs_setup_inode(
 	bool			is_meta = xfs_is_internal_inode(ip);
 
 	inode->i_ino = ip->i_ino;
-	inode->i_state |= I_NEW;
+	inode_state_add(inode, I_NEW);
 
 	inode_sb_list_add(inode);
 	/* make the inode look hashed for the writeback code */
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 4dc7f967c861..4fc65b747f6d 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -644,7 +644,7 @@ static struct inode *zonefs_get_file_inode(struct inode *dir,
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW)) {
+	if (!(inode_state_read(inode) & I_NEW)) {
 		WARN_ON_ONCE(inode->i_private != z);
 		return inode;
 	}
@@ -683,7 +683,7 @@ static struct inode *zonefs_get_zgroup_inode(struct super_block *sb,
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read(inode) & I_NEW))
 		return inode;
 
 	inode->i_ino = ino;
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 783904d8c5ef..305952e17812 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -72,7 +72,7 @@ static void collect_wb_stats(struct wb_stats *stats,
 	list_for_each_entry(inode, &wb->b_more_io, i_io_list)
 		stats->nr_more_io++;
 	list_for_each_entry(inode, &wb->b_dirty_time, i_io_list)
-		if (inode->i_state & I_DIRTY_TIME)
+		if (inode_state_read(inode) & I_DIRTY_TIME)
 			stats->nr_dirty_time++;
 	spin_unlock(&wb->list_lock);
 
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 0bade2c5aa1d..d4d72f406d58 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1296,7 +1296,7 @@ static void hook_sb_delete(struct super_block *const sb)
 		 * second call to iput() for the same Landlock object.  Also
 		 * checks I_NEW because such inode cannot be tied to an object.
 		 */
-		if (inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW)) {
+		if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-- 
2.43.0


