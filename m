Return-Path: <linux-fsdevel+bounces-48813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8500AB4D4E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 09:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A9DF1B42ADF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 07:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00B11F150B;
	Tue, 13 May 2025 07:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9gJSotR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449171F0E32;
	Tue, 13 May 2025 07:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747122566; cv=none; b=LHJ27nc43yMcRfET5xoZetq7alSc8aguILLBgcfb+FoupCOnNUw3TKGhnXp9CuTF+TbjZf08w43c6pwqcPDMHOHcy4H6vXb3Lr+lAZCRxRTv9wsxDoiHClYsLVXHpzmLkiW46Z7DNoKQ+Rj+KVnS8H1cO4AgEu6yvh1TjJNnZOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747122566; c=relaxed/simple;
	bh=VLxcu0V7gW2h5K11iB7jr+IaeN8+cPN0RC81qh4vOK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/NDM5leexdcbQTAYTkpUIGQVH+iIQsPWtrAxU1NNIQmqYiv1KKPEXbNGcu8XulKmZ9WwEk4KKAwk3NLku33OTfX0v0WRTBsbrnWKkpZtGC/3W2eFMTnYq138MBGqEb87R3tZNyrHQW+U7vMtGqYGCGRDE4NHdX4vUIAeHMR30I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9gJSotR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B532C4CEE4;
	Tue, 13 May 2025 07:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747122565;
	bh=VLxcu0V7gW2h5K11iB7jr+IaeN8+cPN0RC81qh4vOK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K9gJSotRqE11irDRsenj/Sps9sqasgQoguQjG7u/53txwvUsSj7hERGuVKPCC8M8H
	 JYwDRY/Kh5ZZyFrRVTwfig9iJJm4P+v2LujQ6c2iz8VNfcub7Q9eTgR2MW3Ej0A8iX
	 oFpaNeENNsrWs6nmUYMm8mC9Q6tX4406XvX3JHzPHSrXR8N1MUEXixnQExIRGlqeHr
	 HP5MCGvRHb8XEr5pXh/rxaFCAnWJCQFyUzv+R2EK17Hh9gvT+MQ6Vsz6EmhjjbqdcL
	 TcqMwq2kHogMFs44jzWW+e/2v+StEBchj8WofhBSncT2/fgsNG3Qhj47N1SrgFgVRH
	 RJj1mmRuJE6CA==
Date: Tue, 13 May 2025 09:49:20 +0200
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Etienne Champetier <champetier.etienne@gmail.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Jeffrey Altman <jaltman@auristor.com>, Chet Ramey <chet.ramey@case.edu>, 
	Steve French <sfrench@samba.org>, linux-afs@lists.infradead.org, openafs-devel@openafs.org, 
	linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] afs, bash: Fix open(O_CREAT) on an extant AFS file in
 a sticky dir
Message-ID: <20250513-dividende-kursniveau-014674876b04@brauner>
References: <20250509-deckung-glitschig-8d27cb12f09f@brauner>
 <20250505-erproben-zeltlager-4c16f07b96ae@brauner>
 <433928.1745944651@warthog.procyon.org.uk>
 <1209711.1746527190@warthog.procyon.org.uk>
 <2086612.1747054957@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2086612.1747054957@warthog.procyon.org.uk>

