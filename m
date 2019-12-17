Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1020123957
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 23:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfLQWR7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 17:17:59 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:49789 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbfLQWR4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 17:17:56 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M9WmQ-1ie1lZ0nQ4-005V7i; Tue, 17 Dec 2019 23:17:33 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux-doc@vger.kernel.org, corbet@lwn.net, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 22/27] compat_ioctl: scsi: handle HDIO commands from drivers
Date:   Tue, 17 Dec 2019 23:17:03 +0100
Message-Id: <20191217221708.3730997-23-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191217221708.3730997-1-arnd@arndb.de>
References: <20191217221708.3730997-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:pSOIrqA4qJmN8oxuhXgjjmKQ4BKDNp8za+fcHrSHtYc7EmHxMCJ
 ttBmqAyhcKzs6ALP6XaKjK1eJRepY36qUdiG1Ymlv2tcIEYRshLq2jDytMfphz3+jMw7eED
 id44i00bAoVEZGiADfmkRWGK5ysYfQDl/ODvN/WylYpI/Cktg36r4HXzmChOoQKwPNw7hC/
 O3MQzKNY2II5A2Xp9GQdg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Xn6+UU1gPkE=:Bv08/Fta262/hxm73yaJG7
 y492BZ90Db600sYHwNqoIUQnWSm/atwksEsV1xp4NNp+CuzOfClXWkCfHdzavBqpGJCXYsADl
 vsmudpY7oDIEyFAjmwugJe7iYi4PjkrHdo5qZkpsN8w1DKViflSW2rPR2e5voJyJ9rox3y7iN
 plV4XfZj1mR3aln6NxFOC1UypUU90Ai+Cb6ebfnlEtP2XU6jXiXSJURAAK2v1MIUWklgOS+93
 zfO79A0IX1aK6C0kywszdTyW8pWLpkHrMHazzve/V23DJfGKpYm/he8UEA0WHkmJYk8GuYHt4
 kQxgpRdDZ7qUhlolIqv4eHS0sJ6gCxZb+xys2yDg3btFd+ZCKP2KXfpl1CPzp7MDxtQg0UQjo
 lKszOsvC3Q3ebmbqqaGdKnNmL+twKhlgxfXxc/kfcwIJ3xdo2j81H5rL0+fySEJrkup0JhbBc
 V9sX9uZEwtJxBF0KiPsIEmU7b2TJya1sdrM3dhSEriIPs0ATUHlFQerrOAYD8MoEbfcoMlcgz
 CeS7mhMKIjLCtQiyeOl4ZHCycZ5y4wVJJD/IXMu+J8tPrVU3F+6UeGGxgjukY6zzcK/CwUy9s
 AuB708Q3h1gujO3R0e0382zazvQo+ZbVSzds+5y6Mp5DgXoXRnjaSHH2w0sT6RP5iZMYOwlNe
 VS9VHsWdnczFV8kUE5ATZeyFAVeYgyjqQ5ptFuFU00D7Y1Tt7pyJE2f+3FEX26n40HkD/eivx
 xV4aJqVGW+KCy4QWKcu49XXy8bUUPvMiBKyWbdVFQCO3a9iGlYg9bSJaA7BeGjPCfdHTW7fgl
 CpIl21r4ov345QUtxFOnW8wJaGmk2O1kY3SohSN4rBQibpmDdrMyaZUAn81EfAk6wWFFR3TrJ
 SXCRbLBNlUDixrQa7A5Q==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The ata_sas_scsi_ioctl() function implements a number of HDIO_* commands
for SCSI devices, it is used by all libata drivers as well as a few
drivers that support SAS attached SATA drives.

The only command that is not safe for compat ioctls here is
HDIO_GET_32BIT. Change the implementation to check for in_compat_syscall()
in order to do both cases correctly, and change all callers to use it
as both native and compat callback pointers, including the indirect
callers through sas_ioctl and ata_scsi_ioctl.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/ata/libata-scsi.c              | 9 +++++++++
 drivers/scsi/aic94xx/aic94xx_init.c    | 3 +++
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c | 3 +++
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 3 +++
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 3 +++
 drivers/scsi/ipr.c                     | 3 +++
 drivers/scsi/isci/init.c               | 3 +++
 drivers/scsi/mvsas/mv_init.c           | 3 +++
 drivers/scsi/pm8001/pm8001_init.c      | 3 +++
 include/linux/libata.h                 | 6 ++++++
 10 files changed, 39 insertions(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 58e09ffe8b9c..eb2eb599e602 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -17,6 +17,7 @@
  *  - http://www.t13.org/
  */
 
+#include <linux/compat.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/blkdev.h>
@@ -761,6 +762,10 @@ static int ata_ioc32(struct ata_port *ap)
 	return 0;
 }
 
