Return-Path: <linux-fsdevel+bounces-50722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE0DACEE88
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 13:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AFE51895925
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 11:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42C7204C07;
	Thu,  5 Jun 2025 11:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACZ2sZE8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69431F4631;
	Thu,  5 Jun 2025 11:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749122742; cv=none; b=HkPcKIdC3HYysnVRT/jkqzBOsFuaMutRzN8lz9/a8DRXXYww+9GR0LLjepyuizE5UmwgB76yYlFAOMox6ORcwd49V3GoERqWisHKj1X5p5rt4oOjbkbLnofbXQvT8zGVtGkuXoMGP8KDfy3BQB/DOyPKBd/UFdJLSUH8ECgw1/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749122742; c=relaxed/simple;
	bh=K7m9f6Rk6duKbjEN+EwDIR4mKg+jSwYRbzFNL2XGm5s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U7OFcpyz97SE5L37mK9/+cldaMYcbmQhr6D5ruu0Lus05Emu5LpA+DyGbS/WhTUjaOUhPcZ+Uu/q5xCLdAlvJlW+l+RS+UCINaZerrVncgmoZWeVudlmE/MDtU4L3aDsex04i0sRpOE+auC4QCsiQKdbucUMGAc6npBd1FyYR1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACZ2sZE8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC3FC4CEE7;
	Thu,  5 Jun 2025 11:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749122741;
	bh=K7m9f6Rk6duKbjEN+EwDIR4mKg+jSwYRbzFNL2XGm5s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ACZ2sZE8VQzcCub0RG1tMSKtg5yCHE2W/G1tE9YgrcMYYvA3qaODQp0T1QGdgOfzI
	 dq0NJ/FYnPtG5Y2J8WMcQryFA18KfxbOVnvlt2HpPzoa64/LxfWyPyqKis6NqFtjnV
	 PHWuFZqXV/XeQ4AIIbntYCGK3wXR3n4cnhukoMqjHH9ap5yCuYQvZkCDkUq1YQBGz7
	 QfnjRZwK3XwpNyZVxa6GhP9/iZ95Z4T0+dAqqf6btIJSJz00HCWP0or14I8uRgb+Li
	 mq4U0x7r9NI8aYl4L/3sIPVIwc9Zo1cxFLfgzBjq0TXqDqurx3Gn3B7oIv2seZAl1e
	 c2S+BTMGzvg4w==
Message-ID: <eeefb45bc67182971ae7d3c455a4ecfdec53d640.camel@kernel.org>
Subject: Re: [PATCH RFC v2 04/28] vfs: allow mkdir to wait for delegation
 break on parent
From: Jeff Layton <jlayton@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner	
 <brauner@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Alexander Aring
	 <alex.aring@gmail.com>, Trond Myklebust <trondmy@kernel.org>, Anna
 Schumaker	 <anna@kernel.org>, Steve French <sfrench@samba.org>, Paulo
 Alcantara	 <pc@manguebit.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Shyam Prasad N	 <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
 Bharath SM	 <bharathsm@microsoft.com>, NeilBrown <neil@brown.name>, Olga
 Kornievskaia	 <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Jonathan
 Corbet	 <corbet@lwn.net>, Amir Goldstein <amir73il@gmail.com>, Miklos
 Szeredi	 <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	linux-doc@vger.kernel.org
Date: Thu, 05 Jun 2025 07:25:38 -0400
In-Reply-To: <wqp4ruxfzv47xwz2fca5trvpwg7rxufvd3nlfiu5kfsasqzsih@lutnvxe4ri62>
References: <20250602-dir-deleg-v2-0-a7919700de86@kernel.org>
	 <20250602-dir-deleg-v2-4-a7919700de86@kernel.org>
	 <wqp4ruxfzv47xwz2fca5trvpwg7rxufvd3nlfiu5kfsasqzsih@lutnvxe4ri62>
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

On Thu, 2025-06-05 at 13:19 +0200, Jan Kara wrote:
> On Mon 02-06-25 10:01:47, Jeff Layton wrote:
> > In order to add directory delegation support, we need to break
> > delegations on the parent whenever there is going to be a change in the
> > directory.
> >=20
> > Rename the existing vfs_mkdir to __vfs_mkdir, make it static and add a
> > new delegated_inode parameter. Add a new exported vfs_mkdir wrapper
> > around it that passes a NULL pointer for delegated_inode.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>=20
> FWIW I went through the changes adding breaking of delegations to VFS
> directory functions and they look ok to me. Just I dislike the addition o=
f
> __vfs_mkdir() (and similar) helpers because over longer term the helpers
> tend to pile up and the maze of functions (already hard to follow in VFS)
> gets unwieldy. Either I'd try to give it a proper name or (if exposing th=
e
> functionality to the external world is fine - which seems it is) you coul=
d
> just add the argument to vfs_mkdir() and change all the callers? I've
> checked and for each of the modified functions there's less than 10 calle=
rs
> so the churn shouldn't be that big. What do others think?
>=20

Good point -- I'm always terrible with naming functions. I'm fine with
either approach, but just adding the argument does sound simple enough.
I'll plan to do that unless anyone objects.

Thanks for taking a look!

