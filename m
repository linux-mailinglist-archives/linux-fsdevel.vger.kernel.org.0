Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137305A2F8C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 21:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344574AbiHZTCi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Aug 2022 15:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236131AbiHZTCh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Aug 2022 15:02:37 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C813C93508
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Aug 2022 12:02:35 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id w7-20020a5d9607000000b0067c6030dfb8so1424434iol.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Aug 2022 12:02:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=dq5VkqjfDnwWLl/bsXasVEegglasUUDpYrJ8qiZGvfU=;
        b=Nr+JolYqM+I+RPHFyGwTguII8qyNFILLdtAPzVwdRuZuluthb4b21z4b6OWwGIHmo1
         GCIH0vpY9TtCG5AxbRAInvjMFWBpxRr/Mz6qcN3eXskkc+7u/p0AlBI+J5xu+G0qCXOW
         Azb6Dy9oYl9ub0H31x/Je46hNcXQH+VbTXw1orCL9imRIbPxzpGbmfMIzQxaBSiZn3h/
         yI5xp7iRpAHCt8TYp12ILUanKbAsEl70z8fhHrtbmFs0pV/xzm9S3ogdn8IAnY3BlLIx
         KRdIF1BSohAeUD5oQkMjk9YF0wdOLF8O5R+3H1x+Hm2sRg+hraLvhn06c1hsrQCEr2Uo
         152A==
X-Gm-Message-State: ACgBeo0Y+U2pHzisHqHLJP7ci/sRzvRJq/wtIdXOVIkXqdno8Q2oiahD
        wTFRNwr5TU6U3dIO94CzWAjPL+ipgQjs9lHl0xCPG7Tq6IKB
X-Google-Smtp-Source: AA6agR7sf7ZBSqvlIc2tOb7t/wHMmhB/lfBoygiWWaHxWN7e36f0wmiKls7yee9YOFkHWyaDrSb2MeNbK2RPW4n+4wvc/RgZ6rR0
MIME-Version: 1.0
X-Received: by 2002:a92:cd8f:0:b0:2df:ff82:2e5f with SMTP id
 r15-20020a92cd8f000000b002dfff822e5fmr4777330ilb.72.1661540554818; Fri, 26
 Aug 2022 12:02:34 -0700 (PDT)
Date:   Fri, 26 Aug 2022 12:02:34 -0700
In-Reply-To: <000000000000d5b4fe05e7127662@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008cccea05e7298e1f@google.com>
Subject: Re: [syzbot] BUG: unable to handle kernel NULL pointer dereference in set_page_dirty
From:   syzbot <syzbot+775a3440817f74fddb8c@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    a41a877bc12d Merge branch 'for-next/fixes' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=104eb875080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5cea15779c42821c
dashboard link: https://syzkaller.appspot.com/bug?extid=775a3440817f74fddb8c
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15aebce7080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=167b5e33080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+775a3440817f74fddb8c@syzkaller.appspotmail.com

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
Mem abort info:
  ESR = 0x0000000086000004
  EC = 0x21: IABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
user pgtable: 4k pages, 48-bit VAs, pgdp=0000000109ee4000
[0000000000000000] pgd=0000000000000000, p4d=0000000000000000
Internal error: Oops: 86000004 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 3045 Comm: syz-executor330 Not tainted 6.0.0-rc2-syzkaller-16455-ga41a877bc12d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : 0x0
lr : folio_mark_dirty+0xbc/0x208 mm/page-writeback.c:2748
sp : ffff800012783970
x29: ffff800012783970 x28: 0000000000000000 x27: ffff800012783b08
x26: 0000000000000001 x25: 0000000000000400 x24: 0000000000000001
x23: ffff0000c736e000 x22: 0000000000000045 x21: 05ffc00000000015
x20: ffff0000ca7403b8 x19: fffffc00032ec600 x18: 0000000000000181
x17: ffff80000c04d6bc x16: ffff80000dbb8658 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
x11: ff808000083e9814 x10: 0000000000000000 x9 : ffff8000083e9814
x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
x5 : ffff0000cbb19000 x4 : ffff0000cb3d2000 x3 : ffff0000cbb18f80
x2 : fffffffffffffff0 x1 : fffffc00032ec600 x0 : ffff0000ca7403b8
Call trace:
 0x0
 set_page_dirty+0x38/0xbc mm/folio-compat.c:62
 f2fs_update_meta_page+0x80/0xa8 fs/f2fs/segment.c:2369
 do_checkpoint+0x794/0xea8 fs/f2fs/checkpoint.c:1522
 f2fs_write_checkpoint+0x3b8/0x568 fs/f2fs/checkpoint.c:1679
 f2fs_issue_checkpoint+0x1b0/0x234
 f2fs_sync_fs+0x8c/0xc8 fs/f2fs/super.c:1651
 sync_filesystem+0xe0/0x134 fs/sync.c:66
 generic_shutdown_super+0x38/0x190 fs/super.c:474
 kill_block_super+0x30/0x78 fs/super.c:1427
 kill_f2fs_super+0x140/0x184 fs/f2fs/super.c:4544
 deactivate_locked_super+0x70/0xd4 fs/super.c:332
 deactivate_super+0xb8/0xbc fs/super.c:363
 cleanup_mnt+0x1f8/0x234 fs/namespace.c:1186
 __cleanup_mnt+0x20/0x30 fs/namespace.c:1193
 task_work_run+0xc4/0x208 kernel/task_work.c:177
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x174/0x1d0 arch/arm64/kernel/signal.c:1127
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0x9c/0x150 arch/arm64/kernel/entry-common.c:625
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
 el0t_64_sync+0x18c/0x190
Code: bad PC value
---[ end trace 0000000000000000 ]---

