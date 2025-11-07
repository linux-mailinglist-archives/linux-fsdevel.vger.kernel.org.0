Return-Path: <linux-fsdevel+bounces-67412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F95C3EB1D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 08:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04635188C6A6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 07:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51213307AC6;
	Fri,  7 Nov 2025 07:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="czkV9Sy+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oHKV63Kq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8172FCC01
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Nov 2025 07:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762499312; cv=none; b=hlcL2mhvEDoCvbhvHvWDpAa/W0SfWODW8SXe+2bLX3sPOl/W7W+ZEIdbQ4lKUY2t1HXDJrJU6SBksUpzBeIAnNR5Z7D9Vdjj9eLnnv3CJ/IknpK/X0KdRzG/q92mNDvPZtGHwZr7SUsi0P1tAWrKIfdjaNRsuWwhGtiaZubUosg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762499312; c=relaxed/simple;
	bh=rkWnS0D+0mddtDBOb/4th2VMSY2roDcrp9Q+CfNVVGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjrUnYvpI2twPSAZprS6TD2eRuAz/vSKjjORg3CFlN/W/t16W2q4b2e7rHY0kldHeCSDvjVGh5YiVpA3I9e3SiklbyGordOdoLIUIMjAAT6c5oEVvcb0LvtzBEmwhU2L0OgzNz+nsOLxpNedTqHu2tFK7z3/wDToGy55ryzj4m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=czkV9Sy+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oHKV63Kq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762499309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yerLGJx7gBZqKU4HNq5xwJA95EiCLHLf/kDEUKD/Wjk=;
	b=czkV9Sy+PgHGRssgZR3DBE2SD/YkIYUnhhJn7F9zR01XjPd60lU9HR1OTYJ/CEmlnXP8bM
	G+7jc8gif5yxosnjtCoaeAzXnZNx+kfA1k3qarvrDgtDYPW4HePRFlKUcDZ3McescessD/
	VYtweJCCUH0aMKVaWuMKGez7Rl8WjcM=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-VZJEKmsyMH2QvietceQXSw-1; Fri, 07 Nov 2025 02:08:28 -0500
X-MC-Unique: VZJEKmsyMH2QvietceQXSw-1
X-Mimecast-MFC-AGG-ID: VZJEKmsyMH2QvietceQXSw_1762499307
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2958c80fcabso14220945ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Nov 2025 23:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762499307; x=1763104107; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yerLGJx7gBZqKU4HNq5xwJA95EiCLHLf/kDEUKD/Wjk=;
        b=oHKV63KqHyIGk2JouP+pM5Om9c15GPZw+etlpVEIFuMnc90ybFw53EBOS0ky2uD+JC
         e6wtbr0I8raBSNp27kAuqS7zo7mOXlaXJKxj/xb/M4UyDJfT7azrcBC/mSEF393LWLM3
         GQKLqyI6W2yHRLh8ErRIN3wsjLd5y1j4wxMK2zL7XZCLSnXUkgprVYStedFqVCZi91hJ
         9eAowNYNvv5cm8om5qYYETn9bncaCz7nxiXgrEqC7GaaTAA3Haup8natEjei+cqK5+2V
         L3njrdLB587Hlf+apUUYA3bbcjgrnuzbMTHW43hi01xROzWjUkN5t00Fu0PLmkMtNPrp
         /I1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762499307; x=1763104107;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yerLGJx7gBZqKU4HNq5xwJA95EiCLHLf/kDEUKD/Wjk=;
        b=VXW/5a9Nauea3NEPGgqCOPa24emtXeajKk1m5PtoR1aQCGa49ROEJJ36GDEJNJcQ0Z
         8/8iRHqvG9SAN8GiwYqFG3zFTdWAyXcmhp6IR/rvND92nAB78kLPVSFEGJxNja59MAor
         WRuMwxOWyuZ7HbLiY/nrCez6dNmlH1O2Xl+MI5HfZfS+4jTxHOBzxuz3/Piu7saAdDMK
         4ssdT4qT+I+G3DmkxSQS5d4of88D8MWmLvp6DrybQcJizI87+29a+GvCVunM8PC/8l/3
         c0usltf/0jcjHIpwhj4w7iHliRKi4PHlFnMK1lrcPWUeRMtzsjhdpkpzay68mvIR26YO
         pA8A==