> 								Honza
>=20
> > ---
> >  fs/namei.c | 67 +++++++++++++++++++++++++++++++++++++++---------------=
--------
> >  1 file changed, 42 insertions(+), 25 deletions(-)
> >=20
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 0fea12860036162c01a291558e068fde9c986142..7c9e237ed1b1a535934ffe5=
e523424bb035e7ae0 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -4318,29 +4318,9 @@ SYSCALL_DEFINE3(mknod, const char __user *, file=
name, umode_t, mode, unsigned, d
> >  	return do_mknodat(AT_FDCWD, getname(filename), mode, dev);
> >  }
> > =20
> > -/**
> > - * vfs_mkdir - create directory returning correct dentry if possible
> > - * @idmap:	idmap of the mount the inode was found from
> > - * @dir:	inode of the parent directory
> > - * @dentry:	dentry of the child directory
> > - * @mode:	mode of the child directory
> > - *
> > - * Create a directory.
> > - *
> > - * If the inode has been found through an idmapped mount the idmap of
> > - * the vfsmount must be passed through @idmap. This function will then=
 take
> > - * care to map the inode according to @idmap before checking permissio=
ns.
> > - * On non-idmapped mounts or if permission checking is to be performed=
 on the
> > - * raw inode simply pass @nop_mnt_idmap.
> > - *
> > - * In the event that the filesystem does not use the *@dentry but leav=
es it
> > - * negative or unhashes it and possibly splices a different one return=
ing it,
> > - * the original dentry is dput() and the alternate is returned.
> > - *
> > - * In case of an error the dentry is dput() and an ERR_PTR() is return=
ed.
> > - */
> > -struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> > -			 struct dentry *dentry, umode_t mode)
> > +static struct dentry *__vfs_mkdir(struct mnt_idmap *idmap, struct inod=
e *dir,
> > +				  struct dentry *dentry, umode_t mode,
> > +				  struct inode **delegated_inode)
> >  {
> >  	int error;
> >  	unsigned max_links =3D dir->i_sb->s_max_links;
> > @@ -4363,6 +4343,10 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap=
, struct inode *dir,
> >  	if (max_links && dir->i_nlink >=3D max_links)
> >  		goto err;
> > =20
> > +	error =3D try_break_deleg(dir, delegated_inode);
> > +	if (error)
> > +		goto err;
> > +
> >  	de =3D dir->i_op->mkdir(idmap, dir, dentry, mode);
> >  	error =3D PTR_ERR(de);
> >  	if (IS_ERR(de))
> > @@ -4378,6 +4362,33 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap=
, struct inode *dir,
> >  	dput(dentry);
> >  	return ERR_PTR(error);
> >  }
> > +
> > +/**
> > + * vfs_mkdir - create directory returning correct dentry if possible
> > + * @idmap:	idmap of the mount the inode was found from
> > + * @dir:	inode of the parent directory
> > + * @dentry:	dentry of the child directory
> > + * @mode:	mode of the child directory
> > + *
> > + * Create a directory.
> > + *
> > + * If the inode has been found through an idmapped mount the idmap of
> > + * the vfsmount must be passed through @idmap. This function will then=
 take
> > + * care to map the inode according to @idmap before checking permissio=
ns.
> > + * On non-idmapped mounts or if permission checking is to be performed=
 on the
> > + * raw inode simply pass @nop_mnt_idmap.
> > + *
> > + * In the event that the filesystem does not use the *@dentry but leav=
es it
> > + * negative or unhashes it and possibly splices a different one return=
ing it,
> > + * the original dentry is dput() and the alternate is returned.
> > + *
> > + * In case of an error the dentry is dput() and an ERR_PTR() is return=
ed.
> > + */
> > +struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> > +			 struct dentry *dentry, umode_t mode)
> > +{
> > +	return __vfs_mkdir(idmap, dir, dentry, mode, NULL);
> > +}
> >  EXPORT_SYMBOL(vfs_mkdir);
> > =20
> >  int do_mkdirat(int dfd, struct filename *name, umode_t mode)
> > @@ -4386,6 +4397,7 @@ int do_mkdirat(int dfd, struct filename *name, um=
ode_t mode)
> >  	struct path path;
> >  	int error;
> >  	unsigned int lookup_flags =3D LOOKUP_DIRECTORY;
> > +	struct inode *delegated_inode =3D NULL;
> > =20
> >  retry:
> >  	dentry =3D filename_create(dfd, name, &path, lookup_flags);
> > @@ -4396,12 +4408,17 @@ int do_mkdirat(int dfd, struct filename *name, =
umode_t mode)
> >  	error =3D security_path_mkdir(&path, dentry,
> >  			mode_strip_umask(path.dentry->d_inode, mode));
> >  	if (!error) {
> > -		dentry =3D vfs_mkdir(mnt_idmap(path.mnt), path.dentry->d_inode,
> > -				  dentry, mode);
> > +		dentry =3D __vfs_mkdir(mnt_idmap(path.mnt), path.dentry->d_inode,
> > +				     dentry, mode, &delegated_inode);
> >  		if (IS_ERR(dentry))
> >  			error =3D PTR_ERR(dentry);
> >  	}
> >  	done_path_create(&path, dentry);
> > +	if (delegated_inode) {
> > +		error =3D break_deleg_wait(&delegated_inode);
> > +		if (!error)
> > +			goto retry;
> > +	}
> >  	if (retry_estale(error, lookup_flags)) {
> >  		lookup_flags |=3D LOOKUP_REVAL;
> >  		goto retry;
> >=20
> > --=20
> > 2.49.0
> >=20

--=20
Jeff Layton <jlayton@kernel.org>

