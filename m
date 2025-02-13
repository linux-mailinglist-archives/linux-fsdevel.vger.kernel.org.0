Return-Path: <linux-fsdevel+bounces-41640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF5CA33D7B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 12:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A03F18886B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 11:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B269215190;
	Thu, 13 Feb 2025 11:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="NIgwJXjN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B99214238;
	Thu, 13 Feb 2025 11:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739444919; cv=none; b=inyAkcEJUhzYJXNG9pMI9L3ebbbu0BdtMqS8GEWtKQ0DvRqCZdQYBMBBNR6JZdOkh0K/3E9/Glre6UpaUdJx1L8E4he5P5SjgOrsD9V4WWJDjUVvizK4NgDrBaWwdJGMAqtlQWg5wYBOfKfw8lvVDmU8x1a8Yk3xGWXIBFJcpnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739444919; c=relaxed/simple;
	bh=EOBiQL2i0ZXLCxz8ZRPi5i6PvJHEc5UOe7SQ5492xeI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d+2L9N6nydX+bzPd4IzyRa0w4d/fddKA1FixtByWXCInUQvXrH/OqSYcwJb2mJnjAHMitT6MDwm00q73VeMf41YFOTUUo5OjhkRAHuHjQAKFUrPLvtf+fnC9TTtKQwvHoBKyfe88bufamotbvnRmLVNx5afil6wcurac/gKPw1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=NIgwJXjN; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=DznlSHtJ15TXUJBEI7kzkOuDVk92KIybVPX2ql7XlRc=; b=NIgwJXjNiNh4TOL4r74Z1Wm82s
	RlWiIxFQXEyRa2Kj2qNTxUQPo+yE0teNHh0p0/cCtJcFVLN6euqFY25Bcsrl9tc7nc4Dnl8AkAOi7
	pwqF56OvbU2wpgaLfVYAXFi0DqKkgBeY2Cf5NpBOYtA+ua9X9haOnrxZtChDx80mMmoSAShRawLxD
	juem+hTJD98dXAd6/gYxoVo+dftZbjzxjI/9TmoyZ2jNndcc/CWQ+sxCzEosVrypFzPypl3/rpZKv
	p3gIRUGoT4/iOxLpD/KQyTAOVqZXZ7s7u59v47O6Csg9VfiYNZILJK0C9I1E5wzKIEX4K4rfH4L5+
	hoyqfPjA==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tiX4x-00AAdl-0g; Thu, 13 Feb 2025 12:08:28 +0100
From: Luis Henriques <luis@igalia.com>
To: Dave Chinner <david@fromorbit.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Matt Harvey <mharvey@jumptrading.com>,
  Bernd Schubert <bschubert@ddn.com>,  Joanne Koong
 <joannelkoong@gmail.com>
Subject: Re: [PATCH v4] fuse: add new function to invalidate cache for all
 inodes
In-Reply-To: <Z60bD3C_p_PHao0n@dread.disaster.area> (Dave Chinner's message of
	"Thu, 13 Feb 2025 09:05:03 +1100")
References: <20250211092604.15160-1-luis@igalia.com>
	<Z6u5dumvZHf_BDHM@dread.disaster.area> <875xlf4cvb.fsf@igalia.com>
	<Z60bD3C_p_PHao0n@dread.disaster.area>
Date: Thu, 13 Feb 2025 11:08:28 +0000
Message-ID: <87mseqcdar.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13 2025, Dave Chinner wrote:

> On Wed, Feb 12, 2025 at 11:32:40AM +0000, Luis Henriques wrote:
>> On Wed, Feb 12 2025, Dave Chinner wrote:
>>=20
>> > [ FWIW: if the commit message directly references someone else's
>> > related (and somewhat relevant) work, please directly CC those
>> > people on the patch(set). I only noticed this by chance, not because
>> > I read every FUSE related patch that goes by me. ]
>>=20
>> Point taken -- I should have included you on CC since the initial RFC.
>>=20
>> > On Tue, Feb 11, 2025 at 09:26:04AM +0000, Luis Henriques wrote:
>> >> Currently userspace is able to notify the kernel to invalidate the ca=
che
>> >> for an inode.  This means that, if all the inodes in a filesystem nee=
d to
>> >> be invalidated, then userspace needs to iterate through all of them a=
nd do
>> >> this kernel notification separately.
>> >>=20
>> >> This patch adds a new option that allows userspace to invalidate all =
the
>> >> inodes with a single notification operation.  In addition to invalida=
te
>> >> all the inodes, it also shrinks the sb dcache.
>> >
>> > That, IMO, seems like a bit naive - we generally don't allow user
>> > controlled denial of service vectors to be added to the kernel. i.e.
>> > this is the equivalent of allowing FUSE fs specific 'echo 1 >
>> > /proc/sys/vm/drop_caches' via some fuse specific UAPI. We only allow
>> > root access to /proc/sys/vm/drop_caches because it can otherwise be
>> > easily abused to cause system wide performance issues.
>> >
>> > It also strikes me as a somewhat dangerous precendent - invalidating
>> > random VFS caches through user APIs hidden deep in random fs
>> > implementations makes for poor visibility and difficult maintenance
>> > of VFS level functionality...
>>=20
>> Hmm... OK, I understand the concern and your comment makes perfect sense.
>> But would it be acceptable to move this API upper in the stack and make =
it
>> visible at the VFS layer?  Something similar to the 'drop_caches' but wi=
th
>> a superblock granularity.  I haven't spent any time thinking how could
>> that be done, but it wouldn't be "hidden deep" anymore.
>
> I'm yet to see any justification for why 'user driven entire
> filesystem cache invalidation' is needed. Get agreement on whether
> the functionality should exist first, then worry about how to
> implement it.
>
>> >> Signed-off-by: Luis Henriques <luis@igalia.com>
>> >> ---
>> >> * Changes since v3
>> >> - Added comments to clarify semantic changes in fuse_reverse_inval_in=
ode()
>> >>   when called with FUSE_INVAL_ALL_INODES (suggested by Bernd).
>> >> - Added comments to inodes iteration loop to clarify __iget/iput usage
>> >>   (suggested by Joanne)
>> >> - Dropped get_fuse_mount() call -- fuse_mount can be obtained from
>> >>   fuse_ilookup() directly (suggested by Joanne)
>> >>=20
>> >> (Also dropped the RFC from the subject.)
>> >>=20
>> >> * Changes since v2
>> >> - Use the new helper from fuse_reverse_inval_inode(), as suggested by=
 Bernd.
