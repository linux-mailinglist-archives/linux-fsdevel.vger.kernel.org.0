Return-Path: <linux-fsdevel+bounces-51068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BADAD278D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 22:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02B311894E6C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 20:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DA422126D;
	Mon,  9 Jun 2025 20:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ogzi/2Ms"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7A71AA782;
	Mon,  9 Jun 2025 20:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749500977; cv=none; b=ik0NOOozbTRgAt7CljwdeddtO+k8wbVaSw2KtVyGfdfj3LxgP1xMyqW941gsaBgc4sPua3zlAPtIYgM9v0AywehoXIGl8kl9K0e0fekBZJL12qP3wSqW6geOYyZS26edou21I/Kgob/8W1U12LIwa8FfhISL3v1f++QmMt7AUoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749500977; c=relaxed/simple;
	bh=KC900HYZGvbagK26NWtuXMtx5ERM58Y3FC5+HvTwVVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHW9d5n+nK0Zfsog0EkFAuMxoW9AYXGx3DMj23oaOF0h1C85I3jJ7XwBBRvy89pTY1hmrDpOzeJe2Ya/QeFEKT9XIKDWIgEEpeJ1fJtRBEogXxkXeDzNNjqbpIK6/pqqU7LYZoRGx2bIG6EExNKFCJfB8EainPpQNHL5Hs0fG7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ogzi/2Ms; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F47C4CEEB;
	Mon,  9 Jun 2025 20:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749500977;
	bh=KC900HYZGvbagK26NWtuXMtx5ERM58Y3FC5+HvTwVVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ogzi/2MsceljrLA7F4PoHffPSxSFajTlvgJkpS6QRj0GlZIZClg/7y4s21sFuWhSt
	 P0SdEeLIWhc5JW3X1Jkq8TyS1a6QmQZdk7anyI0OBZQ/ElDdYB8OJ1Aovp6H78yz7h
	 6F/3Ewior4UcomlvRNMXuDUCLBrbVg3Og7KIaX5FZGLNymZI9gBe0kibE4ifBhnuwv
	 s16h63imDJalIOYt10PzXBfKJTg+e33mtf3X7D8kTwtlBhGcayj6qoJRrnC3ZaUw8e
	 2LPwLTlILaLrzSScayNzHMtDUM5T2XRLO1OAO+lFN0MH7baqW8aKTo2uSUb4JylZmD
	 QCcpY54zLIt9w==
Date: Mon, 9 Jun 2025 13:29:36 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com,
	linux-xfs@vger.kernel.org, bernd@bsbernd.com, John@groves.net
Subject: Re: [PATCH 01/11] fuse: fix livelock in synchronous file put from
 fuseblk workers
Message-ID: <20250609202936.GA6138@frogsfrogsfrogs>
References: <174787195502.1483178.17485675069927796174.stgit@frogsfrogsfrogs>
 <174787195588.1483178.6811285839793085547.stgit@frogsfrogsfrogs>
 <CAJfpegsn2eBjy27rncxYBQ1heoiA1tme8oExF-d_C9DoFq34ow@mail.gmail.com>
 <20250531010844.GF8328@frogsfrogsfrogs>
 <CAJfpegvwXqL_N0POa95KgPJT5mMXS2xxCojbGWABhFCZy8An+g@mail.gmail.com>
 <20250609181326.GC6179@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609181326.GC6179@frogsfrogsfrogs>

On Mon, Jun 09, 2025 at 11:13:26AM -0700, Darrick J. Wong wrote:
> On Fri, Jun 06, 2025 at 03:54:50PM +0200, Miklos Szeredi wrote:
> > On Sat, 31 May 2025 at 03:08, Darrick J. Wong <djwong@kernel.org> wrote:
> > 
> > > The best reason that I can think of is that normally the process that
> > > owns the fd (and hence is releasing it) should be made to wait for
> > > the release, because normally we want processes that generate file
> > > activity to pay those costs.
> > 
> > That argument seems to apply to all fuse variants.  But fuse does get
> > away with async release and I don't see why fuseblk would be different
> > in this respect.
> > 
> > Trying to hack around the problems of sync release with a task flag
> > that servers might or might not have set does not feel a very robust
> > solution.
> > 
> > > Also: is it a bug that the kernel only sends FUSE_DESTROY on umount for
> > > fuseblk filesystems?  I'd have thought that you'd want to make umount
> > > block until the fuse server is totally done.  OTOH I guess I could see
> > > an argument for not waiting for potentially hung servers, etc.
> > 
> > It's a potential DoS.  With allow_root we could arguably enable
> > FUSE_DESTROY, since the mounter is explicitly acknowledging this DoS
> > possibilty.
> 
> <nod> Looking deeper at fuse2fs's op_destroy function, I think most of
> the slow functionality (writing group descriptors and the primary super
> and fsyncing the device) ought to be done via FUSE_SYNCFS, not
> FUSE_DESTROY.  If I made that change, I think op_destroy becomes very
> fast -- all it does is close the fs and log a message.  The VFS unmount
> code calls sync_filesystem (which initiates a FUSE_SYNCFS) which sounds
> like it would work for fuse2fs.
> 
> Unhappily, libfuse3 doesn't seem to implement it:
> 
> $ git grep FUSE_SYNCFS
> doc/libfuse-operations.txt:394:50. FUSE_SYNCFS (50)
> include/fuse_kernel.h:186: *  - add FUSE_SYNCFS
> include/fuse_kernel.h:670:      FUSE_SYNCFS             = 50,

...and it won't really work anyway since fuse_sync_fs doesn't upcall to
the fuse server if sb->s_root == NULL; and we can't do anything at that
point anyway because deactivate_locked_super -> fuse_kill_sb_anon has
already called fuse_conn_destroy to tear down the connection.

--D

> 
> > Thanks,
> > Miklos
> 

