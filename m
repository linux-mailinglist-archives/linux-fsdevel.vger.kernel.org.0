Return-Path: <linux-fsdevel+bounces-30239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A4E988258
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 12:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1407E283906
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 10:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8B21BC086;
	Fri, 27 Sep 2024 10:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HwUqdqXu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YbMAKTAN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Bcm9QXh5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ga7OdGMR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32DF1B4C23;
	Fri, 27 Sep 2024 10:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727432459; cv=none; b=t/4MCXvYqiSytanixF43OjTOVJjW4sSlmaJPBYG1DkHZOQqRzyvvvfhGQjMd9anBzn+YizlBa/UW7o2GdBX83ALgrSWjeoScJNLO498yzANnQe0QDLnwmoibM7ZZl1dTfAaNu9/BTGI3l+YEptGMZ+4hAZk9MgPJXM9uDKRWghM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727432459; c=relaxed/simple;
	bh=7PO1MxQ0fjA2hryP/It8e8OI7DVfYqyO2NAGyV6D7Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jsOjI4x6Gq3ZO8nTjxiWwnXHZLcRMJb7tEt6MReToCuiIGAtkEEvFXtE2fm9HcAr5kFcE6Pp2TSeI/cYZEWPqDVgnf8U3tu2XdLo7+yVd6OBQQhAp6yDhaC0erx1rSdmQ0rK6P9XEmQTZU3yY25jVwEMwrXZo72ZW46F8aSNCqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HwUqdqXu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YbMAKTAN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Bcm9QXh5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ga7OdGMR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EC2C621B94;
	Fri, 27 Sep 2024 10:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727432455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q9w24BRYtjvligv3ZQVtycGgxnP/AoCZYUXV1YlzvHs=;
	b=HwUqdqXu8IERgdJJEWyu2+6eLxoNePSkuLPIcieznw5VoT+9fOQxuDjRmwbNGVqar1vnHX
	F2dpjIrVxfAZahpzYfTZaIo+cCfVHBMx3U+mkIZaf6Dg1CWRuiUAhiici604Zbu/lb42z1
	24DgU3A7Hd4j4/rH36BYdA4X/aTnRFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727432455;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q9w24BRYtjvligv3ZQVtycGgxnP/AoCZYUXV1YlzvHs=;
	b=YbMAKTAN9NDz9YLbjGsQD4NKqW0xc+O01rVrS/23QXHsJ13BF0ClkJ3W8o014onAoTFBnu
	hh4AM/uCIg07IbDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727432454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q9w24BRYtjvligv3ZQVtycGgxnP/AoCZYUXV1YlzvHs=;
	b=Bcm9QXh5+aW2+HLgtNf4ji6Tmf78qtFAqNGyCWU6n4XaJtCwrp7fdPqfJAE2M+w4Go4ZO3
	rm4fpsCQB2iMSUq/zA6qUr49Wk2pQRhlULP+fS4PNxkFOec2SVGcGltY0NbisDl/7++coe
	t/A6eO66Xmsy290uEaiLAsFwo7KN5lQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727432454;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q9w24BRYtjvligv3ZQVtycGgxnP/AoCZYUXV1YlzvHs=;
	b=ga7OdGMRMUzM/Vl07MrdWvG8bB71CiT/wxHno+Udl5+PjqiHLB6wILpJkiwgo/UOkH9/ey
	cSQd+IFp8uFijRBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF94F13A73;
	Fri, 27 Sep 2024 10:20:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SOKPNgaH9maVVwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 27 Sep 2024 10:20:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 830AEA0826; Fri, 27 Sep 2024 12:20:50 +0200 (CEST)
Date: Fri, 27 Sep 2024 12:20:50 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Lizhi Xu <lizhi.xu@windriver.com>,
	syzbot+c679f13773f295d2da53@syzkaller.appspotmail.com, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	phillip@squashfs.org.uk, squashfs-devel@lists.sourceforge.net,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] inotify: Fix possible deadlock in fsnotify_destroy_mark
Message-ID: <20240927102050.cfr4ovprdbgiicgk@quack3>
References: <000000000000ae63710620417f67@google.com>
 <20240927091231.360334-1-lizhi.xu@windriver.com>
 <CAOQ4uxisuBYc6Zy7D8p+RkWxq3g=Hij99wKMrL_FqRmOFx-wXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxisuBYc6Zy7D8p+RkWxq3g=Hij99wKMrL_FqRmOFx-wXQ@mail.gmail.com>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[c679f13773f295d2da53];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 27-09-24 11:31:50, Amir Goldstein wrote:
