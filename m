Return-Path: <linux-fsdevel+bounces-10348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBFA84A797
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 22:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8353328ED88
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 21:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2BD482FE;
	Mon,  5 Feb 2024 20:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Cs+5zrTf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rCYEbPxn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Cs+5zrTf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rCYEbPxn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564D0127B46;
	Mon,  5 Feb 2024 19:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707163200; cv=none; b=dbO7sQ3lAOLEBKbeFVQ+2CL7L4s5KanJvBQIUZU7OAS8WJoLyYYYmPdsAw9ypOS8PK6hE4iX1q/SRg0yzL1CrXWtzlIcoFzJjtJJV1UOKcxCyD1x7tjBNvcSO0HrrIFBUUcyzBlohVmznmPmh7KJHoaMTgzGhh600bLqSEke6QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707163200; c=relaxed/simple;
	bh=a1KKAzw6kExkdI+UlXdfVkb/SFcxRBlq2zYmLJPDg64=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=O0Uj3U4/pqaaVF+MiFgrdjT2IeiW3CjCMk6iYMvnJi/gTqckgfsU4/vH8X1om1mwx3twN7fiW9pReSyU1an9R3pDTi0LcP/TQ9hbXpvazOslMkpHsk76E7lxgdCL8iIPKtChdYmVbbpqr7yORJ0Hk+fVZr8QiTBoHvCaOiLjZHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Cs+5zrTf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rCYEbPxn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Cs+5zrTf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rCYEbPxn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5F3F0220CF;
	Mon,  5 Feb 2024 19:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707163196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5emmKEB/db2diNQgCaTGPLO2lv1hefgy9617c2n1a6Y=;
	b=Cs+5zrTf47S5tFQrg+3ztQG49yZItZ/e7RGbGxjrpHE7XhBr+e81yytssxWojLONGKOL4J
	oXxxSsuiuk/vCHupX7LsGK2/Hy1MR2Z/J4hQIiDq6pIKtC1dmzvgU5mfcZ+PCeNG/tobrg
	6/52enKKIgxn8eShhjzjKmIUdFuz6L4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707163196;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5emmKEB/db2diNQgCaTGPLO2lv1hefgy9617c2n1a6Y=;
	b=rCYEbPxnvGjs9gNVtGnQrXlRpgGLI5qbgG3/38wtEgkY9YjyuC3Ph0hE1hN/CJv0hVLwIc
	FaoQ7JQmDXWhm1Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707163196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5emmKEB/db2diNQgCaTGPLO2lv1hefgy9617c2n1a6Y=;
	b=Cs+5zrTf47S5tFQrg+3ztQG49yZItZ/e7RGbGxjrpHE7XhBr+e81yytssxWojLONGKOL4J
	oXxxSsuiuk/vCHupX7LsGK2/Hy1MR2Z/J4hQIiDq6pIKtC1dmzvgU5mfcZ+PCeNG/tobrg
	6/52enKKIgxn8eShhjzjKmIUdFuz6L4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707163196;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5emmKEB/db2diNQgCaTGPLO2lv1hefgy9617c2n1a6Y=;
	b=rCYEbPxnvGjs9gNVtGnQrXlRpgGLI5qbgG3/38wtEgkY9YjyuC3Ph0hE1hN/CJv0hVLwIc
	FaoQ7JQmDXWhm1Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 40144136F5;
	Mon,  5 Feb 2024 19:59:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id b/69OTc+wWXiQgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 05 Feb 2024 19:59:51 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <kolga@netapp.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
 Ondrej =?utf-8?q?Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>,
 "Zdenek Pytela" <zpytela@redhat.com>, "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCH] filelock: don't do security checks on nfsd setlease calls
