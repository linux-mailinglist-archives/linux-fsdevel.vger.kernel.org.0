Return-Path: <linux-fsdevel+bounces-28342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05112969862
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 11:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FFEDB25133
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 09:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4A81A3AA9;
	Tue,  3 Sep 2024 09:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="ZBZAXABY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905031C7669;
	Tue,  3 Sep 2024 09:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725354705; cv=none; b=P6CnQzMLM5M7aT6FB6hQjjdTwwYSzeT+GmP7xaZeg1n+3zP1MVt4OX541t/oVUb3t/UR/yNfoAIg5Pw67zHHZByzffpzATFx4sXkn132sQc3VKpUaDg8/BmxGl8rOyxYqbmMVw4GY3SnYtxDkXm8GufC5mu1AH2icFP5fF+1NBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725354705; c=relaxed/simple;
	bh=vTXnBN7RkGqWdbB/SBRPMbiet1ycfG5/HgtzTsoYtfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JuA24i9cFzUPbACXt0VaKnYmzaEYYbWOdIH/ovr3b2NVnimEioVd+vIKgHyzbH0diWHNeflU1Db4bb57Hjt/UHjzJkgnRTlKPxd7vFDScEKSlBeKrJk9HB5dg1rfISu/5CR+jgwUKNhLxIJ1vdirRnutUYDglOoZ6ezVD+J2VV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=ZBZAXABY; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Wyfy23z0Tz9tCJ;
	Tue,  3 Sep 2024 11:11:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1725354698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZPzW6zq/WcQ/WiA0gxrcLJjcmAKmM8AZOEgUBVGohqU=;
	b=ZBZAXABYVG2geXwbPM3S25PkgrHwvEQKgFi6QrCVNgQFuXfmqoT55sUlP9C4u26sOWaUR2
	Ak9EVSIGIWcE+x1lwyaKkwHd3CjUehNN1jOSWo3Q71adbymmg82h7I3vGEtvaGjc5ddRUF
	jojEcwx4S274kwzQ3ytsoYnnnTSheNseaHZSovzFZk3D2mxSWTur14Kfo8WMM4g6U/ge4m
	7VfdButVk4vNzkBZtkFkRYfuu+2vwIrSL+tF3qAI9sXdSOkjkl9D6GLTvNLYboTfizO+gX
	lTZbz/SPjZD+lGSMHlHWSINaZ7syGXUrJjwtdcMOY4gie+xQm5G2syNxCVEFVQ==
Date: Tue, 3 Sep 2024 19:11:14 +1000
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
Subject: Re: [PATCH xfstests v2 2/2] open_by_handle: add tests for u64 mount
 ID
Message-ID: <20240903.084814-meek.porthole.lonely.employer-6kt9HpTqtbg4@cyphar.com>
References: <20240828-exportfs-u64-mount-id-v3-0-10c2c4c16708@cyphar.com>
 <20240902164554.928371-1-cyphar@cyphar.com>
 <20240902164554.928371-2-cyphar@cyphar.com>
 <CAOQ4uxi291jBJ5ycZgiicVebjkcRQjhXJRgOgvSPBV4-TOcQvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ctvs2l4bgcgrysaf"
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi291jBJ5ycZgiicVebjkcRQjhXJRgOgvSPBV4-TOcQvA@mail.gmail.com>
X-Rspamd-Queue-Id: 4Wyfy23z0Tz9tCJ


