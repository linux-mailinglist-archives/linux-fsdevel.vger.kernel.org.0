Return-Path: <linux-fsdevel+bounces-18814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D449F8BC824
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 09:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A3FF1F22291
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 07:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1973874432;
	Mon,  6 May 2024 07:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="V08lBjsV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873284F213;
	Mon,  6 May 2024 07:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714979667; cv=none; b=gOGaHs9eceQQiCiAzPoU1iPU+MW8LqifZEzdmoK/2iVqrLe+6QxxZCL4Y7CXZ1FXniI8t1e/raxxB+1roVDvxwLrBgO3xybH+vTqTUHB3OausBX/79hE8ajHSjjOHUDi++GMdRHMPjxk5n1Qsm5mQtsA+9AmKdzx9z/rhZLZtzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714979667; c=relaxed/simple;
	bh=Dygdq8cppKEQPzRYXrG1OaW8DCB7aL6OMePXXxzqQrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LO+gI5nVrBT5c9zHAbGxcVMLcw/0qDoukfBTRQlEbFuXTjQ+ojg61RCmd8Aywv9cOt6AaBz2xIzV7btOG0owuVWIYrm9w0KrO/Vk3UL2uhooetgjPE2x9l5TtjprrchpqcFtXRR6YBNKwk7QXiXW90eCLAyQ6q2WKayCaLOjEZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=V08lBjsV; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4VXt240Nltz9stm;
	Mon,  6 May 2024 09:14:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1714979660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+vucf9U0kG+ujJlNP6bEQbpSKQ0yhjin8ohNdx+U0rI=;
	b=V08lBjsVYZMjGEWylhBA7aFdmYPot3jrdjyhP7oWrp7uS/yxxzQORvW/Vwe9SBLObNaCiH
	awa4JkZ7XuD0P+QjgfyFkP+UwZh5cr+rM9x0YYlezN5I7Hno55Zu0V8BfQr604yd+GxbmU
	EjuierlnobZ6eLFqo8o33rFNgTVcYd+STo6kggFSResZ9yuUIxwBKqO/VU6NcNS/q8e+Wl
	QC7EHVl6iScw3T5AnXiJj2zUN/lpWZLX+AVAQacYBYntB3ENJJ1vl7NHRpGOUQ5i4iZbLX
	EaUX+pTPE5YTAhEQ8CWfi9b37lmGJ4UlCYmlT2X3Ba778F52hG3prXBkOInVjA==
Date: Mon, 6 May 2024 17:13:59 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Stas Sergeev <stsp2@yandex.ru>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-kernel@vger.kernel.org, Stefan Metzmacher <metze@samba.org>, 
	Eric Biederman <ebiederm@xmission.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Andy Lutomirski <luto@kernel.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, David Laight <David.Laight@aculab.com>, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Christian =?utf-8?B?R8O2dHRzY2hl?= <cgzones@googlemail.com>
Subject: Re: [PATCH v5 0/3] implement OA2_CRED_INHERIT flag for openat2()
Message-ID: <20240428.171236-tangy.giblet.idle.helpline-y9LqufL7EAAV@cyphar.com>
References: <20240426133310.1159976-1-stsp2@yandex.ru>
 <CALCETrUL3zXAX94CpcQYwj1omwO+=-1Li+J7Bw2kpAw4d7nsyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="swbizyhwpvawptrc"
Content-Disposition: inline
In-Reply-To: <CALCETrUL3zXAX94CpcQYwj1omwO+=-1Li+J7Bw2kpAw4d7nsyw@mail.gmail.com>
X-Rspamd-Queue-Id: 4VXt240Nltz9stm


