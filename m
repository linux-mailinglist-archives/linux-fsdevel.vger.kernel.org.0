Return-Path: <linux-fsdevel+bounces-27303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AA5960125
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 07:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A5EF1C222F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 05:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC4F7E76D;
	Tue, 27 Aug 2024 05:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tlkPpN6g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BDC8C13;
	Tue, 27 Aug 2024 05:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724737465; cv=none; b=YB28eSJIdOsMFl9+HtaJl+ZrRnk4usSLkOAAsGFK8ANaa7PK9mr6CQeKyKT0KdHUIEX7SQo2X7/Of/c1PJm/K8NooULd4iEnrjJlgIyY3j8DOzy4WQvb0SgpelTcF/ksqkNDaCyPC6jQidw0q69yw9UBfreozLvzxvdwdMFc0YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724737465; c=relaxed/simple;
	bh=GBlXGrFCl1FRYT4KQQPvi092iMx/sBc21pvRXwJGyGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5iXu86KHLImgOGAlGV2hlJHYBhn7zTS4VCCs6RUtHtjwcqM6t0SDLk2Tjg52Qomtd6WDUFIWj/kxQ4bjNQqD0fv9v3wNdsNwMcfmDUTH5DtjXwGv85s/3ijb8lV/Kyt6JpQNkWprEuYKoXrB+5jOAeH/oBSIeQv/OsQxn4ujdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tlkPpN6g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50DFEC8B7A0;
	Tue, 27 Aug 2024 05:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724737465;
	bh=GBlXGrFCl1FRYT4KQQPvi092iMx/sBc21pvRXwJGyGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tlkPpN6gnguIZa6voj7rF/zR0mddZSSCeGKJAUUoNX82xE43iqscjxCpFOY8mF7iw
	 avg+aOouy+x7zwvDEA9heji5mQZpkftYlnQJ7qchYEBMDfEGNAXw84SF3Tib+qLnmW
	 dYqnfLoyE+/1xRwZ3Oz0/FQ8/TGKnLaF5XUy1dcoB+t6t7VX07ijHUDe11GVV0y8O6
	 czE+CAjAd/tUMmlJfM6u26oMLtrpq5IxKPdxMZYMk3KNnKTs5Tes0ewOvjOH7f+/LL
	 nk4VK8uAY4j+1UsKr1Tgn9PCXipd6cS+HskrfIei6cgkbhHCAqjLQu6qbrI1EfkCRF
	 mrB5jCVfHmNuQ==
Date: Mon, 26 Aug 2024 22:44:24 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/10] iomap: improve shared block detection in
 iomap_unshare_iter
Message-ID: <20240827054424.GM6043@frogsfrogsfrogs>
References: <20240827051028.1751933-1-hch@lst.de>
 <20240827051028.1751933-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827051028.1751933-3-hch@lst.de>

On Tue, Aug 27, 2024 at 07:09:49AM +0200, Christoph Hellwig wrote:
> Currently iomap_unshare_iter relies on the IOMAP_F_SHARED flag to detect
> blocks to unshare.  This is reasonable, but IOMAP_F_SHARED is also useful
> for the file system to do internal book keeping for out of place writes.
> XFS used to that, until it got removed in commit 72a048c1056a
> ("xfs: only set IOMAP_F_SHARED when providing a srcmap to a write")
> because unshare for incorrectly unshare such blocks.
> 
> Add an extra safeguard by checking the explicitly provided srcmap instead
> of the fallback to the iomap for valid data, as that catches the case
> where we'd just copy from the same place we'd write to easily, allowing
> to reinstate setting IOMAP_F_SHARED for all XFS writes that go to the
> COW fork.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 69a931de1979b9..737a005082e035 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1337,16 +1337,25 @@ EXPORT_SYMBOL_GPL(iomap_file_buffered_write_punch_delalloc);
>  static loff_t iomap_unshare_iter(struct iomap_iter *iter)
>  {
>  	struct iomap *iomap = &iter->iomap;
> -	const struct iomap *srcmap = iomap_iter_srcmap(iter);
>  	loff_t pos = iter->pos;
>  	loff_t length = iomap_length(iter);
>  	loff_t written = 0;
>  
> -	/* don't bother with blocks that are not shared to start with */
> +	/* Don't bother with blocks that are not shared to start with. */
>  	if (!(iomap->flags & IOMAP_F_SHARED))
>  		return length;
> -	/* don't bother with holes or unwritten extents */
> -	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN)
> +
> +	/*
> +	 * Don't bother with holes or unwritten extents.
> +	 *
> +	 * Note that we use srcmap directly instead of iomap_iter_srcmap as
> +	 * unsharing requires providing a separate source map, and the presence
> +	 * of one is a good indicator that unsharing is needed, unlike
> +	 * IOMAP_F_SHARED which can be set for any data that goes into the COW

Maybe we should rename it then?

IOMAP_F_OUT_OF_PLACE_WRITE.

Yuck.

IOMAP_F_ELSEWHERE

Not much better.  Maybe just add a comment that "IOMAP_F_SHARED" really
just means an out of place write (aka srcmap is not just a hole).

--D

> +	 * fork for XFS.
> +	 */
> +	if (iter->srcmap.type == IOMAP_HOLE ||
> +	    iter->srcmap.type == IOMAP_UNWRITTEN)
>  		return length;
>  
>  	do {
> -- 
> 2.43.0
> 
> 

