Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6751C4ECB2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 19:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349574AbiC3SAf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 14:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349589AbiC3SAe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 14:00:34 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA92EEF0B0
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Mar 2022 10:58:47 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id w7so16805762pfu.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Mar 2022 10:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qRdDzcsR6tHaU83Zu+AB6iaBkt7tf4uVxesheVO+k04=;
        b=fmINK1FWWmoLOoYP7UthQGhftrRGdNFBc+IlK+NV5/Ok9ERGA+qLeK6Qc2wTVLtgAA
         9LQ/i0EUSMCyjEaFKyIhIb7cMmbwQz9Y8BcfXLRuoN6ajRH59AuxXHA3EMGdoKl2VTSg
         p24YHpEbjdk+uT0CBOdjzzYlBeDTZ3F7gpj4hM7l1TBMoGnLiRy7iLYUHQWybuBMUn3o
         +79Dbrk0SFPljaZd36P/MkFhRRizQhSn53CNrK2P1EbC2v9I9Kv5K+rfi43xESLumhbH
         68CiFZAIDCb11Ijcxh9K1W3GQjeukR3sJTsN4+zlgHn1NYrxdXEcaVCJINP6zp/PmCKt
         vRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qRdDzcsR6tHaU83Zu+AB6iaBkt7tf4uVxesheVO+k04=;
        b=pp2T9AWiKChR6Vidi/LjpeuC5ofNcDAWhYB80PqefC96eGBC3Bs0fjGuJDUNqImrmH
         HEfwEOApucGqHP+L1fKf6oM2GUHmzG7U+C7TsmV5OlR9bThe7ZMfU5UtwX4ml3+n2HUo
         92ralIbrcC8kScRNh56+IfQcAU5QeuN9OSBud94JBIsJcY5Q6saXC0ZFKK2EUrZWXx8H
         u0RuM4jRCp2KwT4Gj2WWuKxfqaGktc4uYTRvARm8ZQSRDKrwRdyUzUkCKWe3/1RpVmBL
         wqN4YeTL1RFFhaV9cR3RSoxa3gUZenXlGrz9CaK05Y6Q12MUeTajttnJpy8QbDPwPSzI
         y4KA==
X-Gm-Message-State: AOAM5308l7dSh6aGUwKD4DOnneRU5VUuc+glBszh51WMgglaI7oTX3/4
        ob2f0IZ9z7jZyBMqScNk3RKVDg==
X-Google-Smtp-Source: ABdhPJw5RZDHzkmYWQnqaCR/pP7fkWu0K1pHE0zmJg/ZBWnJ2OplQYKLUcCZisuEeybmIa1wsGUd6g==
X-Received: by 2002:a65:674b:0:b0:381:6565:26fc with SMTP id c11-20020a65674b000000b00381656526fcmr7064146pgu.618.1648663126803;
        Wed, 30 Mar 2022 10:58:46 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090a8b0300b001c735089cc2sm6710778pjn.54.2022.03.30.10.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 10:58:45 -0700 (PDT)
Date:   Wed, 30 Mar 2022 17:58:41 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Quentin Perret <qperret@google.com>
Cc:     Steven Price <steven.price@arm.com>,
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
Message-ID: <YkSaUQX89ZEojsQb@google.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <YjyS6A0o4JASQK+B@google.com>
 <YkHspg+YzOsbUaCf@google.com>
 <YkH32nx+YsJuUbmZ@google.com>
 <YkIFW25WgV2WIQHb@google.com>
 <YkM7eHCHEBe5NkNH@google.com>
 <88620519-029e-342b-0a85-ce2a20eaf41b@arm.com>
 <YkQzfjgTQaDd2E2T@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkQzfjgTQaDd2E2T@google.com>
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

On Wed, Mar 30, 2022, Quentin Perret wrote:
> On Wednesday 30 Mar 2022 at 09:58:27 (+0100), Steven Price wrote:
> > On 29/03/2022 18:01, Quentin Perret wrote:
> > > Is implicit sharing a thing? E.g., if a guest makes a memory access in
> > > the shared gpa range at an address that doesn't have a backing memslot,
> > > will KVM check whether there is a corresponding private memslot at the
> > > right offset with a hole punched and report a KVM_EXIT_MEMORY_ERROR? Or
> > > would that just generate an MMIO exit as usual?
> > 
> > My understanding is that the guest needs some way of tagging whether a
> > page is expected to be shared or private. On the architectures I'm aware
> > of this is done by effectively stealing a bit from the IPA space and
> > pretending it's a flag bit.
> 
> Right, and that is in fact the main point of divergence we have I think.
> While I understand this might be necessary for TDX and the likes, this
> makes little sense for pKVM. This would effectively embed into the IPA a
> purely software-defined non-architectural property/protocol although we
> don't actually need to: we (pKVM) can reasonably expect the guest to
> explicitly issue hypercalls to share pages in-place. So I'd be really
> keen to avoid baking in assumptions about that model too deep in the
> host mm bits if at all possible.

