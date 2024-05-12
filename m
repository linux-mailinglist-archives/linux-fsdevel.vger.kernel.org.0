Return-Path: <linux-fsdevel+bounces-19353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC2F8C3834
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2024 21:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B9F2280F7F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2024 19:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643A454BF4;
	Sun, 12 May 2024 19:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="q5FxJCVv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D4951C34;
	Sun, 12 May 2024 19:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715542372; cv=none; b=BNe+Gd3EgtjPS7Uf11t5SIQJuIu6rr+tisfAO6BZ+NWThSytq9DKkXE2j9Q0OwkO4ewVkPn7mrtKiwX1mMCyV+xv5vZCUY+wDGnLvJBYObB2P1NFXgpNw+vcBwYdY5VHf4ey/ilug8C0zX9dpwE0I5usOPGHr9CqNy3LjXZcNOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715542372; c=relaxed/simple;
	bh=PvyFmIqnit3tB539Co+7wuRW+IE95f4txoHSn3Qz5ZQ=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=mJ9RXPf0VFN7hyd/1HNB9vyS+02RNLBajCayoWGOEsr9dXYTTR4w6ViKPraRteE5X1pOCvA9Wf0GXIF8D6SqkdNeVZ+Tx6y7X30WYz155d/RF1VmPKjZgFxuFu2Yefth+ef+WZ5LG9GOWgmaiwOAP7c3MQ9N7wstaBqoDArFvEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=q5FxJCVv; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240512193247euoutp028395386268472af00b4482601e7ec58b~O1LGim-aF2248722487euoutp024;
	Sun, 12 May 2024 19:32:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240512193247euoutp028395386268472af00b4482601e7ec58b~O1LGim-aF2248722487euoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1715542367;
	bh=PvyFmIqnit3tB539Co+7wuRW+IE95f4txoHSn3Qz5ZQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=q5FxJCVvcRlNbw8l3QKxhirjflXeDHMDCLFZkJiHoP1UZ5QtgKAcSiT7RyfJmt7EW
	 hSZzRaEHz1EygrUV6UWkYAiVy2uPwuauv5W50NHVePQz3uhniwnjBm5u0Enkmqhp4d
	 eAwf+lnGiqc3kjYLFPQ5d+GKvizvaPpKzOgK29BY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240512193246eucas1p1b803e1e209b64539505f5fda1778b4dc~O1LFSONbZ3234432344eucas1p1m;
	Sun, 12 May 2024 19:32:46 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 5A.97.09624.D5911466; Sun, 12
	May 2024 20:32:45 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240512193245eucas1p103d1891d851a519d0ab83e586ccd2cad~O1LErWG9j3233532335eucas1p1u;
	Sun, 12 May 2024 19:32:45 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240512193245eusmtrp2908ef0acafe2b5b7a8df17de78204001~O1LEqceM60125201252eusmtrp2d;
	Sun, 12 May 2024 19:32:45 +0000 (GMT)
X-AuditID: cbfec7f2-bfbff70000002598-7b-6641195dba44
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 08.B2.08810.D5911466; Sun, 12
	May 2024 20:32:45 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240512193245eusmtip2a45a6ffabbaf52a5c4686fc913dd8737~O1LEbwfVT0200202002eusmtip2K;
	Sun, 12 May 2024 19:32:45 +0000 (GMT)
Received: from localhost (106.210.248.15) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Sun, 12 May 2024 20:32:44 +0100
Date: Sun, 12 May 2024 21:32:40 +0200
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: Kees Cook <keescook@chromium.org>, Jakub Kicinski <kuba@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>, Eric Dumazet <edumazet@google.com>,
	Dave Chinner <david@fromorbit.com>, <linux-fsdevel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-mm@kvack.org>,
	<linux-security-module@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-xfs@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<netfilter-devel@vger.kernel.org>, <coreteam@netfilter.org>,
	<kexec@lists.infradead.org>, <linux-hardening@vger.kernel.org>,
	<bridge@lists.linux.dev>, <lvs-devel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <rds-devel@oss.oracle.com>,
	<linux-sctp@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
	<apparmor@lists.ubuntu.com>
Subject: Re: [PATCH v3 00/11] sysctl: treewide: constify ctl_table argument
 of sysctl handlers
