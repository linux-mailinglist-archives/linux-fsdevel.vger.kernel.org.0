Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B36776BBE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 00:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjHIWF7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 18:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjHIWFz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:05:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA511FD2;
        Wed,  9 Aug 2023 15:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=jgQoGphI7yhK2a8sAJjEwq0DyBSNj/HdoUXg4IN4ww8=; b=l2+VlDhQjqHeCtyIZQH09kn34B
        XW68F5Gfkpa3KIQwsOcH9W0O8+tLrXXxGlrwQNEnJvM6VyTmvWyUymw2KoPm3LCT+dEL3StP22vqZ
        eO3DM9OQX44ucG2ZHWroVbhPP6r2QwLzgq3IhhOHX52V1qIqhqskttslgWeM0QLa5QKi86nkLVlDF
        WiaSjm96WweMFfTnHDkvfsh02RU4f8dl4C5IIJO4N7HHGVLFIClaBv09Y6L5XVjZGuQD8hkQDo09s
        9L/hsayCW79BTT7jfehbmlnDPG3XVrbNcHIFz2N7rNFJu32QSbT26I45yYrp1LqPV9S5QTn4mlSxg
        D7w0siTw==;
Received: from [4.28.11.157] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qTrJN-005xoa-0c;
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
Subject: [PATCH 09/13] exfat: don't RCU-free the sbi
Date:   Wed,  9 Aug 2023 15:05:41 -0700
Message-Id: <20230809220545.1308228-10-hch@lst.de>
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

There are no RCU critical sections for accessing any information in the
sbi, so drop the call_rcu indirection for freeing the sbi.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/exfat/exfat_fs.h |  2 --
 fs/exfat/super.c    | 15 ++++-----------
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 729ada9e26e82e..f55498e5c23d46 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -273,8 +273,6 @@ struct exfat_sb_info {
 
 	spinlock_t inode_hash_lock;
 	struct hlist_head inode_hashtable[EXFAT_HASH_SIZE];
-
-	struct rcu_head rcu;
 };
 
 #define EXFAT_CACHE_VALID	0
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 8c32460e031e80..3c6aec96d0dc85 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -31,16 +31,6 @@ static void exfat_free_iocharset(struct exfat_sb_info *sbi)
 		kfree(sbi->options.iocharset);
 }
 
-static void exfat_delayed_free(struct rcu_head *p)
-{
-	struct exfat_sb_info *sbi = container_of(p, struct exfat_sb_info, rcu);
-
-	unload_nls(sbi->nls_io);
-	exfat_free_iocharset(sbi);
-	exfat_free_upcase_table(sbi);
-	kfree(sbi);
-}
-
 static void exfat_put_super(struct super_block *sb)
 {
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
@@ -50,7 +40,10 @@ static void exfat_put_super(struct super_block *sb)
 	brelse(sbi->boot_bh);
 	mutex_unlock(&sbi->s_lock);
 
-	call_rcu(&sbi->rcu, exfat_delayed_free);
+	unload_nls(sbi->nls_io);
+	exfat_free_iocharset(sbi);
+	exfat_free_upcase_table(sbi);
+	kfree(sbi);
 }
 
 static int exfat_sync_fs(struct super_block *sb, int wait)
-- 
2.39.2

