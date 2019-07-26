Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF4A76486
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2019 13:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbfGZLao (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jul 2019 07:30:44 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:58716 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfGZLao (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jul 2019 07:30:44 -0400
Received: from fsav303.sakura.ne.jp (fsav303.sakura.ne.jp [153.120.85.134])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x6QBU0JI005258;
        Fri, 26 Jul 2019 20:30:00 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav303.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp);
 Fri, 26 Jul 2019 20:30:00 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x6QBTrHb005193
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 26 Jul 2019 20:30:00 +0900 (JST)
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
 <2964b430-63d6-e172-84e2-cb269cf43443@i-love.sakura.ne.jp>
 <aa151251-d271-1e65-1cae-0d9da9764d56@arista.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <9a919c32-4e0e-ca1b-887f-c329543913d3@i-love.sakura.ne.jp>
Date:   Fri, 26 Jul 2019 20:29:52 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <aa151251-d271-1e65-1cae-0d9da9764d56@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/07/25 23:25, Dmitry Safonov wrote:
> Yes, also current distributions already using the counter to print
> warnings number of times and then silently ignore. I.e., on my Arch
> Linux setup:
> hung_task_warnings:10

You can propose changing the default value of hung_task_warnings to -1.

Current patch might be inconvenient because printk() from hung_task_warning(t, false)
fails to go to consoles when that "t" was blocked for more than "timeout" seconds, for

	if (sysctl_hung_task_panic) {
		console_verbose();
		hung_task_show_lock = true;
		hung_task_call_panic = true;
	}

path which is intended to force printk() to go to consoles is ignored by

	/* Don't print warings twice */
	if (!sysctl_hung_task_interval_warnings)
		hung_task_warning(t, true);

when panic() should be called. (The vmcore would contain the printk() output which
was not sent to consoles if kdump is configured. But vmcore is not always available.)

> Yes, that's why it's disabled by default (=0).
> I tend to agree that printing with KERN_DEBUG may be better, but in my
> point of view the patch isn't enough justification for patching
> sched_show_task() and show_stack().

You can propose sched_show_task_log_lvl() and show_stack_log_lvl() like show_trace_log_lvl().

I think that sysctl_hung_task_interval_warnings should not be decremented automatically.
I guess that that variable should become a boolean which controls whether to report threads
(with KERN_DEBUG level) which was blocked for more than sysctl_hung_task_check_interval_secs
seconds (or a tristate which also controls whether the report should be sent to consoles
(because KERN_DEBUG level likely prevents sending to consoles)), and
hung_task_warning(t, false) should be called like

	if (time_is_after_jiffies(t->last_switch_time + timeout * HZ)) {
		if (sysctl_hung_task_interval_warnings)
			hung_task_warning(t, false);
		return;
	}

rather than

	if (sysctl_hung_task_interval_warnings)
		hung_task_warning(t, false);
	if (time_is_after_jiffies(t->last_switch_time + timeout * HZ))
		return;

.

