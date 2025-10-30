Return-Path: <linux-fsdevel+bounces-66478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AE5C206FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 15:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8FD44F01E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 13:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33C0264A97;
	Thu, 30 Oct 2025 13:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1JLT4tGW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ErFI8tFF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1JLT4tGW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ErFI8tFF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4943125EF9C
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 13:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761832648; cv=none; b=IbSmfoEHrcM/KgmTQAC72B/gth99uQHI5wQ+O7AFJyg2y53ZGMPoIKaeIAX9c0RGvoGMI+6PH9w6ip94DMChRe4pZSmrd7yerBLK55JD0qzejUhBeI7Hcv11Ud/Cgu8qdtK1aEltlDtIa6Y00WAK3CLocespJR5M0TZ0X7EPu9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761832648; c=relaxed/simple;
	bh=w2S0YC520/Ikqb7PSHsQkT+j6NpKokCPg5VWSwFakNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdKdeol4wxc1Qj8cjJb02H6RTfLuZWFuOEw/niKeMomHP1kmml6H7TrGZrFLifGwHsGz+8H5o6AcsPG/eeNdGv2dvrUVrNVnCcLbn3olc16lwBwpgPpDykQD4PKGbYHcJTFaSYjHni019nSvNVRLVPeLLr8Gh4XujmUMAroeIXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1JLT4tGW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ErFI8tFF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1JLT4tGW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ErFI8tFF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0420D1F7CA;
	Thu, 30 Oct 2025 13:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761832639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B69QgLXqST05IDNk9dcQ708rS7rtDUnV0OKvAp1AQDM=;
	b=1JLT4tGW+LjVVnL8v2357BSNDG+hgo9VF7eP1kZ7c9iNXsAEDCjdl0i9MEivsxwPReyWTA
	kVyG9VDOP3emjcLny2JTnkdmnMz8W9F6S/E97vjM/1/emGxJBWqgEhrEQKqDomQ2LvPhGa
	8U32qTrnA2c6ol/XSXRarr9+TobEfkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761832639;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B69QgLXqST05IDNk9dcQ708rS7rtDUnV0OKvAp1AQDM=;
	b=ErFI8tFFbO9UkJHKrdYaYhpzNOJLrwUBFqLjErh2Z3VtycF+eOzbvfE2CLHLODGwRENuYM
	2j/3sLxsRRkgJFBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1JLT4tGW;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ErFI8tFF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761832639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B69QgLXqST05IDNk9dcQ708rS7rtDUnV0OKvAp1AQDM=;
	b=1JLT4tGW+LjVVnL8v2357BSNDG+hgo9VF7eP1kZ7c9iNXsAEDCjdl0i9MEivsxwPReyWTA
	kVyG9VDOP3emjcLny2JTnkdmnMz8W9F6S/E97vjM/1/emGxJBWqgEhrEQKqDomQ2LvPhGa
	8U32qTrnA2c6ol/XSXRarr9+TobEfkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761832639;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B69QgLXqST05IDNk9dcQ708rS7rtDUnV0OKvAp1AQDM=;
	b=ErFI8tFFbO9UkJHKrdYaYhpzNOJLrwUBFqLjErh2Z3VtycF+eOzbvfE2CLHLODGwRENuYM
	2j/3sLxsRRkgJFBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EDAED1396A;
	Thu, 30 Oct 2025 13:57:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1XoDOr5uA2mvAQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 30 Oct 2025 13:57:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A7337A0AD6; Thu, 30 Oct 2025 14:57:18 +0100 (CET)
Date: Thu, 30 Oct 2025 14:57:18 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] fs: cosmetic fixes to lru handling
Message-ID: <wwx6x46p7gkrunyh6arukpy3fhh7jzgyy4f64khvgfmqa7husc@5d7sqtpuqwgx>
References: <20251029131428.654761-1-mjguzik@gmail.com>
 <20251029131428.654761-2-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029131428.654761-2-mjguzik@gmail.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 0420D1F7CA
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -4.01

