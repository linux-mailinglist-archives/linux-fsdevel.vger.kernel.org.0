Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB027AD4D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 11:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjIYJvv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 05:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjIYJvr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:51:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E0DE3;
        Mon, 25 Sep 2023 02:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=6TWSZCgmP5RpqZAP6eKztGmF1/PqQHitW8swe9guwZg=; b=pM5US9jQFrvi/zNxF+8t4ssgaM
        qKZNgpnrgHwmHxic3ZWGdtxFb9E4PkM7yi48JnnRw7RrJJjUDynO0/t7pD5PtpZiyT4i11ygJBi0o
        kmXc3/7v/6+DC8Xbo8vb4w51awZ6vQa70KEGxr6HtNafBKVywVdsbEKMduJFC3tpDRnFCOTmZti1N
        eR+eQJUtL3T2CLw2CpfSWL+jYaemWv11sd9ZGg+vTEyRiy45Wgw8gxAsGSXZ7WgoRUafUUv7NR2Jj
        Yes3QztZ/zC7VY3R7LRoBcDIVGV2267cHEirN8IO0mAYxfxIxIYXgzC5t9bQczdj0PJbVKvBcNBD1
        3HDpv15w==;
Received: from [2001:4bb8:180:ac72:5d00:ec60:acf5:548c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qkiFf-00DtI5-0C;
        Mon, 25 Sep 2023 09:51:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     djwong@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        brauner@kernel.org,
        syzbot+1fa947e7f09e136925b8@syzkaller.appspotmail.com
Subject: [PATCH] iomap: add a workaround for racy i_size updates on block devices
Date:   Mon, 25 Sep 2023 11:51:33 +0200
Message-Id: <20230925095133.311224-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A szybot reproducer that does write I/O while truncating the size of a
block device can end up in clean_bdev_aliases, which tries to clean the
bdev aliases that it uses.  This is because iomap_to_bh automatically
sets the BH_New flag when outside of i_size.  For block devices updates
to i_size are racy and we can hit this case in a tiny race window,
leading to the eventual clean_bdev_aliases call.  Fix this by erroring
out of > i_size I/O on block devices.

Reported-by: syzbot+1fa947e7f09e136925b8@syzkaller.appspotmail.com
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: syzbot+1fa947e7f09e136925b8@syzkaller.appspotmail.com
---
 fs/buffer.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index a6785cd07081cb..12e9a71c693d74 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2058,8 +2058,17 @@ iomap_to_bh(struct inode *inode, sector_t block, struct buffer_head *bh,
 		fallthrough;
 	case IOMAP_MAPPED:
 		if ((iomap->flags & IOMAP_F_NEW) ||
-		    offset >= i_size_read(inode))
+		    offset >= i_size_read(inode)) {
+			/*
+			 * This can happen if truncating the block device races
+			 * with the check in the caller as i_size updates on
+			 * block devices aren't synchronized by i_rwsem for
+			 * block devices.
+			 */
+			if (S_ISBLK(inode->i_mode))
+				return -EIO;
 			set_buffer_new(bh);
+		}
 		bh->b_blocknr = (iomap->addr + offset - iomap->offset) >>
 				inode->i_blkbits;
 		set_buffer_mapped(bh);
-- 
2.39.2

