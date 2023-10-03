Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757007B5EC2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 03:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238986AbjJCBnB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 21:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjJCBnA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 21:43:00 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305B0C4
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 18:42:57 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5827f6d60aaso221315a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Oct 2023 18:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1696297376; x=1696902176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8V805m7ttXbTthUXmXdTXgnda0hJbi48S1GO+p1UKEU=;
        b=drU+HS8Q5K01OZ4mrulL42bp1jZBbIUFfNlNphHL+Dqee9x/wJe8ze2FAmDhbixoK6
         39UKiXmfALVdAFz+SJ7dsWH2PgEtEtTCQ9tNIgdUZyXs3UpKt2KSHEoKnvb2jeFIPaGG
         thMuPJfZF2uKJDbPKPZpNG8hwN3VdjWF8xhxPI8Rf3xGIQ4ENP6c76W54P6dQwTrtKmC
         5dxyBy8tL5qf6IGFUIBIHCwzeVxHVpsuVSTE1/eBJb9/fyJpaYrLU3xPEYBXFqZjUgtM
         VlurOrUZaUM5opNgGZW4uq+g+cG5e34moKNBGCjBd+aNRFBJQADT6qpl4+yAYwVj/doM
         SkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696297376; x=1696902176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8V805m7ttXbTthUXmXdTXgnda0hJbi48S1GO+p1UKEU=;
        b=YaE4exhVqoaBqsy6LB3WBQnAktBFvTujxizB6WUEzZEB5lXxVcOBd23iYhPkBvHHk3
         SY4ZNtbQiJ4VPUG7jIK65JMkR/fIuDo/uBikbLzQnjqU6AeuZShJVMByGcgKRdiSU2tM
         fg7ngYs9CacjTMPQn2U8xkXacNkCsD+EdW4cYga+A9Hoa37O+YaT6qlSYQ4eq4WqPJKk
         V/V/M3e2kV+6YMuwayBCnG30MdlbkBSfThj9keJfWB/bMADjor+zx5gy+V7ybUD2m9LP
         4Df/Tas0hKi6dXIvua0Uu7NymwLbhjsxfdcNVtH8rf4gfqLE19+jEZ2zGEZ8gGt3+9Jv
         svNQ==
X-Gm-Message-State: AOJu0YzUBDHBoxZwAPRO8GYSdFsa9ECsxzomo+Lqcq8P3HXixfhOCC18
        RYWXeprTkPkLtbmULZB1GcU1Q5rLJSK/WKrdAtM=
X-Google-Smtp-Source: AGHT+IH1MMBNEn/3axN7rieR3Ka9rd9cKkhqHZcuCTJaLw3uXvLw0daIzmInBxIrIYUS3hte/ESRZw==
X-Received: by 2002:a05:6a20:734a:b0:15d:641b:57b6 with SMTP id v10-20020a056a20734a00b0015d641b57b6mr12536153pzc.5.1696297376470;
        Mon, 02 Oct 2023 18:42:56 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id w9-20020a1709026f0900b001b895336435sm133951plk.21.2023.10.02.18.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 18:42:56 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qnUR3-008hoD-0v;
        Tue, 03 Oct 2023 12:42:53 +1100
Date:   Tue, 3 Oct 2023 12:42:53 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     John Garry <john.g.garry@oracle.com>
Cc:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 13/21] fs: xfs: Make file data allocations observe the
 'forcealign' flag
