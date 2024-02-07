Return-Path: <linux-fsdevel+bounces-10634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 563AF84CF85
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 18:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D22BD1F249BE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 17:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD6484FA2;
	Wed,  7 Feb 2024 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b="EnGpgNM8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79006839E1
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 17:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707325855; cv=none; b=u6iWHDUaIqVoBepwHxNErLgJFR+Sqe+ae69GIVOYPNFDgAJ708Ryt7HsKKiQusEYM4m4H5mdc0s+keRPWFHdSo7Xflu75BOoHohMOjnyyuiQ3OzvoA7mgalCPzqs/usyOMZ8v3MM3vLIwJzEslI3aOto5Uaq4/jgOVrYHCt/B/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707325855; c=relaxed/simple;
	bh=cSPcyud6xloE+SW7fZUt0r9oQTUtm4YjoFN2yR6+XUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IvS6euAksOIc3G2FNI6fZfid3UwZ47V7zrU59qnR5URcuCOcBWBqMu0cTHJqKs/cTtHLh1UHBCMKqSq5RXGQ10qbtthcFfJ57soRAnzkknLKKCvfSQeeQI18EJAZy52s4Wl/Uaj65CgFFf1IUg8MMPiZcZl9GQoAiHWDKm3Y7ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b=EnGpgNM8; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40efcb37373so7946775e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Feb 2024 09:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1707325850; x=1707930650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEnld1n4J2H05K3DENQtKQhNVSdCp4/Wfk63V/2ciOQ=;
        b=EnGpgNM8WZUL49pPnaFI7ZgtjkM32fc/eQFeDV/bAwPapyM7mWMwEN0OWK386Zsu3R
         Z4P0P9lyWRcUPOESQgRiQ+rPL7Oi9QTlfAyasLMwF4K8bTZS74LK3PoFnYcDj1C/iBWm
         jWyURqqXcSRiOyNAvQmhS5UE5XiEi6YTUMa5lLUGjGuP3CwGGjL3TcqnUxNItRFkuT6O
         by5fiCShbM+SiPzGyVyOysCwAuskAUU3xrEmF0dMCiho15ukAPVH6Nvzvm89g0ua0FM2
         CQXrlBgUvLVK+r//WnlJ1ccJUmuINNETQDxDd9qtgv3cAGM9Z7FAw5C382F3chF3C3Xg
         RorQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707325850; x=1707930650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MEnld1n4J2H05K3DENQtKQhNVSdCp4/Wfk63V/2ciOQ=;
        b=EhlwzQuoyABihLcDXvVPaSYPxTUauKwgKFOAloYXyvIDhUrmRWgN4jKZJSoo5ARrj6
         TcFWnJUp2K3tteHq/YrxHH/L0kwOXmMrnyrT6TRz/hO5Qg9k+6cgixJHZK/j8hL+mXNf
         Qa1I5I12kLbJnv+PEgAMC0o/3gK/HdyWBhBnuzCMOSqwJxFpReTvAZUqyguFl77WIauU
         cyGle/kWfaC1Dg9MwocGD4PH5tGnicBq23xgqBlOYtz0bah7g2PySoiFIYLGPEVZdcK/
         1pwlMXoT+QLpbDq7eyg35VT5V42/+Eun/PntaT2Q6p+kCWWHl6PmXmTBkJvdV2+Z6q/C
         FLqA==
X-Gm-Message-State: AOJu0YxMIF0BBVh/oQBqse/E6lPR+Ec44AYAwvkbQ2utctLF2hLVpHtt
	JFPaM4Z4WEBRyu+HgHdke4SBfc3jxHHNruY03JdVXeR7zv2bFbWiVawm105g9AVyRsnGyF1mOcJ
	L/b8=
