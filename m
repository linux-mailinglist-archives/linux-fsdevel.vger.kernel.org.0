Return-Path: <linux-fsdevel+bounces-47947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02871AA7A54
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 21:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C1811C01288
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 19:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDF31F30DD;
	Fri,  2 May 2025 19:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UrNhXnKI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2571A3174;
	Fri,  2 May 2025 19:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746214828; cv=none; b=eIsamw+O94vNrGRZn+xZxWgS4B1NkYFi1qehK+nhMzE2an77ofD9uqwaSeCZQZsjYtu84ISrhygJnu2b4RICN1D0B7pThiMhxwd/y9k/ohRqz+rej3pdNsiGpUP5e4VvD1dRRrIcB9xjmpLukDLxWQFNeRLrdDS1WNuGWekhIpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746214828; c=relaxed/simple;
	bh=hyiDyys24oSUE9tSsevokVk04RNtueaz1JO09kD27b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=US0K1IYASjXTkThc8kgzbbGZ2H4wevWi8066KbnzJPtQwD+OVhsWmO9MGGcMkVvth81JkPFt0z4bZ6joFOp2UShQiUsea6iySTWtQLxrImdP1jgpLOEeCjKAPNfcw0Yz3gmHKqGZeNAhGhb4314oE3dYCaoxkAXh0osWZsGZb7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UrNhXnKI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93325C4CEE4;
	Fri,  2 May 2025 19:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746214828;
	bh=hyiDyys24oSUE9tSsevokVk04RNtueaz1JO09kD27b4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UrNhXnKIbkmnJgDRzuGLCOWH6eb3MedWEsKTfZ2OAgSYOdc16JFiMS0nkJM0eRWyo
	 iz0rzoVxOn51lskgOrc75ryGWmXoF4zh/vUJjzdG8EyruKdJ27zCpbWGi9F5edEbCd
	 V60Bo8EN4VpK61p300n84GrIzCHfxin1fVJlnRP2W2tgw0lmwahqBDTNavik9dNx/M
	 eOVCo2Zrji4QMIyRP442WX0fzLL/rCT4cnCj38jaytmIInAtQZ2qlO9fWRmfZABHHU
	 J6HVSIA+VskoXxS75CuXWoG+8QYY7RKpZYKRFIUBrDnYaXPcx+5jmyYzMnvsCPVIbO
	 oRlKnLgu0SnNw==
Date: Fri, 2 May 2025 12:40:28 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 6/6] iomap: rework iomap_write_begin() to return folio
 offset and length
Message-ID: <20250502194028.GQ25675@frogsfrogsfrogs>
References: <20250430190112.690800-1-bfoster@redhat.com>
 <20250430190112.690800-7-bfoster@redhat.com>
 <20250501222229.GL25675@frogsfrogsfrogs>
 <aBTGMGWjnVZ3lP4d@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBTGMGWjnVZ3lP4d@bfoster>

On Fri, May 02, 2025 at 09:18:40AM -0400, Brian Foster wrote:
> On Thu, May 01, 2025 at 03:22:29PM -0700, Darrick J. Wong wrote:
> > On Wed, Apr 30, 2025 at 03:01:12PM -0400, Brian Foster wrote:
> > > iomap_write_begin() returns a folio based on current pos and
> > > remaining length in the iter, and each caller then trims the
> > > pos/length to the given folio. Clean this up a bit and let
> > > iomap_write_begin() return the trimmed range along with the folio.
> > > 
> > > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > > ---
> > >  fs/iomap/buffered-io.c | 26 +++++++++++++++-----------
> > >  1 file changed, 15 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > index d3b30ebad9ea..2fde268c39fc 100644
> > > --- a/fs/iomap/buffered-io.c
> > > +++ b/fs/iomap/buffered-io.c
> > > @@ -793,15 +793,22 @@ static int iomap_write_begin_inline(const struct iomap_iter *iter,
> > >  	return iomap_read_inline_data(iter, folio);
> > >  }
> > >  
> > > -static int iomap_write_begin(struct iomap_iter *iter, size_t len,
> > > -		struct folio **foliop)
> > > +/*
> > > + * Grab and prepare a folio for write based on iter state. Returns the folio,
> > > + * offset, and length. Callers can optionally pass a max length *plen,
> > > + * otherwise init to zero.
> > > + */
> > > +static int iomap_write_begin(struct iomap_iter *iter, struct folio **foliop,
> > > +		size_t *poffset, u64 *plen)
> > 
> > Hmm, is this offset and length supposed to be bytes within the folio?
> > I find it a little odd that plen would be a u64 then, unless we're
> > preparing for folios that huge?  Or is that just to avoid integer
> > truncation issues?
> > 
> 
> It was more the latter.. it's an input/output param for callers that use
> iomap_length(). That returns a u64, so just trying to keep things
> consistent. I suppose we could break the function decl into one param
> per line with "in/out" type comments if you think that is useful..?

