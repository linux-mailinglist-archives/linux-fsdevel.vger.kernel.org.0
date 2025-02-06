Return-Path: <linux-fsdevel+bounces-41087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD662A2AB67
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 15:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 927A7188A41F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 14:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF45A1C6FEA;
	Thu,  6 Feb 2025 14:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHhl39fi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318AC1A5BA7;
	Thu,  6 Feb 2025 14:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738852250; cv=none; b=T7GjqYuTAHxP04NIEl/RU+KYyvmOgHQyNl7OaE0YKgPGjtRK2hhvcATt3gLwqFyY/r7qQNONQJTFTDxr+e3PW605NIfIwISHv+evPXHsVIuZc/+TixrhkBtB3luGVWxGcdqox02vfW6mKJMXJD4X9PgdAnT/RxFIaRVj6lRx6SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738852250; c=relaxed/simple;
	bh=9Jj4yeadvzGMfimGhwfnhWOxW264mdl0ABUvNCg6iYY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YHLu9kE+6bP0GkPgQfpPi8pTmWBA90EGhAqnGrNhjycl/anodn1pwmgZlXtt4BnnGiaBNt6Gn44f6ZAwnkUFcxkCiYxJDKMM9T+U0rlKdLmyxgcwOSj/nyqjD1ll3f5+L9d2/BR4t6//qmEa3Byv6NytP0MnhNiYfAwonNDFKC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHhl39fi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1AEC4CEDD;
	Thu,  6 Feb 2025 14:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738852249;
	bh=9Jj4yeadvzGMfimGhwfnhWOxW264mdl0ABUvNCg6iYY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=KHhl39fihyyqG7RwpPK4rviN30vYZOzFbMcNeUOs6jp8dzP4Y33sNGaHMyjWz1ZrV
	 FjiKcd22oC1xAb1oiivg7KT/nDMUPRAvwpiyHrkdjnFf4YlAsm0KnS1HygVEbRDw6z
	 Vun5IjpL3dSHKLrWw3ymstwH657nmhroW5LQvvjdcUtGwoRyq/MgQ97wHhhsU2g+vQ
	 nShdNpKdepysBHRsr4uXjoIHF/dh2LUFezBNcrBTAXzrIIERLa8tsDVDO2rIGxg2+H
	 7h04MT/c8UndYL+qVQtPfqcajTlolF288INWtEWgVczRiHfBNbAtKJb7YXbJmkuubr
	 4rswu4s49Xf9g==
Message-ID: <017ca787f3a167302281b65e60d301d9f1c0f5de.camel@kernel.org>
Subject: Re: [PATCH 03/19] VFS: use d_alloc_parallel() in
 lookup_one_qstr_excl() and rename it.
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner
	 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Linus Torvalds
	 <torvalds@linux-foundation.org>, Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 06 Feb 2025 09:30:47 -0500
In-Reply-To: <20250206054504.2950516-4-neilb@suse.de>
References: <20250206054504.2950516-1-neilb@suse.de>
	 <20250206054504.2950516-4-neilb@suse.de>
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

