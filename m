Return-Path: <linux-fsdevel+bounces-63319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B39BB4A6D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 19:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFBFA3BE911
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 17:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A7125B662;
	Thu,  2 Oct 2025 17:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSBt77mY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E0942A99
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 17:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759425580; cv=none; b=sU6fpfREU/72NIeNbOQvHs+L4uW/0ZKvHxtjdmWkNIeEP+RlEEDK+XPbEF/Xhn1oWk0eXo5qIrlyLcj1OFbfUrnA7fERZMLw1fwEbl17CGfSHFhENfZU6n+CgvS9Hb6yYJqqEt3zUf5mZ9/3Nd/Gx6d/TKfNL50yQEPRo9zlL1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759425580; c=relaxed/simple;
	bh=2izIfzvcQfDpHeqmzjf5SqvCVpagOLOJKKSztKXGNrk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p+BhGtdHBpL8gTcDwcHjfTqgmrgpWV5rwrM/uJ2+zJNV6pV8JatPEKkLU1U5EKlfaW3u5Rwph5OEpcQfhgMnFCyg8QYpY5p8GeDh7xaXJp1YHrbXHPQ/pyQQNxqwx73wuQ7GAw8FHIu8+29w9V2YjR7f1SBgnhfly8qkV19zNO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSBt77mY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE6AC4CEF5;
	Thu,  2 Oct 2025 17:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759425580;
	bh=2izIfzvcQfDpHeqmzjf5SqvCVpagOLOJKKSztKXGNrk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=RSBt77mYeSvAQcnOPKcTENQYPAp7xjqqlIVC13Va/DECz6BNZxAZSRbebqUlwJkAZ
	 d6d/1zf2iS3j835udrispakTmtbERDXaQb9S4bI3k10J4+HfHqe8zT2B5vFRiwU4o2
	 n8NAky3eYRz9XrMxPfGtio7z79ku2CALCzuXISzjQ353xP4zC8JZTZrXs+sKXlNQ/z
	 8qrUolE4ZnzZjlSYVKwaHQ63Oowf8+SViE5T4q6OnZZyo/ggJHfdqOZN4SC2X4/Xy3
	 Zv9ZUW58+Kikj4tSC1GKSk8Ssbc6QvtQyZRqyD2QQ6L1o+08Lae7y/Giv/peH9fw9r
	 mSOXi8lJofEdw==
Message-ID: <71d455e2d378a7500b37101cb8c16576aea90198.camel@kernel.org>
Subject: Re: [PATCH 06/11] VFS: introduce start_removing_dentry()
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neil@brown.name>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner
	 <brauner@kernel.org>, Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Date: Thu, 02 Oct 2025 13:19:38 -0400
