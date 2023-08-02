Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6AE76D292
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 17:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235335AbjHBPmp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 11:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234282AbjHBPmR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:42:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DB3212B;
        Wed,  2 Aug 2023 08:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=H3MTtQkLFkLtQvQuadZGreptlnpEa/QPHhaLm59CLeo=; b=3JXg/prj0HfTjXvS5Acr1C9TH8
        tBCdwieLU44WmKkY3yg459RwXOD3Ksk/8LYtSODjqVxZt/pb+SwDXBOYev1CR9j0Gzt6WBv9+Yb9n
        0d6Gg7s326FEZsZfpcNZDOIYGoDpH0mESnTfRIiZI3w8I2NMPDqxnxJLbxNPkqle4gMEcQKYp1EgX
        7CEBSecV3ExtqrQHb8ny4H4fzi1LfiImJPIEpcVxedd+2YDNFXNgP5/iHFTm9wdAgHoWSi4D7/T4A
        qQP6+/T+EtbyBae5S1gS5DirSjkxKBoWa/sIWZn8/4j/f/cAkgIIVu/nkTbTc3SB4lzPFWqQHZ5An
        LLzbtv3w==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qRDz6-005GJQ-2m;
        Wed, 02 Aug 2023 15:42:01 +0000
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
Subject: [PATCH 07/12] fs: stop using get_super in fs_mark_dead
Date:   Wed,  2 Aug 2023 17:41:26 +0200
Message-Id: <20230802154131.2221419-8-hch@lst.de>
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

fs_mark_dead currently uses get_super to find the superblock for the
block device that is going away.  This means it is limited to the
main device stored in sb->s_dev, leading to a lot of code duplication
for file systems that can use multiple block devices.

Now that the holder for all block devices used by file systems is set
to the super_block, we can instead look at that holder and then check
if the file system is born and active, so do that instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/super.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 09b65ee1a8b737..0cda4af0a7e16c 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1209,17 +1209,39 @@ int get_tree_keyed(struct fs_context *fc,
 EXPORT_SYMBOL(get_tree_keyed);
 
 #ifdef CONFIG_BLOCK
+/*
+ * Lock a super block that the callers holds a reference to.
+ *
+ * The caller needs to ensure that the super_block isn't being freed while
+ * calling this function, e.g. by holding a lock over the call to this function
+ * and the place that clears the pointer to the superblock used by this function
+ * before freeing the superblock.
+ */
+static bool lock_active_super(struct super_block *sb)
+{
+	down_read(&sb->s_umount);
+	if (!sb->s_root ||
+	    (sb->s_flags & (SB_ACTIVE | SB_BORN)) != (SB_ACTIVE | SB_BORN)) {
+		up_read(&sb->s_umount);
+		return false;
+	}
+	return true;
+}
+
 static void fs_mark_dead(struct block_device *bdev)
 {
-	struct super_block *sb;
+	struct super_block *sb = bdev->bd_holder;
 
-	sb = get_super(bdev);
-	if (!sb)
+	/* bd_holder_lock ensures that the sb isn't freed */
+	lockdep_assert_held(&bdev->bd_holder_lock);
+
+	if (!lock_active_super(sb))
 		return;
 
 	if (sb->s_op->shutdown)
 		sb->s_op->shutdown(sb);
-	drop_super(sb);
+
+	up_read(&sb->s_umount);
 }
 
 static const struct blk_holder_ops fs_holder_ops = {
-- 
2.39.2

