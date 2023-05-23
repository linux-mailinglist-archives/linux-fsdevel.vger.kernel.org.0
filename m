Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E397F70D4D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 09:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbjEWHVv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 03:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjEWHVu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 03:21:50 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C6E120;
        Tue, 23 May 2023 00:21:20 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34N6rGSF026726;
        Tue, 23 May 2023 07:19:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=aOFKrxD/8Ws8yLWC8SjjnwbXx06prSo2yjIJvkzzvk0=;
 b=M5ZAlAq4eFQ2gk9smVqosLDW3krPRgn8PJbVaauNvenj9HaiA2FNdNhkr6nt9K5Um4ek
 D4PidRgQp0WyPgz1mAnqRFiDRCcELzI4lLfRenvvPyDbKLK5T0JXvhjF/PGa6fJbuSOw
 bYHY7DFFVj/E+/VfB5zWm8jSx9MKHxXwUBAcsdGSR6eEPXT7n2cL8XQo4tquhJVQMFpk
 9bEHfRcLM8Dcq2RyrKrwGzv8MQykTNmuODviC9QIDlWrcXQGrkQpsyF40RUdZae4ASmQ
 N3ts3dlkzvVgyofRkBWKHh9bj1OB6BrxQuVuzmxjW5p8+GNJBHbkX1SQByz1GWZOoIAc og== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qrrkygtf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 07:19:38 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34N6vx99008008;
        Tue, 23 May 2023 07:19:37 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qrrkygtdt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 07:19:37 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34N4snZn030176;
        Tue, 23 May 2023 07:19:34 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3qppe09361-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 07:19:34 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34N7JVKH21693066
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 07:19:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9847B2004E;
        Tue, 23 May 2023 07:19:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 600C920040;
        Tue, 23 May 2023 07:19:22 +0000 (GMT)
