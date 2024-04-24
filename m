Return-Path: <linux-fsdevel+bounces-17614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF74E8B05A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 11:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 535911F26504
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 09:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05106158DB9;
	Wed, 24 Apr 2024 09:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aSAwhV0B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AE3158D6B;
	Wed, 24 Apr 2024 09:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713950038; cv=none; b=IHzhoPABdwtnkTg7dQwJiL4Ztbygn1xYBk6T9Kx1YajDFzr7gER7gjh7rV5scQXoDESLGOgWKOS/Fu1InO9TNDRgCHHDpvrSFLz1lqrdXHxzR9aKIT7Uz7pDe2krwAFTPOqY+GzUolHEDrUeVIUI75IXH5NA/oV6J2mPetCSDjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713950038; c=relaxed/simple;
	bh=kwOToCx5Xooe3aJqkybANNPjfaU/VyfvyRqvIPXQRH4=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=HHTu0kWfFcRd3GQG6jrhMjncdAlTCce8z+E16E+hK4YMv7kKSFm4Xvlc1G38k+w8lNo55wetkPUg2L46h9AK8lIuI6QWXKiU5xr3/teHazWX+R02ZiS2KJk4oCjCZzANIArDWLR/o9bh3bZsyab9b4fqSUUfAj+qV2GSmC224Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=aSAwhV0B; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240424091353euoutp02a99f231124e7c37c8b8a49a9232b77f9~JLHl1sgmH1862118621euoutp020;
	Wed, 24 Apr 2024 09:13:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240424091353euoutp02a99f231124e7c37c8b8a49a9232b77f9~JLHl1sgmH1862118621euoutp020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1713950033;
	bh=kwOToCx5Xooe3aJqkybANNPjfaU/VyfvyRqvIPXQRH4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=aSAwhV0BgLj4HlzR9RkxKUIlKO6mdH+qDlcJnc3WQqvvbUEEu9rE5tdbfzAf3CCKG
	 LMJ5j7IlxtSxWYK2OgflVwchXJUAt+SEljM12rLnj+ixER6dRPvEAkh5jxiubbM7YU
	 y+vsHzDfhMaVwDt5VCCH2fjZ1joktXWYCMO6tnok=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240424091353eucas1p2d064d779024946aee4f8181509c2f5da~JLHlozUYn1487814878eucas1p23;
	Wed, 24 Apr 2024 09:13:53 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id E5.96.09624.05DC8266; Wed, 24
	Apr 2024 10:13:52 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240424091352eucas1p1c0d02929537ba08fee15fd7fd0517813~JLHlALEqg2217522175eucas1p19;
	Wed, 24 Apr 2024 09:13:52 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240424091352eusmtrp1d9ccae9cde2c168d9a3fb3babdbf8d26~JLHk_vwxq2021920219eusmtrp1y;
	Wed, 24 Apr 2024 09:13:52 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-d2-6628cd50483d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id DE.D4.08810.05DC8266; Wed, 24
	Apr 2024 10:13:52 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240424091352eusmtip1fa4b115f07c557f8f6f3537efb4e8058~JLHktoFeI2178721787eusmtip1L;
	Wed, 24 Apr 2024 09:13:52 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 24 Apr 2024 10:13:51 +0100
Date: Wed, 24 Apr 2024 09:52:38 +0200
From: Joel Granados <j.granados@samsung.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
CC: Luis Chamberlain <mcgrof@kernel.org>, <josh@joshtriplett.org>, Kees Cook
	<keescook@chromium.org>, Eric Biederman <ebiederm@xmission.com>, Iurii
	Zaikin <yzaikin@google.com>, Steven Rostedt <rostedt@goodmis.org>, Masami
	Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas
	Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>, Stephen
	Boyd <sboyd@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Will Drewry
	<wad@chromium.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel
	Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider
	<vschneid@redhat.com>, Petr Mladek <pmladek@suse.com>, John Ogness
	<john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Anil S Keshavamurthy
	<anil.s.keshavamurthy@intel.com>, "David S. Miller" <davem@davemloft.net>,
	Balbir Singh <bsingharora@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
	<john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
	KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	<linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, <tools@kernel.org>
Subject: Re: [PATCH v3 00/10] sysctl: Remove sentinel elements from kernel
 dir
