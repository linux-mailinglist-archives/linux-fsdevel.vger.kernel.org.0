Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34B21CA5EB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 10:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgEHISl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 04:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbgEHISl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 04:18:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC6BC05BD43;
        Fri,  8 May 2020 01:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=PThi5otuSmIv87sVwtTG8nfMFGAV/tBkGdHRgwma/LQ=; b=kjfsQYGail38WC8kyZ+p6PMRp9
        JNo3u24zU9ARRWd5LlGzFEa6bMcRSYaEVj3lPkoMwgcH7Xv2VlXF720v5QrVmMNl6x2EgFWgD9pkP
        jxr1/BxgnffJmhLLtLafFZx+jCzPR2mYfujXM5tZ2ti/yD/8vDHqYd6IzhamGmfnoSpod9RgWrIMe
        w4NCjKSljGsgpY5BO6q9Cp1fpnL+Y1GjOsdwckOUBKn3eI5EojEGORDDhc9TfEd4X/faJsktBN3f1
        Burhw+zkUsx5kS6nj48Ek01HgZ8KOL6jZLrTdny16q2E6lYC2wI5VNtRmKDw4FAs1tx9GsZ4GApU/
        EvRyBdRA==;
Received: from [2001:4bb8:180:9d3f:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWyDQ-0004XT-R9; Fri, 08 May 2020 08:18:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] hfs: stop using ioctl_by_bdev
Date:   Fri,  8 May 2020 10:18:28 +0200
Message-Id: <20200508081828.590158-2-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508081828.590158-1-hch@lst.de>
References: <20200508081828.590158-1-hch@lst.de>
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

