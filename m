Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B963D6778C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 11:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjAWKMd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 05:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbjAWKMb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 05:12:31 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE6517166;
        Mon, 23 Jan 2023 02:11:44 -0800 (PST)
Received: from [192.168.10.12] (unknown [39.45.186.163])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 917396600879;
        Mon, 23 Jan 2023 10:11:26 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674468695;
        bh=u+v0ZVBPX5gJCfq0pAD2uZvj+jovmR0YkwYSGUDWX4M=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=jFj13RK/PFud3EBAnKhWTD/id3T3zHS6lbX84Kx/42ayZ8z9EaNXtabtcuvgNcQqa
         LZ3DkhbjcOzsoLWBiHjNB85NSfDEgXvlV8G/zGpLZxmUEBDOKRGQu4v08+k6VWQv7L
         v5/kjgDnp/EhO/2CHkXyqjiz6Oq4p47CvNrKuazzONofbMT/3+1c7nxJylfkP6w7WW
         WEpGWSX73RnEo/3jJuPmZKBueeLt4hTGlPv8fmst4mlsAPrikhnN38Ro0dWv/T32l8
         hMNZSfOhmZ9QX9+Zppf0Vyshkeikd/En/yDcZ2YwufNT0hgIZKcuybt8AHtWgdMU+6
         dnCHz1Kjz4eCA==
Message-ID: <328f54c1-171f-22a1-10c9-8b7a25bd8027@collabora.com>
Date:   Mon, 23 Jan 2023 15:11:20 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WC?= =?UTF-8?Q?aw?= 
        <emmir@google.com>, Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v7 1/4] userfaultfd: Add UFFD WP Async support
To:     Peter Xu <peterx@redhat.com>
References: <20230109064519.3555250-1-usama.anjum@collabora.com>
 <20230109064519.3555250-2-usama.anjum@collabora.com> <Y8gkY8OlnOwvlkj4@x1n>
 <0bed5911-48b9-0cc2-dfcf-d3bc3b0e8388@collabora.com> <Y8lxW5YtD6MX61WD@x1n>
 <Y8qq0dKIJBshua+X@x1n>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <Y8qq0dKIJBshua+X@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/20/23 7:53 PM, Peter Xu wrote:
