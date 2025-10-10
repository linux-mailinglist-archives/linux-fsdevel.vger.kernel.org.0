Return-Path: <linux-fsdevel+bounces-63766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD7DBCD6F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 16:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2202519A3104
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 14:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3AE2F5A3F;
	Fri, 10 Oct 2025 14:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lFdaMee7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y/6Vks8a";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lFdaMee7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y/6Vks8a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA5D2F532C
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 14:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760105565; cv=none; b=CNhhWwfU7wRhxZSH6ZxCnjoPU2pmBQbLKPr23bLmv3yRPQ9BfN+H6eVePD1jqb6Xzm0peUVl+A93AloIpJkAY29QiybxMMBmoBHhOaU04W768olfqUQbmA6fpAE1jNKCRiUYRgZb1feqj/IWJgwjVqhizNxElOOhX6Z4CDNWEbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760105565; c=relaxed/simple;
	bh=f4z8bdtTHOsQ14NaVpmPyM3d7w3XBSahKI4xwW0lmeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKEb06+dhZc5dMHmtcd1eFrDlJMjNcO8FVTrGbXIJ0f1UkFvQI52kLDLu3uFbwgNV0LAzAptRf9gbK65ttBRM333azNr1qSVMXUkfv/JY/rEaKD29PtLdQW/BW2Q5/5i6tnl/756UXf/IF34wPOkdEvOe5ymCmHRod/VHkCHlDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lFdaMee7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y/6Vks8a; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lFdaMee7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y/6Vks8a; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 70FB91F397;
	Fri, 10 Oct 2025 14:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760105561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A3ME5g+qhe2ekD20ygRIPqlRcmmYhtzmcpV3lc61ma0=;
	b=lFdaMee78BtkQmpioPL7r4Oi2oK87Y2/h3KLh90mONS/2uZY40R0kekgsw2VTe0pXj9wDo
	0utJhVzFZuG9sWkmnyMrAOD5oD29rhP9DBvmiZ8eylWD0N8j7QoLp8ROqFNK/Fk4cgQ+JW
	xQ239QBVCElMtrnMEMmutISBWubpK/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760105561;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A3ME5g+qhe2ekD20ygRIPqlRcmmYhtzmcpV3lc61ma0=;
	b=Y/6Vks8aCTBvOaogOBWzgEt3mL7roBAanFxsT7WRrjL95OZfWEJzJCuQR4OFf/QbdfyVHl
	kBgwIAhWEBx7niAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760105561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A3ME5g+qhe2ekD20ygRIPqlRcmmYhtzmcpV3lc61ma0=;
	b=lFdaMee78BtkQmpioPL7r4Oi2oK87Y2/h3KLh90mONS/2uZY40R0kekgsw2VTe0pXj9wDo
	0utJhVzFZuG9sWkmnyMrAOD5oD29rhP9DBvmiZ8eylWD0N8j7QoLp8ROqFNK/Fk4cgQ+JW
	xQ239QBVCElMtrnMEMmutISBWubpK/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760105561;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A3ME5g+qhe2ekD20ygRIPqlRcmmYhtzmcpV3lc61ma0=;
	b=Y/6Vks8aCTBvOaogOBWzgEt3mL7roBAanFxsT7WRrjL95OZfWEJzJCuQR4OFf/QbdfyVHl
	kBgwIAhWEBx7niAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 529E11375D;
	Fri, 10 Oct 2025 14:12:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 94goFFkU6WhgCAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 10 Oct 2025 14:12:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3B197A0A58; Fri, 10 Oct 2025 16:12:40 +0200 (CEST)
Date: Fri, 10 Oct 2025 16:12:40 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	kernel-team@fb.com, amir73il@gmail.com, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v7 07/14] ceph: use the new ->i_state accessors
Message-ID: <pgntaqxmxnoe2zujqmwswz5tfgob7p24it4ckhxlshy4v6d6ir@jabz5zepbz2x>
References: <20251009075929.1203950-1-mjguzik@gmail.com>
 <20251009075929.1203950-8-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009075929.1203950-8-mjguzik@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,vger.kernel.org,toxicpanda.com,fb.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Thu 09-10-25 09:59:21, Mateusz Guzik wrote:
> Change generated with coccinelle and fixed up by hand as appropriate.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> cheat sheet:
> 
> If ->i_lock is held, then:
> 
> state = inode->i_state          => state = inode_state_read(inode)
> inode->i_state |= (I_A | I_B)   => inode_state_set(inode, I_A | I_B)
> inode->i_state &= ~(I_A | I_B)  => inode_state_clear(inode, I_A | I_B)
> inode->i_state = I_A | I_B      => inode_state_assign(inode, I_A | I_B)
> 
> If ->i_lock is not held or only held conditionally:
> 
> state = inode->i_state          => state = inode_state_read_once(inode)
> inode->i_state |= (I_A | I_B)   => inode_state_set_raw(inode, I_A | I_B)
> inode->i_state &= ~(I_A | I_B)  => inode_state_clear_raw(inode, I_A | I_B)
> inode->i_state = I_A | I_B      => inode_state_assign_raw(inode, I_A | I_B)
> 
>  fs/ceph/cache.c  |  2 +-
>  fs/ceph/crypto.c |  4 ++--
>  fs/ceph/file.c   |  4 ++--
>  fs/ceph/inode.c  | 28 ++++++++++++++--------------
>  4 files changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/ceph/cache.c b/fs/ceph/cache.c
> index 930fbd54d2c8..f678bab189d8 100644
> --- a/fs/ceph/cache.c
> +++ b/fs/ceph/cache.c
> @@ -26,7 +26,7 @@ void ceph_fscache_register_inode_cookie(struct inode *inode)
>  		return;
>  
>  	/* Only new inodes! */
> -	if (!(inode->i_state & I_NEW))
> +	if (!(inode_state_read_once(inode) & I_NEW))
>  		return;
>  
>  	WARN_ON_ONCE(ci->netfs.cache);
> diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
> index 7026e794813c..928746b92512 100644
> --- a/fs/ceph/crypto.c
> +++ b/fs/ceph/crypto.c
> @@ -329,7 +329,7 @@ int ceph_encode_encrypted_dname(struct inode *parent, char *buf, int elen)
>  out:
>  	kfree(cryptbuf);
>  	if (dir != parent) {
> -		if ((dir->i_state & I_NEW))
> +		if ((inode_state_read_once(dir) & I_NEW))
>  			discard_new_inode(dir);
>  		else
>  			iput(dir);
> @@ -438,7 +438,7 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
>  	fscrypt_fname_free_buffer(&_tname);
>  out_inode:
>  	if (dir != fname->dir) {
> -		if ((dir->i_state & I_NEW))
> +		if ((inode_state_read_once(dir) & I_NEW))
>  			discard_new_inode(dir);
>  		else
>  			iput(dir);
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 978acd3d4b32..1c9d73523b88 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -741,7 +741,7 @@ static int ceph_finish_async_create(struct inode *dir, struct inode *inode,
>  		      vino.ino, ceph_ino(dir), dentry->d_name.name);
>  		ceph_dir_clear_ordered(dir);
>  		ceph_init_inode_acls(inode, as_ctx);
> -		if (inode->i_state & I_NEW) {
> +		if (inode_state_read_once(inode) & I_NEW) {
>  			/*
>  			 * If it's not I_NEW, then someone created this before
>  			 * we got here. Assume the server is aware of it at
> @@ -903,7 +903,7 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
>  				new_inode = NULL;
>  				goto out_req;
>  			}
> -			WARN_ON_ONCE(!(new_inode->i_state & I_NEW));
> +			WARN_ON_ONCE(!(inode_state_read_once(new_inode) & I_NEW));
>  
>  			spin_lock(&dentry->d_lock);
>  			di->flags |= CEPH_DENTRY_ASYNC_CREATE;
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 949f0badc944..4044a13969ad 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -132,7 +132,7 @@ struct inode *ceph_new_inode(struct inode *dir, struct dentry *dentry,
>  			goto out_err;
>  	}
>  
> -	inode->i_state = 0;
> +	inode_state_assign_raw(inode, 0);
>  	inode->i_mode = *mode;
>  
>  	err = ceph_security_init_secctx(dentry, *mode, as_ctx);
> @@ -201,7 +201,7 @@ struct inode *ceph_get_inode(struct super_block *sb, struct ceph_vino vino,
>  
>  	doutc(cl, "on %llx=%llx.%llx got %p new %d\n",
>  	      ceph_present_inode(inode), ceph_vinop(inode), inode,
> -	      !!(inode->i_state & I_NEW));
> +	      !!(inode_state_read_once(inode) & I_NEW));
>  	return inode;
>  }
>  
> @@ -228,7 +228,7 @@ struct inode *ceph_get_snapdir(struct inode *parent)
>  		goto err;
>  	}
>  
> -	if (!(inode->i_state & I_NEW) && !S_ISDIR(inode->i_mode)) {
> +	if (!(inode_state_read_once(inode) & I_NEW) && !S_ISDIR(inode->i_mode)) {
>  		pr_warn_once_client(cl, "bad snapdir inode type (mode=0%o)\n",
>  				    inode->i_mode);
>  		goto err;
> @@ -261,7 +261,7 @@ struct inode *ceph_get_snapdir(struct inode *parent)
>  		}
>  	}
>  #endif
> -	if (inode->i_state & I_NEW) {
> +	if (inode_state_read_once(inode) & I_NEW) {
>  		inode->i_op = &ceph_snapdir_iops;
>  		inode->i_fop = &ceph_snapdir_fops;
>  		ci->i_snap_caps = CEPH_CAP_PIN; /* so we can open */
> @@ -270,7 +270,7 @@ struct inode *ceph_get_snapdir(struct inode *parent)
>  
>  	return inode;
>  err:
> -	if ((inode->i_state & I_NEW))
> +	if ((inode_state_read_once(inode) & I_NEW))
>  		discard_new_inode(inode);
>  	else
>  		iput(inode);
> @@ -744,7 +744,7 @@ void ceph_evict_inode(struct inode *inode)
>  
>  	netfs_wait_for_outstanding_io(inode);
>  	truncate_inode_pages_final(&inode->i_data);
> -	if (inode->i_state & I_PINNING_NETFS_WB)
> +	if (inode_state_read_once(inode) & I_PINNING_NETFS_WB)
>  		ceph_fscache_unuse_cookie(inode, true);
>  	clear_inode(inode);
>  
> @@ -1013,7 +1013,7 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
>  	      le64_to_cpu(info->version), ci->i_version);
>  
>  	/* Once I_NEW is cleared, we can't change type or dev numbers */
> -	if (inode->i_state & I_NEW) {
> +	if (inode_state_read_once(inode) & I_NEW) {
>  		inode->i_mode = mode;
>  	} else {
>  		if (inode_wrong_type(inode, mode)) {
> @@ -1090,7 +1090,7 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
>  
>  #ifdef CONFIG_FS_ENCRYPTION
>  	if (iinfo->fscrypt_auth_len &&
> -	    ((inode->i_state & I_NEW) || (ci->fscrypt_auth_len == 0))) {
> +	    ((inode_state_read_once(inode) & I_NEW) || (ci->fscrypt_auth_len == 0))) {
>  		kfree(ci->fscrypt_auth);
>  		ci->fscrypt_auth_len = iinfo->fscrypt_auth_len;
>  		ci->fscrypt_auth = iinfo->fscrypt_auth;
> @@ -1692,13 +1692,13 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
>  			pr_err_client(cl, "badness %p %llx.%llx\n", in,
>  				      ceph_vinop(in));
>  			req->r_target_inode = NULL;
> -			if (in->i_state & I_NEW)
> +			if (inode_state_read_once(in) & I_NEW)
>  				discard_new_inode(in);
>  			else
>  				iput(in);
>  			goto done;
>  		}
> -		if (in->i_state & I_NEW)
> +		if (inode_state_read_once(in) & I_NEW)
>  			unlock_new_inode(in);
>  	}
>  
> @@ -1887,11 +1887,11 @@ static int readdir_prepopulate_inodes_only(struct ceph_mds_request *req,
>  			pr_err_client(cl, "inode badness on %p got %d\n", in,
>  				      rc);
>  			err = rc;
> -			if (in->i_state & I_NEW) {
> +			if (inode_state_read_once(in) & I_NEW) {
>  				ihold(in);
>  				discard_new_inode(in);
>  			}
> -		} else if (in->i_state & I_NEW) {
> +		} else if (inode_state_read_once(in) & I_NEW) {
>  			unlock_new_inode(in);
>  		}
>  
> @@ -2103,7 +2103,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
>  			pr_err_client(cl, "badness on %p %llx.%llx\n", in,
>  				      ceph_vinop(in));
>  			if (d_really_is_negative(dn)) {
> -				if (in->i_state & I_NEW) {
> +				if (inode_state_read_once(in) & I_NEW) {
>  					ihold(in);
>  					discard_new_inode(in);
>  				}
> @@ -2113,7 +2113,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
>  			err = ret;
>  			goto next_item;
>  		}
> -		if (in->i_state & I_NEW)
> +		if (inode_state_read_once(in) & I_NEW)
>  			unlock_new_inode(in);
>  
>  		if (d_really_is_negative(dn)) {
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

