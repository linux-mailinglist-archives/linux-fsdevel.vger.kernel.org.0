Return-Path: <linux-fsdevel+bounces-29090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2812C975017
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 12:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C491B28D7E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 10:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9529186611;
	Wed, 11 Sep 2024 10:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WbVoOYIM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="41Hr5tLA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hX7e+S0J";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dvlkKre7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B2B14A097;
	Wed, 11 Sep 2024 10:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726051854; cv=none; b=s/xCBHk+28Ai43ywjIKHyoIH/nvWQDqh6DdfQb18xn424XjduHJ5vD5LTv+vDKQpaqh/TjuvOeTlsyv5uIssbcUSwXHcN8WQqvg6dIpaO4dAkp2jeEahV+qjispWc3hIjr0h40vAHQaf4Q+bulMoloGicxG34PDdrQE/sDcHkU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726051854; c=relaxed/simple;
	bh=DbZKP0AbvVVBQB8u19Y7/SLVr2Vgda7jyqsUQs46yxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggXV7VsjVB8MgGxX9CmtxEmGQeKKSREDq1RlyewKqn2PDVGFNbT68BdRN5gAfOnnLSHoAI1hS28mmXBahqjXDjrmSru4Yf6FjErxfK6nUKAWq3gR3j7Z6mc3O+1OQ55Uk5mAL+TNsRROdMRf5WHxNkXLNBA5QQz356IOgMlsGjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WbVoOYIM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=41Hr5tLA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hX7e+S0J; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dvlkKre7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2C6E91F8A6;
	Wed, 11 Sep 2024 10:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726051850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jwXOIpb6yYpDXDJRvC5Clqos8OxkOKuKVsqJGz1Gykg=;
	b=WbVoOYIMlf6csnOAdDIwuABVxYSCci+pXhx4v7WtK7YTrxCv/RNphZbWVv2yDO72/Bvu+V
	gQ0dJCVaDi7VKjdr+c+v5SNsSXwVsje/vWdaf9A1kSBWckUGx1Ukp0bwGqn2x3Z5sox9ns
	JWcoyoxOnZ2ZlnwbnZ4NsS7otBgmpn8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726051850;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jwXOIpb6yYpDXDJRvC5Clqos8OxkOKuKVsqJGz1Gykg=;
	b=41Hr5tLACBo/bXNletF3hyj47HFFYCS2WDpF3mEyYe1JFjahgrTXEZ/dWtzJb1UzwNbBzx
	2v9z42PPqzytCIAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726051849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jwXOIpb6yYpDXDJRvC5Clqos8OxkOKuKVsqJGz1Gykg=;
	b=hX7e+S0J5J7/mPZgvenqSpNAKFWsagRDBV94eGZmQVVGt3ecMe3lXqaUzmmmFfuAsFHY+H
	biCabu2wjTVr5Ih7Qp1mueYs5JkVc0JiAr5mvygroHyfIeOyISFY4yd9PyQMQ5hyAZB7lr
	dDWvYRBEFMF8MdODDydAjdF0hJjqv2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726051849;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jwXOIpb6yYpDXDJRvC5Clqos8OxkOKuKVsqJGz1Gykg=;
	b=dvlkKre7yumt5qA/mbgQTS4zIZyjCGqcHFaBJHNa9EhVNnnXozEx3s+o9bio+SnX2TaAUU
	B6r/uXUxino1Z1Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20EA313ABD;
	Wed, 11 Sep 2024 10:50:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XeoCCAl24WZ6DQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 11 Sep 2024 10:50:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B2BA1A098C; Wed, 11 Sep 2024 12:50:33 +0200 (CEST)
Date: Wed, 11 Sep 2024 12:50:33 +0200
From: Jan Kara <jack@suse.cz>
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	Zhaoyang Huang <huangzhaoyang@gmail.com>, steve.kang@unisoc.com
Subject: Re: [RFC PATCH 1/1] fs: jbd2: try to launch cp transaction when bh
 refer cma
