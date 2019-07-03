Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87BDE5E894
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2019 18:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfGCQQW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jul 2019 12:16:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57451 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbfGCQQW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jul 2019 12:16:22 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A38FE307D853;
        Wed,  3 Jul 2019 16:16:16 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-160.bos.redhat.com [10.18.17.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1165519698;
        Wed,  3 Jul 2019 16:16:09 +0000 (UTC)
Subject: Re: [PATCH] mm, slab: Extend slab/shrink to shrink all the memcg
 caches
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
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
 <20190702130318.39d187dc27dbdd9267788165@linux-foundation.org>
 <78879b79-1b8f-cdfd-d4fa-610afe5e5d48@redhat.com>
 <20190702143340.715f771192721f60de1699d7@linux-foundation.org>
 <c29ff725-95ba-db4d-944f-d33f5f766cd3@redhat.com>
 <20190703155314.GT978@dhcp22.suse.cz>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <ca6147ca-25be-cba6-a7b9-fcac6d21345d@redhat.com>
Date:   Wed, 3 Jul 2019 12:16:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190703155314.GT978@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 03 Jul 2019 16:16:21 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/3/19 11:53 AM, Michal Hocko wrote:
> On Wed 03-07-19 11:21:16, Waiman Long wrote:
>> On 7/2/19 5:33 PM, Andrew Morton wrote:
>>> On Tue, 2 Jul 2019 16:44:24 -0400 Waiman Long <longman@redhat.com> wrote:
>>>
>>>> On 7/2/19 4:03 PM, Andrew Morton wrote:
>>>>> On Tue,  2 Jul 2019 14:37:30 -0400 Waiman Long <longman@redhat.com> wrote:
>>>>>
>>>>>> Currently, a value of '1" is written to /sys/kernel/slab/<slab>/shrink
>>>>>> file to shrink the slab by flushing all the per-cpu slabs and free
>>>>>> slabs in partial lists. This applies only to the root caches, though.
>>>>>>
>>>>>> Extends this capability by shrinking all the child memcg caches and
>>>>>> the root cache when a value of '2' is written to the shrink sysfs file.
>>>>> Why?
>>>>>
>>>>> Please fully describe the value of the proposed feature to or users. 
>>>>> Always.
>>>> Sure. Essentially, the sysfs shrink interface is not complete. It allows
>>>> the root cache to be shrunk, but not any of the memcg caches. 
>>> But that doesn't describe anything of value.  Who wants to use this,
>>> and why?  How will it be used?  What are the use-cases?
>>>
>> For me, the primary motivation of posting this patch is to have a way to
>> make the number of active objects reported in /proc/slabinfo more
>> accurately reflect the number of objects that are actually being used by
>> the kernel.
> I believe we have been through that. If the number is inexact due to
> caching then lets fix slabinfo rather than trick around it and teach
> people to do a magic write to some file that will "solve" a problem.
> This is exactly what drop_caches turned out to be in fact. People just
> got used to drop caches because they were told so by $random web page.
> So really, think about the underlying problem and try to fix it.
>
> It is true that you could argue that this patch is actually fixing the
> existing interface because it doesn't really do what it is documented to
> do and on those grounds I would agree with the change.

I do think that we should correct the shrink file to do what it is
designed to do to include the memcg caches as well.


>  But do not teach
> people that they have to write to some file to get proper numbers.
> Because that is just a bad idea and it will kick back the same way
> drop_caches.

The /proc/slabinfo file is a well-known file that is probably used
relatively extensively. Making it to scan through all the per-cpu
structures will probably cause performance issues as the slab_mutex has
to be taken during the whole duration of the scan. That could have
undesirable side effect.

Instead, I am thinking about extending the slab/objects sysfs file to
also show the number of objects hold up by the per-cpu structures and
thus we can get an accurate count by subtracting it from the reported
active objects. That will have a more limited performance impact as it
is just one kmem cache instead of all the kmem caches in the system.
Also the sysfs files are not as commonly used as slabinfo. That will be
another patch in the near future.

Cheers,
Longman

