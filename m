Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416D71C3BE6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 16:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbgEDN75 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 09:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727831AbgEDN74 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 09:59:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F645C061A0E;
        Mon,  4 May 2020 06:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Ka8H9LU7jjrOu6CL+GRUkSnQIy14Y6G6eqXUck1b3aI=; b=t8tMGUiZowLTG8cHxfcwkZA4ED
        j39aST8d5FawvIvBw/Q/htIMt2238aIANRVAR4l2QWztC3tK2bqyt2hzl0RsVKK13V5KDec4mnqK/
        VmP2ib4rZsL4dy3GpFPZWe7fhWNp2brYvWAdyOgXuUsGyMW+EHC+LmRCP3d8CD+Oo0PLnYCuiMMRq
        LFqvjz/9lGqsGjwz1iNK4Wnu0f+1OgbVC4TMAn78z1jKn7FLuSy2XZ5Xvjtv4DHQyRbCigYbMIqB6
        po8i4Jt/hUifRQLyLjrnnp82/7yJaAAcJxzTKLClbXjTSuBznzDFhwa3r5EqmINB5UCiaxVYUjfQd
        iI2f/nCQ==;
Received: from [2001:4bb8:18c:10bd:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVbdC-0007ZM-Np; Mon, 04 May 2020 13:59:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tim Waugh <tim@cyberelk.net>, Borislav Petkov <bp@alien8.de>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 3/8] cdrom: factor out a cdrom_read_tocentry helper
Date:   Mon,  4 May 2020 15:59:22 +0200
Message-Id: <20200504135927.2835750-4-hch@lst.de>
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

Factor out a version of the CDROMREADTOCENTRY ioctl handler that can
be called directly from kernel space.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de
---
 drivers/cdrom/cdrom.c | 39 ++++++++++++++++++++++-----------------
 include/linux/cdrom.h |  3 +++
 2 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index a1d2112fd283f..c91d1e1382142 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -2666,32 +2666,37 @@ static int cdrom_ioctl_read_tochdr(struct cdrom_device_info *cdi,
 	return 0;
 }
 
+int cdrom_read_tocentry(struct cdrom_device_info *cdi,
+		struct cdrom_tocentry *entry)
+{
+	u8 requested_format = entry->cdte_format;
+	int ret;
+
+	if (requested_format != CDROM_MSF && requested_format != CDROM_LBA)
+		return -EINVAL;
+
+	/* make interface to low-level uniform */
+	entry->cdte_format = CDROM_MSF;
+	ret = cdi->ops->audio_ioctl(cdi, CDROMREADTOCENTRY, entry);
+	if (!ret)
+		sanitize_format(&entry->cdte_addr, &entry->cdte_format,
+				requested_format);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cdrom_read_tocentry);
+
 static int cdrom_ioctl_read_tocentry(struct cdrom_device_info *cdi,
 		void __user *argp)
 {
 	struct cdrom_tocentry entry;
-	u8 requested_format;
 	int ret;
 
-	/* cd_dbg(CD_DO_IOCTL, "entering CDROMREADTOCENTRY\n"); */
-
 	if (copy_from_user(&entry, argp, sizeof(entry)))
 		return -EFAULT;
-
-	requested_format = entry.cdte_format;
-	if (requested_format != CDROM_MSF && requested_format != CDROM_LBA)
-		return -EINVAL;
-	/* make interface to low-level uniform */
-	entry.cdte_format = CDROM_MSF;
-	ret = cdi->ops->audio_ioctl(cdi, CDROMREADTOCENTRY, &entry);
-	if (ret)
-		return ret;
-	sanitize_format(&entry.cdte_addr, &entry.cdte_format, requested_format);
-
-	if (copy_to_user(argp, &entry, sizeof(entry)))
+	ret = cdrom_read_tocentry(cdi, &entry);
+	if (!ret && copy_to_user(argp, &entry, sizeof(entry)))
 		return -EFAULT;
-	/* cd_dbg(CD_DO_IOCTL, "CDROMREADTOCENTRY successful\n"); */
-	return 0;
+	return ret;
 }
 
 static int cdrom_ioctl_play_msf(struct cdrom_device_info *cdi,
diff --git a/include/linux/cdrom.h b/include/linux/cdrom.h
index 4f74ce050253d..008c4d79fa332 100644
--- a/include/linux/cdrom.h
+++ b/include/linux/cdrom.h
@@ -94,6 +94,9 @@ struct cdrom_device_ops {
 			       struct packet_command *);
 };
 
+int cdrom_read_tocentry(struct cdrom_device_info *cdi,
+		struct cdrom_tocentry *entry);
+
 /* the general block_device operations structure: */
 extern int cdrom_open(struct cdrom_device_info *cdi, struct block_device *bdev,
 			fmode_t mode);
-- 
2.26.2

