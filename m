Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B011F9B95
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 17:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730954AbgFOPJb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 11:09:31 -0400
Received: from verein.lst.de ([213.95.11.211]:33935 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729875AbgFOPJa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 11:09:30 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E658068B05; Mon, 15 Jun 2020 17:09:26 +0200 (CEST)
Date:   Mon, 15 Jun 2020 17:09:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] exec: simplify the compat syscall handling
Message-ID: <20200615150926.GA17108@lst.de>
References: <20200615130032.931285-1-hch@lst.de> <20200615130032.931285-3-hch@lst.de> <CAK8P3a0bRD3RzE_X6Tjzu9Tj+OhHhP+S=k6+VYODBGko8oQhew@mail.gmail.com> <20200615141239.GA12951@lst.de> <CAK8P3a2MeZhayZWkPbd4Ckq3n410p_n808NJTwN=JjzqHRiAXg@mail.gmail.com> <20200615144310.GA15101@lst.de> <CAK8P3a17h782gO65qJ9Mmz0EuiTSKQPEyr_=nvqOtnmQZuh9Kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a17h782gO65qJ9Mmz0EuiTSKQPEyr_=nvqOtnmQZuh9Kw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 15, 2020 at 04:46:15PM +0200, Arnd Bergmann wrote:
> How about this one:
> 
> diff --git a/arch/x86/entry/syscall_x32.c b/arch/x86/entry/syscall_x32.c
> index 3d8d70d3896c..0ce15807cf54 100644
> --- a/arch/x86/entry/syscall_x32.c
> +++ b/arch/x86/entry/syscall_x32.c
> @@ -16,6 +16,9 @@
>  #undef __SYSCALL_X32
>  #undef __SYSCALL_COMMON
> 
> +#define __x32_sys_execve __x64_sys_execve
> +#define __x32_sys_execveat __x64_sys_execveat
> +


arch/x86/entry/syscall_x32.c:19:26: error: ‘__x64_sys_execve’ undeclared here (not in a function); did you mean ‘__x32_sys_execve’?
   19 | #define __x32_sys_execve __x64_sys_execve
      |                          ^~~~~~~~~~~~~~~~
arch/x86/entry/syscall_x32.c:22:39: note: in expansion of macro ‘__x32_sys_execve’
   22 | #define __SYSCALL_X32(nr, sym) [nr] = __x32_##sym,
      |                                       ^~~~~~
./arch/x86/include/generated/asm/syscalls_64.h:344:1: note: in expansion of macro ‘__SYSCALL_X32’
  344 | __SYSCALL_X32(520, sys_execve)
      | ^~~~~~~~~~~~~
arch/x86/entry/syscall_x32.c:20:28: error: ‘__x64_sys_execveat’ undeclared here (not in a function); did you mean ‘__x32_sys_execveat’?
   20 | #define __x32_sys_execveat __x64_sys_execveat
      |                            ^~~~~~~~~~~~~~~~~~
arch/x86/entry/syscall_x32.c:22:39: note: in expansion of macro ‘__x32_sys_execveat’
   22 | #define __SYSCALL_X32(nr, sym) [nr] = __x32_##sym,
      |                                       ^~~~~~
./arch/x86/include/generated/asm/syscalls_64.h:369:1: note: in expansion of macro ‘__SYSCALL_X32’
  369 | __SYSCALL_X32(545, sys_execveat)
      | ^~~~~~~~~~~~~
make[2]: *** [scripts/Makefile.build:281: arch/x86/entry/syscall_x32.o] Error 1
make[1]: *** [scripts/Makefile.build:497: arch/x86/entry] Error 2
make[1]: *** Waiting for unfinished jobs....
kernel/exit.o: warning: objtool: __x64_sys_exit_group()+0x14: unreachable instruction
make: *** [Makefile:1764: arch/x86] Error 2
make: *** Waiting for unfinished jobs....
