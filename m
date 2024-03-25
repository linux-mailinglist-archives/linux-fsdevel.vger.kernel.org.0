Return-Path: <linux-fsdevel+bounces-15246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 785CF88AF9C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 20:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3457F301B27
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 19:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F9B14AB8;
	Mon, 25 Mar 2024 19:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SJro86af"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780AA9461;
	Mon, 25 Mar 2024 19:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711394166; cv=none; b=t/0bw7BV9+OCUnbj/GpKLu6Wa5dTXi5aGhFCiTn2Wsx8LUP4rKBBKo+qUocFDFfD5OlFgfxmeZwdTV1JbEmBB43jbU7PUKs5dL+18SW9nR+ekgijwVMM5p+yhLrKU3VWs4mW/LMJPjYkyJctETLJyWL9RkcL9x+jjf8vFRfuzhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711394166; c=relaxed/simple;
	bh=l8mYrO7LA7D7hbrR36TT9zl2GYA+uskKnO6cZSSL8pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFMvZrTF9lKngr+2ia3HmwKXlBpdbE1eyf7sYvsWOg6wUSv6HHOLAKpAaCedCvJczwAkCCH56ARb1APeefAzyZJnlsbNQ7soxWJlYU+s7/v2A/xSIyTi3OJ75puVKwpmGaX7ihQfK0AH7E9Nc2vkr1c5ksLvr8wKsVkjacsHxMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SJro86af; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eTY9tWsMxZ2K3aQkEZJpivPTdRpw7VkLZH41dnj2hEQ=; b=SJro86afQ01NTvzMF0k9zFPIAC
	/zDtpbnYDk4Wq8eoVWQaQ+LHAzjV04+AV+k/5bl0HtvL37X6+HOgXTl4f3F+dzJCDkKas5fqqVl0D
	OMtxfNkM+XfKVaSeT+mrUxjjNtMrfSrzvNvUaL0TuIhy2sO6l8OwwcR+LAt6SwywwbLxtL9ewACEx
	uBLMVJ3hO0GN0KjqBmNMJYXQcHAf2j39ql2S9LHSNM+DRKd1SLPHiQbXabKxZGdLoqIjqUn0YTvMn
	BySYDpMd0Wl43aynAvcRrRb6x4Rz7tskCiTSaueKWv95Ne79I399pH+ZOXra7Hi7/7U83/uekccK3
	szsgYAQA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ropnb-0000000H9QS-2aiZ;
	Mon, 25 Mar 2024 19:15:59 +0000
Date: Mon, 25 Mar 2024 19:15:59 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	gost.dev@samsung.com, chandan.babu@oracle.com, hare@suse.de,
	mcgrof@kernel.org, djwong@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, david@fromorbit.com,
	akpm@linux-foundation.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v3 10/11] xfs: make the calculation generic in
 xfs_sb_validate_fsb_count()
Message-ID: <ZgHNb3Led05RXRd2@casper.infradead.org>
References: <20240313170253.2324812-1-kernel@pankajraghav.com>
 <20240313170253.2324812-11-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313170253.2324812-11-kernel@pankajraghav.com>

On Wed, Mar 13, 2024 at 06:02:52PM +0100, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> Instead of assuming that PAGE_SHIFT is always higher than the blocklog,
> make the calculation generic so that page cache count can be calculated
> correctly for LBS.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  fs/xfs/xfs_mount.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
> index aabb25dc3efa..9cf800586da7 100644
> --- a/fs/xfs/xfs_mount.c
> +++ b/fs/xfs/xfs_mount.c
> @@ -133,9 +133,16 @@ xfs_sb_validate_fsb_count(
>  {
>  	ASSERT(PAGE_SHIFT >= sbp->sb_blocklog);

but ... you're still asserting that PAGE_SHIFT is larger than blocklog.
Shouldn't you delete that assertion?

>  	ASSERT(sbp->sb_blocklog >= BBSHIFT);
> +	uint64_t max_index;
> +	uint64_t max_bytes;
> +
> +	if (check_shl_overflow(nblocks, sbp->sb_blocklog, &max_bytes))
> +		return -EFBIG;
>  
>  	/* Limited by ULONG_MAX of page cache index */
> -	if (nblocks >> (PAGE_SHIFT - sbp->sb_blocklog) > ULONG_MAX)
> +	max_index = max_bytes >> PAGE_SHIFT;
> +
> +	if (max_index > ULONG_MAX)
>  		return -EFBIG;

This kind of depends on the implementation details of the page cache.
We have MAX_LFS_FILESIZE to abstract that; maybe that should be used
here?

