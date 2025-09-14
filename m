Return-Path: <linux-fsdevel+bounces-61221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68814B564FD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 05:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A02B27B2D5D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 03:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D829271458;
	Sun, 14 Sep 2025 03:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGAFrY/9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465E226B2A5
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Sep 2025 03:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757821986; cv=none; b=CIKMn/X1EdMGL7knj5NRB3inzj6TsMyEhJvfzsVm+eVdepU8pJTbIUhVEIJaodtPkOO9SLzFHCqjPXbAXH4ZqRAD47XczzZT4VFE2qAJQs58mmL5UaEruw8JFViJwsqfqlpaMbJ4FXuZwolypU5PPSzdp3ba76sJxXFT1trHqpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757821986; c=relaxed/simple;
	bh=LMgtS7zLTnFefTUU75+3aHu+RqXM9pA5ZmIuER5pXRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FkExSzWR6uI9deqIXQ4xUSd5avdyFsXXuP9+ZTO03tLod81nlg4g11pW7kK1iSVoV0YAcjynbt/YwbqqrnWPUSQ3f3WZWe+XxLtBTVy2RILQLO7Jz0xFFslr005zykUEhgpDBHEMBnZP+eZuYko/txYR6icg72zxEDRQWE3blLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGAFrY/9; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b00a9989633so588978266b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Sep 2025 20:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757821976; x=1758426776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GGxQFMp8lGOCxr3zDvSjgZrq/vjHM87qRoa1426bdXU=;
        b=NGAFrY/9JS0garmprNdYDLpoSl+05ArBpyrAC9xS6+OBhZJqt4D6qDDvvlN1rzWAmE
         GsK3GA8sF7Zf8GHy2l8eYTu5WOK0yvicuhs2wvZsyXE/EDPE/8t+BOHkOBiNGOuR6gSJ
         Gr4xUFSrxZYgFI20q95DckoE1FCMdYbWcHntvl6xINZ9TDhOO6pbdFiBuhdWsoOw9Ofn
         APH6UcRzk8zkCZW+Ra1a6YBF2nG0bx/6WvZRVngSYbA/1+QDjLX2jGOwTyGv0fO3RSUo
         OYnrbbFXoHeLjhCKpK70s+Zunp56Xz8JOZxMc6pjWtTx+Rjyif9MTafRSExa8CneEFYc
         8CWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757821976; x=1758426776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GGxQFMp8lGOCxr3zDvSjgZrq/vjHM87qRoa1426bdXU=;
        b=ggfmUA2st7hWhNrDivdzAMkH/C5LdA4M1aL3t6s06yD2kXvUQnb18Qmu9DdXAe0ujc
         Y82rw5Rm9MQwWKU1RFLkRPnb7WVvoPSKncuSJIyEKrKX/kd5VLCbPnvmwdjvfl5SVa7N
         VAg6sj0yf6guChisR+GEuUdr2f1FYRyDocs3EywSYMVQ4W+BJyx34qKEZ909YmIEjUIl
         hhYGgz6QAg3bN9LZBLETgzba9YeuyQJnLgT9W0cwaQiG6FwiGUlUg8ixu2e8wpRavv6f
         wfjJ4fcMoZ9VIoMNlzJofqIkCBMiDX1dXyhrDxur42uaiQNKp+vDMbagtG9MR/dprpNp
         gNCg==
X-Gm-Message-State: AOJu0Yw9kUNuf8JPlg/Ege8+cuUAvln2oWEyvDY+AOhu5sz8yorhs2Qh
	iMrn+FNQKGtkpZHnBwLxd/HakRM+PgaTIHaAi3Mb6fVyFB187NnWGc7DbF2zJhl5
