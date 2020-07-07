Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9F9216831
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 10:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgGGITw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 04:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbgGGITd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 04:19:33 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7010C08C5E0
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2020 01:19:32 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id w17so1993361ply.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2020 01:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sjDrdoX7gf+4DuKtCmuxAh2Xm2q9yMKpqX8nn9fNlAU=;
        b=BBeRz/5+VJOp1s5xKW+QB/U7Z61hcEMJy79aFjwf2dJ9rKV8hONmZsPCo5Nhh2N9X+
         AFYaL+6F5Y74L5ZxmUFHBnaw7KGYEJ/MwF5UAfy1bbvWQL5fIXJHFPyAsl57beknLqxK
         4bzhDBr2u3/Ej7fNZaSFsox4Us7VvonmVkQpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sjDrdoX7gf+4DuKtCmuxAh2Xm2q9yMKpqX8nn9fNlAU=;
        b=DVW8voZmwtFeDOE98PV8WbGTHKPfVwcAOvLxWl1+nGD0MfpIaFIaDoLnhn6gzAks2p
         3c49egr2LOzVMfLYtCvqTr7cPhp0bEctI6M85OT1SDPrfHWsUBSBa7DRgmPX/gZpwCWG
         4uVxYoLcpDoCJqUfxUBguZA6eTkfW3czEtiGvmkt/LJs2QXVOCNJF3ZsyCskJ3Cae+8x
         cP6eHtvwFirY600WEneuJ2yKEjJtH9A6VKnePSXRAfCGp8B/sMuhAu16tjJArovMB6XH
         +F1GyvKxHrrX/wxVbSHDlOLhMIbD5bc/8/vAqiaVhy/57T2vaRXcPog3Eahr1oXCQmmL
         5hqA==
X-Gm-Message-State: AOAM532fc8H3Zui6y9QAQO7pNm3algc8boEQajrmswoZNjy2POccTJsg
        RkXAEpnoDUSdWAvys9oXAmu2Rw==
X-Google-Smtp-Source: ABdhPJxGDuEjuYScG46HCLyI9wttHYF86/hPhGKgpCUuGKRMHmNSLyc+lzbiBkHquFjKncIjjpHaBg==
X-Received: by 2002:a17:902:40a:: with SMTP id 10mr20914146ple.180.1594109972200;
        Tue, 07 Jul 2020 01:19:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h9sm21361306pfk.155.2020.07.07.01.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 01:19:30 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     James Morris <jmorris@namei.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jessica Yu <jeyu@kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        KP Singh <kpsingh@google.com>, Dave Olsthoorn <dave@bewaar.me>,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 3/4] fs: Remove FIRMWARE_EFI_EMBEDDED from kernel_read_file() enums
Date:   Tue,  7 Jul 2020 01:19:25 -0700
Message-Id: <20200707081926.3688096-4-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707081926.3688096-1-keescook@chromium.org>
References: <20200707081926.3688096-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The "FIRMWARE_EFI_EMBEDDED" enum is a "where", not a "what". It
should not be distinguished separately from just "FIRMWARE", as this
confuses the LSMs about what is being loaded. Additionally, there was
no actual validation of the firmware contents happening. Add call to
security_kernel_post_read_file() so the contents can be measured/verified,
just as the firmware sysfs fallback does. This would allow for IMA (or
other LSMs) to validate known-good EFI firmware images.

Fixes: e4c2c0ff00ec ("firmware: Add new platform fallback mechanism and firmware_request_platform()")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/base/firmware_loader/fallback_platform.c | 7 ++++++-
 include/linux/fs.h                               | 3 +--
 include/linux/lsm_hooks.h                        | 6 +++++-
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/base/firmware_loader/fallback_platform.c b/drivers/base/firmware_loader/fallback_platform.c
index 685edb7dd05a..76e0c4a7835f 100644
--- a/drivers/base/firmware_loader/fallback_platform.c
+++ b/drivers/base/firmware_loader/fallback_platform.c
@@ -17,7 +17,7 @@ int firmware_fallback_platform(struct fw_priv *fw_priv, u32 opt_flags)
 	if (!(opt_flags & FW_OPT_FALLBACK_PLATFORM))
 		return -ENOENT;
 
-	rc = security_kernel_load_data(LOADING_FIRMWARE_EFI_EMBEDDED);
+	rc = security_kernel_load_data(LOADING_FIRMWARE);
 	if (rc)
 		return rc;
 
@@ -25,6 +25,11 @@ int firmware_fallback_platform(struct fw_priv *fw_priv, u32 opt_flags)
 	if (rc)
 		return rc; /* rc == -ENOENT when the fw was not found */
 
+	rc = security_kernel_post_read_file(NULL, (char *)data, size,
+					    READING_FIRMWARE);
+	if (rc)
+		return rc;
+
 	if (fw_priv->data && size > fw_priv->allocated_size)
 		return -ENOMEM;
 	if (!fw_priv->data)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 95fc775ed937..f50a35d54a61 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2993,11 +2993,10 @@ static inline void i_readcount_inc(struct inode *inode)
 #endif
 extern int do_pipe_flags(int *, int);
 
-/* This is a list of *what* is being read, not *how*. */
+/* This is a list of *what* is being read, not *how* nor *where*. */
 #define __kernel_read_file_id(id) \
 	id(UNKNOWN, unknown)		\
 	id(FIRMWARE, firmware)		\
-	id(FIRMWARE_EFI_EMBEDDED, firmware)	\
 	id(MODULE, kernel-module)		\
 	id(KEXEC_IMAGE, kexec-image)		\
 	id(KEXEC_INITRAMFS, kexec-initramfs)	\
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 95b7c1d32062..7cfc3166a1e2 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -633,15 +633,19 @@
  *	@kmod_name name of the module requested by the kernel
  *	Return 0 if successful.
  * @kernel_load_data:
- *	Load data provided by userspace.
+ *	Load data provided by a non-file source (usually userspace buffer).
  *	@id kernel load data identifier
  *	Return 0 if permission is granted.
+ *	This may be paired with a kernel_post_read_file() with a NULL
+ *	@file, but contains the actual data loaded.
  * @kernel_read_file:
  *	Read a file specified by userspace.
  *	@file contains the file structure pointing to the file being read
  *	by the kernel.
  *	@id kernel read file identifier
  *	Return 0 if permission is granted.
+ *	This must be paired with a kernel_post_read_file(), which contains
+ *	the actual data read from @file.
  * @kernel_post_read_file:
  *	Read a file specified by userspace.
  *	@file contains the file structure pointing to the file being read
-- 
2.25.1

