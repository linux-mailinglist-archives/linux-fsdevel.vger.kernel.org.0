Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AABF6F812
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2019 05:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfGVDoy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Jul 2019 23:44:54 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:44419 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726106AbfGVDoy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Jul 2019 23:44:54 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0TXSDwvJ_1563767088;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TXSDwvJ_1563767088)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 22 Jul 2019 11:44:49 +0800
Subject: Re: [PATCH 4/4] numa: introduce numa cling feature
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
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
 <82f42063-ce51-dd34-ba95-5b32ee733de7@linux.alibaba.com>
 <20190712075318.GM3402@hirez.programming.kicks-ass.net>
 <0a5066be-ac10-5dce-c0a6-408725bc0784@linux.alibaba.com>
Message-ID: <c85b5868-150f-7114-18cd-a5e9cd55f406@linux.alibaba.com>
Date:   Mon, 22 Jul 2019 11:44:48 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <0a5066be-ac10-5dce-c0a6-408725bc0784@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2019/7/12 下午4:58, 王贇 wrote:
[snip]
> 
> I see, we should not override the decision of select_idle_sibling().
> 
> Actually the original design we try to achieve is:
> 
>   let wake affine select the target
>   try find idle sibling of target
>   if got one
> 	pick it
>   else if task cling to prev
> 	pick prev
> 
> That is to consider wake affine superior to numa cling.
> 
> But after rethinking maybe this is not necessary, since numa cling is
> also some kind of strong wake affine hint, actually maybe even a better
> one to filter out the bad cases.
> 
> I'll try change @target instead and give a retest then.

We now leave select_idle_sibling() untouched, instead prevent numa swap
with task cling to dst, and stop wake affine when curr & prev cpu are on
different node and wakee cling to prev.

Retesting show a even better results, benchmark like dbench also show 1%~5%
improvement, not stable but always improved now :-)

Regards,
Michael Wang

> 
> Regards,
> Michael Wang
> 
