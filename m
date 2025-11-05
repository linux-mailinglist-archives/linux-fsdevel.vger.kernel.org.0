Return-Path: <linux-fsdevel+bounces-67179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE27C37381
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 18:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D01776620C9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 17:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B367338F45;
	Wed,  5 Nov 2025 17:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQ9X8BzK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A3C1C862E;
	Wed,  5 Nov 2025 17:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762364826; cv=none; b=uvpbOFohODUIjizbbm5sMsqIYkGWwqwJpQBpTPRt4tEjWTUGSGobvWMGSQEiXFZj5LJSmTmmom5JQV7SOZz0m6cDwVfUyHMZblAw73jWjdeq9tV1JwL6ZkPhRW34xOUJYdVHMU9yJhi3NJ2DYLdlKMJ6IeAoI4TNxPbfuLDZ1G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762364826; c=relaxed/simple;
	bh=/BXvEGHymUGiCxnhk7dwuwRbwFwHhZSRcQPI5vRjORU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7wmpCO34YfNXCIyvcnc+t09I7O5qB+fFptxtLmIIakwX4pYFVfTbwFO2rSkip6yu1/o/1BOEwCeNuC8Rs7doVtPNu5URib26kO7Lt68TLq/GjqYLdlsF6El6+OcXCS3r4CjC+DI3cjsNPOxjSXy71IRpI13g/TUU62JlrmQ0CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQ9X8BzK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B411C4CEF5;
	Wed,  5 Nov 2025 17:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762364826;
	bh=/BXvEGHymUGiCxnhk7dwuwRbwFwHhZSRcQPI5vRjORU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mQ9X8BzKqz1q1rRcBXlYS3n7HX/M1Oy6G9we0Uzy+lxhEQjjDKhg0yvCGtAQZUn7m
	 HiaWkmCpbzMFZ5/XKpG+rVk10jYgdWV7LujFhYX7yOVJbLXoJ/3JIfwoEf6N7UjyFB
	 2lZQVhsdRsL/KO8uyi/O14WEUt5G5Z8+N6x5VZfx6scyIuI+AixvCj4NVUmlEfaJrt
	 wceaIP1uz4FPOOB1XjNhW3fd7YrWGi1Y6g1OQRkf5iTzhfnen6AkLuQrxvH1Jzp3kS
	 ced65H7g6Lcjt7bm7IpFnK719Q+G9JMiZ4tnB2XAJrbjDSukuCvdzbmDCOSCLCJYYH
	 cEVxaXDoP7wkA==
Date: Wed, 5 Nov 2025 09:47:05 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH RFC 8/8] xfs: use super write guard in xfs_file_ioctl()
Message-ID: <20251105174705.GB196358@frogsfrogsfrogs>
References: <20251104-work-guards-v1-0-5108ac78a171@kernel.org>
 <20251104-work-guards-v1-8-5108ac78a171@kernel.org>
 <20251104170845.GK196370@frogsfrogsfrogs>
 <20251104-mitglied-ozonwerte-88de46f0b26a@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104-mitglied-ozonwerte-88de46f0b26a@brauner>

On Tue, Nov 04, 2025 at 09:57:30PM +0100, Christian Brauner wrote:
> On Tue, Nov 04, 2025 at 09:08:45AM -0800, Darrick J. Wong wrote:
> > On Tue, Nov 04, 2025 at 01:12:37PM +0100, Christian Brauner wrote:
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > ---
> > >  fs/xfs/xfs_ioctl.c | 6 ++----
> > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> > > index a6bb7ee7a27a..f72e96f54cb5 100644
> > > --- a/fs/xfs/xfs_ioctl.c
> > > +++ b/fs/xfs/xfs_ioctl.c
> > > @@ -1408,10 +1408,8 @@ xfs_file_ioctl(
> > >  
> > >  		trace_xfs_ioc_free_eofblocks(mp, &icw, _RET_IP_);
> > >  
> > > -		sb_start_write(mp->m_super);
> > > -		error = xfs_blockgc_free_space(mp, &icw);
> > > -		sb_end_write(mp->m_super);
> > > -		return error;
> > > +		scoped_guard(super_write, mp->m_super)
> > > +			return xfs_blockgc_free_space(mp, &icw);
> > 
> > Can we go full on Java?
> > 
> > #define with_sb_write(sb) scoped_guard(super_write, (sb))
> > 
> > 	with_sb_write(mp->m_super)
> > 		return xfs_blockgc_free_space(mp, &icw);
> > 
> > I still keep seeing scoped_guard() as a function call, not the sort of
> > thing that starts a new block.
> > 
> > [If I missed the bikeshedding war over this, I'll let this go]
> 
> It's an option and what I did for the creds stuff. The thing is thought
> that scoped_guard() is more widespread by now and thus probably easier
> to grasp for readers that are familiar with it. I'm not married to it.

The wait_ macro would maintain sb_.*_write greppability, though I don't
know how important that might be.

--D

