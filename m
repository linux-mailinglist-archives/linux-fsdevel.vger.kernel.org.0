Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F29771457
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Aug 2023 12:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjHFKM0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Aug 2023 06:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjHFKMZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Aug 2023 06:12:25 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B0719A3
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Aug 2023 03:12:23 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe4ad22e36so18557625e9.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Aug 2023 03:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691316741; x=1691921541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=stuJqaNoc8+CyrTaBzMymqInJJyNxuySrxbp3ccLMSM=;
        b=BvUibkjXpSn53ss6d2zWo3GHot1opOycwPZLmgg5RX03G6KJzC2uUYMo7Ej1fmktPN
         n1TE2pKhI+mHYJfzop9rxOhvuDM81/U6vmE74ewiMKl4X4FSfQQvHEqlqh7fcZ/L2r03
         scb0mhJCHjZcxPW4ammn5glclltGIvkWPapubBJM+ds7HjObw6hRGkM3+ggBs8XG6q0+
         PU9DnBiea1oKKox9Bnv/vj7cY78J3oljrMclWguKcWyoJ/8znocnA20Wt4StxGjiyzJD
         +/I3T+OIJTtL+u3qaY0bBofAHKSmP5yohxv+ffm4YZOKDzwEuhBmVakVqfrFZkZfF7MY
         MhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691316741; x=1691921541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=stuJqaNoc8+CyrTaBzMymqInJJyNxuySrxbp3ccLMSM=;
        b=dR0dt1NqMqGSr0tJ1xf/SgirTwlbSdiJ7wHmJ53ptvzCFDWv4llPAJf4XRRRni0Jf8
         aU26HnhJFyxldn9GvYkacoUFPQAIEQFBSSniIWHPtIo8UbD9gDnG2wl476QaMvDken0C
         ExVJ7OcuCfvB2ZtSrGI3jgmDLVfEQ+EfTZqxLWR2eZSBI2360+LeXWPozFDtMAMRFNqc
         F0ODgWJkByX57ZN1ekrGWHeNBCyHqY83jpQkhp00UqNqOE4YpkVISNYaTbgMC7HAHwAE
         tTwFiL7PmLD0/pIpckKqPNANoTthCjpAacW8FD2eoi5trNGz92kCuzqEa+Hi3Y3tqmvd
         x8kQ==
X-Gm-Message-State: AOJu0YwhkDO9hraWASp5KWRw4uvPlT4+L05se2CuRcfP8XS/WJ2bMeax
        /H595DVFlnGLsr1F+a8im29GLw==
X-Google-Smtp-Source: AGHT+IHFd/KlMS3CBCtwj91xL7Xwekc7eD/+pg68NTNAiQoIDYiivoLT70Bf8C7dD+yRl6RV03H1Kg==
X-Received: by 2002:a7b:cc99:0:b0:3fe:1f98:deb7 with SMTP id p25-20020a7bcc99000000b003fe1f98deb7mr4690456wma.35.1691316741571;
        Sun, 06 Aug 2023 03:12:21 -0700 (PDT)
Received: from loic-ThinkPad-T470p.. ([2a01:e0a:82c:5f0:2a5f:dd16:fb77:b314])
        by smtp.gmail.com with ESMTPSA id a14-20020adfed0e000000b003177f57e79esm7209115wro.88.2023.08.06.03.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 03:12:20 -0700 (PDT)
From:   Loic Poulain <loic.poulain@linaro.org>
To:     brauner@kernel.org, viro@zeniv.linux.org.uk, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        rdunlap@infradead.org, Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH v3] init: Add support for rootwait timeout parameter
Date:   Sun,  6 Aug 2023 12:12:17 +0200
Message-Id: <20230806101217.164068-1-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

 .../admin-guide/kernel-parameters.txt         |  4 ++++
 init/do_mounts.c                              | 24 +++++++++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

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
index 1aa015883519..98190bf34a9f 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/ramfs.h>
 #include <linux/shmem_fs.h>
+#include <linux/ktime.h>
 
 #include <linux/nfs_fs.h>
 #include <linux/nfs_fs_sb.h>
@@ -71,12 +72,25 @@ static int __init rootwait_setup(char *str)
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
+	if (kstrtoint(str, 0, &root_wait) || root_wait < 0) {
+		pr_warn("ignoring invalid rootwait value\n");
+		/* fallback to indefinite wait */
+		root_wait = -1;
+	}
+
+	return 1;
+}
+
+__setup("rootwait=", rootwait_timeout_setup);
+
 static char * __initdata root_mount_data;
 static int __init root_data_setup(char *str)
 {
@@ -384,14 +398,20 @@ void __init mount_root(char *root_device_name)
 /* wait for any asynchronous scanning to complete */
 static void __init wait_for_root(char *root_device_name)
 {
+	const ktime_t end = ktime_add_ms(ktime_get_raw(), root_wait * MSEC_PER_SEC);
+
 	if (ROOT_DEV != 0)
 		return;
 
 	pr_info("Waiting for root device %s...\n", root_device_name);
 
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

