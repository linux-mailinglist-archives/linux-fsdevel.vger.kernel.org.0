Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021A047A65F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Dec 2021 09:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhLTI6C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Dec 2021 03:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbhLTI6B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Dec 2021 03:58:01 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B060CC06173E
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Dec 2021 00:58:01 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso12254516pji.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Dec 2021 00:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vD/XD5zs81BT+CjH0NqpZ+UnGzDTxHP4VtRYZAvnSN8=;
        b=kshEEqyVGKl6EkyvLHqKuxAzBWTv6EeltHpptWv8PFHjeSBcV4XrJV2+MvKEioPIlJ
         YlPGzf7ecJOqsJc4Hene8O6TpoxWlAhljdE6oZb0FxRfqSihBPyMOXB0kB1FaPzMgCuK
         RFH7XaPXW96ruTZXYKV+pZoYtk5fJLT3I6R0cVrTUSBdei9xkU0f0rwLLB+bjaiIkld/
         tCnd7WLBVNs9gg01DEL8BPtXgX24sUbTv2/hlPN7zdOGhun3uWH4OUAVdx1OTqcvKoB6
         JpU7/GH9l7GLmTkaVarY6LrE39SZRGVUZxwwJkOSZYf8bzpAghn5ER0qdrqG7YK0cFSI
         x+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vD/XD5zs81BT+CjH0NqpZ+UnGzDTxHP4VtRYZAvnSN8=;
        b=rQNDWg9VLmSLNe7J2sKsrKk94ZJ7NlL0R0eCmh85gG7d7wNa0qsl5yvjkCRXQujCjU
         a9Wcs0tHt/pjBoi/JsDShf77kvino7v1ZQ6BvXWM0NNX24uMyGYCwvC+6+lFMLF4JHDT
         W1zfKsMqaNZdIq72t1n6RsiPkmb6BLx1ty5vCj6BRJpu9PCELSLg16KG7sHOks+5AsDG
         I8ztGXXWsj0PjLZzhNa81cvkoXm0NTi44VFudWW1YAtd87zqKIUejlY7SlUTs9LcepuE
         kzb7magY9Kl6YcgXuZ1wv7itTx210Ndb5/37a0lHTcz0RO/Q1FW3DmyU5uLd2V4cJKeN
         uGGw==
X-Gm-Message-State: AOAM5330L9qmYGPuxQMRefJu3kUPiwy3Czm4pu2w1OkGaTpytf4wd5Lb
        fS9kWyL7oS52PsuH346FTtYGeA==
X-Google-Smtp-Source: ABdhPJyCvIhjc+Ne46p3Z11l1TRhECyYfuLNx20UmUoRajl6ZFki2zYKXrIKGnhLZxmSTO1s2ZgUhg==
X-Received: by 2002:a17:902:8f8d:b0:148:a2e8:2c32 with SMTP id z13-20020a1709028f8d00b00148a2e82c32mr15688377plo.129.1639990680981;
        Mon, 20 Dec 2021 00:58:00 -0800 (PST)
