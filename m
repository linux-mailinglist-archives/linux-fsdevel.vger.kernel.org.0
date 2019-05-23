Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5F7427497
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 04:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729957AbfEWCvb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 May 2019 22:51:31 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43473 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729940AbfEWCva (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 May 2019 22:51:30 -0400
Received: by mail-pf1-f195.google.com with SMTP id c6so2369029pfa.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2019 19:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a33B5dVFl//CSD5xiGq7X/EJU3E2AsKeoUUI/bbtEUY=;
        b=c5L/nVAUSsb3g6K0q+ocBSa9AuR0Rxv0bLa770FXdXIJQKQhmBGX7rkRMR1iKpR7jY
         ZQtx4T/5mIhzVlfWDCXt81//ZaS5RTn6WytDog6uc1jv2laQyQ8ePMbdT29U4x/GCriO
         ih7i1WpaVpTXVGoIiJA85PeiMcnkambuJJznU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a33B5dVFl//CSD5xiGq7X/EJU3E2AsKeoUUI/bbtEUY=;
        b=hqMnPQIo6ZrutfOZquiQrewzu+ZFRk9HTN368V8uXz749TM2prNACbD5YEq2Ain/20
         2ZlGaIK+QHVMQWI8jMiNl38Qmvnr3B83masUS0Z/ouOaVoP5Ddst+jRHTGU5hRCdPNJF
         2KfeKbNfbjz1y/nR1jPtEyIYbJhvBH2TxJiRiiCrQX4DQOtNhymQdPId0KT5ARz2WbDu
         IwFjNNyAPyZbGQvm0E7cwHCcefkBUvHtJ6E6aXEjLc+0ajmJqedPTJBbXs73gRj9nlXi
         qb3p9pMlhpqAhlARzVnR5zDJDu5G3SPc1eswjQMMvcbOYnnyYFD6j+ERuROCNIO1vLKo
         j9/A==
X-Gm-Message-State: APjAAAUzEQbHE/NEcX3r+Q8W/yNM5Z7GD+QGz5Gw8lYjxeX1nppyF2is
        MDUYoHEwH+Itdxns0sbg5iCuvw==
X-Google-Smtp-Source: APXvYqydUdE9J++ceqvklk2kh9zBacE72tt9HkYrMkcC8NoVLRmfubWzxyopkOnMq12DfOKPZ08/pQ==
X-Received: by 2002:a63:d949:: with SMTP id e9mr6375335pgj.437.1558579889730;
        Wed, 22 May 2019 19:51:29 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id q19sm42812174pff.96.2019.05.22.19.51.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 19:51:29 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH 2/3] firmware: add offset to request_firmware_into_buf
Date:   Wed, 22 May 2019 19:51:12 -0700
Message-Id: <20190523025113.4605-3-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190523025113.4605-1-scott.branden@broadcom.com>
References: <20190523025113.4605-1-scott.branden@broadcom.com>
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
 include/linux/firmware.h                |  8 +++-
 3 files changed, 45 insertions(+), 17 deletions(-)

diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmware_loader/firmware.h
index 4c1395f8e7ed..d73d400c2023 100644
--- a/drivers/base/firmware_loader/firmware.h
+++ b/drivers/base/firmware_loader/firmware.h
@@ -29,6 +29,8 @@
  *	firmware caching mechanism.
  * @FW_OPT_NOFALLBACK: Disable the fallback mechanism. Takes precedence over
  *	&FW_OPT_UEVENT and &FW_OPT_USERHELPER.
