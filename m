Return-Path: <linux-fsdevel+bounces-61176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F7CB55C73
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 03:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 863291CC7DDF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 01:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED5E1A2C04;
	Sat, 13 Sep 2025 01:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0ScNvh0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225EF191F9C
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Sep 2025 01:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757725385; cv=none; b=vCNkNHKuiw081FTIwGDbyqHwthlVWpex7dLemuZzOSUMrs1Haugb2lza0kDMdufU+6pj46aWdqWiR/+ZQLl+qSfqpPlKt9hFkVuQMVov2e+Y0DpiquiAC4SInOtj8KN+sFyKC68Cp2SL1EbJfl9vf6s3DJCwlqIlac2zvRyVmqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757725385; c=relaxed/simple;
	bh=7gEBevABKdbz1juiJdjHLSN5JkwW9ymo+YvMgIW9ipA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O44qpL/q6iX3WFtCJgLkLI7sXPzSjocNdgVurxI8cZT6C4FA24tFw2BS0QIcQV27oA5SjGdFXVsu6pJZg0r+lj9fiP9q1+eEGvClOouDw7aLp80iI/l5d9Nt+veEga0wl0h2n11mqwOj4XnKrFFBOEYI5vV1ZIQsqaWsGqqNnxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0ScNvh0; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b0428b537e5so362979966b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 18:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757725377; x=1758330177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NF+T8e2PbYTcD1qVfLaQWGAohazGGctTG5y1SpryEQ8=;
        b=O0ScNvh0+cP6sT7JkadhC/QXUmObIpeSbY2fQIt03J010Zza+G4JFOaEZbHAvekfGB
         mco47PM/GT3Sfnxa0RfYloaWzE6GYSzMYtnBGhsNoukAn3wC0hea1bA1PoO/cC3YKdiL
         09mish++j5JwzrPRxkoWUWgnxDwtmM3yK8gib+NRuTdriA0pjp1JdH0lMCRZQVCI2cG+
         bYeDUTsagYkXm6qdmBztzg2jyFy1VW28x/aVivC8k/jcaEW/pxLhDXt5EEjoCx257EkS
         ULhalASsUHhwBiBGb+9Txqlg0Z5wWYVXtyFXMCP7OnumslAHH2smyAPbboz9wvtbaVK9
         tTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757725377; x=1758330177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NF+T8e2PbYTcD1qVfLaQWGAohazGGctTG5y1SpryEQ8=;
        b=fYoXIneWymZtieLXzxoiILQ+/2WiDJJYbFQdgjlf7Oz79nYpHu/SJvMPPK0BIDIY00
         KMzpv3fKcTDVTnVOao7HZhSm3nkCxc7A1iuTUvGw7kYrrGedJelG8sYzEr34ZUT1aZan
         3W7xfSJOkjf94JTFIqerFpk/en1N54sMaPkaRumkwvj2+61aT2BdZpmKioBPQdD3ZVce
         sZdc0eDfnu/NzX/z5lL3w7BKI8PGGgSPj7n0g3Y7+kdq9KtuOAWUw3QzEZE+dK1jPCI1
         C4ANSZF6SlsG/JQwMgGqbN9FECiBQI9TxNJEl5Ysk1gzk1F8R+0uQ8TM/sVsZnaU8i9v
         2fgw==
X-Gm-Message-State: AOJu0YxttwHEwXRrTsvPx3fjnTzGUYUXzv50zZhtnSdjjerxjn8KQNog
	ySjQs+BCga83upOJ+AhE22lg1PlgFZfwBg34tecPFHg0UmOLWUbJrZ/HjW/ybTt/
X-Gm-Gg: ASbGnctJTESJK5wXRAotrMkr+qc+dX04QdDjDVe7CZ7ZZpl41o5gIDEkW66tZLor+s0
	mp5lxXhNWQmiXRChBLWE5K5XjWtkPInt70EiNNlAHKteSZLJIIaZ4ypTnyupIbmzGfJap2NpGzU
	zY4BuEYeylJWOzGSCcEouCcWY3c/mEnMQvRUmskdURg9B6iEh5eSvENgp22XWKy6tnISfhrCEqt
	knYeLdjxp68ag4TcnlBFjW6imoCoqmPELkiWKi24kCDyRdvKCHZYn8WatExH/rMUzilsM9Px65E
	KJx/Cjf67LMYNQDhZwNN/vCGP3xfKqjYbNaGByQytsL+ehY+OvnnPvgXGpJfH7cQglSbTr13KQe
	rXdH2DzvoD9+AiVOl4ReJL5nB3Ad+IH6cVWs7ceFu
