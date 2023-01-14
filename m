Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D0966A79A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jan 2023 01:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjANAey (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 19:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjANAe0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 19:34:26 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609188A23D;
        Fri, 13 Jan 2023 16:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=7rKi7M9XeA7u/BSdnD6EYSAF+nkJ3hBQm4/7Xq4xJq0=; b=MWp/2mhiBI6iJXCiQzwVkKCytJ
        lA2Kzj+3t8CLt1BN05olQVxJ5NP3NTZaI4scHtp0LPS51FLLK+4u1tIXU3LcUONkX2GC4hEos6gkj
        txw5vsPmbsqf3DTwagKy5gjl+lXhdEYXK9Wid09YdQxjAh9NlwUKe4gRSY77ehFxicz0ITbyZpUV+
        qP84D5GWe4WdRggvZgtawBWd6ILP4C8nkzq2vN34Hqicbn4xuy9anWNlk/FFa7yhst/o6nZrUyW2O
        alPlKICOGMXS+WQRDB9JNFGYzBLsqaQKoRMXBOAZ7v+y39+HjcEBQDmrQZzGF7GFuzV7JSJfEOD/o
        2asCTbqA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGUUt-004twi-Vl; Sat, 14 Jan 2023 00:34:11 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hch@infradead.org, djwong@kernel.org, song@kernel.org,
        rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, bvanassche@acm.org,
        ebiederm@xmission.com
Cc:     mchehab@kernel.org, keescook@chromium.org, p.raghav@samsung.com,
        linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC v3 24/24] fs: remove FS_AUTOFREEZE
Date:   Fri, 13 Jan 2023 16:34:09 -0800
Message-Id: <20230114003409.1168311-25-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230114003409.1168311-1-mcgrof@kernel.org>
References: <20230114003409.1168311-1-mcgrof@kernel.org>
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

Now that all filesystems have been converted over to stop using the
kthread freezer APIs we can remove FS_AUTOFREEZE and its check.

The following Coccinelle rule was used as to remove the flag:

spatch --sp-file remove-fs-autofreezeflag.cocci --in-place --timeout 120 --dir fs/ --jobs 12 --use-gitgrep
@ rm_auto_flag @
expression E1;
identifier fs_type;
@@

struct file_system_type fs_type = {
	.fs_flags = E1
-                   | FS_AUTOFREEZE
	,
};

