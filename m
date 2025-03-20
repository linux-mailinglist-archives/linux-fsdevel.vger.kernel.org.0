Return-Path: <linux-fsdevel+bounces-44542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1A3A6A3FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 11:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DB39189D77C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 10:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB499224254;
	Thu, 20 Mar 2025 10:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHLdbn9e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D885209F4E;
	Thu, 20 Mar 2025 10:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742467544; cv=none; b=gRXFEyomB1WsZipb2pndNq0KGiawBMKcBm1Xtf3Kmc1Ize8lmrheEuiMJeSONTgplENEFhaMX/HEd6tkNH0slz0Kp1OYnmz/6T22d5Za1MBIIgyrFEtkS6LqkkIpTJ7bveoddRJHauemMeapvXzMosYHkR7aJfl2K496Ir1yDlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742467544; c=relaxed/simple;
	bh=uhTRmSvju8WYMAnf/mgl7BiwduH4AAy7uMFg1eLjCcM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Da6FT/H/6VjGo+Kjjf+IddxU86thCSDilStaizAruP6vxV3wgdcp4rsk7LV5UMo1EsUQC4hp2cih0uDs7mczTd7fnZn1BYk854nNuuqNlPGJEBB2EsjEVkR/B+ML4S9ya887y7JFlFdx+eDka03SCz8ElgdeDbdl7/vQtsouHOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHLdbn9e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B7BC4CEDD;
	Thu, 20 Mar 2025 10:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742467543;
	bh=uhTRmSvju8WYMAnf/mgl7BiwduH4AAy7uMFg1eLjCcM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=BHLdbn9elunW1tqHdj5yu07PAsDPi0NSjBWvtgfleMIXS1Qm4yn+p5xrqT7FoYmWS
	 gfGLos0eCPElmvgKm1dl9boj11cCRdAhobSG44QBO99TsaO5O8QM0hTPgpq127B2MT
	 /gEpcjjP073hC7J9n0q8WF6+bkzeiZm3dPL0wIL5IqMhQfnnFYYCjbE9/7oa6kPnjG
	 K08cKi8vRCXMDeD1W4QvllqNlwr5IFk71mKj+9mCC8WF2k1fI39nC+RIabri+dlBoI
	 XUJplREFNUSBM6dPMhGPcUTLy0dTaouH44uwxfSQms06XkZ1rUDm7ml44qCDgHwoXF
	 W5UkJFCmNAHtQ==
Message-ID: <3fb9594115c3df18120dedec1091f18be5ea22a4.camel@kernel.org>
Subject: Re: [PATCH 5/6] Use try_lookup_noperm() instead of
 d_hash_and_lookup() outside of VFS
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neil@brown.name>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner	 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, David
 Howells <dhowells@redhat.com>,  Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Date: Thu, 20 Mar 2025 06:45:41 -0400
