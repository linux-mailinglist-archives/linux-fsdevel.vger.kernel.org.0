Return-Path: <linux-fsdevel+bounces-34457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0906B9C59B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 14:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D7AC1F2378A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 13:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFE91FBF65;
	Tue, 12 Nov 2024 13:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udSp44gA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828FE1FBF4F;
	Tue, 12 Nov 2024 13:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731419842; cv=none; b=GTK6bklUUY5Omvq53b1X/iUky0rIbDwse2g+wZrUGV9aIlfz0IkEXZ6oxaUuAP4fqQbwnWm1z2/UHKwttFxfoL0vNkSRksZyCrQvT0Cm0A55Rbu1mFfqaboMOowJj3h0T68b2BvpWMp9jQIzYoCd36Gjclv+RrD2O2v6xbr77UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731419842; c=relaxed/simple;
	bh=a/EmdG3xpINbbr99embeoJSOzr6JZsMWfCtX8ybCVm8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Am2fw/M+oVXpdSdB4iw5LWe78Ff3RFD+sqOzBOX4hDCiLsQeN3wJ0mP6LSGVpQjTKtK/6+o3OWbcAruvqHILsuxg3H/aRWPkc28FzFEDodOCkyVeHp+HECg0dzZsygxvl4eLX50HeraXUVUx/CS/Q+hP25eHOZV+awSfOu7JEVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udSp44gA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3DBC4CECD;
	Tue, 12 Nov 2024 13:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731419842;
	bh=a/EmdG3xpINbbr99embeoJSOzr6JZsMWfCtX8ybCVm8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=udSp44gAcuLSgTdyf67lvLTk4NdbZtxspMb2/5gYXaPthAfqzAkj77EV8xTGWQ5z2
	 Feucj3VjMyWjG/GsZYVlVvDYKg7OBLmo44bazfZS0rVozASrtNGJf0WRTvfwj1U4ji
	 VXVn6Tk+uqrFktCo1RdyM06OF3q7nhHkX1EPtvjzM2aB+EiUOtVc76DqKYIV2VCU+b
	 XVfjAZGiqdlSe8ICwCl+gmtDdCHBFR4zOsXjhjSib87NMaVh65c1W6VvQUF77VGVKC
	 bKqNOB8lBlakMEcOMvM/nzoBWgvC3kq0J+WDIFwgkW7WsJ9p2bqjG4GJ04NuRY/RaE
	 b3I2Zi4ssgRxw==
Message-ID: <45e2da5392c07cfc139a014fbac512bfe14113a7.camel@kernel.org>
Subject: Re: [PATCH 0/4] pidfs: implement file handle support
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>, Erin Shepherd
 <erin.shepherd@e43.eu>,  Amir Goldstein <amir73il@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	christian@brauner.io, paul@paul-moore.com, bluca@debian.org, Chuck Lever
	 <chuck.lever@oracle.com>
Date: Tue, 12 Nov 2024 08:57:20 -0500
In-Reply-To: <20241112-banknoten-ehebett-211d59cb101e@brauner>
References: <20241101135452.19359-1-erin.shepherd@e43.eu>
	 <20241112-banknoten-ehebett-211d59cb101e@brauner>
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
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-11-12 at 14:10 +0100, Christian Brauner wrote:
> On Fri, Nov 01, 2024 at 01:54:48PM +0000, Erin Shepherd wrote:
> > Since the introduction of pidfs, we have had 64-bit process identifiers=
=20
> > that will not be reused for the entire uptime of the system. This great=
ly=20
> > facilitates process tracking in userspace.
> >=20
> > There are two limitations at present:
> >=20
> >  * These identifiers are currently only exposed to processes on 64-bit=
=20
> >    systems. On 32-bit systems, inode space is also limited to 32 bits a=
nd=20
> >    therefore is subject to the same reuse issues.

We should really just move to storing 64-bit inode numbers internally
on 32-bit machines. That would at least make statx() give you all 64
bits on 32-bit host.

