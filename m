Return-Path: <linux-fsdevel+bounces-77740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLJQJ+B6l2m7zAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 22:04:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 850E61628BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 22:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B61C63008D35
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 21:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B014A326D63;
	Thu, 19 Feb 2026 21:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ku3YBzA+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ABB32572C
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 21:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771535062; cv=none; b=SoDPed3bjXm60I12+oUY3ZPmaaUI7uHKmisiN6W7RhXmKdF+7qSWvP1881j97ZqbTc2gFY0LpwApUtbfVExQcjffioaG61+034dj9nsnlDNC5LfG1L31VwfyZHG7pZaLEhjlTX3fpRRy8R5z/ppDqd1PbZgxHv5P6+0ahJIphnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771535062; c=relaxed/simple;
	bh=NWOHX4wJiydvQJAKSbMHFM5RZCjj3ncDHBlFzgCjT4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUR0AXtJ/LakNpgzd9yyBW4yEO0NcRiREE9eMy+yTPFLsOVpeimqxteQ+2Pj0e/RVOmP/1wzmtwKET9vJ3wtxYydZA79M3AFcRBU8PEJDbIkixav0rz74lyu7qsYDKBe5GqXm+dst0zBKNVz1PEiyZoR8DN5GwEcA6i97KpNcIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ku3YBzA+; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4806f3fc50bso15676965e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 13:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771535059; x=1772139859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVSm2WaUuTGgvAJIQjX14NypR0jZFeVYy3dn1Snm/v8=;
        b=Ku3YBzA+OxzLMBBCY3BJvtOM96Bmlx7j33jJTXmk8CAR4/Y49QX+NTASHjFYLppcG9
         JObsimfqs1z/ALayEwJpjQ9S/vbms5VKuGPWETskqcP1GqNzipcV6telAL64WpvgI8L9
         amy4Ma68b7MyF7C6obhDU6+yP/lFlw61xxmPYcpR32tCJqGMTvIgxKVOMSy1UczbJZHR
         leI2C/WkuNB4r1C1zrp72O7Er5Gq+3t/eqQ1oQQgoMeMB0dj5JcWwxGHKbhusgj9gaDg
         UOLcyTX3BLN3bN9eKAGfgbPH+yg5Jbchfl3ol6yTFKzOk4fr8LItHMgFTLs3yb1B+NS8
         ZedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771535059; x=1772139859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XVSm2WaUuTGgvAJIQjX14NypR0jZFeVYy3dn1Snm/v8=;
        b=h4qhCwzsmF5XiOYRSLwDiAnmY7JN4XiQW+p5UZRCfbMOhGbQUuzXIm8H3BMPygBqMY
         uSBS5hq64BeXV1dS59FigPaOIkfl/RGg1uDBHXEkIf8E1jGSO9zlwFwS/7kJzPT0DTxl
         XxT9ndKfXSIfMRZ1Tk3Qu3afPgclH9l8M2Hej0urEFlo+05+5WxC8pQqG4RbSgfWAYNt
         nknWxpNEZ4Q16PxunFf2lFvOoGhlBc2fubjvt4jJkBkUCHWRApt5E7o4DGBfYYBftmrO
         Z2Dc/cD8mblYtF+912It1/6ZYWGXclWl+nz89Hio14T6DezAr1BNoTMMPA/xTWW6oOjF
         m93A==
X-Gm-Message-State: AOJu0YzLLfuR+i2aHwplanQGq7+GPNN/V4s8Md+loMBXEjArtZXfmPju
	DLdTBo9sL84pKabHmtne3n+S9QfVhpMW9xRZays+tOFBsOX943COgadf4iLneA==
X-Gm-Gg: AZuq6aI3S/XoDxG1Jg1ysUAKGvEUSBDXvfKYOsO+U+zCgvGNntqWxG+cY9IOQe/HwwC
	BE/q07HsGL/t94DakY5ZndUjrqm9GGYtikrw3wL9z7vxcsrR+OY7ABubmzw0qtDS6n20Nry+mfg
	pmULcHiZzwZgBm5CyiqQakO/fUXbKiTIMNvgGAE6ckE1I6zPM+C0X3fA9o6PGjpfe+y5EsL5x0z
	StHFYexXWn8Py/0JOFaCDNcegLshp5yrRj9Xy9daAh2Ov1bflOflLYCNWRDI9zh515p6EAVk5At
	pLFF3DRWVWwGlcV2LnRrh5jxjZxdkB3xTxAX1mwKSaIN9sfNDwlF9DTyrrbIiNXknyNgY/VoX0G
	rabrMrnyf27d2UQhPvtk90GSC1vRPdS9L+eAvMNZdIQgCiQDHHfGWmroxzJokAIXt82dFEzZ5pz
	r8n5twhJanSphYlhMiCvM=
