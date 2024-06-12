Return-Path: <linux-fsdevel+bounces-21542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC6090573B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 17:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AF281F27E08
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 15:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CB4180A77;
	Wed, 12 Jun 2024 15:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Usgv+C/e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148361802D7;
	Wed, 12 Jun 2024 15:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718207024; cv=none; b=gSbbVer5HOmpEuusFNkVfVYCUWMNPA5zzMgIyAXNsMPThYUp1mRxeK2qVjHik0PQqoNXjngfPxp8JtfVWWcc/Z92EkyuQh80fAg+bv55MG1UZlYL5OrWQnsm4eO3NIK6wD8YMEw4zC2Or76wnRvw0bxQsNyWL6miLbimYA3YU3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718207024; c=relaxed/simple;
	bh=viWgeyD653r31MiLWhNh3LFZNvBZzTGpeJJoQhAvSz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+VMZEtQAaPUPcLfBPJnHW4Hm4sgPD3TcHXjIzrp2On4FgxOMVU+IbKA95yiyFlhobHtxzTtmIBsmC1VTFIxYUpNTSODA4HhHfq3HLIkET/7oj+MWbtO/fRaHIv/icd107FMesO7AiOTeV0KASAQPpJ5LMkmWGyqVUI8ua5VrW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Usgv+C/e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84387C116B1;
	Wed, 12 Jun 2024 15:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718207023;
	bh=viWgeyD653r31MiLWhNh3LFZNvBZzTGpeJJoQhAvSz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Usgv+C/eWKPNVB/O70oZtRo7hZ1YUmaavo22jrWBVrIBUr+0SA8gMhgwRRMtfBvLH
	 ncSICA4si0AJgTjQoXpGrai5D/sZRz6pQCHJpYNWuas4ZclFuORK04RbVDobc+2/Iw
	 0Zz/bZuxg01mNo6ffpOtgrID37SxaPf2QIF39XOzWnE+Hk4sqC0HegVnNjo7TGl4Tc
	 hrW8BT1zN5o1XZqmfFVmZUJa4O08515lRI035ztq0ZG7xgb6cybUHYQHgrt1EhLnm6
	 gZhqsBWH3qv5Q+Wj27xW5mXGiXcWIK3c/Y0ngyWiZeYzl1oCjjQ9msCs4NLUN7kSRX
	 Nn2LXiCSfn9aw==
Date: Wed, 12 Jun 2024 08:43:42 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Long Li <leo.lilong@huawei.com>, david@fromorbit.com, hch@lst.de,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	chandan.babu@oracle.com, willy@infradead.org, axboe@kernel.dk,
	martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com, mcgrof@kernel.org,
	p.raghav@samsung.com, linux-xfs@vger.kernel.org,
	catherine.hoang@oracle.com
Subject: Re: [PATCH v3 08/21] xfs: Introduce FORCEALIGN inode flag
Message-ID: <20240612154342.GC2764752@frogsfrogsfrogs>
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
 <20240429174746.2132161-9-john.g.garry@oracle.com>
 <20240612021058.GA729527@ceph-admin>
 <82269717-ab49-4a02-aaad-e25a01f15768@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82269717-ab49-4a02-aaad-e25a01f15768@oracle.com>

On Wed, Jun 12, 2024 at 07:55:31AM +0100, John Garry wrote:
> On 12/06/2024 03:10, Long Li wrote:
> > On Mon, Apr 29, 2024 at 05:47:33PM +0000, John Garry wrote:
> > > From: "Darrick J. Wong"<djwong@kernel.org>
> > > 
> > > Add a new inode flag to require that all file data extent mappings must
> > > be aligned (both the file offset range and the allocated space itself)
> > > to the extent size hint.  Having a separate COW extent size hint is no
> > > longer allowed.
> > > 
> > > The goal here is to enable sysadmins and users to mandate that all space
> > > mappings in a file must have a startoff/blockcount that are aligned to
> > > (say) a 2MB alignment and that the startblock/blockcount will follow the
> > > same alignment.
> > > 
> > > jpg: Enforce extsize is a power-of-2 and aligned with afgsize + stripe
> > >       alignment for forcealign
> > > Signed-off-by: "Darrick J. Wong"<djwong@kernel.org>
> > > Co-developed-by: John Garry<john.g.garry@oracle.com>
> > > Signed-off-by: John Garry<john.g.garry@oracle.com>
> > > ---
> > >   fs/xfs/libxfs/xfs_format.h    |  6 ++++-
> > >   fs/xfs/libxfs/xfs_inode_buf.c | 50 +++++++++++++++++++++++++++++++++++
> > >   fs/xfs/libxfs/xfs_inode_buf.h |  3 +++
> > >   fs/xfs/libxfs/xfs_sb.c        |  2 ++
> > >   fs/xfs/xfs_inode.c            | 12 +++++++++
> > >   fs/xfs/xfs_inode.h            |  2 +-
> > >   fs/xfs/xfs_ioctl.c            | 34 +++++++++++++++++++++++-
> > >   fs/xfs/xfs_mount.h            |  2 ++
> > >   fs/xfs/xfs_super.c            |  4 +++
> > >   include/uapi/linux/fs.h       |  2 ++
> > >   10 files changed, 114 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
> > > index 2b2f9050fbfb..4dd295b047f8 100644
> > > --- a/fs/xfs/libxfs/xfs_format.h
> > > +++ b/fs/xfs/libxfs/xfs_format.h
> > > @@ -353,6 +353,7 @@ xfs_sb_has_compat_feature(
> > >   #define XFS_SB_FEAT_RO_COMPAT_RMAPBT   (1 << 1)		/* reverse map btree */
> > >   #define XFS_SB_FEAT_RO_COMPAT_REFLINK  (1 << 2)		/* reflinked files */
> > >   #define XFS_SB_FEAT_RO_COMPAT_INOBTCNT (1 << 3)		/* inobt block counts */
> > > +#define XFS_SB_FEAT_RO_COMPAT_FORCEALIGN (1 << 30)	/* aligned file data extents */
> > Hi, John
> > 
> > You know I've been using and testing your atomic writes patch series recently,
> > and I'm particularly interested in the changes to the on-disk format. I noticed
> > that XFS_SB_FEAT_RO_COMPAT_FORCEALIGN uses bit 30 instead of bit 4, which would
> > be the next available bit in sequence.
> > 
> > I'm wondering if using bit 30 is just a temporary solution to avoid conflicts,
> > and if the plan is to eventually use bits sequentially, for example, using bit 4?
> > I'm looking forward to your explanation.
> 
> I really don't know. I'm looking through the history and it has been like
> that this the start of my source control records.
> 
> Maybe it was a copy-and-paste error from XFS_FEAT_FORCEALIGN, whose value
> has changed since.
> 
> Anyway, I'll ask a bit more internally, and I'll look to change to (1 << 4)
> if ok.

I tend to use upper bits for ondisk features that are still under
development so that (a) there won't be collisions with other features
getting merged and (b) after the feature I'm working on gets merged, any
old fs images in my zoo will no longer mount.

--D

> Thanks,
> John
> 

