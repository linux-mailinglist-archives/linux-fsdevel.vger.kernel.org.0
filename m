Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A4236669F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 10:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbhDUICN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 04:02:13 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:38883 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234116AbhDUICJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 04:02:09 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1lZ7nh-002iGt-NF; Wed, 21 Apr 2021 10:01:33 +0200
Received: from x4db7fa20.dyn.telefonica.de ([77.183.250.32] helo=[192.168.1.10])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1lZ7nh-000iLU-Cw; Wed, 21 Apr 2021 10:01:33 +0200
Subject: Re: [PATCH v1] binfmt: remove support for em86 (alpha only)
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        David Hildenbrand <david@redhat.com>
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
References: <20210420175631.46923-1-david@redhat.com>
 <20210421075431.blsuv3adard2e4xu@wittgenstein>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <37f00e0a-e0b9-0c93-d0e8-47169c091faa@physik.fu-berlin.de>
Date:   Wed, 21 Apr 2021 10:01:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210421075431.blsuv3adard2e4xu@wittgenstein>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 77.183.250.32
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!

On 4/21/21 9:54 AM, Christian Brauner wrote:
> The only Alpha machines in active use I know of are here in Berlin at
> the FU so adding Adrian in case they care but I don't think so and this
> seems like a good cleanup:
> 
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

Thanks for CC'ing me. FWIW, Gentoo has a very active Alpha maintenance as well
and there are more people running Debian on Alpha on the debian-alpha ML.

I agree that em86 is obsolete and most users will just use qemu-user these days.

Adrian

