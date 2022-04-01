Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09AD4EF772
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Apr 2022 18:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348489AbiDAP5L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Apr 2022 11:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349544AbiDAPRY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Apr 2022 11:17:24 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F13FDB4
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Apr 2022 07:59:31 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id i16so6345273ejk.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Apr 2022 07:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ebGPtXiu5HUtQyoqNhZdO92KCGPkkOR97ApJgxTMzik=;
        b=qKMvZ0uz+73PRmlGOgQsh3zTqfJPV2XLOZeRQy0SNRj7ikzNPzjZCE6WDkxxsMLYGl
         jp1SmVDUE4DnEbIb62wHtywaPHT3KZ81zMqI1KkFPnJiIWqTiqb+9Aysn/Hoy2APHnbX
         NeGhEaPPoyVrEMI4k+h0+jnAyhQ45WhIX6WGzSBe/boN4a1k4eC3Tc4wa5yaF8HGJJnZ
         S0nVU9bnQmaEE95KucUq9tXOAXUkWjz0xA5T+ADXrfyErCHCfEJX2DGyEcCfrEM/cg1l
         FKCBb5p1wg1qFEOtg7z+HuklCdulWyZBAOGrsf/npODiLif4HYaNF7NR9Vs8z7acaTsn
         ejhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ebGPtXiu5HUtQyoqNhZdO92KCGPkkOR97ApJgxTMzik=;
        b=KPHiu3tpwqfiAacVaAyZO7YGBXtDBEeQkkgv+9nmkvuscXEGeN9fhrCAcJjBb/29XM
         ltOPYFA2+5T0WJrlOcgO2yTRJYiLtIraF7EEUoKyOlqbV0EXueE6LF4dn0y91M3mTbgA
         6XkP4kmUkccg9NdkDznER5EeqgDjEFf/LosBOU2vL+8ebLrW1gAQZn8jopfRjesD+jyW
         d7Q7vAVKrj8xReoUm7wBCZKO/7x2vZbTtpusTBj3OpHHV0aXidrAmEZ7FdyrazQijQgk
         30KmBGKHRdZsI8f9PQC9xWHtZyCQmsZDN52pdEJP7jWAs/NbFhWM1OlvPBT7/+tELvK0
         nv9Q==
X-Gm-Message-State: AOAM531dvZSqpimz2TU3eWPzdtgqxbGalH/87mgu8q/Zv7owIUoote3K
        kSGUzFcNSOJB7pYvLnYuV7sAtg==
X-Google-Smtp-Source: ABdhPJx9bCGvjBSmplrmdcdg9DcsXsnr8KsvPSDkXSQNWOZOvhJWwLziCro/t6700UZZGELjAFzbkw==
X-Received: by 2002:a17:906:8a6d:b0:6e0:68ac:7197 with SMTP id hy13-20020a1709068a6d00b006e068ac7197mr147150ejc.703.1648825169282;
        Fri, 01 Apr 2022 07:59:29 -0700 (PDT)
Received: from google.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id gl2-20020a170906e0c200b006a767d52373sm1090474ejb.182.2022.04.01.07.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 07:59:28 -0700 (PDT)
Date:   Fri, 1 Apr 2022 14:59:25 +0000
From:   Quentin Perret <qperret@google.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Sean Christopherson <seanjc@google.com>,
        Steven Price <steven.price@arm.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        kvm list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v5 00/13] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Message-ID: <YkcTTY4YjQs5BRhE@google.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <YjyS6A0o4JASQK+B@google.com>
 <YkHspg+YzOsbUaCf@google.com>
 <YkH32nx+YsJuUbmZ@google.com>
 <YkIFW25WgV2WIQHb@google.com>
 <YkM7eHCHEBe5NkNH@google.com>
 <88620519-029e-342b-0a85-ce2a20eaf41b@arm.com>
 <YkQzfjgTQaDd2E2T@google.com>
 <YkSaUQX89ZEojsQb@google.com>
 <80aad2f9-9612-4e87-a27a-755d3fa97c92@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80aad2f9-9612-4e87-a27a-755d3fa97c92@www.fastmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thursday 31 Mar 2022 at 09:04:56 (-0700), Andy Lutomirski wrote:
> On Wed, Mar 30, 2022, at 10:58 AM, Sean Christopherson wrote:
> > On Wed, Mar 30, 2022, Quentin Perret wrote:
> >> On Wednesday 30 Mar 2022 at 09:58:27 (+0100), Steven Price wrote:
> >> > On 29/03/2022 18:01, Quentin Perret wrote:
> >> > > Is implicit sharing a thing? E.g., if a guest makes a memory access in
> >> > > the shared gpa range at an address that doesn't have a backing memslot,
> >> > > will KVM check whether there is a corresponding private memslot at the
> >> > > right offset with a hole punched and report a KVM_EXIT_MEMORY_ERROR? Or
> >> > > would that just generate an MMIO exit as usual?
> >> > 
> >> > My understanding is that the guest needs some way of tagging whether a
> >> > page is expected to be shared or private. On the architectures I'm aware
> >> > of this is done by effectively stealing a bit from the IPA space and
> >> > pretending it's a flag bit.
> >> 
> >> Right, and that is in fact the main point of divergence we have I think.
> >> While I understand this might be necessary for TDX and the likes, this
> >> makes little sense for pKVM. This would effectively embed into the IPA a
> >> purely software-defined non-architectural property/protocol although we
> >> don't actually need to: we (pKVM) can reasonably expect the guest to
> >> explicitly issue hypercalls to share pages in-place. So I'd be really
> >> keen to avoid baking in assumptions about that model too deep in the
> >> host mm bits if at all possible.
> >
> > There is no assumption about stealing PA bits baked into this API.  Even within
> > x86 KVM, I consider it a hard requirement that the common flows not assume the
> > private vs. shared information is communicated through the PA.
> 
> Quentin, I think we might need a clarification.  The API in this patchset indeed has no requirement that a PA bit distinguish between private and shared, but I think it makes at least a weak assumption that *something*, a priori, distinguishes them.  In particular, there are private memslots and shared memslots, so the logical flow of resolving a guest memory access looks like:
> 
> 1. guest accesses a GVA
> 
> 2. read guest paging structures
> 
> 3. determine whether this is a shared or private access
> 
> 4. read host (KVM memslots and anything else, EPT, NPT, RMP, etc) structures accordingly.  In particular, the memslot to reference is different depending on the access type.
> 
> For TDX, this maps on to the fd-based model perfectly: the host-side paging structures for the shared and private slots are completely separate.  For SEV, the structures are shared and KVM will need to figure out what to do in case a private and shared memslot overlap.  Presumably it's sufficient to declare that one of them wins, although actually determining which one is active for a given GPA may involve checking whether the backing store for a given page actually exists.
> 
> But I don't understand pKVM well enough to understand how it fits in.  Quentin, how is the shared vs private mode of a memory access determined?  How do the paging structures work?  Can a guest switch between shared and private by issuing a hypercall without changing any guest-side paging structures or anything else?

