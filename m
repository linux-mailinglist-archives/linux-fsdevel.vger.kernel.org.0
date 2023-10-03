Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708A17B6DAA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 17:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240149AbjJCP7h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 11:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbjJCP7g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:59:36 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080B0D3
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Oct 2023 08:59:30 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d814634fe4bso1294139276.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Oct 2023 08:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696348769; x=1696953569; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xP89tk8jeFUDqiHwgtcyinENLLmFDFAo+sp2wFgmRBw=;
        b=3VHfewwIV0zOljG/ol2pjU+0vBAWkOLQRPOSIDg5brqaS+50EHIiCl+ps7d84LasCC
         jz7EfaUe1TP4lksfzPRXjmqvTy2qhmWi6rE0bUp0X2soN22L9f7Tpzv33HVo7nNh1DpK
         xVGLumlTXW1AIwOdhs8KaR033H4JRtK7qJDnzZJbOZVOAIuVgRgMfBtgHnv9p3YdnuwS
         poxsb3AIswlAkEV08xxGKdQ+PCQ4u8RqOWnx7mo22z94u7AEoRP+Ocm9CDkjVMbyosWx
         CaUYYlWPcDj5t6s+bBhCEmtwG+DQmiZ1F93IWvadR9nnbUGaPS4AG69AHcpqDEFwXAXk
         PMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696348769; x=1696953569;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xP89tk8jeFUDqiHwgtcyinENLLmFDFAo+sp2wFgmRBw=;
        b=sKb7XUYMMau1EesDpt0ReEI1WAVsikm6TN7Wnk9XvRgtAkrbwKAcLIijTjn+QoNnWI
         kuYvmkqFvCe3oSNY6mRCbQ2D61Up46qI4hCrvA7sgqFyK+BUhlWRBT/sFwRMYPGCUJov
         wOKbHN0YQaE5nEdNkyMt+WYJbcKaQ/AdWCRyYxrFe43U9xOi1SVao0cc4Jl71JPm5IJW
         l74ZhVuRAwhSodEIva82SW88lYoObA9CrGu9KfEpXCVoZ37x5ZmGePJQklwbjjEWn5Zh
         p9j/0fgXSqmxKrbX3UoKs3zyqixUPSMNrQTNELMA9eOdbCH+Lq2AfVjoDnUkN1upcdDV
         Z36w==
X-Gm-Message-State: AOJu0YyzT2CdE0gouTPkSsBqmng+Vx6Act7vEeDQniYfdQsbJ5vl4a6o
        pB2yZAmAFEReI6XKGDE5KvUKbnmUME4=
X-Google-Smtp-Source: AGHT+IHlsTPxnmIroL8cntBugIBpa7VGBcPZjKPldlj/dItcEWdxSvIkKSkj76hPSiTFqWvviFkle9Hc81s=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:3604:0:b0:d7a:c85c:725b with SMTP id
 d4-20020a253604000000b00d7ac85c725bmr227114yba.7.1696348768967; Tue, 03 Oct
 2023 08:59:28 -0700 (PDT)
Date:   Tue, 3 Oct 2023 08:59:27 -0700
In-Reply-To: <CA+EHjTzSUXx8P9gWmUERg4owxH6r6yNPm1_RL-BzS_2CNPtRKw@mail.gmail.com>
Mime-Version: 1.0
References: <20230914015531.1419405-1-seanjc@google.com> <20230914015531.1419405-12-seanjc@google.com>
 <CA+EHjTzSUXx8P9gWmUERg4owxH6r6yNPm1_RL-BzS_2CNPtRKw@mail.gmail.com>
