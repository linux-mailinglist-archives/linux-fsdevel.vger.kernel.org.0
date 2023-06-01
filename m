Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56158719767
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 11:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbjFAJpc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 05:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbjFAJpZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:45:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B38695;
        Thu,  1 Jun 2023 02:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=k4kNldVjs7e6baim8DHczVcxxVbNeVcf2VNYa40zrTg=; b=WJB1U3XzmTyXq+NiXj5gLFMAln
        Yna1szv8xq6MvrjgFSZMKkaciy3Jxq1smAfaFVRHx32tKlYtrzzvvZW/J/02D7Nw0g0OR1DNsNmkF
        h1stJDzJs9Ms7o3GnN8ShpnZPgqiWNWbyGIax8YjbKhwB0JCGwPOrwXeFmo6O01KZBzoHoSb2hZlf
        nLyD6xsq8e+6iLDDI5Fqs5pJmqZUciH4o2W6D6uufC6aEBELpHJ5mN+uJ0Et70xvyL4dD7Y66UPBd
        oNFHS9gqKJ+oVTfJ3nLtGPZBeAmnzclOAEVf3f+NHQX48HhIYBMyyLcmU8PYgxV1Y0rzigouu0wkk
        Igp8wGfg==;
Received: from [2001:4bb8:182:6d06:35f3:1da0:1cc3:d86d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4erx-002lzw-1g;
        Thu, 01 Jun 2023 09:45:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: [PATCH 04/16] block: consolidate the shutdown logic in blk_mark_disk_dead and del_gendisk
Date:   Thu,  1 Jun 2023 11:44:47 +0200
Message-Id: <20230601094459.1350643-5-hch@lst.de>
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

blk_mark_disk_dead does very similar work a a section of del_gendisk:

 - set the GD_DEAD flag
 - set the capacity to zero
 - start a queue drain

but del_gendisk also sets QUEUE_FLAG_DYING on the queue if it is owned by
the disk, sets the capacity to zero before starting the drain, and both
with sending a uevent and kernel message for this fake capacity change.

Move the exact logic from the more heavily used del_gendisk into
blk_mark_disk_dead and then call blk_mark_disk_dead from del_gendisk.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 block/genhd.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 3537b7d7c484d7..aa327314905e63 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -572,13 +572,22 @@ EXPORT_SYMBOL(device_add_disk);
  */
 void blk_mark_disk_dead(struct gendisk *disk)
 {
+	/*
+	 * Fail any new I/O.
+	 */
 	set_bit(GD_DEAD, &disk->state);
-	blk_queue_start_drain(disk->queue);
+	if (test_bit(GD_OWNS_QUEUE, &disk->state))
+		blk_queue_flag_set(QUEUE_FLAG_DYING, disk->queue);
 
 	/*
 	 * Stop buffered writers from dirtying pages that can't be written out.
 	 */
-	set_capacity_and_notify(disk, 0);
+	set_capacity(disk, 0);
+
+	/*
+	 * Prevent new I/O from crossing bio_queue_enter().
+	 */
+	blk_queue_start_drain(disk->queue);
 }
 EXPORT_SYMBOL_GPL(blk_mark_disk_dead);
 
@@ -620,18 +629,7 @@ void del_gendisk(struct gendisk *disk)
 	fsync_bdev(disk->part0);
 	__invalidate_device(disk->part0, true);
 
-	/*
-	 * Fail any new I/O.
-	 */
-	set_bit(GD_DEAD, &disk->state);
-	if (test_bit(GD_OWNS_QUEUE, &disk->state))
-		blk_queue_flag_set(QUEUE_FLAG_DYING, q);
-	set_capacity(disk, 0);
-
-	/*
-	 * Prevent new I/O from crossing bio_queue_enter().
-	 */
-	blk_queue_start_drain(q);
+	blk_mark_disk_dead(disk);
 
 	if (!(disk->flags & GENHD_FL_HIDDEN)) {
 		sysfs_remove_link(&disk_to_dev(disk)->kobj, "bdi");
-- 
2.39.2

