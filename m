Return-Path: <linux-fsdevel+bounces-61175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7366BB55C5E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 03:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A19771CC7D16
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 01:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DE61A3142;
	Sat, 13 Sep 2025 01:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8rWdZ3v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9665417C203
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Sep 2025 01:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757725317; cv=none; b=l+elTdBltMBKC4phYJl4PUIq3/hiDr4e0lmCiwHhgDNeMiKdZMQUNmGa5BMnBfy3hlGXdvJvgmCTSMhqH+GiR8ERIUzgXieMKd200jCBWfhoeJsQWHQC9Hvq8hKQl5/ropWhhSIAGLiN9Li5xMTPo+vZM1+YfjgEpniiI4CByO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757725317; c=relaxed/simple;
	bh=ZZkhjwhbE6/y3ircTGqTXeD3vHrC5P1n1IkbBCMXiHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FGI/U7ExlqGDfqKXM4zUtkCSeENF+uz9Tdh+NDj9f+yMeHR4DCj7moYKlSTJArP8DeP71OLUzsdVijHzcSGrdmvxu/T0v/zhl95HAk81zfeQIAy6mIW1ALXCF/vvaGS/Gziql8DTvL6kxabqiHRvfMh8X0PAzzpflZfjEHWJCQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8rWdZ3v; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b0428b537e5so362915166b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 18:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757725311; x=1758330111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZEc0E3RkrtT53PvUmeExPdZ+yV/ZVWq9ufU5BOWTEg=;
        b=Q8rWdZ3vPQO1IDpapVGlhe3nSOw6j7XOwKTltsOQUoqihFACKG7eINVSNY+6Egf1rz
         90lgEMndfc+LJNqp6Bw9t8ThVQ9YcGTLnXt4oOQQjnIiW539pIwvpIKLF2/M1970rnmG
         pF64Klv2fcCQ12ZentyM3dPxge5HtBxxT1o0lSI5zeEIQ6oEBFm+nmc0OIU8DRXsa8AF
         PHG5ixPgYhjikb9K0Kk7wBIAta4uu/bmCq+LgT6KPw9CuIbMv9L+7pWh69ssFc/sVlxg
         2+UB7ZZgZABxPVpf6CdhmNDZ+v4yJor6u01ZLFjrHuprYzxjaWXtkZ0Xqy+GHquIIOw7
         6Lfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757725311; x=1758330111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZEc0E3RkrtT53PvUmeExPdZ+yV/ZVWq9ufU5BOWTEg=;
        b=jAMPe9FdGSNxQVjd5NnroZlI7GIMcSqMY8KHMRoxb3jSwbQ1v7j0RQQ/VEuuUqNR5z
         LKN7HGWi/G8PoWMr2Y7p0U3B/g9BszNkPxa7/TQsMfzS5QqDijheiFkXmRMJ9CwkByMa
         GL6LIoJk/H9b6K7FhPc7mRLNP1dv8JTZn3jNsvG/SQ51T1YDV/ydoG5S1zDpoFtrve4J
         X5tP3YYGR01ikW6nmmXcUqxKNfeHBG329D1Tkl5AODHd1aywJQCY+jtz6HGu3YiLeV9b
         DY5dvPZWx1i30qDfUUi/J/uRCq0PNkHfQX9AgUdOySGgFeBt1aY/dwuIf4qClFMpv0uX
         j9Hw==
X-Gm-Message-State: AOJu0YwS7w37D9s2QXKn8HnMl13FvLhLHncf31VTJvnoKWs2VXosHv7k
	k9qk+roeQhtpFJoLuW+UV6tU4pUDRHD/IvS36SYbiDTXuIcELlNxsHslWfmbyv5o
