Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 631DA79E5D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 03:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731067AbfG3Bvn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jul 2019 21:51:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43567 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730837AbfG3Bu1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jul 2019 21:50:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id i189so28949610pfg.10;
        Mon, 29 Jul 2019 18:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CJvht37EZemmcnBgtlNiz9+F+TMC9CP5JC3nxpy4VdY=;
        b=GYkm93F1cJJjois+RV8eMjig9xIYQGk+SUnlQDx43S+Uu/41dHNKq90eVf618tDeUr
         WEhiGiy+V5MiKxL76vvoq57Fv52TCb6McUeald2lUzRsAlH+djZTCx912xz1xe/0uhYF
         raBQiGP750m/gqcyG2+H2THhlCHvYbdV9cbIZ5XSHgORnKCeuL6V7rrfuzm7WbifsB/e
         G0zvOt+LVA9KtaEu6+9piTZLiIDyeuqyGnhvHXnLUfRKpsjGvo2fnsVCgoerB7LL2t1j
         DkiSzSFuxoUY16+Xnrx6oiR20x5Cq+JMCahtn/DNTqBOsUs+1/tmZeAf61XUNw7gdTOR
         tE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CJvht37EZemmcnBgtlNiz9+F+TMC9CP5JC3nxpy4VdY=;
        b=c++eOynR/75hAdNEql4xAgHunXxIBT+8EGE07x4qh7Ucp1Gnq0easXXS4ZrJN7N0O8
         uWtSETtaZALUQaBh9dupvKV3UPlJHrjHFU4FLfVDoKUTw1rkLuLEY3HylviYu+jR6jEm
         70OJ8inwjyLZgQmDKsuCbmt2m0K/Adjj3fsijx3a84VgEdcl/+cVFB4RHjRv9bm3E+H+
         sG8vC9IiXmrswO3XQFXnlBKGnF/ymtT+y567iWO21ehoEOAMZ31CefRQNZam5DGTRE7d
         D+/wNeSNq7TLtX1zFwoXUDc6rM8szU1zoeC/q+mXceXH/3Ex5rMou+KjwXz9e9GXCbFG
         ByOg==
X-Gm-Message-State: APjAAAUV74SSj7Px5abA2h87lpafIpkSjbsOvzBIMa5twm2zMT9V2xWM
        iv7J6BMSvYxRIyOrlnUjpRU=
X-Google-Smtp-Source: APXvYqw9HM2FyYpOSBZ+oV02s33RW4zpOn3lB0rMSooqL418lTjpdNtWteRxv46hIS/3Tw3gww5h6Q==
X-Received: by 2002:a62:e315:: with SMTP id g21mr40609144pfh.225.1564451426354;
        Mon, 29 Jul 2019 18:50:26 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id r6sm138807156pjb.22.2019.07.29.18.50.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 18:50:25 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, arnd@arndb.de,
        y2038@lists.linaro.org, aivazian.tigran@gmail.com, al@alarsen.net,
        coda@cs.cmu.edu, darrick.wong@oracle.com, dushistov@mail.ru,
        dwmw2@infradead.org, hch@infradead.org, jack@suse.com,
        jaharkes@cs.cmu.edu, luisbg@kernel.org, nico@fluxnic.net,
        phillip@squashfs.org.uk, richard@nod.at, salah.triki@gmail.com,
        shaggy@kernel.org, linux-xfs@vger.kernel.org,
        codalist@coda.cs.cmu.edu, linux-ext4@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        jfs-discussion@lists.sourceforge.net,
        reiserfs-devel@vger.kernel.org
Subject: [PATCH 06/20] fs: Fill in max and min timestamps in superblock
Date:   Mon, 29 Jul 2019 18:49:10 -0700
Message-Id: <20190730014924.2193-7-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190730014924.2193-1-deepa.kernel@gmail.com>
References: <20190730014924.2193-1-deepa.kernel@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fill in the appropriate limits to avoid inconsistencies
in the vfs cached inode times when timestamps are
outside the permitted range.

