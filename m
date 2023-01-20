Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB75D6757C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 15:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjATOyC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 09:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjATOyB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:54:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795134615E
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jan 2023 06:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674226390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AUOjGmTFXC4DMVmZa6wjPRMDEu/y7poMMIu/vvuBRrM=;
        b=DwxUWvsH55vVzOAFA4PBiJG5j66QaF32Vm0d9bIkp2HpDU90zHKdfb/93soaXRXsbcc8py
        OzVZakhj5SYZybGpoqGprfk/l9hk4VHhhFueRlxVdLTyONkE0QdNbO/YUGPB6Qunc9/hl0
        IuQgjxJxEJiisLMEWWMg22fq7zmvRT4=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-133-Ic9s55YiNo6S47pX5cj1hw-1; Fri, 20 Jan 2023 09:53:09 -0500
X-MC-Unique: Ic9s55YiNo6S47pX5cj1hw-1
Received: by mail-vk1-f198.google.com with SMTP id h191-20020a1f21c8000000b003db14450957so1742452vkh.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jan 2023 06:53:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUOjGmTFXC4DMVmZa6wjPRMDEu/y7poMMIu/vvuBRrM=;
        b=Bv019ZZsQW/Xq2N27FE//gp9NWZDCZM4TJTxtx8YpmPMI5C1WBQOSnwDzhTnpItVVt
         nU0S5pkzLMZS537pWMHUmNf1h1Okqpuc8xyD4lQuKglUR7pJUfSj+cx9e6RvqwAZrl6T
         aLt2vlfsUTWADrKKBlP5AxNVJApqRQIpnJwmLMOfjn6YnUXqZ3NAr/Tq0mpjlWv9WTa/
         /Ar6q3kZwychjViEfvEjB7oOyEx6J4XBSbCJvFZm4jTSVqGRHXyu0vziZm7n8vKmFEym
         KAkck0LL2uEhag5KVbtF7j5giakME1KvqtdHYITd0f093MoNp+GzVC2uPlzIP3S+cMLd
         XTZw==
X-Gm-Message-State: AFqh2ko1Otd1LxBf9rltV4Xl9S0X5xfnZcJSVVVdi/BIhTDsBFgL5gS8
        C9wpT/j2XWPIMTsLmMQ+wrbtwmNGjVvqizkhwycWEdIRJw/xs1rIpd5vCeXyWZ5KZ2wnpbQ7KED
        QTEkSmRl5BRKgbs9bAOUoBDkxwA==
X-Received: by 2002:a05:6102:6c4:b0:3d3:c6b6:f6cb with SMTP id m4-20020a05610206c400b003d3c6b6f6cbmr10110937vsg.33.1674226388600;
        Fri, 20 Jan 2023 06:53:08 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuKEI5wlPM5iwQbylwxVk98E9UP/R/7m4X/rvDyrG3sF/GyxINJUK4YDTd8CcGLUnyV8nbN3A==
X-Received: by 2002:a05:6102:6c4:b0:3d3:c6b6:f6cb with SMTP id m4-20020a05610206c400b003d3c6b6f6cbmr10110884vsg.33.1674226388173;
        Fri, 20 Jan 2023 06:53:08 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id q22-20020a05620a2a5600b0070638ad5986sm12859313qkp.85.2023.01.20.06.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 06:53:07 -0800 (PST)
Date:   Fri, 20 Jan 2023 09:53:05 -0500
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
Message-ID: <Y8qq0dKIJBshua+X@x1n>
References: <20230109064519.3555250-1-usama.anjum@collabora.com>
 <20230109064519.3555250-2-usama.anjum@collabora.com>
 <Y8gkY8OlnOwvlkj4@x1n>
 <0bed5911-48b9-0cc2-dfcf-d3bc3b0e8388@collabora.com>
 <Y8lxW5YtD6MX61WD@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y8lxW5YtD6MX61WD@x1n>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 19, 2023 at 11:35:39AM -0500, Peter Xu wrote:
