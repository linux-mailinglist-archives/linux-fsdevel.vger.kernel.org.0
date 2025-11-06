Return-Path: <linux-fsdevel+bounces-67393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2F6C3DC47
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 00:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A8E614E5B53
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 23:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB27357727;
	Thu,  6 Nov 2025 23:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQ/nW7/c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB91C357704;
	Thu,  6 Nov 2025 23:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762470736; cv=none; b=PXTH0gS7HhJxqzBi4xYz/iexDjnLroMS3a+538XvLy1L52YuvK1qNn4kxYbOQbUujZjYL1UB/1fchMwYNiu9wSl6kFygsogD+GLQIuz9WtwRZn88MCiN1RpTCaBvWBUfg6LOvFwELm6xb/uEVqII+n4wNjIA8NkBKHTZ/gOGx6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762470736; c=relaxed/simple;
	bh=eaGLdXCCzfn0vCqc+TTzAlxkQNheAW4rx3yT51YPeLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RR6c99BYYajCDWrz7T+trl25qJll2fFink7FJFvL6FnoTI7KnttrjsCxQFZ41likOYO2b00S3jM2RaXU2PMGwFU5bndkVelx4n3d+xtfAqdnj4bM2VjBR1YiPZqAEzjQyvXe/7hVKTAWIfAneq1xL34IH6NqDjllMy5h/q3P6Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQ/nW7/c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20050C4CEFB;
	Thu,  6 Nov 2025 23:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762470736;
	bh=eaGLdXCCzfn0vCqc+TTzAlxkQNheAW4rx3yT51YPeLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZQ/nW7/cM4xgoJeOCouButyh6uCpOAV7RQJ5jnwtxbR/gRxHltLSRSRrpbt5HfcCm
	 CyyDP2eUy4Ld/b/qiPitg1Iz3gdnAQyn7q10AwS56j/ZcOwmRptdMr4IH42lO9TEsE
	 t+XZoNQpAh10tstWRZmcFnzHL3moKpRxgZULbFu3DgrmbsK4K6/zr22wp0DXX+oqgp
	 X5tpuatTJuGEEreRB52mwvPxOnw4FVH7g4KmHwuB8gavqmkCDGRY4o3clCTG5pbh3o
	 DqDjphuDl6nbPGXZIqH1hbCBEROBG5wmftUnJ20f6b6B21HUD1iYz54sqeDulrJ/41
	 HVyQa04aYTwoA==
Date: Thu, 6 Nov 2025 15:12:15 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: zlang@redhat.com, neal@gompa.dev, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joannelkoong@gmail.com, bernd@bsbernd.com
Subject: Re: [PATCH 01/33] misc: adapt tests to handle the fuse ext[234]
 drivers
Message-ID: <20251106231215.GC196366@frogsfrogsfrogs>
References: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
 <176169819994.1433624.4365613323075287467.stgit@frogsfrogsfrogs>
 <CAOQ4uxj7yaX5qLEs4BOJBJwybkHzv8WmNsUt0w_zehueOLLP9A@mail.gmail.com>
 <20251105225355.GC196358@frogsfrogsfrogs>
 <CAOQ4uxjC+rFKrp3SMMabyBwSKOWDGGpVR7-5gyodGbH80ucnkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjC+rFKrp3SMMabyBwSKOWDGGpVR7-5gyodGbH80ucnkA@mail.gmail.com>

On Thu, Nov 06, 2025 at 09:58:28AM +0100, Amir Goldstein wrote:
> On Wed, Nov 5, 2025 at 11:53 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Thu, Oct 30, 2025 at 10:51:06AM +0100, Amir Goldstein wrote:
> > > On Wed, Oct 29, 2025 at 2:22 AM Darrick J. Wong <djwong@kernel.org> wrote:
> > > >
> > > > From: Darrick J. Wong <djwong@kernel.org>
> > > >
> > > > It would be useful to be able to run fstests against the userspace
> > > > ext[234] driver program fuse2fs.  A convention (at least on Debian)
> > > > seems to be to install fuse drivers as /sbin/mount.fuse.XXX so that
> > > > users can run "mount -t fuse.XXX" to start a fuse driver for a
> > > > disk-based filesystem type XXX.
> > > >
> > > > Therefore, we'll adopt the practice of setting FSTYP=fuse.ext4 to
> > > > test ext4 with fuse2fs.  Change all the library code as needed to handle
> > > > this new type alongside all the existing ext[234] checks, which seems a
> > > > little cleaner than FSTYP=fuse FUSE_SUBTYPE=ext4, which also would
> > > > require even more treewide cleanups to work properly because most
> > > > fstests code switches on $FSTYP alone.
> > > >
> > >
> > > I agree that FSTYP=fuse.ext4 is cleaner than
> > > FSTYP=fuse FUSE_SUBTYPE=ext4
> > > but it is not extendable to future (e.g. fuse.xfs)
> > > and it is still a bit ugly.
> > >
> > > Consider:
> > > FSTYP=fuse.ext4
> > > MKFSTYP=ext4
> > >
> > > I think this is the correct abstraction -
> > > fuse2fs/ext4 are formatted that same and mounted differently
> > >
> > > See how some of your patch looks nicer and naturally extends to
> > > the imaginary fuse.xfs...
> >
> > Maybe I'd rather do it the other way around for fuse4fs:
> >
> > FSTYP=ext4
> > MOUNT_FSTYP=fuse.ext4
> >
> 
> Sounds good. Will need to see the final patch.
> 
> > (obviously, MOUNT_FSTYP=$FSTYP if the test runner hasn't overridden it)
> >
> > Where $MOUNT_FSTYP is what you pass to mount -t and what you'd see in
> > /proc/mounts.  The only weirdness with that is that some of the helpers
> > will end up with code like:
> >
> >         case $FSTYP in
> >         ext4)
> >                 # do ext4 stuff
> >                 ;;
> >         esac
> >
> >         case $MOUNT_FSTYP in
> >         fuse.ext4)
> >                 # do fuse4fs stuff that overrides ext4
> >                 ;;
> >         esac
> >
> > which would be a little weird.
> >
> 
> Sounds weird, but there is always going to be weirdness
> somewhere - need to pick the least weird result or most
> easy to understand code IMO.
> 
> > _scratch_mount would end up with:
> >
> >         $MOUNT_PROG -t $MOUNT_FSTYP ...
> >
> > and detecting it would be
> >
> >         grep -q -w $MOUNT_FSTYP /proc/mounts || _fail "booooo"
> >
> > Hrm?
> 
> Those look obviously nice.
> 
> Maybe the answer is to have all MOUNT_FSTYP, MKFS_FSTYP
> and FSTYP and use whichever best fits in the context.

Hrmm well I would /like/ avoid adding MKFS_FSTYP since ext4 is ext4, no
matter whether we're using the kernel or fuse42fs.  Do you have a use
case for adding such a thing?

--D

> Thanks,
> Amir.
> 

