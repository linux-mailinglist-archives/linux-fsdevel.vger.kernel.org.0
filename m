Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC54510929
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 21:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354272AbiDZThU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 15:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236078AbiDZThQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 15:37:16 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2320D1A1771
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Apr 2022 12:34:06 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n126-20020a1c2784000000b0038e8af3e788so2212679wmn.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Apr 2022 12:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HdglKt24ulKLWyX0LsILT516ozly9pUWvxRymOVkqGI=;
        b=D9ihhOYCzfSq6PHe75gU3OheUI3W9iH7N3JyrClUp6au/zHYy/RjIQ+jFjvmiw3I9o
         uU7o/2RsJb0OvTjqDki2JlEYfTgugeTS76dPfA3259nEGmWh42vCXrHa6/5V7/2johUN
         +QaWhuSllkcd3/yIwhHQc0dL4v+1u2xt3a0+X1HNRFS3ddbQntWN7TwV79pXNZP4tjWY
         q9oDYLmA6GmRpsibkQ3SJm8PJsmjU0ySPtDfndPYlEEAFXG22uifNwS/0VoF2zqchWyZ
         YeBZmMfcWMAOzmPfGY/zoiJYCO20nTusS/8yz+ffjxEMcUZ2DMbLY7V/1myPVVFJC4B1
         X+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HdglKt24ulKLWyX0LsILT516ozly9pUWvxRymOVkqGI=;
        b=vCAc4Cfr168KScWNh9e6sFCvM7V2eyTnsTg/bBKrde7YzNcxrTD9fGDMilmUHANjDc
         uLd7QEowh0DBEp/4zVnIZr8/n0yyCNwCzOeK24GeGBa6kJnGTqcccC6LXrS6bhQDfP78
         k5cQYfpQKQQffIrEvhAAe/jTLyhmm7qQVkyx51a27uKXg5Gy1uofeByarasTCx5L/Cn2
         GMbszAKpsnQsWA3sv1Kla67HNd8bDl7j772zPf0uhdHr7uWrCoZ7rHW9tMm3bFU90bDT
         AWQGWW7mVfsl2IXF/Ua2I0hjnGNRNVhtyzyN+g2Wxru9aCNYwK4C8mQEtqCNBtT8T5n2
         G/IQ==
X-Gm-Message-State: AOAM5320SUgRFLrbtGp8LbB3Zc8PaRvhrQrRUZqa1yQjDvAU+ipGWevu
        SDonm8T3EkyNZWCqV97cePuWfI0MTRyDA806/AnWvg==
X-Google-Smtp-Source: ABdhPJxfcXYYWDf1qEw77YopXVh9hGlDN3ohweZv6hh7qehoXVg7JxTIKYy8mWq0Lcp0jdkpbGhhqEQXGML1k1dn1J0=
X-Received: by 2002:a05:600c:4e46:b0:393:f5fb:b3df with SMTP id
 e6-20020a05600c4e4600b00393f5fbb3dfmr4865915wmq.80.1651001644438; Tue, 26 Apr
 2022 12:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220426053904.3684293-1-yosryahmed@google.com>
 <20220426053904.3684293-5-yosryahmed@google.com> <874k2falbk.wl-maz@kernel.org>
In-Reply-To: <874k2falbk.wl-maz@kernel.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 26 Apr 2022 12:33:28 -0700
Message-ID: <CAJD7tkZ-mrhCXoR0ZONjJ7kuAuzWED8Dcjkw6mv812-3uSo_Cg@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] KVM: arm64/mmu: count KVM page table pages in
 pagetable stats
To:     Marc Zyngier <maz@kernel.org>
Cc:     Sean Christopherson <seanjc@google.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks a lot for taking the time to look at this!

On Tue, Apr 26, 2022 at 8:58 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Tue, 26 Apr 2022 06:39:02 +0100,
> Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > Count the pages used by KVM in arm64 for page tables in pagetable stats.
> >
> > Account pages allocated for PTEs in pgtable init functions and
> > kvm_set_table_pte().
> >
> > Since most page table pages are freed using put_page(), add a helper
> > function put_pte_page() that checks if this is the last ref for a pte
> > page before putting it, and unaccounts stats accordingly.
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
> >  arch/arm64/kernel/image-vars.h |  3 ++
> >  arch/arm64/kvm/hyp/pgtable.c   | 50 +++++++++++++++++++++-------------
> >  2 files changed, 34 insertions(+), 19 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
> > index 241c86b67d01..25bf058714f6 100644
> > --- a/arch/arm64/kernel/image-vars.h
> > +++ b/arch/arm64/kernel/image-vars.h
> > @@ -143,6 +143,9 @@ KVM_NVHE_ALIAS(__hyp_rodata_end);
> >  /* pKVM static key */
> >  KVM_NVHE_ALIAS(kvm_protected_mode_initialized);
> >
> > +/* Called by kvm_account_pgtable_pages() to update pagetable stats */
> > +KVM_NVHE_ALIAS(__mod_lruvec_page_state);
>
> This cannot be right. It means that this function will be called
> directly from the EL2 code when in protected mode, and will result in
> extreme fireworks.  There is no way you can call core kernel stuff
> like this from this context.
>
> Please do not add random symbols to this list just for the sake of
> being able to link the kernel.

