Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2097392776
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 08:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbhE0G1a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 02:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbhE0G1D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 02:27:03 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69535C061346
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 23:25:29 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id q25so2874755pfn.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 23:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W+XDpXtgnloFQ+TzXm2Lkz4gcpdlW86il6bXZrzroV8=;
        b=uNhA97Kd/IL4zUzrfFXFYa5MMoYSnh6t02n75mOdOxqaXgn2DfEckubCYm8WlzpFZk
         isNL+QIlnR6JpoGxLRwChZVF2eIu0zwI9WXAZ0Ya9iKX4kPRlk6qx1VddfpGZerc66mk
         b6Oa68Y4cSE94Ca+AwwBS7dVMh/AMeG7jQvTvdbhOKmfljAhjl4/W/Aa5hKxRE2pYU55
         Z3gGMCnXwYV1Axy8lNY4ds4Y6EHOM/VQqitXN+BN0J2dcDZb71cbeKdu9Fw/jTq7F4jg
         lp+MDINnI5ihJuVlUoQnkjIYO0TrAG4VUJWe96B9HLxvncH+sJPl77Z4bq+SUSqWkXJu
         MH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W+XDpXtgnloFQ+TzXm2Lkz4gcpdlW86il6bXZrzroV8=;
        b=SfT3y2LW+LOA3NBcdvR9FTV6MO6gyamA+VPOOulbNUU3xvqX7fqcS3f+xv2CsVLo1X
         CKUjjU8XElU/8ceWRvoemH/OTSdtrWayPuq2mDaPJVIQv8Ghq1zGXXwk11SOgg0bQfd+
         IFuYPXnDvwuLxyVr15IqBUiHWZvHYbjHv2cAkNFrtkufedfMM+LiTDhEarOo+jFSA599
         7HIpQN1TuGOBGPuOIX+gFUSeOrSYNucFl3iT6y/ajTgk87NOz3ubzu2DrfRvCtz/wAGn
         j1G2KfTbTk4hrnbYybWAM7ZifOkNlT7KAKUjqH7DOWLMdn4L1DBJkKURs/vjjbxi+oe+
         uQKQ==
X-Gm-Message-State: AOAM530LQxWUV1b0DRsHly5tNn8fNaYIKdiOpKQ+MOFKj7P/rnnIpahY
        eTtFN+xpYUhwuSdBpAGudRumAA==
X-Google-Smtp-Source: ABdhPJyO06J1i7YbgNg0XJqhzH4oKhkepT7GeUCPZRS0GcxAK9FpBS9Dsge7s97JpPwmfZH2eEkWYg==
X-Received: by 2002:a63:e058:: with SMTP id n24mr2272816pgj.91.1622096728657;
        Wed, 26 May 2021 23:25:28 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id m5sm882971pgl.75.2021.05.26.23.25.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 May 2021 23:25:28 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 10/21] fs: introduce alloc_inode_sb() to allocate filesystems specific inode
