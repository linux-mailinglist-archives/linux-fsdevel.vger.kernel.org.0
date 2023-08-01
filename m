Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4404376B580
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 15:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbjHANKG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 09:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbjHANKE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:10:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFBDE9
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 06:10:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1F416159C
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 13:10:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96B0C433CA;
        Tue,  1 Aug 2023 13:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690895402;
        bh=wnpVcaWar0Rj0XtHf6shnc/tYSuVhZuk8fodfSttX50=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=PT2hTpS3aMAX4sQUAmzkP1W3m90Il+aDyJg2Rnzn+rco0CTGl53aDKaoeG7QUFx3R
         IXo6rqD9yVMi6ksUlubed92Wncz2QWa/8im+Ka+8ey5xQuQnk7uIzsjRauc9pe5xsl
         RrAFtzjOf2odWYFm+E+unEfzYIpEacqB0/pMNBxMbKAxHhLMlk+QHBFCWMFUeuCqpC
         UYX88xWCGWQVxBGaWDU+wOBXGzIhDhNXXlVNkbAxNQwVXHrhAXcplKzDWFW/+suEQu
         Fpzs/B6J8lVsLEnaWywmMUGUKADOD/FOo43iG0XnqaDRA+y3QcZDc7cBP0ivfNYrsi
         ggb/PX/1Jms/Q==
From:   Christian Brauner <brauner@kernel.org>
Date:   Tue, 01 Aug 2023 15:09:00 +0200
Subject: [PATCH RFC 1/3] super: remove get_tree_single_reconf()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230801-vfs-super-exclusive-v1-1-1a587e56c9f3@kernel.org>
References: <20230801-vfs-super-exclusive-v1-0-1a587e56c9f3@kernel.org>
In-Reply-To: <20230801-vfs-super-exclusive-v1-0-1a587e56c9f3@kernel.org>
To:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Karel Zak <kzak@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=3265; i=brauner@kernel.org;
 h=from:subject:message-id; bh=wnpVcaWar0Rj0XtHf6shnc/tYSuVhZuk8fodfSttX50=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaScZFFjXsOc8JT9SH/VifRnX4Rs9h8+/d9RVco+55/Y4qQt
 L/QedJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExEgI/hf8X5a5mznU6J33v56rSjjt
 kNxUS50xEntxvt9uOJM1i2p4+RYVOt86+1YuLrj69W0MmLuHTKfNct+zqBNB5+ndwL11RYGQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The get_tree_single_reconf() helper isn't used anywhere. Remote it.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/super.c                 | 34 ++++++++--------------------------
 include/linux/fs_context.h |  3 ---
 2 files changed, 8 insertions(+), 29 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 3ef39df5bec5..c086ce4929cd 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1136,10 +1136,10 @@ static int test_single_super(struct super_block *s, struct fs_context *fc)
 	return 1;
 }
 
-static int vfs_get_super(struct fs_context *fc, bool reconf,
-		int (*test)(struct super_block *, struct fs_context *),
-		int (*fill_super)(struct super_block *sb,
-				  struct fs_context *fc))
+static int vfs_get_super(struct fs_context *fc,
+			 int (*test)(struct super_block *, struct fs_context *),
+			 int (*fill_super)(struct super_block *sb,
+					   struct fs_context *fc))
 {
 	struct super_block *sb;
 	int err;
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

