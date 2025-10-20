Return-Path: <linux-fsdevel+bounces-64670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38864BF0439
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 11:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEB833ACE64
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 09:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92C12F7460;
	Mon, 20 Oct 2025 09:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PMoc3eH+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xpQ8z13t";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PMoc3eH+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xpQ8z13t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8092F9C39
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 09:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760953133; cv=none; b=siG/AgrbtWkiysOi8piiosiyCx/jyMaYqO1GX6Q3W/sS+R/8O3miR8ib5B0cIjt8wV3xIFW66Nv/dAg53mSH8rNSTKFD99U+TxlfwcaBDcUbsHqXYULvNo7tIBGhzUY9XuY1+WUDE3ee0NDY+IC0Cp3fTc19mffXmzUdFHUeuAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760953133; c=relaxed/simple;
	bh=ll+6a37NzmYY8oAciWn0Oz2O2lvs/XhA3GHdqVS4ZcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IuwD9lNo5g1FsWYMZT1V8gbBEbtmpi1oTEvOdgEaCdDkSTtR+3JJO6Yrkex+8+b3v5xJeHKQc5ExkI7iOaBPIG/z0Fck+X+roJYrHxA8++/wA8oWyYXhizTcadQXF9s85u8jHUpLXC8pmkMmlVd3P+12ZCsyNpZMiI+JJaqTO1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PMoc3eH+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xpQ8z13t; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PMoc3eH+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xpQ8z13t; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AD4221F391;
	Mon, 20 Oct 2025 09:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760953121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z9tk0MymbeEPEc97HmDnOdd6Tee2QpVHpskZDB00+A0=;
	b=PMoc3eH+z0ztx01o56U11wC8lTz9omQBMba625hKDZNzBzDX7ztNvE0i2ZWi3TaGaOjQr/
	ROyLSAUg8v5LUavcxE5TKsmbFta5xgosf7E6GElNpmU2EKM+I3Bqzj9wmsdhpgCmCJ2EN0
	euyZZbCiP8S1qGdwoNcHFFDKTJSxCvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760953121;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z9tk0MymbeEPEc97HmDnOdd6Tee2QpVHpskZDB00+A0=;
	b=xpQ8z13td4NPQPHGowYAyCUwVENEAuUpdgHT0rSgrmLtdLC09oj9Vi2Fzj/jWudLGWHxGt
	VXb5w+rH9mvAyaAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760953121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z9tk0MymbeEPEc97HmDnOdd6Tee2QpVHpskZDB00+A0=;
	b=PMoc3eH+z0ztx01o56U11wC8lTz9omQBMba625hKDZNzBzDX7ztNvE0i2ZWi3TaGaOjQr/
	ROyLSAUg8v5LUavcxE5TKsmbFta5xgosf7E6GElNpmU2EKM+I3Bqzj9wmsdhpgCmCJ2EN0
	euyZZbCiP8S1qGdwoNcHFFDKTJSxCvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760953121;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z9tk0MymbeEPEc97HmDnOdd6Tee2QpVHpskZDB00+A0=;
	b=xpQ8z13td4NPQPHGowYAyCUwVENEAuUpdgHT0rSgrmLtdLC09oj9Vi2Fzj/jWudLGWHxGt
	VXb5w+rH9mvAyaAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A000C13AAD;
	Mon, 20 Oct 2025 09:38:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3A4NJyED9mhjDwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 Oct 2025 09:38:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 55145A0856; Mon, 20 Oct 2025 11:38:41 +0200 (CEST)
Date: Mon, 20 Oct 2025 11:38:41 +0200
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
Subject: Re: [PATCH 08/13] vfs: make vfs_mknod break delegations on parent
 directory
Message-ID: <vuf6ypnlwgo6edemvtdhx3cpoufpr2iojbzqd4urocqjuoxj76@v7xwlpwnn77a>
References: <20251013-dir-deleg-ro-v1-0-406780a70e5e@kernel.org>
 <20251013-dir-deleg-ro-v1-8-406780a70e5e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013-dir-deleg-ro-v1-8-406780a70e5e@kernel.org>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.30

