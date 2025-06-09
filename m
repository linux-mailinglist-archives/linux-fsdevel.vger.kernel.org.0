Return-Path: <linux-fsdevel+bounces-51043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0858DAD22E1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 17:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0DBC168F1F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 15:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D32215043;
	Mon,  9 Jun 2025 15:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJtQSXRk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFBE1F4CB7;
	Mon,  9 Jun 2025 15:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749484083; cv=none; b=dAIBfC6Uon+sGBJ+tjnKmz5US1ybfttjEYbbfvqCSwoZLJL5xIPmxyaZWCaRCQMv3rWYUdv2RoD4Q/Ol+6F1guFRCZ3/YxXVx7IAWlZLZbRzV2r7T4N9rtyVSIENCN1xwPyDssSk9ykKWDarAiMf4cs6bp+40dLcXfZ52BElGaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749484083; c=relaxed/simple;
	bh=lif/CBsWAXaIRHNW7WKES1+sUcI6rXNxbmHDIuO+9Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxOJwmmMwojpOlOO/slf0ACQbNgzEH2GO9VSn+g63aD+z2Xg4F0gDGNhwAcrI7955iM5vtGw/y6Ni9pjmLPf7P/xogs06HcS6VDcakYkbRXyX9Zfy+Nup24xhWVYmRrMU5g+mrzFyipl431L0t01HaajAeM2T+ivBneH9/hlolI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJtQSXRk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4046EC4CEEB;
	Mon,  9 Jun 2025 15:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749484083;
	bh=lif/CBsWAXaIRHNW7WKES1+sUcI6rXNxbmHDIuO+9Sc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aJtQSXRkyw2TIn63fFDQJyQQ+0U7YVwHzFuvN2StSQz0lmO110FkF5+pQwAQnoHpd
	 o8G0iebZJDejJ7muW/UBhrbtUDxAz7KpsmoqOEe/XFhH4tcTGF5zfD7wWbakobFQF9
	 3CM2qxzAR+PR25WfNFpaAZ4dSLEns4Dsehbxi/oV1mqxrZqEmcYp+LqqnBNyBaMSpi
	 WGXYmcgS/mUpcKbhIh277dzWD7EpGLeeBS8lQFlW/2MjSqdr51LnKYt0iFeEAg4Bd5
	 X7V9QHeSC1cEsttBufwmFGn/zUN/Sbrolq/b14mE0MzrtY4zYoBWrlfLKZk4DOvrw4
	 RPi0f7BN3olWg==
Date: Mon, 9 Jun 2025 08:48:02 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 2/7] filemap: add helper to look up dirty folios in a
 range
Message-ID: <20250609154802.GB6156@frogsfrogsfrogs>
References: <20250605173357.579720-1-bfoster@redhat.com>
 <20250605173357.579720-3-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605173357.579720-3-bfoster@redhat.com>

On Thu, Jun 05, 2025 at 01:33:52PM -0400, Brian Foster wrote:
> Add a new filemap_get_folios_dirty() helper to look up existing dirty
> folios in a range and add them to a folio_batch. This is to support
> optimization of certain iomap operations that only care about dirty
> folios in a target range. For example, zero range only zeroes the subset
> of dirty pages over unwritten mappings, seek hole/data may use similar
> logic in the future, etc.
> 
> Note that the helper is intended for use under internal fs locks.
> Therefore it trylocks folios in order to filter out clean folios.
> This loosely follows the logic from filemap_range_has_writeback().
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>

You might want to cc willy directly on this one... 
> ---
>  include/linux/pagemap.h |  2 ++
>  mm/filemap.c            | 42 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index e63fbfbd5b0f..fb83ddf26621 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -941,6 +941,8 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
>  		pgoff_t *start, pgoff_t end, struct folio_batch *fbatch);
>  unsigned filemap_get_folios_tag(struct address_space *mapping, pgoff_t *start,
>  		pgoff_t end, xa_mark_t tag, struct folio_batch *fbatch);
> +unsigned filemap_get_folios_dirty(struct address_space *mapping,
> +		pgoff_t *start, pgoff_t end, struct folio_batch *fbatch);
>  
>  /*
>   * Returns locked page at given index in given cache, creating it if needed.
> diff --git a/mm/filemap.c b/mm/filemap.c
> index bada249b9fb7..d28e984cdfd4 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2334,6 +2334,48 @@ unsigned filemap_get_folios_tag(struct address_space *mapping, pgoff_t *start,
>  }
>  EXPORT_SYMBOL(filemap_get_folios_tag);
>  
> +unsigned filemap_get_folios_dirty(struct address_space *mapping, pgoff_t *start,
> +			pgoff_t end, struct folio_batch *fbatch)

This ought to have a comment explaining what the function does.
It identifies every folio starting at @*start and ending before @end
that is dirty and tries to assign them to @fbatch, right?

The code looks reasonable to me; hopefully there aren't some subtleties
that I'm missing here :P

> +{
> +	XA_STATE(xas, &mapping->i_pages, *start);
> +	struct folio *folio;
> +
> +	rcu_read_lock();
> +	while ((folio = find_get_entry(&xas, end, XA_PRESENT)) != NULL) {
> +		if (xa_is_value(folio))
> +			continue;
> +		if (folio_trylock(folio)) {
> +			bool clean = !folio_test_dirty(folio) &&
> +				     !folio_test_writeback(folio);
> +			folio_unlock(folio);
> +			if (clean) {
> +				folio_put(folio);
> +				continue;
> +			}
> +		}
> +		if (!folio_batch_add(fbatch, folio)) {
> +			unsigned long nr = folio_nr_pages(folio);
> +			*start = folio->index + nr;
> +			goto out;
> +		}
> +	}
> +	/*
> +	 * We come here when there is no page beyond @end. We take care to not

...no folio beyond @end?

--D

> +	 * overflow the index @start as it confuses some of the callers. This
> +	 * breaks the iteration when there is a page at index -1 but that is
> +	 * already broke anyway.
> +	 */
> +	if (end == (pgoff_t)-1)
> +		*start = (pgoff_t)-1;
> +	else
> +		*start = end + 1;
> +out:
> +	rcu_read_unlock();
> +
> +	return folio_batch_count(fbatch);
> +}
> +EXPORT_SYMBOL(filemap_get_folios_dirty);
> +
>  /*
>   * CD/DVDs are error prone. When a medium error occurs, the driver may fail
>   * a _large_ part of the i/o request. Imagine the worst scenario:
> -- 
> 2.49.0
> 
> 

