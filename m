Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0696C4EF9C9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Apr 2022 20:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239054AbiDAS0n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Apr 2022 14:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349906AbiDAS0k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Apr 2022 14:26:40 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F027197511
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Apr 2022 11:24:49 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id jx9so3118487pjb.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Apr 2022 11:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u8pAbwXuVZ7sCmxLVbJSUFO5pNLY6s4GVBTnQJD82aI=;
        b=YYzb/Ra45v4lgC8Mo/lsfCtm73X48xfnKrwB54MwA5wPabpTz4mmwu8S2I8qAYyJj5
         Kn8uWkEGKw42ptlWD2HrRNgNxXueDq73aO//NsxdRXksW3j8tF8LEZ9TNnOWeavfn4mS
         ZnUNSezrBOtvRZXs/fW/nfMTjCy5B2muTjyglf0mxjSXQ6YnqfEviq2D7D++dUzYgxcG
         UdF4Qru6HTQXhc6znRvUaCdL76qs761lqxWW05blkvDbtrYsJVEI4tJZNsF09hAOBLyT
         1WnaRrSyuvDFbGtFyDjWoiF7bOi7Ge6us5fAD3EwikvFCxEpyQbi8pGe9Fn/yt7zc2oz
         m/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u8pAbwXuVZ7sCmxLVbJSUFO5pNLY6s4GVBTnQJD82aI=;
        b=2LzC6+0FRnUb64kTP5WltMXKxHZDnNLHQwxQJpixBYSDZuS85C+AxGiND/7laUOxYA
         OncGu0lnY0eADt7guEstHMFdBEafDTuuQEkU4bdGxPvUCpSkYDuMLcwBPOReLirz+f1g
         EOq3FDiZRcNPy1EVIJleLJwMC/v+t3QY9F8MAlr8iE9SOk7NZzbgZcDOWabmam7HB0EV
         GVb435Q0ZOq4FZdV6hadXST6Szp0Do1eY+UCrG/qoxW64DtkT9T+arlQj2Sj4Q+6oOcI
         oxpXHnbs5bM9u7c8ayig40OKUo1+IxORE5OMXmKXLIB1Ae9/2mBiUZJ+cbXIKdoCVenD
         SmYQ==
X-Gm-Message-State: AOAM530LyGe4uxrFQ8xaX/LYCRfgL2cwADk+EwSBW94IZ0cfHEg5Zkiv
        ro+FLGqlZ9hrAE1VELih27u7Vw==
X-Google-Smtp-Source: ABdhPJwlAe0fXT7OVI7wEJgZhusGac4WQ7Y+Hjw0pJaGrpLtvXvp7Ss9UWdSc1InlU9W2r2G1vWIkQ==
X-Received: by 2002:a17:90b:1c86:b0:1bf:2a7e:5c75 with SMTP id oo6-20020a17090b1c8600b001bf2a7e5c75mr13348243pjb.145.1648837488223;
        Fri, 01 Apr 2022 11:24:48 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id oc10-20020a17090b1c0a00b001c7510ed0c8sm14589897pjb.49.2022.04.01.11.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 11:24:47 -0700 (PDT)
Date:   Fri, 1 Apr 2022 18:24:44 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Quentin Perret <qperret@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
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
Message-ID: <YkdDbCdFy1Fp06K2@google.com>
References: <YkH32nx+YsJuUbmZ@google.com>
 <YkIFW25WgV2WIQHb@google.com>
 <YkM7eHCHEBe5NkNH@google.com>
 <88620519-029e-342b-0a85-ce2a20eaf41b@arm.com>
 <YkQzfjgTQaDd2E2T@google.com>
 <YkSaUQX89ZEojsQb@google.com>
 <80aad2f9-9612-4e87-a27a-755d3fa97c92@www.fastmail.com>
 <YkcTTY4YjQs5BRhE@google.com>
 <Ykcy7fj/d+f9OUl/@google.com>
 <Ykc+ZNWlsXCaOrM9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ykc+ZNWlsXCaOrM9@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 01, 2022, Quentin Perret wrote:
