Return-Path: <linux-fsdevel+bounces-42441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 335BDA426F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 16:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F03518876E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 15:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F9B19C54F;
	Mon, 24 Feb 2025 15:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TZefOmSR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5212586E8;
	Mon, 24 Feb 2025 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740412170; cv=none; b=dK61VPcFap/cqeVjXHV57hO64vVmG6/A/PHlmMWHlcPNdTYVjKAXzj1zWIoJ9cIe4oHDC8Kbyqcbj1VZDXZESFmgf7zYdbfLqB4Ssy8gd7ofp6XBH/cQbECaMFCCfaDWXuDlRe1zXPnpq8abzB2iyttB79mUxG5XB+NCMJ3+X3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740412170; c=relaxed/simple;
	bh=2F1yKXvZDy9KJ3o7uCp5qsrGeb3CkfF1yTUgtwkYwdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkDYpI3sghRnT8uprY4TMfZudQbUep1wLPM6I6eC0FC1VacEHKIDcAmGvUOwHn/H+pb6DaFytvgKFvceF8vNWqMLZC3itmPXr5Xy0QHYpdsHNoePM6JSqqiXNaFlEoH2RiHs5v4XiPNH6vRkmEt2ogt58HBEU4lD+7THJnCf82A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TZefOmSR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=YErfRUqRg108yTH5RXZzWhvly/jQo5kC4YXPq+9ZtKA=; b=TZefOmSRKXmue8yFnsBIq67Vzj
	Mdjvtl7tQycOyZFeRWtWhHbHO704f8fmdWuxrCyqNBIcvrYWK7dnq3AmArLPc4SneUxIAkUp2Yuxe
	ZpXX7X5dN/OB1OcQZWWb7+OWrrIbIyUOuc9CWSc1YLTMQVDZTnhZikNk5rg4JSJNlYkfAhTrbYNag
	L2H32yLitZPgUyJsPa5Uyf2J6+RPFHNVM4UVhiHGCORUWGTSa0sVcVJ3u96ESVxz9Iwt1VC0+djFe
	yCc3mg3Dww13/GtUIKZblhwwmeKUbTmTk8XYlKejibAd/p72Hkqn1EuWbCgHLZvNKSJwx5WOdzInb
	gl7GIKzw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmahz-00000007gGA-1xkE;
	Mon, 24 Feb 2025 15:49:27 +0000
Date: Mon, 24 Feb 2025 15:49:27 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Raphael S. Carvalho" <raphaelsc@scylladb.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, djwong@kernel.org,
	Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2] mm: Fix error handling in __filemap_get_folio() with
 FGP_NOWAIT
Message-ID: <Z7yVB0w7YoY_DrNz@casper.infradead.org>
References: <20250224081328.18090-1-raphaelsc@scylladb.com>
 <20250224141744.GA1088@lst.de>
 <Z7yRSe-nkfMz4TS2@casper.infradead.org>
 <CAKhLTr1s9t5xThJ10N9Wgd_M0RLTiy5gecvd1W6gok3q1m4Fiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKhLTr1s9t5xThJ10N9Wgd_M0RLTiy5gecvd1W6gok3q1m4Fiw@mail.gmail.com>

On Mon, Feb 24, 2025 at 12:45:21PM -0300, Raphael S. Carvalho wrote:
> On Mon, Feb 24, 2025 at 12:33 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Mon, Feb 24, 2025 at 03:17:44PM +0100, Christoph Hellwig wrote:
> > > On Mon, Feb 24, 2025 at 05:13:28AM -0300, Raphael S. Carvalho wrote:
> > > > +           if (err) {
> > > > +                   /* Prevents -ENOMEM from escaping to user space with FGP_NOWAIT */
> > > > +                   if ((fgp_flags & FGP_NOWAIT) && err == -ENOMEM)
> > > > +                           err = -EAGAIN;
> > > >                     return ERR_PTR(err);
> > >
> > > I don't think the comment is all that useful.  It's also overly long.
> > >
> > > I'd suggest this instead:
> > >
> > >                       /*
> > >                        * When NOWAIT I/O fails to allocate folios this could
> > >                        * be due to a nonblocking memory allocation and not
> > >                        * because the system actually is out of memory.
> > >                        * Return -EAGAIN so that there caller retries in a
> > >                        * blocking fashion instead of propagating -ENOMEM
> > >                        * to the application.
> > >                        */
> >
> > I don't think it needs a comment at all, but the memory allocation
> > might be for something other than folios, so your suggested comment
> > is misleading.
> 
> Isn't it all in the context of allocating or adding folio? The reason
> behind a comment is to prevent movements in the future that could
> cause a similar regression, and also to inform the poor reader that
> might be left wondering why we're converting -ENOMEM into -EAGAIN with
> FGP_NOWAIT. Can it be slightly adjusted to make it more correct? Or
> you really think it's better to remove it completely?

I really don't think the comment is needed.  This is a common mistake
when fixing a bug.

