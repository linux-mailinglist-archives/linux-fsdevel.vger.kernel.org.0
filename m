Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D293129C6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Feb 2021 05:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhBHEgc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Feb 2021 23:36:32 -0500
Received: from mga07.intel.com ([134.134.136.100]:17032 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229590AbhBHEgb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Feb 2021 23:36:31 -0500
IronPort-SDR: l/FAM6FSC72CiLe0G+w2+xUn5tZvBRHmYyuvfuwMPQ8npg8+J2zW72vwv2ziThkC+jQ3tTVPpM
 W8XL2waaGaQg==
X-IronPort-AV: E=McAfee;i="6000,8403,9888"; a="245728711"
X-IronPort-AV: E=Sophos;i="5.81,161,1610438400"; 
   d="scan'208";a="245728711"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2021 20:35:46 -0800
IronPort-SDR: 4emt90bFPXkomAEhMAD/amfAwA5qVmGt0sO4/tEOTDnxbNYF4BpZw3GHR0aFYD7ulF1hKkEC4B
 kY6KjbpkbPNQ==
X-IronPort-AV: E=Sophos;i="5.81,161,1610438400"; 
   d="scan'208";a="435473654"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2021 20:35:46 -0800
Date:   Sun, 7 Feb 2021 20:35:46 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, axboe@kernel.dk, tytso@mit.edu,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org, chao@kernel.org,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com, clm@fb.com,
        dsterba@suse.com, ebiggers@kernel.org, hch@infradead.org,
        dave.hansen@intel.com
Subject: Re: [RFC PATCH 2/8] brd: use memcpy_from_page() in copy_from_brd()
Message-ID: <20210208043545.GF5033@iweiny-DESK2.sc.intel.com>
References: <20210207190425.38107-1-chaitanya.kulkarni@wdc.com>
 <20210207190425.38107-3-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210207190425.38107-3-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Feb 07, 2021 at 11:04:19AM -0800, Chaitanya Kulkarni wrote:
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  drivers/block/brd.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/block/brd.c b/drivers/block/brd.c
> index d41b7d489e9f..c1f6d768a1b3 100644
> --- a/drivers/block/brd.c
> +++ b/drivers/block/brd.c
> @@ -220,7 +220,6 @@ static void copy_from_brd(void *dst, struct brd_device *brd,
>  			sector_t sector, size_t n)
>  {
>  	struct page *page;
> -	void *src;
>  	unsigned int offset = (sector & (PAGE_SECTORS-1)) << SECTOR_SHIFT;
>  	size_t copy;
>  
> @@ -236,11 +235,9 @@ static void copy_from_brd(void *dst, struct brd_device *brd,
>  		sector += copy >> SECTOR_SHIFT;
>  		copy = n - copy;
>  		page = brd_lookup_page(brd, sector);
> -		if (page) {
> -			src = kmap_atomic(page);
> -			memcpy(dst, src, copy);
> -			kunmap_atomic(src);
> -		} else
> +		if (page)
> +			memcpy_from_page(dst, page, offset, copy);

Why 'offset'?

Ira

> +		else
>  			memset(dst, 0, copy);
>  	}
>  }
> -- 
> 2.22.1
> 
