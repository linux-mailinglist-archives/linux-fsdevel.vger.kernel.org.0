Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB0572B04B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jun 2023 06:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbjFKE7I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jun 2023 00:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjFKE7H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jun 2023 00:59:07 -0400
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12C5270B
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Jun 2023 21:59:05 -0700 (PDT)
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-77a1f4e92cdso366551339f.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Jun 2023 21:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686459545; x=1689051545;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=un7th58fEnBwC+OFu0f9V7Zu6p9CM5Mc2hn3wVtyZWY=;
        b=jjI2Qe3sJeOnBY4j6s/i5Pxq69CXbbMMF7g7YjzHd3rQCTVBKtMahXSob4Bdzs4WtR
         UQnlavKiQSnbGi/mWvaU36whtwJr9LuobvUxhG9N5EgUVh9QhO/QiUmA/h/lWjE02Svz
         wq1F7sk2AeNG0r3FulAj9nuIkBjRFMPl4BWJBKGsexdfNHynEqDbMTuJeMau5ei7p2Jt
         8Xp2ol1Schu28sde9mS413UJHyu97sZZeDDA+wtDyvGrCKTNHMZ9h4+mG0kx88IEXq+G
         RO1IGw5Irftk0gAzOj1ppOHnazi8E+iu1VUcgQIOYnDDnsOwmdz3DCAPKxxHESxNzf8t
         mf4Q==
X-Gm-Message-State: AC+VfDxqt1u/XlH3Ahl+gN6pR0zTXU8st0v7SM9LoYtV5N1Twj2lPGaP
        jlHCdN6E2+C4UXe8SaHYZrTK/quR1fIn1HPkRBcZ7vklls+k
X-Google-Smtp-Source: ACHHUZ4z5LBQRYRbj85KagIyc+Fgg2IO8mme8WldLcU/jJMr+sqKtwnCTB1PWB8A0dIDEXq/MdjmHpYBTrPizco5CzIYlOtWt2jK
MIME-Version: 1.0
X-Received: by 2002:a02:9444:0:b0:41f:6a82:fc22 with SMTP id
 a62-20020a029444000000b0041f6a82fc22mr2457344jai.3.1686459545188; Sat, 10 Jun
 2023 21:59:05 -0700 (PDT)
Date:   Sat, 10 Jun 2023 21:59:05 -0700
In-Reply-To: <0000000000002f18b905f6026455@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001e807e05fdd37619@google.com>
Subject: Re: [syzbot] [ntfs?] UBSAN: shift-out-of-bounds in ntfs_read_inode_mount
From:   syzbot <syzbot+c601e38d15ce8253186a@syzkaller.appspotmail.com>
To:     anton@tuxera.com, linkinjeon@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    d8b213732169 Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=12825c53280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd4213541e5ab26f
dashboard link: https://syzkaller.appspot.com/bug?extid=c601e38d15ce8253186a
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=145b7343280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17d9d453280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3d15de852c90/disk-d8b21373.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ca6234ed6efc/vmlinux-d8b21373.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0fc706ec33bb/Image-d8b21373.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/1a154c912743/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c601e38d15ce8253186a@syzkaller.appspotmail.com

ntfs: (device loop0): parse_options(): Option utf8 is no longer supported, using option nls=utf8. Please use option nls=utf8 in the future and make sure utf8 is compiled either as a module or into the kernel.
================================================================================
UBSAN: shift-out-of-bounds in fs/ntfs/inode.c:1080:43
shift exponent 267 is too large for 32-bit type 'unsigned int'
CPU: 1 PID: 5969 Comm: syz-executor382 Not tainted 6.4.0-rc5-syzkaller-gd8b213732169 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:233
 show_stack+0x2c/0x44 arch/arm64/kernel/stacktrace.c:240
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 dump_stack+0x1c/0x28 lib/dump_stack.c:113
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_shift_out_of_bounds+0x2f4/0x36c lib/ubsan.c:387
 ntfs_read_locked_inode+0x35b4/0x38e0 fs/ntfs/inode.c:1080
 ntfs_read_inode_mount+0xbb0/0x2044 fs/ntfs/inode.c:2098
 ntfs_fill_super+0x13b4/0x2314 fs/ntfs/super.c:2863
 mount_bdev+0x274/0x370 fs/super.c:1380
 ntfs_mount+0x44/0x58 fs/ntfs/super.c:3057
 legacy_get_tree+0xd4/0x16c fs/fs_context.c:610
 vfs_get_tree+0x90/0x274 fs/super.c:1510
 do_new_mount+0x25c/0x8c4 fs/namespace.c:3039
 path_mount+0x590/0xe04 fs/namespace.c:3369
 do_mount fs/namespace.c:3382 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __arm64_sys_mount+0x45c/0x594 fs/namespace.c:3568
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x244 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:191
 el0_svc+0x4c/0x160 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
================================================================================
================================================================================
UBSAN: shift-out-of-bounds in fs/ntfs/inode.c:1089:11
shift exponent 255 is too large for 32-bit type 'unsigned int'
CPU: 1 PID: 5969 Comm: syz-executor382 Not tainted 6.4.0-rc5-syzkaller-gd8b213732169 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:233
 show_stack+0x2c/0x44 arch/arm64/kernel/stacktrace.c:240
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 dump_stack+0x1c/0x28 lib/dump_stack.c:113
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_shift_out_of_bounds+0x2f4/0x36c lib/ubsan.c:387
 ntfs_read_locked_inode+0x35d0/0x38e0 fs/ntfs/inode.c:1089
 ntfs_read_inode_mount+0xbb0/0x2044 fs/ntfs/inode.c:2098
 ntfs_fill_super+0x13b4/0x2314 fs/ntfs/super.c:2863
 mount_bdev+0x274/0x370 fs/super.c:1380
 ntfs_mount+0x44/0x58 fs/ntfs/super.c:3057
 legacy_get_tree+0xd4/0x16c fs/fs_context.c:610
 vfs_get_tree+0x90/0x274 fs/super.c:1510
 do_new_mount+0x25c/0x8c4 fs/namespace.c:3039
 path_mount+0x590/0xe04 fs/namespace.c:3369
 do_mount fs/namespace.c:3382 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __arm64_sys_mount+0x45c/0x594 fs/namespace.c:3568
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x244 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:191
 el0_svc+0x4c/0x160 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
================================================================================
ntfs: (device loop0): check_mft_mirror(): $MFT and $MFTMirr (record 0) do not match.  Run ntfsfix or chkdsk.
ntfs: (device loop0): load_system_files(): $MFTMirr does not match $MFT.  Mounting read-only.  Run ntfsfix and/or chkdsk.
ntfs: (device loop0): map_mft_record(): Failed with error code 13.
ntfs: (device loop0): ntfs_read_locked_inode(): Failed with error code -13.  Marking corrupt inode 0xa as bad.  Run chkdsk.
ntfs: (device loop0): load_and_init_upcase(): Failed to load $UpCase from the volume. Using default.
ntfs: (device loop0): map_mft_record(): Failed with error code 13.
ntfs: (device loop0): ntfs_read_locked_inode(): Failed with error code -13.  Marking corrupt inode 0x4 as bad.  Run chkdsk.
ntfs: (device loop0): load_and_init_attrdef(): Failed to initialize attribute definition table.
ntfs: (device loop0): ntfs_fill_super(): Failed to load system files.


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
