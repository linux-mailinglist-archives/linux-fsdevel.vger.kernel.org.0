Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD331F0519
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jun 2020 07:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgFFFGK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Jun 2020 01:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbgFFFGK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Jun 2020 01:06:10 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDB8C08C5C5
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2020 22:06:10 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id n2so4491167pld.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2020 22:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bdtRQGHvrSh00xAdLmeIZIxqVgqyFJLwGvwbUofZsyI=;
        b=hRNMavVIIz7Nz5FCC7D0doinbL+qSuf+g8oM8AYtZuNvfzUgkbqNDu5/keAt0FJdEr
         E26j3S/5jw+rHGhEL/5S3kuKGg0vPWlywvUlzps52jkAvsVgqd5qeuQ6/OZsccv7RuOb
         ReS22+wAZrf+MIvtZyO9HzcoBO0WADDzHn2Wc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bdtRQGHvrSh00xAdLmeIZIxqVgqyFJLwGvwbUofZsyI=;
        b=PdZTnpzTKp6KsKdVRxpvUZZbbW6VABqq4EGQaeoq4WvGcE2rbPkalGc44vwp2G+fPD
         BkWe77SCcUG4oHNjq9fun15+DVPip0VpcWlGZ0kC6DztdC0CvQ77qZfX75nrzGYO3f+1
         IlgpkQ6lT7FuSBcCphO67ziLdKto8HT+bGxpLznJlT0kDboSVxfximrCBzRmGWwud5R1
         mGl7h0xrrsLOwbYNevEa5U7mO+5Yl/EhnBKtZSCFuMM4p01Xhab+CeOk8XE6/RtffT67
         tqbEfj3t8Dcf/6OuLz7ZaSBI4MeXlrc5290WDO6oM9Z0zfZljKMrGI14YC34nlPTs8JW
         V5UQ==
X-Gm-Message-State: AOAM532ScmtdkZsLOesirHOuhFN/Lq19yzaiHN3ga94vEJpIt8fcCR9J
        ah7iGA+vw20xQk5OI+3NYQWAog==
X-Google-Smtp-Source: ABdhPJyxk9KNmpg/sdIP0QiyOx+hEkhoA2gekodMaxTgGIB7TZ5cYAF8+qmm4h3i5+wdqRVLj30tsA==
X-Received: by 2002:a17:902:b7c9:: with SMTP id v9mr12861061plz.34.1591419969389;
        Fri, 05 Jun 2020 22:06:09 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id v8sm1057636pfn.217.2020.06.05.22.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 22:06:08 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
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
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v7 2/8] firmware: add offset to request_firmware_into_buf
Date:   Fri,  5 Jun 2020 22:04:52 -0700
Message-Id: <20200606050458.17281-3-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200606050458.17281-1-scott.branden@broadcom.com>
References: <20200606050458.17281-1-scott.branden@broadcom.com>
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
 drivers/base/firmware_loader/main.c     | 53 +++++++++++++++++--------
 drivers/i2c/i2c-slave-eeprom.c          |  4 +-
 drivers/soc/qcom/mdt_loader.c           |  7 +++-
 include/linux/firmware.h                |  8 +++-
 lib/test_firmware.c                     |  4 +-
 6 files changed, 59 insertions(+), 22 deletions(-)

diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmware_loader/firmware.h
index 933e2192fbe8..c9b6ba8d29d8 100644
--- a/drivers/base/firmware_loader/firmware.h
+++ b/drivers/base/firmware_loader/firmware.h
@@ -32,6 +32,8 @@
  * @FW_OPT_FALLBACK_PLATFORM: Enable fallback to device fw copy embedded in
  *	the platform's main firmware. If both this fallback and the sysfs
  *      fallback are enabled, then this fallback will be tried first.
