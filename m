Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23C92EA066
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jan 2021 00:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbhADXEq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 18:04:46 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:40140 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbhADXEq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 18:04:46 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kwYtG-006tib-Fg; Mon, 04 Jan 2021 23:03:54 +0000
Date:   Mon, 4 Jan 2021 23:03:54 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-fsdevel@vger.kernel.org
Subject: Re: [vfs:work.elf-compat 11/13] fs/binfmt_elf.c:254: undefined
 reference to `vdso_image_32'
Message-ID: <20210104230354.GP3579531@ZenIV.linux.org.uk>
References: <202101041818.RRAoU6Bu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202101041818.RRAoU6Bu-lkp@intel.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 04, 2021 at 06:13:25PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.elf-compat
> head:   b9613abdecd9d2dae95f4712985280c80ce8e646
> commit: 5df3c15125233fbc59fd003249c381c7edd985cc [11/13] Kconfig: regularize selection of CONFIG_BINFMT_ELF
> config: x86_64-randconfig-a005-20210104 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/commit/?id=5df3c15125233fbc59fd003249c381c7edd985cc
>         git remote add vfs https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git
>         git fetch --no-tags vfs work.elf-compat
>         git checkout 5df3c15125233fbc59fd003249c381c7edd985cc
>         # save the attached .config to linux build tree
>         make W=1 ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    ld: fs/compat_binfmt_elf.o: in function `create_elf_tables':
> >> fs/binfmt_elf.c:254: undefined reference to `vdso_image_32'
> >> ld: fs/binfmt_elf.c:254: undefined reference to `vdso_image_32'
> >> ld: fs/binfmt_elf.c:254: undefined reference to `vdso_image_32'

Bloody wonderful.  Background: right now in mainline selecting X32
without IA32_EMULATION ends up with being unable to execute x32
binaries.  Which is the reason why that build breakage does not
happen there.  It's not hard to fix (just turn the else branch of
COMPAT_ARCH_DLINFO into else if (IS_ENABLED(CONFIG_IA32_EMULATION));
absent IA32_EMULATION compat_elf_check_arch() will reject anything
that doesn't have exec->e_machine == EM_X86_64, so that else is
dead code on such configs anyway).

Let me check if such configs (X32, !IA32_EMULATION, 64bit
userland with some x32 binaries) boot and work; if that fix
is all it takes, I'll throw it into the series next to other
x32 commits...
