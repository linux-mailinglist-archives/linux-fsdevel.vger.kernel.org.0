Return-Path: <linux-fsdevel+bounces-21648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AC3907571
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 16:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 604831C216F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 14:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA13146D6C;
	Thu, 13 Jun 2024 14:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TgVNIKLo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FCpyFjpQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TgVNIKLo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FCpyFjpQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D191448D7;
	Thu, 13 Jun 2024 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718289646; cv=none; b=ZI3j67Y0lBJvqTp1mVWDUhSnE68XTnBAcjW0F3Mw6MNN8dVlXPWxdUPmWicPEU1HZOtdCL9hs/IoYBQngvWxRqaWULbkn/7/tPCQY3miHnsjPBOLHu0GtUI8wt6h/XlPzZ53Z3b0x+36nzXg9P+tymr5JGcPcgVpyiwLWO9DuL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718289646; c=relaxed/simple;
	bh=Vylgub80OOZhxp8G4oXJk2kSySofV8Qa0quu2RB96gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNL2mMXrAJdE2IuL04NTgxM7QJeNoTBJJVM2x8fY9zspDRWf+IUGnKMt9CEqKIi0n/6wlqsVqMrqaww9m+3Nahpmtfawf6mfCUETPZ0/4MbURzUi9r2Lk+V9aIfk9krcSOdtNtLIeGTBFNkPWNL3FciNgcCPX0RnvKuVmG67Tt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TgVNIKLo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FCpyFjpQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TgVNIKLo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FCpyFjpQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4C8D85D4A7;
	Thu, 13 Jun 2024 14:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718289641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=14D2XLC6LZpKUlBb4mIQXL+Nt4wTJ5RbiQAvrS7h1Wg=;
	b=TgVNIKLoraOgX+W+DOkjo5JslHRtiDrJ3sLkQ1+EqSwZpn6HNEWqQWaeGCKkHER5iStxDZ
	W+AvSP0qoxTyXdsaS4RZDTNTGT3Ep9hCaUY402s4FQFxzzVudZfPaFY1dy1le3wGdyZHj6
	xKT58JdfOxcU7o4Px8nTjEMaSJMB7KA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718289641;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=14D2XLC6LZpKUlBb4mIQXL+Nt4wTJ5RbiQAvrS7h1Wg=;
	b=FCpyFjpQ7gMaSQ0n6q7APghKlcSLnA06D/rQgCRHCLYMjmntaPBowsAvPGM6O7kZzYjWMz
	/Vf3SSwaqIZfaHDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718289641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=14D2XLC6LZpKUlBb4mIQXL+Nt4wTJ5RbiQAvrS7h1Wg=;
	b=TgVNIKLoraOgX+W+DOkjo5JslHRtiDrJ3sLkQ1+EqSwZpn6HNEWqQWaeGCKkHER5iStxDZ
	W+AvSP0qoxTyXdsaS4RZDTNTGT3Ep9hCaUY402s4FQFxzzVudZfPaFY1dy1le3wGdyZHj6
	xKT58JdfOxcU7o4Px8nTjEMaSJMB7KA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718289641;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=14D2XLC6LZpKUlBb4mIQXL+Nt4wTJ5RbiQAvrS7h1Wg=;
	b=FCpyFjpQ7gMaSQ0n6q7APghKlcSLnA06D/rQgCRHCLYMjmntaPBowsAvPGM6O7kZzYjWMz
	/Vf3SSwaqIZfaHDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 380B713A7F;
	Thu, 13 Jun 2024 14:40:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IfBmDekEa2YYUwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 13 Jun 2024 14:40:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 75161A0889; Thu, 13 Jun 2024 16:40:40 +0200 (CEST)
Date: Thu, 13 Jun 2024 16:40:40 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, josef@toxicpanda.com,
	hch@infradead.org
Subject: Re: [PATCH v4 1/2] vfs: add rcu-based find_inode variants for iget
 ops
Message-ID: <20240613144040.zkd7ojl7nf2ksoxb@quack3>
References: <20240611173824.535995-1-mjguzik@gmail.com>
 <20240611173824.535995-2-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611173824.535995-2-mjguzik@gmail.com>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]

