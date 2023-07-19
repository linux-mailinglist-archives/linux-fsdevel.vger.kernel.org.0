Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D598759C21
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 19:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjGSRNM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 13:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjGSRNH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 13:13:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3A31FD5
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 10:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689786739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S9AsII7CY5MJTEaTaOHNT9YNASCGL4WKC7qHJSnopZQ=;
        b=Y77E94ZDeDOxBKZmMXM+UKpj+fgQ3BlQkZHQkntIaTRpKXh0+lm0vJ3jrTGHX/PLjw1hq0
        sbRNQdswKOVIQcEA8Az+uC111UOs22xJeVz99BhYQJaOsTIrVjkf4cWT0PIFHejJEd+2+q
        Ye8tHaaMVaH2VksLJnsb2Nnvw3k8z/M=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-HWlHYmm_MQeFpicw_jStfw-1; Wed, 19 Jul 2023 13:12:17 -0400
X-MC-Unique: HWlHYmm_MQeFpicw_jStfw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-993d7ca4607so369144866b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 10:12:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689786736; x=1692378736;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S9AsII7CY5MJTEaTaOHNT9YNASCGL4WKC7qHJSnopZQ=;
        b=Bdpz42b2S2n2n9KZKD1FpUo1dP4tzsG0QA1f0pWrOw0qd8f1N0/i8YZI1Qlj1B3Q+k
         2HNnNfKftka8JAtJzF3/wMAYQuEBa8A3WJsr4B2i4LVbe0+8qyUouhifWCRy7P7bow2J
         09qU4z4ulxkXHa1nIpLhrALdAnJGd+XAaUd33xPnb7BgN0FK166edNFmLWwCv2UVPVAk
         j8IsJacYYWYbx2PxQDPLND3L31r9hzkghXDezCZMdxoX3klos6sZ9lUkkpxPcvJJ0uOZ
         6cIZVs5WP1lMv1tVPlCZLhoElA6OWnifcKnFXERrSpQYRmc3DHo/3J8i/MLc7v0AXKfu
         T5lw==
X-Gm-Message-State: ABy/qLapukHWnLsR76JjDAMu2GF2FVSGQi2QqKPgRBY7sxqAui4O5/DI
        T8r7tGQ54CDAuzWgf74Z7Ne4EDZZn5jXf1Mw91L3sF31MTRkmjd2lDc1XA/dYJeFOigyQKrc7zN
        3Vg+yRJhZqr4BVpToifboxxzb9Q==
X-Received: by 2002:a17:907:78c7:b0:993:336d:bc0c with SMTP id kv7-20020a17090778c700b00993336dbc0cmr3348308ejc.34.1689786736183;
        Wed, 19 Jul 2023 10:12:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEWH5lpXrWw3fibEqRX+XISeWU/0ydBla5bYBnTwaBnN76X92VTCl72XthCydwwSYBUr3ZDqg==
X-Received: by 2002:a17:907:78c7:b0:993:336d:bc0c with SMTP id kv7-20020a17090778c700b00993336dbc0cmr3348255ejc.34.1689786735792;
        Wed, 19 Jul 2023 10:12:15 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id i16-20020a17090685d000b0099251942e1esm2561055ejy.119.2023.07.19.10.12.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 10:12:15 -0700 (PDT)
Message-ID: <fedb8c9b-c28b-fe97-aa98-f8189067cb5a@redhat.com>
Date:   Wed, 19 Jul 2023 19:12:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH v11 03/29] KVM: Use gfn instead of hva for
 mmu_notifier_retry
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Marc Zyngier <maz@kernel.org>,
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
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20230718234512.1690985-1-seanjc@google.com>
 <20230718234512.1690985-4-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230718234512.1690985-4-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/19/23 01:44, Sean Christopherson wrote:
> From: Chao Peng<chao.p.peng@linux.intel.com>
> 
> Currently in mmu_notifier invalidate path, hva range is recorded and
> then checked against by mmu_notifier_retry_hva() in the page fault
> handling path. However, for the to be introduced private memory, a page
> fault may not have a hva associated, checking gfn(gpa) makes more sense.
> 
> For existing hva based shared memory, gfn is expected to also work. The
> only downside is when aliasing multiple gfns to a single hva, the
> current algorithm of checking multiple ranges could result in a much
> larger range being rejected. Such aliasing should be uncommon, so the
> impact is expected small.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

