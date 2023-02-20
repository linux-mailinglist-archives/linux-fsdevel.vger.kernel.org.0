Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBC969C6D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 09:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjBTIgo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 03:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjBTIgm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 03:36:42 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AB013DDF;
        Mon, 20 Feb 2023 00:36:22 -0800 (PST)
Received: from [192.168.10.12] (unknown [39.45.217.110])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8BD7966018CA;
        Mon, 20 Feb 2023 08:36:14 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676882181;
        bh=kMZkLJYnHc2ozlvIeqwgQbNYmUjgvuZvFvLC0JjfCIo=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=FeIL13Ed3B7K3m2XvQ5pImkpPsoNOFzsOakUec5c2jL58ehH2qjUnw2FhD4fazRg9
         kvmAWUGLsDmmbgDK4BSvxMKf2++Ljw33BaxdsavOT1ClAUErVl8I61tAcWRnU5kTJP
         dhMEwCPNbT1/QI6kscsfk9xBkzWoohTEDm+ESSKwEWU4Ltjrgtv+avAZjdsjm48q4Q
         AEPNv82qmn8tzV+5Btag8a57XbWGyCnVo0H3nrvqOzSwMgeoo0PqA53OOCY9ckAyVU
         gxD5cfPNapOgl0rPkPxsnIkI+iJAulpHSB4yqXH4JRbqBIvkSzchPe2ASirSTfq9gA
         cwbD3TuL5Ah4w==
Message-ID: <787ea67e-c48d-c88e-c233-a231b7a101e5@collabora.com>
Date:   Mon, 20 Feb 2023 13:36:10 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Peter Xu <peterx@redhat.com>,
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
        Nadav Amit <namit@vmware.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v10 1/6] userfaultfd: Add UFFD WP Async support
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>
References: <20230202112915.867409-1-usama.anjum@collabora.com>
 <20230202112915.867409-2-usama.anjum@collabora.com>
 <Y+9K5j+uWdTRKzkv@kernel.org>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <Y+9K5j+uWdTRKzkv@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Mike,

Thanks for reviewing.