X-Google-Smtp-Source: AGHT+IFAenQpr+eqgUw7A0V0nlBuRy0elv8T6Skb87OgHRBdD5XZP8Q5CVFdy6An9tI7tJa4OQ9j+A==
X-Received: by 2002:a17:907:d19:b0:b07:88d0:b with SMTP id a640c23a62f3a-b07c3acc5c1mr462636966b.63.1757725376510;
        Fri, 12 Sep 2025 18:02:56 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b3128525sm468738866b.31.2025.09.12.18.02.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 18:02:56 -0700 (PDT)
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
Subject: [PATCH RESEND 21/62] init: remove all mentions of root=/dev/ram*
Date: Sat, 13 Sep 2025 00:38:00 +0000
Message-ID: <20250913003842.41944-22-safinaskar@gmail.com>
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

Initrd support is removed, so root=/dev/ram* is never correct

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt          | 3 +--
 Documentation/arch/m68k/kernel-options.rst               | 9 ++-------
 arch/arm/boot/dts/arm/integratorap.dts                   | 2 +-
 arch/arm/boot/dts/arm/integratorcp.dts                   | 2 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-cmm.dts     | 2 +-
 .../boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dts    | 2 +-
 .../arm/boot/dts/aspeed/aspeed-bmc-facebook-minipack.dts | 2 +-
 .../arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge100.dts | 2 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge40.dts | 2 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yamp.dts    | 2 +-
 .../boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi  | 2 +-
 arch/arm/boot/dts/hisilicon/hi3620-hi4511.dts            | 2 +-
 .../boot/dts/intel/ixp/intel-ixp42x-welltech-epbx100.dts | 2 +-
 arch/arm/boot/dts/nspire/nspire-classic.dtsi             | 2 +-
 arch/arm/boot/dts/nspire/nspire-cx.dts                   | 2 +-
 arch/arm/boot/dts/samsung/exynos4210-origen.dts          | 2 +-
 arch/arm/boot/dts/samsung/exynos4210-smdkv310.dts        | 2 +-
 arch/arm/boot/dts/samsung/exynos4412-smdk4412.dts        | 2 +-
 arch/arm/boot/dts/samsung/exynos5250-smdk5250.dts        | 2 +-
 arch/arm/boot/dts/st/ste-nomadik-nhk15.dts               | 2 +-
 arch/arm/boot/dts/st/ste-nomadik-s8815.dts               | 2 +-
 arch/arm/boot/dts/st/stm32429i-eval.dts                  | 2 +-
 arch/arm/boot/dts/st/stm32746g-eval.dts                  | 2 +-
 arch/arm/boot/dts/st/stm32f429-disco.dts                 | 2 +-
 arch/arm/boot/dts/st/stm32f469-disco.dts                 | 2 +-
 arch/arm/boot/dts/st/stm32f746-disco.dts                 | 2 +-
 arch/arm/boot/dts/st/stm32f769-disco.dts                 | 2 +-
 arch/arm/boot/dts/st/stm32h743i-disco.dts                | 2 +-
 arch/arm/boot/dts/st/stm32h743i-eval.dts                 | 2 +-
 arch/arm/boot/dts/st/stm32h747i-disco.dts                | 2 +-
 arch/arm/boot/dts/st/stm32h750i-art-pi.dts               | 2 +-
 arch/arm/configs/assabet_defconfig                       | 2 +-
 arch/arm/configs/at91_dt_defconfig                       | 2 +-
 arch/arm/configs/exynos_defconfig                        | 2 +-
 arch/arm/configs/lpc32xx_defconfig                       | 2 +-
 arch/arm/configs/pxa_defconfig                           | 2 +-
 arch/arm/configs/s3c6400_defconfig                       | 2 +-
 arch/arm/configs/s5pv210_defconfig                       | 2 +-
 arch/arm/configs/sama5_defconfig                         | 2 +-
 arch/arm/configs/u8500_defconfig                         | 2 +-
 arch/parisc/defpalo.conf                                 | 2 +-
 arch/s390/boot/ipl_parm.c                                | 2 +-
 arch/xtensa/Kconfig                                      | 2 +-
 arch/xtensa/boot/dts/csp.dts                             | 2 +-
 44 files changed, 45 insertions(+), 51 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e862a7b1d2ec..a259f2bdba0f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6407,8 +6407,7 @@
 			Usually this is a block device specifier of some kind,
 			see the early_lookup_bdev comment in
 			block/early-lookup.c for details.
-			Alternatively this can be "ram" for the legacy initial
-			ramdisk, "nfs" and "cifs" for root on a network file
+			Alternatively this can be "nfs" and "cifs" for root on a network file
 			system, or "mtd" and "ubi" for mounting from raw flash.
 
 	rootdelay=	[KNL] Delay (in seconds) to pause before attempting to