Message-ID: <20240424075238.g7dwzjt7nqajcdgk@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="c3mjqeq3spx6dpjw"
Content-Disposition: inline
In-Reply-To: <36a1ea2f-92c2-4183-a892-00c5b48c419b@linaro.org>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTe1BUZRjG5zvncM6CLR4Wwk/AHBAZBgE1dPwgISvHjs1UVM5UTqOucgQC
	FmYXSMUmICRYUUhABgRZIK6LKBeX+wIr10BuEnETUERBUEJcCWXZgIPlTP+97/v8nu993j8+
	Hi5opEx4niJ/ViwSeluQeoSicaHDzvW29ckdl+87oflXV3BUOTFIoOcLgxSaq28iUffYHyRK
	mAwhUPJkG4Uy0l7gKLkjjEDjMTdxpFWEUUjVVEOh0LIcDCl6UgGqj0taFmS+aLG5kER3o+MJ
	1HbeB1W2qjEUEVtKoEfKCxiqqm4h0J2KZBLVX79NIPm1YB2U+WcXhvIjc3VQX8w4QLFPHwKU
	kW2FumtlGJLHaSjUdKEWQ9oxtQ5SRoxiaKm3kEDdf08RqLIwnURN2RoSFRfF46i98B6OIuqX
	s95smKfQoFRLoVG5QgdllX+2bzszMq0hmPyr+YC5EtxFMCW5/RhTnnSXYsKUAxQjKwpginNs
	mIyqSYyR9nXjzMCUM1OUF0kyQ71VJPO0vZ1i0oLjcSYmvRa4Gh/W2+vGensGsuLtLsf0PDp/
	UQI/pcGpshfhRDA4t14KdHmQ3gWz8xNIKdDjCegcAFsePcS55jmA54qb15Q5ADXSOPK1pSIm
	EeOEbAAXOyewf6nyxB7ANcUAyruGiBULQW+F0UMjq3aStoUd00PLS3g8o+U6Ml6ywuN0Ax92
	xHWs8oa0K4zv7aZWGD69DwaHbFoZ82kD2JL4YBXB6VNwdky7iuC0Kcxe4q2MdWkXuCDrIbig
	5lCdMbxW/wh/LxlYzQnpmXWwvWF8NQKk90NNqRvHGMLHTSUUV5vB1tgoguNjAaxZ+oviGjmA
	WSFqjKPeg2E9D9YcH8Dw4RmCe1Qf9j0x4HLqw0uKhLVdfBgRLuBoKygfniZiwJakNy5LeuOy
	pP8u48a2UFb5jPzfeBvMSpvCudoZFhTMEDJA5YENbIDEx52V7BSxP9hLhD6SAJG7/QlfnyKw
	/L1al5qelYGUx7P2KoDxgApYLpvv35B3AhNC5CtiLYz4LxctTwr4bsLTZ1ix71FxgDcrUQFT
	HmGxgb/VbTMroN2F/qwXy/qx4tcqxtM1Cca+DDxbJ7jnWXvoYpk25qD1nsBOZdTnjsP2pbFt
	31uVrE/10m9WzCnXjdineFQd33/++Ca/vBnvI7kDm+00BVc/CSk6bKqWRu96aeswvdQ2Yb6o
	c9D6oy17y68hlXfLNrv+0t2DTidoZeQX3wlOG77TanP91pmgj3sSg4xveDn4yS7V/NT4qbOb
	OZ5ZbPJ2aHpVVJDjxu666sYPn/yGp1eYGR117T9bPRvq3mg2Z6z2rjuimx9npBDTqQcm56Xa
	GTq8YbTW8qtvyKSJy3Y/q60yHeM1hxzKdvjL+75uabloMuaacuddibb6VYnBxl95eZ18lz2q
	WP+3KlW979/69thuO6fwPJ8OkQUh8RDutMHFEuE/XTuYVtkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTe0xTVxzHd+69vbewFS+FsRsciTaMGaaFIoVTIh1ZNrkui+EPyTKcQieX
	xwYta8GgCaY44kqJoUxxUhBaQRBhaHnKc11XBwryEhlPAZ3yTJUhOt5r7ZaZ7L9Pvuf7/Z5f
	fjmHjXIncXd2vDSZkUslCTzcEevcbB/fE3Z3V4xvU50LfLmWj8LmmVEMPl8ZJeCSuR2H/Y/u
	4/DH2XQMFsx2EbBY/wKFBT0ZGHysqUPhVn0GAU3tPxPw9M2rCKwfKALQfF5rPdDJ4HqHAYfj
	2bkY7MpKhM2dywhUnWvA4HTbWQS2tN7G4L2mAhyar9/FYMVPSha88nsfAiszy1lwSPMYwHOW
	JwAWl3nBfqMOgRXnNwjYftaIwK1HyyzYpppE4OagAYP9f81jsNlwGYftZRs4rKnORWG3YQqF
	KrN11rpbLwk4qt4i4GRFPQuWNh4M8aEnFjYwurKwEtD5yj6Mri0fRuhG7ThBZ7SNELSuOoWu
	uepNF7fMIrR6qB+lR+aD6eprmTg9NtiC05buboLWK3NRWnPZCMLcIvj75LKUZGZHnEyRHMw7
	LIB+fIEI8v38RXzB3sAjQX5Cno94XzSTEH+ckfuIo/hxW88+SmpxTtW01uJK8N02NXBgU6Q/
	1aTJQ2zMJa8AamRjh11/lzI8v8+yswu1PqjG1cDR6lkE1GyOnrAHagBlzAq0MUa+R2WPTeA2
	xsndVM/CGKoGbLarlTNzFbYsSt7iUEPTRa88LuRBauwHI2bzcMgQSpnuYe+fBNRwdfarizmk
	M3U77w/Mxih5nOoyXAA2P0pup8o22TbZgRRTK7oBzD7nTmq5+ME/nEYtbTwBGuCifa1J+1qT
	9r8mu+xNDW3OIv+TP6BK9fOonYOpqqqnmA4Q14Ark6JIjE1UCPgKSaIiRRrLPyZLrAbW513/
	20rNTVA4t8g3AYQNTMDTmnx4o6IXuGNSmZThuXJW1z1juJxoyYmTjFwWKU9JYBQmILQuMQd1
	f/uYzPpXpMmRggBfocA/QOQrFAXs5b3DOZCkknDJWEky8w3DJDHyf3MI28FdiWQronxLzxvf
	MJ1Uxe8fDmVzG9y+kI8NRFWGz3Ssdn6I+zqmx/d7hkfeQXb3rdYVihpqY9p3mk2iT3dZDrhn
	72HpXScP8T4+80z8PZ//yftpzpI3N+suVsfOWWIixLoQ4sbRwPTDRVHBAQX6X3tXzc1eoZp5
	C136taX8BTK1eoLcxnJi8lyL5goH3Es+H+/9ih6simmOFlZ4THv0uJzRRXeUlHt+ebRFm3mn
	9dJE1kXJocW33L7l/PnZ6dwjM70TDYUPFLlP2criknwx956rZ7gwbdg4HaBPXQpaOxXhPBXk
	NNita3T+pZy/kFTmtRY6HJnqVNB4SnVpf44qbHX78sPrizxMEScReKNyheRvqkITNnMEAAA=