Message-ID: <20240911105033.cj2sd4zd7ugkbyxs@quack3>
References: <20240820072609.570513-1-zhaoyang.huang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820072609.570513-1-zhaoyang.huang@unisoc.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[mit.edu,suse.com,vger.kernel.org,gmail.com,unisoc.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,unisoc.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 20-08-24 15:26:09, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> cma_alloc() keep failed when an bunch of IO operations happened on an
> journal enabled ext4 device which is caused by a jh->bh->b_page
> can not be migrated out of CMA area as the jh has one cp_transaction
> pending on it. We solve this by launching jbd2_log_do_checkpoint forcefully
> somewhere. Since journal is common mechanism to all JFSs and
> cp_transaction has a little fewer opportunity to be launched, this patch
> would like to introduce a timing point at which the
> cp_transaction->t_checkpoint_list is shrunk if CMA page used for
> journalling.
> 
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Hum, I see your problem but this solution feels like a hack. How are dirty
metadata buffers in CMA region different from any other dirty page cache
folio? ... checking migration code ... Oh, right, normal dirty page cache
folio will get migrated while bdev mappings use
buffer_migrate_folio_norefs() so we cannot migrate as long as jh is
attached to the folio. OK, I'd think that providing proper page migration
function that can migrate buffers on checkpoint list would be a cleaner
(and more efficient) way to go. buffer_migrate_folio() is safe for jbd2
buffers that are only part of checkpoint list. The trouble is that we need
to check that the jh is not part of running or committing transaction under
the buffer lock so for that we'd need to hook into __buffer_migrate_folio()
and I'm not yet clear on a way how to cleanly do that...

								Honza

> ---
>  fs/jbd2/checkpoint.c | 27 +++++++++++++++++++++++++++
>  fs/jbd2/journal.c    |  4 ++++
>  include/linux/jbd2.h |  2 ++
>  3 files changed, 33 insertions(+)
> 
> diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
> index 951f78634adf..8c6c1dba1f0f 100644
> --- a/fs/jbd2/checkpoint.c
> +++ b/fs/jbd2/checkpoint.c
> @@ -21,6 +21,7 @@
>  #include <linux/slab.h>
>  #include <linux/blkdev.h>
>  #include <trace/events/jbd2.h>
> +#include <linux/mm.h>
>  
>  /*
>   * Unlink a buffer from a transaction checkpoint list.
> @@ -137,6 +138,32 @@ __flush_batch(journal_t *journal, int *batch_count)
>  	*batch_count = 0;
>  }
>  
> +#ifdef CONFIG_CMA
> +void drain_cma_bh(journal_t *journal)
> +{
> +	struct journal_head	*jh;
> +	struct buffer_head	*bh;
> +
> +	if (!journal->j_checkpoint_transactions)
> +		return;
> +
> +	jh = journal->j_checkpoint_transactions->t_checkpoint_list;
> +	while (jh) {
> +		bh = jh2bh(jh);
> +
> +		if (bh && get_pageblock_migratetype(bh->b_page) == MIGRATE_CMA) {
> +			mutex_lock_io(&journal->j_checkpoint_mutex);
> +			jbd2_log_do_checkpoint(journal);
> +			mutex_unlock(&journal->j_checkpoint_mutex);
> +			return;
> +		}
> +
> +		jh = jh->b_cpnext;
> +	}
> +}
> +#else
> +void drain_cma_bh(journal_t *journal) {}
> +#endif
>  /*
>   * Perform an actual checkpoint. We take the first transaction on the
>   * list of transactions to be checkpointed and send all its buffers
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 1ebf2393bfb7..dd92cb7404fc 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -41,6 +41,7 @@
>  #include <linux/bitops.h>
>  #include <linux/ratelimit.h>
>  #include <linux/sched/mm.h>
> +#include <linux/swap.h>
>  
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/jbd2.h>
> @@ -1273,6 +1274,9 @@ static unsigned long jbd2_journal_shrink_scan(struct shrinker *shrink,
>  	count = percpu_counter_read_positive(&journal->j_checkpoint_jh_count);
>  	trace_jbd2_shrink_scan_enter(journal, sc->nr_to_scan, count);
>  
> +	if (current_is_kswapd())
> +		drain_cma_bh(journal);
> +
>  	nr_shrunk = jbd2_journal_shrink_checkpoint_list(journal, &nr_to_scan);
>  
>  	count = percpu_counter_read_positive(&journal->j_checkpoint_jh_count);
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 5157d92b6f23..fc152382a6ae 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -105,6 +105,8 @@ typedef struct jbd2_journal_handle handle_t;	/* Atomic operation type */
>  typedef struct journal_s	journal_t;	/* Journal control structure */
>  #endif
>  
> +void drain_cma_bh(journal_t *journal);
> +
>  /*
>   * Internal structures used by the logging mechanism:
>   */
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

