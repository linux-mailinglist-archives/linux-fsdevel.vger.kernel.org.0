Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A244E673D2A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 16:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjASPKU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 10:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjASPKS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 10:10:18 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C706797F;
        Thu, 19 Jan 2023 07:10:05 -0800 (PST)
Received: from [192.168.10.12] (unknown [39.45.186.163])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8B0B366003B1;
        Thu, 19 Jan 2023 15:09:57 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674141004;
        bh=+9EQfFr+ASzmxjKMcZmvBS5xXcamlLlj63358f2o14M=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=lTKkANzKMqyu/IY9WO++UPpurbhOvsmjKsmVWgSVhXB6h6BE4eXhxKQllMdY+3yxV
         AsOlK6t3Hb6nHnE3nztGj8rMHVSo4X4eAV7BVQ+XrNBxNuSyhH/N5q+x95OcniFjJH
         p1Wyu0ECzWX988hviCiSVHe9/j76KDMsnSwVM74HZSTkI8Tb8e7APfF783P+B697Ge
         BTQggwtNYD8L2zAiXh9XOOpSYEuc5GhYMwnz4Eo2Zf2vWUF741vPpHEOgICrZlqcxD
         wpZWiaNyVGxi0WxGb2eUht85sBWOGMS9uLaGyk2wP1dU9xYYag7Xi8E+C317JdadBa
         zsDc4tHjdooQw==
Message-ID: <0bed5911-48b9-0cc2-dfcf-d3bc3b0e8388@collabora.com>
Date:   Thu, 19 Jan 2023 20:09:52 +0500
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
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
References: <20230109064519.3555250-1-usama.anjum@collabora.com>
 <20230109064519.3555250-2-usama.anjum@collabora.com> <Y8gkY8OlnOwvlkj4@x1n>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <Y8gkY8OlnOwvlkj4@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Peter,

Thank you so much for reviewing.

