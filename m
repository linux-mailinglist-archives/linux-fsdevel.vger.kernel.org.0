Return-Path: <linux-fsdevel+bounces-41992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 970BFA39D1A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 14:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7ACA7A2CF0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 13:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA52266560;
	Tue, 18 Feb 2025 13:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="td6vD+8f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E586B14B08E;
	Tue, 18 Feb 2025 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739884437; cv=none; b=Hnwj9vKokQNkZJ+w5UYHub2hMC5A7VoUECx65c5OU8lb78YYXvxzC9c4IQkUtwiY/aV2KGmDkOE/tW8WQu19muFzCrLJpmC8R/rJaUk+oZVt3HG6coam8qWeSGiNe6A+KlNA7LdO5wqpsTXc8zZRrOAZeq22BBQ/rcqdHyOtdp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739884437; c=relaxed/simple;
	bh=reB85UhyFMejn25ctkbc9zv7G7xya9WcrpnKW2GPx+o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I6l6pneYs7EcQtzOVT2LzFMpt41/jFkLEDWJPCO1qneeBx5ecIVBonQIH2V38OjNI2I4YV9jTedChdtpdEhKLCT6MrCZ5GvX3dBtybnIl43jv5u2vUw8BBvYalttaEr8z2UXad7kjShiWiGfeQ6KXdFZBpmF/jcAruySFhNjrVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=td6vD+8f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16B3C4CEE2;
	Tue, 18 Feb 2025 13:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739884436;
	bh=reB85UhyFMejn25ctkbc9zv7G7xya9WcrpnKW2GPx+o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=td6vD+8fu/HGLCF0shJkR7J9i8n1tygk+5Tbn44fCC390cS4uSxcPDA5DGeGWAHWu
	 kCjSO8w/mETKzzAkKNFkcao4MrSMVnzHuEgQy3nX/AtyxMlBY7ZTdIYqhk9Kv3rhCH
	 /zpCj3yCCM1Gg3I00NPxxzayg+dYaMFUycjtpK3IsGzLiyxt/t6hNVy2pEPOZgTpKU
	 At1JbgaSXWl+3loMTdxaKxW1KL2hrZvK54pyTjf2gvfoeULz+ArDQmYQ989709ky6e
	 XxOb7gjP1xVvlSVgptglu26cvjTgbyvXrNhMTObJ/vF1Rhh/L/M0W7m4WWRe4apAn5
	 TmzXZkeJdkzSA==
Message-ID: <74488f024f3802c65e320f5884939f200c866a7e.camel@kernel.org>
Subject: Re: [PATCH 1/3] Change inode_operations.mkdir to return struct
 dentry *
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 18 Feb 2025 08:13:54 -0500
In-Reply-To: <20250217053727.3368579-2-neilb@suse.de>
References: <20250217053727.3368579-1-neilb@suse.de>
	 <20250217053727.3368579-2-neilb@suse.de>
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
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-02-17 at 16:30 +1100, NeilBrown wrote:
> Some filesystems, such as NFS, cifs, ceph, and fuse, do not have
> complete control of sequencing on the actual filesystem (e.g.  on a
> different server) and may find that the inode created for a mkdir
> request already exists in the icache and dcache by the time the mkdir
> request returns.  For example, if the filesystem is mounted twice the
> file could be visible on the other mount before it is on the original
> mount, and a pair of name_to_handle_at(), open_by_handle_at() could
> instantiate the directory inode with an IS_ROOT() dentry before the
> first mkdir returns.
>=20
> This means that the dentry passed to ->mkdir() may not be the one that
> is associated with the inode after the ->mkdir() completes.  Some
> callers need to interact with the inode after the ->mkdir completes and
> they currently need to perform a lookup in the (rare) case that the
> dentry is no longer hashed.
>=20
> This lookup-after-mkdir requires that the directory remains locked to
> avoid races.  Planned future patches to lock the dentry rather than the
> directory will mean that this lookup cannot be performed atomically with
> the mkdir.
>=20
> To remove this barrier, this patch changes ->mkdir to return the
> resulting dentry if it is different from the one passed in.
> Possible returns are:
>   NULL - the directory was created and no other dentry was used
>   ERR_PTR() - an error occurred
>   non-NULL - this other dentry was spliced in
>=20
> Not all filesystems reliable result in a positive hashed dentry:
>=20
> - NFS does produce the proper dentry, but does not yet return it.  The
>   code change is larger than I wanted to include in this patch



To be clear: with this patch and NFS, the only breakage is that you get
a fsnotify_mkdir() call with the wrong dentry.

