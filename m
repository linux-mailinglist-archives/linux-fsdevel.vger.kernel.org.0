Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A60774C30
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 23:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbjHHVD0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 17:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235282AbjHHVDM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:03:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4865FA9B;
        Tue,  8 Aug 2023 11:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=KcOpoqbZgkJsyfWlcpWY5JHgObXtvv0somhVOIZQD4w=; b=Aq9z3o3XGi9OLoFG7ORcEkpiZV
        zNBw01/HJOmn6epF3CLZolAD6+cPRIbjA38cUsd5BM5UDqqZlCDQ4Nt8rjUtJSq4nhKXmVihmBEgA
        Q5pLMVqVNPX07YFeyXqxksHTylsr6iVy80QFDF62ReFibCUCMy3/u9njwwcGHTS7C5zKbtgH1kFoO
        QHNhXqF6nGzEONUlWDZYbiosx+IseNoL47W7tYD2fGk36F7LE4vE7ukOQzYfkuE6y1A/yjqPLs2sz
        x+JU3WlpyNDV36Gaz0RInOlo5OjcKuIJlwAzodbZWkMDv8p49L/JcWwGCE95NOdHUUnKDqrkDByr2
        GXztsAdQ==;
Received: from [4.28.11.157] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qTPNN-002vg3-2M;
        Tue, 08 Aug 2023 16:16:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: [PATCH 13/13] ntfs3: free the sbi in ->kill_sb
Date:   Tue,  8 Aug 2023 09:16:00 -0700
Message-Id: <20230808161600.1099516-14-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230808161600.1099516-1-hch@lst.de>
References: <20230808161600.1099516-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As a rule of thumb everything allocated to the fs_context and moved into
the super_block should be freed by ->kill_sb so that the teardown
handling doesn't need to be duplicated between the fill_super error
path and put_super.  Implement an ntfs3-specific kill_sb method to do
that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ntfs3/super.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 727138933a9324..5fffddea554f18 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -625,10 +625,6 @@ static void ntfs_put_super(struct super_block *sb)
 
 	/* Mark rw ntfs as clear, if possible. */
 	ntfs_set_state(sbi, NTFS_DIRTY_CLEAR);
-
-	put_mount_options(sbi->options);
-	ntfs3_free_sbi(sbi);
-	sb->s_fs_info = NULL;
 }
 
 static int ntfs_statfs(struct dentry *dentry, struct kstatfs *buf)
@@ -1562,15 +1558,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 put_inode_out:
 	iput(inode);
 out:
-	/*
-	 * Free resources here.
-	 * ntfs_fs_free will be called with fc->s_fs_info = NULL
-	 */
-	put_mount_options(sbi->options);
-	ntfs3_free_sbi(sbi);
-	sb->s_fs_info = NULL;
 	kfree(boot2);
-
 	return err;
 }
 
@@ -1726,13 +1714,24 @@ static int ntfs_init_fs_context(struct fs_context *fc)
 	return -ENOMEM;
 }
 
+static void ntfs3_kill_sb(struct super_block *sb)
+{
+	struct ntfs_sb_info *sbi = sb->s_fs_info;
+
+	kill_block_super(sb);
+
+	if (sbi->options)
+		put_mount_options(sbi->options);
+	ntfs3_free_sbi(sbi);
+}
+
 // clang-format off
 static struct file_system_type ntfs_fs_type = {
 	.owner			= THIS_MODULE,
 	.name			= "ntfs3",
 	.init_fs_context	= ntfs_init_fs_context,
 	.parameters		= ntfs_fs_parameters,
-	.kill_sb		= kill_block_super,
+	.kill_sb		= ntfs3_kill_sb,
 	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
 };
 // clang-format on
-- 
2.39.2

