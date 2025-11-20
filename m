Return-Path: <linux-fsdevel+bounces-69174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF29C71CF1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 03:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2EAD9345EB2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 02:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7758829E114;
	Thu, 20 Nov 2025 02:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="OipdMMfk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1AC1A285;
	Thu, 20 Nov 2025 02:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763605143; cv=none; b=eU4n3q7xG87xYYuKclFeVoE34BuwqbCXpOQDlRZYcZGz5kslPQnNccqALqeUkHGcA88SiLSKs1dhrN1T59QOJLeQR00XLJph7oVSqv0eSDMvUuDMUboiiFXNTz4qoBt21UGpqVLMPyNWeImoMsPOVcFUHHUactMPT2GtixE6Y9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763605143; c=relaxed/simple;
	bh=gBsZ0u4g/ohzYsDkvSDKJilFKka/uOlyKz55elNqRjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/qTeCUcAdNtaXMkIOsXhp5YuO6n9fbfuTvTidoP5QMSlEW29XOAidfbP7jXCjOGLgVsUO27FhalNzBQXpHLg9iMmT/++juJn5920Zyo5K8XUK+B/hNCAgHKTNBPa2tdqUrrQK/t06/D/qmcHqTnNt5nhWOkzMXNwptHUgrbwPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=OipdMMfk; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dBhqH083nz9tCL;
	Thu, 20 Nov 2025 03:18:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1763605131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0whPfThUa/Ub187hjOoajUyMP9lcTrlqKje8b8QsuQs=;
	b=OipdMMfke1JRkD61WAIBiKHCl+avrjbZCYpoPjvd+qdH8lgsxEDbnad4qQjHUsLdu2Rr/H
	3EA0G8pv0k9xl8RR7II09/VT5JxJuLRF5+J0kxLPu3k4IauWR0eF54IWTMIsUhA//V9kU+
	nOQhgLvXeNY0EbGN4Ka1REtqpewGki/7i0NwD9WIRKNiTBgid44TKSyPDdy5kBzzOyyk5s
	TX5O8WClLHc34cAoKv95iOWIw/xCnlqpJbNjZ8ecNZ/Zu+jzrGXcXx3M7mXlDjGGA/SmdI
	6ZE7bYS4C+Cak5DmX45YGSMvMpKtBkUwfZ6+s/19vUUlAowp9afXrGdt8WcDGQ==
Date: Thu, 20 Nov 2025 13:18:34 +1100
From: Aleksa Sarai <cyphar@cyphar.com>
To: Alyssa Ross <hi@alyssa.is>
Cc: linux-fsdevel@vger.kernel.org, 
	Demi Marie Obenour <demiobenour@gmail.com>, Jann Horn <jannh@google.com>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, jlayton@kernel.org, Bruce Fields <bfields@fieldses.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, shuah@kernel.org, 
	David Howells <dhowells@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Tycho Andersen <tycho@tycho.pizza>, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org
Subject: Re: Safety of resolving untrusted paths with detached mount dirfd
Message-ID: <2025-11-20-limber-salted-luncheon-scads-7AT044@cyphar.com>
References: <87cy5eqgn8.fsf@alyssa.is>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zpbuj6rjk7dcacxc"
Content-Disposition: inline
In-Reply-To: <87cy5eqgn8.fsf@alyssa.is>


--zpbuj6rjk7dcacxc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Safety of resolving untrusted paths with detached mount dirfd
MIME-Version: 1.0

On 2025-11-19, Alyssa Ross <hi@alyssa.is> wrote:
> Hello,
>=20
> As we know, it's not safe to use chroot() for resolving untrusted paths
> within some root, as a subdirectory could be moved outside of the
> process root while walking the path[1].  On the other hand,
> LOOKUP_BENEATH is supposed to be robust against this, and going by [2],
> it sounds like resolving with the mount namespace root as dirfd should
> also be.
>=20
> My question is: would resolving an untrusted path against a detached
> mount root dirfd opened with OPEN_TREE_CLONE (not necessarily a
> filesystem root) also be expected to be robust against traversal issues?
> i.e. can I rely on an untrusted path never resolving to a path that
> isn't under the mount root?

No, if you hit an absolute symlink or use an absolute path it will
resolve to your current->fs->root (mount namespace root or chroot).
However, OPEN_TREE_CLONE will stop ".." from naively stepping out of the
detached bind-mount. If you are dealing with procfs then magic-links can
also jump out.

You can always use RESOLVE_BENEATH or RESOLVE_IN_ROOT in combination
with OPEN_TREE_CLONE.

--=20
Aleksa Sarai
https://www.cyphar.com/

--zpbuj6rjk7dcacxc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaR56ehsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG9PsAD+PRkbsNED4VDGpQv1RzBJ
tRTPbZXq0e1cR3TVXbbmoGUA/3y03WLfy00sJzXMWRQCJILmhsRdHZ9CN3KWfSw6
8RsM
=I+MW
-----END PGP SIGNATURE-----

--zpbuj6rjk7dcacxc--

