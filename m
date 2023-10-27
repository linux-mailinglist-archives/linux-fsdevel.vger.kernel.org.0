Return-Path: <linux-fsdevel+bounces-1354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BD07D94FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 12:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E6CC282359
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 10:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0B21803C;
	Fri, 27 Oct 2023 10:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwDm/Z6c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663A81802F
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 10:16:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0672C433C8;
	Fri, 27 Oct 2023 10:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698401779;
	bh=4fUwCmh3aJLtidgC+TUbXK1gRF+kVmTye+QZ20QsJ80=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=BwDm/Z6ckHYn0M0+TrPfEdhK1nBIlaIliRl0Ybg91eHjVixIdLevpPaRKvmftAMEm
	 IZrOGxqJNms0OnEXycIJT9OrYkbf89Zjeata2QfkzPvocEUugZlMm8CjsRuu40OOdv
	 lMD2DAJ6qaeKrhOOggYbz68O1ezKbBPQAxfTaYC74mK7m15f0nqOgJ21S9o6cUCN19
	 6aInWdx0Wnk7kwuk/YhKkBmD3PX6R7yApQ6QS0qcBps44pF7Ny6wUueybPSF3n5hWz
	 lVgR2HidXjBFbDkyteUop+808/7NofOCQYUdlr2Oprmyc6awq8XT/2wlRBOFQasSwK
	 0GM3Po/r0uNWg==
