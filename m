Return-Path: <linux-fsdevel+bounces-42134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A0AA3CC6B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 23:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6CD11663FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 22:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630E025A2BE;
	Wed, 19 Feb 2025 22:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4rrM7j5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16A522ACDB;
	Wed, 19 Feb 2025 22:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740004511; cv=none; b=qIhozh85UqojL1Xh8RrHFqnn8OwwsLDh+fjDL8YO3A91115rXsapbF/Bz9HMSy3+QMZ4Giw1d7zQ1I4sCDHhQ5ywTUghl4OIW3/TovNALsFqSZrK+WxjCteYMCZteINvaXvxWUKJ1IVIK0ajK5g2ZtuOFhEPVhHOi7mYFTH4AnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740004511; c=relaxed/simple;
	bh=93WQjzqJcTwp9hcQLjAB30hMJIuP6E4L3X3w75gMw6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lE/3VtEA2+GnHRgt7++vVA4Qfg0lP3FIe1zMvR63R00cGxxZRYUC7K6FR/bbXOdmEwbVlSmRqL0dSBzCo/nik8ajuyURiux9WRsx9ZX5+IcY+QEBepW94/G8A4sYJxZX7G/SiUGUvD1gj3nsA55FUaXvPeoQ+a1X7jf9zPVttpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4rrM7j5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4307BC4CED1;
	Wed, 19 Feb 2025 22:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740004511;
	bh=93WQjzqJcTwp9hcQLjAB30hMJIuP6E4L3X3w75gMw6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J4rrM7j5AhWhA0KtqKCBl8/ZbnH0SApXiuUlxthxrAIU82PM+qJBswsh8nIZWes0+
	 KLHAtRi4tva5ORdV1GGJWTbzUtFl84C7fxGAZRcoS+X7Fgs7DoCQ2AFgji8o6IU/tn
	 bwEKSPcupR5YzKLdKK2X7yGGyLh2jrHdPl336XtGM8+zOTyd2NV5hNLW7zns+MRoFC
	 E8qptgv8WpL3KsKDkehFukLZhqSS637AjxKuse8S1J2M63hRICsW/Mm3fRDxVHxQDi
	 RWnBHzFfBLuEWRqEfF4J+Rh2ew6sD9Vg4QWu6kN3kuuE6pfMRToiQbNvfMvQk3WS5f
	 kU6JD4C3JpENQ==
Date: Wed, 19 Feb 2025 14:35:10 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 07/12] dax: advance the iomap_iter on unshare range
Message-ID: <20250219223510.GM21808@frogsfrogsfrogs>
References: <20250219175050.83986-1-bfoster@redhat.com>
 <20250219175050.83986-8-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219175050.83986-8-bfoster@redhat.com>

On Wed, Feb 19, 2025 at 12:50:45PM -0500, Brian Foster wrote:
> Advance the iter and return 0 or an error code for success or
> failure.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>

Looks good,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/dax.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index f4d8c8c10086..c0fbab8c66f7 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1266,11 +1266,11 @@ static s64 dax_unshare_iter(struct iomap_iter *iter)
>  	u64 copy_len = iomap_length(iter);
>  	u32 mod;
>  	int id = 0;
> -	s64 ret = 0;
> +	s64 ret = iomap_length(iter);
>  	void *daddr = NULL, *saddr = NULL;
>  
>  	if (!iomap_want_unshare_iter(iter))
> -		return iomap_length(iter);
> +		return iomap_iter_advance(iter, &ret);
>  
>  	/*
>  	 * Extend the file range to be aligned to fsblock/pagesize, because
> @@ -1307,7 +1307,9 @@ static s64 dax_unshare_iter(struct iomap_iter *iter)
>  
>  out_unlock:
>  	dax_read_unlock(id);
> -	return dax_mem2blk_err(ret);
> +	if (ret < 0)
> +		return dax_mem2blk_err(ret);
> +	return iomap_iter_advance(iter, &ret);
>  }
>  
>  int dax_file_unshare(struct inode *inode, loff_t pos, loff_t len,
> -- 
> 2.48.1
> 
> 

