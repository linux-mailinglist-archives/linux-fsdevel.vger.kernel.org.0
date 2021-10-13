Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A58442B5CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Oct 2021 07:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237826AbhJMFoV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Oct 2021 01:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhJMFoU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Oct 2021 01:44:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6BBC061570;
        Tue, 12 Oct 2021 22:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Jn3vPWURqTLCTgey+1ZKUDn76o/D4LziuPXo21jTcNA=; b=hRwOIaUT4TV+iuM/Zg8w7n25xq
        4JP07oWgVj96DxAIyE5GugNAoImIQjt6YOnfusnDpQHqpMzsfUUyomS23Xdp6GlGxW3N9d9yv8zRS
        Hpba9F54jbcMwbBNW8QibfhbiimOvdOmbo+bN2OBMyd97mLTimJW2mXzi7iAyeKKMK46Qo3qyEEEa
        rak7t0pG0xoWK9og1uwIKQIsTozlfX1z449iRcMhaqjTRmWD/ItgnJgiWeePTgAAgRxi2mKfmIrf0
        aPWD/qlzTxrcJbhN3jtl/ZC96e/wuQfBrUM++RgMnBjSBr/PpZLjvhZ0imDh0CcCecmWUWPsOtrDH
        PvSE0SHg==;
Received: from 089144212063.atnat0021.highway.a1.net ([89.144.212.63] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maWxN-007832-Di; Wed, 13 Oct 2021 05:38:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Song Liu <song@kernel.org>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Dave Kleikamp <shaggy@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Kees Cook <keescook@chromium.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, drbd-dev@lists.linbit.com,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev,
        reiserfs-devel@vger.kernel.org
Subject: [PATCH 23/29] block: use bdev_nr_sectors instead of open coding it in blkdev_fallocate
Date:   Wed, 13 Oct 2021 07:10:36 +0200
Message-Id: <20211013051042.1065752-24-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211013051042.1065752-1-hch@lst.de>
References: <20211013051042.1065752-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the proper helper to read the block device size.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/fops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index 7bb9581a146cf..6e27dd2748504 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -548,7 +548,7 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 		return -EOPNOTSUPP;
 
 	/* Don't go off the end of the device. */
-	isize = i_size_read(bdev->bd_inode);
+	isize = bdev_nr_sectors(bdev) << SECTOR_SHIFT;
 	if (start >= isize)
 		return -EINVAL;
 	if (end >= isize) {
-- 
2.30.2

