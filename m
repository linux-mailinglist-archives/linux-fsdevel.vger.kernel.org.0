Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD83424EAF3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Aug 2020 04:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgHWCtb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Aug 2020 22:49:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52556 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726999AbgHWCta (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Aug 2020 22:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598150969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TE0Zpj1FO1fCF2Nzd7hXL6TqjYYA4mP9yp1lb4isM3o=;
        b=PE7FzAPRK5gVl3krnskUvDTlMAMVO9oqCGehoZoPeZeK91NkBCF9IQn0YFHlGF6wl/0x5t
        kvAaBT5kbmhAmyL6L8Uj1TKu7EVchcmPg5d8LJ6O0cVI9FIi/Nn5vgyHGDLHymJ0NSndPZ
        jqFCb+aB/W27/VEKVzo7/R8npXeqiQc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-bJphY9BWNqKZtumUMnw_PA-1; Sat, 22 Aug 2020 22:49:27 -0400
X-MC-Unique: bJphY9BWNqKZtumUMnw_PA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 126901074658;
        Sun, 23 Aug 2020 02:49:25 +0000 (UTC)
Received: from llong.remote.csb (ovpn-112-211.rdu2.redhat.com [10.10.112.211])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CFF076E715;
        Sun, 23 Aug 2020 02:49:19 +0000 (UTC)
Subject: Re: [RFC PATCH 0/8] memcg: Enable fine-grained per process memory
 control
To:     Chris Down <chris@chrisdown.name>, peterz@infradead.org
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
References: <20200817140831.30260-1-longman@redhat.com>
 <20200818091453.GL2674@hirez.programming.kicks-ass.net>
 <20200818092617.GN28270@dhcp22.suse.cz>
 <20200818095910.GM2674@hirez.programming.kicks-ass.net>
 <20200818101756.GA155582@chrisdown.name>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <989570d6-639e-6385-d638-c4729665c2e4@redhat.com>
Date:   Sat, 22 Aug 2020 22:49:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200818101756.GA155582@chrisdown.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/18/20 6:17 AM, Chris Down wrote:
> peterz@infradead.org writes:
>> But then how can it run-away like Waiman suggested?
>
> Probably because he's not running with that commit at all. We and 
> others use this to prevent runaway allocation on a huge range of 
> production and desktop use cases and it works just fine.
>
>> /me goes look... and finds MEMCG_MAX_HIGH_DELAY_JIFFIES.
>>
>> That's a fail... :-(
>
> I'd ask that you understand a bit more about the tradeoffs and 
> intentions of the patch before rushing in to declare its failure, 
> considering it works just fine :-)
>
> Clamping the maximal time allows the application to take some action 
> to remediate the situation, while still being slowed down 
> significantly. 2 seconds per allocation batch is still absolutely 
> plenty for any use case I've come across. If you have evidence it 
> isn't, then present that instead of vague notions of "wrongness".
>
Sorry for the late reply.

I ran some test on the latest kernel and and it seems to work as 
expected. I was running the test on an older kernel that doesn't have 
this patch and I was not aware of it before hand.

Sorry for the confusion.

Cheers,
Longman

