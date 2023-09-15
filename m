Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44447A298B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 23:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237834AbjIOVdc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 17:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237756AbjIOVdP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 17:33:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1FF197;
        Fri, 15 Sep 2023 14:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=tAHuZOTRnJkuAieR6OQU11hxZjIemhP5K5oO05h360E=; b=k1J5RsdsGwRvjm0rSSOFEnoVKZ
        uAidGm/Nh4/fnxXdDaj9BuBFL+fyFphAjuYXfUD3YUn9NM4jzz6HSyBmITkl2PaCf/7OJq0AfbvUS
        Sp2ErZ0Fe6eErMLGuvRZF7wbAW/XQXIE5LDJGdDrqbNy91/LUocM18NcAZHQJ2f2MVHq+3o7D2Djr
        zJulmaozeTK++xfokkoo4a63a+WYesGZ8ANM4E7sBvazvoSDDsPaBG8NRgYD+5+d4hBSqTJfuuMZ0
        jYjkuwyatKrpmMMs01Xafjr6yadQZOhIW3LNIJVmV9r7cUUpfVE3Vr4T3Bc39VIQElJgmUzGGveOz
        W3uPNhIg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qhGQq-00BQnQ-0o;
        Fri, 15 Sep 2023 21:32:56 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hch@infradead.org, djwong@kernel.org, dchinner@redhat.com,
        kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com
Cc:     willy@infradead.org, brauner@kernel.org, hare@suse.de,
        ritesh.list@gmail.com, rgoldwyn@suse.com, jack@suse.cz,
        ziy@nvidia.com, ryan.roberts@arm.com, patches@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, p.raghav@samsung.com,
        da.gomez@samsung.com, dan.helmick@samsung.com, mcgrof@kernel.org
Subject: [RFC v2 04/10] filesystems: add filesytem buffer-head flag
Date:   Fri, 15 Sep 2023 14:32:48 -0700
Message-Id: <20230915213254.2724586-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230915213254.2724586-1-mcgrof@kernel.org>
References: <20230915213254.2724586-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/adfs/super.c          | 2 +-
 fs/affs/super.c          | 2 +-
 fs/befs/linuxvfs.c       | 2 +-
 fs/bfs/inode.c           | 2 +-
 fs/efs/super.c           | 2 +-
 fs/exfat/super.c         | 2 +-
 fs/ext2/super.c          | 2 +-
 fs/ext4/super.c          | 7 ++++---
 fs/f2fs/super.c          | 2 +-
 fs/fat/namei_msdos.c     | 2 +-
 fs/fat/namei_vfat.c      | 2 +-
 fs/freevxfs/vxfs_super.c | 2 +-
 fs/gfs2/ops_fstype.c     | 4 ++--
 fs/hfs/super.c           | 2 +-
 fs/hfsplus/super.c       | 2 +-
 fs/isofs/inode.c         | 2 +-
 fs/jfs/super.c           | 2 +-
 fs/minix/inode.c         | 2 +-
 fs/nilfs2/super.c        | 2 +-
 fs/ntfs/super.c          | 2 +-
 fs/ntfs3/super.c         | 2 +-
 fs/ocfs2/super.c         | 2 +-
 fs/omfs/inode.c          | 2 +-
 fs/qnx4/inode.c          | 2 +-
 fs/qnx6/inode.c          | 2 +-
 fs/reiserfs/super.c      | 2 +-
 fs/sysv/super.c          | 4 ++--
 fs/udf/super.c           | 2 +-
 fs/ufs/super.c           | 2 +-
 include/linux/fs.h       | 1 +
 30 files changed, 35 insertions(+), 33 deletions(-)

diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index e8bfc38239cd..7c57fff29bb4 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -464,7 +464,7 @@ static struct file_system_type adfs_fs_type = {
 	.name		= "adfs",
 	.mount		= adfs_mount,
 	.kill_sb	= kill_block_super,
-	.fs_flags	= FS_REQUIRES_DEV,
+	.fs_flags	= FS_REQUIRES_DEV | FS_BUFFER_HEADS,
 };
 MODULE_ALIAS_FS("adfs");
 
