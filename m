Return-Path: <linux-fsdevel+bounces-62061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6153B82C71
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 05:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ABBC1699CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 03:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CFD24397A;
	Thu, 18 Sep 2025 03:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="big4Eoc6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF6D14B06C;
	Thu, 18 Sep 2025 03:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758166853; cv=none; b=uCgAExDAX9vpLT3+miNlZz5xqFPooFFnt2a77YtT8slrBZr9yY2bpauZ9TfVI/F6T045pYEKNikYA2yNEQadTkK25k6k5QNaWEV+ZFD+OC7mTOIBDM1XjdUQGwfgPZXky7ICgZytQOsnpnLAUsdyKmAy+dGuKOhiNy3S29eHp/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758166853; c=relaxed/simple;
	bh=yT3K8uBlaTZ4oRUfArIJX6RgDQSVHzMNclhTow/TmcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKYHvAaaWn7oaIhitT7y6Uor4Icp/GYYmJibIkfA64qXXcPRno5aE6RMe/i4jQe9aBlLuPNujtdgp3TA63kXIDjGJLY26+3Rg5HeM6REjPpkztvqguwZDP+qSnXsNP5spj07E1Sos5UAbt6roWaUULikQB8TMSn7VyulgzQ3Cyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=big4Eoc6; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cS1cm4XT6z9slX;
	Thu, 18 Sep 2025 05:40:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1758166840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yT3K8uBlaTZ4oRUfArIJX6RgDQSVHzMNclhTow/TmcE=;
	b=big4Eoc6bqe9q6T1qfJlYA+OdrIwGvvsbDSKl3AuavBpgBdtZE80XTg558Tgu7XEEM8GOu
	4HUYEXX3fg4YSlTHkbhSzBpl4q+It3vCwD8MPvGv+yvT3h/qqjzlnM6zyF0rYqbmgws1wp
	izbsOl3m35zhbv9k5i+H5sufoIWJ5Zx22JTz5VfKjy2MPYp0thT/hpGB6m5bKMiCSc4vxo
	fup1hwDmgk7OLk1BJPCqqYzVpItRsxz5QsfkOyTs5OQi0OIBGdsZDEkui+UTHKBiwFi8J2
	7Jl+u7/uXJro9unpSw3pyztLb2ULxy77hNAqJxuLy2ZwfGguHTyBWmYb5gA+oA==
Date: Thu, 18 Sep 2025 13:40:20 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH 27/32] nsfs: support file handles
Message-ID: <2025-09-18-onyx-sunny-pleats-turbans-lW2ejZ@cyphar.com>
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
 <20250910-work-namespace-v1-27-4dd56e7359d8@kernel.org>
 <CAOQ4uxgtQQa-jzsnTBxgUTPzgtCiAaH8X6ffMqd+1Y5Jjy0dmQ@mail.gmail.com>
 <20250911-werken-raubzug-64735473739c@brauner>
 <CAOQ4uxgMgzOjz4E-4kJFJAz3Dpd=Q6vXoGrhz9F0=mb=4XKZqA@mail.gmail.com>
 <20250912-wirsing-karibus-7f6a98621dd1@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d2xgw3mufvo5akdl"
Content-Disposition: inline
In-Reply-To: <20250912-wirsing-karibus-7f6a98621dd1@brauner>


--d2xgw3mufvo5akdl
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 27/32] nsfs: support file handles
MIME-Version: 1.0

On 2025-09-12, Christian Brauner <brauner@kernel.org> wrote:
> On Thu, Sep 11, 2025 at 01:36:28PM +0200, Amir Goldstein wrote:
> > On Thu, Sep 11, 2025 at 11:31=E2=80=AFAM Christian Brauner <brauner@ker=
nel.org> wrote:
> > >
> > > On Wed, Sep 10, 2025 at 07:21:22PM +0200, Amir Goldstein wrote:
> > > > On Wed, Sep 10, 2025 at 4:39=E2=80=AFPM Christian Brauner <brauner@=
kernel.org> wrote:
> > > > >
> > > > > A while ago we added support for file handles to pidfs so pidfds =
can be
> > > > > encoded and decoded as file handles. Userspace has adopted this q=
uickly
> > > > > and it's proven very useful.
> > > >
> > > > > Pidfd file handles are exhaustive meaning
> > > > > they don't require a handle on another pidfd to pass to
> > > > > open_by_handle_at() so it can derive the filesystem to decode in.
> > > > >
> > > > > Implement the exhaustive file handles for namespaces as well.
> > > >
> > > > I think you decide to split the "exhaustive" part to another patch,
> > > > so better drop this paragraph?
> > >
> > > Yes, good point. I've dont that.
> > >
> > > > I am missing an explanation about the permissions for
> > > > opening these file handles.
> > > >
> > > > My understanding of the code is that the opener needs to meet one of
> > > > the conditions:
> > > > 1. user has CAP_SYS_ADMIN in the userns owning the opened namespace
> > > > 2. current task is in the opened namespace
> > >
> > > Yes.
> > >
> > > >
> > > > But I do not fully understand the rationale behind the 2nd conditio=
n,
> > > > that is, when is it useful?
> > >
> > > A caller is always able to open a file descriptor to it's own set of
> > > namespaces. File handles will behave the same way.
> > >
> >=20
> > I understand why it's safe, and I do not object to it at all,
> > I just feel that I do not fully understand the use case of how ns file =
handles
> > are expected to be used.
> > A process can always open /proc/self/ns/mnt
> > What's the use case where a process may need to open its own ns by hand=
le?
> >=20
> > I will explain. For CAP_SYS_ADMIN I can see why keeping handles that
> > do not keep an elevated refcount of ns object could be useful in the sa=
me
> > way that an NFS client keeps file handles without keeping the file obje=
ct alive.
> >=20
> > But if you do not have CAP_SYS_ADMIN and can only open your own ns
> > by handle, what is the application that could make use of this?
> > and what's the benefit of such application keeping a file handle instea=
d of
> > ns fd?
>=20
> A process is not always able to open /proc/self/ns/. That requires
> procfs to be mounted and for /proc/self/ or /proc/self/ns/ to not be
> overmounted. However, they can derive a namespace fd from their own
> pidfd. And that also always works if it's their own namespace.

It's also important to note that if /proc/self and /proc/thread-self are
overmounted, you can get into scenarios where /proc/$pid will refer to
the wrong process (container runtimes run into this scenario a lot --
when configuring a container there is a point where we are in a new
pidns but still see the host /proc, which leads to lots of fun bugs).

> There's no need to introduce unnecessary behavioral differences between
> /proc/self/ns/, pidfd-derived namespace fs, and file-handle-derived
> namespace fds. That's just going to be confusing.
>=20
> The other thing is that there are legitimate use-case for encoding your
> own namespace. For example, you might store file handles to your set of
> namespaces in a file on-disk so you can verify when you get rexeced that
> they're still valid and so on. This is akin to the pidfd use-case.
>=20
> Or just plainly for namespace comparison reasons where you keep a file
> handle to your own namespaces and can then easily check against others.

I agree wholeheartedly.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--d2xgw3mufvo5akdl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaMt/JBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG+0QwEAy14crLGqBanw8F+iJGyg
Ufib+dDPLnlaRH2JgIDOdJgBANhW3e6kOOLSuP7Zb/NhMzS6y+B/qnF8mUByEN7m
bhII
=NYA2
-----END PGP SIGNATURE-----

--d2xgw3mufvo5akdl--

