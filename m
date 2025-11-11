Return-Path: <linux-fsdevel+bounces-67909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EF984C4D441
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 12:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 73545342935
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 11:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFCF355022;
	Tue, 11 Nov 2025 11:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R/SF8wuf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tyvCvYZ5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R/SF8wuf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tyvCvYZ5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AD5354AC2
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 11:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858895; cv=none; b=Ou63LZfFY169+Jok1neGlEjX31dtIu6puMLDQFizGELhLUscR2ROjVWxG0Ivgt/FXHss9WDCSxxlq8OIOY+5UD263zljGMK0vydYTZlpPYJRztt0vXI1+qvc+q1reMAFmzFtx1OzaJ23lRO15cIG6vi14W6543bvA7cy2YnpRYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858895; c=relaxed/simple;
	bh=eurXhqdivXv0KRTmNXzmarIKKNOuugWm8/37QAkMAko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oC5NK3Bibs6UHnFn5VvSnFCLuEecOkqRpmcoQb249tupQAqj0EAPvk5K75FkhANhXIxPlC0BNp8A1f8grLsD7nFpt+ps1mzZ8W5Mk3lZaxi5y6xTbUqCY1cwJCgycpdWOIk/AdE59/4hIyrsiWissKLprAsomXU5oD6Z5b1pr4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R/SF8wuf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tyvCvYZ5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R/SF8wuf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tyvCvYZ5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 840CF1F750;
	Tue, 11 Nov 2025 11:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762858890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q0xIfy6Adj2vTJvQP9AjqPtLnU8M8pTVdFLFRqnVOck=;
	b=R/SF8wufIMyxCRQr4XMRcIxPtTJeWN2jnT9iLxCdg/V+eDziZBN6hCl06KqUhNn272vyuI
	8i2m+KVM9wdnlof/wSdKV25BWTPJRNtPTyiOXlCFabklKSfrlBEwwas85EZbmVNiwtU7ro
	pMSyBDpTpus7je5SUgz6CQ2xYjS/dHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762858890;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q0xIfy6Adj2vTJvQP9AjqPtLnU8M8pTVdFLFRqnVOck=;
	b=tyvCvYZ5PrB6TX5lw4ufWg3PufNnXuFh1izpDbnSfRJg9PYA3PHucLiBWkGoowB3vb7+Da
	X5mmdK0p2foU7MBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762858890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q0xIfy6Adj2vTJvQP9AjqPtLnU8M8pTVdFLFRqnVOck=;
	b=R/SF8wufIMyxCRQr4XMRcIxPtTJeWN2jnT9iLxCdg/V+eDziZBN6hCl06KqUhNn272vyuI
	8i2m+KVM9wdnlof/wSdKV25BWTPJRNtPTyiOXlCFabklKSfrlBEwwas85EZbmVNiwtU7ro
	pMSyBDpTpus7je5SUgz6CQ2xYjS/dHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762858890;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q0xIfy6Adj2vTJvQP9AjqPtLnU8M8pTVdFLFRqnVOck=;
	b=tyvCvYZ5PrB6TX5lw4ufWg3PufNnXuFh1izpDbnSfRJg9PYA3PHucLiBWkGoowB3vb7+Da
	X5mmdK0p2foU7MBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 625B714908;
	Tue, 11 Nov 2025 11:01:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ys/+F4oXE2lQTQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 11 Nov 2025 11:01:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E492CA28C8; Tue, 11 Nov 2025 12:01:29 +0100 (CET)
