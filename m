Return-Path: <linux-fsdevel+bounces-63635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B9977BC7E33
	for <lists+linux-fsdevel@lfdr.de>; Thu, 09 Oct 2025 10:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA4EE4F8EF0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 08:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23B72DCF4C;
	Thu,  9 Oct 2025 07:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3CgIn8s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA23A2D5921
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Oct 2025 07:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996795; cv=none; b=fEJjzS8i5ijrJ1+OkHM+P5tkM//DGbQUH0SoPMF6dIqefntkLlPV7GNN7bLZjpANtVw/BFi1STx+k9zCXtmh8lOceF3UNtdQK2Q6TYQvDAhv+Ty7W0TOckToYJI8oiLUR3STDzE7jTrLzAl/roTTeym3kYD8+j/yAqdXm+pqQNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996795; c=relaxed/simple;
	bh=cufSrmyDW0uWHdfX8arSSIVv2GP2uza03kztsfD3kCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oucQyfGBCI8Xx4k6/wUwKgmGP1qcoH+ijHlMIcmHQKTbNh68pE81Q24k4IN/QAhiXVWjs7zHAaT63QwbMTdyWuRJnY37pOR1Se3lpUOll/gTp5NBdRkf5z2QyGiTl97CHm8rwUVLjnkKWNg+xcAWUNL4Y5zyhe8jiLmn0HSAHDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3CgIn8s; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-63963066fb0so1294608a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Oct 2025 00:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759996787; x=1760601587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODJwP34MaBpSxSDR36N4YTruQ+TAX69fxkWAUJugC7Y=;
        b=h3CgIn8sBsSEOBF3csi7SLnZNr6T9iWK5LmnOnzXZQYjUywMZh2npwIcgs9mkTr8E6
         bZih7Sxv2smqY7YvyAW/7CmskQWCF8P1yeZYiSmm+Y1pfdQ9Yrc6OpMzQvrT4NWHm8E1
         Slh9PcTIeGC3+sTzPgMRtGuzlh8EJsbGKCvIHu65H5sEzTPe49Q22I1JDbUszoyqDrQM
         m7DDFdKwk3xptP3C55WKjfL2/WjYBW26kJcjwHjM6LteD8AU2lF6Fu81GP0VtJTnHiGb
         ITM8ru6pBzHOfpBAFw5KUbFkyAk96MR3ctgfYPrCEdhX743BSJX4tf+G7FLBIIgri0lf
         fd0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759996787; x=1760601587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ODJwP34MaBpSxSDR36N4YTruQ+TAX69fxkWAUJugC7Y=;
        b=HvARltywalCec/K+cpJHOCe4z7C1fgjQCgPp4ECgYSIscdVGHC1MlbnoS1h46UMTae
         QgYfcFRDxvUXjOHQnBeAYFiC/tegjNh4DhCfUsrqwcTalxBOetIIHAWLmr6x/gvhuuCK
         ba6NsXWvrqkqL0mCd72I23YmsHOZ6u5o/bm534SU4iMLo98xuJkjaGl1+5RF3ksZ4rZs
         u8KHuJQ8VqBknISKwY+/RA5qrRpI/5mYMOpjlO4/x4Pqndw7XJGnmLQtPfmHHKjsEaNm
         SnOvT7Sf1sCDBhBrHFhwh4Xa8pWvUogb50wEBvxvJKctfJQeLsR5vkp8AZjnIonz5POE
         9d4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXS9rluaQcVxdJcawWC3xSwHAPxCC8XFZZRiMfEK32S14N08CxYVVtthXAa5DCsCZbTWCvv2Q0gUHqIrANb@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu8U4gEoomBUkUsjJ4uMZeEH4W8/TVl4hAHH9axJ4CgB7TBrAQ
	CUHMwWhw/PXZKLCnO3Z8Pr/8jMJbHTAcv1MwO1/tcMNNcfYqlnOLXbUn
X-Gm-Gg: ASbGnctz8TX2SVpbd+C7/Q1mYVaZ9o42PCIQZpne1Md0ZoDPSChdmLar2N36SgZMNys
	SBg8qMK/6L82NwOxckE0BElcXVXqB+KngIIGC6rJCOBH8LjMV04fAsqpabsvwlfiUiyW92jCn0z
	1tPYj7S/2J7fJHw5Li4yZj360cYMvjNYxcieYITbhrHAAr4+PDx2QcEjUO1I0P0rOPbMIspkudq
	xfMgAIgW/QUGSWd2oqU8ubF1O3tvErWkTgVs7iYBX40o2In9uIU+73wbyNBb9ofK4cYmUGT6Onf
	X/kYDsSGw0ksamz2DIV5lv7v5ewirF+SZp0sMn8TRo3k8IjG88q+pEZcEydY78NjE4E2MeBOUGA
	E0XM6M/oJttWilUM+vA7o21y+QWiL1ubFERpQ/CyE0Jl498vAjrBN9QPc9VTlo39hmZ+S+uHpc5
	lUBkUBNcYP15SsQjMIWO4v8FLn4o6ugCvK
X-Google-Smtp-Source: AGHT+IEieqhCYdRx0Ff3HzfXdAYFTgmRNW9jsu9K1glb+sDdLF3aKs4PUuYf+4bcU+vC4tP1CLqw2g==
X-Received: by 2002:a17:907:3e1b:b0:b3e:b226:5bb0 with SMTP id a640c23a62f3a-b50ac0cc032mr657388266b.42.1759996786579;
        Thu, 09 Oct 2025 00:59:46 -0700 (PDT)
