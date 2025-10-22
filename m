Return-Path: <linux-fsdevel+bounces-65077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D0CBFB096
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 11:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 604AC3AB22E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 09:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93892311979;
	Wed, 22 Oct 2025 09:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dSiQXI/l";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MWisSngV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qdPETKvZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3uDlxHFr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBBC3101BA
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 09:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761123711; cv=none; b=aah82/BPkuy1rp18Q82PhQ1iwXlzPx98JdB4I2BCeOauP6W4vEoAn4Ve/ojHCZPHBbSlx5slYM0b49TzkTpTc4zQvi+Oy+PRFdYyyxDx8KcCCcfzpCiy0jmb1Ldaoi5Xp+7a1+XITp10HFSNRCQpG3EH1NlH/L2NPRq8jlsvRC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761123711; c=relaxed/simple;
	bh=VHN/UQff7A3+DxFgq1sSc7iiJV2KTM6NJo0DtGeq3rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYKxmJSkTrOT6zGx1Mx8vKPsUNWXFwnRZ0s8x4fJmqfFoHCJkppgsABWh8sI4z3AnUdy25Igk3aMKjhfPtjgPET9VQy2GvMaaxxq3/LOmSJZZWmPEifvn+MGmDjV1I/poOHcQhgNWbXQbtW9VdpwpHsGe/8fJTIrCdqgUg2W5dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dSiQXI/l; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MWisSngV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qdPETKvZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3uDlxHFr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 49D7C1F749;
	Wed, 22 Oct 2025 09:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761123702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rDdPlNAcuhAAy0Fe+9/oq8PqcomW2cgrMGt2giiFlOU=;
	b=dSiQXI/lo5BVa8LX9AmhKCTXDAmIn6mF+frLmQXmp7bUVGu8yUxl7sDryqyFQsClydfajG
	dWqthMIRl7vL3YXLr8LYwo8I44U5PuYsEyHr9wRTHCkWDRQNdqzQLVUNWG2DU7e3EwKERe
	gp7b8bCMJWOxDErHASAP+6Q2BYHWVCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761123702;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rDdPlNAcuhAAy0Fe+9/oq8PqcomW2cgrMGt2giiFlOU=;
	b=MWisSngV32oGPqXWOijJsTcE2TbQIq8cuT77IYQAwy6y3yy8YH+GenekNfhR8wARPsWWO2
	ccIzjqUYOqF8SFCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761123698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rDdPlNAcuhAAy0Fe+9/oq8PqcomW2cgrMGt2giiFlOU=;
	b=qdPETKvZPIPot8Ex3gj2HTC55yOlxp9zrZ0yMjmUTgO9QsKXnFtYZdYQrfFioOKr9Y346j
	CGm8LEOPnwWEIrTVhuVH4s+7qlaOhJ0EzTZTTM9MkfxP9blCETMGHLIIyauVo/MYF66/8a
	1E8Y+N/bkUxtNzEygqA5H9BwpCyMnrs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761123698;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rDdPlNAcuhAAy0Fe+9/oq8PqcomW2cgrMGt2giiFlOU=;
	b=3uDlxHFrVzqE2LzeWr7B9NE7IM77VJZ1LN5sResymS2pMKDGNh6cCav/Jxi9s4zHuqYfiu
	aExjNa6qZBBa6/AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B5EC13A29;
	Wed, 22 Oct 2025 09:01:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ff15DnKd+GhDawAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 22 Oct 2025 09:01:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AC4BCA0990; Wed, 22 Oct 2025 11:01:22 +0200 (CEST)
Date: Wed, 22 Oct 2025 11:01:22 +0200
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Tom Talpey <tom@talpey.com>, Bharath SM <bharathsm@microsoft.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, David Howells <dhowells@redhat.com>, 
	Tyler Hicks <code@tyhicks.com>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Amir Goldstein <amir73il@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Steve French <smfrench@gmail.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Carlos Maiolino <cem@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, netfs@lists.linux.dev, 
	ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v3 08/13] vfs: make vfs_symlink break delegations on
 parent dir
Message-ID: <od3ovbtjf3hc3htk6wxhb4t7wpq3he53dm3l23d456o4yjbe4t@tooasyi3jer4>
References: <20251021-dir-deleg-ro-v3-0-a08b1cde9f4c@kernel.org>
 <20251021-dir-deleg-ro-v3-8-a08b1cde9f4c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021-dir-deleg-ro-v3-8-a08b1cde9f4c@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[44];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	R_RATELIMIT(0.00)[to_ip_from(RL63fqwwx8ot6gmekemcs76f9d)];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[szeredi.hu,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,samba.org,manguebit.org,microsoft.com,talpey.com,linuxfoundation.org,redhat.com,tyhicks.com,brown.name,chromium.org,google.com,davemloft.net,vger.kernel.org,lists.samba.org,lists.linux.dev];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.30

