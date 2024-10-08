Return-Path: <linux-fsdevel+bounces-31359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6209F995650
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 20:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1356B21CA9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 18:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42248212644;
	Tue,  8 Oct 2024 18:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLs0bV1F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A060420B20;
	Tue,  8 Oct 2024 18:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728411567; cv=none; b=JVX7MmlZqLFf8tK9fexEDvFsV48VzIiqy6yP8ImH7M2J8Q8zTlF5G9jZDaxWYs+c5KKFZCF8Rpx/Zqbn6oM+fqw+8FAnp1iVLRMgCUbpHk3Z10PdA5QZQ6lw8+XMzceiwHdy1gqBdsfuNntSqcdLA1gcLqGgMB63tXhPjnaFIZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728411567; c=relaxed/simple;
	bh=z54KckxhgJG3g7xIM1xPAckD2eOaytBEiXST0+QTFi8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RbxwXJIbpOBQeAFJLGUTqIJdbNIEZwDU1DYbPyru1ogYKemYT+EGbAzuxB8dJja3WR47cF+LQ8cTNuKWkawFgLhIDfYU7nYwqPhvWap570vC2PucO1aj268UiRzI2RWBwj6RhWLQv3EzZw5y1KXd3Zce/eRlLK6gLlD1mjHScrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLs0bV1F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB3FC4CEC7;
	Tue,  8 Oct 2024 18:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728411567;
	bh=z54KckxhgJG3g7xIM1xPAckD2eOaytBEiXST0+QTFi8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=JLs0bV1F3aUUl1juIVgv1kMHK/xtpxJPD91j5csNJEONaEBx7Sx6IiGMVo0b+zSv/
	 IQy2DRQNoHAf8kvZbyRsaDvYiOZ18ww7oOnNlnpOIATEGjKgEdWH8NSxcRl/z/BBk6
	 FQ3hLKIUq3IHn/PfmoKsgrM6TNBPoxJJz097Z9MqIg3gWDIYVMLPmDXSfm+glQHrqp
	 rnWwZf/4kfRVaUJxHAeqqmnEX9gyGQGu9SHHTj7lw2LoTAnx9Xl1kLdkPAPmMHGPEk
	 4xJYdvSJUqNJhAZF7KwpbrrQ52G/U+PbX3GPWRrGviUyd2gUw4JadxGL7TPawF73WR
	 2x1mlC2/LFsUA==
Message-ID: <b2df96ad86950b4b3a790f68be99df845a6a2108.camel@kernel.org>
Subject: Re: [PATCH v3 1/3] fs: prepare for "explicit connectable" file
 handles
From: Jeff Layton <jlayton@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Aleksa
 Sarai <cyphar@cyphar.com>, Chuck Lever <chuck.lever@oracle.com>, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Date: Tue, 08 Oct 2024 14:19:25 -0400
In-Reply-To: <20241008152118.453724-2-amir73il@gmail.com>
References: <20241008152118.453724-1-amir73il@gmail.com>
	 <20241008152118.453724-2-amir73il@gmail.com>
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

