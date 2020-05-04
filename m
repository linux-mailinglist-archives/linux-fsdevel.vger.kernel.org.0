Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8961C3BED
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 16:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbgEDOAV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 10:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728165AbgEDN74 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 09:59:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E808C0610D6;
        Mon,  4 May 2020 06:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=WjxZKoRIKfO4ZrZvf/DLMSa0ugerjjYcPKsjotVpyb0=; b=OoQjpj5XgRMCw9fvjUr+p7wIPS
        0mI54aJz14KheaZBW6dbWbZOfHxvTofwPA9GtYEbAlfA+2qzUh04S9tXrOmnms6/cZ5SEs1CmepbU
        qaTU6lF6dE1n72pfIJYPAUn8upmFFrzs/90j9G90zKNfsL3XUk3GL9op1gTyyXhVCSDuIHODmq1wO
        41OwwXIs1uXmIHwUEKFZ18gj2XgVEoOM2XzZRul9Um0SBPVjzdWdG6abYwgq2rHVUYRIb+5fIjVM3
        Dk8MgMzrO28ISVrwwOqFcfC8tZL9o1lDudh+X6HbYg00n9SoQO4GOyV7HehP2ZTK14yskP8k1Bxrz
        unEDh2RQ==;
Received: from [2001:4bb8:18c:10bd:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVbdF-0007Za-5t; Mon, 04 May 2020 13:59:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tim Waugh <tim@cyberelk.net>, Borislav Petkov <bp@alien8.de>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 4/8] cdrom: factor out a cdrom_multisession helper
Date:   Mon,  4 May 2020 15:59:23 +0200
Message-Id: <20200504135927.2835750-5-hch@lst.de>
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

Factor out a version of the CDROMMULTISESSION ioctl handler that can
be called directly from kernel space.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de
---
 drivers/cdrom/cdrom.c | 41 +++++++++++++++++++++++++----------------
 include/linux/cdrom.h |  2 ++
 2 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index c91d1e1382142..06896c07b1333 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -2295,37 +2295,46 @@ static int cdrom_read_cdda(struct cdrom_device_info *cdi, __u8 __user *ubuf,
 	return cdrom_read_cdda_old(cdi, ubuf, lba, nframes);	
 }
 
-static int cdrom_ioctl_multisession(struct cdrom_device_info *cdi,
-		void __user *argp)
+int cdrom_multisession(struct cdrom_device_info *cdi,
+		struct cdrom_multisession *info)
 {
-	struct cdrom_multisession ms_info;
 	u8 requested_format;
 	int ret;
 
-	cd_dbg(CD_DO_IOCTL, "entering CDROMMULTISESSION\n");
-
 	if (!(cdi->ops->capability & CDC_MULTI_SESSION))
 		return -ENOSYS;
 
-	if (copy_from_user(&ms_info, argp, sizeof(ms_info)))
-		return -EFAULT;
-
-	requested_format = ms_info.addr_format;
+	requested_format = info->addr_format;
 	if (requested_format != CDROM_MSF && requested_format != CDROM_LBA)
 		return -EINVAL;
-	ms_info.addr_format = CDROM_LBA;
+	info->addr_format = CDROM_LBA;
 
-	ret = cdi->ops->get_last_session(cdi, &ms_info);
-	if (ret)
-		return ret;
+	ret = cdi->ops->get_last_session(cdi, info);
+	if (!ret)
+		sanitize_format(&info->addr, &info->addr_format,
+				requested_format);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cdrom_multisession);
 
-	sanitize_format(&ms_info.addr, &ms_info.addr_format, requested_format);
+static int cdrom_ioctl_multisession(struct cdrom_device_info *cdi,
+		void __user *argp)
+{
+	struct cdrom_multisession info;
+	int ret;
+
+	cd_dbg(CD_DO_IOCTL, "entering CDROMMULTISESSION\n");
 
-	if (copy_to_user(argp, &ms_info, sizeof(ms_info)))
+	if (copy_from_user(&info, argp, sizeof(info)))
+		return -EFAULT;
+	ret = cdrom_multisession(cdi, &info);
+	if (ret)
+		return ret;
+	if (copy_to_user(argp, &info, sizeof(info)))
 		return -EFAULT;
 
 	cd_dbg(CD_DO_IOCTL, "CDROMMULTISESSION successful\n");
-	return 0;
+	return ret;
 }
 
 static int cdrom_ioctl_eject(struct cdrom_device_info *cdi)
diff --git a/include/linux/cdrom.h b/include/linux/cdrom.h
index 008c4d79fa332..8543fa59da720 100644
--- a/include/linux/cdrom.h
+++ b/include/linux/cdrom.h
@@ -94,6 +94,8 @@ struct cdrom_device_ops {
 			       struct packet_command *);
 };
 
+int cdrom_multisession(struct cdrom_device_info *cdi,
+		struct cdrom_multisession *info);
 int cdrom_read_tocentry(struct cdrom_device_info *cdi,
 		struct cdrom_tocentry *entry);
 
-- 
2.26.2

