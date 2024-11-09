Return-Path: <linux-fsdevel+bounces-34134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 498449C299F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 04:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CABA8B21E7C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 03:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6713B2BB;
	Sat,  9 Nov 2024 03:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQXFLQQs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C96C2E401
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Nov 2024 03:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731121211; cv=none; b=OnMWYvuXi9RPdGTId37qzBWfioLNOHrnf8hU/6H0cjeh9NfmCnJaxW3NXKJIpQkG2ttlo5F1bZuuG3IaumoYK8uAvfSkNHzVi+UR80tUsq3iOxKOZCoq981y1FSvmsu1HeWPtmxUb4v9EkJ1iBuqTWb1BGZA0XW7Lg831akcV3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731121211; c=relaxed/simple;
	bh=hk+1gGuqilh4027HNt/nWEhtR6G6cDhjpBQ0G5lv4/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=boNEBWXFarozvX9yXQwiVjOWriZ+A2yGPiTdV0Cy6l7NVdEXdcse+Gtgu4qD/YfGhnEwH+qhBOXiKDgEQb7ial7j73kz4CqQs6/K6juR//IgJUHEJoVr2bKl13YFEvEc9NRTq3DSj4sQe6T2o8DJUlEVU0hM8G9o0Y73+C5nPts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQXFLQQs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11EC6C4CECD;
	Sat,  9 Nov 2024 03:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731121211;
	bh=hk+1gGuqilh4027HNt/nWEhtR6G6cDhjpBQ0G5lv4/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kQXFLQQsL1f17I2bxadWapeyktUwXR5rEY+U+jrXMa010bkQe+ndWRlgUbGs3oqiq
	 l49t3QEU1GCnM+wa6haxtPm16FsKCnthyNItMNh6g1s3TDS5cVubu992NYEvcfg5tz
	 v6nLKPwbnDaQ45dyQSAV52qXPrbjh5ywgJDuglBDilOSlqMBwcFQ2SMJKPFDPwr3bJ
	 GlfSA+PgouFrDOfRQuIeHmKe61vPqTTWeXJQClecC4n1SAaguHbOJrgqudWNsZTWsZ
	 aNnor7yd1EHp6lFAu6/zCNVT5s7QRkWJ50jCXbN2dDZEr2rzOACecVl6hOC+3IL0T7
	 Y7b5LanUm6nJQ==
Date: Fri, 8 Nov 2024 19:00:10 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] iomap: reset per-iter state on non-error iter
 advances
Message-ID: <20241109030010.GA9421@frogsfrogsfrogs>
References: <20241108124246.198489-1-bfoster@redhat.com>
 <20241108124246.198489-2-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108124246.198489-2-bfoster@redhat.com>

On Fri, Nov 08, 2024 at 07:42:43AM -0500, Brian Foster wrote:
> iomap_iter_advance() zeroes the processed and mapping fields on
> every non-error iteration except for the last expected iteration
> (i.e. return 0 expected to terminate the iteration loop). This
> appears to be circumstantial as nothing currently relies on these
> fields after the final iteration.
> 
> Therefore to better faciliate iomap_iter reuse in subsequent
> patches, update iomap_iter_advance() to always reset per-iteration
> state on successful completion.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>

Seems pretty straightforward to me,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/iter.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
> index 79a0614eaab7..3790918646af 100644
> --- a/fs/iomap/iter.c
> +++ b/fs/iomap/iter.c
> @@ -22,26 +22,25 @@
>  static inline int iomap_iter_advance(struct iomap_iter *iter)
>  {
>  	bool stale = iter->iomap.flags & IOMAP_F_STALE;
> +	int ret = 1;
>  
>  	/* handle the previous iteration (if any) */
>  	if (iter->iomap.length) {
>  		if (iter->processed < 0)
>  			return iter->processed;
> -		if (!iter->processed && !stale)
> -			return 0;
>  		if (WARN_ON_ONCE(iter->processed > iomap_length(iter)))
>  			return -EIO;
>  		iter->pos += iter->processed;
>  		iter->len -= iter->processed;
> -		if (!iter->len)
> -			return 0;
> +		if (!iter->len || (!iter->processed && !stale))
> +			ret = 0;
>  	}
>  
> -	/* clear the state for the next iteration */
> +	/* clear the per iteration state */
>  	iter->processed = 0;
>  	memset(&iter->iomap, 0, sizeof(iter->iomap));
>  	memset(&iter->srcmap, 0, sizeof(iter->srcmap));
> -	return 1;
> +	return ret;
>  }
>  
>  static inline void iomap_iter_done(struct iomap_iter *iter)
> -- 
> 2.47.0
> 
> 

