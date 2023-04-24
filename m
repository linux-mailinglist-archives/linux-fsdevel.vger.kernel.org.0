Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A5A6EC785
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 09:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjDXH7U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 03:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjDXH7S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 03:59:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9CD11B;
        Mon, 24 Apr 2023 00:59:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00FB46101F;
        Mon, 24 Apr 2023 07:59:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5AEC433EF;
        Mon, 24 Apr 2023 07:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682323156;
        bh=LVTaOO3e2WuhCkVNpP1jxSnkqaU8Al77qhAf5+dDf4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TlUpVrOkP6yBue5XzLOYl2+j3hTGF9pt8WU/guTsbd7YVD7LW+z13puIb+Q//1IDz
         M8nLZ322fuvBxgmPkJA9jB7vhk19KTXBJ/9LKzrCNKQgnKItpKB3GliVCTlwDqJxHE
         iuDsWWPyTkJi4fmShKgYfE9WXtLowhwWNIlL7UpBXUH0QCy12VhAhPY6xMQKyKHnat
         gmbA6jP+gLai4y7zPrkfXxQ/W9XhdmantUWVQ2UySuptRAL/8HfnnkrLAO/WaV5iTb
         l6eEodJZkIS56RORPZ8guulhAxrD9VSlrOOl1xfud8t7xYGn0VeE/Fb2UAtB5joZHf
         2uPNxytB5LVAw==
Date:   Mon, 24 Apr 2023 09:59:07 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
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
Subject: Re: [syzbot] [ext4?] [mm?] KCSAN: data-race in strscpy / strscpy (3)
Message-ID: <20230424-frucht-beneiden-83a8083a973b@brauner>
References: <000000000000b9915d05f9d98bdd@google.com>
 <CACT4Y+a3J0Z2PThebH6UaUWchKLWec8qApuv1ezYGKjf67Xctg@mail.gmail.com>
 <ZEKko6U2MxfkXgs5@casper.infradead.org>
 <13d484d3-d573-cd82-fff0-a35e27b8451e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <13d484d3-d573-cd82-fff0-a35e27b8451e@oracle.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 21, 2023 at 12:40:45PM -0500, Mike Christie wrote:
> cc'ing Christian, because I might have fixed this with a patch in
> his tree.
> 
> On 4/21/23 9:58 AM, Matthew Wilcox wrote:
> > I'm not sure how it is that bpf is able to see the task before comm is
> > initialised; that seems to be the real race here, that comm is not set
> > before the kthread is a schedulable entity?  Adding the scheduler people.
> > 
> >>> ==================================================================
> >>> BUG: KCSAN: data-race in strscpy / strscpy
> >>>
> >>> write to 0xffff88812ed8b730 of 8 bytes by task 16157 on cpu 1:
> >>>  strscpy+0xa9/0x170 lib/string.c:165
> >>>  strscpy_pad+0x27/0x80 lib/string_helpers.c:835
> >>>  __set_task_comm+0x46/0x140 fs/exec.c:1232
> >>>  set_task_comm include/linux/sched.h:1984 [inline]
> >>>  __kthread_create_on_node+0x2b2/0x320 kernel/kthread.c:474
> >>>  kthread_create_on_node+0x8a/0xb0 kernel/kthread.c:512
> >>>  ext4_run_lazyinit_thread fs/ext4/super.c:3848 [inline]
> >>>  ext4_register_li_request+0x407/0x650 fs/ext4/super.c:3983
> >>>  __ext4_fill_super fs/ext4/super.c:5480 [inline]
> >>>  ext4_fill_super+0x3f4a/0x43f0 fs/ext4/super.c:5637
> >>>  get_tree_bdev+0x2b1/0x3a0 fs/super.c:1303
> >>>  ext4_get_tree+0x1c/0x20 fs/ext4/super.c:5668
> >>>  vfs_get_tree+0x51/0x190 fs/super.c:1510
> >>>  do_new_mount+0x200/0x650 fs/namespace.c:3042
> >>>  path_mount+0x498/0xb40 fs/namespace.c:3372
> >>>  do_mount fs/namespace.c:3385 [inline]
> >>>  __do_sys_mount fs/namespace.c:3594 [inline]
> >>>  __se_sys_mount+0x27f/0x2d0 fs/namespace.c:3571
> >>>  __x64_sys_mount+0x67/0x80 fs/namespace.c:3571
> >>>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >>>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> >>>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >>>
> >>> read to 0xffff88812ed8b733 of 1 bytes by task 16161 on cpu 0:
> >>>  strscpy+0xde/0x170 lib/string.c:174
> >>>  ____bpf_get_current_comm kernel/bpf/helpers.c:260 [inline]
> >>>  bpf_get_current_comm+0x45/0x70 kernel/bpf/helpers.c:252
> >>>  ___bpf_prog_run+0x281/0x3050 kernel/bpf/core.c:1822
> >>>  __bpf_prog_run32+0x74/0xa0 kernel/bpf/core.c:2043
> >>>  bpf_dispatcher_nop_func include/linux/bpf.h:1124 [inline]
> >>>  __bpf_prog_run include/linux/filter.h:601 [inline]
> >>>  bpf_prog_run include/linux/filter.h:608 [inline]
> >>>  __bpf_trace_run kernel/trace/bpf_trace.c:2263 [inline]
> >>>  bpf_trace_run4+0x9f/0x140 kernel/trace/bpf_trace.c:2304
> >>>  __traceiter_sched_switch+0x3a/0x50 include/trace/events/sched.h:222
> >>>  trace_sched_switch include/trace/events/sched.h:222 [inline]
> >>>  __schedule+0x7e7/0x8e0 kernel/sched/core.c:6622
> >>>  schedule+0x51/0x80 kernel/sched/core.c:6701
> >>>  schedule_preempt_disabled+0x10/0x20 kernel/sched/core.c:6760
> >>>  kthread+0x11c/0x1e0 kernel/kthread.c:369
> >>>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
> >>>
> 
> 
> I didn't see the beginning of this thread and I think the part of the
> sysbot report that lists the patches/trees being used got cut off so
> I'm not 100% sure what's in the kernel.
> 
> In Linus's current tree we do set_task_comm in __kthread_create_on_node
> after waiting on the kthread_create_info completion which is completed by
> threadd(). At this time, kthread() has already done the complete() on the
> kthread_create_info completion and started to run the threadfn function and
> that could be running. So we can hit the race that way.
> 
> 
> In linux next, from 
> https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=kernel.user_worker
> we have:
> 
> commit cf587db2ee0261c74d04f61f39783db88a0b65e4
> Author: Mike Christie <michael.christie@oracle.com>
> Date:   Fri Mar 10 16:03:23 2023 -0600
> 
>     kernel: Allow a kernel thread's name to be set in copy_process
> 
> and so now copy_process() sets the name before the taskfn is started, so we
> shouldn't hit any races like above.

Yeah, that looks like it should fix it.

Afaict, this has no reproducer so there's no point in letting syzbot
test on this. I've sent the pull request for the kernel user worker
series on Friday. So I guess we'll see whether it's reproducible on
v6.4-rc1.


