Return-Path: <linux-fsdevel+bounces-21114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2868FF287
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 18:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ADC22837D3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 16:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA33196DBA;
	Thu,  6 Jun 2024 16:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K0lP7RQL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+jvMGAFj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K0lP7RQL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+jvMGAFj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A934437;
	Thu,  6 Jun 2024 16:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717691485; cv=none; b=pG+O97B9HJjllXY7aYgBXi2zosstEXcrSGakj6uBuF/t9HAALgJ/lPMTLPGKoFW06iwYBdteY9Es4j9Yo1hOj8FdjAbbmM94FntHPZvIZfiJphK/mMrGWyffykzagXcAWdu1i7jZH1poJaL06cA9IpR7wMAagHAxQVWvUIVUO30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717691485; c=relaxed/simple;
	bh=OCZO1OAFIJX6cewO5H0eUUgYYJY3miByAmr5NURRsvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a34avWX7CbA8VO2/4HDn7FwLHzJqwaZpv7OOD8Nx98aP4faQbBmQyi0yjB0zA0N87FhSWzElT6T05KEVUGyQCZjzWpB/3G2uENsqOw0ix5l/cYiZ8hqjTPXMjGmqooJepRBaZeswrnf/joH0oqhQViCmpVOvBtVs1j/uxU8WYNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K0lP7RQL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+jvMGAFj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K0lP7RQL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+jvMGAFj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 999F41FB45;
	Thu,  6 Jun 2024 16:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717691480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sCiuMsOM1H9RBCyePUM1/0Ht1runZh9mrvpn13u8UM4=;
	b=K0lP7RQLSYRUbY7FRGI9bZ+o0H9G4zqrAsYqKYyJfZDr+AhflqCPdWdM/2OFTKR8StzjyM
	coRchP0vp2H7jAYVVZN7TewQLtK/7vksnSz9yYQG/810A8DXulcTJKJeoGU602LPnjzUD4
	4Z2bAKwYudCpMrUdPlist4NBwGJk0K0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717691480;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sCiuMsOM1H9RBCyePUM1/0Ht1runZh9mrvpn13u8UM4=;
	b=+jvMGAFjkI94uB85BXqvOJb49Sb94uMBzJPRjUCzx5V3M4BWXaoNcgiPEV7bPeWdFWFjR+
	aFvDqU+FY11oNLBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717691480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sCiuMsOM1H9RBCyePUM1/0Ht1runZh9mrvpn13u8UM4=;
	b=K0lP7RQLSYRUbY7FRGI9bZ+o0H9G4zqrAsYqKYyJfZDr+AhflqCPdWdM/2OFTKR8StzjyM
	coRchP0vp2H7jAYVVZN7TewQLtK/7vksnSz9yYQG/810A8DXulcTJKJeoGU602LPnjzUD4
	4Z2bAKwYudCpMrUdPlist4NBwGJk0K0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717691480;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sCiuMsOM1H9RBCyePUM1/0Ht1runZh9mrvpn13u8UM4=;
	b=+jvMGAFjkI94uB85BXqvOJb49Sb94uMBzJPRjUCzx5V3M4BWXaoNcgiPEV7bPeWdFWFjR+
	aFvDqU+FY11oNLBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 851E313A1E;
	Thu,  6 Jun 2024 16:31:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ma40IFjkYWatBQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 06 Jun 2024 16:31:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1C064A0887; Thu,  6 Jun 2024 18:31:16 +0200 (CEST)
Date: Thu, 6 Jun 2024 18:31:16 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] vfs: add rcu-based find_inode variants for iget ops
Message-ID: <20240606163116.fnblztdlbp7sqjt6@quack3>
References: <20240606140515.216424-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606140515.216424-1-mjguzik@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]

On Thu 06-06-24 16:05:15, Mateusz Guzik wrote:
> Instantiating a new inode normally takes the global inode hash lock
> twice:
> 1. once to check if it happens to already be present
> 2. once to add it to the hash
> 
> The back-to-back lock/unlock pattern is known to degrade performance
> significantly, which is further exacerbated if the hash is heavily
> populated (long chains to walk, extending hold time). Arguably hash
> sizing and hashing algo need to be revisited, but that's beyond the
> scope of this patch.
> 
> A long term fix would introduce fine-grained locking, this was attempted
> in [1], but that patchset was already posted several times and appears
> stalled.
> 
> A simpler idea which solves majority of the problem and which may be
> good enough for the time being is to use RCU for the initial lookup.
> Basic RCU support is already present in the hash, it is just not being
> used for lookup on inode creation.
> 
> iget_locked consumers (notably ext4) get away without any changes
> because inode comparison method is built-in.
> 
> iget5_locked and ilookup5_nowait consumers pass a custom callback. Since
> removal of locking adds more problems (inode can be changing) it's not
> safe to assume all filesystems happen to cope.  Thus iget5_locked_rcu
> ilookup5_nowait_rcu get added, requiring manual conversion.

