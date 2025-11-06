Return-Path: <linux-fsdevel+bounces-67391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 49605C3DBB7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 00:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 380274E3B9E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 23:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1138D3502BC;
	Thu,  6 Nov 2025 23:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spik9obX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9CA2DF14D
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 23:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762470544; cv=none; b=JPyqLwFzlnj29nG5vLc5BXVxc/9xlDP6+RQ8e4yFyfytWlPxyVtvGebHtbUl3IeKCl/JyNDvKHytB6dSIg8ADfaP89IKsBy801NtfVnjLr5Y+TEjbZAQVWMem60BX/CxW6cCPkhwOVZ+uWiPMAYnRFfnNoOyfagGhTfCwz8ex1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762470544; c=relaxed/simple;
	bh=4eZ5Y35kimZun5nbyioHfr9g/DtbvRNKmFt/7agf9DA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dy+LyxisHO9TVo5UMo6t+AvC1+rz8gg5yphW54AtO4irTZGk7/Y7A18yuo255bsG7ODJIVweOi7tWupm7LBcqy8oOsxst+S/EpQD8rftqlOdWBvg6tH6nLel7yf76XdlHjV/NpQg2VaujnoO3/BfGz9xKZ0iXR7LAYTBEkqmSSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spik9obX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5BFFC4CEF7;
	Thu,  6 Nov 2025 23:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762470544;
	bh=4eZ5Y35kimZun5nbyioHfr9g/DtbvRNKmFt/7agf9DA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=spik9obX1FlRuajzgxXI9gb19txRMo3nX3apTjZHj2ZEgSGfxnLcF0la3ocsoIgiO
	 m6QaSR0AzK3+DIymU+FZxmCqUza9j3gK9mMPwesPqwtEM9oqx1BCuOWoOkbcH+25He
	 Gc966L9U14tnPEQHvtWnyqzzai1FGw0eWDW/zNH1LqgPINhGFBR4aXYBNuIm4h4sjj
	 9c6QebkjWEwzRukM0DBA7ZdMn9RC38oCyTVOnNRPFVuicFjClbq9mKfl+2vnRjjNRQ
	 QTax38B2shusgUxgNnUufov1VL82N0aSlf9kLJe7VWgH6tzosFf9gAV0pl1pv3bkHL
	 8WCw9JPr7YMoA==
Date: Thu, 6 Nov 2025 15:09:03 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, hch@infradead.org, bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 4/8] iomap: simplify ->read_folio_range() error
 handling for reads
Message-ID: <20251106230903.GT196362@frogsfrogsfrogs>
References: <20251104205119.1600045-1-joannelkoong@gmail.com>
 <20251104205119.1600045-5-joannelkoong@gmail.com>
 <20251105015058.GJ196362@frogsfrogsfrogs>
 <CAJnrk1Zqj0TNpJcrGLhSvTaK48=8iHW-58y3HXH=YgHs_or0tA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1Zqj0TNpJcrGLhSvTaK48=8iHW-58y3HXH=YgHs_or0tA@mail.gmail.com>

On Thu, Nov 06, 2025 at 09:17:02AM -0800, Joanne Koong wrote:
> On Tue, Nov 4, 2025 at 5:50 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Tue, Nov 04, 2025 at 12:51:15PM -0800, Joanne Koong wrote:
> > > Instead of requiring that the caller calls iomap_finish_folio_read()
> > > even if the ->read_folio_range() callback returns an error, account for
> > > this internally in iomap instead, which makes the interface simpler and
> > > makes it match writeback's ->read_folio_range() error handling
> > > expectations.
> > >
> > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > >  .../filesystems/iomap/operations.rst          |  7 +++--
> > >  fs/fuse/file.c                                | 10 ++-----
> > >  fs/iomap/buffered-io.c                        | 27 +++++++++----------
> > >  include/linux/iomap.h                         |  5 ++--
> > >  4 files changed, 20 insertions(+), 29 deletions(-)
> > >
> > > @@ -498,10 +497,10 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
> > >               } else {
> > >                       if (!*bytes_submitted)
> > >                               iomap_read_init(folio);
> > > -                     *bytes_submitted += plen;
> > >                       ret = ctx->ops->read_folio_range(iter, ctx, plen);
> > >                       if (ret)
> > >                               return ret;
> > > +                     *bytes_submitted += plen;
> >
> > Hrmm.  Is this the main change of this patch?  We don't increment
> > bytes_submitted if ->read_folio_range returns an error, which then means
> > that fuse doesn't have to call iomap_finish_folio_read to decrement
> > *bytes_submitted?
> >
> > (and apparently the bio read_folio_range can't fail so no changes are
> > needed there)
> 
> Yes, that is the motivation for the change. And to make the interface
> consistent with how the ->read_folio_iter() callback for writeback
> handles errors.

Cool!  I think I understand this well enough to say
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> 
> Thanks,
> Joanne
> 
> >
> > --D
> 

