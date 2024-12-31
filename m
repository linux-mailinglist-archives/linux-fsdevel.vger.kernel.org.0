Return-Path: <linux-fsdevel+bounces-38299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 370049FEFCB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2024 14:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CA071882F56
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2024 13:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F0419D086;
	Tue, 31 Dec 2024 13:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYsrzwin"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B757A2D7BF;
	Tue, 31 Dec 2024 13:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735651968; cv=none; b=H76PGkFUSh1LFObbBxuY0yvR1NM4iGcItra3KyUfCIcI4VN+ITWTPG2HSOXl4gVjn4ZlkmB4Im1GBHqDtB/4Uo6rNxUfA6pKsF/V+4uO78aQZF9nFXHyfWLolWYgjhGD5aEVoRp7+aXgbfYr21Ias9LuL1qazKPtNs5QVm9CvT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735651968; c=relaxed/simple;
	bh=44ssKbjZbkMEZclKtLBr9uPHguz7ATVkdTfvzetO57g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OvAXR6nTpNx8oTGq3RwbGnRH9TpITaMpCc/qhR4nG9sgxXMlnggCarq7WikeWslAhAnC2YNDJ186YTuVoipgks0sUUZ33Uthr4quI9aBRh0oylHl2xN7eZBIvb6IZl7sbpyJUcJUniOCyJ+Tt5SGsCP+N43iWx2TxvReC7Juuno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYsrzwin; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43626213fffso64872005e9.1;
        Tue, 31 Dec 2024 05:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735651965; x=1736256765; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YYar/STfIY8FWZ7g6LrFwruW+wFnAdXqsNUZ+kjiXlA=;
        b=KYsrzwinEvowHEpM7h3ZvWj1R9zb72cQV3Xf6igBG7NpUAUGo7sUlHQMgXroIR9Ma/
         nzwBrsy6Lz9mZYTr1cufNb4orUekVJm+iVIuNczS0iuTr8+XXbQqGut4JbabWjgmgSTB
         ZwUfMoi0J+p4/TlnDvqU7cqLDcUsm8peKY/M0PExzJ8JbnLimpgqI5VjBlUhFTXPTCaW
         JmQJcEtyRXj/u9m5B3q2+yt/bOEAKq8qpoM1fWqWup2l5nN5/Qpmyz4ER4qMPniQVPoN
         xxop5KTbiOflmjUcbISn5PUhYhqugUzZHZEZJ7+gOeNnlXCNxMw/qvxka6Xah3/2eUEo
         Ckzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735651965; x=1736256765;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YYar/STfIY8FWZ7g6LrFwruW+wFnAdXqsNUZ+kjiXlA=;
        b=QbnBEINdbCpeUzK8VSEVVIab5CFbrFwGpQGwrprbwKhZ9+bsEjGOdcmmjurEUje6g6
         jkfDPRM5mGHfRTaAjiMaK08cb0t0gJP0Hj1vlaj/VObzArGXtrhV3JJ0lqlF0bnnMlAi
         Ro5NPLC7fZ4IUcGEs7YMBhpLc/0kme6HNlNg22mUA088u7DWehVh+FSvC377bMvyly8l
         V9p1FWOBTzOfqC53ltIFEq0n8uQituJUhKk08bvYI+J5DUPSsoNxoFdSUV4oVzMQluR6
         /qybvOuajcHfTLK6DkOgDdRW3cBjbgEL8lrwplzEPy94BeCOkTfv6920umjXGhv+rP8t
         mbNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhYWHofhd045lMV9quZ10jtXPxh2A3ZOuhIABuoXNC7i0cykrvnnuhVr178DlNSu1oLPQdGNKNoG2k6FVD@vger.kernel.org, AJvYcCVw712tO6u+gSvsMv3e7PLCoYg46Iboz3yygy1L0TKLDOiTflWACiJidxaMkGoioDdypCXCb0DU+eHrZqpe@vger.kernel.org
X-Gm-Message-State: AOJu0YwRYuMPLIWRiWr0rASqH4e8X8++A6KYgZz0aCjBkSN51LAZg+dd
	1XfBsTVirXK3c0QpU0VAfQHFtd3oj16UGEh3wKWuW9cE0Em2jxp1
