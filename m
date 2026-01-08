Return-Path: <linux-fsdevel+bounces-72820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6238CD044E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 17:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4787E305F642
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 15:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF173D332A;
	Thu,  8 Jan 2026 11:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0LcxD2F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8DD3AEF2F;
	Thu,  8 Jan 2026 11:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767871916; cv=none; b=og0xxcStPUwN5I5vJu1/Mpf0zYPBl3OKeV/TEqFcyHhkkoSmzLtBUq4ydnRGDfzigd10bAX4vL7E97zuEjPHnlLNLRWL2pcjepEPXRJkjAFjBUFq5THBOWRXgLHgfXrGfP4A4Q8WKbDdhYWk5bqYE02uzwMT3MEjs/9rDSjLjNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767871916; c=relaxed/simple;
	bh=GrXNFXLMVkEvuyjBXRmf3vAuCoPHKHapcE99UYwQNC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQoOFWqMSR7ALsrkwizeu1URRQuIbeF5idP0poQSYu72JrLNvnd7wXjOUAgpl+q2UhWD3o4h/3xuYwVTJP+PI8Rttxdtwa/3Cp2tj4YEfYinH5J3MpqR/DmtpMjX+AW3IpnVc8yyhG2Uh4LbQvNkkCecjCehbg8y2vFCapRAUag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0LcxD2F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE633C116C6;
	Thu,  8 Jan 2026 11:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767871915;
	bh=GrXNFXLMVkEvuyjBXRmf3vAuCoPHKHapcE99UYwQNC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E0LcxD2FmBfBt5A2gB+q1KZ449IeQzU4gEsfHILvYt6lX/bEUz2tBjHnBQDV2ZScT
	 4EsUEFCiSej8EgqA98dJL2GvmzZpfjA+gGQpMlsQZukLRCNhs+mVsEksIOfONUYVF0
	 9XUOraxxDDNhYUEsv+EM2Qw0JJYe3ziQBRAIcHpRy8TRP1B9qX0jIi/TjLz44IRgoc
	 Quv+bL5uhS4bMGpLHafEC4k5om3sMmc9NYGOGmLiGhHWfeXC8wnyVsZFKiTNNcLKcL
	 YReXCQx+YCkeLN4VtxyoSK7xHbfnqj2SdM19DhhSfazXPd4YJ+YjzFLttqDgj7Wy5H
	 faomWJ+DHzrbQ==
Date: Thu, 8 Jan 2026 11:31:46 +0000
From: Mark Brown <broonie@kernel.org>
To: Andrei Vagin <avagin@google.com>
Cc: Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	criu@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
	Chen Ridong <chenridong@huawei.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Koutny <mkoutny@suse.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH 1/3] binfmt_elf_fdpic: fix AUXV size calculation for
 ELF_HWCAP3 and ELF_HWCAP4
Message-ID: <79af0c28-9423-40ac-840f-ccf0ca676bf1@sirena.org.uk>
References: <20260108050748.520792-1-avagin@google.com>
 <20260108050748.520792-2-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YYxvTW0iZ6aVz70k"
Content-Disposition: inline
In-Reply-To: <20260108050748.520792-2-avagin@google.com>
X-Cookie: If you suspect a man, don't employ him.


--YYxvTW0iZ6aVz70k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 08, 2026 at 05:07:46AM +0000, Andrei Vagin wrote:
> Commit 4e6e8c2b757f ("binfmt_elf: Wire up AT_HWCAP3 at AT_HWCAP4") added
> support for AT_HWCAP3 and AT_HWCAP4, but it missed updating the AUX
> vector size calculation in create_elf_fdpic_tables() and
> AT_VECTOR_SIZE_BASE in include/linux/auxvec.h.
>=20
> Similar to the fix for ELF_HWCAP2 in commit c6a09e342f8e
> ("binfmt_elf_fdpic: fix AUXV size calculation when ELF_HWCAP2 is defined"=
),
> this omission leads to a mismatch between the reserved space and the
> actual number of AUX entries, eventually triggering a kernel BUG_ON(csp !=
=3D sp).

Sorry, missed fdpic here:

Reviewed-by: Mark Brown <broonie@kernel.org>

--YYxvTW0iZ6aVz70k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlflaIACgkQJNaLcl1U
h9BNQQf/SWKoyWBsmRtRijLDQFwuIjFlknk89+D+ZwI7hTFR2GRem2nPrMjLveB2
SP+8ABx9/CPZxt3iYxRGP6ljFYeT6e6sHGPloqEG/nSyp9sAgSc5a3jM8CtjhbQB
5658MuH0gZgd7Sckj8WduZPof98zKrMkGftfJ2Q7uT/jhM7ZHIy8q+1GodpMLZ98
jMT6IkBHsjrfNgJr3KHrTxNa2os+W+371N9L5RlTanphMm4sQOdCJvAqyLVlvpjW
IGrFyVgOcjwFqsBjXYs874Zo2+82EKN7QER2auVrJx5oIUn+uxf/KmBxkLN6DrcY
aF+eT03o52RmgcRqCa6h1rIN1bDr6Q==
=96VI
-----END PGP SIGNATURE-----

--YYxvTW0iZ6aVz70k--

