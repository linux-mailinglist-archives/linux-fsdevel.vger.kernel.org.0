Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC064EF977
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Apr 2022 20:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350950AbiDASFQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Apr 2022 14:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243382AbiDASFP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Apr 2022 14:05:15 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E19D65D1D
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Apr 2022 11:03:22 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id x34so3836439ede.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Apr 2022 11:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lhxxWKT9SwwnWJkm39OZn7IwwCKXG3b/O/9dQouxNPo=;
        b=Lr8A3p7Ekj/xeqHFv/FPraXvj8lmfHwD95Tyh0wBLtHKMerFISovW3cP911Cv1OBMv
         LV/OgGxHqX6rFmQDgLqdILULRzc7+aWuNiPU+Sk8Vtloe5edefA/RKnzKDbH1r5KuBbZ
         kev1t4QLJXESZh3mGGAntIMgi47syaHwmLXLjV4jdlQobqziGAHtJIA2WFfzfe5cFIjV
         fqcPM0a1TZGP94MxJrnUfa3F6LyGzWdGmQaH2OoT4mLR0RmukUXT9LXwNpTFQKZVcRf/
         aIWCTNM3KQyU809xH2hE5O+R6+Ekag5oYXwycP+wVr1LXAKbwyLENB8lf5HV4rz1dgco
         C/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lhxxWKT9SwwnWJkm39OZn7IwwCKXG3b/O/9dQouxNPo=;
        b=lw188lXGo1K+lWKAyA0+bHOFjliV6JqDu+K4hJJpl4GlirI+y3zD6Kxn4wJCsN4sFB
         TdG1PdHulw4i6P3zsKggFyssQQYmgEqI+UlBi+j+BOe121IYbNWY5COwehN2r6svqVp+
         jYc9Izqmld3HZTnXZ6dENwv0x4Ja58cAQfLRRcvuRWpePQZAL11g5jAeoxl0PpLhgtj7
         FMfiLHEAbY5T3vkVUSKWuIQP9qqTsK/gW8PH73Zp8bbMYR5B+yIPsmzwILrVSvnEc5P/
         r5mGwntkXD1M5J3zpTGmAp4eutgAo7ZZwJN32Ut5lIltuUw0lUhSbQIoYHO0Ct/GtXNv
         Hr1Q==
X-Gm-Message-State: AOAM530YQ6E6gcYhl86TucENVfLmaJLejnvLSb5w7pL7m4riV25xoecA
        PyVx82CE6ofFQ3pYhKUR4DzZSA==
X-Google-Smtp-Source: ABdhPJx4lQmR1Kk59tyeYPMDHJWz6rR/i5Lub1feW38LhyW2CdsmPwtcOTrIJDFvMbum4LQjQAg6LQ==
X-Received: by 2002:a05:6402:438d:b0:419:4550:d52b with SMTP id o13-20020a056402438d00b004194550d52bmr22227721edc.83.1648836200464;
        Fri, 01 Apr 2022 11:03:20 -0700 (PDT)
Received: from google.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id w14-20020a170906d20e00b006cee22553f7sm1261239ejz.213.2022.04.01.11.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 11:03:20 -0700 (PDT)
Date:   Fri, 1 Apr 2022 18:03:16 +0000
From:   Quentin Perret <qperret@google.com>
To:     Sean Christopherson <seanjc@google.com>
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
Message-ID: <Ykc+ZNWlsXCaOrM9@google.com>
References: <YkHspg+YzOsbUaCf@google.com>
 <YkH32nx+YsJuUbmZ@google.com>
 <YkIFW25WgV2WIQHb@google.com>
 <YkM7eHCHEBe5NkNH@google.com>
 <88620519-029e-342b-0a85-ce2a20eaf41b@arm.com>
 <YkQzfjgTQaDd2E2T@google.com>
 <YkSaUQX89ZEojsQb@google.com>
 <80aad2f9-9612-4e87-a27a-755d3fa97c92@www.fastmail.com>
 <YkcTTY4YjQs5BRhE@google.com>
 <Ykcy7fj/d+f9OUl/@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ykcy7fj/d+f9OUl/@google.com>
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

