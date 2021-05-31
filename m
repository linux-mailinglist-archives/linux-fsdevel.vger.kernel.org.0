Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AADC8395381
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 May 2021 02:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhEaAzG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 May 2021 20:55:06 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:44709 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhEaAzE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 May 2021 20:55:04 -0400
Received: by mail-il1-f199.google.com with SMTP id p6-20020a92d6860000b02901bb4be9e3c1so7029843iln.11
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 May 2021 17:53:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=hUhrULEmAcG3BBaVRE+yadHfnjAYcnaKo1TDVQBUraE=;
        b=DWWWVmJqYCJilzIY8MIEAia0d0kilqgY6PEsmFfZiA+lNxIPMci+KEognw/IDTL2SD
         CFhhlBh0cOGZJy1wpvx/LRsPxAnkgFEKm6ZN1HR2/3POXrWma5ML0GZmtvRR9QsL4co3
         RKF0RVeMQ2ksZEEf4atc9mDP8gdQdw3ff7or/iwNdzar835TCqsN39Afs70zt7leV9Bw
         xD1E3uDrUcQM5+QiSfJs1haH0KEJVVPcePzfpkJIHP6BSj3yncf04NIvMi5PxsFivMe2
         pt4suBbTFNHrgcV/MWLNmmbghJPYaUP77EHnzu6QfotAOCprx7ZHFSHU7bjhFKKSjNx/
         CuHg==
X-Gm-Message-State: AOAM531qO0yHxavEzp/Wy4jL4OP4MR4r/igQt5mbozXvpxoBGTBkDH+r
        9C+wZK9auSqYSPCvd/49U4yBuXUoZYArVPdgOPB6scTfHB7q
X-Google-Smtp-Source: ABdhPJxiThmvWnHoMqbyTTVYKrKoJrSzbVMiuKZaNvTfsn0clWaUWbsniMa3DLjwSHHKlouUZ+FGxLdhgMuPRhUKK9hovzcxfTiU
MIME-Version: 1.0
X-Received: by 2002:a92:608:: with SMTP id x8mr233711ilg.217.1622422404435;
 Sun, 30 May 2021 17:53:24 -0700 (PDT)
Date:   Sun, 30 May 2021 17:53:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000017977605c395a751@google.com>
Subject: [syzbot] kernel BUG in __page_mapcount
From:   syzbot <syzbot+1f52b3a18d5633fa7f82@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, chinwen.chang@mediatek.com,
        jannh@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        vbabka@suse.cz, walken@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7ac3a1c1 Merge tag 'mtd/fixes-for-5.13-rc4' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14559d5bd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f9f3fc7daa178986
dashboard link: https://syzkaller.appspot.com/bug?extid=1f52b3a18d5633fa7f82
compiler:       Debian clang version 11.0.1-2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11132d5bd00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1f52b3a18d5633fa7f82@syzkaller.appspotmail.com

 __mmput+0x111/0x370 kernel/fork.c:1096
 exit_mm+0x67e/0x7d0 kernel/exit.c:502
 do_exit+0x6b9/0x23d0 kernel/exit.c:813
 do_group_exit+0x168/0x2d0 kernel/exit.c:923
 get_signal+0x1770/0x2180 kernel/signal.c:2835
 arch_do_signal_or_restart+0x8e/0x6c0 arch/x86/kernel/signal.c:789
 handle_signal_work kernel/entry/common.c:147 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0xac/0x200 kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x26/0x70 kernel/entry/common.c:301
