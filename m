Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817FF76CC2A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 13:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbjHBL5Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 07:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234351AbjHBL5T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:57:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31AB272E
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 04:57:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF51A61932
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 11:57:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682B9C433C8;
        Wed,  2 Aug 2023 11:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690977436;
        bh=5vyOwxIioBJhGFwFBUPwJFcNXRe83e/NybIREoa9yyA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=atlnbfXPbIgdEvjDhn002o+v/RoQTMp5KbYB6+VuuprHPMVErb9m4O5q79evqUWVE
         u/Nvmi/JQRuVSe1ZsKBxrax6cHDIPhUz0xvnYugKklqfi5S0ZikRHLFoYKvYzTYkxn
         P1/Fcz3xhoNhLR7Q04POZs48ujfqSSB05iwZIbWYUyYVjgsVPCiQZMip0RB8BoBtc+
         1ALdUq+UE7BATESDRVX8xWMkDrHpH29PIVguXk0rXmYPD/JTqaKBWHUb+BbGGgMSv1
         7KiNXoTPDFwzslLsPaqgSNVhPJfw6b3BOCFtp8XSNV7cHpPwySwIsUSAHUyTyDx0cR
         Vo1IgIiQb+v0g==
From:   Christian Brauner <brauner@kernel.org>
Date:   Wed, 02 Aug 2023 13:57:03 +0200
Subject: [PATCH v2 1/4] super: remove get_tree_single_reconf()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230802-vfs-super-exclusive-v2-1-95dc4e41b870@kernel.org>
References: <20230802-vfs-super-exclusive-v2-0-95dc4e41b870@kernel.org>
In-Reply-To: <20230802-vfs-super-exclusive-v2-0-95dc4e41b870@kernel.org>
To:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Karel Zak <kzak@redhat.com>,
        linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=3119; i=brauner@kernel.org;
 h=from:subject:message-id; bh=5vyOwxIioBJhGFwFBUPwJFcNXRe83e/NybIREoa9yyA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSccpmeFP2LdaWmVMgFifn39+pf0828meJwovTZ/grLKNfZ
 3qx9HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNRm8LwP6lwucehF/lO7u0O0ssadT
 9M+VBaV6nl+U3NT7Zdmb+dlZHh0MaFVsr2X3tPPOm20P+ovFcrJXyjyX7dr8uj/WrZv/7lBAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The get_tree_single_reconf() helper isn't used anywhere. Remote it.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/super.c                 | 28 +++++-----------------------
 include/linux/fs_context.h |  3 ---
 2 files changed, 5 insertions(+), 26 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 3ef39df5bec5..9aaf0fbad036 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1136,7 +1136,7 @@ static int test_single_super(struct super_block *s, struct fs_context *fc)
 	return 1;
 }
 
-static int vfs_get_super(struct fs_context *fc, bool reconf,
+static int vfs_get_super(struct fs_context *fc,
 		int (*test)(struct super_block *, struct fs_context *),
 		int (*fill_super)(struct super_block *sb,
 				  struct fs_context *fc))
@@ -1154,19 +1154,9 @@ static int vfs_get_super(struct fs_context *fc, bool reconf,
 			goto error;
 
 		sb->s_flags |= SB_ACTIVE;
-		fc->root = dget(sb->s_root);
-	} else {
-		fc->root = dget(sb->s_root);
-		if (reconf) {
-			err = reconfigure_super(fc);
-			if (err < 0) {
-				dput(fc->root);
-				fc->root = NULL;
-				goto error;
-			}
-		}
 	}
 
+	fc->root = dget(sb->s_root);
 	return 0;
 
 error:
@@ -1178,7 +1168,7 @@ int get_tree_nodev(struct fs_context *fc,
 		  int (*fill_super)(struct super_block *sb,
 				    struct fs_context *fc))
 {
-	return vfs_get_super(fc, false, NULL, fill_super);
+	return vfs_get_super(fc, NULL, fill_super);
 }
 EXPORT_SYMBOL(get_tree_nodev);
 
@@ -1186,25 +1176,17 @@ int get_tree_single(struct fs_context *fc,
 		  int (*fill_super)(struct super_block *sb,
 				    struct fs_context *fc))
 {
-	return vfs_get_super(fc, false, test_single_super, fill_super);
+	return vfs_get_super(fc, test_single_super, fill_super);
 }
 EXPORT_SYMBOL(get_tree_single);
 
-int get_tree_single_reconf(struct fs_context *fc,
-		  int (*fill_super)(struct super_block *sb,
-				    struct fs_context *fc))
-{
-	return vfs_get_super(fc, true, test_single_super, fill_super);
-}
-EXPORT_SYMBOL(get_tree_single_reconf);
-
 int get_tree_keyed(struct fs_context *fc,
 		  int (*fill_super)(struct super_block *sb,
 				    struct fs_context *fc),
 		void *key)
 {
 	fc->s_fs_info = key;
-	return vfs_get_super(fc, false, test_keyed_super, fill_super);
+	return vfs_get_super(fc, test_keyed_super, fill_super);
 }
 EXPORT_SYMBOL(get_tree_keyed);
 
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index ff6341e09925..851b3fe2549c 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -150,9 +150,6 @@ extern int get_tree_nodev(struct fs_context *fc,
 extern int get_tree_single(struct fs_context *fc,
 			 int (*fill_super)(struct super_block *sb,
 					   struct fs_context *fc));
-extern int get_tree_single_reconf(struct fs_context *fc,
-			 int (*fill_super)(struct super_block *sb,
-					   struct fs_context *fc));
 extern int get_tree_keyed(struct fs_context *fc,
 			 int (*fill_super)(struct super_block *sb,
 					   struct fs_context *fc),

-- 
2.34.1

