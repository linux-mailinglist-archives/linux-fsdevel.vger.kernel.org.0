Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331844F61A5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 16:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234735AbiDFOZC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 10:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234730AbiDFOYf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:24:35 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E9A4B4B82
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Apr 2022 03:34:21 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id i27so3295189ejd.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Apr 2022 03:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iTXPlXz9Zr5EQou03o/EzBtB8wT2GGE1Oxj4KHnssrs=;
        b=ayqp+jO7yOZ05GUhmKmLMJU9illW53IQuWYj97Bq0h7OEyqmw3078v9FFmpHAsDAsX
         spKmsJURhryre2eQUlppZX9/HUMI+W6eoOizaX7iehhukxIce2QAtRFltzvot97mqi5g
         wkzLHd/GXAJerFP3q1x2xzOele+vfbjGw1VTYhqxLnyW66oK1u7wRDE72iuiN53gsanI
         rXtjHuLiferpfP6GaXR+e/2+55LTuT8kg2k0SD2i6I/8Spe3SQIHjv+mc1I1GC7cM2Bn
         lfPpqaubm9GgEOe61Moi+rdCo7ZOQ3yLidHpWgZcNsZorkDZClOB35C15vOMByW5gWia
         Ohgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iTXPlXz9Zr5EQou03o/EzBtB8wT2GGE1Oxj4KHnssrs=;
        b=H2+CsBzPE1MbpKxx/q0ZYBXzOg4rziVJLKpPCrAJkH6u7XjKDd/jOBxeEHJ4AhSU4c
         RztiyrPUxSupm7fpJCgVWsMy0UP2EV8JhI53yRlm5dCvXHIz1/2/dE13WjKUyKYntYVS
         1m8WRCJqack2x0CpXVy2an8ZevmoLrTe9vTr97S+HV0sFzMCTg/A0NrMo3bjoygQTQst
         Ag5YK50dTmZw2oeKzg1xbpBcfOcviUhCaeWKAZ2BB4MA17FB8VA8FCh/uPVBgEYE5EMr
         kO+Xl2b7ucu+hZNOx7MtmvIRk9rHmM7oS+/SzZzTXWcHiYUckbIpu+ag/Mri6kGQ0sX4
         IExw==
X-Gm-Message-State: AOAM531h5QnqKqjdRdoxFs6TvzMaEYBuBLYTl8UN9hFRi/AIzDxlWlsl
        RDPGU/u9hTGwi/Cpud65Q90XqA==
X-Google-Smtp-Source: ABdhPJx9uNXrv9QkGvgAJYDqUioNGXqvB3w7Wp/JIXcWJjl7z4UKv44fp6VMiLyGHlZ2RnmerugK6g==
X-Received: by 2002:a17:907:3f02:b0:6e7:7172:4437 with SMTP id hq2-20020a1709073f0200b006e771724437mr7358942ejc.361.1649241258989;
        Wed, 06 Apr 2022 03:34:18 -0700 (PDT)
Received: from google.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id x3-20020a50d9c3000000b0041c8ce4bcd7sm6543091edj.63.2022.04.06.03.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 03:34:18 -0700 (PDT)
Date:   Wed, 6 Apr 2022 10:34:15 +0000
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
Message-ID: <Yk1spw4zIxR73VX8@google.com>
References: <YkQzfjgTQaDd2E2T@google.com>
 <YkSaUQX89ZEojsQb@google.com>
 <80aad2f9-9612-4e87-a27a-755d3fa97c92@www.fastmail.com>
 <YkcTTY4YjQs5BRhE@google.com>
 <83fd55f8-cd42-4588-9bf6-199cbce70f33@www.fastmail.com>
 <YksIQYdG41v3KWkr@google.com>
 <Ykslo2eo2eRXrpFR@google.com>
 <eefc3c74-acca-419c-8947-726ce2458446@www.fastmail.com>
 <Ykwbqv90C7+8K+Ao@google.com>
 <YkyEaYiL0BrDYcZv@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkyEaYiL0BrDYcZv@google.com>
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

On Tuesday 05 Apr 2022 at 18:03:21 (+0000), Sean Christopherson wrote:
> On Tue, Apr 05, 2022, Quentin Perret wrote:
> > On Monday 04 Apr 2022 at 15:04:17 (-0700), Andy Lutomirski wrote:
> > > >>  - it can be very useful for protected VMs to do shared=>private
> > > >>    conversions. Think of a VM receiving some data from the host in a
> > > >>    shared buffer, and then it wants to operate on that buffer without
> > > >>    risking to leak confidential informations in a transient state. In
> > > >>    that case the most logical thing to do is to convert the buffer back
> > > >>    to private, do whatever needs to be done on that buffer (decrypting a
> > > >>    frame, ...), and then share it back with the host to consume it;
> > > >
> > > > If performance is a motivation, why would the guest want to do two
> > > > conversions instead of just doing internal memcpy() to/from a private
> > > > page?  I would be quite surprised if multiple exits and TLB shootdowns is
> > > > actually faster, especially at any kind of scale where zapping stage-2
> > > > PTEs will cause lock contention and IPIs.
> > > 
> > > I don't know the numbers or all the details, but this is arm64, which is a
> > > rather better architecture than x86 in this regard.  So maybe it's not so
> > > bad, at least in very simple cases, ignoring all implementation details.
> > > (But see below.)  Also the systems in question tend to have fewer CPUs than
> > > some of the massive x86 systems out there.
> > 
> > Yep. I can try and do some measurements if that's really necessary, but
> > I'm really convinced the cost of the TLBI for the shared->private
> > conversion is going to be significantly smaller than the cost of memcpy
> > the buffer twice in the guest for us.
> 
> It's not just the TLB shootdown, the VM-Exits aren't free.

Ack, but we can at least work on the rest (number of exits, locking, ...).
The cost of the memcpy and the TLBI are really incompressible.

> And barring non-trivial
> improvements to KVM's MMU, e.g. sharding of mmu_lock, modifying the page tables will
> block all other updates and MMU operations.  Taking mmu_lock for read, should arm64
> ever convert to a rwlock, is not an option because KVM needs to block other
> conversions to avoid races.

FWIW the host mmu_lock isn't all that useful for pKVM. The host doesn't
have _any_ control over guest page-tables, and the hypervisor can't
safely rely on the host for locking, so we have hypervisor-level
synchronization.

> Hmm, though batching multiple pages into a single request would mitigate most of
> the overhead.

Yep, there are a few tricks we can play to make this fairly efficient in
the most common cases. And fine-grain locking at EL2 is really high up
on the todo list :-)

Thanks,
Quentin
