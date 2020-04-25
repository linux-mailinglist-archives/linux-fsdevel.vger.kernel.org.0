Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA961B846E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Apr 2020 09:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgDYH5Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Apr 2020 03:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726107AbgDYH5Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Apr 2020 03:57:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6732C09B04A;
        Sat, 25 Apr 2020 00:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Q/yz6o88K4GebiwCkpvyx2+fDSD99ucotl90SX8TRcA=; b=Ys4A0Uo4ZTN6Ee/sogPT8kZZpo
        1pQSaM4ADcZfEIfViXJXVdv45w5dKKx61Edbpm0ngMt38+Yd7BfGewWWC1VGnX3tnbq3WCIGeU0Uu
        GV/ee7p/q0Jg0ECbdcXK8O9ObZfFDW6nohw4BzVJZkBTFgaTjNFU5MTUCVkaM9gDmQPoi8H+1aeOF
        rCfWQsqrsuEzWHi7IJLCqdpJXynSPGPDN0kxdm/4TiWlwWptzy44Qp1vHE8ak7c171IPeu0+L1IfG
        k9BSLOIXhFzkWKnKppDwsOiLAxrMgqSAaE+ABoR2VzI6WHKUgMLIgUsOlq8qhUeDZ0tsJ/r6LJ02y
        fCuXMpZw==;
Received: from [2001:4bb8:193:f203:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jSFgd-00022d-62; Sat, 25 Apr 2020 07:57:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tim Waugh <tim@cyberelk.net>, Borislav Petkov <bp@alien8.de>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 4/7] cdrom: factor out a cdrom_multisession helper
Date:   Sat, 25 Apr 2020 09:57:03 +0200
Message-Id: <20200425075706.721917-5-hch@lst.de>
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

Factor out a version of the CDROMMULTISESSION ioctl handler that can
be called directly from kernel space.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
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
2.26.1