X-Received: by 2002:a05:600c:1c19:b0:483:5310:dc67 with SMTP id 5b1f17b1804b1-48379be817cmr365806455e9.20.1771535058446;
        Thu, 19 Feb 2026 13:04:18 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-483a3dd3391sm7201895e9.1.2026.02.19.13.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 13:04:18 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	initramfs@vger.kernel.org,
	Rob Landley <rob@landley.net>,
	David Disseldorp <ddiss@suse.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	patches@lists.linux.dev
Subject: [PATCH 1/2] init: ensure that /dev/console is (nearly) always available in initramfs
Date: Thu, 19 Feb 2026 21:03:11 +0000
Message-ID: <20260219210312.3468980-2-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260219210312.3468980-1-safinaskar@gmail.com>
References: <20260219210312.3468980-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77740-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,checkpatch.pl:url]
X-Rspamd-Queue-Id: 850E61628BB
X-Rspamd-Action: no action

If we generate external initramfs as normal user using "cpio"
command, then we cannot put /dev/console there.

Fortunately, in this case default builtin initramfs will
contain /dev/console (before this commit).

But if we generate builtin initramfs instead, then we will
not have /dev/console at all. Thus the kernel will be unable to
open /dev/console, and PID 1 will have stdin, stdout and stderr
closed.

This problem can be solved by using gen_init_cpio.

But I think that proper solution is to ensure that /dev/console
is always available, no matter what. This is quality-of-implementation
feature. This will reduce number of possible failure modes. And
this will make easier for developers to get early boot right.
(Early boot issues are very hard to debug.)

So I put to the beginning of function "do_populate_rootfs" a code, which
creates nodes /dev, /dev/console and /root. This ensures that
they are always available even if both builtin and external
initramfses don't contain them.

The kernel itself relies on presence of these nodes. It uses
/dev/console in "console_on_rootfs" and /root in "do_mount_root".
So, ensuring that they are always available is right thing to do.

But then code in the beginning of "do_populate_rootfs" becomes
very similar to the code in "default_rootfs". So I extract
a common helper named "create_basic_rootfs".

Also I replace S_IRUSR | S_IWUSR with 0600 (suggested by checkpatch.pl).

Then nodes in usr/default_cpio_list become not needed,
so I make this file empty.

(In fact, this patch doesn't ensure that /dev/console is truly
always available. You can still break it if you create
bad /dev/console in builtin or external initramfs. So I
update comment on "console_on_rootfs".)

This patch makes default builtin initramfs truly empty.
This happens to match description in ramfs-rootfs-initramfs.rst.
But that description says that size of this initramfs is 134 bytes.
This is wrong. I checked: its size is 512 bytes (and default
builtin initramfs is always uncompressed). So I just remove that
number. While I'm there, I remove word "gzipped",
because builtin initramfs may be also uncompressed or compressed
using different algorithm.

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 .../filesystems/ramfs-rootfs-initramfs.rst    |  4 +--
 init/do_mounts.c                              |  8 ++++++
 init/do_mounts.h                              |  2 ++
 init/initramfs.c                              |  2 ++
 init/main.c                                   |  6 +++-
 init/noinitramfs.c                            | 28 +++----------------
 usr/Makefile                                  |  2 +-
 usr/default_cpio_list                         |  6 +---
 8 files changed, 25 insertions(+), 33 deletions(-)

diff --git a/Documentation/filesystems/ramfs-rootfs-initramfs.rst b/Documentation/filesystems/ramfs-rootfs-initramfs.rst
index 165117a721ce..c6451692294f 100644
--- a/Documentation/filesystems/ramfs-rootfs-initramfs.rst
+++ b/Documentation/filesystems/ramfs-rootfs-initramfs.rst
@@ -133,9 +133,9 @@ All this differs from the old initrd in several ways:
 Populating initramfs:
 ---------------------
 
-The 2.6 kernel build process always creates a gzipped cpio format initramfs
+The kernel build process always creates a cpio format initramfs
 archive and links it into the resulting kernel binary.  By default, this
-archive is empty (consuming 134 bytes on x86).
+archive is empty.
 
 The config option CONFIG_INITRAMFS_SOURCE (in General Setup in menuconfig,
 and living in usr/Kconfig) can be used to specify a source for the
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 55ed3ac0b70f..f911280a348e 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -519,3 +519,11 @@ void __init init_rootfs(void)
 			is_tmpfs = true;
 	}
 }
