Return-Path: <linux-fsdevel+bounces-27786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F115896405D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 11:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F51BB25D5E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 09:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067C718E744;
	Thu, 29 Aug 2024 09:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oZA7TE1Y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="omYsbTru";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oZA7TE1Y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="omYsbTru"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDAB18CBFE;
	Thu, 29 Aug 2024 09:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724924261; cv=none; b=dNEkl2O5cA2taTZauCS+7oPLyH9vyM3k+g7MmcW6+bSQSu9KD4hi5SPLW60WKemgi2WvsxR37pLHD9PSaujuRwhJrvPaY6vdCwtQx3y0kx+AG/08BNlLgIqgv1uWoEXt6HUqkUGJQ81DQqdkrnKHq70lHaO8qbUOLG6YF33x91A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724924261; c=relaxed/simple;
	bh=lhmzv8vL+ANlbOmjNK4zvMLX7XiFnSTBb8tBvs9UObc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHSvOfizSPn4J+xemLgsUYf9FjfQSyctEutNLOtFdEkTiMX6Yu/fwOkxJPqoA3DwBu4YqWKahpJPMZJ7x777W02xI67mP40ZJorDc6jHHqhjjCWO4i9PXPSgrtNUfIZBOex+1PacGwDTvkJe9P/FmpPqvX9602QSeqbs2L4cGqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oZA7TE1Y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=omYsbTru; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oZA7TE1Y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=omYsbTru; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A96861FD10;
	Thu, 29 Aug 2024 09:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724924257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9drsSD5YJCouaKbMktVv8j8L/jfLbn2xhxC8kz8aIlA=;
	b=oZA7TE1YY5nXJkOW40ResvG1zmb/IW9l1Un+zYjR3jFgF8bAb4CmVb5rgCbKvq6f3F6B9t
	wkWrt94DdDP8F8cISWAzIhdgU0H5qilivSM/mg5PhR7XNVsn0DjIjVaCWV8cPMIbWFMevR
	5WQoH/LX8r8mnbi/Gu/6yMwhc/qK2jk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724924257;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9drsSD5YJCouaKbMktVv8j8L/jfLbn2xhxC8kz8aIlA=;
	b=omYsbTruGNB64Af8UELCpSc6wli2TCeYGq4FBAGp4l0h8cQEra7bIXuQ+tJp6Ce3AzQ04h
	XcnOQUSpT1gg2sAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724924257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9drsSD5YJCouaKbMktVv8j8L/jfLbn2xhxC8kz8aIlA=;
	b=oZA7TE1YY5nXJkOW40ResvG1zmb/IW9l1Un+zYjR3jFgF8bAb4CmVb5rgCbKvq6f3F6B9t
	wkWrt94DdDP8F8cISWAzIhdgU0H5qilivSM/mg5PhR7XNVsn0DjIjVaCWV8cPMIbWFMevR
	5WQoH/LX8r8mnbi/Gu/6yMwhc/qK2jk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724924257;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9drsSD5YJCouaKbMktVv8j8L/jfLbn2xhxC8kz8aIlA=;
	b=omYsbTruGNB64Af8UELCpSc6wli2TCeYGq4FBAGp4l0h8cQEra7bIXuQ+tJp6Ce3AzQ04h
	XcnOQUSpT1gg2sAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D86C13408;
	Thu, 29 Aug 2024 09:37:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id llhxJmFB0Gb6dAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 29 Aug 2024 09:37:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5969EA0965; Thu, 29 Aug 2024 11:37:33 +0200 (CEST)
Date: Thu, 29 Aug 2024 11:37:33 +0200
From: Jan Kara <jack@suse.cz>
To: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>, jack@suse.cz,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 1/2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Message-ID: <20240829093733.njnlsyexwknyosxe@quack3>
References: <20240826085347.1152675-1-mhocko@kernel.org>
 <20240826085347.1152675-2-mhocko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826085347.1152675-2-mhocko@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,lst.de,gmail.com,linux.dev,suse.cz,kernel.org,zeniv.linux.org.uk,paul-moore.com,namei.org,hallyn.com,vger.kernel.org,kvack.org,suse.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -2.30
X-Spam-Flag: NO

