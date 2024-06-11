Return-Path: <linux-fsdevel+bounces-21398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B15D903852
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 12:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B7B51C23943
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 10:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCB8178CC3;
	Tue, 11 Jun 2024 10:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Esai4RR/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yZ5mIBS3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Esai4RR/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yZ5mIBS3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC158178CC0;
	Tue, 11 Jun 2024 10:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718100146; cv=none; b=in+2rFmexuRNMZxrEwPpZti/Nv9N7za4NsS07OqhVCZ+W7T9C5L+iKdZI0EV5WNrcW7lsmSzuLrAiPfELcol0tessCsUsZWfwd8p/NgMBrGb94YaHoZrr+/ac3ooLJPvYMG1Z/1ptg+KEVoB2Orbp7JIaaTO2Z7PLh/+h0TATcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718100146; c=relaxed/simple;
	bh=UtapOdxOaSjXwtjVW5+IoyBi6061b38o3u9Hnk0m79g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oea8KzlWSgLfJX+W1AcOZlDY5hepz22gSyVYxaOBrjDDbXqUofT/YTFZ8fTxPr7BwC7i+VtYUJhIKRqv70ZKP6pqMqCbAzGwWBHh7WCcCjD3yiuf9QX/xz7lhTgSMD8wzjjNoLWyiFTgQ4OafsiGABk3D+Cka4UkVLUl6xm30UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Esai4RR/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yZ5mIBS3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Esai4RR/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yZ5mIBS3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 06EF0336AB;
	Tue, 11 Jun 2024 10:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718100143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aRdLPpz05TLrSd9Pe6wJbv+oeSCC1gwmuyxznVlLb0k=;
	b=Esai4RR/eclizHU62RyZqlkBXoZNL9lI3aQiWnuZCUFEZ14b26K5wE2+eiTPB+mOx+OVLy
	aky/ORdcthXJoAJgeTzLrDtlHPTogSjoCS+bp68iac8NonhCYkFufheQHIjrp0rhMB5ArH
	78+vx2VclD06Dx9H6TzIEAKH8LFrzZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718100143;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aRdLPpz05TLrSd9Pe6wJbv+oeSCC1gwmuyxznVlLb0k=;
	b=yZ5mIBS3Hk4r6ql4p6sM4540HiZvwnGEhuZNPEeEp7Jk2L6XlwK79zBxnclI6Xchsz+HpG
	sAMKOQV3WZwE0oDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="Esai4RR/";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=yZ5mIBS3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718100143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aRdLPpz05TLrSd9Pe6wJbv+oeSCC1gwmuyxznVlLb0k=;
	b=Esai4RR/eclizHU62RyZqlkBXoZNL9lI3aQiWnuZCUFEZ14b26K5wE2+eiTPB+mOx+OVLy
	aky/ORdcthXJoAJgeTzLrDtlHPTogSjoCS+bp68iac8NonhCYkFufheQHIjrp0rhMB5ArH
	78+vx2VclD06Dx9H6TzIEAKH8LFrzZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718100143;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aRdLPpz05TLrSd9Pe6wJbv+oeSCC1gwmuyxznVlLb0k=;
	b=yZ5mIBS3Hk4r6ql4p6sM4540HiZvwnGEhuZNPEeEp7Jk2L6XlwK79zBxnclI6Xchsz+HpG
	sAMKOQV3WZwE0oDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E684313A55;
	Tue, 11 Jun 2024 10:02:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HT5FOK4gaGYffgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 11 Jun 2024 10:02:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 90FFFA0880; Tue, 11 Jun 2024 12:02:22 +0200 (CEST)
