Return-Path: <linux-fsdevel+bounces-63729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 65088BCC668
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 11:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 045634FCF4D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 09:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40E32D063E;
	Fri, 10 Oct 2025 09:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnAOXH22"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3255F275B18
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 09:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760089342; cv=none; b=peNsSoKBYN8cB47G1SQZObqkCm4v4IBxIKgctyZBTi6xgTpkTCnX30Uj2OzKWt9+nxpoB7MRJrYxWHYvzBQVrFWgPdUFHVCM+ms1MFD05ECZvagSoetEnhpxbaO+gI94SDbAANwlzYGVVcqSSoz+gjxKjtDQgqad9a7w/tsoEbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760089342; c=relaxed/simple;
	bh=vpQ+LSLHouZBwGQBSVAWIUVgEf6yUW/Fn0AY8RH0AoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XezJDeqGh4tLqqc0gnyk5fwBbNx7k7PFoVDVtcJ+iZOqJjpWbFoIVNQnWZfGkmBZAnmfswXhei6ymZeFIL8FIJ9BWDIqdvvH4gdZjpG3aNjWMIRaxyt7KLSKW4vq2eN8V3/iL44aPhnkOD39sh4gTVL17xEGRfl37PUB+bFExUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnAOXH22; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e52279279so12851625e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 02:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760089336; x=1760694136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yB+XQb9dVBYMVnL4S8fyMdF/923o0cYSVo05HxH73v4=;
        b=TnAOXH22joUBWeDFi3SJV91CLC4+/N0+FB/jANT4nnEvRw297wobaPMZhQcosUqoVn
         MfeMc68XOFLZ5wTi1GSj/sXxDUtSyRG8/1wEK/iqjAnPOeC35dmCFdhWA+zZjQ4kCmUK
         85plJ6WJV/Rd5RPq9L4Pi/eyWc43r9imFtFeObShrzKVKMEoQV3cERBfIwP10xUb0Ol9
         pBwf71B24jw7pRoP39HFculG6cDtNGvJzwuy5n8zZ5B1GXs7JrbQbLifqjPo6wKHBhpx
         XoHm1TISiXBZMj949r7qFjJzG7uPyPo+xQM4Mw/amx+r2cN1M5PfkaokgmGX4ykmGOmW
         Jcnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760089336; x=1760694136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yB+XQb9dVBYMVnL4S8fyMdF/923o0cYSVo05HxH73v4=;
        b=YIok795hRcitKEfDmuXY6hgJ30FovnrjWf1JXH7yo3Vk1RtHY32GLGYdnicRiQ3sDR
         UZMBdPo5dBADOwJk4u09fxAodDAGNlCWnCFsFT1BS/Coq88UD7NdO4q9SaXSgs1UEBEk
         IBO/Kqo0gwCnwKTpX02cyo+21yyyN5tcy1bmCaRqzwY3/8BO9YS33YVxDsKtplkbQQ7N
         s28DPpC7Ger6XnXPyBEHEYzlNFbwLE5ZIE8r8uXsgyB8EDk+rcZoWmz6CSbKHthLD0N0
         KMob6Jt1VzFxlArWcmJ6pAfijnvLLJheSphdfs2PaCQt9I3asSMvdw+aM4xMTmWyaJ0I
         GN5w==
X-Gm-Message-State: AOJu0Yy/pFiyZuoeLyVUaueoxJF5Psvd+6u/n4Q6s9cot+0PNd+a3CJZ
	ezDabcLqFGvMAhKnsCY5DaA+LGCIZ/sTQatvoxoiIOMeM9LVjiJ+fTx1NLxap61m
X-Gm-Gg: ASbGncvRlRXROjuCG8J2I7wnZsJ8Koc7RCKPlYP5ihsYBhnE7ChHB7s4hlou5wlg3U7
	mILGCJ81CItn+fzr4yFd5GttSxgYYvHnRvt+KleUW2iRqeMZAI4hvmm3h8XVuTQ4mJr88E4xhMg
	pF7kKXlTuOuQv+OaveL/DWtCDKYniErRbq29H/mTolZyJ5SDncCZgmOA9BeCxKNMZKfONCoYTyj
	1WbHOKaD/jeLWOLNvHzcDvTkPoPe1lZYPwJKpyczJqBXSl6HX70qJjnhbkh2gJ2IG9LAil4GiFc
	a/+Pd34irGL+wvDZpyVNqbqClMdNpd+krvuZRAIlLMMcAXzGN5HObKNebMkn4aimCdS6B4eAEdU
	0Ji3qL9yNo6K/tfwpuVoYYUk4ZOAP2J+PxJijPA==
