Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAA22310F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 19:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732010AbgG1RcO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 13:32:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:45794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731973AbgG1RcO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 13:32:14 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E59F721775
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2020 17:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595957533;
        bh=9/DO98f4NNb2r87lGlZR0IYODVEjduHFQ1okay382Kw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=00hywb4ZCFn7lczpn0BiOMeOm9xDGiOqlvQj8/th2fDX/IzE1putRyI2doIv2tI36
         gO4lphP9SFo10v3da6m5h1BH07cHRR/okVnVy90sS8zQtt5pSIghUkUXx0ikOM7Nd0
         h6O5+kD6MR7Vr5ux5UT9pRxsLHVuGsY6clVQqbF0=
Received: by mail-wr1-f52.google.com with SMTP id r12so19043641wrj.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2020 10:32:12 -0700 (PDT)
X-Gm-Message-State: AOAM53326Z2CC4SwGIcBqLeGjkIS+971C5Bi+FRGdCCrrIJ7/mPl7vMK
        nDh5Ep8Cw7QU+R9J4yo6jGE/6ZMZWGrrk3WTLqBnHg==
X-Google-Smtp-Source: ABdhPJxq1bq+hNP4spnLcyA3rbDMq8utpwpjTxFxTkTrdf+BFedxKdyd+N85+0IDFv89rVq0CIoCx1Y8N9iYBQx1zm4=
X-Received: by 2002:a5d:5273:: with SMTP id l19mr25476365wrc.257.1595957531409;
 Tue, 28 Jul 2020 10:32:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200728131050.24443-1-madvenka@linux.microsoft.com>
In-Reply-To: <20200728131050.24443-1-madvenka@linux.microsoft.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 28 Jul 2020 10:31:59 -0700
X-Gmail-Original-Message-ID: <CALCETrVy5OMuUx04-wWk9FJbSxkrT2vMfN_kANinudrDwC4Cig@mail.gmail.com>
Message-ID: <CALCETrVy5OMuUx04-wWk9FJbSxkrT2vMfN_kANinudrDwC4Cig@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] [RFC] Implement Trampoline File Descriptor
To:     madvenka@linux.microsoft.com
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On Jul 28, 2020, at 6:11 AM, madvenka@linux.microsoft.com wrote:
>
> =EF=BB=BFFrom: "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
>

> The kernel creates the trampoline mapping without any permissions. When
> the trampoline is executed by user code, a page fault happens and the
> kernel gets control. The kernel recognizes that this is a trampoline
> invocation. It sets up the user registers based on the specified
> register context, and/or pushes values on the user stack based on the
> specified stack context, and sets the user PC to the requested target
> PC. When the kernel returns, execution continues at the target PC.
> So, the kernel does the work of the trampoline on behalf of the
> application.

This is quite clever, but now I=E2=80=99m wondering just how much kernel he=
lp
is really needed. In your series, the trampoline is an non-executable
page.  I can think of at least two alternative approaches, and I'd
like to know the pros and cons.

1. Entirely userspace: a return trampoline would be something like:

1:
pushq %rax
pushq %rbc
pushq %rcx
...
pushq %r15
movq %rsp, %rdi # pointer to saved regs
leaq 1b(%rip), %rsi # pointer to the trampoline itself
callq trampoline_handler # see below

You would fill a page with a bunch of these, possibly compacted to get
more per page, and then you would remap as many copies as needed.  The
'callq trampoline_handler' part would need to be a bit clever to make
it continue to work despite this remapping.  This will be *much*
faster than trampfd. How much of your use case would it cover?  For
the inverse, it's not too hard to write a bit of asm to set all
registers and jump somewhere.

2. Use existing kernel functionality.  Raise a signal, modify the
state, and return from the signal.  This is very flexible and may not
be all that much slower than trampfd.

3. Use a syscall.  Instead of having the kernel handle page faults,
have the trampoline code push the syscall nr register, load a special
new syscall nr into the syscall nr register, and do a syscall. On
x86_64, this would be:

pushq %rax
movq __NR_magic_trampoline, %rax
syscall

with some adjustment if the stack slot you're clobbering is important.


Also, will using trampfd cause issues with various unwinders?  I can
easily imagine unwinders expecting code to be readable, although this
is slowly going away for other reasons.

All this being said, I think that the kernel should absolutely add a
sensible interface for JITs to use to materialize their code.  This
would integrate sanely with LSMs and wouldn't require hacks like using
files, etc.  A cleverly designed JIT interface could function without
seriailization IPIs, and even lame architectures like x86 could
potentially avoid shootdown IPIs if the interface copied code instead
of playing virtual memory games.  At its very simplest, this could be:

void *jit_create_code(const void *source, size_t len);

and the result would be a new anonymous mapping that contains exactly
the code requested.  There could also be:

int jittfd_create(...);

that does something similar but creates a memfd.  A nicer
implementation for short JIT sequences would allow appending more code
to an existing JIT region.  On x86, an appendable JIT region would
start filled with 0xCC, and I bet there's a way to materialize new
code into a previously 0xcc-filled virtual page wthout any
synchronization.  One approach would be to start with:

<some code>
0xcc
0xcc
...
0xcc

and to create a whole new page like:

<some code>
<some more code>
0xcc
...
0xcc

so that the only difference is that some code changed to some more
code.  Then replace the PTE to swap from the old page to the new page,
and arrange to avoid freeing the old page until we're sure it's gone
from all TLBs.  This may not work if <some more code> spans a page
boundary.  The #BP fixup would zap the TLB and retry.  Even just
directly copying code over some 0xcc bytes almost works, but there's a
nasty corner case involving instructions that fetch I$ fetch
boundaries.  I'm not sure to what extent I$ snooping helps.

--Andy
