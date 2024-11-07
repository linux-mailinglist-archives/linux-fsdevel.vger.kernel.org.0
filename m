Return-Path: <linux-fsdevel+bounces-33905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E957D9C07BD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 14:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA67F28243C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 13:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25ECC212D18;
	Thu,  7 Nov 2024 13:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="juXJ4pPt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D3E2076A5;
	Thu,  7 Nov 2024 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730986738; cv=none; b=TzGeSMnq/3oXfJDWl5LCkrS0QD+0lUanVPfRn82mdqiu+5dJ0N/iQ1/xqdqXV+hDMPRalWICHQOgDQeGr+ZPJvLy32y9se3a8tUnyAIzTXUEPQws5QbfUpFmOTocbfhH8fa2SSRSiJwyHf6YDPDW7l1bctywdEPNz8yCCBZCV5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730986738; c=relaxed/simple;
	bh=vHDvps/nhQ8488k0taybkc8hL6eOd+QGxgTaKd9As+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3w5Bc0M6u7WG4NSdD153G7pTwfok4qc2Wy0sLDngWyelMR/NxiCiGrdsCNaFj2gFvN9OlEAg93fxtT2f5LV8ZnTYN7eQbqtNPfXukhIk0mTVKZuQxY5S8YzYHcSOH+zhv9a/t83TlntW1y2mkQvL+ngIlOVFEwhwdozuwo3kTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=juXJ4pPt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47EFDC4CECC;
	Thu,  7 Nov 2024 13:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730986738;
	bh=vHDvps/nhQ8488k0taybkc8hL6eOd+QGxgTaKd9As+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=juXJ4pPt2PnZFm5le1ouU2RhyRQP7aToB7moKQNrxCqsSNdgzB5pCSh85zyQijc+u
	 m3dbDJY5g5D6JLp+TOXf2yfMKCl964FFlAXl4u2cUVaE7m7EhcYnxn81GWvditUtvn
	 2GLSgAH2Shc5AM/fX6n4CSUUpethrUeQesF3ve3Y3hn3a0OnqCtmfNMRj3PNyM19nt
	 a0f6M69PV7grt0l7hmVxqh6NPzs9Y3Sm/O1Ln75+Rw3A70uSTtTOx4wtLIuKD47kq0
	 rprl1oT0Fd7cXbE9BnxazG04YwTwuMAxOqZnznfXiPpwy8d1bi+DdAWhAJtfKUXjnb
	 /xzOuTFcKP1hA==
Date: Thu, 7 Nov 2024 14:38:49 +0100
From: Carlos Maiolino <cem@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>, 
	Theodore Ts'o <tytso@mit.edu>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	John Garry <john.g.garry@oracle.com>, Catherine Hoang <catherine.hoang@oracle.com>, 
	linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>, 
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-block@vger.kernel.org, Dave Chinner <david@fromorbit.com>, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [ANNOUNCE] work tree for untorn filesystem writes
Message-ID: <g6jwjmlvs7oqnotb4esj52hff7bt5vos4csdhounkgxtw7x5hz@dikdatdyzfcv>
References: <20241105004341.GO21836@frogsfrogsfrogs>
 <fegazz7mxxhrpn456xek54vtpc7p4eec3pv37f2qznpeexyrvn@iubpqvjzl36k>
 <72515c41-4313-4287-97cc-040ec143b3c5@kernel.dk>
 <20241105150812.GA227621@mit.edu>
 <5557bb8e-0ab8-4346-907e-a6cfea1dabf8@kernel.dk>
 <20241105154044.GD2578692@frogsfrogsfrogs>
 <00618fda-985d-4d6b-ada1-2d93a5380492@kernel.dk>
 <20241106-hupen-phosphor-f4e126535131@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106-hupen-phosphor-f4e126535131@brauner>

On Wed, Nov 06, 2024 at 11:40:00AM +0100, Christian Brauner wrote:
> On Tue, Nov 05, 2024 at 08:54:40AM -0700, Jens Axboe wrote:
> > On 11/5/24 8:40 AM, Darrick J. Wong wrote:
> > > On Tue, Nov 05, 2024 at 08:11:52AM -0700, Jens Axboe wrote:
> > >> On 11/5/24 8:08 AM, Theodore Ts'o wrote:
> > >>> On Tue, Nov 05, 2024 at 05:52:05AM -0700, Jens Axboe wrote:
> > >>>>
> > >>>> Why is this so difficult to grasp? It's a pretty common method for
> > >>>> cross subsystem work - it avoids introducing conflicts when later
> > >>>> work goes into each subsystem, and freedom of either side to send a
> > >>>> PR before the other.
> > >>>>
> > >>>> So please don't start committing the patches again, it'll just cause
> > >>>> duplicate (and empty) commits in Linus's tree.
> > >>>
> > >>> Jens, what's going on is that in order to test untorn (aka "atomic"
> > >>> although that's a bit of a misnomer) writes, changes are needed in the
> > >>> block, vfs, and ext4 or xfs git trees.  So we are aware that you had
> > >>> taken the block-related patches into the block tree.  What Darrick has
> > >>> done is to apply the the vfs patches on top of the block commits, and
> > >>> then applied the ext4 and xfs patches on top of that.
> > >>
> > >> And what I'm saying is that is _wrong_. Darrick should be pulling the
> > >> branch that you cut from my email:
> > >>
> > >> for-6.13/block-atomic
> > >>
> > >> rather than re-applying patches. At least if the intent is to send that
> > >> branch to Linus. But even if it's just for testing, pretty silly to have
> > >> branches with duplicate commits out there when the originally applied
> > >> patches can just be pulled in.
> > > 
> > > I *did* start my branch at the end of your block-atomic branch.
> > > 
> > > Notice how the commits I added yesterday have a parent commitid of
> > > 1eadb157947163ca72ba8963b915fdc099ce6cca, which is the head of your
> > > for-6.13/block-atomic branch?
> > 
> > Ah that's my bad, I didn't see a merge commit, so assumed it was just
> > applied on top. Checking now, yeah it does look like it's done right!
> > Would've been nicer on top of current -rc and with a proper merge
> > commit, but that's really more of a style preference. Though -rc1 is
> > pretty early...
> > 
> > > But, it's my fault for not explicitly stating that I did that.  One of
> > > the lessons I apparently keep needing to learn is that senior developers
> > > here don't actually pull and examine the branches I link to in my emails
> > > before hitting Reply All to scold.  You obviously didn't.
> > 
> > I did click the link, in my defense it was on the phone this morning.
> > And this wasn't meant as a scolding, nor do I think my wording really
> > implies any scolding. My frustration was that I had explained this
> > previously, and this seemed like another time to do the exact same. So
> > my apologies if it came off like that, was not the intent.
> 
> Fwiw, I pulled the branch that Darrick provided into vfs.untorn.writes
> and it all looks sane to me.
> 

Sounds good, will you submit a pull-request from it or shall I still submit the
remaining ones to Linus?

Carlos

