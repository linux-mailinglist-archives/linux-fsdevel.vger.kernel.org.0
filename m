Return-Path: <linux-fsdevel+bounces-42079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4B7A3C499
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 17:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F09E16C8ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 16:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8161FDE02;
	Wed, 19 Feb 2025 16:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cpaaKRdk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KlzLe4Mk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M3sIByfx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="b6v1/tOa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616051EB195
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2025 16:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739981472; cv=none; b=cJyIrVMnJCGf94TD6uhiizRcGnwNKbSuOm3BhaYkD1zrhWG+FBoFc1Lp+3N+ol9bHvLm8yw0QtU0JMunzJLFQnVscEnxECgEa3s37nIX805atO30Ec8Hpnx50RdP8DH/MuD2gIvHs2sFZvhj9z0Ai71lMDSKVcYlU9T4r0NpleY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739981472; c=relaxed/simple;
	bh=rEDgITclZccUZptmj/byUN4hZ2EPdkLu/kDgOTOs1qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4zdFyVTr9nbStLTAJ8fw9W2Yll6dyQqPfqfLB6bm1SpYIcbRWBeopCvvH2Nd8K5Ky/MFGqHtdSfGfeLn3Q9eRtveCr5nmh2XbAeu14bHfy0KJbpaYYxOwyKUOAX8m/S2IjDS0+8RVIbUhJUG1bim2a1HMyJxjt4vr07UlnUGRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cpaaKRdk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KlzLe4Mk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=M3sIByfx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=b6v1/tOa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6EB4C21259;
	Wed, 19 Feb 2025 16:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739981468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vp/OsR6plsZc24/y6aDwUmeA+X6wkOtO+CgkkXaeD9o=;
	b=cpaaKRdkZTQYjCXggB48djdBehJ1SHlRlrpmg0SGiPLswH09lSKBVUB62mu3Gs6xxUY9RJ
	0zlvnx2jfchhwa8OUL/WHtCUOagNnAqRtQxO92fJz1aPz+XrzCTpfQ5vFl1yNxdkhwZB/r
	hBvNGeyT5NV6VVbzw9tyfbVeBtk4Xno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739981468;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vp/OsR6plsZc24/y6aDwUmeA+X6wkOtO+CgkkXaeD9o=;
	b=KlzLe4MkgRf7AGbPDHVUCri3+eO1Jve+a0LgCoSsmWsBnebz+E+KNi6MydW/v7qe//KwZX
	mClIjGA/14XdQDCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=M3sIByfx;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="b6v1/tOa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739981467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vp/OsR6plsZc24/y6aDwUmeA+X6wkOtO+CgkkXaeD9o=;
	b=M3sIByfxPoeaTZK2XQ6wLPvC0+m+C+/sdv3byLNhQGtn/gpSGx8W3bbzF1rO3JnDeoMuLh
	JH76x3aYWYCWT6UwezHH7AKgmej27P1WMnIehIngWi4g49xzN+j9Prpqy8jpXL/9VJB4TC
	P3LGSyHZDnu8wVie9URTjkVc8/zPMNE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739981467;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vp/OsR6plsZc24/y6aDwUmeA+X6wkOtO+CgkkXaeD9o=;
	b=b6v1/tOaW6sx9ZsQimjIwAhbE+P4qRNHPRzb4se9cBtSIen75+0B4KFEP9ocBmmsHAJVik
	fwzeMxJCjhUc6nAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6616713715;
	Wed, 19 Feb 2025 16:11:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id akTnGJsCtmeJQgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 19 Feb 2025 16:11:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 19DA4A08A7; Wed, 19 Feb 2025 17:11:07 +0100 (CET)
Date: Wed, 19 Feb 2025 17:11:07 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: inline new_inode_pseudo() and de-staticize
 alloc_inode()
Message-ID: <vinprvobwukhgyjuurep2xdzanuqrf5wcvhzfhj7g5tpeflcsp@z3cyitdtssms>
References: <20250212180459.1022983-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212180459.1022983-1-mjguzik@gmail.com>
X-Rspamd-Queue-Id: 6EB4C21259
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 12-02-25 19:04:59, Mateusz Guzik wrote:
> The former is a no-op wrapper with the same argument.
> 
> I left it in place to not lose the information who needs it -- one day
> "pseudo" inodes may start differing from what alloc_inode() returns.
> 
> In the meantime no point taking a detour.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/inode.c         | 29 ++++++++++++-----------------
>  include/linux/fs.h |  6 +++++-
>  2 files changed, 17 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 5587aabdaa5e..6e251e43bf70 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -327,7 +327,17 @@ static void i_callback(struct rcu_head *head)
>  		free_inode_nonrcu(inode);
>  }
>  
> -static struct inode *alloc_inode(struct super_block *sb)
> +/**
> + *	alloc_inode 	- obtain an inode
> + *	@sb: superblock
> + *
> + *	Allocates a new inode for given superblock.
> + *	Inode wont be chained in superblock s_inodes list
> + *	This means :
> + *	- fs can't be unmount
> + *	- quotas, fsnotify, writeback can't work
> + */
> +struct inode *alloc_inode(struct super_block *sb)
>  {
>  	const struct super_operations *ops = sb->s_op;
>  	struct inode *inode;
> @@ -1159,21 +1169,6 @@ unsigned int get_next_ino(void)
>  }
>  EXPORT_SYMBOL(get_next_ino);
>  
> -/**
> - *	new_inode_pseudo 	- obtain an inode
> - *	@sb: superblock
> - *
> - *	Allocates a new inode for given superblock.
> - *	Inode wont be chained in superblock s_inodes list
> - *	This means :
> - *	- fs can't be unmount
> - *	- quotas, fsnotify, writeback can't work
> - */
> -struct inode *new_inode_pseudo(struct super_block *sb)
> -{
> -	return alloc_inode(sb);
> -}
> -
>  /**
>   *	new_inode 	- obtain an inode
>   *	@sb: superblock
> @@ -1190,7 +1185,7 @@ struct inode *new_inode(struct super_block *sb)
>  {
>  	struct inode *inode;
>  
> -	inode = new_inode_pseudo(sb);
> +	inode = alloc_inode(sb);
>  	if (inode)
>  		inode_sb_list_add(inode);
>  	return inode;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 640949116cf9..ac5d699e3aab 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3287,7 +3287,11 @@ static inline void __iget(struct inode *inode)
>  extern void iget_failed(struct inode *);
>  extern void clear_inode(struct inode *);
>  extern void __destroy_inode(struct inode *);
> -extern struct inode *new_inode_pseudo(struct super_block *sb);
> +struct inode *alloc_inode(struct super_block *sb);
> +static inline struct inode *new_inode_pseudo(struct super_block *sb)
> +{
> +	return alloc_inode(sb);
> +}
>  extern struct inode *new_inode(struct super_block *sb);
>  extern void free_inode_nonrcu(struct inode *inode);
>  extern int setattr_should_drop_suidgid(struct mnt_idmap *, struct inode *);
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

