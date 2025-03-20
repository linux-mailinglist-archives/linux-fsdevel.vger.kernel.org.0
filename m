Return-Path: <linux-fsdevel+bounces-44539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E50CA6A3A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 11:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37719188D001
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 10:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BF9224252;
	Thu, 20 Mar 2025 10:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsgtP7Je"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE0C209F5E;
	Thu, 20 Mar 2025 10:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742466582; cv=none; b=P72ETzA/aJXq/2OyD0VYkV5uVULvz+ZmT8dMLwJg+ZFZiU2hnCyvTqyVGzV6YhxKwvRiKswuN2nOxmZNNzxt4nya5sGn+eOxt+3NVc2ejxrzccOXKGN91nv41VFUcI6JkEv2vp8mYd2zuUanUIebhxF3mYf57un8KTWYduzL6EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742466582; c=relaxed/simple;
	bh=H15aOIRzuEcxFGDizp8hFh4g6JzdrSwMwgtMoDbI4XI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rpNXYWJT88b3SF9sFSHx+6PvLGCxKaQDc+/Ow+jeGprq3TznGw7Gqm+h+yNsFtYR5VaWP07BI0caR29DtLn0EMtn1J3JCQiyYBaZFcPy6kO+MIY3+p211BPcpiBgUER8uNImJiyq3Ee/ddYptM6qgozdxVwogzRKqAripXaFgN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsgtP7Je; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE89DC4CEDD;
	Thu, 20 Mar 2025 10:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742466581;
	bh=H15aOIRzuEcxFGDizp8hFh4g6JzdrSwMwgtMoDbI4XI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=fsgtP7JeMU0heWWKw78sd9IN0RzGhzUs4kzUYxowZ/Ew79o/OhN518dSWmv6nCCYC
	 MAvPeaYJ64x164asntYXWt+DcN3SvlnxpHEMcBDF14rQmjI0ijRS9gUz+G83MiQ7kR
	 hiYP8B76OdMDUWWgxvZUoNZ4QfY7X8lVkrR/QbjOsj9DkaKjUZKJ3o1hAdBWw1WloU
	 IH2Pr88tFdCU3biLqqOuryB6as5r4xCUqq+8QE8fnf7cDPisvytzV91OwSDX34xa10
	 HRp8B0uul6cSSVPALaexeVEZp7eaYpYUK+vu8qw5acP45KZ4CScSH4kvZK6CwWK/v3
	 HQFUMsdyQbr6w==
Message-ID: <92c8c67bf90cae0ebdc87290e8a5954128baf36f.camel@kernel.org>
Subject: Re: [PATCH 4/6] VFS: rename lookup_one_len family to lookup_noperm
 and remove permission check
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neil@brown.name>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner	 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, David
 Howells <dhowells@redhat.com>,  Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Date: Thu, 20 Mar 2025 06:29:39 -0400
