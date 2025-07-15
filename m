Return-Path: <linux-fsdevel+bounces-54911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B1AB050D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 07:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D63416B8E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 05:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DA02D3751;
	Tue, 15 Jul 2025 05:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5VIZ9u+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB7023C8A1;
	Tue, 15 Jul 2025 05:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752556812; cv=none; b=pzlGsj6Nmch2bR6lA7aCEeVO0oCQmMXld285oawaZegdyuA2u9rdQUQ8EdiVhHKKGwerZ38cXJFcLHPImzeQanBu+ydfCEU4A5CFG7UqA44JLk2yW6UXistxHD52LUfCd8EsiF7N1xGUJStYLcPbAcuEFaDkrjy6r2fvZlk7X1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752556812; c=relaxed/simple;
	bh=EUM3Bv+Y3HYOMRHJNG6hn45eJHccsRF1nJ4qkDSEuuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKYQiFciXE13z6RF9OGips2AtBnhKIMn3DpjXTNrO8+PluZ4xQ5W2kQ6spqmxPklglfdZWzUNBLX6ItT1LmeQ9294GRs7KzqYA3zeGftsEQnYBqQbjUoWjOEp+D60PnMI014N5ebo/qypI3Cuj1Qan10Mb777bHZOs5lCGimI6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5VIZ9u+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A4DC4CEE3;
	Tue, 15 Jul 2025 05:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752556811;
	bh=EUM3Bv+Y3HYOMRHJNG6hn45eJHccsRF1nJ4qkDSEuuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q5VIZ9u+L5P6mMTmOgiRE7K/UyoIGYM9fqi/9MEvDCSfJiAe5zuiZPJY5OluFuO12
	 IH5BlYOjWzaJVxHOEzE2+0ezKVoEh3U4xeg41m8oLa+X+LAdhdOvL6+5PghX+20EdG
	 ThT2IWAyuSyHKY36m+lB93t7tzOCNbMJAbWm1TAuuujOCBKbjJ5nWdDJLvYWcDMq00
	 p1p6R47mzfiMpIQxVnJk6Bf3riDO0o8GMX0bCj1DhcJXNQzkM1hrWVKDqTBChtRBe9
	 CdXjPxonJsk0CHTN09EWQW6QXf/iFLoCd2CSXZAw4pslWEAOW8Pqr7r6wr8vKSmFd0
	 n8NSvaYzD/asA==
Date: Mon, 14 Jul 2025 22:20:11 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, hch@infradead.org, willy@infradead.org
Subject: Re: [PATCH v3 1/7] filemap: add helper to look up dirty folios in a
 range
Message-ID: <20250715052011.GN2672049@frogsfrogsfrogs>
References: <20250714204122.349582-1-bfoster@redhat.com>
 <20250714204122.349582-2-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714204122.349582-2-bfoster@redhat.com>

On Mon, Jul 14, 2025 at 04:41:16PM -0400, Brian Foster wrote:
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
> Reviewed-by: Christoph Hellwig <hch@lst.de>

This seems correct to me, though like hch said, I'd like to hear from
willy.
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  include/linux/pagemap.h |  2 ++
>  mm/filemap.c            | 58 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 60 insertions(+)
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
> index bada249b9fb7..2171b7f689b0 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2334,6 +2334,64 @@ unsigned filemap_get_folios_tag(struct address_space *mapping, pgoff_t *start,
>  }
>  EXPORT_SYMBOL(filemap_get_folios_tag);
>  
> +/**
> + * filemap_get_folios_dirty - Get a batch of dirty folios
> + * @mapping:	The address_space to search
> + * @start:	The starting folio index
> + * @end:	The final folio index (inclusive)
> + * @fbatch:	The batch to fill
> + *
> + * filemap_get_folios_dirty() works exactly like filemap_get_folios(), except
> + * the returned folios are presumed to be dirty or undergoing writeback. Dirty
> + * state is presumed because we don't block on folio lock nor want to miss
> + * folios. Callers that need to can recheck state upon locking the folio.
> + *
> + * This may not return all dirty folios if the batch gets filled up.
> + *
> + * Return: The number of folios found.
> + * Also update @start to be positioned for traversal of the next folio.
> + */
> +unsigned filemap_get_folios_dirty(struct address_space *mapping, pgoff_t *start,
> +			pgoff_t end, struct folio_batch *fbatch)
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
> +	 * We come here when there is no folio beyond @end. We take care to not
> +	 * overflow the index @start as it confuses some of the callers. This
> +	 * breaks the iteration when there is a folio at index -1 but that is
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
> +
>  /*
>   * CD/DVDs are error prone. When a medium error occurs, the driver may fail
>   * a _large_ part of the i/o request. Imagine the worst scenario:
> -- 
> 2.50.0
> 
> 

