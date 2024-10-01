Return-Path: <linux-fsdevel+bounces-30564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A1E98C5AB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 20:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 467431F25A18
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 18:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE0C1CDA28;
	Tue,  1 Oct 2024 18:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="ppaifXUB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61621CB30F;
	Tue,  1 Oct 2024 18:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727808518; cv=none; b=NkNqTlE+EfvxJmkI9b5WqaBW1r7zifHJrI1V2USYIN2dc4Z6twhsXZWaJEg/OklEhtp3HQoFenMZ3dHbLrbYDaPcBtiN8k8GUiZsHbPpJcOknykqePe2MYdNxurwToen1rZ20JliHVJAnckVY7YORONElopd/a82z+QBC7UzHMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727808518; c=relaxed/simple;
	bh=H76BOncWu8xQUpoYVO7/nfxlsFJ5MIyoc5Ipf+SgPco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmdF6VHmVwU/dqOMgwUyTPoG9l3M1zEb93b8EADOsHuai09QtIt4Clt30eSIUvPLc2phM031xiOSxjl3yvGkHl/OL1AM7qSyykbcbsjN37/GqjEWaW/320RRNywReImkVU1i0Lm6ip/SRvKWd3rZvqkS2iWurCWSA0dTiU4Ehxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=ppaifXUB; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4XJ6Qd1vMTz9spH;
	Tue,  1 Oct 2024 20:48:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1727808505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fdrBQP3bUQTRkSAN5X0Ar51E6rJtrMZnr+nnaX4bGRY=;
	b=ppaifXUBL5l2kuCJ8egHIfyZh/zpcMPobazbgCznTK2IAulMQs4Xfuhv+ErhMJfoQ2Utgz
	NH85pxly39WgRC6bMazehTB41rN+k7WkcsEz6h61o+62hn+cE8VgHQQcASXI0+ffzU14Lr
	AO6Jv86KT/NB+ffeid5eJXelt79dlRmqNs3qYfmlXssc5smHJgGfAmdN/4Q7alSMZLrUHp
	PcpWAzTVJw9K0DLbYH2fznGpSsujduRUHzAHIlKSvjfmyAlBg4+E6LvUKVABn+SBPeZ1Dd
	D/mpIfN4x/Q7fX28AolTkOIiEGS7LrAgNWVudmdEds65Jqb63KiLWltYBKg5yw==
Date: Tue, 1 Oct 2024 20:48:06 +0200
From: Aleksa Sarai <cyphar@cyphar.com>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Eric Biederman <ebiederm@xmission.com>, 
	Kees Cook <kees@kernel.org>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Tycho Andersen <tandersen@netflix.com>, Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: Re: [PATCH v3 1/2] exec: fix up /proc/pid/comm in the
 execveat(AT_EMPTY_PATH) case
Message-ID: <20241001.184625-homely.tarps.selfish.shotgun-bJjSBGdHDLKb@cyphar.com>
References: <20241001134945.798662-1-tycho@tycho.pizza>
 <20241001.175124-western.preview.meager.saws-pzvpWxOhfokt@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wd2o7flkl4ghydpi"
Content-Disposition: inline
In-Reply-To: <20241001.175124-western.preview.meager.saws-pzvpWxOhfokt@cyphar.com>
X-Rspamd-Queue-Id: 4XJ6Qd1vMTz9spH


--wd2o7flkl4ghydpi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-10-01, Aleksa Sarai <cyphar@cyphar.com> wrote:
> On 2024-10-01, Tycho Andersen <tycho@tycho.pizza> wrote:
> > From: Tycho Andersen <tandersen@netflix.com>
> >=20
> > Zbigniew mentioned at Linux Plumber's that systemd is interested in
> > switching to execveat() for service execution, but can't, because the
> > contents of /proc/pid/comm are the file descriptor which was used,
> > instead of the path to the binary. This makes the output of tools like
> > top and ps useless, especially in a world where most fds are opened
> > CLOEXEC so the number is truly meaningless.
> >=20
> > Change exec path to fix up /proc/pid/comm in the case where we have
> > allocated one of these synthetic paths in bprm_init(). This way the act=
ual
> > exec machinery is unchanged, but cosmetically the comm looks reasonable=
 to
> > admins investigating things.
>=20
> While I still think the argv[0] solution was semantically nicer, it
> seems this is enough to fix the systemd problem for most cases and so we
> can revisit the argv[0] discussion in another 10 years. :D

Of course, this assumes the busybox problem I mentioned really is not an
issue. But at least this option is "less wrong" than using the fd
number. I suspect we will eventually need the argv[0] thing.

> Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>
>=20
> > Signed-off-by: Tycho Andersen <tandersen@netflix.com>
> > Suggested-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
> > CC: Aleksa Sarai <cyphar@cyphar.com>
> > Link: https://github.com/uapi-group/kernel-features#set-comm-field-befo=
re-exec
> > ---
> > v2: * drop the flag, everyone :)
> >     * change the rendered value to f_path.dentry->d_name.name instead of
> >       argv[0], Eric
> > v3: * fix up subject line, Eric
> > ---
> >  fs/exec.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/fs/exec.c b/fs/exec.c
> > index dad402d55681..9520359a8dcc 100644
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -1416,7 +1416,18 @@ int begin_new_exec(struct linux_binprm * bprm)
> >  		set_dumpable(current->mm, SUID_DUMP_USER);
> > =20
> >  	perf_event_exec();
> > -	__set_task_comm(me, kbasename(bprm->filename), true);
> > +
> > +	/*
> > +	 * If fdpath was set, execveat() made up a path that will
> > +	 * probably not be useful to admins running ps or similar.
> > +	 * Let's fix it up to be something reasonable.
> > +	 */
> > +	if (bprm->fdpath) {
> > +		BUILD_BUG_ON(TASK_COMM_LEN > DNAME_INLINE_LEN);
> > +		__set_task_comm(me, bprm->file->f_path.dentry->d_name.name, true);
> > +	} else {
> > +		__set_task_comm(me, kbasename(bprm->filename), true);
> > +	}
> > =20
> >  	/* An exec changes our domain. We are no longer part of the thread
> >  	   group */
> >=20
> > base-commit: baeb9a7d8b60b021d907127509c44507539c15e5
> > --=20
> > 2.34.1
> >=20
>=20
> --=20
> Aleksa Sarai
> Senior Software Engineer (Containers)
> SUSE Linux GmbH
> <https://www.cyphar.com/>



--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--wd2o7flkl4ghydpi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZvxD5gAKCRAol/rSt+lE
b6K4AP0bkE8XQim5jTCFtZmavfUnJ3zLtIlqABmpFfxf4uq8AAD+KW/IsgZGoAu7
ov97H3FBDh8FdTxrCOEcruXb8xQQnwU=
=1uQQ
-----END PGP SIGNATURE-----

--wd2o7flkl4ghydpi--

