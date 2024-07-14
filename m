Return-Path: <linux-fsdevel+bounces-23646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAF9930B5A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Jul 2024 21:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC5F6B212AC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Jul 2024 19:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E252213C9C0;
	Sun, 14 Jul 2024 19:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="dT3qRkeK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89B213BAE2
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jul 2024 19:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720985667; cv=none; b=YRbM43zJ99JTnK3jy79+82S7lAyAvTYqY8hejbZVWaxnsiUJ3RSMJ4q/A+v1FGXih0GCD8yr/LtDbjfHtBBMNEo20hzwW8+G21//kpYzdzsDnORk3Szg9Oc0tnepCv+kEEpVcCO1RD8/vflLOIWxWS5hIhfLlqbr8xPg3zjjZd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720985667; c=relaxed/simple;
	bh=M87rrktCHY7ghhsSswI4T1DoWNIiUEx81cbb38bY5aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGXTjMrUPKKizVbYgks80Ly9SvxyTi4fMjb3/scdNUqniCD/XN9vgYdpRoHvCyd3IqJAfgYIBeV5PNV2j5msPv10FJHMBpcyxjloxuZRrH2ZezdDtC4Upd/yeNpcZhG5H9hBtLuE4CIpM7b91nSa3UFlniUnG++9ZrIPcglt0hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=dT3qRkeK; arc=none smtp.client-ip=185.125.25.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WMb9w4V8NzDD7;
	Sun, 14 Jul 2024 21:34:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1720985652;
	bh=K31st2qlqWJi+cy7FgRVcUlfoX1RhYvk1QYxVEuqOUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dT3qRkeKGq56bt9kV3Qstlrq22PAo5PeK2fYHLXD/IRoR9V0R2eAfUGJZOA3lPoLy
	 iIYTgtY16vjW+FXeO0NRwEjAhXkUxPeIGhop+M0XpWhOeusW5XKYKlLSG/hb51hJ6O
	 fTcQJ4HoEwQqXvY6SeqxgjHwMmXuuWFq++s4cBTY=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WMb9v1hMczv4r;
	Sun, 14 Jul 2024 21:34:11 +0200 (CEST)
Date: Sun, 14 Jul 2024 21:34:01 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Brian Foster <bfoster@redhat.com>, 
	linux-bcachefs@vger.kernel.org
Cc: syzbot <syzbot+34b68f850391452207df@syzkaller.appspotmail.com>, 
	gnoack@google.com, jmorris@namei.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, serge@hallyn.com, syzkaller-bugs@googlegroups.com, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [syzbot] [lsm?] WARNING in current_check_refer_path - bcachefs
 bug
Message-ID: <20240714.iaDuNgieR9Qu@digikod.net>
References: <000000000000a65b35061cffca61@google.com>
 <CAHC9VhT_XpUeaxtkz0+4+YbWgK6=NDeDQikmPVYZ=RXDt+NOgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhT_XpUeaxtkz0+4+YbWgK6=NDeDQikmPVYZ=RXDt+NOgw@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Fri, Jul 12, 2024 at 10:55:11AM -0400, Paul Moore wrote:
> On Thu, Jul 11, 2024 at 5:53 PM syzbot
> <syzbot+34b68f850391452207df@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    8a03d70c27fc Merge remote-tracking branch 'tglx/devmsi-arm..
> > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> > console output: https://syzkaller.appspot.com/x/log.txt?x=174b0e6e980000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=15349546db652fd3
> > dashboard link: https://syzkaller.appspot.com/bug?extid=34b68f850391452207df
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > userspace arch: arm64
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13cd1b69980000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12667fd1980000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/efb354033e75/disk-8a03d70c.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/c747c205d094/vmlinux-8a03d70c.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/5641f4fb7265/Image-8a03d70c.gz.xz
> > mounted in repro: https://storage.googleapis.com/syzbot-assets/4e4d1faacdef/mount_0.gz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+34b68f850391452207df@syzkaller.appspotmail.com
> >
> > bcachefs (loop0): resume_logged_ops... done
> > bcachefs (loop0): delete_dead_inodes... done
> > bcachefs (loop0): done starting filesystem
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 6284 at security/landlock/fs.c:971 current_check_refer_path+0x4e0/0xaa8 security/landlock/fs.c:1132
> 
> I'll let Mickaël answer this for certain, but based on a quick look it
> appears that the fs object being moved has a umode_t that Landlock is
> not setup to handle?

syzbot found an issue with bcachefs: in some cases umode_t is invalid (i.e.
a weird file).

Kend, Brian, you'll find the incorrect filesystem with syzbot's report.
Could you please investigate the issue?

