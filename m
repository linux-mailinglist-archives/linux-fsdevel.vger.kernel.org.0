Return-Path: <linux-fsdevel+bounces-73453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8D8D1A044
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 16:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2AFF530312C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 15:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403B02773F0;
	Tue, 13 Jan 2026 15:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCQjwVTm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6446E3033FE;
	Tue, 13 Jan 2026 15:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768319337; cv=none; b=Bfovnnut9rWKGTN6T8dtx4ZMEnMczFyLEblvJAiY4uGhmobkNT8wJtfUSY+Ks/U52eZ9QjSgoYRwsRRMsXxs1g8CYZlXKLmwXohxlPBK63nuK0goNC4jtAi/QbXj9ldd2By1fiHVJGf/smuTS+IbA31TNYWLB4Z7MKyUGE0PqBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768319337; c=relaxed/simple;
	bh=ioqawy1jaBtw650mwYkMf22BmHRepy+95f08DFuvNvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=maSokjHdxiGPcFbpqq5TrTPZiBf7eXzWWf0+DwHhBuKZ33TkgDydM+o3sHbWNFoz3rrw59HpEBLLwwFsCc07/Yhh1m6fFT8MrIOA1UOeJ8Ut0r+viVKqJFUEDgZbDb9f8XXjf6z6vp5TE6v8+zph2qyTTG4Tb0PyF5S9EKuJr+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCQjwVTm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A06C116C6;
	Tue, 13 Jan 2026 15:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768319336;
	bh=ioqawy1jaBtw650mwYkMf22BmHRepy+95f08DFuvNvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iCQjwVTm9M+gc5PjZ4MeZAQD1VGblUPkHG6mH6z3VdSOzYRQ3ZjPWXcyszc3w/64m
	 FFrjphgobeaqsObunVLjPkIjTHq5zowMbV5VnwAq2sf9c85FX5Zj3TeDxCP9QhV0Lc
	 /g9lhmbeOnw9eU+g2xGhgMKYqianh+J4Nf+xNP/tqsKrykF5LrAm6bwZ/AU23seB4q
	 IFXk3Jg/f0GfLjE+Ec4i9/RGsqFJonSxZKPsWDcyJVMJwlib+Jdwv40gtmJTBXq2gj
	 xxQEKYSVH8YiR2X39BsfUDumvfGGKi+oFHWGZMHdMteSo80ddCaOP4wEE4s2KTu2lr
	 LtvOkVFyLI9gg==
Date: Tue, 13 Jan 2026 07:48:55 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: brauner@kernel.org, bfoster@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: wait for batched folios to be stable in
 __iomap_get_folio
Message-ID: <20260113154855.GH15583@frogsfrogsfrogs>
References: <20260113153943.3323869-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113153943.3323869-1-hch@lst.de>

On Tue, Jan 13, 2026 at 04:39:17PM +0100, Christoph Hellwig wrote:
> __iomap_get_folio needs to wait for writeback to finish if the file
> requires folios to be stable for writes.  For the regular path this is
> taken care of by __filemap_get_folio, but for the newly added batch
> lookup it has to be done manually.
> 
> This fixes xfs/131 failures when running on PI-capable hardware.
> 
> Fixes: 395ed1ef0012 ("iomap: optional zero range dirty folio processing")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index fd9a2cf95620..6beb876658c0 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -851,6 +851,7 @@ static struct folio *__iomap_get_folio(struct iomap_iter *iter,
>  		}
>  
>  		folio_get(folio);
> +		folio_wait_stable(folio);

Heh, oops.  That's a little too easy to miss. :(

I wonder if we ought to have a filemap_fbatch_next() that would take
care of the relocking, revalidation, and stabilization... but this spot
fix is good as-is.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

>  		return folio;
>  	}
>  
> -- 
> 2.47.3
> 