diff --git a/fs/affs/super.c b/fs/affs/super.c
index 58b391446ae1..2dc200010740 100644
--- a/fs/affs/super.c
+++ b/fs/affs/super.c
@@ -649,7 +649,7 @@ static struct file_system_type affs_fs_type = {
 	.name		= "affs",
 	.mount		= affs_mount,
 	.kill_sb	= affs_kill_sb,
-	.fs_flags	= FS_REQUIRES_DEV,
+	.fs_flags	= FS_REQUIRES_DEV | FS_BUFFER_HEADS,
 };
 MODULE_ALIAS_FS("affs");
 
diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index 9a16a51fbb88..64715f554034 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -982,7 +982,7 @@ static struct file_system_type befs_fs_type = {
 	.name		= "befs",
 	.mount		= befs_mount,
 	.kill_sb	= kill_block_super,
-	.fs_flags	= FS_REQUIRES_DEV,
+	.fs_flags	= FS_REQUIRES_DEV | FS_BUFFER_HEADS,
 };
 MODULE_ALIAS_FS("befs");
 
diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
index e6a76ae9eb44..e94d7c92b591 100644
--- a/fs/bfs/inode.c
+++ b/fs/bfs/inode.c
@@ -459,7 +459,7 @@ static struct file_system_type bfs_fs_type = {
 	.name		= "bfs",
 	.mount		= bfs_mount,
 	.kill_sb	= kill_block_super,
-	.fs_flags	= FS_REQUIRES_DEV,
+	.fs_flags	= FS_REQUIRES_DEV | FS_BUFFER_HEADS,
 };
 MODULE_ALIAS_FS("bfs");
 
diff --git a/fs/efs/super.c b/fs/efs/super.c
index b287f47c165b..35891a596267 100644
--- a/fs/efs/super.c
+++ b/fs/efs/super.c
@@ -40,7 +40,7 @@ static struct file_system_type efs_fs_type = {
 	.name		= "efs",
 	.mount		= efs_mount,
 	.kill_sb	= efs_kill_sb,
-	.fs_flags	= FS_REQUIRES_DEV,
+	.fs_flags	= FS_REQUIRES_DEV | FS_BUFFER_HEADS,
 };
 MODULE_ALIAS_FS("efs");
 
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 17100b13dcdc..fbc2aa45d291 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -786,7 +786,7 @@ static struct file_system_type exfat_fs_type = {
 	.init_fs_context	= exfat_init_fs_context,
 	.parameters		= exfat_parameters,
 	.kill_sb		= exfat_kill_sb,
-	.fs_flags		= FS_REQUIRES_DEV,
+	.fs_flags		= FS_REQUIRES_DEV | FS_BUFFER_HEADS,
 };
 
 static void exfat_inode_init_once(void *foo)
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index aaf3e3e88cb2..ca2c44ca2c29 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -1629,7 +1629,7 @@ static struct file_system_type ext2_fs_type = {
 	.name		= "ext2",
 	.mount		= ext2_mount,
 	.kill_sb	= kill_block_super,
-	.fs_flags	= FS_REQUIRES_DEV,
+	.fs_flags	= FS_REQUIRES_DEV | FS_BUFFER_HEADS,
 };
 MODULE_ALIAS_FS("ext2");
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 38217422f938..b7fab39cd1ca 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -137,7 +137,7 @@ static struct file_system_type ext2_fs_type = {
 	.init_fs_context	= ext4_init_fs_context,
 	.parameters		= ext4_param_specs,
 	.kill_sb		= ext4_kill_sb,
-	.fs_flags		= FS_REQUIRES_DEV,
+	.fs_flags		= FS_REQUIRES_DEV | FS_BUFFER_HEADS,
 };
 MODULE_ALIAS_FS("ext2");
 MODULE_ALIAS("ext2");
@@ -153,7 +153,7 @@ static struct file_system_type ext3_fs_type = {
 	.init_fs_context	= ext4_init_fs_context,
 	.parameters		= ext4_param_specs,
 	.kill_sb		= ext4_kill_sb,
-	.fs_flags		= FS_REQUIRES_DEV,
+	.fs_flags		= FS_REQUIRES_DEV | FS_BUFFER_HEADS,
 };
 MODULE_ALIAS_FS("ext3");
 MODULE_ALIAS("ext3");
