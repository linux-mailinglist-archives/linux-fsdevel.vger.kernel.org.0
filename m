Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117EC4EC986
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 18:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348740AbiC3QUL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 12:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348729AbiC3QUG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:20:06 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1764140A6
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Mar 2022 09:18:20 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id bx24-20020a17090af49800b001c6872a9e4eso473313pjb.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Mar 2022 09:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nLFu3lC46wywpXjsuIK0ZHIhaIdPVQVthjLJWcG1bqs=;
        b=ObdhiCZmnQ357m81FhFtTehR9aYW6P4+BOjn381CbSMHEsU1E7K3XcewtQe3sJCPWQ
         Csyxq34Lypg3+bYvidjj+H3qoa/rNI7SuZbTd3AoCwOk6Mqd2uRtxKjVcVzSJoZodMTf
         D/y6FT6RGJsMSbkAlI8a0sPYLgZwkMMWyNwRd4fxHKehurrHJxHet0aUP9LncDJtE3cQ
         UPOz+IFAmZ6u0RgCGDhAInm8qhjfecUTWrGa0uueQmXiVf0afirovk1cfrPKwTF9EAHS
         gOr/NoP4PJTR2EKpDT/fo37IVT+5E6uWqx4jWGTeL/5PLf3qFXEVzRH+FzhiYJwPOXLr
         Ejdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nLFu3lC46wywpXjsuIK0ZHIhaIdPVQVthjLJWcG1bqs=;
        b=tG3y6EgsmeEMxjjh9YHahR/pwx7HC5fKfHLlkOa/BfmlJJojxWGuCyAzguBEyvj7F1
         AQUJE1mBzJuBIrWfDoG6qoDeDi8MkcWHIvI8fgFtTe1uKEF3oUIuC0Jn8ZRnM15rW44L
         9/1MNxzpDbufJ3rpggGevcjoGWsVQW7N55fLjtstvSv3nPGmrLX0hLIsFUPnxDn948Yg
         cyh6fm2JOL10oGWuKpLe6n8Jr9g5WEjL2XrLq6Ejf5YjDUQKmbvwbMR6VoDRWzkdjwmI
         Uk2IxXdWr+RnC9F8Zeovaxuz6dsldYf979LWnCmRPzp1T7s6NDbThH3jHlO6dTSJsjvB
         i5zA==
X-Gm-Message-State: AOAM533gwXOyy34pq6ylmv7711wGu0ofBFc0TAmbqqvWZl2m1CfHjGif
        pP+EPrCHvnbzLlty+F0zt7fPaA==
X-Google-Smtp-Source: ABdhPJzu0B5xizLOKCwUOp7QXz7jXFJn2pPNsklxdxdBWzWCsDjkD8HDdgo8h4C6dlF1WJ0c8QhdzA==
X-Received: by 2002:a17:903:2305:b0:154:4aa2:e800 with SMTP id d5-20020a170903230500b001544aa2e800mr29560plh.167.1648657099936;
        Wed, 30 Mar 2022 09:18:19 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id b14-20020a056a000cce00b004fabc39519esm25365204pfv.5.2022.03.30.09.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 09:18:19 -0700 (PDT)
Date:   Wed, 30 Mar 2022 16:18:15 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Quentin Perret <qperret@google.com>,
        Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, maz@kernel.org,
        will@kernel.org
Subject: Re: [PATCH v5 00/13] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Message-ID: <YkSCx7q4Dl25mSp8@google.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <YjyS6A0o4JASQK+B@google.com>
 <YkHspg+YzOsbUaCf@google.com>
 <YkH32nx+YsJuUbmZ@google.com>
 <YkIFW25WgV2WIQHb@google.com>
 <YkM7eHCHEBe5NkNH@google.com>
 <88620519-029e-342b-0a85-ce2a20eaf41b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88620519-029e-342b-0a85-ce2a20eaf41b@arm.com>
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