> On Thu, Jan 19, 2023 at 11:35:39AM -0500, Peter Xu wrote:
>> On Thu, Jan 19, 2023 at 08:09:52PM +0500, Muhammad Usama Anjum wrote:
>>
>> [...]
>>
>>>>> @@ -497,80 +498,93 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
>>>>>  
>>>>>  	/* take the reference before dropping the mmap_lock */
>>>>>  	userfaultfd_ctx_get(ctx);
>>>>> +	if (ctx->async) {
>>>>
>>>> Firstly, please consider not touching the existing code/indent as much as
>>>> what this patch did.  Hopefully we can keep the major part of sync uffd be
>>>> there with its git log, it also helps reviewing your code.  You can add the
>>>> async block before that, handle the fault and return just earlier.
>>> This is possible. Will do in next revision.
>>>
>>>>
>>>> And, I think this is a bit too late because we're going to return with
>>>> VM_FAULT_RETRY here, while maybe we don't need to retry at all here because
>>>> we're going to resolve the page fault immediately.
>>>>
>>>> I assume you added this because you wanted userfaultfd_ctx_get() to make
>>>> sure the uffd context will not go away from under us, but it's not needed
>>>> if we're still holding the mmap read lock.  I'd expect for async mode we
>>>> don't really need to release it at all.
>>> I'll have to check the what should be returned here. We should return
>>> something which shows that the fault has been resolved.
>>
>> VM_FAULT_NOPAGE may be the best to describe it, but I guess it shouldn't
>> have a difference here if to just return zero.  And, I guess you don't even
>> need to worry on the retval here because I think you can leverage do_wp_page.
>> More below.
Yeah, this has been changed with your below patch.

>>
>>>
>>>>
>>>>> +		// Resolve page fault of this page
>>>>
>>>> Please use "/* ... */" as that's the common pattern of commenting in the
>>>> Linux kernel, at least what I see in mm/.
>>> Will do.
>>>
>>>>
>>>>> +		unsigned long addr = (ctx->features & UFFD_FEATURE_EXACT_ADDRESS) ?
>>>>> +				      vmf->real_address : vmf->address;
>>>>> +		struct vm_area_struct *dst_vma = find_vma(ctx->mm, addr);
>>>>> +		size_t s = PAGE_SIZE;
>>>>
>>>> This is weird - if we want async uffd-wp, let's consider huge page from the
>>>> 1st day.
>>>>
>>>>> +
>>>>> +		if (dst_vma->vm_flags & VM_HUGEPAGE) {
>>>>
>>>> VM_HUGEPAGE is only a hint.  It doesn't mean this page is always a huge
>>>> page.  For anon, we can have thp wr-protected as a whole, not happening for
>>>> !anon because we'll split already.
>>>>
>>>> For anon, if a write happens to a thp being uffd-wp-ed, we'll keep that pmd
>>>> wr-protected and report the uffd message.  The pmd split happens when the
>>>> user invokes UFFDIO_WRITEPROTECT on the small page.  I think it'll stop
>>>> working for async uffd-wp because we're going to resolve the page faults
>>>> right away.
>>>>
>>>> So for async uffd-wp (note: this will be different from hugetlb), you may
>>>> want to consider having a pre-requisite patch to change wp_huge_pmd()
>>>> behavior: rather than calling handle_userfault(), IIUC you can also just
>>>> fallback to the split path right below (__split_huge_pmd) so the thp will
>>>> split now even before the uffd message is generated.
>>> I'll make the changes and make this. I wasn't aware that the thp is being
>>> broken in the UFFD WP. At this time, I'm not sure if thp will be handled by
>>> handle_userfault() in one go. Probably it will as the length is stored in
>>> the vmf.
>>
>> Yes I think THP can actually be handled in one go with uffd-wp anon (even
>> if vmf doesn't store any length because page fault is about address only
>> not length, afaict).  E.g. thp firstly get wr-protected in thp size, then
>> when unprotect the user app sends UFFDIO_WRITEPROTECT(wp=false) with a
>> range covering the whole thp.
>>
>> But AFAIU that should be quite rare because most uffd-wp scenarios are
>> latency sensitive, resolving page faults in large chunk definitely enlarges
>> that.  It could happen though when it's not resolving an immediate page
>> fault, so it could happen in the background.
>>
>> So after a second thought, a safer approach is we only go to the split path
>> if async is enabled, in wp_huge_pmd().  Then it doesn't need to be a
>> pre-requisite patch too, it can be part of the major patch to implement the
>> uffd-wp async mode.
>>
>>>
>>>>
>>>> I think it should be transparent to the user and it'll start working for
>>>> you with async uffd-wp here, because it means when reaching
>>>> handle_userfault, it should not be possible to have thp at all since they
>>>> should have all split up.
>>>>
>>>>> +			s = HPAGE_SIZE;
>>>>> +			addr &= HPAGE_MASK;
>>>>> +		}
>>>>>  
>>>>> -	init_waitqueue_func_entry(&uwq.wq, userfaultfd_wake_function);
>>>>> -	uwq.wq.private = current;
>>>>> -	uwq.msg = userfault_msg(vmf->address, vmf->real_address, vmf->flags,
>>>>> -				reason, ctx->features);
>>>>> -	uwq.ctx = ctx;
>>>>> -	uwq.waken = false;
>>>>> -
>>>>> -	blocking_state = userfaultfd_get_blocking_state(vmf->flags);
>>>>> +		ret = mwriteprotect_range(ctx->mm, addr, s, false, &ctx->mmap_changing);
>>>>
>>>> This is an overkill - we're pretty sure it's a single page, no need to call
>>>> a range function here.
>>> Probably change_pte_range() should be used here to directly remove the WP here?
>>
>> Here we can persue the best performance, or we can also persue the easist
>> way to implement.  I think the best we can have is we don't release either
>> the mmap read lock _and_ the pgtable lock, so we resolve the page fault
>> completely here.  But that requires more code changes.
>>
>> So far an probably intermediate (and very easy to implement) solution is:
>>
>> (1) Remap the pte (vmf->pte) and retake the lock (vmf->ptl).  Note: you
>>     need to move the chunk to be before mmap read lock released first,
>>     because we'll need that to make sure pgtable lock and the pgtable page
>>     being still exist at the first place.
>>
>> (2) If *vmf->pte != vmf->orig_pte, it means the pgtable changed, retry
>>     (with VM_FAULT_NOPAGE).  We must have orig_pte set btw in this path.
>>
>> (2) Remove the uffd-wp bit if it's set (and it must be set, because we
>>     checked again on orig_pte with pgtable lock held).
>>
>> (3) Invoke do_wp_page() again with the same vmf.
>>
>> This will focus the resolution on the single page and resolve CoW in one
>> shot if needed.  We may need to redo the map/lock of pte* but I suppose it
>> won't hurt a lot if we just modified the fields anyway, so we can leave
>> that for later.
> 
> I just noticed it's actually quite straigtforward to just not fall into
> handle_userfault at all.  It can be as simple as:
> 
> ---8<---
> diff --git a/mm/memory.c b/mm/memory.c
> index 4000e9f017e0..09aab434654c 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3351,8 +3351,20 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
> 
>         if (likely(!unshare)) {
>                 if (userfaultfd_pte_wp(vma, *vmf->pte)) {
> -                       pte_unmap_unlock(vmf->pte, vmf->ptl);
> -                       return handle_userfault(vmf, VM_UFFD_WP);
> +                       if (userfaultfd_uffd_wp_async(vma)) {
> +                               /*
> +                                * Nothing needed (cache flush, TLB
> +                                * invalidations, etc.) because we're only
> +                                * removing the uffd-wp bit, which is
> +                                * completely invisible to the user.
> +                                * This falls through to possible CoW.
> +                                */
> +                               set_pte_at(vma->vm_mm, vmf->address, vmf->pte,
> +                                          pte_clear_uffd_wp(*vmf->pte));
> +                       } else {
> +                               pte_unmap_unlock(vmf->pte, vmf->ptl);
> +                               return handle_userfault(vmf, VM_UFFD_WP);
> +                       }
>                 }
> ---8<---
> 
> Similar thing will be needed for hugetlb if that'll be supported.
At the moment, hugetlb support is required. Thank you so much for sending
this up. This has made things simple. I've replicated this same patch in
wp_huge_pmd() for huge pages.

> 
> One thing worth mention is, I think for async wp it doesn't need to be
> restricted by UFFD_USER_MODE_ONLY, because comparing to the sync messages
> it has no risk of being utilized for malicious purposes.
I think with updated handling path updated in do_wp_page() and
wp_huge_pmd() in version, UFFD_USER_MODE_ONLY will not affect us.

> 
>>
>> [...]
>>
>>>> Then when the app wants to wr-protect in async mode, it simply goes ahead
>>>> with UFFDIO_WRITEPROTECT(wp=true), it'll happen exactly the same as when it
>>>> was sync mode.  It's only the pf handling procedure that's different (along
>>>> with how the fault is reported - rather than as a message but it'll be
>>>> consolidated into the soft-dirty bit).
>>> PF handling will resovle the fault after un-setting the _PAGE_*_UFFD_WP on
>>> the page. I'm not changing the soft-dirty bit. It is too delicate (if you
>>> get the joke).
>>
>> It's unfortunate that the old soft-dirty solution didn't go through easily.
>> Soft-dirty still covers something that uffd-wp cannot do right now, e.g. on
>> tracking mostly any type of pte mappings.  Uffd-wp can so far only track
>> fully ram backed pages like shmem or hugetlb for files but not any random
>> page cache.  Hopefully it still works at least for your use case, or it's
>> time to rethink otherwise.
>>
>>>
>>>>
>>>>>  
>>>>>  	if (mode_wp && mode_dontwake)
>>>>>  		return -EINVAL;
>>>>> @@ -2126,6 +2143,7 @@ static int new_userfaultfd(int flags)
>>>>>  	ctx->flags = flags;
>>>>>  	ctx->features = 0;
>>>>>  	ctx->released = false;
>>>>> +	ctx->async = false;
>>>>>  	atomic_set(&ctx->mmap_changing, 0);
>>>>>  	ctx->mm = current->mm;
>>>>>  	/* prevent the mm struct to be freed */
>>>>> diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
>>>>> index 005e5e306266..b89665653861 100644
>>>>> --- a/include/uapi/linux/userfaultfd.h
>>>>> +++ b/include/uapi/linux/userfaultfd.h
>>>>> @@ -284,6 +284,11 @@ struct uffdio_writeprotect {
>>>>>   * UFFDIO_WRITEPROTECT_MODE_DONTWAKE: set the flag to avoid waking up
>>>>>   * any wait thread after the operation succeeds.
>>>>>   *
>>>>> + * UFFDIO_WRITEPROTECT_MODE_ASYNC_WP: set the flag to write protect a
>>>>> + * range, the flag is unset automatically when the page is written.
>>>>> + * This is used to track which pages have been written to from the
>>>>> + * time the memory was write protected.
>>>>> + *
>>>>>   * NOTE: Write protecting a region (WP=1) is unrelated to page faults,
>>>>>   * therefore DONTWAKE flag is meaningless with WP=1.  Removing write
>>>>>   * protection (WP=0) in response to a page fault wakes the faulting
>>>>> @@ -291,6 +296,7 @@ struct uffdio_writeprotect {
>>>>>   */
>>>>>  #define UFFDIO_WRITEPROTECT_MODE_WP		((__u64)1<<0)
>>>>>  #define UFFDIO_WRITEPROTECT_MODE_DONTWAKE	((__u64)1<<1)
>>>>> +#define UFFDIO_WRITEPROTECT_MODE_ASYNC_WP	((__u64)1<<2)
>>>>>  	__u64 mode;
>>>>>  };
>>>>>  
>>>>> -- 
>>>>> 2.30.2
>>>>>
>>>>
>>>
>>> I should have added Suggested-by: Peter Xy <peterx@redhat.com> to this
>>> patch. I'll add in the next revision if you don't object.
>>
>> I'm fine with it.  If so, please do s/Xy/Xu/.
Sorry,

Suggested-by: Peter Xu <peterx@redhat.com>

>>
>>>
>>> I've started working on next revision. I'll reply to other highly valuable
>>> review emails a bit later.
>>
>> Thanks,
>>
>> -- 
>> Peter Xu
> 

-- 
BR,
Muhammad Usama Anjum
