Return-Path: <linux-fsdevel+bounces-38900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2248A098E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 18:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D38363A6C9E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 17:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C6B211A06;
	Fri, 10 Jan 2025 17:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZG73IBx5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D70E1E32CD
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 17:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736531479; cv=none; b=OOqm9f6AkF94zrR4L7i0PVvQdCr9yVz6nF9QpuEhpvBeUZY0nyztBwInHM/oQNbWKtjoPXd+3yW6T4IUPYcbKxO/B+/qUi2DKWD2VoUCcYMgqMTfmVyySVGFDlS23gowLExU8bCOXpixRCFbTVGsHUjjtUI/B/J5qR2pH6GUTn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736531479; c=relaxed/simple;
	bh=DA6OXgu/BuzxifV01FDF+2gYTcC8fij95DNW78iDfsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbTnlqhO1AUBUyGFihEss5+pkwpep6WixOx4HnySgAV8WsH6DH4gosNTQIXz4RFa+kHW8QO5MTBmysdM2AM4KdVuRoAMJwhKWKclPGpSmz99wR3+TuxWBZzkUStNdY+HsjqLB6RlKDwGncX4RYqxR/fRgD0FcOG7stRO7I3pjKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZG73IBx5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736531477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2G9Li3NQ2IyuchxyLdq53IFYQWPeg05G9IsZevdsA1g=;
	b=ZG73IBx5i9atWNIwrVw0BCeSIGnMvEgU3lXYdSgTtHZsvkdNuTaK3D44Z1WkZFSysw2ObH
	FqfyGpIJ+4dw5FvWjuiCM1ktzQI0VmivtPWh2yBRPytBniDDwQjy57QvcxHY8XXaIDJOzL
	zHFz+/dUJMoSXsTVAfGjk2qH0ykDYCk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-281-DuwoW5TtN-yKpoIYISg0bA-1; Fri,
 10 Jan 2025 12:51:13 -0500
X-MC-Unique: DuwoW5TtN-yKpoIYISg0bA-1
X-Mimecast-MFC-AGG-ID: DuwoW5TtN-yKpoIYISg0bA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 071E4195608A;
	Fri, 10 Jan 2025 17:51:13 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.122])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 421651955BE3;
	Fri, 10 Jan 2025 17:51:12 +0000 (UTC)
Date: Fri, 10 Jan 2025 12:53:19 -0500
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH RFCv2 2/4] iomap: optional zero range dirty folio
 processing
Message-ID: <Z4Fejwv9XmNkJEGl@bfoster>
References: <20241213150528.1003662-1-bfoster@redhat.com>
 <20241213150528.1003662-3-bfoster@redhat.com>
 <Z394x1XyN5F0fd4h@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z394x1XyN5F0fd4h@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, Jan 08, 2025 at 11:20:39PM -0800, Christoph Hellwig wrote:
> Just a bit of nitpicking, otherwise this looks sane, although I'd
> want to return to proper review of the squashed prep patches first.
> 

Yeah.. I mainly wanted to send this just to show the use case for the
iter advance changes. I'll look into tweaks for the various
nits/comments.

...
> > +	while (filemap_get_folios(mapping, &start, end, &fbatch) &&
> > +	       folio_batch_space(iter->fbatch)) {
> > +		struct folio *folio;
> > +		while ((folio = folio_batch_next(&fbatch))) {
> > +			if (folio_trylock(folio)) {
> > +				bool clean = !folio_test_dirty(folio) &&
> > +					     !folio_test_writeback(folio);
> > +				folio_unlock(folio);
> > +				if (clean)
> > +					continue;
> > +			}
> > +
> > +			folio_get(folio);
> > +			if (!folio_batch_add(iter->fbatch, folio)) {
> > +				end_pos = folio_pos(folio) + folio_size(folio);
> > +				break;
> > +			}
> > +		}
> > +		folio_batch_release(&fbatch);
> 
> I think I mentioned this last time, but I'd much prefer to do away
> with the locla fbatch used for processing and rewrite this using a
> find_get_entry() loop.  That probably means this helper needs to move
> to filemap.c, which should be easy if we pass in the mapping and outer
> fbatch.
> 

I recall we discussed making this more generic. That is still on my
radar, I just hadn't got to it yet.

I don't recall the find_get_entry() loop suggestion, but that seems
reasonable at a quick glance. I've been away from this for a few weeks
but I think my main concern with this trajectory was if/how to deal with
iomap_folio_state if we wanted fully granular dirty folio && dirty block
processing.

For example, if we have a largish dirty folio backed by an unwritten
extent with maybe a single block that is actually dirty, would we be
alright to just zero the requested portion of the folio as long as some
part of the folio is dirty? Given the historical ad hoc nature of XFS
speculative prealloc zeroing, personally I don't see that as much of an
issue in practice as long as subsequent reads return zeroes, but I could
be missing something.

...
> >  static inline void iomap_iter_reset_iomap(struct iomap_iter *iter)
> >  {
> > +	if (iter->fbatch) {
> > +		folio_batch_release(iter->fbatch);
> > +		kfree(iter->fbatch);
> > +		iter->fbatch = NULL;
> > +	}
> 
> Does it make sense to free the fbatch allocation on every iteration,
> or should we keep the memory allocation around and only free it after
> the last iteration?
> 

In the current implementation the existence of the fbatch is what
controls the folio lookup path, so we'd only want it for unwritten
mappings. That said, this could be done differently with a flag or
something that indicates whether to use the batch. Given that we release
the folios anyways and zero range isn't the most frequent thing, I
figured this keeps things simple for now. I don't really have a strong
preference for either approach, however.

Brian