X-Gm-Gg: ASbGncu3HWyezrhXDq1X/OttuiNnx+KTsSSrLBcRtcR8V25/cfs98Ari+bYdANnQwuT
	ND4Af452Qub2DKuHAtd0/NfM8Nc56v0WdnwEy9O9PSE+QrGSto2S99gbwvsO0KSiZrNQm8IAdzT
	dmpKN6oIwWRriGNHJ4kFWA+X3HqGW0f6rcxiM4IjxVWhqK0eDWF9iOdJfnL8Tn2iy0v+RXXcT2a
	pS6tX37Q8JK3Xr24Ta3LwntdSUay4UcWGSqxkc8YoL7eaOFjDAA23XmCekjib/K2pruS9s58kkA
	Gerwm/xcN5hG56JCrGFkHyFHL9lelfjJiPiB1VYFkSxiShAOXyIfNIBP8/cgqe1D1tnDX4Xgl42
	PpNqtXa/YydEH3sdoYJfU1At8k0URLQ==
X-Google-Smtp-Source: AGHT+IEAi4xtonmhCaT33K2Hzh7yyRfMcFV0HvMSUAxXUtkPqhwfRFML0tJIQIoV7OGJ/h1kr7fV7w==
X-Received: by 2002:a17:907:3d0c:b0:b04:7880:3e8c with SMTP id a640c23a62f3a-b07c3820252mr475574166b.38.1757725311044;
        Fri, 12 Sep 2025 18:01:51 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b317124esm476784166b.46.2025.09.12.18.01.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 18:01:50 -0700 (PDT)
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
Subject: [PATCH RESEND 20/62] doc: remove Documentation/power/swsusp-dmcrypt.rst
Date: Sat, 13 Sep 2025 00:37:59 +0000
Message-ID: <20250913003842.41944-21-safinaskar@gmail.com>
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

It contains obsolete initrd and lilo based instructions

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 Documentation/power/index.rst                 |   1 -
 Documentation/power/swsusp-dmcrypt.rst        | 140 ------------------
 .../translations/zh_CN/power/index.rst        |   1 -
 3 files changed, 142 deletions(-)
 delete mode 100644 Documentation/power/swsusp-dmcrypt.rst

diff --git a/Documentation/power/index.rst b/Documentation/power/index.rst
index a0f5244fb427..9f1758c92e48 100644
--- a/Documentation/power/index.rst
+++ b/Documentation/power/index.rst
@@ -22,7 +22,6 @@ Power Management
     suspend-and-cpuhotplug
     suspend-and-interrupts
     swsusp-and-swap-files
-    swsusp-dmcrypt
     swsusp
     video
     tricks
