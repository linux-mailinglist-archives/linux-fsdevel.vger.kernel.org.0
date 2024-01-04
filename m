Return-Path: <linux-fsdevel+bounces-7386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D8D8244C0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 16:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C4982860FC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 15:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0252F241F9;
	Thu,  4 Jan 2024 15:16:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9CD241E7;
	Thu,  4 Jan 2024 15:16:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC1BC433C7;
	Thu,  4 Jan 2024 15:16:12 +0000 (UTC)
Date: Thu, 4 Jan 2024 10:17:17 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: syzbot <syzbot+fd93e36ced1a43a58f75@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, bristot@redhat.com, bsegall@google.com,
 chouhan.shreyansh630@gmail.com, dietmar.eggemann@arm.com, jack@suse.cz,
 jeffm@suse.com, juri.lelli@redhat.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mgorman@suse.de,
 mingo@redhat.com, peterz@infradead.org, reiserfs-devel@vger.kernel.org,
 rkovhaev@gmail.com, syzkaller-bugs@googlegroups.com,
 vincent.guittot@linaro.org
Subject: Re: [syzbot] [mm?] [reiserfs?] general protection fault in
 free_swap_cache (4)
Message-ID: <20240104101717.6c7fd262@gandalf.local.home>
In-Reply-To: <0000000000008a0fa9060e1d198e@google.com>
References: <0000000000008a0fa9060e1d198e@google.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 04 Jan 2024 03:33:25 -0800
syzbot <syzbot+fd93e36ced1a43a58f75@syzkaller.appspotmail.com> wrote:

> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:    610a9b8f49fb Linux 6.7-rc8
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D106d2699e80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D48ca880a5d56f=
9b1
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dfd93e36ced1a43a=
58f75
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D15f4cc41e80=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D14d526ade80000
>=20
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/b1acb98afcb0/dis=
k-610a9b8f.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/4f7d6503eb8c/vmlinu=
x-610a9b8f.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/927f38e505d9/b=
zImage-610a9b8f.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/c4f427645c=
60/mount_0.gz
>=20
> The issue was bisected to:
>=20
> commit 13d257503c0930010ef9eed78b689cec417ab741
> Author: Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
> Date:   Fri Jul 9 15:29:29 2021 +0000
>=20
>     reiserfs: check directory items on read from disk
>=20
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1603b8f9e8=
0000

=46rom the above there's this:

testing commit c81cfb6256d90ea5ba4a6fb280ea3b171be4e05c gcc
compiler: gcc (GCC) 10.2.1 20210217, GNU ld (GNU Binutils for Debian) 2.40
kernel signature: 497e79600c6ea11f26483c542ee335e10f144dccb7fe657a67bd32d52=
7271e77
all runs: OK
false negative chance: 0.000
# git bisect good c81cfb6256d90ea5ba4a6fb280ea3b171be4e05c
Bisecting: 936 revisions left to test after this (roughly 10 steps)
[e04480920d1eec9c061841399aa6f35b6f987d8b] Bluetooth: defer cleanup of reso=
urces in hci_unregister_dev()

testing commit e04480920d1eec9c061841399aa6f35b6f987d8b gcc
compiler: gcc (GCC) 10.2.1 20210217, GNU ld (GNU Binutils for Debian) 2.40
kernel signature: 05fb4fd86182a07a0a9fbfcc25fafd9df57e9d38d1c03a915a6b73410=
507148c
run #0: crashed: BUG: unable to handle kernel paging request in leaf_paste_=
in_buffer
run #1: crashed: BUG: unable to handle kernel NULL pointer dereference in e=
xpand_downwards
run #2: crashed: INFO: trying to register non-static key in inode_doinit_wi=
th_dentry
run #3: crashed: BUG: unable to handle kernel paging request in do_epoll_wa=
it
run #4: OK
run #5: OK
run #6: OK
run #7: OK
run #8: OK
run #9: OK
run #10: OK
run #11: OK
run #12: OK
run #13: OK
run #14: OK
run #15: OK
run #16: OK
run #17: OK
run #18: OK
run #19: OK
representative crash: BUG: unable to handle kernel paging request in leaf_p=
aste_in_buffer, types: [UNKNOWN]
# git bisect bad e04480920d1eec9c061841399aa6f35b6f987d8b
Bisecting: 456 revisions left to test after this (roughly 9 steps)
[1e60cebf82948cfdc9497ea4553bab125587593c] net: let flow have same hash in =
two directions

If the "bad" only crashed 20% of the time, you can not trust any of the
"all runs: OK".

Not to mention each crash looks to be a separate bug!

> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D1503b8f9e8=
0000

And this is:

REISERFS (device loop0): checking transaction log (loop0)
REISERFS (device loop0): Using r5 hash to sort names
REISERFS (device loop0): using 3.5.x disk format
REISERFS (device loop0): Created .reiserfs_priv - reserved for xattr storag=
e.
Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: =
__schedule+0x13c2/0x13e0 kernel/sched/core.c:5948
Kernel Offset: disabled
Rebooting in 86400 seconds..

