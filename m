Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0E696A090
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2019 04:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730807AbfGPCln (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jul 2019 22:41:43 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:35228 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729512AbfGPClm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jul 2019 22:41:42 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0TX1EVd9_1563244897;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TX1EVd9_1563244897)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 16 Jul 2019 10:41:37 +0800
Subject: Re: [PATCH 1/4] numa: introduce per-cgroup numa balancing locality,
 statistic
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, keescook@chromium.org,
        hannes@cmpxchg.org, vdavydov.dev@gmail.com, mcgrof@kernel.org,
        mhocko@kernel.org, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>, riel@surriel.com,
        Mel Gorman <mgorman@suse.de>, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <209d247e-c1b2-3235-2722-dd7c1f896483@linux.alibaba.com>
 <60b59306-5e36-e587-9145-e90657daec41@linux.alibaba.com>
 <3ac9b43a-cc80-01be-0079-df008a71ce4b@linux.alibaba.com>
 <20190711134754.GD3402@hirez.programming.kicks-ass.net>
 <b027f9cc-edd2-840c-3829-176a1e298446@linux.alibaba.com>
 <20190712075815.GN3402@hirez.programming.kicks-ass.net>
 <37474414-1a54-8e3a-60df-eb7e5e1cc1ed@linux.alibaba.com>
 <20190712094214.GR3402@hirez.programming.kicks-ass.net>
 <f8020f92-045e-d515-360b-faf9a149ab80@linux.alibaba.com>
 <20190715121025.GN9035@blackbody.suse.cz>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <ecd21563-539c-06b1-92f2-26a111163174@linux.alibaba.com>
Date:   Tue, 16 Jul 2019 10:41:36 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190715121025.GN9035@blackbody.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Michal,

Thx for the comments :-)

On 2019/7/15 下午8:10, Michal Koutný wrote:
> Hello Yun.
> 
> On Fri, Jul 12, 2019 at 06:10:24PM +0800, 王贇  <yun.wang@linux.alibaba.com> wrote:
>> Forgive me but I have no idea on how to combined this
>> with memory cgroup's locality hierarchical update...
>> parent memory cgroup do not have influence on mems_allowed
>> to it's children, correct?
> I'd recommend to look at the v2 of the cpuset controller that implements
> the hierarchical behavior among configured memory node sets.

Actually whatever the memory node sets or cpu allow sets is, it will
take effect on task's behavior regarding memory location and cpu
location, while the locality only care about the results rather than
the sets.

For example if we bind tasks to cpus of node 0 and memory allow only
the node 1, by cgroup controller or madvise, then they will running
on node 0 with all the memory on node 1, on each PF for numa balancing,
the task will access page on node 1 from node 0 remotely, so the
locality will always be 0.

> 
> (My comment would better fit to 
>     [PATCH 3/4] numa: introduce numa group per task group
> IIUC, you could use cpuset controller to constraint memory nodes.)
> 
> For the second part (accessing numa statistics, i.e. this patch), I
> wonder wheter this information wouldn't be better presented under the
> cpuset controller too.

Yeah, we realized the cpu cgroup could be a better place to hold these
new statistics, both locality and exectime are task's running behavior,
related to memory location but not the memory behavior, will apply in
next version.

Regards,
Michael Wang

> 
> HTH,
> Michal
> 
