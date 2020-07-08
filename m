Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945D82180A5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 09:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730171AbgGHHRv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 03:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbgGHHRu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:17:50 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645A2C061755
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2020 00:17:50 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id r22so40563351qke.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2020 00:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1bJsktqs/Kukntyns73/JkjWH8D//Ik43R5boH5UyhE=;
        b=dDF9q1dnuhvm64jzDp7J8FVZCQQ3Lcr312l7qp4jKj8+mFxaOuVmTkoRk0X0pTVyWV
         K930IcoUJ3+YEIEWr4uKHhM9qkvPzVn11m6yzf9h+FKjYw5+bDwbfEq6Ys3qXK/Gz2nJ
         6DldAItKBVJe57q9ADVXpbfQoXaUCGyz1/va3H0QF39FlMaNCP4WIYUUHN/LMLPHLNLq
         JIa80BXLin6mQxwKG3RfJ2ETi1yWaBZXYXnGvWlhsM9xcGoM6jb9aw5awFKRw/tdvZPc
         s/nE7eTnkjq++WMgY7HYsteohIWFjuG57Qf3O2ZNfVrNrLVqW5wLYEQJFXUGyxS8kBU2
         Bowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1bJsktqs/Kukntyns73/JkjWH8D//Ik43R5boH5UyhE=;
        b=ckPdFLClJvTm+Lsu9AsYty0dkuZBKQMheyh84r7/hwuUqrMsSRsy9WoPMoeVqdd/WR
         JfJzGqgYzwJ8fKPmGw9HkVaoup+0K/z5l208BwPkzOVbQrL1I9LvHHeQAx4H13Lchuia
         7e/E/zOfo9wQln4mGTsMW+s4r+anidSl4JmhGWWsDXf/LyUzbgvO+wXxXzvpNYrbsjmP
         UZiVSRqmQ4xHF3pacOnhAL+TLQdXwolLWVVO9rROrI9LyOc7iQ4eQNGcYkAi1GTfo7Kf
         FBbTikp3yGNC9UkgmFeLTMSEuJ9PR04BaA8/O7ewW5H2jE8MDKpsXATcitNm3AuMswLz
         5ZyQ==
X-Gm-Message-State: AOAM533byDeOCttA49vK9NVQUaK0t2p24z4vB57WNrjesos5f0eQtMB0
        oE64dUcUaUX4xxjqwURKGCEzkMT3Bu0304usb0Fdug==
X-Google-Smtp-Source: ABdhPJx0i8eiKdwT255I1AmqPTuEenUx24n4OSkV8lWkY5VpcIy0FLXJgF3J/6rrmGNHCVsA4iP6wtWOJ9hUO3M917o=
X-Received: by 2002:a37:4e58:: with SMTP id c85mr14498322qkb.8.1594192669338;
 Wed, 08 Jul 2020 00:17:49 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000a47ace05a9c7b825@google.com> <20200707152411.GD25069@quack2.suse.cz>
 <20200707181710.GD32331@gaia>
In-Reply-To: <20200707181710.GD32331@gaia>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 8 Jul 2020 09:17:37 +0200
Message-ID: <CACT4Y+ZLx3wT3uvsMr9EOQ35wF+tw3SN_kzgwn2B+K5dTtHrOg@mail.gmail.com>
Subject: Re: memory leak in inotify_update_watch
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Jan Kara <jack@suse.cz>,
        syzbot <syzbot+dec34b033b3479b9ef13@syzkaller.appspotmail.com>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 7, 2020 at 8:17 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Tue, Jul 07, 2020 at 05:24:11PM +0200, Jan Kara wrote:
