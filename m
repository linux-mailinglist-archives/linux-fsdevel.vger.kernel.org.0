Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21255EA872
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Sep 2022 16:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234726AbiIZOcA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 10:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234718AbiIZObW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:31:22 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152AB63DA
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 05:44:39 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id 63so6417694vse.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 05:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Qhszc+YoCUEZ4Tep8FDXKzzRTWZEsGztKOKRqjZ/8Ug=;
        b=WoFsjyv4q6Tfm2ocW7Dv5yo54TozO1tQujMcioOnsG0kAvFQKILgAbgo0J9/wSHyLv
         Wb6k5lH1dl+7kiRDULVvxe7hsFyp7AEEr4neiBE7UgbZhLQzDa6BlFWqEi8GpMeWgeOh
         blQy+ISAJXOJJhElDZBVInLMpHJihjvKemFgKvm3+8FkGLpG9FPLJIvZ/wgxsZiQPyAX
         uNkC/ktURkX3orlq9VetPiYHKJ7MirxRJNX4tlycNyiI5XLVFdRjKhMwWJNDzIYB8UyQ
         wj7VbileHVxqnq38/ERiwZDJd1YwcQt37X1J9NSJxYypheu0+hCCNjWpABxlvMmyq/LD
         EQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Qhszc+YoCUEZ4Tep8FDXKzzRTWZEsGztKOKRqjZ/8Ug=;
        b=zGobz7WjrE4zTDNVzBn5nuoDvgGwH0tv/lvQ/l5hxcmL5cuOT/3//XrudSxoJGRaSL
         Oj83jpYVc1qwmoCdikDQlcZgAlpxVF76lAkypYxq1ULIFzuVgB1diYKdJZbJ+S3miEA3
         dFStdOTCD0wnFJR+rkxueusxpyD7bqLEwQocPeUpA5Z4QkDa7UZgO+sBuknJJgqVRiSX
         a3IAdwRqaBGuFaEPgrdGIzt85qo9Io9G8kBrvioxoGjco9KlgGGU3L5lIFC4tRCQa0dM
         XxnaVJTNUdXPVjdgK8JkVyRf0zlpnB9PAomNS48oYMUy11/EzQ/i7uZO1UGJyXkE5SAG
         +B5g==
X-Gm-Message-State: ACrzQf2rayP+3BxqJPL36G64j7Hq3GmgrS4JTftDZuN6zfpkft5QPfSd
        1NJwa8B6gpF06W51rNR5Dg/Ck4zzLr8jbnUTg59t9UaAXCb2yA==
X-Google-Smtp-Source: AMsMyM6wLECHvniGCf/uKWif8vMvnnAB59gMJTwGi+Kun69PCV6IyGfySMKxlj8to8RaGpVkRWq9HD+29ct98pLjat8=
X-Received: by 2002:a05:6102:453:b0:398:c15c:aae6 with SMTP id
 e19-20020a056102045300b00398c15caae6mr9142240vsq.80.1664196278702; Mon, 26
 Sep 2022 05:44:38 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000046d33405e98a9daa@google.com> <YzEJ2D8kga+ZRDZx@ZenIV>
In-Reply-To: <YzEJ2D8kga+ZRDZx@ZenIV>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Mon, 26 Sep 2022 14:44:27 +0200
Message-ID: <CANp29Y4B5x5aBSfXAqmvF80BEk-_4Bzeuw1fFgMvXKvjD71-Gw@mail.gmail.com>
Subject: Re: [syzbot] WARNING: Nested lock was not taken
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     syzbot <syzbot+7475732e7177a19317a1@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "'Aleksandr Nogikh' via syzkaller-bugs" 
        <syzkaller-bugs@googlegroups.com>, ntfs3@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Thank you for the feedback!

On Mon, Sep 26, 2022 at 4:09 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sun, Sep 25, 2022 at 06:40:36PM -0700, syzbot wrote:
>
> YANTFSBUG; please Cc ntfs maintainers to that.  Folks, seriously -
> you are fuzzing a specific filesystem, you bloody well ought to Cc
> its maintainers.  Especially since your subject lines are completely
> useless for triage - "[syzbot] WARNING: Nested lock was not taken"
> says nothing whatsoever about the report in question.

We currently determine the mailing lists / people to Cc depending on
the report parsing results, in this case the bug was attributed to the
generic fs code, so it was only fs-devel that was included.
I filed an issue with a fallback mechanism in case when the reproducer
is present: https://github.com/google/syzkaller/issues/3393

>
> Ideally - fix the subject lines as well.  You want to convince
> recepients to open the mail rather than do the default "delete
> unopened", after all...

I've adjusted the report parsing rules for the "Nested lock was not
taken" case (https://github.com/google/syzkaller/pull/3394), which
should come into effect in the coming days.

