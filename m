Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FB376D25C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 17:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbjHBPlx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 11:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbjHBPlq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:41:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0991CE4;
        Wed,  2 Aug 2023 08:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=yR3dj+eONAtbKM/zIO7ew4m4jCWdaatgpKXh7YubtNo=; b=mhaGQnhVJ1uO0sXkPgK8YqFZc5
        sx4T/ucx2OPuff6PNBCxPLw0lRV53g6hNyTwuVkRXmfF5ms72GkE+0x1uqrIpsNzHaHP6+Py4j6Tt
        9XFmrppR/JGamizKFARycs9Ei0Zd6NCt6jtO/emxLVKW+oJppL6xK9oZ0QyDSOt4KwCRRE5Fb3/qV
        nd1M5X+TDd19RtkW7i16PyY3kk/HSZISBliaimAqK2zb2qyMjYGvY5ilv8+9zMumwN7d615Bm9309
        WGSgzj/m+SQzHji61NEj7z0Pag2YVdzThx00Fv79SfAWHCvcSS285h67bPeQfgF/88NmzMiFiyxid
        AaZCwhZg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qRDyk-005GE4-1b;
        Wed, 02 Aug 2023 15:41:39 +0000
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
Subject: [PATCH 01/12] fs: export setup_bdev_super
Date:   Wed,  2 Aug 2023 17:41:20 +0200
Message-Id: <20230802154131.2221419-2-hch@lst.de>
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

We'll want to use setup_bdev_super instead of duplicating it in nilfs2.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/super.c                 | 3 ++-
 include/linux/fs_context.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/super.c b/fs/super.c
index 3ef39df5bec506..6aaa275fa8630d 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1243,7 +1243,7 @@ static int test_bdev_super_fc(struct super_block *s, struct fs_context *fc)
 		s->s_dev == *(dev_t *)fc->sget_key;
 }
 
-static int setup_bdev_super(struct super_block *sb, int sb_flags,
+int setup_bdev_super(struct super_block *sb, int sb_flags,
 		struct fs_context *fc)
 {
 	blk_mode_t mode = sb_open_mode(sb_flags);
@@ -1295,6 +1295,7 @@ static int setup_bdev_super(struct super_block *sb, int sb_flags,
 	sb_set_blocksize(sb, block_size(bdev));
 	return 0;
 }
+EXPORT_SYMBOL_GPL(setup_bdev_super);
 
 /**
  * get_tree_bdev - Get a superblock based on a single block device
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index ff6341e09925bc..58ef8433a94b8c 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -158,6 +158,8 @@ extern int get_tree_keyed(struct fs_context *fc,
 					   struct fs_context *fc),
 			 void *key);
 
+int setup_bdev_super(struct super_block *sb, int sb_flags,
+		struct fs_context *fc);
 extern int get_tree_bdev(struct fs_context *fc,
 			       int (*fill_super)(struct super_block *sb,
 						 struct fs_context *fc));
-- 
2.39.2

