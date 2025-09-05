Return-Path: <linux-fsdevel+bounces-60325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3CCB44B42
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 03:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C5B5176E35
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 01:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823941EB5F8;
	Fri,  5 Sep 2025 01:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ER5f0khu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C65290F
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Sep 2025 01:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757035736; cv=none; b=MTrm8lbSUKn4LjUvA/hhMR9re5n5UVXFWjP43zr8Ah9p1g920KdM5IAhNBO4LVOyNnsfCYqy1yf29tWP41KiHa1KHTwgYLEBKMBhfBziSSGU2NlJ1Dn4zv71LW7VA0FWtTgGjFUUWcJt9zrW2UuO2psn/2xVeJFf9+O//Tx5HZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757035736; c=relaxed/simple;
	bh=JIiLWQwIlxhvXinmcfuehr3kIemYrpCIbmBwroXpH/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCjg7x6rW9H0GqLTn687FVtYZ9YNr7/6532kxNbnnIyfLUW93U9QsjX0uN3fh4yFfubmhOZSAEineBs9/tpdmYT3Xlaw+anaHHII0mhQ+Zs238v+KhjWhRP8GUplYk4ZLR3vIMMcqsdQVkE0rXVp85FJ/PYasJOzj2H6zc85V6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ER5f0khu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CBB6C4CEF5;
	Fri,  5 Sep 2025 01:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757035735;
	bh=JIiLWQwIlxhvXinmcfuehr3kIemYrpCIbmBwroXpH/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ER5f0khu6KNAQrl2HkFyzLILrzWtx3EnjTrUO9nE41ffrfbchvq6rZTUiqnXh0pCO
	 5yJ+w1/mp7Q3rC04cLLxWjudqszpTTafgu2mO63cSGteKrQLDpdhflolLx0oL30giM
	 5WzM3Yaw3hXHyiVVyOyYULPJDn/3UYlRw7Ay6VXC29q1Qdvn7+tBD7K2G5/mo2Wn5m
	 qiZJZi85NLUmxVl4UrBpVCCOcHpen3yDX8pUPqaC/MB8Zs7ewPYYKcl3Xnq+rmoO/i
	 fCrJFekpaktq4gR6+Q8XTE8Fn1Gw+zalfn0yw1HyGs62CfCmkR8wYXoFhLohsDLHZB
	 XDpo1w3+vh+VQ==
Date: Thu, 4 Sep 2025 18:28:54 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
	linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Subject: Re: [PATCH 4/7] fuse: implement file attributes mask for statx
Message-ID: <20250905012854.GA1587915@frogsfrogsfrogs>
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs>
 <175573708630.15537.1057407663556817922.stgit@frogsfrogsfrogs>
 <CAJfpegsp=6A7jMxSpQce6Xx72POGddWqtJFTWauM53u7_125vQ@mail.gmail.com>
 <20250829153938.GA8088@frogsfrogsfrogs>
 <CAJfpegs=2==Tx3kcFHoD-0Y98tm6USdX_NTNpmoCpAJSMZvDtw@mail.gmail.com>
 <20250902205736.GB1587915@frogsfrogsfrogs>
 <CAJfpegskHg7ewo6p0Bn=3Otsm7zXcyRu=0drBdqWzMG+hegbSQ@mail.gmail.com>
 <20250903154955.GD1587915@frogsfrogsfrogs>
 <CAJfpegu6Ec=nFPPD8nFXHPF+b1DxvWVEFnKHNHgmeJeo9xX7Nw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegu6Ec=nFPPD8nFXHPF+b1DxvWVEFnKHNHgmeJeo9xX7Nw@mail.gmail.com>

On Thu, Sep 04, 2025 at 01:26:36PM +0200, Miklos Szeredi wrote:
> On Wed, 3 Sept 2025 at 17:49, Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Wed, Sep 03, 2025 at 11:55:25AM +0200, Miklos Szeredi wrote:
> 
> > > Agree?
> >
> > I think we do, except maybe the difficult first point. :)
> 
> Let's then defer the LOOKUPX thing ;)   I'm fine with adding IMMUTABLE
> and APPEND to fuse_attr::flags.

OK.  Should I hide that behind the fuse mount having iomap turned on?
Or fc->is_local_fs == true?  Or let any server set those bits?

One thing occurred to me -- for a plain old fuse server that is the
client for some network filesystem, the other end might have its own
immutable/append bits, in which case we actually *do* want to let those
bits through from the FUSE_STATX replies.

--D

> Thanks,
> Miklos
> 