+ * @FW_OPT_PARTIAL: Allow partial read of firmware instead of needing to read
+ *	entire file.
  */
 enum fw_opt {
 	FW_OPT_UEVENT			= BIT(0),
@@ -41,6 +43,7 @@ enum fw_opt {
 	FW_OPT_NOCACHE			= BIT(4),
 	FW_OPT_NOFALLBACK_SYSFS		= BIT(5),
 	FW_OPT_FALLBACK_PLATFORM	= BIT(6),
+	FW_OPT_PARTIAL			= BIT(7),
 };
 
 enum fw_status {
@@ -68,6 +71,8 @@ struct fw_priv {
 	void *data;
 	size_t size;
 	size_t allocated_size;
+	size_t offset;
+	enum kernel_pread_opt opt;
 #ifdef CONFIG_FW_LOADER_PAGED_BUF
 	bool is_paged_buf;
 	struct page **pages;
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index ca871b13524e..93e7fee42cd4 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -167,7 +167,9 @@ static int fw_cache_piggyback_on_request(const char *name);
 
 static struct fw_priv *__allocate_fw_priv(const char *fw_name,
 					  struct firmware_cache *fwc,
-					  void *dbuf, size_t size)
+					  void *dbuf, size_t size,
+					  size_t offset,
+					  enum kernel_pread_opt opt)
 {
 	struct fw_priv *fw_priv;
 
@@ -185,6 +187,8 @@ static struct fw_priv *__allocate_fw_priv(const char *fw_name,
 	fw_priv->fwc = fwc;
 	fw_priv->data = dbuf;
 	fw_priv->allocated_size = size;
+	fw_priv->offset = offset;
+	fw_priv->opt = opt;
 	fw_state_init(fw_priv);
 #ifdef CONFIG_FW_LOADER_USER_HELPER
 	INIT_LIST_HEAD(&fw_priv->pending_list);
@@ -210,9 +214,11 @@ static struct fw_priv *__lookup_fw_priv(const char *fw_name)
 static int alloc_lookup_fw_priv(const char *fw_name,
 				struct firmware_cache *fwc,
 				struct fw_priv **fw_priv, void *dbuf,
-				size_t size, u32 opt_flags)
+				size_t size, u32 opt_flags,
+				size_t offset)
 {
 	struct fw_priv *tmp;
+	enum kernel_pread_opt pread_opt;
 
 	spin_lock(&fwc->lock);
 	if (!(opt_flags & FW_OPT_NOCACHE)) {
@@ -226,7 +232,12 @@ static int alloc_lookup_fw_priv(const char *fw_name,
 		}
 	}
 
-	tmp = __allocate_fw_priv(fw_name, fwc, dbuf, size);
+	if (opt_flags & FW_OPT_PARTIAL)
+		pread_opt = KERNEL_PREAD_PART;
+	else
+		pread_opt = KERNEL_PREAD_WHOLE;
+
+	tmp = __allocate_fw_priv(fw_name, fwc, dbuf, size, offset, pread_opt);
 	if (tmp) {
 		INIT_LIST_HEAD(&tmp->list);
 		if (!(opt_flags & FW_OPT_NOCACHE))
@@ -495,8 +506,10 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
 		fw_priv->size = 0;
 
 		/* load firmware files from the mount namespace of init */
-		rc = kernel_read_file_from_path_initns(path, &buffer,
-						       &size, msize, id);
+		rc = kernel_pread_file_from_path_initns(path, &buffer,
+							&size, fw_priv->offset,
+							msize,
+							fw_priv->opt, id);
 		if (rc) {
 			if (rc != -ENOENT)
 				dev_warn(device, "loading %s failed with error %d\n",
@@ -683,7 +696,7 @@ int assign_fw(struct firmware *fw, struct device *device, u32 opt_flags)
 static int
 _request_firmware_prepare(struct firmware **firmware_p, const char *name,
 			  struct device *device, void *dbuf, size_t size,
-			  u32 opt_flags)
+			  u32 opt_flags, size_t offset)
 {
 	struct firmware *firmware;
 	struct fw_priv *fw_priv;
@@ -702,7 +715,7 @@ _request_firmware_prepare(struct firmware **firmware_p, const char *name,
 	}
 
 	ret = alloc_lookup_fw_priv(name, &fw_cache, &fw_priv, dbuf, size,
-				  opt_flags);
+				   opt_flags, offset);
 
 	/*
 	 * bind with 'priv' now to avoid warning in failure path
@@ -749,7 +762,7 @@ static void fw_abort_batch_reqs(struct firmware *fw)
 static int
 _request_firmware(const struct firmware **firmware_p, const char *name,
 		  struct device *device, void *buf, size_t size,
-		  u32 opt_flags)
+		  u32 opt_flags, size_t offset)
 {
 	struct firmware *fw = NULL;
 	int ret;
@@ -763,7 +776,7 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
 	}
 
 	ret = _request_firmware_prepare(&fw, name, device, buf, size,
-					opt_flags);
+					opt_flags, offset);
 	if (ret <= 0) /* error or already assigned */
 		goto out;
 
@@ -826,7 +839,7 @@ request_firmware(const struct firmware **firmware_p, const char *name,
 	/* Need to pin this module until return */
 	__module_get(THIS_MODULE);
 	ret = _request_firmware(firmware_p, name, device, NULL, 0,
-				FW_OPT_UEVENT);
+				FW_OPT_UEVENT, 0);
 	module_put(THIS_MODULE);
 	return ret;
 }
@@ -853,7 +866,7 @@ int firmware_request_nowarn(const struct firmware **firmware, const char *name,
 	/* Need to pin this module until return */
 	__module_get(THIS_MODULE);
 	ret = _request_firmware(firmware, name, device, NULL, 0,
-				FW_OPT_UEVENT | FW_OPT_NO_WARN);
+				FW_OPT_UEVENT | FW_OPT_NO_WARN, 0);
 	module_put(THIS_MODULE);
 	return ret;
 }
@@ -878,7 +891,7 @@ int request_firmware_direct(const struct firmware **firmware_p,
 	__module_get(THIS_MODULE);
 	ret = _request_firmware(firmware_p, name, device, NULL, 0,
 				FW_OPT_UEVENT | FW_OPT_NO_WARN |
-				FW_OPT_NOFALLBACK_SYSFS);
+				FW_OPT_NOFALLBACK_SYSFS, 0);
 	module_put(THIS_MODULE);
 	return ret;
 }
@@ -902,7 +915,7 @@ int firmware_request_platform(const struct firmware **firmware,
 	/* Need to pin this module until return */
 	__module_get(THIS_MODULE);
 	ret = _request_firmware(firmware, name, device, NULL, 0,
-				FW_OPT_UEVENT | FW_OPT_FALLBACK_PLATFORM);
+				FW_OPT_UEVENT | FW_OPT_FALLBACK_PLATFORM, 0);
 	module_put(THIS_MODULE);
 	return ret;
 }
@@ -939,6 +952,8 @@ EXPORT_SYMBOL_GPL(firmware_request_cache);
  * @device: device for which firmware is being loaded and DMA region allocated
  * @buf: address of buffer to load firmware into
  * @size: size of buffer
+ * @offset: offset into file to read
+ * @pread_opt: KERNEL_PREAD_PART to allow partial file read
  *
  * This function works pretty much like request_firmware(), but it doesn't
  * allocate a buffer to hold the firmware data. Instead, the firmware
@@ -949,16 +964,22 @@ EXPORT_SYMBOL_GPL(firmware_request_cache);
  */
 int
 request_firmware_into_buf(const struct firmware **firmware_p, const char *name,
-			  struct device *device, void *buf, size_t size)
+			  struct device *device, void *buf, size_t size,
+			  size_t offset, enum kernel_pread_opt pread_opt)
 {
 	int ret;
+	u32 opt_flags;
 
 	if (fw_cache_is_setup(device, name))
 		return -EOPNOTSUPP;
 
 	__module_get(THIS_MODULE);
+	opt_flags = FW_OPT_UEVENT | FW_OPT_NOCACHE;
+	if (pread_opt == KERNEL_PREAD_PART)
+		opt_flags |= FW_OPT_PARTIAL;
+
 	ret = _request_firmware(firmware_p, name, device, buf, size,
-				FW_OPT_UEVENT | FW_OPT_NOCACHE);
+				opt_flags, offset);
 	module_put(THIS_MODULE);
 	return ret;
 }
