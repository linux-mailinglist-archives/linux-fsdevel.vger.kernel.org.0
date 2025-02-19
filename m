Return-Path: <linux-fsdevel+bounces-42124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7936FA3CC37
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 23:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BBC73ADC65
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 22:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DAD2586D8;
	Wed, 19 Feb 2025 22:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="poyAimLC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E107235341;
	Wed, 19 Feb 2025 22:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740003778; cv=none; b=HpzeDJXCm7UjsjCidl8oLcYzGeUxoI8wAzzsGuzBvd+G3McAn1EI7bg0o8i8p1AabzCoqDXo0H7Imj3fVdiq+PLZMy+kt4nbRjQ7P/HYAS8fmUvv30jew2A2kPbTo+REsv+1i6SiDc2xVa+lDrsTEMnRAlUroLve7vBLcb8n5hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740003778; c=relaxed/simple;
	bh=xWgGgWbi3i0lhTbc6RB4l6UKJ+2bnTKHbsSpD11BEn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ef1fChL4cQrLYyt34TjHufSwJ1FscH6iwS9aS4uu7/k0yM1tL1hEBGog4IsYxyLHPtrzlsJ6JtTc9RvuyVo0NA7v5GhlMOziOqwx2xyV71AjtbKkdAHMv+gI5s78ilAjqbS4JjtsJUhop1u5TgGXwoQ9RpXeEOTMo9lH/4AkE0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=poyAimLC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D62C4CED1;
	Wed, 19 Feb 2025 22:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740003777;
	bh=xWgGgWbi3i0lhTbc6RB4l6UKJ+2bnTKHbsSpD11BEn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=poyAimLCcvcYV1LDiflLLpUPMJvOa2fkZdkjH3DSIY8WG1JwJSDS8g0xt7zfpI8Io
	 SYGdLOcRSwA1JOMJJbllaeB0T4iyk1Q93fWwCqktHe9Yk9X33eq/kYkLHBdQSctYsd
	 6zH4xfAXoioC/EXRRIWsxC9DfhUbPfvmu10PF/af56c5oIKUGcq6r8zuFk+RkSv6sG
	 6LBLPs+Ry+evIFjoRxXCN9AykNCetdWbOcuZ2VNKUTJkv0aT5Urz6crl7hfvVe4drV
	 2Hy3UDA2Z9RCqCm2R/Xemhuz8e+yXCC/GiXzbdU2tNIey23hfSRKpW5nrTYQ5s1FcX
	 I6r6ZYSGxFybw==
Date: Wed, 19 Feb 2025 14:22:57 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 02/12] iomap: advance the iter on direct I/O
Message-ID: <20250219222257.GC21808@frogsfrogsfrogs>
References: <20250219175050.83986-1-bfoster@redhat.com>
 <20250219175050.83986-3-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219175050.83986-3-bfoster@redhat.com>

On Wed, Feb 19, 2025 at 12:50:40PM -0500, Brian Foster wrote:
> Update iomap direct I/O to advance the iter directly rather than via
> iter.processed. Update each mapping type helper to advance based on
> the amount of data processed and return success or failure.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>

Looks pretty straightforward,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/direct-io.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index b521eb15759e..b3599f8d12ac 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -289,8 +289,7 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
>  	return opflags;
>  }
>  
> -static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
> -		struct iomap_dio *dio)
> +static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>  {
>  	const struct iomap *iomap = &iter->iomap;
>  	struct inode *inode = iter->inode;
> @@ -303,7 +302,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  	bool need_zeroout = false;
>  	bool use_fua = false;
>  	int nr_pages, ret = 0;
> -	size_t copied = 0;
> +	u64 copied = 0;
>  	size_t orig_count;
>  
>  	if (atomic && length != fs_block_size)
> @@ -467,30 +466,28 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  	/* Undo iter limitation to current extent */
>  	iov_iter_reexpand(dio->submit.iter, orig_count - copied);
>  	if (copied)
> -		return copied;
> +		return iomap_iter_advance(iter, &copied);
>  	return ret;
>  }
>  
> -static loff_t iomap_dio_hole_iter(const struct iomap_iter *iter,
> -		struct iomap_dio *dio)
> +static int iomap_dio_hole_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>  {
>  	loff_t length = iov_iter_zero(iomap_length(iter), dio->submit.iter);
>  
>  	dio->size += length;
>  	if (!length)
>  		return -EFAULT;
> -	return length;
> +	return iomap_iter_advance(iter, &length);
>  }
>  
> -static loff_t iomap_dio_inline_iter(const struct iomap_iter *iomi,
> -		struct iomap_dio *dio)
> +static int iomap_dio_inline_iter(struct iomap_iter *iomi, struct iomap_dio *dio)
>  {
>  	const struct iomap *iomap = &iomi->iomap;
>  	struct iov_iter *iter = dio->submit.iter;
>  	void *inline_data = iomap_inline_data(iomap, iomi->pos);
>  	loff_t length = iomap_length(iomi);
>  	loff_t pos = iomi->pos;
> -	size_t copied;
> +	u64 copied;
>  
>  	if (WARN_ON_ONCE(!iomap_inline_data_valid(iomap)))
>  		return -EIO;
> @@ -512,11 +509,10 @@ static loff_t iomap_dio_inline_iter(const struct iomap_iter *iomi,
>  	dio->size += copied;
>  	if (!copied)
>  		return -EFAULT;
> -	return copied;
> +	return iomap_iter_advance(iomi, &copied);
>  }
>  
> -static loff_t iomap_dio_iter(const struct iomap_iter *iter,
> -		struct iomap_dio *dio)
> +static int iomap_dio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>  {
>  	switch (iter->iomap.type) {
>  	case IOMAP_HOLE:
> -- 
> 2.48.1
> 
> 

