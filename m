Return-Path: <linux-fsdevel+bounces-54544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08914B00B8D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 20:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F043F4A8793
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 18:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6867E2FCE3D;
	Thu, 10 Jul 2025 18:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YR3JBw0d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF95D1E8333;
	Thu, 10 Jul 2025 18:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752172886; cv=none; b=Dez44LtrwX4c8NKX92Rl44xk/AdZg8T5USCI8jlz69zP5JzXBoenBTT4q9a4lD5n3AS25Mo4WKOCTKtJT9IgdqvRZ90P1v0k80ibQY2BGxW6PsCerDy65sb3Twh9J4I1YzqYUh39aWkwCM/uQ2MyLq3FceHDRbda+SO2zzrO4qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752172886; c=relaxed/simple;
	bh=nSYtxsroVKUHT9UvaB/DZeOq2Pt7+h1yZzB58Fh4XdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uw/sp/sKzuQLTrcwSDrRCr+g2u+GJ7BVWeYRAuFhEC/PDDxye0bn7lgEnw6XKV6IUGuz2Yjsaa09O82AZbghXzy0IcsrHmrEXJ125Ydm3cWbNonUc19HsJB9Bp0wWqo76cZYT+5Li89fIfuegWPNIpmH+sz94op9133Pd3pD9Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YR3JBw0d; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 10 Jul 2025 14:41:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752172882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4BIQ0YzbWgDLZuTNtQ8L6nBVEh6ENrzY2g79PLtP8UI=;
	b=YR3JBw0dNQxWT8gbfOrQApQA3Dr/mncyvyWlhdULFlpmatye4WQWSGg+jo14ol4mS36JHY
	HHEptsY8mnK7lMtHhlgU9ZWw06YTXudIOiL3YY7WVl8TqHFp7dZrbySpEs9bEUWoszkMXv
	xx0hqlX1kXJ+NYMyOY8UTChQdDIsxs0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Jan Kara <jack@suse.cz>
Cc: Dave Chinner <david@fromorbit.com>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, 
	Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH v4 1/6] fs: enhance and rename shutdown() callback to
 remove_bdev()
Message-ID: <5xno4s25lsd2sqq6judn7moorgy2h3konejgassnzlccfa6jsf@ez6ciofy3bwp>
References: <343vlonfhw76mnbjnysejihoxsjyp2kzwvedhjjjml4ccaygbq@72m67s3e2ped>
 <y2rpp6u6pksjrzgxsn5rtcsl2vspffkcbtu6tfzgo7thn7g23p@7quhaixfx5yh>
 <kgolzhhd47x3iqkdrwyzh65ng4mm6cauxdjgiao2otztncyc3f@rskadwaph2l5>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kgolzhhd47x3iqkdrwyzh65ng4mm6cauxdjgiao2otztncyc3f@rskadwaph2l5>
X-Migadu-Flow: FLOW_OUT

On Thu, Jul 10, 2025 at 03:10:04PM +0200, Jan Kara wrote:
> On Wed 09-07-25 13:49:12, Kent Overstreet wrote:
> > On Wed, Jul 09, 2025 at 07:23:07PM +0200, Jan Kara wrote:
> > > > It also avoids the problem of ->mark_dead events being generated
> > > > from a context that holds filesystem/vfs locks and then deadlocking
> > > > waiting for those locks to be released.
> > > > 
> > > > IOWs, a multi-device filesystem should really be implementing
> > > > ->mark_dead itself, and should not be depending on being able to
> > > > lock the superblock to take an active reference to it.
> > > > 
> > > > It should be pretty clear that these are not issues that the generic
> > > > filesystem ->mark_dead implementation should be trying to
> > > > handle.....
> > > 
> > > Well, IMO every fs implementation needs to do the bdev -> sb transition and
> > > make sb somehow stable. It may be that grabbing s_umount and active sb
> > > reference is not what everybody wants but AFAIU btrfs as the second
> > > multi-device filesystem would be fine with that and for bcachefs this
> > > doesn't work only because they have special superblock instantiation
> > > behavior on mount for independent reasons (i.e., not because active ref
> > > + s_umount would be problematic for them) if I understand Kent right.
> > > So I'm still not fully convinced each multi-device filesystem should be
> > > shipping their special method to get from device to stable sb reference.
> > 
> > Honestly, the sync_filesystem() call seems bogus.
> > 
> > If the block device is truly dead, what's it going to accomplish?
> 
> Notice that fs_bdev_mark_dead() calls sync_filesystem() only in case
> 'surprise' argument is false - meaning this is actually a notification
> *before* the device is going away. I.e., graceful device hot unplug when
> you can access the device to clean up as much as possible.

That doesn't seem to be hooked up to anything?

blk_mark_disk_dead() -> blk_report_disk_dead(), surprise is always true

disk_force_media_change(), same

The only call where it's falso is in s390 code. If we know that a disk
is going away, that would be a userspace thing, and they can just
unmount.

