Return-Path: <linux-fsdevel+bounces-61233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBCAB565E8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 06:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E2ED7AE531
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 03:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBDE275845;
	Sun, 14 Sep 2025 04:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUs2AQam"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC45F2264BB
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Sep 2025 04:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757822414; cv=none; b=HCpuuADALuhu3P4zxQrzmxvuGDQlaIRL9E4KwbMCde1TZIx4QsGccM5EEIyx6eySsIKipWDuLKS+KZWalCuAoVS5tKszRhD14Bn3i3Ari1IDuMjfIXCKEmRxYc2cGEgI7kfzqninZRBoiM4NniezLA6v1TW91jNvjeERXXGSbsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757822414; c=relaxed/simple;
	bh=/bxzngf5skclGRBscZHcLzo2yjr/LuMuS/DD/Rj8Rbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E8UMpGRlQd8m95ZVHPI3a65Kz/GYLaNodRbDrNw3vAToCRxJWNwl5PJp59dfGv1JytGvxy3uVU7ZPoLXlr1LlfQ7/KMkFsvJFyQZ/LynkTqXaEQvbAdswpIqz/G89mARGUQPLIzQ8YpR5FgCdF05KtrwNKkE+wamC/oyvI2PMAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUs2AQam; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-62f1987d53aso720054a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Sep 2025 21:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757822408; x=1758427208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPu72pvE4Wbo60re69UImAF/YSQlNTTbxtv7CBRvcjs=;
        b=JUs2AQam6b4nqSOGTAtBSs33sUvHl88lDkWIx7zrB3ZDFeCH8P/tw0XxiBcN6MHJ+9
         B0oIVTqotkPUqYV9jllsybZda2m+T/Zk3ZIgT0QPKSipnbCfheTUdMch3NBww6BeK9iS
         XJhlQARLy6SoVaoL8JqjC6wbtWc7gCyv0bxYOrVZ//awb98b2zeU2j/N29kGDv5v/gTZ
         VtB93KsUYG0fovDk7p5MWHsmGTOYsmDQrTIEskR97v00NvcSDZG757ioGzXBpn7wj3CF
         A+EApAe/GCLOZp44RNdCM29TTV+/QhyxFMho3/g8e1KZBC2vF+gP3sI6rea/ZAFp7IyC
         4xOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757822408; x=1758427208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sPu72pvE4Wbo60re69UImAF/YSQlNTTbxtv7CBRvcjs=;
        b=mLWufR/SYADjlq+ULsfE8Pvgqw6IPavTgWmCfA9yL4k0U2zc6zmUT6D4TYXmJrwzXQ
         drnDif/2VrJHZt+GSpodZgWEPrbrNXTruGXHKMqre/uWhD7jx84iuWNiOTemUMAO5Vcr
         0BeGg9egIYqpg63ol0JKuaY5yULTs1AmQuR30iSpM1Ao99CXgDzFkecj7hoiNnfzygEP
         uw+vLeDxvvzFgQk+mnnm8edlfQJX1v0sUAgOew4DcCdli1++qiKw4vbzETLyDIXLFuZJ
         1MNr4NfDTohsDGVrabNKqLuvfykIEjPp8EBxWD6X8trIzQ4NRRDeeFuokVEaQs1STI/9
         +qJg==
X-Gm-Message-State: AOJu0YwydwNvb8xDSLzWQRT3GMnp8O+Sd5JusWP66aBpdE+sakb1+Z9+
	qkZoW1T40vfl9v3/Og2CdrVQgPCukin3dmySiJW9Su4O8asuUAUevayyS5DnSnwa
X-Gm-Gg: ASbGncsuoqQSwVXwZC6ShQAHB9rKt4MKgjnaL9+w3HLT9hq80rsNT8KsM44u13g9JMv
	RQM+EhxKCHbufIwAMPmc5asJFxbmn235rA73V2uN9ASpgYnt+zKqzhRTmU0Ej6YVxSAn5ga3/jq
	P6AMZZST2Nt8GhBaPiQJvL1N3qosZ6fGkmtH4vtH51cytM7mPvqZdjDBX34koPD/syQN2ow1quj
	KMN3cJmeHY+fP4AWgC26YUpLknNM+EoeSU+IHqdvbE9jVE2YWDGIqGh0VOtTkqQTrbXAv6UNp+k
	VCC3gRH/DSGclOJq2NjbM354Lfqa31do7KTmzqvBkjZ8TT1GYMGrZcfHIuNWT0Zee8BiEZeqUrE
	ZdqJeVjCVwvi1ddR3EOs=
X-Google-Smtp-Source: AGHT+IEl+TZwxB50+bcUbtwQ17obwnzKEwTqhOZYOAPQC+b9EZK3iFYtQ6uoMv0unkK0mvoXQKHChg==
X-Received: by 2002:a17:907:3e1e:b0:afe:35d:fd5d with SMTP id a640c23a62f3a-b07c3475927mr787189666b.1.1757822407322;
        Sat, 13 Sep 2025 21:00:07 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b32ef574sm682456966b.73.2025.09.13.21.00.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 21:00:06 -0700 (PDT)
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
Subject: [PATCH RESEND 54/62] init: arm, x86: deal with some references to initrd
Date: Sun, 14 Sep 2025 07:00:01 +0300
Message-ID: <20250914040002.3779907-1-safinaskar@gmail.com>
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

