Return-Path: <linux-fsdevel+bounces-56191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E83B143F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 23:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E42455420A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 21:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752DE192D8A;
	Mon, 28 Jul 2025 21:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XbtR4Oum";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zy1Nm/o8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xy/Y2BC7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QWcMK3FP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B9A4A11
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 21:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753738877; cv=none; b=O7nkJ44uFSh+jCM+9EDRcF6X8LItJKYS4LvzaUHrU8nBTOO494ZwEEkZZ5lNfscVD+beIaxaEBRKqTalc2pg21g9XsP1vLAsVlPOxtMWTeE4oy46MIoUdviqjhOGSvqTcV53Jcd/LHJClcFZDuvyVxJL+M3x/n7m6DyOG2GXyF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753738877; c=relaxed/simple;
	bh=NIIY6VCbzybM0Ga1w/myWtJNAZm/f0a2U3/kFelhNtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RuPNqQt40kNfDZCgjKO0IlP01S6WZbljMTueMz5EHMZYhhnwK5Sb+Q4qCY6pXCzJGnBY2ad2pdc6aFbTnu1bd9P4Qr8zWHLXiNGePNchCAjf/zS2AdAlvF38EQrYjWBlx+eAmG1/rOPUE4IytTes9G52khBLvidTFRee4RqbVRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XbtR4Oum; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zy1Nm/o8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xy/Y2BC7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QWcMK3FP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DD0F31F44E;
	Mon, 28 Jul 2025 21:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753738874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q9O56YyqeVaJQCz/ISaqSwOUxMc7uJmdn3oyjBRRc2o=;
	b=XbtR4OumB61xt+vHk9Ik/QJ6Ri48LZc8Iczfw+Cq6Bwv4X0KjS4pIir03HW9OoOpGhrNxx
	ehktAqhhzVuRO4Cl6Krz6rRrtFbSM+d4kEPX3MYQjgZyO1zwfifKqQQjqlnP/mB5CEDEKo
	uy//PVBuw5BVUZED9wTS9gt41BdVJSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753738874;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q9O56YyqeVaJQCz/ISaqSwOUxMc7uJmdn3oyjBRRc2o=;
	b=zy1Nm/o8pNhTrmKvbDE2LG3d6ONLIYpXesUBTN3+kNhz+ejzSsCZQGQLKJkU1688rpWjyh
	veTH0bMVOg+VNEAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="xy/Y2BC7";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=QWcMK3FP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753738873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q9O56YyqeVaJQCz/ISaqSwOUxMc7uJmdn3oyjBRRc2o=;
	b=xy/Y2BC7ik8U92NZ4B+fijUmxNBjHaOe+xjGD6/YRDcPq8sbA0mfSQ7d9jLCqFIS3p4/XL
	Aus9f00zUE8q7OVBsjZVaw8flfttlmSWwzRA/hkZYv4T723R83VSw9yGgpGKLGTOIEtTXt
	MeIXYR98aWuh/LTSIpstdbo1Vwcv9PM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753738873;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q9O56YyqeVaJQCz/ISaqSwOUxMc7uJmdn3oyjBRRc2o=;
	b=QWcMK3FPoqVlU8FgvB33KRdB66oZOpmVHB5xMCfW9AOVQkdgMGhaGWNcrP7JVJgi/OrTG2
	w6BsWTb0hxf6yKBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CEDDF1368A;
	Mon, 28 Jul 2025 21:41:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id afM5Mnnuh2ihDgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 28 Jul 2025 21:41:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 526DCA09E7; Mon, 28 Jul 2025 23:41:09 +0200 (CEST)
Date: Mon, 28 Jul 2025 23:41:09 +0200
From: Jan Kara <jack@suse.cz>
To: Dai Junbing <daijunbing@vivo.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>, 
	Theodore Ts'o <tytso@mit.edu>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-ext4@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v1] fs: Prevent spurious wakeups with TASK_FREEZABLE
Message-ID: <vgi3yig4zi3t54pfqdbsspge4wa3n5mucx5antazw7at36c4ja@wi7gtgu7itsu>
References: <20250725030341.520-1-daijunbing@vivo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725030341.520-1-daijunbing@vivo.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: DD0F31F44E
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01

On Fri 25-07-25 11:03:39, Dai Junbing wrote:
> From: junbing dai <daijunbing@vivo.com>
> 
> During system suspend, processes in TASK_INTERRUPTIBLE state get
> forcibly awakened. By applying TASK_FREEZABLE flag, we prevent these
> unnecessary wakeups and reduce suspend/resume overhead
> 
> Signed-off-by: junbing dai <daijunbing@vivo.com>

