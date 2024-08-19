Return-Path: <linux-fsdevel+bounces-26252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A511695697C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 13:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CC8228133A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 11:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9ADD166F21;
	Mon, 19 Aug 2024 11:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTTQBtTP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B932157A48;
	Mon, 19 Aug 2024 11:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724067598; cv=none; b=KrQCQFyDPrYpaA/q06T+sewIIw1puvTPZWytpUkAd6r0nmHPYrOlHucwE3fI1riWQGTtt/BxqOhRKzAlGiOQCb2vm42TyXHfzia0n4B9nHsnwJZVdUU8QKqXpqB01ZEpHE02FNy1jxmRc8UXv4RGK0UIZQVOTabJGBOmclzw0Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724067598; c=relaxed/simple;
	bh=O1hmigQhEU8ilJfC/vXhxyk/7Gxaju8oMFaI+ExkUho=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CV+dMDMEi3sIaFEN+iEwDH4qwLmSxLeuUqI/WTzMHjWGVxIycqjBa5EXGvMMzf9Fr89RWTMWueQXKCHL3Al1H06kfzURIFWW6CyBe2/t3gfU4j4Nfnfwk9RLrsNYGeyeS0k9eMjs223dT4KZy0yxOWLY7PV/7c1Fa98qK6oHgCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTTQBtTP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F174C32782;
	Mon, 19 Aug 2024 11:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724067597;
	bh=O1hmigQhEU8ilJfC/vXhxyk/7Gxaju8oMFaI+ExkUho=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=XTTQBtTPOy9gj1BYXEUzLDRAgafsvbO5Xzlai1pHBX7Y3ampmBF3TbLN9+ZOQ5LVs
	 CfEa6EQKo7pStI2FnNsvCMQwOoW8m/NzGdJzbFs0F7PkJDJGpVXvp/BtbdspK9BGwI
	 6eBtI15um5sUPUfZuWv0Pick7ZwK950Np9zWZ4LtFc2wI2Fr2lJQUX6qe4YcjYfVdM
	 5hMh0tgKPoQ9EB3ZA7E15U+C1z4Bxw5asd4t1FrnmCuoWYOhqz9nJJt9H7Y8nFrdT9
	 21vsh6YJhllTIODP0ZHW64OBs0pWFLnnFr6pScZCJbNb5BM7IWRIG3Tzi3NnzTVEtu
	 E3OGJ5xjS0qXg==
Message-ID: <4f1b6ce6cf5d9979e039141a3c824eb9420a56d5.camel@kernel.org>
Subject: Re: [PATCH fstests] generic/755: test that inode's ctime is updated
 on unlink
From: Jeff Layton <jlayton@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Date: Mon, 19 Aug 2024 07:39:56 -0400
In-Reply-To: <20240817055301.nisxjdvue6lasois@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240813-master-v1-1-862678cc4000@kernel.org>
	 <20240816125557.yu7664riqf4gvckl@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
	 <0fc76e7d49e8523d00f54fd5b50f24f040e7cf70.camel@kernel.org>
	 <20240817055301.nisxjdvue6lasois@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-08-17 at 13:53 +0800, Zorro Lang wrote:
> On Fri, Aug 16, 2024 at 08:58:28AM -0400, Jeff Layton wrote:
> > On Fri, 2024-08-16 at 20:55 +0800, Zorro Lang wrote:
> > > On Tue, Aug 13, 2024 at 02:21:08PM -0400, Jeff Layton wrote:
> > >=20
> > > Hi Jeff :)
> > >=20
> > > Any description about this case test for?
> > >=20
> >=20
> > Yes. I should have put that info in the commit. Can you add it if the
> > patch otherwise looks OK?
> >=20
> >     https://lore.kernel.org/linux-btrfs/20240812-btrfs-unlink-v1-1-ee5c=
2ef538eb@kernel.org/
>=20
> Hi Jeff,
>=20
> I saw this patch has gotten 3 RVBs, it's going to be in btrfs tree.
> I think it's good enough. BTW, you can add "_fixed_by_kernel_commit"
> to the test case, see below tests/generic/755 ...
>=20
> By reading above link, I think this issue doesn't need a C program (to
> reproduce), it can be done in bash script. e.g.
>=20
> # touch file
> # link file linkfile
> # ctime1=3D$(stat -c %Z file)
> # sleep 2
> # ctime2=3D$(stat -c %Z file)
> # if [ "$ctime1" =3D=3D "$ctime2" ];then ....
>=20
> Does that make sense to you?
>=20

It does. I was trying to replicate the original report which showed
that we didn't update the ctime when unlinking the last dentry on an
inode, but this should replicate the btrfs bug just as well.

I'm fine with going this route if it's what you'd prefer. Let me know.

> >=20
> > Thanks,
> >=20
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > > HCH suggested I roll a fstest for this problem that I found in btrf=
s the
> > > > other day. In principle, we probably could expand this to other dir
> > > > operations and to check the parent timestamps, but having to do all=
 that
> > > > in C is a pain.  I didn't see a good way to use xfs_io for this,
> > > > however.
> > >=20
> > > Is there a kernel commit or patch link about the bug which you found?
> > >=20
> > > > ---
> > > >  src/Makefile          |  2 +-
> > > >  src/unlink-ctime.c    | 50 +++++++++++++++++++++++++++++++++++++++=
+++++++++++
> > > >  tests/generic/755     | 26 ++++++++++++++++++++++++++
> > > >  tests/generic/755.out |  2 ++
> > > >  4 files changed, 79 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/src/Makefile b/src/Makefile
> > > > index 9979613711c9..c71fa41e4668 100644
> > > > --- a/src/Makefile
> > > > +++ b/src/Makefile
> > > > @@ -34,7 +34,7 @@ LINUX_TARGETS =3D xfsctl bstat t_mtab getdevicesi=
ze preallo_rw_pattern_reader \
> > > >  	attr_replace_test swapon mkswap t_attr_corruption t_open_tmpfiles=
 \
