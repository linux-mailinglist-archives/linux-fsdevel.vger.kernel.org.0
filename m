Return-Path: <linux-fsdevel+bounces-37397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA7E9F1BA2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 01:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6271C7A0FF7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 00:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDD61799F;
	Sat, 14 Dec 2024 00:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHLF2XVq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E1D14012;
	Sat, 14 Dec 2024 00:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734137799; cv=none; b=i9b+g7EL03sXji03r8oQ53sBh0gHgM79qo0i9yhFQiJRhzBXqS0Qy/wrhMNJaeDK4sky6swsMhyjBzsI1wEXHwv3zLOAERAhcHN98kSpOGyvDmJDYOrJ4N4CuUl5pStZ7AijDAgE2CqkoeYzm321uErkGm6WhWE62uV5PlRwZ6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734137799; c=relaxed/simple;
	bh=06DHfHUoXN2gx/rqmuaz6xAj+b6BV0g4p7qVhA+C9ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nhWVYFSq2As/PmcaHK+vC6OCR+7W+VZci+GLYXttiMdSD8hXLQODCsf0CXIjjofXHz02RHKovEj+/jy2pXmGU6auVDpYIenyJcAO8K3vaf22EebZwrtwHooHafAV0OHubE7x59L2XKdIa+G8eOOdFYymzi89bkZR2TGT5b+mdn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHLF2XVq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD23C4CED0;
	Sat, 14 Dec 2024 00:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734137799;
	bh=06DHfHUoXN2gx/rqmuaz6xAj+b6BV0g4p7qVhA+C9ws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BHLF2XVqZa0LCEogswGR35sUTliRU4plg9Dgx9U3oDfPyyfkWf+AzQJYyl25khZrK
	 DGcEzjN+oI9wyuN5RRNVxKQN96CXx4h+8w59P+4tbfEp5Ehn/HQ7eJhTUM4myAU+Zn
	 TXd06WDaP5plwJmGANIxNQTPH/jZ9PKyVoaJgbkjNIBXHk4jmDf8m0EECXh7rl+Jg6
	 /V9UR7fndT8YN7sjH9s9AMkHcFIKt7FnYxPl0dvs6h43Ldqlo6ejdr48daZB8gUMhM
	 Iux7A10xepuEhplmCZPqLSd5FDk0yLCDuteoGpLIFX8p+v1lNHWjq5LSHCOjgHuoQ1
	 hbdAaSbmWrGYw==
Date: Fri, 13 Dec 2024 16:56:38 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: John Garry <john.g.garry@oracle.com>, brauner@kernel.org,
	cem@kernel.org, dchinner@redhat.com, ritesh.list@gmail.com,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, martin.petersen@oracle.com
Subject: Re: [PATCH v2 2/7] iomap: Add zero unwritten mappings dio support
Message-ID: <20241214005638.GJ6678@frogsfrogsfrogs>
References: <20241210125737.786928-1-john.g.garry@oracle.com>
 <20241210125737.786928-3-john.g.garry@oracle.com>
 <20241211234748.GB6678@frogsfrogsfrogs>
 <4d34e14f-6596-483b-86e8-d4b7e44acd9a@oracle.com>
 <20241212204007.GL6678@frogsfrogsfrogs>
 <20241213144740.GA17593@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213144740.GA17593@lst.de>

On Fri, Dec 13, 2024 at 03:47:40PM +0100, Christoph Hellwig wrote:
> On Thu, Dec 12, 2024 at 12:40:07PM -0800, Darrick J. Wong wrote:
> > > However, I still think that we should be able to atomic write mixed extents,
> > > even though it is a pain to implement. To that end, I could be convinced
> > > again that we don't require it...
> > 
> > Well... if you /did/ add a few entries to include/uapi/linux/fs.h for
> > ways that an untorn write can fail, then we could define the programming
> > interface as so:
> > 
> > "If you receive -EBADMAP, then call fallocate(FALLOC_FL_MAKE_OVERWRITE)
> > to force all the mappings to pure overwrites."
> 
> Ewwwwwwwwwwwwwwwwwwwww.
> 
> That's not a sane API in any way.

Oh I know, I'd much rather stick to the view that block untorn writes
are a means for programs that only ever do IO in large(ish) blocks to
take advantage of a hardware feature that also wants those large
blocks.  And only if the file mapping is in the correct state, and the
program is willing to *maintain* them in the correct state to get the
better performance.  I don't want xfs to grow code to write zeroes to
mapped blocks just so it can then write-untorn to the same blocks.

The gross part is that I think if you want to do untorn multi-fsblock
writes, then you need forcealign.  In turn, forcealign has to handle COW
of shared blocks.  willy and I looked through the changes I made to
support dirtying and writing back gangs of pages for rtreflink when the
rtextsize > 1, and didn't find anything insane in there.  Using that to
handle COWing forcealign file blocks should work, though things get
tricky once you add atomic untorn writes because we can't split bios.

Everything else I think should use exchange-range because it has so many
fewer limitations.

--D

> > ...since there have been a few people who have asked about that ability
> > so that they can write+fdatasync without so much overhead from file
> > metadata updates.
> 
> And all of them fundamentally misunderstood file system semantics and/or
> used weird bypasses that are dommed to corrupt the file system sooner
> or later.