Message-ID: <20240512193240.kholmilosdqjb52p@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="qt3jjettk7ey6stj"
Content-Disposition: inline
In-Reply-To: <8d1daa64-3746-46a3-b696-127a70cdf7e7@t-8ch.de>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WSfUybVRTGvX2/CqbLS4Fx6XQ6JmziQElMvApqSUbyLotfmS7RZJEK7xgZ
	LbUdG3NMQHCr42MNHw5QoQxWEGbBUirgCJNgKS2TKqRDxIJIt8k6Bq3brECR8jJd4n+/8zzn
	Ofec5PIxoZMU8dNlR1iFTJIRQQbiRpN3JOZAeOLBZ/JrX0D5Jg2BPAODJDI2FPHQSvdpDBlM
	DoCcphkKDRdJ0bfWOzxkM5YSSP+7nUCXeodwVNvmBWi053MSOS6uEsh22UqgsU4djq71l+DI
	6Ckkkbq+AENOzU0CLRTPkGig7QqOepa7KLT01zUeWrrnI1BBnRtD42onQCbNZqTWWXD0Q4eH
	EG9lPsv7EWcs5yGj0Wcx+pZPSEbvLqOYjsZc5kZHNWBGquoBYx+fwplbS2YeY9O6SMaj38qc
	LTJRrwveCUxIZTPSj7KKp19KDjw0ZtRT8pnwbJ2jkcwDXaFnQAAf0s/CpqZZ3hkQyBfSzQAO
	LesIrvgTQNVA54bjAdBXZAP3I+YlC+CMJgDrVmqJf7u8I1corjAAqFm5TvkjOB0JKz89x/Mz
	Se+CI65JzM8hdAL88q5nPYDR3RT8uleH+41gOhkaLpSvvyegxdBac5fkOAgOVc+u92B0Nvxj
	YmVtKH+Nt8AmH98vB6zNtJsvbawaAQtMxRt8EloMEzyOFwJhb8/bHO+Gns5BjONgODdooDh+
	BK52163fD+lyAPt8CxRXtAKozb+zMSkeFo7NbiQSYfPkJPAvBOlNcPxWELfnJlhmPIdxsgCq
	Tgm57ijY6nDharC95oHLah64rOa/yzg5Fo5XVpD/k5+C2vqbGMcvQp3uNq4BVAsIY7OU0jRW
	GSdjj8UqJVJlliwtNiVTqgdrv9/qG3R3gS/mFmP7AY8P+sETa+GZ9lYbEOGyTBkbESIQv//y
	QaEgVXL8A1aR+a4iK4NV9oMtfDwiTBCZ+hgrpNMkR9jDLCtnFfddHj9AlMc7XT13QGVY7D2r
	Str5inzK21J2qtHwmqcTDTufvDjaNu1gdl2/2l4RYk1wPbQ77NWURbnj9qx7x2L3kPKyfbWv
	d78luKJy3/Ztv+UmVg0F2ZtiOqO03/FNxFvxQXsam/cWE8s5bzxX59spFo25538iS9R7y8N9
	N7z77SfjzLlX6RTyb210c07Sz98XVqTukxynzG+mbQs+URW9YhMlrU6SH+mBey667ZuG0JLu
	+IAEOI0ydww+erR0PiZ3StLwePZ0zHnpx/MfTpSWffWwZqTnPYnqsBk5RL9OTES6hJvvZYjz
	ctJ/6Ru+sFoSSic8X5lcLW93qjyW2j3HGk7Y60xRoxG48pAkLhpTKCX/ABbPJLd4BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA2WSf1CTdRzH/T6/Nuxmj4D1ZabosDjMJkOg7zo0ODMf7fd5dpTyY+EDeLEN
	n20e2XmOH2kxkzWxchZs2maYBzJgCYHY0ofJKsep6Bk3kl9xYilumARSg9HlXf+97v3+vN+f
	733vI8TDSyixcLtKy3IqRYGEmkt4pjp8z2REpeXGD9yIRMW8hUT+cx0Uch4zYOhB8z4cNfI+
	gAb5PgH60aBE33nGMOR1HiCRo7+bRK1tFwhUVTcO0KWWLyjkO/k3ibxnPSS63FRLoCHXxwRy
	+ssoZLSW4mjQMkKiO/v7KHSu7icCtUyeFqCJ+0MYmvhzikSl1XdxdM04CBBveQwZazsJ9HOD
	n0xdzBzRdxFM51HIWBw6xnHiI4px3DUJmIav9jDDDYcBc/FzK2C6r/USzO8Tbozx2m9RjN+x
	mKkw8ILXRW9LUzi1TssuyVdrtKslW2QoQSqTI2lColwqW/VsxnMJSZKVa1K2sQXbd7LcyjXZ
	0ny+cpQs/DWqqPJyN6UHzgXlIEwI6UTonugE5WCuMJy2ATg8MoKFjCdgfeAKGeIIONldToWG
	RgHs/f7r2UQjgNbGtpkpgn4SHvr0s5k0Ra+AF2/14NMcSafAmnt+wXQAp5sF0FhRDKaNCDob
	NtoOzrCIToUe873ZFVUY7DrAUyFjPrxweICYZpzeCQftfwUDwiAvhMenhNNyWHBBt7sVhJ4q
	gaX8/lneDf0PhoARRJgfajI/1GT+rykkr4DNTT3U/+Snod06god4NaytvU1YgOAEiGR1GmWe
	UiOTahRKjU6VJ81RKx0geIBOfrzhNKi6OSp1AUwIXGBZMNl36hsvEBMqtYqVRIpSdzyfGy7a
	pnhvF8upszhdAatxgaTgN36CixfkqIPXrNJmyZLjk2SJyfL4JHnyKsnjog2FHyrC6TyFln2X
	ZQtZ7t8cJgwT67GTquGjd7L6bmyGbnC/3aP15L4qSvRHFQ30FC+b7F+S37GQSwqUke3s+bZ0
	BW5TPEV8e0oeHcbvffN6xgdcdarqJev42jOcjy9GvqbexqU1eHaszxR47Y24uE11v90uXbej
	b6uy3mWdPFs37+WNh6Rp+mxLh2n98t2YuYYviZPYywIx0kxXl2jD9XUW/9XSdn1g0earL0Sn
	U/vqkMtgOBKgYmN67P1pcf4x76JXYra8n2nelDPHYG3VpafvKdlIm678EdvZMFa0N+vRkl+Y
	6HnWLw9WuHedqa80Vb913o3NsdXP79fwJcdjzTdbj71jE1965IcXt1oFwJ7JtRBOp4TQ5Ctk
	y3FOo/gH5R3XohUEAAA=
