Return-Path: <linux-fsdevel+bounces-16175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD69899B96
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 13:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9616286F2C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 11:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F132F16C684;
	Fri,  5 Apr 2024 11:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UE+Va/cP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BFF16C42D;
	Fri,  5 Apr 2024 11:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712315166; cv=none; b=qNuYH98u7x3jePX18psmaaJQM3y+oQZ89ZYDkhiuz9sH8J6RMe9daOaRVpfO7f54607gd8b92rmCVy9Zej0Iey52e4sKz1I97wyNxwOiJRWq2E5GAR52mAoqMOK4ah60bVkryBla96Y1ws13SRRKDWFVjbafJRwX1nn8C8cwtOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712315166; c=relaxed/simple;
	bh=S8tJp9tlrFrniCs2F68u2zvpKyZISH6tFt+bDbVN8hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PnqraPhLCXAT93RDYnbskfaRh4bfY8EDH1RAfur6dqMVuj8H9JYsjMhXPwbBgbQ29Rd15NCg7TkNffXk7ZwlvKOWeGKAS0E/fSwuDpLYwcvk5hIP6b9eGiFbKxQLn3cdyJzSgkLhQNjPr5z9/ZuzSwoAgS7E/onVMuKJ8gnWk9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UE+Va/cP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C53C43390;
	Fri,  5 Apr 2024 11:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712315165;
	bh=S8tJp9tlrFrniCs2F68u2zvpKyZISH6tFt+bDbVN8hU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UE+Va/cPmg/8gSlj/HbF6tCZHY5b5oYJ8nlvAqXk7stNJeGHPY/GGbQsRVDXOqSgm
	 cM2/tWVi/BrUwO85C5B5SaPfPqiayXkHiEzVy0iB6rWBmV7lGiFPfDorJ0Lu+ig+6y
	 A62+ETPUXMCqjDkDVE6dnXj839ESQ3DRA/xBFkrG19nd9mUtcxj1uMU/Z+f920FJwh
	 JR90VgC4W7VkOQqt3MuH+aNFRTdz9vERhRN1WoctQ6SqH++Kp9Ge2oldQYrJpGI3eh
	 op0zs0pMcs0ok2k/zIQYa6Y74gEb2Gug+yrflyJelCzzwZXV4GOZ0nnS+Rzgs9sa5D
	 +1uW+re1V0p8Q==
Date: Fri, 5 Apr 2024 13:05:59 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>, gregkh@linuxfoundation.org, 
	konishi.ryusuke@gmail.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org, 
	viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [nilfs?] KASAN: slab-out-of-bounds Read in wb_writeback
Message-ID: <20240405-heilbad-eisbrecher-cd0cbc27f36f@brauner>
References: <000000000000fd0f2a061506cc93@google.com>
 <00000000000003b8c406151e0fd1@google.com>
 <20240403094717.zex45tc2kpkfelny@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240403094717.zex45tc2kpkfelny@quack3>

