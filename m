Return-Path: <linux-fsdevel+bounces-14146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8308785CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 17:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55DC22814F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 16:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4524878F;
	Mon, 11 Mar 2024 16:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxOaFCqG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DA9481C0;
	Mon, 11 Mar 2024 16:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710176107; cv=none; b=KjZ9MnKV/IxWIXUdxQKDRmAsVDevZAR4QaBVI9NSMu9XwuN8Z/q+y1NA/pUS9SVJK/NT2TaaRBboEz8HgeQzItT2UlIbYPmsefKKpGcgkS6TKj1IE8y3OXOHXghFpnMLJFzTtmR2HV4SWieLkj25fbSxWWdRi22r47yM749cU2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710176107; c=relaxed/simple;
	bh=EmSwqbbiz2NGUzCup8uGw5T3VANghTq+mvsHdLzLqD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCYylDAJQvnDwUwlhDyp2g3wnd+3ogmESi/g/sCdgxJbWLnA++u1bmZEmzT80nyUq+1/bXiTNNaV4n6Ax8gfU7s67OgFC4aqWbuQ32r5DEJp63mqTlV234Kf4Cgmv/4oavW/fEYe/L4VnHXzR+V1gJBZcY/pQL3s5/mz0ww1vN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxOaFCqG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51751C433C7;
	Mon, 11 Mar 2024 16:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710176107;
	bh=EmSwqbbiz2NGUzCup8uGw5T3VANghTq+mvsHdLzLqD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rxOaFCqGUJGZ5vchsJvIIjSm0nQOrOKNgVBD8aQou5cwQKdj9JPd5bKaQIhmYrlxG
	 l5N7ViI4X5elLDH32nMLuEYiuHR7FV1hEIH5FQZe/XzrSUjdyM19WMM9T0ISDd7Om2
	 5XN7UbtL6nn8QzpRAgguL9Ivr2IG2l0kB/teP7kCLeMIuQVVI3IlyRJigosuimIkWr
	 xjvs0yW1QyA6EcdRsY2otGZ+5yw6NifmBv4PO4zr514+9iZ1oetKqY4jnIkHIg8mYR
	 Zg2qL29Q8W5UM3yRrvxmcVE59L0Wi838EZUI4/bgvHl6gGAbr/db92JFaoZhshze2c
	 hCCLeuccOEmxA==
Date: Mon, 11 Mar 2024 17:55:01 +0100
From: Alejandro Colomar <alx@kernel.org>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Jorge Lucangeli Obes <jorgelo@chromium.org>,
	Allen Webb <allenwebb@google.com>,
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, linux-api@vger.kernel.org
Subject: Re: [PATCH v10 2/9] landlock: Add IOCTL access right for character
 and block devices
Message-ID: <Ze83ZS6TaHQx5g8A@debian>
References: <20240309075320.160128-1-gnoack@google.com>
 <20240309075320.160128-3-gnoack@google.com>
 <20240311.If7ieshaegu2@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+cM1Ud5rDWldnSWU"
Content-Disposition: inline
In-Reply-To: <20240311.If7ieshaegu2@digikod.net>


--+cM1Ud5rDWldnSWU
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 Mar 2024 17:55:01 +0100
From: Alejandro Colomar <alx@kernel.org>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Jorge Lucangeli Obes <jorgelo@chromium.org>,
	Allen Webb <allenwebb@google.com>,
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, linux-api@vger.kernel.org
Subject: Re: [PATCH v10 2/9] landlock: Add IOCTL access right for character
 and block devices

On Mon, Mar 11, 2024 at 03:46:36PM +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> Adding Alex, Jon and the API ML for interface-related question: file
> type check or not?

Hi Micka=C3=ABl!

I'm sorry, I don't know.  :)

Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es/>
Looking for a remote C programming job at the moment.

--+cM1Ud5rDWldnSWU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmXvN2UACgkQnowa+77/
2zJudBAAn59RSuL91IBBzfzKiGg0hR74wX4lYRbOzus/3NtLZiXtBZkvZA9D40/3
nXDSlkxsjPpIdp/0F/SKOu7Vhpc18SMTpa9zeYBKf2SdUGxu5OKtKY1SobXoapE+
YbVcpyjDpOUIkJf/DSdNliSSPQWh4cl7V18tTOcTSmikvn5dmWpt1Dh2lG7xT0QF
KpwqaGDIAGIZ1AyZc4FyVfO1gVHrE3+4zeRjjzSj3OV/SeVPBEOTnHSDg/KMVm83
v/MucYfMCp4LxKVSAvRGJACSP4A4IaxVvXief2gpe7qKyOoEyHVdE0JBy+nqBJDB
PJy5tFCfF8ge63/4xVk58R77BhEmyESWsg3lAUU+GpMAS5kniI0nY2Qb5H0/Wcy8
hIIN/2HYqItugaI3PBVHCNbImRrr7iDinBV8MZ/NDfjY5IGjXPOTxqzL4wGkaDBA
STUZWAnrl+fkspnfpiinj5OB07AQ2gbgMqhbvfd/bFdIP0doGyQN+HzF4qpkmIP0
lTZlpT4LKl/9cQ2wegHR6rkC3hKPlq1sqEjO07ZkM+J6enVPvRZPJytH34D47GNi
qQQlQI0zja9bO3C30D6b9JNWAh4dPJxAh7QVhnf3bkPt6/TOXCNGGlMNvl/rm71W
EpWqhE5EcbMNH0Xo7we6Um2TcnHUAUcuZzyRXoi8Kw1h8tbTOLk=
=7MXN
-----END PGP SIGNATURE-----

--+cM1Ud5rDWldnSWU--

