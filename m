Return-Path: <linux-fsdevel+bounces-17611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B778B0387
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 09:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1383285659
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 07:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C13C158200;
	Wed, 24 Apr 2024 07:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JxxltQf+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591D4158204;
	Wed, 24 Apr 2024 07:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713945324; cv=none; b=LpD+87a3HJrz+QaZ05KvSj5KUd26ED02Qox0h9ZTJseVXXk3ZsQDT09APKumHAzmSkb8ij41udfaVDaSSymPA0tHUIlDQRjgWSqW7IFVeu7/WHommCXtEAf2uUxnHolztfMlHZjpiE2SvZ9uZOnrTu0cGzx9fupc/ABDHYGuFqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713945324; c=relaxed/simple;
	bh=854/E/3WlV5L2HlVhvqn4Cpxbq0+moLFrvaCOnjxA/g=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=uAM19zTUncUdEDLQRjMHzobjR8dufJrBHyK9y0KhPWV1zh7qqHT94gxPHCnqLIqFnaBr9r06+K8apsbgIUFZxFE3UIY8+kI0aYaPGtlmfNhvaKGTUj5MbrNtiJbqCFAqDzmwe+yzWnEbR6e7gGUhbjyLGd+26c7DYT4588UXLNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=JxxltQf+; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240424075518euoutp0197d40c301283da644655615a37656105~JKC_VtpW92450024500euoutp01d;
	Wed, 24 Apr 2024 07:55:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240424075518euoutp0197d40c301283da644655615a37656105~JKC_VtpW92450024500euoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1713945318;
	bh=13Crf8Dw1GdmPTClarxewW31SdTx+PFVwsFMGKkjJ2s=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=JxxltQf+qwyB2mCsZ3vOJEn2PHIwy1raoBUfIMVd+jfpvXRH95oN+ceqxh92svjTX
	 4i3xJ+2TzTWVqswUbSQuMdBeI7Y+X4vnvq1nUXhwL6UKZCygbxrws8ghEdzUV/Dah8
	 KOTwccoayMTSWn30So8Sx23xoy8yQicm9MDDNu+0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240424075517eucas1p1c119b4f0f864c1a3b8f5d1a90eec5aaf~JKC98GKvG1445914459eucas1p1G;
	Wed, 24 Apr 2024 07:55:17 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id D4.D7.09620.5EAB8266; Wed, 24
	Apr 2024 08:55:17 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240424075516eucas1p1e0334417fd06c1443c325723a2f08c9c~JKC9RIfbS0143501435eucas1p1C;
	Wed, 24 Apr 2024 07:55:16 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240424075516eusmtrp2a20c2bc21c42ecff63616a3e68737e50~JKC9M8Uq-1702017020eusmtrp2n;
	Wed, 24 Apr 2024 07:55:16 +0000 (GMT)
X-AuditID: cbfec7f5-d1bff70000002594-62-6628bae529dd
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id EB.73.08810.4EAB8266; Wed, 24
	Apr 2024 08:55:16 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240424075516eusmtip2d500b32a0b1125da635221646781374e~JKC87ZNaL1353413534eusmtip2B;
	Wed, 24 Apr 2024 07:55:16 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 24 Apr 2024 08:55:15 +0100