+ * @FW_OPT_PARTIAL: Allow partial read of firmware instead of needing to read
+ *	entire file.
  */
 enum fw_opt {
 	FW_OPT_UEVENT =         BIT(0),
@@ -37,6 +39,7 @@ enum fw_opt {
 	FW_OPT_NO_WARN =        BIT(3),
 	FW_OPT_NOCACHE =        BIT(4),
 	FW_OPT_NOFALLBACK =     BIT(5),
+	FW_OPT_PARTIAL =        BIT(6),
 };
 
 enum fw_status {
@@ -64,6 +67,8 @@ struct fw_priv {
 	void *data;
 	size_t size;
 	size_t allocated_size;
+	size_t offset;
+	unsigned int flags;
 #ifdef CONFIG_FW_LOADER_USER_HELPER
 	bool is_paged_buf;
 	bool need_uevent;
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 7eaaf5ee5ba6..34d4f043b7c8 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -166,7 +166,8 @@ static int fw_cache_piggyback_on_request(const char *name);
 
 static struct fw_priv *__allocate_fw_priv(const char *fw_name,
 					  struct firmware_cache *fwc,
-					  void *dbuf, size_t size)
+					  void *dbuf, size_t size,
+					  size_t offset, unsigned int flags)
 {
 	struct fw_priv *fw_priv;
 
@@ -184,6 +185,8 @@ static struct fw_priv *__allocate_fw_priv(const char *fw_name,
 	fw_priv->fwc = fwc;
 	fw_priv->data = dbuf;
 	fw_priv->allocated_size = size;
+	fw_priv->offset = offset;
+	fw_priv->flags = flags;
 	fw_state_init(fw_priv);
 #ifdef CONFIG_FW_LOADER_USER_HELPER
 	INIT_LIST_HEAD(&fw_priv->pending_list);
@@ -209,9 +212,11 @@ static struct fw_priv *__lookup_fw_priv(const char *fw_name)
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
@@ -225,7 +230,12 @@ static int alloc_lookup_fw_priv(const char *fw_name,
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
@@ -325,8 +335,9 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv)
 		}
 
 		fw_priv->size = 0;
-		rc = kernel_read_file_from_path(path, &fw_priv->data, &size,
-						msize, id);
+		rc = kernel_pread_file_from_path(path, &fw_priv->data, &size,
+						 fw_priv->offset, msize,
+						 fw_priv->flags, id);
 		if (rc) {
 			if (rc != -ENOENT)
 				dev_warn(device, "loading %s failed with error %d\n",
@@ -500,7 +511,7 @@ int assign_fw(struct firmware *fw, struct device *device,
 static int
 _request_firmware_prepare(struct firmware **firmware_p, const char *name,
 			  struct device *device, void *dbuf, size_t size,
-			  enum fw_opt opt_flags)
+			  enum fw_opt opt_flags, size_t offset)
 {
 	struct firmware *firmware;
 	struct fw_priv *fw_priv;
@@ -519,7 +530,7 @@ _request_firmware_prepare(struct firmware **firmware_p, const char *name,
 	}
 
 	ret = alloc_lookup_fw_priv(name, &fw_cache, &fw_priv, dbuf, size,
-				  opt_flags);
+				  opt_flags, offset);
 
 	/*
 	 * bind with 'priv' now to avoid warning in failure path
@@ -566,7 +577,7 @@ static void fw_abort_batch_reqs(struct firmware *fw)
 static int
 _request_firmware(const struct firmware **firmware_p, const char *name,
 		  struct device *device, void *buf, size_t size,
-		  enum fw_opt opt_flags)
+		  enum fw_opt opt_flags, size_t offset)
 {
 	struct firmware *fw = NULL;
 	int ret;
@@ -580,7 +591,7 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
 	}
 
 	ret = _request_firmware_prepare(&fw, name, device, buf, size,
-					opt_flags);
+					opt_flags, offset);
 	if (ret <= 0) /* error or already assigned */
 		goto out;
 
@@ -634,7 +645,7 @@ request_firmware(const struct firmware **firmware_p, const char *name,
 	/* Need to pin this module until return */
 	__module_get(THIS_MODULE);
 	ret = _request_firmware(firmware_p, name, device, NULL, 0,
-				FW_OPT_UEVENT);
+				FW_OPT_UEVENT, 0);
 	module_put(THIS_MODULE);
 	return ret;
 }
@@ -661,7 +672,7 @@ int firmware_request_nowarn(const struct firmware **firmware, const char *name,
 	/* Need to pin this module until return */
 	__module_get(THIS_MODULE);
 	ret = _request_firmware(firmware, name, device, NULL, 0,
-				FW_OPT_UEVENT | FW_OPT_NO_WARN);
+				FW_OPT_UEVENT | FW_OPT_NO_WARN, 0);
 	module_put(THIS_MODULE);
 	return ret;
 }
@@ -686,7 +697,7 @@ int request_firmware_direct(const struct firmware **firmware_p,
 	__module_get(THIS_MODULE);
 	ret = _request_firmware(firmware_p, name, device, NULL, 0,
 				FW_OPT_UEVENT | FW_OPT_NO_WARN |
-				FW_OPT_NOFALLBACK);
+				FW_OPT_NOFALLBACK, 0);
 	module_put(THIS_MODULE);
 	return ret;
 }
@@ -723,6 +734,8 @@ EXPORT_SYMBOL_GPL(firmware_request_cache);
  * @device: device for which firmware is being loaded and DMA region allocated
  * @buf: address of buffer to load firmware into
  * @size: size of buffer
+ * @offset: offset into file to read
+ * @pread_flags: KERNEL_PREAD_FLAG_PART to allow partial file read
  *
  * This function works pretty much like request_firmware(), but it doesn't
  * allocate a buffer to hold the firmware data. Instead, the firmware
@@ -733,16 +746,22 @@ EXPORT_SYMBOL_GPL(firmware_request_cache);
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
@@ -781,7 +800,7 @@ static void request_firmware_work_func(struct work_struct *work)
 	fw_work = container_of(work, struct firmware_work, work);
 
 	_request_firmware(&fw, fw_work->name, fw_work->device, NULL, 0,
-			  fw_work->opt_flags);
+			  fw_work->opt_flags, 0);
 	fw_work->cont(fw, fw_work->context);
 	put_device(fw_work->device); /* taken in request_firmware_nowait() */
 
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
-- 
2.17.1

