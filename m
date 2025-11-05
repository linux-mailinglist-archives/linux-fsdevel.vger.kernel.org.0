Return-Path: <linux-fsdevel+bounces-67213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1D6C38190
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 22:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB4553A745F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 21:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B4C2E11A6;
	Wed,  5 Nov 2025 21:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NN+ReGI3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A086219319;
	Wed,  5 Nov 2025 21:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762379049; cv=none; b=S7x7TpF1DdMVI8/LuT9BtkWnuw0RyxI1VqEhXZCI61pRq0yI7Dx1z5YuHbY4M4lLCuxsi51cdf+3ZlAkc9XNOJh5xHGxu/Lgd9CtPwbLWICKkPX/kEWJJoOZglvKbAPlVw0nTdGwYBvzmn+4o97sPHQPPgDaqz2VqkdXe86payY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762379049; c=relaxed/simple;
	bh=eQieCjh8t22+XloRu2p1/oK9/d2dh8UCLxdwY7O5YgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7giOvC9Y/rWtxtaC6jmY/QWZMj2pIseO+ZTyce7HsyAt+wQgsfpRqquaKJ6r8X28DynM6HEjjS23b/XObVtMb0/P0mu8zAlLhLCGQv6V8OCmNw09yVDjHvo74HfBWIJ1H0h8PTybWn/uUAJlK+cgUl0YWMtp8vS2/uE8GdXj/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NN+ReGI3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8327DC116B1;
	Wed,  5 Nov 2025 21:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762379048;
	bh=eQieCjh8t22+XloRu2p1/oK9/d2dh8UCLxdwY7O5YgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NN+ReGI3gpraSXnSf9lVg5nwyvG4oRQ39walsEJTQd9pVPfP6fGocvEMfknhX8hPA
	 ZXD7QYyN43RNKTpycwtS2ngEK/jtrVWmSW30MYGieb3NOIx0kM5hIKXJYg85qYz3QH
	 QRqyRKnROxw/gP52wmI60NUhYS4pIg8Zmpvd0U1X1XcxH46VT81lVV8s8QTvhEbYOZ
	 +0+s1Blo+3tXUaw+iJfA/bxNniTMTjB688aoERkcYTML/USx7TSbhHg6HlIyJeB30e
	 3XLNBP1bqLlAzdX51LJXju/14Rk9Jf1hHwy9CsboAXT05D6YbS7HM38QaZOvaQOpQo
	 vU+i2AAymF7rw==
Date: Wed, 5 Nov 2025 13:44:07 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.cz>, Keith Busch <kbusch@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: fall back from direct to buffered I/O when stable writes are
 required
Message-ID: <20251105214407.GN196362@frogsfrogsfrogs>
References: <aQNJ4iQ8vOiBQEW2@dread.disaster.area>
 <20251030143324.GA31550@lst.de>
 <aQPyVtkvTg4W1nyz@dread.disaster.area>
 <20251031130050.GA15719@lst.de>
 <aQTcb-0VtWLx6ghD@kbusch-mbp>
 <20251031164701.GA27481@lst.de>
 <kpk2od2fuqofdoneqse2l3gvn7wbqx3y4vckmnvl6gc2jcaw4m@hsxqmxshckpj>
 <20251103122111.GA17600@lst.de>
 <20251104233824.GO196370@frogsfrogsfrogs>
 <20251105141130.GB22325@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105141130.GB22325@lst.de>

On Wed, Nov 05, 2025 at 03:11:30PM +0100, Christoph Hellwig wrote:
> On Tue, Nov 04, 2025 at 03:38:24PM -0800, Darrick J. Wong wrote:
> > IIRC, a PI disk is supposed to check the supplied CRC against the
> > supplied data, and fail the write if there's a discrepancy, right?
> 
> Yes.
> 
> > In
> > that case, an application can't actually corrupt its own data because
> > hardware will catch it.
> 
> Yes.
> 
> > A. We can allow mutant directio to non-PI devices because buggy programs
> >    can only screw themselves over.  Not great but we've allowed this
> >    forever.
> >
> > B. We can also allow it to PI devices because those buggy programs will
> >    get hit with EIOs immediately.
> 
> Well, those "buggy programs" include qemu and probably others.  Which
> immediately limits the usefulness of operating with PI.
> 
> This also does not help with non-PI checksums - one thing my RFC series
> did is to allow storing checksums in non-PI metadata, which is useful
> for devices that are too cheap for PI, but still provide metadata.  These
> do exist, although are not very wide spread, and this will require an
> on-disk flag in XFS, so it's not right there.  But compared to all the
> others methods to provide checksums, block metdata is by far the best,
> so I'll keep it on the agenda in the hope that such devices become
> more prelevant.
> 
> > I wonder if that means we really need a way to convey the potential
> > damage of a mutant write through the block layer / address space so that
> > the filesystem can do the right thing?  IOWs, instead of a single
> > stable-pages flag, something along the lines of:
> 
> Maybe, I actually suggested this earlier.  But breaking the biggest user
> of direct I/O (qemu) by default once we have checksums still feels like a
> losing proposition.

Just out of curiosity -- is qemu itself mutating the buffers that it is
passing down to the lower levels via dio?  Or is it a program in the
guest that's mutating buffers that are submitted for dio, which then get
zerocopied all the way down to the hypervisor?

(But yeah, I'm coming back around to the notion that the dio ->
dontcache transition is needed for all of the PI/raid cases...)

--D