> On Thu, Jan 19, 2023 at 08:09:52PM +0500, Muhammad Usama Anjum wrote:
> 
> [...]
> 
> > >> @@ -497,80 +498,93 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
> > >>  
> > >>  	/* take the reference before dropping the mmap_lock */
> > >>  	userfaultfd_ctx_get(ctx);
> > >> +	if (ctx->async) {
> > > 
> > > Firstly, please consider not touching the existing code/indent as much as
> > > what this patch did.  Hopefully we can keep the major part of sync uffd be
> > > there with its git log, it also helps reviewing your code.  You can add the
> > > async block before that, handle the fault and return just earlier.
> > This is possible. Will do in next revision.
> > 
> > > 
> > > And, I think this is a bit too late because we're going to return with
> > > VM_FAULT_RETRY here, while maybe we don't need to retry at all here because
> > > we're going to resolve the page fault immediately.
> > > 
> > > I assume you added this because you wanted userfaultfd_ctx_get() to make
> > > sure the uffd context will not go away from under us, but it's not needed
> > > if we're still holding the mmap read lock.  I'd expect for async mode we
> > > don't really need to release it at all.
> > I'll have to check the what should be returned here. We should return
> > something which shows that the fault has been resolved.
> 
> VM_FAULT_NOPAGE may be the best to describe it, but I guess it shouldn't
> have a difference here if to just return zero.  And, I guess you don't even
> need to worry on the retval here because I think you can leverage do_wp_page.
> More below.
> 
> > 
> > > 
> > >> +		// Resolve page fault of this page
> > > 
> > > Please use "/* ... */" as that's the common pattern of commenting in the
> > > Linux kernel, at least what I see in mm/.
> > Will do.
> > 
> > > 
> > >> +		unsigned long addr = (ctx->features & UFFD_FEATURE_EXACT_ADDRESS) ?
> > >> +				      vmf->real_address : vmf->address;
> > >> +		struct vm_area_struct *dst_vma = find_vma(ctx->mm, addr);
> > >> +		size_t s = PAGE_SIZE;
> > > 
> > > This is weird - if we want async uffd-wp, let's consider huge page from the
> > > 1st day.
> > > 
> > >> +
> > >> +		if (dst_vma->vm_flags & VM_HUGEPAGE) {
> > > 
> > > VM_HUGEPAGE is only a hint.  It doesn't mean this page is always a huge
> > > page.  For anon, we can have thp wr-protected as a whole, not happening for
> > > !anon because we'll split already.
> > > 
> > > For anon, if a write happens to a thp being uffd-wp-ed, we'll keep that pmd
> > > wr-protected and report the uffd message.  The pmd split happens when the
> > > user invokes UFFDIO_WRITEPROTECT on the small page.  I think it'll stop
> > > working for async uffd-wp because we're going to resolve the page faults
> > > right away.
> > > 
> > > So for async uffd-wp (note: this will be different from hugetlb), you may
> > > want to consider having a pre-requisite patch to change wp_huge_pmd()
> > > behavior: rather than calling handle_userfault(), IIUC you can also just
> > > fallback to the split path right below (__split_huge_pmd) so the thp will
> > > split now even before the uffd message is generated.
> > I'll make the changes and make this. I wasn't aware that the thp is being
> > broken in the UFFD WP. At this time, I'm not sure if thp will be handled by
> > handle_userfault() in one go. Probably it will as the length is stored in
> > the vmf.
> 
> Yes I think THP can actually be handled in one go with uffd-wp anon (even
> if vmf doesn't store any length because page fault is about address only
> not length, afaict).  E.g. thp firstly get wr-protected in thp size, then
> when unprotect the user app sends UFFDIO_WRITEPROTECT(wp=false) with a
> range covering the whole thp.
> 
> But AFAIU that should be quite rare because most uffd-wp scenarios are
> latency sensitive, resolving page faults in large chunk definitely enlarges
> that.  It could happen though when it's not resolving an immediate page
> fault, so it could happen in the background.
> 
> So after a second thought, a safer approach is we only go to the split path
> if async is enabled, in wp_huge_pmd().  Then it doesn't need to be a
> pre-requisite patch too, it can be part of the major patch to implement the
> uffd-wp async mode.
> 
> > 
> > > 
> > > I think it should be transparent to the user and it'll start working for
> > > you with async uffd-wp here, because it means when reaching
> > > handle_userfault, it should not be possible to have thp at all since they
> > > should have all split up.
> > > 
> > >> +			s = HPAGE_SIZE;
> > >> +			addr &= HPAGE_MASK;
> > >> +		}
> > >>  
> > >> -	init_waitqueue_func_entry(&uwq.wq, userfaultfd_wake_function);
> > >> -	uwq.wq.private = current;
> > >> -	uwq.msg = userfault_msg(vmf->address, vmf->real_address, vmf->flags,
> > >> -				reason, ctx->features);
> > >> -	uwq.ctx = ctx;
> > >> -	uwq.waken = false;
> > >> -
> > >> -	blocking_state = userfaultfd_get_blocking_state(vmf->flags);
> > >> +		ret = mwriteprotect_range(ctx->mm, addr, s, false, &ctx->mmap_changing);
> > > 
> > > This is an overkill - we're pretty sure it's a single page, no need to call
> > > a range function here.
> > Probably change_pte_range() should be used here to directly remove the WP here?
> 
> Here we can persue the best performance, or we can also persue the easist
> way to implement.  I think the best we can have is we don't release either
> the mmap read lock _and_ the pgtable lock, so we resolve the page fault
> completely here.  But that requires more code changes.
> 
> So far an probably intermediate (and very easy to implement) solution is:
> 
> (1) Remap the pte (vmf->pte) and retake the lock (vmf->ptl).  Note: you
>     need to move the chunk to be before mmap read lock released first,
>     because we'll need that to make sure pgtable lock and the pgtable page
>     being still exist at the first place.
> 
> (2) If *vmf->pte != vmf->orig_pte, it means the pgtable changed, retry
>     (with VM_FAULT_NOPAGE).  We must have orig_pte set btw in this path.
> 
> (2) Remove the uffd-wp bit if it's set (and it must be set, because we
>     checked again on orig_pte with pgtable lock held).
> 
> (3) Invoke do_wp_page() again with the same vmf.
> 
> This will focus the resolution on the single page and resolve CoW in one
> shot if needed.  We may need to redo the map/lock of pte* but I suppose it
> won't hurt a lot if we just modified the fields anyway, so we can leave
> that for later.

