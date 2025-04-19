Return-Path: <linux-fsdevel+bounces-46726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF422A94541
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Apr 2025 21:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21C8A3BE6D5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Apr 2025 19:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4561E25F2;
	Sat, 19 Apr 2025 19:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShVq+JRF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220DE8F54;
	Sat, 19 Apr 2025 19:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745090761; cv=none; b=dqF0NB5ldD9GiVWFgTIvlE9tm1MKnufnTI+D5kcnMO8dbLiBqL09rW5Nwwgu59vBQ9WMxiRZW8+eSy4qeAtt2BYPaJaZk4e/uRbSpzMjorJRObj/UF6Bgv4kgst8h1kTpWF/L8nODpLakFS2CNKiERoDBR4xJk/3umDL3KO0a5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745090761; c=relaxed/simple;
	bh=tOhwqVfySjcWHIL3neB7Q+6oiJ+utj9Oxn8O8KYI0Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUGKFt2c8jt8f9IlkoTHry6/PMj3HtvMLzNi/7CPPOcrDe9Tkx2hPQ2yWoCcbRlqGdFByc1DsyrVQdlUBEo/sQfhfz+XtF2igr/6+RJkrrkQ91P2rALRCs8QQRfFGDGzht+dsTF2Qjhnq9c5dAUiBEhB5v8C4tl0K/3Ysievefo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShVq+JRF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F0E0C4CEE7;
	Sat, 19 Apr 2025 19:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745090760;
	bh=tOhwqVfySjcWHIL3neB7Q+6oiJ+utj9Oxn8O8KYI0Mg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ShVq+JRFEXyx1IZCDO3usclodqiMqiChOPFBW83LMMiPxmNQp+IoAVibL4ZBOSj7g
	 JRtB0Zw1l9h3CJLqH5nRrFGaiv5N2vv/jID1O1QokwnPfXKMH93KNgSsTFOVYrI+Uy
	 C7Mh1Z6hc6Y/mLAcwffWjUF43nwxyJmH4okPqpApLt+/sWEwGMfTLU6AY55MlAmSKp
	 uw8Lv3xVA//PVQXb21/wIQsBnEokpu5jt5KCRHOrPBmLMJKlR+QLCK0EUWLyFqvrNR
	 GQrmgaJpYBBeFgc1Zw078ZTS/cXm+fn9nEvpE2fBxqVGFdt1NGqYUwpjRhKA00Zvg8
	 lsar/JXJYU02Q==
Date: Sat, 19 Apr 2025 21:25:46 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, aarcange@redhat.com
Cc: linux-man@vger.kernel.org, akpm@linux-foundation.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org, lokeshgidra@google.com, 
	peterx@redhat.com, david@redhat.com, ryan.roberts@arm.com, hughd@google.com, 
	mhocko@suse.com, axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org, 
	Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com, bgeffon@google.com, 
	kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com
Subject: Re: [PATCH v6 2/5] userfaultfd: UFFDIO_MOVE uABI
Message-ID: <rns3bplwlxhdkueowpehtrej6avjbmh6mauwl33pfvr4qptmlg@swctg52xpyya>
References: <20231206103702.3873743-1-surenb@google.com>
 <20231206103702.3873743-3-surenb@google.com>
 <8bcb7e5f-3c05-4d92-98f7-b62afa17e2fb@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cps3uvezotjpoism"
Content-Disposition: inline
In-Reply-To: <8bcb7e5f-3c05-4d92-98f7-b62afa17e2fb@lucifer.local>


--cps3uvezotjpoism
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, aarcange@redhat.com
Cc: linux-man@vger.kernel.org, akpm@linux-foundation.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org, lokeshgidra@google.com, 
	peterx@redhat.com, david@redhat.com, ryan.roberts@arm.com, hughd@google.com, 
	mhocko@suse.com, axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org, 
	Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com, bgeffon@google.com, 
	kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com