Date: Wed, 24 Apr 2024 09:55:07 +0200
From: Joel Granados <j.granados@samsung.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Konstantin Ryabitsev <konstantin@linuxfoundation.org>, Konrad Dybcio
	<konrad.dybcio@linaro.org>, Luis Chamberlain <mcgrof@kernel.org>,
	<josh@joshtriplett.org>, Kees Cook <keescook@chromium.org>, Eric Biederman
	<ebiederm@xmission.com>, Iurii Zaikin <yzaikin@google.com>, Steven Rostedt
	<rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, John Stultz
	<jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Andy Lutomirski
	<luto@amacapital.net>, Will Drewry <wad@chromium.org>, Ingo Molnar
	<mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel Bristot de
	Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
	Petr Mladek <pmladek@suse.com>, John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>, "Naveen N. Rao"
	<naveen.n.rao@linux.ibm.com>, Anil S Keshavamurthy
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
Message-ID: <20240424075507.ggdmj7hg2xihmbq6@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="5scxkb2uvfn4vufj"
Content-Disposition: inline
In-Reply-To: <1804aebc-68a5-4bd8-b42e-e06ce82f7355@kernel.org>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTe0xTZxjG853zcU7BAYdL4AuYXZgwJopzM+bbmIaZmZ25jJnMv9wcFjkg
	GRfTinMuEGxwQBmRjRIZIhQ6rsUC5TLLtTaMgkLRitxhKrdxH4PKZbaM5uBmsv9+7/O8T77n
	/eMTkM5G2kMQEX2eE0ULI70oO1jXtm7YO1HvG/bWgswTr/59ncQNfwxBvLI+ROPlVj2FjWMP
	KXxt+jLEOdOdNFbkPyVxTncixBPptSTerEuksU7fQmPJrRIC1/XkAdwqy94y5DH4WXsVhUeu
	ZkLcmRqFG+6aCJyc8SvEmuUVgKea0wjc3V1J48amDogf1OdQuLWiC2LlzQQbXNh3n8DlKaU2
	uD99AuCMhUmAFcU+2KiVE1gpM9NYn6Yl8OaYyQY3Jz8isKW3CmLj2izEDVUFFNYXmylcrc4k
	saHqMYmTW7da1/62SuMh6SaNHynrbHCRJihwP/v7nBmy5bnlgL2ecB+yNaUDBKvJHqHZxOZB
	mpWrY9nqkt2sonGaYKX9RpIdnD3EqstSKHa4t5FiFwwGms1PyCTZ9AItOO5+0u79UC4y4gIn
	2nf4tN3Z+h8t1DkZuri4HpIAUl2lwFaAmAOoYmmAlAI7gTNTAlBSRg/NDysAZbb1bjvLAE0t
	3rB5HnmSMQt5oxignLZ2+O/WxJh5O1INUO6IBlgjkPFG1fNrlJUpZg/qnhsmrezKvIn6zKs2
	1gDJlDmgwqQ2wmq4MMdRZq+RtrI9E4geSg0kz06o4+dxaGWSuYiSr0xu6YIt9kTFFoFVtmUO
	o6WJHIqv+hoyKUYhz3HoTs0gYX0LMRs7UEpZ7fY9H6KN3O7tJRc0o6+hed6JNjV524EMgFos
	f9L8oASo6LKJ4LcCUGLP+HbiA2Tuu01YGyHGAfXPO/FFHdBPdddIXrZHyd8789s+SDk6B9PB
	69kvnJb9wmnZ/53Gy3uQvOEv6n+yHyrKnyV5PoRUqkUoB3QZcOdixVHhnPidaO4bf7EwShwb
	He5/JiZKDba+2l2L3nQLlMws+esAIQA6sGsr/KRSeQ94wOiYaM7L1X7j2a4wZ/tQ4beXOFFM
	sCg2khPrgKcAernbe4e+wjkz4cLz3Nccd44TPXcJga1HAuHoeczNnKSQUH5R4wcVRu+QrK8q
	317SSm7Iuw4SkibaL7hMdrOg6Is0F4MlcF/xAwpczevvWtnZMoEnm9yh372uDvNemWr+VHyW
	7tVlzuvSZIO2ia77aGqcipdcCKYr4JnSA6JluHSk0W09tWQ08nPfH7JaPkn9zifoJelJpnDH
	qc2ZkSP5IyrHQLOrtvPdvi99tSf6yv3f6Jz9+JhDeKUsSlap1of2PFU97tkgak0qZYBjXJn9
	5FD48lEdECVZwjRx3l7U0ewBx/d+kc+MuQVFeCMgnW+/rR6+E1LRtkacblL1xMcPf5qwOJd3
	QiUZv1JiUDm9PJ6jCp7Z+CzAC4rPCvfvJkVi4T+O5zTt5QQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTeVCUZRzH53nfd993MbAVSN5WpoyjBGRhOX80QFg589YfajE2pRJu8nJM
	sMvswaClUGHBlkUcIccgSLLAggHLIYcbbZtkcgjFIYcoV8KiDQMEJru0O1tjM/33eZ7vMb/5
	zfNwcfslks9NEMtZqViU6EJuI26Yum97z7bvifXtbfKA9UfFOHTcGydg9eE4BSv6bhIGZ4ZI
	KFj4iICShR4KKsr/xKGkP4OAuexmHLZaMijQdX9PwcdXqjBo+e0CAn1ekVkok8Dmzw0kTH6V
	T0DP50nQcWMNg8zcVgLaVlYR/K49h0F/fz0FnVevE/BrewkJ+u96CVDXpXPg0sgABrVZ1RwY
	zZ5DkPtgHkGF6nkY7CrDQJ1npKD7XBcGWzNrHNBm3sHANNxAwOCGgYCOhoskdKuMJGga83Ho
	a7iLQ6bePHXzT+sUjCu3KLijbuFAZduBCCEztWQkmNrSWsQUpw8QTFP1LYxpK5qkmAztGMWU
	NSoYTZUnU9G5gDHK0UGcGTOEMY01WSQzMdxJMg/6+iimPD0fZ7IvdqFDTkcEoVKJQs7ujpfI
	5GEuR4XgJxCGgMAvIEQg9A+OetEv0MUnPDSGTUxIYaU+4ccF8e39mSg5h0790UiloyxHJbLh
	0rwAejrXQCjRNq497xKi+wo2OFbBmW5YHfqHHejNYSVpNS0jurq8jrIeNIheme0iLC6C505r
	7m+QFiZ5e+n+pQncwo48D3rEuM6xBHBezXZ6K6uKsggOvAP0RI41bMeLoIeUfbi1dROjPysx
	4FZhB329cNZs4prTKfS3q/5W3EWrTFyLw4YXTi/PlZDWSZ+j1ypuE1Y+Ta8Y51E2cij6T1HR
	46Kix0UWB87zpEdNC9j/rr3oynIDbuUw+vLlP4gyRNUgR1YhS4pLkgkFMlGSTCGOE5yQJDUi
	81NvufZQcwWVLi4LdAjjIh1yMyen69U3EZ8QS8Ssi6PdX5tusfZ2MaKTp1ipJFqqSGRlOhRo
	XuLXOP+pExLzvxHLo4VBvoHCgKAQ38CQIH8XJ7vXkjNF9rw4kZx9n2WTWem/OYxrw0/HFF8+
	ObPgyce0BZOF7suvR3DffLvO54xOsOg1j2KLg9lvBirfYiOzfHrecYayqGtc2/dsBuWb+3fZ
	HTz86BV1et3pUPmEaSRqauugaud2V3WZ27675TeNzZ01umcN4e8GNDntjlxPinE4fl4jNe1o
	c7tQ37jRHs2Zf2b4fExeOIzFRTSe9VZFTpcee5mizqyMVdeVTn2Qu8/9XqvX2S9ueY9sOpdc
	rVanCu0Oqb0+PfaEwDXVs52r0O4/cnQ3Sm0OVofb8nfKxuwDPKapHzgvjYceXv4kQ7uSe/9U
	6964lEXtG6qcLI3rXJpH8R5VQnIE/svJDwULaa/qB235Tyv1aYUv9LoQsniR0BOXykR/A8K3
	mgJ/BAAA
