Return-Path: <linux-fsdevel+bounces-39546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FCEA157AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 19:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81EAF7A1D6E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 18:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F9C1A7265;
	Fri, 17 Jan 2025 18:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WaRN8psN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC33019B3EC;
	Fri, 17 Jan 2025 18:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737140104; cv=none; b=LP4+jFNYao39mEZz6yaXQ2lYbH8NiEGmml7uLHueQVgGWGy+nKzX4zmh1Z2mwWLANwUHZYTxWfpZV3Yfhhg486M/iZOIFKs4EKalETyAl8zXOcFDPwgg3fikmK+pKhCnKyzpdpBeDoNsUgvHK4pDwZF+hNSRExSqUGyHEQhbT1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737140104; c=relaxed/simple;
	bh=oXWeuahTOX/tiXNxMDYitL3I8tW0eAn2UOw/qkr1O8g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LuHVEQoYco6fqHP2nRbQQvtDixQpuPCJcPXB3AopNGa2mep+r6nwJUt7CmQuaKHEBsdcWgr7bVzgNM8zyF4JMVUGh/Y7iPezejRr7c7demBiUNbB3J/kYdTaAsf0R2X7ts920PxAib0HWN0rh/oBlCM35LDYwuYB0IXamWBZtiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WaRN8psN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D8AC4CEDD;
	Fri, 17 Jan 2025 18:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737140103;
	bh=oXWeuahTOX/tiXNxMDYitL3I8tW0eAn2UOw/qkr1O8g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=WaRN8psN+k0Q9Bq77lV8X9bQizmw8aEN0pofrN0DsRYx9FsCyjyYr4nPP2gTo8w8s
	 tiVB1y9xShOdbZnS1WK0N51xo3DsapoPv7LpbbeEepRMypiQBvaVCokdtUsYJLC0Cs
	 /S97wYDi2LbppH/3g373ZRRW1ePeBdIw3K3XQCnhiRC7T7dWqHy3ol7KwCxpyx/MyN
	 x4h0/szdrBVQ6h7VaCqYjs2L4+GqWAM34f02ZagP9q0UUCuDhvI8u6vzHPjkvQZM0y
	 c+J2OF247QvqxnsBwCIgRCDIcy+ieATcMGc9Lt4Mhv/FM4ENYc5ZWX23ITu/iJST9O
	 M7XaPrmnLYRZA==
Message-ID: <a345eacd1ec75dd5931b145e32f65e6725a26bf7.camel@kernel.org>
Subject: Re: [PATCH v2 07/20] Pass parent directory inode and expected name
 to ->d_revalidate()
From: Jeff Layton <jlayton@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc: agruenba@redhat.com, amir73il@gmail.com, brauner@kernel.org, 
	ceph-devel@vger.kernel.org, dhowells@redhat.com, hubcap@omnibond.com,
 jack@suse.cz, 	krisman@kernel.org, linux-nfs@vger.kernel.org,
 miklos@szeredi.hu, 	torvalds@linux-foundation.org
Date: Fri, 17 Jan 2025 13:55:01 -0500
In-Reply-To: <20250116052317.485356-7-viro@zeniv.linux.org.uk>
References: <20250116052103.GF1977892@ZenIV>
	 <20250116052317.485356-1-viro@zeniv.linux.org.uk>
	 <20250116052317.485356-7-viro@zeniv.linux.org.uk>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-01-16 at 05:23 +0000, Al Viro wrote:
