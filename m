Return-Path: <linux-fsdevel+bounces-62781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CD5BA09DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 18:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCED362154E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 16:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBD02DE719;
	Thu, 25 Sep 2025 16:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ibtasaTh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="J+eJ54HW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ibtasaTh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="J+eJ54HW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298951C75E2
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 16:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758817875; cv=none; b=FxpKUbcogF7YhYZc9cKmiCeSOyw5s9kcb+QTcq9mOFs+8l3YC2tWeJ7Sg7RNN7n5TCz83n7LSgV2BBZUJz/f2e47IUbbGB8cosxLG3f78LgbZlbKJKRIUdt7pAe3RxdGroRaERHd7bcrxFk5/Zfi2iGCuvaXyDCZNUuBoPirVbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758817875; c=relaxed/simple;
	bh=B9iCVWKvXs73KOEt/EV2bMExKQtSr5m0q6ocezExms4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LrT0WI7QesgGqTSneHlF3HV13/0crm2NClWwI35QArUlsu0diVokuDddm4g4DET9M36EkMNqr5aYBFJ80G4/BaTB7lygVRhdLyk5yKfASamMivXDHcpkO+M7r4geMOp7EfTgzmsyP8eW0KADIEVVb2TMLsOL6sLuJ0tKa3rwDrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ibtasaTh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=J+eJ54HW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ibtasaTh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=J+eJ54HW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7932C16D1A;
	Thu, 25 Sep 2025 16:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758817872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=it0j9KCXBZhl4Hhd95jETo3midFSNO8BKgMtPKO+6F4=;
	b=ibtasaThLOq/k4BRnlzz5Z5Dv3LbENMenol/3nJ5Bg8devuGAev0iBiYIhP6K9l8yGsxYh
	/iu7wpo9mJs36EEoX7wz0JrnTE/W5l7WV/Du7grPYRXHDo4LxcSxwFMazy8CHPBa1G/Gkx
	7V7B93AMmOM5F1DYY1vkXbyMVmp0+BA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758817872;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=it0j9KCXBZhl4Hhd95jETo3midFSNO8BKgMtPKO+6F4=;
	b=J+eJ54HW543gRz34smscic2Ob0b0MjWks2J3T84ePAX/bCIT4mP8zxHyKcglxWnV9/UxXl
	rg40hEquGHb4nFDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758817872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=it0j9KCXBZhl4Hhd95jETo3midFSNO8BKgMtPKO+6F4=;
	b=ibtasaThLOq/k4BRnlzz5Z5Dv3LbENMenol/3nJ5Bg8devuGAev0iBiYIhP6K9l8yGsxYh
	/iu7wpo9mJs36EEoX7wz0JrnTE/W5l7WV/Du7grPYRXHDo4LxcSxwFMazy8CHPBa1G/Gkx
	7V7B93AMmOM5F1DYY1vkXbyMVmp0+BA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758817872;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=it0j9KCXBZhl4Hhd95jETo3midFSNO8BKgMtPKO+6F4=;
	b=J+eJ54HW543gRz34smscic2Ob0b0MjWks2J3T84ePAX/bCIT4mP8zxHyKcglxWnV9/UxXl
	rg40hEquGHb4nFDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6CCCA132C9;
	Thu, 25 Sep 2025 16:31:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RZ+MGlBu1Wi4ZwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 25 Sep 2025 16:31:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 32093A0AA5; Thu, 25 Sep 2025 18:31:12 +0200 (CEST)
Date: Thu, 25 Sep 2025 18:31:12 +0200
From: Jan Kara <jack@suse.cz>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, peterz@infradead.org
Subject: Re: [PATCH] write-back: Wake up waiting tasks when finishing the
 writeback of a chunk.
Message-ID: <dti6ef2u4gsr2cix43fsbcdminqbt3ymmq27m7ztikyevcoafn@dwsybu3ad6wm>
References: <20250925132239.2145036-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925132239.2145036-1-sunjunchao@bytedance.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Thu 25-09-25 21:22:39, Julian Sun wrote:
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
>  fs/fs-writeback.c                | 13 +++++++++++--
>  include/linux/backing-dev-defs.h |  1 +
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index a07b8cf73ae2..475d52abfb3e 100644
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
> @@ -174,9 +175,12 @@ static void finish_writeback_work(struct wb_writeback_work *work)
>  		kfree(work);
>  	if (done) {
>  		wait_queue_head_t *waitq = done->waitq;
> +		/* Report progress to inform the hung task detector of the progress. */
> +		bool force_wake = (jiffies - done->stamp) >
> +				   sysctl_hung_task_timeout_secs * HZ / 2;
>  
>  		/* @done can't be accessed after the following dec */
> -		if (atomic_dec_and_test(&done->cnt))
> +		if (atomic_dec_and_test(&done->cnt) || force_wake)
>  			wake_up_all(waitq);
>  	}
>  }
> @@ -213,7 +217,7 @@ static void wb_queue_work(struct bdi_writeback *wb,
>  void wb_wait_for_completion(struct wb_completion *done)
>  {
>  	atomic_dec(&done->cnt);		/* put down the initial count */
> -	wait_event(*done->waitq, !atomic_read(&done->cnt));
> +	wait_event(*done->waitq, ({ done->stamp = jiffies; !atomic_read(&done->cnt); }));
>  }
>  
>  #ifdef CONFIG_CGROUP_WRITEBACK
> @@ -1975,6 +1979,11 @@ static long writeback_sb_inodes(struct super_block *sb,
>  		 */
>  		__writeback_single_inode(inode, &wbc);
>  
> +		/* Report progress to inform the hung task detector of the progress. */
> +		if (work->done && (jiffies - work->done->stamp) >
> +		    HZ * sysctl_hung_task_timeout_secs / 2)
> +			wake_up_all(work->done->waitq);
> +
>  		wbc_detach_inode(&wbc);
>  		work->nr_pages -= write_chunk - wbc.nr_to_write;
>  		wrote = write_chunk - wbc.nr_to_write - wbc.pages_skipped;
> diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
> index 2ad261082bba..c37c6bd5ef5c 100644
> --- a/include/linux/backing-dev-defs.h
> +++ b/include/linux/backing-dev-defs.h
> @@ -63,6 +63,7 @@ enum wb_reason {
>  struct wb_completion {
>  	atomic_t		cnt;
>  	wait_queue_head_t	*waitq;
> +	unsigned long stamp;
>  };
>  
>  #define __WB_COMPLETION_INIT(_waitq)	\
> -- 
> 2.39.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

