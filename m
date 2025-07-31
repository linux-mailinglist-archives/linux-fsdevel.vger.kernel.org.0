Return-Path: <linux-fsdevel+bounces-56438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C70DFB175CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 19:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88ECD3B3CC2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 17:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEAA262FD0;
	Thu, 31 Jul 2025 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVKb1xg4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAAA101EE
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 17:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753984326; cv=none; b=dCaTVlHrVEEN3fQyuCHNYzAS2P3wovLj/RuhuHyJPEcFInYz3Yh02rK5++5t2jc3UyytcLa81YOPG6o5bnGxOdc4nhKnueOMFWHOf449C+d8YizaGwKM7xrM2hemVNEG0ubKosuexh0tpfQs4rxF9xPUaJ/W+Cm1UVEtwuHfpWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753984326; c=relaxed/simple;
	bh=774g9yLukQGQF0WU16B3YfGdoY2y1+C+2fMmSu2mc+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rx0S2yTZ7kt7P9zjVd7tFkVg0/wrj89LTxwRhBSGVIi3V3lHZSVXlGT/Ex7LdsEuhU6pa0zFT8L5ZMmI/8OWH+aaFsbgvrF2eppcQeg8YE6sBL6fXHY08HBpmCZJ3qAnCFSs0yGVIMJYO7SJjAwU4rY7qjbnxZTaEgG5u+uYLxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVKb1xg4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67723C4CEF6;
	Thu, 31 Jul 2025 17:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753984326;
	bh=774g9yLukQGQF0WU16B3YfGdoY2y1+C+2fMmSu2mc+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BVKb1xg4iUbz08Rw7n784nySNLTieIFMwzEoEfXFI7fhgg45p84iuoV9z1lnA8Tdb
	 +rFLD6KWaEVF73HsI70Zw1K/Q/cddS/tiPBmhCiz5aKHmgGhywa/S+Qdg57wbRebVI
	 VoDFbo5KxUzR1jdwkFTigVy/QqzEconC9vqVeUHLWzFjUWhTMP/lhpPhmQj58PXCEI
	 5oO7nH3oT6CMxQkLxlfnvoBHEx8D9SG3t/SmjiqaRpIwgdli0KKZOIV2Vm9G/NpdMH
	 EYHySqXb7y+iboODks2p/kyAYrFqbwOob0Lac+ZozNte7X9VblNoil340HhRqbVtAs
	 TyxU9KKZcMlYQ==
Date: Thu, 31 Jul 2025 10:52:05 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Joanne Koong <joannelkoong@gmail.com>,
	linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
	miklos@szeredi.hu, bernd@bsbernd.com
Subject: Re: [PATCH 2/7] fuse: flush pending fuse events before aborting the
 connection
Message-ID: <20250731175205.GL2672070@frogsfrogsfrogs>
References: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
 <175279449501.710975.16858401145201411486.stgit@frogsfrogsfrogs>
 <CAJnrk1YeJPdtHMDatQvg8mDPYx4fgkeUCrBgBR=8zFMpOn3q0A@mail.gmail.com>
 <20250719003215.GG2672029@frogsfrogsfrogs>
 <5ba49b0ff30f4e4f44440d393359a06a2515ab20.camel@kernel.org>
 <fda653661ea160cc65bd217c450c5291a7d3f3b1.camel@kernel.org>
 <20250723153742.GH2672029@frogsfrogsfrogs>
 <96df21fad772cfe2dbe736a22aaf18384c6a5205.camel@kernel.org>
 <20250731-dackel-auskommen-c066d3eb985a@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731-dackel-auskommen-c066d3eb985a@brauner>

On Thu, Jul 31, 2025 at 11:45:37AM +0200, Christian Brauner wrote:
> > > (That said, my opinion is that after years of all of us telling
> > > programmers that fsync is the golden standard for checking if bad stuff
> > > happened, we really ought only be clearing error state during fsync.)
> > > 
> > 
> > That is pretty doable. The only question is whether it's something we
> > *want* to do. Something like this would probably be enough if so:
> > 
> > diff --git a/fs/open.c b/fs/open.c
> > index 7828234a7caa..a20657a85ee1 100644
> > --- a/fs/open.c
> > +++ b/fs/open.c
> > @@ -1582,6 +1582,10 @@ SYSCALL_DEFINE1(close, unsigned int, fd)
> >  
> >         retval = filp_flush(file, current->files);
> >  
> > +       /* Do an opportunistic writeback error check before returning. */
> > +       if (likely(retval == 0))
> > +               retval = filemap_check_wb_err(file_inode(file)->i_mapping, file->f_wb_err);
> 
> I think that's a bad idea. 90% of the code will not check close for
> any errors so they'll never see any of this anyway. 1% will be the very
> interested users that may care about. 9% will be tests that suddenly
> start failing because they assert on close(fd) I'm pretty sure.
> 
> So I don't think this provides a lot of value. At least I can't see it yet.

Yeah, I think changed my mind to thinking it's sensible to say that if
@fd was removed from the file descriptor table then close() returns 0 no
matter what else happened to the file.

--D