diff --git a/Documentation/arch/m68k/kernel-options.rst b/Documentation/arch/m68k/kernel-options.rst
index f6469ebeb2c7..a508ee8efa8b 100644
--- a/Documentation/arch/m68k/kernel-options.rst
+++ b/Documentation/arch/m68k/kernel-options.rst
@@ -73,7 +73,6 @@ hardcoded name to number mappings. The name must always be a
 combination of two or three letters, followed by a decimal number.
 Valid names are::
 
-  /dev/ram: -> 0x0100 (initial ramdisk)
   /dev/hda: -> 0x0300 (first IDE disk)
   /dev/hdb: -> 0x0340 (second IDE disk)
   /dev/sda: -> 0x0800 (first SCSI disk)
@@ -86,12 +85,8 @@ Valid names are::
 The name must be followed by a decimal number, that stands for the
 partition number. Internally, the value of the number is just
 added to the device number mentioned in the table above. The
-exceptions are /dev/ram and /dev/fd, where /dev/ram refers to an
-initial ramdisk loaded by your bootstrap program (please consult the
-instructions for your bootstrap program to find out how to load an
-initial ramdisk). As of kernel version 2.0.18 you must specify
-/dev/ram as the root device if you want to boot from an initial
-ramdisk. For the floppy devices, /dev/fd, the number stands for the
+exception is /dev/fd.
+For the floppy devices, /dev/fd, the number stands for the
 floppy drive number (there are no partitions on floppy disks). I.e.,
 /dev/fd0 stands for the first drive, /dev/fd1 for the second, and so
 on. Since the number is just added, you can also force the disk format
diff --git a/arch/arm/boot/dts/arm/integratorap.dts b/arch/arm/boot/dts/arm/integratorap.dts
index 9b6a1dbaf265..2e43a8291d40 100644
--- a/arch/arm/boot/dts/arm/integratorap.dts
+++ b/arch/arm/boot/dts/arm/integratorap.dts
@@ -53,7 +53,7 @@ aliases {
 	};
 
 	chosen {
-		bootargs = "root=/dev/ram0 console=ttyAM0,38400n8 earlyprintk";
+		bootargs = "console=ttyAM0,38400n8 earlyprintk";
 	};
 
 	/* 24 MHz chrystal on the Integrator/AP development board */
