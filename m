Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732637A2A7C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Sep 2023 00:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbjIOWmF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 18:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236780AbjIOWmE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 18:42:04 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CA1101;
        Fri, 15 Sep 2023 15:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1694817716;
        bh=mjPh7CflK5Hh9QsVLWzR7ZRmmuSXtlKu+2F1df3iAg0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EbEVUMEoTWi0KYlwkmVl8VJSvYRKKmHZp6pT+c60wmDXPOjzzsiO9i7Nnu63dvBk5
         ppvf8tI61dfraitTxNtmsCTBtMP95Kzt/rYyyJtq6kWXF/ZtGi4iAgQZZlB5Cv/8n+
         K5v9KPlBn7xOsoHNIiYMp/OQk3NLLFJwXxSfgju8=
Date:   Sat, 16 Sep 2023 00:41:55 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Pedro Falcato <pedro.falcato@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Brown <broonie@kernel.org>, Willy Tarreau <w@1wt.eu>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Sebastian Ott <sebott@redhat.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH RFC] binfmt_elf: fully allocate bss pages
Message-ID: <6bdff5d5-0be5-499c-84d4-2a2315fd3b05@t-8ch.de>
References: <20230914-bss-alloc-v1-1-78de67d2c6dd@weissschuh.net>
 <CAKbZUD2r7e673gDF8un8vw4GAVgMLG=Lk7F0-HfK5Mz59Sxzxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKbZUD2r7e673gDF8un8vw4GAVgMLG=Lk7F0-HfK5Mz59Sxzxw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-09-15 23:15:05+0100, Pedro Falcato wrote:
