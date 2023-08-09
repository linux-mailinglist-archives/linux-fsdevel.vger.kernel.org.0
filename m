Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B406776BCD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 00:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbjHIWGD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 18:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjHIWF5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:05:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7985D1729;
        Wed,  9 Aug 2023 15:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Y8HEOWYHzd0yCITy4kwbsWwLvmGD2QTzJ/9iJjb6YmY=; b=j8bvS4sUYS4qUpAB/lm3BrTobv
        GCKVKIo1DSa+vFR/zC1mKEZfeYEVWdoVqWIj5g/k0oTmXbDAMVtSlJMeWld2t0e/5fQEMumsy0vgE
        pIpT8foOhWGfBycPltACrZpWCTGbzpMi2AMSRj1HhR57fGW9atqu0PRHuNGnEug3tXSQ73K0lMrgY
        2EcPaFysS/jvLG0ZPBBtvgYu0X9t02g+QJJdm6ZvvP0c8auU8PojpHZ9tnSrbUS9w4Vk711vuYM7B
        x9v4ZUn4UMXxeG34dr1aJ3E44ZYH9XYk3NWLEcjoa5h44rI3lewq6kYxPi/rYpKLSC13bo+PPsee7
        DlMzJwQQ==;
Received: from [4.28.11.157] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qTrJO-005xpD-3D;
        Wed, 09 Aug 2023 22:05:51 +0000
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
Date:   Wed,  9 Aug 2023 15:05:45 -0700
Message-Id: <20230809220545.1308228-14-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230809220545.1308228-1-hch@lst.de>
References: <20230809220545.1308228-1-hch@lst.de>
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
Reviewed-by: Christian Brauner <brauner@kernel.org>
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

