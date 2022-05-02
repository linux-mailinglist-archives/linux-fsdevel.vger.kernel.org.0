Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A12A516FE7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 May 2022 14:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385139AbiEBNBV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 May 2022 09:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234640AbiEBNBT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 May 2022 09:01:19 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8F615A26
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 May 2022 05:57:48 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-ed8a3962f8so4089003fac.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 May 2022 05:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=92kzJxr/JagTlye1ZQ02wAIxiKUgetbU8Zqnl47TXPk=;
        b=NQVpWjur0bazfuJ7lwcUUDaLsbdiWunUzAjAKT/RSKl3wJWglYNjkr8egl7dcBquzM
         UWdNegXSNZuJlCq0Qv1XCm+nDYkd8FlVCJ9wGYnObHxVcWGknD4Xe6E2aSivsFbhtVe/
         6h0i1QXa7MgSZDG2gZyjkHBNJseagDAQ6Q8R5rvvhC26oxbK9/s1XpkD/ZfAm+f1nD8n
         PBfjev0DoZHnYLoLOiQgiedARDFPa+x/zCGVlyn6tPxAct3cKeA1fCUZg5NP4wsMMH7J
         bKHMKa78x++AZZqd+OXUaV76WkKWA5SDDPEi+bKeJV/rYF2RlScjO7MqE9tQtsr4/A/S
         3mZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=92kzJxr/JagTlye1ZQ02wAIxiKUgetbU8Zqnl47TXPk=;
        b=7krTh46zCJMwoMYbeA0PEGKU+u9uyhwsWs21XMkdB4zE+r7CXZ6ANpKSzbkyiEl5AU
         oBhlD/aFQVzLBDDbl3sHe8VAufQNHZsmrxNA5qh3oPAjZNw06V93LRr+RSkj1d+Wtoc/
         a44sQsB8eLzCiYyJsEI5SQORv/asxTqhgIB/7Jxzp71+3jPQJvA0VBByaSlhiU3ghhEP
         XUQZykN1k/t80E+4Rqzm75eQKKaUbWgsSPhxW9ciGoUnKSxx/Lmkl2ZHZQF2euj2F9m7
         VmiltDD5WJ2VHN2t4o2EccVjfa28nkSqbUXMaFcehbwFKDO0M5fOv5rbNxOrmKGJOz1d
         58Ig==
X-Gm-Message-State: AOAM533VE0T3IIdgVlweOH9fTWfreWhk5gIPdrbW9OEa5vlOn/b1Zeex
        OENdTTuhTBjrnc3H9deIgxW6JFqIq0VmZ/gCsFhRjQ==
X-Google-Smtp-Source: ABdhPJx0RhWhjDfZqZh/jFSSu6dd0EFe+2Z7YeE4zWijCslBp2aZzs3YDalki7qp1ItBICRjD98Yao/yjOuFnZwywjw=
X-Received: by 2002:a05:6870:d254:b0:db:12b5:da3 with SMTP id
 h20-20020a056870d25400b000db12b50da3mr6214848oac.211.1651496267855; Mon, 02
 May 2022 05:57:47 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000006b8dad05ddc47e92@google.com> <20220429120456.qcs7qbtv3o4hiiv6@wittgenstein>
 <20220429180123.fojd3kxpprqdzkgu@revolver>
In-Reply-To: <20220429180123.fojd3kxpprqdzkgu@revolver>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 2 May 2022 14:57:36 +0200
Message-ID: <CACT4Y+Zm-1XyvydWJECqUG-=shmrZSwB-_-g-LRFJMAUjFnvgA@mail.gmail.com>
Subject: Re: [syzbot] WARNING: suspicious RCU usage in mas_walk
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        syzbot <syzbot+2ee18845e89ae76342c5@syzkaller.appspotmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 29 Apr 2022 at 20:01, Liam Howlett <liam.howlett@oracle.com> wrote:
>
> * Christian Brauner <brauner@kernel.org> [220429 08:05]:
> > On Thu, Apr 28, 2022 at 10:41:27PM -0700, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    bdc61aad77fa Add linux-next specific files for 20220428
> > > git tree:       linux-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=15bb3dc2f00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=87767e89da13a759
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=2ee18845e89ae76342c5
> > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1118a5f6f00000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=125bd212f00000
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+2ee18845e89ae76342c5@syzkaller.appspotmail.com
> > >
> > > =============================
> > > WARNING: suspicious RCU usage
> > > 5.18.0-rc4-next-20220428-syzkaller #0 Not tainted
> > > -----------------------------
> > > lib/maple_tree.c:844 suspicious rcu_dereference_check() usage!
> >
> > I _think_ for maple tree stuff you want to somehow ensure that
> > Liam Howlett <liam.howlett@oracle.com>
> > gets Cced.
>
> Thanks for sending this along.  Yes, it would be best if I was somehow
> emailed for maple tree things.  I did add myself to maintainers for this
> file.

