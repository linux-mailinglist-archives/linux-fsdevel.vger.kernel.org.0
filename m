Return-Path: <linux-fsdevel+bounces-38297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3F99FEFAF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2024 14:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 553C23A2EA8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2024 13:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C42919D07A;
	Tue, 31 Dec 2024 13:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZ783206"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF329199EBB;
	Tue, 31 Dec 2024 13:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735651233; cv=none; b=DMFNIepi2svoBsk7JDsR50P7P5TImgmAcdFfDumYo15V1CCYonPrLoA1ZJccctC1nhPPQu9mam9DCjFaGn0IhBxdf73sMm35BykjpDG5DuCN/H5eX6Pq4Sqwg72uKaY0v0jiubLVI6r8ucdMs3q7Yjxb/ApViLtQn2ed6zvjhEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735651233; c=relaxed/simple;
	bh=t+a/jMAXQCrZVPz63VahHVjg8NjsP8eL1NEAnab7UM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EsiHmdLACYxdkOlniclWbW84RcMaY9NzhmpRm6E+bUGJpbdU0CKP9gEFWca7HTU++pF5h6c1+jefkh9w9Ldw+Ij6/dG1bbEEX/SU8S5InHtUy3hHy+4jE6OT4Sfnqc4silEb97XiGDLQDpXSkwum5khSJLy6ORxpzbOBEEv3rYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZ783206; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43618283d48so73070465e9.1;
        Tue, 31 Dec 2024 05:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735651225; x=1736256025; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PGAKmRer78hCkL+PxDHFxRS6MSQEb41pprcjtHOYOWI=;
        b=dZ783206N4E89mIcW4Dwnmcq7ucgiESXko51lqLvAWiJB0oNM5jvuN22+0FBq1PyJe
         Id6VQYGotssqloeOJupivvEskpqZMmAiFa+rRiEnhwMvTw9CaAyy4IQdI2y7238G9+Nx
         buMHi5+3TcSNYLRIdbG2EE91k6lfjhojbUlBOdYx84NIdWDjvajvqzVa+7r7QB/soN/1
         ElczT4ooPgwsDa4Y68Do5PR7255fKXJFOxkGOw8F47DOcWn5ijAHPBbMIC5HV/hboT5Y
         3b+UWBiQFOOwz4SmYhTuLm9rT3L13VZd2EHJAtVNmm7Q2dHv9IC/1L2aseKCx7fkH0QJ
         sxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735651225; x=1736256025;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PGAKmRer78hCkL+PxDHFxRS6MSQEb41pprcjtHOYOWI=;
        b=M8xd23QH2gRueRHId51NuJL23jt74cnKFvWBnK5SXmJSWOLIn+h+RYFg88pq1mLcP5
         uQfyWdS2JA7n2SINFxmVFCMiYCu8wWUJDqGKpD2UzDz6DX6G2dxG2ZiNsQjt34dJn2IU
         /WJ8Au2POUPzJNwKw2o/RtyPADz4PapPTiEvHcmC5Zy+x6uniCRC/tHKt3Oxcrn1Mi+s
         i96i9K2MlBH9FbBzPtuNtMVg2iFw7FK0/bH96nZkZ9T5k9ib0ZG7VPcHI9u15zGpxFAY
         z7nwQkVDhpddlEyrSLox+8Kj/WRxfGgXJJf0lHjTMWIp5oOH8W0PngvRiR9zHcmvHk5j
         WbLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhsLNKnHJ/6vdvkdGvEnZ7+2JXg/ovLESnsopkJr0c64tpIH8kxQKzt0IsOjMpotQpLQOarWCjqYUfVFo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3H3RPD27aVGt/uJ88VkUjv1m0fNq6acH1KQQ24kx4xpgs527B
	2M7SjyGl1q3wNGewtWlCtjapxPcZAFbZMsMKNYc67AH+UL8TwPrG
X-Gm-Gg: ASbGncvMGnpENAx2MXluQzJEFzKffzW96gnAA3mCVOR4U+AX+NGlpT3LzTSS2VX2qGI
	K35c8obbFrMnw60w4ZSwmo1SUEvcQoS4TiVgt059OKpIbZlgV42zH4g8b1Rx5YHFJ9hu3SMK5zs
	PtqJb5lwffeaoEjlqHSCj2CEWMg12ckL0NhIfkrVQhjnbie2v/I9odidUtOCvu9QJ4+WinyalJC
	+WWlLrZ+cCL3SRGKGlrTJwwwbXTRkyQ+IFV7nyE33iCRQDIURGLbrck3SA=
