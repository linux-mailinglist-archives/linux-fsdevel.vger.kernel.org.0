Return-Path: <linux-fsdevel+bounces-55608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62986B0C75F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 17:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70E7A16DDB7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 15:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A560C2DEA96;
	Mon, 21 Jul 2025 15:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="ZqA5dv5G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B1C5383;
	Mon, 21 Jul 2025 15:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753111161; cv=none; b=POUHlNSk0HNM1eKNSBBjulqvihlbWDvwSF8enOdnAOjbXlHZQEXK+1lsla8eWk5ktqDAlGrpIrtUTuEEWsSAdVHvUarydwkkEU7dhE8Yzau4nYuDEN9B9/gMAo4S52T+lhFsUquihLw4VT3oKWmljsHju6086hXwx2Ly4UrS1jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753111161; c=relaxed/simple;
	bh=lR9DhaHkYhiIlmXUci5r2sc4oWISTeQIQOFn7N7h9C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FuFDaAOPXJA5MaBepXenO+9wE3pFsYOWXlGAECpXt+zG7qWEs32LrUA2Crglz+ZiXiPthu8f/4cFJq3s5C4MMAlwCZIqVWYZxI+v4UcPhhjDFGdIHIjYSSyGdLHIV79sVR5KEq2FSOr1/qBoGr/2tbe2gqndBADa1vQKRSjC2ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=ZqA5dv5G; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bm3w24T6Qz9thl;
	Mon, 21 Jul 2025 17:19:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1753111154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=27ePGKfk1IpGb39mFKtSkLv7SdmqONl0QJ7+stsT6hM=;
	b=ZqA5dv5GvcMVj639SK6l4HlrSwxA4acrTPV6xpW3cmG5jX7uUkBvVlG8JBoTWgyFx9Fox3
	0o8ddFzdXjEUYc49+If0V+I6aRC34Ryq5bb8uZR9CSVOFrQ+BpuUKFrOaV2QoUB3sUPdrp
	cej4+6ndOPbS6REA8Z+dtgzVYzLMAxXeXu2ZCmqdaMIQwoRTZ+cs5tD2fV1EoPKYisna6b
	uK3BzSzHfNuNAXNOgSKCfr8jkUSQebithqevIrG4l7lLOC1w+D+jndmfxlcpxfIHfc5tdr
	ObuATqX4b6E5RRCqomu5+WEP4bN4dSx0KJCcCp9N+LeZoLyGcFRlNPpKTEl+3g==
Date: Tue, 22 Jul 2025 01:19:00 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 0/4] procfs: make reference pidns more user-visible
Message-ID: <20250721.150803-lavish.ninja.rigid.racism-OCjeOw80sO9@cyphar.com>
References: <20250721-procfs-pidns-api-v1-0-5cd9007e512d@cyphar.com>
 <CALCETrVo+Mdj7as2R0R+FqTBbjqwTkXu5Zkj=dg8EVM9xRhBPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4hmpcw27chbaxqg4"
Content-Disposition: inline
In-Reply-To: <CALCETrVo+Mdj7as2R0R+FqTBbjqwTkXu5Zkj=dg8EVM9xRhBPw@mail.gmail.com>


--4hmpcw27chbaxqg4
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC 0/4] procfs: make reference pidns more user-visible
MIME-Version: 1.0

On 2025-07-21, Andy Lutomirski <luto@amacapital.net> wrote:
> On Mon, Jul 21, 2025 at 1:44=E2=80=AFAM Aleksa Sarai <cyphar@cyphar.com> =
wrote:
> >
> > Ever since the introduction of pid namespaces, procfs has had very
> > implicit behaviour surrounding them (the pidns used by a procfs mount is
> > auto-selected based on the mounting process's active pidns, and the
> > pidns itself is basically hidden once the mount has been constructed).
> > This has historically meant that userspace was required to do some
> > special dances in order to configure the pidns of a procfs mount as
> > desired. Examples include:
> >
> >  * In order to bypass the mnt_too_revealing() check, Kubernetes creates
> >    a procfs mount from an empty pidns so that user namespaced containers
> >    can be nested (without this, the nested containers would fail to
> >    mount procfs). But this requires forking off a helper process because
> >    you cannot just one-shot this using mount(2).
> >
> >  * Container runtimes in general need to fork into a container before
> >    configuring its mounts, which can lead to security issues in the case
> >    of shared-pidns containers (a privileged process in the pidns can
> >    interact with your container runtime process). While
> >    SUID_DUMP_DISABLE and user namespaces make this less of an issue, the
> >    strict need for this due to a minor uAPI wart is kind of unfortunate.
> >
> > Things would be much easier if there was a way for userspace to just
> > specify the pidns they want. Patch 1 implements a new "pidns" argument
> > which can be set using fsconfig(2):
> >
> >     fsconfig(procfd, FSCONFIG_SET_FD, "pidns", NULL, nsfd);
> >     fsconfig(procfd, FSCONFIG_SET_STRING, "pidns", "/proc/self/ns/pid",=
 0);