> >  * There is no way to go from one of these unique identifiers to a pid =
or=20
> >    pidfd.
> >=20
> > Patch 1 & 2 in this stack implements fh_export for pidfs. This means=
=20
> > userspace  can retrieve a unique process identifier even on 32-bit syst=
ems=20
> > via name_to_handle_at.
> >=20
> > Patch 3 & 4 in this stack implement fh_to_dentry for pidfs. This means=
=20
> > userspace can convert back from a file handle to the corresponding pidf=
d.=20
> > To support us going from a file handle to a pidfd, we have to store a p=
id=20
> > inside the file handle. To ensure file handles are invariant and can mo=
ve=20
> > between pid namespaces, we stash a pid from the initial namespace insid=
e=20
> > the file handle.
> >=20
> > I'm not quite sure if stashing an initial-namespace pid inside the file=
=20
> > handle is the right approach here; if not, I think that patch 1 & 2 are=
=20
> > useful on their own.

Hmm... I guess pid namespaces don't have a convenient 64-bit ID like
mount namespaces do? In that case, stashing the pid from init_ns is
probably the next best thing.

>=20
> Sorry for the delayed reply (I'm recovering from a lengthy illness.).
>=20
> I like the idea in general. I think this is really useful. A few of my
> thoughts but I need input from Amir and Jeff:
>=20
> * In the last patch of the series you already implement decoding of
>   pidfd file handles by adding a .fh_to_dentry export_operations method.
>=20
>   There are a few things to consider because of how open_by_handle_at()
>   works.
>=20
>   - open_by_handle_at() needs to be restricted so it only creates pidfds
>     from pidfs file handles that resolve to a struct pid that is
>     reachable in the caller's pid namespace. In other words, it should
>     mirror pidfd_open().
>=20
>     Put another way, open_by_handle_at() must not be usable to open
>     arbitrary pids to prevent a container from constructing a pidfd file
>     handle for a process that lives outside it's pid namespace
>     hierarchy.
>=20
>     With this restriction in place open_by_handle_at() can be available
>     to let unprivileged processes open pidfd file handles.
>=20
>     Related to that, I don't think we need to make open_by_handle_at()
>     open arbitrary pidfd file handles via CAP_DAC_READ_SEARCH. Simply
>     because any process in the initial pid namespace can open any other
>     process via pidfd_open() anyway because pid namespaces are
>     hierarchical.
>=20
>     IOW, CAP_DAC_READ_SEARCH must not override the restriction that the
>     provided pidfs file handle must be reachable from the caller's pid
>     namespace.
>=20
>   - open_by_handle_at() uses may_decode_fh() to determine whether it's
>     possible to decode a file handle as an unprivileged user. The
>     current checks don't make sense for pidfs. Conceptually, I think
>     there don't need to place any restrictions based on global
>     CAP_DAC_READ_SEARCH, owning user namespace of the superblock or
>     mount on pidfs file handles.
>=20
>     The only restriction that matters is that the requested pidfs file
>     handle is reachable from the caller's pid namespace.
>
>   - A pidfd always has exactly a single inode and a single dentry.
>     There's no aliases.
>=20
>   - Generally, in my naive opinion, I think that decoding pidfs file
>     handles should be a lot simpler than decoding regular path based
>     file handles. Because there should be no need to verify any
>     ancestors, or reconnect paths. Pidfs also doesn't have directory
>     inodes, only regular inodes. In other words, any dentry is
>     acceptable.
>=20
>     Essentially, the only thing we need is for exportfs_decode_fh_raw()
>     to verify that the provided pidfs file handle is resolvable in the
>     caller's pid namespace. If so we're done. The challenge is how to
>     nicely plumb this into the code without it sticking out like a sore
>     thumb.
>=20
>   - Pidfs should not be exportable via NFS. It doesn't make sense.

I haven't looked over the patchset yet, but those restrictions all
sound pretty reasonable to me. Special casing the may_decode_fh
permission checks may be the tricky bit. I'm not sure what that should
look like, tbqh.

--=20
Jeff Layton <jlayton@kernel.org>

