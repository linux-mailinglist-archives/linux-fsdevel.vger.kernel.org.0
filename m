Return-Path: <linux-fsdevel+bounces-63610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22ABCBC6097
	for <lists+linux-fsdevel@lfdr.de>; Wed, 08 Oct 2025 18:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 015474E8774
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Oct 2025 16:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F4F2BE03B;
	Wed,  8 Oct 2025 16:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mprtzb6O";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="F0ihlidL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FDwob46G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FN7p1RnK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B512BDC27
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Oct 2025 16:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759941338; cv=none; b=iFOAsQKd5RBV7aqLR2Rd47QwEbUtAd723iwoJdwQEZq0EPbM4+mEH3VxZow2+sSYodk9reS1rWx5bpLElLJkE4noYbo8+LI2UACYrvuU1yVZ9dBExdtochrC7fdARTkB8jHn4vlb263WPVHGyCKkljqDB8OxNJBbGRc7WxkJGMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759941338; c=relaxed/simple;
	bh=STlPLILrdbUkehDItZwxZeAIA65ZfO5IjXhUhS+Az7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKwnTECohTfAsqeUQOe3bsNAY0GAtyeqLntYzg4AiHx2pwHAM7RcqD7O6/wwWoQYCSQBJwrfyJr1LTjNbuvTxSnQn38lqa4xZyusp2gdQ6TqGjvfrVgHek0wpiUEznlyeipb4uaHCcxhweKARU4ex7SINcklYSzb6BuVItFvAC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mprtzb6O; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=F0ihlidL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FDwob46G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FN7p1RnK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0C4AA219FD;
	Wed,  8 Oct 2025 16:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759941335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=75UfXoGGzzh/57QEN2GVr6tMjNnzbbUsyDdDu88QK2E=;
	b=mprtzb6OshShNCuPggAsQCbGfUvaS6+9ur54jUrXf/nbyG4AHBiyceGcTe8dAwqsqHFcPf
	pqukcUI5ZqHZOZXrJEXiOS6793Y3dh0zzm8p0kebQrOqosFdqRX1oGJb45ZxhJ9eTnkwWm
	cBLMgpDE1IaRhGgsFyGTfoTnL0Fu0+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759941335;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=75UfXoGGzzh/57QEN2GVr6tMjNnzbbUsyDdDu88QK2E=;
	b=F0ihlidLyoYV9Vt+eIAvfM5rdKGXDpIePTQ3D3rlOTUjjRZf0ZAypBxhhrLl+6Niynf+We
	z4QPdBwU+0crEtAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759941334; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=75UfXoGGzzh/57QEN2GVr6tMjNnzbbUsyDdDu88QK2E=;
	b=FDwob46GKJMj/04vQRA0oyIU5xQa9AtP9CRQnA8EN4Y7R6k22cxTAC6VEyldxEMsLbzXQZ
	5B8zCF43rxtQajuCnnhmrxfje5aLDnjs64spEUDLxvR8WpmHxxRA8+3FVW80v9CuEFacHS
	Cv1zQiq+zj3la1HNvWrj2HAc7Tsxyeg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759941334;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=75UfXoGGzzh/57QEN2GVr6tMjNnzbbUsyDdDu88QK2E=;
	b=FN7p1RnKM4dHWp5mTs2ADyP3cQOvE+nRa1cd3TkzMF/PnEXpb/qfA2VmA9XB81qgU5ElWQ
	yh0WO5ZT2I/Y2dAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E474813A3D;
	Wed,  8 Oct 2025 16:35:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 68+BN9WS5mguEgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 08 Oct 2025 16:35:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 279A2A08E9; Wed,  8 Oct 2025 18:35:29 +0200 (CEST)
Date: Wed, 8 Oct 2025 18:35:29 +0200
From: Jan Kara <jack@suse.cz>
To: Matt Fleming <matt@readmodwrite.com>
Cc: adilger.kernel@dilger.ca, kernel-team@cloudflare.com, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tytso@mit.edu, willy@infradead.org, Baokun Li <libaokun1@huawei.com>, 
	Jan Kara <jack@suse.cz>
Subject: Re: ext4 writeback performance issue in 6.12
Message-ID: <2nuegl4wtmu3lkprcomfeluii77ofrmkn4ukvbx2gesnqlsflk@yx466sbd7bni>
References: <20251006115615.2289526-1-matt@readmodwrite.com>
 <20251008150705.4090434-1-matt@readmodwrite.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008150705.4090434-1-matt@readmodwrite.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	URIBL_BLOCKED(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

Hi Matt!

Nice talking to you again :)

