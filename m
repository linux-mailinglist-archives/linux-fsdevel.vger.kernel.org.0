Return-Path: <linux-fsdevel+bounces-1240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E697D823F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 14:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D050282037
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 12:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507AE2D7B4;
	Thu, 26 Oct 2023 12:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8E+oN8l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE2B2D04E
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 12:07:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09BDFC433C8;
	Thu, 26 Oct 2023 12:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698322062;
	bh=zCKmL3xJnMB9gENZ9sAOcOWK60ND1XtBlXDEAsaCgto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W8E+oN8lfiCuBD4qlKWBmonfQ4p+b41zbagD3/LJZNciR9F3yUWkZfNfi9qWyUpoU
	 gNRGgEcjAs+n6INR2B9yBtj+hFK5bqhPUjjKFaE9Lf98MqL8pUo7SU/3K/Rqr0UP6R
	 eqMp1xc3qe/JwcX6+kauVCds7TAVhKNqyCzbZWGR53/ZpqubK1qsFwhU2BCu3XAr5j
	 iVcFZ5+gl+Ir0TPKXt0l+moKdxGpK7ITtL8SQYh3qbliw+ia31phExcA+qrbwDhPIM
	 Yj7L/aTQIUi4gtNb3dfRBv7+nw2+t6Yt1x6b0IT8P6eoSCdcNJCTXKOeGQj1sN8+qo
	 1upBXJF14zypw==
Date: Thu, 26 Oct 2023 14:07:38 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 0/6] fs,block: yield devices
Message-ID: <20231026-marsch-tierzucht-0221d75b18ea@brauner>
References: <20231024-vfs-super-rework-v1-0-37a8aa697148@kernel.org>
 <20231025172057.kl5ajjkdo3qtr2st@quack3>
 <20231025-ersuchen-restbetrag-05047ba130b5@brauner>
 <20231026103503.ldupo3nhynjjkz45@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231026103503.ldupo3nhynjjkz45@quack3>

On Thu, Oct 26, 2023 at 12:35:03PM +0200, Jan Kara wrote:
> On Wed 25-10-23 22:46:29, Christian Brauner wrote:
> > On Wed, Oct 25, 2023 at 07:20:57PM +0200, Jan Kara wrote:
> > > Hello!
> > > 
> > > On Tue 24-10-23 16:53:38, Christian Brauner wrote:
> > > > This is a mechanism that allows the holder of a block device to yield
> > > > device access before actually closing the block device.
> > > > 
> > > > If a someone yields a device then any concurrent opener claiming the
> > > > device exclusively with the same blk_holder_ops as the current owner can
> > > > wait for the device to be given up. Filesystems by default use
> > > > fs_holder_ps and so can wait on each other.
> > > > 
> > > > This mechanism allows us to simplify superblock handling quite a bit at
> > > > the expense of requiring filesystems to yield devices. A filesytems must
> > > > yield devices under s_umount. This allows costly work to be done outside
> > > > of s_umount.
> > > > 
> > > > There's nothing wrong with the way we currently do things but this does
> > > > allow us to simplify things and kills a whole class of theoretical UAF
> > > > when walking the superblock list.
> > > 
> > > I'm not sure why is it better to create new ->yield callback called under
> > > sb->s_umount rather than just move blkdev_put() calls back into
> > > ->put_super? Or at least yielding could be done in ->put_super instead of
> > 
> > The main reason was to not call potentially expensive
> > blkdev_put()/bdev_release() under s_umount. If we don't care about this
> > though then this shouldn't be a problem.
> 
> So I would not be really concerned about performance here. The superblock
> is dying, nobody can do anything about that until the superblock is fully
> dead and cleaned up. Maybe some places could skip such superblocks more
> quickly but so far I'm not convinced it matters in practice (e.g. writeback
> holds s_umount over the whole sync(1) time and nobody complains). And as
> you mention below, we have been doing this for a long time without anybody
> really complaining.

Ok, that's a good point.

> 
> > And yes, then we need to move
> > blkdev_put()/bdev_release() under s_umount including the main block
> > device. IOW, we need to ensure that all bdev calls are done under
> > s_umount before we remove the superblock from the instance list.
> 
> This is about those seemingly spurious "device busy" errors when the
> superblock hasn't closed its devices yet, isn't it?  But we now remove

Yes, because we tie superblock and block device neatly together.

> superblock from s_instances list in kill_super_notify() and until that
> moment SB_DYING is protecting us from racing mounts. So is there some other
> problem?

No, there isn't a problem at all. It's all working fine but it was
initially a little annoying as we had to update filesystems to ensure
that sb->s_fs_info is kept alive. But it's all fixed.

The possible advantage is that if we drop all block devices under
s_umount then we can remove the superblock from fs_type->s_instances in
the old location again. I'm not convinced it's worth it but it's a
possible simplification. I'm not even arguing it's objectively better I
think it's a matter of taste in the end.

> 
> > I think
> > that should be fine but I wanted to propose an alternative to that as
> > well: cheap mark-for-release under s_umount and heavy-duty without
> > s_umount. But I guess it doesn't matter because most filesystems did use
> > to close devices under s_umount before anyway. Let me know what you
> > think makes the most sense.
> 
> I think we should make it as simple as possible for filesystems. As I said

Yes, I fully agree.

The really good thing about the current mechanism is that it's
completely vfs-only. With s_umount/open_mutex ordering fixed filesystems
can now close block devices wherever and the vfs will ensure that you
don't get spurious ebusy. And the filesystem doesn't have to know a
thing about it or take any care.

> above I don't think s_umount hold time really matters so the only thing
> that limits us are locking constraints. During superblock shutdown the only
> thing that currently cannot be done under s_umount (that I'm aware of) is the
> teardown of the sb->s_bdi because that waits for writeback threads and
> those can be blocked waiting for s_umount.

Which we don't need to change if it's working fine.

> 
> So if we wanted we could just move ext4 & xfs bdev closing back into
> ->put_super to avoid ext4_kill_sb() and somewhat slim down xfs_mount_free()
> but otherwise I don't see much space for simplification or need for adding
> more callbacks :)

I mean, that I would only think is useful if we really wanted to close
all block devices under s_umount to possible be remove the waiting
mechanism we have right now. Otherwise I think it's churn for the sake
of churn and I quite like what we have right now.

