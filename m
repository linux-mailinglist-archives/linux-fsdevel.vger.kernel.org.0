Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05FA06822A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2019 04:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbfGOCKC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Jul 2019 22:10:02 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:36474 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727006AbfGOCKC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Jul 2019 22:10:02 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0TWte0iC_1563156576;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TWte0iC_1563156576)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 15 Jul 2019 10:09:37 +0800
Subject: Re: [PATCH 1/4] numa: introduce per-cgroup numa balancing locality,
 statistic
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
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
 <b027f9cc-edd2-840c-3829-176a1e298446@linux.alibaba.com>
 <20190712075815.GN3402@hirez.programming.kicks-ass.net>
 <37474414-1a54-8e3a-60df-eb7e5e1cc1ed@linux.alibaba.com>
 <20190712094214.GR3402@hirez.programming.kicks-ass.net>
 <f8020f92-045e-d515-360b-faf9a149ab80@linux.alibaba.com>
Message-ID: <673993cf-c5cc-475d-1396-991edcf367ea@linux.alibaba.com>
Date:   Mon, 15 Jul 2019 10:09:36 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <f8020f92-045e-d515-360b-faf9a149ab80@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2019/7/12 下午6:10, 王贇 wrote:
[snip]
>>
>> Documentation/cgroup-v1/cpusets.txt
>>
>> Look for mems_allowed.
> 
> This is the attribute belong to cpuset cgroup isn't it?
> 
> Forgive me but I have no idea on how to combined this
> with memory cgroup's locality hierarchical update...
> parent memory cgroup do not have influence on mems_allowed
> to it's children, correct?
> 
> What about we just account the locality status of child
> memory group into it's ancestors?

We have rethink about this, and found no strong reason to stay
with memory cgroup anymore.

We used to acquire pages number, exectime and locality together
from memory cgroup, to make thing easier for our numa balancer
module, as now we use the numa group approach, maybe we can just
move these accounting into cpu cgroups, so all these features
stay in one subsys and could be hierarchical :-)

Regards,
Michael Wang

> 
> Regards,
> Michael Wang
> 
>>
