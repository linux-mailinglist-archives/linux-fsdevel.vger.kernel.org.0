Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1214D620FE4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Nov 2022 13:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbiKHMIc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Nov 2022 07:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbiKHMIS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Nov 2022 07:08:18 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C0223EBD;
        Tue,  8 Nov 2022 04:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667909297; x=1699445297;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=caRUr7sQcj7Z1erPIwFwOEGdgx5trQeO2xkwYKL7cBE=;
  b=JOrJ6Vb3qj+WF9pSsgQeXhN3E1tgAGk0kBmiI5JE6k0OaAwhNt2GRcXr
   ro6BPGBkiLQJY97mWmXAqsrq5kEImF0P3xwYw8mminmR4cgM44KtZyalw
   CEzBVszSDcz717sSgr8jBMuR/65mvK4slg6uS1nK/+E8KM7Vio92CqUw1
   L3jW/jY3GJgMeTmxaODAIGMbGn6mIPH1Jnp7ofD31zMupFr07NqznxYUN
   Qbddz1QBESpofaryH22/f4zuUQiGJ1nbAfm9mDgaDm5legnEVcjua2D54
   8PbUXt08W+M3KfIXJs4G7CM8rETU8xMIHpXYbGKQLlUrOQDlntl56+gfG
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="309386690"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="309386690"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 04:08:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="667566067"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="667566067"
Received: from yy-desk-7060.sh.intel.com (HELO localhost) ([10.239.159.76])
  by orsmga008.jf.intel.com with ESMTP; 08 Nov 2022 04:08:06 -0800
Date:   Tue, 8 Nov 2022 20:08:05 +0800
From:   Yuan Yao <yuan.yao@linux.intel.com>
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
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Subject: Re: [PATCH v9 6/8] KVM: Update lpage info when private/shared memory
 are mixed
