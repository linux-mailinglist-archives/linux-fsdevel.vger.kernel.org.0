Return-Path: <linux-fsdevel+bounces-64668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A05BF03B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 11:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 263CD34ACEA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 09:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F2C2F657F;
	Mon, 20 Oct 2025 09:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AbCokr9d";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="htOJBh5D";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lecXGC+s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="w+ROXWwa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB66B33987
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 09:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760953126; cv=none; b=oJ80m3oTW5q5MM3QjaogMBoKdrDYbRwGAC3vLG4apm4lE0g+ec0LZuBeKgiSQ9fmB/2tNMpKVmgfp8/fJoEwq//hOqnCytrlkvpQpKiDPLxheIL2x8uYvOIX83d/5PHd4vinCLSF/PwiIDcMrejkU8Gj0m5q/sRn4F5r8WAMgcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760953126; c=relaxed/simple;
	bh=BvivGmhsM3FvZ6Lxm8NOO2kq3ajrIfhuXygsw7GX55I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZ7KYg8qMA5NpAtAvZgIf+ufUV/oAqxMMCFT5IqrQmTfe7lD9cy2yvG2sTlf/xb86FdjzfyPa9p7fYMQaxnzfxv9a0hYtMqh+4LZXKONDPjy7a4yOxUcKE1nA5gwD2BMLla5xg4LF6aW+RJjFJZX5EG2sq6V9Armq6r0wLG41+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AbCokr9d; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=htOJBh5D; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lecXGC+s; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=w+ROXWwa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 503481F387;
	Mon, 20 Oct 2025 09:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760953110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wzwy5x2PYJ6Ji+N5DkWavBUtEqBNmQBy4TmNzsIyKBk=;
	b=AbCokr9dcIh0NiCZ9cee7OmJq14x2+KI4TwurVPy4R5ubkZcSdypO8X3BCzPdoy7wY67RT
	YicommI+KCLloL29wfNG3Zf4zVX/BnqgEWA0pRnazudCRSip0gnID1navjnzhcIbHLA3Uj
	jFh8R6pXzlUVGDhnEgU50WWUHw3mL+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760953110;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wzwy5x2PYJ6Ji+N5DkWavBUtEqBNmQBy4TmNzsIyKBk=;
	b=htOJBh5DZ0E1gaAuVZMfUX4OaN1kpMQNAdjPYasYIn+FvlC7M3JEd20beZZqqTIvvpMzWc
	/Mo6PJTk6e/fxWAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=lecXGC+s;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=w+ROXWwa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760953106; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wzwy5x2PYJ6Ji+N5DkWavBUtEqBNmQBy4TmNzsIyKBk=;
	b=lecXGC+s4hN8o9BjaHzKAULEA5+P96smF+Nl8+Lf7OByLCrRbnQWa5lX39WGwc95ZNzr9X
	EX/1hyQrEeovpaYVudpvdRDja2MbGT6veU7l+Fpc+r12TBbyPQ6VPMPRvBuw2Xz3Oc/0Tn
	LFYWbh+95+aoa3DavjddggCaIGaoGj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760953106;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wzwy5x2PYJ6Ji+N5DkWavBUtEqBNmQBy4TmNzsIyKBk=;
	b=w+ROXWwa1pt4+XUlIQ/mwD6xiZt1mj0tkgHedJ7Wv52zYHz8D56CvMcOYLhKY43veDzZQM
	kpDN+Tdf8JzGiVBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4377013AAD;
	Mon, 20 Oct 2025 09:38:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CIZ4EBID9mg+DwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 Oct 2025 09:38:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 04A47A0856; Mon, 20 Oct 2025 11:38:25 +0200 (CEST)
Date: Mon, 20 Oct 2025 11:38:25 +0200
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
Subject: Re: [PATCH 05/13] vfs: allow rmdir to wait for delegation break on
 parent
Message-ID: <dmixw6ybhw2bqfejcpd5xq6i6o77heuunhnezy3nwrgraw2fce@e7xhnz24u6yn>
References: <20251013-dir-deleg-ro-v1-0-406780a70e5e@kernel.org>
 <20251013-dir-deleg-ro-v1-5-406780a70e5e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013-dir-deleg-ro-v1-5-406780a70e5e@kernel.org>
X-Rspamd-Queue-Id: 503481F387
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[44];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLpnapcpkwxdkc5mopt1ezhhna)];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[szeredi.hu,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,samba.org,manguebit.org,microsoft.com,talpey.com,linuxfoundation.org,redhat.com,tyhicks.com,brown.name,chromium.org,google.com,davemloft.net,vger.kernel.org,lists.samba.org,lists.linux.dev];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 