Date:   Thu, 27 May 2021 14:21:37 +0800
Message-Id: <20210527062148.9361-11-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210527062148.9361-1-songmuchun@bytedance.com>
References: <20210527062148.9361-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The allocated inode cache will be added to its memcg list_lru, we should
allocate its list_lru_one structure in advance. Introduce alloc_inode_sb
which is used for allocating filesystems specific inodes to set up the
inode reclaim context correctly.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 Documentation/filesystems/porting.rst |  5 +++++
 drivers/dax/super.c                   |  2 +-
 fs/9p/vfs_inode.c                     |  2 +-
 fs/adfs/super.c                       |  2 +-
 fs/affs/super.c                       |  2 +-
 fs/afs/super.c                        |  2 +-
 fs/befs/linuxvfs.c                    |  2 +-
 fs/bfs/inode.c                        |  2 +-
 fs/block_dev.c                        |  2 +-
 fs/btrfs/inode.c                      |  2 +-
 fs/ceph/inode.c                       |  2 +-
 fs/cifs/cifsfs.c                      |  2 +-
 fs/coda/inode.c                       |  2 +-
 fs/ecryptfs/super.c                   |  2 +-
 fs/efs/super.c                        |  2 +-
 fs/erofs/super.c                      |  2 +-
 fs/exfat/super.c                      |  2 +-
 fs/ext2/super.c                       |  2 +-
 fs/ext4/super.c                       |  2 +-
 fs/f2fs/super.c                       |  2 +-
 fs/fat/inode.c                        |  2 +-
 fs/freevxfs/vxfs_super.c              |  2 +-
 fs/fuse/inode.c                       |  2 +-
 fs/gfs2/super.c                       |  2 +-
 fs/hfs/super.c                        |  2 +-
 fs/hfsplus/super.c                    |  2 +-
 fs/hostfs/hostfs_kern.c               |  2 +-
 fs/hpfs/super.c                       |  2 +-
 fs/hugetlbfs/inode.c                  |  2 +-
 fs/inode.c                            |  2 +-
 fs/isofs/inode.c                      |  2 +-
 fs/jffs2/super.c                      |  2 +-
 fs/jfs/super.c                        |  2 +-
 fs/minix/inode.c                      |  2 +-
 fs/nfs/inode.c                        |  2 +-
 fs/nilfs2/super.c                     |  2 +-
 fs/ntfs/inode.c                       |  2 +-
 fs/ocfs2/dlmfs/dlmfs.c                |  2 +-
 fs/ocfs2/super.c                      |  2 +-
 fs/openpromfs/inode.c                 |  2 +-
 fs/orangefs/super.c                   |  2 +-
 fs/overlayfs/super.c                  |  2 +-
 fs/proc/inode.c                       |  2 +-
 fs/qnx4/inode.c                       |  2 +-
 fs/qnx6/inode.c                       |  2 +-
 fs/reiserfs/super.c                   |  2 +-
 fs/romfs/super.c                      |  2 +-
 fs/squashfs/super.c                   |  2 +-
 fs/sysv/inode.c                       |  2 +-
 fs/ubifs/super.c                      |  2 +-
 fs/udf/super.c                        |  2 +-
 fs/ufs/super.c                        |  2 +-
 fs/vboxsf/super.c                     |  2 +-
 fs/xfs/xfs_icache.c                   |  3 ++-
 fs/zonefs/super.c                     |  2 +-
 include/linux/fs.h                    | 11 +++++++++++
 ipc/mqueue.c                          |  2 +-
 mm/shmem.c                            |  2 +-
 net/socket.c                          |  2 +-
 net/sunrpc/rpc_pipe.c                 |  2 +-
 60 files changed, 75 insertions(+), 58 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 0302035781be..7db1c462cfcc 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -45,6 +45,11 @@ typically between calling iget_locked() and unlocking the inode.
 
 At some point that will become mandatory.
 
+**mandatory**
+
+The foo_inode_info should always be allocated through alloc_inode_sb() rather
+than kmem_cache_alloc().
+
 ---
 
 **mandatory**
diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 5fa6ae9dbc8b..30474ba337c8 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -460,7 +460,7 @@ static struct inode *dax_alloc_inode(struct super_block *sb)
 	struct dax_device *dax_dev;
 	struct inode *inode;
 
