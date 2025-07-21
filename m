Return-Path: <linux-fsdevel+bounces-55599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 975EFB0C55A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 15:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02BB71AA030E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 13:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3616B2D877F;
	Mon, 21 Jul 2025 13:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+s+tot5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C06A6F06B;
	Mon, 21 Jul 2025 13:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753105165; cv=none; b=UkyahDfHlGhwAutocIa8wtXWEndVQuubpcd74zhyNs7FL8i/qPTaAo+xGKC68c4u8bJq/dNzMTDn9dhNujeWER16uIfrXjunCr7kDG4GilY+gublBFrKyNe0ZXRVKhj31z5aLkRDg6v7/6UrUOkpeaBP2y5Nf7wbJwwfmfR9DOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753105165; c=relaxed/simple;
	bh=fsJ2MTskARLVf9CJ6jlBRYJCeVzPdTSVSzDZiEKuS/s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KX8PrUGhr2+1DCwNxT1828E+UUGB5+rPpB0QrlHOYZCsZRL2L6KcI4v3NPALM4xsz+QL3ETjW7YhIg+WkMtkRrqGdxOCOKoA8rhiGeKsS9dB9E/hv5kszZLj+XhL9huhQtZRy2qjrRzBlygBaOuuBf9nq1r+AsejBq4cGriVbwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+s+tot5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538EBC4CEED;
	Mon, 21 Jul 2025 13:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753105165;
	bh=fsJ2MTskARLVf9CJ6jlBRYJCeVzPdTSVSzDZiEKuS/s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=t+s+tot5sPvNdxakPPsgdvUPppROXX+HcIUyIZ24u/Lf2UGzQXV9pFjrtbLQAkR+8
	 uCbHWT7dtV72DxlupVqg2UHHRIXSpFsnUfgS79QEt53eggu/oLkV/PnKmCAH/fbmEV
	 rXTRBKYTDm3oOJ31zLOhRf9bmgvpT79l5l6Gnd7sdfwUJAsQ0q1ON+iUY2nmrkkdzb
	 d9+AuZo8Gg6TOBVE0P7okxK4UEgr5zmpSle6kxhw4+RPzbpmk4xTFtZxgqGC2u+5JB
	 mZlU3uSldhHd93aBW5Csw+GPdlHluFuYa6WR9La8vLgWUVLhcux5Ft2AImJ+MqlMoe
	 dOVwp1PhYqzbA==
Message-ID: <b518093d927c52e4a7affce3a91fba618fd3fc09.camel@kernel.org>
Subject: Re: [PATCH 2/7] VFS: introduce done_dentry_lookup()
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neil@brown.name>, Linus Torvalds
 <torvalds@linux-foundation.org>,  Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 21 Jul 2025 09:39:23 -0400
In-Reply-To: <20250721084412.370258-3-neil@brown.name>
References: <20250721084412.370258-1-neil@brown.name>
	 <20250721084412.370258-3-neil@brown.name>
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

On Mon, 2025-07-21 at 17:59 +1000, NeilBrown wrote:
> done_dentry_lookup() is the first step in introducing a new API for
> locked operation on names in directories - those that create or remove
> names.  Rename operations will also be part of this API but will
> use separate interfaces.
>=20
> The plan is to lock just the dentry (or dentries), not the whole
> directory.  A "dentry_lookup()" operation will perform the locking and
> lookup with a corresponding "done_dentry_lookup()" releasing the
> resulting dentry and dropping any locks.
>=20
> This done_dentry_lookup() can immediately be used to complete updates
> started with kern_path_locked() (much as done_path_create() already
> completes operations started with kern_path_create()).
>=20
> So this patch adds done_dentry_lookup() and uses it where
> kern_path_locked() is used.  It also adds done_dentry_lookup_return()
> which returns a reference to the dentry rather than dropping it.  This
> is a less common need in existing code, but still worth its own interface=
.
>=20
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  drivers/base/devtmpfs.c |  7 ++-----
>  fs/bcachefs/fs-ioctl.c  |  3 +--
>  fs/namei.c              | 38 ++++++++++++++++++++++++++++++++++++++
>  include/linux/namei.h   |  3 +++
>  kernel/audit_fsnotify.c |  9 ++++-----
>  kernel/audit_watch.c    |  3 +--
>  6 files changed, 49 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
> index 31bfb3194b4c..47bee8166c8d 100644
> --- a/drivers/base/devtmpfs.c
> +++ b/drivers/base/devtmpfs.c
> @@ -265,8 +265,7 @@ static int dev_rmdir(const char *name)
>  	else
>  		err =3D -EPERM;
> =20
> -	dput(dentry);
> -	inode_unlock(d_inode(parent.dentry));
> +	done_dentry_lookup(dentry);
>  	path_put(&parent);
>  	return err;
>  }
> @@ -349,9 +348,7 @@ static int handle_remove(const char *nodename, struct=
 device *dev)