X-Gm-Gg: ASbGncuxx0YC7sEI+9Hv0nAihPCt7uBsYY1QGJyF2/mXDauYMtJJL01I8ytkbnJqgvC
	dkZQ8wQXIYL/PzIsArIfMgnhpU0JjtSgo8wXNi/+J6QlXNeQsyhvsFyfgMClobbvf+Sni161uTD
	+YGsFnoo06JECe1qdngdmiDYXPrgI/BqIxbogp8u07yP3nki7Ac6gu4E7rpX5jDetT7lcILQ727
	ym60FrdA65x1n0zXXPURK/YOkEbaocTGEb4mpZoH31fkQHEZNA1G4RSAGwObx4wK3gKePdvlhef
	QB7k4YYFkArBpE38sO7DK1XE+DfYdChr8iSqUsFnugbivcHv+tVRoX4xcR3LPLDmvSVBNsMjJMd
	O81jO2FDbTIK6moeW9RuIGNcasMokGQ==
X-Google-Smtp-Source: AGHT+IH9xzJ553wZWDYkr7UyRf4TwcRTicJafQ2AYjwvL+0tbQTxwZJG0zX97H5xMAMWT4x8GiPAYA==
X-Received: by 2002:a17:906:fe0b:b0:b04:7eba:1b55 with SMTP id a640c23a62f3a-b07c2501249mr788571566b.19.1757821976146;
        Sat, 13 Sep 2025 20:52:56 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b31291b0sm675041666b.34.2025.09.13.20.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 20:52:55 -0700 (PDT)
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
Subject: [PATCH RESEND 42/62] init: rename <linux/initrd.h> to <linux/initramfs.h>
Date: Sun, 14 Sep 2025 06:52:50 +0300
Message-ID: <20250914035250.3651258-1-safinaskar@gmail.com>
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

This is cleanup after initrd removal

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 arch/alpha/kernel/core_irongate.c                | 2 +-
 arch/alpha/kernel/setup.c                        | 2 +-
 arch/arc/mm/init.c                               | 2 +-
 arch/arm/kernel/atags_parse.c                    | 2 +-
 arch/arm/kernel/setup.c                          | 2 +-
 arch/arm/mm/init.c                               | 2 +-
 arch/arm64/kernel/setup.c                        | 2 +-
 arch/arm64/mm/init.c                             | 2 +-
 arch/csky/kernel/setup.c                         | 2 +-
 arch/csky/mm/init.c                              | 2 +-
 arch/loongarch/kernel/mem.c                      | 2 +-
 arch/loongarch/kernel/setup.c                    | 2 +-
 arch/m68k/kernel/setup_mm.c                      | 2 +-
 arch/m68k/kernel/setup_no.c                      | 2 +-
 arch/m68k/kernel/uboot.c                         | 2 +-
 arch/microblaze/kernel/cpu/mb.c                  | 2 +-
 arch/microblaze/kernel/setup.c                   | 2 +-
 arch/microblaze/mm/init.c                        | 2 +-
 arch/mips/ath79/prom.c                           | 2 +-
 arch/mips/kernel/setup.c                         | 2 +-
 arch/mips/mm/init.c                              | 2 +-
 arch/mips/sibyte/swarm/setup.c                   | 2 +-
 arch/nios2/kernel/setup.c                        | 2 +-
 arch/openrisc/kernel/setup.c                     | 2 +-
 arch/parisc/kernel/pdt.c                         | 2 +-
 arch/parisc/kernel/setup.c                       | 2 +-
 arch/parisc/mm/init.c                            | 2 +-
 arch/powerpc/kernel/prom.c                       | 2 +-
 arch/powerpc/kernel/prom_init.c                  | 2 +-
 arch/powerpc/kernel/setup-common.c               | 2 +-
 arch/powerpc/kernel/setup_32.c                   | 2 +-
 arch/powerpc/kernel/setup_64.c                   | 2 +-
 arch/powerpc/mm/init_32.c                        | 2 +-
 arch/powerpc/platforms/52xx/lite5200.c           | 2 +-
 arch/powerpc/platforms/83xx/km83xx.c             | 2 +-
 arch/powerpc/platforms/85xx/mpc85xx_mds.c        | 2 +-
 arch/powerpc/platforms/chrp/setup.c              | 2 +-
 arch/powerpc/platforms/embedded6xx/linkstation.c | 2 +-
 arch/powerpc/platforms/embedded6xx/storcenter.c  | 2 +-
 arch/powerpc/platforms/powermac/setup.c          | 2 +-
 arch/riscv/mm/init.c                             | 2 +-
 arch/s390/kernel/setup.c                         | 2 +-
 arch/s390/mm/init.c                              | 2 +-
 arch/sh/kernel/setup.c                           | 2 +-
 arch/sparc/kernel/setup_32.c                     | 2 +-
 arch/sparc/kernel/setup_64.c                     | 2 +-
 arch/sparc/mm/init_32.c                          | 2 +-
 arch/sparc/mm/init_64.c                          | 2 +-
 arch/um/kernel/initrd.c                          | 2 +-
 arch/x86/kernel/cpu/microcode/amd.c              | 2 +-
 arch/x86/kernel/cpu/microcode/intel.c            | 2 +-
 arch/x86/kernel/cpu/microcode/internal.h         | 2 +-
 arch/x86/kernel/devicetree.c                     | 2 +-
 arch/x86/kernel/setup.c                          | 2 +-
 arch/x86/mm/init.c                               | 2 +-
 arch/x86/mm/init_32.c                            | 2 +-
 arch/x86/mm/init_64.c                            | 2 +-
 drivers/acpi/tables.c                            | 2 +-
 drivers/base/firmware_loader/main.c              | 2 +-
 drivers/block/brd.c                              | 2 +-
 drivers/firmware/efi/efi.c                       | 2 +-
 drivers/of/fdt.c                                 | 2 +-
 include/linux/{initrd.h => initramfs.h}          | 6 +++---
 init/do_mounts.c                                 | 2 +-
 init/initramfs.c                                 | 2 +-
 init/main.c                                      | 2 +-
 kernel/sysctl.c                                  | 2 +-
 kernel/umh.c                                     | 2 +-
 68 files changed, 70 insertions(+), 70 deletions(-)
 rename include/linux/{initrd.h => initramfs.h} (89%)