Message-ID: <20221108120805.kize74qgzsmarze5@yy-desk-7060>
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <20221025151344.3784230-7-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025151344.3784230-7-chao.p.peng@linux.intel.com>
User-Agent: NeoMutt/20171215
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 25, 2022 at 11:13:42PM +0800, Chao Peng wrote:
> When private/shared memory are mixed in a large page, the lpage_info may
> not be accurate and should be updated with this mixed info. A large page
> has mixed pages can't be really mapped as large page since its
> private/shared pages are from different physical memory.
>
> Update lpage_info when private/shared memory attribute is changed. If
> both private and shared pages are within a large page region, it can't
> be mapped as large page. It's a bit challenge to track the mixed
> info in a 'count' like variable, this patch instead reserves a bit in
> 'disallow_lpage' to indicate a large page has mixed private/share pages.
>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> ---
>  arch/x86/include/asm/kvm_host.h |   8 +++
>  arch/x86/kvm/mmu/mmu.c          | 112 +++++++++++++++++++++++++++++++-
>  arch/x86/kvm/x86.c              |   2 +
>  include/linux/kvm_host.h        |  19 ++++++
>  virt/kvm/kvm_main.c             |  16 +++--
>  5 files changed, 152 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 7551b6f9c31c..db811a54e3fd 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -37,6 +37,7 @@
>  #include <asm/hyperv-tlfs.h>
>
>  #define __KVM_HAVE_ARCH_VCPU_DEBUGFS
> +#define __KVM_HAVE_ARCH_UPDATE_MEM_ATTR
>
>  #define KVM_MAX_VCPUS 1024
>
> @@ -952,6 +953,13 @@ struct kvm_vcpu_arch {
>  #endif
>  };
>
> +/*
> + * Use a bit in disallow_lpage to indicate private/shared pages mixed at the
> + * level. The remaining bits are used as a reference count.
> + */
> +#define KVM_LPAGE_PRIVATE_SHARED_MIXED		(1U << 31)
> +#define KVM_LPAGE_COUNT_MAX			((1U << 31) - 1)
> +
>  struct kvm_lpage_info {
>  	int disallow_lpage;
>  };
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 33b1aec44fb8..67a9823a8c35 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -762,11 +762,16 @@ static void update_gfn_disallow_lpage_count(const struct kvm_memory_slot *slot,
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
>  	}
>  }
>
> @@ -6910,3 +6915,108 @@ void kvm_mmu_pre_destroy_vm(struct kvm *kvm)
>  	if (kvm->arch.nx_lpage_recovery_thread)
>  		kthread_stop(kvm->arch.nx_lpage_recovery_thread);
>  }
> +
> +static inline bool linfo_is_mixed(struct kvm_lpage_info *linfo)
> +{
> +	return linfo->disallow_lpage & KVM_LPAGE_PRIVATE_SHARED_MIXED;
> +}
> +
> +static inline void linfo_update_mixed(struct kvm_lpage_info *linfo, bool mixed)
> +{
> +	if (mixed)
> +		linfo->disallow_lpage |= KVM_LPAGE_PRIVATE_SHARED_MIXED;
> +	else
> +		linfo->disallow_lpage &= ~KVM_LPAGE_PRIVATE_SHARED_MIXED;
> +}
> +
> +static bool mem_attr_is_mixed_2m(struct kvm *kvm, unsigned int attr,
> +				 gfn_t start, gfn_t end)
> +{
> +	XA_STATE(xas, &kvm->mem_attr_array, start);
> +	gfn_t gfn = start;
> +	void *entry;
> +	bool shared = attr == KVM_MEM_ATTR_SHARED;
> +	bool mixed = false;
> +
> +	rcu_read_lock();
> +	entry = xas_load(&xas);
> +	while (gfn < end) {
> +		if (xas_retry(&xas, entry))
> +			continue;
> +
> +		KVM_BUG_ON(gfn != xas.xa_index, kvm);
> +
> +		if ((entry && !shared) || (!entry && shared)) {
> +			mixed = true;
> +			goto out;
> +		}
> +
> +		entry = xas_next(&xas);
> +		gfn++;
> +	}
> +out:
> +	rcu_read_unlock();
> +	return mixed;
> +}
> +
> +static bool mem_attr_is_mixed(struct kvm *kvm, struct kvm_memory_slot *slot,
> +			      int level, unsigned int attr,
> +			      gfn_t start, gfn_t end)
> +{
> +	unsigned long gfn;
> +	void *entry;
> +
> +	if (level == PG_LEVEL_2M)
> +		return mem_attr_is_mixed_2m(kvm, attr, start, end);
> +
> +	entry = xa_load(&kvm->mem_attr_array, start);
> +	for (gfn = start; gfn < end; gfn += KVM_PAGES_PER_HPAGE(level - 1)) {
> +		if (linfo_is_mixed(lpage_info_slot(gfn, slot, level - 1)))
> +			return true;
> +		if (xa_load(&kvm->mem_attr_array, gfn) != entry)
> +			return true;
> +	}
> +	return false;
> +}
> +
> +void kvm_arch_update_mem_attr(struct kvm *kvm, struct kvm_memory_slot *slot,
> +			      unsigned int attr, gfn_t start, gfn_t end)
> +{
> +
> +	unsigned long lpage_start, lpage_end;
> +	unsigned long gfn, pages, mask;
> +	int level;
> +
> +	WARN_ONCE(!(attr & (KVM_MEM_ATTR_PRIVATE | KVM_MEM_ATTR_SHARED)),
> +			"Unsupported mem attribute.\n");
> +
> +	/*
> +	 * The sequence matters here: we update the higher level basing on the
> +	 * lower level's scanning result.
> +	 */
> +	for (level = PG_LEVEL_2M; level <= KVM_MAX_HUGEPAGE_LEVEL; level++) {
> +		pages = KVM_PAGES_PER_HPAGE(level);
> +		mask = ~(pages - 1);
> +		lpage_start = max(start & mask, slot->base_gfn);
> +		lpage_end = (end - 1) & mask;
> +
> +		/*
> +		 * We only need to scan the head and tail page, for middle pages
> +		 * we know they are not mixed.
> +		 */
> +		linfo_update_mixed(lpage_info_slot(lpage_start, slot, level),
> +				   mem_attr_is_mixed(kvm, slot, level, attr,
> +						     lpage_start, start));

Looks only query the lpage_start, start is not enough:

A and B are private gfns from same lpage_start as below, A > B :
lpage_start
       |---------A
       |----B

Convert A to shared, this makes the upper 2M page to MIX.
Convert B to shared, this also makes the upper 2M page to MIX.
Convert B to private, this makes the upper 2M page to Non-MIX, but
it's incorrect, due to A is shared.

Same to tail case.

> +
> +		if (lpage_start == lpage_end)
> +			return;
> +
> +		for (gfn = lpage_start + pages; gfn < lpage_end; gfn += pages)
> +			linfo_update_mixed(lpage_info_slot(gfn, slot, level),
> +					   false);
> +
> +		linfo_update_mixed(lpage_info_slot(lpage_end, slot, level),
> +				   mem_attr_is_mixed(kvm, slot, level, attr,
> +						     end, lpage_end + pages));
> +	}
> +}
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 02ad31f46dd7..4276ca73bd7b 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -12563,6 +12563,8 @@ static int kvm_alloc_memslot_metadata(struct kvm *kvm,
>  		if ((slot->base_gfn + npages) & (KVM_PAGES_PER_HPAGE(level) - 1))
>  			linfo[lpages - 1].disallow_lpage = 1;
>  		ugfn = slot->userspace_addr >> PAGE_SHIFT;
> +		if (kvm_slot_can_be_private(slot))
> +			ugfn |= slot->restricted_offset >> PAGE_SHIFT;
>  		/*
>  		 * If the gfn and userspace address are not aligned wrt each
>  		 * other, disable large page support for this slot.
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 4ce98fa0153c..6ce36065532c 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2284,4 +2284,23 @@ static inline void kvm_account_pgtable_pages(void *virt, int nr)
>  /* Max number of entries allowed for each kvm dirty ring */
>  #define  KVM_DIRTY_RING_MAX_ENTRIES  65536
>
> +#ifdef CONFIG_KVM_GENERIC_PRIVATE_MEM
> +
> +#define KVM_MEM_ATTR_SHARED	0x0001
> +#define KVM_MEM_ATTR_PRIVATE	0x0002
> +
> +#ifdef __KVM_HAVE_ARCH_UPDATE_MEM_ATTR
> +void kvm_arch_update_mem_attr(struct kvm *kvm, struct kvm_memory_slot *slot,
> +			      unsigned int attr, gfn_t start, gfn_t end);
> +#else
> +static inline void kvm_arch_update_mem_attr(struct kvm *kvm,
> +					    struct kvm_memory_slot *slot,
> +					    unsigned int attr,
> +					    gfn_t start, gfn_t end)
> +{
> +}
> +#endif
> +
> +#endif /* CONFIG_KVM_GENERIC_PRIVATE_MEM */
> +
>  #endif
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index fc3835826ace..13a37b4d9e97 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -939,7 +939,8 @@ static int kvm_init_mmu_notifier(struct kvm *kvm)
>
>  #ifdef CONFIG_KVM_GENERIC_PRIVATE_MEM
>
> -static void kvm_unmap_mem_range(struct kvm *kvm, gfn_t start, gfn_t end)
> +static void kvm_unmap_mem_range(struct kvm *kvm, gfn_t start, gfn_t end,
> +				unsigned int attr)
>  {
>  	struct kvm_gfn_range gfn_range;
>  	struct kvm_memory_slot *slot;
> @@ -963,6 +964,7 @@ static void kvm_unmap_mem_range(struct kvm *kvm, gfn_t start, gfn_t end)
>  			gfn_range.slot = slot;
>
>  			r |= kvm_unmap_gfn_range(kvm, &gfn_range);
> +			kvm_arch_update_mem_attr(kvm, slot, attr, start, end);
>  		}
>  	}
>
> @@ -970,7 +972,6 @@ static void kvm_unmap_mem_range(struct kvm *kvm, gfn_t start, gfn_t end)
>  		kvm_flush_remote_tlbs(kvm);
>  }
>
> -#define KVM_MEM_ATTR_SHARED	0x0001
>  static int kvm_vm_ioctl_set_mem_attr(struct kvm *kvm, gpa_t gpa, gpa_t size,
>  				     bool is_private)
>  {
> @@ -979,6 +980,7 @@ static int kvm_vm_ioctl_set_mem_attr(struct kvm *kvm, gpa_t gpa, gpa_t size,
>  	void *entry;
>  	int idx;
>  	int r = 0;
> +	unsigned int attr;
>
>  	if (size == 0 || gpa + size < gpa)
>  		return -EINVAL;
> @@ -992,7 +994,13 @@ static int kvm_vm_ioctl_set_mem_attr(struct kvm *kvm, gpa_t gpa, gpa_t size,
>  	 * Guest memory defaults to private, kvm->mem_attr_array only stores
>  	 * shared memory.
>  	 */
> -	entry = is_private ? NULL : xa_mk_value(KVM_MEM_ATTR_SHARED);
> +	if (is_private) {
> +		attr = KVM_MEM_ATTR_PRIVATE;
> +		entry = NULL;
> +	} else {
> +		attr = KVM_MEM_ATTR_SHARED;
> +		entry = xa_mk_value(KVM_MEM_ATTR_SHARED);
> +	}
>
>  	idx = srcu_read_lock(&kvm->srcu);
>  	KVM_MMU_LOCK(kvm);
> @@ -1005,7 +1013,7 @@ static int kvm_vm_ioctl_set_mem_attr(struct kvm *kvm, gpa_t gpa, gpa_t size,
>  			goto err;
>  	}
>
> -	kvm_unmap_mem_range(kvm, start, end);
> +	kvm_unmap_mem_range(kvm, start, end, attr);
>
>  	goto ret;
>  err:
> --
> 2.25.1
>