Even though some filesystems are read-only, fill in the
timestamps to reflect the on-disk representation.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: aivazian.tigran@gmail.com
Cc: al@alarsen.net
Cc: coda@cs.cmu.edu
Cc: darrick.wong@oracle.com
Cc: dushistov@mail.ru
Cc: dwmw2@infradead.org
Cc: hch@infradead.org
Cc: jack@suse.com
Cc: jaharkes@cs.cmu.edu
Cc: luisbg@kernel.org
Cc: nico@fluxnic.net
Cc: phillip@squashfs.org.uk
Cc: richard@nod.at
Cc: salah.triki@gmail.com
Cc: shaggy@kernel.org
Cc: linux-xfs@vger.kernel.org
Cc: codalist@coda.cs.cmu.edu
Cc: linux-ext4@vger.kernel.org
Cc: linux-mtd@lists.infradead.org
Cc: jfs-discussion@lists.sourceforge.net
Cc: reiserfs-devel@vger.kernel.org
---
 fs/befs/linuxvfs.c       | 2 ++
 fs/bfs/inode.c           | 2 ++
 fs/coda/inode.c          | 3 +++
 fs/cramfs/inode.c        | 2 ++
 fs/efs/super.c           | 2 ++
 fs/ext2/super.c          | 2 ++
 fs/freevxfs/vxfs_super.c | 2 ++
 fs/jffs2/fs.c            | 3 +++
 fs/jfs/super.c           | 2 ++
 fs/minix/inode.c         | 2 ++
 fs/qnx4/inode.c          | 2 ++
 fs/qnx6/inode.c          | 2 ++
 fs/reiserfs/super.c      | 3 +++
 fs/romfs/super.c         | 2 ++
 fs/squashfs/super.c      | 2 ++
 fs/ufs/super.c           | 7 +++++++
 fs/xfs/xfs_super.c       | 2 ++
 17 files changed, 42 insertions(+)

diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index 462d096ff3e9..64cdf4d8e424 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -893,6 +893,8 @@ befs_fill_super(struct super_block *sb, void *data, int silent)
 	sb_set_blocksize(sb, (ulong) befs_sb->block_size);
 	sb->s_op = &befs_sops;
 	sb->s_export_op = &befs_export_operations;
