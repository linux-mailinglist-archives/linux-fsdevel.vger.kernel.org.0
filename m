Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D8063FC63
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Dec 2022 00:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbiLAX60 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Dec 2022 18:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbiLAX6N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Dec 2022 18:58:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C667DBFCFE;
        Thu,  1 Dec 2022 15:58:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BF3C6178A;
        Thu,  1 Dec 2022 23:58:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C27F0C433C1;
        Thu,  1 Dec 2022 23:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669939091;
        bh=zPyaMFVNtJz39yxuPqF88oHgpJ3uncDzubuWa5rwGJc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MhniUVuXFz96YDbTNmKxsR23Xfn0Bw5dVPYyb3Pfrt+WgCyOOL59YbJchYz1ZXNmG
         xmSoWIvChXKlmhedoutyUiutSWeBHfRvrQmMUs/vAaYxpZyN5p1gAQz38l8uu77Cqm
         h2LPjjYUEdL48kiIp7MBEnmE/U4C4o+QDl5sR1M2OHjHSackl/pvXF8Mbf0tDH5eLX
         CsPgJlVUgOGDbo/kXPbKH1AP/RCFUpj+ikg+Fc4damulzHfFWu0l+NZpt+EPI/lmrD
         3WPFQb2PbmnVCbJAV0j3Bo8+fBP1CtAeVzudaQu8BsV/14FamWbu/kGV7emLyjr7Ip
         vxKs0XuvavxOA==
Date:   Thu, 1 Dec 2022 15:58:11 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, dan.j.williams@intel.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH v2 3/8] fsdax: zero the edges if source is HOLE or
 UNWRITTEN
Message-ID: <Y4k/kxuPOirdlctI@magnolia>
References: <1669908538-55-1-git-send-email-ruansy.fnst@fujitsu.com>
 <1669908538-55-4-git-send-email-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1669908538-55-4-git-send-email-ruansy.fnst@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 01, 2022 at 03:28:53PM +0000, Shiyang Ruan wrote:
> If srcmap contains invalid data, such as HOLE and UNWRITTEN, the dest
> page should be zeroed.  Otherwise, since it's a pmem, old data may
> remains on the dest page, the result of CoW will be incorrect.
> 
> The function name is also not easy to understand, rename it to
> "dax_iomap_copy_around()", which means it copys data around the range.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  fs/dax.c | 78 ++++++++++++++++++++++++++++++++++----------------------
>  1 file changed, 48 insertions(+), 30 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 482dda85ccaf..6b6e07ad8d80 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1092,7 +1092,7 @@ static int dax_iomap_direct_access(const struct iomap *iomap, loff_t pos,
>  }
>  
>  /**
> - * dax_iomap_cow_copy - Copy the data from source to destination before write
> + * dax_iomap_copy_around - Copy the data from source to destination before write

 * dax_iomap_copy_around - Prepare for an unaligned write to a
 * shared/cow page by copying the data before and after the range to be
 * written.

Other than that, this make sense,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

>   * @pos:	address to do copy from.
>   * @length:	size of copy operation.
>   * @align_size:	aligned w.r.t align_size (either PMD_SIZE or PAGE_SIZE)
> @@ -1101,35 +1101,50 @@ static int dax_iomap_direct_access(const struct iomap *iomap, loff_t pos,
>   *
>   * This can be called from two places. Either during DAX write fault (page
>   * aligned), to copy the length size data to daddr. Or, while doing normal DAX
> - * write operation, dax_iomap_actor() might call this to do the copy of either
> + * write operation, dax_iomap_iter() might call this to do the copy of either
>   * start or end unaligned address. In the latter case the rest of the copy of
> - * aligned ranges is taken care by dax_iomap_actor() itself.
> + * aligned ranges is taken care by dax_iomap_iter() itself.
> + * If the srcmap contains invalid data, such as HOLE and UNWRITTEN, zero the
> + * area to make sure no old data remains.
>   */
> -static int dax_iomap_cow_copy(loff_t pos, uint64_t length, size_t align_size,
> +static int dax_iomap_copy_around(loff_t pos, uint64_t length, size_t align_size,
>  		const struct iomap *srcmap, void *daddr)
>  {
>  	loff_t head_off = pos & (align_size - 1);
>  	size_t size = ALIGN(head_off + length, align_size);
>  	loff_t end = pos + length;
>  	loff_t pg_end = round_up(end, align_size);
> +	/* copy_all is usually in page fault case */
>  	bool copy_all = head_off == 0 && end == pg_end;
> +	/* zero the edges if srcmap is a HOLE or IOMAP_UNWRITTEN */
> +	bool zero_edge = srcmap->flags & IOMAP_F_SHARED ||
> +			 srcmap->type == IOMAP_UNWRITTEN;
>  	void *saddr = 0;
>  	int ret = 0;
>  
> -	ret = dax_iomap_direct_access(srcmap, pos, size, &saddr, NULL);
> -	if (ret)
> -		return ret;
> +	if (!zero_edge) {
> +		ret = dax_iomap_direct_access(srcmap, pos, size, &saddr, NULL);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	if (copy_all) {
> -		ret = copy_mc_to_kernel(daddr, saddr, length);
> -		return ret ? -EIO : 0;
> +		if (zero_edge)
> +			memset(daddr, 0, size);
> +		else
> +			ret = copy_mc_to_kernel(daddr, saddr, length);
> +		goto out;
>  	}
>  
>  	/* Copy the head part of the range */
>  	if (head_off) {
> -		ret = copy_mc_to_kernel(daddr, saddr, head_off);
> -		if (ret)
> -			return -EIO;
> +		if (zero_edge)
> +			memset(daddr, 0, head_off);
> +		else {
> +			ret = copy_mc_to_kernel(daddr, saddr, head_off);
> +			if (ret)
> +				return -EIO;
> +		}
>  	}
>  
>  	/* Copy the tail part of the range */
> @@ -1137,12 +1152,19 @@ static int dax_iomap_cow_copy(loff_t pos, uint64_t length, size_t align_size,
>  		loff_t tail_off = head_off + length;
>  		loff_t tail_len = pg_end - end;
>  
> -		ret = copy_mc_to_kernel(daddr + tail_off, saddr + tail_off,
> -					tail_len);
> -		if (ret)
> -			return -EIO;
> +		if (zero_edge)
> +			memset(daddr + tail_off, 0, tail_len);
> +		else {
> +			ret = copy_mc_to_kernel(daddr + tail_off,
> +						saddr + tail_off, tail_len);
> +			if (ret)
> +				return -EIO;
> +		}
>  	}
> -	return 0;
> +out:
> +	if (zero_edge)
> +		dax_flush(srcmap->dax_dev, daddr, size);
> +	return ret ? -EIO : 0;
>  }
>  
>  /*
> @@ -1241,13 +1263,10 @@ static int dax_memzero(struct iomap_iter *iter, loff_t pos, size_t size)
>  	if (ret < 0)
>  		return ret;
>  	memset(kaddr + offset, 0, size);
> -	if (srcmap->addr != iomap->addr) {
> -		ret = dax_iomap_cow_copy(pos, size, PAGE_SIZE, srcmap,
> -					 kaddr);
> -		if (ret < 0)
> -			return ret;
> -		dax_flush(iomap->dax_dev, kaddr, PAGE_SIZE);
> -	} else
> +	if (iomap->flags & IOMAP_F_SHARED)
> +		ret = dax_iomap_copy_around(pos, size, PAGE_SIZE, srcmap,
> +					    kaddr);
> +	else
>  		dax_flush(iomap->dax_dev, kaddr + offset, size);
>  	return ret;
>  }
> @@ -1401,8 +1420,8 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
>  		}
>  
>  		if (cow) {
> -			ret = dax_iomap_cow_copy(pos, length, PAGE_SIZE, srcmap,
> -						 kaddr);
> +			ret = dax_iomap_copy_around(pos, length, PAGE_SIZE,
> +						    srcmap, kaddr);
>  			if (ret)
>  				break;
>  		}
> @@ -1547,7 +1566,7 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
>  		struct xa_state *xas, void **entry, bool pmd)
>  {
>  	const struct iomap *iomap = &iter->iomap;
> -	const struct iomap *srcmap = &iter->srcmap;
> +	const struct iomap *srcmap = iomap_iter_srcmap(iter);
>  	size_t size = pmd ? PMD_SIZE : PAGE_SIZE;
>  	loff_t pos = (loff_t)xas->xa_index << PAGE_SHIFT;
>  	bool write = iter->flags & IOMAP_WRITE;
> @@ -1578,9 +1597,8 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
>  
>  	*entry = dax_insert_entry(xas, vmf, iter, *entry, pfn, entry_flags);
>  
> -	if (write &&
> -	    srcmap->type != IOMAP_HOLE && srcmap->addr != iomap->addr) {
> -		err = dax_iomap_cow_copy(pos, size, size, srcmap, kaddr);
> +	if (write && iomap->flags & IOMAP_F_SHARED) {
> +		err = dax_iomap_copy_around(pos, size, size, srcmap, kaddr);
>  		if (err)
>  			return dax_fault_return(err);
>  	}
> -- 
> 2.38.1
> 