@@ -997,7 +1018,7 @@ static void request_firmware_work_func(struct work_struct *work)
 	fw_work = container_of(work, struct firmware_work, work);
 
 	_request_firmware(&fw, fw_work->name, fw_work->device, NULL, 0,
-			  fw_work->opt_flags);
+			  fw_work->opt_flags, 0);
 	fw_work->cont(fw, fw_work->context);
 	put_device(fw_work->device); /* taken in request_firmware_nowait() */
 
diff --git a/drivers/i2c/i2c-slave-eeprom.c b/drivers/i2c/i2c-slave-eeprom.c
index 593f2fd39d17..facc5dff218f 100644
--- a/drivers/i2c/i2c-slave-eeprom.c
+++ b/drivers/i2c/i2c-slave-eeprom.c
@@ -129,7 +129,9 @@ static int i2c_slave_init_eeprom_data(struct eeprom_data *eeprom, struct i2c_cli
 
 	if (!ret) {
 		ret = request_firmware_into_buf(&fw, eeprom_data, &client->dev,
-						eeprom->buffer, size);
+						eeprom->buffer, size,
+						0,
+						KERNEL_PREAD_WHOLE);
 		if (ret)
 			return ret;
 		release_firmware(fw);
diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index 24cd193dec55..c9490c15da68 100644
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
+						 KERNEL_PREAD_WHOLE);
 			if (ret) {
 				dev_err(dev, "failed to load %s\n", fw_name);
 				break;
diff --git a/include/linux/firmware.h b/include/linux/firmware.h
index cb3e2c06ed8a..a53a854294e2 100644
--- a/include/linux/firmware.h
+++ b/include/linux/firmware.h
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/compiler.h>
+#include <linux/fs.h>
 #include <linux/gfp.h>
 
 #define FW_ACTION_NOHOTPLUG 0
@@ -52,7 +53,9 @@ int request_firmware_nowait(
 int request_firmware_direct(const struct firmware **fw, const char *name,
 			    struct device *device);
 int request_firmware_into_buf(const struct firmware **firmware_p,
-	const char *name, struct device *device, void *buf, size_t size);
+			      const char *name, struct device *device,
+			      void *buf, size_t size,
+			      size_t offset, enum kernel_pread_opt opt);
 
 void release_firmware(const struct firmware *fw);
 #else
@@ -97,7 +100,8 @@ static inline int request_firmware_direct(const struct firmware **fw,
 }
 
 static inline int request_firmware_into_buf(const struct firmware **firmware_p,
-	const char *name, struct device *device, void *buf, size_t size)
+	const char *name, struct device *device, void *buf, size_t size,
+	size_t offset, enum kernel_pread_opt opt)
 {
 	return -EINVAL;
 }
diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 9fee2b93a8d1..af747660fe29 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -654,7 +654,9 @@ static int test_fw_run_batch_request(void *data)
 						    req->name,
 						    req->dev,
 						    test_buf,
-						    TEST_FIRMWARE_BUF_SIZE);
+						    TEST_FIRMWARE_BUF_SIZE,
+						    0,
+						    KERNEL_PREAD_WHOLE);
 		if (!req->fw)
 			kfree(test_buf);
 	} else {
-- 
2.17.1

