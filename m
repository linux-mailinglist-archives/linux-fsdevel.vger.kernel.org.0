Return-Path: <linux-fsdevel+bounces-28622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E3296C700
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 21:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A94A31F2244B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 19:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B140013C673;
	Wed,  4 Sep 2024 19:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="YnsRoz7u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F948121F;
	Wed,  4 Sep 2024 19:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725476481; cv=none; b=p/T/roB0K/FwtROKmz9+E9LRQJhF8h5IsiRKsEpKq2ZShqTmCCxGX9utk9AqVctM/z5XcZ7tqHNjEtzne4Ppyzv/OUUzEoTjQZrJ1C6wsum1M53rzFu56KZHgsLCFhYD5df/BKHhvRgIyeXI9cd26kMiRIrh/h5JNNS++tOpy0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725476481; c=relaxed/simple;
	bh=7eVPAWD7u0oCwemb5UaskDkmMCiOKdzg7B5GaQvolZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOR2X6TLf3B3hmJ31SiQ3A6l4GflgBPhJC3n+Z23riENweWjCczq7He6NcIt4poZ7GeKE6Haa4bI9jzjsq5KnN7kNm76xj68LJabD8t8qqV+xuGJ27L6IuZMIiwWAeBAUc36nsHco3b7eOzNXGWR68YyBp/KGi5su7NLMl2jq8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=YnsRoz7u; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WzWzl4gk9z9sxJ;
	Wed,  4 Sep 2024 21:01:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1725476467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pv1gX6AoAYOONckDDkDyKlXT6qAc0DAgmLU0m9ZD2A0=;
	b=YnsRoz7uFI8BlTSonn5pLqCf8FyDxogOJqiKXZVTetL1KVCKLiBqgBTvHkLjRxGPH9yw1W
	vRtYCWXKcphzigWD4GIa7Dw0DoAy91YVKL0MIDIeUOlGl/E++Kvurw8Bqn47DIfAFBHmOM
	YYDNHatPNphiSlGBYbcvnOyFm00oxFUxtnICNpi1vXGe5PKNWp0PYOTMA3aNx40os476dm
	7Kqh9IFu8Mq+mX+VkBxXGylBDVmoRvNEWs195ns/C5tXWWAfixubMbg9zgUZPCMTV+/uZQ
	mIxLyc9cEdZ1oQ3bJHBTpCnacdYmL1iQvKSmUSoOhjnxPFTt46CQIUX+kqVUzg==
Date: Thu, 5 Sep 2024 05:00:45 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: fstests@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Alexander Aring <alex.aring@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Christoph Hellwig <hch@infradead.org>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH xfstests v3 2/2] generic/756: test
 name_to_handle_at(AT_HANDLE_MNT_ID_UNIQUE) explicitly
Message-ID: <20240904.185915-mundane.creels.ceramic.region-AXUMFBqDC1ZD@cyphar.com>
References: <20240828-exportfs-u64-mount-id-v3-0-10c2c4c16708@cyphar.com>
 <20240904175639.2269694-1-cyphar@cyphar.com>
 <20240904175639.2269694-2-cyphar@cyphar.com>
 <CAOQ4uxj0X2GJLvB=HyR7_kr=SvqQ0dGapVnf9Ft1hWcaXXCJVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z42o635q3rq4mue5"
Content-Disposition: inline
In-Reply-To: <CAOQ4uxj0X2GJLvB=HyR7_kr=SvqQ0dGapVnf9Ft1hWcaXXCJVw@mail.gmail.com>
X-Rspamd-Queue-Id: 4WzWzl4gk9z9sxJ


