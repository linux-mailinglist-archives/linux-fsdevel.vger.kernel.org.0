Return-Path: <linux-fsdevel+bounces-55238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 586F7B08B5C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 12:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DC773AB5FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 10:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86FB299957;
	Thu, 17 Jul 2025 10:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dyZfaYQA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IT01QtTH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dyZfaYQA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IT01QtTH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA2A262FC2
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 10:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752749693; cv=none; b=dQZWWSwrUgjCP9SCs7XC6Qx+y3odyVi6l3UTDYQalLdoSPxg8fnM9Dob5oAEdSMWmaApe7RCaVVVLQ/gAxpH7bNNczAW9WL6yUzkRJJVS7+FPbysE1WFW/v/zRUJhcddjvaZADTzVTxllIZBgvBwSWAQzOJlW3DCzzVHsrqY1c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752749693; c=relaxed/simple;
	bh=sxCUf5Wg12t7cY/nNXS6aZxTLkpIP9si6LXgeAHY8Sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exZbXB8nvu1QWBTWJqcmCkubBcSXP9ZPYGQyKQeWlbgNHordkwz4XOPyqaYzm2gZ+qRzUMNashqDplRI7W7ZOSeZ1NXQTOrigUpkiYzBFPZVOZWSwgHYMDP9+pH5+vBngN237C+dsXoY04tTrMBFSql2iZXmZa1lWBXaa4Ig33E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dyZfaYQA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IT01QtTH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dyZfaYQA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IT01QtTH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 97D06216F1;
	Thu, 17 Jul 2025 10:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752749688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iLaC5Ovn/Xlf1a8svsT4zsqKlyjD3HPQn3CB7YMsEpo=;
	b=dyZfaYQAYw6bvLRwcix6i5/IC5HkiOu6d/pflfTFlCLnD49mw1qNCQqag4FgfKO0wcAnNa
	xe9xjO02ySjfflNYIq7qzXDTZY5bXplohaEE8I+VrWFtKQhecVn+6al11KpQpXKpdsg7OI
	K5Pb2tWDa7ZLZVWBc5fhFjj6u7FgXOE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752749688;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iLaC5Ovn/Xlf1a8svsT4zsqKlyjD3HPQn3CB7YMsEpo=;
	b=IT01QtTH2H3mC16/GMNoKShgOWOBclA5e/1Bl3AFkKhf1SR2xR0x0IHZBShQJgeQsVFuXv
	+JPdHE4ZY8PeGGCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dyZfaYQA;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=IT01QtTH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752749688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iLaC5Ovn/Xlf1a8svsT4zsqKlyjD3HPQn3CB7YMsEpo=;
	b=dyZfaYQAYw6bvLRwcix6i5/IC5HkiOu6d/pflfTFlCLnD49mw1qNCQqag4FgfKO0wcAnNa
	xe9xjO02ySjfflNYIq7qzXDTZY5bXplohaEE8I+VrWFtKQhecVn+6al11KpQpXKpdsg7OI
	K5Pb2tWDa7ZLZVWBc5fhFjj6u7FgXOE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752749688;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iLaC5Ovn/Xlf1a8svsT4zsqKlyjD3HPQn3CB7YMsEpo=;
	b=IT01QtTH2H3mC16/GMNoKShgOWOBclA5e/1Bl3AFkKhf1SR2xR0x0IHZBShQJgeQsVFuXv
	+JPdHE4ZY8PeGGCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C8801392A;
	Thu, 17 Jul 2025 10:54:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9fpHInjWeGgpcQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 17 Jul 2025 10:54:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2EEFFA0993; Thu, 17 Jul 2025 12:54:48 +0200 (CEST)
Date: Thu, 17 Jul 2025 12:54:48 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>, Jens Axboe <axboe@kernel.dk>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC DRAFT DOESNOTBUILD] inode: free up more space
Message-ID: <scdueoausnzt2gusp2i5yt4nvf4adso7oe3gzunb4j5lavyi4p@xzzmjddppihf>
References: <20250715-work-inode-fscrypt-v1-1-aa3ef6f44b6b@kernel.org>
 <20250716112149.GA29673@lst.de>
 <20250716-unwahr-dumpf-835be7215e4c@brauner>
 <a24e87f111509bed526dd0a1650399edda9b75c0.camel@kernel.org>
 <aHeydTPax7kh5p28@casper.infradead.org>
 <20250716141030.GA11490@lst.de>
 <20250717-drehbaren-rabiat-850d4c5212fb@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717-drehbaren-rabiat-850d4c5212fb@brauner>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.com:email];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 97D06216F1
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Thu 17-07-25 10:32:07, Christian Brauner wrote:
> On Wed, Jul 16, 2025 at 04:10:30PM +0200, Christoph Hellwig wrote:
> > On Wed, Jul 16, 2025 at 03:08:53PM +0100, Matthew Wilcox wrote:
> > > struct filemap_inode {
> > > 	struct inode		inode;
> > > 	struct address_space	i_mapping;
> > > 	struct fscrypt_struct	i_fscrypt;
> > > 	struct fsverity_struct	i_fsverity;
> > > 	struct quota_struct	i_quota;
> > > };
> > > 
> > > struct ext4_inode {
> > > 	struct filemap_inode inode;
> > > 	...
> > > };
> > > 
> > > saves any messing with i_ops and offsets.
> > 
> > I still wastest a lot of space for XFS which only needs inode
> > and i_mapping of those.  As would most ext4 file systems..
> 
> We can do a hybrid approach:
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 2bc6a3ac2b8e..dda45b3f2122 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1198,9 +1198,7 @@ struct ext4_inode_info {
> 
>         kprojid_t i_projid;
> 
> -#ifdef CONFIG_FS_ENCRYPTION
> -       struct fscrypt_inode_info       *i_fscrypt_info;
> -#endif
> +       struct vfs_inode_adjunct i_adjunct; /* Adjunct data for inode */
>  };

