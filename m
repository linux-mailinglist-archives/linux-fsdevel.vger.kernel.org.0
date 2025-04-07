Return-Path: <linux-fsdevel+bounces-45872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B70D9A7E02C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 15:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3C3E189AC39
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 13:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F6D1AC43A;
	Mon,  7 Apr 2025 13:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1tdC+PjD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lA0J5MPp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WU3dtWNr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eNd1KZDx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262EB18D649
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Apr 2025 13:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744033853; cv=none; b=nhiLPPuiD3Li2oWlLJ11JKy1p7JM67NB6HNZs2RkLhdH2BOvcT/XA7cONXUbEROVc7kvdRu0KVhRRemgz6O88OcxuEp8QQSUsayO+56yoYO8thtp/WThKyyZf4ZDYYavE6FHMoPk236R6o8hVpGWYcw69mW/xNHWGsJu9UNrAGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744033853; c=relaxed/simple;
	bh=H2HCHdzRQQWsnCbi02mnUVPsu52o4xeqygUVqvJ8Tdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCWUGv3pou4mtV0jwbrzm36JFpB9o24c3rcTyPKzR9D/L9gUmiqYRHEYR404VTQuvi+82Ydw+eksLQw8bguOxj7vdBxzToQXcTPMuEk8S3Nd6A+opzwWxtG4mpDrinvxFUy1etJ7B2O9T4YJ11n0ymL7Surf60zUeoN1Puf946Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1tdC+PjD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lA0J5MPp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WU3dtWNr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eNd1KZDx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5D94621180;
	Mon,  7 Apr 2025 13:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744033849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VxkjbTzeZf6DAfIC1EHsf9iEoYFt42HmIE3lIGCxxMc=;
	b=1tdC+PjDjHmVUVHqheKdyX3bwLS2lU+/relNgof2rva+nlAScRD6xH6BN2F15iIXDJACHS
	D34bc60VjulH3BW6bDQ1mfGeMjL8ZW79OgMkLcj4+94dqHvjRKRBoT9H2rbsGgVgu2IMnC
	ABFgWIcwIkfULT6E1N9uEtShmL3Hjgw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744033849;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VxkjbTzeZf6DAfIC1EHsf9iEoYFt42HmIE3lIGCxxMc=;
	b=lA0J5MPpt0d/LcJwg5QsjrF8w41B91UmMT+CDEUrnJ7WzjfKs3gID+0wiRvASf0+VD8Ae7
	mFGenVwm13OZ7ZBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=WU3dtWNr;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=eNd1KZDx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744033848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VxkjbTzeZf6DAfIC1EHsf9iEoYFt42HmIE3lIGCxxMc=;
	b=WU3dtWNro7ml6OF+pekGhpCGoqjgq6dR4i7bZsDI07lORo2iJ/QIbIpYCWtzjnHo3k7GiB
	CbxDzphQa8EiMchZIDJilE4FzVzpdJJd0CbTXeACQ3gTVDoE/Sv63uRC/b+Hdigxr/gRON
	3yzMTvvBYE0KyV5RBN0/EWkTLKViVhE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744033848;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VxkjbTzeZf6DAfIC1EHsf9iEoYFt42HmIE3lIGCxxMc=;
	b=eNd1KZDx8xHawp9oVtpDxnIBDFx34ar6puxWnDL9EoxgtiAlKShNHvPvbeaqhjEDEHR6Fm
	2a+0J2xfkHL/rkAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5097E13A4B;
	Mon,  7 Apr 2025 13:50:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cQKfEzjY82dnHQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 07 Apr 2025 13:50:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E2E45A08D2; Mon,  7 Apr 2025 15:50:47 +0200 (CEST)
Date: Mon, 7 Apr 2025 15:50:47 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Penglei Jiang <superman.xpt@gmail.com>, viro@zeniv.linux.org.uk, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com
Subject: Re: [PATCH] anon_inode: use a proper mode internally
Message-ID: <xc5jgiqsyaqxxsqgjsspmmxji5hzuhu24a57dunkwtjzyqj2ld@l4wyerk6gbdj>
References: <20250404-aphorismen-reibung-12028a1db7e3@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404-aphorismen-reibung-12028a1db7e3@brauner>
X-Rspamd-Queue-Id: 5D94621180
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[5d8e79d323a13aa0b248];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,gmail.com,zeniv.linux.org.uk,suse.cz,vger.kernel.org,syzkaller.appspotmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,appspotmail.com:email,suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO

On Fri 04-04-25 12:39:14, Christian Brauner wrote:
> This allows the VFS to not trip over anonymous inodes and we can add
> asserts based on the mode into the vfs. When we report it to userspace
> we can simply hide the mode to avoid regressions. I've audited all
> direct callers of alloc_anon_inode() and only secretmen overrides i_mode
> and i_op inode operations but it already uses a regular file.
> 
> Fixes: af153bb63a336 ("vfs: catch invalid modes in may_open()")
> Reported-by: syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/67ed3fb3.050a0220.14623d.0009.GAE@google.com"
> Signed-off-by: Christian Brauner <brauner@kernel.org>