On Mon, May 12, 2025 at 02:02:37PM +0100, David Howells wrote:
> Christian Brauner <brauner@kernel.org> wrote:
> 
> > > Now, in my patch, I added two inode ops because they VFS code involved makes
> > > two distinct evaluations and so I made an op for each and, as such, those
> > > evaluations may be applicable elsewhere, but I could make a combined op that
> > > handles that specific situation instead.
> > 
> > Try to make it one, please.
> 
> Okay, see attached.
> 
> David
> ----
> Bash has a work around in redir_open() that causes open(O_CREAT) of a file
> in a sticky directory to be retried without O_CREAT if bash was built with
> AFS workarounds configured:
> 
>         #if defined (AFS)
>               if ((fd < 0) && (errno == EACCES))
>             {
>               fd = open (filename, flags & ~O_CREAT, mode);
>               errno = EACCES;    /* restore errno */
>             }
> 
>         #endif /* AFS */
> 
> This works around the kernel not being able to validly check the
> current_fsuid() against i_uid on the file or the directory because the
> uidspaces of the system and of AFS may well be disjoint.  The problem lies
> with the uid checks in may_create_in_sticky().
> 
> However, the bash work around is going to be removed:
> 
>         https://git.savannah.gnu.org/cgit/bash.git/tree/redir.c?h=bash-5.3-rc1#n733
> 
> Fix this in the kernel by providing a ->may_create_in_sticky() inode op,
> similar to ->permission(), that, if provided, is called to:
> 
>  (1) see if an inode has the same owner as the parent on the path walked;
> 
>  (2) determine if the caller owns the file instead of checking the i_uid to
>      current_fsuid().
> 
> For kafs, the hook is implemented to see if:
> 
>  (1) the AFS owner IDs retrieved on the file and its parent directory by
>      FS.FetchStatus match;
> 
>  (2) if the server set the ADMINISTER bit in the access rights returned by
>      the FS.FetchStatus and suchlike for the key, indicating ownership by
>      the user specified by the key.
> 
> (Note that the owner IDs retrieved from an AuriStor YFS server may not fit
> in the kuid_t being 64-bit, so they need comparing directly).

There's a few other places where we compare vfsuids:

* may_delete()
  -> check_sticky()
     -> __check_sticky()

* may_follow_link()

* may_linkat()

* fsuidgid_has_mapping()

Anyone of those need special treatment on AFS as well?

