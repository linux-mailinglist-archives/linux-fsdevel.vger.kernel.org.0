Return-Path: <linux-fsdevel+bounces-51266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CA2AD5023
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 11:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EAFE7A61F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 09:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CB42609D5;
	Wed, 11 Jun 2025 09:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GW1Plu2E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE8923E25B
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 09:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634608; cv=none; b=tEccRaHNZ1JyguzChHNJV5a7ccAJsIzMymmrYwiu+2kPgih17+z0OH0A2X5GfWjhWz7a6ND6sdy8HQEWD8J3RVxvUqLQB6IXRXTrcYEDbA5MxJqp2z2VONi0qB5guUwTCIR79JE2ZsAPgnNo8ZQkxP1RozCTRZ5FE5vPdm0X9mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634608; c=relaxed/simple;
	bh=4S2bRreIV196LeuUbldSTWGivnFEuN0eS5NT0vpiDBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUHqyREYM2tDZ19CWO1EacuOSchHvj5EZy666w74NoI29bOywkMCEMt/fbnX4AnTIGcg1diAhSdIKcgoXr7MGHPD1aXoRrPP2DkS9+1jcUoGDul0wGteO/rAAhPs/oG0iWIxrL89qj9N+VFkZ9Rl0fZICuB+05abbULthB3/bFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GW1Plu2E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40AECC4CEEE;
	Wed, 11 Jun 2025 09:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749634607;
	bh=4S2bRreIV196LeuUbldSTWGivnFEuN0eS5NT0vpiDBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GW1Plu2E1YQshngRaYFlcETptgMwGpOmbUub7q7NrFfCDNA8/GUeVG+HfCldBsB7q
	 KjyT13DcKplz01QkggfYlyECsYmGEKGSpP3vJoyjG4ztScBFcJ4xmGug6bycuN3ttW
	 nIPtWlGl3vHFevyig0o1MBFjgseIGzMuimlH2XcCJL6XHmTfO9KbbXjn5LWfdrby7W
	 Hyipz0CW98Och8T6TlEzPyoZHIKYG7kkPowsFv6qP5SVcUMjT5Pba9BBYLff+O9AQX
	 Dj5bgVKYCbGi8KcpeYk/4Q21BDb0eOD2TS7CRjfgh0+OPX6dCfkSmhkFAOoecEPdD5
	 peRQm1A7196Wg==
Date: Wed, 11 Jun 2025 11:36:43 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, 
	Jan Kara <jack@suse.cz>, Allison Karlitskaya <lis@redhat.com>
Subject: Re: [PATCH 1/2] mount: fix detached mount regression
Message-ID: <20250611-denkpause-wegrand-6eb6647dab77@brauner>
References: <20250605-work-mount-regression-v1-0-60c89f4f4cf5@kernel.org>
 <20250605-work-mount-regression-v1-1-60c89f4f4cf5@kernel.org>
 <20250606045441.GS299672@ZenIV>
 <20250606051428.GT299672@ZenIV>
 <20250606070127.GU299672@ZenIV>
 <20250606-neuformulierung-flohmarkt-42efdaa4bac5@brauner>
 <20250606174502.GY299672@ZenIV>
 <20250607052048.GZ299672@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250607052048.GZ299672@ZenIV>

On Sat, Jun 07, 2025 at 06:20:48AM +0100, Al Viro wrote:
> On Fri, Jun 06, 2025 at 06:45:02PM +0100, Al Viro wrote:
> > On Fri, Jun 06, 2025 at 09:58:26AM +0200, Christian Brauner wrote:
> > 
> > > Fwiw, check_mnt() is a useless name for this function that's been
> > > bothering me forever.
> > 
> > Point, but let's keep the renaming (s/check_mnt/our_mount/, for
> > example) separate.
> 
> Modified and force-pushed.
> 
> It does pass xfstests without regressions.  kselftests... AFAICS,
> no regressions either, but the damn thing is a mess.  Example:
> 
> # # set_layers_via_fds.c:711:set_layers_via_detached_mount_fds:Expected layers_found[i] (0) == true (1)
> # # set_layers_via_fds.c:39:set_layers_via_detached_mount_fds:Expected rmdir("/set_layers_via_fds") (-1) == 0 (0)
> # # set_layers_via_detached_mount_fds: Test terminated by assertion
> # #          FAIL  set_layers_via_fds.set_layers_via_detached_mount_fds
> 
> Not a regression, AFAICT; the underlying problem is that mount options
> are shown incorrectly in the tested case.  Still present after overlayfs
> merge.  mount does succeed, but... in options we see this:
> rw,relatime,lowerdir+=/,lowerdir+=/,lowerdir+=/,lowerdir+=/,datadir+=/,datadir+=/,datadir+=/,upperdir=/upper,workdir=/work,redirect_dir=on,uuid=on,metacopy=on
> 
> And it's a perfectly expected result - you are giving fsconfig(2) empty
> path on a detached tree, created with OPEN_TREE_CLONE.  I.e. it *is*
> an empty path in the mount tree the sucker's in.  What could d_path()
> produce other than "/"?

Sigh. There's no need to get all high and mighty about this. For once I
actually do write extensive selftests and they do actually catch a lot
of bugs. It's a joke how little selftests we have given the importance
of our apis. Nobody ever gives a flying fsck to review selftests when
they're posted because nobody seems to actually care.

The simple thing here to do is to point out that there's an issue in the
tests and that this should be fixed and maybe ask why.

The answer to that is that the getline checked in

        TEST_F(set_layers_via_fds, set_layers_via_detached_mount_fds)

is a simple copy-and-paste error from

        TEST_F(set_layers_via_fds, set_layers_via_fds)

that should just be removed and that's the end of that problem.

What sort of odd assumption is it that I'm not aware that a detached
tree doesn't resolve to /tmp. It's clearly a simple bug.

I actually had a patch to fix this I probably just forgot to paste it
during the merge window that added support for this.

> Note, BTW that it really does create set_layers_via_fds in root (WTF?) and
> running that sucker again yields a predictable fun result - mkdir() failing
> with EEXIST...

It's clearly a cleanup issue in FIXTURE_TEARDOWN(). Either fix it or ask
me to fix it.

> IMO that kind of stuff should be dealt with by creating a temporary directory
> somewhere in /tmp, mounting tmpfs on it, then doing all creations, etc.
> inside that.  Then umount -l /tmp/<whatever>; rmdir /tmp/<whatever> will
> clean the things up.

Sorry, that's just wishful thinking at best and out of touch with how
these apis are used. The fact that you need a private assembly in some
hidden away directory followed by a umount is a complete waste of system
calls for a start. It's also inherently unclean unless you also bring
mount namespaces into the mix. Being able to use detached mount trees is
simple and clean especially for the overlayfs layer case.

There's enough cases where you don't ever want to leak the mounts into
an actually accessible mount namespace.