X-CMS-MailID: 20240512193245eucas1p103d1891d851a519d0ab83e586ccd2cad
X-Msg-Generator: CA
X-RootMTR: 20240511095125eucas1p1e6cd077a31c94dcdda88967d4ffc9262
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240511095125eucas1p1e6cd077a31c94dcdda88967d4ffc9262
References: <20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net>
	<20240424201234.3cc2b509@kernel.org> <202405080959.104A73A914@keescook>
	<CGME20240511095125eucas1p1e6cd077a31c94dcdda88967d4ffc9262@eucas1p1.samsung.com>
	<8d1daa64-3746-46a3-b696-127a70cdf7e7@t-8ch.de>

--qt3jjettk7ey6stj
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 11, 2024 at 11:51:18AM +0200, Thomas Wei=DFschuh wrote:
> Hi Kees,
>=20
> On 2024-05-08 10:11:35+0000, Kees Cook wrote:
> > On Wed, Apr 24, 2024 at 08:12:34PM -0700, Jakub Kicinski wrote:
> > > On Tue, 23 Apr 2024 09:54:35 +0200 Thomas Wei=DFschuh wrote:
> > > > The series was split from my larger series sysctl-const series [0].
> > > > It only focusses on the proc_handlers but is an important step to be
> > > > able to move all static definitions of ctl_table into .rodata.
> > >=20
> > > Split this per subsystem, please.
> >=20
> > I've done a few painful API transitions before, and I don't think the
> > complexity of these changes needs a per-subsystem constification pass. I
> > think this series is the right approach, but that patch 11 will need
> > coordination with Linus. We regularly do system-wide prototype changes
> > like this right at the end of the merge window before -rc1 comes out.
>=20
> That sounds good.
>=20
> > The requirements are pretty simple: it needs to be a obvious changes
> > (this certainly is) and as close to 100% mechanical as possible. I think
> > patch 11 easily qualifies. Linus should be able to run the same Coccine=
lle
> > script and get nearly the same results, etc. And all the other changes
> > need to have landed. This change also has no "silent failure" condition=
s:
> > anything mismatched will immediately stand out.
>=20
> Unfortunately coccinelle alone is not sufficient, as some helpers with
> different prototypes are called by handlers and themselves are calling
> handler and therefore need to change in the same commit.
> But if I add a diff for those on top of the coccinelle script to the
> changelog it should be obvious.
Judging by Kees' comment on "100% mechanical", it might be better just
having the diff and have Linus apply than rather than two step process?
Have not these types of PRs, so am interested in what folks think.

>=20
> > So, have patches 1-10 go via their respective subsystems, and once all
> > of those are in Linus's tree, send patch 11 as a stand-alone PR.
>=20
> Ack, I'll do that with the cover letter information requested by Joel.
>=20
> > (From patch 11, it looks like the seccomp read/write function changes
> > could be split out? I'll do that now...)
>=20
> Thanks!
>=20
> Thomas

--=20

Joel Granados

--qt3jjettk7ey6stj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmZBGVgACgkQupfNUreW
QU9Dtgv8D/HdnyHHjf9EvZYIA7HnMu2U/9l/w1ouqfAMmi7HS4Y98dZVBP5X3MEe
5neOWNwlQN6rncGIhaLJE+q0M7KL52ej3pWS72olJGcJamFdahPGRN444v49FvCk
bCwjbHxOysmwpLAF+XsnYlOGOJ5K0n9eDONYPI2Zg+ehDHMMGyAPx6P+d7rqJzOF
WUgIsUGC75GVbawyHRi25emp4svTsNh+cnsG6Fsh8LY0u8ixH1q58bUxOq5Qu8IG
aI6TCHU/1z0iFEBV1PAF/NsFx/GHFaJ2v01TDNwEX1J4vOWE8wopJaYDVudy8MGg
z8fMq6vlMSQnY3EkN6LKkFUJyS7vnRhowXaWBrY1DoB0zKLziXHhCpWU7JzN4U4N
guxBPD1pT8LhIPGBC5wRfKO9LLe8jNKwn7ugcLdCCxzygdPjWizk0M8QVxRnhGKO
unK/FP5KS6yFMxT9sppN6halqDwjuwon9WU7vbuINgn2VhTSM7u9/kUzcuq3N/Cu
Qk1K0rUf
=w318
-----END PGP SIGNATURE-----

--qt3jjettk7ey6stj--

