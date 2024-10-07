Return-Path: <linux-fsdevel+bounces-31260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2EB99396B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 23:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3083B1F21E5D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 21:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9862B18CBE9;
	Mon,  7 Oct 2024 21:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="iaSqz3ff"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBB518C935
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Oct 2024 21:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728336969; cv=none; b=U7qo1sdGTENI2k6XsBGHctaMP06wGInGrWMF12f97bvzcwJUOGN2PfeGIQOckuPYIHpTrBmfmoqp3cPOfYQXBQxZt22eiabH2UewSPANPfZZ1hHvFYdyFdNRq0OT3F0Pa0aMxYpAdoX4fjc+Vwbr4xRR0ZP9VUozSz+BpwP5AKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728336969; c=relaxed/simple;
	bh=JQy2zL4oAPwikhk17+kQURqFnFir6FA9LSRRTMyBm94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9UwtXDPy7ubZgRNyl0v2wdVHjbmAJG4fjrTJea2Hvoqk2yTLZrR2+1L8idEUelLZdKkpaCgBh857p8q6eI9pnNUMAGE3/Akzl0SHSuWn0T47374oDOlAZ8eLsCrYszFU4rZVmPfCyYYblPIQPtM3oF65/eXrd/jxjI57xOSQTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=iaSqz3ff; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e0a060f6e8so3523594a91.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2024 14:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1728336966; x=1728941766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YNElnBEDYpWFvzvIDSHHM3zq8aWA/ncVSKt50m3p1Uc=;
        b=iaSqz3ffv9QcEsvbFPKokl1pHTR3fk5D3y26Ge/n8xgDS2hK6Gj18jhmQehKUVP0o1
         iGn2MF5Vmd9vsNPQUd5KmhXwkovrVOIvJdZht3JwHEHoOYaO1h2h7gaSf/DqD5nWaHq4
         p50qHwYtT5T33j1ChjEt9f/LfGIVc2xFR+sopmFLI1q4K9wsq6NwDUkCIYWhKB2BxvDv
         Gck4gUy7W+Gu3cdqI2aUyicuVlO58UVphfIiG4YZvSEBK4f3osGON+eEUQ0hacyytkca
         v3Rq2Z+zNHQabNM0d01bmqTGUldp8nWC/3mwX4r8PvCeL6lQvuRSZ2ArRQWkS6A95ys6
         iz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728336966; x=1728941766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNElnBEDYpWFvzvIDSHHM3zq8aWA/ncVSKt50m3p1Uc=;
        b=gQhbr7Fywa2pBJAutQAOVtqNMAvuqz6zk/a9Mmp9nQtIZUj4/fRGYpr+nlGpyARvB3
         stZIkjg3rB2rY5NuggfJg2p3eZY3Is9NpuURykii8pbQRoK1k7/4iqibL6Rsjd4mHG69
         J5OqtzfADuK41yPAn88/foWr6wIJGURPcJv0nuSi92S8tA4G6Y1yA1IXEsU9KuF3l6Ns
         BDKRxD7RxOnZX4PR7KdN+oji/5rNSee/s/AUupEP0qbzkptmtqnxeSc7dqtWE1fGqgs2
         otGv3eeBnFWx/KAGqiqFb0tAEBenpjRUL3P3DPNT4K3yC1DiWUKr40ZpGWIyBt+jQsq3
         vtlQ==
X-Forwarded-Encrypted: i=1; AJvYcCX06iR+m7o9a6KE9kuHZZPoG36W0qkCvqLRjnL1oxpqtMYY4dKnHbMgXvYKweV3e70VG7QucDqlBQxEvkyp@vger.kernel.org
X-Gm-Message-State: AOJu0YzuWPVzbJc5H/ZzQCY9lR9Mv6Z/xFkmPuljWS3PZmAUSK9m37UX
	qeFVFWWyHmlEV1KL4oOkN5TZKI9y/GwrrDOP0EmRVcS8WxCYeDkklnXU9k8tF75murvuYRjbpaC
	s
X-Google-Smtp-Source: AGHT+IExu8G+LbTmre/7Wvi64/0zNdjewTInymIURS0AgdTaL/5h/Wa336/N3B/Hwt0kgIfIZhHc+A==
X-Received: by 2002:a17:90a:ec07:b0:2e0:8095:98d9 with SMTP id 98e67ed59e1d1-2e1e6222221mr14172739a91.11.1728336966427;
        Mon, 07 Oct 2024 14:36:06 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e83ca284sm7699214a91.11.2024.10.07.14.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 14:36:05 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sxvOc-00FJuO-37;
	Tue, 08 Oct 2024 08:36:02 +1100
Date: Tue, 8 Oct 2024 08:36:02 +1100
From: Dave Chinner <david@fromorbit.com>
To: Tang Yizhou <yizhou.tang@shopee.com>
Cc: jack@suse.cz, hch@infradead.org, willy@infradead.org,
	akpm@linux-foundation.org, chandan.babu@oracle.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 3/3] xfs: Let the max iomap length be consistent with
 the writeback code
