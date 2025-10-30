Return-Path: <linux-fsdevel+bounces-66445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B38DC1F63B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 10:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D5C214E8E0B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 09:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1DD34DCF4;
	Thu, 30 Oct 2025 09:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYDg0kcJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EDF34D924
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 09:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761817883; cv=none; b=ARNyOM1iU5oSqGVPzSV4TRdN4e1DxV7VzLwZWGQgTSgS1RawVFN2k6SIkqk4HKcQOlbE0CEaziXd3u9ZMe1oKq9yvvuwbbVMVha2Fb91rq2OhMEQMYndkzrlmXIvNDrMzUrsILJVP9n28V+B/o/gzIpxLCMJ7gasXCWOJMKN7x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761817883; c=relaxed/simple;
	bh=Bdna/k+BaGIX8LkaT6I2ZdXbUrQKJnVTyqDgNR+l4hQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e024GGsYQTusAmUaRErv8sQ11KgLu/qiWAj97W/Rpm0HqmrLzHYmR5SCZ09HLIrYRfkeUlon0NPLb4y1QrsRDwg2VPvndUI/W4BtHWi0e0KFaLLYi0AiY5sCYPC3hdVAecRYro5LbGe7mj5YDsYQee71QfHAV209KZ1eLve0aJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYDg0kcJ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b64cdbb949cso194072066b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 02:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761817878; x=1762422678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5VVNoQwAWyxLpv1h4Yk/Mj6zmb3mSEma5Re6w3inwA=;
        b=MYDg0kcJWLY2+kI9HNpKPEaTQOvLdTAgJwygpyQg71tnZm+yOM7kcr62DpcJAdwjvm
         LcSd8q32sgcRcbX5tp0ZGHU8F8lLRiY1UmndI0dYDDLfSp9L/M73x58rZeh9giXJrixt
         DBrl7NNXrKL69/n2V7SPuNQghJ9Rcar893iMunLrVCX6wpCroZA5ToLBCjshDjZwunDv
         YfZmj58HAAlaYT22/ps3oGptcBK67jOHk+awfV/fuqFrT3ytFuM/sAT9xdNaHJfxywbk
         vvi0L2cooCImXwjDBQJ27ZhnXKOMK0cvFi5hnVee6RQFoctWsKw2LZNW+JAesdCmCSCf
         npVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761817878; x=1762422678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q5VVNoQwAWyxLpv1h4Yk/Mj6zmb3mSEma5Re6w3inwA=;
        b=SNjwRSgvrHPTwNrKFfrkIGqLb2qtJwD4QxWli+DvbjpuuZM6He+K5q7UjLwDoTsrfX
         SjNLyke/SPk7VBdkFky/Xanpw+vEUnFrDdacEpm/0PEBYSdbKPXlmq3qL/xgtc8SyLmP
         q7x/kKXA0T40DxjF4crDVnl27tNKtBcEnVhM/AwqBw+LvhH0irsw5j15N5MUo75eyoFo
         03KOTHT3MJd23u9JNU3WSkGj/4ZYJ1OmWyqVUYSXnVz0yAMGiMeGurWT6lpUZNWmCChe
         65CujizRUW/YTW7CHmie0TovKzUfmPSTa4pZMkgKNNSRK6AgpNQROUN0kbsxmgId1OgP
         e4RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdNVN8U0yOf6J13sHiSFgoca3dCE4vluwS00r6it70YQqh5yBhJbi+6etrmLTov3ro5wEb+scq5TaoNP8u@vger.kernel.org
X-Gm-Message-State: AOJu0YySJiUgmMnBVjkZvSKGOE+ZpIRSTNxksPu32ZAZ2DC90WOxFM5T
	Cf/qfiNa6C62alW5+i6ionIQY+x4AKDF3JfJ/TkdTYwL4kaoU/9FNDDqZx+2AOCHUswla3sPsi1
	UVLtEVvEu+LexReTcVQoNbZ96xdtu3sI=
X-Gm-Gg: ASbGnct2E3moWvQA7qNFyxNZXHSaP6sPyEHRSbm0PwGS2Ac58wtAFHXspH3+nT/Gmqy
	xL4OWD8NkDuUkdlmGsEEe79ySjb1YUk+851VywSmsOKsRPT+Al2bwNIAkllg/xWkrI0CtkM2VkT
	ZVWJfry+jRzCVtHA0qOp+hMmbyNEA+o194YhxxuOpboWzdorQ6YhYDOx0nHljVnXHm+zApEbd9g
	b5QFpMNzf9zrIR629wq/EyagtgCGQvlMesGEu7o3FbDLO2mh6GsIDt4BvXDitfMC2oMYmbXE5Hx
	qc+R1J3YjRnuPOudwu4jcpZaYvcntg==