+/*
+ * This handles both native and compat commands, so anything added
+ * here must have a compatible argument, or check in_compat_syscall()
+ */
 int ata_sas_scsi_ioctl(struct ata_port *ap, struct scsi_device *scsidev,
 		     unsigned int cmd, void __user *arg)
 {
@@ -773,6 +778,10 @@ int ata_sas_scsi_ioctl(struct ata_port *ap, struct scsi_device *scsidev,
 		spin_lock_irqsave(ap->lock, flags);
 		val = ata_ioc32(ap);
 		spin_unlock_irqrestore(ap->lock, flags);
+#ifdef CONFIG_COMPAT
+		if (in_compat_syscall())
+			return put_user(val, (compat_ulong_t __user *)arg);
+#endif
 		return put_user(val, (unsigned long __user *)arg);
 
 	case HDIO_SET_32BIT:
diff --git a/drivers/scsi/aic94xx/aic94xx_init.c b/drivers/scsi/aic94xx/aic94xx_init.c
index f5781e31f57c..d022407e5645 100644
--- a/drivers/scsi/aic94xx/aic94xx_init.c
+++ b/drivers/scsi/aic94xx/aic94xx_init.c
@@ -54,6 +54,9 @@ static struct scsi_host_template aic94xx_sht = {
 	.eh_target_reset_handler	= sas_eh_target_reset_handler,
 	.target_destroy		= sas_target_destroy,
 	.ioctl			= sas_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl		= sas_ioctl,
+#endif
 	.track_queue_depth	= 1,
 };
 
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
index 3af53cc42bd6..fa25766502a2 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
@@ -1772,6 +1772,9 @@ static struct scsi_host_template sht_v1_hw = {
 	.eh_target_reset_handler = sas_eh_target_reset_handler,
 	.target_destroy		= sas_target_destroy,
 	.ioctl			= sas_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl		= sas_ioctl,
+#endif
 	.shost_attrs		= host_attrs_v1_hw,
 	.host_reset             = hisi_sas_host_reset,
 };
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index 61b1e2693b08..545eaff5f3ee 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -3551,6 +3551,9 @@ static struct scsi_host_template sht_v2_hw = {
 	.eh_target_reset_handler = sas_eh_target_reset_handler,
 	.target_destroy		= sas_target_destroy,
 	.ioctl			= sas_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl		= sas_ioctl,
+#endif
 	.shost_attrs		= host_attrs_v2_hw,
 	.host_reset		= hisi_sas_host_reset,
 };
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index bf5d5f138437..fa05e612d85a 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -3075,6 +3075,9 @@ static struct scsi_host_template sht_v3_hw = {
 	.eh_target_reset_handler = sas_eh_target_reset_handler,
 	.target_destroy		= sas_target_destroy,
 	.ioctl			= sas_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl		= sas_ioctl,
+#endif
 	.shost_attrs		= host_attrs_v3_hw,
 	.tag_alloc_policy	= BLK_TAG_ALLOC_RR,
 	.host_reset             = hisi_sas_host_reset,
diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index 079c04bc448a..ae45cbe98ae2 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -6727,6 +6727,9 @@ static struct scsi_host_template driver_template = {
 	.name = "IPR",
 	.info = ipr_ioa_info,
 	.ioctl = ipr_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = ipr_ioctl,
+#endif
 	.queuecommand = ipr_queuecommand,
 	.eh_abort_handler = ipr_eh_abort,
 	.eh_device_reset_handler = ipr_eh_dev_reset,
diff --git a/drivers/scsi/isci/init.c b/drivers/scsi/isci/init.c
index 1727d0c71b12..b48aac8dfcb8 100644
--- a/drivers/scsi/isci/init.c
+++ b/drivers/scsi/isci/init.c
@@ -168,6 +168,9 @@ static struct scsi_host_template isci_sht = {
 	.eh_target_reset_handler        = sas_eh_target_reset_handler,
 	.target_destroy			= sas_target_destroy,
 	.ioctl				= sas_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl			= sas_ioctl,
+#endif
 	.shost_attrs			= isci_host_attrs,
 	.track_queue_depth		= 1,
 };
diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
index da719b0694dc..7af9173c4925 100644
--- a/drivers/scsi/mvsas/mv_init.c
+++ b/drivers/scsi/mvsas/mv_init.c
@@ -47,6 +47,9 @@ static struct scsi_host_template mvs_sht = {
 	.eh_target_reset_handler = sas_eh_target_reset_handler,
 	.target_destroy		= sas_target_destroy,
 	.ioctl			= sas_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl		= sas_ioctl,
+#endif
 	.shost_attrs		= mvst_host_attrs,
 	.track_queue_depth	= 1,
 };
diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index ff618ad80ebd..3c6076e4c6d2 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -101,6 +101,9 @@ static struct scsi_host_template pm8001_sht = {
 	.eh_target_reset_handler = sas_eh_target_reset_handler,
 	.target_destroy		= sas_target_destroy,
 	.ioctl			= sas_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl		= sas_ioctl,
+#endif
 	.shost_attrs		= pm8001_host_attrs,
 	.track_queue_depth	= 1,
 };
diff --git a/include/linux/libata.h b/include/linux/libata.h
index d3bbfddf616a..e68d05febe5a 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1109,6 +1109,11 @@ extern void ata_host_init(struct ata_host *, struct device *, struct ata_port_op
 extern int ata_scsi_detect(struct scsi_host_template *sht);
 extern int ata_scsi_ioctl(struct scsi_device *dev, unsigned int cmd,
 			  void __user *arg);
+#ifdef CONFIG_COMPAT
+#define ATA_SCSI_COMPAT_IOCTL .compat_ioctl = ata_scsi_ioctl,
+#else
+#define ATA_SCSI_COMPAT_IOCTL /* empty */
+#endif
 extern int ata_scsi_queuecmd(struct Scsi_Host *h, struct scsi_cmnd *cmd);
 extern int ata_sas_scsi_ioctl(struct ata_port *ap, struct scsi_device *dev,
 			    unsigned int cmd, void __user *arg);
@@ -1340,6 +1345,7 @@ extern struct device_attribute *ata_common_sdev_attrs[];
 	.module			= THIS_MODULE,			\
 	.name			= drv_name,			\
 	.ioctl			= ata_scsi_ioctl,		\
+	ATA_SCSI_COMPAT_IOCTL					\
 	.queuecommand		= ata_scsi_queuecmd,		\
 	.can_queue		= ATA_DEF_QUEUE,		\
 	.tag_alloc_policy	= BLK_TAG_ALLOC_RR,		\
-- 
2.20.0

