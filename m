Return-Path: <linux-fsdevel+bounces-73882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC8FD228B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 07:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2D33E3008C5C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 06:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76DC227B8E;
	Thu, 15 Jan 2026 06:24:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095E62236FA;
	Thu, 15 Jan 2026 06:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768458276; cv=none; b=Sqwh4VuaaEJl+pVKNSdswSOJ/tdl0epVIgwbqlUODLRi8Js3XGlqXH2m+s7CcDh87x3/vxYBoWE7vEA6HTVy1jMIFvZRULZHJnIEdMyFLlIMa0cQs5w1WRueOhSzzMMVccICyGUsMBYie04Qb9+J11NpQvbtzjoLw9VwmTaue7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768458276; c=relaxed/simple;
	bh=KIhm1XufAznvrR2UwjEjuF5zYuMHtrqnlyhSV4IcgKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCK7iaBjaH9xrkAZp+Cx3nA8xU06OY2Q7uFGD7FTaQhNL/J5toV3CEpm5mf92G4jBInKjmCUqxt51iKH/TUToHZRzBIg7A0s5wpAlYuKm9q7IXsTRP6+smKceOPfZBAiqODKSKZ3on6eAp4cKAVxnwjvfkPTjniVLrx3ITOUDDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4E62E227AA8; Thu, 15 Jan 2026 07:24:31 +0100 (CET)
Date: Thu, 15 Jan 2026 07:24:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 14/14] xfs: use bounce buffering direct I/O when the
 device requires stable pages
Message-ID: <20260115062430.GI9205@lst.de>
References: <20260114074145.3396036-1-hch@lst.de> <20260114074145.3396036-15-hch@lst.de> <20260114230728.GS15551@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114230728.GS15551@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 14, 2026 at 03:07:28PM -0800, Darrick J. Wong wrote:
> Now that I've gotten to the final patch, one thing strikes me as a
> little strange -- we pass the iocb to iomap_dio_rw, which means that in
> theory iomap could set IOMAP_DIO_BOUNCE for us, instead of XFS having to
> do that on its own.
> 
> I think the only barrier to that is the little bit with
> xfs_dio_read_bounce_submit_io where we have to kick the direct read
> completion to a place where we can copy the bounce buffer contents to
> the pages that the caller gave us in the iov_iter, right?

Yes.

> Directio already has a mechanism for doing completions from
> s_dio_done_wq, so can't we reuse that?  Or is the gamble here that
> things like btrfs might want to do something further with the bounce
> buffer (like verifying checksums before copying to the caller's pages)
> so we might as well make the fs responsible for setting IOMAP_DIO_BOUNCE
> and taking control of the bio completion?

A few things:

  - s_dio_done_wq is used for completing the entire iomap_dio
  - by default the iomap direct I/O code uses plain bios, that don't
    have a work struct that can be queued up on a workqueue, so we'll
    need to grow that structure
  - queuing a work_struct for each I/O completion can lead to nasty
    scheduling storms

All that is handled nicely by the XFS ioend based code, which uses
a per-inode work and merging of contiguous ioends.  As mentioned in
the cover letter this should probably move to common code, and then
used by all file systems.  But one thing at a time.


