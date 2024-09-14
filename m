Return-Path: <linux-fsdevel+bounces-29370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 432AA978CCA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2024 04:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B1291C254AD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2024 02:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1B3101E6;
	Sat, 14 Sep 2024 02:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="A5vmQRwF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5F21103;
	Sat, 14 Sep 2024 02:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726281191; cv=none; b=KPOUyZv7z1xk6SPvYGPFsfIY00tj0fQyOpGN3mIjGeC4wWZp60KBvNv4rhaU4XBJetgvqRhZAVyIDlMCbOSl/NG1HIpiG2NjK63gcpl1/Zu0B9953Ithpl5t7oZliHRFCcZJ0/Vz3RR4kbPqnPfMdHfTjD7oIXnwiP/U2HFYFZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726281191; c=relaxed/simple;
	bh=hJq/6PBF3sLbLnqKLZJjrgpBEM96uIsrLMnjX63Oq7A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HuX9gFIGC2P3enzy7ydzproBQD1llXSTZIxobKzPUTWeM6BCWdfX0I0q6eyusAxiwORJG5AD2MEBCGa8ZEXTuUxoafNDhfLsK49dxLxPYY79yRs4EgrmVqimWAVdBdn+Y6t4cCJDw3sljedxYNcgI6wn1ZdVl+wlDuSM/QUFp8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=A5vmQRwF; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1726281185;
	bh=IXODKEe3p+GPPq+OmwlVmOqxhuyvfZujvYHlJhtMSKg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A5vmQRwFtF0709SnQzA0l3k5YNzxl13DlLiN6kIkcTc2TH8T/qtBhUCDOxDOm7Udp
	 /tigOCaTMIC2GVOU58T6cHYfq2Kci0ogX+LkusXqruEHvl1H0t0Bjb/t3CWhoEn7JD
	 cf2Be3e1+53Mh3sqXmnJrcNEI3vm/YDXt4qg+lvbxWUH0/b+o6/IbX3pitAGCz7zN1
	 m26BAcInxZmiD46Ga1W40o3KpEK/35eD99lBQp/mp0XvJD65Z/bV0He+o1SnQCc2Me
	 VDwJgR3O/Tvf6M4tlpDoE9NYa3cKT20uCBiiyHTiMQBGtuHYq7UGMesEXGOIo8hI1G
	 8VftC3nuOMFnQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4X5Fb51nbdz4xD3;
	Sat, 14 Sep 2024 12:33:05 +1000 (AEST)
Date: Sat, 14 Sep 2024 12:33:04 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Al Viro  <viro@zeniv.linux.org.uk>
Subject: Re: [GIT PULL] vfs mount
Message-ID: <20240914123304.172831bd@canb.auug.org.au>
In-Reply-To: <20240913-vfs-mount-ff71ba96c312@brauner>
References: <20240913-vfs-mount-ff71ba96c312@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wSIiq+IvzhhMIXid3Y9yCpQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/wSIiq+IvzhhMIXid3Y9yCpQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Fri, 13 Sep 2024 16:41:58 +0200 Christian Brauner <brauner@kernel.org> w=
rote:
>
> (1) linux-next: build failure after merge of the bpf-next tree
>     https://lore.kernel.org/r/20240913133240.066ae790@canb.auug.org.au
>=20
>     The reported merge conflict isn't really with bpf-next but with the
>     series to convert to fd_file() accessors for the changed struct fd
>     representation.
>=20
>     The patch you need to fix this however is correct in that draft. But
>     honestly, it's pretty easy for you to figure out on your own anyway.

Except Al Viro told me an earlier time we had this conflict (the commit
the did the convert to fd_file() was removed form linux-next for a while)
that !fd_file(f) should (could)? be replaced by fd_empty(f) - but that
may be done later.

--=20
Cheers,
Stephen Rothwell

--Sig_/wSIiq+IvzhhMIXid3Y9yCpQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmbk9eAACgkQAVBC80lX
0Gwv/Af/Xe48GEh3qp6w9EqA83fo+8wnPvFcg3rpEpCiBe0/pj7/7Qig/YCnZ0vC
/Jt+8G9RUNhNIH0wrmMZG+GY5rIyhECAsew2+yTPLKnYeFvZbDo1edJHqXZZYXTH
9410/yMMZw9EVdRYqbSAgDDDAuS9V9CGuF+ARx39n9nCTNWsmIIxYDprezL8w0Pv
tAIAIlWNqgFKW1VGDbz3Gb0n7Otjy1YvEVAaKnjicLtKVHEFURlk/RtfS5vPWKxp
x++ju9Z8PcxWQ8raqFaWFpsYT/kVUZCM/10hXIMXJU+15XfcD1JgEfaUQnXk67ol
D5m1jsxJv+enWaiUNNRtASsVGszHLA==
=cEDV
-----END PGP SIGNATURE-----

--Sig_/wSIiq+IvzhhMIXid3Y9yCpQ--

