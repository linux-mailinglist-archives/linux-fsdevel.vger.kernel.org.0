Return-Path: <linux-fsdevel+bounces-9869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 395A68458D2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 14:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0A0E28B0BA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 13:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F285B668;
	Thu,  1 Feb 2024 13:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWcsUdm3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372C85336F;
	Thu,  1 Feb 2024 13:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706793819; cv=none; b=nhfff6XUkuDKMCFt5wyIPu3vrV+gOeULzrR3/tnZwTKvWQ59EfrOShoaHsLj60GAAQNnHGWCH0CrB2uB+yFgelb45j3EyHxleq1TxWiytO13WzgWUkNRl9anW4NiJUQboFgY14cBxxt52fjmSATPTDMtH1OUR2cspzBuiAazHvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706793819; c=relaxed/simple;
	bh=NtqHFlxEJNZmH7ys32ys/m/kxKwQbmeoWmnAwqZzgqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2HKxKudo6NOkenyfFqD5okWadStYxO8+xCOL1EthcA6bGrJ+I7Qb5+F4GkXIrdrHBJg/mlXtylc+eTm5du1aGRQN3jDxftWtHYjiUScR9f/rYqD7QCGfsAcHC5zpo2QgDUgqv7VedoferRmUwz85Fd2XcbvOdIQeqRNEWZ4HxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWcsUdm3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F338C433F1;
	Thu,  1 Feb 2024 13:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706793818;
	bh=NtqHFlxEJNZmH7ys32ys/m/kxKwQbmeoWmnAwqZzgqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jWcsUdm32chHvmL/xxPi5Q7MJBIP6dyqox55U1S2j3jMlUQU2jc0OiZpXdqNRtNZ7
	 EneM+5P9eF+aCN5jUh+SaHEumhGSh99JWC4SzTcaLfKjJ8aJ9rSHMV/iNH7lrGEyMT
	 mc1FjiTkNhwuhNrB90Xm3h3Pf8v+WNbfvWExRlDgPNXGDlxrP7fezyc/gPX1H7DYHc
	 YJa23oiRd1NzwLRGMh+qPQYJo1zB522PGdSlfMlMIhy+3sg0JoyGnhwTB6MU1q739x
	 hi6tAwAjalLBmrvh2Xv146+YVZp0AFHozpG+B2mLXPBnJwAzI2FVLcJruq+tUyEkq6
	 FEgGOBmKCYTEA==
Date: Thu, 1 Feb 2024 14:23:30 +0100
From: Christian Brauner <brauner@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Chandan Babu R <chandan.babu@oracle.com>, 
	Zhang Yi <yi.zhang@huaweicloud.com>, Ritesh Harjani <ritesh.list@gmail.com>, 
	Jens Axboe <axboe@kernel.dk>, Andreas Gruenbacher <agruenba@redhat.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>, 
	Johannes Thumshirn <jth@kernel.org>, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Subject: Re: map multiple blocks per ->map_blocks in iomap writeback
Message-ID: <20240201-ebenso-flugobjekt-7e89e69907b0@brauner>
References: <20231207072710.176093-1-hch@lst.de>
 <20231211-listen-ehrbaren-105219c9ab09@brauner>
 <20240201060716.GA15869@lst.de>
 <20240201061835.GC616564@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240201061835.GC616564@frogsfrogsfrogs>

On Wed, Jan 31, 2024 at 10:18:35PM -0800, Darrick J. Wong wrote:
> On Thu, Feb 01, 2024 at 07:07:16AM +0100, Christoph Hellwig wrote:
> > On Mon, Dec 11, 2023 at 11:45:38AM +0100, Christian Brauner wrote:
> > > Applied to the vfs.iomap branch of the vfs/vfs.git tree.
> > > Patches in the vfs.iomap branch should appear in linux-next soon.
> > 
> > So it seems like this didn't make it to Linus for the 6.8 cycle, and
> > also doesn't appear in current linux-next.  Was that an oversight
> > or did I miss something?
> 
> Speaking solely for myself, I got covid like 2 days before you sent this
> and didn't get my brain back from the cleaners until ~2.5 weeks after.
> I totally forgot that any of this was going on. :(

Bah, sorry to hear that.

Sorry Christoph and Darrick. This was my fault as I seemingly dropped
that branch. I've rebased this onto v6.8-rc1 and it's now in vfs.iomap
and merged into vfs.all.

Going forward I'll be sending reminders to double-check branches for any
accidently dropped commits. Feel free to remind me in case I miss
anything!

