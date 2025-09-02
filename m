Return-Path: <linux-fsdevel+bounces-60034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3192B41099
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 01:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DD175E7770
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 23:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE8627875C;
	Tue,  2 Sep 2025 23:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="PLcdi6Xf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D623732F743;
	Tue,  2 Sep 2025 23:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756854584; cv=none; b=poedzsl1w5Jffxqr0xCPyli5bRM10Si8dKSPnA/qyB7jtehUIvpX+Rr9QlD1KTNsgceFTHTv/LB/IW7haEBzDuRiPa3DChBBHDuTxI0DfBemxaP2BtjeimBVwU0D6Q848hS0dLWVyXiuCwa57g8AavOC+VymZon1RVKXfKpUFmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756854584; c=relaxed/simple;
	bh=C3axpAdbhhgLqxaGF5ASkzZmnrWZlH5BBeSgMj2uuB8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g1QagyQHxMun7V2DUHn5t0Z+C90xaOLc5nGfCvwr1ypOsixu4ValR0NLkNYQTru67HUpXGVTCcHuneEvQEV+HOVtE0Id5igJ9Akpp27QXJX+FkXzmQkgiAxyw15H3iWRhe16+oYffyrX1wqFS/tCf03Z0/tFDa67Dp1JSKbpaYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=PLcdi6Xf; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1756854576;
	bh=lmd19YEM6DwJTRO3boTZW63QHXm1N7rR6wiqw+ejDUQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PLcdi6XfnW7YUKeGYPwl38hmYQAlCEWbwD3AW+D2Ojsfajd84Mu7yu3styXm/xE3e
	 o+9OWx1HbhCnFuCd7GA+SqCJSPTNRd9ISdgrl7mfa9T4jpPDilAmsGl3JlIZKKBfJm
	 Wnkr4ElhuP4cxcKrcCwoT+L61dJJw7UryTZXyfib6mc4NraQMXmHN6VJkYIDebHNZU
	 0AHgChNxAilkoUWMElFJPBY8kuLqxghLLT4ujw4k/dQd7pzBt18ooezsdiBc7m/58Z
	 KE2aahQIM/JbInVC2FRcaF2tPSeqWetl3m0vaJybwvhrnnWFhijoj2Kg+pqJetJMb1
	 /zczHoHTqJ3PA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4cGhJv4fYdz4w9S;
	Wed,  3 Sep 2025 09:09:35 +1000 (AEST)
Date: Wed, 3 Sep 2025 09:09:34 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Aleksandr Nogikh <nogikh@google.com>, david@redhat.com,
 joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, m.szyprowski@samsung.com,
 mszeredi@redhat.com, willy@infradead.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] mm: fix lockdep issues in writeback handling
Message-ID: <20250903090934.4b5479d8@canb.auug.org.au>
In-Reply-To: <20250902154043.7214448ff3a9cb68c8d231d5@linux-foundation.org>
References: <345d49d2-5b6b-4307-824b-5167db737ad2@redhat.com>
	<20250902095250.1319807-1-nogikh@google.com>
	<20250902154043.7214448ff3a9cb68c8d231d5@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/51YENCBeuS5sHhgM6ma6l5W";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/51YENCBeuS5sHhgM6ma6l5W
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Tue, 2 Sep 2025 15:40:43 -0700 Andrew Morton <akpm@linux-foundation.org>=
 wrote:
>
> Perhaps Stephen can directly add it to linux-next for a while?

I will add it to linux-next from today (until Miklos sorts it out).
Note that the fuse tree was updated since yesterday's linux-next, but
this patch is still not included.

> From: Marek Szyprowski <m.szyprowski@samsung.com>
> To: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.=
kernel.org
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>, "Matthew Wilcox (Oracle)=
" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, David H=
ildenbrand <david@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>, Joanne=
 Koong <joannelkoong@gmail.com>
> Subject: [PATCH] mm: fix lockdep issues in writeback handling
> Date: Tue, 26 Aug 2025 15:09:48 +0200
> Sender: owner-linux-mm@kvack.org
> X-Mailer: git-send-email 2.34.1
>=20
> Commit 167f21a81a9c ("mm: remove BDI_CAP_WRITEBACK_ACCT") removed
> BDI_CAP_WRITEBACK_ACCT flag and refactored code that depend on it.
> Unfortunately it also moved some variable intialization out of guarded
> scope in writeback handling, what triggers a true lockdep warning. Fix
> this by moving initialization to the proper place.
>=20
> Fixes: 167f21a81a9c ("mm: remove BDI_CAP_WRITEBACK_ACCT")

This is now commit

  2841808f35ee ("mm: remove BDI_CAP_WRITEBACK_ACCT")

in the fuse tree.

> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

--=20
Cheers,
Stephen Rothwell

--Sig_/51YENCBeuS5sHhgM6ma6l5W
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmi3eS4ACgkQAVBC80lX
0Gybxwf/Uv3fpc9804shY5OAElYnQfg2+iEGw0IZHoAf6i8/EloaC7OQL/sm06/o
eSck0xYXKM5k6aPUaKC7v6Y990fW/b9GKyQVO3+KVWPEH393Q5PoU01Lazp6LgvE
4eaLnLYlFhlZwLgHtFcVWHEq8BeYjXl/wE/g9UDxOuyZ6M0UXF75o1Rnofib25tF
38AwQf1Vxzptzts2zFyVoFbqL+/PioS0C1OBlcM77DUOKvFCOKD9dFuqNkCm5tF4
Cf5RaO2UcQVFo1KHClvNNzw2dHP2fy81TsDuhG0vHnoEDO+S4bH+oaGjwIyKQsj5
uP8Ajs97yivTnWBOKh5JeZx3JerJ2Q==
=i4KV
-----END PGP SIGNATURE-----

--Sig_/51YENCBeuS5sHhgM6ma6l5W--

