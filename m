Return-Path: <linux-fsdevel+bounces-38295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 752479FEFA4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2024 14:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C185161D8E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2024 13:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10841A704B;
	Tue, 31 Dec 2024 13:18:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BD019CC33
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Dec 2024 13:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735651081; cv=none; b=HtB4XiBHKrzmKZa7gVkPVvr97cPkNL07j3R1+JEdPDCGAweCjhvglGaWL4ptpTA5ZhUuEdsMtS/ZAXjQ8VWhRhvimlc8+0LAQ1foj9Yg6bpL/LwxPpTOMPg6WYsXUt+CdhKRB/2gMRbg6eGJ/odCHrJz21hhIVZajmx/DLbFSxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735651081; c=relaxed/simple;
	bh=sLkqtcKy8Ct/m30cu9OzuXheHkMxVpL3X1GqxwKCttk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=HEbNAbIUZfgE1139rJXlGK9I+rhuonk6U/++oBV9DkzMWioGHY87QBtKK6tJ+da1v57u/mPzOiEAEwz1FkDGJYkgw5DWrMFH16I2gZnJtirNHYZgAmTUFPPFPX2YoBO4+vmXR39g11JJHQf9yPB+mbKoqBV3Gwh7giO/8zTlT20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3a819a4e83dso109781645ab.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Dec 2024 05:17:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735651079; x=1736255879;
        h=content-transfer-encoding:cc:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nr6PbDpKLnrcBSLJqJeyCll/4t6RrG+rZ8H/hwG9TAU=;
        b=ugjNl57f27RhAW6j/4iXK5wVVyP7bCmikHJwF6ZLq6CgUrjbrurFdxTckczXhp0wKy
         Xvfza/Vg71TnV8U5ltWzMlbCi1kSuiR05PvVdkdGjTB3byvx2lmS9pe2vPczg6fh8jKL
         pjjBVeiOQaBJyVOAQujCN/gNIkX0pXIViyCD8bLEKxu1OOJ3lpjj8p5H8hJGGKB6Al7k
         KiBfdD/M40/5rMldSX+lw8apUUb4D6D6DCgQ7J7xUGHCBQaScJrQTnWi1CEIZt5wWi0A
         buUaq7eVLciVBIee4NequKQ+qyHW+EbBP+XC5ABSu0Zx1jaHERGtOoBuUHJ+J2TUrwNN
         dSxw==
X-Forwarded-Encrypted: i=1; AJvYcCUc3hRT5mbpyneP2TcHB66x59FuXKwpd7chyrxh+1kRfyaat4k88gU81ZAsYy0R60iIPBURzDToSwcjQJLw@vger.kernel.org
X-Gm-Message-State: AOJu0YzPF659y77SWpGnxAt/sKGKo/bo8S5bJkbocuVTV3hS9qAQ7SSn
	hfhm5+P0mDR2E/15HwdjACpVXIxw9MtOBIbhhneOKG9wjHjVENtFfddIcYjTOEU+JYSaZznyYqB
	mN9NhKV5P/kG8yXvqtqLTpqEjFn3cZYUYkwdIs9hSfGg3iwhDPV12XXQ=
X-Google-Smtp-Source: AGHT+IFWCVeAa9Uff7hyuMd7jhvcBcsB13EEnUEOhIodvFf6KIxiXLMdb972tVmjKGM5C+drzmO9LkbW1leYd+vqfH2A0H2FEiWg
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3042:b0:3a7:fd5a:8b8a with SMTP id
 e9e14a558f8ab-3c2d2d4f1abmr367675075ab.12.1735651078912; Tue, 31 Dec 2024
 05:17:58 -0800 (PST)
Date: Tue, 31 Dec 2024 05:17:58 -0800
In-Reply-To: <ee7c3be0-35f1-43bd-8627-1ad6ec655c24@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6773ef06.050a0220.2f3838.04e1.GAE@google.com>
Subject: Re: [syzbot] [fuse?] BUG: unable to handle kernel NULL pointer
 dereference in fuse_copy_one
