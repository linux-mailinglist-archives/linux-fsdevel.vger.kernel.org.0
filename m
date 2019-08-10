Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A642D8871F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2019 02:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfHJAJ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Aug 2019 20:09:57 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17832 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfHJAJ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Aug 2019 20:09:57 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d4e0b5d0000>; Fri, 09 Aug 2019 17:10:06 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 09 Aug 2019 17:09:55 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 09 Aug 2019 17:09:55 -0700
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 10 Aug
 2019 00:09:55 +0000
Subject: Re: [RFC PATCH v2 15/19] mm/gup: Introduce vaddr_pin_pages()
To:     <ira.weiny@intel.com>, Andrew Morton <akpm@linux-foundation.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>, Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        <linux-xfs@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-ext4@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <20190809225833.6657-1-ira.weiny@intel.com>
 <20190809225833.6657-16-ira.weiny@intel.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <6ed26a08-4371-9dc1-09eb-7b8a4689d93b@nvidia.com>
Date:   Fri, 9 Aug 2019 17:09:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190809225833.6657-16-ira.weiny@intel.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565395806; bh=6gNuzZAjPm1drI86ijnE4uQ1M9Dnne0kRHnh1Jmmh9I=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=bpL5Ee4vSwNJx48EaIgEa1vW54C9BYxOuHJZXR2g0DimV8Jbzh9FRHk15PHeXZMt7
         3/XIvkM/NZxoMCLKXrSswHltiMKCAoppMwLtn2BNcmUd0Lw2sUJvyJyIaxd/yXSjd3
         LaYgfDzJsY3KevnitA9y+5kH//XcswK9sOikrJXKW9xfdNJxmtenjCD/AWehvcHIik
         y5CZMfyYhk4QKlqgr+QjwyqQWwWhf7J8xk1xm0vY75awN4I9ewl+//BoHKekZfNLOK
         ZxUnp+fBKdqhMrKGLYc8mXDRC+MO6XRKOuvv/2u6Q8pmbWfnTuoDHXlQnv60eq+LZw
         O5Ypby3VqT9Wg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/9/19 3:58 PM, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> The addition of FOLL_LONGTERM has taken on additional meaning for CMA
> pages.
> 
> In addition subsystems such as RDMA require new information to be passed
> to the GUP interface to track file owning information.  As such a simple
> FOLL_LONGTERM flag is no longer sufficient for these users to pin pages.
> 
> Introduce a new GUP like call which takes the newly introduced vaddr_pin
> information.  Failure to pass the vaddr_pin object back to a vaddr_put*
> call will result in a failure if pins were created on files during the
> pin operation.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from list:
> 	Change to vaddr_put_pages_dirty_lock
> 	Change to vaddr_unpin_pages_dirty_lock
> 
>  include/linux/mm.h |  5 ++++
>  mm/gup.c           | 59 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 64 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 657c947bda49..90c5802866df 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1603,6 +1603,11 @@ int account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc);
>  int __account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc,
>  			struct task_struct *task, bool bypass_rlim);
>  
> +long vaddr_pin_pages(unsigned long addr, unsigned long nr_pages,
> +		     unsigned int gup_flags, struct page **pages,
> +		     struct vaddr_pin *vaddr_pin);
> +void vaddr_unpin_pages_dirty_lock(struct page **pages, unsigned long nr_pages,
> +				  struct vaddr_pin *vaddr_pin, bool make_dirty);

Hi Ira,

OK, the API seems fine to me, anyway. :)

A bit more below...

>  bool mapping_inode_has_layout(struct vaddr_pin *vaddr_pin, struct page *page);
>  
>  /* Container for pinned pfns / pages */
> diff --git a/mm/gup.c b/mm/gup.c
> index eeaa0ddd08a6..6d23f70d7847 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2536,3 +2536,62 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(get_user_pages_fast);
> +
> +/**
> + * vaddr_pin_pages pin pages by virtual address and return the pages to the
> + * user.
> + *
> + * @addr, start address

What's with the commas? I thought kernel-doc wants colons, like this, right?

@addr: start address


> + * @nr_pages, number of pages to pin
> + * @gup_flags, flags to use for the pin
> + * @pages, array of pages returned
> + * @vaddr_pin, initalized meta information this pin is to be associated
> + * with.
> + *
> + * NOTE regarding vaddr_pin:
> + *
> + * Some callers can share pins via file descriptors to other processes.
> + * Callers such as this should use the f_owner field of vaddr_pin to indicate
> + * the file the fd points to.  All other callers should use the mm this pin is
> + * being made against.  Usually "current->mm".
> + *
> + * Expects mmap_sem to be read locked.
> + */
> +long vaddr_pin_pages(unsigned long addr, unsigned long nr_pages,
> +		     unsigned int gup_flags, struct page **pages,
> +		     struct vaddr_pin *vaddr_pin)
> +{
> +	long ret;
> +
> +	gup_flags |= FOLL_LONGTERM;


Is now the right time to introduce and use FOLL_PIN? If not, then I can always
add it on top of this later, as part of gup-tracking patches. But you did point
out that FOLL_LONGTERM is taking on additional meaning, and so maybe it's better
to split that meaning up right from the start.


> +
> +	if (!vaddr_pin || (!vaddr_pin->mm && !vaddr_pin->f_owner))
> +		return -EINVAL;
> +
> +	ret = __gup_longterm_locked(current,
> +				    vaddr_pin->mm,
> +				    addr, nr_pages,
> +				    pages, NULL, gup_flags,
> +				    vaddr_pin);
> +	return ret;
> +}
> +EXPORT_SYMBOL(vaddr_pin_pages);
> +
> +/**
> + * vaddr_unpin_pages_dirty_lock - counterpart to vaddr_pin_pages
> + *
> + * @pages, array of pages returned
> + * @nr_pages, number of pages in pages
> + * @vaddr_pin, same information passed to vaddr_pin_pages
> + * @make_dirty: whether to mark the pages dirty
> + *
> + * The semantics are similar to put_user_pages_dirty_lock but a vaddr_pin used
> + * in vaddr_pin_pages should be passed back into this call for propper

Typo:
                                                                  proper

> + * tracking.
> + */
> +void vaddr_unpin_pages_dirty_lock(struct page **pages, unsigned long nr_pages,
> +				  struct vaddr_pin *vaddr_pin, bool make_dirty)
> +{
> +	__put_user_pages_dirty_lock(vaddr_pin, pages, nr_pages, make_dirty);
> +}
> +EXPORT_SYMBOL(vaddr_unpin_pages_dirty_lock);
> 

OK, whew, I'm glad to see the updated _dirty_lock() API used here. :)

thanks,
-- 
John Hubbard
NVIDIA