Date: Tue, 11 Jun 2024 12:02:22 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	dave@fromorbit.com, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: partially sanitize i_state zeroing on inode creation
Message-ID: <20240611100222.htl43626sklgso5p@quack3>
References: <20240611041540.495840-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611041540.495840-1-mjguzik@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 06EF0336AB
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Tue 11-06-24 06:15:40, Mateusz Guzik wrote:
> new_inode used to have the following:
> 	spin_lock(&inode_lock);
> 	inodes_stat.nr_inodes++;
> 	list_add(&inode->i_list, &inode_in_use);
> 	list_add(&inode->i_sb_list, &sb->s_inodes);
> 	inode->i_ino = ++last_ino;
> 	inode->i_state = 0;
> 	spin_unlock(&inode_lock);
> 
> over time things disappeared, got moved around or got replaced (global
> inode lock with a per-inode lock), eventually this got reduced to:
> 	spin_lock(&inode->i_lock);
> 	inode->i_state = 0;
> 	spin_unlock(&inode->i_lock);
> 
> But the lock acquire here does not synchronize against anyone.
> 
> Additionally iget5_locked performs i_state = 0 assignment without any
> locks to begin with and the two combined look confusing at best.
> 
> It looks like the current state is a leftover which was not cleaned up.
> 
> Ideally it would be an invariant that i_state == 0 to begin with, but
> achieving that would require dealing with all filesystem alloc handlers
> one by one.
> 
> In the meantime drop the misleading locking and move i_state zeroing to
> alloc_inode so that others don't need to deal with it by hand.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Good point. But the initialization would seem more natural in
inode_init_always(), wouldn't it? And that will also address your "FIXME"
comment.

								Honza

> ---
> 
> I diffed this against fs-next + my inode hash patch as it adds one
> i_state = 0 case. Should that patch not be accepted this bit can be
> easily dropped from this one.
> 
> I brought the entire thing up quite some time ago [1] and Dave Chinner
> noted that perhaps the lock has a side effect of providing memory
> barriers which otherwise would not be there and which are needed by
> someone.
> 
> For new_inode and alloc_inode consumers all fences are already there
> anyway due to immediate lock usage.
> 
> Arguably new_inode_pseudo escape without it but I don't find the code at
> hand to be affected in any meanignful way -- the only 2 consumers
> (get_pipe_inode and sock_alloc) perform numerous other stores to the
> inode immediately after. By the time it gets added to anything looking
> at i_state, flushing that should be handled by whatever thing which adds
> it. Mentioning this just in case.
> 
> [1] https://lore.kernel.org/all/CAGudoHF_Y0shcU+AMRRdN5RQgs9L_HHvBH8D4K=7_0X72kYy2g@mail.gmail.com/
> 
>  fs/inode.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 149adf8ab0ea..3967e68311a6 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -276,6 +276,10 @@ static struct inode *alloc_inode(struct super_block *sb)
>  		return NULL;
>  	}
>  
> +	/*
> +	 * FIXME: the code should be able to assert i_state == 0 instead.
> +	 */
> +	inode->i_state = 0;
>  	return inode;
>  }
>  
> @@ -1023,14 +1027,7 @@ EXPORT_SYMBOL(get_next_ino);
>   */
>  struct inode *new_inode_pseudo(struct super_block *sb)
>  {
> -	struct inode *inode = alloc_inode(sb);
> -
> -	if (inode) {
> -		spin_lock(&inode->i_lock);
> -		inode->i_state = 0;
> -		spin_unlock(&inode->i_lock);
> -	}
> -	return inode;
> +	return alloc_inode(sb);
>  }
>  
>  /**
> @@ -1254,7 +1251,6 @@ struct inode *iget5_locked(struct super_block *sb, unsigned long hashval,
>  		struct inode *new = alloc_inode(sb);
>  
>  		if (new) {
> -			new->i_state = 0;
>  			inode = inode_insert5(new, hashval, test, set, data);
>  			if (unlikely(inode != new))
>  				destroy_inode(new);
> @@ -1297,7 +1293,6 @@ struct inode *iget5_locked_rcu(struct super_block *sb, unsigned long hashval,
>  
>  	new = alloc_inode(sb);
>  	if (new) {
> -		new->i_state = 0;
>  		inode = inode_insert5(new, hashval, test, set, data);
>  		if (unlikely(inode != new))
>  			destroy_inode(new);
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

