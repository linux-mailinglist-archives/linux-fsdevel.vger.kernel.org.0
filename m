Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9CF99FF2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 21:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391876AbfHVTZ1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 15:25:27 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40465 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404359AbfHVTZ0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 15:25:26 -0400
Received: by mail-pl1-f193.google.com with SMTP id h3so4012693pls.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2019 12:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qQ2h0fFa9vcEZCdLdpejDWu7hMGGOs+HzjS3pQo3ERk=;
        b=UL0/4/NlizyQZrpC8KUKf4Ui7S6eRxjhhLO6i1FqATlEj1f5F0IG0sS6unIgKfXlru
         OGyk3Kgg1kNVkZVx4MAoqTBQ0rdGHHHBDZJOaAWfPNHOCFCFd6Taq49N4ml+VIzctel7
         9g9TPIXfTHfv8xJ4624pBztqoqZUBRLg6xSOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qQ2h0fFa9vcEZCdLdpejDWu7hMGGOs+HzjS3pQo3ERk=;
        b=gUmyq9lb4jT2rx3eSJGakr+0HttyPixeH2OuHJ1kQ6VZVrPDTm9VSeAYthP0yfvaDh
         kvKOKCKwuDlne+JRWxBhVbUu/HuEZqN3Wwo1rz3T8dzv4wdCsTMS7y9fpLfTNYON25Bd
         eWDLVC+1AD+alzP9KNHwexU2mE87coYokzp6Tysv9r0EtjAeu//nuy9Jiwu9BlMnLTjt
         Ctkww81kAfx1ZbVQ/S4pN7g8OJGOlCSkjkhntxlz5amgcjUM7U8KVlXIPaBwQz8snhsx
         Qd6HNwZcQoyYibFMlAwJ5ATdfLlvZ6KoCDPoGDjnqV7b8MYRc0pvPkG2Ey5tl48IGXlR
         ksqw==
X-Gm-Message-State: APjAAAVb2BulaMBEGCNy/1fK5d46n5hr1rYby9UlFR0nGFO/8VqKZ+NK
        6ehSs1VgAE59vDSmaV3nT8k3cQ==
X-Google-Smtp-Source: APXvYqxl4SarFJrqODlPydAIqJjiZbX1TZo26H0jepQ55yHpaDKV3DR6zaM5hWV99gEikOAvfGK7lA==
X-Received: by 2002:a17:902:d686:: with SMTP id v6mr466378ply.134.1566501922066;
        Thu, 22 Aug 2019 12:25:22 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id c12sm198018pfc.22.2019.08.22.12.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 12:25:21 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>,
        Desmond Yan <desmond.yan@broadcom.com>,
        James Hu <james.hu@broadcom.com>
Subject: [PATCH 6/7] misc: bcm-vk: add Broadcom Valkyrie driver
Date:   Thu, 22 Aug 2019 12:24:50 -0700
Message-Id: <20190822192451.5983-7-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190822192451.5983-1-scott.branden@broadcom.com>
References: <20190822192451.5983-1-scott.branden@broadcom.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add Broadcom Valkyrie driver offload engine.
This driver interfaces to the Valkyrie PCIe offload engine to perform
should offload functions as video transcoding on multiple streams
in parallel.  Valkyrie device is booted from files loaded using
request_firmware_into_buf mechanism.  After booted card status is updated
and messages can then be sent to the card.
Such messages contain scatter gather list of addresses
to pull data from the host to perform operations on.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Desmond Yan <desmond.yan@broadcom.com>
Signed-off-by: James Hu <james.hu@broadcom.com>
---
 drivers/misc/Kconfig             |    1 +
 drivers/misc/Makefile            |    1 +
 drivers/misc/bcm-vk/Kconfig      |   16 +
 drivers/misc/bcm-vk/Makefile     |    7 +
 drivers/misc/bcm-vk/README       |   29 +
 drivers/misc/bcm-vk/bcm_vk.h     |  229 +++++
 drivers/misc/bcm-vk/bcm_vk_dev.c | 1558 ++++++++++++++++++++++++++++++
 drivers/misc/bcm-vk/bcm_vk_msg.c |  963 ++++++++++++++++++
 drivers/misc/bcm-vk/bcm_vk_msg.h |  169 ++++
 drivers/misc/bcm-vk/bcm_vk_sg.c  |  273 ++++++
 drivers/misc/bcm-vk/bcm_vk_sg.h  |   60 ++
 11 files changed, 3306 insertions(+)
 create mode 100644 drivers/misc/bcm-vk/Kconfig
 create mode 100644 drivers/misc/bcm-vk/Makefile
 create mode 100644 drivers/misc/bcm-vk/README
 create mode 100644 drivers/misc/bcm-vk/bcm_vk.h
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_dev.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_msg.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_msg.h
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_sg.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_sg.h

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 16900357afc2..67c1c2154c31 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -501,6 +501,7 @@ source "drivers/misc/genwqe/Kconfig"
 source "drivers/misc/echo/Kconfig"
 source "drivers/misc/cxl/Kconfig"
 source "drivers/misc/ocxl/Kconfig"
+source "drivers/misc/bcm-vk/Kconfig"
 source "drivers/misc/cardreader/Kconfig"
 source "drivers/misc/habanalabs/Kconfig"
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index abd8ae249746..c72a9a5335ca 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_VEXPRESS_SYSCFG)	+= vexpress-syscfg.o
 obj-$(CONFIG_CXL_BASE)		+= cxl/
 obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
 obj-$(CONFIG_OCXL)		+= ocxl/
+obj-$(CONFIG_BCM_VK)		+= bcm-vk/
 obj-y				+= cardreader/
 obj-$(CONFIG_PVPANIC)   	+= pvpanic.o
 obj-$(CONFIG_HABANA_AI)		+= habanalabs/
