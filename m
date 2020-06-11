Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF561F6964
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jun 2020 15:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgFKNvw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jun 2020 09:51:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31955 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726109AbgFKNvw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jun 2020 09:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591883509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9+HdOR4975sbAEuB1RaL0b8J+blDp+Ho3Hrxc6qjF2Y=;
        b=hDxxEFoWpdIPPIFlfCo9sRR1Q8iET3Q6Udia7BFI1A1HTHwsBTEtaSMgbvdWBAVqf3DiTS
        rgJF1qGuAL4P1hQxbZ3VW53iLTkL/KJ3eTCSGfSt4wbtPXXlc7yGnDHBz6L4XNj2xMJPwX
        +WDoMbfs3qBRu/5/P4xDqiLEkF8tejk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-WrLPbTxGNc6pRAjkTVHJUQ-1; Thu, 11 Jun 2020 09:51:41 -0400
X-MC-Unique: WrLPbTxGNc6pRAjkTVHJUQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64B73107ACCA;
        Thu, 11 Jun 2020 13:51:36 +0000 (UTC)
Received: from llong.remote.csb (ovpn-115-149.rdu2.redhat.com [10.10.115.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B82E410013C1;
        Thu, 11 Jun 2020 13:51:29 +0000 (UTC)
Subject: Re: possible deadlock in send_sigio
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+a9fb1457d720a55d6dc5@syzkaller.appspotmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, allison@lohutok.net,
        areber@redhat.com, aubrey.li@linux.intel.com,
        Andrei Vagin <avagin@gmail.com>,
        Bruce Fields <bfields@fieldses.org>,
        Christian Brauner <christian@brauner.io>, cyphar@cyphar.com,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, guro@fb.com,
        Jeff Layton <jlayton@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Kees Cook <keescook@chromium.org>, linmiaohe@huawei.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>, Ingo Molnar <mingo@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, sargun@sargun.me,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <000000000000760d0705a270ad0c@google.com>
 <69818a6c-7025-8950-da4b-7fdc065d90d6@redhat.com>
 <CACT4Y+brpePBoR7EUwPiSvGAgo6bhvpKvLTiCaCfRSadzn6yRw@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <88c172af-46df-116e-6f22-b77f98803dcb@redhat.com>
Date:   Thu, 11 Jun 2020 09:51:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+brpePBoR7EUwPiSvGAgo6bhvpKvLTiCaCfRSadzn6yRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/11/20 3:43 AM, Dmitry Vyukov wrote:
> On Thu, Jun 11, 2020 at 4:33 AM Waiman Long <longman@redhat.com> wrote:
>> On 4/4/20 1:55 AM, syzbot wrote:
>>> Hello,
>>>
>>> syzbot found the following crash on:
>>>
>>> HEAD commit:    bef7b2a7 Merge tag 'devicetree-for-5.7' of git://git.kerne..
>>> git tree:       upstream
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=15f39c5de00000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=91b674b8f0368e69
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=a9fb1457d720a55d6dc5
>>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1454c3b7e00000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12a22ac7e00000
>>>
>>> The bug was bisected to:
>>>
>>> commit 7bc3e6e55acf065500a24621f3b313e7e5998acf
>>> Author: Eric W. Biederman <ebiederm@xmission.com>
>>> Date:   Thu Feb 20 00:22:26 2020 +0000
>>>
>>>       proc: Use a list of inodes to flush from proc
>>>
>>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=165c4acde00000
>>> final crash:    https://syzkaller.appspot.com/x/report.txt?x=155c4acde00000
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=115c4acde00000
>>>
>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>> Reported-by: syzbot+a9fb1457d720a55d6dc5@syzkaller.appspotmail.com
>>> Fixes: 7bc3e6e55acf ("proc: Use a list of inodes to flush from proc")
>>>
>>> ========================================================
>>> WARNING: possible irq lock inversion dependency detected
>>> 5.6.0-syzkaller #0 Not tainted
>>> --------------------------------------------------------
>>> ksoftirqd/0/9 just changed the state of lock:
>>> ffffffff898090d8 (tasklist_lock){.+.?}-{2:2}, at: send_sigio+0xa9/0x340 fs/fcntl.c:800
>>> but this lock took another, SOFTIRQ-unsafe lock in the past:
>>>    (&pid->wait_pidfd){+.+.}-{2:2}
>>>
>>>
>>> and interrupts could create inverse lock ordering between them.
>>>
>>>
>>> other info that might help us debug this:
>>>    Possible interrupt unsafe locking scenario:
>>>
>>>          CPU0                    CPU1
>>>          ----                    ----
>>>     lock(&pid->wait_pidfd);
>>>                                  local_irq_disable();
>>>                                  lock(tasklist_lock);
>>>                                  lock(&pid->wait_pidfd);
>>>     <Interrupt>
>>>       lock(tasklist_lock);
>>>
>>>    *** DEADLOCK ***
>> That is a false positive. The qrwlock has the special property that it
>> becomes unfair (for read lock) at interrupt context. So unless it is
>> taking a write lock in the interrupt context, it won't go into deadlock.
>> The current lockdep code does not capture the full semantics of qrwlock
>> leading to this false positive.
> Hi Longman
>
> Thanks for looking into this.
> Now the question is: how should we change lockdep annotations to fix this bug?

There was an old lockdep patch that I think may address the issue, but 
was not merged at the time. I will need to dig it out and see if it can 
be adapted to work in the current kernel. It may take some time.

Cheers,
Longman

