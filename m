Return-Path: <linux-fsdevel+bounces-40983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF619A29B5D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 21:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C708A3A4EF4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 20:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E632921421F;
	Wed,  5 Feb 2025 20:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KScHd7tZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4835A211A11;
	Wed,  5 Feb 2025 20:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738788253; cv=none; b=DnbkN72nJ8cdEqfkPxX/KZ6zMbK95R/Fd88vD6J+vNwjP7YA1HNYaEHc0dUQIMnbzbMvug5FO/5k/OXgZXtC3nm62ytr/1M99eXc9nPuJAsjZfH+o17PY5GDVtapv/h4E3AJHkm+TKNoYOzVb8qgKbvY+u8LdDB/YjZ3Vs3PTiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738788253; c=relaxed/simple;
	bh=KXN9+2Jo3ujxulKHeR4dQC1jEliw332hWB8LwN67E/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDNG6NbZKKvmQ12UDLGMJmxl/rqi0q0YP/TV3o8QwqzRhq6ajhspxQ1pXu4YHE65W2gcJnQqk67gezjO3nMTwkkyBWU28nM2ZQaaZ8FJ/jZOmBy65uoM5rL9w5+Neq9A0qhsxgb9brDR898pjO9GwznAqsg6EX53xjPL5ZrYZOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KScHd7tZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7DE3C4CED1;
	Wed,  5 Feb 2025 20:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738788252;
	bh=KXN9+2Jo3ujxulKHeR4dQC1jEliw332hWB8LwN67E/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KScHd7tZRahDnJGjp/MYZVGUArPBxzm542TngBUpW74oTM34hadoFElLwmXSnMGeU
	 yMA+4XmApgfIapZHsJjM59WEW3x5rtAcyVxpCn81LnEfcwnUBwqE+i8QIHuH9/eP80
	 XE/KaxNn8wdId7CObc9SIpnNt/aRtssndQrH/LEGYV6MDj0xwL55B6vqu0mhzF/bN6
	 YXWNCeYD62K0rX9Rvs5cLas10DNI/hS6Pn97Lk8htx2EIKwokfhqt+rmUJ7uMAYQmH
	 f4Qpldc0ZnErnt9uPbcAdrfA3KnmeDZvGZ4fbrkymcCEP3Wbg7UiUokHeZXAGP1Dbu
	 adkzQhjzL8nGg==
Date: Wed, 5 Feb 2025 12:44:12 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v5 09/10] iomap: advance the iter directly on unshare
 range
Message-ID: <20250205204412.GB21808@frogsfrogsfrogs>
References: <20250205135821.178256-1-bfoster@redhat.com>
 <20250205135821.178256-10-bfoster@redhat.com>
 <20250205191610.GS21808@frogsfrogsfrogs>
 <Z6PJs8RvbcfNJNcC@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6PJs8RvbcfNJNcC@bfoster>

On Wed, Feb 05, 2025 at 03:27:31PM -0500, Brian Foster wrote:
> On Wed, Feb 05, 2025 at 11:16:10AM -0800, Darrick J. Wong wrote:
> > On Wed, Feb 05, 2025 at 08:58:20AM -0500, Brian Foster wrote:
> > > Modify unshare range to advance the iter directly. Replace the local
> > > pos and length calculations with direct advances and loop based on
> > > iter state instead.
> > > 
> > > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > >  fs/iomap/buffered-io.c | 23 +++++++++++------------
> > >  1 file changed, 11 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > index 678c189faa58..f953bf66beb1 100644
> > > --- a/fs/iomap/buffered-io.c
> > > +++ b/fs/iomap/buffered-io.c
> > > @@ -1267,20 +1267,19 @@ EXPORT_SYMBOL_GPL(iomap_write_delalloc_release);
> > >  static loff_t iomap_unshare_iter(struct iomap_iter *iter)
> > >  {
> > >  	struct iomap *iomap = &iter->iomap;
> > > -	loff_t pos = iter->pos;
> > > -	loff_t length = iomap_length(iter);
> > > -	loff_t written = 0;
> > > +	u64 bytes = iomap_length(iter);
> > > +	int status;
> > >  
> > >  	if (!iomap_want_unshare_iter(iter))
> > > -		return length;
> > > +		return iomap_iter_advance(iter, &bytes);
> > >  
> > >  	do {
> > >  		struct folio *folio;
> > > -		int status;
> > >  		size_t offset;
> > > -		size_t bytes = min_t(u64, SIZE_MAX, length);
> > > +		loff_t pos = iter->pos;
> > 
> > Do we still need the local variable here?
> > 
> 
> Technically no.. Christoph brought up something similar in earlier
> versions re: the pos/len variables (here and in subsequent patches) but
> I'm leaving it like this for now because the folio batch work (which is
> the impetus for this series) further refactors and removes much of this.
> 
> For example, pos gets pushed down into the write begin path so it can
> manage state between the next folio in a provided batch and the current
> position of the iter itself. So this pos code goes away from
> unshare_iter() completely and this patch is just moving things one step
> in that direction.

Ah, ok. :)

--D

> > Otherwise looks right to me, so
> > Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> > 
> 
> Thanks.
> 
> Brian
> 
> > --D
> > 
> > >  		bool ret;
> > >  
> > > +		bytes = min_t(u64, SIZE_MAX, bytes);
> > >  		status = iomap_write_begin(iter, pos, bytes, &folio);
> > >  		if (unlikely(status))
> > >  			return status;
> > > @@ -1298,14 +1297,14 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
> > >  
> > >  		cond_resched();
> > >  
> > > -		pos += bytes;
> > > -		written += bytes;
> > > -		length -= bytes;
> > > -
> > >  		balance_dirty_pages_ratelimited(iter->inode->i_mapping);
> > > -	} while (length > 0);
> > >  
> > > -	return written;
> > > +		status = iomap_iter_advance(iter, &bytes);
> > > +		if (status)
> > > +			break;
> > > +	} while (bytes > 0);
> > > +
> > > +	return status;
> > >  }
> > >  
> > >  int
> > > -- 
> > > 2.48.1
> > > 
> > > 
> > 
> 
> 

