Return-Path: <linux-fsdevel+bounces-15963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF668962E1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 05:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55D0E285902
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 03:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E296224C6;
	Wed,  3 Apr 2024 03:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGGu6ngP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6065F1BF5C;
	Wed,  3 Apr 2024 03:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712114351; cv=none; b=JV3r1H6o2lF/uO5Jd6uChWZCdNK+fdpWpY2w8DWDuITti/6UCo3VILmwJq1/u2ZMnXtpOi4VqnIOwOAdqRtqgo7wLiWmpXbJQI1w04bu+kV3TGpQ125stz2Fqrmhprn8ynKqjJr7Hb47EUVZ0/exXYHpPhr/l0rdlXZMv0SoufU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712114351; c=relaxed/simple;
	bh=0ii2xyB6wjXqNNBKh4pHdJBXfPI3+uhqMoqBXBnA9Bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2z2Y0spnnzrtoKugeAcHKjgFnlvop8d9RFMIuTBIjJC44K7eubBBBLaEfDmpdjsLBRt095EdjP+VgFUP/YyIjfAugGm4r/1PQfZFH2MZJ1pIz4fV5J9dZAS3vG+78lWOvBUytBO/21+WLua5nqqQiLpQmKTdCZPSvlYYn/UV6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGGu6ngP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A92C433F1;
	Wed,  3 Apr 2024 03:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712114351;
	bh=0ii2xyB6wjXqNNBKh4pHdJBXfPI3+uhqMoqBXBnA9Bo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FGGu6ngPhgKkmY7QboSq86OG2FgPy4LcycVuMxuo4zHhbpueruVmAtav344nWxnyZ
	 GedcjFDMtLtnYOJiuHTrMs2rcquU53MO5zRlFqQtBqNggwOzoOzCTDZHx6JRevGs/z
	 9iCWe/tuzpy0lsYqMdPdKRDV86FLv2nukAFLinfxy/9Az66Oq5nCClONa7UlV459G2
	 9rdFVtP5ACVbFn5hJD2e3EDD/u5wJH6gAP2+mQJxrtKeNaGyHft90pQXr3ZgSIrlzN
	 SdlGoX5pdonl5PXxRV7mrhEX1n+taI+q9a7cjv4CTqCK7DurLvo+4Edyp90nm38CrJ
	 JMXQyJ8LJw3eg==
Date: Tue, 2 Apr 2024 20:19:10 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Colin Walters <walters@verbum.org>, Eric Biggers <ebiggers@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	xfs <linux-xfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
	fsverity@lists.linux.dev, Alexander Larsson <alexl@redhat.com>
Subject: Re: [PATCH 28/29] xfs: allow verity files to be opened even if the
 fsverity metadata is damaged
Message-ID: <20240403031910.GH6390@frogsfrogsfrogs>
References: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
 <171175869022.1988170.16501260874882118498.stgit@frogsfrogsfrogs>
 <2afcf2b2-992d-4678-bf68-d70dce0a2289@app.fastmail.com>
 <20240402225216.GW6414@frogsfrogsfrogs>
 <992e84c7-66f5-42d2-a042-9a850891b705@app.fastmail.com>
 <20240403013903.GG6390@frogsfrogsfrogs>
 <Zgy3+ljJME0pky3d@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zgy3+ljJME0pky3d@dread.disaster.area>

On Wed, Apr 03, 2024 at 12:59:22PM +1100, Dave Chinner wrote:
> On Tue, Apr 02, 2024 at 06:39:03PM -0700, Darrick J. Wong wrote:
> > On Tue, Apr 02, 2024 at 08:10:15PM -0400, Colin Walters wrote:
> > > >> I hesitate to say it but maybe there should be some ioctl for online
> > > >> repair use cases only, or perhaps a new O_NOVERITY special flag to
> > > >> openat2()?
> > > >
> > > > "openat2 but without meddling from the VFS"?  Tempting... ;)
> > > 
> > > Or really any lower level even filesystem-specific API for the online
> > > fsck case.  Adding a blanket new special case for all CAP_SYS_ADMIN
> > > processes covers a lot of things that don't need that.
> > 
> > I suppose there could be an O_NOVALIDATION to turn off data checksum
> > validation on btrfs/bcachefs too.  But then you'd want to careful
> > controls on who gets to use it.  Maybe not liblzma_la-crc64-fast.o.
> 
> Just use XFS_IOC_OPEN_BY_HANDLE same as xfs_fsr and xfsdump do. The
> handle can be build in userspace from the inode bulkstat
> information, and for typical inode contents verification purposes we
> don't actually need path-based open access to the inodes. That would
> then mean we can simple add our own open flag to return a fd that
> can do data operations that short-circuit verification...

Heh, ok.  Are there any private flags that get passed via
xfs_fsop_handlereq_t::oflags?  Or does that mean defining a top level
O_FLAG that cannot be passed through openat but /can/ be sent via
open_by_handle?

--D

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