diff --git a/arch/arm/boot/dts/arm/integratorcp.dts b/arch/arm/boot/dts/arm/integratorcp.dts
index 8ad1a8957ace..2ac140741752 100644
--- a/arch/arm/boot/dts/arm/integratorcp.dts
+++ b/arch/arm/boot/dts/arm/integratorcp.dts
@@ -11,7 +11,7 @@ / {
 	compatible = "arm,integrator-cp";
 
 	chosen {
-		bootargs = "root=/dev/ram0 console=ttyAMA0,38400n8 earlyprintk";
+		bootargs = "console=ttyAMA0,38400n8 earlyprintk";
 	};
 
 	cpus {
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-cmm.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-cmm.dts
index 24153868cc00..f4ae167e89f0 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-cmm.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-cmm.dts
@@ -280,7 +280,7 @@ aliases {
 
 	chosen {
 		stdout-path = &uart1;
-		bootargs = "console=ttyS1,9600n8 root=/dev/ram rw earlycon";
+		bootargs = "console=ttyS1,9600n8 rw earlycon";
 	};
 
 	ast-adc-hwmon {
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dts
index 60e875ac2461..d51ee3aaa461 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dts
@@ -10,7 +10,7 @@ / {
 
 	chosen {
 		stdout-path = &uart5;
-		bootargs = "console=ttyS0,9600n8 root=/dev/ram rw";
+		bootargs = "console=ttyS0,9600n8 rw";
 	};
 
 	ast-adc-hwmon {
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minipack.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minipack.dts
index aafd1042b6e5..4233d0d857b8 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minipack.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minipack.dts
@@ -230,7 +230,7 @@ aliases {
 
 	chosen {
 		stdout-path = &uart1;
-		bootargs = "debug console=ttyS1,9600n8 root=/dev/ram rw";
+		bootargs = "debug console=ttyS1,9600n8 rw";
 	};
 };
 
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge100.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge100.dts
index 97cd11c3d9a5..23f9d1c690f8 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge100.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge100.dts
@@ -10,7 +10,7 @@ / {
 
 	chosen {
 		stdout-path = &uart3;
-		bootargs = "console=ttyS2,9600n8 root=/dev/ram rw";
+		bootargs = "console=ttyS2,9600n8 rw";
 	};
 
 	ast-adc-hwmon {
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge40.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge40.dts
index 6624855d8ebd..e9b1b51f9f7a 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge40.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge40.dts
@@ -10,7 +10,7 @@ / {
 
 	chosen {
 		stdout-path = &uart3;
-		bootargs = "console=ttyS2,9600n8 root=/dev/ram rw";
+		bootargs = "console=ttyS2,9600n8 rw";
 	};
 
 	ast-adc-hwmon {
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yamp.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yamp.dts
index 98fe0d6c8188..578ca0dc9647 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yamp.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yamp.dts
@@ -21,7 +21,7 @@ aliases {
 
 	chosen {
 		stdout-path = &uart5;
-		bootargs = "console=ttyS0,9600n8 root=/dev/ram rw";
+		bootargs = "console=ttyS0,9600n8 rw";
 	};
 };
 
diff --git a/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi b/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
index 00e5887c926f..3dbf0cc70f48 100644
--- a/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
+++ b/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
@@ -12,7 +12,7 @@ aliases {
 	};
 
 	chosen {
-		bootargs = "console=ttyS0,9600n8 root=/dev/ram rw vmalloc=640M";
+		bootargs = "console=ttyS0,9600n8 rw vmalloc=640M";
 	};
 
 	memory@80000000 {
diff --git a/arch/arm/boot/dts/hisilicon/hi3620-hi4511.dts b/arch/arm/boot/dts/hisilicon/hi3620-hi4511.dts
index f1c816a1d7cf..bbd62c6ad280 100644
--- a/arch/arm/boot/dts/hisilicon/hi3620-hi4511.dts
+++ b/arch/arm/boot/dts/hisilicon/hi3620-hi4511.dts
@@ -13,7 +13,7 @@ / {
 	compatible = "hisilicon,hi3620-hi4511";
 
 	chosen {
-		bootargs = "root=/dev/ram0";
+		bootargs = "";
 		stdout-path = "serial0:115200n8";
 	};
 
diff --git a/arch/arm/boot/dts/intel/ixp/intel-ixp42x-welltech-epbx100.dts b/arch/arm/boot/dts/intel/ixp/intel-ixp42x-welltech-epbx100.dts
index c550c421b659..96105137a364 100644
--- a/arch/arm/boot/dts/intel/ixp/intel-ixp42x-welltech-epbx100.dts
+++ b/arch/arm/boot/dts/intel/ixp/intel-ixp42x-welltech-epbx100.dts
@@ -20,7 +20,7 @@ memory@0 {
 	};
 
 	chosen {
-		bootargs = "console=ttyS0,115200n8 root=/dev/ram0 initrd=0x00800000,9M";
+		bootargs = "console=ttyS0,115200n8 initrd=0x00800000,9M";
 		stdout-path = "uart0:115200n8";
 	};
 
diff --git a/arch/arm/boot/dts/nspire/nspire-classic.dtsi b/arch/arm/boot/dts/nspire/nspire-classic.dtsi
index 0ee53d3ecd54..224cf5921e26 100644
--- a/arch/arm/boot/dts/nspire/nspire-classic.dtsi
+++ b/arch/arm/boot/dts/nspire/nspire-classic.dtsi
@@ -81,6 +81,6 @@ panel_in: endpoint {
 		};
 	};
 	chosen {
-		bootargs = "debug earlyprintk console=tty0 console=ttyS0,115200n8 root=/dev/ram0";
+		bootargs = "debug earlyprintk console=tty0 console=ttyS0,115200n8";
 	};
 };
diff --git a/arch/arm/boot/dts/nspire/nspire-cx.dts b/arch/arm/boot/dts/nspire/nspire-cx.dts
index debeff0ec010..08155d15cca9 100644
--- a/arch/arm/boot/dts/nspire/nspire-cx.dts
+++ b/arch/arm/boot/dts/nspire/nspire-cx.dts
@@ -165,6 +165,6 @@ panel_in: endpoint {
 		};
 	};
 	chosen {
-		bootargs = "debug earlyprintk console=tty0 console=ttyAMA0,115200n8 root=/dev/ram0";
+		bootargs = "debug earlyprintk console=tty0 console=ttyAMA0,115200n8";
 	};
 };
diff --git a/arch/arm/boot/dts/samsung/exynos4210-origen.dts b/arch/arm/boot/dts/samsung/exynos4210-origen.dts
index 4dcf794bd18b..b714073143e7 100644
--- a/arch/arm/boot/dts/samsung/exynos4210-origen.dts
+++ b/arch/arm/boot/dts/samsung/exynos4210-origen.dts
@@ -36,7 +36,7 @@ aliases {
 	};
 
 	chosen {
-		bootargs = "root=/dev/ram0 rw initrd=0x41000000,8M init=/linuxrc";
+		bootargs = "rw initrd=0x41000000,8M init=/linuxrc";
 		stdout-path = "serial2:115200n8";
 	};
 
diff --git a/arch/arm/boot/dts/samsung/exynos4210-smdkv310.dts b/arch/arm/boot/dts/samsung/exynos4210-smdkv310.dts
index 4cdeddeff3fc..2a3c2a4c0e90 100644
--- a/arch/arm/boot/dts/samsung/exynos4210-smdkv310.dts
+++ b/arch/arm/boot/dts/samsung/exynos4210-smdkv310.dts
@@ -30,7 +30,7 @@ aliases {
 	};
 
 	chosen {
-		bootargs = "root=/dev/ram0 rw initrd=0x41000000,8M init=/linuxrc";
+		bootargs = "rw initrd=0x41000000,8M init=/linuxrc";
 		stdout-path = "serial1:115200n8";
 	};
 
diff --git a/arch/arm/boot/dts/samsung/exynos4412-smdk4412.dts b/arch/arm/boot/dts/samsung/exynos4412-smdk4412.dts
index 4b18cc55d6ca..920af4f91c75 100644
--- a/arch/arm/boot/dts/samsung/exynos4412-smdk4412.dts
+++ b/arch/arm/boot/dts/samsung/exynos4412-smdk4412.dts
@@ -27,7 +27,7 @@ aliases {
 	};
 
 	chosen {
-		bootargs = "root=/dev/ram0 rw initrd=0x41000000,8M init=/linuxrc";
+		bootargs = "rw initrd=0x41000000,8M init=/linuxrc";
 		stdout-path = "serial1:115200n8";
 	};
 
diff --git a/arch/arm/boot/dts/samsung/exynos5250-smdk5250.dts b/arch/arm/boot/dts/samsung/exynos5250-smdk5250.dts
index 4164c7c2a3eb..e5cfff1ffad0 100644
--- a/arch/arm/boot/dts/samsung/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/samsung/exynos5250-smdk5250.dts
@@ -27,7 +27,7 @@ memory@40000000 {
 	};
 
 	chosen {
-		bootargs = "root=/dev/ram0 rw initrd=0x41000000,8M init=/linuxrc";
+		bootargs = "rw initrd=0x41000000,8M init=/linuxrc";
 		stdout-path = "serial2:115200n8";
 	};
 
diff --git a/arch/arm/boot/dts/st/ste-nomadik-nhk15.dts b/arch/arm/boot/dts/st/ste-nomadik-nhk15.dts
index cdff33063d6f..8a22425cdb78 100644
--- a/arch/arm/boot/dts/st/ste-nomadik-nhk15.dts
+++ b/arch/arm/boot/dts/st/ste-nomadik-nhk15.dts
@@ -13,7 +13,7 @@ / {
 	compatible = "st,nomadik-nhk-15";
 
 	chosen {
-		bootargs = "root=/dev/ram0 console=ttyAMA1,115200n8 earlyprintk";
+		bootargs = "console=ttyAMA1,115200n8 earlyprintk";
 	};
 
 	aliases {
diff --git a/arch/arm/boot/dts/st/ste-nomadik-s8815.dts b/arch/arm/boot/dts/st/ste-nomadik-s8815.dts
index c905c2643a12..7f418d8a2370 100644
--- a/arch/arm/boot/dts/st/ste-nomadik-s8815.dts
+++ b/arch/arm/boot/dts/st/ste-nomadik-s8815.dts
@@ -13,7 +13,7 @@ / {
 	compatible = "calaosystems,usb-s8815";
 
 	chosen {
-		bootargs = "root=/dev/ram0 console=ttyAMA1,115200n8 earlyprintk";
+		bootargs = "console=ttyAMA1,115200n8 earlyprintk";
 	};
 
 	aliases {
diff --git a/arch/arm/boot/dts/st/stm32429i-eval.dts b/arch/arm/boot/dts/st/stm32429i-eval.dts
index afa417b34b25..7e8834af20c6 100644
--- a/arch/arm/boot/dts/st/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/st/stm32429i-eval.dts
@@ -57,7 +57,7 @@ / {
 	compatible = "st,stm32429i-eval", "st,stm32f429";
 
 	chosen {
-		bootargs = "root=/dev/ram";
+		bootargs = "";
 		stdout-path = "serial0:115200n8";
 	};
 
diff --git a/arch/arm/boot/dts/st/stm32746g-eval.dts b/arch/arm/boot/dts/st/stm32746g-eval.dts
index e9ac37b6eca0..43a52b26fdaa 100644
--- a/arch/arm/boot/dts/st/stm32746g-eval.dts
+++ b/arch/arm/boot/dts/st/stm32746g-eval.dts
@@ -51,7 +51,7 @@ / {
 	compatible = "st,stm32746g-eval", "st,stm32f746";
 
 	chosen {
-		bootargs = "root=/dev/ram";
+		bootargs = "";
 		stdout-path = "serial0:115200n8";
 	};
 
diff --git a/arch/arm/boot/dts/st/stm32f429-disco.dts b/arch/arm/boot/dts/st/stm32f429-disco.dts
index a3cb4aabdd5a..68d822d79988 100644
--- a/arch/arm/boot/dts/st/stm32f429-disco.dts
+++ b/arch/arm/boot/dts/st/stm32f429-disco.dts
@@ -57,7 +57,7 @@ / {
 	compatible = "st,stm32f429i-disco", "st,stm32f429";
 
 	chosen {
-		bootargs = "root=/dev/ram";
+		bootargs = "";
 		stdout-path = "serial0:115200n8";
 	};
 
diff --git a/arch/arm/boot/dts/st/stm32f469-disco.dts b/arch/arm/boot/dts/st/stm32f469-disco.dts
index 8a4f8ddd083d..31b4abbc608d 100644
--- a/arch/arm/boot/dts/st/stm32f469-disco.dts
+++ b/arch/arm/boot/dts/st/stm32f469-disco.dts
@@ -56,7 +56,7 @@ / {
 	compatible = "st,stm32f469i-disco", "st,stm32f469";
 
 	chosen {
-		bootargs = "root=/dev/ram";
+		bootargs = "";
 		stdout-path = "serial0:115200n8";
 	};
 
diff --git a/arch/arm/boot/dts/st/stm32f746-disco.dts b/arch/arm/boot/dts/st/stm32f746-disco.dts
index b57dbdce2f40..3cb04547228e 100644
--- a/arch/arm/boot/dts/st/stm32f746-disco.dts
+++ b/arch/arm/boot/dts/st/stm32f746-disco.dts
@@ -52,7 +52,7 @@ / {
 	compatible = "st,stm32f746-disco", "st,stm32f746";
 
 	chosen {
-		bootargs = "root=/dev/ram";
+		bootargs = "";
 		stdout-path = "serial0:115200n8";
 	};
 
diff --git a/arch/arm/boot/dts/st/stm32f769-disco.dts b/arch/arm/boot/dts/st/stm32f769-disco.dts
index 535cfdc4681c..13f96ee0b3de 100644
--- a/arch/arm/boot/dts/st/stm32f769-disco.dts
+++ b/arch/arm/boot/dts/st/stm32f769-disco.dts
@@ -51,7 +51,7 @@ / {
 	compatible = "st,stm32f769-disco", "st,stm32f769";
 
 	chosen {
-		bootargs = "root=/dev/ram";
+		bootargs = "";
 		stdout-path = "serial0:115200n8";
 	};
 
diff --git a/arch/arm/boot/dts/st/stm32h743i-disco.dts b/arch/arm/boot/dts/st/stm32h743i-disco.dts
index 8451a54a9a08..8bdb24fcf0c7 100644
--- a/arch/arm/boot/dts/st/stm32h743i-disco.dts
+++ b/arch/arm/boot/dts/st/stm32h743i-disco.dts
@@ -49,7 +49,7 @@ / {
 	compatible = "st,stm32h743i-disco", "st,stm32h743";
 
 	chosen {
-		bootargs = "root=/dev/ram";
+		bootargs = "";
 		stdout-path = "serial0:115200n8";
 	};
 
diff --git a/arch/arm/boot/dts/st/stm32h743i-eval.dts b/arch/arm/boot/dts/st/stm32h743i-eval.dts
index 4b0ced27b80e..c3de36d94acf 100644
--- a/arch/arm/boot/dts/st/stm32h743i-eval.dts
+++ b/arch/arm/boot/dts/st/stm32h743i-eval.dts
@@ -49,7 +49,7 @@ / {
 	compatible = "st,stm32h743i-eval", "st,stm32h743";
 
 	chosen {
-		bootargs = "root=/dev/ram";
+		bootargs = "";
 		stdout-path = "serial0:115200n8";
 	};
 
diff --git a/arch/arm/boot/dts/st/stm32h747i-disco.dts b/arch/arm/boot/dts/st/stm32h747i-disco.dts
index 99f0255dae8e..a57341e2d95c 100644
--- a/arch/arm/boot/dts/st/stm32h747i-disco.dts
+++ b/arch/arm/boot/dts/st/stm32h747i-disco.dts
@@ -14,7 +14,7 @@ / {
 	compatible = "st,stm32h747i-disco", "st,stm32h747";
 
 	chosen {
-		bootargs = "root=/dev/ram";
+		bootargs = "";
 		stdout-path = "serial0:115200n8";
 	};
 
diff --git a/arch/arm/boot/dts/st/stm32h750i-art-pi.dts b/arch/arm/boot/dts/st/stm32h750i-art-pi.dts
index 56c53e262da7..b4bd8315464c 100644
--- a/arch/arm/boot/dts/st/stm32h750i-art-pi.dts
+++ b/arch/arm/boot/dts/st/stm32h750i-art-pi.dts
@@ -54,7 +54,7 @@ / {
 	compatible = "st,stm32h750i-art-pi", "st,stm32h750";
 
 	chosen {
-		bootargs = "root=/dev/ram";
+		bootargs = "";
 		stdout-path = "serial0:2000000n8";
 	};
 
diff --git a/arch/arm/configs/assabet_defconfig b/arch/arm/configs/assabet_defconfig
index 07ab9eaac4af..56fce6c08945 100644
--- a/arch/arm/configs/assabet_defconfig
+++ b/arch/arm/configs/assabet_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_MULTI_V4=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_ASSABET=y
-CONFIG_CMDLINE="mem=32M console=ttySA0,38400n8 initrd=0xc0800000,3M root=/dev/ram"
+CONFIG_CMDLINE="mem=32M console=ttySA0,38400n8 initrd=0xc0800000,3M"
 CONFIG_FPE_NWFPE=y
 CONFIG_PM=y
 CONFIG_MODULES=y
diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index ff13e1ecf4bb..b53c7906d317 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -23,7 +23,7 @@ CONFIG_UACCESS_WITH_MEMCPY=y
 # CONFIG_ATAGS is not set
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
-CONFIG_CMDLINE="console=ttyS0,115200 initrd=0x21100000,25165824 root=/dev/ram0 rw"
+CONFIG_CMDLINE="console=ttyS0,115200 initrd=0x21100000,25165824 rw"
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 77d3521f55d4..02a903816baa 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -15,7 +15,7 @@ CONFIG_HIGHMEM=y
 CONFIG_SECCOMP=y
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
-CONFIG_CMDLINE="root=/dev/ram0 rw initrd=0x41000000,8M console=ttySAC1,115200 init=/linuxrc mem=256M"
+CONFIG_CMDLINE="rw initrd=0x41000000,8M console=ttySAC1,115200 init=/linuxrc mem=256M"
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_STAT=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
diff --git a/arch/arm/configs/lpc32xx_defconfig b/arch/arm/configs/lpc32xx_defconfig
index 9afccd76446b..a98d1125b9aa 100644
--- a/arch/arm/configs/lpc32xx_defconfig
+++ b/arch/arm/configs/lpc32xx_defconfig
@@ -13,7 +13,7 @@ CONFIG_ARCH_LPC32XX=y
 CONFIG_AEABI=y
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
-CONFIG_CMDLINE="console=ttyS0,115200n81 root=/dev/ram0"
+CONFIG_CMDLINE="console=ttyS0,115200n81"
 CONFIG_CPU_IDLE=y
 CONFIG_VFP=y
 CONFIG_JUMP_LABEL=y
diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
index 1a80602c1284..0c4b9389d4d6 100644
--- a/arch/arm/configs/pxa_defconfig
+++ b/arch/arm/configs/pxa_defconfig
@@ -22,7 +22,7 @@ CONFIG_MACH_AKITA=y
 CONFIG_MACH_BORZOI=y
 CONFIG_AEABI=y
 CONFIG_ARCH_FORCE_MAX_ORDER=8
-CONFIG_CMDLINE="root=/dev/ram0 ro"
+CONFIG_CMDLINE="ro"
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_STAT=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
diff --git a/arch/arm/configs/s3c6400_defconfig b/arch/arm/configs/s3c6400_defconfig
index 23635d5b9322..a5018ce274ec 100644
--- a/arch/arm/configs/s3c6400_defconfig
+++ b/arch/arm/configs/s3c6400_defconfig
@@ -4,7 +4,7 @@ CONFIG_ARCH_MULTI_V6=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_S3C64XX=y
 CONFIG_MACH_WLF_CRAGG_6410=y
-CONFIG_CMDLINE="console=ttySAC0,115200 root=/dev/ram init=/linuxrc initrd=0x51000000,6M"
+CONFIG_CMDLINE="console=ttySAC0,115200 init=/linuxrc initrd=0x51000000,6M"
 CONFIG_VFP=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/arch/arm/configs/s5pv210_defconfig b/arch/arm/configs/s5pv210_defconfig
index 8ec82d9b51e4..485dd5174c62 100644
--- a/arch/arm/configs/s5pv210_defconfig
+++ b/arch/arm/configs/s5pv210_defconfig
@@ -8,7 +8,7 @@ CONFIG_KALLSYMS_ALL=y
 CONFIG_ARCH_S5PV210=y
 CONFIG_VMSPLIT_2G=y
 CONFIG_ARM_APPENDED_DTB=y
-CONFIG_CMDLINE="root=/dev/ram0 rw initrd=0x20800000,8M console=ttySAC1,115200 init=/linuxrc"
+CONFIG_CMDLINE="rw initrd=0x20800000,8M console=ttySAC1,115200 init=/linuxrc"
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_STAT=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index 2cad045e1d8d..0463ff84c06c 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -14,7 +14,7 @@ CONFIG_SOC_SAMA5D4=y
 # CONFIG_ATMEL_CLOCKSOURCE_PIT is not set
 CONFIG_UACCESS_WITH_MEMCPY=y
 # CONFIG_ATAGS is not set
-CONFIG_CMDLINE="console=ttyS0,115200 initrd=0x21100000,25165824 root=/dev/ram0 rw"
+CONFIG_CMDLINE="console=ttyS0,115200 initrd=0x21100000,25165824 rw"
 CONFIG_VFP=y
 CONFIG_NEON=y
 CONFIG_KERNEL_MODE_NEON=y
diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
index 0f55815eecb3..510c760b0bc7 100644
--- a/arch/arm/configs/u8500_defconfig
+++ b/arch/arm/configs/u8500_defconfig
@@ -9,7 +9,7 @@ CONFIG_NR_CPUS=2
 CONFIG_HIGHMEM=y
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
-CONFIG_CMDLINE="root=/dev/ram0 console=ttyAMA2,115200n8"
+CONFIG_CMDLINE="console=ttyAMA2,115200n8"
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_GOV_ONDEMAND=y
 CONFIG_CPUFREQ_DT=y
diff --git a/arch/parisc/defpalo.conf b/arch/parisc/defpalo.conf
index 208ff3b41487..86c9a132cb92 100644
--- a/arch/parisc/defpalo.conf
+++ b/arch/parisc/defpalo.conf
@@ -12,7 +12,7 @@
 # If you want a root ramdisk, use the next 2 lines
 #   (Edit the ramdisk image name!!!!)
 --ramdisk=ram-disk-image-file
---commandline=0/vmlinuz HOME=/ root=/dev/ram initrd=0/ramdisk panic_timeout=60 panic=-1
+--commandline=0/vmlinuz HOME=/ initrd=0/ramdisk panic_timeout=60 panic=-1
 
 # If you want NFS root, use the following command line (Edit the HOSTNAME!!!)
 #--commandline=0/vmlinuz HOME=/ root=/dev/nfs nfsroot=HOSTNAME ip=bootp
diff --git a/arch/s390/boot/ipl_parm.c b/arch/s390/boot/ipl_parm.c
index f584d7da29cb..47fc2a7ed551 100644
--- a/arch/s390/boot/ipl_parm.c
+++ b/arch/s390/boot/ipl_parm.c
@@ -18,7 +18,7 @@
 struct parmarea parmarea __section(".parmarea") = {
 	.kernel_version		= (unsigned long)kernel_version,
 	.max_command_line_size	= COMMAND_LINE_SIZE,
-	.command_line		= "root=/dev/ram0 ro",
+	.command_line		= "ro",
 };
 
 char __bootdata(early_command_line)[COMMAND_LINE_SIZE];
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index f2f9cd9cde50..e8e579160c6b 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -448,7 +448,7 @@ config CMDLINE_BOOL
 config CMDLINE
 	string "Initial kernel command string"
 	depends on CMDLINE_BOOL
-	default "console=ttyS0,38400 root=/dev/ram"
+	default "console=ttyS0,38400"
 	help
 	  On some architectures (EBSA110 and CATS), there is currently no way
 	  for the boot loader to pass arguments to the kernel. For these
diff --git a/arch/xtensa/boot/dts/csp.dts b/arch/xtensa/boot/dts/csp.dts
index 885495460f7e..c7e07dd0d7d0 100644
--- a/arch/xtensa/boot/dts/csp.dts
+++ b/arch/xtensa/boot/dts/csp.dts
@@ -8,7 +8,7 @@ / {
 	interrupt-parent = <&pic>;
 
 	chosen {
-		bootargs = "earlycon=cdns,0xfd000000,115200 console=tty0 console=ttyPS0,115200 root=/dev/ram0 rw earlyprintk xilinx_uartps.rx_trigger_level=32 loglevel=8 nohz=off ignore_loglevel";
+		bootargs = "earlycon=cdns,0xfd000000,115200 console=tty0 console=ttyPS0,115200 rw earlyprintk xilinx_uartps.rx_trigger_level=32 loglevel=8 nohz=off ignore_loglevel";
 	};
 
 	memory@0 {
-- 
2.47.2


