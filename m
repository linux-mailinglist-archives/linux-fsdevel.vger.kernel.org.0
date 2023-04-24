Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C7C6EC7D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 10:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjDXIZ1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 04:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjDXIZY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 04:25:24 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66F61BD6
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 01:25:15 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4efd5e4d302so4120e87.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 01:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682324713; x=1684916713;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j18LTPw/0ZiwBV/EQmierqo28H2NNyEAjpLUZMbxn80=;
        b=CesUfe+p8d0dkEmrufChgURYmQzPVsRKB6Z1zq/0m7jQFerLN1vm3sKO5u2K/rl8sJ
         753Xb1kwNpqsBLPPmYoA5D+gusVtmDUbYgFOfDLoue7QdZQWNHon9ozJTA5RjVwFMkRL
         AnIoCuhdETOi2d3M+DoGmCRI0qslU+tTb1mfNS7drK8UaW9VeLrCnkq4Fqi2j5alos/A
         IZikzBkRNKNvM0btTwz4vgI7z6JQ0rR5oqbZStxatygVFvg2zG7l8lGwK2GYsyt17272
         RWCij0rqF2sPbmgGniN/jpu8ahpeTEhNwAAwPrUPETEnOkOGoHjSz5eh3iai5awtX9jQ
         I5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682324713; x=1684916713;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j18LTPw/0ZiwBV/EQmierqo28H2NNyEAjpLUZMbxn80=;
        b=ayvyHo1amXcd0wQ9ht9CIFB7VdoNHNjJ8Sx0to0jp10Y2d/XvsBGz7guQpI7ywrkLo
         dtENSV8ZGSRLtNh38FQrREJz8f2GCalI1rUbb7zPvF9DJRSWCgfYJ2dsd6KovgN25evs
         bjB0N2zLVxZM6Q5Fpqi+V6P3VqYAPC00UB/tuua5NiM/UShgWZ/tAFm7LLClTtTXDZmk
         lV/jmii0aSk62FNao+HIYY45kvM8ncDq1cpu4rOSw0fcBxign2PAEbI4hpHcjHdYpF+/
         jzGcCIInLdisjDfzhk2qy/9z+1HvCgbJRW5Y1ty8bZ/AUARTA/WM4MFJ4CfhFVOjpiXA
         zIDQ==
X-Gm-Message-State: AAQBX9e05DpgdCr7LjzvZqNgj6MEx0XqQUfmXqeD3RD3Jqtz3IOvcjRM
        m+Oei/a6eIQfbfwTREarNCidz4dFuJ4My/TcpA03Cw==
X-Google-Smtp-Source: AKy350a4MUjUHwoBfxED2Pw4cqUKPKubA2JMVCH1vFSwww8z8PN8W5VV4psZGKlLDpTHBQR/gqh8epDpYPGCETmVnoc=
X-Received: by 2002:a05:6512:239b:b0:4ea:e5e2:c893 with SMTP id
 c27-20020a056512239b00b004eae5e2c893mr151496lfv.1.1682324713337; Mon, 24 Apr
 2023 01:25:13 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000b9915d05f9d98bdd@google.com> <CACT4Y+a3J0Z2PThebH6UaUWchKLWec8qApuv1ezYGKjf67Xctg@mail.gmail.com>
 <ZEKko6U2MxfkXgs5@casper.infradead.org> <13d484d3-d573-cd82-fff0-a35e27b8451e@oracle.com>
 <20230424-frucht-beneiden-83a8083a973b@brauner>