Message-ID: <ZRw6X2BptZnRPNK7@google.com>
Subject: Re: [RFC PATCH v12 11/33] KVM: Introduce per-page memory attributes
From:   Sean Christopherson <seanjc@google.com>
To:     Fuad Tabba <tabba@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Anish Moorthy <amoorthy@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 03, 2023, Fuad Tabba wrote:
> Hi,
> 
> > diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> > index d2d913acf0df..f8642ff2eb9d 100644
> > --- a/include/uapi/linux/kvm.h
> > +++ b/include/uapi/linux/kvm.h
> > @@ -1227,6 +1227,7 @@ struct kvm_ppc_resize_hpt {
> >  #define KVM_CAP_ARM_EAGER_SPLIT_CHUNK_SIZE 228
> >  #define KVM_CAP_ARM_SUPPORTED_BLOCK_SIZES 229
> >  #define KVM_CAP_USER_MEMORY2 230
> > +#define KVM_CAP_MEMORY_ATTRIBUTES 231
> >
> >  #ifdef KVM_CAP_IRQ_ROUTING
> >
> > @@ -2293,4 +2294,17 @@ struct kvm_s390_zpci_op {
> >  /* flags for kvm_s390_zpci_op->u.reg_aen.flags */
> >  #define KVM_S390_ZPCIOP_REGAEN_HOST    (1 << 0)
> >
> > +/* Available with KVM_CAP_MEMORY_ATTRIBUTES */
> > +#define KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES    _IOR(KVMIO,  0xd2, __u64)
> > +#define KVM_SET_MEMORY_ATTRIBUTES              _IOW(KVMIO,  0xd3, struct kvm_memory_attributes)
> > +
> > +struct kvm_memory_attributes {
> > +       __u64 address;
> > +       __u64 size;
> > +       __u64 attributes;
> > +       __u64 flags;
> > +};
> > +
> > +#define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
> > +
> 
> In pKVM, we don't want to allow setting (or clearing) of PRIVATE/SHARED
> attributes from userspace.

Why not?  The whole thing falls apart if userspace doesn't *know* the state of a
page, and the only way for userspace to know the state of a page at a given moment
in time is if userspace controls the attributes.  E.g. even if KVM were to provide
a way for userspace to query attributes, the attributes exposed to usrspace would
become stale the instant KVM drops slots_lock (or whatever lock protects the attributes)
since userspace couldn't prevent future changes.

Why does pKVM need to prevent userspace from stating *its* view of attributes?

If the goal is to reduce memory overhead, that can be solved by using an internal,
non-ABI attributes flag to track pKVM's view of SHARED vs. PRIVATE.  If the guest
attempts to access memory where pKVM and userspace don't agree on the state,
generate an exit to userspace.  Or kill the guest.  Or do something else entirely.

> However, we'd like to use the attributes xarray to track the sharing state of
> guest pages at the host kernel.
> 
> Moreover, we'd rather the default guest page state be PRIVATE, and
> only specify which pages are shared. All pKVM guest pages start off as
> private, and the majority will remain so.

I would rather optimize kvm_vm_set_mem_attributes() to generate range-based
xarray entries, at which point it shouldn't matter all that much whether PRIVATE
or SHARED is the default "empty" state.  We opted not to do that for the initial
merge purely to keep the code as simple as possible (which is obviously still not
exactly simple).

With range-based xarray entries, the cost of tagging huge chunks of memory as
PRIVATE should be a non-issue.  And if that's not enough for whatever reason, I
would rather define the polarity of PRIVATE on a per-VM basis, but only for internal
storage.
 
> I'm not sure if this is the best way to do this: One idea would be to move
> the definition of KVM_MEMORY_ATTRIBUTE_PRIVATE to
> arch/*/include/asm/kvm_host.h, which is where kvm_arch_supported_attributes()
> lives as well. This would allow different architectures to specify their own
> attributes (i.e., instead we'd have a KVM_MEMORY_ATTRIBUTE_SHARED for pKVM).
> This wouldn't help in terms of preventing userspace from clearing attributes
> (i.e., setting a 0 attribute) though.
> 
> The other thing, which we need for pKVM anyway, is to make
> kvm_vm_set_mem_attributes() global, so that it can be called from outside of
> kvm_main.c (already have a local patch for this that declares it in
> kvm_host.h),

That's no problem, but I am definitely opposed to KVM modifying attributes that
are owned by userspace.

> and not gate this function by KVM_GENERIC_MEMORY_ATTRIBUTES.

As above, I am opposed to pKVM having a completely different ABI for managing
PRIVATE vs. SHARED.  I have no objection to pKVM using unclaimed flags in the
attributes to store extra metadata, but if KVM_SET_MEMORY_ATTRIBUTES doesn't work
for pKVM, then we've failed miserably and should revist the uAPI.