Here is the content of the file system:
# losetup --find --show mount_0
/dev/loop0
# mount /dev/loop0 /mnt/
# ls -la /mnt/
ls: cannot access '/mnt/file2': No such file or directory
ls: cannot access '/mnt/file3': No such file or directory
total 24
drwxr-xr-x 4 root root   0 May  2 20:21 .
drwxr-xr-x 1 root root 130 Oct 31  2023 ..
drwxr-xr-x 2 root root   0 May  2 20:21 file0
?rwxr-xr-x 1 root root  10 May  2 20:21 file1
-????????? ? ?    ?      ?            ? file2
-????????? ? ?    ?      ?            ? file3
-rwxr-xr-x 1 root root 100 May  2 20:21 file.cold
drwx------ 2 root root   0 May  2 20:21 lost+found
# stat /mnt/file1
  File: /mnt/file1
  Size: 10              Blocks: 8          IO Block: 4096   weird file
Device: 7,0     Inode: 1073741824  Links: 1
Access: (0755/?rwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2024-05-02 20:21:07.747039697 +0000
Modify: 2024-05-02 20:21:07.747039697 +0000
Change: 2024-05-02 20:21:07.747039697 +0000
 Birth: 2024-05-02 20:21:07.747039697 +0000

dmesg:
bcachefs (loop0): mounting version 1.7: mi_btree_bitmap opts=compression=lz4,nojournal_transaction_names
bcachefs (loop0): recovering from clean shutdown, journal seq 7
bcachefs (loop0): alloc_read... done
bcachefs (loop0): stripes_read... done
bcachefs (loop0): snapshots_read... done
bcachefs (loop0): going read-write
bcachefs (loop0): journal_replay... done
bcachefs (loop0): resume_logged_ops... done
bcachefs (loop0): delete_dead_inodes... done
bcachefs (loop0): dirent to missing inode:
  u64s 7 type dirent 4096:5067489913167654073:U32_MAX len 0 ver 0: file2 -> 4098 type reg
bcachefs (loop0): inconsistency detected - emergency read only at journal seq 11
bcachefs (loop0): dirent to missing inode:
  u64s 7 type dirent 4096:5868742249271439647:U32_MAX len 0 ver 0:

> 
> > Modules linked in:
> > CPU: 0 PID: 6284 Comm: syz-executor169 Not tainted 6.10.0-rc6-syzkaller-g8a03d70c27fc #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
> > pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > pc : current_check_refer_path+0x4e0/0xaa8 security/landlock/fs.c:1132
> > lr : get_mode_access security/landlock/fs.c:953 [inline]
> > lr : current_check_refer_path+0x4dc/0xaa8 security/landlock/fs.c:1132
> > sp : ffff80009bb47840
> > x29: ffff80009bb47980 x28: ffff80009bb478e0 x27: 0000000000000001
> > x26: 1fffe0001b7a831f x25: ffff0000d713ef00 x24: ffff700013768f14
> > x23: 000000000000f1ed x22: dfff800000000000 x21: ffff0000dbd418f8
> > x20: 0000000000000000 x19: 0000000000001fff x18: ffff80009bb46be0
> > x17: ffff800080b8363c x16: ffff80008afaca80 x15: 0000000000000004
> > x14: 1ffff00013768f24 x13: 0000000000000000 x12: 0000000000000000
> > x11: ffff700013768f28 x10: 0000000000ff0100 x9 : 0000000000000000
> > x8 : ffff0000d6845ac0 x7 : 0000000000000000 x6 : 0000000000000000
> > x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000020
> > x2 : 0000000000000000 x1 : 000000000000f1ed x0 : 000000000000d000
> > Call trace:
> >  current_check_refer_path+0x4e0/0xaa8 security/landlock/fs.c:1132
> >  hook_path_rename+0x4c/0x60 security/landlock/fs.c:1416
> >  security_path_rename+0x154/0x1f0 security/security.c:1918
> >  do_renameat2+0x724/0xe40 fs/namei.c:5031
> >  __do_sys_renameat2 fs/namei.c:5078 [inline]
> >  __se_sys_renameat2 fs/namei.c:5075 [inline]
> >  __arm64_sys_renameat2+0xe0/0xfc fs/namei.c:5075
> >  __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
> >  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
> >  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:131
> >  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:150
> >  el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
> >  el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
> >  el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
> > irq event stamp: 67226
> > hardirqs last  enabled at (67225): [<ffff80008b1683b4>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
> > hardirqs last  enabled at (67225): [<ffff80008b1683b4>] _raw_spin_unlock_irqrestore+0x38/0x98 kernel/locking/spinlock.c:194
> > hardirqs last disabled at (67226): [<ffff80008b06e498>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:470
> > softirqs last  enabled at (66914): [<ffff8000800307e0>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
> > softirqs last disabled at (66912): [<ffff8000800307ac>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
> > ---[ end trace 0000000000000000 ]---
> 
> -- 
> paul-moore.com
> 