In-Reply-To: <20230424-frucht-beneiden-83a8083a973b@brauner>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 24 Apr 2023 10:25:00 +0200
Message-ID: <CACT4Y+b+4pFtZQxXZLVF8e0OKcEEYgLo+5ExAg_iKZFVERcXrw@mail.gmail.com>
Subject: Re: [syzbot] [ext4?] [mm?] KCSAN: data-race in strscpy / strscpy (3)
To:     Christian Brauner <brauner@kernel.org>
Cc:     Mike Christie <michael.christie@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        syzbot <syzbot+c2de99a72baaa06d31f3@syzkaller.appspotmail.com>,
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
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 24 Apr 2023 at 09:59, Christian Brauner <brauner@kernel.org> wrote:
>
> On Fri, Apr 21, 2023 at 12:40:45PM -0500, Mike Christie wrote:
> > cc'ing Christian, because I might have fixed this with a patch in
> > his tree.
> >
> > On 4/21/23 9:58 AM, Matthew Wilcox wrote:
> > > I'm not sure how it is that bpf is able to see the task before comm is
> > > initialised; that seems to be the real race here, that comm is not set
> > > before the kthread is a schedulable entity?  Adding the scheduler people.
> > >
> > >>> ==================================================================
> > >>> BUG: KCSAN: data-race in strscpy / strscpy
> > >>>
> > >>> write to 0xffff88812ed8b730 of 8 bytes by task 16157 on cpu 1:
> > >>>  strscpy+0xa9/0x170 lib/string.c:165
> > >>>  strscpy_pad+0x27/0x80 lib/string_helpers.c:835
> > >>>  __set_task_comm+0x46/0x140 fs/exec.c:1232
> > >>>  set_task_comm include/linux/sched.h:1984 [inline]
> > >>>  __kthread_create_on_node+0x2b2/0x320 kernel/kthread.c:474
> > >>>  kthread_create_on_node+0x8a/0xb0 kernel/kthread.c:512
> > >>>  ext4_run_lazyinit_thread fs/ext4/super.c:3848 [inline]
> > >>>  ext4_register_li_request+0x407/0x650 fs/ext4/super.c:3983
> > >>>  __ext4_fill_super fs/ext4/super.c:5480 [inline]
> > >>>  ext4_fill_super+0x3f4a/0x43f0 fs/ext4/super.c:5637
> > >>>  get_tree_bdev+0x2b1/0x3a0 fs/super.c:1303
> > >>>  ext4_get_tree+0x1c/0x20 fs/ext4/super.c:5668
> > >>>  vfs_get_tree+0x51/0x190 fs/super.c:1510
> > >>>  do_new_mount+0x200/0x650 fs/namespace.c:3042
> > >>>  path_mount+0x498/0xb40 fs/namespace.c:3372
> > >>>  do_mount fs/namespace.c:3385 [inline]
> > >>>  __do_sys_mount fs/namespace.c:3594 [inline]
> > >>>  __se_sys_mount+0x27f/0x2d0 fs/namespace.c:3571
> > >>>  __x64_sys_mount+0x67/0x80 fs/namespace.c:3571
> > >>>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > >>>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> > >>>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > >>>
> > >>> read to 0xffff88812ed8b733 of 1 bytes by task 16161 on cpu 0:
> > >>>  strscpy+0xde/0x170 lib/string.c:174
> > >>>  ____bpf_get_current_comm kernel/bpf/helpers.c:260 [inline]
> > >>>  bpf_get_current_comm+0x45/0x70 kernel/bpf/helpers.c:252
> > >>>  ___bpf_prog_run+0x281/0x3050 kernel/bpf/core.c:1822
> > >>>  __bpf_prog_run32+0x74/0xa0 kernel/bpf/core.c:2043
> > >>>  bpf_dispatcher_nop_func include/linux/bpf.h:1124 [inline]
> > >>>  __bpf_prog_run include/linux/filter.h:601 [inline]
> > >>>  bpf_prog_run include/linux/filter.h:608 [inline]
> > >>>  __bpf_trace_run kernel/trace/bpf_trace.c:2263 [inline]
> > >>>  bpf_trace_run4+0x9f/0x140 kernel/trace/bpf_trace.c:2304
> > >>>  __traceiter_sched_switch+0x3a/0x50 include/trace/events/sched.h:222
> > >>>  trace_sched_switch include/trace/events/sched.h:222 [inline]
> > >>>  __schedule+0x7e7/0x8e0 kernel/sched/core.c:6622
> > >>>  schedule+0x51/0x80 kernel/sched/core.c:6701
> > >>>  schedule_preempt_disabled+0x10/0x20 kernel/sched/core.c:6760
> > >>>  kthread+0x11c/0x1e0 kernel/kthread.c:369
> > >>>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
> > >>>
> >
> >
> > I didn't see the beginning of this thread and I think the part of the
> > sysbot report that lists the patches/trees being used got cut off so
> > I'm not 100% sure what's in the kernel.
> >
> > In Linus's current tree we do set_task_comm in __kthread_create_on_node
> > after waiting on the kthread_create_info completion which is completed by
> > threadd(). At this time, kthread() has already done the complete() on the
> > kthread_create_info completion and started to run the threadfn function and
> > that could be running. So we can hit the race that way.
> >
> >
> > In linux next, from
> > https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=kernel.user_worker
> > we have:
> >
> > commit cf587db2ee0261c74d04f61f39783db88a0b65e4
> > Author: Mike Christie <michael.christie@oracle.com>
> > Date:   Fri Mar 10 16:03:23 2023 -0600
> >
> >     kernel: Allow a kernel thread's name to be set in copy_process
> >
> > and so now copy_process() sets the name before the taskfn is started, so we
> > shouldn't hit any races like above.
>
> Yeah, that looks like it should fix it.
>
> Afaict, this has no reproducer so there's no point in letting syzbot
> test on this. I've sent the pull request for the kernel user worker
> series on Friday. So I guess we'll see whether it's reproducible on
> v6.4-rc1.

To see if it still happens to tell syzbot about the fix, then it will
remind if it still happens with the fix or not. Otherwise everybody
will forget about this tomorrow ;)

#syz fix: kernel: Allow a kernel thread's name to be set in copy_process

Btw, a similar race will still be possible b/c it's possible to change
the name at any point by writing to /proc/self/task/[tid]/comm. But I
am not sure how provably dangerous it will be and there is a different
attitude towards fixing races proactively for different kernel
subsystems, so we will probably not report it.