>> >> - Also updated patch description as per checkpatch.pl suggestion.
>> >>=20
>> >> * Changes since v1
>> >> As suggested by Bernd, this patch v2 simply adds an helper function t=
hat
>> >> will make it easier to replace most of it's code by a call to function
>> >> super_iter_inodes() when Dave Chinner's patch[1] eventually gets merg=
ed.
>> >>=20
>> >> [1] https://lore.kernel.org/r/20241002014017.3801899-3-david@fromorbi=
t.com
>> >
>> > That doesn't make the functionality any more palatable.
>> >
>> > Those iterators are the first step in removing the VFS inode list
>> > and only maintaining it in filesystems that actually need this
>> > functionality. We want this list to go away because maintaining it
>> > is a general VFS cache scalability limitation.
>> >
>> > i.e. if a filesystem has internal functionality that requires
>> > iterating all instantiated inodes, the filesystem itself should
>> > maintain that list in the most efficient manner for the filesystem's
>> > iteration requirements not rely on the VFS to maintain this
>> > information for it.
>>=20
>> Right, and in my use-case that's exactly what is currently being done: t=
he
>> FUSE API to invalidate individual inodes is being used.
>>
>> This new
>> functionality just tries to make life easier to userspace when *all* the
>> inodes need to be invalidated. (For reference, the use-case is CVMFS, a
>> read-only FS, where new generations of a filesystem snapshot may become
>> available at some point and the previous one needs to be wiped from the
>> cache.)
>
> But you can't actually "wipe" referenced inodes from cache. That is a
> use case for revoke(), not inode cache invalidation.

I guess the word "wipe" wasn't the best choice.  See below.

>> > I'm left to ponder why the invalidation isn't simply:
>> >
>> > 	/* Remove all possible active references to cached inodes */
>> > 	shrink_dcache_sb();
>> >
>> > 	/* Remove all unreferenced inodes from cache */
>> > 	invalidate_inodes();
>> >
>> > Which will result in far more of the inode cache for the filesystem
>> > being invalidated than the above code....
>>=20
>> To be honest, my initial attempt to implement this feature actually used
>> invalidate_inodes().  For some reason that I don't remember anymore why I
>> decided to implement the iterator myself.  I'll go look at that code aga=
in
>> and run some tests on this (much!) simplified version of the invalidation
>> function your suggesting.
>
> The above code, while simpler, still doesn't resolve the problem of
> invalidation of inodes that have active references (e.g. open files
> on them). They can't be "invalidated" in this way - they can't be
> removed from cache until all active references go away.

Sure, I understand that and that's *not* what I'm trying to do.  I guess
I'm just failing to describe my goal.  If there's a userspace process that
has a file open for an inode that does not exist anymore, that process
will continue using it -- the user-space filesystem will have to deal with
that.

Right now, fuse allows the user-space filesystem to notify the kernel that
*one* inode is not valid anymore.  This is a per inode operation.  I guess
this is very useful, for example, for network filesystems, where an inode
may have been deleted from somewhere else.

However, when user-space wants to do this for all the filesystem inodes,
it will be slow.  With my patch all I wanted to do is to make it a bit
less painful by moving the inodes iteration into the kernel.

Cheers,
--=20
Lu=C3=ADs

> i.e. any operation that is based on the assumption that we can
> remove all references to inodes and dentries by walking across them
> and dropping cache references to them is fundamentally flawed. To do
> this reliably, all active references have to be hunted down and
> released before the inodes can be removed from VFS visibility. i.e.
> the mythical revoke() operation would need to be implemented for
> this to work...
>
> -Dave.
>
> --=20
> Dave Chinner
> david@fromorbit.com


