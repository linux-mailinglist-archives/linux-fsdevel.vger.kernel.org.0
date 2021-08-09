Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5753E428F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 11:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbhHIJYz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 05:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbhHIJYz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 05:24:55 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC31EC0613D3
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Aug 2021 02:24:34 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id 14so17646130qkc.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Aug 2021 02:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kv0qXianjgxGg39Jv0L+TDQ2QR47zY1TQNpfW3pv4mQ=;
        b=kEmda94zCsiFJ4hkRfv8nmCHOJY9Xtz7Hi+q6mJteBnYsGeW4coQYAAlQiyIA6NuB5
         rShW4nCj9a4qBHJV+fbizHmTnFouFGv8DavO0y0lckf2h752mr9WWwlZOgAoEb6pgpoE
         rVycT8mhx8LzKyCoh6AHlarBbgO4GakbqBbHxMxtcRTK9OUUTWV0q0o1nLiR6Xyt+zPv
         60hxNJZA1ymL4imjzkp7pajUJeay+ScZyzfismLq40KayFkIMrwxIO8CPQfXOADpVhOc
         8hmqaQM14DsxHc1j6daZPMaJ51cDVc56raHCdnfgcfhtb0y+OIYvGD72mN7ie2pcpqtL
         eN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kv0qXianjgxGg39Jv0L+TDQ2QR47zY1TQNpfW3pv4mQ=;
        b=Xcc5elZu4XvG4s83gDIbZBJphfPFBWVSD/8YLHJowVMBxorgAcIVuAgLGk3i3Skkp5
         H7dssC1n8B83zalkV+puUHdBcpwGHCnOM7jzqjm0h4NzeDRQvlGkgPQrEoU2o2JfL/z6
         VdlUVmo/O5p0kkEy+qlV/HOLbCGj5WSlEQ+TrLVXt6m2aaKWF+JnGOu3GXiPLQu9GOq0
         8NqOHlwcXhyHFLk8cRifsm/JUwh8uZr+r+JtcsfLNqG0eXmto0BXHWYzp+8B/bvZEobJ
         P+3Kn630JlGOZfQBrzScfQPqEQVyja5EvwxhDDxg/lJxskrQnMjW/03IorW9JzHIaSBA
         ddWA==
X-Gm-Message-State: AOAM531z5CeHOc67KId+JNi+rC3ZKmiIAZW4tWTgYQpUf5l/V9la8kQE
        M5ALylQB6dP7nxCtDAZaOt+YNZ8pyQbFo6+6k76jlA==
X-Google-Smtp-Source: ABdhPJxXl18cxzKnQBY3knr15inSdLY6oj4mR/HzXN5uBU1hQ8auewNUOtxu5SkVcmFzUkAhuStYr0/x4tDStsBgE2c=
X-Received: by 2002:a05:620a:6c3:: with SMTP id 3mr21757425qky.501.1628501073849;
 Mon, 09 Aug 2021 02:24:33 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000007db08f05c79fc81f@google.com> <x498s1ee26t.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x498s1ee26t.fsf@segfault.boston.devel.redhat.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 9 Aug 2021 11:24:22 +0200
Message-ID: <CACT4Y+Y=7aT65CA4n+sy5n75e53rWc+E3_K+-e6jxU=QQQOATg@mail.gmail.com>
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

On Fri, 6 Aug 2021 at 22:39, Jeff Moyer <jmoyer@redhat.com> wrote:
>
> syzbot <syzbot+d40a01556c761b2cb385@syzkaller.appspotmail.com> writes:
>
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    1d67c8d993ba Merge tag 'soc-fixes-5.14-1' of git://git.ker..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=11b40232300000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=f1b998c1afc13578
> > dashboard link: https://syzkaller.appspot.com/bug?extid=d40a01556c761b2cb385
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12453812300000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11225922300000
> >
> > Bisection is inconclusive: the issue happens on the oldest tested release.
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=127cac6a300000
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=117cac6a300000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=167cac6a300000
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+d40a01556c761b2cb385@syzkaller.appspotmail.com
> >
> > INFO: task syz-executor299:8807 blocked for more than 143 seconds.
> >       Not tainted 5.14.0-rc1-syzkaller #0
> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > task:syz-executor299 state:D stack:29400 pid: 8807 ppid:  8806 flags:0x00000000
> > Call Trace:
> >  context_switch kernel/sched/core.c:4683 [inline]
> >  __schedule+0x93a/0x26f0 kernel/sched/core.c:5940
> >  schedule+0xd3/0x270 kernel/sched/core.c:6019
> >  schedule_timeout+0x1db/0x2a0 kernel/time/timer.c:1854
> >  do_wait_for_common kernel/sched/completion.c:85 [inline]
> >  __wait_for_common kernel/sched/completion.c:106 [inline]
> >  wait_for_common kernel/sched/completion.c:117 [inline]
> >  wait_for_completion+0x176/0x280 kernel/sched/completion.c:138
> >  __do_sys_io_destroy fs/aio.c:1402 [inline]
> >  __se_sys_io_destroy fs/aio.c:1380 [inline]
> >  __x64_sys_io_destroy+0x17e/0x1e0 fs/aio.c:1380
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> The reproducer is creating a thread, issuing a IOCB_CMD_PREAD from a
> pipe in that thread, and then calling io_destroy from another thread.
> Because there is no writer on the other end of the pipe, the read will
> block.  Note that it also is not submitted asynchronously, as that's not
> supported.
>
> io_destroy is "hanging" because it's waiting for the read to finish.  If
> the read thread is killed, cleanup happens as usual.  I'm not sure I
> could classify this as a kernel bug.

Hi Jeff,

Thanks for looking into this. I suspect the reproducer may create a
fork bomb that DoSed the kernel so that it can't make progress for 140
seconds. FTR, I've added it to
https://github.com/google/syzkaller/issues/498#issuecomment-895071514
to take a closer look.
