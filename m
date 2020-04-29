Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 062761BE4D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 19:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgD2RJj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 13:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727028AbgD2RJi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 13:09:38 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08ACDC03C1AE
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2020 10:09:38 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id e6so1003448pjt.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2020 10:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=00YMMCWDMa7S3Ez/U3c50IrBaimzCN8AIvaOvv+kT9I=;
        b=XvIqEYXfhZtYhSWOttmNJMqoYq3sd87oIJ+eidE29iCFjxyZnN4RxmBEj4RTg8qfDj
         jv7+sXtIpywmnZE/7lPTK/XsdssJuYxlkxkFb5SJrvHonL0mwViF48MlWRCAASayNp8y
         WkHM0JGnII03zzmRA+lBFri8IQLrOqzamdcLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=00YMMCWDMa7S3Ez/U3c50IrBaimzCN8AIvaOvv+kT9I=;
        b=nnULMn4W8qvf84VYG7u5zEYw8TNK8I47bgVZB4uaXN7+eSQAoGDkdEYUn5ITUEcqRM
         qGq9TUiyDPC+BQMxfC67vHEf+2DF+UcdTVEG8ffLS5hvGRFNlGhZL0i6IFR3ffclOqB9
         WOwBaiz9fIhHzRh1htCZ04S+GY8ZjAMOWtwt26+dapY8KDGwQFGOvoBVQMVB7jRKzxlO
         M+0RQqR7lWETxQbmgA2dOKot4sKpRmr4kSJPcjtsrQbvLMdafhokEnwklloALZ/P+F0c
         mYkn4Lzs+14/sV43PJFmxiyqzI94LQwA1ej3abKdZP6EMl2htSrU8CgTv5G78cDJTjWP
         DsvQ==
X-Gm-Message-State: AGi0PuYuPePD6LcN81z+BPQE0w8xuF/jlWw/acrfjD5PTCCrro8IzzvG
        fjSz0EFhZGELmBlZt8AiYrH/UQ==
X-Google-Smtp-Source: APiQypJDJMUzK2nbtXJlzwpSJEoMUillujh/O+4JPQmvRNlfV582LFFvOWd4ksdClevr3Ylydl1zqA==
X-Received: by 2002:a17:902:9697:: with SMTP id n23mr7907941plp.150.1588180177470;
        Wed, 29 Apr 2020 10:09:37 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id y63sm1574456pfg.138.2020.04.29.10.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 10:09:36 -0700 (PDT)
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
Subject: [PATCH v4 2/7] firmware: add offset to request_firmware_into_buf
Date:   Wed, 29 Apr 2020 10:09:09 -0700
Message-Id: <20200429170914.30976-3-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200429170914.30976-1-scott.branden@broadcom.com>
References: <20200429170914.30976-1-scott.branden@broadcom.com>
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
 drivers/base/firmware_loader/main.c     | 52 +++++++++++++++++--------
 drivers/soc/qcom/mdt_loader.c           |  7 +++-
 include/linux/firmware.h                |  8 +++-
 lib/test_firmware.c                     |  4 +-
 5 files changed, 55 insertions(+), 21 deletions(-)

diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmware_loader/firmware.h
index 25836a6afc9f..1147dae01148 100644
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
+	unsigned int flags;
 #ifdef CONFIG_FW_LOADER_PAGED_BUF
 	bool is_paged_buf;
 	struct page **pages;
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 76f79913916d..4552b7bb819f 100644
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
@@ -495,8 +505,10 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
 		fw_priv->size = 0;
 
 		/* load firmware files from the mount namespace of init */
