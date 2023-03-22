Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74006C4511
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 09:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjCVIey (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 04:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjCVIes (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 04:34:48 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9451D93D
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 01:34:38 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id q8-20020a92ca48000000b00320ed437f04so9180165ilo.19
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 01:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679474078;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wRMzSlulrwzbuSJ2HiNXW+2IVvehimYVDd96RcKYNA0=;
        b=aUljQpJifcvj+EcI354+AwvDN6yo5gqI30hamfbCMZ3QsfQ00RtdmjoSqruxhOxoYA
         SukowLrTFhNyHTvtok4gz7Z4qOLyDvbbJxk2QOhwNOilIWau18j+xisZT1t5WzR2izfT
         6m7Tf3fEIhEVs6fm+0RJWZOSlhky9iIXT040TaVLQmZuJR8ZLSOxXOPEEclIoOXbyNAS
         Vs73YK4JUavM9qWrbC20Kg4yrwUtNauixDAg0fCuBwx1eTQd25NgmEUvocScc9TntHGp
         vrK/xkwoBbjGBXld1pnO9H/lJkWHnI6MuJvfW9srM51DD9Mphex0iODY2lPh+75o078b
         cHwQ==
X-Gm-Message-State: AO0yUKWWr6WumVdzC4jCuBAMPk/Yx9v5+co7lp+XKkan3QK5rDnrC6WA
        Hya93N7cZHlymp3HpK3FQNIyOGZRPMuA5LUNaHqVHM0HIYua
X-Google-Smtp-Source: AK7set+tI2Y78k2+QDv4uXZRXjvDYAAv/HXX/9DmxwQd3c4SXLSXWsPSHfIbrXd+kuOZLZabV9dj97JlmKi8efueuIpj31O3HlIj
MIME-Version: 1.0
X-Received: by 2002:a6b:701a:0:b0:745:c41a:8f0f with SMTP id
 l26-20020a6b701a000000b00745c41a8f0fmr2405904ioc.2.1679474077859; Wed, 22 Mar
 2023 01:34:37 -0700 (PDT)
Date:   Wed, 22 Mar 2023 01:34:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d207ef05f7790759@google.com>
Subject: [syzbot] [xfs?] KASAN: null-ptr-deref Write in xfs_filestream_select_ag
From:   syzbot <syzbot+87466712bb342796810a@syzkaller.appspotmail.com>
To:     dchinner@redhat.com, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    17214b70a159 Merge tag 'fsverity-for-linus' of git://git.k..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17938109c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d40f6d44826f6cf7
dashboard link: https://syzkaller.appspot.com/bug?extid=87466712bb342796810a
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1492946ac80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e45ad6c80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d166fda7fbbd/disk-17214b70.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0c16461022b9/vmlinux-17214b70.xz
kernel image: https://storage.googleapis.com/syzbot-assets/53e9e40da8bb/bzImage-17214b70.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/52081e4a3707/mount_0.gz

The issue was bisected to:

commit 3e43877a9dac13771ac722462c87bea0bdc50759
Author: Dave Chinner <dchinner@redhat.com>
Date:   Sun Feb 12 22:14:55 2023 +0000

    xfs: remove xfs_filestream_select_ag() longest extent check

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13cee69ac80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=102ee69ac80000
console output: https://syzkaller.appspot.com/x/log.txt?x=17cee69ac80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+87466712bb342796810a@syzkaller.appspotmail.com
Fixes: 3e43877a9dac ("xfs: remove xfs_filestream_select_ag() longest extent check")

XFS (loop0): metadata I/O error in "xfs_read_agf+0x2c9/0x600" at daddr 0x1 len 1 error 117
XFS (loop0): page discard on page ffffea0001c573c0, inode 0x2a, pos 0.
==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read_write include/linux/instrumented.h:102 [inline]
BUG: KASAN: null-ptr-deref in atomic_inc include/linux/atomic/atomic-instrumented.h:190 [inline]
BUG: KASAN: null-ptr-deref in xfs_filestream_pick_ag fs/xfs/xfs_filestream.c:156 [inline]
BUG: KASAN: null-ptr-deref in xfs_filestream_create_association fs/xfs/xfs_filestream.c:301 [inline]
BUG: KASAN: null-ptr-deref in xfs_filestream_select_ag+0x14e5/0x1ca0 fs/xfs/xfs_filestream.c:372
Write of size 4 at addr 00000000000001c0 by task kworker/u4:3/47

CPU: 0 PID: 47 Comm: kworker/u4:3 Not tainted 6.3.0-rc3-syzkaller-00012-g17214b70a159 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
Workqueue: writeback wb_workfn (flush-7:0)
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_report+0xe6/0x540 mm/kasan/report.c:433
 kasan_report+0x176/0x1b0 mm/kasan/report.c:536
 kasan_check_range+0x283/0x290 mm/kasan/generic.c:187
 instrument_atomic_read_write include/linux/instrumented.h:102 [inline]
 atomic_inc include/linux/atomic/atomic-instrumented.h:190 [inline]
 xfs_filestream_pick_ag fs/xfs/xfs_filestream.c:156 [inline]
 xfs_filestream_create_association fs/xfs/xfs_filestream.c:301 [inline]
 xfs_filestream_select_ag+0x14e5/0x1ca0 fs/xfs/xfs_filestream.c:372
 xfs_bmap_btalloc_filestreams fs/xfs/libxfs/xfs_bmap.c:3558 [inline]
 xfs_bmap_btalloc+0xffa/0x28a0 fs/xfs/libxfs/xfs_bmap.c:3672
 xfs_bmapi_allocate+0x647/0xf30
 xfs_bmapi_convert_delalloc+0x98f/0x1310 fs/xfs/libxfs/xfs_bmap.c:4554
 xfs_convert_blocks fs/xfs/xfs_aops.c:266 [inline]
 xfs_map_blocks+0x780/0x1090 fs/xfs/xfs_aops.c:389
 iomap_writepage_map fs/iomap/buffered-io.c:1641 [inline]
 iomap_do_writepage+0x941/0x2ee0 fs/iomap/buffered-io.c:1803
 write_cache_pages+0x89e/0x12c0 mm/page-writeback.c:2473
 iomap_writepages+0x68/0x240 fs/iomap/buffered-io.c:1820
 xfs_vm_writepages+0x139/0x1a0 fs/xfs/xfs_aops.c:513
 do_writepages+0x3a6/0x670 mm/page-writeback.c:2551
 __writeback_single_inode+0x155/0xfb0 fs/fs-writeback.c:1600
 writeback_sb_inodes+0x8ef/0x11d0 fs/fs-writeback.c:1891
 wb_writeback+0x458/0xc70 fs/fs-writeback.c:2065
 wb_do_writeback fs/fs-writeback.c:2208 [inline]
 wb_workfn+0x400/0xff0 fs/fs-writeback.c:2248
 process_one_work+0x8a0/0x10e0 kernel/workqueue.c:2390
 worker_thread+0xa63/0x1210 kernel/workqueue.c:2537
 kthread+0x270/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
