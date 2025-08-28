Return-Path: <linux-fsdevel+bounces-59459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D16CB39044
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 02:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97C71683141
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 00:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99521A256B;
	Thu, 28 Aug 2025 00:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="IjykoAQq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7116A3FC2;
	Thu, 28 Aug 2025 00:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756342389; cv=none; b=Tg/eDV/d1GEploKvDHSbsfsms2UG6JTdLGnCd7JE4MQHTlcPlRAHpohrMs4GgUCE5tw1vancN05yHjHSd4Dc+qOqSxlEt59C3RPWylcViE0l+MuIvTuAQ6jTsJAgJAX6rIFCFGXKq+bKiHSqbLXEK79XczhMiAln9Q0e91xqEwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756342389; c=relaxed/simple;
	bh=gQf+PWyp6TnihmKGlYeBwS7O4NsUMz9RyWp5vamaK7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgevz27IskneTFawO0kSjhyxIVvR+DZdiZweMSnovyK0t1oR9A5Yywgy3DKMq/NH6Y+fYUUC2f9JdyNOka87i8qI6wrJCf2ucHEO77+NNJtMNRgomfP136MT0gDVKxk0odgeHy2u8mDlGk/1D1iyzidiTX7KK1TATz021fdAXu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=IjykoAQq; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cC2v30ggvz9tQQ;
	Thu, 28 Aug 2025 02:53:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1756342383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+nkOVSTJeGMrXnWxpGpCSqeWsWiSvBuOe+MZ2w3etRU=;
	b=IjykoAQqWYQXRZz4Xn49InWy8P9wskh17pgP4b5aQ35Z4D48ODkQay3K09Nob+X0BaCp5w
	jx41jaJ3Pf4M4/zNR86ugRZyrBFQBOmqAz7N2Vc8wnCBwbhJfmrepDjg2a+QwFGu5MtyM3
	AZXaxFlqcyiBbZF1N0gw0ePo6/JX/AlNJNc5i0mNd1z0ywmkgvv10Xcl264sTwtfm5HIf6
	Bhk1QJuKol+hI+LYmKQY1NzQfmoU56kcgEdeZ0FMIn4FxaccZTisU/zeeS7124dztDMfsg
	CAVgyvvwhy1GjpX3yvVhmPcNAIVUgynEHOeMCnvZTjgATZFrlOa2yqTcEls94w==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Thu, 28 Aug 2025 10:52:42 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Andy Lutomirski <luto@kernel.org>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Kees Cook <keescook@chromium.org>, Paul Moore <paul@paul-moore.com>, 
	Serge Hallyn <serge@hallyn.com>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Heimes <christian@python.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Elliott Hughes <enh@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jordan R Abrahams <ajordanr@google.com>, 
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Luca Boccassi <bluca@debian.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Miklos Szeredi <mszeredi@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
	Robert Waite <rowait@microsoft.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Scott Shell <scottsh@microsoft.com>, Steve Dower <steve.dower@python.org>, 
	Steve Grubb <sgrubb@redhat.com>, kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/2] Add O_DENY_WRITE (complement AT_EXECVE_CHECK)
Message-ID: <2025-08-28-alert-groggy-mugs-lapse-IWqeR7@cyphar.com>
References: <20250822170800.2116980-1-mic@digikod.net>
 <20250826-skorpion-magma-141496988fdc@brauner>
 <20250826.aig5aiShunga@digikod.net>
 <2025-08-27-obscene-great-toy-diary-X1gVRV@cyphar.com>
 <CALCETrWHKga33bvzUHnd-mRQUeNXTtXSS8Y8+40d5bxv-CqBhw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t3uldpk5vmc35wcr"
Content-Disposition: inline
In-Reply-To: <CALCETrWHKga33bvzUHnd-mRQUeNXTtXSS8Y8+40d5bxv-CqBhw@mail.gmail.com>
X-Rspamd-Queue-Id: 4cC2v30ggvz9tQQ


--t3uldpk5vmc35wcr
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH v1 0/2] Add O_DENY_WRITE (complement AT_EXECVE_CHECK)
MIME-Version: 1.0

On 2025-08-27, Andy Lutomirski <luto@kernel.org> wrote:
> On Wed, Aug 27, 2025 at 5:14=E2=80=AFPM Aleksa Sarai <cyphar@cyphar.com> =
wrote:
> >
> > On 2025-08-26, Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> wrote:
> > > On Tue, Aug 26, 2025 at 11:07:03AM +0200, Christian Brauner wrote:
> > > > Nothing has changed in that regard and I'm not interested in stuffi=
ng
> > > > the VFS APIs full of special-purpose behavior to work around the fa=
ct
> > > > that this is work that needs to be done in userspace. Change the ap=
ps,
> > > > stop pushing more and more cruft into the VFS that has no business
> > > > there.
> > >
> > > It would be interesting to know how to patch user space to get the sa=
me
> > > guarantees...  Do you think I would propose a kernel patch otherwise?
> >
> > You could mmap the script file with MAP_PRIVATE. This is the *actual*
> > protection the kernel uses against overwriting binaries (yes, ETXTBSY is
> > nice but IIRC there are ways to get around it anyway).
>=20
> Wait, really?  MAP_PRIVATE prevents writes to the mapping from
> affecting the file, but I don't think that writes to the file will
> break the MAP_PRIVATE CoW if it's not already broken.

Oh I guess you're right -- that's news to me. And from mmap(2):

> MAP_PRIVATE
> [...] It is unspecified whether changes made to the file after the
> mmap() call are visible in the mapped region.

But then what is the protection mechanism (in the absence of -ETXTBSY)
that stops you from overwriting the live text of a binary by just
writing to it?

I would need to go trawling through my old scripts to find the
reproducer that let you get around -ETXTBSY (I think it involved
executable memfds) but I distinctly remember that even if you overwrote
the binary you would not see the live process's mapped mm change value.
(Ditto for the few kernels when we removed -ETXTBSY.) I found this
surprising, but assumed that it was because of MAP_PRIVATE.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--t3uldpk5vmc35wcr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaK+oWhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG9YOwD+IgeIsIsIT209gc6p0UJ+
RpiujJ3PHk79u8piCbNs9GIA/2I0ge/RGvNochLLI17BW1sMdgZdclwN/rf+cUxC
cnwF
=FhJ0
-----END PGP SIGNATURE-----

--t3uldpk5vmc35wcr--

