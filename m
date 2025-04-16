Return-Path: <linux-fsdevel+bounces-46553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2D2A8B5D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 11:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74A023A5C81
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 09:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8FA236A7A;
	Wed, 16 Apr 2025 09:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HHhhJvJJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5tJ6Nxjh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nIYdAtjN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="baEEojHK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B880E2356C1
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Apr 2025 09:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744796597; cv=none; b=tMmtnE/Uzoq2hLTd1s54VdTilR6RQzG5IXwXu2f/AwxCGa3+JrLG1vXR0jz+aKLt25h0elkXNtgc/gzaIk0tbVfelp/bEetDQAN1SMt9G5JJV4R9yFOFgWZRlv7buyhGgc612gjOWonaekJSAOwWnsRMx3wCecluMGoe5d7/lsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744796597; c=relaxed/simple;
	bh=Zzwem0GJrFdnyqulU5AZEB8Mx7Dpi4+0/uaC91Dv9KI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUsO/hWCf5KTjOisDCMKfU9w8ulsYOUmvSKMl4MSwdQ34uuPZLzStLlnms3Q8Or03RrBtHhfVlE57n+TDMKfqa66jPCsYChEb8C5EK4YDUQYq/BIqnl2Bw58dZIFd9r1tYa7qtzUw65x0XbKmWesP/AAFV7c6OBbTsOMIweBXPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HHhhJvJJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5tJ6Nxjh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nIYdAtjN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=baEEojHK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C79971F445;
	Wed, 16 Apr 2025 09:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744796594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ab9IcjuX6LQv/6sxl0cPtCD4BdqLZx1T92HH/x/n7jM=;
	b=HHhhJvJJqTxUbE9sjUyrYS5d9OEMbtCLa4OTPN75dRyYGCFssYE+KE/3uVNmZpvupMJIhQ
	k1PV5AR/FsGTtX5S+T0fuzMnfuMw33JO777VklUaCrLi8Qt7xZJrH6s7D5731gkIJL6UvB
	L1nj+KRGfLPdtPnZW2C6uLFNFb8vqAc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744796594;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ab9IcjuX6LQv/6sxl0cPtCD4BdqLZx1T92HH/x/n7jM=;
	b=5tJ6NxjhqGpCK+QNFu1bPRJ/g/S1+8sMN+CnbK5kZyX9aXjO/KDPPkAcpItKxOsRZOM7nY
	HyoMF8uvcwyMJICw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744796592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ab9IcjuX6LQv/6sxl0cPtCD4BdqLZx1T92HH/x/n7jM=;
	b=nIYdAtjNJheQ0w5+XR6ns5Ovifpb/Ij73acMwVLmIm47tqIPb53TfKosRjk5Ctir9G3WdG
	pSg3m0A3OmJsuMPXZ8fOqnFC2jiILvOfuOmxEpF+jGZHj+8ZnclSVfphBCLNRYIF5SqSi9
	PKTTfSUkXmqPf1nnXWJEyzZqv1ZjYvg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744796592;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ab9IcjuX6LQv/6sxl0cPtCD4BdqLZx1T92HH/x/n7jM=;
	b=baEEojHKC3IGW9K/7OukHM+F5V5ZNNec7HQIDFEyJyQ4i3PQty1Rc8pAvgT9fAK3icsk1Q
	PZToT5ff6bd5hPBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BBF6713976;
	Wed, 16 Apr 2025 09:43:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id M5DiLbB7/2eMdgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 16 Apr 2025 09:43:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5AE8CA0947; Wed, 16 Apr 2025 11:43:08 +0200 (CEST)
Date: Wed, 16 Apr 2025 11:43:08 +0200
From: Jan Kara <jack@suse.cz>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca, 
	brauner@kernel.org, mcgrof@kernel.org, willy@infradead.org, hare@suse.de, 
	djwong@kernel.org, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, kernel test robot <oliver.sang@intel.com>, 
	syzbot+f3c6fda1297c748a7076@syzkaller.appspotmail.com
Subject: Re: [PATCH 7/7] mm/migrate: fix sleep in atomic for large folios and
 buffer heads
Message-ID: <4qdxc5vwmf3squ4yjpgarxdss3d7sacfwgupf4o3onbqxjzb23@4i4ubrmoi74r>
References: <20250415231635.83960-1-dave@stgolabs.net>
 <20250415231635.83960-8-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415231635.83960-8-dave@stgolabs.net>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[f3c6fda1297c748a7076];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email,stgolabs.net:email,appspotmail.com:email]
X-Spam-Score: -2.30
X-Spam-Flag: NO

