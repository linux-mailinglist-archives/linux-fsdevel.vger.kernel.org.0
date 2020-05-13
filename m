Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66EAC1D191F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 17:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389266AbgEMPV3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 11:21:29 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41043 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389194AbgEMPVQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 11:21:16 -0400
Received: by mail-pl1-f195.google.com with SMTP id u10so6947472pls.8;
        Wed, 13 May 2020 08:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y6Z349elIdKKVeaQxYemASvgjctlEyt1SGMVKJhxPXM=;
        b=gyR+naj/grs9FYkqd0BkqB6VJREmlDi5xnmwlWJ0HMj/hEAyfEDzpDaZEPzrM567lE
         coJ2wm4EQesZEpo6u/YEBmn6WkA/mad2A+WxXlvd2yaY6LClM+chjxPfd0t7dCJvbNeU
         +omp2hYgR/qfssq/ZtmnJ4x5wV3cEGCyL+nXGl5TSDuod0bfA6gQxIDG/mbTYdZTXKV5
         N7hvqbBjr2SdOSLZPeUYXyOGJJppAPaMRCVkhsyqlU6V0Z6Dyg1wpIOoKQ8IXGYlneGT
         JGAjZOaGlrWy21UoTMnYQIuB/6Ux4wkfOydJZOXbh9CcRdra/83ceHAF8B4JrWkSAs7f
         ouCw==
X-Gm-Message-State: AGi0PuaLQ2JkixjwOt6RTueI+PTBA48aLT1PMJ2rlQWreGUIcYggV2So
        gVx+4BGpLhmloLEWO6R6SE4=
X-Google-Smtp-Source: APiQypJ0RK+oeB+zoVh6X+gWZ3eFKKxCmbjeHLRNnXh89syCW3qa7AF2ZqhxpjaGZLht8Q8+XSsMkg==
X-Received: by 2002:a17:90a:1743:: with SMTP id 3mr33555393pjm.106.1589383275911;
        Wed, 13 May 2020 08:21:15 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id i3sm6842005pfe.44.2020.05.13.08.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 08:21:13 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 5D22941D00; Wed, 13 May 2020 15:21:12 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rafael@kernel.org, ebiederm@xmission.com, jeyu@kernel.org,
        jmorris@namei.org, keescook@chromium.org, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        nayna@linux.ibm.com, zohar@linux.ibm.com
Cc:     scott.branden@broadcom.com, dan.carpenter@oracle.com,
        skhan@linuxfoundation.org, geert@linux-m68k.org,
        tglx@linutronix.de, bauerman@linux.ibm.com, dhowells@redhat.com,
        linux-integrity@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 2/3] security: add symbol namespace for reading file data
Date:   Wed, 13 May 2020 15:21:07 +0000
Message-Id: <20200513152108.25669-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200513152108.25669-1-mcgrof@kernel.org>
References: <20200513152108.25669-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Certain symbols are not meant to be used by everybody, the security
helpers for reading files directly is one such case. Use a symbol
namespace for them.

This will prevent abuse of use of these symbols in places they were
not inteded to be used, and provides an easy way to audit where these
types of operations happen as a whole.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/base/firmware_loader/fallback.c | 1 +
 fs/exec.c                               | 2 ++
 kernel/kexec.c                          | 2 ++
 kernel/module.c                         | 2 ++
 security/security.c                     | 6 +++---
 5 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index d9ac7296205e..b088886dafda 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -19,6 +19,7 @@
  */
 
 MODULE_IMPORT_NS(FIRMWARE_LOADER_PRIVATE);
+MODULE_IMPORT_NS(SECURITY_READ);
 
 extern struct firmware_fallback_config fw_fallback_config;
 
diff --git a/fs/exec.c b/fs/exec.c
index 9791b9eef9ce..30bd800ab1d6 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -72,6 +72,8 @@
 
 #include <trace/events/sched.h>
 
+MODULE_IMPORT_NS(SECURITY_READ);
+
 int suid_dumpable = 0;
 
 static LIST_HEAD(formats);
diff --git a/kernel/kexec.c b/kernel/kexec.c
index f977786fe498..8d572b41a157 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -19,6 +19,8 @@
 
 #include "kexec_internal.h"
 
+MODULE_IMPORT_NS(SECURITY_READ);
+
 static int copy_user_segment_list(struct kimage *image,
 				  unsigned long nr_segments,
 				  struct kexec_segment __user *segments)
diff --git a/kernel/module.c b/kernel/module.c
index 80faaf2116dd..8973a463712e 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -59,6 +59,8 @@
 #include <uapi/linux/module.h>
 #include "module-internal.h"
 
+MODULE_IMPORT_NS(SECURITY_READ);
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/module.h>
 
diff --git a/security/security.c b/security/security.c
index 8ae66e4c370f..bdbd1fc5105a 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1654,7 +1654,7 @@ int security_kernel_read_file(struct file *file, enum kernel_read_file_id id)
 		return ret;
 	return ima_read_file(file, id);
 }
-EXPORT_SYMBOL_GPL(security_kernel_read_file);
+EXPORT_SYMBOL_NS_GPL(security_kernel_read_file, SECURITY_READ);
 
 int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
 				   enum kernel_read_file_id id)
@@ -1666,7 +1666,7 @@ int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
 		return ret;
 	return ima_post_read_file(file, buf, size, id);
 }
-EXPORT_SYMBOL_GPL(security_kernel_post_read_file);
+EXPORT_SYMBOL_NS_GPL(security_kernel_post_read_file, SECURITY_READ);
 
 int security_kernel_load_data(enum kernel_load_data_id id)
 {
@@ -1677,7 +1677,7 @@ int security_kernel_load_data(enum kernel_load_data_id id)
 		return ret;
 	return ima_load_data(id);
 }
-EXPORT_SYMBOL_GPL(security_kernel_load_data);
+EXPORT_SYMBOL_NS_GPL(security_kernel_load_data, SECURITY_READ);
 
 int security_task_fix_setuid(struct cred *new, const struct cred *old,
 			     int flags)
-- 
2.26.2

