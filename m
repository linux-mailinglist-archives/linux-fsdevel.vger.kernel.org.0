Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224C6748538
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 15:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbjGENlZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 09:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjGENlX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:41:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BE9BA;
        Wed,  5 Jul 2023 06:41:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18B7E6155A;
        Wed,  5 Jul 2023 13:41:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B76A1C433C8;
        Wed,  5 Jul 2023 13:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688564480;
        bh=Q/NgNhAXvsnQ2AEOCtdSpg7hwkODaNSASQGc6Q5RyrQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SXKZKVNisXhEq665eYuP6GgbFGHW1+PrZPWmaonLKTtHUsVnLpstmjLxoBlTHPsS8
         YDRktM925za1dZ3ao2iAY05Pj1zT639QysMHoknAWInWcixUgG3mP+naIwZCNGf9NN
         N4PPwuORX9PkvS0SgBsat3fxitJdP70WuSinJchjzkuptVmY+wRQ+D8G0oXueNzn41
         tnZnW43zPt/La8b/EH+I2APj3sFg7nlxYkU/rAuOSEyT3ERBZ6begpq1pri7okmZrs
         x3OtY4LzlJrwjoAUe1uQN7USJUxhm+Fn4LFmwK/0cqLTLa+US+Lq6bsi/6Z6TkUWu0
         4cSej6P8BNjHQ==
Message-ID: <f966d10e793a9e8e2edb22cf09c25f097e638df9.camel@kernel.org>
Subject: Re: [syzbot] [overlayfs?] general protection fault in d_path
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        syzbot <syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com>,
        amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        syzkaller-bugs@googlegroups.com
Date:   Wed, 05 Jul 2023 09:41:18 -0400
In-Reply-To: <20230705-aufgearbeitet-kaffee-44ff4731a7dd@brauner>
References: <0000000000004f34d705ffbc2604@google.com>
         <20230705-aufgearbeitet-kaffee-44ff4731a7dd@brauner>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-07-05 at 15:05 +0200, Christian Brauner wrote:
