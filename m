Return-Path: <linux-fsdevel+bounces-62557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F93B99709
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 12:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C58E64C01A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 10:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADC82DF6FA;
	Wed, 24 Sep 2025 10:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Isp316Z8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="13VtW3Gr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IOkskc5w";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RoiJjJj4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FA12DFA46
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 10:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758710076; cv=none; b=VC+7gQM25Ehxo613dF+Ga/KlFPtCrBaMrdu4RQpJbhLiXCGVGEwus6dlF+PO82DkD6ASxnqbkijXDwzEe2Arz7NY2m8pIpER0NcdSw/PUXrlStbXuRlPa7oxs7mZM1UPmq94rgzc8aMNhUnCnZY1zvfcZLIFa09BbNgkQaRw/eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758710076; c=relaxed/simple;
	bh=uLVCHPjknpmWjLfeVZ+e5cE3LpEa3mXGTHwptkaUAJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sd0NQDhDoGPDDc13YQZUZEkfSbo1M0aMxUFsoShsK3OvaaKyW5ctwP01JgrnDaCbLywaWNsNNpOZwJQBK8rqwE9lnLXInkdSLHh6PsdNBX2DguND+W02H7GQnPyRNfpXvcuACdglJoXW0E+9dfwwcWSWKLTyafpUztm1eoDYXho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Isp316Z8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=13VtW3Gr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IOkskc5w; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RoiJjJj4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E4E8F20844;
	Wed, 24 Sep 2025 10:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758710069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TbhRTdTzGiA4WihDRPTKgggdSBCGnBZJFtxuXt7bIyM=;
	b=Isp316Z8kTZO6t+loVD01CxK+I8evJ22PwwrW3+X3wpsCGIrWZ0kK86Cff287h6D5PQAYJ
	anf/Q9t9grxIxL48HjoagAD4vrrD+D5va+2Le0UTkh3HkvgClfCXR98967SlZgT+oKwK5P
	7CyhFE66cRvAmW81hb+2lE4PYA6jVO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758710069;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TbhRTdTzGiA4WihDRPTKgggdSBCGnBZJFtxuXt7bIyM=;
	b=13VtW3GrGWmB/eX+x4mf2V6LjLA3vVPmk6uedvrvd0hfs15AQn+neITYxFjTK6KcoyJzSf
	mhKDApYLuUVW7vDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=IOkskc5w;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RoiJjJj4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758710068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TbhRTdTzGiA4WihDRPTKgggdSBCGnBZJFtxuXt7bIyM=;
	b=IOkskc5wdDPXz+LIk7Nh1QXm7wpswxyLg7iqbB8escjIAiJfXAVDkR2UO27d64aghecIo9
	1tDFQ+Z8jcNBzBxiSaeasM72UeS+2Qh57yB5fMsgSwbgy7CU3u3oA+123dG2HQoMUjkYA/
	RPCms5aIl3uAhWlj9J0Ig9qXg8X858k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758710068;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TbhRTdTzGiA4WihDRPTKgggdSBCGnBZJFtxuXt7bIyM=;
	b=RoiJjJj4tpbRyXhbe3oGjxcLuKeYbyAbKKMt9GGPC3wpUOexRsVCYFqUPC/sTiJxDSV5pp
	0tOXQgkGQMaCEYDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D194E13A61;
	Wed, 24 Sep 2025 10:34:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mTblMjTJ02gmKwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 24 Sep 2025 10:34:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7271AA0A9A; Wed, 24 Sep 2025 12:34:28 +0200 (CEST)
Date: Wed, 24 Sep 2025 12:34:28 +0200
From: Jan Kara <jack@suse.cz>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Hellwig <hch@infradead.org>, Julian Sun <sunjunchao@bytedance.com>, cgroups@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, mingo@redhat.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, lance.yang@linux.dev, 
	mhiramat@kernel.org, agruenba@redhat.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev
