Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7981B5569
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 09:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgDWHPi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 03:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbgDWHPD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 03:15:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88481C03C1AB;
        Thu, 23 Apr 2020 00:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=WhaZzPS9Qvu/s1WLYaiKjaP7iKg56wB/u3yne7Uk/RA=; b=N05jbO4XfiXGjvwd3MR8wD2xaB
        g9aAu15byKvi9tLl+dOjkbRCt0m0MMf/AesEVNUh0tyuvPI3dXqR0s3ANH/IviVmC0GxCl6ekUiYT
        FM8KMj5oNfzy9CB/b5m8L4TzCcC8CdB5DgFqp9SLCRoZKMqNmfGqAqeXy0N15CqzWc3NuC4HdiBUw
        LiKq7W5J01NJLid0kI+R8VzpG3WEAbc0MnhBnQ3ml/HVgXrWjQWfCrG87UQG28gHyQmGGD4NZrtmY
        gAGgL3YEqi32Lg+WsEseUr/YQwsUqNdL8ljyvohsW/POfm6f8YbzYjrAQhsorny1miEfmAIp7Yn5k
        BvZiDwpw==;
Received: from [2001:4bb8:188:40ac:46e:e5e4:1e64:2584] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRW4S-00005a-DW; Thu, 23 Apr 2020 07:14:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tim Waugh <tim@cyberelk.net>, Borislav Petkov <bp@alien8.de>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] hfsplus: stop using ioctl_by_bdev
Date:   Thu, 23 Apr 2020 09:12:22 +0200
Message-Id: <20200423071224.500849-6-hch@lst.de>
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
 fs/hfsplus/wrapper.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/fs/hfsplus/wrapper.c b/fs/hfsplus/wrapper.c
index 08c1580bdf7a..61eec628805d 100644
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

