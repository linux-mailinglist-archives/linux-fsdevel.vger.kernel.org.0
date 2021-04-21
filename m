Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00700366686
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 09:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235988AbhDUHzP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 03:55:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231463AbhDUHzN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 03:55:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 693E161182;
        Wed, 21 Apr 2021 07:54:36 +0000 (UTC)
Date:   Wed, 21 Apr 2021 09:54:31 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     David Hildenbrand <david@redhat.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-alpha@vger.kernel.org
Subject: Re: [PATCH v1] binfmt: remove support for em86 (alpha only)
Message-ID: <20210421075431.blsuv3adard2e4xu@wittgenstein>
References: <20210420175631.46923-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210420175631.46923-1-david@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 20, 2021 at 07:56:31PM +0200, David Hildenbrand wrote:
> We have a fairly specific alpha binary loader in Linux: running x86
> (i386, i486) binaries via the em86 [1] emulator. As noted in the Kconfig
> option, the same behavior can be achieved via binfmt_misc, for example,
> more nowadays used for running qemu-user.
> 
> An example on how to get binfmt_misc running with em86 can be found in
> Documentation/admin-guide/binfmt-misc.rst
> 
> The defconfig does not have CONFIG_BINFMT_EM86=y set. And doing a
> 	make defconfig && make olddefconfig
> results in
> 	# CONFIG_BINFMT_EM86 is not set
> 
> ... as we don't seem to have any supported Linux distirbution for alpha
> anymore, there isn't really any "default" user of that feature anymore.
> 
> Searching for "CONFIG_BINFMT_EM86=y" reveals mostly discussions from
> around 20 years ago, like [2] describing how to get netscape via em86
> running via em86, or [3] discussing that running wine or installing
> Win 3.11 through em86 would be a nice feature.
> 
> The latest binaries available for em86 are from 2000, version 2.2.1 [4] --
> which translates to "unsupported"; further, em86 doesn't even work with
> glibc-2.x but only with glibc-2.0 [4, 5]. These are clear signs that
> there might not be too many em86 users out there, especially users
> relying on modern Linux kernels.
> 
> Even though the code footprint is relatively small, let's just get rid
> of this blast from the past that's effectively unused.
> 
> [1] http://ftp.dreamtime.org/pub/linux/Linux-Alpha/em86/v0.4/docs/em86.html
> [2] https://static.lwn.net/1998/1119/a/alpha-netscape.html
> [3] https://groups.google.com/g/linux.debian.alpha/c/AkGuQHeCe0Y
> [4] http://zeniv.linux.org.uk/pub/linux/alpha/em86/v2.2-1/relnotes.2.2.1.html
> [5] https://forum.teamspeak.com/archive/index.php/t-1477.html
> 
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-api@vger.kernel.org
> Cc: linux-alpha@vger.kernel.org
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

The only Alpha machines in active use I know of are here in Berlin at
the FU so adding Adrian in case they care but I don't think so and this
seems like a good cleanup:

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>