On Friday 01 Apr 2022 at 17:14:21 (+0000), Sean Christopherson wrote:
> On Fri, Apr 01, 2022, Quentin Perret wrote:
> > The typical flow is as follows:
> > 
> >  - the host asks the hypervisor to run a guest;
> > 
> >  - the hypervisor does the context switch, which includes switching
> >    stage-2 page-tables;
> > 
> >  - initially the guest has an empty stage-2 (we don't require
> >    pre-faulting everything), which means it'll immediately fault;
> > 
> >  - the hypervisor switches back to host context to handle the guest
> >    fault;
> > 
> >  - the host handler finds the corresponding memslot and does the
> >    ipa->hva conversion. In our current implementation it uses a longterm
> >    GUP pin on the corresponding page;
> > 
> >  - once it has a page, the host handler issues a hypercall to donate the
> >    page to the guest;
> > 
> >  - the hypervisor does a bunch of checks to make sure the host owns the
> >    page, and if all is fine it will unmap it from the host stage-2 and
> >    map it in the guest stage-2, and do some bookkeeping as it needs to
> >    track page ownership, etc;
> > 
> >  - the guest can then proceed to run, and possibly faults in many more
> >    pages;
> > 
> >  - when it wants to, the guest can then issue a hypercall to share a
> >    page back with the host;
> > 
> >  - the hypervisor checks the request, maps the page back in the host
> >    stage-2, does more bookkeeping and returns back to the host to notify
> >    it of the share;
> > 
> >  - the host kernel at that point can exit back to userspace to relay
> >    that information to the VMM;
> > 
> >  - rinse and repeat.
> 
> I assume there is a scenario where a page can be converted from shared=>private?
> If so, is there a use case where that happens post-boot _and_ the contents of the
> page are preserved?

I think most our use-cases are private=>shared, but how is that
different?

> > We currently don't allow the host punching holes in the guest IPA space.
> 
> The hole doesn't get punched in guest IPA space, it gets punched in the private
> backing store, which is host PA space.

Hmm, in a previous message I thought that you mentioned when a whole
gets punched in the fd KVM will go and unmap the page in the private
SPTEs, which will cause a fatal error for any subsequent access from the
guest to the corresponding IPA?

If that's correct, I meant that we currently don't support that - the
host can't unmap anything from the guest stage-2, it can only tear it
down entirely. But again, I'm not too worried about that, we could
certainly implement that part without too many issues.

> > Once it has donated a page to a guest, it can't have it back until the
> > guest has been entirely torn down (at which point all of memory is
> > poisoned by the hypervisor obviously).
> 
> The guest doesn't have to know that it was handed back a different page.  It will
> require defining the semantics to state that the trusted hypervisor will clear
> that page on conversion, but IMO the trusted hypervisor should be doing that
> anyways.  IMO, forcing on the guest to correctly zero pages on conversion is
> unnecessarily risky because converting private=>shared and preserving the contents
> should be a very, very rare scenario, i.e. it's just one more thing for the guest
> to get wrong.

I'm not sure I agree. The guest is going to communicate with an
untrusted entity via that shared page, so it better be careful. Guest
hardening in general is a major topic, and of all problems, zeroing the
page before sharing is probably one of the simplest to solve.

Also, note that in pKVM all the hypervisor code at EL2 runs with
preemption disabled, which is a strict constraint. As such one of the
main goals is the spend as little time as possible in that context.
We're trying hard to keep the amount of zeroing/memcpy-ing to an
absolute minimum. And that's especially true as we introduce support for
huge pages. So, we'll take every opportunity we get to have the guest
or the host do that work.
