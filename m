Return-Path: <linux-fsdevel+bounces-73814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF694D214F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 22:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A292304F14E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 21:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C271A361657;
	Wed, 14 Jan 2026 21:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="hpQUXxbI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B411830DEA2;
	Wed, 14 Jan 2026 21:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768425536; cv=none; b=suHp1sQ39btfim3JLpHm425X7UCbOOPraukf83z1DiW3WKmFhgWsbd3M9TZsYm6wiAWbEWSO7mu5FJkNH+d9ycG3y/qmMPKP3EoFdPsxRPFnqsxqu4XY2j2sudXudd3TEGnUTb8cWkyqVgU3EmsXshnTAJnzDuHarSs2oIRbdIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768425536; c=relaxed/simple;
	bh=9sFGLl2vCZAA7nUjghXYdeA0+AuIpchUPP0Zmj6oWYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmI2TB+3hqUM4Rqt6c1hXh6VsYfQFnz/L8cAhHHyc9rL3pubNKVkR4n0tkWxffeVZWkXM1hd1GXmTIvxn9nDXUyGqEAFEQSrP5cekXoC3GbYx/kxz7NHfmMXyw0huvkh04YoIF9QZp+TSnLkDwFjrnZGzJ4bSp1/PBkOGj6jgiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=hpQUXxbI; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4drzW63NLdz9ttW;
	Wed, 14 Jan 2026 22:18:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1768425522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fIAKT58banHucBToU7l4G8MTS+dB+f+gFGwKSkJo90w=;
	b=hpQUXxbIdiin0oEzTbQ+6mfLvyGK2a3A7GENroD4oQBs+qO0XdQSfGhQ64b5PLX3A23ZJc
	BkYyc2+6sidQw7+uS9sZJcoA1MugBTLKzis2r4g1yMWkv6/h2AzsE5RIqeoAejcEv8YbEn
	yDcFxbE3OUps3HicdJ8w52/c0PxuB2QjoPuKGBzsEmQayVpDkzD8AlVQC238NPcxpyK6A7
	E1wtEqxlyLmsrNRT2lQOdgl38FMf/wn5yomhvbcgkfvt1cSGKpksjrhRXXyIIykMzJBIcl
	k6vGseysOp1sZ6pmmwMSZvMJB+ZAT9nOjNtn8vwKAmKhX8UiZOV9x2z3eEw7RA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Wed, 14 Jan 2026 22:18:38 +0100
From: Aleksa Sarai <cyphar@cyphar.com>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Christian Brauner <brauner@kernel.org>, 
	Florian Weimer <fweimer@redhat.com>, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, 
	David Howells <dhowells@redhat.com>, DJ Delorie <dj@redhat.com>
Subject: Re: O_CLOEXEC use for OPEN_TREE_CLOEXEC
Message-ID: <2026-01-14-pushy-weedy-weapons-linguini-Vz3I33@cyphar.com>
References: <lhupl7dcf0o.fsf@oldenburg.str.redhat.com>
 <20260114-alias-riefen-2cb8c09d0ded@brauner>
 <CALCETrWMWs3_G5JhJb7+h+JQjpqXxqOh2vNcQaG1HuXjaeCqQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o5y7y2m7lspkzwlf"
Content-Disposition: inline
In-Reply-To: <CALCETrWMWs3_G5JhJb7+h+JQjpqXxqOh2vNcQaG1HuXjaeCqQw@mail.gmail.com>
X-Rspamd-Queue-Id: 4drzW63NLdz9ttW


--o5y7y2m7lspkzwlf
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: O_CLOEXEC use for OPEN_TREE_CLOEXEC
MIME-Version: 1.0

On 2026-01-14, Andy Lutomirski <luto@amacapital.net> wrote:
> On Wed, Jan 14, 2026 at 8:09=E2=80=AFAM Christian Brauner <brauner@kernel=
=2Eorg> wrote:
> >
> > On Tue, Jan 13, 2026 at 11:40:55PM +0100, Florian Weimer wrote:
> > > In <linux/mount.h>, we have this:
> > >
> > > #define OPEN_TREE_CLOEXEC      O_CLOEXEC       /* Close the file on e=
xecve() */
> > >
> > > This causes a few pain points for us to on the glibc side when we mir=
ror
> > > this into <linux/mount.h> becuse O_CLOEXEC is defined in <fcntl.h>,
> > > which is one of the headers that's completely incompatible with the U=
API
> > > headers.
> > >
> > > The reason why this is painful is because O_CLOEXEC has at least three
> > > different values across architectures: 0x80000, 0x200000, 0x400000
> > >
> > > Even for the UAPI this isn't ideal because it effectively burns three
> > > open_tree flags, unless the flags are made architecture-specific, too.
> >
> > I think that just got cargo-culted... A long time ago some API define as
> > O_CLOEXEC and now a lot of APIs have done the same. I'm pretty sure we
> > can't change that now but we can document that this shouldn't be ifdefed
> > and instead be a separate per-syscall bit. But I think that's the best
> > we can do right now.
> >
>=20
> How about, for future syscalls, we make CLOEXEC unconditional?  If
> anyone wants an ofd to get inherited across exec, they can F_SETFD it
> themselves.

I believe newer interfaces have already started doing that (e.g., all of
the pidfd stuff is O_CLOEXEC by default) but we should definitely update
the documentation in Documentation/process/adding-syscalls.rst to stop
recommending the inclusion of the O_CLOEXEC flag.

The funniest thing about open_tree(2) is that it actually borrows flag
bits from three distinct namespaces! It has an OPEN_TREE_* namespace,
the AT_* namespace (which now has a concept of "per-syscall flags"), and
O_CLOEXEC. What a fun interface!

--=20
Aleksa Sarai
https://www.cyphar.com/

--o5y7y2m7lspkzwlf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaWgIKxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG9PvgEAvm5Uht4Khdsqz7Fz3JDB
jSmpQw9vQYJ1Gl2iS5HVRngA/jQBDhdVmcTHKczcj7iMbxtZXyQTghXPgJCpCCW2
crYH
=GaGW
-----END PGP SIGNATURE-----

--o5y7y2m7lspkzwlf--

