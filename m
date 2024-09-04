Return-Path: <linux-fsdevel+bounces-28598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD2896C48A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 18:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55115287DFC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 16:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC02B1E1300;
	Wed,  4 Sep 2024 16:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMuXSDQl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063F91DA312;
	Wed,  4 Sep 2024 16:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725469122; cv=none; b=movD9x1o504cBLvY+UZaRy5xJwzZ8QAFQMjBF1qQTTUsAznbLY9MdqP9UtBcY9jKL1Zq13S1r1lmanZb3OxF3kSYblHyuCDgGdcjYYsfEfriQY/6K9us8IRgSRMOZhcGEQawjm6YT7IcdtdtRYnhuDtCQgdItkBFM4+HspPEyEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725469122; c=relaxed/simple;
	bh=bCwGrc2028pSjBdRCl46T+rh8AQRhNz5pAwTue343Y4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H60aP/dp2sdwh4sYyfl65Tr5HNiFz9MDuEVASzpBbj90oDC51pyZsDy+ENhn+MfXOELM4NZpupNMxvJmzEIcJv8VUYvHYYCbWarelvmte8yTnGgg/OwlR7SZFu7WRJWHvkY7Nf1ryBjIDAvW4S9MsM4xQpBjoQWdTOsmyvzK/t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMuXSDQl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF84C4CEC2;
	Wed,  4 Sep 2024 16:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725469121;
	bh=bCwGrc2028pSjBdRCl46T+rh8AQRhNz5pAwTue343Y4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=jMuXSDQlbFbG8LZbLKcRVWTUn6mMdSeXvEC+1dHPGFjn7Lp1qIGdo9WtClVU/WEDs
	 9rrwpjydxHxpQsI+WIi894/JVqq6QZqcYGZSVOCzTAtI7kqbC5RJFC6EMP3ebSjuGh
	 KHluHLWPGT7qnIOG3pARLOjkHiO9R4U6DjblqlzrgJz5IIbe0O2fuIXgo1NZ6mGKst
	 QafmNyZFKHBJhRaPmm1Sc+pW5VrruOrZ4qIKHBwus8cihaw4g2wtLpBS3ZuVaDqkmx
	 yDmGndn4kRCDEWU3poQPfz1sFBHfoagX5JezNlyJlH8AmXr4+BRjyc7hn5XUJHvsmQ
	 fNkTxtLpoYIxQ==
Message-ID: <82b17019fb334973a74adf88e3eb255df4091f12.camel@kernel.org>
Subject: Re: [PATCH v3 03/13] nfsd: drop the ncf_cb_bmap field
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai
 Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Trond Myklebust
 <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Olga Kornievskaia
 <okorniev@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Jonathan Corbet
 <corbet@lwn.net>, Tom Haynes <loghyr@gmail.com>,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Date: Wed, 04 Sep 2024 12:58:38 -0400
