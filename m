Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F141DF2C5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 May 2020 01:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731161AbgEVXM1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 May 2020 19:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731163AbgEVXMZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 May 2020 19:12:25 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E890C08C5C0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 16:12:25 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id n18so5888866pfa.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 16:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=z6aQFoiGEpQXdDjyCS+j9sTsZn2fNsE4BnMRV9DRgrU=;
        b=ePsHrOazMItOER3zR8QN/yANIr1uyVLIlkCErL8PmLzd20C3RFZZLdh8Rf4pnOidQ0
         Hlxj0HEfZWFB0ITcZDzsAuYf8h7sWkEFIPlBr+DllHPbz3AHZuXsNwjy64giBGuyD68s
         pcNv9MhYC0XJ7P7GrIFIo+YIP1/nzTqtfUa4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=z6aQFoiGEpQXdDjyCS+j9sTsZn2fNsE4BnMRV9DRgrU=;
        b=GqF9EK+WYBAlCVnxmMuIwiTi92j6ps+J4mSbosbMza9aaZ0pjcARYZgOUDPJOFwo1O
         uYAlUrJxalNDEraSk+OP1HHJCftHhbI7+NbWQfmqunrF/3So/zWs71x6xSvyKd/IXmZC
         6rkyD/5r5PKhMB5HgahwBXqdlICcuc8s9OzBwWbViVrRFdFUO5oxsLZle7yx6LdKpc/J
         IYwKBBZ347BsmZePy7RaLKi2iLSxA47j4qJX4vLliQ83jsyluKqEM156c4Wn9RyvPxHk
         QL+9VHdvpxToK44S52qKMxwCuocS9yUx+XqInu9oH3qV1ATEYZSCsbtbCC7+q+TsV3Wi
         lrqg==
X-Gm-Message-State: AOAM532qaKvSXLtqrk3J+41sUPd7XSa+JQhtqwYRnrlUci2pIoWLBY7H
        RyWIK3Mk0RBz9B5FyfKH/tu4MA==