Received: from f.. (cst-prg-66-155.cust.vodafone.cz. [46.135.66.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5007639379sm553509366b.48.2025.10.09.00.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 00:59:45 -0700 (PDT)
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
Subject: [PATCH v7 04/14] Coccinelle-based conversion to use ->i_state accessors
Date: Thu,  9 Oct 2025 09:59:18 +0200
Message-ID: <20251009075929.1203950-5-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251009075929.1203950-1-mjguzik@gmail.com>
References: <20251009075929.1203950-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All places were patched by coccinelle with the default expecting that
->i_lock is held, afterwards entries got fixed up by hand to use
unlocked variants as needed.

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
+ inode_state_clear(inode, flags)

@@
expression inode, flag1, flag2;
@@

- inode->i_state &= ~flag1 & ~flag2
+ inode_state_clear(inode, flag1 | flag2)

@@
expression inode, flags;
@@

- inode->i_state |= flags
+ inode_state_set(inode, flags)

@@
expression inode, flags;
@@

- inode->i_state = flags
+ inode_state_assign(inode, flags)

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
 fs/buffer.c                  |   4 +-
 fs/coda/cnode.c              |   4 +-
 fs/cramfs/inode.c            |   2 +-
 fs/crypto/keyring.c          |   2 +-
 fs/crypto/keysetup.c         |   2 +-
 fs/dcache.c                  |   8 +--
 fs/drop_caches.c             |   2 +-
 fs/ecryptfs/inode.c          |   6 +-
 fs/efs/inode.c               |   2 +-
 fs/erofs/inode.c             |   2 +-
 fs/ext2/inode.c              |   2 +-
 fs/freevxfs/vxfs_inode.c     |   2 +-
 fs/fs-writeback.c            | 120 +++++++++++++++++------------------
 fs/fuse/inode.c              |   4 +-
 fs/hfs/btree.c               |   2 +-
 fs/hfs/inode.c               |   2 +-
 fs/hfsplus/super.c           |   2 +-
 fs/hostfs/hostfs_kern.c      |   2 +-
 fs/hpfs/dir.c                |   2 +-
 fs/hpfs/inode.c              |   2 +-
 fs/inode.c                   |  92 +++++++++++++--------------
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
 fs/notify/fsnotify.c         |   2 +-
 fs/ntfs3/inode.c             |   2 +-
 fs/ocfs2/dlmglue.c           |   2 +-
 fs/ocfs2/inode.c             |   4 +-
 fs/omfs/inode.c              |   2 +-
 fs/openpromfs/inode.c        |   2 +-
 fs/orangefs/inode.c          |   2 +-
 fs/orangefs/orangefs-utils.c |   6 +-
 fs/pipe.c                    |   2 +-
 fs/qnx4/inode.c              |   2 +-
 fs/qnx6/inode.c              |   2 +-
 fs/quota/dquot.c             |   2 +-
 fs/romfs/super.c             |   2 +-
 fs/squashfs/inode.c          |   2 +-
 fs/sync.c                    |   2 +-
 fs/ubifs/file.c              |   2 +-
 fs/ubifs/super.c             |   2 +-
 fs/udf/inode.c               |   2 +-
 fs/ufs/inode.c               |   2 +-
 fs/zonefs/super.c            |   4 +-
 mm/backing-dev.c             |   2 +-
 security/landlock/fs.c       |   2 +-
 66 files changed, 199 insertions(+), 199 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 810707cca970..c33667e30eb7 100644
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
index d7714d8afb0f..c00b9dff4a06 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -433,7 +433,7 @@ static struct dax_device *dax_dev_get(dev_t devt)
 		return NULL;
 
 	dax_dev = to_dax_dev(inode);
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read_once(inode) & I_NEW) {
 		set_bit(DAXDEV_ALIVE, &dax_dev->flags);
 		inode->i_cdev = &dax_dev->cdev;
 		inode->i_mode = S_IFCHR;
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index d0c77ec31b1d..8666c9c62258 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -422,7 +422,7 @@ static struct inode *v9fs_qid_iget(struct super_block *sb,
 	inode = iget5_locked(sb, QID2INO(qid), test, v9fs_set_inode, st);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read_once(inode) & I_NEW))
 		return inode;
 	/*
 	 * initialize the inode with the stat info
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index be297e335468..1661a25f2772 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -112,7 +112,7 @@ static struct inode *v9fs_qid_iget_dotl(struct super_block *sb,
 	inode = iget5_locked(sb, QID2INO(qid), test, v9fs_set_inode_dotl, st);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read_once(inode) & I_NEW))
 		return inode;
 	/*
 	 * initialize the inode with the stat info
diff --git a/fs/affs/inode.c b/fs/affs/inode.c
index 0210df8d3500..0bfc7d151dcd 100644
--- a/fs/affs/inode.c
+++ b/fs/affs/inode.c
@@ -29,7 +29,7 @@ struct inode *affs_iget(struct super_block *sb, unsigned long ino)
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read_once(inode) & I_NEW))
 		return inode;
 
 	pr_debug("affs_iget(%lu)\n", inode->i_ino);
diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index 8c6130789fde..475012555100 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -64,7 +64,7 @@ static struct inode *afs_iget_pseudo_dir(struct super_block *sb, ino_t ino)
 
 	vnode = AFS_FS_I(inode);
 
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read_once(inode) & I_NEW) {
 		netfs_inode_init(&vnode->netfs, NULL, false);
 		simple_inode_init_ts(inode);
 		set_nlink(inode, 2);
@@ -258,7 +258,7 @@ static struct dentry *afs_lookup_atcell(struct inode *dir, struct dentry *dentry
 
 	vnode = AFS_FS_I(inode);
 
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read_once(inode) & I_NEW) {
 		netfs_inode_init(&vnode->netfs, NULL, false);
 		simple_inode_init_ts(inode);
 		set_nlink(inode, 1);
@@ -383,7 +383,7 @@ struct inode *afs_dynroot_iget_root(struct super_block *sb)
 	vnode = AFS_FS_I(inode);
 
 	/* there shouldn't be an existing inode */
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read_once(inode) & I_NEW) {
 		netfs_inode_init(&vnode->netfs, NULL, false);
 		simple_inode_init_ts(inode);
 		set_nlink(inode, 2);
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index e1cb17b85791..2fe2ccf59c7a 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -579,7 +579,7 @@ struct inode *afs_iget(struct afs_operation *op, struct afs_vnode_param *vp)
 	       inode, vnode->fid.vid, vnode->fid.vnode, vnode->fid.unique);
 
 	/* deal with an existing inode */
