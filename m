Return-Path: <linux-fsdevel+bounces-26136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5AC954DAC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 17:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1BBE1C23F40
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 15:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985811BDAA2;
	Fri, 16 Aug 2024 15:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D33G72Bb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EE31BDA86
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 15:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723822251; cv=none; b=fpSq+ftYAdZkjka+lWnH4hvmxFRAnVolSvehO+LF1BYM0dGGuOJgXf0mEiH3KjcGGKm63+zO3djvEtVuHFl5i6pig6bEZhIQkQN/d8jZ4pzukkD8wOf4rRQGL11iO/9JpSswRjdA5xi7ZgeQmSiGU4ZRmhJw4XBxAdw7IAzVSN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723822251; c=relaxed/simple;
	bh=FmQ63BOTG2vOZxsGt3n+0RccnVhla5GmD9jiRwYMQ24=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O22wML84rGwMs4PRnCfjSEMyvoXk4bLl0WSJdVJ7yiy6DRVXrKIQr3bmG/u5PFDMEhC0LYWRTb18wmEWKO5T0Cmb36p3BYJ2vu0DOOPoKsVBMHqX9o7nRE824fItbvFA3SHn8Loyt/DCWc1H8zjZh2KZQxhk6ouiEQDXurKo+to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D33G72Bb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1816BC32782;
	Fri, 16 Aug 2024 15:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723822250;
	bh=FmQ63BOTG2vOZxsGt3n+0RccnVhla5GmD9jiRwYMQ24=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=D33G72BbWokxC5BDKhfsXQNZgjDBLa2qa8qJvX/5rf9MKq88iHmZkVRxBhPG5foQn
	 srJ7VPb6/O/21s1Ns43do703o3Ha58SLG31dNu8s9tD6aKkgxoP3ihq8QJRB82fUzk
	 0s7ouAhyV/evZ4Wki4Xndi6pQp3yT0U/KOdSuirIGmV/mPA5Xv5/8pHHhEzZ8gTEbx
	 mxwB5A0I2O3Ejajxa+0N1l7PGzhCOPmFxkhSu51kHBnww0lR3/du/O0B1a5WizSl+G
	 +14OqRTBOiGc3nxb7SWUT1pY7sRqnGr2NB3Fyo00jBPvrx0Ou7GFexFUun0y3/6M1r
	 fnnGujFpg1uWA==
Message-ID: <f8fcab3819bba1aa9cdb7366ddbd5542082064b1.camel@kernel.org>
Subject: Re: [PATCH] inode: remove __I_DIO_WAKEUP
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>, David Howells <dhowells@redhat.com>
Date: Fri, 16 Aug 2024 11:30:48 -0400
In-Reply-To: <20240816-vfs-misc-dio-v1-1-80fe21a2c710@kernel.org>
References: <20240816-vfs-misc-dio-v1-1-80fe21a2c710@kernel.org>
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

