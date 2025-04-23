Return-Path: <linux-fsdevel+bounces-47085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD95A988A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 13:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E631C5A34EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 11:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A0526F450;
	Wed, 23 Apr 2025 11:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AZPuGg2L";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="F18oEHTU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="g8B+O98+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4d1mJHh5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D2D269826
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Apr 2025 11:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745408139; cv=none; b=uP/hkj5yb3Mz8OpVqf4g+zTKPg0LPKDeJlFu0q1tFiTLmbUpW1aXzVHC3k0EQfO6lc5ezCClmvRb2Xc0wPO7oP6x9/2ezDxNWuy7gc9ILIycy6eLkTnSW3CpRjLLl9rG+X9D6I5mvuZQ8h02NOsiaRqYhsH1h6yoPNKxjNWeKK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745408139; c=relaxed/simple;
	bh=LcTe/d1Ph23Q9ADA8gbOtmI1qLthurjCeD517hDoX7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pr0mSh8qD3NICDUQsglSLm7glwQElwGFnylmRsI0CLz2/xQBNG3X+ZjQ57F5OQWBq/40/omKQNelWP/AIGYGVtzZpT5hn3lpIkd4reeTJsZ/qWBz5OZvSVubVLvVsDwnmc4FLOcKEtffgzJZfzWCWxLnVRr5JysuxdbhpmoTbQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AZPuGg2L; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=F18oEHTU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=g8B+O98+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4d1mJHh5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7653E1F38D;
	Wed, 23 Apr 2025 11:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745408133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PvLE4bmQuPfApZLR0EMiVz9QpfN79c9/wwuTHBEUDUo=;
	b=AZPuGg2Lt6B6C6j2DF4Ihd0/5cB/lpOR90T7iQA4qZf0q58NGw0GYxfvTB8yRqDAkYsJUS
	89GV2A9KUPXjahjwajuuKTQPrFe4U7hHTuE3IbF8V0p95ZxZnK703vZXM1EvnWLia+BB1y
	WhdlZoyjV3JB2iUE38jIMCzeClea7l4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745408133;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PvLE4bmQuPfApZLR0EMiVz9QpfN79c9/wwuTHBEUDUo=;
	b=F18oEHTUHeT08I2klHabmhRFdNdzrqIdlH+yryhxCeudhkPD15v0Vtv2V+BthV2C5wwedn
	z05KJEAUcsU+e5BA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=g8B+O98+;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4d1mJHh5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745408132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PvLE4bmQuPfApZLR0EMiVz9QpfN79c9/wwuTHBEUDUo=;
	b=g8B+O98+dq29gUFSHTL3g8FKofKJYmk28ZUIiUWgL+1Ys2joZE5gNIPwkwy3jRn3hUlX1D
	sndV/6pa9X3K0u0r1+wXAvVeO/7O1SevVOwC52Y2kU1zRZpx58vpuDNTjcubJlF27a/EW5
	OYNTCmkQgpYE9I0gjspb2HmDj9xgLY0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745408132;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PvLE4bmQuPfApZLR0EMiVz9QpfN79c9/wwuTHBEUDUo=;
	b=4d1mJHh5t6O8zOCa5FLnkjm71JuE0kVmTiVZpMvz3b6aDIIwLSjgaOHWf5g54JtXlcKCSW
	KlPzeXSf8OBq1wBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6096B13A3D;
	Wed, 23 Apr 2025 11:35:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id N6iPF4TQCGj5NAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 23 Apr 2025 11:35:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1094AA07A7; Wed, 23 Apr 2025 13:35:28 +0200 (CEST)
Date: Wed, 23 Apr 2025 13:35:28 +0200
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+321477fad98ea6dd35b7@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk, 
	Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [syzbot] [fs?] INFO: task hung in vfs_rename (2)
