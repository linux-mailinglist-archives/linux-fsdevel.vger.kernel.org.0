Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27A9685120
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2019 18:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388777AbfHGQdl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Aug 2019 12:33:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:48604 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388026AbfHGQdk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Aug 2019 12:33:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F06F7AF93;
        Wed,  7 Aug 2019 16:33:38 +0000 (UTC)
Subject: Re: [PATCH] mm, slab: Extend slab/shrink to shrink all the memcg
 caches
To:     Waiman Long <longman@redhat.com>,
        peter enderborg <peter.enderborg@sony.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <20190702183730.14461-1-longman@redhat.com>
 <71ab6307-9484-fdd3-fe6d-d261acf7c4a5@sony.com>
 <f878a00c-5d84-534b-deac-5736534a61cd@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <85f9074a-064c-acbc-2a22-968026f0a8c3@suse.cz>
Date:   Wed, 7 Aug 2019 18:33:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f878a00c-5d84-534b-deac-5736534a61cd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/23/19 4:30 PM, Waiman Long wrote:
> On 7/22/19 8:46 AM, peter enderborg wrote:
>> On 7/2/19 8:37 PM, Waiman Long wrote:
>>> Currently, a value of '1" is written to /sys/kernel/slab/<slab>/shrink
>>> file to shrink the slab by flushing all the per-cpu slabs and free
>>> slabs in partial lists. This applies only to the root caches, though.
>>>
>>> Extends this capability by shrinking all the child memcg caches and
>>> the root cache when a value of '2' is written to the shrink sysfs file.
>>>
>>> On a 4-socket 112-core 224-thread x86-64 system after a parallel kernel
>>> build, the the amount of memory occupied by slabs before shrinking
>>> slabs were:
>>>
>>>  # grep task_struct /proc/slabinfo
>>>  task_struct         7114   7296   7744    4    8 : tunables    0    0
>>>  0 : slabdata   1824   1824      0
>>>  # grep "^S[lRU]" /proc/meminfo
>>>  Slab:            1310444 kB
>>>  SReclaimable:     377604 kB
>>>  SUnreclaim:       932840 kB
>>>
>>> After shrinking slabs:
>>>
>>>  # grep "^S[lRU]" /proc/meminfo
>>>  Slab:             695652 kB
>>>  SReclaimable:     322796 kB
>>>  SUnreclaim:       372856 kB
>>>  # grep task_struct /proc/slabinfo
>>>  task_struct         2262   2572   7744    4    8 : tunables    0    0
>>>  0 : slabdata    643    643      0
>>
>> What is the time between this measurement points? Should not the shrinked memory show up as reclaimable?
> 
> In this case, I echoed '2' to all the shrink sysfs files under
> /sys/kernel/slab. The purpose of shrinking caches is to reclaim as much
> unused memory slabs from all the caches, irrespective if they are
> reclaimable or not.

Well, SReclaimable counts pages allocated by kmem caches with
SLAB_RECLAIM_ACCOUNT flags, which should match those that have a shrinker
associated and can thus actually reclaim objects. That shrinking slabs affected
SReclaimable just a bit while reducing SUnreclaim by more than 50% looks
certainly odd.
For example the task_struct cache is not a reclaimable one, yet shows massive
reduction. Could be that the reclaimable objects were pinning non-reclaimable
ones, so the shrinking had secondary effects in non-reclaimable caches.

> We do not reclaim any used objects. That is why we
> see the numbers were reduced in both cases.
> 
> Cheers,
> Longman
> 

