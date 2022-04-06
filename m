Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F004F63B3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 17:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236440AbiDFPs1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 11:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236934AbiDFPry (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:47:54 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A2B263677
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Apr 2022 06:05:24 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id b24so2516260edu.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Apr 2022 06:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PM54LwgT2Mgw5AMkSV1qMvIZs90k76HVAm+mIhFW/Ko=;
        b=dDSmSxNu4cKou0wKKJy2RxvoXv2oI6xKR2vY3pb3rpGtbFJSq+v9Sour4amtkG8OmK
         /mIlDVEuFioJxUYt/uLZELUgdXQw0ov1GNV1lrpYe6lLXJddt79EqvJAQITLd3WaNVH7
         RZkDvqmMSe65o+jVNmIxDSjYRyulxd4z4O6RUWbk8rC6zzIUeWQYB0okxXTU0SvhHXZA
         FOlx5xH2zFxCf3OE8/9JHhuxHDnwAY1LJRZbWwasq6aNf43sSQc+pAeLfaWwXG6joBqH
         7NUBr0fvlYsspSPTWRfWfZ9QRS8Vfkb6O9IoizmZOkjDfsVP23+M9cveQTa0tzHjUgJl
         d64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PM54LwgT2Mgw5AMkSV1qMvIZs90k76HVAm+mIhFW/Ko=;
        b=BpYZeyog1oMGmAamLlaHLVlhXoWcwSkm9Dg6WBuvLkTekwEBAqCYfmIfUBDFPJQmve
         36OGPM4UmseXtUmQ89LznsJcRgzn3gFxobzdrnPlE9YTUMyYZ+LHfa1L0f8ojK4238x+
         GpsUg4rfl4hLqbGettZOC4By8Oh8rBrDsSzPbONyeSkPvt90/VRadLafzeyGxzgOUApB
         80TC5x2Ha8o0PfEJ6OfzqdXmZ1DnG/uBslf8wXKAfHPHJxw8p0ZzA7+6s1XKiCsVMrsd
         pfJ4GQ634qJknSZwObLm/ngLSq6+mIXe8dHqJVwxT9f3WubPJqpob6fTju3MrF2XupLB
         qYIQ==
X-Gm-Message-State: AOAM530qFnbhHKhOuoiTS2luw6/xlN5+i3BMX2MtDUjMpx8AkkIinpJ1
        L1EjqZIBaT2IM7OmtEKpzMRlJsqV04DzCW/T
X-Google-Smtp-Source: ABdhPJyAEVGuwpVr2eJbNmM3Bn7rwdqn15Yyq6WvWvI8cuWdHW0Fh3+ITY+ecK+a12QzHGzVyv/MtQ==
X-Received: by 2002:a05:6402:34cf:b0:419:75b1:99ad with SMTP id w15-20020a05640234cf00b0041975b199admr8672622edc.228.1649250322915;
        Wed, 06 Apr 2022 06:05:22 -0700 (PDT)
Received: from google.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id j22-20020a50ed16000000b00419366b2146sm8158326eds.43.2022.04.06.06.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 06:05:22 -0700 (PDT)
Date:   Wed, 6 Apr 2022 13:05:18 +0000
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
Message-ID: <Yk2QDmvKR2ipsA29@google.com>
References: <YkQzfjgTQaDd2E2T@google.com>
 <YkSaUQX89ZEojsQb@google.com>
 <80aad2f9-9612-4e87-a27a-755d3fa97c92@www.fastmail.com>
 <YkcTTY4YjQs5BRhE@google.com>
 <83fd55f8-cd42-4588-9bf6-199cbce70f33@www.fastmail.com>
 <YksIQYdG41v3KWkr@google.com>
 <Ykslo2eo2eRXrpFR@google.com>
 <eefc3c74-acca-419c-8947-726ce2458446@www.fastmail.com>
 <Ykwbqv90C7+8K+Ao@google.com>
 <54acbba9-f4fd-48c1-9028-d596d9f63069@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54acbba9-f4fd-48c1-9028-d596d9f63069@www.fastmail.com>
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

On Tuesday 05 Apr 2022 at 10:51:36 (-0700), Andy Lutomirski wrote:
> Let's try actually counting syscalls and mode transitions, at least approximately.  For non-direct IO (DMA allocation on guest side, not straight to/from pagecache or similar):
> 
> Guest writes to shared DMA buffer.  Assume the guest is smart and reuses the buffer.
> Guest writes descriptor to shared virtio ring.
> Guest rings virtio doorbell, which causes an exit.
> *** guest -> hypervisor -> host ***
> host reads virtio ring (mmaped shared memory)
> host does pread() to read the DMA buffer or reads mmapped buffer
> host does the IO
> resume guest
> *** host -> hypervisor -> guest ***
> 
> This is essentially optimal in terms of transitions.  The data is copied on the guest side (which may well be mandatory depending on what guest userspace did to initiate the IO) and on the host (which may well be mandatory depending on what the host is doing with the data).
> 
> Now let's try straight-from-guest-pagecache or otherwise zero-copy on the guest side.  Without nondestructive changes, the guest needs a bounce buffer and it looks just like the above.  One extra copy, zero extra mode transitions.  With nondestructive changes, it's a bit more like physical hardware with an IOMMU:
> 
> Guest shares the page.
> *** guest -> hypervisor ***
> Hypervisor adds a PTE.  Let's assume we're being very optimal and the host is not synchronously notified.
> *** hypervisor -> guest ***
> Guest writes descriptor to shared virtio ring.
> Guest rings virtio doorbell, which causes an exit.
> *** guest -> hypervisor -> host ***
> host reads virtio ring (mmaped shared memory)
> 
> mmap  *** syscall ***
> host does the IO
> munmap *** syscall, TLBI ***
> 
> resume guest
> *** host -> hypervisor -> guest ***
> Guest unshares the page.
> *** guest -> hypervisor ***
> Hypervisor removes PTE.  TLBI.
> *** hypervisor -> guest ***
> 
> This is quite expensive.  For small IO, pread() or splice() in the host may be a lot faster.  Even for large IO, splice() may still win.

Right, that would work nicely for pages that are shared transiently, but
less so for long-term shares. But I guess your proposal below should do
the trick.

> I can imagine clever improvements.  First, let's get rid of mmap() + munmap().  Instead use a special device mapping with special semantics, not regular memory.  (mmap and munmap are expensive even ignoring any arch and TLB stuff.)  The rule is that, if the page is shared, access works, and if private, access doesn't, but it's still mapped.  The hypervisor and the host cooperate to make it so.

As long as the page can't be GUP'd I _think_ this shouldn't be a
problem. We can have the hypervisor re-inject the fault in the host. And
the host fault handler will deal with it just fine if the fault was
taken from userspace (inject a SEGV), or from the kernel through uaccess
macros. But we do get into issues if the host kernel can be tricked into
accessing the page via e.g. kmap(). I've been able to trigger this by
strace-ing a userspace process which passes a pointer to private memory
to a syscall. strace will inspect the syscall argument using
process_vm_readv(), which will pin_user_pages_remote() and access the
page via kmap(), and then we're in trouble. But preventing GUP would
prevent this by construction I think?

FWIW memfd_secret() did look like a good solution to this, but it lacks
the bidirectional notifiers with KVM that is offered by this patch
series, which is needed to allow KVM to handle guest faults, and also
offers a good framework to support future extensions (e.g.
hypervisor-assisted page migration, swap, ...). So yes, ideally
pKVM would use a kind of hybrid between memfd_secret and the private fd
proposed here, or something else providing similar properties.

Thanks,
Quentin
