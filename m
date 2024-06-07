Return-Path: <linux-fsdevel+bounces-21202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A819004E8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 15:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1292D1F258B0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 13:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCF3198A0E;
	Fri,  7 Jun 2024 13:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNQCcyBk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E34B197A95;
	Fri,  7 Jun 2024 13:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717766926; cv=none; b=JRXfOiYP+fKfYgSbyAtPttqSYS7xAIWoNHt96ypuUHicyYHKZ5qCS7M0qlq/0/DyTcgL2DFen6aZtHxWmYEiq42S0xbEk29Urm/n//eC666Co43JsVB7uNkC482T99aUyCZcnir9cwxnEtEgInl7lc5ww+orWvLYFw53Rmx7P0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717766926; c=relaxed/simple;
	bh=TOkXUwMiFKI/YUlHmZVctr4CzCt3NHxwSyZ8+Tm40ik=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=T7CNkN22tnHE/JwbAKDky4aPlp5yY5vAa/ZNzGxL+E7I9lCM5EWuOD4+v8aVjowxatxkgcrFvBO0pkI/7DAnr9gscpeq99IMf8F+WbTst+X4fBP8IzuXI5BSK2oTz5wMVZX/In804cWR4OEQsurnUV96uicKB0Y2fJ4jS/P1jeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNQCcyBk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEEB6C4AF08;
	Fri,  7 Jun 2024 13:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717766926;
	bh=TOkXUwMiFKI/YUlHmZVctr4CzCt3NHxwSyZ8+Tm40ik=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=SNQCcyBkDkxK2buvXRVnoMMYPQAWjiqd0I0Yqsm6qADvYN/ddHOPvWtukqAdm2M1K
	 zQFsDpt12x5p8SKXarAbKax3eX29SjGNOfinBnpKbiePiKQoO85fGobO1k18kXAawG
	 avTh2dJqmhWOrRD2VYG1JZ1L9Fw0vkWONiL7N3tlFaadjUO29JM5OT0YXlM8B1zJ/d
	 CdwHVS/K7dZ80VHRz1pru7kJtu/wBQfieYgCcRFUwUSH2+0/Qw0dEqUSr3+tcPa69u
	 NWBwWme14RNciWFqPqvooc6O15KrgbXWSZWFSGtqE4YnWiUaTGMA7SCR0UcCwNukLX
	 tlnVIsias4kfg==
Message-ID: <1047e6db-0a9e-4e9e-a39b-e1bb55984f4e@kernel.org>
Date: Fri, 7 Jun 2024 21:28:43 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] possible deadlock in hfsplus_file_truncate
To: syzbot <syzbot+6030b3b1b9bf70e538c4@syzkaller.appspotmail.com>,
 syzkaller-bugs@googlegroups.com
References: <000000000000e37a4005ef129563@google.com>
Content-Language: en-US
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
From: Chao Yu <chao@kernel.org>
In-Reply-To: <000000000000e37a4005ef129563@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git misc