> ->d_revalidate() often needs to access dentry parent and name; that has
> to be done carefully, since the locking environment varies from caller
> to caller.  We are not guaranteed that dentry in question will not be
> moved right under us - not unless the filesystem is such that nothing
> on it ever gets renamed.
>=20
> It can be dealt with, but that results in boilerplate code that isn't
> even needed - the callers normally have just found the dentry via dcache
> lookup and want to verify that it's in the right place; they already
> have the values of ->d_parent and ->d_name stable.  There is a couple
> of exceptions (overlayfs and, to less extent, ecryptfs), but for the
> majority of calls that song and dance is not needed at all.
>=20
> It's easier to make ecryptfs and overlayfs find and pass those values if
> there's a ->d_revalidate() instance to be called, rather than doing that
> in the instances.
>=20
> This commit only changes the calling conventions; making use of supplied
> values is left to followups.
>=20
> NOTE: some instances need more than just the parent - things like CIFS
> may need to build an entire path from filesystem root, so they need
> more precautions than the usual boilerplate.  This series doesn't
> do anything to that need - these filesystems have to keep their locking
> mechanisms (rename_lock loops, use of dentry_path_raw(), private rwsem
> a-la v9fs).
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  Documentation/filesystems/locking.rst |  3 ++-
>  Documentation/filesystems/porting.rst | 13 +++++++++++++
>  Documentation/filesystems/vfs.rst     |  3 ++-
>  fs/9p/vfs_dentry.c                    | 10 ++++++++--
>  fs/afs/dir.c                          |  6 ++++--
>  fs/ceph/dir.c                         |  5 +++--
>  fs/coda/dir.c                         |  3 ++-
>  fs/crypto/fname.c                     |  3 ++-
>  fs/ecryptfs/dentry.c                  | 18 ++++++++++++++----
>  fs/exfat/namei.c                      |  3 ++-
>  fs/fat/namei_vfat.c                   |  6 ++++--
>  fs/fuse/dir.c                         |  3 ++-
>  fs/gfs2/dentry.c                      |  7 +++++--
>  fs/hfs/sysdep.c                       |  3 ++-
>  fs/jfs/namei.c                        |  3 ++-
>  fs/kernfs/dir.c                       |  3 ++-
>  fs/namei.c                            | 18 ++++++++++--------
>  fs/nfs/dir.c                          |  9 ++++++---
>  fs/ocfs2/dcache.c                     |  3 ++-
>  fs/orangefs/dcache.c                  |  3 ++-
>  fs/overlayfs/super.c                  | 22 ++++++++++++++++++++--
>  fs/proc/base.c                        |  6 ++++--
>  fs/proc/fd.c                          |  3 ++-
>  fs/proc/generic.c                     |  6 ++++--
>  fs/proc/proc_sysctl.c                 |  3 ++-
>  fs/smb/client/dir.c                   |  3 ++-
>  fs/tracefs/inode.c                    |  3 ++-
>  fs/vboxsf/dir.c                       |  3 ++-
>  include/linux/dcache.h                |  3 ++-
>  include/linux/fscrypt.h               |  7 ++++---
>  30 files changed, 133 insertions(+), 51 deletions(-)
>=20
> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesy=
stems/locking.rst
> index f5e3676db954..146e7d8aa736 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -17,7 +17,8 @@ dentry_operations
> =20
>  prototypes::
> =20
> -	int (*d_revalidate)(struct dentry *, unsigned int);
> +	int (*d_revalidate)(struct inode *, const struct qstr *,
> +			    struct dentry *, unsigned int);
>  	int (*d_weak_revalidate)(struct dentry *, unsigned int);
>  	int (*d_hash)(const struct dentry *, struct qstr *);
>  	int (*d_compare)(const struct dentry *,
> diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesy=
stems/porting.rst
> index 9ab2a3d6f2b4..b50c3ce36ef2 100644
> --- a/Documentation/filesystems/porting.rst
> +++ b/Documentation/filesystems/porting.rst
> @@ -1141,3 +1141,16 @@ pointer are gone.
> =20
>  set_blocksize() takes opened struct file instead of struct block_device =
now
>  and it *must* be opened exclusive.
> +
> +---
> +
> +** mandatory**
> +
> +->d_revalidate() gets two extra arguments - inode of parent directory an=
d
> +name our dentry is expected to have.  Both are stable (dir is pinned in
> +non-RCU case and will stay around during the call in RCU case, and name
> +is guaranteed to stay unchanging).  Your instance doesn't have to use
> +either, but it often helps to avoid a lot of painful boilerplate.
> +NOTE: if you need something like full path from the root of filesystem,
> +you are still on your own - this assists with simple cases, but it's not
> +magic.
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystem=
s/vfs.rst
> index 0b18af3f954e..7c352ebaae98 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -1251,7 +1251,8 @@ defined:
>  .. code-block:: c
> =20
>  	struct dentry_operations {
> -		int (*d_revalidate)(struct dentry *, unsigned int);
> +		int (*d_revalidate)(struct inode *, const struct qstr *,
> +				    struct dentry *, unsigned int);
>  		int (*d_weak_revalidate)(struct dentry *, unsigned int);
>  		int (*d_hash)(const struct dentry *, struct qstr *);
>  		int (*d_compare)(const struct dentry *,
> diff --git a/fs/9p/vfs_dentry.c b/fs/9p/vfs_dentry.c
> index 01338d4c2d9e..872c1abe3295 100644
> --- a/fs/9p/vfs_dentry.c
> +++ b/fs/9p/vfs_dentry.c
> @@ -61,7 +61,7 @@ static void v9fs_dentry_release(struct dentry *dentry)
>  		p9_fid_put(hlist_entry(p, struct p9_fid, dlist));
>  }
> =20
> -static int v9fs_lookup_revalidate(struct dentry *dentry, unsigned int fl=
ags)
> +static int __v9fs_lookup_revalidate(struct dentry *dentry, unsigned int =
flags)
>  {
>  	struct p9_fid *fid;
>  	struct inode *inode;
> @@ -99,9 +99,15 @@ static int v9fs_lookup_revalidate(struct dentry *dentr=
y, unsigned int flags)
>  	return 1;
>  }
> =20
> +static int v9fs_lookup_revalidate(struct inode *dir, const struct qstr *=
name,
> +				  struct dentry *dentry, unsigned int flags)
> +{
> +	return __v9fs_lookup_revalidate(dentry, flags);
> +}
> +
>  const struct dentry_operations v9fs_cached_dentry_operations =3D {
>  	.d_revalidate =3D v9fs_lookup_revalidate,
> -	.d_weak_revalidate =3D v9fs_lookup_revalidate,
> +	.d_weak_revalidate =3D __v9fs_lookup_revalidate,
>  	.d_delete =3D v9fs_cached_dentry_delete,
>  	.d_release =3D v9fs_dentry_release,
>  };
> diff --git a/fs/afs/dir.c b/fs/afs/dir.c
> index ada363af5aab..9780013cd83a 100644
> --- a/fs/afs/dir.c
> +++ b/fs/afs/dir.c
> @@ -22,7 +22,8 @@ static struct dentry *afs_lookup(struct inode *dir, str=
uct dentry *dentry,
>  				 unsigned int flags);
>  static int afs_dir_open(struct inode *inode, struct file *file);
>  static int afs_readdir(struct file *file, struct dir_context *ctx);
> -static int afs_d_revalidate(struct dentry *dentry, unsigned int flags);
> +static int afs_d_revalidate(struct inode *dir, const struct qstr *name,
> +			    struct dentry *dentry, unsigned int flags);
>  static int afs_d_delete(const struct dentry *dentry);
>  static void afs_d_iput(struct dentry *dentry, struct inode *inode);
>  static bool afs_lookup_one_filldir(struct dir_context *ctx, const char *=
name, int nlen,
> @@ -1093,7 +1094,8 @@ static int afs_d_revalidate_rcu(struct dentry *dent=
ry)
>   * - NOTE! the hit can be a negative hit too, so we can't assume we have=
 an
>   *   inode
>   */
> -static int afs_d_revalidate(struct dentry *dentry, unsigned int flags)
> +static int afs_d_revalidate(struct inode *parent_dir, const struct qstr =
*name,
> +			    struct dentry *dentry, unsigned int flags)
>  {
>  	struct afs_vnode *vnode, *dir;
>  	struct afs_fid fid;
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index 0bf388e07a02..c4c71c24221b 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -1940,7 +1940,8 @@ static int dir_lease_is_valid(struct inode *dir, st=
ruct dentry *dentry,
>  /*
>   * Check if cached dentry can be trusted.
>   */
> -static int ceph_d_revalidate(struct dentry *dentry, unsigned int flags)
> +static int ceph_d_revalidate(struct inode *parent_dir, const struct qstr=
 *name,
> +			     struct dentry *dentry, unsigned int flags)
>  {
>  	struct ceph_mds_client *mdsc =3D ceph_sb_to_fs_client(dentry->d_sb)->md=
sc;
>  	struct ceph_client *cl =3D mdsc->fsc->client;
> @@ -1948,7 +1949,7 @@ static int ceph_d_revalidate(struct dentry *dentry,=
 unsigned int flags)
>  	struct dentry *parent;
>  	struct inode *dir, *inode;
> =20
> -	valid =3D fscrypt_d_revalidate(dentry, flags);
> +	valid =3D fscrypt_d_revalidate(parent_dir, name, dentry, flags);
>  	if (valid <=3D 0)
>  		return valid;
> =20
> diff --git a/fs/coda/dir.c b/fs/coda/dir.c
> index 4e552ba7bd43..a3e2dfeedfbf 100644
> --- a/fs/coda/dir.c
> +++ b/fs/coda/dir.c
> @@ -445,7 +445,8 @@ static int coda_readdir(struct file *coda_file, struc=
t dir_context *ctx)
>  }
> =20
>  /* called when a cache lookup succeeds */
> -static int coda_dentry_revalidate(struct dentry *de, unsigned int flags)
> +static int coda_dentry_revalidate(struct inode *dir, const struct qstr *=
name,
> +				  struct dentry *de, unsigned int flags)
>  {
>  	struct inode *inode;
>  	struct coda_inode_info *cii;
> diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
> index 0ad52fbe51c9..389f5b2bf63b 100644
> --- a/fs/crypto/fname.c
> +++ b/fs/crypto/fname.c
> @@ -574,7 +574,8 @@ EXPORT_SYMBOL_GPL(fscrypt_fname_siphash);
>   * Validate dentries in encrypted directories to make sure we aren't pot=
entially
>   * caching stale dentries after a key has been added.
>   */
> -int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags)
> +int fscrypt_d_revalidate(struct inode *parent_dir, const struct qstr *na=
me,
> +			 struct dentry *dentry, unsigned int flags)
>  {
>  	struct dentry *dir;
>  	int err;
> diff --git a/fs/ecryptfs/dentry.c b/fs/ecryptfs/dentry.c
> index acaa0825e9bb..1dfd5b81d831 100644
> --- a/fs/ecryptfs/dentry.c
> +++ b/fs/ecryptfs/dentry.c
> @@ -17,7 +17,9 @@
> =20
>  /**
>   * ecryptfs_d_revalidate - revalidate an ecryptfs dentry
> - * @dentry: The ecryptfs dentry
> + * @dir: inode of expected parent
> + * @name: expected name
> + * @dentry: dentry to revalidate
>   * @flags: lookup flags
>   *
>   * Called when the VFS needs to revalidate a dentry. This
> @@ -28,7 +30,8 @@
>   * Returns 1 if valid, 0 otherwise.
>   *
>   */
> -static int ecryptfs_d_revalidate(struct dentry *dentry, unsigned int fla=
gs)
> +static int ecryptfs_d_revalidate(struct inode *dir, const struct qstr *n=
ame,
> +				 struct dentry *dentry, unsigned int flags)
>  {
>  	struct dentry *lower_dentry =3D ecryptfs_dentry_to_lower(dentry);
>  	int rc =3D 1;
> @@ -36,8 +39,15 @@ static int ecryptfs_d_revalidate(struct dentry *dentry=
, unsigned int flags)
>  	if (flags & LOOKUP_RCU)
>  		return -ECHILD;
> =20
> -	if (lower_dentry->d_flags & DCACHE_OP_REVALIDATE)
> -		rc =3D lower_dentry->d_op->d_revalidate(lower_dentry, flags);
> +	if (lower_dentry->d_flags & DCACHE_OP_REVALIDATE) {
> +		struct inode *lower_dir =3D ecryptfs_inode_to_lower(dir);
> +		struct name_snapshot n;
> +
> +		take_dentry_name_snapshot(&n, lower_dentry);
> +		rc =3D lower_dentry->d_op->d_revalidate(lower_dir, &n.name,
> +						      lower_dentry, flags);
> +		release_dentry_name_snapshot(&n);
> +	}
> =20
>  	if (d_really_is_positive(dentry)) {
>  		struct inode *inode =3D d_inode(dentry);
> diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
> index 97d2774760fe..e3b4feccba07 100644
> --- a/fs/exfat/namei.c
> +++ b/fs/exfat/namei.c
> @@ -31,7 +31,8 @@ static inline void exfat_d_version_set(struct dentry *d=
entry,
>   * If it happened, the negative dentry isn't actually negative anymore. =
 So,
>   * drop it.
>   */
> -static int exfat_d_revalidate(struct dentry *dentry, unsigned int flags)
> +static int exfat_d_revalidate(struct inode *dir, const struct qstr *name=
,
> +			      struct dentry *dentry, unsigned int flags)
>  {
>  	int ret;
> =20
> diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
> index 15bf32c21ac0..f9cbd5c6f932 100644
> --- a/fs/fat/namei_vfat.c
> +++ b/fs/fat/namei_vfat.c
> @@ -53,7 +53,8 @@ static int vfat_revalidate_shortname(struct dentry *den=
try)
>  	return ret;
>  }
> =20
> -static int vfat_revalidate(struct dentry *dentry, unsigned int flags)
> +static int vfat_revalidate(struct inode *dir, const struct qstr *name,
> +			   struct dentry *dentry, unsigned int flags)
>  {
>  	if (flags & LOOKUP_RCU)
>  		return -ECHILD;
> @@ -64,7 +65,8 @@ static int vfat_revalidate(struct dentry *dentry, unsig=
ned int flags)
>  	return vfat_revalidate_shortname(dentry);
>  }
> =20
> -static int vfat_revalidate_ci(struct dentry *dentry, unsigned int flags)
> +static int vfat_revalidate_ci(struct inode *dir, const struct qstr *name=
,
> +			      struct dentry *dentry, unsigned int flags)
>  {
>  	if (flags & LOOKUP_RCU)
>  		return -ECHILD;
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 494ac372ace0..d9e9f26917eb 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -192,7 +192,8 @@ static void fuse_lookup_init(struct fuse_conn *fc, st=
ruct fuse_args *args,
>   * the lookup once more.  If the lookup results in the same inode,
>   * then refresh the attributes, timeouts and mark the dentry valid.
>   */
> -static int fuse_dentry_revalidate(struct dentry *entry, unsigned int fla=
gs)
> +static int fuse_dentry_revalidate(struct inode *dir, const struct qstr *=
name,
> +				  struct dentry *entry, unsigned int flags)
>  {
>  	struct inode *inode;
>  	struct dentry *parent;
> diff --git a/fs/gfs2/dentry.c b/fs/gfs2/dentry.c
> index 2e215e8c3c88..86c338901fab 100644
> --- a/fs/gfs2/dentry.c
> +++ b/fs/gfs2/dentry.c
> @@ -21,7 +21,9 @@
> =20
>  /**
>   * gfs2_drevalidate - Check directory lookup consistency
> - * @dentry: the mapping to check
> + * @dir: expected parent directory inode
> + * @name: expexted name
> + * @dentry: dentry to check
>   * @flags: lookup flags
>   *
>   * Check to make sure the lookup necessary to arrive at this inode from =
its
> @@ -30,7 +32,8 @@
>   * Returns: 1 if the dentry is ok, 0 if it isn't
>   */
> =20
> -static int gfs2_drevalidate(struct dentry *dentry, unsigned int flags)
> +static int gfs2_drevalidate(struct inode *dir, const struct qstr *name,
> +			    struct dentry *dentry, unsigned int flags)
>  {
>  	struct dentry *parent;
>  	struct gfs2_sbd *sdp;
> diff --git a/fs/hfs/sysdep.c b/fs/hfs/sysdep.c
> index 76fa02e3835b..ef54fc8093cf 100644
> --- a/fs/hfs/sysdep.c
> +++ b/fs/hfs/sysdep.c
> @@ -13,7 +13,8 @@
> =20
>  /* dentry case-handling: just lowercase everything */
> =20
> -static int hfs_revalidate_dentry(struct dentry *dentry, unsigned int fla=
gs)
> +static int hfs_revalidate_dentry(struct inode *dir, const struct qstr *n=
ame,
> +				 struct dentry *dentry, unsigned int flags)
>  {
>  	struct inode *inode;
>  	int diff;
> diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
> index d68a4e6ac345..fc8ede43afde 100644
> --- a/fs/jfs/namei.c
> +++ b/fs/jfs/namei.c
> @@ -1576,7 +1576,8 @@ static int jfs_ci_compare(const struct dentry *dent=
ry,
>  	return result;
>  }
> =20
> -static int jfs_ci_revalidate(struct dentry *dentry, unsigned int flags)
> +static int jfs_ci_revalidate(struct inode *dir, const struct qstr *name,
> +			     struct dentry *dentry, unsigned int flags)
>  {
>  	/*
>  	 * This is not negative dentry. Always valid.
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index 458519e416fe..5f0f8b95f44c 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -1109,7 +1109,8 @@ struct kernfs_node *kernfs_create_empty_dir(struct =
kernfs_node *parent,
>  	return ERR_PTR(rc);
>  }
> =20
> -static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int fla=
gs)
> +static int kernfs_dop_revalidate(struct inode *dir, const struct qstr *n=
ame,
> +				 struct dentry *dentry, unsigned int flags)
>  {
>  	struct kernfs_node *kn;
>  	struct kernfs_root *root;
> diff --git a/fs/namei.c b/fs/namei.c
> index 9d30c7aa9aa6..77e5d136faaf 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -921,10 +921,11 @@ static bool try_to_unlazy_next(struct nameidata *nd=
, struct dentry *dentry)
>  	return false;
>  }
> =20
> -static inline int d_revalidate(struct dentry *dentry, unsigned int flags=
)
> +static inline int d_revalidate(struct inode *dir, const struct qstr *nam=
e,
> +			       struct dentry *dentry, unsigned int flags)
>  {
>  	if (unlikely(dentry->d_flags & DCACHE_OP_REVALIDATE))
> -		return dentry->d_op->d_revalidate(dentry, flags);
> +		return dentry->d_op->d_revalidate(dir, name, dentry, flags);

I know I sent a R-b for this, but one question:

Suppose we get back a positive result (dentry is still good), but the
name and dentry->d_name no longer match. Do we need to do any special
handling in that case?

>  	else
>  		return 1;
>  }
> @@ -1652,7 +1653,7 @@ static struct dentry *lookup_dcache(const struct qs=
tr *name,
>  {
>  	struct dentry *dentry =3D d_lookup(dir, name);
>  	if (dentry) {
> -		int error =3D d_revalidate(dentry, flags);
> +		int error =3D d_revalidate(dir->d_inode, name, dentry, flags);
>  		if (unlikely(error <=3D 0)) {
>  			if (!error)
>  				d_invalidate(dentry);
> @@ -1737,19 +1738,20 @@ static struct dentry *lookup_fast(struct nameidat=
a *nd)
>  		if (read_seqcount_retry(&parent->d_seq, nd->seq))
>  			return ERR_PTR(-ECHILD);
> =20
> -		status =3D d_revalidate(dentry, nd->flags);
> +		status =3D d_revalidate(nd->inode, &nd->last, dentry, nd->flags);
>  		if (likely(status > 0))
>  			return dentry;
>  		if (!try_to_unlazy_next(nd, dentry))
>  			return ERR_PTR(-ECHILD);
>  		if (status =3D=3D -ECHILD)
>  			/* we'd been told to redo it in non-rcu mode */
> -			status =3D d_revalidate(dentry, nd->flags);
> +			status =3D d_revalidate(nd->inode, &nd->last,
> +					      dentry, nd->flags);
>  	} else {
>  		dentry =3D __d_lookup(parent, &nd->last);
>  		if (unlikely(!dentry))
>  			return NULL;
> -		status =3D d_revalidate(dentry, nd->flags);
> +		status =3D d_revalidate(nd->inode, &nd->last, dentry, nd->flags);
>  	}
>  	if (unlikely(status <=3D 0)) {
>  		if (!status)
> @@ -1777,7 +1779,7 @@ static struct dentry *__lookup_slow(const struct qs=
tr *name,
>  	if (IS_ERR(dentry))
>  		return dentry;
>  	if (unlikely(!d_in_lookup(dentry))) {
> -		int error =3D d_revalidate(dentry, flags);
> +		int error =3D d_revalidate(inode, name, dentry, flags);
>  		if (unlikely(error <=3D 0)) {
>  			if (!error) {
>  				d_invalidate(dentry);
> @@ -3575,7 +3577,7 @@ static struct dentry *lookup_open(struct nameidata =
*nd, struct file *file,
>  		if (d_in_lookup(dentry))
>  			break;
> =20
> -		error =3D d_revalidate(dentry, nd->flags);
> +		error =3D d_revalidate(dir_inode, &nd->last, dentry, nd->flags);
>  		if (likely(error > 0))
>  			break;
>  		if (error)
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index 492cffd9d3d8..9910d9796f4c 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -1814,7 +1814,8 @@ __nfs_lookup_revalidate(struct dentry *dentry, unsi=
gned int flags,
>  	return ret;
>  }
> =20
> -static int nfs_lookup_revalidate(struct dentry *dentry, unsigned int fla=
gs)
> +static int nfs_lookup_revalidate(struct inode *dir, const struct qstr *n=
ame,
> +				 struct dentry *dentry, unsigned int flags)
>  {
>  	return __nfs_lookup_revalidate(dentry, flags, nfs_do_lookup_revalidate)=
;
>  }
> @@ -2025,7 +2026,8 @@ void nfs_d_prune_case_insensitive_aliases(struct in=
ode *inode)
>  EXPORT_SYMBOL_GPL(nfs_d_prune_case_insensitive_aliases);
> =20
>  #if IS_ENABLED(CONFIG_NFS_V4)
> -static int nfs4_lookup_revalidate(struct dentry *, unsigned int);
> +static int nfs4_lookup_revalidate(struct inode *, const struct qstr *,
> +				  struct dentry *, unsigned int);
> =20
>  const struct dentry_operations nfs4_dentry_operations =3D {
>  	.d_revalidate	=3D nfs4_lookup_revalidate,
> @@ -2260,7 +2262,8 @@ nfs4_do_lookup_revalidate(struct inode *dir, struct=
 dentry *dentry,
>  	return nfs_do_lookup_revalidate(dir, dentry, flags);
>  }
> =20
> -static int nfs4_lookup_revalidate(struct dentry *dentry, unsigned int fl=
ags)
> +static int nfs4_lookup_revalidate(struct inode *dir, const struct qstr *=
name,
> +				  struct dentry *dentry, unsigned int flags)
>  {
>  	return __nfs_lookup_revalidate(dentry, flags,
>  			nfs4_do_lookup_revalidate);
> diff --git a/fs/ocfs2/dcache.c b/fs/ocfs2/dcache.c
> index a9b8688aaf30..ecb1ce6301c4 100644
> --- a/fs/ocfs2/dcache.c
> +++ b/fs/ocfs2/dcache.c
> @@ -32,7 +32,8 @@ void ocfs2_dentry_attach_gen(struct dentry *dentry)
>  }
> =20
> =20
> -static int ocfs2_dentry_revalidate(struct dentry *dentry, unsigned int f=
lags)
> +static int ocfs2_dentry_revalidate(struct inode *dir, const struct qstr =
*name,
> +				   struct dentry *dentry, unsigned int flags)
>  {
>  	struct inode *inode;
>  	int ret =3D 0;    /* if all else fails, just return false */
> diff --git a/fs/orangefs/dcache.c b/fs/orangefs/dcache.c
> index 395a00ed8ac7..c32c9a86e8d0 100644
> --- a/fs/orangefs/dcache.c
> +++ b/fs/orangefs/dcache.c
> @@ -92,7 +92,8 @@ static int orangefs_revalidate_lookup(struct dentry *de=
ntry)
>   *
>   * Should return 1 if dentry can still be trusted, else 0.
>   */
> -static int orangefs_d_revalidate(struct dentry *dentry, unsigned int fla=
gs)
> +static int orangefs_d_revalidate(struct inode *dir, const struct qstr *n=
ame,
> +				 struct dentry *dentry, unsigned int flags)
>  {
>  	int ret;
>  	unsigned long time =3D (unsigned long) dentry->d_fsdata;
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index fe511192f83c..86ae6f6da36b 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -91,7 +91,24 @@ static int ovl_revalidate_real(struct dentry *d, unsig=
ned int flags, bool weak)
>  		if (d->d_flags & DCACHE_OP_WEAK_REVALIDATE)
>  			ret =3D  d->d_op->d_weak_revalidate(d, flags);
>  	} else if (d->d_flags & DCACHE_OP_REVALIDATE) {
> -		ret =3D d->d_op->d_revalidate(d, flags);
> +		struct dentry *parent;
> +		struct inode *dir;
> +		struct name_snapshot n;
> +
> +		if (flags & LOOKUP_RCU) {
> +			parent =3D READ_ONCE(d->d_parent);
> +			dir =3D d_inode_rcu(parent);
> +			if (!dir)
> +				return -ECHILD;
> +		} else {
> +			parent =3D dget_parent(d);
> +			dir =3D d_inode(parent);
> +		}
> +		take_dentry_name_snapshot(&n, d);
> +		ret =3D d->d_op->d_revalidate(dir, &n.name, d, flags);
> +		release_dentry_name_snapshot(&n);
> +		if (!(flags & LOOKUP_RCU))
> +			dput(parent);
>  		if (!ret) {
>  			if (!(flags & LOOKUP_RCU))
>  				d_invalidate(d);
> @@ -127,7 +144,8 @@ static int ovl_dentry_revalidate_common(struct dentry=
 *dentry,
>  	return ret;
>  }
> =20
> -static int ovl_dentry_revalidate(struct dentry *dentry, unsigned int fla=
gs)
> +static int ovl_dentry_revalidate(struct inode *dir, const struct qstr *n=
ame,
> +				 struct dentry *dentry, unsigned int flags)
>  {
>  	return ovl_dentry_revalidate_common(dentry, flags, false);
>  }
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 0edf14a9840e..fb5493d0edf0 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2058,7 +2058,8 @@ void pid_update_inode(struct task_struct *task, str=
uct inode *inode)
>   * performed a setuid(), etc.
>   *
>   */
> -static int pid_revalidate(struct dentry *dentry, unsigned int flags)
> +static int pid_revalidate(struct inode *dir, const struct qstr *name,
> +			  struct dentry *dentry, unsigned int flags)
>  {
>  	struct inode *inode;
>  	struct task_struct *task;
> @@ -2191,7 +2192,8 @@ static int dname_to_vma_addr(struct dentry *dentry,
>  	return 0;
>  }
> =20
> -static int map_files_d_revalidate(struct dentry *dentry, unsigned int fl=
ags)
> +static int map_files_d_revalidate(struct inode *dir, const struct qstr *=
name,
> +				  struct dentry *dentry, unsigned int flags)
>  {
>  	unsigned long vm_start, vm_end;
>  	bool exact_vma_exists =3D false;
> diff --git a/fs/proc/fd.c b/fs/proc/fd.c
> index 24baf23e864f..37aa778d1af7 100644
> --- a/fs/proc/fd.c
> +++ b/fs/proc/fd.c
> @@ -140,7 +140,8 @@ static void tid_fd_update_inode(struct task_struct *t=
ask, struct inode *inode,
>  	security_task_to_inode(task, inode);
>  }
> =20
> -static int tid_fd_revalidate(struct dentry *dentry, unsigned int flags)
> +static int tid_fd_revalidate(struct inode *dir, const struct qstr *name,
> +			     struct dentry *dentry, unsigned int flags)
>  {
>  	struct task_struct *task;
>  	struct inode *inode;
> diff --git a/fs/proc/generic.c b/fs/proc/generic.c
> index dbe82cf23ee4..8ec90826a49e 100644
> --- a/fs/proc/generic.c
> +++ b/fs/proc/generic.c
> @@ -216,7 +216,8 @@ void proc_free_inum(unsigned int inum)
>  	ida_free(&proc_inum_ida, inum - PROC_DYNAMIC_FIRST);
>  }
> =20
> -static int proc_misc_d_revalidate(struct dentry *dentry, unsigned int fl=
ags)
> +static int proc_misc_d_revalidate(struct inode *dir, const struct qstr *=
name,
> +				  struct dentry *dentry, unsigned int flags)
>  {
>  	if (flags & LOOKUP_RCU)
>  		return -ECHILD;
> @@ -343,7 +344,8 @@ static const struct file_operations proc_dir_operatio=
ns =3D {
>  	.iterate_shared		=3D proc_readdir,
>  };
> =20
> -static int proc_net_d_revalidate(struct dentry *dentry, unsigned int fla=
gs)
> +static int proc_net_d_revalidate(struct inode *dir, const struct qstr *n=
ame,
> +				 struct dentry *dentry, unsigned int flags)
>  {
>  	return 0;
>  }
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index 27a283d85a6e..cc9d74a06ff0 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -884,7 +884,8 @@ static const struct inode_operations proc_sys_dir_ope=
rations =3D {
>  	.getattr	=3D proc_sys_getattr,
>  };
> =20
> -static int proc_sys_revalidate(struct dentry *dentry, unsigned int flags=
)
> +static int proc_sys_revalidate(struct inode *dir, const struct qstr *nam=
e,
> +			       struct dentry *dentry, unsigned int flags)
>  {
>  	if (flags & LOOKUP_RCU)
>  		return -ECHILD;
> diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
> index 864b194dbaa0..8c5d44ee91ed 100644
> --- a/fs/smb/client/dir.c
> +++ b/fs/smb/client/dir.c
> @@ -737,7 +737,8 @@ cifs_lookup(struct inode *parent_dir_inode, struct de=
ntry *direntry,
>  }
> =20
>  static int
> -cifs_d_revalidate(struct dentry *direntry, unsigned int flags)
> +cifs_d_revalidate(struct inode *dir, const struct qstr *name,
> +		  struct dentry *direntry, unsigned int flags)
>  {
>  	struct inode *inode;
>  	int rc;
> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index cfc614c638da..53214499e384 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -457,7 +457,8 @@ static void tracefs_d_release(struct dentry *dentry)
>  		eventfs_d_release(dentry);
>  }
> =20
> -static int tracefs_d_revalidate(struct dentry *dentry, unsigned int flag=
s)
> +static int tracefs_d_revalidate(struct inode *inode, const struct qstr *=
name,
> +				struct dentry *dentry, unsigned int flags)
>  {
>  	struct eventfs_inode *ei =3D dentry->d_fsdata;
> =20
> diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
> index 5f1a14d5b927..a859ac9b74ba 100644
> --- a/fs/vboxsf/dir.c
> +++ b/fs/vboxsf/dir.c
> @@ -192,7 +192,8 @@ const struct file_operations vboxsf_dir_fops =3D {
>   * This is called during name resolution/lookup to check if the @dentry =
in
>   * the cache is still valid. the job is handled by vboxsf_inode_revalida=
te.
>   */
> -static int vboxsf_dentry_revalidate(struct dentry *dentry, unsigned int =
flags)
> +static int vboxsf_dentry_revalidate(struct inode *dir, const struct qstr=
 *name,
> +				    struct dentry *dentry, unsigned int flags)
>  {
>  	if (flags & LOOKUP_RCU)
>  		return -ECHILD;
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index 8bc567a35718..4a6bdadf2f29 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -144,7 +144,8 @@ enum d_real_type {
>  };
> =20
>  struct dentry_operations {
> -	int (*d_revalidate)(struct dentry *, unsigned int);
> +	int (*d_revalidate)(struct inode *, const struct qstr *,
> +			    struct dentry *, unsigned int);
>  	int (*d_weak_revalidate)(struct dentry *, unsigned int);
>  	int (*d_hash)(const struct dentry *, struct qstr *);
>  	int (*d_compare)(const struct dentry *,
> diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
> index 772f822dc6b8..18855cb44b1c 100644
> --- a/include/linux/fscrypt.h
> +++ b/include/linux/fscrypt.h
> @@ -192,7 +192,8 @@ struct fscrypt_operations {
>  					     unsigned int *num_devs);
>  };
> =20
> -int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags);
> +int fscrypt_d_revalidate(struct inode *dir, const struct qstr *name,
> +			 struct dentry *dentry, unsigned int flags);
> =20
>  static inline struct fscrypt_inode_info *
>  fscrypt_get_inode_info(const struct inode *inode)
> @@ -711,8 +712,8 @@ static inline u64 fscrypt_fname_siphash(const struct =
inode *dir,
>  	return 0;
>  }
> =20
> -static inline int fscrypt_d_revalidate(struct dentry *dentry,
> -				       unsigned int flags)
> +static inline int fscrypt_d_revalidate(struct inode *dir, const struct q=
str *name,
> +				       struct dentry *dentry, unsigned int flags)
>  {
>  	return 1;
>  }

--=20
Jeff Layton <jlayton@kernel.org>

