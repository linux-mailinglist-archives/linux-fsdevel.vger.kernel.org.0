Return-Path: <linux-fsdevel+bounces-47832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B32EAA6150
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 18:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAD591BA5B93
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 16:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88626211499;
	Thu,  1 May 2025 16:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NoeNHc6M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B793820297D;
	Thu,  1 May 2025 16:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746116537; cv=none; b=pCUN9hpDO6Lym3cgQLnECFUZSr7ZNC9eauGAkqfSsOCBqZ0nJrx9VJjMgxZQztmt+I3zsObaapbIqatu7Mjw+L2k/f8Dvs7uimR1pixtLGC1192u02PT9wii76Rz4WbXT32h/3JgAxArehDR+PmLTESqAkxJVInKPlVq6ahDh6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746116537; c=relaxed/simple;
	bh=7mGDLReut9Z4ueLGijvozal54uog/fy6GCv7gOrGGLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PsyL1xlLNuc3lfhW9ZtZCmKL358BzBdMOjxJcE789wupC456B+NQognS7ooRBtjISn/HGTmCnMZyaRvc1UC4JHwpwEOk0ywuarn0ZUKjmOTtHcB0bZ+eo3bTEOesHTHT4xV3V7pHYLdb2HSI9a1bjqriyuFLRSTD4WlE4cSQVAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NoeNHc6M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2F8C4CEE3;
	Thu,  1 May 2025 16:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746116537;
	bh=7mGDLReut9Z4ueLGijvozal54uog/fy6GCv7gOrGGLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NoeNHc6MRswVTdN4Sxr8t/6h602Ehbvkb5m0zKRHq+vu/rv0dzFvu9R2VsSyH59h5
	 kAXaY8Es7LBTkaasyfrUV0D9HPSmdIn8O3riyEC6jdDMOaboz9x2GhWwQj8h6fOoiX
	 L2/l88SAMUXEK8O5PUg0SYuOeCQWF8vmZYU6sJ5Kg/1RaVOtgqdSIBhbCBBNhaSkto
	 /2Orx3ST25iaQ4+zt9zG4EvAziJ08IsOUvGOJBRDnTYPKwdF62YUOg2pnOx6MntBsZ
	 FXLaMDb0ojHFIUGRbInCeQqMFSohD1L+u8nNHydWai1d0qbaMPC2ODItM5zPsFXMmo
	 znP8R4oRtF2hA==
Date: Thu, 1 May 2025 09:22:16 -0700
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
Message-ID: <20250501162216.GB25675@frogsfrogsfrogs>
References: <20250425164504.3263637-1-john.g.garry@oracle.com>
 <20250425164504.3263637-6-john.g.garry@oracle.com>
 <20250429122105.GA12603@lst.de>
 <20250429144446.GD25655@frogsfrogsfrogs>
 <20250430125906.GB834@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430125906.GB834@lst.de>

On Wed, Apr 30, 2025 at 02:59:06PM +0200, Christoph Hellwig wrote:
> On Tue, Apr 29, 2025 at 07:44:46AM -0700, Darrick J. Wong wrote:
> > > So this can't be merged into xfs_setsize_buftarg as suggeted last round
> > > instead of needing yet another per-device call into the buftarg code?
> > 
> > Oh, heh, I forgot that xfs_setsize_buftarg is called a second time by
> > xfs_setup_devices at the end of fill_super.
> 
> That's actually the real call.  The first is just a dummy to have
> bt_meta_sectorsize/bt_meta_sectormask initialized because if we didn't
> do that some assert in the block layer triggered.  We should probably
> remove that call and open code the two assignments..
> 
> > I don't like the idea of merging the hw atomic write detection into
> > xfs_setsize_buftarg itself because (a) it gets called for the data
> > device before we've read the fs blocksize so the validation is
> > meaningless and (b) that makes xfs_setsize_buftarg's purpose less
> > cohesive.
> 
> As explained last round this came up I'd of course rename it if
> we did that.  But I can do that later.

<nod> Would you be willing to review this patch as it is now and either
you or me can just tack a new cleanup patch on the end?  I tried writing
a patch to clean this up, but ran into questions:

At first I thought that the xfs_setsize_buftarg call in
xfs_alloc_buftarg could be replaced by open-coding the bt_meta_sector*
assignment, checking that bdev_validate_blocksize is ok, and dropping
the sync_blockdev.

Once we get to xfs_setup_devices, we can call xfs_setsize_buftarg on the
three buftargs, and xfs_setsize_buftarg will configure the atomic writes
geometry.

But then as I was reading the patch, it occurred to me that at least for
the data device, we actually /do/ want that sync_blockdev call so that
any dirty pagecache for the superblock actually get written to disk.
Maybe that can go at the end of xfs_open_devices?  But would it be
preferable to sync all the devices prior to trying to read the primary
sb?  I don't think there's a need, but maybe someone else has a
different viewpoint?

--D