I just noticed it's actually quite straigtforward to just not fall into
handle_userfault at all.  It can be as simple as:

---8<---
diff --git a/mm/memory.c b/mm/memory.c
index 4000e9f017e0..09aab434654c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3351,8 +3351,20 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)

        if (likely(!unshare)) {
                if (userfaultfd_pte_wp(vma, *vmf->pte)) {
-                       pte_unmap_unlock(vmf->pte, vmf->ptl);
-                       return handle_userfault(vmf, VM_UFFD_WP);
+                       if (userfaultfd_uffd_wp_async(vma)) {
+                               /*
+                                * Nothing needed (cache flush, TLB
+                                * invalidations, etc.) because we're only
+                                * removing the uffd-wp bit, which is
+                                * completely invisible to the user.
+                                * This falls through to possible CoW.
+                                */
+                               set_pte_at(vma->vm_mm, vmf->address, vmf->pte,
+                                          pte_clear_uffd_wp(*vmf->pte));
+                       } else {
+                               pte_unmap_unlock(vmf->pte, vmf->ptl);
+                               return handle_userfault(vmf, VM_UFFD_WP);
+                       }
                }
---8<---

Similar thing will be needed for hugetlb if that'll be supported.

One thing worth mention is, I think for async wp it doesn't need to be
restricted by UFFD_USER_MODE_ONLY, because comparing to the sync messages
it has no risk of being utilized for malicious purposes.

> 
> [...]
> 
> > > Then when the app wants to wr-protect in async mode, it simply goes ahead
> > > with UFFDIO_WRITEPROTECT(wp=true), it'll happen exactly the same as when it
> > > was sync mode.  It's only the pf handling procedure that's different (along
> > > with how the fault is reported - rather than as a message but it'll be
> > > consolidated into the soft-dirty bit).
> > PF handling will resovle the fault after un-setting the _PAGE_*_UFFD_WP on
> > the page. I'm not changing the soft-dirty bit. It is too delicate (if you
> > get the joke).
> 
> It's unfortunate that the old soft-dirty solution didn't go through easily.
> Soft-dirty still covers something that uffd-wp cannot do right now, e.g. on
> tracking mostly any type of pte mappings.  Uffd-wp can so far only track
> fully ram backed pages like shmem or hugetlb for files but not any random
> page cache.  Hopefully it still works at least for your use case, or it's
> time to rethink otherwise.
> 
> > 
> > > 
> > >>  
> > >>  	if (mode_wp && mode_dontwake)
> > >>  		return -EINVAL;
> > >> @@ -2126,6 +2143,7 @@ static int new_userfaultfd(int flags)
> > >>  	ctx->flags = flags;
> > >>  	ctx->features = 0;
> > >>  	ctx->released = false;
> > >> +	ctx->async = false;
> > >>  	atomic_set(&ctx->mmap_changing, 0);
> > >>  	ctx->mm = current->mm;
> > >>  	/* prevent the mm struct to be freed */
> > >> diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
> > >> index 005e5e306266..b89665653861 100644
> > >> --- a/include/uapi/linux/userfaultfd.h
> > >> +++ b/include/uapi/linux/userfaultfd.h
> > >> @@ -284,6 +284,11 @@ struct uffdio_writeprotect {
> > >>   * UFFDIO_WRITEPROTECT_MODE_DONTWAKE: set the flag to avoid waking up
> > >>   * any wait thread after the operation succeeds.
> > >>   *
> > >> + * UFFDIO_WRITEPROTECT_MODE_ASYNC_WP: set the flag to write protect a
> > >> + * range, the flag is unset automatically when the page is written.
> > >> + * This is used to track which pages have been written to from the
> > >> + * time the memory was write protected.
> > >> + *
> > >>   * NOTE: Write protecting a region (WP=1) is unrelated to page faults,
> > >>   * therefore DONTWAKE flag is meaningless with WP=1.  Removing write
> > >>   * protection (WP=0) in response to a page fault wakes the faulting
> > >> @@ -291,6 +296,7 @@ struct uffdio_writeprotect {
> > >>   */
> > >>  #define UFFDIO_WRITEPROTECT_MODE_WP		((__u64)1<<0)
> > >>  #define UFFDIO_WRITEPROTECT_MODE_DONTWAKE	((__u64)1<<1)
> > >> +#define UFFDIO_WRITEPROTECT_MODE_ASYNC_WP	((__u64)1<<2)
> > >>  	__u64 mode;
> > >>  };
> > >>  
> > >> -- 
> > >> 2.30.2
> > >>
> > > 
> > 
> > I should have added Suggested-by: Peter Xy <peterx@redhat.com> to this
> > patch. I'll add in the next revision if you don't object.
> 
> I'm fine with it.  If so, please do s/Xy/Xu/.
> 
> > 
> > I've started working on next revision. I'll reply to other highly valuable
> > review emails a bit later.
> 
> Thanks,
> 
> -- 
> Peter Xu

-- 
Peter Xu

