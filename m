Return-Path: <linux-fsdevel+bounces-22628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4FC91A7EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 15:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EA061C20F3B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 13:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E43E193071;
	Thu, 27 Jun 2024 13:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="vXAWDIAj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFF31591F0
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 13:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719495294; cv=none; b=VpVXlaVzyqe77e0GPjaGdz/qUMuouXhA6jdoFU7NrGEBlP/f6fYqcf34xf/IfbKhgvsbhZh/2OtGHOiahMS1V+JKJiLqAAXADcNsiTYSGS5aDkGu6BtJcKHOF6sRCYqYa+o0aJfZif3HSpUswW7AZHqERkNyb4tPYWlHD0yDKUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719495294; c=relaxed/simple;
	bh=GvnoEkPpIGXBUknEyoZSNzDOn+ExFV+JY/tEqWuyGqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHLaTGv1EsifD1waP5+utXBMkd1eHqUqSk3fafDdi2cMXeRUDRvC2WeNpdwDbxvBQwuXGw7FYZph/DpX/TvbxquYK4XtaSiXIWKMRTRAhRCxKFVeNEh3kDy7caDgo+DlsH46PxwWE2BGt/Oycz5t+k3PgKBJIzV2HO4dFCh9dic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=vXAWDIAj; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4W900z1b40zh4D;
	Thu, 27 Jun 2024 15:34:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1719495283;
	bh=Ga5GBvk8RCDApCiWuXBfQjwbDd8BROsS5R5jAdhkXKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vXAWDIAjj0sYSNrY7XA7WLmHxOgtM8qPSs/eXn0dlvbBeJkVCEgp6wGkGk9YxRA6d
	 6Zyh22g1bwVYYZKkzDHwzXu9xRID19Y3NtJAal36yjZsgMGYtUC3RK+9oIKsiA4Jem
	 IHVTe6yK4idi1uv/FgG5m+US2V5YudGboc4M75HE=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4W900y4hngzrX8;
	Thu, 27 Jun 2024 15:34:42 +0200 (CEST)
Date: Thu, 27 Jun 2024 15:34:41 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>, Jann Horn <jannh@google.com>, 
	Christian Brauner <brauner@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Kees Cook <keescook@chromium.org>
Cc: syzbot <syzbot+5446fbf332b0602ede0b@syzkaller.appspotmail.com>, 
	jmorris@namei.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, serge@hallyn.com, syzkaller-bugs@googlegroups.com, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [syzbot] [lsm?] general protection fault in
 hook_inode_free_security
Message-ID: <20240627.Voox5yoogeum@digikod.net>
References: <00000000000076ba3b0617f65cc8@google.com>
 <CAHC9VhSmbAY8gX=Mh2OT-dkQt+W3xaa9q9LVWkP9q8pnMh+E_w@mail.gmail.com>
 <20240515.Yoo5chaiNai9@digikod.net>
 <20240516.doyox6Iengou@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240516.doyox6Iengou@digikod.net>
X-Infomaniak-Routing: alpha

I didn't find specific issues with Landlock's code except the extra
check in hook_inode_free_security().  It looks like inode->i_security is
a dangling pointer, leading to UAF.

Reading security_inode_free() comments, two things looks weird to me:
> /**
>  * security_inode_free() - Free an inode's LSM blob
>  * @inode: the inode
>  *
>  * Deallocate the inode security structure and set @inode->i_security to NULL.

I don't see where i_security is set to NULL.

>  */
> void security_inode_free(struct inode *inode)
> {

Shouldn't we add this check here?
if (!inode->i_security)
	return;

> 	call_void_hook(inode_free_security, inode);
> 	/*
> 	 * The inode may still be referenced in a path walk and
> 	 * a call to security_inode_permission() can be made
> 	 * after inode_free_security() is called. Ideally, the VFS
> 	 * wouldn't do this, but fixing that is a much harder
> 	 * job. For now, simply free the i_security via RCU, and
> 	 * leave the current inode->i_security pointer intact.
> 	 * The inode will be freed after the RCU grace period too.

It's not clear to me why this should be safe if an LSM try to use the
partially-freed blob after the hook calls and before the actual blob
free.

> 	 */
> 	if (inode->i_security)
> 		call_rcu((struct rcu_head *)inode->i_security,
> 			 inode_free_by_rcu);

And then:
inode->i_security = NULL;

But why call_rcu()?  i_security is not protected by RCU barriers.

> }


