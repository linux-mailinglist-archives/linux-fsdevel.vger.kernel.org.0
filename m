Return-Path: <linux-fsdevel+bounces-47922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC68AA731E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 15:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E4EF984E56
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 13:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB022550A6;
	Fri,  2 May 2025 13:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wzzqh8a9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11D8254AEE
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 May 2025 13:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746191735; cv=none; b=qkBMmRtnes+s5jYHsGFrTnzIn5RVCDw2xjsG6cWk8s1VPJHQ69IIHPvJB4jjelLjtpqmm1ZIAaEOdcbnmJW45h19YP3bxZTdkWmjT9oyq6dwctLuBjeLDaf9pY95dPhxnHO1vtjGnwbAe3kXX3FtjkbvlBRqUbS5aqDytKhSQQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746191735; c=relaxed/simple;
	bh=jJejY/kf7IDqaZNybWSSFUeVHRlYJ/plDhZW6vp3vyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxvN2qgVf/JOO2xFXCUC3khBkTNvC7Ik+84HhxdU9P2VKpryXhsajy4OCZs44IvfBJJ1Jvbwe4dPiX5bv2yCN5TE4r2vUqxXML4OuFMNj0OQaPRZPl1W7uNUkfTz73xdl/BYWU+/hUJHXQMjC4tcvgK5hYHyKIldHlNU1quVNWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wzzqh8a9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746191732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bl9xS8/zrnkeUjZjg41gkZkBRahrSQQdcDdXOBJn19Y=;
	b=Wzzqh8a9hIEzluYr9e6iNw+kPh74lbuFRd0i4FuN5uQyiWCINDYBUi+F5J4LpnTVqj4Hbt
	3qQ97e2mhmN81SPj45aRGQrSs5OceQeNtEto4woeM3iUE05fy9GfQ5PGCIzrxR0HLHz62s
	SxO7VbRu47BdBuLzgi6dqjWaRSHBONA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-9IurcSpxOBqP51bcApkz4g-1; Fri,
 02 May 2025 09:15:31 -0400
X-MC-Unique: 9IurcSpxOBqP51bcApkz4g-1
X-Mimecast-MFC-AGG-ID: 9IurcSpxOBqP51bcApkz4g_1746191730
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F891195608E;
	Fri,  2 May 2025 13:15:30 +0000 (UTC)
Received: from bfoster (unknown [10.22.64.112])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 871B1195608D;
	Fri,  2 May 2025 13:15:29 +0000 (UTC)
Date: Fri, 2 May 2025 09:18:40 -0400
From: Brian Foster <bfoster@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 6/6] iomap: rework iomap_write_begin() to return folio
 offset and length
Message-ID: <aBTGMGWjnVZ3lP4d@bfoster>
References: <20250430190112.690800-1-bfoster@redhat.com>
 <20250430190112.690800-7-bfoster@redhat.com>
 <20250501222229.GL25675@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501222229.GL25675@frogsfrogsfrogs>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, May 01, 2025 at 03:22:29PM -0700, Darrick J. Wong wrote:
> On Wed, Apr 30, 2025 at 03:01:12PM -0400, Brian Foster wrote:
> > iomap_write_begin() returns a folio based on current pos and
> > remaining length in the iter, and each caller then trims the
> > pos/length to the given folio. Clean this up a bit and let
> > iomap_write_begin() return the trimmed range along with the folio.
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > ---
> >  fs/iomap/buffered-io.c | 26 +++++++++++++++-----------
> >  1 file changed, 15 insertions(+), 11 deletions(-)
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index d3b30ebad9ea..2fde268c39fc 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -793,15 +793,22 @@ static int iomap_write_begin_inline(const struct iomap_iter *iter,
> >  	return iomap_read_inline_data(iter, folio);
> >  }
> >  
> > -static int iomap_write_begin(struct iomap_iter *iter, size_t len,
> > -		struct folio **foliop)
> > +/*
> > + * Grab and prepare a folio for write based on iter state. Returns the folio,
> > + * offset, and length. Callers can optionally pass a max length *plen,
> > + * otherwise init to zero.
> > + */
> > +static int iomap_write_begin(struct iomap_iter *iter, struct folio **foliop,
> > +		size_t *poffset, u64 *plen)
> 
> Hmm, is this offset and length supposed to be bytes within the folio?
> I find it a little odd that plen would be a u64 then, unless we're
> preparing for folios that huge?  Or is that just to avoid integer
> truncation issues?
> 

