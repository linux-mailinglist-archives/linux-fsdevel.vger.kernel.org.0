Return-Path: <linux-fsdevel+bounces-38622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE352A04FA2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 02:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F12D1637EE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 01:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CCC19E7F9;
	Wed,  8 Jan 2025 01:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2ScurNo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B55197A87;
	Wed,  8 Jan 2025 01:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736299598; cv=none; b=Y6L8EA2Ag7JDjAixRY3vQxRYEYjzZIcPm3TRTagnC4p3N1Vj2qygKsLBLD9/r27nM2XBANmY4ViOkKb2kHhma98H/hAQ1sDlxNQuBLf65w8Etvq/ntU+tNltvkA5b3/Cyaucjm6EIj+QFiqTcZkQUgcHnC9RjZd4EXeiGlH/clY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736299598; c=relaxed/simple;
	bh=vkVjnKRqGlDlum/jA+USzPiNMSXGI7tIMAfgeioFVGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOqNaiI0DMBwcRJ47Swk6NNSaquArOO/7EUw9Jm7GXQzuTY4sKV10LjBijTjRyHE+dJTYaWKCnQvboZlc0/I03iiRuDSwJMavLvWSEzXXuAXaFDPHOptgVgmXBAz6PvnAaT1wR34lQ3nxxJKLgODJRLz35E+5O9AnbyjkKjVHsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2ScurNo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75705C4CEDF;
	Wed,  8 Jan 2025 01:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736299597;
	bh=vkVjnKRqGlDlum/jA+USzPiNMSXGI7tIMAfgeioFVGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F2ScurNoYBogXxdkW/7hiqwFoyLjYT6h2VORn4bZJ3YJJJmXqPZISBhVxBExRJWgM
	 lPGpJhCy2u+IDD5CRQqnb5P1SqVdcN2SB/Lbk8yjpz1//QCp4nszvA4MgVJjTy42s6
	 5h1opxiw9Asr/hEiMPX/QB+SNJIJ8Dc0h/jBFZBotAkBA1okpmLKrttsQ92LeoBD6P
	 DuUDDTZADR8jZGTvRD1Y2ZbxYmLNNTjITdC1laXXgteP47pXxa+6mj28DB9fmVlsm7
	 pKUz3wzJxG9cT7TgVNXccCdTrBtUxSY9iJGEAT/N4ORrriNyj03yWLsUwAUolT2SJH
	 Ale0XYK0VL36g==
Date: Tue, 7 Jan 2025 17:26:36 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, brauner@kernel.org, cem@kernel.org,
	dchinner@redhat.com, ritesh.list@gmail.com,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, martin.petersen@oracle.com
Subject: Re: [PATCH v2 2/7] iomap: Add zero unwritten mappings dio support
Message-ID: <20250108012636.GE1306365@frogsfrogsfrogs>
References: <20241210125737.786928-1-john.g.garry@oracle.com>
 <20241210125737.786928-3-john.g.garry@oracle.com>
 <20241211234748.GB6678@frogsfrogsfrogs>
 <4d34e14f-6596-483b-86e8-d4b7e44acd9a@oracle.com>
 <20241212204007.GL6678@frogsfrogsfrogs>
 <20241213144740.GA17593@lst.de>
 <20241214005638.GJ6678@frogsfrogsfrogs>
 <20241217070845.GA19358@lst.de>
 <93eecf38-272b-426f-96ec-21939cd3fbc5@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93eecf38-272b-426f-96ec-21939cd3fbc5@oracle.com>

On Wed, Dec 18, 2024 at 11:15:42AM +0000, John Garry wrote:
> On 17/12/2024 07:08, Christoph Hellwig wrote:
> > On Fri, Dec 13, 2024 at 04:56:38PM -0800, Darrick J. Wong wrote:
> > > > > "If you receive -EBADMAP, then call fallocate(FALLOC_FL_MAKE_OVERWRITE)
> > > > > to force all the mappings to pure overwrites."
> > > > 
> > > > Ewwwwwwwwwwwwwwwwwwwww.
> > > > 
> > > > That's not a sane API in any way.
> > > 
> > > Oh I know, I'd much rather stick to the view that block untorn writes
> > > are a means for programs that only ever do IO in large(ish) blocks to
> > > take advantage of a hardware feature that also wants those large
> > > blocks.
> > 
> > I (vaguely) agree ith that.
> > 
> > > And only if the file mapping is in the correct state, and the
> > > program is willing to *maintain* them in the correct state to get the
> > > better performance.
> > 
> > I kinda agree with that, but the maintain is a bit hard as general
> > rule of thumb as file mappings can change behind the applications
> > back.  So building interfaces around the concept that there are
> > entirely stable mappings seems like a bad idea.
> 
> I tend to agree.

As long as it's a general rule that file mappings can change even after
whatever prep work an application tries to do, we're never going to have
an easy time enabling any of these fancy direct-to-storage tricks like
cpu loads and stores to pmem, or this block-untorn writes stuff.

> > 
> > > I don't want xfs to grow code to write zeroes to
> > > mapped blocks just so it can then write-untorn to the same blocks.
> > 
> > Agreed.
> > 
> 
> So if we want to allow large writes over mixed extents, how to handle?
> 
> Note that some time ago we also discussed that we don't want to have a
> single bio covering mixed extents as we cannot atomically convert all
> unwritten extents to mapped.

From https://lore.kernel.org/linux-xfs/Z3wbqlfoZjisbe1x@infradead.org/ :

"I think we should wire it up as a new FALLOC_FL_WRITE_ZEROES mode,
document very vigorously that it exists to facilitate pure overwrites
(specifically that it returns EOPNOTSUPP for always-cow files), and not
add more ioctls."

If we added this new fallocate mode to set up written mappings, would it
be enough to write in the programming manuals that applications should
use it to prepare a file for block-untorn writes?  Perhaps we should
change the errno code to EMEDIUMTYPE for the mixed mappings case.

Alternately, maybe we /should/ let programs open a lease-fd on a file
range, do their untorn writes through the lease fd, and if another
thread does something to break the lease, then the lease fd returns EIO
until you close it.

<shrug> any thoughts?

--D

> Thanks,
> John
> 
> 
> 
> 