X-Google-Smtp-Source: AGHT+IG0OQElTxeTBcaBn/XfbJCgyeS3Gr9vY9Zdbksy5JbOVMoq0BeEeKqJYtnFc9hKOySYtAKojw==
X-Received: by 2002:a05:600c:1c9e:b0:40f:c1b7:2556 with SMTP id k30-20020a05600c1c9e00b0040fc1b72556mr5415616wms.11.1707325849823;
        Wed, 07 Feb 2024 09:10:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXKDoUCko0tABHtVDpRnJU6mOZlVn5cx1FgfcRs8MtjdpIfvWfGdJpdF3x4CcL/0RpfYOgLQ64FXhB8uqPQftDfiqqq9G1U+d/X5j3u3SIaE8/Jc4P1NWWDFXaMlIwsd6i7ylu+AU+NS6OWREHhg3AJ1HjsT2YhZnc4XlFrYlAFnt/1I6hlzWbuMS2FyYO8oVOWSFvwrXFgJsnTmpFjWflVk2z/KsdST6GrfH3aQYzeGKDm04O5W07AckOFbNIY5EIdL2DYouSOulgc75l2Jnw4yGAGi4wSzlvZ6iIAxy4YTtkepQQQM7Q2g42KqbUb/pbeZ3cf1Fu0PyBCrgv36/eXnNh71rnmUOJmgRzL06pRuAoyjy8LUjjKEn+Qn04Qv0hZTPS222kd9zPyzBUh3id66r7UuQolesT+Pafh1WE71pOEVm7X26vUoXkhomIrbLgKJ+pbu7T/R+yClJfVFRPWdjmdsyRdkdM8jokLN3tAYbbfdp9VGT/AyO1820GWnTEr0lOT/17kUONlERmb+cWw2SQpPwmsErJpwYSGLC/6zf3KkAuxIeOWgQHu44nF5gxKclsjGPLdHMyXszZ8SnL97QQoPvUw83rnmzUvVJfF84oHA6sWTPOpAW71fQ+CIhpSyyziKLJaQJWti4BFJpu0yaX4jdNcoOKBzZ1pop3P6EATEukkrYPXD041X9uRoYJaL1LLKmTOGCS2UGXBtRZNBLeBQOA79CCqOh+PA11TjlyUj2BL6EJdR4o0ivwzixh3p8NGqJi+ZxitfoiTyYws+H+Ys0k=
Received: from P-ASN-ECS-830T8C3.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id u14-20020a05600c19ce00b0040fdf2832desm2645584wmq.12.2024.02.07.09.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 09:10:49 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: linux-fsdevel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	x86@kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Borislav Petkov <bp@alien8.de>,
	Darren Hart <dvhart@infradead.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Josh Triplett <josh@joshtriplett.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Yoann Congal <yoann.congal@smile.fr>
Subject: [PATCH v5 3/3] printk: Remove redundant CONFIG_BASE_FULL
Date: Wed,  7 Feb 2024 18:10:20 +0100
Message-Id: <20240207171020.41036-4-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240207171020.41036-1-yoann.congal@smile.fr>
References: <20240207171020.41036-1-yoann.congal@smile.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CONFIG_BASE_FULL is equivalent to !CONFIG_BASE_SMALL and is enabled by
default: CONFIG_BASE_SMALL is the special case to take care of.
So, remove CONFIG_BASE_FULL and move the config choice to
CONFIG_BASE_SMALL (which defaults to 'n')

