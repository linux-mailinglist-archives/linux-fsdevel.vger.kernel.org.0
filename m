Return-Path: <linux-fsdevel+bounces-43111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 936F8A4E0CD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 15:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 120177A4B24
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 14:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45382080C6;
	Tue,  4 Mar 2025 14:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NsyYfudN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PWxEua8/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NsyYfudN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PWxEua8/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2038F2063FA
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098331; cv=none; b=HxtkzLxwB4uNzOFzGuUFRLkNAe0iEEWb+0f7msDdP6H8qV8SqL3jBjJmuqBllv0I3VWf2IttHbRarQ5Tbycy6phMglDdxaRRhJiBnC6VrviH8QbmId+lQ2fYaaROcHxEJRK8a8IC8bHFXCJEij+5fNevq9Jc9wM6L3dos9gKJdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098331; c=relaxed/simple;
	bh=GHvYhF6mhNS8Xc5SlOXHmfIdiVTGU7d1If0qxTFNczU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7q8QPCI/Ed/si9Six9E8F2UH3GGSHwz6I/iYYJUqzu0N0AIcVSSmU82ae64gyLQxvH5O0aO7cbe5zgBBTnP7q8iSCcYCAWZUpQJyHZggkUU+2ARJ2QHyojDQqSC8jmkmn4p5oJqjTC8DO/X+DQWoWBFOkks2BvjbBfeIB09+UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NsyYfudN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PWxEua8/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NsyYfudN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PWxEua8/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2357A21170;
	Tue,  4 Mar 2025 14:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741098327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=21R63puFBhLrbr9hO90cmJ3hCPSZdL7Adv8+v03JTpA=;
	b=NsyYfudNY9FvF1DL3njfH8UJz/mC7PaFYt4sJHkItzjHknJ/lyBc//bIUhmBTwymukq0SC
	wej+vQVwkTB1AnPXJYsidSrKE1YmqNjSIc0h8/qvuapxRtn6ulH//Lu+c59sUQOePJn4F+
	xhPTrRt2AOOV+lD++9nc9oNZCeUHsyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741098327;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=21R63puFBhLrbr9hO90cmJ3hCPSZdL7Adv8+v03JTpA=;
	b=PWxEua8/DYaf0TaSvOdTf1d0fUsUZls/1sdlh/pe7g8t/wlQL17tO9K9WBtZv+2B07Rp4s
	Q49fLmhD94CZglDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=NsyYfudN;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="PWxEua8/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741098327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=21R63puFBhLrbr9hO90cmJ3hCPSZdL7Adv8+v03JTpA=;
	b=NsyYfudNY9FvF1DL3njfH8UJz/mC7PaFYt4sJHkItzjHknJ/lyBc//bIUhmBTwymukq0SC
	wej+vQVwkTB1AnPXJYsidSrKE1YmqNjSIc0h8/qvuapxRtn6ulH//Lu+c59sUQOePJn4F+
	xhPTrRt2AOOV+lD++9nc9oNZCeUHsyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741098327;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=21R63puFBhLrbr9hO90cmJ3hCPSZdL7Adv8+v03JTpA=;
	b=PWxEua8/DYaf0TaSvOdTf1d0fUsUZls/1sdlh/pe7g8t/wlQL17tO9K9WBtZv+2B07Rp4s
	Q49fLmhD94CZglDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 17F521393C;
	Tue,  4 Mar 2025 14:25:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3evSBVcNx2ejMAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 04 Mar 2025 14:25:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CD815A0912; Tue,  4 Mar 2025 15:25:26 +0100 (CET)
Date: Tue, 4 Mar 2025 15:25:26 +0100
From: Jan Kara <jack@suse.cz>
To: Tang Yizhou <yizhou.tang@shopee.com>
Cc: tj@kernel.org, jack@suse.cz, brauner@kernel.org, willy@infradead.org, 
	akpm@linux-foundation.org, rostedt@goodmis.org, mhiramat@kernel.org, ast@kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 1/2] writeback: Let trace_balance_dirty_pages()
 take struct dtc as parameter
Message-ID: <tko35tkqszdwi5ibkzjnt5cxyuoppkfymnrotaqte2lbo5of26@4vo44czqtirp>
References: <20250303100617.223677-1-yizhou.tang@shopee.com>
 <20250303100617.223677-2-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303100617.223677-2-yizhou.tang@shopee.com>