On Wed, Mar 30, 2022, Steven Price wrote:
> On 29/03/2022 18:01, Quentin Perret wrote:
> > Is implicit sharing a thing? E.g., if a guest makes a memory access in
> > the shared gpa range at an address that doesn't have a backing memslot,
> > will KVM check whether there is a corresponding private memslot at the
> > right offset with a hole punched and report a KVM_EXIT_MEMORY_ERROR? Or
> > would that just generate an MMIO exit as usual?
> 
> My understanding is that the guest needs some way of tagging whether a
> page is expected to be shared or private. On the architectures I'm aware
> of this is done by effectively stealing a bit from the IPA space and
> pretending it's a flag bit.
> 
> So when a guest access causes a fault, the flag bit (really part of the
> intermediate physical address) is compared against whether the page is
> present in the private fd. If they correspond (i.e. a private access and
> the private fd has a page, or a shared access and there's a hole in the
> private fd) then the appropriate page is mapped and the guest continues.
> If there's a mismatch then a KVM_EXIT_MEMORY_ERROR exit is trigged and
> the VMM is expected to fix up the situation (either convert the page or
> kill the guest if this was unexpected).

x86 architectures do steal a bit, but it's not strictly required.  The guest can
communicate its desired private vs. shared state via hypercall.  I refer to the
hypercall method as explicit conversion, and reacting to a page fault due to
accessing the "wrong" PA variant as implicit conversion.

I have dreams of supporting a software-only implementation on x86, a la pKVM, if
only for testing and debug purposes.  In that case, only explicit conversion is
supported.

I'd actually prefer TDX and SNP only allow explicit conversion, i.e. let the host
treat accesses to the "wrong" PA as illegal, but sadly the guest/host ABIs for
both TDX and SNP require the host to support implicit conversions.

> >>>> The key point is that KVM never decides to convert between shared and private, it's
> >>>> always a userspace decision.  Like normal memslots, where userspace has full control
> >>>> over what gfns are a valid, this gives userspace full control over whether a gfn is
> >>>> shared or private at any given time.
> >>>
> >>> I'm understanding this as 'the VMM is allowed to punch holes in the
> >>> private fd whenever it wants'. Is this correct?
> >>
> >> From the kernel's perspective, yes, the VMM can punch holes at any time.  From a
> >> "do I want to DoS my guest" perspective, the VMM must honor its contract with the
> >> guest and not spuriously unmap private memory.
> >>
> >>> What happens if it does so for a page that a guest hasn't shared back?
> >>
> >> When the hole is punched, KVM will unmap the corresponding private SPTEs.  If the
> >> guest is still accessing the page as private, the next access will fault and KVM
> >> will exit to userspace with KVM_EXIT_MEMORY_ERROR.  Of course the guest is probably
> >> hosed if the hole punch was truly spurious, as at least hardware-based protected VMs
> >> effectively destroy data when a private page is unmapped from the guest private SPTEs.
> >>
> >> E.g. Linux guests for TDX and SNP will panic/terminate in such a scenario as they
> >> will get a fault (injected by trusted hardware/firmware) saying that the guest is
> >> trying to access an unaccepted/unvalidated page (TDX and SNP require the guest to
> >> explicit accept all private pages that aren't part of the guest's initial pre-boot
> >> image).
> > 
> > I suppose this is necessary is to prevent the VMM from re-fallocating
> > in a hole it previously punched and re-entering the guest without
> > notifying it?
> 
> I don't know specifically about TDX/SNP, but one thing we want to
> prevent with CCA is the VMM deallocating/reallocating a private page
> without the guest being aware (i.e. corrupting the guest's state).So
> punching a hole will taint the address such that a future access by the
> guest is fatal (unless the guest first jumps through the right hoops to
> acknowledge that it was expecting such a thing).

Yep, both TDX and SNP will trigger a fault in the guest if the host removes and
reinserts a private page.  The current plan for Linux guests is to track whether
or not a given page has been accepted as private, and panic/die if a fault due
to unaccepted private page occurs.