> > On Mon 06-07-20 08:42:24, syzbot wrote:
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    7cc2a8ea Merge tag 'block-5.8-2020-07-01' of git://git.ker..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=17644c05100000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=5ee23b9caef4e07a
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=dec34b033b3479b9ef13
> > > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1478a67b100000
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+dec34b033b3479b9ef13@syzkaller.appspotmail.com
> > >
> > > BUG: memory leak
> > > unreferenced object 0xffff888115db8480 (size 576):
> > >   comm "systemd-udevd", pid 11037, jiffies 4295104591 (age 56.960s)
> > >   hex dump (first 32 bytes):
> > >     00 04 00 00 00 00 00 00 80 fd e8 15 81 88 ff ff  ................
> > >     a0 02 dd 20 81 88 ff ff b0 81 d0 09 81 88 ff ff  ... ............
> > >   backtrace:
> > >     [<00000000288c0066>] radix_tree_node_alloc.constprop.0+0xc1/0x140 lib/radix-tree.c:252
> > >     [<00000000f80ba6a7>] idr_get_free+0x231/0x3b0 lib/radix-tree.c:1505
> > >     [<00000000ec9ab938>] idr_alloc_u32+0x91/0x120 lib/idr.c:46
> > >     [<00000000aea98d29>] idr_alloc_cyclic+0x84/0x110 lib/idr.c:125
> > >     [<00000000dbad44a4>] inotify_add_to_idr fs/notify/inotify/inotify_user.c:365 [inline]
> > >     [<00000000dbad44a4>] inotify_new_watch fs/notify/inotify/inotify_user.c:578 [inline]
> > >     [<00000000dbad44a4>] inotify_update_watch+0x1af/0x2d0 fs/notify/inotify/inotify_user.c:617
> > >     [<00000000e141890d>] __do_sys_inotify_add_watch fs/notify/inotify/inotify_user.c:755 [inline]
> > >     [<00000000e141890d>] __se_sys_inotify_add_watch fs/notify/inotify/inotify_user.c:698 [inline]
> > >     [<00000000e141890d>] __x64_sys_inotify_add_watch+0x12f/0x180 fs/notify/inotify/inotify_user.c:698
> > >     [<00000000d872d7cc>] do_syscall_64+0x4c/0xe0 arch/x86/entry/common.c:359
> > >     [<000000005c62d8da>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >
> > I've been looking into this for a while and I don't think this is related
> > to inotify at all. Firstly the reproducer looks totally benign:
> >
> > prlimit64(0x0, 0xe, &(0x7f0000000280)={0x9, 0x8d}, 0x0)
> > sched_setattr(0x0, &(0x7f00000000c0)={0x38, 0x2, 0x0, 0x0, 0x9}, 0x0)
> > vmsplice(0xffffffffffffffff, 0x0, 0x0, 0x0)
> > perf_event_open(0x0, 0x0, 0xffffffffffffffff, 0xffffffffffffffff, 0x0)
> > clone(0x20000103, 0x0, 0xfffffffffffffffe, 0x0, 0xffffffffffffffff)
> > syz_mount_image$vfat(0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0)
> >
> > So we seem to set SCHED_RR class and prio 9 to itself, the rest of syscalls
> > seem to be invalid and should fail. Secondly, the kernel log shows that we
> > hit OOM killer frequently and after one of these kills, many leaked objects
> > (among them this radix tree node from inotify idr) are reported. I'm not
> > sure if it could be the leak detector getting confused (e.g. because it got
> > ENOMEM at some point) or something else... Catalin, any idea?
>
> Kmemleak never performs well under heavy load. Normally you'd need to
> let the system settle for a bit before checking whether the leaks are
> still reported. The issue is caused by the memory scanning not stopping
> the whole machine, so pointers may be hidden in registers on different
> CPUs (list insertion/deletion for example causes transient kmemleak
> confusion).
>
> I think the syzkaller guys tried a year or so ago to run it in parallel
> with kmemleak and gave up shortly. The proposal was to add a "stopscan"
> command to kmemleak which would do this under stop_machine(). However,
> no-one got to implementing it.
>
> So, in this case, does the leak still appear with the reproducer, once
> the system went idle?

Hi Catalin,

This report came from syzbot, so obviously we did not give up :)

We don't run scanning in parallel with fuzzing and do a very intricate
multi-step dance to overcome false positives:
https://github.com/google/syzkaller/blob/5962a2dc88f6511b77100acdf687c1088f253f6b/executor/common_linux.h#L3407-L3478
and only report leaks that are reproducible.
So far I have not seen any noticable amount of false positives, and
you can see 70 already fixed leaks here:
https://syzkaller.appspot.com/upstream/fixed?manager=ci-upstream-gce-leak
https://syzkaller.appspot.com/upstream?manager=ci-upstream-gce-leak
