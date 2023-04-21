Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625656EAD57
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 16:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjDUOp3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 10:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbjDUOoq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 10:44:46 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19751444B
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Apr 2023 07:44:24 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4edc63e066fso7033e87.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Apr 2023 07:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682088212; x=1684680212;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8B725ZBKfP0GpWx9JPfGFqkXbZvh/CpPapZ/L8/4CIg=;
        b=vfAbBNK/+7FEiarLloglLl9iO8FTuYu+DqjWSf1EILAEkpr/+RBkwZVWJpJiwz3O2w
         lZAFTrwKio3jZyQKQtc470ZsIRvz7dqV+4FYhWi+ycNv1Cmr61/d3PASWu3I4rsI267U
         SwhwivkYP4Lm+x6AKgkv6z5kMY17enk2SCRkaZZPatYuVT0jFFeKbnOjgjYPv5qodA5D
         kLYikZQKJmJjMUWj+y94YZ1pmg7HgNlPys+sI0FSrdXR23dGz6qhjYupAB8V2uamfuCo
         oiz3ci1vlDssHste7IM3UV+NolCsno7yAYGHFYCwiJWVOq9VRavVUbA9WMg+7hjTUesw
         hKKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682088212; x=1684680212;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8B725ZBKfP0GpWx9JPfGFqkXbZvh/CpPapZ/L8/4CIg=;
        b=OFZDghtojb53XFpvXd0eUR9vpxod94Ni3EeCDI9XqSnWzmshUkNL8isr6tusyAbLFO
         vnrchCOvgKFIhxiojZka1a8pVnBdB8FQUVgwgx84TRosIkjFpyq+Zq9O8qzASD+vpMSS
         /fRdxR5TcvbOM9mmspgJTQysVHiGpOpmEF34KZ4wVMkztMvUlVXYqBpPspVALQ+3OtaF
         S6l3v+pwddZmhcbXdnD2VjMp8KVye04Vbl8roaXSVvotConG5hjqG11nwlfNcwpmCJJY
         +99rt2U8bK4uimZ9E+r1VRvmIGQn0LHE5xryNIpJZjlZrmYH6qUlpARfjG/cwzlDg/yV
         cf/A==
X-Gm-Message-State: AAQBX9cVGOLVtlUrIrt0XD7Mz8fTnU5Pnb3VA1Sdgyl6hxIJPw8RDjal
        T0ZZQsKiYbFF7DXB6ltgAHUkaZcH1v8vpXQQKAq5FQ==
X-Google-Smtp-Source: AKy350ZgFLgjPf0keMqVaZ2XCOPWr5zcEJMuWlapT5bkkYcpH7oSDLcOJm/h5S8depl9UFnyNz5jzxG+9P31BBCsJ4Y=
X-Received: by 2002:a05:6512:1319:b0:4e9:d785:37cb with SMTP id
 x25-20020a056512131900b004e9d78537cbmr123998lfu.1.1682088211800; Fri, 21 Apr
 2023 07:43:31 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000b9915d05f9d98bdd@google.com>
In-Reply-To: <000000000000b9915d05f9d98bdd@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 21 Apr 2023 16:43:19 +0200
Message-ID: <CACT4Y+a3J0Z2PThebH6UaUWchKLWec8qApuv1ezYGKjf67Xctg@mail.gmail.com>
Subject: Re: [syzbot] [ext4?] [mm?] KCSAN: data-race in strscpy / strscpy (3)
To:     syzbot <syzbot+c2de99a72baaa06d31f3@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com, tytso@mit.edu,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, martin.lau@linux.dev,
        bpf <bpf@vger.kernel.org>, KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 21 Apr 2023 at 16:33, syzbot
<syzbot+c2de99a72baaa06d31f3@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    76f598ba7d8e Merge tag 'for-linus' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=133bfbedc80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9c5d44636e91081b
> dashboard link: https://syzkaller.appspot.com/bug?extid=c2de99a72baaa06d31f3
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/a3654f5f77b9/disk-76f598ba.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/abfb4aaa5772/vmlinux-76f598ba.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/789fb5546551/bzImage-76f598ba.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+c2de99a72baaa06d31f3@syzkaller.appspotmail.com