Thanks for the patch but I have two: This is actually less obvious than you
make it sound because if we are holding other locks when going to
interruptible sleep then the behavior of TASK_FREEZABLE vs
TASK_INTERRUPTIBLE is different (you'd suspend the task while holding those
locks). So at each place you need to make sure no other locks are held -
this belongs to the changelog.

And because these changes are not obvious, it is good to separate them per
site or perhaps per subsystem so that changelogs can be appropriate and
also so that maintainers can review them properly.

								Honza

> ---
>  fs/eventpoll.c    | 2 +-
>  fs/fuse/dev.c     | 2 +-
>  fs/jbd2/journal.c | 2 +-
>  fs/pipe.c         | 4 ++--
>  fs/select.c       | 4 ++--
>  5 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 0fbf5dfedb24..6020575bdbab 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -2094,7 +2094,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
>  		 * the same lock on wakeup ep_poll_callback() side, so it
>  		 * is safe to avoid an explicit barrier.
>  		 */
> -		__set_current_state(TASK_INTERRUPTIBLE);
> +		__set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE);
>  
>  		/*
>  		 * Do the final check under the lock. ep_start/done_scan()
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index e80cd8f2c049..b3dbd113e2e2 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1418,7 +1418,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
>  
>  		if (file->f_flags & O_NONBLOCK)
>  			return -EAGAIN;
> -		err = wait_event_interruptible_exclusive(fiq->waitq,
> +		err = wait_event_freezable_exclusive(fiq->waitq,
>  				!fiq->connected || request_pending(fiq));
>  		if (err)
>  			return err;
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index d480b94117cd..a6ca1468ccfe 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -222,7 +222,7 @@ static int kjournald2(void *arg)
>  		DEFINE_WAIT(wait);
>  
>  		prepare_to_wait(&journal->j_wait_commit, &wait,
> -				TASK_INTERRUPTIBLE);
> +				TASK_INTERRUPTIBLE|TASK_FREEZABLE);
>  		transaction = journal->j_running_transaction;
>  		if (transaction == NULL ||
>  		    time_before(jiffies, transaction->t_expires)) {
> diff --git a/fs/pipe.c b/fs/pipe.c
> index 45077c37bad1..a0e624fc734c 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -385,7 +385,7 @@ anon_pipe_read(struct kiocb *iocb, struct iov_iter *to)
>  		 * since we've done any required wakeups and there's no need
>  		 * to mark anything accessed. And we've dropped the lock.
>  		 */
> -		if (wait_event_interruptible_exclusive(pipe->rd_wait, pipe_readable(pipe)) < 0)
> +		if (wait_event_freezable_exclusive(pipe->rd_wait, pipe_readable(pipe)) < 0)
>  			return -ERESTARTSYS;
>  
>  		wake_next_reader = true;
> @@ -1098,7 +1098,7 @@ static int wait_for_partner(struct pipe_inode_info *pipe, unsigned int *cnt)
>  	int cur = *cnt;
>  
>  	while (cur == *cnt) {
> -		prepare_to_wait(&pipe->rd_wait, &rdwait, TASK_INTERRUPTIBLE);
> +		prepare_to_wait(&pipe->rd_wait, &rdwait, TASK_INTERRUPTIBLE|TASK_FREEZABLE);
>  		pipe_unlock(pipe);
>  		schedule();
>  		finish_wait(&pipe->rd_wait, &rdwait);
> diff --git a/fs/select.c b/fs/select.c
> index 9fb650d03d52..0903a08b8067 100644
> --- a/fs/select.c
> +++ b/fs/select.c
> @@ -600,7 +600,7 @@ static noinline_for_stack int do_select(int n, fd_set_bits *fds, struct timespec
>  			to = &expire;
>  		}
>  
> -		if (!poll_schedule_timeout(&table, TASK_INTERRUPTIBLE,
> +		if (!poll_schedule_timeout(&table, TASK_INTERRUPTIBLE|TASK_FREEZABLE,
>  					   to, slack))
>  			timed_out = 1;
>  	}
> @@ -955,7 +955,7 @@ static int do_poll(struct poll_list *list, struct poll_wqueues *wait,
>  			to = &expire;
>  		}
>  
> -		if (!poll_schedule_timeout(wait, TASK_INTERRUPTIBLE, to, slack))
> +		if (!poll_schedule_timeout(wait, TASK_INTERRUPTIBLE|TASK_FREEZABLE, to, slack))
>  			timed_out = 1;
>  	}
>  	return count;
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