diff --git a/arch/alpha/kernel/core_irongate.c b/arch/alpha/kernel/core_irongate.c
index 5519bb8fc6f2..83b799848b39 100644
--- a/arch/alpha/kernel/core_irongate.c
+++ b/arch/alpha/kernel/core_irongate.c
@@ -19,7 +19,7 @@
 #include <linux/pci.h>
 #include <linux/sched.h>
 #include <linux/init.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/memblock.h>
 
 #include <asm/ptrace.h>
diff --git a/arch/alpha/kernel/setup.c b/arch/alpha/kernel/setup.c
index a344e71b2d2a..809651206781 100644
--- a/arch/alpha/kernel/setup.c
+++ b/arch/alpha/kernel/setup.c
@@ -34,7 +34,7 @@
 #include <linux/pci.h>
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/eisa.h>
 #include <linux/pfn.h>
 #ifdef CONFIG_MAGIC_SYSRQ
diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c
index 1e098d7fc6af..00aaf1ed389f 100644
--- a/arch/arc/mm/init.c
+++ b/arch/arc/mm/init.c
@@ -7,7 +7,7 @@
 #include <linux/mm.h>
 #include <linux/memblock.h>
 #ifdef CONFIG_BLK_DEV_INITRD
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #endif
 #include <linux/of_fdt.h>
 #include <linux/swap.h>
diff --git a/arch/arm/kernel/atags_parse.c b/arch/arm/kernel/atags_parse.c
index 615d9e83c9b5..2b49e0ddfa42 100644
--- a/arch/arm/kernel/atags_parse.c
+++ b/arch/arm/kernel/atags_parse.c
@@ -15,7 +15,7 @@
  */
 
 #include <linux/init.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/kernel.h>
 #include <linux/fs.h>
 #include <linux/root_dev.h>
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 0bfd66c7ada0..876039b24290 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -11,7 +11,7 @@
 #include <linux/ioport.h>
 #include <linux/delay.h>
 #include <linux/utsname.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/console.h>
 #include <linux/seq_file.h>
 #include <linux/screen_info.h>
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index a564cbc36d18..ae5921db626e 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -13,7 +13,7 @@
 #include <linux/sched/task.h>
 #include <linux/export.h>
 #include <linux/nodemask.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/of_fdt.h>
 #include <linux/highmem.h>
 #include <linux/gfp.h>
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 77c7926a4df6..bddbb473ad88 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -12,7 +12,7 @@
 #include <linux/stddef.h>
 #include <linux/ioport.h>
 #include <linux/delay.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/console.h>
 #include <linux/cache.h>
 #include <linux/screen_info.h>
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 3414e48c8c82..e50533faaece 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -14,7 +14,7 @@
 #include <linux/cache.h>
 #include <linux/mman.h>
 #include <linux/nodemask.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/gfp.h>
 #include <linux/math.h>
 #include <linux/memblock.h>
