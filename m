Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3746D664D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2019 05:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbfGLDKP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jul 2019 23:10:15 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:45891 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729239AbfGLDKO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jul 2019 23:10:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0TWfcINf_1562901008;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TWfcINf_1562901008)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 12 Jul 2019 11:10:09 +0800
Subject: Re: [PATCH 4/4] numa: introduce numa cling feature
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mcgrof@kernel.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        Mel Gorman <mgorman@suse.de>, riel@surriel.com
References: <209d247e-c1b2-3235-2722-dd7c1f896483@linux.alibaba.com>
 <60b59306-5e36-e587-9145-e90657daec41@linux.alibaba.com>
 <9a440936-1e5d-d3bb-c795-ef6f9839a021@linux.alibaba.com>
 <20190711142728.GF3402@hirez.programming.kicks-ass.net>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <82f42063-ce51-dd34-ba95-5b32ee733de7@linux.alibaba.com>
Date:   Fri, 12 Jul 2019 11:10:08 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190711142728.GF3402@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2019/7/11 下午10:27, Peter Zijlstra wrote:
[snip]
>> Thus we introduce the numa cling, which try to prevent tasks leaving
>> the preferred node on wakeup fast path.
> 
> 
>> @@ -6195,6 +6447,13 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>>  	if ((unsigned)i < nr_cpumask_bits)
>>  		return i;
>>
>> +	/*
>> +	 * Failed to find an idle cpu, wake affine may want to pull but
>> +	 * try stay on prev-cpu when the task cling to it.
>> +	 */
>> +	if (task_numa_cling(p, cpu_to_node(prev), cpu_to_node(target)))
>> +		return prev;
>> +
>>  	return target;
>>  }
> 
> Select idle sibling should never cross node boundaries and is thus the
> entirely wrong place to fix anything.

Hmm.. in our early testing the printk show both select_task_rq_fair() and
task_numa_find_cpu() will call select_idle_sibling with prev and target on
different node, thus we pick this point to save few lines.

But if the semantics of select_idle_sibling() is to return cpu on the same
node of target, what about move the logical after select_idle_sibling() for
the two callers?

Regards,
Michael Wang

> 
