Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4107B1E8C31
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 01:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgE2Xkl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 19:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728598AbgE2Xka (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 19:40:30 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB8CC08C5CA;
        Fri, 29 May 2020 16:40:30 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeoc0-000C4c-1v; Fri, 29 May 2020 23:40:28 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Don Brace <don.brace@microsemi.com>, linux-scsi@vger.kernel.org
Subject: [PATCH 1/4] hpsa passthrough: lift {BIG_,}IOCTL_Command_struct copy{in,out} into hpsa_ioctl()
Date:   Sat, 30 May 2020 00:40:25 +0100
Message-Id: <20200529234028.46373-1-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200529233923.GL23230@ZenIV.linux.org.uk>
References: <20200529233923.GL23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/scsi/hpsa.c | 116 +++++++++++++++++++++++++---------------------------
 1 file changed, 56 insertions(+), 60 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 1e9302e99d05..3344a06c938e 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -6358,37 +6358,33 @@ static int hpsa_getdrivver_ioctl(struct ctlr_info *h, void __user *argp)
 	return 0;
 }
 
-static int hpsa_passthru_ioctl(struct ctlr_info *h, void __user *argp)
+static int hpsa_passthru_ioctl(struct ctlr_info *h,
+			       IOCTL_Command_struct *iocommand)
 {
-	IOCTL_Command_struct iocommand;
 	struct CommandList *c;
 	char *buff = NULL;
 	u64 temp64;
 	int rc = 0;
 
-	if (!argp)
-		return -EINVAL;
 	if (!capable(CAP_SYS_RAWIO))
 		return -EPERM;
-	if (copy_from_user(&iocommand, argp, sizeof(iocommand)))
-		return -EFAULT;
-	if ((iocommand.buf_size < 1) &&
-	    (iocommand.Request.Type.Direction != XFER_NONE)) {
+	if ((iocommand->buf_size < 1) &&
+	    (iocommand->Request.Type.Direction != XFER_NONE)) {
 		return -EINVAL;
 	}
-	if (iocommand.buf_size > 0) {
-		buff = kmalloc(iocommand.buf_size, GFP_KERNEL);
+	if (iocommand->buf_size > 0) {
+		buff = kmalloc(iocommand->buf_size, GFP_KERNEL);
 		if (buff == NULL)
 			return -ENOMEM;
-		if (iocommand.Request.Type.Direction & XFER_WRITE) {
+		if (iocommand->Request.Type.Direction & XFER_WRITE) {
 			/* Copy the data into the buffer we created */
-			if (copy_from_user(buff, iocommand.buf,
-				iocommand.buf_size)) {
+			if (copy_from_user(buff, iocommand->buf,
+				iocommand->buf_size)) {
 				rc = -EFAULT;
 				goto out_kfree;
 			}
 		} else {
-			memset(buff, 0, iocommand.buf_size);
+			memset(buff, 0, iocommand->buf_size);
 		}
 	}
 	c = cmd_alloc(h);
@@ -6398,23 +6394,23 @@ static int hpsa_passthru_ioctl(struct ctlr_info *h, void __user *argp)
 	c->scsi_cmd = SCSI_CMD_BUSY;
 	/* Fill in Command Header */
 	c->Header.ReplyQueue = 0; /* unused in simple mode */
-	if (iocommand.buf_size > 0) {	/* buffer to fill */
+	if (iocommand->buf_size > 0) {	/* buffer to fill */
 		c->Header.SGList = 1;
 		c->Header.SGTotal = cpu_to_le16(1);
 	} else	{ /* no buffers to fill */
 		c->Header.SGList = 0;
 		c->Header.SGTotal = cpu_to_le16(0);
 	}
-	memcpy(&c->Header.LUN, &iocommand.LUN_info, sizeof(c->Header.LUN));
+	memcpy(&c->Header.LUN, &iocommand->LUN_info, sizeof(c->Header.LUN));
 
 	/* Fill in Request block */
-	memcpy(&c->Request, &iocommand.Request,
+	memcpy(&c->Request, &iocommand->Request,
 		sizeof(c->Request));
 
 	/* Fill in the scatter gather information */
-	if (iocommand.buf_size > 0) {
+	if (iocommand->buf_size > 0) {
 		temp64 = dma_map_single(&h->pdev->dev, buff,
-			iocommand.buf_size, DMA_BIDIRECTIONAL);
+			iocommand->buf_size, DMA_BIDIRECTIONAL);
 		if (dma_mapping_error(&h->pdev->dev, (dma_addr_t) temp64)) {
 			c->SG[0].Addr = cpu_to_le64(0);
 			c->SG[0].Len = cpu_to_le32(0);
@@ -6422,12 +6418,12 @@ static int hpsa_passthru_ioctl(struct ctlr_info *h, void __user *argp)
 			goto out;
 		}
 		c->SG[0].Addr = cpu_to_le64(temp64);
-		c->SG[0].Len = cpu_to_le32(iocommand.buf_size);
+		c->SG[0].Len = cpu_to_le32(iocommand->buf_size);
 		c->SG[0].Ext = cpu_to_le32(HPSA_SG_LAST); /* not chaining */
 	}
 	rc = hpsa_scsi_do_simple_cmd(h, c, DEFAULT_REPLY_QUEUE,
 					NO_TIMEOUT);
-	if (iocommand.buf_size > 0)
+	if (iocommand->buf_size > 0)
 		hpsa_pci_unmap(h->pdev, c, 1, DMA_BIDIRECTIONAL);
 	check_ioctl_unit_attention(h, c);
 	if (rc) {
@@ -6436,16 +6432,12 @@ static int hpsa_passthru_ioctl(struct ctlr_info *h, void __user *argp)
 	}
 
 	/* Copy the error information out */
-	memcpy(&iocommand.error_info, c->err_info,
-		sizeof(iocommand.error_info));
-	if (copy_to_user(argp, &iocommand, sizeof(iocommand))) {
-		rc = -EFAULT;
-		goto out;
-	}
-	if ((iocommand.Request.Type.Direction & XFER_READ) &&
-		iocommand.buf_size > 0) {
+	memcpy(&iocommand->error_info, c->err_info,
+		sizeof(iocommand->error_info));
+	if ((iocommand->Request.Type.Direction & XFER_READ) &&
+		iocommand->buf_size > 0) {
 		/* Copy the data out of the buffer we created */
-		if (copy_to_user(iocommand.buf, buff, iocommand.buf_size)) {
+		if (copy_to_user(iocommand->buf, buff, iocommand->buf_size)) {
 			rc = -EFAULT;
 			goto out;
 		}
@@ -6457,9 +6449,9 @@ static int hpsa_passthru_ioctl(struct ctlr_info *h, void __user *argp)
 	return rc;
 }
 
-static int hpsa_big_passthru_ioctl(struct ctlr_info *h, void __user *argp)
+static int hpsa_big_passthru_ioctl(struct ctlr_info *h,
+				   BIG_IOCTL_Command_struct *ioc)
 {
-	BIG_IOCTL_Command_struct *ioc;
 	struct CommandList *c;
 	unsigned char **buff = NULL;
 	int *buff_size = NULL;
@@ -6470,29 +6462,17 @@ static int hpsa_big_passthru_ioctl(struct ctlr_info *h, void __user *argp)
 	u32 sz;
 	BYTE __user *data_ptr;
 
-	if (!argp)
-		return -EINVAL;
 	if (!capable(CAP_SYS_RAWIO))
 		return -EPERM;
-	ioc = vmemdup_user(argp, sizeof(*ioc));
-	if (IS_ERR(ioc)) {
-		status = PTR_ERR(ioc);
-		goto cleanup1;
-	}
+
 	if ((ioc->buf_size < 1) &&
-	    (ioc->Request.Type.Direction != XFER_NONE)) {
-		status = -EINVAL;
-		goto cleanup1;
-	}
+	    (ioc->Request.Type.Direction != XFER_NONE))
+		return -EINVAL;
 	/* Check kmalloc limits  using all SGs */
-	if (ioc->malloc_size > MAX_KMALLOC_SIZE) {
-		status = -EINVAL;
-		goto cleanup1;
-	}
-	if (ioc->buf_size > ioc->malloc_size * SG_ENTRIES_IN_CMD) {
-		status = -EINVAL;
-		goto cleanup1;
-	}
+	if (ioc->malloc_size > MAX_KMALLOC_SIZE)
+		return -EINVAL;
+	if (ioc->buf_size > ioc->malloc_size * SG_ENTRIES_IN_CMD)
+		return -EINVAL;
 	buff = kcalloc(SG_ENTRIES_IN_CMD, sizeof(char *), GFP_KERNEL);
 	if (!buff) {
 		status = -ENOMEM;
@@ -6565,10 +6545,6 @@ static int hpsa_big_passthru_ioctl(struct ctlr_info *h, void __user *argp)
 
 	/* Copy the error information out */
 	memcpy(&ioc->error_info, c->err_info, sizeof(ioc->error_info));
-	if (copy_to_user(argp, ioc, sizeof(*ioc))) {
-		status = -EFAULT;
-		goto cleanup0;
-	}
 	if ((ioc->Request.Type.Direction & XFER_READ) && ioc->buf_size > 0) {
 		int i;
 
@@ -6594,7 +6570,6 @@ static int hpsa_big_passthru_ioctl(struct ctlr_info *h, void __user *argp)
 		kfree(buff);
 	}
 	kfree(buff_size);
-	kvfree(ioc);
 	return status;
 }
 
@@ -6628,18 +6603,39 @@ static int hpsa_ioctl(struct scsi_device *dev, unsigned int cmd,
 		return hpsa_getpciinfo_ioctl(h, argp);
 	case CCISS_GETDRIVVER:
 		return hpsa_getdrivver_ioctl(h, argp);
-	case CCISS_PASSTHRU:
+	case CCISS_PASSTHRU: {
+		IOCTL_Command_struct iocommand;
+
+		if (!argp)
+			return -EINVAL;
+		if (copy_from_user(&iocommand, argp, sizeof(iocommand)))
+			return -EFAULT;
 		if (atomic_dec_if_positive(&h->passthru_cmds_avail) < 0)
 			return -EAGAIN;
-		rc = hpsa_passthru_ioctl(h, argp);
+		rc = hpsa_passthru_ioctl(h, &iocommand);
 		atomic_inc(&h->passthru_cmds_avail);
+		if (!rc && copy_to_user(argp, &iocommand, sizeof(iocommand)))
+			rc = -EFAULT;
 		return rc;
-	case CCISS_BIG_PASSTHRU:
+	}
+	case CCISS_BIG_PASSTHRU: {
+		BIG_IOCTL_Command_struct *ioc;
+		if (!argp)
+			return -EINVAL;
 		if (atomic_dec_if_positive(&h->passthru_cmds_avail) < 0)
 			return -EAGAIN;
-		rc = hpsa_big_passthru_ioctl(h, argp);
+		ioc = vmemdup_user(argp, sizeof(*ioc));
+		if (IS_ERR(ioc)) {
+			atomic_inc(&h->passthru_cmds_avail);
+			return PTR_ERR(ioc);
+		}
+		rc = hpsa_big_passthru_ioctl(h, ioc);
 		atomic_inc(&h->passthru_cmds_avail);
+		if (!rc && copy_to_user(argp, ioc, sizeof(*ioc)))
+			rc = -EFAULT;
+		kvfree(ioc);
 		return rc;
+	}
 	default:
 		return -ENOTTY;
 	}
-- 
2.11.0

