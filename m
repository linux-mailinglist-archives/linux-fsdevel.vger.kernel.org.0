Return-Path: <linux-fsdevel+bounces-63582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E021BBC48FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 08 Oct 2025 13:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AD5B3AB5D1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Oct 2025 11:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839462F7449;
	Wed,  8 Oct 2025 11:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lu4Pc6r3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NrQpT950";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tnpTM0bp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/3Fno+VV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BB52F6564
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Oct 2025 11:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759922822; cv=none; b=KgJF5/22BFLxaQNLauAJAncpbgNECyZOF7nQ8Ns7EKailufQsiip6d7m+ruMoTGAEx4jpu9FBpWXsy0+clwQ9HRxUPZQ1JjvRKDWMKc/8rNHDWZx5TH5IXUW2BT4+A3TmfXG1xlJPiYxXnC3WTeRFSyjDryxYlj/kDBD3BmvfMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759922822; c=relaxed/simple;
	bh=XULBkTyoGoAzZ3kyX4Xl1zY1DYI5vaZ8JdqknNsW3dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfUHyTR/Akgg9eLvH+tJ2yOGhJz9/Rasrg84M9r7cHXJK5uWowwbYF7frdw0QLeCO/3uF1Xq/vn9N56vLMN5YiNKO2FZjx2qZzteruSWPfUeXW8sZY8+2zkV0kSbuW9LJUxaC1OY81DHzcP2xYVVGBjzH69hnPcPgwytoTE8Pfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Lu4Pc6r3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NrQpT950; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tnpTM0bp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/3Fno+VV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E232E1F395;
	Wed,  8 Oct 2025 11:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759922818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9yxTUHDIOTp1FsmvuznKaGdacntH6YOzvVuPzn3XkUo=;
	b=Lu4Pc6r3UGWCcboLzUAtPwYqacH3QHrhtzIFFYmifzbvOvDajLB7i5Tz22L5y3oC9cW85a
	9MeHKewUnVeugAXzI27i+lATG2lVqNx1G9TO03lUrzqLfDsDij86aOU6JdnuxMAL0qfFFB
	CGaiAzwLjNtAzpihWybOn6OpfR1GV8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759922818;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9yxTUHDIOTp1FsmvuznKaGdacntH6YOzvVuPzn3XkUo=;
	b=NrQpT950eTS0WzXY6gXKM67NuNkErzWcOU0CemfTz29vM7ez9KTHTrQYZ3G/bf4azsEqHv
	AJOEh250+koG7YBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=tnpTM0bp;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/3Fno+VV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759922817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9yxTUHDIOTp1FsmvuznKaGdacntH6YOzvVuPzn3XkUo=;
	b=tnpTM0bpqnY4roIMUENJhc4/Cj9SrJJKuIcFSL4wBRB+0V1+eV59cScRK13zLS+XnQj9jx
	QXNnPi9tkaUs3f8cKCiWkQDlCxgDKKEOh0nVw+42x5lv8XuloVwQhLVEFZ0Zy2bir/jKmO
	q5BQAgfttYc9PE19V08P54njHOiHvag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759922817;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9yxTUHDIOTp1FsmvuznKaGdacntH6YOzvVuPzn3XkUo=;
	b=/3Fno+VV3G0ZBIDD+z5qzZYYLASr1PGzScADCRSCNiqCN02xQyzHwyLADHslWtPFpBDCk9
	Br2tfRiZLaqQepAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D4F8113693;
	Wed,  8 Oct 2025 11:26:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Hjf9M4FK5mg0KAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 08 Oct 2025 11:26:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4CF97A0ACD; Wed,  8 Oct 2025 13:26:57 +0200 (CEST)
Date: Wed, 8 Oct 2025 13:26:57 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 03/13] ext4: introduce seq counter for the extent
 status entry
Message-ID: <utxx6yngpfntc5qn7iv6a6be2hgpoubkkhdxkrfbcdnbmiiv5j@ftxbfofhybj2>
References: <20250925092610.1936929-1-yi.zhang@huaweicloud.com>
 <20250925092610.1936929-4-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925092610.1936929-4-yi.zhang@huaweicloud.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: E232E1F395
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.com:email];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01

