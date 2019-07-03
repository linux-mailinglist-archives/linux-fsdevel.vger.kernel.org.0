Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1045E87F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2019 18:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfGCQNv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jul 2019 12:13:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56204 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbfGCQNu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jul 2019 12:13:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BBE813083394;
        Wed,  3 Jul 2019 16:13:24 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-160.bos.redhat.com [10.18.17.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 95F121725D;
        Wed,  3 Jul 2019 16:13:15 +0000 (UTC)
Subject: Re: [PATCH] mm, slab: Extend slab/shrink to shrink all the memcg
 caches
To:     Christopher Lameter <cl@linux.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
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
 <0100016bb89a0a6e-99d54043-4934-420f-9de0-1f71a8f943a3-000000@email.amazonses.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <1afc4772-27e5-b7f1-a15e-e912e15737e6@redhat.com>
Date:   Wed, 3 Jul 2019 12:13:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <0100016bb89a0a6e-99d54043-4934-420f-9de0-1f71a8f943a3-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 03 Jul 2019 16:13:50 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/3/19 12:10 PM, Christopher Lameter wrote:
> On Wed, 3 Jul 2019, Waiman Long wrote:
>
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
>> cache and the memcg caches. If we all agree that the only sensible
>> operation is to shrink root cache and the memcg caches together. I am
>> fine just adding memcg shrink without changing the sysfs interface
>> definition and be done with it.
> I think its best and consistent behavior to shrink all memcg caches
> with the root cache. This looks like an oversight and thus a bugfix.
>
Yes, that is what I am now planning to do for the next version of the patch.

Cheers,
Longman