On Mon 13-10-25 10:48:06, Jeff Layton wrote:
> In order to add directory delegation support, we need to break
> delegations on the parent whenever there is going to be a change in the
> directory.
> 
> Add a new delegated_inode return pointer to vfs_mknod() and have the
> appropriate callers wait when there is an outstanding delegation. All
> other callers just set the pointer to NULL.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/base/devtmpfs.c  |  2 +-
>  fs/ecryptfs/inode.c      |  2 +-
>  fs/init.c                |  2 +-
>  fs/namei.c               | 25 +++++++++++++++++--------
>  fs/nfsd/vfs.c            |  2 +-
>  fs/overlayfs/overlayfs.h |  2 +-
>  include/linux/fs.h       |  4 ++--
>  net/unix/af_unix.c       |  2 +-
>  8 files changed, 25 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
> index 104025104ef75381984fd94dfbd50feeaa8cdd22..2f576ecf18324f767cd5ac6cbd28adbf9f46b958 100644
> --- a/drivers/base/devtmpfs.c
> +++ b/drivers/base/devtmpfs.c
> @@ -231,7 +231,7 @@ static int handle_create(const char *nodename, umode_t mode, kuid_t uid,
>  		return PTR_ERR(dentry);
>  
>  	err = vfs_mknod(&nop_mnt_idmap, d_inode(path.dentry), dentry, mode,
> -			dev->devt);
> +			dev->devt, NULL);
>  	if (!err) {
>  		struct iattr newattrs;
>  
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index 88631291b32535f623a3fbe4ea9b6ed48a306ca0..acef6d921167268d4590c688894d4522016db0dd 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -565,7 +565,7 @@ ecryptfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
>  	rc = lock_parent(dentry, &lower_dentry, &lower_dir);
>  	if (!rc)
>  		rc = vfs_mknod(&nop_mnt_idmap, lower_dir,
> -			       lower_dentry, mode, dev);
> +			       lower_dentry, mode, dev, NULL);
>  	if (rc || d_really_is_negative(lower_dentry))
>  		goto out;
>  	rc = ecryptfs_interpose(lower_dentry, dentry, dir->i_sb);
> diff --git a/fs/init.c b/fs/init.c
> index 895f8a09a71acfd03e11164e3b441a7d4e2de146..4f02260dd65b0dfcbfbf5812d2ec6a33444a3b1f 100644
> --- a/fs/init.c
> +++ b/fs/init.c
> @@ -157,7 +157,7 @@ int __init init_mknod(const char *filename, umode_t mode, unsigned int dev)
>  	error = security_path_mknod(&path, dentry, mode, dev);
>  	if (!error)
>  		error = vfs_mknod(mnt_idmap(path.mnt), path.dentry->d_inode,
> -				  dentry, mode, new_decode_dev(dev));
> +				  dentry, mode, new_decode_dev(dev), NULL);
>  	end_creating_path(&path, dentry);
>  	return error;
>  }
> diff --git a/fs/namei.c b/fs/namei.c
> index 1427c53e13978e70adefdc572b71247536985430..2e1e3f0068a28271e07aa0fa0c7e0b04582400fe 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4302,13 +4302,15 @@ inline struct dentry *start_creating_user_path(
>  }
>  EXPORT_SYMBOL(start_creating_user_path);
>  
> +
>  /**
>   * vfs_mknod - create device node or file
> - * @idmap:	idmap of the mount the inode was found from
> - * @dir:	inode of the parent directory
> - * @dentry:	dentry of the child device node
> - * @mode:	mode of the child device node
> - * @dev:	device number of device to create
> + * @idmap:		idmap of the mount the inode was found from
> + * @dir:		inode of the parent directory
> + * @dentry:		dentry of the child device node
> + * @mode:		mode of the child device node
> + * @dev:		device number of device to create
> + * @delegated_inode:	returns parent inode, if the inode is delegated.
>   *
>   * Create a device node or file.
>   *
> @@ -4319,7 +4321,8 @@ EXPORT_SYMBOL(start_creating_user_path);
>   * raw inode simply pass @nop_mnt_idmap.
>   */
>  int vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
> -	      struct dentry *dentry, umode_t mode, dev_t dev)
> +	      struct dentry *dentry, umode_t mode, dev_t dev,
> +	      struct inode **delegated_inode)
>  {
>  	bool is_whiteout = S_ISCHR(mode) && dev == WHITEOUT_DEV;
>  	int error = may_create(idmap, dir, dentry);
> @@ -4343,6 +4346,10 @@ int vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
>  	if (error)
>  		return error;
>  
> +	error = try_break_deleg(dir, delegated_inode);
> +	if (error)
> +		return error;
> +
>  	error = dir->i_op->mknod(idmap, dir, dentry, mode, dev);
>  	if (!error)
>  		fsnotify_create(dir, dentry);
> @@ -4402,11 +4409,13 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
>  			break;
>  		case S_IFCHR: case S_IFBLK:
>  			error = vfs_mknod(idmap, path.dentry->d_inode,
> -					  dentry, mode, new_decode_dev(dev));
> +					  dentry, mode, new_decode_dev(dev),
> +					  &delegated_inode);
>  			break;
>  		case S_IFIFO: case S_IFSOCK:
>  			error = vfs_mknod(idmap, path.dentry->d_inode,
> -					  dentry, mode, 0);
> +					  dentry, mode, 0,
> +					  &delegated_inode);
>  			break;
>  	}
>  out2:
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 7d8cd2595f197be9741ee6320d43ed6651896647..858485c76b6524e965b7cbc92f67c1a4eb19e34e 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1660,7 +1660,7 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	case S_IFIFO:
>  	case S_IFSOCK:
>  		host_err = vfs_mknod(&nop_mnt_idmap, dirp, dchild,
> -				     iap->ia_mode, rdev);
> +				     iap->ia_mode, rdev, NULL);
>  		break;
>  	default:
>  		printk(KERN_WARNING "nfsd: bad file type %o in nfsd_create\n",
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index d215d7349489686b66bb66e939b27046f7d836f6..8b8c99e9e1a518c365cfff952d391887ec18d453 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -257,7 +257,7 @@ static inline int ovl_do_mknod(struct ovl_fs *ofs,
>  			       struct inode *dir, struct dentry *dentry,
>  			       umode_t mode, dev_t dev)
>  {
> -	int err = vfs_mknod(ovl_upper_mnt_idmap(ofs), dir, dentry, mode, dev);
> +	int err = vfs_mknod(ovl_upper_mnt_idmap(ofs), dir, dentry, mode, dev, NULL);
>  
>  	pr_debug("mknod(%pd2, 0%o, 0%o) = %i\n", dentry, mode, dev, err);
>  	return err;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index d8bdaf7c87502ff17775602f5391d375738b4ed8..4ad49b39441b2c9088fd01a7e0e46a6511c26d2e 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2115,7 +2115,7 @@ int vfs_create(struct mnt_idmap *, struct inode *,
>  struct dentry *vfs_mkdir(struct mnt_idmap *, struct inode *,
>  			 struct dentry *, umode_t, struct inode **);
>  int vfs_mknod(struct mnt_idmap *, struct inode *, struct dentry *,
> -              umode_t, dev_t);
> +	      umode_t, dev_t, struct inode **);
>  int vfs_symlink(struct mnt_idmap *, struct inode *,
>  		struct dentry *, const char *);
>  int vfs_link(struct dentry *, struct mnt_idmap *, struct inode *,
> @@ -2151,7 +2151,7 @@ static inline int vfs_whiteout(struct mnt_idmap *idmap,
>  			       struct inode *dir, struct dentry *dentry)
>  {
>  	return vfs_mknod(idmap, dir, dentry, S_IFCHR | WHITEOUT_MODE,
> -			 WHITEOUT_DEV);
> +			 WHITEOUT_DEV, NULL);
>  }
>  
>  struct file *kernel_tmpfile_open(struct mnt_idmap *idmap,
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 768098dec2310008632558ae928703b37c3cc8ef..db1fd8d6a84c2c7c0d45b43d9c5a936b3d491b7b 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -1399,7 +1399,7 @@ static int unix_bind_bsd(struct sock *sk, struct sockaddr_un *sunaddr,
>  	idmap = mnt_idmap(parent.mnt);
>  	err = security_path_mknod(&parent, dentry, mode, 0);
>  	if (!err)
> -		err = vfs_mknod(idmap, d_inode(parent.dentry), dentry, mode, 0);
> +		err = vfs_mknod(idmap, d_inode(parent.dentry), dentry, mode, 0, NULL);
>  	if (err)
>  		goto out_path;
>  	err = mutex_lock_interruptible(&u->bindlock);
> 
> -- 
> 2.51.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

