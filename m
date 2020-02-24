Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0E6D169C85
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 04:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbgBXDJL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Feb 2020 22:09:11 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:47240 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727156AbgBXDJL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Feb 2020 22:09:11 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04455;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0Tqhg-oW_1582513746;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0Tqhg-oW_1582513746)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 24 Feb 2020 11:09:08 +0800
Subject: Re: [PATCH RESEND v8 1/2] sched/numa: introduce per-cgroup NUMA
 locality info
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Michal Koutn? <mkoutny@suse.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <fe56d99d-82e0-498c-ae44-f7cde83b5206@linux.alibaba.com>
 <cde13472-46c0-7e17-175f-4b2ba4d8148a@linux.alibaba.com>
 <20200214151048.GL14914@hirez.programming.kicks-ass.net>
 <20200217115810.GA3420@suse.de>
 <881deb50-163e-442a-41ec-b375cc445e4d@linux.alibaba.com>
 <20200221152824.GH18400@hirez.programming.kicks-ass.net>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <3bd3f4d0-2504-a48c-adea-a28227a81d7a@linux.alibaba.com>
Date:   Mon, 24 Feb 2020 11:09:06 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200221152824.GH18400@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2020/2/21 下午11:28, Peter Zijlstra wrote:
> On Mon, Feb 17, 2020 at 09:23:52PM +0800, 王贇 wrote:
>> FYI, by monitoring locality, we found that the kvm vcpu thread is not
>> covered by NUMA Balancing, whatever how many maximum period passed, the
>> counters are not increasing, or very slowly, although inside guest we are
>> copying memory.
>>
>> Later we found such task rarely exit to user space to trigger task
>> work callbacks, and NUMA Balancing scan depends on that, which help us
>> realize the importance to enable NUMA Balancing inside guest, with the
>> correct NUMA topo, a big performance risk I'll say :-P
> 
> That's a bug in KVM, see:
> 
>   https://lkml.kernel.org/r/20190801143657.785902257@linutronix.de
>   https://lkml.kernel.org/r/20190801143657.887648487@linutronix.de
> 
> ISTR there being newer versions of that patch-set, but I can't seem to
> find them in a hurry.

Aha, that's exactly the problem we saw, will check~

Regards,
Michael Wang

> 
