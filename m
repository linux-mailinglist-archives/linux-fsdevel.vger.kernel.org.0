Return-Path: <linux-fsdevel+bounces-61172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DF0B55C24
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 02:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 631771C839EA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 00:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC1C1922F6;
	Sat, 13 Sep 2025 00:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKAdVg/A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6B7158DAC
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Sep 2025 00:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757725120; cv=none; b=uSdw4gW7cr7M/0iPXGrFTBMZII9ux00pjc2dpdca5SkZc+9tLfdR6RWJ7qIeAsP238IOwkIGI5qeQJBsEd8b52xuVt62qASHN7+OaKQaBFmWA7peFIpQhP+EyvVnwnW4NSYNc/eazg67k8N9tP4BYwxhDdJHl9ScE/cfsXt6dXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757725120; c=relaxed/simple;
	bh=riLYrwvey4IG1vm31BCl7axPrjxd4nPuzw1Lf4FnM3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mGSuhcjSgG8aCBm8gn5I05Ep+3Z4xoRo87m65D+kPz31NinbPd3wae5htKAcMHYWXMMchEx/TIWKPU3e7P0MC2XULUc2WmvuO2WVYZW6TE67RWMwdZn2Pkl728MRL7fWRIzAeg+FyfCZwwMUXNl18UXq9O7EIVsus1dzH84CLbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKAdVg/A; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6188b5ad4f0so3984415a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 17:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757725115; x=1758329915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BXXMTZbWkKZqT8QgJ9Z777RqiFOaP2Wc1It8eJXku8=;
        b=hKAdVg/A1cgqKS6p9i2KuodzZogaEVcz6+R6REIkiNiIbFfMinE02lC9EOoe6YQ662
         QoLR9T6aT3+M7BjTiV7UHhhnL8XkKjyZyIXFiPtCqdXyqRhXZQVCsC5d/pExy5n63UVD
         aP3IcvsxqqlBvJIhGWqLfrRjmqsx4H8gcINoCK2y+hNmwLXGrio/G7e159/gpZcMF69K
         kaZmEu4fumfSdszmb6RAwXH0qFnnNqWRKA9VZMV1du0FKs+yZoo8fyd8Vjq+UH3lzPCr
         jJbdtu7AJXlgY45fa3FMZxSgib30KPPXZPVWOybYPPZXcTs7CcclB57K/d1DO8TrpOBv
         6XDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757725115; x=1758329915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2BXXMTZbWkKZqT8QgJ9Z777RqiFOaP2Wc1It8eJXku8=;
        b=gmxFI6ensxH3Y/w6Lks/P3ZPiq330goUxu3TyhKxC6Iw3X6mU1vZB0e2YpeeHzCeU2
         WMaGUzs1so7DOoUWIKbF8AIEHuHgVhKOAW29ivJi+5xRGWqEXO38M7ySR3lxmdybnB7a
         LyvAnIEm3pebNxOYUaBH5UvPbLUPGbDDbfW+EtNjbVbIrt5BjsL/KUqc4sb3QS1OhpAa
         RJDwhMNxwFgXjYQkvUBmFqrfEia2Vz7Nc+AD9vhH4GewYGccD+GBXnj0SXN9ypDv2ITr
         u0KuY1cVQDBfz/NWm/oDEPL9Ex4H7MihLWeCz/hmVAmAIg7DJFAKjnv5QMn3b/rjc1ih
         fF/A==
X-Gm-Message-State: AOJu0YznocXHk/Oyx3cPtzsnA25EZ5m0PQCpuA3mdRpfkl9DejGVxiT2
	RgRm+8mmJKx6JX+cUYoO+wvv3umRz/pGTbnm54tBzEBe1MPgrGNd2P/9M5wL2XUW
X-Gm-Gg: ASbGnct4dRQok+ZwkyhHWVhHnJIJSsDUMlMuGgjuELkSERDGhoEr4oqnVHMr2GZ+zsh
	Dd+naYQ6/NJv+bh6hLMZA7VCiLnVCOFelA0WV5VeClPraH/An2dvRDnxzfxoLYS1IhO060zHCzr
	JDG7Nbgfl9QUBINeSsgVOMlzVxwGicXX4OLQbHVekzjiE9ZR6FUfNOzj/GNGQwXc0HZ2ZcGhbZC
	474Xeca+xHfkmOwBEI2HBvmi0O3ae9zDnQu3GJTi56D1lY7PAAi1FiMOEbJRYs3v+B1mXv5y4tK
	pNWaXMclKsoEadVOm7AvHyaHkesBq78FRmHvQDeEXlCk1Oalni4v34a3WdDy8IAgjhkVdxl51rh
	xgaGN26gg5iRQwVWmB3S1DbVHZVT5Tg==
X-Google-Smtp-Source: AGHT+IF4XezAq8wXNO6voYrJeDnCFhU1tJ+TfyE7OJRqFWOCMlq1YMWoUA8uaJ4xPb3fA3w8qZjP4Q==
X-Received: by 2002:a05:6402:5242:b0:628:a4fb:3b44 with SMTP id 4fb4d7f45d1cf-62ed825998fmr4961876a12.1.1757725114882;
        Fri, 12 Sep 2025 17:58:34 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62ec33f3b16sm4143925a12.24.2025.09.12.17.58.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 17:58:34 -0700 (PDT)
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
Subject: [PATCH RESEND 17/62] doc: modernize Documentation/filesystems/ramfs-rootfs-initramfs.rst
Date: Sat, 13 Sep 2025 00:37:56 +0000
Message-ID: <20250913003842.41944-18-safinaskar@gmail.com>
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

Update it to reflect initrd removal.

Also I specified that error reports should
go to linux-doc@vger.kernel.org , because
Rob Landley said that he keeps getting
reports about this document and is unable
to fix them

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 .../filesystems/ramfs-rootfs-initramfs.rst    | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/filesystems/ramfs-rootfs-initramfs.rst b/Documentation/filesystems/ramfs-rootfs-initramfs.rst
index fa4f81099cb4..38a9cf11f547 100644
--- a/Documentation/filesystems/ramfs-rootfs-initramfs.rst
+++ b/Documentation/filesystems/ramfs-rootfs-initramfs.rst
@@ -8,6 +8,8 @@ October 17, 2005
 
 :Author: Rob Landley <rob@landley.net>
 
+Report errors in this document to <linux-doc@vger.kernel.org>
+
 What is ramfs?
 --------------
 
@@ -101,9 +103,9 @@ archive is extracted into it, the kernel will fall through to the older code
 to locate and mount a root partition, then exec some variant of /sbin/init
 out of that.
 
-All this differs from the old initrd in several ways:
+All this differs from the old initrd (removed in 2025) in several ways:
 
-  - The old initrd was always a separate file, while the initramfs archive is
+  - The old initrd was always a separate file, while the initramfs archive can be
     linked into the linux kernel image.  (The directory ``linux-*/usr`` is
     devoted to generating this archive during the build.)
 
@@ -137,7 +139,7 @@ Populating initramfs:
 
 The 2.6 kernel build process always creates a gzipped cpio format initramfs
 archive and links it into the resulting kernel binary.  By default, this
-archive is empty (consuming 134 bytes on x86).
+archive is nearly empty (consuming 134 bytes on x86).
 
 The config option CONFIG_INITRAMFS_SOURCE (in General Setup in menuconfig,
 and living in usr/Kconfig) can be used to specify a source for the
@@ -222,15 +224,13 @@ use in place of the above config file::
 External initramfs images:
 --------------------------
 
-If the kernel has initrd support enabled, an external cpio.gz archive can also
-be passed into a 2.6 kernel in place of an initrd.  In this case, the kernel
-will autodetect the type (initramfs, not initrd) and extract the external cpio
+If the kernel has CONFIG_BLK_DEV_INITRD enabled, an external cpio.gz archive can also
+be passed into a 2.6 kernel.  In this case, the kernel will extract the external cpio
 archive into rootfs before trying to run /init.
 
-This has the memory efficiency advantages of initramfs (no ramdisk block
-device) but the separate packaging of initrd (which is nice if you have
+This is nice if you have
 non-GPL code you'd like to run from initramfs, without conflating it with
-the GPL licensed Linux kernel binary).
+the GPL licensed Linux kernel binary.
 
 It can also be used to supplement the kernel's built-in initramfs image.  The
 files in the external archive will overwrite any conflicting files in
@@ -278,7 +278,7 @@ User Mode Linux, like so::
   EOF
   gcc -static hello.c -o init
   echo init | cpio -o -H newc | gzip > test.cpio.gz
-  # Testing external initramfs using the initrd loading mechanism.
+  # Testing external initramfs.
   qemu -kernel /boot/vmlinuz -initrd test.cpio.gz /dev/zero
 
 When debugging a normal root filesystem, it's nice to be able to boot with
-- 
2.47.2


