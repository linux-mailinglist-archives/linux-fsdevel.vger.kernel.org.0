Return-Path: <linux-fsdevel+bounces-63771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 162E9BCD7D1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 16:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2FEBF356022
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 14:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FB72F6585;
	Fri, 10 Oct 2025 14:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RmurergB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lYE4q1Ib";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RmurergB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lYE4q1Ib"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFC480604
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 14:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760105939; cv=none; b=t0sQzQeSa5jyeFIN1sVjSwvHYZ6DA3bNJDH4Zn0qQ6yYpg9t4pRcdp0aC6q0wpDVrMkVPjptmOQHFhqO8FGN8SqenqU5WbHaM2YQUSR2i346xenHU/a7UScI/gJp0Os31PZZoIIjIV6JHM151ZGxq7t8HvE5bavsMjk78bkZlcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760105939; c=relaxed/simple;
	bh=Clt/ihAti6XuMRlb938uQSgUwBDmnttPKIgKZJerYrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFLuUF6YoqFpBmE5ErdOj3QXYg27xeCahKeA9dOLxz3/VIKvKn6qZ1ApuqtMZX+2Ovci9fNhUkf8M7DvwhAOFQeLnG+T49WddK16eck5T/tyoOWx3umD7tPHjwHqkqfMGhAqUjboQTzmIdl8sPcZT+lk1YdYi9xHNBXQ5StOn50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RmurergB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lYE4q1Ib; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RmurergB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lYE4q1Ib; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A3F491F397;
	Fri, 10 Oct 2025 14:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760105935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oykd9A9BzTtIcI7zroPK0XkkZV3Imzx0cziCFRRykjU=;
	b=RmurergBcb8nF/LSTvrw6eeVzEr59V2dMt3PmjfV1PBwGkYbTu2RrQxOgmrhEGJEslxvOp
	HCfwlf28dfxgkoEmlNvzrB4YUQmParYVtzjj97ckkW6bqdnMMaVaZsoeCSUID+JRXwQpWZ
	QiCWEEYsuUAy8iz3sMIoUVQw20dC2n0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760105935;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oykd9A9BzTtIcI7zroPK0XkkZV3Imzx0cziCFRRykjU=;
	b=lYE4q1IblmzVWkOj0lHfd9Jg6NlzthrK8LzWYzQoPJJqec6/YpxQOizbAuUkryGxI4Wr5C
	LBK8Db4e3MyOZnCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760105935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oykd9A9BzTtIcI7zroPK0XkkZV3Imzx0cziCFRRykjU=;
	b=RmurergBcb8nF/LSTvrw6eeVzEr59V2dMt3PmjfV1PBwGkYbTu2RrQxOgmrhEGJEslxvOp
	HCfwlf28dfxgkoEmlNvzrB4YUQmParYVtzjj97ckkW6bqdnMMaVaZsoeCSUID+JRXwQpWZ
	QiCWEEYsuUAy8iz3sMIoUVQw20dC2n0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760105935;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oykd9A9BzTtIcI7zroPK0XkkZV3Imzx0cziCFRRykjU=;
	b=lYE4q1IblmzVWkOj0lHfd9Jg6NlzthrK8LzWYzQoPJJqec6/YpxQOizbAuUkryGxI4Wr5C
	LBK8Db4e3MyOZnCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C35D1375D;
	Fri, 10 Oct 2025 14:18:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1jU5Is8V6WisDgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 10 Oct 2025 14:18:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 84449A28E2; Fri, 10 Oct 2025 16:18:54 +0200 (CEST)