X-Google-Smtp-Source: AGHT+IGhj1/Xta/HDezSCHmYKGPM6KRR6NesF+F9b2XmUayFL7V4iH3QP/fT9tINiA4R8cJX5aHPpA==
X-Received: by 2002:a05:600c:6383:b0:45d:d353:a491 with SMTP id 5b1f17b1804b1-46fa9a8c425mr74390025e9.1.1760089336065;
        Fri, 10 Oct 2025 02:42:16 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46fab3d7df4sm59813525e9.1.2025.10.10.02.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 02:42:15 -0700 (PDT)
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
	Alexander Graf <graf@amazon.com>,
	Rob Landley <rob@landley.net>,
	Lennart Poettering <mzxreary@0pointer.de>,
	linux-arch@vger.kernel.org,
	linux-block@vger.kernel.org,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Heiko Carstens <hca@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dave Young <dyoung@redhat.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Jessica Clarke <jrtc27@jrtc27.com>,
	Nicolas Schichan <nschichan@freebox.fr>,
	David Disseldorp <ddiss@suse.de>,
	patches@lists.linux.dev
Subject: [PATCH v2 1/3] init: remove deprecated "load_ramdisk" and "prompt_ramdisk" command line parameters
Date: Fri, 10 Oct 2025 09:40:45 +0000
Message-ID: <20251010094047.3111495-2-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251010094047.3111495-1-safinaskar@gmail.com>
References: <20251010094047.3111495-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

...which do nothing. They were deprecated (in documentation) in
6b99e6e6aa62 ("Documentation/admin-guide: blockdev/ramdisk: remove use of
"rdev"") and in kernel messages in c8376994c86c ("initrd: remove support
for multiple floppies")

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 ----
 arch/arm/configs/neponset_defconfig             | 2 +-
 init/do_mounts.c                                | 7 -------
 init/do_mounts_rd.c                             | 7 -------
 4 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e019db1633fd..521ab3425504 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3280,8 +3280,6 @@
 			If there are multiple matching configurations changing
 			the same attribute, the last one is used.
 
-	load_ramdisk=	[RAM] [Deprecated]
-
 	lockd.nlm_grace_period=P  [NFS] Assign grace period.
 			Format: <integer>
 
@@ -5245,8 +5243,6 @@
 			Param: <number> - step/bucket size as a power of 2 for
 				statistical time based profiling.
 
-	prompt_ramdisk=	[RAM] [Deprecated]
-
 	prot_virt=	[S390] enable hosting protected virtual machines
 			isolated from the hypervisor (if hardware supports
 			that). If enabled, the default kernel base address
diff --git a/arch/arm/configs/neponset_defconfig b/arch/arm/configs/neponset_defconfig
index 2227f86100ad..4d720001c12e 100644
--- a/arch/arm/configs/neponset_defconfig
+++ b/arch/arm/configs/neponset_defconfig
@@ -9,7 +9,7 @@ CONFIG_ASSABET_NEPONSET=y
 CONFIG_ZBOOT_ROM_TEXT=0x80000
 CONFIG_ZBOOT_ROM_BSS=0xc1000000
 CONFIG_ZBOOT_ROM=y
-CONFIG_CMDLINE="console=ttySA0,38400n8 cpufreq=221200 rw root=/dev/mtdblock2 mtdparts=sa1100:512K(boot),1M(kernel),2560K(initrd),4M(root) load_ramdisk=1 prompt_ramdisk=0 mem=32M noinitrd initrd=0xc0800000,3M"
+CONFIG_CMDLINE="console=ttySA0,38400n8 cpufreq=221200 rw root=/dev/mtdblock2 mtdparts=sa1100:512K(boot),1M(kernel),2560K(initrd),4M(root) mem=32M noinitrd initrd=0xc0800000,3M"
 CONFIG_FPE_NWFPE=y
 CONFIG_PM=y
 CONFIG_MODULES=y
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 6af29da8889e..0f2f44e6250c 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -34,13 +34,6 @@ static int root_wait;
 
 dev_t ROOT_DEV;
 
-static int __init load_ramdisk(char *str)
-{
-	pr_warn("ignoring the deprecated load_ramdisk= option\n");
-	return 1;
-}
-__setup("load_ramdisk=", load_ramdisk);
-
 static int __init readonly(char *str)
 {
 	if (*str)
diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index 19d9f33dcacf..5311f2d7edc8 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -18,13 +18,6 @@
 static struct file *in_file, *out_file;
 static loff_t in_pos, out_pos;
 
-static int __init prompt_ramdisk(char *str)
-{
-	pr_warn("ignoring the deprecated prompt_ramdisk= option\n");
-	return 1;
-}
-__setup("prompt_ramdisk=", prompt_ramdisk);
-
 int __initdata rd_image_start;		/* starting block # of image */
 
 static int __init ramdisk_start_setup(char *str)
-- 
2.47.3


