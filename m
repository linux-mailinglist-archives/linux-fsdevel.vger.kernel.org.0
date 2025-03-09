Return-Path: <linux-fsdevel+bounces-43558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 122EEA588C4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Mar 2025 23:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98D20188B8CD
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Mar 2025 22:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B1719DF8B;
	Sun,  9 Mar 2025 22:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="ll43LU1b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AFB1ADC7B
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Mar 2025 22:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741557839; cv=none; b=JCVHw23Ce7Zb4BpR6pRU+cviGDDzsH4pe2/Xv7ttFJ3KQ/viKwShL3jd9Gm75MooQqoiXqn6o7Z1azuefj+s4smC5wlH/ADCZD3Ts2+AtO77LDqSyWtowhogBL7ZB3QIyqYsFvzzbqKKNQmo7mg0zbv37maWVFbaot8AyxLOb98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741557839; c=relaxed/simple;
	bh=JQLHE5htqxDYXrr3QIScKSn+/HYlywKSaeUU+2okPcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSy4IQkNoZ6u/uia1SlTVL1QqHO+7D1LfupDU3CcgXRBIW6IVbnxiVzlviNtjEh+i1yqGcKAHWhOQ6x8X5qhv52+XBMdihtDBY9Eo3+NOIWqKT/YCoeOPFLIIPVBDcHFoDzkbOwWucyz/TWImZcwU82ZK3jCxC/3dCJiWyq5unA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=ll43LU1b; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-224171d6826so45981095ad.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Mar 2025 15:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1741557836; x=1742162636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hIVTntw+6S/j1ajpJsjlP3frsHftTY0cBdO3R42IMlg=;
        b=ll43LU1bXZEzSHG31syp3/u1KtqXGWnqNXo4+/NowRduZ8faC3R44O86Y7ViHhcU5f
         PMMLfuk3m7wRuJ2RkBd+hz1XESN2NJMiwNR5DLWdxEoKv/aetFovHGpiLeODnn3ala6k
         omsffJQFHJINszzt0y3ROVGIJsdr9UWTtcSDazyBoTJ7jboGIqNBvV88qloCCKNOt6N9
         Ddtb93qp5cmY/6hcWPDQZqSBNYSY1rEXqKvSHnnKXDhJqYBtAVVMjQoMS9CES1GgdTfa
         Szz994YEILL8qlpxI5gsvP/jtWAQ0NXzjGjtRIucBpuA/7pc7zGQcB6Up/Y6yWhcoLZ3
         Le4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741557836; x=1742162636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIVTntw+6S/j1ajpJsjlP3frsHftTY0cBdO3R42IMlg=;
        b=E28c5dEe/aeMtl29G4B3YS5aCqP9QUskrIRUiEuv+a9GlYNhIgwNRORWcOZOyz4CQ3
         5YvIDVK6TMmVaD8SJKYnx4jt2Hs14MLaFvJm3y28R5tVB30kvJCdTCfePa0lyDF4YJfM
         xsFyu29iIw6HbdwhzrwG1dsLPABoRjQfVYEbtCwiJdHcQSBxNDTEd9IneKkzRYdrEG+L
         dYIOzdYhAp2UVv32qvQAzJ6jGFcmWRnd+2MsF0iPKNSKtvrZ99D6fhxDSpHGRiwQDt6I
         RSXISo0fL9WhRp8MkBuOwp4tbdvwr0B/J6mH/haH0usbvZOchce2xwrCxCMEWIX2hIoA
         iYJQ==
X-Forwarded-Encrypted: i=1; AJvYcCURS1M31R3fM+r9ejkMe+Pdd7otdzTX+1UVm7EaQTdDmcy2z00KRmcP9wLmIU2tHW+BZIvfBGAujGGY4/YC@vger.kernel.org
X-Gm-Message-State: AOJu0YxL4u85ha+QfKp1TesaJ+wP2oxfzCMzVlv4J+Cd+402YdOyBgdM
	qwKDJoIhhAhjNICVBOCz1rxQRpbYfWwTnFjhO3R9QZ2FRwYzws7uxkBqCXKKaG8=
X-Gm-Gg: ASbGncvBuNXytrv/wHmgyt5PVsRRplb1Cg4oztG1fmWMVNgKM/QPx/G3aIOi3ktY5pP
	RBbYlM49HrEEYoiKKFRmZ+OWn14hPxdgigppnS5/7aN7082YGWcrqmT8tZ4gbNJE4b0tqOqFOHL
	DcTg/eyYIPlxwi2DjLu5YCm6kMhs03GPwmbT49cJdoAzc1s2wotB/0usn45eloTpz2yBiTCNIZ3
	3LDWDDVgGeiUN4Y/1VFlJDf1gcq9YnXlpersf9cuizANStOhXEfOdMF1BSeW+yE3o6kPo6ztBCa
	yHcS93prxldVGysUvqmxX6Idyh0+ktuuEQAudFY/ezCWE/Nr2FkY3x5pi67AzIDMN3cZdiHRQ35
	7B/AYemq8j32QX/ChrEoMUXalSbRjN5w=
