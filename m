Return-Path: <linux-fsdevel+bounces-35327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2309D3DA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 15:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B27D8B2CED1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 14:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C3C1AC420;
	Wed, 20 Nov 2024 14:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gfr38Ewz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3157B158D8B
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2024 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732113211; cv=none; b=g80JfAAbZXOwuiNEQWxdmTOSTIvplUj3z9I5oNSOUOkJfb4akqcYRCYbFDWTjehTniePno/HbFB0dOeSiR/jc4ejYBoKTW083JqC0tZC1TEJ8URejx3nMdHlvROTeH+yh7OgkBchHStf4IwSjkFXXpM4WMC8Rjc9lRd6AF/n1nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732113211; c=relaxed/simple;
	bh=4D7jhmIN+rhPQe4uLUz8YUoqo3hTFlKCodiLOzCveak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHC+i0bDKF6hRUYEkzIyfEhcdW9NB130834ULln9YwpNipKdbXl+EKFIhLBFCTAFKli94VyzA4jf/uRtG1ve6PfFslknOuTlGeH4/3tLyOJ9Rlzki/8r2U54TeyjphE8r1cWHfNZe5uWb3kUqGLDU+TyBZ5XDW7zb5AMo+siCN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gfr38Ewz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732113209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zipiPf3dx+Mos8wN1deNRE1lwsmvYnwZAPA79uwRTD4=;
	b=Gfr38EwzAh7KOIUDYFFAPUkLkIdnxVfXMaW/5/ct3QjTHQ7U5o/75LTGagW0LUrhKpWXLb
	v54tXpV4oZ5HPlGXhrs4W9Xu1MSZZaRLk/zGRKUzNtU61j1AfbjjgQfg0kllKHNCrmU9DK
	xAI9pC64lNQUH694tFUokpgWf1yxhXc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-211-diET0LaLNVKX1PbBJNQ_Xw-1; Wed,
 20 Nov 2024 09:33:27 -0500
X-MC-Unique: diET0LaLNVKX1PbBJNQ_Xw-1
X-Mimecast-MFC-AGG-ID: diET0LaLNVKX1PbBJNQ_Xw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9EBF71954B02;
	Wed, 20 Nov 2024 14:33:26 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.120])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D5DE71955F3D;
	Wed, 20 Nov 2024 14:33:25 +0000 (UTC)
Date: Wed, 20 Nov 2024 09:34:58 -0500
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH RFC 2/4] iomap: optional zero range dirty folio processing
Message-ID: <Zz3zkhtuAzz2bXAI@bfoster>
References: <20241119154656.774395-1-bfoster@redhat.com>
 <20241119154656.774395-3-bfoster@redhat.com>
 <Zz2hQ05dZC4D5fEl@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zz2hQ05dZC4D5fEl@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Wed, Nov 20, 2024 at 12:43:47AM -0800, Christoph Hellwig wrote:
> On Tue, Nov 19, 2024 at 10:46:54AM -0500, Brian Foster wrote:
> > +loff_t
> > +iomap_fill_dirty_folios(
> > +	struct inode		*inode,
> > +	struct iomap		*iomap,
> 
> If you pass in the batch directly instead of the iomap this is
> completely generic and could go into filemap.c.  Adding willy
> and linux-mm for these kinds of things also tends to help to
> get good review feedback and often improvements.
> 

That is a good idea, but I'm not sure this will remain generic. One of
the tradeoffs this current patch makes is that for the sub-folio block
size (whether small blocks or large folios), we zero any subrange so
long as the high level folio is dirty.

This causes something like generic/445 to fail on small block sizes
because we explicitly zero a subrange that technically wasn't written
to, but rather some other part of the same folio was, and therefore
SEEK_DATA finds it after when a hole was expected based on the test
workload. I was thinking of improving this by using
ifs_find_dirty_range() here to further filter out unwritten subranges
based on the target range being zeroed, but haven't done that yet.

That said, I suspect that still won't be perfect and some spurious
zeroing may still be possible. Personally, I think it might be fine to
leave as is and just fix up the fstests test to be a little less strict
about SEEK_DATA at block granularity. We have to writeback the folio
anyways and so I'm not sure it makes much practical difference. So if
there's preference to try and keep this generic in favor of that
functional tradeoff, I'm certainly fine with going that route. Thoughts?

(Hmm.. thinking more about it, it may also be possible to fix up via a
post-process on the first/last folios in the batch, so maybe this
doesn't technically have to be an either or choice.)

> > +	loff_t			offset,
> > +	loff_t			length)
> > +{
> > +	struct address_space	*mapping = inode->i_mapping;
> > +	struct folio_batch	fbatch;
> > +	pgoff_t			start, end;
> > +	loff_t			end_pos;
> > +
> > +	folio_batch_init(&fbatch);
> > +	folio_batch_init(&iomap->fbatch);
> > +
> > +	end_pos = offset + length;
> > +	start = offset >> PAGE_SHIFT;
> > +	end = (end_pos - 1) >> PAGE_SHIFT;
> 
> Nit: initializing these at declaration time make the code easier to
> read (at least for me :)).
> 

Ok.

> > +
> > +	while (filemap_get_folios(mapping, &start, end, &fbatch) &&
> > +	       folio_batch_space(&iomap->fbatch)) {
> > +		struct folio *folio;
> > +		while ((folio = folio_batch_next(&fbatch))) {
> > +			if (folio_trylock(folio)) {
> > +				bool clean = !folio_test_dirty(folio) &&
> > +					     !folio_test_writeback(folio);
> > +				folio_unlock(folio);
> > +				if (clean)
> > +					continue;
> 
> What does the lock protect here given that it can become stale as soon
> as we unlock?
> 

I thought the lock was needed to correctly test for dirty and writeback,
because dirty is cleared before writeback is set under folio lock. That
said, I suppose this could also just do the folio_test_locked() thing
that filemap_range_has_writeback() does.

Just note that this is possibly affected by how we decide to handle the
sub-folio case above, as I think we'd also need the lock for looking at
the iomap_folio_state.

> Note that there also is a filemap_get_folios_tag that only looks up
> folios with the right tag (dirty or writeback).  Currently it only
> supports a single tag, which wuld not be helpful here, but this might
> be worth talking to the pagecache and xarray maintainer.
> 

Yeah, that was one of the first things I looked into before writing the
fill helper, but atm it didn't look possible to check for an OR
combination of xarray tags. That might be a nice future improvement if
reasonably possible, or if somebody who knows that code better wants to
cook something up faster than I can, but otherwise I don't really want
to make that a hard requirement.

Brian