------------[ cut here ]------------
kernel BUG at include/linux/page-flags.h:686!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 10694 Comm: syz-executor.0 Not tainted 5.13.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:PageDoubleMap include/linux/page-flags.h:686 [inline]
RIP: 0010:__page_mapcount+0x2b3/0x2d0 mm/util.c:728
Code: e8 72 25 cf ff 4c 89 ff 48 c7 c6 40 fb 39 8a e8 03 4c 04 00 0f 0b e8 5c 25 cf ff 4c 89 ff 48 c7 c6 40 fc 39 8a e8 ed 4b 04 00 <0f> 0b e8 46 25 cf ff 4c 89 ff 48 c7 c6 80 fc 39 8a e8 d7 4b 04 00
RSP: 0018:ffffc90001ff7460 EFLAGS: 00010246
RAX: e8070b6faabf8b00 RBX: 00fff0000008001d RCX: ffff888047280000
RDX: 0000000000000000 RSI: 000000000000ffff RDI: 000000000000ffff
RBP: 0000000000000000 R08: ffffffff81ce2584 R09: ffffed1017363f24
R10: ffffed1017363f24 R11: 0000000000000000 R12: 1ffffd4000265001
R13: 00000000ffffffff R14: dffffc0000000000 R15: ffffea0001328000
FS:  00007f6e83636700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000568000 CR3: 000000002b559000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 page_mapcount include/linux/mm.h:873 [inline]
 smaps_account+0x79d/0x980 fs/proc/task_mmu.c:467
 smaps_pte_entry fs/proc/task_mmu.c:533 [inline]
 smaps_pte_range+0x6ed/0xfc0 fs/proc/task_mmu.c:596
 walk_pmd_range mm/pagewalk.c:89 [inline]
 walk_pud_range mm/pagewalk.c:160 [inline]
 walk_p4d_range mm/pagewalk.c:193 [inline]
 walk_pgd_range mm/pagewalk.c:229 [inline]
 __walk_page_range+0xd64/0x1ad0 mm/pagewalk.c:331
 walk_page_vma+0x3c2/0x500 mm/pagewalk.c:482
 smap_gather_stats fs/proc/task_mmu.c:769 [inline]
 show_smaps_rollup+0x49d/0xc20 fs/proc/task_mmu.c:872
 seq_read_iter+0x43a/0xcf0 fs/seq_file.c:227
 seq_read+0x445/0x5c0 fs/seq_file.c:159
 do_loop_readv_writev fs/read_write.c:761 [inline]
 do_iter_read+0x464/0x660 fs/read_write.c:803
 vfs_readv fs/read_write.c:921 [inline]
 do_preadv+0x1f7/0x340 fs/read_write.c:1013
 do_syscall_64+0x3f/0xb0 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665d9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6e83636188 EFLAGS: 00000246 ORIG_RAX: 0000000000000127
RAX: ffffffffffffffda RBX: 000000000056bf80 RCX: 00000000004665d9
RDX: 0000000000000001 RSI: 0000000020000780 RDI: 0000000000000004
RBP: 00000000004bfcb9 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf80
R13: 00007ffeb607b5df R14: 00007f6e83636300 R15: 0000000000022000
Modules linked in:
---[ end trace e65a33e7d2bffb07 ]---
RIP: 0010:PageDoubleMap include/linux/page-flags.h:686 [inline]
RIP: 0010:__page_mapcount+0x2b3/0x2d0 mm/util.c:728
Code: e8 72 25 cf ff 4c 89 ff 48 c7 c6 40 fb 39 8a e8 03 4c 04 00 0f 0b e8 5c 25 cf ff 4c 89 ff 48 c7 c6 40 fc 39 8a e8 ed 4b 04 00 <0f> 0b e8 46 25 cf ff 4c 89 ff 48 c7 c6 80 fc 39 8a e8 d7 4b 04 00
RSP: 0018:ffffc90001ff7460 EFLAGS: 00010246
RAX: e8070b6faabf8b00 RBX: 00fff0000008001d RCX: ffff888047280000
RDX: 0000000000000000 RSI: 000000000000ffff RDI: 000000000000ffff
RBP: 0000000000000000 R08: ffffffff81ce2584 R09: ffffed1017363f24
R10: ffffed1017363f24 R11: 0000000000000000 R12: 1ffffd4000265001
R13: 00000000ffffffff R14: dffffc0000000000 R15: ffffea0001328000
FS:  00007f6e83636700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000568000 CR3: 000000002b559000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
