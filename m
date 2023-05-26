Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0C6712731
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 15:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243540AbjEZNHg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 09:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243315AbjEZNHf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 09:07:35 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76101B1
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 May 2023 06:07:29 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f6cbf02747so5230505e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 May 2023 06:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685106448; x=1687698448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3OYN7dZABhmYimN+TZxc/LvZq8eCNJGJVqa65c9esQQ=;
        b=hVt1U943xtcdOo2EhnLU8fSa9SaQAhhJAK9fHvIygC7JJ8lzJKKxP4k7u5OHw8Cp4/
         GsuhTsj7XzA72Zxe9iq2RfLMhyqlEB0pzSIDDgSSYWZsnp/ykcjQeDwPRVz7kDJvnGPl
         KgZToumD2FoaSZR9jpQgonIffD2DIgJPuF4qX7LxLYn3tz66EN6ljaxsV+OcT9Ih0IGM
         LzrS01FjPnYyjJyAtBTRPL8ZsTEM4QgBcxkM4ldHr/JZvlU2r/KZxoQquvr8tjs/l+mW
         BJ0oV+JvPFQW+SJPIkGkl+u9pJ9qj152wZMxlg/TDIGZq+oeD3SUbA0kwEs4sgbvGxpB
         je3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685106448; x=1687698448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3OYN7dZABhmYimN+TZxc/LvZq8eCNJGJVqa65c9esQQ=;
        b=Dp1+zdWxsVUwaPVNRYDSUgCJnUF2zBk4d3RLn+FUxAXBJTAWNVbH2aMrtOTe4JKKwj
         tP+cn+tbD25c6T//fk7jtJhCKF3JyIjHqinzCKu1jzvx7cehXsNXcaUwkP55rv9AFo4g
         wWzlZcTCofL1fVuuAtVaoNxbyr7VuXeixlT3jVU5bfCt5ldvuGMbsYJqfsLbwRmwwrE+
         Aiw8x0bVEIQlb3kGQ5pv5YBlVjgIoecv+3DrzDixyLxvDDL7XhiQZP3Yog5B8EuhxOhr
         dIJaniITq5XAUXJTJitSztmrliuwXHCnzMSgEbLs8qiDmBPsqDhvWi2kTf8wWslqHyh5
         bdwQ==
X-Gm-Message-State: AC+VfDxJ7HdKALDGb54y8M5a0Fkcv7IpYaJXAixLQJiEimyMKYU/ZpUk
        HaT1TbjPYcXOTY/SNiOCzJYhSw==
X-Google-Smtp-Source: ACHHUZ7YKORMpC4RuNFuNl96MUWxk3+APLsN1PXwJ89q18j6GEnvJOhIRtKVBHTuz15K85dTVUYMJQ==
X-Received: by 2002:a05:600c:3658:b0:3f5:fb83:62b0 with SMTP id y24-20020a05600c365800b003f5fb8362b0mr1473701wmq.36.1685106448115;
        Fri, 26 May 2023 06:07:28 -0700 (PDT)
Received: from loic-ThinkPad-T470p.. ([2a01:e0a:82c:5f0:73c8:c098:1848:c7ac])
        by smtp.gmail.com with ESMTPSA id i2-20020a05600c290200b003eddc6aa5fasm8731390wmd.39.2023.05.26.06.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 06:07:27 -0700 (PDT)
From:   Loic Poulain <loic.poulain@linaro.org>
To:     corbet@lwn.net, viro@zeniv.linux.org.uk, brauner@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH] init: Add support for rootwait timeout parameter
Date:   Fri, 26 May 2023 15:07:16 +0200
Message-Id: <20230526130716.2932507-1-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add an optional timeout arg to 'rootwait' as the maximum time in
seconds to wait for the root device to show up before attempting
forced mount of the root filesystem.

This can be helpful to force boot failure and restart in case the
root device does not show up in time, allowing the bootloader to
take any appropriate measures (e.g. recovery, A/B switch, retry...).

In success case, mounting happens as soon as the root device is ready,
contrary to the existing 'rootdelay' parameter (unconditional delay).

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 .../admin-guide/kernel-parameters.txt         |  4 ++++
 init/do_mounts.c                              | 19 +++++++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9e5bab29685f..6e351d4c84a5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5465,6 +5465,10 @@
 			Useful for devices that are detected asynchronously
 			(e.g. USB and MMC devices).
 
+	rootwait=	[KNL] Maximum time (in seconds) to wait for root device
+			to show up before attempting to mount the root
+			filesystem.
+
 	rproc_mem=nn[KMG][@address]
 			[KNL,ARM,CMA] Remoteproc physical memory block.
 			Memory area to be used by remote processor image,
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 811e94daf0a8..942458e7d1c0 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/ramfs.h>
 #include <linux/shmem_fs.h>
+#include <linux/ktime.h>
 
 #include <linux/nfs_fs.h>
 #include <linux/nfs_fs_sb.h>
@@ -306,12 +307,20 @@ static int __init rootwait_setup(char *str)
 {
 	if (*str)
 		return 0;
-	root_wait = 1;
+	root_wait = -1;
 	return 1;
 }
 
 __setup("rootwait", rootwait_setup);
 
+static int __init rootwait_timeout_setup(char *str)
+{
+	root_wait = simple_strtoul(str, NULL, 0);
+	return 1;
+}
+
+__setup("rootwait=", rootwait_timeout_setup);
+
 static char * __initdata root_mount_data;
 static int __init root_data_setup(char *str)
 {
@@ -633,11 +642,17 @@ void __init prepare_namespace(void)
 
 	/* wait for any asynchronous scanning to complete */
 	if ((ROOT_DEV == 0) && root_wait) {
+		const ktime_t end = ktime_add_ms(ktime_get_raw(), root_wait * MSEC_PER_SEC);
+
 		printk(KERN_INFO "Waiting for root device %s...\n",
 			saved_root_name);
 		while (driver_probe_done() != 0 ||
-			(ROOT_DEV = name_to_dev_t(saved_root_name)) == 0)
+			(ROOT_DEV = name_to_dev_t(saved_root_name)) == 0) {
 			msleep(5);
+
+			if (root_wait > 0 && ktime_after(ktime_get_raw(), end))
+				break;
+		}
 		async_synchronize_full();
 	}
 
-- 
2.34.1

