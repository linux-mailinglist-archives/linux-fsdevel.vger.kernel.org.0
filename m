Return-Path: <linux-fsdevel+bounces-60207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E59B42AFD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 22:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DECFC207742
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 20:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBC82E1C55;
	Wed,  3 Sep 2025 20:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfpOCAN5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2802C18A;
	Wed,  3 Sep 2025 20:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756931566; cv=none; b=CyNdy/fX4p/ZCmPTo4lD8dfHEeeDgEQ1NMkPgRUDrvbny0r0rtZx6rBlwbV9YGqM6ZXmk/M/kCEIGNyUz9qTC1fPTQqQoIL2iBHCUHUvgexXefV/gz+vjWGbUwUYkKkaq8Tjq6kpxlpJ8mSgEgFwhMJ0y3rCrYBKO4ATAukyIC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756931566; c=relaxed/simple;
	bh=KGcX8D0nqV/ecDm6rZ50XzkEbakVFe47FArvxKyldlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EfzA7/sa2IpB0aUhMatAc+prVbW0UtCV2HoiZjJhAXS6IN50JITKvow4taMH7+QgeEP161dnAaIFbLTKPasuGUNg+jW5PKA3UWOav/2ebqti5UGhDtgnhgVU1IpWBuZiF3Ukw+Swps/QcxnWq8YPUpBoKT84PVlHdNkwa9t1ZOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfpOCAN5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C38C4CEE7;
	Wed,  3 Sep 2025 20:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756931565;
	bh=KGcX8D0nqV/ecDm6rZ50XzkEbakVFe47FArvxKyldlU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gfpOCAN5Cb9bncYoQE+gGCnxwO1IP5INDVV01GJpxlrIiKzBQE1yY8dsUO99Iqo+u
	 +YaCrn6DCz02j8FFwkL+Mc+hxuScxOXdNzg77brcXHFJFUhXT2zS0QvBa1581IRQhB
	 EUhJ94aXzeiblHIm/SuGrkWGHnccpM0yyEXOCPLCxN7BO/sPtYdpg9BSFcxAZp23U5
	 bq2iUQxAkbKvowdF4SSuIi1DZTtqYoSM7xlXfD4R5TvTig/9DsJNHWezbTE6pXT+BJ
	 OzHyzNoD5hoJmcyOD04npz5jvhHuk77uV/y7QM+wk2sk5C77jcQdQ0HZhELVPkq86p
	 TpMli/Hq4uw7Q==
Date: Wed, 3 Sep 2025 13:32:45 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 05/16] iomap: propagate iomap_read_folio() error to
 caller
Message-ID: <20250903203245.GN1587915@frogsfrogsfrogs>
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
 <20250829235627.4053234-6-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829235627.4053234-6-joannelkoong@gmail.com>

On Fri, Aug 29, 2025 at 04:56:16PM -0700, Joanne Koong wrote:
> Propagate any error encountered in iomap_read_folio() back up to its
> caller (otherwise a default -EIO will be passed up by
> filemap_read_folio() to callers). This is standard behavior for how
> other filesystems handle their ->read_folio() errors as well.
> 
> Remove the out of date comment about setting the folio error flag.
> Folio error flags were removed in commit 1f56eedf7ff7 ("iomap:
> Remove calls to set and clear folio error flag").
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

This seems correct to me
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 9db233a4a82c..8dd26c50e5ea 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -495,12 +495,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
>  
>  	iomap_readfolio_complete(&iter, &ctx);
>  
> -	/*
> -	 * Just like mpage_readahead and block_read_full_folio, we always
> -	 * return 0 and just set the folio error flag on errors.  This
> -	 * should be cleaned up throughout the stack eventually.
> -	 */
> -	return 0;
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(iomap_read_folio);
>  
> -- 
> 2.47.3
> 
> 

