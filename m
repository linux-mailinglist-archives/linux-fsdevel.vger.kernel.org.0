Return-Path: <linux-fsdevel+bounces-56089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DBDB12BF6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 21:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7245A1C22EB5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 19:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23B0289355;
	Sat, 26 Jul 2025 19:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8JOCxiV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F80D63CF;
	Sat, 26 Jul 2025 19:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753556636; cv=none; b=OaidyM4b3TBlOaLe6XjBDfc/J6k0D49Dg6tRpKEKy4ntD8+ma/MnKlYVM/fZ+smO/B48EqJrxKWaD0CEtBfVO9iqrdn7NWytKCdoqdk7Vv9VtoEok97Kk1Os/nqjS5mejtrBfW+Mko47rrF4wnCTwfWqSFirI7BOJlGPHpx6PoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753556636; c=relaxed/simple;
	bh=2pVPFrfvVgYBx36XlOKsAM8yFf3e5hfXbP8daZjDeAI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U/+/68/ZZnj6rtG/wpbRVpBJVJ0U+3krcq/fj+/3Dj524BsaaZ/PmZRGNUz9QXUWMv1+yrnIslRKSTLqINHyipLkgO3yJFaSul6ya8vlqBA+7qTOD+6831vb8YxG/gJiGGG34UH7g+xVetSe3/+cnrstbTBjfmRqqSJQA/nSXeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8JOCxiV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0DBC4CEED;
	Sat, 26 Jul 2025 19:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753556635;
	bh=2pVPFrfvVgYBx36XlOKsAM8yFf3e5hfXbP8daZjDeAI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=E8JOCxiV9nrIWoFxUMRQo0GRb+9IDPSvj34WtOGK227fH2er4N5O61AYPsQXEDwE0
	 9nlmyah70hlgTJJQ5cVDje+wot4Vfb8aHBLIGXhC0fu1CUB6Kgp+LZt93thf4g/7dk
	 18ElVi1a/0WPJlFRnvTR3lmMUMeArrHHT3Lw1dtpwPMHqgNwIil1LFJShVetygQz3A
	 uoqL1MrleSFJzOQXDS7VfDtTdTb3eVflum7quLP699Rh/n7s4VotadZflvFAQ4vkK0
	 bCPyezi9/n93lJ4HKJEXvqkJ8SSK35Ppgy2iUk8YYYthUENhyTmNHVz69At+1z28R5
	 KnnjtfIwlnbDg==
Message-ID: <8ec5b19dc1d0ce26f1cd86d7db2ba5a2d260c073.camel@kernel.org>
Subject: Re: [PATCH v2 3/7] nfsd: use ATTR_CTIME_SET for delegated ctime
 updates
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Alexander Viro	
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
	 <jack@suse.cz>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu	
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai
 Ngo <Dai.Ngo@oracle.com>,  Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@hammerspace.com>, Anna Schumaker
 <anna@kernel.org>, 	linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-trace-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org
Date: Sat, 26 Jul 2025 15:03:53 -0400
In-Reply-To: <5f877de4-347c-484c-814f-33c08f1a5189@oracle.com>
References: <20250726-nfsd-testing-v2-0-f45923db2fbb@kernel.org>
	 <20250726-nfsd-testing-v2-3-f45923db2fbb@kernel.org>
	 <5f877de4-347c-484c-814f-33c08f1a5189@oracle.com>
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
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-07-26 at 14:48 -0400, Chuck Lever wrote:
> Hi Jeff -
>=20
> Thanks again for your focus on getting this straightened out!
>=20
>=20
> On 7/26/25 10:31 AM, Jeff Layton wrote:
> > Ensure that notify_change() doesn't clobber a delegated ctime update
> > with current_time() by setting ATTR_CTIME_SET for those updates.
> >=20
> > Also, set the tv_nsec field the nfsd4_decode_fattr4 to the correct
> > value.
>=20
> I don't yet see the connection of the above tv_nsec fix to the other
> changes in this patch. Wouldn't this be an independent fix?
>=20

I felt like they were related. Yes, the ia_ctime field is currently
being set wrong, but it's also being clobbered by notify_change(), so
it doesn't matter much. I can break this into a separate patch (with a
Fixes: tag) if you prefer though.

