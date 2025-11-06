Return-Path: <linux-fsdevel+bounces-67344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE5AC3C3BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 17:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F2C51AA72D4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 16:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CE633EB00;
	Thu,  6 Nov 2025 16:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3bBJM7M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD39434C127;
	Thu,  6 Nov 2025 16:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762444969; cv=none; b=fVLg8Fkl2wTHebPCRECXHkHS8apEuzfVkXLbg8ZXSJX5AnKzFp504JyjMFoaiMY2M14chTEvuh957+QdpktFZ0maErttn5ftVMVWBo0IvGzgpzKq8F33778/Dileue4HNYR5Ak6e6xVrsOvFVnbvyPiDbLofXUMPjyj1BLp+dsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762444969; c=relaxed/simple;
	bh=HY4WkagOCSSLnIUoikHDOt/pBlqaTxH2hmXbuOnRe6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pGXAOpvjkYcM/Umir4LfCJhsErmZt4dH41xbL+qkP3lUVyteIZm2y/dvK5uPOIp/kEwHXrLz4ADzWOKodPhBOEZw3jAVW0TP5267mnTu8dCS4DyqAtau+FqpmDFbjY8bGcyovBc+rj7sRj6JDYKq3HXrDZlf2voEmsrHfM1hVlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3bBJM7M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18787C4CEFB;
	Thu,  6 Nov 2025 16:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762444968;
	bh=HY4WkagOCSSLnIUoikHDOt/pBlqaTxH2hmXbuOnRe6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f3bBJM7MWHciQta/a44zHsq26o7EEcl95Gj9sYuDxNZ2W3qohpu6JacKFC4MkIY5/
	 oipfbgirthcXoz0hns1dpiMAKvLYEOFUQuNvIW/GZfCc2NvZp3wgQp5J2z+j3qFmWK
	 0BtGHSR4x5EvhzrA2Epco5Y9hyiv+moKWc1whuc28dZgAzQk4wjTVECygwZIgY180t
	 EXqNxeL6ItFADftwme0msZ0EzoH5w2qqipiFrXmSAT59G97N3LIpTwUuQc7wjoNtVy
	 L2KiyutXTNEu4f51KkGOuvgZRxMuhNnZhYLLOLFIBM2fmiJvyVrbNlw6DbT6bWhQkc
	 yV+/yJrsx6owQ==
Date: Thu, 6 Nov 2025 08:02:47 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: zlang@redhat.com, neal@gompa.dev, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joannelkoong@gmail.com, bernd@bsbernd.com
Subject: Re: [PATCH 22/33] generic/631: don't run test if we can't mount
 overlayfs
Message-ID: <20251106160247.GH196391@frogsfrogsfrogs>
References: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
 <176169820388.1433624.12333256574549591904.stgit@frogsfrogsfrogs>
 <aQNNZ6lxeMntTifa@amir-ThinkPad-T480>
 <20251105231228.GG196358@frogsfrogsfrogs>
 <CAOQ4uxhQt6LNo7QaN3rWy3eCeAS9r0xNcMW4ZvdrY5YgMbq66g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhQt6LNo7QaN3rWy3eCeAS9r0xNcMW4ZvdrY5YgMbq66g@mail.gmail.com>