diff --git a/arch/csky/kernel/setup.c b/arch/csky/kernel/setup.c
index 403a977b8c1f..9feca38d4c47 100644
--- a/arch/csky/kernel/setup.c
+++ b/arch/csky/kernel/setup.c
@@ -3,7 +3,7 @@
 
 #include <linux/console.h>
 #include <linux/memblock.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <linux/start_kernel.h>
diff --git a/arch/csky/mm/init.c b/arch/csky/mm/init.c
index 573da66b2543..f2d1004fc6ae 100644
--- a/arch/csky/mm/init.c
+++ b/arch/csky/mm/init.c
@@ -19,7 +19,7 @@
 #include <linux/swap.h>
 #include <linux/proc_fs.h>
 #include <linux/pfn.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 
 #include <asm/setup.h>
 #include <asm/cachectl.h>
diff --git a/arch/loongarch/kernel/mem.c b/arch/loongarch/kernel/mem.c
index aed901c57fb4..5ec4d18c9000 100644
--- a/arch/loongarch/kernel/mem.c
+++ b/arch/loongarch/kernel/mem.c
@@ -3,7 +3,7 @@
  * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
  */
 #include <linux/efi.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/memblock.h>
 
 #include <asm/bootinfo.h>
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 226262f35dc1..5d0124cbe94b 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -17,7 +17,7 @@
 #include <linux/efi.h>
 #include <linux/export.h>
 #include <linux/memblock.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/ioport.h>
 #include <linux/kexec.h>
 #include <linux/crash_dump.h>
diff --git a/arch/m68k/kernel/setup_mm.c b/arch/m68k/kernel/setup_mm.c
index 80f0544c1041..b9c9b2e3a150 100644
--- a/arch/m68k/kernel/setup_mm.c
+++ b/arch/m68k/kernel/setup_mm.c
@@ -25,7 +25,7 @@
 #include <linux/seq_file.h>
 #include <linux/module.h>
 #include <linux/nvram.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/random.h>
 
 #include <asm/bootinfo.h>
diff --git a/arch/m68k/kernel/setup_no.c b/arch/m68k/kernel/setup_no.c
index 4d98e0063725..6d3d5a299383 100644
--- a/arch/m68k/kernel/setup_no.c
+++ b/arch/m68k/kernel/setup_no.c
@@ -29,7 +29,7 @@
 #include <linux/memblock.h>
 #include <linux/seq_file.h>
 #include <linux/init.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/root_dev.h>
 #include <linux/rtc.h>
 
diff --git a/arch/m68k/kernel/uboot.c b/arch/m68k/kernel/uboot.c
index 5fc831a0794a..416e3f8f879d 100644
--- a/arch/m68k/kernel/uboot.c
+++ b/arch/m68k/kernel/uboot.c
@@ -18,7 +18,7 @@
 #include <linux/memblock.h>
 #include <linux/seq_file.h>
 #include <linux/init.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/root_dev.h>
 #include <linux/rtc.h>
 
diff --git a/arch/microblaze/kernel/cpu/mb.c b/arch/microblaze/kernel/cpu/mb.c
index 37cb2898216b..a5d2c564d4e5 100644
--- a/arch/microblaze/kernel/cpu/mb.c
+++ b/arch/microblaze/kernel/cpu/mb.c
@@ -13,7 +13,7 @@
 #include <linux/string.h>
 #include <linux/seq_file.h>
 #include <linux/cpu.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 
 #include <linux/bug.h>
 #include <asm/cpuinfo.h>
