Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECE16136CF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Oct 2022 13:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbiJaMqy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 08:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbiJaMqb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 08:46:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED0EDEDA
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Oct 2022 05:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=yZH2j+1r0KsFUp/MAnhNT1/f9uXU9sRLygwuwuRcj4M=; b=fLheFFL/ypZht6apTh4EWibofy
        2YLY8KqBHXb9tCMM7nAhcguUd/VJw6U/Dwas42subOUGgvzMmm9L5RNQoExobjqXm5LBeMejNW7rl
        DE+1cXo0rLZ9kdiwIx+JHkElSZruW7bBbHEFLT3wX4S+ZubLyA/oDQbOg588nIBCI4iKiFH9YkUlg
        TbK5s2k9MDkXWTMOAUD4a5zxumvTZvj7Q1+NhRPWx2bF59uHYt4qdzXOqaDNW49Bl+HtPLp9UmotP
        a3M1+Kriwz200fgQ9DJGaBfcJWkd1QhQujRWX+gPOcf1BntxwwMkMyg6EY+hO13+yFBWugGigzmRA
        eoiMMjkQ==;
Received: from [2001:4bb8:180:e42a:7f6e:c80d:ead7:d5da] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opUBR-00BpEM-IN; Mon, 31 Oct 2022 12:46:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs: simplify vfs_get_super
Date:   Mon, 31 Oct 2022 13:46:26 +0100
Message-Id: <20221031124626.381838-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove the pointless keying argument and associated enum and pass the
fill_super callback and a "bool reconf" instead.  Also mark the function
static given that there are no users outside of super.c.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/filesystems/mount_api.rst | 11 -----
 fs/super.c                              | 60 ++++---------------------
 include/linux/fs_context.h              | 14 ------
 3 files changed, 9 insertions(+), 76 deletions(-)

diff --git a/Documentation/filesystems/mount_api.rst b/Documentation/filesystems/mount_api.rst
index eb358a00be279..6114daf337978 100644
--- a/Documentation/filesystems/mount_api.rst
+++ b/Documentation/filesystems/mount_api.rst
@@ -562,17 +562,6 @@ or looking up of superblocks.
 
 The following helpers all wrap sget_fc():
 
-   * ::
-
-       int vfs_get_super(struct fs_context *fc,
-		         enum vfs_get_super_keying keying,
-		         int (*fill_super)(struct super_block *sb,
-					   struct fs_context *fc))
-
-     This creates/looks up a deviceless superblock.  The keying indicates how
-     many superblocks of this type may exist and in what manner they may be
-     shared:
-
 	(1) vfs_get_single_super
 
 	    Only one such superblock may exist in the system.  Any further
diff --git a/fs/super.c b/fs/super.c
index 8d39e4f11cfa3..12c08cb20405d 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1112,55 +1112,14 @@ static int test_single_super(struct super_block *s, struct fs_context *fc)
 	return 1;
 }
 
