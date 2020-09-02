Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9302E25ACEB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 16:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgIBOYQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 10:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbgIBONl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:13:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEB5C061231;
        Wed,  2 Sep 2020 07:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=JsmSEHqUTPHzIdiuujgytMYVmaPLDkPMtqBFsN746VA=; b=EzvW+WRU6ocqroaF91GmMLKtwY
        nTHpPcnlF9niVs+7RjtJZeCQxp9v5fF0wGWanEjySq1iFFZJDMZKzPCqtyKrSQTbWAkyTsqjVT55Q
        iD/n2seyc/esMFg4wQO5m3F72Mwva4oG37BI1mEQ4gESiyggBoHE0cZAegPOy6vyED9ZhEWbCiVgT
        Ys8Wi2PNgTCN/rHxeRVjAIvzNNpREuSn4i/ikZs+x/ZDO9ofVpQmJ7ld/bWo2F83N3CjGGsx3JHJv
        Hl2OAV7Tbs9yDOCOr0rXsb0f53R+j06c53vCxpYfinFl+LSPeDGn2hvVwJCIIdnTQON4fRKP+bbLs
        Zl0N0jOA==;
Received: from [2001:4bb8:184:af1:6a63:7fdb:a80e:3b0b] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDTVG-0005hA-83; Wed, 02 Sep 2020 14:12:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Denis Efremov <efremov@linux.com>, Tim Waugh <tim@cyberelk.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-m68k@lists.linux-m68k.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 19/19] block: remove check_disk_change
Date:   Wed,  2 Sep 2020 16:12:18 +0200
Message-Id: <20200902141218.212614-20-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902141218.212614-1-hch@lst.de>
References: <20200902141218.212614-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove the now unused check_disk_change helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c        | 20 --------------------
 include/linux/genhd.h |  1 -
 2 files changed, 21 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 37cb809b217926..c6baae5b85060c 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1339,26 +1339,6 @@ void revalidate_disk_size(struct gendisk *disk, bool verbose)
 }
 EXPORT_SYMBOL(revalidate_disk_size);
 
-/*
- * This routine checks whether a removable media has been changed,
- * and invalidates all buffer-cache-entries in that case. This
- * is a relatively slow routine, so we have to try to minimize using
- * it. Thus it is called only upon a 'mount' or 'open'. This
- * is the best way of combining speed and utility, I think.
- * People changing diskettes in the middle of an operation deserve
- * to lose :-)
- */
-int check_disk_change(struct block_device *bdev)
-{
-	if (!bdev_check_media_change(bdev))
-		return 0;
-	if (bdev->bd_disk->fops->revalidate_disk)
-		bdev->bd_disk->fops->revalidate_disk(bdev->bd_disk);
-	return 1;
-}
-
-EXPORT_SYMBOL(check_disk_change);
-
 void bd_set_nr_sectors(struct block_device *bdev, sector_t sectors)
 {
 	spin_lock(&bdev->bd_size_lock);
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 322d48a207728a..1c97cf84f011a7 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -370,7 +370,6 @@ int register_blkdev(unsigned int major, const char *name);
 void unregister_blkdev(unsigned int major, const char *name);
 
 void revalidate_disk_size(struct gendisk *disk, bool verbose);
-int check_disk_change(struct block_device *bdev);
 bool bdev_check_media_change(struct block_device *bdev);
 int __invalidate_device(struct block_device *bdev, bool kill_dirty);
 void bd_set_nr_sectors(struct block_device *bdev, sector_t sectors);
-- 
2.28.0

