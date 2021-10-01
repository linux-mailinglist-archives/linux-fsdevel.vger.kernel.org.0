Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4979A41E7FA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Oct 2021 09:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352160AbhJAHHe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Oct 2021 03:07:34 -0400
Received: from out2.migadu.com ([188.165.223.204]:23452 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352015AbhJAHHd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Oct 2021 03:07:33 -0400
Date:   Fri, 1 Oct 2021 16:05:39 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1633071948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GvGmNJe2m6c7do6Iwp74+Xpwugj6O+M8yPQxd3iIJ60=;
        b=pMQryGTJW4ett9e1r6f81QtKAR+z8Lz88hg1yr+o5gM67pKsLpUqSYDJ7x2N2M4lTj9fzP
        yn7DOVLePs4+oWKlJk4DnoPMc1qqCk8/dDLI+mePZPoI5OOCU9xbi7AhtH8cspOO2cOb+z
        +z1HA4+UjMWnWl9A2k/euhFFAzvbu5A=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Yang Shi <shy828301@gmail.com>
Cc:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        peterx@redhat.com, osalvador@suse.de, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH 4/5] mm: shmem: don't truncate page if memory failure
 happens
Message-ID: <20211001070539.GA1364952@u2004>
References: <20210930215311.240774-1-shy828301@gmail.com>
 <20210930215311.240774-5-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210930215311.240774-5-shy828301@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: naoya.horiguchi@linux.dev
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 30, 2021 at 02:53:10PM -0700, Yang Shi wrote:
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
...
> @@ -894,6 +896,12 @@ static int me_pagecache_clean(struct page_state *ps, struct page *p)
>  		goto out;
>  	}
>  
> +	/*
> +	 * The shmem page is kept in page cache instead of truncating
> +	 * so need decrement the refcount from page cache.
> +	 */

This comment seems to me confusing because no refcount is decremented here.
What the variable dec tries to do is to give the expected value of the
refcount of the error page after successfull erorr handling, which differs
according to the page state before error handling, so dec adjusts it.

How about the below?

+	/*
+	 * The shmem page is kept in page cache instead of truncating
+	 * so is expected to have an extra refcount after error-handling.
+	 */

> +	dec = shmem_mapping(mapping);
> +
>  	/*
>  	 * Truncation is a bit tricky. Enable it per file system for now.
>  	 *
...
> @@ -2466,7 +2467,17 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
>  			return -EPERM;
>  	}
>  
> -	return shmem_getpage(inode, index, pagep, SGP_WRITE);
> +	ret = shmem_getpage(inode, index, pagep, SGP_WRITE);
> +
> +	if (*pagep) {
> +		if (PageHWPoison(*pagep)) {

Unless you plan to add some code in the near future, how about merging
these two if sentences?

	if (*pagep && PageHWPoison(*pagep)) {

Thanks,
Naoya Horiguchi

> +			unlock_page(*pagep);
> +			put_page(*pagep);
> +			ret = -EIO;
> +		}
> +	}
> +
> +	return ret;
>  }
>  
>  static int