> On Fri, Sep 27, 2024 at 11:12 AM Lizhi Xu <lizhi.xu@windriver.com> wrote:
> >
> > [Syzbot reported]
> > WARNING: possible circular locking dependency detected
> > 6.11.0-rc4-syzkaller-00019-gb311c1b497e5 #0 Not tainted
> > ------------------------------------------------------
> > kswapd0/78 is trying to acquire lock:
> > ffff88801b8d8930 (&group->mark_mutex){+.+.}-{3:3}, at: fsnotify_group_lock include/linux/fsnotify_backend.h:270 [inline]
> > ffff88801b8d8930 (&group->mark_mutex){+.+.}-{3:3}, at: fsnotify_destroy_mark+0x38/0x3c0 fs/notify/mark.c:578
> >
> > but task is already holding lock:
> > ffffffff8ea2fd60 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:6841 [inline]
> > ffffffff8ea2fd60 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0xbb4/0x35a0 mm/vmscan.c:7223
> >
> > which lock already depends on the new lock.
> >
> >
> > the existing dependency chain (in reverse order) is:
> >
> > -> #1 (fs_reclaim){+.+.}-{0:0}:
> >        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
> >        __fs_reclaim_acquire mm/page_alloc.c:3818 [inline]
> >        fs_reclaim_acquire+0x88/0x140 mm/page_alloc.c:3832
> >        might_alloc include/linux/sched/mm.h:334 [inline]
> >        slab_pre_alloc_hook mm/slub.c:3939 [inline]
> >        slab_alloc_node mm/slub.c:4017 [inline]
> >        kmem_cache_alloc_noprof+0x3d/0x2a0 mm/slub.c:4044
> >        inotify_new_watch fs/notify/inotify/inotify_user.c:599 [inline]
> >        inotify_update_watch fs/notify/inotify/inotify_user.c:647 [inline]
> >        __do_sys_inotify_add_watch fs/notify/inotify/inotify_user.c:786 [inline]
> >        __se_sys_inotify_add_watch+0x72e/0x1070 fs/notify/inotify/inotify_user.c:729
> >        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >        do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > -> #0 (&group->mark_mutex){+.+.}-{3:3}:
> >        check_prev_add kernel/locking/lockdep.c:3133 [inline]
> >        check_prevs_add kernel/locking/lockdep.c:3252 [inline]
> >        validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3868
> >        __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
> >        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
> >        __mutex_lock_common kernel/locking/mutex.c:608 [inline]
> >        __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
> >        fsnotify_group_lock include/linux/fsnotify_backend.h:270 [inline]
> >        fsnotify_destroy_mark+0x38/0x3c0 fs/notify/mark.c:578
> >        fsnotify_destroy_marks+0x14a/0x660 fs/notify/mark.c:934
> >        fsnotify_inoderemove include/linux/fsnotify.h:264 [inline]
> >        dentry_unlink_inode+0x2e0/0x430 fs/dcache.c:403
> >        __dentry_kill+0x20d/0x630 fs/dcache.c:610
> >        shrink_kill+0xa9/0x2c0 fs/dcache.c:1055
> >        shrink_dentry_list+0x2c0/0x5b0 fs/dcache.c:1082
> >        prune_dcache_sb+0x10f/0x180 fs/dcache.c:1163
> >        super_cache_scan+0x34f/0x4b0 fs/super.c:221
> >        do_shrink_slab+0x701/0x1160 mm/shrinker.c:435
> >        shrink_slab+0x1093/0x14d0 mm/shrinker.c:662
> >        shrink_one+0x43b/0x850 mm/vmscan.c:4815
> >        shrink_many mm/vmscan.c:4876 [inline]
> >        lru_gen_shrink_node mm/vmscan.c:4954 [inline]
> >        shrink_node+0x3799/0x3de0 mm/vmscan.c:5934
> >        kswapd_shrink_node mm/vmscan.c:6762 [inline]
> >        balance_pgdat mm/vmscan.c:6954 [inline]
> >        kswapd+0x1bcd/0x35a0 mm/vmscan.c:7223
> >        kthread+0x2f0/0x390 kernel/kthread.c:389
> >        ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> >        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> >
> > other info that might help us debug this:
> >
> >  Possible unsafe locking scenario:
> >
> >        CPU0                    CPU1
> >        ----                    ----
> >   lock(fs_reclaim);
> >                                lock(&group->mark_mutex);
> >                                lock(fs_reclaim);
> >   lock(&group->mark_mutex);
> >
> >  *** DEADLOCK ***
> >
> > [Analysis]
> > The inotify_new_watch() call passes through GFP_KERNEL, use memalloc_nofs_save/
> > memalloc_nofs_restore to make sure we don't end up with the fs reclaim dependency.
> 
> I don't think this can actually happen, because an inode with
> an inotify mark cannot get evicted,

Well, in the trace above dentry reclaim apparently raced with unlink and so
ended up going to dentry_unlink_inode() -> fsnotify_inoderemove() which
does indeed end up grabbing group->mark_mutex. 

> but I cannot think of a way to annotate
> this to lockdep, so if we need to silence lockdep, this is what
> FSNOTIFY_GROUP_NOFS was created for.

So yes, inotify needs FSNOTIFY_GROUP_NOFS as well. In fact this trace shows
that any notification group needs to use NOFS allocations to be safe
against this race so we can just remove FSNOTIFY_GROUP_NOFS and
unconditionally do memalloc_nofs_save() in fsnotify_group_lock(). Lizhi,
will you send a patch please?

								Honza

> > Reported-and-tested-by: syzbot+c679f13773f295d2da53@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=c679f13773f295d2da53
> > Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> > ---
> >  fs/notify/inotify/inotify_user.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> > index c7e451d5bd51..70b77b6186a6 100644
> > --- a/fs/notify/inotify/inotify_user.c
> > +++ b/fs/notify/inotify/inotify_user.c
> > @@ -643,8 +643,13 @@ static int inotify_update_watch(struct fsnotify_group *group, struct inode *inod
> >         /* try to update and existing watch with the new arg */
> >         ret = inotify_update_existing_watch(group, inode, arg);
> >         /* no mark present, try to add a new one */
> > -       if (ret == -ENOENT)
> > +       if (ret == -ENOENT) {
> > +               unsigned int nofs_flag;
> > +
> > +               nofs_flag = memalloc_nofs_save();
> >                 ret = inotify_new_watch(group, inode, arg);
> > +               memalloc_nofs_restore(nofs_flag);
> > +       }
> >         fsnotify_group_unlock(group);
> >
> >         return ret;
> > --
> > 2.43.0
> >
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

