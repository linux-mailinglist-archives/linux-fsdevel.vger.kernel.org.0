Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E943F7195F0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 10:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbjFAIq7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 04:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbjFAIqW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 04:46:22 -0400
Received: from out-28.mta1.migadu.com (out-28.mta1.migadu.com [IPv6:2001:41d0:203:375::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096891A2
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Jun 2023 01:46:11 -0700 (PDT)
Message-ID: <ce82b32c-95b5-c6ad-9466-39c68dcf5119@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685609168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=viwhASMvyk0Cjm0jq9ZeM+ouB4uWAEMzGdt0PzGjYnA=;
        b=b4INK5nOSvj+75WjbDesPWXE9AWkPJLkn0CqnTqvUvZPjLpeC/weObuZD0D9N+pq2TyM+Q
        SLt6WHzcqRMkacOE6fFeTGK0DV1zDWyMJCvSGdyA9fkcu7loNxzGDd4xlLT3zo7YLqAg8O
        CHFEm/Rhuq4aIM7H7jTCHMz2EGYRaiY=
Date:   Thu, 1 Jun 2023 16:46:00 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 0/8] make unregistration of super_block shrinker more
 faster
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     tkhai@ya.ru, roman.gushchin@linux.dev, vbabka@suse.cz,
        viro@zeniv.linux.org.uk, brauner@kernel.org, djwong@kernel.org,
        hughd@google.com, paulmck@kernel.org, muchun.song@linux.dev,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
References: <20230531095742.2480623-1-qi.zheng@linux.dev>
 <20230531114054.bf077db642aa9c58c0831687@linux-foundation.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <20230531114054.bf077db642aa9c58c0831687@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/6/1 02:40, Andrew Morton wrote:
> On Wed, 31 May 2023 09:57:34 +0000 Qi Zheng <qi.zheng@linux.dev> wrote:
> 
>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>> Hi all,
>>
>> This patch series aims to make unregistration of super_block shrinker more
>> faster.
>>
>> 1. Background
>> =============
>>
>> The kernel test robot noticed a -88.8% regression of stress-ng.ramfs.ops_per_sec
>> on commit f95bdb700bc6 ("mm: vmscan: make global slab shrink lockless"). More
>> details can be seen from the link[1] below.
>>
>> [1]. https://lore.kernel.org/lkml/202305230837.db2c233f-yujie.liu@intel.com/
>>
>> We can just use the following command to reproduce the result:
>>
>> stress-ng --timeout 60 --times --verify --metrics-brief --ramfs 9 &
>>
>> 1) before commit f95bdb700bc6b:
>>
>> stress-ng: info:  [11023] dispatching hogs: 9 ramfs
>> stress-ng: info:  [11023] stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s
>> stress-ng: info:  [11023]                           (secs)    (secs)    (secs)   (real time) (usr+sys time)
>> stress-ng: info:  [11023] ramfs            774966     60.00     10.18    169.45     12915.89        4314.26
>> stress-ng: info:  [11023] for a 60.00s run time:
>> stress-ng: info:  [11023]    1920.11s available CPU time
>> stress-ng: info:  [11023]      10.18s user time   (  0.53%)
>> stress-ng: info:  [11023]     169.44s system time (  8.82%)
>> stress-ng: info:  [11023]     179.62s total time  (  9.35%)
>> stress-ng: info:  [11023] load average: 8.99 2.69 0.93
>> stress-ng: info:  [11023] successful run completed in 60.00s (1 min, 0.00 secs)
>>
>> 2) after commit f95bdb700bc6b:
>>
>> stress-ng: info:  [37676] dispatching hogs: 9 ramfs
>> stress-ng: info:  [37676] stressor       bogo ops real time  usrtime  sys time   bogo ops/s     bogo ops/s
>> stress-ng: info:  [37676]                           (secs)    (secs)   (secs)   (real time) (usr+sys time)
>> stress-ng: info:  [37676] ramfs            168673     60.00     1.61    39.66      2811.08        4087.47
>> stress-ng: info:  [37676] for a 60.10s run time:
>> stress-ng: info:  [37676]    1923.36s available CPU time
>> stress-ng: info:  [37676]       1.60s user time   (  0.08%)
>> stress-ng: info:  [37676]      39.66s system time (  2.06%)
>> stress-ng: info:  [37676]      41.26s total time  (  2.15%)
>> stress-ng: info:  [37676] load average: 7.69 3.63 2.36
>> stress-ng: info:  [37676] successful run completed in 60.10s (1 min, 0.10 secs)
> 
> Is this comparison reversed?  It appears to demonstrate that
> f95bdb700bc6b made the operation faster.

Maybe not. IIUC, the bogo ops/s (real time) bigger the better.

Thanks,
Qi

> 

