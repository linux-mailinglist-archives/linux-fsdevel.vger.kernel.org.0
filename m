Return-Path: <linux-fsdevel+bounces-44536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D867BA6A37A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 11:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4990317E476
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 10:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC8B22332A;
	Thu, 20 Mar 2025 10:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cyj/xb6O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9923987D;
	Thu, 20 Mar 2025 10:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742466130; cv=none; b=obSoqFIDSU3nsXaEL9lqTYZqk1qS6qlRx6XDYm+L/RWtpUOpKzXpNpaUUJ95JFw8tNbH5VZACko2a2mrsYDRiqc9v2mhgi6uvLoFZgd3yBvwEri8Le6Llh8jCqXXWwMoIKPo4NL2SY6viGg85wa+Cd4lsveWTM/+Qurmt9PeCHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742466130; c=relaxed/simple;
	bh=gmRz2/NMlDM53NGE2aacgcAmvCTTT1LFk57cGWwn6kM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PubsvW2pCbacsPWUJs+mu4l5rM/+qJI4yB6FsZCpe/vAQi7vCAUaAFLfsMRCtzARujakonHfd9vkbYnLCdI6ooMxqkPoap+u5nwKcZe7vXcN/XI+gaGtJo22fXa8uOUOY3TxkmYHGSVubuZWDK/Bbfmn7EBnq+6iOEFuCNx0qp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cyj/xb6O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B26DC4CEDD;
	Thu, 20 Mar 2025 10:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742466130;
	bh=gmRz2/NMlDM53NGE2aacgcAmvCTTT1LFk57cGWwn6kM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=cyj/xb6OaaBrbvRnW8Nx2QXMSheRvTYnII2Ik6rkWJJdznQySY9cbk0oub41gvVUV
	 ke83j1vZ0JjGJqwoCLzhXD/5WHIla/8J3uzjWf291efpgJUkiV3b9+oOlohJ9yWijH
	 HOWWyDRIuE4oydL0cwii+0yZhES60MaoevkRD2CXgrAndsmR/yg4/jnWM4fytRgtWY
	 mNm028lzYvdab0DxbKMzsX0uGogoAsQqpLmHRRIXCWjzahgDgE5NZ40BfNh+99zPCq
	 DdJKcmYiYUzQvyLci4iV7ZKg/0cD6vquyPv1QqGIu3sPHWvOM0WI7Pu6u0G0jVVry2
	 ZE6KKtF/3Om5A==
Message-ID: <ee36dab38583d28205c4b40a87126c44cab69dc9.camel@kernel.org>
Subject: Re: [PATCH 3/6] cachefiles: Use lookup_one() rather than
 lookup_one_len()
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neil@brown.name>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner	 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, David
 Howells <dhowells@redhat.com>,  Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Date: Thu, 20 Mar 2025 06:22:08 -0400
In-Reply-To: <20250319031545.2999807-4-neil@brown.name>
References: <20250319031545.2999807-1-neil@brown.name>
	 <20250319031545.2999807-4-neil@brown.name>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
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

On Wed, 2025-03-19 at 14:01 +1100, NeilBrown wrote:
> From: NeilBrown <neilb@suse.de>
>=20
> cachefiles uses some VFS interfaces (such as vfs_mkdir) which take an
> explicit mnt_idmap, and it passes &nop_mnt_idmap as cachefiles doesn't
> yet support idmapped mounts.
>=20
> It also uses the lookup_one_len() family of functions which implicitly
> use &nop_mnt_idmap.  This mixture of implicit and explicit could be
> confusing.  When we eventually update cachefiles to support idmap mounts =
it

Is that something we ever plan to do?

