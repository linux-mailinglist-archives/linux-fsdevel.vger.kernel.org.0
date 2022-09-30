Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC345F071C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 11:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbiI3JET (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 05:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiI3JEM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:04:12 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759F6FEE62;
        Fri, 30 Sep 2022 02:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664528641; x=1696064641;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=7edFq4KfjD2qXKsxniMqDJkmCPq4gGLwlTMIRGIuFiY=;
  b=fzyNl9+llh60/1XsgZBRPtuKhdA8F6v1zrm2E8iZAyQFNrwRgp+YDKIx
   fFobK2uAQ/jqtE9hfEZmiPEhkjI11N9ktEFxuX6hW/axbHdz4b6s+Lpko
   1UxXZnSk+HBSB9gYITmK4ttm9JLDXl6IBLJMtNxLOxeVlcasZkeK/Pkw/
   VXSx/U+nrqdgtxPwbQ+f4Tra7XTp+Gg+/OqHlS1IIeeS4NAmBTAuIwefI
   7o66eJnoP8eFSy7KRQrfpKJrOCW5bgzeFsxBp3YiN7Y/RBuDhsgzYJ53F
   cOPkpCNBkM2o7Q8Yd1RJeSpBIHpU9qtejnPyMFc+Y0sXSDqPTqO13UHSc
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="300863395"
X-IronPort-AV: E=Sophos;i="5.93,357,1654585200"; 
   d="scan'208";a="300863395"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 02:04:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="685214525"
X-IronPort-AV: E=Sophos;i="5.93,357,1654585200"; 
   d="scan'208";a="685214525"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by fmsmga008.fm.intel.com with ESMTP; 30 Sep 2022 02:03:49 -0700
Date:   Fri, 30 Sep 2022 16:59:14 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Isaku Yamahata <isaku.yamahata@gmail.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
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
Subject: Re: [PATCH v8 6/8] KVM: Update lpage info when private/shared memory
 are mixed
Message-ID: <20220930085914.GA2799703@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-7-chao.p.peng@linux.intel.com>
 <20220929165206.GA1963093@ls.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929165206.GA1963093@ls.amr.corp.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 29, 2022 at 09:52:06AM -0700, Isaku Yamahata wrote:
> On Thu, Sep 15, 2022 at 10:29:11PM +0800,
> Chao Peng <chao.p.peng@linux.intel.com> wrote:
> 
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index 08abad4f3e6f..a0f198cede3d 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> ...
> > @@ -6894,3 +6899,115 @@ void kvm_mmu_pre_destroy_vm(struct kvm *kvm)
> >  	if (kvm->arch.nx_lpage_recovery_thread)
> >  		kthread_stop(kvm->arch.nx_lpage_recovery_thread);
> >  }
> > +
> > +static bool mem_attr_is_mixed(struct kvm *kvm, unsigned int attr,
> > +			      gfn_t start, gfn_t end)
> > +{
> > +	XA_STATE(xas, &kvm->mem_attr_array, start);
> > +	gfn_t gfn = start;
> > +	void *entry;
> > +	bool shared, private;
> > +	bool mixed = false;
> > +
> > +	if (attr == KVM_MEM_ATTR_SHARED) {
> > +		shared = true;
> > +		private = false;
> > +	} else {
> > +		shared = false;
> > +		private = true;
> > +	}
> 
> We don't have to care the target is shared or private.  We need to check
> only same or not.

There is optimization chance if we know what we are going to set. we can
return 'mixed = true' earlier when we find the first reverse attr, e.g.
it's unnecessarily to check all the child page attr in one largepage to
give a conclusion.

After a further look, the code can be refined as below:

--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -7255,17 +7255,9 @@ static bool mem_attr_is_mixed(struct kvm *kvm, unsigned int attr,
 	XA_STATE(xas, &kvm->mem_attr_array, start);
 	gfn_t gfn = start;
 	void *entry;
-	bool shared, private;
+	bool shared = attr == KVM_MEM_ATTR_SHARED;
 	bool mixed = false;
 
-	if (attr == KVM_MEM_ATTR_SHARED) {
-		shared = true;
-		private = false;
-	} else {
-		shared = false;
-		private = true;
-	}
-
 	rcu_read_lock();
 	entry = xas_load(&xas);
 	while (gfn < end) {
@@ -7274,12 +7266,7 @@ static bool mem_attr_is_mixed(struct kvm *kvm, unsigned int attr,
 
 		KVM_BUG_ON(gfn != xas.xa_index, kvm);
 
-		if (entry)
-			private = true;
-		else
-			shared = true;
-
-		if (private && shared) {
+		if ((entry && !shared) || (!entry && shared)) {
 			mixed = true;
 			goto out;
 		}
@@ -7320,8 +7307,7 @@ static void update_mem_lpage_info(struct kvm *kvm,
 		 * we know they are not mixed.
 		 */
 		update_mixed(lpage_info_slot(lpage_start, slot, level),
-			     mem_attr_is_mixed(kvm, attr, lpage_start,
-							  lpage_start + pages));
+			     mem_attr_is_mixed(kvm, attr, lpage_start, start));
 
 		if (lpage_start == lpage_end)
 			return;
@@ -7330,7 +7316,7 @@ static void update_mem_lpage_info(struct kvm *kvm,
 			update_mixed(lpage_info_slot(gfn, slot, level), false);
 
 		update_mixed(lpage_info_slot(lpage_end, slot, level),
-			     mem_attr_is_mixed(kvm, attr, lpage_end,
+			     mem_attr_is_mixed(kvm, attr, end,
 							  lpage_end + pages));
 	}
 }
> 
> > +
> > +	rcu_read_lock();
> > +	entry = xas_load(&xas);
> > +	while (gfn < end) {
> > +		if (xas_retry(&xas, entry))
> > +			continue;
> > +
> > +		KVM_BUG_ON(gfn != xas.xa_index, kvm);
> > +
> > +		if (entry)
> > +			private = true;
> > +		else
> > +			shared = true;
> > +
> > +		if (private && shared) {
> > +			mixed = true;
> > +			goto out;
> > +		}
> > +
> > +		entry = xas_next(&xas);
> > +		gfn++;
> > +	}
> > +out:
> > +	rcu_read_unlock();
> > +	return mixed;
> > +}
> > +
> > +static inline void update_mixed(struct kvm_lpage_info *linfo, bool mixed)
> > +{
> > +	if (mixed)
> > +		linfo->disallow_lpage |= KVM_LPAGE_PRIVATE_SHARED_MIXED;
> > +	else
> > +		linfo->disallow_lpage &= ~KVM_LPAGE_PRIVATE_SHARED_MIXED;
> > +}
> > +
> > +static void update_mem_lpage_info(struct kvm *kvm,
> > +				  struct kvm_memory_slot *slot,
> > +				  unsigned int attr,
> > +				  gfn_t start, gfn_t end)
> > +{
> > +	unsigned long lpage_start, lpage_end;
> > +	unsigned long gfn, pages, mask;
> > +	int level;
> > +
> > +	for (level = PG_LEVEL_2M; level <= KVM_MAX_HUGEPAGE_LEVEL; level++) {
> > +		pages = KVM_PAGES_PER_HPAGE(level);
> > +		mask = ~(pages - 1);
> > +		lpage_start = start & mask;
> > +		lpage_end = (end - 1) & mask;
> > +
> > +		/*
> > +		 * We only need to scan the head and tail page, for middle pages
> > +		 * we know they are not mixed.
> > +		 */
> > +		update_mixed(lpage_info_slot(lpage_start, slot, level),
> > +			     mem_attr_is_mixed(kvm, attr, lpage_start,
> > +							  lpage_start + pages));
> > +
> > +		if (lpage_start == lpage_end)
> > +			return;
> > +
> > +		for (gfn = lpage_start + pages; gfn < lpage_end; gfn += pages)
> > +			update_mixed(lpage_info_slot(gfn, slot, level), false);
> 
> 
> For >2M case, we don't have to check all entry. just check lower level case.

Sounds good, we can reduce some scanning.

Thanks,
Chao
> 
> > +
> > +		update_mixed(lpage_info_slot(lpage_end, slot, level),
> > +			     mem_attr_is_mixed(kvm, attr, lpage_end,
> > +							  lpage_end + pages));
> > +	}
> > +}
> > +
> > +void kvm_arch_update_mem_attr(struct kvm *kvm, unsigned int attr,
> > +			      gfn_t start, gfn_t end)
> > +{
> > +	struct kvm_memory_slot *slot;
> > +	struct kvm_memslots *slots;
> > +	struct kvm_memslot_iter iter;
> > +	int i;
> > +
> > +	WARN_ONCE(!(attr & (KVM_MEM_ATTR_PRIVATE | KVM_MEM_ATTR_SHARED)),
> > +			"Unsupported mem attribute.\n");
> > +
> > +	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
> > +		slots = __kvm_memslots(kvm, i);
> > +
> > +		kvm_for_each_memslot_in_gfn_range(&iter, slots, start, end) {
> > +			slot = iter.slot;
> > +			start = max(start, slot->base_gfn);
> > +			end = min(end, slot->base_gfn + slot->npages);
> > +			if (WARN_ON_ONCE(start >= end))
> > +				continue;
> > +
> > +			update_mem_lpage_info(kvm, slot, attr, start, end);
> > +		}
> > +	}
> > +}
> 
> 
> Here is my updated version.
> 
> bool kvm_mem_attr_is_mixed(struct kvm_memory_slot *slot, gfn_t gfn, int level)
> {
> 	gfn_t pages = KVM_PAGES_PER_HPAGE(level);
> 	gfn_t mask = ~(pages - 1);
> 	struct kvm_lpage_info *linfo = lpage_info_slot(gfn & mask, slot, level);
> 
> 	WARN_ON_ONCE(level == PG_LEVEL_4K);
> 	return linfo->disallow_lpage & KVM_LPAGE_PRIVATE_SHARED_MIXED;
> }
> 
> #ifdef CONFIG_HAVE_KVM_PRIVATE_MEM_ATTR
> static void update_mixed(struct kvm_lpage_info *linfo, bool mixed)
> {
> 	if (mixed)
> 		linfo->disallow_lpage |= KVM_LPAGE_PRIVATE_SHARED_MIXED;
> 	else
> 		linfo->disallow_lpage &= ~KVM_LPAGE_PRIVATE_SHARED_MIXED;
> }
> 
> static bool __mem_attr_is_mixed(struct kvm *kvm, gfn_t start, gfn_t end)
> {
> 	XA_STATE(xas, &kvm->mem_attr_array, start);
> 	bool mixed = false;
> 	gfn_t gfn = start;
> 	void *s_entry;
> 	void *entry;
> 
> 	rcu_read_lock();
> 	s_entry = xas_load(&xas);
> 	entry = s_entry;
> 	while (gfn < end) {
> 		if (xas_retry(&xas, entry))
> 			continue;
> 
> 		KVM_BUG_ON(gfn != xas.xa_index, kvm);
> 
> 		entry = xas_next(&xas);
> 		if (entry != s_entry) {
> 			mixed = true;
> 			break;
> 		}
> 		gfn++;
> 	}
> 	rcu_read_unlock();
> 	return mixed;
> }
> 
> static bool mem_attr_is_mixed(struct kvm *kvm,
> 			      struct kvm_memory_slot *slot, int level,
> 			      gfn_t start, gfn_t end)
> {
> 	struct kvm_lpage_info *child_linfo;
> 	unsigned long child_pages;
> 	bool mixed = false;
> 	unsigned long gfn;
> 	void *entry;
> 
> 	if (WARN_ON_ONCE(level == PG_LEVEL_4K))
> 		return false;
> 
> 	if (level == PG_LEVEL_2M)
> 		return __mem_attr_is_mixed(kvm, start, end);
> 
> 	/* This assumes that level - 1 is already updated. */
> 	rcu_read_lock();
> 	child_pages = KVM_PAGES_PER_HPAGE(level - 1);
> 	entry = xa_load(&kvm->mem_attr_array, start);
> 	for (gfn = start; gfn < end; gfn += child_pages) {
> 		child_linfo = lpage_info_slot(gfn, slot, level - 1);
> 		if (child_linfo->disallow_lpage & KVM_LPAGE_PRIVATE_SHARED_MIXED) {
> 			mixed = true;
> 			break;
> 		}
> 		if (xa_load(&kvm->mem_attr_array, gfn) != entry) {
> 			mixed = true;
> 			break;
> 		}
> 	}
> 	rcu_read_unlock();
> 	return mixed;
> }
> 
> static void update_mem_lpage_info(struct kvm *kvm,
> 				  struct kvm_memory_slot *slot,
> 				  unsigned int attr,
> 				  gfn_t start, gfn_t end)
> {
> 	unsigned long lpage_start, lpage_end;
> 	unsigned long gfn, pages, mask;
> 	int level;
> 
> 	for (level = PG_LEVEL_2M; level <= KVM_MAX_HUGEPAGE_LEVEL; level++) {
> 		pages = KVM_PAGES_PER_HPAGE(level);
> 		mask = ~(pages - 1);
> 		lpage_start = start & mask;
> 		lpage_end = (end - 1) & mask;
> 
> 		/*
> 		 * We only need to scan the head and tail page, for middle pages
> 		 * we know they are not mixed.
> 		 */
> 		update_mixed(lpage_info_slot(lpage_start, slot, level),
> 			     mem_attr_is_mixed(kvm, slot, level,
> 					       lpage_start, lpage_start + pages));
> 
> 		if (lpage_start == lpage_end)
> 			return;
> 
> 		for (gfn = lpage_start + pages; gfn < lpage_end; gfn += pages)
> 			update_mixed(lpage_info_slot(gfn, slot, level), false);
> 
> 		update_mixed(lpage_info_slot(lpage_end, slot, level),
> 			     mem_attr_is_mixed(kvm, slot, level,
> 					       lpage_end, lpage_end + pages));
> 	}
> }
> 
> void kvm_arch_update_mem_attr(struct kvm *kvm, unsigned int attr,
> 			      gfn_t start, gfn_t end)
> {
> 	struct kvm_memory_slot *slot;
> 	struct kvm_memslots *slots;
> 	struct kvm_memslot_iter iter;
> 	int idx;
> 	int i;
> 
> 	WARN_ONCE(!(attr & (KVM_MEM_ATTR_PRIVATE | KVM_MEM_ATTR_SHARED)),
> 		  "Unsupported mem attribute.\n");
> 
> 	idx = srcu_read_lock(&kvm->srcu);
> 	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
> 		slots = __kvm_memslots(kvm, i);
> 
> 		kvm_for_each_memslot_in_gfn_range(&iter, slots, start, end) {
> 			slot = iter.slot;
> 			start = max(start, slot->base_gfn);
> 			end = min(end, slot->base_gfn + slot->npages);
> 			if (WARN_ON_ONCE(start >= end))
> 				continue;
> 
> 			update_mem_lpage_info(kvm, slot, attr, start, end);
> 		}
> 	}
> 	srcu_read_unlock(&kvm->srcu, idx);
> }
> #endif
> 
> 
> -- 
> Isaku Yamahata <isaku.yamahata@gmail.com>
