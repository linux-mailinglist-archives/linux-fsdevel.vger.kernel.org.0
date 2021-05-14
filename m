Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF4C38133D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 23:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbhENVli (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 May 2021 17:41:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:59180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229889AbhENVlh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 May 2021 17:41:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2942F613C5;
        Fri, 14 May 2021 21:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1621028425;
        bh=C0ec2lfIbPBQ13yCQGnS5z2cME0lA0z5uIv9YCgayBU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BFAquXp3lA88Qe0Ju8asJkbRhmzDZKSdYwghLg2G9D+BTRY9z759N2CaiNhqRQMC+
         QgMuArxF7WcxRpzSvxYcAPU7TGVk0IAfwv0ayQxwfAsBB3Hz2vzVnKwD52XYPS3EEX
         cfpyUGuHZVn94x+oXcMO5o/2aDo7e9A6Cd2AxR7Q=
Date:   Fri, 14 May 2021 14:40:24 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Mark Brown <broonie@kernel.org>, linux-fsdevel@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        mhocko@suse.cz, mm-commits@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        lkft-triage@lists.linaro.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: mmotm 2021-05-12-21-46 uploaded (arch/x86/mm/pgtable.c)
Message-Id: <20210514144024.ed67212e0577961d7ac2c16e@linux-foundation.org>
In-Reply-To: <CA+G9fYv79t0+2W4Rt3wDkBShc4eY3M3utC5BHqUgGDwMYExYMw@mail.gmail.com>
References: <20210513044710.MCXhM_NwC%akpm@linux-foundation.org>
        <151ddd7f-1d3e-a6f7-daab-e32f785426e1@infradead.org>
        <54055e72-34b8-d43d-2ad3-87e8c8fa547b@csgroup.eu>
        <20210513134754.ab3f1a864b0156ef99248401@linux-foundation.org>
        <a3ac0b42-f779-ffaf-c6d7-0d4b40dc25f2@infradead.org>
        <CA+G9fYv79t0+2W4Rt3wDkBShc4eY3M3utC5BHqUgGDwMYExYMw@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 14 May 2021 15:15:41 +0530 Naresh Kamboju <naresh.kamboju@linaro.org> wrote:

> On Fri, 14 May 2021 at 02:38, Randy Dunlap <rdunlap@infradead.org> wrote:
> >
> > On 5/13/21 1:47 PM, Andrew Morton wrote:
> > > On Thu, 13 May 2021 19:09:23 +0200 Christophe Leroy <christophe.leroy@csgroup.eu> wrote:
> > >
> > >>
> > >>
> > >>> on i386:
> > >>>
> > >>> ../arch/x86/mm/pgtable.c:703:5: error: redefinition of ‘pud_set_huge’
> > >>>   int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
> > >>>       ^~~~~~~~~~~~
> > >>> In file included from ../include/linux/mm.h:33:0,
> > >>>                   from ../arch/x86/mm/pgtable.c:2:
> > >>> ../include/linux/pgtable.h:1387:19: note: previous definition of ‘pud_set_huge’ was here
> > >>>   static inline int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
> > >>>                     ^~~~~~~~~~~~
> > >>> ../arch/x86/mm/pgtable.c:758:5: error: redefinition of ‘pud_clear_huge’
> > >>>   int pud_clear_huge(pud_t *pud)
> > >>>       ^~~~~~~~~~~~~~
> > >>> In file included from ../include/linux/mm.h:33:0,
> > >>>                   from ../arch/x86/mm/pgtable.c:2:
> > >>> ../include/linux/pgtable.h:1391:19: note: previous definition of ‘pud_clear_huge’ was here
> > >>>   static inline int pud_clear_huge(pud_t *pud)
> 
> These errors are noticed on linux next 20210514 tag on arm64.
> Regressions found on arm64 for the following configs.
> 
>   - build/gcc-9-defconfig-904271f2
>   - build/gcc-9-tinyconfig
>   - build/gcc-8-allnoconfig
>   - build/gcc-10-allnoconfig
>   - build/clang-11-allnoconfig
>   - build/clang-10-allnoconfig
>   - build/clang-12-tinyconfig
>   - build/gcc-10-tinyconfig
>   - build/clang-10-tinyconfig
>   - build/clang-11-tinyconfig
>   - build/clang-12-allnoconfig
>   - build/gcc-8-tinyconfig
>   - build/gcc-9-allnoconfig

I can't get arm64 to compile at all ;(.  5.13-rc1 base with gcc-9.3.0,
tinyconfig:

In file included from ././include/linux/compiler_types.h:65,
                 from <command-line>:
./include/linux/smp.h:34:26: error: requested alignment '20' is not a positive power of 2
   34 |  __aligned(sizeof(struct __call_single_data));
      |                          ^~~~~~~~~~~~~~~~~~
./include/linux/compiler_attributes.h:52:68: note: in definition of macro '__aligned'
   52 | #define __aligned(x)                    __attribute__((__aligned__(x)))
      |                                                                    ^
In file included from ./arch/arm64/include/asm/thread_info.h:17,
                 from ./include/linux/thread_info.h:59,
                 from ./arch/arm64/include/asm/preempt.h:5,
                 from ./include/linux/preempt.h:78,
                 from ./include/linux/smp.h:110,
                 from ./include/linux/lockdep.h:14,
                 from ./include/linux/mutex.h:17,
                 from ./include/linux/kernfs.h:12,
                 from ./include/linux/sysfs.h:16,
                 from ./include/linux/kobject.h:20,
                 from ./include/linux/of.h:17,
                 from ./include/linux/irqdomain.h:35,
                 from ./include/linux/acpi.h:13,
                 from ./include/acpi/apei.h:9,
                 from ./include/acpi/ghes.h:5,
                 from ./include/linux/arm_sdei.h:8,
                 from arch/arm64/kernel/asm-offsets.c:10:
./arch/arm64/include/asm/memory.h: In function 'kaslr_offset':
./arch/arm64/include/asm/memory.h:65:33: warning: left shift count >= width of type [-Wshift-count-overflow]
   65 | #define _PAGE_END(va)  (-(UL(1) << ((va) - 1)))
      |                                 ^~
./arch/arm64/include/asm/memory.h:47:31: note: in expansion of macro '_PAGE_END'
   47 | #define BPF_JIT_REGION_START (_PAGE_END(VA_BITS_MIN))
      |                               ^~~~~~~~~
./arch/arm64/include/asm/memory.h:49:29: note: in expansion of macro 'BPF_JIT_REGION_START'
   49 | #define BPF_JIT_REGION_END (BPF_JIT_REGION_START + BPF_JIT_REGION_SIZE)
      |                             ^~~~~~~~~~~~~~~~~~~~
./arch/arm64/include/asm/memory.h:51:25: note: in expansion of macro 'BPF_JIT_REGION_END'
   51 | #define MODULES_VADDR  (BPF_JIT_REGION_END)
      |                         ^~~~~~~~~~~~~~~~~~
./arch/arm64/include/asm/memory.h:50:23: note: in expansion of macro 'MODULES_VADDR'
   50 | #define MODULES_END  (MODULES_VADDR + MODULES_VSIZE)
      |                       ^~~~~~~~~~~~~
./arch/arm64/include/asm/memory.h:46:24: note: in expansion of macro 'MODULES_END'
   46 | #define KIMAGE_VADDR  (MODULES_END)
      |                        ^~~~~~~~~~~
./arch/arm64/include/asm/memory.h:196:24: note: in expansion of macro 'KIMAGE_VADDR'
  196 |  return kimage_vaddr - KIMAGE_VADDR;
      |                        ^~~~~~~~~~~~
In file included from ./arch/arm64/include/asm/thread_info.h:17,
                 from ./include/linux/thread_info.h:59,
                 from ./arch/arm64/include/asm/preempt.h:5,
                 from ./include/linux/preempt.h:78,
                 from ./include/linux/smp.h:110,
                 from ./include/linux/lockdep.h:14,
                 from ./include/linux/mutex.h:17,
                 from ./include/linux/kernfs.h:12,
                 from ./include/linux/sysfs.h:16,
                 from ./include/linux/kobject.h:20,
                 from ./include/linux/of.h:17,
                 from ./include/linux/irqdomain.h:35,
                 from ./include/linux/acpi.h:13,
                 from ./include/acpi/apei.h:9,
                 from ./include/acpi/ghes.h:5,
                 from ./include/linux/arm_sdei.h:8,
                 from arch/arm64/kernel/asm-offsets.c:10:

and lots of other errors beside that.
