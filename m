Return-Path: <linux-fsdevel+bounces-74283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 03255D38BA9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jan 2026 03:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE9F3302E61E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jan 2026 02:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9799C318EDF;
	Sat, 17 Jan 2026 02:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrxdtxnO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F89921FF26
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Jan 2026 02:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768617003; cv=none; b=V29xf5sNqcyJZcldVO1YqOuxNr4VtAa51FfkeyvizczoJBpNkHh5ID0DXfAEYfnhLlVl0UbBbb5205m8c1UlTlSWScUnPXpmqwRn5FSHEx0p2QY4cDyb5EdNP0nlqvOaNlj54pT9HB6U+5R3AKqDDYgQ/II7PLkG1W8BZsyx7fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768617003; c=relaxed/simple;
	bh=oZKmhf04huA7jcKu9N3+5Z9u14CnAMqUWycooHENAxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kg3ui8J9YetQo8KLCfVab5tgqsA4VgXX5Sqngqiww374qNm0jIH5No8AkJ5UyGy+ZKOrHFBr74mcq0v1d7Fh08aIgNM7cLTw3wEJ+/70P4y2k+n0+EXRxBnecmd3DmRPjKn7ta7mZEKDrP4kuGCJ4B7wpgwZGG9ewMWqlkwe1LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrxdtxnO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12AC3C116C6;
	Sat, 17 Jan 2026 02:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768617003;
	bh=oZKmhf04huA7jcKu9N3+5Z9u14CnAMqUWycooHENAxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QrxdtxnOriLbxFwGtFok7wnoqReHJcAUiz39Lhc1pmFDAc+86UwggpcX14hNM/yhP
	 P5tQRNwcmBufTJPV0n/DvFMOrgfx+iCSEfFG0kFljVkuCFKO0rHSwGwLzmP/hUCIkC
	 L63SrsD6w/Edri8WX34YZbQ8vdM/e8lnZDRV5xFePhQskdqH1Xuc64h3jFpWKhoXZ/
	 0NlaVFKKrIlYWDVo/W3PsKA/BI7/Wa0EpxRRicnZ1ABWE/cem8EAZKUCb3lPK3/nbL
	 707e6ZyxcUy0VL4d2lfk6sIt3kbKcEuztj+8PQwfjvkdqjztBcavIHXX0KPC4F6XOf
	 Opk4IExxObOpg==
Date: Fri, 16 Jan 2026 18:30:02 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, brauner@kernel.org,
	hch@infradead.org, bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] iomap: fix readahead folio refcounting race
Message-ID: <20260117023002.GD15532@frogsfrogsfrogs>
References: <20260116015452.757719-1-joannelkoong@gmail.com>
 <20260116015452.757719-2-joannelkoong@gmail.com>
 <aWmn2FympQXOMst-@casper.infradead.org>
 <CAJnrk1Zs2C-RjigzuhU-5dCqZqV1igAfAWfiv-trnydwBYOHfA@mail.gmail.com>
 <aWqxgAfDHD5mZBO1@casper.infradead.org>
 <CAJnrk1YJFV5aE2U6bK1PpTBp5tfkRzBK5o24AhidYFUfQnQjNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1YJFV5aE2U6bK1PpTBp5tfkRzBK5o24AhidYFUfQnQjNQ@mail.gmail.com>

On Fri, Jan 16, 2026 at 02:02:20PM -0800, Joanne Koong wrote:
> On Fri, Jan 16, 2026 at 1:45 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Fri, Jan 16, 2026 at 10:36:25AM -0800, Joanne Koong wrote:
> > > On Thu, Jan 15, 2026 at 6:52 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > > +                     if (!ifs) {
> > > > > +                             ctx->cur_folio = NULL;
> > > > > +                             if (unlikely(plen != folio_len))
> > > > > +                                 return -EIO;
> > > >
> > > > This should be indented with a tab, not four spaces.  Can it even
> > > > happen?  If we didn't attach an ifs, can we do a short read?
> > >
> > > The short read can happen if the filesystem sets the iomap length to a
> > > size that's less than the folio size. plen is determined by
> > > iomap_length() (which returns the minimum of the iter->len and the
> > > iomap length value the filesystem set).
> >
> > Understood, but if plen is less than folio_size(), don't we allocate
> > an ifs?  So !ifs && plen < folio_size() shouldn't be possible?  Or have
> > I misunderstood this part?
> 
> Maybe I'm misunderstanding this, but I'm pretty sure the ifs is only
> allocated if the inode's block size is less than the folio size, and
> is not based on plen. The logic I'm looking at is the code inside
> ifs_alloc().

Hrmm.  If there's no ifs then blocksize == foliosize, so if
plen < foliosize then that means we're not fully reading in the folio
contents?  That doesn't sound good, especially if the folio can be
mmapped into someone's address space.

--D

> Thanks,
> Joanne
> 