--ctvs2l4bgcgrysaf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-09-03, Amir Goldstein <amir73il@gmail.com> wrote:
> On Mon, Sep 2, 2024 at 6:46=E2=80=AFPM Aleksa Sarai <cyphar@cyphar.com> w=
rote:
> >
> > Now that open_by_handle_at(2) can return u64 mount IDs, do some tests to
> > make sure they match properly as part of the regular open_by_handle
> > tests.
> >
> > Link: https://lore.kernel.org/all/20240828-exportfs-u64-mount-id-v3-0-1=
0c2c4c16708@cyphar.com/
> > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> > ---
> > v2:
> > - Remove -M argument and always do the mount ID tests. [Amir Goldstein]
> > - Do not error out if the kernel doesn't support STATX_MNT_ID_UNIQUE
> >   or AT_HANDLE_MNT_ID_UNIQUE. [Amir Goldstein]
> > - v1: <https://lore.kernel.org/all/20240828103706.2393267-1-cyphar@cyph=
ar.com/>
> >
> >  src/open_by_handle.c | 128 +++++++++++++++++++++++++++++++++----------
> >  1 file changed, 99 insertions(+), 29 deletions(-)
> >
> > diff --git a/src/open_by_handle.c b/src/open_by_handle.c
> > index d9c802ca9bd1..0ad591da632e 100644
> > --- a/src/open_by_handle.c
> > +++ b/src/open_by_handle.c
> > @@ -86,10 +86,16 @@ Examples:
> >  #include <errno.h>
> >  #include <linux/limits.h>
> >  #include <libgen.h>
> > +#include <stdint.h>
> > +#include <stdbool.h>
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
> > @@ -120,6 +126,94 @@ void usage(void)
> >         exit(EXIT_FAILURE);
> >  }
> >
> > +int do_name_to_handle_at(const char *fname, struct file_handle *fh, in=
t bufsz)
> > +{
> > +       int ret;
> > +       int mntid_short;
> > +
> > +       static bool skip_mntid_unique;
> > +
> > +       uint64_t statx_mntid_short =3D 0, statx_mntid_unique =3D 0;
> > +       struct statx statxbuf;
> > +
> > +       /* Get both the short and unique mount id. */
> > +       if (statx(AT_FDCWD, fname, 0, STATX_MNT_ID, &statxbuf) < 0) {
>=20
> This fails build on top of latest for-next branch with commit
> 873e36c9 - statx.h: update to latest kernel UAPI
>=20
> It can be fixed by changing to use the private xfstests_statx()
> implementation, same as in stat_test.c.
>=20
> I am not sure how elegant this is, but that's the easy fix.

Ah, I was using master as the base. Sorry about that...

> > +               fprintf(stderr, "%s: statx(STATX_MNT_ID): %m\n", fname);
> > +               return EXIT_FAILURE;
> > +       }
> > +       if (!(statxbuf.stx_mask & STATX_MNT_ID)) {
> > +               fprintf(stderr, "%s: no STATX_MNT_ID in stx_mask\n", fn=
ame);
> > +               return EXIT_FAILURE;
> > +       }
> > +       statx_mntid_short =3D statxbuf.stx_mnt_id;
> > +
> > +       if (!skip_mntid_unique) {
> > +               if (statx(AT_FDCWD, fname, 0, STATX_MNT_ID_UNIQUE, &sta=
txbuf) < 0) {
> > +                       fprintf(stderr, "%s: statx(STATX_MNT_ID_UNIQUE)=
: %m\n", fname);
> > +                       return EXIT_FAILURE;
> > +               }
> > +               /*
> > +                * STATX_MNT_ID_UNIQUE was added fairly recently in Lin=
ux 6.8, so if the
> > +                * kernel doesn't give us a unique mount ID just skip i=
t.
> > +                */
> > +               if ((skip_mntid_unique |=3D !(statxbuf.stx_mask & STATX=
_MNT_ID_UNIQUE)))
> > +                       printf("statx(STATX_MNT_ID_UNIQUE) not supporte=
d by running kernel -- skipping unique mount ID test\n");
>=20
> This verbose print breaks all existing "exportfs" tests which do not
> expect it in the golden output.
>=20
> I understand that silently ignoring the failure is not good, but I also
> would like to add this test coverage to all the existing tests.
>=20
> One solution is to resurrect the command line option -M from v1,
> but instead of meaning "test unique mount id" let it mean
> "do not allow to skip unique mount id" test.
>=20
> Then you can add a new test that runs open_by_handle -M, but also
> implement a helper _require_unique_mntid similar to _require_btime
> which is needed for the new test to run only on new kernels.
>=20
> I'm sorry for this complication, but fstest is a testsuite that runs on
> disto and stable kernels as well and we need to allow test coverage
> of new features along with stability of the test env.

No worries, I'll write it up. I'm not familiar with the exact
requirements of xfstests, sorry for the noise! (^_^")

>=20
> Thanks,
> Amir.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--ctvs2l4bgcgrysaf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZtbSsgAKCRAol/rSt+lE
bwxGAQDiAoDf52s+LenWo4ttMhBeDkXrmdgs1mOXMqJLRHnbwQD+PRJRjDKv6qU4
BM1xu+Z4CvaDhwgbzw8kVRLkpAlSago=
=VcBz
-----END PGP SIGNATURE-----

--ctvs2l4bgcgrysaf--