On Thu, May 16, 2024 at 09:31:21AM GMT, Mickaël Salaün wrote:
> Adding membarrier experts.
> 
> On Wed, May 15, 2024 at 05:12:58PM +0200, Mickaël Salaün wrote:
> > On Thu, May 09, 2024 at 08:01:49PM -0400, Paul Moore wrote:
> > > On Wed, May 8, 2024 at 3:32 PM syzbot
> > > <syzbot+5446fbf332b0602ede0b@syzkaller.appspotmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    dccb07f2914c Merge tag 'for-6.9-rc7-tag' of git://git.kern..
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=14a46760980000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=6d14c12b661fb43
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=5446fbf332b0602ede0b
> > > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > > >
> > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > >
> > > > Downloadable assets:
> > > > disk image: https://storage.googleapis.com/syzbot-assets/39d66018d8ad/disk-dccb07f2.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/c160b651d1bc/vmlinux-dccb07f2.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/3662a33ac713/bzImage-dccb07f2.xz
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > Reported-by: syzbot+5446fbf332b0602ede0b@syzkaller.appspotmail.com
> > > >
> > > > general protection fault, probably for non-canonical address 0xdffffc018f62f515: 0000 [#1] PREEMPT SMP KASAN NOPTI
> > > > KASAN: probably user-memory-access in range [0x0000000c7b17a8a8-0x0000000c7b17a8af]
> > > > CPU: 1 PID: 5102 Comm: syz-executor.1 Not tainted 6.9.0-rc7-syzkaller-00012-gdccb07f2914c #0
> > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
> > > > RIP: 0010:hook_inode_free_security+0x5b/0xb0 security/landlock/fs.c:1047
> > > 
> > > Possibly a Landlock issue, Mickaël?
> > 
> > It looks like security_inode_free() is called two times on the same
> > inode.  This could happen if an inode labeled by Landlock is put
> > concurrently with release_inode() for a closed ruleset or with
> > hook_sb_delete().  I didn't find any race condition that could lead to
> > two calls to iput() though.  Could WRITE_ONCE(object->underobj, NULL)
> > change anything even if object->lock is locked?

I don't think so anymore, the issue is with i_security, not the blob
content.

> > 
> > A bit unrelated but looking at the SELinux code, I see that selinux_inode()
> > checks `!inode->i_security`.  In which case could this happen?

I think this shouldn't happen, and that might actually be an issue for
SELinux.  See my above comment about security_free_inode().

> > 
> > > 
> > > > Code: 8a fd 48 8b 1b 48 c7 c0 c4 4e d5 8d 48 c1 e8 03 42 0f b6 04 30 84 c0 75 3e 48 63 05 33 59 65 09 48 01 c3 48 89 d8 48 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 df e8 66 be 8a fd 48 83 3b 00 75 0d e8
> > > > RSP: 0018:ffffc9000307f9a8 EFLAGS: 00010212
> > > > RAX: 000000018f62f515 RBX: 0000000c7b17a8a8 RCX: ffff888027668000
> > > > RDX: 0000000000000000 RSI: 0000000000000040 RDI: ffff88805c0bb270
> > > > RBP: ffffffff8c01fb00 R08: ffffffff82132a15 R09: 1ffff1100b81765f
> > > > R10: dffffc0000000000 R11: ffffffff846ff540 R12: dffffc0000000000
> > > > R13: 1ffff1100b817683 R14: dffffc0000000000 R15: dffffc0000000000
> > > > FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
> > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > CR2: 00007f43c42de000 CR3: 00000000635f8000 CR4: 0000000000350ef0
> > > > Call Trace:
> > > >  <TASK>
> > > >  security_inode_free+0x4a/0xd0 security/security.c:1613
> > > >  __destroy_inode+0x2d9/0x650 fs/inode.c:286
> > > >  destroy_inode fs/inode.c:309 [inline]
> > > >  evict+0x521/0x630 fs/inode.c:682
> > > >  dispose_list fs/inode.c:700 [inline]
> > > >  evict_inodes+0x5f9/0x690 fs/inode.c:750
> > > >  generic_shutdown_super+0x9d/0x2d0 fs/super.c:626
> > > >  kill_block_super+0x44/0x90 fs/super.c:1675
> > > >  deactivate_locked_super+0xc6/0x130 fs/super.c:472
> > > >  cleanup_mnt+0x426/0x4c0 fs/namespace.c:1267
> > > >  task_work_run+0x251/0x310 kernel/task_work.c:180
> > > >  exit_task_work include/linux/task_work.h:38 [inline]
> > > >  do_exit+0xa1b/0x27e0 kernel/exit.c:878
> > > >  do_group_exit+0x207/0x2c0 kernel/exit.c:1027
> > > >  __do_sys_exit_group kernel/exit.c:1038 [inline]
> > > >  __se_sys_exit_group kernel/exit.c:1036 [inline]
> > > >  __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1036
> > > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > > >  do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
> > > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > > RIP: 0033:0x7f731567dd69
> > > > Code: Unable to access opcode bytes at 0x7f731567dd3f.
> > > > RSP: 002b:00007fff4f0804d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> > > > RAX: ffffffffffffffda RBX: 00007f73156c93a3 RCX: 00007f731567dd69
> > > > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > > > RBP: 0000000000000002 R08: 00007fff4f07e277 R09: 00007fff4f081790
> > > > R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff4f081790
> > > > R13: 00007f73156c937e R14: 00000000000154d0 R15: 000000000000001e
> > > >  </TASK>
> > > > Modules linked in:
> > > > ---[ end trace 0000000000000000 ]---
> > > 
> > > -- 
> > > paul-moore.com
> > > 

