Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D3723F5B6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Aug 2020 03:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgHHBB5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 21:01:57 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:50561 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgHHBB5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 21:01:57 -0400
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 07811SRb017623;
        Sat, 8 Aug 2020 10:01:28 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp);
 Sat, 08 Aug 2020 10:01:28 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 07811M8g017602
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 8 Aug 2020 10:01:28 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: INFO: task hung in pipe_read (2)
To:     Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     syzbot <syzbot+96cc7aba7e969b1d305c@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <00000000000045b3fe05abcced2f@google.com>
 <fc097a54-0384-9d21-323f-c3ca52cdb956@I-love.SAKURA.ne.jp>
 <CAHk-=wj15SDiHjP2wPiC=Ru-RrUjOuT4AoULj6N_9pVvSXaWiw@mail.gmail.com>
 <20200807053148.GA10409@redhat.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <e673cccb-1b67-802a-84e3-6aeea4513a09@i-love.sakura.ne.jp>
Date:   Sat, 8 Aug 2020 10:01:21 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200807053148.GA10409@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/08/07 14:31, Andrea Arcangeli wrote:
>> Andrea? Comments? As mentioned, this is probably much too aggressive,
>> but I do think we need to limit the time that the kernel will wait for
>> page faults.
> 
> Why is pipe preventing to SIGKILL the task that is blocked on the
> mutex_lock? Is there any good reason for it or it simply has margin
> for improvement regardless of the hangcheck report? It'd be great if
> we can look into that before looking into the uffd specific bits.

It would be possible to use _killable version for this specific function, but

> 
> The hangcheck timer would have zero issues with tasks that can be
> killed, if only the pipe code could be improved to use mutex_lock_killable.
> 
> 		/* use "==" to skip the TASK_KILLABLE tasks waiting on NFS */
> 		if (t->state == TASK_UNINTERRUPTIBLE)
> 			check_hung_task(t, timeout);
> 
> The hangcheck report is just telling us one task was in D state a
> little too long, but it wasn't fatal error and the kernel wasn't
> actually destabilized and the only malfunction reported is that a task
> was unkillable for too long.

use of killable waits disables ability to detect possibility of deadlock (because
lockdep can't check possibility of deadlock which involves actions in userspace), for
syzkaller process is SIGKILLed after 5 seconds while khungtaskd's timeout is 140 seconds.

If we encounter a deadlock in an unattended operation (e.g. some server process),
we don't have a method for resolving the deadlock. Therefore, I consider that
t->state == TASK_UNINTERRUPTIBLE check is a bad choice. Unless a sleep is neutral
(e.g. no lock is held, or obviously safe to sleep with that specific lock held),
sleeping for 140 seconds inside the kernel is a bad sign even if interruptible/killable.

> 
> Now if it's impossible to improve the pipe code so it works better not
> just for uffd, there's still no reason to worry: we could disable uffd
> in the pipe context. For example ptrace opts-out of uffds, so that gdb
> doesn't get stuck if you read a pointer that should be handled by the
> process that is under debug. I hope it won't be necessary but it
> wouldn't be a major issue, certainly it wouldn't risk breaking qemu
> (and non-cooperative APIs are privileged so it could still skip the
> timeout).

Can we do something like this?

  bool retried = false;
retry:
  lock();
  disable_fault();
  ret = access_memory_that_might_fault();
  enable_fault();
  if (ret == -EWOULDFAULT && !retried)
    goto retry_without_lock;
  if (ret == 0)
    ret = do_something();
  unlock();
  return ret;
retry_without_lock:
  unlock();
  ret = access_memory_that_might_fault();
  retried = true;
  goto retry;

