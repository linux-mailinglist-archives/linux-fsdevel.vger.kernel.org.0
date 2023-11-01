Return-Path: <linux-fsdevel+bounces-1748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 589827DE48A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 17:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1B77B210F7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 16:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F4114F7E;
	Wed,  1 Nov 2023 16:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E6B6ABB
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 16:24:36 +0000 (UTC)
Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9090FD
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 09:24:31 -0700 (PDT)
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-1e9c1e06ce9so9158183fac.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Nov 2023 09:24:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698855871; x=1699460671;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5PsaySvfTDD9q1J9f+GuzFXfSH+Ayr9JaEuL3ziAbsQ=;
        b=c9wTENZrhV54APcjm2NZecCIXOkAQ2lMEX7Qp1k6zKkU+l89naCzb110LLHPZLBX6k
         j67eO2Bgs5wYqkcKqOcIKQaz/AlICBRYawB5ymQIdX751l/gRnzgL4Xl5fn8c7D/teg9
         loMRll8bUxvX7fWFpYAX/72WOW+pNTxyDJKfVK7Ct3p7y1anAgvwJI+UHcka5y/pk9mb
         F5dP8xvOJg6wUv2vqGGT6st+VruKPgtc3EaGElsrms0uh2VfXC5adampX9KaQwnq1tft
         4VIM+WK/q6FYSs+KhlCZEzPxESkl/zu2CsJqVVGxBXp11btecm8t7gUbwqGLmlmKA0U0
         /mnA==
X-Gm-Message-State: AOJu0Yz3DmmtYZLcaGd4XCA15dqf9DXMPPl1wNd/GLrJ3/nq9vNqrBUK
	psro/MfQwNFeKDKMDBdHuc7VlNEnwaEMUXI5vHEBsqYJyhqxR+bd4A==
X-Google-Smtp-Source: AGHT+IFAnetEgMZ7wlXJeiFipYMWPGJyKKSH8m+izWS1ReoWcXDpLUdoev8S4ZfvpVliPZvW8UTtjpliacQ9+CgjCuQpHdA9xuyR
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:b684:b0:1e9:c362:a397 with SMTP id
 cy4-20020a056870b68400b001e9c362a397mr8396631oab.10.1698855871148; Wed, 01
 Nov 2023 09:24:31 -0700 (PDT)
Date: Wed, 01 Nov 2023 09:24:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b987aa060919b4b1@google.com>
Subject: [syzbot] [hfs?] kernel BUG in __block_write_full_folio
From: syzbot <syzbot+c2827a62c6978df9ccc3@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8de1e7afcc1c Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=143d173b680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e6feaeda5dcbc27
dashboard link: https://syzkaller.appspot.com/bug?extid=c2827a62c6978df9ccc3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1569f36f680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0f00907f9764/disk-8de1e7af.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0502fe78c60d/vmlinux-8de1e7af.xz
kernel image: https://storage.googleapis.com/syzbot-assets/192135168cc0/Image-8de1e7af.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/0fdeae0e53d7/mount_4.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c2827a62c6978df9ccc3@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/buffer.c:1901!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 13080 Comm: syz-executor.5 Not tainted 6.6.0-rc7-syzkaller-g8de1e7afcc1c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __block_write_full_folio+0xd80/0xe24 fs/buffer.c:1901
lr : __block_write_full_folio+0xd80/0xe24 fs/buffer.c:1901
sp : ffff800098116560
x29: ffff8000981165c0 x28: fffffc0003731000 x27: 1fffe0001b970091
x26: dfff800000000000 x25: ffff0000c14f9570 x24: 0000000000000080
x23: 0000000000000002 x22: 0000000000000004 x21: ffff0000c14f9570
x20: ffff0000c14f9570 x19: 05ffc0000000811f x18: 1fffe000193d1469
x17: 0000000000000000 x16: ffff80008a71b360 x15: 0000000000000001
x14: 1fffe0003683238c x13: 0000000000000000 x12: 0000000000000003
x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
x8 : ffff0000d92f5340 x7 : ffff8000807d0e78 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000007 x1 : 0000000000000002 x0 : 0000000000000000
Call trace:
 __block_write_full_folio+0xd80/0xe24 fs/buffer.c:1901
 block_write_full_page+0x544/0x660
 hfsplus_writepage+0x30/0x40 fs/hfsplus/inode.c:33
 writeout mm/migrate.c:897 [inline]
 fallback_migrate_folio mm/migrate.c:921 [inline]
 move_to_new_folio+0x624/0xc24 mm/migrate.c:970
 migrate_folio_move mm/migrate.c:1274 [inline]
 migrate_pages_batch+0x1a2c/0x25f4 mm/migrate.c:1759
 migrate_pages_sync mm/migrate.c:1847 [inline]
 migrate_pages+0x1b9c/0x302c mm/migrate.c:1929
 compact_zone+0x274c/0x4158 mm/compaction.c:2515
 compact_node+0x234/0x3c0 mm/compaction.c:2812
 compact_nodes mm/compaction.c:2825 [inline]
 sysctl_compaction_handler+0x110/0x1d4 mm/compaction.c:2871
 proc_sys_call_handler+0x4cc/0x7cc fs/proc/proc_sysctl.c:600
 proc_sys_write+0x2c/0x3c fs/proc/proc_sysctl.c:626
 do_iter_write+0x65c/0xaa8 fs/read_write.c:860
 vfs_iter_write+0x88/0xac fs/read_write.c:901
 iter_file_splice_write+0x628/0xc58 fs/splice.c:736
 do_splice_from fs/splice.c:933 [inline]
 direct_splice_actor+0xe4/0x1c0 fs/splice.c:1142
 splice_direct_to_actor+0x2a0/0x7e4 fs/splice.c:1088
 do_splice_direct+0x20c/0x348 fs/splice.c:1194
 do_sendfile+0x4b8/0xcc4 fs/read_write.c:1254
 __do_sys_sendfile64 fs/read_write.c:1316 [inline]
 __se_sys_sendfile64 fs/read_write.c:1308 [inline]
 __arm64_sys_sendfile64+0x23c/0x3b4 fs/read_write.c:1308
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595
Code: aa1c03e0 97f37837 d4210000 97e5ff75 (d4210000) 
---[ end trace 0000000000000000 ]---


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

