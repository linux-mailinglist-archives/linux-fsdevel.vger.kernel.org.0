Return-Path: <linux-fsdevel+bounces-64902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E12F2BF6528
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 14:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A73F18C3A23
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 12:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C4233C509;
	Tue, 21 Oct 2025 11:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1TTkiGPk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BuV2xgvQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mPcYAdGf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1+8SUplI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8863396E9
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 11:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047594; cv=none; b=kgLepgdVhaZBhL+RDRrj6b+M72yW+zkz8dfDZj+H0HHrkU4V7e6WSVzglBnq9IdaWDdb1f0yvRvN//P+kx0gy3uh4mU1fIDReAAPuYSQma/mzXuxxHeGKUQL+xO3gZK9QNtPqtMxlFaOuxz/37AZKTzxl5F2Xb//xdY5+Dwzzn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047594; c=relaxed/simple;
	bh=8RTjJ7zh972v8WRy3c/aLWajZxbkAEI23M926Bbl+ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8/FUREtG6l8bTRLJhmqj3NNNFK64/nkI2AEHAnakBkDZJRDYCMzscv0N/eeu4QD/hk4o74oEc8Vfqf/MTQqD7EXMKnqhzuePc5BQ2tqEDCEVo4pX+rGQxmuGfxScMmD8wf+WZr2EZ8kcpS+0wuYZyQwAJRB3o7Ic1ENvtaV038=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1TTkiGPk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BuV2xgvQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mPcYAdGf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1+8SUplI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6BECE1F7BD;
	Tue, 21 Oct 2025 11:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761047583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+uorp+kk4hmsZbpZpm5Gun01lSMtY2PtNzIQ7LvYx/w=;
	b=1TTkiGPkzFlXtwxDEYw356BP9xhGDO5Phqb57mvhJKszoz9QmdQb2A5TTN5MKGjBdS/Kh/
	fFs3OwV4J2tE7J0ZuzUu1QJr1atyBrylovTHFzBh0STAXYpC96e5fQjr7IVcuJkXm1o8+0
	KyIOCBaz43F8+NRSIIQ+WzrM7em2uZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761047583;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+uorp+kk4hmsZbpZpm5Gun01lSMtY2PtNzIQ7LvYx/w=;
	b=BuV2xgvQE2Iib51rzP7AyujX1mAs98KsVZJJic6827wuj/OWy49BLKF8TZWsof8P1/vm6u
	qkZH7vIfBLrWrRBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mPcYAdGf;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1+8SUplI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761047579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+uorp+kk4hmsZbpZpm5Gun01lSMtY2PtNzIQ7LvYx/w=;
	b=mPcYAdGf2omVYbSV3sB9WE0ve2pyTWILXTwCYQDE+iEmiku2Zdi9/XhapA5CIYIHUzepBh
	cLHBgu8ROr3vkCN0eEvdTXKn8ppe5SB+NsOmxch3UBGDPpy9fdfTr6tuMxL42kst71l3oY
	oZwgaFdhYv2leSdox7oD3tPYj9jt/OU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761047579;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+uorp+kk4hmsZbpZpm5Gun01lSMtY2PtNzIQ7LvYx/w=;
	b=1+8SUplIr545q5gZVapwStOD5xK3D4DwPy15AmyIF1656N/dDWe5pYkDp+rqjMfjaMn6It
	1vBH3ehUKa/BPOCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 59B92139B1;
	Tue, 21 Oct 2025 11:52:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id etngFRt092ibVgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 21 Oct 2025 11:52:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E705AA0990; Tue, 21 Oct 2025 13:52:54 +0200 (CEST)
Date: Tue, 21 Oct 2025 13:52:54 +0200
From: Jan Kara <jack@suse.cz>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu, agruenba@redhat.com, 
	trondmy@kernel.org, anna@kernel.org, akpm@linux-foundation.org, willy@infradead.org, 
	mcgrof@kernel.org, clm@meta.com, david@fromorbit.com, amir73il@gmail.com, 
	axboe@kernel.dk, hch@lst.de, ritesh.list@gmail.com, djwong@kernel.org, 
	dave@stgolabs.net, wangyufei@vivo.com, linux-f2fs-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, 
	linux-mm@kvack.org, gost.dev@samsung.com, anuj20.g@samsung.com, vishak.g@samsung.com, 
	joshi.k@samsung.com