> This can be tested by creating a sticky directory (the user must have a
> token to do this) and creating a file in it.  Then strace bash doing "echo
> foo >>file" and look at whether bash does a single, successful O_CREAT open
> on the file or whether that one fails and then bash does one without
> O_CREAT that succeeds.
> 
> Reported-by: Etienne Champetier <champetier.etienne@gmail.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: Jeffrey Altman <jaltman@auristor.com>
> cc: Chet Ramey <chet.ramey@case.edu>
> cc: Alexander Viro <viro@zeniv.linux.org.uk>
> cc: Christian Brauner <brauner@kernel.org>
> cc: Steve French <sfrench@samba.org>
> cc: linux-afs@lists.infradead.org
> cc: openafs-devel@openafs.org
> cc: linux-cifs@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/afs/dir.c       |    1 +
>  fs/afs/file.c      |    1 +
>  fs/afs/internal.h  |    2 ++
>  fs/afs/security.c  |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/namei.c         |   17 ++++++++++++-----
>  include/linux/fs.h |    2 ++
>  6 files changed, 70 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/afs/dir.c b/fs/afs/dir.c
> index 9e7b1fe82c27..27e565612bde 100644
> --- a/fs/afs/dir.c
> +++ b/fs/afs/dir.c
> @@ -65,6 +65,7 @@ const struct inode_operations afs_dir_inode_operations = {
>  	.permission	= afs_permission,
>  	.getattr	= afs_getattr,
>  	.setattr	= afs_setattr,
> +	.may_create_in_sticky = afs_may_create_in_sticky,
>  };
>  
>  const struct address_space_operations afs_dir_aops = {
> diff --git a/fs/afs/file.c b/fs/afs/file.c
> index fc15497608c6..dff48d0adec3 100644
> --- a/fs/afs/file.c
> +++ b/fs/afs/file.c
> @@ -47,6 +47,7 @@ const struct inode_operations afs_file_inode_operations = {
>  	.getattr	= afs_getattr,
>  	.setattr	= afs_setattr,
>  	.permission	= afs_permission,
> +	.may_create_in_sticky = afs_may_create_in_sticky,
>  };
>  
>  const struct address_space_operations afs_file_aops = {
> diff --git a/fs/afs/internal.h b/fs/afs/internal.h
> index 440b0e731093..4a5bb01606a8 100644
> --- a/fs/afs/internal.h
> +++ b/fs/afs/internal.h
> @@ -1495,6 +1495,8 @@ extern struct key *afs_request_key(struct afs_cell *);
>  extern struct key *afs_request_key_rcu(struct afs_cell *);
>  extern int afs_check_permit(struct afs_vnode *, struct key *, afs_access_t *);
>  extern int afs_permission(struct mnt_idmap *, struct inode *, int);
> +int afs_may_create_in_sticky(struct mnt_idmap *idmap, struct inode *inode,
> +			     struct path *path);
>  extern void __exit afs_clean_up_permit_cache(void);
>  
>  /*
> diff --git a/fs/afs/security.c b/fs/afs/security.c
> index 6a7744c9e2a2..9fd6e4b5c228 100644
> --- a/fs/afs/security.c
> +++ b/fs/afs/security.c
> @@ -477,6 +477,58 @@ int afs_permission(struct mnt_idmap *idmap, struct inode *inode,
>  	return ret;
>  }
>  
> +/*
> + * Perform the ownership checks for a file in a sticky directory on AFS.
> + *
> + * In the case of AFS, this means that:
> + *
> + * (1) the file and the directory have the same AFS ownership or
> + *
> + * (2) the file is owned by the AFS user represented by the token (e.g. from a
> + *     kerberos server) held in a key.
> + *
> + * Returns 0 if owned by me or has same owner as parent dir, 1 if not; can also
> + * return an error.
> + */
> +int afs_may_create_in_sticky(struct mnt_idmap *idmap, struct inode *inode,
> +			     struct path *path)
> +{
> +	struct afs_vnode *dvnode, *vnode = AFS_FS_I(inode);
> +	struct dentry *parent;
> +	struct key *key;
> +	afs_access_t access;
> +	int ret;
> +	s64 owner;
> +
> +	key = afs_request_key(vnode->volume->cell);
> +	if (IS_ERR(key))
> +		return PTR_ERR(key);
> +
> +	/* Get the owner's ID for the directory.  Ideally, we'd use RCU to
> +	 * access the parent rather than getting a ref.
> +	 */
> +	parent = dget_parent(path->dentry);
> +	dvnode = AFS_FS_I(d_backing_inode(parent));
> +	owner = dvnode->status.owner;
> +	dput(parent);
> +
> +	if (vnode->status.owner == owner) {
> +		ret = 0;
> +		goto error;
> +	}
> +
> +	/* Get the access rights for the key on this file. */
> +	ret = afs_check_permit(vnode, key, &access);
> +	if (ret < 0)
> +		goto error;
> +
> +	/* We get the ADMINISTER bit if we own the file. */
> +	ret = (access & AFS_ACE_ADMINISTER) ? 1 : 0;
> +error:
> +	key_put(key);
> +	return ret;
> +}
> +
>  void __exit afs_clean_up_permit_cache(void)
>  {
>  	int i;
> diff --git a/fs/namei.c b/fs/namei.c
> index 84a0e0b0111c..e52c91cbed2a 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1316,13 +1316,20 @@ static int may_create_in_sticky(struct mnt_idmap *idmap, struct nameidata *nd,
>  	if (S_ISFIFO(inode->i_mode) && !sysctl_protected_fifos)
>  		return 0;
>  
> -	i_vfsuid = i_uid_into_vfsuid(idmap, inode);
> +	if (unlikely(inode->i_op->may_create_in_sticky)) {
> +		int ret = inode->i_op->may_create_in_sticky(idmap, inode, &nd->path);

This should probably use an IOP flag just like we do for permission
handling.

>  
> -	if (vfsuid_eq(i_vfsuid, dir_vfsuid))
> -		return 0;
> +		if (ret <= 0) /* 1 if not owned by me or by parent dir. */
> +			return ret;
> +	} else {
> +		i_vfsuid = i_uid_into_vfsuid(idmap, inode);
>  
> -	if (vfsuid_eq_kuid(i_vfsuid, current_fsuid()))
> -		return 0;
> +		if (vfsuid_eq(i_vfsuid, dir_vfsuid))
> +			return 0;
> +
> +		if (vfsuid_eq_kuid(i_vfsuid, current_fsuid()))
> +			return 0;
> +	}
>  
>  	if (likely(dir_mode & 0002)) {
>  		audit_log_path_denied(AUDIT_ANOM_CREAT, "sticky_create");
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 016b0fe1536e..11122e169719 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2236,6 +2236,8 @@ struct inode_operations {
>  			    struct dentry *dentry, struct fileattr *fa);
>  	int (*fileattr_get)(struct dentry *dentry, struct fileattr *fa);
>  	struct offset_ctx *(*get_offset_ctx)(struct inode *inode);
> +	int (*may_create_in_sticky)(struct mnt_idmap *idmap, struct inode *inode,
> +				    struct path *path);
>  } ____cacheline_aligned;
>  
>  static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
> 

