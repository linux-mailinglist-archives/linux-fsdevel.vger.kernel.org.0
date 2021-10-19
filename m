Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23846432D73
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 07:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbhJSFyo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 01:54:44 -0400
Received: from out0.migadu.com ([94.23.1.103]:61195 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233786AbhJSFyn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 01:54:43 -0400
Date:   Tue, 19 Oct 2021 14:52:21 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1634622748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eleFrI14OL3nhvSbN5u9PeAeR7eMrpEMGjnceXAO42w=;
        b=dJZ910Bq7uAQPTACw1YuK1xa43xV5o64PfQlD/qatlaV4qPpHaZGvPaCtxlGkVu01rYZV1
        MnuCpNomxvOZCDuchCqK++KnbLxFWM+YCnk/MQ4mMJQ1tNABQv7a2y6f07NDLJVSj2EZqT
        Qe2DIIjUHmjM9w9opjuZqbMgAO7sEOc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Yang Shi <shy828301@gmail.com>
Cc:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        peterx@redhat.com, osalvador@suse.de, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v4 PATCH 5/6] mm: shmem: don't truncate page if memory failure
 happens
Message-ID: <20211019055221.GC2268449@u2004>
References: <20211014191615.6674-1-shy828301@gmail.com>
 <20211014191615.6674-6-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211014191615.6674-6-shy828301@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: naoya.horiguchi@linux.dev
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 14, 2021 at 12:16:14PM -0700, Yang Shi wrote:
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
>  mm/memory-failure.c | 10 +++++++++-
>  mm/shmem.c          | 37 ++++++++++++++++++++++++++++++++++---
>  mm/userfaultfd.c    |  5 +++++
>  3 files changed, 48 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index cdf8ccd0865f..f5eab593b2a7 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -57,6 +57,7 @@
>  #include <linux/ratelimit.h>
>  #include <linux/page-isolation.h>
>  #include <linux/pagewalk.h>
> +#include <linux/shmem_fs.h>
>  #include "internal.h"
>  #include "ras/ras_event.h"
>  
> @@ -866,6 +867,7 @@ static int me_pagecache_clean(struct page_state *ps, struct page *p)
>  {
>  	int ret;
>  	struct address_space *mapping;
> +	bool extra_pins;
>  
>  	delete_from_lru_cache(p);
>  
> @@ -894,6 +896,12 @@ static int me_pagecache_clean(struct page_state *ps, struct page *p)
>  		goto out;
>  	}
>  
> +	/*
> +	 * The shmem page is kept in page cache instead of truncating
> +	 * so is expected to have an extra refcount after error-handling.
> +	 */
> +	extra_pins = shmem_mapping(mapping);
> +
>  	/*
>  	 * Truncation is a bit tricky. Enable it per file system for now.
>  	 *
> @@ -903,7 +911,7 @@ static int me_pagecache_clean(struct page_state *ps, struct page *p)
>  out:
>  	unlock_page(p);
>  
> -	if (has_extra_refcount(ps, p, false))
> +	if (has_extra_refcount(ps, p, extra_pins))
>  		ret = MF_FAILED;
>  
>  	return ret;
> diff --git a/mm/shmem.c b/mm/shmem.c
> index b5860f4a2738..69eaf65409e6 100644
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
> @@ -2466,7 +2467,15 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
>  			return -EPERM;
>  	}
>  
> -	return shmem_getpage(inode, index, pagep, SGP_WRITE);
> +	ret = shmem_getpage(inode, index, pagep, SGP_WRITE);
> +
> +	if (*pagep && PageHWPoison(*pagep)) {

shmem_getpage() could return with pagep == NULL, so you need check ret first
to avoid NULL pointer dereference.

> +		unlock_page(*pagep);
> +		put_page(*pagep);
> +		ret = -EIO;
> +	}
> +
> +	return ret;
>  }
>  
>  static int
> @@ -2555,6 +2564,11 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  			unlock_page(page);
>  		}
>  
> +		if (page && PageHWPoison(page)) {
> +			error = -EIO;

Is it cleaner to add PageHWPoison() check in the existing "if (page)" block
just above?  Then, you don't have to check "page != NULL" twice.

@@ -2562,7 +2562,11 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
                        if (sgp == SGP_CACHE)
                                set_page_dirty(page);
                        unlock_page(page);

+                       if (PageHWPoison(page)) {
+                               error = -EIO;
+                               break;
+                       }
                }

                /*


Thanks,
Naoya Horiguchi