> On Wed, Jul 05, 2023 at 05:00:45AM -0700, syzbot wrote:
> > Hello,
> >=20
> > syzbot found the following issue on:
> >=20
> > HEAD commit:    d528014517f2 Revert ".gitignore: ignore *.cover and *.m=
bx"
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D14fad002a80=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D1085b4238c9=
eb6ba
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Da67fc5321ffb4=
b311c98
> > compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for D=
ebian) 2.35.2
> >=20
> > Unfortunately, I don't have any reproducer for this issue yet.
> >=20
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/fef94e788067/d=
isk-d5280145.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/576412ea518b/vmli=
nux-d5280145.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/685a0e4be06b=
/bzImage-d5280145.xz
> >=20
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com
> >=20
> > general protection fault, probably for non-canonical address 0xdffffc00=
0000000a: 0000 [#1] PREEMPT SMP KASAN
> > KASAN: null-ptr-deref in range [0x0000000000000050-0x0000000000000057]
> > CPU: 1 PID: 10127 Comm: syz-executor.3 Not tainted 6.4.0-syzkaller-1147=
8-gd528014517f2 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 05/27/2023
> > RIP: 0010:__lock_acquire+0x10d/0x7f70 kernel/locking/lockdep.c:5012
> > Code: 85 75 18 00 00 83 3d 15 c8 2c 0d 00 48 89 9c 24 10 01 00 00 0f 84=
 f8 0f 00 00 83 3d 5c de b3 0b 00 74 34 48 89 d0 48 c1 e8 03 <42> 80 3c 00 =
00 74 1a 48 89 d7 e8 b4 51 79 00 48 8b 94 24 80 00 00
> > RSP: 0018:ffffc900169be9e0 EFLAGS: 00010006
> > RAX: 000000000000000a RBX: 1ffff92002d37d60 RCX: 0000000000000002
> > RDX: 0000000000000050 RSI: 0000000000000000 RDI: 0000000000000050
> > RBP: ffffc900169beca8 R08: dffffc0000000000 R09: 0000000000000001
> > R10: dffffc0000000000 R11: fffffbfff1d2fe76 R12: 0000000000000000
> > R13: 0000000000000001 R14: 0000000000000002 R15: ffff88802091d940
> > FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007fa22a3fe000 CR3: 000000004b5e1000 CR4: 00000000003506e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5761
> >  seqcount_lockdep_reader_access+0x139/0x220 include/linux/seqlock.h:102
> >  get_fs_root_rcu fs/d_path.c:244 [inline]
> >  d_path+0x2f0/0x6e0 fs/d_path.c:286
> >  audit_log_d_path+0xd3/0x310 kernel/audit.c:2139
> >  dump_common_audit_data security/lsm_audit.c:224 [inline]
> >  common_lsm_audit+0x7cf/0x1a90 security/lsm_audit.c:458
> >  smack_log+0x421/0x540 security/smack/smack_access.c:383
> >  smk_tskacc+0x2ff/0x360 security/smack/smack_access.c:253
> >  smack_inode_getattr+0x203/0x270 security/smack/smack_lsm.c:1202
> >  security_inode_getattr+0xd3/0x120 security/security.c:2114
> >  vfs_getattr+0x25/0x70 fs/stat.c:167
> >  ovl_getattr+0x1b1/0xf70 fs/overlayfs/inode.c:174
> >  ima_check_last_writer security/integrity/ima/ima_main.c:171 [inline]
> >  ima_file_free+0x26e/0x4b0 security/integrity/ima/ima_main.c:203
>=20
> Ugh, I think the root of this might all be the call back into
> vfs_getattr() that happens on overlayfs:
>=20
> __fput()
> -> ima_file_free()
>    -> mutex_lock()
>    -> vfs_getattr_nosec()
>       -> i_op->getattr() =3D=3D ovl_getattr()
>          -> vfs_getattr()
> 	    -> security_inode_getattr()
>    -> mutex_unlock()
>=20
> So either overlayfs needs to call vfs_getattr_nosec() when the request
> comes from vfs_getattr_nosec() or this needs to use
> backing_file_real_path() to operate on the real underlying path.
>=20
> Thoughts?
>=20

When you say "this needs to use backing_file_real_path()", what do you
mean by "this"? IMA?

That said, passing some sort of NOSEC flag to vfs_getattr that
designates the call as kernel-internal seems like the more correct thing
to do here, and might be useful in other weird stacking cases like this.

> >  __fput+0x36a/0x950 fs/file_table.c:378
> >  task_work_run+0x24a/0x300 kernel/task_work.c:179
> >  exit_task_work include/linux/task_work.h:38 [inline]
> >  do_exit+0x68f/0x2290 kernel/exit.c:874
> >  do_group_exit+0x206/0x2c0 kernel/exit.c:1024
> >  get_signal+0x1709/0x17e0 kernel/signal.c:2877
> >  arch_do_signal_or_restart+0x91/0x670 arch/x86/kernel/signal.c:308
> >  exit_to_user_mode_loop+0x6a/0x100 kernel/entry/common.c:168
> >  exit_to_user_mode_prepare+0xb1/0x140 kernel/entry/common.c:204
> >  __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
> >  syscall_exit_to_user_mode+0x64/0x280 kernel/entry/common.c:297
> >  do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > RIP: 0033:0x7f7f3ca8c389
> > Code: Unable to access opcode bytes at 0x7f7f3ca8c35f.
> > RSP: 002b:00007f7f3d741168 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
> > RAX: fffffffffffffffb RBX: 00007f7f3cbac050 RCX: 00007f7f3ca8c389
> > RDX: 0000000000000000 RSI: 00000000200001c0 RDI: 0000000020000180
> > RBP: 00007f7f3cad7493 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 00007fff8432555f R14: 00007f7f3d741300 R15: 0000000000022000
> >  </TASK>
> > Modules linked in:
> > ---[ end trace 0000000000000000 ]---
> > RIP: 0010:__lock_acquire+0x10d/0x7f70 kernel/locking/lockdep.c:5012
> > Code: 85 75 18 00 00 83 3d 15 c8 2c 0d 00 48 89 9c 24 10 01 00 00 0f 84=
 f8 0f 00 00 83 3d 5c de b3 0b 00 74 34 48 89 d0 48 c1 e8 03 <42> 80 3c 00 =
00 74 1a 48 89 d7 e8 b4 51 79 00 48 8b 94 24 80 00 00
> > RSP: 0018:ffffc900169be9e0 EFLAGS: 00010006
> > RAX: 000000000000000a RBX: 1ffff92002d37d60 RCX: 0000000000000002
> > RDX: 0000000000000050 RSI: 0000000000000000 RDI: 0000000000000050
> > RBP: ffffc900169beca8 R08: dffffc0000000000 R09: 0000000000000001
> > R10: dffffc0000000000 R11: fffffbfff1d2fe76 R12: 0000000000000000
> > R13: 0000000000000001 R14: 0000000000000002 R15: ffff88802091d940
> > FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007fa22a3fe000 CR3: 000000004b5e1000 CR4: 00000000003506e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > ----------------
> > Code disassembly (best guess):
> >    0:	85 75 18             	test   %esi,0x18(%rbp)
> >    3:	00 00                	add    %al,(%rax)
> >    5:	83 3d 15 c8 2c 0d 00 	cmpl   $0x0,0xd2cc815(%rip)        # 0xd2cc=
821
> >    c:	48 89 9c 24 10 01 00 	mov    %rbx,0x110(%rsp)
> >   13:	00
> >   14:	0f 84 f8 0f 00 00    	je     0x1012
> >   1a:	83 3d 5c de b3 0b 00 	cmpl   $0x0,0xbb3de5c(%rip)        # 0xbb3d=
e7d
> >   21:	74 34                	je     0x57
> >   23:	48 89 d0             	mov    %rdx,%rax
> >   26:	48 c1 e8 03          	shr    $0x3,%rax
> > * 2a:	42 80 3c 00 00       	cmpb   $0x0,(%rax,%r8,1) <-- trapping instr=
uction
> >   2f:	74 1a                	je     0x4b
> >   31:	48 89 d7             	mov    %rdx,%rdi
> >   34:	e8 b4 51 79 00       	callq  0x7951ed
> >   39:	48                   	rex.W
> >   3a:	8b                   	.byte 0x8b
> >   3b:	94                   	xchg   %eax,%esp
> >   3c:	24 80                	and    $0x80,%al
> >=20
> >=20
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >=20
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >=20
> > If the bug is already fixed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >=20
> > If you want to change bug's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >=20
> > If the bug is a duplicate of another bug, reply with:
> > #syz dup: exact-subject-of-another-report
> >=20
> > If you want to undo deduplication, reply with:
> > #syz undup

--=20
Jeff Layton <jlayton@kernel.org>
