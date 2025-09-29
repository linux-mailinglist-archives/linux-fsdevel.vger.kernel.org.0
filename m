Return-Path: <linux-fsdevel+bounces-63036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 062FBBA9C82
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 17:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A644816F663
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 15:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76502FE044;
	Mon, 29 Sep 2025 15:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BV72zwdi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AM+TGOKK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="B66k1ACt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="n5hcf4ww"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8922C2F068C
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 15:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759159269; cv=none; b=YgqMgX1nSjxq7PEl7HsIFuDxW8Lf3s1wKoDFY9zcazyAJ/wx/tuzWNoki0j9TgxNMC8DTb5MuYlH4+JB4KgpA943FZYVax9K34ijT7q4qDvr8/e1kyUEHO4XN5QoGxXLZIK/4R3AFmIO4kA2Zg4UJ+b8iOikjzrVnofTF388c2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759159269; c=relaxed/simple;
	bh=P5lCD/i4triwAj7G9NXdbQz0j34MeienIMlFSSa57hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uiCxhgvfQo/aOdQ3Rb7hZ/5fdS3eBgwaCEwDCxVOc9t98hoCJq5IJcSOIVnFT65bV7QyGtD0wYWc1X/RoJbWZ4SPLt4smhuwPgra3fUjDq5Uj8XqYHYo6nsQH4RlGPSsgWBYP9qRNUAsytk3kXXX2Wg4UY4pmCjL43wswZlTCGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BV72zwdi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AM+TGOKK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=B66k1ACt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=n5hcf4ww; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CF74C3079E;
	Mon, 29 Sep 2025 15:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759159264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hX4a/QaXdnBMrooqLs/pC+YOO/DCfIizLJPKMaec8vY=;
	b=BV72zwdi5toRVJnMFuG9Yh78qsvn32TWqbXI6H75Lo9mhNixQtg8KhTgGWmcCS2jCtEta3
	zF9DRMsjf3bIAsb6Ie3lTdYftGQRDLDlN64qoZUlrixBjNodwBRsvPRd2Uy47VdT0/+nap
	9ng0r2tmgOW0CflYfxx06FEVDYdfZGI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759159264;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hX4a/QaXdnBMrooqLs/pC+YOO/DCfIizLJPKMaec8vY=;
	b=AM+TGOKKCGlmh61c2750/cRjI5kygKa9a7PkVIt/NqVAMI/fyYVSBAcKc34J7EuLZ/JMBj
	XwROoFbkH3cPayAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759159263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hX4a/QaXdnBMrooqLs/pC+YOO/DCfIizLJPKMaec8vY=;
	b=B66k1ACtCPpr9fYA4s1U4peZUEyh3q75dJSRic4ukmJukhwbZP1p8jSAfH6KpPNwJg3DIk
	ePUPhcxfM4RQ4TCnShzFck0WzR4jTARTkK/55yj6VrLh7tSg37FkjfJk9yA2FeM+QzXn1o
	TvctbcFBu6HakGcfFEZpJdopyJWfZf8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759159263;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hX4a/QaXdnBMrooqLs/pC+YOO/DCfIizLJPKMaec8vY=;
	b=n5hcf4wwj60iedbYmFMJ0RPPW9D6jC5WK5Ws4WMTyOoL32Dd77DWH54T0bzlgnLz8GP/Rv
	YZLQRp6CmrbzwtBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B82CB13782;
	Mon, 29 Sep 2025 15:21:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AKjvLN+j2mh1QgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 29 Sep 2025 15:21:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2931BA2B46; Mon, 29 Sep 2025 17:21:03 +0200 (CEST)
Date: Mon, 29 Sep 2025 17:21:03 +0200
From: Jan Kara <jack@suse.cz>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, mjguzik@gmail.com
Subject: Re: [PATCH v2 1/2] writeback: Wake up waiting tasks when finishing
 the writeback of a chunk.
Message-ID: <q4flookdnrppc3xtc4vcme6k77toqrv2qgagw65d5vrg43gvgw@6lkewzmdxjyo>
References: <20250929122850.586278-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929122850.586278-1-sunjunchao@bytedance.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,zeniv.linux.org.uk,kernel.org,suse.cz,gmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Mon 29-09-25 20:28:49, Julian Sun wrote:
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
>  Changes in v2:
>   * remove code in finish_writeback_work()
>   * rename stamp to progress_stamp
>   * only report progress if there's any task waiting
> 
>  fs/fs-writeback.c                | 11 ++++++++++-
>  include/linux/backing-dev-defs.h |  1 +
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index a07b8cf73ae2..61785a9d6669 100644
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
> @@ -1893,6 +1895,7 @@ static long writeback_sb_inodes(struct super_block *sb,
>  	long write_chunk;
>  	long total_wrote = 0;  /* count both pages and inodes */
>  	unsigned long dirtied_before = jiffies;
> +	unsigned long progress_stamp;
>  
>  	if (work->for_kupdate)
>  		dirtied_before = jiffies -
> @@ -1975,6 +1978,12 @@ static long writeback_sb_inodes(struct super_block *sb,
>  		 */
>  		__writeback_single_inode(inode, &wbc);
>  
> +		/* Report progress to inform the hung task detector of the progress. */
> +		progress_stamp = work->done->progress_stamp;
> +		if (work->done && progress_stamp && (jiffies - progress_stamp) >
> +		    HZ * sysctl_hung_task_timeout_secs / 2)
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