On Wed 08-10-25 16:07:05, Matt Fleming wrote:
> (Adding Baokun and Jan in case they have any ideas)
> On Mon, Oct 06, 2025 at 12:56:15 +0100, Matt Fleming wrote:
> > Hi,
> > 
> > We're seeing writeback take a long time and triggering blocked task
> > warnings on some of our database nodes, e.g.
> > 
> >   INFO: task kworker/34:2:243325 blocked for more than 225 seconds.
> >         Tainted: G           O       6.12.41-cloudflare-2025.8.2 #1
> >   "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >   task:kworker/34:2    state:D stack:0     pid:243325 tgid:243325 ppid:2      task_flags:0x4208060 flags:0x00004000
> >   Workqueue: cgroup_destroy css_free_rwork_fn
> >   Call Trace:
> >    <TASK>
> >    __schedule+0x4fb/0xbf0
> >    schedule+0x27/0xf0
> >    wb_wait_for_completion+0x5d/0x90
> >    ? __pfx_autoremove_wake_function+0x10/0x10
> >    mem_cgroup_css_free+0x19/0xb0
> >    css_free_rwork_fn+0x4e/0x430
> >    process_one_work+0x17e/0x330
> >    worker_thread+0x2ce/0x3f0
> >    ? __pfx_worker_thread+0x10/0x10
> >    kthread+0xd2/0x100
> >    ? __pfx_kthread+0x10/0x10
> >    ret_from_fork+0x34/0x50
> >    ? __pfx_kthread+0x10/0x10
> >    ret_from_fork_asm+0x1a/0x30
> >    </TASK>

So this particular hang check warning will be silenced by [1]. That being
said if the writeback is indeed taking longer than expected (depends on
cgroup configuration etc.) these patches will obviously not fix it. Based
on what you write below, are you saying that most of the time from these
225s is spent in the filesystem allocating blocks? I'd expect we'd spend
most of the time waiting for IO to complete...

[1] https://lore.kernel.org/linux-fsdevel/20250930065637.1876707-1-sunjunchao@bytedance.com/

> > A large chunk of system time (4.43%) is being spent in the following
> > code path:
> > 
> >    ext4_get_group_info+9
> >    ext4_mb_good_group+41
> >    ext4_mb_find_good_group_avg_frag_lists+136
> >    ext4_mb_regular_allocator+2748
> >    ext4_mb_new_blocks+2373
> >    ext4_ext_map_blocks+2149
> >    ext4_map_blocks+294
> >    ext4_do_writepages+2031
> >    ext4_writepages+173
> >    do_writepages+229
> >    __writeback_single_inode+65
> >    writeback_sb_inodes+544
> >    __writeback_inodes_wb+76
> >    wb_writeback+413
> >    wb_workfn+196
> >    process_one_work+382
> >    worker_thread+718
> >    kthread+210
> >    ret_from_fork+52
> >    ret_from_fork_asm+26
> > 
> > That's the path through the CR_GOAL_LEN_FAST allocator.
> > 
> > The primary reason for all these cycles looks to be that we're spending
> > a lot of time in ext4_mb_find_good_group_avg_frag_lists(). The fragment
> > lists seem quite big and the function fails to find a suitable group
> > pretty much every time it's called either because the frag list is empty
> > (orders 10-13) or the average size is < 1280 (order 9). I'm assuming it
> > falls back to a linear scan at that point.
> > 
> >   https://gist.github.com/mfleming/5b16ee4cf598e361faf54f795a98c0a8
> > 
> > $ sudo cat /proc/fs/ext4/md127/mb_structs_summary
> > optimize_scan: 1
> > max_free_order_lists:
> > 	list_order_0_groups: 0
> > 	list_order_1_groups: 1
> > 	list_order_2_groups: 6
> > 	list_order_3_groups: 42
> > 	list_order_4_groups: 513
> > 	list_order_5_groups: 62
> > 	list_order_6_groups: 434
> > 	list_order_7_groups: 2602
> > 	list_order_8_groups: 10951
> > 	list_order_9_groups: 44883
> > 	list_order_10_groups: 152357
> > 	list_order_11_groups: 24899
> > 	list_order_12_groups: 30461
> > 	list_order_13_groups: 18756
> > avg_fragment_size_lists:
> > 	list_order_0_groups: 108
> > 	list_order_1_groups: 411
> > 	list_order_2_groups: 1640
> > 	list_order_3_groups: 5809
> > 	list_order_4_groups: 14909
> > 	list_order_5_groups: 31345
> > 	list_order_6_groups: 54132
> > 	list_order_7_groups: 90294
> > 	list_order_8_groups: 77322
> > 	list_order_9_groups: 10096
> > 	list_order_10_groups: 0
> > 	list_order_11_groups: 0
> > 	list_order_12_groups: 0
> > 	list_order_13_groups: 0
> > 
> > These machines are striped and are using noatime:
> > 
> > $ grep ext4 /proc/mounts
> > /dev/md127 /state ext4 rw,noatime,stripe=1280 0 0
> > 
> > Is there some tunable or configuration option that I'm missing that
> > could help here to avoid wasting time in
> > ext4_mb_find_good_group_avg_frag_lists() when it's most likely going to
> > fail an order 9 allocation anyway?

So I'm somewhat confused here. How big is the allocation request? Above you
write that average size of order 9 bucket is < 1280 which is true and
makes me assume the allocation is for 1 stripe which is 1280 blocks. But
here you write about order 9 allocation.

Anyway, stripe aligned allocations don't always play well with
mb_optimize_scan logic, so you can try mounting the filesystem with
mb_optimize_scan=0 mount option.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