On Mon 26-08-24 10:47:12, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> bch2_new_inode relies on PF_MEMALLOC_NORECLAIM to try to allocate a new
> inode to achieve GFP_NOWAIT semantic while holding locks. If this
> allocation fails it will drop locks and use GFP_NOFS allocation context.
> 
> We would like to drop PF_MEMALLOC_NORECLAIM because it is really
> dangerous to use if the caller doesn't control the full call chain with
> this flag set. E.g. if any of the function down the chain needed
> GFP_NOFAIL request the PF_MEMALLOC_NORECLAIM would override this and
> cause unexpected failure.
> 
> While this is not the case in this particular case using the scoped gfp
> semantic is not really needed bacause we can easily pus the allocation
> context down the chain without too much clutter.
> 
> Acked-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Michal Hocko <mhocko@suse.com>

For the VFS changes feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/bcachefs/fs.c          | 14 ++++++--------
>  fs/inode.c                |  6 +++---
>  include/linux/fs.h        |  7 ++++++-
>  include/linux/lsm_hooks.h |  2 +-
>  include/linux/security.h  |  4 ++--
>  security/security.c       |  8 ++++----
>  6 files changed, 22 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
> index 15fc41e63b6c..7a55167b9133 100644
> --- a/fs/bcachefs/fs.c
> +++ b/fs/bcachefs/fs.c
> @@ -231,9 +231,9 @@ static struct inode *bch2_alloc_inode(struct super_block *sb)
>  	BUG();
>  }
>  
> -static struct bch_inode_info *__bch2_new_inode(struct bch_fs *c)
> +static struct bch_inode_info *__bch2_new_inode(struct bch_fs *c, gfp_t gfp)
>  {
> -	struct bch_inode_info *inode = kmem_cache_alloc(bch2_inode_cache, GFP_NOFS);
> +	struct bch_inode_info *inode = kmem_cache_alloc(bch2_inode_cache, gfp);
>  	if (!inode)
>  		return NULL;
>  
> @@ -245,7 +245,7 @@ static struct bch_inode_info *__bch2_new_inode(struct bch_fs *c)
>  	mutex_init(&inode->ei_quota_lock);
>  	memset(&inode->ei_devs_need_flush, 0, sizeof(inode->ei_devs_need_flush));
>  
> -	if (unlikely(inode_init_always(c->vfs_sb, &inode->v))) {
> +	if (unlikely(inode_init_always_gfp(c->vfs_sb, &inode->v), gfp)) {
>  		kmem_cache_free(bch2_inode_cache, inode);
>  		return NULL;
>  	}
> @@ -258,12 +258,10 @@ static struct bch_inode_info *__bch2_new_inode(struct bch_fs *c)
>   */
>  static struct bch_inode_info *bch2_new_inode(struct btree_trans *trans)
>  {
> -	struct bch_inode_info *inode =
> -		memalloc_flags_do(PF_MEMALLOC_NORECLAIM|PF_MEMALLOC_NOWARN,
> -				  __bch2_new_inode(trans->c));
> +	struct bch_inode_info *inode = __bch2_new_inode(trans->c, GFP_NOWARN | GFP_NOWAIT);
>  
>  	if (unlikely(!inode)) {
> -		int ret = drop_locks_do(trans, (inode = __bch2_new_inode(trans->c)) ? 0 : -ENOMEM);
> +		int ret = drop_locks_do(trans, (inode = __bch2_new_inode(trans->c, GFP_NOFS)) ? 0 : -ENOMEM);
>  		if (ret && inode) {
>  			__destroy_inode(&inode->v);
>  			kmem_cache_free(bch2_inode_cache, inode);
> @@ -328,7 +326,7 @@ __bch2_create(struct mnt_idmap *idmap,
>  	if (ret)
>  		return ERR_PTR(ret);
>  #endif
> -	inode = __bch2_new_inode(c);
> +	inode = __bch2_new_inode(c, GFP_NOFS);
>  	if (unlikely(!inode)) {
>  		inode = ERR_PTR(-ENOMEM);
>  		goto err;
> diff --git a/fs/inode.c b/fs/inode.c
> index 86670941884b..95fd67a6cac3 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -153,7 +153,7 @@ static int no_open(struct inode *inode, struct file *file)
>   * These are initializations that need to be done on every inode
>   * allocation as the fields are not initialised by slab allocation.
>   */
> -int inode_init_always(struct super_block *sb, struct inode *inode)
> +int inode_init_always(struct super_block *sb, struct inode *inode, gfp_t gfp)
>  {
>  	static const struct inode_operations empty_iops;
>  	static const struct file_operations no_open_fops = {.open = no_open};
> @@ -230,14 +230,14 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
>  #endif
>  	inode->i_flctx = NULL;
>  
> -	if (unlikely(security_inode_alloc(inode)))
> +	if (unlikely(security_inode_alloc(inode, gfp)))
>  		return -ENOMEM;
>  
>  	this_cpu_inc(nr_inodes);
>  
>  	return 0;
>  }
> -EXPORT_SYMBOL(inode_init_always);
> +EXPORT_SYMBOL(inode_init_always_gfp);
>  
>  void free_inode_nonrcu(struct inode *inode)
>  {
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index fd34b5755c0b..d46ca71a7855 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3027,7 +3027,12 @@ extern loff_t default_llseek(struct file *file, loff_t offset, int whence);
>  
>  extern loff_t vfs_llseek(struct file *file, loff_t offset, int whence);
>  
> -extern int inode_init_always(struct super_block *, struct inode *);
> +extern int inode_init_always_gfp(struct super_block *, struct inode *, gfp_t);
> +static inline int inode_init_always(struct super_block *sb, struct inode *inode)
> +{
> +	return inode_init_always_gfp(sb, inode, GFP_NOFS);
> +}
> +
>  extern void inode_init_once(struct inode *);
>  extern void address_space_init_once(struct address_space *mapping);
>  extern struct inode * igrab(struct inode *);
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index a2ade0ffe9e7..b08472d64765 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -150,6 +150,6 @@ extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
>  		__used __section(".early_lsm_info.init")		\
>  		__aligned(sizeof(unsigned long))
>  
> -extern int lsm_inode_alloc(struct inode *inode);
> +extern int lsm_inode_alloc(struct inode *inode, gfp_t gfp);
>  
>  #endif /* ! __LINUX_LSM_HOOKS_H */
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 1390f1efb4f0..7c6b9b038a0d 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -336,7 +336,7 @@ int security_dentry_create_files_as(struct dentry *dentry, int mode,
>  					struct cred *new);
>  int security_path_notify(const struct path *path, u64 mask,
>  					unsigned int obj_type);
> -int security_inode_alloc(struct inode *inode);
> +int security_inode_alloc(struct inode *inode, gfp_t gfp);
>  void security_inode_free(struct inode *inode);
>  int security_inode_init_security(struct inode *inode, struct inode *dir,
>  				 const struct qstr *qstr,
> @@ -769,7 +769,7 @@ static inline int security_path_notify(const struct path *path, u64 mask,
>  	return 0;
>  }
>  
> -static inline int security_inode_alloc(struct inode *inode)
> +static inline int security_inode_alloc(struct inode *inode, gfp_t gfp)
>  {
>  	return 0;
>  }
> diff --git a/security/security.c b/security/security.c
> index 8cee5b6c6e6d..3581262da5ee 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -660,14 +660,14 @@ static int lsm_file_alloc(struct file *file)
>   *
>   * Returns 0, or -ENOMEM if memory can't be allocated.
>   */
> -int lsm_inode_alloc(struct inode *inode)
> +int lsm_inode_alloc(struct inode *inode, gfp_t gfp)
>  {
>  	if (!lsm_inode_cache) {
>  		inode->i_security = NULL;
>  		return 0;
>  	}
>  
> -	inode->i_security = kmem_cache_zalloc(lsm_inode_cache, GFP_NOFS);
> +	inode->i_security = kmem_cache_zalloc(lsm_inode_cache, gfp);
>  	if (inode->i_security == NULL)
>  		return -ENOMEM;
>  	return 0;
> @@ -1582,9 +1582,9 @@ int security_path_notify(const struct path *path, u64 mask,
>   *
>   * Return: Return 0 if operation was successful.
>   */
> -int security_inode_alloc(struct inode *inode)
> +int security_inode_alloc(struct inode *inode, gfp_t gfp)
>  {
> -	int rc = lsm_inode_alloc(inode);
> +	int rc = lsm_inode_alloc(inode, gfp);
>  
>  	if (unlikely(rc))
>  		return rc;
> -- 
> 2.46.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