X-Forwarded-Encrypted: i=1; AJvYcCUfxuGaHya9GqzTPLVchN7t+hgFpfdSzSZ6A+o2xtQIbt+PjLpn/YYXgLRxzjezAZm4AOicnvI+7Q9gS+Gu@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo6iBxeosVBl6nYpINIL8n6/zJZbuhq/2Ggun87t+Lo0NpfFkY
	LZvPgzD13Fup2hPEqtchd8GAuTaG5R9N1P4c7+1ySxM9CAvzGKYp7fc6rrCU0tHSO2Vt3Y+Q55+
	/NY4fvV2qK5FoxRzW7f80fozP978LrRJVC1+pPgrAbMjqvwLwJeIO/L4Y0st8z7RrcDg=
X-Gm-Gg: ASbGncveJhsHXDFC9+FrABj2BaPSIhBJ/qA6iTcKF76rEj5CphNAigaTrhlZxPe6FT7
	6mRBFmLqkjOUnEwnL8CJkMutCdMcc2HFIihX5Kh0j6Fd9MoVQP3atuwNR+WHNDMYNvmMP7WePq3
	kNyp9GZQoPRz7WaiC1IQb9QaZmaLyCRXY5RLD1BgdDfEqYL5MLWoJzxUNNcf31OyCZndVUxqhGg
	WYEGSkPHCvakWT2n84fE8wJ+2/YanSlB9JI9Rvr83CYVMnbEpHKW8i8C8irT5zo/UKMwpZpZOgH
	fhgMaQQJyn/uLJ1nq2VeFbXkBguXRUb+1IoMPpUxMQg8FAmV+GZSn4QhpAdPDOEH0JJ8p7D39eP
	a4RV6FswJZtilD3bX0pw3v7dFuufkgFqbZJLcMpo=
X-Received: by 2002:a17:902:e784:b0:295:70b1:edc8 with SMTP id d9443c01a7336-297c0389e74mr33041435ad.2.1762499307101;
        Thu, 06 Nov 2025 23:08:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9fly+Wc+YihTvNqEBuwjA19haWK5XSmHSuGiSWWoCjn97gDfrteqMvZADgN28pNxE0akWCg==
X-Received: by 2002:a17:902:e784:b0:295:70b1:edc8 with SMTP id d9443c01a7336-297c0389e74mr33041085ad.2.1762499306592;
        Thu, 06 Nov 2025 23:08:26 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c93c8dsm50850245ad.80.2025.11.06.23.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 23:08:25 -0800 (PST)
Date: Fri, 7 Nov 2025 15:08:20 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>
Cc: neal@gompa.dev, fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com,
	bernd@bsbernd.com
Subject: Re: [PATCH 01/33] misc: adapt tests to handle the fuse ext[234]
 drivers
Message-ID: <20251107070820.6mil3ptmkkyauyts@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
 <176169819994.1433624.4365613323075287467.stgit@frogsfrogsfrogs>
 <CAOQ4uxj7yaX5qLEs4BOJBJwybkHzv8WmNsUt0w_zehueOLLP9A@mail.gmail.com>
 <20251105225355.GC196358@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251105225355.GC196358@frogsfrogsfrogs>

