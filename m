Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD4C1B8476
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Apr 2020 09:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgDYH5z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Apr 2020 03:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726140AbgDYH5Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Apr 2020 03:57:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D40C09B04A;
        Sat, 25 Apr 2020 00:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=iN058KjzLihwegdmbCnjqBTIYUWszTynShxhqrWnMxg=; b=XUE7EQJjNRXvwm4wQaG7sgsMvg
        e0A72bYcGGrzlA4A6UUS/x26AzBv5Stp4XUZrXhrmAMNMBDuHAz6hs8BcSoF4S7M4btdLrQEaJyEt
        uQiDwzKmSdcB//yKNd9BGvd2d60vO6fSVudZc619t6+pRI1WCVtb88hZyscGPxPVUEES2pfOH2ZUq
        XOntuUuJm6egAMp1ZbC+QyMF2wMZSzab2onsJOIBGVd80NuH883ekz7Ks7aXs4KYurUNgtoG3P2dQ
        4xR4xhIijwXS3j25xMN9FFWwWeTE8Q/Q5Q2DN2LbEjHJHrUVDxQ0zQBHgkUGiL0Fgc1cklRx3+v6B
        fd62jPKQ==;
Received: from [2001:4bb8:193:f203:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jSFgZ-000229-RU; Sat, 25 Apr 2020 07:57:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tim Waugh <tim@cyberelk.net>, Borislav Petkov <bp@alien8.de>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 3/7] cdrom: factor out a cdrom_read_tocentry helper
Date:   Sat, 25 Apr 2020 09:57:02 +0200
Message-Id: <20200425075706.721917-4-hch@lst.de>
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

Factor out a version of the CDROMREADTOCENTRY ioctl handler that can
be called directly from kernel space.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
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
2.26.1

