Return-Path: <linux-fsdevel+bounces-63105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C6FBAC262
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 10:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0E4C16BBCB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 08:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3004C2F3C3A;
	Tue, 30 Sep 2025 08:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jv94TX/2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dACoQ9eC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jv94TX/2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dACoQ9eC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13DC2BD034
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 08:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759222785; cv=none; b=oEcejmIwANrx4ZvqmBkP83HQknwUgQCwf1BmypoDhRbtDQwklhRLGI8vaqKnXDr7JGOFzCaNkoNn+sWXTXC+ujPSfAWMuunFKWofERpvHHkYwDfNR1Dzmo9vyBUhjeSKIBKm3a632nmQXxwyryRFyXTzcptIV5ypG2rLDHk8ug0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759222785; c=relaxed/simple;
	bh=Krx2gB9DW4EFhcWe35aenDw48Mjx+VQGROEgPqwpmqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBaXcEYmKWQPCCA80XmCfIQBCdZcASx2P+4Aym6/JthcTUp9IcQQbH/Db2hR0K6GjFtBOLN5XE0H706pg3eXdK20LOa2dfesYrosherJP1PyB2htDY6fzylasSoMgVG7+HnUzUgIrzEMMlPqGmgfA9ybbDOwSUI70TGwY/lcklk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jv94TX/2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dACoQ9eC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jv94TX/2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dACoQ9eC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0DA3C33718;
	Tue, 30 Sep 2025 08:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759222781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YAlASGSsrW4YNDKN0K0Ldqhng3BcUvS6Iqba5cCODyY=;
	b=Jv94TX/29a3DR7AGStvypHa2E/G9sshCjUWUdQWFjirjH+/3fGi62xGePNVMtekS/K71Hs
	x8+NJEdIa5nNzWSCRhXAd345JsYDNsgXxa9Q+UKM8WfmgGUlwns8osV0rBuv5Lr8gizL1j
	GtPnZZWp6wXB/m3xQ/6Eo1xe6R5h3bI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759222781;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YAlASGSsrW4YNDKN0K0Ldqhng3BcUvS6Iqba5cCODyY=;
	b=dACoQ9eCmyIl/Ll0zf27XVo7gL1euJZ7UsiDbLZkrLHiolofdLEaGPAeGaAufakmceIcwu
	QhdKxGF88OM7iCAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="Jv94TX/2";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=dACoQ9eC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759222781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YAlASGSsrW4YNDKN0K0Ldqhng3BcUvS6Iqba5cCODyY=;
	b=Jv94TX/29a3DR7AGStvypHa2E/G9sshCjUWUdQWFjirjH+/3fGi62xGePNVMtekS/K71Hs
	x8+NJEdIa5nNzWSCRhXAd345JsYDNsgXxa9Q+UKM8WfmgGUlwns8osV0rBuv5Lr8gizL1j
	GtPnZZWp6wXB/m3xQ/6Eo1xe6R5h3bI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759222781;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YAlASGSsrW4YNDKN0K0Ldqhng3BcUvS6Iqba5cCODyY=;
	b=dACoQ9eCmyIl/Ll0zf27XVo7gL1euJZ7UsiDbLZkrLHiolofdLEaGPAeGaAufakmceIcwu
	QhdKxGF88OM7iCAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 04AB713A3F;
	Tue, 30 Sep 2025 08:59:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LFQaAf2b22gcbQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 30 Sep 2025 08:59:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B6D8AA2BF0; Tue, 30 Sep 2025 10:59:40 +0200 (CEST)
Date: Tue, 30 Sep 2025 10:59:40 +0200
From: Jan Kara <jack@suse.cz>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v3 1/2] writeback: Wake up waiting tasks when finishing
 the writeback of a chunk.
Message-ID: <lw33zem5n7piki65lvm34kmsj3c2aq7b2op4gu73b4rcxdv6je@n4fni6ambblt>
References: <20250930065637.1876707-1-sunjunchao@bytedance.com>
 <20250930085315.2039852-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930085315.2039852-1-sunjunchao@bytedance.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 0DA3C33718
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
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,bytedance.com:email,suse.com:email]
X-Spam-Score: -4.01

On Tue 30-09-25 16:53:15, Julian Sun wrote:
> Writing back a large number of pages can take a lots of time.
> This issue is exacerbated when the underlying device is slow or
> subject to block layer rate limiting, which in turn triggers
> unexpected hung task warnings.
> 
> We can trigger a wake-up once a chunk has been written back and the
> waiting time for writeback exceeds half of
> sysctl_hung_task_timeout_secs.
> This action allows the hung task detector to be aware of the writeback
> progress, thereby eliminating these unexpected hung task warnings.
> 
> This patch has passed the xfstests 'check -g quick' test based on ext4,
> with no additional failures introduced.
> 
> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  Hi, the previous patch sent unupdated code due to an mistake; 
>  this version is the genuine v3.
> 
>  Changes in v3:
>   * Fix null-ptr-deref issue.
> 
>  Changes in v2:
>   * remove code in finish_writeback_work()
>   * rename stamp to progress_stamp
>   * only report progress if there's any task waiting
> 
> 
>  fs/fs-writeback.c                | 10 +++++++++-
>  include/linux/backing-dev-defs.h |  1 +
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index a07b8cf73ae2..40954040fd69 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -14,6 +14,7 @@
>   *		Additions for address_space-based writeback
>   */
>  
> +#include <linux/sched/sysctl.h>
>  #include <linux/kernel.h>
>  #include <linux/export.h>
>  #include <linux/spinlock.h>
> @@ -213,7 +214,8 @@ static void wb_queue_work(struct bdi_writeback *wb,
>  void wb_wait_for_completion(struct wb_completion *done)
>  {
>  	atomic_dec(&done->cnt);		/* put down the initial count */
> -	wait_event(*done->waitq, !atomic_read(&done->cnt));
> +	wait_event(*done->waitq,
> +		   ({ done->progress_stamp = jiffies; !atomic_read(&done->cnt); }));
>  }
>  
>  #ifdef CONFIG_CGROUP_WRITEBACK
> @@ -1975,6 +1977,12 @@ static long writeback_sb_inodes(struct super_block *sb,
>  		 */
>  		__writeback_single_inode(inode, &wbc);
>  
> +		/* Report progress to inform the hung task detector of the progress. */
> +		if (work->done && work->done->progress_stamp &&
> +		   (jiffies - work->done->progress_stamp) > HZ *
> +		   sysctl_hung_task_timeout_secs / 2)
> +			wake_up_all(work->done->waitq);
> +
>  		wbc_detach_inode(&wbc);
>  		work->nr_pages -= write_chunk - wbc.nr_to_write;
>  		wrote = write_chunk - wbc.nr_to_write - wbc.pages_skipped;
> diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
> index 2ad261082bba..1057060bb2aa 100644
> --- a/include/linux/backing-dev-defs.h
> +++ b/include/linux/backing-dev-defs.h
> @@ -63,6 +63,7 @@ enum wb_reason {
>  struct wb_completion {
>  	atomic_t		cnt;
>  	wait_queue_head_t	*waitq;
> +	unsigned long progress_stamp;	/* The jiffies when slow progress is detected */
>  };
>  
>  #define __WB_COMPLETION_INIT(_waitq)	\
> -- 
> 2.39.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

