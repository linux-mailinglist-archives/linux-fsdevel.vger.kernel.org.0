Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D960978F77F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Sep 2023 05:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348241AbjIADqA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 23:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjIADp6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 23:45:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FE8CF;
        Thu, 31 Aug 2023 20:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693539955; x=1725075955;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dQBtg8NKz/pLl187/eYnyafMQC+Yh2bQyqEr25y1Bps=;
  b=YohkZfL/VAzFFK4DnQgPAOhLhLKGcEGkSsltUkZoqX6ps4L1oo/n/OlH
   MfU1vWVDkc0DzwD3vOh3SlOYlvK/2rP0qrvyilkweAPDQoy+b+0mv6FgB
   UVIZsqaYLSL1NdxJKKacODvufJN3BAQWTSKAmNJApvdsD4wgqwa+GRQ1n
   Rg0iCPE6y/XwoO6pykO0wSVTZ8tmHr+LM0f4Iz8sJ4PiGOe22oqAFaYZR
   QkQhUiDLoKkz+5m2TWByGmqko6ngu+2JYHyosMjHmRvgxuElgoo7bDGoU
   7srBZZJchfebDtsUE0PMpRYTUonR/OBSN65g3XjwOV8ZjqFb7QW/I9rrf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="356441896"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="356441896"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 20:45:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="742962743"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="742962743"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.93.2.44]) ([10.93.2.44])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 20:45:45 -0700
Message-ID: <f7aaf097-6f83-0ee9-e16d-713d392b2299@linux.intel.com>
Date:   Fri, 1 Sep 2023 11:45:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH v11 12/29] KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for
 guest-specific backing memory
To:     Ackerley Tng <ackerleytng@google.com>
Cc:     seanjc@google.com, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com, maz@kernel.org,
        oliver.upton@linux.dev, chenhuacai@kernel.org, mpe@ellerman.id.au,
        anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, willy@infradead.org,
        akpm@linux-foundation.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, chao.p.peng@linux.intel.com, tabba@google.com,
        jarkko@kernel.org, yu.c.zhang@linux.intel.com,
        vannapurve@google.com, mail@maciej.szmigiero.name, vbabka@suse.cz,
        david@redhat.com, qperret@google.com, michael.roth@amd.com,
        wei.w.wang@intel.com, liam.merwick@oracle.com,
        isaku.yamahata@gmail.com, kirill.shutemov@linux.intel.com
References: <diqz5y4wfpj0.fsf@ackerleytng-ctop.c.googlers.com>
From:   Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <diqz5y4wfpj0.fsf@ackerleytng-ctop.c.googlers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/31/2023 12:44 AM, Ackerley Tng wrote:
> Binbin Wu <binbin.wu@linux.intel.com> writes:
>
>>> <snip>
>>>
>>> +static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
>>> +{
>>> +	struct address_space *mapping = inode->i_mapping;
>>> +	pgoff_t start, index, end;
>>> +	int r;
>>> +
>>> +	/* Dedicated guest is immutable by default. */
>>> +	if (offset + len > i_size_read(inode))
>>> +		return -EINVAL;
>>> +
>>> +	filemap_invalidate_lock_shared(mapping);
>>> +
>>> +	start = offset >> PAGE_SHIFT;
>>> +	end = (offset + len) >> PAGE_SHIFT;
>>> +
>>> +	r = 0;
>>> +	for (index = start; index < end; ) {
>>> +		struct folio *folio;
>>> +
>>> +		if (signal_pending(current)) {
>>> +			r = -EINTR;
>>> +			break;
>>> +		}
>>> +
>>> +		folio = kvm_gmem_get_folio(inode, index);
>>> +		if (!folio) {
>>> +			r = -ENOMEM;
>>> +			break;
>>> +		}
>>> +
>>> +		index = folio_next_index(folio);
>>> +
>>> +		folio_unlock(folio);
>>> +		folio_put(folio);
>> May be a dumb question, why we get the folio and then put it immediately?
>> Will it make the folio be released back to the page allocator?
>>
> I was wondering this too, but it is correct.
>
> In filemap_grab_folio(), the refcount is incremented in three places:
>
> + When the folio is created in filemap_alloc_folio(), it is given a
>    refcount of 1 in
>
>      filemap_alloc_folio() -> folio_alloc() -> __folio_alloc_node() ->
>      __folio_alloc() -> __alloc_pages() -> get_page_from_freelist() ->
>      prep_new_page() -> post_alloc_hook() -> set_page_refcounted()
>
> + Then, in filemap_add_folio(), the refcount is incremented twice:
>
>      + The first is from the filemap (1 refcount per page if this is a
>        hugepage):
>
>          filemap_add_folio() -> __filemap_add_folio() -> folio_ref_add()
>
>      + The second is a refcount from the lru list
>
>          filemap_add_folio() -> folio_add_lru() -> folio_get() ->
>          folio_ref_inc()
>
> In the other path, if the folio exists in the page cache (filemap), the
> refcount is also incremented through
>
>      filemap_grab_folio() -> __filemap_get_folio() -> filemap_get_entry()
>      -> folio_try_get_rcu()
>
> I believe all the branches in kvm_gmem_get_folio() are taking a refcount
> on the folio while the kernel does some work on the folio like clearing
> the folio in clear_highpage() or getting the next index, and then when
> done, the kernel does folio_put().
>
> This pattern is also used in shmem and hugetlb. :)

Thanks for your explanation. It helps a lot.

>
> I'm not sure whose refcount the folio_put() in kvm_gmem_allocate() is
> dropping though:
>
> + The refcount for the filemap depends on whether this is a hugepage or
>    not, but folio_put() strictly drops a refcount of 1.
> + The refcount for the lru list is just 1, but doesn't the page still
>    remain in the lru list?

I guess the refcount drop here is the one get on the fresh allocation.
Now the filemap has grabbed the folio, so the lifecycle of the folio now 
is decided by the filemap/inode?

>
>>> +
>>> +		/* 64-bit only, wrapping the index should be impossible. */
>>> +		if (WARN_ON_ONCE(!index))
>>> +			break;
>>> +
>>> +		cond_resched();
>>> +	}
>>> +
>>> +	filemap_invalidate_unlock_shared(mapping);
>>> +
>>> +	return r;
>>> +}
>>> +
>>>
>>> <snip>