+	sb->s_time_min = 0;
+	sb->s_time_max = 0xffffffffffffll;
 	root = befs_iget(sb, iaddr2blockno(sb, &(befs_sb->root_dir)));
 	if (IS_ERR(root)) {
 		ret = PTR_ERR(root);
diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
index 5e97bed073d7..f8ce1368218b 100644
--- a/fs/bfs/inode.c
+++ b/fs/bfs/inode.c
@@ -324,6 +324,8 @@ static int bfs_fill_super(struct super_block *s, void *data, int silent)
 		return -ENOMEM;
 	mutex_init(&info->bfs_lock);
 	s->s_fs_info = info;
+	s->s_time_min = 0;
+	s->s_time_max = U32_MAX;
 
 	sb_set_blocksize(s, BFS_BSIZE);
 
diff --git a/fs/coda/inode.c b/fs/coda/inode.c
index 321f56e487cb..b1c70e2b9b1e 100644
--- a/fs/coda/inode.c
+++ b/fs/coda/inode.c
@@ -188,6 +188,9 @@ static int coda_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_magic = CODA_SUPER_MAGIC;
 	sb->s_op = &coda_super_operations;
 	sb->s_d_op = &coda_dentry_operations;
+	sb->s_time_gran = 1;
+	sb->s_time_min = S64_MIN;
+	sb->s_time_max = S64_MAX;
 
 	error = super_setup_bdi(sb);
 	if (error)
diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 9352487bd0fc..4d1d8b7761ed 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -597,6 +597,8 @@ static int cramfs_finalize_super(struct super_block *sb,
 
 	/* Set it all up.. */
 	sb->s_flags |= SB_RDONLY;
+	sb->s_time_min = 0;
+	sb->s_time_max = 0;
 	sb->s_op = &cramfs_ops;
 	root = get_cramfs_inode(sb, cramfs_root, 0);
 	if (IS_ERR(root))
diff --git a/fs/efs/super.c b/fs/efs/super.c
index 867fc24dee20..4a6ebff2af76 100644
--- a/fs/efs/super.c
+++ b/fs/efs/super.c
@@ -257,6 +257,8 @@ static int efs_fill_super(struct super_block *s, void *d, int silent)
 	if (!sb)
 		return -ENOMEM;
 	s->s_fs_info = sb;
+	s->s_time_min = 0;
+	s->s_time_max = U32_MAX;
  
 	s->s_magic		= EFS_SUPER_MAGIC;
 	if (!sb_set_blocksize(s, EFS_BLOCKSIZE)) {
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 44eb6e7eb492..baa36c6fb71e 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -1002,6 +1002,8 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 
 	sb->s_maxbytes = ext2_max_size(sb->s_blocksize_bits);
 	sb->s_max_links = EXT2_LINK_MAX;
+	sb->s_time_min = S32_MIN;
+	sb->s_time_max = S32_MAX;
 
 	if (le32_to_cpu(es->s_rev_level) == EXT2_GOOD_OLD_REV) {
 		sbi->s_inode_size = EXT2_GOOD_OLD_INODE_SIZE;
diff --git a/fs/freevxfs/vxfs_super.c b/fs/freevxfs/vxfs_super.c
index a89f68c3cbed..578a5062706e 100644
--- a/fs/freevxfs/vxfs_super.c
+++ b/fs/freevxfs/vxfs_super.c
@@ -229,6 +229,8 @@ static int vxfs_fill_super(struct super_block *sbp, void *dp, int silent)
 
 	sbp->s_op = &vxfs_super_ops;
 	sbp->s_fs_info = infp;
+	sbp->s_time_min = 0;
+	sbp->s_time_max = U32_MAX;
 
 	if (!vxfs_try_sb_magic(sbp, silent, 1,
 			(__force __fs32)cpu_to_le32(VXFS_SUPER_MAGIC))) {
diff --git a/fs/jffs2/fs.c b/fs/jffs2/fs.c
index 8a20ddd25f2d..d0b59d03a7a9 100644
--- a/fs/jffs2/fs.c
+++ b/fs/jffs2/fs.c
@@ -590,6 +590,9 @@ int jffs2_do_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_blocksize = PAGE_SIZE;
 	sb->s_blocksize_bits = PAGE_SHIFT;
 	sb->s_magic = JFFS2_SUPER_MAGIC;
+	sb->s_time_min = 0;
+	sb->s_time_max = U32_MAX;
+
 	if (!sb_rdonly(sb))
 		jffs2_start_garbage_collect_thread(c);
 	return 0;
diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index f4e10cb9f734..b2dc4d1f9dcc 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -503,6 +503,8 @@ static int jfs_fill_super(struct super_block *sb, void *data, int silent)
 
 	sb->s_fs_info = sbi;
 	sb->s_max_links = JFS_LINK_MAX;
+	sb->s_time_min = 0;
+	sb->s_time_max = U32_MAX;
 	sbi->sb = sb;
 	sbi->uid = INVALID_UID;
 	sbi->gid = INVALID_GID;
diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index f96073f25432..7cb5fd38eb14 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -277,6 +277,8 @@ static int minix_fill_super(struct super_block *s, void *data, int silent)
 
 	/* set up enough so that it can read an inode */
 	s->s_op = &minix_sops;
+	s->s_time_min = 0;
+	s->s_time_max = U32_MAX;
 	root_inode = minix_iget(s, MINIX_ROOT_INO);
 	if (IS_ERR(root_inode)) {
 		ret = PTR_ERR(root_inode);
diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
index 922d083bbc7c..e8da1cde87b9 100644
--- a/fs/qnx4/inode.c
+++ b/fs/qnx4/inode.c
@@ -201,6 +201,8 @@ static int qnx4_fill_super(struct super_block *s, void *data, int silent)
 	s->s_op = &qnx4_sops;
 	s->s_magic = QNX4_SUPER_MAGIC;
 	s->s_flags |= SB_RDONLY;	/* Yup, read-only yet */
+	s->s_time_min = 0;
+	s->s_time_max = U32_MAX;
 
 	/* Check the superblock signature. Since the qnx4 code is
 	   dangerous, we should leave as quickly as possible
diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index 0f8b0ff1ba43..345db56c98fd 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -429,6 +429,8 @@ static int qnx6_fill_super(struct super_block *s, void *data, int silent)
 	s->s_op = &qnx6_sops;
 	s->s_magic = QNX6_SUPER_MAGIC;
 	s->s_flags |= SB_RDONLY;        /* Yup, read-only yet */
+	s->s_time_min = 0;
+	s->s_time_max = U32_MAX;
 
 	/* ease the later tree level calculations */
 	sbi = QNX6_SB(s);
diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
index ab028ea0e561..d69b4ac0ae2f 100644
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -1976,6 +1976,9 @@ static int reiserfs_fill_super(struct super_block *s, void *data, int silent)
 		goto error_unlocked;
 	}
 
+	s->s_time_min = 0;
+	s->s_time_max = U32_MAX;
+
 	rs = SB_DISK_SUPER_BLOCK(s);
 	/*
 	 * Let's do basic sanity check to verify that underlying device is not
diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index 7d580f7c3f1d..a42c0e3079dc 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -478,6 +478,8 @@ static int romfs_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_maxbytes = 0xFFFFFFFF;
 	sb->s_magic = ROMFS_MAGIC;
 	sb->s_flags |= SB_RDONLY | SB_NOATIME;
+	sb->s_time_min = 0;
+	sb->s_time_max = 0;
 	sb->s_op = &romfs_super_ops;
 
 #ifdef CONFIG_ROMFS_ON_MTD
diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
index effa638d6d85..a9e9837617a9 100644
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -183,6 +183,8 @@ static int squashfs_fill_super(struct super_block *sb, void *data, int silent)
 		(u64) le64_to_cpu(sblk->id_table_start));
 
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
+	sb->s_time_min = 0;
+	sb->s_time_max = U32_MAX;
 	sb->s_flags |= SB_RDONLY;
 	sb->s_op = &squashfs_super_ops;
 
diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index 4ed0dca52ec8..1da0be667409 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -843,6 +843,10 @@ static int ufs_fill_super(struct super_block *sb, void *data, int silent)
 
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
 
+	sb->s_time_gran = NSEC_PER_SEC;
+	sb->s_time_min = S32_MIN;
+	sb->s_time_max = S32_MAX;
+
 	switch (sbi->s_mount_opt & UFS_MOUNT_UFSTYPE) {
 	case UFS_MOUNT_UFSTYPE_44BSD:
 		UFSD("ufstype=44bsd\n");
@@ -861,6 +865,9 @@ static int ufs_fill_super(struct super_block *sb, void *data, int silent)
 		uspi->s_fshift = 9;
 		uspi->s_sbsize = super_block_size = 1536;
 		uspi->s_sbbase =  0;
+		sb->s_time_gran = 1;
+		sb->s_time_min = S64_MIN;
+		sb->s_time_max = S64_MAX;
 		flags |= UFS_TYPE_UFS2 | UFS_DE_44BSD | UFS_UID_44BSD | UFS_ST_44BSD | UFS_CG_44BSD;
 		break;
 		
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index a14d11d78bd8..1a0daf46bae8 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1685,6 +1685,8 @@ xfs_fs_fill_super(
 	sb->s_maxbytes = xfs_max_file_offset(sb->s_blocksize_bits);
 	sb->s_max_links = XFS_MAXLINK;
 	sb->s_time_gran = 1;
+	sb->s_time_min = S32_MIN;
+	sb->s_time_max = S32_MAX;
 	set_posix_acl_flag(sb);
 
 	/* version 5 superblocks support inode version counters. */
-- 
2.17.1