On Thu, 2025-02-06 at 16:42 +1100, NeilBrown wrote:
> lookup_one_qstr_excl() is used for lookups prior to directory
> modifications, whether create, unlink, rename, or whatever.
>=20
> To prepare for allowing modification to happen in parallel, change
> lookup_one_qstr_excl() to use d_alloc_parallel().
>=20
> To reflect this, name is changed to lookup_one_qtr() - as the directory
> may be locked shared.
>=20
> If any for the "intent" LOOKUP flags are passed, the caller must ensure
> d_lookup_done() is called at an appropriate time.  If none are passed
> then we can be sure ->lookup() will do a real lookup and d_lookup_done()
> is called internally.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/namei.c            | 47 +++++++++++++++++++++++++------------------
>  fs/smb/server/vfs.c   |  7 ++++---
>  include/linux/namei.h |  9 ++++++---
>  3 files changed, 37 insertions(+), 26 deletions(-)
>=20
> diff --git a/fs/namei.c b/fs/namei.c
> index 5cdbd2eb4056..d684102d873d 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1665,15 +1665,13 @@ static struct dentry *lookup_dcache(const struct =
qstr *name,
>  }
> =20
>  /*
> - * Parent directory has inode locked exclusive.  This is one
> - * and only case when ->lookup() gets called on non in-lookup
> - * dentries - as the matter of fact, this only gets called
> - * when directory is guaranteed to have no in-lookup children
> - * at all.
> + * Parent directory has inode locked: exclusive or shared.
> + * If @flags contains any LOOKUP_INTENT_FLAGS then d_lookup_done()
> + * must be called after the intended operation is performed - or aborted=
.
>   */
> -struct dentry *lookup_one_qstr_excl(const struct qstr *name,
> -				    struct dentry *base,
> -				    unsigned int flags)
> +struct dentry *lookup_one_qstr(const struct qstr *name,
> +			       struct dentry *base,
> +			       unsigned int flags)
>  {
>  	struct dentry *dentry =3D lookup_dcache(name, base, flags);
>  	struct dentry *old;
> @@ -1686,18 +1684,25 @@ struct dentry *lookup_one_qstr_excl(const struct =
qstr *name,
>  	if (unlikely(IS_DEADDIR(dir)))
>  		return ERR_PTR(-ENOENT);
> =20
> -	dentry =3D d_alloc(base, name);
> -	if (unlikely(!dentry))
> +	dentry =3D d_alloc_parallel(base, name);
> +	if (unlikely(IS_ERR_OR_NULL(dentry)))
>  		return ERR_PTR(-ENOMEM);
> +	if (!d_in_lookup(dentry))
> +		/* Raced with another thread which did the lookup */
> +		return dentry;
> =20
>  	old =3D dir->i_op->lookup(dir, dentry, flags);
>  	if (unlikely(old)) {
> +		d_lookup_done(dentry);
>  		dput(dentry);
>  		dentry =3D old;
>  	}
> +	if ((flags & LOOKUP_INTENT_FLAGS) =3D=3D 0)
> +		/* ->lookup must have given final answer */
> +		d_lookup_done(dentry);

This is kind of an ugly thing for the callers to get right. I think it
would be cleaner to just push the d_lookup_done() into all of the
callers that don't pass any intent flags, and do away with this.

>  	return dentry;
>  }
> -EXPORT_SYMBOL(lookup_one_qstr_excl);
> +EXPORT_SYMBOL(lookup_one_qstr);
> =20
>  /**
>   * lookup_fast - do fast lockless (but racy) lookup of a dentry
> @@ -2739,7 +2744,7 @@ static struct dentry *__kern_path_locked(int dfd, s=
truct filename *name, struct
>  		return ERR_PTR(-EINVAL);
>  	}
>  	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
> -	d =3D lookup_one_qstr_excl(&last, path->dentry, 0);
> +	d =3D lookup_one_qstr(&last, path->dentry, 0);
>  	if (IS_ERR(d)) {
>  		inode_unlock(path->dentry->d_inode);
>  		path_put(path);
> @@ -4078,8 +4083,8 @@ static struct dentry *filename_create(int dfd, stru=
ct filename *name,
>  	if (last.name[last.len] && !want_dir)
>  		create_flags =3D 0;
>  	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
> -	dentry =3D lookup_one_qstr_excl(&last, path->dentry,
> -				      reval_flag | create_flags);
> +	dentry =3D lookup_one_qstr(&last, path->dentry,
> +				 reval_flag | create_flags);
>  	if (IS_ERR(dentry))
>  		goto unlock;
> =20
> @@ -4103,6 +4108,7 @@ static struct dentry *filename_create(int dfd, stru=
ct filename *name,
>  	}
>  	return dentry;
>  fail:
> +	d_lookup_done(dentry);
>  	dput(dentry);
>  	dentry =3D ERR_PTR(error);
>  unlock:
> @@ -4508,7 +4514,7 @@ int do_rmdir(int dfd, struct filename *name)
>  		goto exit2;
> =20
>  	inode_lock_nested(path.dentry->d_inode, I_MUTEX_PARENT);
> -	dentry =3D lookup_one_qstr_excl(&last, path.dentry, lookup_flags);
> +	dentry =3D lookup_one_qstr(&last, path.dentry, lookup_flags);
>  	error =3D PTR_ERR(dentry);
>  	if (IS_ERR(dentry))
>  		goto exit3;
> @@ -4641,7 +4647,7 @@ int do_unlinkat(int dfd, struct filename *name)
>  		goto exit2;
>  retry_deleg:
>  	inode_lock_nested(path.dentry->d_inode, I_MUTEX_PARENT);
> -	dentry =3D lookup_one_qstr_excl(&last, path.dentry, lookup_flags);
> +	dentry =3D lookup_one_qstr(&last, path.dentry, lookup_flags);
>  	error =3D PTR_ERR(dentry);
>  	if (!IS_ERR(dentry)) {
> =20
> @@ -5231,8 +5237,8 @@ int do_renameat2(int olddfd, struct filename *from,=
 int newdfd,
>  		goto exit_lock_rename;
>  	}
> =20
> -	old_dentry =3D lookup_one_qstr_excl(&old_last, old_path.dentry,
> -					  lookup_flags);
> +	old_dentry =3D lookup_one_qstr(&old_last, old_path.dentry,
> +				     lookup_flags);
>  	error =3D PTR_ERR(old_dentry);
>  	if (IS_ERR(old_dentry))
>  		goto exit3;
> @@ -5240,8 +5246,8 @@ int do_renameat2(int olddfd, struct filename *from,=
 int newdfd,
>  	error =3D -ENOENT;
>  	if (d_is_negative(old_dentry))
>  		goto exit4;
> -	new_dentry =3D lookup_one_qstr_excl(&new_last, new_path.dentry,
> -					  lookup_flags | target_flags);
> +	new_dentry =3D lookup_one_qstr(&new_last, new_path.dentry,
> +				     lookup_flags | target_flags);
>  	error =3D PTR_ERR(new_dentry);
>  	if (IS_ERR(new_dentry))
>  		goto exit4;
> @@ -5292,6 +5298,7 @@ int do_renameat2(int olddfd, struct filename *from,=
 int newdfd,
>  	rd.flags	   =3D flags;
>  	error =3D vfs_rename(&rd);
>  exit5:
> +	d_lookup_done(new_dentry);
>  	dput(new_dentry);
>  exit4:
>  	dput(old_dentry);
> diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
> index 4e580bb7baf8..89b3823f6405 100644
> --- a/fs/smb/server/vfs.c
> +++ b/fs/smb/server/vfs.c
> @@ -109,7 +109,7 @@ static int ksmbd_vfs_path_lookup_locked(struct ksmbd_=
share_config *share_conf,
>  	}
> =20
>  	inode_lock_nested(parent_path->dentry->d_inode, I_MUTEX_PARENT);
> -	d =3D lookup_one_qstr_excl(&last, parent_path->dentry, 0);
> +	d =3D lookup_one_qstr(&last, parent_path->dentry, 0);
>  	if (IS_ERR(d))
>  		goto err_out;
> =20
> @@ -726,8 +726,8 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const s=
truct path *old_path,
>  		ksmbd_fd_put(work, parent_fp);
>  	}
> =20
> -	new_dentry =3D lookup_one_qstr_excl(&new_last, new_path.dentry,
> -					  lookup_flags | LOOKUP_RENAME_TARGET);
> +	new_dentry =3D lookup_one_qstr(&new_last, new_path.dentry,
> +				     lookup_flags | LOOKUP_RENAME_TARGET);
>  	if (IS_ERR(new_dentry)) {
>  		err =3D PTR_ERR(new_dentry);
>  		goto out3;
> @@ -771,6 +771,7 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const s=
truct path *old_path,
>  		ksmbd_debug(VFS, "vfs_rename failed err %d\n", err);
> =20
>  out4:
> +	d_lookup_done(new_dentry);
>  	dput(new_dentry);
>  out3:
>  	dput(old_parent);
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index 8ec8fed3bce8..06bb3ea65beb 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -34,6 +34,9 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
>  #define LOOKUP_EXCL		0x0400	/* ... in exclusive creation */
>  #define LOOKUP_RENAME_TARGET	0x0800	/* ... in destination of rename() */
> =20
> +#define LOOKUP_INTENT_FLAGS	(LOOKUP_OPEN | LOOKUP_CREATE | LOOKUP_EXCL |=
	\
> +				 LOOKUP_RENAME_TARGET)
> +
>  /* internal use only */
>  #define LOOKUP_PARENT		0x0010
> =20
> @@ -52,9 +55,9 @@ extern int path_pts(struct path *path);
> =20
>  extern int user_path_at(int, const char __user *, unsigned, struct path =
*);
> =20
> -struct dentry *lookup_one_qstr_excl(const struct qstr *name,
> -				    struct dentry *base,
> -				    unsigned int flags);
> +struct dentry *lookup_one_qstr(const struct qstr *name,
> +			       struct dentry *base,
> +			       unsigned int flags);
>  extern int kern_path(const char *, unsigned, struct path *);
> =20
>  extern struct dentry *kern_path_create(int, const char *, struct path *,=
 unsigned int);

--=20
Jeff Layton <jlayton@kernel.org>

