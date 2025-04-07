Return-Path: <linux-fsdevel+bounces-45873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F562A7E0B0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 16:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BCE317329A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 14:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9131C8FB4;
	Mon,  7 Apr 2025 14:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OSP7h1So";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2ZCiF/uj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OSP7h1So";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2ZCiF/uj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38611C173D
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Apr 2025 14:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744034678; cv=none; b=KulRpziWEoZH/XeaV6zh5ydq4t2W/iMuc6UAb/Bm0CWbrO0gldMDysA0enzo0W9PUNf1v2J9rpSZXl9GuZ+GDo3HPZ1vjwSXe0WCvIWU8ZccMCUqBnLpRRAqHeN9HWCvXQWJuC2oo7LYvmPQq9kGFQko1PqZ03QOhx2rtuUh8us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744034678; c=relaxed/simple;
	bh=FWqH/TlKaEaF2RFgS1OR7yKIZYnOXDZD3FxeQBEaNzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRTAnYl9QPSVAftPEp84Re3vpsGzhitePDOTlTlWIAQSHws5HLAjkMwUNGNojx6lCGLr2BCYKlXqPwl4lKaNkRFHwlIkumzWa7WnGew/BySAqI+Deo3wKe6VrnUbEYsvHVMFxSc8fU5lvznODePGDDfB7eC0ISjvlV/CVH7WQ1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OSP7h1So; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2ZCiF/uj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OSP7h1So; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2ZCiF/uj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B38621F388;
	Mon,  7 Apr 2025 14:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744034673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ou56xQQ5EV1c/5D+sqPQx38AFdd4DRPJbrguRjWWZQw=;
	b=OSP7h1So2QsvoUzekwuG5fZVSFwKqYDG1JcesbPXR3PgS+0f1vlaUPQq+wdWq6aKPOzY9H
	Ep4lg98fHmtPSe9zoCEZya6zD2IE8pTZRhfxlryAoWngTMH0axXcClMpck3GfJ3sNI9u4W
	ueyDsWaXzgUNzP/+ad46fpoiemcoLW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744034673;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ou56xQQ5EV1c/5D+sqPQx38AFdd4DRPJbrguRjWWZQw=;
	b=2ZCiF/ujwVbl0UeycoadGdyFUiepLAJwbg8/ckA4rXPi1y9c0wvdXmR9loavBRawzm3jts
	8h5gHMMiQpU3R/Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=OSP7h1So;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="2ZCiF/uj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744034673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ou56xQQ5EV1c/5D+sqPQx38AFdd4DRPJbrguRjWWZQw=;
	b=OSP7h1So2QsvoUzekwuG5fZVSFwKqYDG1JcesbPXR3PgS+0f1vlaUPQq+wdWq6aKPOzY9H
	Ep4lg98fHmtPSe9zoCEZya6zD2IE8pTZRhfxlryAoWngTMH0axXcClMpck3GfJ3sNI9u4W
	ueyDsWaXzgUNzP/+ad46fpoiemcoLW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744034673;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ou56xQQ5EV1c/5D+sqPQx38AFdd4DRPJbrguRjWWZQw=;
	b=2ZCiF/ujwVbl0UeycoadGdyFUiepLAJwbg8/ckA4rXPi1y9c0wvdXmR9loavBRawzm3jts
	8h5gHMMiQpU3R/Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E77913A4B;
	Mon,  7 Apr 2025 14:04:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 712uJnHb82fdIQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 07 Apr 2025 14:04:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 40266A08D2; Mon,  7 Apr 2025 16:04:33 +0200 (CEST)
Date: Mon, 7 Apr 2025 16:04:33 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Penglei Jiang <superman.xpt@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH 1/9] anon_inode: use a proper mode internally
Message-ID: <o67hqkys5v76qwedbzn3wvln2czz4mhnhd4newph2h6rsmvsbi@rl4k2thv5zk5>
References: <20250407-work-anon_inode-v1-0-53a44c20d44e@kernel.org>
 <20250407-work-anon_inode-v1-1-53a44c20d44e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407-work-anon_inode-v1-1-53a44c20d44e@kernel.org>
X-Rspamd-Queue-Id: B38621F388
X-Spam-Score: -2.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,infradead.org,gmail.com,zeniv.linux.org.uk,suse.cz,kernel.org,toxicpanda.com,syzkaller.appspotmail.com];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TAGGED_RCPT(0.00)[5d8e79d323a13aa0b248];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim,appspotmail.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 07-04-25 11:54:15, Christian Brauner wrote:
> This allows the VFS to not trip over anonymous inodes and we can add
> asserts based on the mode into the vfs. When we report it to userspace
> we can simply hide the mode to avoid regressions. I've audited all
> direct callers of alloc_anon_inode() and only secretmen overrides i_mode
> and i_op inode operations but it already uses a regular file.
> 
> Fixes: af153bb63a336 ("vfs: catch invalid modes in may_open()")
> Cc: <stable@vger.kernel.org> # all LTS kernels
> Reported-by: syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/67ed3fb3.050a0220.14623d.0009.GAE@google.com
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/anon_inodes.c | 36 ++++++++++++++++++++++++++++++++++++
>  fs/internal.h    |  3 +++
>  fs/libfs.c       |  2 +-
>  3 files changed, 40 insertions(+), 1 deletion(-)
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
> 
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

