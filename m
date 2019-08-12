Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53FF38AA5B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 00:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfHLWVx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 18:21:53 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13137 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfHLWVw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 18:21:52 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d51e6800000>; Mon, 12 Aug 2019 15:21:52 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 12 Aug 2019 15:21:50 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 12 Aug 2019 15:21:50 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 12 Aug
 2019 22:21:50 +0000
Subject: Re: [RFC PATCH 2/2] mm/gup: introduce vaddr_pin_pages_remote()
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-rdma@vger.kernel.org>
References: <20190812015044.26176-1-jhubbard@nvidia.com>
 <20190812015044.26176-3-jhubbard@nvidia.com>
 <20190812220340.GA26305@iweiny-DESK2.sc.intel.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <0b66c1f8-c694-7971-b2d3-e1dd53a0f103@nvidia.com>
Date:   Mon, 12 Aug 2019 15:21:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190812220340.GA26305@iweiny-DESK2.sc.intel.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565648512; bh=uQPl7D4DEl8AVSuP+2Fq2Helx9cv9AvXMSaieCMT7oA=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=lDBMVyRnFKunGUOR/0vpLpZtJOa9QH7VEGqfPR59AhGyeeukIzGUoz9b2kBImVw7H
         y8cnr9Sd//+TBEcrXo9JyNphHRFzRQgJ85myw2lNi+kM6UpUUnytx9+GhUeXP9FKZ3
         RgoJQNeEGGMUnduEAVPhVoM3HZX/ST0NXgedIKw8OttfofCcgaRwxUvU0yjmLHTOzG
         m5CZ8Z7yajenjJDzRcT7W+lJF+01cDcxKn2xWig68moCWvUMubbCMJ6xnFNn5c/Kga
         oo7WH7P6nyLqX/egqMWZyT9SX3Cawy0d9q4Ay6DRQakwmqgJWdNqonVaHWGMH2xGSU
         8GUs/eRg3PT6Q==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/12/19 3:03 PM, Ira Weiny wrote:
> On Sun, Aug 11, 2019 at 06:50:44PM -0700, john.hubbard@gmail.com wrote:
>> From: John Hubbard <jhubbard@nvidia.com>
...
>> +/**
>> + * vaddr_pin_pages pin pages by virtual address and return the pages to the
> 
> vaddr_pin_pages_remote
> 
> Fixed in my tree.


thanks. :)


> 
>> + * user.
>> + *
>> + * @tsk:	the task_struct to use for page fault accounting, or
>> + *		NULL if faults are not to be recorded.
>> + * @mm:		mm_struct of target mm
>> + * @addr:	start address
>> + * @nr_pages:	number of pages to pin
>> + * @gup_flags:	flags to use for the pin
>> + * @pages:	array of pages returned
>> + * @vaddr_pin:	initialized meta information this pin is to be associated
>> + * with.
>> + *
>> + * This is the "vaddr_pin_pages" corresponding variant to
>> + * get_user_pages_remote(), but with FOLL_PIN semantics: the implementation sets
>> + * FOLL_PIN. That, in turn, means that the pages must ultimately be released
>> + * by put_user_page().
>> + */
>> +long vaddr_pin_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
>> +			    unsigned long start, unsigned long nr_pages,
>> +			    unsigned int gup_flags, struct page **pages,
>> +			    struct vm_area_struct **vmas, int *locked,
>> +			    struct vaddr_pin *vaddr_pin)
>> +{
>> +	gup_flags |= FOLL_TOUCH | FOLL_REMOTE | FOLL_PIN;
>> +
>> +	return __get_user_pages_locked(tsk, mm, start, nr_pages, pages, vmas,
>> +				       locked, gup_flags, vaddr_pin);
>> +}
>> +EXPORT_SYMBOL(vaddr_pin_pages_remote);
>> +
>>  /**
>>   * vaddr_unpin_pages_dirty_lock - counterpart to vaddr_pin_pages
>>   *
>> @@ -2536,3 +2568,21 @@ void vaddr_unpin_pages_dirty_lock(struct page **pages, unsigned long nr_pages,
>>  	__put_user_pages_dirty_lock(vaddr_pin, pages, nr_pages, make_dirty);
>>  }
>>  EXPORT_SYMBOL(vaddr_unpin_pages_dirty_lock);
>> +
>> +/**
>> + * vaddr_unpin_pages - simple, non-dirtying counterpart to vaddr_pin_pages
>> + *
>> + * @pages: array of pages returned
>> + * @nr_pages: number of pages in pages
>> + * @vaddr_pin: same information passed to vaddr_pin_pages
>> + *
>> + * Like vaddr_unpin_pages_dirty_lock, but for non-dirty pages. Useful in putting
>> + * back pages in an error case: they were never made dirty.
>> + */
>> +void vaddr_unpin_pages(struct page **pages, unsigned long nr_pages,
>> +		       struct vaddr_pin *vaddr_pin)
>> +{
>> +	__put_user_pages_dirty_lock(vaddr_pin, pages, nr_pages, false);
>> +}
>> +EXPORT_SYMBOL(vaddr_unpin_pages);
> 
> Rather than have another wrapping call why don't we just do this?  Would it be
> so bad to just have to specify false for make_dirty?

