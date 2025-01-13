Return-Path: <linux-fsdevel+bounces-39031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F62A0B498
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 11:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAC74164BEF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 10:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B17D22AE4E;
	Mon, 13 Jan 2025 10:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Uel/aDQY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Sf5G/Piq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Uel/aDQY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Sf5G/Piq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D116187554;
	Mon, 13 Jan 2025 10:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736764132; cv=none; b=Xf8htT05TBuCWBgXt2a6SfXNOccAHKt+5BVkteigiIH5PsQSF1JwrN+m6gY0/xskHhbKAOFeoED/9yd3J2ylx+jzHzn7SJNMW8wetP1KZGWPD/Z6UiTa2J7hDY0D3U6au+UoRZuUqcETJKqt58LlW0J4oeSnzZs3pz+6yyM+D0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736764132; c=relaxed/simple;
	bh=tfGi6DJ4crtBDhJSkeFlMG9hzfnY+iayqhh7/YoEWgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSC847wzldGw/JfcGPC2alutFfGKGrK0RZIIZ3VO97RyDQt8ggxQq8e+vSX2pqxFzwCyt7Zs3x9XhVBKrNarW5a93qMzRaTywT5vNdhNJSnTA7c786322DMo/whqR6ujWcDBU0eP7dxXWhOgEuewdfF8n2Nl7VW+N9q02zoCYco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Uel/aDQY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Sf5G/Piq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Uel/aDQY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Sf5G/Piq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 672F521102;
	Mon, 13 Jan 2025 10:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736764128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3YR2HQF4k2ObdLNGSaMe+dXaIEGBesP5t2w/hKJTvKc=;
	b=Uel/aDQYY1za8bghyM3gAHgnrOvHDUEvFeXfy/q+lVEkI5yIkZ2KVn426VyVb5nQI2iBI0
	RUxtN3ekLJcKzAfHa2ksDCR8Xe0BGBvwqs9DJemYZyXzMFxYvsbY0WW9Px6nycwspWwgb3
	9gAPZVoR8PRrPgU8hrwyrUDF/HpBhUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736764128;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3YR2HQF4k2ObdLNGSaMe+dXaIEGBesP5t2w/hKJTvKc=;
	b=Sf5G/PiqDWgacGcF9Iqoq1lnNJYbY00l6OEQxIe7fU8Q8GjG6kJZJMiyMhkYkArU1sIG/N
	CZ89JrB5n7ATuRDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736764128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3YR2HQF4k2ObdLNGSaMe+dXaIEGBesP5t2w/hKJTvKc=;
	b=Uel/aDQYY1za8bghyM3gAHgnrOvHDUEvFeXfy/q+lVEkI5yIkZ2KVn426VyVb5nQI2iBI0
	RUxtN3ekLJcKzAfHa2ksDCR8Xe0BGBvwqs9DJemYZyXzMFxYvsbY0WW9Px6nycwspWwgb3
	9gAPZVoR8PRrPgU8hrwyrUDF/HpBhUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736764128;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3YR2HQF4k2ObdLNGSaMe+dXaIEGBesP5t2w/hKJTvKc=;
	b=Sf5G/PiqDWgacGcF9Iqoq1lnNJYbY00l6OEQxIe7fU8Q8GjG6kJZJMiyMhkYkArU1sIG/N
	CZ89JrB5n7ATuRDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 509FA13876;
	Mon, 13 Jan 2025 10:28:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XBdoE+DqhGc3agAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 13 Jan 2025 10:28:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EBD02A082D; Mon, 13 Jan 2025 11:28:43 +0100 (CET)
Date: Mon, 13 Jan 2025 11:28:43 +0100
From: Jan Kara <jack@suse.cz>
To: Kun Hu <huk23@m.fudan.edu.cn>
Cc: jlayton@redhat.com, tytso@mit.edu, adilger.kernel@dilger.ca, 
	david@fromorbit.com, bfields@redhat.com, viro@zeniv.linux.org.uk, 
	christian.brauner@ubuntu.com, hch@lst.de, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jack@suse.cz, brauner@kernel.org, linux-bcachefs@vger.kernel.org, 
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: Bug: INFO_ task hung in lock_two_nondirectories
Message-ID: <gwgec4tknjmjel4e37myyichugheuba3sy7cxkdqqj2raaglf5@n7uttxolimpa>
References: <42BD15B5-3C6C-437E-BF52-E22E6F200513@m.fudan.edu.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42BD15B5-3C6C-437E-BF52-E22E6F200513@m.fudan.edu.cn>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Flag: NO

