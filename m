Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780A347C4F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 18:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240394AbhLURYV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 12:24:21 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:38500 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbhLURYV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:24:21 -0500
Received: by mail-il1-f199.google.com with SMTP id h11-20020a92c26b000000b002b4a32c0ee3so230951ild.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Dec 2021 09:24:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=NR2r2axULjweOgBCAvolqftShAH89P7hUZxF3KCl6ZI=;
        b=ZPQ1P5VsX0HHKDQALIgRIHctSs18FS+Wx5MVlst/KI8F36NyWV6yPZiFaUL6o/meII
         5ro3FvIUprzvDR+EnJdgDh5XwmQo/4taswkuQCW3QbxGlo/3Y4UW7a/KOJGEI62076mQ
         8O2P5nRd3/EVMjoa9hpcpbY5DKRzXrzRRjDqyaO9W0DvlYYln1/6jiMA5ZESVtPt2Cvt
         BTD+DRClPHuyBl39KYATcLQbI0Rx/ucpsvJ0jCfqvzIbH8Ok/gquS7MDbNDo8uGayBBk
         5RWq59/kXNh7U85ufoaywuTxxIBJh7ptfkAZZaYdG2BbJtMI+pWQScfxMGbFpVyCkWrK
         keNQ==
X-Gm-Message-State: AOAM532Mom8tUqqnmcM6PolCMutPlODYxVIfWosCa/Das+XDqh4GB7R7
        mJXPLIMK+NdXIFN0MQbe7WDPkJS0khmVHjOeBxTMCN8f9ZuP
X-Google-Smtp-Source: ABdhPJyA4yEg0OFko1dn0BPJP+DPmZi62d05HfP0iJCDTKr40FizNsqIOUeZbK47sQGxlXjEH/vGThBhZDl9JHKRqeEiu4o4NWSi
MIME-Version: 1.0
X-Received: by 2002:a05:6602:140c:: with SMTP id t12mr2230992iov.187.1640107460529;
 Tue, 21 Dec 2021 09:24:20 -0800 (PST)
Date:   Tue, 21 Dec 2021 09:24:20 -0800
In-Reply-To: <00000000000017977605c395a751@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009411bb05d3ab468f@google.com>
Subject: Re: [syzbot] kernel BUG in __page_mapcount
From:   syzbot <syzbot+1f52b3a18d5633fa7f82@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, apopple@nvidia.com,
        chinwen.chang@mediatek.com, fgheet255t@gmail.com, jannh@google.com,
        khlebnikov@yandex-team.ru, kirill.shutemov@linux.intel.com,
        kirill@shutemov.name, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        peterx@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tonymarislogistics@yandex.com,
        vbabka@suse.cz, walken@google.com, willy@infradead.org,
        ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    6e0567b73052 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14c192b3b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ae22d1ee4fbca18
dashboard link: https://syzkaller.appspot.com/bug?extid=1f52b3a18d5633fa7f82
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133200fdb00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17c3102db00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1f52b3a18d5633fa7f82@syzkaller.appspotmail.com

 __mmput+0x122/0x4b0 kernel/fork.c:1113
 mmput+0x56/0x60 kernel/fork.c:1134
 exit_mm kernel/exit.c:507 [inline]
 do_exit+0xb27/0x2b40 kernel/exit.c:819
 do_group_exit+0x125/0x310 kernel/exit.c:929
 get_signal+0x47d/0x2220 kernel/signal.c:2852
 arch_do_signal_or_restart+0x2a9/0x1c40 arch/x86/kernel/signal.c:868
 handle_signal_work kernel/entry/common.c:148 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:172 [inline]
 exit_to_user_mode_prepare+0x17d/0x290 kernel/entry/common.c:207
 __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
