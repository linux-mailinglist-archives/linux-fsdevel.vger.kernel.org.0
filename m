Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9952C1B7E3B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 20:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbgDXStU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Apr 2020 14:49:20 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38507 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgDXStU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Apr 2020 14:49:20 -0400
Received: by mail-pf1-f193.google.com with SMTP id y25so5212118pfn.5;
        Fri, 24 Apr 2020 11:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dnrdoD7nmACg/ZcofKqMNFF5jN6vuaerLfx/Qx9DPPc=;
        b=kacqRBdxwzcFxPk43qDM6P0s1HxZZbMkh/Y1WYFhZLOFtVuRujjYLWeFf+fFWTfe/P
         8U/5Nu/UdYjYlzt8YntmeBT+bDv12SVBEe5ACyBdJSfkf/D782eG7rNOQYvkBnaBQVDK
         5ibhi6LYHgSpisXfg+qBlPrdTsC5S0VQAguhq/FQ2cAL/zRgJugY0Tn7WNlMECvexo8N
         cZ3bPm230/5/jJ59A7AqRtwGeBRtm/p0kl1JD1Z3Rz5Jk55AHwkdGEEdG8HbSx4ZETVQ
         gXiYaVgk/+X0sPGWOySkZEGSNiZdjli18uvJDfOLFp7cq2Ll2Vbf3W9w6IOZjFP3q2E5
         XD/A==
X-Gm-Message-State: AGi0PuZW8/X7s8RovHwLBZnei4syqU2WL4IX/Fg/DiGDLtOr1q9WB7md
        INTBSEWtzI7XNDJIEkkYal0=
X-Google-Smtp-Source: APiQypKS/Krkami4O3Ig5kxq8u0/B8rJ9D1wPXZ5S66dUFNYWrEFGiRqwPOe2N19TWYG+SlCQ0y47g==
X-Received: by 2002:aa7:9251:: with SMTP id 17mr10452124pfp.315.1587754159592;
        Fri, 24 Apr 2020 11:49:19 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id x4sm6334099pfj.76.2020.04.24.11.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 11:49:18 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 99D05403AB; Fri, 24 Apr 2020 18:49:17 +0000 (UTC)
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
Subject: [PATCH v2 1/2] firmware_loader: revert removal of the fw_fallback_config export
Date:   Fri, 24 Apr 2020 18:49:15 +0000
Message-Id: <20200424184916.22843-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

Christoph's patch removed two unsused exported symbols, however, one
symbol is used by the firmware_loader itself.  If CONFIG_FW_LOADER=m so
the firmware_loader is modular but CONFIG_FW_LOADER_USER_HELPER=y we fail
the build at mostpost.

ERROR: modpost: "fw_fallback_config" [drivers/base/firmware_loader/firmware_class.ko] undefined!

This happens because the variable fw_fallback_config is built into the
kernel if CONFIG_FW_LOADER_USER_HELPER=y always, so we need to grant
access to the firmware loader module by exporting it.

Revert only one hunk from his patch.

Fixes: 739604734bd8e4ad71 ("firmware_loader: remove unused exports")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/base/firmware_loader/fallback_table.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/firmware_loader/fallback_table.c b/drivers/base/firmware_loader/fallback_table.c
index 0a737349f78f..a182e318bd09 100644
--- a/drivers/base/firmware_loader/fallback_table.c
+++ b/drivers/base/firmware_loader/fallback_table.c
@@ -21,6 +21,7 @@ struct firmware_fallback_config fw_fallback_config = {
 	.loading_timeout = 60,
 	.old_timeout = 60,
 };
+EXPORT_SYMBOL_GPL(fw_fallback_config);
 
 #ifdef CONFIG_SYSCTL
 struct ctl_table firmware_config_table[] = {
-- 
2.25.1