It seems better to have anon inodes consistent with the rest of the kernel
so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/anon_inodes.c | 36 ++++++++++++++++++++++++++++++++++++
>  fs/internal.h    |  3 +++
>  fs/libfs.c       |  2 +-
>  fs/pidfs.c       | 24 +-----------------------
>  4 files changed, 41 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
> index 583ac81669c2..42e4b9c34f89 100644
> --- a/fs/anon_inodes.c
> +++ b/fs/anon_inodes.c
> @@ -24,9 +24,43 @@
>  
>  #include <linux/uaccess.h>
>  
> +#include "internal.h"
> +
>  static struct vfsmount *anon_inode_mnt __ro_after_init;
>  static struct inode *anon_inode_inode __ro_after_init;
>  
> +/*
> + * User space expects anonymous inodes to have no file type in st_mode.
> + *
> + * In particular, 'lsof' has this legacy logic:
> + *
> + *	type = s->st_mode & S_IFMT;
> + *	switch (type) {
> + *	  ...
> + *	case 0:
> + *		if (!strcmp(p, "anon_inode"))
> + *			Lf->ntype = Ntype = N_ANON_INODE;
> + *
> + * to detect our old anon_inode logic.
> + *
> + * Rather than mess with our internal sane inode data, just fix it
> + * up here in getattr() by masking off the format bits.
> + */
> +int anon_inode_getattr(struct mnt_idmap *idmap, const struct path *path,
> +		       struct kstat *stat, u32 request_mask,
> +		       unsigned int query_flags)
> +{
> +	struct inode *inode = d_inode(path->dentry);
> +
> +	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
> +	stat->mode &= ~S_IFMT;
> +	return 0;
> +}
> +
> +static const struct inode_operations anon_inode_operations = {
> +	.getattr = anon_inode_getattr,
> +};
> +
>  /*
>   * anon_inodefs_dname() is called from d_path().
>   */
> @@ -66,6 +100,7 @@ static struct inode *anon_inode_make_secure_inode(
>  	if (IS_ERR(inode))
>  		return inode;
>  	inode->i_flags &= ~S_PRIVATE;
> +	inode->i_op = &anon_inode_operations;
>  	error =	security_inode_init_security_anon(inode, &QSTR(name),
>  						  context_inode);
>  	if (error) {
> @@ -313,6 +348,7 @@ static int __init anon_inode_init(void)
>  	anon_inode_inode = alloc_anon_inode(anon_inode_mnt->mnt_sb);
>  	if (IS_ERR(anon_inode_inode))
>  		panic("anon_inode_init() inode allocation failed (%ld)\n", PTR_ERR(anon_inode_inode));
> +	anon_inode_inode->i_op = &anon_inode_operations;
>  
>  	return 0;
>  }
> diff --git a/fs/internal.h b/fs/internal.h
> index b9b3e29a73fd..717dc9eb6185 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -343,3 +343,6 @@ static inline bool path_mounted(const struct path *path)
>  void file_f_owner_release(struct file *file);
>  bool file_seek_cur_needs_f_lock(struct file *file);
>  int statmount_mnt_idmap(struct mnt_idmap *idmap, struct seq_file *seq, bool uid_map);
> +int anon_inode_getattr(struct mnt_idmap *idmap, const struct path *path,
> +		       struct kstat *stat, u32 request_mask,
> +		       unsigned int query_flags);
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 6393d7c49ee6..0ad3336f5b49 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -1647,7 +1647,7 @@ struct inode *alloc_anon_inode(struct super_block *s)
>  	 * that it already _is_ on the dirty list.
>  	 */
>  	inode->i_state = I_DIRTY;
> -	inode->i_mode = S_IRUSR | S_IWUSR;
> +	inode->i_mode = S_IFREG | S_IRUSR | S_IWUSR;
>  	inode->i_uid = current_fsuid();
>  	inode->i_gid = current_fsgid();
>  	inode->i_flags |= S_PRIVATE;
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index d64a4cbeb0da..809c3393b6a3 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -572,33 +572,11 @@ static int pidfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  	return -EOPNOTSUPP;
>  }
>  
> -
> -/*
> - * User space expects pidfs inodes to have no file type in st_mode.
> - *
> - * In particular, 'lsof' has this legacy logic:
> - *
> - *	type = s->st_mode & S_IFMT;
> - *	switch (type) {
> - *	  ...
> - *	case 0:
> - *		if (!strcmp(p, "anon_inode"))
> - *			Lf->ntype = Ntype = N_ANON_INODE;
> - *
> - * to detect our old anon_inode logic.
> - *
> - * Rather than mess with our internal sane inode data, just fix it
> - * up here in getattr() by masking off the format bits.
> - */
>  static int pidfs_getattr(struct mnt_idmap *idmap, const struct path *path,
>  			 struct kstat *stat, u32 request_mask,
>  			 unsigned int query_flags)
>  {
> -	struct inode *inode = d_inode(path->dentry);
> -
> -	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
> -	stat->mode &= ~S_IFMT;
> -	return 0;
> +	return anon_inode_getattr(idmap, path, stat, request_mask, query_flags);
>  }
>  
>  static const struct inode_operations pidfs_inode_operations = {
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