X-CMS-MailID: 20240424075516eucas1p1e0334417fd06c1443c325723a2f08c9c
X-Msg-Generator: CA
X-RootMTR: 20240422150814eucas1p273f4eedd9082763e57ea53f16e5ac7f1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240422150814eucas1p273f4eedd9082763e57ea53f16e5ac7f1
References: <20240328-jag-sysctl_remove_empty_elem_kernel-v3-0-285d273912fe@samsung.com>
	<36a1ea2f-92c2-4183-a892-00c5b48c419b@linaro.org>
	<311c8b64-be13-4740-a659-3a14cf68774a@kernel.org>
	<20240422-sensible-sambar-of-plenty-ae8afc@lemur>
	<CGME20240422150814eucas1p273f4eedd9082763e57ea53f16e5ac7f1@eucas1p2.samsung.com>
	<1804aebc-68a5-4bd8-b42e-e06ce82f7355@kernel.org>

--5scxkb2uvfn4vufj
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 05:07:59PM +0200, Krzysztof Kozlowski wrote:
> On 22/04/2024 16:57, Konstantin Ryabitsev wrote:
> > On Mon, Apr 22, 2024 at 04:49:27PM +0200, Krzysztof Kozlowski wrote:
> >>>> These commits remove the sentinel element (last empty element) from=
=20
> >>>> the
> >>>> sysctl arrays of all the files under the "kernel/" directory that us=
e a
> >>>> sysctl array for registration. The merging of the preparation patches
> >>>> [1] to mainline allows us to remove sentinel elements without changi=
ng
> >>>> behavior. This is safe because the sysctl registration code
> >>>> (register_sysctl() and friends) use the array size in addition to
> >>>> checking for a sentinel [2].
> >>>
> >>> Hi,
> >>>
> >>> looks like *this* "patch" made it to the sysctl tree [1], breaking b4
> >>> for everyone else (as there's a "--- b4-submit-tracking ---" magic in
> >>> the tree history now) on next-20240422
> >>>
> >>> Please drop it (again, I'm only talking about this empty cover letter=
).
> >>
> >> Just to clarify, in case it is not obvious:
> >> Please *do not merge your own trees* into kernel.org repos. Instead use
> >> b4 shazam to pick up entire patchset, even if it is yours. b4 allows to
> >> merge/apply also the cover letter, if this is your intention.
> >>
> >> With b4 shazam you would get proper Link tags and not break everyone's
> >> b4 workflow on next. :/
> >=20
> > I was expecting this to happen at some point. :/
> >=20
> > Note, that you can still use b4 and merge your own trees, but you need=
=20
> > to switch to using a different cover letter strategy:
> >=20
> >   [b4]
> >   prep-cover-strategy =3D branch-description
>=20
> Yes, but you still won't have:
> 1. Link tags
> 2. Nice thank-you letters
> 3. Auto-collecting review/tested/ack tags
>=20
> So sure, maintainer can even cherry-pick patches, use patch or manually
> edit git objects and then update git refs, but that's not the point. :)
>=20
> Just use b4 shazam, it's so awesome tool.
I'll try this out going forward (instead of chaning the cover letter
strategy)