> On Fri, Sep 15, 2023 at 4:54 AM Thomas Weißschuh <linux@weissschuh.net> wrote:
> >
> > When allocating the pages for bss the start address needs to be rounded
> > down instead of up.
> > Otherwise the start of the bss segment may be unmapped.
> >
> > The was reported to happen on Aarch64:
> >
> > Memory allocated by set_brk():
> > Before: start=0x420000 end=0x420000
> > After:  start=0x41f000 end=0x420000
> >
> > The triggering binary looks like this:
> >
> >     Elf file type is EXEC (Executable file)
> >     Entry point 0x400144
> >     There are 4 program headers, starting at offset 64
> >
> >     Program Headers:
> >       Type           Offset             VirtAddr           PhysAddr
> >                      FileSiz            MemSiz              Flags  Align
> >       LOAD           0x0000000000000000 0x0000000000400000 0x0000000000400000
> >                      0x0000000000000178 0x0000000000000178  R E    0x10000
> >       LOAD           0x000000000000ffe8 0x000000000041ffe8 0x000000000041ffe8
> >                      0x0000000000000000 0x0000000000000008  RW     0x10000
> >       NOTE           0x0000000000000120 0x0000000000400120 0x0000000000400120
> >                      0x0000000000000024 0x0000000000000024  R      0x4
> >       GNU_STACK      0x0000000000000000 0x0000000000000000 0x0000000000000000
> >                      0x0000000000000000 0x0000000000000000  RW     0x10
> >
> >      Section to Segment mapping:
> >       Segment Sections...
> >        00     .note.gnu.build-id .text .eh_frame
> >        01     .bss
> >        02     .note.gnu.build-id
> >        03
> >
> > Reported-by: Sebastian Ott <sebott@redhat.com>
> > Closes: https://lore.kernel.org/lkml/5d49767a-fbdc-fbe7-5fb2-d99ece3168cb@redhat.com/
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> >
> > I'm not really familiar with the ELF loading process, so putting this
> > out as RFC.
> >
> > A example binary compiled with aarch64-linux-gnu-gcc 13.2.0 is available
> > at https://test.t-8ch.de/binfmt-bss-repro.bin
> > ---
> >  fs/binfmt_elf.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> > index 7b3d2d491407..4008a57d388b 100644
> > --- a/fs/binfmt_elf.c
> > +++ b/fs/binfmt_elf.c
> > @@ -112,7 +112,7 @@ static struct linux_binfmt elf_format = {
> >
> >  static int set_brk(unsigned long start, unsigned long end, int prot)
> >  {
> > -       start = ELF_PAGEALIGN(start);
> > +       start = ELF_PAGESTART(start);
> >         end = ELF_PAGEALIGN(end);
> >         if (end > start) {
> >                 /*
> 
> I don't see how this change can be correct. set_brk takes the start of
> .bss as the start, so doing ELF_PAGESTART(start) will give you what
> may very well be another ELF segment. In the common case, you'd map an
> anonymous page on top of someone's .data, which will misload the ELF.

That does make sense, and indeed it breaks more complex binaries.

> The current logic looks OK to me (gosh this code would ideally take a
> good refactoring...). I still can't quite tell how padzero() (in the
> original report) is -EFAULTing though.

As a test I replaced the asm clear_user() in padzero() with the generic
memset()-based implementation from include/asm-generic/uaccess.h.
It does provide better diagnostics, see below.

Who should have mapped this partial .bss page if there is no .data?
Maybe the logic needs to be a bit more complex and check if this page
has been already mapped for .data and in that case don't map it again.



[    5.620235] Run /init as init process
[    5.662763] CUSTOM DEBUG ELF_PAGEALIGN(start)=0x420000 ELF_PAGEALIGN(end)=0x420000 ELF_PAGESTART(0x41f000)
[    5.667176] Unable to handle kernel paging request at virtual address 000000000041ffe8
[    5.668062] Mem abort info:
[    5.668429]   ESR = 0x0000000096000045
[    5.669400]   EC = 0x25: DABT (current EL), IL = 32 bits
[    5.670119]   SET = 0, FnV = 0
[    5.670608]   EA = 0, S1PTW = 0
[    5.671172]   FSC = 0x05: level 1 translation fault
[    5.672024] Data abort info:
[    5.673273]   ISV = 0, ISS = 0x00000045, ISS2 = 0x00000000
[    5.674169]   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
[    5.674991]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    5.676871] user pgtable: 4k pages, 39-bit VAs, pgdp=0000000043f20000
[    5.677776] [000000000041ffe8] pgd=0800000043c62003, p4d=0800000043c62003, pud=0800000043c62003, pmd=0000000000000000
[    5.681522] Internal error: Oops: 0000000096000045 [#1] PREEMPT SMP
[    5.682604] Modules linked in:
[    5.683576] CPU: 0 PID: 1 Comm: init Not tainted 6.6.0-rc1+ #241 00a261b9689606c4fc0c90eb29739c5b0eec7b82
[    5.684706] Hardware name: linux,dummy-virt (DT)
[    5.685462] pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    5.686094] pc : __memset+0x50/0x188
[    5.686572] lr : padzero+0x84/0xa0
[    5.686956] sp : ffffffc08003bc70
[    5.687307] x29: ffffffc08003bc70 x28: 0000000000000000 x27: ffffff80026afa00
[    5.688091] x26: 000000000041fff0 x25: 000000000041ffe8 x24: 0000000000400144
[    5.688698] x23: 0000000000000000 x22: 0000000000000000 x21: 0000000000000000
[    5.689275] x20: 0000000000000fe8 x19: 000000000041ffe8 x18: ffffffffffffffff
[    5.689928] x17: ffffffdf46cd2984 x16: ffffffdf46cd2880 x15: 0720072007200720
[    5.690597] x14: 0720072007200720 x13: 0720072007200720 x12: 0000000000000000
[    5.691192] x11: 00000000ffffefff x10: 0000000000000000 x9 : ffffffdf46e1ba28
[    5.691906] x8 : 000000000041ffe8 x7 : 0000000000000000 x6 : 0000000000057fa8
[    5.692496] x5 : 0000000000000fff x4 : 0000000000000008 x3 : 0000000000000000
[    5.693168] x2 : 0000000000000018 x1 : 0000000000000000 x0 : 000000000041ffe8
[    5.693985] Call trace:
[    5.694318]  __memset+0x50/0x188
[    5.694708]  load_elf_binary+0x630/0x15d0
[    5.695132]  bprm_execve+0x2bc/0x7c0
[    5.695505]  kernel_execve+0x144/0x1c8
[    5.695882]  run_init_process+0xf8/0x110
[    5.696264]  kernel_init+0x8c/0x200
[    5.696624]  ret_from_fork+0x10/0x20
[    5.697216] Code: d65f03c0 cb0803e4 f2400c84 54000080 (a9001d07)
[    5.698936] ---[ end trace 0000000000000000 ]---
[    5.701625] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    5.702502] SMP: stopping secondary CPUs
[    5.703608] Kernel Offset: 0x1ec6a00000 from 0xffffffc080000000
[    5.704119] PHYS_OFFSET: 0x40000000
[    5.704491] CPU features: 0x0000000d,00020000,0000420b
[    5.705276] Memory Limit: none