My apologies, I've indeed shared very little details about how pKVM
works. We'll be posting patches upstream really soon that will hopefully
help with this, but in the meantime, here is the idea.

pKVM is designed around MMU-based protection as opposed to encryption as
is the case for many confidential computing solutions. It's probably
worth mentioning that, although it targets arm64, pKVM is distinct from
the Arm CC-A stuff and requires no fancy hardware extensions -- it is
applicable all the way back to Arm v8.0 which makes it an interesting
solution for mobile.

Another particularity of the pKVM approach is that the code of the
hypervisor itself lives in the kernel source tree (see
arch/arm64/kvm/hyp/nvhe/). The hypervisor is built with the rest of the
kernel but as a self-sufficient object, and ends up in its own dedicated
ELF section (.hyp.*) in the kernel image. The main requirement for pKVM
(and KVM on arm64 in general) is to have the bootloader enter the kernel
at the hypervisor exception level (a.k.a EL2). The boot procedure is a
bit involved, but eventually the hypervisor object is installed at EL2,
and the kernel is deprivileged to EL1 and proceeds to boot. From that
point on the hypervisor no longer trusts the kernel and will enable the
stage-2 MMU to impose access-control restrictions to all memory accesses
from the host.

All that to say: the pKVM approach offers a great deal of flexibility
when it comes to hypervisor behaviour. We have control over the
hypervisor code and can change it as we see fit. Since both the
hypervisor and the host kernel are part of the same image, the ABI
between them is very much *not* stable and can be adjusted to whatever
makes the most sense. So, I think we'd be quite keen to use that
flexibility to align some of the pKVM behaviours with other players
(TDX, SEV, CC-A), especially when it comes to host mm APIs. But that
flexibility also means we can do some things a bit better (e.g. pKVM can
handle illegal accesses from the host mostly fine -- the hypervisor can
re-inject the fault in the host) so I would definitely like to use this
to our advantage and not be held back by unrelated constraints.

To answer your original question about memory 'conversion', the key
thing is that the pKVM hypervisor controls the stage-2 page-tables for
everyone in the system, all guests as well as the host. As such, a page
'conversion' is nothing more than a permission change in the relevant
page-tables.

The typical flow is as follows:

 - the host asks the hypervisor to run a guest;

 - the hypervisor does the context switch, which includes switching
   stage-2 page-tables;

 - initially the guest has an empty stage-2 (we don't require
   pre-faulting everything), which means it'll immediately fault;

 - the hypervisor switches back to host context to handle the guest
   fault;

 - the host handler finds the corresponding memslot and does the
   ipa->hva conversion. In our current implementation it uses a longterm
   GUP pin on the corresponding page;

 - once it has a page, the host handler issues a hypercall to donate the
   page to the guest;

 - the hypervisor does a bunch of checks to make sure the host owns the
   page, and if all is fine it will unmap it from the host stage-2 and
   map it in the guest stage-2, and do some bookkeeping as it needs to
   track page ownership, etc;

 - the guest can then proceed to run, and possibly faults in many more
   pages;

 - when it wants to, the guest can then issue a hypercall to share a
   page back with the host;

 - the hypervisor checks the request, maps the page back in the host
   stage-2, does more bookkeeping and returns back to the host to notify
   it of the share;

 - the host kernel at that point can exit back to userspace to relay
   that information to the VMM;

 - rinse and repeat.

We currently don't allow the host punching holes in the guest IPA space.
Once it has donated a page to a guest, it can't have it back until the
guest has been entirely torn down (at which point all of memory is
poisoned by the hypervisor obviously). But we could certainly reconsider
that part. OTOH, I'm still inclined to think that in-place sharing is
desirable. In our case it's dirt cheap, and could even work on huge
pages, which would allow very efficient sharing of large amounts of
data. So, I'm a bit hesitant to use the private-fd approach as-is since
it's not immediately obvious how we'll ever be able reconcile these
things if mmap-ing the fd is a firm no. With that said, I don't think
our *current* use-cases have a strong need for this, so I mostly agree
with Sean's point earlier. But since we're talking about committing to a
userspace ABI, I would feel better if there was a clear path towards
having support for in-place sharing -- I can certainly see it being
useful. I'll think about it, but if folks have ideas in the meantime
I'll be happy to discuss.

I hope the above was useful and clears up the confusion.

Thanks,
Quentin