--z42o635q3rq4mue5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-09-04, Amir Goldstein <amir73il@gmail.com> wrote:
> On Wed, Sep 4, 2024 at 7:57=E2=80=AFPM Aleksa Sarai <cyphar@cyphar.com> w=
rote:
> >
> > In order to make sure we are actually testing AT_HANDLE_MNT_ID_UNIQUE,
> > add a test (based on generic/426) which runs the open_by_handle in a
> > mode where it will error out if there is a problem with getting mount
> > IDs. The test is skipped if the kernel doesn't support the necessary
> > features.
> >
> > Suggested-by: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
>=20
> Apart from one minor nits below, you may add:
>=20
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
>=20
> > ---
> >  common/rc             | 24 ++++++++++++++++
> >  src/open_by_handle.c  | 63 ++++++++++++++++++++++++++++++++++-------
> >  tests/generic/756     | 65 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/756.out |  5 ++++
> >  4 files changed, 147 insertions(+), 10 deletions(-)
> >  create mode 100755 tests/generic/756
> >  create mode 100644 tests/generic/756.out
> >
> > diff --git a/common/rc b/common/rc
> > index 9da9fe188297..0beaf2ff1126 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -5178,6 +5178,30 @@ _require_fibmap()
> >         rm -f $file
> >  }
> >
> > +_require_statx_unique_mountid()
> > +{
> > +       # statx(STATX_MNT_ID=3D0x1000) was added in Linux 5.8.
> > +       # statx(STATX_MNT_ID_UNIQUE=3D0x4000) was added in Linux 6.9.
> > +       # We only need to check the latter.
> > +
> > +       export STATX_MNT_ID_UNIQUE=3D0x4000
> > +       local statx_mask=3D$(
> > +               ${XFS_IO_PROG} -c "statx -m $STATX_MNT_ID_UNIQUE -r" "$=
TEST_DIR" |
> > +               sed -En 's/stat\.mask =3D (0x[0-9a-f]+)/\1/p'
> > +       )
> > +
> > +       [[ $(( statx_mask & STATX_MNT_ID_UNIQUE )) =3D=3D $((STATX_MNT_=
ID_UNIQUE)) ]] ||
> > +               _notrun "statx does not support STATX_MNT_ID_UNIQUE on =
this kernel"
> > +}
> > +
> > +_require_open_by_handle_unique_mountid()
> > +{
> > +       _require_test_program "open_by_handle"
> > +
> > +       $here/src/open_by_handle -C AT_HANDLE_MNT_ID_UNIQUE 2>&1 \
> > +               || _notrun "name_to_handle_at does not support AT_HANDL=
E_MNT_ID_UNIQUE"
> > +}
> > +
> >  _try_wipe_scratch_devs()
> >  {
> >         test -x "$WIPEFS_PROG" || return 0
> > diff --git a/src/open_by_handle.c b/src/open_by_handle.c
> > index 920ec7d9170b..b5c1a30abbbc 100644
> > --- a/src/open_by_handle.c
> > +++ b/src/open_by_handle.c
> > @@ -106,9 +106,11 @@ struct handle {
> >
> >  void usage(void)
> >  {
> > -       fprintf(stderr, "usage: open_by_handle [-cludmrwapknhs] [<-i|-o=
> <handles_file>] <test_dir> [num_files]\n");
> > +       fprintf(stderr, "usage: open_by_handle [-cludmMrwapknhs] [<-i|-=
o> <handles_file>] <test_dir> [num_files]\n");
> > +       fprintf(stderr, "       open_by_handle -C <feature>\n");
> >         fprintf(stderr, "\n");
> >         fprintf(stderr, "open_by_handle -c <test_dir> [N] - create N te=
st files under test_dir, try to get file handles and exit\n");
> > +       fprintf(stderr, "open_by_handle -c <test_dir> [N] - create N te=
st files under test_dir, try to get file handles and exit\n");
> >         fprintf(stderr, "open_by_handle    <test_dir> [N] - get file ha=
ndles of test files, drop caches and try to open by handle\n");
> >         fprintf(stderr, "open_by_handle -n <test_dir> [N] - get file ha=
ndles of test files and try to open by handle without drop caches\n");
> >         fprintf(stderr, "open_by_handle -k <test_dir> [N] - get file ha=
ndles of files that are kept open, drop caches and try to open by handle\n"=
);
> > @@ -117,19 +119,23 @@ void usage(void)
> >         fprintf(stderr, "open_by_handle -a <test_dir> [N] - write data =
to test files after open by handle\n");
> >         fprintf(stderr, "open_by_handle -l <test_dir> [N] - create hard=
links to test files, drop caches and try to open by handle\n");
> >         fprintf(stderr, "open_by_handle -u <test_dir> [N] - unlink (har=
dlinked) test files, drop caches and try to open by handle\n");
> > -       fprintf(stderr, "open_by_handle -U <test_dir> [N] - verify the =
mount ID returned with AT_HANDLE_MNT_ID_UNIQUE is correct\n");
>=20
> I guess this was not supposed to be in the first patch

Yeah, it got mixed up when splitting the patch. I'll fix it up.

> >         fprintf(stderr, "open_by_handle -d <test_dir> [N] - unlink test=
 files and hardlinks, drop caches and try to open by handle\n");
> >         fprintf(stderr, "open_by_handle -m <test_dir> [N] - rename test=
 files, drop caches and try to open by handle\n");
> > +       fprintf(stderr, "open_by_handle -M <test_dir> [N] - do not sile=
ntly skip the mount ID verifications\n");
> >         fprintf(stderr, "open_by_handle -p <test_dir>     - create/dele=
te and try to open by handle also test_dir itself\n");
> >         fprintf(stderr, "open_by_handle -i <handles_file> <test_dir> [N=
] - read test files handles from file and try to open by handle\n");
> >         fprintf(stderr, "open_by_handle -o <handles_file> <test_dir> [N=
] - get file handles of test files and write handles to file\n");
> >         fprintf(stderr, "open_by_handle -s <test_dir> [N] - wait in sle=
ep loop after opening files by handle to keep them open\n");
> >         fprintf(stderr, "open_by_handle -z <test_dir> [N] - query files=
ystem required buffer size\n");
> > +       fprintf(stderr, "\n");
> > +       fprintf(stderr, "open_by_handle -C <feature>      - check if <f=
eature> is supported by the kernel.\n");
> > +       fprintf(stderr, "  <feature> can be any of the following values=
:\n");
> > +       fprintf(stderr, "  - AT_HANDLE_MNT_ID_UNIQUE\n");
> >         exit(EXIT_FAILURE);
> >  }
> >
> >  static int do_name_to_handle_at(const char *fname, struct file_handle =
*fh,
> > -                               int bufsz)
> > +                               int bufsz, bool force_check_mountid)
> >  {
> >         int ret;
> >         int mntid_short;
> > @@ -145,10 +151,15 @@ static int do_name_to_handle_at(const char *fname=
, struct file_handle *fh,
> >                         fprintf(stderr, "%s: statx(STATX_MNT_ID): %m\n"=
, fname);
> >                         return EXIT_FAILURE;
> >                 }
> > -               if (!(statxbuf.stx_mask & STATX_MNT_ID))
> > +               if (!(statxbuf.stx_mask & STATX_MNT_ID)) {
> > +                       if (force_check_mountid) {
> > +                               fprintf(stderr, "%s: statx(STATX_MNT_ID=
) not supported by running kernel\n", fname);
> > +                               return EXIT_FAILURE;
> > +                       }
> >                         skip_mntid =3D true;
> > -               else
> > +               } else {
> >                         statx_mntid_short =3D statxbuf.stx_mnt_id;
> > +               }
> >         }
> >
> >         if (!skip_mntid_unique) {
> > @@ -160,10 +171,15 @@ static int do_name_to_handle_at(const char *fname=
, struct file_handle *fh,
> >                  * STATX_MNT_ID_UNIQUE was added fairly recently in Lin=
ux 6.8, so if the
> >                  * kernel doesn't give us a unique mount ID just skip i=
t.
> >                  */
> > -               if (!(statxbuf.stx_mask & STATX_MNT_ID_UNIQUE))
> > +               if (!(statxbuf.stx_mask & STATX_MNT_ID_UNIQUE)) {
> > +                       if (force_check_mountid) {
> > +                               fprintf(stderr, "%s: statx(STATX_MNT_ID=
_UNIQUE) not supported by running kernel\n", fname);
> > +                               return EXIT_FAILURE;
> > +                       }
> >                         skip_mntid_unique =3D true;
> > -               else
> > +               } else {
> >                         statx_mntid_unique =3D statxbuf.stx_mnt_id;
> > +               }
> >         }
> >
> >         fh->handle_bytes =3D bufsz;
> > @@ -204,6 +220,10 @@ static int do_name_to_handle_at(const char *fname,=
 struct file_handle *fh,
> >                                 return EXIT_FAILURE;
> >                         }
> >                         /* EINVAL means AT_HANDLE_MNT_ID_UNIQUE is not =
supported */
> > +                       if (force_check_mountid) {
> > +                               fprintf(stderr, "%s: name_to_handle_at(=
AT_HANDLE_MNT_ID_UNIQUE) not supported by running kernel\n", fname);
> > +                               return EXIT_FAILURE;
> > +                       }
> >                         skip_mntid_unique =3D true;
> >                 } else {
> >                         if (mntid_unique !=3D statx_mntid_unique) {
> > @@ -216,6 +236,22 @@ static int do_name_to_handle_at(const char *fname,=
 struct file_handle *fh,
> >         return 0;
> >  }
> >
> > +static int check_feature(const char *feature)
> > +{
> > +       if (!strcmp(feature, "AT_HANDLE_MNT_ID_UNIQUE")) {
> > +               int ret =3D name_to_handle_at(AT_FDCWD, ".", NULL, NULL=
, AT_HANDLE_MNT_ID_UNIQUE);
> > +               /* If AT_HANDLE_MNT_ID_UNIQUE is supported, we get EFAU=
LT. */
> > +               if (ret < 0 && errno =3D=3D EINVAL) {
> > +                       fprintf(stderr, "name_to_handle_at(AT_HANDLE_MN=
T_ID_UNIQUE) not supported by running kernel\n");
> > +                       return EXIT_FAILURE;
> > +               }
> > +               return 0;
> > +       }
> > +
> > +       fprintf(stderr, "unknown feature name '%s'\n", feature);
> > +       return EXIT_FAILURE;
> > +}
> > +
> >  int main(int argc, char **argv)
> >  {
> >         int     i, c;
> > @@ -235,16 +271,20 @@ int main(int argc, char **argv)
> >         int     create =3D 0, delete =3D 0, nlink =3D 1, move =3D 0;
> >         int     rd =3D 0, wr =3D 0, wrafter =3D 0, parent =3D 0;
> >         int     keepopen =3D 0, drop_caches =3D 1, sleep_loop =3D 0;
> > +       int force_check_mountid =3D 0;
> >         int     bufsz =3D MAX_HANDLE_SZ;
> >
> >         if (argc < 2)
> >                 usage();
> >
> > -       while ((c =3D getopt(argc, argv, "cludmrwapknhi:o:sz")) !=3D -1=
) {
> > +       while ((c =3D getopt(argc, argv, "cC:ludmMrwapknhi:o:sz")) !=3D=
 -1) {
> >                 switch (c) {
> >                 case 'c':
> >                         create =3D 1;
> >                         break;
> > +               case 'C':
> > +                       /* Check kernel feature support. */
> > +                       return check_feature(optarg);
> >                 case 'w':
> >                         /* Write data before open_by_handle_at() */
> >                         wr =3D 1;
> > @@ -271,6 +311,9 @@ int main(int argc, char **argv)
> >                 case 'm':
> >                         move =3D 1;
> >                         break;
> > +               case 'M':
> > +                       force_check_mountid =3D 1;
> > +                       break;
> >                 case 'p':
> >                         parent =3D 1;
> >                         break;
> > @@ -403,7 +446,7 @@ int main(int argc, char **argv)
> >                                 return EXIT_FAILURE;
> >                         }
> >                 } else {
> > -                       ret =3D do_name_to_handle_at(fname, &handle[i].=
fh, bufsz);
> > +                       ret =3D do_name_to_handle_at(fname, &handle[i].=
fh, bufsz, force_check_mountid);
> >                         if (ret)
> >                                 return EXIT_FAILURE;
> >                 }
> > @@ -433,7 +476,7 @@ int main(int argc, char **argv)
> >                                 return EXIT_FAILURE;
> >                         }
> >                 } else {
> > -                       ret =3D do_name_to_handle_at(test_dir, &dir_han=
dle.fh, bufsz);
> > +                       ret =3D do_name_to_handle_at(test_dir, &dir_han=
dle.fh, bufsz, force_check_mountid);
> >                         if (ret)
> >                                 return EXIT_FAILURE;
> >                 }
> > diff --git a/tests/generic/756 b/tests/generic/756
> > new file mode 100755
> > index 000000000000..c7a82cfd25f4
> > --- /dev/null
> > +++ b/tests/generic/756
> > @@ -0,0 +1,65 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (C) 2017 CTERA Networks. All Rights Reserved.
> > +# Copyright (C) 2024 Aleksa Sarai <cyphar@cyphar.com>
> > +#
> > +# FS QA Test No. 756
> > +#
> > +# Check stale handles pointing to unlinked files and non-stale handles=
 pointing
> > +# to linked files while verifying that u64 mount IDs are correctly ret=
urned.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick exportfs
> > +
> > +# Import common functions.
> > +. ./common/filter
> > +
> > +
> > +# Modify as appropriate.
> > +_require_test
> > +# _require_exportfs and  already requires open_by_handle, but let's no=
t count on it
> > +_require_test_program "open_by_handle"
> > +_require_exportfs
> > +# We need both STATX_MNT_ID_UNIQUE and AT_HANDLE_MNT_ID_UNIQUE.
> > +_require_statx_unique_mountid
> > +_require_open_by_handle_unique_mountid
> > +
> > +NUMFILES=3D1024
> > +testdir=3D$TEST_DIR/$seq-dir
> > +mkdir -p $testdir
> > +
> > +# Create empty test files in test dir
> > +create_test_files()
> > +{
> > +       local dir=3D$1
> > +
> > +       mkdir -p $dir
> > +       rm -f $dir/*
> > +       $here/src/open_by_handle -c $dir $NUMFILES
> > +}
> > +
> > +# Test encode/decode file handles
> > +test_file_handles()
> > +{
> > +       local dir=3D$1
> > +       local opt=3D$2
> > +
> > +       echo test_file_handles $* | _filter_test_dir
> > +       $here/src/open_by_handle $opt $dir $NUMFILES
> > +}
> > +
> > +# Check stale handles to deleted files
> > +create_test_files $testdir
> > +test_file_handles $testdir -Md
> > +
> > +# Check non-stale handles to linked files
> > +create_test_files $testdir
> > +test_file_handles $testdir -M
> > +
> > +# Check non-stale handles to files that were hardlinked and original d=
eleted
> > +create_test_files $testdir
> > +test_file_handles $testdir -Ml
> > +test_file_handles $testdir -Mu
> > +
> > +status=3D0
> > +exit
> > diff --git a/tests/generic/756.out b/tests/generic/756.out
> > new file mode 100644
> > index 000000000000..48aed88d87b9
> > --- /dev/null
> > +++ b/tests/generic/756.out
> > @@ -0,0 +1,5 @@
> > +QA output created by 756
> > +test_file_handles TEST_DIR/756-dir -Md
> > +test_file_handles TEST_DIR/756-dir -M
> > +test_file_handles TEST_DIR/756-dir -Ml
> > +test_file_handles TEST_DIR/756-dir -Mu
> > --
> > 2.46.0
> >

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--z42o635q3rq4mue5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZtiuXQAKCRAol/rSt+lE
b/m0AQCzKGryUMf1YN9bsLh9plqsyDcabEjPN3fz+B9z5DB0eQD/TbZk5nMKY+uC
nsyr6JXdGtadISbB0yrwK4a4wHcCogo=
=0331
-----END PGP SIGNATURE-----

--z42o635q3rq4mue5--

