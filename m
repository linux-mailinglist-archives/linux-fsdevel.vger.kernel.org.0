Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52CB1248E78
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 21:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgHRTOp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 15:14:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31638 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726676AbgHRTOp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 15:14:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597778083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zfJNd7RYls8lhl+N7+nbfG2UK0yQWhrSTT/VQFptF2Q=;
        b=aOBil5bara8TJl0lVxI0iG32QGXVbUxVq4asGMuKQ9KLQaafzrRfQTZEHZd8AZSynw9pu2
        4wvIv23g91NOxRCMxqG0pTNie4z3UhBh/TBJ7t3CTOoFc3JvHpNVq7hwYOpggeSAgzQrvF
        hBCuQfoAZoL6ZdFTa7BCbjtlvi3wEAI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-qCnjyY6iPQiK4u6wOlrzhQ-1; Tue, 18 Aug 2020 15:14:42 -0400
X-MC-Unique: qCnjyY6iPQiK4u6wOlrzhQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6142581F020;
        Tue, 18 Aug 2020 19:14:39 +0000 (UTC)
Received: from llong.remote.csb (ovpn-112-51.rdu2.redhat.com [10.10.112.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6A4091014169;
        Tue, 18 Aug 2020 19:14:07 +0000 (UTC)
Subject: Re: [RFC PATCH 1/8] memcg: Enable fine-grained control of over
 memory.high action
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
References: <20200817140831.30260-1-longman@redhat.com>
 <20200817140831.30260-2-longman@redhat.com>
 <CALvZod5V3N3K9-tDoaq=JgkeuAK=0TkRf97Vua0khXL+Lxw+Pg@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <89179081-697d-232d-a936-697e3c662f65@redhat.com>
Date:   Tue, 18 Aug 2020 15:14:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CALvZod5V3N3K9-tDoaq=JgkeuAK=0TkRf97Vua0khXL+Lxw+Pg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/17/20 12:44 PM, Shakeel Butt wrote:
> On Mon, Aug 17, 2020 at 7:11 AM Waiman Long <longman@redhat.com> wrote:
>> Memory controller can be used to control and limit the amount of
>> physical memory used by a task. When a limit is set in "memory.high"
>> in a non-root memory cgroup, the memory controller will try to reclaim
>> memory if the limit has been exceeded. Normally, that will be enough
>> to keep the physical memory consumption of tasks in the memory cgroup
>> to be around or below the "memory.high" limit.
>>
>> Sometimes, memory reclaim may not be able to recover memory in a rate
>> that can catch up to the physical memory allocation rate especially
>> when rotating disks are used for swapping or writing dirty pages. In
>> this case, the physical memory consumption will keep on increasing.
> Isn't this the real underlying issue? Why not make the guarantees of
> memory.high more strict instead of adding more interfaces and
> complexity?
>
> By the way, have you observed this issue on real workloads or some
> test cases? It would be good to get a repro with simple test cases.
>
As said before, this is from a customer request. I will need to 
re-examine the existing features to see if they can satisfy the customer 
need.

Cheers,
Longman