diff --git a/drivers/misc/bcm-vk/Kconfig b/drivers/misc/bcm-vk/Kconfig
new file mode 100644
index 000000000000..92a28f048d06
--- /dev/null
+++ b/drivers/misc/bcm-vk/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Broadcom VK device
+#
+config BCM_VK
+	tristate "Support for Broadcom Valkyrie Accelerators (VK)"
+	depends on PCI_MSI
+	default m
+	help
+	  Select this option to enable support for Broadcom
+	  Valkyrie Accelerators (VK).  VK is used for performing
+	  specific video offload processing.  This driver enables
+	  userspace programs to access these accelerators via /dev/bcm-vk.N
+	  devices.
+
+	  If unsure, say N.
diff --git a/drivers/misc/bcm-vk/Makefile b/drivers/misc/bcm-vk/Makefile
new file mode 100644
index 000000000000..7bc48ca9c60b
--- /dev/null
+++ b/drivers/misc/bcm-vk/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for Broadcom VK driver
+#
+
+obj-$(CONFIG_BCM_VK) += bcm_vk.o
+bcm_vk-objs := bcm_vk_dev.o bcm_vk_msg.o bcm_vk_sg.o
diff --git a/drivers/misc/bcm-vk/README b/drivers/misc/bcm-vk/README
new file mode 100644
index 000000000000..1ec806455965
--- /dev/null
+++ b/drivers/misc/bcm-vk/README
@@ -0,0 +1,29 @@
+Valkyrie Card Status using SysFS
+================================
+
+The bcm-vk driver supports the query of the Valkyrie card status using the
+SysFs entry.
+
+A Group attribute is created to report the valkyrie card status
+(vk-card-status) and different status values are consolidated under the
+card status group.
+
+The organization of the card status is given below.
+
+The group is created under the following : /sysfs/devices/<pci device number>/
+
+vk-card-status/
+	firmware-status
+	firmware-version
+	voltage		---> reports the 1.8v and 3.3v voltage rail readings
+	temperature	---> reports the current temperature of the soc
+
+The sysfs entry supports only the read operation.
+
+Example:
+To read the temperature from a PCIe device at 65:00.0:
+cat /sys/devices/pci0000:64/0000:64:00.0/0000:65:00.0/vk-card-status/voltage
+
+where
+	/sys/devices/pci0000:64/0000:64:00.0/0000:65:00.0/ --> path of bcm-vk device
+	vk-card-status/voltage --> current voltage reading from the card
diff --git a/drivers/misc/bcm-vk/bcm_vk.h b/drivers/misc/bcm-vk/bcm_vk.h
new file mode 100644
index 000000000000..9c7476a8dc0b
--- /dev/null
+++ b/drivers/misc/bcm-vk/bcm_vk.h
@@ -0,0 +1,229 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2018-2019 Broadcom.
+ */
+
+#ifndef BCM_VK_H
+#define BCM_VK_H
+
+#include <linux/pci.h>
+#include <linux/irq.h>
+#include <linux/miscdevice.h>
+#include <linux/mutex.h>
+#include <linux/uaccess.h>
+#include <linux/version.h>
+
+#include "bcm_vk_msg.h"
+
+/*
+ * Load Image is completed in two stages:
+ *
+ * 1) When the VK device boot-up, M7 CPU runs and executes the BootROM.
+ * The Secure Boot Loader (SBL) as part of the BootROM will run
+ * fastboot to open up ITCM for host to push BOOT1 image.
+ * SBL will authenticate the image before jumping to BOOT1 image.
+ *
+ * 2) Because BOOT1 image is a secured image, we also called it the
+ * Secure Boot Image (SBI). At second stage, SBI will initialize DDR
+ * and run fastboot for host to push BOOT2 image to DDR.
+ * SBI will authenticate the image before jumping to BOOT2 image.
+ *
+ */
+/* Location of registers of interest in BAR0 */
+/* Fastboot request for Secure Boot Loader (SBL) */
+#define BAR_CODEPUSH_SBL		0x400
+/* Fastboot progress */
+#define BAR_FB_OPEN			0x404
+/* Fastboot request for Secure Boot Image (SBI) */
+#define BAR_CODEPUSH_SBI		0x408
+#define BAR_CARD_STATUS			0x410
+#define BAR_FW_STATUS			0x41C
+#define BAR_METADATA_VERSION		0x440
+#define BAR_FIRMWARE_VERSION		0x444
+#define BAR_CHIP_ID			0x448
+#define BAR_CARD_TEMPERATURE		0x45C
+#define BAR_CARD_VOLTAGE		0x460
+#define BAR_CARD_ERR_LOG		0x464
+#define BAR_CARD_ERR_MEM		0x468
+#define BAR_CARD_PWR_AND_THRE		0x46C
+#define BAR_FIRMWARE_TAG		0x220000
+
+#define CODEPUSH_BOOT1_ENTRY		0x00400000
+#define CODEPUSH_BOOT2_ENTRY		0x60000000
+#define CODEPUSH_MASK			0xFFFFF000
+#define CODEPUSH_FASTBOOT		BIT(0)
+#define SRAM_OPEN			BIT(16)
+#define DDR_OPEN			BIT(17)
+
+/* FW_STATUS definitions */
+#define FW_STATUS_RELOCATION_ENTRY	BIT(0)
+#define FW_STATUS_RELOCATION_EXIT	BIT(1)
+#define FW_STATUS_INIT_START		BIT(2)
+#define FW_STATUS_ARCH_INIT_DONE	BIT(3)
+#define FW_STATUS_PRE_KNL1_INIT_DONE	BIT(4)
+#define FW_STATUS_PRE_KNL2_INIT_DONE	BIT(5)
+#define FW_STATUS_POST_KNL_INIT_DONE	BIT(6)
+#define FW_STATUS_INIT_DONE		BIT(7)
+#define FW_STATUS_APP_INIT_START	BIT(8)
+#define FW_STATUS_APP_INIT_DONE		BIT(9)
+#define FW_STATUS_MASK			0xFFFFFFFF
+#define FW_STATUS_READY			(FW_STATUS_INIT_START | \
+					 FW_STATUS_ARCH_INIT_DONE | \
+					 FW_STATUS_PRE_KNL1_INIT_DONE | \
+					 FW_STATUS_PRE_KNL2_INIT_DONE | \
+					 FW_STATUS_POST_KNL_INIT_DONE | \
+					 FW_STATUS_INIT_DONE | \
+					 FW_STATUS_APP_INIT_START | \
+					 FW_STATUS_APP_INIT_DONE)
+
+/* Deinit */
+#define FW_STATUS_APP_DEINIT_START	BIT(23)
+#define FW_STATUS_APP_DEINIT_DONE	BIT(24)
+#define FW_STATUS_DRV_DEINIT_START	BIT(25)
+#define FW_STATUS_DRV_DEINIT_DONE	BIT(26)
+#define FW_STATUS_RESET_DONE		BIT(27)
+#define FW_STATUS_DEINIT_TRIGGERED	(FW_STATUS_APP_DEINIT_START | \
+					 FW_STATUS_APP_DEINIT_DONE  | \
+					 FW_STATUS_DRV_DEINIT_START | \
+					 FW_STATUS_DRV_DEINIT_DONE)
+
+/* Last nibble for reboot reason */
+#define FW_STATUS_RESET_REASON_SHIFT	28
+#define FW_STATUS_RESET_REASON_MASK	(0xF << FW_STATUS_RESET_REASON_SHIFT)
+#define FW_STATUS_RESET_MBOX_DB		(0x1 << FW_STATUS_RESET_REASON_SHIFT)
+#define FW_STATUS_RESET_M7_WDOG		(0x2 << FW_STATUS_RESET_REASON_SHIFT)
+#define FW_STATUS_RESET_TEMP		(0x3 << FW_STATUS_RESET_REASON_SHIFT)
+#define FW_STATUS_RESET_PCI_FLR		(0x4 << FW_STATUS_RESET_REASON_SHIFT)
+#define FW_STATUS_RESET_PCI_HOT		(0x5 << FW_STATUS_RESET_REASON_SHIFT)
+#define FW_STATUS_RESET_PCI_WARM	(0x6 << FW_STATUS_RESET_REASON_SHIFT)
+#define FW_STATUS_RESET_PCI_COLD	(0x7 << FW_STATUS_RESET_REASON_SHIFT)
+#define FW_STATUS_RESET_UNKNOWN		(0xF << FW_STATUS_RESET_REASON_SHIFT)
+
+/* FW_STATUS definitions end */
+
+/* Card OS Firmware version size */
+#define BAR_FIRMWARE_TAG_SIZE		50
+#define FIRMWARE_STATUS_PRE_INIT_DONE	0x1F
+
+/* Fastboot firmware loader status definitions */
+#define FW_LOADER_ACK_SEND_MORE_DATA	BIT(18)
+#define FW_LOADER_ACK_IN_PROGRESS	BIT(19)
+#define FW_LOADER_ACK_RCVD_ALL_DATA	BIT(20)
+
+/* Error log register bit definition - register for error alerts */
+#define ERR_LOG_ALERT_ECC		BIT(0)
+#define ERR_LOG_ALERT_SSIM_BUSY		BIT(1)
+#define ERR_LOG_ALERT_AFBC_BUSY		BIT(2)
+#define ERR_LOG_HIGH_TEMP_ERR		BIT(3)
+#define ERR_LOG_MEM_ALLOC_FAIL		BIT(8)
+#define ERR_LOG_LOW_TEMP_WARN		BIT(9)
+
+/* Fast boot register derived states */
+#define FB_BOOT_STATE_MASK		0xFFF3FFFF
+#define FB_BOOT1_RUNNING		(DDR_OPEN | 0x6)
+#define FB_BOOT2_RUNNING		(FW_LOADER_ACK_RCVD_ALL_DATA | 0x6)
+
+/* VK MSG_ID defines */
+#define VK_MSG_ID_BITMAP_SIZE		4096
+#define VK_MSG_ID_BITMAP_MASK		(VK_MSG_ID_BITMAP_SIZE - 1)
+#define VK_MSG_ID_OVERFLOW		0xFFFF
+
+/* VK device supports a maximum of 3 bars */
+#define MAX_BAR	3
+enum pci_barno {
+	BAR_0 = 0,
+	BAR_1,
+	BAR_2
+};
+
+struct bcm_vk {
+	struct pci_dev *pdev;
+	void __iomem *bar[MAX_BAR];
+	int num_irqs;
+
+	/* mutex to protect the ioctls */
+	struct mutex mutex;
+	struct miscdevice miscdev;
+	int misc_devid; /* dev id allocated */
+
+	/* Reference-counting to handle file operations */
+	struct kref kref;
+
+	spinlock_t msg_id_lock;
+	uint16_t msg_id;
+	DECLARE_BITMAP(bmap, VK_MSG_ID_BITMAP_SIZE);
+	spinlock_t ctx_lock;
+	struct bcm_vk_ctx ctx[VK_CMPT_CTX_MAX];
+	struct bcm_vk_ht_entry pid_ht[VK_PID_HT_SZ];
+	struct task_struct *reset_ppid; /* process that issue reset */
+
+	bool msgq_inited; /* indicate if info has been synced with vk */
+	struct bcm_vk_msg_chan h2vk_msg_chan;
+	struct bcm_vk_msg_chan vk2h_msg_chan;
+
+	struct workqueue_struct *wq_thread;
+	struct work_struct wq_work; /* work queue for deferred job */
+	unsigned long wq_offload; /* various flags on wq requested */
+	void *tdma_vaddr; /* test dma segment virtual addr */
+	dma_addr_t tdma_addr; /* test dma segment bus addr */
+
+	struct notifier_block panic_nb;
+};
+
+/* wq offload work items bits definitions */
+#define BCM_VK_WQ_DWNLD_PEND	0
+#define BCM_VK_WQ_DWNLD_AUTO	1
+
+static inline u32 vkread32(struct bcm_vk *vk,
+			   enum pci_barno bar,
+			   uint64_t offset)
+{
+	u32 value;
+
+	value = ioread32(vk->bar[bar] + offset);
+	return value;
+}
+
+static inline void vkwrite32(struct bcm_vk *vk,
+			     u32 value,
+			     enum pci_barno bar,
+			     uint64_t offset)
+{
+	iowrite32(value, vk->bar[bar] + offset);
+}
+
+static inline u8 vkread8(struct bcm_vk *vk,
+			 enum pci_barno bar,
+			 uint64_t offset)
+{
+	u8 value;
+
+	value = ioread8(vk->bar[bar] + offset);
+	return value;
+}
+
+static inline void vkwrite8(struct bcm_vk *vk,
+			    u8 value,
+			    enum pci_barno bar,
+			    uint64_t offset)
+{
+	iowrite8(value, vk->bar[bar] + offset);
+}
+
+int bcm_vk_open(struct inode *inode, struct file *p_file);
+ssize_t bcm_vk_read(struct file *p_file, char __user *buf, size_t count,
+		    loff_t *f_pos);
+ssize_t bcm_vk_write(struct file *p_file, const char __user *buf,
+		     size_t count, loff_t *f_pos);
+int bcm_vk_release(struct inode *inode, struct file *p_file);
+void bcm_vk_release_data(struct kref *kref);
+irqreturn_t bcm_vk_irqhandler(int irq, void *dev_id);
+int bcm_vk_msg_init(struct bcm_vk *vk);
+void bcm_vk_msg_remove(struct bcm_vk *vk);
+int bcm_vk_sync_msgq(struct bcm_vk *vk);
+int bcm_vk_send_shutdown_msg(struct bcm_vk *vk, uint32_t shut_type, pid_t pid);
+void bcm_vk_trigger_reset(struct bcm_vk *vk);
+void bcm_h2vk_doorbell(struct bcm_vk *vk, uint32_t q_num, uint32_t db_val);
+int bcm_vk_auto_load_all_images(struct bcm_vk *vk);
+
+#endif
diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
new file mode 100644
index 000000000000..a3d29cd85de4
--- /dev/null
+++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
@@ -0,0 +1,1558 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2018-2019 Broadcom.
+ */
+
+#include <linux/delay.h>
+#include <linux/firmware.h>
+#include <linux/fs.h>
+#include <linux/idr.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/pci_regs.h>
+#include <linux/sched/signal.h>
+#include <linux/sizes.h>
+#include <uapi/linux/misc/bcm_vk.h>
+
+#include "bcm_vk.h"
+
+#define DRV_MODULE_NAME		"bcm-vk"
+
+#define PCI_DEVICE_ID_VALKYRIE	0x5E87
+
+static DEFINE_IDA(bcm_vk_ida);
+
+/* Location of memory base addresses of interest in BAR1 */
+/* Load Boot1 to start of ITCM */
+#define BAR1_CODEPUSH_BASE_BOOT1	0x100000
+/* Load Boot2 to start of DDR0 */
+#define BAR1_CODEPUSH_BASE_BOOT2	0x300000
+/* Allow minimum 1s for Load Image timeout responses */
+#define LOAD_IMAGE_TIMEOUT_MS		1000
+/* Allow extended time for maximum Load Image timeout responses */
+#define LOAD_IMAGE_EXT_TIMEOUT_MS	30000
+
+#define VK_MSIX_IRQ_MAX			3
+
+#define BCM_VK_DMA_BITS			64
+
+#define BCM_VK_MIN_RESET_TIME_SEC	2
+
+#define BCM_VK_BOOT1_STARTUP_TIME_MS    (3 * MSEC_PER_SEC)
+
+#define BCM_VK_BUS_SYMLINK_NAME		"pci"
+
+/* defines for voltage rail conversion */
+#define BCM_VK_VOLT_RAIL_MASK		0xFFFF
+#define BCM_VK_3P3_VOLT_REG_SHIFT	16
+
+/* defines for power and temp threshold, all fields have same width */
+#define BCM_VK_PWR_AND_THRE_FIELD_MASK	0xFF
+#define BCM_VK_LOW_TEMP_THRE_SHIFT	0
+#define BCM_VK_HIGH_TEMP_THRE_SHIFT	8
+#define BCM_VK_PWR_STATE_SHIFT		16
+
+/* defines for mem err, all fields have same width */
+#define BCM_VK_MEM_ERR_FIELD_MASK	0xFF
+#define BCM_VK_INT_MEM_ERR_SHIFT	0
+#define BCM_VK_EXT_MEM_ERR_SHIFT	8
+
+/* a macro to get an individual field with mask and shift */
+#define BCM_VK_EXTRACT_FIELD(_field, _reg, _mask, _shift) \
+	(_field = (((_reg) >> (_shift)) & (_mask)))
+
+/*
+ * check if PCIe interface is down on read.  Use it when it is
+ * certain that _val should never be all ones.
+ */
+#define BCM_VK_INTF_IS_DOWN(_val)          ((_val) == 0xFFFFFFFF)
+#define BCM_VK_BITS_NOT_SET(_val, _bitmask) \
+	(((_val) & (_bitmask)) != (_bitmask))
+
+/*
+ * deinit time for the card os after receiving doorbell,
+ * 2 seconds should be enough
+ */
+#define BCM_VK_DEINIT_TIME_MS    (2 * MSEC_PER_SEC)
+
+/*
+ * module parameters
+ */
+static bool auto_load = true;
+module_param(auto_load, bool, 0444);
+MODULE_PARM_DESC(auto_load,
+		 "Load images automatically at PCIe probe time.\n");
+uint nr_scratch_pages = VK_BAR1_SCRATCH_DEF_NR_PAGES;
+module_param(nr_scratch_pages, uint, 0444);
+MODULE_PARM_DESC(nr_scratch_pages,
+		 "Number of pre allocated DMAable coherent pages.\n");
+
+/* structure that is used to faciliate displaying of register content */
+struct bcm_vk_sysfs_reg_entry {
+	const uint32_t mask;
+	const uint32_t exp_val;
+	const char *str;
+};
+
+struct bcm_vk_sysfs_reg_list {
+	const uint64_t offset;
+	struct bcm_vk_sysfs_reg_entry const *tab;
+	const uint32_t size;
+	const char *hdr;
+};
+
+static int bcm_vk_sysfs_dump_reg(uint32_t reg_val,
+				 struct bcm_vk_sysfs_reg_entry const *entry_tab,
+				 const uint32_t table_size, char *buf)
+{
+	uint32_t i, masked_val;
+	struct bcm_vk_sysfs_reg_entry const *entry;
+	char *p_buf = buf;
+	int ret;
+
+	for (i = 0; i < table_size; i++) {
+		entry = &entry_tab[i];
+		masked_val = entry->mask & reg_val;
+		if (masked_val == entry->exp_val) {
+			ret = sprintf(p_buf, "  [0x%08x]    : %s\n",
+				      masked_val, entry->str);
+			if (ret < 0)
+				return ret;
+
+			p_buf += ret;
+		}
+	}
+
+	return (p_buf - buf);
+}
+
+static long bcm_vk_get_metadata(struct bcm_vk *vk, struct vk_metadata *arg)
+{
+	struct device *dev = &vk->pdev->dev;
+	struct vk_metadata metadata;
+	long ret = 0;
+
+	metadata.version = vkread32(vk, BAR_0, BAR_METADATA_VERSION);
+	dev_dbg(dev, "version=0x%x\n", metadata.version);
+	metadata.card_status = vkread32(vk, BAR_0, BAR_CARD_STATUS);
+	dev_dbg(dev, "card_status=0x%x\n", metadata.card_status);
+	metadata.firmware_version = vkread32(vk, BAR_0, BAR_FIRMWARE_VERSION);
+	dev_dbg(dev, "firmware_version=0x%x\n", metadata.firmware_version);
+	metadata.fw_status = vkread32(vk, BAR_0, BAR_FW_STATUS);
+	dev_dbg(dev, "fw_status=0x%x\n", metadata.fw_status);
+
+	if (copy_to_user(arg, &metadata, sizeof(metadata)))
+		ret = -EFAULT;
+
+	return ret;
+}
+
+static inline int bcm_vk_wait(struct bcm_vk *vk, enum pci_barno bar,
+			      uint64_t offset, u32 mask, u32 value,
+			      unsigned long timeout_ms)
+{
+	struct device *dev = &vk->pdev->dev;
+	unsigned long timeout = jiffies + msecs_to_jiffies(timeout_ms);
+	u32 rd_val;
+
+	do {
+		rd_val = vkread32(vk, bar, offset);
+		dev_dbg(dev, "BAR%d Offset=0x%llx: 0x%x\n",
+			bar, offset, rd_val);
+
+		if (time_after(jiffies, timeout))
+			return -ETIMEDOUT;
+
+		cpu_relax();
+		cond_resched();
+	} while ((rd_val & mask) != value);
+
+	return 0;
+}
+
+static int bcm_vk_load_image_by_type(struct bcm_vk *vk, u32 load_type,
+				     const char *filename)
+{
+	struct device *dev = &vk->pdev->dev;
+	const struct firmware *fw;
+	void *bufp;
+	size_t max_buf;
+	int ret;
+	uint64_t offset_codepush;
+	u32 codepush;
+
+	if (load_type == VK_IMAGE_TYPE_BOOT1) {
+		codepush = CODEPUSH_FASTBOOT + CODEPUSH_BOOT1_ENTRY;
+		offset_codepush = BAR_CODEPUSH_SBL;
+
+		/* Write a 1 to request SRAM open bit */
+		vkwrite32(vk, CODEPUSH_FASTBOOT, BAR_0, offset_codepush);
+
+		/* Wait for VK to respond */
+		ret = bcm_vk_wait(vk, BAR_0, BAR_FB_OPEN, SRAM_OPEN, SRAM_OPEN,
+				  LOAD_IMAGE_TIMEOUT_MS);
+		if (ret < 0) {
+			dev_err(dev, "boot1 timeout\n");
+			goto err_out;
+		}
+
+		bufp = vk->bar[BAR_1] + BAR1_CODEPUSH_BASE_BOOT1;
+		max_buf = SZ_256K;
+	} else if (load_type == VK_IMAGE_TYPE_BOOT2) {
+		codepush = CODEPUSH_BOOT2_ENTRY;
+		offset_codepush = BAR_CODEPUSH_SBI;
+
+		/* Wait for VK to respond */
+		ret = bcm_vk_wait(vk, BAR_0, BAR_FB_OPEN, DDR_OPEN, DDR_OPEN,
+				  LOAD_IMAGE_TIMEOUT_MS);
+		if (ret < 0) {
+			dev_err(dev, "boot2 timeout\n");
+			goto err_out;
+		}
+
+		bufp = vk->bar[BAR_2];
+		max_buf = SZ_64M;
+	} else {
+		dev_err(dev, "Error invalid image type 0x%x\n", load_type);
+		ret = -EINVAL;
+		goto err_out;
+	}
+
+	ret = request_firmware_into_buf(&fw, filename, dev,
+					bufp, max_buf, 0,
+					KERNEL_PREAD_FLAG_PART);
+	if (ret) {
+		dev_err(dev, "Error %d requesting firmware file: %s\n",
+			ret, filename);
+		goto err_out;
+	}
+	dev_dbg(dev, "size=0x%zx\n", fw->size);
+
+	dev_dbg(dev, "Signaling 0x%x to 0x%llx\n", codepush, offset_codepush);
+	vkwrite32(vk, codepush, BAR_0, offset_codepush);
+
+	if (load_type == VK_IMAGE_TYPE_BOOT1) {
+
+		/* allow minimal time for boot1 to run */
+		msleep(2 * MSEC_PER_SEC);
+
+		/* wait until done */
+		ret = bcm_vk_wait(vk, BAR_0, BAR_FB_OPEN,
+				  FB_BOOT1_RUNNING,
+				  FB_BOOT1_RUNNING,
+				  BCM_VK_BOOT1_STARTUP_TIME_MS);
+		if (ret) {
+			dev_err(dev,
+				"Timeout %ld ms waiting for boot1 to come up\n",
+				BCM_VK_BOOT1_STARTUP_TIME_MS);
+			goto err_firmware_out;
+		}
+
+	} else if (load_type == VK_IMAGE_TYPE_BOOT2) {
+		/* To send more data to VK than max_buf allowed at a time */
+		do {
+			/* Wait for VK to move data from BAR space */
+			ret = bcm_vk_wait(vk, BAR_0, BAR_FB_OPEN,
+					  FW_LOADER_ACK_IN_PROGRESS,
+					  FW_LOADER_ACK_IN_PROGRESS,
+					  LOAD_IMAGE_EXT_TIMEOUT_MS);
+			if (ret < 0)
+				dev_dbg(dev, "boot2 timeout - transfer in progress\n");
+
+			/* Wait for VK to acknowledge if it received all data */
+			ret = bcm_vk_wait(vk, BAR_0, BAR_FB_OPEN,
+					  FW_LOADER_ACK_RCVD_ALL_DATA,
+					  FW_LOADER_ACK_RCVD_ALL_DATA,
+					  LOAD_IMAGE_EXT_TIMEOUT_MS);
+			if (ret < 0)
+				dev_dbg(dev, "boot2 timeout - received all data\n");
+			else
+				break; /* VK received all data, break out */
+
+			/* Wait for VK to request to send more data */
+			ret = bcm_vk_wait(vk, BAR_0, BAR_FB_OPEN,
+					  FW_LOADER_ACK_SEND_MORE_DATA,
+					  FW_LOADER_ACK_SEND_MORE_DATA,
+					  LOAD_IMAGE_EXT_TIMEOUT_MS);
+			if (ret < 0) {
+				dev_err(dev, "boot2 timeout - data send\n");
+				break;
+			}
+
+			/* Wait for VK to open BAR space to copy new data */
+			ret = bcm_vk_wait(vk, BAR_0, BAR_FB_OPEN,
+					  DDR_OPEN, DDR_OPEN,
+					  LOAD_IMAGE_EXT_TIMEOUT_MS);
+			if (ret == 0) {
+				ret = request_firmware_into_buf(
+							&fw,
+							filename,
+							dev, bufp,
+							max_buf,
+							fw->size,
+							KERNEL_PREAD_FLAG_PART);
+				if (ret) {
+					dev_err(dev, "Error %d requesting firmware file: %s offset: 0x%zx\n",
+						ret, filename,
+						fw->size);
+					goto err_firmware_out;
+				}
+				dev_dbg(dev, "size=0x%zx\n", fw->size);
+				dev_dbg(dev, "Signaling 0x%x to 0x%llx\n",
+					codepush, offset_codepush);
+				vkwrite32(vk, codepush, BAR_0, offset_codepush);
+			}
+		} while (1);
+
+		/* Initialize Message Q if we are loading boot2 */
+		/* wait for fw status bits to indicate app ready */
+		ret = bcm_vk_wait(vk, BAR_0, BAR_FW_STATUS,
+				  FW_STATUS_READY,
+				  FW_STATUS_READY,
+				  LOAD_IMAGE_TIMEOUT_MS);
+		if (ret < 0) {
+			dev_err(dev, "Boot2 not ready - timeout\n");
+			goto err_firmware_out;
+		}
+
+		/* sync queues when card os is up */
+		if (bcm_vk_sync_msgq(vk)) {
+			dev_err(dev, "Boot2 Error reading comm msg Q info\n");
+			ret = -EIO;
+			goto err_firmware_out;
+		}
+	}
+
+err_firmware_out:
+	release_firmware(fw);
+
+err_out:
+	return ret;
+}
+
+static u32 bcm_vk_next_boot_image(struct bcm_vk *vk)
+{
+	uint32_t fb_open = vkread32(vk, BAR_0, BAR_FB_OPEN);
+	u32 load_type = 0;  /* default for unknown */
+
+	if (!BCM_VK_INTF_IS_DOWN(fb_open) && (fb_open & SRAM_OPEN))
+		load_type = VK_IMAGE_TYPE_BOOT1;
+	else if (fb_open == FB_BOOT1_RUNNING)
+		load_type = VK_IMAGE_TYPE_BOOT2;
+
+	/*
+	 * TO_FIX: For now, like to know what value we get everytime
+	 *         for debugging.
+	 */
+	dev_info(&vk->pdev->dev, "FB_OPEN value on deciding next image: 0x%x\n",
+		 fb_open);
+
+	return load_type;
+}
+
+int bcm_vk_auto_load_all_images(struct bcm_vk *vk)
+{
+	int ret = 0;
+	struct device *dev = &vk->pdev->dev;
+	static struct _load_image_tab {
+		const uint32_t image_type;
+		const char *image_name;
+	} image_tab[] = {
+		{VK_IMAGE_TYPE_BOOT1, VK_BOOT1_DEF_FILENAME},
+		{VK_IMAGE_TYPE_BOOT2, VK_BOOT2_DEF_FILENAME},
+	};
+	uint32_t i;
+	uint32_t curr_type;
+	const char *curr_name;
+
+	/* log a message to know the relative loading order */
+	dev_info(&vk->pdev->dev, "Load All for device %d\n", vk->misc_devid);
+
+	for (i = 0; i < ARRAY_SIZE(image_tab); i++) {
+
+		curr_type = image_tab[i].image_type;
+		if (bcm_vk_next_boot_image(vk) == curr_type) {
+
+			curr_name = image_tab[i].image_name;
+			ret = bcm_vk_load_image_by_type(vk, curr_type,
+							curr_name);
+			dev_info(dev, "Auto load %s, ret %d\n",
+				 curr_name, ret);
+
+			if (ret) {
+				dev_err(dev, "Error loading default %s\n",
+					curr_name);
+				goto bcm_vk_auto_load_all_exit;
+			}
+		}
+	}
+
+bcm_vk_auto_load_all_exit:
+	return ret;
+
+}
+
+static int bcm_vk_trigger_autoload(struct bcm_vk *vk)
+{
+	if (test_and_set_bit(BCM_VK_WQ_DWNLD_PEND, &vk->wq_offload) != 0)
+		return -EPERM;
+
+	set_bit(BCM_VK_WQ_DWNLD_AUTO, &vk->wq_offload);
+	queue_work(vk->wq_thread, &vk->wq_work);
+
+	return 0;
+}
+
+static long bcm_vk_load_image(struct bcm_vk *vk, struct vk_image *arg)
+{
+	int ret;
+	struct device *dev = &vk->pdev->dev;
+	struct vk_image image;
+	u32 next_loadable;
+
+	if (copy_from_user(&image, arg, sizeof(image))) {
+		ret = -EACCES;
+		goto bcm_vk_load_image_exit;
+	}
+
+	/* first check if fw is at the right state for the download */
+	next_loadable = bcm_vk_next_boot_image(vk);
+	if (next_loadable != image.type) {
+		dev_err(dev, "Next expected image %u, Loading %u\n",
+			next_loadable, image.type);
+		ret = -EPERM;
+		goto bcm_vk_load_image_exit;
+	}
+
+	/*
+	 * if something is pending download already.  This could only happen
+	 * for now when the driver is being loaded, or if someone has issued
+	 * another download command in another shell.
+	 */
+	if (test_and_set_bit(BCM_VK_WQ_DWNLD_PEND, &vk->wq_offload) != 0) {
+		dev_err(dev, "Download operation already pending.\n");
+		return -EPERM;
+	}
+
+	ret = bcm_vk_load_image_by_type(vk, image.type, image.filename);
+	clear_bit(BCM_VK_WQ_DWNLD_PEND, &vk->wq_offload);
+
+bcm_vk_load_image_exit:
+	return ret;
+}
+
+static long bcm_vk_access_bar(struct bcm_vk *vk, struct vk_access *arg)
+{
+	struct device *dev = &vk->pdev->dev;
+	struct vk_access access;
+	long ret = 0;
+	u32 value;
+	long i;
+	long num;
+
+	if (copy_from_user(&access, arg, sizeof(struct vk_access))) {
+		ret = -EACCES;
+		goto err_out;
+	}
+	dev_dbg(dev, "barno=0x%x\n", access.barno);
+	dev_dbg(dev, "type=0x%x\n", access.type);
+	if (access.type == VK_ACCESS_READ) {
+		dev_dbg(dev, "read barno:%d offset:0x%llx len:0x%x\n",
+			access.barno, access.offset, access.len);
+		num = access.len / sizeof(u32);
+		for (i = 0; i < num; i++) {
+			value = vkread32(vk, access.barno,
+					 access.offset + (i * sizeof(u32)));
+			ret = put_user(value, access.data + i);
+			if (ret)
+				goto err_out;
+
+			dev_dbg(dev, "0x%x\n", value);
+		}
+	} else if (access.type == VK_ACCESS_WRITE) {
+		dev_dbg(dev, "write barno:%d offset:0x%llx len:0x%x\n",
+			access.barno, access.offset, access.len);
+		num = access.len / sizeof(u32);
+		for (i = 0; i < num; i++) {
+			ret = get_user(value, access.data + i);
+			if (ret)
+				goto err_out;
+
+			vkwrite32(vk, value, access.barno,
+				  access.offset + (i * sizeof(u32)));
+			dev_dbg(dev, "0x%x\n", value);
+		}
+	} else {
+		dev_dbg(dev, "error\n");
+		ret = -EINVAL;
+		goto err_out;
+	}
+err_out:
+	return ret;
+}
+
+static int bcm_vk_reset_successful(struct bcm_vk *vk)
+{
+	struct device *dev = &vk->pdev->dev;
+	u32 fw_status, reset_reason;
+	int ret = -EAGAIN;
+
+	/*
+	 * Reset could be triggered when the card in several state:
+	 *   i)   in bootROM
+	 *   ii)  after boot1
+	 *   iii) boot2 running
+	 *
+	 * i) & ii) - no status bits will be updated.  If vkboot1
+	 * runs automatically after reset, it  will update the reason
+	 * to be unknown reason
+	 * iii) - reboot reason match + deinit done.
+	 */
+	fw_status = vkread32(vk, BAR_0, BAR_FW_STATUS);
+	/* immediate exit if interface goes down */
+	if (BCM_VK_INTF_IS_DOWN(fw_status)) {
+		dev_err(dev, "PCIe Intf Down!\n");
+		goto bcm_vk_reset_exit;
+	}
+
+	/* initial check on reset reason */
+	reset_reason = (fw_status & FW_STATUS_RESET_REASON_MASK);
+	if ((reset_reason == FW_STATUS_RESET_MBOX_DB)
+	     || (reset_reason == FW_STATUS_RESET_UNKNOWN))
+		ret = 0;
+
+	/*
+	 * if some of the deinit bits are set, but done
+	 * bit is not, this is a failure if triggered while boot2 is running
+	 */
+	if ((fw_status & FW_STATUS_DEINIT_TRIGGERED)
+	    && !(fw_status & FW_STATUS_RESET_DONE))
+		ret = -EAGAIN;
+
+bcm_vk_reset_exit:
+	dev_dbg(dev, "FW status = 0x%x ret %d\n", fw_status, ret);
+
+	return ret;
+}
+
+static long bcm_vk_reset(struct bcm_vk *vk, struct vk_reset *arg)
+{
+	struct device *dev = &vk->pdev->dev;
+	struct vk_reset reset;
+	int ret = 0;
+	int i;
+
+	if (copy_from_user(&reset, arg, sizeof(struct vk_reset))) {
+		ret = -EACCES;
+		goto err_out;
+	}
+	dev_info(dev, "Issue Reset 0x%x, 0x%x\n", reset.arg1, reset.arg2);
+	if (reset.arg2 < BCM_VK_MIN_RESET_TIME_SEC)
+		reset.arg2 = BCM_VK_MIN_RESET_TIME_SEC;
+
+	/*
+	 * The following is the sequence of reset:
+	 * - send card level graceful shut down
+	 * - wait enough time for VK to handle its business, stopping DMA etc
+	 * - kill host apps
+	 * - Trigger interrupt with DB
+	 */
+	bcm_vk_send_shutdown_msg(vk, VK_SHUTDOWN_GRACEFUL, 0);
+
+	spin_lock(&vk->ctx_lock);
+	if (!vk->reset_ppid) {
+		vk->reset_ppid = current;
+	} else {
+		dev_err(dev, "Reset already launched by process pid %d\n",
+			task_pid_nr(vk->reset_ppid));
+		ret = -EACCES;
+	}
+	spin_unlock(&vk->ctx_lock);
+	if (ret)
+		goto err_out;
+
+	/* sleep time as specified by user in seconds, which is arg2 */
+	msleep(reset.arg2 * MSEC_PER_SEC);
+
+	spin_lock(&vk->ctx_lock);
+	for (i = 0; i < VK_PID_HT_SZ; i++) {
+
+		struct bcm_vk_ctx *ctx;
+
+		list_for_each_entry(ctx, &vk->pid_ht[i].head, node) {
+			if (ctx->ppid != vk->reset_ppid) {
+				dev_dbg(dev, "Send kill signal to pid %d\n",
+					task_pid_nr(ctx->ppid));
+				kill_pid(task_pid(ctx->ppid), SIGKILL, 1);
+			}
+		}
+	}
+	spin_unlock(&vk->ctx_lock);
+	if (ret)
+		goto err_out;
+
+	bcm_vk_trigger_reset(vk);
+
+	/*
+	 * Wait enough time for card os to deinit + populate the reset
+	 * reason.
+	 */
+	msleep(BCM_VK_DEINIT_TIME_MS);
+
+	ret = bcm_vk_reset_successful(vk);
+
+err_out:
+	return ret;
+}
+
+static int bcm_vk_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct bcm_vk_ctx *ctx = file->private_data;
+	struct bcm_vk *vk = container_of(ctx->miscdev, struct bcm_vk, miscdev);
+	unsigned long pg_size;
+
+	/* only BAR2 is mmap possible, which is bar num 4 due to 64bit */
+#define VK_MMAPABLE_BAR	   4
+
+	pg_size = ((pci_resource_len(vk->pdev, VK_MMAPABLE_BAR) - 1)
+		    >> PAGE_SHIFT) + 1;
+	if (vma->vm_pgoff + vma_pages(vma) > pg_size)
+		return -EINVAL;
+
+	vma->vm_pgoff += (pci_resource_start(vk->pdev, VK_MMAPABLE_BAR)
+			  >> PAGE_SHIFT);
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+
+	return io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
+				  vma->vm_end - vma->vm_start,
+				  vma->vm_page_prot);
+}
+
+static long bcm_vk_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	long ret = -EINVAL;
+	struct bcm_vk_ctx *ctx = file->private_data;
+	struct bcm_vk *vk = container_of(ctx->miscdev, struct bcm_vk, miscdev);
+	void __user *argp = (void __user *)arg;
+
+	dev_dbg(&vk->pdev->dev,
+		"ioctl, cmd=0x%02x, arg=0x%02lx\n",
+		cmd, arg);
+
+	mutex_lock(&vk->mutex);
+
+	switch (cmd) {
+	case VK_IOCTL_GET_METADATA:
+		ret = bcm_vk_get_metadata(vk, argp);
+		break;
+
+	case VK_IOCTL_LOAD_IMAGE:
+		ret = bcm_vk_load_image(vk, argp);
+		break;
+
+	case VK_IOCTL_ACCESS_BAR:
+		ret = bcm_vk_access_bar(vk, argp);
+		break;
+
+	case VK_IOCTL_RESET:
+		ret = bcm_vk_reset(vk, argp);
+		break;
+
+	default:
+		break;
+	}
+
+	mutex_unlock(&vk->mutex);
+
+	return ret;
+}
+
+static int bcm_vk_sysfs_chk_fw_status(struct bcm_vk *vk, uint32_t mask,
+				      char *buf, const char *err_log)
+{
+	uint32_t fw_status;
+	int ret = 0;
+
+	/* if card OS is not running, no one will update the value */
+	fw_status = vkread32(vk, BAR_0, BAR_FW_STATUS);
+	if (BCM_VK_INTF_IS_DOWN(fw_status))
+		return sprintf(buf, "PCIe Intf Down!\n");
+	else if (BCM_VK_BITS_NOT_SET(fw_status, mask))
+		return sprintf(buf, err_log);
+
+	return ret;
+}
+
+static int bcm_vk_sysfs_get_tag(struct bcm_vk *vk, enum pci_barno barno,
+				uint32_t offset, char *buf, const char *fmt)
+{
+	uint32_t magic;
+
+#define REL_MAGIC_TAG         0x68617368   /* this stands for "hash" */
+
+	magic = vkread32(vk, barno, offset);
+	return sprintf(buf, fmt, (magic == REL_MAGIC_TAG) ?
+		       (char *)(vk->bar[barno] + offset + sizeof(magic)) : "");
+}
+
+static ssize_t temperature_sensor_1_show(struct device *dev,
+					 struct device_attribute *devattr,
+					 char *buf)
+{
+	unsigned int temperature = 0; /* default if invalid */
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct bcm_vk *vk = pci_get_drvdata(pdev);
+
+	temperature = vkread32(vk, BAR_0, BAR_CARD_TEMPERATURE);
+
+	dev_dbg(dev, "Temperature_sensor_1 : %u Celsius\n", temperature);
+	return sprintf(buf, "%d\n", temperature);
+}
+
+static ssize_t voltage_18_mv_show(struct device *dev,
+				  struct device_attribute *devattr, char *buf)
+{
+	unsigned int voltage;
+	unsigned int volt_1p8;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct bcm_vk *vk = pci_get_drvdata(pdev);
+
+	voltage = vkread32(vk, BAR_0, BAR_CARD_VOLTAGE);
+	volt_1p8 = voltage & BCM_VK_VOLT_RAIL_MASK;
+
+	dev_dbg(dev, "[1.8v] : %u mV\n", volt_1p8);
+	return sprintf(buf, "%d\n", volt_1p8);
+}
+
+static ssize_t voltage_33_mv_show(struct device *dev,
+				  struct device_attribute *devattr, char *buf)
+{
+	unsigned int voltage;
+	unsigned int volt_3p3 = 0;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct bcm_vk *vk = pci_get_drvdata(pdev);
+
+	voltage = vkread32(vk, BAR_0, BAR_CARD_VOLTAGE);
+	volt_3p3 = (voltage >> BCM_VK_3P3_VOLT_REG_SHIFT)
+		    & BCM_VK_VOLT_RAIL_MASK;
+
+	dev_dbg(dev, "[3.3v] : %u mV\n", volt_3p3);
+	return sprintf(buf, "%d\n", volt_3p3);
+}
+
+static ssize_t chip_id_show(struct device *dev,
+			    struct device_attribute *devattr, char *buf)
+{
+	uint32_t chip_id;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct bcm_vk *vk = pci_get_drvdata(pdev);
+
+	chip_id = vkread32(vk, BAR_0, BAR_CHIP_ID);
+
+	return sprintf(buf, "0x%x\n", chip_id);
+}
+
+static ssize_t firmware_status_reg_show(struct device *dev,
+					struct device_attribute *devattr,
+					char *buf)
+{
+	uint32_t fw_status;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct bcm_vk *vk = pci_get_drvdata(pdev);
+
+	fw_status = vkread32(vk, BAR_0, BAR_FW_STATUS);
+
+	return sprintf(buf, "0x%x\n", fw_status);
+}
+
+static ssize_t fastboot_reg_show(struct device *dev,
+				 struct device_attribute *devattr,
+				 char *buf)
+{
+	uint32_t fb_reg;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct bcm_vk *vk = pci_get_drvdata(pdev);
+
+	fb_reg = vkread32(vk, BAR_0, BAR_FB_OPEN);
+
+	return sprintf(buf, "0x%x\n", fb_reg);
+}
+
+static ssize_t pwr_state_show(struct device *dev,
+			      struct device_attribute *devattr,
+			      char *buf)
+{
+	uint32_t card_pwr_and_thre;
+	uint32_t pwr_state;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct bcm_vk *vk = pci_get_drvdata(pdev);
+
+	card_pwr_and_thre = vkread32(vk, BAR_0, BAR_CARD_PWR_AND_THRE);
+	BCM_VK_EXTRACT_FIELD(pwr_state, card_pwr_and_thre,
+			     BCM_VK_PWR_AND_THRE_FIELD_MASK,
+			     BCM_VK_PWR_STATE_SHIFT);
+
+	return sprintf(buf, "%u\n", pwr_state);
+}
+
+static ssize_t firmware_version_show(struct device *dev,
+				     struct device_attribute *devattr,
+				     char *buf)
+{
+	int count = 0;
+	unsigned long offset = BAR_FIRMWARE_TAG;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct bcm_vk *vk = pci_get_drvdata(pdev);
+	uint32_t chip_id;
+	uint32_t loop_count = 0;
+	int ret;
+
+	/* Print driver version first, which is always available */
+	count  = sprintf(buf, "Driver  : %s %s, srcversion %s\n",
+			 DRV_MODULE_NAME, THIS_MODULE->version,
+			 THIS_MODULE->srcversion);
+
+	/* check for ucode and vk-boot1 versions */
+	count += bcm_vk_sysfs_get_tag(vk, BAR_1, VK_BAR1_UCODE_VER_TAG,
+				      &buf[count], "UCODE   : %s\n");
+	count += bcm_vk_sysfs_get_tag(vk, BAR_1, VK_BAR1_BOOT1_VER_TAG,
+				      &buf[count], "Boot1   : %s\n");
+
+	/* Check if FIRMWARE_STATUS_PRE_INIT_DONE for rest of items */
+	ret = bcm_vk_sysfs_chk_fw_status(vk, FIRMWARE_STATUS_PRE_INIT_DONE,
+					 &buf[count],
+					 "FW Version: n/a (fw not running)\n");
+	if (ret)
+		return (ret + count);
+
+	/* retrieve chip id for display */
+	chip_id = vkread32(vk, BAR_0, BAR_CHIP_ID);
+	count += sprintf(&buf[count], "Chip id : 0x%x\n", chip_id);
+
+	count += sprintf(&buf[count], "Card os  : ");
+
+	do {
+		buf[count] = vkread8(vk, BAR_1, offset);
+		if (buf[count] == '\0')
+			break;
+		offset++;
+		count++;
+		loop_count++;
+	} while (loop_count != BAR_FIRMWARE_TAG_SIZE);
+
+	if (loop_count == BAR_FIRMWARE_TAG_SIZE)
+		buf[--count] = '\0';
+
+	buf[count++] = '\n'; /* append a CR */
+	dev_dbg(dev, "FW version: %s", buf);
+	return count;
+}
+
+static ssize_t firmware_status_show(struct device *dev,
+				    struct device_attribute *devattr, char *buf)
+{
+	int ret, i;
+	uint32_t reg_status;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct bcm_vk *vk = pci_get_drvdata(pdev);
+	char *p_buf = buf;
+	/*
+	 * for firmware status register, they are bit definitions,
+	 * so mask == exp_val
+	 */
+	static struct bcm_vk_sysfs_reg_entry const fw_status_reg_tab[] = {
+		{FW_STATUS_RELOCATION_ENTRY, FW_STATUS_RELOCATION_ENTRY,
+		 "relo_entry"},
+		{FW_STATUS_RELOCATION_EXIT, FW_STATUS_RELOCATION_EXIT,
+		 "relo_exit"},
+		{FW_STATUS_INIT_START, FW_STATUS_INIT_START,
+		 "init_st"},
+		{FW_STATUS_ARCH_INIT_DONE, FW_STATUS_ARCH_INIT_DONE,
+		 "arch_inited"},
+		{FW_STATUS_PRE_KNL1_INIT_DONE, FW_STATUS_PRE_KNL1_INIT_DONE,
+		 "pre_kern1_inited"},
+		{FW_STATUS_PRE_KNL2_INIT_DONE, FW_STATUS_PRE_KNL2_INIT_DONE,
+		  "pre_kern2_inited"},
+		{FW_STATUS_POST_KNL_INIT_DONE, FW_STATUS_POST_KNL_INIT_DONE,
+		  "kern_inited"},
+		{FW_STATUS_INIT_DONE, FW_STATUS_INIT_DONE,
+		 "card_os_inited"},
+		{FW_STATUS_APP_INIT_START, FW_STATUS_APP_INIT_START,
+		 "app_init_st"},
+		{FW_STATUS_APP_INIT_DONE, FW_STATUS_APP_INIT_DONE,
+		 "app_inited"},
+	};
+	/* for FB register */
+	static struct bcm_vk_sysfs_reg_entry const fb_open_reg_tab[] = {
+		{FW_LOADER_ACK_SEND_MORE_DATA, FW_LOADER_ACK_SEND_MORE_DATA,
+		 "bt1_needs_data"},
+		{FW_LOADER_ACK_IN_PROGRESS, FW_LOADER_ACK_IN_PROGRESS,
+		 "bt1_inprog"},
+		{FW_LOADER_ACK_RCVD_ALL_DATA, FW_LOADER_ACK_RCVD_ALL_DATA,
+		 "bt2_dload_done"},
+		{SRAM_OPEN, SRAM_OPEN,
+		 "wait_boot1"},
+		{FB_BOOT_STATE_MASK, FB_BOOT1_RUNNING,
+		 "wait_boot2"},
+		{FB_BOOT_STATE_MASK, FB_BOOT2_RUNNING,
+		 "boot2_running"},
+	};
+	/*
+	 * shut down is lumped with fw-status register, but we use a different
+	 * table to isolate it out.
+	 */
+	static struct bcm_vk_sysfs_reg_entry const fw_shutdown_reg_tab[] = {
+		{FW_STATUS_APP_DEINIT_START, FW_STATUS_APP_DEINIT_START,
+		 "app_deinit_st"},
+		{FW_STATUS_APP_DEINIT_DONE, FW_STATUS_APP_DEINIT_DONE,
+		 "app_deinited"},
+		{FW_STATUS_DRV_DEINIT_START, FW_STATUS_DRV_DEINIT_START,
+		 "drv_deinit_st"},
+		{FW_STATUS_DRV_DEINIT_DONE, FW_STATUS_DRV_DEINIT_DONE,
+		 "drv_deinited"},
+		{FW_STATUS_RESET_DONE, FW_STATUS_RESET_DONE,
+		 "reset_done"},
+		/* reboot reason */
+		{FW_STATUS_RESET_REASON_MASK, 0,
+		 "R-sys_pwrup"},
+		{FW_STATUS_RESET_REASON_MASK, FW_STATUS_RESET_MBOX_DB,
+		 "R-reset_doorbell"},
+		{FW_STATUS_RESET_REASON_MASK, FW_STATUS_RESET_M7_WDOG,
+		 "R-wdog"},
+		{FW_STATUS_RESET_REASON_MASK, FW_STATUS_RESET_TEMP,
+		 "R-overheat"},
+		{FW_STATUS_RESET_REASON_MASK, FW_STATUS_RESET_PCI_FLR,
+		 "R-pci_flr"},
+		{FW_STATUS_RESET_REASON_MASK, FW_STATUS_RESET_PCI_HOT,
+		 "R-pci_hot"},
+		{FW_STATUS_RESET_REASON_MASK, FW_STATUS_RESET_PCI_WARM,
+		 "R-pci_warm" },
+		{FW_STATUS_RESET_REASON_MASK, FW_STATUS_RESET_PCI_COLD,
+		 "R-pci_cold" },
+		{FW_STATUS_RESET_REASON_MASK, FW_STATUS_RESET_UNKNOWN,
+		 "R-unknown" },
+	};
+	/* list of registers */
+	static struct bcm_vk_sysfs_reg_list const fw_status_reg_list[] = {
+		{BAR_FW_STATUS, fw_status_reg_tab,
+		 ARRAY_SIZE(fw_status_reg_tab),
+		 "FW status"},
+		{BAR_FB_OPEN, fb_open_reg_tab,
+		 ARRAY_SIZE(fb_open_reg_tab),
+		 "FastBoot status"},
+		{BAR_FW_STATUS, fw_shutdown_reg_tab,
+		 ARRAY_SIZE(fw_shutdown_reg_tab),
+		 "Last Reset status"},
+	};
+
+	reg_status = vkread32(vk, BAR_0, BAR_FW_STATUS);
+	if (BCM_VK_INTF_IS_DOWN(reg_status))
+		return sprintf(buf, "PCIe Intf Down!\n");
+
+	for (i = 0; i < ARRAY_SIZE(fw_status_reg_list); i++) {
+		reg_status = vkread32(vk, BAR_0, fw_status_reg_list[i].offset);
+
+		dev_dbg(dev, "%s: 0x%08x\n",
+			fw_status_reg_list[i].hdr, reg_status);
+
+		ret = sprintf(p_buf, "%s: 0x%08x\n",
+			      fw_status_reg_list[i].hdr, reg_status);
+		if (ret < 0)
+			goto fw_status_show_fail;
+		p_buf += ret;
+
+		ret = bcm_vk_sysfs_dump_reg(reg_status,
+					    fw_status_reg_list[i].tab,
+					    fw_status_reg_list[i].size,
+					    p_buf);
+		if (ret < 0)
+			goto fw_status_show_fail;
+		p_buf += ret;
+	}
+
+	/* return total length written */
+	return (p_buf - buf);
+
+fw_status_show_fail:
+	return ret;
+}
+
+static ssize_t bus_show(struct device *dev,
+			struct device_attribute *devattr, char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+#define _BUS_NUM_FMT "[pci_bus] %04x:%02x:%02x.%1d\n"
+	dev_dbg(dev, _BUS_NUM_FMT,
+		pci_domain_nr(pdev->bus), pdev->bus->number,
+		PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
+
+	return sprintf(buf, _BUS_NUM_FMT,
+		       pci_domain_nr(pdev->bus), pdev->bus->number,
+		       PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
+}
+
+static ssize_t card_state_show(struct device *dev,
+			       struct device_attribute *devattr, char *buf)
+{
+	int ret;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct bcm_vk *vk = pci_get_drvdata(pdev);
+	uint32_t reg;
+	uint32_t low_temp_thre, high_temp_thre, pwr_state;
+	uint32_t int_mem_err, ext_mem_err;
+	char *p_buf = buf;
+	static struct bcm_vk_sysfs_reg_entry const err_log_reg_tab[] = {
+		{ERR_LOG_ALERT_ECC, ERR_LOG_ALERT_ECC,
+		 "ecc"},
+		{ERR_LOG_ALERT_SSIM_BUSY, ERR_LOG_ALERT_SSIM_BUSY,
+		 "ssim_busy"},
+		{ERR_LOG_ALERT_AFBC_BUSY, ERR_LOG_ALERT_AFBC_BUSY,
+		 "afbc_busy"},
+		{ERR_LOG_HIGH_TEMP_ERR, ERR_LOG_HIGH_TEMP_ERR,
+		 "high_temp"},
+		{ERR_LOG_MEM_ALLOC_FAIL, ERR_LOG_MEM_ALLOC_FAIL,
+		 "malloc_fail warn"},
+		{ERR_LOG_LOW_TEMP_WARN, ERR_LOG_LOW_TEMP_WARN,
+		 "low_temp warn"}
+	};
+	static const char * const pwr_state_tab[] = {
+		"Full", "Reduced", "Lowest"};
+	char *pwr_state_str;
+
+	/* if OS is not running, no one will update the value */
+	ret = bcm_vk_sysfs_chk_fw_status(vk, FW_STATUS_READY, buf,
+					 "card_state: n/a (fw not running)\n");
+	if (ret)
+		return ret;
+
+	/* First, get power state and the threshold */
+	reg = vkread32(vk, BAR_0, BAR_CARD_PWR_AND_THRE);
+	BCM_VK_EXTRACT_FIELD(low_temp_thre, reg,
+			     BCM_VK_PWR_AND_THRE_FIELD_MASK,
+			     BCM_VK_LOW_TEMP_THRE_SHIFT);
+	BCM_VK_EXTRACT_FIELD(high_temp_thre, reg,
+			     BCM_VK_PWR_AND_THRE_FIELD_MASK,
+			     BCM_VK_HIGH_TEMP_THRE_SHIFT);
+	BCM_VK_EXTRACT_FIELD(pwr_state, reg,
+			     BCM_VK_PWR_AND_THRE_FIELD_MASK,
+			     BCM_VK_PWR_STATE_SHIFT);
+
+#define _PWR_AND_THRE_FMT "Pwr&Thre: 0x%08x\n"       \
+		"  [Pwr_state]     : %d (%s)\n"      \
+		"  [Low_thre]      : %d Celsius\n"   \
+		"  [High_thre]     : %d Celsius\n"
+
+	pwr_state_str = (pwr_state < ARRAY_SIZE(pwr_state_tab)) ?
+			 (char *) pwr_state_tab[pwr_state] : "n/a";
+	ret = sprintf(buf, _PWR_AND_THRE_FMT, reg, pwr_state, pwr_state_str,
+		      low_temp_thre, high_temp_thre);
+	if (ret < 0)
+		goto card_state_show_fail;
+	p_buf += ret;
+	dev_dbg(dev, _PWR_AND_THRE_FMT, reg, pwr_state, pwr_state_str,
+		low_temp_thre, high_temp_thre);
+
+	/* next, see if there is any alert, also display them */
+	reg = vkread32(vk, BAR_0, BAR_CARD_ERR_LOG);
+	ret = sprintf(p_buf, "Alerts: 0x%08x\n", reg);
+	if (ret < 0)
+		goto card_state_show_fail;
+	p_buf += ret;
+
+	dev_dbg(dev, "Alerts: 0x%08x\n", reg);
+	ret = bcm_vk_sysfs_dump_reg(reg,
+				    err_log_reg_tab,
+				    ARRAY_SIZE(err_log_reg_tab),
+				    p_buf);
+	if (ret < 0)
+		goto card_state_show_fail;
+	p_buf += ret;
+
+	/* display memory error */
+	reg = vkread32(vk, BAR_0, BAR_CARD_ERR_MEM);
+	BCM_VK_EXTRACT_FIELD(int_mem_err, reg,
+			     BCM_VK_MEM_ERR_FIELD_MASK,
+			     BCM_VK_INT_MEM_ERR_SHIFT);
+	BCM_VK_EXTRACT_FIELD(ext_mem_err, reg,
+			     BCM_VK_MEM_ERR_FIELD_MASK,
+			     BCM_VK_EXT_MEM_ERR_SHIFT);
+
+#define _MEM_ERR_FMT "MemErr: 0x%08x\n"    \
+		"  [internal]      : %d\n" \
+		"  [external]      : %d\n"
+	ret = sprintf(p_buf, _MEM_ERR_FMT, reg, int_mem_err, ext_mem_err);
+	if (ret < 0)
+		goto card_state_show_fail;
+	p_buf += ret;
+	dev_dbg(dev, _MEM_ERR_FMT, reg, int_mem_err, ext_mem_err);
+
+	return (p_buf - buf);
+
+card_state_show_fail:
+	return ret;
+}
+
+static ssize_t sotp_common_show(struct device *dev,
+				struct device_attribute *devattr,
+				char *buf, uint32_t tag_offset)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct bcm_vk *vk = pci_get_drvdata(pdev);
+
+	return bcm_vk_sysfs_get_tag(vk, BAR_1, tag_offset, buf, "%s\n");
+}
+
+static ssize_t sotp_dauth_1_show(struct device *dev,
+				 struct device_attribute *devattr, char *buf)
+{
+	return sotp_common_show(dev, devattr, buf,
+				VK_BAR1_DAUTH_STORE_ADDR(0));
+}
+
+static ssize_t sotp_dauth_1_valid_show(struct device *dev,
+				       struct device_attribute *devattr,
+				       char *buf)
+{
+	return sotp_common_show(dev, devattr, buf,
+				VK_BAR1_DAUTH_VALID_ADDR(0));
+}
+
+static ssize_t sotp_dauth_2_show(struct device *dev,
+				 struct device_attribute *devattr, char *buf)
+{
+	return sotp_common_show(dev, devattr, buf,
+				VK_BAR1_DAUTH_STORE_ADDR(1));
+}
+
+static ssize_t sotp_dauth_2_valid_show(struct device *dev,
+				       struct device_attribute *devattr,
+				       char *buf)
+{
+	return sotp_common_show(dev, devattr, buf,
+				VK_BAR1_DAUTH_VALID_ADDR(1));
+}
+
+static ssize_t sotp_dauth_3_show(struct device *dev,
+				 struct device_attribute *devattr, char *buf)
+{
+	return sotp_common_show(dev, devattr, buf,
+				VK_BAR1_DAUTH_STORE_ADDR(2));
+}
+
+static ssize_t sotp_dauth_3_valid_show(struct device *dev,
+				       struct device_attribute *devattr,
+				       char *buf)
+{
+	return sotp_common_show(dev, devattr, buf,
+				VK_BAR1_DAUTH_VALID_ADDR(2));
+}
+
+static ssize_t sotp_dauth_4_show(struct device *dev,
+				 struct device_attribute *devattr, char *buf)
+{
+	return sotp_common_show(dev, devattr, buf,
+				VK_BAR1_DAUTH_STORE_ADDR(3));
+}
+
+static ssize_t sotp_dauth_4_valid_show(struct device *dev,
+				       struct device_attribute *devattr,
+				       char *buf)
+{
+	return sotp_common_show(dev, devattr, buf,
+				VK_BAR1_DAUTH_VALID_ADDR(3));
+}
+
+static ssize_t sotp_boot1_rev_id_show(struct device *dev,
+				      struct device_attribute *devattr,
+				      char *buf)
+{
+	return sotp_common_show(dev, devattr, buf,
+				VK_BAR1_SOTP_REVID_ADDR(0));
+}
+
+static ssize_t sotp_boot2_rev_id_show(struct device *dev,
+				      struct device_attribute *devattr,
+				      char *buf)
+{
+	return sotp_common_show(dev, devattr, buf,
+				VK_BAR1_SOTP_REVID_ADDR(1));
+}
+
+static DEVICE_ATTR_RO(firmware_status);
+static DEVICE_ATTR_RO(firmware_version);
+static DEVICE_ATTR_RO(bus);
+static DEVICE_ATTR_RO(card_state);
+static DEVICE_ATTR_RO(sotp_dauth_1);
+static DEVICE_ATTR_RO(sotp_dauth_1_valid);
+static DEVICE_ATTR_RO(sotp_dauth_2);
+static DEVICE_ATTR_RO(sotp_dauth_2_valid);
+static DEVICE_ATTR_RO(sotp_dauth_3);
+static DEVICE_ATTR_RO(sotp_dauth_3_valid);
+static DEVICE_ATTR_RO(sotp_dauth_4);
+static DEVICE_ATTR_RO(sotp_dauth_4_valid);
+static DEVICE_ATTR_RO(sotp_boot1_rev_id);
+static DEVICE_ATTR_RO(sotp_boot2_rev_id);
+static DEVICE_ATTR_RO(temperature_sensor_1);
+static DEVICE_ATTR_RO(voltage_18_mv);
+static DEVICE_ATTR_RO(voltage_33_mv);
+static DEVICE_ATTR_RO(chip_id);
+static DEVICE_ATTR_RO(firmware_status_reg);
+static DEVICE_ATTR_RO(fastboot_reg);
+static DEVICE_ATTR_RO(pwr_state);
+
+static struct attribute *bcm_vk_card_stat_attributes[] = {
+
+	&dev_attr_chip_id.attr,
+	&dev_attr_firmware_status.attr,
+	&dev_attr_firmware_version.attr,
+	&dev_attr_bus.attr,
+	&dev_attr_card_state.attr,
+	&dev_attr_sotp_dauth_1.attr,
+	&dev_attr_sotp_dauth_1_valid.attr,
+	&dev_attr_sotp_dauth_2.attr,
+	&dev_attr_sotp_dauth_2_valid.attr,
+	&dev_attr_sotp_dauth_3.attr,
+	&dev_attr_sotp_dauth_3_valid.attr,
+	&dev_attr_sotp_dauth_4.attr,
+	&dev_attr_sotp_dauth_4_valid.attr,
+	&dev_attr_sotp_boot1_rev_id.attr,
+	&dev_attr_sotp_boot2_rev_id.attr,
+	NULL,
+};
+
+static struct attribute *bcm_vk_card_mon_attributes[] = {
+
+	&dev_attr_temperature_sensor_1.attr,
+	&dev_attr_voltage_18_mv.attr,
+	&dev_attr_voltage_33_mv.attr,
+	&dev_attr_firmware_status_reg.attr,
+	&dev_attr_fastboot_reg.attr,
+	&dev_attr_pwr_state.attr,
+	NULL,
+};
+
+static const struct attribute_group bcm_vk_card_stat_attribute_group = {
+	.name = "vk-card-status",
+	.attrs = bcm_vk_card_stat_attributes,
+};
+
+static const struct attribute_group bcm_vk_card_mon_attribute_group = {
+	.name = "vk-card-mon",
+	.attrs = bcm_vk_card_mon_attributes,
+};
+
+static const struct file_operations bcm_vk_fops = {
+	.owner = THIS_MODULE,
+	.open = bcm_vk_open,
+	.read = bcm_vk_read,
+	.write = bcm_vk_write,
+	.release = bcm_vk_release,
+	.mmap = bcm_vk_mmap,
+	.unlocked_ioctl = bcm_vk_ioctl,
+};
+
+static int bcm_vk_on_panic(struct notifier_block *nb,
+			   unsigned long e, void *p)
+{
+	struct bcm_vk *vk = container_of(nb, struct bcm_vk, panic_nb);
+
+	bcm_h2vk_doorbell(vk, VK_BAR0_RESET_DB_NUM, VK_BAR0_RESET_DB_HARD);
+
+	return 0;
+}
+
+static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	int err;
+	int i;
+	int id;
+	int irq;
+	char name[20];
+	struct bcm_vk *vk;
+	struct device *dev = &pdev->dev;
+	struct miscdevice *misc_device;
+
+	/* allocate vk structure which is tied to kref for freeing */
+	vk = kzalloc(sizeof(*vk), GFP_KERNEL);
+	if (!vk)
+		return -ENOMEM;
+
+	kref_init(&vk->kref);
+	vk->pdev = pdev;
+	mutex_init(&vk->mutex);
+
+	err = pci_enable_device(pdev);
+	if (err) {
+		dev_err(dev, "Cannot enable PCI device\n");
+		return err;
+	}
+
+	err = pci_request_regions(pdev, DRV_MODULE_NAME);
+	if (err) {
+		dev_err(dev, "Cannot obtain PCI resources\n");
+		goto err_disable_pdev;
+	}
+
+	/* make sure DMA is good */
+	err = dma_set_mask_and_coherent(&pdev->dev,
+					DMA_BIT_MASK(BCM_VK_DMA_BITS));
+	if (err) {
+		dev_err(dev, "failed to set DMA mask\n");
+		goto err_disable_pdev;
+	}
+
+	/* The tdma is a scratch area for some DMA testings. */
+	if (nr_scratch_pages) {
+		vk->tdma_vaddr = dma_alloc_coherent(dev,
+					 nr_scratch_pages * PAGE_SIZE,
+					 &vk->tdma_addr, GFP_KERNEL);
+		if (!vk->tdma_vaddr) {
+			err = -ENOMEM;
+			goto err_disable_pdev;
+		}
+	}
+
+	pci_set_master(pdev);
+	pci_set_drvdata(pdev, vk);
+
+	irq = pci_alloc_irq_vectors(pdev,
+				    1,
+				    VK_MSIX_IRQ_MAX,
+				    PCI_IRQ_MSI | PCI_IRQ_MSIX);
+
+	if (irq < VK_MSIX_IRQ_MAX) {
+		dev_err(dev, "failed to get %d MSIX interrupts, ret(%d)\n",
+			VK_MSIX_IRQ_MAX, irq);
+		err = (irq >= 0) ? -EINVAL : irq;
+		goto err_disable_pdev;
+	}
+
+	dev_info(dev, "Number of IRQs %d allocated.\n", irq);
+
+	for (i = 0; i < MAX_BAR; i++) {
+		/* multiple by 2 for 64 bit BAR mapping */
+		vk->bar[i] = pci_ioremap_bar(pdev, i * 2);
+		if (!vk->bar[i]) {
+			dev_err(dev, "failed to remap BAR%d\n", i);
+			goto err_iounmap;
+		}
+	}
+
+	for (vk->num_irqs = 0; vk->num_irqs < irq; vk->num_irqs++) {
+		err = devm_request_irq(dev, pci_irq_vector(pdev, vk->num_irqs),
+				       bcm_vk_irqhandler,
+				       IRQF_SHARED, DRV_MODULE_NAME, vk);
+		if (err) {
+			dev_err(dev, "failed to request IRQ %d for MSIX %d\n",
+				pdev->irq + vk->num_irqs, vk->num_irqs + 1);
+			goto err_irq;
+		}
+	}
+
+	id = ida_simple_get(&bcm_vk_ida, 0, 0, GFP_KERNEL);
+	if (id < 0) {
+		err = id;
+		dev_err(dev, "unable to get id\n");
+		goto err_irq;
+	}
+
+	vk->misc_devid = id;
+	snprintf(name, sizeof(name), DRV_MODULE_NAME ".%d", id);
+	misc_device = &vk->miscdev;
+	misc_device->minor = MISC_DYNAMIC_MINOR;
+	misc_device->name = kstrdup(name, GFP_KERNEL);
+	if (!misc_device->name) {
+		err = -ENOMEM;
+		goto err_ida_remove;
+	}
+	misc_device->fops = &bcm_vk_fops,
+
+	err = misc_register(misc_device);
+	if (err) {
+		dev_err(dev, "failed to register device\n");
+		goto err_kfree_name;
+	}
+
+	err = bcm_vk_msg_init(vk);
+	if (err) {
+		dev_err(dev, "failed to init msg queue info\n");
+		goto err_kfree_name;
+	}
+
+	dev_info(dev, "create sysfs group for bcm-vk.%d\n", id);
+	err = sysfs_create_group(&pdev->dev.kobj,
+				 &bcm_vk_card_stat_attribute_group);
+	if (err < 0) {
+		dev_err(dev,
+			"failed to create card status attr for bcm.vk.%d\n",
+			id);
+		goto err_kfree_name;
+	}
+	err = sysfs_create_group(&pdev->dev.kobj,
+				 &bcm_vk_card_mon_attribute_group);
+	if (err < 0) {
+		dev_err(dev,
+			"failed to create card mon attr for bcm.vk.%d\n",
+			id);
+		goto err_free_card_stat_group;
+	}
+
+	/* create symbolic link from misc device to bus directory */
+	err = sysfs_create_link(&misc_device->this_device->kobj,
+				&pdev->dev.kobj, BCM_VK_BUS_SYMLINK_NAME);
+	if (err < 0) {
+		dev_err(dev, "failed to create symlink for bcm.vk.%d\n", id);
+		goto err_free_card_mon_group;
+	}
+	/* create symbolic link from bus to misc device also */
+	err = sysfs_create_link(&pdev->dev.kobj,
+				&misc_device->this_device->kobj,
+				misc_device->name);
+	if (err < 0) {
+		dev_err(dev,
+			"failed to create reverse symlink for bcm.vk.%d\n",
+			id);
+		goto err_free_sysfs_entry;
+	}
+
+	/* register for panic notifier */
+	vk->panic_nb.notifier_call = bcm_vk_on_panic;
+	atomic_notifier_chain_register(&panic_notifier_list,
+				       &vk->panic_nb);
+
+	/* pass down scratch mem info */
+	if (vk->tdma_addr) {
+		vkwrite32(vk, vk->tdma_addr >> 32, BAR_1,
+			  VK_BAR1_SCRATCH_OFF_LO);
+		vkwrite32(vk, (uint32_t)vk->tdma_addr, BAR_1,
+			  VK_BAR1_SCRATCH_OFF_HI);
+		vkwrite32(vk, nr_scratch_pages * PAGE_SIZE, BAR_1,
+			  VK_BAR1_SCRATCH_SZ_ADDR);
+	}
+
+	/*
+	 * lets trigger an auto download.  We don't want to do it serially here
+	 * because at probing time, it is not supposed to block for a long time.
+	 */
+	if (auto_load)
+		if (bcm_vk_trigger_autoload(vk))
+			goto err_free_sysfs_entry;
+
+	dev_info(dev, "BCM-VK:%u created, 0x%p\n", id, vk);
+
+	return 0;
+
+err_free_sysfs_entry:
+	sysfs_remove_link(&misc_device->this_device->kobj,
+			  BCM_VK_BUS_SYMLINK_NAME);
+
+err_free_card_mon_group:
+	sysfs_remove_group(&pdev->dev.kobj, &bcm_vk_card_mon_attribute_group);
+err_free_card_stat_group:
+	sysfs_remove_group(&pdev->dev.kobj, &bcm_vk_card_stat_attribute_group);
+
+err_kfree_name:
+	kfree(misc_device->name);
+	misc_device->name = NULL;
+
+err_ida_remove:
+	ida_simple_remove(&bcm_vk_ida, id);
+
+err_irq:
+	for (i = 0; i < vk->num_irqs; i++)
+		devm_free_irq(dev, pci_irq_vector(pdev, i), vk);
+
+	pci_disable_msix(pdev);
+	pci_disable_msi(pdev);
+
+err_iounmap:
+	for (i = 0; i < MAX_BAR; i++) {
+		if (vk->bar[i])
+			pci_iounmap(pdev, vk->bar[i]);
+	}
+	pci_release_regions(pdev);
+
+err_disable_pdev:
+	pci_disable_device(pdev);
+
+	return err;
+}
+
+void bcm_vk_release_data(struct kref *kref)
+{
+	struct bcm_vk *vk = container_of(kref, struct bcm_vk, kref);
+
+	/* use raw print, as dev is gone */
+	pr_info("BCM-VK:%d release data 0x%p\n", vk->misc_devid, vk);
+	kfree(vk);
+}
+
+static void bcm_vk_remove(struct pci_dev *pdev)
+{
+	int i;
+	struct bcm_vk *vk = pci_get_drvdata(pdev);
+	struct miscdevice *misc_device = &vk->miscdev;
+
+	/* unregister panic notifier */
+	atomic_notifier_chain_unregister(&panic_notifier_list,
+				       &vk->panic_nb);
+
+	/* remove the sysfs entry and symlinks associated */
+	sysfs_remove_link(&pdev->dev.kobj, misc_device->name);
+	sysfs_remove_link(&misc_device->this_device->kobj,
+			  BCM_VK_BUS_SYMLINK_NAME);
+	sysfs_remove_group(&pdev->dev.kobj, &bcm_vk_card_mon_attribute_group);
+	sysfs_remove_group(&pdev->dev.kobj, &bcm_vk_card_stat_attribute_group);
+
+	cancel_work_sync(&vk->wq_work);
+	bcm_vk_msg_remove(vk);
+
+	if (vk->tdma_vaddr)
+		dma_free_coherent(&pdev->dev, PAGE_SIZE, vk->tdma_vaddr,
+				  vk->tdma_addr);
+
+	/* remove if name is set which means misc dev registered */
+	if (misc_device->name) {
+		misc_deregister(&vk->miscdev);
+		kfree(misc_device->name);
+		ida_simple_remove(&bcm_vk_ida, vk->misc_devid);
+	}
+	for (i = 0; i < vk->num_irqs; i++)
+		devm_free_irq(&pdev->dev, pci_irq_vector(pdev, i), vk);
+
+	pci_disable_msix(pdev);
+	pci_disable_msi(pdev);
+
+	for (i = 0; i < MAX_BAR; i++) {
+		if (vk->bar[i])
+			pci_iounmap(pdev, vk->bar[i]);
+	}
+
+	dev_info(&pdev->dev, "BCM-VK:%d released\n", vk->misc_devid);
+
+	pci_release_regions(pdev);
+	pci_disable_device(pdev);
+
+	kref_put(&vk->kref, bcm_vk_release_data);
+}
+
+static const struct pci_device_id bcm_vk_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_VALKYRIE), },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, bcm_vk_ids);
+
+static struct pci_driver pci_driver = {
+	.name     = DRV_MODULE_NAME,
+	.id_table = bcm_vk_ids,
+	.probe    = bcm_vk_probe,
+	.remove   = bcm_vk_remove,
+};
+module_pci_driver(pci_driver);
+
+MODULE_DESCRIPTION("Broadcom Valkyrie Host Driver");
+MODULE_AUTHOR("Scott Branden <scott.branden@broadcom.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_VERSION("1.0");
diff --git a/drivers/misc/bcm-vk/bcm_vk_msg.c b/drivers/misc/bcm-vk/bcm_vk_msg.c
new file mode 100644
index 000000000000..ecdf45c316cc
--- /dev/null
+++ b/drivers/misc/bcm-vk/bcm_vk_msg.c
@@ -0,0 +1,963 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2018-2019 Broadcom.
+ */
+
+#include <linux/delay.h>
+#include <linux/fs.h>
+#include <linux/hash.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/sizes.h>
+#include <linux/spinlock.h>
+
+#include "bcm_vk.h"
+#include "bcm_vk_msg.h"
+#include "bcm_vk_sg.h"
+
+/*
+ * allocate a ctx per file struct
+ */
+static struct bcm_vk_ctx *bcm_vk_get_ctx(struct bcm_vk *vk,
+					 struct task_struct *ppid)
+{
+	uint32_t i;
+	struct bcm_vk_ctx *ctx = NULL;
+	const pid_t pid = task_pid_nr(ppid);
+	uint32_t hash_idx = hash_32(pid, VK_PID_HT_SHIFT_BIT);
+
+	spin_lock(&vk->ctx_lock);
+
+	/* check if it is in reset, if so, don't allow */
+	if (vk->reset_ppid) {
+		dev_err(&vk->pdev->dev,
+			"No context allowed during reset by pid %d\n",
+			task_pid_nr(vk->reset_ppid));
+
+		goto in_reset_exit;
+	}
+
+	for (i = 0; i < VK_CMPT_CTX_MAX; i++) {
+		if (!vk->ctx[i].in_use) {
+			vk->ctx[i].in_use = true;
+			ctx = &vk->ctx[i];
+			break;
+		}
+	}
+
+	if (!ctx) {
+		dev_err(&vk->pdev->dev, "All context in use\n");
+
+		goto all_in_use_exit;
+	}
+
+	/* set the pid and insert it to hash table */
+	ctx->ppid = ppid;
+	ctx->hash_idx = hash_idx;
+	list_add_tail(&ctx->node, &vk->pid_ht[hash_idx].head);
+
+	/* increase kref */
+	kref_get(&vk->kref);
+
+all_in_use_exit:
+in_reset_exit:
+	spin_unlock(&vk->ctx_lock);
+
+	return ctx;
+}
+
+static uint16_t bcm_vk_get_msg_id(struct bcm_vk *vk)
+{
+	uint16_t rc = VK_MSG_ID_OVERFLOW;
+	uint16_t test_bit_count = 0;
+
+	spin_lock(&vk->msg_id_lock);
+	while (test_bit_count < VK_MSG_ID_BITMAP_SIZE) {
+		vk->msg_id++;
+		vk->msg_id = vk->msg_id & VK_MSG_ID_BITMAP_MASK;
+		if (test_bit(vk->msg_id, vk->bmap)) {
+			test_bit_count++;
+			continue;
+		}
+		rc = vk->msg_id;
+		bitmap_set(vk->bmap, vk->msg_id, 1);
+		break;
+	}
+	spin_unlock(&vk->msg_id_lock);
+
+	return rc;
+}
+
+static int bcm_vk_free_ctx(struct bcm_vk *vk, struct bcm_vk_ctx *ctx)
+{
+	uint32_t idx;
+	uint32_t hash_idx;
+	pid_t pid;
+	struct bcm_vk_ctx *entry;
+	int count = 0;
+
+	if (ctx == NULL) {
+		dev_err(&vk->pdev->dev, "NULL context detected\n");
+		return -EINVAL;
+	}
+	idx = ctx->idx;
+	pid = task_pid_nr(ctx->ppid);
+
+	spin_lock(&vk->ctx_lock);
+
+	if (!vk->ctx[idx].in_use) {
+		dev_err(&vk->pdev->dev, "context[%d] not in use!\n", idx);
+	} else {
+		vk->ctx[idx].in_use = false;
+		vk->ctx[idx].miscdev = NULL;
+
+		/* Remove it from hash list and see if it is the last one. */
+		list_del(&ctx->node);
+		hash_idx = ctx->hash_idx;
+		list_for_each_entry(entry, &vk->pid_ht[hash_idx].head, node) {
+			if (task_pid_nr(entry->ppid) == pid)
+				count++;
+		}
+	}
+
+	spin_unlock(&vk->ctx_lock);
+
+	return count;
+}
+
+static void bcm_vk_free_wkent(struct device *dev, struct bcm_vk_wkent *entry)
+{
+	bcm_vk_sg_free(dev, entry->dma, VK_DMA_MAX_ADDRS);
+
+	kfree(entry->vk2h_msg);
+	kfree(entry);
+}
+
+static void bcm_vk_drain_all_pend(struct device *dev,
+				  struct bcm_vk_msg_chan *chan,
+				  struct bcm_vk_ctx *ctx)
+{
+	uint32_t num;
+	struct bcm_vk_wkent *entry, *tmp;
+
+	spin_lock(&chan->pendq_lock);
+	for (num = 0; num < chan->q_nr; num++) {
+		list_for_each_entry_safe(entry, tmp, &chan->pendq[num], node) {
+			if (ctx == NULL) {
+				list_del(&entry->node);
+				bcm_vk_free_wkent(dev, entry);
+			} else if (entry->ctx->idx == ctx->idx) {
+				struct vk_msg_blk *msg;
+
+				/* if it is specific ctx, log for any stuck */
+				msg = entry->h2vk_msg;
+				dev_err(dev,
+					"Drained: fid %u size %u msg 0x%x ctx 0x%x args:[0x%x 0x%x]",
+					msg->function_id, msg->size,
+					msg->msg_id, msg->context_id,
+					msg->args[0], msg->args[1]);
+				list_del(&entry->node);
+				bcm_vk_free_wkent(dev, entry);
+			}
+		}
+	}
+	spin_unlock(&chan->pendq_lock);
+}
+
+bool bcm_vk_msgq_marker_valid(struct bcm_vk *vk)
+{
+	uint32_t rdy_marker = 0;
+	uint32_t fw_status;
+
+	fw_status = vkread32(vk, BAR_0, BAR_FW_STATUS);
+
+	if ((fw_status & FW_STATUS_READY) == FW_STATUS_READY)
+		rdy_marker = vkread32(vk, BAR_1, VK_BAR1_MSGQ_DEF_RDY);
+
+	return (rdy_marker == VK_BAR1_MSGQ_RDY_MARKER);
+}
+
+/*
+ * Function to sync up the messages queue info that is provided by BAR1
+ */
+int bcm_vk_sync_msgq(struct bcm_vk *vk)
+{
+	struct bcm_vk_msgq *msgq = NULL;
+	struct device *dev = &vk->pdev->dev;
+	uint32_t msgq_off;
+	uint32_t num_q;
+	struct bcm_vk_msg_chan *chan_list[] = {&vk->h2vk_msg_chan,
+					       &vk->vk2h_msg_chan};
+	struct bcm_vk_msg_chan *chan = NULL;
+	int i, j;
+
+	/*
+	 * if this function is called when it is already inited,
+	 * something is wrong
+	 */
+	if (vk->msgq_inited) {
+		dev_err(dev, "Msgq info already in sync\n");
+		return -EPERM;
+	}
+
+	/*
+	 * If the driver is loaded at startup where vk OS is not up yet,
+	 * the msgq-info may not be available until a later time.  In
+	 * this case, we skip and the sync function is supposed to be
+	 * called again.
+	 */
+	if (!bcm_vk_msgq_marker_valid(vk)) {
+		dev_info(dev, "BAR1 msgq marker not initialized.\n");
+		return 0;
+	}
+
+	msgq_off = vkread32(vk, BAR_1, VK_BAR1_MSGQ_CTRL_OFF);
+
+	/* each side is always half the total  */
+	num_q = vk->h2vk_msg_chan.q_nr = vk->vk2h_msg_chan.q_nr =
+		vkread32(vk, BAR_1, VK_BAR1_MSGQ_NR) / 2;
+
+	/* first msgq location */
+	msgq = (struct bcm_vk_msgq *)(vk->bar[BAR_1] + msgq_off);
+
+	for (i = 0; i < ARRAY_SIZE(chan_list); i++) {
+		chan = chan_list[i];
+		for (j = 0; j < num_q; j++) {
+			chan->msgq[j] = msgq;
+
+			dev_info(dev,
+				 "MsgQ[%d] type %d num %d, @ 0x%x, rd_idx %d wr_idx %d, size %d, nxt 0x%x\n",
+				 j,
+				 chan->msgq[j]->type,
+				 chan->msgq[j]->num,
+				 chan->msgq[j]->start,
+				 chan->msgq[j]->rd_idx,
+				 chan->msgq[j]->wr_idx,
+				 chan->msgq[j]->size,
+				 chan->msgq[j]->nxt);
+
+			msgq = (struct bcm_vk_msgq *)
+				((char *)msgq + sizeof(*msgq) + msgq->nxt);
+
+			rmb(); /* do a read mb to guarantee */
+		}
+	}
+
+	vk->msgq_inited = true;
+
+	return 0;
+}
+
+static int bcm_vk_msg_chan_init(struct bcm_vk_msg_chan *chan)
+{
+	int rc = 0;
+	uint32_t i;
+
+	mutex_init(&chan->msgq_mutex);
+	spin_lock_init(&chan->pendq_lock);
+	for (i = 0; i < VK_MSGQ_MAX_NR; i++)
+		INIT_LIST_HEAD(&chan->pendq[i]);
+
+	return rc;
+}
+
+static void bcm_vk_append_pendq(struct bcm_vk_msg_chan *chan, uint16_t q_num,
+				struct bcm_vk_wkent *entry)
+{
+	spin_lock(&chan->pendq_lock);
+	list_add_tail(&entry->node, &chan->pendq[q_num]);
+	spin_unlock(&chan->pendq_lock);
+}
+
+void bcm_h2vk_doorbell(struct bcm_vk *vk, uint32_t q_num,
+			      uint32_t db_val)
+{
+	/* press door bell based on q_num */
+	vkwrite32(vk,
+		  db_val,
+		  BAR_0,
+		  VK_BAR0_REGSEG_DB_BASE + q_num * VK_BAR0_REGSEG_DB_REG_GAP);
+}
+
+static int bcm_h2vk_msg_enqueue(struct bcm_vk *vk, struct bcm_vk_wkent *entry)
+{
+	struct bcm_vk_msg_chan *chan = &vk->h2vk_msg_chan;
+	struct device *dev = &vk->pdev->dev;
+	struct vk_msg_blk *src = &entry->h2vk_msg[0];
+
+	volatile struct vk_msg_blk *dst;
+	struct bcm_vk_msgq *msgq;
+	uint32_t q_num = src->queue_id;
+	uint32_t wr_idx; /* local copy */
+	uint32_t i;
+
+	if (entry->h2vk_blks != src->size + 1) {
+		dev_err(dev, "number of blks %d not matching %d MsgId[0x%x]: func %d ctx 0x%x\n",
+			entry->h2vk_blks,
+			src->size + 1,
+			src->msg_id,
+			src->function_id,
+			src->context_id);
+		return -EMSGSIZE;
+	}
+
+	msgq = chan->msgq[q_num];
+
+	rmb(); /* start with a read barrier */
+	mutex_lock(&chan->msgq_mutex);
+
+	/* if not enough space, return EAGAIN and let app handles it */
+	if (VK_MSGQ_AVAIL_SPACE(msgq) < entry->h2vk_blks) {
+		mutex_unlock(&chan->msgq_mutex);
+		return -EAGAIN;
+	}
+
+	/* at this point, mutex is taken and there is enough space */
+
+	wr_idx = msgq->wr_idx;
+
+	dst = VK_MSGQ_BLK_ADDR(vk->bar[BAR_1], msgq, wr_idx);
+	for (i = 0; i < entry->h2vk_blks; i++) {
+		*dst = *src;
+
+		src++;
+		wr_idx = VK_MSGQ_INC(msgq, wr_idx, 1);
+		dst = VK_MSGQ_BLK_ADDR(vk->bar[BAR_1], msgq, wr_idx);
+	}
+
+	/* flush the write pointer */
+	msgq->wr_idx = wr_idx;
+	wmb(); /* flush */
+
+	/* log new info for debugging */
+	dev_dbg(dev,
+		"MsgQ[%d] [Rd Wr] = [%d %d] blks inserted %d - Q = [u-%d a-%d]/%d\n",
+		msgq->num,
+		msgq->rd_idx, msgq->wr_idx, entry->h2vk_blks,
+		VK_MSGQ_OCCUPIED(msgq),
+		VK_MSGQ_AVAIL_SPACE(msgq),
+		msgq->size);
+
+	mutex_unlock(&chan->msgq_mutex);
+
+	/*
+	 * press door bell based on queue number. 1 is added to the wr_idx
+	 * to avoid the value of 0 appearing on the VK side to distinguish
+	 * from initial value.
+	 */
+	bcm_h2vk_doorbell(vk, q_num, wr_idx + 1);
+
+	return 0;
+}
+
+int bcm_vk_send_shutdown_msg(struct bcm_vk *vk, uint32_t shut_type,
+			     pid_t pid)
+{
+	int rc = 0;
+	struct bcm_vk_wkent *entry;
+	struct device *dev = &vk->pdev->dev;
+
+	/*
+	 * check if the marker is still good.  Sometimes, the PCIe interface may
+	 * have gone done, and if so and we ship down thing based on broken
+	 * values, kernel may panic.
+	 */
+	if (!bcm_vk_msgq_marker_valid(vk)) {
+		dev_err(dev, "Marker invalid - PCIe interface potentially done!\n");
+		return -EINVAL;
+	}
+
+	entry = kzalloc(sizeof(struct bcm_vk_wkent) +
+			sizeof(struct vk_msg_blk), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	/* just fill up non-zero data */
+	entry->h2vk_msg[0].function_id = VK_FID_SHUTDOWN;
+	entry->h2vk_msg[0].queue_id = 0; /* use highest queue */
+	entry->h2vk_blks = 1; /* always 1 block */
+
+	entry->h2vk_msg[0].args[0] = shut_type;
+	entry->h2vk_msg[0].args[1] = pid;
+
+	rc = bcm_h2vk_msg_enqueue(vk, entry);
+	if (rc)
+		dev_err(dev,
+			"Sending shutdown message to q %d for pid %d fails.\n",
+			entry->h2vk_msg[0].queue_id, pid);
+
+	kfree(entry);
+
+	return rc;
+}
+
+int bcm_vk_handle_last_sess(struct bcm_vk *vk, struct task_struct *ppid)
+{
+	int rc = 0;
+	pid_t pid = task_pid_nr(ppid);
+	struct device *dev = &vk->pdev->dev;
+
+	/*
+	 * don't send down or do anything if message queue is not initialized
+	 * and if it is the reset session, clear it.
+	 */
+	if (!vk->msgq_inited) {
+
+		if (vk->reset_ppid == ppid)
+			vk->reset_ppid = NULL;
+		return -EPERM;
+	}
+
+	dev_info(dev, "No more sessions, shut down pid %d\n", pid);
+
+	/* only need to do it if it is not the reset process */
+	if (vk->reset_ppid != ppid)
+		rc = bcm_vk_send_shutdown_msg(vk, VK_SHUTDOWN_PID, pid);
+	else
+		/* reset the pointer if it is exiting last session */
+		vk->reset_ppid = NULL;
+
+	return rc;
+}
+
+static struct bcm_vk_wkent *bcm_vk_find_pending(struct bcm_vk_msg_chan *chan,
+						uint16_t q_num,
+						uint16_t msg_id,
+						unsigned long *map)
+{
+	bool found = false;
+	struct bcm_vk_wkent *entry;
+
+	spin_lock(&chan->pendq_lock);
+	list_for_each_entry(entry, &chan->pendq[q_num], node) {
+
+		if (entry->h2vk_msg[0].msg_id == msg_id) {
+			list_del(&entry->node);
+			found = true;
+			bitmap_clear(map, msg_id, 1);
+			break;
+		}
+	}
+	spin_unlock(&chan->pendq_lock);
+	return ((found) ? entry : NULL);
+}
+
+static uint32_t bcm_vk2h_msg_dequeue(struct bcm_vk *vk)
+{
+	struct device *dev = &vk->pdev->dev;
+	struct bcm_vk_msg_chan *chan = &vk->vk2h_msg_chan;
+	struct vk_msg_blk *data;
+	volatile struct vk_msg_blk *src;
+	struct vk_msg_blk *dst;
+	struct bcm_vk_msgq *msgq;
+	struct bcm_vk_wkent *entry;
+	uint32_t rd_idx;
+	uint32_t q_num, j;
+	uint32_t num_blks;
+	uint32_t total = 0;
+
+	/*
+	 * drain all the messages from the queues, and find its pending
+	 * entry in the h2vk queue, based on msg_id & q_num, and move the
+	 * entry to the vk2h pending queue, waiting for user space
+	 * program to extract
+	 */
+	mutex_lock(&chan->msgq_mutex);
+	rmb(); /* start with a read barrier */
+	for (q_num = 0; q_num < chan->q_nr; q_num++) {
+		msgq = chan->msgq[q_num];
+
+		while (!VK_MSGQ_EMPTY(msgq)) {
+
+			/* make a local copy */
+			rd_idx = msgq->rd_idx;
+
+			/* look at the first block and decide the size */
+			src = VK_MSGQ_BLK_ADDR(vk->bar[BAR_1], msgq, rd_idx);
+
+			num_blks = src->size + 1;
+
+			data = kzalloc(num_blks * VK_MSGQ_BLK_SIZE, GFP_KERNEL);
+
+			if (data) {
+				/* copy messages and linearize it */
+				dst = data;
+				for (j = 0; j < num_blks; j++) {
+					*dst = *src;
+
+					dst++;
+					rd_idx = VK_MSGQ_INC(msgq, rd_idx, 1);
+					src = VK_MSGQ_BLK_ADDR(vk->bar[BAR_1],
+							       msgq,
+							       rd_idx);
+				}
+				total++;
+			} else {
+				dev_crit(dev, "Error allocating memory\n");
+				/* just keep draining..... */
+				rd_idx = VK_MSGQ_INC(msgq, rd_idx, num_blks);
+			}
+
+			/* flush rd pointer after a message is dequeued */
+			msgq->rd_idx = rd_idx;
+			mb(); /* do both rd/wr as we are extracting data out */
+
+			/* log new info for debugging */
+			dev_dbg(dev,
+				"MsgQ[%d] [Rd Wr] = [%d %d] blks extracted %d - Q = [u-%d a-%d]/%d\n",
+				msgq->num,
+				msgq->rd_idx, msgq->wr_idx, num_blks,
+				VK_MSGQ_OCCUPIED(msgq),
+				VK_MSGQ_AVAIL_SPACE(msgq),
+				msgq->size);
+
+			/*
+			 * No need to search if it is an autonomous one-way
+			 * message from driver, as these messages do not bear
+			 * a h2vk pending item. Currently, only the shutdown
+			 * message falls into this category.
+			 */
+			if (data->function_id == VK_FID_SHUTDOWN) {
+				kfree(data);
+				continue;
+			}
+
+			/* lookup original message in h2vk direction */
+			entry = bcm_vk_find_pending(&vk->h2vk_msg_chan,
+						    q_num,
+						    data->msg_id,
+						    vk->bmap);
+
+			/*
+			 * if there is message to does not have prior send,
+			 * this is the location to add here
+			 */
+			if (entry) {
+				entry->vk2h_blks = num_blks;
+				entry->vk2h_msg = data;
+				bcm_vk_append_pendq(&vk->vk2h_msg_chan,
+						    q_num, entry);
+
+			} else {
+				dev_crit(dev,
+					 "Could not find MsgId[0x%x] for resp func %d\n",
+					 data->msg_id, data->function_id);
+				kfree(data);
+			}
+
+		}
+	}
+	mutex_unlock(&chan->msgq_mutex);
+	dev_dbg(dev, "total %d drained from queues\n", total);
+
+	return total;
+}
+
+/*
+ * deferred work queue for draining and auto download.
+ */
+static void bcm_vk_wq_handler(struct work_struct *work)
+{
+	struct bcm_vk *vk = container_of(work, struct bcm_vk, wq_work);
+	struct device *dev = &vk->pdev->dev;
+	uint32_t tot;
+
+	/* check wq offload bit map and see if auto download is requested */
+	if (test_bit(BCM_VK_WQ_DWNLD_AUTO, &vk->wq_offload)) {
+		bcm_vk_auto_load_all_images(vk);
+
+		/* at the end of operation, clear AUTO bit and pending bit */
+		clear_bit(BCM_VK_WQ_DWNLD_AUTO, &vk->wq_offload);
+		clear_bit(BCM_VK_WQ_DWNLD_PEND, &vk->wq_offload);
+	}
+
+	/* next, try to drain */
+	tot = bcm_vk2h_msg_dequeue(vk);
+
+	if (tot == 0)
+		dev_dbg(dev, "Spurious trigger for workqueue\n");
+}
+
+/*
+ * init routine for all required data structures
+ */
+static int bcm_vk_data_init(struct bcm_vk *vk)
+{
+	int rc = 0;
+	int i;
+
+	spin_lock_init(&vk->ctx_lock);
+	for (i = 0; i < VK_CMPT_CTX_MAX; i++) {
+		vk->ctx[i].in_use = false;
+		vk->ctx[i].idx = i;	/* self identity */
+		vk->ctx[i].miscdev = NULL;
+	}
+	spin_lock_init(&vk->msg_id_lock);
+	vk->msg_id = 0;
+
+	/* initialize hash table */
+	for (i = 0; i < VK_PID_HT_SZ; i++)
+		INIT_LIST_HEAD(&vk->pid_ht[i].head);
+
+	INIT_WORK(&vk->wq_work, bcm_vk_wq_handler);
+	return rc;
+}
+
+irqreturn_t bcm_vk_irqhandler(int irq, void *dev_id)
+{
+	struct bcm_vk *vk = dev_id;
+
+	if (!vk->msgq_inited) {
+		dev_err(&vk->pdev->dev,
+			"Interrupt %d received when msgq not inited\n", irq);
+		goto skip_schedule_work;
+	}
+
+	queue_work(vk->wq_thread, &vk->wq_work);
+
+skip_schedule_work:
+	return IRQ_HANDLED;
+}
+
+int bcm_vk_open(struct inode *inode, struct file *p_file)
+{
+	struct bcm_vk_ctx *ctx;
+	struct miscdevice *miscdev = (struct miscdevice *)p_file->private_data;
+	struct bcm_vk *vk = container_of(miscdev, struct bcm_vk, miscdev);
+	struct device *dev = &vk->pdev->dev;
+	int    rc = 0;
+
+	/* get a context and set it up for file */
+	ctx = bcm_vk_get_ctx(vk, current);
+	if (!ctx) {
+		dev_err(dev, "Error allocating context\n");
+		rc = -ENOMEM;
+	} else {
+
+		/*
+		 * set up context and replace private data with context for
+		 * other methods to use.  Reason for the context is because
+		 * it is allowed for multiple sessions to open the sysfs, and
+		 * for each file open, when upper layer query the response,
+		 * only those that are tied to a specific open should be
+		 * returned.  The context->idx will be used for such binding
+		 */
+		ctx->miscdev = miscdev;
+		p_file->private_data = ctx;
+		dev_dbg(dev, "ctx_returned with idx %d, pid %d\n",
+			ctx->idx, task_pid_nr(ctx->ppid));
+	}
+	return rc;
+}
+
+ssize_t bcm_vk_read(struct file *p_file, char __user *buf, size_t count,
+			   loff_t *f_pos)
+{
+	ssize_t rc = -ENOMSG;
+	struct bcm_vk_ctx *ctx = p_file->private_data;
+	struct bcm_vk *vk = container_of(ctx->miscdev, struct bcm_vk,
+					 miscdev);
+	struct device *dev = &vk->pdev->dev;
+	struct bcm_vk_msg_chan *chan = &vk->vk2h_msg_chan;
+	struct bcm_vk_wkent *entry = NULL;
+	uint32_t q_num;
+	uint32_t rsp_length;
+	bool found = false;
+
+	dev_dbg(dev, "Buf count %ld, msgq_inited %d\n", count, vk->msgq_inited);
+
+	if (!vk->msgq_inited)
+		return -EPERM;
+
+	found = false;
+
+	/*
+	 * search through the pendq on the vk2h chan, and return only those
+	 * that belongs to the same context.  Search is always from the high to
+	 * the low priority queues
+	 */
+	spin_lock(&chan->pendq_lock);
+	for (q_num = 0; q_num < chan->q_nr; q_num++) {
+		list_for_each_entry(entry, &chan->pendq[q_num], node) {
+			if (entry->ctx->idx == ctx->idx) {
+				if (count >=
+				    (entry->vk2h_blks * VK_MSGQ_BLK_SIZE)) {
+					list_del(&entry->node);
+					found = true;
+				} else {
+					/* buffer not big enough */
+					rc = -EMSGSIZE;
+				}
+				goto bcm_vk_read_loop_exit;
+			}
+		}
+	}
+ bcm_vk_read_loop_exit:
+	spin_unlock(&chan->pendq_lock);
+
+	if (found) {
+		/* retrieve the passed down msg_id */
+		entry->vk2h_msg[0].msg_id = entry->usr_msg_id;
+		rsp_length = entry->vk2h_blks * VK_MSGQ_BLK_SIZE;
+		if (copy_to_user(buf, entry->vk2h_msg, rsp_length) == 0)
+			rc = rsp_length;
+
+		bcm_vk_free_wkent(dev, entry);
+	} else if (rc == -EMSGSIZE) {
+		struct vk_msg_blk tmp_msg = entry->vk2h_msg[0];
+
+		/*
+		 * in this case, return just the first block, so
+		 * that app knows what size it is looking for.
+		 */
+		tmp_msg.msg_id = entry->usr_msg_id;
+		tmp_msg.size = entry->vk2h_blks - 1;
+		if (copy_to_user(buf, &tmp_msg, VK_MSGQ_BLK_SIZE) != 0) {
+			dev_err(dev, "Error return 1st block in -EMSGSIZE\n");
+			rc = -EFAULT;
+		}
+	}
+	return rc;
+}
+
+ssize_t bcm_vk_write(struct file *p_file, const char __user *buf,
+			    size_t count, loff_t *f_pos)
+{
+	ssize_t rc = -EPERM;
+	struct bcm_vk_ctx *ctx = p_file->private_data;
+	struct bcm_vk *vk = container_of(ctx->miscdev, struct bcm_vk,
+					 miscdev);
+	struct bcm_vk_msgq *msgq;
+	struct device *dev = &vk->pdev->dev;
+	struct bcm_vk_wkent *entry;
+
+	dev_dbg(dev, "Msg count %ld, msg_inited %d\n", count, vk->msgq_inited);
+
+	if (!vk->msgq_inited)
+		return -EPERM;
+
+	/* first, do sanity check where count should be multiple of basic blk */
+	if ((count % VK_MSGQ_BLK_SIZE) != 0) {
+		dev_err(dev, "Failure with size %ld not multiple of %ld\n",
+			count, VK_MSGQ_BLK_SIZE);
+		rc = -EBADR;
+		goto bcm_vk_write_err;
+	}
+
+	/* allocate the work entry and the buffer */
+	entry = kzalloc(sizeof(struct bcm_vk_wkent) + count, GFP_KERNEL);
+	if (!entry) {
+		rc = -ENOMEM;
+		goto bcm_vk_write_err;
+	}
+
+	/* now copy msg from user space, and then formulate the wk ent */
+	if (copy_from_user(&entry->h2vk_msg[0], buf, count))
+		goto bcm_vk_write_free_ent;
+
+	entry->h2vk_blks = count / VK_MSGQ_BLK_SIZE;
+	entry->ctx = ctx;
+
+	/* do a check on the blk size which could not exceed queue space */
+	msgq = vk->h2vk_msg_chan.msgq[entry->h2vk_msg[0].queue_id];
+	if (entry->h2vk_blks > (msgq->size - 1)) {
+		dev_err(dev, "Blk size %d exceed max queue size allowed %d\n",
+			entry->h2vk_blks, msgq->size - 1);
+		rc = -EOVERFLOW;
+		goto bcm_vk_write_free_ent;
+	}
+
+	/* Use internal message id */
+	entry->usr_msg_id = entry->h2vk_msg[0].msg_id;
+	rc = bcm_vk_get_msg_id(vk);
+	if (rc == VK_MSG_ID_OVERFLOW) {
+		dev_err(dev, "msg_id overflow\n");
+		rc = -EOVERFLOW;
+		goto bcm_vk_write_free_ent;
+	}
+	entry->h2vk_msg[0].msg_id = rc;
+
+	dev_dbg(dev,
+		"Message ctx id %d, usr_msg_id 0x%x sent msg_id 0x%x\n",
+		ctx->idx, entry->usr_msg_id,
+		entry->h2vk_msg[0].msg_id);
+
+	/* Convert any pointers to sg list */
+	if (entry->h2vk_msg[0].function_id == VK_FID_TRANS_BUF) {
+		int num_planes;
+		int dir;
+		struct _vk_data *data;
+
+		/*
+		 * check if we are in reset, if so, no buffer transfer is
+		 * allowed and return error.
+		 */
+		if (vk->reset_ppid) {
+			dev_dbg(dev, "No Transfer allowed during reset, pid %d.\n",
+				task_pid_nr(ctx->ppid));
+			rc = -EACCES;
+			goto bcm_vk_write_free_msgid;
+		}
+
+		num_planes = entry->h2vk_msg[0].args[0] & VK_CMD_PLANES_MASK;
+		if ((entry->h2vk_msg[0].args[0] & VK_CMD_MASK)
+		    == VK_CMD_DOWNLOAD) {
+			/* Memory transfer from vk device */
+			dir = DMA_FROM_DEVICE;
+		} else {
+			/* Memory transfer to vk device */
+			dir = DMA_TO_DEVICE;
+		}
+
+		/* Calculate vk_data location */
+		/* Go to end of the message */
+		data = (struct _vk_data *)
+			&(entry->h2vk_msg[entry->h2vk_msg[0].size + 1]);
+		/* Now back up to the start of the pointers */
+		data -= num_planes;
+
+		/* Convert user addresses to DMA SG List */
+		rc = bcm_vk_sg_alloc(dev, entry->dma, dir, data, num_planes);
+		if (rc)
+			goto bcm_vk_write_free_msgid;
+	}
+
+	/*
+	 * store wk ent to pending queue until a response is got. This needs to
+	 * be done before enqueuing the message
+	 */
+	bcm_vk_append_pendq(&vk->h2vk_msg_chan, entry->h2vk_msg[0].queue_id,
+			    entry);
+
+	rc = bcm_h2vk_msg_enqueue(vk, entry);
+	if (rc) {
+		dev_err(dev, "Fail to enqueue msg to h2vk queue\n");
+
+		/* remove message from pending list */
+		entry = bcm_vk_find_pending(&vk->h2vk_msg_chan,
+					    entry->h2vk_msg[0].queue_id,
+					    entry->h2vk_msg[0].msg_id,
+					    vk->bmap);
+		goto bcm_vk_write_free_msgid;
+	}
+
+	return count;
+
+bcm_vk_write_free_msgid:
+	bitmap_clear(vk->bmap, entry->h2vk_msg[0].msg_id, 1);
+bcm_vk_write_free_ent:
+	kfree(entry);
+bcm_vk_write_err:
+	return rc;
+}
+
+int bcm_vk_release(struct inode *inode, struct file *p_file)
+{
+	int ret;
+	struct bcm_vk_ctx *ctx = p_file->private_data;
+	struct bcm_vk *vk = container_of(ctx->miscdev, struct bcm_vk, miscdev);
+	struct device *dev = &vk->pdev->dev;
+	struct task_struct *ppid = ctx->ppid;
+	pid_t pid = task_pid_nr(ppid);
+
+	dev_dbg(dev, "Draining with context idx %d pid %d\n",
+		ctx->idx, pid);
+
+	bcm_vk_drain_all_pend(&vk->pdev->dev, &vk->h2vk_msg_chan, ctx);
+	bcm_vk_drain_all_pend(&vk->pdev->dev, &vk->vk2h_msg_chan, ctx);
+
+	ret = bcm_vk_free_ctx(vk, ctx);
+	if (ret == 0)
+		ret = bcm_vk_handle_last_sess(vk, ppid);
+
+	/* free memory if it is the last reference */
+	kref_put(&vk->kref, bcm_vk_release_data);
+
+	return ret;
+}
+
+int bcm_vk_msg_init(struct bcm_vk *vk)
+{
+	struct device *dev = &vk->pdev->dev;
+	int err = 0;
+
+	if (bcm_vk_data_init(vk)) {
+		dev_err(dev, "Error initializing internal data structures\n");
+		err = -EINVAL;
+		goto err_out;
+	}
+
+	if (bcm_vk_msg_chan_init(&vk->h2vk_msg_chan) ||
+	    bcm_vk_msg_chan_init(&vk->vk2h_msg_chan)) {
+		dev_err(dev, "Error initializing communication channel\n");
+		err = -EIO;
+		goto err_out;
+	}
+
+	/* create dedicated workqueue */
+	vk->wq_thread = create_singlethread_workqueue(vk->miscdev.name);
+	if (!vk->wq_thread) {
+		dev_err(dev, "Fail to create workqueue thread\n");
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	/* read msgq info */
+	if (bcm_vk_sync_msgq(vk)) {
+		dev_err(dev, "Error reading comm msg Q info\n");
+		err = -EIO;
+		goto err_out;
+	}
+
+err_out:
+	return err;
+}
+
+void bcm_vk_msg_remove(struct bcm_vk *vk)
+{
+	destroy_workqueue(vk->wq_thread);
+
+	/* drain all pending items */
+	bcm_vk_drain_all_pend(&vk->pdev->dev, &vk->h2vk_msg_chan, NULL);
+	bcm_vk_drain_all_pend(&vk->pdev->dev, &vk->vk2h_msg_chan, NULL);
+	vk->msgq_inited = false;
+}
+
+void bcm_vk_trigger_reset(struct bcm_vk *vk)
+{
+	uint32_t i;
+	u32 value;
+
+	/* clean up before pressing the door bell */
+	bcm_vk_drain_all_pend(&vk->pdev->dev, &vk->h2vk_msg_chan, NULL);
+	bcm_vk_drain_all_pend(&vk->pdev->dev, &vk->vk2h_msg_chan, NULL);
+	vk->msgq_inited = false;
+	vkwrite32(vk, 0, BAR_1, VK_BAR1_MSGQ_DEF_RDY);
+	/* make tag '\0' terminated */
+	vkwrite32(vk, 0, BAR_1, VK_BAR1_BOOT1_VER_TAG);
+
+	for (i = 0; i < VK_BAR1_DAUTH_MAX; i++) {
+		vkwrite32(vk, 0, BAR_1, VK_BAR1_DAUTH_STORE_ADDR(i));
+		vkwrite32(vk, 0, BAR_1, VK_BAR1_DAUTH_VALID_ADDR(i));
+	}
+	for (i = 0; i < VK_BAR1_SOTP_REVID_MAX; i++)
+		vkwrite32(vk, 0, BAR_1, VK_BAR1_SOTP_REVID_ADDR(i));
+
+	/*
+	 * When fastboot fails, the CODE_PUSH_OFFSET stays persistent.
+	 * Allowing us to debug the failure. When we call reset,
+	 * we should clear CODE_PUSH_OFFSET so ROM does not execute
+	 * fastboot again (and fails again) and instead waits for a new
+	 * codepush.
+	 */
+	value = vkread32(vk, BAR_0, BAR_CODEPUSH_SBL);
+	value &= ~CODEPUSH_MASK;
+	vkwrite32(vk, value, BAR_0, BAR_CODEPUSH_SBL);
+
+	/* reset fw_status with proper reason, and press db */
+	vkwrite32(vk, FW_STATUS_RESET_MBOX_DB, BAR_0, BAR_FW_STATUS);
+	bcm_h2vk_doorbell(vk, VK_BAR0_RESET_DB_NUM, VK_BAR0_RESET_DB_SOFT);
+
+	/* clear 4096 bits of bitmap */
+	bitmap_clear(vk->bmap, 0, VK_MSG_ID_BITMAP_SIZE);
+}
diff --git a/drivers/misc/bcm-vk/bcm_vk_msg.h b/drivers/misc/bcm-vk/bcm_vk_msg.h
new file mode 100644
index 000000000000..89b2ddeda334
--- /dev/null
+++ b/drivers/misc/bcm-vk/bcm_vk_msg.h
@@ -0,0 +1,169 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2018-2019 Broadcom.
+ */
+
+#ifndef BCM_VK_MSG_H
+#define BCM_VK_MSG_H
+
+#include <uapi/linux/misc/bcm_vk.h>
+#include "bcm_vk_sg.h"
+
+/* Single message queue control structure */
+struct bcm_vk_msgq {
+	uint16_t type;	/* queue type */
+	uint16_t num;	/* queue number */
+	uint32_t start;	/* offset in BAR1 where the queue memory starts */
+	volatile uint32_t rd_idx; /* read idx */
+	volatile uint32_t wr_idx; /* write idx */
+	uint32_t size;	/*
+			 * size, which is in number of 16byte blocks,
+			 * to align with the message data structure.
+			 */
+	uint32_t nxt;	/*
+			 * nxt offset to the next msg queue struct.
+			 * This is to provide flexibity for alignment purposes.
+			 */
+};
+
+#define VK_MSGQ_MAX_NR 4 /* Maximum number of message queues */
+
+/*
+ * some useful message queue macros
+ */
+#define VK_MSGQ_BLK_SIZE   (sizeof(struct vk_msg_blk))
+
+#define VK_MSGQ_EMPTY(q) (q->rd_idx == q->wr_idx)
+
+#define VK_MSGQ_SIZE_MASK(q) (q->size - 1)
+
+#define VK_MSGQ_INC(q, idx, inc) (((idx) + (inc)) & VK_MSGQ_SIZE_MASK(q))
+
+#define VK_MSGQ_FULL(q) (VK_MSGQ_INC(q, q->wr_idx, 1) == q->rd_idx)
+
+#define VK_MSGQ_OFFSET(q, idx) (q->start + VK_MSGQ_BLK_SIZE * (idx))
+
+#define VK_MSGQ_BLK_ADDR(base, q, idx) \
+	 (volatile struct vk_msg_blk *)(base + VK_MSGQ_OFFSET(q, idx))
+
+#define VK_MSGQ_OCCUPIED(q) ((q->wr_idx - q->rd_idx) & VK_MSGQ_SIZE_MASK(q))
+
+#define VK_MSGQ_AVAIL_SPACE(q) (q->size - VK_MSGQ_OCCUPIED(q) - 1)
+
+/* context per session opening of sysfs */
+struct bcm_vk_ctx {
+	struct list_head node; /* use for linkage in Hash Table */
+	uint idx;
+	bool in_use;
+	struct task_struct *ppid;
+	uint32_t hash_idx;
+	struct miscdevice *miscdev;
+};
+
+/* pid hash table entry */
+struct bcm_vk_ht_entry {
+	struct list_head head;
+};
+
+#define VK_DMA_MAX_ADDRS 4 /* Max 4 DMA Addresses */
+/* structure for house keeping a single work entry */
+struct bcm_vk_wkent {
+
+	struct list_head node; /* for linking purpose */
+	struct bcm_vk_ctx *ctx;
+
+	/* Store up to 4 dma pointers */
+	struct bcm_vk_dma dma[VK_DMA_MAX_ADDRS];
+
+	uint32_t vk2h_blks; /* response */
+	struct vk_msg_blk *vk2h_msg;
+
+	/*
+	 * put the h2vk_msg at the end so that we could simply append h2vk msg
+	 * to the end of the allocated block
+	 */
+	uint32_t usr_msg_id;
+	uint32_t h2vk_blks;
+	struct vk_msg_blk h2vk_msg[0];
+};
+
+/* control channel structure for either h2vk or vk2h communication */
+struct bcm_vk_msg_chan {
+	uint32_t q_nr;
+	struct mutex msgq_mutex;
+	/* pointing to BAR locations */
+	struct bcm_vk_msgq *msgq[VK_MSGQ_MAX_NR];
+
+	spinlock_t pendq_lock;
+	/* for temporary storing pending items, one for each queue */
+	struct list_head pendq[VK_MSGQ_MAX_NR];
+
+};
+
+/* TO_DO: some of the following defines may need to be adjusted */
+#define VK_CMPT_CTX_MAX		(32 * 5)
+
+/* hash table defines to store the opened FDs */
+#define VK_PID_HT_SHIFT_BIT	7 /* 128 */
+#define VK_PID_HT_SZ		(1 << VK_PID_HT_SHIFT_BIT)
+
+/* The following are offsets of DDR info provided by the vk card */
+#define VK_BAR0_SEG_SIZE	(4 * SZ_1K) /* segment size for BAR0 */
+
+/* shutdown types supported */
+#define VK_SHUTDOWN_PID		1
+#define VK_SHUTDOWN_GRACEFUL	2
+
+/*
+ * first door bell reg, ie for queue = 0.  Only need the first one, as
+ * we will use the queue number to derive the others
+ */
+#define VK_BAR0_REGSEG_DB_BASE		0x484
+#define VK_BAR0_REGSEG_DB_REG_GAP	8 /*
+					   * DB register gap,
+					   * DB1 at 0x48c and DB2 at 0x494
+					   */
+
+/* reset register and specific values */
+#define VK_BAR0_RESET_DB_NUM		3
+#define VK_BAR0_RESET_DB_SOFT		0xFFFFFFFF
+#define VK_BAR0_RESET_DB_HARD		0xFFFFFFFD
+
+/* BAR1 message q definition */
+
+/* indicate if msgq ctrl in BAR1 is populated */
+#define VK_BAR1_MSGQ_DEF_RDY		0x60c0
+/* ready marker value for the above location */
+#define VK_BAR1_MSGQ_RDY_MARKER		0xbeefcafe
+/* number of msgqs in BAR1 */
+#define VK_BAR1_MSGQ_NR			0x60c4
+/* BAR1 queue control structure offset */
+#define VK_BAR1_MSGQ_CTRL_OFF		0x60c8
+/* BAR1 ucode and boot1 version tag */
+#define VK_BAR1_UCODE_VER_TAG		0x6170
+#define VK_BAR1_BOOT1_VER_TAG		0x61b0
+#define VK_BAR1_VER_TAG_SIZE		64
+/* BAR1 SOTP AUTH and REVID info */
+#define VK_BAR1_DAUTH_BASE_ADDR		0x6200
+#define VK_BAR1_DAUTH_STORE_SIZE	0x48
+#define VK_BAR1_DAUTH_VALID_SIZE	0x8
+#define VK_BAR1_DAUTH_MAX		4
+#define VK_BAR1_DAUTH_STORE_ADDR(x) \
+		(VK_BAR1_DAUTH_BASE_ADDR + \
+		 (x) * (VK_BAR1_DAUTH_STORE_SIZE + VK_BAR1_DAUTH_VALID_SIZE))
+#define VK_BAR1_DAUTH_VALID_ADDR(x) \
+		(VK_BAR1_DAUTH_STORE_ADDR(x) + VK_BAR1_DAUTH_STORE_SIZE)
+
+#define VK_BAR1_SOTP_REVID_BASE_ADDR	0x6340
+#define VK_BAR1_SOTP_REVID_SIZE		0x10
+#define VK_BAR1_SOTP_REVID_MAX		2
+#define VK_BAR1_SOTP_REVID_ADDR(x) \
+		(VK_BAR1_SOTP_REVID_BASE_ADDR + (x) * VK_BAR1_SOTP_REVID_SIZE)
+
+/* Scratch memory allocated on host for VK */
+#define VK_BAR1_SCRATCH_OFF_LO		0x61f0
+#define VK_BAR1_SCRATCH_OFF_HI		(VK_BAR1_SCRATCH_OFF_LO + 4)
+#define VK_BAR1_SCRATCH_SZ_ADDR		(VK_BAR1_SCRATCH_OFF_LO + 8)
+#define VK_BAR1_SCRATCH_DEF_NR_PAGES	32
+
+#endif
diff --git a/drivers/misc/bcm-vk/bcm_vk_sg.c b/drivers/misc/bcm-vk/bcm_vk_sg.c
new file mode 100644
index 000000000000..3839de7c22a6
--- /dev/null
+++ b/drivers/misc/bcm-vk/bcm_vk_sg.c
@@ -0,0 +1,273 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2018-2019 Broadcom.
+ */
+#include <linux/dma-mapping.h>
+#include <linux/mm.h>
+#include <linux/pagemap.h>
+#include <linux/vmalloc.h>
+
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/unaligned.h>
+
+#include <uapi/linux/misc/bcm_vk.h>
+
+#include "bcm_vk.h"
+#include "bcm_vk_msg.h"
+#include "bcm_vk_sg.h"
+
+/*
+ * Valkyrie has a hardware limitation of 16M transfer size.
+ * So limit the SGL chunks to 16M.
+ */
+#define BCM_VK_MAX_SGL_CHUNK SZ_16M
+
+static int bcm_vk_dma_alloc(struct device *dev,
+			    struct bcm_vk_dma *dma,
+			    int dir,
+			    struct _vk_data *vkdata);
+static int bcm_vk_dma_free(struct device *dev, struct bcm_vk_dma *dma);
+
+/* Uncomment to dump SGLIST */
+//#define BCM_VK_DUMP_SGLIST
+
+static int bcm_vk_dma_alloc(struct device *dev,
+			    struct bcm_vk_dma *dma,
+			    int direction,
+			    struct _vk_data *vkdata)
+{
+	dma_addr_t addr, sg_addr;
+	int err;
+	int i;
+	int offset;
+	uint32_t size;
+	uint32_t remaining_size;
+	uint32_t transfer_size;
+	uint64_t data;
+	unsigned long first, last;
+	struct _vk_data *sgdata;
+
+	/* Get 64-bit user address */
+	data = get_unaligned(&(vkdata->address));
+
+	/* offset into first page */
+	offset = offset_in_page(data);
+
+	/* Calculate number of pages */
+	first = (data & PAGE_MASK) >> PAGE_SHIFT;
+	last  = ((data + vkdata->size - 1) & PAGE_MASK) >> PAGE_SHIFT;
+	dma->nr_pages = last - first + 1;
+
+	/* Allocate DMA pages */
+	dma->pages = kmalloc_array(dma->nr_pages,
+				   sizeof(struct page *),
+				   GFP_KERNEL);
+	if (dma->pages == NULL)
+		return -ENOMEM;
+
+	dev_dbg(dev, "Alloc DMA Pages [0x%llx+0x%x => %d pages]\n",
+		data, vkdata->size, dma->nr_pages);
+
+	dma->direction = direction;
+
+	/* Get user pages into memory */
+	err = get_user_pages_fast(data & PAGE_MASK,
+				  dma->nr_pages,
+				  direction == DMA_FROM_DEVICE,
+				  dma->pages);
+	if (err != dma->nr_pages) {
+		dma->nr_pages = (err >= 0) ? err : 0;
+		dev_err(dev, "get_user_pages_fast, err=%d [%d]\n",
+			err, dma->nr_pages);
+		return err < 0 ? err : -EINVAL;
+	}
+
+	/* Max size of sg list is 1 per mapped page + fields at start */
+	dma->sglen = (dma->nr_pages * sizeof(*sgdata)) +
+		     (sizeof(uint32_t) * SGLIST_VKDATA_START);
+
+	/* Allocate sglist */
+	dma->sglist = dma_alloc_coherent(dev,
+					 dma->sglen,
+					 &dma->handle,
+					 GFP_KERNEL);
+	if (!dma->sglist)
+		return -ENOMEM;
+
+	dma->sglist[SGLIST_NUM_SG] = 0;
+	dma->sglist[SGLIST_TOTALSIZE] = vkdata->size;
+	remaining_size = vkdata->size;
+	sgdata = (struct _vk_data *)&(dma->sglist[SGLIST_VKDATA_START]);
+
+	/* Map all pages into DMA */
+	i = 0;
+	size = min_t(size_t, PAGE_SIZE - offset, remaining_size);
+	remaining_size -= size;
+	sg_addr = dma_map_page(dev,
+			       dma->pages[0],
+			       offset,
+			       size,
+			       dma->direction);
+	transfer_size = size;
+	if (unlikely(dma_mapping_error(dev, sg_addr))) {
+		__free_page(dma->pages[0]);
+		return -EIO;
+	}
+
+	for (i = 1; i < dma->nr_pages; i++) {
+		size = min_t(size_t, PAGE_SIZE, remaining_size);
+		remaining_size -= size;
+		addr = dma_map_page(dev,
+				    dma->pages[i],
+				    0,
+				    size,
+				    dma->direction);
+		if (unlikely(dma_mapping_error(dev, addr))) {
+			__free_page(dma->pages[i]);
+			return -EIO;
+		}
+
+		/*
+		 * Compress SG list entry when pages are contiguous
+		 * and transfer size less or equal to BCM_VK_MAX_SGL_CHUNK
+		 */
+		if ((addr == (sg_addr + transfer_size)) &&
+		    ((transfer_size + size) <= BCM_VK_MAX_SGL_CHUNK)) {
+			/* pages are contiguous, add to same sg entry */
+			transfer_size += size;
+		} else {
+			/* pages are not contiguous, write sg entry */
+			sgdata->size = transfer_size;
+			put_unaligned(sg_addr, (uint64_t *)&(sgdata->address));
+			dma->sglist[SGLIST_NUM_SG]++;
+
+			/* start new sg entry */
+			sgdata++;
+			sg_addr = addr;
+			transfer_size = size;
+		}
+	}
+	/* Write last sg list entry */
+	sgdata->size = transfer_size;
+	put_unaligned(sg_addr, (uint64_t *)&(sgdata->address));
+	dma->sglist[SGLIST_NUM_SG]++;
+
+	/* Update pointers and size field to point to sglist */
+	put_unaligned((uint64_t)dma->handle, &(vkdata->address));
+	vkdata->size = (dma->sglist[SGLIST_NUM_SG] * sizeof(*sgdata)) +
+		       (sizeof(uint32_t) * SGLIST_VKDATA_START);
+
+#ifdef BCM_VK_DUMP_SGLIST
+	dev_dbg(dev,
+		"sgl 0x%llx handle 0x%llx, sglen: 0x%x sgsize: 0x%x\n",
+		(uint64_t)dma->sglist,
+		dma->handle,
+		dma->sglen,
+		vkdata->size);
+	for (i = 0; i < vkdata->size / sizeof(uint32_t); i++)
+		dev_dbg(dev, "i:0x%x 0x%x\n", i, dma->sglist[i]);
+#endif
+
+	return 0;
+}
+
+int bcm_vk_sg_alloc(struct device *dev,
+		    struct bcm_vk_dma *dma,
+		    int dir,
+		    struct _vk_data *vkdata,
+		    int num)
+{
+	int i;
+	int rc = -EINVAL;
+
+	/* Convert user addresses to DMA SG List */
+	for (i = 0; i < num; i++) {
+		if (vkdata[i].size && vkdata[i].address) {
+			/*
+			 * If both size and address are non-zero
+			 * then DMA alloc.
+			 */
+			rc = bcm_vk_dma_alloc(dev,
+					      &dma[i],
+					      dir,
+					      &vkdata[i]);
+		} else if (vkdata[i].size ||
+			   vkdata[i].address) {
+			/*
+			 * If one of size and address are zero
+			 * there is a problem.
+			 */
+			dev_err(dev,
+				"Invalid vkdata %x 0x%x 0x%llx\n",
+				i, vkdata[i].size, vkdata[i].address);
+			rc = -EINVAL;
+		} else {
+			/*
+			 * If size and address are both zero
+			 * don't convert, but return success.
+			 */
+			rc = 0;
+		}
+
+		if (rc)
+			goto fail_alloc;
+	}
+	return rc;
+
+fail_alloc:
+	while (i > 0) {
+		i--;
+		if (dma[i].sglist)
+			bcm_vk_dma_free(dev, &dma[i]);
+	}
+	return rc;
+}
+
+static int bcm_vk_dma_free(struct device *dev, struct bcm_vk_dma *dma)
+{
+	dma_addr_t addr;
+	int i;
+	int num_sg;
+	uint32_t size;
+	struct _vk_data *vkdata;
+
+	dev_dbg(dev, "free sglist=%p sglen=0x%x\n",
+		dma->sglist, dma->sglen);
+
+	/* Unmap all pages in the sglist */
+	num_sg = dma->sglist[SGLIST_NUM_SG];
+	vkdata = (struct _vk_data *)&(dma->sglist[SGLIST_VKDATA_START]);
+	for (i = 0; i < num_sg; i++) {
+		size = vkdata[i].size;
+		addr = get_unaligned(&(vkdata[i].address));
+
+		dma_unmap_page(dev, addr, size, dma->direction);
+	}
+
+	/* Free allocated sglist */
+	dma_free_coherent(dev, dma->sglen, dma->sglist, dma->handle);
+
+	/* Release lock on all pages */
+	for (i = 0; i < dma->nr_pages; i++)
+		put_page(dma->pages[i]);
+
+	/* Free allocated dma pages */
+	kfree(dma->pages);
+	dma->sglist = NULL;
+
+	return 0;
+}
+
+int bcm_vk_sg_free(struct device *dev, struct bcm_vk_dma *dma, int num)
+{
+	int i;
+
+	/* Unmap and free all pages and sglists */
+	for (i = 0; i < num; i++) {
+		if (dma[i].sglist)
+			bcm_vk_dma_free(dev, &dma[i]);
+	}
+
+	return 0;
+}
diff --git a/drivers/misc/bcm-vk/bcm_vk_sg.h b/drivers/misc/bcm-vk/bcm_vk_sg.h
new file mode 100644
index 000000000000..6e90ac2123b8
--- /dev/null
+++ b/drivers/misc/bcm-vk/bcm_vk_sg.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2018-2019 Broadcom.
+ */
+
+#ifndef BCM_VK_SG_H
+#define BCM_VK_SG_H
+
+#include <linux/dma-mapping.h>
+
+struct bcm_vk_dma {
+	/* for userland buffer */
+	struct page **pages;
+	int nr_pages;
+
+	/* common */
+	dma_addr_t handle;
+	/*
+	 * sglist is of the following LE format
+	 * [U32] num_sg  = number of sg addresses (N)
+	 * [U32] totalsize = totalsize of data being transferred in sglist
+	 * [U32] size[0] = size of data in address0
+	 * [U32] addr_l[0] = lower 32-bits of address0
+	 * [U32] addr_h[0] = higher 32-bits of address0
+	 * ..
+	 * [U32] size[N-1] = size of data in addressN-1
+	 * [U32] addr_l[N-1] = lower 32-bits of addressN-1
+	 * [U32] addr_h[N-1] = higher 32-bits of addressN-1
+	 */
+	uint32_t *sglist;
+#define SGLIST_NUM_SG		0
+#define SGLIST_TOTALSIZE	1
+#define SGLIST_VKDATA_START	2
+
+	int sglen; /* Length (bytes) of sglist */
+	int direction;
+};
+
+struct _vk_data {
+	uint32_t size;    /* data size in bytes */
+	uint64_t address; /* Pointer to data     */
+} __packed;
+
+/*
+ * Scatter-gather DMA buffer API.
+ *
+ * These functions provide a simple way to create a page list and a
+ * scatter-gather list from userspace address and map the memory
+ * for DMA operation.
+ */
+int bcm_vk_sg_alloc(struct device *dev,
+		    struct bcm_vk_dma *dma,
+		    int dir,
+		    struct _vk_data *vkdata,
+		    int num);
+
+int bcm_vk_sg_free(struct device *dev, struct bcm_vk_dma *dma, int num);
+
+#endif
+
-- 
2.17.1

