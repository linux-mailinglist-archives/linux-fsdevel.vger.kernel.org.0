Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF081123959
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 23:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfLQWSP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 17:18:15 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:36663 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbfLQWSB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 17:18:01 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mn2iP-1i0tG23yJr-00k6zJ; Tue, 17 Dec 2019 23:17:30 +0100
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
Subject: [PATCH v2 15/27] compat_ioctl: add scsi_compat_ioctl
Date:   Tue, 17 Dec 2019 23:16:56 +0100
Message-Id: <20191217221708.3730997-16-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191217221708.3730997-1-arnd@arndb.de>
References: <20191217221708.3730997-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7+9fPO46Y0HOH2OsOUifwZayoQFbXANj+Oa9VP+1U7rh8ZhZZ8F
 3hxCkpaA0NO2kdv6ZjC7Pgek4BhVndAGAH74m7t3INTUHKuOrVeEt1zDk8MHcDHm51AGTFB
 i36qQDfnTVO+CYDUu1JMmlixsSxong5R851SGfuaWLQN8Xk51RMnN8aiZwuYw/GZ0rdzqWU
 ivSwaSOO+EgFMWYzMvC3g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yXc2hnIb6Ew=:BmbRqeeBaGxFN50taxmFBo
 AY7Ftkhhc9Z2VsPCHIDRN/ZHcQLs60RU/ZEvxvBwZIglimP546GHVde0vtrNsMN2HtblCPxPw
 rBRQKO2ARkBnklEkN+iMV8MEZhJ8srTpBNGo8nfXETXa7SNAXtW+768+tj9dtTYADhOLIf958
 8gTa2Y/MsH++UEcuF1GQfQGgKH0pqtWukenVKl/gFUeDh2sgrNtRNQW9jwS6C+dnOAfguHCH1
 ID4Qs/pfPtvcNkWQWOYnC8Cxk0EhwbG3kPjv18zQNtWROCysQsIKEMg+mrkJhhD9kz6QHTcQJ
 4Qsm7lKUNqfcqQKd8/ifFRcooygBwXfk0H+pw5ae8EzcVq1VETJSXA34T9Ryrmz53GrgMYoL6
 EIFHi7mI4La9/ty+0u/a8wHeKGVttDL80Ve3WItZ2vjoButtXX39HOuDaUWPZnD+owBuSfdhG
 Qfv/6nqIAQr5JvRqQuDM7oJ55+Eyja+eWaVUfp6XTUoRRVOfW4sY0HhnelNN6575s1Ri+zwmS
 rgNyU+vhYg3HUOqdkydSJ16lwkzL+ZM8b/ZYMqlil81ogT9V0OHOaMJMboTsf8bUhDIn3UNyd
 GdrCgPPUYp0N6SRsm9h5v/5lrCmgyINDBzuHm6Aq/2WRJOe179VmvhYwVJ7WoyjKaFx+oQ+Hz
 +/QDIQBT9HWa4Cc+67t5UsCVSoIAAEb3h0sFHmNakFM/D8ySgTVTW6EUuNTABasAetCKik53V
 G1D/SAS96Qlaky35Ws5whccdgGnA0xfZYAWRT6trmwdon9U0fcmT9ICdsZ3oRrzZ/tymL4h7Y
 QG0c9EQ4J1FnZrfxc09XCL1xwnf8QaZGZFuI14EaA3IG+nEKpmEWbKf9yh/ZzGlgoVthHYykV
 WGe2+u3w+mZZxg6ytwlw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order to move the compat handling for SCSI ioctl commands out of
fs/compat_ioctl.c into the individual drivers, we need a helper function
first to match the native ioctl handler called by sd, sr, st, etc.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/scsi_ioctl.c | 54 +++++++++++++++++++++++++++++----------
 include/scsi/scsi_ioctl.h |  1 +
 2 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/drivers/scsi/scsi_ioctl.c b/drivers/scsi/scsi_ioctl.c