@@ -7314,7 +7314,8 @@ static struct file_system_type ext4_fs_type = {
 	.init_fs_context	= ext4_init_fs_context,
 	.parameters		= ext4_param_specs,
 	.kill_sb		= ext4_kill_sb,
-	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME,
+	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME |
+				  FS_BUFFER_HEADS,
 };
 MODULE_ALIAS_FS("ext4");
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index fe25ff9cebbe..6ffc7a4d57d8 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4903,7 +4903,7 @@ static struct file_system_type f2fs_fs_type = {
 	.name		= "f2fs",
 	.mount		= f2fs_mount,
 	.kill_sb	= kill_f2fs_super,
-	.fs_flags	= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
+	.fs_flags	= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_BUFFER_HEADS,
 };
 MODULE_ALIAS_FS("f2fs");
 
diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
index 2116c486843b..785ee85cf77d 100644
--- a/fs/fat/namei_msdos.c
+++ b/fs/fat/namei_msdos.c
@@ -667,7 +667,7 @@ static struct file_system_type msdos_fs_type = {
 	.name		= "msdos",
 	.mount		= msdos_mount,
 	.kill_sb	= kill_block_super,
-	.fs_flags	= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
+	.fs_flags	= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_BUFFER_HEADS,
 };
 MODULE_ALIAS_FS("msdos");
 
diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index c4d00999a433..4fe85c569543 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -1212,7 +1212,7 @@ static struct file_system_type vfat_fs_type = {
 	.name		= "vfat",
 	.mount		= vfat_mount,
 	.kill_sb	= kill_block_super,
-	.fs_flags	= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
+	.fs_flags	= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_BUFFER_HEADS,
 };
 MODULE_ALIAS_FS("vfat");
 
