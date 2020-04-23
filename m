Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A341B5554
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 09:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgDWHPE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 03:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgDWHPC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 03:15:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DAAC03C1AB;
        Thu, 23 Apr 2020 00:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=nWfIZmbU7Qrbff/0/Pgfe/+8nSWp45Nz1AnrZBwZ5Z4=; b=qj/fsWE3D7YZ/S1VSMh0J1PcHp
        L0H50uyUkcDxbgqPCv8xEkFanAuHfr9B4QQgNXueHpgVZOftkndl62xFr5nTxqGpSSlTyhjSVerar
        JbYRXlDk0Qz8nuvGv8mwGOQ+lJK3v8GAHxSjnh4p+MGvEyV9wB+y03v6OmxH2tqB0VrV428qpGDnM
        RwKUCde4Pt6M1CXsTfoJjkcJdtFpQCO3EOoEBSrYO91StaQv565vRsQrkSzsb0MBj75tEBkP3Cca1
        A/qco9rXBvo7TyuaFtuubaVV8JBhngN4hl0e5ttl0eKcebao1a08m4/QD00ZwUnGM/JBY0ihANO5Q
        bLrgtCjA==;
Received: from [2001:4bb8:188:40ac:46e:e5e4:1e64:2584] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRW4U-00006B-Ve; Thu, 23 Apr 2020 07:14:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tim Waugh <tim@cyberelk.net>, Borislav Petkov <bp@alien8.de>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] isofs: stop using ioctl_by_bdev
Date:   Thu, 23 Apr 2020 09:12:23 +0200
Message-Id: <20200423071224.500849-7-hch@lst.de>
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

Instead just call the CD-ROM layer functionality directly, and turn the
hot mess in isofs_get_last_session into remotely readable code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/isofs/inode.c | 54 +++++++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 62c0462dc89f..fc48923a9b6c 100644
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
+			return -EINVAL;
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
2.26.1

