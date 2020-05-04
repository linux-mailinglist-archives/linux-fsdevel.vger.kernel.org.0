Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D5D1C3BFE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 16:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgEDN74 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 09:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728050AbgEDN74 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 09:59:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25832C061A0F;
        Mon,  4 May 2020 06:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=hXlFdNu3uey0NQs9NJqfMf+yPJLzrPPpQ2QUUnXWjJw=; b=EYo3DNwydBHWefKOMPHRub+4nk
        Aa4WnRZKp7MBW3wUapQTAvBRUzPIqdxd/hCqnCJhRV4reECz9SWm71wBU7h6wtna1W8ThpVLlBOcP
        BMWJgFiFaHUKO63BSlbEf5e2KupXKMIByRgPNH4hylAd2TcNWb4TzOkieXbnNFvcHjFR8nFhYHekD
        IxST6t1y0BNY5zT0+KSjexItsiOakAir8ZmafatI/sU3W/khGPztKB2lKG9Y5LBQbdcS5DuE1q+B2
        6haOc77Jkqqt5bPMLMDRY20X6mALWNw6UXbmFR+YlFk5gF5PXs1LsFW7OZ04wwUaNXD4EwC+sXnxa
        UPo5JP9Q==;
Received: from [2001:4bb8:18c:10bd:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVbdK-0007a8-0q; Mon, 04 May 2020 13:59:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tim Waugh <tim@cyberelk.net>, Borislav Petkov <bp@alien8.de>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 6/8] hfsplus: stop using ioctl_by_bdev
Date:   Mon,  4 May 2020 15:59:25 +0200
Message-Id: <20200504135927.2835750-7-hch@lst.de>
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
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de
---
 fs/hfsplus/wrapper.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/fs/hfsplus/wrapper.c b/fs/hfsplus/wrapper.c
index 08c1580bdf7ad..61eec628805de 100644
--- a/fs/hfsplus/wrapper.c
+++ b/fs/hfsplus/wrapper.c
@@ -127,31 +127,34 @@ static int hfsplus_read_mdb(void *bufptr, struct hfsplus_wd *wd)
 static int hfsplus_get_last_session(struct super_block *sb,
 				    sector_t *start, sector_t *size)
 {
-	struct cdrom_multisession ms_info;
-	struct cdrom_tocentry te;
-	int res;
+	struct cdrom_device_info *cdi = disk_to_cdi(sb->s_bdev->bd_disk);
 
 	/* default values */
 	*start = 0;
 	*size = i_size_read(sb->s_bdev->bd_inode) >> 9;
 
 	if (HFSPLUS_SB(sb)->session >= 0) {
+		struct cdrom_tocentry te;
+
+		if (!cdi)
+			return -EINVAL;
+
 		te.cdte_track = HFSPLUS_SB(sb)->session;
 		te.cdte_format = CDROM_LBA;
-		res = ioctl_by_bdev(sb->s_bdev,
-			CDROMREADTOCENTRY, (unsigned long)&te);
-		if (!res && (te.cdte_ctrl & CDROM_DATA_TRACK) == 4) {
-			*start = (sector_t)te.cdte_addr.lba << 2;
-			return 0;
+		if (cdrom_read_tocentry(cdi, &te) ||
+		    (te.cdte_ctrl & CDROM_DATA_TRACK) != 4) {
+			pr_err("invalid session number or type of track\n");
+			return -EINVAL;
 		}
-		pr_err("invalid session number or type of track\n");
-		return -EINVAL;
+		*start = (sector_t)te.cdte_addr.lba << 2;
+	} else if (cdi) {
+		struct cdrom_multisession ms_info;
+
+		ms_info.addr_format = CDROM_LBA;
+		if (cdrom_multisession(cdi, &ms_info) == 0 && ms_info.xa_flag)
+			*start = (sector_t)ms_info.addr.lba << 2;
 	}
-	ms_info.addr_format = CDROM_LBA;
-	res = ioctl_by_bdev(sb->s_bdev, CDROMMULTISESSION,
-		(unsigned long)&ms_info);
-	if (!res && ms_info.xa_flag)
-		*start = (sector_t)ms_info.addr.lba << 2;
+
 	return 0;
 }
 
-- 
2.26.2

