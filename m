Return-Path: <linux-fsdevel+bounces-37303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE0E9F0E28
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 14:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07C4C2814BD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 13:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473331E0B75;
	Fri, 13 Dec 2024 13:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="bF4R2i8q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCE443166;
	Fri, 13 Dec 2024 13:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734098327; cv=none; b=PCxn46m37kDG9kaW5dPVsNE/xYZV5/Nor2wLdq9oLUEBsQCFisk8iBjHIVEFdWG4uIQGzRbKQ6Ow8MEcp3BaRJzQJ4qsa4qQ2iOyjcwDvUT880SmWqZ9pdIxfFuojC9r5mK/DEpcgl+U3ypScEPnTdpzTzkFELkdBVSLOcIH61E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734098327; c=relaxed/simple;
	bh=8V8loealhg9hkbGgSk1VpS+Qg3+oMxBbcWO6//lVuYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNz/ClqKUzxOY93uOy9fqBgrtMx/hVpzSdd1f+06xXIFG7enSyHE1+SSkFQUY+4OHHoFUBItlDLxGUyyztATxMu/vhQf5a0Ok9wyP1TeNtNT9PkDBivBbdLNAMQfceNdizjAJydqLtDaREhN6FOkANRVmTeqQnQB+VOhEGRHaec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=bF4R2i8q; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Y8rMZ60X4z9spN;
	Fri, 13 Dec 2024 14:50:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1734097850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SUozLGiWspsdDi63BsNnDFj2H4MhXpnjnTQm1/c6WRM=;
	b=bF4R2i8qCbRIk0otAdEoofsOnaXpJGeIbbBTXPpYvJXzDgKB/Q/D15UCTzjw0gIt8lC1lt
	9X8HgnpKgz44aeB45pUvbOYm9x9fkHM+pq3kGn5q73o5pVk86KANBdhe3yRQwAgnVUGNqj
	GgnnK7ee8U7RX+9+WO3qTB7gcnz0eMDn+ki7APaO9smg/5PnqhefyA/zd7XiW2HqVEwRGh
	7lajSygfadKGShsDkvrX3ZXSn3FYF4E6XVxQgdfWLMsx3FQMN3v4mDpLoq7tyGdcYye6Tw
	blqRDfIEeVDFbb1ymprIuC1uxLvgDJ9mD95s1Y93L8ZAhUdjlrilNrz//xqkWA==
Date: Sat, 14 Dec 2024 00:50:40 +1100
From: Aleksa Sarai <cyphar@cyphar.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC] Add a prctl to disable ".." traversal in path resolution
Message-ID: <20241213.022139-austere.rattle.lush.moves-oG1a9SMmxNr@cyphar.com>
References: <20241211142929.247692-1-mjg59@srcf.ucam.org>
 <20241211.154841-core.hand.fragrant.rearview-Ajjgdy5TrwhO@cyphar.com>
 <20241211162056.GF3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qd7mhjlggoyqbohb"
Content-Disposition: inline
In-Reply-To: <20241211162056.GF3387508@ZenIV>


--qd7mhjlggoyqbohb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC] Add a prctl to disable ".." traversal in path resolution
MIME-Version: 1.0

On 2024-12-11, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Thu, Dec 12, 2024 at 02:56:59AM +1100, Aleksa Sarai wrote:
>=20
> > I think RESOLVE_BENEATH is usually more along the lines of what programs
> > that are trying to restrict themselves would want (RESOLVE_IN_ROOT is
> > what extraction tools want, on the other hand) as it only blocks ".."
> > components that move you out of the directory you expect.
> >=20
> > It also blocks absolute symlinks, which this proposal does nothing about
> > (it even blocks magic-links, which can be an even bigger issue depending
> > on what kind of program we are talking about). Alas, RESOLVE_BENEATH
> > requires education...
>=20
> So does this prctl, when you get to that - any references to "service man=
ager"
> that might turn it on are contradicted by the "after startup" bit in the
> original posting.
>=20
> IOW, I very much doubt that this problem is amenable to cargo-culting.

I'm not sure I understand what you're saying -- was this comment
intended for me or Matthew? I was just trying to say that:

 1. Most programs that want to access config files or static files to
	serve as a web server where there might be ".." symlinks would
	probably want RESOLVE_BENEATH behaviour (using the config directory
	as the root) because that will only block escaping ".."s (and will
	also block absolute symlinks as well as magic-links that can escape
	too -- which are also issues that you need to deal with anyway).

 2. Blocking this on a process-wide level could cause issues for any
    given program because the language's stdlib or runtime could
	internally do a ".." open operation, and if that fails the runtime
	might decide to crash the program (we've run into issues like this
	in Go -- though those were related to errors from pthread_*
	functions). If the service manager sets the prctl then if the link
	loader or glibc on startup have to resolve ".." due to the way the
	system was set up, you would also get errors (and probably a crash).

	Obviously, some users would prefer the application crash rather than
	resolving a "..", but most would not which is why I'm unsure of how
	much this will help solve the problem in practice.

As a devils-advocate proposal, I wonder if we could instead do something
like nosymfollow (so nodotdot?) where you can mark particular mounts
to have this restriction. This could be used to limit all ".."s globally
for a process using a mntns, but it could also be scoped to application
data directories (or to all untrusted directories) without requiring
program changes (the same argument was used for adding nosymfollow when
RESOLVE_NO_SYMLINKS existed).

Obviously there would be problems with this proposal -- unlike
nosymfollow (which is more like nodev or noexec in concept, and so is
more about conceptually restricting access modes of inodes -- even
though nosymfollow is piped through namei), this is would be nd->mnt
impacting how lookups work, which seems kinda ugly and would burn
another MS_ flag (the final one aside from internal ones AFAICS)...

Just food for thought. (I think LOOKUP_NO_DOTDOT / RESOLVE_NO_DOTDOT is
the most usable solution for most programs that really need this, fwiw.)

> _If_ somebody wants to collect actual information about the use patterns,
> something like prctl that would spew a stack trace when running into
> .. would be an obvious approach, but I would strongly object to even
> inserting a tracepoint of that sort into the mainline kernel.

You probably don't need a custom tracepoint, I expect they can get most
of the information they'd need with bpftrace.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--qd7mhjlggoyqbohb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZ1w7sAAKCRAol/rSt+lE
b3poAQDqa9E6YCJ+XsOENJpixfqyCh+/tz7GqmgbqEGEozI3aAD8DYOBZzm0tq4p
th1r+CbRHvlYqlhD7emrseKax2aT/w8=
=YYxD
-----END PGP SIGNATURE-----

--qd7mhjlggoyqbohb--

