Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 152D31B8465
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Apr 2020 09:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgDYH51 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Apr 2020 03:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726098AbgDYH50 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Apr 2020 03:57:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A06C09B049;
        Sat, 25 Apr 2020 00:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=DOhDQWJTIqg6uQvMzoVnirpUK+I+SnHs5deg5vip0Nc=; b=Sy56M4q4nAx+d1ghDl7bCoY9Nj
        dP0N9jkjcNTJYANbkR3T7E+ykMzKUFpMXINuOKN7d+1BwOeRR8hiyiRcOpeBZjMJhaTT6ItiXxV7j
        nTCkOKvjGJD7s+hu9X7d+2zfYRzOigZU84hZQr/sSjlofxLud5U3ued46vQxVImIS8W4Hxkx50Afy
        CsrUJROUK4NVxYx/EvYncKihnTBWfcRbG8rgq2c+koaivnIE4CjGqkUDSOL91vTJ/7pY4QsIKYchR
        LCKMXY2nsuoihuKQhN1n83FDJCw2wToEKztW3QK8Z9ShvEbInhV46tBApDXpSVc5ONCacly2xTy6/
        vTy/Qn8w==;
Received: from [2001:4bb8:193:f203:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jSFgf-00022v-J7; Sat, 25 Apr 2020 07:57:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tim Waugh <tim@cyberelk.net>, Borislav Petkov <bp@alien8.de>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 5/7] hfsplus: stop using ioctl_by_bdev
Date:   Sat, 25 Apr 2020 09:57:04 +0200
Message-Id: <20200425075706.721917-6-hch@lst.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200425075706.721917-1-hch@lst.de>
References: <20200425075706.721917-1-hch@lst.de>
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
2.26.1