In-Reply-To: <20250319031545.2999807-6-neil@brown.name>
References: <20250319031545.2999807-1-neil@brown.name>
	 <20250319031545.2999807-6-neil@brown.name>
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
> try_lookup_noperm() and d_hash_and_lookup() are nearly identical.  The
> former does some validation of the name where the latter doesn't.
> Outside of the VFS that validation is likely valuable, and having only
> one exported function for this task is certainly a good idea.
>=20
> So make d_hash_and_lookup() local to VFS files and change all other
> callers to try_lookup_noperm().  Note that the arguments are swapped.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  Documentation/filesystems/porting.rst | 11 +++++++++++
>  fs/dcache.c                           |  1 -
>  fs/efivarfs/super.c                   | 14 ++++----------
>  fs/internal.h                         |  1 +
>  fs/proc/base.c                        |  2 +-
>  fs/smb/client/readdir.c               |  3 ++-
>  fs/xfs/scrub/orphanage.c              |  4 ++--
>  include/linux/dcache.h                |  1 -
>  net/sunrpc/rpc_pipe.c                 | 12 ++++++------
>  security/selinux/selinuxfs.c          |  4 ++--
>  10 files changed, 29 insertions(+), 24 deletions(-)
>=20
> diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesy=
stems/porting.rst
> index df9516cd82e0..626f094787e8 100644
> --- a/Documentation/filesystems/porting.rst
> +++ b/Documentation/filesystems/porting.rst
> @@ -1225,3 +1225,14 @@ checked that the caller has 'X' permission on the =
parent.  They must
>  ONLY be used internally by a filesystem on itself when it knows that
>  permissions are irrelevant or in a context where permission checks have
>  already been performed such as after vfs_path_parent_lookup()
> +
> +---
> +
> +** mandatory**
> +
> +d_hash_and_lookup() is no longer exported or available outside the VFS.
> +Use try_lookup_noperm() instead.  This adds name validation and takes
> +arguments in the opposite order but is otherwise identical.
> +
> +Using try_lookup_noperm() will require linux/namei.h to be included.
> +
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 726a5be2747b..17f8e0b7f04f 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -2395,7 +2395,6 @@ struct dentry *d_hash_and_lookup(struct dentry *dir=
, struct qstr *name)
>  	}
>  	return d_lookup(dir, name);
>  }
> -EXPORT_SYMBOL(d_hash_and_lookup);
> =20
>  /*
>   * When a file is deleted, we have two options:
> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> index 09fcf731e65d..867cd6e0fbad 100644
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -204,7 +204,6 @@ bool efivarfs_variable_is_present(efi_char16_t *varia=
ble_name,
>  	char *name =3D efivar_get_utf8name(variable_name, vendor);
>  	struct super_block *sb =3D data;
>  	struct dentry *dentry;
> -	struct qstr qstr;
> =20
>  	if (!name)
>  		/*
> @@ -217,9 +216,7 @@ bool efivarfs_variable_is_present(efi_char16_t *varia=
ble_name,
>  		 */
>  		return true;
> =20
> -	qstr.name =3D name;
> -	qstr.len =3D strlen(name);
> -	dentry =3D d_hash_and_lookup(sb->s_root, &qstr);
> +	dentry =3D try_lookup_noperm(&QSTR(name), sb->s_root);
>  	kfree(name);
>  	if (!IS_ERR_OR_NULL(dentry))
>  		dput(dentry);
> @@ -402,8 +399,8 @@ static bool efivarfs_actor(struct dir_context *ctx, c=
onst char *name, int len,
>  {
>  	unsigned long size;
>  	struct efivarfs_ctx *ectx =3D container_of(ctx, struct efivarfs_ctx, ct=
x);
> -	struct qstr qstr =3D { .name =3D name, .len =3D len };
> -	struct dentry *dentry =3D d_hash_and_lookup(ectx->sb->s_root, &qstr);
> +	struct dentry *dentry =3D try_lookup_noperm(QSTR_LEN(name, len),
> +						  ectx->sb->s_root);
>  	struct inode *inode;
>  	struct efivar_entry *entry;
>  	int err;
> @@ -439,7 +436,6 @@ static int efivarfs_check_missing(efi_char16_t *name1=
6, efi_guid_t vendor,
>  	char *name;
>  	struct super_block *sb =3D data;
>  	struct dentry *dentry;
> -	struct qstr qstr;
>  	int err;
> =20
>  	if (guid_equal(&vendor, &LINUX_EFI_RANDOM_SEED_TABLE_GUID))
> @@ -449,9 +445,7 @@ static int efivarfs_check_missing(efi_char16_t *name1=
6, efi_guid_t vendor,
>  	if (!name)
>  		return -ENOMEM;
> =20
> -	qstr.name =3D name;
> -	qstr.len =3D strlen(name);
> -	dentry =3D d_hash_and_lookup(sb->s_root, &qstr);
> +	dentry =3D try_lookup_noperm(&QSTR(name), sb->s_root);
>  	if (IS_ERR(dentry)) {
>  		err =3D PTR_ERR(dentry);
>  		goto out;
> diff --git a/fs/internal.h b/fs/internal.h
> index e7f02ae1e098..c21534a23196 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -66,6 +66,7 @@ int do_linkat(int olddfd, struct filename *old, int new=
dfd,
>  int vfs_tmpfile(struct mnt_idmap *idmap,
>  		const struct path *parentpath,
>  		struct file *file, umode_t mode);
> +struct dentry *d_hash_and_lookup(struct dentry *, struct qstr *);
> =20
>  /*
>   * namespace.c
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index cd89e956c322..7d36c7567c31 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2124,7 +2124,7 @@ bool proc_fill_cache(struct file *file, struct dir_=
context *ctx,
>  	unsigned type =3D DT_UNKNOWN;
>  	ino_t ino =3D 1;
> =20
> -	child =3D d_hash_and_lookup(dir, &qname);
> +	child =3D try_lookup_noperm(&qname, dir);
>  	if (!child) {
>  		DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
>  		child =3D d_alloc_parallel(dir, &qname, &wq);
> diff --git a/fs/smb/client/readdir.c b/fs/smb/client/readdir.c
> index 50f96259d9ad..7329ec532bcf 100644
> --- a/fs/smb/client/readdir.c
> +++ b/fs/smb/client/readdir.c
> @@ -9,6 +9,7 @@
>   *
>   */
>  #include <linux/fs.h>
> +#include <linux/namei.h>
>  #include <linux/pagemap.h>
>  #include <linux/slab.h>
>  #include <linux/stat.h>
> @@ -78,7 +79,7 @@ cifs_prime_dcache(struct dentry *parent, struct qstr *n=
ame,
> =20
>  	cifs_dbg(FYI, "%s: for %s\n", __func__, name->name);
> =20
> -	dentry =3D d_hash_and_lookup(parent, name);
> +	dentry =3D try_lookup_noperm(name, parent);
>  	if (!dentry) {
>  		/*
>  		 * If we know that the inode will need to be revalidated
> diff --git a/fs/xfs/scrub/orphanage.c b/fs/xfs/scrub/orphanage.c
> index 987af5b2bb82..f42ffad5a7b9 100644
> --- a/fs/xfs/scrub/orphanage.c
> +++ b/fs/xfs/scrub/orphanage.c
> @@ -444,7 +444,7 @@ xrep_adoption_check_dcache(
>  	if (!d_orphanage)
>  		return 0;
> =20
> -	d_child =3D d_hash_and_lookup(d_orphanage, &qname);
> +	d_child =3D try_lookup_noperm(&qname, d_orphanage);
>  	if (d_child) {
>  		trace_xrep_adoption_check_child(sc->mp, d_child);
> =20
> @@ -481,7 +481,7 @@ xrep_adoption_zap_dcache(
>  	if (!d_orphanage)
>  		return;
> =20
> -	d_child =3D d_hash_and_lookup(d_orphanage, &qname);
> +	d_child =3D try_lookup_noperm(&qname, d_orphanage);
>  	while (d_child !=3D NULL) {
>  		trace_xrep_adoption_invalidate_child(sc->mp, d_child);
> =20
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index 1f01f4e734c5..cf37ae54955d 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -288,7 +288,6 @@ extern void d_exchange(struct dentry *, struct dentry=
 *);
>  extern struct dentry *d_ancestor(struct dentry *, struct dentry *);
> =20
>  extern struct dentry *d_lookup(const struct dentry *, const struct qstr =
*);
> -extern struct dentry *d_hash_and_lookup(struct dentry *, struct qstr *);
> =20
>  static inline unsigned d_count(const struct dentry *dentry)
>  {
> diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
> index eadc00410ebc..98f78cd55905 100644
> --- a/net/sunrpc/rpc_pipe.c
> +++ b/net/sunrpc/rpc_pipe.c
> @@ -631,7 +631,7 @@ static struct dentry *__rpc_lookup_create_exclusive(s=
truct dentry *parent,
>  					  const char *name)
>  {
>  	struct qstr q =3D QSTR(name);
> -	struct dentry *dentry =3D d_hash_and_lookup(parent, &q);
> +	struct dentry *dentry =3D try_lookup_noperm(&q, parent);
>  	if (!dentry) {
>  		dentry =3D d_alloc(parent, &q);
>  		if (!dentry)
> @@ -658,7 +658,7 @@ static void __rpc_depopulate(struct dentry *parent,
>  	for (i =3D start; i < eof; i++) {
>  		name.name =3D files[i].name;
>  		name.len =3D strlen(files[i].name);
> -		dentry =3D d_hash_and_lookup(parent, &name);
> +		dentry =3D try_lookup_noperm(&name, parent);
> =20
>  		if (dentry =3D=3D NULL)
>  			continue;
> @@ -1190,7 +1190,7 @@ static const struct rpc_filelist files[] =3D {
>  struct dentry *rpc_d_lookup_sb(const struct super_block *sb,
>  			       const unsigned char *dir_name)
>  {
> -	return d_hash_and_lookup(sb->s_root, &QSTR(dir_name));
> +	return try_lookup_noperm(&QSTR(dir_name), sb->s_root);
>  }
>  EXPORT_SYMBOL_GPL(rpc_d_lookup_sb);
> =20
> @@ -1301,7 +1301,7 @@ rpc_gssd_dummy_populate(struct dentry *root, struct=
 rpc_pipe *pipe_data)
>  	struct dentry *pipe_dentry =3D NULL;
> =20
>  	/* We should never get this far if "gssd" doesn't exist */
> -	gssd_dentry =3D d_hash_and_lookup(root, &QSTR(files[RPCAUTH_gssd].name)=
);
> +	gssd_dentry =3D try_lookup_noperm(&QSTR(files[RPCAUTH_gssd].name), root=
);
>  	if (!gssd_dentry)
>  		return ERR_PTR(-ENOENT);
> =20
> @@ -1311,8 +1311,8 @@ rpc_gssd_dummy_populate(struct dentry *root, struct=
 rpc_pipe *pipe_data)
>  		goto out;
>  	}
> =20
> -	clnt_dentry =3D d_hash_and_lookup(gssd_dentry,
> -					&QSTR(gssd_dummy_clnt_dir[0].name));
> +	clnt_dentry =3D try_lookup_noperm(&QSTR(gssd_dummy_clnt_dir[0].name),
> +					  gssd_dentry);
>  	if (!clnt_dentry) {
>  		__rpc_depopulate(gssd_dentry, gssd_dummy_clnt_dir, 0, 1);
>  		pipe_dentry =3D ERR_PTR(-ENOENT);
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 47480eb2189b..e67a8ce4b64c 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -2158,8 +2158,8 @@ static int __init init_sel_fs(void)
>  		return err;
>  	}
> =20
> -	selinux_null.dentry =3D d_hash_and_lookup(selinux_null.mnt->mnt_root,
> -						&null_name);
> +	selinux_null.dentry =3D try_lookup_noperm(&null_name,
> +						  selinux_null.mnt->mnt_root);
>  	if (IS_ERR(selinux_null.dentry)) {
>  		pr_err("selinuxfs:  could not lookup null!\n");
>  		err =3D PTR_ERR(selinux_null.dentry);

Reviewed-by: Jeff Layton <jlayton@kernel.org>

