Return-Path: <linux-fsdevel+bounces-23957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5037A93527A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 22:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E64D52820E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 20:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A352D145B1B;
	Thu, 18 Jul 2024 20:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CwQXc5aC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3TFas+F3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="D+ZeWRmY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SZjz36ZN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E97143C54;
	Thu, 18 Jul 2024 20:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721335218; cv=none; b=nSUf6qOUU3XXBl10vMFARiCX+pgcs3rKc9IK8a6BzAw9ieFC7WE123yFcKFllGzg4CW5gKjo3y0pUhgh3Le8R6V2JSTUbkZOkkswearH7IV5hJQHmJeSe1r97R1XdidKdnfD0ikuxiahzknjHWvUwqVz41QXw8L4iUsQV4zobMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721335218; c=relaxed/simple;
	bh=QivVf0yOJ4j9FWAgm7rYE+HpDApzpZa/B0WyGW+kKVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uadJofNR12Ax0UtQpwbICwFMxJeJp61KRuBI+b5NN2cAiFhMXeAj3S0Sm2MAnXi7CfSiF707KV2KU1N4tFHds+ozAFefJq8hvKHY4MnzUrdoOJC5rtqjKRrqbLVYrDbmFuYLiHe3OnAsMYBVRihnhCnWiZ/c8wRe4XIVSXNSua4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CwQXc5aC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3TFas+F3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=D+ZeWRmY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SZjz36ZN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1CBF721C30;
	Thu, 18 Jul 2024 20:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721335214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=82lPptaZbhKCSi1vGqHZHbBmsVDaEQXXJeWHUMbZyII=;
	b=CwQXc5aCeoEaYQ9XiULmidgV2142YcqVZ9csbDWRUutHH7tD3OAUGQyh+jhIQgzDOUBEoF
	lxGCvZFEX85wpFr3/efKpQI1Cw4DisSsp6daMWlyY0ZYPSg1aAruRa8F2WEytwvOOkkKC7
	EytZwa3TUPmMT10DgR3LNJneCjQ5lj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721335214;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=82lPptaZbhKCSi1vGqHZHbBmsVDaEQXXJeWHUMbZyII=;
	b=3TFas+F39BetoT5zCbnbLDWnqBIbRPJrvIgleTBKnuJ8AZvYY+/f2W5HRhL1cwiP9CFtCn
	D+D04Wp34SXawuDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721335213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=82lPptaZbhKCSi1vGqHZHbBmsVDaEQXXJeWHUMbZyII=;
	b=D+ZeWRmY6Nvf5CYCPoS5o8+ViBZUaYym0unMu6LBP00Pmh3VKqDnWHrItVDHzFeCpitu3p
	OPYr5hj1Evns5FDXH48v0E784RbEj114RVJmi9lbG8Xu/rX5seec8567B04f0u/i0QYcNY
	KKeQysFGXYDRtaJsz8u7XSrF9zdyrlI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721335213;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=82lPptaZbhKCSi1vGqHZHbBmsVDaEQXXJeWHUMbZyII=;
	b=SZjz36ZNJV4zkutOwS5CEa1Ko8dUwk6/eeFMjePho18EQq0Z+2ZR/fxdETFLeixqWwXVen
	oHv25rZDX9DI9sAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10684136F7;
	Thu, 18 Jul 2024 20:40:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G1r3A619mWbAfwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 18 Jul 2024 20:40:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A61ABA0987; Thu, 18 Jul 2024 22:40:12 +0200 (CEST)
Date: Thu, 18 Jul 2024 22:40:12 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Dominique Martinet <asmadeus@codewreck.org>,
	Jakub Kicinski <kuba@kernel.org>, v9fs@lists.linux.dev
Subject: Re: [PATCH] vfs: handle __wait_on_freeing_inode() and evict() race
Message-ID: <20240718204012.x4ysnjmvjh5v2zf3@quack3>
References: <20240718151838.611807-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718151838.611807-1-mjguzik@gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email,codewreck.org:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Thu 18-07-24 17:18:37, Mateusz Guzik wrote:
> Lockless hash lookup can find and lock the inode after it gets the
> I_FREEING flag set, at which point it blocks waiting for teardown in
> evict() to finish.
> 
> However, the flag is still set even after evict() wakes up all waiters.
> 
> This results in a race where if the inode lock is taken late enough, it
> can happen after both hash removal and wakeups, meaning there is nobody
> to wake the racing thread up.
> 
> This worked prior to RCU-based lookup because the entire ordeal was
> synchronized with the inode hash lock.
> 
> Since unhashing requires the inode lock, we can safely check whether it
> happened after acquiring it.
> 
> Link: https://lore.kernel.org/v9fs/20240717102458.649b60be@kernel.org/
> Reported-by: Dominique Martinet <asmadeus@codewreck.org>
> Fixes: 7180f8d91fcb ("vfs: add rcu-based find_inode variants for iget ops")
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> The 'fixes' tag is contingent on testing by someone else. :>
> 
> I have 0 experience with 9pfs and the docs failed me vs getting it
> running on libvirt+qemu, so I gave up on trying to test it myself.
> 
> Dominique, you offered to narrow things down here, assuming the offer
> stands I would appreciate if you got this sorted out :)
> 
> Even if the patch in the current form does not go in, it should be
> sufficient to confirm the problem diagnosis is correct.
> 
> A debug printk can be added to validate the problematic condition was
> encountered, for example:
> 
> > diff --git a/fs/inode.c b/fs/inode.c
> > index 54e0be80be14..8f61fad0bc69 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -2308,6 +2308,7 @@ static void __wait_on_freeing_inode(struct inode *inode, bool locked)
> >         if (unlikely(inode_unhashed(inode))) {
> >                 BUG_ON(locked);
> >                 spin_unlock(&inode->i_lock);
> > +               printk(KERN_EMERG "%s: got unhashed inode %p\n", __func__, inode);
> >                 return;
> >         }
> 
> 
>  fs/inode.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index f356fe2ec2b6..54e0be80be14 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -676,6 +676,16 @@ static void evict(struct inode *inode)
>  
>  	remove_inode_hash(inode);
>  
> +	/*
> +	 * Wake up waiters in __wait_on_freeing_inode().
> +	 *
> +	 * Lockless hash lookup may end up finding the inode before we removed
> +	 * it above, but only lock it *after* we are done with the wakeup below.
> +	 * In this case the potential waiter cannot safely block.
> +	 *
> +	 * The inode being unhashed after the call to remove_inode_hash() is
> +	 * used as an indicator whether blocking on it is safe.
> +	 */
>  	spin_lock(&inode->i_lock);
>  	wake_up_bit(&inode->i_state, __I_NEW);
>  	BUG_ON(inode->i_state != (I_FREEING | I_CLEAR));
> @@ -2291,6 +2301,16 @@ static void __wait_on_freeing_inode(struct inode *inode, bool locked)
>  {
>  	wait_queue_head_t *wq;
>  	DEFINE_WAIT_BIT(wait, &inode->i_state, __I_NEW);
> +
> +	/*
> +	 * Handle racing against evict(), see that routine for more details.
> +	 */
> +	if (unlikely(inode_unhashed(inode))) {
> +		BUG_ON(locked);
> +		spin_unlock(&inode->i_lock);
> +		return;
> +	}
> +
>  	wq = bit_waitqueue(&inode->i_state, __I_NEW);
>  	prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
>  	spin_unlock(&inode->i_lock);
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

