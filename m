Return-Path: <linux-fsdevel+bounces-23656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C9F930F39
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 09:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84E801C21246
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 07:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1F9184107;
	Mon, 15 Jul 2024 07:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="AA4ziZT+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4382D6BFD2;
	Mon, 15 Jul 2024 07:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721030374; cv=none; b=GBIRraH7JEvQSFnZCKecCxRkeo8/JD2LseW7St0oEmpiSMwPo4e2k02M4bvGv7tfCTzsWSwtsAp9Nwx54yBFIdIrwYhRYY6P0jDvd67hP5eEW4PQkEK88Puq7qtyBcJaoF6Sty1yYJ6DmY1Z6Jo/iWYWrNUde8ggAophjHzmO8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721030374; c=relaxed/simple;
	bh=datvoZZvIixbD0/XQQUke0X297LhSV7ToXIMDsAaAcc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WMKYmOwBlSaFjjkR0qGYePct1zX2qKiiAXgnRGaBzj9Dg8/W5rzapNJseJfqSxsHM8GJ0VobQWu1q1LnOAVelEHtoq11ZON+edHIHUk4ZDN428hatoZnrR3w/i89mdppl+3k0lrUtUqoup/ES2meK7jkk2YiMO3AK1K9mpyvI5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=AA4ziZT+; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1721030367;
	bh=ohPE7nPRrmUUOf0bN6ejQ6W3V7rt7YS4lDz93qfBr5k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AA4ziZT+VfvaLwNXERke8hG5rIEXfGJxb+z+opGIDzbSXhHDmB7obF+crHK4LnKie
	 /2G23U3nk8NQF0OXPatZtPEjq9npsSiQShhfUPOZYUzev2E0Vr5y0osrwj5kpp+Cny
	 f965tkQ2ZgF8Xj6r879UvaPj8z8BjEYxtVnZ2i9hguRJ2SYe4qlVqKO+MCQIeeIjoa
	 B4faRJ8+/DPRPBipktyxK6b0WTvF7sM8uYxUv8mVCSigFSH9Kdv0FPJRqyODJ/fxTz
	 d+KFI/z6yudOCRfr2cbDZGG5+KFwjIISrEf6MGih9aQGvJNgx24ZpGmX5c7NSIqAXm
	 3CgHCtleG7Fog==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WMvjq43rgz4w2Q;
	Mon, 15 Jul 2024 17:59:27 +1000 (AEST)
Date: Mon, 15 Jul 2024 17:59:26 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs changes for 6.11
Message-ID: <20240715175926.70d0fa38@canb.auug.org.au>
In-Reply-To: <r75jqqdjp24gikil2l26wwtxdxvqxpgfaixb2rqmuyzxnbhseq@6k34emck64hv>
References: <r75jqqdjp24gikil2l26wwtxdxvqxpgfaixb2rqmuyzxnbhseq@6k34emck64hv>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/AI5INI9cPSBr9vNTqIP.IE5";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/AI5INI9cPSBr9vNTqIP.IE5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Kent,

On Sun, 14 Jul 2024 21:26:30 -0400 Kent Overstreet <kent.overstreet@linux.d=
ev> wrote:
>
> Hi Linus - another opossum for the posse:
>=20
> The following changes since commit 0c3836482481200ead7b416ca80c68a29cfdaa=
bd:
>=20
>   Linux 6.10 (2024-07-14 15:43:32 -0700)
>=20
> are available in the Git repository at:
>=20
>   https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-07-14
>=20
> for you to fetch changes up to efb2018e4d238cc205690ac62c0917d60d291e66:
>=20
>   bcachefs: Kill bch2_assert_btree_nodes_not_locked() (2024-07-14 19:59:1=
2 -0400)

We normally expect branches to not be rebased just before being sent to
Linus for merging.

See: Documentation/maintainer/rebasing-and-merging.rst
--=20
Cheers,
Stephen Rothwell

--Sig_/AI5INI9cPSBr9vNTqIP.IE5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmaU1t4ACgkQAVBC80lX
0Gz6xAf+NUXquXRCckrz1A28TRE48GZJQPISQpzPBv8jqECWGk06HYRoNmRcB41S
QocK7ExP3xuVx/0srJFOvo1+zDyqUtK+CwOb7FFQTlpY/n0UL+tWROUm0+BJK9hu
w43Y4k6iZwHAmd9F89j+pgThL5ktbA6wUbCRZk6eF3QZcumLiXjgYiy+q1CPO5xV
+mL0UPvjILWXgJY+kl9qgtb48LAA37JiVu5I0ZDu9aVsJ82o3H8rz9sKw2O3gCoT
veqZjaYcFYOGehDvjSWUAB9+LH5ci+YEptpbUuPPYS0DS3BTBqt0c2HToFh5f/z+
12AvulOW7ELND+MqOKKP7DZE74mmDg==
=whAD
-----END PGP SIGNATURE-----

--Sig_/AI5INI9cPSBr9vNTqIP.IE5--