On Wed, Apr 03, 2024 at 11:47:17AM +0200, Jan Kara wrote:
> On Tue 02-04-24 07:38:25, syzbot wrote:
> > syzbot has found a reproducer for the following issue on:
> > 
> > HEAD commit:    c0b832517f62 Add linux-next specific files for 20240402
> > git tree:       linux-next
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=14af7dd9180000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=afcaf46d374cec8c
> > dashboard link: https://syzkaller.appspot.com/bug?extid=7b219b86935220db6dd8
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1729f003180000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17fa4341180000
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/0d36ec76edc7/disk-c0b83251.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/6f9bb4e37dd0/vmlinux-c0b83251.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/2349287b14b7/bzImage-c0b83251.xz
> > mounted in repro: https://storage.googleapis.com/syzbot-assets/9760c52a227c/mount_0.gz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+7b219b86935220db6dd8@syzkaller.appspotmail.com
> > 
> > ==================================================================
> > BUG: KASAN: slab-out-of-bounds in __lock_acquire+0x78/0x1fd0 kernel/locking/lockdep.c:5005
> > Read of size 8 at addr ffff888020485fa8 by task kworker/u8:2/35
> 
> Looks like the writeback cleanups are causing some use-after-free issues.
> The code KASAN is complaining about is:
> 
> 		/*
> 		 * Nothing written. Wait for some inode to
> 		 * become available for writeback. Otherwise
> 		 * we'll just busyloop.
> 		 */
> 		trace_writeback_wait(wb, work);
> 		inode = wb_inode(wb->b_more_io.prev);
> >>>>>		spin_lock(&inode->i_lock); <<<<<<
> 		spin_unlock(&wb->list_lock);
> 		/* This function drops i_lock... */
> 		inode_sleep_on_writeback(inode);
> 
> in wb_writeback(). Now looking at the changes indeed the commit
> 167d6693deb ("fs/writeback: bail out if there is no more inodes for IO and
> queued once") is buggy because it will result in trying to fetch 'inode'
> from empty b_more_io list and thus we'll corrupt memory. I think instead of
> modifying the condition:
> 
> 		if (list_empty(&wb->b_more_io)) {
> 
> we should do:
> 
> -		if (progress) {
> +		if (progress || !queued) {
>                         spin_unlock(&wb->list_lock);
>                         continue;
>                 }
> 
> Kemeng?

Fwiw, I observed this on xfstest too the last few days and tracked it
down to this series. Here's the splat I got in case it helps:

Apr 05 00:33:06 localhost kernel: ==================================================================
Apr 05 00:33:06 localhost kernel: BUG: KASAN: slab-out-of-bounds in __lock_acquire.isra.0+0x1075/0x1280
Apr 05 00:33:06 localhost kernel: Read of size 8 at addr ffff88810ed40f48 by task kworker/u128:2/305560
Apr 05 00:33:06 localhost kernel:
Apr 05 00:33:06 localhost kernel: CPU: 5 PID: 305560 Comm: kworker/u128:2 Not tainted 99.9.0-rc2-gdebeafad51e2 #262
Apr 05 00:33:06 localhost kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009)/Incus, BIOS unknown 2/2/2022
Apr 05 00:33:06 localhost kernel: Workqueue: writeback wb_workfn (flush-259:0)
Apr 05 00:33:06 localhost kernel: Call Trace:
Apr 05 00:33:06 localhost kernel:  <TASK>
Apr 05 00:33:06 localhost kernel:  dump_stack_lvl+0x5a/0x90
Apr 05 00:33:06 localhost kernel:  print_report+0xce/0x650
Apr 05 00:33:06 localhost kernel:  ? __virt_addr_valid+0x217/0x320
Apr 05 00:33:06 localhost kernel:  kasan_report+0xd7/0x110
Apr 05 00:33:06 localhost kernel:  ? __lock_acquire.isra.0+0x1075/0x1280
Apr 05 00:33:06 localhost kernel:  ? __lock_acquire.isra.0+0x1075/0x1280
Apr 05 00:33:06 localhost kernel:  __lock_acquire.isra.0+0x1075/0x1280
Apr 05 00:33:06 localhost kernel:  lock_acquire+0x136/0x330
Apr 05 00:33:06 localhost kernel:  ? wb_writeback+0x255/0x870
Apr 05 00:33:06 localhost kernel:  _raw_spin_lock+0x33/0x40
Apr 05 00:33:06 localhost kernel:  ? wb_writeback+0x255/0x870
Apr 05 00:33:06 localhost kernel:  wb_writeback+0x255/0x870
Apr 05 00:33:06 localhost kernel:  ? __pfx_wb_writeback+0x10/0x10
Apr 05 00:33:06 localhost kernel:  ? __pfx_lock_release+0x10/0x10
Apr 05 00:33:06 localhost kernel:  wb_workfn+0x221/0xc80
Apr 05 00:33:06 localhost kernel:  ? __pfx_wb_workfn+0x10/0x10
Apr 05 00:33:06 localhost kernel:  ? lock_acquire+0x136/0x330
Apr 05 00:33:06 localhost kernel:  process_one_work+0x82d/0x1790
Apr 05 00:33:06 localhost kernel:  ? __pfx_process_one_work+0x10/0x10
Apr 05 00:33:06 localhost kernel:  ? assign_work+0x16c/0x240
Apr 05 00:33:06 localhost kernel:  worker_thread+0x724/0x1300
Apr 05 00:33:06 localhost kernel:  ? __kthread_parkme+0xba/0x1f0
Apr 05 00:33:06 localhost kernel:  ? __pfx_worker_thread+0x10/0x10
Apr 05 00:33:06 localhost kernel:  kthread+0x2ed/0x3d0
Apr 05 00:33:06 localhost kernel:  ? __pfx_kthread+0x10/0x10
Apr 05 00:33:06 localhost kernel:  ret_from_fork+0x31/0x70
Apr 05 00:33:06 localhost kernel:  ? __pfx_kthread+0x10/0x10
Apr 05 00:33:06 localhost kernel:  ret_from_fork_asm+0x1a/0x30
Apr 05 00:33:06 localhost kernel:  </TASK>
Apr 05 00:33:06 localhost kernel:
Apr 05 00:33:06 localhost kernel: Allocated by task 1:
Apr 05 00:33:06 localhost kernel:  kasan_save_stack+0x33/0x60
Apr 05 00:33:06 localhost kernel:  kasan_save_track+0x14/0x30
Apr 05 00:33:06 localhost kernel:  __kasan_kmalloc+0xaa/0xb0
Apr 05 00:33:06 localhost kernel:  psi_cgroup_alloc+0x57/0x2b0
Apr 05 00:33:06 localhost kernel:  cgroup_mkdir+0x4f8/0xfb0
Apr 05 00:33:06 localhost kernel:  kernfs_iop_mkdir+0x133/0x1c0
Apr 05 00:33:06 localhost kernel:  vfs_mkdir+0x3b9/0x610
Apr 05 00:33:06 localhost kernel:  do_mkdirat+0x27e/0x300
Apr 05 00:33:06 localhost kernel:  __x64_sys_mkdir+0x65/0x80
Apr 05 00:33:06 localhost kernel:  do_syscall_64+0x64/0x190
Apr 05 00:33:06 localhost kernel:  entry_SYSCALL_64_after_hwframe+0x71/0x79
Apr 05 00:33:06 localhost kernel:
Apr 05 00:33:06 localhost kernel: Last potentially related work creation:
Apr 05 00:33:06 localhost kernel:  kasan_save_stack+0x33/0x60
Apr 05 00:33:06 localhost kernel:  __kasan_record_aux_stack+0xad/0xc0
Apr 05 00:33:06 localhost kernel:  insert_work+0x32/0x1f0
Apr 05 00:33:06 localhost kernel:  __queue_work+0x5cb/0xcb0
Apr 05 00:33:06 localhost kernel:  call_timer_fn+0x16d/0x490
Apr 05 00:33:06 localhost kernel:  __run_timers+0x488/0x980
Apr 05 00:33:06 localhost kernel:  run_timer_base+0xfb/0x170
Apr 05 00:33:06 localhost kernel:  run_timer_softirq+0x1a/0x30
Apr 05 00:33:06 localhost kernel:  __do_softirq+0x26a/0x7d2
Apr 05 00:33:06 localhost kernel:
Apr 05 00:33:06 localhost kernel: Second to last potentially related work creation:
Apr 05 00:33:06 localhost kernel:  kasan_save_stack+0x33/0x60
Apr 05 00:33:06 localhost kernel:  __kasan_record_aux_stack+0xad/0xc0
Apr 05 00:33:06 localhost kernel:  insert_work+0x32/0x1f0
Apr 05 00:33:06 localhost kernel:  __queue_work+0x5cb/0xcb0
Apr 05 00:33:06 localhost kernel:  call_timer_fn+0x16d/0x490
Apr 05 00:33:06 localhost kernel:  __run_timers+0x488/0x980
Apr 05 00:33:06 localhost kernel:  timer_expire_remote+0xe6/0x150
Apr 05 00:33:06 localhost kernel:  tmigr_handle_remote+0x6e2/0xe00
Apr 05 00:33:06 localhost kernel:  __do_softirq+0x26a/0x7d2
Apr 05 00:33:06 localhost kernel:
Apr 05 00:33:06 localhost kernel: The buggy address belongs to the object at ffff88810ed40000
                                   which belongs to the cache kmalloc-2k of size 2048
Apr 05 00:33:06 localhost kernel: The buggy address is located 2792 bytes to the right of
                                   allocated 1120-byte region [ffff88810ed40000, ffff88810ed40460)
Apr 05 00:33:06 localhost kernel:
Apr 05 00:33:06 localhost kernel: The buggy address belongs to the physical page:
Apr 05 00:33:06 localhost kernel: page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88810ed45000 pfn:0x10ed40
Apr 05 00:33:06 localhost kernel: head: order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
Apr 05 00:33:06 localhost kernel: flags: 0x200000000000840(slab|head|node=0|zone=2)
Apr 05 00:33:06 localhost kernel: page_type: 0xffffffff()
Apr 05 00:33:06 localhost kernel: raw: 0200000000000840 ffff888100042f00 ffffea00040f1a00 dead000000000002
Apr 05 00:33:06 localhost kernel: raw: ffff88810ed45000 0000000080080006 00000001ffffffff 0000000000000000
Apr 05 00:33:06 localhost kernel: head: 0200000000000840 ffff888100042f00 ffffea00040f1a00 dead000000000002
Apr 05 00:33:06 localhost kernel: head: ffff88810ed45000 0000000080080006 00000001ffffffff 0000000000000000
Apr 05 00:33:06 localhost kernel: head: 0200000000000003 ffffea00043b5001 dead000000000122 00000000ffffffff
Apr 05 00:33:06 localhost kernel: head: 0000000800000000 0000000000000000 00000000ffffffff 0000000000000000
Apr 05 00:33:06 localhost kernel: page dumped because: kasan: bad access detected
Apr 05 00:33:06 localhost kernel:
Apr 05 00:33:06 localhost kernel: Memory state around the buggy address:
Apr 05 00:33:06 localhost kernel:  ffff88810ed40e00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
Apr 05 00:33:06 localhost kernel:  ffff88810ed40e80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
Apr 05 00:33:06 localhost kernel: >ffff88810ed40f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
Apr 05 00:33:06 localhost kernel:                                               ^
Apr 05 00:33:06 localhost kernel:  ffff88810ed40f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
Apr 05 00:33:06 localhost kernel:  ffff88810ed41000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Apr 05 00:33:06 localhost kernel: ==================================================================
Apr 05 00:33:06 localhost kernel: Disabling lock debugging due to kernel taint
Apr 05 00:33:06 localhost kernel: INFO: trying to register non-static key.
Apr 05 00:33:06 localhost kernel: The code is fine but needs lockdep annotation, or maybe
Apr 05 00:33:06 localhost kernel: you didn't initialize this object before use?
Apr 05 00:33:06 localhost kernel: turning off the locking correctness validator.
Apr 05 00:33:06 localhost kernel: CPU: 5 PID: 305560 Comm: kworker/u128:2 Tainted: G    B              99.9.0-rc2-gdebeafad51e2 #262
Apr 05 00:33:06 localhost kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009)/Incus, BIOS unknown 2/2/2022
Apr 05 00:33:06 localhost kernel: Workqueue: writeback wb_workfn (flush-259:0)
Apr 05 00:33:06 localhost kernel: Call Trace:
Apr 05 00:33:06 localhost kernel:  <TASK>
Apr 05 00:33:06 localhost kernel:  dump_stack_lvl+0x5a/0x90
Apr 05 00:33:06 localhost kernel:  register_lock_class+0x11dd/0x1860
Apr 05 00:33:06 localhost kernel:  ? add_taint+0x2a/0x90
Apr 05 00:33:06 localhost kernel:  ? end_report+0x85/0x180
Apr 05 00:33:06 localhost kernel:  ? __pfx_register_lock_class+0x10/0x10
Apr 05 00:33:06 localhost kernel:  __lock_acquire.isra.0+0x7f/0x1280
Apr 05 00:33:06 localhost kernel:  lock_acquire+0x136/0x330
Apr 05 00:33:06 localhost kernel:  ? wb_writeback+0x255/0x870
Apr 05 00:33:06 localhost kernel:  _raw_spin_lock+0x33/0x40
Apr 05 00:33:06 localhost kernel:  ? wb_writeback+0x255/0x870
Apr 05 00:33:06 localhost kernel:  wb_writeback+0x255/0x870
Apr 05 00:33:06 localhost kernel:  ? __pfx_wb_writeback+0x10/0x10
Apr 05 00:33:06 localhost kernel:  ? __pfx_lock_release+0x10/0x10
Apr 05 00:33:06 localhost kernel:  wb_workfn+0x221/0xc80
Apr 05 00:33:06 localhost kernel:  ? __pfx_wb_workfn+0x10/0x10
Apr 05 00:33:06 localhost kernel:  ? lock_acquire+0x136/0x330
Apr 05 00:33:06 localhost kernel:  process_one_work+0x82d/0x1790
Apr 05 00:33:06 localhost kernel:  ? __pfx_process_one_work+0x10/0x10
Apr 05 00:33:06 localhost kernel:  ? assign_work+0x16c/0x240
Apr 05 00:33:06 localhost kernel:  worker_thread+0x724/0x1300
Apr 05 00:33:06 localhost kernel:  ? __kthread_parkme+0xba/0x1f0
Apr 05 00:33:06 localhost kernel:  ? __pfx_worker_thread+0x10/0x10
Apr 05 00:33:06 localhost kernel:  kthread+0x2ed/0x3d0
Apr 05 00:33:06 localhost kernel:  ? __pfx_kthread+0x10/0x10
Apr 05 00:33:06 localhost kernel:  ret_from_fork+0x31/0x70
Apr 05 00:33:06 localhost kernel:  ? __pfx_kthread+0x10/0x10
Apr 05 00:33:06 localhost kernel:  ret_from_fork_asm+0x1a/0x30
Apr 05 00:33:06 localhost kernel:  </TASK>

