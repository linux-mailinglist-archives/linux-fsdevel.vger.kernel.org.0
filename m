Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C81B12A987
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2019 02:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfLZBki (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Dec 2019 20:40:38 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:47778 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726885AbfLZBki (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Dec 2019 20:40:38 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BB881B29549195D034E0;
        Thu, 26 Dec 2019 09:40:36 +0800 (CST)
Received: from [127.0.0.1] (10.184.213.217) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Thu, 26 Dec 2019
 09:40:34 +0800
Subject: Re: [PATCH] fs: inode: Reduce volatile inode wraparound risk when
 ino_t is 64 bit
To:     Chris Down <chris@chrisdown.name>,
        Amir Goldstein <amir73il@gmail.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Jeff Layton" <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Hugh Dickins <hughd@google.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Roman Gushchin <guro@fb.com>
References: <20191220024936.GA380394@chrisdown.name>
 <CAOQ4uxjqSWcrA1reiyit9DRt+aq2tXBxLdPE31RrYw1yr=4hjg@mail.gmail.com>
 <20191220121615.GB388018@chrisdown.name>
 <CAOQ4uxgo_kAttnB4N1+om5gScYSDn3FXAr+_GUiqNy_79iiLXQ@mail.gmail.com>
 <20191220164632.GA26902@bombadil.infradead.org>
 <CAOQ4uxhYY9Ep1ncpU+E3bWg4ZpR8pjvLJMA5vj+7frEJ2KTwsg@mail.gmail.com>
 <20191220195025.GA9469@bombadil.infradead.org>
 <20191223204551.GA272672@chrisdown.name>
 <CAOQ4uxjm5JMvfbi4xa3yaDwuM+XpNOSDrbVsHvJtkms00ZBnAg@mail.gmail.com>
 <20191225125448.GA309148@chrisdown.name>
From:   "zhengbin (A)" <zhengbin13@huawei.com>
Message-ID: <d2205e04-524f-6f7d-000f-7b45b06ed93a@huawei.com>
Date:   Thu, 26 Dec 2019 09:40:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20191225125448.GA309148@chrisdown.name>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.184.213.217]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2019/12/25 20:54, Chris Down wrote:
> Amir Goldstein writes:
>>> The slab i_ino recycling approach works somewhat, but is unfortunately neutered
>>> quite a lot by the fact that slab recycling is per-memcg. That is, replacing
>>> with recycle_or_get_next_ino(old_ino)[0] for shmfs and a few other trivial
>>> callsites only leads to about 10% slab reuse, which doesn't really stem the
>>> bleeding of 32-bit inums on an affected workload:
>>>
>>>      # tail -5000 /sys/kernel/debug/tracing/trace | grep -o 'recycle_or_get_next_ino:.*' | sort | uniq -c
>>>          4454 recycle_or_get_next_ino: not recycled
>>>           546 recycle_or_get_next_ino: recycled
>>>
>>
>> Too bad..
>> Maybe recycled ino should be implemented all the same because it is simple
>> and may improve workloads that are not so MEMCG intensive.
>
> Yeah, I agree. I'll send the full patch over separately (ie. not as v2 for this) since it's not a total solution for the problem, but still helps somewhat and we all seem to agree that it's overall an uncontroversial improvement.

Please cc me as well, thanks.


>
>>> Roman (who I've just added to cc) tells me that currently we only have
>>> per-memcg slab reuse instead of global when using CONFIG_MEMCG. This
>>> contributes fairly significantly here since there are multiple tasks across
>>> multiple cgroups which are contributing to the get_next_ino() thrash.
>>>
>>> I think this is a good start, but we need something of a different magnitude in
>>> order to actually solve this problem with the current slab infrastructure. How
>>> about something like the following?
>>>
>>> 1. Add get_next_ino_full, which uses whatever the full width of ino_t is
>>> 2. Use get_next_ino_full in tmpfs (et al.)
>>
>> I would prefer that filesystems making heavy use of get_next_ino, be converted
>> to use a private ino pool per sb:
>>
>> ino_pool_create()
>> ino_pool_get_next()
>>
>> flags to ino_pool_create() can determine the desired ino range.
>> Does the Facebook use case involve a single large tmpfs or many
>> small ones? I would guess the latter and therefore we are trying to solve
>> a problem that nobody really needs to solve (i.e. global efficient ino pool).
>
> Unfortunately in the case under discussion, it's all in one large tmpfs in /dev/shm. I can empathise with that -- application owners often prefer to use the mounts provided to them rather than having to set up their own. For this one case we can change that, but I think it seems reasonable to support this case since using a single tmpfs can be a reasonable decision as an application developer, especially if you only have unprivileged access to the system.
>
>>> 3. Add a mount option to tmpfs (et al.), say `32bit-inums`, which people can
>>>     pass if they want the 32-bit inode numbers back. This would still allow
>>>     people who want to make this tradeoff to use xino.
>>
>> inode32|inode64 (see man xfs(5)).
>
> Ah great, thanks! I'll reuse precedent from those.
>
>>> 4. (If you like) Also add a CONFIG option to disable this at compile time.
>>>
>>
>> I Don't know about disable, but the default mode for tmpfs (inode32|inode64)
>> might me best determined by CONFIG option, so distro builders could decide
>> if they want to take the risk of breaking applications on tmpfs.
>
> Sounds good.
>
>> But if you implement per sb ino pool, maybe inode64 will no longer be
>> required for your use case?
>
> In this case I think per-sb ino pool will help a bit, but unfortunately not by an order of magnitude. As with the recycling patch this will help reduce thrash a bit but not conclusively prevent the problem from happening long-term. To fix that, I think we really do need the option to use ino_t-sized get_next_ino_full (or per-sb equivalent).
>
> Happy holidays, and thanks for your feedback!
>
> Chris
>
> .
>