On Thu 25-09-25 17:25:59, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> In the iomap_write_iter(), the iomap buffered write frame does not hold
> any locks between querying the inode extent mapping info and performing
> page cache writes. As a result, the extent mapping can be changed due to
> concurrent I/O in flight. Similarly, in the iomap_writepage_map(), the
> write-back process faces a similar problem: concurrent changes can
> invalidate the extent mapping before the I/O is submitted.
> 
> Therefore, both of these processes must recheck the mapping info after
> acquiring the folio lock. To address this, similar to XFS, we propose
> introducing an extent sequence number to serve as a validity cookie for
> the extent. After commit 24b7a2331fcd ("ext4: clairfy the rules for
> modifying extents"), we can ensure the extent information should always
> be processed through the extent status tree, and the extent status tree
> is always uptodate under i_rwsem or invalidate_lock or folio lock, so
> it's safe to introduce this sequence number. The sequence number will be
> increased whenever the extent status tree changes, preparing for the
> buffered write iomap conversion.
> 
> Besides, this mechanism is also applicable for the moving extents case.
> In move_extent_per_page(), it also needs to reacquire data_sem and check
> the mapping info again under the folio lock.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h              |  2 ++
>  fs/ext4/extents_status.c    | 21 +++++++++++++++++----
>  fs/ext4/super.c             |  1 +
>  include/trace/events/ext4.h | 23 +++++++++++++++--------
>  4 files changed, 35 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 01a6e2de7fc3..7b37a661dd37 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1138,6 +1138,8 @@ struct ext4_inode_info {
>  	ext4_lblk_t i_es_shrink_lblk;	/* Offset where we start searching for
>  					   extents to shrink. Protected by
>  					   i_es_lock  */
> +	u64 i_es_seq;			/* Change counter for extents.
> +					   Protected by i_es_lock */
>  
>  	/* ialloc */
>  	ext4_group_t	i_last_alloc_group;
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index 31dc0496f8d0..62886e18e2a3 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -235,6 +235,13 @@ static inline ext4_lblk_t ext4_es_end(struct extent_status *es)
>  	return es->es_lblk + es->es_len - 1;
>  }
>  
> +static inline void ext4_es_inc_seq(struct inode *inode)
> +{
> +	struct ext4_inode_info *ei = EXT4_I(inode);
> +
> +	WRITE_ONCE(ei->i_es_seq, ei->i_es_seq + 1);
> +}
> +
>  /*
>   * search through the tree for an delayed extent with a given offset.  If
>   * it can't be found, try to find next extent.
> @@ -906,7 +913,6 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>  	newes.es_lblk = lblk;
>  	newes.es_len = len;
>  	ext4_es_store_pblock_status(&newes, pblk, status);
> -	trace_ext4_es_insert_extent(inode, &newes);
>  
>  	ext4_es_insert_extent_check(inode, &newes);
>  
> @@ -955,6 +961,7 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>  		}
>  		pending = err3;
>  	}
> +	ext4_es_inc_seq(inode);
>  error:
>  	write_unlock(&EXT4_I(inode)->i_es_lock);
>  	/*
> @@ -981,6 +988,7 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>  	if (err1 || err2 || err3 < 0)
>  		goto retry;
>  
> +	trace_ext4_es_insert_extent(inode, &newes);
>  	ext4_es_print_tree(inode);
>  	return;
>  }
> @@ -1550,7 +1558,6 @@ void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
>  	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
>  		return;
>  
> -	trace_ext4_es_remove_extent(inode, lblk, len);
>  	es_debug("remove [%u/%u) from extent status tree of inode %lu\n",
>  		 lblk, len, inode->i_ino);
>  
> @@ -1570,16 +1577,21 @@ void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
>  	 */
>  	write_lock(&EXT4_I(inode)->i_es_lock);
>  	err = __es_remove_extent(inode, lblk, end, &reserved, es);
> +	if (err)
> +		goto error;
>  	/* Free preallocated extent if it didn't get used. */
>  	if (es) {
>  		if (!es->es_len)
>  			__es_free_extent(es);
>  		es = NULL;
>  	}
> +	ext4_es_inc_seq(inode);
> +error:
>  	write_unlock(&EXT4_I(inode)->i_es_lock);
>  	if (err)
>  		goto retry;
>  
> +	trace_ext4_es_remove_extent(inode, lblk, len);
>  	ext4_es_print_tree(inode);
>  	ext4_da_release_space(inode, reserved);
>  }
> @@ -2140,8 +2152,6 @@ void ext4_es_insert_delayed_extent(struct inode *inode, ext4_lblk_t lblk,
>  	newes.es_lblk = lblk;
>  	newes.es_len = len;
>  	ext4_es_store_pblock_status(&newes, ~0, EXTENT_STATUS_DELAYED);
> -	trace_ext4_es_insert_delayed_extent(inode, &newes, lclu_allocated,
> -					    end_allocated);
>  
>  	ext4_es_insert_extent_check(inode, &newes);
>  
> @@ -2196,11 +2206,14 @@ void ext4_es_insert_delayed_extent(struct inode *inode, ext4_lblk_t lblk,
>  			pr2 = NULL;
>  		}
>  	}
> +	ext4_es_inc_seq(inode);
>  error:
>  	write_unlock(&EXT4_I(inode)->i_es_lock);
>  	if (err1 || err2 || err3 < 0)
>  		goto retry;
>  
> +	trace_ext4_es_insert_delayed_extent(inode, &newes, lclu_allocated,
> +					    end_allocated);
>  	ext4_es_print_tree(inode);
>  	ext4_print_pending_tree(inode);
>  	return;
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 699c15db28a8..30682df3eeef 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1397,6 +1397,7 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
>  	ei->i_es_all_nr = 0;
>  	ei->i_es_shk_nr = 0;
>  	ei->i_es_shrink_lblk = 0;
> +	ei->i_es_seq = 0;
>  	ei->i_reserved_data_blocks = 0;
>  	spin_lock_init(&(ei->i_block_reservation_lock));
>  	ext4_init_pending_tree(&ei->i_pending_tree);
> diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
> index a374e7ea7e57..6a0754d38acf 100644
> --- a/include/trace/events/ext4.h
> +++ b/include/trace/events/ext4.h
> @@ -2210,7 +2210,8 @@ DECLARE_EVENT_CLASS(ext4__es_extent,
>  		__field(	ext4_lblk_t,	lblk		)
>  		__field(	ext4_lblk_t,	len		)
>  		__field(	ext4_fsblk_t,	pblk		)
> -		__field(	char, status	)
> +		__field(	char,		status		)
> +		__field(	u64,		seq		)
>  	),
>  
>  	TP_fast_assign(
> @@ -2220,13 +2221,15 @@ DECLARE_EVENT_CLASS(ext4__es_extent,
>  		__entry->len	= es->es_len;
>  		__entry->pblk	= ext4_es_show_pblock(es);
>  		__entry->status	= ext4_es_status(es);
> +		__entry->seq	= EXT4_I(inode)->i_es_seq;
>  	),
>  
> -	TP_printk("dev %d,%d ino %lu es [%u/%u) mapped %llu status %s",
> +	TP_printk("dev %d,%d ino %lu es [%u/%u) mapped %llu status %s seq %llu",
>  		  MAJOR(__entry->dev), MINOR(__entry->dev),
>  		  (unsigned long) __entry->ino,
>  		  __entry->lblk, __entry->len,
> -		  __entry->pblk, show_extent_status(__entry->status))
> +		  __entry->pblk, show_extent_status(__entry->status),
> +		  __entry->seq)
>  );
>  
>  DEFINE_EVENT(ext4__es_extent, ext4_es_insert_extent,
> @@ -2251,6 +2254,7 @@ TRACE_EVENT(ext4_es_remove_extent,
>  		__field(	ino_t,	ino			)
>  		__field(	loff_t,	lblk			)
>  		__field(	loff_t,	len			)
> +		__field(	u64,	seq			)
>  	),
>  
>  	TP_fast_assign(
> @@ -2258,12 +2262,13 @@ TRACE_EVENT(ext4_es_remove_extent,
>  		__entry->ino	= inode->i_ino;
>  		__entry->lblk	= lblk;
>  		__entry->len	= len;
> +		__entry->seq	= EXT4_I(inode)->i_es_seq;
>  	),
>  
> -	TP_printk("dev %d,%d ino %lu es [%lld/%lld)",
> +	TP_printk("dev %d,%d ino %lu es [%lld/%lld) seq %llu",
>  		  MAJOR(__entry->dev), MINOR(__entry->dev),
>  		  (unsigned long) __entry->ino,
> -		  __entry->lblk, __entry->len)
> +		  __entry->lblk, __entry->len, __entry->seq)
>  );
>  
>  TRACE_EVENT(ext4_es_find_extent_range_enter,
> @@ -2523,6 +2528,7 @@ TRACE_EVENT(ext4_es_insert_delayed_extent,
>  		__field(	char,		status		)
>  		__field(	bool,		lclu_allocated	)
>  		__field(	bool,		end_allocated	)
> +		__field(	u64,		seq		)
>  	),
>  
>  	TP_fast_assign(
> @@ -2534,15 +2540,16 @@ TRACE_EVENT(ext4_es_insert_delayed_extent,
>  		__entry->status		= ext4_es_status(es);
>  		__entry->lclu_allocated	= lclu_allocated;
>  		__entry->end_allocated	= end_allocated;
> +		__entry->seq		= EXT4_I(inode)->i_es_seq;
>  	),
>  
> -	TP_printk("dev %d,%d ino %lu es [%u/%u) mapped %llu status %s "
> -		  "allocated %d %d",
> +	TP_printk("dev %d,%d ino %lu es [%u/%u) mapped %llu status %s allocated %d %d seq %llu",
>  		  MAJOR(__entry->dev), MINOR(__entry->dev),
>  		  (unsigned long) __entry->ino,
>  		  __entry->lblk, __entry->len,
>  		  __entry->pblk, show_extent_status(__entry->status),
> -		  __entry->lclu_allocated, __entry->end_allocated)
> +		  __entry->lclu_allocated, __entry->end_allocated,
> +		  __entry->seq)
>  );
>  
>  /* fsmap traces */
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

