Return-Path: <linux-fsdevel+bounces-63027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D892BA91EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 13:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38280188BC94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 11:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851D430505E;
	Mon, 29 Sep 2025 11:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x7XE9PkW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Wot1Z8VS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x7XE9PkW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Wot1Z8VS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545FC301010
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 11:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759146614; cv=none; b=ZRaeAL0Vot6B4y/02F3BfIwQOOi20NOM03vv0bzUOUUt7004VrhOjHrQo2MD8U6GT9/eaPNtC3aqTbj8Qm22hjnh1gH2qzcLYf6L5DAAQJYC8LbaCt4Tu+QBb60NGlqT90JHdNx81VYJ4LnrhuFeYkEdO6SmmcsXExf0m3UJ5xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759146614; c=relaxed/simple;
	bh=9j/gKWeBV8W7Xm1Kjn/LCWNqEr5BuINKb/yoKy/Ifx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpdQr4DxEYpTbo4VO51qvrg1buUzWmk//RrkEHoZVAX9E24TjwAsgMqqeXjh4Ucj4F+0qcxjWkTAeKPjg6BgIQGTyx9qnl73dCdWGGBey6jLAB/0cJ4q9W2rVawSUsD0PuQlKxN+TE1ZUOb5ef0vS9ZY68wPoh5G56yWjEEwOxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=x7XE9PkW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Wot1Z8VS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=x7XE9PkW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Wot1Z8VS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2361A31AF3;
	Mon, 29 Sep 2025 11:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759146609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mhU1lqYXGXju5aeAWCfAkcmAEShO+lmEqPcT3URjaMo=;
	b=x7XE9PkW9wQizwWe9LaNBRgqIZz17riSNCIn9Q9RnwOrAklEvW5ERjTJ9AuQSkibGT+l9d
	psN9vSNirJxSyMtJe1YOL/9+WshUo7EmJB6v/s5i/tTppxHQdQ49drNU3fBbcsiw8bDAC2
	UItS76CngkZDV5kZz4sQ8LscEl/J5RA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759146609;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mhU1lqYXGXju5aeAWCfAkcmAEShO+lmEqPcT3URjaMo=;
	b=Wot1Z8VSPEtL8dVJWulj7w4q79zowLcGsJughLOgRdcw506Kveu5SNU1EWMps3R9hUb5pv
	mrrmdGF39r+PurDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759146609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mhU1lqYXGXju5aeAWCfAkcmAEShO+lmEqPcT3URjaMo=;
	b=x7XE9PkW9wQizwWe9LaNBRgqIZz17riSNCIn9Q9RnwOrAklEvW5ERjTJ9AuQSkibGT+l9d
	psN9vSNirJxSyMtJe1YOL/9+WshUo7EmJB6v/s5i/tTppxHQdQ49drNU3fBbcsiw8bDAC2
	UItS76CngkZDV5kZz4sQ8LscEl/J5RA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759146609;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mhU1lqYXGXju5aeAWCfAkcmAEShO+lmEqPcT3URjaMo=;
	b=Wot1Z8VSPEtL8dVJWulj7w4q79zowLcGsJughLOgRdcw506Kveu5SNU1EWMps3R9hUb5pv
	mrrmdGF39r+PurDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1035713A21;
	Mon, 29 Sep 2025 11:50:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FnXuA3Fy2mjAdwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 29 Sep 2025 11:50:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B51B2A0A96; Mon, 29 Sep 2025 13:50:08 +0200 (CEST)
Date: Mon, 29 Sep 2025 13:50:08 +0200
From: Jan Kara <jack@suse.cz>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-ext4@vger.kernel.org, ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	clm@fb.com, dsterba@suse.com, xiubli@redhat.com, idryomov@gmail.com, 
	tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org, chao@kernel.org, 
	willy@infradead.org, jack@suse.cz, brauner@kernel.org, agruenba@redhat.com