On Tue, 2024-10-08 at 17:21 +0200, Amir Goldstein wrote:
> We would like to use the high 16bit of the handle_type field to encode
> file handle traits, such as "connectable".
>=20
> In preparation for this change, make sure that filesystems do not return
> a handle_type value with upper bits set and that the open_by_handle_at(2)
> syscall rejects these handle types.
>=20
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/exportfs/expfs.c      | 14 ++++++++++++--
>  fs/fhandle.c             |  6 ++++++
>  include/linux/exportfs.h | 14 ++++++++++++++
>  3 files changed, 32 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
> index 4f2dd4ab4486..c8eb660fdde4 100644
> --- a/fs/exportfs/expfs.c
> +++ b/fs/exportfs/expfs.c
> @@ -382,14 +382,21 @@ int exportfs_encode_inode_fh(struct inode *inode, s=
truct fid *fid,
>  			     int *max_len, struct inode *parent, int flags)
>  {
>  	const struct export_operations *nop =3D inode->i_sb->s_export_op;
> +	enum fid_type type;
> =20
>  	if (!exportfs_can_encode_fh(nop, flags))
>  		return -EOPNOTSUPP;
> =20
>  	if (!nop && (flags & EXPORT_FH_FID))
> -		return exportfs_encode_ino64_fid(inode, fid, max_len);
> +		type =3D exportfs_encode_ino64_fid(inode, fid, max_len);
> +	else
> +		type =3D nop->encode_fh(inode, fid->raw, max_len, parent);
> +
> +	if (WARN_ON_ONCE(FILEID_USER_FLAGS(type)))
> +		return -EINVAL;
> +

The stack trace won't be very useful here. Rather than a WARN, it might
be better to dump out some info about the fstype (and maybe other
info?) that returned the bogus type value here. I'm pretty sure most
in-kernel fs's don't do this, but who knows what 3rd party fs's might
do.

> +	return type;
> =20
> -	return nop->encode_fh(inode, fid->raw, max_len, parent);
>  }
>  EXPORT_SYMBOL_GPL(exportfs_encode_inode_fh);
> =20
> @@ -436,6 +443,9 @@ exportfs_decode_fh_raw(struct vfsmount *mnt, struct f=
id *fid, int fh_len,
>  	char nbuf[NAME_MAX+1];
>  	int err;
> =20
> +	if (WARN_ON_ONCE(FILEID_USER_FLAGS(fileid_type)))
> +		return -EINVAL;
> +


This is called from do_handle_to_path() or nfsd_set_fh_dentry(), which
means that this fh comes from userland or from an NFS client. I don't
think we want to WARN because someone crafted a bogus fh and passed it
to us.


>  	/*
>  	 * Try to get any dentry for the given file handle from the filesystem.
>  	 */
> diff --git a/fs/fhandle.c b/fs/fhandle.c
> index 82df28d45cd7..c5792cf3c6e9 100644
> --- a/fs/fhandle.c
> +++ b/fs/fhandle.c
> @@ -307,6 +307,10 @@ static int handle_to_path(int mountdirfd, struct fil=
e_handle __user *ufh,
>  		retval =3D -EINVAL;
>  		goto out_path;
>  	}
> +	if (!FILEID_USER_TYPE_IS_VALID(f_handle.handle_type)) {
> +		retval =3D -EINVAL;
> +		goto out_path;
> +	}
>  	handle =3D kmalloc(struct_size(handle, f_handle, f_handle.handle_bytes)=
,
>  			 GFP_KERNEL);
>  	if (!handle) {
> @@ -322,6 +326,8 @@ static int handle_to_path(int mountdirfd, struct file=
_handle __user *ufh,
>  		goto out_handle;
>  	}
> =20
> +	/* Filesystem code should not be exposed to user flags */
> +	handle->handle_type &=3D ~FILEID_USER_FLAGS_MASK;
>  	retval =3D do_handle_to_path(handle, path, &ctx);
> =20
>  out_handle:
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index 893a1d21dc1c..76a3050b3593 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -160,6 +160,20 @@ struct fid {
>  #define EXPORT_FH_FID		0x2 /* File handle may be non-decodeable */
>  #define EXPORT_FH_DIR_ONLY	0x4 /* Only decode file handle for a director=
y */
> =20
> +/*
> + * Filesystems use only lower 8 bits of file_handle type for fid_type.
> + * name_to_handle_at() uses upper 16 bits of type as user flags to be
> + * interpreted by open_by_handle_at().
> + */
> +#define FILEID_USER_FLAGS_MASK	0xffff0000
> +#define FILEID_USER_FLAGS(type) ((type) & FILEID_USER_FLAGS_MASK)
> +
> +/* Flags supported in encoded handle_type that is exported to user */
> +#define FILEID_VALID_USER_FLAGS	(0)
> +
> +#define FILEID_USER_TYPE_IS_VALID(type) \
> +	(!(FILEID_USER_FLAGS(type) & ~FILEID_VALID_USER_FLAGS))
> +
>  /**
>   * struct export_operations - for nfsd to communicate with file systems
>   * @encode_fh:      encode a file handle fragment from a dentry

The rest looks reasonable.
--=20
Jeff Layton <jlayton@kernel.org>

