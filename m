Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8D11C3BF3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 16:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbgEDOAV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 10:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728191AbgEDN74 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 09:59:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3742BC03C1A7;
        Mon,  4 May 2020 06:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ufRuX5PQbB2jqqbHHg7fvKBAMJcv5Za1TaoOkXdfMXY=; b=MVJG1YAtRinzkEzc77kDCgeBH9
        E2TBXf7FyyOaRa3T6kJ3Qsyh5BKtEJUDAtTLZlVlO5WuS64bXuyPsePY3iWasACFbZ7Nknf8r3CKu
        tI4t0xd4bbybZGgj5DWRrcm/2+lJf1IUJ6fFSftIh59RTMhBkvpQFXmiJf+LkIYBWRlxWjNBQZwKT
        yrV1tsh3pV9MvgsiBOTmL585hMxnuHO9NlgdZ/IXGxMshmRRIH9sTSCS2mma7NaCqFvkMlYwxuc1o
        bbVFOS/lSiabwEvptHLgwwQAOkQRm7VoN8WleGgZ+ZKD28bQxkiGGteiZAUkAIliy0Nn+/Tx+w/fC
        pQs+kKYQ==;
Received: from [2001:4bb8:18c:10bd:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVbdM-0007aP-Dn; Mon, 04 May 2020 13:59:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tim Waugh <tim@cyberelk.net>, Borislav Petkov <bp@alien8.de>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 7/8] isofs: stop using ioctl_by_bdev
Date:   Mon,  4 May 2020 15:59:26 +0200
Message-Id: <20200504135927.2835750-8-hch@lst.de>
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

Instead just call the CDROM layer functionality directly, and turn the
hot mess in isofs_get_last_session into remotely readable code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de
---
 fs/isofs/inode.c | 54 +++++++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 62c0462dc89f3..276107cdaaf13 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -544,43 +544,41 @@ static int isofs_show_options(struct seq_file *m, struct dentry *root)
 
 static unsigned int isofs_get_last_session(struct super_block *sb, s32 session)
 {
-	struct cdrom_multisession ms_info;
-	unsigned int vol_desc_start;
-	struct block_device *bdev = sb->s_bdev;
-	int i;
+	struct cdrom_device_info *cdi = disk_to_cdi(sb->s_bdev->bd_disk);
+	unsigned int vol_desc_start = 0;
 
-	vol_desc_start=0;
-	ms_info.addr_format=CDROM_LBA;
 	if (session > 0) {
-		struct cdrom_tocentry Te;
-		Te.cdte_track=session;
-		Te.cdte_format=CDROM_LBA;
-		i = ioctl_by_bdev(bdev, CDROMREADTOCENTRY, (unsigned long) &Te);
-		if (!i) {
+		struct cdrom_tocentry te;
+
+		if (!cdi)
+			return 0;
+
+		te.cdte_track = session;
+		te.cdte_format = CDROM_LBA;
+		if (cdrom_read_tocentry(cdi, &te) == 0) {
 			printk(KERN_DEBUG "ISOFS: Session %d start %d type %d\n",
-				session, Te.cdte_addr.lba,
-				Te.cdte_ctrl&CDROM_DATA_TRACK);
-			if ((Te.cdte_ctrl&CDROM_DATA_TRACK) == 4)
-				return Te.cdte_addr.lba;
+				session, te.cdte_addr.lba,
+				te.cdte_ctrl & CDROM_DATA_TRACK);
+			if ((te.cdte_ctrl & CDROM_DATA_TRACK) == 4)
+				return te.cdte_addr.lba;
 		}
 
 		printk(KERN_ERR "ISOFS: Invalid session number or type of track\n");
 	}
-	i = ioctl_by_bdev(bdev, CDROMMULTISESSION, (unsigned long) &ms_info);
-	if (session > 0)
-		printk(KERN_ERR "ISOFS: Invalid session number\n");
-#if 0
-	printk(KERN_DEBUG "isofs.inode: CDROMMULTISESSION: rc=%d\n",i);
-	if (i==0) {
-		printk(KERN_DEBUG "isofs.inode: XA disk: %s\n",ms_info.xa_flag?"yes":"no");
-		printk(KERN_DEBUG "isofs.inode: vol_desc_start = %d\n", ms_info.addr.lba);
-	}
-#endif
-	if (i==0)
+
+	if (cdi) {
+		struct cdrom_multisession ms_info;
+
+		ms_info.addr_format = CDROM_LBA;
+		if (cdrom_multisession(cdi, &ms_info) == 0) {
 #if WE_OBEY_THE_WRITTEN_STANDARDS
-		if (ms_info.xa_flag) /* necessary for a valid ms_info.addr */
+			/* necessary for a valid ms_info.addr */
+			if (ms_info.xa_flag)
 #endif
-			vol_desc_start=ms_info.addr.lba;
+				vol_desc_start = ms_info.addr.lba;
+		}
+	}
+
 	return vol_desc_start;
 }
 
-- 
2.26.2