>  		if (!err || err =3D=3D -ENOENT)
>  			deleted =3D 1;
>  	}
> -	dput(dentry);
> -	inode_unlock(d_inode(parent.dentry));
> -
> +	done_dentry_lookup(dentry);
>  	path_put(&parent);
>  	if (deleted && strchr(nodename, '/'))
>  		delete_path(nodename);
> diff --git a/fs/bcachefs/fs-ioctl.c b/fs/bcachefs/fs-ioctl.c
> index 4e72e654da96..8077ddf4ddc4 100644
> --- a/fs/bcachefs/fs-ioctl.c
> +++ b/fs/bcachefs/fs-ioctl.c
> @@ -351,8 +351,7 @@ static long bch2_ioctl_subvolume_destroy(struct bch_f=
s *c, struct file *filp,
>  		d_invalidate(victim);
>  	}
>  err:
> -	inode_unlock(dir);
> -	dput(victim);
> +	done_dentry_lookup(victim);
>  	path_put(&path);
>  	return ret;
>  }
> diff --git a/fs/namei.c b/fs/namei.c
> index 1c80445693d4..da160a01e23d 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1714,6 +1714,44 @@ struct dentry *lookup_one_qstr_excl(const struct q=
str *name,
>  }
>  EXPORT_SYMBOL(lookup_one_qstr_excl);
> =20
> +/**
> + * done_dentry_lookup - finish a lookup used for create/delete
> + * @dentry:  the target dentry
> + *
> + * After locking the directory and lookup or validating a dentry
> + * an attempt can be made to create (including link) or remove (includin=
g
> + * rmdir) a dentry.  After this, done_dentry_lookup() can be used to bot=
h
> + * unlock the parent directory and dput() the dentry.
> + *
> + * This interface allows a smooth transition from parent-dir based
> + * locking to dentry based locking.
> + */
> +void done_dentry_lookup(struct dentry *dentry)
> +{
> +	inode_unlock(dentry->d_parent->d_inode);
> +	dput(dentry);
> +}
> +EXPORT_SYMBOL(done_dentry_lookup);
> +
> +/**
> + * done_dentry_lookup_return - finish a lookup sequence, returning the d=
entry
> + * @dentry:  the target dentry
> + *
> + * After locking the directory and lookup or validating a dentry
> + * an attempt can be made to create (including link) or remove (includin=
g
> + * rmdir) a dentry.  After this, done_dentry_lookup_return() can be used=
 to
> + * unlock the parent directory.  The dentry is returned for further use.
> + *
> + * This interface allows a smooth transition from parent-dir based
> + * locking to dentry based locking.
> + */
> +struct dentry *done_dentry_lookup_return(struct dentry *dentry)
> +{
> +	inode_unlock(dentry->d_parent->d_inode);
> +	return dentry;
> +}
> +EXPORT_SYMBOL(done_dentry_lookup_return);
> +
>  /**
>   * lookup_fast - do fast lockless (but racy) lookup of a dentry
>   * @nd: current nameidata
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index 5d085428e471..e097f11587c9 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -81,6 +81,9 @@ struct dentry *lookup_one_positive_unlocked(struct mnt_=
idmap *idmap,
>  					    struct qstr *name,
>  					    struct dentry *base);
> =20
> +void done_dentry_lookup(struct dentry *dentry);
> +struct dentry *done_dentry_lookup_return(struct dentry *dentry);
> +
>  extern int follow_down_one(struct path *);
>  extern int follow_down(struct path *path, unsigned int flags);
>  extern int follow_up(struct path *);
> diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
> index c565fbf66ac8..170836c3520f 100644
> --- a/kernel/audit_fsnotify.c
> +++ b/kernel/audit_fsnotify.c
> @@ -85,8 +85,8 @@ struct audit_fsnotify_mark *audit_alloc_mark(struct aud=
it_krule *krule, char *pa
>  	dentry =3D kern_path_locked(pathname, &path);
>  	if (IS_ERR(dentry))
>  		return ERR_CAST(dentry); /* returning an error */
> -	inode =3D path.dentry->d_inode;
> -	inode_unlock(inode);
> +	inode =3D igrab(dentry->d_inode);

This is a little confusing. This patch changes "inode" from pointing to
the parent inode to point to the child inode instead. That actually
makes a bit more sense given the naming, but might best be done in a
separate patch.

> +	done_dentry_lookup(dentry);
> =20
>  	audit_mark =3D kzalloc(sizeof(*audit_mark), GFP_KERNEL);
>  	if (unlikely(!audit_mark)) {
> @@ -97,17 +97,16 @@ struct audit_fsnotify_mark *audit_alloc_mark(struct a=
udit_krule *krule, char *pa
>  	fsnotify_init_mark(&audit_mark->mark, audit_fsnotify_group);
>  	audit_mark->mark.mask =3D AUDIT_FS_EVENTS;
>  	audit_mark->path =3D pathname;
> -	audit_update_mark(audit_mark, dentry->d_inode);
> +	audit_update_mark(audit_mark, inode);
>  	audit_mark->rule =3D krule;
> =20
> -	ret =3D fsnotify_add_inode_mark(&audit_mark->mark, inode, 0);
> +	ret =3D fsnotify_add_inode_mark(&audit_mark->mark, path.dentry->d_inode=
, 0);
>  	if (ret < 0) {
>  		audit_mark->path =3D NULL;
>  		fsnotify_put_mark(&audit_mark->mark);
>  		audit_mark =3D ERR_PTR(ret);
>  	}
>  out:
> -	dput(dentry);
>  	path_put(&path);
>  	return audit_mark;
>  }
> diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
> index 0ebbbe37a60f..f6ecac2109d4 100644
> --- a/kernel/audit_watch.c
> +++ b/kernel/audit_watch.c
> @@ -359,8 +359,7 @@ static int audit_get_nd(struct audit_watch *watch, st=
ruct path *parent)
>  		watch->ino =3D d_backing_inode(d)->i_ino;
>  	}
> =20
> -	inode_unlock(d_backing_inode(parent->dentry));
> -	dput(d);
> +	done_dentry_lookup(d);
>  	return 0;
>  }
> =20

It looks right to me though.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