Message-ID: <ZwRUQvq4wqfL8rBd@dread.disaster.area>
References: <20241006152849.247152-1-yizhou.tang@shopee.com>
 <20241006152849.247152-4-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241006152849.247152-4-yizhou.tang@shopee.com>

On Sun, Oct 06, 2024 at 11:28:49PM +0800, Tang Yizhou wrote:
> From: Tang Yizhou <yizhou.tang@shopee.com>
> 
> Since commit 1a12d8bd7b29 ("writeback: scale IO chunk size up to half
> device bandwidth"), macro MAX_WRITEBACK_PAGES has been removed from the
> writeback path. Therefore, the MAX_WRITEBACK_PAGES comments in
> xfs_direct_write_iomap_begin() and xfs_buffered_write_iomap_begin() appear
> outdated.
> 
> In addition, Christoph mentioned that the xfs iomap process should be
> similar to writeback, so xfs_max_map_length() was written following the
> logic of writeback_chunk_size().
> 
> v2: Thanks for Christoph's advice. Resync with the writeback code.
> 
> Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
> ---
>  fs/fs-writeback.c         |  5 ----
>  fs/xfs/xfs_iomap.c        | 52 ++++++++++++++++++++++++---------------
>  include/linux/writeback.h |  5 ++++
>  3 files changed, 37 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index d8bec3c1bb1f..31c72e207e1b 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -31,11 +31,6 @@
>  #include <linux/memcontrol.h>
>  #include "internal.h"
>  
> -/*
> - * 4MB minimal write chunk size
> - */
> -#define MIN_WRITEBACK_PAGES	(4096UL >> (PAGE_SHIFT - 10))
> -
>  /*
>   * Passed into wb_writeback(), essentially a subset of writeback_control
>   */
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 1e11f48814c0..80f759fa9534 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -4,6 +4,8 @@
>   * Copyright (c) 2016-2018 Christoph Hellwig.
>   * All Rights Reserved.
>   */
> +#include <linux/writeback.h>
> +
>  #include "xfs.h"
>  #include "xfs_fs.h"
>  #include "xfs_shared.h"
> @@ -744,6 +746,34 @@ xfs_ilock_for_iomap(
>  	return 0;
>  }
>  
> +/*
> + * We cap the maximum length we map to a sane size to keep the chunks
> + * of work done where somewhat symmetric with the work writeback does.
> + * This is a completely arbitrary number pulled out of thin air as a
> + * best guess for initial testing.
> + *
> + * Following the logic of writeback_chunk_size(), the length will be
> + * rounded to the nearest 4MB boundary.
> + *
> + * Note that the values needs to be less than 32-bits wide until the
> + * lower level functions are updated.
> + */
> +static loff_t
> +xfs_max_map_length(struct inode *inode, loff_t length)
> +{
> +	struct bdi_writeback *wb;
> +	long pages;
> +
> +	spin_lock(&inode->i_lock);
> +	wb = inode_to_wb(wb);
> +	pages = min(wb->avg_write_bandwidth / 2,
> +		    global_wb_domain.dirty_limit / DIRTY_SCOPE);
> +	spin_unlock(&inode->i_lock);
> +	pages = round_down(pages + MIN_WRITEBACK_PAGES, MIN_WRITEBACK_PAGES);
> +
> +	return min_t(loff_t, length, pages * PAGE_SIZE);
> +}

I think this map size limiting is completely unnecessary for
buffered writeback - buffered writes are throttled against writeback
by balance_dirty_pages(), not by extent allocation size. The size of
the delayed allocation or the overwrite map is largely irrelevant -
we're going to map the entire range during a write, do it just
doesn't matter what size the mapping is...

>  /*
>   * Check that the imap we are going to return to the caller spans the entire
>   * range that the caller requested for the IO.
> @@ -878,16 +908,7 @@ xfs_direct_write_iomap_begin(
>  	if (flags & (IOMAP_NOWAIT | IOMAP_OVERWRITE_ONLY))
>  		goto out_unlock;
>  
> -	/*
> -	 * We cap the maximum length we map to a sane size  to keep the chunks
> -	 * of work done where somewhat symmetric with the work writeback does.
> -	 * This is a completely arbitrary number pulled out of thin air as a
> -	 * best guess for initial testing.
> -	 *
> -	 * Note that the values needs to be less than 32-bits wide until the
> -	 * lower level functions are updated.
> -	 */
> -	length = min_t(loff_t, length, 1024 * PAGE_SIZE);
> +	length = xfs_max_map_length(inode, length);
>  	end_fsb = xfs_iomap_end_fsb(mp, offset, length);

And I'd just remove this altogether from the direct IO path. The DIO
code will chain as many bios as it takes to issue Io over the entire
mapping that is returned. Given that buffered writeback has done
arbitrarily large writeback for quite some time now, I don't think
there is any need to limit the bio chain lengths in the DIO path
like this anymore, either.

i.e. I'd be looking at removing the "arbitrary size limit" code, not
making it more complex.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

