Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A208366529
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2019 05:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbfGLDnW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jul 2019 23:43:22 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:46903 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729293AbfGLDnV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jul 2019 23:43:21 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0TWfco61_1562902997;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TWfco61_1562902997)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 12 Jul 2019 11:43:18 +0800
Subject: Re: [PATCH 1/4] numa: introduce per-cgroup numa balancing locality,
 statistic
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mcgrof@kernel.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        Mel Gorman <mgorman@suse.de>, riel@surriel.com
References: <209d247e-c1b2-3235-2722-dd7c1f896483@linux.alibaba.com>
 <60b59306-5e36-e587-9145-e90657daec41@linux.alibaba.com>
 <3ac9b43a-cc80-01be-0079-df008a71ce4b@linux.alibaba.com>
 <20190711134754.GD3402@hirez.programming.kicks-ass.net>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <b027f9cc-edd2-840c-3829-176a1e298446@linux.alibaba.com>
Date:   Fri, 12 Jul 2019 11:43:17 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190711134754.GD3402@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2019/7/11 下午9:47, Peter Zijlstra wrote:
[snip]
>> +	rcu_read_lock();
>> +	memcg = mem_cgroup_from_task(p);
>> +	if (idx != -1)
>> +		this_cpu_inc(memcg->stat_numa->locality[idx]);
> 
> I thought cgroups were supposed to be hierarchical. That is, if we have:
> 
>           R
> 	 / \
> 	 A
> 	/\
> 	  B
> 	  \
> 	   t1
> 
> Then our task t1 should be accounted to B (as you do), but also to A and
> R.

I get the point but not quite sure about this...

Not like pages there are no hierarchical limitation on locality, also tasks
running in a particular group have no influence to others, not to mention the
extra overhead, does it really meaningful to account the stuff hierarchically?

Regards,
Michael Wang

> 
>> +	rcu_read_unlock();
>> +}
>> +#endif