In-Reply-To: <20250926025015.1747294-7-neilb@ownmail.net>
References: <20250926025015.1747294-1-neilb@ownmail.net>
	 <20250926025015.1747294-7-neilb@ownmail.net>
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
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-09-26 at 12:49 +1000, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
>=20
> start_removing_dentry() is similar to start_removing() but instead of
> providing a name for lookup, the target dentry is given.
>=20
> start_removing_dentry() checks that the dentry is still hashed and in
> the parent, and if so it locks and increases the refcount so that
> end_removing() can be used to finish the operation.
>=20
> This is used in cachefiles, overlayfs, smb/server, and apparmor.
>=20
> There will be other users including ecryptfs.
>=20
> As start_removing_dentry() takes an extra reference to the dentry (to be
> put by end_removing()), there is no need to explicitly take an extra
> reference to stop d_delete() from using dentry_unlink_inode() to negate
> the dentry - as in cachefiles_delete_object(), and ksmbd_vfs_unlink().
>=20
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/cachefiles/interface.c      | 14 +++++++++-----
>  fs/cachefiles/namei.c          | 22 ++++++++++++----------
>  fs/cachefiles/volume.c         | 10 +++++++---
>  fs/namei.c                     | 29 +++++++++++++++++++++++++++++
>  fs/overlayfs/dir.c             | 10 ++++------
>  fs/overlayfs/readdir.c         |  8 ++++----
>  fs/smb/server/vfs.c            | 27 ++++-----------------------
>  include/linux/namei.h          |  2 ++
>  security/apparmor/apparmorfs.c |  8 ++++----
>  9 files changed, 75 insertions(+), 55 deletions(-)
>=20
> diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
> index 3e63cfe15874..3f8a6f1a8fc3 100644
> --- a/fs/cachefiles/interface.c
> +++ b/fs/cachefiles/interface.c
> @@ -9,6 +9,7 @@
>  #include <linux/mount.h>
>  #include <linux/xattr.h>
>  #include <linux/file.h>
> +#include <linux/namei.h>
>  #include <linux/falloc.h>
>  #include <trace/events/fscache.h>
>  #include "internal.h"
> @@ -428,11 +429,14 @@ static bool cachefiles_invalidate_cookie(struct fsc=
ache_cookie *cookie)
>  		if (!old_tmpfile) {
>  			struct cachefiles_volume *volume =3D object->volume;
>  			struct dentry *fan =3D volume->fanout[(u8)cookie->key_hash];
> -
> -			inode_lock_nested(d_inode(fan), I_MUTEX_PARENT);
> -			cachefiles_bury_object(volume->cache, object, fan,
> -					       old_file->f_path.dentry,
> -					       FSCACHE_OBJECT_INVALIDATED);
> +			struct dentry *obj;
> +
> +			obj =3D start_removing_dentry(fan, old_file->f_path.dentry);
> +			if (!IS_ERR(obj))
> +				cachefiles_bury_object(volume->cache, object,
> +						       fan, obj,
> +						       FSCACHE_OBJECT_INVALIDATED);
> +			end_removing(obj);
>  		}
>  		fput(old_file);
>  	}
> diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> index 3064d439807b..80a3055d8ae5 100644
> --- a/fs/cachefiles/namei.c
> +++ b/fs/cachefiles/namei.c
> @@ -424,13 +424,12 @@ int cachefiles_delete_object(struct cachefiles_obje=
ct *object,
> =20
>  	_enter(",OBJ%x{%pD}", object->debug_id, object->file);
> =20
> -	/* Stop the dentry being negated if it's only pinned by a file struct. =
*/
> -	dget(dentry);
> -
> -	inode_lock_nested(d_backing_inode(fan), I_MUTEX_PARENT);
> -	ret =3D cachefiles_unlink(volume->cache, object, fan, dentry, why);
> -	inode_unlock(d_backing_inode(fan));
> -	dput(dentry);
> +	dentry =3D start_removing_dentry(fan, dentry);
> +	if (IS_ERR(dentry))
> +		ret =3D PTR_ERR(dentry);
> +	else
> +		ret =3D cachefiles_unlink(volume->cache, object, fan, dentry, why);
> +	end_removing(dentry);
>  	return ret;
>  }
> =20
> @@ -643,9 +642,12 @@ bool cachefiles_look_up_object(struct cachefiles_obj=
ect *object)
> =20
>  	if (!d_is_reg(dentry)) {
>  		pr_err("%pd is not a file\n", dentry);
> -		inode_lock_nested(d_inode(fan), I_MUTEX_PARENT);
> -		ret =3D cachefiles_bury_object(volume->cache, object, fan, dentry,
> -					     FSCACHE_OBJECT_IS_WEIRD);
> +		struct dentry *de =3D start_removing_dentry(fan, dentry);
> +		if (!IS_ERR(de))
> +			ret =3D cachefiles_bury_object(volume->cache, object,
> +						     fan, de,
> +						     FSCACHE_OBJECT_IS_WEIRD);
> +		end_removing(de);
>  		dput(dentry);
>  		if (ret < 0)
>  			return false;
> diff --git a/fs/cachefiles/volume.c b/fs/cachefiles/volume.c
> index 781aac4ef274..ddf95ff5daf0 100644
> --- a/fs/cachefiles/volume.c
> +++ b/fs/cachefiles/volume.c
> @@ -7,6 +7,7 @@
> =20
>  #include <linux/fs.h>
>  #include <linux/slab.h>
> +#include <linux/namei.h>
>  #include "internal.h"
>  #include <trace/events/fscache.h>
> =20
> @@ -58,9 +59,12 @@ void cachefiles_acquire_volume(struct fscache_volume *=
vcookie)
>  		if (ret < 0) {
>  			if (ret !=3D -ESTALE)
>  				goto error_dir;
> -			inode_lock_nested(d_inode(cache->store), I_MUTEX_PARENT);
> -			cachefiles_bury_object(cache, NULL, cache->store, vdentry,
> -					       FSCACHE_VOLUME_IS_WEIRD);
> +			vdentry =3D start_removing_dentry(cache->store, vdentry);
> +			if (!IS_ERR(vdentry))
> +				cachefiles_bury_object(cache, NULL, cache->store,
> +						       vdentry,
> +						       FSCACHE_VOLUME_IS_WEIRD);
> +			end_removing(vdentry);
>  			cachefiles_put_directory(volume->dentry);
>  			cond_resched();
>  			goto retry;
> diff --git a/fs/namei.c b/fs/namei.c
> index bd5c45801756..cb4d40af12ae 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3344,6 +3344,35 @@ struct dentry *start_removing_noperm(struct dentry=
 *parent,
>  }
>  EXPORT_SYMBOL(start_removing_noperm);
> =20
> +/**
> + * start_removing_dentry - prepare to remove a given dentry
> + * @parent - directory from which dentry should be removed
> + * @child - the dentry to be removed
> + *
> + * A lock is taken to protect the dentry again other dirops and
> + * the validity of the dentry is checked: correct parent and still hashe=
d.
> + *
> + * If the dentry is valid a reference is taken and returned.  If not
> + * an error is returned.
> + *
> + * end_removing() should be called when removal is complete, or aborted.
> + *
> + * Returns: the valid dentry, or an error.
> + */
> +struct dentry *start_removing_dentry(struct dentry *parent,
> +				     struct dentry *child)
> +{
> +	inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
> +	if (unlikely(IS_DEADDIR(parent->d_inode) ||
> +		     child->d_parent !=3D parent ||
> +		     d_unhashed(child))) {
> +		inode_unlock(parent->d_inode);
> +		return ERR_PTR(-EINVAL);
> +	}
> +	return dget(child);
> +}
> +EXPORT_SYMBOL(start_removing_dentry);
> +
>  #ifdef CONFIG_UNIX98_PTYS
>  int path_pts(struct path *path)
>  {
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index c4057b4a050d..74b1ef5860a4 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -47,14 +47,12 @@ static int ovl_cleanup_locked(struct ovl_fs *ofs, str=
uct inode *wdir,
>  int ovl_cleanup(struct ovl_fs *ofs, struct dentry *workdir,
>  		struct dentry *wdentry)
>  {
> -	int err;
> -
> -	err =3D ovl_parent_lock(workdir, wdentry);
> -	if (err)
> -		return err;
> +	wdentry =3D start_removing_dentry(workdir, wdentry);
> +	if (IS_ERR(wdentry))
> +		return PTR_ERR(wdentry);
> =20
>  	ovl_cleanup_locked(ofs, workdir->d_inode, wdentry);
> -	ovl_parent_unlock(workdir);
> +	end_removing(wdentry);
> =20
>  	return 0;
>  }
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index 15cb06fa0c9a..213ff42556e7 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -1158,11 +1158,11 @@ int ovl_workdir_cleanup(struct ovl_fs *ofs, struc=
t dentry *parent,
>  	if (!d_is_dir(dentry) || level > 1)
>  		return ovl_cleanup(ofs, parent, dentry);
> =20
> -	err =3D ovl_parent_lock(parent, dentry);
> -	if (err)
> -		return err;
> +	dentry =3D start_removing_dentry(parent, dentry);
> +	if (IS_ERR(dentry))
> +		return PTR_ERR(dentry);
>  	err =3D ovl_do_rmdir(ofs, parent->d_inode, dentry);
> -	ovl_parent_unlock(parent);
> +	end_removing(dentry);
>  	if (err) {
>  		struct path path =3D { .mnt =3D mnt, .dentry =3D dentry };
> =20
> diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
> index 1cfa688904b2..56b755a05c4e 100644
> --- a/fs/smb/server/vfs.c
> +++ b/fs/smb/server/vfs.c
> @@ -48,24 +48,6 @@ static void ksmbd_vfs_inherit_owner(struct ksmbd_work =
*work,
>  	i_uid_write(inode, i_uid_read(parent_inode));
>  }
> =20
> -/**
> - * ksmbd_vfs_lock_parent() - lock parent dentry if it is stable
> - * @parent: parent dentry
> - * @child: child dentry
> - *
> - * Returns: %0 on success, %-ENOENT if the parent dentry is not stable
> - */
> -int ksmbd_vfs_lock_parent(struct dentry *parent, struct dentry *child)
> -{
> -	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
> -	if (child->d_parent !=3D parent) {
> -		inode_unlock(d_inode(parent));
> -		return -ENOENT;
> -	}
> -
> -	return 0;
> -}
> -
>  static int ksmbd_vfs_path_lookup(struct ksmbd_share_config *share_conf,
>  				 char *pathname, unsigned int flags,
>  				 struct path *path, bool do_lock)
> @@ -1083,18 +1065,17 @@ int ksmbd_vfs_unlink(struct file *filp)
>  		return err;
> =20
>  	dir =3D dget_parent(dentry);
> -	err =3D ksmbd_vfs_lock_parent(dir, dentry);
> -	if (err)
> +	dentry =3D start_removing_dentry(dir, dentry);
> +	err =3D PTR_ERR(dentry);
> +	if (IS_ERR(dentry))
>  		goto out;
> -	dget(dentry);
> =20
>  	if (S_ISDIR(d_inode(dentry)->i_mode))
>  		err =3D vfs_rmdir(idmap, d_inode(dir), dentry);
>  	else
>  		err =3D vfs_unlink(idmap, d_inode(dir), dentry, NULL);
> =20
> -	dput(dentry);
> -	inode_unlock(d_inode(dir));
> +	end_removing(dentry);
>  	if (err)
>  		ksmbd_debug(VFS, "failed to delete, err %d\n", err);
>  out:
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index 20a88a46fe92..32a007f1043e 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -94,6 +94,8 @@ struct dentry *start_removing(struct mnt_idmap *idmap, =
struct dentry *parent,
>  			      struct qstr *name);
>  struct dentry *start_creating_noperm(struct dentry *parent, struct qstr =
*name);
>  struct dentry *start_removing_noperm(struct dentry *parent, struct qstr =
*name);
> +struct dentry *start_removing_dentry(struct dentry *parent,
> +				     struct dentry *child);
> =20
>  /* end_creating - finish action started with start_creating
>   * @child - dentry returned by start_creating()
> diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorf=
s.c
> index 391a586d0557..9d08d103f142 100644
> --- a/security/apparmor/apparmorfs.c
> +++ b/security/apparmor/apparmorfs.c
> @@ -355,17 +355,17 @@ static void aafs_remove(struct dentry *dentry)
>  	if (!dentry || IS_ERR(dentry))
>  		return;
> =20
> +	/* ->d_parent is stable as rename is not supported */
>  	dir =3D d_inode(dentry->d_parent);
> -	inode_lock(dir);
> -	if (simple_positive(dentry)) {
> +	dentry =3D start_removing_dentry(dentry->d_parent, dentry);
> +	if (!IS_ERR(dentry) && simple_positive(dentry)) {
>  		if (d_is_dir(dentry))
>  			simple_rmdir(dir, dentry);
>  		else
>  			simple_unlink(dir, dentry);
>  		d_delete(dentry);
> -		dput(dentry);
>  	}
> -	inode_unlock(dir);
> +	end_removing(dentry);
>  	simple_release_fs(&aafs_mnt, &aafs_count);
>  }
> =20

Reviewed-by: Jeff Layton <jlayton@kernel.org>