>
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    c194837ebb57 Merge branch 'for-next/core', remote-tracking..
> > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> > console output: https://syzkaller.appspot.com/x/log.txt?x=16bb8574880000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=15a770deac0c935a
> > dashboard link: https://syzkaller.appspot.com/bug?extid=7475732e7177a19317a1
> > compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> > userspace arch: arm64
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a45edf080000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e66470880000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/8d8ae425e7fa/disk-c194837e.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/c540d501ebe7/vmlinux-c194837e.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+7475732e7177a19317a1@syzkaller.appspotmail.com
> >
> > loop4: detected capacity change from 0 to 264192
> > ==================================
> > WARNING: Nested lock was not taken
> > 6.0.0-rc6-syzkaller-17742-gc194837ebb57 #0 Not tainted
> > ----------------------------------
> > syz-executor253/3315 is trying to lock:
> > ffff0000c495a9d8 (&s->s_inode_list_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:349 [inline]
> > ffff0000c495a9d8 (&s->s_inode_list_lock){+.+.}-{2:2}, at: inode_sb_list_del fs/inode.c:503 [inline]
> > ffff0000c495a9d8 (&s->s_inode_list_lock){+.+.}-{2:2}, at: evict+0x90/0x334 fs/inode.c:654
> >
> > but this task is not holding:
> > Unable to handle kernel paging request at virtual address 0000000100000017
> > Mem abort info:
> >   ESR = 0x0000000096000005
> >   EC = 0x25: DABT (current EL), IL = 32 bits
> >   SET = 0, FnV = 0
> >   EA = 0, S1PTW = 0
> >   FSC = 0x05: level 1 translation fault
> > Data abort info:
> >   ISV = 0, ISS = 0x00000005
> >   CM = 0, WnR = 0
> > user pgtable: 4k pages, 48-bit VAs, pgdp=000000010a8da000
> > [0000000100000017] pgd=0800000107ed2003, p4d=0800000107ed2003, pud=0000000000000000
> > Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
> > Modules linked in:
> > CPU: 0 PID: 3315 Comm: syz-executor253 Not tainted 6.0.0-rc6-syzkaller-17742-gc194837ebb57 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
> > pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > pc : print_lock_nested_lock_not_held kernel/locking/lockdep.c:4885 [inline]
> > pc : __lock_acquire+0x7cc/0x30a4 kernel/locking/lockdep.c:5044
> > lr : print_lock_nested_lock_not_held kernel/locking/lockdep.c:4884 [inline]
> > lr : __lock_acquire+0x7c0/0x30a4 kernel/locking/lockdep.c:5044
> > sp : ffff80001289b8b0
> > x29: ffff80001289b990 x28: 0000000000000001 x27: ffff80000d30c000
> > x26: ffff0000c68d24b8 x25: ffff0000c68d24d8 x24: 0000000000000002
> > x23: ffff0000c68d24d0 x22: ffff80000d32a753 x21: ffff80000d32a712
> > x20: 0000000000040067 x19: ffff0000c68d1a80 x18: 0000000000000156
> > x17: 2b7463697665203a x16: 0000000000000002 x15: 0000000000000000
> > x14: 0000000000000000 x13: 205d353133335420 x12: 5b5d303434313530
> > x11: ff808000081c1630 x10: 0000000000000000 x9 : 30785d1575e13b00
> > x8 : 00000000ffffffff x7 : 205b5d3034343135 x6 : ffff800008195d30
> > x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
> > x2 : 0000000000000000 x1 : 0000000100000001 x0 : ffff80000cb555a1
> > Call trace:
> >  print_lock_nested_lock_not_held kernel/locking/lockdep.c:4885 [inline]
> >  __lock_acquire+0x7cc/0x30a4 kernel/locking/lockdep.c:5044
> >  lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
> >  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
> >  _raw_spin_lock+0x54/0x6c kernel/locking/spinlock.c:154
> >  spin_lock include/linux/spinlock.h:349 [inline]
> >  inode_sb_list_del fs/inode.c:503 [inline]
> >  evict+0x90/0x334 fs/inode.c:654
> >  iput_final fs/inode.c:1748 [inline]
> >  iput+0x2c4/0x324 fs/inode.c:1774
> >  ntfs_fill_super+0x1254/0x14a4 fs/ntfs/super.c:188
> >  get_tree_bdev+0x1e8/0x2a0 fs/super.c:1323
> >  ntfs_fs_get_tree+0x28/0x38 fs/ntfs3/super.c:1358
> >  vfs_get_tree+0x40/0x140 fs/super.c:1530
> >  do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
> >  path_mount+0x358/0x914 fs/namespace.c:3370
> >  do_mount fs/namespace.c:3383 [inline]
> >  __do_sys_mount fs/namespace.c:3591 [inline]
> >  __se_sys_mount fs/namespace.c:3568 [inline]
> >  __arm64_sys_mount+0x2c4/0x3c4 fs/namespace.c:3568
> >  __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
> >  invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
> >  el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
> >  do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
> >  el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
> >  el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
> >  el0t_64_sync+0x18c/0x190
> > Code: 94f84769 f94002e8 d0024dc0 91168400 (f9400d01)
> > ---[ end trace 0000000000000000 ]---
> > ----------------
> > Code disassembly (best guess):
> >    0: 94f84769        bl      0x3e11da4
> >    4: f94002e8        ldr     x8, [x23]
> >    8: d0024dc0        adrp    x0, 0x49ba000
> >    c: 91168400        add     x0, x0, #0x5a1
> > * 10: f9400d01        ldr     x1, [x8, #24] <-- trapping instruction
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > syzbot can test patches for this issue, for details see:
> > https://goo.gl/tpsmEJ#testing-patches
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/YzEJ2D8kga%2BZRDZx%40ZenIV.