Received: from li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com (unknown [9.109.216.99])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 23 May 2023 07:19:22 +0000 (GMT)
Date:   Tue, 23 May 2023 12:49:19 +0530
From:   Kautuk Consul <kconsul@linux.vnet.ibm.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, linux-kselftest@vger.kernel.org,
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
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v7 08/14] KVM: Rename mmu_notifier_*
Message-ID: <ZGxo9ylqYI8JXjGn@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-9-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706082016.2603916-9-chao.p.peng@linux.intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rIX2sU3fQE3c3XkBrS10nGHJfLdh5OEX
X-Proofpoint-ORIG-GUID: bxYNWGfbJVvyRRyVmwpJr9egMnmcVBgY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_04,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 clxscore=1011 mlxlogscore=940
 priorityscore=1501 mlxscore=0 adultscore=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230058
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022-07-06 16:20:10, Chao Peng wrote:
> The sync mechanism between mmu_notifier and page fault handler employs
> fields mmu_notifier_seq/count and mmu_notifier_range_start/end. For the
> to be added private memory, there is the same mechanism needed but not
> rely on mmu_notifier (It uses new introduced memfile_notifier). This
> patch renames the existing fields and related helper functions to a
> neutral name mmu_updating_* so private memory can reuse.
> 
> No functional change intended.
> 
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> ---
>  arch/arm64/kvm/mmu.c                     |  8 ++---
>  arch/mips/kvm/mmu.c                      | 10 +++---
>  arch/powerpc/include/asm/kvm_book3s_64.h |  2 +-
>  arch/powerpc/kvm/book3s_64_mmu_host.c    |  4 +--
>  arch/powerpc/kvm/book3s_64_mmu_hv.c      |  4 +--
>  arch/powerpc/kvm/book3s_64_mmu_radix.c   |  6 ++--
>  arch/powerpc/kvm/book3s_hv_nested.c      |  2 +-
>  arch/powerpc/kvm/book3s_hv_rm_mmu.c      |  8 ++---
>  arch/powerpc/kvm/e500_mmu_host.c         |  4 +--
>  arch/riscv/kvm/mmu.c                     |  4 +--
>  arch/x86/kvm/mmu/mmu.c                   | 14 ++++----
>  arch/x86/kvm/mmu/paging_tmpl.h           |  4 +--
>  include/linux/kvm_host.h                 | 38 ++++++++++-----------
>  virt/kvm/kvm_main.c                      | 42 +++++++++++-------------
>  virt/kvm/pfncache.c                      | 14 ++++----
>  15 files changed, 81 insertions(+), 83 deletions(-)
> 
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 87f1cd0df36e..7ee6fafc24ee 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -993,7 +993,7 @@ transparent_hugepage_adjust(struct kvm *kvm, struct kvm_memory_slot *memslot,
>  		 * THP doesn't start to split while we are adjusting the
>  		 * refcounts.
>  		 *
> -		 * We are sure this doesn't happen, because mmu_notifier_retry
> +		 * We are sure this doesn't happen, because mmu_updating_retry
>  		 * was successful and we are holding the mmu_lock, so if this
>  		 * THP is trying to split, it will be blocked in the mmu
>  		 * notifier before touching any of the pages, specifically
> @@ -1188,9 +1188,9 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  			return ret;
>  	}
>  
> -	mmu_seq = vcpu->kvm->mmu_notifier_seq;
> +	mmu_seq = vcpu->kvm->mmu_updating_seq;
>  	/*
> -	 * Ensure the read of mmu_notifier_seq happens before we call
> +	 * Ensure the read of mmu_updating_seq happens before we call
>  	 * gfn_to_pfn_prot (which calls get_user_pages), so that we don't risk
>  	 * the page we just got a reference to gets unmapped before we have a
>  	 * chance to grab the mmu_lock, which ensure that if the page gets
> @@ -1246,7 +1246,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  	else
>  		write_lock(&kvm->mmu_lock);
>  	pgt = vcpu->arch.hw_mmu->pgt;
> -	if (mmu_notifier_retry(kvm, mmu_seq))
> +	if (mmu_updating_retry(kvm, mmu_seq))
>  		goto out_unlock;
>  
>  	/*
> diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
> index 1bfd1b501d82..abd468c6a749 100644
> --- a/arch/mips/kvm/mmu.c
> +++ b/arch/mips/kvm/mmu.c
> @@ -615,17 +615,17 @@ static int kvm_mips_map_page(struct kvm_vcpu *vcpu, unsigned long gpa,
>  	 * Used to check for invalidations in progress, of the pfn that is
>  	 * returned by pfn_to_pfn_prot below.
>  	 */
> -	mmu_seq = kvm->mmu_notifier_seq;
> +	mmu_seq = kvm->mmu_updating_seq;
>  	/*
> -	 * Ensure the read of mmu_notifier_seq isn't reordered with PTE reads in
> +	 * Ensure the read of mmu_updating_seq isn't reordered with PTE reads in
>  	 * gfn_to_pfn_prot() (which calls get_user_pages()), so that we don't
>  	 * risk the page we get a reference to getting unmapped before we have a
> -	 * chance to grab the mmu_lock without mmu_notifier_retry() noticing.
> +	 * chance to grab the mmu_lock without mmu_updating_retry () noticing.
>  	 *
>  	 * This smp_rmb() pairs with the effective smp_wmb() of the combination
>  	 * of the pte_unmap_unlock() after the PTE is zapped, and the
>  	 * spin_lock() in kvm_mmu_notifier_invalidate_<page|range_end>() before
> -	 * mmu_notifier_seq is incremented.
> +	 * mmu_updating_seq is incremented.
>  	 */
>  	smp_rmb();
>  
> @@ -638,7 +638,7 @@ static int kvm_mips_map_page(struct kvm_vcpu *vcpu, unsigned long gpa,
>  
>  	spin_lock(&kvm->mmu_lock);
>  	/* Check if an invalidation has taken place since we got pfn */
> -	if (mmu_notifier_retry(kvm, mmu_seq)) {
> +	if (mmu_updating_retry(kvm, mmu_seq)) {
>  		/*
>  		 * This can happen when mappings are changed asynchronously, but
>  		 * also synchronously if a COW is triggered by
> diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
> index 4def2bd17b9b..4d35fb913de5 100644
> --- a/arch/powerpc/include/asm/kvm_book3s_64.h
> +++ b/arch/powerpc/include/asm/kvm_book3s_64.h
> @@ -666,7 +666,7 @@ static inline pte_t *find_kvm_host_pte(struct kvm *kvm, unsigned long mmu_seq,
>  	VM_WARN(!spin_is_locked(&kvm->mmu_lock),
>  		"%s called with kvm mmu_lock not held \n", __func__);
>  
> -	if (mmu_notifier_retry(kvm, mmu_seq))
> +	if (mmu_updating_retry(kvm, mmu_seq))
>  		return NULL;
>  
>  	pte = __find_linux_pte(kvm->mm->pgd, ea, NULL, hshift);
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_host.c b/arch/powerpc/kvm/book3s_64_mmu_host.c
> index 1ae09992c9ea..78f1aae8cb60 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_host.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_host.c
> @@ -90,7 +90,7 @@ int kvmppc_mmu_map_page(struct kvm_vcpu *vcpu, struct kvmppc_pte *orig_pte,
>  	unsigned long pfn;
>  
>  	/* used to check for invalidations in progress */
> -	mmu_seq = kvm->mmu_notifier_seq;
> +	mmu_seq = kvm->mmu_updating_seq;
>  	smp_rmb();
>  
>  	/* Get host physical address for gpa */
> @@ -151,7 +151,7 @@ int kvmppc_mmu_map_page(struct kvm_vcpu *vcpu, struct kvmppc_pte *orig_pte,
>  	cpte = kvmppc_mmu_hpte_cache_next(vcpu);
>  
>  	spin_lock(&kvm->mmu_lock);
> -	if (!cpte || mmu_notifier_retry(kvm, mmu_seq)) {
> +	if (!cpte || mmu_updating_retry(kvm, mmu_seq)) {
>  		r = -EAGAIN;
>  		goto out_unlock;
>  	}
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> index 514fd45c1994..bcdec6a6f2a7 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> @@ -578,7 +578,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_vcpu *vcpu,
>  		return -EFAULT;
>  
>  	/* used to check for invalidations in progress */
> -	mmu_seq = kvm->mmu_notifier_seq;
> +	mmu_seq = kvm->mmu_updating_seq;
>  	smp_rmb();
>  
>  	ret = -EFAULT;
> @@ -693,7 +693,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_vcpu *vcpu,
>  
>  	/* Check if we might have been invalidated; let the guest retry if so */
>  	ret = RESUME_GUEST;
> -	if (mmu_notifier_retry(vcpu->kvm, mmu_seq)) {
> +	if (mmu_updating_retry(vcpu->kvm, mmu_seq)) {
>  		unlock_rmap(rmap);
>  		goto out_unlock;
>  	}
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
> index 42851c32ff3b..c8890ccc3f40 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
> @@ -639,7 +639,7 @@ int kvmppc_create_pte(struct kvm *kvm, pgd_t *pgtable, pte_t pte,
>  	/* Check if we might have been invalidated; let the guest retry if so */
>  	spin_lock(&kvm->mmu_lock);
>  	ret = -EAGAIN;
> -	if (mmu_notifier_retry(kvm, mmu_seq))
> +	if (mmu_updating_retry(kvm, mmu_seq))
>  		goto out_unlock;
>  
>  	/* Now traverse again under the lock and change the tree */
> @@ -829,7 +829,7 @@ int kvmppc_book3s_instantiate_page(struct kvm_vcpu *vcpu,
>  	bool large_enable;
>  
>  	/* used to check for invalidations in progress */
> -	mmu_seq = kvm->mmu_notifier_seq;
> +	mmu_seq = kvm->mmu_updating_seq;
>  	smp_rmb();
>  
>  	/*
> @@ -1190,7 +1190,7 @@ void kvmppc_radix_flush_memslot(struct kvm *kvm,
>  	 * Increase the mmu notifier sequence number to prevent any page
>  	 * fault that read the memslot earlier from writing a PTE.
>  	 */
> -	kvm->mmu_notifier_seq++;
> +	kvm->mmu_updating_seq++;
>  	spin_unlock(&kvm->mmu_lock);
>  }
>  
> diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
> index 0644732d1a25..09f841f730da 100644
> --- a/arch/powerpc/kvm/book3s_hv_nested.c
> +++ b/arch/powerpc/kvm/book3s_hv_nested.c
> @@ -1579,7 +1579,7 @@ static long int __kvmhv_nested_page_fault(struct kvm_vcpu *vcpu,
>  	/* 2. Find the host pte for this L1 guest real address */
>  
>  	/* Used to check for invalidations in progress */
> -	mmu_seq = kvm->mmu_notifier_seq;
> +	mmu_seq = kvm->mmu_updating_seq;
>  	smp_rmb();
>  
>  	/* See if can find translation in our partition scoped tables for L1 */
> diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
> index 2257fb18cb72..952b504dc98a 100644
> --- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
> +++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
> @@ -219,7 +219,7 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
>  	g_ptel = ptel;
>  
>  	/* used later to detect if we might have been invalidated */
> -	mmu_seq = kvm->mmu_notifier_seq;
> +	mmu_seq = kvm->mmu_updating_seq;
>  	smp_rmb();
>  
>  	/* Find the memslot (if any) for this address */
> @@ -366,7 +366,7 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
>  			rmap = real_vmalloc_addr(rmap);
>  		lock_rmap(rmap);
>  		/* Check for pending invalidations under the rmap chain lock */
> -		if (mmu_notifier_retry(kvm, mmu_seq)) {
> +		if (mmu_updating_retry(kvm, mmu_seq)) {
>  			/* inval in progress, write a non-present HPTE */
>  			pteh |= HPTE_V_ABSENT;
>  			pteh &= ~HPTE_V_VALID;
> @@ -932,7 +932,7 @@ static long kvmppc_do_h_page_init_zero(struct kvm_vcpu *vcpu,
>  	int i;
>  
>  	/* Used later to detect if we might have been invalidated */
> -	mmu_seq = kvm->mmu_notifier_seq;
> +	mmu_seq = kvm->mmu_updating_seq;
>  	smp_rmb();
>  
>  	arch_spin_lock(&kvm->mmu_lock.rlock.raw_lock);
> @@ -960,7 +960,7 @@ static long kvmppc_do_h_page_init_copy(struct kvm_vcpu *vcpu,
>  	long ret = H_SUCCESS;
>  
>  	/* Used later to detect if we might have been invalidated */
> -	mmu_seq = kvm->mmu_notifier_seq;
> +	mmu_seq = kvm->mmu_updating_seq;
>  	smp_rmb();
>  
>  	arch_spin_lock(&kvm->mmu_lock.rlock.raw_lock);
> diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
> index 7f16afc331ef..d7636b926f25 100644
> --- a/arch/powerpc/kvm/e500_mmu_host.c
> +++ b/arch/powerpc/kvm/e500_mmu_host.c
> @@ -339,7 +339,7 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
>  	unsigned long flags;
>  
>  	/* used to check for invalidations in progress */
> -	mmu_seq = kvm->mmu_notifier_seq;
> +	mmu_seq = kvm->mmu_updating_seq;
>  	smp_rmb();
>  
>  	/*
> @@ -460,7 +460,7 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
>  	}
>  
>  	spin_lock(&kvm->mmu_lock);
> -	if (mmu_notifier_retry(kvm, mmu_seq)) {
> +	if (mmu_updating_retry(kvm, mmu_seq)) {
>  		ret = -EAGAIN;
>  		goto out;
>  	}
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 081f8d2b9cf3..a7db374d3861 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -654,7 +654,7 @@ int kvm_riscv_gstage_map(struct kvm_vcpu *vcpu,
>  		return ret;
>  	}
>  
> -	mmu_seq = kvm->mmu_notifier_seq;
> +	mmu_seq = kvm->mmu_updating_seq;
>  
>  	hfn = gfn_to_pfn_prot(kvm, gfn, is_write, &writeable);
>  	if (hfn == KVM_PFN_ERR_HWPOISON) {
> @@ -674,7 +674,7 @@ int kvm_riscv_gstage_map(struct kvm_vcpu *vcpu,
>  
>  	spin_lock(&kvm->mmu_lock);
>  
> -	if (mmu_notifier_retry(kvm, mmu_seq))
> +	if (mmu_updating_retry(kvm, mmu_seq))
>  		goto out_unlock;
>  
>  	if (writeable) {
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 0d882fad4bc1..545eb74305fe 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -2908,7 +2908,7 @@ static void direct_pte_prefetch(struct kvm_vcpu *vcpu, u64 *sptep)
>  	 * If addresses are being invalidated, skip prefetching to avoid
>  	 * accidentally prefetching those addresses.
>  	 */
> -	if (unlikely(vcpu->kvm->mmu_notifier_count))
> +	if (unlikely(vcpu->kvm->mmu_updating_count))
>  		return;
>  
>  	__direct_pte_prefetch(vcpu, sp, sptep);
> @@ -2950,7 +2950,7 @@ static int host_pfn_mapping_level(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
>  	/*
>  	 * Lookup the mapping level in the current mm.  The information
>  	 * may become stale soon, but it is safe to use as long as
> -	 * 1) mmu_notifier_retry was checked after taking mmu_lock, and
> +	 * 1) mmu_updating_retry was checked after taking mmu_lock, and
>  	 * 2) mmu_lock is taken now.
>  	 *
>  	 * We still need to disable IRQs to prevent concurrent tear down
> @@ -3035,7 +3035,7 @@ void kvm_mmu_hugepage_adjust(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
>  		return;
>  
>  	/*
> -	 * mmu_notifier_retry() was successful and mmu_lock is held, so
> +	 * mmu_updating_retry was successful and mmu_lock is held, so
>  	 * the pmd can't be split from under us.
>  	 */
>  	fault->goal_level = fault->req_level;
> @@ -4182,7 +4182,7 @@ static bool is_page_fault_stale(struct kvm_vcpu *vcpu,
>  		return true;
>  
>  	return fault->slot &&
> -	       mmu_notifier_retry_gfn(vcpu->kvm, mmu_seq, fault->gfn);
> +	       mmu_updating_retry_gfn(vcpu->kvm, mmu_seq, fault->gfn);
>  }
>  
>  static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
> @@ -4206,7 +4206,7 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
>  	if (r)
>  		return r;
>  
> -	mmu_seq = vcpu->kvm->mmu_notifier_seq;
> +	mmu_seq = vcpu->kvm->mmu_updating_seq;
>  	smp_rmb();
>  
>  	r = kvm_faultin_pfn(vcpu, fault);
> @@ -6023,7 +6023,7 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
>  
>  	write_lock(&kvm->mmu_lock);
>  
> -	kvm_inc_notifier_count(kvm, gfn_start, gfn_end);
> +	kvm_mmu_updating_begin(kvm, gfn_start, gfn_end);
>  
>  	flush = __kvm_zap_rmaps(kvm, gfn_start, gfn_end);
>  
> @@ -6037,7 +6037,7 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
>  		kvm_flush_remote_tlbs_with_address(kvm, gfn_start,
>  						   gfn_end - gfn_start);
>  
> -	kvm_dec_notifier_count(kvm, gfn_start, gfn_end);
> +	kvm_mmu_updating_end(kvm, gfn_start, gfn_end);
>  
>  	write_unlock(&kvm->mmu_lock);
>  }
> diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
> index 2448fa8d8438..acf7e41aa02b 100644
> --- a/arch/x86/kvm/mmu/paging_tmpl.h
> +++ b/arch/x86/kvm/mmu/paging_tmpl.h
> @@ -589,7 +589,7 @@ static void FNAME(pte_prefetch)(struct kvm_vcpu *vcpu, struct guest_walker *gw,
>  	 * If addresses are being invalidated, skip prefetching to avoid
>  	 * accidentally prefetching those addresses.
>  	 */
> -	if (unlikely(vcpu->kvm->mmu_notifier_count))
> +	if (unlikely(vcpu->kvm->mmu_updating_count))
>  		return;
>  
>  	if (sp->role.direct)
> @@ -838,7 +838,7 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
>  	else
>  		fault->max_level = walker.level;
>  
> -	mmu_seq = vcpu->kvm->mmu_notifier_seq;
> +	mmu_seq = vcpu->kvm->mmu_updating_seq;
>  	smp_rmb();
>  
>  	r = kvm_faultin_pfn(vcpu, fault);
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index e9153b54e2a4..c262ebb168a7 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -765,10 +765,10 @@ struct kvm {
>  
>  #if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
>  	struct mmu_notifier mmu_notifier;
> -	unsigned long mmu_notifier_seq;
> -	long mmu_notifier_count;
> -	gfn_t mmu_notifier_range_start;
> -	gfn_t mmu_notifier_range_end;
> +	unsigned long mmu_updating_seq;
> +	long mmu_updating_count;

Can we convert mmu_updating_seq and mmu_updating_count to atomic_t ?
I see that not all accesses to these are under the kvm->mmu_lock
spinlock. This will also remove the need for putting separate smp_wmb() and
smp_rmb() memory barriers while accessing these structure members.

> +	gfn_t mmu_updating_range_start;
> +	gfn_t mmu_updating_range_end;
>  #endif
>  	struct list_head devices;
>  	u64 manual_dirty_log_protect;
> @@ -1362,8 +1362,8 @@ void kvm_mmu_free_memory_cache(struct kvm_mmu_memory_cache *mc);
>  void *kvm_mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc);
>  #endif
>  
> -void kvm_inc_notifier_count(struct kvm *kvm, gfn_t start, gfn_t end);
> -void kvm_dec_notifier_count(struct kvm *kvm, gfn_t start, gfn_t end);
> +void kvm_mmu_updating_begin(struct kvm *kvm, gfn_t start, gfn_t end);
> +void kvm_mmu_updating_end(struct kvm *kvm, gfn_t start, gfn_t end);
>  
>  long kvm_arch_dev_ioctl(struct file *filp,
>  			unsigned int ioctl, unsigned long arg);
> @@ -1901,42 +1901,42 @@ extern const struct kvm_stats_header kvm_vcpu_stats_header;
>  extern const struct _kvm_stats_desc kvm_vcpu_stats_desc[];
>  
>  #if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
> -static inline int mmu_notifier_retry(struct kvm *kvm, unsigned long mmu_seq)
> +static inline int mmu_updating_retry(struct kvm *kvm, unsigned long mmu_seq)
>  {
> -	if (unlikely(kvm->mmu_notifier_count))
> +	if (unlikely(kvm->mmu_updating_count))
>  		return 1;
>  	/*
> -	 * Ensure the read of mmu_notifier_count happens before the read
> -	 * of mmu_notifier_seq.  This interacts with the smp_wmb() in
> +	 * Ensure the read of mmu_updating_count happens before the read
> +	 * of mmu_updating_seq.  This interacts with the smp_wmb() in
>  	 * mmu_notifier_invalidate_range_end to make sure that the caller
> -	 * either sees the old (non-zero) value of mmu_notifier_count or
> -	 * the new (incremented) value of mmu_notifier_seq.
> +	 * either sees the old (non-zero) value of mmu_updating_count or
> +	 * the new (incremented) value of mmu_updating_seq.
>  	 * PowerPC Book3s HV KVM calls this under a per-page lock
>  	 * rather than under kvm->mmu_lock, for scalability, so
>  	 * can't rely on kvm->mmu_lock to keep things ordered.
>  	 */
>  	smp_rmb();
> -	if (kvm->mmu_notifier_seq != mmu_seq)
> +	if (kvm->mmu_updating_seq != mmu_seq)
>  		return 1;
>  	return 0;
>  }
>  
> -static inline int mmu_notifier_retry_gfn(struct kvm *kvm,
> +static inline int mmu_updating_retry_gfn(struct kvm *kvm,
>  					 unsigned long mmu_seq,
>  					 gfn_t gfn)
>  {
>  	lockdep_assert_held(&kvm->mmu_lock);
>  	/*
> -	 * If mmu_notifier_count is non-zero, then the range maintained by
> +	 * If mmu_updating_count is non-zero, then the range maintained by
>  	 * kvm_mmu_notifier_invalidate_range_start contains all addresses that
>  	 * might be being invalidated. Note that it may include some false
>  	 * positives, due to shortcuts when handing concurrent invalidations.
>  	 */
> -	if (unlikely(kvm->mmu_notifier_count) &&
> -	    gfn >= kvm->mmu_notifier_range_start &&
> -	    gfn < kvm->mmu_notifier_range_end)
> +	if (unlikely(kvm->mmu_updating_count) &&
> +	    gfn >= kvm->mmu_updating_range_start &&
> +	    gfn < kvm->mmu_updating_range_end)
>  		return 1;
> -	if (kvm->mmu_notifier_seq != mmu_seq)
> +	if (kvm->mmu_updating_seq != mmu_seq)
>  		return 1;
>  	return 0;
>  }
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 4d7f0e72366f..3ae4944b9f15 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -698,30 +698,29 @@ static void kvm_mmu_notifier_change_pte(struct mmu_notifier *mn,
>  
>  	/*
>  	 * .change_pte() must be surrounded by .invalidate_range_{start,end}().
> -	 * If mmu_notifier_count is zero, then no in-progress invalidations,
> +	 * If mmu_updating_count is zero, then no in-progress invalidations,
>  	 * including this one, found a relevant memslot at start(); rechecking
>  	 * memslots here is unnecessary.  Note, a false positive (count elevated
>  	 * by a different invalidation) is sub-optimal but functionally ok.
>  	 */
>  	WARN_ON_ONCE(!READ_ONCE(kvm->mn_active_invalidate_count));
> -	if (!READ_ONCE(kvm->mmu_notifier_count))
> +	if (!READ_ONCE(kvm->mmu_updating_count))
>  		return;
>  
>  	kvm_handle_hva_range(mn, address, address + 1, pte, kvm_set_spte_gfn);
>  }
>  
> -void kvm_inc_notifier_count(struct kvm *kvm, unsigned long start,
> -				   unsigned long end)
> +void kvm_mmu_updating_begin(struct kvm *kvm, gfn_t start, gfn_t end)
>  {
>  	/*
>  	 * The count increase must become visible at unlock time as no
>  	 * spte can be established without taking the mmu_lock and
>  	 * count is also read inside the mmu_lock critical section.
>  	 */
> -	kvm->mmu_notifier_count++;
> -	if (likely(kvm->mmu_notifier_count == 1)) {
> -		kvm->mmu_notifier_range_start = start;
> -		kvm->mmu_notifier_range_end = end;
> +	kvm->mmu_updating_count++;
> +	if (likely(kvm->mmu_updating_count == 1)) {
> +		kvm->mmu_updating_range_start = start;
> +		kvm->mmu_updating_range_end = end;
>  	} else {
>  		/*
>  		 * Fully tracking multiple concurrent ranges has diminishing
> @@ -732,10 +731,10 @@ void kvm_inc_notifier_count(struct kvm *kvm, unsigned long start,
>  		 * accumulate and persist until all outstanding invalidates
>  		 * complete.
>  		 */
> -		kvm->mmu_notifier_range_start =
> -			min(kvm->mmu_notifier_range_start, start);
> -		kvm->mmu_notifier_range_end =
> -			max(kvm->mmu_notifier_range_end, end);
> +		kvm->mmu_updating_range_start =
> +			min(kvm->mmu_updating_range_start, start);
> +		kvm->mmu_updating_range_end =
> +			max(kvm->mmu_updating_range_end, end);
>  	}
>  }
>  
> @@ -748,7 +747,7 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
>  		.end		= range->end,
>  		.pte		= __pte(0),
>  		.handler	= kvm_unmap_gfn_range,
> -		.on_lock	= kvm_inc_notifier_count,
> +		.on_lock	= kvm_mmu_updating_begin,
>  		.on_unlock	= kvm_arch_guest_memory_reclaimed,
>  		.flush_on_ret	= true,
>  		.may_block	= mmu_notifier_range_blockable(range),
> @@ -759,7 +758,7 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
>  	/*
>  	 * Prevent memslot modification between range_start() and range_end()
>  	 * so that conditionally locking provides the same result in both
> -	 * functions.  Without that guarantee, the mmu_notifier_count
> +	 * functions.  Without that guarantee, the mmu_updating_count
>  	 * adjustments will be imbalanced.
>  	 *
>  	 * Pairs with the decrement in range_end().
> @@ -775,7 +774,7 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
>  	 * any given time, and the caches themselves can check for hva overlap,
>  	 * i.e. don't need to rely on memslot overlap checks for performance.
>  	 * Because this runs without holding mmu_lock, the pfn caches must use
> -	 * mn_active_invalidate_count (see above) instead of mmu_notifier_count.
> +	 * mn_active_invalidate_count (see above) instead of mmu_updating_count.
>  	 */
>  	gfn_to_pfn_cache_invalidate_start(kvm, range->start, range->end,
>  					  hva_range.may_block);
> @@ -785,22 +784,21 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
>  	return 0;
>  }
>  
> -void kvm_dec_notifier_count(struct kvm *kvm, unsigned long start,
> -				   unsigned long end)
> +void kvm_mmu_updating_end(struct kvm *kvm, gfn_t start, gfn_t end)
>  {
>  	/*
>  	 * This sequence increase will notify the kvm page fault that
>  	 * the page that is going to be mapped in the spte could have
>  	 * been freed.
>  	 */
> -	kvm->mmu_notifier_seq++;
> +	kvm->mmu_updating_seq++;
>  	smp_wmb();
>  	/*
>  	 * The above sequence increase must be visible before the
>  	 * below count decrease, which is ensured by the smp_wmb above
> -	 * in conjunction with the smp_rmb in mmu_notifier_retry().
> +	 * in conjunction with the smp_rmb in mmu_updating_retry().
>  	 */
> -	kvm->mmu_notifier_count--;
> +	kvm->mmu_updating_count--;
>  }
>  
>  static void kvm_mmu_notifier_invalidate_range_end(struct mmu_notifier *mn,
> @@ -812,7 +810,7 @@ static void kvm_mmu_notifier_invalidate_range_end(struct mmu_notifier *mn,
>  		.end		= range->end,
>  		.pte		= __pte(0),
>  		.handler	= (void *)kvm_null_fn,
> -		.on_lock	= kvm_dec_notifier_count,
> +		.on_lock	= kvm_mmu_updating_end,
>  		.on_unlock	= (void *)kvm_null_fn,
>  		.flush_on_ret	= false,
>  		.may_block	= mmu_notifier_range_blockable(range),
> @@ -833,7 +831,7 @@ static void kvm_mmu_notifier_invalidate_range_end(struct mmu_notifier *mn,
>  	if (wake)
>  		rcuwait_wake_up(&kvm->mn_memslots_update_rcuwait);
>  
> -	BUG_ON(kvm->mmu_notifier_count < 0);
> +	BUG_ON(kvm->mmu_updating_count < 0);
>  }
>  
>  static int kvm_mmu_notifier_clear_flush_young(struct mmu_notifier *mn,
> diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
> index ab519f72f2cd..aa6d24966a76 100644
> --- a/virt/kvm/pfncache.c
> +++ b/virt/kvm/pfncache.c
> @@ -112,27 +112,27 @@ static inline bool mmu_notifier_retry_cache(struct kvm *kvm, unsigned long mmu_s
>  {
>  	/*
>  	 * mn_active_invalidate_count acts for all intents and purposes
> -	 * like mmu_notifier_count here; but the latter cannot be used
> +	 * like mmu_updating_count here; but the latter cannot be used
>  	 * here because the invalidation of caches in the mmu_notifier
> -	 * event occurs _before_ mmu_notifier_count is elevated.
> +	 * event occurs _before_ mmu_updating_count is elevated.
>  	 *
>  	 * Note, it does not matter that mn_active_invalidate_count
>  	 * is not protected by gpc->lock.  It is guaranteed to
>  	 * be elevated before the mmu_notifier acquires gpc->lock, and
> -	 * isn't dropped until after mmu_notifier_seq is updated.
> +	 * isn't dropped until after mmu_updating_seq is updated.
>  	 */
>  	if (kvm->mn_active_invalidate_count)
>  		return true;
>  
>  	/*
>  	 * Ensure mn_active_invalidate_count is read before
> -	 * mmu_notifier_seq.  This pairs with the smp_wmb() in
> +	 * mmu_updating_seq.  This pairs with the smp_wmb() in
>  	 * mmu_notifier_invalidate_range_end() to guarantee either the
>  	 * old (non-zero) value of mn_active_invalidate_count or the
> -	 * new (incremented) value of mmu_notifier_seq is observed.
> +	 * new (incremented) value of mmu_updating_seq is observed.
>  	 */
>  	smp_rmb();
> -	return kvm->mmu_notifier_seq != mmu_seq;
> +	return kvm->mmu_updating_seq != mmu_seq;
>  }
>  
>  static kvm_pfn_t hva_to_pfn_retry(struct kvm *kvm, struct gfn_to_pfn_cache *gpc)
> @@ -155,7 +155,7 @@ static kvm_pfn_t hva_to_pfn_retry(struct kvm *kvm, struct gfn_to_pfn_cache *gpc)
>  	gpc->valid = false;
>  
>  	do {
> -		mmu_seq = kvm->mmu_notifier_seq;
> +		mmu_seq = kvm->mmu_updating_seq;
>  		smp_rmb();
>  
>  		write_unlock_irq(&gpc->lock);
> -- 
> 2.25.1
> 