Date: Tue, 11 Nov 2025 12:01:29 +0100
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
Subject: Re: [PATCH v5 03/17] filelock: add struct delegated_inode
Message-ID: <xzmaeyzqevtqmtt2nppyjmj6k7qdiu66wxytjr2hiolesxwzyb@7vz6zvpz32ob>
References: <20251105-dir-deleg-ro-v5-0-7ebc168a88ac@kernel.org>
 <20251105-dir-deleg-ro-v5-3-7ebc168a88ac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105-dir-deleg-ro-v5-3-7ebc168a88ac@kernel.org>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[44];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[szeredi.hu,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,samba.org,manguebit.org,microsoft.com,talpey.com,linuxfoundation.org,redhat.com,tyhicks.com,brown.name,chromium.org,google.com,davemloft.net,vger.kernel.org,lists.samba.org,lists.linux.dev];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL63fqwwx8ot6gmekemcs76f9d)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 

On Wed 05-11-25 11:53:49, Jeff Layton wrote:
> The current API requires a pointer to an inode pointer. It's easy for
> callers to get this wrong. Add a new delegated_inode structure and use
> that to pass back any inode that needs to be waited on.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

I didn't find anything particularly problematic with struct inode ** but I
agree this seems a tad bit cleaner and harder to get wrong. So feel free to
add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/attr.c                |  2 +-
>  fs/namei.c               | 18 +++++++++---------
>  fs/open.c                |  8 ++++----
>  fs/posix_acl.c           |  8 ++++----
>  fs/utimes.c              |  4 ++--
>  fs/xattr.c               | 12 ++++++------
>  include/linux/filelock.h | 36 +++++++++++++++++++++++++++---------
>  include/linux/fs.h       |  9 +++++----
>  include/linux/xattr.h    |  4 ++--
>  9 files changed, 60 insertions(+), 41 deletions(-)
> 
> diff --git a/fs/attr.c b/fs/attr.c
> index 795f231d00e8eaaadf5b62f241655cb4b69cb507..b9ec6b47bab2fc2b561677b639633bd32994022f 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -415,7 +415,7 @@ EXPORT_SYMBOL(may_setattr);
>   * performed on the raw inode simply pass @nop_mnt_idmap.
>   */
>  int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
> -		  struct iattr *attr, struct inode **delegated_inode)
> +		  struct iattr *attr, struct delegated_inode *delegated_inode)
>  {
>  	struct inode *inode = dentry->d_inode;
>  	umode_t mode = inode->i_mode;
> diff --git a/fs/namei.c b/fs/namei.c
> index 7377020a2cba02501483020e0fc93c279fb38d3e..bf42f146f847a5330fc581595c7256af28d9db90 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4648,7 +4648,7 @@ SYSCALL_DEFINE1(rmdir, const char __user *, pathname)
>   * raw inode simply pass @nop_mnt_idmap.
>   */
>  int vfs_unlink(struct mnt_idmap *idmap, struct inode *dir,
> -	       struct dentry *dentry, struct inode **delegated_inode)
> +	       struct dentry *dentry, struct delegated_inode *delegated_inode)
>  {
>  	struct inode *target = dentry->d_inode;
>  	int error = may_delete(idmap, dir, dentry, 0);
> @@ -4706,7 +4706,7 @@ int do_unlinkat(int dfd, struct filename *name)
>  	struct qstr last;
>  	int type;
>  	struct inode *inode = NULL;
> -	struct inode *delegated_inode = NULL;
> +	struct delegated_inode delegated_inode = { };
>  	unsigned int lookup_flags = 0;
>  retry:
>  	error = filename_parentat(dfd, name, lookup_flags, &path, &last, &type);
> @@ -4743,7 +4743,7 @@ int do_unlinkat(int dfd, struct filename *name)
>  	if (inode)
>  		iput(inode);	/* truncate the inode here */
>  	inode = NULL;
> -	if (delegated_inode) {
> +	if (is_delegated(&delegated_inode)) {
>  		error = break_deleg_wait(&delegated_inode);
>  		if (!error)
>  			goto retry_deleg;
> @@ -4892,7 +4892,7 @@ SYSCALL_DEFINE2(symlink, const char __user *, oldname, const char __user *, newn
>   */
>  int vfs_link(struct dentry *old_dentry, struct mnt_idmap *idmap,
>  	     struct inode *dir, struct dentry *new_dentry,
> -	     struct inode **delegated_inode)
> +	     struct delegated_inode *delegated_inode)
>  {
>  	struct inode *inode = old_dentry->d_inode;
>  	unsigned max_links = dir->i_sb->s_max_links;
> @@ -4968,7 +4968,7 @@ int do_linkat(int olddfd, struct filename *old, int newdfd,
>  	struct mnt_idmap *idmap;
>  	struct dentry *new_dentry;
>  	struct path old_path, new_path;
> -	struct inode *delegated_inode = NULL;
> +	struct delegated_inode delegated_inode = { };
>  	int how = 0;
>  	int error;
>  
> @@ -5012,7 +5012,7 @@ int do_linkat(int olddfd, struct filename *old, int newdfd,
>  			 new_dentry, &delegated_inode);
>  out_dput:
>  	end_creating_path(&new_path, new_dentry);
> -	if (delegated_inode) {
> +	if (is_delegated(&delegated_inode)) {
>  		error = break_deleg_wait(&delegated_inode);
>  		if (!error) {
>  			path_put(&old_path);
> @@ -5098,7 +5098,7 @@ int vfs_rename(struct renamedata *rd)
>  	struct inode *new_dir = d_inode(rd->new_parent);
>  	struct dentry *old_dentry = rd->old_dentry;
>  	struct dentry *new_dentry = rd->new_dentry;
> -	struct inode **delegated_inode = rd->delegated_inode;
> +	struct delegated_inode *delegated_inode = rd->delegated_inode;
>  	unsigned int flags = rd->flags;
>  	bool is_dir = d_is_dir(old_dentry);
>  	struct inode *source = old_dentry->d_inode;
> @@ -5261,7 +5261,7 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
>  	struct path old_path, new_path;
>  	struct qstr old_last, new_last;
>  	int old_type, new_type;
> -	struct inode *delegated_inode = NULL;
> +	struct delegated_inode delegated_inode = { };
>  	unsigned int lookup_flags = 0, target_flags =
>  		LOOKUP_RENAME_TARGET | LOOKUP_CREATE;
>  	bool should_retry = false;
> @@ -5369,7 +5369,7 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
>  exit3:
>  	unlock_rename(new_path.dentry, old_path.dentry);
>  exit_lock_rename:
> -	if (delegated_inode) {
> +	if (is_delegated(&delegated_inode)) {
>  		error = break_deleg_wait(&delegated_inode);
>  		if (!error)
>  			goto retry_deleg;
> diff --git a/fs/open.c b/fs/open.c
> index 3d64372ecc675e4795eb0a0deda10f8f67b95640..fdaa6f08f6f4cac5c2fefd3eafa5e430e51f3979 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -631,7 +631,7 @@ SYSCALL_DEFINE1(chroot, const char __user *, filename)
>  int chmod_common(const struct path *path, umode_t mode)
>  {
>  	struct inode *inode = path->dentry->d_inode;
> -	struct inode *delegated_inode = NULL;
> +	struct delegated_inode delegated_inode = { };
>  	struct iattr newattrs;
>  	int error;
>  
> @@ -651,7 +651,7 @@ int chmod_common(const struct path *path, umode_t mode)
>  			      &newattrs, &delegated_inode);
>  out_unlock:
>  	inode_unlock(inode);
> -	if (delegated_inode) {
> +	if (is_delegated(&delegated_inode)) {
>  		error = break_deleg_wait(&delegated_inode);
>  		if (!error)
>  			goto retry_deleg;
> @@ -756,7 +756,7 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
>  	struct mnt_idmap *idmap;
>  	struct user_namespace *fs_userns;
>  	struct inode *inode = path->dentry->d_inode;
> -	struct inode *delegated_inode = NULL;
> +	struct delegated_inode delegated_inode = { };
>  	int error;
>  	struct iattr newattrs;
>  	kuid_t uid;
> @@ -791,7 +791,7 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
>  		error = notify_change(idmap, path->dentry, &newattrs,
>  				      &delegated_inode);
>  	inode_unlock(inode);
> -	if (delegated_inode) {
> +	if (is_delegated(&delegated_inode)) {
>  		error = break_deleg_wait(&delegated_inode);
>  		if (!error)
>  			goto retry_deleg;
> diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> index 4050942ab52f95741da2df13d191ade5c5ca12a2..768f027c142811ea907fe8545155ba7abd016305 100644
> --- a/fs/posix_acl.c
> +++ b/fs/posix_acl.c
> @@ -1091,7 +1091,7 @@ int vfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
>  	int acl_type;
>  	int error;
>  	struct inode *inode = d_inode(dentry);
> -	struct inode *delegated_inode = NULL;
> +	struct delegated_inode delegated_inode = { };
>  
>  	acl_type = posix_acl_type(acl_name);
>  	if (acl_type < 0)
> @@ -1141,7 +1141,7 @@ int vfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
>  out_inode_unlock:
>  	inode_unlock(inode);
>  
> -	if (delegated_inode) {
> +	if (is_delegated(&delegated_inode)) {
>  		error = break_deleg_wait(&delegated_inode);
>  		if (!error)
>  			goto retry_deleg;
> @@ -1212,7 +1212,7 @@ int vfs_remove_acl(struct mnt_idmap *idmap, struct dentry *dentry,
>  	int acl_type;
>  	int error;
>  	struct inode *inode = d_inode(dentry);
> -	struct inode *delegated_inode = NULL;
> +	struct delegated_inode delegated_inode = { };
>  
>  	acl_type = posix_acl_type(acl_name);
>  	if (acl_type < 0)
> @@ -1249,7 +1249,7 @@ int vfs_remove_acl(struct mnt_idmap *idmap, struct dentry *dentry,
>  out_inode_unlock:
>  	inode_unlock(inode);
>  
> -	if (delegated_inode) {
> +	if (is_delegated(&delegated_inode)) {
>  		error = break_deleg_wait(&delegated_inode);
>  		if (!error)
>  			goto retry_deleg;
> diff --git a/fs/utimes.c b/fs/utimes.c
> index c7c7958e57b22f91646ca9f76d18781b64d371a3..bf9f45bdef54947de7ac55c9f873ae9d0336dafa 100644
> --- a/fs/utimes.c
> +++ b/fs/utimes.c
> @@ -22,7 +22,7 @@ int vfs_utimes(const struct path *path, struct timespec64 *times)
>  	int error;
>  	struct iattr newattrs;
>  	struct inode *inode = path->dentry->d_inode;
> -	struct inode *delegated_inode = NULL;
> +	struct delegated_inode delegated_inode = { };
>  
>  	if (times) {
>  		if (!nsec_valid(times[0].tv_nsec) ||
> @@ -66,7 +66,7 @@ int vfs_utimes(const struct path *path, struct timespec64 *times)
>  	error = notify_change(mnt_idmap(path->mnt), path->dentry, &newattrs,
>  			      &delegated_inode);
>  	inode_unlock(inode);
> -	if (delegated_inode) {
> +	if (is_delegated(&delegated_inode)) {
>  		error = break_deleg_wait(&delegated_inode);
>  		if (!error)
>  			goto retry_deleg;
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 8851a5ef34f5ab34383975dd4cef537de3f6391e..32d445fb60aaf2aaf4b16b62934dc99bad378067 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -274,7 +274,7 @@ int __vfs_setxattr_noperm(struct mnt_idmap *idmap,
>  int
>  __vfs_setxattr_locked(struct mnt_idmap *idmap, struct dentry *dentry,
>  		      const char *name, const void *value, size_t size,
> -		      int flags, struct inode **delegated_inode)
> +		      int flags, struct delegated_inode *delegated_inode)
>  {
>  	struct inode *inode = dentry->d_inode;
>  	int error;
> @@ -305,7 +305,7 @@ vfs_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  	     const char *name, const void *value, size_t size, int flags)
>  {
>  	struct inode *inode = dentry->d_inode;
> -	struct inode *delegated_inode = NULL;
> +	struct delegated_inode delegated_inode = { };
>  	const void  *orig_value = value;
>  	int error;
>  
> @@ -322,7 +322,7 @@ vfs_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  				      flags, &delegated_inode);
>  	inode_unlock(inode);
>  
> -	if (delegated_inode) {
> +	if (is_delegated(&delegated_inode)) {
>  		error = break_deleg_wait(&delegated_inode);
>  		if (!error)
>  			goto retry_deleg;
> @@ -533,7 +533,7 @@ EXPORT_SYMBOL(__vfs_removexattr);
>  int
>  __vfs_removexattr_locked(struct mnt_idmap *idmap,
>  			 struct dentry *dentry, const char *name,
> -			 struct inode **delegated_inode)
> +			 struct delegated_inode *delegated_inode)
>  {
>  	struct inode *inode = dentry->d_inode;
>  	int error;
> @@ -567,7 +567,7 @@ vfs_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  		const char *name)
>  {
>  	struct inode *inode = dentry->d_inode;
> -	struct inode *delegated_inode = NULL;
> +	struct delegated_inode delegated_inode = { };
>  	int error;
>  
>  retry_deleg:
> @@ -576,7 +576,7 @@ vfs_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  					 name, &delegated_inode);
>  	inode_unlock(inode);
>  
> -	if (delegated_inode) {
> +	if (is_delegated(&delegated_inode)) {
>  		error = break_deleg_wait(&delegated_inode);
>  		if (!error)
>  			goto retry_deleg;
> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
> index 47da6aa28d8dc9122618d02c6608deda0f3c4d3e..208d108df2d73a9df65e5dc9968d074af385f881 100644
> --- a/include/linux/filelock.h
> +++ b/include/linux/filelock.h
> @@ -486,25 +486,35 @@ static inline int break_deleg(struct inode *inode, unsigned int flags)
>  	return 0;
>  }
>  
> -static inline int try_break_deleg(struct inode *inode, struct inode **delegated_inode)
> +struct delegated_inode {
> +	struct inode *di_inode;
> +};
> +
> +static inline bool is_delegated(struct delegated_inode *di)
> +{
> +	return di->di_inode;
> +}
> +
> +static inline int try_break_deleg(struct inode *inode,
> +				  struct delegated_inode *di)
>  {
>  	int ret;
>  
>  	ret = break_deleg(inode, LEASE_BREAK_NONBLOCK);
> -	if (ret == -EWOULDBLOCK && delegated_inode) {
> -		*delegated_inode = inode;
> +	if (ret == -EWOULDBLOCK && di) {
> +		di->di_inode = inode;
>  		ihold(inode);
>  	}
>  	return ret;
>  }
>  
> -static inline int break_deleg_wait(struct inode **delegated_inode)
> +static inline int break_deleg_wait(struct delegated_inode *di)
>  {
>  	int ret;
>  
> -	ret = break_deleg(*delegated_inode, 0);
> -	iput(*delegated_inode);
> -	*delegated_inode = NULL;
> +	ret = break_deleg(di->di_inode, 0);
> +	iput(di->di_inode);
> +	di->di_inode = NULL;
>  	return ret;
>  }
>  
> @@ -523,6 +533,13 @@ static inline int break_layout(struct inode *inode, bool wait)
>  }
>  
>  #else /* !CONFIG_FILE_LOCKING */
> +struct delegated_inode { };
> +
> +static inline bool is_delegated(struct delegated_inode *di)
> +{
> +	return false;
> +}
> +
>  static inline int break_lease(struct inode *inode, bool wait)
>  {
>  	return 0;
> @@ -533,12 +550,13 @@ static inline int break_deleg(struct inode *inode, unsigned int flags)
>  	return 0;
>  }
>  
> -static inline int try_break_deleg(struct inode *inode, struct inode **delegated_inode)
> +static inline int try_break_deleg(struct inode *inode,
> +				  struct delegated_inode *delegated_inode)
>  {
>  	return 0;
>  }
>  
> -static inline int break_deleg_wait(struct inode **delegated_inode)
> +static inline int break_deleg_wait(struct delegated_inode *delegated_inode)
>  {
>  	BUG();
>  	return 0;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c895146c1444be36e0a779df55622cc38c9419ff..909a88e3979d4f1ba3104f3d05145e1096ed44d5 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -80,6 +80,7 @@ struct fs_context;
>  struct fs_parameter_spec;
>  struct file_kattr;
>  struct iomap_ops;
> +struct delegated_inode;
>  
>  extern void __init inode_init(void);
>  extern void __init inode_init_early(void);
> @@ -2119,10 +2120,10 @@ int vfs_mknod(struct mnt_idmap *, struct inode *, struct dentry *,
>  int vfs_symlink(struct mnt_idmap *, struct inode *,
>  		struct dentry *, const char *);
>  int vfs_link(struct dentry *, struct mnt_idmap *, struct inode *,
> -	     struct dentry *, struct inode **);
> +	     struct dentry *, struct delegated_inode *);
>  int vfs_rmdir(struct mnt_idmap *, struct inode *, struct dentry *);
>  int vfs_unlink(struct mnt_idmap *, struct inode *, struct dentry *,
> -	       struct inode **);
> +	       struct delegated_inode *);
>  
>  /**
>   * struct renamedata - contains all information required for renaming
> @@ -2140,7 +2141,7 @@ struct renamedata {
>  	struct dentry *old_dentry;
>  	struct dentry *new_parent;
>  	struct dentry *new_dentry;
> -	struct inode **delegated_inode;
> +	struct delegated_inode *delegated_inode;
>  	unsigned int flags;
>  } __randomize_layout;
>  
> @@ -3071,7 +3072,7 @@ static inline int bmap(struct inode *inode,  sector_t *block)
>  #endif
>  
>  int notify_change(struct mnt_idmap *, struct dentry *,
> -		  struct iattr *, struct inode **);
> +		  struct iattr *, struct delegated_inode *);
>  int inode_permission(struct mnt_idmap *, struct inode *, int);
>  int generic_permission(struct mnt_idmap *, struct inode *, int);
>  static inline int file_permission(struct file *file, int mask)
> diff --git a/include/linux/xattr.h b/include/linux/xattr.h
> index 86b0d47984a16d935dd1c45ca80a3b8bb5b7295b..64e9afe7d647dc38f686a4b5c6f765e061cde54c 100644
> --- a/include/linux/xattr.h
> +++ b/include/linux/xattr.h
> @@ -85,12 +85,12 @@ int __vfs_setxattr_noperm(struct mnt_idmap *, struct dentry *,
>  			  const char *, const void *, size_t, int);
>  int __vfs_setxattr_locked(struct mnt_idmap *, struct dentry *,
>  			  const char *, const void *, size_t, int,
> -			  struct inode **);
> +			  struct delegated_inode *);
>  int vfs_setxattr(struct mnt_idmap *, struct dentry *, const char *,
>  		 const void *, size_t, int);
>  int __vfs_removexattr(struct mnt_idmap *, struct dentry *, const char *);
>  int __vfs_removexattr_locked(struct mnt_idmap *, struct dentry *,
> -			     const char *, struct inode **);
> +			     const char *, struct delegated_inode *);
>  int vfs_removexattr(struct mnt_idmap *, struct dentry *, const char *);
>  
>  ssize_t generic_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size);
> 
> -- 
> 2.51.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