On Tue 21-10-25 11:25:43, Jeff Layton wrote:
> In order to add directory delegation support, we must break delegations
> on the parent on any change to the directory.
> 
> Add a delegated_inode parameter to vfs_symlink() and have it break the
> delegation. do_symlinkat() can then wait on the delegation break before
> proceeding.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ecryptfs/inode.c      |  2 +-
>  fs/init.c                |  2 +-
>  fs/namei.c               | 16 ++++++++++++++--
>  fs/nfsd/vfs.c            |  2 +-
>  fs/overlayfs/overlayfs.h |  2 +-
>  include/linux/fs.h       |  2 +-
>  6 files changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index 639ae42bcd56890d04592f7269e4ffc099b44f09..d430ec5a63094ea4cd42828e7d44f0f8d918fcec 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -480,7 +480,7 @@ static int ecryptfs_symlink(struct mnt_idmap *idmap,
>  	if (rc)
>  		goto out_lock;
>  	rc = vfs_symlink(&nop_mnt_idmap, lower_dir, lower_dentry,
> -			 encoded_symname);
> +			 encoded_symname, NULL);
>  	kfree(encoded_symname);
>  	if (rc || d_really_is_negative(lower_dentry))
>  		goto out_lock;
> diff --git a/fs/init.c b/fs/init.c
> index 4f02260dd65b0dfcbfbf5812d2ec6a33444a3b1f..e0f5429c0a49d046bd3f231a260954ed0f90ef44 100644
> --- a/fs/init.c
> +++ b/fs/init.c
> @@ -209,7 +209,7 @@ int __init init_symlink(const char *oldname, const char *newname)
>  	error = security_path_symlink(&path, dentry, oldname);
>  	if (!error)
>  		error = vfs_symlink(mnt_idmap(path.mnt), path.dentry->d_inode,
> -				    dentry, oldname);
> +				    dentry, oldname, NULL);
>  	end_creating_path(&path, dentry);
>  	return error;
>  }
> diff --git a/fs/namei.c b/fs/namei.c
> index 7e400cbdbc6af1c72eb684f051d0571e944a27d7..71af256cdd941e200389570538f64a3f795e6c83 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4851,6 +4851,7 @@ SYSCALL_DEFINE1(unlink, const char __user *, pathname)
>   * @dir:	inode of the parent directory
>   * @dentry:	dentry of the child symlink file
>   * @oldname:	name of the file to link to
> + * @delegated_inode: returns victim inode, if the inode is delegated.
>   *
>   * Create a symlink.
>   *
> @@ -4861,7 +4862,8 @@ SYSCALL_DEFINE1(unlink, const char __user *, pathname)
>   * raw inode simply pass @nop_mnt_idmap.
>   */
>  int vfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
> -		struct dentry *dentry, const char *oldname)
> +		struct dentry *dentry, const char *oldname,
> +		struct inode **delegated_inode)
>  {
>  	int error;
>  
> @@ -4876,6 +4878,10 @@ int vfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
>  	if (error)
>  		return error;
>  
> +	error = try_break_deleg(dir, delegated_inode);
> +	if (error)
> +		return error;
> +
>  	error = dir->i_op->symlink(idmap, dir, dentry, oldname);
>  	if (!error)
>  		fsnotify_create(dir, dentry);
> @@ -4889,6 +4895,7 @@ int do_symlinkat(struct filename *from, int newdfd, struct filename *to)
>  	struct dentry *dentry;
>  	struct path path;
>  	unsigned int lookup_flags = 0;
> +	struct inode *delegated_inode = NULL;
>  
>  	if (IS_ERR(from)) {
>  		error = PTR_ERR(from);
> @@ -4903,8 +4910,13 @@ int do_symlinkat(struct filename *from, int newdfd, struct filename *to)
>  	error = security_path_symlink(&path, dentry, from->name);
>  	if (!error)
>  		error = vfs_symlink(mnt_idmap(path.mnt), path.dentry->d_inode,
> -				    dentry, from->name);
> +				    dentry, from->name, &delegated_inode);
>  	end_creating_path(&path, dentry);
> +	if (delegated_inode) {
> +		error = break_deleg_wait(&delegated_inode);
> +		if (!error)
> +			goto retry;
> +	}
>  	if (retry_estale(error, lookup_flags)) {
>  		lookup_flags |= LOOKUP_REVAL;
>  		goto retry;
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 44debf3d0be450ddc245e2fa4f57fe076e1454a2..386f454badce7ed448399ef93e9c8edafbcc4d79 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1829,7 +1829,7 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	err = fh_fill_pre_attrs(fhp);
>  	if (err != nfs_ok)
>  		goto out_unlock;
> -	host_err = vfs_symlink(&nop_mnt_idmap, d_inode(dentry), dnew, path);
> +	host_err = vfs_symlink(&nop_mnt_idmap, d_inode(dentry), dnew, path, NULL);
>  	err = nfserrno(host_err);
>  	cerr = fh_compose(resfhp, fhp->fh_export, dnew, fhp);
>  	if (!err)
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 87b82dada7ec1b8429299c68078cda24176c5607..94bb4540f7ae2e0571b3b88393c180bd73c3c09c 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -267,7 +267,7 @@ static inline int ovl_do_symlink(struct ovl_fs *ofs,
>  				 struct inode *dir, struct dentry *dentry,
>  				 const char *oldname)
>  {
> -	int err = vfs_symlink(ovl_upper_mnt_idmap(ofs), dir, dentry, oldname);
> +	int err = vfs_symlink(ovl_upper_mnt_idmap(ofs), dir, dentry, oldname, NULL);
>  
>  	pr_debug("symlink(\"%s\", %pd2) = %i\n", oldname, dentry, err);
>  	return err;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index a1e1afe39e01a46bf0a81e241b92690947402851..d8c7245da3bf3200b435c7ea6cafcf7903ebf293 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2117,7 +2117,7 @@ struct dentry *vfs_mkdir(struct mnt_idmap *, struct inode *,
>  int vfs_mknod(struct mnt_idmap *, struct inode *, struct dentry *,
>  	      umode_t, dev_t, struct inode **);
>  int vfs_symlink(struct mnt_idmap *, struct inode *,
> -		struct dentry *, const char *);
> +		struct dentry *, const char *, struct inode **);
>  int vfs_link(struct dentry *, struct mnt_idmap *, struct inode *,
>  	     struct dentry *, struct inode **);
>  int vfs_rmdir(struct mnt_idmap *, struct inode *, struct dentry *,
> 
> -- 
> 2.51.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