> > Don't bother setting the timestamps in cb_getattr_update_times() in the
> > non-delegated case. notify_change() will do that itself.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>=20
> General comments:
>=20
> I don't feel that any of the patches in this series need to be tagged
> for stable, since there is already a Kconfig setting that defaults to
> leaving timestamp delegation disabled. But I would like to see Fixes:
> tags, where that makes sense?
>=20

I don't think any of these need to go to stable since this is still
under a non-default Kconfig option, and the main effect of the bug is
wonky timestamps. I should be able to add some Fixes: tags though.

> Is this set on top of the set you posted a day or two ago with the new
> trace point? Or does this set replace that one?
>=20

This set should replace those.

>=20
> > ---
> >  fs/nfsd/nfs4state.c | 6 +++---
> >  fs/nfsd/nfs4xdr.c   | 5 +++--
> >  2 files changed, 6 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 88c347957da5b8f352be63f84f207d2225f81cb9..77eea2ad93cc07939f045fc=
4b983b1ac00d068b8 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -9167,7 +9167,6 @@ static bool set_cb_time(struct timespec64 *cb, co=
nst struct timespec64 *orig,
> >  static int cb_getattr_update_times(struct dentry *dentry, struct nfs4_=
delegation *dp)
> >  {
> >  	struct inode *inode =3D d_inode(dentry);
> > -	struct timespec64 now =3D current_time(inode);
> >  	struct nfs4_cb_fattr *ncf =3D &dp->dl_cb_fattr;
> >  	struct iattr attrs =3D { };
> >  	int ret;
> > @@ -9175,6 +9174,7 @@ static int cb_getattr_update_times(struct dentry =
*dentry, struct nfs4_delegation
> >  	if (deleg_attrs_deleg(dp->dl_type)) {
> >  		struct timespec64 atime =3D inode_get_atime(inode);
> >  		struct timespec64 mtime =3D inode_get_mtime(inode);
> > +		struct timespec64 now =3D current_time(inode);
> > =20
> >  		attrs.ia_atime =3D ncf->ncf_cb_atime;
> >  		attrs.ia_mtime =3D ncf->ncf_cb_mtime;
> > @@ -9183,12 +9183,12 @@ static int cb_getattr_update_times(struct dentr=
y *dentry, struct nfs4_delegation
> >  			attrs.ia_valid |=3D ATTR_ATIME | ATTR_ATIME_SET;
> > =20
> >  		if (set_cb_time(&attrs.ia_mtime, &mtime, &now)) {
> > -			attrs.ia_valid |=3D ATTR_CTIME | ATTR_MTIME | ATTR_MTIME_SET;
> > +			attrs.ia_valid |=3D ATTR_CTIME | ATTR_CTIME_SET |
> > +					  ATTR_MTIME | ATTR_MTIME_SET;
> >  			attrs.ia_ctime =3D attrs.ia_mtime;
> >  		}
> >  	} else {
> >  		attrs.ia_valid |=3D ATTR_MTIME | ATTR_CTIME;
> > -		attrs.ia_mtime =3D attrs.ia_ctime =3D now;
> >  	}
> > =20
> >  	if (!attrs.ia_valid)
> > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > index 8b68f74a8cf08c6aa1305a2a3093467656085e4a..c0a3c6a7c8bb70d62940115=
c3101e9f897401456 100644
> > --- a/fs/nfsd/nfs4xdr.c
> > +++ b/fs/nfsd/nfs4xdr.c
> > @@ -538,8 +538,9 @@ nfsd4_decode_fattr4(struct nfsd4_compoundargs *argp=
, u32 *bmval, u32 bmlen,
> >  		iattr->ia_mtime.tv_sec =3D modify.seconds;
> >  		iattr->ia_mtime.tv_nsec =3D modify.nseconds;
> >  		iattr->ia_ctime.tv_sec =3D modify.seconds;
> > -		iattr->ia_ctime.tv_nsec =3D modify.seconds;
> > -		iattr->ia_valid |=3D ATTR_CTIME | ATTR_MTIME | ATTR_MTIME_SET | ATTR=
_DELEG;
> > +		iattr->ia_ctime.tv_nsec =3D modify.nseconds;
> > +		iattr->ia_valid |=3D ATTR_CTIME | ATTR_CTIME_SET |
> > +				   ATTR_MTIME | ATTR_MTIME_SET | ATTR_DELEG;
> >  	}
> > =20
> >  	/* request sanity: did attrlist4 contain the expected number of words=
? */
> >=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