On Wed, Nov 05, 2025 at 02:53:55PM -0800, Darrick J. Wong wrote:
> On Thu, Oct 30, 2025 at 10:51:06AM +0100, Amir Goldstein wrote:
> > On Wed, Oct 29, 2025 at 2:22 AM Darrick J. Wong <djwong@kernel.org> wrote:
> > >
> > > From: Darrick J. Wong <djwong@kernel.org>
> > >
> > > It would be useful to be able to run fstests against the userspace
> > > ext[234] driver program fuse2fs.  A convention (at least on Debian)
> > > seems to be to install fuse drivers as /sbin/mount.fuse.XXX so that
> > > users can run "mount -t fuse.XXX" to start a fuse driver for a
> > > disk-based filesystem type XXX.
> > >
> > > Therefore, we'll adopt the practice of setting FSTYP=fuse.ext4 to
> > > test ext4 with fuse2fs.  Change all the library code as needed to handle
> > > this new type alongside all the existing ext[234] checks, which seems a
> > > little cleaner than FSTYP=fuse FUSE_SUBTYPE=ext4, which also would
> > > require even more treewide cleanups to work properly because most
> > > fstests code switches on $FSTYP alone.

Thanks Darrick, a big patchset again :)

> > >
> > 
> > I agree that FSTYP=fuse.ext4 is cleaner than
> > FSTYP=fuse FUSE_SUBTYPE=ext4
> > but it is not extendable to future (e.g. fuse.xfs)
> > and it is still a bit ugly.
> > 
> > Consider:
> > FSTYP=fuse.ext4
> > MKFSTYP=ext4

No matter this ^^^, or ...

> > 
> > I think this is the correct abstraction -
> > fuse2fs/ext4 are formatted that same and mounted differently
> > 
> > See how some of your patch looks nicer and naturally extends to
> > the imaginary fuse.xfs...
> 
> Maybe I'd rather do it the other way around for fuse4fs:
> 
> FSTYP=ext4
> MOUNT_FSTYP=fuse.ext4

... this ^^^, I think this discussion brings in a topic:
If the same on-disk fstype can be mounted with different drivers, what does
original $FSTYP stand for? Is it stand for the running fs driver, or the the
on-disk fs type? Besides the code looks ugly or not, the basic parameters must
be clear in meaning I think.

If the same on-disk fstype can be mounted with different drivers, we might
need two parameters to avoid this confusion. Due to we sometimes depends on
the on-disk type, e.g. mkfs, fsck, xfs_db, metadump and so on, sometimes
depend on running-time fs driver, e.g. mount, quota and so on.

We can let FSTYP stands for the running-time fs driver, as it's mostly treated
as that I think. And set MKFSTYP=$FSTYP by default, if MKFSTYP isn't specified.
Then change those "FSTYP judgement" code to MKFSTYP, if they need ondisk fstype
actually.

I don't mind the parameter name, but the meaning should not be confused. What
do you think? Feel free to correct me if I miss anything.

Thanks,
Zorro