-/**
- * vfs_get_super - Get a superblock with a search key set in s_fs_info.
- * @fc: The filesystem context holding the parameters
- * @keying: How to distinguish superblocks
- * @fill_super: Helper to initialise a new superblock
- *
- * Search for a superblock and create a new one if not found.  The search
- * criterion is controlled by @keying.  If the search fails, a new superblock
- * is created and @fill_super() is called to initialise it.
- *
- * @keying can take one of a number of values:
- *
- * (1) vfs_get_single_super - Only one superblock of this type may exist on the
- *     system.  This is typically used for special system filesystems.
- *
- * (2) vfs_get_keyed_super - Multiple superblocks may exist, but they must have
- *     distinct keys (where the key is in s_fs_info).  Searching for the same
- *     key again will turn up the superblock for that key.
- *
- * (3) vfs_get_independent_super - Multiple superblocks may exist and are
- *     unkeyed.  Each call will get a new superblock.
- *
- * A permissions check is made by sget_fc() unless we're getting a superblock
- * for a kernel-internal mount or a submount.
- */
-int vfs_get_super(struct fs_context *fc,
-		  enum vfs_get_super_keying keying,
-		  int (*fill_super)(struct super_block *sb,
-				    struct fs_context *fc))
+static int vfs_get_super(struct fs_context *fc, bool reconf,
+		int (*test)(struct super_block *, struct fs_context *),
+		int (*fill_super)(struct super_block *sb,
+				  struct fs_context *fc))
 {
-	int (*test)(struct super_block *, struct fs_context *);
 	struct super_block *sb;
 	int err;
 
-	switch (keying) {
-	case vfs_get_single_super:
-	case vfs_get_single_reconf_super:
-		test = test_single_super;
-		break;
-	case vfs_get_keyed_super:
-		test = test_keyed_super;
-		break;
-	case vfs_get_independent_super:
-		test = NULL;
-		break;
-	default:
-		BUG();
-	}
-
 	sb = sget_fc(fc, test, set_anon_super_fc);
 	if (IS_ERR(sb))
 		return PTR_ERR(sb);
@@ -1174,7 +1133,7 @@ int vfs_get_super(struct fs_context *fc,
 		fc->root = dget(sb->s_root);
 	} else {
 		fc->root = dget(sb->s_root);
-		if (keying == vfs_get_single_reconf_super) {
+		if (reconf) {
 			err = reconfigure_super(fc);
 			if (err < 0) {
 				dput(fc->root);
@@ -1190,13 +1149,12 @@ int vfs_get_super(struct fs_context *fc,
 	deactivate_locked_super(sb);
 	return err;
 }
-EXPORT_SYMBOL(vfs_get_super);
 
 int get_tree_nodev(struct fs_context *fc,
 		  int (*fill_super)(struct super_block *sb,
 				    struct fs_context *fc))
 {
-	return vfs_get_super(fc, vfs_get_independent_super, fill_super);
+	return vfs_get_super(fc, false, NULL, fill_super);
 }
 EXPORT_SYMBOL(get_tree_nodev);
 
@@ -1204,7 +1162,7 @@ int get_tree_single(struct fs_context *fc,
 		  int (*fill_super)(struct super_block *sb,
 				    struct fs_context *fc))
 {
-	return vfs_get_super(fc, vfs_get_single_super, fill_super);
+	return vfs_get_super(fc, false, test_single_super, fill_super);
 }
 EXPORT_SYMBOL(get_tree_single);
 
@@ -1212,7 +1170,7 @@ int get_tree_single_reconf(struct fs_context *fc,
 		  int (*fill_super)(struct super_block *sb,
 				    struct fs_context *fc))
 {
-	return vfs_get_super(fc, vfs_get_single_reconf_super, fill_super);
+	return vfs_get_super(fc, true, test_single_super, fill_super);
 }
 EXPORT_SYMBOL(get_tree_single_reconf);
 
@@ -1222,7 +1180,7 @@ int get_tree_keyed(struct fs_context *fc,
 		void *key)
 {
 	fc->s_fs_info = key;
-	return vfs_get_super(fc, vfs_get_keyed_super, fill_super);
+	return vfs_get_super(fc, false, test_keyed_super, fill_super);
 }
 EXPORT_SYMBOL(get_tree_keyed);
 
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 13fa6f3df8e46..87a34f2fa68de 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -145,20 +145,6 @@ extern void fc_drop_locked(struct fs_context *fc);
 int reconfigure_single(struct super_block *s,
 		       int flags, void *data);
 
-/*
- * sget() wrappers to be called from the ->get_tree() op.
- */
-enum vfs_get_super_keying {
-	vfs_get_single_super,	/* Only one such superblock may exist */
-	vfs_get_single_reconf_super, /* As above, but reconfigure if it exists */
-	vfs_get_keyed_super,	/* Superblocks with different s_fs_info keys may exist */
-	vfs_get_independent_super, /* Multiple independent superblocks may exist */
-};
-extern int vfs_get_super(struct fs_context *fc,
-			 enum vfs_get_super_keying keying,
-			 int (*fill_super)(struct super_block *sb,
-					   struct fs_context *fc));
-
 extern int get_tree_nodev(struct fs_context *fc,
 			 int (*fill_super)(struct super_block *sb,
 					   struct fs_context *fc));
-- 
2.30.2

