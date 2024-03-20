Return-Path: <linux-fsdevel+bounces-14851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B85E788093C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 02:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 746B4283FD2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 01:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC19279FE;
	Wed, 20 Mar 2024 01:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjbzolXh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDAD7464;
	Wed, 20 Mar 2024 01:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710899368; cv=none; b=tabaOwZxFrpOQeLfbNPMjzhzYkKZ9/WY7Ny0LmrMDrWyj9Cp7JkHa1vrxhdWXQXAg1NW1n2x3ySdNowclOopetbLnmpdOab8Q5YTCyUJ62mhLNSaMK9rhuznZDzcJojktnf6bVaE66+PhGHSYYNo+7rF1vQPbQGMWv9AMdmPQQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710899368; c=relaxed/simple;
	bh=P+xOin5dGZ4GaniipK30HqG2ktCQwuPC/n57ZbiXppM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zu0ICq6KvoSPuf89XvuCzXharuGIO0cixAUXmzICPomeRK0sneiW+Rzq6Fjx6oaSWFMiTu+KYOMRAqhJLOyJTS4aaTxWMG88LEatvPuShQ16j9jjvpDWUnhO6N4+L+YK3ZTMHGblw/6T8zQ4+EiKvsAzVt/tdHYH1UO+5Wr+zTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjbzolXh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C03C433C7;
	Wed, 20 Mar 2024 01:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710899367;
	bh=P+xOin5dGZ4GaniipK30HqG2ktCQwuPC/n57ZbiXppM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sjbzolXhEiJUY+t3wAhyS0phc5T83NDCfJXFQNahxsWBcGJ3prS+19CHlzsu+ZOPY
	 dezPg0TVkppu4MdGjZQNtDwu+SMuteP1iSaVOf8JqGEdhEgPLt38RbmUUDLP37H2AD
	 38XehjBo9s382bQ3bmAwv63dLmhqovQflmnmmSsiR3vE6SwVou1ueeqHyspjzMl7GD
	 UvPhiLmDSD5IEy4SitSAvdrtN+1C7e2i1kcj/iH54Umzj6tYv9mQkrO2NM54/tYgVY
	 r+LBl9gr27FdU7ZnNtzk+2+mvzqzW84yJbN7AC6CwV5Vg9I5MiG3jTLKTx9jrKr0Nh
	 iPi75nzRcUzqQ==
Date: Tue, 19 Mar 2024 18:49:27 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: "Kiselev, Oleg" <okiselev@amazon.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Theodore Ts'o <tytso@mit.edu>,
	"torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 3/3] ext4: Add support for FS_IOC_GETFSSYSFSPATH
Message-ID: <20240320014927.GT6184@frogsfrogsfrogs>
References: <20240315035308.3563511-1-kent.overstreet@linux.dev>
 <20240315035308.3563511-4-kent.overstreet@linux.dev>
 <20240315164550.GD324770@mit.edu>
 <l3dzlrzaekbxjryazwiqtdtckvl4aundfmwff2w4exuweg4hbc@2zsrlptoeufv>
 <A0A342BA-631D-4D6E-B6D2-692A45509F63@amazon.com>
 <Zfi+v/9vF+mfZ4Bl@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zfi+v/9vF+mfZ4Bl@dread.disaster.area>

On Tue, Mar 19, 2024 at 09:22:55AM +1100, Dave Chinner wrote:
> On Mon, Mar 18, 2024 at 09:51:04PM +0000, Kiselev, Oleg wrote:
> > On 3/15/24, 09:51, "Kent Overstreet" <kent.overstreet@linux.dev <mailto:kent.overstreet@linux.dev>> wrote:
> > > On Fri, Mar 15, 2024 at 12:45:50PM -0400, Theodore Ts'o wrote:
> > > > On Thu, Mar 14, 2024 at 11:53:02PM -0400, Kent Overstreet wrote:
> > > > > the new sysfs path ioctl lets us get the /sys/fs/ path for a given
> > > > > filesystem in a fs agnostic way, potentially nudging us towards
> > > > > standarizing some of our reporting.
> > > > >
> > > > > --- a/fs/ext4/super.c
> > > > > +++ b/fs/ext4/super.c
> > > > > @@ -5346,6 +5346,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
> > > > > sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP | QTYPE_MASK_PRJ;
> > > > > #endif
> > > > > super_set_uuid(sb, es->s_uuid, sizeof(es->s_uuid));
> > > > > + super_set_sysfs_name_bdev(sb);
> > > >
> > > > Should we perhaps be hoisting this call up to the VFS layer, so that
> > > > all file systems would benefit?
> > >
> > >
> > > I did as much hoisting as I could. For some filesystems (single device
> > > filesystems) the sysfs name is the block device, for the multi device
> > > filesystems I've looked at it's the UUID.
> > 
> > Why not use the fs UUID for all cases, single device and multi device?
> 
> Because the sysfs directory heirachy has already been defined for
> many filesystems, and technically sysfs represents a KABI that we
> can't just break for the hell of it.
> 
> e.g. changing everything to use uuid will break fstests
> infrastructure because it assumes that it can derive the sysfs dir
> location for the filesystem from the *device name* the filesystem is
> mounted on. btrfs has a special implementation of that derivation
> that runs the btrfs command to retreive the UUID of the filesysem.
> 
> So, yes, while we could technically change it, we break anything in
> userspace that has introduced a dependency on bdev name as the sysfs
> fs identifier. We're not going to break userspace like this,
> especially as it is trivial to avoid.

Wellll... some day in the far kumbaya future, everyone will call
GETSYSFSPATH and they won't have to know or care what each fs does under
the covers.  So who cares? 8-)

How about using sysfs_create_link for non -o nouuid filesystems so that
/sys/fs/xfs/$uuid actually goes somewhere?

<shrug> Don't really care much myself either way.

--D

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