>  fs/Kconfig.binfmt |  15 -------
>  fs/Makefile       |   1 -
>  fs/binfmt_em86.c  | 110 ----------------------------------------------
>  3 files changed, 126 deletions(-)
>  delete mode 100644 fs/binfmt_em86.c
> 
> diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
> index c6f1c8c1934e..8720e0a30005 100644
> --- a/fs/Kconfig.binfmt
> +++ b/fs/Kconfig.binfmt
> @@ -165,21 +165,6 @@ config OSF4_COMPAT
>  	  with v4 shared libraries freely available from Compaq. If you're
>  	  going to use shared libraries from Tru64 version 5.0 or later, say N.
>  
> -config BINFMT_EM86
> -	tristate "Kernel support for Linux/Intel ELF binaries"
> -	depends on ALPHA
> -	help
> -	  Say Y here if you want to be able to execute Linux/Intel ELF
> -	  binaries just like native Alpha binaries on your Alpha machine. For
> -	  this to work, you need to have the emulator /usr/bin/em86 in place.
> -
> -	  You can get the same functionality by saying N here and saying Y to
> -	  "Kernel support for MISC binaries".
> -
> -	  You may answer M to compile the emulation support as a module and
> -	  later load the module when you want to use a Linux/Intel binary. The
> -	  module will be called binfmt_em86. If unsure, say Y.
> -
>  config BINFMT_MISC
>  	tristate "Kernel support for MISC binaries"
>  	help
> diff --git a/fs/Makefile b/fs/Makefile
> index 3215fe205256..c92e403c53f8 100644
> --- a/fs/Makefile
> +++ b/fs/Makefile
> @@ -39,7 +39,6 @@ obj-$(CONFIG_FS_ENCRYPTION)	+= crypto/
>  obj-$(CONFIG_FS_VERITY)		+= verity/
>  obj-$(CONFIG_FILE_LOCKING)      += locks.o
>  obj-$(CONFIG_BINFMT_AOUT)	+= binfmt_aout.o
> -obj-$(CONFIG_BINFMT_EM86)	+= binfmt_em86.o
>  obj-$(CONFIG_BINFMT_MISC)	+= binfmt_misc.o
>  obj-$(CONFIG_BINFMT_SCRIPT)	+= binfmt_script.o
>  obj-$(CONFIG_BINFMT_ELF)	+= binfmt_elf.o
> diff --git a/fs/binfmt_em86.c b/fs/binfmt_em86.c
> deleted file mode 100644
> index 06b9b9fddf70..000000000000
> --- a/fs/binfmt_em86.c
> +++ /dev/null
> @@ -1,110 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - *  linux/fs/binfmt_em86.c
> - *
> - *  Based on linux/fs/binfmt_script.c
> - *  Copyright (C) 1996  Martin von Löwis
> - *  original #!-checking implemented by tytso.
> - *
> - *  em86 changes Copyright (C) 1997  Jim Paradis
> - */
> -
> -#include <linux/module.h>
> -#include <linux/string.h>
> -#include <linux/stat.h>
> -#include <linux/binfmts.h>
> -#include <linux/elf.h>
> -#include <linux/init.h>
> -#include <linux/fs.h>
> -#include <linux/file.h>
> -#include <linux/errno.h>
> -
> -
> -#define EM86_INTERP	"/usr/bin/em86"
> -#define EM86_I_NAME	"em86"
> -
> -static int load_em86(struct linux_binprm *bprm)
> -{
> -	const char *i_name, *i_arg;
> -	char *interp;
> -	struct file * file;
> -	int retval;
> -	struct elfhdr	elf_ex;
> -
> -	/* Make sure this is a Linux/Intel ELF executable... */
> -	elf_ex = *((struct elfhdr *)bprm->buf);
> -
> -	if (memcmp(elf_ex.e_ident, ELFMAG, SELFMAG) != 0)
> -		return  -ENOEXEC;
> -
> -	/* First of all, some simple consistency checks */
> -	if ((elf_ex.e_type != ET_EXEC && elf_ex.e_type != ET_DYN) ||
> -		(!((elf_ex.e_machine == EM_386) || (elf_ex.e_machine == EM_486))) ||
> -		!bprm->file->f_op->mmap) {
> -			return -ENOEXEC;
> -	}
> -
> -	/* Need to be able to load the file after exec */
> -	if (bprm->interp_flags & BINPRM_FLAGS_PATH_INACCESSIBLE)
> -		return -ENOENT;
> -
> -	/* Unlike in the script case, we don't have to do any hairy
> -	 * parsing to find our interpreter... it's hardcoded!
> -	 */
> -	interp = EM86_INTERP;
> -	i_name = EM86_I_NAME;
> -	i_arg = NULL;		/* We reserve the right to add an arg later */
> -
> -	/*
> -	 * Splice in (1) the interpreter's name for argv[0]
> -	 *           (2) (optional) argument to interpreter
> -	 *           (3) filename of emulated file (replace argv[0])
> -	 *
> -	 * This is done in reverse order, because of how the
> -	 * user environment and arguments are stored.
> -	 */
> -	remove_arg_zero(bprm);
> -	retval = copy_string_kernel(bprm->filename, bprm);
> -	if (retval < 0) return retval; 
> -	bprm->argc++;
> -	if (i_arg) {
> -		retval = copy_string_kernel(i_arg, bprm);
> -		if (retval < 0) return retval; 
> -		bprm->argc++;
> -	}
> -	retval = copy_string_kernel(i_name, bprm);
> -	if (retval < 0)	return retval;
> -	bprm->argc++;
> -
> -	/*
> -	 * OK, now restart the process with the interpreter's inode.
> -	 * Note that we use open_exec() as the name is now in kernel
> -	 * space, and we don't need to copy it.
> -	 */
> -	file = open_exec(interp);
> -	if (IS_ERR(file))
> -		return PTR_ERR(file);
> -
> -	bprm->interpreter = file;
> -	return 0;
> -}
> -
> -static struct linux_binfmt em86_format = {
> -	.module		= THIS_MODULE,
> -	.load_binary	= load_em86,
> -};
> -
> -static int __init init_em86_binfmt(void)
> -{
> -	register_binfmt(&em86_format);
> -	return 0;
> -}
> -
> -static void __exit exit_em86_binfmt(void)
> -{
> -	unregister_binfmt(&em86_format);
> -}
> -
> -core_initcall(init_em86_binfmt);
> -module_exit(exit_em86_binfmt);
> -MODULE_LICENSE("GPL");
> -- 
> 2.30.2
> 
