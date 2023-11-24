Return-Path: <linux-fsdevel+bounces-3579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E15547F6B24
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 05:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 821E02817ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 04:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7521FCF;
	Fri, 24 Nov 2023 04:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f205.google.com (mail-pg1-f205.google.com [209.85.215.205])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB96D4E
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Nov 2023 20:07:19 -0800 (PST)
Received: by mail-pg1-f205.google.com with SMTP id 41be03b00d2f7-5c1c48d7226so1756687a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Nov 2023 20:07:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700798839; x=1701403639;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h0vRuOm3bYedFbYqbLhxDQ5YfI/esjpwLN9DwiNIFQ8=;
        b=rVSPeGfjN3nTRvmUi4ZwyrPnK0q7m8YzA/LKTQANNMLXwazbu0oi8Un1DJ7lhA548e
         ZpH5FHb7MCMVUysAeYBK1QUkh1UeGBQmGBKdFkUAcJmb8E/jfZzZQzYGOPl69vMHrnSc
         OEXea7sfUmo5AGzHB4oErsS91PxFTDWcPwnVc1MzATSdwn5MCD+oadtmf9KBQGzZVvQ0
         gVbf2j8ODFu9xXpp8JqXkEILtn7SS/F6tKs1YBew83PBzGQpIyIv3Lwf1AacZnwFnidf
         scTJkbte9hkXHaQ2Zh+5XVyv7IBZnKdv9+BsgOT1cGtuZUEQ2zSp6q+epN/ldP/E4KZM
         ezDg==
X-Gm-Message-State: AOJu0YztyvIne2gHmqZpFus4o3my55FK3tSj0ys/IedCHSrfEa1KHu1e
	UZqERVIoUZX1CemOt3gwfLmcABTXMLNROSZwZ9nFINmy86fe
X-Google-Smtp-Source: AGHT+IHZRsewILwuiH0XfYhzpcc84TnIwHPhnSJafwQ5uSyAIc6bJMXvt5C0NCc/uA2o/BuZhV4Ek2XWQlFjz0aEbVOdqG/fV7zE
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:903:22d2:b0:1cc:42bf:5c1f with SMTP id
 y18-20020a17090322d200b001cc42bf5c1fmr380444plg.4.1700798839555; Thu, 23 Nov
 2023 20:07:19 -0800 (PST)
Date: Thu, 23 Nov 2023 20:07:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aa8c0c060ade165e@google.com>
Subject: [syzbot] [btrfs?] memory leak in clear_state_bit
From: syzbot <syzbot+81670362c283f3dd889c@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    98b1cc82c4af Linux 6.7-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1617a610e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f1b9d95ada516af
dashboard link: https://syzkaller.appspot.com/bug?extid=81670362c283f3dd889c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e5bdd4e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13b506f0e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6b6d520f592c/disk-98b1cc82.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c2cb6183fd56/vmlinux-98b1cc82.xz
kernel image: https://storage.googleapis.com/syzbot-assets/de520cfc8b93/bzImage-98b1cc82.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/97f709bf4312/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+81670362c283f3dd889c@syzkaller.appspotmail.com

write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
BUG: memory leak
unreferenced object 0xffff888100812800 (size 64):
  comm "syz-executor358", pid 5076, jiffies 4294970941 (age 12.950s)
  hex dump (first 32 bytes):
    00 00 48 00 00 00 00 00 ff ff 48 00 00 00 00 00  ..H.......H.....
    60 b6 52 02 00 c9 ff ff 60 b6 52 02 00 c9 ff ff  `.R.....`.R.....
  backtrace:
    [<ffffffff816339bd>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff816339bd>] slab_post_alloc_hook mm/slab.h:766 [inline]
    [<ffffffff816339bd>] slab_alloc_node mm/slub.c:3478 [inline]
    [<ffffffff816339bd>] __kmem_cache_alloc_node+0x2dd/0x3f0 mm/slub.c:3517
    [<ffffffff8157e845>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1098
    [<ffffffff8215ec8b>] kmalloc include/linux/slab.h:600 [inline]
    [<ffffffff8215ec8b>] ulist_add_merge fs/btrfs/ulist.c:210 [inline]
    [<ffffffff8215ec8b>] ulist_add_merge+0xcb/0x2b0 fs/btrfs/ulist.c:198
    [<ffffffff821b3964>] add_extent_changeset fs/btrfs/extent-io-tree.c:199 [inline]
    [<ffffffff821b3964>] add_extent_changeset fs/btrfs/extent-io-tree.c:186 [inline]
    [<ffffffff821b3964>] clear_state_bit+0xa4/0x1f0 fs/btrfs/extent-io-tree.c:559
    [<ffffffff821b4b12>] __clear_extent_bit+0x432/0x840 fs/btrfs/extent-io-tree.c:731
    [<ffffffff82169c7d>] __btrfs_qgroup_release_data+0x21d/0x4a0 fs/btrfs/qgroup.c:4123
    [<ffffffff820e2737>] alloc_ordered_extent+0x57/0x2c0 fs/btrfs/ordered-data.c:159
    [<ffffffff820e2dc8>] btrfs_alloc_ordered_extent+0x78/0x4f0 fs/btrfs/ordered-data.c:274
    [<ffffffff820ab67a>] btrfs_create_dio_extent+0xba/0x1b0 fs/btrfs/inode.c:6953
    [<ffffffff820c47ac>] btrfs_get_blocks_direct_write fs/btrfs/inode.c:7343 [inline]
    [<ffffffff820c47ac>] btrfs_dio_iomap_begin+0xcbc/0x11a0 fs/btrfs/inode.c:7594
    [<ffffffff81772039>] iomap_iter+0x219/0x590 fs/iomap/iter.c:91
    [<ffffffff8177968b>] __iomap_dio_rw+0x2bb/0xd40 fs/iomap/direct-io.c:658
    [<ffffffff820c4da3>] btrfs_dio_write+0x73/0xa0 fs/btrfs/inode.c:7798
    [<ffffffff820cf774>] btrfs_direct_write fs/btrfs/file.c:1543 [inline]
    [<ffffffff820cf774>] btrfs_do_write_iter+0x454/0x960 fs/btrfs/file.c:1684
    [<ffffffff816924c4>] call_write_iter include/linux/fs.h:2020 [inline]
    [<ffffffff816924c4>] do_iter_readv_writev+0x154/0x220 fs/read_write.c:735
    [<ffffffff81693c4c>] do_iter_write+0xec/0x370 fs/read_write.c:860

write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

