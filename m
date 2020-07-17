Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE41622426D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 19:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgGQRog (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 13:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbgGQRnQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 13:43:16 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FA0C0619D3
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 10:43:16 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l63so7015986pge.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 10:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7gESCYHdeEc18WmSHoFiRlcOM8qkMy02/gtCzbZTAqQ=;
        b=WxPHrXXFANimi0wbvfcJ6Cfo6RILGM8zrzptr/i4wicbfpzxjVf9s2PSObmLwcn9aq
         SbUDJlkCbpwtWAmmR9A2NZpribK1YDkwqAQ5TTgN4F0z1JKluyrZrKxbZBHXSmRh0PPQ
         ei15QxSWG1ELter/xoH0l0moiUBAi1WUPtXtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7gESCYHdeEc18WmSHoFiRlcOM8qkMy02/gtCzbZTAqQ=;
        b=hz6kAZJtSp5aWjUP0RZgibwjowIH91NsHkpT2vKAcHDkyJuu8IjI4ejvHWwUtgaIOM
         DR/iVeUm4kuuGF+TYxxYpyGcHGyo+ubt0AGAPBG8OLHc73ipvAwfHbz/UdK8TssrOh2r
         kfP+ym/aXhLsPLFLAEfqnt7Sbx/OT+QGzWIL6kweiERj1f0J6UaV1YwYobUA7cpO7HcY
         M8QP+ocQ8+mbCpbIjQxMPbtivW1tWbNj8bTYjPLwu09xasNQxWXaMgVNk+02QwEGOQpp
         aZHflnoDBA+UZxITTun8Ahq3SyDmzC30KHaW+6dOJYySOeju7mBhlo9ak+F0cNCr+Mz0
         osCw==
X-Gm-Message-State: AOAM53313ax3azi24tjeQq2XKDeyHnsYtsP34OwUJT0fvxCowwc4u21l
        +glHZvbJdaWVbshLXZ5TPfklUQ==
X-Google-Smtp-Source: ABdhPJysbKI9KHmH4JZipg0ZRO74vc0Q1f/poXmDdT5wVjf46XMdV4SEDnNnhl9+P92e4T6IX1H7yg==
X-Received: by 2002:a63:338c:: with SMTP id z134mr9360703pgz.245.1595007796077;
        Fri, 17 Jul 2020 10:43:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c139sm8072372pfb.65.2020.07.17.10.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 10:43:13 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        James Morris <jmorris@namei.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
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
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/13] fs/kernel_read_file: Remove FIRMWARE_EFI_EMBEDDED enum
Date:   Fri, 17 Jul 2020 10:42:58 -0700
Message-Id: <20200717174309.1164575-4-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717174309.1164575-1-keescook@chromium.org>
References: <20200717174309.1164575-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The "FIRMWARE_EFI_EMBEDDED" enum is a "where", not a "what". It
should not be distinguished separately from just "FIRMWARE", as this
confuses the LSMs about what is being loaded. Additionally, there was
no actual validation of the firmware contents happening.

Fixes: e4c2c0ff00ec ("firmware: Add new platform fallback mechanism and firmware_request_platform()")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
To aid in backporting, this change is made before moving
kernel_read_file() to separate header/source files.
---
 drivers/base/firmware_loader/fallback_platform.c | 2 +-
 include/linux/fs.h                               | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/base/firmware_loader/fallback_platform.c b/drivers/base/firmware_loader/fallback_platform.c
index 685edb7dd05a..6958ab1a8059 100644
--- a/drivers/base/firmware_loader/fallback_platform.c
+++ b/drivers/base/firmware_loader/fallback_platform.c
@@ -17,7 +17,7 @@ int firmware_fallback_platform(struct fw_priv *fw_priv, u32 opt_flags)
 	if (!(opt_flags & FW_OPT_FALLBACK_PLATFORM))
 		return -ENOENT;
 
-	rc = security_kernel_load_data(LOADING_FIRMWARE_EFI_EMBEDDED);
+	rc = security_kernel_load_data(LOADING_FIRMWARE);
 	if (rc)
 		return rc;
 
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
-- 
2.25.1

