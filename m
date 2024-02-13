Return-Path: <linux-fsdevel+bounces-11386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF90F8535F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 17:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F33DA1C22346
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 16:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556DD5F876;
	Tue, 13 Feb 2024 16:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXuj59mV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB655D91C;
	Tue, 13 Feb 2024 16:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707841572; cv=none; b=TsaEc1ox2OnE7f2GBrTJ0u2XAh/Py1VKMppZNb1Hisv8eBfFBJAEQH2GZG0wtX9mHmkjor0HL+roOIi3sPUjU8T8mXAOWMD2APVlpDDBVY8Q90arcmWYL6wJPUfNujzX7p7LdEZk8Nw71M2liDN4zry6j4FlpyF+iQeXadZuWIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707841572; c=relaxed/simple;
	bh=TBfQpsjoMY7jrNA/FeZM1dUOfhL8fb7O2OuwjJxxz9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNeJ0VruZVBr1T8GZqsXPj+05LHF2ivsbGuLLQJS48nvnD2cOn7ckYYKMSTmraNj6ws4pE/zNMVTD/rBlZUYFOymm3lciB1dM6O/eC/632kv5Y6ABG8W95ZCs7X96Cp8cjUFF325MymGFn4L7ypV0hiqXbM9bQSZYJmt6ps+2x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXuj59mV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261F3C433F1;
	Tue, 13 Feb 2024 16:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707841572;
	bh=TBfQpsjoMY7jrNA/FeZM1dUOfhL8fb7O2OuwjJxxz9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UXuj59mVbe41ruT+hc23UrwHz5GEpU9LaQu6usf8oy6UrO5tR3wXQWP9DsYDqcp/p
	 f4yvbjgZEZwZCtk0v9CnaFBG2TKsI/XHd2ozlArf53ihmaBW0DiEMVSjkzolA/O1gf
	 7G1wO74ukiATY7yiOnKLKZ5iCSi4EILVAmDGR8Q+hG6J3ZJmyqA2Vd0XItpTDC1oIL
	 HnVKdhX5cjj220+j/3l2QmflzrmgrV5FBGUGdc64RFXLGYVDluv8VVEmwswirF/+AI
	 v5Kx6M8NurqK/NrHOJwpsrw5MCnmHoFmmsHr/7eTYP7pYSoKl/9NxRf4XRs9vyTpkQ
	 0kV+bynbFJMbQ==
Date: Tue, 13 Feb 2024 08:26:11 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	mcgrof@kernel.org, gost.dev@samsung.com, akpm@linux-foundation.org,
	kbusch@kernel.org, chandan.babu@oracle.com, p.raghav@samsung.com,
	linux-kernel@vger.kernel.org, hare@suse.de, willy@infradead.org,
	linux-mm@kvack.org, david@fromorbit.com
Subject: Re: [RFC v2 12/14] xfs: make the calculation generic in
 xfs_sb_validate_fsb_count()
Message-ID: <20240213162611.GP6184@frogsfrogsfrogs>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
 <20240213093713.1753368-13-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213093713.1753368-13-kernel@pankajraghav.com>

On Tue, Feb 13, 2024 at 10:37:11AM +0100, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> Instead of assuming that PAGE_SHIFT is always higher than the blocklog,
> make the calculation generic so that page cache count can be calculated
> correctly for LBS.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  fs/xfs/xfs_mount.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
> index aabb25dc3efa..bfbaaecaf668 100644
> --- a/fs/xfs/xfs_mount.c
> +++ b/fs/xfs/xfs_mount.c
> @@ -133,9 +133,13 @@ xfs_sb_validate_fsb_count(
>  {
>  	ASSERT(PAGE_SHIFT >= sbp->sb_blocklog);
>  	ASSERT(sbp->sb_blocklog >= BBSHIFT);
> +	unsigned long mapping_count;

Nit: indenting

	unsigned long		mapping_count;

> +	uint64_t bytes = nblocks << sbp->sb_blocklog;

What happens if someone feeds us a garbage fs with sb_blocklog > 64?
Or did we check that previously, so an overflow isn't possible?

> +
> +	mapping_count = bytes >> PAGE_SHIFT;

Does this result in truncation when unsigned long is 32 bits?

--D

>  
>  	/* Limited by ULONG_MAX of page cache index */
> -	if (nblocks >> (PAGE_SHIFT - sbp->sb_blocklog) > ULONG_MAX)
> +	if (mapping_count > ULONG_MAX)
>  		return -EFBIG;
>  	return 0;
>  }
> -- 
> 2.43.0
> 
> 

