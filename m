Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFBF66A6BD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jan 2023 00:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjAMXNE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 18:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjAMXNB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 18:13:01 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93C855649
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 15:12:57 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id z1-20020a17090a66c100b00226f05b9595so10761402pjl.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 15:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6waHfzu6QNTCtARyXVkB2oMyhcfo5fqUC0ATnnKkPnY=;
        b=O6XguqMafTRXvQv85ExvdAnE49HZTKXNFy9YUORXoBYzBNDK6XxQRaxRUTp2T45YDl
         3057gy8m4GrFJCc2FQRiuh4Zzt1/f66sG6btraeyAsnFb0jqUB9L7Qp/1BLfYoDWl9TF
         2JGj2sT8EblX2TZhDTIrHiTnNxD1O+mjmH7F4f7CLLFU69qeBNeLiHjFcmmeWLXdBGi1
         3m8EiWwX/R6p+t3mmfsBVw7CK5LPwwYoq8U9dXBEUV0ZyihLamO8d75F7khta35ohnxc
         k9IFwWLfQtmsUuUdwAJda5eFdqvHErSHGZVXbDonZUE2GJ8vDBMz7n2syh4S6ddDsffQ
         QzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6waHfzu6QNTCtARyXVkB2oMyhcfo5fqUC0ATnnKkPnY=;
        b=zDJxvqjIgKg34efACMv1EgkmUqbiv9OgQual31aiOq2FUI5nhuNIM0Hck8dCnF7MMj
         HecGK9WbLv/T3tzCxIDHUTtLtbB60uwdDljGYWj7vCz9QmV9fxJV1S+OFV2x2vPAFkx1
         d+Vrb9AYdNh2Qwm4Mqby7OzezQyld4KC/n0U7KiiOBARVI7p9HGDoZpkcErcNvdGUZio
         5g+VXstSL3Yy0e3ndQ4fv2apSIPtX1JMi6I0g5sVaeStO8AzwriZVq9zauxK4EkVlVmv
         bMx/Yot6XWwGAuYvwmKcvioUGva+ndkKkv5R67U47ars/Psv/bzkEfGKaNKQbMKYI8ak
         Hn9w==
X-Gm-Message-State: AFqh2krq4Rej9qml0riGLZqs9Yz00ucP/ZYo2u9VSZt4/QM9lgZ1WK9t
        u9/PgPpJzbHENJj182xP904kaQ==
X-Google-Smtp-Source: AMrXdXvPFhd+n6NDrxL3+OIQGw+e3rO4vrbsluJ2hKSdpRPcy2J3J1PbafFWRHVEyKRqjQvuzoJZkg==
X-Received: by 2002:a17:90b:274b:b0:219:f970:5119 with SMTP id qi11-20020a17090b274b00b00219f9705119mr1466515pjb.1.1673651577254;
        Fri, 13 Jan 2023 15:12:57 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id d12-20020a634f0c000000b0047829d1b8eesm9819354pgb.31.2023.01.13.15.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 15:12:56 -0800 (PST)
Date:   Fri, 13 Jan 2023 23:12:53 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
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
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        wei.w.wang@intel.com
Subject: Re: [PATCH v10 7/9] KVM: Update lpage info when private/shared
 memory are mixed
Message-ID: <Y8HldeHBrw+OOZVm@google.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-8-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202061347.1070246-8-chao.p.peng@linux.intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 02, 2022, Chao Peng wrote:
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 283cbb83d6ae..7772ab37ac89 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -38,6 +38,7 @@
>  #include <asm/hyperv-tlfs.h>
>  
>  #define __KVM_HAVE_ARCH_VCPU_DEBUGFS
> +#define __KVM_HAVE_ARCH_SET_MEMORY_ATTRIBUTES

