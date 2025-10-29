Return-Path: <linux-fsdevel+bounces-66337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D26FC1C186
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 17:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 81AF85A3A14
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 16:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CDE2F12AD;
	Wed, 29 Oct 2025 16:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8+lEigM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED122D8779;
	Wed, 29 Oct 2025 16:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761754489; cv=none; b=g7JTgFFd1qpw997pKDZn7apLktIuhbfb+hFDcODwYQePlmj2T3N3pkwY3OBGDuXgojVFR13tomrJoOnrvLgo1n0a8+bZb7z7S7ZyVXkYZIlYG5ZzoEdVG++VG+fs4xcgUTNmICi4JyFYhyB/Xy0AHp78hPF/eqpZc/uzIZwtEbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761754489; c=relaxed/simple;
	bh=BU/KJ2BFrWdN2k7V2JQhqCYa+EJvjFnOYlY5BUSYT9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqhKKRU5uK9r7gBurFD+F5lPyAuR9sy0CFA0IaAT0+EIZFOuhfgpfVBboilQ39mVEPI4SV/LAZMV1MHhoSQaZHgT8XFVSWf1xvddB73LWzVjJJh8n0gp9DMO2kpT1MpEKaBMd0QD1uPEmFc2Fh0X2YrAP8jPMRgChySpQ8UYETo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8+lEigM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BFFCC4CEF7;
	Wed, 29 Oct 2025 16:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761754488;
	bh=BU/KJ2BFrWdN2k7V2JQhqCYa+EJvjFnOYlY5BUSYT9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R8+lEigMCWnv6jmZw7f3tuW9pVGrdDzpaYzGpAmok0dAUywXkVhHfV+pEpY2S+ObD
	 MhgPMLz7+QpkFbjwJYYIzG3s4I34eOY9QZMCh5UWa0bSNXYsIoJoDuuarPMRLkGjqC
	 gyhFFH9+wwU4JmNGpKCinn0H33s7pLrMaPetcPVJaTGU+Z1J6xLIHixm20IX7VQees
	 3rRU25vTn3ZJeR4IYwNfj8YAzomS2wcdKfgSboFTHfdT8LfvdashHSYGQmIhLbcN89
	 FY5vptUOjJ5+fh75bKtGOIuYb6tbOZjCA8zWZ3O0iqTvmwnqvuLcXlVxp2TiWXqLfc
	 ew7CKmj0W7s2g==
Date: Wed, 29 Oct 2025 09:14:47 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bart Van Assche <bart.vanassche@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: fall back from direct to buffered I/O when stable writes are
 required
Message-ID: <20251029161447.GG3356773@frogsfrogsfrogs>
References: <20251029071537.1127397-1-hch@lst.de>
 <ea07dede-5baa-41e5-ad5d-a9f6a90ac6e8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea07dede-5baa-41e5-ad5d-a9f6a90ac6e8@gmail.com>

On Wed, Oct 29, 2025 at 08:58:52AM -0700, Bart Van Assche wrote:
> On 10/29/25 12:15 AM, Christoph Hellwig wrote:
> > we've had a long standing issue that direct I/O to and from devices that
> > require stable writes can corrupt data because the user memory can be
> > modified while in flight.  This series tries to address this by falling
> > back to uncached buffered I/O.  Given that this requires an extra copy it
> > is usually going to be a slow down, especially for very high bandwith
> > use cases, so I'm not exactly happy about.
> > 
> > I suspect we need a way to opt out of this for applications that know
> > what they are doing, and I can think of a few ways to do that:
> > 
> > 1a) Allow a mount option to override the behavior
> > 
> > 	This allows the sysadmin to get back to the previous state.
> > 	This is fairly easy to implement, but the scope might be to wide.

/me dislikes mount options because getting rid of them is hard.

> > 1b) Sysfs attribute
> > 
> > 	Same as above.  Slightly easier to modify, but a more unusual
> > 	interface.
> > 
> > 2) Have a per-inode attribute
> > 
> > 	Allows to set it on a specific file.  Would require an on-disk
> > 	format change for the usual attr options.
> > 
> > 3) Have a fcntl or similar to allow an application to override it
> > 
> > 	Fine granularity.  Requires application change.  We might not
> > 	allow any application to force this as it could be used to inject
> > 	corruption.
> > 
> > In other words, they are all kinda horrible.

Yeah, I don't like the choices either.  Bart's prctl sounds the least
annoying but even then I still don't like "I KNOW WHAT I'M DOING!!"
flags.

> Hi Christoph,
> 
> Has the opposite been considered: only fall back to buffered I/O for buggy
> software that modifies direct I/O buffers before I/O has
> completed?

How would xfs detect that?  For all we know the dio buffer is actually a
piece of device memory or something, and some hardware changed the
memory without the kernel knowing that.  Later on the raid scrub fails a
parity check and it's far too late to do anything about it.

--D

> Regarding selecting the direct I/O behavior for a process, how about
> introducing a new prctl() flag and introducing a new command-line
> utility that follows the style of ionice and sets the new flag before
> any code runs in the started process?
> 
> Thanks,
> 
> Bart.
> 

