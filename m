Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAF5E71A63
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2019 16:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732301AbfGWOaM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jul 2019 10:30:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53898 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731652AbfGWOaM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jul 2019 10:30:12 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3914781F18;
        Tue, 23 Jul 2019 14:30:11 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-160.bos.redhat.com [10.18.17.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1EBAC600D1;
        Tue, 23 Jul 2019 14:30:08 +0000 (UTC)
Subject: Re: [PATCH] mm, slab: Extend slab/shrink to shrink all the memcg
 caches
To:     peter enderborg <peter.enderborg@sony.com>,
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
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <f878a00c-5d84-534b-deac-5736534a61cd@redhat.com>
Date:   Tue, 23 Jul 2019 10:30:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <71ab6307-9484-fdd3-fe6d-d261acf7c4a5@sony.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 23 Jul 2019 14:30:12 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/22/19 8:46 AM, peter enderborg wrote:
> On 7/2/19 8:37 PM, Waiman Long wrote:
>> Currently, a value of '1" is written to /sys/kernel/slab/<slab>/shrink
>> file to shrink the slab by flushing all the per-cpu slabs and free
>> slabs in partial lists. This applies only to the root caches, though.
>>
>> Extends this capability by shrinking all the child memcg caches and
>> the root cache when a value of '2' is written to the shrink sysfs file.
>>
>> On a 4-socket 112-core 224-thread x86-64 system after a parallel kernel
>> build, the the amount of memory occupied by slabs before shrinking
>> slabs were:
>>
>>  # grep task_struct /proc/slabinfo
>>  task_struct         7114   7296   7744    4    8 : tunables    0    0
>>  0 : slabdata   1824   1824      0
>>  # grep "^S[lRU]" /proc/meminfo
>>  Slab:            1310444 kB
>>  SReclaimable:     377604 kB
>>  SUnreclaim:       932840 kB
>>
>> After shrinking slabs:
>>
>>  # grep "^S[lRU]" /proc/meminfo
>>  Slab:             695652 kB
>>  SReclaimable:     322796 kB
>>  SUnreclaim:       372856 kB
>>  # grep task_struct /proc/slabinfo
>>  task_struct         2262   2572   7744    4    8 : tunables    0    0
>>  0 : slabdata    643    643      0
>
> What is the time between this measurement points? Should not the shrinked memory show up as reclaimable?

In this case, I echoed '2' to all the shrink sysfs files under
/sys/kernel/slab. The purpose of shrinking caches is to reclaim as much
unused memory slabs from all the caches, irrespective if they are
reclaimable or not. We do not reclaim any used objects. That is why we
see the numbers were reduced in both cases.

Cheers,
Longman
