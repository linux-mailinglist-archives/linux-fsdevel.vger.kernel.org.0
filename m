Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B22E88712
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2019 02:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfHJAGr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Aug 2019 20:06:47 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17727 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfHJAGr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Aug 2019 20:06:47 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d4e0a9f0000>; Fri, 09 Aug 2019 17:06:55 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 09 Aug 2019 17:06:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 09 Aug 2019 17:06:45 -0700
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 10 Aug
 2019 00:06:44 +0000
Subject: Re: [RFC PATCH v2 09/19] mm/gup: Introduce vaddr_pin structure
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
 <20190809225833.6657-10-ira.weiny@intel.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <e92723cf-97a1-9860-9482-8466ff2feaa8@nvidia.com>
Date:   Fri, 9 Aug 2019 17:06:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190809225833.6657-10-ira.weiny@intel.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565395615; bh=jTuLvBzGh+kRCSFsoIGwjCgOacpl2q44m+IwnKc4d+0=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=izwR1/V7u6R4rPsmxBRUBZRR9/F2NLCDO+Jw6k19oSt+MczMwnsovxf3IqKW5nI2/
         3/QCYIcTnTfeTCmrFCBmCUus4X4UjXn/+DnCU0TtdxZM+7Ol5CgAQUA5CTFMsPQdyp
         vxVho4K/RzlmF3r/A+tJhDGCAVsidkv3A8TFn63cPRsZKXDwbt9Vd/5JqNloweOqAN
         Vr3hxEUUNo/XljBaDL1tsqD98/AHiYdndOCKZgRPCdctEPmYNm06OJ1q5oknXUlZr/
         DfTFOHtlAeRE45q/jSiZDXBvrROpK4a7RoVxqXDq/ibzLd0FnEbRB9IVoTq6zmwQHg
         tNADgPlRdswiA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/9/19 3:58 PM, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Some subsystems need to pass owning file information to GUP calls to
> allow for GUP to associate the "owning file" to any files being pinned
> within the GUP call.
> 
> Introduce an object to specify this information and pass it down through
> some of the GUP call stack.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  include/linux/mm.h |  9 +++++++++
>  mm/gup.c           | 36 ++++++++++++++++++++++--------------
>  2 files changed, 31 insertions(+), 14 deletions(-)
> 

Looks good, although you may want to combine it with the next patch. 
Otherwise it feels like a "to be continued" when you're reading them.

Either way, though:

    Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 04f22722b374..befe150d17be 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -971,6 +971,15 @@ static inline bool is_zone_device_page(const struct page *page)