Excuse my ignorance, this is my first time touching kvm code. Thanks a
lot for pointing this out.

>
> > +
> >  #endif /* CONFIG_KVM */
> >
> >  #endif /* __ARM64_KERNEL_IMAGE_VARS_H */
> > diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> > index 2cb3867eb7c2..53e13c3313e9 100644
> > --- a/arch/arm64/kvm/hyp/pgtable.c
> > +++ b/arch/arm64/kvm/hyp/pgtable.c
> > @@ -152,6 +152,7 @@ static void kvm_set_table_pte(kvm_pte_t *ptep, kvm_pte_t *childp,
> >
> >       WARN_ON(kvm_pte_valid(old));
> >       smp_store_release(ptep, pte);
> > +     kvm_account_pgtable_pages((void *)childp, +1);
>
> Why the + sign?

I am following conventions in other existing stat accounting hooks
(e.g. kvm_mod_used_mmu_pages(vcpu->kvm, +1) call in
arch/x86/kvm/mmu/mmu.c), but I can certainly remove it if you think
this is better.

>
> >  }
> >
> >  static kvm_pte_t kvm_init_valid_leaf_pte(u64 pa, kvm_pte_t attr, u32 level)
> > @@ -326,6 +327,14 @@ int kvm_pgtable_get_leaf(struct kvm_pgtable *pgt, u64 addr,
> >       return ret;
> >  }
> >
> > +static void put_pte_page(kvm_pte_t *ptep, struct kvm_pgtable_mm_ops *mm_ops)
> > +{
> > +     /* If this is the last page ref, decrement pagetable stats first. */
> > +     if (!mm_ops->page_count || mm_ops->page_count(ptep) == 1)
> > +             kvm_account_pgtable_pages((void *)ptep, -1);
> > +     mm_ops->put_page(ptep);
> > +}
> > +
> >  struct hyp_map_data {
> >       u64                             phys;
> >       kvm_pte_t                       attr;
> > @@ -488,10 +497,10 @@ static int hyp_unmap_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
> >
> >       dsb(ish);
> >       isb();
> > -     mm_ops->put_page(ptep);
> > +     put_pte_page(ptep, mm_ops);
> >
> >       if (childp)
> > -             mm_ops->put_page(childp);
> > +             put_pte_page(childp, mm_ops);
> >
> >       return 0;
> >  }
> > @@ -522,6 +531,7 @@ int kvm_pgtable_hyp_init(struct kvm_pgtable *pgt, u32 va_bits,
> >       pgt->pgd = (kvm_pte_t *)mm_ops->zalloc_page(NULL);
> >       if (!pgt->pgd)
> >               return -ENOMEM;
> > +     kvm_account_pgtable_pages((void *)pgt->pgd, +1);
> >
> >       pgt->ia_bits            = va_bits;
> >       pgt->start_level        = KVM_PGTABLE_MAX_LEVELS - levels;
> > @@ -541,10 +551,10 @@ static int hyp_free_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
> >       if (!kvm_pte_valid(pte))
> >               return 0;
> >
> > -     mm_ops->put_page(ptep);
> > +     put_pte_page(ptep, mm_ops);
> >
> >       if (kvm_pte_table(pte, level))
> > -             mm_ops->put_page(kvm_pte_follow(pte, mm_ops));
> > +             put_pte_page(kvm_pte_follow(pte, mm_ops), mm_ops);
>
> OK, I see the pattern. I don't think this workable as such. I'd rather
> the callbacks themselves (put_page, zalloc_page*) call into the
> accounting code when it makes sense, rather than spreading the
> complexity and having to special case the protected case.
>

This makes sense. I am working on moving calls to
kvm_account_pgtable_pages to callbacks in mmu.c in the next version
(stage2_memcache_zalloc_page, kvm_host_put_page, etc).


> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