> >
> > or classic mount(2) / mount(8):
> >
> >     // mount -t proc -o pidns=3D/proc/self/ns/pid proc /tmp/proc
> >     mount("proc", "/tmp/proc", "proc", MS_..., "pidns=3D/proc/self/ns/p=
id");
> >
> > The initial security model I have in this RFC is to be as conservative
> > as possible and just mirror the security model for setns(2) -- which
> > means that you can only set pidns=3D... to pid namespaces that your
> > current pid namespace is a direct ancestor of. This fulfils the
> > requirements of container runtimes, but I suspect that this may be too
> > strict for some usecases.
> >
> > The pidns argument is not displayed in mountinfo -- it's not clear to me
> > what value it would make sense to show (maybe we could just use ns_dname
> > to provide an identifier for the namespace, but this number would be
> > fairly useless to userspace). I'm open to suggestions.
> >
> > In addition, being able to figure out what pid namespace is being used
> > by a procfs mount is quite useful when you have an administrative
> > process (such as a container runtime) which wants to figure out the
> > correct way of mapping PIDs between its own namespace and the namespace
> > for procfs (using NS_GET_{PID,TGID}_{IN,FROM}_PIDNS). There are
> > alternative ways to do this, but they all rely on ancillary information
> > that third-party libraries and tools do not necessarily have access to.
> >
> > To make this easier, add a new ioctl (PROCFS_GET_PID_NAMESPACE) which
> > can be used to get a reference to the pidns that a procfs is using.
> >
> > It's not quite clear what is the correct security model for this API,
> > but the current approach I've taken is to:
> >
> >  * Make the ioctl only valid on the root (meaning that a process without
> >    access to the procfs root -- such as only having an fd to a procfs
> >    file or some open_tree(2)-like subset -- cannot use this API).
> >
> >  * Require that the process requesting either has access to
> >    /proc/1/ns/pid anyway (i.e. has ptrace-read access to the pidns
> >    pid1), has CAP_SYS_ADMIN access to the pidns (i.e. has administrative
> >    access to it and can join it if they had a handle), or is in a pidns
> >    that is a direct ancestor of the target pidns (i.e. all of the pids
> >    are already visible in the procfs for the current process's pidns).
>=20
> What's the motivation for the ptrace-read option?  While I don't see
> an attack off the top of my head, it seems like creating a procfs
> mount may give write-ish access to things in the pidns (because the
> creator is likely to have CAP_DAC_OVERRIDE, etc) and possibly even
> access to namespace-wide things that aren't inherently visible to
> PID1.

This latter section is about the privilege model for
ioctl(PROCFS_GET_PID_NAMESPACE), not the pidns=3D mount flag. pidns=3D
requires CAP_SYS_ADMIN for pidns->user_ns, in addition to the same
restrictions as pidns_install() (must be a direct ancestor). Maybe I
should add some headers in this cover letter for v2...

For the ioctl -- if the user can ptrace-read pid1 in the pidns, they can
open a handle to /proc/1/ns/pid which is exactly the same thing they'd
get from PROCFS_GET_PID_NAMESPACE.

> Even the ancestor check seems dicey.  Imagine that uid 1000 makes an
> unprivileged container complete with a userns.  Then uid 1001 (outside
> the container) makes its own userns and mountns but stays in the init
> pidns and then mounts (and owns, with all filesystem-related
> capabilities) that mount.  Is this really safe?

As for the ancestor check (for the ioctl), the logic I had was that
being in an ancestor pidns means that you already can see all of the
subprocesses in your own pidns, so it seems strange to not be able to
get a handle to their pidns. Maybe this isn't quite right, idk.

Ultimately there isn't too much you can do with a pidns fd if you don't
have privileges to join it (the only thing I can think of is that you
could bind-mount it, which could maybe be used to trick an
administrative process if they trusted your mountns for some reason).

> CAP_SYS_ADMIN seems about right.

For pidns=3D, sure. For the ioctl, I think this is overkill.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--4hmpcw27chbaxqg4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaH5aYwAKCRAol/rSt+lE
bxwJAPsExwFlCYmv56CAhmcD4tOiYjdj4rRodrWoLlDHqXc2QwD+OcuhtT7gwFY5
kPb4AgmTUiYufiAlBeMVvO42bxZK/A8=
=EH6N
-----END PGP SIGNATURE-----

--4hmpcw27chbaxqg4--