Date: Fri, 10 Oct 2025 16:18:54 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	kernel-team@fb.com, amir73il@gmail.com, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v7 12/14] nilfs2: use the new ->i_state accessors
Message-ID: <cvpndcmciruukt46mshuhpldy6ox4uco6fmkook2h63fvxqikz@3wrruygkalem>
References: <20251009075929.1203950-1-mjguzik@gmail.com>
 <20251009075929.1203950-13-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009075929.1203950-13-mjguzik@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,vger.kernel.org,toxicpanda.com,fb.com,gmail.com];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Thu 09-10-25 09:59:26, Mateusz Guzik wrote:
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
>  fs/nilfs2/cpfile.c |  2 +-
>  fs/nilfs2/dat.c    |  2 +-
>  fs/nilfs2/ifile.c  |  2 +-
>  fs/nilfs2/inode.c  | 10 +++++-----
>  fs/nilfs2/sufile.c |  2 +-
>  5 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/nilfs2/cpfile.c b/fs/nilfs2/cpfile.c
> index bcc7d76269ac..4bbdc832d7f2 100644
> --- a/fs/nilfs2/cpfile.c
> +++ b/fs/nilfs2/cpfile.c
> @@ -1148,7 +1148,7 @@ int nilfs_cpfile_read(struct super_block *sb, size_t cpsize,
>  	cpfile = nilfs_iget_locked(sb, NULL, NILFS_CPFILE_INO);
>  	if (unlikely(!cpfile))
>  		return -ENOMEM;
> -	if (!(cpfile->i_state & I_NEW))
> +	if (!(inode_state_read_once(cpfile) & I_NEW))
>  		goto out;
>  
>  	err = nilfs_mdt_init(cpfile, NILFS_MDT_GFP, 0);
> diff --git a/fs/nilfs2/dat.c b/fs/nilfs2/dat.c
> index c664daba56ae..674380837ab9 100644
> --- a/fs/nilfs2/dat.c
> +++ b/fs/nilfs2/dat.c
> @@ -506,7 +506,7 @@ int nilfs_dat_read(struct super_block *sb, size_t entry_size,
>  	dat = nilfs_iget_locked(sb, NULL, NILFS_DAT_INO);
>  	if (unlikely(!dat))
>  		return -ENOMEM;
> -	if (!(dat->i_state & I_NEW))
> +	if (!(inode_state_read_once(dat) & I_NEW))
>  		goto out;
>  
>  	err = nilfs_mdt_init(dat, NILFS_MDT_GFP, sizeof(*di));
> diff --git a/fs/nilfs2/ifile.c b/fs/nilfs2/ifile.c
> index c4cd4a4dedd0..99eb8a59009e 100644
> --- a/fs/nilfs2/ifile.c
> +++ b/fs/nilfs2/ifile.c
> @@ -188,7 +188,7 @@ int nilfs_ifile_read(struct super_block *sb, struct nilfs_root *root,
>  	ifile = nilfs_iget_locked(sb, root, NILFS_IFILE_INO);
>  	if (unlikely(!ifile))
>  		return -ENOMEM;
> -	if (!(ifile->i_state & I_NEW))
> +	if (!(inode_state_read_once(ifile) & I_NEW))
>  		goto out;
>  
>  	err = nilfs_mdt_init(ifile, NILFS_MDT_GFP,
> diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
> index 87ddde159f0c..51bde45d5865 100644
> --- a/fs/nilfs2/inode.c
> +++ b/fs/nilfs2/inode.c
> @@ -365,7 +365,7 @@ struct inode *nilfs_new_inode(struct inode *dir, umode_t mode)
>  
>   failed_after_creation:
>  	clear_nlink(inode);
> -	if (inode->i_state & I_NEW)
> +	if (inode_state_read_once(inode) & I_NEW)
>  		unlock_new_inode(inode);
>  	iput(inode);  /*
>  		       * raw_inode will be deleted through
> @@ -562,7 +562,7 @@ struct inode *nilfs_iget(struct super_block *sb, struct nilfs_root *root,
>  	if (unlikely(!inode))
>  		return ERR_PTR(-ENOMEM);
>  
> -	if (!(inode->i_state & I_NEW)) {
> +	if (!(inode_state_read_once(inode) & I_NEW)) {
>  		if (!inode->i_nlink) {
>  			iput(inode);
>  			return ERR_PTR(-ESTALE);
> @@ -591,7 +591,7 @@ struct inode *nilfs_iget_for_gc(struct super_block *sb, unsigned long ino,
>  	inode = iget5_locked(sb, ino, nilfs_iget_test, nilfs_iget_set, &args);
>  	if (unlikely(!inode))
>  		return ERR_PTR(-ENOMEM);
> -	if (!(inode->i_state & I_NEW))
> +	if (!(inode_state_read_once(inode) & I_NEW))
>  		return inode;
>  
>  	err = nilfs_init_gcinode(inode);
> @@ -631,7 +631,7 @@ int nilfs_attach_btree_node_cache(struct inode *inode)
>  				  nilfs_iget_set, &args);
>  	if (unlikely(!btnc_inode))
>  		return -ENOMEM;
> -	if (btnc_inode->i_state & I_NEW) {
> +	if (inode_state_read_once(btnc_inode) & I_NEW) {
>  		nilfs_init_btnc_inode(btnc_inode);
>  		unlock_new_inode(btnc_inode);
>  	}
> @@ -686,7 +686,7 @@ struct inode *nilfs_iget_for_shadow(struct inode *inode)
>  			       nilfs_iget_set, &args);
>  	if (unlikely(!s_inode))
>  		return ERR_PTR(-ENOMEM);
> -	if (!(s_inode->i_state & I_NEW))
> +	if (!(inode_state_read_once(s_inode) & I_NEW))
>  		return inode;
>  
>  	NILFS_I(s_inode)->i_flags = 0;
> diff --git a/fs/nilfs2/sufile.c b/fs/nilfs2/sufile.c
> index 330f269abedf..83f93337c01b 100644
> --- a/fs/nilfs2/sufile.c
> +++ b/fs/nilfs2/sufile.c
> @@ -1226,7 +1226,7 @@ int nilfs_sufile_read(struct super_block *sb, size_t susize,
>  	sufile = nilfs_iget_locked(sb, NULL, NILFS_SUFILE_INO);
>  	if (unlikely(!sufile))
>  		return -ENOMEM;
> -	if (!(sufile->i_state & I_NEW))
> +	if (!(inode_state_read_once(sufile) & I_NEW))
>  		goto out;
>  
>  	err = nilfs_mdt_init(sufile, NILFS_MDT_GFP, sizeof(*sui));
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

