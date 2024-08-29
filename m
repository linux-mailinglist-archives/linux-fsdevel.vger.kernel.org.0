Return-Path: <linux-fsdevel+bounces-27868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 773AF964902
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 16:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05D021F218D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 14:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7971B140A;
	Thu, 29 Aug 2024 14:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pI71RdFk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD631AED38;
	Thu, 29 Aug 2024 14:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942950; cv=none; b=nRScNRbPQTkpaAu5bbXJhdQT1XiDeYdQtH7NJ/7k3CtVNSu2baOHtW0TfqziNu705nzrs8m16SNnzmvvE9OpG3FKnjS64IP0M1ggDW3XanYkVd0idSVqLzXYN+3I/e6+PpDo+BxNtP+9gUG9EwXNsdv+T7dSAR3P+kKpcTi1lJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942950; c=relaxed/simple;
	bh=P6LSYolCmWbwlJC9EuWxIaAA/mvYhHG1w5mu6bJF5bg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z/eK7o3j8uQeJZ+O6QhHStKpkPnZxlc3pvEamK5q8cvBpIbam+7RiqlN6QfC4WIOibZKLfycSs3PCUykWF8KTNpQCMWE4RG1ryVZA+DmidyYzkhsZXIhDsr67ZOHcGXKgQtmNl31t2FtW22jX1b5e/ERkUWrCIsKzJfBh26HOHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pI71RdFk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49588C4CEC1;
	Thu, 29 Aug 2024 14:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724942950;
	bh=P6LSYolCmWbwlJC9EuWxIaAA/mvYhHG1w5mu6bJF5bg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=pI71RdFkw/6UpMkuKOVTRhWryaQBHCydsuSgikmScV5cax12u/J9LwQgkKkCR7w4L
	 2uHbsQkJmA8N8I0kUOVI4GAk+nQtAnndBMkdQXl62RAVfNJrWAMXnkqj0FHqBRJW01
	 OzXirRsPXu/Tl06436If9UjfxEwnINuVAjEEd3RTgKdrT3/1PXDxwEPRnPKlKeB6I/
	 AHBlpF02Jvq5MR/ANq7Aq0AfDadhhMWy11XP4kvpuXWFixJgumCzDOz7FetgwRpsHz
	 YRqQy0FXs+z65C9O09Xx5o1+96bkO8HhcYkQWGb4J5sd91bx/V6sKhVkpS+AtZcER6
	 n2vZ6cJ1VHSPw==
Message-ID: <3b6491dfc9dec7e4c3b63cce7e2d6a09675654fa.camel@kernel.org>
Subject: Re: [PATCH v14 09/25] nfsd: add nfsd_file_acquire_local()
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, Anna Schumaker <anna@kernel.org>, 
 Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
 linux-fsdevel@vger.kernel.org
Date: Thu, 29 Aug 2024 10:49:08 -0400
In-Reply-To: <20240829010424.83693-10-snitzer@kernel.org>
References: <20240829010424.83693-1-snitzer@kernel.org>
	 <20240829010424.83693-10-snitzer@kernel.org>
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

