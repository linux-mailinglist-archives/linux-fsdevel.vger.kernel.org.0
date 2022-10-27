Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C83460F528
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Oct 2022 12:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235461AbiJ0KaS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Oct 2022 06:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235493AbiJ0KaA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Oct 2022 06:30:00 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9E31EEF5
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Oct 2022 03:29:52 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id j16so1817512lfe.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Oct 2022 03:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0heoQ75/5VSlWRbzYWlqtOyoihaCk0GBJXOxfmWTOfk=;
        b=TGZ+AHB+/VCuAf8/5IZLQRevtX055y+nnz+ARUuKwQU1I4fg7fp43eeRuH2v7XFvkS
         X+Gt7cF2nNFj4HpCbNa8jW9qEUtRMt+sS17Fcf05qC4cN3kYAndhWb9LZ0eyn6IvzOxf
         UOeSAFO4W+oPeg/fJnHtuDOr3YrIC4cX/Z4LxgyBljFOwiOLrYYkl4IKn8x7WwMN1DhQ
         vFafYxM3d1UVYup5HarUqQRn5QU47KwSOnDd0hfHqSRGuVJWqjUDcO1XM/8rHi/L59+w
         VU2aUC5tKx1ZdvIV+kfKXyE5JbtXoSIREX3CedB+BO6IQKhcKT+BItyxmNDmmPiu/8QV
         lzzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0heoQ75/5VSlWRbzYWlqtOyoihaCk0GBJXOxfmWTOfk=;
        b=Xx/TeLXmd+11ACcpwz1jJM2BgOXdBVZzJDjbbDoXChd35ddyn++Oh3cT9L5ZUO94Cs
         DDFUYvBmKMHm009w+rK3rgrxOqCyTj9XSAmhPY/QJWFxMBXFGVlemneY9lRDvSwXC1eB
         QtRV05FKczgXU5cu8jsMfOlDEMyQIT7jn5auw94MJN6V1/Gy41rylkkWLp4IDg2suhFL
         X4RVbJictDRfhGodOZunfLLgHZn3a31ckk1403LSA5G0h2ezhY0fscTZBHRiFHtm3Pz8
         hA26HKvWFX4CQNnM7O2N/xqiD+pnduG54buphEw51vjbavHH8dUieNVUQZrZPUk1fqvM
         nn+g==
X-Gm-Message-State: ACrzQf1s30yicMGAh1uokdDp5GFlQEkbawV+rFYDps5CKlTebtBU0afE
        H2WtPGnSBtmVxyV2rOmZrt9Oi+SXTLBjQ7tItThcw/1Nt3mNbZSa
X-Google-Smtp-Source: AMsMyM6pXaQUclBRuQdHyU6LfjVbG2j8GF0LigG6tmbtr2FkYZjZ0nO5HPb+OzdJSXOTlsdg0oH0XtaqnFKTblieit4=
X-Received: by 2002:a05:6512:2392:b0:4a2:550a:e21d with SMTP id
 c18-20020a056512239200b004a2550ae21dmr19000831lfv.550.1666866591008; Thu, 27
 Oct 2022 03:29:51 -0700 (PDT)
MIME-Version: 1.0
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com> <20221025151344.3784230-5-chao.p.peng@linux.intel.com>
In-Reply-To: <20221025151344.3784230-5-chao.p.peng@linux.intel.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Thu, 27 Oct 2022 11:29:14 +0100
Message-ID: <CA+EHjTySnJTuLB+XoRya6kS_zw2iMahW9-Ze70oKTf+6k0GrGQ@mail.gmail.com>
Subject: Re: [PATCH v9 4/8] KVM: Use gfn instead of hva for mmu_notifier_retry
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
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
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
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

Hi,

