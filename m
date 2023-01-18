Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B2C672442
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 17:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjARQz7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 11:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjARQzz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:55:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBB23756E
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jan 2023 08:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674060905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NXDkukCGDDbIwdVjEbXoFsk14utwQSi8UJxIyseUvo8=;
        b=QkJ22qXeWBfonl1rmKwR5CTiEJYn17g3hJ/JDcr4suzI2I35OMgXj9hDhG3S2rKuB3qNYq
        CdHW3CWql5zZyz0007G1wQEwKl7TFN9kSllS/WJhcGZuWT6cpMjixVMok0UFX83l5KTp5S
        KVB4O6+Hxbtcfv8IxqRyuaAi2f9a2Cg=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-9-g8WbXzg3PkarU89_lA-rxA-1; Wed, 18 Jan 2023 11:55:04 -0500
X-MC-Unique: g8WbXzg3PkarU89_lA-rxA-1
Received: by mail-vs1-f71.google.com with SMTP id 68-20020a670347000000b003bf750cb86eso8984694vsd.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jan 2023 08:55:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXDkukCGDDbIwdVjEbXoFsk14utwQSi8UJxIyseUvo8=;
        b=EJSAcqfXkqnZACBtM9jnumYFQvPFcL1POP4o5HHp1lNSNLQ9PIdi5bPLzppkV0xzcq
         7Hd6kHRFkoZYKISAXx5lht40R38OxqU8zeXYRhK9sJl/kk8uNmc8tjzm2phFnGTwROFh
         HjSAxI+1Ycdb5EKK5CvjwoecSyma2RGVMsT4n6MGhdJSh+T0HO2S8iEV6cH62uqb1Znx
         JwMnYsENztjM1yYO8bwYGhI45hHHeSQJOyD+C7j5+watEy7ZgJVeTwfNnKgis6SHBzJz
         l/RgFJI4tO543pVVHFlP1IcYxSRk6UnlElPEhlTJoeztCcQYizqPsLEo/PZli3nNZSAO
         8L9A==
X-Gm-Message-State: AFqh2krEZUnQ7yok3qwNjHS6j2dOocEYM7Bw9KOCNDKdyFC12SfU7iEM
        pwlrTewaEv3kojbjAk+nPSsXjSjmTXs/QBx2i+EzBLlSw67MMgzXKfFYOSFicgQyOGM8lgzEtXu
        DYVSDqFJBH/6BWV1fhCUN8IHYlg==
X-Received: by 2002:a05:6102:14aa:b0:3d1:3b77:eccb with SMTP id d42-20020a05610214aa00b003d13b77eccbmr4625646vsv.32.1674060903558;
        Wed, 18 Jan 2023 08:55:03 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtfUDE93Hj9NBAi0fV5nniObyvetYgHNfybdyrV5OsYvIshSx8M23O3FZSKa0SjM49mqmSYtw==
X-Received: by 2002:a05:6102:14aa:b0:3d1:3b77:eccb with SMTP id d42-20020a05610214aa00b003d13b77eccbmr4625606vsv.32.1674060903180;
        Wed, 18 Jan 2023 08:55:03 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id y4-20020a05620a44c400b007069375e0f4sm4420004qkp.122.2023.01.18.08.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 08:55:02 -0800 (PST)
Date:   Wed, 18 Jan 2023 11:54:59 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
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
Message-ID: <Y8gkY8OlnOwvlkj4@x1n>
References: <20230109064519.3555250-1-usama.anjum@collabora.com>
 <20230109064519.3555250-2-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230109064519.3555250-2-usama.anjum@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Muhammad,