Sure, passing in false for make_dirty is fine, and in fact, there may even be
error cases I've forgotten about that *want* to dirty the page. 

I thought about these variants, and realized that we don't generally need to 
say "lock" anymore, because we're going to forcibly use set_page_dirty_lock 
(rather than set_page_dirty) in this part of the code. And a shorter name 
is nice. Since you've dropped both "_dirty" and "_lock" from the function 
name, it's still nice and short even though we pass in make_dirty as an arg.

So that's a long-winded, "the API below looks good to me". :)

> 
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index e77b250c1307..ca660a5e8206 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2540,7 +2540,7 @@ long vaddr_pin_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
>  EXPORT_SYMBOL(vaddr_pin_pages_remote);
>  
>  /**
> - * vaddr_unpin_pages_dirty_lock - counterpart to vaddr_pin_pages
> + * vaddr_unpin_pages - counterpart to vaddr_pin_pages
>   *
>   * @pages: array of pages returned
>   * @nr_pages: number of pages in pages
> @@ -2551,26 +2551,9 @@ EXPORT_SYMBOL(vaddr_pin_pages_remote);
>   * in vaddr_pin_pages should be passed back into this call for proper
>   * tracking.
>   */
> -void vaddr_unpin_pages_dirty_lock(struct page **pages, unsigned long nr_pages,
> -                                 struct vaddr_pin *vaddr_pin, bool make_dirty)
> +void vaddr_unpin_pages(struct page **pages, unsigned long nr_pages,
> +                      struct vaddr_pin *vaddr_pin, bool make_dirty)
>  {
>         __put_user_pages_dirty_lock(vaddr_pin, pages, nr_pages, make_dirty);
>  }
>  EXPORT_SYMBOL(vaddr_unpin_pages_dirty_lock);
> -
> -/**
> - * vaddr_unpin_pages - simple, non-dirtying counterpart to vaddr_pin_pages
> - *
> - * @pages: array of pages returned
> - * @nr_pages: number of pages in pages
> - * @vaddr_pin: same information passed to vaddr_pin_pages
> - *
> - * Like vaddr_unpin_pages_dirty_lock, but for non-dirty pages. Useful in putting
> - * back pages in an error case: they were never made dirty.
> - */
> -void vaddr_unpin_pages(struct page **pages, unsigned long nr_pages,
> -                      struct vaddr_pin *vaddr_pin)
> -{
> -       __put_user_pages_dirty_lock(vaddr_pin, pages, nr_pages, false);
> -}
> -EXPORT_SYMBOL(vaddr_unpin_pages);
> 

thanks,
-- 
John Hubbard
NVIDIA