For defconfigs explicitely disabling BASE_FULL, explicitely enable
BASE_SMALL.
For defconfigs explicitely enabling BASE_FULL, drop it as it is the
default.

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
v4->v5:
* Patch refreshed (2/3 changed)
* Added defconfigs refresh (Petr Mladek's comment, thanks!)
* dropped the redundant "default n" (Masahiro Yamada's comment, thanks!)

v3->v4:
* Split "switch CONFIG_BASE_SMALL to bool" and "Remove the redundant
  config" (this patch) into two patches
* keep CONFIG_BASE_SMALL instead of CONFIG_BASE_FULL
---
 arch/arm/configs/collie_defconfig                    |  2 +-
 arch/arm/configs/keystone_defconfig                  |  2 +-
 arch/arm/configs/lpc18xx_defconfig                   |  2 +-
 arch/arm/configs/moxart_defconfig                    |  2 +-
 arch/arm/configs/mps2_defconfig                      |  2 +-
 arch/arm/configs/omap1_defconfig                     |  2 +-
 arch/arm/configs/stm32_defconfig                     |  2 +-
 arch/microblaze/configs/mmu_defconfig                |  2 +-
 arch/mips/configs/rs90_defconfig                     |  2 +-
 arch/powerpc/configs/adder875_defconfig              |  2 +-
 arch/powerpc/configs/ep88xc_defconfig                |  2 +-
 arch/powerpc/configs/mpc866_ads_defconfig            |  2 +-
 arch/powerpc/configs/mpc885_ads_defconfig            |  2 +-
 arch/powerpc/configs/tqm8xx_defconfig                |  2 +-
 arch/riscv/configs/nommu_k210_defconfig              |  2 +-
 arch/riscv/configs/nommu_k210_sdcard_defconfig       |  2 +-
 arch/riscv/configs/nommu_virt_defconfig              |  2 +-
 arch/sh/configs/edosk7705_defconfig                  |  2 +-
 arch/sh/configs/se7619_defconfig                     |  2 +-
 arch/sh/configs/se7712_defconfig                     |  2 +-
 arch/sh/configs/se7721_defconfig                     |  2 +-
 arch/sh/configs/shmin_defconfig                      |  2 +-
 init/Kconfig                                         | 10 +++-------
 tools/testing/selftests/wireguard/qemu/kernel.config |  1 -
 24 files changed, 25 insertions(+), 30 deletions(-)

diff --git a/arch/arm/configs/collie_defconfig b/arch/arm/configs/collie_defconfig
index 01b5a5a73f037..42cb1c8541188 100644
--- a/arch/arm/configs/collie_defconfig
+++ b/arch/arm/configs/collie_defconfig
@@ -3,7 +3,7 @@ CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EXPERT=y
-# CONFIG_BASE_FULL is not set
+CONFIG_BASE_SMALL=y
 # CONFIG_EPOLL is not set
 CONFIG_ARCH_MULTI_V4=y
 # CONFIG_ARCH_MULTI_V7 is not set
diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index 59c4835ffc977..c1291ca290b23 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -12,7 +12,7 @@ CONFIG_CGROUP_DEVICE=y
 CONFIG_CGROUP_CPUACCT=y
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_ELF_CORE is not set
-# CONFIG_BASE_FULL is not set
+CONFIG_BASE_SMALL=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_EXPERT=y
 CONFIG_PROFILING=y
diff --git a/arch/arm/configs/lpc18xx_defconfig b/arch/arm/configs/lpc18xx_defconfig
index d169da9b2824d..f55c231e08708 100644
--- a/arch/arm/configs/lpc18xx_defconfig
+++ b/arch/arm/configs/lpc18xx_defconfig
@@ -8,7 +8,7 @@ CONFIG_BLK_DEV_INITRD=y
 # CONFIG_RD_LZ4 is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 # CONFIG_UID16 is not set
-# CONFIG_BASE_FULL is not set
+CONFIG_BASE_SMALL=y
 # CONFIG_FUTEX is not set
 # CONFIG_EPOLL is not set
 # CONFIG_SIGNALFD is not set
diff --git a/arch/arm/configs/moxart_defconfig b/arch/arm/configs/moxart_defconfig
index 1d41e73f4903c..34d079e03b3c5 100644
--- a/arch/arm/configs/moxart_defconfig
+++ b/arch/arm/configs/moxart_defconfig
@@ -6,7 +6,7 @@ CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_EXPERT=y
 # CONFIG_ELF_CORE is not set
-# CONFIG_BASE_FULL is not set
+CONFIG_BASE_SMALL=y
 # CONFIG_SIGNALFD is not set
 # CONFIG_TIMERFD is not set
 # CONFIG_EVENTFD is not set
diff --git a/arch/arm/configs/mps2_defconfig b/arch/arm/configs/mps2_defconfig
index 3ed73f184d839..e995e50537efd 100644
--- a/arch/arm/configs/mps2_defconfig
+++ b/arch/arm/configs/mps2_defconfig
@@ -5,7 +5,7 @@ CONFIG_LOG_BUF_SHIFT=16
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_EXPERT=y
 # CONFIG_UID16 is not set
-# CONFIG_BASE_FULL is not set
+CONFIG_BASE_SMALL=y
 # CONFIG_FUTEX is not set
 # CONFIG_EPOLL is not set
 # CONFIG_SIGNALFD is not set
diff --git a/arch/arm/configs/omap1_defconfig b/arch/arm/configs/omap1_defconfig
index 729ea8157e2a5..025b595dd8375 100644
--- a/arch/arm/configs/omap1_defconfig
+++ b/arch/arm/configs/omap1_defconfig
@@ -9,7 +9,7 @@ CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 # CONFIG_ELF_CORE is not set
-# CONFIG_BASE_FULL is not set
+CONFIG_BASE_SMALL=y
 # CONFIG_SHMEM is not set
 # CONFIG_KALLSYMS is not set
 CONFIG_PROFILING=y
diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
index b9fe3fbed5aec..3baec075d1efd 100644
--- a/arch/arm/configs/stm32_defconfig
+++ b/arch/arm/configs/stm32_defconfig
@@ -6,7 +6,7 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_EXPERT=y
 # CONFIG_UID16 is not set
-# CONFIG_BASE_FULL is not set
+CONFIG_BASE_SMALL=y
 # CONFIG_FUTEX is not set
 # CONFIG_EPOLL is not set
 # CONFIG_SIGNALFD is not set
diff --git a/arch/microblaze/configs/mmu_defconfig b/arch/microblaze/configs/mmu_defconfig
index 4da7bc4ac4a37..176314f3c9aac 100644
--- a/arch/microblaze/configs/mmu_defconfig
+++ b/arch/microblaze/configs/mmu_defconfig
@@ -4,7 +4,7 @@ CONFIG_AUDIT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_EXPERT=y
-# CONFIG_BASE_FULL is not set
+CONFIG_BASE_SMALL=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_XILINX_MICROBLAZE0_USE_MSR_INSTR=1
 CONFIG_XILINX_MICROBLAZE0_USE_PCMP_INSTR=1
diff --git a/arch/mips/configs/rs90_defconfig b/arch/mips/configs/rs90_defconfig
index 4b9e36d6400e0..a53dd66e9b864 100644
--- a/arch/mips/configs/rs90_defconfig
+++ b/arch/mips/configs/rs90_defconfig
@@ -9,7 +9,7 @@ CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y
 # CONFIG_SGETMASK_SYSCALL is not set
 # CONFIG_SYSFS_SYSCALL is not set
 # CONFIG_ELF_CORE is not set
-# CONFIG_BASE_FULL is not set
+CONFIG_BASE_SMALL=y
 # CONFIG_TIMERFD is not set
 # CONFIG_AIO is not set
 # CONFIG_IO_URING is not set
diff --git a/arch/powerpc/configs/adder875_defconfig b/arch/powerpc/configs/adder875_defconfig
index 7f35d5bc12299..97f4d48517356 100644
--- a/arch/powerpc/configs/adder875_defconfig
+++ b/arch/powerpc/configs/adder875_defconfig
@@ -4,7 +4,7 @@ CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_EXPERT=y
 # CONFIG_ELF_CORE is not set
-# CONFIG_BASE_FULL is not set
+CONFIG_BASE_SMALL=y
 # CONFIG_FUTEX is not set
 # CONFIG_VM_EVENT_COUNTERS is not set
 # CONFIG_BLK_DEV_BSG is not set
diff --git a/arch/powerpc/configs/ep88xc_defconfig b/arch/powerpc/configs/ep88xc_defconfig
index a98ef6a4abef6..50cc59eb36cf1 100644
--- a/arch/powerpc/configs/ep88xc_defconfig
+++ b/arch/powerpc/configs/ep88xc_defconfig
@@ -6,7 +6,7 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_EXPERT=y
 # CONFIG_ELF_CORE is not set
-# CONFIG_BASE_FULL is not set
+CONFIG_BASE_SMALL=y
 # CONFIG_FUTEX is not set
 # CONFIG_VM_EVENT_COUNTERS is not set
 # CONFIG_BLK_DEV_BSG is not set
diff --git a/arch/powerpc/configs/mpc866_ads_defconfig b/arch/powerpc/configs/mpc866_ads_defconfig
index 5c56d36cdfc5c..6f449411abf7b 100644
--- a/arch/powerpc/configs/mpc866_ads_defconfig
+++ b/arch/powerpc/configs/mpc866_ads_defconfig
@@ -6,7 +6,7 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_EXPERT=y
 # CONFIG_BUG is not set
-# CONFIG_BASE_FULL is not set
+CONFIG_BASE_SMALL=y
 # CONFIG_EPOLL is not set
 # CONFIG_VM_EVENT_COUNTERS is not set
 # CONFIG_BLK_DEV_BSG is not set
diff --git a/arch/powerpc/configs/mpc885_ads_defconfig b/arch/powerpc/configs/mpc885_ads_defconfig
index 56b876e418e91..77306be62e9ee 100644
--- a/arch/powerpc/configs/mpc885_ads_defconfig
+++ b/arch/powerpc/configs/mpc885_ads_defconfig
@@ -7,7 +7,7 @@ CONFIG_VIRT_CPU_ACCOUNTING_NATIVE=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_EXPERT=y
 # CONFIG_ELF_CORE is not set
-# CONFIG_BASE_FULL is not set
+CONFIG_BASE_SMALL=y
 # CONFIG_FUTEX is not set
 CONFIG_PERF_EVENTS=y
 # CONFIG_VM_EVENT_COUNTERS is not set
diff --git a/arch/powerpc/configs/tqm8xx_defconfig b/arch/powerpc/configs/tqm8xx_defconfig
index 083c2e57520a0..383c0966e92fd 100644
--- a/arch/powerpc/configs/tqm8xx_defconfig
+++ b/arch/powerpc/configs/tqm8xx_defconfig
@@ -6,7 +6,7 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_EXPERT=y
 # CONFIG_ELF_CORE is not set
-# CONFIG_BASE_FULL is not set
+CONFIG_BASE_SMALL=y
 # CONFIG_FUTEX is not set
 # CONFIG_VM_EVENT_COUNTERS is not set
 CONFIG_MODULES=y
diff --git a/arch/riscv/configs/nommu_k210_defconfig b/arch/riscv/configs/nommu_k210_defconfig
index 146c46d0525b4..51ba0d1683383 100644
--- a/arch/riscv/configs/nommu_k210_defconfig
+++ b/arch/riscv/configs/nommu_k210_defconfig
@@ -11,7 +11,7 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 # CONFIG_SYSFS_SYSCALL is not set
 # CONFIG_FHANDLE is not set
-# CONFIG_BASE_FULL is not set
+CONFIG_BASE_SMALL=y
 # CONFIG_FUTEX is not set
 # CONFIG_EPOLL is not set
 # CONFIG_SIGNALFD is not set
diff --git a/arch/riscv/configs/nommu_k210_sdcard_defconfig b/arch/riscv/configs/nommu_k210_sdcard_defconfig
index 95d8d1808f194..762aea9127ae4 100644
--- a/arch/riscv/configs/nommu_k210_sdcard_defconfig
+++ b/arch/riscv/configs/nommu_k210_sdcard_defconfig
@@ -3,7 +3,7 @@ CONFIG_LOG_BUF_SHIFT=13
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 # CONFIG_SYSFS_SYSCALL is not set
 # CONFIG_FHANDLE is not set
-# CONFIG_BASE_FULL is not set
+CONFIG_BASE_SMALL=y
 # CONFIG_FUTEX is not set
 # CONFIG_EPOLL is not set
 # CONFIG_SIGNALFD is not set
diff --git a/arch/riscv/configs/nommu_virt_defconfig b/arch/riscv/configs/nommu_virt_defconfig
index b794e2f8144e6..ab6d618c1828f 100644
--- a/arch/riscv/configs/nommu_virt_defconfig
+++ b/arch/riscv/configs/nommu_virt_defconfig
@@ -10,7 +10,7 @@ CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_EXPERT=y
 # CONFIG_SYSFS_SYSCALL is not set
 # CONFIG_FHANDLE is not set
-# CONFIG_BASE_FULL is not set
+CONFIG_BASE_SMALL=y
 # CONFIG_EPOLL is not set
 # CONFIG_SIGNALFD is not set
 # CONFIG_TIMERFD is not set
diff --git a/arch/sh/configs/edosk7705_defconfig b/arch/sh/configs/edosk7705_defconfig
index 9ee35269bee26..ab3bf72264df4 100644
--- a/arch/sh/configs/edosk7705_defconfig
+++ b/arch/sh/configs/edosk7705_defconfig
@@ -6,7 +6,7 @@
 # CONFIG_PRINTK is not set
 # CONFIG_BUG is not set
 # CONFIG_ELF_CORE is not set
-# CONFIG_BASE_FULL is not set
+CONFIG_BASE_SMALL=y
 # CONFIG_FUTEX is not set
 # CONFIG_EPOLL is not set
 # CONFIG_SIGNALFD is not set
diff --git a/arch/sh/configs/se7619_defconfig b/arch/sh/configs/se7619_defconfig
index 14d0f5ead502f..4765966fec99c 100644
--- a/arch/sh/configs/se7619_defconfig
+++ b/arch/sh/configs/se7619_defconfig
@@ -4,7 +4,7 @@ CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_KALLSYMS is not set
 # CONFIG_HOTPLUG is not set
 # CONFIG_ELF_CORE is not set
-# CONFIG_BASE_FULL is not set
+CONFIG_BASE_SMALL=y
 # CONFIG_FUTEX is not set
 # CONFIG_EPOLL is not set
 # CONFIG_VM_EVENT_COUNTERS is not set
diff --git a/arch/sh/configs/se7712_defconfig b/arch/sh/configs/se7712_defconfig
index dc854293da435..20f07aee5bde7 100644
--- a/arch/sh/configs/se7712_defconfig
+++ b/arch/sh/configs/se7712_defconfig
@@ -7,7 +7,7 @@ CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_KALLSYMS_ALL=y
 # CONFIG_BUG is not set
-# CONFIG_BASE_FULL is not set
+CONFIG_BASE_SMALL=y
 # CONFIG_SHMEM is not set
 CONFIG_MODULES=y
 # CONFIG_BLK_DEV_BSG is not set
diff --git a/arch/sh/configs/se7721_defconfig b/arch/sh/configs/se7721_defconfig
index c891945b8a900..00862d3c030d2 100644
--- a/arch/sh/configs/se7721_defconfig
+++ b/arch/sh/configs/se7721_defconfig
@@ -7,7 +7,7 @@ CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_KALLSYMS_ALL=y
 # CONFIG_BUG is not set
-# CONFIG_BASE_FULL is not set
+CONFIG_BASE_SMALL=y
 # CONFIG_SHMEM is not set
 CONFIG_MODULES=y
 # CONFIG_BLK_DEV_BSG is not set
diff --git a/arch/sh/configs/shmin_defconfig b/arch/sh/configs/shmin_defconfig
index e078b193a78a8..bfeb004f130ec 100644
--- a/arch/sh/configs/shmin_defconfig
+++ b/arch/sh/configs/shmin_defconfig
@@ -5,7 +5,7 @@ CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_HOTPLUG is not set
 # CONFIG_BUG is not set
 # CONFIG_ELF_CORE is not set
-# CONFIG_BASE_FULL is not set
+CONFIG_BASE_SMALL=y
 # CONFIG_FUTEX is not set
 # CONFIG_EPOLL is not set
 # CONFIG_SHMEM is not set
diff --git a/init/Kconfig b/init/Kconfig
index 0148229f93613..6f08c736ce799 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1581,11 +1581,10 @@ config PCSPKR_PLATFORM
 	  This option allows to disable the internal PC-Speaker
 	  support, saving some memory.
 
-config BASE_FULL
-	default y
-	bool "Enable full-sized data structures for core" if EXPERT
+config BASE_SMALL
+	bool "Enable smaller-sized data structures for core" if EXPERT
 	help
-	  Disabling this option reduces the size of miscellaneous core
+	  Enabling this option reduces the size of miscellaneous core
 	  kernel data structures. This saves memory on small machines,
 	  but may reduce performance.
 
@@ -1940,9 +1939,6 @@ config RT_MUTEXES
 	bool
 	default y if PREEMPT_RT
 
-config BASE_SMALL
-	def_bool !BASE_FULL
-
 config MODULE_SIG_FORMAT
 	def_bool n
 	select SYSTEM_DATA_VERIFICATION
diff --git a/tools/testing/selftests/wireguard/qemu/kernel.config b/tools/testing/selftests/wireguard/qemu/kernel.config
index 507555714b1d8..f314d3789f175 100644
--- a/tools/testing/selftests/wireguard/qemu/kernel.config
+++ b/tools/testing/selftests/wireguard/qemu/kernel.config
@@ -41,7 +41,6 @@ CONFIG_KALLSYMS=y
 CONFIG_BUG=y
 CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
 CONFIG_JUMP_LABEL=y
-CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_SHMEM=y
 CONFIG_SLUB=y
-- 
2.39.2


