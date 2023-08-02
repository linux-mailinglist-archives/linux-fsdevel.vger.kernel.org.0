Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE7E76D27A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 17:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235248AbjHBPmL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 11:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234769AbjHBPl6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:41:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3439B;
        Wed,  2 Aug 2023 08:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=RYN7DH9joo3rTfq03kLfw85iskRMJeYrOUPHdC0m2mc=; b=VueuQORBH0Zx8oecpphGDd2a+f
        C5wXJWADk0ImZU6N80BupX/ZLTEluwHdf0bUw2wgbIVHzC4QM/bCJjgsnQEUhtU031a1gtB+mS3iG
        DTTgblzl2urUf4SSKGYW0eqzGYAHnbkFQK9ShplN/L36EJF1csgfmjTtDPks6m8MLcM2NSfBkK0yk
        YInd8oNc8nohhh1lAb9WMtyUjnN0afRF7aLxK2HUoGXeYbQoyvZu3JkZfcleLpxakg5nfDO3SoERw
        qQn+nJoxuqkTDCbHCSGJS69vnqYxfYRvoOWnioqmewoq+36B/XNMiyvu+GiTGedFDHOvVA6F1eKOM
        g49DmvlA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qRDyw-005GFw-0I;
        Wed, 02 Aug 2023 15:41:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH 05/12] ext4: make the IS_EXT2_SB/IS_EXT3_SB checks more robust
Date:   Wed,  2 Aug 2023 17:41:24 +0200
Message-Id: <20230802154131.2221419-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230802154131.2221419-1-hch@lst.de>
References: <20230802154131.2221419-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Check for sb->s_type which is the right place to look at the file system
type, not the holder, which is just an implementation detail in the VFS
helpers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ext4/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c94ebf704616e5..193d665813b611 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -140,7 +140,7 @@ static struct file_system_type ext2_fs_type = {
 };
 MODULE_ALIAS_FS("ext2");
 MODULE_ALIAS("ext2");
-#define IS_EXT2_SB(sb) ((sb)->s_bdev->bd_holder == &ext2_fs_type)
+#define IS_EXT2_SB(sb) ((sb)->s_type == &ext2_fs_type)
 #else
 #define IS_EXT2_SB(sb) (0)
 #endif
@@ -156,7 +156,7 @@ static struct file_system_type ext3_fs_type = {
 };
 MODULE_ALIAS_FS("ext3");
 MODULE_ALIAS("ext3");
-#define IS_EXT3_SB(sb) ((sb)->s_bdev->bd_holder == &ext3_fs_type)
+#define IS_EXT3_SB(sb) ((sb)->s_type == &ext3_fs_type)
 
 
 static inline void __ext4_read_bh(struct buffer_head *bh, blk_opf_t op_flags,
-- 
2.39.2