-	if (!(inode->i_state & I_NEW)) {
+	if (!(inode_state_read_once(inode) & I_NEW)) {
 		_leave(" = %p", inode);
 		return inode;
 	}
@@ -639,7 +639,7 @@ struct inode *afs_root_iget(struct super_block *sb, struct key *key)
 
 	_debug("GOT ROOT INODE %p { vl=%llx }", inode, as->volume->vid);
 
-	BUG_ON(!(inode->i_state & I_NEW));
+	BUG_ON(!(inode_state_read_once(inode) & I_NEW));
 
 	vnode = AFS_FS_I(inode);
 	vnode->cb_v_check = atomic_read(&as->volume->cb_v_break);
@@ -748,7 +748,7 @@ void afs_evict_inode(struct inode *inode)
 
 	if ((S_ISDIR(inode->i_mode) ||
 	     S_ISLNK(inode->i_mode)) &&
-	    (inode->i_state & I_DIRTY) &&
+	    (inode_state_read_once(inode) & I_DIRTY) &&
 	    !sbi->dyn_root) {
 		struct writeback_control wbc = {
 			.sync_mode = WB_SYNC_ALL,
diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index 8f430ff8e445..9fcfdd6b8189 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -307,7 +307,7 @@ static struct inode *befs_iget(struct super_block *sb, unsigned long ino)
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read_once(inode) & I_NEW))
 		return inode;
 
 	befs_ino = BEFS_I(inode);
diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
index 1d41ce477df5..cb406a6ee811 100644
--- a/fs/bfs/inode.c
+++ b/fs/bfs/inode.c
@@ -42,7 +42,7 @@ struct inode *bfs_iget(struct super_block *sb, unsigned long ino)
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read_once(inode) & I_NEW))
 		return inode;
 
 	if ((ino < BFS_ROOT_INO) || (ino > BFS_SB(inode->i_sb)->si_lasti)) {
diff --git a/fs/buffer.c b/fs/buffer.c
index 6a8752f7bbed..17b8ce567cc3 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -611,9 +611,9 @@ int generic_buffers_fsync_noflush(struct file *file, loff_t start, loff_t end,
 		return err;
 
 	ret = sync_mapping_buffers(inode->i_mapping);
-	if (!(inode->i_state & I_DIRTY_ALL))
+	if (!(inode_state_read_once(inode) & I_DIRTY_ALL))
 		goto out;
-	if (datasync && !(inode->i_state & I_DIRTY_DATASYNC))
+	if (datasync && !(inode_state_read_once(inode) & I_DIRTY_DATASYNC))
 		goto out;
 
 	err = sync_inode_metadata(inode, 1);
diff --git a/fs/coda/cnode.c b/fs/coda/cnode.c
index 62a3d2565c26..70bb0579b40c 100644
--- a/fs/coda/cnode.c
+++ b/fs/coda/cnode.c
@@ -70,7 +70,7 @@ struct inode * coda_iget(struct super_block * sb, struct CodaFid * fid,
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read_once(inode) & I_NEW) {
 		cii = ITOC(inode);
 		/* we still need to set i_ino for things like stat(2) */
 		inode->i_ino = hash;
@@ -148,7 +148,7 @@ struct inode *coda_fid_to_inode(struct CodaFid *fid, struct super_block *sb)
 
 	/* we should never see newly created inodes because we intentionally
 	 * fail in the initialization callback */
-	BUG_ON(inode->i_state & I_NEW);
+	BUG_ON(inode_state_read_once(inode) & I_NEW);
 
 	return inode;
 }
diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index ca54bf24b719..e54ebe402df7 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -95,7 +95,7 @@ static struct inode *get_cramfs_inode(struct super_block *sb,
 	inode = iget_locked(sb, cramino(cramfs_inode, offset));
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read_once(inode) & I_NEW))
 		return inode;
 
 	switch (cramfs_inode->mode & S_IFMT) {
diff --git a/fs/crypto/keyring.c b/fs/crypto/keyring.c
index 3adbd7167055..5e939ea3ac28 100644
--- a/fs/crypto/keyring.c
+++ b/fs/crypto/keyring.c
@@ -945,7 +945,7 @@ static void evict_dentries_for_decrypted_inodes(struct fscrypt_master_key *mk)
 	list_for_each_entry(ci, &mk->mk_decrypted_inodes, ci_master_key_link) {
 		inode = ci->ci_inode;
 		spin_lock(&inode->i_lock);
-		if (inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW)) {
+		if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index 4bd3918f50e3..40fa05688d3a 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -834,7 +834,7 @@ int fscrypt_drop_inode(struct inode *inode)
 	 * userspace is still using the files, inodes can be dirtied between
 	 * then and now.  We mustn't lose any writes, so skip dirty inodes here.
 	 */
-	if (inode->i_state & I_DIRTY_ALL)
+	if (inode_state_read(inode) & I_DIRTY_ALL)
 		return 0;
 
 	/*
diff --git a/fs/dcache.c b/fs/dcache.c
index 806d6a665124..78ffa7b7e824 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -794,7 +794,7 @@ void d_mark_dontcache(struct inode *inode)
 		de->d_flags |= DCACHE_DONTCACHE;
 		spin_unlock(&de->d_lock);
 	}
-	inode->i_state |= I_DONTCACHE;
+	inode_state_set(inode, I_DONTCACHE);
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
@@ -1980,12 +1980,12 @@ void d_instantiate_new(struct dentry *entry, struct inode *inode)
 	security_d_instantiate(entry, inode);
 	spin_lock(&inode->i_lock);
 	__d_instantiate(entry, inode);
-	WARN_ON(!(inode->i_state & I_NEW));
+	WARN_ON(!(inode_state_read(inode) & I_NEW));
 	/*
 	 * Pairs with smp_rmb in wait_on_inode().
 	 */
 	smp_wmb();
-	inode->i_state &= ~I_NEW & ~I_CREATING;
+	inode_state_clear(inode, I_NEW | I_CREATING);
 	/*
 	 * Pairs with the barrier in prepare_to_wait_event() to make sure
 	 * ___wait_var_event() either sees the bit cleared or
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
index ed1394da8d6b..f3c68ef0271f 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -95,7 +95,7 @@ static struct inode *__ecryptfs_get_inode(struct inode *lower_inode,
 		iput(lower_inode);
 		return ERR_PTR(-EACCES);
 	}
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read_once(inode) & I_NEW))
 		iput(lower_inode);
 
 	return inode;
@@ -106,7 +106,7 @@ struct inode *ecryptfs_get_inode(struct inode *lower_inode,
 {
 	struct inode *inode = __ecryptfs_get_inode(lower_inode, sb);
 
-	if (!IS_ERR(inode) && (inode->i_state & I_NEW))
+	if (!IS_ERR(inode) && (inode_state_read_once(inode) & I_NEW))
 		unlock_new_inode(inode);
 
 	return inode;
@@ -364,7 +364,7 @@ static struct dentry *ecryptfs_lookup_interpose(struct dentry *dentry,
 		}
 	}
 
-	if (inode->i_state & I_NEW)
+	if (inode_state_read_once(inode) & I_NEW)
 		unlock_new_inode(inode);
 	return d_splice_alias(inode, dentry);
 }
diff --git a/fs/efs/inode.c b/fs/efs/inode.c
index 462619e59766..28407578f83a 100644
--- a/fs/efs/inode.c
+++ b/fs/efs/inode.c
@@ -62,7 +62,7 @@ struct inode *efs_iget(struct super_block *super, unsigned long ino)
 	inode = iget_locked(super, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read_once(inode) & I_NEW))
 		return inode;
 
 	in = INODE_INFO(inode);
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index cb780c095d28..bce98c845a18 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -295,7 +295,7 @@ struct inode *erofs_iget(struct super_block *sb, erofs_nid_t nid)
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read_once(inode) & I_NEW) {
 		int err = erofs_fill_inode(inode);
 
 		if (err) {
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index e10c376843d7..dbfe9098a124 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1398,7 +1398,7 @@ struct inode *ext2_iget (struct super_block *sb, unsigned long ino)
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read_once(inode) & I_NEW))
 		return inode;
 
 	ei = EXT2_I(inode);
diff --git a/fs/freevxfs/vxfs_inode.c b/fs/freevxfs/vxfs_inode.c
index 20600e9ea202..21fc94b98209 100644
--- a/fs/freevxfs/vxfs_inode.c
+++ b/fs/freevxfs/vxfs_inode.c
@@ -258,7 +258,7 @@ vxfs_iget(struct super_block *sbp, ino_t ino)
 	ip = iget_locked(sbp, ino);
 	if (!ip)
 		return ERR_PTR(-ENOMEM);
-	if (!(ip->i_state & I_NEW))
+	if (!(inode_state_read_once(ip) & I_NEW))
 		return ip;
 
 	vip = VXFS_INO(ip);
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 9cda19a40ca2..f784d8b09b04 100644
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
+	inode_state_clear(inode, I_SYNC_QUEUED);
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
@@ -451,7 +451,7 @@ static bool inode_do_switch_wbs(struct inode *inode,
 	if (!list_empty(&inode->i_io_list)) {
 		inode->i_wb = new_wb;
 
-		if (inode->i_state & I_DIRTY_ALL) {
+		if (inode_state_read(inode) & I_DIRTY_ALL) {
 			/*
 			 * We need to keep b_dirty list sorted by
 			 * dirtied_time_when. However properly sorting the
@@ -480,7 +480,7 @@ static bool inode_do_switch_wbs(struct inode *inode,
 	 * ensures that the new wb is visible if they see !I_WB_SWITCH.
 	 */
 	smp_wmb();
-	inode->i_state &= ~I_WB_SWITCH;
+	inode_state_clear(inode, I_WB_SWITCH);
 
 	xa_unlock_irq(&mapping->i_pages);
 	spin_unlock(&inode->i_lock);
@@ -601,12 +601,12 @@ static bool inode_prepare_wbs_switch(struct inode *inode,
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
+	inode_state_set(inode, I_WB_SWITCH);
 	__iget(inode);
 	spin_unlock(&inode->i_lock);
 
@@ -636,7 +636,7 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
 	struct bdi_writeback *new_wb = NULL;
 
 	/* noop if seems to be already in progress */
-	if (inode->i_state & I_WB_SWITCH)
+	if (inode_state_read_once(inode) & I_WB_SWITCH)
 		return;
 
 	/* avoid queueing a new switch if too many are already in flight */
@@ -1237,9 +1237,9 @@ static void inode_cgwb_move_to_attached(struct inode *inode,
 {
 	assert_spin_locked(&wb->list_lock);
 	assert_spin_locked(&inode->i_lock);
-	WARN_ON_ONCE(inode->i_state & I_FREEING);
+	WARN_ON_ONCE(inode_state_read(inode) & I_FREEING);
 
-	inode->i_state &= ~I_SYNC_QUEUED;
+	inode_state_clear(inode, I_SYNC_QUEUED);
 	list_del_init(&inode->i_io_list);
 	wb_io_lists_depopulated(wb);
 }
@@ -1352,7 +1352,7 @@ void inode_io_list_del(struct inode *inode)
 	wb = inode_to_wb_and_lock_list(inode);
 	spin_lock(&inode->i_lock);
 
-	inode->i_state &= ~I_SYNC_QUEUED;
+	inode_state_clear(inode, I_SYNC_QUEUED);
 	list_del_init(&inode->i_io_list);
 	wb_io_lists_depopulated(wb);
 
@@ -1410,13 +1410,13 @@ static void redirty_tail_locked(struct inode *inode, struct bdi_writeback *wb)
 {
 	assert_spin_locked(&inode->i_lock);
 
-	inode->i_state &= ~I_SYNC_QUEUED;
+	inode_state_clear(inode, I_SYNC_QUEUED);
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
@@ -1450,7 +1450,7 @@ static void inode_sync_complete(struct inode *inode)
 {
 	assert_spin_locked(&inode->i_lock);
 
-	inode->i_state &= ~I_SYNC;
+	inode_state_clear(inode, I_SYNC);
 	/* If inode is clean an unused, put it into LRU now... */
 	inode_add_lru(inode);
 	/* Called with inode->i_lock which ensures memory ordering. */
@@ -1494,7 +1494,7 @@ static int move_expired_inodes(struct list_head *delaying_queue,
 		spin_lock(&inode->i_lock);
 		list_move(&inode->i_io_list, &tmp);
 		moved++;
-		inode->i_state |= I_SYNC_QUEUED;
+		inode_state_set(inode, I_SYNC_QUEUED);
 		spin_unlock(&inode->i_lock);
 		if (sb_is_blkdev_sb(inode->i_sb))
 			continue;
@@ -1580,14 +1580,14 @@ void inode_wait_for_writeback(struct inode *inode)
 
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
@@ -1613,7 +1613,7 @@ static void inode_sleep_on_writeback(struct inode *inode)
 	wq_head = inode_bit_waitqueue(&wqe, inode, __I_SYNC);
 	prepare_to_wait_event(wq_head, &wqe.wq_entry, TASK_UNINTERRUPTIBLE);
 	/* Checking I_SYNC with inode->i_lock guarantees memory ordering. */
-	sleep = !!(inode->i_state & I_SYNC);
+	sleep = !!(inode_state_read(inode) & I_SYNC);
 	spin_unlock(&inode->i_lock);
 	if (sleep)
 		schedule();
@@ -1632,7 +1632,7 @@ static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
 			  struct writeback_control *wbc,
 			  unsigned long dirtied_before)
 {
-	if (inode->i_state & I_FREEING)
+	if (inode_state_read(inode) & I_FREEING)
 		return;
 
 	/*
@@ -1640,7 +1640,7 @@ static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
 	 * shot. If still dirty, it will be redirty_tail()'ed below.  Update
 	 * the dirty time to prevent enqueue and sync it again.
 	 */
-	if ((inode->i_state & I_DIRTY) &&
+	if ((inode_state_read(inode) & I_DIRTY) &&
 	    (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages))
 		inode->dirtied_when = jiffies;
 
@@ -1651,7 +1651,7 @@ static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
 		 * is odd for clean inodes, it can happen for some
 		 * filesystems so handle that gracefully.
 		 */
-		if (inode->i_state & I_DIRTY_ALL)
+		if (inode_state_read(inode) & I_DIRTY_ALL)
 			redirty_tail_locked(inode, wb);
 		else
 			inode_cgwb_move_to_attached(inode, wb);
@@ -1677,17 +1677,17 @@ static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
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
+		inode_state_clear(inode, I_SYNC_QUEUED);
 	} else {
 		/* The inode is clean. Remove from writeback lists. */
 		inode_cgwb_move_to_attached(inode, wb);
@@ -1713,7 +1713,7 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
 	unsigned dirty;
 	int ret;
 
-	WARN_ON(!(inode->i_state & I_SYNC));
+	WARN_ON(!(inode_state_read_once(inode) & I_SYNC));
 
 	trace_writeback_single_inode_start(inode, wbc, nr_to_write);
 
@@ -1737,7 +1737,7 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
 	 * mark_inode_dirty_sync() to notify the filesystem about it and to
 	 * change I_DIRTY_TIME into I_DIRTY_SYNC.
 	 */
-	if ((inode->i_state & I_DIRTY_TIME) &&
+	if ((inode_state_read_once(inode) & I_DIRTY_TIME) &&
 	    (wbc->sync_mode == WB_SYNC_ALL ||
 	     time_after(jiffies, inode->dirtied_time_when +
 			dirtytime_expire_interval * HZ))) {
@@ -1752,8 +1752,8 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
 	 * after handling timestamp expiration, as that may dirty the inode too.
 	 */
 	spin_lock(&inode->i_lock);
-	dirty = inode->i_state & I_DIRTY;
-	inode->i_state &= ~dirty;
+	dirty = inode_state_read(inode) & I_DIRTY;
+	inode_state_clear(inode, dirty);
 
 	/*
 	 * Paired with smp_mb() in __mark_inode_dirty().  This allows
@@ -1769,10 +1769,10 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
 	smp_mb();
 
 	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
-		inode->i_state |= I_DIRTY_PAGES;
-	else if (unlikely(inode->i_state & I_PINNING_NETFS_WB)) {
-		if (!(inode->i_state & I_DIRTY_PAGES)) {
-			inode->i_state &= ~I_PINNING_NETFS_WB;
+		inode_state_set(inode, I_DIRTY_PAGES);
+	else if (unlikely(inode_state_read(inode) & I_PINNING_NETFS_WB)) {
+		if (!(inode_state_read(inode) & I_DIRTY_PAGES)) {
+			inode_state_clear(inode, I_PINNING_NETFS_WB);
 			wbc->unpinned_netfs_wb = true;
 			dirty |= I_PINNING_NETFS_WB; /* Cause write_inode */
 		}
@@ -1808,11 +1808,11 @@ static int writeback_single_inode(struct inode *inode,
 
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
@@ -1823,7 +1823,7 @@ static int writeback_single_inode(struct inode *inode,
 			goto out;
 		inode_wait_for_writeback(inode);
 	}
-	WARN_ON(inode->i_state & I_SYNC);
+	WARN_ON(inode_state_read(inode) & I_SYNC);
 	/*
 	 * If the inode is already fully clean, then there's nothing to do.
 	 *
@@ -1831,11 +1831,11 @@ static int writeback_single_inode(struct inode *inode,
 	 * still under writeback, e.g. due to prior WB_SYNC_NONE writeback.  If
 	 * there are any such pages, we'll need to wait for them.
 	 */
-	if (!(inode->i_state & I_DIRTY_ALL) &&
+	if (!(inode_state_read(inode) & I_DIRTY_ALL) &&
 	    (wbc->sync_mode != WB_SYNC_ALL ||
 	     !mapping_tagged(inode->i_mapping, PAGECACHE_TAG_WRITEBACK)))
 		goto out;
-	inode->i_state |= I_SYNC;
+	inode_state_set(inode, I_SYNC);
 	wbc_attach_and_unlock_inode(wbc, inode);
 
 	ret = __writeback_single_inode(inode, wbc);
@@ -1848,18 +1848,18 @@ static int writeback_single_inode(struct inode *inode,
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
@@ -1968,12 +1968,12 @@ static long writeback_sb_inodes(struct super_block *sb,
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
@@ -1995,14 +1995,14 @@ static long writeback_sb_inodes(struct super_block *sb,
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
+		inode_state_set(inode, I_SYNC);
 		wbc_attach_and_unlock_inode(&wbc, inode);
 
 		write_chunk = writeback_chunk_size(wb, work);
@@ -2040,7 +2040,7 @@ static long writeback_sb_inodes(struct super_block *sb,
 		 */
 		tmp_wb = inode_to_wb_and_lock_list(inode);
 		spin_lock(&inode->i_lock);
-		if (!(inode->i_state & I_DIRTY_ALL))
+		if (!(inode_state_read(inode) & I_DIRTY_ALL))
 			total_wrote++;
 		requeue_inode(inode, tmp_wb, &wbc, dirtied_before);
 		inode_sync_complete(inode);
@@ -2546,10 +2546,10 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 		 * We tell ->dirty_inode callback that timestamps need to
 		 * be updated by setting I_DIRTY_TIME in flags.
 		 */
-		if (inode->i_state & I_DIRTY_TIME) {
+		if (inode_state_read_once(inode) & I_DIRTY_TIME) {
 			spin_lock(&inode->i_lock);
-			if (inode->i_state & I_DIRTY_TIME) {
-				inode->i_state &= ~I_DIRTY_TIME;
+			if (inode_state_read(inode) & I_DIRTY_TIME) {
+				inode_state_clear(inode, I_DIRTY_TIME);
 				flags |= I_DIRTY_TIME;
 			}
 			spin_unlock(&inode->i_lock);
@@ -2586,16 +2586,16 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 	 */
 	smp_mb();
 
-	if ((inode->i_state & flags) == flags)
+	if ((inode_state_read_once(inode) & flags) == flags)
 		return;
 
 	spin_lock(&inode->i_lock);
-	if ((inode->i_state & flags) != flags) {
-		const int was_dirty = inode->i_state & I_DIRTY;
+	if ((inode_state_read(inode) & flags) != flags) {
+		const int was_dirty = inode_state_read(inode) & I_DIRTY;
 
 		inode_attach_wb(inode, NULL);
 
-		inode->i_state |= flags;
+		inode_state_set(inode, flags);
 
 		/*
 		 * Grab inode's wb early because it requires dropping i_lock and we
@@ -2614,7 +2614,7 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 		 * the inode it will place it on the appropriate superblock
 		 * list, based upon its state.
 		 */
-		if (inode->i_state & I_SYNC_QUEUED)
+		if (inode_state_read(inode) & I_SYNC_QUEUED)
 			goto out_unlock;
 
 		/*
@@ -2625,7 +2625,7 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 			if (inode_unhashed(inode))
 				goto out_unlock;
 		}
-		if (inode->i_state & I_FREEING)
+		if (inode_state_read(inode) & I_FREEING)
 			goto out_unlock;
 
 		/*
@@ -2640,7 +2640,7 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 			if (dirtytime)
 				inode->dirtied_time_when = jiffies;
 
-			if (inode->i_state & I_DIRTY)
+			if (inode_state_read(inode) & I_DIRTY)
 				dirty_list = &wb->b_dirty;
 			else
 				dirty_list = &wb->b_dirty_time;
@@ -2737,7 +2737,7 @@ static void wait_sb_inodes(struct super_block *sb)
 		spin_unlock_irq(&sb->s_inode_wblist_lock);
 
 		spin_lock(&inode->i_lock);
-		if (inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) {
+		if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) {
 			spin_unlock(&inode->i_lock);
 
 			spin_lock_irq(&sb->s_inode_wblist_lock);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index d1babf56f254..bbecd0e5855d 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -160,7 +160,7 @@ static void fuse_evict_inode(struct inode *inode)
 	struct fuse_inode *fi = get_fuse_inode(inode);
 
 	/* Will write inode on close/munmap and in all other dirtiers */
-	WARN_ON(inode->i_state & I_DIRTY_INODE);
+	WARN_ON(inode_state_read_once(inode) & I_DIRTY_INODE);
 
 	if (FUSE_IS_DAX(inode))
 		dax_break_layout_final(inode);
@@ -505,7 +505,7 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 	if (!inode)
 		return NULL;
 
-	if ((inode->i_state & I_NEW)) {
+	if ((inode_state_read_once(inode) & I_NEW)) {
 		inode->i_flags |= S_NOATIME;
 		if (!fc->writeback_cache || !S_ISREG(attr->mode))
 			inode->i_flags |= S_NOCMTIME;
diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
index 22e62fe7448b..54c20d01c342 100644
--- a/fs/hfs/btree.c
+++ b/fs/hfs/btree.c
@@ -42,7 +42,7 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id, btree_keycmp ke
 	tree->inode = iget_locked(sb, id);
 	if (!tree->inode)
 		goto free_tree;
-	BUG_ON(!(tree->inode->i_state & I_NEW));
+	BUG_ON(!(inode_state_read_once(tree->inode) & I_NEW));
 	{
 	struct hfs_mdb *mdb = HFS_SB(sb)->mdb;
 	HFS_I(tree->inode)->flags = 0;
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 9cd449913dc8..81ad93e6312f 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -412,7 +412,7 @@ struct inode *hfs_iget(struct super_block *sb, struct hfs_cat_key *key, hfs_cat_
 		return NULL;
 	}
 	inode = iget5_locked(sb, cnid, hfs_test_inode, hfs_read_inode, &data);
-	if (inode && (inode->i_state & I_NEW))
+	if (inode && (inode_state_read_once(inode) & I_NEW))
 		unlock_new_inode(inode);
 	return inode;
 }
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 16bc4abc67e0..54e85e25a259 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -65,7 +65,7 @@ struct inode *hfsplus_iget(struct super_block *sb, unsigned long ino)
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read_once(inode) & I_NEW))
 		return inode;
 
 	atomic_set(&HFSPLUS_I(inode)->opencnt, 0);
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 1e1acf5775ab..76b643f7d05c 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -581,7 +581,7 @@ static struct inode *hostfs_iget(struct super_block *sb, char *name)
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read_once(inode) & I_NEW) {
 		unlock_new_inode(inode);
 	} else {
 		spin_lock(&inode->i_lock);
diff --git a/fs/hpfs/dir.c b/fs/hpfs/dir.c
index 49dd585c2b17..ceb50b2dc91a 100644
--- a/fs/hpfs/dir.c
+++ b/fs/hpfs/dir.c
@@ -247,7 +247,7 @@ struct dentry *hpfs_lookup(struct inode *dir, struct dentry *dentry, unsigned in
 		result = ERR_PTR(-ENOMEM);
 		goto bail1;
 	}
-	if (result->i_state & I_NEW) {
+	if (inode_state_read_once(result) & I_NEW) {
 		hpfs_init_inode(result);
 		if (de->directory)
 			hpfs_read_inode(result);
diff --git a/fs/hpfs/inode.c b/fs/hpfs/inode.c
index 34008442ee26..93d528f4f4f2 100644
--- a/fs/hpfs/inode.c
+++ b/fs/hpfs/inode.c
@@ -196,7 +196,7 @@ void hpfs_write_inode(struct inode *i)
 	parent = iget_locked(i->i_sb, hpfs_inode->i_parent_dir);
 	if (parent) {
 		hpfs_inode->i_dirty = 0;
-		if (parent->i_state & I_NEW) {
+		if (inode_state_read_once(parent) & I_NEW) {
 			hpfs_init_inode(parent);
 			hpfs_read_inode(parent);
 			unlock_new_inode(parent);
diff --git a/fs/inode.c b/fs/inode.c
index 37fc7a72aba5..f094ed3e6f30 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -233,7 +233,7 @@ int inode_init_always_gfp(struct super_block *sb, struct inode *inode, gfp_t gfp
 	inode->i_sb = sb;
 	inode->i_blkbits = sb->s_blocksize_bits;
 	inode->i_flags = 0;
-	inode->i_state = 0;
+	inode_state_assign_raw(inode, 0);
 	atomic64_set(&inode->i_sequence, 0);
 	atomic_set(&inode->i_count, 1);
 	inode->i_op = &empty_iops;
@@ -471,7 +471,7 @@ EXPORT_SYMBOL(set_nlink);
 void inc_nlink(struct inode *inode)
 {
 	if (unlikely(inode->i_nlink == 0)) {
-		WARN_ON(!(inode->i_state & I_LINKABLE));
+		WARN_ON(!(inode_state_read_once(inode) & I_LINKABLE));
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
+		inode_state_set(inode, I_REFERENCED);
 }
 
 struct wait_queue_head *inode_bit_waitqueue(struct wait_bit_queue_entry *wqe,
@@ -577,15 +577,15 @@ static void inode_lru_list_del(struct inode *inode)
 static void inode_pin_lru_isolating(struct inode *inode)
 {
 	lockdep_assert_held(&inode->i_lock);
-	WARN_ON(inode->i_state & (I_LRU_ISOLATING | I_FREEING | I_WILL_FREE));
-	inode->i_state |= I_LRU_ISOLATING;
+	WARN_ON(inode_state_read(inode) & (I_LRU_ISOLATING | I_FREEING | I_WILL_FREE));
+	inode_state_set(inode, I_LRU_ISOLATING);
 }
 
 static void inode_unpin_lru_isolating(struct inode *inode)
 {
 	spin_lock(&inode->i_lock);
-	WARN_ON(!(inode->i_state & I_LRU_ISOLATING));
-	inode->i_state &= ~I_LRU_ISOLATING;
+	WARN_ON(!(inode_state_read(inode) & I_LRU_ISOLATING));
+	inode_state_clear(inode, I_LRU_ISOLATING);
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
+	BUG_ON(!(inode_state_read_once(inode) & I_FREEING));
+	BUG_ON(inode_state_read_once(inode) & I_CLEAR);
 	BUG_ON(!list_empty(&inode->i_wb_list));
 	/* don't need i_lock here, no concurrent mods to i_state */
-	inode->i_state = I_FREEING | I_CLEAR;
+	inode_state_assign_raw(inode, I_FREEING | I_CLEAR);
 }
 EXPORT_SYMBOL(clear_inode);
 
@@ -786,7 +786,7 @@ static void evict(struct inode *inode)
 {
 	const struct super_operations *op = inode->i_sb->s_op;
 
-	BUG_ON(!(inode->i_state & I_FREEING));
+	BUG_ON(!(inode_state_read_once(inode) & I_FREEING));
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
+		inode_state_set(inode, I_FREEING);
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
+		inode_state_clear(inode, I_REFERENCED);
 		spin_unlock(&inode->i_lock);
 		return LRU_ROTATE;
 	}
@@ -975,8 +975,8 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 		return LRU_RETRY;
 	}
 
-	WARN_ON(inode->i_state & I_NEW);
-	inode->i_state |= I_FREEING;
+	WARN_ON(inode_state_read(inode) & I_NEW);
+	inode_state_set(inode, I_FREEING);
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
@@ -1180,12 +1180,12 @@ void unlock_new_inode(struct inode *inode)
 {
 	lockdep_annotate_inode_mutex_key(inode);
 	spin_lock(&inode->i_lock);
-	WARN_ON(!(inode->i_state & I_NEW));
+	WARN_ON(!(inode_state_read(inode) & I_NEW));
 	/*
 	 * Pairs with smp_rmb in wait_on_inode().
 	 */
 	smp_wmb();
-	inode->i_state &= ~I_NEW & ~I_CREATING;
+	inode_state_clear(inode, I_NEW | I_CREATING);
 	/*
 	 * Pairs with the barrier in prepare_to_wait_event() to make sure
 	 * ___wait_var_event() either sees the bit cleared or
@@ -1201,12 +1201,12 @@ void discard_new_inode(struct inode *inode)
 {
 	lockdep_annotate_inode_mutex_key(inode);
 	spin_lock(&inode->i_lock);
-	WARN_ON(!(inode->i_state & I_NEW));
+	WARN_ON(!(inode_state_read(inode) & I_NEW));
 	/*
 	 * Pairs with smp_rmb in wait_on_inode().
 	 */
 	smp_wmb();
-	inode->i_state &= ~I_NEW;
+	inode_state_clear(inode, I_NEW);
 	/*
 	 * Pairs with the barrier in prepare_to_wait_event() to make sure
 	 * ___wait_var_event() either sees the bit cleared or
@@ -1318,7 +1318,7 @@ struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
 	 * caller is responsible for filling in the contents
 	 */
 	spin_lock(&inode->i_lock);
-	inode->i_state |= I_NEW;
+	inode_state_set(inode, I_NEW);
 	hlist_add_head_rcu(&inode->i_hash, head);
 	spin_unlock(&inode->i_lock);
 
@@ -1460,7 +1460,7 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
 		if (!old) {
 			inode->i_ino = ino;
 			spin_lock(&inode->i_lock);
-			inode->i_state = I_NEW;
+			inode_state_assign(inode, I_NEW);
 			hlist_add_head_rcu(&inode->i_hash, head);
 			spin_unlock(&inode->i_lock);
 			spin_unlock(&inode_hash_lock);
@@ -1553,7 +1553,7 @@ EXPORT_SYMBOL(iunique);
 struct inode *igrab(struct inode *inode)
 {
 	spin_lock(&inode->i_lock);
-	if (!(inode->i_state & (I_FREEING|I_WILL_FREE))) {
+	if (!(inode_state_read(inode) & (I_FREEING | I_WILL_FREE))) {
 		__iget(inode);
 		spin_unlock(&inode->i_lock);
 	} else {
@@ -1749,7 +1749,7 @@ struct inode *find_inode_rcu(struct super_block *sb, unsigned long hashval,
 
 	hlist_for_each_entry_rcu(inode, head, i_hash) {
 		if (inode->i_sb == sb &&
-		    !(READ_ONCE(inode->i_state) & (I_FREEING | I_WILL_FREE)) &&
+		    !(inode_state_read_once(inode) & (I_FREEING | I_WILL_FREE)) &&
 		    test(inode, data))
 			return inode;
 	}
@@ -1788,7 +1788,7 @@ struct inode *find_inode_by_ino_rcu(struct super_block *sb,
 	hlist_for_each_entry_rcu(inode, head, i_hash) {
 		if (inode->i_ino == ino &&
 		    inode->i_sb == sb &&
-		    !(READ_ONCE(inode->i_state) & (I_FREEING | I_WILL_FREE)))
+		    !(inode_state_read_once(inode) & (I_FREEING | I_WILL_FREE)))
 		    return inode;
 	}
 	return NULL;
@@ -1812,7 +1812,7 @@ int insert_inode_locked(struct inode *inode)
 			if (old->i_sb != sb)
 				continue;
 			spin_lock(&old->i_lock);
-			if (old->i_state & (I_FREEING|I_WILL_FREE)) {
+			if (inode_state_read(old) & (I_FREEING | I_WILL_FREE)) {
 				spin_unlock(&old->i_lock);
 				continue;
 			}
@@ -1820,13 +1820,13 @@ int insert_inode_locked(struct inode *inode)
 		}
 		if (likely(!old)) {
 			spin_lock(&inode->i_lock);
-			inode->i_state |= I_NEW | I_CREATING;
+			inode_state_set(inode, I_NEW | I_CREATING);
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
@@ -1851,7 +1851,7 @@ int insert_inode_locked4(struct inode *inode, unsigned long hashval,
 
 	might_sleep();
 
-	inode->i_state |= I_CREATING;
+	inode_state_set_raw(inode, I_CREATING);
 	old = inode_insert5(inode, hashval, test, NULL, data);
 
 	if (old != inode) {
@@ -1886,7 +1886,7 @@ static void iput_final(struct inode *inode)
 	unsigned long state;
 	int drop;
 
-	WARN_ON(inode->i_state & I_NEW);
+	WARN_ON(inode_state_read(inode) & I_NEW);
 	VFS_BUG_ON_INODE(atomic_read(&inode->i_count) != 0, inode);
 
 	if (op->drop_inode)
@@ -1895,7 +1895,7 @@ static void iput_final(struct inode *inode)
 		drop = inode_generic_drop(inode);
 
 	if (!drop &&
-	    !(inode->i_state & I_DONTCACHE) &&
+	    !(inode_state_read(inode) & I_DONTCACHE) &&
 	    (sb->s_flags & SB_ACTIVE)) {
 		__inode_add_lru(inode, true);
 		spin_unlock(&inode->i_lock);
@@ -1908,7 +1908,7 @@ static void iput_final(struct inode *inode)
 	 */
 	VFS_BUG_ON_INODE(atomic_read(&inode->i_count) != 0, inode);
 
-	state = inode->i_state;
+	state = inode_state_read(inode);
 	if (!drop) {
 		WRITE_ONCE(inode->i_state, state | I_WILL_FREE);
 		spin_unlock(&inode->i_lock);
@@ -1916,7 +1916,7 @@ static void iput_final(struct inode *inode)
 		write_inode_now(inode, 1);
 
 		spin_lock(&inode->i_lock);
-		state = inode->i_state;
+		state = inode_state_read(inode);
 		WARN_ON(state & I_NEW);
 		state &= ~I_WILL_FREE;
 	}
@@ -1946,7 +1946,7 @@ void iput(struct inode *inode)
 
 retry:
 	lockdep_assert_not_held(&inode->i_lock);
-	VFS_BUG_ON_INODE(inode->i_state & I_CLEAR, inode);
+	VFS_BUG_ON_INODE(inode_state_read_once(inode) & I_CLEAR, inode);
 	/*
 	 * Note this assert is technically racy as if the count is bogusly
 	 * equal to one, then two CPUs racing to further drop it can both
@@ -1957,14 +1957,14 @@ void iput(struct inode *inode)
 	if (atomic_add_unless(&inode->i_count, -1, 1))
 		return;
 
-	if ((inode->i_state & I_DIRTY_TIME) && inode->i_nlink) {
+	if ((inode_state_read_once(inode) & I_DIRTY_TIME) && inode->i_nlink) {
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
index 6f0e6b19383c..0d51f57f7ad7 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -1515,7 +1515,7 @@ struct inode *__isofs_iget(struct super_block *sb,
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read_once(inode) & I_NEW) {
 		ret = isofs_read_inode(inode, relocated);
 		if (ret < 0) {
 			iget_failed(inode);
diff --git a/fs/jffs2/fs.c b/fs/jffs2/fs.c
index d175cccb7c55..764bba8ba999 100644
--- a/fs/jffs2/fs.c
+++ b/fs/jffs2/fs.c
@@ -265,7 +265,7 @@ struct inode *jffs2_iget(struct super_block *sb, unsigned long ino)
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read_once(inode) & I_NEW))
 		return inode;
 
 	f = JFFS2_INODE_INFO(inode);
@@ -373,7 +373,7 @@ void jffs2_dirty_inode(struct inode *inode, int flags)
 {
 	struct iattr iattr;
 
-	if (!(inode->i_state & I_DIRTY_DATASYNC)) {
+	if (!(inode_state_read_once(inode) & I_DIRTY_DATASYNC)) {
 		jffs2_dbg(2, "%s(): not calling setattr() for ino #%lu\n",
 			  __func__, inode->i_ino);
 		return;
diff --git a/fs/jfs/file.c b/fs/jfs/file.c
index 2a4a288b821c..87ad042221e7 100644
--- a/fs/jfs/file.c
+++ b/fs/jfs/file.c
@@ -26,8 +26,8 @@ int jfs_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 		return rc;
 
 	inode_lock(inode);
-	if (!(inode->i_state & I_DIRTY_ALL) ||
-	    (datasync && !(inode->i_state & I_DIRTY_DATASYNC))) {
+	if (!(inode_state_read_once(inode) & I_DIRTY_ALL) ||
+	    (datasync && !(inode_state_read_once(inode) & I_DIRTY_DATASYNC))) {
 		/* Make sure committed changes hit the disk */
 		jfs_flush_journal(JFS_SBI(inode->i_sb)->log, 1);
 		inode_unlock(inode);
diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
index 21f3d029da7d..4709762713ef 100644
--- a/fs/jfs/inode.c
+++ b/fs/jfs/inode.c
@@ -29,7 +29,7 @@ struct inode *jfs_iget(struct super_block *sb, unsigned long ino)
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read_once(inode) & I_NEW))
 		return inode;
 
 	ret = diRead(inode);
diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
index 7840a03e5bcb..c16578af3a77 100644
--- a/fs/jfs/jfs_txnmgr.c
+++ b/fs/jfs/jfs_txnmgr.c
@@ -1287,7 +1287,7 @@ int txCommit(tid_t tid,		/* transaction identifier */
 		 * to verify this, only a trivial s/I_LOCK/I_SYNC/ was done.
 		 * Joern
 		 */
-		if (tblk->u.ip->i_state & I_SYNC)
+		if (inode_state_read_once(tblk->u.ip) & I_SYNC)
 			tblk->xflag &= ~COMMIT_LAZY;
 	}
 
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 457f91c412d4..a36aaee98dce 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -251,7 +251,7 @@ struct inode *kernfs_get_inode(struct super_block *sb, struct kernfs_node *kn)
 	struct inode *inode;
 
 	inode = iget_locked(sb, kernfs_ino(kn));
-	if (inode && (inode->i_state & I_NEW))
+	if (inode && (inode_state_read_once(inode) & I_NEW))
 		kernfs_init_inode(kn, inode);
 
 	return inode;
diff --git a/fs/libfs.c b/fs/libfs.c
index ce8c496a6940..96e3d7fc7fc6 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1542,9 +1542,9 @@ int __generic_file_fsync(struct file *file, loff_t start, loff_t end,
 
 	inode_lock(inode);
 	ret = sync_mapping_buffers(inode->i_mapping);
-	if (!(inode->i_state & I_DIRTY_ALL))
+	if (!(inode_state_read_once(inode) & I_DIRTY_ALL))
 		goto out;
-	if (datasync && !(inode->i_state & I_DIRTY_DATASYNC))
+	if (datasync && !(inode_state_read_once(inode) & I_DIRTY_DATASYNC))
 		goto out;
 
 	err = sync_inode_metadata(inode, 1);
@@ -1664,7 +1664,7 @@ struct inode *alloc_anon_inode(struct super_block *s)
 	 * list because mark_inode_dirty() will think
 	 * that it already _is_ on the dirty list.
 	 */
-	inode->i_state = I_DIRTY;
+	inode_state_assign_raw(inode, I_DIRTY);
 	/*
 	 * Historically anonymous inodes don't have a type at all and
 	 * userspace has come to rely on this.
diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index 32db676127a9..f220d0e4aedf 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -589,7 +589,7 @@ struct inode *minix_iget(struct super_block *sb, unsigned long ino)
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read_once(inode) & I_NEW))
 		return inode;
 
 	if (INODE_VERSION(inode) == MINIX_V1)
diff --git a/fs/namei.c b/fs/namei.c
index 7377020a2cba..354a9e844721 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4036,7 +4036,7 @@ int vfs_tmpfile(struct mnt_idmap *idmap,
 	inode = file_inode(file);
 	if (!(open_flag & O_EXCL)) {
 		spin_lock(&inode->i_lock);
-		inode->i_state |= I_LINKABLE;
+		inode_state_set(inode, I_LINKABLE);
 		spin_unlock(&inode->i_lock);
 	}
 	security_inode_post_create_tmpfile(idmap, inode);
@@ -4931,7 +4931,7 @@ int vfs_link(struct dentry *old_dentry, struct mnt_idmap *idmap,
 
 	inode_lock(inode);
 	/* Make sure we don't allow creating hardlink to an unlinked file */
-	if (inode->i_nlink == 0 && !(inode->i_state & I_LINKABLE))
+	if (inode->i_nlink == 0 && !(inode_state_read_once(inode) & I_LINKABLE))
 		error =  -ENOENT;
 	else if (max_links && inode->i_nlink >= max_links)
 		error = -EMLINK;
@@ -4941,9 +4941,9 @@ int vfs_link(struct dentry *old_dentry, struct mnt_idmap *idmap,
 			error = dir->i_op->link(old_dentry, dir, new_dentry);
 	}
 
-	if (!error && (inode->i_state & I_LINKABLE)) {
+	if (!error && (inode_state_read_once(inode) & I_LINKABLE)) {
 		spin_lock(&inode->i_lock);
-		inode->i_state &= ~I_LINKABLE;
+		inode_state_clear(inode, I_LINKABLE);
 		spin_unlock(&inode->i_lock);
 	}
 	inode_unlock(inode);
diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 486166460e17..3b97bc35de77 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -147,10 +147,10 @@ bool netfs_dirty_folio(struct address_space *mapping, struct folio *folio)
 	if (!fscache_cookie_valid(cookie))
 		return true;
 
-	if (!(inode->i_state & I_PINNING_NETFS_WB)) {
+	if (!(inode_state_read_once(inode) & I_PINNING_NETFS_WB)) {
 		spin_lock(&inode->i_lock);
-		if (!(inode->i_state & I_PINNING_NETFS_WB)) {
-			inode->i_state |= I_PINNING_NETFS_WB;
+		if (!(inode_state_read(inode) & I_PINNING_NETFS_WB)) {
+			inode_state_set(inode, I_PINNING_NETFS_WB);
 			need_use = true;
 		}
 		spin_unlock(&inode->i_lock);
@@ -192,7 +192,7 @@ void netfs_clear_inode_writeback(struct inode *inode, const void *aux)
 {
 	struct fscache_cookie *cookie = netfs_i_cookie(netfs_inode(inode));
 
-	if (inode->i_state & I_PINNING_NETFS_WB) {
+	if (inode_state_read_once(inode) & I_PINNING_NETFS_WB) {
 		loff_t i_size = i_size_read(inode);
 		fscache_unuse_cookie(cookie, aux, &i_size);
 	}
diff --git a/fs/netfs/read_single.c b/fs/netfs/read_single.c
index 5c0dc4efc792..8e6264f62a8f 100644
--- a/fs/netfs/read_single.c
+++ b/fs/netfs/read_single.c
@@ -36,12 +36,12 @@ void netfs_single_mark_inode_dirty(struct inode *inode)
 
 	mark_inode_dirty(inode);
 
-	if (caching && !(inode->i_state & I_PINNING_NETFS_WB)) {
+	if (caching && !(inode_state_read_once(inode) & I_PINNING_NETFS_WB)) {
 		bool need_use = false;
 
 		spin_lock(&inode->i_lock);
-		if (!(inode->i_state & I_PINNING_NETFS_WB)) {
-			inode->i_state |= I_PINNING_NETFS_WB;
+		if (!(inode_state_read(inode) & I_PINNING_NETFS_WB)) {
+			inode_state_set(inode, I_PINNING_NETFS_WB);
 			need_use = true;
 		}
 		spin_unlock(&inode->i_lock);
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 18b57c7c2f97..9e3b1f10ce80 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -475,7 +475,7 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 		goto out_no_inode;
 	}
 
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read_once(inode) & I_NEW) {
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
index 9cb20d4aeab1..cf4062ac092a 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1159,7 +1159,7 @@ static int wait_for_concurrent_writes(struct file *file)
 		dprintk("nfsd: write resume %d\n", task_pid_nr(current));
 	}
 
-	if (inode->i_state & I_DIRTY) {
+	if (inode_state_read_once(inode) & I_DIRTY) {
 		dprintk("nfsd: write sync %d\n", task_pid_nr(current));
 		err = vfs_fsync(file, 0);
 	}
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
index 3959f23c487a..08266adc42ba 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -537,7 +537,7 @@ struct inode *ntfs_iget5(struct super_block *sb, const struct MFT_REF *ref,
 		return ERR_PTR(-ENOMEM);
 
 	/* If this is a freshly allocated inode, need to read it now. */
-	if (inode->i_state & I_NEW)
+	if (inode_state_read_once(inode) & I_NEW)
 		inode = ntfs_read_mft(inode, name, ref);
 	else if (ref->seq != ntfs_i(inode)->mi.mrec->seq) {
 		/*
diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
index 92a6149da9c1..619ff03b15d6 100644
--- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -2487,7 +2487,7 @@ int ocfs2_inode_lock_full_nested(struct inode *inode,
 	 * which hasn't been populated yet, so clear the refresh flag
 	 * and let the caller handle it.
 	 */
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read_once(inode) & I_NEW) {
 		status = 0;
 		if (lockres)
 			ocfs2_complete_lock_res_refresh(lockres, 0);
diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index 84115bf8b464..78f81950c9ee 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -152,8 +152,8 @@ struct inode *ocfs2_iget(struct ocfs2_super *osb, u64 blkno, unsigned flags,
 		mlog_errno(PTR_ERR(inode));
 		goto bail;
 	}
-	trace_ocfs2_iget5_locked(inode->i_state);
-	if (inode->i_state & I_NEW) {
+	trace_ocfs2_iget5_locked(inode_state_read_once(inode));
+	if (inode_state_read_once(inode) & I_NEW) {
 		rc = ocfs2_read_locked_inode(inode, &args);
 		unlock_new_inode(inode);
 	}
diff --git a/fs/omfs/inode.c b/fs/omfs/inode.c
index 135c49c5d848..db80af312678 100644
--- a/fs/omfs/inode.c
+++ b/fs/omfs/inode.c
@@ -212,7 +212,7 @@ struct inode *omfs_iget(struct super_block *sb, ino_t ino)
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read_once(inode) & I_NEW))
 		return inode;
 
 	bh = omfs_bread(inode->i_sb, ino);
diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
index 26ecda0e4d19..fb8d84bdedfb 100644
--- a/fs/openpromfs/inode.c
+++ b/fs/openpromfs/inode.c
@@ -236,7 +236,7 @@ static struct dentry *openpromfs_lookup(struct inode *dir, struct dentry *dentry
 	mutex_unlock(&op_mutex);
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read_once(inode) & I_NEW) {
 		simple_inode_init_ts(inode);
 		ent_oi = OP_I(inode);
 		ent_oi->type = ent_type;
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index a01400cd41fd..1eb4fbe35a46 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -1041,7 +1041,7 @@ struct inode *orangefs_iget(struct super_block *sb,
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read_once(inode) & I_NEW))
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
diff --git a/fs/pipe.c b/fs/pipe.c
index 42fead1efe52..2d0fed2ecbfd 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -908,7 +908,7 @@ static struct inode * get_pipe_inode(void)
 	 * list because "mark_inode_dirty()" will think
 	 * that it already _is_ on the dirty list.
 	 */
-	inode->i_state = I_DIRTY;
+	inode_state_assign_raw(inode, I_DIRTY);
 	inode->i_mode = S_IFIFO | S_IRUSR | S_IWUSR;
 	inode->i_uid = current_fsuid();
 	inode->i_gid = current_fsgid();
diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
index e399e2dd3a12..31d78da203ea 100644
--- a/fs/qnx4/inode.c
+++ b/fs/qnx4/inode.c
@@ -290,7 +290,7 @@ struct inode *qnx4_iget(struct super_block *sb, unsigned long ino)
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read_once(inode) & I_NEW))
 		return inode;
 
 	qnx4_inode = qnx4_raw_inode(inode);
diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index 3310d1ad4d0e..88d285005083 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -521,7 +521,7 @@ struct inode *qnx6_iget(struct super_block *sb, unsigned ino)
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read_once(inode) & I_NEW))
 		return inode;
 
 	ei = QNX6_I(inode);
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 6c4a6ee1fa2b..376739f6420e 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -1033,7 +1033,7 @@ static int add_dquot_ref(struct super_block *sb, int type)
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		spin_lock(&inode->i_lock);
-		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) ||
+		if ((inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) ||
 		    !atomic_read(&inode->i_writecount) ||
 		    !dqinit_needed(inode, type)) {
 			spin_unlock(&inode->i_lock);
diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index 0addcc849ff2..360b00854115 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -302,7 +302,7 @@ static struct inode *romfs_iget(struct super_block *sb, unsigned long pos)
 	if (!i)
 		return ERR_PTR(-ENOMEM);
 
-	if (!(i->i_state & I_NEW))
+	if (!(inode_state_read_once(i) & I_NEW))
 		return i;
 
 	/* precalculate the data offset */
diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index cceae3b78698..82b687414e65 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -86,7 +86,7 @@ struct inode *squashfs_iget(struct super_block *sb, long long ino,
 
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read_once(inode) & I_NEW))
 		return inode;
 
 	err = squashfs_read_inode(inode, ino);
diff --git a/fs/sync.c b/fs/sync.c
index 2955cd4c77a3..73b3efb35b26 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -182,7 +182,7 @@ int vfs_fsync_range(struct file *file, loff_t start, loff_t end, int datasync)
 
 	if (!file->f_op->fsync)
 		return -EINVAL;
-	if (!datasync && (inode->i_state & I_DIRTY_TIME))
+	if (!datasync && (inode_state_read_once(inode) & I_DIRTY_TIME))
 		mark_inode_dirty_sync(inode);
 	return file->f_op->fsync(file, start, end, datasync);
 }
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index ca41ce8208c4..c3265b8804f5 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1323,7 +1323,7 @@ int ubifs_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	inode_lock(inode);
 
 	/* Synchronize the inode unless this is a 'datasync()' call. */
-	if (!datasync || (inode->i_state & I_DIRTY_DATASYNC)) {
+	if (!datasync || (inode_state_read_once(inode) & I_DIRTY_DATASYNC)) {
 		err = inode->i_sb->s_op->write_inode(inode, NULL);
 		if (err)
 			goto out;
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 46952a33c4e6..f453c37cee37 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -114,7 +114,7 @@ struct inode *ubifs_iget(struct super_block *sb, unsigned long inum)
 	inode = iget_locked(sb, inum);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read_once(inode) & I_NEW))
 		return inode;
 	ui = ubifs_inode(inode);
 
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index a79d73f28aa7..7fae8002344a 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -1962,7 +1962,7 @@ struct inode *__udf_iget(struct super_block *sb, struct kernel_lb_addr *ino,
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	if (!(inode->i_state & I_NEW)) {
+	if (!(inode_state_read_once(inode) & I_NEW)) {
 		if (UDF_I(inode)->i_hidden != hidden_inode) {
 			iput(inode);
 			return ERR_PTR(-EFSCORRUPTED);
diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index 8361c00e8fa6..e2b0a35de2a7 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -655,7 +655,7 @@ struct inode *ufs_iget(struct super_block *sb, unsigned long ino)
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read_once(inode) & I_NEW))
 		return inode;
 
 	ufsi = UFS_I(inode);
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 70be0b3dda49..086a31269198 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -644,7 +644,7 @@ static struct inode *zonefs_get_file_inode(struct inode *dir,
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW)) {
+	if (!(inode_state_read_once(inode) & I_NEW)) {
 		WARN_ON_ONCE(inode->i_private != z);
 		return inode;
 	}
@@ -683,7 +683,7 @@ static struct inode *zonefs_get_zgroup_inode(struct super_block *sb,
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read_once(inode) & I_NEW))
 		return inode;
 
 	inode->i_ino = ino;
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 41b6c9386b69..c5740c6d37a2 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -72,7 +72,7 @@ static void collect_wb_stats(struct wb_stats *stats,
 	list_for_each_entry(inode, &wb->b_more_io, i_io_list)
 		stats->nr_more_io++;
 	list_for_each_entry(inode, &wb->b_dirty_time, i_io_list)
-		if (inode->i_state & I_DIRTY_TIME)
+		if (inode_state_read_once(inode) & I_DIRTY_TIME)
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
2.34.1


