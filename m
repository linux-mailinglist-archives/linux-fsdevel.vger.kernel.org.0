Return-Path: <linux-fsdevel+bounces-42766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E35BFA4869C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 18:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4FDA7A76D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 17:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E1F1DE4DE;
	Thu, 27 Feb 2025 17:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGaZUP6v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0921DE3B3;
	Thu, 27 Feb 2025 17:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740677353; cv=none; b=FWu585ZHkw0QZJIm2+YTGnNa+GxTv9ldjeHVDmP1kuoPqogeqdqy4y/P3a4DimGhuoC0tjuQ8PY0HR+VLBqhZyxhBKmyF6HGdDHH2uL8byTh6xVxjrqi3GY7McugbREfpO/Frn6UDGH9db6BDhAhQ9ojBcCB9+wC+uluSvRAJq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740677353; c=relaxed/simple;
	bh=aKTihwdmWnVOPpFLB3ojexIrErAwzbOnNr/AECau6gU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPiRq/H5cNELyRJpQvnA0gQ/XJt/H9I14JIttoQ7KdpebuWRCHDaasXexYP0XdJeI7Gi6xdMGEcZCwkoyp2JRFw2EvIPc8ixQIKTAZksg8DvEba+TtHmTV/LVyc+BR8sKgbkw7zk6xDJvs7qv0zBcOGq3x6qXnRYQYNX4D+wHSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGaZUP6v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70249C4CEDD;
	Thu, 27 Feb 2025 17:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740677352;
	bh=aKTihwdmWnVOPpFLB3ojexIrErAwzbOnNr/AECau6gU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=QGaZUP6vMkmo1Vav5QGZdq+Og+nzouJowmLkV2hUA7WgIdlSUS+wEN2ppKMeJl40A
	 xQeQI77juhM2vmB5d7vWvFvvLh0j3WMDpP+lwvMC6PZgpOl34QZPP9zSaaGL366mXv
	 ipTljD2mPs7r3SdUvnAZZG0P/X8iA8VUw1xQk/eUAg+Tst7w/lVatEe6gukESjrE98
	 dXye4PkWXnBWJHDOQPo0BOKInK5lPdoyrv5ZLw3J7iECP4N4LARVbiHtDAKIhrwL/E
	 Ad6Oohdp6DP0BVxbO2oQUydE89vD8+2D1iB32iSK2JXAUkkEAB1yblfgXLpx1DDJaT
	 En8iYn+mGZKQA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 072ABCE0799; Thu, 27 Feb 2025 09:29:12 -0800 (PST)
Date: Thu, 27 Feb 2025 09:29:12 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, sfr@canb.auug.org.au,
	linux-next@vger.kernel.org
Subject: Re: [PATCH RFC namespace] Fix uninitialized uflags in
 SYSCALL_DEFINE5(move_mount)
Message-ID: <d8c20a28-2dc4-4b9d-bea0-0800aea0de30@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <e85f9977-0719-4de8-952e-8ecdd741a9d4@paulmck-laptop>
 <20250227-abbruch-geknickt-c6522ef250a7@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227-abbruch-geknickt-c6522ef250a7@brauner>

On Thu, Feb 27, 2025 at 09:13:10AM +0100, Christian Brauner wrote:
> On Wed, Feb 26, 2025 at 11:18:49AM -0800, Paul E. McKenney wrote:
> > The next-20250226 release gets an uninitialized-variable warning from the
> > move_mount syscall in builds with clang 19.1.5.  This variable is in fact
> > assigned only if the MOVE_MOUNT_F_EMPTY_PATH flag is set, but is then
> > unconditionally passed to getname_maybe_null(), which unconditionally
> > references it.
> > 
> > This patch simply sets uflags to zero in the same manner as is done
> > for lflags, which makes rcutorture happy, but might or might not be a
> > proper patch.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: <linux-fsdevel@vger.kernel.org>
> > Cc: <linux-kernel@vger.kernel.org>
> > ---
> 
> Hey Paul! Thank you for the patch. The fix is correct but I've already
> taken a patch from Arnd yesterday. So hopefully you'll forgive me for
> not taking yours. :)

Thank you, and looking forward to seeing -next being fixed.  I guess I
just need to be faster.  ;-)

							Thanx, Paul

> >  namespace.c |    2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index 663bacefddfa6..80505d533cd23 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -4617,6 +4617,7 @@ SYSCALL_DEFINE5(move_mount,
> >  	if (flags & MOVE_MOUNT_BENEATH)		mflags |= MNT_TREE_BENEATH;
> >  
> >  	lflags = 0;
> > +	uflags = 0;
> >  	if (flags & MOVE_MOUNT_F_SYMLINKS)	lflags |= LOOKUP_FOLLOW;
> >  	if (flags & MOVE_MOUNT_F_AUTOMOUNTS)	lflags |= LOOKUP_AUTOMOUNT;
> >  	if (flags & MOVE_MOUNT_F_EMPTY_PATH)	uflags = AT_EMPTY_PATH;
> > @@ -4625,6 +4626,7 @@ SYSCALL_DEFINE5(move_mount,
> >  		return PTR_ERR(from_name);
> >  
> >  	lflags = 0;
> > +	uflags = 0;
> >  	if (flags & MOVE_MOUNT_T_SYMLINKS)	lflags |= LOOKUP_FOLLOW;
> >  	if (flags & MOVE_MOUNT_T_AUTOMOUNTS)	lflags |= LOOKUP_AUTOMOUNT;
> >  	if (flags & MOVE_MOUNT_T_EMPTY_PATH)	uflags = AT_EMPTY_PATH;

