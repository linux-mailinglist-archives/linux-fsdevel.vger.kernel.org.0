Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59AE47858A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 15:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235508AbjHWNO7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 09:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235529AbjHWNOu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:14:50 -0400
Received: from mail-pj1-f79.google.com (mail-pj1-f79.google.com [209.85.216.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0073610E5
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 06:14:40 -0700 (PDT)
Received: by mail-pj1-f79.google.com with SMTP id 98e67ed59e1d1-26d4cb043a9so6581690a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 06:14:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692796480; x=1693401280;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RFApB1Y2v2rveRjo6nnTdcFEwXfzQreGSzlC+r9Qk20=;
        b=jln+cBOf9LsDSfSs0x0s1hb9dtuD4kw+nZ9u5xER2LYr4EG16YhznOL/m/b7YNKkiq
         9q+N8Lr28GYQCw86Ec53RDlCFh14SB2/rHeoxBoEqumhpkJfSCWP8NBNL/1vL13cB8vb
         NDUoR16fM0vkrFBBhn7sFYUeEQVBhuYbjidXcrQfUc0q9fJIKmlXfNbuqUY0RfEvLlsB
         /pH47zzcc8YJZBnH0GoiNn+G+X3ujqkRUfku79IHvjIeIqJhAyKBQ0B3TMQCyUXbA9do
         6Gj+4VfcVmkCaRjGMN9uJiVV3P/bpdi4W+8VUX0Vq6llRjoYo6wZ6bmCCDsmBSurRlt3
         VEXw==
X-Gm-Message-State: AOJu0YxneHNDkFY7gKG/xAirmtdRfno9rg20D9TBaXyyRif9wbzKlkiI
        9bvqj9umZeT+m/Pimlw2Ha1sJIaGauR0QH6/ujiLn2uV31zc
X-Google-Smtp-Source: AGHT+IEX1yqAYhiEN1pueWO1LpFxWdmeDTE28VzHBsnz4BeGwdO3pqmg1pnm5QXJ79UtLgqPj9IJbjT/KmqHF23jlB6WpQP7/VJR
MIME-Version: 1.0
X-Received: by 2002:a17:90a:ea07:b0:26d:43f3:eef1 with SMTP id
 w7-20020a17090aea0700b0026d43f3eef1mr3215711pjy.7.1692796480428; Wed, 23 Aug
 2023 06:14:40 -0700 (PDT)
Date:   Wed, 23 Aug 2023 06:14:40 -0700
In-Reply-To: <0000000000006f098a06000d10a5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e4a538060396e4e9@google.com>
Subject: Re: [syzbot] [ntfs3?] UBSAN: array-index-out-of-bounds in truncate_inode_pages_final
From:   syzbot <syzbot+e295147e14b474e4ad70@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    35e2132122ba Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=16924717a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4f6a8d3c0bd07f11
dashboard link: https://syzkaller.appspot.com/bug?extid=e295147e14b474e4ad70
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a2eeb0680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12224553a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6808a9c4c8df/disk-35e21321.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/85a6cfc7b474/vmlinux-35e21321.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a3958fe16b1c/Image-35e21321.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b81535b17c61/mount_1.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e295147e14b474e4ad70@syzkaller.appspotmail.com

================================================================================
UBSAN: array-index-out-of-bounds in ./include/linux/pagevec.h:74:2
index 255 is out of range for type 'struct folio *[15]'
CPU: 1 PID: 12841 Comm: syz-executor402 Not tainted 6.5.0-rc7-syzkaller-g35e2132122ba #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:233
 show_stack+0x2c/0x44 arch/arm64/kernel/stacktrace.c:240
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 dump_stack+0x1c/0x28 lib/dump_stack.c:113
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_out_of_bounds+0xfc/0x148 lib/ubsan.c:348
 folio_batch_add include/linux/pagevec.h:74 [inline]
 find_lock_entries+0x8fc/0xd84 mm/filemap.c:2089
 truncate_inode_pages_range+0x1b0/0xf74 mm/truncate.c:364
 truncate_inode_pages mm/truncate.c:449 [inline]
 truncate_inode_pages_final+0x90/0xc0 mm/truncate.c:484
 ntfs_evict_inode+0x20/0x48 fs/ntfs3/inode.c:1790
 evict+0x260/0x68c fs/inode.c:664
 iput_final fs/inode.c:1788 [inline]
 iput+0x734/0x818 fs/inode.c:1814
 ntfs_fill_super+0x3648/0x3f90 fs/ntfs3/super.c:1420
 get_tree_bdev+0x378/0x570 fs/super.c:1318
 ntfs_fs_get_tree+0x28/0x38 fs/ntfs3/super.c:1647
 vfs_get_tree+0x90/0x274 fs/super.c:1519
 do_new_mount+0x25c/0x8c8 fs/namespace.c:3335
 path_mount+0x590/0xe04 fs/namespace.c:3662
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount fs/namespace.c:3861 [inline]
 __arm64_sys_mount+0x45c/0x594 fs/namespace.c:3861
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x58/0x16c arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
================================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