> On Friday 01 Apr 2022 at 17:14:21 (+0000), Sean Christopherson wrote:
> > On Fri, Apr 01, 2022, Quentin Perret wrote:
> > I assume there is a scenario where a page can be converted from shared=>private?
> > If so, is there a use case where that happens post-boot _and_ the contents of the
> > page are preserved?
> 
> I think most our use-cases are private=>shared, but how is that
> different?

Ah, it's not really different.  What I really was trying to understand is if there
are post-boot conversions that preserve data.  I asked about shared=>private because
there are known pre-boot conversions, e.g. populating the initial guest image, but
AFAIK there are no use cases for post-boot conversions, which might be more needy in
terms of performance.

> > > We currently don't allow the host punching holes in the guest IPA space.
> > 
> > The hole doesn't get punched in guest IPA space, it gets punched in the private
> > backing store, which is host PA space.
> 
> Hmm, in a previous message I thought that you mentioned when a whole
> gets punched in the fd KVM will go and unmap the page in the private
> SPTEs, which will cause a fatal error for any subsequent access from the
> guest to the corresponding IPA?

Oooh, that was in the context of TDX.  Mixing VMX and arm64 terminology... TDX has
two separate stage-2 roots, one for private IPAs and one for shared IPAs.  The
guest selects private/shared by toggling a bit stolen from the guest IPA space.
Upon conversion, KVM will remove from one stage-2 tree and insert into the other.

But even then, subsequent accesses to the wrong IPA won't be fatal, as KVM will
treat them as implicit conversions.  I wish they could be fatal, but that's not
"allowed" given the guest/host contract dictated by the TDX specs.

> If that's correct, I meant that we currently don't support that - the
> host can't unmap anything from the guest stage-2, it can only tear it
> down entirely. But again, I'm not too worried about that, we could
> certainly implement that part without too many issues.

I believe for the pKVM case it wouldn't be unmapping, it would be a PFN change.

> > > Once it has donated a page to a guest, it can't have it back until the
> > > guest has been entirely torn down (at which point all of memory is
> > > poisoned by the hypervisor obviously).
> > 
> > The guest doesn't have to know that it was handed back a different page.  It will
> > require defining the semantics to state that the trusted hypervisor will clear
> > that page on conversion, but IMO the trusted hypervisor should be doing that
> > anyways.  IMO, forcing on the guest to correctly zero pages on conversion is
> > unnecessarily risky because converting private=>shared and preserving the contents
> > should be a very, very rare scenario, i.e. it's just one more thing for the guest
> > to get wrong.
> 
> I'm not sure I agree. The guest is going to communicate with an
> untrusted entity via that shared page, so it better be careful. Guest
> hardening in general is a major topic, and of all problems, zeroing the
> page before sharing is probably one of the simplest to solve.

Yes, for private=>shared you're correct, the guest needs to be paranoid as
there are no guarantees as to what data may be in the shared page.

I was thinking more in the context of shared=>private conversions, e.g. the guest
is done sharing a page and wants it back.  In that case, forcing the guest to zero
the private page upon re-acceptance is dicey.  Hmm, but if the guest needs to
explicitly re-accept the page, then putting the onus on the guest to zero the page
isn't a big deal.  The pKVM contract would just need to make it clear that the
guest cannot make any assumptions about the state of private data 

Oh, now I remember why I'm biased toward the trusted entity doing the work.
IIRC, thanks to TDX's lovely memory poisoning and cache aliasing behavior, the
guest can't be trusted to properly initialize private memory with the guest key,
i.e. the guest could induce a #MC and crash the host.

Anywho, I agree that for performance reasons, requiring the guest to zero private
pages is preferable so long as the guest must explicitly accept/initiate conversions.

> Also, note that in pKVM all the hypervisor code at EL2 runs with
> preemption disabled, which is a strict constraint. As such one of the
> main goals is the spend as little time as possible in that context.
> We're trying hard to keep the amount of zeroing/memcpy-ing to an
> absolute minimum. And that's especially true as we introduce support for
> huge pages. So, we'll take every opportunity we get to have the guest
> or the host do that work.

FWIW, TDX has the exact same constraints (they're actually worse as the trusted
entity runs with _all_ interrupts blocked).  And yeah, it needs to be careful when
dealing with huge pages, e.g. many flows force the guest/host to do 512 * 4kb operations.
