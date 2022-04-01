Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB3E4EF8BA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Apr 2022 19:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349767AbiDARQS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Apr 2022 13:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349587AbiDARQQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Apr 2022 13:16:16 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D73181175
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Apr 2022 10:14:26 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id e5so2989000pls.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Apr 2022 10:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TmJlBi2lOKilVyCE4rEH1RU4SqqxsckJUfBoRuoJ5iA=;
        b=XswIK2+VM16bs1EyCAixrX89EKH93ezG3dB1CWqPGTee1snfa+If/AZijfKqsxCqtT
         czAJM7L+aUj6khEGJ6GV9s++PLrO8RH4lZkcJg2KUogkm/dx0FOh6Bdu3+L9kSytbNEF
         XG0woWBUkeuEHiLxkjZVlGyLcAV8wCqkBCs5NYAogpMbDENpW1paD3SiXOo3FOHbC/BE
         WYgluaeEO6OycFsdtzk13mJ436B8Tm+WeKW9KRWPo6GkYNWY936IsCliUkUrYOsiKniH
         rexTSPppoR//hQcB3ze8glrIZD0dmsOyJ/XHIq6k4cBlE7q4ChILUSTyVJwIVcd9BGxN
         YFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TmJlBi2lOKilVyCE4rEH1RU4SqqxsckJUfBoRuoJ5iA=;
        b=PVI7EuxShnk85qpOT2B4kquWDCoNO4Np98qhftEa6S3XLqbX9/kr9+PYmeVGaJ5dow
         nkVKzC/L9n6omHI+FDW5A8Y49Vie2NvSiUZ7xcMd8JucI/9u5ijJj5UtJMZphBddz9El
         9+PdL191LEVUZziIN+/eTJkSmysLvVCGwZkBq1GnGaG+iHon2jXp6cvivh8bvuCFNcQW
         wKG2ur8nxiM+eBjZDssRJu3ttH4KO/uzNJqn1ne3ier8C6YiOT/Y0Yt1FFgO1j9MocwP
         hEiFH1Ugop5uHgKxsGl3CZBGd2UnsuNtfuzLdOXLP18E9MvISn30dNBG3qy6RguUQmT3
         +S0w==
X-Gm-Message-State: AOAM531ZG4lbj7P5iKwZkAOlmpNI/BGvfGD+Rv5eNt5VvwaFE9MTBDps
        1kNKy7ecybAwAOLbGONReVhMXw==
X-Google-Smtp-Source: ABdhPJz12AHLKCpitPA4TCd4Qr7wvOzdMzS4bQmVFvgCp7soE2Mp/gjwDqcr67uNH6+9bYjsC7+Dhg==
X-Received: by 2002:a17:902:ec8c:b0:154:2e86:dd51 with SMTP id x12-20020a170902ec8c00b001542e86dd51mr11082426plg.99.1648833265465;
        Fri, 01 Apr 2022 10:14:25 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id z5-20020a056a00240500b004e15d39f15fsm3669103pfh.83.2022.04.01.10.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 10:14:24 -0700 (PDT)
Date:   Fri, 1 Apr 2022 17:14:21 +0000
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
Message-ID: <Ykcy7fj/d+f9OUl/@google.com>
References: <YjyS6A0o4JASQK+B@google.com>
 <YkHspg+YzOsbUaCf@google.com>
 <YkH32nx+YsJuUbmZ@google.com>
 <YkIFW25WgV2WIQHb@google.com>
 <YkM7eHCHEBe5NkNH@google.com>
 <88620519-029e-342b-0a85-ce2a20eaf41b@arm.com>
 <YkQzfjgTQaDd2E2T@google.com>
 <YkSaUQX89ZEojsQb@google.com>
 <80aad2f9-9612-4e87-a27a-755d3fa97c92@www.fastmail.com>
 <YkcTTY4YjQs5BRhE@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkcTTY4YjQs5BRhE@google.com>
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
> The typical flow is as follows:
> 
>  - the host asks the hypervisor to run a guest;
> 
>  - the hypervisor does the context switch, which includes switching
>    stage-2 page-tables;
> 
>  - initially the guest has an empty stage-2 (we don't require
>    pre-faulting everything), which means it'll immediately fault;
> 
>  - the hypervisor switches back to host context to handle the guest
>    fault;
> 
>  - the host handler finds the corresponding memslot and does the
>    ipa->hva conversion. In our current implementation it uses a longterm
>    GUP pin on the corresponding page;
> 
>  - once it has a page, the host handler issues a hypercall to donate the
>    page to the guest;
> 
>  - the hypervisor does a bunch of checks to make sure the host owns the
>    page, and if all is fine it will unmap it from the host stage-2 and
>    map it in the guest stage-2, and do some bookkeeping as it needs to
>    track page ownership, etc;
> 
>  - the guest can then proceed to run, and possibly faults in many more
>    pages;
> 
>  - when it wants to, the guest can then issue a hypercall to share a
>    page back with the host;
> 
>  - the hypervisor checks the request, maps the page back in the host
>    stage-2, does more bookkeeping and returns back to the host to notify
>    it of the share;
> 
>  - the host kernel at that point can exit back to userspace to relay
>    that information to the VMM;
> 
>  - rinse and repeat.

I assume there is a scenario where a page can be converted from shared=>private?
If so, is there a use case where that happens post-boot _and_ the contents of the
page are preserved?

> We currently don't allow the host punching holes in the guest IPA space.

The hole doesn't get punched in guest IPA space, it gets punched in the private
backing store, which is host PA space.

> Once it has donated a page to a guest, it can't have it back until the
> guest has been entirely torn down (at which point all of memory is
> poisoned by the hypervisor obviously).

The guest doesn't have to know that it was handed back a different page.  It will
require defining the semantics to state that the trusted hypervisor will clear
that page on conversion, but IMO the trusted hypervisor should be doing that
anyways.  IMO, forcing on the guest to correctly zero pages on conversion is
unnecessarily risky because converting private=>shared and preserving the contents
should be a very, very rare scenario, i.e. it's just one more thing for the guest
to get wrong.

If there is a use case where the page contents need to be preserved, then that can
and should be an explicit request from the guest, and can be handled through
export/import style functions.  Export/import would be slow-ish due to memcpy(),
which is why I asked if there's a need to do this specific action frequently (or
at all).
