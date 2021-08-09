Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 210F83E46DD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 15:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbhHINq7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 09:46:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44382 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233102AbhHINq6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 09:46:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628516797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kC60/FWvUwVd7y01o36qa1ToUR0hILQPRSMtA/mfOk4=;
        b=MXs95t3Tfp8QCDmiftr8m5T/NMPGoLy+pfhVTakq44+nfeoCA1RDxgsB1w6Om77WKxwjdM
        Q+5Qk+lViLgNSZIHJD6yWiJSdoBVCJGBKTokcWlJcmhm6HoC7zMIHfeP1+w518YXaghSlf
        CC4Z7kaiR/G1+oNkZq38LNOvmjKJfI0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-WeHJt-ooMMOa3Q7ID4zj0Q-1; Mon, 09 Aug 2021 09:46:36 -0400
X-MC-Unique: WeHJt-ooMMOa3Q7ID4zj0Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9CF7190A7A0;
        Mon,  9 Aug 2021 13:46:34 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E22295D6A1;
        Mon,  9 Aug 2021 13:46:33 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+d40a01556c761b2cb385@syzkaller.appspotmail.com>,
        bcrl@kvack.org, linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Subject: Re: [syzbot] INFO: task hung in sys_io_destroy
References: <0000000000007db08f05c79fc81f@google.com>
        <x498s1ee26t.fsf@segfault.boston.devel.redhat.com>
        <CACT4Y+Y=7aT65CA4n+sy5n75e53rWc+E3_K+-e6jxU=QQQOATg@mail.gmail.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Mon, 09 Aug 2021 09:47:57 -0400
In-Reply-To: <CACT4Y+Y=7aT65CA4n+sy5n75e53rWc+E3_K+-e6jxU=QQQOATg@mail.gmail.com>
        (Dmitry Vyukov's message of "Mon, 9 Aug 2021 11:24:22 +0200")
Message-ID: <x498s1aenle.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dmitry Vyukov <dvyukov@google.com> writes:

> On Fri, 6 Aug 2021 at 22:39, Jeff Moyer <jmoyer@redhat.com> wrote:
>>
>> syzbot <syzbot+d40a01556c761b2cb385@syzkaller.appspotmail.com> writes:
>>
>> > Hello,
>> >
>> > syzbot found the following issue on:
>> >
>> > HEAD commit:    1d67c8d993ba Merge tag 'soc-fixes-5.14-1' of git://git.ker..
>> > git tree:       upstream
>> > console output: https://syzkaller.appspot.com/x/log.txt?x=11b40232300000
>> > kernel config:  https://syzkaller.appspot.com/x/.config?x=f1b998c1afc13578
>> > dashboard link: https://syzkaller.appspot.com/bug?extid=d40a01556c761b2cb385
>> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12453812300000
>> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11225922300000
>> >
>> > Bisection is inconclusive: the issue happens on the oldest tested release.
>> >
>> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=127cac6a300000
>> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=117cac6a300000
>> > console output: https://syzkaller.appspot.com/x/log.txt?x=167cac6a300000
>> >
>> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> > Reported-by: syzbot+d40a01556c761b2cb385@syzkaller.appspotmail.com
>> >
>> > INFO: task syz-executor299:8807 blocked for more than 143 seconds.
>> >       Not tainted 5.14.0-rc1-syzkaller #0
>> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> > task:syz-executor299 state:D stack:29400 pid: 8807 ppid:  8806 flags:0x00000000
>> > Call Trace:
>> >  context_switch kernel/sched/core.c:4683 [inline]
>> >  __schedule+0x93a/0x26f0 kernel/sched/core.c:5940
>> >  schedule+0xd3/0x270 kernel/sched/core.c:6019
>> >  schedule_timeout+0x1db/0x2a0 kernel/time/timer.c:1854
>> >  do_wait_for_common kernel/sched/completion.c:85 [inline]
>> >  __wait_for_common kernel/sched/completion.c:106 [inline]
>> >  wait_for_common kernel/sched/completion.c:117 [inline]
>> >  wait_for_completion+0x176/0x280 kernel/sched/completion.c:138
>> >  __do_sys_io_destroy fs/aio.c:1402 [inline]
>> >  __se_sys_io_destroy fs/aio.c:1380 [inline]
>> >  __x64_sys_io_destroy+0x17e/0x1e0 fs/aio.c:1380
>> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>> >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>> >  entry_SYSCALL_64_after_hwframe+0x44/0xae
>>
>> The reproducer is creating a thread, issuing a IOCB_CMD_PREAD from a
>> pipe in that thread, and then calling io_destroy from another thread.
>> Because there is no writer on the other end of the pipe, the read will
>> block.  Note that it also is not submitted asynchronously, as that's not
>> supported.
>>
>> io_destroy is "hanging" because it's waiting for the read to finish.  If
>> the read thread is killed, cleanup happens as usual.  I'm not sure I
>> could classify this as a kernel bug.
>
> Hi Jeff,
>
> Thanks for looking into this. I suspect the reproducer may create a
> fork bomb that DoSed the kernel so that it can't make progress for 140
> seconds. FTR, I've added it to
> https://github.com/google/syzkaller/issues/498#issuecomment-895071514
> to take a closer look.

No, I described exactly what happens.  You can reproduce the hung task
timeout with a much simpler program, attached below.

Cheers,
Jeff

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <errno.h>
#include <unistd.h>
#include <libaio.h>
#include <pthread.h>

#define BUFSZ 512

void *
submit_thread(void *arg)
{
	io_context_t *ctx = arg;
	int ret;
	int fds[2];
	char buf[BUFSZ];
	struct iocb iocb, *iocbp = &iocb;

	ret = pipe(fds);
	if (ret) {
		perror("pipe");
		exit(1);
	}

	io_prep_pread(iocbp, fds[0], buf, BUFSZ, 0);

	ret = io_submit(*ctx, 1, &iocbp);
	if (ret != 1) {
		printf("io_submit failed with %d\n", ret);
		exit(1);
	}

	/* NOTREACHED */
	printf("Read submitted.\n");
	return 0;
}

int
main(void)
{
	int ret;
	io_context_t ctx;
	pthread_t pth;

	memset(&ctx, 0, sizeof(ctx));
	ret = io_setup(1, &ctx);
	if (ret) {
		printf("io_setup failed with %d\n", ret);
		exit(1);
	}

	ret = pthread_create(&pth, NULL, submit_thread, &ctx);
	if (ret) {
		perror("pthread_create");
		exit(1);
	}

	usleep(1000); /* give the thread time to run */

	ret = io_destroy(ctx);
	if (ret) {
		printf("io_destroy failed with %d\n", ret);
		exit(1);
	}

	exit(0);
}