> 
> (obviously, MOUNT_FSTYP=$FSTYP if the test runner hasn't overridden it)
> 
> Where $MOUNT_FSTYP is what you pass to mount -t and what you'd see in
> /proc/mounts.  The only weirdness with that is that some of the helpers
> will end up with code like:
> 
> 	case $FSTYP in
> 	ext4)
> 		# do ext4 stuff
> 		;;
> 	esac
> 
> 	case $MOUNT_FSTYP in
> 	fuse.ext4)
> 		# do fuse4fs stuff that overrides ext4
> 		;;
> 	esac
> 
> which would be a little weird.
> 
> _scratch_mount would end up with:
> 
> 	$MOUNT_PROG -t $MOUNT_FSTYP ...
> 
> and detecting it would be
> 
> 	grep -q -w $MOUNT_FSTYP /proc/mounts || _fail "booooo"
> 
> Hrm?
> 
> --D
> 
> > 
> > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > ---
> > >  check             |   24 +++++++++++++++++-------
> > >  common/casefold   |    4 ++++
> > >  common/config     |   11 ++++++++---
> > >  common/defrag     |    2 +-
> > >  common/encrypt    |   16 ++++++++--------
> > >  common/log        |   10 +++++-----
> > >  common/populate   |   14 +++++++-------
> > >  common/quota      |    9 +++++++++
> > >  common/rc         |   50 +++++++++++++++++++++++++++++---------------------
> > >  common/report     |    2 +-
> > >  common/verity     |    8 ++++----
> > >  tests/generic/020 |    2 +-
> > >  tests/generic/067 |    2 +-
> > >  tests/generic/441 |    2 +-
> > >  tests/generic/496 |    2 +-
> > >  tests/generic/621 |    2 +-
> > >  tests/generic/740 |    2 +-
> > >  tests/generic/746 |    4 ++--
> > >  tests/generic/765 |    4 ++--
> > >  19 files changed, 103 insertions(+), 67 deletions(-)
> > >
> > >
> > > diff --git a/check b/check
> > > index 9bb80a22440f97..81cd03f73ce155 100755
> > > --- a/check
> > > +++ b/check
> > > @@ -140,12 +140,25 @@ get_sub_group_list()
> > >         echo $grpl
> > >  }
> > >
> > > +get_group_dirs()
> > > +{
> > > +       local fsgroup="$FSTYP"
> > > +
> > > +       case "$FSTYP" in
> > > +       ext2|ext3|fuse.ext[234])
> > > +               fsgroup=ext4
> > > +               ;;
> > > +       esac
> > > +
> > > +       echo $SRC_GROUPS
> > > +       echo $fsgroup
> > > +}
> > > +
> > >  get_group_list()
> > >  {
> > >         local grp=$1
> > >         local grpl=""
> > >         local sub=$(dirname $grp)
> > > -       local fsgroup="$FSTYP"
> > >
> > >         if [ -n "$sub" -a "$sub" != "." -a -d "$SRC_DIR/$sub" ]; then
> > >                 # group is given as <subdir>/<group> (e.g. xfs/quick)
> > > @@ -154,10 +167,7 @@ get_group_list()
> > >                 return
> > >         fi
> > >
> > > -       if [ "$FSTYP" = ext2 -o "$FSTYP" = ext3 ]; then
> > > -           fsgroup=ext4
> > > -       fi
> > > -       for d in $SRC_GROUPS $fsgroup; do
> > > +       for d in $(get_group_dirs); do
> > >                 if ! test -d "$SRC_DIR/$d" ; then
> > >                         continue
> > >                 fi
> > > @@ -171,7 +181,7 @@ get_group_list()
> > >  get_all_tests()
> > >  {
> > >         touch $tmp.list
> > > -       for d in $SRC_GROUPS $FSTYP; do
> > > +       for d in $(get_group_dirs); do
> > >                 if ! test -d "$SRC_DIR/$d" ; then
> > >                         continue
> > >                 fi
> > > @@ -387,7 +397,7 @@ if [ -n "$FUZZ_REWRITE_DURATION" ]; then
> > >  fi
> > >
> > >  if [ -n "$subdir_xfile" ]; then
> > > -       for d in $SRC_GROUPS $FSTYP; do
> > > +       for d in $(get_group_dirs); do
> > >                 [ -f $SRC_DIR/$d/$subdir_xfile ] || continue
> > >                 for f in `sed "s/#.*$//" $SRC_DIR/$d/$subdir_xfile`; do
> > >                         exclude_tests+=($d/$f)
> > > diff --git a/common/casefold b/common/casefold
> > > index 2aae5e5e6c8925..fcdb4d210028ac 100644
> > > --- a/common/casefold
> > > +++ b/common/casefold
> > > @@ -6,6 +6,10 @@
> > >  _has_casefold_kernel_support()
> > >  {
> > >         case $FSTYP in
> > > +       fuse.ext[234])
> > > +               # fuse2fs does not support casefolding
> > > +               false
> > > +               ;;
> > 
> > This would not be needed
> > 
> > >         ext4)
> > >                 test -f '/sys/fs/ext4/features/casefold'
> > >                 ;;
> > > diff --git a/common/config b/common/config
> > > index 7fa97319d7d0ca..0cd2b33c4ade40 100644
> > > --- a/common/config
> > > +++ b/common/config
> > > @@ -386,6 +386,11 @@ _common_mount_opts()
> > >         overlay)
> > >                 echo $OVERLAY_MOUNT_OPTIONS
> > >                 ;;
> > > +       fuse.ext[234])
> > > +               # fuse sets up secure defaults, so we must explicitly tell
> > > +               # fuse2fs to use the more relaxed kernel access behaviors.
> > > +               echo "-o kernel $EXT_MOUNT_OPTIONS"
> > > +               ;;
> > >         ext2|ext3|ext4)
> > >                 # acls & xattrs aren't turned on by default on ext$FOO
> > >                 echo "-o acl,user_xattr $EXT_MOUNT_OPTIONS"
> > > @@ -472,7 +477,7 @@ _mkfs_opts()
> > >  _fsck_opts()
> > >  {
> > >         case $FSTYP in
> > 
> > This would obviously be $MKFSTYP with no further changes
> > 
> > > -       ext2|ext3|ext4)
> > > +       ext2|ext3|fuse.ext[234]|ext4)
> > >                 export FSCK_OPTIONS="-nf"
> > >                 ;;
> > >         reiser*)
> > > @@ -514,11 +519,11 @@ _source_specific_fs()
> > >
> > >                 . ./common/btrfs
> > >                 ;;
> > > -       ext4)
> > > +       fuse.ext4|ext4)
> > >                 [ "$MKFS_EXT4_PROG" = "" ] && _fatal "mkfs.ext4 not found"
> > >                 . ./common/ext4
> > >                 ;;
> > > -       ext2|ext3)
> > > +       ext2|ext3|fuse.ext[23])
> > >                 . ./common/ext4
> > 
> > same here
> > 
> > >                 ;;
> > >         f2fs)
> > > diff --git a/common/defrag b/common/defrag
> > > index 055d0d0e9182c5..c054e62bde6f4d 100644
> > > --- a/common/defrag
> > > +++ b/common/defrag
> > > @@ -12,7 +12,7 @@ _require_defrag()
> > >          _require_xfs_io_command "falloc"
> > >          DEFRAG_PROG="$XFS_FSR_PROG"
> > >         ;;
> > > -    ext4)
> > > +    fuse.ext4|ext4)
> > >         testfile="$TEST_DIR/$$-test.defrag"
> > >         donorfile="$TEST_DIR/$$-donor.defrag"
> > >         bsize=`_get_block_size $TEST_DIR`
> > 
> > and here
> > 
> > > diff --git a/common/encrypt b/common/encrypt
> > > index f2687631b214cf..4fa7b6853fd461 100644
> > > --- a/common/encrypt
> > > +++ b/common/encrypt
> > > @@ -191,7 +191,7 @@ _require_hw_wrapped_key_support()
> > >  _scratch_mkfs_encrypted()
> > >  {
> > >         case $FSTYP in
> > > -       ext4|f2fs)
> > > +       fuse.ext4|ext4|f2fs)
> > >                 _scratch_mkfs -O encrypt
> > >                 ;;
> > 
> > and here
> > 
> > >         ubifs)
> > > @@ -210,7 +210,7 @@ _scratch_mkfs_encrypted()
> > >  _scratch_mkfs_sized_encrypted()
> > >  {
> > >         case $FSTYP in
> > > -       ext4|f2fs)
> > > +       fuse.ext4|ext4|f2fs)
> > >                 MKFS_OPTIONS="$MKFS_OPTIONS -O encrypt" _scratch_mkfs_sized $*
> > >                 ;;
> > 
> > and here... I think you got my point.
> > 
> > Thanks,
> > Amir.
> > 
> 


