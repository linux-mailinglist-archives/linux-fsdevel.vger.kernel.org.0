Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955733E4A19
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 18:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbhHIQiw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 12:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbhHIQiv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 12:38:51 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE694C061796
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Aug 2021 09:38:30 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id bl13so3518420qvb.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Aug 2021 09:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vGmxXoRJqoVtQvEJ99Oxq7I03PHdPXOjSEHoTmy10SI=;
        b=oglR60NiKs/uJBRwcCaM4iZiITuPNEo5Afi6vNiWsjJndtPIvI1HpRmyjLyKkiA8do
         LIgWIudfgHX7khFlhhvEiGLznMdfurJD+HEJS4zky91sqKzxAE3G75mNZ6bd7dcHmPbY
         Ak4BmJTOD2ODHkafjHWNcouFCrLtBh5j9dYOJShZyald6bKQSKVx5wQkIldIryvZ45f5
         gVbEBiicoAe1dw4uBb4i8kdnJecWQbix6FFoNWt+3lbDYSyAs4641QNu219dtLW2OToR
         BX6LnQbBPj8le8H8y9AsWDHU3AI82HT7zRKoG1en6BR3+ztjX7FxaiJnVhAV+rNf7GeV
         GXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vGmxXoRJqoVtQvEJ99Oxq7I03PHdPXOjSEHoTmy10SI=;
        b=uXH51qyJEnMLcd/MmaNT71q3kDlPtvpARPPonYjcNhaqL3rOmqMA5z6Yq6gw/ErxA8
         WpQbUoa1XXuVGelGIbzzJXjLnIkUz/V7NS9Vu+S7bYWMfswbrx+WDk50mLx4FlYuvmDq
         1G8pHcpyvyQjNyGkYJn+j5oc9hYEXPSBYJEtIEiDCB/w8PvtGrP1YQd2eCyOLcCtWa/e
         YfckdUvraCx9PjU39NQUp10bOuJx74TWtLeIioXPSLce+Kvf5hNgmxtbQzWb3qR2dJY0
         4ArJlqIRd82g55QnNuhP8nXupG5/xIJ/+RvqnAYJNsIi//mCZQjxJYBfJjeFv+YEUTSZ
         PXsA==
X-Gm-Message-State: AOAM532h/bhbWGQZHTfmbGGHABv4wnq8Kz+/1+2qWO4pgkLHmpeTmrD7
        Fv5FjRl7JiaqYsvlHTxCstXfpxOVsTDNmyKNoVOHmQ==
X-Google-Smtp-Source: ABdhPJyNf8jA43u8FQx2VD8OpqyYmnYqBBe08qiwIXNfNu8mFzTWax/XBENY/O3HFRnpI6PhekNmBmslfYy5EeovOZ8=
X-Received: by 2002:a0c:aa42:: with SMTP id e2mr13509058qvb.23.1628527109795;
 Mon, 09 Aug 2021 09:38:29 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000007db08f05c79fc81f@google.com> <x498s1ee26t.fsf@segfault.boston.devel.redhat.com>
 <CACT4Y+Y=7aT65CA4n+sy5n75e53rWc+E3_K+-e6jxU=QQQOATg@mail.gmail.com> <x498s1aenle.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x498s1aenle.fsf@segfault.boston.devel.redhat.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 9 Aug 2021 18:38:18 +0200
Message-ID: <CACT4Y+bkGk5pC2Bud1nrp6vibmFgOY6hDSSFrKL-bmHVZTvNTA@mail.gmail.com>
Subject: Re: [syzbot] INFO: task hung in sys_io_destroy
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     syzbot <syzbot+d40a01556c761b2cb385@syzkaller.appspotmail.com>,
        bcrl@kvack.org, linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 9 Aug 2021 at 15:46, Jeff Moyer <jmoyer@redhat.com> wrote:
> >> syzbot <syzbot+d40a01556c761b2cb385@syzkaller.appspotmail.com> writes:
> >>
> >> > Hello,
> >> >
> >> > syzbot found the following issue on:
> >> >
> >> > HEAD commit:    1d67c8d993ba Merge tag 'soc-fixes-5.14-1' of git://git.ker..
> >> > git tree:       upstream
> >> > console output: https://syzkaller.appspot.com/x/log.txt?x=11b40232300000
> >> > kernel config:  https://syzkaller.appspot.com/x/.config?x=f1b998c1afc13578
> >> > dashboard link: https://syzkaller.appspot.com/bug?extid=d40a01556c761b2cb385
> >> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12453812300000
> >> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11225922300000
> >> >
> >> > Bisection is inconclusive: the issue happens on the oldest tested release.
> >> >
> >> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=127cac6a300000
> >> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=117cac6a300000
> >> > console output: https://syzkaller.appspot.com/x/log.txt?x=167cac6a300000
> >> >
> >> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >> > Reported-by: syzbot+d40a01556c761b2cb385@syzkaller.appspotmail.com
> >> >
> >> > INFO: task syz-executor299:8807 blocked for more than 143 seconds.
> >> >       Not tainted 5.14.0-rc1-syzkaller #0
> >> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >> > task:syz-executor299 state:D stack:29400 pid: 8807 ppid:  8806 flags:0x00000000
> >> > Call Trace:
> >> >  context_switch kernel/sched/core.c:4683 [inline]
> >> >  __schedule+0x93a/0x26f0 kernel/sched/core.c:5940
> >> >  schedule+0xd3/0x270 kernel/sched/core.c:6019
> >> >  schedule_timeout+0x1db/0x2a0 kernel/time/timer.c:1854
> >> >  do_wait_for_common kernel/sched/completion.c:85 [inline]
> >> >  __wait_for_common kernel/sched/completion.c:106 [inline]
> >> >  wait_for_common kernel/sched/completion.c:117 [inline]
> >> >  wait_for_completion+0x176/0x280 kernel/sched/completion.c:138
> >> >  __do_sys_io_destroy fs/aio.c:1402 [inline]
> >> >  __se_sys_io_destroy fs/aio.c:1380 [inline]
> >> >  __x64_sys_io_destroy+0x17e/0x1e0 fs/aio.c:1380
> >> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >> >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >> >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> >>
> >> The reproducer is creating a thread, issuing a IOCB_CMD_PREAD from a
> >> pipe in that thread, and then calling io_destroy from another thread.
> >> Because there is no writer on the other end of the pipe, the read will
> >> block.  Note that it also is not submitted asynchronously, as that's not
> >> supported.
> >>
> >> io_destroy is "hanging" because it's waiting for the read to finish.  If
> >> the read thread is killed, cleanup happens as usual.  I'm not sure I
> >> could classify this as a kernel bug.
> >
> > Hi Jeff,
> >
> > Thanks for looking into this. I suspect the reproducer may create a
> > fork bomb that DoSed the kernel so that it can't make progress for 140
> > seconds. FTR, I've added it to
> > https://github.com/google/syzkaller/issues/498#issuecomment-895071514
> > to take a closer look.
>
> No, I described exactly what happens.  You can reproduce the hung task
> timeout with a much simpler program, attached below.

Ah, I see.
But then shouldn't any userspace program be able to trigger kernel bug
detection splats? If userspace programs can trigger bug detection
warnings "legitimately", it makes it impossible to use these bug
detection facilities in kernel testing.
Also the reproducer should have killed the child process much sooner
than 140 second, why did it still produce the warning?
Also I wonder if it's possible to deadlock the system by creating 2
tasks each waiting on the other, and both becoming non-killable as the
result (maybe playing with CLONE_THREAD/VM)?


> #define _GNU_SOURCE
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <fcntl.h>
> #include <errno.h>
> #include <unistd.h>
> #include <libaio.h>
> #include <pthread.h>
>
> #define BUFSZ 512
>
> void *
> submit_thread(void *arg)
> {
>         io_context_t *ctx = arg;
>         int ret;
>         int fds[2];
>         char buf[BUFSZ];
>         struct iocb iocb, *iocbp = &iocb;
>
>         ret = pipe(fds);
>         if (ret) {
>                 perror("pipe");
>                 exit(1);
>         }
>
>         io_prep_pread(iocbp, fds[0], buf, BUFSZ, 0);
>
>         ret = io_submit(*ctx, 1, &iocbp);
>         if (ret != 1) {
>                 printf("io_submit failed with %d\n", ret);
>                 exit(1);
>         }
>
>         /* NOTREACHED */
>         printf("Read submitted.\n");
>         return 0;
> }
>
> int
> main(void)
> {
>         int ret;
>         io_context_t ctx;
>         pthread_t pth;
>
>         memset(&ctx, 0, sizeof(ctx));
>         ret = io_setup(1, &ctx);
>         if (ret) {
>                 printf("io_setup failed with %d\n", ret);
>                 exit(1);
>         }
>
>         ret = pthread_create(&pth, NULL, submit_thread, &ctx);
>         if (ret) {
>                 perror("pthread_create");
>                 exit(1);
>         }
>
>         usleep(1000); /* give the thread time to run */
>
>         ret = io_destroy(ctx);
>         if (ret) {
>                 printf("io_destroy failed with %d\n", ret);
>                 exit(1);
>         }
>
>         exit(0);
> }
>