Message-ID: <6b12ba28a4bd276ecd6ffbd97af76de46c72788a.camel@kernel.org>
Subject: Re: [syzbot] [ext4?] general protection fault in locks_remove_posix
From: Jeff Layton <jlayton@kernel.org>
To: syzbot <syzbot+ba2c35eb32f5a85137f8@syzkaller.appspotmail.com>, 
 adilger.kernel@dilger.ca, brauner@kernel.org, chuck.lever@oracle.com, 
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 tytso@mit.edu,  viro@zeniv.linux.org.uk
Date: Fri, 27 Oct 2023 06:16:17 -0400
In-Reply-To: <000000000000ef757e0608aba23d@google.com>
References: <000000000000ef757e0608aba23d@google.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-10-26 at 22:05 -0700, syzbot wrote:
> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:    2030579113a1 Add linux-next specific files for 20231020
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D14e7573968000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D37404d76b3c88=
40e
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dba2c35eb32f5a85=
137f8
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D125607f5680=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D12a22e9368000=
0
>=20
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/a99a981e5d78/dis=
k-20305791.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/073a5ba6a2a6/vmlinu=
x-20305791.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/c7c1a7107f7b/b=
zImage-20305791.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/81394ce585=
9f/mount_0.gz
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+ba2c35eb32f5a85137f8@syzkaller.appspotmail.com
>=20
> general protection fault, probably for non-canonical address 0xdffffc001f=
fff11a: 0000 [#1] PREEMPT SMP KASAN
> KASAN: probably user-memory-access in range [0x00000000ffff88d0-0x0000000=
0ffff88d7]
> CPU: 1 PID: 5052 Comm: udevd Not tainted 6.6.0-rc6-next-20231020-syzkalle=
r #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 09/06/2023
> RIP: 0010:list_empty include/linux/list.h:373 [inline]
> RIP: 0010:locks_remove_posix+0x100/0x510 fs/locks.c:2555
> Code: 4d 8b ae 20 02 00 00 4d 85 ed 0f 84 0c 02 00 00 e8 15 60 7d ff 49 8=
d 55 50 48 b9 00 00 00 00 00 fc ff df 48 89 d6 48 c1 ee 03 <80> 3c 0e 00 0f=
 85 ae 03 00 00 49 8b 45 50 48 39 c2 0f 84 db 01 00
> RSP: 0018:ffffc90003d6f948 EFLAGS: 00010202
> RAX: 0000000000000000 RBX: ffff8880271cca00 RCX: dffffc0000000000
> RDX: 00000000ffff88d0 RSI: 000000001ffff11a RDI: ffff8880796982e0
> RBP: 1ffff920007adf2b R08: 0000000000000003 R09: 0000000000004000
> R10: 0000000000000000 R11: dffffc0000000000 R12: ffffc90003d6f988
> R13: 00000000ffff8880 R14: ffff8880796980c0 R15: ffff8880271ccb90
> FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fc227c3e000 CR3: 000000002000e000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  filp_flush+0x11b/0x1a0 fs/open.c:1554
>  filp_close+0x1c/0x30 fs/open.c:1563
>  close_files fs/file.c:432 [inline]
>  put_files_struct fs/file.c:447 [inline]
>  put_files_struct+0x1df/0x360 fs/file.c:444
>  exit_files+0x82/0xb0 fs/file.c:464
>  do_exit+0xa51/0x2ac0 kernel/exit.c:866
>  do_group_exit+0xd3/0x2a0 kernel/exit.c:1021
>  get_signal+0x2391/0x2760 kernel/signal.c:2904
>  arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:309
>  exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
>  exit_to_user_mode_prepare+0x11c/0x240 kernel/entry/common.c:204
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
>  syscall_exit_to_user_mode+0x1d/0x60 kernel/entry/common.c:296
>  do_syscall_64+0x4b/0x110 arch/x86/entry/common.c:88
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> RIP: 0033:0x7fc2276be3cd
> Code: Unable to access opcode bytes at 0x7fc2276be3a3.
> RSP: 002b:00007ffd929ccc20 EFLAGS: 00000246 ORIG_RAX: 00000000000000ea
> RAX: 0000000000000000 RBX: 00007fc227b0bc80 RCX: 00007fc2276be3cd
> RDX: 0000000000000006 RSI: 00000000000013bc RDI: 00000000000013bc
> RBP: 00000000000013bc R08: 0000000000000000 R09: 0000000000000002
> R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000000006
> R13: 00007ffd929cce30 R14: 0000000000001000 R15: 0000000000000000
>  </TASK>
> Modules linked in:
> ----------------
> Code disassembly (best guess):
>    0:	4d 8b ae 20 02 00 00 	mov    0x220(%r14),%r13
>    7:	4d 85 ed             	test   %r13,%r13
>    a:	0f 84 0c 02 00 00    	je     0x21c
>   10:	e8 15 60 7d ff       	call   0xff7d602a
>   15:	49 8d 55 50          	lea    0x50(%r13),%rdx
>   19:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
>   20:	fc ff df
>   23:	48 89 d6             	mov    %rdx,%rsi
>   26:	48 c1 ee 03          	shr    $0x3,%rsi
> * 2a:	80 3c 0e 00          	cmpb   $0x0,(%rsi,%rcx,1) <-- trapping instru=
ction
>   2e:	0f 85 ae 03 00 00    	jne    0x3e2
>   34:	49 8b 45 50          	mov    0x50(%r13),%rax
>   38:	48 39 c2             	cmp    %rax,%rdx
>   3b:	0f                   	.byte 0xf
>   3c:	84 db                	test   %bl,%bl
>   3e:	01 00                	add    %eax,(%rax)
>=20

Hrm, this is a curious one. The relevant code is here:
                                                                           =
         =20
        ctx =3D locks_inode_context(inode);                             =
=20
        if (!ctx || list_empty(&ctx->flc_posix))                      =20
                return;                                               =20

So in this case, ctx was non-NULL, but apparently the i_flctx pointer
was bogus (or maybe the list in it was corrupt? Not certain here). That
pointer is initialized to NULL in inode_init_always, and it's only ever
set via cmpxchg in locks_get_lock_context.

The assembly looks really weird, but I found this mail from Linus that
explains some of what we're seeing (but in the context of a percpu var
problem):

    https://lkml.org/lkml/2023/10/8/295

I'm stumped. I don't see how this could happen right offhand, so I'm
left to wonder if maybe we have some sort of generic memory corruption
here? Could this be a KASAN bug of some sort?
--=20
Jeff Layton <jlayton@kernel.org>

