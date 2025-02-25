Return-Path: <linux-fsdevel+bounces-42581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6795A44516
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 16:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25A2A19C5CBD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 15:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B161624E7;
	Tue, 25 Feb 2025 15:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vwOuaQdC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FiMIUyyz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vwOuaQdC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FiMIUyyz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4EC15E5A6
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2025 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740498959; cv=none; b=NukF1zxRBhahP7elKmlL9CBA6fbRpQpH8Syc7kSyl5zbo0qlS57ncBXS1uTRmq5oFK6sxmU6IMNh1VWjum8XEYgM7mtc6j9O2VUlHgccHs2tk5EBz/TiLaicWxaS5qvBaSlT4UAN57IQcWgUuuR+VsuaCyVgMsK3+FnhWzClHuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740498959; c=relaxed/simple;
	bh=Yy3jM36iTMsdO5AIUcVFx0m9QG4KupJ1fy9wsrWOgWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMSxFQNbz6ChB1DxqJZwcRhWdBONeEtDXKphy9yqcAlV2ylWMYdePLCzHtWY0DlJtXSo+TKwScrRhH027CChoTQmNASNApwOgLDntfsG34JjzunKespNXkqrI270AVDFCygw+V55HpRm7QVySBj1bYV5fg+8QmjKHqFcaYuyXTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vwOuaQdC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FiMIUyyz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vwOuaQdC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FiMIUyyz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 12F2621179;
	Tue, 25 Feb 2025 15:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740498956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KJGZclTLaBJ33Xe3VASnfQhQNoIstlz3AioMbNOAxrM=;
	b=vwOuaQdCnhkZ/NEPlN1HwfQpGf3EMHTLXKBy2BynZ+issixOfxUrztszC+yKr2rDiwzBaI
	ebIT76DPQZl0Kd5RRWFG25Wb+lh1o9xQdug1o5OkExLJnh8fG+jQd4zXomMrQZW5LCU3if
	evNsOVtmcQGACFUwYO5s7qiFVfW4BKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740498956;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KJGZclTLaBJ33Xe3VASnfQhQNoIstlz3AioMbNOAxrM=;
	b=FiMIUyyzvboUwIpGRBLF/AL7DUA35FbS+Mesnh4QImt1KWI4gKshbkZ5nJWBGISii7xdJV
	WPd4IcoREffFN7Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740498956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KJGZclTLaBJ33Xe3VASnfQhQNoIstlz3AioMbNOAxrM=;
	b=vwOuaQdCnhkZ/NEPlN1HwfQpGf3EMHTLXKBy2BynZ+issixOfxUrztszC+yKr2rDiwzBaI
	ebIT76DPQZl0Kd5RRWFG25Wb+lh1o9xQdug1o5OkExLJnh8fG+jQd4zXomMrQZW5LCU3if
	evNsOVtmcQGACFUwYO5s7qiFVfW4BKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740498956;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KJGZclTLaBJ33Xe3VASnfQhQNoIstlz3AioMbNOAxrM=;
	b=FiMIUyyzvboUwIpGRBLF/AL7DUA35FbS+Mesnh4QImt1KWI4gKshbkZ5nJWBGISii7xdJV
	WPd4IcoREffFN7Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 07A9813332;
	Tue, 25 Feb 2025 15:55:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VsnVAQzovWeGMwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 25 Feb 2025 15:55:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B6B15A0851; Tue, 25 Feb 2025 16:55:51 +0100 (CET)
Date: Tue, 25 Feb 2025 16:55:51 +0100
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, 
	Neil Brown <neilb@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 01/21] procfs: kill ->proc_dops
Message-ID: <7xagwr27m3ygguz7nv53u5up2jnzjbuhqcadzwjz7jzmafp4ct@rgkubaqwpwah>
References: <20250224141444.GX1977892@ZenIV>
 <20250224212051.1756517-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224212051.1756517-1-viro@zeniv.linux.org.uk>
X-Spam-Score: -3.80
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
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 24-02-25 21:20:31, Al Viro wrote:
> It has two possible values - one for "forced lookup" entries, another
> for the normal ones.  We'd be better off with that as an explicit
> flag anyway and in addition to that it opens some fun possibilities
> with ->d_op and ->d_flags handling.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

FWIW I went through the patches and I like them. They look mostly
straightforward enough to me and as good simplifications.

								Honza

> ---
>  fs/proc/generic.c  | 8 +++++---
>  fs/proc/internal.h | 5 +++--
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/proc/generic.c b/fs/proc/generic.c
> index 8ec90826a49e..499c2bf67488 100644
> --- a/fs/proc/generic.c
> +++ b/fs/proc/generic.c
> @@ -254,7 +254,10 @@ struct dentry *proc_lookup_de(struct inode *dir, struct dentry *dentry,
>  		inode = proc_get_inode(dir->i_sb, de);
>  		if (!inode)
>  			return ERR_PTR(-ENOMEM);
> -		d_set_d_op(dentry, de->proc_dops);
> +		if (de->flags & PROC_ENTRY_FORCE_LOOKUP)
> +			d_set_d_op(dentry, &proc_net_dentry_ops);
> +		else
> +			d_set_d_op(dentry, &proc_misc_dentry_ops);
>  		return d_splice_alias(inode, dentry);
>  	}
>  	read_unlock(&proc_subdir_lock);
> @@ -448,9 +451,8 @@ static struct proc_dir_entry *__proc_create(struct proc_dir_entry **parent,
>  	INIT_LIST_HEAD(&ent->pde_openers);
>  	proc_set_user(ent, (*parent)->uid, (*parent)->gid);
>  
> -	ent->proc_dops = &proc_misc_dentry_ops;
>  	/* Revalidate everything under /proc/${pid}/net */
> -	if ((*parent)->proc_dops == &proc_net_dentry_ops)
> +	if ((*parent)->flags & PROC_ENTRY_FORCE_LOOKUP)
>  		pde_force_lookup(ent);
>  
>  out:
> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> index 1695509370b8..07f75c959173 100644
> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -44,7 +44,6 @@ struct proc_dir_entry {
>  		const struct proc_ops *proc_ops;
>  		const struct file_operations *proc_dir_ops;
>  	};
> -	const struct dentry_operations *proc_dops;
>  	union {
>  		const struct seq_operations *seq_ops;
>  		int (*single_show)(struct seq_file *, void *);
> @@ -67,6 +66,8 @@ struct proc_dir_entry {
>  	char inline_name[];
>  } __randomize_layout;
>  
> +#define PROC_ENTRY_FORCE_LOOKUP 2 /* same space as PROC_ENTRY_PERMANENT */
> +
>  #define SIZEOF_PDE	(				\
>  	sizeof(struct proc_dir_entry) < 128 ? 128 :	\
>  	sizeof(struct proc_dir_entry) < 192 ? 192 :	\
> @@ -346,7 +347,7 @@ extern const struct dentry_operations proc_net_dentry_ops;
>  static inline void pde_force_lookup(struct proc_dir_entry *pde)
>  {
>  	/* /proc/net/ entries can be changed under us by setns(CLONE_NEWNET) */
> -	pde->proc_dops = &proc_net_dentry_ops;
> +	pde->flags |= PROC_ENTRY_FORCE_LOOKUP;
>  }
>  
>  /*
> -- 
> 2.39.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

