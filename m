Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0103F776BD7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 00:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbjHIWGH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 18:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbjHIWF4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:05:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B78A2129;
        Wed,  9 Aug 2023 15:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=lMZjGmk9h743/vCRz7ALqu87zkGuLF1PQOhL9ZSvlGg=; b=tnrx0od2PPpPNGOaV4Ve/AcK1M
        w85KS5B58iDdykHgWLGwQ0KyY0o1oRcXDh8ECQZMl9ZtqTDzwdijgqPzZBB9J+85k6ytYfxBN5b7B
        H5c6zs+axAN3mQqy39Q5hTMxhJ/4HMALSz8W1JcOF5E2THK/TFtihDho8ZjrimIFBOK5MNB1TXpeI
        zYXXQYMUvyBgyvWxDe6BMqO37P2CMZfxPgwwz2yK0w9sDdjBJetWTO3NrWPMpEOeAkVXhhYNEbg4i
        Q1HgSLoo3PQLdMzle7MMMjt9H4typ+uUCdKztMFchLqYfjOCYyhR7FuLxBd9JbQ2fEZv899/fImcl
        d686xyzw==;
Received: from [4.28.11.157] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qTrJN-005xoc-1X;
        Wed, 09 Aug 2023 22:05:49 +0000
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
Subject: [PATCH 10/13] exfat: free the sbi and iocharset in ->kill_sb
Date:   Wed,  9 Aug 2023 15:05:42 -0700
Message-Id: <20230809220545.1308228-11-hch@lst.de>
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
path and put_super.  Implement an exfat-specific kill_sb method to do
that and share the code with the mount contex free helper for the
mount error handling case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/exfat/super.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 3c6aec96d0dc85..85b04a4064af1e 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -41,9 +41,7 @@ static void exfat_put_super(struct super_block *sb)
 	mutex_unlock(&sbi->s_lock);
 
 	unload_nls(sbi->nls_io);
-	exfat_free_iocharset(sbi);
 	exfat_free_upcase_table(sbi);
-	kfree(sbi);
 }
 
 static int exfat_sync_fs(struct super_block *sb, int wait)
@@ -703,9 +701,6 @@ static int exfat_fill_super(struct super_block *sb, struct fs_context *fc)
 
 check_nls_io:
 	unload_nls(sbi->nls_io);
-	exfat_free_iocharset(sbi);
-	sb->s_fs_info = NULL;
-	kfree(sbi);
 	return err;
 }
 
@@ -714,14 +709,18 @@ static int exfat_get_tree(struct fs_context *fc)
 	return get_tree_bdev(fc, exfat_fill_super);
 }
 
+static void exfat_free_sbi(struct exfat_sb_info *sbi)
+{
+	exfat_free_iocharset(sbi);
+	kfree(sbi);
+}
+
 static void exfat_free(struct fs_context *fc)
 {
 	struct exfat_sb_info *sbi = fc->s_fs_info;
 
-	if (sbi) {
-		exfat_free_iocharset(sbi);
-		kfree(sbi);
-	}
+	if (sbi)
+		exfat_free_sbi(sbi);
 }
 
 static int exfat_reconfigure(struct fs_context *fc)
@@ -766,12 +765,21 @@ static int exfat_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
+static void exfat_kill_sb(struct super_block *sb)
+{
+	struct exfat_sb_info *sbi = sb->s_fs_info;
+
+	kill_block_super(sb);
+	if (sbi)
+		exfat_free_sbi(sbi);
+}
+
 static struct file_system_type exfat_fs_type = {
 	.owner			= THIS_MODULE,
 	.name			= "exfat",
 	.init_fs_context	= exfat_init_fs_context,
 	.parameters		= exfat_parameters,
-	.kill_sb		= kill_block_super,
+	.kill_sb		= exfat_kill_sb,
 	.fs_flags		= FS_REQUIRES_DEV,
 };
 
-- 
2.39.2