X-Gm-Gg: ASbGncv44l1QWuS3tOGyiTU7YlP/XLcI3EOxuFzpDM42Yz6U+/QsaU/57Tt6x5XrqgE
	x7XC94roAfaR5/cd+eu+3PT/ks/Pqoe8YMIy8/anM9SLkdFwsT/55DfROAl55YqaN4cqmRmEIxl
	8DRae4qgu2TUEpLkNEec7PW0M7whkzGTY+ZJCRRsdZrFeSe/oKLXojAHA93CB5Lfao1P759BMhA
	ehz+4cjvHagrNucyKVBu1TBdsEgTj4QFlb+WfWkqDSwyObuGLjLz6/n2mQ=
X-Google-Smtp-Source: AGHT+IHf8BG5P7TQYiRTijU+yEEKG/978BiLPqdxQWN/M3oHgSorVWJlBGxVwahpsTueGivEwhgHfA==
X-Received: by 2002:a05:600c:3596:b0:434:f1bd:1e40 with SMTP id 5b1f17b1804b1-436697f917fmr328082785e9.6.1735651964631;
        Tue, 31 Dec 2024 05:32:44 -0800 (PST)
Received: from [10.0.0.4] ([78.245.221.173])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b1143dsm420145025e9.18.2024.12.31.05.32.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Dec 2024 05:32:44 -0800 (PST)
Message-ID: <783e93af-42ce-480c-bc8f-834a787bc0b3@gmail.com>
Date: Tue, 31 Dec 2024 14:32:43 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [fs?] KASAN: slab-out-of-bounds Write in __put_unused_fd
To: syzbot <syzbot+6a3aa63412255587b21b@syzkaller.appspotmail.com>,
 amir73il@gmail.com, jack@suse.cz, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, repnop@google.com,
 syzkaller-bugs@googlegroups.com, Al Viro <viro@zeniv.linux.org.uk>