Message-ID: <z2pwc5kafcjpfmfo22ikwiqhutmzqskveffbgc2rcme4tztlr3@uvbibcbmm7b7>
References: <680809f3.050a0220.36a438.0003.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <680809f3.050a0220.36a438.0003.GAE@google.com>
X-Rspamd-Queue-Id: 7653E1F38D
X-Spam-Score: -1.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=170d968a88ba5c06];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlegroups.com:email,appspotmail.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,syzkaller.appspot.com:url,goo.gl:url,suse.cz:dkim];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[321477fad98ea6dd35b7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 22-04-25 14:28:19, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    fc96b232f8e7 Merge tag 'pci-v6.15-fixes-2' of git://git.ke..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=10c65fe4580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=170d968a88ba5c06
> dashboard link: https://syzkaller.appspot.com/bug?extid=321477fad98ea6dd35b7
> compiler:       Debian clang version 15.0.6, Debian LLD 15.0.6
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11075470580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13a6063f980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/fd977d7e57de/disk-fc96b232.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/ffa0a3b5b655/vmlinux-fc96b232.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/44df3bd100d2/bzImage-fc96b232.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/b166f1d5e115/mount_0.gz
>   fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=12655204580000)
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+321477fad98ea6dd35b7@syzkaller.appspotmail.com
> 
> INFO: task syz-executor362:5849 blocked for more than 143 seconds.
>       Not tainted 6.15.0-rc2-syzkaller-00278-gfc96b232f8e7 #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor362 state:D stack:24280 pid:5849  tgid:5849  ppid:5848   task_flags:0x400140 flags:0x00004006
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5382 [inline]
>  __schedule+0x1b33/0x51f0 kernel/sched/core.c:6767
>  __schedule_loop kernel/sched/core.c:6845 [inline]
>  schedule+0x163/0x360 kernel/sched/core.c:6860
>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6917
>  rwsem_down_write_slowpath+0xedd/0x1420 kernel/locking/rwsem.c:1176
>  __down_write_common kernel/locking/rwsem.c:1304 [inline]
>  __down_write kernel/locking/rwsem.c:1313 [inline]
>  down_write+0x1da/0x220 kernel/locking/rwsem.c:1578
>  inode_lock include/linux/fs.h:867 [inline]
>  vfs_rename+0x6b9/0xf10 fs/namei.c:5051
>  do_renameat2+0xc8d/0x1290 fs/namei.c:5235
>  __do_sys_renameat2 fs/namei.c:5269 [inline]
>  __se_sys_renameat2 fs/namei.c:5266 [inline]
>  __x64_sys_renameat2+0xce/0xe0 fs/namei.c:5266
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xf3/0x210 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f

The hang happens at:

inode_lock(target);

in vfs_rename() where 'target' is 'file0' which is a mountpoint of a FUSE
filesystem. Miklos?

								Honza

