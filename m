Return-Path: <linux-fsdevel+bounces-47222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F335A9AC64
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 13:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B8557B3436
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 11:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969E3227581;
	Thu, 24 Apr 2025 11:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpMEaFQg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6511226CEB;
	Thu, 24 Apr 2025 11:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745495330; cv=none; b=pgs1Iy5O6EAEQ7Thanom3dqxO8PBBIc6JWJJB+yYKlpwQSYnMC4gGWrG5LSyJWoZ+e7LVtYZrBtaVlQrQVpJw6Kg1HHs26pvkc2/bUzaMkCks1JXvJ9bYrSPkGHS8rOSS29uOIFCLI5aMv6mXnBuBEoZzr8v6UFXIRXDRfcugfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745495330; c=relaxed/simple;
	bh=tka2nkFt+YTLCXeIlbWv0s0FI0+bvvfgH7BhTLKbgbc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j8NLuvH5tCKHHb9HWMNdbDdGfXQSvnyGqV4ELkA0+crREmSupZc2olQa89QsYVBIZxETTrFRbViriaNDYoVB0sU/kZSeEdUlXW/0h8fXWTkP6rcvpIRLgl37+VnaXRotpn5RQEdT4H31tZfrj62UIz/X10u75b/LKU182n6moB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpMEaFQg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A79C4CEE3;
	Thu, 24 Apr 2025 11:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745495329;
	bh=tka2nkFt+YTLCXeIlbWv0s0FI0+bvvfgH7BhTLKbgbc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=OpMEaFQgrsCFmilT9N52pKTAWjYXGjAEdUw/dslCJEHMH1dLN7+PoNQ+/AQKYGUy6
	 f06S3drR2+BXF+BR4zBZN2QeoihIq54646IotI75oaD1OMc9Oh5bJgoQcPV8QkHS84
	 Cp84P+Sqyp6M7LLc7LxRVtAl/GDvlVrz3kOtJKbqs41XtFmubfZ0Qj9uRYMx2W6pJB
	 HFG+3+1EvQ4x3QSOZIGQo93bCesS7N1Cl7dJAMcpotmh+aXP6mUNVNt4VumEkYOirJ
	 e2MSE5Ym5GJrTR/GbPdfvaKuy1D70lnu+Rapw93eKq28e/97AEuU37rNMYOQPPDGXG
	 QGDu85Yezj58w==
Message-ID: <b32b6fe99057cea52d0f0998929ed3aa38362217.camel@kernel.org>
Subject: Re: [RFC][PATCH] saner calling conventions for ->d_automount()
From: Jeff Layton <jlayton@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>, David Howells
 <dhowells@redhat.com>, 	linux-nfs@vger.kernel.org, Steven Rostedt
 <rostedt@goodmis.org>, Miklos Szeredi	 <miklos@szeredi.hu>,
 linux-cifs@vger.kernel.org
Date: Thu, 24 Apr 2025 07:48:47 -0400
In-Reply-To: <20250424060845.GG2023217@ZenIV>
References: <20250424060845.GG2023217@ZenIV>
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

