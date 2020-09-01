Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 137E2259616
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 17:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732171AbgIAP6V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Sep 2020 11:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731348AbgIAP6M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:58:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E10C06124F;
        Tue,  1 Sep 2020 08:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=X/wfONNMX9AkocUJrvkgvfoHlYcJ3otMPBdPBvDFSjg=; b=a3R6hLNAfPXw6R8QRXbGznXJl/
        XYw3Qcp5GUZVdLvYz3g7yZTdhLBPVHDMlSfggoOPLUZWWTlpi4VSyTLAeSxeaGxz4415i0HuxYlHn
        Rrzp4jXd9c1wB6Wl3fp75EZkwMR2pMOu0V4GqphS42Sy5cwGMmFOYSTu0f0WbNwh1AsqMoTho9gFC
        RdhXzlE/7Zkah6VP7mUGqtnJKwpPFotBogYpnKN+bSpdkd42Pcgek9fWuBUDFm0apHm4YOMPi1N2y
        tFJ5Kmb07jMbKgTkS/gXIrjXeu0LFRibRlegC43oSpS4bZjr/7ucSGkobwgV+XWFLT35JhGnmQ+r9
        HsMdIZtA==;
Received: from [2001:4bb8:18c:45ba:2f95:e5:ca6b:9b4a] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kD8fX-0004QE-CS; Tue, 01 Sep 2020 15:57:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Dan Williams <dan.j.williams@intel.com>, dm-devel@redhat.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        nbd@other.debian.org, ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-raid@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/9] block: use revalidate_disk_size in set_capacity_revalidate_and_notify
Date:   Tue,  1 Sep 2020 17:57:44 +0200
Message-Id: <20200901155748.2884-6-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901155748.2884-1-hch@lst.de>
References: <20200901155748.2884-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Only virtio_blk and xen-blkfront set the revalidate argument to true,
and both do not implement the ->revalidate_disk method.  So switch
to the helper that just updates the size instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c         | 7 +++----
 include/linux/genhd.h | 4 ++--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index a2c0ec694918e5..431d4081b50ec7 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -50,14 +50,13 @@ static void disk_release_events(struct gendisk *disk);
  * zero and will not be set to zero
  */
 void set_capacity_revalidate_and_notify(struct gendisk *disk, sector_t size,
-					bool revalidate)
+					bool update_bdev)
 {
 	sector_t capacity = get_capacity(disk);
 
 	set_capacity(disk, size);
-
-	if (revalidate)
-		revalidate_disk(disk);
+	if (update_bdev)
+		revalidate_disk_size(disk, true);
 
 	if (capacity != size && capacity != 0 && size != 0) {
 		char *envp[] = { "RESIZE=1", NULL };
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 8e9c9d3a493fae..c340b392452ce6 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -315,8 +315,8 @@ static inline int get_disk_ro(struct gendisk *disk)
 extern void disk_block_events(struct gendisk *disk);
 extern void disk_unblock_events(struct gendisk *disk);
 extern void disk_flush_events(struct gendisk *disk, unsigned int mask);
-extern void set_capacity_revalidate_and_notify(struct gendisk *disk,
-			sector_t size, bool revalidate);
+void set_capacity_revalidate_and_notify(struct gendisk *disk, sector_t size,
+		bool update_bdev);
 extern unsigned int disk_clear_events(struct gendisk *disk, unsigned int mask);
 
 /* drivers/char/random.c */
-- 
2.28.0