On Wed 29-10-25 14:14:28, Mateusz Guzik wrote:
> 1. inode_bit_waitqueue() was somehow placed between __inode_add_lru() and
>    inode_add_lru(). move it up
> 2. assert ->i_lock is held in __inode_add_lru instead of just claiming it is
>    needed
> 3. s/__inode_add_lru/__inode_lru_list_add/ for consistency with itself
>    (inode_lru_list_del()) and similar routines for sb and io list
>    management
> 4. push list presence check into inode_lru_list_del(), just like sb and
>    io list
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> rebased
> 
>  fs/fs-writeback.c  |  2 +-
>  fs/inode.c         | 50 ++++++++++++++++++++++++----------------------
>  include/linux/fs.h |  2 +-
>  mm/filemap.c       |  4 ++--
>  mm/truncate.c      |  6 +++---
>  mm/vmscan.c        |  2 +-
>  mm/workingset.c    |  2 +-
>  7 files changed, 35 insertions(+), 33 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 5dccbe5fb09d..c81fffcb3648 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1455,7 +1455,7 @@ static void inode_sync_complete(struct inode *inode)
>  
>  	inode_state_clear(inode, I_SYNC);
>  	/* If inode is clean an unused, put it into LRU now... */
> -	inode_add_lru(inode);
> +	inode_lru_list_add(inode);
>  	/* Called with inode->i_lock which ensures memory ordering. */
>  	inode_wake_up_bit(inode, __I_SYNC);
>  }
> diff --git a/fs/inode.c b/fs/inode.c
> index b5c2efebaa18..faf99d916afc 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -530,23 +530,6 @@ void ihold(struct inode *inode)
>  }
>  EXPORT_SYMBOL(ihold);
>  
> -static void __inode_add_lru(struct inode *inode, bool rotate)
> -{
> -	if (inode_state_read(inode) & (I_DIRTY_ALL | I_SYNC | I_FREEING | I_WILL_FREE))
> -		return;
> -	if (icount_read(inode))
> -		return;
> -	if (!(inode->i_sb->s_flags & SB_ACTIVE))
> -		return;
> -	if (!mapping_shrinkable(&inode->i_data))
> -		return;
> -
> -	if (list_lru_add_obj(&inode->i_sb->s_inode_lru, &inode->i_lru))
> -		this_cpu_inc(nr_unused);
> -	else if (rotate)
> -		inode_state_set(inode, I_REFERENCED);
> -}
> -
>  struct wait_queue_head *inode_bit_waitqueue(struct wait_bit_queue_entry *wqe,
>  					    struct inode *inode, u32 bit)
>  {
> @@ -584,18 +567,38 @@ void wait_on_new_inode(struct inode *inode)
>  }
>  EXPORT_SYMBOL(wait_on_new_inode);
>  
> +static void __inode_lru_list_add(struct inode *inode, bool rotate)
> +{
> +	lockdep_assert_held(&inode->i_lock);
> +
> +	if (inode_state_read(inode) & (I_DIRTY_ALL | I_SYNC | I_FREEING | I_WILL_FREE))
> +		return;
> +	if (icount_read(inode))
> +		return;
> +	if (!(inode->i_sb->s_flags & SB_ACTIVE))
> +		return;
> +	if (!mapping_shrinkable(&inode->i_data))
> +		return;
> +
> +	if (list_lru_add_obj(&inode->i_sb->s_inode_lru, &inode->i_lru))
> +		this_cpu_inc(nr_unused);
> +	else if (rotate)
> +		inode_state_set(inode, I_REFERENCED);
> +}
> +
>  /*
>   * Add inode to LRU if needed (inode is unused and clean).
> - *
> - * Needs inode->i_lock held.
>   */
> -void inode_add_lru(struct inode *inode)
> +void inode_lru_list_add(struct inode *inode)
>  {
> -	__inode_add_lru(inode, false);
> +	__inode_lru_list_add(inode, false);
>  }
>  
>  static void inode_lru_list_del(struct inode *inode)
>  {
> +	if (list_empty(&inode->i_lru))
> +		return;
> +
>  	if (list_lru_del_obj(&inode->i_sb->s_inode_lru, &inode->i_lru))
>  		this_cpu_dec(nr_unused);
>  }
> @@ -1924,7 +1927,7 @@ static void iput_final(struct inode *inode)
>  	if (!drop &&
>  	    !(inode_state_read(inode) & I_DONTCACHE) &&
>  	    (sb->s_flags & SB_ACTIVE)) {
> -		__inode_add_lru(inode, true);
> +		__inode_lru_list_add(inode, true);
>  		spin_unlock(&inode->i_lock);
>  		return;
>  	}
> @@ -1948,8 +1951,7 @@ static void iput_final(struct inode *inode)
>  		inode_state_replace(inode, I_WILL_FREE, I_FREEING);
>  	}
>  
> -	if (!list_empty(&inode->i_lru))
> -		inode_lru_list_del(inode);
> +	inode_lru_list_del(inode);
>  	spin_unlock(&inode->i_lock);
>  
>  	evict(inode);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index a813abdcf218..33129cda3a99 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3502,7 +3502,7 @@ static inline void remove_inode_hash(struct inode *inode)
>  }
>  
>  extern void inode_sb_list_add(struct inode *inode);
> -extern void inode_add_lru(struct inode *inode);
> +extern void inode_lru_list_add(struct inode *inode);
>  
>  extern int sb_set_blocksize(struct super_block *, int);
>  extern int sb_min_blocksize(struct super_block *, int);
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 13f0259d993c..add5228a7d97 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -256,7 +256,7 @@ void filemap_remove_folio(struct folio *folio)
>  	__filemap_remove_folio(folio, NULL);
>  	xa_unlock_irq(&mapping->i_pages);
>  	if (mapping_shrinkable(mapping))
> -		inode_add_lru(mapping->host);
> +		inode_lru_list_add(mapping->host);
>  	spin_unlock(&mapping->host->i_lock);
>  
>  	filemap_free_folio(mapping, folio);
> @@ -335,7 +335,7 @@ void delete_from_page_cache_batch(struct address_space *mapping,
>  	page_cache_delete_batch(mapping, fbatch);
>  	xa_unlock_irq(&mapping->i_pages);
>  	if (mapping_shrinkable(mapping))
> -		inode_add_lru(mapping->host);
> +		inode_lru_list_add(mapping->host);
>  	spin_unlock(&mapping->host->i_lock);
>  
>  	for (i = 0; i < folio_batch_count(fbatch); i++)
> diff --git a/mm/truncate.c b/mm/truncate.c
> index 91eb92a5ce4f..ad9c0fa29d94 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -46,7 +46,7 @@ static void clear_shadow_entries(struct address_space *mapping,
>  
>  	xas_unlock_irq(&xas);
>  	if (mapping_shrinkable(mapping))
> -		inode_add_lru(mapping->host);
> +		inode_lru_list_add(mapping->host);
>  	spin_unlock(&mapping->host->i_lock);
>  }
>  
> @@ -111,7 +111,7 @@ static void truncate_folio_batch_exceptionals(struct address_space *mapping,
>  
>  	xas_unlock_irq(&xas);
>  	if (mapping_shrinkable(mapping))
> -		inode_add_lru(mapping->host);
> +		inode_lru_list_add(mapping->host);
>  	spin_unlock(&mapping->host->i_lock);
>  out:
>  	folio_batch_remove_exceptionals(fbatch);
> @@ -622,7 +622,7 @@ int folio_unmap_invalidate(struct address_space *mapping, struct folio *folio,
>  	__filemap_remove_folio(folio, NULL);
>  	xa_unlock_irq(&mapping->i_pages);
>  	if (mapping_shrinkable(mapping))
> -		inode_add_lru(mapping->host);
> +		inode_lru_list_add(mapping->host);
>  	spin_unlock(&mapping->host->i_lock);
>  
>  	filemap_free_folio(mapping, folio);
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index b2fc8b626d3d..bb4a96c7b682 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -811,7 +811,7 @@ static int __remove_mapping(struct address_space *mapping, struct folio *folio,
>  		__filemap_remove_folio(folio, shadow);
>  		xa_unlock_irq(&mapping->i_pages);
>  		if (mapping_shrinkable(mapping))
> -			inode_add_lru(mapping->host);
> +			inode_lru_list_add(mapping->host);
>  		spin_unlock(&mapping->host->i_lock);
>  
>  		if (free_folio)
> diff --git a/mm/workingset.c b/mm/workingset.c
> index 68a76a91111f..d32dc2e02a61 100644
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -755,7 +755,7 @@ static enum lru_status shadow_lru_isolate(struct list_head *item,
>  	xa_unlock_irq(&mapping->i_pages);
>  	if (mapping->host != NULL) {
>  		if (mapping_shrinkable(mapping))
> -			inode_add_lru(mapping->host);
> +			inode_lru_list_add(mapping->host);
>  		spin_unlock(&mapping->host->i_lock);
>  	}
>  	ret = LRU_REMOVED_RETRY;
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

