Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 635B116351A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 22:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbgBRVdV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 16:33:21 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:15423 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgBRVdV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 16:33:21 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e4c57d90000>; Tue, 18 Feb 2020 13:32:09 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 18 Feb 2020 13:33:20 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 18 Feb 2020 13:33:20 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Feb
 2020 21:33:19 +0000
Subject: Re: [PATCH v6 02/19] mm: Ignore return value of ->readpages
To:     Matthew Wilcox <willy@infradead.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-btrfs@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <cluster-devel@redhat.com>, <ocfs2-devel@oss.oracle.com>,
        <linux-xfs@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-3-willy@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <ed5b3635-be1b-c290-0e19-b516e7af2aca@nvidia.com>
Date:   Tue, 18 Feb 2020 13:33:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200217184613.19668-3-willy@infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582061529; bh=RXve5/fUA3oBILhUm8o+y+17c7pBmRijpBQPJAnmP80=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=f5Iuo6blIXbcDZrM05UIgCY8ANT5xW9HB6FXMMGQCfaHMfBnR1DfaWLTMAYIE7XBP
         B9QOW8wSO4ij5j+4bCfhLlUR2LpeSTGJV0y8tnLGhP+d4at2LBMPXmcd1007q6GV+V
         F6nXmc1d8pgAlmrCaaR8bklkj+n7DiCZH8Mj9XZsOl6SUYvt06XEAlqdCtbjrJAqsO
         JEKRbCwBCkx6iNbCJyyfXN8/DDeOTx/qKgkY7yedkT+Pn0V+QFJNvk6ybzosDhS50D
         pgn5lvAGlEV280+lBsRM1YfSDahNeoARNWUSdQ6PSTGWm5OdOjiCPRr9K7h5I26KXq
         jvW6k1ji+T2MA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/17/20 10:45 AM, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> We used to assign the return value to a variable, which we then ignored.
> Remove the pretence of caring.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/readahead.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

Looks good,

    Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

> 
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 8ce46d69e6ae..12d13b7792da 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -113,17 +113,16 @@ int read_cache_pages(struct address_space *mapping, struct list_head *pages,
>  
>  EXPORT_SYMBOL(read_cache_pages);
>  
> -static int read_pages(struct address_space *mapping, struct file *filp,
> +static void read_pages(struct address_space *mapping, struct file *filp,
>  		struct list_head *pages, unsigned int nr_pages, gfp_t gfp)
>  {
>  	struct blk_plug plug;
>  	unsigned page_idx;
> -	int ret;
>  
>  	blk_start_plug(&plug);
>  
>  	if (mapping->a_ops->readpages) {
> -		ret = mapping->a_ops->readpages(filp, mapping, pages, nr_pages);
> +		mapping->a_ops->readpages(filp, mapping, pages, nr_pages);
>  		/* Clean up the remaining pages */
>  		put_pages_list(pages);
>  		goto out;
> @@ -136,12 +135,9 @@ static int read_pages(struct address_space *mapping, struct file *filp,
>  			mapping->a_ops->readpage(filp, page);
>  		put_page(page);
>  	}
> -	ret = 0;
>  
>  out:
>  	blk_finish_plug(&plug);
> -
> -	return ret;
>  }
>  
>  /*
> 