Which looks like a corrupted (overrun?) stack. Which saying this is a
"general protection fault" bug will put us in a wild goose chase.

> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1103b8f9e80000
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+fd93e36ced1a43a58f75@syzkaller.appspotmail.com
> Fixes: 13d257503c09 ("reiserfs: check directory items on read from disk")
>=20
> general protection fault, probably for non-canonical address 0xdffffc0000=
000001: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
> CPU: 1 PID: 5048 Comm: sshd Not tainted 6.7.0-rc8-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 11/17/2023
> RIP: 0010:_compound_head include/linux/page-flags.h:247 [inline]
> RIP: 0010:free_swap_cache+0x25/0x3d0 mm/swap_state.c:287
> Code: 0f 1f 44 00 00 66 0f 1f 00 41 54 55 53 48 89 fb e8 90 e9 b2 ff 48 8=
d 7b 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f=
 85 34 03 00 00 4c 8b 63 08 31 ff 4c 89 e5 83 e5 01
> RSP: 0018:ffffc900034df938 EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff81d3826a
> RDX: 0000000000000001 RSI: ffffffff81d37b70 RDI: 0000000000000008
> RBP: 0000000000000005 R08: 0000000000000004 R09: 0000000000000200
> R10: 0000000000000004 R11: 0000000000000001 R12: 0000000000000200
> R13: dffffc0000000000 R14: ffff88807490d010 R15: ffff88807490d008
> FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffc22cebe00 CR3: 000000007c973000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  free_pages_and_swap_cache+0x60/0xa0 mm/swap_state.c:315
>  tlb_batch_pages_flush+0x9a/0x190 mm/mmu_gather.c:98
>  tlb_flush_mmu_free mm/mmu_gather.c:293 [inline]
>  tlb_flush_mmu mm/mmu_gather.c:300 [inline]
>  tlb_finish_mmu+0x14b/0x6f0 mm/mmu_gather.c:392
>  exit_mmap+0x38b/0xa70 mm/mmap.c:3321
>  __mmput+0x12a/0x4d0 kernel/fork.c:1349
>  mmput+0x62/0x70 kernel/fork.c:1371
>  exit_mm kernel/exit.c:567 [inline]
>  do_exit+0x9a5/0x2ad0 kernel/exit.c:856
>  do_group_exit+0xd4/0x2a0 kernel/exit.c:1018
>  get_signal+0x23b5/0x2790 kernel/signal.c:2904
>  arch_do_signal_or_restart+0x90/0x7f0 arch/x86/kernel/signal.c:309
>  exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
>  exit_to_user_mode_prepare+0x121/0x240 kernel/entry/common.c:204
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
>  syscall_exit_to_user_mode+0x1e/0x60 kernel/entry/common.c:296
>  do_syscall_64+0x4d/0x110 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> RIP: 0033:0x5623b9f0af8e
> Code: Unable to access opcode bytes at 0x5623b9f0af64.
> RSP: 002b:00007fff3b36f178 EFLAGS: 00000246 ORIG_RAX: 000000000000010f
> RAX: 0000000000000000 RBX: 00000000000668a0 RCX: 00007f85b4f19ad5
> RDX: 00007fff3b36f180 RSI: 00007fff3b36f2b0 RDI: 0000000000000011
> RBP: 00005623bb920260 R08: 0000000000000008 R09: 0000000000000000
> R10: 00007fff3b36f848 R11: 0000000000000246 R12: 00005623b9f8faa4
> R13: 0000000000000001 R14: 00005623b9f903e8 R15: 00007fff3b36f7c8
>  </TASK>
> Modules linked in:
> ----------------
> Code disassembly (best guess):
>    0:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
>    5:	66 0f 1f 00          	nopw   (%rax)
>    9:	41 54                	push   %r12
>    b:	55                   	push   %rbp
>    c:	53                   	push   %rbx
>    d:	48 89 fb             	mov    %rdi,%rbx
>   10:	e8 90 e9 b2 ff       	call   0xffb2e9a5
>   15:	48 8d 7b 08          	lea    0x8(%rbx),%rdi
>   19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
>   20:	fc ff df
>   23:	48 89 fa             	mov    %rdi,%rdx
>   26:	48 c1 ea 03          	shr    $0x3,%rdx
> * 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instru=
ction
>   2e:	0f 85 34 03 00 00    	jne    0x368
>   34:	4c 8b 63 08          	mov    0x8(%rbx),%r12
>   38:	31 ff                	xor    %edi,%edi
>   3a:	4c 89 e5             	mov    %r12,%rbp
>   3d:	83 e5 01             	and    $0x1,%ebp
>=20
>=20
> ---
> This report is generated by a bot. It may contain errors.

I would say it does.

Anyway, it is possibly a reiserfs bug that's using too much stack.

But it would be nice if these bot reports had a bit better bisecting
algorithm.

-- Steve


> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>=20
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>=20
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>=20
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>=20
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>=20
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>=20
> If you want to undo deduplication, reply with:
> #syz undup