X-Google-Smtp-Source: ABdhPJxbhnGYMbebANFJZbps6Qbs6bcRF0/4tlksxMBeGGhwnQVbRr/y0IYkJlIeEaccN+35ejhjFg==
X-Received: by 2002:a65:498f:: with SMTP id r15mr15827831pgs.345.1590189144505;
        Fri, 22 May 2020 16:12:24 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id q12sm6815178pfn.129.2020.05.22.16.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 16:12:23 -0700 (PDT)
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
Subject: [PATCH v2] firmware_loader: change enum fw_opt to u32
Date:   Fri, 22 May 2020 16:12:02 -0700
Message-Id: <20200522231202.13681-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"enum fw_opt" is not used as an enum.
Change fw_opt to u32 as FW_OPT_* values are OR'd together.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/base/firmware_loader/fallback.c          | 12 ++++++------
 drivers/base/firmware_loader/fallback.h          |  8 ++++----
 drivers/base/firmware_loader/fallback_platform.c |  2 +-
 drivers/base/firmware_loader/firmware.h          |  3 +--
 drivers/base/firmware_loader/main.c              | 11 +++++------
 5 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index 1e9c96e3ed63..af1aa3d69920 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -460,7 +460,7 @@ static const struct attribute_group *fw_dev_attr_groups[] = {
 
 static struct fw_sysfs *
 fw_create_instance(struct firmware *firmware, const char *fw_name,
-		   struct device *device, enum fw_opt opt_flags)
+		   struct device *device, u32 opt_flags)
 {
 	struct fw_sysfs *fw_sysfs;
 	struct device *f_dev;
@@ -493,7 +493,7 @@ fw_create_instance(struct firmware *firmware, const char *fw_name,
  * In charge of constructing a sysfs fallback interface for firmware loading.
  **/
 static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs,
-				  enum fw_opt opt_flags, long timeout)
+				  u32 opt_flags, long timeout)
 {
 	int retval = 0;
 	struct device *f_dev = &fw_sysfs->dev;
@@ -547,7 +547,7 @@ static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs,
 
 static int fw_load_from_user_helper(struct firmware *firmware,
 				    const char *name, struct device *device,
-				    enum fw_opt opt_flags)
+				    u32 opt_flags)
 {
 	struct fw_sysfs *fw_sysfs;
 	long timeout;
@@ -588,7 +588,7 @@ static int fw_load_from_user_helper(struct firmware *firmware,
 	return ret;
 }
 
-static bool fw_force_sysfs_fallback(enum fw_opt opt_flags)
+static bool fw_force_sysfs_fallback(u32 opt_flags)
 {
 	if (fw_fallback_config.force_sysfs_fallback)
 		return true;
@@ -597,7 +597,7 @@ static bool fw_force_sysfs_fallback(enum fw_opt opt_flags)
 	return true;
 }
 
-static bool fw_run_sysfs_fallback(enum fw_opt opt_flags)
+static bool fw_run_sysfs_fallback(u32 opt_flags)
 {
 	int ret;
 
@@ -640,7 +640,7 @@ static bool fw_run_sysfs_fallback(enum fw_opt opt_flags)
  **/
 int firmware_fallback_sysfs(struct firmware *fw, const char *name,
 			    struct device *device,
-			    enum fw_opt opt_flags,
+			    u32 opt_flags,
 			    int ret)
 {
 	if (!fw_run_sysfs_fallback(opt_flags))
diff --git a/drivers/base/firmware_loader/fallback.h b/drivers/base/firmware_loader/fallback.h
index 06f4577733a8..2afdb6adb23f 100644
--- a/drivers/base/firmware_loader/fallback.h
+++ b/drivers/base/firmware_loader/fallback.h
@@ -33,7 +33,7 @@ struct firmware_fallback_config {
 #ifdef CONFIG_FW_LOADER_USER_HELPER
 int firmware_fallback_sysfs(struct firmware *fw, const char *name,
 			    struct device *device,
-			    enum fw_opt opt_flags,
+			    u32 opt_flags,
 			    int ret);
 void kill_pending_fw_fallback_reqs(bool only_kill_custom);
 
@@ -45,7 +45,7 @@ void unregister_sysfs_loader(void);
 #else /* CONFIG_FW_LOADER_USER_HELPER */
 static inline int firmware_fallback_sysfs(struct firmware *fw, const char *name,
 					  struct device *device,
-					  enum fw_opt opt_flags,
+					  u32 opt_flags,
 					  int ret)
 {
 	/* Keep carrying over the same error */
@@ -67,10 +67,10 @@ static inline void unregister_sysfs_loader(void)
 #endif /* CONFIG_FW_LOADER_USER_HELPER */
 
 #ifdef CONFIG_EFI_EMBEDDED_FIRMWARE
-int firmware_fallback_platform(struct fw_priv *fw_priv, enum fw_opt opt_flags);
+int firmware_fallback_platform(struct fw_priv *fw_priv, u32 opt_flags);
 #else
 static inline int firmware_fallback_platform(struct fw_priv *fw_priv,
-					     enum fw_opt opt_flags)
+					     u32 opt_flags)
 {
 	return -ENOENT;
 }
diff --git a/drivers/base/firmware_loader/fallback_platform.c b/drivers/base/firmware_loader/fallback_platform.c
index c88c745590fe..cdd2c9a9f38a 100644
--- a/drivers/base/firmware_loader/fallback_platform.c
+++ b/drivers/base/firmware_loader/fallback_platform.c
@@ -8,7 +8,7 @@
 #include "fallback.h"
 #include "firmware.h"
 
-int firmware_fallback_platform(struct fw_priv *fw_priv, enum fw_opt opt_flags)
+int firmware_fallback_platform(struct fw_priv *fw_priv, u32 opt_flags)
 {
 	const u8 *data;
 	size_t size;
diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmware_loader/firmware.h
index 25836a6afc9f..933e2192fbe8 100644
--- a/drivers/base/firmware_loader/firmware.h
+++ b/drivers/base/firmware_loader/firmware.h
@@ -136,8 +136,7 @@ static inline void fw_state_done(struct fw_priv *fw_priv)
 	__fw_state_set(fw_priv, FW_STATUS_DONE);
 }
 
-int assign_fw(struct firmware *fw, struct device *device,
-	      enum fw_opt opt_flags);
+int assign_fw(struct firmware *fw, struct device *device, u32 opt_flags);
 
 #ifdef CONFIG_FW_LOADER_PAGED_BUF
 void fw_free_paged_buf(struct fw_priv *fw_priv);
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 76f79913916d..2ca6b4735979 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -210,7 +210,7 @@ static struct fw_priv *__lookup_fw_priv(const char *fw_name)
 static int alloc_lookup_fw_priv(const char *fw_name,
 				struct firmware_cache *fwc,
 				struct fw_priv **fw_priv, void *dbuf,
-				size_t size, enum fw_opt opt_flags)
+				size_t size, u32 opt_flags)
 {
 	struct fw_priv *tmp;
 
@@ -635,8 +635,7 @@ static int fw_add_devm_name(struct device *dev, const char *name)
 }
 #endif
 
-int assign_fw(struct firmware *fw, struct device *device,
-	      enum fw_opt opt_flags)
+int assign_fw(struct firmware *fw, struct device *device, u32 opt_flags)
 {
 	struct fw_priv *fw_priv = fw->priv;
 	int ret;
@@ -687,7 +686,7 @@ int assign_fw(struct firmware *fw, struct device *device,
 static int
 _request_firmware_prepare(struct firmware **firmware_p, const char *name,
 			  struct device *device, void *dbuf, size_t size,
-			  enum fw_opt opt_flags)
+			  u32 opt_flags)
 {
 	struct firmware *firmware;
 	struct fw_priv *fw_priv;
@@ -753,7 +752,7 @@ static void fw_abort_batch_reqs(struct firmware *fw)
 static int
 _request_firmware(const struct firmware **firmware_p, const char *name,
 		  struct device *device, void *buf, size_t size,
-		  enum fw_opt opt_flags)
+		  u32 opt_flags)
 {
 	struct firmware *fw = NULL;
 	int ret;
@@ -990,7 +989,7 @@ struct firmware_work {
 	struct device *device;
 	void *context;
 	void (*cont)(const struct firmware *fw, void *context);
-	enum fw_opt opt_flags;
+	u32 opt_flags;
 };
 
 static void request_firmware_work_func(struct work_struct *work)
-- 
2.17.1

