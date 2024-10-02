Return-Path: <linux-fsdevel+bounces-30686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E9898D4C5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 15:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3497281D44
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 13:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6E01D0493;
	Wed,  2 Oct 2024 13:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="C2JPeSwX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="d7l4p7qR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="C2JPeSwX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="d7l4p7qR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179D51CF28B;
	Wed,  2 Oct 2024 13:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727875435; cv=none; b=oRpQDmbemPqWJSUnchL/LyR8f/KLPUs4JXzlkfO3H4xgD0gRurXJM77X0NPvDAxzLh9iEI7m4umCmB2SGxPFXh4IoPMI2/fHvSVAx+FC1ciNMk6mZ8OWFkLYT80ORo9RbYSpcGxsteDdVfhOnKKFr5KbTvTGriW5TPKZQqd9xns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727875435; c=relaxed/simple;
	bh=YMsEHsHqgHU2Jqw9WqFUXm5C7dSstlBx7jDdUtF5zAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=REylYC35givBiYQ1l8zFwpxHPBqDtiOXSeV2Hecgg+KsHma0qMKLNEWxrlAAXSDI5aVbsydgL01+0qElcm6LhUg7zmaqlb7knltX4uYeF9ts9RyxpVOKkYobv7rgwk2YjjbNnYi/0f3IgDVc6aUoiOOqUaW89kfwKZWOeSFqfl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=C2JPeSwX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=d7l4p7qR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=C2JPeSwX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=d7l4p7qR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1D6221FD53;
	Wed,  2 Oct 2024 13:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727875432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HVuiTvRCrZwf6HeXK12csr1q5Em3pvbiT9/7ux4NBe0=;
	b=C2JPeSwXzI5h9FClwHGd7YqfFg0AzCuEtXCXXFX+gmhYYrBhnHAl2t5E6X0jHkmzREGAZo
	O4yzuY7LZxSBUgLWPeXY13cuCYkMBdGD3suWSzXy4m0W8ibSnmLZvnq99dMYtNZeSAl7HJ
	gaHJ7kMp32hg7UXhPQ0Fih5fZwath2I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727875432;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HVuiTvRCrZwf6HeXK12csr1q5Em3pvbiT9/7ux4NBe0=;
	b=d7l4p7qRxOQ0w4AMWRDuxgDgltYQG/YpIfEeizfjGio1oNpuegQnsz2KA1eEAVMwLfkOkH
	au1YG75ajwlwAdCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=C2JPeSwX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=d7l4p7qR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727875432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HVuiTvRCrZwf6HeXK12csr1q5Em3pvbiT9/7ux4NBe0=;
	b=C2JPeSwXzI5h9FClwHGd7YqfFg0AzCuEtXCXXFX+gmhYYrBhnHAl2t5E6X0jHkmzREGAZo
	O4yzuY7LZxSBUgLWPeXY13cuCYkMBdGD3suWSzXy4m0W8ibSnmLZvnq99dMYtNZeSAl7HJ
	gaHJ7kMp32hg7UXhPQ0Fih5fZwath2I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727875432;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HVuiTvRCrZwf6HeXK12csr1q5Em3pvbiT9/7ux4NBe0=;
	b=d7l4p7qRxOQ0w4AMWRDuxgDgltYQG/YpIfEeizfjGio1oNpuegQnsz2KA1eEAVMwLfkOkH
	au1YG75ajwlwAdCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1104E13A6E;
	Wed,  2 Oct 2024 13:23:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MIwkBGhJ/WY7HAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 02 Oct 2024 13:23:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B638EA08CB; Wed,  2 Oct 2024 15:23:51 +0200 (CEST)
Date: Wed, 2 Oct 2024 15:23:51 +0200
From: Jan Kara <jack@suse.cz>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: amir73il@gmail.com, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, phillip@squashfs.org.uk,
	squashfs-devel@lists.sourceforge.net,
	syzbot+c679f13773f295d2da53@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V3] inotify: Fix possible deadlock in
 fsnotify_destroy_mark
Message-ID: <20241002132351.soglueukw7ttgxhf@quack3>
References: <CAOQ4uxhrSSpPijzeuFWRZBrgZvEyk6aLK=q7fBz3rpiZcHZrvg@mail.gmail.com>
 <20240927143642.2369508-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927143642.2369508-1-lizhi.xu@windriver.com>
X-Rspamd-Queue-Id: 1D6221FD53
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[c679f13773f295d2da53];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,vger.kernel.org,squashfs.org.uk,lists.sourceforge.net,syzkaller.appspotmail.com,googlegroups.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:dkim]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO

