Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 694E42472BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Aug 2020 20:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389221AbgHQSq4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 14:46:56 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56029 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388042AbgHQPzv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:55:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597679746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k6oJC/PPG0hRAekHdOQPH1JgLE6OMEX6unSGcCgCQZY=;
        b=Qn2JWxWYPd16clvgohqpFLiqnZivNmxR1L1HUOTrXsKPFfBCgZGk3G2xosACBCGLv7kXUi
        IjR+8Lxq72ogIY0687rLw2QUj5PzoWrVuv76j51RtiKKVaLB2CxhbtJ7ckW1h1H7K3cFch
        crEnZPhIb+fYK1cGphCruIm5jHdBZdI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-Rbny8aeWOpiIteDTxPfBTQ-1; Mon, 17 Aug 2020 11:55:44 -0400
X-MC-Unique: Rbny8aeWOpiIteDTxPfBTQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81E101DDEB;
        Mon, 17 Aug 2020 15:55:42 +0000 (UTC)
Received: from llong.remote.csb (ovpn-118-35.rdu2.redhat.com [10.10.118.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 950E37D901;
        Mon, 17 Aug 2020 15:55:37 +0000 (UTC)
Subject: Re: [RFC PATCH 0/8] memcg: Enable fine-grained per process memory
 control
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
References: <20200817140831.30260-1-longman@redhat.com>
 <20200817152655.GE28270@dhcp22.suse.cz>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <e66d6b5f-6f02-8c8f-681e-1d6da7a72224@redhat.com>
Date:   Mon, 17 Aug 2020 11:55:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200817152655.GE28270@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/17/20 11:26 AM, Michal Hocko wrote:
> On Mon 17-08-20 10:08:23, Waiman Long wrote:
>> Memory controller can be used to control and limit the amount of
>> physical memory used by a task. When a limit is set in "memory.high" in
>> a v2 non-root memory cgroup, the memory controller will try to reclaim
>> memory if the limit has been exceeded. Normally, that will be enough
>> to keep the physical memory consumption of tasks in the memory cgroup
>> to be around or below the "memory.high" limit.
>>
>> Sometimes, memory reclaim may not be able to recover memory in a rate
>> that can catch up to the physical memory allocation rate. In this case,
>> the physical memory consumption will keep on increasing.  When it reaches
>> "memory.max" for memory cgroup v2 or when the system is running out of
>> free memory, the OOM killer will be invoked to kill some tasks to free
>> up additional memory. However, one has little control of which tasks
>> are going to be killed by an OOM killer. Killing tasks that hold some
>> important resources without freeing them first can create other system
>> problems down the road.
>>
>> Users who do not want the OOM killer to be invoked to kill random
>> tasks in an out-of-memory situation can use the memory control
>> facility provided by this new patchset via prctl(2) to better manage
>> the mitigation action that needs to be performed to various tasks when
>> the specified memory limit is exceeded with memory cgroup v2 being used.
>>
>> The currently supported mitigation actions include the followings:
>>
>>   1) Return ENOMEM for some syscalls that allocate or handle memory
>>   2) Slow down the process for memory reclaim to catch up
>>   3) Send a specific signal to the task
>>   4) Kill the task
>>
>> The users that want better memory control for their applicatons can
>> either modify their applications to call the prctl(2) syscall directly
>> with the new memory control command code or write the desired action to
>> the newly provided memctl procfs files of their applications provided
>> that those applications run in a non-root v2 memory cgroup.
> prctl is fundamentally about per-process control while cgroup (not only
> memcg) is about group of processes interface. How do those two interact
> together? In other words what is the semantic when different processes
> have a different views on the same underlying memcg event?
As said in a previous mail, this patchset is derived from a customer 
request and per-process control is exactly what the customer wants. That 
is why prctl() is used. This patchset is intended to supplement the 
existing memory cgroup features. Processes in a memory cgroup that don't 
use this new API will behave exactly like before. Only processes that 
opt to use this new API will have additional mitigation actions applied 
on them in case the additional limits are reached.
>
> Also the above description doesn't really describe any usecase which
> struggles with the existing interface. We already do allow slow down and
> along with PSI also provide user space control over close to OOM
> situation.
>
The customer that request it was using Solaris. Solaris does allow 
per-process memory control and they have tools that rely on this 
capability. This patchset will help them migrate off Solaris easier. I 
will look closer into how PSI can help here.

Thanks,
Longman

