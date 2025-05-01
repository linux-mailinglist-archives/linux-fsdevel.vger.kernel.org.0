Return-Path: <linux-fsdevel+bounces-47871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D65AA6475
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 21:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 642A81BC7C2A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 19:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F02323770D;
	Thu,  1 May 2025 19:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvxxJahx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DF5235069;
	Thu,  1 May 2025 19:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746129229; cv=none; b=tVKVT0ckchcf3hUEcRsO7ioFYLL06F9jSNf2wFvzUadRQJhz0nru+dC9HuUULT0kCzyuNPqTSgrAoL4tzAsn15Azef8QV9cxD13QMBZEorpLydbh6Ns5r9YIBT8+X3uuBi1rjOmNQHXEx+MANjQtt/s7XswLhqc6veznZEEdLng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746129229; c=relaxed/simple;
	bh=yseky+6nMqu8zW66EyDaMuMbkyGJiRf5HJSmPi71rhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxvumCUXWqVG1nFGNyeRj2KmGQjZy2Ju2cdEvff3/eTAAOwCGbwQMvMhRbaIsK4oUA5xCJr6FWecADDD2lQjSC/jaz9++U75V7PCF3T4mK/t6VHhxdgxe9RTfW/P6k7sApxfU9TdhiFacMRST5tG/ciNDtRFmIAf0zM77PyRxdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvxxJahx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE4BC4CEE3;
	Thu,  1 May 2025 19:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746129229;
	bh=yseky+6nMqu8zW66EyDaMuMbkyGJiRf5HJSmPi71rhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FvxxJahxj98DdcATmX2NuCi1yRRapON+UkQuq2EiTPHM66kagvudZv0QRTYPgb1bo
	 tpTeKwW86JGfmy9YzQLp8bkghVS7xDB3GtIRJO6tJxE8ofebqIsY88kvldxgEXhOuG
	 jN0xaG0APqnaXZA6oGT7uM80Ejk8Rfw73E9Z74BMt/pAUKybG97jyNyRgUwb7qB4rI
	 1XiNEbIDwlwzjEucfPcx8yQcWqfJd9KI6RvIwXddeMZoKtv5jJ7VXEg/q5MBQQhRJo
	 178cgoqG/UlzaBM/sic9EjAZ7QdiWh6dk8SmGzav4BSf1NZIIFZv/nvWKISh6BLkUI
	 m17w/bJ4ZMKsg==
Date: Thu, 1 May 2025 12:53:48 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: John Garry <john.g.garry@oracle.com>, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, cem@kernel.org,
	linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v9 05/15] xfs: ignore HW which cannot atomic write a
 single block
Message-ID: <20250501195348.GH25675@frogsfrogsfrogs>
References: <20250425164504.3263637-1-john.g.garry@oracle.com>
 <20250425164504.3263637-6-john.g.garry@oracle.com>
 <20250429122105.GA12603@lst.de>
 <20250429144446.GD25655@frogsfrogsfrogs>
 <20250430125906.GB834@lst.de>
 <20250501162216.GB25675@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501162216.GB25675@frogsfrogsfrogs>

On Thu, May 01, 2025 at 09:22:16AM -0700, Darrick J. Wong wrote:
> On Wed, Apr 30, 2025 at 02:59:06PM +0200, Christoph Hellwig wrote:
> > On Tue, Apr 29, 2025 at 07:44:46AM -0700, Darrick J. Wong wrote:
> > > > So this can't be merged into xfs_setsize_buftarg as suggeted last round
> > > > instead of needing yet another per-device call into the buftarg code?
> > > 
> > > Oh, heh, I forgot that xfs_setsize_buftarg is called a second time by
> > > xfs_setup_devices at the end of fill_super.
> > 
> > That's actually the real call.  The first is just a dummy to have
> > bt_meta_sectorsize/bt_meta_sectormask initialized because if we didn't
> > do that some assert in the block layer triggered.  We should probably
> > remove that call and open code the two assignments..
> > 
> > > I don't like the idea of merging the hw atomic write detection into
> > > xfs_setsize_buftarg itself because (a) it gets called for the data
> > > device before we've read the fs blocksize so the validation is
> > > meaningless and (b) that makes xfs_setsize_buftarg's purpose less
> > > cohesive.
> > 
> > As explained last round this came up I'd of course rename it if
> > we did that.  But I can do that later.
> 
> <nod> Would you be willing to review this patch as it is now and either
> you or me can just tack a new cleanup patch on the end?  I tried writing
> a patch to clean this up, but ran into questions:
> 
> At first I thought that the xfs_setsize_buftarg call in
> xfs_alloc_buftarg could be replaced by open-coding the bt_meta_sector*
> assignment, checking that bdev_validate_blocksize is ok, and dropping
> the sync_blockdev.
> 
> Once we get to xfs_setup_devices, we can call xfs_setsize_buftarg on the
> three buftargs, and xfs_setsize_buftarg will configure the atomic writes
> geometry.
> 
> But then as I was reading the patch, it occurred to me that at least for
> the data device, we actually /do/ want that sync_blockdev call so that
> any dirty pagecache for the superblock actually get written to disk.
> Maybe that can go at the end of xfs_open_devices?  But would it be
> preferable to sync all the devices prior to trying to read the primary
> sb?  I don't think there's a need, but maybe someone else has a
> different viewpoint?

Eh, since John posted a V10 I'll just tack my new patches on the end of
that so everyone can look at them.

--D