diff --git a/fs/freevxfs/vxfs_super.c b/fs/freevxfs/vxfs_super.c
index 310d73e254df..d1e042784694 100644
--- a/fs/freevxfs/vxfs_super.c
+++ b/fs/freevxfs/vxfs_super.c
@@ -293,7 +293,7 @@ static struct file_system_type vxfs_fs_type = {
 	.name		= "vxfs",
 	.mount		= vxfs_mount,
 	.kill_sb	= kill_block_super,
-	.fs_flags	= FS_REQUIRES_DEV,
+	.fs_flags	= FS_REQUIRES_DEV | FS_BUFFER_HEADS,
 };
 MODULE_ALIAS_FS("vxfs"); /* makes mount -t vxfs autoload the module */
 MODULE_ALIAS("vxfs");
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index ecf789b7168c..f97d8480e665 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1810,7 +1810,7 @@ static void gfs2_kill_sb(struct super_block *sb)
 
 struct file_system_type gfs2_fs_type = {
 	.name = "gfs2",
-	.fs_flags = FS_REQUIRES_DEV,
+	.fs_flags = FS_REQUIRES_DEV | FS_BUFFER_HEADS,
 	.init_fs_context = gfs2_init_fs_context,
 	.parameters = gfs2_fs_parameters,
 	.kill_sb = gfs2_kill_sb,
@@ -1820,7 +1820,7 @@ MODULE_ALIAS_FS("gfs2");
 
 struct file_system_type gfs2meta_fs_type = {
 	.name = "gfs2meta",
-	.fs_flags = FS_REQUIRES_DEV,
+	.fs_flags = FS_REQUIRES_DEV | FS_BUFFER_HEADS,
 	.init_fs_context = gfs2_meta_init_fs_context,
 	.owner = THIS_MODULE,
 };
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index 6764afa98a6f..1b31b8e2b7ef 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -461,7 +461,7 @@ static struct file_system_type hfs_fs_type = {
 	.name		= "hfs",
 	.mount		= hfs_mount,
 	.kill_sb	= kill_block_super,
-	.fs_flags	= FS_REQUIRES_DEV,
+	.fs_flags	= FS_REQUIRES_DEV | FS_BUFFER_HEADS,
 };
 MODULE_ALIAS_FS("hfs");
 
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 1986b4f18a90..efc12ff05e0f 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -646,7 +646,7 @@ static struct file_system_type hfsplus_fs_type = {
 	.name		= "hfsplus",
 	.mount		= hfsplus_mount,
 	.kill_sb	= kill_block_super,
-	.fs_flags	= FS_REQUIRES_DEV,
+	.fs_flags	= FS_REQUIRES_DEV | FS_BUFFER_HEADS,
 };
 MODULE_ALIAS_FS("hfsplus");
 
diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 2ee21286ac8f..96d5b4dfec12 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -1564,7 +1564,7 @@ static struct file_system_type iso9660_fs_type = {
 	.name		= "iso9660",
 	.mount		= isofs_mount,
 	.kill_sb	= kill_block_super,
-	.fs_flags	= FS_REQUIRES_DEV,
+	.fs_flags	= FS_REQUIRES_DEV | FS_BUFFER_HEADS,
 };
 MODULE_ALIAS_FS("iso9660");
 MODULE_ALIAS("iso9660");
diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index 2e2f7f6d36a0..052c277eab9f 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -906,7 +906,7 @@ static struct file_system_type jfs_fs_type = {
 	.name		= "jfs",
 	.mount		= jfs_do_mount,
 	.kill_sb	= kill_block_super,
-	.fs_flags	= FS_REQUIRES_DEV,
+	.fs_flags	= FS_REQUIRES_DEV | FS_BUFFER_HEADS,
 };
 MODULE_ALIAS_FS("jfs");
 
diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index df575473c1cc..ae2bbb610603 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -689,7 +689,7 @@ static struct file_system_type minix_fs_type = {
 	.name		= "minix",
 	.mount		= minix_mount,
 	.kill_sb	= kill_block_super,
-	.fs_flags	= FS_REQUIRES_DEV,
+	.fs_flags	= FS_REQUIRES_DEV | FS_BUFFER_HEADS,
 };
 MODULE_ALIAS_FS("minix");
 
diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
index a5d1fa4e7552..8e3737a3302a 100644
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -1371,7 +1371,7 @@ struct file_system_type nilfs_fs_type = {
 	.name     = "nilfs2",
 	.mount    = nilfs_mount,
 	.kill_sb  = kill_block_super,
-	.fs_flags = FS_REQUIRES_DEV,
+	.fs_flags = FS_REQUIRES_DEV | FS_BUFFER_HEADS,
 };
 MODULE_ALIAS_FS("nilfs2");
 
diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 56a7d5bd33e4..eb9e434b6541 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -3062,7 +3062,7 @@ static struct file_system_type ntfs_fs_type = {
 	.name		= "ntfs",
 	.mount		= ntfs_mount,
 	.kill_sb	= kill_block_super,
-	.fs_flags	= FS_REQUIRES_DEV,
+	.fs_flags	= FS_REQUIRES_DEV | FS_BUFFER_HEADS,
 };
 MODULE_ALIAS_FS("ntfs");
 
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index cfec5e0c7f66..40f09d5159d2 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1738,7 +1738,7 @@ static struct file_system_type ntfs_fs_type = {
 	.init_fs_context	= ntfs_init_fs_context,
 	.parameters		= ntfs_fs_parameters,
 	.kill_sb		= ntfs3_kill_sb,
-	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
+	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_BUFFER_HEADS,
 };
 // clang-format on
 
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 6b906424902b..50d5be9fb28f 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -1191,7 +1191,7 @@ static struct file_system_type ocfs2_fs_type = {
 	.name           = "ocfs2",
 	.mount          = ocfs2_mount,
 	.kill_sb        = kill_block_super,
-	.fs_flags       = FS_REQUIRES_DEV|FS_RENAME_DOES_D_MOVE,
+	.fs_flags       = FS_REQUIRES_DEV|FS_RENAME_DOES_D_MOVE | FS_BUFFER_HEADS,
 	.next           = NULL
 };
 MODULE_ALIAS_FS("ocfs2");
diff --git a/fs/omfs/inode.c b/fs/omfs/inode.c
index 2f8c1882f45c..e95b7d91fe35 100644
--- a/fs/omfs/inode.c
+++ b/fs/omfs/inode.c
@@ -607,7 +607,7 @@ static struct file_system_type omfs_fs_type = {
 	.name = "omfs",
 	.mount = omfs_mount,
 	.kill_sb = kill_block_super,
-	.fs_flags = FS_REQUIRES_DEV,
+	.fs_flags = FS_REQUIRES_DEV | FS_BUFFER_HEADS,
 };
 MODULE_ALIAS_FS("omfs");
 
diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
index a7171f5532a1..4f66b93397d7 100644
--- a/fs/qnx4/inode.c
+++ b/fs/qnx4/inode.c
@@ -389,7 +389,7 @@ static struct file_system_type qnx4_fs_type = {
 	.name		= "qnx4",
 	.mount		= qnx4_mount,
 	.kill_sb	= qnx4_kill_sb,
-	.fs_flags	= FS_REQUIRES_DEV,
+	.fs_flags	= FS_REQUIRES_DEV | FS_BUFFER_HEADS,
 };
 MODULE_ALIAS_FS("qnx4");
 
diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index 21f90d519f1a..68f650d67d3b 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -645,7 +645,7 @@ static struct file_system_type qnx6_fs_type = {
 	.name		= "qnx6",
 	.mount		= qnx6_mount,
 	.kill_sb	= kill_block_super,
-	.fs_flags	= FS_REQUIRES_DEV,
+	.fs_flags	= FS_REQUIRES_DEV | FS_BUFFER_HEADS,
 };
 MODULE_ALIAS_FS("qnx6");
 
diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
index 7eaf36b3de12..838046f43d11 100644
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -2635,7 +2635,7 @@ struct file_system_type reiserfs_fs_type = {
 	.name = "reiserfs",
 	.mount = get_super_block,
 	.kill_sb = reiserfs_kill_sb,
-	.fs_flags = FS_REQUIRES_DEV,
+	.fs_flags = FS_REQUIRES_DEV | FS_BUFFER_HEADS,
 };
 MODULE_ALIAS_FS("reiserfs");
 
diff --git a/fs/sysv/super.c b/fs/sysv/super.c
index 3365a30dc1e0..92f08cb24a28 100644
--- a/fs/sysv/super.c
+++ b/fs/sysv/super.c
@@ -545,7 +545,7 @@ static struct file_system_type sysv_fs_type = {
 	.name		= "sysv",
 	.mount		= sysv_mount,
 	.kill_sb	= kill_block_super,
-	.fs_flags	= FS_REQUIRES_DEV,
+	.fs_flags	= FS_REQUIRES_DEV | FS_BUFFER_HEADS,
 };
 MODULE_ALIAS_FS("sysv");
 
@@ -554,7 +554,7 @@ static struct file_system_type v7_fs_type = {
 	.name		= "v7",
 	.mount		= v7_mount,
 	.kill_sb	= kill_block_super,
-	.fs_flags	= FS_REQUIRES_DEV,
+	.fs_flags	= FS_REQUIRES_DEV | FS_BUFFER_HEADS,
 };
 MODULE_ALIAS_FS("v7");
 MODULE_ALIAS("v7");
diff --git a/fs/udf/super.c b/fs/udf/super.c
index 928a04d9d9e0..9f160973cbe8 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -130,7 +130,7 @@ static struct file_system_type udf_fstype = {
 	.name		= "udf",
 	.mount		= udf_mount,
 	.kill_sb	= kill_block_super,
-	.fs_flags	= FS_REQUIRES_DEV,
+	.fs_flags	= FS_REQUIRES_DEV | FS_BUFFER_HEADS,
 };
 MODULE_ALIAS_FS("udf");
 
diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index 23377c1baed9..7829c325d011 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -1513,7 +1513,7 @@ static struct file_system_type ufs_fs_type = {
 	.name		= "ufs",
 	.mount		= ufs_mount,
 	.kill_sb	= kill_block_super,
-	.fs_flags	= FS_REQUIRES_DEV,
+	.fs_flags	= FS_REQUIRES_DEV | FS_BUFFER_HEADS,
 };
 MODULE_ALIAS_FS("ufs");
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ebc7b8ac5008..35b661b48a49 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2336,6 +2336,7 @@ struct file_system_type {
 #define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
 #define FS_ALLOW_IDMAP         32      /* FS has been updated to handle vfs idmappings. */
 #define FS_MGTIME		64	/* FS uses multigrain timestamps */
+#define FS_BUFFER_HEADS		128	/* filesystem requires buffer-heads */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
 	int (*init_fs_context)(struct fs_context *);
 	const struct fs_parameter_spec *parameters;
-- 
2.39.2