On 2/17/23 2:37 PM, Mike Rapoport wrote:
> Hi Muhammad,
> 
> On Thu, Feb 02, 2023 at 04:29:10PM +0500, Muhammad Usama Anjum wrote:
>> Add new WP Async mode (UFFD_FEATURE_WP_ASYNC) which resolves the page
>> faults on its own. It can be used to track that which pages have been
>> written-to from the time the pages were write-protected. It is very
>> efficient way to track the changes as uffd is by nature pte/pmd based.
>>
>> UFFD synchronous WP sends the page faults to the userspace where the
>> pages which have been written-to can be tracked. But it is not efficient.
>> This is why this asynchronous version is being added. After setting the
>> WP Async, the pages which have been written to can be found in the pagemap
>> file or information can be obtained from the PAGEMAP_IOCTL.
>>
>> Suggested-by: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> Changes in v10:
>> - Build fix
>> - Update comments and add error condition to return error from uffd
>>   register if hugetlb pages are present when wp async flag is set
>>
>> Changes in v9:
>> - Correct the fault resolution with code contributed by Peter
>>
>> Changes in v7:
>> - Remove UFFDIO_WRITEPROTECT_MODE_ASYNC_WP and add UFFD_FEATURE_WP_ASYNC
>> - Handle automatic page fault resolution in better way (thanks to Peter)
>>
>> update to wp async
>>
>> uffd wp async
>> ---
>>  fs/userfaultfd.c                 | 20 ++++++++++++++++++--
>>  include/linux/userfaultfd_k.h    | 11 +++++++++++
>>  include/uapi/linux/userfaultfd.h | 10 +++++++++-
>>  mm/memory.c                      | 23 ++++++++++++++++++++---
>>  4 files changed, 58 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
>> index 15a5bf765d43..422f2530c63e 100644
>> --- a/fs/userfaultfd.c
>> +++ b/fs/userfaultfd.c
>> @@ -1422,10 +1422,15 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>>  			goto out_unlock;
>>  
>>  		/*
>> -		 * Note vmas containing huge pages
>> +		 * Note vmas containing huge pages. Hugetlb isn't supported
>> +		 * with UFFD_FEATURE_WP_ASYNC.
>>  		 */
>> -		if (is_vm_hugetlb_page(cur))
>> +		if (is_vm_hugetlb_page(cur)) {
>> +			if (ctx->features & UFFD_FEATURE_WP_ASYNC)
>> +				goto out_unlock;
>> +
>>  			basic_ioctls = true;
>> +		}
>>  
>>  		found = true;
>>  	}
>> @@ -1867,6 +1872,10 @@ static int userfaultfd_writeprotect(struct userfaultfd_ctx *ctx,
>>  	mode_wp = uffdio_wp.mode & UFFDIO_WRITEPROTECT_MODE_WP;
>>  	mode_dontwake = uffdio_wp.mode & UFFDIO_WRITEPROTECT_MODE_DONTWAKE;
>>  
>> +	/* The unprotection is not supported if in async WP mode */
>> +	if (!mode_wp && (ctx->features & UFFD_FEATURE_WP_ASYNC))
>> +		return -EINVAL;
>> +
>>  	if (mode_wp && mode_dontwake)
>>  		return -EINVAL;
>>  
>> @@ -1950,6 +1959,13 @@ static int userfaultfd_continue(struct userfaultfd_ctx *ctx, unsigned long arg)
>>  	return ret;
>>  }
>>  
>> +int userfaultfd_wp_async(struct vm_area_struct *vma)
>> +{
>> +	struct userfaultfd_ctx *ctx = vma->vm_userfaultfd_ctx.ctx;
>> +
>> +	return (ctx && (ctx->features & UFFD_FEATURE_WP_ASYNC));
>> +}
>> +
>>  static inline unsigned int uffd_ctx_features(__u64 user_features)
>>  {
>>  	/*
>> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
>> index 9df0b9a762cc..38c92c2beb16 100644
>> --- a/include/linux/userfaultfd_k.h
>> +++ b/include/linux/userfaultfd_k.h
>> @@ -179,6 +179,7 @@ extern int userfaultfd_unmap_prep(struct mm_struct *mm, unsigned long start,
>>  				  unsigned long end, struct list_head *uf);
>>  extern void userfaultfd_unmap_complete(struct mm_struct *mm,
>>  				       struct list_head *uf);
>> +extern int userfaultfd_wp_async(struct vm_area_struct *vma);
>>  
>>  #else /* CONFIG_USERFAULTFD */
>>  
>> @@ -189,6 +190,11 @@ static inline vm_fault_t handle_userfault(struct vm_fault *vmf,
>>  	return VM_FAULT_SIGBUS;
>>  }
>>  
>> +static inline void uffd_wp_range(struct mm_struct *dst_mm, struct vm_area_struct *vma,
>> +				 unsigned long start, unsigned long len, bool enable_wp)
>> +{
>> +}
>> +
>>  static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
>>  					struct vm_userfaultfd_ctx vm_ctx)
>>  {
>> @@ -274,6 +280,11 @@ static inline bool uffd_disable_fault_around(struct vm_area_struct *vma)
>>  	return false;
>>  }
>>  
>> +static inline int userfaultfd_wp_async(struct vm_area_struct *vma)
>> +{
>> +	return false;
>> +}
>> +
>>  #endif /* CONFIG_USERFAULTFD */
>>  
>>  static inline bool pte_marker_entry_uffd_wp(swp_entry_t entry)
>> diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
>> index 005e5e306266..30a6f32cf564 100644
>> --- a/include/uapi/linux/userfaultfd.h
>> +++ b/include/uapi/linux/userfaultfd.h
>> @@ -38,7 +38,8 @@
>>  			   UFFD_FEATURE_MINOR_HUGETLBFS |	\
>>  			   UFFD_FEATURE_MINOR_SHMEM |		\
>>  			   UFFD_FEATURE_EXACT_ADDRESS |		\
>> -			   UFFD_FEATURE_WP_HUGETLBFS_SHMEM)
>> +			   UFFD_FEATURE_WP_HUGETLBFS_SHMEM |	\
>> +			   UFFD_FEATURE_WP_ASYNC)
>>  #define UFFD_API_IOCTLS				\
>>  	((__u64)1 << _UFFDIO_REGISTER |		\
>>  	 (__u64)1 << _UFFDIO_UNREGISTER |	\
>> @@ -203,6 +204,12 @@ struct uffdio_api {
>>  	 *
>>  	 * UFFD_FEATURE_WP_HUGETLBFS_SHMEM indicates that userfaultfd
>>  	 * write-protection mode is supported on both shmem and hugetlbfs.
>> +	 *
>> +	 * UFFD_FEATURE_WP_ASYNC indicates that userfaultfd write-protection
>> +	 * asynchronous mode is supported in which the write fault is automatically
>> +	 * resolved and write-protection is un-set. It only supports anon and shmem
>> +	 * (hugetlb isn't supported). It only takes effect when a vma is registered
>> +	 * with write-protection mode. Otherwise the flag is ignored.
>>  	 */
> 
> Most of mm/ adheres the 80-character limits. Please make your changes to
> follow it as well. 
Will update in next version.

> 
>>  #define UFFD_FEATURE_PAGEFAULT_FLAG_WP		(1<<0)
>>  #define UFFD_FEATURE_EVENT_FORK			(1<<1)
>> @@ -217,6 +224,7 @@ struct uffdio_api {
>>  #define UFFD_FEATURE_MINOR_SHMEM		(1<<10)
>>  #define UFFD_FEATURE_EXACT_ADDRESS		(1<<11)
>>  #define UFFD_FEATURE_WP_HUGETLBFS_SHMEM		(1<<12)
>> +#define UFFD_FEATURE_WP_ASYNC			(1<<13)
>>  	__u64 features;
>>  
>>  	__u64 ioctls;
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 4000e9f017e0..75331fbf7cb4 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -3351,8 +3351,21 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>>  
>>  	if (likely(!unshare)) {
>>  		if (userfaultfd_pte_wp(vma, *vmf->pte)) {
>> -			pte_unmap_unlock(vmf->pte, vmf->ptl);
>> -			return handle_userfault(vmf, VM_UFFD_WP);
>> +			if (userfaultfd_wp_async(vma)) {
>> +				/*
>> +				 * Nothing needed (cache flush, TLB invalidations,
>> +				 * etc.) because we're only removing the uffd-wp bit,
>> +				 * which is completely invisible to the user.
>> +				 */
>> +				pte_t pte = pte_clear_uffd_wp(*vmf->pte);
>> +
>> +				set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
>> +				/* Update this to be prepared for following up CoW handling */
>> +				vmf->orig_pte = pte;
>> +			} else {
>> +				pte_unmap_unlock(vmf->pte, vmf->ptl);
>> +				return handle_userfault(vmf, VM_UFFD_WP);
>> +			}
> 
> You can revert the condition here and reduce the nesting:
> 
> 			if (!userfaultfd_wp_async(vma)) {
> 				pte_unmap_unlock(vmf->pte, vmf->ptl);
> 				return handle_userfault(vmf, VM_UFFD_WP);
> 			}
> 
> 			/* handle async WP */
I'll update in next version.

> 
>>  		}
>>  
>>  		/*
>> @@ -4812,8 +4825,11 @@ static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
>>  
>>  	if (vma_is_anonymous(vmf->vma)) {
>>  		if (likely(!unshare) &&
>> -		    userfaultfd_huge_pmd_wp(vmf->vma, vmf->orig_pmd))
>> +		    userfaultfd_huge_pmd_wp(vmf->vma, vmf->orig_pmd)) {
>> +			if (userfaultfd_wp_async(vmf->vma))
>> +				goto split;
>>  			return handle_userfault(vmf, VM_UFFD_WP);
>> +		}
>>  		return do_huge_pmd_wp_page(vmf);
>>  	}
>>  
>> @@ -4825,6 +4841,7 @@ static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
>>  		}
>>  	}
>>  
>> +split:
>>  	/* COW or write-notify handled on pte level: split pmd. */
>>  	__split_huge_pmd(vmf->vma, vmf->pmd, vmf->address, false, NULL);
>>  
>> -- 
>> 2.30.2
>>
> 

-- 
BR,
Muhammad Usama Anjum
