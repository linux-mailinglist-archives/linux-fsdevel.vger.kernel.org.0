Return-Path: <linux-fsdevel+bounces-44454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 331FDA6941C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 16:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AB8E17C9CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 15:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D68F1D79B8;
	Wed, 19 Mar 2025 15:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="a2y7yMoR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GmjBBI9g";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="a2y7yMoR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GmjBBI9g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F02E1B6CE0
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 15:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742399653; cv=none; b=ImFrlJl5uVEkW+jz77eK17IUL6HjJmiOqSFBt+0IYHvbFG1v+Ov0Qt7e09uf3XZpfYvTxbXvuYYGorFOqCL5JVFHAc9L/5BrwwHjfXn1uhRNNo42o/KS1Jrw/LHMtqsGyQ9GxOF0ptd7uLFtVWfLyqi863vCqaw1mLQ9nFaER8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742399653; c=relaxed/simple;
	bh=cN3YtOFtZDW5KQ8WSF2b1CCv7JD/rgunE0F184aQ6mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CU9P82Eji9qh7sT3xkLkbTF244i/Tl+ro3G7R0/UU6glVB4hLHNa/e1GWatuvqWY1jshwCgoGIjsMv0wCHN+bu6aioXdw5RIDpqd/doV8v+Fe8u0unA9gRmZk20POjsc4I2IVX1E9dyhKhbF67+pjyBp8hSF7uttL6R7dJ/ZhR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=a2y7yMoR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GmjBBI9g; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=a2y7yMoR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GmjBBI9g; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 893DE2191C;
	Wed, 19 Mar 2025 15:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742399648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QRaFa1MFKzQ/6eSVd+w33b/cDI8lOm8iEz6IbpJxhUY=;
	b=a2y7yMoR7YbJ5MJVbCiwdPKcJoztzioppPforCO8l5DGdbU/PI9bErfONQ8hYiTC8b3K2+
	2N9qBkMN6cPf38/84S0rHjuKcpH5GomAJpfmcPOD7adi5ZBOvSUHyCnZp8WxQNLR7ZDg+U
	OXkoB2oPEzLYfNHC5T5XterL4ir3IC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742399648;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QRaFa1MFKzQ/6eSVd+w33b/cDI8lOm8iEz6IbpJxhUY=;
	b=GmjBBI9gelOHeDTMYPEWYQTs3kTxqff203/pS+0kKg2KOQZtleXlZluGRY5Q1PtAAhYG0n
	Gb/DyH1iuvCIWVAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742399648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QRaFa1MFKzQ/6eSVd+w33b/cDI8lOm8iEz6IbpJxhUY=;
	b=a2y7yMoR7YbJ5MJVbCiwdPKcJoztzioppPforCO8l5DGdbU/PI9bErfONQ8hYiTC8b3K2+
	2N9qBkMN6cPf38/84S0rHjuKcpH5GomAJpfmcPOD7adi5ZBOvSUHyCnZp8WxQNLR7ZDg+U
	OXkoB2oPEzLYfNHC5T5XterL4ir3IC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742399648;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QRaFa1MFKzQ/6eSVd+w33b/cDI8lOm8iEz6IbpJxhUY=;
	b=GmjBBI9gelOHeDTMYPEWYQTs3kTxqff203/pS+0kKg2KOQZtleXlZluGRY5Q1PtAAhYG0n
	Gb/DyH1iuvCIWVAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 676EA13726;
	Wed, 19 Mar 2025 15:54:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dKw8GaDo2mfyUQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 19 Mar 2025 15:54:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0A18EA08D2; Wed, 19 Mar 2025 16:54:08 +0100 (CET)
