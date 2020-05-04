Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E381D1C3BD3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 15:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgEDN75 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 09:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728088AbgEDN74 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 09:59:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA99C061A41;
        Mon,  4 May 2020 06:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=U//7dJcVU8Y3pHY5ljTkEwmYgkA64gPl3bOWhYC99c0=; b=c2UJn86GjfReLqes8s5dn8SneA
        hAz6rzjtbgjbuTGPTNSWlnb7ZxvTITVderF9+NG9oLxzLIIFp6XYbCxwcA2EVUQlx4Whcmd/u/qsX
        O7zmlb08sF6a2CAgV3egRXvpkN3B6uQ4xfwESwdSV1mkaG6bKNuZIaBqBlM9oKKdzNrX2tTHUcqYs
        O6yQnxyeqM7sUTmUv9ZEZWyCzvATkX6mzYBbP8zipKGSsIU1L6IkeE0dWC3UNCMdOTNzVmhSG3kTb
        tijeuFnFAZoAh+RWwTHc58YUiUETWQBcFaEFtD4rZqQs1THxQomeB/I29o2+h5LA7OhNHT4oOySkI
        26ryfOxQ==;
Received: from [2001:4bb8:18c:10bd:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVbdO-0007b2-Qj; Mon, 04 May 2020 13:59:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tim Waugh <tim@cyberelk.net>, Borislav Petkov <bp@alien8.de>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 8/8] udf: stop using ioctl_by_bdev
Date:   Mon,  4 May 2020 15:59:27 +0200
Message-Id: <20200504135927.2835750-9-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504135927.2835750-1-hch@lst.de>
References: <20200504135927.2835750-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead just call the CDROM layer functionality directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 fs/udf/lowlevel.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/fs/udf/lowlevel.c b/fs/udf/lowlevel.c
index 5c7ec121990da..f1094cdcd6cde 100644
--- a/fs/udf/lowlevel.c
+++ b/fs/udf/lowlevel.c
@@ -27,41 +27,38 @@
 
 unsigned int udf_get_last_session(struct super_block *sb)
 {
+	struct cdrom_device_info *cdi = disk_to_cdi(sb->s_bdev->bd_disk);
 	struct cdrom_multisession ms_info;
-	unsigned int vol_desc_start;
-	struct block_device *bdev = sb->s_bdev;
-	int i;
 
-	vol_desc_start = 0;
-	ms_info.addr_format = CDROM_LBA;
-	i = ioctl_by_bdev(bdev, CDROMMULTISESSION, (unsigned long)&ms_info);
+	if (!cdi) {
+		udf_debug("CDROMMULTISESSION not supported.\n");
+		return 0;
+	}
 
-	if (i == 0) {
+	ms_info.addr_format = CDROM_LBA;
+	if (cdrom_multisession(cdi, &ms_info) == 0) {
 		udf_debug("XA disk: %s, vol_desc_start=%d\n",
 			  ms_info.xa_flag ? "yes" : "no", ms_info.addr.lba);
 		if (ms_info.xa_flag) /* necessary for a valid ms_info.addr */
-			vol_desc_start = ms_info.addr.lba;
-	} else {
-		udf_debug("CDROMMULTISESSION not supported: rc=%d\n", i);
+			return ms_info.addr.lba;
 	}
-	return vol_desc_start;
+	return 0;
 }
 
 unsigned long udf_get_last_block(struct super_block *sb)
 {
 	struct block_device *bdev = sb->s_bdev;
+	struct cdrom_device_info *cdi = disk_to_cdi(bdev->bd_disk);
 	unsigned long lblock = 0;
 
 	/*
-	 * ioctl failed or returned obviously bogus value?
+	 * The cdrom layer call failed or returned obviously bogus value?
 	 * Try using the device size...
 	 */
-	if (ioctl_by_bdev(bdev, CDROM_LAST_WRITTEN, (unsigned long) &lblock) ||
-	    lblock == 0)
+	if (!cdi || cdrom_get_last_written(cdi, &lblock) || lblock == 0)
 		lblock = i_size_read(bdev->bd_inode) >> sb->s_blocksize_bits;
 
 	if (lblock)
 		return lblock - 1;
-	else
-		return 0;
+	return 0;
 }
-- 
2.26.2

