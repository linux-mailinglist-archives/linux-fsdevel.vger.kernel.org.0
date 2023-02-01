Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191F6687141
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Feb 2023 23:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjBAWwZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Feb 2023 17:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjBAWwX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Feb 2023 17:52:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BA56385D
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Feb 2023 14:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675291900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XSLskm6AR/RoEO7AKZfXBH2mjiqKgHPTYdoXGz36+6Y=;
        b=QEa21kbNtStvvrwSiGuhXQuts+Mj6jWjb5eKYGNoso6l0lfjTL1hlxaufiwwtvgQwQ/6Ow
        h8wFXsW0jF5FA5+88VaCxuXGqBXpwC/OIsUWjHdZlJUyuOMN8w0Uepx/jIaAPmKHdX7TTn
        epSo+hLpl8ooEpg/xv+wlMq/H7ZJdZ4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-226-HUvxdIXbNI6lV22rNxqNQw-1; Wed, 01 Feb 2023 17:51:39 -0500
X-MC-Unique: HUvxdIXbNI6lV22rNxqNQw-1
Received: by mail-qv1-f69.google.com with SMTP id k15-20020a0cd68f000000b00535261af1b1so11059942qvi.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Feb 2023 14:51:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSLskm6AR/RoEO7AKZfXBH2mjiqKgHPTYdoXGz36+6Y=;
        b=VKS+qVpcggmJVrD2//tJcS3O0nI8wXmppoP8DUzw2JCDh/4KAb7wyMdLEevfxkd7Yq
         Cb7CW9NbETtOocs12/Q19TZYIAJgeiAt+npusxe7g158z6ngj7oL72yMnVqeuIK8Ix6L
         RNz2Fuk2w3Ut9peFLbzddJQ4x/9NyoXyKDfJIVOkeIlLUEK+Yz5Tnuig0hCtyKncSeGB
         tHGl5fDRhNkq6qvj+SS7dhSxDBO85zfgcBTqpDsPxLYsYgAOuR5e+hqF9eEi3ubzBY51
         W2mvLhBAow5P0zkyXsVXl2BulFlEMNc5UklbDv/rqykQpnejiDudsV+U4mcH18mrAybp
         zt7w==
X-Gm-Message-State: AO0yUKUHAOSg8UVPVWcih8owfJeYPgvChnSqxlhFrj5uYlj6x7v5sIt+
        fOwHjVlnCu2ve/SrTdYQWVH7UhOrkLo8ynoGNdhHtiw58+l6FNLwnIOfvT710y/BXQvxhKIzKKQ
        BuqGl084I/Atv9k1jsYjb2voDFA==
X-Received: by 2002:ac8:4908:0:b0:3b8:6c6e:4949 with SMTP id e8-20020ac84908000000b003b86c6e4949mr6666854qtq.4.1675291898863;
        Wed, 01 Feb 2023 14:51:38 -0800 (PST)
X-Google-Smtp-Source: AK7set9QU/pg3lX447cZDPT+ECjMCN9D89jwTNBjSZqxAR811W/xmquV+vVt3b6u8OCgqafcLR9zUg==
X-Received: by 2002:ac8:4908:0:b0:3b8:6c6e:4949 with SMTP id e8-20020ac84908000000b003b86c6e4949mr6666813qtq.4.1675291898528;
        Wed, 01 Feb 2023 14:51:38 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id a8-20020ac84348000000b003b86d8ad0c1sm5593624qtn.3.2023.02.01.14.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 14:51:37 -0800 (PST)
Date:   Wed, 1 Feb 2023 17:51:35 -0500
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
Subject: Re: [PATCH v9 1/3] userfaultfd: Add UFFD WP Async support
Message-ID: <Y9rs93beOffPHlkt@x1n>
References: <20230131083257.3302830-1-usama.anjum@collabora.com>
 <20230131083257.3302830-2-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230131083257.3302830-2-usama.anjum@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 31, 2023 at 01:32:55PM +0500, Muhammad Usama Anjum wrote:
> Add new WP Async mode (UFFD_FEATURE_WP_ASYNC) which resolves the page
> faults on its own. It can be used to track that which pages have been
> written-to from the time the pages were write-protected. It is very
> efficient way to track the changes as uffd is by nature pte/pmd based.
> 
> UFFD synchronous WP sends the page faults to the userspace where the
> pages which have been written-to can be tracked. But it is not efficient.
> This is why this asynchronous version is being added. After setting the
> WP Async, the pages which have been written to can be found in the pagemap
> file or information can be obtained from the PAGEMAP_IOCTL.
> 
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes in v9:
> - Correct the fault resolution with code contributed by Peter
> 
> Changes in v7:
> - Remove UFFDIO_WRITEPROTECT_MODE_ASYNC_WP and add UFFD_FEATURE_WP_ASYNC
> - Handle automatic page fault resolution in better way (thanks to Peter)
> 
> update to wp async
> ---
>  fs/userfaultfd.c                 | 11 +++++++++++
>  include/linux/userfaultfd_k.h    |  6 ++++++
>  include/uapi/linux/userfaultfd.h |  8 +++++++-
>  mm/memory.c                      | 23 ++++++++++++++++++++---
>  4 files changed, 44 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 15a5bf765d43..c17835a0e842 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1867,6 +1867,10 @@ static int userfaultfd_writeprotect(struct userfaultfd_ctx *ctx,
>  	mode_wp = uffdio_wp.mode & UFFDIO_WRITEPROTECT_MODE_WP;
>  	mode_dontwake = uffdio_wp.mode & UFFDIO_WRITEPROTECT_MODE_DONTWAKE;
>  
> +	/* The unprotection is not supported if in async WP mode */
> +	if (!mode_wp && (ctx->features & UFFD_FEATURE_WP_ASYNC))
> +		return -EINVAL;
> +
>  	if (mode_wp && mode_dontwake)
>  		return -EINVAL;
>  
> @@ -1950,6 +1954,13 @@ static int userfaultfd_continue(struct userfaultfd_ctx *ctx, unsigned long arg)
>  	return ret;
>  }
>  
> +int userfaultfd_wp_async(struct vm_area_struct *vma)
> +{
> +	struct userfaultfd_ctx *ctx = vma->vm_userfaultfd_ctx.ctx;
> +
> +	return (ctx && (ctx->features & UFFD_FEATURE_WP_ASYNC));
> +}
> +
>  static inline unsigned int uffd_ctx_features(__u64 user_features)
>  {
>  	/*
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index 9df0b9a762cc..94dcb4dc1b4a 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -179,6 +179,7 @@ extern int userfaultfd_unmap_prep(struct mm_struct *mm, unsigned long start,
>  				  unsigned long end, struct list_head *uf);
>  extern void userfaultfd_unmap_complete(struct mm_struct *mm,
>  				       struct list_head *uf);
> +extern int userfaultfd_wp_async(struct vm_area_struct *vma);
>  
>  #else /* CONFIG_USERFAULTFD */
>  
> @@ -274,6 +275,11 @@ static inline bool uffd_disable_fault_around(struct vm_area_struct *vma)
>  	return false;
>  }
>  
> +static inline int userfaultfd_wp_async(struct vm_area_struct *vma)
> +{
> +	return false;
> +}
> +
>  #endif /* CONFIG_USERFAULTFD */
>  
>  static inline bool pte_marker_entry_uffd_wp(swp_entry_t entry)
> diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
> index 005e5e306266..f4252ef40071 100644
> --- a/include/uapi/linux/userfaultfd.h
> +++ b/include/uapi/linux/userfaultfd.h
> @@ -38,7 +38,8 @@
>  			   UFFD_FEATURE_MINOR_HUGETLBFS |	\
>  			   UFFD_FEATURE_MINOR_SHMEM |		\
>  			   UFFD_FEATURE_EXACT_ADDRESS |		\
> -			   UFFD_FEATURE_WP_HUGETLBFS_SHMEM)
> +			   UFFD_FEATURE_WP_HUGETLBFS_SHMEM |	\
> +			   UFFD_FEATURE_WP_ASYNC)
>  #define UFFD_API_IOCTLS				\
>  	((__u64)1 << _UFFDIO_REGISTER |		\
>  	 (__u64)1 << _UFFDIO_UNREGISTER |	\
> @@ -203,6 +204,10 @@ struct uffdio_api {
>  	 *
>  	 * UFFD_FEATURE_WP_HUGETLBFS_SHMEM indicates that userfaultfd
>  	 * write-protection mode is supported on both shmem and hugetlbfs.
> +	 *
> +	 * UFFD_FEATURE_WP_ASYNC indicates that userfaultfd write-protection
> +	 * asynchronous mode is supported in which the write fault is automatically
> +	 * resolved and write-protection is un-set.

Please mention a few other things:

  - It only supports anon and shmem (so hugetlb is not supported)

  - It will only take effect when any vma is registered with wr-protection
    mode.  Otherwise the flag will be ignored.

In userfaultfd_register(), we need to fail the ioctl if anyone tries to
register any hugetlb vma with this new flag set.

>  	 */
>  #define UFFD_FEATURE_PAGEFAULT_FLAG_WP		(1<<0)
>  #define UFFD_FEATURE_EVENT_FORK			(1<<1)
> @@ -217,6 +222,7 @@ struct uffdio_api {
>  #define UFFD_FEATURE_MINOR_SHMEM		(1<<10)
>  #define UFFD_FEATURE_EXACT_ADDRESS		(1<<11)
>  #define UFFD_FEATURE_WP_HUGETLBFS_SHMEM		(1<<12)
> +#define UFFD_FEATURE_WP_ASYNC			(1<<13)
>  	__u64 features;
>  
>  	__u64 ioctls;
> diff --git a/mm/memory.c b/mm/memory.c
> index 4000e9f017e0..04843e35550e 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3351,8 +3351,21 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>  
>  	if (likely(!unshare)) {
>  		if (userfaultfd_pte_wp(vma, *vmf->pte)) {
> -			pte_unmap_unlock(vmf->pte, vmf->ptl);
> -			return handle_userfault(vmf, VM_UFFD_WP);
> +			if (userfaultfd_wp_async(vma)) {
> +				/*
> +				 * Nothing needed (cache flush, TLB invalidations,
> +				 * etc.) because we're only removing the uffd-wp bit,
> +				 * which is completely invisible to the user.
> +				 */
> +				pte_t pte = pte_clear_uffd_wp(*vmf->pte);
> +
> +				set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
> +				/* Update this to be prepared for following up CoW handling */
> +				vmf->orig_pte = pte;
> +			} else {
> +				pte_unmap_unlock(vmf->pte, vmf->ptl);
> +				return handle_userfault(vmf, VM_UFFD_WP);
> +			}
>  		}
>  
>  		/*
> @@ -4812,8 +4825,11 @@ static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
>  
>  	if (vma_is_anonymous(vmf->vma)) {
>  		if (likely(!unshare) &&
> -		    userfaultfd_huge_pmd_wp(vmf->vma, vmf->orig_pmd))
> +		    userfaultfd_huge_pmd_wp(vmf->vma, vmf->orig_pmd)) {
> +			if (userfaultfd_wp_async(vmf->vma))
> +				goto split_and_return;
>  			return handle_userfault(vmf, VM_UFFD_WP);
> +		}
>  		return do_huge_pmd_wp_page(vmf);
>  	}
>  
> @@ -4825,6 +4841,7 @@ static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
>  		}
>  	}
>  
> +split_and_return:

The "and_return" is superfluous, IMHO.  Just make it "split"?

>  	/* COW or write-notify handled on pte level: split pmd. */
>  	__split_huge_pmd(vmf->vma, vmf->pmd, vmf->address, false, NULL);

Would you also update Documentation/admin-guide/mm/userfaultfd.rst in the
same patch?

Thanks,

-- 
Peter Xu

