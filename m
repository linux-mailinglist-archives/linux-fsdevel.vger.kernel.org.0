Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046AA6EAD99
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 16:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbjDUO7A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 10:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbjDUO6z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 10:58:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785F3A274;
        Fri, 21 Apr 2023 07:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=T9LXOdWMRXqaqS22weQhZo+/CD9S/0W7jBzVygMsK3Y=; b=InAJCSPOAlj1EKhhmNXf/r3IkX
        6oW/gCF1ILhOM4eo3jviU83s+rVoOoIeFKFv57K4WyTkSf7ji0/t7AfrGlT9txK4DdnMOQ571f91R
        PzYDogvvJM8tmfcZK8Jbs0R2aPa03EPJ41nKD4GbqtXJ6iIkEv1MJ6cvoeZGKKf5bD3dvYhEQ1WtU
        hHJ4jEilijTsBkM0aC4ShNx+LDVeYYyQGw8R58W/f/HQxssV8lTTBGzu75RSgxi8ztIX8ZCFwlaUi
        3EHwyEOdSVgiR4aPlsu6fsVJwqZdGVpZmQemafsBk8AQPG6LHdeYyD59Gp9CSUAb6fhrNpIGzJWOQ
        cyI84C7Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ppsDj-00FLN0-P2; Fri, 21 Apr 2023 14:58:43 +0000
Date:   Fri, 21 Apr 2023 15:58:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+c2de99a72baaa06d31f3@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com, tytso@mit.edu,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, martin.lau@linux.dev,
        bpf <bpf@vger.kernel.org>, KP Singh <kpsingh@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mike Christie <michael.christie@oracle.com>
Subject: Re: [syzbot] [ext4?] [mm?] KCSAN: data-race in strscpy / strscpy (3)
Message-ID: <ZEKko6U2MxfkXgs5@casper.infradead.org>
References: <000000000000b9915d05f9d98bdd@google.com>
 <CACT4Y+a3J0Z2PThebH6UaUWchKLWec8qApuv1ezYGKjf67Xctg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+a3J0Z2PThebH6UaUWchKLWec8qApuv1ezYGKjf67Xctg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 21, 2023 at 04:43:19PM +0200, Dmitry Vyukov wrote:
> On Fri, 21 Apr 2023 at 16:33, syzbot
> <syzbot+c2de99a72baaa06d31f3@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    76f598ba7d8e Merge tag 'for-linus' of git://git.kernel.org..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=133bfbedc80000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=9c5d44636e91081b
> > dashboard link: https://syzkaller.appspot.com/bug?extid=c2de99a72baaa06d31f3
> > compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/a3654f5f77b9/disk-76f598ba.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/abfb4aaa5772/vmlinux-76f598ba.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/789fb5546551/bzImage-76f598ba.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+c2de99a72baaa06d31f3@syzkaller.appspotmail.com
> 
> +bpf maintainers
> 
> If I am reading this correctly, this can cause a leak of kernel memory
> and/or crash via bpf_get_current_comm helper.
> 
> strcpy() can temporary leave comm buffer non-0 terminated as it
> terminates it only after the copy:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/string.c?id=76f598ba7d8e2bfb4855b5298caedd5af0c374a8#n184
> 
> If bpf_get_current_comm() observes such non-0-terminated comm, it will
> start reading off bounds.

Just to be clear, this isn't ext4 at all; ext4 happens to be calling
kthread_create(), but it's actually a generic kthread problem, right?

I'm not sure how it is that bpf is able to see the task before comm is
initialised; that seems to be the real race here, that comm is not set
before the kthread is a schedulable entity?  Adding the scheduler people.

> > ==================================================================
> > BUG: KCSAN: data-race in strscpy / strscpy
> >
> > write to 0xffff88812ed8b730 of 8 bytes by task 16157 on cpu 1:
> >  strscpy+0xa9/0x170 lib/string.c:165
> >  strscpy_pad+0x27/0x80 lib/string_helpers.c:835
> >  __set_task_comm+0x46/0x140 fs/exec.c:1232
> >  set_task_comm include/linux/sched.h:1984 [inline]
> >  __kthread_create_on_node+0x2b2/0x320 kernel/kthread.c:474
> >  kthread_create_on_node+0x8a/0xb0 kernel/kthread.c:512
> >  ext4_run_lazyinit_thread fs/ext4/super.c:3848 [inline]
> >  ext4_register_li_request+0x407/0x650 fs/ext4/super.c:3983
> >  __ext4_fill_super fs/ext4/super.c:5480 [inline]
> >  ext4_fill_super+0x3f4a/0x43f0 fs/ext4/super.c:5637
> >  get_tree_bdev+0x2b1/0x3a0 fs/super.c:1303
> >  ext4_get_tree+0x1c/0x20 fs/ext4/super.c:5668
> >  vfs_get_tree+0x51/0x190 fs/super.c:1510
> >  do_new_mount+0x200/0x650 fs/namespace.c:3042
> >  path_mount+0x498/0xb40 fs/namespace.c:3372
> >  do_mount fs/namespace.c:3385 [inline]
> >  __do_sys_mount fs/namespace.c:3594 [inline]
> >  __se_sys_mount+0x27f/0x2d0 fs/namespace.c:3571
> >  __x64_sys_mount+0x67/0x80 fs/namespace.c:3571
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >
> > read to 0xffff88812ed8b733 of 1 bytes by task 16161 on cpu 0:
> >  strscpy+0xde/0x170 lib/string.c:174
> >  ____bpf_get_current_comm kernel/bpf/helpers.c:260 [inline]
> >  bpf_get_current_comm+0x45/0x70 kernel/bpf/helpers.c:252
> >  ___bpf_prog_run+0x281/0x3050 kernel/bpf/core.c:1822
> >  __bpf_prog_run32+0x74/0xa0 kernel/bpf/core.c:2043
> >  bpf_dispatcher_nop_func include/linux/bpf.h:1124 [inline]
> >  __bpf_prog_run include/linux/filter.h:601 [inline]
> >  bpf_prog_run include/linux/filter.h:608 [inline]
> >  __bpf_trace_run kernel/trace/bpf_trace.c:2263 [inline]
> >  bpf_trace_run4+0x9f/0x140 kernel/trace/bpf_trace.c:2304
> >  __traceiter_sched_switch+0x3a/0x50 include/trace/events/sched.h:222
> >  trace_sched_switch include/trace/events/sched.h:222 [inline]
> >  __schedule+0x7e7/0x8e0 kernel/sched/core.c:6622
> >  schedule+0x51/0x80 kernel/sched/core.c:6701
> >  schedule_preempt_disabled+0x10/0x20 kernel/sched/core.c:6760
> >  kthread+0x11c/0x1e0 kernel/kthread.c:369
> >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
> >
> > value changed: 0x72 -> 0x34
> >
> > Reported by Kernel Concurrency Sanitizer on:
> > CPU: 0 PID: 16161 Comm: ext4lazyinit Not tainted 6.3.0-rc5-syzkaller-00022-g76f598ba7d8e #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
> > ==================================================================
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