> RIP: 0033:0x7fc3678ce519
> RSP: 002b:00007ffc519cacb8 EFLAGS: 00000246 ORIG_RAX: 000000000000013c
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc3678ce519
> RDX: 0000000000000004 RSI: 0000200000000240 RDI: 0000000000000004
> RBP: 0000000000000000 R08: 0000000000000000 R09: 00007ffc519cacf0
> R10: 00002000000001c0 R11: 0000000000000246 R12: 00007ffc519cacf0
> R13: 00007ffc519caf78 R14: 431bde82d7b634db R15: 00007fc36791703b
>  </TASK>
> 
> Showing all locks held in the system:
> 1 lock held by khungtaskd/31:
>  #0: ffffffff8ed3df20 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
>  #0: ffffffff8ed3df20 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
>  #0: ffffffff8ed3df20 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x30/0x180 kernel/locking/lockdep.c:6764
> 2 locks held by getty/5587:
>  #0: ffff8880366f20a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
>  #1: ffffc900036d62f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x5bb/0x1700 drivers/tty/n_tty.c:2222
> 6 locks held by syz-executor362/5849:
>  #0: ffff88807f054420 (sb_writers#8){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:556
>  #1: ffff88807f054730 (&type->s_vfs_rename_key){+.+.}-{4:4}, at: lock_rename fs/namei.c:3234 [inline]
>  #1: ffff88807f054730 (&type->s_vfs_rename_key){+.+.}-{4:4}, at: do_renameat2+0x5d6/0x1290 fs/namei.c:5181
>  #2: ffff88807b3e8910 (&sb->s_type->i_mutex_key#14/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:902 [inline]
>  #2: ffff88807b3e8910 (&sb->s_type->i_mutex_key#14/1){+.+.}-{4:4}, at: lock_two_directories+0x1a8/0x220 fs/namei.c:3210
>  #3: ffff88807b2b8910 (&sb->s_type->i_mutex_key#14/5){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:902 [inline]
>  #3: ffff88807b2b8910 (&sb->s_type->i_mutex_key#14/5){+.+.}-{4:4}, at: lock_two_directories+0x1d1/0x220 fs/namei.c:3211
>  #4: ffff88807b2b82a0 (&sb->s_type->i_mutex_key#14/2){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:902 [inline]
>  #4: ffff88807b2b82a0 (&sb->s_type->i_mutex_key#14/2){+.+.}-{4:4}, at: vfs_rename+0x63f/0xf10 fs/namei.c:5049
>  #5: ffff88807b2b8910 (&sb->s_type->i_mutex_key#14){++++}-{4:4}, at: inode_lock include/linux/fs.h:867 [inline]
>  #5: ffff88807b2b8910 (&sb->s_type->i_mutex_key#14){++++}-{4:4}, at: vfs_rename+0x6b9/0xf10 fs/namei.c:5051
> 
> =============================================
> 
> NMI backtrace for cpu 1
> CPU: 1 UID: 0 PID: 31 Comm: khungtaskd Not tainted 6.15.0-rc2-syzkaller-00278-gfc96b232f8e7 #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  nmi_cpu_backtrace+0x4ab/0x4e0 lib/nmi_backtrace.c:113
>  nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
>  trigger_all_cpu_backtrace include/linux/nmi.h:158 [inline]
>  check_hung_uninterruptible_tasks kernel/hung_task.c:274 [inline]
>  watchdog+0x1058/0x10a0 kernel/hung_task.c:437
>  kthread+0x7b7/0x940 kernel/kthread.c:464
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
> Sending NMI from CPU 1 to CPUs 0:
> NMI backtrace for cpu 0
> CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.15.0-rc2-syzkaller-00278-gfc96b232f8e7 #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
> RIP: 0010:pv_native_safe_halt+0x13/0x20 arch/x86/kernel/paravirt.c:81
> Code: cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d 73 5f 20 00 f3 0f 1e fa fb f4 <c3> cc cc cc cc cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90
> RSP: 0018:ffffffff8ea07d60 EFLAGS: 000002c2
> RAX: 5fa1c341e9d1cd00 RBX: ffffffff8197267e RCX: ffffffff8c27d93c
> RDX: 0000000000000001 RSI: ffffffff8e6356dd RDI: ffffffff8ca0e2e0
> RBP: ffffffff8ea07eb8 R08: ffff8880b8632b5b R09: 1ffff110170c656b
> R10: dffffc0000000000 R11: ffffed10170c656c R12: 1ffffffff1d40fc6
> R13: 1ffffffff1d52cb0 R14: 0000000000000000 R15: dffffc0000000000
> FS:  0000000000000000(0000) GS:ffff888124fcf000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005597c9480600 CR3: 000000000eb38000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
>  default_idle+0x13/0x20 arch/x86/kernel/process.c:748
>  default_idle_call+0x74/0xb0 kernel/sched/idle.c:117
>  cpuidle_idle_call kernel/sched/idle.c:185 [inline]
>  do_idle+0x22e/0x5d0 kernel/sched/idle.c:325
>  cpu_startup_entry+0x42/0x60 kernel/sched/idle.c:423
>  rest_init+0x2dc/0x300 init/main.c:743
>  start_kernel+0x484/0x510 init/main.c:1099
>  x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:513
>  x86_64_start_kernel+0x66/0x70 arch/x86/kernel/head64.c:494
>  common_startup_64+0x13e/0x147
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

