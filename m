Return-Path: <linux-fsdevel+bounces-73476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D30DD1A7AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 18:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABDCD3046436
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 16:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C03934EF09;
	Tue, 13 Jan 2026 16:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sv3mUq8d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92203346AD6;
	Tue, 13 Jan 2026 16:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768323421; cv=none; b=NgXXq6ABuf6ccnZrhPPmT2qTJ1lw+H2crqJofvdyJEt2QEv9XiIJes5i+LIgAVy4xjbyHW9cbPIfTZ9veY6HvesZxOVNZIw46ckO2aZNNYyTJ8yeFfp6oeb7zF0B4Grg0+MaFBJvyjkWYdWtzkpAOg1XKgoUeybwtjf08ghAfuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768323421; c=relaxed/simple;
	bh=Yl0lMpNMVQ/naErct5zxjs7FtqTJZfyUzVDb81q07Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uv0bw/8oL2aFAlPXqTOwD23fU51i2urw9NENPn1OnBBPY8QzNQPzMUdEujfCOBxGMeIR4jUDzPERnVOpqdvXAhxtsLciw8JbZKE9bTP/824EduQ9C64V8PgwrlfBG+2K12XhKvUleQpAUNn/hX9lz8M7nLCLxpw0yp6IfGGzWC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sv3mUq8d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14341C116C6;
	Tue, 13 Jan 2026 16:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768323421;
	bh=Yl0lMpNMVQ/naErct5zxjs7FtqTJZfyUzVDb81q07Mo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sv3mUq8dQz7F/PY89TtNV9yNAowCM5dKV0dwRPMV8CJwOlUq7/hn6zfsLHc7FY+NW
	 WIzURftHjIL9d7TEQsOOngFezDFkR44AEclc9iJM4WAGC8piBbjkl6Q5ETZlHj1qqX
	 nX4GjGSkYC7nl4BsHKPbx2EnFQskaVm3q4VB0tdxpMJ2naqU45qRUlkvEU5TUCVRQN
	 GgMrh4JTE/vAsiWSezGjtsmcT0IgooOPhjhiUzrRENLZhjiUPDv92Kp66iQI6RX39h
	 c+XWMYttQeXAb+BaT6QQlZ7wmOkjHFt5micjazQZ6XUIiIVxYa77kT0OaJ5S5gHdEF
	 PTMVu2A59YeBw==
Date: Tue, 13 Jan 2026 16:56:56 +0000
From: Mark Brown <broonie@kernel.org>
To: david.laight.linux@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 30/44] fs: use min() or umin() instead of min_t()
Message-ID: <62097ec5-510e-4343-b111-3afee2c7b01e@sirena.org.uk>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
 <20251119224140.8616-31-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fwrXW7fUl9Ff/6Yg"
Content-Disposition: inline
In-Reply-To: <20251119224140.8616-31-david.laight.linux@gmail.com>
X-Cookie: As seen on TV.


--fwrXW7fUl9Ff/6Yg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 10:41:26PM +0000, david.laight.linux@gmail.com wrot=
e:
> From: David Laight <david.laight.linux@gmail.com>
>=20
> min_t(unsigned int, a, b) casts an 'unsigned long' to 'unsigned int'.
> Use min(a, b) instead as it promotes any 'unsigned int' to 'unsigned long'
> and so cannot discard significant bits.

This breaks an arm imx_v6_v7_defconfig build:

In file included from <command-line>:
In function 'fuse_wr_pages',
    inlined from 'fuse_perform_write' at /home/broonie/git/bisect/fs/fuse/f=
ile.c:1347:27:
/home/broonie/git/bisect/include/linux/compiler_types.h:630:45: error: call=
 to '__compiletime_assert_434' declared with attribute error: min(((pos + l=
en - 1) >> 12) - (pos >> 12) + 1, max_pages) signedness error
  630 |         _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
      |                                             ^
/home/broonie/git/bisect/include/linux/compiler_types.h:611:25: note: in de=
finition of macro '__compiletime_assert'
  611 |                         prefix ## suffix();                        =
     \
      |                         ^~~~~~
/home/broonie/git/bisect/include/linux/compiler_types.h:630:9: note: in exp=
ansion of macro '_compiletime_assert'
  630 |         _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
/home/broonie/git/bisect/include/linux/build_bug.h:39:37: note: in expansio=
n of macro 'compiletime_assert'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
/home/broonie/git/bisect/include/linux/minmax.h:93:9: note: in expansion of=
 macro 'BUILD_BUG_ON_MSG'
   93 |         BUILD_BUG_ON_MSG(!__types_ok(ux, uy),           \
      |         ^~~~~~~~~~~~~~~~
/home/broonie/git/bisect/include/linux/minmax.h:98:9: note: in expansion of=
 macro '__careful_cmp_once'
   98 |         __careful_cmp_once(op, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y=
_))
      |         ^~~~~~~~~~~~~~~~~~
/home/broonie/git/bisect/include/linux/minmax.h:105:25: note: in expansion =
of macro '__careful_cmp'
  105 | #define min(x, y)       __careful_cmp(min, x, y)
      |                         ^~~~~~~~~~~~~
/home/broonie/git/bisect/fs/fuse/file.c:1326:16: note: in expansion of macr=
o 'min'
 1326 |         return min(((pos + len - 1) >> PAGE_SHIFT) - (pos >> PAGE_S=
HIFT) + 1,
      |                ^~~

--fwrXW7fUl9Ff/6Yg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlmeVcACgkQJNaLcl1U
h9BxQAf9HGqurLEC/bAa5+GdCUPrgVdNex+JnRAXx13wodsJ//7gbnkF7ruYTjXG
uHxd08MpP9HpJI5fAUXFGOnVc3ikYOj/ClD+HbJPrDeCIUTdVFddGzresI6lJilL
hYLOAIKo07m87eTkKRA7HNg3XVTi007RZJFitH6OBtsXnZ159j4NkDdrOIpl9CFp
kc6sOejpQVd6rktrhECe0R+PxjpYQIY2EBTe/MeE3ajRyyUK9ULoB476IxYgqGg9
KxXIZD25WeoDpdOFqwy4UD/8b72twg5OQ6QvzBNrUHFU2bhC9qr5r2OpjodbeGI1
NKW0tC0CEzSMpSsUNGuea3HdJ4HcAQ==
=6EHM
-----END PGP SIGNATURE-----

--fwrXW7fUl9Ff/6Yg--

