Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9151B7E3D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 20:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgDXStX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Apr 2020 14:49:23 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38323 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbgDXStV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Apr 2020 14:49:21 -0400
Received: by mail-pj1-f65.google.com with SMTP id t40so4226397pjb.3;
        Fri, 24 Apr 2020 11:49:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/KdHtw0iNxBT1mFzOs+kCctxSiinEZ8vRaXskeLEpas=;
        b=pdaOj6pEaDXTihKXkV73LUwSFoz8TyKEK6IG22e4ovvT2bJnJI1BCM7wwjfBZS1MGZ
         IjeXc1RPO+T4jelk2RWNA6pZr3l17EqnyNprXCWEQiIYo1hltkw/RlzOkqbNLqfI0jRg
         wTi4SaorJ02IVol8pZJel+kfUr55m+D04oEVKZPu7u3kGOLWVbG/aJ8cY88yCRygajX1
         wJ4SSi+Y367FemwH6srOiR0tyArQaVWqbl5xZhDIgjtfq33t4CCDcfJkVKs0ggeqxIqd
         WfXHNueca5EsdaC9eK97GMPa0gPoUm7NhNOPypt5hO54LH74fh+LKNEbf49vgtbJnZS+
         04rA==
X-Gm-Message-State: AGi0PubAhw311A9egTWKucMfESVaiCqjP2KOvwZIJrVcphEtTi/8Jema
        tiBwCNWyAlE1grYE2ut2af0=
X-Google-Smtp-Source: APiQypIy/NnmBc8N2fwBt1MHd/4L7BZFYNQtg6fsCXmGZgGhKnNZkb3oP0XC/BVldP8PcIiE8PGbIA==
X-Received: by 2002:a17:902:8e8b:: with SMTP id bg11mr10147371plb.139.1587754160563;
        Fri, 24 Apr 2020 11:49:20 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 14sm6389640pfy.38.2020.04.24.11.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 11:49:18 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id AC5244096E; Fri, 24 Apr 2020 18:49:17 +0000 (UTC)
From:   "Luis R. Rodriguez" <mcgrof@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     akpm@linux-foundation.org, josh@joshtriplett.org,
        rishabhb@codeaurora.org, kubakici@wp.pl, maco@android.com,
        david.brown@linaro.org, bjorn.andersson@linaro.org,
        linux-wireless@vger.kernel.org, keescook@chromium.org,
        shuah@kernel.org, mfuzzey@parkeon.com, zohar@linux.vnet.ibm.com,
        dhowells@redhat.com, pali.rohar@gmail.com, tiwai@suse.de,
        arend.vanspriel@broadcom.com, zajec5@gmail.com, nbroeking@me.com,
        broonie@kernel.org, dmitry.torokhov@gmail.com, dwmw2@infradead.org,
        torvalds@linux-foundation.org, Abhay_Salunke@dell.com,
        jewalt@lgsinnovations.com, cantabile.desu@gmail.com, ast@fb.com,
        andresx7@gmail.com, dan.rue@linaro.org, brendanhiggins@google.com,
        yzaikin@google.com, sfr@canb.auug.org.au, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 2/2] firmware_loader: move fw_fallback_config to a private kernel symbol namespace
Date:   Fri, 24 Apr 2020 18:49:16 +0000
Message-Id: <20200424184916.22843-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200424184916.22843-1-mcgrof@kernel.org>
References: <20200424184916.22843-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

Take advantage of the new kernel symbol namespacing functionality, and
export the fw_fallback_config symbol only to a new private firmware loader
namespace. This would prevent misuses from other drivers and makes it clear
the goal is to keep this private to the firmware loader only.

It should also make it clearer for folks git grep'ing for users of
the symbol that this exported symbol is private, and prevent future
accidental removals of the exported symbol.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/base/firmware_loader/fallback.c       | 3 +++
 drivers/base/firmware_loader/fallback_table.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

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
index a182e318bd09..46a731dede6f 100644
--- a/drivers/base/firmware_loader/fallback_table.c
+++ b/drivers/base/firmware_loader/fallback_table.c
@@ -21,7 +21,7 @@ struct firmware_fallback_config fw_fallback_config = {
 	.loading_timeout = 60,
 	.old_timeout = 60,
 };
-EXPORT_SYMBOL_GPL(fw_fallback_config);
+EXPORT_SYMBOL_NS_GPL(fw_fallback_config, FIRMWARE_LOADER_PRIVATE);
 
 #ifdef CONFIG_SYSCTL
 struct ctl_table firmware_config_table[] = {
-- 
2.25.1