Date: Wed, 19 Mar 2025 16:54:07 +0100
From: Jan Kara <jack@suse.cz>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: Jan Kara <jack@suse.cz>, Kundan Kumar <kundan.kumar@samsung.com>, 
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>, 
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, mcgrof@kernel.org, 
	joshi.k@samsung.com, axboe@kernel.dk, clm@meta.com, willy@infradead.org, 
	gost.dev@samsung.com
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Parallelizing filesystem writeback
Message-ID: <gamxtewl5yzg4xwu7lpp7obhp44xh344swvvf7tmbiknvbd3ww@jowphz4h4zmb>
References: <20250129102627.161448-1-kundan.kumar@samsung.com>
 <Z5qw_1BOqiFum5Dn@dread.disaster.area>
 <20250131093209.6luwm4ny5kj34jqc@green245>
 <Z6GAYFN3foyBlUxK@dread.disaster.area>
 <20250204050642.GF28103@lst.de>
 <s43qlmnbtjbpc5vn75gokti3au7qhvgx6qj7qrecmkd2dgrdfv@no2i7qifnvvk>
 <Z6qkLjSj1K047yPt@dread.disaster.area>
 <20250220141824.ju5va75s3xp472cd@green245>
 <qdgoyhi5qjnlfk6zmlizp2lcrmg43rwmy3tl4yz6zkgavgfav5@nsfculj7aoxe>
 <20250318113712.GA14945@green245>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318113712.GA14945@green245>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	URIBL_BLOCKED(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,samsung.com:email,suse.cz:email];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,samsung.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 18-03-25 17:07:12, Anuj Gupta wrote:
> > I was thinking about how to best parallelize the writeback and I think
> > there are two quite different demands for which we probably want two
> > different levels of parallelism.
> > 
> > One case is the situation when the filesystem for example has multiple
> > underlying devices (like btrfs or bcachefs) or for other reasons writeback
> > to different parts is fairly independent (like for different XFS AGs). Here
> > we want parallelism at rather high level I think including separate
> > dirty throttling, tracking of writeback bandwidth etc.. It is *almost* like
> > separate bdis (struct backing_dev_info) but I think it would be technically
> > and also conceptually somewhat easier to do the multiplexing by factoring
> > out:
> > 
> >         struct bdi_writeback wb;  /* the root writeback info for this bdi */
> >         struct list_head wb_list; /* list of all wbs */
> > #ifdef CONFIG_CGROUP_WRITEBACK
> >         struct radix_tree_root cgwb_tree; /* radix tree of active cgroup wbs */
> >         struct rw_semaphore wb_switch_rwsem; /* no cgwb switch while syncing */
> > #endif
> >         wait_queue_head_t wb_waitq;
> > 
> > into a new structure (looking for a good name - bdi_writeback_context???)
> > that can get multiplied (filesystem can create its own bdi on mount and
> > configure there number of bdi_writeback_contexts it wants). We also need to
> > add a hook sb->s_ops->get_inode_wb_context() called from __inode_attach_wb()
> > which will return appropriate bdi_writeback_context (or perhaps just it's
> > index?) for an inode. This will be used by the filesystem to direct
> > writeback code where the inode should go. This is kind of what Kundan did
> > in the last revision of his patches but I hope this approach should
> > somewhat limit the changes necessary to writeback infrastructure - the
> > patch 2 in his series is really unreviewably large...
> 
> Thanks Jan.
> 
> I tried to modify the existing infra based on your suggestion [1]. This
> only takes care of the first case that you mentioned. I am yet to start
> to evaluate and implement the second case (when amount of cpu work is
> high). The patch is large, because it requires changing all the places
> that uses bdi's fields that have now been moved to a new structure. I
> will try to streamline it further.
> 
> I have omitted the xfs side plumbing for now.
> Can you please see if this aligns with the scheme that you had in mind?
> If the infra looks fine, I can plumb XFS changes on top of it.
> 
> Note: This patch is only compile tested, haven't run any tests on it.

Sure, this is fine for this early prototyping phase.

> Subject: [PATCH] writeback: add infra for parallel writeback
> 
> Introduce a new bdi_writeback_ctx structure that enables us to have
> multiple writeback contexts for parallel writeback.
> 
> Existing single threaded writeback will use default_ctx.
> 
> Filesystem now have the option to create there own bdi aind populate
> multiple bdi_writeback_ctx in bdi's bdi_wb_ctx_arr (xarray for now, but
> plan to move to use a better structure like list_lru).
> 
> Introduce a new hook get_inode_wb_ctx() in super_operations which takes
> inode as a parameter and returns the bdi_wb_ctx corresponding to the
> inode.
> 
> Modify all the functions/places that operate on bdi's wb, wb_list,
> cgwb_tree, wb_switch_rwsem, wb_waitq as these fields have now been moved
> to bdi_writeback_ctx
> 
> Store a reference to bdi_wb_ctx in bdi_writeback.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>

Thanks for the patch! Overall I think we are going in the right direction
:) Some comments below.

> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 3cd99e2dc6ac..4c47c298f174 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -265,23 +265,27 @@ void __inode_attach_wb(struct inode *inode, struct folio *folio)
>  {
>  	struct backing_dev_info *bdi = inode_to_bdi(inode);
>  	struct bdi_writeback *wb = NULL;
> +	struct bdi_writeback_ctx *bdi_writeback_ctx =
> +						fetch_bdi_writeback_ctx(inode);
						^^^
I'd call this inode_bdi_writeback_ctx(). I think that name tells a bit
more.

>  	if (inode_cgwb_enabled(inode)) {
>  		struct cgroup_subsys_state *memcg_css;
>  
>  		if (folio) {
>  			memcg_css = mem_cgroup_css_from_folio(folio);
> -			wb = wb_get_create(bdi, memcg_css, GFP_ATOMIC);
> +			wb = wb_get_create(bdi, bdi_writeback_ctx, memcg_css,
> +					   GFP_ATOMIC);
>  		} else {
>  			/* must pin memcg_css, see wb_get_create() */
>  			memcg_css = task_get_css(current, memory_cgrp_id);
> -			wb = wb_get_create(bdi, memcg_css, GFP_ATOMIC);
> +			wb = wb_get_create(bdi, bdi_writeback_ctx, memcg_css,
> +					   GFP_ATOMIC);
>  			css_put(memcg_css);
>  		}
>  	}
>  
>  	if (!wb)
> -		wb = &bdi->wb;
> +		wb = &bdi_writeback_ctx->wb;

Perhaps as a preparation patch, can you please rename bdi->wb to
bdi->root_wb (just mechanical replacement) and then carry over this name to
bdi_writeback_ctx? Because we have too many wbs here already and as the
structure is getting more complex, explanatory naming becomes more
important. Thanks!

> @@ -1103,7 +1112,17 @@ int cgroup_writeback_by_id(u64 bdi_id, int memcg_id,
>  	 * And find the associated wb.  If the wb isn't there already
>  	 * there's nothing to flush, don't create one.
>  	 */
> -	wb = wb_get_lookup(bdi, memcg_css);
> +	if (bdi->is_parallel) {
> +		struct bdi_writeback_ctx *bdi_wb_ctx;
> +
> +		for_each_bdi_wb_ctx(bdi, bdi_wb_ctx) {
> +			wb = wb_get_lookup(bdi_wb_ctx, memcg_css);
> +			if (wb)
> +				break;
> +		}
> +	} else {
> +		wb = wb_get_lookup(&bdi->default_ctx, memcg_css);
> +	}

Why do you introduce this bdi->is_parallel bool? Why don't we
unconditionally do:

	for_each_bdi_wb_ctx(bdi, bdi_wb_ctx) {
		wb = wb_get_lookup(bdi_wb_ctx, memcg_css);
		if (wb)
			break;
	}

It would seem more obvious and with less code duplication... It might
require a bit of magic inside for_each_bdi_wb_ctx() but I think it pays
off. BTW, you should initialize 'wb' before the loop to NULL. Otherwise I
expect some compilers to complain and also for readers it makes the test
below obviously do the right thing.

>  	if (!wb) {
>  		ret = -ENOENT;
>  		goto out_css_put;
...
> @@ -1232,13 +1251,14 @@ static long wb_split_bdi_pages(struct bdi_writeback *wb, long nr_pages)
>  
>  static void bdi_split_work_to_wbs(struct backing_dev_info *bdi,
>  				  struct wb_writeback_work *base_work,
> -				  bool skip_if_busy)
> +				  bool skip_if_busy,
> +				  struct bdi_writeback_ctx *bdi_wb_ctx)

Nit; logical position for bdi_wb_ctx argument would be just after 'bdi' but
see below - I think we could pass only bdi_wb_ctx here after some changes.

> @@ -2713,11 +2753,12 @@ static void wait_sb_inodes(struct super_block *sb)
>  	mutex_unlock(&sb->s_sync_lock);
>  }
>  
> -static void __writeback_inodes_sb_nr(struct super_block *sb, unsigned long nr,
> -				     enum wb_reason reason, bool skip_if_busy)
> +static void __writeback_inodes_sb_nr_bdi_wb_ctx(struct super_block *sb,
> +						unsigned long nr, enum wb_reason reason,
> +						bool skip_if_busy,
> +						struct bdi_writeback_ctx *bdi_wb_ctx)
>  {
> -	struct backing_dev_info *bdi = sb->s_bdi;
> -	DEFINE_WB_COMPLETION(done, bdi);
> +	DEFINE_WB_COMPLETION(done, bdi_wb_ctx);
>  	struct wb_writeback_work work = {
>  		.sb			= sb,
>  		.sync_mode		= WB_SYNC_NONE,
> @@ -2727,12 +2768,29 @@ static void __writeback_inodes_sb_nr(struct super_block *sb, unsigned long nr,
>  		.reason			= reason,
>  	};
>  
> +	bdi_split_work_to_wbs(sb->s_bdi, &work, skip_if_busy, bdi_wb_ctx);
> +	wb_wait_for_completion(&done);
> +}
> +
> +static void __writeback_inodes_sb_nr(struct super_block *sb, unsigned long nr,
> +				     enum wb_reason reason, bool skip_if_busy)
> +{
> +	struct backing_dev_info *bdi = sb->s_bdi;
> +
>  	if (!bdi_has_dirty_io(bdi) || bdi == &noop_backing_dev_info)
>  		return;
>  	WARN_ON(!rwsem_is_locked(&sb->s_umount));
>  
> -	bdi_split_work_to_wbs(sb->s_bdi, &work, skip_if_busy);
> -	wb_wait_for_completion(&done);
> +	if (bdi->is_parallel) {
> +		struct bdi_writeback_ctx *bdi_wb_ctx;
> +
> +		for_each_bdi_wb_ctx(bdi, bdi_wb_ctx)
> +			__writeback_inodes_sb_nr_bdi_wb_ctx(sb, nr, reason,
> +							    skip_if_busy, bdi_wb_ctx);
> +	} else {
> +		__writeback_inodes_sb_nr_bdi_wb_ctx(sb, nr, reason,
> +						    skip_if_busy, &bdi->default_ctx);
> +	}
>  }

If we drop this 'is_parallel' thing, I think we don't need the new
__writeback_inodes_sb_nr_bdi_wb_ctx() function and can keep everything
in one function.

>  
>  /**
> @@ -2785,17 +2843,10 @@ void try_to_writeback_inodes_sb(struct super_block *sb, enum wb_reason reason)
>  }
>  EXPORT_SYMBOL(try_to_writeback_inodes_sb);
>  
> -/**
> - * sync_inodes_sb	-	sync sb inode pages
> - * @sb: the superblock
> - *
> - * This function writes and waits on any dirty inode belonging to this
> - * super_block.
> - */
> -void sync_inodes_sb(struct super_block *sb)
> +static void sync_inodes_bdi_wb_ctx(struct super_block *sb,
> +		struct backing_dev_info *bdi, struct bdi_writeback_ctx *bdi_wb_ctx)
>  {
> -	struct backing_dev_info *bdi = sb->s_bdi;
> -	DEFINE_WB_COMPLETION(done, bdi);
> +	DEFINE_WB_COMPLETION(done, bdi_wb_ctx);
>  	struct wb_writeback_work work = {
>  		.sb		= sb,
>  		.sync_mode	= WB_SYNC_ALL,
> @@ -2805,6 +2856,22 @@ void sync_inodes_sb(struct super_block *sb)
>  		.reason		= WB_REASON_SYNC,
>  		.for_sync	= 1,
>  	};
> +	bdi_wb_ctx_down_write_wb_switch_rwsem(bdi_wb_ctx);
> +	bdi_split_work_to_wbs(bdi, &work, false, bdi_wb_ctx);
> +	wb_wait_for_completion(&done);
> +	bdi_wb_ctx_up_write_wb_switch_rwsem(bdi_wb_ctx);
> +}
> +
> +/**
> + * sync_inodes_sb	-	sync sb inode pages
> + * @sb: the superblock
> + *
> + * This function writes and waits on any dirty inode belonging to this
> + * super_block.
> + */
> +void sync_inodes_sb(struct super_block *sb)
> +{
> +	struct backing_dev_info *bdi = sb->s_bdi;
>  
>  	/*
>  	 * Can't skip on !bdi_has_dirty() because we should wait for !dirty
> @@ -2815,12 +2882,15 @@ void sync_inodes_sb(struct super_block *sb)
>  		return;
>  	WARN_ON(!rwsem_is_locked(&sb->s_umount));
>  
> -	/* protect against inode wb switch, see inode_switch_wbs_work_fn() */
> -	bdi_down_write_wb_switch_rwsem(bdi);
> -	bdi_split_work_to_wbs(bdi, &work, false);
> -	wb_wait_for_completion(&done);
> -	bdi_up_write_wb_switch_rwsem(bdi);
> +	if (bdi->is_parallel) {
> +		struct bdi_writeback_ctx *bdi_wb_ctx;
>  
> +		for_each_bdi_wb_ctx(bdi, bdi_wb_ctx) {
> +			sync_inodes_bdi_wb_ctx(sb, bdi, bdi_wb_ctx);
> +		}
> +	} else {
> +		sync_inodes_bdi_wb_ctx(sb, bdi, &bdi->default_ctx);
> +	}
>  	wait_sb_inodes(sb);
>  }
>  EXPORT_SYMBOL(sync_inodes_sb);

The same comment as above.

> @@ -104,6 +104,7 @@ struct wb_completion {
>   */
>  struct bdi_writeback {
>  	struct backing_dev_info *bdi;	/* our parent bdi */
> +	struct bdi_writeback_ctx *bdi_wb_ctx;
>  
>  	unsigned long state;		/* Always use atomic bitops on this */
>  	unsigned long last_old_flush;	/* last old data flush */
> @@ -160,6 +161,16 @@ struct bdi_writeback {
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

As I was seeing the patch, I'd also add:
	struct backing_dev_info *bdi;

pointer to bdi_writeback_ctx. Then in most functions, you can just pass
bdi_wb_ctx into them instead of both bdi *and* bdi_wb_ctx and it makes
interfaces somewhat nicer.

>  struct backing_dev_info {
>  	u64 id;
>  	struct rb_node rb_node; /* keyed by ->id */
> @@ -182,16 +193,13 @@ struct backing_dev_info {
>  	 * blk-wbt.
>  	 */
>  	unsigned long last_bdp_sleep;
> -
> -	struct bdi_writeback wb;  /* the root writeback info for this bdi */
> -	struct list_head wb_list; /* list of all wbs */
> +	struct bdi_writeback_ctx default_ctx;
> +	bool is_parallel;
> +	int nr_wb_ctx;
> +	struct xarray bdi_wb_ctx_arr;

I think xarray here is overkill. I'd just make this a plain array:

	struct bdi_writeback_ctx **bdi_wb_ctx_arr;

which will get allocated with nr_wb_ctx entries during bdi_init(). Also I'd
make default_ctx just be entry at index 0 in this array. I'm undecided
whether it will be clearer to just drop default_ctx altogether or keep it
and set:

	struct bdi_writeback_ctx *default_ctx = bdi_wb_ctx_arr[0];

on init so I'll leave that up to you.

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

> +static inline struct bdi_writeback_ctx *fetch_bdi_writeback_ctx(struct inode *inode)
> +{
> +	struct backing_dev_info *bdi = inode_to_bdi(inode);
> +	struct super_block *sb = inode->i_sb;
> +	struct bdi_writeback_ctx *bdi_wb_ctx;
> +
> +	if (sb->s_op->get_inode_wb_ctx)
> +		bdi_wb_ctx = sb->s_op->get_inode_wb_ctx(inode);
> +	else
> +		bdi_wb_ctx = &bdi->default_ctx;
> +	return bdi_wb_ctx;
> +}

The indirect call (and the handling in there) might get potentially
expensive given all the places where this is called. For now I think we are
fine but eventually we might need to find space in struct inode (I know
that's a hard sell) for u8/u16 to store writeback context index there. But
first let's get this working before we burry ourselves in (potentially
premature) performance optimizations.

> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 7e29433c5ecc..667f97c68cd1 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2228,6 +2228,7 @@ struct super_operations {
>     	struct inode *(*alloc_inode)(struct super_block *sb);
>  	void (*destroy_inode)(struct inode *);
>  	void (*free_inode)(struct inode *);
> +	struct bdi_writeback_ctx* (*get_inode_wb_ctx)(struct inode *);
                                ^^ wrongly placed space here.
>  
>     	void (*dirty_inode) (struct inode *, int flags);
>  	int (*write_inode) (struct inode *, struct writeback_control *wbc);

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

