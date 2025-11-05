Return-Path: <linux-fsdevel+bounces-67227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AE374C3844C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 23:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E44E4F0F09
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 22:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444302E0407;
	Wed,  5 Nov 2025 22:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PeKuCXyT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974972D0631;
	Wed,  5 Nov 2025 22:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762383236; cv=none; b=aUUwkHkyH70eWfZblN3ddAAvKo8gETXwqVnYksj+yK5XEWn1N7Q1kVtbuf/7L0jD+V4cf/1tQarF2Jq4e0nFUC3IT7GTtoPtTFwZou+QwE6+yeX7dAwlTHGJo02MbzgQiZxJyScdzqc2avwqvDHxApnYXZoxBDl3iW+8KtXz7t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762383236; c=relaxed/simple;
	bh=ynMLpSbNVbUJVeGYFfQcm4ptkEtNwDrG6gEBd+Y4KiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKCWbrvbbLgURtpQVcts6VVGYXqar0rgDXjK+VyBbWX6ITwkAziPSQ8DjViPsjrotR2hj6wlmEVEzEeG54DPyasGmSCUjGCXG1u0XLBAWe8OzathG+jhKnekQs0B5srKinZeqM77FTv5SPVSZCEhG2dHF09E0YRiQo+RSvLiwyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PeKuCXyT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C4DC4CEF5;
	Wed,  5 Nov 2025 22:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762383236;
	bh=ynMLpSbNVbUJVeGYFfQcm4ptkEtNwDrG6gEBd+Y4KiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PeKuCXyTYy0rVSoo3qcRZjwB2oovzip75nL11bbXc53halFJGTMaDHIJPgTps5vGT
	 OfWhwH6rfmOtG+WoC33f6zwopYzoN6bTtnsYeo1VnV4f3jiY1txXznbN7krFF/zUve
	 m06os6NNfj42lBEVJJhGj/2ptFrqiEXvpq4xHDLzeictMGb4WU93LlQbkTkNQfiTbj
	 eA2eoE8lAiDIBk6OjGJlH21Wt/Z1J90vc3Z1/8b3fYNfMyQtkHshXTax3VjnBrxaqT
	 5pvePJt5obrgU4G6wNpsiVl/VGBB68nWrTNxw0axFw2A/dISOjCiBw9JBflJ9mVA3S
	 4827zmrJrZH+A==
Date: Wed, 5 Nov 2025 14:53:55 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: zlang@redhat.com, neal@gompa.dev, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joannelkoong@gmail.com, bernd@bsbernd.com
Subject: Re: [PATCH 01/33] misc: adapt tests to handle the fuse ext[234]
 drivers
Message-ID: <20251105225355.GC196358@frogsfrogsfrogs>
References: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
 <176169819994.1433624.4365613323075287467.stgit@frogsfrogsfrogs>
 <CAOQ4uxj7yaX5qLEs4BOJBJwybkHzv8WmNsUt0w_zehueOLLP9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxj7yaX5qLEs4BOJBJwybkHzv8WmNsUt0w_zehueOLLP9A@mail.gmail.com>

On Thu, Oct 30, 2025 at 10:51:06AM +0100, Amir Goldstein wrote:
> On Wed, Oct 29, 2025 at 2:22 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > It would be useful to be able to run fstests against the userspace
> > ext[234] driver program fuse2fs.  A convention (at least on Debian)
> > seems to be to install fuse drivers as /sbin/mount.fuse.XXX so that
> > users can run "mount -t fuse.XXX" to start a fuse driver for a
> > disk-based filesystem type XXX.
> >
> > Therefore, we'll adopt the practice of setting FSTYP=fuse.ext4 to
> > test ext4 with fuse2fs.  Change all the library code as needed to handle
> > this new type alongside all the existing ext[234] checks, which seems a
> > little cleaner than FSTYP=fuse FUSE_SUBTYPE=ext4, which also would
> > require even more treewide cleanups to work properly because most
> > fstests code switches on $FSTYP alone.
> >
> 
> I agree that FSTYP=fuse.ext4 is cleaner than
> FSTYP=fuse FUSE_SUBTYPE=ext4
> but it is not extendable to future (e.g. fuse.xfs)
> and it is still a bit ugly.
> 
> Consider:
> FSTYP=fuse.ext4
> MKFSTYP=ext4
> 
> I think this is the correct abstraction -
> fuse2fs/ext4 are formatted that same and mounted differently
> 
> See how some of your patch looks nicer and naturally extends to
> the imaginary fuse.xfs...

