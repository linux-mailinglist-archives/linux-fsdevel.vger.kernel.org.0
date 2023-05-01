Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C96D6F34EB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 May 2023 19:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbjEARMJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 May 2023 13:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbjEARJk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 May 2023 13:09:40 -0400
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3311930D7
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 May 2023 10:06:08 -0700 (PDT)
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-760ed929d24so363043139f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 May 2023 10:06:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682960705; x=1685552705;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c7hKOKbJMl2YcfkxcJZJbcJ0r0WbQba+Lj4vLNvcKOE=;
        b=HjnFpKj0A79asFLWDQmlLTrWYUIbtTZmawjQ6P9+Oi1kD3DHwjqpw/KPjOuqcSgnGC
         2gtOmU3+O3kbPOajXcr47ua9itKXTMBk8z01/bp8LLL9pZ3wh/OCB7MopPs6EkGUqaEU
         J/GB5y0p79El8/HGwTzYmgIWAUJuH8ROUtNtIHAE8P8rAsa1HPx4QowpSpj3fR5BkK0E
         3gKr/aLam4ZMnCKyEBO5JeX2slrhUtyO/L7HGh0HRPgEjsc729bAeuppbMDTTwKhF4qa
         ioStfWKYEQv1Ge4XTOmibUUSBPLZJqQdhxqYacnxVC3W7juAACxHVbZqybGO9KNi5KzT
         xF/w==
X-Gm-Message-State: AC+VfDyRohNtxYBW2kgkiFE4Kfi36LbY0Rf7Qru9n9Gyk4KkHiM8DvFn
        fqUwFvJrTUL4pqZOJNWUh4ZS9VCbLPB6CXrOW0dvEDQZSq+n
X-Google-Smtp-Source: ACHHUZ5FVEo4YIYIOxSOTqYoStsO2FMW1fltRzaNlRIlAPBCKX6aQmNn7FN7CSNEMFtrbbLgQtxJDHAg67n5/kE75ozY5FZzLBwM
MIME-Version: 1.0
X-Received: by 2002:a02:6207:0:b0:40f:9262:b588 with SMTP id
 d7-20020a026207000000b0040f9262b588mr5871886jac.6.1682960705456; Mon, 01 May
 2023 10:05:05 -0700 (PDT)
Date:   Mon, 01 May 2023 10:05:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000534da05faa4d3d4@google.com>
Subject: [syzbot] [f2fs?] WARNING: lock held when returning to user space in f2fs_write_single_data_page
From:   syzbot <syzbot+eb6201248f684e99b9f8@syzkaller.appspotmail.com>
To:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
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

Hello,

syzbot found the following issue on:

HEAD commit:    58390c8ce1bd Merge tag 'iommu-updates-v6.4' of git://git.k..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=136e6ef8280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5eadbf0d3c2ece89
dashboard link: https://syzkaller.appspot.com/bug?extid=eb6201248f684e99b9f8
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16bbb03c280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140d36f8280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/60130779f509/disk-58390c8c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d7f0cdd29b71/vmlinux-58390c8c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/de415ad52ae4/bzImage-58390c8c.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/dc89d01cd6e9/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+eb6201248f684e99b9f8@syzkaller.appspotmail.com

syz-executor768: attempt to access beyond end of device
loop0: rw=2049, sector=77824, nr_sectors = 2048 limit=63271
syz-executor768: attempt to access beyond end of device
loop0: rw=2049, sector=79872, nr_sectors = 2048 limit=63271
================================================
WARNING: lock held when returning to user space!
6.3.0-syzkaller-12049-g58390c8ce1bd #0 Not tainted
------------------------------------------------
syz-executor768/4998 is leaving the kernel with locks still held!
1 lock held by syz-executor768/4998:
 #0: ffff88807e800448 (&sbi->node_write){++++}-{3:3}, at: f2fs_down_read fs/f2fs/f2fs.h:2087 [inline]
 #0: ffff88807e800448 (&sbi->node_write){++++}-{3:3}, at: f2fs_write_single_data_page+0xa10/0x1d50 fs/f2fs/data.c:2842


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