>>  fs/Kconfig.binfmt |  15 -------
>>  fs/Makefile       |   1 -
>>  fs/binfmt_em86.c  | 110 ----------------------------------------------
>>  3 files changed, 126 deletions(-)
>>  delete mode 100644 fs/binfmt_em86.c
>>
>> diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
>> index c6f1c8c1934e..8720e0a30005 100644
>> --- a/fs/Kconfig.binfmt
>> +++ b/fs/Kconfig.binfmt
>> @@ -165,21 +165,6 @@ config OSF4_COMPAT
>>  	  with v4 shared libraries freely available from Compaq. If you're
>>  	  going to use shared libraries from Tru64 version 5.0 or later, say N.
>>  
>> -config BINFMT_EM86
>> -	tristate "Kernel support for Linux/Intel ELF binaries"
>> -	depends on ALPHA
>> -	help
>> -	  Say Y here if you want to be able to execute Linux/Intel ELF
>> -	  binaries just like native Alpha binaries on your Alpha machine. For
>> -	  this to work, you need to have the emulator /usr/bin/em86 in place.
>> -
>> -	  You can get the same functionality by saying N here and saying Y to
>> -	  "Kernel support for MISC binaries".
>> -
>> -	  You may answer M to compile the emulation support as a module and
>> -	  later load the module when you want to use a Linux/Intel binary. The
>> -	  module will be called binfmt_em86. If unsure, say Y.
>> -
>>  config BINFMT_MISC
>>  	tristate "Kernel support for MISC binaries"
>>  	help
>> diff --git a/fs/Makefile b/fs/Makefile
>> index 3215fe205256..c92e403c53f8 100644
>> --- a/fs/Makefile
>> +++ b/fs/Makefile
>> @@ -39,7 +39,6 @@ obj-$(CONFIG_FS_ENCRYPTION)	+= crypto/
>>  obj-$(CONFIG_FS_VERITY)		+= verity/
>>  obj-$(CONFIG_FILE_LOCKING)      += locks.o
>>  obj-$(CONFIG_BINFMT_AOUT)	+= binfmt_aout.o
>> -obj-$(CONFIG_BINFMT_EM86)	+= binfmt_em86.o
>>  obj-$(CONFIG_BINFMT_MISC)	+= binfmt_misc.o
>>  obj-$(CONFIG_BINFMT_SCRIPT)	+= binfmt_script.o
>>  obj-$(CONFIG_BINFMT_ELF)	+= binfmt_elf.o
>> diff --git a/fs/binfmt_em86.c b/fs/binfmt_em86.c
>> deleted file mode 100644
>> index 06b9b9fddf70..000000000000
>> --- a/fs/binfmt_em86.c
>> +++ /dev/null
>> @@ -1,110 +0,0 @@
>> -// SPDX-License-Identifier: GPL-2.0-only
>> -/*
>> - *  linux/fs/binfmt_em86.c
>> - *
>> - *  Based on linux/fs/binfmt_script.c
>> - *  Copyright (C) 1996  Martin von Löwis
>> - *  original #!-checking implemented by tytso.
>> - *
>> - *  em86 changes Copyright (C) 1997  Jim Paradis
>> - */
>> -
>> -#include <linux/module.h>
>> -#include <linux/string.h>
>> -#include <linux/stat.h>
>> -#include <linux/binfmts.h>
>> -#include <linux/elf.h>
>> -#include <linux/init.h>
>> -#include <linux/fs.h>
>> -#include <linux/file.h>
>> -#include <linux/errno.h>
>> -
>> -
>> -#define EM86_INTERP	"/usr/bin/em86"
>> -#define EM86_I_NAME	"em86"
>> -
>> -static int load_em86(struct linux_binprm *bprm)
>> -{
>> -	const char *i_name, *i_arg;
>> -	char *interp;
>> -	struct file * file;
>> -	int retval;
>> -	struct elfhdr	elf_ex;
>> -
>> -	/* Make sure this is a Linux/Intel ELF executable... */
>> -	elf_ex = *((struct elfhdr *)bprm->buf);
>> -
>> -	if (memcmp(elf_ex.e_ident, ELFMAG, SELFMAG) != 0)
>> -		return  -ENOEXEC;
>> -
>> -	/* First of all, some simple consistency checks */
>> -	if ((elf_ex.e_type != ET_EXEC && elf_ex.e_type != ET_DYN) ||
>> -		(!((elf_ex.e_machine == EM_386) || (elf_ex.e_machine == EM_486))) ||
>> -		!bprm->file->f_op->mmap) {
>> -			return -ENOEXEC;
>> -	}
>> -
>> -	/* Need to be able to load the file after exec */
>> -	if (bprm->interp_flags & BINPRM_FLAGS_PATH_INACCESSIBLE)
>> -		return -ENOENT;
>> -
>> -	/* Unlike in the script case, we don't have to do any hairy
>> -	 * parsing to find our interpreter... it's hardcoded!
>> -	 */
>> -	interp = EM86_INTERP;
>> -	i_name = EM86_I_NAME;
>> -	i_arg = NULL;		/* We reserve the right to add an arg later */
>> -
>> -	/*
>> -	 * Splice in (1) the interpreter's name for argv[0]
>> -	 *           (2) (optional) argument to interpreter
>> -	 *           (3) filename of emulated file (replace argv[0])
>> -	 *
>> -	 * This is done in reverse order, because of how the
>> -	 * user environment and arguments are stored.
>> -	 */
>> -	remove_arg_zero(bprm);
>> -	retval = copy_string_kernel(bprm->filename, bprm);
>> -	if (retval < 0) return retval; 
>> -	bprm->argc++;
>> -	if (i_arg) {
>> -		retval = copy_string_kernel(i_arg, bprm);
>> -		if (retval < 0) return retval; 
>> -		bprm->argc++;
>> -	}
>> -	retval = copy_string_kernel(i_name, bprm);
>> -	if (retval < 0)	return retval;
>> -	bprm->argc++;
>> -
>> -	/*
>> -	 * OK, now restart the process with the interpreter's inode.
>> -	 * Note that we use open_exec() as the name is now in kernel
>> -	 * space, and we don't need to copy it.
>> -	 */
>> -	file = open_exec(interp);
>> -	if (IS_ERR(file))
>> -		return PTR_ERR(file);
>> -
>> -	bprm->interpreter = file;
>> -	return 0;
>> -}
>> -
>> -static struct linux_binfmt em86_format = {
>> -	.module		= THIS_MODULE,
>> -	.load_binary	= load_em86,
>> -};
>> -
>> -static int __init init_em86_binfmt(void)
>> -{
>> -	register_binfmt(&em86_format);
>> -	return 0;
>> -}
>> -
>> -static void __exit exit_em86_binfmt(void)
>> -{
>> -	unregister_binfmt(&em86_format);
>> -}
>> -
>> -core_initcall(init_em86_binfmt);
>> -module_exit(exit_em86_binfmt);
>> -MODULE_LICENSE("GPL");
>> -- 
>> 2.30.2
>>

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