On Fri, 2024-08-16 at 16:35 +0200, Christian Brauner wrote:
> Afaict, we can just rely on inode->i_dio_count for waiting instead of
> this awkward indirection through __I_DIO_WAKEUP. This survives LTP
> dio
> and xfstests dio tests.
>=20
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
> ---
> =C2=A0fs/inode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 23 +++=
++++++++------------
> =C2=A0fs/netfs/locking.c | 18 +++---------------
> =C2=A0include/linux/fs.h |=C2=A0 9 ++++-----
> =C2=A03 files changed, 18 insertions(+), 32 deletions(-)
>=20
> diff --git a/fs/inode.c b/fs/inode.c
> index 7a4e27606fca..46bf05d826db 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2465,18 +2465,12 @@ EXPORT_SYMBOL(inode_owner_or_capable);
> =C2=A0/*
> =C2=A0 * Direct i/o helper functions
> =C2=A0 */
> -static void __inode_dio_wait(struct inode *inode)
> +bool inode_dio_finished(const struct inode *inode)
> =C2=A0{
> -	wait_queue_head_t *wq =3D bit_waitqueue(&inode->i_state,
> __I_DIO_WAKEUP);
> -	DEFINE_WAIT_BIT(q, &inode->i_state, __I_DIO_WAKEUP);
> -
> -	do {
> -		prepare_to_wait(wq, &q.wq_entry,
> TASK_UNINTERRUPTIBLE);
> -		if (atomic_read(&inode->i_dio_count))
> -			schedule();
> -	} while (atomic_read(&inode->i_dio_count));
> -	finish_wait(wq, &q.wq_entry);
> +	smp_mb__before_atomic();
> +	return atomic_read(&inode->i_dio_count) =3D=3D 0;
> =C2=A0}
> +EXPORT_SYMBOL(inode_dio_finished);
> =C2=A0
> =C2=A0/**
> =C2=A0 * inode_dio_wait - wait for outstanding DIO requests to finish
> @@ -2490,11 +2484,16 @@ static void __inode_dio_wait(struct inode
> *inode)
> =C2=A0 */
> =C2=A0void inode_dio_wait(struct inode *inode)
> =C2=A0{
> -	if (atomic_read(&inode->i_dio_count))
> -		__inode_dio_wait(inode);
> +	wait_var_event(&inode->i_dio_count, inode_dio_finished);
> =C2=A0}
> =C2=A0EXPORT_SYMBOL(inode_dio_wait);
> =C2=A0
> +void inode_dio_wait_interruptible(struct inode *inode)
> +{
> +	wait_var_event_interruptible(&inode->i_dio_count,
> inode_dio_finished);
> +}
> +EXPORT_SYMBOL(inode_dio_wait_interruptible);
> +
> =C2=A0/*
> =C2=A0 * inode_set_flags - atomically set some inode flags
> =C2=A0 *
> diff --git a/fs/netfs/locking.c b/fs/netfs/locking.c
> index 75dc52a49b3a..c2cfdda85230 100644
> --- a/fs/netfs/locking.c
> +++ b/fs/netfs/locking.c
> @@ -21,23 +21,11 @@
> =C2=A0 */
> =C2=A0static int inode_dio_wait_interruptible(struct inode *inode)
> =C2=A0{
> -	if (!atomic_read(&inode->i_dio_count))
> +	if (inode_dio_finished(inode))
> =C2=A0		return 0;
> =C2=A0
> -	wait_queue_head_t *wq =3D bit_waitqueue(&inode->i_state,
> __I_DIO_WAKEUP);
> -	DEFINE_WAIT_BIT(q, &inode->i_state, __I_DIO_WAKEUP);
> -
> -	for (;;) {
> -		prepare_to_wait(wq, &q.wq_entry,
> TASK_INTERRUPTIBLE);
> -		if (!atomic_read(&inode->i_dio_count))
> -			break;
> -		if (signal_pending(current))
> -			break;
> -		schedule();
> -	}
> -	finish_wait(wq, &q.wq_entry);
> -
> -	return atomic_read(&inode->i_dio_count) ? -ERESTARTSYS : 0;
> +	inode_dio_wait_interruptible(inode);
> +	return !inode_dio_finished(inode) ? -ERESTARTSYS : 0;
> =C2=A0}
> =C2=A0
> =C2=A0/* Call with exclusively locked inode->i_rwsem */
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index b6f2e2a1e513..f744cd918259 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2380,8 +2380,6 @@ static inline void kiocb_clone(struct kiocb
> *kiocb, struct kiocb *kiocb_src,
> =C2=A0 *
> =C2=A0 * I_REFERENCED		Marks the inode as recently
> references on the LRU list.
> =C2=A0 *
> - * I_DIO_WAKEUP		Never set.=C2=A0 Only used as a key for
> wait_on_bit().
> - *
> =C2=A0 * I_WB_SWITCH		Cgroup bdi_writeback switching in progress.=C2=A0
> Used to
> =C2=A0 *			synchronize competing switching instances
> and to tell
> =C2=A0 *			wb stat updates to grab the i_pages lock.=C2=A0
> See
> @@ -2413,8 +2411,6 @@ static inline void kiocb_clone(struct kiocb
> *kiocb, struct kiocb *kiocb_src,
> =C2=A0#define __I_SYNC		7
> =C2=A0#define I_SYNC			(1 << __I_SYNC)
> =C2=A0#define I_REFERENCED		(1 << 8)
> -#define __I_DIO_WAKEUP		9
> -#define I_DIO_WAKEUP		(1 << __I_DIO_WAKEUP)
> =C2=A0#define I_LINKABLE		(1 << 10)
> =C2=A0#define I_DIRTY_TIME		(1 << 11)
> =C2=A0#define I_WB_SWITCH		(1 << 13)
> @@ -3230,6 +3226,7 @@ static inline ssize_t blockdev_direct_IO(struct
> kiocb *iocb,
> =C2=A0#endif
> =C2=A0
> =C2=A0void inode_dio_wait(struct inode *inode);
> +void inode_dio_wait_interruptible(struct inode *inode);
> =C2=A0
> =C2=A0/**
> =C2=A0 * inode_dio_begin - signal start of a direct I/O requests
> @@ -3241,6 +3238,7 @@ void inode_dio_wait(struct inode *inode);
> =C2=A0static inline void inode_dio_begin(struct inode *inode)
> =C2=A0{
> =C2=A0	atomic_inc(&inode->i_dio_count);
> +	smp_mb__after_atomic();
> =C2=A0}
> =C2=A0
> =C2=A0/**
> @@ -3252,8 +3250,9 @@ static inline void inode_dio_begin(struct inode
> *inode)
> =C2=A0 */
> =C2=A0static inline void inode_dio_end(struct inode *inode)
> =C2=A0{
> +	smp_mb__before_atomic();
> =C2=A0	if (atomic_dec_and_test(&inode->i_dio_count))
> -		wake_up_bit(&inode->i_state, __I_DIO_WAKEUP);
> +		wake_up_var(&inode->i_dio_count);
> =C2=A0}
> =C2=A0
> =C2=A0extern void inode_set_flags(struct inode *inode, unsigned int flags=
,
>=20
> ---
> base-commit: 5570f04d0bb1a34ebcb27caac76c797a7c9e36c9
> change-id: 20240816-vfs-misc-dio-5cb07eaae155
>=20

Nice cleanup!

Reviewed-by: Jeff Layton <jlayton@kernel.org>

