Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B3962C061
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 15:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbiKPODM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 09:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiKPOBL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:01:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA4A49B46
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Nov 2022 05:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668607037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U4homV+fVhvRQr3MTMK6djx4iwohawMzl3H/+thnj+U=;
        b=WK0uoAzO6iu3sExrT7Yu9di522TAx4NduVQqto0VXS9bgmE/6UuXp1eg371lW6ey+vBUP6
        qfiHZjQdAOZhnAhclpQlYEMytdxFMJ0b7hrD+1hQ5yjx30GiLwfBxDy6FlQFrvKKgxNhoi
        UrQIHQBJs95zlTTgH+4miNUuoW4k8OI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-141-vwL2WU1CNFm8cuLhlzZFZA-1; Wed, 16 Nov 2022 08:57:16 -0500
X-MC-Unique: vwL2WU1CNFm8cuLhlzZFZA-1
Received: by mail-qv1-f71.google.com with SMTP id lb11-20020a056214318b00b004c63b9f91e5so6700330qvb.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Nov 2022 05:57:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4homV+fVhvRQr3MTMK6djx4iwohawMzl3H/+thnj+U=;
        b=fI28uMbah5jd9H8o2RXxXy86kFFAI7fqu+SSw79zr+f7zKCK0mwO1mVv0gHvJj6IS/
         TStm+LJrQ8H9jvTzYQMgo4LKd+io3G44BU/DaHa7iylKbucEKJoNZ2ZBmE5kE57W0pov
         kA2usD9h/eCv+ihwpw5ej5O6dTPGq2S394iEAxVQfHiOicLu6iEgJU2MBw4Xfne4vPsh
         rM1RYqVb4vMzFtZjj2VpvdVoxT35/QODwX73WUFvUp82AZU0z+vOISMCtuOR4AMDOaAO
         G56EFHV4vhlSVVNKe3zG0fyiAwniyP3ttLOJOzoO0P4Zh8a4sxRUy6ex6GzPFZduZCas
         O6Aw==
X-Gm-Message-State: ANoB5ploGhtNHmnJcDqSEODXz2V9awcfGmT2OwiYSr9EcDS6TN68VWvs
        La9fgE+IFuGyhkbExco9tXDngk2BhGEw4EDU/JUa41mpLtEMzmaQzJU+A4waRm7MhBtBSUw8cti
        CqljlqHGvbh3lIJcwvBalFIN5xA==
X-Received: by 2002:a05:6214:3185:b0:4c6:5682:8878 with SMTP id lb5-20020a056214318500b004c656828878mr7571441qvb.5.1668607035632;
        Wed, 16 Nov 2022 05:57:15 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5886Oi0yVJL/ZsJCfXFajAX1bbbEKJNG9bcaFh8odkbdwQtNJ2DtnN4JzEWzF2Op9k157ZWw==
X-Received: by 2002:a05:6214:3185:b0:4c6:5682:8878 with SMTP id lb5-20020a056214318500b004c656828878mr7571423qvb.5.1668607035332;
        Wed, 16 Nov 2022 05:57:15 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id he31-20020a05622a601f00b00397b1c60780sm8787436qtb.61.2022.11.16.05.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 05:57:14 -0800 (PST)
Date:   Wed, 16 Nov 2022 08:57:19 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 5/9] xfs: buffered write failure should not truncate the
 page cache
Message-ID: <Y3TsPzd0XzXXIzQv@bfoster>
References: <20221115013043.360610-1-david@fromorbit.com>
 <20221115013043.360610-6-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115013043.360610-6-david@fromorbit.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 15, 2022 at 12:30:39PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