Subject: Re: [PATCH v2 01/16] writeback: add infra for parallel writeback
Message-ID: <25h6rdu2pweg6wwrfvw3n5bu34vnknqqfpotpfm47uxg267hp5@wo637wyeaxvh>
References: <20251014120845.2361-1-kundan.kumar@samsung.com>
 <CGME20251014121014epcas5p11d254fd09fcc157ea69c39bd9c5984ed@epcas5p1.samsung.com>
 <20251014120845.2361-2-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014120845.2361-2-kundan.kumar@samsung.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 6BECE1F7BD
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLhzk8m8dynxu9bgo74bfqqdh9)];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,szeredi.hu,redhat.com,linux-foundation.org,infradead.org,meta.com,fromorbit.com,gmail.com,kernel.dk,lst.de,stgolabs.net,vivo.com,lists.sourceforge.net,vger.kernel.org,lists.linux.dev,kvack.org,samsung.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:dkim,suse.cz:email]
X-Spam-Score: -2.51

On Tue 14-10-25 17:38:30, Kundan Kumar wrote:
> This is a prep patch which introduces a new bdi_writeback_ctx structure
> that enables us to have multiple writeback contexts for parallel
> writeback. Each bdi now can have multiple writeback contexts, with each
> writeback context having has its own cgwb tree.
> 
> Modify all the functions/places that operate on bdi's wb, wb_list,
> cgwb_tree, wb_switch_rwsem, wb_waitq as these fields have now been moved
> to bdi_writeback_ctx.
> 
> This patch mechanically replaces bdi->wb to bdi->wb_ctx[0]->wb and there
> is no functional change.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
> ---
>  fs/f2fs/node.c                   |   4 +-
>  fs/f2fs/segment.h                |   2 +-
>  fs/fs-writeback.c                |  78 +++++++++++++--------
>  fs/fuse/file.c                   |   6 +-
>  fs/gfs2/super.c                  |   2 +-
>  fs/nfs/internal.h                |   3 +-
>  fs/nfs/write.c                   |   3 +-
>  include/linux/backing-dev-defs.h |  32 +++++----
>  include/linux/backing-dev.h      |  41 +++++++----
>  include/linux/fs.h               |   1 -
>  mm/backing-dev.c                 | 113 +++++++++++++++++++------------
>  mm/page-writeback.c              |   5 +-
>  12 files changed, 179 insertions(+), 111 deletions(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 27743b93e186..1693da9417f9 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -73,7 +73,7 @@ bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type)
>  		if (excess_cached_nats(sbi))
>  			res = false;
>  	} else if (type == DIRTY_DENTS) {
> -		if (sbi->sb->s_bdi->wb.dirty_exceeded)
> +		if (sbi->sb->s_bdi->wb_ctx[0]->wb.dirty_exceeded)

I think this needs to be abstracted to proper helper like
bdi_dirty_exceeded() as a preparatory patch. We don't want filesystems to
mess with wb internals like this...

...

> @@ -994,18 +1003,19 @@ static long wb_split_bdi_pages(struct bdi_writeback *wb, long nr_pages)
>   * total active write bandwidth of @bdi.
>   */
>  static void bdi_split_work_to_wbs(struct backing_dev_info *bdi,
> +				  struct bdi_writeback_ctx *bdi_wb_ctx,
>  				  struct wb_writeback_work *base_work,
>  				  bool skip_if_busy)
>  {
>  	struct bdi_writeback *last_wb = NULL;
> -	struct bdi_writeback *wb = list_entry(&bdi->wb_list,
> +	struct bdi_writeback *wb = list_entry(&bdi_wb_ctx->wb_list,
>  					      struct bdi_writeback, bdi_node);
>  
>  	might_sleep();
>  restart:
>  	rcu_read_lock();
> -	list_for_each_entry_continue_rcu(wb, &bdi->wb_list, bdi_node) {
> -		DEFINE_WB_COMPLETION(fallback_work_done, bdi);
> +	list_for_each_entry_continue_rcu(wb, &bdi_wb_ctx->wb_list, bdi_node) {
> +		DEFINE_WB_COMPLETION(fallback_work_done, bdi_wb_ctx);
>  		struct wb_writeback_work fallback_work;
>  		struct wb_writeback_work *work;
>  		long nr_pages;

I think bdi_split_work_to_wbs() should stay as is (i.e., no additional
bdi_writeback_ctx) and instead it should iterate over all writeback
contexts and split work among them as well.

> @@ -2371,7 +2387,7 @@ static void __wakeup_flusher_threads_bdi(struct backing_dev_info *bdi,
>  	if (!bdi_has_dirty_io(bdi))
>  		return;
>  
> -	list_for_each_entry_rcu(wb, &bdi->wb_list, bdi_node)
> +	list_for_each_entry_rcu(wb, &bdi->wb_ctx[0]->wb_list, bdi_node)
>  		wb_start_writeback(wb, reason);
>  }
>  
> @@ -2427,7 +2443,8 @@ static void wakeup_dirtytime_writeback(struct work_struct *w)
>  	list_for_each_entry_rcu(bdi, &bdi_list, bdi_list) {
>  		struct bdi_writeback *wb;
>  
> -		list_for_each_entry_rcu(wb, &bdi->wb_list, bdi_node)
> +		list_for_each_entry_rcu(wb, &bdi->wb_ctx[0]->wb_list,
> +					bdi_node)
>  			if (!list_empty(&wb->b_dirty_time))
>  				wb_wakeup(wb);
>  	}
> @@ -2730,7 +2747,7 @@ static void __writeback_inodes_sb_nr(struct super_block *sb, unsigned long nr,
>  				     enum wb_reason reason, bool skip_if_busy)
>  {
>  	struct backing_dev_info *bdi = sb->s_bdi;
> -	DEFINE_WB_COMPLETION(done, bdi);
> +	DEFINE_WB_COMPLETION(done, bdi->wb_ctx[0]);
>  	struct wb_writeback_work work = {
>  		.sb			= sb,
>  		.sync_mode		= WB_SYNC_NONE,
> @@ -2744,7 +2761,8 @@ static void __writeback_inodes_sb_nr(struct super_block *sb, unsigned long nr,
>  		return;
>  	WARN_ON(!rwsem_is_locked(&sb->s_umount));
>  
> -	bdi_split_work_to_wbs(sb->s_bdi, &work, skip_if_busy);
> +	bdi_split_work_to_wbs(sb->s_bdi, bdi->wb_ctx[0], &work,
> +			      skip_if_busy);
>  	wb_wait_for_completion(&done);
>  }
>  
> @@ -2808,7 +2826,7 @@ EXPORT_SYMBOL(try_to_writeback_inodes_sb);
>  void sync_inodes_sb(struct super_block *sb)
>  {
>  	struct backing_dev_info *bdi = sb->s_bdi;
> -	DEFINE_WB_COMPLETION(done, bdi);
> +	DEFINE_WB_COMPLETION(done, bdi->wb_ctx[0]);
>  	struct wb_writeback_work work = {
>  		.sb		= sb,
>  		.sync_mode	= WB_SYNC_ALL,

Above places will clearly need more adaptation to work with multiple
writeback contexts (and several places below as well). That can happen in
later patches but it would be good to have some FIXME comments before them
to make it easy to verify we don't miss some place. In fact, I think it
might be easier to review if you just introduced for_each_bdi_wb_context()
macro with trivial implementation in this patch and used it where
appropriate instead of hardcoding wb_ctx[0] in places where we actually
need to iterate over all contexts. At least in the places where we don't
really need anything fancier than "call this for all writeback contexts in
the bdi" which seems to be a vast majority of cases. The complex cases can
be handled with FIXME comments and dealt with in later patches.

> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 4adcf09d4b01..8c823a661139 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1833,8 +1833,8 @@ static void fuse_writepage_finish(struct fuse_writepage_args *wpa)
>  		 * contention and noticeably improves performance.
>  		 */
>  		iomap_finish_folio_write(inode, ap->folios[i], 1);
> -		dec_wb_stat(&bdi->wb, WB_WRITEBACK);
> -		wb_writeout_inc(&bdi->wb);
> +		dec_wb_stat(&bdi->wb_ctx[0]->wb, WB_WRITEBACK);
> +		wb_writeout_inc(&bdi->wb_ctx[0]->wb);
>  	}
>  
>  	wake_up(&fi->page_waitq);
> @@ -2017,7 +2017,7 @@ static void fuse_writepage_args_page_fill(struct fuse_writepage_args *wpa, struc
>  	ap->descs[folio_index].offset = offset;
>  	ap->descs[folio_index].length = len;
>  
> -	inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
> +	inc_wb_stat(&inode_to_bdi(inode)->wb_ctx[0]->wb, WB_WRITEBACK);
>  }
>  

These seem to be gone in current upstream kernel.

> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> index c0a44f389f8f..5b3c84104b5b 100644
> --- a/fs/nfs/internal.h
> +++ b/fs/nfs/internal.h
> @@ -857,7 +857,8 @@ static inline void nfs_folio_mark_unstable(struct folio *folio,
>  		 * writeback is happening on the server now.
>  		 */
>  		node_stat_mod_folio(folio, NR_WRITEBACK, nr);
> -		wb_stat_mod(&inode_to_bdi(inode)->wb, WB_WRITEBACK, nr);
> +		wb_stat_mod(&inode_to_bdi(inode)->wb_ctx[0]->wb,
> +			    WB_WRITEBACK, nr);
>  		__mark_inode_dirty(inode, I_DIRTY_DATASYNC);
>  	}
>  }
> diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> index 647c53d1418a..4317b93bc2af 100644
> --- a/fs/nfs/write.c
> +++ b/fs/nfs/write.c
> @@ -865,9 +865,10 @@ static void nfs_folio_clear_commit(struct folio *folio)
>  {
>  	if (folio) {
>  		long nr = folio_nr_pages(folio);
> +		struct inode *inode = folio->mapping->host;
>  
>  		node_stat_mod_folio(folio, NR_WRITEBACK, -nr);
> -		wb_stat_mod(&inode_to_bdi(folio->mapping->host)->wb,
> +		wb_stat_mod(&inode_to_bdi(inode)->wb_ctx[0]->wb,
>  			    WB_WRITEBACK, -nr);
>  	}
>  }

Above two hunks need some helper as well so that we don't leak internal wb
details into filesystems. I think you should use fetch_bdi_writeback_ctx()
here?

> @@ -104,6 +105,7 @@ struct wb_completion {
>   */
>  struct bdi_writeback {
>  	struct backing_dev_info *bdi;	/* our parent bdi */
> +	struct bdi_writeback_ctx *bdi_wb_ctx;
>  
>  	unsigned long state;		/* Always use atomic bitops on this */
>  	unsigned long last_old_flush;	/* last old data flush */
> @@ -160,6 +162,16 @@ struct bdi_writeback {
>  #endif
>  };
>  
> +struct bdi_writeback_ctx {
> +	struct bdi_writeback wb;  /* the root writeback info for this bdi */
> +	struct list_head wb_list; /* list of all wbs */
> +#ifdef CONFIG_CGROUP_WRITEBACK
> +	struct radix_tree_root cgwb_tree; /* radix tree of active cgroup wbs */
> +	struct rw_semaphore wb_switch_rwsem; /* no cgwb switch while syncing */
> +#endif
> +	wait_queue_head_t wb_waitq;
> +};
> +
>
>  struct backing_dev_info {
>  	u64 id;
>  	struct rb_node rb_node; /* keyed by ->id */
> @@ -183,15 +195,11 @@ struct backing_dev_info {
>  	 */
>  	unsigned long last_bdp_sleep;
>  
> -	struct bdi_writeback wb;  /* the root writeback info for this bdi */
> -	struct list_head wb_list; /* list of all wbs */
> +	int nr_wb_ctx;
> +	struct bdi_writeback_ctx **wb_ctx;
>  #ifdef CONFIG_CGROUP_WRITEBACK
> -	struct radix_tree_root cgwb_tree; /* radix tree of active cgroup wbs */
>  	struct mutex cgwb_release_mutex;  /* protect shutdown of wb structs */
> -	struct rw_semaphore wb_switch_rwsem; /* no cgwb switch while syncing */
>  #endif
> -	wait_queue_head_t wb_waitq;
> -
>  	struct device *dev;
>  	char dev_name[64];
>  	struct device *owner;
...
> diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
> index e721148c95d0..92674543ac8a 100644
> --- a/include/linux/backing-dev.h
> +++ b/include/linux/backing-dev.h
> @@ -148,11 +148,20 @@ static inline bool mapping_can_writeback(struct address_space *mapping)
>  	return inode_to_bdi(mapping->host)->capabilities & BDI_CAP_WRITEBACK;
>  }
>  
> +static inline struct bdi_writeback_ctx *
> +fetch_bdi_writeback_ctx(struct inode *inode)
> +{
> +	struct backing_dev_info *bdi = inode_to_bdi(inode);
> +
> +	return bdi->wb_ctx[0];
> +}

I think a better name for this function would be inode_writeback_ctx().

> @@ -187,16 +196,18 @@ static inline bool inode_cgwb_enabled(struct inode *inode)
>   * Must be called under rcu_read_lock() which protects the returend wb.
>   * NULL if not found.
>   */
> -static inline struct bdi_writeback *wb_find_current(struct backing_dev_info *bdi)
> +static inline struct bdi_writeback *
> +wb_find_current(struct backing_dev_info *bdi,
> +		struct bdi_writeback_ctx *bdi_wb_ctx)

This function doesn't need bdi anymore so why do you keep passing it?

>  {
>  	struct cgroup_subsys_state *memcg_css;
>  	struct bdi_writeback *wb;
>  
>  	memcg_css = task_css(current, memory_cgrp_id);
>  	if (!memcg_css->parent)
> -		return &bdi->wb;
> +		return &bdi_wb_ctx->wb;
>  
> -	wb = radix_tree_lookup(&bdi->cgwb_tree, memcg_css->id);
> +	wb = radix_tree_lookup(&bdi_wb_ctx->cgwb_tree, memcg_css->id);
>  
>  	/*
>  	 * %current's blkcg equals the effective blkcg of its memcg.  No
> @@ -217,12 +228,13 @@ static inline struct bdi_writeback *wb_find_current(struct backing_dev_info *bdi
>   * wb_find_current().
>   */
>  static inline struct bdi_writeback *
> -wb_get_create_current(struct backing_dev_info *bdi, gfp_t gfp)
> +wb_get_create_current(struct backing_dev_info *bdi,
> +		      struct bdi_writeback_ctx *bdi_wb_ctx, gfp_t gfp)

I think functions like wb_get_create_current(), wb_get_create() etc. should
all be getting just struct bdi_writeback_ctx as argument because that
really specifies where we want the wb to be created. In some cases we do
need to get up to the struct backing_dev_info so you'll need to add struct
backing_dev_info pointer to bdi_writeback_ctx but I think that's fine.

> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index 783904d8c5ef..8b7125349f6c 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -84,13 +84,14 @@ static void collect_wb_stats(struct wb_stats *stats,
>  }
>  
>  #ifdef CONFIG_CGROUP_WRITEBACK
> +
>  static void bdi_collect_stats(struct backing_dev_info *bdi,
>  			      struct wb_stats *stats)
>  {
>  	struct bdi_writeback *wb;
>  
>  	rcu_read_lock();
> -	list_for_each_entry_rcu(wb, &bdi->wb_list, bdi_node) {
> +	list_for_each_entry_rcu(wb, &bdi->wb_ctx[0]->wb_list, bdi_node) {
>  		if (!wb_tryget(wb))
>  			continue;
>  
> @@ -103,7 +104,7 @@ static void bdi_collect_stats(struct backing_dev_info *bdi,
>  static void bdi_collect_stats(struct backing_dev_info *bdi,
>  			      struct wb_stats *stats)
>  {
> -	collect_wb_stats(stats, &bdi->wb);
> +	collect_wb_stats(stats, &bdi->wb_ctx[0]->wb);
>  }
>  #endif
>  
> @@ -149,7 +150,7 @@ static int bdi_debug_stats_show(struct seq_file *m, void *v)
>  		   stats.nr_io,
>  		   stats.nr_more_io,
>  		   stats.nr_dirty_time,
> -		   !list_empty(&bdi->bdi_list), bdi->wb.state);
> +		   !list_empty(&bdi->bdi_list), bdi->wb_ctx[0]->wb.state);
>  
>  	return 0;
>  }
> @@ -193,14 +194,14 @@ static void wb_stats_show(struct seq_file *m, struct bdi_writeback *wb,
>  static int cgwb_debug_stats_show(struct seq_file *m, void *v)
>  {
>  	struct backing_dev_info *bdi = m->private;
> +	struct bdi_writeback *wb;
>  	unsigned long background_thresh;
>  	unsigned long dirty_thresh;
> -	struct bdi_writeback *wb;
>  
>  	global_dirty_limits(&background_thresh, &dirty_thresh);
>  
>  	rcu_read_lock();
> -	list_for_each_entry_rcu(wb, &bdi->wb_list, bdi_node) {
> +	list_for_each_entry_rcu(wb, &bdi->wb_ctx[0]->wb_list, bdi_node) {
>  		struct wb_stats stats = { .dirty_thresh = dirty_thresh };
>  
>  		if (!wb_tryget(wb))
> @@ -520,6 +521,7 @@ static int wb_init(struct bdi_writeback *wb, struct backing_dev_info *bdi,
>  	memset(wb, 0, sizeof(*wb));
>  
>  	wb->bdi = bdi;
> +	wb->bdi_wb_ctx = bdi->wb_ctx[0];
>  	wb->last_old_flush = jiffies;
>  	INIT_LIST_HEAD(&wb->b_dirty);
>  	INIT_LIST_HEAD(&wb->b_io);
> @@ -643,11 +645,12 @@ static void cgwb_release(struct percpu_ref *refcnt)
>  	queue_work(cgwb_release_wq, &wb->release_work);
>  }
>  
> -static void cgwb_kill(struct bdi_writeback *wb)
> +static void cgwb_kill(struct bdi_writeback *wb,
> +		      struct bdi_writeback_ctx *bdi_wb_ctx)
>  {
>  	lockdep_assert_held(&cgwb_lock);
>  
> -	WARN_ON(!radix_tree_delete(&wb->bdi->cgwb_tree, wb->memcg_css->id));
> +	WARN_ON(!radix_tree_delete(&bdi_wb_ctx->cgwb_tree, wb->memcg_css->id));

Why don't you use wb->bdi_wb_ctx instead of passing bdi_wb_ctx as a
function argument?

> @@ -662,6 +665,7 @@ static void cgwb_remove_from_bdi_list(struct bdi_writeback *wb)
>  }
>  
>  static int cgwb_create(struct backing_dev_info *bdi,
> +		       struct bdi_writeback_ctx *bdi_wb_ctx,
>  		       struct cgroup_subsys_state *memcg_css, gfp_t gfp)
>  {

I'd pass *only* bdi_writeback_ctx here.

> @@ -813,6 +818,7 @@ struct bdi_writeback *wb_get_lookup(struct backing_dev_info *bdi,
>   * create one.  See wb_get_lookup() for more details.
>   */
>  struct bdi_writeback *wb_get_create(struct backing_dev_info *bdi,
> +				    struct bdi_writeback_ctx *bdi_wb_ctx,
>  				    struct cgroup_subsys_state *memcg_css,
>  				    gfp_t gfp)
>  {

And here as well.

> -static void cgwb_bdi_register(struct backing_dev_info *bdi)
> +static void cgwb_bdi_register(struct backing_dev_info *bdi,
> +		struct bdi_writeback_ctx *bdi_wb_ctx)

Again no need for bdi here...

>  {
>  	spin_lock_irq(&cgwb_lock);
> -	list_add_tail_rcu(&bdi->wb.bdi_node, &bdi->wb_list);
> +	list_add_tail_rcu(&bdi_wb_ctx->wb.bdi_node, &bdi_wb_ctx->wb_list);
>  	spin_unlock_irq(&cgwb_lock);
>  }
>  

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

