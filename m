Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3F9235A11
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Aug 2020 20:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbgHBSyj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Aug 2020 14:54:39 -0400
Received: from linux.microsoft.com ([13.77.154.182]:55680 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgHBSyi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Aug 2020 14:54:38 -0400
Received: from [192.168.254.32] (unknown [47.187.206.220])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8B20620B4908;
        Sun,  2 Aug 2020 11:54:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8B20620B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596394477;
        bh=Bi0Avm087nVKLtlYIbtSWKURIDHCpmDKtLVQ5vuWflc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fHpnzFOJOlzwXKwSY8zPf6k+L+PvjjAKdLTYmh86GcRZ1GlLSdgkG9g2/aH5jJhcq
         rLnj76Yu6QdnUO6KTpkXFwOCQ9jicshEkSNSDxcUKT9TPhmvEepbEQ05Wq5VephZTP
         PadVn+hOSExc6VqPzwe7hlZHes7rqpGKqv+UP3nE=
Subject: Re: [PATCH v1 0/4] [RFC] Implement Trampoline File Descriptor
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, X86 ML <x86@kernel.org>
References: <20200728131050.24443-1-madvenka@linux.microsoft.com>
 <CALCETrVy5OMuUx04-wWk9FJbSxkrT2vMfN_kANinudrDwC4Cig@mail.gmail.com>
From:   "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Message-ID: <3b916198-3a98-bd19-9a1c-f2d8d44febe8@linux.microsoft.com>
Date:   Sun, 2 Aug 2020 13:54:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CALCETrVy5OMuUx04-wWk9FJbSxkrT2vMfN_kANinudrDwC4Cig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

More responses inline..

On 7/28/20 12:31 PM, Andy Lutomirski wrote:
>> On Jul 28, 2020, at 6:11 AM, madvenka@linux.microsoft.com wrote:
>>
>> ﻿From: "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
>>
>
> 2. Use existing kernel functionality.  Raise a signal, modify the
> state, and return from the signal.  This is very flexible and may not
> be all that much slower than trampfd.

Let me understand this. You are saying that the trampoline code
would raise a signal and, in the signal handler, set up the context
so that when the signal handler returns, we end up in the target
function with the context correctly set up. And, this trampoline code
can be generated statically at build time so that there are no
security issues using it.

Have I understood your suggestion correctly?

So, my argument would be that this would always incur the overhead
of a trip to the kernel. I think twice the overhead if I am not mistaken.
With trampfd, we can have the kernel generate the code so that there
is no performance penalty at all.

Signals have many problems. Which signal number should we use for this
purpose? If we use an existing one, that might conflict with what the application
is already handling. Getting a new signal number for this could meet
with resistance from the community.

Also, signals are asynchronous. So, they are vulnerable to race conditions.
To prevent other signals from coming in while handling the raised signal,
we would need to block and unblock signals. This will cause more
overhead.

> 3. Use a syscall.  Instead of having the kernel handle page faults,
> have the trampoline code push the syscall nr register, load a special
> new syscall nr into the syscall nr register, and do a syscall. On
> x86_64, this would be:
>
> pushq %rax
> movq __NR_magic_trampoline, %rax
> syscall
>
> with some adjustment if the stack slot you're clobbering is important.

How is this better than the kernel handling an address fault?
The system call still needs to do the same work as the fault handler.
We do need to specify the register and stack contexts before hand
so the system call can do its job.

Also, this always incurs a trip to the kernel. With trampfd, the kernel
could generate the code to avoid the performance penalty.


>
> Also, will using trampfd cause issues with various unwinders?  I can
> easily imagine unwinders expecting code to be readable, although this
> is slowly going away for other reasons.

I need to study unwinders a little before I respond to this question.
So, bear with me.

> All this being said, I think that the kernel should absolutely add a
> sensible interface for JITs to use to materialize their code.  This
> would integrate sanely with LSMs and wouldn't require hacks like using
> files, etc.  A cleverly designed JIT interface could function without
> seriailization IPIs, and even lame architectures like x86 could
> potentially avoid shootdown IPIs if the interface copied code instead
> of playing virtual memory games.  At its very simplest, this could be:
>
> void *jit_create_code(const void *source, size_t len);
>
> and the result would be a new anonymous mapping that contains exactly
> the code requested.  There could also be:
>
> int jittfd_create(...);
>
> that does something similar but creates a memfd.  A nicer
> implementation for short JIT sequences would allow appending more code
> to an existing JIT region.  On x86, an appendable JIT region would
> start filled with 0xCC, and I bet there's a way to materialize new
> code into a previously 0xcc-filled virtual page wthout any
> synchronization.  One approach would be to start with:
>
> <some code>
> 0xcc
> 0xcc
> ...
> 0xcc
>
> and to create a whole new page like:
>
> <some code>
> <some more code>
> 0xcc
> ...
> 0xcc
>
> so that the only difference is that some code changed to some more
> code.  Then replace the PTE to swap from the old page to the new page,
> and arrange to avoid freeing the old page until we're sure it's gone
> from all TLBs.  This may not work if <some more code> spans a page
> boundary.  The #BP fixup would zap the TLB and retry.  Even just
> directly copying code over some 0xcc bytes almost works, but there's a
> nasty corner case involving instructions that fetch I$ fetch
> boundaries.  I'm not sure to what extent I$ snooping helps.

I am thinking that the trampfd API can be used for addressing JIT
code as well. I have not yet started thinking about the details. But I
think the API is sufficient. E.g.,

    struct trampfd_jit {
        void    *source;
        size_t    len;
    };

    struct trampfd_jit    jit;
    struct trampfd_map    map;
    void    *addr;

    jit.source = blah;
    jit.size = blah;

    fd = syscall(440, TRAMPFD_JIT, &jit, flags);
    pread(fd, &map, sizeof(map), TRAMPFD_MAP_OFFSET);
    addr = mmap(NULL, map.size, map.prot, map.flags, fd, map.offset);

And addr would be used to invoke the generated JIT code.

Madhavan

