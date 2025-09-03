Return-Path: <linux-fsdevel+bounces-60169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7D9B425EB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 17:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0B4C481079
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 15:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED8528C854;
	Wed,  3 Sep 2025 15:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIzMFIcw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDD7289E07
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 15:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756914597; cv=none; b=AtBIg3Nc+HIqoyRB1YOX2IMdvMT7++hB944NG4S4nfiIB/VqunbKDq5O9wQkh2VPckcu+AOWa1UzAe1GqMi1XOJp+XVdwpFQnkZTY7Du08obRIhGncrJT8bXA+QRAWH3UUwmMzrbukKyWk1xQQdbrqrYdbl0yIipCvD0qIGEUxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756914597; c=relaxed/simple;
	bh=GIqx8DIEvTWqmbtzc/0SABE5854Eet/awyCxQJt3vHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5A3FLPwKMBTRklzdQgpgp8m9smmh2rpLqzngGQarCoNyMmj2pPxusqWvyGg4JEeTZui2pjxnX4Bu9FfA6y8kN7gdy+FWgSoc+qGGhfp26qtRXNRtnOYgGXo3kRYoD8ZanE0G3W7lt3Zu8Se1fqXBn35Z8mjy1lhntLI1VBN8Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIzMFIcw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3A0C4CEE7;
	Wed,  3 Sep 2025 15:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756914596;
	bh=GIqx8DIEvTWqmbtzc/0SABE5854Eet/awyCxQJt3vHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HIzMFIcwGM2J8fy2XPQ5+tBJul5FiTckIdE7P1Pl7pWHYDtaHt71mQRQNISwiZnZ3
	 QWaUUtbzzSlBnkm63S4Rk3yZRgXtQfqOlVF+v2IxeGI0Apv5oO/VI7KqAHoI1SFWv+
	 QwkDisvI5ubY5+NYgs8OdqN4w58NIaJ3xp8t4v4tdKM23lWOn15nfhFQJBWJUSFrch
	 NJubQqxRIt4DUNodEDltfcV0nC9jrbQCkpe8bqJke4T0StwlMY/aA/Y3VWIYNTccok
	 GAvJlB4W7xOUTDEYHVICxXV/wiaPkx0FgVIOvmOi2eZJLeVsfQGCGw+IFht5Mtnxax
	 fU9ITkMMqL1fQ==
Date: Wed, 3 Sep 2025 08:49:55 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
	linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Subject: Re: [PATCH 4/7] fuse: implement file attributes mask for statx
Message-ID: <20250903154955.GD1587915@frogsfrogsfrogs>
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs>
 <175573708630.15537.1057407663556817922.stgit@frogsfrogsfrogs>
 <CAJfpegsp=6A7jMxSpQce6Xx72POGddWqtJFTWauM53u7_125vQ@mail.gmail.com>
 <20250829153938.GA8088@frogsfrogsfrogs>
 <CAJfpegs=2==Tx3kcFHoD-0Y98tm6USdX_NTNpmoCpAJSMZvDtw@mail.gmail.com>
 <20250902205736.GB1587915@frogsfrogsfrogs>
 <CAJfpegskHg7ewo6p0Bn=3Otsm7zXcyRu=0drBdqWzMG+hegbSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegskHg7ewo6p0Bn=3Otsm7zXcyRu=0drBdqWzMG+hegbSQ@mail.gmail.com>

On Wed, Sep 03, 2025 at 11:55:25AM +0200, Miklos Szeredi wrote:
> On Tue, 2 Sept 2025 at 22:57, Darrick J. Wong <djwong@kernel.org> wrote:
> 
> > You can, kind of -- either send the server FS_IOC_FSGETXATTR or
> > FS_IOC_GETFLAGS right after igetting an inode and set the VFS
> > immutable/append flags from that; or we could add a couple of flag bits
> > to fuse_attr::flags to avoid the extra upcall.
> 
> How about a new FUSE_LOOKUPX that uses fuse_statx instead of fuse_attr
> to initialize the inode?

Or what if we enlarged fuse_attr?  Its fields mostly duplicate what was
already in struct stat (and now struct statx):

struct fuse_attrx {
	struct fuse_statx	statx;
	uint32_t		flags; /* fuse_attr::flags */
};

Hrmm, fuse_attr is embedded in structs fuse_entry_out and
fuse_attr_out.  FUSE_{LOOKUP,OPEN,CREATE,SETATTR,GETATTR} (and
direntplus) would need to be rototilled to support the new structure,
and either you need new command codes for all that, or I guess one could
set out_argvar = true and switch the out-struct decoding based on the
size returned.

That sounds like a project in and of itself.

> > The flag is very much needed for virtiofs/famfs (and any future
> > fuse+iomap+fsdax combination), because that's how application programs
> > are supposed to detect that they can use load/store to mmap file regions
> > without needing fsync/msync.
> 
> Makes sense.
> 
> > > I also fell that all unknown flags should also be masked off, but
> > > maybe that's too paranoid.
> >
> > That isn't a terrible idea.
> 
> So in conclusion, the following can be passed through from the fuse
> server to the statx syscall (directly or cached):
> 
> COMPRESSED
> NODUMP
> ENCRYPTED
> VERITY
> WRITE_ATOMIC

Right.

> The following should be set (cached) in the relevant inode flag:
> 
> IMMUTABLE
> APPEND

Right, S_IMMUTABLE and S_APPEND.

> The following should be ignored and the VFS flag be used instead:
> 
> AUTOMOUNT
> MOUNT_ROOT
> DAX

Yes to the first two.

As for /setting/ S_DAX, I think we just keep using FUSE_ATTR_DAX like we
do now, since that's baked into the kernel <-> libfuse interface and
can't go away.  That would fit nicely with how the other filesystems do
it.

> And other attributes should just be ignored.

I prefer to say "Other attribute bits are undefined and should just be
ignored." :)

> Agree?

I think we do, except maybe the difficult first point. :)

--D

> Thanks,
> Miklos
> 

