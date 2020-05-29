Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3D91E8C29
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 01:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbgE2Xka (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 19:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728142AbgE2Xka (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 19:40:30 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AE9C08C5C9;
        Fri, 29 May 2020 16:40:30 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeoc0-000C4l-FP; Fri, 29 May 2020 23:40:28 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Don Brace <don.brace@microsemi.com>, linux-scsi@vger.kernel.org
Subject: [PATCH 3/4] hpsa: get rid of compat_alloc_user_space()
Date:   Sat, 30 May 2020 00:40:27 +0100
Message-Id: <20200529234028.46373-3-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200529234028.46373-1-viro@ZenIV.linux.org.uk>
References: <20200529233923.GL23230@ZenIV.linux.org.uk>
 <20200529234028.46373-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

no need for building a native struct on kernel stack, copying
it to userland one, then calling hpsa_ioctl() which copies it
back into _another_ instance of the same struct.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/scsi/hpsa.c | 80 ++++++++++++++++++++++++-----------------------------
 1 file changed, 36 insertions(+), 44 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 64fd97272109..c7fbe56891ef 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -254,6 +254,10 @@ static irqreturn_t do_hpsa_intr_intx(int irq, void *dev_id);
 static irqreturn_t do_hpsa_intr_msi(int irq, void *dev_id);
 static int hpsa_ioctl(struct scsi_device *dev, unsigned int cmd,
 		      void __user *arg);
+static int hpsa_passthru_ioctl(struct ctlr_info *h,
+			       IOCTL_Command_struct *iocommand);
+static int hpsa_big_passthru_ioctl(struct ctlr_info *h,
+				   BIG_IOCTL_Command_struct *ioc);
 
 #ifdef CONFIG_COMPAT
 static int hpsa_compat_ioctl(struct scsi_device *dev, unsigned int cmd,
@@ -6217,75 +6221,63 @@ static void cmd_free(struct ctlr_info *h, struct CommandList *c)
 static int hpsa_ioctl32_passthru(struct scsi_device *dev, unsigned int cmd,
 	void __user *arg)
 {
-	IOCTL32_Command_struct __user *arg32 =
-	    (IOCTL32_Command_struct __user *) arg;
+	struct ctlr_info *h = sdev_to_hba(dev);
+	IOCTL32_Command_struct __user *arg32 = arg;
 	IOCTL_Command_struct arg64;
-	IOCTL_Command_struct __user *p = compat_alloc_user_space(sizeof(arg64));
 	int err;
 	u32 cp;
 
-	memset(&arg64, 0, sizeof(arg64));
-	err = 0;
-	err |= copy_from_user(&arg64.LUN_info, &arg32->LUN_info,
-			   sizeof(arg64.LUN_info));
-	err |= copy_from_user(&arg64.Request, &arg32->Request,
-			   sizeof(arg64.Request));
-	err |= copy_from_user(&arg64.error_info, &arg32->error_info,
-			   sizeof(arg64.error_info));
-	err |= get_user(arg64.buf_size, &arg32->buf_size);
-	err |= get_user(cp, &arg32->buf);
-	arg64.buf = compat_ptr(cp);
-	err |= copy_to_user(p, &arg64, sizeof(arg64));
+	if (!arg)
+		return -EINVAL;
 
-	if (err)
+	memset(&arg64, 0, sizeof(arg64));
+	if (copy_from_user(&arg64, arg32, offsetof(IOCTL_Command_struct, buf)))
+		return -EFAULT;
+	if (get_user(cp, &arg32->buf))
 		return -EFAULT;
+	arg64.buf = compat_ptr(cp);
 
-	err = hpsa_ioctl(dev, CCISS_PASSTHRU, p);
+	if (atomic_dec_if_positive(&h->passthru_cmds_avail) < 0)
+		return -EAGAIN;
+	err = hpsa_passthru_ioctl(h, &arg64);
+	atomic_inc(&h->passthru_cmds_avail);
 	if (err)
 		return err;
-	err |= copy_in_user(&arg32->error_info, &p->error_info,
-			 sizeof(arg32->error_info));
-	if (err)
+	if (copy_to_user(&arg32->error_info, &arg64.error_info,
+			 sizeof(arg32->error_info)))
 		return -EFAULT;
-	return err;
+	return 0;
 }
 
 static int hpsa_ioctl32_big_passthru(struct scsi_device *dev,
 	unsigned int cmd, void __user *arg)
 {
-	BIG_IOCTL32_Command_struct __user *arg32 =
-	    (BIG_IOCTL32_Command_struct __user *) arg;
+	struct ctlr_info *h = sdev_to_hba(dev);
+	BIG_IOCTL32_Command_struct __user *arg32 = arg;
 	BIG_IOCTL_Command_struct arg64;
-	BIG_IOCTL_Command_struct __user *p =
-	    compat_alloc_user_space(sizeof(arg64));
 	int err;
 	u32 cp;
 
+	if (!arg)
+		return -EINVAL;
 	memset(&arg64, 0, sizeof(arg64));
-	err = 0;
-	err |= copy_from_user(&arg64.LUN_info, &arg32->LUN_info,
-			   sizeof(arg64.LUN_info));
-	err |= copy_from_user(&arg64.Request, &arg32->Request,
-			   sizeof(arg64.Request));
-	err |= copy_from_user(&arg64.error_info, &arg32->error_info,
-			   sizeof(arg64.error_info));
-	err |= get_user(arg64.buf_size, &arg32->buf_size);
-	err |= get_user(arg64.malloc_size, &arg32->malloc_size);
-	err |= get_user(cp, &arg32->buf);
-	arg64.buf = compat_ptr(cp);
-	err |= copy_to_user(p, &arg64, sizeof(arg64));
-
-	if (err)
+	if (copy_from_user(&arg64, arg32,
+			   offsetof(BIG_IOCTL32_Command_struct, buf)))
 		return -EFAULT;
+	if (get_user(cp, &arg32->buf))
+		return -EFAULT;
+	arg64.buf = compat_ptr(cp);
 
-	err = hpsa_ioctl(dev, CCISS_BIG_PASSTHRU, p);
+	if (atomic_dec_if_positive(&h->passthru_cmds_avail) < 0)
+		return -EAGAIN;
+	err = hpsa_big_passthru_ioctl(h, &arg64);
+	atomic_inc(&h->passthru_cmds_avail);
 	if (err)
 		return err;
-	err |= copy_in_user(&arg32->error_info, &p->error_info,
-			 sizeof(arg32->error_info));
-	if (err)
+	if (copy_to_user(&arg32->error_info, &arg64.error_info,
+			 sizeof(arg32->error_info)))
 		return -EFAULT;
-	return err;
+	return 0;
 }
 
 static int hpsa_compat_ioctl(struct scsi_device *dev, unsigned int cmd,
-- 
2.11.0

