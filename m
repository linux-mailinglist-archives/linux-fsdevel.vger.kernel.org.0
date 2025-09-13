Return-Path: <linux-fsdevel+bounces-61166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 486F0B55BA8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 02:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D3EB5A09AE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 00:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE10A1885A5;
	Sat, 13 Sep 2025 00:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5Sg4ace"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C234A11CA9
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Sep 2025 00:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757724728; cv=none; b=vDqapLxv6WMdpfLMQDb5kTc8d7n38b4ZLJpXqca8qkFzy0Rbz2x6jHiU8gjz1gPBJsRcJ3ZthO6jJHwnVYwaF6pSI+hXmTUKASO7Q0H0fIkZKZUU+gQvpNxCgi0H4Yq5T8LrQU2zxNgZ5tvuuyHX7w13MRztoHbXa6H/ahxwbYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757724728; c=relaxed/simple;
	bh=XuzND7NDKgn2zA4fn1lxlzKccu851trJZxPzYXoIeEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=InBNj/lI2FkJj1iPVw30WKHY/EqiUgLrTXkM3+TGrmrqJ4SZpvzl/cl9ynal6tqEEQbYDLgs/tiC0bEbUiToV/VxeZE9OP1e1eA+gjZ7umC9OACIIYCsfs8uk4zlE1ADMkk3SKozQftSLCF1VlF65uqQKN7x7PKm/Q0K78MYOBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5Sg4ace; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b0418f6fc27so429553066b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 17:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757724723; x=1758329523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MdGbmKxqlcMl0rLfzu7p7wshkZ7f+lqXVhPxNRPgNLM=;
        b=h5Sg4aceiNqsG09qyv4fQHdta7r18PBqbjnCUQpUsr0d59Jlkku5pnj1q118tscufQ
         WMm0Tfh6iedh86Y/SKnZfZobObCqOt05Ab4REpnZp0DyxdrxCyH/wwW78hq1FoyM0Lw/
         OvqrrPUA7raZRjK9uZxseDWoGS1nsmULA8hWW/VG3h2Nngul2pms0DCxfWvDTvD5jxLA
         MuNNnUcH+9fJr/PtPD3KN4h6992YdjcNlSTFBtbjPkRmhqheYZgjU0wEnwf5OYU/Csxi
         zAoxqn0BDujXIYGUGBa1NoCGS66XPy89dIWzW0iGHjPMUIERZLv5f+Cc17wRsFkSq72O
         LFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757724723; x=1758329523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MdGbmKxqlcMl0rLfzu7p7wshkZ7f+lqXVhPxNRPgNLM=;
        b=dunqlOGf2UB0fsk+3XQZB58jQjdeZKLLP1g2lo92P3+p7VxgmZQw7u5RwW7vS4PnX/
         BNeSt0UEhpZ81AncHWA+j6Vtl0bTRZf8BhaY3U5w0lUdUZJOqeijjuyVlS7Q8V9ZUWiW
         gabUSUWUjNOmJP+1E+mqFXMkmX1b5h/4AR0LMZFDu4pYZxiwt8Z7x8OnBET82Zd3LMJ7
         6wn+BEKxOs3BuOqvwvUc2jg8bM4efMOXGcwzrmwic2y52lKiUYpWn7SAWdFzkNTuwHzr
         S+qSdPxih2KlnDVBKcCeHOWUKAKxrONbnVjXyxS5p+jfs9DXYImJGGDmIXB5lnoh00I7
         y84Q==
X-Gm-Message-State: AOJu0YyBfPLIJG4ocijD2kQ/le4mYZxYt6j4Taj0x94bearcZXA14N+X
	4dmFGlKe5Pu4/YwfzuOsIm0dZ6G7ktB9lGPp0sVtXr279FztqxdBXWfWLA06k/B0
X-Gm-Gg: ASbGncs7JP4ZF/QQwWjby1L2RkOtSeO8EZ6rU9LfpU/CWiE8sHEyjqpPQMU39Es7bw3
	9gHph8bBtKpZizrdnCHb5KXJPwxcYekjmwDxcAMEffhdsVcChu94kebb9f67M0oF9oLklqNFcpk
	YVXpir5VDCFsHRQjCK+fCqspu3xtizd8/MUQAgwJyzH4arOWgRA9uuZwVDKjibXkRr2yEnog44b
	JuhpIgjmiI7BGEFbS0RTN++mQIu6JuP4aFMqPAG9i0blTqJdtkysT1EWBT1Ysdb1sxu4am5GLY/
	TJ9MpeQnud+fl3mlIhPsCoZW6iq6uZDxs28JrIXq43xvVDWCToZMTBoq1vL0ZAnUTEP1/dr6pmC
	zGFUB9FeTsiprC8UXgMi2uqmt6eu9Pw==
