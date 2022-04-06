Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6DB4F58FC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 11:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236872AbiDFJP4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 05:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353711AbiDFJCt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 05:02:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C024445859;
        Tue,  5 Apr 2022 23:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=WTqESTvtfO4RX0qAqhs2oFd2Ik59q54vLqp/V/y7bnI=; b=FyJUmCuIohn+Rc7Inqu3BniYMO
        qIbi7WgRq0N7qblPyTDtikeMFm5V1dbLiaJQYES35HwVVDM5F002rNedhKojSjZSangf3g4TTB5H8
        ose/VQW92oLsoNNnrgmuQ76bdKKE4T6Y3dmmZVsUWsnsPjVGMnUiPjquePmKO+IeMAi+ZQQvMCCYS
        5PMGec+vFR133rAMQYM0lD1ltqCTBtpWog3Ko4h+ioJJRDUI+WLYZoytyDGy8Ig1GoZQ2cZVQBaiq
        VeAMRPUX1EVBht4ncdSOvQy0zHk56lci0PZ4ia4LUpztUXudJZTNfnXGvXSxvvSo+c89mmlg6GRYS
        FB4ItY+g==;
Received: from 213-225-3-188.nat.highway.a1.net ([213.225.3.188] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbynb-003uwx-AJ; Wed, 06 Apr 2022 06:05:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-um@lists.infradead.org,
        linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
        nbd@other.debian.org, ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, jfs-discussion@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
        ocfs2-devel@oss.oracle.com, linux-mm@kvack.org
Subject: [PATCH 07/27] btrfs: use bdev_max_active_zones instead of open coding it
Date:   Wed,  6 Apr 2022 08:04:56 +0200
Message-Id: <20220406060516.409838-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220406060516.409838-1-hch@lst.de>
References: <20220406060516.409838-1-hch@lst.de>
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

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/zoned.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index b7b5fac1c7790..5b85004d85d6c 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -350,7 +350,6 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 	struct btrfs_fs_info *fs_info = device->fs_info;
 	struct btrfs_zoned_device_info *zone_info = NULL;
 	struct block_device *bdev = device->bdev;
-	struct request_queue *queue = bdev_get_queue(bdev);
 	unsigned int max_active_zones;
 	unsigned int nactive;
 	sector_t nr_sectors;
@@ -410,7 +409,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 	if (!IS_ALIGNED(nr_sectors, zone_sectors))
 		zone_info->nr_zones++;
 
-	max_active_zones = queue_max_active_zones(queue);
+	max_active_zones = bdev_max_active_zones(bdev);
 	if (max_active_zones && max_active_zones < BTRFS_MIN_ACTIVE_ZONES) {
 		btrfs_err_in_rcu(fs_info,
 "zoned: %s: max active zones %u is too small, need at least %u active zones",
-- 
2.30.2