On Tue 15-04-25 16:16:35, Davidlohr Bueso wrote:
> The large folio + buffer head noref migration scenarios are
> being naughty and blocking while holding a spinlock.
> 
> As a consequence of the pagecache lookup path taking the
> folio lock this serializes against migration paths, so
> they can wait for each other. For the private_lock
> atomic case, a new BH_Migrate flag is introduced which
> enables the lookup to bail.
> 
> This allows the critical region of the private_lock on
> the migration path to be reduced to the way it was before
> ebdf4de5642fb6 ("mm: migrate: fix reference  check race
> between __find_get_block() and migration"), that is covering
> the count checks.
> 
> The scope is always noref migration.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Reported-by: syzbot+f3c6fda1297c748a7076@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/oe-lkp/202503101536.27099c77-lkp@intel.com
> Fixes: 3c20917120ce61 ("block/bdev: enable large folio support for large logical block sizes")
> Co-developed-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Looks good! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/buffer.c                 | 12 +++++++++++-
>  fs/ext4/ialloc.c            |  3 ++-
>  include/linux/buffer_head.h |  1 +
>  mm/migrate.c                |  8 +++++---
>  4 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index f8e63885604b..b8e1e6e325cd 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -207,6 +207,15 @@ __find_get_block_slow(struct block_device *bdev, sector_t block, bool atomic)
>  	head = folio_buffers(folio);
>  	if (!head)
>  		goto out_unlock;
> +	/*
> +	 * Upon a noref migration, the folio lock serializes here;
> +	 * otherwise bail.
> +	 */
> +	if (test_bit_acquire(BH_Migrate, &head->b_state)) {
> +		WARN_ON(!atomic);
> +		goto out_unlock;
> +	}
> +
>  	bh = head;
>  	do {
>  		if (!buffer_mapped(bh))
> @@ -1390,7 +1399,8 @@ lookup_bh_lru(struct block_device *bdev, sector_t block, unsigned size)
>  /*
>   * Perform a pagecache lookup for the matching buffer.  If it's there, refresh
>   * it in the LRU and mark it as accessed.  If it is not present then return
> - * NULL
> + * NULL. Atomic context callers may also return NULL if the buffer is being
> + * migrated; similarly the page is not marked accessed either.
>   */
>  static struct buffer_head *
>  find_get_block_common(struct block_device *bdev, sector_t block,
> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
> index 38bc8d74f4cc..e7ecc7c8a729 100644
> --- a/fs/ext4/ialloc.c
> +++ b/fs/ext4/ialloc.c
> @@ -691,7 +691,8 @@ static int recently_deleted(struct super_block *sb, ext4_group_t group, int ino)
>  	if (!bh || !buffer_uptodate(bh))
>  		/*
>  		 * If the block is not in the buffer cache, then it
> -		 * must have been written out.
> +		 * must have been written out, or, most unlikely, is
> +		 * being migrated - false failure should be OK here.
>  		 */
>  		goto out;
>  
> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
> index c791aa9a08da..0029ff880e27 100644
> --- a/include/linux/buffer_head.h
> +++ b/include/linux/buffer_head.h
> @@ -34,6 +34,7 @@ enum bh_state_bits {
>  	BH_Meta,	/* Buffer contains metadata */
>  	BH_Prio,	/* Buffer should be submitted with REQ_PRIO */
>  	BH_Defer_Completion, /* Defer AIO completion to workqueue */
> +	BH_Migrate,     /* Buffer is being migrated (norefs) */
>  
>  	BH_PrivateStart,/* not a state bit, but the first bit available
>  			 * for private allocation by other entities
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 6e2488e5dbe4..c80591514e66 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -845,9 +845,11 @@ static int __buffer_migrate_folio(struct address_space *mapping,
>  		return -EAGAIN;
>  
>  	if (check_refs) {
> -		bool busy;
> +		bool busy, migrating;
>  		bool invalidated = false;
>  
> +		migrating = test_and_set_bit_lock(BH_Migrate, &head->b_state);
> +		VM_WARN_ON_ONCE(migrating);
>  recheck_buffers:
>  		busy = false;
>  		spin_lock(&mapping->i_private_lock);
> @@ -859,12 +861,12 @@ static int __buffer_migrate_folio(struct address_space *mapping,
>  			}
>  			bh = bh->b_this_page;
>  		} while (bh != head);
> +		spin_unlock(&mapping->i_private_lock);
>  		if (busy) {
>  			if (invalidated) {
>  				rc = -EAGAIN;
>  				goto unlock_buffers;
>  			}
> -			spin_unlock(&mapping->i_private_lock);
>  			invalidate_bh_lrus();
>  			invalidated = true;
>  			goto recheck_buffers;
> @@ -883,8 +885,7 @@ static int __buffer_migrate_folio(struct address_space *mapping,
>  
>  unlock_buffers:
>  	if (check_refs)
> -		spin_unlock(&mapping->i_private_lock);
> +		clear_bit_unlock(BH_Migrate, &head->b_state);
>  	bh = head;
>  	do {
>  		unlock_buffer(bh);
> --
> 2.39.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

