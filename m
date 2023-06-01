Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D4471978E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 11:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjFAJqq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 05:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbjFAJqa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:46:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE72198;
        Thu,  1 Jun 2023 02:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=U4TjS8hJ35XHd5owLFnLOorlk910Gs34ZQ7m5GZkWrQ=; b=AW37rgIICwNhWS4cQhU/rOeDtl
        Fc+pKGDwxbMkx0yfrdUfBJETxBAGp2L+FpFX21n05hR40fvZFcvzDwgR4mGclRFIE0HiYAjcr84Mo
        2LguJIqCn1sSXXNeRICc/NGz2FRZLPnp/I0ODyqo7Oe3SMAk+CHWSOO9s6xFUWX/RFJRVNFST7RZz
        WHd/zUQlxakpP9Hs7BFtLb2QUJfHzuBZKfb3uvWFLfFd0glBqTLYSvVh9VN/6S3U3R/flIWQrusGK
        GzQjiph+NDLg5nzUpREgxdrrLcFZ0C+H657sG2nQdU+xdso6RQIUhbYoqnqINKLbB91BaIeD7V0wP
        h513/YCA==;
Received: from [2001:4bb8:182:6d06:35f3:1da0:1cc3:d86d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4et1-002mEa-0r;
        Thu, 01 Jun 2023 09:46:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: [PATCH 16/16] ext4: wire up the ->mark_dead holder operation for log devices
Date:   Thu,  1 Jun 2023 11:44:59 +0200
Message-Id: <20230601094459.1350643-17-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230601094459.1350643-1-hch@lst.de>
References: <20230601094459.1350643-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement a set of holder_ops that shut down the file system when the
block device used as log device is removed undeneath the file system.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ext4/super.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index a177a16c4d2fe5..9070ea9154d727 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1096,6 +1096,15 @@ void ext4_update_dynamic_rev(struct super_block *sb)
 	 */
 }
 
+static void ext4_bdev_mark_dead(struct block_device *bdev)
+{
+	ext4_force_shutdown(bdev->bd_holder, EXT4_GOING_FLAGS_NOLOGFLUSH);
+}
+
+static const struct blk_holder_ops ext4_holder_ops = {
+	.mark_dead		= ext4_bdev_mark_dead,
+};
+
 /*
  * Open the external journal device
  */
@@ -1104,7 +1113,7 @@ static struct block_device *ext4_blkdev_get(dev_t dev, struct super_block *sb)
 	struct block_device *bdev;
 
 	bdev = blkdev_get_by_dev(dev, FMODE_READ|FMODE_WRITE|FMODE_EXCL, sb,
-				 NULL);
+				 &ext4_holder_ops);
 	if (IS_ERR(bdev))
 		goto fail;
 	return bdev;
-- 
2.39.2