X-Google-Smtp-Source: AGHT+IEOxv4u1csoR3Asex+KK1PngLg51+/kQQMoUV5EwO+MoxI2Yose6oae6R3weUM2rN4atBIYiQ==
X-Received: by 2002:a17:907:9801:b0:afe:6c9b:c828 with SMTP id a640c23a62f3a-b07c37b8165mr442852966b.61.1757724722473;
        Fri, 12 Sep 2025 17:52:02 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b08cab32303sm25787366b.72.2025.09.12.17.51.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 17:52:02 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Art Nikpal <email2tema@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Curtin <ecurtin@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Rob Landley <rob@landley.net>,
	Lennart Poettering <mzxreary@0pointer.de>,
	linux-arch@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	linux-block@vger.kernel.org,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	"Theodore Y . Ts'o" <tytso@mit.edu>,
	linux-acpi@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>,
	devicetree@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Heiko Carstens <hca@linux.ibm.com>,
	patches@lists.linux.dev
Subject: [PATCH RESEND 11/62] init, efi: remove "noinitrd" command line parameter
Date: Sat, 13 Sep 2025 00:37:50 +0000
Message-ID: <20250913003842.41944-12-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was inconsistent before initrd removal: it mostly
controlled initrd only, but in EFI stub boot mode
it controlled both initrd and initramfs

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 3 ---
 arch/arm/configs/collie_defconfig               | 2 +-
 arch/arm/configs/imx_v6_v7_defconfig            | 2 +-
 arch/arm/configs/neponset_defconfig             | 2 +-
 arch/arm/configs/spitz_defconfig                | 2 +-
 drivers/firmware/efi/libstub/efi-stub-helper.c  | 5 +----
 init/do_mounts_initrd.c                         | 9 ---------
 7 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 07e8878f1e13..ad52e3d26014 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4271,9 +4271,6 @@
 			Note that this argument takes precedence over
 			the CONFIG_RCU_NOCB_CPU_DEFAULT_ALL option.
 
-	noinitrd	[RAM] Tells the kernel not to load any configured
-			initial RAM disk.
-
 	nointremap	[X86-64,Intel-IOMMU,EARLY] Do not enable interrupt
 			remapping.
 			[Deprecated - use intremap=off]
diff --git a/arch/arm/configs/collie_defconfig b/arch/arm/configs/collie_defconfig
index 578c6a4af620..00dc8ae22824 100644
--- a/arch/arm/configs/collie_defconfig
+++ b/arch/arm/configs/collie_defconfig
@@ -9,7 +9,7 @@ CONFIG_ARCH_MULTI_V4=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_COLLIE=y
-CONFIG_CMDLINE="noinitrd root=/dev/mtdblock2 rootfstype=jffs2 fbcon=rotate:1"
+CONFIG_CMDLINE="root=/dev/mtdblock2 rootfstype=jffs2 fbcon=rotate:1"
 CONFIG_FPE_NWFPE=y
 CONFIG_PM=y
 # CONFIG_SWAP is not set
diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 9a57763a8d38..b53ae2c052fc 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -32,7 +32,7 @@ CONFIG_SMP=y
 CONFIG_ARM_PSCI=y
 CONFIG_HIGHMEM=y
 CONFIG_ARCH_FORCE_MAX_ORDER=13
-CONFIG_CMDLINE="noinitrd console=ttymxc0,115200"
+CONFIG_CMDLINE="console=ttymxc0,115200"
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_STAT=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
diff --git a/arch/arm/configs/neponset_defconfig b/arch/arm/configs/neponset_defconfig
index 4d720001c12e..a61eb27373a8 100644
--- a/arch/arm/configs/neponset_defconfig
+++ b/arch/arm/configs/neponset_defconfig
@@ -9,7 +9,7 @@ CONFIG_ASSABET_NEPONSET=y
 CONFIG_ZBOOT_ROM_TEXT=0x80000
 CONFIG_ZBOOT_ROM_BSS=0xc1000000
 CONFIG_ZBOOT_ROM=y
