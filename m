Return-Path: <linux-fsdevel+bounces-67902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C780CC4D212
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 11:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 818453B0173
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 10:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17A92F83C2;
	Tue, 11 Nov 2025 10:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ABmQSe0O";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jkz/qW7s";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VntBozyr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="T2bebI6e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5388134EF04
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 10:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762857462; cv=none; b=pcl5we6wIfTr4CXB/BME66icoL4yGFawwxW2X5tskfFpIQ+/jYD1vNgsSYyh0XdJ2uvODBE0MWGtz01xyAHqb+xEJ0rste0l9xlvud3HCG8R+scEwg7TzunJrgGOwNGYPjFCrb2MWZzZslXsDF0e2dmcnN5RyURJJBSYzQCMLVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762857462; c=relaxed/simple;
	bh=hyNCHdMdIEMpcB1iHJpcmtHhO0cY+NOEEI3eHb/ZxTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljXIu7FvoHVYB37HjCYaOk9g5mVxQr7HVf6JoyOZ+UPp3a3EmcRYctBnRD2laWJyH63TepGZVHb7N3vxxBPLfJgE9Qy4uVIGeFjCfEBZ5+wDmfLE8dGks4rbm2lKkxwx7/nQpOn3Vq4ApK/yrJjoCXc//PkjZqgTURN05lkUL2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ABmQSe0O; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jkz/qW7s; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VntBozyr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=T2bebI6e; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E1E551F750;
	Tue, 11 Nov 2025 10:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762857457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TEc5BMTgakLjP2lCVtIyTqJLSeq6a+T/g0/3T6sOX5U=;
	b=ABmQSe0O1DSmwu4YW8RIxEoGNBGD+4SQhQzJNFk7ZIK/wi1vrlGnLIPVriMj95Ui3+p9mx
	Yd9UGrSajO0qV2Bht3YikO09LuHTEssfjHksnNrnqdIMybRvVPBE2k7viEu7oL10CxU7Wp
	zZEbIsiQ2mLyhAEHZgq5Jy4hmevTtak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762857457;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TEc5BMTgakLjP2lCVtIyTqJLSeq6a+T/g0/3T6sOX5U=;
	b=jkz/qW7s9eoNvg0Y9NyoTKRl1CvNA7QZbsZl15s/0xIal0ZkL87Xv+ZpSBJWNabgCS/cBA
	sSwA+bE4gBgZFbCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=VntBozyr;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=T2bebI6e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762857456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TEc5BMTgakLjP2lCVtIyTqJLSeq6a+T/g0/3T6sOX5U=;
	b=VntBozyrZOAwKMhMIiNgxjR0KRGEpKVeRCJN7GjFlWWR3GAVTLaBB12PQhXoalsSNvR29T
	eJAe4uA/CLjC/RkCVPY1m/Z0HuNeRSv2ONIkwfnmCBZ7yfZsVyA36iQF4JOwCbXzwqXCJV
	4rlGyoMFfgMKp2cuB4/q0PLoHrmRCrY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762857456;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TEc5BMTgakLjP2lCVtIyTqJLSeq6a+T/g0/3T6sOX5U=;
	b=T2bebI6e2BNXdytzddpspO6C6YUZ4uUPoYnCUJiePajNoGohIT8FiWbGYBMGrmJPUekWob
	EW3tQuc1bsO/icAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF8A1148F0;
	Tue, 11 Nov 2025 10:37:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IuCoMvARE2kbNQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 11 Nov 2025 10:37:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8D536A28C8; Tue, 11 Nov 2025 11:37:36 +0100 (CET)
Date: Tue, 11 Nov 2025 11:37:36 +0100
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
	netdev@vger.kernel.org, NeilBrown <neilb@ownmail.net>
Subject: Re: [PATCH v5 09/17] vfs: clean up argument list for vfs_create()
Message-ID: <g3si4zuuhxleat2gkebyhnokq5eiymatgi36ad25datcbvinfs@nsk4fop6sz5f>
References: <20251105-dir-deleg-ro-v5-0-7ebc168a88ac@kernel.org>
 <20251105-dir-deleg-ro-v5-9-7ebc168a88ac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105-dir-deleg-ro-v5-9-7ebc168a88ac@kernel.org>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: E1E551F750
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[45];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,ownmail.net];
	FREEMAIL_CC(0.00)[szeredi.hu,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,samba.org,manguebit.org,microsoft.com,talpey.com,linuxfoundation.org,redhat.com,tyhicks.com,brown.name,chromium.org,google.com,davemloft.net,vger.kernel.org,lists.samba.org,lists.linux.dev,ownmail.net];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TAGGED_RCPT(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLpnapcpkwxdkc5mopt1ezhhna)];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -2.51