>  }
>  #endif
>  
> +/**
> + * @f_owner The file who "owns this GUP"
> + * @mm The mm who "owns this GUP"
> + */
> +struct vaddr_pin {
> +	struct file *f_owner;
> +	struct mm_struct *mm;
> +};
> +
>  #ifdef CONFIG_DEV_PAGEMAP_OPS
>  void __put_devmap_managed_page(struct page *page);
>  DECLARE_STATIC_KEY_FALSE(devmap_managed_key);
> diff --git a/mm/gup.c b/mm/gup.c
> index 0b05e22ac05f..7a449500f0a6 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1005,7 +1005,8 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
>  						struct page **pages,
>  						struct vm_area_struct **vmas,
>  						int *locked,
> -						unsigned int flags)
> +						unsigned int flags,
> +						struct vaddr_pin *vaddr_pin)
>  {
>  	long ret, pages_done;
>  	bool lock_dropped;
> @@ -1165,7 +1166,8 @@ long get_user_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
>  
>  	return __get_user_pages_locked(tsk, mm, start, nr_pages, pages, vmas,
>  				       locked,
> -				       gup_flags | FOLL_TOUCH | FOLL_REMOTE);
> +				       gup_flags | FOLL_TOUCH | FOLL_REMOTE,
> +				       NULL);
>  }
>  EXPORT_SYMBOL(get_user_pages_remote);
>  
> @@ -1320,7 +1322,8 @@ static long __get_user_pages_locked(struct task_struct *tsk,
>  		struct mm_struct *mm, unsigned long start,
>  		unsigned long nr_pages, struct page **pages,
>  		struct vm_area_struct **vmas, int *locked,
> -		unsigned int foll_flags)
> +		unsigned int foll_flags,
> +		struct vaddr_pin *vaddr_pin)
>  {
>  	struct vm_area_struct *vma;
>  	unsigned long vm_flags;
> @@ -1504,7 +1507,7 @@ static long check_and_migrate_cma_pages(struct task_struct *tsk,
>  		 */
>  		nr_pages = __get_user_pages_locked(tsk, mm, start, nr_pages,
>  						   pages, vmas, NULL,
> -						   gup_flags);
> +						   gup_flags, NULL);
>  
>  		if ((nr_pages > 0) && migrate_allow) {
>  			drain_allow = true;
> @@ -1537,7 +1540,8 @@ static long __gup_longterm_locked(struct task_struct *tsk,
>  				  unsigned long nr_pages,
>  				  struct page **pages,
>  				  struct vm_area_struct **vmas,
> -				  unsigned int gup_flags)
> +				  unsigned int gup_flags,
> +				  struct vaddr_pin *vaddr_pin)
>  {
>  	struct vm_area_struct **vmas_tmp = vmas;
>  	unsigned long flags = 0;
> @@ -1558,7 +1562,7 @@ static long __gup_longterm_locked(struct task_struct *tsk,
>  	}
>  
>  	rc = __get_user_pages_locked(tsk, mm, start, nr_pages, pages,
> -				     vmas_tmp, NULL, gup_flags);
> +				     vmas_tmp, NULL, gup_flags, vaddr_pin);
>  
>  	if (gup_flags & FOLL_LONGTERM) {
>  		memalloc_nocma_restore(flags);
> @@ -1588,10 +1592,11 @@ static __always_inline long __gup_longterm_locked(struct task_struct *tsk,
>  						  unsigned long nr_pages,
>  						  struct page **pages,
>  						  struct vm_area_struct **vmas,
> -						  unsigned int flags)
> +						  unsigned int flags,
> +						  struct vaddr_pin *vaddr_pin)
>  {
>  	return __get_user_pages_locked(tsk, mm, start, nr_pages, pages, vmas,
> -				       NULL, flags);
> +				       NULL, flags, vaddr_pin);
>  }
>  #endif /* CONFIG_FS_DAX || CONFIG_CMA */
>  
> @@ -1607,7 +1612,8 @@ long get_user_pages(unsigned long start, unsigned long nr_pages,
>  		struct vm_area_struct **vmas)
>  {
>  	return __gup_longterm_locked(current, current->mm, start, nr_pages,
> -				     pages, vmas, gup_flags | FOLL_TOUCH);
> +				     pages, vmas, gup_flags | FOLL_TOUCH,
> +				     NULL);
>  }
>  EXPORT_SYMBOL(get_user_pages);
>  
> @@ -1647,7 +1653,7 @@ long get_user_pages_locked(unsigned long start, unsigned long nr_pages,
>  
>  	return __get_user_pages_locked(current, current->mm, start, nr_pages,
>  				       pages, NULL, locked,
> -				       gup_flags | FOLL_TOUCH);
> +				       gup_flags | FOLL_TOUCH, NULL);
>  }
>  EXPORT_SYMBOL(get_user_pages_locked);
>  
> @@ -1684,7 +1690,7 @@ long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
>  
>  	down_read(&mm->mmap_sem);
>  	ret = __get_user_pages_locked(current, mm, start, nr_pages, pages, NULL,
> -				      &locked, gup_flags | FOLL_TOUCH);
> +				      &locked, gup_flags | FOLL_TOUCH, NULL);
>  	if (locked)
>  		up_read(&mm->mmap_sem);
>  	return ret;
> @@ -2377,7 +2383,8 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
>  EXPORT_SYMBOL_GPL(__get_user_pages_fast);
>  
>  static int __gup_longterm_unlocked(unsigned long start, int nr_pages,
> -				   unsigned int gup_flags, struct page **pages)
> +				   unsigned int gup_flags, struct page **pages,
> +				   struct vaddr_pin *vaddr_pin)
>  {
>  	int ret;
>  
> @@ -2389,7 +2396,8 @@ static int __gup_longterm_unlocked(unsigned long start, int nr_pages,
>  		down_read(&current->mm->mmap_sem);
>  		ret = __gup_longterm_locked(current, current->mm,
>  					    start, nr_pages,
> -					    pages, NULL, gup_flags);
> +					    pages, NULL, gup_flags,
> +					    vaddr_pin);
>  		up_read(&current->mm->mmap_sem);
>  	} else {
>  		ret = get_user_pages_unlocked(start, nr_pages,
> @@ -2448,7 +2456,7 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
>  		pages += nr;
>  
>  		ret = __gup_longterm_unlocked(start, nr_pages - nr,
> -					      gup_flags, pages);
> +					      gup_flags, pages, NULL);
>  
>  		/* Have to be a bit careful with return values */
>  		if (nr > 0) {
> 
