Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81633FBDB2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2019 02:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfKNBws (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 20:52:48 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:55764 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726098AbfKNBws (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 20:52:48 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0Ti0ZFre_1573696360;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0Ti0ZFre_1573696360)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 14 Nov 2019 09:52:43 +0800
Subject: Re: [PATCH 3/3] sched/numa: documentation for per-cgroup numa stat
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
References: <743eecad-9556-a241-546b-c8a66339840e@linux.alibaba.com>
 <896a7da3-f139-32e7-8a64-b3562df1a091@linux.alibaba.com>
 <20191113080912.041918ce@lwn.net>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <359ef90a-aecc-c382-0dd2-2ad7445fb821@linux.alibaba.com>
Date:   Thu, 14 Nov 2019 09:52:10 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113080912.041918ce@lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Jonathan

On 2019/11/13 下午11:09, Jonathan Corbet wrote:
> On Wed, 13 Nov 2019 11:45:59 +0800
> 王贇 <yun.wang@linux.alibaba.com> wrote:
> 
>> Add the description for 'cg_numa_stat', also a new doc to explain
>> the details on how to deal with the per-cgroup numa statistics.
>>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Michal Koutný <mkoutny@suse.com>
>> Cc: Mel Gorman <mgorman@suse.de>
>> Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
>> ---
>>  Documentation/admin-guide/cg-numa-stat.rst      | 161 ++++++++++++++++++++++++
>>  Documentation/admin-guide/kernel-parameters.txt |   4 +
>>  Documentation/admin-guide/sysctl/kernel.rst     |   9 ++
>>  3 files changed, 174 insertions(+)
>>  create mode 100644 Documentation/admin-guide/cg-numa-stat.rst
> 
> Thanks for adding documentation for your new feature!  When you add a new
> RST file, though, you should also add it to index.rst so that it becomes a
> part of the docs build.

Thanks for pointing out :-) will fix this in next version.

> 
> A couple of nits below...
> 
>> diff --git a/Documentation/admin-guide/cg-numa-stat.rst b/Documentation/admin-guide/cg-numa-stat.rst
>> new file mode 100644
>> index 000000000000..87b716c51e16
>> --- /dev/null
[snip]
>> +For example the 'cpu.numa_stat' show:
>> +  locality 39541 60962 36842 72519 118605 721778 946553
>> +  exectime 1220127 1458684
> 
> You almost certainly want that rendered as a literal block, so say
> "show::".  There are other places where you'll want to do that as well. 

I see, will fix such cases.

> 
>> +The locality is sectioned into 7 regions, closely as:
>> +  0-13% 14-27% 28-42% 43-56% 57-71% 72-85% 86-100%
>> +
>> +And exectime is sectioned into 2 nodes, 0 and 1 in this case.
>> +
>> +Thus we know the workload of this group and it's descendants have totally
>> +executed 1220127ms on node_0 and 1458684ms on node_1, tasks with locality
>> +around 0~13% executed for 39541 ms, and tasks with locality around 87~100%
>> +executed for 946553 ms, which imply most of the memory access are local.
>> +
>> +Monitoring
>> +-----------------
> 
> A slightly long underline :)

Aha, will fix this too.

Regards,
Michael Wang

> 
> I'll stop here; thanks again for adding documentation.
> 
> jon
> 
