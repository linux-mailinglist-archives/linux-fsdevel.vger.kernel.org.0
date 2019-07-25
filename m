Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5F474BBF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2019 12:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387451AbfGYKi6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jul 2019 06:38:58 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:52122 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfGYKi5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jul 2019 06:38:57 -0400
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x6PAcHRM014383;
        Thu, 25 Jul 2019 19:38:17 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp);
 Thu, 25 Jul 2019 19:38:17 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x6PAcH6I014372
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 25 Jul 2019 19:38:17 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] hung_task: Allow printing warnings every check interval
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20190724170249.9644-1-dima@arista.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <2964b430-63d6-e172-84e2-cb269cf43443@i-love.sakura.ne.jp>
Date:   Thu, 25 Jul 2019 19:38:13 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724170249.9644-1-dima@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/07/25 2:02, Dmitry Safonov wrote:
> Hung task detector has one timeout and has two associated actions on it:
> - issuing warnings with names and stacks of blocked tasks
> - panic()
> 
> We want switches to panic (and reboot) if there's a task
> in uninterruptible sleep for some minutes - at that moment something
> ugly has happened and the box needs a reboot.
> But we also want to detect conditions that are "out of range"
> or approaching the point of failure. Under such conditions we want
> to issue an "early warning" of an impending failure, minutes before
> the switch is going to panic.

Can't we do it by extending sysctl_hung_task_panic to accept values larger
than 1, and decrease by one when at least one thread was reported by each
check_hung_uninterruptible_tasks() check, and call panic() when
sysctl_hung_task_panic reached to 0 (or maybe 1 is simpler) ?

Hmm, might have the same problem regarding how/when to reset the counter.
If some userspace process can reset the counter, such process can trigger
SysRq-c when some period expired...

> It seems rather easy to add printing tasks and their stacks for
> notification and debugging purposes into hung task detector without
> complicating the code or major cost (prints are with KERN_INFO loglevel
> and so don't go on console, only into dmesg log).

Well, I don't think so. Might be noisy for systems without "quiet" kernel
command line option, and we can't pass KERN_DEBUG to e.g. sched_show_task()...

