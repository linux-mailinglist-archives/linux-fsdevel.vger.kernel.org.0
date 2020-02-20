Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC8161653D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 01:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbgBTAsr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 19:48:47 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38308 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727555AbgBTAsp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 19:48:45 -0500
Received: by mail-pg1-f193.google.com with SMTP id d6so1001595pgn.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2020 16:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sKqnGcIb54G+edEpjgURZj2ckSacGktuDw7MmMglohk=;
        b=BSs9cShGZFGiI9sZygDzkEzvKX6e6aqkV4bGP99Z5fL8jm6htE2z7+H3VG/VWhBFwp
         T8r9ah3EHYPdpPdoboP8LhlDwtJfbItMXl1pOUqpioO7nVu7Y1EbVBl88aNPH/r2lsgI
         iD+uB3kuvC+3HWBWwH6uISzpoBirKSknZ18N0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sKqnGcIb54G+edEpjgURZj2ckSacGktuDw7MmMglohk=;
        b=EkqMt5J7KXWd9ffBndk+qY4GLAOgkdHQ5pGpznTrNGfDYJUpZL5F74Nty47QC31kcf
         NIPsrCs/8V6GoRUnrFOtpMIi90lPgWX2UP8KGrika0IOuT4Z4xjDZLQ6mGaFpAhdelAt
         7CzGAxTUZ39emhXlNh/t/7zE8QhxdHrxt71eNC5V/wjwZE7682waoFNd7dlVY7rIyO6i
         7I/vg4X7otxRbODjJwDtsCkKZO/rxXtbKf1a1W+iSWNcZbA1tV+z9OhEs1GP6NuV8HCb
         4m6vq3P4VLYFishP9uzvlapFay7uiEwNlbDAdeL2HpQ5DWLduwj03Mvy3+BduMzaKnsg
         WwDw==
X-Gm-Message-State: APjAAAWaiDdsEqvmkzU/QxapmKcq7u6cifFjgwKCizoeoz4giWdNzK46
        hkk0bvPIhjzibq077VJ+xt0DGA==
X-Google-Smtp-Source: APXvYqyrkIEPT6+Jx8Y5tp5dlOBSB6ZMiISr/An4swXe7HDPYmVNUZN4vn2G4NHST43aoQbbmjVwOg==
X-Received: by 2002:a63:e509:: with SMTP id r9mr32152531pgh.274.1582159724952;
        Wed, 19 Feb 2020 16:48:44 -0800 (PST)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 64sm816323pfd.48.2020.02.19.16.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 16:48:44 -0800 (PST)
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
        Andy Gross <agross@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v2 2/7] firmware: add offset to request_firmware_into_buf
Date:   Wed, 19 Feb 2020 16:48:20 -0800
Message-Id: <20200220004825.23372-3-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200220004825.23372-1-scott.branden@broadcom.com>
References: <20200220004825.23372-1-scott.branden@broadcom.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add offset to request_firmware_into_buf to allow for portions
of firmware file to be read into a buffer.  Necessary where firmware
needs to be loaded in portions from file in memory constrained systems.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/base/firmware_loader/firmware.h |  5 +++
 drivers/base/firmware_loader/main.c     | 49 +++++++++++++++++--------
 drivers/soc/qcom/mdt_loader.c           |  7 +++-
 include/linux/firmware.h                |  8 +++-
 lib/test_firmware.c                     |  4 +-
 5 files changed, 53 insertions(+), 20 deletions(-)

diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmware_loader/firmware.h
index 8656e5239a80..9f4fddcb1ab7 100644
--- a/drivers/base/firmware_loader/firmware.h
+++ b/drivers/base/firmware_loader/firmware.h
@@ -29,6 +29,8 @@
  *	firmware caching mechanism.
  * @FW_OPT_NOFALLBACK_SYSFS: Disable the sysfs fallback mechanism. Takes
  *	precedence over &FW_OPT_UEVENT and &FW_OPT_USERHELPER.