> Suggested-by: Sean Christopherson<seanjc@google.com>
> Signed-off-by: Chao Peng<chao.p.peng@linux.intel.com>
> Reviewed-by: Fuad Tabba<tabba@google.com>
> Tested-by: Fuad Tabba<tabba@google.com>
> [sean: convert vmx_set_apic_access_page_addr() to gfn-based API]
> Signed-off-by: Sean Christopherson<seanjc@google.com>
> ---
>   arch/x86/kvm/mmu/mmu.c   | 10 ++++++----
>   arch/x86/kvm/vmx/vmx.c   | 11 +++++------
>   include/linux/kvm_host.h | 33 +++++++++++++++++++++------------
>   virt/kvm/kvm_main.c      | 40 +++++++++++++++++++++++++++++++---------
>   4 files changed, 63 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index d72f2b20f430..b034727c4cf9 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -3087,7 +3087,7 @@ static void direct_pte_prefetch(struct kvm_vcpu *vcpu, u64 *sptep)
>    *
>    * There are several ways to safely use this helper:
>    *
> - * - Check mmu_invalidate_retry_hva() after grabbing the mapping level, before
> + * - Check mmu_invalidate_retry_gfn() after grabbing the mapping level, before
>    *   consuming it.  In this case, mmu_lock doesn't need to be held during the
>    *   lookup, but it does need to be held while checking the MMU notifier.
>    *
> @@ -4400,7 +4400,7 @@ static bool is_page_fault_stale(struct kvm_vcpu *vcpu,
>   		return true;
>   
>   	return fault->slot &&
> -	       mmu_invalidate_retry_hva(vcpu->kvm, fault->mmu_seq, fault->hva);
> +	       mmu_invalidate_retry_gfn(vcpu->kvm, fault->mmu_seq, fault->gfn);
>   }
>   
>   static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
> @@ -6301,7 +6301,9 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
>   
>   	write_lock(&kvm->mmu_lock);
>   
> -	kvm_mmu_invalidate_begin(kvm, 0, -1ul);
> +	kvm_mmu_invalidate_begin(kvm);
> +
> +	kvm_mmu_invalidate_range_add(kvm, gfn_start, gfn_end);
>   
>   	flush = kvm_rmap_zap_gfn_range(kvm, gfn_start, gfn_end);
>   
> @@ -6314,7 +6316,7 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
>   	if (flush)
>   		kvm_flush_remote_tlbs_range(kvm, gfn_start, gfn_end - gfn_start);
>   
> -	kvm_mmu_invalidate_end(kvm, 0, -1ul);
> +	kvm_mmu_invalidate_end(kvm);
>   
>   	write_unlock(&kvm->mmu_lock);
>   }
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 0ecf4be2c6af..946380b53cf5 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6729,10 +6729,10 @@ static void vmx_set_apic_access_page_addr(struct kvm_vcpu *vcpu)
>   		return;
>   
>   	/*
> -	 * Grab the memslot so that the hva lookup for the mmu_notifier retry
> -	 * is guaranteed to use the same memslot as the pfn lookup, i.e. rely
> -	 * on the pfn lookup's validation of the memslot to ensure a valid hva
> -	 * is used for the retry check.
> +	 * Explicitly grab the memslot using KVM's internal slot ID to ensure
> +	 * KVM doesn't unintentionally grab a userspace memslot.  It_should_
> +	 * be impossible for userspace to create a memslot for the APIC when
> +	 * APICv is enabled, but paranoia won't hurt in this case.
>   	 */
>   	slot = id_to_memslot(slots, APIC_ACCESS_PAGE_PRIVATE_MEMSLOT);
>   	if (!slot || slot->flags & KVM_MEMSLOT_INVALID)
> @@ -6757,8 +6757,7 @@ static void vmx_set_apic_access_page_addr(struct kvm_vcpu *vcpu)
>   		return;
>   
>   	read_lock(&vcpu->kvm->mmu_lock);
> -	if (mmu_invalidate_retry_hva(kvm, mmu_seq,
> -				     gfn_to_hva_memslot(slot, gfn))) {
> +	if (mmu_invalidate_retry_gfn(kvm, mmu_seq, gfn)) {
>   		kvm_make_request(KVM_REQ_APIC_PAGE_RELOAD, vcpu);
>   		read_unlock(&vcpu->kvm->mmu_lock);
>   		goto out;
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index b901571ab61e..90a0be261a5c 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -788,8 +788,8 @@ struct kvm {
>   	struct mmu_notifier mmu_notifier;
>   	unsigned long mmu_invalidate_seq;
>   	long mmu_invalidate_in_progress;
> -	unsigned long mmu_invalidate_range_start;
> -	unsigned long mmu_invalidate_range_end;
> +	gfn_t mmu_invalidate_range_start;
> +	gfn_t mmu_invalidate_range_end;
>   #endif
>   	struct list_head devices;
>   	u64 manual_dirty_log_protect;
> @@ -1371,10 +1371,9 @@ void kvm_mmu_free_memory_cache(struct kvm_mmu_memory_cache *mc);
>   void *kvm_mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc);
>   #endif
>   
> -void kvm_mmu_invalidate_begin(struct kvm *kvm, unsigned long start,
> -			      unsigned long end);
> -void kvm_mmu_invalidate_end(struct kvm *kvm, unsigned long start,
> -			    unsigned long end);
> +void kvm_mmu_invalidate_begin(struct kvm *kvm);
> +void kvm_mmu_invalidate_range_add(struct kvm *kvm, gfn_t start, gfn_t end);
> +void kvm_mmu_invalidate_end(struct kvm *kvm);
>   
>   long kvm_arch_dev_ioctl(struct file *filp,
>   			unsigned int ioctl, unsigned long arg);
> @@ -1940,9 +1939,9 @@ static inline int mmu_invalidate_retry(struct kvm *kvm, unsigned long mmu_seq)
>   	return 0;
>   }
>   
> -static inline int mmu_invalidate_retry_hva(struct kvm *kvm,
> +static inline int mmu_invalidate_retry_gfn(struct kvm *kvm,
>   					   unsigned long mmu_seq,
> -					   unsigned long hva)
> +					   gfn_t gfn)
>   {
>   	lockdep_assert_held(&kvm->mmu_lock);
>   	/*
> @@ -1951,10 +1950,20 @@ static inline int mmu_invalidate_retry_hva(struct kvm *kvm,
>   	 * that might be being invalidated. Note that it may include some false
>   	 * positives, due to shortcuts when handing concurrent invalidations.
>   	 */
> -	if (unlikely(kvm->mmu_invalidate_in_progress) &&
> -	    hva >= kvm->mmu_invalidate_range_start &&
> -	    hva < kvm->mmu_invalidate_range_end)
> -		return 1;
> +	if (unlikely(kvm->mmu_invalidate_in_progress)) {
> +		/*
> +		 * Dropping mmu_lock after bumping mmu_invalidate_in_progress
> +		 * but before updating the range is a KVM bug.
> +		 */
> +		if (WARN_ON_ONCE(kvm->mmu_invalidate_range_start == INVALID_GPA ||
> +				 kvm->mmu_invalidate_range_end == INVALID_GPA))
> +			return 1;
> +
> +		if (gfn >= kvm->mmu_invalidate_range_start &&
> +		    gfn < kvm->mmu_invalidate_range_end)
> +			return 1;
> +	}
> +
>   	if (kvm->mmu_invalidate_seq != mmu_seq)
>   		return 1;
>   	return 0;
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 50aea855eeae..8101b11a13ba 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -518,9 +518,7 @@ static inline struct kvm *mmu_notifier_to_kvm(struct mmu_notifier *mn)
>   
>   typedef bool (*gfn_handler_t)(struct kvm *kvm, struct kvm_gfn_range *range);
>   
> -typedef void (*on_lock_fn_t)(struct kvm *kvm, unsigned long start,
> -			     unsigned long end);
> -
> +typedef void (*on_lock_fn_t)(struct kvm *kvm);
>   typedef void (*on_unlock_fn_t)(struct kvm *kvm);
>   
>   struct kvm_mmu_notifier_range {
> @@ -617,7 +615,8 @@ static __always_inline int __kvm_handle_hva_range(struct kvm *kvm,
>   				locked = true;
>   				KVM_MMU_LOCK(kvm);
>   				if (!IS_KVM_NULL_FN(range->on_lock))
> -					range->on_lock(kvm, range->start, range->end);
> +					range->on_lock(kvm);
> +
>   				if (IS_KVM_NULL_FN(range->handler))
>   					break;
>   			}
> @@ -721,15 +720,26 @@ static void kvm_mmu_notifier_change_pte(struct mmu_notifier *mn,
>   	kvm_handle_hva_range(mn, address, address + 1, pte, kvm_change_spte_gfn);
>   }
>   
> -void kvm_mmu_invalidate_begin(struct kvm *kvm, unsigned long start,
> -			      unsigned long end)
> +void kvm_mmu_invalidate_begin(struct kvm *kvm)
>   {
> +	lockdep_assert_held_write(&kvm->mmu_lock);
>   	/*
>   	 * The count increase must become visible at unlock time as no
>   	 * spte can be established without taking the mmu_lock and
>   	 * count is also read inside the mmu_lock critical section.
>   	 */
>   	kvm->mmu_invalidate_in_progress++;
> +
> +	if (likely(kvm->mmu_invalidate_in_progress == 1))
> +		kvm->mmu_invalidate_range_start = INVALID_GPA;
> +}
> +
> +void kvm_mmu_invalidate_range_add(struct kvm *kvm, gfn_t start, gfn_t end)
> +{
> +	lockdep_assert_held_write(&kvm->mmu_lock);
> +
> +	WARN_ON_ONCE(!kvm->mmu_invalidate_in_progress);
> +
>   	if (likely(kvm->mmu_invalidate_in_progress == 1)) {
>   		kvm->mmu_invalidate_range_start = start;
>   		kvm->mmu_invalidate_range_end = end;
> @@ -750,6 +760,12 @@ void kvm_mmu_invalidate_begin(struct kvm *kvm, unsigned long start,
>   	}
>   }
>   
> +static bool kvm_mmu_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
> +{
> +	kvm_mmu_invalidate_range_add(kvm, range->start, range->end);
> +	return kvm_unmap_gfn_range(kvm, range);
> +}
> +