On 2022/12/5 18:59, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    0ba09b173387 Revert "mm: align larger anonymous mappings o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1517e983880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2325e409a9a893e1
> dashboard link: https://syzkaller.appspot.com/bug?extid=6030b3b1b9bf70e538c4
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b4d2cb880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d90fc3880000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/9758ec2c06f4/disk-0ba09b17.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/06781dbfd581/vmlinux-0ba09b17.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/3d44a22d15fa/bzImage-0ba09b17.xz
> mounted in repro #1: https://storage.googleapis.com/syzbot-assets/57266b2eb2c9/mount_0.gz
> mounted in repro #2: https://storage.googleapis.com/syzbot-assets/5f557bd13d34/mount_2.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+6030b3b1b9bf70e538c4@syzkaller.appspotmail.com
> 
> loop0: detected capacity change from 0 to 1024
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.1.0-rc7-syzkaller-00211-g0ba09b173387 #0 Not tainted
> ------------------------------------------------------
> syz-executor955/3635 is trying to acquire lock:
> ffff8880279780b0 (&tree->tree_lock){+.+.}-{3:3}, at: hfsplus_file_truncate+0x871/0xbb0 fs/hfsplus/extents.c:595
> 
> but task is already holding lock:
> ffff8880189a3708 (&HFSPLUS_I(inode)->extents_lock){+.+.}-{3:3}, at: hfsplus_file_truncate+0x280/0xbb0 fs/hfsplus/extents.c:576
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #1 (&HFSPLUS_I(inode)->extents_lock){+.+.}-{3:3}:
>         lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
>         __mutex_lock_common+0x1bd/0x26e0 kernel/locking/mutex.c:603
>         __mutex_lock kernel/locking/mutex.c:747 [inline]
>         mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
>         hfsplus_get_block+0x3a3/0x1560 fs/hfsplus/extents.c:260
>         block_read_full_folio+0x3b3/0xfa0 fs/buffer.c:2271
>         filemap_read_folio+0x187/0x7d0 mm/filemap.c:2407
>         do_read_cache_folio+0x2d3/0x790 mm/filemap.c:3534
>         do_read_cache_page mm/filemap.c:3576 [inline]
>         read_cache_page+0x56/0x270 mm/filemap.c:3585
>         read_mapping_page include/linux/pagemap.h:756 [inline]
>         __hfs_bnode_create+0x4d5/0x7f0 fs/hfsplus/bnode.c:440
>         hfsplus_bnode_find+0x23d/0xd80 fs/hfsplus/bnode.c:486
>         hfsplus_brec_find+0x145/0x520 fs/hfsplus/bfind.c:183
>         hfsplus_brec_read+0x27/0x100 fs/hfsplus/bfind.c:222
>         hfsplus_find_cat+0x168/0x6d0 fs/hfsplus/catalog.c:202
>         hfsplus_iget+0x402/0x630 fs/hfsplus/super.c:82
>         hfsplus_fill_super+0xc6a/0x1b50 fs/hfsplus/super.c:503
>         mount_bdev+0x26c/0x3a0 fs/super.c:1401
>         legacy_get_tree+0xea/0x180 fs/fs_context.c:610
>         vfs_get_tree+0x88/0x270 fs/super.c:1531
>         do_new_mount+0x289/0xad0 fs/namespace.c:3040
>         do_mount fs/namespace.c:3383 [inline]
>         __do_sys_mount fs/namespace.c:3591 [inline]
>         __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
>         do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>         do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>         entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> -> #0 (&tree->tree_lock){+.+.}-{3:3}:
>         check_prev_add kernel/locking/lockdep.c:3097 [inline]
>         check_prevs_add kernel/locking/lockdep.c:3216 [inline]
>         validate_chain+0x1898/0x6ae0 kernel/locking/lockdep.c:3831
>         __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
>         lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
>         __mutex_lock_common+0x1bd/0x26e0 kernel/locking/mutex.c:603
>         __mutex_lock kernel/locking/mutex.c:747 [inline]
>         mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
>         hfsplus_file_truncate+0x871/0xbb0 fs/hfsplus/extents.c:595
>         hfsplus_delete_inode+0x16d/0x210
>         hfsplus_unlink+0x4e2/0x7d0 fs/hfsplus/dir.c:405
>         hfsplus_rename+0xc3/0x1b0 fs/hfsplus/dir.c:547
>         vfs_rename+0xd53/0x1130 fs/namei.c:4779
>         do_renameat2+0xb53/0x1370 fs/namei.c:4930
>         __do_sys_rename fs/namei.c:4976 [inline]
>         __se_sys_rename fs/namei.c:4974 [inline]
>         __x64_sys_rename+0x82/0x90 fs/namei.c:4974
>         do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>         do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>         entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> other info that might help us debug this:
> 
>   Possible unsafe locking scenario:
> 
>         CPU0                    CPU1
>         ----                    ----
>    lock(&HFSPLUS_I(inode)->extents_lock);
>                                 lock(&tree->tree_lock);
>                                 lock(&HFSPLUS_I(inode)->extents_lock);
>    lock(&tree->tree_lock);
> 
>   *** DEADLOCK ***
> 
> 6 locks held by syz-executor955/3635:
>   #0: ffff888075a6c460 (sb_writers#9){.+.+}-{0:0}, at: mnt_want_write+0x3b/0x80 fs/namespace.c:393
>   #1: ffff8880189a2b80 (&type->i_mutex_dir_key#6/1){+.+.}-{3:3}, at: lock_rename+0x182/0x1a0
>   #2: ffff8880189a3240 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
>   #2: ffff8880189a3240 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: lock_two_nondirectories+0xdd/0x130 fs/inode.c:1121
>   #3: ffff8880189a3900 (&sb->s_type->i_mutex_key#15/4){+.+.}-{3:3}, at: vfs_rename+0x80a/0x1130 fs/namei.c:4749
>   #4: ffff888027abb198 (&sbi->vh_mutex){+.+.}-{3:3}, at: hfsplus_unlink+0x135/0x7d0 fs/hfsplus/dir.c:370
>   #5: ffff8880189a3708 (&HFSPLUS_I(inode)->extents_lock){+.+.}-{3:3}, at: hfsplus_file_truncate+0x280/0xbb0 fs/hfsplus/extents.c:576
> 
> stack backtrace:
> CPU: 1 PID: 3635 Comm: syz-executor955 Not tainted 6.1.0-rc7-syzkaller-00211-g0ba09b173387 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
>   check_noncircular+0x2cc/0x390 kernel/locking/lockdep.c:2177
>   check_prev_add kernel/locking/lockdep.c:3097 [inline]
>   check_prevs_add kernel/locking/lockdep.c:3216 [inline]
>   validate_chain+0x1898/0x6ae0 kernel/locking/lockdep.c:3831
>   __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
>   lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
>   __mutex_lock_common+0x1bd/0x26e0 kernel/locking/mutex.c:603
>   __mutex_lock kernel/locking/mutex.c:747 [inline]
>   mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
>   hfsplus_file_truncate+0x871/0xbb0 fs/hfsplus/extents.c:595
>   hfsplus_delete_inode+0x16d/0x210
>   hfsplus_unlink+0x4e2/0x7d0 fs/hfsplus/dir.c:405
>   hfsplus_rename+0xc3/0x1b0 fs/hfsplus/dir.c:547
>   vfs_rename+0xd53/0x1130 fs/namei.c:4779
>   do_renameat2+0xb53/0x1370 fs/namei.c:4930
>   __do_sys_rename fs/namei.c:4976 [inline]
>   __se_sys_rename fs/namei.c:4974 [inline]
>   __x64_sys_rename+0x82/0x90 fs/namei.c:4974
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f462a64f3f9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 41 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f462a5da2f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f462a64f3f9
> RDX: 0000000000000031 RSI: 00000000200001c0 RDI: 0000000020000180
> RBP: 00007f462a6d4798 R08: 0000000000000000 R09: 0000000000000000
> R10: 00000000000005fb R11: 0000000000000246 R12: 00007f462a6d4790
> R13: 736f706d6f636564 R14: 0030656c69662f2e R15: 0073756c70736668
>   </TASK>
> 