In-Reply-To: <Zth6oPq1GV2iiypL@tissot.1015granger.net>
References: <20240829-delstid-v3-0-271c60806c5d@kernel.org>
	 <20240829-delstid-v3-3-271c60806c5d@kernel.org>
	 <Zth6oPq1GV2iiypL@tissot.1015granger.net>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=mQINBE6V0TwBEADXhJg7s8wFDwBMEvn0qyhAnzFLTOCHooMZyx7XO7dAiIhDSi7G1NPxw
 n8jdFUQMCR/GlpozMFlSFiZXiObE7sef9rTtM68ukUyZM4pJ9l0KjQNgDJ6Fr342Htkjxu/kFV1Wv
 egyjnSsFt7EGoDjdKqr1TS9syJYFjagYtvWk/UfHlW09X+jOh4vYtfX7iYSx/NfqV3W1D7EDi0PqV
 T2h6v8i8YqsATFPwO4nuiTmL6I40ZofxVd+9wdRI4Db8yUNA4ZSP2nqLcLtFjClYRBoJvRWvsv4lm
 0OX6MYPtv76hka8lW4mnRmZqqx3UtfHX/hF/zH24Gj7A6sYKYLCU3YrI2Ogiu7/ksKcl7goQjpvtV
 YrOOI5VGLHge0awt7bhMCTM9KAfPc+xL/ZxAMVWd3NCk5SamL2cE99UWgtvNOIYU8m6EjTLhsj8sn
 VluJH0/RcxEeFbnSaswVChNSGa7mXJrTR22lRL6ZPjdMgS2Km90haWPRc8Wolcz07Y2se0xpGVLEQ
 cDEsvv5IMmeMe1/qLZ6NaVkNuL3WOXvxaVT9USW1+/SGipO2IpKJjeDZfehlB/kpfF24+RrK+seQf
 CBYyUE8QJpvTZyfUHNYldXlrjO6n5MdOempLqWpfOmcGkwnyNRBR46g/jf8KnPRwXs509yAqDB6sE
 LZH+yWr9LQZEwARAQABtCVKZWZmIExheXRvbiA8amxheXRvbkBwb29jaGllcmVkcy5uZXQ+iQI7BB
 MBAgAlAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAUCTpXWPAIZAQAKCRAADmhBGVaCFc65D/4
 gBLNMHopQYgG/9RIM3kgFCCQV0pLv0hcg1cjr+bPI5f1PzJoOVi9s0wBDHwp8+vtHgYhM54yt43uI
 7Htij0RHFL5eFqoVT4TSfAg2qlvNemJEOY0e4daljjmZM7UtmpGs9NN0r9r50W82eb5Kw5bc/r0km
 R/arUS2st+ecRsCnwAOj6HiURwIgfDMHGPtSkoPpu3DDp/cjcYUg3HaOJuTjtGHFH963B+f+hyQ2B
 rQZBBE76ErgTDJ2Db9Ey0kw7VEZ4I2nnVUY9B5dE2pJFVO5HJBMp30fUGKvwaKqYCU2iAKxdmJXRI
 ONb7dSde8LqZahuunPDMZyMA5+mkQl7kpIpR6kVDIiqmxzRuPeiMP7O2FCUlS2DnJnRVrHmCljLkZ
 Wf7ZUA22wJpepBligemtSRSbqCyZ3B48zJ8g5B8xLEntPo/NknSJaYRvfEQqGxgk5kkNWMIMDkfQO
 lDSXZvoxqU9wFH/9jTv1/6p8dHeGM0BsbBLMqQaqnWiVt5mG92E1zkOW69LnoozE6Le+12DsNW7Rj
 iR5K+27MObjXEYIW7FIvNN/TQ6U1EOsdxwB8o//Yfc3p2QqPr5uS93SDDan5ehH59BnHpguTc27Xi
 QQZ9EGiieCUx6Zh2ze3X2UW9YNzE15uKwkkuEIj60NvQRmEDfweYfOfPVOueC+iFifbQgSmVmZiBM
 YXl0b24gPGpsYXl0b25AcmVkaGF0LmNvbT6JAjgEEwECACIFAk6V0q0CGwMGCwkIBwMCBhUIAgkKC
 wQWAgMBAh4BAheAAAoJEAAOaEEZVoIViKUQALpvsacTMWWOd7SlPFzIYy2/fjvKlfB/Xs4YdNcf9q
 LqF+lk2RBUHdR/dGwZpvw/OLmnZ8TryDo2zXVJNWEEUFNc7wQpl3i78r6UU/GUY/RQmOgPhs3epQC
 3PMJj4xFx+VuVcf/MXgDDdBUHaCTT793hyBeDbQuciARDJAW24Q1RCmjcwWIV/pgrlFa4lAXsmhoa
 c8UPc82Ijrs6ivlTweFf16VBc4nSLX5FB3ls7S5noRhm5/Zsd4PGPgIHgCZcPgkAnU1S/A/rSqf3F
 LpU+CbVBDvlVAnOq9gfNF+QiTlOHdZVIe4gEYAU3CUjbleywQqV02BKxPVM0C5/oVjMVx3bri75n1
 TkBYGmqAXy9usCkHIsG5CBHmphv9MHmqMZQVsxvCzfnI5IO1+7MoloeeW/lxuyd0pU88dZsV/riHw
 87i2GJUJtVlMl5IGBNFpqoNUoqmvRfEMeXhy/kUX4Xc03I1coZIgmwLmCSXwx9MaCPFzV/dOOrju2
 xjO+2sYyB5BNtxRqUEyXglpujFZqJxxau7E0eXoYgoY9gtFGsspzFkVNntamVXEWVVgzJJr/EWW0y
 +jNd54MfPRqH+eCGuqlnNLktSAVz1MvVRY1dxUltSlDZT7P2bUoMorIPu8p7ZCg9dyX1+9T6Muc5d
 Hxf/BBP/ir+3e8JTFQBFOiLNdFtB9KZWZmIExheXRvbiA8amxheXRvbkBzYW1iYS5vcmc+iQI4BBM
 BAgAiBQJOldK9AhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRAADmhBGVaCFWgWD/0ZRi4h
 N9FK2BdQs9RwNnFZUr7JidAWfCrs37XrA/56olQl3ojn0fQtrP4DbTmCuh0SfMijB24psy1GnkPep
 naQ6VRf7Dxg/Y8muZELSOtsv2CKt3/02J1BBitrkkqmHyni5fLLYYg6fub0T/8Kwo1qGPdu1hx2BQ
 RERYtQ/S5d/T0cACdlzi6w8rs5f09hU9Tu4qV1JLKmBTgUWKN969HPRkxiojLQziHVyM/weR5Reu6
 FZVNuVBGqBD+sfk/c98VJHjsQhYJijcsmgMb1NohAzwrBKcSGKOWJToGEO/1RkIN8tqGnYNp2G+aR
 685D0chgTl1WzPRM6mFG1+n2b2RR95DxumKVpwBwdLPoCkI24JkeDJ7lXSe3uFWISstFGt0HL8Eew
 P8RuGC8s5h7Ct91HMNQTbjgA+Vi1foWUVXpEintAKgoywaIDlJfTZIl6Ew8ETN/7DLy8bXYgq0Xzh
 aKg3CnOUuGQV5/nl4OAX/3jocT5Cz/OtAiNYj5mLPeL5z2ZszjoCAH6caqsF2oLyAnLqRgDgR+wTQ
 T6gMhr2IRsl+cp8gPHBwQ4uZMb+X00c/Amm9VfviT+BI7B66cnC7Zv6Gvmtu2rEjWDGWPqUgccB7h
 dMKnKDthkA227/82tYoFiFMb/NwtgGrn5n2vwJyKN6SEoygGrNt0SI84y6hEVbQlSmVmZiBMYXl0b
 24gPGpsYXl0b25AcHJpbWFyeWRhdGEuY29tPokCOQQTAQIAIwUCU4xmKQIbAwcLCQgHAwIBBhUIAg
 kKCwQWAgMBAh4BAheAAAoJEAAOaEEZVoIV1H0P/j4OUTwFd7BBbpoSp695qb6HqCzWMuExsp8nZjr
 uymMaeZbGr3OWMNEXRI1FWNHMtcMHWLP/RaDqCJil28proO+PQ/yPhsr2QqJcW4nr91tBrv/MqItu
 AXLYlsgXqp4BxLP67bzRJ1Bd2x0bWXurpEXY//VBOLnODqThGEcL7jouwjmnRh9FTKZfBDpFRaEfD
 FOXIfAkMKBa/c9TQwRpx2DPsl3eFWVCNuNGKeGsirLqCxUg5kWTxEorROppz9oU4HPicL6rRH22Ce
 6nOAON2vHvhkUuO3GbffhrcsPD4DaYup4ic+DxWm+DaSSRJ+e1yJvwi6NmQ9P9UAuLG93S2MdNNbo
 sZ9P8k2mTOVKMc+GooI9Ve/vH8unwitwo7ORMVXhJeU6Q0X7zf3SjwDq2lBhn1DSuTsn2DbsNTiDv
 qrAaCvbsTsw+SZRwF85eG67eAwouYk+dnKmp1q57LDKMyzysij2oDKbcBlwB/TeX16p8+LxECv51a
 sjS9TInnipssssUDrHIvoTTXWcz7Y5wIngxDFwT8rPY3EggzLGfK5Zx2Q5S/N0FfmADmKknG/D8qG
 IcJE574D956tiUDKN4I+/g125ORR1v7bP+OIaayAvq17RP+qcAqkxc0x8iCYVCYDouDyNvWPGRhbL
 UO7mlBpjW9jK9e2fvZY9iw3QzIPGKtClKZWZmIExheXRvbiA8amVmZi5sYXl0b25AcHJpbWFyeWRh
 dGEuY29tPokCOQQTAQIAIwUCU4xmUAIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEAAOa
 EEZVoIVzJoQALFCS6n/FHQS+hIzHIb56JbokhK0AFqoLVzLKzrnaeXhE5isWcVg0eoV2oTScIwUSU
 apy94if69tnUo4Q7YNt8/6yFM6hwZAxFjOXR0ciGE3Q+Z1zi49Ox51yjGMQGxlakV9ep4sV/d5a50
 M+LFTmYSAFp6HY23JN9PkjVJC4PUv5DYRbOZ6Y1+TfXKBAewMVqtwT1Y+LPlfmI8dbbbuUX/kKZ5d
 dhV2736fgyfpslvJKYl0YifUOVy4D1G/oSycyHkJG78OvX4JKcf2kKzVvg7/Rnv+AueCfFQ6nGwPn
 0P91I7TEOC4XfZ6a1K3uTp4fPPs1Wn75X7K8lzJP/p8lme40uqwAyBjk+IA5VGd+CVRiyJTpGZwA0
 jwSYLyXboX+Dqm9pSYzmC9+/AE7lIgpWj+3iNisp1SWtHc4pdtQ5EU2SEz8yKvDbD0lNDbv4ljI7e
 flPsvN6vOrxz24mCliEco5DwhpaaSnzWnbAPXhQDWb/lUgs/JNk8dtwmvWnqCwRqElMLVisAbJmC0
 BhZ/Ab4sph3EaiZfdXKhiQqSGdK4La3OTJOJYZphPdGgnkvDV9Pl1QZ0ijXQrVIy3zd6VCNaKYq7B
 AKidn5g/2Q8oio9Tf4XfdZ9dtwcB+bwDJFgvvDYaZ5bI3ln4V3EyW5i2NfXazz/GA/I/ZtbsigCFc
 8ftCBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPokCOAQTAQIAIgUCWe8u6AIbAwYLCQg
 HAwIGFQgCCQoLBBYCAwECHgECF4AACgkQAA5oQRlWghUuCg/+Lb/xGxZD2Q1oJVAE37uW308UpVSD
 2tAMJUvFTdDbfe3zKlPDTuVsyNsALBGclPLagJ5ZTP+Vp2irAN9uwBuacBOTtmOdz4ZN2tdvNgozz
 uxp4CHBDVzAslUi2idy+xpsp47DWPxYFIRP3M8QG/aNW052LaPc0cedYxp8+9eiVUNpxF4SiU4i9J
 DfX/sn9XcfoVZIxMpCRE750zvJvcCUz9HojsrMQ1NFc7MFT1z3MOW2/RlzPcog7xvR5ENPH19ojRD
 CHqumUHRry+RF0lH00clzX/W8OrQJZtoBPXv9ahka/Vp7kEulcBJr1cH5Wz/WprhsIM7U9pse1f1g
 Yy9YbXtWctUz8uvDR7shsQxAhX3qO7DilMtuGo1v97I/Kx4gXQ52syh/w6EBny71CZrOgD6kJwPVV
 AaM1LRC28muq91WCFhs/nzHozpbzcheyGtMUI2Ao4K6mnY+3zIuXPygZMFr9KXE6fF7HzKxKuZMJO
 aEZCiDOq0anx6FmOzs5E6Jqdpo/mtI8beK+BE7Va6ni7YrQlnT0i3vaTVMTiCThbqsB20VrbMjlhp
 f8lfK1XVNbRq/R7GZ9zHESlsa35ha60yd/j3pu5hT2xyy8krV8vGhHvnJ1XRMJBAB/UYb6FyC7S+m
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-09-04 at 11:20 -0400, Chuck Lever wrote:
> On Thu, Aug 29, 2024 at 09:26:41AM -0400, Jeff Layton wrote:
> > This is always the same value, and in a later patch we're going to need
> > to set bits in WORD2. We can simplify this code and save a little space
> > in the delegation too. Just hardcode the bitmap in the callback encode
> > function.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>=20
> OK, lurching forward on this ;-)
>=20
>  - The first patch in v3 was applied to v6.11-rc.
>  - The second patch is now in nfsd-next.
>  - I've squashed the sixth and eighth patches into nfsd-next.
>=20
> I'm replying to this patch because this one seems like a step
> backwards to me: the bitmap values are implementation-dependent,
> and this code will eventually be automatically generated based only
> on the protocol, not the local implementation. IMO, architecturally,
> bitmap values should be set at the proc layer, not in the encoders.
>=20
> I've gone back and forth on whether to just go with it for now, but
> I thought I'd mention it here to see if this change is truly
> necessary for what follows. If it can't be replaced, I will suck it
> up and fix it up later when this encoder is converted to an xdrgen-
> manufactured one.