+
+void __init create_basic_rootfs(void)
+{
+	WARN_ON_ONCE(init_mkdir("/dev", 0755) != 0);
+	WARN_ON_ONCE(init_mknod("/dev/console", S_IFCHR | 0600,
+			new_encode_dev(MKDEV(5, 1))) != 0);
+	WARN_ON_ONCE(init_mkdir("/root", 0700) != 0);
+}
diff --git a/init/do_mounts.h b/init/do_mounts.h
index a386ee5314c9..907e9af77464 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -16,6 +16,8 @@ void  mount_root_generic(char *name, char *pretty_name, int flags);
 void  mount_root(char *root_device_name);
 extern int root_mountflags;
 
+void __init create_basic_rootfs(void);
+
 static inline __init int create_dev(char *name, dev_t dev)
 {
 	init_unlink(name);
diff --git a/init/initramfs.c b/init/initramfs.c
index 6ddbfb17fb8f..678b5050a7ac 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -717,6 +717,8 @@ static void __init populate_initrd_image(char *err)
 
 static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
 {
+	create_basic_rootfs();
+
 	/* Load the built in initramfs */
 	char *err = unpack_to_rootfs(__initramfs_start, __initramfs_size);
 	if (err)
diff --git a/init/main.c b/init/main.c
index 1cb395dd94e4..76f5320d3d4c 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1645,7 +1645,11 @@ static int __ref kernel_init(void *unused)
 	      "See Linux Documentation/admin-guide/init.rst for guidance.");
 }
 
-/* Open /dev/console, for stdin/stdout/stderr, this should never fail */
+/*
+ * Open /dev/console, for stdin/stdout/stderr, this should never fail,
+ * unless you intentionally make it fail, for example, by supplying
+ * wrong /dev/console in initramfs
+ */
 void __init console_on_rootfs(void)
 {
 	struct file *file = filp_open("/dev/console", O_RDWR, 0);
diff --git a/init/noinitramfs.c b/init/noinitramfs.c
index d1d26b93d25c..00bcf59cf05d 100644
--- a/init/noinitramfs.c
+++ b/init/noinitramfs.c
@@ -6,37 +6,17 @@
  * Author: Jean-Paul Saman <jean-paul.saman@nxp.com>
  */
 #include <linux/init.h>
-#include <linux/stat.h>
-#include <linux/kdev_t.h>
-#include <linux/syscalls.h>
-#include <linux/init_syscalls.h>
 #include <linux/umh.h>
 
+#include "do_mounts.h"
+
 /*
- * Create a simple rootfs that is similar to the default initramfs
+ * Create a simple rootfs
  */
 static int __init default_rootfs(void)
 {
-	int err;
-
 	usermodehelper_enable();
-	err = init_mkdir("/dev", 0755);
-	if (err < 0)
-		goto out;
-
-	err = init_mknod("/dev/console", S_IFCHR | S_IRUSR | S_IWUSR,
-			new_encode_dev(MKDEV(5, 1)));
-	if (err < 0)
-		goto out;
-
-	err = init_mkdir("/root", 0700);
-	if (err < 0)
-		goto out;
-
+	create_basic_rootfs();
 	return 0;
-
-out:
-	printk(KERN_WARNING "Failed to create a rootfs\n");
-	return err;
 }
 rootfs_initcall(default_rootfs);
diff --git a/usr/Makefile b/usr/Makefile
index e8f42478a0b7..de1ee4e78ef4 100644
--- a/usr/Makefile
+++ b/usr/Makefile
@@ -22,7 +22,7 @@ ramfs-input := $(CONFIG_INITRAMFS_SOURCE)
 cpio-data :=
 
 # If CONFIG_INITRAMFS_SOURCE is empty, generate a small initramfs with the
-# default contents.
+# contents, specified in default_cpio_list, which is currently empty.
 ifeq ($(ramfs-input),)
 ramfs-input := $(src)/default_cpio_list
 endif
diff --git a/usr/default_cpio_list b/usr/default_cpio_list
index 37b3864066e8..1df1ef08e504 100644
--- a/usr/default_cpio_list
+++ b/usr/default_cpio_list
@@ -1,6 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-# This is a very simple, default initramfs
-
-dir /dev 0755 0 0
-nod /dev/console 0600 0 0 c 5 1
-dir /root 0700 0 0
+# Default initramfs is empty
-- 
2.47.3


