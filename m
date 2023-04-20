Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2756E9C17
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 20:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjDTSw4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 14:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjDTSwl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 14:52:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F51730F5
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Apr 2023 11:52:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2D9064B52
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Apr 2023 18:52:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E6BC433EF;
        Thu, 20 Apr 2023 18:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682016734;
        bh=fvIPzDfhL4B65lF7qY8dpY6GW36ogiG9XxwwkHW2TIQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=RSFeQw9dVD5KbQE7mvIVZawc/xw/qWiPGHQliC4XvgO7Tf5NkzHTj9BDfN0f9lja0
         mNf4LYv13Ka4oZu0M1MamFQmsL2YSktvavp9zsh/Y9s3ckBn4BDhvAylZtz4zbp76f
         Zig4/CwbVLZxUBfdM3o8qlTJzoofd2jEhwSofsN59yKnAtaLMrmvHasOYruua307k1
         kqg5xCEZLfHoj5/nTS/JO1SwORA8z+w5TdbgcTE15n4PwFDMzYwJ3GNM2wQ7KNCTJ2
         Zknw083WmdvRhWOQ+46ddc/lSUzwtx+o+x0JwAQ+ZqM/GkzdeYnKOfHamRjY/9g7AO
         bEiTznud0zZCg==
Message-ID: <d624a7a0d5e477b3c7ba8aa671f1f450d517fb7a.camel@kernel.org>
Subject: Re: [PATCH v1] shmem: stable directory cookies
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>, hughd@google.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Date:   Thu, 20 Apr 2023 14:52:12 -0400
In-Reply-To: <168175931561.2843.16288612382874559384.stgit@manet.1015granger.net>
References: <168175931561.2843.16288612382874559384.stgit@manet.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.0 (3.48.0-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2023-04-17 at 15:23 -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> The current cursor-based directory cookie mechanism doesn't work
> when a tmpfs filesystem is exported via NFS. This is because NFS
> clients do not open directories: each READDIR operation has to open
> the directory on the server, read it, then close it. The cursor
> state for that directory, being associated strictly with the opened
> struct file, is then discarded.
>=20
> Directory cookies are cached not only by NFS clients, but also by
> user space libraries on those clients. Essentially there is no way
> to invalidate those caches when directory offsets have changed on
> an NFS server after the offset-to-dentry mapping changes.
>=20
> The solution we've come up with is to make the directory cookie for
> each file in a tmpfs filesystem stable for the life of the directory
> entry it represents.
>=20
> Add a per-directory xarray. shmem_readdir() uses this to map each
> directory offset (an loff_t integer) to the memory address of a
> struct dentry.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  include/linux/shmem_fs.h |    2=20
>  mm/shmem.c               |  213 ++++++++++++++++++++++++++++++++++++++++=
+++---
>  2 files changed, 201 insertions(+), 14 deletions(-)
>=20
> Changes since RFC:
> - Destroy xarray in shmem_destroy_inode() instead of free_in_core_inode()
> - A few cosmetic updates
>=20
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index 103d1000a5a2..682ef885aa89 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -26,6 +26,8 @@ struct shmem_inode_info {
>  	atomic_t		stop_eviction;	/* hold when working on inode */
>  	struct timespec64	i_crtime;	/* file creation time */
>  	unsigned int		fsflags;	/* flags for FS_IOC_[SG]ETFLAGS */
> +	struct xarray		doff_map;	/* dir offset to entry mapping */
> +	u32			next_doff;
>  	struct inode		vfs_inode;
>  };
> =20
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 448f393d8ab2..ba4176499e5c 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -40,6 +40,8 @@
>  #include <linux/fs_parser.h>
>  #include <linux/swapfile.h>
>  #include <linux/iversion.h>
> +#include <linux/xarray.h>
> +
>  #include "swap.h"
> =20
>  static struct vfsmount *shm_mnt;
> @@ -234,6 +236,7 @@ static const struct super_operations shmem_ops;
>  const struct address_space_operations shmem_aops;
>  static const struct file_operations shmem_file_operations;
>  static const struct inode_operations shmem_inode_operations;
> +static const struct file_operations shmem_dir_operations;
>  static const struct inode_operations shmem_dir_inode_operations;
>  static const struct inode_operations shmem_special_inode_operations;
>  static const struct vm_operations_struct shmem_vm_ops;
> @@ -2397,7 +2400,9 @@ static struct inode *shmem_get_inode(struct mnt_idm=
ap *idmap, struct super_block
>  			/* Some things misbehave if size =3D=3D 0 on a directory */
>  			inode->i_size =3D 2 * BOGO_DIRENT_SIZE;
>  			inode->i_op =3D &shmem_dir_inode_operations;
> -			inode->i_fop =3D &simple_dir_operations;
> +			inode->i_fop =3D &shmem_dir_operations;
> +			xa_init_flags(&info->doff_map, XA_FLAGS_ALLOC1);
> +			info->next_doff =3D 0;
>  			break;
>  		case S_IFLNK:
>  			/*
> @@ -2917,6 +2922,71 @@ static int shmem_statfs(struct dentry *dentry, str=
uct kstatfs *buf)
>  	return 0;
>  }
> =20
> +static struct xarray *shmem_doff_map(struct inode *dir)
> +{
> +	return &SHMEM_I(dir)->doff_map;
> +}
> +
> +static int shmem_doff_add(struct inode *dir, struct dentry *dentry)
> +{
> +	struct shmem_inode_info *info =3D SHMEM_I(dir);
> +	struct xa_limit limit =3D XA_LIMIT(2, U32_MAX);
> +	u32 offset;
> +	int ret;
> +
> +	if (dentry->d_fsdata)
> +		return -EBUSY;
> +
> +	offset =3D 0;
> +	ret =3D xa_alloc_cyclic(shmem_doff_map(dir), &offset, dentry, limit,
> +			      &info->next_doff, GFP_KERNEL);
> +	if (ret < 0)
> +		return ret;
> +
> +	dentry->d_fsdata =3D (void *)(unsigned long)offset;
> +	return 0;
> +}
> +
> +static struct dentry *shmem_doff_find_after(struct dentry *dir,
> +					    unsigned long *offset)
> +{
> +	struct xarray *xa =3D shmem_doff_map(d_inode(dir));
> +	struct dentry *d, *found =3D NULL;
> +
> +	spin_lock(&dir->d_lock);
> +	d =3D xa_find_after(xa, offset, ULONG_MAX, XA_PRESENT);
> +	if (d) {
> +		spin_lock_nested(&d->d_lock, DENTRY_D_LOCK_NESTED);
> +		if (simple_positive(d))
> +			found =3D dget_dlock(d);
> +		spin_unlock(&d->d_lock);
> +	}
> +	spin_unlock(&dir->d_lock);

This part is kind of gross, but I think I get it now...

You have to take dir->d_lock to ensure that "d" doesn't go away when you
don't hold a ref on it, and you need the child's d_lock to ensure that
simple_positive result is stable while you take a reference (because
doing a dput there could be problematic). If that's right, then that's a
bit subtle, and might deserve a nice comment.

I do wonder if there is some way to do this with RCU instead, but this
seems to work well enough.

> +	return found;
> +}
> +
> +static void shmem_doff_remove(struct inode *dir, struct dentry *dentry)
> +{
> +	u32 offset =3D (u32)(unsigned long)dentry->d_fsdata;
> +
> +	if (!offset)
> +		return;
> +
> +	xa_erase(shmem_doff_map(dir), offset);
> +	dentry->d_fsdata =3D NULL;
> +}
> +
> +/*
> + * During fs teardown (eg. umount), a directory's doff_map might still
> + * contain entries. xa_destroy() cleans out anything that remains.
> + */
> +static void shmem_doff_map_destroy(struct inode *inode)
> +{
> +	struct xarray *xa =3D shmem_doff_map(inode);
> +
> +	xa_destroy(xa);
> +}
> +
>  /*
>   * File creation. Allocate an inode, and we're done..
>   */
> @@ -2938,6 +3008,10 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode =
*dir,
>  		if (error && error !=3D -EOPNOTSUPP)
>  			goto out_iput;
> =20
> +		error =3D shmem_doff_add(dir, dentry);
> +		if (error)
> +			goto out_iput;
> +
>  		error =3D 0;
>  		dir->i_size +=3D BOGO_DIRENT_SIZE;
>  		dir->i_ctime =3D dir->i_mtime =3D current_time(dir);
> @@ -3015,6 +3089,10 @@ static int shmem_link(struct dentry *old_dentry, s=
truct inode *dir, struct dentr
>  			goto out;
>  	}
> =20
> +	ret =3D shmem_doff_add(dir, dentry);
> +	if (ret)
> +		goto out;
> +
>  	dir->i_size +=3D BOGO_DIRENT_SIZE;
>  	inode->i_ctime =3D dir->i_ctime =3D dir->i_mtime =3D current_time(inode=
);
>  	inode_inc_iversion(dir);
> @@ -3033,6 +3111,8 @@ static int shmem_unlink(struct inode *dir, struct d=
entry *dentry)
>  	if (inode->i_nlink > 1 && !S_ISDIR(inode->i_mode))
>  		shmem_free_inode(inode->i_sb);
> =20
> +	shmem_doff_remove(dir, dentry);
> +
>  	dir->i_size -=3D BOGO_DIRENT_SIZE;
>  	inode->i_ctime =3D dir->i_ctime =3D dir->i_mtime =3D current_time(inode=
);
>  	inode_inc_iversion(dir);
> @@ -3091,24 +3171,37 @@ static int shmem_rename2(struct mnt_idmap *idmap,
>  {
>  	struct inode *inode =3D d_inode(old_dentry);
>  	int they_are_dirs =3D S_ISDIR(inode->i_mode);
> +	int error;
> =20
>  	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
>  		return -EINVAL;
> =20
> -	if (flags & RENAME_EXCHANGE)
> +	if (flags & RENAME_EXCHANGE) {
> +		shmem_doff_remove(old_dir, old_dentry);
> +		shmem_doff_remove(new_dir, new_dentry);
> +		error =3D shmem_doff_add(new_dir, old_dentry);
> +		if (error)
> +			return error;
> +		error =3D shmem_doff_add(old_dir, new_dentry);
> +		if (error)
> +			return error;
>  		return simple_rename_exchange(old_dir, old_dentry, new_dir, new_dentry=
);
> +	}
> =20
>  	if (!simple_empty(new_dentry))
>  		return -ENOTEMPTY;
> =20
>  	if (flags & RENAME_WHITEOUT) {
> -		int error;
> -
>  		error =3D shmem_whiteout(idmap, old_dir, old_dentry);
>  		if (error)
>  			return error;
>  	}
> =20
> +	shmem_doff_remove(old_dir, old_dentry);
> +	error =3D shmem_doff_add(new_dir, old_dentry);
> +	if (error)
> +		return error;
> +
>  	if (d_really_is_positive(new_dentry)) {
>  		(void) shmem_unlink(new_dir, new_dentry);
>  		if (they_are_dirs) {
> @@ -3149,26 +3242,22 @@ static int shmem_symlink(struct mnt_idmap *idmap,=
 struct inode *dir,
> =20
>  	error =3D security_inode_init_security(inode, dir, &dentry->d_name,
>  					     shmem_initxattrs, NULL);
> -	if (error && error !=3D -EOPNOTSUPP) {
> -		iput(inode);
> -		return error;
> -	}
> +	if (error && error !=3D -EOPNOTSUPP)
> +		goto out_iput;
> =20
>  	inode->i_size =3D len-1;
>  	if (len <=3D SHORT_SYMLINK_LEN) {
>  		inode->i_link =3D kmemdup(symname, len, GFP_KERNEL);
>  		if (!inode->i_link) {
> -			iput(inode);
> -			return -ENOMEM;
> +			error =3D -ENOMEM;
> +			goto out_iput;
>  		}
>  		inode->i_op =3D &shmem_short_symlink_operations;
>  	} else {
>  		inode_nohighmem(inode);
>  		error =3D shmem_get_folio(inode, 0, &folio, SGP_WRITE);
> -		if (error) {
> -			iput(inode);
> -			return error;
> -		}
> +		if (error)
> +			goto out_iput;
>  		inode->i_mapping->a_ops =3D &shmem_aops;
>  		inode->i_op =3D &shmem_symlink_inode_operations;
>  		memcpy(folio_address(folio), symname, len);
> @@ -3177,12 +3266,20 @@ static int shmem_symlink(struct mnt_idmap *idmap,=
 struct inode *dir,
>  		folio_unlock(folio);
>  		folio_put(folio);
>  	}
> +
> +	error =3D shmem_doff_add(dir, dentry);
> +	if (error)
> +		goto out_iput;
> +
>  	dir->i_size +=3D BOGO_DIRENT_SIZE;
>  	dir->i_ctime =3D dir->i_mtime =3D current_time(dir);
>  	inode_inc_iversion(dir);
>  	d_instantiate(dentry, inode);
>  	dget(dentry);
>  	return 0;
> +out_iput:
> +	iput(inode);
> +	return error;
>  }
> =20
>  static void shmem_put_link(void *arg)
> @@ -3224,6 +3321,77 @@ static const char *shmem_get_link(struct dentry *d=
entry,
>  	return folio_address(folio);
>  }
> =20
> +static loff_t shmem_dir_llseek(struct file *file, loff_t offset, int whe=
nce)
> +{
> +	switch (whence) {
> +	case SEEK_CUR:
> +		offset +=3D file->f_pos;
> +		fallthrough;
> +	case SEEK_SET:
> +		if (offset >=3D 0)
> +			break;
> +		fallthrough;
> +	default:
> +		return -EINVAL;
> +	}
> +	return vfs_setpos(file, offset, U32_MAX);
> +}
> +
> +static bool shmem_dir_emit(struct dir_context *ctx, struct dentry *dentr=
y)
> +{
> +	struct inode *inode =3D d_inode(dentry);
> +
> +	return ctx->actor(ctx, dentry->d_name.name, dentry->d_name.len,
> +			  (loff_t)dentry->d_fsdata, inode->i_ino,
> +			  fs_umode_to_dtype(inode->i_mode));
> +}
> +
> +/**
> + * shmem_readdir - Emit entries starting at offset @ctx->pos
> + * @file: an open directory to iterate over
> + * @ctx: directory iteration context
> + *
> + * Caller must hold @file's i_rwsem to prevent insertion or removal of
> + * entries during this call.
> + *
> + * On entry, @ctx->pos contains an offset that represents the first entr=
y
> + * to be read from the directory.
> + *
> + * The operation continues until there are no more entries to read, or
> + * until the ctx->actor indicates there is no more space in the caller's
> + * output buffer.
> + *
> + * On return, @ctx->pos contains an offset that will read the next entry
> + * in this directory when shmem_readdir() is called again with @ctx.
> + *
> + * Return values:
> + *   %0 - Complete
> + */
> +static int shmem_readdir(struct file *file, struct dir_context *ctx)
> +{
> +	struct dentry *dentry, *dir =3D file->f_path.dentry;
> +	unsigned long offset;
> +
> +	lockdep_assert_held(&d_inode(dir)->i_rwsem);

You probably don't need the above. This is called via ->iterate_shared
so the lock had _better_ be held.

=20
> +
> +	if (!dir_emit_dots(file, ctx))
> +		goto out;
> +	for (offset =3D ctx->pos - 1; offset < ULONG_MAX - 1;) {
> +		dentry =3D shmem_doff_find_after(dir, &offset);
> +		if (!dentry)
> +			break;
> +		if (!shmem_dir_emit(ctx, dentry)) {
> +			dput(dentry);
> +			break;
> +		}
> +		ctx->pos =3D offset + 1;
> +		dput(dentry);
> +	}
> +
> +out:
> +	return 0;
> +}
> +
>  #ifdef CONFIG_TMPFS_XATTR
> =20
>  static int shmem_fileattr_get(struct dentry *dentry, struct fileattr *fa=
)
> @@ -3742,6 +3910,12 @@ static int shmem_show_options(struct seq_file *seq=
, struct dentry *root)
>  	return 0;
>  }
> =20
> +#else /* CONFIG_TMPFS */
> +
> +static inline void shmem_doff_map_destroy(struct inode *dir)
> +{
> +}
> +
>  #endif /* CONFIG_TMPFS */
> =20
>  static void shmem_put_super(struct super_block *sb)
> @@ -3888,6 +4062,8 @@ static void shmem_destroy_inode(struct inode *inode=
)
>  {
>  	if (S_ISREG(inode->i_mode))
>  		mpol_free_shared_policy(&SHMEM_I(inode)->policy);
> +	if (S_ISDIR(inode->i_mode))
> +		shmem_doff_map_destroy(inode);
>  }
> =20
>  static void shmem_init_inode(void *foo)
> @@ -3955,6 +4131,15 @@ static const struct inode_operations shmem_inode_o=
perations =3D {
>  #endif
>  };
> =20
> +static const struct file_operations shmem_dir_operations =3D {
> +#ifdef CONFIG_TMPFS
> +	.llseek		=3D shmem_dir_llseek,
> +	.iterate_shared	=3D shmem_readdir,
> +#endif
> +	.read		=3D generic_read_dir,
> +	.fsync		=3D noop_fsync,
> +};
> +
>  static const struct inode_operations shmem_dir_inode_operations =3D {
>  #ifdef CONFIG_TMPFS
>  	.getattr	=3D shmem_getattr,
>=20
>=20

Other than the nits above, this all looks fine to me. I've done some
testing with this series too and it all seems to work as expected, and
fixes some nasty problems when trying to recursively remove directories
via nfsd.

Have you done any performance testing? My expectation would be that
you'd have roughly similar (or even faster) performance with this set,
but at the expense of a bit of memory (for the xarrays).

One thing we could consider is lifting the bulk of this code into libfs,
so other shmem-like filesystems can take advantage of it, but that work
could be done later too when we have another proposed consumer.
--=20
Jeff Layton <jlayton@kernel.org>