No need for this, I think we should just make it mandatory to implement the
arch hook when CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES=y.  If another arch gains
support for mem attributes and doesn't need the hook, then we can simply add a
weak helper (or maybe add a #define then if we feel that's the way to go).

>  #define KVM_MAX_VCPUS 1024
>  
> @@ -1011,6 +1012,13 @@ struct kvm_vcpu_arch {
>  #endif
>  };
>  
> +/*
> + * Use a bit in disallow_lpage to indicate private/shared pages mixed at the
> + * level. The remaining bits are used as a reference count.
> + */
> +#define KVM_LPAGE_PRIVATE_SHARED_MIXED		(1U << 31)

Similar to the need to unmap, I think we should just say "mixed" and ignore the
private vs. shared, i.e. make this a flag for all memory attributes.

> +#define KVM_LPAGE_COUNT_MAX			((1U << 31) - 1)

"MAX" is technically correct, but it's more of a mask.  I think we can make it a
moot point though.  There's no need to mask the count, we just want to assert that
adjusting the counting doesn't change the flag.

I would also say throw these defines into mmu.c, at least pending the bug fix
for kvm_alloc_memslot_metadata() (more on that below).

>  struct kvm_lpage_info {
>  	int disallow_lpage;
>  };
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index e2c70b5afa3e..2190fd8c95c0 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -763,11 +763,16 @@ static void update_gfn_disallow_lpage_count(const struct kvm_memory_slot *slot,
>  {
>  	struct kvm_lpage_info *linfo;
>  	int i;
> +	int disallow_count;
>  
>  	for (i = PG_LEVEL_2M; i <= KVM_MAX_HUGEPAGE_LEVEL; ++i) {
>  		linfo = lpage_info_slot(gfn, slot, i);
> +
> +		disallow_count = linfo->disallow_lpage & KVM_LPAGE_COUNT_MAX;
> +		WARN_ON(disallow_count + count < 0 ||
> +			disallow_count > KVM_LPAGE_COUNT_MAX - count);
> +
>  		linfo->disallow_lpage += count;
> -		WARN_ON(linfo->disallow_lpage < 0);

It's been a long week so don't trust my math, but I believe this can simply be:

		old = linfo->disallow_lpage;
		linfo->disallow_lpage += count;

		WARN_ON_ONCE((old ^ linfo->disallow_lpage) & KVM_LPAGE_MIXED_FLAG);
>  	}
>  }
>  
> @@ -6986,3 +6991,130 @@ void kvm_mmu_pre_destroy_vm(struct kvm *kvm)
>  	if (kvm->arch.nx_huge_page_recovery_thread)
>  		kthread_stop(kvm->arch.nx_huge_page_recovery_thread);
>  }
> +
> +static bool linfo_is_mixed(struct kvm_lpage_info *linfo)
> +{
> +	return linfo->disallow_lpage & KVM_LPAGE_PRIVATE_SHARED_MIXED;
> +}
> +
> +static void linfo_set_mixed(gfn_t gfn, struct kvm_memory_slot *slot,
> +			    int level, bool mixed)
> +{
> +	struct kvm_lpage_info *linfo = lpage_info_slot(gfn, slot, level);
> +
> +	if (mixed)
> +		linfo->disallow_lpage |= KVM_LPAGE_PRIVATE_SHARED_MIXED;
> +	else
> +		linfo->disallow_lpage &= ~KVM_LPAGE_PRIVATE_SHARED_MIXED;
> +}
> +
> +static bool is_expected_attr_entry(void *entry, unsigned long expected_attrs)
> +{
> +	bool expect_private = expected_attrs & KVM_MEMORY_ATTRIBUTE_PRIVATE;
> +
> +	if (xa_to_value(entry) & KVM_MEMORY_ATTRIBUTE_PRIVATE) {
> +		if (!expect_private)
> +			return false;
> +	} else if (expect_private)
> +		return false;

This is messy.  If we drop the private vs. shared specifity, this can go away if
we add a helper to get attributes

	static inline unsigned long kvm_get_memory_attributes(struct kvm *kvm, gfn_t gfn)
	{
		return xa_to_value(xa_load(&kvm->mem_attr_array, gfn));
	}

and then we can do


		if (KVM_BUG_ON(gfn != xas.xa_index, kvm) ||
		    attrs != kvm_get_memory_attributes(kvm, gfn)) {
			mixed = true;
			break;
		}

and

		if (linfo_is_mixed(lpage_info_slot(gfn, slot, level - 1)) ||
		    attrs != kvm_get_memory_attributes(kvm, gfn))
			return true;


> +
> +	return true;
> +}
> +
> +static bool mem_attrs_mixed_2m(struct kvm *kvm, unsigned long attrs,
> +			       gfn_t start, gfn_t end)
> +{
> +	XA_STATE(xas, &kvm->mem_attr_array, start);
> +	gfn_t gfn = start;
> +	void *entry;
> +	bool mixed = false;
> +
> +	rcu_read_lock();
> +	entry = xas_load(&xas);
> +	while (gfn < end) {
> +		if (xas_retry(&xas, entry))
> +			continue;
> +
> +		KVM_BUG_ON(gfn != xas.xa_index, kvm);

As above, I think it's worth bailing immediately if there's a mismatch.

> +
> +		if (!is_expected_attr_entry(entry, attrs)) {
> +			mixed = true;
> +			break;
> +		}
> +
> +		entry = xas_next(&xas);
> +		gfn++;
> +	}
> +
> +	rcu_read_unlock();
> +	return mixed;
> +}
> +
> +static bool mem_attrs_mixed(struct kvm *kvm, struct kvm_memory_slot *slot,

s/mem_attrs_mixed/has_mixed_attrs to make it clear this is querying, not setting.
And has_mixed_attrs_2m() above.

> +			    int level, unsigned long attrs,
> +			    gfn_t start, gfn_t end)
> +{
> +	unsigned long gfn;
> +
> +	if (level == PG_LEVEL_2M)
> +		return mem_attrs_mixed_2m(kvm, attrs, start, end);
> +
> +	for (gfn = start; gfn < end; gfn += KVM_PAGES_PER_HPAGE(level - 1))

Curly braces needed on the for-loop.

> +		if (linfo_is_mixed(lpage_info_slot(gfn, slot, level - 1)) ||
> +		    !is_expected_attr_entry(xa_load(&kvm->mem_attr_array, gfn),
> +					    attrs))
> +			return true;
> +	return false;
> +}
> +
> +static void kvm_update_lpage_private_shared_mixed(struct kvm *kvm,
> +						  struct kvm_memory_slot *slot,
> +						  unsigned long attrs,
> +						  gfn_t start, gfn_t end)
> +{
> +	unsigned long pages, mask;
> +	gfn_t gfn, gfn_end, first, last;
> +	int level;
> +	bool mixed;
> +
> +	/*
> +	 * The sequence matters here: we set the higher level basing on the
> +	 * lower level's scanning result.
> +	 */
> +	for (level = PG_LEVEL_2M; level <= KVM_MAX_HUGEPAGE_LEVEL; level++) {
> +		pages = KVM_PAGES_PER_HPAGE(level);
> +		mask = ~(pages - 1);
> +		first = start & mask;
> +		last = (end - 1) & mask;
> +
> +		/*
> +		 * We only need to scan the head and tail page, for middle pages
> +		 * we know they will not be mixed.
> +		 */
> +		gfn = max(first, slot->base_gfn);
> +		gfn_end = min(first + pages, slot->base_gfn + slot->npages);
> +		mixed = mem_attrs_mixed(kvm, slot, level, attrs, gfn, gfn_end);
> +		linfo_set_mixed(gfn, slot, level, mixed);
> +
> +		if (first == last)
> +			return;
> +
> +		for (gfn = first + pages; gfn < last; gfn += pages)
> +			linfo_set_mixed(gfn, slot, level, false);
> +
> +		gfn = last;
> +		gfn_end = min(last + pages, slot->base_gfn + slot->npages);
> +		mixed = mem_attrs_mixed(kvm, slot, level, attrs, gfn, gfn_end);
> +		linfo_set_mixed(gfn, slot, level, mixed);
> +	}
> +}
> +
> +void kvm_arch_set_memory_attributes(struct kvm *kvm,
> +				    struct kvm_memory_slot *slot,
> +				    unsigned long attrs,
> +				    gfn_t start, gfn_t end)
> +{
> +	if (kvm_slot_can_be_private(slot))

Make this an early return optimization, with a comment explaining that KVM x86
doesn't yet support other attributes.

	/*
	 * KVM x86 currently only supports KVM_MEMORY_ATTRIBUTE_PRIVATE, skip
	 * the slot if the slot will never consume the PRIVATE attribute.
	 */
	if (!kvm_slot_can_be_private(slot))
		return;


> +		kvm_update_lpage_private_shared_mixed(kvm, slot, attrs,
> +						      start, end);
> +}
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 9a07380f8d3c..5aefcff614d2 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -12362,6 +12362,8 @@ static int kvm_alloc_memslot_metadata(struct kvm *kvm,
>  		if ((slot->base_gfn + npages) & (KVM_PAGES_PER_HPAGE(level) - 1))
>  			linfo[lpages - 1].disallow_lpage = 1;
>  		ugfn = slot->userspace_addr >> PAGE_SHIFT;
> +		if (kvm_slot_can_be_private(slot))
> +			ugfn |= slot->restricted_offset >> PAGE_SHIFT;

I would rather reject memslot if the gfn has lesser alignment than the offset.
I'm totally ok with this approach _if_ there's a use case.  Until such a use case
presents itself, I would rather be conservative from a uAPI perspective.

>  		/*
>  		 * If the gfn and userspace address are not aligned wrt each
>  		 * other, disable large page support for this slot.
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 3331c0c92838..25099c94e770 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -592,6 +592,11 @@ struct kvm_memory_slot {
>  	struct restrictedmem_notifier notifier;
>  };
>  
> +static inline bool kvm_slot_can_be_private(const struct kvm_memory_slot *slot)
> +{
> +	return slot && (slot->flags & KVM_MEM_PRIVATE);

KVM_MEM_PRIVATE should really be defined only when private memory is exposed to
userspace.  For this patch, even though it means we have untestable code, I think
it makes sense to "return false".

> +}
> +
>  static inline bool kvm_slot_dirty_track_enabled(const struct kvm_memory_slot *slot)
>  {
>  	return slot->flags & KVM_MEM_LOG_DIRTY_PAGES;
> @@ -2316,4 +2321,18 @@ static inline void kvm_account_pgtable_pages(void *virt, int nr)
>  /* Max number of entries allowed for each kvm dirty ring */
>  #define  KVM_DIRTY_RING_MAX_ENTRIES  65536
>  
> +#ifdef __KVM_HAVE_ARCH_SET_MEMORY_ATTRIBUTES
> +void kvm_arch_set_memory_attributes(struct kvm *kvm,
> +				    struct kvm_memory_slot *slot,
> +				    unsigned long attrs,
> +				    gfn_t start, gfn_t end);
> +#else
> +static inline void kvm_arch_set_memory_attributes(struct kvm *kvm,
> +						  struct kvm_memory_slot *slot,
> +						  unsigned long attrs,
> +						  gfn_t start, gfn_t end)
> +{
> +}
> +#endif /* __KVM_HAVE_ARCH_SET_MEMORY_ATTRIBUTES */

As above, no stub is necessary.

>  #endif
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 4e1e1e113bf0..e107afea32f0 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2354,7 +2354,8 @@ static u64 kvm_supported_mem_attributes(struct kvm *kvm)
>  	return 0;
>  }
>  
> -static void kvm_unmap_mem_range(struct kvm *kvm, gfn_t start, gfn_t end)

Feedback for an earlier patch (to avoid churn): this should be kvm_mem_attrs_changed()
or so now that this does more than just unmap.

> +static void kvm_unmap_mem_range(struct kvm *kvm, gfn_t start, gfn_t end,
> +				unsigned long attrs)

Weird nit.  I think we should keep the prototypes for kvm_mem_attrs_changed()
and kvm_arch_set_memory_attributes() somewhat similar, i.e. squeeze in @attrs
before @start.

>  {
>  	struct kvm_gfn_range gfn_range;
>  	struct kvm_memory_slot *slot;
> @@ -2378,6 +2379,10 @@ static void kvm_unmap_mem_range(struct kvm *kvm, gfn_t start, gfn_t end)
>  			gfn_range.slot = slot;
>  
>  			r |= kvm_unmap_gfn_range(kvm, &gfn_range);
> +
> +			kvm_arch_set_memory_attributes(kvm, slot, attrs,
> +						       gfn_range.start,
> +						       gfn_range.end);
>  		}
>  	}
>  
> @@ -2427,7 +2432,7 @@ static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
>  		idx = srcu_read_lock(&kvm->srcu);
>  		KVM_MMU_LOCK(kvm);
>  		if (i > start)
> -			kvm_unmap_mem_range(kvm, start, i);
> +			kvm_unmap_mem_range(kvm, start, i, attrs->attributes);
>  		kvm_mmu_invalidate_end(kvm);
>  		KVM_MMU_UNLOCK(kvm);
>  		srcu_read_unlock(&kvm->srcu, idx);
> -- 
> 2.25.1
> 
