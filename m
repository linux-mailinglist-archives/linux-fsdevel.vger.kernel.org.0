Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC88A1DF16E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 May 2020 23:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731093AbgEVVrU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 May 2020 17:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731065AbgEVVrU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 May 2020 17:47:20 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAC0C05BD43
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 14:47:20 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id c75so5624257pga.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 14:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=80cOC3Q1C1nh3jgT7bLdfn6QXwRHWrLiSMAc5u1N5Mg=;
        b=MBVTOqMsRRDOXwqDeh3TlHhCVuQINpecjzEWi2sbZjFC2s+fi8libuvJoKMdyiA93j
         HjxXahYGwB2EeBTPt5THAGJtXNUS1blvwgSzxXsV7iD7yKk/idl5N09duhj4GIrn1ZiN
         dFdhnMRbAksUe0m8/f+9BUDtxd165NCjk74ME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=80cOC3Q1C1nh3jgT7bLdfn6QXwRHWrLiSMAc5u1N5Mg=;
        b=maxooGyZcEiIU0tWgbAGm6O/Ny/wm5ywukic+ZQKz9zDm1KtVKn/baOSUZUKUIO7lS
         mHYVUiXIljvnja+V3ZN4HzG8TFzzB6IL9AAOd6qLW7cOwfwC2GyzaCQp5i8h8rZJGlMk
         kI/d+7AFyM6vfhlaqBNJiwxECAhZhG9pJasUvALC5ISTRSYE/Unsw5MqMLDgsW6docwI
         XtxM89xn19qQw0VMsIZ0PsvqXRUYqTb50cJi6/8oDa4KUTBIgNns3JR/E9aDE51FVlQ0
         yzNOyhApS+xE+9c+nT8BSSNkXFrHlnIJWoXxWQPjfke+GNlwpVAByuCiVdcRcSu/lbKQ
         JlPA==
X-Gm-Message-State: AOAM532rS6lVg9KGdJZz4yjvbS69bgtZlfHKk1mwaCQ9rZbpzyIutY3I
        ZqoGlvhuQuELMVjAGkgTMBd9bw==
X-Google-Smtp-Source: ABdhPJwCvSRp3cNpgT+cHxazKcMuvzWV+0gormNW+/FlbLyRW0Hkd2BGV2aYYNTI+c6UjR+ZCLaIdA==
X-Received: by 2002:a63:5864:: with SMTP id i36mr15433327pgm.231.1590184039358;
        Fri, 22 May 2020 14:47:19 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id w1sm6889502pgh.53.2020.05.22.14.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 14:47:18 -0700 (PDT)
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
Subject: [PATCH] firmware_loader: change enum fw_opt to u32
Date:   Fri, 22 May 2020 14:46:58 -0700
Message-Id: <20200522214658.12722-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"enum fw_opt" is not used as an enum.
Change fw_opt to a u32 and the FW_OPT_* values inside the enum to defines.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/base/firmware_loader/fallback.c       | 12 +++++------
 drivers/base/firmware_loader/fallback.h       |  8 +++----
 .../base/firmware_loader/fallback_platform.c  |  2 +-
 drivers/base/firmware_loader/firmware.h       | 21 ++++++++-----------
 drivers/base/firmware_loader/main.c           | 11 +++++-----
 5 files changed, 25 insertions(+), 29 deletions(-)

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
index 25836a6afc9f..cf6dc96a84a2 100644
--- a/drivers/base/firmware_loader/firmware.h
+++ b/drivers/base/firmware_loader/firmware.h
@@ -12,7 +12,7 @@
 #include <generated/utsrelease.h>
 
 /**
- * enum fw_opt - options to control firmware loading behaviour
+ * fw_opt - options to control firmware loading behaviour
  *
  * @FW_OPT_UEVENT: Enables the fallback mechanism to send a kobject uevent
  *	when the firmware is not found. Userspace is in charge to load the
@@ -33,15 +33,13 @@
  *	the platform's main firmware. If both this fallback and the sysfs
  *      fallback are enabled, then this fallback will be tried first.
  */
-enum fw_opt {
-	FW_OPT_UEVENT			= BIT(0),
-	FW_OPT_NOWAIT			= BIT(1),
-	FW_OPT_USERHELPER		= BIT(2),
-	FW_OPT_NO_WARN			= BIT(3),
-	FW_OPT_NOCACHE			= BIT(4),
-	FW_OPT_NOFALLBACK_SYSFS		= BIT(5),
-	FW_OPT_FALLBACK_PLATFORM	= BIT(6),
-};
+#define FW_OPT_UEVENT			BIT(0)
+#define FW_OPT_NOWAIT			BIT(1)
+#define FW_OPT_USERHELPER		BIT(2)
+#define FW_OPT_NO_WARN			BIT(3)
+#define FW_OPT_NOCACHE			BIT(4)
+#define FW_OPT_NOFALLBACK_SYSFS		BIT(5)
+#define FW_OPT_FALLBACK_PLATFORM	BIT(6)
 
 enum fw_status {
 	FW_STATUS_UNKNOWN,
@@ -136,8 +134,7 @@ static inline void fw_state_done(struct fw_priv *fw_priv)
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

