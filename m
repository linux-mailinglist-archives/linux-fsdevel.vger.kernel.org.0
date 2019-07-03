Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA36F5E790
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2019 17:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfGCPOs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jul 2019 11:14:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46504 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbfGCPOs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jul 2019 11:14:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A41D981F12;
        Wed,  3 Jul 2019 15:14:37 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-160.bos.redhat.com [10.18.17.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CE7F3608C1;
        Wed,  3 Jul 2019 15:14:28 +0000 (UTC)
Subject: Re: [PATCH] mm, slab: Extend slab/shrink to shrink all the memcg
 caches
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <20190702183730.14461-1-longman@redhat.com>
 <20190703065628.GK978@dhcp22.suse.cz>
 <9ade5859-b937-c1ac-9881-2289d734441d@redhat.com>
 <20190703143701.GR978@dhcp22.suse.cz>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <bf569ee8-1999-97c1-d49f-ef58eef5f62c@redhat.com>
Date:   Wed, 3 Jul 2019 11:14:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190703143701.GR978@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 03 Jul 2019 15:14:48 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/3/19 10:37 AM, Michal Hocko wrote:
> On Wed 03-07-19 09:12:13, Waiman Long wrote:
>> On 7/3/19 2:56 AM, Michal Hocko wrote:
>>> On Tue 02-07-19 14:37:30, Waiman Long wrote:
>>>> Currently, a value of '1" is written to /sys/kernel/slab/<slab>/shrink
>>>> file to shrink the slab by flushing all the per-cpu slabs and free
>>>> slabs in partial lists. This applies only to the root caches, though.
>>>>
>>>> Extends this capability by shrinking all the child memcg caches and
>>>> the root cache when a value of '2' is written to the shrink sysfs file.
>>> Why do we need a new value for this functionality? I would tend to think
>>> that skipping memcg caches is a bug/incomplete implementation. Or is it
>>> a deliberate decision to cover root caches only?
>> It is just that I don't want to change the existing behavior of the
>> current code. It will definitely take longer to shrink both the root
>> cache and the memcg caches.
> Does that matter? To whom and why? I do not expect this interface to be
> used heavily.
The only concern that I can see is the fact that I need to take the
slab_mutex when iterating the memcg list to prevent concurrent
modification. That may have some impact on other applications running in
the system. However, I can put a precaution statement on the user-doc to
discuss the potential performance impact.
>> If we all agree that the only sensible
>> operation is to shrink root cache and the memcg caches together. I am
>> fine just adding memcg shrink without changing the sysfs interface
>> definition and be done with it.
> The existing documentation is really modest on the actual semantic:
> Description:
>                 The shrink file is written when memory should be reclaimed from
>                 a cache.  Empty partial slabs are freed and the partial list is
>                 sorted so the slabs with the fewest available objects are used
>                 first.
>
> which to me sounds like all slabs are free and nobody should be really
> thinking of memcgs. This is simply drop_caches kinda thing. We surely do
> not want to drop caches only for the root memcg for /proc/sys/vm/drop_caches
> right?
>
I am planning to reword the document to make the effect of using this
sysfs file more explicit.

Cheers,
Longman