On Tue 11-06-24 19:38:22, Mateusz Guzik wrote:
> This avoids one inode hash lock acquire in the common case on inode
> creation, in effect significantly reducing contention.
> 
> On the stock kernel said lock is typically taken twice:
> 1. once to check if the inode happens to already be present
> 2. once to add it to the hash
> 
> The back-to-back lock/unlock pattern is known to degrade performance
> significantly, which is further exacerbated if the hash is heavily
> populated (long chains to walk, extending hold time). Arguably hash
> sizing and hashing algo need to be revisited, but that's beyond the
> scope of this patch.
> 
> With the acquire from step 1 eliminated with RCU lookup throughput
> increases significantly at the scale of 20 cores (benchmark results at
> the bottom).
> 
> So happens the hash already supports RCU-based operation, but lookups on
> inode insertions didn't take advantage of it.
> 
> This of course has its limits as the global lock is still a bottleneck.
> There was a patchset posted which introduced fine-grained locking[1] but
> it appears staled. Apart from that doubt was expressed whether a
> handrolled hash implementation is appropriate to begin with, suggesting
> replacement with rhashtables. Nobody committed to carrying [1] across
> the finish line or implementing anything better, thus the bandaid below.
> 
> iget_locked consumers (notably ext4) get away without any changes
> because inode comparison method is built-in.
> 
> iget5_locked consumers pass a custom callback. Since removal of locking
> adds more problems (inode can be changing) it's not safe to assume all
> filesystems happen to cope.  Thus iget5_locked_rcu gets added, requiring
> manual conversion of interested filesystems.
> 
> In order to reduce code duplication find_inode and find_inode_fast grow
> an argument indicating whether inode hash lock is held, which is passed
> down in case sleeping is necessary. They always rcu_read_lock, which is
> redundant but harmless. Doing it conditionally reduces readability for
> no real gain that I can see. RCU-alike restrictions were already put on
> callbacks due to the hash spinlock being held.
> 
> Benchmarking:
> There is a real cache-busting workload scanning millions of files in
> parallel (it's a backup appliance), where the initial lookup is
> guaranteed to fail resulting in the two lock acquires on stock kernel
> (and one with the patch at hand).
> 
> Implemented below is a synthetic benchmark providing the same behavior.
> [I shall note the workload is not running on Linux, instead it was
> causing trouble elsewhere. Benchmark below was used while addressing
> said problems and was found to adequately represent the real workload.]
> 
> Total real time fluctuates by 1-2s.
> 
> With 20 threads each walking a dedicated 1000 dirs * 1000 files
> directory tree to stat(2) on a 32 core + 24GB RAM vm:
> 
> ext4 (needed mkfs.ext4 -N 24000000):
> before: 3.77s user 890.90s system 1939% cpu 46.118 total
> after:  3.24s user 397.73s system 1858% cpu 21.581 total (-53%)
> 
> That's 20 million files to visit, while the machine can only cache about
> 15 million at a time (obtained from ext4_inode_cache object count in
> /proc/slabinfo). Since each terminal inode is only visited once per run
> this amounts to 0% hit ratio for the dentry cache and the hash table
> (there are however hits for the intermediate directories).
> 
> On repeated runs the kernel caches the last ~15 mln, meaning there is ~5
> mln of uncached inodes which are going to be visited first, evicting the
> previously cached state as it happens.
> 
> Lack of hits can be trivially verified with bpftrace, like so:
> bpftrace -e 'kretprobe:find_inode_fast { @[kstack(), retval != 0] = count(); }'\
> -c "/bin/sh walktrees /testfs 20"
> 
> Best ran more than once.
> 
> Expected results after "warmup":
> [snip]
> @[
>     __ext4_iget+275
>     ext4_lookup+224
>     __lookup_slow+130
>     walk_component+219
>     link_path_walk.part.0.constprop.0+614
>     path_lookupat+62
>     filename_lookup+204
>     vfs_statx+128
>     vfs_fstatat+131
>     __do_sys_newfstatat+38
>     do_syscall_64+87
>     entry_SYSCALL_64_after_hwframe+118
> , 1]: 20000
> @[
>     __ext4_iget+275
>     ext4_lookup+224
>     __lookup_slow+130
>     walk_component+219
>     path_lookupat+106
>     filename_lookup+204
>     vfs_statx+128
>     vfs_fstatat+131
>     __do_sys_newfstatat+38
>     do_syscall_64+87
>     entry_SYSCALL_64_after_hwframe+118
> , 1]: 20000000
> 
> That is 20 million calls for the initial lookup and 20 million after
> allocating a new inode, all of them failing to return a value != 0
> (i.e., they are returning NULL -- no match found).
> 
> Of course aborting the benchmark in the middle and starting it again (or
> messing with the state in other ways) is going to alter these results.
> 
> Benchmark can be found here: https://people.freebsd.org/~mjg/fstree.tgz
> 
> [1] https://lore.kernel.org/all/20231206060629.2827226-1-david@fromorbit.com/
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/inode.c         | 97 ++++++++++++++++++++++++++++++++++++++--------
>  include/linux/fs.h |  7 +++-
>  2 files changed, 86 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 3a41f83a4ba5..8c57cea7bbbb 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -886,36 +886,45 @@ long prune_icache_sb(struct super_block *sb, struct shrink_control *sc)
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
> +	else
> +		lockdep_assert_not_held(&inode_hash_lock);
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
> @@ -924,29 +933,39 @@ static struct inode *find_inode(struct super_block *sb,
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
> +	else
> +		lockdep_assert_not_held(&inode_hash_lock);
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
> @@ -1161,7 +1180,7 @@ struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
>  
>  again:
>  	spin_lock(&inode_hash_lock);
> -	old = find_inode(inode->i_sb, head, test, data);
> +	old = find_inode(inode->i_sb, head, test, data, true);
>  	if (unlikely(old)) {
>  		/*
>  		 * Uhhuh, somebody else created the same inode under us.
> @@ -1245,6 +1264,48 @@ struct inode *iget5_locked(struct super_block *sb, unsigned long hashval,
>  }
>  EXPORT_SYMBOL(iget5_locked);
>  
> +/**
> + * iget5_locked_rcu - obtain an inode from a mounted file system
> + * @sb:		super block of file system
> + * @hashval:	hash value (usually inode number) to get
> + * @test:	callback used for comparisons between inodes
> + * @set:	callback used to initialize a new struct inode
> + * @data:	opaque data pointer to pass to @test and @set
> + *
> + * This is equivalent to iget5_locked, except the @test callback must
> + * tolerate the inode not being stable, including being mid-teardown.
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
> +EXPORT_SYMBOL_GPL(iget5_locked_rcu);
> +
>  /**
>   * iget_locked - obtain an inode from a mounted file system
>   * @sb:		super block of file system
> @@ -1263,9 +1324,7 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
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
> @@ -1283,7 +1342,7 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
>  
>  		spin_lock(&inode_hash_lock);
>  		/* We released the lock, so.. */
> -		old = find_inode_fast(sb, head, ino);
> +		old = find_inode_fast(sb, head, ino, true);
>  		if (!old) {
>  			inode->i_ino = ino;
>  			spin_lock(&inode->i_lock);
> @@ -1419,7 +1478,7 @@ struct inode *ilookup5_nowait(struct super_block *sb, unsigned long hashval,
>  	struct inode *inode;
>  
>  	spin_lock(&inode_hash_lock);
> -	inode = find_inode(sb, head, test, data);
> +	inode = find_inode(sb, head, test, data, true);
>  	spin_unlock(&inode_hash_lock);
>  
>  	return IS_ERR(inode) ? NULL : inode;
> @@ -1474,7 +1533,7 @@ struct inode *ilookup(struct super_block *sb, unsigned long ino)
>  	struct inode *inode;
>  again:
>  	spin_lock(&inode_hash_lock);
> -	inode = find_inode_fast(sb, head, ino);
> +	inode = find_inode_fast(sb, head, ino, true);
>  	spin_unlock(&inode_hash_lock);
>  
>  	if (inode) {
> @@ -2235,17 +2294,21 @@ EXPORT_SYMBOL(inode_needs_sync);
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
> index bfc1e6407bf6..3eb88cb3c1e6 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3045,7 +3045,12 @@ extern struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
>  		int (*test)(struct inode *, void *),
>  		int (*set)(struct inode *, void *),
>  		void *data);
> -extern struct inode * iget5_locked(struct super_block *, unsigned long, int (*test)(struct inode *, void *), int (*set)(struct inode *, void *), void *);
> +struct inode *iget5_locked(struct super_block *, unsigned long,
> +			   int (*test)(struct inode *, void *),
> +			   int (*set)(struct inode *, void *), void *);
> +struct inode *iget5_locked_rcu(struct super_block *, unsigned long,
> +			       int (*test)(struct inode *, void *),
> +			       int (*set)(struct inode *, void *), void *);
>  extern struct inode * iget_locked(struct super_block *, unsigned long);
>  extern struct inode *find_inode_nowait(struct super_block *,
>  				       unsigned long,
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

