Return-Path: <linux-fsdevel+bounces-21519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBDC904F39
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 11:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A72A91C2156A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 09:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDFF16DEB3;
	Wed, 12 Jun 2024 09:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0eUc1FPJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tdrX+aHq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q0YNd/FY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="c0RJ1UZB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E3516D9C6;
	Wed, 12 Jun 2024 09:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718184427; cv=none; b=ir2g/KHCeSuZx/GGVHGGiKltb8RDM8PazXGOrXpXUM8qpq1Kdb4vo9HpqA+rOUR3O08AWE3Vu2AqI3T42S9LRbsYj0lEUqzjqkKRBjcfh0exNupyeultlIl1vv0KKOw1ONyJcs30OzM+Ak/R8y8vv24yCkatUKkuGz5qRk6yoGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718184427; c=relaxed/simple;
	bh=Xu299l6Ta8mKb4nVWFkojbWgWy2H6Gu131pvTyWxq+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVaAu/44apXQVu5dIJtYFYwKA689zAM+CDVm7poHWVLlAErZTTj6gbrKCsusT+TXA0rBaHquYrJKNErHeQBFcy+jBjcginyyUJaOTS4JBjdoCwrphFUW0oFkRnjjXc4gLYiG8uV1GFijUAifZ+pkq1TCMkf8ZWBRl8kBpxzvAAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0eUc1FPJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tdrX+aHq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q0YNd/FY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=c0RJ1UZB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D6F6D34229;
	Wed, 12 Jun 2024 09:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718184424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gYE6wHsRVZXT/1LfXcwYHZ1w+B8WavL0Dr06xOj6qzs=;
	b=0eUc1FPJGOj6WoK8oXDEims9dtSdfB4tHJ5NmUgKoG8Qk5osNOiNBK4F5cV+TmttLXb4Le
	dSk8mqhBYbv0OmvhjPBHY5DtIvxZssoxXjuPs9jwHagI8UHe9BTgkeorPQM9J27DJjT4xR
	ISU5w32fcbn3R1NIJiU0PE/dzFciU9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718184424;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gYE6wHsRVZXT/1LfXcwYHZ1w+B8WavL0Dr06xOj6qzs=;
	b=tdrX+aHqkWE78c9fv8+pVzfCsTeAvy1/VPvtHh2JfTbqVh++eMNuR3bhVjAwIokylspKpg
	oz5+VuLTTEmBJKAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="Q0YNd/FY";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=c0RJ1UZB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718184423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gYE6wHsRVZXT/1LfXcwYHZ1w+B8WavL0Dr06xOj6qzs=;
	b=Q0YNd/FYoLuhXfhES+rir1Y5nkpZ+fg5wrgqDat3NF5TBj6VntjYSKOTCXHBycemuiUWNz
	r8UUAjA0yW9CdZQZlNg0oljC/AjWE3uki0OHp7r9vzkPKkjtK+Jf0tDgWvImkCVbUvSDkV
	WNvzIUlSJWPiwlCdfmlwK+Ugx7r6YGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718184423;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gYE6wHsRVZXT/1LfXcwYHZ1w+B8WavL0Dr06xOj6qzs=;
	b=c0RJ1UZBQdVp7g62ngUI5LbfCq5ofkcHpZv0C+sCOn75I3cRG505lzvXrExkE9jo1oV1Gu
	1gSh4weIny6JyqBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2050137DF;
	Wed, 12 Jun 2024 09:27:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZRUcL+dpaWaCbQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 12 Jun 2024 09:27:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 847DEA0884; Wed, 12 Jun 2024 11:27:03 +0200 (CEST)
Date: Wed, 12 Jun 2024 11:27:03 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, kent.overstreet@linux.dev,
	linux-xfs@vger.kernel.org, david@fromorbit.com
Subject: Re: [PATCH v2 2/4] vfs: partially sanitize i_state zeroing on inode
 creation
Message-ID: <20240612092703.u5ialfzz74pfnafk@quack3>
References: <20240611120626.513952-1-mjguzik@gmail.com>
 <20240611120626.513952-3-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611120626.513952-3-mjguzik@gmail.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D6F6D34229
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Tue 11-06-24 14:06:24, Mateusz Guzik wrote:
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
> locks to begin with, the two combined look confusing at best.
> 
> It looks like the current state is a leftover which was not cleaned up.
> 
> Ideally it would be an invariant that i_state == 0 to begin with, but
> achieving that would require dealing with all filesystem alloc handlers
> one by one.
> 
> In the meantime drop the misleading locking and move i_state zeroing to
> inode_init_always so that others don't need to deal with it by hand.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Just one nit below:

> diff --git a/fs/inode.c b/fs/inode.c
> index 3a4c67bfe085..8f05d79de01d 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -231,6 +231,8 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
>  
>  	if (unlikely(security_inode_alloc(inode)))
>  		return -ENOMEM;
> +
> +	inode->i_state = 0;
>  	this_cpu_inc(nr_inodes);

This would be more logical above where inode content is initialized (and
less errorprone just in case security_inode_alloc() grows dependency on
i_state value) - like just after:

	inode->i_flags = 0;

With that fixed feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