------------[ cut here ]------------
kernel BUG at include/linux/page-flags.h:785!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 4392 Comm: syz-executor560 Not tainted 5.16.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:PageDoubleMap include/linux/page-flags.h:785 [inline]
RIP: 0010:__page_mapcount+0x2d2/0x350 mm/util.c:744
Code: e8 d3 16 d1 ff 48 c7 c6 c0 00 b6 89 48 89 ef e8 94 4e 04 00 0f 0b e8 bd 16 d1 ff 48 c7 c6 60 01 b6 89 48 89 ef e8 7e 4e 04 00 <0f> 0b e8 a7 16 d1 ff 48 c7 c6 a0 01 b6 89 4c 89 f7 e8 68 4e 04 00
RSP: 0018:ffffc90002b6f7b8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888019619d00 RSI: ffffffff81a68c12 RDI: 0000000000000003
RBP: ffffea0001bdc2c0 R08: 0000000000000029 R09: 00000000ffffffff
R10: ffffffff8903e29f R11: 00000000ffffffff R12: 00000000ffffffff
R13: 00000000ffffea00 R14: ffffc90002b6fb30 R15: ffffea0001bd8001
FS:  00007faa2aefd700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff7e663318 CR3: 0000000018c6e000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 page_mapcount include/linux/mm.h:837 [inline]
 smaps_account+0x470/0xb10 fs/proc/task_mmu.c:466
 smaps_pte_entry fs/proc/task_mmu.c:538 [inline]
 smaps_pte_range+0x611/0x1250 fs/proc/task_mmu.c:601
 walk_pmd_range mm/pagewalk.c:128 [inline]
 walk_pud_range mm/pagewalk.c:205 [inline]
 walk_p4d_range mm/pagewalk.c:240 [inline]
 walk_pgd_range mm/pagewalk.c:277 [inline]
 __walk_page_range+0xe23/0x1ea0 mm/pagewalk.c:379
 walk_page_vma+0x277/0x350 mm/pagewalk.c:530
 smap_gather_stats.part.0+0x148/0x260 fs/proc/task_mmu.c:768
 smap_gather_stats fs/proc/task_mmu.c:741 [inline]
 show_smap+0xc6/0x440 fs/proc/task_mmu.c:822
 seq_read_iter+0xbb0/0x1240 fs/seq_file.c:272
 seq_read+0x3e0/0x5b0 fs/seq_file.c:162
 vfs_read+0x1b5/0x600 fs/read_write.c:479
 ksys_read+0x12d/0x250 fs/read_write.c:619
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7faa2af6c969
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007faa2aefd288 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007faa2aff4418 RCX: 00007faa2af6c969
RDX: 0000000000002025 RSI: 0000000020000100 RDI: 0000000000000003
RBP: 00007faa2aff4410 R08: 00007faa2aefd700 R09: 0000000000000000
R10: 00007faa2aefd700 R11: 0000000000000246 R12: 00007faa2afc20ac
R13: 00007fff7e6632bf R14: 00007faa2aefd400 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 24ec93ff95e4ac3d ]---
RIP: 0010:PageDoubleMap include/linux/page-flags.h:785 [inline]
RIP: 0010:__page_mapcount+0x2d2/0x350 mm/util.c:744
Code: e8 d3 16 d1 ff 48 c7 c6 c0 00 b6 89 48 89 ef e8 94 4e 04 00 0f 0b e8 bd 16 d1 ff 48 c7 c6 60 01 b6 89 48 89 ef e8 7e 4e 04 00 <0f> 0b e8 a7 16 d1 ff 48 c7 c6 a0 01 b6 89 4c 89 f7 e8 68 4e 04 00
RSP: 0018:ffffc90002b6f7b8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888019619d00 RSI: ffffffff81a68c12 RDI: 0000000000000003
RBP: ffffea0001bdc2c0 R08: 0000000000000029 R09: 00000000ffffffff
R10: ffffffff8903e29f R11: 00000000ffffffff R12: 00000000ffffffff
R13: 00000000ffffea00 R14: ffffc90002b6fb30 R15: ffffea0001bd8001
FS:  00007faa2aefd700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff7e663318 CR3: 0000000018c6e000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