Received: from localhost.localdomain ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id m11sm18441647pfk.27.2021.12.20.00.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 00:58:00 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        jaegeuk@kernel.org, chao@kernel.org, kari.argillander@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH v5 04/16] fs: allocate inode by using alloc_inode_sb()
Date:   Mon, 20 Dec 2021 16:56:37 +0800
Message-Id: <20211220085649.8196-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20211220085649.8196-1-songmuchun@bytedance.com>
References: <20211220085649.8196-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The inode allocation is supposed to use alloc_inode_sb(), so convert
kmem_cache_alloc() of all filesystems to alloc_inode_sb().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Theodore Ts'o <tytso@mit.edu>		[ext4]
---
 block/bdev.c             | 2 +-
 drivers/dax/super.c      | 2 +-
 fs/9p/vfs_inode.c        | 2 +-
 fs/adfs/super.c          | 2 +-
 fs/affs/super.c          | 2 +-
 fs/afs/super.c           | 2 +-
 fs/befs/linuxvfs.c       | 2 +-
 fs/bfs/inode.c           | 2 +-
 fs/btrfs/inode.c         | 2 +-
 fs/ceph/inode.c          | 2 +-
 fs/cifs/cifsfs.c         | 2 +-
 fs/coda/inode.c          | 2 +-
 fs/ecryptfs/super.c      | 2 +-
 fs/efs/super.c           | 2 +-
 fs/erofs/super.c         | 2 +-
 fs/exfat/super.c         | 2 +-
 fs/ext2/super.c          | 2 +-
 fs/ext4/super.c          | 2 +-
 fs/fat/inode.c           | 2 +-
 fs/freevxfs/vxfs_super.c | 2 +-
 fs/fuse/inode.c          | 2 +-
 fs/gfs2/super.c          | 2 +-
 fs/hfs/super.c           | 2 +-
 fs/hfsplus/super.c       | 2 +-
 fs/hostfs/hostfs_kern.c  | 2 +-
 fs/hpfs/super.c          | 2 +-
 fs/hugetlbfs/inode.c     | 2 +-
 fs/isofs/inode.c         | 2 +-
 fs/jffs2/super.c         | 2 +-
 fs/jfs/super.c           | 2 +-
 fs/minix/inode.c         | 2 +-
 fs/nfs/inode.c           | 2 +-
 fs/nilfs2/super.c        | 2 +-
 fs/ntfs/inode.c          | 2 +-
 fs/ntfs3/super.c         | 2 +-
 fs/ocfs2/dlmfs/dlmfs.c   | 2 +-
 fs/ocfs2/super.c         | 2 +-
 fs/openpromfs/inode.c    | 2 +-
 fs/orangefs/super.c      | 2 +-
 fs/overlayfs/super.c     | 2 +-
 fs/proc/inode.c          | 2 +-
 fs/qnx4/inode.c          | 2 +-
 fs/qnx6/inode.c          | 2 +-
 fs/reiserfs/super.c      | 2 +-
 fs/romfs/super.c         | 2 +-
 fs/squashfs/super.c      | 2 +-
 fs/sysv/inode.c          | 2 +-
 fs/ubifs/super.c         | 2 +-
 fs/udf/super.c           | 2 +-
 fs/ufs/super.c           | 2 +-
 fs/vboxsf/super.c        | 2 +-
 fs/xfs/xfs_icache.c      | 2 +-
 fs/zonefs/super.c        | 2 +-
 ipc/mqueue.c             | 2 +-
 mm/shmem.c               | 2 +-
 net/socket.c             | 2 +-
 net/sunrpc/rpc_pipe.c    | 2 +-
 57 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index b1d087e5e205..32c42b47c0e9 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -390,7 +390,7 @@ static struct kmem_cache * bdev_cachep __read_mostly;
 
 static struct inode *bdev_alloc_inode(struct super_block *sb)
 {
-	struct bdev_inode *ei = kmem_cache_alloc(bdev_cachep, GFP_KERNEL);
+	struct bdev_inode *ei = alloc_inode_sb(sb, bdev_cachep, GFP_KERNEL);
 
 	if (!ei)
 		return NULL;
diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index b882cf8106ea..15275c438a4e 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -383,7 +383,7 @@ static struct inode *dax_alloc_inode(struct super_block *sb)
 	struct dax_device *dax_dev;
 	struct inode *inode;
 
-	dax_dev = kmem_cache_alloc(dax_cache, GFP_KERNEL);
+	dax_dev = alloc_inode_sb(sb, dax_cache, GFP_KERNEL);
 	if (!dax_dev)
 		return NULL;
 
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 328c338ff304..1c5d8c56d94f 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -228,7 +228,7 @@ struct inode *v9fs_alloc_inode(struct super_block *sb)
 {
 	struct v9fs_inode *v9inode;
 
-	v9inode = kmem_cache_alloc(v9fs_inode_cache, GFP_KERNEL);
+	v9inode = alloc_inode_sb(sb, v9fs_inode_cache, GFP_KERNEL);
 	if (!v9inode)
 		return NULL;
 #ifdef CONFIG_9P_FSCACHE
diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index bdbd26e571ed..e8bfc38239cd 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -220,7 +220,7 @@ static struct kmem_cache *adfs_inode_cachep;
 static struct inode *adfs_alloc_inode(struct super_block *sb)
 {
 	struct adfs_inode_info *ei;
-	ei = kmem_cache_alloc(adfs_inode_cachep, GFP_KERNEL);
+	ei = alloc_inode_sb(sb, adfs_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	return &ei->vfs_inode;
diff --git a/fs/affs/super.c b/fs/affs/super.c
index c609005a9eaa..4c5f30a83336 100644
--- a/fs/affs/super.c
+++ b/fs/affs/super.c
@@ -100,7 +100,7 @@ static struct inode *affs_alloc_inode(struct super_block *sb)
 {
 	struct affs_inode_info *i;
 
-	i = kmem_cache_alloc(affs_inode_cachep, GFP_KERNEL);
+	i = alloc_inode_sb(sb, affs_inode_cachep, GFP_KERNEL);
 	if (!i)
 		return NULL;
 
diff --git a/fs/afs/super.c b/fs/afs/super.c
index d110def8aa8e..92cb145e1c65 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -677,7 +677,7 @@ static struct inode *afs_alloc_inode(struct super_block *sb)
 {
 	struct afs_vnode *vnode;
 
-	vnode = kmem_cache_alloc(afs_inode_cachep, GFP_KERNEL);
+	vnode = alloc_inode_sb(sb, afs_inode_cachep, GFP_KERNEL);
 	if (!vnode)
 		return NULL;
 
diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index c1ba13d19024..b4b3567ac655 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -277,7 +277,7 @@ befs_alloc_inode(struct super_block *sb)
 {
 	struct befs_inode_info *bi;
 
-	bi = kmem_cache_alloc(befs_inode_cachep, GFP_KERNEL);
+	bi = alloc_inode_sb(sb, befs_inode_cachep, GFP_KERNEL);
 	if (!bi)
 		return NULL;
 	return &bi->vfs_inode;
diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
index fd691e4815c5..1926bec2c850 100644
--- a/fs/bfs/inode.c
+++ b/fs/bfs/inode.c
@@ -239,7 +239,7 @@ static struct kmem_cache *bfs_inode_cachep;
 static struct inode *bfs_alloc_inode(struct super_block *sb)
 {
 	struct bfs_inode_info *bi;
-	bi = kmem_cache_alloc(bfs_inode_cachep, GFP_KERNEL);
+	bi = alloc_inode_sb(sb, bfs_inode_cachep, GFP_KERNEL);
 	if (!bi)
 		return NULL;
 	return &bi->vfs_inode;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b8c911a4a320..b8fb50c58e6b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9085,7 +9085,7 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	struct btrfs_inode *ei;
 	struct inode *inode;
 
-	ei = kmem_cache_alloc(btrfs_inode_cachep, GFP_KERNEL);
+	ei = alloc_inode_sb(sb, btrfs_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index e3322fcb2e8d..9cab86ef94ed 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -447,7 +447,7 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
 	struct ceph_inode_info *ci;
 	int i;
 
-	ci = kmem_cache_alloc(ceph_inode_cachep, GFP_NOFS);
+	ci = alloc_inode_sb(sb, ceph_inode_cachep, GFP_NOFS);
 	if (!ci)
 		return NULL;
 
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index dca42aa87d30..e39b760eb9c2 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -353,7 +353,7 @@ static struct inode *
 cifs_alloc_inode(struct super_block *sb)
 {
 	struct cifsInodeInfo *cifs_inode;
-	cifs_inode = kmem_cache_alloc(cifs_inode_cachep, GFP_KERNEL);
+	cifs_inode = alloc_inode_sb(sb, cifs_inode_cachep, GFP_KERNEL);
 	if (!cifs_inode)
 		return NULL;
 	cifs_inode->cifsAttrs = 0x20;	/* default */
diff --git a/fs/coda/inode.c b/fs/coda/inode.c
index d9f1bd7153df..2185328b65c7 100644
--- a/fs/coda/inode.c
+++ b/fs/coda/inode.c
@@ -43,7 +43,7 @@ static struct kmem_cache * coda_inode_cachep;
 static struct inode *coda_alloc_inode(struct super_block *sb)
 {
 	struct coda_inode_info *ei;
-	ei = kmem_cache_alloc(coda_inode_cachep, GFP_KERNEL);
+	ei = alloc_inode_sb(sb, coda_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	memset(&ei->c_fid, 0, sizeof(struct CodaFid));
diff --git a/fs/ecryptfs/super.c b/fs/ecryptfs/super.c
index 39116af0390f..0b1c878317ab 100644
--- a/fs/ecryptfs/super.c
+++ b/fs/ecryptfs/super.c
@@ -38,7 +38,7 @@ static struct inode *ecryptfs_alloc_inode(struct super_block *sb)
 	struct ecryptfs_inode_info *inode_info;
 	struct inode *inode = NULL;
 
-	inode_info = kmem_cache_alloc(ecryptfs_inode_info_cache, GFP_KERNEL);
+	inode_info = alloc_inode_sb(sb, ecryptfs_inode_info_cache, GFP_KERNEL);
 	if (unlikely(!inode_info))
 		goto out;
 	if (ecryptfs_init_crypt_stat(&inode_info->crypt_stat)) {
diff --git a/fs/efs/super.c b/fs/efs/super.c
index 62b155b9366b..b287f47c165b 100644
--- a/fs/efs/super.c
+++ b/fs/efs/super.c
@@ -69,7 +69,7 @@ static struct kmem_cache * efs_inode_cachep;
 static struct inode *efs_alloc_inode(struct super_block *sb)
 {
 	struct efs_inode_info *ei;
-	ei = kmem_cache_alloc(efs_inode_cachep, GFP_KERNEL);
+	ei = alloc_inode_sb(sb, efs_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	return &ei->vfs_inode;
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 6a969b1e0ee6..d3de5674ab81 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -83,7 +83,7 @@ static void erofs_inode_init_once(void *ptr)
 static struct inode *erofs_alloc_inode(struct super_block *sb)
 {
 	struct erofs_inode *vi =
-		kmem_cache_alloc(erofs_inode_cachep, GFP_KERNEL);
+		alloc_inode_sb(sb, erofs_inode_cachep, GFP_KERNEL);
 
 	if (!vi)
 		return NULL;
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 5539ffc20d16..1b24c9f61be1 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -182,7 +182,7 @@ static struct inode *exfat_alloc_inode(struct super_block *sb)
 {
 	struct exfat_inode_info *ei;
 
-	ei = kmem_cache_alloc(exfat_inode_cachep, GFP_NOFS);
+	ei = alloc_inode_sb(sb, exfat_inode_cachep, GFP_NOFS);
 	if (!ei)
 		return NULL;
 
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index d8d580b609ba..8deb03ae4742 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -180,7 +180,7 @@ static struct kmem_cache * ext2_inode_cachep;
 static struct inode *ext2_alloc_inode(struct super_block *sb)
 {
 	struct ext2_inode_info *ei;
-	ei = kmem_cache_alloc(ext2_inode_cachep, GFP_KERNEL);
+	ei = alloc_inode_sb(sb, ext2_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	ei->i_block_alloc_info = NULL;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 4e33b5eca694..19c16d9b173d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1292,7 +1292,7 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
 {
 	struct ext4_inode_info *ei;
 
-	ei = kmem_cache_alloc(ext4_inode_cachep, GFP_NOFS);
+	ei = alloc_inode_sb(sb, ext4_inode_cachep, GFP_NOFS);
 	if (!ei)
 		return NULL;
 
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index a6f1c6d426d1..38796681cc86 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -745,7 +745,7 @@ static struct kmem_cache *fat_inode_cachep;
 static struct inode *fat_alloc_inode(struct super_block *sb)
 {
 	struct msdos_inode_info *ei;
-	ei = kmem_cache_alloc(fat_inode_cachep, GFP_NOFS);
+	ei = alloc_inode_sb(sb, fat_inode_cachep, GFP_NOFS);
 	if (!ei)
 		return NULL;
 
diff --git a/fs/freevxfs/vxfs_super.c b/fs/freevxfs/vxfs_super.c
index 578a5062706e..22eed5a73ac2 100644
--- a/fs/freevxfs/vxfs_super.c
+++ b/fs/freevxfs/vxfs_super.c
@@ -124,7 +124,7 @@ static struct inode *vxfs_alloc_inode(struct super_block *sb)
 {
 	struct vxfs_inode_info *vi;
 
-	vi = kmem_cache_alloc(vxfs_inode_cachep, GFP_KERNEL);
+	vi = alloc_inode_sb(sb, vxfs_inode_cachep, GFP_KERNEL);
 	if (!vi)
 		return NULL;
 	inode_init_once(&vi->vfs_inode);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 8b89e3ba7df3..6497603fd69c 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -73,7 +73,7 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
 {
 	struct fuse_inode *fi;
 
-	fi = kmem_cache_alloc(fuse_inode_cachep, GFP_KERNEL);
+	fi = alloc_inode_sb(sb, fuse_inode_cachep, GFP_KERNEL);
 	if (!fi)
 		return NULL;
 
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 0f93e8beca4d..55440fb51df9 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1427,7 +1427,7 @@ static struct inode *gfs2_alloc_inode(struct super_block *sb)
 {
 	struct gfs2_inode *ip;
 
-	ip = kmem_cache_alloc(gfs2_inode_cachep, GFP_KERNEL);
+	ip = alloc_inode_sb(sb, gfs2_inode_cachep, GFP_KERNEL);
 	if (!ip)
 		return NULL;
 	ip->i_flags = 0;
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index 12d9bae39363..6764afa98a6f 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -162,7 +162,7 @@ static struct inode *hfs_alloc_inode(struct super_block *sb)
 {
 	struct hfs_inode_info *i;
 
-	i = kmem_cache_alloc(hfs_inode_cachep, GFP_KERNEL);
+	i = alloc_inode_sb(sb, hfs_inode_cachep, GFP_KERNEL);
 	return i ? &i->vfs_inode : NULL;
 }
 
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index b9e3db3f855f..8479add998b5 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -624,7 +624,7 @@ static struct inode *hfsplus_alloc_inode(struct super_block *sb)
 {
 	struct hfsplus_inode_info *i;
 
-	i = kmem_cache_alloc(hfsplus_inode_cachep, GFP_KERNEL);
+	i = alloc_inode_sb(sb, hfsplus_inode_cachep, GFP_KERNEL);
 	return i ? &i->vfs_inode : NULL;
 }
 
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index d5c9d886cd9f..2123d2bed55b 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -222,7 +222,7 @@ static struct inode *hostfs_alloc_inode(struct super_block *sb)
 {
 	struct hostfs_inode_info *hi;
 
-	hi = kmem_cache_alloc(hostfs_inode_cache, GFP_KERNEL_ACCOUNT);
+	hi = alloc_inode_sb(sb, hostfs_inode_cache, GFP_KERNEL_ACCOUNT);
 	if (hi == NULL)
 		return NULL;
 	hi->fd = -1;
diff --git a/fs/hpfs/super.c b/fs/hpfs/super.c
index a7dbfc892022..1cb89595b875 100644
--- a/fs/hpfs/super.c
+++ b/fs/hpfs/super.c
@@ -232,7 +232,7 @@ static struct kmem_cache * hpfs_inode_cachep;
 static struct inode *hpfs_alloc_inode(struct super_block *sb)
 {
 	struct hpfs_inode_info *ei;
-	ei = kmem_cache_alloc(hpfs_inode_cachep, GFP_NOFS);
+	ei = alloc_inode_sb(sb, hpfs_inode_cachep, GFP_NOFS);
 	if (!ei)
 		return NULL;
 	return &ei->vfs_inode;
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 49d2e686be74..7e0bd1c629e1 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1109,7 +1109,7 @@ static struct inode *hugetlbfs_alloc_inode(struct super_block *sb)
 
 	if (unlikely(!hugetlbfs_dec_free_inodes(sbinfo)))
 		return NULL;
-	p = kmem_cache_alloc(hugetlbfs_inode_cachep, GFP_KERNEL);
+	p = alloc_inode_sb(sb, hugetlbfs_inode_cachep, GFP_KERNEL);
 	if (unlikely(!p)) {
 		hugetlbfs_inc_free_inodes(sbinfo);
 		return NULL;
diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 0c6eacfcbeef..d7491692aea3 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -70,7 +70,7 @@ static struct kmem_cache *isofs_inode_cachep;
 static struct inode *isofs_alloc_inode(struct super_block *sb)
 {
 	struct iso_inode_info *ei;
-	ei = kmem_cache_alloc(isofs_inode_cachep, GFP_KERNEL);
+	ei = alloc_inode_sb(sb, isofs_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	return &ei->vfs_inode;
diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
index 81ca58c10b72..7ea37f49f1e1 100644
--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -39,7 +39,7 @@ static struct inode *jffs2_alloc_inode(struct super_block *sb)
 {
 	struct jffs2_inode_info *f;
 
-	f = kmem_cache_alloc(jffs2_inode_cachep, GFP_KERNEL);
+	f = alloc_inode_sb(sb, jffs2_inode_cachep, GFP_KERNEL);
 	if (!f)
 		return NULL;
 	return &f->vfs_inode;
diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index 24cbc9946e01..f1a13a74cddf 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -102,7 +102,7 @@ static struct inode *jfs_alloc_inode(struct super_block *sb)
 {
 	struct jfs_inode_info *jfs_inode;
 
-	jfs_inode = kmem_cache_alloc(jfs_inode_cachep, GFP_NOFS);
+	jfs_inode = alloc_inode_sb(sb, jfs_inode_cachep, GFP_NOFS);
 	if (!jfs_inode)
 		return NULL;
 #ifdef CONFIG_QUOTA
diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index a71f1cf894b9..8a0af80741b5 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -63,7 +63,7 @@ static struct kmem_cache * minix_inode_cachep;
 static struct inode *minix_alloc_inode(struct super_block *sb)
 {
 	struct minix_inode_info *ei;
-	ei = kmem_cache_alloc(minix_inode_cachep, GFP_KERNEL);
+	ei = alloc_inode_sb(sb, minix_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	return &ei->vfs_inode;
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index fda530d5e764..59a63f1bd9ee 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -2241,7 +2241,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 struct inode *nfs_alloc_inode(struct super_block *sb)
 {
 	struct nfs_inode *nfsi;
-	nfsi = kmem_cache_alloc(nfs_inode_cachep, GFP_KERNEL);
+	nfsi = alloc_inode_sb(sb, nfs_inode_cachep, GFP_KERNEL);
 	if (!nfsi)
 		return NULL;
 	nfsi->flags = 0UL;
diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
index 63e5fa74016c..3e05c98631ec 100644
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -151,7 +151,7 @@ struct inode *nilfs_alloc_inode(struct super_block *sb)
 {
 	struct nilfs_inode_info *ii;
 
-	ii = kmem_cache_alloc(nilfs_inode_cachep, GFP_NOFS);
+	ii = alloc_inode_sb(sb, nilfs_inode_cachep, GFP_NOFS);
 	if (!ii)
 		return NULL;
 	ii->i_bh = NULL;
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 4474adb393ca..fca18ac72b4f 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -310,7 +310,7 @@ struct inode *ntfs_alloc_big_inode(struct super_block *sb)
 	ntfs_inode *ni;
 
 	ntfs_debug("Entering.");
-	ni = kmem_cache_alloc(ntfs_big_inode_cache, GFP_NOFS);
+	ni = alloc_inode_sb(sb, ntfs_big_inode_cache, GFP_NOFS);
 	if (likely(ni != NULL)) {
 		ni->state = 0;
 		return VFS_I(ni);
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 29813200c7af..278dcf502410 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -399,7 +399,7 @@ static struct kmem_cache *ntfs_inode_cachep;
 
 static struct inode *ntfs_alloc_inode(struct super_block *sb)
 {
-	struct ntfs_inode *ni = kmem_cache_alloc(ntfs_inode_cachep, GFP_NOFS);
+	struct ntfs_inode *ni = alloc_inode_sb(sb, ntfs_inode_cachep, GFP_NOFS);
 
 	if (!ni)
 		return NULL;
diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
index fa0a14f199eb..e360543ad7e7 100644
--- a/fs/ocfs2/dlmfs/dlmfs.c
+++ b/fs/ocfs2/dlmfs/dlmfs.c
@@ -280,7 +280,7 @@ static struct inode *dlmfs_alloc_inode(struct super_block *sb)
 {
 	struct dlmfs_inode_private *ip;
 
-	ip = kmem_cache_alloc(dlmfs_inode_cache, GFP_NOFS);
+	ip = alloc_inode_sb(sb, dlmfs_inode_cache, GFP_NOFS);
 	if (!ip)
 		return NULL;
 
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 1286b88b6fa1..0452d5835ffe 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -549,7 +549,7 @@ static struct inode *ocfs2_alloc_inode(struct super_block *sb)
 {
 	struct ocfs2_inode_info *oi;
 
-	oi = kmem_cache_alloc(ocfs2_inode_cachep, GFP_NOFS);
+	oi = alloc_inode_sb(sb, ocfs2_inode_cachep, GFP_NOFS);
 	if (!oi)
 		return NULL;
 
diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
index f825176ff4ed..f0b7f4d51a17 100644
--- a/fs/openpromfs/inode.c
+++ b/fs/openpromfs/inode.c
@@ -335,7 +335,7 @@ static struct inode *openprom_alloc_inode(struct super_block *sb)
 {
 	struct op_inode_info *oi;
 
-	oi = kmem_cache_alloc(op_inode_cachep, GFP_KERNEL);
+	oi = alloc_inode_sb(sb, op_inode_cachep, GFP_KERNEL);
 	if (!oi)
 		return NULL;
 
diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
index d90d8addbfc2..5254256a224d 100644
--- a/fs/orangefs/super.c
+++ b/fs/orangefs/super.c
@@ -107,7 +107,7 @@ static struct inode *orangefs_alloc_inode(struct super_block *sb)
 {
 	struct orangefs_inode_s *orangefs_inode;
 
-	orangefs_inode = kmem_cache_alloc(orangefs_inode_cache, GFP_KERNEL);
+	orangefs_inode = alloc_inode_sb(sb, orangefs_inode_cache, GFP_KERNEL);
 	if (!orangefs_inode)
 		return NULL;
 
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 265181c110ae..a1987aef2dfb 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -174,7 +174,7 @@ static struct kmem_cache *ovl_inode_cachep;
 
 static struct inode *ovl_alloc_inode(struct super_block *sb)
 {
-	struct ovl_inode *oi = kmem_cache_alloc(ovl_inode_cachep, GFP_KERNEL);
+	struct ovl_inode *oi = alloc_inode_sb(sb, ovl_inode_cachep, GFP_KERNEL);
 
 	if (!oi)
 		return NULL;
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 599eb724ff2d..cc0a406d3a19 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -66,7 +66,7 @@ static struct inode *proc_alloc_inode(struct super_block *sb)
 {
 	struct proc_inode *ei;
 
-	ei = kmem_cache_alloc(proc_inode_cachep, GFP_KERNEL);
+	ei = alloc_inode_sb(sb, proc_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	ei->pid = NULL;
diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
index 3fb7fc819b4f..a635bb6615e9 100644
--- a/fs/qnx4/inode.c
+++ b/fs/qnx4/inode.c
@@ -338,7 +338,7 @@ static struct kmem_cache *qnx4_inode_cachep;
 static struct inode *qnx4_alloc_inode(struct super_block *sb)
 {
 	struct qnx4_inode_info *ei;
-	ei = kmem_cache_alloc(qnx4_inode_cachep, GFP_KERNEL);
+	ei = alloc_inode_sb(sb, qnx4_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	return &ei->vfs_inode;
diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index 61191f7bdf62..9d8e7e9788a1 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -597,7 +597,7 @@ static struct kmem_cache *qnx6_inode_cachep;
 static struct inode *qnx6_alloc_inode(struct super_block *sb)
 {
 	struct qnx6_inode_info *ei;
-	ei = kmem_cache_alloc(qnx6_inode_cachep, GFP_KERNEL);
+	ei = alloc_inode_sb(sb, qnx6_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	return &ei->vfs_inode;
diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
index 82e09901462e..756c4916c7ae 100644
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -639,7 +639,7 @@ static struct kmem_cache *reiserfs_inode_cachep;
 static struct inode *reiserfs_alloc_inode(struct super_block *sb)
 {
 	struct reiserfs_inode_info *ei;
-	ei = kmem_cache_alloc(reiserfs_inode_cachep, GFP_KERNEL);
+	ei = alloc_inode_sb(sb, reiserfs_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	atomic_set(&ei->openers, 0);
diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index 259f684d9236..9e6bbb4219de 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -375,7 +375,7 @@ static struct inode *romfs_alloc_inode(struct super_block *sb)
 {
 	struct romfs_inode_info *inode;
 
-	inode = kmem_cache_alloc(romfs_inode_cachep, GFP_KERNEL);
+	inode = alloc_inode_sb(sb, romfs_inode_cachep, GFP_KERNEL);
 	return inode ? &inode->vfs_inode : NULL;
 }
 
diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
index bb44ff4c5cc6..32565dafa7f3 100644
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -551,7 +551,7 @@ static void __exit exit_squashfs_fs(void)
 static struct inode *squashfs_alloc_inode(struct super_block *sb)
 {
 	struct squashfs_inode_info *ei =
-		kmem_cache_alloc(squashfs_inode_cachep, GFP_KERNEL);
+		alloc_inode_sb(sb, squashfs_inode_cachep, GFP_KERNEL);
 
 	return ei ? &ei->vfs_inode : NULL;
 }
diff --git a/fs/sysv/inode.c b/fs/sysv/inode.c
index be47263b8605..9e8d4a6fb2f3 100644
--- a/fs/sysv/inode.c
+++ b/fs/sysv/inode.c
@@ -306,7 +306,7 @@ static struct inode *sysv_alloc_inode(struct super_block *sb)
 {
 	struct sysv_inode_info *si;
 
-	si = kmem_cache_alloc(sysv_inode_cachep, GFP_KERNEL);
+	si = alloc_inode_sb(sb, sysv_inode_cachep, GFP_KERNEL);
 	if (!si)
 		return NULL;
 	return &si->vfs_inode;
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index f0fb25727d96..73b51f8e6817 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -268,7 +268,7 @@ static struct inode *ubifs_alloc_inode(struct super_block *sb)
 {
 	struct ubifs_inode *ui;
 
-	ui = kmem_cache_alloc(ubifs_inode_slab, GFP_NOFS);
+	ui = alloc_inode_sb(sb, ubifs_inode_slab, GFP_NOFS);
 	if (!ui)
 		return NULL;
 
diff --git a/fs/udf/super.c b/fs/udf/super.c
index f26b5e0b84b6..48871615e489 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -136,7 +136,7 @@ static struct kmem_cache *udf_inode_cachep;
 static struct inode *udf_alloc_inode(struct super_block *sb)
 {
 	struct udf_inode_info *ei;
-	ei = kmem_cache_alloc(udf_inode_cachep, GFP_KERNEL);
+	ei = alloc_inode_sb(sb, udf_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 
diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index 00a01471ea05..23377c1baed9 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -1443,7 +1443,7 @@ static struct inode *ufs_alloc_inode(struct super_block *sb)
 {
 	struct ufs_inode_info *ei;
 
-	ei = kmem_cache_alloc(ufs_inode_cachep, GFP_NOFS);
+	ei = alloc_inode_sb(sb, ufs_inode_cachep, GFP_NOFS);
 	if (!ei)
 		return NULL;
 
diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
index 37dd3fe5b1e9..d2f6df69f611 100644
--- a/fs/vboxsf/super.c
+++ b/fs/vboxsf/super.c
@@ -241,7 +241,7 @@ static struct inode *vboxsf_alloc_inode(struct super_block *sb)
 {
 	struct vboxsf_inode *sf_i;
 
-	sf_i = kmem_cache_alloc(vboxsf_inode_cachep, GFP_NOFS);
+	sf_i = alloc_inode_sb(sb, vboxsf_inode_cachep, GFP_NOFS);
 	if (!sf_i)
 		return NULL;
 
diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index da4af2142a2b..57b4fd7d7c5e 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -77,7 +77,7 @@ xfs_inode_alloc(
 	 * XXX: If this didn't occur in transactions, we could drop GFP_NOFAIL
 	 * and return NULL here on ENOMEM.
 	 */
-	ip = kmem_cache_alloc(xfs_inode_cache, GFP_KERNEL | __GFP_NOFAIL);
+	ip = alloc_inode_sb(mp->m_super, xfs_inode_cache, GFP_KERNEL | __GFP_NOFAIL);
 
 	if (inode_init_always(mp->m_super, VFS_I(ip))) {
 		kmem_cache_free(xfs_inode_cache, ip);
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 259ee2bda492..e88e16a1529a 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -1137,7 +1137,7 @@ static struct inode *zonefs_alloc_inode(struct super_block *sb)
 {
 	struct zonefs_inode_info *zi;
 
-	zi = kmem_cache_alloc(zonefs_inode_cachep, GFP_KERNEL);
+	zi = alloc_inode_sb(sb, zonefs_inode_cachep, GFP_KERNEL);
 	if (!zi)
 		return NULL;
 
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 5becca9be867..7c08eb3c258d 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -486,7 +486,7 @@ static struct inode *mqueue_alloc_inode(struct super_block *sb)
 {
 	struct mqueue_inode_info *ei;
 
-	ei = kmem_cache_alloc(mqueue_inode_cachep, GFP_KERNEL);
+	ei = alloc_inode_sb(sb, mqueue_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	return &ei->vfs_inode;
diff --git a/mm/shmem.c b/mm/shmem.c
index 18f93c2d68f1..b8490cbbc1a0 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3714,7 +3714,7 @@ static struct kmem_cache *shmem_inode_cachep;
 static struct inode *shmem_alloc_inode(struct super_block *sb)
 {
 	struct shmem_inode_info *info;
-	info = kmem_cache_alloc(shmem_inode_cachep, GFP_KERNEL);
+	info = alloc_inode_sb(sb, shmem_inode_cachep, GFP_KERNEL);
 	if (!info)
 		return NULL;
 	return &info->vfs_inode;
diff --git a/net/socket.c b/net/socket.c
index 7f64a6eccf63..cee567ccd99c 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -300,7 +300,7 @@ static struct inode *sock_alloc_inode(struct super_block *sb)
 {
 	struct socket_alloc *ei;
 
-	ei = kmem_cache_alloc(sock_inode_cachep, GFP_KERNEL);
+	ei = alloc_inode_sb(sb, sock_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	init_waitqueue_head(&ei->socket.wq.wait);
diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index ee5336d73fdd..7ed4accc480d 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -197,7 +197,7 @@ static struct inode *
 rpc_alloc_inode(struct super_block *sb)
 {
 	struct rpc_inode *rpci;
-	rpci = kmem_cache_alloc(rpc_inode_cachep, GFP_KERNEL);
+	rpci = alloc_inode_sb(sb, rpc_inode_cachep, GFP_KERNEL);
 	if (!rpci)
 		return NULL;
 	return &rpci->vfs_inode;
-- 
2.11.0