On 1/18/23 9:54 PM, Peter Xu wrote:
> Hi, Muhammad,
> 
> On Mon, Jan 09, 2023 at 11:45:16AM +0500, Muhammad Usama Anjum wrote:
>> Add new WP Async mode (UFFDIO_WRITEPROTECT_MODE_ASYNC_WP) which resolves
>> the page faults on its own. It can be used to track that which pages have
>> been written to from the time the pages were write protected. It is very
>> efficient way to track the changes as uffd is by nature pte/pmd based.
>>
>> UFFD WP (UFFDIO_WRITEPROTECT_MODE_WP) sends the page faults to the
>> userspace where the pages which have been written-to can be tracked. But
>> it is not efficient. This is why this async version is being added.
>> After setting the WP Async, the pages which have been written to can be
>> found in the pagemap file or information can be obtained from the
>> PAGEMAP_IOCTL (see next patches).
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>  fs/userfaultfd.c                 | 150 +++++++++++++++++--------------
>>  include/uapi/linux/userfaultfd.h |   6 ++
>>  2 files changed, 90 insertions(+), 66 deletions(-)
>>
>> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
>> index 15a5bf765d43..be5e10d15058 100644
>> --- a/fs/userfaultfd.c
>> +++ b/fs/userfaultfd.c
>> @@ -69,6 +69,7 @@ struct userfaultfd_ctx {
>>  	unsigned int features;
>>  	/* released */
>>  	bool released;
>> +	bool async;
> 
> Let's just make it a feature flag,
> 
>   UFFD_FEATURE_WP_ASYNC
This would really make things easier. Thank you so much for suggesting it.

> 
>>  	/* memory mappings are changing because of non-cooperative event */
>>  	atomic_t mmap_changing;
>>  	/* mm with one ore more vmas attached to this userfaultfd_ctx */
>> @@ -497,80 +498,93 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
>>  
>>  	/* take the reference before dropping the mmap_lock */
>>  	userfaultfd_ctx_get(ctx);
>> +	if (ctx->async) {
> 
> Firstly, please consider not touching the existing code/indent as much as
> what this patch did.  Hopefully we can keep the major part of sync uffd be
> there with its git log, it also helps reviewing your code.  You can add the
> async block before that, handle the fault and return just earlier.
This is possible. Will do in next revision.

> 
> And, I think this is a bit too late because we're going to return with
> VM_FAULT_RETRY here, while maybe we don't need to retry at all here because
> we're going to resolve the page fault immediately.
> 
> I assume you added this because you wanted userfaultfd_ctx_get() to make
> sure the uffd context will not go away from under us, but it's not needed
> if we're still holding the mmap read lock.  I'd expect for async mode we
> don't really need to release it at all.
I'll have to check the what should be returned here. We should return
something which shows that the fault has been resolved.

> 
>> +		// Resolve page fault of this page
> 
> Please use "/* ... */" as that's the common pattern of commenting in the
> Linux kernel, at least what I see in mm/.
Will do.

> 
>> +		unsigned long addr = (ctx->features & UFFD_FEATURE_EXACT_ADDRESS) ?
>> +				      vmf->real_address : vmf->address;
>> +		struct vm_area_struct *dst_vma = find_vma(ctx->mm, addr);
>> +		size_t s = PAGE_SIZE;
> 
> This is weird - if we want async uffd-wp, let's consider huge page from the
> 1st day.
> 
>> +
>> +		if (dst_vma->vm_flags & VM_HUGEPAGE) {
> 
> VM_HUGEPAGE is only a hint.  It doesn't mean this page is always a huge
> page.  For anon, we can have thp wr-protected as a whole, not happening for
> !anon because we'll split already.
> 
> For anon, if a write happens to a thp being uffd-wp-ed, we'll keep that pmd
> wr-protected and report the uffd message.  The pmd split happens when the
> user invokes UFFDIO_WRITEPROTECT on the small page.  I think it'll stop
> working for async uffd-wp because we're going to resolve the page faults
> right away.
> 
> So for async uffd-wp (note: this will be different from hugetlb), you may
> want to consider having a pre-requisite patch to change wp_huge_pmd()
> behavior: rather than calling handle_userfault(), IIUC you can also just
> fallback to the split path right below (__split_huge_pmd) so the thp will
> split now even before the uffd message is generated.
I'll make the changes and make this. I wasn't aware that the thp is being
broken in the UFFD WP. At this time, I'm not sure if thp will be handled by
handle_userfault() in one go. Probably it will as the length is stored in
the vmf.

> 
> I think it should be transparent to the user and it'll start working for
> you with async uffd-wp here, because it means when reaching
> handle_userfault, it should not be possible to have thp at all since they
> should have all split up.
> 
>> +			s = HPAGE_SIZE;
>> +			addr &= HPAGE_MASK;
>> +		}
>>  
>> -	init_waitqueue_func_entry(&uwq.wq, userfaultfd_wake_function);
>> -	uwq.wq.private = current;
>> -	uwq.msg = userfault_msg(vmf->address, vmf->real_address, vmf->flags,
>> -				reason, ctx->features);
>> -	uwq.ctx = ctx;
>> -	uwq.waken = false;
>> -
>> -	blocking_state = userfaultfd_get_blocking_state(vmf->flags);
>> +		ret = mwriteprotect_range(ctx->mm, addr, s, false, &ctx->mmap_changing);
> 
> This is an overkill - we're pretty sure it's a single page, no need to call
> a range function here.
Probably change_pte_range() should be used here to directly remove the WP here?

> 
>> +	} else {
>> +		init_waitqueue_func_entry(&uwq.wq, userfaultfd_wake_function);
>> +		uwq.wq.private = current;
>> +		uwq.msg = userfault_msg(vmf->address, vmf->real_address, vmf->flags,
>> +					reason, ctx->features);
>> +		uwq.ctx = ctx;
>> +		uwq.waken = false;
>>  
>> -        /*
>> -         * Take the vma lock now, in order to safely call
>> -         * userfaultfd_huge_must_wait() later. Since acquiring the
>> -         * (sleepable) vma lock can modify the current task state, that
>> -         * must be before explicitly calling set_current_state().
>> -         */
>> -	if (is_vm_hugetlb_page(vma))
>> -		hugetlb_vma_lock_read(vma);
>> +		blocking_state = userfaultfd_get_blocking_state(vmf->flags);
>>  
>> -	spin_lock_irq(&ctx->fault_pending_wqh.lock);
>> -	/*
>> -	 * After the __add_wait_queue the uwq is visible to userland
>> -	 * through poll/read().
>> -	 */
>> -	__add_wait_queue(&ctx->fault_pending_wqh, &uwq.wq);
>> -	/*
>> -	 * The smp_mb() after __set_current_state prevents the reads
>> -	 * following the spin_unlock to happen before the list_add in
>> -	 * __add_wait_queue.
>> -	 */
>> -	set_current_state(blocking_state);
>> -	spin_unlock_irq(&ctx->fault_pending_wqh.lock);
>> +		/*
>> +		 * Take the vma lock now, in order to safely call
>> +		 * userfaultfd_huge_must_wait() later. Since acquiring the
>> +		 * (sleepable) vma lock can modify the current task state, that
>> +		 * must be before explicitly calling set_current_state().
>> +		 */
>> +		if (is_vm_hugetlb_page(vma))
>> +			hugetlb_vma_lock_read(vma);
>>  
>> -	if (!is_vm_hugetlb_page(vma))
>> -		must_wait = userfaultfd_must_wait(ctx, vmf->address, vmf->flags,
>> -						  reason);
>> -	else
>> -		must_wait = userfaultfd_huge_must_wait(ctx, vma,
>> -						       vmf->address,
>> -						       vmf->flags, reason);
>> -	if (is_vm_hugetlb_page(vma))
>> -		hugetlb_vma_unlock_read(vma);
>> -	mmap_read_unlock(mm);
>> +		spin_lock_irq(&ctx->fault_pending_wqh.lock);
>> +		/*
>> +		 * After the __add_wait_queue the uwq is visible to userland
>> +		 * through poll/read().
>> +		 */
>> +		__add_wait_queue(&ctx->fault_pending_wqh, &uwq.wq);
>> +		/*
>> +		 * The smp_mb() after __set_current_state prevents the reads
>> +		 * following the spin_unlock to happen before the list_add in
>> +		 * __add_wait_queue.
>> +		 */
>> +		set_current_state(blocking_state);
>> +		spin_unlock_irq(&ctx->fault_pending_wqh.lock);
>>  
>> -	if (likely(must_wait && !READ_ONCE(ctx->released))) {
>> -		wake_up_poll(&ctx->fd_wqh, EPOLLIN);
>> -		schedule();
>> -	}
>> +		if (!is_vm_hugetlb_page(vma))
>> +			must_wait = userfaultfd_must_wait(ctx, vmf->address, vmf->flags,
>> +							  reason);
>> +		else
>> +			must_wait = userfaultfd_huge_must_wait(ctx, vma,
>> +							       vmf->address,
>> +							       vmf->flags, reason);
>> +		if (is_vm_hugetlb_page(vma))
>> +			hugetlb_vma_unlock_read(vma);
>> +		mmap_read_unlock(mm);
>> +
>> +		if (likely(must_wait && !READ_ONCE(ctx->released))) {
>> +			wake_up_poll(&ctx->fd_wqh, EPOLLIN);
>> +			schedule();
>> +		}
>>  
>> -	__set_current_state(TASK_RUNNING);
>> +		__set_current_state(TASK_RUNNING);
>>  
>> -	/*
>> -	 * Here we race with the list_del; list_add in
>> -	 * userfaultfd_ctx_read(), however because we don't ever run
>> -	 * list_del_init() to refile across the two lists, the prev
>> -	 * and next pointers will never point to self. list_add also
>> -	 * would never let any of the two pointers to point to
>> -	 * self. So list_empty_careful won't risk to see both pointers
>> -	 * pointing to self at any time during the list refile. The
>> -	 * only case where list_del_init() is called is the full
>> -	 * removal in the wake function and there we don't re-list_add
>> -	 * and it's fine not to block on the spinlock. The uwq on this
>> -	 * kernel stack can be released after the list_del_init.
>> -	 */
>> -	if (!list_empty_careful(&uwq.wq.entry)) {
>> -		spin_lock_irq(&ctx->fault_pending_wqh.lock);
>>  		/*
>> -		 * No need of list_del_init(), the uwq on the stack
>> -		 * will be freed shortly anyway.
>> +		 * Here we race with the list_del; list_add in
>> +		 * userfaultfd_ctx_read(), however because we don't ever run
>> +		 * list_del_init() to refile across the two lists, the prev
>> +		 * and next pointers will never point to self. list_add also
>> +		 * would never let any of the two pointers to point to
>> +		 * self. So list_empty_careful won't risk to see both pointers
>> +		 * pointing to self at any time during the list refile. The
>> +		 * only case where list_del_init() is called is the full
>> +		 * removal in the wake function and there we don't re-list_add
>> +		 * and it's fine not to block on the spinlock. The uwq on this
>> +		 * kernel stack can be released after the list_del_init.
>>  		 */
>> -		list_del(&uwq.wq.entry);
>> -		spin_unlock_irq(&ctx->fault_pending_wqh.lock);
>> +		if (!list_empty_careful(&uwq.wq.entry)) {
>> +			spin_lock_irq(&ctx->fault_pending_wqh.lock);
>> +			/*
>> +			 * No need of list_del_init(), the uwq on the stack
>> +			 * will be freed shortly anyway.
>> +			 */
>> +			list_del(&uwq.wq.entry);
>> +			spin_unlock_irq(&ctx->fault_pending_wqh.lock);
>> +		}
>>  	}
>> -
>>  	/*
>>  	 * ctx may go away after this if the userfault pseudo fd is
>>  	 * already released.
>> @@ -1861,11 +1875,14 @@ static int userfaultfd_writeprotect(struct userfaultfd_ctx *ctx,
>>  		return ret;
>>  
>>  	if (uffdio_wp.mode & ~(UFFDIO_WRITEPROTECT_MODE_DONTWAKE |
>> -			       UFFDIO_WRITEPROTECT_MODE_WP))
>> +			       UFFDIO_WRITEPROTECT_MODE_WP |
>> +			       UFFDIO_WRITEPROTECT_MODE_ASYNC_WP))
>>  		return -EINVAL;
>>  
>> -	mode_wp = uffdio_wp.mode & UFFDIO_WRITEPROTECT_MODE_WP;
>> +	mode_wp = uffdio_wp.mode & (UFFDIO_WRITEPROTECT_MODE_WP |
>> +				    UFFDIO_WRITEPROTECT_MODE_ASYNC_WP);
>>  	mode_dontwake = uffdio_wp.mode & UFFDIO_WRITEPROTECT_MODE_DONTWAKE;
>> +	ctx->async = uffdio_wp.mode & UFFDIO_WRITEPROTECT_MODE_ASYNC_WP;
> 
> Please no..  ctx attributes shouldn't be easily changed by a single ioctl.
> 
> I suggest we have a new feature bit as I mentioned above (say,
> UFFD_FEATURE_WP_ASYNC), set it once with UFFDIO_API and it should apply to
> the whole lifecycle of this uffd handle.  That flag should (something I can
> quickly think of):
> 
>   - Have effect only if the uffd will be registered with WP mode (of
>     course) or ignored in any other modes,
> 
>   - Should fail any attempts of UFFDIO_WRITEPROTECT with wp=false on this
>     uffd handle because with async faults no page fault resolution needed
>     from userspace,
> 
>   - Should apply to any region registered with this uffd ctx, so it's
>     exclusively used with sync uffd-wp mode.
All of these are necesary and must be done to consolidate the interface of
UFFD. Agreed!

> 
> Then when the app wants to wr-protect in async mode, it simply goes ahead
> with UFFDIO_WRITEPROTECT(wp=true), it'll happen exactly the same as when it
> was sync mode.  It's only the pf handling procedure that's different (along
> with how the fault is reported - rather than as a message but it'll be
> consolidated into the soft-dirty bit).
PF handling will resovle the fault after un-setting the _PAGE_*_UFFD_WP on
the page. I'm not changing the soft-dirty bit. It is too delicate (if you
get the joke).

> 
>>  
>>  	if (mode_wp && mode_dontwake)
>>  		return -EINVAL;
>> @@ -2126,6 +2143,7 @@ static int new_userfaultfd(int flags)
>>  	ctx->flags = flags;
>>  	ctx->features = 0;
>>  	ctx->released = false;
>> +	ctx->async = false;
>>  	atomic_set(&ctx->mmap_changing, 0);
>>  	ctx->mm = current->mm;
>>  	/* prevent the mm struct to be freed */
>> diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
>> index 005e5e306266..b89665653861 100644
>> --- a/include/uapi/linux/userfaultfd.h
>> +++ b/include/uapi/linux/userfaultfd.h
>> @@ -284,6 +284,11 @@ struct uffdio_writeprotect {
>>   * UFFDIO_WRITEPROTECT_MODE_DONTWAKE: set the flag to avoid waking up
>>   * any wait thread after the operation succeeds.
>>   *
>> + * UFFDIO_WRITEPROTECT_MODE_ASYNC_WP: set the flag to write protect a
>> + * range, the flag is unset automatically when the page is written.
>> + * This is used to track which pages have been written to from the
>> + * time the memory was write protected.
>> + *
>>   * NOTE: Write protecting a region (WP=1) is unrelated to page faults,
>>   * therefore DONTWAKE flag is meaningless with WP=1.  Removing write
>>   * protection (WP=0) in response to a page fault wakes the faulting
>> @@ -291,6 +296,7 @@ struct uffdio_writeprotect {
>>   */
>>  #define UFFDIO_WRITEPROTECT_MODE_WP		((__u64)1<<0)
>>  #define UFFDIO_WRITEPROTECT_MODE_DONTWAKE	((__u64)1<<1)
>> +#define UFFDIO_WRITEPROTECT_MODE_ASYNC_WP	((__u64)1<<2)
>>  	__u64 mode;
>>  };
>>  
>> -- 
>> 2.30.2
>>
> 

I should have added Suggested-by: Peter Xy <peterx@redhat.com> to this
patch. I'll add in the next revision if you don't object.

I've started working on next revision. I'll reply to other highly valuable
review emails a bit later.

-- 
BR,
Muhammad Usama Anjum