BTW, why not ilookup5_rcu() as well? To keep symmetry with non-RCU APIs and
iget5_locked_rcu() could then use ilookup5_rcu(). I presume eventually we'd
like to trasition everything to these RCU based methods?

> In order to reduce code duplication find_inode and find_inode_fast grow
> an argument indicating whether inode hash lock is held, which is passed
> down should sleeping be necessary. They always rcu_read_lock, which is
> redundant but harmless. Doing it conditionally reduces readability for
> no real gain that I can see. RCU-alike restrictions were already put on
> callbacks due to the hash spinlock being held.
> 
> Benchmarked with the following: a 32-core vm with 24GB of RAM, a
> dedicated fs partition. 20 separate trees with 1000 directories * 1000
> files.  Then walked by 20 processes issuing stat on files, each on a
> dedicated tree. Testcase is at [2].
> 
> In this particular workload, mimicking a real-world setup $elsewhere,
> the initial lookup is guaranteed to fail, guaranteeing the 2 lock
> acquires. At the same time RAM is scarce enough enough compared to the
> demand that inodes keep needing to be recycled.
> 
> Total real time fluctuates by 1-2s, sample results:
> 
> ext4 (needed mkfs.ext4 -N 24000000):
> before:	3.77s user 890.90s system 1939% cpu 46.118 total
> after:  3.24s user 397.73s system 1858% cpu 21.581 total (-53%)
> 
> btrfs (s/iget5_locked/iget5_locked_rcu in fs/btrfs/inode.c):
> before: 3.54s user 892.30s system 1966% cpu 45.549 total
> after:  3.28s user 738.66s system 1955% cpu 37.932 total (-16.7%)
> 
> btrfs is heavily bottlenecked on its own locks, so the improvement is
> small in comparison.
> 
> [1] https://lore.kernel.org/all/20231206060629.2827226-1-david@fromorbit.com/
> [2] https://people.freebsd.org/~mjg/fstree.tgz

Nice results. I've looked through the patch and otherwise I didn't find any
issue.

								Honza

> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
> 
> This is an initial submission to gauge interest.
> 
> I do claim this provides great bang for the buck, I don't claim it
> solves the problem overall. *something* finer-grained will need to
> land.
> 
> I wanted to add bcachefs to the list, but I ran into memory reclamation
> issues again (first time here:
> https://lore.kernel.org/all/CAGudoHGenxzk0ZqPXXi1_QDbfqQhGHu+wUwzyS6WmfkUZ1HiXA@mail.gmail.com/),
> did not have time to mess with diagnostic to write a report yet.
> 
> I'll post a patchset with this (+ tidy ups to comments and whatnot) +
> btrfs + bcachefs conversion after the above gets reported and sorted
> out.
> 
> Also interestingly things improved since last year, when Linux needed
> about a minute.
> 
>  fs/inode.c         | 106 +++++++++++++++++++++++++++++++++++++--------
>  include/linux/fs.h |  10 ++++-
>  2 files changed, 98 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 3a41f83a4ba5..f40b868f491f 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -886,36 +886,43 @@ long prune_icache_sb(struct super_block *sb, struct shrink_control *sc)
>  	return freed;
>  }
>  
> -static void __wait_on_freeing_inode(struct inode *inode);
> +static void __wait_on_freeing_inode(struct inode *inode, bool locked);
>  /*
>   * Called with the inode lock held.
>   */
>  static struct inode *find_inode(struct super_block *sb,
>  				struct hlist_head *head,
>  				int (*test)(struct inode *, void *),
> -				void *data)
> +				void *data, bool locked)
>  {
>  	struct inode *inode = NULL;
>  
> +	if (locked)
> +		lockdep_assert_held(&inode_hash_lock);
> +
> +	rcu_read_lock();
>  repeat:
> -	hlist_for_each_entry(inode, head, i_hash) {
> +	hlist_for_each_entry_rcu(inode, head, i_hash) {
>  		if (inode->i_sb != sb)
>  			continue;
>  		if (!test(inode, data))
>  			continue;
>  		spin_lock(&inode->i_lock);
>  		if (inode->i_state & (I_FREEING|I_WILL_FREE)) {
> -			__wait_on_freeing_inode(inode);
> +			__wait_on_freeing_inode(inode, locked);
>  			goto repeat;
>  		}
>  		if (unlikely(inode->i_state & I_CREATING)) {
>  			spin_unlock(&inode->i_lock);
> +			rcu_read_unlock();
>  			return ERR_PTR(-ESTALE);
>  		}
>  		__iget(inode);
>  		spin_unlock(&inode->i_lock);
> +		rcu_read_unlock();
>  		return inode;
>  	}
> +	rcu_read_unlock();
>  	return NULL;
>  }
>  
> @@ -924,29 +931,37 @@ static struct inode *find_inode(struct super_block *sb,
>   * iget_locked for details.
>   */
>  static struct inode *find_inode_fast(struct super_block *sb,
> -				struct hlist_head *head, unsigned long ino)
> +				struct hlist_head *head, unsigned long ino,
> +				bool locked)
>  {
>  	struct inode *inode = NULL;
>  
> +	if (locked)
> +		lockdep_assert_held(&inode_hash_lock);
> +
> +	rcu_read_lock();
>  repeat:
> -	hlist_for_each_entry(inode, head, i_hash) {
> +	hlist_for_each_entry_rcu(inode, head, i_hash) {
>  		if (inode->i_ino != ino)
>  			continue;
>  		if (inode->i_sb != sb)
>  			continue;
>  		spin_lock(&inode->i_lock);
>  		if (inode->i_state & (I_FREEING|I_WILL_FREE)) {
> -			__wait_on_freeing_inode(inode);
> +			__wait_on_freeing_inode(inode, locked);
>  			goto repeat;
>  		}
>  		if (unlikely(inode->i_state & I_CREATING)) {
>  			spin_unlock(&inode->i_lock);
> +			rcu_read_unlock();
>  			return ERR_PTR(-ESTALE);
>  		}
>  		__iget(inode);
>  		spin_unlock(&inode->i_lock);
> +		rcu_read_unlock();
>  		return inode;
>  	}
> +	rcu_read_unlock();
>  	return NULL;
>  }
>  
> @@ -1161,7 +1176,7 @@ struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
>  
>  again:
>  	spin_lock(&inode_hash_lock);
> -	old = find_inode(inode->i_sb, head, test, data);
> +	old = find_inode(inode->i_sb, head, test, data, true);
>  	if (unlikely(old)) {
>  		/*
>  		 * Uhhuh, somebody else created the same inode under us.
> @@ -1245,6 +1260,43 @@ struct inode *iget5_locked(struct super_block *sb, unsigned long hashval,
>  }
>  EXPORT_SYMBOL(iget5_locked);
>  
> +/**
> + * iget5_locked_rcu - obtain an inode from a mounted file system
> + *
> + * This is equivalent to iget5_locked, except the @test callback must
> + * tolerate inode not being stable, including being mid-teardown.
> + */
> +struct inode *iget5_locked_rcu(struct super_block *sb, unsigned long hashval,
> +		int (*test)(struct inode *, void *),
> +		int (*set)(struct inode *, void *), void *data)
> +{
> +	struct hlist_head *head = inode_hashtable + hash(sb, hashval);
> +	struct inode *inode, *new;
> +
> +again:
> +	inode = find_inode(sb, head, test, data, false);
> +	if (inode) {
> +		if (IS_ERR(inode))
> +			return NULL;
> +		wait_on_inode(inode);
> +		if (unlikely(inode_unhashed(inode))) {
> +			iput(inode);
> +			goto again;
> +		}
> +		return inode;
> +	}
> +
> +	new = alloc_inode(sb);
> +	if (new) {
> +		new->i_state = 0;
> +		inode = inode_insert5(new, hashval, test, set, data);
> +		if (unlikely(inode != new))
> +			destroy_inode(new);
> +	}
> +	return inode;
> +}
> +EXPORT_SYMBOL(iget5_locked_rcu);
> +
>  /**
>   * iget_locked - obtain an inode from a mounted file system
>   * @sb:		super block of file system
> @@ -1263,9 +1315,7 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
>  	struct hlist_head *head = inode_hashtable + hash(sb, ino);
>  	struct inode *inode;
>  again:
> -	spin_lock(&inode_hash_lock);
> -	inode = find_inode_fast(sb, head, ino);
> -	spin_unlock(&inode_hash_lock);
> +	inode = find_inode_fast(sb, head, ino, false);
>  	if (inode) {
>  		if (IS_ERR(inode))
>  			return NULL;
> @@ -1283,7 +1333,7 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
>  
>  		spin_lock(&inode_hash_lock);
>  		/* We released the lock, so.. */
> -		old = find_inode_fast(sb, head, ino);
> +		old = find_inode_fast(sb, head, ino, true);
>  		if (!old) {
>  			inode->i_ino = ino;
>  			spin_lock(&inode->i_lock);
> @@ -1419,13 +1469,31 @@ struct inode *ilookup5_nowait(struct super_block *sb, unsigned long hashval,
>  	struct inode *inode;
>  
>  	spin_lock(&inode_hash_lock);
> -	inode = find_inode(sb, head, test, data);
> +	inode = find_inode(sb, head, test, data, true);
>  	spin_unlock(&inode_hash_lock);
>  
>  	return IS_ERR(inode) ? NULL : inode;
>  }
>  EXPORT_SYMBOL(ilookup5_nowait);
>  
> +/**
> + * ilookup5_nowait_rcu - search for an inode in the inode cache
> + *
> + * This is equivalent to ilookup5_nowait, except the @test callback must
> + * tolerate inode not being stable, including being mid-teardown.
> + */
> +struct inode *ilookup5_nowait_rcu(struct super_block *sb, unsigned long hashval,
> +		int (*test)(struct inode *, void *), void *data)
> +{
> +	struct hlist_head *head = inode_hashtable + hash(sb, hashval);
> +	struct inode *inode;
> +
> +	inode = find_inode(sb, head, test, data, false);
> +
> +	return IS_ERR(inode) ? NULL : inode;
> +}
> +EXPORT_SYMBOL(ilookup5_nowait_rcu);
> +
>  /**
>   * ilookup5 - search for an inode in the inode cache
>   * @sb:		super block of file system to search
> @@ -1474,7 +1542,7 @@ struct inode *ilookup(struct super_block *sb, unsigned long ino)
>  	struct inode *inode;
>  again:
>  	spin_lock(&inode_hash_lock);
> -	inode = find_inode_fast(sb, head, ino);
> +	inode = find_inode_fast(sb, head, ino, true);
>  	spin_unlock(&inode_hash_lock);
>  
>  	if (inode) {
> @@ -2235,17 +2303,21 @@ EXPORT_SYMBOL(inode_needs_sync);
>   * wake_up_bit(&inode->i_state, __I_NEW) after removing from the hash list
>   * will DTRT.
>   */
> -static void __wait_on_freeing_inode(struct inode *inode)
> +static void __wait_on_freeing_inode(struct inode *inode, bool locked)
>  {
>  	wait_queue_head_t *wq;
>  	DEFINE_WAIT_BIT(wait, &inode->i_state, __I_NEW);
>  	wq = bit_waitqueue(&inode->i_state, __I_NEW);
>  	prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
>  	spin_unlock(&inode->i_lock);
> -	spin_unlock(&inode_hash_lock);
> +	rcu_read_unlock();
> +	if (locked)
> +		spin_unlock(&inode_hash_lock);
>  	schedule();
>  	finish_wait(wq, &wait.wq_entry);
> -	spin_lock(&inode_hash_lock);
> +	if (locked)
> +		spin_lock(&inode_hash_lock);
> +	rcu_read_lock();
>  }
>  
>  static __initdata unsigned long ihash_entries;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 0283cf366c2a..2817c915d355 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3021,6 +3021,9 @@ extern void d_mark_dontcache(struct inode *inode);
>  extern struct inode *ilookup5_nowait(struct super_block *sb,
>  		unsigned long hashval, int (*test)(struct inode *, void *),
>  		void *data);
> +extern struct inode *ilookup5_nowait_rcu(struct super_block *sb,
> +		unsigned long hashval, int (*test)(struct inode *, void *),
> +		void *data);
>  extern struct inode *ilookup5(struct super_block *sb, unsigned long hashval,
>  		int (*test)(struct inode *, void *), void *data);
>  extern struct inode *ilookup(struct super_block *sb, unsigned long ino);
> @@ -3029,7 +3032,12 @@ extern struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
>  		int (*test)(struct inode *, void *),
>  		int (*set)(struct inode *, void *),
>  		void *data);
> -extern struct inode * iget5_locked(struct super_block *, unsigned long, int (*test)(struct inode *, void *), int (*set)(struct inode *, void *), void *);
> +extern struct inode * iget5_locked(struct super_block *, unsigned long,
> +				   int (*test)(struct inode *, void *),
> +				   int (*set)(struct inode *, void *), void *);
> +extern struct inode * iget5_locked_rcu(struct super_block *, unsigned long,
> +				       int (*test)(struct inode *, void *),
> +				       int (*set)(struct inode *, void *), void *);
>  extern struct inode * iget_locked(struct super_block *, unsigned long);
>  extern struct inode *find_inode_nowait(struct super_block *,
>  				       unsigned long,
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

