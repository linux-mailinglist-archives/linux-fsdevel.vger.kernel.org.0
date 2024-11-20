Return-Path: <linux-fsdevel+bounces-35326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 415219D3DCB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 15:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91F5CB24A3F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 14:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8BF1AA1FB;
	Wed, 20 Nov 2024 14:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GiaZJOiJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508AD2746D
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2024 14:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732112891; cv=none; b=unhTkReMUpBpvuBE889yDXbzSiGIlxXeeCodlz7KGBizc8S0T+8/87MiUgbMBVdV7rUIow0b3ldR340Wzi3mfRT3IugRJEzt5BENQTbWTtI0xvQflB3SJU7++U68UGPU34BukNOFH7fuWWj9MwUdM2FFl7NsB1vi9yG/cvY5NME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732112891; c=relaxed/simple;
	bh=VcfT+TOEehb0BHrfRCO4ylVJVaRSqpSV7NZiJJXUZBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkodf3zbOs0F9Am0UFvPmUoGjal3Ka+GWUCjS4enM86ZiX4t71ybrgqJXqFxd9eK/gGKwh20XKOz9dBMbokD5+L5qQX6EDXi2ez12bu6zAbJ+nKA4rvbQJrb8XtJPoxMeCBRoSuFahdhn7W6aiQmBH6FN9sL1KIzIZpRIvOSTt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GiaZJOiJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732112889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fOqVT7qgxsLioMds4Vj1na0BAUHhzs1xNTntAsj3qsQ=;
	b=GiaZJOiJjzZzgv1BMtRj4JZrGxK2yougMnVqgaKYijK/2bfM79/hQkkOXzPN4h6Bw1AOVb
	6uprpcT+x7+vRTUPOZtvY4148wLE5TZTNx7zkLK7YWVONPEuXMoSHBdBXtnvfxbyCYkCgw
	bUMdDL0ccP1y0lZODFGpxM2O3G6LoPM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-503-jcY-4ndsPW2-UX94IAH32w-1; Wed,
 20 Nov 2024 09:28:08 -0500
X-MC-Unique: jcY-4ndsPW2-UX94IAH32w-1
X-Mimecast-MFC-AGG-ID: jcY-4ndsPW2-UX94IAH32w
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD4CC1955F56;
	Wed, 20 Nov 2024 14:28:06 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.120])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A9D21956086;
	Wed, 20 Nov 2024 14:28:05 +0000 (UTC)
Date: Wed, 20 Nov 2024 09:29:38 -0500
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH RFC 1/4] iomap: allow passing a folio into write begin
 path
Message-ID: <Zz3yUlYfrqAKiwbV@bfoster>
References: <20241119154656.774395-1-bfoster@redhat.com>
 <20241119154656.774395-2-bfoster@redhat.com>
 <Zz2gEfgY8G7oTpdV@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zz2gEfgY8G7oTpdV@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Wed, Nov 20, 2024 at 12:38:41AM -0800, Christoph Hellwig wrote:
> On Tue, Nov 19, 2024 at 10:46:53AM -0500, Brian Foster wrote:
> > To facilitate batch processing of dirty folios for zero range, tweak
> > the write begin path to allow the caller to optionally pass in its
> > own folio/pos combination.
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > ---
> >  fs/iomap/buffered-io.c | 20 +++++++++++++-------
> >  1 file changed, 13 insertions(+), 7 deletions(-)
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index ce73d2a48c1e..d1a86aea1a7a 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -781,7 +781,7 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
> >  {
> >  	const struct iomap_folio_ops *folio_ops = iter->iomap.folio_ops;
> >  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> > -	struct folio *folio;
> > +	struct folio *folio = *foliop;
> >  	int status = 0;
> >  
> >  	BUG_ON(pos + len > iter->iomap.offset + iter->iomap.length);
> > @@ -794,9 +794,15 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
> >  	if (!mapping_large_folio_support(iter->inode->i_mapping))
> >  		len = min_t(size_t, len, PAGE_SIZE - offset_in_page(pos));
> >  
> > -	folio = __iomap_get_folio(iter, pos, len);
> > -	if (IS_ERR(folio))
> > -		return PTR_ERR(folio);
> > +	/*
> > +	 * XXX: Might want to plumb batch handling down through here. For now
> > +	 * let the caller do it.
> 
> Yeah, plumbing in the batch here would be nicer.
> 

Ok, I'll take a closer look at that. IIRC I punted on it initially
because we'll also have to fix up pos/len down in this path when the
next folio is not contiguous. This was easier to just get the basics
working.

Brian

> I suspect doing batch processing might actually be a neat thing for
> the normal write patch as well.
> 


