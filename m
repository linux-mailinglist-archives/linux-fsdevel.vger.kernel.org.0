Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE5D010D0D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2019 06:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfK2FTm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Nov 2019 00:19:42 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:35519 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725812AbfK2FTm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Nov 2019 00:19:42 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0TjMcOpq_1575004773;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TjMcOpq_1575004773)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 29 Nov 2019 13:19:34 +0800
Subject: Re: [PATCH v2 1/3] sched/numa: advanced per-cgroup numa statistic
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
References: <743eecad-9556-a241-546b-c8a66339840e@linux.alibaba.com>
 <207ef46c-672c-27c8-2012-735bd692a6de@linux.alibaba.com>
 <9354ffe8-81ba-9e76-e0b3-222bc942b3fc@linux.alibaba.com>
 <20191127101932.GN28938@suse.de>
 <3ff78d18-fa29-13f3-81e5-a05537a2e344@linux.alibaba.com>
 <20191128123924.GD831@blackbody.suse.cz>
 <e008fef6-06d2-28d3-f4d3-229f4b181b4f@linux.alibaba.com>
 <20191128155818.GE831@blackbody.suse.cz>
 <b97ce489-c5c5-0670-a553-0e45d593de2c@linux.alibaba.com>
Message-ID: <f9da5ce8-519e-62b4-36f7-8e5bbf0485fd@linux.alibaba.com>
Date:   Fri, 29 Nov 2019 13:19:33 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <b97ce489-c5c5-0670-a553-0e45d593de2c@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2019/11/29 上午9:52, 王贇 wrote:
[snip]
>> That would avoid the partitioning question completely, exposed values
>> would be simple numbers and provided information should be equal. A
>> drawback is that such a sampling would be slower (but sufficient for the
>> illustrating example).
> 
> You mean the cgroup numa stat just give the accumulated local/remote access?
> 
> As long as the counter won't overflow, maybe... sounds easier to explain too.
> 
> So user tracing locality will then get just one percentage (calculated on
> their own) from a cgroup, but one should be enough to represent the situation.
> 
> Sounds like a good idea to me :-) will try to do that in next version.

I did some research regarding cpuacct, and find cpuacct_charge() is a good
place to do hierarchical update, however, what we get there is the execution
time delta since last update_curr().

I'm afraid we can't just do local/remote accumulation since the sample period
now is changing, still have to accumulate the execution time into locality
regions.

While at least we should be able to address your concern regarding exectime
collection :-)

Regards,
Michael Wang

> 
> Regards,
> Michael Wang
> 
>>
>> Michal
>>
