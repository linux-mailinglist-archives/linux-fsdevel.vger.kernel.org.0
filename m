Return-Path: <linux-fsdevel+bounces-60365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D85FB45BB0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 17:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14FAB7B9A9C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 15:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46406313287;
	Fri,  5 Sep 2025 15:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tcc70QhE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7A631326F;
	Fri,  5 Sep 2025 15:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757084585; cv=none; b=hbZH5I8eMNoq1Nv5NBnc7JleSkonNfGSMUrLMAPU7c58sHI6mIGRqe9WpLkcCqFCorBXuVjcHRna1D+XuE5UreqnHPTlqJqeyqQPauqoKL8vr6qGh3zDSJ6LanH31r4DZv9p3RdOeadFOGG9aDBCGopK4QSla0C17DTVstUmd/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757084585; c=relaxed/simple;
	bh=Q6tmO3O0s0yu285/kvDm5ptCmigvCQ9v86PVCcQoubo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAVameC83I92y6kwD2jwMAd4PV1L6K72vLG8GtT/jDxrF7fvFllZwf3CprRhn+xhypOn18GdL+WQrdR+eLPnzsUhCfm1wkh1qSroAeCO4QCr5Kg/r9lYL6A1x8ungSsScrcVBD5y+S7W1rxGrIbby7I5RZxsCuT5eyAI79ootHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tcc70QhE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7B5C4CEF1;
	Fri,  5 Sep 2025 15:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757084585;
	bh=Q6tmO3O0s0yu285/kvDm5ptCmigvCQ9v86PVCcQoubo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tcc70QhEScVWQpGLCylBCNkk9g7PhquhVD6bc3uvr43/zDIRBuQsfTzb9EBG+Aa0E
	 vYpFSAiHxksJzaQmx/QjdDq7QGtnyWi7NO7B6XFV6BC4/jmomhFM11ZMcOynCggbfi
	 c8aTJD7ddHz+NEqoUftv6LWXMZ2zIYFNgxu3DuR8hIEsIyhRQyrFCtmWsYIomcUs+p
	 Bqn778SrW4iGXrSmK6r5tXnj68iJW7XVZ8DIL/VsTBUq+3xncoiWo7zEjiXO4/AbaL
	 MJ2dUWhu6Q8/0fVxaSalcr4LW9Q7wbudrfyadt4I9/ChFINaq2KQYhyS3n/AWAhDNw
	 XZqICuhp8HvjQ==
Date: Fri, 5 Sep 2025 08:03:04 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org,
	miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com, linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 02/16] iomap: rename cur_folio_in_bio to
 folio_unlockedOM
Message-ID: <20250905150304.GD1587915@frogsfrogsfrogs>
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
 <20250829235627.4053234-3-joannelkoong@gmail.com>
 <20250903202637.GL1587915@frogsfrogsfrogs>
 <aLkryaC0K58_wXRy@infradead.org>
 <CAJnrk1bkDSwgZ0s9jToEETtu-nvE4FQdG7iPbbH_w+gW1AA2xQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1bkDSwgZ0s9jToEETtu-nvE4FQdG7iPbbH_w+gW1AA2xQ@mail.gmail.com>

On Thu, Sep 04, 2025 at 03:06:52PM -0700, Joanne Koong wrote:
> On Wed, Sep 3, 2025 at 11:03 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Wed, Sep 03, 2025 at 01:26:37PM -0700, Darrick J. Wong wrote:
> > > On Fri, Aug 29, 2025 at 04:56:13PM -0700, Joanne Koong wrote:
> > > > The purpose of struct iomap_readpage_ctx's cur_folio_in_bio is to track
> > > > if the folio needs to be unlocked or not. Rename this to folio_unlocked
> > > > to make the purpose more clear and so that when iomap read/readahead
> > > > logic is made generic, the name also makes sense for filesystems that
> > > > don't use bios.
> > >
> > > Hrmmm.  The problem is, "cur_folio_in_bio" captures the meaning that the
> > > (locked) folio is attached to the bio, so the bio_io_end function has to
> > > unlock the folio.  The readahead context is basically borrowing the
> > > folio and cannot unlock the folio itelf.
> > >
> > > The name folio_unlocked doesn't capture the change in ownership, it just
> > > fixates on the lock state which (imo) is a side effect of the folio lock
> > > ownership.
> >
> > Agreed.  Not sure what a good name is in a world where the folio can be
> > in something else than the bio.  Maybe just replace bio with ctx or
> > similar? cur_folio_in_ctx?  cur_folio_locked_by_ctx?
> 
> I find the ctx naming to be more confusing, the "ctx" imo is too
> easily confused with the iomap_readfolio_ctx struct.
> 
> What about "cur_folio_owned" or "cur_folio_handled"? Or keeping it as
> "cur_folio_unlocked" and adding a comment to explain the change in
> ownership?

folio_owned_by_ctx?
or maybe just folio_owned?

Leaving a comment would solve most of my confusion, I think.  Something
like this?

	/*
	 * Is the folio owned by this readpage context, or by some
	 * external IO helper?  Either way, the owner of the folio is
	 * responsible for unlocking it when the read completes.
	 */
	bool folio_owned;

--D

> >
> > > > +   bool                    folio_unlocked;
> > >
> > > Maybe this ought to be called cur_folio_borrowed?
> >
> > I don't think 'borrow' makes much sense here.  It's not like we're
> > borrowing it, we transfer the lock context to the bio (or whatever else
> > Joanne is going to use for fuse, I haven't read down to that yet).
> 

