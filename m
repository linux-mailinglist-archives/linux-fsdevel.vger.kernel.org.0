Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65A66FBB42
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 01:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbjEHXHB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 May 2023 19:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjEHXHA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 May 2023 19:07:00 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1ED46AC
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 May 2023 16:06:57 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-331a812aa1eso32980185ab.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 May 2023 16:06:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683587216; x=1686179216;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KGTxV02oDpoXmYT9QqyGUuZjQyrxrQMBqWahyhOa9N8=;
        b=E72D6FgREgnifJ7vOhzHIHI3KEK9LIWwRLXUPlxU8+hAACiOMHKhRVdTJAi2c15vmP
         k+PQqEhuyWOApcxpSOdAibdwnyht5bz8bp4N+RRMZlDUjK0oJCQfDcPKOfPkbfiCJW4I
         j/7shOHAVNIaIqwf+aCg+KWcLqKr+8VrXVlelTL5i62toWKMH7qsf2nGjWu6wXvHe39v
         xa3qwlAboTjpMVlQvuOvCHW0JZYiZ1g2FZJzeh3/aQFLXw1KNJsSiYFoTQZmCaBtjcII
         UexTt6cziQvrLJYugZcMSFDGtGmIRc7rwlZGTBW1moAcgKIn9G1zYg7Br+ToSuo5T8f9
         XPpg==
X-Gm-Message-State: AC+VfDyVk2dg6TbTg6ra3Lmsk1gJxA/Ing6Gp49H1ET8zciopldBpuGt
        2yl/Xr3GzuoV5a8xDaGQvw6POSj5ip+jQLoPx9vXXHSi6CHi
X-Google-Smtp-Source: ACHHUZ6mGxdu+oKvQum/2hUq8mig0bm5LSD51FmLjuz6i/mY7i5ZpUPydkC+n/J/vJbuJHu92v74clY1n7FNsRHJ6rZdwXBlL8FW
MIME-Version: 1.0
X-Received: by 2002:a92:d245:0:b0:32b:766c:850e with SMTP id
 v5-20020a92d245000000b0032b766c850emr6240509ilg.1.1683587216742; Mon, 08 May
 2023 16:06:56 -0700 (PDT)
Date:   Mon, 08 May 2023 16:06:56 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000000a12d05fb36b2eb@google.com>
Subject: [syzbot] [ext4?] WARNING: locking bug in ext4_xattr_inode_iget
From:   syzbot <syzbot+e44749b6ba4d0434cd47@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    1a5304fecee5 Merge tag 'parisc-for-6.4-1' of git://git.ker..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17680612280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=73a06f6ef2d5b492
dashboard link: https://syzkaller.appspot.com/bug?extid=e44749b6ba4d0434cd47
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=124dd084280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1266af88280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dd767dde3306/disk-1a5304fe.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/21e0fbeccd39/vmlinux-1a5304fe.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dada79d4407c/bzImage-1a5304fe.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/96c8988d43c2/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e44749b6ba4d0434cd47@syzkaller.appspotmail.com

EXT4-fs error (device loop0): ext4_xattr_inode_iget:436: inode #12: comm syz-executor308: casefold flag without casefold feature
------------[ cut here ]------------
Looking for class "&ea_inode->i_rwsem" with key ext4_fs_type, but found a different class "&type->i_mutex_dir_key" with the same key
WARNING: CPU: 1 PID: 4993 at kernel/locking/lockdep.c:941 look_up_lock_class+0xc2/0x140 kernel/locking/lockdep.c:938
Modules linked in:
CPU: 1 PID: 4993 Comm: syz-executor308 Not tainted 6.3.0-syzkaller-13027-g1a5304fecee5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
RIP: 0010:look_up_lock_class+0xc2/0x140 kernel/locking/lockdep.c:938
Code: 8b 16 48 c7 c0 60 91 1e 90 48 39 c2 74 46 f6 05 92 87 92 03 01 75 3d c6 05 89 87 92 03 01 48 c7 c7 40 af ea 8a e8 ee 29 a4 f6 <0f> 0b eb 26 e8 15 2f 81 f9 48 c7 c7 80 ae ea 8a 89 de e8 37 ca fd
RSP: 0018:ffffc90003b7f090 EFLAGS: 00010046
RAX: adf3f2136120b500 RBX: ffffffff9005c4e0 RCX: ffff88802d63d940
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90003b7f190 R08: ffffffff81531182 R09: ffffed1017325163
R10: 0000000000000000 R11: dffffc0000000001 R12: 0000000000000001
R13: 1ffff9200076fe20 R14: ffff888078b36800 R15: ffffffff8d0df979
FS:  0000555555f12300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005fdeb8 CR3: 000000002c0ce000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 register_lock_class+0x104/0x990 kernel/locking/lockdep.c:1290
 lockdep_init_map_type+0x37a/0x8e0 kernel/locking/lockdep.c:4875
 ext4_xattr_inode_set_class fs/ext4/xattr.c:124 [inline]
 ext4_xattr_inode_iget+0x2fa/0x5e0 fs/ext4/xattr.c:461
 ext4_xattr_inode_get+0x164/0x430 fs/ext4/xattr.c:551
 ext4_xattr_move_to_block fs/ext4/xattr.c:2640 [inline]
 ext4_xattr_make_inode_space fs/ext4/xattr.c:2742 [inline]
 ext4_expand_extra_isize_ea+0xf28/0x1d10 fs/ext4/xattr.c:2834
 __ext4_expand_extra_isize+0x2f7/0x3d0 fs/ext4/inode.c:5769
 ext4_try_to_expand_extra_isize fs/ext4/inode.c:5812 [inline]
 __ext4_mark_inode_dirty+0x53e/0x870 fs/ext4/inode.c:5890
 ext4_evict_inode+0x839/0xf20 fs/ext4/inode.c:251
 evict+0x2a4/0x620 fs/inode.c:665
 ext4_orphan_cleanup+0xb1e/0x13c0 fs/ext4/orphan.c:474
 __ext4_fill_super fs/ext4/super.c:5556 [inline]
 ext4_fill_super+0x62f7/0x6bd0 fs/ext4/super.c:5672
 get_tree_bdev+0x405/0x620 fs/super.c:1303
 vfs_get_tree+0x8c/0x270 fs/super.c:1510
 do_new_mount+0x28f/0xae0 fs/namespace.c:3039
 do_mount fs/namespace.c:3382 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f63b52faf0a
Code: 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff577b2cd8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f63b52faf0a
RDX: 0000000020000180 RSI: 00000000200000c0 RDI: 00007fff577b2cf0
RBP: 00007fff577b2cf0 R08: 00007fff577b2d30 R09: 0000000000000435
R10: 0000000000800700 R11: 0000000000000206 R12: 0000000000000004
R13: 0000555555f122c0 R14: 0000000000800700 R15: 00007fff577b2d30
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
