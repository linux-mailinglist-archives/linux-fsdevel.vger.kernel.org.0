Return-Path: <linux-fsdevel+bounces-27373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5370D960D7C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 16:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85A831C20490
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 14:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC38919CD04;
	Tue, 27 Aug 2024 14:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XEBBuhlD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA19B1C4638
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 14:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724768542; cv=none; b=Y6yNosnRwKM0mGn4Fj6DSGDx9CF8Rf5CCc+ixUqqF6/ZjiB4VhZjV+L4yg+C83YRWYrmi6JUHL1TAn3auDOKKTbLlOxxDSkm5c1ohlOe+5NVUNH+vdFS6szkUZ3o3df9YnPz6O5Q6BSFxcZYzKz6tQXEJEYMyVcmZvlO2dFV2ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724768542; c=relaxed/simple;
	bh=rMY+Wpa6P9tpuCs/0GZB0yDMZmRLrFpolvUlscalVBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNDgx8Ai9W46Zxj8ZfwA0P0HwhIfHe+TZyop+OS9SY/TTHtZRSIIH5Op2fAvum5hhn4mB9V0bBF5eRzya57KOlZuixvlw3Eh+vJYugsFnjjkus5K9tMhpMIX7lwTjXDkhSkgQycCDHxHKv/JWR3Ax0cmhHtMmAZgZuRYQA9i34c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XEBBuhlD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724768539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=twWn1uZMxlAJCczdUdorkg/5g2Kk3ZQ1joR3dGvJZA4=;
	b=XEBBuhlDMhE/UGcKNpEFx7k0vRZH8/eW4RZ0xZyiQq7aC7ay+F/znAI6Zi+JY+Jb2ZS/U6
	08lkOX//ilDMUihup3mSzWd3iXxAjrq2bgEpMTflvDU//tRb8SBnRxlc6LP4nMEGapFMjS
	ovFVxP1fsZScY/0WmnOmySg2CKnoWMI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-vV8QkMvUMEiTLuzl7CrM7A-1; Tue,
 27 Aug 2024 10:22:14 -0400
X-MC-Unique: vV8QkMvUMEiTLuzl7CrM7A-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E6B1D1955BED;
	Tue, 27 Aug 2024 14:22:11 +0000 (UTC)
Received: from bfoster (unknown [10.22.16.95])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C1FF1955DD6;
	Tue, 27 Aug 2024 14:22:10 +0000 (UTC)
Date: Tue, 27 Aug 2024 10:23:10 -0400
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	djwong@kernel.org, josef@toxicpanda.com, david@fromorbit.com
Subject: Re: [PATCH 2/2] iomap: make zero range flush conditional on
 unwritten mappings
Message-ID: <Zs3hTiXLtuwXkYgU@bfoster>
References: <20240822145910.188974-1-bfoster@redhat.com>
 <20240822145910.188974-3-bfoster@redhat.com>
 <Zs1uHoemE7jHQ2bw@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs1uHoemE7jHQ2bw@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Mon, Aug 26, 2024 at 11:11:42PM -0700, Christoph Hellwig wrote:
> On Thu, Aug 22, 2024 at 10:59:10AM -0400, Brian Foster wrote:
> > Note that we also flush for hole mappings because iomap_zero_range()
> > is used for partial folio zeroing in some cases. For example, if a
> > folio straddles EOF on a sub-page FSB size fs, the post-eof portion
> > is hole-backed and dirtied/written via mapped write, and then i_size
> > increases before writeback can occur (which otherwise zeroes the
> > post-eof portion of the EOF folio), then the folio becomes
> > inconsistent with disk until reclaimed.
> 
> Eww.  I'm not sure iomap_zero_range is the right way to handle this
> even if that's what we have now and it kinda work.
> 

Yeah, I agree with that. That was one of the minor appeals (to me) of the
prototype I posted a while back that customizes iomap_truncate_page() to
do unconditional zeroing instead of being an almost pointless wrapper
for iomap_zero_range(). I don't quite recall if that explicitly handled
the hole case since it was quickly hacked together, but the general idea
is that it could be more purpose built for these partial zeroing cases
than zero range might be.

There are some other caveats with that approach that would still require
some variant of zero range, however, so I'm not immediately clear on
what the ideal high level solution looks like quite yet. I'd like to get
the existing mechanism working correctly, improve the test situation and
go from there.

> > +	/*
> > +	 * We can skip pre-zeroed mappings so long as either the mapping was
> > +	 * clean before we started or we've flushed at least once since.
> > +	 * Otherwise we don't know whether the current mapping had dirty
> > +	 * pagecache, so flush it now, stale the current mapping, and proceed
> > +	 * from there.
> > +	 */
> > +	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN) {
> 
> .. at very least the above needs to be documented here as a big fat
> reminder, though.
> 

Sure, I'll include that explanation in the code comments in v2. Thanks.

Brian

> Otherwise the series looks sensible to me.
> 
> 