References: <6773f137.050a0220.2f3838.04e2.GAE@google.com>
Content-Language: en-US
From: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <6773f137.050a0220.2f3838.04e2.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/31/24 2:27 PM, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    8155b4ef3466 Add linux-next specific files for 20241220
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=105ba818580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9c90bb7161a56c88
> dashboard link: https://syzkaller.appspot.com/bug?extid=6a3aa63412255587b21b
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e670b0580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13f42ac4580000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/98a974fc662d/disk-8155b4ef.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/2dea9b72f624/vmlinux-8155b4ef.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/593a42b9eb34/bzImage-8155b4ef.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+6a3aa63412255587b21b@syzkaller.appspotmail.com
>
> RAX: ffffffffffffffda RBX: 00007ffd163c2680 RCX: 00007f8b75a4d669
> RDX: 00007f8b75a4c8a0 RSI: 0000000000000000 RDI: 0000000000000008
> RBP: 0000000000000001 R08: 00007ffd163c2407 R09: 00000000000000a0
> R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000001
> R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
>   </TASK>
> ==================================================================
> BUG: KASAN: use-after-free in instrument_write include/linux/instrumented.h:40 [inline]
> BUG: KASAN: use-after-free in ___clear_bit include/asm-generic/bitops/instrumented-non-atomic.h:44 [inline]
> BUG: KASAN: use-after-free in __clear_open_fd fs/file.c:324 [inline]
> BUG: KASAN: use-after-free in __put_unused_fd+0xdb/0x2a0 fs/file.c:600
> Write of size 8 at addr ffff88804952aa48 by task syz-executor128/5830
>
> CPU: 1 UID: 0 PID: 5830 Comm: syz-executor128 Not tainted 6.13.0-rc3-next-20241220-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:94 [inline]
>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>   print_address_description mm/kasan/report.c:378 [inline]
>   print_report+0x169/0x550 mm/kasan/report.c:489
>   kasan_report+0x143/0x180 mm/kasan/report.c:602
>   kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
>   instrument_write include/linux/instrumented.h:40 [inline]
>   ___clear_bit include/asm-generic/bitops/instrumented-non-atomic.h:44 [inline]
>   __clear_open_fd fs/file.c:324 [inline]
>   __put_unused_fd+0xdb/0x2a0 fs/file.c:600
>   put_unused_fd+0x5c/0x70 fs/file.c:609
>   __do_sys_fanotify_init fs/notify/fanotify/fanotify_user.c:1628 [inline]
>   __se_sys_fanotify_init+0x800/0x970 fs/notify/fanotify/fanotify_user.c:1466
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f8b75a4d669
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 a1 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffd163c2668 EFLAGS: 00000246 ORIG_RAX: 000000000000012c
> RAX: ffffffffffffffda RBX: 00007ffd163c2680 RCX: 00007f8b75a4d669
> RDX: 00007f8b75a4c8a0 RSI: 0000000000000000 RDI: 0000000000000008
> RBP: 0000000000000001 R08: 00007ffd163c2407 R09: 00000000000000a0
> R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000001
> R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
>   </TASK>
>
> The buggy address belongs to the physical page:
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x4952a
> flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
> raw: 00fff00000000000 dead000000000100 dead000000000122 0000000000000000
> raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as freed
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0xcc0(GFP_KERNEL), pid 1, tgid 1 (swapper/0), ts 21408968854, free_ts 21922910177
>   set_page_owner include/linux/page_owner.h:32 [inline]
>   post_alloc_hook+0x1f4/0x240 mm/page_alloc.c:1551
>   split_free_pages+0xe1/0x2d0 mm/page_alloc.c:6374
>   alloc_contig_range_noprof+0x10eb/0x1770 mm/page_alloc.c:6551
>   __alloc_contig_pages mm/page_alloc.c:6581 [inline]
>   alloc_contig_pages_noprof+0x4b3/0x5c0 mm/page_alloc.c:6663
>   debug_vm_pgtable_alloc_huge_page+0xaf/0x100 mm/debug_vm_pgtable.c:1084
>   init_args+0x83b/0xb20 mm/debug_vm_pgtable.c:1266
>   debug_vm_pgtable+0xe0/0x550 mm/debug_vm_pgtable.c:1304
>   do_one_initcall+0x248/0x870 init/main.c:1267
>   do_initcall_level+0x157/0x210 init/main.c:1329
>   do_initcalls+0x3f/0x80 init/main.c:1345
>   kernel_init_freeable+0x435/0x5d0 init/main.c:1578
>   kernel_init+0x1d/0x2b0 init/main.c:1467
>   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> page last free pid 1 tgid 1 stack trace:
>   reset_page_owner include/linux/page_owner.h:25 [inline]
>   free_pages_prepare mm/page_alloc.c:1127 [inline]
>   free_frozen_pages+0xe0d/0x10e0 mm/page_alloc.c:2660
>   free_contig_range+0x14c/0x430 mm/page_alloc.c:6697
>   destroy_args+0x92/0x910 mm/debug_vm_pgtable.c:1017
>   debug_vm_pgtable+0x4be/0x550 mm/debug_vm_pgtable.c:1397
>   do_one_initcall+0x248/0x870 init/main.c:1267
>   do_initcall_level+0x157/0x210 init/main.c:1329
>   do_initcalls+0x3f/0x80 init/main.c:1345
>   kernel_init_freeable+0x435/0x5d0 init/main.c:1578
>   kernel_init+0x1d/0x2b0 init/main.c:1467
>   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
> Memory state around the buggy address:
>   ffff88804952a900: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>   ffff88804952a980: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> ffff88804952aa00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>                                                ^
>   ffff88804952aa80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>   ffff88804952ab00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ==================================================================
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
>
#syz test

diff --git a/fs/notify/fanotify/fanotify_user.c 
b/fs/notify/fanotify/fanotify_user.c
index 19435cd2c41f..6ff94e312232 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1624,8 +1624,8 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, 
flags, unsigned int, event_f_flags)
         file = anon_inode_getfile_fmode("[fanotify]", &fanotify_fops, 
group,
                                         f_flags, FMODE_NONOTIFY);
         if (IS_ERR(file)) {
-               fd = PTR_ERR(file);
                 put_unused_fd(fd);
+               fd = PTR_ERR(file);
                 goto out_destroy_group;
         }
         fd_install(fd, file);