Subject: Re: [PATCH v2] fs: Make wbc_to_tag() inline and use it in fs.
Message-ID: <77x7h6m5klki4pish2i3fhza26i6mhjw3cx66cpokg5kopthzk@7umq2wu7hyol>
References: <20250929111349.448324-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929111349.448324-1-sunjunchao@bytedance.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,fb.com,suse.com,redhat.com,gmail.com,mit.edu,dilger.ca,kernel.org,infradead.org,suse.cz];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Mon 29-09-25 19:13:49, Julian Sun wrote:
> The logic in wbc_to_tag() is widely used in file systems, so modify this
> function to be inline and use it in file systems.
> 
> This patch has only passed compilation tests, but it should be fine.
> 
> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/btrfs/extent_io.c      | 5 +----
>  fs/ceph/addr.c            | 6 +-----
>  fs/ext4/inode.c           | 5 +----
>  fs/f2fs/data.c            | 5 +----
>  fs/gfs2/aops.c            | 5 +----
>  include/linux/writeback.h | 7 +++++++
>  mm/page-writeback.c       | 6 ------
>  7 files changed, 12 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index b21cb72835cc..0fea58287175 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2390,10 +2390,7 @@ static int extent_write_cache_pages(struct address_space *mapping,
>  			       &BTRFS_I(inode)->runtime_flags))
>  		wbc->tagged_writepages = 1;
>  
> -	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
> -		tag = PAGECACHE_TAG_TOWRITE;
> -	else
> -		tag = PAGECACHE_TAG_DIRTY;
> +	tag = wbc_to_tag(wbc);
>  retry:
>  	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
>  		tag_pages_for_writeback(mapping, index, end);
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 322ed268f14a..63b75d214210 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -1045,11 +1045,7 @@ void ceph_init_writeback_ctl(struct address_space *mapping,
>  	ceph_wbc->index = ceph_wbc->start_index;
>  	ceph_wbc->end = -1;
>  
> -	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages) {
> -		ceph_wbc->tag = PAGECACHE_TAG_TOWRITE;
> -	} else {
> -		ceph_wbc->tag = PAGECACHE_TAG_DIRTY;
> -	}
> +	ceph_wbc->tag = wbc_to_tag(wbc);
>  
>  	ceph_wbc->op_idx = -1;
>  	ceph_wbc->num_ops = 0;
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 5b7a15db4953..196eba7fa39c 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -2619,10 +2619,7 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
>  	handle_t *handle = NULL;
>  	int bpp = ext4_journal_blocks_per_folio(mpd->inode);
>  
> -	if (mpd->wbc->sync_mode == WB_SYNC_ALL || mpd->wbc->tagged_writepages)
> -		tag = PAGECACHE_TAG_TOWRITE;
> -	else
> -		tag = PAGECACHE_TAG_DIRTY;
> +	tag = wbc_to_tag(mpd->wbc);
>  
>  	mpd->map.m_len = 0;
>  	mpd->next_pos = mpd->start_pos;
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 7961e0ddfca3..101e962845db 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -3003,10 +3003,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>  		if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
>  			range_whole = 1;
>  	}
> -	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
> -		tag = PAGECACHE_TAG_TOWRITE;
> -	else
> -		tag = PAGECACHE_TAG_DIRTY;
> +	tag = wbc_to_tag(wbc);
>  retry:
>  	retry = 0;
>  	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
> diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
> index 47d74afd63ac..12394fc5dd29 100644
> --- a/fs/gfs2/aops.c
> +++ b/fs/gfs2/aops.c
> @@ -311,10 +311,7 @@ static int gfs2_write_cache_jdata(struct address_space *mapping,
>  			range_whole = 1;
>  		cycled = 1; /* ignore range_cyclic tests */
>  	}
> -	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
> -		tag = PAGECACHE_TAG_TOWRITE;
> -	else
> -		tag = PAGECACHE_TAG_DIRTY;
> +	tag = wbc_to_tag(wbc);
>  
>  retry:
>  	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
> diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> index a2848d731a46..dde77d13a200 100644
> --- a/include/linux/writeback.h
> +++ b/include/linux/writeback.h
> @@ -240,6 +240,13 @@ static inline void inode_detach_wb(struct inode *inode)
>  	}
>  }
>  
> +static inline xa_mark_t wbc_to_tag(struct writeback_control *wbc)
> +{
> +	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
> +		return PAGECACHE_TAG_TOWRITE;
> +	return PAGECACHE_TAG_DIRTY;
> +}
> +
>  void wbc_attach_fdatawrite_inode(struct writeback_control *wbc,
>  		struct inode *inode);
>  
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 3e248d1c3969..ae1181a46dea 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2434,12 +2434,6 @@ static bool folio_prepare_writeback(struct address_space *mapping,
>  	return true;
>  }
>  
> -static xa_mark_t wbc_to_tag(struct writeback_control *wbc)
> -{
> -	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
> -		return PAGECACHE_TAG_TOWRITE;
> -	return PAGECACHE_TAG_DIRTY;
> -}
>  
>  static pgoff_t wbc_end(struct writeback_control *wbc)
>  {
> -- 
> 2.39.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

