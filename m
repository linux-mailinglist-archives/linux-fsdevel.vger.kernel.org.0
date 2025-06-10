Return-Path: <linux-fsdevel+bounces-51093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96171AD2C59
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 05:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59B9316D8C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 03:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF8425D8F5;
	Tue, 10 Jun 2025 03:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nfskXAIH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9617E9;
	Tue, 10 Jun 2025 03:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749527888; cv=none; b=B7VQa+KL/SwEa7A3uiAV7gpccqMibKvmK0T4W3EkJayLnyF6q1ZTCecL2vyi1QPo0+It03N7TGz4wwJdiPJsnJ1gFbvwGViHmkBur98CiDwRWm2uloOl6CISexJwQ3BF7c9e1Fa5XVzhQw+5WoANkR1X1vQkBR4kY9wtbb5S3c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749527888; c=relaxed/simple;
	bh=rNRu8nD7m+4tAW9saYT+umwg1cp+FHFSbna4m3yMOGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HWVVYXn4XpU6kr6lVj5FKpPhrJ1+LRLFElscgrmfc5McN7HoKiL6o+ajue95MSKoL5rHMc5afmC5mVxuBYJjhibeLpuqMsdRvhkWJz9lARbc7N/7mTddS9/EpdV3H6Xs3znjbgp3c4IptScx+oKJMxpHX1cEvETMoA1tCuFnLpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nfskXAIH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JbBI3PjF4hxtc3Ai+BO+SYCJWA6Hb7ndLSiBVuLLJlM=; b=nfskXAIHoe+OP6PQIABoFR++vk
	Umahlx9W/yHy1r26Q05nBV+fU5ZPxM1O5M3PnVWSHuBQxRvhIF2KI5TD7jDV+y7scB/LYuX9yNza1
	Hz/cYYgHNEo06IU8rh8OzgSt3lKWxfIZCrx472x8PpnbwMq49aFUkuOqWnCNlIuMvnh0mLrIS2Xqs
	FQwr00YsCI6Y4DDuCYmcTcAj06ah+qXeCY336nBJY7GrDf51Rr5B7rojr+50oE5359Yd/K/Z/pkrh
	2F2ytvnXA9RYci95Jy/JFFgb+65o939ax7BY47PEibDYWvZps4SEhUEZHFvGtIsC+OJPhjml8tXy+
	FF0Cai1g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOq7i-00000005ibA-0wH9;
	Tue, 10 Jun 2025 03:58:06 +0000
Date: Mon, 9 Jun 2025 20:58:06 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, miklos@szeredi.hu,
	djwong@kernel.org, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Subject: Re: [PATCH v1 4/8] iomap: add writepages support for IOMAP_IN_MEM
 iomaps
Message-ID: <aEetTojb-DbXpllw@infradead.org>
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
 <20250606233803.1421259-5-joannelkoong@gmail.com>
 <aEZx5FKK13v36wRv@infradead.org>
 <CAJnrk1ZuuE9HKa0OWRjrt6qaPvP5R4DTPBA90PV8M3ke+zqNnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1ZuuE9HKa0OWRjrt6qaPvP5R4DTPBA90PV8M3ke+zqNnw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jun 09, 2025 at 04:15:27PM -0700, Joanne Koong wrote:
> ioends are used in fuse for cleaning up state. fuse implements a
> ->submit_ioend() callback in fuse_iomap_submit_ioend() (in patch 7/8).

But do you use struct iomap_ioend at all?  (Sorry, still don't have a
whole tree with the patches applied in front of me).

> > Given that the patch that moved things around already wrapped the
> > error propagation to the bio into a helpr, how does this differ
> > from the main path in the function now?
> >
> 
> If we don't add this special casing for IOMAP_IN_MEM here, then in
> this function it'll hit the "if (!wpc->ioend)" case right in the
> beginning and return error without calling the ->submit_ioend()

So this suggests you don't use struct iomap_ioend at all.  Given that
you add a private field to iomap_writepage_ctx I guess that is where
you chain the fuse requests?

Either way I think we should clean this up one way or another.  If the
non-block iomap writeback code doesn't use ioends we should probably move
the ioend chain into the private field, and hide everything using it (or
even the ioend name) in proper abstraction.  In this case this means
finding another way to check for a non-empty wpc.  One way would be to
check nr_folios as any non-empty wbc must have a number of folios
attached to it, the other would be to move the check into the
->submit_ioend method including the block fallback.  For a proper split
the method should probably be renamed, and we'd probably want to require
every use to provide the submit method, even if the trivial block
users set it to the default one provided.

> > > -             if (!count)
> > > +             /*
> > > +              * If wpc->ops->writeback_folio is set, then it is responsible
> > > +              * for ending the writeback itself.
> > > +              */
> > > +             if (!count && !wpc->ops->writeback_folio)
> > >                       folio_end_writeback(folio);
> >
> > This fails to explain why writeback_folio does the unlocking itself.
> 
> writeback_folio needs to do the unlocking itself because the writeback
> may be done asynchronously (as in the case for fuse). I'll add that as
> a comment in v2.

So how do you end up with a zero count here and still want
the fuse code to unlock?


