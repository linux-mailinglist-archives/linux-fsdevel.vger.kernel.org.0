Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9F53539FB
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Apr 2021 23:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhDDUzZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Apr 2021 16:55:25 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:37732 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbhDDUzW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Apr 2021 16:55:22 -0400
Received: by mail-il1-f200.google.com with SMTP id m1so8282655ilu.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 04 Apr 2021 13:55:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=8eI+Fn0OWtzHAxaZWv2hy0pkmfoNaRftOIWLgV2Kr3w=;
        b=X76PKIcZvAFkuljTyQYav425T73Y+YK0B/Dpdk1Sh4niZYDcHPQnJcEhnaIk9LCXyS
         4InFe+NETf1NaCg1lhw8+9hdW2gXVAv1w0xE2/7JWrFas0RjhLeq0Vodb29uRT2oQokJ
         QJKOndVdJLKx47cf/U8Kz7mUlNOLwiGs8tl7vaZP3Aweh7vkDt/00+p2W8zu6clK29Bx
         OztRbSg1NN/EyxpL5OZa6qOLcls5zSyaI1YqDnmnJebkHj4iQWAQlGb/gAqtPdgnxpf3
         N1slJsIfYOnWStsbgHzYgFee+4G4UTb4htaDt3PqlXRvsKN20lkFqBOvQPCqN8RdmCgG
         +TDg==
X-Gm-Message-State: AOAM531liN5jXBBsIVO77qroNw4IrFm9Aqc4Y3MtZ1DMv/R1uI/6E0Vt
        rAiShLyaT7Lb5jzSqafk+tHaP0J7WBu6zQHoP7wNNYRD11ka
X-Google-Smtp-Source: ABdhPJz0gR6B0Awso2uk/2Y09F3TFmQF/w5+0P+QrYCndhU3koQPMDDyTJOmA9KOOPxYsh9d10pS67v3egpwNvuFwHdRE9SuiLQi
MIME-Version: 1.0
X-Received: by 2002:a5e:8902:: with SMTP id k2mr17342886ioj.48.1617569717122;
 Sun, 04 Apr 2021 13:55:17 -0700 (PDT)
Date:   Sun, 04 Apr 2021 13:55:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000637c4405bf2bccb8@google.com>
Subject: [syzbot] WARNING: suspicious RCU usage in __ext4_handle_dirty_metadata
From:   syzbot <syzbot+cb293a00f01b422bac7d@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    5e46d1b7 reiserfs: update reiserfs_xattrs_initialized() co..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10808831d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=78ef1d159159890
dashboard link: https://syzkaller.appspot.com/bug?extid=cb293a00f01b422bac7d

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cb293a00f01b422bac7d@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
5.12.0-rc5-syzkaller #0 Not tainted
-----------------------------
kernel/sched/core.c:8294 Illegal context switch in RCU-bh read-side critical section!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 0
7 locks held by syz-executor.2/17885:
 #0: 
ffff888014000930
 (
&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:961
 #1: ffff88802455a460 (sb_writers#5){.+.+}-{0:0}, at: ksys_write+0x12d/0x250 fs/read_write.c:658
 #2: ffff888080e91888 (&sb->s_type->i_mutex_key#9){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #2: ffff888080e91888 (&sb->s_type->i_mutex_key#9){+.+.}-{3:3}, at: ext4_dio_write_iter fs/ext4/file.c:493 [inline]
 #2: ffff888080e91888 (&sb->s_type->i_mutex_key#9){+.+.}-{3:3}, at: ext4_file_write_iter+0xaeb/0x14e0 fs/ext4/file.c:661
 #3: ffff888080e91678 (&ei->i_data_sem){++++}-{3:3}, at: ext4_map_blocks+0x5e1/0x17d0 fs/ext4/inode.c:631
 #4: ffffffff8bf718a0 (rcu_read_lock){....}-{1:2}, at: ieee80211_rx_napi+0x0/0x3d0 arch/x86/include/asm/bitops.h:207
 #5: ffff88807b381580 (&local->rx_path_lock){+.-.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:359 [inline]
 #5: ffff88807b381580 (&local->rx_path_lock){+.-.}-{2:2}, at: ieee80211_rx_handlers+0xd7/0xae60 net/mac80211/rx.c:3758
 #6: ffff8880b9d26358 (hrtimer_bases.lock){-.-.}-{2:2}, at: __run_hrtimer kernel/time/hrtimer.c:1541 [inline]
 #6: ffff8880b9d26358 (hrtimer_bases.lock){-.-.}-{2:2}, at: __hrtimer_run_queues+0x243/0xe40 kernel/time/hrtimer.c:1601

stack backtrace:
CPU: 1 PID: 17885 Comm: syz-executor.2 Not tainted 5.12.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 ___might_sleep+0x229/0x2c0 kernel/sched/core.c:8294
 __ext4_handle_dirty_metadata+0x37/0x730 fs/ext4/ext4_jbd2.c:326
 ext4_mb_mark_diskspace_used+0x991/0x1160 fs/ext4/mballoc.c:3279
 ext4_mb_new_blocks+0xd46/0x51a0 fs/ext4/mballoc.c:5000
 ext4_new_meta_blocks+0x2fe/0x360 fs/ext4/balloc.c:693
 ext4_alloc_branch fs/ext4/indirect.c:335 [inline]
 ext4_ind_map_blocks+0xb0d/0x2450 fs/ext4/indirect.c:626
 ext4_map_blocks+0x9c9/0x17d0 fs/ext4/inode.c:640
 ext4_iomap_alloc fs/ext4/inode.c:3428 [inline]
 ext4_iomap_begin+0x463/0x7a0 fs/ext4/inode.c:3478
 iomap_apply+0x177/0xb50 fs/iomap/apply.c:46
 __iomap_dio_rw+0x71b/0x1280 fs/iomap/direct-io.c:553
 iomap_dio_rw+0x30/0x90 fs/iomap/direct-io.c:641
 ext4_dio_write_iter fs/ext4/file.c:551 [inline]
 ext4_file_write_iter+0xe18/0x14e0 fs/ext4/file.c:661
 call_write_iter include/linux/fs.h:1977 [inline]
 new_sync_write+0x426/0x650 fs/read_write.c:518
 vfs_write+0x796/0xa30 fs/read_write.c:605
 ksys_write+0x12d/0x250 fs/read_write.c:658
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x466459
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fadff8ad188 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000056bf60 RCX: 0000000000466459
RDX: 0000000000248800 RSI: 0000000020000000 RDI: 0000000000000005
RBP: 00000000004bf9fb R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf60
R13: 00007ffc9e5e3caf R14: 00007fadff8ad300 R15: 0000000000022000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