On Mon, Jan 09, 2023 at 11:45:16AM +0500, Muhammad Usama Anjum wrote:
> Add new WP Async mode (UFFDIO_WRITEPROTECT_MODE_ASYNC_WP) which resolves
> the page faults on its own. It can be used to track that which pages have
> been written to from the time the pages were write protected. It is very
> efficient way to track the changes as uffd is by nature pte/pmd based.
> 
> UFFD WP (UFFDIO_WRITEPROTECT_MODE_WP) sends the page faults to the
> userspace where the pages which have been written-to can be tracked. But
> it is not efficient. This is why this async version is being added.
> After setting the WP Async, the pages which have been written to can be
> found in the pagemap file or information can be obtained from the
> PAGEMAP_IOCTL (see next patches).
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  fs/userfaultfd.c                 | 150 +++++++++++++++++--------------
>  include/uapi/linux/userfaultfd.h |   6 ++
>  2 files changed, 90 insertions(+), 66 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 15a5bf765d43..be5e10d15058 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -69,6 +69,7 @@ struct userfaultfd_ctx {
>  	unsigned int features;
>  	/* released */
>  	bool released;
> +	bool async;

Let's just make it a feature flag,

  UFFD_FEATURE_WP_ASYNC

>  	/* memory mappings are changing because of non-cooperative event */
>  	atomic_t mmap_changing;
>  	/* mm with one ore more vmas attached to this userfaultfd_ctx */
> @@ -497,80 +498,93 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
>  
>  	/* take the reference before dropping the mmap_lock */
>  	userfaultfd_ctx_get(ctx);
> +	if (ctx->async) {

Firstly, please consider not touching the existing code/indent as much as
what this patch did.  Hopefully we can keep the major part of sync uffd be
there with its git log, it also helps reviewing your code.  You can add the
async block before that, handle the fault and return just earlier.

And, I think this is a bit too late because we're going to return with
VM_FAULT_RETRY here, while maybe we don't need to retry at all here because
we're going to resolve the page fault immediately.

I assume you added this because you wanted userfaultfd_ctx_get() to make
sure the uffd context will not go away from under us, but it's not needed
if we're still holding the mmap read lock.  I'd expect for async mode we
don't really need to release it at all.

> +		// Resolve page fault of this page

Please use "/* ... */" as that's the common pattern of commenting in the
Linux kernel, at least what I see in mm/.

> +		unsigned long addr = (ctx->features & UFFD_FEATURE_EXACT_ADDRESS) ?
> +				      vmf->real_address : vmf->address;
> +		struct vm_area_struct *dst_vma = find_vma(ctx->mm, addr);
> +		size_t s = PAGE_SIZE;

This is weird - if we want async uffd-wp, let's consider huge page from the
1st day.

> +
> +		if (dst_vma->vm_flags & VM_HUGEPAGE) {

VM_HUGEPAGE is only a hint.  It doesn't mean this page is always a huge
page.  For anon, we can have thp wr-protected as a whole, not happening for
!anon because we'll split already.

For anon, if a write happens to a thp being uffd-wp-ed, we'll keep that pmd
wr-protected and report the uffd message.  The pmd split happens when the
user invokes UFFDIO_WRITEPROTECT on the small page.  I think it'll stop
working for async uffd-wp because we're going to resolve the page faults
right away.

So for async uffd-wp (note: this will be different from hugetlb), you may
want to consider having a pre-requisite patch to change wp_huge_pmd()
behavior: rather than calling handle_userfault(), IIUC you can also just
fallback to the split path right below (__split_huge_pmd) so the thp will
split now even before the uffd message is generated.

I think it should be transparent to the user and it'll start working for
you with async uffd-wp here, because it means when reaching
handle_userfault, it should not be possible to have thp at all since they
should have all split up.

> +			s = HPAGE_SIZE;
> +			addr &= HPAGE_MASK;
> +		}
>  
> -	init_waitqueue_func_entry(&uwq.wq, userfaultfd_wake_function);
> -	uwq.wq.private = current;
> -	uwq.msg = userfault_msg(vmf->address, vmf->real_address, vmf->flags,
> -				reason, ctx->features);
> -	uwq.ctx = ctx;
> -	uwq.waken = false;
> -
> -	blocking_state = userfaultfd_get_blocking_state(vmf->flags);
> +		ret = mwriteprotect_range(ctx->mm, addr, s, false, &ctx->mmap_changing);

This is an overkill - we're pretty sure it's a single page, no need to call
a range function here.

> +	} else {
> +		init_waitqueue_func_entry(&uwq.wq, userfaultfd_wake_function);
> +		uwq.wq.private = current;
> +		uwq.msg = userfault_msg(vmf->address, vmf->real_address, vmf->flags,
> +					reason, ctx->features);
> +		uwq.ctx = ctx;
> +		uwq.waken = false;
>  
> -        /*
> -         * Take the vma lock now, in order to safely call
> -         * userfaultfd_huge_must_wait() later. Since acquiring the
> -         * (sleepable) vma lock can modify the current task state, that
> -         * must be before explicitly calling set_current_state().
> -         */
> -	if (is_vm_hugetlb_page(vma))
> -		hugetlb_vma_lock_read(vma);
> +		blocking_state = userfaultfd_get_blocking_state(vmf->flags);
>  
> -	spin_lock_irq(&ctx->fault_pending_wqh.lock);
> -	/*
> -	 * After the __add_wait_queue the uwq is visible to userland
> -	 * through poll/read().
> -	 */
> -	__add_wait_queue(&ctx->fault_pending_wqh, &uwq.wq);
> -	/*
> -	 * The smp_mb() after __set_current_state prevents the reads
> -	 * following the spin_unlock to happen before the list_add in
> -	 * __add_wait_queue.
> -	 */
> -	set_current_state(blocking_state);
> -	spin_unlock_irq(&ctx->fault_pending_wqh.lock);
> +		/*
> +		 * Take the vma lock now, in order to safely call
> +		 * userfaultfd_huge_must_wait() later. Since acquiring the
> +		 * (sleepable) vma lock can modify the current task state, that
> +		 * must be before explicitly calling set_current_state().
> +		 */
> +		if (is_vm_hugetlb_page(vma))
> +			hugetlb_vma_lock_read(vma);
>  
> -	if (!is_vm_hugetlb_page(vma))
> -		must_wait = userfaultfd_must_wait(ctx, vmf->address, vmf->flags,
> -						  reason);
> -	else
> -		must_wait = userfaultfd_huge_must_wait(ctx, vma,
> -						       vmf->address,
> -						       vmf->flags, reason);
> -	if (is_vm_hugetlb_page(vma))
> -		hugetlb_vma_unlock_read(vma);
> -	mmap_read_unlock(mm);
> +		spin_lock_irq(&ctx->fault_pending_wqh.lock);
> +		/*
> +		 * After the __add_wait_queue the uwq is visible to userland
> +		 * through poll/read().
> +		 */
> +		__add_wait_queue(&ctx->fault_pending_wqh, &uwq.wq);
> +		/*
> +		 * The smp_mb() after __set_current_state prevents the reads
> +		 * following the spin_unlock to happen before the list_add in
> +		 * __add_wait_queue.
> +		 */
> +		set_current_state(blocking_state);
> +		spin_unlock_irq(&ctx->fault_pending_wqh.lock);
>  
> -	if (likely(must_wait && !READ_ONCE(ctx->released))) {
> -		wake_up_poll(&ctx->fd_wqh, EPOLLIN);
> -		schedule();
> -	}
> +		if (!is_vm_hugetlb_page(vma))
> +			must_wait = userfaultfd_must_wait(ctx, vmf->address, vmf->flags,
> +							  reason);
> +		else
> +			must_wait = userfaultfd_huge_must_wait(ctx, vma,
> +							       vmf->address,
> +							       vmf->flags, reason);
> +		if (is_vm_hugetlb_page(vma))
> +			hugetlb_vma_unlock_read(vma);
> +		mmap_read_unlock(mm);
> +
> +		if (likely(must_wait && !READ_ONCE(ctx->released))) {
> +			wake_up_poll(&ctx->fd_wqh, EPOLLIN);
> +			schedule();
> +		}
>  
> -	__set_current_state(TASK_RUNNING);
> +		__set_current_state(TASK_RUNNING);
>  
> -	/*
> -	 * Here we race with the list_del; list_add in
> -	 * userfaultfd_ctx_read(), however because we don't ever run
> -	 * list_del_init() to refile across the two lists, the prev
> -	 * and next pointers will never point to self. list_add also
> -	 * would never let any of the two pointers to point to
> -	 * self. So list_empty_careful won't risk to see both pointers
> -	 * pointing to self at any time during the list refile. The
> -	 * only case where list_del_init() is called is the full
> -	 * removal in the wake function and there we don't re-list_add
> -	 * and it's fine not to block on the spinlock. The uwq on this
> -	 * kernel stack can be released after the list_del_init.
> -	 */
> -	if (!list_empty_careful(&uwq.wq.entry)) {
> -		spin_lock_irq(&ctx->fault_pending_wqh.lock);
>  		/*
> -		 * No need of list_del_init(), the uwq on the stack
> -		 * will be freed shortly anyway.
> +		 * Here we race with the list_del; list_add in
> +		 * userfaultfd_ctx_read(), however because we don't ever run
> +		 * list_del_init() to refile across the two lists, the prev
> +		 * and next pointers will never point to self. list_add also
> +		 * would never let any of the two pointers to point to
> +		 * self. So list_empty_careful won't risk to see both pointers
> +		 * pointing to self at any time during the list refile. The
> +		 * only case where list_del_init() is called is the full
> +		 * removal in the wake function and there we don't re-list_add
> +		 * and it's fine not to block on the spinlock. The uwq on this
> +		 * kernel stack can be released after the list_del_init.
>  		 */
> -		list_del(&uwq.wq.entry);
> -		spin_unlock_irq(&ctx->fault_pending_wqh.lock);
> +		if (!list_empty_careful(&uwq.wq.entry)) {
> +			spin_lock_irq(&ctx->fault_pending_wqh.lock);
> +			/*
> +			 * No need of list_del_init(), the uwq on the stack
> +			 * will be freed shortly anyway.
> +			 */
> +			list_del(&uwq.wq.entry);
> +			spin_unlock_irq(&ctx->fault_pending_wqh.lock);
> +		}
>  	}
> -
>  	/*
>  	 * ctx may go away after this if the userfault pseudo fd is
>  	 * already released.
> @@ -1861,11 +1875,14 @@ static int userfaultfd_writeprotect(struct userfaultfd_ctx *ctx,
>  		return ret;
>  
>  	if (uffdio_wp.mode & ~(UFFDIO_WRITEPROTECT_MODE_DONTWAKE |
> -			       UFFDIO_WRITEPROTECT_MODE_WP))
> +			       UFFDIO_WRITEPROTECT_MODE_WP |
> +			       UFFDIO_WRITEPROTECT_MODE_ASYNC_WP))
>  		return -EINVAL;
>  
> -	mode_wp = uffdio_wp.mode & UFFDIO_WRITEPROTECT_MODE_WP;
> +	mode_wp = uffdio_wp.mode & (UFFDIO_WRITEPROTECT_MODE_WP |
> +				    UFFDIO_WRITEPROTECT_MODE_ASYNC_WP);
>  	mode_dontwake = uffdio_wp.mode & UFFDIO_WRITEPROTECT_MODE_DONTWAKE;
> +	ctx->async = uffdio_wp.mode & UFFDIO_WRITEPROTECT_MODE_ASYNC_WP;

Please no..  ctx attributes shouldn't be easily changed by a single ioctl.

I suggest we have a new feature bit as I mentioned above (say,
UFFD_FEATURE_WP_ASYNC), set it once with UFFDIO_API and it should apply to
the whole lifecycle of this uffd handle.  That flag should (something I can
quickly think of):

  - Have effect only if the uffd will be registered with WP mode (of
    course) or ignored in any other modes,

  - Should fail any attempts of UFFDIO_WRITEPROTECT with wp=false on this
    uffd handle because with async faults no page fault resolution needed
    from userspace,

  - Should apply to any region registered with this uffd ctx, so it's
    exclusively used with sync uffd-wp mode.

Then when the app wants to wr-protect in async mode, it simply goes ahead
with UFFDIO_WRITEPROTECT(wp=true), it'll happen exactly the same as when it
was sync mode.  It's only the pf handling procedure that's different (along
with how the fault is reported - rather than as a message but it'll be
consolidated into the soft-dirty bit).

>  
>  	if (mode_wp && mode_dontwake)
>  		return -EINVAL;
> @@ -2126,6 +2143,7 @@ static int new_userfaultfd(int flags)
>  	ctx->flags = flags;
>  	ctx->features = 0;
>  	ctx->released = false;
> +	ctx->async = false;
>  	atomic_set(&ctx->mmap_changing, 0);
>  	ctx->mm = current->mm;
>  	/* prevent the mm struct to be freed */
> diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
> index 005e5e306266..b89665653861 100644
> --- a/include/uapi/linux/userfaultfd.h
> +++ b/include/uapi/linux/userfaultfd.h
> @@ -284,6 +284,11 @@ struct uffdio_writeprotect {
>   * UFFDIO_WRITEPROTECT_MODE_DONTWAKE: set the flag to avoid waking up
>   * any wait thread after the operation succeeds.
>   *
> + * UFFDIO_WRITEPROTECT_MODE_ASYNC_WP: set the flag to write protect a
> + * range, the flag is unset automatically when the page is written.
> + * This is used to track which pages have been written to from the
> + * time the memory was write protected.
> + *
>   * NOTE: Write protecting a region (WP=1) is unrelated to page faults,
>   * therefore DONTWAKE flag is meaningless with WP=1.  Removing write
>   * protection (WP=0) in response to a page fault wakes the faulting
> @@ -291,6 +296,7 @@ struct uffdio_writeprotect {
>   */
>  #define UFFDIO_WRITEPROTECT_MODE_WP		((__u64)1<<0)
>  #define UFFDIO_WRITEPROTECT_MODE_DONTWAKE	((__u64)1<<1)
> +#define UFFDIO_WRITEPROTECT_MODE_ASYNC_WP	((__u64)1<<2)
>  	__u64 mode;
>  };
>  
> -- 
> 2.30.2
> 

-- 
Peter Xu

