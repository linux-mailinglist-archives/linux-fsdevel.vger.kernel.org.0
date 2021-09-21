Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12DC54130EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 11:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbhIUJuy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 05:50:54 -0400
Received: from out0.migadu.com ([94.23.1.103]:57218 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231435AbhIUJuy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 05:50:54 -0400
Date:   Tue, 21 Sep 2021 18:49:15 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1632217764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Quq+0jhOskeL/K3WU9X/OZRgaVP3m6IJiCXAdpAnFeA=;
        b=MkwFFnRmyXHMxZ11CLpYFa99w3IOyuVE6xQBoEO8hx/6pSBEG0fUnXVpV2hk6CUTiLUZ//
        21mf6T5dlVnQNkJEOFY70W8foUumsNIp57hsb1X8FqmfzsM+FJJJMti6+jRET/P8DQerB3
        ZnWt5HDBfJTUGIMz5whC/XEt6pC7Mfc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Yang Shi <shy828301@gmail.com>
Cc:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        osalvador@suse.de, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] mm: shmem: don't truncate page if memory failure
 happens
Message-ID: <20210921094915.GA817765@u2004>
References: <20210914183718.4236-1-shy828301@gmail.com>
 <20210914183718.4236-4-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210914183718.4236-4-shy828301@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: naoya.horiguchi@linux.dev
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 14, 2021 at 11:37:17AM -0700, Yang Shi wrote:
> The current behavior of memory failure is to truncate the page cache
> regardless of dirty or clean.  If the page is dirty the later access
> will get the obsolete data from disk without any notification to the
> users.  This may cause silent data loss.  It is even worse for shmem
> since shmem is in-memory filesystem, truncating page cache means
> discarding data blocks.  The later read would return all zero.
> 
> The right approach is to keep the corrupted page in page cache, any
> later access would return error for syscalls or SIGBUS for page fault,
> until the file is truncated, hole punched or removed.  The regular
> storage backed filesystems would be more complicated so this patch
> is focused on shmem.  This also unblock the support for soft
> offlining shmem THP.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  mm/memory-failure.c |  3 ++-
>  mm/shmem.c          | 25 +++++++++++++++++++++++--
>  2 files changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 54879c339024..3e06cb9d5121 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1101,7 +1101,8 @@ static int page_action(struct page_state *ps, struct page *p,
>  	result = ps->action(p, pfn);
>  
>  	count = page_count(p) - 1;
> -	if (ps->action == me_swapcache_dirty && result == MF_DELAYED)
> +	if ((ps->action == me_swapcache_dirty && result == MF_DELAYED) ||
> +	    (ps->action == me_pagecache_dirty && result == MF_FAILED))

This new line seems to affect the cases of dirty page cache
on other filesystems, whose result is to miss "still referenced"
messages for some unmap failure cases (although it's not so critical).
So checking filesystem type (for example with shmem_mapping())
might be helpful?

And I think that if we might want to have some refactoring to pass
*ps to each ps->action() callback, then move this refcount check to
the needed places.
I don't think that we always need the refcount check, for example in
MF_MSG_KERNEL and MF_MSG_UNKNOWN cases (because no one knows the
expected values for these cases).


>  		count--;
>  	if (count > 0) {
>  		pr_err("Memory failure: %#lx: %s still referenced by %d users\n",
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 88742953532c..ec33f4f7173d 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2456,6 +2456,7 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
>  	struct inode *inode = mapping->host;
>  	struct shmem_inode_info *info = SHMEM_I(inode);
>  	pgoff_t index = pos >> PAGE_SHIFT;
> +	int ret = 0;
>  
>  	/* i_rwsem is held by caller */
>  	if (unlikely(info->seals & (F_SEAL_GROW |
> @@ -2466,7 +2467,19 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
>  			return -EPERM;
>  	}
>  
> -	return shmem_getpage(inode, index, pagep, SGP_WRITE);
> +	ret = shmem_getpage(inode, index, pagep, SGP_WRITE);
> +
> +	if (!ret) {

Maybe this "!ret" check is not necessary because *pagep is set
non-NULL only when ret is 0.  It could save one indent level.

> +		if (*pagep) {
> +			if (PageHWPoison(*pagep)) {
> +				unlock_page(*pagep);
> +				put_page(*pagep);
> +				ret = -EIO;
> +			}
> +		}
> +	}
> +
> +	return ret;
>  }
>  
>  static int
> @@ -2555,6 +2568,11 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  			unlock_page(page);
>  		}
>  
> +		if (page && PageHWPoison(page)) {
> +			error = -EIO;
> +			break;
> +		}
> +
>  		/*
>  		 * We must evaluate after, since reads (unlike writes)
>  		 * are called without i_rwsem protection against truncate
> @@ -3782,7 +3800,6 @@ const struct address_space_operations shmem_aops = {
>  #ifdef CONFIG_MIGRATION
>  	.migratepage	= migrate_page,
>  #endif
> -	.error_remove_page = generic_error_remove_page,

This change makes truncate_error_page() calls invalidate_inode_page(),
and in my testing it fails with "Failed to invalidate" message.
So as a result memory_failure() finally returns with -EBUSY. I'm not
sure it's expected because this patchset changes to keep error pages
in page cache as a proper error handling.
Maybe you can avoid this by defining .error_remove_page in shmem_aops
which simply returns 0.

>  };
>  EXPORT_SYMBOL(shmem_aops);
>  
> @@ -4193,6 +4210,10 @@ struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
>  		page = ERR_PTR(error);
>  	else
>  		unlock_page(page);
> +
> +	if (PageHWPoison(page))
> +		page = NULL;
> +
>  	return page;

One more comment ...

  - I guess that you add PageHWPoison() checks after some call sites
    of shmem_getpage() and shmem_getpage_gfp(), but seems not cover all.
    For example, mcontinue_atomic_pte() in mm/userfaultfd.c can properly
    handle PageHWPoison?

I'm trying to test more detail, but in my current understanding,
this patch looks promising to me.  Thank you for your effort.

Thanks,
Naoya Horiguchi
