Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E9977A590
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Aug 2023 10:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjHMIXz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Aug 2023 04:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjHMIXy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Aug 2023 04:23:54 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B74170D
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Aug 2023 01:23:56 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fe1d462762so30705725e9.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Aug 2023 01:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691915035; x=1692519835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VZM/b5Pej16mPyKc+Kl8IzPyaWchqEJykmJSB7R8QxY=;
        b=Ewmkr7AF7MNqSpuZkHq/Y4c5NCdWW9p+Fc1hm2GYmFQmYDt7K8M3kFQ62C12zb0tvl
         AbAerJCN4HYZd4DOFtyWh3Q7jNkGqk9aX6idham7z1TeYyEmOpIrYudXMnh42Obiq9wa
         YTha5qrZx+r933REfvtYvkwVdE3mcPtmjhs2GgpfLSeuG8d8Vfu9dOt9CGK6FLS1iUSm
         6hrIbrXrRl+KO0XPqAOsLpnID9uUyuv5oyMF2nn/7Vu03RTzc91SZaLWRYNkDaHHPLIt
         BXEb91rEsywUr7G7ihLXN7R12umwmy6Pemp1pZ6SxMLzORjpY6Rg9+9CnSpdRupP3LMU
         E6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691915035; x=1692519835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VZM/b5Pej16mPyKc+Kl8IzPyaWchqEJykmJSB7R8QxY=;
        b=MBvmqP7QaOBfxu888x1CirAGEtFblP/yfk8el47rMshpm1UmOyRcZOIn9/sEwMdWrT
         qw86NQVJVwaMzvWBLXpQBycdKbRip97ZssuuScVSwihD88dS1Ti1V67x+vQ2JFYUrHDg
         9Saq9XOQJURhK9ob33JRPqJ/k6YrlssKDxj+EPE5CNkL5P6mhRQxzvVF6E7gv614gpOb
         Sl8lDlMF7tJIWe/F248eY+q2HX1K5Dok8wMp8gUpPqeVbIRHA14/ePjYJ9+x3Np5Sdz1
         Rm0dh34lTPeFy/MPsKutt1V4H8AxMltk0Lv8ZKjqGjzAV+EDMPh6rmS8Ak5iDYBurnRK
         oq7Q==
X-Gm-Message-State: AOJu0YzIaBs/vs3uF0TBCeskka+9vB58iOvgMzQGv9XbWyseKNiA5ifj
        tqdBWWpyi/tLhgTMgLigG1aXvA==
X-Google-Smtp-Source: AGHT+IFiA82j+MfSX+Hf64zA4EhTshaU/pw+Unt6Tw0sb319FHM6l8VmOd+SSIZQR3/67HpTaa5teQ==
X-Received: by 2002:a05:600c:2487:b0:3fe:1d13:4663 with SMTP id 7-20020a05600c248700b003fe1d134663mr5044165wms.1.1691915034606;
        Sun, 13 Aug 2023 01:23:54 -0700 (PDT)
Received: from loic-ThinkPad-T470p.. ([2a01:e0a:82c:5f0:92a5:d57e:294f:f41a])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c294500b003fbaade0735sm13495057wmd.19.2023.08.13.01.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 01:23:53 -0700 (PDT)
From:   Loic Poulain <loic.poulain@linaro.org>
To:     brauner@kernel.org, viro@zeniv.linux.org.uk, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        rdunlap@infradead.org, Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH v4] init: Add support for rootwait timeout parameter
Date:   Sun, 13 Aug 2023 10:23:49 +0200
Message-Id: <20230813082349.513386-1-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add an optional timeout arg to 'rootwait' as the maximum time in
seconds to wait for the root device to show up before attempting
forced mount of the root filesystem.

Use case:
In case of device mapper usage for the rootfs (e.g. root=/dev/dm-0),
if the mapper is not able to create the virtual block for any reason
(wrong arguments, bad dm-verity signature, etc), the `rootwait` param
causes the kernel to wait forever. It may however be desirable to only
wait for a given time and then panic (force mount) to cause device reset.
This gives the bootloader a chance to detect the problem and to take some
measures, such as marking the booted partition as bad (for A/B case) or
entering a recovery mode.

In success case, mounting happens as soon as the root device is ready,
unlike the existing 'rootdelay' parameter which performs an unconditional
pause.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 v2: rebase + reword: add use case example
 v3: Use kstrtoint instead of deprecated simple_strtoul
 v4: Handle mult overflow when converting sec to ms
     Initialize end ktime after ROOT_DEV check

 .../admin-guide/kernel-parameters.txt         |  4 ++
 init/do_mounts.c                              | 38 ++++++++++++++++++-
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a1457995fd41..387cf9c2a2c5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5501,6 +5501,10 @@
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
index 1aa015883519..5dfd30b13f48 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/ramfs.h>
 #include <linux/shmem_fs.h>
+#include <linux/ktime.h>
 
 #include <linux/nfs_fs.h>
 #include <linux/nfs_fs_sb.h>
@@ -71,12 +72,37 @@ static int __init rootwait_setup(char *str)
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
+	int sec;
+
+	if (kstrtoint(str, 0, &sec) || sec < 0) {
+		pr_warn("ignoring invalid rootwait value\n");
+		goto ignore;
+	}
+
+	if (check_mul_overflow(sec, MSEC_PER_SEC, &root_wait)) {
+		pr_warn("ignoring excessive rootwait value\n");
+		goto ignore;
+	}
+
+	return 1;
+
+ignore:
+	/* Fallback to indefinite wait */
+	root_wait = -1;
+
+	return 1;
+}
+
+__setup("rootwait=", rootwait_timeout_setup);
+
 static char * __initdata root_mount_data;
 static int __init root_data_setup(char *str)
 {
@@ -384,14 +410,22 @@ void __init mount_root(char *root_device_name)
 /* wait for any asynchronous scanning to complete */
 static void __init wait_for_root(char *root_device_name)
 {
+	ktime_t end;
+
 	if (ROOT_DEV != 0)
 		return;
 
 	pr_info("Waiting for root device %s...\n", root_device_name);
 
+	end = ktime_add_ms(ktime_get_raw(), root_wait);
+
 	while (!driver_probe_done() ||
-	       early_lookup_bdev(root_device_name, &ROOT_DEV) < 0)
+	       early_lookup_bdev(root_device_name, &ROOT_DEV) < 0) {
 		msleep(5);
+		if (root_wait > 0 && ktime_after(ktime_get_raw(), end))
+			break;
+	}
+
 	async_synchronize_full();
 
 }
-- 
2.34.1

