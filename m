Return-Path: <linux-fsdevel+bounces-44534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 195DDA6A36A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 11:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F39E13ACF58
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 10:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87CF21C188;
	Thu, 20 Mar 2025 10:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHVSechT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D2D33E4;
	Thu, 20 Mar 2025 10:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742465862; cv=none; b=DKTIDh8rZspGFljKaDSOpWJhFfgFQSum7cqfTk0lFBOR5ujssUfLnqkecbtbMqzynHdXHOW772C6McCkszRIsGEsRI9haRxWcbkjqGmGe8phZAWBoGmoICg4a1KvXndlMFKnftPx5CUukirFv+ybt6wZFjFGBxbaU+UL2dKhpBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742465862; c=relaxed/simple;
	bh=UxHxmFtpaCR9zzEyPSNpGMpJJkn3VSo1jblEudkkpkw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cR3295zmYN7qX6UtDNa/JHxNK+bLN3uSLnAEkq0t9EpYpZx9q7d1NSO4UXgm3kxbcVlcu0ZJlvPjTheqkvIi9K9CR1sWmbKzyP42pY2wtKvRl2l7GJ4E8C1n0wCGH4xs/Dl/lG51mgL+1qsCT7umc1dG7PwMzpUY/ZVWgCvk+AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHVSechT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27830C4CEE8;
	Thu, 20 Mar 2025 10:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742465861;
	bh=UxHxmFtpaCR9zzEyPSNpGMpJJkn3VSo1jblEudkkpkw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=AHVSechTUErKrLAT1iKRqgcqF+YmAs4/Kwhz+jskfLIdPtq724CO2iM32juLGyQC5
	 YyPWaZvQ89BXIjK9ZraSkyrpHAvccTbrzqNTYIhHwjFXNPZKO583biq/Z222ht7Ysp
	 4a8Sx7ztpmsv9eimVjjGxM9HE6ozXxhOE8d8Exn1DkLAtScO3O+Sf2MrOa1aJMQpfw
	 Ub87GxW+RFwLDwo51+zAVKGKnM031Q6q6V05C/754Gbbn3ZyMwEBVMIVKsJsCdlZR5
	 zpgkQuZzOW1Uz2/E22sFldjL91CItxqU7tHNB+UteGICsxDtqEUZa47F1KdiKKxqxJ
	 HWVOYDwQuLTeA==
Message-ID: <f435729f69432b4c6659e1bbff1c8a7866f96bbe.camel@kernel.org>
Subject: Re: [PATCH 1/6] VFS: improve interface for lookup_one functions
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neil@brown.name>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner	 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, David
 Howells <dhowells@redhat.com>,  Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Date: Thu, 20 Mar 2025 06:17:39 -0400
In-Reply-To: <20250319031545.2999807-2-neil@brown.name>
References: <20250319031545.2999807-1-neil@brown.name>
	 <20250319031545.2999807-2-neil@brown.name>
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
> The family of functions:
>   lookup_one()
>   lookup_one_unlocked()
>   lookup_one_positive_unlocked()
>=20
> appear designed to be used by external clients of the filesystem rather
> than by filesystems acting on themselves as the lookup_one_len family
> are used.
>=20
> They are used by:
>    btrfs/ioctl - which is a user-space interface rather than an internal
>      activity
>    exportfs - i.e. from nfsd or the open_by_handle_at interface
>    overlayfs - at access the underlying filesystems
>    smb/server - for file service
>=20
> They should be used by nfsd (more than just the exportfs path) and
> cachefs but aren't.
>=20
> It would help if the documentation didn't claim they should "not be
> called by generic code".
>=20

I read that as generic VFS code, since this is really intended to used
outside that, but I agree the term "generic" is vague here.

