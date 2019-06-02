Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE478322BA
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2019 10:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfFBIgw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Jun 2019 04:36:52 -0400
Received: from [176.110.122.116] ([176.110.122.116]:52152 "EHLO
        ocean.emcraft.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbfFBIgw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Jun 2019 04:36:52 -0400
X-Greylist: delayed 4503 seconds by postgrey-1.27 at vger.kernel.org; Sun, 02 Jun 2019 04:36:51 EDT
Received: from [10.8.0.10] (helo=mehome.localdomain)
        by ocean.emcraft.com with esmtps (TLSv1:AES256-SHA:256)
        (Exim 4.76)
        (envelope-from <sposelenov@emcraft.com>)
        id 1hXKoA-0002FG-S7; Sun, 02 Jun 2019 10:21:37 +0300
Message-ID: <34079b6a34abbad5ab13925dc004e397f70524e3.camel@emcraft.com>
Subject: Re: [PATCH] binfmt_flat: make load_flat_shared_library() work
From:   Sergei Poselenov <sposelenov@emcraft.com>
To:     Arnd Bergmann <arnd@arndb.de>, Greg Ungerer <gerg@linux-m68k.org>
Cc:     arch@emcraft.com, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Date:   Sun, 02 Jun 2019 10:21:33 +0300
In-Reply-To: <CAK8P3a0b7MBn+84jh0Y2zhFLLAqZ2tMvFDFF9Kw=breRLH4Utg@mail.gmail.com>
References: <20190524201817.16509-1-jannh@google.com>
         <20190525144304.e2b9475a18a1f78a964c5640@linux-foundation.org>
         <CAG48ez36xJ9UA8gWef3+1rHQwob5nb8WP3RqnbT8GEOV9Z38jA@mail.gmail.com>
         <6956cfe5-90d4-aad4-48e3-66b0ece91fed@linux-m68k.org>
         <CAK8P3a0b7MBn+84jh0Y2zhFLLAqZ2tMvFDFF9Kw=breRLH4Utg@mail.gmail.com>
Organization: Emcraft Systems
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Arnd, all,

On Wed, 2019-05-29 at 14:05 +0200, Arnd Bergmann wrote:
> On Tue, May 28, 2019 at 12:56 PM Greg Ungerer <gerg@linux-m68k.org>
> wrote:
> > On 27/5/19 11:38 pm, Jann Horn wrote:
> > > On Sat, May 25, 2019 at 11:43 PM Andrew Morton
> > > <akpm@linux-foundation.org> wrote:
> > > > On Fri, 24 May 2019 22:18:17 +0200 Jann Horn <jannh@google.com>
> > > > wrote:
> > > > > load_flat_shared_library() is broken: It only calls
> > > > > load_flat_file() if
> > > > > prepare_binprm() returns zero, but prepare_binprm() returns
> > > > > the number of
> > > > > bytes read - so this only happens if the file is empty.
> > > > 
> > > > ouch.
> > > > 
> > > > > Instead, call into load_flat_file() if the number of bytes
> > > > > read is
> > > > > non-negative. (Even if the number of bytes is zero - in that
> > > > > case,
> > > > > load_flat_file() will see nullbytes and return a nice
> > > > > -ENOEXEC.)
> > > > > 
> > > > > In addition, remove the code related to bprm creds and stop
> > > > > using
> > > > > prepare_binprm() - this code is loading a library, not a main
> > > > > executable,
> > > > > and it only actually uses the members "buf", "file" and
> > > > > "filename" of the
> > > > > linux_binprm struct. Instead, call kernel_read() directly.
> > > > > 
> > > > > Cc: stable@vger.kernel.org
> > > > > Fixes: 287980e49ffc ("remove lots of IS_ERR_VALUE abuses")
> > > > > Signed-off-by: Jann Horn <jannh@google.com>
> > > > > ---
> > > > > I only found the bug by looking at the code, I have not
> > > > > verified its
> > > > > existence at runtime.
> > > > > Also, this patch is compile-tested only.
> > > > > It would be nice if someone who works with nommu Linux could
> > > > > have a
> > > > > look at this patch.
> > > > 
> > > > 287980e49ffc was three years ago!  Has it really been broken
> > > > for all
> > > > that time?  If so, it seems a good source of freed disk
> > > > space...
> > > 
> > > Maybe... but I didn't want to rip it out without having one of
> > > the
> > > maintainers confirm that this really isn't likely to be used
> > > anymore.
> > 
> > I have not used shared libraries on m68k non-mmu setups for
> > a very long time. At least 10 years I would think.
> 
> I think Emcraft have a significant customer base running ARM NOMMU
> Linux, I wonder whether they would have run into this (adding
> Sergei to Cc).
> My suspicion is that they use only binfmt-elf-fdpic, not binfmt-flat.
> 

We use both, acutally, but all-static. We don't support shared
libraries with bFLT or ELF FDPIC.

Kind regards,
Sergei
> The only architectures I see that enable binfmt-flat are sh, xtensa
> and h8300, but only arch/sh uses CONFIG_BINFMT_SHARED_FLAT
> for a few machine specific configurations, and I'm in turn fairly
> sure
> those machines have not run a recent kernel in many years.
> 
> The one SH nommu platform likely to have users is j2, and that is
> probably always used with musl-libc with elf-fdpic (given that
> Rich Felker maintains both the kernel port and the library).
> 
>       Arnd
> 