Hello!

First I'd note that the list of recipients of this report seems somewhat
arbitrary. linux-kernel & linux-fsdevel makes sense but I'm not sure how
you have arrived at the list of other persons you have CCed :). I have to
say syzbot folks have done a pretty good job at implementing mechanisms how
to determine recipients of the reports (as well as managing existing
reports over the web / email). Maybe you could take some inspiration there
or just contribute your syzkaller modifications to syzbot folks so that
your reports can benefit from all the other infrastructure they have?

Anyway, in this particular case, based on locks reported by lockdep, the
problem seems to be most likely somewhere in bcachefs. Added relevant CCs.

								Honza

On Sun 12-01-25 18:00:24, Kun Hu wrote:
> When using our customized fuzzer tool to fuzz the latest Linux kernel, the following crash (43s)
> was triggered.
> 
> HEAD commit: 9d89551994a430b50c4fffcb1e617a057fa76e20
> git tree: upstream
> Console output: https://github.com/pghk13/Kernel-Bug/blob/main/0110_6.13rc6/43-INFO_%20task%20hung%20in%20lock_two_nondirectories/log0
> Kernel config: https://github.com/pghk13/Kernel-Bug/blob/main/0110_6.13rc6/config.txt
> C reproducer: https://github.com/pghk13/Kernel-Bug/blob/main/0110_6.13rc6/43-INFO_%20task%20hung%20in%20lock_two_nondirectories/12generated_program.c
> Syzlang reproducer: https://github.com/pghk13/Kernel-Bug/blob/main/0110_6.13rc6/43-INFO_%20task%20hung%20in%20lock_two_nondirectories/12_repro.txt
> 
> We first found the issue without a stable C and Syzlang reproducers, but later I tried multiple rounds of replication and got the C and Syzlang reproducers.
> 
> I suspect the issue may stem from resource contention or synchronization delays, as indicated by functions like lock_two_nondirectories and vfs_rename. There could also be potential deadlocks or inconsistencies in file system state management (e.g., sb_writers or inode locks) within the bcachefs subsystem. Additionally, interactions between lock_rename and concurrent rename operations might be contributing factors.
> 
> Could you kindly help review these areas to narrow down the root cause? Your expertise would be greatly appreciated.
> 
> If you fix this issue, please add the following tag to the commit:
> Reported-by: Kun Hu <huk23@m.fudan.edu.cn>, Jiaji Qin <jjtan24@m.fudan.edu.cn>
> 
> INFO: task syz.0.12:1823 blocked for more than 143 seconds.
>       Tainted: G        W          6.13.0-rc6 #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz.0.12        state:D stack:25728 pid:1823  tgid:1714  ppid:442    flags:0x00000004
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5369 [inline]
>  __schedule+0xe60/0x4120 kernel/sched/core.c:6756
>  __schedule_loop kernel/sched/core.c:6833 [inline]
>  schedule+0xd4/0x210 kernel/sched/core.c:6848
>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6905
>  rwsem_down_write_slowpath+0x551/0x1660 kernel/locking/rwsem.c:1176
>  __down_write_common kernel/locking/rwsem.c:1304 [inline]
>  __down_write kernel/locking/rwsem.c:1313 [inline]
>  down_write_nested+0x1db/0x210 kernel/locking/rwsem.c:1694
>  inode_lock_nested include/linux/fs.h:853 [inline]
>  lock_two_nondirectories+0x107/0x210 fs/inode.c:1283
>  vfs_rename+0x14c7/0x2a20 fs/namei.c:5038
>  do_renameat2+0xb81/0xc90 fs/namei.c:5224
>  __do_sys_renameat2 fs/namei.c:5258 [inline]
>  __se_sys_renameat2 fs/namei.c:5255 [inline]
>  __x64_sys_renameat2+0xe4/0x120 fs/namei.c:5255
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xc3/0x1d0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fca967c071d
> RSP: 002b:00007fca953f2ba8 EFLAGS: 00000246 ORIG_RAX: 000000000000013c
> RAX: ffffffffffffffda RBX: 00007fca96983058 RCX: 00007fca967c071d
> RDX: ffffffffffffff9c RSI: 0000000020000580 RDI: ffffffffffffff9c
> RBP: 00007fca96835425 R08: 0000000000000000 R09: 0000000000000000
> R10: 00000000200005c0 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fca96983064 R14: 00007fca969830f0 R15: 00007fca953f2d40
>  </TASK>
> 
> Showing all locks held in the system:
> 1 lock held by khungtaskd/45:
>  #0: ffffffff9fb1aea0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
>  #0: ffffffff9fb1aea0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
>  #0: ffffffff9fb1aea0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6744
> 1 lock held by in:imklog/329:
> 5 locks held by syz.0.12/1715:
>  #0: ff1100003ff8c420 (sb_writers#20){.+.+}-{0:0}, at: do_open fs/namei.c:3821 [inline]
>  #0: ff1100003ff8c420 (sb_writers#20){.+.+}-{0:0}, at: path_openat+0x1577/0x2970 fs/namei.c:3987
>  #1: ff110000415c1780 (&sb->s_type->i_mutex_key#21){++++}-{4:4}, at: inode_lock include/linux/fs.h:818 [inline]
>  #1: ff110000415c1780 (&sb->s_type->i_mutex_key#21){++++}-{4:4}, at: do_truncate+0x131/0x200 fs/open.c:63
>  #2: ff11000047780a38 (&c->snapshot_create_lock){.+.+}-{4:4}, at: bch2_truncate+0x145/0x260 fs/bcachefs/io_misc.c:292
>  #3: ff11000047784398 (&c->btree_trans_barrier){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:158 [inline]
>  #3: ff11000047784398 (&c->btree_trans_barrier){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:249 [inline]
>  #3: ff11000047784398 (&c->btree_trans_barrier){.+.+}-{0:0}, at: __bch2_trans_get+0x625/0xf60 fs/bcachefs/btree_iter.c:3228
>  #4: ff110000477a66d0 (&c->gc_lock){.+.+}-{4:4}, at: bch2_btree_update_start+0xb18/0x2010 fs/bcachefs/btree_update_interior.c:1197
> 3 locks held by syz.0.12/1823:
>  #0: ff1100003ff8c420 (sb_writers#20){.+.+}-{0:0}, at: do_renameat2+0x3ea/0xc90 fs/namei.c:5154
>  #1: ff110000415c0148 (&sb->s_type->i_mutex_key#21/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:853 [inline]
>  #1: ff110000415c0148 (&sb->s_type->i_mutex_key#21/1){+.+.}-{4:4}, at: lock_rename fs/namei.c:3215 [inline]
>  #1: ff110000415c0148 (&sb->s_type->i_mutex_key#21/1){+.+.}-{4:4}, at: lock_rename+0xa5/0xc0 fs/namei.c:3212
>  #2: ff110000415c1780 (&sb->s_type->i_mutex_key#21/4){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:853 [inline]
>  #2: ff110000415c1780 (&sb->s_type->i_mutex_key#21/4){+.+.}-{4:4}, at: lock_two_nondirectories+0x107/0x210 fs/inode.c:1283
> 4 locks held by bch-reclaim/loo/1811:
>  #0: ff110000477cb0a8 (&j->reclaim_lock){+.+.}-{4:4}, at: bch2_journal_reclaim_thread+0x101/0x560 fs/bcachefs/journal_reclaim.c:739
>  #1: ff11000047784398 (&c->btree_trans_barrier){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:158 [inline]
>  #1: ff11000047784398 (&c->btree_trans_barrier){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:249 [inline]
>  #1: ff11000047784398 (&c->btree_trans_barrier){.+.+}-{0:0}, at: __bch2_trans_get+0x625/0xf60 fs/bcachefs/btree_iter.c:3228
>  #2: ff11000047784740 (&wb->flushing.lock){+.+.}-{4:4}, at: btree_write_buffer_flush_seq+0x69f/0xa40 fs/bcachefs/btree_write_buffer.c:516
>  #3: ff110000477a66d0 (&c->gc_lock){.+.+}-{4:4}, at: bch2_btree_update_start+0xb18/0x2010 fs/bcachefs/btree_update_interior.c:1197
> 1 lock held by syz-executor/5484:
> 2 locks held by syz.1.1333/8755:
> 1 lock held by syz.7.1104/8876:
>  #0: ffffffff9fb27ef8 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock+0x29f/0x3d0 kernel/rcu/tree_exp.h:297
> 2 locks held by syz.8.1367/8889:
> 
> =============================================
> 
> ---------------
> thanks,
> Kun Hu
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

