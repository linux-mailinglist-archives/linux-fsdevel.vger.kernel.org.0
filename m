Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB3860CFB2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Oct 2022 16:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbiJYO5D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Oct 2022 10:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbiJYO4y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Oct 2022 10:56:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9131AC1DB;
        Tue, 25 Oct 2022 07:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1CzXyO7CuyV1gfLMYeF/4X2psNc4MKQOgtdQ6REO1y4=; b=lKoDj+GeEsAug+rqoIuL9PqhJY
        b5q2rJlxS5PuA/caZ5KttMzESQUvGjLzm2VvbPy0fukAhe4+lHrJCmAtl8g88nzxoymx+F0E7In6z
        h6aD7R1rtjW9xYX46HntGnT8r4pVkRn/I0Zc5PY4qb6+xDZ1HtBIlavsXORYNmgWQNJR6Rr48TZzI
        OG3JrFRhj1X04DOxCCH8gy3pyp6vGieeS5F6ocdyW/dFRHgefV5VtHplbOU5cvo6YVXi+e3y5B+hd
        gxQusoLF83GFG6PP1KUyvb7BpMzDsDmV1uBx9h1RZH9NVFAKkP+b3lLnDvqkisO/AjyQRY6lPfCxA
        RpqGJB3g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onLMB-005w4x-Ja; Tue, 25 Oct 2022 14:56:43 +0000
Date:   Tue, 25 Oct 2022 07:56:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Dawei Li <set_pte_at@outlook.com>, viro@zeniv.linux.org.uk,
        neilb@suse.de, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: Make vfs_get_super() internal
Message-ID: <Y1f5K6LKgD3hpkU/@infradead.org>
References: <TYCP286MB2323D37F4F6400FD07D7C7F7CA319@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
 <20221025143607.frmf3qg7j4kwezll@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025143607.frmf3qg7j4kwezll@wittgenstein>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 25, 2022 at 04:36:07PM +0200, Christian Brauner wrote:
> If you want to make it static that you should probably also make enum
> vfs_get_super_keying static by moving it into super.c. It's not used
> anywhere but for vfs_get_super() afaict.

I'd just remove the enum entirely, as it really obsfucates the code:

diff --git a/Documentation/filesystems/mount_api.rst b/Documentation/filesystems/mount_api.rst
index eb358a00be279..b0f7fd4f64bc8 100644
--- a/Documentation/filesystems/mount_api.rst
+++ b/Documentation/filesystems/mount_api.rst
@@ -560,37 +560,6 @@ or looking up of superblocks.
      to sb->s_fs_info - and fc->s_fs_info will be cleared if set returns
      success (ie. 0).
 
-The following helpers all wrap sget_fc():
-
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
-	(1) vfs_get_single_super
-
-	    Only one such superblock may exist in the system.  Any further
-	    attempt to get a new superblock gets this one (and any parameter
-	    differences are ignored).
-
-	(2) vfs_get_keyed_super
-
-	    Multiple superblocks of this type may exist and they're keyed on
-	    their s_fs_info pointer (for example this may refer to a
-	    namespace).
-
-	(3) vfs_get_independent_super
-
-	    Multiple independent superblocks of this type may exist.  This
-	    function never matches an existing one and always creates a new
-	    one.
-
 
 Parameter Description
 =====================
diff --git a/fs/super.c b/fs/super.c
index 6a82660e1adba..76f477c24c3d5 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1111,55 +1111,14 @@ static int test_single_super(struct super_block *s, struct fs_context *fc)
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
@@ -1173,7 +1132,7 @@ int vfs_get_super(struct fs_context *fc,
 		fc->root = dget(sb->s_root);
 	} else {
 		fc->root = dget(sb->s_root);
-		if (keying == vfs_get_single_reconf_super) {
+		if (reconf) {
 			err = reconfigure_super(fc);
 			if (err < 0) {
 				dput(fc->root);
@@ -1189,13 +1148,12 @@ int vfs_get_super(struct fs_context *fc,
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
 
@@ -1203,7 +1161,7 @@ int get_tree_single(struct fs_context *fc,
 		  int (*fill_super)(struct super_block *sb,
 				    struct fs_context *fc))
 {
-	return vfs_get_super(fc, vfs_get_single_super, fill_super);
+	return vfs_get_super(fc, false, test_single_super, fill_super);
 }
 EXPORT_SYMBOL(get_tree_single);
 
@@ -1211,7 +1169,7 @@ int get_tree_single_reconf(struct fs_context *fc,
 		  int (*fill_super)(struct super_block *sb,
 				    struct fs_context *fc))
 {
-	return vfs_get_super(fc, vfs_get_single_reconf_super, fill_super);
+	return vfs_get_super(fc, true, test_single_super, fill_super);
 }
 EXPORT_SYMBOL(get_tree_single_reconf);
 
@@ -1221,7 +1179,7 @@ int get_tree_keyed(struct fs_context *fc,
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
