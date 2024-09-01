Return-Path: <linux-fsdevel+bounces-28151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB861967687
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 14:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EFC51F219A8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 12:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB0217E00C;
	Sun,  1 Sep 2024 12:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="PojFBLF2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DBE156F33;
	Sun,  1 Sep 2024 12:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725195497; cv=none; b=sZgUv8v3PZbPD322DMfIkbrFj2oexUoliRrvJnQR7YycqiV5hGr48wEfXIm/PLtzX+bkIcCl1j8YU59oBjkfeQnmDMM/1PAZxj5HQq4kyP2AGOYuUfYsaUQxTjkpV0jRpVq2y3AJaiOs5a+irBcqrdof9joF9j+AatEehn3ZDFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725195497; c=relaxed/simple;
	bh=AmSHOswEuFz5AIfVdzUvt9B7esvFWuhuC3Je1yQe2Cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TF/T2MPMsqGjcVDHD4g2fLdGH+Tm2o7o0QKcDvbNnSNiKnwozDuicoe3R2ydclHUJqdULaECHZlwK7PqBicH0KYYW9+8vOvvcbMXf3yz5ccUA30DDKZ5/xTSP6e9BmpwntJdfKZLQ0gqF1XgoDHLIHG5k98fFQ0ckJtHhE7c8jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=PojFBLF2; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WxX4D4LQfz9sj1;
	Sun,  1 Sep 2024 14:58:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1725195484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yOScvoXCs6hG9agGvhvqU7BV4yKsTY9quz5vL2xOB3o=;
	b=PojFBLF27YYcqgKaEDOkXX3/sOqWa3bZxcomY1hspQhBgaacrfHLheOFTmRRPEkED5fpf4
	Ors+OrglH/3dYoiAi9K6TYpa5P3LJRtVo0zITsXRt8Z3Pg2/AsnfwKcoji27nK065QUIr0
	chugfQT+udTGEugsyabQpqlcDXrNhwbbFWZ15y7ZejoDdKG352SDG9E6rM5ibYuNf8l0hu
	EEOiIX7w3VdmaZga+T3KZ6rlkZ2rswoROhhdUbSafLB/K7bfpXDsWb8SKlk0uVhvZClCmG
	qj3FawBylBuJfd2WQQaJgN/sTZAha1BabBD/7sHYfvB/FOJ9/myW5EgzT9tk6g==
Date: Sun, 1 Sep 2024 22:57:45 +1000
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
Subject: Re: [PATCH xfstests v1 2/2] open_by_handle: add tests for u64 mount
 ID
Message-ID: <20240901.025307-rougher.varmint.brutal.prayers-rgvz8za91M@cyphar.com>
References: <20240828-exportfs-u64-mount-id-v3-0-10c2c4c16708@cyphar.com>
 <20240828103706.2393267-1-cyphar@cyphar.com>
 <20240828103706.2393267-2-cyphar@cyphar.com>
 <CAOQ4uxjzpoUtH9OGYmj8K4FF0V4J8vi1W6Ry0Po1RoZ70vQ_fA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xoabik3li3lkaf4u"
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjzpoUtH9OGYmj8K4FF0V4J8vi1W6Ry0Po1RoZ70vQ_fA@mail.gmail.com>


--xoabik3li3lkaf4u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-08-30, Amir Goldstein <amir73il@gmail.com> wrote:
> On Wed, Aug 28, 2024 at 12:37=E2=80=AFPM Aleksa Sarai <cyphar@cyphar.com>=
 wrote:
> >
> > Now that open_by_handle_at(2) can return u64 mount IDs, do some tests to
> > make sure they match properly as part of the regular open_by_handle
> > tests.
> >
> > Link: https://lore.kernel.org/all/20240801-exportfs-u64-mount-id-v3-0-b=
e5d6283144a@cyphar.com/
> > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> > ---
> >  src/open_by_handle.c | 123 ++++++++++++++++++++++++++++++++-----------
> >  tests/generic/426    |   1 +
> >  2 files changed, 93 insertions(+), 31 deletions(-)
> >
> > diff --git a/src/open_by_handle.c b/src/open_by_handle.c
> > index d9c802ca9bd1..cbd68aeadac1 100644
> > --- a/src/open_by_handle.c
> > +++ b/src/open_by_handle.c
> > @@ -86,10 +86,15 @@ Examples:
> >  #include <errno.h>
> >  #include <linux/limits.h>
> >  #include <libgen.h>
> > +#include <stdint.h>
> >
> >  #include <sys/stat.h>
> >  #include "statx.h"
> >
> > +#ifndef AT_HANDLE_MNT_ID_UNIQUE
> > +#      define AT_HANDLE_MNT_ID_UNIQUE 0x001
> > +#endif
> > +
> >  #define MAXFILES 1024
> >
> >  struct handle {
> > @@ -99,7 +104,7 @@ struct handle {
> >
> >  void usage(void)
> >  {
> > -       fprintf(stderr, "usage: open_by_handle [-cludmrwapknhs] [<-i|-o=
> <handles_file>] <test_dir> [num_files]\n");
> > +       fprintf(stderr, "usage: open_by_handle [-cludMmrwapknhs] [<-i|-=
o> <handles_file>] <test_dir> [num_files]\n");
> >         fprintf(stderr, "\n");
> >         fprintf(stderr, "open_by_handle -c <test_dir> [N] - create N te=
st files under test_dir, try to get file handles and exit\n");
> >         fprintf(stderr, "open_by_handle    <test_dir> [N] - get file ha=
ndles of test files, drop caches and try to open by handle\n");
> > @@ -111,6 +116,7 @@ void usage(void)
> >         fprintf(stderr, "open_by_handle -l <test_dir> [N] - create hard=
links to test files, drop caches and try to open by handle\n");
> >         fprintf(stderr, "open_by_handle -u <test_dir> [N] - unlink (har=
dlinked) test files, drop caches and try to open by handle\n");
> >         fprintf(stderr, "open_by_handle -d <test_dir> [N] - unlink test=
 files and hardlinks, drop caches and try to open by handle\n");
> > +       fprintf(stderr, "open_by_handle -M <test_dir> [N] - confirm tha=
t the mount id returned by name_to_handle_at matches the mount id in statx\=
n");
> >         fprintf(stderr, "open_by_handle -m <test_dir> [N] - rename test=
 files, drop caches and try to open by handle\n");
> >         fprintf(stderr, "open_by_handle -p <test_dir>     - create/dele=
te and try to open by handle also test_dir itself\n");
> >         fprintf(stderr, "open_by_handle -i <handles_file> <test_dir> [N=
] - read test files handles from file and try to open by handle\n");
> > @@ -120,6 +126,81 @@ void usage(void)
> >         exit(EXIT_FAILURE);
> >  }
> >
> > +int do_name_to_handle_at(const char *fname, struct file_handle *fh, in=
t bufsz,
> > +                        int checkmountid)
> > +{
> > +       int ret;
> > +       int mntid_short;
> > +
> > +       uint64_t mntid_unique;
> > +       uint64_t statx_mntid_short =3D 0, statx_mntid_unique =3D 0;
> > +       struct handle dummy_fh;
> > +
> > +       if (checkmountid) {
> > +               struct statx statxbuf;
> > +
> > +               /* Get both the short and unique mount id. */
> > +               if (statx(AT_FDCWD, fname, 0, STATX_MNT_ID, &statxbuf) =
< 0) {
> > +                       fprintf(stderr, "%s: statx(STATX_MNT_ID): %m\n"=
, fname);
> > +                       return EXIT_FAILURE;
> > +               }
> > +               if (!(statxbuf.stx_mask & STATX_MNT_ID)) {
> > +                       fprintf(stderr, "%s: no STATX_MNT_ID in stx_mas=
k\n", fname);
> > +                       return EXIT_FAILURE;
> > +               }
> > +               statx_mntid_short =3D statxbuf.stx_mnt_id;
> > +
> > +               if (statx(AT_FDCWD, fname, 0, STATX_MNT_ID_UNIQUE, &sta=
txbuf) < 0) {
> > +                       fprintf(stderr, "%s: statx(STATX_MNT_ID_UNIQUE)=
: %m\n", fname);
> > +                       return EXIT_FAILURE;
>=20
> This failure will break the test on LTS kernels  - we don't want that.
> Instead I think you should:
> - drop the -M option
> - get statx_mntid_unique here IF kernel supports STATX_MNT_ID_UNIQUE
> and then...

Ah okay, I wasn't sure if the xfstests policy was like selftests where
only the latest kernel matters. I'll send a v2 with the suggestions you
mentioned.

However, presumably this means we would also not do the
STATX_MNT_ID_UNIQUE check if name_to_handle_at(AT_HANDLE_MNT_ID_UNIQUE)
returns -EINVAL, right?

> > +               }
> > +               if (!(statxbuf.stx_mask & STATX_MNT_ID_UNIQUE)) {
> > +                       fprintf(stderr, "%s: no STATX_MNT_ID_UNIQUE in =
stx_mask\n", fname);
> > +                       return EXIT_FAILURE;
> > +               }
> > +               statx_mntid_unique =3D statxbuf.stx_mnt_id;
> > +       }
> > +
> > +       fh->handle_bytes =3D bufsz;
> > +       ret =3D name_to_handle_at(AT_FDCWD, fname, fh, &mntid_short, 0);
> > +       if (bufsz < fh->handle_bytes) {
> > +               /* Query the filesystem required bufsz and the file han=
dle */
> > +               if (ret !=3D -1 || errno !=3D EOVERFLOW) {
> > +                       fprintf(stderr, "%s: unexpected result from nam=
e_to_handle_at: %d (%m)\n", fname, ret);
> > +                       return EXIT_FAILURE;
> > +               }
> > +               ret =3D name_to_handle_at(AT_FDCWD, fname, fh, &mntid_s=
hort, 0);
> > +       }
> > +       if (ret < 0) {
> > +               fprintf(stderr, "%s: name_to_handle: %m\n", fname);
> > +               return EXIT_FAILURE;
> > +       }
> > +
> > +       if (checkmountid) {
> > +               if (mntid_short !=3D (int) statx_mntid_short) {
> > +                       fprintf(stderr, "%s: name_to_handle_at returned=
 a different mount ID to STATX_MNT_ID: %u !=3D %lu\n", fname, mntid_short, =
statx_mntid_short);
> > +                       return EXIT_FAILURE;
> > +               }
> > +
> > +               /*
> > +                * Get the unique mount ID. We don't need to get anothe=
r copy of the
> > +                * handle so store it in a dummy struct.
> > +                */
> > +               dummy_fh.fh.handle_bytes =3D fh->handle_bytes;
> > +               if (name_to_handle_at(AT_FDCWD, fname, &dummy_fh.fh, (i=
nt *) &mntid_unique, AT_HANDLE_MNT_ID_UNIQUE) < 0) {
> > +                       fprintf(stderr, "%s: name_to_handle_at(AT_HANDL=
E_MNT_ID_UNIQUE): %m\n", fname);
> > +                       return EXIT_FAILURE;
> > +               }
> > +
> > +               if (mntid_unique !=3D statx_mntid_unique) {
> > +                       fprintf(stderr, "%s: name_to_handle_at(AT_HANDL=
E_MNT_ID_UNIQUE) returned a different mount ID to STATX_MNT_ID_UNIQUE: %lu =
!=3D %lu\n", fname, mntid_unique, statx_mntid_unique);
> > +                       return EXIT_FAILURE;
> > +               }
>=20
> - check statx_mntid_unique here IFF statx_mntid_unique is set
> - always check statx_mntid_short (what could be a reason to not check it?)
>=20
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  int main(int argc, char **argv)
> >  {
> >         int     i, c;
> > @@ -132,19 +213,20 @@ int main(int argc, char **argv)
> >         char    fname2[PATH_MAX];
> >         char    *test_dir;
> >         char    *mount_dir;
> > -       int     mount_fd, mount_id;
> > +       int     mount_fd;
> >         char    *infile =3D NULL, *outfile =3D NULL;
> >         int     in_fd =3D 0, out_fd =3D 0;
> >         int     numfiles =3D 1;
> >         int     create =3D 0, delete =3D 0, nlink =3D 1, move =3D 0;
> >         int     rd =3D 0, wr =3D 0, wrafter =3D 0, parent =3D 0;
> >         int     keepopen =3D 0, drop_caches =3D 1, sleep_loop =3D 0;
> > +       int     checkmountid =3D 0;
> >         int     bufsz =3D MAX_HANDLE_SZ;
> >
> >         if (argc < 2)
> >                 usage();
> >
> > -       while ((c =3D getopt(argc, argv, "cludmrwapknhi:o:sz")) !=3D -1=
) {
> > +       while ((c =3D getopt(argc, argv, "cludMmrwapknhi:o:sz")) !=3D -=
1) {
> >                 switch (c) {
> >                 case 'c':
> >                         create =3D 1;
> > @@ -172,6 +254,9 @@ int main(int argc, char **argv)
> >                         delete =3D 1;
> >                         nlink =3D 0;
> >                         break;
> > +               case 'M':
> > +                       checkmountid =3D 1;
> > +                       break;
> >                 case 'm':
> >                         move =3D 1;
> >                         break;
> > @@ -307,21 +392,9 @@ int main(int argc, char **argv)
> >                                 return EXIT_FAILURE;
> >                         }
> >                 } else {
> > -                       handle[i].fh.handle_bytes =3D bufsz;
> > -                       ret =3D name_to_handle_at(AT_FDCWD, fname, &han=
dle[i].fh, &mount_id, 0);
> > -                       if (bufsz < handle[i].fh.handle_bytes) {
> > -                               /* Query the filesystem required bufsz =
and the file handle */
> > -                               if (ret !=3D -1 || errno !=3D EOVERFLOW=
) {
> > -                                       fprintf(stderr, "Unexpected res=
ult from name_to_handle_at(%s)\n", fname);
> > -                                       return EXIT_FAILURE;
> > -                               }
> > -                               ret =3D name_to_handle_at(AT_FDCWD, fna=
me, &handle[i].fh, &mount_id, 0);
> > -                       }
> > -                       if (ret < 0) {
> > -                               strcat(fname, ": name_to_handle");
> > -                               perror(fname);
> > +                       ret =3D do_name_to_handle_at(fname, &handle[i].=
fh, bufsz, checkmountid);
> > +                       if (ret < 0)
> >                                 return EXIT_FAILURE;
> > -                       }
> >                 }
> >                 if (keepopen) {
> >                         /* Open without close to keep unlinked files ar=
ound */
> > @@ -349,21 +422,9 @@ int main(int argc, char **argv)
> >                                 return EXIT_FAILURE;
> >                         }
> >                 } else {
> > -                       dir_handle.fh.handle_bytes =3D bufsz;
> > -                       ret =3D name_to_handle_at(AT_FDCWD, test_dir, &=
dir_handle.fh, &mount_id, 0);
> > -                       if (bufsz < dir_handle.fh.handle_bytes) {
> > -                               /* Query the filesystem required bufsz =
and the file handle */
> > -                               if (ret !=3D -1 || errno !=3D EOVERFLOW=
) {
> > -                                       fprintf(stderr, "Unexpected res=
ult from name_to_handle_at(%s)\n", dname);
> > -                                       return EXIT_FAILURE;
> > -                               }
> > -                               ret =3D name_to_handle_at(AT_FDCWD, tes=
t_dir, &dir_handle.fh, &mount_id, 0);
> > -                       }
> > -                       if (ret < 0) {
> > -                               strcat(dname, ": name_to_handle");
> > -                               perror(dname);
> > +                       ret =3D do_name_to_handle_at(test_dir, &dir_han=
dle.fh, bufsz, checkmountid);
> > +                       if (ret < 0)
> >                                 return EXIT_FAILURE;
> > -                       }
> >                 }
> >                 if (out_fd) {
> >                         ret =3D write(out_fd, (char *)&dir_handle, size=
of(*handle));
> > diff --git a/tests/generic/426 b/tests/generic/426
> > index 25909f220e1e..df481c58562c 100755
> > --- a/tests/generic/426
> > +++ b/tests/generic/426
> > @@ -51,6 +51,7 @@ test_file_handles $testdir -d
> >  # Check non-stale handles to linked files
> >  create_test_files $testdir
> >  test_file_handles $testdir
> > +test_file_handles $testdir -M
>=20
> I see no reason to add option -M and add a second invocation.
>=20
> Something I am missing?

Given how many other custom modes there were, I assumed that providing
it as an additional flag would've been preferred. I'll just make it
automatic.

Thanks!

>=20
> Thanks,
> Amir.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--xoabik3li3lkaf4u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZtRkyQAKCRAol/rSt+lE
b8iFAP9ronjM390q9EgpPrLva5FQeA5PzBtRCCzWqWo7ot0Z8wEAph1HLsbxE73f
69d3VKHugyM5PhH45ZqRqbUQR8AOEwY=
=DF4l
-----END PGP SIGNATURE-----

--xoabik3li3lkaf4u--

