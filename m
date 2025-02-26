Return-Path: <linux-fsdevel+bounces-42649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72106A4584A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 09:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59DF03AA6E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 08:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93955224251;
	Wed, 26 Feb 2025 08:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUaJpAlO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52DB224244
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 08:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740558635; cv=none; b=TIlQ9TrtmiPHBrAFMHCCVnE4IcjlD2lQfk7XGzXZMTAlx/fIH7EqxGkt/wWctvlDUbeD/GPAafSDlduPc64VsZG76c/sUjtYCybwU3W8W7HMbGP+Ug2oL6i3Xr48jef/1XyvGzuZT8VJIwVWzxaKpb/YFC4d8QzSWIoNrJrzpzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740558635; c=relaxed/simple;
	bh=INDKdr34i/aN7PqXPLyf9GjQEVZ/2OpUir3jYHmsdRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vE+5DLZDd0zRFDX7EtBFw+N/IF4+dbLOX63WlBnJP9zKGbWR4OqwTBfBPzaRfxNEnb7WKaiYCal/8P2QEN7LjERXNAWuUvN8xaItdqxdx1aIVGvodxkoHiF2wCgy6UkXIOFbsx5RuoPeRjC0OY/MQ1638H2FnEDH/fWUfb6rj9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUaJpAlO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4702C4CED6;
	Wed, 26 Feb 2025 08:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740558633;
	bh=INDKdr34i/aN7PqXPLyf9GjQEVZ/2OpUir3jYHmsdRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gUaJpAlOL3XDx/UmHt0/rgvw4L5ga278fccQK7VVAzRqwAMAekdYoFpmE+LLaGUYm
	 ajusueYYp7JnYYA4TxaIGvYfJ0pgB8ZyH4ZcmDpF425Eg9c4UFO7t7bldxs8x96WMF
	 AYSfBG8rDXkuMSR5TB+YabVfzomNTFBI2XfFIbbKFUFIUNqTwIJ4Y1eOzXAn5tlyUx
	 sZYJxOxePgMG6uyuoTs0Ofrgp20M3GxlP7rehJJ64V2+44E/As2tI7piyJg9Icqerz
	 d2JqRp4YXyU0uIiilReanA9mx+bX2neTeE/t/Ms3H9zkUqT2twKYOZKG5GV9PK7f0G
	 bjSiah2F3OmZA==
Date: Wed, 26 Feb 2025 09:30:29 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Neil Brown <neilb@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 05/21] new helper: set_default_d_op()
Message-ID: <20250226-haarscharf-sahen-a60c0bdd85b3@brauner>
References: <20250224141444.GX1977892@ZenIV>
 <20250224212051.1756517-1-viro@zeniv.linux.org.uk>
 <20250224212051.1756517-5-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250224212051.1756517-5-viro@zeniv.linux.org.uk>

On Mon, Feb 24, 2025 at 09:20:35PM +0000, Al Viro wrote:
> ... to be used instead of manually assigning to ->s_d_op.
> All in-tree filesystem converted (and field itself is renamed,
> so any out-of-tree ones in need of conversion will be caught
> by compiler).
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

