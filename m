Return-Path: <linux-fsdevel+bounces-34919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 788BF9CEF41
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 16:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 318BEB2B5D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 14:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026531D3194;
	Fri, 15 Nov 2024 14:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dl8gbxSr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D1418F2D8
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 14:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731682307; cv=none; b=EU9a7iA/S96bexulko1UN810hvjqI81QHBkB6LW5Pp67e8kXAcrBbORUg8bElx1HGjFgCttIijuY8IqWj20/a/tSnSjx2jsdqmOETVOkvnCAL8p7mzpsKxzslKc5kqJgIiU7jo1r1MOZ2i3aP4KvVS5R6GxCXHnMoMorX/oMSWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731682307; c=relaxed/simple;
	bh=eGfhWwKGrYB6IF8HdkNw3pY75T1xZSDC+spWNnkWZsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=roSLHug/3/+Wp4tjvd6LWupPb0JsZkNri8QeNxXxU8XQ4147ASAGa1ZwUlhbNQvbZXXlgFBL3/fzrWZbv9HX/E/vT0NVY9oWQLK/7XT5isFGm/bx66cVkiVylx//zp9vSdSf18HBTnSB9rAvbgzvZ7YgucMou0/tT7USEfullCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dl8gbxSr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731682304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iy26NCMw5Me2hgy3UM6AwJLMahhCwzvJRkn1Iane3Mo=;
	b=Dl8gbxSrlnzcIdKIvUoB26J2EWLGdX5pkdBTA6tL3AEm5dUMr+NpHeWLpFCzxe7kfTo/mB
	bo/riY1yW4594K6OitnFghniJxzUo8fyk7ziPaQhBmlPR8qPIq65iDlKSTY86jChGEbJaB
	/gph+nKedVJMiLr7Iy4ZytbC3MLAo64=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-9pBooNNMPuebWywnMd9MDg-1; Fri,
 15 Nov 2024 09:51:43 -0500
X-MC-Unique: 9pBooNNMPuebWywnMd9MDg-1
X-Mimecast-MFC-AGG-ID: 9pBooNNMPuebWywnMd9MDg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A6E71944DF4;
	Fri, 15 Nov 2024 14:51:42 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.120])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E5D11195DF81;
	Fri, 15 Nov 2024 14:51:41 +0000 (UTC)
Date: Fri, 15 Nov 2024 09:53:14 -0500
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] iomap: lift zeroed mapping handling into
 iomap_zero_range()
Message-ID: <ZzdgWkt1DRCTWfCv@bfoster>
References: <20241108124246.198489-1-bfoster@redhat.com>
 <20241108124246.198489-3-bfoster@redhat.com>
 <ZzGeQGl9zvQLkRfZ@infradead.org>
 <ZzNfg2E7TyMyo86h@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzNfg2E7TyMyo86h@bfoster>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Nov 12, 2024 at 09:00:35AM -0500, Brian Foster wrote:
> On Sun, Nov 10, 2024 at 10:03:44PM -0800, Christoph Hellwig wrote:
> > On Fri, Nov 08, 2024 at 07:42:44AM -0500, Brian Foster wrote:
> > > In preparation for special handling of subranges, lift the zeroed
> > > mapping logic from the iterator into the caller.
> > 
> > What's that special code?  I don't really see anything added to this
> > in the new code?  In general I would prefer if all code for the
> > iteration would be kept in a single function in preparation for
> > unrolling these loops.  If you want to keep this code separate
> > from the write zeroes logic (which seems like a good idea) please
> > just just move the actual real zeroing out of iomap_zero_iter into
> > a separate helper similar to how we e.g. have multiple different
> > implementations in the dio iterator.
> > 
> 
> There is no special code... the special treatment is to check the dirty
> state of a block unaligned start in isolation to decide whether to skip
> or explicitly zero if dirty. The fallback logic is to check the dirty
> state of the entire range and if needed, flush the mapping to push all
> pending (dirty && unwritten) instances out to the fs so the iomap is up
> to date and we can safely skip iomaps that are inherently zero on disk.
> 
> Hmm.. so I see the multiple iter modes for dio, but it looks like that
> is inherent to the mapping type. That's not quite what I'm doing here,
> so I'm not totally clear on what you're asking for. FWIW, I swizzled
> this code around a few times and failed to ultimately find something I'd
> consider elegant. For example, initial versions would have something
> like another param to iomap_zero_iter() to skip the optimization logic
> (i.e. don't skip zeroed extents for this call), which I think is more in
> the spirit of what you're saying, but I ultimately found it cleaner to
> open code that part. If you had something else in mind, could you share
> some pseudocode or something to show the factoring..?
> 

FWIW, I'm concurrently hacking on what I'd consider a longer term fix
here, based on some of the earlier discussions. The idea is basically
iomap provides a mechanism for the fs to attach a folio_batch of dirty
folios to the iomap, which zero range can then use as the source of
truth for which subranges to zero of an unwritten mapping.

It occurs to me that might lend itself a bit more to what you're looking
for here by avoiding the need for a new instance of the iter loop (I
assume there is some outstanding work that is affected by this?). Given
that this series was kind of a side quest for a band-aid performance fix
in the meantime, and it's not likely 6.13 material anyways, I think I'm
going to put it in a holding pattern and keep it in the back pocket in
favor of trying to move that alternate approach along, at least to where
I can post an RFC for discussion.

If that doesn't work out or there proves some critical need for it in
the meantime, then I'll post v4 for an easy fix. I'll post a v2 of patch
4 separately since that is an independent fix..

Brian

> > > +	while ((ret = iomap_iter(&iter, ops)) > 0) {
> > > +		const struct iomap *s = iomap_iter_srcmap(&iter);
> > > +
> > > +		if (s->type == IOMAP_HOLE || s->type == IOMAP_UNWRITTEN) {
> > > +			loff_t p = iomap_length(&iter);
> > 
> > Also please stick to variable names that are readable and preferably
> > the same as in the surrounding code, e.g. s -> srcmap p -> pos.
> > 
> 
> Sure. I think I did this to avoid long lines, but I can change it.
> Thanks.
> 
> Brian
> 
> 