On Tue, Oct 25, 2022 at 4:19 PM Chao Peng <chao.p.peng@linux.intel.com> wrote:
>
> Currently in mmu_notifier validate path, hva range is recorded and then
> checked against in the mmu_notifier_retry_hva() of the page fault path.
> However, for the to be introduced private memory, a page fault may not
> have a hva associated, checking gfn(gpa) makes more sense.
>
> For existing non private memory case, gfn is expected to continue to
> work. The only downside is when aliasing multiple gfns to a single hva,
> the current algorithm of checking multiple ranges could result in a much
> larger range being rejected. Such aliasing should be uncommon, so the
> impact is expected small.
>
> It also fixes a bug in kvm_zap_gfn_range() which has already been using

nit: Now it's kvm_unmap_gfn_range().

> gfn when calling kvm_mmu_invalidate_begin/end() while these functions
> accept hva in current code.
>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> ---

Based on reading this code and my limited knowledge of the x86 MMU code:
Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad


>  arch/x86/kvm/mmu/mmu.c   |  2 +-
>  include/linux/kvm_host.h | 18 +++++++---------
>  virt/kvm/kvm_main.c      | 45 ++++++++++++++++++++++++++--------------
>  3 files changed, 39 insertions(+), 26 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 6f81539061d6..33b1aec44fb8 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4217,7 +4217,7 @@ static bool is_page_fault_stale(struct kvm_vcpu *vcpu,
>                 return true;
>
>         return fault->slot &&
> -              mmu_invalidate_retry_hva(vcpu->kvm, mmu_seq, fault->hva);
> +              mmu_invalidate_retry_gfn(vcpu->kvm, mmu_seq, fault->gfn);
>  }
>
>  static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 739a7562a1f3..79e5cbc35fcf 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -775,8 +775,8 @@ struct kvm {
>         struct mmu_notifier mmu_notifier;
>         unsigned long mmu_invalidate_seq;
>         long mmu_invalidate_in_progress;
> -       unsigned long mmu_invalidate_range_start;
> -       unsigned long mmu_invalidate_range_end;
> +       gfn_t mmu_invalidate_range_start;
> +       gfn_t mmu_invalidate_range_end;
>  #endif
>         struct list_head devices;
>         u64 manual_dirty_log_protect;
> @@ -1365,10 +1365,8 @@ void kvm_mmu_free_memory_cache(struct kvm_mmu_memory_cache *mc);
>  void *kvm_mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc);
>  #endif
>
> -void kvm_mmu_invalidate_begin(struct kvm *kvm, unsigned long start,
> -                             unsigned long end);
> -void kvm_mmu_invalidate_end(struct kvm *kvm, unsigned long start,
> -                           unsigned long end);
> +void kvm_mmu_invalidate_begin(struct kvm *kvm, gfn_t start, gfn_t end);
> +void kvm_mmu_invalidate_end(struct kvm *kvm, gfn_t start, gfn_t end);
>
>  long kvm_arch_dev_ioctl(struct file *filp,
>                         unsigned int ioctl, unsigned long arg);
> @@ -1937,9 +1935,9 @@ static inline int mmu_invalidate_retry(struct kvm *kvm, unsigned long mmu_seq)
>         return 0;
>  }
>
> -static inline int mmu_invalidate_retry_hva(struct kvm *kvm,
> +static inline int mmu_invalidate_retry_gfn(struct kvm *kvm,
>                                            unsigned long mmu_seq,
> -                                          unsigned long hva)
> +                                          gfn_t gfn)
>  {
>         lockdep_assert_held(&kvm->mmu_lock);
>         /*
> @@ -1949,8 +1947,8 @@ static inline int mmu_invalidate_retry_hva(struct kvm *kvm,
>          * positives, due to shortcuts when handing concurrent invalidations.
>          */
>         if (unlikely(kvm->mmu_invalidate_in_progress) &&
> -           hva >= kvm->mmu_invalidate_range_start &&
> -           hva < kvm->mmu_invalidate_range_end)
> +           gfn >= kvm->mmu_invalidate_range_start &&
> +           gfn < kvm->mmu_invalidate_range_end)
>                 return 1;
>         if (kvm->mmu_invalidate_seq != mmu_seq)
>                 return 1;
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 8dace78a0278..09c9cdeb773c 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -540,8 +540,7 @@ static void kvm_mmu_notifier_invalidate_range(struct mmu_notifier *mn,
>
>  typedef bool (*hva_handler_t)(struct kvm *kvm, struct kvm_gfn_range *range);
>
> -typedef void (*on_lock_fn_t)(struct kvm *kvm, unsigned long start,
> -                            unsigned long end);
> +typedef void (*on_lock_fn_t)(struct kvm *kvm, gfn_t start, gfn_t end);
>
>  typedef void (*on_unlock_fn_t)(struct kvm *kvm);
>
> @@ -628,7 +627,8 @@ static __always_inline int __kvm_handle_hva_range(struct kvm *kvm,
>                                 locked = true;
>                                 KVM_MMU_LOCK(kvm);
>                                 if (!IS_KVM_NULL_FN(range->on_lock))
> -                                       range->on_lock(kvm, range->start, range->end);
> +                                       range->on_lock(kvm, gfn_range.start,
> +                                                           gfn_range.end);
>                                 if (IS_KVM_NULL_FN(range->handler))
>                                         break;
>                         }
> @@ -715,15 +715,9 @@ static void kvm_mmu_notifier_change_pte(struct mmu_notifier *mn,
>         kvm_handle_hva_range(mn, address, address + 1, pte, kvm_set_spte_gfn);
>  }
>
> -void kvm_mmu_invalidate_begin(struct kvm *kvm, unsigned long start,
> -                             unsigned long end)
> +static inline void update_invalidate_range(struct kvm *kvm, gfn_t start,
> +                                                           gfn_t end)
>  {
> -       /*
> -        * The count increase must become visible at unlock time as no
> -        * spte can be established without taking the mmu_lock and
> -        * count is also read inside the mmu_lock critical section.
> -        */
> -       kvm->mmu_invalidate_in_progress++;
>         if (likely(kvm->mmu_invalidate_in_progress == 1)) {
>                 kvm->mmu_invalidate_range_start = start;
>                 kvm->mmu_invalidate_range_end = end;
> @@ -744,6 +738,28 @@ void kvm_mmu_invalidate_begin(struct kvm *kvm, unsigned long start,
>         }
>  }
>
> +static void mark_invalidate_in_progress(struct kvm *kvm, gfn_t start, gfn_t end)
> +{
> +       /*
> +        * The count increase must become visible at unlock time as no
> +        * spte can be established without taking the mmu_lock and
> +        * count is also read inside the mmu_lock critical section.
> +        */
> +       kvm->mmu_invalidate_in_progress++;
> +}
> +
> +static bool kvm_mmu_handle_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
> +{
> +       update_invalidate_range(kvm, range->start, range->end);
> +       return kvm_unmap_gfn_range(kvm, range);
> +}
> +
> +void kvm_mmu_invalidate_begin(struct kvm *kvm, gfn_t start, gfn_t end)
> +{
> +       mark_invalidate_in_progress(kvm, start, end);
> +       update_invalidate_range(kvm, start, end);
> +}
> +
>  static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
>                                         const struct mmu_notifier_range *range)
>  {
> @@ -752,8 +768,8 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
>                 .start          = range->start,
>                 .end            = range->end,
>                 .pte            = __pte(0),
> -               .handler        = kvm_unmap_gfn_range,
> -               .on_lock        = kvm_mmu_invalidate_begin,
> +               .handler        = kvm_mmu_handle_gfn_range,
> +               .on_lock        = mark_invalidate_in_progress,
>                 .on_unlock      = kvm_arch_guest_memory_reclaimed,
>                 .flush_on_ret   = true,
>                 .may_block      = mmu_notifier_range_blockable(range),
> @@ -791,8 +807,7 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
>         return 0;
>  }
>
> -void kvm_mmu_invalidate_end(struct kvm *kvm, unsigned long start,
> -                           unsigned long end)
> +void kvm_mmu_invalidate_end(struct kvm *kvm, gfn_t start, gfn_t end)
>  {
>         /*
>          * This sequence increase will notify the kvm page fault that
> --
> 2.25.1
>
