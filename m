Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B96442CA71E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 16:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730438AbgLAPdy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 10:33:54 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42118 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729216AbgLAPdy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 10:33:54 -0500
Received: by mail-ot1-f67.google.com with SMTP id 11so1994346oty.9;
        Tue, 01 Dec 2020 07:33:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3TYEuLB7a0GZMz9VHnUGScyAuLcS1oGx4ZirLfVhD58=;
        b=JkISPntkiRBmJGOtCWV17IMkMkGPJIRsoLx+nXEnh4ZKKxv+SOaamlQ4Csg2j97Wto
         QVB2dUhZ3q0udJIHZxE7TXj9Qngzajxw/JTeJIxyw5h9wXNBD68zugREqfEguj6an0k0
         8hcOBlNmI+4fUwh+YrloosZ3vFReI7/dG0J1a4VOc4Zhmct2QF/Ef7FokRMOiE5LcHX1
         g+7WUakNtkdiRlz3UhWv9ZntD5CkEneq8t6QpV3yTwqo038p9MDl1R3e2S9Otyz9pzpV
         lDeHDs8TH1a8vSWpp3+39pyfDzIQ4GNpU5bkdkqhjVh2M1THw1naF+1q/Mrb1pzdZgZc
         InKA==
X-Gm-Message-State: AOAM530x3ylCDO8ih8iT8ARPNM+InE3PoCVgpDSKTn0DNG06psV/tStM
        gjzgsyftfll7wiWD41rZzm7SbxYOfLUyCiurWQY=
X-Google-Smtp-Source: ABdhPJwjl/WrymSGG1q6QSWA4NULJul1vnTn+2DnKqCieAk1A5M/ct7FjmDTX3AX+1wL4kK44UIIt92TTByk+q4tP5g=
X-Received: by 2002:a05:6830:1f5a:: with SMTP id u26mr2273458oth.250.1606836793188;
 Tue, 01 Dec 2020 07:33:13 -0800 (PST)
MIME-Version: 1.0
References: <20201101170454.9567-1-rppt@kernel.org> <43c53597-6267-bdc2-a975-0aab5daa0d37@physik.fu-berlin.de>
 <20201117062316.GB370813@kernel.org> <a7d01146-77f9-d363-af99-af3aee3789b4@physik.fu-berlin.de>
 <20201201102901.GF557259@kernel.org> <e3d5d791-8e4f-afcc-944c-24f66f329bd7@physik.fu-berlin.de>
 <20201201121033.GG557259@kernel.org> <49a2022c-f106-55ec-9390-41307a056517@physik.fu-berlin.de>
 <20201201135623.GA751215@kernel.org> <59351dbb-96cc-93b2-f2ec-b8968e935845@kernel.dk>
In-Reply-To: <59351dbb-96cc-93b2-f2ec-b8968e935845@kernel.dk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 1 Dec 2020 16:33:01 +0100
Message-ID: <CAMuHMdWRc8W7U0LKyH9u1hdMuN515PCZiTEJ12FrDaCx-eTdaQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] arch, mm: deprecate DISCONTIGMEM
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Mike Rapoport <rppt@kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matt Turner <mattst88@gmail.com>, Meelis Roos <mroos@linux.ee>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Will Deacon <will@kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux MM <linux-mm@kvack.org>,
        arcml <linux-snps-arc@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jens,

On Tue, Dec 1, 2020 at 4:03 PM Jens Axboe <axboe@kernel.dk> wrote:
> On 12/1/20 6:56 AM, Mike Rapoport wrote:
> > (added Jens)
> >
> > On Tue, Dec 01, 2020 at 01:16:05PM +0100, John Paul Adrian Glaubitz wrote:
> >> Hi Mike!
> >>
> >> On 12/1/20 1:10 PM, Mike Rapoport wrote:
> >>> On Tue, Dec 01, 2020 at 12:35:09PM +0100, John Paul Adrian Glaubitz wrote:
> >>>> Hi Mike!
> >>>>
> >>>> On 12/1/20 11:29 AM, Mike Rapoport wrote:
> >>>>> These changes are in linux-mm tree (https://www.ozlabs.org/~akpm/mmotm/
> >>>>> with a mirror at https://github.com/hnaz/linux-mm)
> >>>>>
> >>>>> I beleive they will be coming in 5.11.
> >>>>
> >>>> Just pulled from that tree and gave it a try, it actually fails to build:
> >>>>
> >>>>   LDS     arch/ia64/kernel/vmlinux.lds
> >>>>   AS      arch/ia64/kernel/entry.o
> >>>> arch/ia64/kernel/entry.S: Assembler messages:
> >>>> arch/ia64/kernel/entry.S:710: Error: Operand 2 of `and' should be a general register
> >>>> arch/ia64/kernel/entry.S:710: Error: qualifying predicate not followed by instruction
> >>>> arch/ia64/kernel/entry.S:848: Error: Operand 2 of `and' should be a general register
> >>>> arch/ia64/kernel/entry.S:848: Error: qualifying predicate not followed by instruction
> >>>>   GEN     usr/initramfs_data.cpio
> >>>> make[1]: *** [scripts/Makefile.build:364: arch/ia64/kernel/entry.o] Error 1
> >>>> make: *** [Makefile:1797: arch/ia64/kernel] Error 2
> >>>> make: *** Waiting for unfinished jobs....
> >>>>   CC      init/do_mounts_initrd.o
> >>>>   SHIPPED usr/initramfs_inc_data
> >>>>   AS      usr/initramfs_data.o
> >>>
> >>> Hmm, it was buidling fine with v5.10-rc2-mmotm-2020-11-07-21-40.
> >>> I'll try to see what could cause this.
> >>>
> >>> Do you build with defconfig or do you use a custom config?
> >>
> >> That's with "localmodconfig", see attached configuration file.
> >
> > Thanks.
> > It seems that the recent addition of TIF_NOTIFY_SIGNAL to ia64 in
> > linux-next caused the issue. Can you please try the below patch?
>
> That's a lot of typos in that patch... I wonder why the buildbot hasn't
> complained about this. Thanks for fixing this up! I'm going to fold this
> into the original to avoid the breakage.

Does lkp@intel.com do ia64 builds? Yes, it builds zx1_defconfig.

Kisskb doesn't seem to build zx1_defconfig, but generic_defconfig.
http://kisskb.ellerman.id.au/kisskb/target/101883/ shows this has been broken
since Oct 30.  Perhaps kisskb build failures are not emailed to the ia64
maintainers, or not acted upon?
(I do receive kisskb build failure emails for m68k)

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