Maybe I'd rather do it the other way around for fuse4fs:

FSTYP=ext4
MOUNT_FSTYP=fuse.ext4

(obviously, MOUNT_FSTYP=$FSTYP if the test runner hasn't overridden it)

Where $MOUNT_FSTYP is what you pass to mount -t and what you'd see in
/proc/mounts.  The only weirdness with that is that some of the helpers
will end up with code like:

	case $FSTYP in
	ext4)
		# do ext4 stuff
		;;
	esac

	case $MOUNT_FSTYP in
	fuse.ext4)
		# do fuse4fs stuff that overrides ext4
		;;
	esac

which would be a little weird.

_scratch_mount would end up with:

	$MOUNT_PROG -t $MOUNT_FSTYP ...

and detecting it would be

	grep -q -w $MOUNT_FSTYP /proc/mounts || _fail "booooo"

Hrm?

--D

> 
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  check             |   24 +++++++++++++++++-------
> >  common/casefold   |    4 ++++
> >  common/config     |   11 ++++++++---
> >  common/defrag     |    2 +-
> >  common/encrypt    |   16 ++++++++--------
> >  common/log        |   10 +++++-----
> >  common/populate   |   14 +++++++-------
> >  common/quota      |    9 +++++++++
> >  common/rc         |   50 +++++++++++++++++++++++++++++---------------------
> >  common/report     |    2 +-
> >  common/verity     |    8 ++++----
> >  tests/generic/020 |    2 +-
> >  tests/generic/067 |    2 +-
> >  tests/generic/441 |    2 +-
> >  tests/generic/496 |    2 +-
> >  tests/generic/621 |    2 +-
> >  tests/generic/740 |    2 +-
> >  tests/generic/746 |    4 ++--
> >  tests/generic/765 |    4 ++--
> >  19 files changed, 103 insertions(+), 67 deletions(-)
> >
> >
> > diff --git a/check b/check
> > index 9bb80a22440f97..81cd03f73ce155 100755
> > --- a/check
> > +++ b/check
> > @@ -140,12 +140,25 @@ get_sub_group_list()
> >         echo $grpl
> >  }
> >
> > +get_group_dirs()
> > +{
> > +       local fsgroup="$FSTYP"
> > +
> > +       case "$FSTYP" in
> > +       ext2|ext3|fuse.ext[234])
> > +               fsgroup=ext4
> > +               ;;
> > +       esac
> > +
> > +       echo $SRC_GROUPS
> > +       echo $fsgroup
> > +}
> > +
> >  get_group_list()
> >  {
> >         local grp=$1
> >         local grpl=""
> >         local sub=$(dirname $grp)
> > -       local fsgroup="$FSTYP"
> >
> >         if [ -n "$sub" -a "$sub" != "." -a -d "$SRC_DIR/$sub" ]; then
> >                 # group is given as <subdir>/<group> (e.g. xfs/quick)
> > @@ -154,10 +167,7 @@ get_group_list()
> >                 return
> >         fi
> >
> > -       if [ "$FSTYP" = ext2 -o "$FSTYP" = ext3 ]; then
> > -           fsgroup=ext4
> > -       fi
> > -       for d in $SRC_GROUPS $fsgroup; do
> > +       for d in $(get_group_dirs); do
> >                 if ! test -d "$SRC_DIR/$d" ; then
> >                         continue
> >                 fi
> > @@ -171,7 +181,7 @@ get_group_list()
> >  get_all_tests()
> >  {
> >         touch $tmp.list
> > -       for d in $SRC_GROUPS $FSTYP; do
> > +       for d in $(get_group_dirs); do
> >                 if ! test -d "$SRC_DIR/$d" ; then
> >                         continue
> >                 fi
> > @@ -387,7 +397,7 @@ if [ -n "$FUZZ_REWRITE_DURATION" ]; then
> >  fi
> >
> >  if [ -n "$subdir_xfile" ]; then
> > -       for d in $SRC_GROUPS $FSTYP; do
> > +       for d in $(get_group_dirs); do
> >                 [ -f $SRC_DIR/$d/$subdir_xfile ] || continue
> >                 for f in `sed "s/#.*$//" $SRC_DIR/$d/$subdir_xfile`; do
> >                         exclude_tests+=($d/$f)
> > diff --git a/common/casefold b/common/casefold
> > index 2aae5e5e6c8925..fcdb4d210028ac 100644
> > --- a/common/casefold
> > +++ b/common/casefold
> > @@ -6,6 +6,10 @@
> >  _has_casefold_kernel_support()
> >  {
> >         case $FSTYP in
> > +       fuse.ext[234])
> > +               # fuse2fs does not support casefolding
> > +               false
> > +               ;;
> 
> This would not be needed
> 
> >         ext4)
> >                 test -f '/sys/fs/ext4/features/casefold'
> >                 ;;
> > diff --git a/common/config b/common/config
> > index 7fa97319d7d0ca..0cd2b33c4ade40 100644
> > --- a/common/config
> > +++ b/common/config
> > @@ -386,6 +386,11 @@ _common_mount_opts()
> >         overlay)
> >                 echo $OVERLAY_MOUNT_OPTIONS
> >                 ;;
> > +       fuse.ext[234])
> > +               # fuse sets up secure defaults, so we must explicitly tell
> > +               # fuse2fs to use the more relaxed kernel access behaviors.
> > +               echo "-o kernel $EXT_MOUNT_OPTIONS"
> > +               ;;
> >         ext2|ext3|ext4)
> >                 # acls & xattrs aren't turned on by default on ext$FOO
> >                 echo "-o acl,user_xattr $EXT_MOUNT_OPTIONS"
> > @@ -472,7 +477,7 @@ _mkfs_opts()
> >  _fsck_opts()
> >  {
> >         case $FSTYP in
> 
> This would obviously be $MKFSTYP with no further changes
> 
> > -       ext2|ext3|ext4)
> > +       ext2|ext3|fuse.ext[234]|ext4)
> >                 export FSCK_OPTIONS="-nf"
> >                 ;;
> >         reiser*)
> > @@ -514,11 +519,11 @@ _source_specific_fs()
> >
> >                 . ./common/btrfs
> >                 ;;
> > -       ext4)
> > +       fuse.ext4|ext4)
> >                 [ "$MKFS_EXT4_PROG" = "" ] && _fatal "mkfs.ext4 not found"
> >                 . ./common/ext4
> >                 ;;
> > -       ext2|ext3)
> > +       ext2|ext3|fuse.ext[23])
> >                 . ./common/ext4
> 
> same here
> 
> >                 ;;
> >         f2fs)
> > diff --git a/common/defrag b/common/defrag
> > index 055d0d0e9182c5..c054e62bde6f4d 100644
> > --- a/common/defrag
> > +++ b/common/defrag
> > @@ -12,7 +12,7 @@ _require_defrag()
> >          _require_xfs_io_command "falloc"
> >          DEFRAG_PROG="$XFS_FSR_PROG"
> >         ;;
> > -    ext4)
> > +    fuse.ext4|ext4)
> >         testfile="$TEST_DIR/$$-test.defrag"
> >         donorfile="$TEST_DIR/$$-donor.defrag"
> >         bsize=`_get_block_size $TEST_DIR`
> 
> and here
> 
> > diff --git a/common/encrypt b/common/encrypt
> > index f2687631b214cf..4fa7b6853fd461 100644
> > --- a/common/encrypt
> > +++ b/common/encrypt
> > @@ -191,7 +191,7 @@ _require_hw_wrapped_key_support()
> >  _scratch_mkfs_encrypted()
> >  {
> >         case $FSTYP in
> > -       ext4|f2fs)
> > +       fuse.ext4|ext4|f2fs)
> >                 _scratch_mkfs -O encrypt
> >                 ;;
> 
> and here
> 
> >         ubifs)
> > @@ -210,7 +210,7 @@ _scratch_mkfs_encrypted()
> >  _scratch_mkfs_sized_encrypted()
> >  {
> >         case $FSTYP in
> > -       ext4|f2fs)
> > +       fuse.ext4|ext4|f2fs)
> >                 MKFS_OPTIONS="$MKFS_OPTIONS -O encrypt" _scratch_mkfs_sized $*
> >                 ;;
> 
> and here... I think you got my point.
> 
> Thanks,
> Amir.
> 

