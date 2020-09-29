Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDD627D084
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Sep 2020 16:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731067AbgI2OEn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Sep 2020 10:04:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730077AbgI2OEm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Sep 2020 10:04:42 -0400
Received: from kernel.org (unknown [87.71.73.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C8EF20848;
        Tue, 29 Sep 2020 14:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601388281;
        bh=WaJTg3SQjbcW6v/DzBgW2ai/TQzh1nqimfbp97MMiZg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g/sTn+vuGDTybOkywy/hzK7aJ4iFWFxujqk7E2jgui44H35NmFrCcMr3S2mhlUWeH
         RlNghCYd1xYJLA4ucZ8Vo4pHssTfstFhjlURUf8gE12YAEPb3mM3qxx0M1Gl8xPkdq
         sLFMhLXPdlIflpJ6y2oTcFDApMPO11kHq6sLeZiY=
Date:   Tue, 29 Sep 2020 17:04:24 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shuah Khan <shuah@kernel.org>, Tycho Andersen <tycho@tycho.ws>,
        Will Deacon <will@kernel.org>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
Subject: Re: [PATCH v6 5/6] mm: secretmem: use PMD-size pages to amortize
 direct map fragmentation
Message-ID: <20200929140424.GI2142832@kernel.org>
References: <20200924132904.1391-1-rppt@kernel.org>
 <20200924132904.1391-6-rppt@kernel.org>
 <20200925074125.GQ2628@hirez.programming.kicks-ass.net>
 <8435eff6-7fa9-d923-45e5-d8850e4c6d73@redhat.com>
 <20200925095029.GX2628@hirez.programming.kicks-ass.net>
 <20200925103114.GA7407@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925103114.GA7407@C02TD0UTHF1T.local>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 25, 2020 at 11:31:14AM +0100, Mark Rutland wrote:
> Hi,
> 
> Agreed. I think if we really need something like this, something between
> XPFO and DEBUG_PAGEALLOC would be generally better, since:
> 
> * Secretmem puts userspace in charge of kernel internals (AFAICT without
>   any ulimits?), so that seems like an avenue for malicious or buggy
>   userspace to exploit and trigger DoS, etc. The other approaches leave
>   the kernel in charge at all times, and it's a system-level choice
>   which is easier to reason about and test.

Secretmem obeys RLIMIT_MLOCK.
I don't see why it "puts userpspace in charge of kernel internals" more
than other system calls. The fact that memory is dropped from
linear/direct mapping does not make userspace in charge of the kernel
internals. The fact that this is not system-level actually makes it more
controllable and tunable, IMHO.

> * Secretmem interaction with existing ABIs is unclear. Should uaccess
>   primitives work for secretmem? If so, this means that it's not valid
>   to transform direct uaccesses in syscalls etc into accesses via the
>   linear/direct map. If not, how do we prevent syscalls? The other
>   approaches are clear that this should always work, but the kernel
>   should avoid mappings wherever possible.

Our idea was that direct uaccess in the context of the process that owns
the secretmem should work and that transforming the direct uaccesses
into accesses via the linear map would be valid only when allowed
explicitly. E.g with addition of FOLL_SOMETHING to gup.
Yet, this would be required for any implementation of memory areas that
excludes pages from the linear mapping.

> * The uncached option doesn't work in a number of situations, such as
>   systems which are purely cache coherent at all times, or where the
>   hypervisor has overridden attributes. The kernel cannot even know that
>   whther this works as intended. On its own this doens't solve a
>   particular problem, and I think this is a solution looking for a
>   problem.

As we discussed at one of the previous iterations, the uncached makes
sense for x86 to reduce availability of side channels and I've only
enabled uncached mappings on x86.

> ... and fundamentally, this seems like a "more security, please" option
> that is going to be abused, since everyone wants security, regardless of
> how we say it *should* be used. The few use-cases that may make sense
> (e.g. protection of ketys and/or crypto secrrets), aren't going to be
> able to rely on this (since e.g. other uses may depelete memory pools),
> so this is going to be best-effort. With all that in mind, I struggle to
> beleive that this is going to be worth the maintenance cost (e.g. with
> any issues arising from uaccess, IO, etc).

I think that making secretmem a file descriptor that only allows mmap()
already makes it quite self contained and simple. There could be several
cases that will need special treatment, but I don't think it will have
large maintenance cost.
I've run syzkaller for some time with memfd_secret() enabled and I never
hit a crash because of it.

> Thanks,
> Mark.

-- 
Sincerely yours,
Mike.
