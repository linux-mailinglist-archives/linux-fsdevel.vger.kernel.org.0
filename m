Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B65EB163624
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 23:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgBRWdV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 17:33:21 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:18969 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgBRWdV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 17:33:21 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e4c65e90000>; Tue, 18 Feb 2020 14:32:09 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 18 Feb 2020 14:33:20 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 18 Feb 2020 14:33:20 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Feb
 2020 22:33:19 +0000
Subject: Re: [PATCH v6 04/19] mm: Rearrange readahead loop
To:     Matthew Wilcox <willy@infradead.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-btrfs@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <cluster-devel@redhat.com>, <ocfs2-devel@oss.oracle.com>,
        <linux-xfs@vger.kernel.org>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-5-willy@infradead.org>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <6ecedc28-a999-8673-e4b1-349b0c23fdfd@nvidia.com>
Date:   Tue, 18 Feb 2020 14:33:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200217184613.19668-5-willy@infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582065129; bh=yWG75TuvaIkixcYjAReAuF+49IUj/8WtcUdupEFzEyw=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=klykhDzbfDnFoiAzHG0F/sl3+zuD/yu0U05wkkG5YL25K0mXMn/SZDKS/OPYoMjVi
         mBSMyFlXKKo4UAQQuQv/lsdIWAvE7WxiS+oOmcGMSJDykk7YuHI6JFzdcykchFj71k
         zIa5A9cfCBqyTcR6zGjigkGmcGSCKI7dxvmn+IuKHqErApkB59r3L/Gj+RxcTKKVSI
         +btrOqRw+4ZZVhqAz1RhfcawzguTRlv7l99v2wGxH6VlakfW2nQLeICs16ez9TeiWQ
         ZpdA450G/HarSR+IiezZDL9QVYoCyXag0rX4h00yKEt9Soza8Wdn/b85Sc2AMZZmq3
         fR1BnLTnbzkPg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/17/20 10:45 AM, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Move the declaration of 'page' to inside the loop and move the 'kick
> off a fresh batch' code to the end of the function for easier use in
> subsequent patches.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/readahead.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 15329309231f..3eca59c43a45 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -154,7 +154,6 @@ void __do_page_cache_readahead(struct address_space *mapping,
>  		unsigned long lookahead_size)
>  {
>  	struct inode *inode = mapping->host;
> -	struct page *page;
>  	unsigned long end_index;	/* The last page we want to read */
>  	LIST_HEAD(page_pool);
>  	int page_idx;
> @@ -175,6 +174,7 @@ void __do_page_cache_readahead(struct address_space *mapping,
>  	 * Preallocate as many pages as we will need.
>  	 */
>  	for (page_idx = 0; page_idx < nr_to_read; page_idx++) {
> +		struct page *page;
>  		pgoff_t page_offset = offset + page_idx;
>  
>  		if (page_offset > end_index)
> @@ -183,14 +183,14 @@ void __do_page_cache_readahead(struct address_space *mapping,
>  		page = xa_load(&mapping->i_pages, page_offset);
>  		if (page && !xa_is_value(page)) {
>  			/*
> -			 * Page already present?  Kick off the current batch of
> -			 * contiguous pages before continuing with the next
> -			 * batch.
> +			 * Page already present?  Kick off the current batch
> +			 * of contiguous pages before continuing with the
> +			 * next batch.  This page may be the one we would
> +			 * have intended to mark as Readahead, but we don't
> +			 * have a stable reference to this page, and it's
> +			 * not worth getting one just for that.
>  			 */
> -			if (readahead_count(&rac))
> -				read_pages(&rac, &page_pool, gfp_mask);
> -			rac._nr_pages = 0;
> -			continue;


A fine point:  you'll get better readability and a less complex function by
factoring that into a static subroutine, instead of jumping around with 
goto's. (This clearly wants to be a subroutine, and in fact you've effectively 
created one inside this function, at the "read:" label. Either way, though...


> +			goto read;
>  		}
>  
>  		page = __page_cache_alloc(gfp_mask);
> @@ -201,6 +201,11 @@ void __do_page_cache_readahead(struct address_space *mapping,
>  		if (page_idx == nr_to_read - lookahead_size)
>  			SetPageReadahead(page);
>  		rac._nr_pages++;
> +		continue;
> +read:
> +		if (readahead_count(&rac))
> +			read_pages(&rac, &page_pool, gfp_mask);
> +		rac._nr_pages = 0;
>  	}
>  
>  	/*
> 

...no errors spotted, I'm confident that this patch is correct,

    Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA
