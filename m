Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCDB166E7B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 05:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbgBUEYy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 23:24:54 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17855 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729562AbgBUEYy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 23:24:54 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e4f5b870000>; Thu, 20 Feb 2020 20:24:39 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 20 Feb 2020 20:24:53 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 20 Feb 2020 20:24:53 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 21 Feb
 2020 04:24:52 +0000
Subject: Re: [PATCH v7 04/24] mm: Move readahead nr_pages check into
 read_pages
To:     Matthew Wilcox <willy@infradead.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-btrfs@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <cluster-devel@redhat.com>, <ocfs2-devel@oss.oracle.com>,
        <linux-xfs@vger.kernel.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-5-willy@infradead.org>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <89a2e3d1-df95-f006-24d9-76a4b7dd230b@nvidia.com>
Date:   Thu, 20 Feb 2020 20:24:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200219210103.32400-5-willy@infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582259079; bh=ASKxt3bijyoYwdw1pDufntJpHzO9oNcu8Dw674S+ZbU=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=heUrjhw3xqeEYQuBuoBasbu56gpWlnwZt+AdI2wq+B9NZbvczA0FSHtDGsaVb4Naf
         bnLZHSctgsoXIEuM1CeqQs2bSg86B5wpOR88JYaRMGaVNCFZ0llOWVBqfWBe1dfYIU
         BUwh2YAMS+RWhS/AXveX566mq203Kwd9VMWWIOhSUurQzAI72ujnD9tt6+SnD57HYI
         MgI6ngKNa6Eh0y5HdQDTDz6lnM06+eXX5yP8YrN+QsAaNtRrwPlFUiL3IiVJfgaM4Y
         DJpi7QNVd6PQYwtQElVUeLezKB5OQAGRgilG6WKFgkE2WbMHVP2VGJNm3q3F0+FJmu
         6lrj9yx0IYl2Q==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/19/20 1:00 PM, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Simplify the callers by moving the check for nr_pages and the BUG_ON
> into read_pages().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/readahead.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 

Looks nice,

    Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

> diff --git a/mm/readahead.c b/mm/readahead.c
> index 61b15b6b9e72..9fcd4e32b62d 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -119,6 +119,9 @@ static void read_pages(struct address_space *mapping, struct file *filp,
>  	struct blk_plug plug;
>  	unsigned page_idx;
>  
> +	if (!nr_pages)
> +		return;
> +
>  	blk_start_plug(&plug);
>  
>  	if (mapping->a_ops->readpages) {
> @@ -138,6 +141,8 @@ static void read_pages(struct address_space *mapping, struct file *filp,
>  
>  out:
>  	blk_finish_plug(&plug);
> +
> +	BUG_ON(!list_empty(pages));
>  }
>  
>  /*
> @@ -180,8 +185,7 @@ void __do_page_cache_readahead(struct address_space *mapping,
>  			 * contiguous pages before continuing with the next
>  			 * batch.
>  			 */
> -			if (nr_pages)
> -				read_pages(mapping, filp, &page_pool, nr_pages,
> +			read_pages(mapping, filp, &page_pool, nr_pages,
>  						gfp_mask);
>  			nr_pages = 0;
>  			continue;
> @@ -202,9 +206,7 @@ void __do_page_cache_readahead(struct address_space *mapping,
>  	 * uptodate then the caller will launch readpage again, and
>  	 * will then handle the error.
>  	 */
> -	if (nr_pages)
> -		read_pages(mapping, filp, &page_pool, nr_pages, gfp_mask);
> -	BUG_ON(!list_empty(&page_pool));
> +	read_pages(mapping, filp, &page_pool, nr_pages, gfp_mask);
>  }
>  
>  /*
> 
