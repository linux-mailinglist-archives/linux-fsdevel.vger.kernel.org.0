Return-Path: <linux-fsdevel+bounces-24844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3D2945611
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 03:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DA991C22AE2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 01:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E581C2A3;
	Fri,  2 Aug 2024 01:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="l8kuj9LN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC514199A2;
	Fri,  2 Aug 2024 01:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722563055; cv=none; b=lK9Zs9Dj7MHQx+HKWsHpNLo1nw9C/9nZ2UdQrbduxCPI4K7WV+qcbxV2le21uPzjKYYt90A8tBXyQj/PeQ5qAUASEhuB4mXmzRA889jbBxfinXXAwWKn7E58pz87TSNjqJ7r5flT3TO8BSF9PuQjYaY3c04hU+a6rbz6yFBxQ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722563055; c=relaxed/simple;
	bh=AOHlQpp439hxXb8Yhi0cw6rbI7T9wbusdFDZsoOV5IU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKxa+cZecpaYHSiMpuCmA7dDMnGqxzTZRyTyxHekLKHq0IU4Dmu0sQ1omm2vCWNXSdbqH2qAV1KCYnTQrEvDDG19mQdWlFvBCacvob6r8Ez96wMe1lQWvIsy+N4EIO15dNPteLBQtOffNh8ZETZwC9adywk08u6ueo1cGhwmkx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=l8kuj9LN; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WZpXM4GcRz9sRt;
	Fri,  2 Aug 2024 03:44:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1722563043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rX5EutK1564BvFK6uRJjpD10n8gil980gFWkU6pBKcA=;
	b=l8kuj9LNJSkG1HDlE84DRgEPD5l4U2ZvOu8ucxxAt+bBLucAibv9BFY32ZcHRT3HvJb2Oj
	Rrr/ipAJyEn3TBchVEgoOQnx497Vw9dUw2rj3majF1imXkczlTVl7Kdp5fp0gs8srw9Swr
	qEux0YiQuY1FSzFwLAEuw3YOt22VnAmovWpN2GOobnNlProTG7bQWk5Dt8Wd7ylJisP975
	ubaGZg7icectV6xdUI78iaFg18JtnYA0QbWYLELGvdLnVhGdYcDA0u43t8053r8tv/DqmR
	wiFMHaKxp+2By482c9Dgln4a8MfA6KboPF91OyZFKeDUCqoIri31gt7K2CsJ0Q==
Date: Fri, 2 Aug 2024 11:43:50 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Alexander Aring <alex.aring@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH RFC v3 0/2] fhandle: expose u64 mount id to
 name_to_handle_at(2)
Message-ID: <20240802.010502-peachy.struggle.moldy.shape-YcRNLL7bq7EE@cyphar.com>
References: <20240801-exportfs-u64-mount-id-v3-0-be5d6283144a@cyphar.com>
 <20240801142812.GA4187848@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c7qvxlthxg64t2lg"
Content-Disposition: inline
In-Reply-To: <20240801142812.GA4187848@perftesting>


--c7qvxlthxg64t2lg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-08-01, Josef Bacik <josef@toxicpanda.com> wrote:
> On Thu, Aug 01, 2024 at 01:52:39PM +1000, Aleksa Sarai wrote:
> > Now that we provide a unique 64-bit mount ID interface in statx(2), we
> > can now provide a race-free way for name_to_handle_at(2) to provide a
> > file handle and corresponding mount without needing to worry about
> > racing with /proc/mountinfo parsing or having to open a file just to do
> > statx(2).
> >=20
> > While this is not necessary if you are using AT_EMPTY_PATH and don't
> > care about an extra statx(2) call, users that pass full paths into
> > name_to_handle_at(2) need to know which mount the file handle comes from
> > (to make sure they don't try to open_by_handle_at a file handle from a
> > different filesystem) and switching to AT_EMPTY_PATH would require
> > allocating a file for every name_to_handle_at(2) call, turning
> >=20
> >   err =3D name_to_handle_at(-EBADF, "/foo/bar/baz", &handle, &mntid,
> >                           AT_HANDLE_MNT_ID_UNIQUE);
> >=20
> > into
> >=20
> >   int fd =3D openat(-EBADF, "/foo/bar/baz", O_PATH | O_CLOEXEC);
> >   err1 =3D name_to_handle_at(fd, "", &handle, &unused_mntid, AT_EMPTY_P=
ATH);
> >   err2 =3D statx(fd, "", AT_EMPTY_PATH, STATX_MNT_ID_UNIQUE, &statxbuf);
> >   mntid =3D statxbuf.stx_mnt_id;
> >   close(fd);
> >=20
> > Also, this series adds a patch to clarify how AT_* flag allocation
> > should work going forwards.
> >=20
> > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> > ---
> > Changes in v3:
> > - Added a patch describing how AT_* flags should be allocated in the
> >   future, based on Amir's suggestions.
> > - Included AT_* aliases for RENAME_* flags to further indicate that
> >   renameat2(2) is an *at(2) syscall and to indicate that those flags
> >   have been allocated already in the per-syscall range.
> > - Switched AT_HANDLE_MNT_ID_UNIQUE to use 0x01 (to reuse
> >   (AT_)RENAME_NOREPLACE).
> > - v2: <https://lore.kernel.org/r/20240523-exportfs-u64-mount-id-v2-1-f9=
f959f17eb1@cyphar.com>
> > Changes in v2:
> > - Fixed a few minor compiler warnings and a buggy copy_to_user() check.
> > - Rename AT_HANDLE_UNIQUE_MOUNT_ID -> AT_HANDLE_MNT_ID_UNIQUE to match =
statx.
> > - Switched to using an AT_* bit from 0xFF and defining that range as
> >   being "per-syscall" for future usage.
> > - Sync tools/ copy of <linux/fcntl.h> to include changes.
> > - v1: <https://lore.kernel.org/r/20240520-exportfs-u64-mount-id-v1-1-f5=
5fd9215b8e@cyphar.com>
> >=20
> > ---
> > Aleksa Sarai (2):
> >       uapi: explain how per-syscall AT_* flags should be allocated
> >       fhandle: expose u64 mount id to name_to_handle_at(2)
> >=20
>=20
> Wasn't the conclusion from this discussion last time that we needed to re=
visit
> this API completely?  Christoph had some pretty adamant objections.

There was a discussion about reworking the API and I agree with most of
the issues raised about file handles (I personally don't really like
this interface and it's a bit of a shame that it seems this is going to
be the interface that replaces inode numbers) so I'm not at all opposed
to reworking it.

However, I agree with Christian[1] that we can fix this existing issue
in the existing API fairly easily and then work on a new API separately.
The existing usage of name_to_handle_at() is fundamentally unsafe (as
outlined in the man page) and we can fix that fairly easily.

[1]: https://lore.kernel.org/all/20240527-hagel-thunfisch-75781b0cf75d@brau=
ner/

> That being said the uapi comments patch looks good to me, you can add
>=20
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>=20
> to that one.  The other one I'm going to let others who have stronger opi=
nions
> than me argue about.  Thanks,
>=20
> Josef

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--c7qvxlthxg64t2lg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZqw51QAKCRAol/rSt+lE
b4pZAP0REm8hqjt6l74YM2JQI+BQIfgYBKBGk78diZBwiJ5jxgD+KhCe4dt7UT3O
P4dv9Kd0Ol79OKqHOpG5Fs+2TkIQcQg=
=Z43g
-----END PGP SIGNATURE-----

--c7qvxlthxg64t2lg--

