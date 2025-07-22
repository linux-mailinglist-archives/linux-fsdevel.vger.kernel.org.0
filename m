Return-Path: <linux-fsdevel+bounces-55761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AF0B0E658
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 00:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2D141753D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 22:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3F42882CE;
	Tue, 22 Jul 2025 22:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R27Xon8Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16C828725F;
	Tue, 22 Jul 2025 22:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753222793; cv=none; b=n0yUXBf7MBmCJ8ZZOBaynDPSFYO9CEf/V7nLZsamXlyZTt3mNNtUhQZg0SrK2wUPlFT98+40RF1NrcbIr1kNLMWE8u2uZqICLXUzcehxwar3F/7FLLwqMAuRfZrdADpoQzk5VaLrj1wOZMjG2hl79ZFZZ63rN7HYvgcHQyVFFQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753222793; c=relaxed/simple;
	bh=ssaXsvIAkUPfB6W28Y4tZMmth7R68kQGLxxToq6hOrQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oN6tKJJZkP7NQgcHoDgNwXBS7lJehGWdTbo4+LhsEi50NC0SXzSHCvE+nE1t7OeCV3kURnbzoGRPv4vk+78znc6z1lIMYRcffvUxWE0CIYJSQT4iYe6qv6cmjw1lcZdEDNJEUMpmaFWqU0Hr4tT7e0Nu2BZ75TzT3i0Ze/FLzAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R27Xon8Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23EC2C4CEEB;
	Tue, 22 Jul 2025 22:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753222793;
	bh=ssaXsvIAkUPfB6W28Y4tZMmth7R68kQGLxxToq6hOrQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=R27Xon8QZBSfwP0XyetYRyVj778L3QdJdtT8mCHuXIV3p2TBNPvsJ0A6HhdGn64xV
	 ZE5bQEzE6EEUvgJISR9VfmluRLhXVcFpSpoAsVrya+tyJcyG1p0cCk3VPmK/GeTXP9
	 ULbFnsBJcX3hPIxUSXLzi/Xh45TtMIUshFRzHc6IAuu4X35ACi7Ev2OEckMD0X+eZ6
	 g77spQNk26BlIGPs4T2rtj2BU/Izk6bZjeDhCNh8m/MevvIY5KZQXgRtOc+qcnFijH
	 2eFwB9NqJpVadYHLwdJwD8xKt2OXyHY37W8TpppdHySrtu8JnggELOxWBxlOPlWZ7p
	 5PFgTDkmiAQlQ==
Message-ID: <e28297a2abe8253c0aa590831b3857432bef60f7.camel@kernel.org>
Subject: Re: [PATCH 2/2] vfs: fix delegated timestamp handling in
 setattr_copy()
From: Jeff Layton <jlayton@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner	
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Steven Rostedt	
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Chuck Lever
 <chuck.lever@oracle.com>, NeilBrown	 <neil@brown.name>, Olga Kornievskaia
 <okorniev@redhat.com>, Dai Ngo	 <Dai.Ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Date: Tue, 22 Jul 2025 18:19:51 -0400
In-Reply-To: <20250722-nfsd-testing-v1-2-31321c7fc97f@kernel.org>
References: <20250722-nfsd-testing-v1-0-31321c7fc97f@kernel.org>
	 <20250722-nfsd-testing-v1-2-31321c7fc97f@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
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

