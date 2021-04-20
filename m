Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B94D365EDC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 19:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbhDTR5X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 13:57:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59788 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232473AbhDTR5S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 13:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618941406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=afa6Hv1Y+nEnC6nqP5aByitRJ6Vc/us+E9c6JL1buB0=;
        b=bWsjA20q2cvwYRTiX8nNvEdWxLOFXK3GERotS2Ca2FUeAHg2lI9QoixKw8VMjq8pk9RWmt
        7Ixa4ryQsNu92YUj+CFZDNzS677VeWwPGnxRYYJDwDeP5aLOr4+fehKO83BdrPk+H59dPk
        PlGcnBhuVyZ9+IL8z4MJe71HdESj4LA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-wWBJTFitOxWFtL4G6Wub8g-1; Tue, 20 Apr 2021 13:56:41 -0400
X-MC-Unique: wWBJTFitOxWFtL4G6Wub8g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7505184BA40;
        Tue, 20 Apr 2021 17:56:39 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-170.ams2.redhat.com [10.36.114.170])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 82A145D6AB;
        Tue, 20 Apr 2021 17:56:32 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-alpha@vger.kernel.org
Subject: [PATCH v1] binfmt: remove support for em86 (alpha only)
Date:   Tue, 20 Apr 2021 19:56:31 +0200
Message-Id: <20210420175631.46923-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We have a fairly specific alpha binary loader in Linux: running x86
(i386, i486) binaries via the em86 [1] emulator. As noted in the Kconfig
option, the same behavior can be achieved via binfmt_misc, for example,
more nowadays used for running qemu-user.

An example on how to get binfmt_misc running with em86 can be found in
Documentation/admin-guide/binfmt-misc.rst

The defconfig does not have CONFIG_BINFMT_EM86=y set. And doing a
	make defconfig && make olddefconfig
results in
	# CONFIG_BINFMT_EM86 is not set

... as we don't seem to have any supported Linux distirbution for alpha
anymore, there isn't really any "default" user of that feature anymore.

Searching for "CONFIG_BINFMT_EM86=y" reveals mostly discussions from
around 20 years ago, like [2] describing how to get netscape via em86
running via em86, or [3] discussing that running wine or installing
Win 3.11 through em86 would be a nice feature.

The latest binaries available for em86 are from 2000, version 2.2.1 [4] --
which translates to "unsupported"; further, em86 doesn't even work with
glibc-2.x but only with glibc-2.0 [4, 5]. These are clear signs that
there might not be too many em86 users out there, especially users
relying on modern Linux kernels.

Even though the code footprint is relatively small, let's just get rid
of this blast from the past that's effectively unused.

[1] http://ftp.dreamtime.org/pub/linux/Linux-Alpha/em86/v0.4/docs/em86.html
[2] https://static.lwn.net/1998/1119/a/alpha-netscape.html
[3] https://groups.google.com/g/linux.debian.alpha/c/AkGuQHeCe0Y
[4] http://zeniv.linux.org.uk/pub/linux/alpha/em86/v2.2-1/relnotes.2.2.1.html
[5] https://forum.teamspeak.com/archive/index.php/t-1477.html

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-api@vger.kernel.org
Cc: linux-alpha@vger.kernel.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/Kconfig.binfmt |  15 -------
 fs/Makefile       |   1 -
 fs/binfmt_em86.c  | 110 ----------------------------------------------
 3 files changed, 126 deletions(-)
 delete mode 100644 fs/binfmt_em86.c

diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index c6f1c8c1934e..8720e0a30005 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -165,21 +165,6 @@ config OSF4_COMPAT
 	  with v4 shared libraries freely available from Compaq. If you're
 	  going to use shared libraries from Tru64 version 5.0 or later, say N.
 
-config BINFMT_EM86
-	tristate "Kernel support for Linux/Intel ELF binaries"
-	depends on ALPHA
-	help
-	  Say Y here if you want to be able to execute Linux/Intel ELF
-	  binaries just like native Alpha binaries on your Alpha machine. For
-	  this to work, you need to have the emulator /usr/bin/em86 in place.
-
-	  You can get the same functionality by saying N here and saying Y to
-	  "Kernel support for MISC binaries".
-
-	  You may answer M to compile the emulation support as a module and
-	  later load the module when you want to use a Linux/Intel binary. The
-	  module will be called binfmt_em86. If unsure, say Y.
-
 config BINFMT_MISC
 	tristate "Kernel support for MISC binaries"
 	help
