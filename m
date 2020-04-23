Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985811B5570
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 09:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgDWHPp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 03:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgDWHPD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 03:15:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2354C08ED7D;
        Thu, 23 Apr 2020 00:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=5AB5dfD4cOF4go8VoQp19niQnty9MJDxRJIwxRQua1k=; b=ZIQHeFRVnZ/TGoQeogHVuqeF70
        t21obQAG75Qh1GK1ZDq3vVljmPlTlcEuk20o6JVUxRAmflu95wpoYzdOH+0GCw6XkEUKRgjz6Ox3Q
        WRZvJ/MsCYuTVva3PnBu04/nFetQZxsmF9ws6fDnhsQnjYAF+vK3tpcu+gmhs+i3vVSBnLQM8HmPd
        YUYpt/CaS9xf9aRnRTbXJPmv2h+ZKUXfvgGbHEkzSS0uJf5sKkG4f1kR2Us+vwIJGcX4No3WVcRvt
        XSk29fFAvbfAfvzSXOWcJXo9RqHpwuE+goxmmIC9JTLT+Llf8gx55y3USQpntStdShV3YJ1T8DIxo
        DUWDB50g==;
Received: from [2001:4bb8:188:40ac:46e:e5e4:1e64:2584] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRW4P-0008VP-MG; Thu, 23 Apr 2020 07:14:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tim Waugh <tim@cyberelk.net>, Borislav Petkov <bp@alien8.de>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] cdrom: factor out a cdrom_multisession helper
Date:   Thu, 23 Apr 2020 09:12:21 +0200
Message-Id: <20200423071224.500849-5-hch@lst.de>
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

Factor out a version of the CDROMMULTISESSION: ioctl handler that can
be called directly from kernel space.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/cdrom/cdrom.c | 41 +++++++++++++++++++++++++----------------
 include/linux/cdrom.h |  2 ++
 2 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index c91d1e138214..06896c07b133 100644
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
index 008c4d79fa33..8543fa59da72 100644
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

