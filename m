Return-Path: <linux-fsdevel+bounces-62201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBD5B8810C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 08:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17B0B3A46D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 06:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F8F2D0C64;
	Fri, 19 Sep 2025 06:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E8Qno5vc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20802BEC5A
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 06:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758264578; cv=none; b=K3KyamUrABqWP/RLCSrDvPmzTLWobBc+irP9RkdSlGUQ8ZoRwmp/20FBiUn2j2h6cXwtyc+EaRS8iZFufyuWpIGIPML/L8KIiOZ/gNQqhdXQW+FGxzE6zQe+2q4dwo7zX5OYCdc08X2YOrsYmcQBlzuqkEfJ8feEjR6iJBkM7ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758264578; c=relaxed/simple;
	bh=TSuTs95qyaxmGWCl5QI/IiVi4mhmu6HmD1gGkviGY3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+w+ZuERJvc8hpmG+TY1F1u+dTGdSx1xB8DItWhHIEhE0ll4/88ca8L+C0Ty34Io7iHL3dJJqFVi8VjgGrIdTMO4c2ZPHgPCkmHaxiNcxYn2mcUjyjXgzw0yV2IVAr4vyjdk1bu184jZom1gQnpDKG61gIvmn9wIJUl+J4y8GOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E8Qno5vc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758264574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NglS1LeOLjiCYpCRleIlmuIOGrUZ54nZq4/o1z62nKQ=;
	b=E8Qno5vc5f/w8QIHPfQ98JxcRN52V8tvJnMfoTgRxjTnDt+cwEfThBhbF26I0VUF2nSuOM
	30shxGF9i3hWe3TUiybP1tY70lzws9xU1lEaXNISQA23AvRB0ww5IE0GOYh7EUEtmSjPWR
	FJVMt/eTR5x6IWsEqwc1AGqcb821zTM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-slYl8wlcO8aPnFavrs3aEw-1; Fri,
 19 Sep 2025 02:49:31 -0400
X-MC-Unique: slYl8wlcO8aPnFavrs3aEw-1
X-Mimecast-MFC-AGG-ID: slYl8wlcO8aPnFavrs3aEw_1758264569
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1CED319560AE;
	Fri, 19 Sep 2025 06:49:29 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.65])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 2AF101955F21;
	Fri, 19 Sep 2025 06:49:24 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 19 Sep 2025 08:48:05 +0200 (CEST)
Date: Fri, 19 Sep 2025 08:48:00 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: syzbot <syzbot+3815dce0acab6c55984e@syzkaller.appspotmail.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Hillf Danton <hdanton@sina.com>
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev,
	pc@manguebit.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfs?] INFO: task hung in vfs_utimes (3)
Message-ID: <20250919064800.GA20476@redhat.com>
References: <68cb3c24.050a0220.50883.0028.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68cb3c24.050a0220.50883.0028.GAE@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Dominique,

according to

	https://lore.kernel.org/all/20250919021852.7157-1-hdanton@sina.com/
	https://lore.kernel.org/all/68ccc372.050a0220.28a605.0016.GAE@google.com/

this is yet another issue seems to be fixed by

	[PATCH] 9p/trans_fd: p9_fd_request: kick rx thread if EPOLLIN
	https://lore.kernel.org/all/20250819161013.GB11345@redhat.com/

are you going to apply it?

Hillf, thanks a lot!

Oleg.

