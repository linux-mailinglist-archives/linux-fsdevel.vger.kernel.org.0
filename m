Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E59AA5F734
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2019 13:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfGDL1U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jul 2019 07:27:20 -0400
Received: from us-edge-1.acronis.com ([69.20.59.99]:54032 "EHLO
        us-edge-1.acronis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbfGDL1U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jul 2019 07:27:20 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Jul 2019 07:27:18 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=acronis.com
        ; s=exim; h=MIME-Version:Content-Transfer-Encoding:Content-Type:Message-ID:
        Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ebLt+rgN7+eRdUOrhQJKd9HTr215QAx3NpL4JVnj+J8=; b=KP6WW9YUufMfCC1ywYXDnLOq3q
        fgNT8E2lfEOrE/LW2ounRUZwyldYFc+S8LIhlVsQEeZk63EEvq+1dr4ueTA6M6FNBP8T8YaRXnzkX
        1rYSUkfgcktdNKXfhLp9x2Y4FL8vkGNdqiPq5bM0nkVp3EI5PxQSZuJ//AStH7K5IgIY=;
Received: from [91.195.22.121] (helo=ru-ex-2.corp.acronis.com)
        by us-edge-1.acronis.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <Filipp.Mikoian@acronis.com>)
        id 1hizoO-0001FI-SQ; Thu, 04 Jul 2019 07:22:00 -0400
Received: from ru-ex-2.corp.acronis.com (10.250.32.21) by
 ru-ex-2.corp.acronis.com (10.250.32.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1591.10; Thu, 4 Jul 2019 14:21:57 +0300
Received: from ru-ex-2.corp.acronis.com ([fe80::3163:6934:fc33:4bd3]) by
 ru-ex-2.corp.acronis.com ([fe80::3163:6934:fc33:4bd3%4]) with mapi id
 15.01.1591.011; Thu, 4 Jul 2019 14:21:57 +0300
From:   Filipp Mikoian <Filipp.Mikoian@acronis.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-aio@kvack.org" <linux-aio@kvack.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "jmoyer@redhat.com" <jmoyer@redhat.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: io_uring question
Thread-Topic: io_uring question
Thread-Index: AQHVMlktc6wBW1EANEu5MaqUCERTlQ==
Date:   Thu, 4 Jul 2019 11:21:57 +0000
Message-ID: <76524892f9c048ea88c7d87295ec85ae@acronis.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.250.3.5]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MessageID-Signature: 294ead3f9692afd3605e2efd4a21308e2b740685
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi dear io_uring developers,

Recently I started playing with io_uring, and the main difference I expecte=
d
to see with old AIO(io_submit(), etc.) was submission syscall(io_uring_ente=
r())
not blocking in case submission might take long time, e.g. if waiting for a=
 slot
in block device request queue is required. AFAIU, 'workers' machinery is us=
ed
solely to be able to submit requests in async context, thus not forcing cal=
ling
thread to block for a significant time. At worst EAGAIN is expected.

However, when I installed fresh 5.2.0-rc7 kernel on the machine with HDD wi=
th
64-requests-deep queue, I noticed significant increase in time spent in
io_uring_enter() once request queue became full. Below you can find output
of the program that submits random(in 1GB range) 4K read requests in batche=
s
of 32. Though O_DIRECT is used, the same phenomenon is observed when using
page cache. Source code can be found here:
https://github.com/Phikimon/io_uring_question

While analyzing stack dump, I found out that IOCB_NOWAIT flag being set
does not prevent generic_file_read_iter() from calling blkdev_direct_IO(),
so thread gets stuck for hundreds of milliseconds. However, I am not a
Linux kernel expert, so I can not be sure this is actually related to the
mentioned issue.

Is it actually expected that io_uring would sleep in case there is no slot
in block device's request queue, or is this a bug of current implementation=
?

