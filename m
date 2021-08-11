Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9189C3E8705
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 02:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235693AbhHKAJH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 20:09:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235537AbhHKAJG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 20:09:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C6007600CD;
        Wed, 11 Aug 2021 00:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628640523;
        bh=OHDM4XZtwVeumjQMhwhxYCPd8z30085t/okcA6XD6ns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BYUz3wDYq9MPo46WJn3zlRhyiqUuhwfK4DV98eWQs0aB97LqYgvVXu8HtyW+uyzfz
         EQHW9dQ0qDn63hROd64fM5SsJYl8+AdxdxhRk/lQompe2zw2KNG5PEEXXD2vjHaa+G
         5kS+zQ6AO4sCaHBmO22Iom8NaZbhbCju5cS94BLjiOgWUfUUdGcLT/QbxPNDmGsrLQ
         x2OC62IWpKFm3Wjpk28F09Aag1UXvzNEXArRA5neWCnvKVLz3Vm8hs8EK7e9+sArYT
         iBeoAe0g38omOZXVZFnSJ0uXCkITGi5/y1Ils1wSuPjX5QUdf2qjrwL0wIepAdtJvG
         NlMb/avZOyQlw==
Date:   Tue, 10 Aug 2021 17:08:43 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: Re: [PATCH 22/30] iomap: switch iomap_swapfile_activate to use
 iomap_iter
Message-ID: <20210811000843.GR3601443@magnolia>
References: <20210809061244.1196573-1-hch@lst.de>
 <20210809061244.1196573-23-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809061244.1196573-23-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 09, 2021 at 08:12:36AM +0200, Christoph Hellwig wrote:
> Switch iomap_swapfile_activate to use iomap_iter.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Smooooooth
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/swapfile.c | 38 ++++++++++++++++----------------------
>  1 file changed, 16 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/iomap/swapfile.c b/fs/iomap/swapfile.c
> index 6250ca6a1f851d..7069606eca85b2 100644
> --- a/fs/iomap/swapfile.c
> +++ b/fs/iomap/swapfile.c
> @@ -88,13 +88,9 @@ static int iomap_swapfile_fail(struct iomap_swapfile_info *isi, const char *str)
>   * swap only cares about contiguous page-aligned physical extents and makes no
>   * distinction between written and unwritten extents.
>   */
> -static loff_t iomap_swapfile_activate_actor(struct inode *inode, loff_t pos,
> -		loff_t count, void *data, struct iomap *iomap,
> -		struct iomap *srcmap)
> +static loff_t iomap_swapfile_iter(const struct iomap_iter *iter,
> +		struct iomap *iomap, struct iomap_swapfile_info *isi)
>  {
> -	struct iomap_swapfile_info *isi = data;
> -	int error;
> -
>  	switch (iomap->type) {
>  	case IOMAP_MAPPED:
>  	case IOMAP_UNWRITTEN:
> @@ -125,12 +121,12 @@ static loff_t iomap_swapfile_activate_actor(struct inode *inode, loff_t pos,
>  		isi->iomap.length += iomap->length;
>  	} else {
>  		/* Otherwise, add the retained iomap and store this one. */
> -		error = iomap_swapfile_add_extent(isi);
> +		int error = iomap_swapfile_add_extent(isi);
>  		if (error)
>  			return error;
>  		memcpy(&isi->iomap, iomap, sizeof(isi->iomap));
>  	}
> -	return count;
> +	return iomap_length(iter);
>  }
>  
>  /*
> @@ -141,16 +137,19 @@ int iomap_swapfile_activate(struct swap_info_struct *sis,
>  		struct file *swap_file, sector_t *pagespan,
>  		const struct iomap_ops *ops)
>  {
> +	struct inode *inode = swap_file->f_mapping->host;
> +	struct iomap_iter iter = {
> +		.inode	= inode,
> +		.pos	= 0,
> +		.len	= ALIGN_DOWN(i_size_read(inode), PAGE_SIZE),
> +		.flags	= IOMAP_REPORT,
> +	};
>  	struct iomap_swapfile_info isi = {
>  		.sis = sis,
>  		.lowest_ppage = (sector_t)-1ULL,
>  		.file = swap_file,
>  	};
> -	struct address_space *mapping = swap_file->f_mapping;
> -	struct inode *inode = mapping->host;
> -	loff_t pos = 0;
> -	loff_t len = ALIGN_DOWN(i_size_read(inode), PAGE_SIZE);
> -	loff_t ret;
> +	int ret;
>  
>  	/*
>  	 * Persist all file mapping metadata so that we won't have any
> @@ -160,15 +159,10 @@ int iomap_swapfile_activate(struct swap_info_struct *sis,
>  	if (ret)
>  		return ret;
>  
> -	while (len > 0) {
> -		ret = iomap_apply(inode, pos, len, IOMAP_REPORT,
> -				ops, &isi, iomap_swapfile_activate_actor);
> -		if (ret <= 0)
> -			return ret;
> -
> -		pos += ret;
> -		len -= ret;
> -	}
> +	while ((ret = iomap_iter(&iter, ops)) > 0)
> +		iter.processed = iomap_swapfile_iter(&iter, &iter.iomap, &isi);
> +	if (ret < 0)
> +		return ret;
>  
>  	if (isi.iomap.length) {
>  		ret = iomap_swapfile_add_extent(&isi);
> -- 
> 2.30.2
> 