On 09/17, syzbot wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    46a51f4f5eda Merge tag 'for-v6.17-rc' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=144cce42580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8f01d8629880e620
> dashboard link: https://syzkaller.appspot.com/bug?extid=3815dce0acab6c55984e
> compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17692f62580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1361f47c580000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/c4f63dbf3edb/disk-46a51f4f.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/b110f6d26eda/vmlinux-46a51f4f.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/a0b5f2118cec/bzImage-46a51f4f.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3815dce0acab6c55984e@syzkaller.appspotmail.com
>
> INFO: task syz.0.17:6022 blocked for more than 143 seconds.
>       Not tainted syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz.0.17        state:D stack:28976 pid:6022  tgid:6020  ppid:5973   task_flags:0x400040 flags:0x00004004
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5357 [inline]
>  __schedule+0x1190/0x5de0 kernel/sched/core.c:6961
>  __schedule_loop kernel/sched/core.c:7043 [inline]
>  schedule+0xe7/0x3a0 kernel/sched/core.c:7058
>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7115
>  rwsem_down_write_slowpath+0x524/0x1310 kernel/locking/rwsem.c:1185
>  __down_write_common kernel/locking/rwsem.c:1317 [inline]
>  __down_write kernel/locking/rwsem.c:1326 [inline]
>  down_write+0x1d6/0x200 kernel/locking/rwsem.c:1591
>  inode_lock include/linux/fs.h:870 [inline]
>  vfs_utimes+0x3b7/0x820 fs/utimes.c:65
>  do_utimes_path fs/utimes.c:99 [inline]
>  do_utimes fs/utimes.c:140 [inline]
>  __do_sys_utime fs/utimes.c:221 [inline]
>  __se_sys_utime fs/utimes.c:210 [inline]
>  __x64_sys_utime+0x1e2/0x2c0 fs/utimes.c:210
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fabd158eba9
> RSP: 002b:00007fabd0bdd038 EFLAGS: 00000246 ORIG_RAX: 0000000000000084
> RAX: ffffffffffffffda RBX: 00007fabd17d6090 RCX: 00007fabd158eba9
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00002000000000c0
> RBP: 00007fabd1611e19 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fabd17d6128 R14: 00007fabd17d6090 R15: 00007ffd32e714b8
>  </TASK>
>
> Showing all locks held in the system:
> 1 lock held by khungtaskd/31:
>  #0: ffffffff8e5c15a0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
>  #0: ffffffff8e5c15a0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
>  #0: ffffffff8e5c15a0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x36/0x1c0 kernel/locking/lockdep.c:6775
> 2 locks held by getty/5612:
>  #0: ffff88814d96d0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
>  #1: ffffc9000332b2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x41b/0x14f0 drivers/tty/n_tty.c:2222
> 2 locks held by syz.0.17/6021:
>  #0: ffff8880787b6428 (sb_writers#13){.+.+}-{0:0}, at: do_pwritev+0x1a6/0x270 fs/read_write.c:1153
>  #1: ffff88805bdb8148 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: netfs_start_io_direct+0x116/0x260 fs/netfs/locking.c:188
> 2 locks held by syz.0.17/6022:
>  #0: ffff8880787b6428 (sb_writers#13){.+.+}-{0:0}, at: vfs_utimes+0x69b/0x820 fs/utimes.c:36
>  #1: ffff88805bdb8148 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: inode_lock include/linux/fs.h:870 [inline]
>  #1: ffff88805bdb8148 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: vfs_utimes+0x3b7/0x820 fs/utimes.c:65
> 2 locks held by syz.1.18/6047:
>  #0: ffff888074228428 (sb_writers#13){.+.+}-{0:0}, at: do_pwritev+0x1a6/0x270 fs/read_write.c:1153
>  #1: ffff88805bdb87b8 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: netfs_start_io_direct+0x116/0x260 fs/netfs/locking.c:188
> 2 locks held by syz.1.18/6049:
>  #0: ffff888074228428 (sb_writers#13){.+.+}-{0:0}, at: vfs_utimes+0x69b/0x820 fs/utimes.c:36
>  #1: ffff88805bdb87b8 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: inode_lock include/linux/fs.h:870 [inline]
>  #1: ffff88805bdb87b8 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: vfs_utimes+0x3b7/0x820 fs/utimes.c:65
> 2 locks held by syz.2.20/6077:
>  #0: ffff888032842428 (sb_writers#13){.+.+}-{0:0}, at: do_pwritev+0x1a6/0x270 fs/read_write.c:1153
>  #1: ffff88805f8c07b8 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: netfs_start_io_direct+0x116/0x260 fs/netfs/locking.c:188
> 2 locks held by syz.2.20/6079:
>  #0: ffff888032842428 (sb_writers#13){.+.+}-{0:0}, at: vfs_utimes+0x69b/0x820 fs/utimes.c:36
>  #1: ffff88805f8c07b8 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: inode_lock include/linux/fs.h:870 [inline]
>  #1: ffff88805f8c07b8 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: vfs_utimes+0x3b7/0x820 fs/utimes.c:65
> 2 locks held by syz.3.21/6103:
>  #0: ffff888078172428 (sb_writers#13){.+.+}-{0:0}, at: do_pwritev+0x1a6/0x270 fs/read_write.c:1153
>  #1: ffff88805bdb8e28 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: netfs_start_io_direct+0x116/0x260 fs/netfs/locking.c:188
> 2 locks held by syz.3.21/6104:
>  #0: ffff888078172428 (sb_writers#13){.+.+}-{0:0}, at: vfs_utimes+0x69b/0x820 fs/utimes.c:36
>  #1: ffff88805bdb8e28 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: inode_lock include/linux/fs.h:870 [inline]
>  #1: ffff88805bdb8e28 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: vfs_utimes+0x3b7/0x820 fs/utimes.c:65
> 2 locks held by syz.4.22/6133:
>  #0: ffff888076a00428 (sb_writers#13){.+.+}-{0:0}, at: do_pwritev+0x1a6/0x270 fs/read_write.c:1153
>  #1: ffff88805bdb9498 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: netfs_start_io_direct+0x116/0x260 fs/netfs/locking.c:188
> 2 locks held by syz.4.22/6134:
>  #0: ffff888076a00428 (sb_writers#13){.+.+}-{0:0}, at: vfs_utimes+0x69b/0x820 fs/utimes.c:36
>  #1: ffff88805bdb9498 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: inode_lock include/linux/fs.h:870 [inline]
>  #1: ffff88805bdb9498 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: vfs_utimes+0x3b7/0x820 fs/utimes.c:65
> 2 locks held by syz.5.23/6168:
>  #0: ffff88806b6da428 (sb_writers#13){.+.+}-{0:0}, at: do_pwritev+0x1a6/0x270 fs/read_write.c:1153
>  #1: ffff88805bdb9b08 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: netfs_start_io_direct+0x116/0x260 fs/netfs/locking.c:188
> 2 locks held by syz.5.23/6169:
>  #0: ffff88806b6da428 (sb_writers#13){.+.+}-{0:0}, at: vfs_utimes+0x69b/0x820 fs/utimes.c:36
>  #1: ffff88805bdb9b08 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: inode_lock include/linux/fs.h:870 [inline]
>  #1: ffff88805bdb9b08 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: vfs_utimes+0x3b7/0x820 fs/utimes.c:65
> 2 locks held by syz.6.26/6203:
>  #0: ffff888059288428 (sb_writers#13){.+.+}-{0:0}, at: do_pwritev+0x1a6/0x270 fs/read_write.c:1153
>  #1: ffff88805bdba178 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: netfs_start_io_direct+0x116/0x260 fs/netfs/locking.c:188
> 2 locks held by syz.6.26/6204:
>  #0: ffff888059288428 (sb_writers#13){.+.+}-{0:0}, at: vfs_utimes+0x69b/0x820 fs/utimes.c:36
>  #1: ffff88805bdba178 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: inode_lock include/linux/fs.h:870 [inline]
>  #1: ffff88805bdba178 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: vfs_utimes+0x3b7/0x820 fs/utimes.c:65
> 2 locks held by syz.7.27/6232:
>  #0: ffff88805cc2a428 (sb_writers#13){.+.+}-{0:0}, at: do_pwritev+0x1a6/0x270 fs/read_write.c:1153
>  #1: ffff88805f8c1b08 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: netfs_start_io_direct+0x116/0x260 fs/netfs/locking.c:188
> 2 locks held by syz.7.27/6234:
>  #0: ffff88805cc2a428 (sb_writers#13){.+.+}-{0:0}, at: vfs_utimes+0x69b/0x820 fs/utimes.c:36
>  #1: ffff88805f8c1b08 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: inode_lock include/linux/fs.h:870 [inline]
>  #1: ffff88805f8c1b08 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: vfs_utimes+0x3b7/0x820 fs/utimes.c:65
> 2 locks held by syz.8.28/6264:
>  #0: ffff88807b296428 (sb_writers#13){.+.+}-{0:0}, at: do_pwritev+0x1a6/0x270 fs/read_write.c:1153
>  #1: ffff88805bdba7e8 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: netfs_start_io_direct+0x116/0x260 fs/netfs/locking.c:188
> 2 locks held by syz.8.28/6265:
>  #0: ffff88807b296428 (sb_writers#13){.+.+}-{0:0}, at: vfs_utimes+0x69b/0x820 fs/utimes.c:36
>  #1: ffff88805bdba7e8 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: inode_lock include/linux/fs.h:870 [inline]
>  #1: ffff88805bdba7e8 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: vfs_utimes+0x3b7/0x820 fs/utimes.c:65
> 2 locks held by syz.9.29/6301:
>  #0: ffff88805912a428 (sb_writers#13){.+.+}-{0:0}, at: do_pwritev+0x1a6/0x270 fs/read_write.c:1153
>  #1: ffff88805f8c1498 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: netfs_start_io_direct+0x116/0x260 fs/netfs/locking.c:188
> 2 locks held by syz.9.29/6302:
>  #0: ffff88805912a428 (sb_writers#13){.+.+}-{0:0}, at: vfs_utimes+0x69b/0x820 fs/utimes.c:36
>  #1: ffff88805f8c1498 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: inode_lock include/linux/fs.h:870 [inline]
>  #1: ffff88805f8c1498 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: vfs_utimes+0x3b7/0x820 fs/utimes.c:65
>
> =============================================
>
> NMI backtrace for cpu 0
> CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>  nmi_cpu_backtrace+0x27b/0x390 lib/nmi_backtrace.c:113
>  nmi_trigger_cpumask_backtrace+0x29c/0x300 lib/nmi_backtrace.c:62
>  trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
>  check_hung_uninterruptible_tasks kernel/hung_task.c:328 [inline]
>  watchdog+0xf0e/0x1260 kernel/hung_task.c:491
>  kthread+0x3c2/0x780 kernel/kthread.c:463
>  ret_from_fork+0x56a/0x730 arch/x86/kernel/process.c:148
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
> Sending NMI from CPU 0 to CPUs 1:
> NMI backtrace for cpu 1
> CPU: 1 UID: 0 PID: 49 Comm: kworker/u8:3 Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
> Workqueue: bat_events batadv_nc_worker
> RIP: 0010:iterate_chain_key kernel/locking/lockdep.c:451 [inline]
> RIP: 0010:__lock_acquire+0x642/0x1ce0 kernel/locking/lockdep.c:5225
> Code: 08 45 85 d2 0f 85 6f 04 00 00 4c 89 e7 89 4c 24 08 e8 92 ac ff ff 8b 4c 24 08 48 83 78 40 00 0f 84 c2 0a 00 00 0f b7 44 24 10 <8b> 7c 24 28 44 8b 74 24 20 c1 e0 0d 66 0b 04 24 98 29 f8 8b 7c 24
> RSP: 0018:ffffc90000b97958 EFLAGS: 00000086
> RAX: 0000000000000700 RBX: ffff888022ae2f30 RCX: 00000000748bd351
> RDX: 0000000000000000 RSI: ffff888022ae2f80 RDI: ffff888022ae2f80
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
> R10: 0000000000000002 R11: 0000000000000000 R12: ffff888022ae2f80
> R13: ffff888022ae2440 R14: 0000000000000002 R15: 0000000000000003
> FS:  0000000000000000(0000) GS:ffff8881247b2000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055fb93cf9be0 CR3: 000000000e380000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  lock_acquire kernel/locking/lockdep.c:5868 [inline]
>  lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5825
>  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
>  _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
>  spin_lock_bh include/linux/spinlock.h:356 [inline]
>  batadv_nc_purge_paths+0xd9/0x3a0 net/batman-adv/network-coding.c:442
>  batadv_nc_worker+0x958/0x1030 net/batman-adv/network-coding.c:722
>  process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3236
>  process_scheduled_works kernel/workqueue.c:3319 [inline]
>  worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
>  kthread+0x3c2/0x780 kernel/kthread.c:463
>  ret_from_fork+0x56a/0x730 arch/x86/kernel/process.c:148
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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