+ * @FW_OPT_PARTIAL: Allow partial read of firmware instead of needing to read
+ *	entire file.
  */
 enum fw_opt {
 	FW_OPT_UEVENT			= BIT(0),
@@ -37,6 +39,7 @@ enum fw_opt {
 	FW_OPT_NO_WARN			= BIT(3),
 	FW_OPT_NOCACHE			= BIT(4),
 	FW_OPT_NOFALLBACK_SYSFS		= BIT(5),
+	FW_OPT_PARTIAL			= BIT(6),
 };
 
 enum fw_status {
@@ -64,6 +67,8 @@ struct fw_priv {
 	void *data;
 	size_t size;
 	size_t allocated_size;
+	size_t offset;
+	unsigned int flags;
 #ifdef CONFIG_FW_LOADER_PAGED_BUF
 	bool is_paged_buf;
 	struct page **pages;
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 57133a9dad09..28312309aab4 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -167,7 +167,8 @@ static int fw_cache_piggyback_on_request(const char *name);
 
 static struct fw_priv *__allocate_fw_priv(const char *fw_name,
 					  struct firmware_cache *fwc,
-					  void *dbuf, size_t size)
+					  void *dbuf, size_t size,
+					  size_t offset, unsigned int flags)
 {
 	struct fw_priv *fw_priv;
 
@@ -185,6 +186,8 @@ static struct fw_priv *__allocate_fw_priv(const char *fw_name,
 	fw_priv->fwc = fwc;
 	fw_priv->data = dbuf;
 	fw_priv->allocated_size = size;
+	fw_priv->offset = offset;
+	fw_priv->flags = flags;
 	fw_state_init(fw_priv);
 #ifdef CONFIG_FW_LOADER_USER_HELPER
 	INIT_LIST_HEAD(&fw_priv->pending_list);
@@ -210,9 +213,11 @@ static struct fw_priv *__lookup_fw_priv(const char *fw_name)
 static int alloc_lookup_fw_priv(const char *fw_name,
 				struct firmware_cache *fwc,
 				struct fw_priv **fw_priv, void *dbuf,
-				size_t size, enum fw_opt opt_flags)
+				size_t size, enum fw_opt opt_flags,
+				size_t offset)
 {
 	struct fw_priv *tmp;
+	unsigned int pread_flags;
 
 	spin_lock(&fwc->lock);
 	if (!(opt_flags & FW_OPT_NOCACHE)) {
@@ -226,7 +231,12 @@ static int alloc_lookup_fw_priv(const char *fw_name,
 		}
 	}
 
-	tmp = __allocate_fw_priv(fw_name, fwc, dbuf, size);
+	if (opt_flags & FW_OPT_PARTIAL)
+		pread_flags = KERNEL_PREAD_FLAG_PART;
+	else
+		pread_flags = KERNEL_PREAD_FLAG_WHOLE;
+
+	tmp = __allocate_fw_priv(fw_name, fwc, dbuf, size, offset, pread_flags);
 	if (tmp) {
 		INIT_LIST_HEAD(&tmp->list);
 		if (!(opt_flags & FW_OPT_NOCACHE))
@@ -493,8 +503,9 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
 		}
 
 		fw_priv->size = 0;
-		rc = kernel_read_file_from_path(path, &buffer, &size,
-						msize, id);
+		rc = kernel_pread_file_from_path(path, &buffer, &size,
+						 fw_priv->offset, msize,
+						 fw_priv->flags, id);
 		if (rc) {
 			if (rc != -ENOENT)
 				dev_warn(device, "loading %s failed with error %d\n",
@@ -685,7 +696,7 @@ int assign_fw(struct firmware *fw, struct device *device,
 static int
 _request_firmware_prepare(struct firmware **firmware_p, const char *name,
 			  struct device *device, void *dbuf, size_t size,
-			  enum fw_opt opt_flags)
+			  enum fw_opt opt_flags, size_t offset)
 {
 	struct firmware *firmware;
 	struct fw_priv *fw_priv;
@@ -704,7 +715,7 @@ _request_firmware_prepare(struct firmware **firmware_p, const char *name,
 	}
 
 	ret = alloc_lookup_fw_priv(name, &fw_cache, &fw_priv, dbuf, size,
-				  opt_flags);
+				  opt_flags, offset);
 
 	/*
 	 * bind with 'priv' now to avoid warning in failure path
@@ -751,7 +762,7 @@ static void fw_abort_batch_reqs(struct firmware *fw)
 static int
 _request_firmware(const struct firmware **firmware_p, const char *name,
 		  struct device *device, void *buf, size_t size,
-		  enum fw_opt opt_flags)
+		  enum fw_opt opt_flags, size_t offset)
 {
 	struct firmware *fw = NULL;
 	int ret;
@@ -765,7 +776,7 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
 	}
 
 	ret = _request_firmware_prepare(&fw, name, device, buf, size,
-					opt_flags);
+					opt_flags, offset);
 	if (ret <= 0) /* error or already assigned */
 		goto out;
 
@@ -825,7 +836,7 @@ request_firmware(const struct firmware **firmware_p, const char *name,
 	/* Need to pin this module until return */
 	__module_get(THIS_MODULE);
 	ret = _request_firmware(firmware_p, name, device, NULL, 0,
-				FW_OPT_UEVENT);
+				FW_OPT_UEVENT, 0);
 	module_put(THIS_MODULE);
 	return ret;
 }
@@ -852,7 +863,7 @@ int firmware_request_nowarn(const struct firmware **firmware, const char *name,
 	/* Need to pin this module until return */
 	__module_get(THIS_MODULE);
 	ret = _request_firmware(firmware, name, device, NULL, 0,
-				FW_OPT_UEVENT | FW_OPT_NO_WARN);
+				FW_OPT_UEVENT | FW_OPT_NO_WARN, 0);
 	module_put(THIS_MODULE);
 	return ret;
 }
@@ -877,7 +888,7 @@ int request_firmware_direct(const struct firmware **firmware_p,
 	__module_get(THIS_MODULE);
 	ret = _request_firmware(firmware_p, name, device, NULL, 0,
 				FW_OPT_UEVENT | FW_OPT_NO_WARN |
-				FW_OPT_NOFALLBACK_SYSFS);
+				FW_OPT_NOFALLBACK_SYSFS, 0);
 	module_put(THIS_MODULE);
 	return ret;
 }
@@ -914,6 +925,8 @@ EXPORT_SYMBOL_GPL(firmware_request_cache);
  * @device: device for which firmware is being loaded and DMA region allocated
  * @buf: address of buffer to load firmware into
  * @size: size of buffer
+ * @offset: offset into file to read
+ * @pread_flags: KERNEL_PREAD_FLAG_PART to allow partial file read
  *
  * This function works pretty much like request_firmware(), but it doesn't
  * allocate a buffer to hold the firmware data. Instead, the firmware
@@ -924,16 +937,22 @@ EXPORT_SYMBOL_GPL(firmware_request_cache);
  */
 int
 request_firmware_into_buf(const struct firmware **firmware_p, const char *name,
-			  struct device *device, void *buf, size_t size)
+			  struct device *device, void *buf, size_t size,
+			  size_t offset, unsigned int pread_flags)
 {
 	int ret;
+	enum fw_opt opt_flags;
 
 	if (fw_cache_is_setup(device, name))
 		return -EOPNOTSUPP;
 
 	__module_get(THIS_MODULE);
+	opt_flags = FW_OPT_UEVENT | FW_OPT_NOCACHE;
+	if (pread_flags & KERNEL_PREAD_FLAG_PART)
+		opt_flags |= FW_OPT_PARTIAL;
+
 	ret = _request_firmware(firmware_p, name, device, buf, size,
-				FW_OPT_UEVENT | FW_OPT_NOCACHE);
+				opt_flags, offset);
 	module_put(THIS_MODULE);
 	return ret;
 }
@@ -972,7 +991,7 @@ static void request_firmware_work_func(struct work_struct *work)
 	fw_work = container_of(work, struct firmware_work, work);
 
 	_request_firmware(&fw, fw_work->name, fw_work->device, NULL, 0,
-			  fw_work->opt_flags);
+			  fw_work->opt_flags, 0);
 	fw_work->cont(fw, fw_work->context);
 	put_device(fw_work->device); /* taken in request_firmware_nowait() */
 
diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index 24cd193dec55..00f3359f4f61 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -246,8 +246,11 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
 		} else if (phdr->p_filesz) {
 			/* Firmware not large enough, load split-out segments */
 			sprintf(fw_name + fw_name_len - 3, "b%02d", i);
-			ret = request_firmware_into_buf(&seg_fw, fw_name, dev,
-							ptr, phdr->p_filesz);
+			ret = request_firmware_into_buf
+						(&seg_fw, fw_name, dev,
+						 ptr, phdr->p_filesz,
+						 0,
+						 KERNEL_PREAD_FLAG_WHOLE);
 			if (ret) {
 				dev_err(dev, "failed to load %s\n", fw_name);
 				break;
diff --git a/include/linux/firmware.h b/include/linux/firmware.h
index 2dd566c91d44..c81162a8d709 100644
--- a/include/linux/firmware.h
+++ b/include/linux/firmware.h
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/compiler.h>
+#include <linux/fs.h>
 #include <linux/gfp.h>
 
 #define FW_ACTION_NOHOTPLUG 0
@@ -51,7 +52,9 @@ int request_firmware_nowait(
 int request_firmware_direct(const struct firmware **fw, const char *name,
 			    struct device *device);
 int request_firmware_into_buf(const struct firmware **firmware_p,
-	const char *name, struct device *device, void *buf, size_t size);
+			      const char *name, struct device *device,
+			      void *buf, size_t size,
+			      size_t offset, unsigned int pread_flags);
 
 void release_firmware(const struct firmware *fw);
 #else
@@ -89,7 +92,8 @@ static inline int request_firmware_direct(const struct firmware **fw,
 }
 
 static inline int request_firmware_into_buf(const struct firmware **firmware_p,
-	const char *name, struct device *device, void *buf, size_t size)
+	const char *name, struct device *device, void *buf, size_t size,
+	size_t offset, unsigned int pread_flags);
 {
 	return -EINVAL;
 }
diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 251213c872b5..7d1d97fa9a23 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -622,7 +622,9 @@ static int test_fw_run_batch_request(void *data)
 						    req->name,
 						    req->dev,
 						    test_buf,
-						    TEST_FIRMWARE_BUF_SIZE);
+						    TEST_FIRMWARE_BUF_SIZE,
+						    0,
+						    KERNEL_PREAD_FLAG_WHOLE);
 		if (!req->fw)
 			kfree(test_buf);
 	} else {
-- 
2.17.1