...
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  fs/xfs/xfs_iomap.c | 151 ++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 141 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 7bb55dbc19d3..2d48fcc7bd6f 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1134,6 +1134,146 @@ xfs_buffered_write_delalloc_punch(
>  				end_fsb - start_fsb);
>  }
>  
...
> +/*
> + * Punch out all the delalloc blocks in the range given except for those that
> + * have dirty data still pending in the page cache - those are going to be
> + * written and so must still retain the delalloc backing for writeback.
> + *
> + * As we are scanning the page cache for data, we don't need to reimplement the
> + * wheel - mapping_seek_hole_data() does exactly what we need to identify the
> + * start and end of data ranges correctly even for sub-folio block sizes. This
> + * byte range based iteration is especially convenient because it means we don't
> + * have to care about variable size folios, nor where the start or end of the
> + * data range lies within a folio, if they lie within the same folio or even if
> + * there are multiple discontiguous data ranges within the folio.
> + */
> +static int
> +xfs_buffered_write_delalloc_release(
> +	struct inode		*inode,
> +	loff_t			start_byte,
> +	loff_t			end_byte)
> +{
> +	loff_t			punch_start_byte = start_byte;
> +	int			error = 0;
> +
> +	/*
> +	 * Lock the mapping to avoid races with page faults re-instantiating
> +	 * folios and dirtying them via ->page_mkwrite whilst we walk the
> +	 * cache and perform delalloc extent removal. Failing to do this can
> +	 * leave dirty pages with no space reservation in the cache.
> +	 */
> +	filemap_invalidate_lock(inode->i_mapping);
> +	while (start_byte < end_byte) {
> +		loff_t		data_end;
> +
> +		start_byte = mapping_seek_hole_data(inode->i_mapping,
> +				start_byte, end_byte, SEEK_DATA);

FWIW, the fact that mapping seek data is based on uptodate status means
that seek behavior can change based on prior reads. For example, see how
seek hole/data presents reads of unwritten ranges as data [1]. The same
thing isn't observable for holes because iomap doesn't check the mapping
in that case, but underlying iop state is the same and that is what this
code is looking at.

The filtering being done here means we essentially only care about dirty
pages backed by delalloc blocks. That means if you get here with a dirty
page and the portion of the page affected by this failed write is
uptodate, this won't punch an underlying delalloc block even though
nothing else may have written to it in the meantime. That sort of state
can be created by a prior read of the range on a sub-page block size fs,
or perhaps a racing async readahead (via read fault of a lower
offset..?), etc.

I suspect this is not a serious error because the page is dirty and
writeback will thus convert the block. The only exception to that I can
see is if the block is beyond EOF (consider a mapped read to a page that
straddles EOF, followed by a post-eof write that fails), writeback won't
actually map the block directly. It may convert if contiguous with
delalloc blocks inside EOF (and sufficiently sized physical extents
exist), or even if not, should still otherwise be cleaned up by the
various other means we already have to manage post-eof blocks.

So IOW there's a tradeoff being made here for possible spurious
allocation and I/O and a subtle dependency on writeback that should
probably be documented somewhere. The larger concern is that if
writeback eventually changes based on dirty range tracking in a way that
breaks this dependency, that introduces yet another stale delalloc block
landmine associated with this error handling code (regardless of whether
you want to call that a bug in this code, seek data, whatever), and
those problems are difficult enough to root cause as it is.

Brian

[1]

# xfs_io -fc "falloc 0 4k" -c "seek -a 0" -c "pread 0 4k" -c "seek -a 0" <file>
Whence  Result
HOLE    0
read 4096/4096 bytes at offset 0
4 KiB, 4 ops; 0.0000 sec (156 MiB/sec and 160000.0000 ops/sec)
Whence  Result
DATA    0
HOLE    4096

> +		/*
> +		 * If there is no more data to scan, all that is left is to
> +		 * punch out the remaining range.
> +		 */
> +		if (start_byte == -ENXIO || start_byte == end_byte)
> +			break;
> +		if (start_byte < 0) {
> +			error = start_byte;
> +			goto out_unlock;
> +		}
> +		ASSERT(start_byte >= punch_start_byte);
> +		ASSERT(start_byte < end_byte);
> +
> +		/*
> +		 * We find the end of this contiguous cached data range by
> +		 * seeking from start_byte to the beginning of the next hole.
> +		 */
> +		data_end = mapping_seek_hole_data(inode->i_mapping, start_byte,
> +				end_byte, SEEK_HOLE);
> +		if (data_end < 0) {
> +			error = data_end;
> +			goto out_unlock;
> +		}
> +		ASSERT(data_end > start_byte);
> +		ASSERT(data_end <= end_byte);
> +
> +		error = xfs_buffered_write_delalloc_scan(inode,
> +				&punch_start_byte, start_byte, data_end);
> +		if (error)
> +			goto out_unlock;
> +
> +		/* The next data search starts at the end of this one. */
> +		start_byte = data_end;
> +	}
> +
> +	if (punch_start_byte < end_byte)
> +		error = xfs_buffered_write_delalloc_punch(inode,
> +				punch_start_byte, end_byte);
> +out_unlock:
> +	filemap_invalidate_unlock(inode->i_mapping);
> +	return error;
> +}
> +
>  static int
>  xfs_buffered_write_iomap_end(
>  	struct inode		*inode,
> @@ -1179,16 +1319,7 @@ xfs_buffered_write_iomap_end(
>  	if (start_byte >= end_byte)
>  		return 0;
>  
> -	/*
> -	 * Lock the mapping to avoid races with page faults re-instantiating
> -	 * folios and dirtying them via ->page_mkwrite between the page cache
> -	 * truncation and the delalloc extent removal. Failing to do this can
> -	 * leave dirty pages with no space reservation in the cache.
> -	 */
> -	filemap_invalidate_lock(inode->i_mapping);
> -	truncate_pagecache_range(inode, start_byte, end_byte - 1);
> -	error = xfs_buffered_write_delalloc_punch(inode, start_byte, end_byte);
> -	filemap_invalidate_unlock(inode->i_mapping);
> +	error = xfs_buffered_write_delalloc_release(inode, start_byte, end_byte);
>  	if (error && !xfs_is_shutdown(mp)) {
>  		xfs_alert(mp, "%s: unable to clean up ino 0x%llx",
>  			__func__, XFS_I(inode)->i_ino);
> -- 
> 2.37.2
> 
> 