X-Google-Smtp-Source: AGHT+IH/powE1N2CCtK7Ml2mLRBsL6fzJEMihCFIpP3W69gTDvwEB08TAGMnpbJmG62pqfj+ytkESg==
X-Received: by 2002:a05:6a00:4b4a:b0:736:5c8e:baaa with SMTP id d2e1a72fcca58-736aa9bc0e9mr16487541b3a.2.1741557836403;
        Sun, 09 Mar 2025 15:03:56 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736be0ae3desm3435489b3a.12.2025.03.09.15.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 15:03:55 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1trOkR-0000000B2kg-3jwt;
	Mon, 10 Mar 2025 09:03:51 +1100
Date: Mon, 10 Mar 2025 09:03:51 +1100
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v4 12/12] xfs: Allow block allocator to take an alignment
 hint
Message-ID: <Z84QRx_yEDEDUxr5@dread.disaster.area>
References: <20250303171120.2837067-1-john.g.garry@oracle.com>
 <20250303171120.2837067-13-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303171120.2837067-13-john.g.garry@oracle.com>

On Mon, Mar 03, 2025 at 05:11:20PM +0000, John Garry wrote:
> When issuing an atomic write by the CoW method, give the block allocator a
> hint to align to the extszhint.
> 
> This means that we have a better chance to issuing the atomic write via
> HW offload next time.
> 
> It does mean that the inode extszhint should be set appropriately for the
> expected atomic write size.
> 
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/libxfs/xfs_bmap.c | 7 ++++++-
>  fs/xfs/libxfs/xfs_bmap.h | 6 +++++-
>  fs/xfs/xfs_reflink.c     | 8 ++++++--
>  3 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> index 0ef19f1469ec..9bfdfb7cdcae 100644
> --- a/fs/xfs/libxfs/xfs_bmap.c
> +++ b/fs/xfs/libxfs/xfs_bmap.c
> @@ -3454,6 +3454,12 @@ xfs_bmap_compute_alignments(
>  		align = xfs_get_cowextsz_hint(ap->ip);
>  	else if (ap->datatype & XFS_ALLOC_USERDATA)
>  		align = xfs_get_extsz_hint(ap->ip);
> +
> +	if (align > 1 && ap->flags & XFS_BMAPI_EXTSZALIGN)

needs () around the & logic.

	if (align > 1 && (ap->flags & XFS_BMAPI_EXTSZALIGN))

> +		args->alignment = align;
> +	else
> +		args->alignment = 1;

When is  args->alignment not already initialised to 1?

> +
>  	if (align) {
>  		if (xfs_bmap_extsize_align(mp, &ap->got, &ap->prev, align, 0,
>  					ap->eof, 0, ap->conv, &ap->offset,
> @@ -3782,7 +3788,6 @@ xfs_bmap_btalloc(
>  		.wasdel		= ap->wasdel,
>  		.resv		= XFS_AG_RESV_NONE,
>  		.datatype	= ap->datatype,
> -		.alignment	= 1,
>  		.minalignslop	= 0,
>  	};

Oh, you removed the initialisation to 1, so now we have the
possibility of getting args->alignment = 0 anywhere in the
allocation stack?

FWIW, we've been trying to get rid of that case - args->alignment should
always be 1 if no alignment is necessary so we don't ahve to special
case alignment of 0  (meaning no alignemnt) anywhere. This seems
like a step backwards from that perspective...



>  	xfs_fileoff_t		orig_offset;
> diff --git a/fs/xfs/libxfs/xfs_bmap.h b/fs/xfs/libxfs/xfs_bmap.h
> index 4b721d935994..e6baa81e20d8 100644
> --- a/fs/xfs/libxfs/xfs_bmap.h
> +++ b/fs/xfs/libxfs/xfs_bmap.h
> @@ -87,6 +87,9 @@ struct xfs_bmalloca {
>  /* Do not update the rmap btree.  Used for reconstructing bmbt from rmapbt. */
>  #define XFS_BMAPI_NORMAP	(1u << 10)
>  
> +/* Try to align allocations to the extent size hint */
> +#define XFS_BMAPI_EXTSZALIGN	(1u << 11)

Don't we already do that?

Or is this doing something subtle and non-obvious like overriding
stripe width alignment for large atomic writes?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