--swbizyhwpvawptrc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-04-28, Andy Lutomirski <luto@amacapital.net> wrote:
> > On Apr 26, 2024, at 6:39=E2=80=AFAM, Stas Sergeev <stsp2@yandex.ru> wro=
te:
> > =EF=BB=BFThis patch-set implements the OA2_CRED_INHERIT flag for openat=
2() syscall.
> > It is needed to perform an open operation with the creds that were in
> > effect when the dir_fd was opened, if the dir was opened with O_CRED_AL=
LOW
> > flag. This allows the process to pre-open some dirs and switch eUID
> > (and other UIDs/GIDs) to the less-privileged user, while still retaining
> > the possibility to open/create files within the pre-opened directory se=
t.
> >
>=20
> I=E2=80=99ve been contemplating this, and I want to propose a different s=
olution.
>=20
> First, the problem Stas is solving is quite narrow and doesn=E2=80=99t
> actually need kernel support: if I want to write a user program that
> sandboxes itself, I have at least three solutions already.  I can make
> a userns and a mountns; I can use landlock; and I can have a separate
> process that brokers filesystem access using SCM_RIGHTS.
>=20
> But what if I want to run a container, where the container can access
> a specific host directory, and the contained application is not aware
> of the exact technology being used?  I recently started using
> containers in anger in a production setting, and =E2=80=9Canger=E2=80=9D =
was
> definitely the right word: binding part of a filesystem in is
> *miserable*.  Getting the DAC rules right is nasty.  LSMs are worse.
> Podman=E2=80=99s =E2=80=9Cbind,relabel=E2=80=9D feature is IMO utterly di=
sgusting.  I think I
> actually gave up on making one of my use cases work on a Fedora
> system.
>=20
> Here=E2=80=99s what I wanted to do, logically, in production: pick a host
> directory, pick a host *principal* (UID, GID, label, etc), and have
> the *entire container* access the directory as that principal. This is
> what happens automatically if I run the whole container as a userns
> with only a single UID mapped, but I don=E2=80=99t really want to do that=
 for
> a whole variety and of reasons.
>=20
> So maybe reimagining Stas=E2=80=99 feature a bit can actually solve this
> problem.  Instead of a special dirfd, what if there was a special
> subtree (in the sense of open_tree) that captures a set of creds and
> does all opens inside the subtree using those creds?
>=20
> This isn=E2=80=99t a fully formed proposal, but I *think* it should be
> generally fairly safe for even an unprivileged user to clone a subtree
> with a specific flag set to do this. Maybe a capability would be
> needed (CAP_CAPTURE_CREDS?), but it would be nice to allow delegating
> this to a daemon if a privilege is needed, and getting the API right
> might be a bit tricky.

Tying this to an actual mount rather than a file handle sounds like a
more plausible proposal than OA2_CRED_INHERIT, but it just seems that
this is going to re-create all of the work that went into id-mapped
mounts but with the extra-special step of making the generic VFS
permissions no longer work normally (unless the idea is that everything
would pretend to be owned by current_fsuid()?).

IMHO it also isn't enough to just make open work, you need to make all
operations work (which leads to a non-trivial amount of
filesystem-specific handling), which is just idmapped mounts. A lot of
work was put into making sure that is safe, and collapsing owners seems
like it will cause a lot of headaches.

I also find it somewhat amusing that this proposal is to basically give
up on multi-user permissions for this one directory tree because it's
too annoying to deal with. In that case, isn't chmod 777 a simpler
solution? (I'm being a bit flippant, of course there is a difference,
but the net result is that all users in the container would have the
same permissions with all of the fun issues that implies.)

In short, AFAICS idmapped mounts pretty much solve this problem (minus
the ability to collapse users, which I suspect is not a good idea in
general)?

> Then two different things could be done:
>=20
> 1. The subtree could be used unmounted or via /proc magic links. This
> would be for programs that are aware of this interface.
>=20
> 2. The subtree could be mounted, and accessed through the mount would
> use the captured creds.
>=20
> (Hmm. What would a new open_tree() pointing at this special subtree do?)
>=20
>=20
> With all this done, if userspace wired it up, a container user could
> do something like:
>=20
> =E2=80=94bind-capture-creds source=3Ddest
>=20
> And the contained program would access source *as the user who started
> the container*, and this would just work without relabeling or
> fiddling with owner uids or gids or ACLs, and it would continue to
> work even if the container has multiple dynamically allocated subuids
> mapped (e.g. one for =E2=80=9Croot=E2=80=9D and one for the actual applic=
ation).
>=20
> Bonus points for the ability to revoke the creds in an already opened
> subtree. Or even for the creds to automatically revoke themselves when
> the opener exits (or maybe when a specific cred-pinning fd goes away).
>=20
> (This should work for single files as well as for directories.)
>=20
> New LSM hooks or extensions of existing hooks might be needed to make
> LSMs comfortable with this.
>=20
> What do you all think?

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--swbizyhwpvawptrc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZjiDNgAKCRAol/rSt+lE
b4AgAQD3c5xKhJcmOlaL6i9Mj5Pz1CQQ1VkmIRj6GYk5SX/OTgD/UhuXPIbd1+Tb
M1BFJxkpa+9FRHnJz8gxnUjbtoA0kwo=
=8MgE
-----END PGP SIGNATURE-----

--swbizyhwpvawptrc--