X-Google-Smtp-Source: AGHT+IELIK29pokw4BqrETi6ux8k4VU44qQ8Wmg/FKWNqv6zxVGH3i0jvrbk20hFfDtK/D19rPcWE0k9BP36i6GETJE=
X-Received: by 2002:a17:906:c150:b0:b6d:825b:828 with SMTP id
 a640c23a62f3a-b703d2fe70amr635701766b.25.1761817877746; Thu, 30 Oct 2025
 02:51:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs> <176169819994.1433624.4365613323075287467.stgit@frogsfrogsfrogs>
In-Reply-To: <176169819994.1433624.4365613323075287467.stgit@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 30 Oct 2025 10:51:06 +0100
X-Gm-Features: AWmQ_blB63OMqxUWNdRkp3OOlUR9_IfpMd0IzrnF48FrTNtUADrYcfamedHhE2k
Message-ID: <CAOQ4uxj7yaX5qLEs4BOJBJwybkHzv8WmNsUt0w_zehueOLLP9A@mail.gmail.com>
Subject: Re: [PATCH 01/33] misc: adapt tests to handle the fuse ext[234] drivers
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, neal@gompa.dev, fstests@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	joannelkoong@gmail.com, bernd@bsbernd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 2:22=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> It would be useful to be able to run fstests against the userspace
> ext[234] driver program fuse2fs.  A convention (at least on Debian)
> seems to be to install fuse drivers as /sbin/mount.fuse.XXX so that
> users can run "mount -t fuse.XXX" to start a fuse driver for a
> disk-based filesystem type XXX.
>
> Therefore, we'll adopt the practice of setting FSTYP=3Dfuse.ext4 to
> test ext4 with fuse2fs.  Change all the library code as needed to handle
> this new type alongside all the existing ext[234] checks, which seems a
> little cleaner than FSTYP=3Dfuse FUSE_SUBTYPE=3Dext4, which also would
> require even more treewide cleanups to work properly because most
> fstests code switches on $FSTYP alone.
>

I agree that FSTYP=3Dfuse.ext4 is cleaner than
FSTYP=3Dfuse FUSE_SUBTYPE=3Dext4
but it is not extendable to future (e.g. fuse.xfs)
and it is still a bit ugly.

Consider:
FSTYP=3Dfuse.ext4
MKFSTYP=3Dext4

I think this is the correct abstraction -
fuse2fs/ext4 are formatted that same and mounted differently

See how some of your patch looks nicer and naturally extends to
the imaginary fuse.xfs...

> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  check             |   24 +++++++++++++++++-------
>  common/casefold   |    4 ++++
>  common/config     |   11 ++++++++---
>  common/defrag     |    2 +-
>  common/encrypt    |   16 ++++++++--------
>  common/log        |   10 +++++-----
>  common/populate   |   14 +++++++-------
>  common/quota      |    9 +++++++++
>  common/rc         |   50 +++++++++++++++++++++++++++++------------------=
---
>  common/report     |    2 +-
>  common/verity     |    8 ++++----
>  tests/generic/020 |    2 +-
>  tests/generic/067 |    2 +-
>  tests/generic/441 |    2 +-
>  tests/generic/496 |    2 +-
>  tests/generic/621 |    2 +-
>  tests/generic/740 |    2 +-
>  tests/generic/746 |    4 ++--
>  tests/generic/765 |    4 ++--
>  19 files changed, 103 insertions(+), 67 deletions(-)
>
>
> diff --git a/check b/check
> index 9bb80a22440f97..81cd03f73ce155 100755
> --- a/check
> +++ b/check
> @@ -140,12 +140,25 @@ get_sub_group_list()
>         echo $grpl
>  }
>
> +get_group_dirs()
> +{
> +       local fsgroup=3D"$FSTYP"
> +
> +       case "$FSTYP" in
> +       ext2|ext3|fuse.ext[234])
> +               fsgroup=3Dext4
> +               ;;
> +       esac
> +
> +       echo $SRC_GROUPS
> +       echo $fsgroup
> +}
> +
>  get_group_list()
>  {
>         local grp=3D$1
>         local grpl=3D""
>         local sub=3D$(dirname $grp)
> -       local fsgroup=3D"$FSTYP"
>
>         if [ -n "$sub" -a "$sub" !=3D "." -a -d "$SRC_DIR/$sub" ]; then
>                 # group is given as <subdir>/<group> (e.g. xfs/quick)
> @@ -154,10 +167,7 @@ get_group_list()
>                 return
>         fi
>
> -       if [ "$FSTYP" =3D ext2 -o "$FSTYP" =3D ext3 ]; then
> -           fsgroup=3Dext4
> -       fi
> -       for d in $SRC_GROUPS $fsgroup; do
> +       for d in $(get_group_dirs); do
>                 if ! test -d "$SRC_DIR/$d" ; then
>                         continue
>                 fi
> @@ -171,7 +181,7 @@ get_group_list()
>  get_all_tests()
>  {
>         touch $tmp.list
> -       for d in $SRC_GROUPS $FSTYP; do
> +       for d in $(get_group_dirs); do
>                 if ! test -d "$SRC_DIR/$d" ; then
>                         continue
>                 fi
> @@ -387,7 +397,7 @@ if [ -n "$FUZZ_REWRITE_DURATION" ]; then
>  fi
>
>  if [ -n "$subdir_xfile" ]; then
> -       for d in $SRC_GROUPS $FSTYP; do
> +       for d in $(get_group_dirs); do
>                 [ -f $SRC_DIR/$d/$subdir_xfile ] || continue
>                 for f in `sed "s/#.*$//" $SRC_DIR/$d/$subdir_xfile`; do
>                         exclude_tests+=3D($d/$f)
> diff --git a/common/casefold b/common/casefold
> index 2aae5e5e6c8925..fcdb4d210028ac 100644
> --- a/common/casefold
> +++ b/common/casefold
> @@ -6,6 +6,10 @@
>  _has_casefold_kernel_support()
>  {
>         case $FSTYP in
> +       fuse.ext[234])
> +               # fuse2fs does not support casefolding
> +               false
> +               ;;

This would not be needed

>         ext4)
>                 test -f '/sys/fs/ext4/features/casefold'
>                 ;;
> diff --git a/common/config b/common/config
> index 7fa97319d7d0ca..0cd2b33c4ade40 100644
> --- a/common/config
> +++ b/common/config
> @@ -386,6 +386,11 @@ _common_mount_opts()
>         overlay)
>                 echo $OVERLAY_MOUNT_OPTIONS
>                 ;;
> +       fuse.ext[234])
> +               # fuse sets up secure defaults, so we must explicitly tel=
l
> +               # fuse2fs to use the more relaxed kernel access behaviors=
.
> +               echo "-o kernel $EXT_MOUNT_OPTIONS"
> +               ;;
>         ext2|ext3|ext4)
>                 # acls & xattrs aren't turned on by default on ext$FOO
>                 echo "-o acl,user_xattr $EXT_MOUNT_OPTIONS"
> @@ -472,7 +477,7 @@ _mkfs_opts()
>  _fsck_opts()
>  {
>         case $FSTYP in

This would obviously be $MKFSTYP with no further changes

> -       ext2|ext3|ext4)
> +       ext2|ext3|fuse.ext[234]|ext4)
>                 export FSCK_OPTIONS=3D"-nf"
>                 ;;
>         reiser*)
> @@ -514,11 +519,11 @@ _source_specific_fs()
>
>                 . ./common/btrfs
>                 ;;
> -       ext4)
> +       fuse.ext4|ext4)
>                 [ "$MKFS_EXT4_PROG" =3D "" ] && _fatal "mkfs.ext4 not fou=
nd"
>                 . ./common/ext4
>                 ;;
> -       ext2|ext3)
> +       ext2|ext3|fuse.ext[23])
>                 . ./common/ext4

same here

>                 ;;
>         f2fs)
> diff --git a/common/defrag b/common/defrag
> index 055d0d0e9182c5..c054e62bde6f4d 100644
> --- a/common/defrag
> +++ b/common/defrag
> @@ -12,7 +12,7 @@ _require_defrag()
>          _require_xfs_io_command "falloc"
>          DEFRAG_PROG=3D"$XFS_FSR_PROG"
>         ;;
> -    ext4)
> +    fuse.ext4|ext4)
>         testfile=3D"$TEST_DIR/$$-test.defrag"
>         donorfile=3D"$TEST_DIR/$$-donor.defrag"
>         bsize=3D`_get_block_size $TEST_DIR`

and here

> diff --git a/common/encrypt b/common/encrypt
> index f2687631b214cf..4fa7b6853fd461 100644
> --- a/common/encrypt
> +++ b/common/encrypt
> @@ -191,7 +191,7 @@ _require_hw_wrapped_key_support()
>  _scratch_mkfs_encrypted()
>  {
>         case $FSTYP in
> -       ext4|f2fs)
> +       fuse.ext4|ext4|f2fs)
>                 _scratch_mkfs -O encrypt
>                 ;;

and here

>         ubifs)
> @@ -210,7 +210,7 @@ _scratch_mkfs_encrypted()
>  _scratch_mkfs_sized_encrypted()
>  {
>         case $FSTYP in
> -       ext4|f2fs)
> +       fuse.ext4|ext4|f2fs)
>                 MKFS_OPTIONS=3D"$MKFS_OPTIONS -O encrypt" _scratch_mkfs_s=
ized $*
>                 ;;

and here... I think you got my point.

Thanks,
Amir.