On Tue, 2025-07-22 at 14:52 -0400, Jeff Layton wrote:
> There are a couple of problems with delegated timestamp updates via
> setattr:
>=20
> 1/ the ia_ctime is always clobbered by notify_change(), so setting the
> ia_ctime to the same value as the ia_mtime in nfsd4_decode_fattr4()
> doesn't work.
>=20
> 2/ while it does test the ctime's validity vs. the existing ctime and
> current_time(), the same is not done for the atime or mtime. The spec
> requires this.
>=20
> Add a new setattr_copy_delegts() function that handles updating the
> timestamps whenever ATTR_DELEG is set. For both atime and mtime,
> validate and clamp the value to current_time(), and then set it. If the
> mtime gets updated, also update the ctime.
>=20
> Fixes: 7f2c86cba3c5 ("fs: handle delegated timestamps in setattr_copy_mgt=
ime")
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/attr.c         | 52 ++++++++++++++++++++++++++++++++++++++-----------=
---
>  fs/nfsd/nfs4xdr.c |  4 +---
>  2 files changed, 39 insertions(+), 17 deletions(-)
>=20
> diff --git a/fs/attr.c b/fs/attr.c
> index 9caf63d20d03e86c535e9c8c91d49c2a34d34b7a..3e636943d26a36aeeed0ff8b4=
28b6dd3e63f8dde 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -287,14 +287,7 @@ static void setattr_copy_mgtime(struct inode *inode,=
 const struct iattr *attr)
>  	struct timespec64 now;
> =20
>  	if (ia_valid & ATTR_CTIME) {
> -		/*
> -		 * In the case of an update for a write delegation, we must respect
> -		 * the value in ia_ctime and not use the current time.
> -		 */
> -		if (ia_valid & ATTR_DELEG)
> -			now =3D inode_set_ctime_deleg(inode, attr->ia_ctime);
> -		else
> -			now =3D inode_set_ctime_current(inode);
> +		now =3D inode_set_ctime_current(inode);
>  	} else {
>  		/* If ATTR_CTIME isn't set, then ATTR_MTIME shouldn't be either. */
>  		WARN_ON_ONCE(ia_valid & ATTR_MTIME);
> @@ -312,6 +305,39 @@ static void setattr_copy_mgtime(struct inode *inode,=
 const struct iattr *attr)
>  		inode_set_mtime_to_ts(inode, now);
>  }
> =20
> +/*
> + * Skip update if new value is older than existing time. Clamp
> + * to current_time() if it's in the future.
> + */
> +static void setattr_copy_delegts(struct inode *inode, const struct iattr=
 *attr)
> +{
> +	struct timespec64 now =3D current_time(inode);
> +	unsigned int ia_valid =3D attr->ia_valid;
> +
> +	if (ia_valid & ATTR_MTIME) {
> +		struct timespec64 cur =3D inode_get_mtime(inode);
> +
> +		if (timespec64_compare(&attr->ia_mtime, &cur) > 0) {
> +			if (timespec64_compare(&attr->ia_mtime, &now) > 0)
> +				inode_set_mtime_to_ts(inode, now);
> +			else
> +				inode_set_mtime_to_ts(inode, attr->ia_mtime);
> +			inode_set_ctime_deleg(inode, attr->ia_mtime);
> +		}
> +	}
> +
> +	if (ia_valid & ATTR_ATIME) {
> +		struct timespec64 cur =3D inode_get_atime(inode);
> +
> +		if (timespec64_compare(&attr->ia_atime, &cur) > 0) {
> +			if (timespec64_compare(&attr->ia_atime, &now) > 0)
> +				inode_set_atime_to_ts(inode, now);
> +			else
> +				inode_set_atime_to_ts(inode, attr->ia_atime);
> +		}
> +	}
> +}
> +
>  /**
>   * setattr_copy - copy simple metadata updates into the generic inode
>   * @idmap:	idmap of the mount the inode was found from
> @@ -352,6 +378,8 @@ void setattr_copy(struct mnt_idmap *idmap, struct ino=
de *inode,
>  		inode->i_mode =3D mode;
>  	}
> =20
> +	if (ia_valid & ATTR_DELEG)
> +		return setattr_copy_delegts(inode, attr);
>  	if (is_mgtime(inode))
>  		return setattr_copy_mgtime(inode, attr);
> =20
> @@ -359,12 +387,8 @@ void setattr_copy(struct mnt_idmap *idmap, struct in=
ode *inode,
>  		inode_set_atime_to_ts(inode, attr->ia_atime);
>  	if (ia_valid & ATTR_MTIME)
>  		inode_set_mtime_to_ts(inode, attr->ia_mtime);
> -	if (ia_valid & ATTR_CTIME) {
> -		if (ia_valid & ATTR_DELEG)
> -			inode_set_ctime_deleg(inode, attr->ia_ctime);
> -		else
> -			inode_set_ctime_to_ts(inode, attr->ia_ctime);
> -	}
> +	if (ia_valid & ATTR_CTIME)
> +		inode_set_ctime_to_ts(inode, attr->ia_ctime);
>  }
>  EXPORT_SYMBOL(setattr_copy);
> =20
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 8b68f74a8cf08c6aa1305a2a3093467656085e4a..e6899a3502332d686138abee2=
284c87fc7fbc0ae 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -537,9 +537,7 @@ nfsd4_decode_fattr4(struct nfsd4_compoundargs *argp, =
u32 *bmval, u32 bmlen,
>  			return nfserr_bad_xdr;
>  		iattr->ia_mtime.tv_sec =3D modify.seconds;
>  		iattr->ia_mtime.tv_nsec =3D modify.nseconds;
> -		iattr->ia_ctime.tv_sec =3D modify.seconds;
> -		iattr->ia_ctime.tv_nsec =3D modify.seconds;
> -		iattr->ia_valid |=3D ATTR_CTIME | ATTR_MTIME | ATTR_MTIME_SET | ATTR_D=
ELEG;
> +		iattr->ia_valid |=3D ATTR_MTIME | ATTR_MTIME_SET | ATTR_DELEG;
>  	}
> =20
>  	/* request sanity: did attrlist4 contain the expected number of words? =
*/

Based on Trond's comments in this thread, I think I'm going to have to
respin this:

https://lore.kernel.org/linux-nfs/bfa20f4a81e0c2d5df8525476fb29af156f4f5f1.=
camel@kernel.org/

I'll post a v2 in the near future.

Cheers,
--=20
Jeff Layton <jlayton@kernel.org>

