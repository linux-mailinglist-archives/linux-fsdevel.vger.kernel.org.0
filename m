Return-Path: <linux-fsdevel+bounces-60367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE69B45C70
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 17:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A01263BA399
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 15:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545471C701F;
	Fri,  5 Sep 2025 15:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+xvrC8h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DBA220696
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Sep 2025 15:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757085771; cv=none; b=ovsP2hKSJx7yC7TxqOLkPNec4j1gSU5b7YL00XBFyRw1CWQ1Jp5XQq2DsJWK20J/nJrhv8OXDhNvYSgKCAw2DcvReBr5CUnveCZp6qA4o1lgxWpsyRLPTSrzRCCGHylVwSlg4z03HqP5FHTf8xEAS+HgysQxwl0zYzDTBpLDyNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757085771; c=relaxed/simple;
	bh=OZ/Lx1Zz2uWk3zIlBnv9jk4uKCzlbtEu5wmvtgpUwrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvWxJTyLfoWp4xNiG8Fv2B23TjkjqAQFeSBDdNaySiEUHwALuylnvcQuiZxVtuWvG39kk03XDiuWNSmaepWHBtFTcQhtXFpo9da3NRAY452HLctGD7VmChL4JK/Kfp4Uplsg35noN3WtTEetdQDaWripumyAJm1o8X6KN3xYn2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+xvrC8h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4446BC4CEF1;
	Fri,  5 Sep 2025 15:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757085771;
	bh=OZ/Lx1Zz2uWk3zIlBnv9jk4uKCzlbtEu5wmvtgpUwrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L+xvrC8h/4E42eRYdHpUrFLDAtT7lqukS2N+ggvqcK1v6OIQL/ahytVS/RDSyITK/
	 B09QcqBCKgnnRwGpAgHppsSqM5rVnzG5GLjeJOsZv+hZhPehPQxIyoFmDrkZcwQb6D
	 TPBn3vQjJP5n2ChS8gEoRLujXcC4N9HGW6aCRAkhFh78F2MJeIVoZEZQDBMC/xJAy5
	 e/wmY9xwIweoFbBCl/Lb9mdhZGtfLoEdc1JqI5fWMGwFDLkOqL0mpNA4ya4B8kbuah
	 hVndpGhOeAQ7q6w+9ZmJMCicoY2qtflNpDbzEHtMGfUkPiH+TiL2KIdgEhukMA8PBr
	 Vv1W1irU9Ne9Q==
Date: Fri, 5 Sep 2025 08:22:50 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
	linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Subject: Re: [PATCH 4/7] fuse: implement file attributes mask for statx
Message-ID: <20250905152250.GF1587915@frogsfrogsfrogs>
References: <175573708630.15537.1057407663556817922.stgit@frogsfrogsfrogs>
 <CAJfpegsp=6A7jMxSpQce6Xx72POGddWqtJFTWauM53u7_125vQ@mail.gmail.com>
 <20250829153938.GA8088@frogsfrogsfrogs>
 <CAJfpegs=2==Tx3kcFHoD-0Y98tm6USdX_NTNpmoCpAJSMZvDtw@mail.gmail.com>
 <20250902205736.GB1587915@frogsfrogsfrogs>
 <CAJfpegskHg7ewo6p0Bn=3Otsm7zXcyRu=0drBdqWzMG+hegbSQ@mail.gmail.com>
 <20250903154955.GD1587915@frogsfrogsfrogs>
 <CAJfpegu6Ec=nFPPD8nFXHPF+b1DxvWVEFnKHNHgmeJeo9xX7Nw@mail.gmail.com>
 <20250905012854.GA1587915@frogsfrogsfrogs>
 <CAJfpegubFsCjWJyJhv_9HE_9_htL3Z7-r_AMFszxA-982dC-Jw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegubFsCjWJyJhv_9HE_9_htL3Z7-r_AMFszxA-982dC-Jw@mail.gmail.com>

On Fri, Sep 05, 2025 at 09:02:05AM +0200, Miklos Szeredi wrote:
> On Fri, 5 Sept 2025 at 03:28, Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Thu, Sep 04, 2025 at 01:26:36PM +0200, Miklos Szeredi wrote:
> > > On Wed, 3 Sept 2025 at 17:49, Darrick J. Wong <djwong@kernel.org> wrote:
> > > >
> > > > On Wed, Sep 03, 2025 at 11:55:25AM +0200, Miklos Szeredi wrote:
> > >
> > > > > Agree?
> > > >
> > > > I think we do, except maybe the difficult first point. :)
> > >
> > > Let's then defer the LOOKUPX thing ;)   I'm fine with adding IMMUTABLE
> > > and APPEND to fuse_attr::flags.
> >
> > OK.  Should I hide that behind the fuse mount having iomap turned on?
> > Or fc->is_local_fs == true?  Or let any server set those bits?
> >
> > One thing occurred to me -- for a plain old fuse server that is the
> > client for some network filesystem, the other end might have its own
> > immutable/append bits, in which case we actually *do* want to let those
> > bits through from the FUSE_STATX replies.
> 
> Right, as I said this might have worked without VFS help, but having
> it consistently in the VFS as well would be nicer.
> 
> In that spirit, putting those bits in the inode is safe only in the
> local fs case, so I guess that's what we should do.  And for
> consistency, in the local fs case inode->flags should be the
> authoritative source and all the userspace API's should be looking at
> that, instead of what the server sent in the IOCTL or STATX replies.

Ok, I'll meld that all together today.

--D

> Thanks,
> Miklos
> 