-CONFIG_CMDLINE="console=ttySA0,38400n8 cpufreq=221200 rw root=/dev/mtdblock2 mtdparts=sa1100:512K(boot),1M(kernel),2560K(initrd),4M(root) mem=32M noinitrd initrd=0xc0800000,3M"
+CONFIG_CMDLINE="console=ttySA0,38400n8 cpufreq=221200 rw root=/dev/mtdblock2 mtdparts=sa1100:512K(boot),1M(kernel),2560K(initrd),4M(root) mem=32M initrd=0xc0800000,3M"
 CONFIG_FPE_NWFPE=y
 CONFIG_PM=y
 CONFIG_MODULES=y
diff --git a/arch/arm/configs/spitz_defconfig b/arch/arm/configs/spitz_defconfig
index ac2a0f998c73..8582b6f2cf9d 100644
--- a/arch/arm/configs/spitz_defconfig
+++ b/arch/arm/configs/spitz_defconfig
@@ -10,7 +10,7 @@ CONFIG_ARCH_PXA=y
 CONFIG_PXA_SHARPSL=y
 CONFIG_MACH_AKITA=y
 CONFIG_MACH_BORZOI=y
-CONFIG_CMDLINE="console=ttyS0,115200n8 console=tty1 noinitrd root=/dev/mtdblock2 rootfstype=jffs2   debug"
+CONFIG_CMDLINE="console=ttyS0,115200n8 console=tty1 root=/dev/mtdblock2 rootfstype=jffs2   debug"
 CONFIG_FPE_NWFPE=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 7aa2f9ad2935..6d89bf941d57 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -21,7 +21,6 @@ bool efi_nochunk;
 bool efi_nokaslr = !IS_ENABLED(CONFIG_RANDOMIZE_BASE);
 bool efi_novamap;
 
-static bool efi_noinitrd;
 static bool efi_nosoftreserve;
 static bool efi_disable_pci_dma = IS_ENABLED(CONFIG_EFI_DISABLE_PCI_DMA);
 
@@ -75,8 +74,6 @@ efi_status_t efi_parse_options(char const *cmdline)
 			efi_nokaslr = true;
 		} else if (!strcmp(param, "quiet")) {
 			efi_loglevel = CONSOLE_LOGLEVEL_QUIET;
-		} else if (!strcmp(param, "noinitrd")) {
-			efi_noinitrd = true;
 		} else if (IS_ENABLED(CONFIG_X86_64) && !strcmp(param, "no5lvl")) {
 			efi_no5lvl = true;
 		} else if (IS_ENABLED(CONFIG_ARCH_HAS_MEM_ENCRYPT) &&
@@ -614,7 +611,7 @@ efi_status_t efi_load_initrd(efi_loaded_image_t *image,
 	efi_status_t status = EFI_SUCCESS;
 	struct linux_efi_initrd initrd, *tbl;
 
-	if (!IS_ENABLED(CONFIG_BLK_DEV_INITRD) || efi_noinitrd)
+	if (!IS_ENABLED(CONFIG_BLK_DEV_INITRD))
 		return EFI_SUCCESS;
 
 	status = efi_load_initrd_dev_path(&initrd, hard_limit);
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 308744254c08..bec1c5d684a3 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -15,7 +15,6 @@
 unsigned long initrd_start, initrd_end;
 int initrd_below_start_ok;
 static unsigned int real_root_dev;	/* do_proc_dointvec cannot handle kdev_t */
-static int __initdata mount_initrd = 1;
 
 phys_addr_t phys_initrd_start __initdata;
 unsigned long phys_initrd_size __initdata;
@@ -39,14 +38,6 @@ static __init int kernel_do_mounts_initrd_sysctls_init(void)
 late_initcall(kernel_do_mounts_initrd_sysctls_init);
 #endif /* CONFIG_SYSCTL */
 
-static int __init no_initrd(char *str)
-{
-	mount_initrd = 0;
-	return 1;
-}
-
-__setup("noinitrd", no_initrd);
-
 static int __init early_initrdmem(char *p)
 {
 	phys_addr_t start;
-- 
2.47.2


