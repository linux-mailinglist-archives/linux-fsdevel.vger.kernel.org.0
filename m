Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1EF60B4B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 20:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiJXSAa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 14:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbiJXR7k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:59:40 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E6A857E0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Oct 2022 09:40:17 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id x6-20020a056e021bc600b002fc96f780e7so9122165ilv.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Oct 2022 09:40:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zTpt42zlFi3UfDN6VLOXH7hS4FWPzl+DdSyOQH5VzIg=;
        b=sddiEuOpNG9We/jt205htrKgXGffmbzo4F0bHgNCD9nXnWtykBG8R1XCgfydjaD7h6
         zFU1K9UZ4iBZw/68Qc5qkxSIjyno/OtnB/tCmnWgoWGjVTngSZfiUhel4JMbIzpDhAH6
         tgDcULWn1zLHOi9ZQ0jHl0RTV96CBKPk4yBGgCrDx6e5cSbM1019q1v2cqmzVk22gB2I
         l2yiXWe4jN4G3qbK3woYWPl/jf1ybd7s29LGzYwqsgji/XyBIQc7Gbocecp7z2IfHe0S
         ZTDbEomR+Z/pKipTbAPcY+6DNWAScYCLZM4m7wZMYOjdEab5J4qcIoJNZydHTMo95Ytp
         phEA==
X-Gm-Message-State: ACrzQf1hEC89hyPHbes35PHOjzHLkpQssvnqE4O582Vh18z4eaHiAr3/
        oQupQpbZ+GJdlpC9HsxGIlReEUC7ootWuqD2N4kId14DHAxA
X-Google-Smtp-Source: AMsMyM53XaSnBVhNd1Qcz5Tm+F2TLcYsibmARMi7jrN9rmxnYXub1/fH9aI1qNwdC4ERrgARDlkhw3C4+z7XimkFdNisADbyQPHT
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2b92:b0:6a8:bdb5:a5d5 with SMTP id
 r18-20020a0566022b9200b006a8bdb5a5d5mr20403985iov.85.1666629520753; Mon, 24
 Oct 2022 09:38:40 -0700 (PDT)
Date:   Mon, 24 Oct 2022 09:38:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008e8b8505ebca6cc7@google.com>
Subject: [syzbot] BUG: unable to handle kernel NULL pointer dereference in filemap_free_folio
From:   syzbot <syzbot+f1eb7f33bbf683a5e1e1@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    bbed346d5a96 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=15788ec2880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a4a45d2d827c1e
dashboard link: https://syzkaller.appspot.com/bug?extid=f1eb7f33bbf683a5e1e1
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8e91bc79312/disk-bbed346d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c1cb3fb3b77e/vmlinux-bbed346d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f1eb7f33bbf683a5e1e1@syzkaller.appspotmail.com

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000050
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=000000014a8d0000
[0000000000000050] pgd=08000001532c9003, p4d=08000001532c9003, pud=0000000000000000
Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 3066 Comm: syz-executor.3 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : filemap_free_folio+0x20/0x288 mm/filemap.c:231
lr : filemap_free_folio+0x1c/0x288 mm/filemap.c:227
sp : ffff80001280b990
x29: ffff80001280b990 x28: ffff000117b4ea00 x27: 0000000000000000
x26: 0000000000000001 x25: ffff80000cb6fd9e x24: fffffffffffffffe
x23: 0000000000000000 x22: fffffc0004cfa8c0 x21: 0000000000000001
x20: ffff0001127af450 x19: fffffc0004cfa8c0 x18: 00000000000003b8
x17: ffff80000bffd6bc x16: 0000000000000002 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000003 x12: ffff80000d5f02b0
x11: ff808000083c31e8 x10: 0000000000000000 x9 : ffff8000083c31e8
x8 : 0000000000000000 x7 : ffff80000856806c x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000006 x1 : fffffc0004cfa8c0 x0 : ffff0001127af450
Call trace:
 filemap_free_folio+0x20/0x288 mm/filemap.c:231
 delete_from_page_cache_batch+0x148/0x184 mm/filemap.c:341
 truncate_inode_pages_range+0x174/0xb94 mm/truncate.c:370
 truncate_inode_pages mm/truncate.c:452 [inline]
 truncate_inode_pages_final+0x8c/0x9c mm/truncate.c:487
 nilfs_evict_inode+0x58/0x1cc fs/nilfs2/inode.c:906
 evict+0xec/0x334 fs/inode.c:665
 dispose_list fs/inode.c:698 [inline]
 evict_inodes+0x2e0/0x354 fs/inode.c:748
 generic_shutdown_super+0x50/0x190 fs/super.c:480
 kill_block_super+0x30/0x78 fs/super.c:1427
 deactivate_locked_super+0x70/0xe8 fs/super.c:332
 deactivate_super+0xd0/0xd4 fs/super.c:363
 cleanup_mnt+0x1f8/0x234 fs/namespace.c:1186
 __cleanup_mnt+0x20/0x30 fs/namespace.c:1193
 task_work_run+0xc4/0x14c kernel/task_work.c:177
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x174/0x1f0 arch/arm64/kernel/signal.c:1127
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0x9c/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
Code: aa0103f3 aa0003f4 97fb728c f940de88 (f9402914) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	aa0103f3 	mov	x19, x1
   4:	aa0003f4 	mov	x20, x0
   8:	97fb728c 	bl	0xffffffffffedca38
   c:	f940de88 	ldr	x8, [x20, #440]
* 10:	f9402914 	ldr	x20, [x8, #80] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
