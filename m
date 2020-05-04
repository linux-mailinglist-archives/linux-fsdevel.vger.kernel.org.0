Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC9A1C3BF9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 16:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgEDOAi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 10:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728168AbgEDN74 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 09:59:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A2AC061BD3;
        Mon,  4 May 2020 06:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=PThi5otuSmIv87sVwtTG8nfMFGAV/tBkGdHRgwma/LQ=; b=BL3jxcs71vRIL+nXcJX7p3KpN6
        ZzayRxIQB6ZjYs2/yM5g/kZI1QxtkFtVxM4EliiaqVnQBLnzzGHZVMr3z7nNNVNUipPK9+pS08U7b
        c3lfxqAp7itiR+nnUk59aT0UfH5Ik9+JNxCHRcTU/hQaEd0vg1gwwlomzR5VTeS5qRVv0gWFxNc9q
        8Db3JlT2fOfErwjbD4NHyiOFmqs3yO5lgEIFtU1/ZkBHerm/c7DRWklYi9ynLc24RAiM6/ytSdV5Q
        aPlIgg/Sk9k8/SFTYr6ZeLCzO/8Fh+pZG9R7g/A8+hRNBDVemLC7MnglZUBBTpp6aCUrsFR/mJGF+
        Jsau9qnQ==;
Received: from [2001:4bb8:18c:10bd:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVbdH-0007Zx-Js; Mon, 04 May 2020 13:59:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tim Waugh <tim@cyberelk.net>, Borislav Petkov <bp@alien8.de>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] hfs: stop using ioctl_by_bdev
Date:   Mon,  4 May 2020 15:59:24 +0200
Message-Id: <20200504135927.2835750-6-hch@lst.de>
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
---
 fs/hfs/mdb.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
index 460281b1299eb..cdf0edeeb2781 100644
--- a/fs/hfs/mdb.c
+++ b/fs/hfs/mdb.c
@@ -32,29 +32,35 @@
 static int hfs_get_last_session(struct super_block *sb,
 				sector_t *start, sector_t *size)
 {
-	struct cdrom_multisession ms_info;
-	struct cdrom_tocentry te;
-	int res;
+	struct cdrom_device_info *cdi = disk_to_cdi(sb->s_bdev->bd_disk);
 
 	/* default values */
 	*start = 0;
 	*size = i_size_read(sb->s_bdev->bd_inode) >> 9;
 
 	if (HFS_SB(sb)->session >= 0) {
+		struct cdrom_tocentry te;
+	
+		if (!cdi)
+			return -EINVAL;
+
 		te.cdte_track = HFS_SB(sb)->session;
 		te.cdte_format = CDROM_LBA;
-		res = ioctl_by_bdev(sb->s_bdev, CDROMREADTOCENTRY, (unsigned long)&te);
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
+
+		*start = (sector_t)te.cdte_addr.lba << 2;
+	} else if (cdi) {
+		struct cdrom_multisession ms_info;
+
+		ms_info.addr_format = CDROM_LBA;
+		if (cdrom_multisession(cdi, &ms_info) == 0 && ms_info.xa_flag)
+			*start = (sector_t)ms_info.addr.lba << 2;
 	}
-	ms_info.addr_format = CDROM_LBA;
-	res = ioctl_by_bdev(sb->s_bdev, CDROMMULTISESSION, (unsigned long)&ms_info);
-	if (!res && ms_info.xa_flag)
-		*start = (sector_t)ms_info.addr.lba << 2;
+
 	return 0;
 }
 
-- 
2.26.2

