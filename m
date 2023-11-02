Return-Path: <linux-fsdevel+bounces-1789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8779E7DECAB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 07:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B60871C20EA1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 06:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AD55240;
	Thu,  2 Nov 2023 06:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OiUIPTMY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8F1187A;
	Thu,  2 Nov 2023 06:00:11 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0217FD7;
	Wed,  1 Nov 2023 23:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698904807; x=1730440807;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ou5/8bq0/RVZthvT/yQo+QsMVA9om+MCO0TErMQh5Kw=;
  b=OiUIPTMYdM3Qa7HpDEbjmeZjJDIhxPjHoNLRTODRHbP+kCowzQ1Q2xfF
   g9fbUSi8hz0O7rvlE4GC2vwJvYEWPR5r0RhH64NbcacAsGiZFoRL/y/WO
   DBaz0+yxMxQJEWHe6zuNISMzNLvz65QHE4zh6wIbHpjU/Tx598YMKL/cl
   zTB2EhyGiw86ZpkM6mFPU62OfY1bexN5tsvlGTOjekPiXdRT55sA3jyU4
   BUfAgNMiBGYIhefuHzOkcaDkDaGG3mqrojqBzQJQw/PJ7xFFodReSx5sx
   zykyYeYTcNAftpAr1U7+6ZSl73RtoKQhDED8Jsv1y7f0cU7g14oAz+tV9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="10174671"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; 
   d="scan'208";a="10174671"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 23:00:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="884777553"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; 
   d="scan'208";a="884777553"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.238.2.253]) ([10.238.2.253])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 22:59:55 -0700
Message-ID: <9963b77c-3a38-4f89-b21e-48d0fdda8f53@linux.intel.com>
Date: Thu, 2 Nov 2023 13:59:53 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 12/35] KVM: Prepare for handling only shared mappings
 in mmu_notifier events
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>, Huacai Chen <chenhuacai@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Anup Patel <anup@brainfault.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 Fuad Tabba <tabba@google.com>, Jarkko Sakkinen <jarkko@kernel.org>,
 Anish Moorthy <amoorthy@google.com>, David Matlack <dmatlack@google.com>,
 Yu Zhang <yu.c.zhang@linux.intel.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8?=
 =?UTF-8?Q?n?= <mic@digikod.net>, Vlastimil Babka <vbabka@suse.cz>,
 Vishal Annapurve <vannapurve@google.com>,
 Ackerley Tng <ackerleytng@google.com>,
 Maciej Szmigiero <mail@maciej.szmigiero.name>,
 David Hildenbrand <david@redhat.com>, Quentin Perret <qperret@google.com>,
 Michael Roth <michael.roth@amd.com>, Wang <wei.w.wang@intel.com>,
 Liam Merwick <liam.merwick@oracle.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20231027182217.3615211-1-seanjc@google.com>
 <20231027182217.3615211-13-seanjc@google.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20231027182217.3615211-13-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/28/2023 2:21 AM, Sean Christopherson wrote:
> Add flags to "struct kvm_gfn_range" to let notifier events target only
> shared and only private mappings, and write up the existing mmu_notifier
> events to be shared-only (private memory is never associated with a
> userspace virtual address, i.e. can't be reached via mmu_notifiers).
>
> Add two flags so that KVM can handle the three possibilities (shared,
> private, and shared+private) without needing something like a tri-state
> enum.
I see the two flags are set/cleared in __kvm_handle_hva_range() in this 
patch
and kvm_handle_gfn_range() from the later patch 13/35, but I didn't see they
are used/read in this patch series if I didn't miss anything.  How are they
supposed to be used in KVM?


>
> Link: https://lore.kernel.org/all/ZJX0hk+KpQP0KUyB@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   include/linux/kvm_host.h | 2 ++
>   virt/kvm/kvm_main.c      | 7 +++++++
>   2 files changed, 9 insertions(+)
>
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 96aa930536b1..89c1a991a3b8 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -263,6 +263,8 @@ struct kvm_gfn_range {
>   	gfn_t start;
>   	gfn_t end;
>   	union kvm_mmu_notifier_arg arg;
> +	bool only_private;
> +	bool only_shared;
>   	bool may_block;
>   };
>   bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range);
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index cb9376833c18..302ccb87b4c1 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -635,6 +635,13 @@ static __always_inline kvm_mn_ret_t __kvm_handle_hva_range(struct kvm *kvm,
>   			 * the second or later invocation of the handler).
>   			 */
>   			gfn_range.arg = range->arg;
> +
> +			/*
> +			 * HVA-based notifications aren't relevant to private
> +			 * mappings as they don't have a userspace mapping.
> +			 */
> +			gfn_range.only_private = false;
> +			gfn_range.only_shared = true;
>   			gfn_range.may_block = range->may_block;
>   
>   			/*


