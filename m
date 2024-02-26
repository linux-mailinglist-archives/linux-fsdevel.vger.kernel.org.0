Return-Path: <linux-fsdevel+bounces-12802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96018867582
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 13:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C757A1C220C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 12:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F7560860;
	Mon, 26 Feb 2024 12:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="yorHxad0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7340AEC7
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 12:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708951655; cv=none; b=O4QW3bRMGBsqZKdqZVcc4BNBgfZDSVX/CRMv87g/WxVcQQ/h3uMERT/Q2a4VOyPsMVHAb1iU8ZA4u1EAhjwFAWNUdOQ2m24zfb7Jt73sLELA5ZHA0ajrqSqBLnQjd/WbujL/j5dVOuD+cprzW8we12f8ZfaWSWdo56a1l56BS0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708951655; c=relaxed/simple;
	bh=dN7vlfm2CWuP7gytdhzY1G0iMgJePvyOPGhA6GCsXPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlyMkRfrcZeD6ISiOY6ePP0S4RiMVvR1Am6cGaxSVWtP11p/tTteFTmHrLC50tACMqkM9SnSN6Z1o08BS05D13YGJKbdF9IAleeG1p6T2161odXzkQ/yTVw3DkH2wLDn+laXDvL0hKsI95q75sCy2hwveM+BX/2mn3ES1Nx1+5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=yorHxad0; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e459b39e2cso1640139b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 04:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1708951654; x=1709556454; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nyrubZrd+iQQ9LRdmGo0pLnE0GnOJFu8Ms2d6zdohTc=;
        b=yorHxad0Q2CTEfzncY+ztjfHw/nemFR33fL9via7ohGcaIULF0x3HojLZf/UqW3S4z
         9bZI0jUT9fM48y4aBcJE/Gs5ACGUaat0xkeo0mKou5B0L5hr47wgWceI3dRhhkuuJNQY
         zN/kSt8OXwj9SJ+M5wRKvCbrgxivjyceI0OGGEx5FdJP9I6btAhUdFYNuAXEPz7DVsVt
         lXAlBbHxLl1dEU1Ahc265wpsNvn9I/DVyFXrPWbv2o5QTOs0gJutv9aDECKWyvZxyEoM
         FWshhAUN7+kJp4m0HJBJG70taftd1XZadPI//NOZQsXPAOhHQVCGqW0qL/1wG/+V74gq
         UI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708951654; x=1709556454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nyrubZrd+iQQ9LRdmGo0pLnE0GnOJFu8Ms2d6zdohTc=;
        b=XW7GIsJ7J1hbTjwvucv5mX3ftca2h98FwSko5aCj8bKRnf3FBJhQ9OYp9MyiZTVVBL
         rGaH85gKlhaxcGVWpz5V6ADdsZTM795YL8kuBTR1k8Qu9u+lV+qqTUU+6/ZdlLn7qKnQ
         ACMqUd6yqnJLx4PqSghskRcXUTM+KFYV7yjckvJ+nCwBfgQDj3vUnYdT51runBUajmPV
         bMPYyi3RSnqaIIP8LOcy816atyhTH/LUlsXUaCxnXwuXQsLjN/TwiiKbKYuIHRJZdwLg
         YtxZyvwMFLFhW58psU+nqMMfOnDauLsYEKZOBCeajqCtOd47ArFSznFve2D4P3yBuJsn
         082Q==
X-Forwarded-Encrypted: i=1; AJvYcCWnOR1uL/UvdUil7nk9Qx8OfHmY66ji4ueLWknZP8UWD3aacBuJUSg/hFPPOlSmvzO4Zbrk7IpyK/95MPXScdyTlgVI1LMhAjHs2EQibw==
X-Gm-Message-State: AOJu0Yx/njtKX0wyGyErWe8Z7n3JhlBEYvrzqaFYKQ78Nim4JNJTMFTT
	WOArWuACCR56hmLZtfV991FJZnLK1YO2Y2/+PBjQzhIbgyR1xr6ymqqL+C/pAV8=
X-Google-Smtp-Source: AGHT+IFX/dKtzGRqrmOKHZtigWLQqswOK9f44At5pPNmVA4fazaZ6Tbtk13iEH+Bwie50vdjALOU8A==
X-Received: by 2002:a05:6a21:1584:b0:1a1:5ad:4129 with SMTP id nr4-20020a056a21158400b001a105ad4129mr1274023pzb.15.1708951653839;
        Mon, 26 Feb 2024 04:47:33 -0800 (PST)
Received: from dread.disaster.area (pa49-181-247-196.pa.nsw.optusnet.com.au. [49.181.247.196])
        by smtp.gmail.com with ESMTPSA id l3-20020a62be03000000b006e4432027d1sm4030530pff.142.2024.02.26.04.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 04:47:33 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1reaOI-00BkxF-2y;
	Mon, 26 Feb 2024 23:47:30 +1100
Date: Mon, 26 Feb 2024 23:47:30 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, chandan.babu@oracle.com,
	akpm@linux-foundation.org, mcgrof@kernel.org, ziy@nvidia.com,
	hare@suse.de, djwong@kernel.org, gost.dev@samsung.com,
	linux-mm@kvack.org, willy@infradead.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 12/13] xfs: make the calculation generic in
 xfs_sb_validate_fsb_count()
Message-ID: <ZdyIYrei4QWvAMpx@dread.disaster.area>
References: <20240226094936.2677493-1-kernel@pankajraghav.com>
 <20240226094936.2677493-13-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226094936.2677493-13-kernel@pankajraghav.com>

On Mon, Feb 26, 2024 at 10:49:35AM +0100, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> Instead of assuming that PAGE_SHIFT is always higher than the blocklog,
> make the calculation generic so that page cache count can be calculated
> correctly for LBS.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  fs/xfs/xfs_mount.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
> index aabb25dc3efa..69af3b06be99 100644
> --- a/fs/xfs/xfs_mount.c
> +++ b/fs/xfs/xfs_mount.c
> @@ -133,9 +133,15 @@ xfs_sb_validate_fsb_count(
>  {
>  	ASSERT(PAGE_SHIFT >= sbp->sb_blocklog);
>  	ASSERT(sbp->sb_blocklog >= BBSHIFT);
> +	uint64_t mapping_count;
> +	uint64_t bytes;
>  
> +	if (check_mul_overflow(nblocks, (1 << sbp->sb_blocklog), &bytes))
> +		return -EFBIG;
> +
> +	mapping_count = bytes >> PAGE_SHIFT;

max_index, not a "mapping count". Also, put this after this comment:

>  	/* Limited by ULONG_MAX of page cache index */

So it is obvious what the max_index we are calculating belongs to.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