>  Documentation/filesystems/porting.rst |  7 +++++++
>  fs/9p/vfs_super.c                     |  4 ++--
>  fs/adfs/super.c                       |  2 +-
>  fs/affs/super.c                       |  4 ++--
>  fs/afs/super.c                        |  4 ++--
>  fs/autofs/inode.c                     |  2 +-
>  fs/btrfs/super.c                      |  2 +-
>  fs/ceph/super.c                       |  2 +-
>  fs/coda/inode.c                       |  2 +-
>  fs/configfs/mount.c                   |  2 +-
>  fs/dcache.c                           | 10 ++++++++--
>  fs/debugfs/inode.c                    |  2 +-
>  fs/devpts/inode.c                     |  2 +-
>  fs/ecryptfs/main.c                    |  2 +-
>  fs/efivarfs/super.c                   |  2 +-
>  fs/exfat/super.c                      |  4 ++--
>  fs/fat/namei_msdos.c                  |  2 +-
>  fs/fat/namei_vfat.c                   |  4 ++--
>  fs/fuse/inode.c                       |  4 ++--
>  fs/gfs2/ops_fstype.c                  |  2 +-
>  fs/hfs/super.c                        |  2 +-
>  fs/hfsplus/super.c                    |  2 +-
>  fs/hostfs/hostfs_kern.c               |  2 +-
>  fs/hpfs/super.c                       |  2 +-
>  fs/isofs/inode.c                      |  2 +-
>  fs/jfs/super.c                        |  2 +-
>  fs/kernfs/mount.c                     |  2 +-
>  fs/libfs.c                            | 16 ++++++++--------
>  fs/nfs/super.c                        |  2 +-
>  fs/ntfs3/super.c                      |  3 ++-
>  fs/ocfs2/super.c                      |  2 +-
>  fs/orangefs/super.c                   |  2 +-
>  fs/overlayfs/super.c                  |  2 +-
>  fs/smb/client/cifsfs.c                |  4 ++--
>  fs/tracefs/inode.c                    |  2 +-
>  fs/vboxsf/super.c                     |  2 +-
>  include/linux/dcache.h                |  2 ++
>  include/linux/fs.h                    |  2 +-
>  mm/shmem.c                            |  2 +-
>  net/sunrpc/rpc_pipe.c                 |  2 +-
>  40 files changed, 69 insertions(+), 53 deletions(-)
> 
> diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
> index 1639e78e3146..004cd69617a2 100644
> --- a/Documentation/filesystems/porting.rst
> +++ b/Documentation/filesystems/porting.rst
> @@ -1157,3 +1157,10 @@ in normal case it points into the pathname being looked up.
>  NOTE: if you need something like full path from the root of filesystem,
>  you are still on your own - this assists with simple cases, but it's not
>  magic.
> +
> +---
> +
> +**mandatory**
> +
> +If your filesystem sets the default dentry_operations, use set_default_d_op()
> +rather than manually setting sb->s_d_op.
> diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
> index 489db161abc9..5c3dc3efb909 100644
> --- a/fs/9p/vfs_super.c
> +++ b/fs/9p/vfs_super.c
> @@ -135,9 +135,9 @@ static struct dentry *v9fs_mount(struct file_system_type *fs_type, int flags,
>  		goto release_sb;
>  
>  	if (v9ses->cache & (CACHE_META|CACHE_LOOSE))
> -		sb->s_d_op = &v9fs_cached_dentry_operations;
> +		set_default_d_op(sb, &v9fs_cached_dentry_operations);
>  	else
> -		sb->s_d_op = &v9fs_dentry_operations;
> +		set_default_d_op(sb, &v9fs_dentry_operations);
>  
>  	inode = v9fs_get_new_inode_from_fid(v9ses, fid, sb);
>  	if (IS_ERR(inode)) {
> diff --git a/fs/adfs/super.c b/fs/adfs/super.c
> index 017c48a80203..fdccdbbfc213 100644
> --- a/fs/adfs/super.c
> +++ b/fs/adfs/super.c
> @@ -397,7 +397,7 @@ static int adfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	if (asb->s_ftsuffix)
>  		asb->s_namelen += 4;
>  
> -	sb->s_d_op = &adfs_dentry_operations;
> +	set_default_d_op(sb, &adfs_dentry_operations);
>  	root = adfs_iget(sb, &root_obj);
>  	sb->s_root = d_make_root(root);
>  	if (!sb->s_root) {
> diff --git a/fs/affs/super.c b/fs/affs/super.c
> index 2fa40337776d..44f8aa883100 100644
> --- a/fs/affs/super.c
> +++ b/fs/affs/super.c
> @@ -500,9 +500,9 @@ static int affs_fill_super(struct super_block *sb, struct fs_context *fc)
>  		return PTR_ERR(root_inode);
>  
>  	if (affs_test_opt(AFFS_SB(sb)->s_flags, SF_INTL))
> -		sb->s_d_op = &affs_intl_dentry_operations;
> +		set_default_d_op(sb, &affs_intl_dentry_operations);
>  	else
> -		sb->s_d_op = &affs_dentry_operations;
> +		set_default_d_op(sb, &affs_dentry_operations);
>  
>  	sb->s_root = d_make_root(root_inode);
>  	if (!sb->s_root) {
> diff --git a/fs/afs/super.c b/fs/afs/super.c
> index a9bee610674e..13d0414a1ddb 100644
> --- a/fs/afs/super.c
> +++ b/fs/afs/super.c
> @@ -487,12 +487,12 @@ static int afs_fill_super(struct super_block *sb, struct afs_fs_context *ctx)
>  		goto error;
>  
>  	if (as->dyn_root) {
> -		sb->s_d_op = &afs_dynroot_dentry_operations;
> +		set_default_d_op(sb, &afs_dynroot_dentry_operations);
>  		ret = afs_dynroot_populate(sb);
>  		if (ret < 0)
>  			goto error;
>  	} else {
> -		sb->s_d_op = &afs_fs_dentry_operations;
> +		set_default_d_op(sb, &afs_fs_dentry_operations);
>  		rcu_assign_pointer(as->volume->sb, sb);
>  	}
>  
> diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
> index ee2edccaef70..f5c16ffba013 100644
> --- a/fs/autofs/inode.c
> +++ b/fs/autofs/inode.c
> @@ -311,7 +311,7 @@ static int autofs_fill_super(struct super_block *s, struct fs_context *fc)
>  	s->s_blocksize_bits = 10;
>  	s->s_magic = AUTOFS_SUPER_MAGIC;
>  	s->s_op = &autofs_sops;
> -	s->s_d_op = &autofs_dentry_operations;
> +	set_default_d_op(s, &autofs_dentry_operations);
>  	s->s_time_gran = 1;
>  
>  	/*
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index dc4fee519ca6..5f39857ea3ae 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -954,7 +954,7 @@ static int btrfs_fill_super(struct super_block *sb,
>  	sb->s_maxbytes = MAX_LFS_FILESIZE;
>  	sb->s_magic = BTRFS_SUPER_MAGIC;
>  	sb->s_op = &btrfs_super_ops;
> -	sb->s_d_op = &btrfs_dentry_operations;
> +	set_default_d_op(sb, &btrfs_dentry_operations);
>  	sb->s_export_op = &btrfs_export_ops;
>  #ifdef CONFIG_FS_VERITY
>  	sb->s_vop = &btrfs_verityops;
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index 4344e1f11806..adec6e2f01c4 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -1220,7 +1220,7 @@ static int ceph_set_super(struct super_block *s, struct fs_context *fc)
>  	fsc->max_file_size = 1ULL << 40; /* temp value until we get mdsmap */
>  
>  	s->s_op = &ceph_super_ops;
> -	s->s_d_op = &ceph_dentry_ops;
> +	set_default_d_op(s, &ceph_dentry_ops);
>  	s->s_export_op = &ceph_export_ops;
>  
>  	s->s_time_gran = 1;
> diff --git a/fs/coda/inode.c b/fs/coda/inode.c
> index 6896fce122e1..08450d006016 100644
> --- a/fs/coda/inode.c
> +++ b/fs/coda/inode.c
> @@ -230,7 +230,7 @@ static int coda_fill_super(struct super_block *sb, struct fs_context *fc)
>  	sb->s_blocksize_bits = 12;
>  	sb->s_magic = CODA_SUPER_MAGIC;
>  	sb->s_op = &coda_super_operations;
> -	sb->s_d_op = &coda_dentry_operations;
> +	set_default_d_op(sb, &coda_dentry_operations);
>  	sb->s_time_gran = 1;
>  	sb->s_time_min = S64_MIN;
>  	sb->s_time_max = S64_MAX;
> diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
> index c2d820063ec4..20412eaca972 100644
> --- a/fs/configfs/mount.c
> +++ b/fs/configfs/mount.c
> @@ -92,7 +92,7 @@ static int configfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	configfs_root_group.cg_item.ci_dentry = root;
>  	root->d_fsdata = &configfs_root;
>  	sb->s_root = root;
> -	sb->s_d_op = &configfs_dentry_ops; /* the rest get that */
> +	set_default_d_op(sb, &configfs_dentry_ops); /* the rest get that */
>  	return 0;
>  }
>  
> diff --git a/fs/dcache.c b/fs/dcache.c
> index c85efbda133a..cd5e5139ca4c 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -1712,7 +1712,7 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
>  	INIT_HLIST_HEAD(&dentry->d_children);
>  	INIT_HLIST_NODE(&dentry->d_u.d_alias);
>  	INIT_HLIST_NODE(&dentry->d_sib);
> -	d_set_d_op(dentry, dentry->d_sb->s_d_op);
> +	d_set_d_op(dentry, dentry->d_sb->__s_d_op);
>  
>  	if (dentry->d_op && dentry->d_op->d_init) {
>  		err = dentry->d_op->d_init(dentry);
> @@ -1795,7 +1795,7 @@ struct dentry *d_alloc_pseudo(struct super_block *sb, const struct qstr *name)
>  	struct dentry *dentry = __d_alloc(sb, name);
>  	if (likely(dentry)) {
>  		dentry->d_flags |= DCACHE_NORCU;
> -		if (!sb->s_d_op)
> +		if (!dentry->d_op)
>  			d_set_d_op(dentry, &anon_ops);
>  	}
>  	return dentry;
> @@ -1841,6 +1841,12 @@ void d_set_d_op(struct dentry *dentry, const struct dentry_operations *op)
>  }
>  EXPORT_SYMBOL(d_set_d_op);
>  
> +void set_default_d_op(struct super_block *s, const struct dentry_operations *ops)
> +{
> +	s->__s_d_op = ops;
> +}
> +EXPORT_SYMBOL(set_default_d_op);
> +
>  static unsigned d_flags_for_inode(struct inode *inode)
>  {
>  	unsigned add_flags = DCACHE_REGULAR_TYPE;
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index 75715d8877ee..f54a8fd960e4 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -273,7 +273,7 @@ static int debugfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  		return err;
>  
>  	sb->s_op = &debugfs_super_operations;
> -	sb->s_d_op = &debugfs_dops;
> +	set_default_d_op(sb, &debugfs_dops);
>  
>  	debugfs_apply_options(sb);
>  
> diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
> index 1096ff8562fa..f092973236ef 100644
> --- a/fs/devpts/inode.c
> +++ b/fs/devpts/inode.c
> @@ -433,7 +433,7 @@ devpts_fill_super(struct super_block *s, void *data, int silent)
>  	s->s_blocksize_bits = 10;
>  	s->s_magic = DEVPTS_SUPER_MAGIC;
>  	s->s_op = &devpts_sops;
> -	s->s_d_op = &simple_dentry_operations;
> +	set_default_d_op(s, &simple_dentry_operations);
>  	s->s_time_gran = 1;
>  
>  	error = -ENOMEM;
> diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
> index 8dd1d7189c3b..45f9ca4465da 100644
> --- a/fs/ecryptfs/main.c
> +++ b/fs/ecryptfs/main.c
> @@ -471,7 +471,7 @@ static int ecryptfs_get_tree(struct fs_context *fc)
>  	sbi = NULL;
>  	s->s_op = &ecryptfs_sops;
>  	s->s_xattr = ecryptfs_xattr_handlers;
> -	s->s_d_op = &ecryptfs_dops;
> +	set_default_d_op(s, &ecryptfs_dops);
>  
>  	err = "Reading sb failed";
>  	rc = kern_path(fc->source, LOOKUP_FOLLOW | LOOKUP_DIRECTORY, &path);
> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> index 09fcf731e65d..3f3188e0cfa7 100644
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -345,7 +345,7 @@ static int efivarfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	sb->s_blocksize_bits    = PAGE_SHIFT;
>  	sb->s_magic             = EFIVARFS_MAGIC;
>  	sb->s_op                = &efivarfs_ops;
> -	sb->s_d_op		= &efivarfs_d_ops;
> +	set_default_d_op(sb, &efivarfs_d_ops);
>  	sb->s_time_gran         = 1;
>  
>  	if (!efivar_supports_writes())
> diff --git a/fs/exfat/super.c b/fs/exfat/super.c
> index bd57844414aa..c821582fa1ef 100644
> --- a/fs/exfat/super.c
> +++ b/fs/exfat/super.c
> @@ -697,9 +697,9 @@ static int exfat_fill_super(struct super_block *sb, struct fs_context *fc)
>  	}
>  
>  	if (sbi->options.utf8)
> -		sb->s_d_op = &exfat_utf8_dentry_ops;
> +		set_default_d_op(sb, &exfat_utf8_dentry_ops);
>  	else
> -		sb->s_d_op = &exfat_dentry_ops;
> +		set_default_d_op(sb, &exfat_dentry_ops);
>  
>  	root_inode = new_inode(sb);
>  	if (!root_inode) {
> diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
> index f06f6ba643cc..71302291d33c 100644
> --- a/fs/fat/namei_msdos.c
> +++ b/fs/fat/namei_msdos.c
> @@ -646,7 +646,7 @@ static const struct inode_operations msdos_dir_inode_operations = {
>  static void setup(struct super_block *sb)
>  {
>  	MSDOS_SB(sb)->dir_ops = &msdos_dir_inode_operations;
> -	sb->s_d_op = &msdos_dentry_operations;
> +	set_default_d_op(sb, &msdos_dentry_operations);
>  	sb->s_flags |= SB_NOATIME;
>  }
>  
> diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
> index 926c26e90ef8..2476afd1304d 100644
> --- a/fs/fat/namei_vfat.c
> +++ b/fs/fat/namei_vfat.c
> @@ -1187,9 +1187,9 @@ static void setup(struct super_block *sb)
>  {
>  	MSDOS_SB(sb)->dir_ops = &vfat_dir_inode_operations;
>  	if (MSDOS_SB(sb)->options.name_check != 's')
> -		sb->s_d_op = &vfat_ci_dentry_ops;
> +		set_default_d_op(sb, &vfat_ci_dentry_ops);
>  	else
> -		sb->s_d_op = &vfat_dentry_ops;
> +		set_default_d_op(sb, &vfat_dentry_ops);
>  }
>  
>  static int vfat_fill_super(struct super_block *sb, struct fs_context *fc)
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 57a1ee016b73..9994f3b33a9f 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1665,7 +1665,7 @@ static int fuse_fill_super_submount(struct super_block *sb,
>  	fi = get_fuse_inode(root);
>  	fi->nlookup--;
>  
> -	sb->s_d_op = &fuse_dentry_operations;
> +	set_default_d_op(sb, &fuse_dentry_operations);
>  	sb->s_root = d_make_root(root);
>  	if (!sb->s_root)
>  		return -ENOMEM;
> @@ -1800,7 +1800,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
>  
>  	err = -ENOMEM;
>  	root = fuse_get_root_inode(sb, ctx->rootmode);
> -	sb->s_d_op = &fuse_dentry_operations;
> +	set_default_d_op(sb, &fuse_dentry_operations);
>  	root_dentry = d_make_root(root);
>  	if (!root_dentry)
>  		goto err_dev_free;
> diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
> index e83d293c3614..949bbdb5b564 100644
> --- a/fs/gfs2/ops_fstype.c
> +++ b/fs/gfs2/ops_fstype.c
> @@ -1156,7 +1156,7 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
>  	sb->s_flags |= SB_NOSEC;
>  	sb->s_magic = GFS2_MAGIC;
>  	sb->s_op = &gfs2_super_ops;
> -	sb->s_d_op = &gfs2_dops;
> +	set_default_d_op(sb, &gfs2_dops);
>  	sb->s_export_op = &gfs2_export_ops;
>  	sb->s_qcop = &gfs2_quotactl_ops;
>  	sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP;
> diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> index fe09c2093a93..388a318297ec 100644
> --- a/fs/hfs/super.c
> +++ b/fs/hfs/super.c
> @@ -365,7 +365,7 @@ static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	if (!root_inode)
>  		goto bail_no_root;
>  
> -	sb->s_d_op = &hfs_dentry_operations;
> +	set_default_d_op(sb, &hfs_dentry_operations);
>  	res = -ENOMEM;
>  	sb->s_root = d_make_root(root_inode);
>  	if (!sb->s_root)
> diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
> index 948b8aaee33e..0caf7aa1c249 100644
> --- a/fs/hfsplus/super.c
> +++ b/fs/hfsplus/super.c
> @@ -508,7 +508,7 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
>  		goto out_put_alloc_file;
>  	}
>  
> -	sb->s_d_op = &hfsplus_dentry_operations;
> +	set_default_d_op(sb, &hfsplus_dentry_operations);
>  	sb->s_root = d_make_root(root);
>  	if (!sb->s_root) {
>  		err = -ENOMEM;
> diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
> index e0741e468956..a0e0563a29d7 100644
> --- a/fs/hostfs/hostfs_kern.c
> +++ b/fs/hostfs/hostfs_kern.c
> @@ -920,7 +920,7 @@ static int hostfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	sb->s_blocksize_bits = 10;
>  	sb->s_magic = HOSTFS_SUPER_MAGIC;
>  	sb->s_op = &hostfs_sbops;
> -	sb->s_d_op = &simple_dentry_operations;
> +	set_default_d_op(sb, &simple_dentry_operations);
>  	sb->s_maxbytes = MAX_LFS_FILESIZE;
>  	err = super_setup_bdi(sb);
>  	if (err)
> diff --git a/fs/hpfs/super.c b/fs/hpfs/super.c
> index 27567920abe4..42b779b4d87f 100644
> --- a/fs/hpfs/super.c
> +++ b/fs/hpfs/super.c
> @@ -554,7 +554,7 @@ static int hpfs_fill_super(struct super_block *s, struct fs_context *fc)
>  	/* Fill superblock stuff */
>  	s->s_magic = HPFS_SUPER_MAGIC;
>  	s->s_op = &hpfs_sops;
> -	s->s_d_op = &hpfs_dentry_operations;
> +	set_default_d_op(s, &hpfs_dentry_operations);
>  	s->s_time_min =  local_to_gmt(s, 0);
>  	s->s_time_max =  local_to_gmt(s, U32_MAX);
>  
> diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
> index 47038e660812..05ddc2544ade 100644
> --- a/fs/isofs/inode.c
> +++ b/fs/isofs/inode.c
> @@ -939,7 +939,7 @@ static int isofs_fill_super(struct super_block *s, struct fs_context *fc)
>  	sbi->s_check = opt->check;
>  
>  	if (table)
> -		s->s_d_op = &isofs_dentry_ops[table - 1];
> +		set_default_d_op(s, &isofs_dentry_ops[table - 1]);
>  
>  	/* get the root dentry */
>  	s->s_root = d_make_root(inode);
> diff --git a/fs/jfs/super.c b/fs/jfs/super.c
> index 223d9ac59839..10c3cb714423 100644
> --- a/fs/jfs/super.c
> +++ b/fs/jfs/super.c
> @@ -542,7 +542,7 @@ static int jfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	sb->s_magic = JFS_SUPER_MAGIC;
>  
>  	if (sbi->mntflag & JFS_OS2)
> -		sb->s_d_op = &jfs_ci_dentry_operations;
> +		set_default_d_op(sb, &jfs_ci_dentry_operations);
>  
>  	inode = jfs_iget(sb, ROOT_I);
>  	if (IS_ERR(inode)) {
> diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
> index 1358c21837f1..91e788d15073 100644
> --- a/fs/kernfs/mount.c
> +++ b/fs/kernfs/mount.c
> @@ -281,7 +281,7 @@ static int kernfs_fill_super(struct super_block *sb, struct kernfs_fs_context *k
>  		return -ENOMEM;
>  	}
>  	sb->s_root = root;
> -	sb->s_d_op = &kernfs_dops;
> +	set_default_d_op(sb, &kernfs_dops);
>  	return 0;
>  }
>  
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 8444f5cc4064..929bef0fecbd 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -75,7 +75,7 @@ struct dentry *simple_lookup(struct inode *dir, struct dentry *dentry, unsigned
>  {
>  	if (dentry->d_name.len > NAME_MAX)
>  		return ERR_PTR(-ENAMETOOLONG);
> -	if (!dentry->d_sb->s_d_op)
> +	if (!dentry->d_op)
>  		d_set_d_op(dentry, &simple_dentry_operations);
>  
>  	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
> @@ -683,7 +683,7 @@ static int pseudo_fs_fill_super(struct super_block *s, struct fs_context *fc)
>  	s->s_root = d_make_root(root);
>  	if (!s->s_root)
>  		return -ENOMEM;
> -	s->s_d_op = ctx->dops;
> +	set_default_d_op(s, ctx->dops);
>  	return 0;
>  }
>  
> @@ -1943,22 +1943,22 @@ static const struct dentry_operations generic_encrypted_dentry_ops = {
>   * @sb: superblock to be configured
>   *
>   * Filesystems supporting casefolding and/or fscrypt can call this
> - * helper at mount-time to configure sb->s_d_op to best set of dentry
> - * operations required for the enabled features. The helper must be
> - * called after these have been configured, but before the root dentry
> - * is created.
> + * helper at mount-time to configure default dentry_operations to the
> + * best set of dentry operations required for the enabled features.
> + * The helper must be called after these have been configured, but
> + * before the root dentry is created.
>   */
>  void generic_set_sb_d_ops(struct super_block *sb)
>  {
>  #if IS_ENABLED(CONFIG_UNICODE)
>  	if (sb->s_encoding) {
> -		sb->s_d_op = &generic_ci_dentry_ops;
> +		set_default_d_op(sb, &generic_ci_dentry_ops);
>  		return;
>  	}
>  #endif
>  #ifdef CONFIG_FS_ENCRYPTION
>  	if (sb->s_cop) {
> -		sb->s_d_op = &generic_encrypted_dentry_ops;
> +		set_default_d_op(sb, &generic_encrypted_dentry_ops);
>  		return;
>  	}
>  #endif
> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> index aeb715b4a690..38b0ecf02ad6 100644
> --- a/fs/nfs/super.c
> +++ b/fs/nfs/super.c
> @@ -1169,7 +1169,7 @@ static int nfs_set_super(struct super_block *s, struct fs_context *fc)
>  	struct nfs_server *server = fc->s_fs_info;
>  	int ret;
>  
> -	s->s_d_op = server->nfs_client->rpc_ops->dentry_ops;
> +	set_default_d_op(s, server->nfs_client->rpc_ops->dentry_ops);
>  	ret = set_anon_super(s, server);
>  	if (ret == 0)
>  		server->s_dev = s->s_dev;
> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> index 6a0f6b0a3ab2..90f5361ae13f 100644
> --- a/fs/ntfs3/super.c
> +++ b/fs/ntfs3/super.c
> @@ -1182,7 +1182,8 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	sb->s_export_op = &ntfs_export_ops;
>  	sb->s_time_gran = NTFS_TIME_GRAN; // 100 nsec
>  	sb->s_xattr = ntfs_xattr_handlers;
> -	sb->s_d_op = options->nocase ? &ntfs_dentry_ops : NULL;
> +	if (options->nocase)
> +		set_default_d_op(sb, &ntfs_dentry_ops);
>  
>  	options->nls = ntfs_load_nls(options->nls_name);
>  	if (IS_ERR(options->nls)) {
> diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
> index 8bb5022f3082..411f72be4a9b 100644
> --- a/fs/ocfs2/super.c
> +++ b/fs/ocfs2/super.c
> @@ -1959,7 +1959,7 @@ static int ocfs2_initialize_super(struct super_block *sb,
>  
>  	sb->s_fs_info = osb;
>  	sb->s_op = &ocfs2_sops;
> -	sb->s_d_op = &ocfs2_dentry_ops;
> +	set_default_d_op(sb, &ocfs2_dentry_ops);
>  	sb->s_export_op = &ocfs2_export_ops;
>  	sb->s_qcop = &dquot_quotactl_sysfile_ops;
>  	sb->dq_op = &ocfs2_quota_operations;
> diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
> index eba3e357192e..d4c8d8b32f14 100644
> --- a/fs/orangefs/super.c
> +++ b/fs/orangefs/super.c
> @@ -434,7 +434,7 @@ static int orangefs_fill_sb(struct super_block *sb,
>  	sb->s_xattr = orangefs_xattr_handlers;
>  	sb->s_magic = ORANGEFS_SUPER_MAGIC;
>  	sb->s_op = &orangefs_s_ops;
> -	sb->s_d_op = &orangefs_dentry_operations;
> +	set_default_d_op(sb, &orangefs_dentry_operations);
>  
>  	sb->s_blocksize = PAGE_SIZE;
>  	sb->s_blocksize_bits = PAGE_SHIFT;
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 86ae6f6da36b..5f7a5a8c0778 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -1315,7 +1315,7 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
>  	if (WARN_ON(fc->user_ns != current_user_ns()))
>  		goto out_err;
>  
> -	sb->s_d_op = &ovl_dentry_operations;
> +	set_default_d_op(sb, &ovl_dentry_operations);
>  
>  	err = -ENOMEM;
>  	ofs->creator_cred = cred = prepare_creds();
> diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
> index 6a3bd652d251..5ba1046d1e5a 100644
> --- a/fs/smb/client/cifsfs.c
> +++ b/fs/smb/client/cifsfs.c
> @@ -261,9 +261,9 @@ cifs_read_super(struct super_block *sb)
>  	}
>  
>  	if (tcon->nocase)
> -		sb->s_d_op = &cifs_ci_dentry_ops;
> +		set_default_d_op(sb, &cifs_ci_dentry_ops);
>  	else
> -		sb->s_d_op = &cifs_dentry_ops;
> +		set_default_d_op(sb, &cifs_dentry_ops);
>  
>  	sb->s_root = d_make_root(inode);
>  	if (!sb->s_root) {
> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index 53214499e384..30a951133831 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -480,7 +480,7 @@ static int tracefs_fill_super(struct super_block *sb, struct fs_context *fc)
>  		return err;
>  
>  	sb->s_op = &tracefs_super_operations;
> -	sb->s_d_op = &tracefs_dentry_operations;
> +	set_default_d_op(sb, &tracefs_dentry_operations);
>  
>  	return 0;
>  }
> diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
> index 1d94bb784108..46eea52beb23 100644
> --- a/fs/vboxsf/super.c
> +++ b/fs/vboxsf/super.c
> @@ -190,7 +190,7 @@ static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
>  	sb->s_blocksize = 1024;
>  	sb->s_maxbytes = MAX_LFS_FILESIZE;
>  	sb->s_op = &vboxsf_super_ops;
> -	sb->s_d_op = &vboxsf_dentry_ops;
> +	set_default_d_op(sb, &vboxsf_dentry_ops);
>  
>  	iroot = iget_locked(sb, 0);
>  	if (!iroot) {
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index f47f3a47d97b..e8cf1d0fdd08 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -619,4 +619,6 @@ static inline struct dentry *d_next_sibling(const struct dentry *dentry)
>  	return hlist_entry_safe(dentry->d_sib.next, struct dentry, d_sib);
>  }
>  
> +void set_default_d_op(struct super_block *, const struct dentry_operations *);
> +
>  #endif	/* __LINUX_DCACHE_H */
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 2c3b2f8a621f..23fd8b0d4e81 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1405,7 +1405,7 @@ struct super_block {
>  	 */
>  	const char *s_subtype;
>  
> -	const struct dentry_operations *s_d_op; /* default d_op for dentries */
> +	const struct dentry_operations *__s_d_op; /* default d_op for dentries */
>  
>  	struct shrinker *s_shrink;	/* per-sb shrinker handle */
>  
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 4ea6109a8043..0ecb49113bb2 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -5019,7 +5019,7 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
>  
>  	if (ctx->encoding) {
>  		sb->s_encoding = ctx->encoding;
> -		sb->s_d_op = &shmem_ci_dentry_ops;
> +		set_default_d_op(sb, &shmem_ci_dentry_ops);
>  		if (ctx->strict_encoding)
>  			sb->s_encoding_flags = SB_ENC_STRICT_MODE_FL;
>  	}
> diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
> index eadc00410ebc..e093e4cf20fa 100644
> --- a/net/sunrpc/rpc_pipe.c
> +++ b/net/sunrpc/rpc_pipe.c
> @@ -1363,7 +1363,7 @@ rpc_fill_super(struct super_block *sb, struct fs_context *fc)
>  	sb->s_blocksize_bits = PAGE_SHIFT;
>  	sb->s_magic = RPCAUTH_GSSMAGIC;
>  	sb->s_op = &s_ops;
> -	sb->s_d_op = &simple_dentry_operations;
> +	set_default_d_op(sb, &simple_dentry_operations);
>  	sb->s_time_gran = 1;
>  
>  	inode = rpc_get_inode(sb, S_IFDIR | 0555);
> -- 
> 2.39.5
> 

