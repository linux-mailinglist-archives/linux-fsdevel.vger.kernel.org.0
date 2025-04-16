Return-Path: <linux-fsdevel+bounces-46595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1E0A90E74
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 00:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FB503AA6B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 22:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA89424889A;
	Wed, 16 Apr 2025 22:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9vajFVO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511F4946F;
	Wed, 16 Apr 2025 22:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744841517; cv=none; b=IDgB8WTSn/evN9MtR0MtUqfKaxE0vSiWMdmF3arx2QBOeQORsyWntAsFLhiLvNsx2Rak453S1Qlyy0LFcDFYk80U6Efl6h+g1Pjb3w5FUhEiNHrs1KtMRgtgQq2yg6idoCEZtF48lQcRtDeRLr7aFhQ2RyS0/If7D5fEoZsNQdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744841517; c=relaxed/simple;
	bh=VnutcvSMqWO9EFZdAJ3Trur5sqIDzJa/xMPbZdhHsbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8NEyABMWL/D5cprSY2KocQnK/jE98PcRQdTxmHdheF+cSG7uuV2xXd6H7yOqPfGD9o7HH5Pel1ci9UC96MzKSZsmZe4mM2Oky4qILqby/9NNYFTrivqJmLLCwOI3SkN0aylGJkwjlLhky9sRiNtlHB0QR6gQZeVk0FS6uV4UkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9vajFVO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07924C4CEE2;
	Wed, 16 Apr 2025 22:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744841516;
	bh=VnutcvSMqWO9EFZdAJ3Trur5sqIDzJa/xMPbZdhHsbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c9vajFVO92xiKWLXkAxHJ3XUc2XoSc38UXxTzZZ18mvfbTvua6A2zuLhv08udSnb8
	 oW+cHXzanD5XIbTse4VEuEV1ihYsQxsUTKdbgsV4o8lwZmXPwYqCdtQ8eeXRPlyY3f
	 nAxMvS659GM5/vXh8Piech8RnJm5itn7hZpSMUEhpKNmrqsG8wQE3yHuXwPjzCvuH2
	 ypaeV9zgmijKJhXUlWbH6I8FEmPf2yrOQ/fIDN3XjWVXFOi93iBVKEFoLfJWl9KiUU
	 m8ikparjRAE0OScJLzWCX5ZRisDD9ZUIavbVU7uk3PJkJr1UF//r555g9QMe3DUXMi
	 LAlLQj8kSIYxQ==
Date: Wed, 16 Apr 2025 23:11:51 +0100
From: Mark Brown <broonie@kernel.org>
To: Eric Chanudet <echanude@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Ian Kent <ikent@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Alexander Larsson <alexl@redhat.com>,
	Lucas Karpinski <lkarpins@redhat.com>, Aishwarya.TCV@arm.com
Subject: Re: [PATCH v4] fs/namespace: defer RCU sync for MNT_DETACH umount
Message-ID: <fbbafa84-f86c-4ea4-8f41-e5ebb51173ed@sirena.org.uk>
References: <20250408210350.749901-12-echanude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QXNPbZDwSBbfcPw6"
Content-Disposition: inline
In-Reply-To: <20250408210350.749901-12-echanude@redhat.com>
X-Cookie: That's no moon...


--QXNPbZDwSBbfcPw6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 08, 2025 at 04:58:34PM -0400, Eric Chanudet wrote:
> Defer releasing the detached file-system when calling namespace_unlock()
> during a lazy umount to return faster.
>=20
> When requesting MNT_DETACH, the caller does not expect the file-system
> to be shut down upon returning from the syscall. Calling
> synchronize_rcu_expedited() has a significant cost on RT kernel that
> defaults to rcupdate.rcu_normal_after_boot=3D1. Queue the detached struct
> mount in a separate list and put it on a workqueue to run post RCU
> grace-period.

For the past couple of days we've been seeing failures in a bunch of LTP
filesystem related tests on various arm64 systems.  The failures are
mostly (I think all) in the form:

20101 10:12:40.378045  tst_test.c:1833: TINFO: =3D=3D=3D Testing on vfat =
=3D=3D=3D
20102 10:12:40.385091  tst_test.c:1170: TINFO: Formatting /dev/loop0 with v=
fat opts=3D'' extra opts=3D''
20103 10:12:40.391032  mkfs.vfat: unable to open /dev/loop0: Device or reso=
urce busy
20104 10:12:40.395953  tst_test.c:1170: TBROK: mkfs.vfat failed with exit c=
ode 1

ie, a failure to stand up the test environment on the loopback device
all happening immediately after some other filesystem related test which
also used the loop device.  A bisect points to commit a6c7a78f1b6b97
which is this, which does look rather relevant.  LTP is obviously being
very much an edge case here.

