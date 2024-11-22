Return-Path: <linux-fsdevel+bounces-35581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A785B9D603F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 15:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66B4F281EB2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 14:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A44179FE;
	Fri, 22 Nov 2024 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hCYunQ/k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B49F2309B7
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 14:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732285108; cv=none; b=H9Pp0evOXrIhL2w2uNP/RdH/lykGo+tA9sC7OPMhz3svS9E6DJqa0QSgZIb2xBi0h55xJgm4lE/qnLloT57ioheEYCBLzZeC+N77PWi5pAiSidx8+7Nl0RznPHqOigToR7IgGuEIyJMjjFDrlJqc9vy3DycD0AsvATwKv1RhGxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732285108; c=relaxed/simple;
	bh=oH/1VH4SWk+Pr93Lyt690w84LbIIETSUZTB2Rf+OoxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OhE0DHQYAEO7kGmrpK9Qsk/7tRGpMqTJE0r9mLmlyrJFQXuKL+3P52rAI1cE9zhBglAjlph2UqR9f+dte+GsmjI4/BogpfWqQdIdcMaYq9aRQU9OTDUOtMyhbmDnFWa8VzZpJaZ5cHx3mpxqJYyNnieaimSmAGNp2HsOZHhTC8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hCYunQ/k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732285106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0yVasfE2vHiAdDHBcqhYhJPkY/HalhiFkM5FtdGHDI0=;
	b=hCYunQ/ktF7pS8gB1r/+QYHJo5SdvA/1dXmBVE8FIAbENd14l4ZEThxyfXEjUN1vxQJ3IC
	QTeuwvz8nF7Z5E8WNO0Pqrbg+RVy+Q14Q0mwdOuyA1kky9GgWAXlwzlrzj+XzCVf4cAs30
	uvme3PoIeXs73dCjLbbi07O6NQ+iCHA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-470-uE280pUONnSfATs0eGQxKA-1; Fri,
 22 Nov 2024 09:18:24 -0500
X-MC-Unique: uE280pUONnSfATs0eGQxKA-1
X-Mimecast-MFC-AGG-ID: uE280pUONnSfATs0eGQxKA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CCD0A195608A;
	Fri, 22 Nov 2024 14:18:22 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.120])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DCC7630001A0;
	Fri, 22 Nov 2024 14:18:20 +0000 (UTC)
Date: Fri, 22 Nov 2024 09:19:53 -0500
From: Brian Foster <bfoster@redhat.com>
To: Long Li <leo.lilong@huawei.com>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v3 1/2] iomap: fix zero padding data issue in concurrent
 append writes
Message-ID: <Z0CTCYWwu8Ko0rPV@bfoster>
References: <20241121063430.3304895-1-leo.lilong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121063430.3304895-1-leo.lilong@huawei.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Nov 21, 2024 at 02:34:29PM +0800, Long Li wrote:
> During concurrent append writes to XFS filesystem, zero padding data
> may appear in the file after power failure. This happens due to imprecise
> disk size updates when handling write completion.
> 
> Consider this scenario with concurrent append writes same file:
> 
>   Thread 1:                  Thread 2:
>   ------------               -----------
>   write [A, A+B]
>   update inode size to A+B
>   submit I/O [A, A+BS]
>                              write [A+B, A+B+C]
>                              update inode size to A+B+C
>   <I/O completes, updates disk size to min(A+B+C, A+BS)>
>   <power failure>
> 
> After reboot:
>   1) with A+B+C < A+BS, the file has zero padding in range [A+B, A+B+C]
> 
>   |<         Block Size (BS)      >|
>   |DDDDDDDDDDDDDDDD0000000000000000|
>   ^               ^        ^
>   A              A+B     A+B+C
>                          (EOF)
> 
>   2) with A+B+C > A+BS, the file has zero padding in range [A+B, A+BS]
> 
>   |<         Block Size (BS)      >|<           Block Size (BS)    >|
>   |DDDDDDDDDDDDDDDD0000000000000000|00000000000000000000000000000000|
>   ^               ^                ^               ^
>   A              A+B              A+BS           A+B+C
>                                   (EOF)
> 
>   D = Valid Data
>   0 = Zero Padding
> 
> The issue stems from disk size being set to min(io_offset + io_size,
> inode->i_size) at I/O completion. Since io_offset+io_size is block
> size granularity, it may exceed the actual valid file data size. In
> the case of concurrent append writes, inode->i_size may be larger
> than the actual range of valid file data written to disk, leading to
> inaccurate disk size updates.
> 
> This patch changes the meaning of io_size to represent the size of
> valid data in ioend, while the extent size of ioend can be obtained
> by rounding up based on block size. It ensures more precise disk
> size updates and avoids the zero padding issue.  Another benefit is
> that it makes the xfs_ioend_is_append() check more accurate, which
> can reduce unnecessary end bio callbacks of xfs_end_bio() in certain
> scenarios, such as repeated writes at the file tail without extending
> the file size.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Long Li <leo.lilong@huawei.com>
> ---
> v2->v3:
>   1. Modify commit message and add the description of A+B+C > A+BS
>   2. Rename iomap_ioend_extent_size() to iomap_ioend_size_aligned()
>   3. Move iomap_ioend_size_aligned to buffered-io.c and avoid exposed
>      to new users.
>   4. Add comment for rounding up io_size to explain when/why use it
> 

