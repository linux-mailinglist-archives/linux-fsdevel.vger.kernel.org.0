Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12FD671F37
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 15:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjAROQj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 09:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjAROPp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:15:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867A13B0F4
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jan 2023 05:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674050166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mFihkpDInrgSgklnLUMioicNGhqhAH1TgcOQOASzKX8=;
        b=EA3k93hkqYrhPoOXHuPSuwCgI4osGpM+rMhJ0tvGvH/KpKL2FSYawrH0S+kiMa6G5ImtBI
        nI7T6Knf6SWeBOmnYOmXQbn2ZIoA3DnDPeW84k3M4YnQLkVjlPm6MyzHDOGd7fhFekaq37
        wzuqPIGmesB/886BdNjficcnXFMH+xo=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-133-odFkX7TTMUyZzZohfOMXSQ-1; Wed, 18 Jan 2023 08:56:04 -0500
X-MC-Unique: odFkX7TTMUyZzZohfOMXSQ-1
Received: by mail-vk1-f198.google.com with SMTP id m84-20020a1fa357000000b003bcb3e83df3so10211242vke.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jan 2023 05:56:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFihkpDInrgSgklnLUMioicNGhqhAH1TgcOQOASzKX8=;
        b=bfxpV+HSBq0H2/xdCofIwtL3MzgvaZOD2QKv0ExzFPvhHazfsdD+97ZO0Slc+pEzhy
         C2nIOzakwFEX6LaXJLPy998crN+6CgsapOKVFRA2MOBzzL56R9WHrtCo6sf01m9ARYX6
         G+YLLNDsZl/WrtBdnkT2gfP98kpIXMITpgioq1gyrJNcZDlv7RBxJ+Gmdnt9DQM4d2Jn
         jn/qghsHsfLEulmuAudP8wi6V633M/zmkbMs+D6dnrgH0gylmcWPZKGkNl7/OFjdlbhK
         /DhJpR2I53ZmY26k/TU1RRdr9gXxlLDLfhAuUUxg/s0N3HG2dBD4lFA1HECVNujBzcgq
         wYUg==
X-Gm-Message-State: AFqh2kp2adjxaXxqaV3v4mIlGyMQJndr68cNlkY667NXDcE5YRNBu6RA
        4xBBJWDb3QeFed9R3mcl6Ihn60LL9a5ATF/Lgz4AB3g/+y4mydMdr1L87Nqzmeqiq/M7xSzO3bG
        UiikD1YB5SwUP5c893zFYng66Yw==
X-Received: by 2002:a1f:9092:0:b0:3e1:c1a9:9ed3 with SMTP id s140-20020a1f9092000000b003e1c1a99ed3mr896141vkd.9.1674050164276;
        Wed, 18 Jan 2023 05:56:04 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsLRo7TamkDesKO8QNJFygnDW4twpsX9e35bGiyAXeGnZO0p6bdjcamDz6tCwjrwmPqirRaLA==
X-Received: by 2002:a1f:9092:0:b0:3e1:c1a9:9ed3 with SMTP id s140-20020a1f9092000000b003e1c1a99ed3mr896109vkd.9.1674050163955;
        Wed, 18 Jan 2023 05:56:03 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id s18-20020a05620a255200b006eeb3165565sm22368714qko.80.2023.01.18.05.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 05:56:03 -0800 (PST)
Date:   Wed, 18 Jan 2023 08:57:05 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        cluster-devel@redhat.com, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nilfs@vger.kernel.org
Subject: Re: [PATCH 4/9] shmem: remove shmem_get_partial_folio
Message-ID: <Y8f6sShghKuFim5E@bfoster>
References: <20230118094329.9553-1-hch@lst.de>
 <20230118094329.9553-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118094329.9553-5-hch@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 18, 2023 at 10:43:24AM +0100, Christoph Hellwig wrote:
> Add a new SGP_FIND mode for shmem_get_partial_folio that works like
> SGP_READ, but does not check i_size.  Use that instead of open coding
> the page cache lookup in shmem_get_partial_folio.  Note that this is
> a behavior change in that it reads in swap cache entries for offsets
> outside i_size, possibly causing a little bit of extra work.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/shmem_fs.h |  1 +
>  mm/shmem.c               | 46 ++++++++++++----------------------------
>  2 files changed, 15 insertions(+), 32 deletions(-)
> 
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index d09d54be4ffd99..7ba160ac066e5e 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -105,6 +105,7 @@ enum sgp_type {
>  	SGP_CACHE,	/* don't exceed i_size, may allocate page */
>  	SGP_WRITE,	/* may exceed i_size, may allocate !Uptodate page */
>  	SGP_FALLOC,	/* like SGP_WRITE, but make existing page Uptodate */
> +	SGP_FIND,	/* like SGP_READ, but also read outside i_size */
>  };
>  
>  int shmem_get_folio(struct inode *inode, pgoff_t index, struct folio **foliop,
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 9e1015cbad29f9..e9500fea43a8dc 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -877,27 +877,6 @@ void shmem_unlock_mapping(struct address_space *mapping)
>  	}
>  }
>  
> -static struct folio *shmem_get_partial_folio(struct inode *inode, pgoff_t index)
> -{
> -	struct folio *folio;
> -
> -	/*
> -	 * At first avoid shmem_get_folio(,,,SGP_READ): that fails
> -	 * beyond i_size, and reports fallocated pages as holes.
> -	 */
> -	folio = __filemap_get_folio(inode->i_mapping, index,
> -					FGP_ENTRY | FGP_LOCK, 0);

This all seems reasonable to me at a glance, FWIW, but I am a little
curious why this wouldn't split up into two changes. I.e., switch this
over to filemap_get_entry() to minimally remove the FGP_ENTRY dependency
without a behavior change, then (perhaps after the next patch) introduce
SGP_FIND in a separate patch. That makes it easier to review and
potentially undo if it happens to pose a problem in the future. Hm?

Brian

> -	if (!xa_is_value(folio))
> -		return folio;
> -	/*
> -	 * But read a page back from swap if any of it is within i_size
> -	 * (although in some cases this is just a waste of time).
> -	 */
> -	folio = NULL;
> -	shmem_get_folio(inode, index, &folio, SGP_READ);
> -	return folio;
> -}
> -
>  /*
>   * Remove range of pages and swap entries from page cache, and free them.
>   * If !unfalloc, truncate or punch hole; if unfalloc, undo failed fallocate.
> @@ -957,7 +936,8 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
>  		goto whole_folios;
>  
>  	same_folio = (lstart >> PAGE_SHIFT) == (lend >> PAGE_SHIFT);
> -	folio = shmem_get_partial_folio(inode, lstart >> PAGE_SHIFT);
> +	folio = NULL;
> +	shmem_get_folio(inode, lstart >> PAGE_SHIFT, &folio, SGP_FIND);
>  	if (folio) {
>  		same_folio = lend < folio_pos(folio) + folio_size(folio);
>  		folio_mark_dirty(folio);
> @@ -971,14 +951,16 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
>  		folio = NULL;
>  	}
>  
> -	if (!same_folio)
> -		folio = shmem_get_partial_folio(inode, lend >> PAGE_SHIFT);
> -	if (folio) {
> -		folio_mark_dirty(folio);
> -		if (!truncate_inode_partial_folio(folio, lstart, lend))
> -			end = folio->index;
> -		folio_unlock(folio);
> -		folio_put(folio);
> +	if (!same_folio) {
> +		folio = NULL;
> +		shmem_get_folio(inode, lend >> PAGE_SHIFT, &folio, SGP_FIND);
> +		if (folio) {
> +			folio_mark_dirty(folio);
> +			if (!truncate_inode_partial_folio(folio, lstart, lend))
> +				end = folio->index;
> +			folio_unlock(folio);
> +			folio_put(folio);
> +		}
>  	}
>  
>  whole_folios:
> @@ -1900,7 +1882,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
>  		if (folio_test_uptodate(folio))
>  			goto out;
>  		/* fallocated folio */
> -		if (sgp != SGP_READ)
> +		if (sgp != SGP_READ && sgp != SGP_FIND)
>  			goto clear;
>  		folio_unlock(folio);
>  		folio_put(folio);
> @@ -1911,7 +1893,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
>  	 * SGP_NOALLOC: fail on hole, with NULL folio, letting caller fail.
>  	 */
>  	*foliop = NULL;
> -	if (sgp == SGP_READ)
> +	if (sgp == SGP_READ || sgp == SGP_FIND)
>  		return 0;
>  	if (sgp == SGP_NOALLOC)
>  		return -ENOENT;
> -- 
> 2.39.0
> 
> 