diff --git a/Documentation/power/swsusp-dmcrypt.rst b/Documentation/power/swsusp-dmcrypt.rst
deleted file mode 100644
index afb29a58fdf8..000000000000
--- a/Documentation/power/swsusp-dmcrypt.rst
+++ /dev/null
@@ -1,140 +0,0 @@
-=======================================
-How to use dm-crypt and swsusp together
-=======================================
-
-Author: Andreas Steinmetz <ast@domdv.de>
-
-
-
-Some prerequisites:
-You know how dm-crypt works. If not, visit the following web page:
-http://www.saout.de/misc/dm-crypt/
-You have read Documentation/power/swsusp.rst and understand it.
-You did read Documentation/filesystems/ramfs-rootfs-initramfs.rst and know how an initrd works.
-You know how to create or how to modify an initrd.
-
-Now your system is properly set up, your disk is encrypted except for
-the swap device(s) and the boot partition which may contain a mini
-system for crypto setup and/or rescue purposes. You may even have
-an initrd that does your current crypto setup already.
-
-At this point you want to encrypt your swap, too. Still you want to
-be able to suspend using swsusp. This, however, means that you
-have to be able to either enter a passphrase or that you read
-the key(s) from an external device like a pcmcia flash disk
-or an usb stick prior to resume. So you need an initrd, that sets
-up dm-crypt and then asks swsusp to resume from the encrypted
-swap device.
-
-The most important thing is that you set up dm-crypt in such
-a way that the swap device you suspend to/resume from has
-always the same major/minor within the initrd as well as
-within your running system. The easiest way to achieve this is
-to always set up this swap device first with dmsetup, so that
-it will always look like the following::
-
-  brw-------  1 root root 254, 0 Jul 28 13:37 /dev/mapper/swap0
-
-Now set up your kernel to use /dev/mapper/swap0 as the default
-resume partition, so your kernel .config contains::
-
-  CONFIG_PM_STD_PARTITION="/dev/mapper/swap0"
-
-Prepare your boot loader to use the initrd you will create or
-modify. For lilo the simplest setup looks like the following
-lines::
-
-  image=/boot/vmlinuz
-  initrd=/boot/initrd.gz
-  label=linux
-  append="root=/dev/ram0 init=/linuxrc rw"
-
-Finally you need to create or modify your initrd. Lets assume
-you create an initrd that reads the required dm-crypt setup
-from a pcmcia flash disk card. The card is formatted with an ext2
-fs which resides on /dev/hde1 when the card is inserted. The
-card contains at least the encrypted swap setup in a file
-named "swapkey". /etc/fstab of your initrd contains something
-like the following::
-
-  /dev/hda1   /mnt    ext3      ro                            0 0
-  none        /proc   proc      defaults,noatime,nodiratime   0 0
-  none        /sys    sysfs     defaults,noatime,nodiratime   0 0
-
-/dev/hda1 contains an unencrypted mini system that sets up all
-of your crypto devices, again by reading the setup from the
-pcmcia flash disk. What follows now is a /linuxrc for your
-initrd that allows you to resume from encrypted swap and that
-continues boot with your mini system on /dev/hda1 if resume
-does not happen::
-
-  #!/bin/sh
-  PATH=/sbin:/bin:/usr/sbin:/usr/bin
-  mount /proc
-  mount /sys
-  mapped=0
-  noresume=`grep -c noresume /proc/cmdline`
-  if [ "$*" != "" ]
-  then
-    noresume=1
-  fi
-  dmesg -n 1
-  /sbin/cardmgr -q
-  for i in 1 2 3 4 5 6 7 8 9 0
-  do
-    if [ -f /proc/ide/hde/media ]
-    then
-      usleep 500000
-      mount -t ext2 -o ro /dev/hde1 /mnt
-      if [ -f /mnt/swapkey ]
-      then
-        dmsetup create swap0 /mnt/swapkey > /dev/null 2>&1 && mapped=1
-      fi
-      umount /mnt
-      break
-    fi
-    usleep 500000
-  done
-  killproc /sbin/cardmgr
-  dmesg -n 6
-  if [ $mapped = 1 ]
-  then
-    if [ $noresume != 0 ]
-    then
-      mkswap /dev/mapper/swap0 > /dev/null 2>&1
-    fi
-    echo 254:0 > /sys/power/resume
-    dmsetup remove swap0
-  fi
-  umount /sys
-  mount /mnt
-  umount /proc
-  cd /mnt
-  pivot_root . mnt
-  mount /proc
-  umount -l /mnt
-  umount /proc
-  exec chroot . /sbin/init $* < dev/console > dev/console 2>&1
-
-Please don't mind the weird loop above, busybox's msh doesn't know
-the let statement. Now, what is happening in the script?
-First we have to decide if we want to try to resume, or not.
-We will not resume if booting with "noresume" or any parameters
-for init like "single" or "emergency" as boot parameters.
-
-Then we need to set up dmcrypt with the setup data from the
-pcmcia flash disk. If this succeeds we need to reset the swap
-device if we don't want to resume. The line "echo 254:0 > /sys/power/resume"
-then attempts to resume from the first device mapper device.
-Note that it is important to set the device in /sys/power/resume,
-regardless if resuming or not, otherwise later suspend will fail.
-If resume starts, script execution terminates here.
-
-Otherwise we just remove the encrypted swap device and leave it to the
-mini system on /dev/hda1 to set the whole crypto up (it is up to
-you to modify this to your taste).
-
-What then follows is the well known process to change the root
-file system and continue booting from there. I prefer to unmount
-the initrd prior to continue booting but it is up to you to modify
-this.
diff --git a/Documentation/translations/zh_CN/power/index.rst b/Documentation/translations/zh_CN/power/index.rst
index bc54983ba515..4ee880e65107 100644
--- a/Documentation/translations/zh_CN/power/index.rst
+++ b/Documentation/translations/zh_CN/power/index.rst
@@ -32,7 +32,6 @@ TODOList:
     * suspend-and-cpuhotplug
     * suspend-and-interrupts
     * swsusp-and-swap-files
-    * swsusp-dmcrypt
     * swsusp
     * video
     * tricks
-- 
2.47.2