Bisect log:

git bisect start
# status: waiting for both good and bad commits
# bad: [f660850bc246fef15ba78c81f686860324396628] Add linux-next specific f=
iles for 20250416
git bisect bad f660850bc246fef15ba78c81f686860324396628
# status: waiting for good commit(s), bad commit known
# good: [a6b9fbe391e8da36d2892590db4db4ff94005807] Merge branch 'for-linux-=
next-fixes' of https://gitlab.freedesktop.org/drm/misc/kernel.git
git bisect good a6b9fbe391e8da36d2892590db4db4ff94005807
# bad: [c017ce6f8d2939445ac473ada6a266aca0a0d6eb] Merge branch 'drm-next' o=
f https://gitlab.freedesktop.org/drm/kernel.git
git bisect bad c017ce6f8d2939445ac473ada6a266aca0a0d6eb
# bad: [3efe6d22f422cbba9de75b53890c624a83dbb70a] Merge branch 'next' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
git bisect bad 3efe6d22f422cbba9de75b53890c624a83dbb70a
# good: [ce44f781015a988baf21317f7822567a62a77a5f] Merge branch 'for-next' =
of git://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git
git bisect good ce44f781015a988baf21317f7822567a62a77a5f
# good: [64a47089f778b6e4bfaaf62d4384eaa2bcaf9b63] Merge branch 'overlayfs-=
next' of git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git
git bisect good 64a47089f778b6e4bfaaf62d4384eaa2bcaf9b63
# good: [cdb4a05e60b2646d25f7227c7dfe5d54c3f3a173] Merge branch 'for-next' =
of git://github.com/openrisc/linux.git
git bisect good cdb4a05e60b2646d25f7227c7dfe5d54c3f3a173
# good: [00b7410736b1d46ab26c3b4e04eaa819e3f7448c] Merge branch 'vfs-6.16.m=
isc' into vfs.all
git bisect good 00b7410736b1d46ab26c3b4e04eaa819e3f7448c
# bad: [a9d6e19f91b6600c02276cd7903f747a5389950c] Merge branch 'for-next' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git
git bisect bad a9d6e19f91b6600c02276cd7903f747a5389950c
# bad: [03e1a90f178e3cea3e8864135046e31f4dbe5e2f] Merge branch 'vfs-6.16.mo=
unt' into vfs.all
git bisect bad 03e1a90f178e3cea3e8864135046e31f4dbe5e2f
# good: [a9d7de0f68b79e5e481967fc605698915a37ac13] Merge patch series "pidf=
s: ensure consistent ENOENT/ESRCH reporting"
git bisect good a9d7de0f68b79e5e481967fc605698915a37ac13
# bad: [675e87c588fc7d054c8f626fd59fcad6c534f4c0] selftests/mount_settattr:=
 add missing STATX_MNT_ID_UNIQUE define
git bisect bad 675e87c588fc7d054c8f626fd59fcad6c534f4c0
# bad: [449f3214ce15b697277d5991f096140cf773e849] selftests/mount_settattr:=
 don't define sys_open_tree() twice
git bisect bad 449f3214ce15b697277d5991f096140cf773e849
# bad: [a6c7a78f1b6b974a10fcf4646769ba8bf2596c58] fs/namespace: defer RCU s=
ync for MNT_DETACH umount
git bisect bad a6c7a78f1b6b974a10fcf4646769ba8bf2596c58
# first bad commit: [a6c7a78f1b6b974a10fcf4646769ba8bf2596c58] fs/namespace=
: defer RCU sync for MNT_DETACH umount

--QXNPbZDwSBbfcPw6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgAKyYACgkQJNaLcl1U
h9DaZgf/Z6f+BESM3p3WNzVxn3l8LfgDrlJ2lYZCogS9SBQJXCw0lq85tWApAUBl
N67Y3dM9TOPkAzvdiK34efXk6ddIxhjPO4Kpdxu0ZO8ZQ49HeWZ6bCnHKjhrcMXe
qXdPgmUQ8nQOZ3c2UJzYuuLYC/ZuTovXRrs9MftoD5i9LfyC3ARE/YQvtYyY5eQj
1NfplDjjj5gbxvCrR/b+Rk5oU1gexymRr29OhlOB+9WUTqsz+MYJYZHbKm/n9Ook
GgBxH8teiGQ5ez6/g98Q7ZFwQdNc/aQV4cwTKz3nebdN+dMAP+uuGNXB8KxaHrwk
glMfqw+1xwyV1P6GEPYAZTE867lH/g==
=pZyw
-----END PGP SIGNATURE-----

--QXNPbZDwSBbfcPw6--