In-Reply-To: <20250319031545.2999807-5-neil@brown.name>
References: <20250319031545.2999807-1-neil@brown.name>
	 <20250319031545.2999807-5-neil@brown.name>
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
> The lookup_one_len family of functions is (now) only used internally by
> a filesystem on itself either
> - in a context where permission checking is irrelevant such as by a
>   virtual filesystem populating itself, or xfs accessing its ORPHANAGE
>   or dquota accessing the quota file; or
> - in a context where a permission check (MAY_EXEC on the parent) has just
>   been performed such as a network filesystem finding in "silly-rename"
>   file in the same directory.  This is also the context after the
>   _parentat() functions where currently lookup_one_qstr_excl() is used.
>=20
> So the permission check is pointless.
>=20
> The name "one_len" is unhelpful in understanding the purpose of these
> functions and should be changed.  Most of the callers pass the len as
> "strlen()" so using a qstr and QSTR() can simplify the code.
>=20
> This patch renames these functions (include lookup_positive_unlocked()
> which is part of the family despite the name) to have a name based on
> "lookup_noperm".  They are changed to receive a 'struct qstr' instead
> of separate name and len.  In a few cases the use of QSTR() results in a
> new call to strlen().
>=20
> try_lookup_noperm() takes a pointer to a qstr instead of the whole
> qstr.  This is consistent with d_hash_and_lookup() (which is nearly
> identical) and useful for lookup_noperm_unlocked().
>=20
> The new lookup_noperm_common() doesn't take a qstr yet.  That will be
> tidied up in a subsequent patch.
>=20
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  Documentation/filesystems/porting.rst | 20 +++++++
>  arch/s390/hypfs/inode.c               |  2 +-
>  drivers/android/binderfs.c            |  4 +-
>  drivers/infiniband/hw/qib/qib_fs.c    |  4 +-
>  fs/afs/dir.c                          |  2 +-
>  fs/afs/dir_silly.c                    |  6 +-
>  fs/autofs/dev-ioctl.c                 |  3 +-
>  fs/binfmt_misc.c                      |  2 +-
>  fs/debugfs/inode.c                    |  6 +-
>  fs/ecryptfs/inode.c                   | 16 ++---
>  fs/kernfs/mount.c                     |  4 +-
>  fs/namei.c                            | 86 ++++++++++++++++-----------
>  fs/nfs/unlink.c                       | 11 ++--
>  fs/overlayfs/export.c                 |  6 +-
>  fs/overlayfs/namei.c                  |  2 +-
>  fs/quota/dquot.c                      |  2 +-
>  fs/smb/client/cached_dir.c            |  5 +-
>  fs/smb/client/cifsfs.c                |  3 +-
>  fs/tracefs/inode.c                    |  2 +-
>  fs/xfs/scrub/orphanage.c              |  3 +-
>  include/linux/namei.h                 |  8 +--
>  ipc/mqueue.c                          |  5 +-
>  kernel/bpf/inode.c                    |  2 +-
>  security/apparmor/apparmorfs.c        |  4 +-
>  security/inode.c                      |  2 +-
>  25 files changed, 123 insertions(+), 87 deletions(-)
>=20
> diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesy=
stems/porting.rst
> index 06296ffd1e81..df9516cd82e0 100644
> --- a/Documentation/filesystems/porting.rst
> +++ b/Documentation/filesystems/porting.rst
> @@ -1205,3 +1205,23 @@ lookup_one(), lookup_one_unlocked(), lookup_one_po=
sitive_unlocked() now
>  take a qstr instead of a name and len.  These, not the "one_len"
>  versions, should be used whenever accessing a filesystem from outside
>  that filesysmtem, through a mount point - which will have a mnt_idmap.
> +
> +---
> +
> +** mandatory**
> +
> +Functions try_lookup_one_len(), lookup_one_len(),
> +lookup_one_len_unlocked() and lookup_positive_unlocked() have been
> +renamed to try_lookup_noperm(), lookup_noperm(),
> +lookup_noperm_unlocked(), lookup_noperm_positive_unlocked().  They now
> +take a qstr instead of separate name and length.  QSTR() can be used
> +when strlen() is needed for the length.
> +
> +For try_lookup_noperm() a reference to the qstr is passed in case the
> +hash might subsequently be needed.
> +
> +These function no longer do any permission checking - they previously
> +checked that the caller has 'X' permission on the parent.  They must
> +ONLY be used internally by a filesystem on itself when it knows that
> +permissions are irrelevant or in a context where permission checks have
> +already been performed such as after vfs_path_parent_lookup()
> diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
> index d428635abf08..2eed957393f4 100644
> --- a/arch/s390/hypfs/inode.c
> +++ b/arch/s390/hypfs/inode.c
> @@ -341,7 +341,7 @@ static struct dentry *hypfs_create_file(struct dentry=
 *parent, const char *name,
>  	struct inode *inode;
> =20
>  	inode_lock(d_inode(parent));
> -	dentry =3D lookup_one_len(name, parent, strlen(name));
> +	dentry =3D lookup_noperm(QSTR(name), parent);
>  	if (IS_ERR(dentry)) {
>  		dentry =3D ERR_PTR(-ENOMEM);
>  		goto fail;
> diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> index bc6bae76ccaf..172e825168c8 100644
> --- a/drivers/android/binderfs.c
> +++ b/drivers/android/binderfs.c
> @@ -187,7 +187,7 @@ static int binderfs_binder_device_create(struct inode=
 *ref_inode,
>  	inode_lock(d_inode(root));
> =20
>  	/* look it up */
> -	dentry =3D lookup_one_len(name, root, name_len);
> +	dentry =3D lookup_noperm(QSTR(name), root);
>  	if (IS_ERR(dentry)) {
>  		inode_unlock(d_inode(root));
>  		ret =3D PTR_ERR(dentry);
> @@ -486,7 +486,7 @@ static struct dentry *binderfs_create_dentry(struct d=
entry *parent,
>  {
>  	struct dentry *dentry;
> =20
> -	dentry =3D lookup_one_len(name, parent, strlen(name));
> +	dentry =3D lookup_noperm(QSTR(name), parent);
>  	if (IS_ERR(dentry))
>  		return dentry;
> =20
> diff --git a/drivers/infiniband/hw/qib/qib_fs.c b/drivers/infiniband/hw/q=
ib/qib_fs.c
> index b27791029fa9..c3aa40c3fb8f 100644
> --- a/drivers/infiniband/hw/qib/qib_fs.c
> +++ b/drivers/infiniband/hw/qib/qib_fs.c
> @@ -89,7 +89,7 @@ static int create_file(const char *name, umode_t mode,
>  	int error;
> =20
>  	inode_lock(d_inode(parent));
> -	*dentry =3D lookup_one_len(name, parent, strlen(name));
> +	*dentry =3D lookup_noperm(QSTR(name), parent);
>  	if (!IS_ERR(*dentry))
>  		error =3D qibfs_mknod(d_inode(parent), *dentry,
>  				    mode, fops, data);
> @@ -432,7 +432,7 @@ static int remove_device_files(struct super_block *sb=
,
>  	char unit[10];
> =20
>  	snprintf(unit, sizeof(unit), "%u", dd->unit);
> -	dir =3D lookup_one_len_unlocked(unit, sb->s_root, strlen(unit));
> +	dir =3D lookup_noperm_unlocked(QSTR(unit), sb->s_root);
> =20
>  	if (IS_ERR(dir)) {
>  		pr_err("Lookup of %s failed\n", unit);
> diff --git a/fs/afs/dir.c b/fs/afs/dir.c
> index 5bddcc20786e..0e633535d2c7 100644
> --- a/fs/afs/dir.c
> +++ b/fs/afs/dir.c
> @@ -943,7 +943,7 @@ static struct dentry *afs_lookup_atsys(struct inode *=
dir, struct dentry *dentry)
>  		}
> =20
>  		strcpy(p, name);
> -		ret =3D lookup_one_len(buf, dentry->d_parent, len);
> +		ret =3D lookup_noperm(QSTR(buf), dentry->d_parent);
>  		if (IS_ERR(ret) || d_is_positive(ret))
>  			goto out_s;
>  		dput(ret);
> diff --git a/fs/afs/dir_silly.c b/fs/afs/dir_silly.c
> index a1e581946b93..292a5c8c752a 100644
> --- a/fs/afs/dir_silly.c
> +++ b/fs/afs/dir_silly.c
> @@ -113,16 +113,14 @@ int afs_sillyrename(struct afs_vnode *dvnode, struc=
t afs_vnode *vnode,
> =20
>  	sdentry =3D NULL;
>  	do {
> -		int slen;
> -
>  		dput(sdentry);
>  		sillycounter++;
> =20
>  		/* Create a silly name.  Note that the ".__afs" prefix is
>  		 * understood by the salvager and must not be changed.
>  		 */
> -		slen =3D scnprintf(silly, sizeof(silly), ".__afs%04X", sillycounter);
> -		sdentry =3D lookup_one_len(silly, dentry->d_parent, slen);
> +		scnprintf(silly, sizeof(silly), ".__afs%04X", sillycounter);
> +		sdentry =3D lookup_noperm(QSTR(silly), dentry->d_parent);
> =20
>  		/* N.B. Better to return EBUSY here ... it could be dangerous
>  		 * to delete the file while it's in use.
> diff --git a/fs/autofs/dev-ioctl.c b/fs/autofs/dev-ioctl.c
> index 6d57efbb8110..a577b175c38a 100644
> --- a/fs/autofs/dev-ioctl.c
> +++ b/fs/autofs/dev-ioctl.c
> @@ -461,7 +461,8 @@ static int autofs_dev_ioctl_timeout(struct file *fp,
>  				"prevent shutdown\n");
> =20
>  		inode_lock_shared(inode);
> -		dentry =3D try_lookup_one_len(param->path, base, path_len);
> +		dentry =3D try_lookup_noperm(&QSTR_LEN(param->path, path_len),
> +					   base);
>  		inode_unlock_shared(inode);
>  		if (IS_ERR_OR_NULL(dentry))
>  			return dentry ? PTR_ERR(dentry) : -ENOENT;
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index 5a7ebd160724..f0996a76ee7c 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -842,7 +842,7 @@ static ssize_t bm_register_write(struct file *file, c=
onst char __user *buffer,
>  	}
> =20
>  	inode_lock(d_inode(root));
> -	dentry =3D lookup_one_len(e->name, root, strlen(e->name));
> +	dentry =3D lookup_noperm(QSTR(e->name), root);
>  	err =3D PTR_ERR(dentry);
>  	if (IS_ERR(dentry))
>  		goto out;
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index 75715d8877ee..feb5ccb5bba8 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -346,7 +346,7 @@ struct dentry *debugfs_lookup(const char *name, struc=
t dentry *parent)
>  	if (!parent)
>  		parent =3D debugfs_mount->mnt_root;
> =20
> -	dentry =3D lookup_positive_unlocked(name, parent, strlen(name));
> +	dentry =3D lookup_noperm_positive_unlocked(QSTR(name), parent);
>  	if (IS_ERR(dentry))
>  		return NULL;
>  	return dentry;
> @@ -388,7 +388,7 @@ static struct dentry *start_creating(const char *name=
, struct dentry *parent)
>  	if (unlikely(IS_DEADDIR(d_inode(parent))))
>  		dentry =3D ERR_PTR(-ENOENT);
>  	else
> -		dentry =3D lookup_one_len(name, parent, strlen(name));
> +		dentry =3D lookup_noperm(QSTR(name), parent);
>  	if (!IS_ERR(dentry) && d_really_is_positive(dentry)) {
>  		if (d_is_dir(dentry))
>  			pr_err("Directory '%s' with parent '%s' already present!\n",
> @@ -872,7 +872,7 @@ int __printf(2, 3) debugfs_change_name(struct dentry =
*dentry, const char *fmt, .
>  	}
>  	if (strcmp(old_name.name.name, new_name) =3D=3D 0)
>  		goto out;
> -	target =3D lookup_one_len(new_name, parent, strlen(new_name));
> +	target =3D lookup_noperm(QSTR(new_name), parent);
>  	if (IS_ERR(target)) {
>  		error =3D PTR_ERR(target);
>  		goto out;
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index 51a5c54eb740..9a0d40bb43d6 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -394,8 +394,8 @@ static struct dentry *ecryptfs_lookup(struct inode *e=
cryptfs_dir_inode,
>  	char *encrypted_and_encoded_name =3D NULL;
>  	struct ecryptfs_mount_crypt_stat *mount_crypt_stat;
>  	struct dentry *lower_dir_dentry, *lower_dentry;
> -	const char *name =3D ecryptfs_dentry->d_name.name;
> -	size_t len =3D ecryptfs_dentry->d_name.len;
> +	struct qstr qname =3D QSTR_INIT(ecryptfs_dentry->d_name.name,
> +				      ecryptfs_dentry->d_name.len);
>  	struct dentry *res;
>  	int rc =3D 0;
> =20
> @@ -404,23 +404,25 @@ static struct dentry *ecryptfs_lookup(struct inode =
*ecryptfs_dir_inode,
>  	mount_crypt_stat =3D &ecryptfs_superblock_to_private(
>  				ecryptfs_dentry->d_sb)->mount_crypt_stat;
>  	if (mount_crypt_stat->flags & ECRYPTFS_GLOBAL_ENCRYPT_FILENAMES) {
> +		size_t len =3D qname.len;
>  		rc =3D ecryptfs_encrypt_and_encode_filename(
>  			&encrypted_and_encoded_name, &len,
> -			mount_crypt_stat, name, len);
> +			mount_crypt_stat, qname.name, len);
>  		if (rc) {
>  			printk(KERN_ERR "%s: Error attempting to encrypt and encode "
>  			       "filename; rc =3D [%d]\n", __func__, rc);
>  			return ERR_PTR(rc);
>  		}
> -		name =3D encrypted_and_encoded_name;
> +		qname.name =3D encrypted_and_encoded_name;
> +		qname.len =3D len;
>  	}
> =20
> -	lower_dentry =3D lookup_one_len_unlocked(name, lower_dir_dentry, len);
> +	lower_dentry =3D lookup_noperm_unlocked(qname, lower_dir_dentry);
>  	if (IS_ERR(lower_dentry)) {
> -		ecryptfs_printk(KERN_DEBUG, "%s: lookup_one_len() returned "
> +		ecryptfs_printk(KERN_DEBUG, "%s: lookup_noperm() returned "
>  				"[%ld] on lower_dentry =3D [%s]\n", __func__,
>  				PTR_ERR(lower_dentry),
> -				name);
> +				qname.name);
>  		res =3D ERR_CAST(lower_dentry);
>  	} else {
>  		res =3D ecryptfs_lookup_interpose(ecryptfs_dentry, lower_dentry);
> diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
> index 1358c21837f1..46943a7fb4df 100644
> --- a/fs/kernfs/mount.c
> +++ b/fs/kernfs/mount.c
> @@ -233,8 +233,8 @@ struct dentry *kernfs_node_dentry(struct kernfs_node =
*kn,
>  			dput(dentry);
>  			return ERR_PTR(-EINVAL);
>  		}
> -		dtmp =3D lookup_positive_unlocked(kntmp->name, dentry,
> -					       strlen(kntmp->name));
> +		dtmp =3D lookup_noperm_positive_unlocked(QSTR(kntmp->name),
> +							 dentry);
>  		dput(dentry);
>  		if (IS_ERR(dtmp))
>  			return dtmp;
> diff --git a/fs/namei.c b/fs/namei.c
> index 75816fa80028..16605f7108c0 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2833,9 +2833,9 @@ int vfs_path_lookup(struct dentry *dentry, struct v=
fsmount *mnt,
>  }
>  EXPORT_SYMBOL(vfs_path_lookup);
> =20
> -static int lookup_one_common(struct mnt_idmap *idmap,
> -			     const char *name, struct dentry *base, int len,
> -			     struct qstr *this)
> +static int lookup_noperm_common(const char *name, struct dentry *base,
> +				  int len,
> +				  struct qstr *this)
>  {
>  	this->name =3D name;
>  	this->len =3D len;
> @@ -2860,51 +2860,59 @@ static int lookup_one_common(struct mnt_idmap *id=
map,
>  		if (err < 0)
>  			return err;
>  	}
> +	return 0;
> +}
> =20
> +static int lookup_one_common(struct mnt_idmap *idmap,
> +			     const char *name, struct dentry *base, int len,
> +			     struct qstr *this) {
> +	int err;
> +	err =3D lookup_noperm_common(name, base, len, this);
> +	if (err < 0)
> +		return err;
>  	return inode_permission(idmap, base->d_inode, MAY_EXEC);
>  }
> =20
>  /**
> - * try_lookup_one_len - filesystem helper to lookup single pathname comp=
onent
> - * @name:	pathname component to lookup
> + * try_lookup_noperm - filesystem helper to lookup single pathname compo=
nent
> + * @name:	qstr storing pathname component to lookup
>   * @base:	base directory to lookup from
> - * @len:	maximum length @len should be interpreted to
>   *
>   * Look up a dentry by name in the dcache, returning NULL if it does not
>   * currently exist.  The function does not try to create a dentry.
>   *
>   * Note that this routine is purely a helper for filesystem usage and sh=
ould
> - * not be called by generic code.
> + * not be called by generic code.  It does no permission checking.
>   *
>   * The caller must hold base->i_mutex.
>   */
> -struct dentry *try_lookup_one_len(const char *name, struct dentry *base,=
 int len)
> +struct dentry *try_lookup_noperm(struct qstr *name, struct dentry *base)
>  {
>  	struct qstr this;
>  	int err;
> =20
>  	WARN_ON_ONCE(!inode_is_locked(base->d_inode));
> =20
> -	err =3D lookup_one_common(&nop_mnt_idmap, name, base, len, &this);
> +	err =3D lookup_noperm_common(name->name, base, name->len, &this);
>  	if (err)
>  		return ERR_PTR(err);
> =20
> -	return lookup_dcache(&this, base, 0);
> +	name->hash =3D this.hash;
> +	return lookup_dcache(name, base, 0);
>  }
> -EXPORT_SYMBOL(try_lookup_one_len);
> +EXPORT_SYMBOL(try_lookup_noperm);
> =20
>  /**
> - * lookup_one_len - filesystem helper to lookup single pathname componen=
t
> - * @name:	pathname component to lookup
> + * lookup_noperm - filesystem helper to lookup single pathname component
> + * @name:	qstr storing pathname component to lookup
>   * @base:	base directory to lookup from
> - * @len:	maximum length @len should be interpreted to
>   *
>   * Note that this routine is purely a helper for filesystem usage and sh=
ould
> - * not be called by generic code.
> + * not be called by generic code.  It does no permission checking.
>   *
>   * The caller must hold base->i_mutex.
>   */
> -struct dentry *lookup_one_len(const char *name, struct dentry *base, int=
 len)
> +struct dentry *lookup_noperm(struct qstr name, struct dentry *base)
>  {
>  	struct dentry *dentry;
>  	struct qstr this;
> @@ -2912,14 +2920,14 @@ struct dentry *lookup_one_len(const char *name, s=
truct dentry *base, int len)
> =20
>  	WARN_ON_ONCE(!inode_is_locked(base->d_inode));
> =20
> -	err =3D lookup_one_common(&nop_mnt_idmap, name, base, len, &this);
> +	err =3D lookup_noperm_common(name.name, base, name.len, &this);
>  	if (err)
>  		return ERR_PTR(err);
> =20
>  	dentry =3D lookup_dcache(&this, base, 0);
>  	return dentry ? dentry : __lookup_slow(&this, base, 0);
>  }
> -EXPORT_SYMBOL(lookup_one_len);
> +EXPORT_SYMBOL(lookup_noperm);
> =20
>  /**
>   * lookup_one - lookup single pathname component
> @@ -2957,7 +2965,7 @@ EXPORT_SYMBOL(lookup_one);
>   *
>   * This can be used for in-kernel filesystem clients such as file server=
s.
>   *
> - * Unlike lookup_one_len, it should be called without the parent
> + * Unlike lookup_one, it should be called without the parent
>   * i_rwsem held, and will take the i_rwsem itself if necessary.
>   */
>  struct dentry *lookup_one_unlocked(struct mnt_idmap *idmap,
> @@ -3010,39 +3018,49 @@ struct dentry *lookup_one_positive_unlocked(struc=
t mnt_idmap *idmap,
>  EXPORT_SYMBOL(lookup_one_positive_unlocked);
> =20
>  /**
> - * lookup_one_len_unlocked - filesystem helper to lookup single pathname=
 component
> + * lookup_noperm_unlocked - filesystem helper to lookup single pathname =
component
>   * @name:	pathname component to lookup
>   * @base:	base directory to lookup from
>   * @len:	maximum length @len should be interpreted to
>   *
>   * Note that this routine is purely a helper for filesystem usage and sh=
ould
> - * not be called by generic code.
> + * not be called by generic code. It does no permission checking.
>   *
> - * Unlike lookup_one_len, it should be called without the parent
> - * i_mutex held, and will take the i_mutex itself if necessary.
> + * Unlike lookup_noperm, it should be called without the parent
> + * i_rwsem held, and will take the i_rwsem itself if necessary.
>   */
> -struct dentry *lookup_one_len_unlocked(const char *name,
> -				       struct dentry *base, int len)
> +struct dentry *lookup_noperm_unlocked(struct qstr name,
> +					struct dentry *base)
>  {
> -	return lookup_one_unlocked(&nop_mnt_idmap, QSTR_LEN(name, len), base);
> +	struct dentry *ret;
> +
> +	ret =3D try_lookup_noperm(&name, base);
> +	if (!ret)
> +		ret =3D lookup_slow(&name, base, 0);
> +	return ret;
>  }
> -EXPORT_SYMBOL(lookup_one_len_unlocked);
> +EXPORT_SYMBOL(lookup_noperm_unlocked);
> =20
>  /*
> - * Like lookup_one_len_unlocked(), except that it yields ERR_PTR(-ENOENT=
)
> + * Like lookup_noperm_unlocked(), except that it yields ERR_PTR(-ENOENT)
>   * on negatives.  Returns known positive or ERR_PTR(); that's what
>   * most of the users want.  Note that pinned negative with unlocked pare=
nt
> - * _can_ become positive at any time, so callers of lookup_one_len_unloc=
ked()
> + * _can_ become positive at any time, so callers of lookup_noperm_unlock=
ed()
>   * need to be very careful; pinned positives have ->d_inode stable, so
>   * this one avoids such problems.
>   */
> -struct dentry *lookup_positive_unlocked(const char *name,
> -				       struct dentry *base, int len)
> +struct dentry *lookup_noperm_positive_unlocked(struct qstr name,
> +					       struct dentry *base)
>  {
> -	return lookup_one_positive_unlocked(&nop_mnt_idmap, QSTR_LEN(name, len)=
,
> -					    base);
> +	struct dentry *ret =3D lookup_noperm_unlocked(name, base);
> +
> +	if (!IS_ERR(ret) && d_flags_negative(smp_load_acquire(&ret->d_flags))) =
{
> +		dput(ret);
> +		ret =3D ERR_PTR(-ENOENT);
> +	}
> +	return ret;
>  }
> -EXPORT_SYMBOL(lookup_positive_unlocked);
> +EXPORT_SYMBOL(lookup_noperm_positive_unlocked);
> =20
>  #ifdef CONFIG_UNIX98_PTYS
>  int path_pts(struct path *path)
> diff --git a/fs/nfs/unlink.c b/fs/nfs/unlink.c
> index bf77399696a7..f52e57c31ae4 100644
> --- a/fs/nfs/unlink.c
> +++ b/fs/nfs/unlink.c
> @@ -464,18 +464,17 @@ nfs_sillyrename(struct inode *dir, struct dentry *d=
entry)
> =20
>  	sdentry =3D NULL;
>  	do {
> -		int slen;
>  		dput(sdentry);
>  		sillycounter++;
> -		slen =3D scnprintf(silly, sizeof(silly),
> -				SILLYNAME_PREFIX "%0*llx%0*x",
> -				SILLYNAME_FILEID_LEN, fileid,
> -				SILLYNAME_COUNTER_LEN, sillycounter);
> +		scnprintf(silly, sizeof(silly),
> +			  SILLYNAME_PREFIX "%0*llx%0*x",
> +			  SILLYNAME_FILEID_LEN, fileid,
> +			  SILLYNAME_COUNTER_LEN, sillycounter);
> =20
>  		dfprintk(VFS, "NFS: trying to rename %pd to %s\n",
>  				dentry, silly);
> =20
> -		sdentry =3D lookup_one_len(silly, dentry->d_parent, slen);
> +		sdentry =3D lookup_noperm(QSTR(silly), dentry->d_parent);
>  		/*
>  		 * N.B. Better to return EBUSY here ... it could be
>  		 * dangerous to delete the file while it's in use.
> diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
> index 444aeeccb6da..a51025e8b2d0 100644
> --- a/fs/overlayfs/export.c
> +++ b/fs/overlayfs/export.c
> @@ -385,11 +385,9 @@ static struct dentry *ovl_lookup_real_one(struct den=
try *connected,
>  	 */
>  	take_dentry_name_snapshot(&name, real);
>  	/*
> -	 * No idmap handling here: it's an internal lookup.  Could skip
> -	 * permission checking altogether, but for now just use non-idmap
> -	 * transformed ids.
> +	 * No idmap handling here: it's an internal lookup.
>  	 */
> -	this =3D lookup_one_len(name.name.name, connected, name.name.len);
> +	this =3D lookup_noperm(name.name, connected);
>  	release_dentry_name_snapshot(&name);
>  	err =3D PTR_ERR(this);
>  	if (IS_ERR(this)) {
> diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> index 6a6301e4bba5..adb4af8d08db 100644
> --- a/fs/overlayfs/namei.c
> +++ b/fs/overlayfs/namei.c
> @@ -757,7 +757,7 @@ struct dentry *ovl_get_index_fh(struct ovl_fs *ofs, s=
truct ovl_fh *fh)
>  	if (err)
>  		return ERR_PTR(err);
> =20
> -	index =3D lookup_positive_unlocked(name.name, ofs->workdir, name.len);
> +	index =3D lookup_noperm_positive_unlocked(name, ofs->workdir);
>  	kfree(name.name);
>  	if (IS_ERR(index)) {
>  		if (PTR_ERR(index) =3D=3D -ENOENT)
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index 825c5c2e0962..ea426467f26b 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -2560,7 +2560,7 @@ int dquot_quota_on_mount(struct super_block *sb, ch=
ar *qf_name,
>  	struct dentry *dentry;
>  	int error;
> =20
> -	dentry =3D lookup_positive_unlocked(qf_name, sb->s_root, strlen(qf_name=
));
> +	dentry =3D lookup_noperm_positive_unlocked(QSTR(qf_name), sb->s_root);
>  	if (IS_ERR(dentry))
>  		return PTR_ERR(dentry);
> =20
> diff --git a/fs/smb/client/cached_dir.c b/fs/smb/client/cached_dir.c
> index fe738623cf1b..854de94fc394 100644
> --- a/fs/smb/client/cached_dir.c
> +++ b/fs/smb/client/cached_dir.c
> @@ -109,7 +109,8 @@ path_to_dentry(struct cifs_sb_info *cifs_sb, const ch=
ar *path)
>  		while (*s && *s !=3D sep)
>  			s++;
> =20
> -		child =3D lookup_positive_unlocked(p, dentry, s - p);
> +		child =3D lookup_noperm_positive_unlocked(QSTR_LEN(p, s-p),
> +							dentry);
>  		dput(dentry);
>  		dentry =3D child;
>  	} while (!IS_ERR(dentry));
> @@ -207,7 +208,7 @@ int open_cached_dir(unsigned int xid, struct cifs_tco=
n *tcon,
>  	spin_unlock(&cfids->cfid_list_lock);
> =20
>  	/*
> -	 * Skip any prefix paths in @path as lookup_positive_unlocked() ends up
> +	 * Skip any prefix paths in @path as lookup_noperm_positive_unlocked() =
ends up
>  	 * calling ->lookup() which already adds those through
>  	 * build_path_from_dentry().  Also, do it earlier as we might reconnect
>  	 * below when trying to send compounded request and then potentially
> diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
> index 6a3bd652d251..71eadc0305b5 100644
> --- a/fs/smb/client/cifsfs.c
> +++ b/fs/smb/client/cifsfs.c
> @@ -925,7 +925,8 @@ cifs_get_root(struct smb3_fs_context *ctx, struct sup=
er_block *sb)
>  		while (*s && *s !=3D sep)
>  			s++;
> =20
> -		child =3D lookup_positive_unlocked(p, dentry, s - p);
> +		child =3D lookup_noperm_positive_unlocked(QSTR_LEN(p, s - p),
> +							dentry);
>  		dput(dentry);
>  		dentry =3D child;
>  	} while (!IS_ERR(dentry));
> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index cb1af30b49f5..aa7982e9b579 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -555,7 +555,7 @@ struct dentry *tracefs_start_creating(const char *nam=
e, struct dentry *parent)
>  	if (unlikely(IS_DEADDIR(d_inode(parent))))
>  		dentry =3D ERR_PTR(-ENOENT);
>  	else
> -		dentry =3D lookup_one_len(name, parent, strlen(name));
> +		dentry =3D lookup_noperm(QSTR(name), parent);
>  	if (!IS_ERR(dentry) && d_inode(dentry)) {
>  		dput(dentry);
>  		dentry =3D ERR_PTR(-EEXIST);
> diff --git a/fs/xfs/scrub/orphanage.c b/fs/xfs/scrub/orphanage.c
> index 3537f3cca6d5..987af5b2bb82 100644
> --- a/fs/xfs/scrub/orphanage.c
> +++ b/fs/xfs/scrub/orphanage.c
> @@ -153,8 +153,7 @@ xrep_orphanage_create(
> =20
>  	/* Try to find the orphanage directory. */
>  	inode_lock_nested(root_inode, I_MUTEX_PARENT);
> -	orphanage_dentry =3D lookup_one_len(ORPHANAGE, root_dentry,
> -			strlen(ORPHANAGE));
> +	orphanage_dentry =3D lookup_noperm(QSTR(ORPHANAGE), root_dentry);
>  	if (IS_ERR(orphanage_dentry)) {
>  		error =3D PTR_ERR(orphanage_dentry);
>  		goto out_unlock_root;
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index 508dae67e3c5..befe75439d7e 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -69,10 +69,10 @@ int vfs_path_parent_lookup(struct filename *filename,=
 unsigned int flags,
>  int vfs_path_lookup(struct dentry *, struct vfsmount *, const char *,
>  		    unsigned int, struct path *);
> =20
> -extern struct dentry *try_lookup_one_len(const char *, struct dentry *, =
int);
> -extern struct dentry *lookup_one_len(const char *, struct dentry *, int)=
;
> -extern struct dentry *lookup_one_len_unlocked(const char *, struct dentr=
y *, int);
> -extern struct dentry *lookup_positive_unlocked(const char *, struct dent=
ry *, int);
> +extern struct dentry *try_lookup_noperm(struct qstr *, struct dentry *);
> +extern struct dentry *lookup_noperm(struct qstr, struct dentry *);
> +extern struct dentry *lookup_noperm_unlocked(struct qstr, struct dentry =
*);
> +extern struct dentry *lookup_noperm_positive_unlocked(struct qstr, struc=
t dentry *);
>  struct dentry *lookup_one(struct mnt_idmap *, struct qstr, struct dentry=
 *);
>  struct dentry *lookup_one_unlocked(struct mnt_idmap *idmap,
>  				   struct qstr name, struct dentry *base);
> diff --git a/ipc/mqueue.c b/ipc/mqueue.c
> index 35b4f8659904..f3d76c4b6013 100644
> --- a/ipc/mqueue.c
> +++ b/ipc/mqueue.c
> @@ -913,7 +913,7 @@ static int do_mq_open(const char __user *u_name, int =
oflag, umode_t mode,
> =20
>  	ro =3D mnt_want_write(mnt);	/* we'll drop it in any case */
>  	inode_lock(d_inode(root));
> -	path.dentry =3D lookup_one_len(name->name, root, strlen(name->name));
> +	path.dentry =3D lookup_noperm(QSTR(name->name), root);
>  	if (IS_ERR(path.dentry)) {
>  		error =3D PTR_ERR(path.dentry);
>  		goto out_putfd;
> @@ -969,8 +969,7 @@ SYSCALL_DEFINE1(mq_unlink, const char __user *, u_nam=
e)
>  	if (err)
>  		goto out_name;
>  	inode_lock_nested(d_inode(mnt->mnt_root), I_MUTEX_PARENT);
> -	dentry =3D lookup_one_len(name->name, mnt->mnt_root,
> -				strlen(name->name));
> +	dentry =3D lookup_noperm(QSTR(name->name), mnt->mnt_root);
>  	if (IS_ERR(dentry)) {
>  		err =3D PTR_ERR(dentry);
>  		goto out_unlock;
> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index dc3aa91a6ba0..77fda4101b06 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c
> @@ -421,7 +421,7 @@ static int bpf_iter_link_pin_kernel(struct dentry *pa=
rent,
>  	int ret;
> =20
>  	inode_lock(parent->d_inode);
> -	dentry =3D lookup_one_len(name, parent, strlen(name));
> +	dentry =3D lookup_noperm(QSTR(name), parent);
>  	if (IS_ERR(dentry)) {
>  		inode_unlock(parent->d_inode);
>  		return PTR_ERR(dentry);
> diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorf=
s.c
> index 6039afae4bfc..dfc56cec5ab5 100644
> --- a/security/apparmor/apparmorfs.c
> +++ b/security/apparmor/apparmorfs.c
> @@ -283,7 +283,7 @@ static struct dentry *aafs_create(const char *name, u=
mode_t mode,
>  	dir =3D d_inode(parent);
> =20
>  	inode_lock(dir);
> -	dentry =3D lookup_one_len(name, parent, strlen(name));
> +	dentry =3D lookup_noperm(QSTR(name), parent);
>  	if (IS_ERR(dentry)) {
>  		error =3D PTR_ERR(dentry);
>  		goto fail_lock;
> @@ -2551,7 +2551,7 @@ static int aa_mk_null_file(struct dentry *parent)
>  		return error;
> =20
>  	inode_lock(d_inode(parent));
> -	dentry =3D lookup_one_len(NULL_FILE_NAME, parent, strlen(NULL_FILE_NAME=
));
> +	dentry =3D lookup_noperm(QSTR(NULL_FILE_NAME), parent);
>  	if (IS_ERR(dentry)) {
>  		error =3D PTR_ERR(dentry);
>  		goto out;
> diff --git a/security/inode.c b/security/inode.c
> index da3ab44c8e57..d04a52a52bdd 100644
> --- a/security/inode.c
> +++ b/security/inode.c
> @@ -128,7 +128,7 @@ static struct dentry *securityfs_create_dentry(const =
char *name, umode_t mode,
>  	dir =3D d_inode(parent);
> =20
>  	inode_lock(dir);
> -	dentry =3D lookup_one_len(name, parent, strlen(name));
> +	dentry =3D lookup_noperm(QSTR(name), parent);
>  	if (IS_ERR(dentry))
>  		goto out;
> =20

Reviewed-by: Jeff Layton <jlayton@kernel.org>