There is no assumption about stealing PA bits baked into this API.  Even within
x86 KVM, I consider it a hard requirement that the common flows not assume the
private vs. shared information is communicated through the PA.

> > > I'm overall inclined to think that while this abstraction works nicely
> > > for TDX and the likes, it might not suit pKVM all that well in the
> > > current form, but it's close.
> > > 
> > > What do you think of extending the model proposed here to also address
> > > the needs of implementations that support in-place sharing? One option
> > > would be to have KVM notify the private-fd backing store when a page is
> > > shared back by a guest, which would then allow host userspace to mmap
> > > that particular page in the private fd instead of punching a hole.
> > > 
> > > This should retain the main property you're after: private pages that
> > > are actually mapped in the guest SPTE aren't mmap-able, but all the
> > > others are fair game.
> > > 
> > > Thoughts?
> > How do you propose this works if the page shared by the guest then needs
> > to be made private again? If there's no hole punched then it's not
> > possible to just repopulate the private-fd. I'm struggling to see how
> > that could work.
> 
> Yes, some discussion might be required, but I was thinking about
> something along those lines:
> 
>  - a guest requests a shared->private page conversion;
> 
>  - the conversion request is routed all the way back to the VMM;
> 
>  - the VMM is expected to either decline the conversion (which may be
>    fatal for the guest if it can't handle this), or to tear-down its
>    mappings (via munmap()) of the shared page, and accept the
>    conversion;
> 
>  - upon return from the VMM, KVM will be expected to check how many
>    references to the shared page are still held (probably by asking the
>    fd backing store) to check that userspace has indeed torn down its
>    mappings. If all is fine, KVM will instruct the hypervisor to
>    repopulate the private range of the guest, otherwise it'll return an
>    error to the VMM;
> 
>  - if the conversion has been successful, the guest can resume its
>    execution normally.
> 
> Note: this should still allow to use the hole-punching method just fine
> on systems that require it. The invariant here is just that KVM (with
> help from the backing store) is now responsible for refusing to
> instruct the hypervisor (or TDX module, or RMM, or whatever) to map a
> private page if there are existing mappings to it.
> 
> > Having said that; if we can work out a way to safely
> > mmap() pages from the private-fd there's definitely some benefits to be
> > had - e.g. it could be used to populate the initial memory before the
> > guest is started.
> 
> Right, so assuming the approach proposed above isn't entirely bogus,
> this might now become possible by having the VMM mmap the private-fd,
> load the payload, and then unmap it all, and only then instruct the
> hypervisor to use this as private memory.

Hard "no" on mapping the private-fd.  Having the invariant tha the private-fd
can never be mapped greatly simplifies the responsibilities of the backing store,
as well as the interface between the private-fd and the in-kernel consumers of the
memory (KVM in this case).

What is the use case for shared->private conversion?  x86, both TDX and SNP,
effectively do have a flavor of shared->private conversion; SNP can definitely
be in-place, and I think TDX too.  But the only use case in x86 is to populate
the initial guest image, and due to other performance bottlenecks, it's strongly
recommended to keep the initial image as small as possible.  Based on your previous
response about the guest firmware loading the full guest image, my understanding is
that pKVM will also utilize a minimal initial image.

As a result, true in-place conversion to reduce the number of memcpy()s is low
priority, i.e. not planned at this time.  Unless the use case expects to convert
large swaths of memory, the simplest approach would be to have pKVM memcpy() between
the private and shared backing pages during conversion.

In-place conversion that preserves data needs to be a separate and/or additional
hypercall, because "I want to map this page as private/shared" is very, very different
than "I want to map this page as private/shared and consume/expose non-zero data".
I.e. the host is guaranteed to get an explicit request to do the memcpy(), so there
shouldn't be a need to implicitly allow this on any conversion.
