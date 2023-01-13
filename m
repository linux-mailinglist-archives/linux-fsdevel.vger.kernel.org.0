Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B754F66A713
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jan 2023 00:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjAMX3j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 18:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbjAMX3h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 18:29:37 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74418CBE1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 15:29:35 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id q64so23879123pjq.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 15:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQbX+PJeFGPE/epzSLyMXyeM3puvzgeaNuzCa8J0EXw=;
        b=KI84PoD5hlyAFNUuR0aDNZVOeTIPetcODuXQFOLsthx0M9PBbd4Ii4NEbvq7AksXu7
         toZuH3SuWrDmOxlRgY9v/sD5jNWPLQf6dKrCbnokAUAIQEtbRDiSfZWcl/1I3UQVFAEb
         a6/l7wl7AA00DOx0ry/KDkad9zplSEVZSJFkd/VMKfI133Y6qU9QwZssXXrbCDw5Nb9m
         dzGrv28dPEYNNVmjwYaPASFLrerbq2hEC4XqdUUCBoLLJ4B4Gtckq/k2ywJKN2rpzvVv
         ocA532ET5RmMjB9lD97Ske8J4o2bErglLd6L5RaQkIXwXXqhqMDkO9X/qFp6RwMMIFsr
         LLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQbX+PJeFGPE/epzSLyMXyeM3puvzgeaNuzCa8J0EXw=;
        b=wi1BQtSZoNIIq0sNcJ1rEaZw3sg5KqZYXV8Pe/741ytNsxO9miUBoVtRi2IjpNpuLS
         OHFmTCQcWIafbh4YHQKOtvun7TIqQT4mUnHFfOYh2F8sbU3pTwPxHU5WuDpFMlYF1sy6
         ZjxJwH46WhINZvmY9Gqbp4vPtxDCV4MzjQC1mL1Mm2tapOnyhddSgChV6M+6kPJzYFIL
         3ogQN6t/Zprt2KWeOYRYw/4zxVE7zKhf7wFD/73MWOJd4SyXLIejK6QXsAmRmmbB7bwf
         hiZTH85T/HQsUXqMIvdgNHKEcE/+QHtelYcuK7oTpn+4UgF7sBCsoFjv0kKL/glWbor7
         Tyiw==
X-Gm-Message-State: AFqh2kpakluJqRjm0g0dAAD4/Zv4WImusw4eMblPzGCnVuSGBOuGbSBz
        HFCCKiFKZjbbR522juMsRU3POw==
X-Google-Smtp-Source: AMrXdXuw7u5n3rdsoSl403MwiroTsQpSA4OUWBZMOT9napmmz7jBR90tsEYJogYGPCeapKIvBrQTcA==
X-Received: by 2002:a17:902:d409:b0:189:6624:58c0 with SMTP id b9-20020a170902d40900b00189662458c0mr1300675ple.3.1673652575167;
        Fri, 13 Jan 2023 15:29:35 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090311ce00b00189c536c72asm14777597plh.148.2023.01.13.15.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 15:29:34 -0800 (PST)
Date:   Fri, 13 Jan 2023 23:29:31 +0000
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
Subject: Re: [PATCH v10 8/9] KVM: Handle page fault for private memory
Message-ID: <Y8HpW9VNVlIdiH+P@google.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-9-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202061347.1070246-9-chao.p.peng@linux.intel.com>
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

On Fri, Dec 02, 2022, Chao Peng wrote:
> @@ -5599,6 +5652,9 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 err
>  			return -EIO;
>  	}
>  
> +	if (r == RET_PF_USER)
> +		return 0;
> +
>  	if (r < 0)
>  		return r;
>  	if (r != RET_PF_EMULATE)
> @@ -6452,7 +6508,8 @@ static bool kvm_mmu_zap_collapsible_spte(struct kvm *kvm,
>  		 */
>  		if (sp->role.direct &&
>  		    sp->role.level < kvm_mmu_max_mapping_level(kvm, slot, sp->gfn,
> -							       PG_LEVEL_NUM)) {
> +							       PG_LEVEL_NUM,
> +							       false)) {

Passing %false is incorrect.  It might not cause problems because KVM currently
doesn't allowing modifying private memslots (that likely needs to change to allow
dirty logging), but it's wrong since nothing guarantees KVM is operating on SPTEs
for shared memory.

One option would be to take the patches from the TDX series that add a "private"
flag to the shadow page role, but I'd rather not add the role until it's truly
necessary.

For now, I think we can do this without impacting performance of guests that don't
support private memory.

int kvm_mmu_max_mapping_level(struct kvm *kvm,
			      const struct kvm_memory_slot *slot, gfn_t gfn,
			      int max_level)
{
	bool is_private = kvm_slot_can_be_private(slot) &&
			  kvm_mem_is_private(kvm, gfn);

	return __kvm_mmu_max_mapping_level(kvm, slot, gfn, max_level, is_private);
}

> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 25099c94e770..153842bb33df 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2335,4 +2335,34 @@ static inline void kvm_arch_set_memory_attributes(struct kvm *kvm,
>  }
>  #endif /* __KVM_HAVE_ARCH_SET_MEMORY_ATTRIBUTES */
>  
> +#ifdef CONFIG_HAVE_KVM_MEMORY_ATTRIBUTES
> +static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
> +{

This code, i.e. the generic KVM changes, belongs in a separate patch.  It'll be
small, but I want to separate x86's page fault changes from the restrictedmem
support adding to common KVM.

This should also short-circuit based on CONFIG_HAVE_KVM_RESTRICTED_MEM, though
I would name that CONFIG_KVM_PRIVATE_MEMORY since in KVM's world, it's all about
private vs. shared at this time.

> +	return xa_to_value(xa_load(&kvm->mem_attr_array, gfn)) &
> +	       KVM_MEMORY_ATTRIBUTE_PRIVATE;
> +}
> +#else
> +static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
> +{
> +	return false;
> +}
> +
> +#endif /* CONFIG_HAVE_KVM_MEMORY_ATTRIBUTES */
> +
> +#ifdef CONFIG_HAVE_KVM_RESTRICTED_MEM
> +static inline int kvm_restricted_mem_get_pfn(struct kvm_memory_slot *slot,
> +					gfn_t gfn, kvm_pfn_t *pfn, int *order)
> +{
> +	int ret;
> +	struct page *page;
> +	pgoff_t index = gfn - slot->base_gfn +
> +			(slot->restricted_offset >> PAGE_SHIFT);
> +
> +	ret = restrictedmem_get_page(slot->restricted_file, index,
> +				     &page, order);

This needs handle errors.  If "ret" is non-zero, "page" is garbage.

> +	*pfn = page_to_pfn(page);
> +	return ret;
> +}
> +#endif /* CONFIG_HAVE_KVM_RESTRICTED_MEM */
> +
>  #endif
> -- 
> 2.25.1
> 