On Wed, 2024-08-28 at 21:04 -0400, Mike Snitzer wrote:
> From: NeilBrown <neilb@suse.de>
>=20
> nfsd_file_acquire_local() can be used to look up a file by filehandle
> without having a struct svc_rqst.  This can be used by NFS LOCALIO to
> allow the NFS client to bypass the NFS protocol to directly access a
> file provided by the NFS server which is running in the same kernel.
>=20
> In nfsd_file_do_acquire() care is taken to always use fh_verify() if
> rqstp is not NULL (as is the case for non-LOCALIO callers).  Otherwise
> the non-LOCALIO callers will not supply the correct and required
> arguments to __fh_verify (e.g. gssclient isn't passed).
>=20
> Introduce fh_verify_local() wrapper around __fh_verify to make it
> clear that LOCALIO is intended caller.
>=20
> Also, use GC for nfsd_file returned by nfsd_file_acquire_local.  GC
> offers performance improvements if/when a file is reopened before
> launderette cleans it from the filecache's LRU.
>=20
> Suggested-by: Jeff Layton <jlayton@kernel.org> # use filecache's GC
> Signed-off-by: NeilBrown <neilb@suse.de>
> Co-developed-by: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/filecache.c | 71 ++++++++++++++++++++++++++++++++++++++++-----
>  fs/nfsd/filecache.h |  3 ++
>  fs/nfsd/nfsfh.c     | 39 +++++++++++++++++++++++++
>  fs/nfsd/nfsfh.h     |  2 ++
>  4 files changed, 108 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 9e9d246f993c..2dc72de31f61 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -982,12 +982,14 @@ nfsd_file_is_cached(struct inode *inode)
>  }
> =20
>  static __be32
> -nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
> +nfsd_file_do_acquire(struct svc_rqst *rqstp, struct net *net,
> +		     struct svc_cred *cred,
> +		     struct auth_domain *client,
> +		     struct svc_fh *fhp,
>  		     unsigned int may_flags, struct file *file,
>  		     struct nfsd_file **pnf, bool want_gc)
>  {
>  	unsigned char need =3D may_flags & NFSD_FILE_MAY_MASK;
> -	struct net *net =3D SVC_NET(rqstp);
>  	struct nfsd_file *new, *nf;
>  	bool stale_retry =3D true;
>  	bool open_retry =3D true;
> @@ -996,8 +998,13 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct =
svc_fh *fhp,
>  	int ret;
> =20
>  retry:
> -	status =3D fh_verify(rqstp, fhp, S_IFREG,
> -				may_flags|NFSD_MAY_OWNER_OVERRIDE);
> +	if (rqstp) {
> +		status =3D fh_verify(rqstp, fhp, S_IFREG,
> +				   may_flags|NFSD_MAY_OWNER_OVERRIDE);
> +	} else {
> +		status =3D fh_verify_local(net, cred, client, fhp, S_IFREG,
> +					 may_flags|NFSD_MAY_OWNER_OVERRIDE);
> +	}
>  	if (status !=3D nfs_ok)
>  		return status;
>  	inode =3D d_inode(fhp->fh_dentry);
> @@ -1143,7 +1150,8 @@ __be32
>  nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		     unsigned int may_flags, struct nfsd_file **pnf)
>  {
> -	return nfsd_file_do_acquire(rqstp, fhp, may_flags, NULL, pnf, true);
> +	return nfsd_file_do_acquire(rqstp, SVC_NET(rqstp), NULL, NULL,
> +				    fhp, may_flags, NULL, pnf, true);
>  }
> =20
>  /**
> @@ -1167,7 +1175,55 @@ __be32
>  nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		  unsigned int may_flags, struct nfsd_file **pnf)
>  {
> -	return nfsd_file_do_acquire(rqstp, fhp, may_flags, NULL, pnf, false);
> +	return nfsd_file_do_acquire(rqstp, SVC_NET(rqstp), NULL, NULL,
> +				    fhp, may_flags, NULL, pnf, false);
> +}
> +
> +/**
> + * nfsd_file_acquire_local - Get a struct nfsd_file with an open file fo=
r localio
> + * @net: The network namespace in which to perform a lookup
> + * @cred: the user credential with which to validate access
> + * @client: the auth_domain for LOCALIO lookup
> + * @fhp: the NFS filehandle of the file to be opened
> + * @may_flags: NFSD_MAY_ settings for the file
> + * @pnf: OUT: new or found "struct nfsd_file" object
> + *
> + * This file lookup interface provide access to a file given the
> + * filehandle and credential.  No connection-based authorisation
> + * is performed and in that way it is quite different to other
> + * file access mediated by nfsd.  It allows a kernel module such as the =
NFS
> + * client to reach across network and filesystem namespaces to access
> + * a file.  The security implications of this should be carefully
> + * considered before use.
> + *
> + * The nfsd_file object returned by this API is reference-counted
> + * and garbage-collected. The object is retained for a few
> + * seconds after the final nfsd_file_put() in case the caller
> + * wants to re-use it.
> + *
> + * Return values:
> + *   %nfs_ok - @pnf points to an nfsd_file with its reference
> + *   count boosted.
> + *
> + * On error, an nfsstat value in network byte order is returned.
> + */
> +__be32
> +nfsd_file_acquire_local(struct net *net, struct svc_cred *cred,
> +			struct auth_domain *client, struct svc_fh *fhp,
> +			unsigned int may_flags, struct nfsd_file **pnf)
> +{
> +	/*
> +	 * Save creds before calling nfsd_file_do_acquire() (which calls
> +	 * nfsd_setuser). Important because caller (LOCALIO) is from
> +	 * client context.
> +	 */
> +	const struct cred *save_cred =3D get_current_cred();
> +	__be32 beres;
> +
> +	beres =3D nfsd_file_do_acquire(NULL, net, cred, client,
> +				     fhp, may_flags, NULL, pnf, true);
> +	revert_creds(save_cred);
> +	return beres;
>  }
> =20
>  /**
> @@ -1193,7 +1249,8 @@ nfsd_file_acquire_opened(struct svc_rqst *rqstp, st=
ruct svc_fh *fhp,
>  			 unsigned int may_flags, struct file *file,
>  			 struct nfsd_file **pnf)
>  {
> -	return nfsd_file_do_acquire(rqstp, fhp, may_flags, file, pnf, false);
> +	return nfsd_file_do_acquire(rqstp, SVC_NET(rqstp), NULL, NULL,
> +				    fhp, may_flags, file, pnf, false);
>  }
> =20
>  /*
> diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> index 3fbec24eea6c..26ada78b8c1e 100644
> --- a/fs/nfsd/filecache.h
> +++ b/fs/nfsd/filecache.h
> @@ -66,5 +66,8 @@ __be32 nfsd_file_acquire(struct svc_rqst *rqstp, struct=
 svc_fh *fhp,
>  __be32 nfsd_file_acquire_opened(struct svc_rqst *rqstp, struct svc_fh *f=
hp,
>  		  unsigned int may_flags, struct file *file,
>  		  struct nfsd_file **nfp);
> +__be32 nfsd_file_acquire_local(struct net *net, struct svc_cred *cred,
> +			       struct auth_domain *client, struct svc_fh *fhp,
> +			       unsigned int may_flags, struct nfsd_file **pnf);
>  int nfsd_file_cache_stats_show(struct seq_file *m, void *v);
>  #endif /* _FS_NFSD_FILECACHE_H */
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index 80c06e170e9a..49468e478d23 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -301,6 +301,22 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rq=
stp, struct net *net,
>  	return error;
>  }
> =20
> +/**
> + * __fh_verify - filehandle lookup and access checking
> + * @rqstp: RPC transaction context, or NULL
> + * @net: net namespace in which to perform the export lookup
> + * @cred: RPC user credential
> + * @client: RPC auth domain
> + * @gssclient: RPC GSS auth domain, or NULL
> + * @fhp: filehandle to be verified
> + * @type: expected type of object pointed to by filehandle
> + * @access: type of access needed to object
> + *
> + * This internal API can be used by callers who do not have an RPC
> + * transaction context (ie are not running in an nfsd thread).
> + *
> + * See fh_verify() for further descriptions of @fhp, @type, and @access.
> + */
>  static __be32
>  __fh_verify(struct svc_rqst *rqstp,
>  	    struct net *net, struct svc_cred *cred,
> @@ -382,6 +398,29 @@ __fh_verify(struct svc_rqst *rqstp,
>  	return error;
>  }
> =20
> +/**
> + * fh_verify_local - filehandle lookup and access checking
> + * @net: net namespace in which to perform the export lookup
> + * @cred: RPC user credential
> + * @client: RPC auth domain
> + * @fhp: filehandle to be verified
> + * @type: expected type of object pointed to by filehandle
> + * @access: type of access needed to object
> + *
> + * This API can be used by callers who do not have an RPC
> + * transaction context (ie are not running in an nfsd thread).
> + *
> + * See fh_verify() for further descriptions of @fhp, @type, and @access.
> + */
> +__be32
> +fh_verify_local(struct net *net, struct svc_cred *cred,
> +		struct auth_domain *client, struct svc_fh *fhp,
> +		umode_t type, int access)
> +{
> +	return __fh_verify(NULL, net, cred, client, NULL,
> +			   fhp, type, access);
> +}
> +
>  /**
>   * fh_verify - filehandle lookup and access checking
>   * @rqstp: pointer to current rpc request
> diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> index 8d46e203d139..5b7394801dc4 100644
> --- a/fs/nfsd/nfsfh.h
> +++ b/fs/nfsd/nfsfh.h
> @@ -217,6 +217,8 @@ extern char * SVCFH_fmt(struct svc_fh *fhp);
>   * Function prototypes
>   */
>  __be32	fh_verify(struct svc_rqst *, struct svc_fh *, umode_t, int);
> +__be32	fh_verify_local(struct net *, struct svc_cred *, struct auth_doma=
in *,
> +			struct svc_fh *, umode_t, int);
>  __be32	fh_compose(struct svc_fh *, struct svc_export *, struct dentry *,=
 struct svc_fh *);
>  __be32	fh_update(struct svc_fh *);
>  void	fh_put(struct svc_fh *);

Reviewed-by: Jeff Layton <jlayton@kernel.org>