> - cifs will, when posix extensions are enabled,  unhash the
>   dentry on success so a subsequent lookup  will create it if needed.
> - cifs without posix extensions will unhash the dentry if an
>   internal lookup finds a non-directory where it expected the dir.
> - kernfs and tracefs leave the dentry negative and the ->revalidate
>   operation ensures that lookup will be called to correctly populate
>   the dentry
> - hostfs leaves the dentry negative and uses
>      .d_delete =3D always_delete_dentry
>   so the negative dentry is quickly discarded and a lookup will add a
>   new entry.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  Documentation/filesystems/locking.rst |  2 +-
>  Documentation/filesystems/porting.rst | 11 +++++
>  Documentation/filesystems/vfs.rst     |  7 +++-
>  fs/9p/vfs_inode.c                     |  7 ++--
>  fs/9p/vfs_inode_dotl.c                |  8 ++--
>  fs/affs/affs.h                        |  2 +-
>  fs/affs/namei.c                       |  8 ++--
>  fs/afs/dir.c                          | 12 +++---
>  fs/autofs/root.c                      | 14 +++----
>  fs/bad_inode.c                        |  6 +--
>  fs/bcachefs/fs.c                      |  6 +--
>  fs/btrfs/inode.c                      |  8 ++--
>  fs/ceph/dir.c                         | 15 +++++--
>  fs/coda/dir.c                         | 14 +++----
>  fs/configfs/dir.c                     |  6 +--
>  fs/ecryptfs/inode.c                   |  6 +--
>  fs/exfat/namei.c                      |  8 ++--
>  fs/ext2/namei.c                       |  9 +++--
>  fs/ext4/namei.c                       | 10 ++---
>  fs/f2fs/namei.c                       | 14 +++----
>  fs/fat/namei_msdos.c                  |  8 ++--
>  fs/fat/namei_vfat.c                   |  8 ++--
>  fs/fuse/dir.c                         | 58 +++++++++++++++++----------
>  fs/gfs2/inode.c                       |  9 +++--
>  fs/hfs/dir.c                          | 10 ++---
>  fs/hfsplus/dir.c                      |  6 +--
>  fs/hostfs/hostfs_kern.c               |  8 ++--
>  fs/hpfs/namei.c                       | 10 ++---
>  fs/hugetlbfs/inode.c                  |  6 +--
>  fs/jffs2/dir.c                        | 18 ++++-----
>  fs/jfs/namei.c                        |  8 ++--
>  fs/kernfs/dir.c                       | 12 +++---
>  fs/minix/namei.c                      |  8 ++--
>  fs/namei.c                            | 14 +++++--
>  fs/nfs/dir.c                          |  9 +++--
>  fs/nfs/internal.h                     |  4 +-
>  fs/nilfs2/namei.c                     |  8 ++--
>  fs/ntfs3/namei.c                      |  8 ++--
>  fs/ocfs2/dlmfs/dlmfs.c                | 14 ++++---
>  fs/ocfs2/namei.c                      | 10 ++---
>  fs/omfs/dir.c                         |  6 +--
>  fs/orangefs/namei.c                   |  8 ++--
>  fs/overlayfs/dir.c                    |  9 +++--
>  fs/ramfs/inode.c                      |  6 +--
>  fs/smb/client/cifsfs.h                |  4 +-
>  fs/smb/client/inode.c                 | 10 ++---
>  fs/sysv/namei.c                       |  8 ++--
>  fs/tracefs/inode.c                    | 10 ++---
>  fs/ubifs/dir.c                        | 10 ++---
>  fs/udf/namei.c                        | 12 +++---
>  fs/ufs/namei.c                        |  8 ++--
>  fs/vboxsf/dir.c                       |  8 ++--
>  fs/xfs/xfs_iops.c                     |  4 +-
>  include/linux/fs.h                    |  4 +-
>  kernel/bpf/inode.c                    |  8 ++--
>  mm/shmem.c                            |  8 ++--
>  security/apparmor/apparmorfs.c        |  8 ++--
>  57 files changed, 294 insertions(+), 246 deletions(-)
>=20
> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesy=
stems/locking.rst
> index d20a32b77b60..0ec0bb6eb0fb 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -66,7 +66,7 @@ prototypes::
>  	int (*link) (struct dentry *,struct inode *,struct dentry *);
>  	int (*unlink) (struct inode *,struct dentry *);
>  	int (*symlink) (struct mnt_idmap *, struct inode *,struct dentry *,cons=
t char *);
> -	int (*mkdir) (struct mnt_idmap *, struct inode *,struct dentry *,umode_=
t);
> +	struct dentry *(*mkdir) (struct mnt_idmap *, struct inode *,struct dent=
ry *,umode_t);
>  	int (*rmdir) (struct inode *,struct dentry *);
>  	int (*mknod) (struct mnt_idmap *, struct inode *,struct dentry *,umode_=
t,dev_t);
>  	int (*rename) (struct mnt_idmap *, struct inode *, struct dentry *,
> diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesy=
stems/porting.rst
> index 159adb02be52..68938b7ca1ab 100644
> --- a/Documentation/filesystems/porting.rst
> +++ b/Documentation/filesystems/porting.rst
> @@ -1175,3 +1175,14 @@ lookup_one_qstr_excl() is changed to return errors=
 in some cases:
> =20
>  LOOKUP_EXCL now means "target must not exist".  It can be combined with=
=20
>  LOOK_CREATE or LOOKUP_RENAME_TARGET.
> +
> +---
> +
> +** mandatory**
> +
> +->mkdir() now returns a 'struct dentry *'.  If the created inode is
> +found to already be in cache and have a dentry (often IS_ROOT), it will
> +need to be spliced into the given name in place of the given dentry.
> +That dentry now needs to be returned.  If the original dentry is used,
> +NULL should be returned.  Any error should be returned with
> +ERR_PTR().
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystem=
s/vfs.rst
> index 31eea688609a..bd3751dfddcf 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -495,7 +495,7 @@ As of kernel 2.6.22, the following members are define=
d:
>  		int (*link) (struct dentry *,struct inode *,struct dentry *);
>  		int (*unlink) (struct inode *,struct dentry *);
>  		int (*symlink) (struct mnt_idmap *, struct inode *,struct dentry *,con=
st char *);
> -		int (*mkdir) (struct mnt_idmap *, struct inode *,struct dentry *,umode=
_t);
> +		struct dentry *(*mkdir) (struct mnt_idmap *, struct inode *,struct den=
try *,umode_t);
>  		int (*rmdir) (struct inode *,struct dentry *);
>  		int (*mknod) (struct mnt_idmap *, struct inode *,struct dentry *,umode=
_t,dev_t);
>  		int (*rename) (struct mnt_idmap *, struct inode *, struct dentry *,
> @@ -562,7 +562,10 @@ otherwise noted.
>  ``mkdir``
>  	called by the mkdir(2) system call.  Only required if you want
>  	to support creating subdirectories.  You will probably need to
> -	call d_instantiate() just as you would in the create() method
> +	call d_instantiate() just as you would in the create() method.
> +	If some dentry other than the one given is spliced in, then it
> +	much be returned, otherwise NULL is returned is the original dentry
> +	is successfully used, else an ERR_PTR() is returned.
> =20
>  ``rmdir``
>  	called by the rmdir(2) system call.  Only required if you want
> diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
> index 3e68521f4e2f..399d455d50d6 100644
> --- a/fs/9p/vfs_inode.c
> +++ b/fs/9p/vfs_inode.c
> @@ -669,8 +669,8 @@ v9fs_vfs_create(struct mnt_idmap *idmap, struct inode=
 *dir,
>   *
>   */
> =20
> -static int v9fs_vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> -			  struct dentry *dentry, umode_t mode)
> +static struct dentry *v9fs_vfs_mkdir(struct mnt_idmap *idmap, struct ino=
de *dir,
> +				     struct dentry *dentry, umode_t mode)
>  {
>  	int err;
>  	u32 perm;
> @@ -692,8 +692,7 @@ static int v9fs_vfs_mkdir(struct mnt_idmap *idmap, st=
ruct inode *dir,
> =20
>  	if (fid)
>  		p9_fid_put(fid);
> -
> -	return err;
> +	return ERR_PTR(err);
>  }
> =20
>  /**
> diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
> index 143ac03b7425..cc2007be2173 100644
> --- a/fs/9p/vfs_inode_dotl.c
> +++ b/fs/9p/vfs_inode_dotl.c
> @@ -350,9 +350,9 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct d=
entry *dentry,
>   *
>   */
> =20
> -static int v9fs_vfs_mkdir_dotl(struct mnt_idmap *idmap,
> -			       struct inode *dir, struct dentry *dentry,
> -			       umode_t omode)
> +static struct dentry *v9fs_vfs_mkdir_dotl(struct mnt_idmap *idmap,
> +					  struct inode *dir, struct dentry *dentry,
> +					  umode_t omode)
>  {
>  	int err;
>  	struct v9fs_session_info *v9ses;
> @@ -417,7 +417,7 @@ static int v9fs_vfs_mkdir_dotl(struct mnt_idmap *idma=
p,
>  	p9_fid_put(fid);
>  	v9fs_put_acl(dacl, pacl);
>  	p9_fid_put(dfid);
> -	return err;
> +	return ERR_PTR(err);
>  }
> =20
>  static int
> diff --git a/fs/affs/affs.h b/fs/affs/affs.h
> index e8c2c4535cb3..ac4e9a02910b 100644
> --- a/fs/affs/affs.h
> +++ b/fs/affs/affs.h
> @@ -168,7 +168,7 @@ extern struct dentry *affs_lookup(struct inode *dir, =
struct dentry *dentry, unsi
>  extern int	affs_unlink(struct inode *dir, struct dentry *dentry);
>  extern int	affs_create(struct mnt_idmap *idmap, struct inode *dir,
>  			struct dentry *dentry, umode_t mode, bool);
> -extern int	affs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> +extern struct dentry *affs_mkdir(struct mnt_idmap *idmap, struct inode *=
dir,
>  			struct dentry *dentry, umode_t mode);
>  extern int	affs_rmdir(struct inode *dir, struct dentry *dentry);
>  extern int	affs_link(struct dentry *olddentry, struct inode *dir,
> diff --git a/fs/affs/namei.c b/fs/affs/namei.c
> index 8c154490a2d6..f883be50db12 100644
> --- a/fs/affs/namei.c
> +++ b/fs/affs/namei.c
> @@ -273,7 +273,7 @@ affs_create(struct mnt_idmap *idmap, struct inode *di=
r,
>  	return 0;
>  }
> =20
> -int
> +struct dentry *
>  affs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>  	   struct dentry *dentry, umode_t mode)
>  {
> @@ -285,7 +285,7 @@ affs_mkdir(struct mnt_idmap *idmap, struct inode *dir=
,
> =20
>  	inode =3D affs_new_inode(dir);
>  	if (!inode)
> -		return -ENOSPC;
> +		return ERR_PTR(-ENOSPC);
> =20
>  	inode->i_mode =3D S_IFDIR | mode;
>  	affs_mode_to_prot(inode);
> @@ -298,9 +298,9 @@ affs_mkdir(struct mnt_idmap *idmap, struct inode *dir=
,
>  		clear_nlink(inode);
>  		mark_inode_dirty(inode);
>  		iput(inode);
> -		return error;
> +		return ERR_PTR(error);
>  	}
> -	return 0;
> +	return NULL;
>  }
> =20
>  int
> diff --git a/fs/afs/dir.c b/fs/afs/dir.c
> index 02cbf38e1a77..5bddcc20786e 100644
> --- a/fs/afs/dir.c
> +++ b/fs/afs/dir.c
> @@ -33,8 +33,8 @@ static bool afs_lookup_filldir(struct dir_context *ctx,=
 const char *name, int nl
>  			      loff_t fpos, u64 ino, unsigned dtype);
>  static int afs_create(struct mnt_idmap *idmap, struct inode *dir,
>  		      struct dentry *dentry, umode_t mode, bool excl);
> -static int afs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> -		     struct dentry *dentry, umode_t mode);
> +static struct dentry *afs_mkdir(struct mnt_idmap *idmap, struct inode *d=
ir,
> +				struct dentry *dentry, umode_t mode);
>  static int afs_rmdir(struct inode *dir, struct dentry *dentry);
>  static int afs_unlink(struct inode *dir, struct dentry *dentry);
>  static int afs_link(struct dentry *from, struct inode *dir,
> @@ -1315,8 +1315,8 @@ static const struct afs_operation_ops afs_mkdir_ope=
ration =3D {
>  /*
>   * create a directory on an AFS filesystem
>   */
> -static int afs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> -		     struct dentry *dentry, umode_t mode)
> +static struct dentry *afs_mkdir(struct mnt_idmap *idmap, struct inode *d=
ir,
> +				struct dentry *dentry, umode_t mode)
>  {
>  	struct afs_operation *op;
>  	struct afs_vnode *dvnode =3D AFS_FS_I(dir);
> @@ -1328,7 +1328,7 @@ static int afs_mkdir(struct mnt_idmap *idmap, struc=
t inode *dir,
>  	op =3D afs_alloc_operation(NULL, dvnode->volume);
>  	if (IS_ERR(op)) {
>  		d_drop(dentry);
> -		return PTR_ERR(op);
> +		return ERR_CAST(op);
>  	}
> =20
>  	fscache_use_cookie(afs_vnode_cache(dvnode), true);
> @@ -1344,7 +1344,7 @@ static int afs_mkdir(struct mnt_idmap *idmap, struc=
t inode *dir,
>  	op->ops		=3D &afs_mkdir_operation;
>  	ret =3D afs_do_sync_operation(op);
>  	afs_dir_unuse_cookie(dvnode, ret);
> -	return ret;
> +	return ERR_PTR(ret);
>  }
> =20
>  /*
> diff --git a/fs/autofs/root.c b/fs/autofs/root.c
> index 530d18827e35..174c7205fee4 100644
> --- a/fs/autofs/root.c
> +++ b/fs/autofs/root.c
> @@ -15,8 +15,8 @@ static int autofs_dir_symlink(struct mnt_idmap *, struc=
t inode *,
>  			      struct dentry *, const char *);
>  static int autofs_dir_unlink(struct inode *, struct dentry *);
>  static int autofs_dir_rmdir(struct inode *, struct dentry *);
> -static int autofs_dir_mkdir(struct mnt_idmap *, struct inode *,
> -			    struct dentry *, umode_t);
> +static struct dentry *autofs_dir_mkdir(struct mnt_idmap *, struct inode =
*,
> +				       struct dentry *, umode_t);
>  static long autofs_root_ioctl(struct file *, unsigned int, unsigned long=
);
>  #ifdef CONFIG_COMPAT
>  static long autofs_root_compat_ioctl(struct file *,
> @@ -720,9 +720,9 @@ static int autofs_dir_rmdir(struct inode *dir, struct=
 dentry *dentry)
>  	return 0;
>  }
> =20
> -static int autofs_dir_mkdir(struct mnt_idmap *idmap,
> -			    struct inode *dir, struct dentry *dentry,
> -			    umode_t mode)
> +static struct dentry *autofs_dir_mkdir(struct mnt_idmap *idmap,
> +				       struct inode *dir, struct dentry *dentry,
> +				       umode_t mode)
>  {
>  	struct autofs_sb_info *sbi =3D autofs_sbi(dir->i_sb);
>  	struct autofs_info *ino =3D autofs_dentry_ino(dentry);
> @@ -739,7 +739,7 @@ static int autofs_dir_mkdir(struct mnt_idmap *idmap,
> =20
>  	inode =3D autofs_get_inode(dir->i_sb, S_IFDIR | mode);
>  	if (!inode)
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
>  	d_add(dentry, inode);
> =20
>  	if (sbi->version < 5)
> @@ -751,7 +751,7 @@ static int autofs_dir_mkdir(struct mnt_idmap *idmap,
>  	inc_nlink(dir);
>  	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
> =20
> -	return 0;
> +	return NULL;
>  }
> =20
>  /* Get/set timeout ioctl() operation */
> diff --git a/fs/bad_inode.c b/fs/bad_inode.c
> index 316d88da2ce1..0ef9bcb744dd 100644
> --- a/fs/bad_inode.c
> +++ b/fs/bad_inode.c
> @@ -58,10 +58,10 @@ static int bad_inode_symlink(struct mnt_idmap *idmap,
>  	return -EIO;
>  }
> =20
> -static int bad_inode_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> -			   struct dentry *dentry, umode_t mode)
> +static struct dentry *bad_inode_mkdir(struct mnt_idmap *idmap, struct in=
ode *dir,
> +				      struct dentry *dentry, umode_t mode)
>  {
> -	return -EIO;
> +	return ERR_PTR(-EIO);
>  }
> =20
>  static int bad_inode_rmdir (struct inode *dir, struct dentry *dentry)
> diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
> index 90ade8f648d9..1c94a680fcce 100644
> --- a/fs/bcachefs/fs.c
> +++ b/fs/bcachefs/fs.c
> @@ -858,10 +858,10 @@ static int bch2_symlink(struct mnt_idmap *idmap,
>  	return bch2_err_class(ret);
>  }
> =20
> -static int bch2_mkdir(struct mnt_idmap *idmap,
> -		      struct inode *vdir, struct dentry *dentry, umode_t mode)
> +static struct dentry *bch2_mkdir(struct mnt_idmap *idmap,
> +				 struct inode *vdir, struct dentry *dentry, umode_t mode)
>  {
> -	return bch2_mknod(idmap, vdir, dentry, mode|S_IFDIR, 0);
> +	return ERR_PTR(bch2_mknod(idmap, vdir, dentry, mode|S_IFDIR, 0));
>  }
> =20
>  static int bch2_rename2(struct mnt_idmap *idmap,
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index a9322601ab5c..851d3e8a06a7 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -6739,18 +6739,18 @@ static int btrfs_link(struct dentry *old_dentry, =
struct inode *dir,
>  	return err;
>  }
> =20
> -static int btrfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> -		       struct dentry *dentry, umode_t mode)
> +static struct dentry *btrfs_mkdir(struct mnt_idmap *idmap, struct inode =
*dir,
> +				  struct dentry *dentry, umode_t mode)
>  {
>  	struct inode *inode;
> =20
>  	inode =3D new_inode(dir->i_sb);
>  	if (!inode)
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
>  	inode_init_owner(idmap, inode, dir, S_IFDIR | mode);
>  	inode->i_op =3D &btrfs_dir_inode_operations;
>  	inode->i_fop =3D &btrfs_dir_file_operations;
> -	return btrfs_create_common(dir, dentry, inode);
> +	return ERR_PTR(btrfs_create_common(dir, dentry, inode));
>  }
> =20
>  static noinline int uncompress_inline(struct btrfs_path *path,
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index 62e99e65250d..c1a1c168bb27 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -1092,19 +1092,20 @@ static int ceph_symlink(struct mnt_idmap *idmap, =
struct inode *dir,
>  	return err;
>  }
> =20
> -static int ceph_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> -		      struct dentry *dentry, umode_t mode)
> +static struct dentry *ceph_mkdir(struct mnt_idmap *idmap, struct inode *=
dir,
> +				 struct dentry *dentry, umode_t mode)
>  {
>  	struct ceph_mds_client *mdsc =3D ceph_sb_to_mdsc(dir->i_sb);
>  	struct ceph_client *cl =3D mdsc->fsc->client;
>  	struct ceph_mds_request *req;
>  	struct ceph_acl_sec_ctx as_ctx =3D {};
> +	struct dentry *ret =3D NULL;
>  	int err;
>  	int op;
> =20
>  	err =3D ceph_wait_on_conflict_unlink(dentry);
>  	if (err)
> -		return err;
> +		return ERR_PTR(err);
> =20
>  	if (ceph_snap(dir) =3D=3D CEPH_SNAPDIR) {
>  		/* mkdir .snap/foo is a MKSNAP */
> @@ -1166,14 +1167,20 @@ static int ceph_mkdir(struct mnt_idmap *idmap, st=
ruct inode *dir,
>  	    !req->r_reply_info.head->is_dentry)
>  		err =3D ceph_handle_notrace_create(dir, dentry);
>  out_req:
> +	if (!err && req->r_dentry !=3D dentry)
> +		/* Some other dentry was spliced in */
> +		ret =3D dget(req->r_dentry);
>  	ceph_mdsc_put_request(req);
>  out:
>  	if (!err)
> +		/* Should this use 'ret' ?? */
>  		ceph_init_inode_acls(d_inode(dentry), &as_ctx);
>  	else
>  		d_drop(dentry);
>  	ceph_release_acl_sec_ctx(&as_ctx);
> -	return err;
> +	if (err)
> +		return ERR_PTR(err);
> +	return ret;
>  }
> =20
>  static int ceph_link(struct dentry *old_dentry, struct inode *dir,
> diff --git a/fs/coda/dir.c b/fs/coda/dir.c
> index a3e2dfeedfbf..ab69d8f0cec2 100644
> --- a/fs/coda/dir.c
> +++ b/fs/coda/dir.c
> @@ -166,8 +166,8 @@ static int coda_create(struct mnt_idmap *idmap, struc=
t inode *dir,
>  	return error;
>  }
> =20
> -static int coda_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> -		      struct dentry *de, umode_t mode)
> +static struct dentry *coda_mkdir(struct mnt_idmap *idmap, struct inode *=
dir,
> +				 struct dentry *de, umode_t mode)
>  {
>  	struct inode *inode;
>  	struct coda_vattr attrs;
> @@ -177,14 +177,14 @@ static int coda_mkdir(struct mnt_idmap *idmap, stru=
ct inode *dir,
>  	struct CodaFid newfid;
> =20
>  	if (is_root_inode(dir) && coda_iscontrol(name, len))
> -		return -EPERM;
> +		return ERR_PTR(-EPERM);
> =20
>  	attrs.va_mode =3D mode;
> -	error =3D venus_mkdir(dir->i_sb, coda_i2f(dir),=20
> +	error =3D venus_mkdir(dir->i_sb, coda_i2f(dir),
>  			       name, len, &newfid, &attrs);
>  	if (error)
>  		goto err_out;
> -        =20
> +
>  	inode =3D coda_iget(dir->i_sb, &newfid, &attrs);
>  	if (IS_ERR(inode)) {
>  		error =3D PTR_ERR(inode);
> @@ -195,10 +195,10 @@ static int coda_mkdir(struct mnt_idmap *idmap, stru=
ct inode *dir,
>  	coda_dir_inc_nlink(dir);
>  	coda_dir_update_mtime(dir);
>  	d_instantiate(de, inode);
> -	return 0;
> +	return NULL;
>  err_out:
>  	d_drop(de);
> -	return error;
> +	return ERR_PTR(error);
>  }
> =20
>  /* try to make de an entry in dir_inodde linked to source_de */=20
> diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
> index 7d10278db30d..5568cb74b322 100644
> --- a/fs/configfs/dir.c
> +++ b/fs/configfs/dir.c
> @@ -1280,8 +1280,8 @@ int configfs_depend_item_unlocked(struct configfs_s=
ubsystem *caller_subsys,
>  }
>  EXPORT_SYMBOL(configfs_depend_item_unlocked);
> =20
> -static int configfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> -			  struct dentry *dentry, umode_t mode)
> +static struct dentry *configfs_mkdir(struct mnt_idmap *idmap, struct ino=
de *dir,
> +				     struct dentry *dentry, umode_t mode)
>  {
>  	int ret =3D 0;
>  	int module_got =3D 0;
> @@ -1461,7 +1461,7 @@ static int configfs_mkdir(struct mnt_idmap *idmap, =
struct inode *dir,
>  	put_fragment(frag);
> =20
>  out:
> -	return ret;
> +	return ERR_PTR(ret);
>  }
> =20
>  static int configfs_rmdir(struct inode *dir, struct dentry *dentry)
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index a9819ddb1ab8..6315dd194228 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -503,8 +503,8 @@ static int ecryptfs_symlink(struct mnt_idmap *idmap,
>  	return rc;
>  }
> =20
> -static int ecryptfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> -			  struct dentry *dentry, umode_t mode)
> +static struct dentry *ecryptfs_mkdir(struct mnt_idmap *idmap, struct ino=
de *dir,
> +				     struct dentry *dentry, umode_t mode)
>  {
>  	int rc;
>  	struct dentry *lower_dentry;
> @@ -526,7 +526,7 @@ static int ecryptfs_mkdir(struct mnt_idmap *idmap, st=
ruct inode *dir,
>  	inode_unlock(lower_dir);
>  	if (d_really_is_negative(dentry))
>  		d_drop(dentry);
> -	return rc;
> +	return ERR_PTR(rc);
>  }
> =20
>  static int ecryptfs_rmdir(struct inode *dir, struct dentry *dentry)
> diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
> index 691dd77b6ab5..1660c9bbcfa9 100644
> --- a/fs/exfat/namei.c
> +++ b/fs/exfat/namei.c
> @@ -835,8 +835,8 @@ static int exfat_unlink(struct inode *dir, struct den=
try *dentry)
>  	return err;
>  }
> =20
> -static int exfat_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> -		       struct dentry *dentry, umode_t mode)
> +static struct dentry *exfat_mkdir(struct mnt_idmap *idmap, struct inode =
*dir,
> +				  struct dentry *dentry, umode_t mode)
>  {
>  	struct super_block *sb =3D dir->i_sb;
>  	struct inode *inode;
> @@ -846,7 +846,7 @@ static int exfat_mkdir(struct mnt_idmap *idmap, struc=
t inode *dir,
>  	loff_t size =3D i_size_read(dir);
> =20
>  	if (unlikely(exfat_forced_shutdown(sb)))
> -		return -EIO;
> +		return ERR_PTR(-EIO);
> =20
>  	mutex_lock(&EXFAT_SB(sb)->s_lock);
>  	exfat_set_volume_dirty(sb);
> @@ -877,7 +877,7 @@ static int exfat_mkdir(struct mnt_idmap *idmap, struc=
t inode *dir,
> =20
>  unlock:
>  	mutex_unlock(&EXFAT_SB(sb)->s_lock);
> -	return err;
> +	return ERR_PTR(err);
>  }
> =20
>  static int exfat_check_dir_empty(struct super_block *sb,
> diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
> index 8346ab9534c1..bde617a66cec 100644
> --- a/fs/ext2/namei.c
> +++ b/fs/ext2/namei.c
> @@ -225,15 +225,16 @@ static int ext2_link (struct dentry * old_dentry, s=
truct inode * dir,
>  	return err;
>  }
> =20
> -static int ext2_mkdir(struct mnt_idmap * idmap,
> -	struct inode * dir, struct dentry * dentry, umode_t mode)
> +static struct dentry *ext2_mkdir(struct mnt_idmap * idmap,
> +				 struct inode * dir, struct dentry * dentry,
> +				 umode_t mode)
>  {
>  	struct inode * inode;
>  	int err;
> =20
>  	err =3D dquot_initialize(dir);
>  	if (err)
> -		return err;
> +		return ERR_PTR(err);
> =20
>  	inode_inc_link_count(dir);
> =20
> @@ -258,7 +259,7 @@ static int ext2_mkdir(struct mnt_idmap * idmap,
> =20
>  	d_instantiate_new(dentry, inode);
>  out:
> -	return err;
> +	return ERR_PTR(err);
> =20
>  out_fail:
>  	inode_dec_link_count(inode);
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 536d56d15072..716cc6096870 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -3004,19 +3004,19 @@ int ext4_init_new_dir(handle_t *handle, struct in=
ode *dir,
>  	return err;
>  }
> =20
> -static int ext4_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> -		      struct dentry *dentry, umode_t mode)
> +static struct dentry *ext4_mkdir(struct mnt_idmap *idmap, struct inode *=
dir,
> +				 struct dentry *dentry, umode_t mode)
>  {
>  	handle_t *handle;
>  	struct inode *inode;
>  	int err, err2 =3D 0, credits, retries =3D 0;
> =20
>  	if (EXT4_DIR_LINK_MAX(dir))
> -		return -EMLINK;
> +		return ERR_PTR(-EMLINK);
> =20
>  	err =3D dquot_initialize(dir);
>  	if (err)
> -		return err;
> +		return ERR_PTR(err);
> =20
>  	credits =3D (EXT4_DATA_TRANS_BLOCKS(dir->i_sb) +
>  		   EXT4_INDEX_EXTRA_TRANS_BLOCKS + 3);
> @@ -3066,7 +3066,7 @@ static int ext4_mkdir(struct mnt_idmap *idmap, stru=
ct inode *dir,
>  out_retry:
>  	if (err =3D=3D -ENOSPC && ext4_should_retry_alloc(dir->i_sb, &retries))
>  		goto retry;
> -	return err;
> +	return ERR_PTR(err);
>  }
> =20
>  /*
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index a278c7da8177..24dca4dc85a9 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -684,23 +684,23 @@ static int f2fs_symlink(struct mnt_idmap *idmap, st=
ruct inode *dir,
>  	return err;
>  }
> =20
> -static int f2fs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> -		      struct dentry *dentry, umode_t mode)
> +static struct dentry *f2fs_mkdir(struct mnt_idmap *idmap, struct inode *=
dir,
> +				 struct dentry *dentry, umode_t mode)
>  {
>  	struct f2fs_sb_info *sbi =3D F2FS_I_SB(dir);
>  	struct inode *inode;
>  	int err;
> =20
>  	if (unlikely(f2fs_cp_error(sbi)))
> -		return -EIO;
> +		return ERR_PTR(-EIO);
> =20
>  	err =3D f2fs_dquot_initialize(dir);
>  	if (err)
> -		return err;
> +		return ERR_PTR(err);
> =20
>  	inode =3D f2fs_new_inode(idmap, dir, S_IFDIR | mode, NULL);
>  	if (IS_ERR(inode))
> -		return PTR_ERR(inode);
> +		return ERR_CAST(inode);
> =20
>  	inode->i_op =3D &f2fs_dir_inode_operations;
>  	inode->i_fop =3D &f2fs_dir_operations;
> @@ -722,12 +722,12 @@ static int f2fs_mkdir(struct mnt_idmap *idmap, stru=
ct inode *dir,
>  		f2fs_sync_fs(sbi->sb, 1);
> =20
>  	f2fs_balance_fs(sbi, true);
> -	return 0;
> +	return NULL;
> =20
>  out_fail:
>  	clear_inode_flag(inode, FI_INC_LINK);
>  	f2fs_handle_failed_inode(inode);
> -	return err;
> +	return ERR_PTR(err);
>  }
> =20
>  static int f2fs_rmdir(struct inode *dir, struct dentry *dentry)
> diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
> index f06f6ba643cc..23e9b9371ec3 100644
> --- a/fs/fat/namei_msdos.c
> +++ b/fs/fat/namei_msdos.c
> @@ -339,8 +339,8 @@ static int msdos_rmdir(struct inode *dir, struct dent=
ry *dentry)
>  }
> =20
>  /***** Make a directory */
> -static int msdos_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> -		       struct dentry *dentry, umode_t mode)
> +static struct dentry *msdos_mkdir(struct mnt_idmap *idmap, struct inode =
*dir,
> +				  struct dentry *dentry, umode_t mode)
>  {
>  	struct super_block *sb =3D dir->i_sb;
>  	struct fat_slot_info sinfo;
> @@ -389,13 +389,13 @@ static int msdos_mkdir(struct mnt_idmap *idmap, str=
uct inode *dir,
> =20
>  	mutex_unlock(&MSDOS_SB(sb)->s_lock);
>  	fat_flush_inodes(sb, dir, inode);
> -	return 0;
> +	return NULL;
> =20
>  out_free:
>  	fat_free_clusters(dir, cluster);
>  out:
>  	mutex_unlock(&MSDOS_SB(sb)->s_lock);
> -	return err;
> +	return ERR_PTR(err);
>  }
> =20
>  /***** Unlink a file */
> diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
> index 926c26e90ef8..dd910edd2404 100644
> --- a/fs/fat/namei_vfat.c
> +++ b/fs/fat/namei_vfat.c
> @@ -841,8 +841,8 @@ static int vfat_unlink(struct inode *dir, struct dent=
ry *dentry)
>  	return err;
>  }
> =20
> -static int vfat_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> -		      struct dentry *dentry, umode_t mode)
> +static struct dentry *vfat_mkdir(struct mnt_idmap *idmap, struct inode *=
dir,
> +				  struct dentry *dentry, umode_t mode)
>  {
>  	struct super_block *sb =3D dir->i_sb;
>  	struct inode *inode;
> @@ -877,13 +877,13 @@ static int vfat_mkdir(struct mnt_idmap *idmap, stru=
ct inode *dir,
>  	d_instantiate(dentry, inode);
> =20
>  	mutex_unlock(&MSDOS_SB(sb)->s_lock);
> -	return 0;
> +	return NULL;
> =20
>  out_free:
>  	fat_free_clusters(dir, cluster);
>  out:
>  	mutex_unlock(&MSDOS_SB(sb)->s_lock);
> -	return err;
> +	return ERR_PTR(err);
>  }
> =20
>  static int vfat_get_dotdot_de(struct inode *inode, struct buffer_head **=
bh,
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 198862b086ff..2537eefcd023 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -781,9 +781,9 @@ static int fuse_atomic_open(struct inode *dir, struct=
 dentry *entry,
>  /*
>   * Code shared between mknod, mkdir, symlink and link
>   */
> -static int create_new_entry(struct mnt_idmap *idmap, struct fuse_mount *=
fm,
> -			    struct fuse_args *args, struct inode *dir,
> -			    struct dentry *entry, umode_t mode)
> +static struct dentry *create_new_entry(struct mnt_idmap *idmap, struct f=
use_mount *fm,
> +				       struct fuse_args *args, struct inode *dir,
> +				       struct dentry *entry, umode_t mode)
>  {
>  	struct fuse_entry_out outarg;
>  	struct inode *inode;
> @@ -792,11 +792,11 @@ static int create_new_entry(struct mnt_idmap *idmap=
, struct fuse_mount *fm,
>  	struct fuse_forget_link *forget;
> =20
>  	if (fuse_is_bad(dir))
> -		return -EIO;
> +		return ERR_PTR(-EIO);
> =20
>  	forget =3D fuse_alloc_forget();
>  	if (!forget)
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
> =20
>  	memset(&outarg, 0, sizeof(outarg));
>  	args->nodeid =3D get_node_id(dir);
> @@ -826,29 +826,27 @@ static int create_new_entry(struct mnt_idmap *idmap=
, struct fuse_mount *fm,
>  			  &outarg.attr, ATTR_TIMEOUT(&outarg), 0, 0);
>  	if (!inode) {
>  		fuse_queue_forget(fm->fc, forget, outarg.nodeid, 1);
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
>  	}
>  	kfree(forget);
> =20
>  	d_drop(entry);
>  	d =3D d_splice_alias(inode, entry);
>  	if (IS_ERR(d))
> -		return PTR_ERR(d);
> +		return d;
> =20
> -	if (d) {
> +	if (d)
>  		fuse_change_entry_timeout(d, &outarg);
> -		dput(d);
> -	} else {
> +	else
>  		fuse_change_entry_timeout(entry, &outarg);
> -	}
>  	fuse_dir_changed(dir);
> -	return 0;
> +	return d;
> =20
>   out_put_forget_req:
>  	if (err =3D=3D -EEXIST)
>  		fuse_invalidate_entry(entry);
>  	kfree(forget);
> -	return err;
> +	return ERR_PTR(err);
>  }
> =20
>  static int fuse_mknod(struct mnt_idmap *idmap, struct inode *dir,
> @@ -856,6 +854,7 @@ static int fuse_mknod(struct mnt_idmap *idmap, struct=
 inode *dir,
>  {
>  	struct fuse_mknod_in inarg;
>  	struct fuse_mount *fm =3D get_fuse_mount(dir);
> +	struct dentry *de;
>  	FUSE_ARGS(args);
> =20
>  	if (!fm->fc->dont_mask)
> @@ -871,7 +870,12 @@ static int fuse_mknod(struct mnt_idmap *idmap, struc=
t inode *dir,
>  	args.in_args[0].value =3D &inarg;
>  	args.in_args[1].size =3D entry->d_name.len + 1;
>  	args.in_args[1].value =3D entry->d_name.name;
> -	return create_new_entry(idmap, fm, &args, dir, entry, mode);
> +	de =3D create_new_entry(idmap, fm, &args, dir, entry, mode);
> +	if (IS_ERR(de))
> +		return PTR_ERR(de);
> +	if (de)
> +		dput(de);
> +	return 0;
>  }
> =20
>  static int fuse_create(struct mnt_idmap *idmap, struct inode *dir,
> @@ -898,8 +902,8 @@ static int fuse_tmpfile(struct mnt_idmap *idmap, stru=
ct inode *dir,
>  	return err;
>  }
> =20
> -static int fuse_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> -		      struct dentry *entry, umode_t mode)
> +static struct dentry *fuse_mkdir(struct mnt_idmap *idmap, struct inode *=
dir,
> +				 struct dentry *entry, umode_t mode)
>  {
>  	struct fuse_mkdir_in inarg;
>  	struct fuse_mount *fm =3D get_fuse_mount(dir);
> @@ -918,6 +922,7 @@ static int fuse_mkdir(struct mnt_idmap *idmap, struct=
 inode *dir,
>  	args.in_args[1].size =3D entry->d_name.len + 1;
>  	args.in_args[1].value =3D entry->d_name.name;
>  	return create_new_entry(idmap, fm, &args, dir, entry, S_IFDIR);
> +
>  }
> =20
>  static int fuse_symlink(struct mnt_idmap *idmap, struct inode *dir,
> @@ -925,6 +930,7 @@ static int fuse_symlink(struct mnt_idmap *idmap, stru=
ct inode *dir,
>  {
>  	struct fuse_mount *fm =3D get_fuse_mount(dir);
>  	unsigned len =3D strlen(link) + 1;
> +	struct dentry *de;
>  	FUSE_ARGS(args);
> =20
>  	args.opcode =3D FUSE_SYMLINK;
> @@ -934,7 +940,12 @@ static int fuse_symlink(struct mnt_idmap *idmap, str=
uct inode *dir,
>  	args.in_args[1].value =3D entry->d_name.name;
>  	args.in_args[2].size =3D len;
>  	args.in_args[2].value =3D link;
> -	return create_new_entry(idmap, fm, &args, dir, entry, S_IFLNK);
> +	de =3D create_new_entry(idmap, fm, &args, dir, entry, S_IFLNK);
> +	if (IS_ERR(de))
> +		return PTR_ERR(de);
> +	if (de)
> +		dput(de);
> +	return 0;
>  }
> =20
>  void fuse_flush_time_update(struct inode *inode)
> @@ -1117,7 +1128,7 @@ static int fuse_rename2(struct mnt_idmap *idmap, st=
ruct inode *olddir,
>  static int fuse_link(struct dentry *entry, struct inode *newdir,
>  		     struct dentry *newent)
>  {
> -	int err;
> +	struct dentry *de;
>  	struct fuse_link_in inarg;
>  	struct inode *inode =3D d_inode(entry);
>  	struct fuse_mount *fm =3D get_fuse_mount(inode);
> @@ -1131,13 +1142,16 @@ static int fuse_link(struct dentry *entry, struct=
 inode *newdir,
>  	args.in_args[0].value =3D &inarg;
>  	args.in_args[1].size =3D newent->d_name.len + 1;
>  	args.in_args[1].value =3D newent->d_name.name;
> -	err =3D create_new_entry(&invalid_mnt_idmap, fm, &args, newdir, newent,=
 inode->i_mode);
> -	if (!err)
> +	de =3D create_new_entry(&invalid_mnt_idmap, fm, &args, newdir, newent, =
inode->i_mode);
> +	if (!IS_ERR(de)) {
> +		if (de)
> +			dput(de);
> +		de =3D NULL;
>  		fuse_update_ctime_in_cache(inode);
> -	else if (err =3D=3D -EINTR)
> +	} else if (PTR_ERR(de) =3D=3D -EINTR)
>  		fuse_invalidate_attr(inode);
> =20
> -	return err;
> +	return PTR_ERR(de);
>  }
> =20
>  static void fuse_fillattr(struct mnt_idmap *idmap, struct inode *inode,
> diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> index 6fbbaaad1cd0..198a8cbaf5e5 100644
> --- a/fs/gfs2/inode.c
> +++ b/fs/gfs2/inode.c
> @@ -1248,14 +1248,15 @@ static int gfs2_symlink(struct mnt_idmap *idmap, =
struct inode *dir,
>   * @dentry: The dentry of the new directory
>   * @mode: The mode of the new directory
>   *
> - * Returns: errno
> + * Returns: the dentry, or ERR_PTR(errno)
>   */
> =20
> -static int gfs2_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> -		      struct dentry *dentry, umode_t mode)
> +static struct dentry *gfs2_mkdir(struct mnt_idmap *idmap, struct inode *=
dir,
> +				 struct dentry *dentry, umode_t mode)
>  {
>  	unsigned dsize =3D gfs2_max_stuffed_size(GFS2_I(dir));
> -	return gfs2_create_inode(dir, dentry, NULL, S_IFDIR | mode, 0, NULL, ds=
ize, 0);
> +
> +	return ERR_PTR(gfs2_create_inode(dir, dentry, NULL, S_IFDIR | mode, 0, =
NULL, dsize, 0));
>  }
> =20
>  /**
> diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
> index b75c26045df4..86a6b317b474 100644
> --- a/fs/hfs/dir.c
> +++ b/fs/hfs/dir.c
> @@ -219,26 +219,26 @@ static int hfs_create(struct mnt_idmap *idmap, stru=
ct inode *dir,
>   * in a directory, given the inode for the parent directory and the
>   * name (and its length) of the new directory.
>   */
> -static int hfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> -		     struct dentry *dentry, umode_t mode)
> +static struct dentry *hfs_mkdir(struct mnt_idmap *idmap, struct inode *d=
ir,
> +				struct dentry *dentry, umode_t mode)
>  {
>  	struct inode *inode;
>  	int res;
> =20
>  	inode =3D hfs_new_inode(dir, &dentry->d_name, S_IFDIR | mode);
>  	if (!inode)
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
> =20
>  	res =3D hfs_cat_create(inode->i_ino, dir, &dentry->d_name, inode);
>  	if (res) {
>  		clear_nlink(inode);
>  		hfs_delete_inode(inode);
>  		iput(inode);
> -		return res;
> +		return ERR_PTR(res);
>  	}
>  	d_instantiate(dentry, inode);
>  	mark_inode_dirty(inode);
> -	return 0;
> +	return NULL;
>  }
> =20
>  /*
> diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
> index f5c4b3e31a1c..876bbb80fb4d 100644
> --- a/fs/hfsplus/dir.c
> +++ b/fs/hfsplus/dir.c
> @@ -523,10 +523,10 @@ static int hfsplus_create(struct mnt_idmap *idmap, =
struct inode *dir,
>  	return hfsplus_mknod(&nop_mnt_idmap, dir, dentry, mode, 0);
>  }
> =20
> -static int hfsplus_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> -			 struct dentry *dentry, umode_t mode)
> +static struct dentry *hfsplus_mkdir(struct mnt_idmap *idmap, struct inod=
e *dir,
> +				    struct dentry *dentry, umode_t mode)
>  {
> -	return hfsplus_mknod(&nop_mnt_idmap, dir, dentry, mode | S_IFDIR, 0);
> +	return ERR_PTR(hfsplus_mknod(&nop_mnt_idmap, dir, dentry, mode | S_IFDI=
R, 0));
>  }
> =20
>  static int hfsplus_rename(struct mnt_idmap *idmap,
> diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
> index e0741e468956..ccbb48fe830d 100644
> --- a/fs/hostfs/hostfs_kern.c
> +++ b/fs/hostfs/hostfs_kern.c
> @@ -679,17 +679,17 @@ static int hostfs_symlink(struct mnt_idmap *idmap, =
struct inode *ino,
>  	return err;
>  }
> =20
> -static int hostfs_mkdir(struct mnt_idmap *idmap, struct inode *ino,
> -			struct dentry *dentry, umode_t mode)
> +static struct dentry *hostfs_mkdir(struct mnt_idmap *idmap, struct inode=
 *ino,
> +				   struct dentry *dentry, umode_t mode)
>  {
>  	char *file;
>  	int err;
> =20
>  	if ((file =3D dentry_name(dentry)) =3D=3D NULL)
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
>  	err =3D do_mkdir(file, mode);
>  	__putname(file);
> -	return err;
> +	return ERR_PTR(err);
>  }
> =20
>  static int hostfs_rmdir(struct inode *ino, struct dentry *dentry)
> diff --git a/fs/hpfs/namei.c b/fs/hpfs/namei.c
> index d0edf9ed33b6..e3cdc421dfba 100644
> --- a/fs/hpfs/namei.c
> +++ b/fs/hpfs/namei.c
> @@ -19,8 +19,8 @@ static void hpfs_update_directory_times(struct inode *d=
ir)
>  	hpfs_write_inode_nolock(dir);
>  }
> =20
> -static int hpfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> -		      struct dentry *dentry, umode_t mode)
> +static struct dentry *hpfs_mkdir(struct mnt_idmap *idmap, struct inode *=
dir,
> +				 struct dentry *dentry, umode_t mode)
>  {
>  	const unsigned char *name =3D dentry->d_name.name;
>  	unsigned len =3D dentry->d_name.len;
> @@ -35,7 +35,7 @@ static int hpfs_mkdir(struct mnt_idmap *idmap, struct i=
node *dir,
>  	int r;
>  	struct hpfs_dirent dee;
>  	int err;
> -	if ((err =3D hpfs_chk_name(name, &len))) return err=3D=3D-ENOENT ? -EIN=
VAL : err;
> +	if ((err =3D hpfs_chk_name(name, &len))) return ERR_PTR(err=3D=3D-ENOEN=
T ? -EINVAL : err);
>  	hpfs_lock(dir->i_sb);
>  	err =3D -ENOSPC;
>  	fnode =3D hpfs_alloc_fnode(dir->i_sb, hpfs_i(dir)->i_dno, &fno, &bh);
> @@ -112,7 +112,7 @@ static int hpfs_mkdir(struct mnt_idmap *idmap, struct=
 inode *dir,
>  	hpfs_update_directory_times(dir);
>  	d_instantiate(dentry, result);
>  	hpfs_unlock(dir->i_sb);
> -	return 0;
> +	return NULL;
>  bail3:
>  	iput(result);
>  bail2:
> @@ -123,7 +123,7 @@ static int hpfs_mkdir(struct mnt_idmap *idmap, struct=
 inode *dir,
>  	hpfs_free_sectors(dir->i_sb, fno, 1);
>  bail:
>  	hpfs_unlock(dir->i_sb);
> -	return err;
> +	return ERR_PTR(err);
>  }
> =20
>  static int hpfs_create(struct mnt_idmap *idmap, struct inode *dir,
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 0fc179a59830..d98caedbb723 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -991,14 +991,14 @@ static int hugetlbfs_mknod(struct mnt_idmap *idmap,=
 struct inode *dir,
>  	return 0;
>  }
> =20
> -static int hugetlbfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> -			   struct dentry *dentry, umode_t mode)
> +static struct dentry *hugetlbfs_mkdir(struct mnt_idmap *idmap, struct in=
ode *dir,
> +				      struct dentry *dentry, umode_t mode)
>  {
>  	int retval =3D hugetlbfs_mknod(idmap, dir, dentry,
>  				     mode | S_IFDIR, 0);
>  	if (!retval)
>  		inc_nlink(dir);
> -	return retval;
> +	return ERR_PTR(retval);
>  }
> =20
>  static int hugetlbfs_create(struct mnt_idmap *idmap,
> diff --git a/fs/jffs2/dir.c b/fs/jffs2/dir.c
> index 2b2938970da3..dd91f725ded6 100644
> --- a/fs/jffs2/dir.c
> +++ b/fs/jffs2/dir.c
> @@ -32,8 +32,8 @@ static int jffs2_link (struct dentry *,struct inode *,s=
truct dentry *);
>  static int jffs2_unlink (struct inode *,struct dentry *);
>  static int jffs2_symlink (struct mnt_idmap *, struct inode *,
>  			  struct dentry *, const char *);
> -static int jffs2_mkdir (struct mnt_idmap *, struct inode *,struct dentry=
 *,
> -			umode_t);
> +static struct dentry *jffs2_mkdir (struct mnt_idmap *, struct inode *,st=
ruct dentry *,
> +				   umode_t);
>  static int jffs2_rmdir (struct inode *,struct dentry *);
>  static int jffs2_mknod (struct mnt_idmap *, struct inode *,struct dentry=
 *,
>  			umode_t,dev_t);
> @@ -446,8 +446,8 @@ static int jffs2_symlink (struct mnt_idmap *idmap, st=
ruct inode *dir_i,
>  }
> =20
> =20
> -static int jffs2_mkdir (struct mnt_idmap *idmap, struct inode *dir_i,
> -		        struct dentry *dentry, umode_t mode)
> +static struct dentry *jffs2_mkdir (struct mnt_idmap *idmap, struct inode=
 *dir_i,
> +				   struct dentry *dentry, umode_t mode)
>  {
>  	struct jffs2_inode_info *f, *dir_f;
>  	struct jffs2_sb_info *c;
> @@ -464,7 +464,7 @@ static int jffs2_mkdir (struct mnt_idmap *idmap, stru=
ct inode *dir_i,
> =20
>  	ri =3D jffs2_alloc_raw_inode();
>  	if (!ri)
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
> =20
>  	c =3D JFFS2_SB_INFO(dir_i->i_sb);
> =20
> @@ -477,7 +477,7 @@ static int jffs2_mkdir (struct mnt_idmap *idmap, stru=
ct inode *dir_i,
> =20
>  	if (ret) {
>  		jffs2_free_raw_inode(ri);
> -		return ret;
> +		return ERR_PTR(ret);
>  	}
> =20
>  	inode =3D jffs2_new_inode(dir_i, mode, ri);
> @@ -485,7 +485,7 @@ static int jffs2_mkdir (struct mnt_idmap *idmap, stru=
ct inode *dir_i,
>  	if (IS_ERR(inode)) {
>  		jffs2_free_raw_inode(ri);
>  		jffs2_complete_reservation(c);
> -		return PTR_ERR(inode);
> +		return ERR_CAST(inode);
>  	}
> =20
>  	inode->i_op =3D &jffs2_dir_inode_operations;
> @@ -584,11 +584,11 @@ static int jffs2_mkdir (struct mnt_idmap *idmap, st=
ruct inode *dir_i,
>  	jffs2_complete_reservation(c);
> =20
>  	d_instantiate_new(dentry, inode);
> -	return 0;
> +	return NULL;
> =20
>   fail:
>  	iget_failed(inode);
> -	return ret;
> +	return ERR_PTR(ret);
>  }
> =20
>  static int jffs2_rmdir (struct inode *dir_i, struct dentry *dentry)
> diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
> index fc8ede43afde..65a218eba8fa 100644
> --- a/fs/jfs/namei.c
> +++ b/fs/jfs/namei.c
> @@ -187,13 +187,13 @@ static int jfs_create(struct mnt_idmap *idmap, stru=
ct inode *dip,
>   *		dentry	- dentry of child directory
>   *		mode	- create mode (rwxrwxrwx).
>   *
> - * RETURN:	Errors from subroutines
> + * RETURN:	ERR_PTR() of errors from subroutines.
>   *
>   * note:
>   * EACCES: user needs search+write permission on the parent directory
>   */
> -static int jfs_mkdir(struct mnt_idmap *idmap, struct inode *dip,
> -		     struct dentry *dentry, umode_t mode)
> +static struct dentry *jfs_mkdir(struct mnt_idmap *idmap, struct inode *d=
ip,
> +				struct dentry *dentry, umode_t mode)
>  {
>  	int rc =3D 0;
>  	tid_t tid;		/* transaction id */
> @@ -308,7 +308,7 @@ static int jfs_mkdir(struct mnt_idmap *idmap, struct =
inode *dip,
>        out1:
> =20
>  	jfs_info("jfs_mkdir: rc:%d", rc);
> -	return rc;
> +	return ERR_PTR(rc);
>  }
> =20
>  /*
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index 5f0f8b95f44c..d296aad70800 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -1230,24 +1230,24 @@ static struct dentry *kernfs_iop_lookup(struct in=
ode *dir,
>  	return d_splice_alias(inode, dentry);
>  }
> =20
> -static int kernfs_iop_mkdir(struct mnt_idmap *idmap,
> -			    struct inode *dir, struct dentry *dentry,
> -			    umode_t mode)
> +static struct dentry *kernfs_iop_mkdir(struct mnt_idmap *idmap,
> +				       struct inode *dir, struct dentry *dentry,
> +				       umode_t mode)
>  {
>  	struct kernfs_node *parent =3D dir->i_private;
>  	struct kernfs_syscall_ops *scops =3D kernfs_root(parent)->syscall_ops;
>  	int ret;
> =20
>  	if (!scops || !scops->mkdir)
> -		return -EPERM;
> +		return ERR_PTR(-EPERM);
> =20
>  	if (!kernfs_get_active(parent))
> -		return -ENODEV;
> +		return ERR_PTR(-ENODEV);
> =20
>  	ret =3D scops->mkdir(parent, dentry->d_name.name, mode);
> =20
>  	kernfs_put_active(parent);
> -	return ret;
> +	return ERR_PTR(ret);
>  }
> =20
>  static int kernfs_iop_rmdir(struct inode *dir, struct dentry *dentry)
> diff --git a/fs/minix/namei.c b/fs/minix/namei.c
> index 5d9c1406fe27..8938536d8d3c 100644
> --- a/fs/minix/namei.c
> +++ b/fs/minix/namei.c
> @@ -104,15 +104,15 @@ static int minix_link(struct dentry * old_dentry, s=
truct inode * dir,
>  	return add_nondir(dentry, inode);
>  }
> =20
> -static int minix_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> -		       struct dentry *dentry, umode_t mode)
> +static struct dentry *minix_mkdir(struct mnt_idmap *idmap, struct inode =
*dir,
> +				  struct dentry *dentry, umode_t mode)
>  {
>  	struct inode * inode;
>  	int err;
> =20
>  	inode =3D minix_new_inode(dir, S_IFDIR | mode);
>  	if (IS_ERR(inode))
> -		return PTR_ERR(inode);
> +		return ERR_CAST(inode);
> =20
>  	inode_inc_link_count(dir);
>  	minix_set_inode(inode, 0);
> @@ -128,7 +128,7 @@ static int minix_mkdir(struct mnt_idmap *idmap, struc=
t inode *dir,
> =20
>  	d_instantiate(dentry, inode);
>  out:
> -	return err;
> +	return ERR_PTR(err);
> =20
>  out_fail:
>  	inode_dec_link_count(inode);
> diff --git a/fs/namei.c b/fs/namei.c
> index 865a009fdebc..19d5ea340a18 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4297,6 +4297,7 @@ int vfs_mkdir(struct mnt_idmap *idmap, struct inode=
 *dir,
>  {
>  	int error;
>  	unsigned max_links =3D dir->i_sb->s_max_links;
> +	struct dentry *de;
> =20
>  	error =3D may_create(idmap, dir, dentry);
>  	if (error)
> @@ -4313,10 +4314,17 @@ int vfs_mkdir(struct mnt_idmap *idmap, struct ino=
de *dir,
>  	if (max_links && dir->i_nlink >=3D max_links)
>  		return -EMLINK;
> =20
> -	error =3D dir->i_op->mkdir(idmap, dir, dentry, mode);
> -	if (!error)
> +	de =3D dir->i_op->mkdir(idmap, dir, dentry, mode);
> +	if (IS_ERR(de))
> +		return PTR_ERR(de);
> +	if (de) {
> +		fsnotify_mkdir(dir, de);
> +		/* Cannot return de yet */
> +		dput(de);
> +	} else
>  		fsnotify_mkdir(dir, dentry);
> -	return error;
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL(vfs_mkdir);
> =20
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index 56cf16a72334..5700f73d48bc 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -2422,8 +2422,8 @@ EXPORT_SYMBOL_GPL(nfs_mknod);
>  /*
>   * See comments for nfs_proc_create regarding failed operations.
>   */
> -int nfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> -	      struct dentry *dentry, umode_t mode)
> +struct dentry *nfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> +			 struct dentry *dentry, umode_t mode)
>  {
>  	struct iattr attr;
>  	int error;
> @@ -2439,10 +2439,11 @@ int nfs_mkdir(struct mnt_idmap *idmap, struct ino=
de *dir,
>  	trace_nfs_mkdir_exit(dir, dentry, error);
>  	if (error !=3D 0)
>  		goto out_err;
> -	return 0;
> +	/* FIXME - ->mkdir might have used an alternate dentry */
> +	return NULL;
>  out_err:
>  	d_drop(dentry);
> -	return error;
> +	return ERR_PTR(error);
>  }
>  EXPORT_SYMBOL_GPL(nfs_mkdir);
> =20
> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> index fae2c7ae4acc..1ac1d3eec517 100644
> --- a/fs/nfs/internal.h
> +++ b/fs/nfs/internal.h
> @@ -400,8 +400,8 @@ struct dentry *nfs_lookup(struct inode *, struct dent=
ry *, unsigned int);
>  void nfs_d_prune_case_insensitive_aliases(struct inode *inode);
>  int nfs_create(struct mnt_idmap *, struct inode *, struct dentry *,
>  	       umode_t, bool);
> -int nfs_mkdir(struct mnt_idmap *, struct inode *, struct dentry *,
> -	      umode_t);
> +struct dentry *nfs_mkdir(struct mnt_idmap *, struct inode *, struct dent=
ry *,
> +			 umode_t);
>  int nfs_rmdir(struct inode *, struct dentry *);
>  int nfs_unlink(struct inode *, struct dentry *);
>  int nfs_symlink(struct mnt_idmap *, struct inode *, struct dentry *,
> diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
> index 953fbd5f0851..40f4b1a28705 100644
> --- a/fs/nilfs2/namei.c
> +++ b/fs/nilfs2/namei.c
> @@ -218,8 +218,8 @@ static int nilfs_link(struct dentry *old_dentry, stru=
ct inode *dir,
>  	return err;
>  }
> =20
> -static int nilfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> -		       struct dentry *dentry, umode_t mode)
> +static struct dentry *nilfs_mkdir(struct mnt_idmap *idmap, struct inode =
*dir,
> +				  struct dentry *dentry, umode_t mode)
>  {
>  	struct inode *inode;
>  	struct nilfs_transaction_info ti;
> @@ -227,7 +227,7 @@ static int nilfs_mkdir(struct mnt_idmap *idmap, struc=
t inode *dir,
> =20
>  	err =3D nilfs_transaction_begin(dir->i_sb, &ti, 1);
>  	if (err)
> -		return err;
> +		return ERR_PTR(err);
> =20
>  	inc_nlink(dir);
> =20
> @@ -258,7 +258,7 @@ static int nilfs_mkdir(struct mnt_idmap *idmap, struc=
t inode *dir,
>  	else
>  		nilfs_transaction_abort(dir->i_sb);
> =20
> -	return err;
> +	return ERR_PTR(err);
> =20
>  out_fail:
>  	drop_nlink(inode);
> diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
> index abf7e81584a9..652735a0b0c4 100644
> --- a/fs/ntfs3/namei.c
> +++ b/fs/ntfs3/namei.c
> @@ -201,11 +201,11 @@ static int ntfs_symlink(struct mnt_idmap *idmap, st=
ruct inode *dir,
>  /*
>   * ntfs_mkdir- inode_operations::mkdir
>   */
> -static int ntfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> -		      struct dentry *dentry, umode_t mode)
> +static struct dentry *ntfs_mkdir(struct mnt_idmap *idmap, struct inode *=
dir,
> +				 struct dentry *dentry, umode_t mode)
>  {
> -	return ntfs_create_inode(idmap, dir, dentry, NULL, S_IFDIR | mode, 0,
> -				 NULL, 0, NULL);
> +	return ERR_PTR(ntfs_create_inode(idmap, dir, dentry, NULL, S_IFDIR | mo=
de, 0,
> +					 NULL, 0, NULL));
>  }
> =20
>  /*
> diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
> index 2a7f36643895..f632fbfe59e8 100644
> --- a/fs/ocfs2/dlmfs/dlmfs.c
> +++ b/fs/ocfs2/dlmfs/dlmfs.c
> @@ -402,10 +402,10 @@ static struct inode *dlmfs_get_inode(struct inode *=
parent,
>   * File creation. Allocate an inode, and we're done..
>   */
>  /* SMP-safe */
> -static int dlmfs_mkdir(struct mnt_idmap * idmap,
> -		       struct inode * dir,
> -		       struct dentry * dentry,
> -		       umode_t mode)
> +static struct dentry *dlmfs_mkdir(struct mnt_idmap * idmap,
> +				  struct inode * dir,
> +				  struct dentry * dentry,
> +				  umode_t mode)
>  {
>  	int status;
>  	struct inode *inode =3D NULL;
> @@ -446,9 +446,11 @@ static int dlmfs_mkdir(struct mnt_idmap * idmap,
> =20
>  	status =3D 0;
>  bail:
> -	if (status < 0)
> +	if (status < 0) {
>  		iput(inode);
> -	return status;
> +		return ERR_PTR(status);
> +	}
> +	return NULL;
>  }
> =20
>  static int dlmfs_create(struct mnt_idmap *idmap,
> diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
> index 0ec63a1a94b8..99278c8f0e24 100644
> --- a/fs/ocfs2/namei.c
> +++ b/fs/ocfs2/namei.c
> @@ -644,10 +644,10 @@ static int ocfs2_mknod_locked(struct ocfs2_super *o=
sb,
>  				    suballoc_loc, suballoc_bit);
>  }
> =20
> -static int ocfs2_mkdir(struct mnt_idmap *idmap,
> -		       struct inode *dir,
> -		       struct dentry *dentry,
> -		       umode_t mode)
> +static struct dentry *ocfs2_mkdir(struct mnt_idmap *idmap,
> +				  struct inode *dir,
> +				  struct dentry *dentry,
> +				  umode_t mode)
>  {
>  	int ret;
> =20
> @@ -657,7 +657,7 @@ static int ocfs2_mkdir(struct mnt_idmap *idmap,
>  	if (ret)
>  		mlog_errno(ret);
> =20
> -	return ret;
> +	return ERR_PTR(ret);
>  }
> =20
>  static int ocfs2_create(struct mnt_idmap *idmap,
> diff --git a/fs/omfs/dir.c b/fs/omfs/dir.c
> index 6bda275826d6..2ed541fccf33 100644
> --- a/fs/omfs/dir.c
> +++ b/fs/omfs/dir.c
> @@ -279,10 +279,10 @@ static int omfs_add_node(struct inode *dir, struct =
dentry *dentry, umode_t mode)
>  	return err;
>  }
> =20
> -static int omfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> -		      struct dentry *dentry, umode_t mode)
> +static struct dentry *omfs_mkdir(struct mnt_idmap *idmap, struct inode *=
dir,
> +				 struct dentry *dentry, umode_t mode)
>  {
> -	return omfs_add_node(dir, dentry, mode | S_IFDIR);
> +	return ERR_PTR(omfs_add_node(dir, dentry, mode | S_IFDIR));
>  }
> =20
>  static int omfs_create(struct mnt_idmap *idmap, struct inode *dir,
> diff --git a/fs/orangefs/namei.c b/fs/orangefs/namei.c
> index 200558ec72f0..82395fe2b956 100644
> --- a/fs/orangefs/namei.c
> +++ b/fs/orangefs/namei.c
> @@ -300,8 +300,8 @@ static int orangefs_symlink(struct mnt_idmap *idmap,
>  	return ret;
>  }
> =20
> -static int orangefs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> -			  struct dentry *dentry, umode_t mode)
> +static struct dentry *orangefs_mkdir(struct mnt_idmap *idmap, struct ino=
de *dir,
> +				     struct dentry *dentry, umode_t mode)
>  {
>  	struct orangefs_inode_s *parent =3D ORANGEFS_I(dir);
>  	struct orangefs_kernel_op_s *new_op;
> @@ -312,7 +312,7 @@ static int orangefs_mkdir(struct mnt_idmap *idmap, st=
ruct inode *dir,
> =20
>  	new_op =3D op_alloc(ORANGEFS_VFS_OP_MKDIR);
>  	if (!new_op)
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
> =20
>  	new_op->upcall.req.mkdir.parent_refn =3D parent->refn;
> =20
> @@ -366,7 +366,7 @@ static int orangefs_mkdir(struct mnt_idmap *idmap, st=
ruct inode *dir,
>  	__orangefs_setattr(dir, &iattr);
>  out:
>  	op_release(new_op);
> -	return ret;
> +	return ERR_PTR(ret);
>  }
> =20
>  static int orangefs_rename(struct mnt_idmap *idmap,
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index c9993ff66fc2..21c3aaf7b274 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -282,7 +282,8 @@ static int ovl_instantiate(struct dentry *dentry, str=
uct inode *inode,
>  		 * XXX: if we ever use ovl_obtain_alias() to decode directory
>  		 * file handles, need to use ovl_get_inode_locked() and
>  		 * d_instantiate_new() here to prevent from creating two
> -		 * hashed directory inode aliases.
> +		 * hashed directory inode aliases.  We then need to return
> +		 * the obtained alias to ovl_mkdir().
>  		 */
>  		inode =3D ovl_get_inode(dentry->d_sb, &oip);
>  		if (IS_ERR(inode))
> @@ -687,10 +688,10 @@ static int ovl_create(struct mnt_idmap *idmap, stru=
ct inode *dir,
>  	return ovl_create_object(dentry, (mode & 07777) | S_IFREG, 0, NULL);
>  }
> =20
> -static int ovl_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> -		     struct dentry *dentry, umode_t mode)
> +static struct dentry *ovl_mkdir(struct mnt_idmap *idmap, struct inode *d=
ir,
> +				struct dentry *dentry, umode_t mode)
>  {
> -	return ovl_create_object(dentry, (mode & 07777) | S_IFDIR, 0, NULL);
> +	return ERR_PTR(ovl_create_object(dentry, (mode & 07777) | S_IFDIR, 0, N=
ULL));
>  }
> =20
>  static int ovl_mknod(struct mnt_idmap *idmap, struct inode *dir,
> diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
> index 8006faaaf0ec..775fa905fda0 100644
> --- a/fs/ramfs/inode.c
> +++ b/fs/ramfs/inode.c
> @@ -119,13 +119,13 @@ ramfs_mknod(struct mnt_idmap *idmap, struct inode *=
dir,
>  	return error;
>  }
> =20
> -static int ramfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> -		       struct dentry *dentry, umode_t mode)
> +static struct dentry *ramfs_mkdir(struct mnt_idmap *idmap, struct inode =
*dir,
> +				 struct dentry *dentry, umode_t mode)
>  {
>  	int retval =3D ramfs_mknod(&nop_mnt_idmap, dir, dentry, mode | S_IFDIR,=
 0);
>  	if (!retval)
>  		inc_nlink(dir);
> -	return retval;
> +	return ERR_PTR(retval);
>  }
> =20
>  static int ramfs_create(struct mnt_idmap *idmap, struct inode *dir,
> diff --git a/fs/smb/client/cifsfs.h b/fs/smb/client/cifsfs.h
> index 831fee962c4d..8dea0cf3a8de 100644
> --- a/fs/smb/client/cifsfs.h
> +++ b/fs/smb/client/cifsfs.h
> @@ -59,8 +59,8 @@ extern int cifs_unlink(struct inode *dir, struct dentry=
 *dentry);
>  extern int cifs_hardlink(struct dentry *, struct inode *, struct dentry =
*);
>  extern int cifs_mknod(struct mnt_idmap *, struct inode *, struct dentry =
*,
>  		      umode_t, dev_t);
> -extern int cifs_mkdir(struct mnt_idmap *, struct inode *, struct dentry =
*,
> -		      umode_t);
> +extern struct dentry *cifs_mkdir(struct mnt_idmap *, struct inode *, str=
uct dentry *,
> +				 umode_t);
>  extern int cifs_rmdir(struct inode *, struct dentry *);
>  extern int cifs_rename2(struct mnt_idmap *, struct inode *,
>  			struct dentry *, struct inode *, struct dentry *,
> diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
> index 9cc31cf6ebd0..685a176f7f7e 100644
> --- a/fs/smb/client/inode.c
> +++ b/fs/smb/client/inode.c
> @@ -2194,8 +2194,8 @@ cifs_posix_mkdir(struct inode *inode, struct dentry=
 *dentry, umode_t mode,
>  }
>  #endif /* CONFIG_CIFS_ALLOW_INSECURE_LEGACY */
> =20
> -int cifs_mkdir(struct mnt_idmap *idmap, struct inode *inode,
> -	       struct dentry *direntry, umode_t mode)
> +struct dentry *cifs_mkdir(struct mnt_idmap *idmap, struct inode *inode,
> +			  struct dentry *direntry, umode_t mode)
>  {
>  	int rc =3D 0;
>  	unsigned int xid;
> @@ -2211,10 +2211,10 @@ int cifs_mkdir(struct mnt_idmap *idmap, struct in=
ode *inode,
> =20
>  	cifs_sb =3D CIFS_SB(inode->i_sb);
>  	if (unlikely(cifs_forced_shutdown(cifs_sb)))
> -		return -EIO;
> +		return ERR_PTR(-EIO);
>  	tlink =3D cifs_sb_tlink(cifs_sb);
>  	if (IS_ERR(tlink))
> -		return PTR_ERR(tlink);
> +		return ERR_CAST(tlink);
>  	tcon =3D tlink_tcon(tlink);
> =20
>  	xid =3D get_xid();
> @@ -2270,7 +2270,7 @@ int cifs_mkdir(struct mnt_idmap *idmap, struct inod=
e *inode,
>  	free_dentry_path(page);
>  	free_xid(xid);
>  	cifs_put_tlink(tlink);
> -	return rc;
> +	return ERR_PTR(rc);
>  }
> =20
>  int cifs_rmdir(struct inode *inode, struct dentry *direntry)
> diff --git a/fs/sysv/namei.c b/fs/sysv/namei.c
> index fb8bd8437872..ba037727c1e6 100644
> --- a/fs/sysv/namei.c
> +++ b/fs/sysv/namei.c
> @@ -110,8 +110,8 @@ static int sysv_link(struct dentry * old_dentry, stru=
ct inode * dir,
>  	return add_nondir(dentry, inode);
>  }
> =20
> -static int sysv_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> -		      struct dentry *dentry, umode_t mode)
> +static struct dentry *sysv_mkdir(struct mnt_idmap *idmap, struct inode *=
dir,
> +				 struct dentry *dentry, umode_t mode)
>  {
>  	struct inode * inode;
>  	int err;
> @@ -135,9 +135,9 @@ static int sysv_mkdir(struct mnt_idmap *idmap, struct=
 inode *dir,
>  	if (err)
>  		goto out_fail;
> =20
> -        d_instantiate(dentry, inode);
> +	d_instantiate(dentry, inode);
>  out:
> -	return err;
> +	return ERR_PTR(err);
> =20
>  out_fail:
>  	inode_dec_link_count(inode);
> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index 53214499e384..cb1af30b49f5 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -109,9 +109,9 @@ static char *get_dname(struct dentry *dentry)
>  	return name;
>  }
> =20
> -static int tracefs_syscall_mkdir(struct mnt_idmap *idmap,
> -				 struct inode *inode, struct dentry *dentry,
> -				 umode_t mode)
> +static struct dentry *tracefs_syscall_mkdir(struct mnt_idmap *idmap,
> +					    struct inode *inode, struct dentry *dentry,
> +					    umode_t mode)
>  {
>  	struct tracefs_inode *ti;
>  	char *name;
> @@ -119,7 +119,7 @@ static int tracefs_syscall_mkdir(struct mnt_idmap *id=
map,
> =20
>  	name =3D get_dname(dentry);
>  	if (!name)
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
> =20
>  	/*
>  	 * This is a new directory that does not take the default of
> @@ -141,7 +141,7 @@ static int tracefs_syscall_mkdir(struct mnt_idmap *id=
map,
> =20
>  	kfree(name);
> =20
> -	return ret;
> +	return ERR_PTR(ret);
>  }
> =20
>  static int tracefs_syscall_rmdir(struct inode *inode, struct dentry *den=
try)
> diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
> index fda82f3e16e8..3c3d3ad4fa6c 100644
> --- a/fs/ubifs/dir.c
> +++ b/fs/ubifs/dir.c
> @@ -1002,8 +1002,8 @@ static int ubifs_rmdir(struct inode *dir, struct de=
ntry *dentry)
>  	return err;
>  }
> =20
> -static int ubifs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> -		       struct dentry *dentry, umode_t mode)
> +static struct dentry *ubifs_mkdir(struct mnt_idmap *idmap, struct inode =
*dir,
> +				  struct dentry *dentry, umode_t mode)
>  {
>  	struct inode *inode;
>  	struct ubifs_inode *dir_ui =3D ubifs_inode(dir);
> @@ -1023,7 +1023,7 @@ static int ubifs_mkdir(struct mnt_idmap *idmap, str=
uct inode *dir,
> =20
>  	err =3D ubifs_budget_space(c, &req);
>  	if (err)
> -		return err;
> +		return ERR_PTR(err);
> =20
>  	err =3D ubifs_prepare_create(dir, dentry, &nm);
>  	if (err)
> @@ -1060,7 +1060,7 @@ static int ubifs_mkdir(struct mnt_idmap *idmap, str=
uct inode *dir,
>  	ubifs_release_budget(c, &req);
>  	d_instantiate(dentry, inode);
>  	fscrypt_free_filename(&nm);
> -	return 0;
> +	return NULL;
> =20
>  out_cancel:
>  	dir->i_size -=3D sz_change;
> @@ -1074,7 +1074,7 @@ static int ubifs_mkdir(struct mnt_idmap *idmap, str=
uct inode *dir,
>  	fscrypt_free_filename(&nm);
>  out_budg:
>  	ubifs_release_budget(c, &req);
> -	return err;
> +	return ERR_PTR(err);
>  }
> =20
>  static int ubifs_mknod(struct mnt_idmap *idmap, struct inode *dir,
> diff --git a/fs/udf/namei.c b/fs/udf/namei.c
> index 2cb49b6b0716..5f2e9a892bff 100644
> --- a/fs/udf/namei.c
> +++ b/fs/udf/namei.c
> @@ -419,8 +419,8 @@ static int udf_mknod(struct mnt_idmap *idmap, struct =
inode *dir,
>  	return udf_add_nondir(dentry, inode);
>  }
> =20
> -static int udf_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> -		     struct dentry *dentry, umode_t mode)
> +static struct dentry *udf_mkdir(struct mnt_idmap *idmap, struct inode *d=
ir,
> +				struct dentry *dentry, umode_t mode)
>  {
>  	struct inode *inode;
>  	struct udf_fileident_iter iter;
> @@ -430,7 +430,7 @@ static int udf_mkdir(struct mnt_idmap *idmap, struct =
inode *dir,
> =20
>  	inode =3D udf_new_inode(dir, S_IFDIR | mode);
>  	if (IS_ERR(inode))
> -		return PTR_ERR(inode);
> +		return ERR_CAST(inode);
> =20
>  	iinfo =3D UDF_I(inode);
>  	inode->i_op =3D &udf_dir_inode_operations;
> @@ -439,7 +439,7 @@ static int udf_mkdir(struct mnt_idmap *idmap, struct =
inode *dir,
>  	if (err) {
>  		clear_nlink(inode);
>  		discard_new_inode(inode);
> -		return err;
> +		return ERR_PTR(err);
>  	}
>  	set_nlink(inode, 2);
>  	iter.fi.icb.extLength =3D cpu_to_le32(inode->i_sb->s_blocksize);
> @@ -456,7 +456,7 @@ static int udf_mkdir(struct mnt_idmap *idmap, struct =
inode *dir,
>  	if (err) {
>  		clear_nlink(inode);
>  		discard_new_inode(inode);
> -		return err;
> +		return ERR_PTR(err);
>  	}
>  	iter.fi.icb.extLength =3D cpu_to_le32(inode->i_sb->s_blocksize);
>  	iter.fi.icb.extLocation =3D cpu_to_lelb(iinfo->i_location);
> @@ -471,7 +471,7 @@ static int udf_mkdir(struct mnt_idmap *idmap, struct =
inode *dir,
>  	mark_inode_dirty(dir);
>  	d_instantiate_new(dentry, inode);
> =20
> -	return 0;
> +	return NULL;
>  }
> =20
>  static int empty_dir(struct inode *dir)
> diff --git a/fs/ufs/namei.c b/fs/ufs/namei.c
> index 38a024c8cccd..5b3c85c93242 100644
> --- a/fs/ufs/namei.c
> +++ b/fs/ufs/namei.c
> @@ -166,8 +166,8 @@ static int ufs_link (struct dentry * old_dentry, stru=
ct inode * dir,
>  	return error;
>  }
> =20
> -static int ufs_mkdir(struct mnt_idmap * idmap, struct inode * dir,
> -	struct dentry * dentry, umode_t mode)
> +static struct dentry *ufs_mkdir(struct mnt_idmap * idmap, struct inode *=
 dir,
> +				struct dentry * dentry, umode_t mode)
>  {
>  	struct inode * inode;
>  	int err;
> @@ -194,7 +194,7 @@ static int ufs_mkdir(struct mnt_idmap * idmap, struct=
 inode * dir,
>  		goto out_fail;
> =20
>  	d_instantiate_new(dentry, inode);
> -	return 0;
> +	return NULL;
> =20
>  out_fail:
>  	inode_dec_link_count(inode);
> @@ -202,7 +202,7 @@ static int ufs_mkdir(struct mnt_idmap * idmap, struct=
 inode * dir,
>  	discard_new_inode(inode);
>  out_dir:
>  	inode_dec_link_count(dir);
> -	return err;
> +	return ERR_PTR(err);
>  }
> =20
>  static int ufs_unlink(struct inode *dir, struct dentry *dentry)
> diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
> index a859ac9b74ba..770e29ec3557 100644
> --- a/fs/vboxsf/dir.c
> +++ b/fs/vboxsf/dir.c
> @@ -303,11 +303,11 @@ static int vboxsf_dir_mkfile(struct mnt_idmap *idma=
p,
>  	return vboxsf_dir_create(parent, dentry, mode, false, excl, NULL);
>  }
> =20
> -static int vboxsf_dir_mkdir(struct mnt_idmap *idmap,
> -			    struct inode *parent, struct dentry *dentry,
> -			    umode_t mode)
> +static struct dentry *vboxsf_dir_mkdir(struct mnt_idmap *idmap,
> +				       struct inode *parent, struct dentry *dentry,
> +				       umode_t mode)
>  {
> -	return vboxsf_dir_create(parent, dentry, mode, true, true, NULL);
> +	return ERR_PTR(vboxsf_dir_create(parent, dentry, mode, true, true, NULL=
));
>  }
> =20
>  static int vboxsf_dir_atomic_open(struct inode *parent, struct dentry *d=
entry,
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 40289fe6f5b2..a4480098d2bf 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -298,14 +298,14 @@ xfs_vn_create(
>  	return xfs_generic_create(idmap, dir, dentry, mode, 0, NULL);
>  }
> =20
> -STATIC int
> +STATIC struct dentry *
>  xfs_vn_mkdir(
>  	struct mnt_idmap	*idmap,
>  	struct inode		*dir,
>  	struct dentry		*dentry,
>  	umode_t			mode)
>  {
> -	return xfs_generic_create(idmap, dir, dentry, mode | S_IFDIR, 0, NULL);
> +	return ERR_PTR(xfs_generic_create(idmap, dir, dentry, mode | S_IFDIR, 0=
, NULL));
>  }
> =20
>  STATIC struct dentry *
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 2c3b2f8a621f..45269608ee23 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2211,8 +2211,8 @@ struct inode_operations {
>  	int (*unlink) (struct inode *,struct dentry *);
>  	int (*symlink) (struct mnt_idmap *, struct inode *,struct dentry *,
>  			const char *);
> -	int (*mkdir) (struct mnt_idmap *, struct inode *,struct dentry *,
> -		      umode_t);
> +	struct dentry *(*mkdir) (struct mnt_idmap *, struct inode *,
> +				 struct dentry *, umode_t);
>  	int (*rmdir) (struct inode *,struct dentry *);
>  	int (*mknod) (struct mnt_idmap *, struct inode *,struct dentry *,
>  		      umode_t,dev_t);
> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index 9aaf5124648b..dc3aa91a6ba0 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c
> @@ -150,14 +150,14 @@ static void bpf_dentry_finalize(struct dentry *dent=
ry, struct inode *inode,
>  	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
>  }
> =20
> -static int bpf_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> -		     struct dentry *dentry, umode_t mode)
> +static struct dentry *bpf_mkdir(struct mnt_idmap *idmap, struct inode *d=
ir,
> +				struct dentry *dentry, umode_t mode)
>  {
>  	struct inode *inode;
> =20
>  	inode =3D bpf_get_inode(dir->i_sb, dir, mode | S_IFDIR);
>  	if (IS_ERR(inode))
> -		return PTR_ERR(inode);
> +		return ERR_CAST(inode);
> =20
>  	inode->i_op =3D &bpf_dir_iops;
>  	inode->i_fop =3D &simple_dir_operations;
> @@ -166,7 +166,7 @@ static int bpf_mkdir(struct mnt_idmap *idmap, struct =
inode *dir,
>  	inc_nlink(dir);
> =20
>  	bpf_dentry_finalize(dentry, inode, dir);
> -	return 0;
> +	return NULL;
>  }
> =20
>  struct map_iter {
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 4ea6109a8043..00ae0146e768 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3889,16 +3889,16 @@ shmem_tmpfile(struct mnt_idmap *idmap, struct ino=
de *dir,
>  	return error;
>  }
> =20
> -static int shmem_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> -		       struct dentry *dentry, umode_t mode)
> +static struct dentry *shmem_mkdir(struct mnt_idmap *idmap, struct inode =
*dir,
> +				  struct dentry *dentry, umode_t mode)
>  {
>  	int error;
> =20
>  	error =3D shmem_mknod(idmap, dir, dentry, mode | S_IFDIR, 0);
>  	if (error)
> -		return error;
> +		return ERR_PTR(error);
>  	inc_nlink(dir);
> -	return 0;
> +	return NULL;
>  }
> =20
>  static int shmem_create(struct mnt_idmap *idmap, struct inode *dir,
> diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorf=
s.c
> index c07d150685d7..6039afae4bfc 100644
> --- a/security/apparmor/apparmorfs.c
> +++ b/security/apparmor/apparmorfs.c
> @@ -1795,8 +1795,8 @@ int __aafs_profile_mkdir(struct aa_profile *profile=
, struct dentry *parent)
>  	return error;
>  }
> =20
> -static int ns_mkdir_op(struct mnt_idmap *idmap, struct inode *dir,
> -		       struct dentry *dentry, umode_t mode)
> +static struct dentry *ns_mkdir_op(struct mnt_idmap *idmap, struct inode =
*dir,
> +				  struct dentry *dentry, umode_t mode)
>  {
>  	struct aa_ns *ns, *parent;
>  	/* TODO: improve permission check */
> @@ -1808,7 +1808,7 @@ static int ns_mkdir_op(struct mnt_idmap *idmap, str=
uct inode *dir,
>  				     AA_MAY_LOAD_POLICY);
>  	end_current_label_crit_section(label);
>  	if (error)
> -		return error;
> +		return ERR_PTR(error);
> =20
>  	parent =3D aa_get_ns(dir->i_private);
>  	AA_BUG(d_inode(ns_subns_dir(parent)) !=3D dir);
> @@ -1843,7 +1843,7 @@ static int ns_mkdir_op(struct mnt_idmap *idmap, str=
uct inode *dir,
>  	mutex_unlock(&parent->lock);
>  	aa_put_ns(parent);
> =20
> -	return error;
> +	return ERR_PTR(error);
>  }
> =20
>  static int ns_rmdir_op(struct inode *dir, struct dentry *dentry)

Reviewed-by: Jeff Layton <jlayton@kernel.org>