index 57bcd05605bf..8f3af87b6bb0 100644
--- a/drivers/scsi/scsi_ioctl.c
+++ b/drivers/scsi/scsi_ioctl.c
@@ -189,17 +189,7 @@ static int scsi_ioctl_get_pci(struct scsi_device *sdev, void __user *arg)
 }
 
 
-/**
- * scsi_ioctl - Dispatch ioctl to scsi device
- * @sdev: scsi device receiving ioctl
- * @cmd: which ioctl is it
- * @arg: data associated with ioctl
- *
- * Description: The scsi_ioctl() function differs from most ioctls in that it
- * does not take a major/minor number as the dev field.  Rather, it takes
- * a pointer to a &struct scsi_device.
- */
-int scsi_ioctl(struct scsi_device *sdev, int cmd, void __user *arg)
+static int scsi_ioctl_common(struct scsi_device *sdev, int cmd, void __user *arg)
 {
 	char scsi_cmd[MAX_COMMAND_SIZE];
 	struct scsi_sense_hdr sense_hdr;
@@ -266,14 +256,50 @@ int scsi_ioctl(struct scsi_device *sdev, int cmd, void __user *arg)
                 return scsi_ioctl_get_pci(sdev, arg);
 	case SG_SCSI_RESET:
 		return scsi_ioctl_reset(sdev, arg);
-	default:
-		if (sdev->host->hostt->ioctl)
-			return sdev->host->hostt->ioctl(sdev, cmd, arg);
 	}
+	return -ENOIOCTLCMD;
+}
+
+/**
+ * scsi_ioctl - Dispatch ioctl to scsi device
+ * @sdev: scsi device receiving ioctl
+ * @cmd: which ioctl is it
+ * @arg: data associated with ioctl
+ *
+ * Description: The scsi_ioctl() function differs from most ioctls in that it
+ * does not take a major/minor number as the dev field.  Rather, it takes
+ * a pointer to a &struct scsi_device.
+ */
+int scsi_ioctl(struct scsi_device *sdev, int cmd, void __user *arg)
+{
+	int ret = scsi_ioctl_common(sdev, cmd, arg);
+
+	if (ret != -ENOIOCTLCMD)
+		return ret;
+
+	if (sdev->host->hostt->ioctl)
+		return sdev->host->hostt->ioctl(sdev, cmd, arg);
+
 	return -EINVAL;
 }
 EXPORT_SYMBOL(scsi_ioctl);
 
+#ifdef CONFIG_COMPAT
+int scsi_compat_ioctl(struct scsi_device *sdev, int cmd, void __user *arg)
+{
+	int ret = scsi_ioctl_common(sdev, cmd, arg);
+
+	if (ret != -ENOIOCTLCMD)
+		return ret;
+
+	if (sdev->host->hostt->compat_ioctl)
+		return sdev->host->hostt->compat_ioctl(sdev, cmd, arg);
+
+	return ret;
+}
+EXPORT_SYMBOL(scsi_compat_ioctl);
+#endif
+
 /*
  * We can process a reset even when a device isn't fully operable.
  */
diff --git a/include/scsi/scsi_ioctl.h b/include/scsi/scsi_ioctl.h
index 5101e987c0ef..4fe69d863b5d 100644
--- a/include/scsi/scsi_ioctl.h
+++ b/include/scsi/scsi_ioctl.h
@@ -44,6 +44,7 @@ typedef struct scsi_fctargaddress {
 int scsi_ioctl_block_when_processing_errors(struct scsi_device *sdev,
 		int cmd, bool ndelay);
 extern int scsi_ioctl(struct scsi_device *, int, void __user *);
+extern int scsi_compat_ioctl(struct scsi_device *sdev, int cmd, void __user *arg);
 
 #endif /* __KERNEL__ */
 #endif /* _SCSI_IOCTL_H */
-- 
2.20.0