diff --git a/arch/microblaze/kernel/setup.c b/arch/microblaze/kernel/setup.c
index f417333eccae..7f537307b71c 100644
--- a/arch/microblaze/kernel/setup.c
+++ b/arch/microblaze/kernel/setup.c
@@ -14,7 +14,7 @@
 #include <linux/string.h>
 #include <linux/seq_file.h>
 #include <linux/cpu.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/console.h>
 #include <linux/debugfs.h>
 #include <linux/of_fdt.h>
diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
index fabeca49c2c6..f54d71160712 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -12,7 +12,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/mm.h> /* mem_init */
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/of_fdt.h>
 #include <linux/pagemap.h>
 #include <linux/pfn.h>
diff --git a/arch/mips/ath79/prom.c b/arch/mips/ath79/prom.c
index 506dcada711b..fcb45fe198a0 100644
--- a/arch/mips/ath79/prom.c
+++ b/arch/mips/ath79/prom.c
@@ -11,7 +11,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/string.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 
 #include <asm/bootinfo.h>
 #include <asm/addrspace.h>
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index aed454ebd751..47dc7eb99ef7 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -16,7 +16,7 @@
 #include <linux/ioport.h>
 #include <linux/export.h>
 #include <linux/memblock.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/root_dev.h>
 #include <linux/highmem.h>
 #include <linux/console.h>
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index a673d3d68254..5b109c737547 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -30,7 +30,7 @@
 #include <linux/hardirq.h>
 #include <linux/gfp.h>
 #include <linux/kcore.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/execmem.h>
 
 #include <asm/bootinfo.h>
diff --git a/arch/mips/sibyte/swarm/setup.c b/arch/mips/sibyte/swarm/setup.c
index 38c90b5e8754..ff8b2d8ad7ab 100644
--- a/arch/mips/sibyte/swarm/setup.c
+++ b/arch/mips/sibyte/swarm/setup.c
@@ -15,7 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/console.h>
 #include <linux/screen_info.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 
 #include <asm/irq.h>
 #include <asm/io.h>
diff --git a/arch/nios2/kernel/setup.c b/arch/nios2/kernel/setup.c
index 3cc44fa4931c..d3d60c42df46 100644
--- a/arch/nios2/kernel/setup.c
+++ b/arch/nios2/kernel/setup.c
@@ -17,7 +17,7 @@
 #include <linux/sched/task.h>
 #include <linux/console.h>
 #include <linux/memblock.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/of_fdt.h>
 
 #include <asm/mmu_context.h>
diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
index 337a0381c452..27ae87c09b0e 100644
--- a/arch/openrisc/kernel/setup.c
+++ b/arch/openrisc/kernel/setup.c
@@ -29,7 +29,7 @@
 #include <linux/memblock.h>
 #include <linux/seq_file.h>
 #include <linux/serial.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/of_fdt.h>
 #include <linux/of.h>
 #include <linux/device.h>
diff --git a/arch/parisc/kernel/pdt.c b/arch/parisc/kernel/pdt.c
index 3715a3b088a7..49982a48c92c 100644
--- a/arch/parisc/kernel/pdt.c
+++ b/arch/parisc/kernel/pdt.c
@@ -17,7 +17,7 @@
 #include <linux/seq_file.h>
 #include <linux/kthread.h>
 #include <linux/proc_fs.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/pgtable.h>
 #include <linux/mm.h>
 
diff --git a/arch/parisc/kernel/setup.c b/arch/parisc/kernel/setup.c
index 41f45fa177d0..1e403c26070d 100644
--- a/arch/parisc/kernel/setup.c
+++ b/arch/parisc/kernel/setup.c
@@ -13,7 +13,7 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/init.h>
 #include <linux/console.h>
 #include <linux/seq_file.h>