On Thu, Nov 06, 2025 at 10:23:04AM +0100, Amir Goldstein wrote:
> On Thu, Nov 6, 2025 at 12:12 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Thu, Oct 30, 2025 at 12:35:03PM +0100, Amir Goldstein wrote:
> > > On Tue, Oct 28, 2025 at 06:26:09PM -0700, Darrick J. Wong wrote:
> > > > From: Darrick J. Wong <djwong@kernel.org>
> > > >
> > > > This test fails on fuse2fs with the following:
> > > >
> > > > +mount: /opt/merged0: wrong fs type, bad option, bad superblock on overlay, missing codepage or helper program, or other error.
> > > > +       dmesg(1) may have more information after failed mount system call.
> > > >
> > > > dmesg logs the following:
> > > >
> > > > [  764.775172] overlayfs: upper fs does not support tmpfile.
> > > > [  764.777707] overlayfs: upper fs does not support RENAME_WHITEOUT.
> > > >
> > > > From this, it's pretty clear why the test fails -- overlayfs checks that
> > > > the upper filesystem (fuse2fs) supports RENAME_WHITEOUT and O_TMPFILE.
> > > > fuse2fs doesn't support either of these, so the mount fails and then the
> > > > test goes wild.
> > > >
> > > > Instead of doing that, let's do an initial test mount with the same
> > > > options as the workers, and _notrun if that first mount doesn't succeed.
> > > >
> > > > Fixes: 210089cfa00315 ("generic: test a deadlock in xfs_rename when whiteing out files")
> > > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > > ---
> > > >  tests/generic/631 |   22 ++++++++++++++++++++++
> > > >  1 file changed, 22 insertions(+)
> > > >
> > > >
> > > > diff --git a/tests/generic/631 b/tests/generic/631
> > > > index 72bf85e30bdd4b..64e2f911fdd10e 100755
> > > > --- a/tests/generic/631
> > > > +++ b/tests/generic/631
> > > > @@ -64,6 +64,26 @@ stop_workers() {
> > > >     done
> > > >  }
> > > >
> > > > +require_overlayfs() {
> > > > +   local tag="check"
> > > > +   local mergedir="$SCRATCH_MNT/merged$tag"
> > > > +   local l="lowerdir=$SCRATCH_MNT/lowerdir:$SCRATCH_MNT/lowerdir1"
> > > > +   local u="upperdir=$SCRATCH_MNT/upperdir$tag"
> > > > +   local w="workdir=$SCRATCH_MNT/workdir$tag"
> > > > +   local i="index=off"
> > > > +
> > > > +   rm -rf $SCRATCH_MNT/merged$tag
> > > > +   rm -rf $SCRATCH_MNT/upperdir$tag
> > > > +   rm -rf $SCRATCH_MNT/workdir$tag
> > > > +   mkdir $SCRATCH_MNT/merged$tag
> > > > +   mkdir $SCRATCH_MNT/workdir$tag
> > > > +   mkdir $SCRATCH_MNT/upperdir$tag
> > > > +
> > > > +   _mount -t overlay overlay -o "$l,$u,$w,$i" $mergedir || \
> > > > +           _notrun "cannot mount overlayfs"
> > > > +   umount $mergedir
> > > > +}
> > > > +
> > > >  worker() {
> > > >     local tag="$1"
> > > >     local mergedir="$SCRATCH_MNT/merged$tag"
> > > > @@ -91,6 +111,8 @@ worker() {
> > > >     rm -f $SCRATCH_MNT/workers/$tag
> > > >  }
> > > >
> > > > +require_overlayfs
> > > > +
> > > >  for i in $(seq 0 $((4 + LOAD_FACTOR)) ); do
> > > >     worker $i &
> > > >  done
> > > >
> > >
> > > I agree in general, but please consider this (untested) cleaner patch
> >
> > Yes, this works too.  Since this is your code, could you send it to the
> > list with a proper commit message (or even just copy mine) and then I
> > can ack it?
> >
> 
> Attached.
> Now it's even tested.
> 
> I put you down as Suggested-by.
> Feel free to choose your own roles...
> 
> Thanks,
> Amir.

> From dc31352d6c926e0f6da6238eccbcaa96b1fb89c2 Mon Sep 17 00:00:00 2001
> From: Amir Goldstein <amir73il@gmail.com>
> Date: Thu, 30 Oct 2025 12:24:21 +0100
> Subject: [PATCH] generic/631: don't run test if we can't mount overlayfs
> 
> This test fails on fuse2fs with the following:
> 
> mount: /opt/merged0: wrong fs type, bad option, bad superblock on overlay,
>        missing codepage or helper program, or other error.
>        dmesg(1) may have more information after failed mount system call.
> 
> dmesg logs the following:
> 
> [  764.775172] overlayfs: upper fs does not support tmpfile.
> [  764.777707] overlayfs: upper fs does not support RENAME_WHITEOUT.
> 
> From this, it's pretty clear why the test fails -- overlayfs checks that
> the upper filesystem (fuse2fs) supports RENAME_WHITEOUT and O_TMPFILE.
> fuse2fs doesn't support either of these, so the mount fails and then the
> test goes wild.
> 
> Instead of doing that, let's do an initial test mount with the same
> options as the workers, and _notrun if that first mount doesn't succeed.
> 
> Fixes: 210089cfa00315 ("generic: test a deadlock in xfs_rename when whiteing out files")
> Suggested-by: "Darrick J. Wong" <djwong@kernel.org>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Works for me,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  tests/generic/631 | 39 ++++++++++++++++++++++++++++-----------
>  1 file changed, 28 insertions(+), 11 deletions(-)
> 
> diff --git a/tests/generic/631 b/tests/generic/631
> index c38ab771..7dc335aa 100755
> --- a/tests/generic/631
> +++ b/tests/generic/631
> @@ -46,7 +46,6 @@ _require_extra_fs overlay
>  
>  _scratch_mkfs >> $seqres.full
>  _scratch_mount
> -_supports_filetype $SCRATCH_MNT || _notrun "overlayfs test requires d_type"
>  
>  mkdir $SCRATCH_MNT/lowerdir
>  mkdir $SCRATCH_MNT/lowerdir1
> @@ -64,7 +63,7 @@ stop_workers() {
>  	done
>  }
>  
> -worker() {
> +mount_overlay() {
>  	local tag="$1"
>  	local mergedir="$SCRATCH_MNT/merged$tag"
>  	local l="lowerdir=$SCRATCH_MNT/lowerdir:$SCRATCH_MNT/lowerdir1"
> @@ -72,25 +71,43 @@ worker() {
>  	local w="workdir=$SCRATCH_MNT/workdir$tag"
>  	local i="index=off"
>  
> +	rm -rf $SCRATCH_MNT/merged$tag
> +	rm -rf $SCRATCH_MNT/upperdir$tag
> +	rm -rf $SCRATCH_MNT/workdir$tag
> +	mkdir $SCRATCH_MNT/merged$tag
> +	mkdir $SCRATCH_MNT/workdir$tag
> +	mkdir $SCRATCH_MNT/upperdir$tag
> +
> +	mount -t overlay overlay -o "$l,$u,$w,$i" "$mergedir"
> +}
> +
> +unmount_overlay() {
> +	local tag="$1"
> +	local mergedir="$SCRATCH_MNT/merged$tag"
> +
> +	_unmount $mergedir
> +}
> +
> +worker() {
> +	local tag="$1"
> +	local mergedir="$SCRATCH_MNT/merged$tag"
> +
>  	touch $SCRATCH_MNT/workers/$tag
>  	while test -e $SCRATCH_MNT/running; do
> -		rm -rf $SCRATCH_MNT/merged$tag
> -		rm -rf $SCRATCH_MNT/upperdir$tag
> -		rm -rf $SCRATCH_MNT/workdir$tag
> -		mkdir $SCRATCH_MNT/merged$tag
> -		mkdir $SCRATCH_MNT/workdir$tag
> -		mkdir $SCRATCH_MNT/upperdir$tag
> -
> -		mount -t overlay overlay -o "$l,$u,$w,$i" $mergedir
> +		mount_overlay $tag
>  		mv $mergedir/etc/access.conf $mergedir/etc/access.conf.bak
>  		touch $mergedir/etc/access.conf
>  		mv $mergedir/etc/access.conf $mergedir/etc/access.conf.bak
>  		touch $mergedir/etc/access.conf
> -		_unmount $mergedir
> +		unmount_overlay $tag
>  	done
>  	rm -f $SCRATCH_MNT/workers/$tag
>  }
>  
> +mount_overlay check || \
> +	_notrun "cannot mount overlayfs with underlying filesystem $FSTYP"
> +unmount_overlay check
> +
>  for i in $(seq 0 $((4 + LOAD_FACTOR)) ); do
>  	worker $i &
>  done
> -- 
> 2.51.1
> 