-		rc = kernel_read_file_from_path_initns(path, &buffer,
-						       &size, msize, id);
+		rc = kernel_pread_file_from_path_initns(path, &buffer,
+							&size, fw_priv->offset,
+							msize,
+							fw_priv->flags, id);
 		if (rc) {
 			if (rc != -ENOENT)
 				dev_warn(device, "loading %s failed with error %d\n",
@@ -687,7 +699,7 @@ int assign_fw(struct firmware *fw, struct device *device,
 static int
 _request_firmware_prepare(struct firmware **firmware_p, const char *name,
 			  struct device *device, void *dbuf, size_t size,
-			  enum fw_opt opt_flags)
+			  enum fw_opt opt_flags, size_t offset)
 {
 	struct firmware *firmware;
 	struct fw_priv *fw_priv;
@@ -706,7 +718,7 @@ _request_firmware_prepare(struct firmware **firmware_p, const char *name,
 	}
 
 	ret = alloc_lookup_fw_priv(name, &fw_cache, &fw_priv, dbuf, size,
-				  opt_flags);
+				   opt_flags, offset);
 
 	/*
 	 * bind with 'priv' now to avoid warning in failure path
@@ -753,7 +765,7 @@ static void fw_abort_batch_reqs(struct firmware *fw)
 static int
 _request_firmware(const struct firmware **firmware_p, const char *name,
 		  struct device *device, void *buf, size_t size,
-		  enum fw_opt opt_flags)
+		  enum fw_opt opt_flags, size_t offset)
 {
 	struct firmware *fw = NULL;
 	int ret;
@@ -767,7 +779,7 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
 	}
 
 	ret = _request_firmware_prepare(&fw, name, device, buf, size,
-					opt_flags);
+					opt_flags, offset);
 	if (ret <= 0) /* error or already assigned */
 		goto out;
 
@@ -830,7 +842,7 @@ request_firmware(const struct firmware **firmware_p, const char *name,
 	/* Need to pin this module until return */
 	__module_get(THIS_MODULE);
 	ret = _request_firmware(firmware_p, name, device, NULL, 0,
-				FW_OPT_UEVENT);
+				FW_OPT_UEVENT, 0);
 	module_put(THIS_MODULE);
 	return ret;
 }
@@ -857,7 +869,7 @@ int firmware_request_nowarn(const struct firmware **firmware, const char *name,
 	/* Need to pin this module until return */
 	__module_get(THIS_MODULE);
 	ret = _request_firmware(firmware, name, device, NULL, 0,
-				FW_OPT_UEVENT | FW_OPT_NO_WARN);
+				FW_OPT_UEVENT | FW_OPT_NO_WARN, 0);
 	module_put(THIS_MODULE);
 	return ret;
 }
@@ -882,7 +894,7 @@ int request_firmware_direct(const struct firmware **firmware_p,
 	__module_get(THIS_MODULE);
 	ret = _request_firmware(firmware_p, name, device, NULL, 0,
 				FW_OPT_UEVENT | FW_OPT_NO_WARN |
-				FW_OPT_NOFALLBACK_SYSFS);
+				FW_OPT_NOFALLBACK_SYSFS, 0);
 	module_put(THIS_MODULE);
 	return ret;
 }
@@ -906,7 +918,7 @@ int firmware_request_platform(const struct firmware **firmware,
 	/* Need to pin this module until return */
 	__module_get(THIS_MODULE);
 	ret = _request_firmware(firmware, name, device, NULL, 0,
-				FW_OPT_UEVENT | FW_OPT_FALLBACK_PLATFORM);
+				FW_OPT_UEVENT | FW_OPT_FALLBACK_PLATFORM, 0);
 	module_put(THIS_MODULE);
 	return ret;
 }
@@ -943,6 +955,8 @@ EXPORT_SYMBOL_GPL(firmware_request_cache);
  * @device: device for which firmware is being loaded and DMA region allocated
  * @buf: address of buffer to load firmware into
  * @size: size of buffer
+ * @offset: offset into file to read
+ * @pread_flags: KERNEL_PREAD_FLAG_PART to allow partial file read
  *
  * This function works pretty much like request_firmware(), but it doesn't
  * allocate a buffer to hold the firmware data. Instead, the firmware
@@ -953,16 +967,22 @@ EXPORT_SYMBOL_GPL(firmware_request_cache);
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
@@ -1001,7 +1021,7 @@ static void request_firmware_work_func(struct work_struct *work)
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
index 4bbd0afd91b7..b98d17fb3bd1 100644
--- a/include/linux/firmware.h
+++ b/include/linux/firmware.h
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/compiler.h>
+#include <linux/fs.h>
 #include <linux/gfp.h>
 
 #define FW_ACTION_NOHOTPLUG 0
@@ -53,7 +54,9 @@ int request_firmware_nowait(
 int request_firmware_direct(const struct firmware **fw, const char *name,
 			    struct device *device);
 int request_firmware_into_buf(const struct firmware **firmware_p,
-	const char *name, struct device *device, void *buf, size_t size);
+			      const char *name, struct device *device,
+			      void *buf, size_t size,
+			      size_t offset, unsigned int pread_flags);
 
 void release_firmware(const struct firmware *fw);
 #else
@@ -98,7 +101,8 @@ static inline int request_firmware_direct(const struct firmware **fw,
 }
 
 static inline int request_firmware_into_buf(const struct firmware **firmware_p,
-	const char *name, struct device *device, void *buf, size_t size)
+	const char *name, struct device *device, void *buf, size_t size,
+	size_t offset, unsigned int pread_flags)
 {
 	return -EINVAL;
 }
diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 9fee2b93a8d1..55176b0a8318 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -654,7 +654,9 @@ static int test_fw_run_batch_request(void *data)
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

