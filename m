Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1B51B554E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 09:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgDWHPE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 03:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgDWHPD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 03:15:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2FDC03C1AF;
        Thu, 23 Apr 2020 00:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Mh613tpjoy++kAkUXdryfrHzj3ksrol0w05jql2WKzM=; b=HMYkd2oX9nw0uax3+s1rVqBifg
        8cx3PT/VSvkiAw3cR25Okvr6Zru/Gc45R5ptoBz8aGyNTx1D/k2PwetCUTQsxPxFDEezPtPm6uZKI
        4FKwn9ZfjdWFV30xoAXgp9PtlI3Yt8U9ac8Ua+kvSY8LTI+y9WTYIsjX+7TX1LsjR1xG3YSVUoZg8
        Q+yW261wbWu+0rA9phtBaSTp2JUUe3CTFVyLPBIlCLmMYm18VwagLy+JZ+n8+TiBMHDTvJ+jhib5x
        FVGsKrlSJ968TdM3Axvy8uydRA0DYhC7lFuWHzbfYIjLhQ3WMXUwHAC6wzql9GeUYNZxXVCYRwiYQ
        9qAUTpEg==;
Received: from [2001:4bb8:188:40ac:46e:e5e4:1e64:2584] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRW4X-000074-DT; Thu, 23 Apr 2020 07:14:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tim Waugh <tim@cyberelk.net>, Borislav Petkov <bp@alien8.de>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] udf: stop using ioctl_by_bdev
Date:   Thu, 23 Apr 2020 09:12:24 +0200
Message-Id: <20200423071224.500849-8-hch@lst.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200423071224.500849-1-hch@lst.de>
References: <20200423071224.500849-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead just call the CD-ROM layer functionality directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/udf/lowlevel.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/fs/udf/lowlevel.c b/fs/udf/lowlevel.c
index 5c7ec121990d..f1094cdcd6cd 100644
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
2.26.1