X-Google-Smtp-Source: AGHT+IEK3p6HG8EF9irFKeTXR7QyJHm+i6FCOH4GPDqxJnCBUVUoOytdHflsmKXU/PhoLiXpqAJGNQ==
X-Received: by 2002:a7b:cd95:0:b0:436:30e4:4590 with SMTP id 5b1f17b1804b1-43668b7a1d0mr284335675e9.32.1735651224645;
        Tue, 31 Dec 2024 05:20:24 -0800 (PST)
Received: from [10.0.0.4] ([78.245.221.173])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b4471bsm421955055e9.44.2024.12.31.05.20.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Dec 2024 05:20:23 -0800 (PST)
Message-ID: <7bf896d6-0cff-4be8-98db-8befa11cb6bc@gmail.com>
Date: Tue, 31 Dec 2024 14:20:21 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [fuse?] BUG: unable to handle kernel NULL pointer
 dereference in fuse_copy_one
To: syzbot <syzbot+43f6243d6c4946b26405@syzkaller.appspotmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 miklos@szeredi.hu, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
References: <6773ef06.050a0220.2f3838.04e1.GAE@google.com>
Content-Language: en-US
From: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <6773ef06.050a0220.2f3838.04e1.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/31/24 2:17 PM, syzbot wrote:
>> On 12/31/24 2:10 PM, syzbot wrote:
>>> Hello,
>>>
>>> syzbot found the following issue on:
>>>
>>> HEAD commit:    ccb98ccef0e5 Merge tag 'platform-drivers-x86-v6.13-4' of g..
>>> git tree:       upstream
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=14d4f50f980000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=86dd15278dbfe19f
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=43f6243d6c4946b26405
>>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>>> userspace arch: i386
>>>
>>> Unfortunately, I don't have any reproducer for this issue yet.
>>>
>>> Downloadable assets:
>>> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-ccb98cce.raw.xz
>>> vmlinux: https://storage.googleapis.com/syzbot-assets/75a6223b351c/vmlinux-ccb98cce.xz
>>> kernel image: https://storage.googleapis.com/syzbot-assets/beea89d50f58/bzImage-ccb98cce.xz
>>>
>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>> Reported-by: syzbot+43f6243d6c4946b26405@syzkaller.appspotmail.com
>>>
>>> BUG: kernel NULL pointer dereference, address: 0000000000000000
>>> #PF: supervisor write access in kernel mode
>>> #PF: error_code(0x0002) - not-present page
>>> PGD 6a754067 P4D 6a754067 PUD 68142067 PMD 0
>>> Oops: Oops: 0002 [#1] PREEMPT SMP KASAN NOPTI
>>> CPU: 0 UID: 0 PID: 7523 Comm: syz.2.395 Not tainted 6.13.0-rc5-syzkaller-00004-gccb98ccef0e5 #0
>>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
>>> RIP: 0010:memcpy+0xc/0x20 arch/x86/lib/memcpy_64.S:38
>>> Code: e9 44 fd ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 48 89 f8 48 89 d1 <f3> a4 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90
>>> RSP: 0018:ffffc9000370f8b0 EFLAGS: 00010293
>>> RAX: 0000000000000000 RBX: ffffc9000370fc50 RCX: 0000000000000004
>>> RDX: 0000000000000004 RSI: ffff88804ef5d710 RDI: 0000000000000000
>>> RBP: 0000000000000004 R08: 0000000000000005 R09: 0000000000000000
>>> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000004
>>> R13: 0000000000000000 R14: 0000000000000004 R15: dffffc0000000000
>>> FS:  0000000000000000(0000) GS:ffff88802b400000(0063) knlGS:00000000f5080b40
>>> CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
>>> CR2: 0000000000000000 CR3: 000000006ba72000 CR4: 0000000000352ef0
>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>> Call Trace:
>>>    <TASK>
>>>    fuse_copy_do fs/fuse/dev.c:809 [inline]
>>>    fuse_copy_one+0x1cc/0x230 fs/fuse/dev.c:1065
>>>    fuse_copy_args+0x109/0x690 fs/fuse/dev.c:1083
>>>    copy_out_args fs/fuse/dev.c:1966 [inline]
>>>    fuse_dev_do_write+0x1b0a/0x3100 fs/fuse/dev.c:2052
>>>    fuse_dev_write+0x160/0x1f0 fs/fuse/dev.c:2087
>>>    new_sync_write fs/read_write.c:586 [inline]
>>>    vfs_write+0x5ae/0x1150 fs/read_write.c:679
>>>    ksys_write+0x12b/0x250 fs/read_write.c:731
>>>    do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
>>>    __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
>>>    do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
>>>    entry_SYSENTER_compat_after_hwframe+0x84/0x8e
>>> RIP: 0023:0xf708e579
>>> Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
>>> RSP: 002b:00000000f5080500 EFLAGS: 00000293 ORIG_RAX: 0000000000000004
>>> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000020000700
>>> RDX: 0000000000000014 RSI: 00000000f73c3ff4 RDI: 0000000000000000
>>> RBP: 0000000020008380 R08: 0000000000000000 R09: 0000000000000000
>>> R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
>>> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>>>    </TASK>
>>> Modules linked in:
>>> CR2: 0000000000000000
>>> ---[ end trace 0000000000000000 ]---
>>> RIP: 0010:memcpy+0xc/0x20 arch/x86/lib/memcpy_64.S:38
>>> Code: e9 44 fd ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 48 89 f8 48 89 d1 <f3> a4 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90
>>> RSP: 0018:ffffc9000370f8b0 EFLAGS: 00010293
>>> RAX: 0000000000000000 RBX: ffffc9000370fc50 RCX: 0000000000000004
>>> RDX: 0000000000000004 RSI: ffff88804ef5d710 RDI: 0000000000000000
>>> RBP: 0000000000000004 R08: 0000000000000005 R09: 0000000000000000
>>> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000004
>>> R13: 0000000000000000 R14: 0000000000000004 R15: dffffc0000000000
>>> FS:  0000000000000000(0000) GS:ffff88802b400000(0063) knlGS:00000000f5080b40
>>> CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
>>> CR2: 0000000000000000 CR3: 000000006ba72000 CR4: 0000000000352ef0
>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>> ----------------
>>> Code disassembly (best guess):
>>>      0:	e9 44 fd ff ff       	jmp    0xfffffd49
>>>      5:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
>>>      c:	00 00
>>>      e:	90                   	nop
>>>      f:	90                   	nop
>>>     10:	90                   	nop
>>>     11:	90                   	nop
>>>     12:	90                   	nop
>>>     13:	90                   	nop
>>>     14:	90                   	nop
>>>     15:	90                   	nop
>>>     16:	90                   	nop
>>>     17:	90                   	nop
>>>     18:	90                   	nop
>>>     19:	90                   	nop
>>>     1a:	90                   	nop
>>>     1b:	90                   	nop
>>>     1c:	90                   	nop
>>>     1d:	90                   	nop
>>>     1e:	f3 0f 1e fa          	endbr64
>>>     22:	66 90                	xchg   %ax,%ax
>>>     24:	48 89 f8             	mov    %rdi,%rax
>>>     27:	48 89 d1             	mov    %rdx,%rcx
>>> * 2a:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi) <-- trapping instruction
>>>     2c:	c3                   	ret
>>>     2d:	cc                   	int3
>>>     2e:	cc                   	int3
>>>     2f:	cc                   	int3
>>>     30:	cc                   	int3
>>>     31:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
>>>     38:	00 00 00 00
>>>     3c:	66 90                	xchg   %ax,%ax
>>>     3e:	90                   	nop
>>>     3f:	90                   	nop
>>>
>>>
>>> ---
>>> This report is generated by a bot. It may contain errors.
>>> See https://goo.gl/tpsmEJ for more information about syzbot.
>>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>>
>>> syzbot will keep track of this issue. See:
>>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>>>
>>> If the report is already addressed, let syzbot know by replying with:
>>> #syz fix: exact-commit-title
>>>
>>> If you want to overwrite report's subsystems, reply with:
>>> #syz set subsystems: new-subsystem
>>> (See the list of subsystem names on the web dashboard)
>>>
>>> If the report is a duplicate of another one, reply with:
>>> #syz dup: exact-subject-of-another-report
>>>
>>> If you want to undo deduplication, reply with:
>>> #syz undup
>>>
>> Bug origin in
>>
>> commit ebe559609d7829b52c6642b581860760984faf9d
>> Author: Al Viro <viro@zeniv.linux.org.uk>
>> Date:   Fri Nov 15 10:30:14 2024 -0500
>>
>>       fs: get rid of __FMODE_NONOTIFY kludge
>>
>> #syz test
> This crash does not have a reproducer. I cannot test it.

Right, I sent this (probably correct) patch on the wrong syzbot report.


>> diff --git a/fs/notify/fanotify/fanotify_user.c
>> b/fs/notify/fanotify/fanotify_user.c
>> index 19435cd2c41f..6ff94e312232 100644
>> --- a/fs/notify/fanotify/fanotify_user.c
>> +++ b/fs/notify/fanotify/fanotify_user.c
>> @@ -1624,8 +1624,8 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int,
>> flags, unsigned int, event_f_flags)
>>           file = anon_inode_getfile_fmode("[fanotify]", &fanotify_fops,
>> group,
>>                                           f_flags, FMODE_NONOTIFY);
>>           if (IS_ERR(file)) {
>> -               fd = PTR_ERR(file);
>>                   put_unused_fd(fd);
>> +               fd = PTR_ERR(file);
>>                   goto out_destroy_group;
>>           }
>>           fd_install(fd, file);
>>