diff --git a/fs/Makefile b/fs/Makefile
index 3215fe205256..c92e403c53f8 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -39,7 +39,6 @@ obj-$(CONFIG_FS_ENCRYPTION)	+= crypto/
 obj-$(CONFIG_FS_VERITY)		+= verity/
 obj-$(CONFIG_FILE_LOCKING)      += locks.o
 obj-$(CONFIG_BINFMT_AOUT)	+= binfmt_aout.o
-obj-$(CONFIG_BINFMT_EM86)	+= binfmt_em86.o
 obj-$(CONFIG_BINFMT_MISC)	+= binfmt_misc.o
 obj-$(CONFIG_BINFMT_SCRIPT)	+= binfmt_script.o
 obj-$(CONFIG_BINFMT_ELF)	+= binfmt_elf.o
diff --git a/fs/binfmt_em86.c b/fs/binfmt_em86.c
deleted file mode 100644
index 06b9b9fddf70..000000000000
--- a/fs/binfmt_em86.c
+++ /dev/null
@@ -1,110 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- *  linux/fs/binfmt_em86.c
- *
- *  Based on linux/fs/binfmt_script.c
- *  Copyright (C) 1996  Martin von Löwis
- *  original #!-checking implemented by tytso.
- *
- *  em86 changes Copyright (C) 1997  Jim Paradis
- */
-
-#include <linux/module.h>
-#include <linux/string.h>
-#include <linux/stat.h>
-#include <linux/binfmts.h>
-#include <linux/elf.h>
-#include <linux/init.h>
-#include <linux/fs.h>
-#include <linux/file.h>
-#include <linux/errno.h>
-
-
-#define EM86_INTERP	"/usr/bin/em86"
-#define EM86_I_NAME	"em86"
-
-static int load_em86(struct linux_binprm *bprm)
-{
-	const char *i_name, *i_arg;
-	char *interp;
-	struct file * file;
-	int retval;
-	struct elfhdr	elf_ex;
-
-	/* Make sure this is a Linux/Intel ELF executable... */
-	elf_ex = *((struct elfhdr *)bprm->buf);
-
-	if (memcmp(elf_ex.e_ident, ELFMAG, SELFMAG) != 0)
-		return  -ENOEXEC;
-
-	/* First of all, some simple consistency checks */
-	if ((elf_ex.e_type != ET_EXEC && elf_ex.e_type != ET_DYN) ||
-		(!((elf_ex.e_machine == EM_386) || (elf_ex.e_machine == EM_486))) ||
-		!bprm->file->f_op->mmap) {
-			return -ENOEXEC;
-	}
-
-	/* Need to be able to load the file after exec */
-	if (bprm->interp_flags & BINPRM_FLAGS_PATH_INACCESSIBLE)
-		return -ENOENT;
-
-	/* Unlike in the script case, we don't have to do any hairy
-	 * parsing to find our interpreter... it's hardcoded!
-	 */
-	interp = EM86_INTERP;
-	i_name = EM86_I_NAME;
-	i_arg = NULL;		/* We reserve the right to add an arg later */
-
-	/*
-	 * Splice in (1) the interpreter's name for argv[0]
-	 *           (2) (optional) argument to interpreter
-	 *           (3) filename of emulated file (replace argv[0])
-	 *
-	 * This is done in reverse order, because of how the
-	 * user environment and arguments are stored.
-	 */
-	remove_arg_zero(bprm);
-	retval = copy_string_kernel(bprm->filename, bprm);
-	if (retval < 0) return retval; 
-	bprm->argc++;
-	if (i_arg) {
-		retval = copy_string_kernel(i_arg, bprm);
-		if (retval < 0) return retval; 
-		bprm->argc++;
-	}
-	retval = copy_string_kernel(i_name, bprm);
-	if (retval < 0)	return retval;
-	bprm->argc++;
-
-	/*
-	 * OK, now restart the process with the interpreter's inode.
-	 * Note that we use open_exec() as the name is now in kernel
-	 * space, and we don't need to copy it.
-	 */
-	file = open_exec(interp);
-	if (IS_ERR(file))
-		return PTR_ERR(file);
-
-	bprm->interpreter = file;
-	return 0;
-}
-
-static struct linux_binfmt em86_format = {
-	.module		= THIS_MODULE,
-	.load_binary	= load_em86,
-};
-
-static int __init init_em86_binfmt(void)
-{
-	register_binfmt(&em86_format);
-	return 0;
-}
-
-static void __exit exit_em86_binfmt(void)
-{
-	unregister_binfmt(&em86_format);
-}
-
-core_initcall(init_em86_binfmt);
-module_exit(exit_em86_binfmt);
-MODULE_LICENSE("GPL");
-- 
2.30.2

