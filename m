Return-Path: <linux-fsdevel+bounces-18756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B68E8BBFB5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2024 10:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 915641F21EAB
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2024 08:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675B317C8B;
	Sun,  5 May 2024 08:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b="hVTykD5c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C91DDBB
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 May 2024 08:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714896261; cv=none; b=HeAkjogI1hK+ryBAJt4sVu+CQTWzn1X+koQUx9UzBYqPPu0kYMbB2E5pPImO7y+8LaJdFScoVXuIegcswH8REMxx9TQuB5g+u2TyzXIcyCy7P380FDKgTQkJ+D1+OKgF7QKFYhkxOPqHrMqf8XP8jTzfVIpp4YON9MUYSlRcunQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714896261; c=relaxed/simple;
	bh=PwtyyIvb1g/T7uC7+H+W6+wraflSrTj7M6d51TPMXGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tM3G0RlfR+BPpRAP2feOiOtqXbSPc63hUIbYD3SYhU8AUtXpxN/9HEphwrou+LWOGMVADCDpEP0uqiS1Gu0bRp7jniK6w4srYxiAVWCC+DAywmVrR/LpMoWh+KwlPSjOpvl3KPEVvhfIFrEKjYokM4RS893bgv5HqC8uvlkIft4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b=hVTykD5c; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41b79450f8cso6201785e9.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 May 2024 01:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1714896257; x=1715501057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yL+ECNUaY+eeDvfxBYwpbmB6VWF8d0j7WE6vzmylt8M=;
        b=hVTykD5cPL6Dvq1RrrDZz2SjdCBg7gJ+64uo7KYWRKTuAggvicICx7+aUkp7r4OiAc
         1EQDYsMs3ZAVR2iohEQbtPSWedBHRZwSSJwcQOyys/IyeOTU5QY/9/7/+bA4f2s6oVD5
         21KiSKR+cfMEmX4BhCz1eoIg8NNASpUAFRfPekFgJYMGCVfzxjl3p0DwDARtS1mxBB/i
         91EIWhr9Z4VldGZ068Ovg5+yp3TjZp9pfOKw+TwwSE7hBGPHAb8RbM/EIEuYjYGU9Htn
         aXJe2T8QWDtC4hE8wNsIHMCto3IhHTey+hElu2epZD4vW8hlkv9kjIJgNAlYo7FVHR6F
         8Ukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714896257; x=1715501057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yL+ECNUaY+eeDvfxBYwpbmB6VWF8d0j7WE6vzmylt8M=;
        b=QtYGl0IsyT6nLLeL3I2PDiwgEcD39UW0OrPthdCXeeGmU4WcrsCQ+0OVv4UGWPfbfC
         6yFkxNWCknlrWGQAkop1JaTnwAQWcmkUFllPVBYbpfDQCtR986Y2g3nrjKxMx2cW+teL
         Ey0ex8C3iU1eSuUgeajf53KE8cu+QH+p3gcaGl5b3gdLWPLaLfhCYM5J5RQVpMJknHK/
         2Oz7afZhLigcFOz72XsD5fWzOrAISYRrLe1MHa84BWuQcJ5IxOP9pTeekBPUc+xIfe0I
         +lXpllqtjC5XELsXnC0bJ7h+pbvIXQS+i3XW+qB0/5apQeDOc58XB8fRadw/tS+pdixj
         PmBA==
X-Gm-Message-State: AOJu0YxmosWZ9uwfIh/4cNvoYB8nUZW2nNGVjiZJlpe5nq4W49RmXC5U
	2F5NM3QLDWbyxu0vUQ15Lg5Xe+Ed5tBheeDPpjEMuAM4I4HIaM4Hlhzx1FX8OabPUz5WwH5Dw4p
	hVsHMGg==
X-Google-Smtp-Source: AGHT+IFtLZkZdsLUhIgXhSK0ld2OQ7w8wy+aP5E21t4B3GTVTtsAwfk2An9izuul6EsZP832qMFibw==
X-Received: by 2002:a05:600c:4709:b0:416:2471:e102 with SMTP id v9-20020a05600c470900b004162471e102mr5207887wmo.37.1714896257453;
        Sun, 05 May 2024 01:04:17 -0700 (PDT)
Received: from P-ASN-ECS-830T8C3.local ([89.159.1.53])
        by smtp.gmail.com with ESMTPSA id s3-20020adfe003000000b0034e8a10039esm4705295wrh.10.2024.05.05.01.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 01:04:16 -0700 (PDT)
From: yoann.congal@smile.fr
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
Subject: [PATCH RESEND v6 3/3] printk: Remove redundant CONFIG_BASE_FULL
Date: Sun,  5 May 2024 10:03:43 +0200
Message-Id: <20240505080343.1471198-4-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240505080343.1471198-1-yoann.congal@smile.fr>
References: <20240505080343.1471198-1-yoann.congal@smile.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yoann Congal <yoann.congal@smile.fr>

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
index 182f2671a49dd..2a8203628d212 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1590,11 +1590,10 @@ config PCSPKR_PLATFORM
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
 
@@ -1949,9 +1948,6 @@ config RT_MUTEXES
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