On Fri 27-09-24 22:36:42, Lizhi Xu wrote:
> [Syzbot reported]
> WARNING: possible circular locking dependency detected
> 6.11.0-rc4-syzkaller-00019-gb311c1b497e5 #0 Not tainted
> ------------------------------------------------------
> kswapd0/78 is trying to acquire lock:
> ffff88801b8d8930 (&group->mark_mutex){+.+.}-{3:3}, at: fsnotify_group_lock include/linux/fsnotify_backend.h:270 [inline]
> ffff88801b8d8930 (&group->mark_mutex){+.+.}-{3:3}, at: fsnotify_destroy_mark+0x38/0x3c0 fs/notify/mark.c:578
> 
> but task is already holding lock:
> ffffffff8ea2fd60 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:6841 [inline]
> ffffffff8ea2fd60 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0xbb4/0x35a0 mm/vmscan.c:7223
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #1 (fs_reclaim){+.+.}-{0:0}:
>        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
>        __fs_reclaim_acquire mm/page_alloc.c:3818 [inline]
>        fs_reclaim_acquire+0x88/0x140 mm/page_alloc.c:3832
>        might_alloc include/linux/sched/mm.h:334 [inline]
>        slab_pre_alloc_hook mm/slub.c:3939 [inline]
>        slab_alloc_node mm/slub.c:4017 [inline]
>        kmem_cache_alloc_noprof+0x3d/0x2a0 mm/slub.c:4044
>        inotify_new_watch fs/notify/inotify/inotify_user.c:599 [inline]
>        inotify_update_watch fs/notify/inotify/inotify_user.c:647 [inline]
>        __do_sys_inotify_add_watch fs/notify/inotify/inotify_user.c:786 [inline]
>        __se_sys_inotify_add_watch+0x72e/0x1070 fs/notify/inotify/inotify_user.c:729
>        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>        do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #0 (&group->mark_mutex){+.+.}-{3:3}:
>        check_prev_add kernel/locking/lockdep.c:3133 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3252 [inline]
>        validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3868
>        __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
>        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
>        __mutex_lock_common kernel/locking/mutex.c:608 [inline]
>        __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
>        fsnotify_group_lock include/linux/fsnotify_backend.h:270 [inline]
>        fsnotify_destroy_mark+0x38/0x3c0 fs/notify/mark.c:578
>        fsnotify_destroy_marks+0x14a/0x660 fs/notify/mark.c:934
>        fsnotify_inoderemove include/linux/fsnotify.h:264 [inline]
>        dentry_unlink_inode+0x2e0/0x430 fs/dcache.c:403
>        __dentry_kill+0x20d/0x630 fs/dcache.c:610
>        shrink_kill+0xa9/0x2c0 fs/dcache.c:1055
>        shrink_dentry_list+0x2c0/0x5b0 fs/dcache.c:1082
>        prune_dcache_sb+0x10f/0x180 fs/dcache.c:1163
>        super_cache_scan+0x34f/0x4b0 fs/super.c:221
>        do_shrink_slab+0x701/0x1160 mm/shrinker.c:435
>        shrink_slab+0x1093/0x14d0 mm/shrinker.c:662
>        shrink_one+0x43b/0x850 mm/vmscan.c:4815
>        shrink_many mm/vmscan.c:4876 [inline]
>        lru_gen_shrink_node mm/vmscan.c:4954 [inline]
>        shrink_node+0x3799/0x3de0 mm/vmscan.c:5934
>        kswapd_shrink_node mm/vmscan.c:6762 [inline]
>        balance_pgdat mm/vmscan.c:6954 [inline]
>        kswapd+0x1bcd/0x35a0 mm/vmscan.c:7223
>        kthread+0x2f0/0x390 kernel/kthread.c:389
>        ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 
> other info that might help us debug this:
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(fs_reclaim);
>                                lock(&group->mark_mutex);
>                                lock(fs_reclaim);
>   lock(&group->mark_mutex);
> 
>  *** DEADLOCK ***
> 
> [Analysis]
> The inotify_new_watch() call passes through GFP_KERNEL, use memalloc_nofs_save/
> memalloc_nofs_restore to make sure we don't end up with the fs reclaim dependency.
> 
> That any notification group needs to use NOFS allocations to be safe
> against this race so we can just remove FSNOTIFY_GROUP_NOFS and
> unconditionally do memalloc_nofs_save() in fsnotify_group_lock().
> 
> Reported-and-tested-by: syzbot+c679f13773f295d2da53@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=c679f13773f295d2da53
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>

Thanks. I've added the patch to my tree.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