Message-ID: <ZRtxnc7LpOlxZnON@dread.disaster.area>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-14-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929102726.2985188-14-john.g.garry@oracle.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 29, 2023 at 10:27:18AM +0000, John Garry wrote:
> From: "Darrick J. Wong" <djwong@kernel.org>
> 
> The existing extsize hint code already did the work of expanding file
> range mapping requests so that the range is aligned to the hint value.
> Now add the code we need to guarantee that the space allocations are
> also always aligned.
> 
> XXX: still need to check all this with reflink
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> Co-developed-by: John Garry <john.g.garry@oracle.com>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/libxfs/xfs_bmap.c | 22 +++++++++++++++++-----
>  fs/xfs/xfs_iomap.c       |  4 +++-
>  2 files changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> index 328134c22104..6c864dc0a6ff 100644
> --- a/fs/xfs/libxfs/xfs_bmap.c
> +++ b/fs/xfs/libxfs/xfs_bmap.c
> @@ -3328,6 +3328,19 @@ xfs_bmap_compute_alignments(
>  		align = xfs_get_cowextsz_hint(ap->ip);
>  	else if (ap->datatype & XFS_ALLOC_USERDATA)
>  		align = xfs_get_extsz_hint(ap->ip);
> +
> +	/*
> +	 * xfs_get_cowextsz_hint() returns extsz_hint for when forcealign is
> +	 * set as forcealign and cowextsz_hint are mutually exclusive
> +	 */
> +	if (xfs_inode_forcealign(ap->ip) && align) {
> +		args->alignment = align;
> +		if (stripe_align % align)
> +			stripe_align = align;
> +	} else {
> +		args->alignment = 1;
> +	}

This smells wrong.

If a filesystem has a stripe unit set (hence stripe_align is
non-zero) then any IO that crosses stripe unit boundaries will not
be atomic - they will require multiple IOs to different devices.

Hence if the filesystem has a stripe unit set, then all forced
alignment hints for atomic IO *must* be an exact integer divider
of the stripe unit. hence when an atomic IO bundle is aligned, the
atomic boundaries within the bundle always fall on a stripe unit
boundary and never cross devices.

IOWs, for a striped filesystem, the maximum size/alignment for a
single atomic IO unit is the stripe unit.

This should be enforced when the forced align flag is set on the
inode (i.e. from the ioctl)


> +
>  	if (align) {
>  		if (xfs_bmap_extsize_align(mp, &ap->got, &ap->prev, align, 0,
>  					ap->eof, 0, ap->conv, &ap->offset,
> @@ -3423,7 +3436,6 @@ xfs_bmap_exact_minlen_extent_alloc(
>  	args.minlen = args.maxlen = ap->minlen;
>  	args.total = ap->total;
>  
> -	args.alignment = 1;
>  	args.minalignslop = 0;
>  
>  	args.minleft = ap->minleft;
> @@ -3469,6 +3481,7 @@ xfs_bmap_btalloc_at_eof(
>  {
>  	struct xfs_mount	*mp = args->mp;
>  	struct xfs_perag	*caller_pag = args->pag;
> +	int			orig_alignment = args->alignment;
>  	int			error;
>  
>  	/*
> @@ -3543,10 +3556,10 @@ xfs_bmap_btalloc_at_eof(
>  
>  	/*
>  	 * Allocation failed, so turn return the allocation args to their
> -	 * original non-aligned state so the caller can proceed on allocation
> -	 * failure as if this function was never called.
> +	 * original state so the caller can proceed on allocation failure as
> +	 * if this function was never called.
>  	 */
> -	args->alignment = 1;
> +	args->alignment = orig_alignment;
>  	return 0;
>  }

Urk. Not sure that is right, it's certainly a change of behaviour.

> @@ -3694,7 +3707,6 @@ xfs_bmap_btalloc(
>  		.wasdel		= ap->wasdel,
>  		.resv		= XFS_AG_RESV_NONE,
>  		.datatype	= ap->datatype,
> -		.alignment	= 1,
>  		.minalignslop	= 0,
>  	};
>  	xfs_fileoff_t		orig_offset;
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 18c8f168b153..70fe873951f3 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -181,7 +181,9 @@ xfs_eof_alignment(
>  		 * If mounted with the "-o swalloc" option the alignment is
>  		 * increased from the strip unit size to the stripe width.
>  		 */
> -		if (mp->m_swidth && xfs_has_swalloc(mp))
> +		if (xfs_inode_forcealign(ip))
> +			align = xfs_get_extsz_hint(ip);
> +		else if (mp->m_swidth && xfs_has_swalloc(mp))
>  			align = mp->m_swidth;
>  		else if (mp->m_dalign)
>  			align = mp->m_dalign;

Ah. Now I see. This abuses the stripe alignment code to try to
implement this new inode allocation alignment restriction, rather
than just making the extent size hint alignment mandatory....

Yeah, this can be done better... :)

As it is, I have been working on a series that reworks all this
allocator code to separate out the aligned IO from the exact EOF
allocation case to help clean this up for better perag selection
during allocation. I think that needs to be done first before we go
making the alignment code more intricate like this....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