Subject: Re: [PATCH v6 2/5] userfaultfd: UFFDIO_MOVE uABI
References: <20231206103702.3873743-1-surenb@google.com>
 <20231206103702.3873743-3-surenb@google.com>
 <8bcb7e5f-3c05-4d92-98f7-b62afa17e2fb@lucifer.local>
MIME-Version: 1.0
In-Reply-To: <8bcb7e5f-3c05-4d92-98f7-b62afa17e2fb@lucifer.local>

Hi Lorenzo, Suren, Andrea,

On Sat, Apr 19, 2025 at 07:57:36PM +0100, Lorenzo Stoakes wrote:
> +cc Alejandro

Thanks!

> On Wed, Dec 06, 2023 at 02:36:56AM -0800, Suren Baghdasaryan wrote:
> > From: Andrea Arcangeli <aarcange@redhat.com>
> >
> > Implement the uABI of UFFDIO_MOVE ioctl.

[...]

> >
> > [1] https://lore.kernel.org/all/1425575884-2574-1-git-send-email-aarcan=
ge@redhat.com/
> > [2] https://lore.kernel.org/linux-mm/CA+EESO4uO84SSnBhArH4HvLNhaUQ5nZKN=
KXqxRCyjniNVjp0Aw@mail.gmail.com/
> >
> > Update for the ioctl_userfaultfd(2)  manpage:
>=20
> Sorry to resurrect an old thread but... I don't think this update was ever
> propagated anywhere?
>=20
> If you did send separately to man-pages list or whatnot maybe worth nudgi=
ng
> again?
>=20
> I don't see anything at [0].
>=20
> [0]: https://man7.org/linux/man-pages/man2/ioctl_userfaultfd.2.html
>=20
> Thanks!
>=20
> >
> >    UFFDIO_MOVE
> >        (Since Linux xxx)  Move a continuous memory chunk into the

Nope, it seems this was never sent to linux-man@.
<https://lore.kernel.org/linux-man/?q=3DUFFDIO_MOVE>:

	[No results found]

Please re-send including linux-man@ in CC, as specified in
<https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/tree/CONTRIBUT=
ING>


Have a lovely night!
Alex

--=20
<https://www.alejandro-colomar.es/>

--cps3uvezotjpoism
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmgD+LIACgkQ64mZXMKQ
wqnKzw//TF2X0nYP43skdra2n4YASVKPsOpD7qLs3rwbT9acdN64Lvu8ecfTfGxr
H5F1Ju/JmRyXmC726dgzGO+1K6pHnz3ONQ+VKnj8nMYbyGN0rE3bd93i6Fxtfiyu
Vb04Al1xzJ6hF8YDLF5mQvawYJzHhkTxrlZ02r5Kqrmdp3qHUuFK/lrLX/asY0h8
4By12faaY59gYGuCajneNJC3ADCVzjtra76C5RbGxUK5qOgjEfxlz7jmrxyXpFkm
PeR0h2QbimLRtBAvzuYrE5n5+c/999r/GY7Xm+1fmDoV37e7Un3SZRxdfMMKwzvx
6iiTKfOjv2UmfVv7oQOknofyQNTDeckW/yHrgBS/TOvy8OF7qIkIcHI9A5Krpuz8
PaJco2eqRqlgoMp0rAacT1xGoj07bLMMWbqFi6dEBz6snpkM3Hi/O1W8mt1YNSLz
9IvMa2ipwCQa4Xddo2+E16qMDxG6QtWWz8eve8XgueL4U2ucAnrPOmdcMXX6TXFB
ZM1QlLo6Wk9N+X+ZmxjLWDRbQF3F8rks97pR8W9xZGwGTytpaUqa5qH560YCh0oy
wYKSSmMO2ZMYkpfMEZDihiOEvM+r6qOwzkwUouS56TSRIx7+B7HWyNI4PAo9y0DD
2pJ1F1Bl67dSTdieL7iwt0o0kT+YOXLpKhAtGTgpXbXuSCbuEFc=
=UOsZ
-----END PGP SIGNATURE-----

--cps3uvezotjpoism--