On Thu, 2025-04-24 at 07:08 +0100, Al Viro wrote:
> Currently the calling conventions for ->d_automount() instances have
> an odd wart - returned new mount to be attached is expected to have
> refcount 2.
>=20
> That kludge is intended to make sure that mark_mounts_for_expiry() called
> before we get around to attaching that new mount to the tree won't decide
> to take it out.  finish_automount() drops the extra reference after it's
> done with attaching mount to the tree - or drops the reference twice in
> case of error.  ->d_automount() instances have rather counterintuitive
> boilerplate in them.
>=20
> There's a much simpler approach: have mark_mounts_for_expiry() skip the
> mounts that are yet to be mounted.  And to hell with grabbing/dropping
> those extra references.  Makes for simpler correctness analysis, at that.=
..
>    =20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesy=
stems/porting.rst
> index 767b2927c762..749637231773 100644
> --- a/Documentation/filesystems/porting.rst
> +++ b/Documentation/filesystems/porting.rst
> @@ -1203,3 +1203,10 @@ should use d_drop();d_splice_alias() and return th=
e result of the latter.
>  If a positive dentry cannot be returned for some reason, in-kernel
>  clients such as cachefiles, nfsd, smb/server may not perform ideally but
>  will fail-safe.
> +
> +---
> +
> +**mandatory**
> +
> +Calling conventions for ->d_automount() have changed; we should *not* gr=
ab
> +an extra reference to new mount - it should be returned with refcount 1.
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystem=
s/vfs.rst
> index ae79c30b6c0c..cc0a58e96770 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -1411,9 +1411,7 @@ defined:
> =20
>  	If a vfsmount is returned, the caller will attempt to mount it
>  	on the mountpoint and will remove the vfsmount from its
> -	expiration list in the case of failure.  The vfsmount should be
> -	returned with 2 refs on it to prevent automatic expiration - the
> -	caller will clean up the additional ref.
> +	expiration list in the case of failure.
> =20
>  	This function is only used if DCACHE_NEED_AUTOMOUNT is set on
>  	the dentry.  This is set by __d_instantiate() if S_AUTOMOUNT is
> diff --git a/fs/afs/mntpt.c b/fs/afs/mntpt.c
> index 45cee6534122..9434a5399f2b 100644
> --- a/fs/afs/mntpt.c
> +++ b/fs/afs/mntpt.c
> @@ -189,7 +189,6 @@ struct vfsmount *afs_d_automount(struct path *path)
>  	if (IS_ERR(newmnt))
>  		return newmnt;
> =20
> -	mntget(newmnt); /* prevent immediate expiration */
>  	mnt_set_expiry(newmnt, &afs_vfsmounts);
>  	queue_delayed_work(afs_wq, &afs_mntpt_expiry_timer,
>  			   afs_mntpt_expiry_timeout * HZ);
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 83ac192e7fdd..05d8584fd3b9 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -319,9 +319,6 @@ static struct vfsmount *fuse_dentry_automount(struct =
path *path)
> =20
>  	/* Create the submount */
>  	mnt =3D fc_mount(fsc);
> -	if (!IS_ERR(mnt))
> -		mntget(mnt);
> -
>  	put_fs_context(fsc);
>  	return mnt;
>  }
> diff --git a/fs/namespace.c b/fs/namespace.c
> index bbda516444ff..1807ccb1a52d 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -3903,10 +3903,6 @@ int finish_automount(struct vfsmount *m, const str=
uct path *path)
>  		return PTR_ERR(m);
> =20
>  	mnt =3D real_mount(m);
> -	/* The new mount record should have at least 2 refs to prevent it being
> -	 * expired before we get a chance to add it
> -	 */
> -	BUG_ON(mnt_get_count(mnt) < 2);
> =20
>  	if (m->mnt_sb =3D=3D path->mnt->mnt_sb &&
>  	    m->mnt_root =3D=3D dentry) {
> @@ -3939,7 +3935,6 @@ int finish_automount(struct vfsmount *m, const stru=
ct path *path)
>  	unlock_mount(mp);
>  	if (unlikely(err))
>  		goto discard;
> -	mntput(m);
>  	return 0;
> =20
>  discard_locked:
> @@ -3953,7 +3948,6 @@ int finish_automount(struct vfsmount *m, const stru=
ct path *path)
>  		namespace_unlock();
>  	}
>  	mntput(m);
> -	mntput(m);
>  	return err;
>  }
> =20
> @@ -3990,11 +3984,14 @@ void mark_mounts_for_expiry(struct list_head *mou=
nts)
> =20
>  	/* extract from the expiration list every vfsmount that matches the
>  	 * following criteria:
> +	 * - already mounted
>  	 * - only referenced by its parent vfsmount
>  	 * - still marked for expiry (marked on the last call here; marks are
>  	 *   cleared by mntput())
>  	 */
>  	list_for_each_entry_safe(mnt, next, mounts, mnt_expire) {
> +		if (!is_mounted(&mnt->mnt))
> +			continue;
>  		if (!xchg(&mnt->mnt_expiry_mark, 1) ||
>  			propagate_mount_busy(mnt, 1))
>  			continue;
> diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
> index 973aed9cc5fe..7f1ec9c67ff2 100644
> --- a/fs/nfs/namespace.c
> +++ b/fs/nfs/namespace.c
> @@ -195,7 +195,6 @@ struct vfsmount *nfs_d_automount(struct path *path)
>  	if (IS_ERR(mnt))
>  		goto out_fc;
> =20
> -	mntget(mnt); /* prevent immediate expiration */
>  	if (timeout <=3D 0)
>  		goto out_fc;
> =20
> diff --git a/fs/smb/client/namespace.c b/fs/smb/client/namespace.c
> index e3f9213131c4..778daf11f1db 100644
> --- a/fs/smb/client/namespace.c
> +++ b/fs/smb/client/namespace.c
> @@ -283,7 +283,6 @@ struct vfsmount *cifs_d_automount(struct path *path)
>  		return newmnt;
>  	}
> =20
> -	mntget(newmnt); /* prevent immediate expiration */
>  	mnt_set_expiry(newmnt, &cifs_automount_list);
>  	schedule_delayed_work(&cifs_automount_task,
>  			      cifs_mountpoint_expiry_timeout);
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 8ddf6b17215c..fa488721019f 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -10085,8 +10085,6 @@ static struct vfsmount *trace_automount(struct de=
ntry *mntpt, void *ingore)
>  	put_filesystem(type);
>  	if (IS_ERR(mnt))
>  		return NULL;
> -	mntget(mnt);
> -
>  	return mnt;
>  }
> =20
>=20

Much cleaner:

Reviewed-by: Jeff Layton <jlayton@kernel.org>