It was more the latter.. it's an input/output param for callers that use
iomap_length(). That returns a u64, so just trying to keep things
consistent. I suppose we could break the function decl into one param
per line with "in/out" type comments if you think that is useful..?

Brian

> --D
> 
> >  {
> >  	const struct iomap_folio_ops *folio_ops = iter->iomap.folio_ops;
> >  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> >  	loff_t pos = iter->pos;
> > +	u64 len = min_t(u64, SIZE_MAX, iomap_length(iter));
> >  	struct folio *folio;
> >  	int status = 0;
> >  
> > +	len = *plen > 0 ? min_t(u64, len, *plen) : len;
> >  	BUG_ON(pos + len > iter->iomap.offset + iter->iomap.length);
> >  	if (srcmap != &iter->iomap)
> >  		BUG_ON(pos + len > srcmap->offset + srcmap->length);
> > @@ -833,8 +840,7 @@ static int iomap_write_begin(struct iomap_iter *iter, size_t len,
> >  		}
> >  	}
> >  
> > -	if (pos + len > folio_pos(folio) + folio_size(folio))
> > -		len = folio_pos(folio) + folio_size(folio) - pos;
> > +	pos = iomap_trim_folio_range(iter, folio, poffset, &len);
> >  
> >  	if (srcmap->type == IOMAP_INLINE)
> >  		status = iomap_write_begin_inline(iter, folio);
> > @@ -847,6 +853,7 @@ static int iomap_write_begin(struct iomap_iter *iter, size_t len,
> >  		goto out_unlock;
> >  
> >  	*foliop = folio;
> > +	*plen = len;
> >  	return 0;
> >  
> >  out_unlock:
> > @@ -967,7 +974,7 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
> >  			break;
> >  		}
> >  
> > -		status = iomap_write_begin(iter, bytes, &folio);
> > +		status = iomap_write_begin(iter, &folio, &offset, &bytes);
> >  		if (unlikely(status)) {
> >  			iomap_write_failed(iter->inode, iter->pos, bytes);
> >  			break;
> > @@ -975,7 +982,7 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
> >  		if (iter->iomap.flags & IOMAP_F_STALE)
> >  			break;
> >  
> > -		pos = iomap_trim_folio_range(iter, folio, &offset, &bytes);
> > +		pos = iter->pos;
> >  
> >  		if (mapping_writably_mapped(mapping))
> >  			flush_dcache_folio(folio);
> > @@ -1295,14 +1302,12 @@ static int iomap_unshare_iter(struct iomap_iter *iter)
> >  		bool ret;
> >  
> >  		bytes = min_t(u64, SIZE_MAX, bytes);
> > -		status = iomap_write_begin(iter, bytes, &folio);
> > +		status = iomap_write_begin(iter, &folio, &offset, &bytes);
> >  		if (unlikely(status))
> >  			return status;
> >  		if (iomap->flags & IOMAP_F_STALE)
> >  			break;
> >  
> > -		iomap_trim_folio_range(iter, folio, &offset, &bytes);
> > -
> >  		ret = iomap_write_end(iter, bytes, bytes, folio);
> >  		__iomap_put_folio(iter, bytes, folio);
> >  		if (WARN_ON_ONCE(!ret))
> > @@ -1367,7 +1372,7 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
> >  		bool ret;
> >  
> >  		bytes = min_t(u64, SIZE_MAX, bytes);
> > -		status = iomap_write_begin(iter, bytes, &folio);
> > +		status = iomap_write_begin(iter, &folio, &offset, &bytes);
> >  		if (status)
> >  			return status;
> >  		if (iter->iomap.flags & IOMAP_F_STALE)
> > @@ -1376,7 +1381,6 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
> >  		/* warn about zeroing folios beyond eof that won't write back */
> >  		WARN_ON_ONCE(folio_pos(folio) > iter->inode->i_size);
> >  
> > -		iomap_trim_folio_range(iter, folio, &offset, &bytes);
> >  		folio_zero_range(folio, offset, bytes);
> >  		folio_mark_accessed(folio);
> >  
> > -- 
> > 2.49.0
> > 
> > 
> 