Generated-by: Coccinelle SmPL
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/btrfs/super.c     | 4 ++--
 fs/cifs/cifsfs.c     | 4 ++--
 fs/ecryptfs/main.c   | 2 +-
 fs/ext4/super.c      | 6 +++---
 fs/f2fs/super.c      | 2 +-
 fs/gfs2/ops_fstype.c | 4 ++--
 fs/jfs/super.c       | 2 +-
 fs/nfs/fs_context.c  | 4 ++--
 fs/super.c           | 2 --
 fs/xfs/xfs_super.c   | 2 +-
 include/linux/fs.h   | 1 -
 11 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 35059fe276ac..433ce221dc5c 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2138,7 +2138,7 @@ static struct file_system_type btrfs_fs_type = {
 	.name		= "btrfs",
 	.mount		= btrfs_mount,
 	.kill_sb	= btrfs_kill_super,
-	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA | FS_AUTOFREEZE,
+	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA,
 };
 
 static struct file_system_type btrfs_root_fs_type = {
@@ -2146,7 +2146,7 @@ static struct file_system_type btrfs_root_fs_type = {
 	.name		= "btrfs",
 	.mount		= btrfs_mount_root,
 	.kill_sb	= btrfs_kill_super,
-	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA | FS_ALLOW_IDMAP | FS_AUTOFREEZE,
+	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA | FS_ALLOW_IDMAP,
 };
 
 MODULE_ALIAS_FS("btrfs");
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 25ee05c8af65..1f7af4087b44 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1104,7 +1104,7 @@ struct file_system_type cifs_fs_type = {
 	.init_fs_context = smb3_init_fs_context,
 	.parameters = smb3_fs_parameters,
 	.kill_sb = cifs_kill_sb,
-	.fs_flags = FS_RENAME_DOES_D_MOVE | FS_AUTOFREEZE,
+	.fs_flags = FS_RENAME_DOES_D_MOVE,
 };
 MODULE_ALIAS_FS("cifs");
 
@@ -1114,7 +1114,7 @@ struct file_system_type smb3_fs_type = {
 	.init_fs_context = smb3_init_fs_context,
 	.parameters = smb3_fs_parameters,
 	.kill_sb = cifs_kill_sb,
-	.fs_flags = FS_RENAME_DOES_D_MOVE | FS_AUTOFREEZE,
+	.fs_flags = FS_RENAME_DOES_D_MOVE,
 };
 MODULE_ALIAS_FS("smb3");
 MODULE_ALIAS("smb3");
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index a91f5184edb7..2dc927ba067f 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -637,7 +637,7 @@ static struct file_system_type ecryptfs_fs_type = {
 	.name = "ecryptfs",
 	.mount = ecryptfs_mount,
 	.kill_sb = ecryptfs_kill_block_super,
-	.fs_flags = 0| FS_AUTOFREEZE
+	.fs_flags = 0
 };
 MODULE_ALIAS_FS("ecryptfs");
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 0ae6f13c7fa4..4c83eab8d769 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -136,7 +136,7 @@ static struct file_system_type ext2_fs_type = {
 	.init_fs_context	= ext4_init_fs_context,
 	.parameters		= ext4_param_specs,
 	.kill_sb		= kill_block_super,
-	.fs_flags		= FS_REQUIRES_DEV | FS_AUTOFREEZE,
+	.fs_flags		= FS_REQUIRES_DEV,
 };
 MODULE_ALIAS_FS("ext2");
 MODULE_ALIAS("ext2");
@@ -152,7 +152,7 @@ static struct file_system_type ext3_fs_type = {
 	.init_fs_context	= ext4_init_fs_context,
 	.parameters		= ext4_param_specs,
 	.kill_sb		= kill_block_super,
-	.fs_flags		= FS_REQUIRES_DEV | FS_AUTOFREEZE,
+	.fs_flags		= FS_REQUIRES_DEV,
 };
 MODULE_ALIAS_FS("ext3");
 MODULE_ALIAS("ext3");
@@ -7189,7 +7189,7 @@ static struct file_system_type ext4_fs_type = {
 	.init_fs_context	= ext4_init_fs_context,
 	.parameters		= ext4_param_specs,
 	.kill_sb		= kill_block_super,
-	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_AUTOFREEZE,
+	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
 };
 MODULE_ALIAS_FS("ext4");
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index e9c6fb04c713..87d56a9883e6 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4645,7 +4645,7 @@ static struct file_system_type f2fs_fs_type = {
 	.name		= "f2fs",
 	.mount		= f2fs_mount,
 	.kill_sb	= kill_f2fs_super,
-	.fs_flags	= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_AUTOFREEZE,
+	.fs_flags	= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
 };
 MODULE_ALIAS_FS("f2fs");
 
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 8f5a63148eaf..c0cf1d2d0ef5 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1740,7 +1740,7 @@ static void gfs2_kill_sb(struct super_block *sb)
 
 struct file_system_type gfs2_fs_type = {
 	.name = "gfs2",
-	.fs_flags = FS_REQUIRES_DEV | FS_AUTOFREEZE,
+	.fs_flags = FS_REQUIRES_DEV,
 	.init_fs_context = gfs2_init_fs_context,
 	.parameters = gfs2_fs_parameters,
 	.kill_sb = gfs2_kill_sb,
@@ -1750,7 +1750,7 @@ MODULE_ALIAS_FS("gfs2");
 
 struct file_system_type gfs2meta_fs_type = {
 	.name = "gfs2meta",
-	.fs_flags = FS_REQUIRES_DEV | FS_AUTOFREEZE,
+	.fs_flags = FS_REQUIRES_DEV,
 	.init_fs_context = gfs2_meta_init_fs_context,
 	.owner = THIS_MODULE,
 };
diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index 8ca77aa0b6f9..d2f82cb7db1b 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -906,7 +906,7 @@ static struct file_system_type jfs_fs_type = {
 	.name		= "jfs",
 	.mount		= jfs_do_mount,
 	.kill_sb	= kill_block_super,
-	.fs_flags	= FS_REQUIRES_DEV | FS_AUTOFREEZE,
+	.fs_flags	= FS_REQUIRES_DEV,
 };
 MODULE_ALIAS_FS("jfs");
 
diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 04753962db9a..9bcd53d5c7d4 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -1583,7 +1583,7 @@ struct file_system_type nfs_fs_type = {
 	.init_fs_context	= nfs_init_fs_context,
 	.parameters		= nfs_fs_parameters,
 	.kill_sb		= nfs_kill_super,
-	.fs_flags		= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA | FS_AUTOFREEZE,
+	.fs_flags		= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
 };
 MODULE_ALIAS_FS("nfs");
 EXPORT_SYMBOL_GPL(nfs_fs_type);
@@ -1595,7 +1595,7 @@ struct file_system_type nfs4_fs_type = {
 	.init_fs_context	= nfs_init_fs_context,
 	.parameters		= nfs_fs_parameters,
 	.kill_sb		= nfs_kill_super,
-	.fs_flags		= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA | FS_AUTOFREEZE,
+	.fs_flags		= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
 };
 MODULE_ALIAS_FS("nfs4");
 MODULE_ALIAS("nfs4");
diff --git a/fs/super.c b/fs/super.c
index e8af4c8269ad..2943157aa41c 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1857,8 +1857,6 @@ EXPORT_SYMBOL(thaw_super);
 #ifdef CONFIG_PM_SLEEP
 static bool super_should_freeze(struct super_block *sb)
 {
-	if (!(sb->s_type->fs_flags & FS_AUTOFREEZE))
-		return false;
 	/*
 	 * We don't freeze virtual filesystems, we skip those filesystems with
 	 * no backing device.
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 54cbf15fc459..e71e69895a94 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1966,7 +1966,7 @@ static struct file_system_type xfs_fs_type = {
 	.init_fs_context	= xfs_init_fs_context,
 	.parameters		= xfs_fs_parameters,
 	.kill_sb		= kill_block_super,
-	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_AUTOFREEZE,
+	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
 };
 MODULE_ALIAS_FS("xfs");
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e5bee359e804..64b0ed66e87f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2231,7 +2231,6 @@ struct file_system_type {
 #define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
 #define FS_ALLOW_IDMAP         32      /* FS has been updated to handle vfs idmappings. */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
-#define FS_AUTOFREEZE           (1<<16)	/*  temporary as we phase kthread freezer out */
 	int (*init_fs_context)(struct fs_context *);
 	const struct fs_parameter_spec *parameters;
 	struct dentry *(*mount) (struct file_system_type *, int,
-- 
2.35.1

