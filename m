Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259556CF83E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 02:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjC3A26 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 20:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjC3A25 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 20:28:57 -0400
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5083159C4
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 17:28:56 -0700 (PDT)
Received: by mail-il1-f206.google.com with SMTP id h19-20020a056e021d9300b00318f6b50475so11032046ila.21
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 17:28:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680136135; x=1682728135;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tOFO6ix9K7hEKxkWoMSfJOZ7hN3aNlRJUo1TnYoWGk4=;
        b=dTdptCzzJJ/mq2GoxgUXqRYi7OSy7eyj+SnV9pa7xRTC1AqudO36fTHYtYpKJpGBE7
         t51XcnNFjzsYsG/g4q3dfsPNOyTLOUv/fYHqq8YMEY7yU1+yMMOZDGOYRHR7hzcO54ym
         Y0dnXsQzyFbLBegdGq8AIEfxl6gitpviwQzTsaPTSeTbTHKkZ91ZwDlXcJgOSOTOcauD
         Lme9eBojWVgA3mjTZXH43fIfOCj1jjSXk++iJTdSeUPCdC8NhItERv47ih464LdxGrdU
         PDzjQ3wiMlxLobgWzhr0foT6GN5PJ068FFXPrrC1N09TzxskUC0OkFiKn8UaKiL226j5
         YKuQ==
X-Gm-Message-State: AAQBX9ev3/LSfkcSOEncfF3Tbr84SQfS7Sxw1ZU0uf0+qvUek0SlTab2
        AhlRxFyymJ4EJ57A23vVYiheHTVtt9V2THn7e21Rjc0TaEZp
X-Google-Smtp-Source: AKy350ZFHYuEwSPSNjhCBN2Ly1E+uEsmLmnELVyr5i3aroBtkqbBciEynrcmC0cgfda+2x2aIvIRw1SbviT8xg3JbAcsjL22yeK3
MIME-Version: 1.0
X-Received: by 2002:a92:7603:0:b0:323:cab8:3c0c with SMTP id
 r3-20020a927603000000b00323cab83c0cmr11044041ilc.5.1680136135532; Wed, 29 Mar
 2023 17:28:55 -0700 (PDT)
Date:   Wed, 29 Mar 2023 17:28:55 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000088694505f8132d77@google.com>
Subject: [syzbot] [fs?] KASAN: null-ptr-deref Read in ida_free (3)
From:   syzbot <syzbot+8ac3859139c685c4f597@syzkaller.appspotmail.com>
To:     brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    da8e7da11e4b Merge tag 'nfsd-6.3-4' of git://git.kernel.or..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1266331ec80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=acdb62bf488a8fe5
dashboard link: https://syzkaller.appspot.com/bug?extid=8ac3859139c685c4f597
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11639815c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12128b1ec80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/62e9c5f4bead/disk-da8e7da1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c11aa933e2a7/vmlinux-da8e7da1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7a21bdd49c84/bzImage-da8e7da1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8ac3859139c685c4f597@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:72 [inline]
BUG: KASAN: null-ptr-deref in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: null-ptr-deref in ida_free+0x1b9/0x400 lib/idr.c:511
Read of size 8 at addr 0000000000000000 by task syz-executor237/5830

CPU: 1 PID: 5830 Comm: syz-executor237 Not tainted 6.3.0-rc3-syzkaller-00338-gda8e7da11e4b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_report+0xe6/0x540 mm/kasan/report.c:433
 kasan_report+0x176/0x1b0 mm/kasan/report.c:536
 kasan_check_range+0x283/0x290 mm/kasan/generic.c:187
 instrument_atomic_read include/linux/instrumented.h:72 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 ida_free+0x1b9/0x400 lib/idr.c:511
 mnt_release_group_id fs/namespace.c:160 [inline]
 cleanup_group_ids fs/namespace.c:2093 [inline]
 do_mount_setattr fs/namespace.c:4188 [inline]
 __do_sys_mount_setattr fs/namespace.c:4375 [inline]
 __se_sys_mount_setattr+0xc44/0x1b00 fs/namespace.c:4334
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7efc4b190919
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007efc4b142318 EFLAGS: 00000246 ORIG_RAX: 00000000000001ba
RAX: ffffffffffffffda RBX: 00007efc4b2183e8 RCX: 00007efc4b190919
RDX: 0000000000000000 RSI: 00000000200000c0 RDI: 0000000000000003
RBP: 00007efc4b2183e0 R08: 0000000000000020 R09: 0000000000000000
R10: 0000000020000140 R11: 0000000000000246 R12: 0030656c69662f2e
R13: 00007ffe5a122bdf R14: 00007efc4b142400 R15: 0000000000022000
 </TASK>
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
