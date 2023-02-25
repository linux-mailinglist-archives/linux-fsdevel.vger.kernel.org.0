Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B946A2B3F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 19:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjBYSLk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Feb 2023 13:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjBYSLj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Feb 2023 13:11:39 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A7A168A8;
        Sat, 25 Feb 2023 10:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VkU3wglkazA3WDdsvY+r6GTOXkswm1z2trXm0IechuI=; b=DjStN73s/52C2aKUHJ/N7u+67C
        xKVsxbGgc73JqCB9UjmsEXo28HLWtkaadn4Qvw3tfQ17fHwFv4xLIaSY4juqo0jfuluJOSt53Nnm0
        J8miHKoX3rnhGz3CIFW4q/edegpeos3t2+FOnrUohR5FwZmcES4bSpPnvsdPfTmg8vIyGFPAxJ0WL
        2xtQTXNuwr45ZB2usatus2AtDy+tzz51O8QNmg4FLoCibIJRsy7SLXCoy3hYICxmMM0rpCnf4hXNF
        toOagD/u7ZgV18tcTWmTxhdx/qim6JhKTXHpKXqQl9N286vfbTxVVsV64HYFhRv988vdiaujpipbm
        egPcgAcg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pVz1D-00CHC6-39;
        Sat, 25 Feb 2023 18:11:36 +0000
Date:   Sat, 25 Feb 2023 18:11:35 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [git pull] vfs.git misc bits
Message-ID: <Y/pPV0q43R+drVtV@ZenIV>
References: <Y/gxyQA+yKJECwyp@ZenIV>
 <CAHk-=wiPHkYmiFY_O=7MK-vbWtLEiRP90ufugj1H1QFeiLPoVw@mail.gmail.com>
 <Y/mEQUfLqf8m2s/G@ZenIV>
 <Y/mVP5EsmoCt9NwK@ZenIV>
 <CAHk-=wgQz8VDDxdaj3rk861Ucjzk72hJoCjZvfaeo8jCyVc_2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgQz8VDDxdaj3rk861Ucjzk72hJoCjZvfaeo8jCyVc_2w@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 25, 2023 at 09:04:57AM -0800, Linus Torvalds wrote:
> On Fri, Feb 24, 2023 at 8:57 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Let's have it sit around for at least a few days, OK?  I mean, I'm pretty
> > certain that these are fixes, but they hadn't been in any public tree -
> > only posted to linux-arch.  At least #fixes gets picked by linux-next...
> 
> Ack, sounds good.

... and Intel build-bot had immediately caught a breakage in microblaze.
Fixed and pushed out; I've checked all architectures affected by
this series, and that was the only build breakage.  However, I still have
no way to test it (or anything, for that matter) on microblaze - I've no
userland images for it.  Status right now:

alpha: bug confirmed, patch fixes it.
hexagon, m68k, riscv: acked by maintainer (with explicit tested-by for m68k and riscv)
microblaze, openrisc, nios2: builds, no way for me to test.
sparc32, sparc64, itanic: builds, preparing to test (itanic - once I resurrect
the sodding space heater I hadn't tried to boot for a couple of years; no
idea whether it works).
parisc: builds, but maintainers say that reproducer doesn't confirm the bug
in mainline.  I've parisc32 box, will try to resurrect and see what's going
on.  No way to test parisc64 here - no hardware and qemu/pa-risc doesn't handle
64bit system emulation.

Incidentally, while digging through the arch code around #PF, something's
weird on csky.  Not this bug (it's handled correctly there), but...
looks like vm_get_page_prot(0) returns something that would *not*
pass pte_present().  Which should make life wonderful for e.g. PROT_READ|PROT_WRITE
mmap() + memcpy to it + PROT_NONE mprotect() + PROT_READ|PROT_WRITE mprotect().

Unless I'm seriously misunderstanding something, we have 3 mutually exclusive
cases:
	absent PTE - no further information in it.  No page at the corresponding
address range, access will fault and work from scratch; pte_none() is true for those.
	swap PTE - page had been swapped out, access will fault, the information in
the entry encodes the location in swap.  is_swap_pte() is true for those.
	normal page - page is there, access might or might not fault due to permissions,
PTE contains the page frame number.  pte_present() is true for those.

PROT_NONE should not yield something that looks like a swap entry.  And on csky we
have
#define PAGE_NONE       __pgprot(_PAGE_PROT_NONE)
#define pte_none(pte)           (!(pte_val(pte) & ~_PAGE_GLOBAL))
#define pte_present(pte)        (pte_val(pte) & _PAGE_PRESENT)

and

arch/csky/abiv1/inc/abi/pgtable-bits.h:26:#define _PAGE_PROT_NONE               _PAGE_READ
arch/csky/abiv1/inc/abi/pgtable-bits.h:8:#define _PAGE_READ             (1<<1)
arch/csky/abiv1/inc/abi/pgtable-bits.h:14:#define _PAGE_GLOBAL          (1<<6)
arch/csky/abiv1/inc/abi/pgtable-bits.h:7:#define _PAGE_PRESENT          (1<<0)

arch/csky/abiv2/inc/abi/pgtable-bits.h:26:#define _PAGE_PROT_NONE               _PAGE_WRITE
arch/csky/abiv2/inc/abi/pgtable-bits.h:9:#define _PAGE_WRITE            (1<<9)
arch/csky/abiv2/inc/abi/pgtable-bits.h:14:#define _PAGE_GLOBAL          (1<<0)
arch/csky/abiv2/inc/abi/pgtable-bits.h:10:#define _PAGE_PRESENT         (1<<10)

IOW, on both ABI variants we have PAGE_NONE looking like a malformed swap entry.
And is_swap_pte() is simply !pte_none() && !pte_present()...
