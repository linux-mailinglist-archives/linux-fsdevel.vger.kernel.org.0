Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFE0776BDB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 00:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbjHIWGJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 18:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbjHIWFz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:05:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DE2211E;
        Wed,  9 Aug 2023 15:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=MXJARFPmjc3yQgiqYUDoZ2GP7GID7GJftYa9RQlJfEY=; b=qkk1LhrHQiNUSP0x5xirq/gQPw
        5lXh97wpqGF5TdXdhF3Wwg3MiVIB4X3SqtBPWpiyU+bbWiZb92sdDvVtraYzh8HPx6Uyz2OwTdeJr
        h0dE+fhKXN6R5kQRVBoO4/e6SprnyaKy8UYvU3Mh12MoB3N+gf/dIWNNOuwQyzJRL2s4W6Fz/LIEZ
        NehgT3sI8SfJkxV282VsWSBWR3B/fu9OHLSh4PIsElz7nYO2++2rvwyVInzBe1QEvEekbaWbeBauf
        wHdb9t+FMpgzuglLmAGJHlml2f5S3iOooWB906khcbLs/ZZcPatfUHZtDr3elguZoMfJgIHsIUY5W
        ISuNr3GA==;
Received: from [4.28.11.157] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qTrJN-005xoi-2T;
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
Subject: [PATCH 11/13] ntfs3: rename put_ntfs ntfs3_free_sbi
Date:   Wed,  9 Aug 2023 15:05:43 -0700
Message-Id: <20230809220545.1308228-12-hch@lst.de>
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

put_ntfs is a rather unconventional name for a function that frees the
sbi and associated resources.  Give it a more descriptive name and drop
the duplicate name in the top of the function comment.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christian Brauner <brauner@kernel.org>
---
 fs/ntfs3/super.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 1a02072b6b0e16..bb985d3756d949 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -569,9 +569,9 @@ static void init_once(void *foo)
 }
 
 /*
- * put_ntfs - Noinline to reduce binary size.
+ * Noinline to reduce binary size.
  */
-static noinline void put_ntfs(struct ntfs_sb_info *sbi)
+static noinline void ntfs3_free_sbi(struct ntfs_sb_info *sbi)
 {
 	kfree(sbi->new_rec);
 	kvfree(ntfs_put_shared(sbi->upcase));
@@ -627,7 +627,7 @@ static void ntfs_put_super(struct super_block *sb)
 	ntfs_set_state(sbi, NTFS_DIRTY_CLEAR);
 
 	put_mount_options(sbi->options);
-	put_ntfs(sbi);
+	ntfs3_free_sbi(sbi);
 	sb->s_fs_info = NULL;
 
 	sync_blockdev(sb->s_bdev);
@@ -1569,7 +1569,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	 * ntfs_fs_free will be called with fc->s_fs_info = NULL
 	 */
 	put_mount_options(sbi->options);
-	put_ntfs(sbi);
+	ntfs3_free_sbi(sbi);
 	sb->s_fs_info = NULL;
 	kfree(boot2);
 
@@ -1659,7 +1659,7 @@ static void ntfs_fs_free(struct fs_context *fc)
 	struct ntfs_sb_info *sbi = fc->s_fs_info;
 
 	if (sbi)
-		put_ntfs(sbi);
+		ntfs3_free_sbi(sbi);
 
 	if (opts)
 		put_mount_options(opts);
-- 
2.39.2

