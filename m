Return-Path: <linux-fsdevel+bounces-73793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDBFD20ACF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 18:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73DCF301F3E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 17:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478FC32E68F;
	Wed, 14 Jan 2026 17:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yD/RkXPq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QX4GjPzP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yD/RkXPq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QX4GjPzP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BADE32B9A7
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 17:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768413247; cv=none; b=sv3OfctmVDekBjmwsxZxipAZ9FrNBB1CaKPs8jkzkMbdFtHd6J09ZmxMMKhosJAhxxHu/ejXguoPXTYTQJknJOJZLZ14Z4yRwMphx7oqJiCSZ1TxY35scZynzAvBahaXFnzSB1BgORqWdmQlO9s/3Hqn2+xmSc5pTU82YCbF4hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768413247; c=relaxed/simple;
	bh=Jxe4RRX1jppaNy6E2GcZwb/VPhXaU9kP/kslFNyWXKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdxDy2WDHV9O1Ib0y3FQRb8UG+4D2pdG5uvo/gmGu7rYaHSmNC7NtxRCLLCN96At1i3jtOxFEogeXh76ed+BSdp/sAXYnq1aCSKaE+QJShv2R/t0JD58PF8mnSrL4MuHAmSdAMFAL8Kv2L0fr24uRwkLJ32HIDSmZFyOMdWWTqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yD/RkXPq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QX4GjPzP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yD/RkXPq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QX4GjPzP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2647634982;
	Wed, 14 Jan 2026 17:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768413244; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZXKCCQL7Dp0Na4cDsRpq5ZAN0ggA4kHJeGs7vciEVHQ=;
	b=yD/RkXPq5x5Lj7LozhTOk4ZeuAA8G/5EecCy35l3AE0j9PBheWFggyG+lGJ5OBfSImHYz4
	qzV21NzyEK/ymvGFhHwH0lXruP1yAJSz/hh9lJUyPpskmBGzq3aT/picL/xwPo3TCj2eiY
	/v0JtGvnCxZpBlQ6OCND3nrqT4C0WF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768413244;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZXKCCQL7Dp0Na4cDsRpq5ZAN0ggA4kHJeGs7vciEVHQ=;
	b=QX4GjPzP4S6SsAI+lVVLrrCEbTKSPIT3BfZq7j3gfT+uZIesrwwB3e7p83VUugC3SwJKpV
	n//XDPpIY9pjdrDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="yD/RkXPq";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=QX4GjPzP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768413244; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZXKCCQL7Dp0Na4cDsRpq5ZAN0ggA4kHJeGs7vciEVHQ=;
	b=yD/RkXPq5x5Lj7LozhTOk4ZeuAA8G/5EecCy35l3AE0j9PBheWFggyG+lGJ5OBfSImHYz4
	qzV21NzyEK/ymvGFhHwH0lXruP1yAJSz/hh9lJUyPpskmBGzq3aT/picL/xwPo3TCj2eiY
	/v0JtGvnCxZpBlQ6OCND3nrqT4C0WF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768413244;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZXKCCQL7Dp0Na4cDsRpq5ZAN0ggA4kHJeGs7vciEVHQ=;
	b=QX4GjPzP4S6SsAI+lVVLrrCEbTKSPIT3BfZq7j3gfT+uZIesrwwB3e7p83VUugC3SwJKpV
	n//XDPpIY9pjdrDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0CC833EA63;
	Wed, 14 Jan 2026 17:54:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wiPLAjzYZ2mjHgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 14 Jan 2026 17:54:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9CD53A0BFB; Wed, 14 Jan 2026 18:53:59 +0100 (CET)
Date: Wed, 14 Jan 2026 18:53:59 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, yi1.lai@linux.intel.com
Subject: Re: [PATCH v2] fs: make insert_inode_locked() wait for inode
 destruction