root@localhost:~/io_uring# uname -msr
Linux 5.2.0-rc7 x86_64
root@localhost:~/io_uring# hdparm -I /dev/sda | grep Model
Model Number:       Hitachi HTS541075A9E680
root@localhost:~/io_uring# cat /sys/block/sda/queue/nr_requests
64
root@localhost:~/io_uring# ./io_uring_read_blkdev /dev/sda8
submitted_already =3D   0, submitted_now =3D  32, submit_time =3D     246 u=
s
submitted_already =3D  32, submitted_now =3D  32, submit_time =3D     130 u=
s
submitted_already =3D  64, submitted_now =3D  32, submit_time =3D  189548 u=
s
submitted_already =3D  96, submitted_now =3D  32, submit_time =3D  121542 u=
s
submitted_already =3D 128, submitted_now =3D  32, submit_time =3D  128314 u=
s
submitted_already =3D 160, submitted_now =3D  32, submit_time =3D  136345 u=
s
submitted_already =3D 192, submitted_now =3D  32, submit_time =3D  162320 u=
s
root@localhost:~/io_uring# cat pstack_output # This is where process slept
[<0>] io_schedule+0x16/0x40
[<0>] blk_mq_get_tag+0x166/0x280
[<0>] blk_mq_get_request+0xde/0x380
[<0>] blk_mq_make_request+0x11e/0x5b0
[<0>] generic_make_request+0x191/0x3c0
[<0>] submit_bio+0x75/0x140
[<0>] blkdev_direct_IO+0x3f8/0x4a0
[<0>] generic_file_read_iter+0xbf/0xdc0
[<0>] blkdev_read_iter+0x37/0x40
[<0>] io_read+0xf6/0x180
[<0>] __io_submit_sqe+0x1cd/0x6a0
[<0>] io_submit_sqe+0xea/0x4b0
[<0>] io_ring_submit+0x86/0x120
[<0>] __x64_sys_io_uring_enter+0x241/0x2d0
[<0>] do_syscall_64+0x60/0x1a0
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
[<0>] 0xffffffffffffffff

P.S. There are also several suspicious places in liburing and io_uring's ke=
rnel
     part. I'm not sure if these are really bugs, so please point out if an=
y of
     them needs a fixing patch. Among them:
1. Inaccurate handling of errors in liburing/__io_uring_submit(). Because
   liburing currently does not care about queue head that kernel sets, it c=
annot
   know how many entries have been actually consumed. In case e.g.
   io_uring_enter() returns EAGAIN, and consumes none of the sqes, sq->sqe_=
head
   still advances in __io_uring_submit(), this can eventually cause both
   io_uring_submit() and io_uring_sqe() return 0 forever.
2. There is also a related issue -- when using IORING_SETUP_SQPOLL, in case
   polling kernel thread already went to sleep(IORING_SQ_NEED_WAKEUP is set=
),
   io_uring_enter() just wakes it up and immediately reports all @to_submit
   requests are consumed, while this is not true until awaken thread will m=
anage
   to handle them. At least this contradicts with man page, which states:
   > When the system call returns that a certain amount of SQEs have been
   > consumed and submitted, it's safe to reuse SQE entries in the ring.
   It is easy to reproduce this bug -- just change e.g. ->offset field in t=
he
   SQE immediately after io_uring_enter() successfully returns and you will=
 see
   that IO happened on new offset.
3. Again due to lack of synchronization between io_sq_thread() and
   io_uring_enter(), in case the ring is full and IORING_SETUP_SQPOLL is us=
ed,
   it seems there is no other way for application to wait for slots in SQ t=
o
   become available but busy waiting for *sq->khead to advance. Thus from o=
ne
   busy waiting thread we get two. Is this the expected behavior? Should th=
e
   user of IORING_SETUP_SQPOLL busy wait for slots in SQ?
4. Minor one: in case sq_thread_idle is set to ridiculously big value(e.g. =
100
   sec), kernel watchdog starts reporting this as a bug.
   > Message from syslogd@centos-linux at Jun 21 20:00:04 ...
   >  kernel:watchdog: BUG: soft lockup - CPU#0 stuck for 21s! [io_uring-sq=
:10691]

Looking forward to your reply and thank you in advance.=