On Mon 13-10-25 10:48:03, Jeff Layton wrote:
> In order to add directory delegation support, we need to break
> delegations on the parent whenever there is going to be a change in the
> directory.
> 
> Add a "delegated_inode" return pointer to vfs_rmdir() and populate that
> pointer with the parent inode if it's non-NULL. Most existing in-kernel
> callers pass in a NULL pointer.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/base/devtmpfs.c  |  2 +-
>  fs/ecryptfs/inode.c      |  2 +-
>  fs/namei.c               | 22 +++++++++++++++++-----
>  fs/nfsd/nfs4recover.c    |  4 ++--
>  fs/nfsd/vfs.c            |  2 +-
>  fs/overlayfs/overlayfs.h |  2 +-
>  fs/smb/server/vfs.c      |  4 ++--
>  include/linux/fs.h       |  3 ++-
>  8 files changed, 27 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
> index 0e79621cb0f79870003b867ca384199171ded4e0..104025104ef75381984fd94dfbd50feeaa8cdd22 100644
> --- a/drivers/base/devtmpfs.c
> +++ b/drivers/base/devtmpfs.c
> @@ -261,7 +261,7 @@ static int dev_rmdir(const char *name)
>  		return PTR_ERR(dentry);
>  	if (d_inode(dentry)->i_private == &thread)
>  		err = vfs_rmdir(&nop_mnt_idmap, d_inode(parent.dentry),
> -				dentry);
> +				dentry, NULL);
>  	else
>  		err = -EPERM;
>  
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index 35830b3144f8f71374a78b3e7463b864f4fc216e..88631291b32535f623a3fbe4ea9b6ed48a306ca0 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -540,7 +540,7 @@ static int ecryptfs_rmdir(struct inode *dir, struct dentry *dentry)
>  		if (d_unhashed(lower_dentry))
>  			rc = -EINVAL;
>  		else
> -			rc = vfs_rmdir(&nop_mnt_idmap, lower_dir, lower_dentry);
> +			rc = vfs_rmdir(&nop_mnt_idmap, lower_dir, lower_dentry, NULL);
>  	}
>  	if (!rc) {
>  		clear_nlink(d_inode(dentry));
> diff --git a/fs/namei.c b/fs/namei.c
> index 86cf6eca1f485361c6732974e4103cf5ea721539..4b5a99653c558397e592715d9d4663cd4a63ef86 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4522,9 +4522,10 @@ SYSCALL_DEFINE2(mkdir, const char __user *, pathname, umode_t, mode)
>  
>  /**
>   * vfs_rmdir - remove directory
> - * @idmap:	idmap of the mount the inode was found from
> - * @dir:	inode of the parent directory
> - * @dentry:	dentry of the child directory
> + * @idmap:		idmap of the mount the inode was found from
> + * @dir:		inode of the parent directory
> + * @dentry:		dentry of the child directory
> + * @delegated_inode:	returns parent inode, if it's delegated.
>   *
>   * Remove a directory.
>   *
> @@ -4535,7 +4536,7 @@ SYSCALL_DEFINE2(mkdir, const char __user *, pathname, umode_t, mode)
>   * raw inode simply pass @nop_mnt_idmap.
>   */
>  int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
> -		     struct dentry *dentry)
> +	      struct dentry *dentry, struct inode **delegated_inode)
>  {
>  	int error = may_delete(idmap, dir, dentry, 1);
>  
> @@ -4557,6 +4558,10 @@ int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
>  	if (error)
>  		goto out;
>  
> +	error = try_break_deleg(dir, delegated_inode);
> +	if (error)
> +		goto out;
> +
>  	error = dir->i_op->rmdir(dir, dentry);
>  	if (error)
>  		goto out;
> @@ -4583,6 +4588,7 @@ int do_rmdir(int dfd, struct filename *name)
>  	struct qstr last;
>  	int type;
>  	unsigned int lookup_flags = 0;
> +	struct inode *delegated_inode = NULL;
>  retry:
>  	error = filename_parentat(dfd, name, lookup_flags, &path, &last, &type);
>  	if (error)
> @@ -4612,7 +4618,8 @@ int do_rmdir(int dfd, struct filename *name)
>  	error = security_path_rmdir(&path, dentry);
>  	if (error)
>  		goto exit4;
> -	error = vfs_rmdir(mnt_idmap(path.mnt), path.dentry->d_inode, dentry);
> +	error = vfs_rmdir(mnt_idmap(path.mnt), path.dentry->d_inode,
> +			  dentry, &delegated_inode);
>  exit4:
>  	dput(dentry);
>  exit3:
> @@ -4620,6 +4627,11 @@ int do_rmdir(int dfd, struct filename *name)
>  	mnt_drop_write(path.mnt);
>  exit2:
>  	path_put(&path);
> +	if (delegated_inode) {
> +		error = break_deleg_wait(&delegated_inode);
> +		if (!error)
> +			goto retry;
> +	}
>  	if (retry_estale(error, lookup_flags)) {
>  		lookup_flags |= LOOKUP_REVAL;
>  		goto retry;
> diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> index 3dfbb85c9a1166b56e56eb9f1d6bfd140584730b..ad3acbb956d90cac88f74e5f598719af6f1f8328 100644
> --- a/fs/nfsd/nfs4recover.c
> +++ b/fs/nfsd/nfs4recover.c
> @@ -275,7 +275,7 @@ nfsd4_unlink_clid_dir(char *name, struct nfsd_net *nn)
>  	status = -ENOENT;
>  	if (d_really_is_negative(dentry))
>  		goto out;
> -	status = vfs_rmdir(&nop_mnt_idmap, d_inode(dir), dentry);
> +	status = vfs_rmdir(&nop_mnt_idmap, d_inode(dir), dentry, NULL);
>  out:
>  	dput(dentry);
>  out_unlock:
> @@ -367,7 +367,7 @@ purge_old(struct dentry *parent, char *cname, struct nfsd_net *nn)
>  	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
>  	child = lookup_one(&nop_mnt_idmap, &QSTR(cname), parent);
>  	if (!IS_ERR(child)) {
> -		status = vfs_rmdir(&nop_mnt_idmap, d_inode(parent), child);
> +		status = vfs_rmdir(&nop_mnt_idmap, d_inode(parent), child, NULL);
>  		if (status)
>  			printk("failed to remove client recovery directory %pd\n",
>  			       child);
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 447f5ab8e0b92288c9f220060ab15f32f2a84de9..7d8cd2595f197be9741ee6320d43ed6651896647 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -2194,7 +2194,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
>  				break;
>  		}
>  	} else {
> -		host_err = vfs_rmdir(&nop_mnt_idmap, dirp, rdentry);
> +		host_err = vfs_rmdir(&nop_mnt_idmap, dirp, rdentry, NULL);
>  	}
>  	fh_fill_post_attrs(fhp);
>  
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 0f65f9a5d54d4786b39e4f4f30f416d5b9016e70..d215d7349489686b66bb66e939b27046f7d836f6 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -206,7 +206,7 @@ static inline int ovl_do_notify_change(struct ovl_fs *ofs,
>  static inline int ovl_do_rmdir(struct ovl_fs *ofs,
>  			       struct inode *dir, struct dentry *dentry)
>  {
> -	int err = vfs_rmdir(ovl_upper_mnt_idmap(ofs), dir, dentry);
> +	int err = vfs_rmdir(ovl_upper_mnt_idmap(ofs), dir, dentry, NULL);
>  
>  	pr_debug("rmdir(%pd2) = %i\n", dentry, err);
>  	return err;
> diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
> index 3d2190f26623b23ea79c63410905a3c3ad684048..c5f0f3170d586cb2dc4d416b80948c642797fb82 100644
> --- a/fs/smb/server/vfs.c
> +++ b/fs/smb/server/vfs.c
> @@ -609,7 +609,7 @@ int ksmbd_vfs_remove_file(struct ksmbd_work *work, const struct path *path)
>  
>  	idmap = mnt_idmap(path->mnt);
>  	if (S_ISDIR(d_inode(path->dentry)->i_mode)) {
> -		err = vfs_rmdir(idmap, d_inode(parent), path->dentry);
> +		err = vfs_rmdir(idmap, d_inode(parent), path->dentry, NULL);
>  		if (err && err != -ENOTEMPTY)
>  			ksmbd_debug(VFS, "rmdir failed, err %d\n", err);
>  	} else {
> @@ -1090,7 +1090,7 @@ int ksmbd_vfs_unlink(struct file *filp)
>  	dget(dentry);
>  
>  	if (S_ISDIR(d_inode(dentry)->i_mode))
> -		err = vfs_rmdir(idmap, d_inode(dir), dentry);
> +		err = vfs_rmdir(idmap, d_inode(dir), dentry, NULL);
>  	else
>  		err = vfs_unlink(idmap, d_inode(dir), dentry, NULL);
>  
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 1040df3792794cd353b86558b41618294e25b8a6..d8bdaf7c87502ff17775602f5391d375738b4ed8 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2120,7 +2120,8 @@ int vfs_symlink(struct mnt_idmap *, struct inode *,
>  		struct dentry *, const char *);
>  int vfs_link(struct dentry *, struct mnt_idmap *, struct inode *,
>  	     struct dentry *, struct inode **);
> -int vfs_rmdir(struct mnt_idmap *, struct inode *, struct dentry *);
> +int vfs_rmdir(struct mnt_idmap *, struct inode *, struct dentry *,
> +	      struct inode **);
>  int vfs_unlink(struct mnt_idmap *, struct inode *, struct dentry *,
>  	       struct inode **);
>  
> 
> -- 
> 2.51.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

