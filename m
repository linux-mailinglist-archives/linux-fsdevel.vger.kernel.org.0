Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDA742E0FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 20:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbhJNSTL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 14:19:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:45546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230119AbhJNSTL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 14:19:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7E8760EBB;
        Thu, 14 Oct 2021 18:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634235425;
        bh=nk2O1INGQJeoYK2hz0/chQbDTBJGcPDWQbYrayE/aaM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i+GrwntAyD87EpYdHQzMGU2dlEGyPdLmLrRmggCA7m4PKbBfzhbxM9H54jEdEt4kF
         LwrGHNmrP8B77ITYnhupmqdyqnYbspZYu1KEpKMRBa2L3NZ5+efhGHMF9wTFm6sdPt
         4SwK0t0pfsOslTSXJO76mpfsxC13CDfQs+C2TmrdyW3MpPwomgxD5iVmaVWzIsLGze
         nANB+3Ao+C53dm0OvlLJGSPRppCYDIRaTQUxc4CewrH91C3m32y3RyHBX8l+VarIii
         QivlIQhM6K0c/F1/qguP1EPvZPZjKp7CpcrxhwEBod+TS+9soi3Y6mOffwsz8gN6Nm
         nOiIxQWIeqLVA==
Date:   Thu, 14 Oct 2021 11:17:05 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, dan.j.williams@intel.com,
        david@fromorbit.com, hch@infradead.org, jane.chu@oracle.com
Subject: Re: [PATCH v7 5/8] fsdax: Introduce dax_lock_mapping_entry()
Message-ID: <20211014181705.GH24307@magnolia>
References: <20210924130959.2695749-1-ruansy.fnst@fujitsu.com>
 <20210924130959.2695749-6-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924130959.2695749-6-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 24, 2021 at 09:09:56PM +0800, Shiyang Ruan wrote:
> The current dax_lock_page() locks dax entry by obtaining mapping and
> index in page.  To support 1-to-N RMAP in NVDIMM, we need a new function
> to lock a specific dax entry corresponding to this file's mapping,index.
> And BTW, output the page corresponding to the specific dax entry for
> caller use.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  fs/dax.c            | 65 ++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/dax.h | 15 +++++++++++
>  2 files changed, 79 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 798c43f09eee..509b65e60478 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -390,7 +390,7 @@ static struct page *dax_busy_page(void *entry)
>  }
>  
>  /*
> - * dax_lock_mapping_entry - Lock the DAX entry corresponding to a page
> + * dax_lock_page - Lock the DAX entry corresponding to a page
>   * @page: The page whose entry we want to lock
>   *
>   * Context: Process context.
> @@ -455,6 +455,69 @@ void dax_unlock_page(struct page *page, dax_entry_t cookie)
>  	dax_unlock_entry(&xas, (void *)cookie);
>  }
>  
> +/*
> + * dax_lock_mapping_entry - Lock the DAX entry corresponding to a mapping
> + * @mapping: the file's mapping whose entry we want to lock
> + * @index: the offset within this file
> + * @page: output the dax page corresponding to this dax entry
> + *
> + * Return: A cookie to pass to dax_unlock_mapping_entry() or 0 if the entry
> + * could not be locked.
> + */
> +dax_entry_t dax_lock_mapping_entry(struct address_space *mapping, pgoff_t index,
> +		struct page **page)
> +{
> +	XA_STATE(xas, NULL, 0);
> +	void *entry;
> +
> +	rcu_read_lock();
> +	for (;;) {
> +		entry = NULL;
> +		if (!dax_mapping(mapping))
> +			break;
> +
> +		xas.xa = &mapping->i_pages;
> +		xas_lock_irq(&xas);
> +		xas_set(&xas, index);
> +		entry = xas_load(&xas);
> +		if (dax_is_locked(entry)) {
> +			rcu_read_unlock();
> +			wait_entry_unlocked(&xas, entry);
> +			rcu_read_lock();
> +			continue;
> +		}
> +		if (!entry ||
> +		    dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
> +			/*
> +			 * Because we are looking for entry from file's mapping
> +			 * and index, so the entry may not be inserted for now,
> +			 * or even a zero/empty entry.  We don't think this is
> +			 * an error case.  So, return a special value and do
> +			 * not output @page.
> +			 */
> +			entry = (void *)~0UL;

I kinda wonder if these open-coded magic values ~0UL (no entry) and 0
(cannot lock) should be #defines that force-cast the magic value to
dax_entry_t...

...but then I'm not really an expert in the design behind fs/dax.c --
this part looks reasonable enough to me, but I think Dan or Matthew
ought to look this over.

--D

> +		} else {
> +			*page = pfn_to_page(dax_to_pfn(entry));
> +			dax_lock_entry(&xas, entry);
> +		}
> +		xas_unlock_irq(&xas);
> +		break;
> +	}
> +	rcu_read_unlock();
> +	return (dax_entry_t)entry;
> +}
> +
> +void dax_unlock_mapping_entry(struct address_space *mapping, pgoff_t index,
> +		dax_entry_t cookie)
> +{
> +	XA_STATE(xas, &mapping->i_pages, index);
> +
> +	if (cookie == ~0UL)
> +		return;
> +
> +	dax_unlock_entry(&xas, (void *)cookie);
> +}
> +
>  /*
>   * Find page cache entry at given index. If it is a DAX entry, return it
>   * with the entry locked. If the page cache doesn't contain an entry at
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index d273d59723cd..65411bee4312 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -156,6 +156,10 @@ struct page *dax_layout_busy_page(struct address_space *mapping);
>  struct page *dax_layout_busy_page_range(struct address_space *mapping, loff_t start, loff_t end);
>  dax_entry_t dax_lock_page(struct page *page);
>  void dax_unlock_page(struct page *page, dax_entry_t cookie);
> +dax_entry_t dax_lock_mapping_entry(struct address_space *mapping,
> +		unsigned long index, struct page **page);
> +void dax_unlock_mapping_entry(struct address_space *mapping,
> +		unsigned long index, dax_entry_t cookie);
>  #else
>  #define generic_fsdax_supported		NULL
>  
> @@ -201,6 +205,17 @@ static inline dax_entry_t dax_lock_page(struct page *page)
>  static inline void dax_unlock_page(struct page *page, dax_entry_t cookie)
>  {
>  }
> +
> +static inline dax_entry_t dax_lock_mapping_entry(struct address_space *mapping,
> +		unsigned long index, struct page **page)
> +{
> +	return 0;
> +}
> +
> +static inline void dax_unlock_mapping_entry(struct address_space *mapping,
> +		unsigned long index, dax_entry_t cookie)
> +{
> +}
>  #endif
>  
>  #if IS_ENABLED(CONFIG_DAX)
> -- 
> 2.33.0
> 
> 
> 