> Also the path component name is passed as "name" and "len" which are
> (confusingly?) separate by the "base".  In some cases the len in simply
> "strlen" and so passing a qstr using QSTR() would make the calling
> clearer.
> Other callers do pass separate name and len which are stored in a
> struct.  Sometimes these are already stored in a qstr, other times it
> easily could be.
>=20
> So this patch changes these three functions to receive a 'struct qstr',
> and improves the documentation.
>=20
> QSTR_LEN() is added to make it easy to pass a QSTR containing a known
> len.
>=20
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  Documentation/filesystems/porting.rst |  9 +++++
>  fs/btrfs/ioctl.c                      |  9 ++---
>  fs/exportfs/expfs.c                   |  5 ++-
>  fs/namei.c                            | 51 ++++++++++++---------------
>  fs/overlayfs/namei.c                  | 10 +++---
>  fs/overlayfs/overlayfs.h              |  2 +-
>  fs/overlayfs/readdir.c                |  9 ++---
>  fs/smb/server/smb2pdu.c               |  7 ++--
>  include/linux/dcache.h                |  3 +-
>  include/linux/namei.h                 |  9 +++--
>  10 files changed, 57 insertions(+), 57 deletions(-)
>=20
> diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesy=
stems/porting.rst
> index 6817614e0820..06296ffd1e81 100644
> --- a/Documentation/filesystems/porting.rst
> +++ b/Documentation/filesystems/porting.rst
> @@ -1196,3 +1196,12 @@ should use d_drop();d_splice_alias() and return th=
e result of the latter.
>  If a positive dentry cannot be returned for some reason, in-kernel
>  clients such as cachefiles, nfsd, smb/server may not perform ideally but
>  will fail-safe.
> +
> +---
> +
> +** mandatory**
> +
> +lookup_one(), lookup_one_unlocked(), lookup_one_positive_unlocked() now
> +take a qstr instead of a name and len.  These, not the "one_len"
> +versions, should be used whenever accessing a filesystem from outside
> +that filesysmtem, through a mount point - which will have a mnt_idmap.
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 6c18bad53cd3..f94b638f9478 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -911,7 +911,7 @@ static noinline int btrfs_mksubvol(const struct path =
*parent,
>  	if (error =3D=3D -EINTR)
>  		return error;
> =20
> -	dentry =3D lookup_one(idmap, name, parent->dentry, namelen);
> +	dentry =3D lookup_one(idmap, QSTR_LEN(name, namelen), parent->dentry);
>  	error =3D PTR_ERR(dentry);
>  	if (IS_ERR(dentry))
>  		goto out_unlock;
> @@ -2289,7 +2289,6 @@ static noinline int btrfs_ioctl_snap_destroy(struct=
 file *file,
>  	struct btrfs_ioctl_vol_args_v2 *vol_args2 =3D NULL;
>  	struct mnt_idmap *idmap =3D file_mnt_idmap(file);
>  	char *subvol_name, *subvol_name_ptr =3D NULL;
> -	int subvol_namelen;
>  	int ret =3D 0;
>  	bool destroy_parent =3D false;
> =20
> @@ -2412,10 +2411,8 @@ static noinline int btrfs_ioctl_snap_destroy(struc=
t file *file,
>  			goto out;
>  	}
> =20
> -	subvol_namelen =3D strlen(subvol_name);
> -
>  	if (strchr(subvol_name, '/') ||
> -	    strncmp(subvol_name, "..", subvol_namelen) =3D=3D 0) {
> +	    strcmp(subvol_name, "..") =3D=3D 0) {
>  		ret =3D -EINVAL;
>  		goto free_subvol_name;
>  	}
> @@ -2428,7 +2425,7 @@ static noinline int btrfs_ioctl_snap_destroy(struct=
 file *file,
>  	ret =3D down_write_killable_nested(&dir->i_rwsem, I_MUTEX_PARENT);
>  	if (ret =3D=3D -EINTR)
>  		goto free_subvol_name;
> -	dentry =3D lookup_one(idmap, subvol_name, parent, subvol_namelen);
> +	dentry =3D lookup_one(idmap, QSTR(subvol_name), parent);
>  	if (IS_ERR(dentry)) {
>  		ret =3D PTR_ERR(dentry);
>  		goto out_unlock_dir;
> diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
> index 0c899cfba578..974b432087aa 100644
> --- a/fs/exportfs/expfs.c
> +++ b/fs/exportfs/expfs.c
> @@ -145,7 +145,7 @@ static struct dentry *reconnect_one(struct vfsmount *=
mnt,
>  	if (err)
>  		goto out_err;
>  	dprintk("%s: found name: %s\n", __func__, nbuf);
> -	tmp =3D lookup_one_unlocked(mnt_idmap(mnt), nbuf, parent, strlen(nbuf))=
;
> +	tmp =3D lookup_one_unlocked(mnt_idmap(mnt), QSTR(nbuf), parent);
>  	if (IS_ERR(tmp)) {
>  		dprintk("lookup failed: %ld\n", PTR_ERR(tmp));
>  		err =3D PTR_ERR(tmp);
> @@ -551,8 +551,7 @@ exportfs_decode_fh_raw(struct vfsmount *mnt, struct f=
id *fid, int fh_len,
>  		}
> =20
>  		inode_lock(target_dir->d_inode);
> -		nresult =3D lookup_one(mnt_idmap(mnt), nbuf,
> -				     target_dir, strlen(nbuf));
> +		nresult =3D lookup_one(mnt_idmap(mnt), QSTR(nbuf), target_dir);
>  		if (!IS_ERR(nresult)) {
>  			if (unlikely(nresult->d_inode !=3D result->d_inode)) {
>  				dput(nresult);
> diff --git a/fs/namei.c b/fs/namei.c
> index b5abf456c5f4..75816fa80028 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2922,19 +2922,17 @@ struct dentry *lookup_one_len(const char *name, s=
truct dentry *base, int len)
>  EXPORT_SYMBOL(lookup_one_len);
> =20
>  /**
> - * lookup_one - filesystem helper to lookup single pathname component
> + * lookup_one - lookup single pathname component
>   * @idmap:	idmap of the mount the lookup is performed from
> - * @name:	pathname component to lookup
> + * @name:	qstr holding pathname component to lookup
>   * @base:	base directory to lookup from
> - * @len:	maximum length @len should be interpreted to
>   *
> - * Note that this routine is purely a helper for filesystem usage and sh=
ould
> - * not be called by generic code.
> + * This can be used for in-kernel filesystem clients such as file server=
s.
>   *
>   * The caller must hold base->i_mutex.
>   */
> -struct dentry *lookup_one(struct mnt_idmap *idmap, const char *name,
> -			  struct dentry *base, int len)
> +struct dentry *lookup_one(struct mnt_idmap *idmap, struct qstr name,
> +			  struct dentry *base)
>  {
>  	struct dentry *dentry;
>  	struct qstr this;
> @@ -2942,7 +2940,7 @@ struct dentry *lookup_one(struct mnt_idmap *idmap, =
const char *name,
> =20
>  	WARN_ON_ONCE(!inode_is_locked(base->d_inode));
> =20
> -	err =3D lookup_one_common(idmap, name, base, len, &this);
> +	err =3D lookup_one_common(idmap, name.name, base, name.len, &this);
>  	if (err)
>  		return ERR_PTR(err);
> =20
> @@ -2952,27 +2950,24 @@ struct dentry *lookup_one(struct mnt_idmap *idmap=
, const char *name,
>  EXPORT_SYMBOL(lookup_one);
> =20
>  /**
> - * lookup_one_unlocked - filesystem helper to lookup single pathname com=
ponent
> + * lookup_one_unlocked - lookup single pathname component
>   * @idmap:	idmap of the mount the lookup is performed from
> - * @name:	pathname component to lookup
> + * @name:	qstr olding pathname component to lookup
>   * @base:	base directory to lookup from
> - * @len:	maximum length @len should be interpreted to
>   *
> - * Note that this routine is purely a helper for filesystem usage and sh=
ould
> - * not be called by generic code.
> + * This can be used for in-kernel filesystem clients such as file server=
s.
>   *
>   * Unlike lookup_one_len, it should be called without the parent
> - * i_mutex held, and will take the i_mutex itself if necessary.
> + * i_rwsem held, and will take the i_rwsem itself if necessary.
>   */
>  struct dentry *lookup_one_unlocked(struct mnt_idmap *idmap,
> -				   const char *name, struct dentry *base,
> -				   int len)
> +				   struct qstr name, struct dentry *base)
>  {
>  	struct qstr this;
>  	int err;
>  	struct dentry *ret;
> =20
> -	err =3D lookup_one_common(idmap, name, base, len, &this);
> +	err =3D lookup_one_common(idmap, name.name, base, name.len, &this);
>  	if (err)
>  		return ERR_PTR(err);
> =20
> @@ -2984,12 +2979,10 @@ struct dentry *lookup_one_unlocked(struct mnt_idm=
ap *idmap,
>  EXPORT_SYMBOL(lookup_one_unlocked);
> =20
>  /**
> - * lookup_one_positive_unlocked - filesystem helper to lookup single
> - *				  pathname component
> + * lookup_one_positive_unlocked - lookup single pathname component
>   * @idmap:	idmap of the mount the lookup is performed from
> - * @name:	pathname component to lookup
> + * @name:	qstr holding pathname component to lookup
>   * @base:	base directory to lookup from
> - * @len:	maximum length @len should be interpreted to
>   *
>   * This helper will yield ERR_PTR(-ENOENT) on negatives. The helper retu=
rns
>   * known positive or ERR_PTR(). This is what most of the users want.
> @@ -2998,16 +2991,15 @@ EXPORT_SYMBOL(lookup_one_unlocked);
>   * time, so callers of lookup_one_unlocked() need to be very careful; pi=
nned
>   * positives have >d_inode stable, so this one avoids such problems.
>   *
> - * Note that this routine is purely a helper for filesystem usage and sh=
ould
> - * not be called by generic code.
> + * This can be used for in-kernel filesystem clients such as file server=
s.
>   *
> - * The helper should be called without i_mutex held.
> + * The helper should be called without i_rwsem held.
>   */
>  struct dentry *lookup_one_positive_unlocked(struct mnt_idmap *idmap,
> -					    const char *name,
> -					    struct dentry *base, int len)
> +					    struct qstr name,
> +					    struct dentry *base)
>  {
> -	struct dentry *ret =3D lookup_one_unlocked(idmap, name, base, len);
> +	struct dentry *ret =3D lookup_one_unlocked(idmap, name, base);
> =20
>  	if (!IS_ERR(ret) && d_flags_negative(smp_load_acquire(&ret->d_flags))) =
{
>  		dput(ret);
> @@ -3032,7 +3024,7 @@ EXPORT_SYMBOL(lookup_one_positive_unlocked);
>  struct dentry *lookup_one_len_unlocked(const char *name,
>  				       struct dentry *base, int len)
>  {
> -	return lookup_one_unlocked(&nop_mnt_idmap, name, base, len);
> +	return lookup_one_unlocked(&nop_mnt_idmap, QSTR_LEN(name, len), base);
>  }
>  EXPORT_SYMBOL(lookup_one_len_unlocked);
> =20
> @@ -3047,7 +3039,8 @@ EXPORT_SYMBOL(lookup_one_len_unlocked);
>  struct dentry *lookup_positive_unlocked(const char *name,
>  				       struct dentry *base, int len)
>  {
> -	return lookup_one_positive_unlocked(&nop_mnt_idmap, name, base, len);
> +	return lookup_one_positive_unlocked(&nop_mnt_idmap, QSTR_LEN(name, len)=
,
> +					    base);
>  }
>  EXPORT_SYMBOL(lookup_positive_unlocked);
> =20
> diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> index be5c65d6f848..6a6301e4bba5 100644
> --- a/fs/overlayfs/namei.c
> +++ b/fs/overlayfs/namei.c
> @@ -205,8 +205,8 @@ static struct dentry *ovl_lookup_positive_unlocked(st=
ruct ovl_lookup_data *d,
>  						   struct dentry *base, int len,
>  						   bool drop_negative)
>  {
> -	struct dentry *ret =3D lookup_one_unlocked(mnt_idmap(d->layer->mnt), na=
me,
> -						 base, len);
> +	struct dentry *ret =3D lookup_one_unlocked(mnt_idmap(d->layer->mnt),
> +						 QSTR_LEN(name, len), base);
> =20
>  	if (!IS_ERR(ret) && d_flags_negative(smp_load_acquire(&ret->d_flags))) =
{
>  		if (drop_negative && ret->d_lockref.count =3D=3D 1) {
> @@ -789,8 +789,8 @@ struct dentry *ovl_lookup_index(struct ovl_fs *ofs, s=
truct dentry *upper,
>  	if (err)
>  		return ERR_PTR(err);
> =20
> -	index =3D lookup_one_positive_unlocked(ovl_upper_mnt_idmap(ofs), name.n=
ame,
> -					     ofs->workdir, name.len);
> +	index =3D lookup_one_positive_unlocked(ovl_upper_mnt_idmap(ofs), name,
> +					     ofs->workdir);
>  	if (IS_ERR(index)) {
>  		err =3D PTR_ERR(index);
>  		if (err =3D=3D -ENOENT) {
> @@ -1396,7 +1396,7 @@ bool ovl_lower_positive(struct dentry *dentry)
> =20
>  		this =3D lookup_one_positive_unlocked(
>  				mnt_idmap(parentpath->layer->mnt),
> -				name->name, parentpath->dentry, name->len);
> +				*name, parentpath->dentry);
>  		if (IS_ERR(this)) {
>  			switch (PTR_ERR(this)) {
>  			case -ENOENT:
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 6f2f8f4cfbbc..ceaf4eb199c7 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -402,7 +402,7 @@ static inline struct dentry *ovl_lookup_upper(struct =
ovl_fs *ofs,
>  					      const char *name,
>  					      struct dentry *base, int len)
>  {
> -	return lookup_one(ovl_upper_mnt_idmap(ofs), name, base, len);
> +	return lookup_one(ovl_upper_mnt_idmap(ofs), QSTR_LEN(name, len), base);
>  }
> =20
>  static inline bool ovl_open_flags_need_copy_up(int flags)
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index 881ec5592da5..68df61f4bba7 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -271,7 +271,6 @@ static bool ovl_fill_merge(struct dir_context *ctx, c=
onst char *name,
>  static int ovl_check_whiteouts(const struct path *path, struct ovl_readd=
ir_data *rdd)
>  {
>  	int err;
> -	struct ovl_cache_entry *p;
>  	struct dentry *dentry, *dir =3D path->dentry;
>  	const struct cred *old_cred;
> =20
> @@ -280,9 +279,11 @@ static int ovl_check_whiteouts(const struct path *pa=
th, struct ovl_readdir_data
>  	err =3D down_write_killable(&dir->d_inode->i_rwsem);
>  	if (!err) {
>  		while (rdd->first_maybe_whiteout) {
> -			p =3D rdd->first_maybe_whiteout;
> +			struct ovl_cache_entry *p =3D
> +				rdd->first_maybe_whiteout;
>  			rdd->first_maybe_whiteout =3D p->next_maybe_whiteout;
> -			dentry =3D lookup_one(mnt_idmap(path->mnt), p->name, dir, p->len);
> +			dentry =3D lookup_one(mnt_idmap(path->mnt),
> +					    QSTR_LEN(p->name, p->len), dir);
>  			if (!IS_ERR(dentry)) {
>  				p->is_whiteout =3D ovl_is_whiteout(dentry);
>  				dput(dentry);
> @@ -492,7 +493,7 @@ static int ovl_cache_update(const struct path *path, =
struct ovl_cache_entry *p,
>  		}
>  	}
>  	/* This checks also for xwhiteouts */
> -	this =3D lookup_one(mnt_idmap(path->mnt), p->name, dir, p->len);
> +	this =3D lookup_one(mnt_idmap(path->mnt), QSTR_LEN(p->name, p->len), di=
r);
>  	if (IS_ERR_OR_NULL(this) || !this->d_inode) {
>  		/* Mark a stale entry */
>  		p->is_whiteout =3D true;
> diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
> index f1efcd027475..c862e3bd4531 100644
> --- a/fs/smb/server/smb2pdu.c
> +++ b/fs/smb/server/smb2pdu.c
> @@ -4091,9 +4091,10 @@ static int process_query_dir_entries(struct smb2_q=
uery_dir_private *priv)
>  			return -EINVAL;
> =20
>  		lock_dir(priv->dir_fp);
> -		dent =3D lookup_one(idmap, priv->d_info->name,
> -				  priv->dir_fp->filp->f_path.dentry,
> -				  priv->d_info->name_len);
> +		dent =3D lookup_one(idmap,
> +				  QSTR_LEN(priv->d_info->name,
> +					   priv->d_info->name_len),
> +				  priv->dir_fp->filp->f_path.dentry);
>  		unlock_dir(priv->dir_fp);
> =20
>  		if (IS_ERR(dent)) {
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index 45bff10d3773..1f01f4e734c5 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -57,7 +57,8 @@ struct qstr {
>  };
> =20
>  #define QSTR_INIT(n,l) { { { .len =3D l } }, .name =3D n }
> -#define QSTR(n) (struct qstr)QSTR_INIT(n, strlen(n))
> +#define QSTR_LEN(n,l) (struct qstr)QSTR_INIT(n,l)
> +#define QSTR(n) QSTR_LEN(n, strlen(n))
> =20
>  extern const struct qstr empty_name;
>  extern const struct qstr slash_name;
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index e3042176cdf4..508dae67e3c5 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -73,13 +73,12 @@ extern struct dentry *try_lookup_one_len(const char *=
, struct dentry *, int);
>  extern struct dentry *lookup_one_len(const char *, struct dentry *, int)=
;
>  extern struct dentry *lookup_one_len_unlocked(const char *, struct dentr=
y *, int);
>  extern struct dentry *lookup_positive_unlocked(const char *, struct dent=
ry *, int);
> -struct dentry *lookup_one(struct mnt_idmap *, const char *, struct dentr=
y *, int);
> +struct dentry *lookup_one(struct mnt_idmap *, struct qstr, struct dentry=
 *);
>  struct dentry *lookup_one_unlocked(struct mnt_idmap *idmap,
> -				   const char *name, struct dentry *base,
> -				   int len);
> +				   struct qstr name, struct dentry *base);
>  struct dentry *lookup_one_positive_unlocked(struct mnt_idmap *idmap,
> -					    const char *name,
> -					    struct dentry *base, int len);
> +					    struct qstr name,
> +					    struct dentry *base);
> =20
>  extern int follow_down_one(struct path *);
>  extern int follow_down(struct path *path, unsigned int flags);

Reviewed-by: Jeff Layton <jlayton@kernel.org>