> > > >  	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail=
 \
> > > >  	detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
> > > > -	uuid_ioctl t_snapshot_deleted_subvolume fiemap-fault
> > > > +	uuid_ioctl t_snapshot_deleted_subvolume fiemap-fault unlink-ctime
> > >=20
> > > The .gitignore need updating too.
>=20
> [need changing]
>=20
> > >=20
> > > > =20
> > > >  EXTRA_EXECS =3D dmerror fill2attr fill2fs fill2fs_check scaleread.=
sh \
> > > >  	      btrfs_crc32c_forged_name.py popdir.pl popattr.py \
> > > > diff --git a/src/unlink-ctime.c b/src/unlink-ctime.c
> > > > new file mode 100644
> > > > index 000000000000..7661e340eaba
> > > > --- /dev/null
> > > > +++ b/src/unlink-ctime.c
> > > > @@ -0,0 +1,50 @@
> > > > +#define _GNU_SOURCE 1
> > > > +#include <stdio.h>
> > > > +#include <fcntl.h>
> > > > +#include <unistd.h>
> > > > +#include <errno.h>
> > > > +#include <sys/stat.h>
> > > > +
> > > > +int main(int argc, char **argv)
> > > > +{
> > > > +	int fd, ret;
> > > > +	struct statx before, after;
> > > > +
> > > > +	if (argc < 2) {
> > > > +		fprintf(stderr, "Must specify filename!\n");
> > > > +		return 1;
> > > > +	}
> > > > +
> > > > +	fd =3D open(argv[1], O_RDWR|O_CREAT, 0600);
> > > > +	if (fd < 0) {
> > > > +		perror("open");
> > > > +		return 1;
> > > > +	}
> > > > +
> > > > +	ret =3D statx(fd, "", AT_EMPTY_PATH, STATX_CTIME, &before);
> > > > +	if (ret) {
> > > > +		perror("statx");
> > > > +		return 1;
> > > > +	}
> > > > +
> > > > +	sleep(1);
> > > > +
> > > > +	ret =3D unlink(argv[1]);
> > > > +	if (ret) {
> > > > +		perror("unlink");
> > > > +		return 1;
> > > > +	}
> > > > +
> > > > +	ret =3D statx(fd, "", AT_EMPTY_PATH, STATX_CTIME, &after);
> > >=20
> > > So you need to keep the "fd" after unlink. If so, there might not be =
a
> > > way through xfs_io to do that.
> > >=20
> > > > +	if (ret) {
> > > > +		perror("statx");
> > > > +		return 1;
> > > > +	}
> > > > +
> > > > +	if (before.stx_ctime.tv_nsec =3D=3D after.stx_ctime.tv_nsec &&
> > > > +	    before.stx_ctime.tv_sec =3D=3D after.stx_ctime.tv_sec) {
> > > > +		printf("No change to ctime after unlink!\n");
> > > > +		return 1;
> > > > +	}
> > > > +	return 0;
> > > > +}
> > > > diff --git a/tests/generic/755 b/tests/generic/755
> > > > new file mode 100755
> > > > index 000000000000..500c51f99630
> > > > --- /dev/null
> > > > +++ b/tests/generic/755
> > > > @@ -0,0 +1,26 @@
> > > > +#! /bin/bash
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +# Copyright (c) 2024, Jeff Layton <jlayton@kernel.org>
> > > > +#
> > > > +# FS QA Test No. 755
> > > > +#
> > > > +# Create a file, stat it and then unlink it. Does the ctime of the
> > > > +# target inode change?
> > > > +#
> > > > +. ./common/preamble
> > > > +_begin_fstest auto quick
> > >                              ^^^^^^
> > >                              unlink
>=20
> [need changing]
>=20
> > >=20
> > > > +
> > > > +# Import common functions.
> > > > +. ./common/filter
> > > > +. ./common/dmerror
> > >=20
> > > Why dmerror and filter are needed? If not necessary, remove these
> > > 3 lines.
>=20
> [need changing]
>=20
> > >=20
> > > Others looks good to me.
> > >=20
> > > Thanks,
> > > Zorro
> > >=20
> > > > +
> > > > +_require_test
> > > > +_require_test_program unlink-ctime
>=20
>   _fixed_by_kernel_commit XXXXXXXXXXXX btrfs: update target inode's ctime=
 on unlink
>=20
> > > > +
> > > > +testfile=3D"$TEST_DIR/unlink-ctime.$$"
> > > > +
> > > > +$here/src/unlink-ctime $testfile
> > > > +
> > > > +echo Silence is golden
> > > > +status=3D0
> > > > +exit
> > > > diff --git a/tests/generic/755.out b/tests/generic/755.out
> > > > new file mode 100644
> > > > index 000000000000..7c9ea51cd298
> > > > --- /dev/null
> > > > +++ b/tests/generic/755.out
> > > > @@ -0,0 +1,2 @@
> > > > +QA output created by 755
> > > > +Silence is golden
> > > >=20
> > > > ---
> > > > base-commit: f5ada754d5838d29fd270257003d0d123a9d1cd2
> > > > change-id: 20240813-master-e3b46de630bd
> > > >=20
> > > > Best regards,
> > > > --=20
> > > > Jeff Layton <jlayton@kernel.org>
> > > >=20
> > > >=20
> > >=20
> >=20
> > --=20
> > Jeff Layton <jlayton@kernel.org>
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