willy tells me we actually /are/ trying to keep things clear for some
day supporting folio_size > 2G so I guess the u64/size_t usage here is
ok then. :)

--D

> Brian
> 
> > --D
> > 
> > >  {
> > >  	const struct iomap_folio_ops *folio_ops = iter->iomap.folio_ops;
> > >  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> > >  	loff_t pos = iter->pos;
> > > +	u64 len = min_t(u64, SIZE_MAX, iomap_length(iter));
> > >  	struct folio *folio;
> > >  	int status = 0;
> > >  
> > > +	len = *plen > 0 ? min_t(u64, len, *plen) : len;
> > >  	BUG_ON(pos + len > iter->iomap.offset + iter->iomap.length);
> > >  	if (srcmap != &iter->iomap)
> > >  		BUG_ON(pos + len > srcmap->offset + srcmap->length);
> > > @@ -833,8 +840,7 @@ static int iomap_write_begin(struct iomap_iter *iter, size_t len,
> > >  		}
> > >  	}
> > >  
> > > -	if (pos + len > folio_pos(folio) + folio_size(folio))
> > > -		len = folio_pos(folio) + folio_size(folio) - pos;
> > > +	pos = iomap_trim_folio_range(iter, folio, poffset, &len);
> > >  
> > >  	if (srcmap->type == IOMAP_INLINE)
> > >  		status = iomap_write_begin_inline(iter, folio);
> > > @@ -847,6 +853,7 @@ static int iomap_write_begin(struct iomap_iter *iter, size_t len,
> > >  		goto out_unlock;
> > >  
> > >  	*foliop = folio;
> > > +	*plen = len;
> > >  	return 0;
> > >  
> > >  out_unlock:
> > > @@ -967,7 +974,7 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
> > >  			break;
> > >  		}
> > >  
> > > -		status = iomap_write_begin(iter, bytes, &folio);
> > > +		status = iomap_write_begin(iter, &folio, &offset, &bytes);
> > >  		if (unlikely(status)) {
> > >  			iomap_write_failed(iter->inode, iter->pos, bytes);
> > >  			break;
> > > @@ -975,7 +982,7 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
> > >  		if (iter->iomap.flags & IOMAP_F_STALE)
> > >  			break;
> > >  
> > > -		pos = iomap_trim_folio_range(iter, folio, &offset, &bytes);
> > > +		pos = iter->pos;
> > >  
> > >  		if (mapping_writably_mapped(mapping))
> > >  			flush_dcache_folio(folio);
> > > @@ -1295,14 +1302,12 @@ static int iomap_unshare_iter(struct iomap_iter *iter)
> > >  		bool ret;
> > >  
> > >  		bytes = min_t(u64, SIZE_MAX, bytes);
> > > -		status = iomap_write_begin(iter, bytes, &folio);
> > > +		status = iomap_write_begin(iter, &folio, &offset, &bytes);
> > >  		if (unlikely(status))
> > >  			return status;
> > >  		if (iomap->flags & IOMAP_F_STALE)
> > >  			break;
> > >  
> > > -		iomap_trim_folio_range(iter, folio, &offset, &bytes);
> > > -
> > >  		ret = iomap_write_end(iter, bytes, bytes, folio);
> > >  		__iomap_put_folio(iter, bytes, folio);
> > >  		if (WARN_ON_ONCE(!ret))
> > > @@ -1367,7 +1372,7 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
> > >  		bool ret;
> > >  
> > >  		bytes = min_t(u64, SIZE_MAX, bytes);
> > > -		status = iomap_write_begin(iter, bytes, &folio);
> > > +		status = iomap_write_begin(iter, &folio, &offset, &bytes);
> > >  		if (status)
> > >  			return status;
> > >  		if (iter->iomap.flags & IOMAP_F_STALE)
> > > @@ -1376,7 +1381,6 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
> > >  		/* warn about zeroing folios beyond eof that won't write back */
> > >  		WARN_ON_ONCE(folio_pos(folio) > iter->inode->i_size);
> > >  
> > > -		iomap_trim_folio_range(iter, folio, &offset, &bytes);
> > >  		folio_zero_range(folio, offset, bytes);
> > >  		folio_mark_accessed(folio);
> > >  
> > > -- 
> > > 2.49.0
> > > 
> > > 
> > 
> 
> 