> would be best if all places which need an idmap determined from the
> mount point were similar and easily found.
>=20
> So this patch changes cachefiles to use lookup_one(), lookup_one_unlocked=
(),
> and lookup_one_positive_unlocked(), passing &nop_mnt_idmap.
>=20
> This has the benefit of removing the remaining user of the
> lookup_one_len functions where permission checking is actually needed.
> Other callers don't care about permission checking and using these
> function only where permission checking is needed is a valuable
> simplification.
>=20
> This requires passing the name in a qstr.  This is easily done with
> QSTR() as the name is always nul terminated, and often strlen is used
> anyway.  ->d_name_len is removed as no longer useful.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/cachefiles/internal.h |  1 -
>  fs/cachefiles/key.c      |  1 -
>  fs/cachefiles/namei.c    | 14 +++++++-------
>  3 files changed, 7 insertions(+), 9 deletions(-)
>=20
> diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
> index 38c236e38cef..b62cd3e9a18e 100644
> --- a/fs/cachefiles/internal.h
> +++ b/fs/cachefiles/internal.h
> @@ -71,7 +71,6 @@ struct cachefiles_object {
>  	int				debug_id;
>  	spinlock_t			lock;
>  	refcount_t			ref;
> -	u8				d_name_len;	/* Length of filename */
>  	enum cachefiles_content		content_info:8;	/* Info about content presence=
 */
>  	unsigned long			flags;
>  #define CACHEFILES_OBJECT_USING_TMPFILE	0		/* Have an unlinked tmpfile *=
/
> diff --git a/fs/cachefiles/key.c b/fs/cachefiles/key.c
> index bf935e25bdbe..4927b533b9ae 100644
> --- a/fs/cachefiles/key.c
> +++ b/fs/cachefiles/key.c
> @@ -132,7 +132,6 @@ bool cachefiles_cook_key(struct cachefiles_object *ob=
ject)
>  success:
>  	name[len] =3D 0;
>  	object->d_name =3D name;
> -	object->d_name_len =3D len;
>  	_leave(" =3D %s", object->d_name);
>  	return true;
>  }
> diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> index 83a60126de0f..4fc6f3efd3d9 100644
> --- a/fs/cachefiles/namei.c
> +++ b/fs/cachefiles/namei.c
> @@ -98,7 +98,7 @@ struct dentry *cachefiles_get_directory(struct cachefil=
es_cache *cache,
>  retry:
>  	ret =3D cachefiles_inject_read_error();
>  	if (ret =3D=3D 0)
> -		subdir =3D lookup_one_len(dirname, dir, strlen(dirname));
> +		subdir =3D lookup_one(&nop_mnt_idmap, QSTR(dirname), dir);
>  	else
>  		subdir =3D ERR_PTR(ret);
>  	trace_cachefiles_lookup(NULL, dir, subdir);
> @@ -337,7 +337,7 @@ int cachefiles_bury_object(struct cachefiles_cache *c=
ache,
>  		return -EIO;
>  	}
> =20
> -	grave =3D lookup_one_len(nbuffer, cache->graveyard, strlen(nbuffer));
> +	grave =3D lookup_one(&nop_mnt_idmap, QSTR(nbuffer), cache->graveyard);
>  	if (IS_ERR(grave)) {
>  		unlock_rename(cache->graveyard, dir);
>  		trace_cachefiles_vfs_error(object, d_inode(cache->graveyard),
> @@ -629,8 +629,8 @@ bool cachefiles_look_up_object(struct cachefiles_obje=
ct *object)
>  	/* Look up path "cache/vol/fanout/file". */
>  	ret =3D cachefiles_inject_read_error();
>  	if (ret =3D=3D 0)
> -		dentry =3D lookup_positive_unlocked(object->d_name, fan,
> -						  object->d_name_len);
> +		dentry =3D lookup_one_positive_unlocked(&nop_mnt_idmap,
> +						      QSTR(object->d_name), fan);
>  	else
>  		dentry =3D ERR_PTR(ret);
>  	trace_cachefiles_lookup(object, fan, dentry);
> @@ -682,7 +682,7 @@ bool cachefiles_commit_tmpfile(struct cachefiles_cach=
e *cache,
>  	inode_lock_nested(d_inode(fan), I_MUTEX_PARENT);
>  	ret =3D cachefiles_inject_read_error();
>  	if (ret =3D=3D 0)
> -		dentry =3D lookup_one_len(object->d_name, fan, object->d_name_len);
> +		dentry =3D lookup_one(&nop_mnt_idmap, QSTR(object->d_name), fan);
>  	else
>  		dentry =3D ERR_PTR(ret);
>  	if (IS_ERR(dentry)) {
> @@ -701,7 +701,7 @@ bool cachefiles_commit_tmpfile(struct cachefiles_cach=
e *cache,
>  		dput(dentry);
>  		ret =3D cachefiles_inject_read_error();
>  		if (ret =3D=3D 0)
> -			dentry =3D lookup_one_len(object->d_name, fan, object->d_name_len);
> +			dentry =3D lookup_one(&nop_mnt_idmap, QSTR(object->d_name), fan);
>  		else
>  			dentry =3D ERR_PTR(ret);
>  		if (IS_ERR(dentry)) {
> @@ -750,7 +750,7 @@ static struct dentry *cachefiles_lookup_for_cull(stru=
ct cachefiles_cache *cache,
> =20
>  	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
> =20
> -	victim =3D lookup_one_len(filename, dir, strlen(filename));
> +	victim =3D lookup_one(&nop_mnt_idmap, QSTR(filename), dir);
>  	if (IS_ERR(victim))
>  		goto lookup_error;
>  	if (d_is_negative(victim))

Patch looks sane though.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

