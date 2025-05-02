Return-Path: <linux-fsdevel+bounces-47928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3B1AA7480
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 16:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08C1D9E06DF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 14:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57734255F5B;
	Fri,  2 May 2025 14:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="B5wb5Ahn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E88623C4EB
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 May 2025 14:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746194994; cv=none; b=Q9DTbfq8JJkVlkn0LObXD0ra/sHlAMSlfL3fC7oAmU7LyrEgdhLDkdEE6PXokhQdgePmQuj6pVBY38qjOgSfXbUROVnevW9/UYvq9YjeAk20l7VrpqsxfmoY+O06kDNysSBWHNJmZx4oNHt3cYJAx8Rt+iT05nJa6e9QcY8r3BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746194994; c=relaxed/simple;
	bh=TY3gSKwbF1lNE9LVMCWRdusB6/9qpU7BzIkUVPeNLkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkCjvi4tJ22zloCyUZBVOzf+iQl5N9or2WE7GVZHPeSf3phIqA9w/izZ0gF+jr+gOeBGE1V4zKJqIkPlfX+S3R+n+44WVYkxA5DuVjagO7P0rRJ8PCYbbGVwuyqp9K1zgvCI8TxXYFHqwrSzh5pIdsyHRCiXyw5xWgareJHS1X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=B5wb5Ahn; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Zpt8k3c2kz9tW3;
	Fri,  2 May 2025 16:09:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1746194982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xN9w4RmE6zjsaQ9MbjOzKmQSdpH3nvhTfpbQEvmypO0=;
	b=B5wb5AhnVsypFIhJ5yBHVmTDkSLiwQCAFIXJzU1Rguj8KWu4zvLj3T0c4k0RV1eZRq8RdX
	djQ0HWuvoizzsS4X2DVM0RuWXSk61d9bLfMHd5G6KNNsUICx97lDEnLg8EkV4CY4Ysy2CU
	XLexnkjrHrzzHEg301bWskPBoA9yQ+aEM/X5f4RiCvNzR9R6kaC168ogGtxZHgFd7rrqmi
	RAKNNV16M5ItZYIlwG71EpBnhWm/k+iky9qAh3mgBs8vxcfYAyFe/SjRIPUAlXtxaZirqF
	NKAJGKVPbCijUYupfTtxlHf8SGP3lbXAQ6tL7W7+LXzO59JQ6Skzkwvoq0+OZA==
Date: Sat, 3 May 2025 00:09:32 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Allison Karlitskaya <lis@redhat.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: CAP_SYS_ADMIN restriction for passthrough fds
Message-ID: <20250502.085944-vague.answers.simpler.cure-3kij9vZ9O1RB@cyphar.com>
References: <CAOYeF9V_FM+0iZcsvi22XvHJuXLXP6wUYPwRYfwVFThajww9YA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xolgulxv2log4ffi"
Content-Disposition: inline
In-Reply-To: <CAOYeF9V_FM+0iZcsvi22XvHJuXLXP6wUYPwRYfwVFThajww9YA@mail.gmail.com>
X-Rspamd-Queue-Id: 4Zpt8k3c2kz9tW3


--xolgulxv2log4ffi
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: CAP_SYS_ADMIN restriction for passthrough fds
MIME-Version: 1.0

On 2025-05-02, Allison Karlitskaya <lis@redhat.com> wrote:
> hi,
>=20
> Please excuse me if these are dumb questions.  I'm not great at this stuf=
f. :)
>=20
> In fuse_backing_open() there's a check with an interesting comment:
>=20
>     /* TODO: relax CAP_SYS_ADMIN once backing files are visible to lsof */
>     res =3D -EPERM;
>     if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
>         goto out;
>=20
> I've done some research into this but I wasn't able to find any
> original discussion about what led to this, or about current plans to
> "relax" this restriction -- only speculation about it being a
> potential mechanism to "hide" open files.
>=20
> It would be nice to have an official story about this, on the record.
> What's the concrete problem here, and what would it take to solve it?
> Are there plans?  Is help required?  Would it be possible to relax the
> check to having CAP_SYS_ADMIN in the userns which owns the mount (ie:
> ns_capable(...))?  What would it take to do that?  It would be
> wonderful to be able to use this inside of containers.
>=20
> The most obvious guess about direction (based on the comment) is that
> we need to do something to make sure that fds that are registered with
> backing IDs remain visible in the output of `lsof` even after the
> original fd is closed?
>=20
> Thanks in advance for any information you can give.  Even if the
> answer is "no, it's impossible" it would be great to have that on
> record.

My guess is that the issue is that we don't want an unprivileged process
to be able to create a file reference that cannot be found (with
something like lsof) and forcefully closed/killed by a sysadmin.
Otherwise you could end up with a DOS with an admin being unable to
unmount a filesystem or otherwise figure out what process is holding on
to garbage.

My hot take is that this is already possible in several ways, though
admittedly the ones I can think of all require unprivileged user
namespaces. (You can create bind-mount that is kept alive but not
visible to any user-space process. The simplest way is to do mounts and
chroot. Another is with open_tree().) Now, these won't block umount
outright but you'll get the same effect as umount -l, which can be a
problem.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--xolgulxv2log4ffi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaBTSHAAKCRAol/rSt+lE
b90cAP4wSdxVmo5KSvTzHDyuF3Jv2Ab18u4bhXZSNlBW+SQADQD/fU8CXXXRp0fZ
pd6C3uEoICbnMEs9wVTI2dDCT/Nr7AM=
=KOug
-----END PGP SIGNATURE-----

--xolgulxv2log4ffi--

