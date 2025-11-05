Return-Path: <linux-fsdevel+bounces-67232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B619C384DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 00:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 86B2D4E87C7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 23:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669822F3630;
	Wed,  5 Nov 2025 23:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUuaD9v7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83F9256C8B;
	Wed,  5 Nov 2025 23:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762384349; cv=none; b=VtjRx2Mc7qvchBt2jemWxLf/Om2r+4otWIYmBi5/rWv0p6A95mmlE7LgVdz6x82ckdlxb4lSelv1rQ58hIO5A1B6p1cJMDQaMIAu8DFi0PIMglx5iZYIITyaELMX4Ncfwh64slwSCt5ud/sflCpZYubVK1b0xh3ltkcRC/QH54s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762384349; c=relaxed/simple;
	bh=1cjuJE9QmMmaUHWGKukSnkn4TGToV+0ncbBRmyJldH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KsUc4m9zkc0t1nhVQ8TZ06p6mkHH+89MySEFC7/9EZe83Ohkc6niSImX9ct1RJIuJT/Dx87k1QQYgLo/WY9qymV4baD/aVjrDYTpZzWTETmmoORbY7ChgOo/QRxH7R6Mzwvy9o4qiMD3YLBrWocNLoPEC9I5HD8yeI1JGhB8n9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUuaD9v7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D89EC4CEF5;
	Wed,  5 Nov 2025 23:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762384349;
	bh=1cjuJE9QmMmaUHWGKukSnkn4TGToV+0ncbBRmyJldH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OUuaD9v72qus6Rt6N/co6eumb9jhkPNj0A1EfMDj3cuyzlrOqpk5HSqE4ymU421o/
	 ZfEwxlTlgDPXaSohLBCV0LRJ7n/87SN7u8cLVGIKFtlYGbvWCVTYLoAzqm2Js41Kzu
	 WSMo8CgoexQmW13tSdXcnwQsD8Js3st6R96Q9dskXK28DChJl/N3+Hi/YiYR3ch+65
	 y86sJPK5mdk2g6Jx1J0zxe25ERKa48lFQ/7GqPfFN8tUYhdGOX0uHmeVhZOh8nqQR+
	 fkWKYz3Afo/vsc0avO79qZyYYd5m0scyJJ6wy9d4fPRGzVNV4PtS03cD+h0lshexKw
	 D6XVVT4JPpiAg==
Date: Wed, 5 Nov 2025 15:12:28 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: zlang@redhat.com, neal@gompa.dev, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joannelkoong@gmail.com, bernd@bsbernd.com
Subject: Re: [PATCH 22/33] generic/631: don't run test if we can't mount
 overlayfs
Message-ID: <20251105231228.GG196358@frogsfrogsfrogs>
References: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
 <176169820388.1433624.12333256574549591904.stgit@frogsfrogsfrogs>
 <aQNNZ6lxeMntTifa@amir-ThinkPad-T480>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQNNZ6lxeMntTifa@amir-ThinkPad-T480>

On Thu, Oct 30, 2025 at 12:35:03PM +0100, Amir Goldstein wrote:
> On Tue, Oct 28, 2025 at 06:26:09PM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > This test fails on fuse2fs with the following:
> > 
> > +mount: /opt/merged0: wrong fs type, bad option, bad superblock on overlay, missing codepage or helper program, or other error.
> > +       dmesg(1) may have more information after failed mount system call.
> > 
> > dmesg logs the following:
> > 
> > [  764.775172] overlayfs: upper fs does not support tmpfile.
> > [  764.777707] overlayfs: upper fs does not support RENAME_WHITEOUT.
> > 
> > From this, it's pretty clear why the test fails -- overlayfs checks that
> > the upper filesystem (fuse2fs) supports RENAME_WHITEOUT and O_TMPFILE.
> > fuse2fs doesn't support either of these, so the mount fails and then the
> > test goes wild.
> > 
> > Instead of doing that, let's do an initial test mount with the same
> > options as the workers, and _notrun if that first mount doesn't succeed.
> > 
> > Fixes: 210089cfa00315 ("generic: test a deadlock in xfs_rename when whiteing out files")
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  tests/generic/631 |   22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> > 
> > 
> > diff --git a/tests/generic/631 b/tests/generic/631
> > index 72bf85e30bdd4b..64e2f911fdd10e 100755
> > --- a/tests/generic/631
> > +++ b/tests/generic/631
> > @@ -64,6 +64,26 @@ stop_workers() {
> >  	done
> >  }
> >  
> > +require_overlayfs() {
> > +	local tag="check"
> > +	local mergedir="$SCRATCH_MNT/merged$tag"
> > +	local l="lowerdir=$SCRATCH_MNT/lowerdir:$SCRATCH_MNT/lowerdir1"
> > +	local u="upperdir=$SCRATCH_MNT/upperdir$tag"
> > +	local w="workdir=$SCRATCH_MNT/workdir$tag"
> > +	local i="index=off"
> > +
> > +	rm -rf $SCRATCH_MNT/merged$tag
> > +	rm -rf $SCRATCH_MNT/upperdir$tag
> > +	rm -rf $SCRATCH_MNT/workdir$tag
> > +	mkdir $SCRATCH_MNT/merged$tag
> > +	mkdir $SCRATCH_MNT/workdir$tag
> > +	mkdir $SCRATCH_MNT/upperdir$tag
> > +
> > +	_mount -t overlay overlay -o "$l,$u,$w,$i" $mergedir || \
> > +		_notrun "cannot mount overlayfs"
> > +	umount $mergedir
> > +}
> > +
> >  worker() {
> >  	local tag="$1"
> >  	local mergedir="$SCRATCH_MNT/merged$tag"
> > @@ -91,6 +111,8 @@ worker() {
> >  	rm -f $SCRATCH_MNT/workers/$tag
> >  }
> >  
> > +require_overlayfs
> > +
> >  for i in $(seq 0 $((4 + LOAD_FACTOR)) ); do
> >  	worker $i &
> >  done
> > 
> 
> I agree in general, but please consider this (untested) cleaner patch

Yes, this works too.  Since this is your code, could you send it to the
list with a proper commit message (or even just copy mine) and then I
can ack it?

--D

> Thanks,
> Amir.
> 

> From 470e7e26dc962b58ee1aabd578e63fe7a0df8cdd Mon Sep 17 00:00:00 2001
> From: Amir Goldstein <amir73il@gmail.com>
> Date: Thu, 30 Oct 2025 12:24:21 +0100
> Subject: [PATCH] generic/631: don't run test if we can't mount overlayfs
> 
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