Hi,

Are you sure you want this persistently? And not biased by the fact
that this code is just added?
syzkaller does not blame anything in lib/*.c b/c the assumption is
that for things like memcpy, atomic ops, vsprintf, xarray most bugs
are really in the callers.
If we start blaming lib/maple_tree.c then later ii will be your
responsibility to reroute bugs when callers use if after freeing, etc
to these callers.



> > > other info that might help us debug this:
> > >
> > >
> > > rcu_scheduler_active = 2, debug_locks = 1
> > > 5 locks held by syz-executor842/4211:
> > >  #0: ffff88807f0ae460 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0x127/0x250 fs/read_write.c:644
> > >  #1: ffff88801df04488 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x28c/0x610 fs/kernfs/file.c:282
> > >  #2: ffff8881453b9a00 (kn->active#106){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2b0/0x610 fs/kernfs/file.c:283
> > >  #3: ffffffff8bedc528 (ksm_thread_mutex){+.+.}-{3:3}, at: run_store+0xd1/0xa60 mm/ksm.c:2917
> > >  #4: ffff88801e5e8fd8 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:117 [inline]
> > >  #4: ffff88801e5e8fd8 (&mm->mmap_lock#2){++++}-{3:3}, at: unmerge_and_remove_all_rmap_items mm/ksm.c:989 [inline]
> > >  #4: ffff88801e5e8fd8 (&mm->mmap_lock#2){++++}-{3:3}, at: run_store+0x2a5/0xa60 mm/ksm.c:2923
> > >
> > > stack backtrace:
> > > CPU: 0 PID: 4211 Comm: syz-executor842 Not tainted 5.18.0-rc4-next-20220428-syzkaller #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > > Call Trace:
> > >  <TASK>
> > >  __dump_stack lib/dump_stack.c:88 [inline]
> > >  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
> > >  mas_root lib/maple_tree.c:844 [inline]
> > >  mas_start lib/maple_tree.c:1331 [inline]
> > >  mas_state_walk lib/maple_tree.c:3745 [inline]
> > >  mas_walk+0x45e/0x670 lib/maple_tree.c:4923
> > >  mas_find+0x442/0xc90 lib/maple_tree.c:5861
> > >  vma_find include/linux/mm.h:664 [inline]
> > >  vma_next include/linux/mm.h:673 [inline]
> > >  unmerge_and_remove_all_rmap_items mm/ksm.c:990 [inline]
> > >  run_store+0x2ed/0xa60 mm/ksm.c:2923
> > >  kobj_attr_store+0x50/0x80 lib/kobject.c:824
> > >  sysfs_kf_write+0x110/0x160 fs/sysfs/file.c:136
> > >  kernfs_fop_write_iter+0x3f8/0x610 fs/kernfs/file.c:291
> > >  call_write_iter include/linux/fs.h:2059 [inline]
> > >  new_sync_write+0x38a/0x560 fs/read_write.c:504
> > >  vfs_write+0x7c0/0xac0 fs/read_write.c:591
> > >  ksys_write+0x127/0x250 fs/read_write.c:644
> > >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> > >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > RIP: 0033:0x7f6a91306e79
> > > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> > > RSP: 002b:00007ffddeb8cde8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> > > RAX: ffffffffffffffda RBX: 00000000000f4240 RCX: 00007f6a91306e79
> > > RDX: 0000000000000002 RSI: 0000000020000000 RDI: 0000000000000003
> > > RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
> > > R10: 0000000020117000 R11: 0000000000000246 R12: 000000000000cf84
> > > R13: 00007ffddeb8cdfc R14: 00007ffddeb8ce10 R15: 00007ffddeb8ce00
> > >  </TASK>