From: syzbot <syzbot+43f6243d6c4946b26405@syzkaller.appspotmail.com>
To: eric.dumazet@gmail.com
Cc: eric.dumazet@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, miklos@szeredi.hu, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> On 12/31/24 2:10 PM, syzbot wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    ccb98ccef0e5 Merge tag 'platform-drivers-x86-v6.13-4' of=
 g..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D14d4f50f9800=
00
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D86dd15278dbf=
e19f
>> dashboard link: https://syzkaller.appspot.com/bug?extid=3D43f6243d6c4946=
b26405
>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for =
Debian) 2.40
>> userspace arch: i386
>>
>> Unfortunately, I don't have any reproducer for this issue yet.
>>
>> Downloadable assets:
>> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/=
7feb34a89c2a/non_bootable_disk-ccb98cce.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/75a6223b351c/vmlin=
ux-ccb98cce.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/beea89d50f58/=
bzImage-ccb98cce.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the com=
mit:
>> Reported-by: syzbot+43f6243d6c4946b26405@syzkaller.appspotmail.com
>>
>> BUG: kernel NULL pointer dereference, address: 0000000000000000
>> #PF: supervisor write access in kernel mode
>> #PF: error_code(0x0002) - not-present page
>> PGD 6a754067 P4D 6a754067 PUD 68142067 PMD 0
>> Oops: Oops: 0002 [#1] PREEMPT SMP KASAN NOPTI
>> CPU: 0 UID: 0 PID: 7523 Comm: syz.2.395 Not tainted 6.13.0-rc5-syzkaller=
-00004-gccb98ccef0e5 #0
>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1=
.16.3-2~bpo12+1 04/01/2014
>> RIP: 0010:memcpy+0xc/0x20 arch/x86/lib/memcpy_64.S:38
>> Code: e9 44 fd ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 =
90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 48 89 f8 48 89 d1 <f3> a4 c3 cc c=
c cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90
>> RSP: 0018:ffffc9000370f8b0 EFLAGS: 00010293
>> RAX: 0000000000000000 RBX: ffffc9000370fc50 RCX: 0000000000000004
>> RDX: 0000000000000004 RSI: ffff88804ef5d710 RDI: 0000000000000000
>> RBP: 0000000000000004 R08: 0000000000000005 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000004
>> R13: 0000000000000000 R14: 0000000000000004 R15: dffffc0000000000
>> FS:  0000000000000000(0000) GS:ffff88802b400000(0063) knlGS:00000000f508=
0b40
>> CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
>> CR2: 0000000000000000 CR3: 000000006ba72000 CR4: 0000000000352ef0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>   <TASK>
>>   fuse_copy_do fs/fuse/dev.c:809 [inline]
>>   fuse_copy_one+0x1cc/0x230 fs/fuse/dev.c:1065
>>   fuse_copy_args+0x109/0x690 fs/fuse/dev.c:1083
>>   copy_out_args fs/fuse/dev.c:1966 [inline]
>>   fuse_dev_do_write+0x1b0a/0x3100 fs/fuse/dev.c:2052
>>   fuse_dev_write+0x160/0x1f0 fs/fuse/dev.c:2087
>>   new_sync_write fs/read_write.c:586 [inline]
>>   vfs_write+0x5ae/0x1150 fs/read_write.c:679
>>   ksys_write+0x12b/0x250 fs/read_write.c:731
>>   do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
>>   __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
>>   do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
>>   entry_SYSENTER_compat_after_hwframe+0x84/0x8e
>> RIP: 0023:0xf708e579
>> Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 =
00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 9=
0 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
>> RSP: 002b:00000000f5080500 EFLAGS: 00000293 ORIG_RAX: 0000000000000004
>> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000020000700
>> RDX: 0000000000000014 RSI: 00000000f73c3ff4 RDI: 0000000000000000
>> RBP: 0000000020008380 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
>> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>>   </TASK>
>> Modules linked in:
>> CR2: 0000000000000000
>> ---[ end trace 0000000000000000 ]---
>> RIP: 0010:memcpy+0xc/0x20 arch/x86/lib/memcpy_64.S:38
>> Code: e9 44 fd ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 =
90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 48 89 f8 48 89 d1 <f3> a4 c3 cc c=
c cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90
>> RSP: 0018:ffffc9000370f8b0 EFLAGS: 00010293
>> RAX: 0000000000000000 RBX: ffffc9000370fc50 RCX: 0000000000000004
>> RDX: 0000000000000004 RSI: ffff88804ef5d710 RDI: 0000000000000000
>> RBP: 0000000000000004 R08: 0000000000000005 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000004
>> R13: 0000000000000000 R14: 0000000000000004 R15: dffffc0000000000
>> FS:  0000000000000000(0000) GS:ffff88802b400000(0063) knlGS:00000000f508=
0b40
>> CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
>> CR2: 0000000000000000 CR3: 000000006ba72000 CR4: 0000000000352ef0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> ----------------
>> Code disassembly (best guess):
>>     0:	e9 44 fd ff ff       	jmp    0xfffffd49
>>     5:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
>>     c:	00 00
>>     e:	90                   	nop
>>     f:	90                   	nop
>>    10:	90                   	nop
>>    11:	90                   	nop
>>    12:	90                   	nop
>>    13:	90                   	nop
>>    14:	90                   	nop
>>    15:	90                   	nop
>>    16:	90                   	nop
>>    17:	90                   	nop
>>    18:	90                   	nop
>>    19:	90                   	nop
>>    1a:	90                   	nop
>>    1b:	90                   	nop
>>    1c:	90                   	nop
>>    1d:	90                   	nop
>>    1e:	f3 0f 1e fa          	endbr64
>>    22:	66 90                	xchg   %ax,%ax
>>    24:	48 89 f8             	mov    %rdi,%rax
>>    27:	48 89 d1             	mov    %rdx,%rcx
>> * 2a:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi) <-- trapping=
 instruction