diff --git a/arch/parisc/mm/init.c b/arch/parisc/mm/init.c
index af7a33c8bd31..5843f4a46e93 100644
--- a/arch/parisc/mm/init.c
+++ b/arch/parisc/mm/init.c
@@ -18,7 +18,7 @@
 #include <linux/gfp.h>
 #include <linux/delay.h>
 #include <linux/init.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/swap.h>
 #include <linux/unistd.h>
 #include <linux/nodemask.h>	/* for node_online_map */
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index b7858b0bd697..a2a1896f9e46 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -19,7 +19,7 @@
 #include <linux/types.h>
 #include <linux/pci.h>
 #include <linux/delay.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/bitops.h>
 #include <linux/export.h>
 #include <linux/kexec.h>
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 827c958677f8..a0ac845eb504 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -24,7 +24,7 @@
 #include <linux/pci.h>
 #include <linux/proc_fs.h>
 #include <linux/delay.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/bitops.h>
 #include <linux/pgtable.h>
 #include <linux/printk.h>
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index eff369cba0e5..53a416bc41ce 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -16,7 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/reboot.h>
 #include <linux/delay.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/platform_device.h>
 #include <linux/printk.h>
 #include <linux/seq_file.h>
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 5a1bf501fbe1..21d21b8291ef 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -10,7 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/reboot.h>
 #include <linux/delay.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/tty.h>
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 8fd7cbf3bd04..66c2d563c094 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -13,7 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/reboot.h>
 #include <linux/delay.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/seq_file.h>
 #include <linux/ioport.h>
 #include <linux/console.h>
diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 4e71dfe7d026..f434e6dc1921 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -22,7 +22,7 @@
 #include <linux/stddef.h>
 #include <linux/init.h>
 #include <linux/highmem.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/pagemap.h>
 #include <linux/memblock.h>
 #include <linux/gfp.h>
diff --git a/arch/powerpc/platforms/52xx/lite5200.c b/arch/powerpc/platforms/52xx/lite5200.c
index 0a161d82a3a8..e4222658ec2d 100644
--- a/arch/powerpc/platforms/52xx/lite5200.c
+++ b/arch/powerpc/platforms/52xx/lite5200.c
@@ -17,7 +17,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/root_dev.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <asm/time.h>
 #include <asm/io.h>
 #include <asm/machdep.h>
diff --git a/arch/powerpc/platforms/83xx/km83xx.c b/arch/powerpc/platforms/83xx/km83xx.c
index 2b5d187d9b62..b0426b35f9ed 100644
--- a/arch/powerpc/platforms/83xx/km83xx.c
+++ b/arch/powerpc/platforms/83xx/km83xx.c
@@ -19,7 +19,7 @@
 #include <linux/delay.h>
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index c19490cf6376..6b6c11931c1e 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -24,7 +24,7 @@
 #include <linux/console.h>
 #include <linux/delay.h>
 #include <linux/seq_file.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/fsl_devices.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
diff --git a/arch/powerpc/platforms/chrp/setup.c b/arch/powerpc/platforms/chrp/setup.c
index c1bfa4c3444c..00a6663a0a88 100644
--- a/arch/powerpc/platforms/chrp/setup.c
+++ b/arch/powerpc/platforms/chrp/setup.c
@@ -30,7 +30,7 @@
 #include <linux/console.h>
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/timer.h>
 #include <linux/of_address.h>
 #include <linux/of_fdt.h>
diff --git a/arch/powerpc/platforms/embedded6xx/linkstation.c b/arch/powerpc/platforms/embedded6xx/linkstation.c
index 4012f206ec63..8e41d0fb0892 100644
--- a/arch/powerpc/platforms/embedded6xx/linkstation.c
+++ b/arch/powerpc/platforms/embedded6xx/linkstation.c
@@ -11,7 +11,7 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/of_platform.h>
 #include <linux/seq_file.h>
 