Message-ID: <7u355s2cszvmjy7k7s4eonjejo6udrdhggcggw7rlemdlpg7z3@cfq5sbwcvagn>
References: <20260114094717.236202-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114094717.236202-1-mjguzik@gmail.com>
X-Spam-Score: -4.01
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 2647634982
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On Wed 14-01-26 10:47:16, Mateusz Guzik wrote:
> This is the only routine which instead skipped instead of waiting.
> 
> The current behavior is arguably a bug as it results in a corner case
> where the inode hash can have *two* matching inodes, one of which is on
> its way out.
> 
> Ironing out this difference is an incremental step towards sanitizing
> the API.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> v2:
> - add a way to avoid the rcu dance in __wait_on_freeing_inode
> 
> 
>  fs/inode.c | 41 ++++++++++++++++++++++++-----------------
>  1 file changed, 24 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 8a47c4da603f..a4cfe9182a7c 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1028,19 +1028,20 @@ long prune_icache_sb(struct super_block *sb, struct shrink_control *sc)
>  	return freed;
>  }
>  
> -static void __wait_on_freeing_inode(struct inode *inode, bool is_inode_hash_locked);
> +static void __wait_on_freeing_inode(struct inode *inode, bool hash_locked, bool rcu_locked);
> +
>  /*
>   * Called with the inode lock held.
>   */
>  static struct inode *find_inode(struct super_block *sb,
>  				struct hlist_head *head,
>  				int (*test)(struct inode *, void *),
> -				void *data, bool is_inode_hash_locked,
> +				void *data, bool hash_locked,
>  				bool *isnew)
>  {
>  	struct inode *inode = NULL;
>  
> -	if (is_inode_hash_locked)
> +	if (hash_locked)
>  		lockdep_assert_held(&inode_hash_lock);
>  	else
>  		lockdep_assert_not_held(&inode_hash_lock);
> @@ -1054,7 +1055,7 @@ static struct inode *find_inode(struct super_block *sb,
>  			continue;
>  		spin_lock(&inode->i_lock);
>  		if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE)) {
> -			__wait_on_freeing_inode(inode, is_inode_hash_locked);
> +			__wait_on_freeing_inode(inode, hash_locked, true);
>  			goto repeat;
>  		}
>  		if (unlikely(inode_state_read(inode) & I_CREATING)) {
> @@ -1078,11 +1079,11 @@ static struct inode *find_inode(struct super_block *sb,
>   */
>  static struct inode *find_inode_fast(struct super_block *sb,
>  				struct hlist_head *head, unsigned long ino,
> -				bool is_inode_hash_locked, bool *isnew)
> +				bool hash_locked, bool *isnew)
>  {
>  	struct inode *inode = NULL;
>  
> -	if (is_inode_hash_locked)
> +	if (hash_locked)
>  		lockdep_assert_held(&inode_hash_lock);
>  	else
>  		lockdep_assert_not_held(&inode_hash_lock);
> @@ -1096,7 +1097,7 @@ static struct inode *find_inode_fast(struct super_block *sb,
>  			continue;
>  		spin_lock(&inode->i_lock);
>  		if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE)) {
> -			__wait_on_freeing_inode(inode, is_inode_hash_locked);
> +			__wait_on_freeing_inode(inode, hash_locked, true);
>  			goto repeat;
>  		}
>  		if (unlikely(inode_state_read(inode) & I_CREATING)) {
> @@ -1832,16 +1833,13 @@ int insert_inode_locked(struct inode *inode)
>  	while (1) {
>  		struct inode *old = NULL;
>  		spin_lock(&inode_hash_lock);
> +repeat:
>  		hlist_for_each_entry(old, head, i_hash) {
>  			if (old->i_ino != ino)
>  				continue;
>  			if (old->i_sb != sb)
>  				continue;
>  			spin_lock(&old->i_lock);
> -			if (inode_state_read(old) & (I_FREEING | I_WILL_FREE)) {
> -				spin_unlock(&old->i_lock);
> -				continue;
> -			}
>  			break;
>  		}
>  		if (likely(!old)) {
> @@ -1852,6 +1850,11 @@ int insert_inode_locked(struct inode *inode)
>  			spin_unlock(&inode_hash_lock);
>  			return 0;
>  		}
> +		if (inode_state_read(old) & (I_FREEING | I_WILL_FREE)) {
> +			__wait_on_freeing_inode(old, true, false);
> +			old = NULL;
> +			goto repeat;
> +		}
>  		if (unlikely(inode_state_read(old) & I_CREATING)) {
>  			spin_unlock(&old->i_lock);
>  			spin_unlock(&inode_hash_lock);
> @@ -2522,16 +2525,18 @@ EXPORT_SYMBOL(inode_needs_sync);
>   * wake_up_bit(&inode->i_state, __I_NEW) after removing from the hash list
>   * will DTRT.
>   */
> -static void __wait_on_freeing_inode(struct inode *inode, bool is_inode_hash_locked)
> +static void __wait_on_freeing_inode(struct inode *inode, bool hash_locked, bool rcu_locked)
>  {
>  	struct wait_bit_queue_entry wqe;
>  	struct wait_queue_head *wq_head;
>  
> +	VFS_BUG_ON(!hash_locked && !rcu_locked);
> +
>  	/*
>  	 * Handle racing against evict(), see that routine for more details.
>  	 */
>  	if (unlikely(inode_unhashed(inode))) {
> -		WARN_ON(is_inode_hash_locked);
> +		WARN_ON(hash_locked);
>  		spin_unlock(&inode->i_lock);
>  		return;
>  	}
> @@ -2539,14 +2544,16 @@ static void __wait_on_freeing_inode(struct inode *inode, bool is_inode_hash_lock
>  	wq_head = inode_bit_waitqueue(&wqe, inode, __I_NEW);
>  	prepare_to_wait_event(wq_head, &wqe.wq_entry, TASK_UNINTERRUPTIBLE);
>  	spin_unlock(&inode->i_lock);
> -	rcu_read_unlock();
> -	if (is_inode_hash_locked)
> +	if (rcu_locked)
> +		rcu_read_unlock();
> +	if (hash_locked)
>  		spin_unlock(&inode_hash_lock);
>  	schedule();
>  	finish_wait(wq_head, &wqe.wq_entry);
> -	if (is_inode_hash_locked)
> +	if (hash_locked)
>  		spin_lock(&inode_hash_lock);
> -	rcu_read_lock();
> +	if (rcu_locked)
> +		rcu_read_lock();
>  }
>  
>  static __initdata unsigned long ihash_entries;
> -- 
> 2.48.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