Thanks for the tweaks..

>  fs/iomap/buffered-io.c | 43 ++++++++++++++++++++++++++++++++++++------
>  include/linux/iomap.h  |  2 +-
>  2 files changed, 38 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index d42f01e0fc1c..3f59dfb4d58d 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1593,12 +1593,35 @@ iomap_finish_ioends(struct iomap_ioend *ioend, int error)
>  }
>  EXPORT_SYMBOL_GPL(iomap_finish_ioends);
>  
> +/*
> + * Calculates the extent size of an ioend by rounding up to block size. When
> + * the last block in the ioend's extent contains the file EOF and the EOF is
> + * not block-aligned, the io_size will not be block-aligned.
> + *
> + * This function is specifically used for ioend grow/merge management:
> + * 1. In concurrent writes, when one write's io_size is truncated due to
> + *    non-block-aligned file size while another write extends the file size,
> + *    if these two writes are physically and logically contiguous at block
> + *    boundaries, rounding up io_size to block boundaries helps grow the
> + *    first write's ioend and share this ioend between both writes.
> + * 2. During IO completion, we try to merge physically and logically
> + *    contiguous ioends before completion to minimize the number of
> + *    transactions. Rounding up io_size to block boundaries helps merge
> + *    ioends whose io_size is not block-aligned.
> + */

I might suggest to simplify this and maybe split off a comment to where
the ioend size is trimmed as well. For example:

"Calculate the physical size of an ioend by rounding up to block
granularity. io_size might be unaligned if the last block crossed an
unaligned i_size boundary at creation time."

> +static inline size_t iomap_ioend_size_aligned(struct iomap_ioend *ioend)
> +{
> +	return round_up(ioend->io_size, i_blocksize(ioend->io_inode));
> +}
> +
>  /*
>   * We can merge two adjacent ioends if they have the same set of work to do.
>   */
>  static bool
>  iomap_ioend_can_merge(struct iomap_ioend *ioend, struct iomap_ioend *next)
>  {
> +	size_t size = iomap_ioend_size_aligned(ioend);
> +
>  	if (ioend->io_bio.bi_status != next->io_bio.bi_status)
>  		return false;
>  	if (next->io_flags & IOMAP_F_BOUNDARY)
...
> @@ -1784,12 +1810,17 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
>  		wpc->ioend = iomap_alloc_ioend(wpc, wbc, inode, pos);
>  	}
>  
> -	if (!bio_add_folio(&wpc->ioend->io_bio, folio, len, poff))
> +	ioend = wpc->ioend;
> +	if (!bio_add_folio(&ioend->io_bio, folio, len, poff))
>  		goto new_ioend;
>  
>  	if (ifs)
>  		atomic_add(len, &ifs->write_bytes_pending);
> -	wpc->ioend->io_size += len;
> +

And here..

"If the ioend spans i_size, trim io_size to the former to provide the fs
with more accurate size information. This is useful for completion time
on-disk size updates."

> +	ioend->io_size = iomap_ioend_size_aligned(ioend) + len;
> +	if (ioend->io_offset + ioend->io_size > isize)
> +		ioend->io_size = isize - ioend->io_offset;
> +
>  	wbc_account_cgroup_owner(wbc, folio, len);
>  	return 0;
>  }
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 5675af6b740c..956a0f7c2a8d 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -335,7 +335,7 @@ struct iomap_ioend {
>  	u16			io_type;
>  	u16			io_flags;	/* IOMAP_F_* */
>  	struct inode		*io_inode;	/* file being written to */
> -	size_t			io_size;	/* size of the extent */
> +	size_t			io_size;	/* size of valid data */

"valid data" is kind of unclear to me. Maybe just "size of data within
eof..?"

But those are just suggestions. Feel free to take, leave or reword any
of it, and this LGTM regardless:

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  	loff_t			io_offset;	/* offset in the file */
>  	sector_t		io_sector;	/* start sector of ioend */
>  	struct bio		io_bio;		/* MUST BE LAST! */
> -- 
> 2.39.2
> 
> 


