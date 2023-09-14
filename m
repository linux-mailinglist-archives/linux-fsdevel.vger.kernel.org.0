Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A377A10D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 00:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjINWTA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 18:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjINWS7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 18:18:59 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DC2270C;
        Thu, 14 Sep 2023 15:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1694729933;
        bh=ieuN4WSdOASjW7MZ8fQhKTc4SOBYccYW/PVLNRhj/Fg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hauFyTQ4E7g6eXOFjEGMXUugXelOejX8zOEc4aH3EtYsQhWnuxL6f4h5//V5qxFIj
         k65ZspkDzckwSREnCWmmgkSXq7GFYSn9WUETOX1B3XMTORZ2HtJJ8p0DlDsG04CNVW
         R0Oi5GNm1GsFogs1IcEixwTvcFrgI5ygGf5y+QFo=
Date:   Fri, 15 Sep 2023 00:18:52 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Mark Brown <broonie@kernel.org>, Willy Tarreau <w@1wt.eu>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Sebastian Ott <sebott@redhat.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH RFC] binfmt_elf: fully allocate bss pages
Message-ID: <987fb5f4-416f-482a-9564-b12f7423e19a@t-8ch.de>
References: <20230914-bss-alloc-v1-1-78de67d2c6dd@weissschuh.net>
 <87fs3gwn53.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87fs3gwn53.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-09-14 14:49:44-0500, Eric W. Biederman wrote:
> Thomas Weißschuh <linux@weissschuh.net> writes:
> 
> > When allocating the pages for bss the start address needs to be rounded
> > down instead of up.
> > Otherwise the start of the bss segment may be unmapped.
> >
> > The was reported to happen on Aarch64:
> 
> Those program headers you quote look corrupt.

To reproduce:

$ cat test.c
char foo[1];

void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) _start(void)
{
	__asm__ volatile (
		"mov x0, 123\n"
		"mov x8, 93\n"       /* NR_exit == 93 */
		"svc #0\n"
	);
	__builtin_unreachable();
}

$ aarch64-linux-gnu-gcc -fno-stack-protector -o nolibc-test -nostdlib -static test.c

Note:
it works in qemu-user, newer versions need the workaround from
https://gitlab.com/qemu-project/qemu/-/issues/1854
The issue in qemu-user seems to be related to the question at hand.

> The address 0x41ffe8 is not 0x10000 aligned.
> 
> I don't think anything in the elf specification allows that.
> 
> The most common way to have bss is for a elf segment to have a larger
> memsize than filesize.  In which case rounding up is the correct way to
> handle things.
> 
> We definitely need to verify the appended bss case works, before
> taking this patch, or we will get random application failures
> because parts of the data segment are being zeroed, or the binaries
> won't load because the bss won't be able to map over the initialized data.

My hope in posting this patch was also for the bots to uncover any
obvious breakage. So far there were no reports.

> The note segment living at a conflicting virtual address also looks
> suspicious.   It is probably harmless, as note segments are not
> loaded.
> 
> 
> Are you by any chance using an experimental linker?

I'm using GNU ld 2.41 as supplied by my distro.
(ArchLinux, aarch64-linux-gnu-binutils 2.41-2)

> In general every segment in an elf executable needs to be aligned to the
> SYSVABI's architecture page size.  I think that is 64k on ARM.  Which it
> looks like the linker tried to implement by setting the alignment to
> 0x10000, and then ignored by putting a byte offset beginning to the
> page.

Looking at Figure A-5 of [0] this seems not to be the case.
It shows p_vaddr=0x8048100 and p_align=0x1000.
(On x86_64 with PAGE_SIZE=0x1000)

> At a minimum someone needs to sort through what the elf specification
> says needs to happen is a weird case like this where the start address
> of a load segment does not match the alignment of the segment.

I'll take a look.

> To see how common this is I looked at a binary known to be working, and
> my /usr/bin/ls binary has one segment that has one of these unaligned
> starts as well.

Same for my /usr/bin/busybox, also the .data and .bss segment.

> So it must be defined to work somewhere but I need to see the definition
> to even have a good opinion on the nonsense of saying an unaligned value
> should be aligned.

Figure 2-1 from [0]:

p_align:

Loadable process segments must have congruent values for p_vaddr and
p_offset, modulo the page size.This member gives the value to which the
segments are aligned in memory and in the file. Values 0 and 1 mean that no
alignment is required. Otherwise, p_align should be a positive, integral power of
2, and p_addr should equal p_offset, modulo p_align.

0x41ffe8 (p_vaddr)  % 0x1000 = 0xfe8
0x00ffe8 (p_offset) % 0x1000 = 0xfe8

0x41ffe8 (p_addr)   % 0x10000 = 0xffe8
0x00ffe8 (p_offset) % 0x10000 = 0xffe8

So this seems to be satisfied.

> All I know is that we need to limit our support to what memory mapping
> pieces from the elf executable can support.  Which at a minimum requires:
> 	virt_addr % ELF_MIN_ALIGN == file_offset % ELF_MIN_ALIGN

Aarch64 can also handle 4k pages so this invariant should be satisfied.
4k pages seems to be the default for the kernel, too.

[0] https://refspecs.linuxfoundation.org/elf/elf.pdf

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
> > -	start = ELF_PAGEALIGN(start);
> > +	start = ELF_PAGESTART(start);
> >  	end = ELF_PAGEALIGN(end);
> >  	if (end > start) {
> >  		/*
> >
> > ---
> > base-commit: aed8aee11130a954356200afa3f1b8753e8a9482
> > change-id: 20230914-bss-alloc-f523fa61718c
> >
> > Best regards,