X-CMS-MailID: 20240424091352eucas1p1c0d02929537ba08fee15fd7fd0517813
X-Msg-Generator: CA
X-RootMTR: 20240422142758eucas1p26e94cf6fbbbc99b27e941a172e8a4e41
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240422142758eucas1p26e94cf6fbbbc99b27e941a172e8a4e41
References: <20240328-jag-sysctl_remove_empty_elem_kernel-v3-0-285d273912fe@samsung.com>
	<CGME20240422142758eucas1p26e94cf6fbbbc99b27e941a172e8a4e41@eucas1p2.samsung.com>
	<36a1ea2f-92c2-4183-a892-00c5b48c419b@linaro.org>

--c3mjqeq3spx6dpjw
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 04:27:47PM +0200, Konrad Dybcio wrote:
>=20
>=20
> On 3/28/24 16:44, Joel Granados wrote:
> > What?
> > These commits remove the sentinel element (last empty element) from the
> > sysctl arrays of all the files under the "kernel/" directory that use a
> > sysctl array for registration. The merging of the preparation patches
> > [1] to mainline allows us to remove sentinel elements without changing
> > behavior. This is safe because the sysctl registration code
> > (register_sysctl() and friends) use the array size in addition to
> > checking for a sentinel [2].
>=20
> Hi,
>=20
> looks like *this* "patch" made it to the sysctl tree [1], breaking b4
> for everyone else (as there's a "--- b4-submit-tracking ---" magic in
> the tree history now) on next-20240422
>=20
> Please drop it (again, I'm only talking about this empty cover letter).
Here do you mean revert? or do you mean force-push without the cover
letter commit?

I did the later, but if the former is necessary I can always go back to
the old HEAD, add a revert commit and then push that.

Best

>=20
> Konrad
>=20
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/com=
mit/?h=3Dsysctl-next&id=3Dec04a7fa09ddedc1d6c8b86ae281897256c7fdf0

--=20

Joel Granados

--c3mjqeq3spx6dpjw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmYoukYACgkQupfNUreW
QU9vQAv+Lne9ZN0yGMA1Mmfcb0fp2lW2SntP3+HHJYiKmz98mwTHJrsNLqgRg9Sp
18WTHY2ZF0t/6poR3F6+6ScGSdk9IjzwNzyLJeaH9iGQq8xU7PcIdcvgvXp5GWnw
PeDW28bZ74r2vGa9sDRmzqEHmJ6zxGAsIRopraO5iCjsX/xZQILsbj3McgnQ1Mf8
usn7eJbiUgpWPfc6Xp4oylK/5vZYwkds3ktFT0bCOO+QoP3bIS6xVkRBDS7K9cJS
0yPRvkmICkjOL11n4PYKeev+5NHxAUbFwrD3HJ8bKkDIN0GQCsd98nucM2q32fcA
aQnsxdnHVPeCf42ZSZWEpm3GtTqXJuBespmD78k3DqQMOElbGs3XWck0/17kTNRo
3k53VVirXDs7xWx8KtGPt17sQLTjoR5ETNbS6OO+XLmZvzA8XHDvVLUVOKGvHcSC
pXvKil3C7em0Yuea0ioAKeNRBr8SRsGXD6VazvCUX6eSAeYWVopJscUJY7c5FWuS
wDWSrhNX
=iaui
-----END PGP SIGNATURE-----

--c3mjqeq3spx6dpjw--