...in comments and printk

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 arch/arm/mm/init.c      |  2 +-
 arch/x86/kernel/setup.c | 10 +++++-----
 arch/x86/mm/init.c      |  2 +-
 init/initramfs.c        | 18 +++++++++---------
 init/main.c             | 12 ++++++------
 5 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index ae5921db626e..04ba9b385e24 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -445,7 +445,7 @@ void free_initramfs_mem(unsigned long start, unsigned long end)
 		end = round_up(end, PAGE_SIZE);
 
 	poison_init_mem((void *)start, PAGE_ALIGN(end) - start);
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
+	free_reserved_area((void *)start, (void *)end, -1, "initramfs");
 }
 #endif
 
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 3b88d156ed39..65670e0f59c0 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -325,19 +325,19 @@ static void __init relocate_initrd(void)
 	u64 relocated_ramdisk = memblock_phys_alloc_range(area_size, PAGE_SIZE, 0,
 						      PFN_PHYS(max_pfn_mapped));
 	if (!relocated_ramdisk)
-		panic("Cannot find place for new RAMDISK of size %lld\n",
+		panic("Cannot find place for new INITRAMFS of size %lld\n",
 		      ramdisk_size);
 
 	virt_external_initramfs_start = relocated_ramdisk + PAGE_OFFSET;
 	virt_external_initramfs_end   = virt_external_initramfs_start + ramdisk_size;
-	printk(KERN_INFO "Allocated new RAMDISK: [mem %#010llx-%#010llx]\n",
+	printk(KERN_INFO "Allocated new INITRAMFS: [mem %#010llx-%#010llx]\n",
 	       relocated_ramdisk, relocated_ramdisk + ramdisk_size - 1);
 
 	ret = copy_from_early_mem((void *)virt_external_initramfs_start, ramdisk_image, ramdisk_size);
 	if (ret)
-		panic("Copy RAMDISK failed\n");
+		panic("Copy INITRAMFS failed\n");
 
-	printk(KERN_INFO "Move RAMDISK from [mem %#010llx-%#010llx] to"
+	printk(KERN_INFO "Move INITRAMFS from [mem %#010llx-%#010llx] to"
 		" [mem %#010llx-%#010llx]\n",
 		ramdisk_image, ramdisk_image + ramdisk_size - 1,
 		relocated_ramdisk, relocated_ramdisk + ramdisk_size - 1);
@@ -370,7 +370,7 @@ static void __init reserve_initrd(void)
 
 	virt_external_initramfs_start = 0;
 
-	printk(KERN_INFO "RAMDISK: [mem %#010llx-%#010llx]\n", ramdisk_image,
+	printk(KERN_INFO "INITRAMFS: [mem %#010llx-%#010llx]\n", ramdisk_image,
 			ramdisk_end - 1);
 
 	if (pfn_range_is_mapped(PFN_DOWN(ramdisk_image),
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index b7c45004f999..51b632f7fd21 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -992,7 +992,7 @@ void __init free_initramfs_mem(unsigned long start, unsigned long end)
 	 *   - relocate_initrd()
 	 * So here We can do PAGE_ALIGN() safely to get partial page to be freed
 	 */
-	free_init_pages("initrd", start, PAGE_ALIGN(end));
+	free_init_pages("initramfs", start, PAGE_ALIGN(end));
 }
 #endif
 
diff --git a/init/initramfs.c b/init/initramfs.c
index d52314b17c25..348cfcc4c95e 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -643,7 +643,7 @@ void __init reserve_initramfs_mem(void)
 		return;
 	/*
 	 * Round the memory region to page boundaries as per free_initramfs_mem()
-	 * This allows us to detect whether the pages overlapping the initrd
+	 * This allows us to detect whether the pages overlapping the initramfs
 	 * are in use, but more importantly, reserves the entire set of pages
 	 * as we don't want these pages allocated for other purposes.
 	 */
@@ -652,26 +652,26 @@ void __init reserve_initramfs_mem(void)
 	size = round_up(size, PAGE_SIZE);
 
 	if (!memblock_is_region_memory(start, size)) {
-		pr_err("INITRD: 0x%08llx+0x%08lx is not a memory region",
+		pr_err("INITRAMFS: 0x%08llx+0x%08lx is not a memory region",
 		       (u64)start, size);
 		goto disable;
 	}
 
 	if (memblock_is_region_reserved(start, size)) {
-		pr_err("INITRD: 0x%08llx+0x%08lx overlaps in-use memory region\n",
+		pr_err("INITRAMFS: 0x%08llx+0x%08lx overlaps in-use memory region\n",
 		       (u64)start, size);
 		goto disable;
 	}
 
 	memblock_reserve(start, size);
-	/* Now convert initrd to virtual addresses */
+	/* Now convert initramfs to virtual addresses */
 	virt_external_initramfs_start = (unsigned long)__va(phys_external_initramfs_start);
 	virt_external_initramfs_end = virt_external_initramfs_start + phys_external_initramfs_size;
 	initramfs_below_start_ok = 1;
 
 	return;
 disable:
-	pr_cont(" - disabling initrd\n");
+	pr_cont(" - disabling initramfs\n");
 	virt_external_initramfs_start = 0;
 	virt_external_initramfs_end = 0;
 }
@@ -686,7 +686,7 @@ void __weak __init free_initramfs_mem(unsigned long start, unsigned long end)
 #endif
 
 	free_reserved_area((void *)start, (void *)end, POISON_FREE_INITMEM,
-			"initrd");
+			"initramfs");
 }
 
 #ifdef CONFIG_CRASH_RESERVE
@@ -696,14 +696,14 @@ static bool __init kexec_free_initramfs(void)
 	unsigned long crashk_end   = (unsigned long)__va(crashk_res.end);
 
 	/*
-	 * If the initrd region is overlapped with crashkernel reserved region,
+	 * If the initramfs region is overlapped with crashkernel reserved region,
 	 * free only memory that is not part of crashkernel region.
 	 */
 	if (virt_external_initramfs_start >= crashk_end || virt_external_initramfs_end <= crashk_start)
 		return false;
 
 	/*
-	 * Initialize initrd memory region since the kexec boot does not do.
+	 * Initialize initramfs memory region since the kexec boot does not do.
 	 */
 	memset((void *)virt_external_initramfs_start, 0, virt_external_initramfs_end - virt_external_initramfs_start);
 	if (virt_external_initramfs_start < crashk_start)
@@ -740,7 +740,7 @@ static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
 	security_initramfs_populated();
 
 	/*
-	 * If the initrd region is overlapped with crashkernel reserved region,
+	 * If the initramfs region is overlapped with crashkernel reserved region,
 	 * free only memory that is not part of crashkernel region.
 	 */
 	if (!retain_initramfs && virt_external_initramfs_start && !kexec_free_initramfs()) {
diff --git a/init/main.c b/init/main.c
index c535e0613df8..4212efb33e77 100644
--- a/init/main.c
+++ b/init/main.c
@@ -276,7 +276,7 @@ static void * __init get_boot_config_from_initramfs(size_t *_size)
 
 	data = (char *)virt_external_initramfs_end - BOOTCONFIG_MAGIC_LEN;
 	/*
-	 * Since Grub may align the size of initrd to 4, we must
+	 * Since Grub may align the size of initramfs to 4, we must
 	 * check the preceding 3 bytes as well.
 	 */
 	for (i = 0; i < 4; i++) {
@@ -293,7 +293,7 @@ static void * __init get_boot_config_from_initramfs(size_t *_size)
 
 	data = ((void *)hdr) - size;
 	if ((unsigned long)data < virt_external_initramfs_start) {
-		pr_err("bootconfig size %d is greater than initrd size %ld\n",
+		pr_err("bootconfig size %d is greater than initramfs size %ld\n",
 			size, virt_external_initramfs_end - virt_external_initramfs_start);
 		return NULL;
 	}
@@ -303,7 +303,7 @@ static void * __init get_boot_config_from_initramfs(size_t *_size)
 		return NULL;
 	}
 
-	/* Remove bootconfig from initramfs/initrd */
+	/* Remove bootconfig from initramfs */
 	virt_external_initramfs_end = (unsigned long)data;
 	if (_size)
 		*_size = size;
@@ -421,7 +421,7 @@ static void __init setup_boot_config(void)
 
 	/* Cut out the bootconfig data even if we have no bootconfig option */
 	data = get_boot_config_from_initramfs(&size);
-	/* If there is no bootconfig in initrd, try embedded one. */
+	/* If there is no bootconfig in initramfs, try embedded one. */
 	if (!data)
 		data = xbc_get_embedded_bootconfig(&size);
 
@@ -478,7 +478,7 @@ static void __init exit_boot_config(void)
 
 static void __init setup_boot_config(void)
 {
-	/* Remove bootconfig data from initrd */
+	/* Remove bootconfig data from initramfs */
 	get_boot_config_from_initramfs(NULL);
 }
 
@@ -1049,7 +1049,7 @@ void start_kernel(void)
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (virt_external_initramfs_start && !initramfs_below_start_ok &&
 	    page_to_pfn(virt_to_page((void *)virt_external_initramfs_start)) < min_low_pfn) {
-		pr_crit("initrd overwritten (0x%08lx < 0x%08lx) - disabling it.\n",
+		pr_crit("initramfs overwritten (0x%08lx < 0x%08lx) - disabling it.\n",
 		    page_to_pfn(virt_to_page((void *)virt_external_initramfs_start)),
 		    min_low_pfn);
 		virt_external_initramfs_start = 0;
-- 
2.47.2