Thx again.

Best

--=20

Joel Granados

--5scxkb2uvfn4vufj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmYoutcACgkQupfNUreW
QU+F2Av/QqbfQttykaAD7KNkB5kok78Ab5AkiiDAM8lFgJvBZN1h8U7IueUGwXBr
n0i2wBPUZRDZ4k2OYMltTAhLdVXGNqAfJDmWChJpxRKSpCh+CNK5l1FImfM7I9Hg
wbAXyzgEJofNgic+s75BLSbyC8SQB/4xHZ8HXD5xV7rT5nyxk6FKTU+1CHM0wcMJ
BRRl0JzlPSkfJ9soQFrr0JMosSK/zJfhqQMT8/lYmMWoJfT8u/X6xSiFfOWl3yKD
T/E/zJphjpNN1RVwFGln4I0AAZ1T3bu211IX05ekhYZepQHgx0bhv6/vsqXp1LbG
TB++mNPYhhW0UA7N8OvJCcZHOxTP/KW3bybjDyVBZilmqzhCeIukm/svXIL3t2zV
+yLZIPGFi3anx0l7TBhlWzuLb4BqjOt9sGuJnnzcb421bXtBDTWo6wbrxjvbqXdr
QVauUByn/c8ZYnJkw6j1VhrY39EXSjkcYOC5Li9L1dXfKwgB3daeQ8ZPn3g8TcNn
Aw0xDsib
=jM5G
-----END PGP SIGNATURE-----

--5scxkb2uvfn4vufj--

