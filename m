Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDE5E58CE5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2019 23:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfF0VQT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jun 2019 17:16:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56766 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbfF0VQT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jun 2019 17:16:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 764DE3082A28;
        Thu, 27 Jun 2019 21:16:13 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7EC455C1B4;
        Thu, 27 Jun 2019 21:16:04 +0000 (UTC)
Subject: Re: [PATCH 2/2] mm, slab: Extend vm/drop_caches to shrink kmem slabs
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
References: <20190624174219.25513-1-longman@redhat.com>
 <20190624174219.25513-3-longman@redhat.com>
 <20190627151506.GE5303@dhcp22.suse.cz>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <5cb05d2c-39a7-f138-b0b9-4b03d6008999@redhat.com>
Date:   Thu, 27 Jun 2019 17:16:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190627151506.GE5303@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 27 Jun 2019 21:16:19 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/27/19 11:15 AM, Michal Hocko wrote:
> On Mon 24-06-19 13:42:19, Waiman Long wrote:
>> With the slub memory allocator, the numbers of active slab objects
>> reported in /proc/slabinfo are not real because they include objects
>> that are held by the per-cpu slab structures whether they are actually
>> used or not.  The problem gets worse the more CPUs a system have. For
>> instance, looking at the reported number of active task_struct objects,
>> one will wonder where all the missing tasks gone.
>>
>> I know it is hard and costly to get a real count of active objects.
> What exactly is expensive? Why cannot slabinfo reduce the number of
> active objects by per-cpu cached objects?
>
The number of cachelines that needs to be accessed in order to get an
accurate count will be much higher if we need to iterate through all the
per-cpu structures. In addition, accessing the per-cpu partial list will
be racy.


>> So
>> I am not advocating for that. Instead, this patch extends the
>> /proc/sys/vm/drop_caches sysctl parameter by using a new bit (bit 3)
>> to shrink all the kmem slabs which will flush out all the slabs in the
>> per-cpu structures and give a more accurate view of how much memory are
>> really used up by the active slab objects. This is a costly operation,
>> of course, but it gives a way to have a clearer picture of the actual
>> number of slab objects used, if the need arises.
> drop_caches is a terrible interface. It destroys all the caching and
> people are just too easy in using it to solve any kind of problem they
> think they might have and cause others they might not see immediately.
> I am strongly discouraging anybody - except for some tests which really
> do want to see reproducible results without cache effects - from using
> this interface and therefore I am not really happy to paper over
> something that might be a real problem with yet another mode. If SLUB
> indeed caches too aggressively on large machines then this should be
> fixed.
>
OK, as explained in another thread, the main reason for doing this patch
is to be able to do more accurate measurement of changes in kmem cache
memory consumption. Yes, I do agree that drop_caches is not a general
purpose interface that should be used lightly.

Cheers,
Longman