-	dax_dev = kmem_cache_alloc(dax_cache, GFP_KERNEL);
+	dax_dev = alloc_inode_sb(sb, dax_cache, GFP_KERNEL);
 	if (!dax_dev)
 		return NULL;
 
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 795706520b5e..5311f35accf5 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -223,7 +223,7 @@ v9fs_blank_wstat(struct p9_wstat *wstat)
 struct inode *v9fs_alloc_inode(struct super_block *sb)
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
index c6c2a513ec92..67458f63a1ab 100644
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
index e38bb1e7a4d2..0ecea5a94af9 100644
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
diff --git a/fs/block_dev.c b/fs/block_dev.c
index b8abccd03e5d..14a0ef54ae50 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -796,7 +796,7 @@ static struct kmem_cache * bdev_cachep __read_mostly;
 
 static struct inode *bdev_alloc_inode(struct super_block *sb)
 {
-	struct bdev_inode *ei = kmem_cache_alloc(bdev_cachep, GFP_KERNEL);
+	struct bdev_inode *ei = alloc_inode_sb(sb, bdev_cachep, GFP_KERNEL);
 
 	if (!ei)
 		return NULL;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b44c28455d4f..75decdbdbd45 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8793,7 +8793,7 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	struct btrfs_inode *ei;
 	struct inode *inode;
 
-	ei = kmem_cache_alloc(btrfs_inode_cachep, GFP_KERNEL);
+	ei = alloc_inode_sb(sb, btrfs_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index e1c63adb196d..9fe9db45a6ab 100644
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
index 2ffcb29d5c8f..d68cb0ddb85a 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -363,7 +363,7 @@ static struct inode *
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
index bbf3bbd908e0..03f2dd684f8d 100644
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
index d38d17a77e76..c88e0f218df0 100644
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
index 21e09fbaa46f..7eba9d6fbdc6 100644
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
index 7dc94f3e18e6..b2c486d224b4 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1275,7 +1275,7 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
 {
 	struct ext4_inode_info *ei;
 
-	ei = kmem_cache_alloc(ext4_inode_cachep, GFP_NOFS);
+	ei = alloc_inode_sb(sb, ext4_inode_cachep, GFP_NOFS);
 	if (!ei)
 		return NULL;
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 7d325bfaf65a..444134950ae4 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1169,7 +1169,7 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 {
 	struct f2fs_inode_info *fi;
 
-	fi = kmem_cache_alloc(f2fs_inode_cachep, GFP_F2FS_ZERO);
+	fi = alloc_inode_sb(sb, f2fs_inode_cachep, GFP_F2FS_ZERO);
 	if (!fi)
 		return NULL;
 
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index bab9b202b496..adc8a525553a 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -744,7 +744,7 @@ static struct kmem_cache *fat_inode_cachep;
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
index 393e36b74dc4..3fe7d1484ae6 100644
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
index 4d4ceb0b6903..e9e8ad6f0c66 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1496,7 +1496,7 @@ static struct inode *gfs2_alloc_inode(struct super_block *sb)
 {
 	struct gfs2_inode *ip;
 
-	ip = kmem_cache_alloc(gfs2_inode_cachep, GFP_KERNEL);
+	ip = alloc_inode_sb(sb, gfs2_inode_cachep, GFP_KERNEL);
 	if (!ip)
 		return NULL;
 	ip->i_flags = 0;
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index 44d07c9e3a7f..e40334c93183 100644
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
index 7d0c3dbb2898..96dc97ae48e4 100644
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
index 9d9e0097c1d3..7a3095f786ec 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1108,7 +1108,7 @@ static struct inode *hugetlbfs_alloc_inode(struct super_block *sb)
 
 	if (unlikely(!hugetlbfs_dec_free_inodes(sbinfo)))
 		return NULL;
-	p = kmem_cache_alloc(hugetlbfs_inode_cachep, GFP_KERNEL);
+	p = alloc_inode_sb(sb, hugetlbfs_inode_cachep, GFP_KERNEL);
 	if (unlikely(!p)) {
 		hugetlbfs_inc_free_inodes(sbinfo);
 		return NULL;
diff --git a/fs/inode.c b/fs/inode.c
index c93500d84264..60ab51416a16 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -232,7 +232,7 @@ static struct inode *alloc_inode(struct super_block *sb)
 	if (ops->alloc_inode)
 		inode = ops->alloc_inode(sb);
 	else
-		inode = kmem_cache_alloc(inode_cachep, GFP_KERNEL);
+		inode = alloc_inode_sb(sb, inode_cachep, GFP_KERNEL);
 
 	if (!inode)
 		return NULL;
diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 21edc423b79f..ef6c29501702 100644
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
index 1f0ffabbde56..65255541d44e 100644
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
index a532a99bbe81..f30b1daac386 100644
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
index 529c4099f482..fa3d8e8b695f 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -2240,7 +2240,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 struct inode *nfs_alloc_inode(struct super_block *sb)
 {
 	struct nfs_inode *nfsi;
-	nfsi = kmem_cache_alloc(nfs_inode_cachep, GFP_KERNEL);
+	nfsi = alloc_inode_sb(sb, nfs_inode_cachep, GFP_KERNEL);
 	if (!nfsi)
 		return NULL;
 	nfsi->flags = 0UL;
diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
index 4abd928b0bc8..e7d7ad7a1e50 100644
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
index f5c058b3192c..1e053bb58ead 100644
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
index c86bd4e60e20..cf044448130f 100644
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
index ee5efdc35cc1..5731ce285c98 100644
--- a/fs/orangefs/super.c
+++ b/fs/orangefs/super.c
@@ -106,7 +106,7 @@ static struct inode *orangefs_alloc_inode(struct super_block *sb)
 {
 	struct orangefs_inode_s *orangefs_inode;
 
-	orangefs_inode = kmem_cache_alloc(orangefs_inode_cache, GFP_KERNEL);
+	orangefs_inode = alloc_inode_sb(sb, orangefs_inode_cache, GFP_KERNEL);
 	if (!orangefs_inode)
 		return NULL;
 
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index b01d4147520d..6d8d16bf4b57 100644
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
index 3ffafc73acf0..d9e8b0368ce9 100644
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
index 88cc94be1076..16b785cb78c4 100644
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -466,7 +466,7 @@ static void __exit exit_squashfs_fs(void)
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
index 7b572e1414ba..6851040c598e 100644
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
index 2f83c1204e20..bdeaa5d88a9e 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -141,7 +141,7 @@ static struct kmem_cache *udf_inode_cachep;
 static struct inode *udf_alloc_inode(struct super_block *sb)
 {
 	struct udf_inode_info *ei;
-	ei = kmem_cache_alloc(udf_inode_cachep, GFP_KERNEL);
+	ei = alloc_inode_sb(sb, udf_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 
diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index 74028b5a7b0a..ba83ad6e9d39 100644
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
index 4f5e59f06284..050ef855158b 100644
--- a/fs/vboxsf/super.c
+++ b/fs/vboxsf/super.c
@@ -244,7 +244,7 @@ static struct inode *vboxsf_alloc_inode(struct super_block *sb)
 {
 	struct vboxsf_inode *sf_i;
 
-	sf_i = kmem_cache_alloc(vboxsf_inode_cachep, GFP_NOFS);
+	sf_i = alloc_inode_sb(sb, vboxsf_inode_cachep, GFP_NOFS);
 	if (!sf_i)
 		return NULL;
 
diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 3c81daca0e9a..8c8b059e1e26 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -40,7 +40,8 @@ xfs_inode_alloc(
 	 * XXX: If this didn't occur in transactions, we could drop GFP_NOFAIL
 	 * and return NULL here on ENOMEM.
 	 */
-	ip = kmem_cache_alloc(xfs_inode_zone, GFP_KERNEL | __GFP_NOFAIL);
+	ip = alloc_inode_sb(mp->m_super, xfs_inode_zone,
+			    GFP_KERNEL | __GFP_NOFAIL);
 
 	if (inode_init_always(mp->m_super, VFS_I(ip))) {
 		kmem_cache_free(xfs_inode_zone, ip);
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index cd145d318b17..335b58251b52 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -1152,7 +1152,7 @@ static struct inode *zonefs_alloc_inode(struct super_block *sb)
 {
 	struct zonefs_inode_info *zi;
 
-	zi = kmem_cache_alloc(zonefs_inode_cachep, GFP_KERNEL);
+	zi = alloc_inode_sb(sb, zonefs_inode_cachep, GFP_KERNEL);
 	if (!zi)
 		return NULL;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c3c88fdb9b2a..cb016debb46e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -41,6 +41,7 @@
 #include <linux/stddef.h>
 #include <linux/mount.h>
 #include <linux/cred.h>
+#include <linux/slab.h>
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
@@ -3200,6 +3201,16 @@ extern void free_inode_nonrcu(struct inode *inode);
 extern int should_remove_suid(struct dentry *);
 extern int file_remove_privs(struct file *);
 
+/*
+ * This must be used for allocating filesystems specific inodes to set
+ * up the inode reclaim context correctly.
+ */
+static inline void *
+alloc_inode_sb(struct super_block *sb, struct kmem_cache *cache, gfp_t gfp)
+{
+	return kmem_cache_alloc_lru(cache, &sb->s_inode_lru, gfp);
+}
+
 extern void __insert_inode_hash(struct inode *, unsigned long hashval);
 static inline void insert_inode_hash(struct inode *inode)
 {
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 4e4e61111500..310178dc5480 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -483,7 +483,7 @@ static struct inode *mqueue_alloc_inode(struct super_block *sb)
 {
 	struct mqueue_inode_info *ei;
 
-	ei = kmem_cache_alloc(mqueue_inode_cachep, GFP_KERNEL);
+	ei = alloc_inode_sb(sb, mqueue_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	return &ei->vfs_inode;
diff --git a/mm/shmem.c b/mm/shmem.c
index ccce139d4e5c..67c8db781727 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3736,7 +3736,7 @@ static struct kmem_cache *shmem_inode_cachep;
 static struct inode *shmem_alloc_inode(struct super_block *sb)
 {
 	struct shmem_inode_info *info;
-	info = kmem_cache_alloc(shmem_inode_cachep, GFP_KERNEL);
+	info = alloc_inode_sb(sb, shmem_inode_cachep, GFP_KERNEL);
 	if (!info)
 		return NULL;
 	return &info->vfs_inode;
diff --git a/net/socket.c b/net/socket.c
index 27e3e7d53f8e..d59844b02a2d 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -250,7 +250,7 @@ static struct inode *sock_alloc_inode(struct super_block *sb)
 {
 	struct socket_alloc *ei;
 
-	ei = kmem_cache_alloc(sock_inode_cachep, GFP_KERNEL);
+	ei = alloc_inode_sb(sb, sock_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	init_waitqueue_head(&ei->socket.wq.wait);
diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index 09c000d490a1..30707f39694e 100644
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

