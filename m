Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5DBF1B6571
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 22:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgDWUbq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 16:31:46 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39271 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgDWUbq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 16:31:46 -0400
Received: by mail-pl1-f194.google.com with SMTP id k18so2809502pll.6;
        Thu, 23 Apr 2020 13:31:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y6Yd6vxHdKXfNCR7irTzdhZ+vT9Aep8/YD4m/YAtVdw=;
        b=qNOB7/UTbJ0WPrPane5g72b+wI2CWnElQ+1GsyFof6hilH9nn57dITTjHfdxCiCq2f
         5CW9lFkGUfxwqNK5P6nFR3TXevhfMAoOjC5ioZ7mlMd9Xly6jj2W37URq7SU6xwBa9gW
         hATHcnqRvCLuCBjWcLMWjQVQBCv07Q+7XrteTSZjliOFdS6cZTq3d4V6Lu0ksbGz8DFK
         8EGfVu1D7L/YrfTb8WjXG8lhE7OX/jopd6NEAkSvv2xSlFNsqwQdOcE3ebME0AIaeucx
         yjd9ecWpdZiIOa7AaRNbMcpc1mPli/q/LmHr160WqLicZHqWDdOfBVMeppvvGj+B3RoI
         Ffyg==
X-Gm-Message-State: AGi0PuZj7qNgxi3/QtXksAyipn6LwILKAob98lK7w+/vW/Jm4hjcpHea
        4cAf/bpZQSDMust7kIL6hfk=
X-Google-Smtp-Source: APiQypKOj073Uw8F/aSZ3X0Bvrwz5W+5tF3TTJN6agQwB0Is8Rf+PdYFuKSeUpk4MYviekLU7vhFUg==
X-Received: by 2002:a17:90a:6488:: with SMTP id h8mr2613636pjj.51.1587673904498;
        Thu, 23 Apr 2020 13:31:44 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id e11sm881707pfl.85.2020.04.23.13.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 13:31:43 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 62B10402A1; Thu, 23 Apr 2020 20:31:42 +0000 (UTC)
From:   "Luis R. Rodriguez" <mcgrof@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     akpm@linux-foundation.org, josh@joshtriplett.org,
        rishabhb@codeaurora.org, kubakici@wp.pl, maco@android.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        bjorn.andersson@linaro.org, linux-wireless@vger.kernel.org,
        keescook@chromium.org, shuah@kernel.org, mfuzzey@parkeon.com,
        zohar@linux.vnet.ibm.com, dhowells@redhat.com,
        pali.rohar@gmail.com, tiwai@suse.de, arend.vanspriel@broadcom.com,
        zajec5@gmail.com, nbroeking@me.com, markivx@codeaurora.org,
        broonie@kernel.org, dmitry.torokhov@gmail.com, dwmw2@infradead.org,
        torvalds@linux-foundation.org, Abhay_Salunke@dell.com,
        jewalt@lgsinnovations.com, cantabile.desu@gmail.com, ast@fb.com,
        andresx7@gmail.com, dan.rue@linaro.org, brendanhiggins@google.com,
        yzaikin@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] firmware_loader: re-export fw_fallback_config into firmware_loader's own namespace
Date:   Thu, 23 Apr 2020 20:31:40 +0000
Message-Id: <20200423203140.19510-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

Christoph's recent patch "firmware_loader: remove unused exports", which
is not merged upstream yet, removed two exported symbols. One is fine to
remove since only built-in code uses it but the other is incorrect.

If CONFIG_FW_LOADER=m so the firmware_loader is modular but
CONFIG_FW_LOADER_USER_HELPER=y we fail at mostpost with:

ERROR: modpost: "fw_fallback_config" [drivers/base/firmware_loader/firmware_class.ko] undefined!

This happens because the variable fw_fallback_config is built into the
kernel if CONFIG_FW_LOADER_USER_HELPER=y always, so we need to grant
access to the firmware loader module by exporting it.

Instead of just exporting it as we used to, take advantage of the new
kernel symbol namespacing functionality, and export the symbol only to
the firmware loader private namespace. This would prevent misuses from
other drivers and makes it clear the goal is to keep this private to
the firmware loader alone.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: "firmware_loader: remove unused exports"
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/base/firmware_loader/fallback.c       | 3 +++
 drivers/base/firmware_loader/fallback_table.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index 1e9c96e3ed63..d9ac7296205e 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -9,6 +9,7 @@
 #include <linux/umh.h>
 #include <linux/sysctl.h>
 #include <linux/vmalloc.h>
+#include <linux/module.h>
 
 #include "fallback.h"
 #include "firmware.h"
@@ -17,6 +18,8 @@
  * firmware fallback mechanism
  */
 
+MODULE_IMPORT_NS(FIRMWARE_LOADER_PRIVATE);
+
 extern struct firmware_fallback_config fw_fallback_config;
 
 /* These getters are vetted to use int properly */
diff --git a/drivers/base/firmware_loader/fallback_table.c b/drivers/base/firmware_loader/fallback_table.c
index 0a737349f78f..46a731dede6f 100644
--- a/drivers/base/firmware_loader/fallback_table.c
+++ b/drivers/base/firmware_loader/fallback_table.c
@@ -21,6 +21,7 @@ struct firmware_fallback_config fw_fallback_config = {
 	.loading_timeout = 60,
 	.old_timeout = 60,
 };
+EXPORT_SYMBOL_NS_GPL(fw_fallback_config, FIRMWARE_LOADER_PRIVATE);
 
 #ifdef CONFIG_SYSCTL
 struct ctl_table firmware_config_table[] = {
-- 
2.25.1

