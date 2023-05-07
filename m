Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFA86F9836
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 May 2023 12:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjEGKax (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 May 2023 06:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjEGKau (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 May 2023 06:30:50 -0400
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1F411605
        for <linux-fsdevel@vger.kernel.org>; Sun,  7 May 2023 03:30:45 -0700 (PDT)
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-766588051b3so215163539f.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 May 2023 03:30:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683455445; x=1686047445;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R3i9BTrrWyZRXgDeCeh8X6ei2ZhGQwyd2lT0wG6mo5w=;
        b=EMPQvD5wIXYAevvxtjCCqJsmXES/o31rWqg1qgoBXxSiWCOx9SWFVqIuCKF4PdkOE7
         Q3w7qQ2sZiz3mQSxWlOQQzQHk4GfNUcPeh8sNCMz7020gFTRO4PYQ6ZnniOr2nFscgpa
         e8xIRkMqBdDpKfjXajxUEN7Zw55uOYLmsB9CDoiSG7j5HZvc/OWgnvypTfVBe8HxyMaI
         JPGP+ILMJkhKLSNBMLHxhJ6Hwae9o1wK8r6Kbd8tzV9wwLV3MknVR3K9YXnAca9RQPxi
         H30KbhYc7vh+KOHjSiO5u1aTRkYwJa0VGGMv2cyHcoqkogkT4Ng1mwizfH+qiPl6V48h
         9aeA==
X-Gm-Message-State: AC+VfDzAfaZe3AlANxCITJP24I7Xebe6RsKNO1RmQql7uZsiWY72BNXc
        psdbeweG7AUwEAvILix4ixpAVwd9mIv2yL4p58DoT+NW4vbS
X-Google-Smtp-Source: ACHHUZ5Rd77fpRngyXkiOdx+onEX7USaI4BFCY474UTVlAA9W9+UqdhbdJjiaq2c97eFhsMb9/oJippPnBdxq5iRihDWpe/X6G6Y
MIME-Version: 1.0
X-Received: by 2002:a6b:d915:0:b0:760:d92a:2f4a with SMTP id
 r21-20020a6bd915000000b00760d92a2f4amr3121680ioc.2.1683455445150; Sun, 07 May
 2023 03:30:45 -0700 (PDT)
Date:   Sun, 07 May 2023 03:30:45 -0700
In-Reply-To: <000000000000b0cabf05f90bcb15@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cdb0e805fb180316@google.com>
Subject: Re: [syzbot] [ntfs3?] general protection fault in ni_readpage_cmpr
From:   syzbot <syzbot+af224b63e76b2d869bc3@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    14f8db1c0f9a Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=14ecc3b0280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a837a8ba7e88bb45
dashboard link: https://syzkaller.appspot.com/bug?extid=af224b63e76b2d869bc3
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=168ce182280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1308c522280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ad6ce516eed3/disk-14f8db1c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1f38c2cc7667/vmlinux-14f8db1c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d795115eee39/Image-14f8db1c.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/8a3eac658458/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+af224b63e76b2d869bc3@syzkaller.appspotmail.com

 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x258 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:193
 el0_svc+0x4c/0x15c arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
Unable to handle kernel paging request at virtual address dfff800000000001
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
[dfff800000000001] address between user and kernel address ranges
Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 5930 Comm: syz-executor385 Not tainted 6.3.0-rc7-syzkaller-g14f8db1c0f9a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : _compound_head include/linux/page-flags.h:251 [inline]
pc : unlock_page+0x28/0x74 mm/folio-compat.c:21
lr : unlock_page+0x18/0x74 mm/folio-compat.c:20
sp : ffff80001e4d6fa0
x29: ffff80001e4d6fa0 x28: 0000000000000007 x27: 00000000fffffff4
x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
x23: ffff0000d9371208 x22: 0000000000000001 x21: dfff800000000000
x20: 0000000000000008 x19: 0000000000000000 x18: 1fffe0003684a5b6
x17: 0000000000000000 x16: ffff8000084fa124 x15: 0000000000000001
x14: 0000000000000000 x13: 0000000000000001 x12: 0000000000000001
x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000001
x8 : dfff800000000000 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff80001e4d61d8 x4 : ffff800015e4ccc0 x3 : ffff80000968c944
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 _compound_head include/linux/page-flags.h:251 [inline]
 unlock_page+0x28/0x74 mm/folio-compat.c:21
 ni_readpage_cmpr+0x474/0x798 fs/ntfs3/frecord.c:2149
 ntfs_read_folio+0x14c/0x1c0 fs/ntfs3/inode.c:703
 filemap_read_folio+0x14c/0x39c mm/filemap.c:2424
 filemap_create_folio mm/filemap.c:2552 [inline]
 filemap_get_pages+0xb3c/0x1640 mm/filemap.c:2605
 filemap_read+0x354/0xc98 mm/filemap.c:2693
 generic_file_read_iter+0xa0/0x450 mm/filemap.c:2840
 ntfs_file_read_iter+0x184/0x1e0 fs/ntfs3/file.c:758
 call_read_iter include/linux/fs.h:1845 [inline]
 generic_file_splice_read+0x1e0/0x508 fs/splice.c:402
 do_splice_to fs/splice.c:885 [inline]
 splice_direct_to_actor+0x30c/0x944 fs/splice.c:956
 do_splice_direct+0x1f4/0x334 fs/splice.c:1065
 do_sendfile+0x4bc/0xc70 fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1323 [inline]
 __se_sys_sendfile64 fs/read_write.c:1309 [inline]
 __arm64_sys_sendfile64+0x160/0x3b4 fs/read_write.c:1309
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x258 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:193
 el0_svc+0x4c/0x15c arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
Code: d2d00008 91002274 f2fbffe8 d343fe89 (38686928) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	d2d00008 	mov	x8, #0x800000000000        	// #140737488355328
   4:	91002274 	add	x20, x19, #0x8
   8:	f2fbffe8 	movk	x8, #0xdfff, lsl #48
   c:	d343fe89 	lsr	x9, x20, #3
* 10:	38686928 	ldrb	w8, [x9, x8] <-- trapping instruction


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