Well, but if we moved also fsverity & quota & what not into
vfs_inode_adjunct the benefit of such structure would be diminishing? Or
am I misunderstanding the proposal? I think that the new method should
strive for each filesystem inode to store only the info it needs and not
waste space for things it isn't interested in.

								Honza

> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 676d33a7d842..f257ac048f3b 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -981,17 +981,19 @@ const struct file_operations ext4_file_operations = {
>  };
> 
>  const struct inode_operations ext4_file_inode_operations = {
> -       .setattr        = ext4_setattr,
> -       .getattr        = ext4_file_getattr,
> -       .listxattr      = ext4_listxattr,
> -       .get_inode_acl  = ext4_get_acl,
> -       .set_acl        = ext4_set_acl,
> -       .fiemap         = ext4_fiemap,
> -       .fileattr_get   = ext4_fileattr_get,
> -       .fileattr_set   = ext4_fileattr_set,
> +       .i_adjunct_offset       = offsetof(struct ext4_inode_info, vfs_inode) -
> +                                 offsetof(struct ext4_inode_info, i_adjunct),
> +       .setattr                = ext4_setattr,
> +       .getattr                = ext4_file_getattr,
> +       .listxattr              = ext4_listxattr,
> +       .get_inode_acl          = ext4_get_acl,
> +       .set_acl                = ext4_set_acl,
> +       .fiemap                 = ext4_fiemap,
> +       .fileattr_get           = ext4_fileattr_get,
> +       .fileattr_set           = ext4_fileattr_set,
>  #ifdef CONFIG_FS_ENCRYPTION
> -       .get_fscrypt    = ext4_get_fscrypt,
> -       .set_fscrypt    = ext4_set_fscrypt,
> +       .get_fscrypt            = ext4_get_fscrypt,
> +       .set_fscrypt            = ext4_set_fscrypt,
>  #endif
>  };
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index d8f242a2f431..c4752c80710e 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -789,6 +789,12 @@ struct inode {
>         void                    *i_private; /* fs or device private pointer */
>  } __randomize_layout;
> 
> +struct vfs_inode_adjunct {
> +#ifdef CONFIG_FS_ENCRYPTION
> +       struct fscrypt_inode_info *i_fscrypt_info;
> +#endif
> +};
> +
>  static inline void inode_set_cached_link(struct inode *inode, char *link, int linklen)
>  {
>         VFS_WARN_ON_INODE(strlen(link) != linklen, inode);
> @@ -2217,6 +2223,7 @@ int wrap_directory_iterator(struct file *, struct dir_context *,
>         { return wrap_directory_iterator(file, ctx, x); }
> 
>  struct inode_operations {
> +       ptrdiff_t i_adjunct_offset;
>         struct dentry * (*lookup) (struct inode *,struct dentry *, unsigned int);
>         const char * (*get_link) (struct dentry *, struct inode *, struct delayed_call *);
>         int (*permission) (struct mnt_idmap *, struct inode *, int);
> diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
> index 1aa474232fa7..fa0080869dc1 100644
> --- a/include/linux/fscrypt.h
> +++ b/include/linux/fscrypt.h
> @@ -195,6 +195,12 @@ struct fscrypt_operations {
>  int fscrypt_d_revalidate(struct inode *dir, const struct qstr *name,
>                          struct dentry *dentry, unsigned int flags);
> 
> +static inline struct fscrypt_inode_info *CRYPT_I(struct inode *inode)
> +{
> +       struct vfs_inode_adjunct *p = ((void *)inode) - inode->i_op->i_adjunct_offset;
> +       return p->i_fscrypt_info;
> +}
> +
>  static inline int vfs_fscrypt_inode_set(struct fscrypt_inode_info *crypt_info,
>                                         struct fscrypt_inode_info **p)
>  {
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