Subject: Re: [PATCH 0/3] Suppress undesirable hung task warnings.
Message-ID: <dndr5xdp3bweqtwlyixtzajxgkhxbt2qb2fzg6o2wy5msrhzi4@h3klek5hff5i>
References: <20250922094146.708272-1-sunjunchao@bytedance.com>
 <20250922132718.GB49638@noisy.programming.kicks-ass.net>
 <aNGQoPFTH2_xrd9L@infradead.org>
 <20250922145045.afc6593b4e91c55d8edefabb@linux-foundation.org>
 <20250923071607.GR3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923071607.GR3245006@noisy.programming.kicks-ass.net>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLuhuubkxd663ptcywq6p8zkwd)];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,infradead.org:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: E4E8F20844
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Tue 23-09-25 09:16:07, Peter Zijlstra wrote:
> On Mon, Sep 22, 2025 at 02:50:45PM -0700, Andrew Morton wrote:
> > On Mon, 22 Sep 2025 11:08:32 -0700 Christoph Hellwig <hch@infradead.org> wrote:
> > 
> > > On Mon, Sep 22, 2025 at 03:27:18PM +0200, Peter Zijlstra wrote:
> > > > > Julian Sun (3):
> > > > >   sched: Introduce a new flag PF_DONT_HUNG.
> > > > >   writeback: Introduce wb_wait_for_completion_no_hung().
> > > > >   memcg: Don't trigger hung task when memcg is releasing.
> > > > 
> > > > This is all quite terrible. I'm not at all sure why a task that is
> > > > genuinely not making progress and isn't killable should not be reported.
> > > 
> > > The hung device detector is way to aggressive for very slow I/O.
> > > See blk_wait_io, which has been around for a long time to work
> > > around just that.  Given that this series targets writeback I suspect
> > > it is about an overloaded device as well.
> > 
> > Yup, it's writeback - the bug report is in
> > https://lkml.kernel.org/r/20250917212959.355656-1-sunjunchao@bytedance.com
> > 
> > Memory is big and storage is slow, there's nothing wrong if a task
> > which is designed to wait for writeback waits for a long time.
> > 
> > Of course, there's something wrong if some other task which isn't
> > designed to wait for writeback gets stuck waiting for the task which
> > *is* designed to wait for writeback, but we'll still warn about that.
> > 
> > 
> > Regarding an implementation, I'm wondering if we can put a flag in
> > `struct completion' telling the hung task detector that this one is
> > expected to wait for long periods sometimes.  Probably messy and it
> > only works for completions (not semaphores, mutexes, etc).  Just
> > putting it out there ;)
> 
> So the problem is that there *is* progress (albeit rather slowly), the
> watchdog just doesn't see that. Perhaps that is the thing we should look
> at fixing.
> 
> How about something like the below? That will 'spuriously' wake up the
> waiters as long as there is some progress being made. Thereby increasing
> the context switch counters of the tasks and thus the hung_task watchdog
> sees progress.
> 
> This approach should be safer than the blk_wait_io() hack, which has a
> timer ticking, regardless of actual completions happening or not.

I like the idea. The problem with your patch is that the progress is not
visible with high enough granularity in wb_writeback_work->done completion.
That is only incremented by 1, when say a request to writeout 1GB is queued
and decremented by 1 when that 1GB is written. The progress can be observed
with higher granularity by wb_writeback_work->nr_pages getting decremented
as we submit pages for writeback but this counter still gets updated only
once we are done with a particular inode so if all those 1GB of data are in
one inode there wouldn't be much to observe. So we might need to observe
how struct writeback_control member nr_to_write gets updated. That is
really updated frequently on IO submission but each filesystem updates it
in their writepages() function so implementing that gets messy pretty
quickly.

But maybe a good place to hook into for registering progress would be
wbc_init_bio()? Filesystems call that whenever we create new bio for writeback
purposes. We do have struct writeback_control available there so through
that we could propagate information that forward progress is being made.

What do people think?

								Honza

> ---
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index a07b8cf73ae2..1326193b4d95 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -174,9 +174,10 @@ static void finish_writeback_work(struct wb_writeback_work *work)
>  		kfree(work);
>  	if (done) {
>  		wait_queue_head_t *waitq = done->waitq;
> +		bool force_wake = (jiffies - done->stamp) > HZ/2;
>  
>  		/* @done can't be accessed after the following dec */
> -		if (atomic_dec_and_test(&done->cnt))
> +		if (atomic_dec_and_test(&done->cnt) || force_wake)
>  			wake_up_all(waitq);
>  	}
>  }
> @@ -213,7 +214,7 @@ static void wb_queue_work(struct bdi_writeback *wb,
>  void wb_wait_for_completion(struct wb_completion *done)
>  {
>  	atomic_dec(&done->cnt);		/* put down the initial count */
> -	wait_event(*done->waitq, !atomic_read(&done->cnt));
> +	wait_event(*done->waitq, ({ done->stamp = jiffies; !atomic_read(&done->cnt); }));
>  }
>  
>  #ifdef CONFIG_CGROUP_WRITEBACK
> diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
> index 2ad261082bba..197593193ce3 100644
> --- a/include/linux/backing-dev-defs.h
> +++ b/include/linux/backing-dev-defs.h
> @@ -63,6 +63,7 @@ enum wb_reason {
>  struct wb_completion {
>  	atomic_t		cnt;
>  	wait_queue_head_t	*waitq;
> +	unsigned long		stamp;
>  };
>  
>  #define __WB_COMPLETION_INIT(_waitq)	\
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