>>    2c:	c3                   	ret
>>    2d:	cc                   	int3
>>    2e:	cc                   	int3
>>    2f:	cc                   	int3
>>    30:	cc                   	int3
>>    31:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
>>    38:	00 00 00 00
>>    3c:	66 90                	xchg   %ax,%ax
>>    3e:	90                   	nop
>>    3f:	90                   	nop
>>
>>
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>>
>> If the report is already addressed, let syzbot know by replying with:
>> #syz fix: exact-commit-title
>>
>> If you want to overwrite report's subsystems, reply with:
>> #syz set subsystems: new-subsystem
>> (See the list of subsystem names on the web dashboard)
>>
>> If the report is a duplicate of another one, reply with:
>> #syz dup: exact-subject-of-another-report
>>
>> If you want to undo deduplication, reply with:
>> #syz undup
>>
> Bug origin in
>
> commit ebe559609d7829b52c6642b581860760984faf9d
> Author: Al Viro <viro@zeniv.linux.org.uk>
> Date:=C2=A0=C2=A0 Fri Nov 15 10:30:14 2024 -0500
>
>  =C2=A0=C2=A0=C2=A0 fs: get rid of __FMODE_NONOTIFY kludge
>
> #syz test

This crash does not have a reproducer. I cannot test it.

>
> diff --git a/fs/notify/fanotify/fanotify_user.c=20
> b/fs/notify/fanotify/fanotify_user.c
> index 19435cd2c41f..6ff94e312232 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1624,8 +1624,8 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int,=20
> flags, unsigned int, event_f_flags)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file =3D anon_inode_getfile_f=
mode("[fanotify]", &fanotify_fops,=20
> group,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 f_flags, FMODE_NONOTIFY);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(file)) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 fd =3D PTR_ERR(file);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 put_unused_fd(fd);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 fd =3D PTR_ERR(file);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 goto out_destroy_group;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fd_install(fd, file);
>