On Wed 05-11-25 11:53:55, Jeff Layton wrote:
> As Neil points out:
> 
> "I would be in favour of dropping the "dir" arg because it is always
> d_inode(dentry->d_parent) which is stable."
> 
> ...and...
> 
> "Also *every* caller of vfs_create() passes ".excl = true".  So maybe we
> don't need that arg at all."
> 
> Drop both arguments from vfs_create() and fix up the callers.
> 
> Suggested-by: NeilBrown <neilb@ownmail.net>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ecryptfs/inode.c      |  3 +--
>  fs/namei.c               | 11 ++++-------
>  fs/nfsd/nfs3proc.c       |  2 +-
>  fs/nfsd/vfs.c            |  3 +--
>  fs/open.c                |  4 +---
>  fs/overlayfs/overlayfs.h |  2 +-
>  fs/smb/server/vfs.c      |  3 +--
>  include/linux/fs.h       |  3 +--
>  8 files changed, 11 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index 88631291b32535f623a3fbe4ea9b6ed48a306ca0..d109e3763a88150bfe64cd2d5564dc9802ef3386 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -188,8 +188,7 @@ ecryptfs_do_create(struct inode *directory_inode,
>  
>  	rc = lock_parent(ecryptfs_dentry, &lower_dentry, &lower_dir);
>  	if (!rc)
> -		rc = vfs_create(&nop_mnt_idmap, lower_dir,
> -				lower_dentry, mode, true);
> +		rc = vfs_create(&nop_mnt_idmap, lower_dentry, mode);
>  	if (rc) {
>  		printk(KERN_ERR "%s: Failure to create dentry in lower fs; "
>  		       "rc = [%d]\n", __func__, rc);
> diff --git a/fs/namei.c b/fs/namei.c
> index f439429bdfa271ccc64c937771ef4175597feb53..9586c6aba6eae05a9fc3c103b8501d98767bef53 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3461,10 +3461,8 @@ static inline umode_t vfs_prepare_mode(struct mnt_idmap *idmap,
>  /**
>   * vfs_create - create new file
>   * @idmap:	idmap of the mount the inode was found from
> - * @dir:	inode of the parent directory
>   * @dentry:	dentry of the child file
>   * @mode:	mode of the child file
> - * @want_excl:	whether the file must not yet exist
>   *
>   * Create a new file.
>   *
> @@ -3474,9 +3472,9 @@ static inline umode_t vfs_prepare_mode(struct mnt_idmap *idmap,
>   * On non-idmapped mounts or if permission checking is to be performed on the
>   * raw inode simply pass @nop_mnt_idmap.
>   */
> -int vfs_create(struct mnt_idmap *idmap, struct inode *dir,
> -	       struct dentry *dentry, umode_t mode, bool want_excl)
> +int vfs_create(struct mnt_idmap *idmap, struct dentry *dentry, umode_t mode)
>  {
> +	struct inode *dir = d_inode(dentry->d_parent);
>  	int error;
>  
>  	error = may_create(idmap, dir, dentry);
> @@ -3490,7 +3488,7 @@ int vfs_create(struct mnt_idmap *idmap, struct inode *dir,
>  	error = security_inode_create(dir, dentry, mode);
>  	if (error)
>  		return error;
> -	error = dir->i_op->create(idmap, dir, dentry, mode, want_excl);
> +	error = dir->i_op->create(idmap, dir, dentry, mode, true);
>  	if (!error)
>  		fsnotify_create(dir, dentry);
>  	return error;
> @@ -4383,8 +4381,7 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
>  	idmap = mnt_idmap(path.mnt);
>  	switch (mode & S_IFMT) {
>  		case 0: case S_IFREG:
> -			error = vfs_create(idmap, path.dentry->d_inode,
> -					   dentry, mode, true);
> +			error = vfs_create(idmap, dentry, mode);
>  			if (!error)
>  				security_path_post_mknod(idmap, dentry);
>  			break;
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index b6d03e1ef5f7a5e8dd111b0d56c061f1e91abff7..30ea7ffa2affdb9a959b0fd15a630de056d6dc3c 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -344,7 +344,7 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	status = fh_fill_pre_attrs(fhp);
>  	if (status != nfs_ok)
>  		goto out;
> -	host_err = vfs_create(&nop_mnt_idmap, inode, child, iap->ia_mode, true);
> +	host_err = vfs_create(&nop_mnt_idmap, child, iap->ia_mode);
>  	if (host_err < 0) {
>  		status = nfserrno(host_err);
>  		goto out;
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index c400ea94ff2e837fd59719bf2c4b79ef1d064743..464fd54675f3b16fce9ae5f05ad22e0e6b363eb3 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1552,8 +1552,7 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	err = 0;
>  	switch (type) {
>  	case S_IFREG:
> -		host_err = vfs_create(&nop_mnt_idmap, dirp, dchild,
> -				      iap->ia_mode, true);
> +		host_err = vfs_create(&nop_mnt_idmap, dchild, iap->ia_mode);
>  		if (!host_err)
>  			nfsd_check_ignore_resizing(iap);
>  		break;
> diff --git a/fs/open.c b/fs/open.c
> index fdaa6f08f6f4cac5c2fefd3eafa5e430e51f3979..e440f58e3ce81e137aabdf00510d839342a19219 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -1171,9 +1171,7 @@ struct file *dentry_create(const struct path *path, int flags, umode_t mode,
>  	if (IS_ERR(f))
>  		return f;
>  
> -	error = vfs_create(mnt_idmap(path->mnt),
> -			   d_inode(path->dentry->d_parent),
> -			   path->dentry, mode, true);
> +	error = vfs_create(mnt_idmap(path->mnt), path->dentry, mode);
>  	if (!error)
>  		error = vfs_open(path, f);
>  
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index d215d7349489686b66bb66e939b27046f7d836f6..2bdc434941ebc70f6d4f57cca4f68125112a7bc4 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -235,7 +235,7 @@ static inline int ovl_do_create(struct ovl_fs *ofs,
>  				struct inode *dir, struct dentry *dentry,
>  				umode_t mode)
>  {
> -	int err = vfs_create(ovl_upper_mnt_idmap(ofs), dir, dentry, mode, true);
> +	int err = vfs_create(ovl_upper_mnt_idmap(ofs), dentry, mode);
>  
>  	pr_debug("create(%pd2, 0%o) = %i\n", dentry, mode, err);
>  	return err;
> diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
> index c5f0f3170d586cb2dc4d416b80948c642797fb82..83ece2de4b23bf9209137e7ca414a72439b5cc2e 100644
> --- a/fs/smb/server/vfs.c
> +++ b/fs/smb/server/vfs.c
> @@ -188,8 +188,7 @@ int ksmbd_vfs_create(struct ksmbd_work *work, const char *name, umode_t mode)
>  	}
>  
>  	mode |= S_IFREG;
> -	err = vfs_create(mnt_idmap(path.mnt), d_inode(path.dentry),
> -			 dentry, mode, true);
> +	err = vfs_create(mnt_idmap(path.mnt), dentry, mode);
>  	if (!err) {
>  		ksmbd_vfs_inherit_owner(work, d_inode(path.dentry),
>  					d_inode(dentry));
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 12873214e1c7811735ea5d2dee3d57e2a5604d8f..21876ef1fec90181b9878372c7c7e710773aae9f 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2111,8 +2111,7 @@ bool inode_owner_or_capable(struct mnt_idmap *idmap,
>  /*
>   * VFS helper functions..
>   */
> -int vfs_create(struct mnt_idmap *, struct inode *,
> -	       struct dentry *, umode_t, bool);
> +int vfs_create(struct mnt_idmap *, struct dentry *, umode_t);
>  struct dentry *vfs_mkdir(struct mnt_idmap *, struct inode *,
>  			 struct dentry *, umode_t, struct delegated_inode *);
>  int vfs_mknod(struct mnt_idmap *, struct inode *, struct dentry *,
> 
> -- 
> 2.51.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