It's not truly necessary, but I don't see why it's important that we
keep a record of the full-blown bitmap here. The ncf_cb_bmap field is a
field in the delegation record, and it has to be carried around in
perpetuity. This value is always set by the server and there are only a
few legit bit combinations that can be set in it.

We certainly can keep this bitmap around, but as I said in the
description, the delstid draft grows this bitmap to 3 words, and if we
want to be a purists about storing a bitmap, then that will also
require us to keep the bitmap size (in another 32-bit word), since we
don't always want to set anything in the third word. That's already 24
extra bits per delegation, and we'll be adding new fields for the
timestamps in a later patch.

I don't see the benefit here.

> I've tried to apply a few of the following patches in this series,
> but by 9/13, things stop compiling. So I will let you rebase your
> work on the current nfsd-next and redrive it, and we can go from
> there.
>=20

Great. I'll rebase and re-test.

PS: I'm working on a couple of pynfs tests for CB_GETATTR as well. I'll
post them once I have them working. I've also found nfsd bugs in how we
currently proxy the attrs. I'll have patches for that in the next
posting (once my question on the IETF list is answered).

>=20
> > ---
> >  fs/nfsd/nfs4callback.c | 5 ++++-
> >  fs/nfsd/nfs4state.c    | 1 -
> >  fs/nfsd/state.h        | 1 -
> >  3 files changed, 4 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> > index b5b3ab9d719a..0c49e31d4350 100644
> > --- a/fs/nfsd/nfs4callback.c
> > +++ b/fs/nfsd/nfs4callback.c
> > @@ -364,10 +364,13 @@ encode_cb_getattr4args(struct xdr_stream *xdr, st=
ruct nfs4_cb_compound_hdr *hdr,
> >  	struct nfs4_delegation *dp =3D
> >  		container_of(fattr, struct nfs4_delegation, dl_cb_fattr);
> >  	struct knfsd_fh *fh =3D &dp->dl_stid.sc_file->fi_fhandle;
> > +	u32 bmap[1];
> > +
> > +	bmap[0] =3D FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE;
> > =20
> >  	encode_nfs_cb_opnum4(xdr, OP_CB_GETATTR);
> >  	encode_nfs_fh4(xdr, fh);
> > -	encode_bitmap4(xdr, fattr->ncf_cb_bmap, ARRAY_SIZE(fattr->ncf_cb_bmap=
));
> > +	encode_bitmap4(xdr, bmap, ARRAY_SIZE(bmap));
> >  	hdr->nops++;
> >  }
> > =20
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 8835930ecee6..6844ae9ea350 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -1183,7 +1183,6 @@ alloc_init_deleg(struct nfs4_client *clp, struct =
nfs4_file *fp,
> >  	nfsd4_init_cb(&dp->dl_cb_fattr.ncf_getattr, dp->dl_stid.sc_client,
> >  			&nfsd4_cb_getattr_ops, NFSPROC4_CLNT_CB_GETATTR);
> >  	dp->dl_cb_fattr.ncf_file_modified =3D false;
> > -	dp->dl_cb_fattr.ncf_cb_bmap[0] =3D FATTR4_WORD0_CHANGE | FATTR4_WORD0=
_SIZE;
> >  	get_nfs4_file(fp);
> >  	dp->dl_stid.sc_file =3D fp;
> >  	return dp;
> > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > index 79c743c01a47..ac3a29224806 100644
> > --- a/fs/nfsd/state.h
> > +++ b/fs/nfsd/state.h
> > @@ -138,7 +138,6 @@ struct nfs4_cpntf_state {
> >  struct nfs4_cb_fattr {
> >  	struct nfsd4_callback ncf_getattr;
> >  	u32 ncf_cb_status;
> > -	u32 ncf_cb_bmap[1];
> > =20
> >  	/* from CB_GETATTR reply */
> >  	u64 ncf_cb_change;
> >=20
> > --=20
> > 2.46.0
> >=20
>=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

