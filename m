Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 530B910E473
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2019 03:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfLBCMN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Dec 2019 21:12:13 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:39806 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727285AbfLBCMN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Dec 2019 21:12:13 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0Tjbq8zw_1575252725;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0Tjbq8zw_1575252725)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 02 Dec 2019 10:12:06 +0800
Subject: Re: [PATCH v2 1/3] sched/numa: advanced per-cgroup numa statistic
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
 <f9da5ce8-519e-62b4-36f7-8e5bbf0485fd@linux.alibaba.com>
 <20191129100639.GI831@blackbody.suse.cz>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <89d49efa-23a5-4bed-cd81-0de05500c518@linux.alibaba.com>
Date:   Mon, 2 Dec 2019 10:11:14 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191129100639.GI831@blackbody.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2019/11/29 下午6:06, Michal Koutný wrote:
> On Fri, Nov 29, 2019 at 01:19:33PM +0800, 王贇 <yun.wang@linux.alibaba.com> wrote:
>> I did some research regarding cpuacct, and find cpuacct_charge() is a good
>> place to do hierarchical update, however, what we get there is the execution
>> time delta since last update_curr().
> I wouldn't extend cpuacct, I'd like to look into using the rstat
> mechanism for per-CPU runtime collection. (Most certainly I won't get
> down to this until mid December though.)
> 
>> I'm afraid we can't just do local/remote accumulation since the sample period
>> now is changing, still have to accumulate the execution time into locality
>> regions.y
> My idea was to decouple time from the locality counters completely. It'd
> be up to the monitoring application to normalize differences wrt
> sampling rate (and handle wrap arounds).

I see, basically I understand your proposal as utilize cpuacct's runtime
and only expose per-cgroup local/remote counters, I'm not sure if the
locality still helpful after decouple time factor from it, both need some
investigation, anyway, once I could convince myself it's working, I'll
be happy to make things simple ;-)

Regards,
Michael Wang

> 
> 
> Michal
> 