In-reply-to: <20240205-bz2248830-v1-1-d0ec0daecba1@kernel.org>
References: <20240205-bz2248830-v1-1-d0ec0daecba1@kernel.org>
Date: Tue, 06 Feb 2024 06:59:49 +1100
Message-id: <170716318935.13976.13465352731929804157@noble.neil.brown.name>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Cs+5zrTf;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rCYEbPxn
X-Spamd-Result: default: False [-4.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,netapp.com,talpey.com,vger.kernel.org,gmail.com,redhat.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5F3F0220CF
X-Spam-Level: 
X-Spam-Score: -4.31
X-Spam-Flag: NO

On Mon, 05 Feb 2024, Jeff Layton wrote:
> Zdenek reported seeing some AVC denials due to nfsd trying to set
> delegations:
>=20
>     type=3DAVC msg=3Daudit(09.11.2023 09:03:46.411:496) : avc:  denied  { l=
ease } for  pid=3D5127 comm=3Drpc.nfsd capability=3Dlease  scontext=3Dsystem_=
u:system_r:nfsd_t:s0 tcontext=3Dsystem_u:system_r:nfsd_t:s0 tclass=3Dcapabili=
ty permissive=3D0
>=20
> When setting delegations on behalf of nfsd, we don't want to do all of
> the normal capabilty and LSM checks. nfsd is a kernel thread and runs
> with CAP_LEASE set, so the uid checks end up being a no-op in most cases
> anyway.
>=20
> Some nfsd functions can end up running in normal process context when
> tearing down the server. At that point, the CAP_LEASE check can fail and
> cause the client to not tear down delegations when expected.
>=20
> Also, the way the per-fs ->setlease handlers work today is a little
> convoluted. The non-trivial ones are wrappers around generic_setlease,
> so when they fail due to permission problems they usually they end up
> doing a little extra work only to determine that they can't set the
> lease anyway. It would be more efficient to do those checks earlier.
>=20
> Transplant the permission checking from generic_setlease to
> vfs_setlease, which will make the permission checking happen earlier on
> filesystems that have a ->setlease operation. Add a new kernel_setlease
> function that bypasses these checks, and switch nfsd to use that instead
> of vfs_setlease.
>=20
> There is one behavioral change here: prior this patch the
> setlease_notifier would fire even if the lease attempt was going to fail
> the security checks later. With this change, it doesn't fire until the
> caller has passed them. I think this is a desirable change overall. nfsd
> is the only user of the setlease_notifier and it doesn't benefit from
> being notified about failed attempts.
>=20
> Cc: Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>
> Reported-by: Zdenek Pytela <zpytela@redhat.com>
> Closes: https://bugzilla.redhat.com/show_bug.cgi?id=3D2248830
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: NeilBrown <neilb@suse.de>

It definitely nice to move all the security and sanity check early.
This patch allows a minor clean-up in cifs which could possibly be
included:
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 2a4a4e3a8751..0f142d1ec64f 100644

--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1094,9 +1094,6 @@ cifs_setlease(struct file *file, int arg, struct file_l=
ock **lease, void **priv)
 	struct inode *inode =3D file_inode(file);
 	struct cifsFileInfo *cfile =3D file->private_data;
=20
-	if (!(S_ISREG(inode->i_mode)))
-		return -EINVAL;
-
 	/* Check if file is oplocked if this is request for new lease */
 	if (arg =3D=3D F_UNLCK ||
 	    ((arg =3D=3D F_RDLCK) && CIFS_CACHE_READ(CIFS_I(inode))) ||


as ->setlease() is now never called for non-ISREG files.

NeilBrown


> ---
> This patch is based on top of a merge of Christian's vfs.file branch
> (which has the file_lock/lease split). There is a small merge confict
> with Chuck's nfsd-next patch, but it should be fairly simple to resolve.
> ---
>  fs/locks.c               | 43 +++++++++++++++++++++++++------------------
>  fs/nfsd/nfs4layouts.c    |  5 ++---
>  fs/nfsd/nfs4state.c      |  8 ++++----
>  include/linux/filelock.h |  7 +++++++
>  4 files changed, 38 insertions(+), 25 deletions(-)
>=20
> diff --git a/fs/locks.c b/fs/locks.c
> index 33c7f4a8c729..26d52ef5314a 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -1925,18 +1925,6 @@ static int generic_delete_lease(struct file *filp, v=
oid *owner)
>  int generic_setlease(struct file *filp, int arg, struct file_lease **flp,
>  			void **priv)
>  {
> -	struct inode *inode =3D file_inode(filp);
> -	vfsuid_t vfsuid =3D i_uid_into_vfsuid(file_mnt_idmap(filp), inode);
> -	int error;
> -
> -	if ((!vfsuid_eq_kuid(vfsuid, current_fsuid())) && !capable(CAP_LEASE))
> -		return -EACCES;
> -	if (!S_ISREG(inode->i_mode))
> -		return -EINVAL;
> -	error =3D security_file_lock(filp, arg);
> -	if (error)
> -		return error;
> -
>  	switch (arg) {
>  	case F_UNLCK:
>  		return generic_delete_lease(filp, *priv);
> @@ -1987,6 +1975,19 @@ void lease_unregister_notifier(struct notifier_block=
 *nb)
>  }
>  EXPORT_SYMBOL_GPL(lease_unregister_notifier);
> =20
> +
> +int
> +kernel_setlease(struct file *filp, int arg, struct file_lease **lease, voi=
d **priv)
> +{
> +	if (lease)
> +		setlease_notifier(arg, *lease);
> +	if (filp->f_op->setlease)
> +		return filp->f_op->setlease(filp, arg, lease, priv);
> +	else
> +		return generic_setlease(filp, arg, lease, priv);
> +}
> +EXPORT_SYMBOL_GPL(kernel_setlease);
> +
>  /**
>   * vfs_setlease        -       sets a lease on an open file
>   * @filp:	file pointer
> @@ -2007,12 +2008,18 @@ EXPORT_SYMBOL_GPL(lease_unregister_notifier);
>  int
>  vfs_setlease(struct file *filp, int arg, struct file_lease **lease, void *=
*priv)
>  {
> -	if (lease)
> -		setlease_notifier(arg, *lease);
> -	if (filp->f_op->setlease)
> -		return filp->f_op->setlease(filp, arg, lease, priv);
> -	else
> -		return generic_setlease(filp, arg, lease, priv);
> +	struct inode *inode =3D file_inode(filp);
> +	vfsuid_t vfsuid =3D i_uid_into_vfsuid(file_mnt_idmap(filp), inode);
> +	int error;
> +
> +	if ((!vfsuid_eq_kuid(vfsuid, current_fsuid())) && !capable(CAP_LEASE))
> +		return -EACCES;
> +	if (!S_ISREG(inode->i_mode))
> +		return -EINVAL;
> +	error =3D security_file_lock(filp, arg);
> +	if (error)
> +		return error;
> +	return kernel_setlease(filp, arg, lease, priv);
>  }
>  EXPORT_SYMBOL_GPL(vfs_setlease);
> =20
> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
> index 4fa21b74a981..4c0d00bdfbb1 100644
> --- a/fs/nfsd/nfs4layouts.c
> +++ b/fs/nfsd/nfs4layouts.c
> @@ -170,7 +170,7 @@ nfsd4_free_layout_stateid(struct nfs4_stid *stid)
>  	spin_unlock(&fp->fi_lock);
> =20
>  	if (!nfsd4_layout_ops[ls->ls_layout_type]->disable_recalls)
> -		vfs_setlease(ls->ls_file->nf_file, F_UNLCK, NULL, (void **)&ls);
> +		kernel_setlease(ls->ls_file->nf_file, F_UNLCK, NULL, (void **)&ls);
>  	nfsd_file_put(ls->ls_file);
> =20
>  	if (ls->ls_recalled)
> @@ -199,8 +199,7 @@ nfsd4_layout_setlease(struct nfs4_layout_stateid *ls)
>  	fl->c.flc_pid =3D current->tgid;
>  	fl->c.flc_file =3D ls->ls_file->nf_file;
> =20
> -	status =3D vfs_setlease(fl->c.flc_file, fl->c.flc_type, &fl,
> -			      NULL);
> +	status =3D kernel_setlease(fl->c.flc_file, fl->c.flc_type, &fl, NULL);
>  	if (status) {
>  		locks_free_lease(fl);
>  		return status;
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index b2c8efb5f793..6d52ecba8e9c 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1249,7 +1249,7 @@ static void nfs4_unlock_deleg_lease(struct nfs4_deleg=
ation *dp)
> =20
>  	WARN_ON_ONCE(!fp->fi_delegees);
> =20
> -	vfs_setlease(nf->nf_file, F_UNLCK, NULL, (void **)&dp);
> +	kernel_setlease(nf->nf_file, F_UNLCK, NULL, (void **)&dp);
>  	put_deleg_file(fp);
>  }
> =20
> @@ -5532,8 +5532,8 @@ nfs4_set_delegation(struct nfsd4_open *open, struct n=
fs4_ol_stateid *stp,
>  	if (!fl)
>  		goto out_clnt_odstate;
> =20
> -	status =3D vfs_setlease(fp->fi_deleg_file->nf_file,
> -			      fl->c.flc_type, &fl, NULL);
> +	status =3D kernel_setlease(fp->fi_deleg_file->nf_file,
> +				      fl->c.flc_type, &fl, NULL);
>  	if (fl)
>  		locks_free_lease(fl);
>  	if (status)
> @@ -5571,7 +5571,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct n=
fs4_ol_stateid *stp,
> =20
>  	return dp;
>  out_unlock:
> -	vfs_setlease(fp->fi_deleg_file->nf_file, F_UNLCK, NULL, (void **)&dp);
> +	kernel_setlease(fp->fi_deleg_file->nf_file, F_UNLCK, NULL, (void **)&dp);
>  out_clnt_odstate:
>  	put_clnt_odstate(dp->dl_clnt_odstate);
>  	nfs4_put_stid(&dp->dl_stid);
> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
> index 4a5ad26962c1..cd6c1c291de9 100644
> --- a/include/linux/filelock.h
> +++ b/include/linux/filelock.h
> @@ -208,6 +208,7 @@ struct file_lease *locks_alloc_lease(void);
>  int __break_lease(struct inode *inode, unsigned int flags, unsigned int ty=
pe);
>  void lease_get_mtime(struct inode *, struct timespec64 *time);
>  int generic_setlease(struct file *, int, struct file_lease **, void **priv=
);
> +int kernel_setlease(struct file *, int, struct file_lease **, void **);
>  int vfs_setlease(struct file *, int, struct file_lease **, void **);
>  int lease_modify(struct file_lease *, int, struct list_head *);
> =20
> @@ -357,6 +358,12 @@ static inline int generic_setlease(struct file *filp, =
int arg,
>  	return -EINVAL;
>  }
> =20
> +static inline int kernel_setlease(struct file *filp, int arg,
> +			       struct file_lease **lease, void **priv)
> +{
> +	return -EINVAL;
> +}
> +
>  static inline int vfs_setlease(struct file *filp, int arg,
>  			       struct file_lease **lease, void **priv)
>  {
>=20
> ---
> base-commit: 1499e59af376949b062cdc039257f811f6c1697f
> change-id: 20240202-bz2248830-03e6c7506705
>=20
> Best regards,
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20
>=20
>=20