diff --git a/arch/powerpc/platforms/embedded6xx/storcenter.c b/arch/powerpc/platforms/embedded6xx/storcenter.c
index e49880e8dab8..df458828eb22 100644
--- a/arch/powerpc/platforms/embedded6xx/storcenter.c
+++ b/arch/powerpc/platforms/embedded6xx/storcenter.c
@@ -13,7 +13,7 @@
 
 #include <linux/kernel.h>
 #include <linux/pci.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/of_platform.h>
 
 #include <asm/time.h>
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index 4c3b9ed5428d..ab0860868025 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -32,7 +32,7 @@
 #include <linux/delay.h>
 #include <linux/ioport.h>
 #include <linux/major.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/console.h>
 #include <linux/pci.h>
 #include <linux/adb.h>
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index b1c4876dadae..479a0861a93e 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -9,7 +9,7 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/memblock.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/swap.h>
 #include <linux/swiotlb.h>
 #include <linux/sizes.h>
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 9bdb6f6b893e..7ce009c2599d 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -33,7 +33,7 @@
 #include <linux/ioport.h>
 #include <linux/delay.h>
 #include <linux/init.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/root_dev.h>
 #include <linux/console.h>
 #include <linux/kernel_stat.h>
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index e4953453d254..e6556f9f2be3 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -27,7 +27,7 @@
 #include <linux/memory.h>
 #include <linux/pfn.h>
 #include <linux/poison.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/export.h>
 #include <linux/cma.h>
 #include <linux/gfp.h>
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index 9ce9dc5b9e56..814866e35120 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -9,7 +9,7 @@
  */
 #include <linux/ioport.h>
 #include <linux/init.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/console.h>
 #include <linux/root_dev.h>
 #include <linux/utsname.h>
diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index fb46fb3acf54..b3778d78bb78 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -14,7 +14,7 @@
 #include <linux/unistd.h>
 #include <linux/ptrace.h>
 #include <linux/slab.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <asm/smp.h>
 #include <linux/user.h>
 #include <linux/delay.h>
diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 79b56613c6d8..02b16827b664 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -28,7 +28,7 @@
 #include <linux/root_dev.h>
 #include <linux/interrupt.h>
 #include <linux/cpu.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/module.h>
 #include <linux/start_kernel.h>
 #include <linux/memblock.h>
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index 7b7722ff5232..f04dd1d6f382 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -19,7 +19,7 @@
 #include <linux/mman.h>
 #include <linux/mm.h>
 #include <linux/swap.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/init.h>
 #include <linux/highmem.h>
 #include <linux/memblock.h>
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index af249a654e79..b0fa82676e6f 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -14,7 +14,7 @@
 #include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/hugetlb.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/swap.h>
 #include <linux/pagemap.h>
 #include <linux/poison.h>
diff --git a/arch/um/kernel/initrd.c b/arch/um/kernel/initrd.c
index e6113192a6b6..99edfbd78c00 100644
--- a/arch/um/kernel/initrd.c
+++ b/arch/um/kernel/initrd.c
@@ -5,7 +5,7 @@
 
 #include <linux/init.h>
 #include <linux/memblock.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <asm/types.h>
 #include <init.h>
 #include <os.h>
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 514f63340880..0086e285d60c 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -26,7 +26,7 @@
 #include <linux/bsearch.h>
 #include <linux/uaccess.h>
 #include <linux/vmalloc.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
 
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 371ca6eac00e..4bebf8b77542 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -14,7 +14,7 @@
 #include <linux/earlycpio.h>
 #include <linux/firmware.h>
 #include <linux/uaccess.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/cpu.h>
diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/microcode/internal.h
index 50a9702ae4e2..b4aec58af7e3 100644
--- a/arch/x86/kernel/cpu/microcode/internal.h
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -3,7 +3,7 @@
 #define _X86_MICROCODE_INTERNAL_H
 
 #include <linux/earlycpio.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 
 #include <asm/cpu.h>
 #include <asm/microcode.h>
diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index dd8748c45529..3eb6dad99288 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -16,7 +16,7 @@
 #include <linux/slab.h>
 #include <linux/pci.h>
 #include <linux/of_pci.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 
 #include <asm/irqdomain.h>
 #include <asm/hpet.h>
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 167b9ef12ebb..3b88d156ed39 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -14,7 +14,7 @@
 #include <linux/hugetlb.h>
 #include <linux/ima.h>
 #include <linux/init_ohci1394_dma.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/iscsi_ibft.h>
 #include <linux/memblock.h>
 #include <linux/panic_notifier.h>
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index c7ca996fb430..b7c45004f999 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -1,5 +1,5 @@
 #include <linux/gfp.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/ioport.h>
 #include <linux/swap.h>
 #include <linux/memblock.h>
diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index 8a34fff6ab2b..d075d4178d36 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -27,7 +27,7 @@
 #include <linux/memblock.h>
 #include <linux/proc_fs.h>
 #include <linux/memory_hotplug.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/cpumask.h>
 #include <linux/gfp.h>
 
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index b9426fce5f3e..34fcb5b8f386 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -19,7 +19,7 @@
 #include <linux/swap.h>
 #include <linux/smp.h>
 #include <linux/init.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/pagemap.h>
 #include <linux/memblock.h>
 #include <linux/proc_fs.h>
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 37ad99c10ac4..4ecb6bf897fd 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -19,7 +19,7 @@
 #include <linux/acpi.h>
 #include <linux/memblock.h>
 #include <linux/earlycpio.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/security.h>
 #include <linux/kmemleak.h>
 #include "internal.h"
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 6942c62fa59d..f32de7459e76 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -15,7 +15,7 @@
 #include <linux/kernel_read_file.h>
 #include <linux/module.h>
 #include <linux/init.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/timer.h>
 #include <linux/vmalloc.h>
 #include <linux/interrupt.h>
diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 05c4325904d2..a15b699d3a09 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -10,7 +10,7 @@
  */
 
 #include <linux/init.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/major.h>
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 7cab72da2ea9..1dcaaea1dcfb 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -21,7 +21,7 @@
 #include <linux/device.h>
 #include <linux/efi.h>
 #include <linux/of.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/io.h>
 #include <linux/kexec.h>
 #include <linux/platform_device.h>
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 127b37f211cb..2e73de8a1bbe 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -11,7 +11,7 @@
 #include <linux/crash_dump.h>
 #include <linux/crc32.h>
 #include <linux/kernel.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/memblock.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
diff --git a/include/linux/initrd.h b/include/linux/initramfs.h
similarity index 89%
rename from include/linux/initrd.h
rename to include/linux/initramfs.h
index 51c473b6a973..e9f523917a02 100644
--- a/include/linux/initrd.h
+++ b/include/linux/initramfs.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
-#ifndef __LINUX_INITRD_H
-#define __LINUX_INITRD_H
+#ifndef __LINUX_INITRAMFS_H
+#define __LINUX_INITRAMFS_H
 
 /* 1 if it is not an error if virt_external_initramfs_start < memory_start */
 extern int initramfs_below_start_ok;
@@ -23,4 +23,4 @@ extern unsigned long phys_external_initramfs_size;
 extern char __builtin_initramfs_start[];
 extern unsigned long __builtin_initramfs_size;
 
-#endif /* __LINUX_INITRD_H */
+#endif /* __LINUX_INITRAMFS_H */
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 5b55d0035e03..2df33c573d9c 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -14,7 +14,7 @@
 #include <linux/init.h>
 #include <linux/init_syscalls.h>
 #include <linux/fs.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/async.h>
 #include <linux/fs_struct.h>
 #include <linux/slab.h>
diff --git a/init/initramfs.c b/init/initramfs.c
index a6c11260e62b..8b648b09247a 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -597,7 +597,7 @@ static int __init initramfs_async_setup(char *str)
 }
 __setup("initramfs_async=", initramfs_async_setup);
 
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/kexec.h>
 
 unsigned long virt_external_initramfs_start, virt_external_initramfs_end;
diff --git a/init/main.c b/init/main.c
index f119460bf8e1..5186233c64fd 100644
--- a/init/main.c
+++ b/init/main.c
@@ -26,7 +26,7 @@
 #include <linux/delay.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/memblock.h>
 #include <linux/acpi.h>
 #include <linux/bootconfig.h>
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index cb6196e3fa99..3bf92703332b 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -12,7 +12,7 @@
 #include <linux/kobject.h>
 #include <linux/highuid.h>
 #include <linux/writeback.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/times.h>
 #include <linux/limits.h>
 #include <linux/syscalls.h>
diff --git a/kernel/umh.c b/kernel/umh.c
index b4da45a3a7cf..c58b3e8e9256 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -26,7 +26,7 @@
 #include <linux/ptrace.h>
 #include <linux/async.h>
 #include <linux/uaccess.h>
-#include <linux/initrd.h>
+#include <linux/initramfs.h>
 #include <linux/freezer.h>
 
 #include <trace/events/module.h>
-- 
2.47.2