+bpf maintainers

If I am reading this correctly, this can cause a leak of kernel memory
and/or crash via bpf_get_current_comm helper.

strcpy() can temporary leave comm buffer non-0 terminated as it
terminates it only after the copy:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/string.c?id=76f598ba7d8e2bfb4855b5298caedd5af0c374a8#n184

If bpf_get_current_comm() observes such non-0-terminated comm, it will
start reading off bounds.

> ==================================================================
> BUG: KCSAN: data-race in strscpy / strscpy
>
> write to 0xffff88812ed8b730 of 8 bytes by task 16157 on cpu 1:
>  strscpy+0xa9/0x170 lib/string.c:165
>  strscpy_pad+0x27/0x80 lib/string_helpers.c:835
>  __set_task_comm+0x46/0x140 fs/exec.c:1232
>  set_task_comm include/linux/sched.h:1984 [inline]
>  __kthread_create_on_node+0x2b2/0x320 kernel/kthread.c:474
>  kthread_create_on_node+0x8a/0xb0 kernel/kthread.c:512
>  ext4_run_lazyinit_thread fs/ext4/super.c:3848 [inline]
>  ext4_register_li_request+0x407/0x650 fs/ext4/super.c:3983
>  __ext4_fill_super fs/ext4/super.c:5480 [inline]
>  ext4_fill_super+0x3f4a/0x43f0 fs/ext4/super.c:5637
>  get_tree_bdev+0x2b1/0x3a0 fs/super.c:1303
>  ext4_get_tree+0x1c/0x20 fs/ext4/super.c:5668
>  vfs_get_tree+0x51/0x190 fs/super.c:1510
>  do_new_mount+0x200/0x650 fs/namespace.c:3042
>  path_mount+0x498/0xb40 fs/namespace.c:3372
>  do_mount fs/namespace.c:3385 [inline]
>  __do_sys_mount fs/namespace.c:3594 [inline]
>  __se_sys_mount+0x27f/0x2d0 fs/namespace.c:3571
>  __x64_sys_mount+0x67/0x80 fs/namespace.c:3571
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> read to 0xffff88812ed8b733 of 1 bytes by task 16161 on cpu 0:
>  strscpy+0xde/0x170 lib/string.c:174
>  ____bpf_get_current_comm kernel/bpf/helpers.c:260 [inline]
>  bpf_get_current_comm+0x45/0x70 kernel/bpf/helpers.c:252
>  ___bpf_prog_run+0x281/0x3050 kernel/bpf/core.c:1822
>  __bpf_prog_run32+0x74/0xa0 kernel/bpf/core.c:2043
>  bpf_dispatcher_nop_func include/linux/bpf.h:1124 [inline]
>  __bpf_prog_run include/linux/filter.h:601 [inline]
>  bpf_prog_run include/linux/filter.h:608 [inline]
>  __bpf_trace_run kernel/trace/bpf_trace.c:2263 [inline]
>  bpf_trace_run4+0x9f/0x140 kernel/trace/bpf_trace.c:2304
>  __traceiter_sched_switch+0x3a/0x50 include/trace/events/sched.h:222
>  trace_sched_switch include/trace/events/sched.h:222 [inline]
>  __schedule+0x7e7/0x8e0 kernel/sched/core.c:6622
>  schedule+0x51/0x80 kernel/sched/core.c:6701
>  schedule_preempt_disabled+0x10/0x20 kernel/sched/core.c:6760
>  kthread+0x11c/0x1e0 kernel/kthread.c:369
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
>
> value changed: 0x72 -> 0x34
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 PID: 16161 Comm: ext4lazyinit Not tainted 6.3.0-rc5-syzkaller-00022-g76f598ba7d8e #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
> ==================================================================
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
