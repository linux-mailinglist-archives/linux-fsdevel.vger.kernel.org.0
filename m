Return-Path: <linux-fsdevel+bounces-28591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB8296C427
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 18:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EA4F1C246A7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 16:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D7F1E0B8C;
	Wed,  4 Sep 2024 16:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="NEPW8DSc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D8C1DCB2F;
	Wed,  4 Sep 2024 16:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725467483; cv=none; b=Kuq0ti+jKzdbv61uch6s7lvFKfiQw4whAG8MOtuO/K7/UTVwEsgnSVu6IyZob0Ft4SrZC7pBja7WFtcHk7XCTVN8LM9JcEhTCwR9IT1dAJIKM+vx3XwqIRFoBDxCVjCMRsHz3j+WGUMwCFNObyHzgCa0VivyHSYIszGtAnGJRpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725467483; c=relaxed/simple;
	bh=9B8NIdXtKXjQYQ4GwKfLnNiVZOtUKLuK57HoNnIRKdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f57M6t7qOI0zqS0PAoEG9gxltVrBwoQ+lIBOhVsCAV0Yti97grW4qyq4ruQ93JN8yK40LwXoLD+ugdWuPM+Ot4ywopaI/O7shwNQmEKi44ScbXN6rKj8R0wW5qHel1e1Z63XpKROTfUihj9sk8nAu5ZquV42HRiZ5BRrwZKBxhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=NEPW8DSc; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WzSfl4CvDz9srB;
	Wed,  4 Sep 2024 18:31:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1725467471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6h8xLJebhDjKCW4hsQao0KzGPncsnYRAjwovRv+KG+A=;
	b=NEPW8DScBNdQJfXRYrK8v7eYl7idqIFZG1/uqnNhb6WN+hB/aXAOw5rF23ZiwRorUjOaU2
	jFlaYWY4gVhxdodUWlE8SrqnGy4kVYPCghGIyNmGASF80RP7uD0JV1eT/NpDKjbKq6vCdd
	K0NVw+7bUGuZYXy0QIxoz4IQhBjbVk17EmYvWRz3MunU9rHjEt3EQDsmVdL1q9FiO76vS4
	q6DuWSOu6hTiSSIKPF4WxLcviInnHxUSIbBf8IQPABIuIRkqRZP7YFBqcHRN0PXUQSmkxu
	oWuzN+DIUcDeXWJQJxVqwsIZJZ0rouaXVn/wcwf9BHiVmfN01rpNgzcNQCWhyQ==
Date: Thu, 5 Sep 2024 02:30:52 +1000
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
Message-ID: <20240904.162424-novel.fangs.vital.nursery-BQvjXGlIi7vb@cyphar.com>
References: <20240828-exportfs-u64-mount-id-v3-0-10c2c4c16708@cyphar.com>
 <20240902164554.928371-1-cyphar@cyphar.com>
 <20240902164554.928371-2-cyphar@cyphar.com>
 <CAOQ4uxgS6DvsbUsEoM1Vr2wcd_7Bj=xFXMAy4z9PphTu+G6RaQ@mail.gmail.com>
 <20240903.044647-some.sprint.silent.snacks-jdKnAVp7XuBZ@cyphar.com>
 <CAOQ4uxhXa-1Xjd58p8oGd9Q4hgfDtGnae1YrmDWwQp3t5uGHeg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k27yakkh67nm3oib"
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhXa-1Xjd58p8oGd9Q4hgfDtGnae1YrmDWwQp3t5uGHeg@mail.gmail.com>


--k27yakkh67nm3oib
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-09-03, Amir Goldstein <amir73il@gmail.com> wrote:
> On Tue, Sep 3, 2024 at 8:41=E2=80=AFAM Aleksa Sarai <cyphar@cyphar.com> w=
rote:
> >
> > On 2024-09-02, Amir Goldstein <amir73il@gmail.com> wrote:
> > > On Mon, Sep 2, 2024 at 6:46=E2=80=AFPM Aleksa Sarai <cyphar@cyphar.co=
m> wrote:
> > > >
> > > > Now that open_by_handle_at(2) can return u64 mount IDs, do some tes=
ts to
> > > > make sure they match properly as part of the regular open_by_handle
> > > > tests.
> > > >
> > > > Link: https://lore.kernel.org/all/20240828-exportfs-u64-mount-id-v3=
-0-10c2c4c16708@cyphar.com/
> > > > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> > > > ---
> > > > v2:
> > > > - Remove -M argument and always do the mount ID tests. [Amir Goldst=
ein]
> > > > - Do not error out if the kernel doesn't support STATX_MNT_ID_UNIQUE
> > > >   or AT_HANDLE_MNT_ID_UNIQUE. [Amir Goldstein]
> > > > - v1: <https://lore.kernel.org/all/20240828103706.2393267-1-cyphar@=
cyphar.com/>
> > >
> > > Looks good.
> > >
> > > You may add:
> > >
> > > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> > >
> > > It'd be nice to get a verification that this is indeed tested on the =
latest
> > > upstream and does not regress the tests that run the open_by_handle p=
rogram.
> >
> > I've tested that the fallback works on mainline and correctly does the
> > test on patched kernels (by running open_by_handle directly) but I
> > haven't run the suite yet (still getting my mkosi testing setup working
> > to run fstests...).
>=20
> I am afraid this has to be tested.
> I started testing myself and found that it breaks existing tests.
> Even if you make the test completely opt-in as in v1 it need to be
> tested and _notrun on old kernels.
>=20
> If you have a new version, I can test it until you get your fstests setup
> ready, because anyway I would want to check that your test also
> works with overlayfs which has some specialized exportfs tests.
> Test by running ./check -overlay -g exportfs, but I can also do that for =
you.

I managed to get fstests running, sorry about that...

For the v3 I have ready (which includes a new test using -M), the
following runs work in my VM:

 - ./check -g exportfs
 - ./check -overlay -g exportfs

Should I check anything else before sending it?

Also, when running the tests I think I may have found a bug? Using
overlayfs+xfs leads to the following error when doing ./check -overlay
if the scratch device is XFS:

  ./common/rc: line 299: _xfs_has_feature: command not found
    not run: upper fs needs to support d_type

The fix I applied was simply:

diff --git a/common/rc b/common/rc
index 0beaf2ff1126..e6af1b16918f 100644
--- a/common/rc
+++ b/common/rc
@@ -296,6 +296,7 @@ _supports_filetype()
 	local fstyp=3D`$DF_PROG $dir | tail -1 | $AWK_PROG '{print $2}'`
 	case "$fstyp" in
 	xfs)
+		. common/xfs
 		_xfs_has_feature $dir ftype
 		;;
 	ext2|ext3|ext4)

Should I include this patch as well, or did I make a mistake somewhere?
(I could add the import to the top instead if you'd prefer that.)

Thanks.

>=20
> Thanks,
> Amir.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--k27yakkh67nm3oib
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZtiLPAAKCRAol/rSt+lE
b0qTAQDObJfQoQ4ty+6/dZXFiueoF+rCfMaWVyS6FylNcXzCyAD/Xcl172RWrIge
yjkBNVF0rbuTGTjAO/YNjJC5TclDzQQ=
=z7px
-----END PGP SIGNATURE-----

--k27yakkh67nm3oib--