X-Rspamd-Queue-Id: 2357A21170
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 03-03-25 18:06:16, Tang Yizhou wrote:
> From: Tang Yizhou <yizhou.tang@shopee.com>
> 
> Currently, trace_balance_dirty_pages() already has 12 parameters. In the
> next patch, I initially attempted to introduce an additional parameter.
> However, in include/linux/trace_events.h, bpf_trace_run12() only supports
> up to 12 parameters and bpf_trace_run13() does not exist.
> 
> To reduce the number of parameters in trace_balance_dirty_pages(), we can
> make it accept a pointer to struct dirty_throttle_control as a parameter.
> To achieve this, we need to move the definition of struct
> dirty_throttle_control from mm/page-writeback.c to
> include/linux/writeback.h.
> 
> By the way, rename bdi_setpoint and bdi_dirty in the tracepoint to
> wb_setpoint and wb_dirty, respectively. These changes were omitted by
> Tejun in the cgroup writeback patchset.
> 
> Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/writeback.h        | 23 +++++++++++++++++++++
>  include/trace/events/writeback.h | 28 +++++++++++--------------
>  mm/page-writeback.c              | 35 ++------------------------------
>  3 files changed, 37 insertions(+), 49 deletions(-)
> 
> diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> index d11b903c2edb..32095928365c 100644
> --- a/include/linux/writeback.h
> +++ b/include/linux/writeback.h
> @@ -313,6 +313,29 @@ static inline void cgroup_writeback_umount(struct super_block *sb)
>  /*
>   * mm/page-writeback.c
>   */
> +/* consolidated parameters for balance_dirty_pages() and its subroutines */
> +struct dirty_throttle_control {
> +#ifdef CONFIG_CGROUP_WRITEBACK
> +	struct wb_domain	*dom;
> +	struct dirty_throttle_control *gdtc;	/* only set in memcg dtc's */
> +#endif
> +	struct bdi_writeback	*wb;
> +	struct fprop_local_percpu *wb_completions;
> +
> +	unsigned long		avail;		/* dirtyable */
> +	unsigned long		dirty;		/* file_dirty + write + nfs */
> +	unsigned long		thresh;		/* dirty threshold */
> +	unsigned long		bg_thresh;	/* dirty background threshold */
> +
> +	unsigned long		wb_dirty;	/* per-wb counterparts */
> +	unsigned long		wb_thresh;
> +	unsigned long		wb_bg_thresh;
> +
> +	unsigned long		pos_ratio;
> +	bool			freerun;
> +	bool			dirty_exceeded;
> +};
> +
>  void laptop_io_completion(struct backing_dev_info *info);
>  void laptop_sync_completion(void);
>  void laptop_mode_timer_fn(struct timer_list *t);
> diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
> index a261e86e61fa..3046ca6b08ea 100644
> --- a/include/trace/events/writeback.h
> +++ b/include/trace/events/writeback.h
> @@ -629,11 +629,7 @@ TRACE_EVENT(bdi_dirty_ratelimit,
>  TRACE_EVENT(balance_dirty_pages,
>  
>  	TP_PROTO(struct bdi_writeback *wb,
> -		 unsigned long thresh,
> -		 unsigned long bg_thresh,
> -		 unsigned long dirty,
> -		 unsigned long bdi_thresh,
> -		 unsigned long bdi_dirty,
> +		 struct dirty_throttle_control *dtc,
>  		 unsigned long dirty_ratelimit,
>  		 unsigned long task_ratelimit,
>  		 unsigned long dirtied,
> @@ -641,7 +637,7 @@ TRACE_EVENT(balance_dirty_pages,
>  		 long pause,
>  		 unsigned long start_time),
>  
> -	TP_ARGS(wb, thresh, bg_thresh, dirty, bdi_thresh, bdi_dirty,
> +	TP_ARGS(wb, dtc,
>  		dirty_ratelimit, task_ratelimit,
>  		dirtied, period, pause, start_time),
>  
> @@ -650,8 +646,8 @@ TRACE_EVENT(balance_dirty_pages,
>  		__field(unsigned long,	limit)
>  		__field(unsigned long,	setpoint)
>  		__field(unsigned long,	dirty)
> -		__field(unsigned long,	bdi_setpoint)
> -		__field(unsigned long,	bdi_dirty)
> +		__field(unsigned long,	wb_setpoint)
> +		__field(unsigned long,	wb_dirty)
>  		__field(unsigned long,	dirty_ratelimit)
>  		__field(unsigned long,	task_ratelimit)
>  		__field(unsigned int,	dirtied)
> @@ -664,16 +660,16 @@ TRACE_EVENT(balance_dirty_pages,
>  	),
>  
>  	TP_fast_assign(
> -		unsigned long freerun = (thresh + bg_thresh) / 2;
> +		unsigned long freerun = (dtc->thresh + dtc->bg_thresh) / 2;
>  		strscpy_pad(__entry->bdi, bdi_dev_name(wb->bdi), 32);
>  
>  		__entry->limit		= global_wb_domain.dirty_limit;
>  		__entry->setpoint	= (global_wb_domain.dirty_limit +
>  						freerun) / 2;
> -		__entry->dirty		= dirty;
> -		__entry->bdi_setpoint	= __entry->setpoint *
> -						bdi_thresh / (thresh + 1);
> -		__entry->bdi_dirty	= bdi_dirty;
> +		__entry->dirty		= dtc->dirty;
> +		__entry->wb_setpoint	= __entry->setpoint *
> +						dtc->wb_thresh / (dtc->thresh + 1);
> +		__entry->wb_dirty	= dtc->wb_dirty;
>  		__entry->dirty_ratelimit = KBps(dirty_ratelimit);
>  		__entry->task_ratelimit	= KBps(task_ratelimit);
>  		__entry->dirtied	= dirtied;
> @@ -689,7 +685,7 @@ TRACE_EVENT(balance_dirty_pages,
>  
>  	TP_printk("bdi %s: "
>  		  "limit=%lu setpoint=%lu dirty=%lu "
> -		  "bdi_setpoint=%lu bdi_dirty=%lu "
> +		  "wb_setpoint=%lu wb_dirty=%lu "
>  		  "dirty_ratelimit=%lu task_ratelimit=%lu "
>  		  "dirtied=%u dirtied_pause=%u "
>  		  "paused=%lu pause=%ld period=%lu think=%ld cgroup_ino=%lu",
> @@ -697,8 +693,8 @@ TRACE_EVENT(balance_dirty_pages,
>  		  __entry->limit,
>  		  __entry->setpoint,
>  		  __entry->dirty,
> -		  __entry->bdi_setpoint,
> -		  __entry->bdi_dirty,
> +		  __entry->wb_setpoint,
> +		  __entry->wb_dirty,
>  		  __entry->dirty_ratelimit,
>  		  __entry->task_ratelimit,
>  		  __entry->dirtied,
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index eb55ece39c56..e980b2aec352 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -120,29 +120,6 @@ EXPORT_SYMBOL(laptop_mode);
>  
>  struct wb_domain global_wb_domain;
>  
> -/* consolidated parameters for balance_dirty_pages() and its subroutines */
> -struct dirty_throttle_control {
> -#ifdef CONFIG_CGROUP_WRITEBACK
> -	struct wb_domain	*dom;
> -	struct dirty_throttle_control *gdtc;	/* only set in memcg dtc's */
> -#endif
> -	struct bdi_writeback	*wb;
> -	struct fprop_local_percpu *wb_completions;
> -
> -	unsigned long		avail;		/* dirtyable */
> -	unsigned long		dirty;		/* file_dirty + write + nfs */
> -	unsigned long		thresh;		/* dirty threshold */
> -	unsigned long		bg_thresh;	/* dirty background threshold */
> -
> -	unsigned long		wb_dirty;	/* per-wb counterparts */
> -	unsigned long		wb_thresh;
> -	unsigned long		wb_bg_thresh;
> -
> -	unsigned long		pos_ratio;
> -	bool			freerun;
> -	bool			dirty_exceeded;
> -};
> -
>  /*
>   * Length of period for aging writeout fractions of bdis. This is an
>   * arbitrarily chosen number. The longer the period, the slower fractions will
> @@ -1962,11 +1939,7 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
>  		 */
>  		if (pause < min_pause) {
>  			trace_balance_dirty_pages(wb,
> -						  sdtc->thresh,
> -						  sdtc->bg_thresh,
> -						  sdtc->dirty,
> -						  sdtc->wb_thresh,
> -						  sdtc->wb_dirty,
> +						  sdtc,
>  						  dirty_ratelimit,
>  						  task_ratelimit,
>  						  pages_dirtied,
> @@ -1991,11 +1964,7 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
>  
>  pause:
>  		trace_balance_dirty_pages(wb,
> -					  sdtc->thresh,
> -					  sdtc->bg_thresh,
> -					  sdtc->dirty,
> -					  sdtc->wb_thresh,
> -					  sdtc->wb_dirty,
> +					  sdtc,
>  					  dirty_ratelimit,
>  					  task_ratelimit,
>  					  pages_dirtied,
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

