Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E67B55D6B3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2019 21:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfGBTPz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jul 2019 15:15:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59030 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbfGBTPz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jul 2019 15:15:55 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 25FA9C057F2E;
        Tue,  2 Jul 2019 19:15:50 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-160.bos.redhat.com [10.18.17.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA0471347B;
        Tue,  2 Jul 2019 19:15:42 +0000 (UTC)
Subject: Re: [PATCH] mm, slab: Extend slab/shrink to shrink all the memcg
 caches
To:     David Rientjes <rientjes@google.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <20190702183730.14461-1-longman@redhat.com>
 <alpine.DEB.2.21.1907021206000.67286@chino.kir.corp.google.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <34af4938-f472-9d9b-e615-397217023004@redhat.com>
Date:   Tue, 2 Jul 2019 15:15:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1907021206000.67286@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 02 Jul 2019 19:15:55 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/2/19 3:09 PM, David Rientjes wrote:
> On Tue, 2 Jul 2019, Waiman Long wrote:
>
>> diff --git a/Documentation/ABI/testing/sysfs-kernel-slab b/Documentation/ABI/testing/sysfs-kernel-slab
>> index 29601d93a1c2..2a3d0fc4b4ac 100644
>> --- a/Documentation/ABI/testing/sysfs-kernel-slab
>> +++ b/Documentation/ABI/testing/sysfs-kernel-slab
>> @@ -429,10 +429,12 @@ KernelVersion:	2.6.22
>>  Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
>>  		Christoph Lameter <cl@linux-foundation.org>
>>  Description:
>> -		The shrink file is written when memory should be reclaimed from
>> -		a cache.  Empty partial slabs are freed and the partial list is
>> -		sorted so the slabs with the fewest available objects are used
>> -		first.
>> +		A value of '1' is written to the shrink file when memory should
>> +		be reclaimed from a cache.  Empty partial slabs are freed and
>> +		the partial list is sorted so the slabs with the fewest
>> +		available objects are used first.  When a value of '2' is
>> +		written, all the corresponding child memory cgroup caches
>> +		should be shrunk as well.  All other values are invalid.
>>  
> This should likely call out that '2' also does '1', that might not be 
> clear enough.

You are right. I will reword the text to make it clearer.


>>  What:		/sys/kernel/slab/cache/slab_size
>>  Date:		May 2007
>> diff --git a/mm/slab.h b/mm/slab.h
>> index 3b22931bb557..a16b2c7ff4dd 100644
>> --- a/mm/slab.h
>> +++ b/mm/slab.h
>> @@ -174,6 +174,7 @@ int __kmem_cache_shrink(struct kmem_cache *);
>>  void __kmemcg_cache_deactivate(struct kmem_cache *s);
>>  void __kmemcg_cache_deactivate_after_rcu(struct kmem_cache *s);
>>  void slab_kmem_cache_release(struct kmem_cache *);
>> +int kmem_cache_shrink_all(struct kmem_cache *s);
>>  
>>  struct seq_file;
>>  struct file;
>> diff --git a/mm/slab_common.c b/mm/slab_common.c
>> index 464faaa9fd81..493697ba1da5 100644
>> --- a/mm/slab_common.c
>> +++ b/mm/slab_common.c
>> @@ -981,6 +981,49 @@ int kmem_cache_shrink(struct kmem_cache *cachep)
>>  }
>>  EXPORT_SYMBOL(kmem_cache_shrink);
>>  
>> +/**
>> + * kmem_cache_shrink_all - shrink a cache and all its memcg children
>> + * @s: The root cache to shrink.
>> + *
>> + * Return: 0 if successful, -EINVAL if not a root cache
>> + */
>> +int kmem_cache_shrink_all(struct kmem_cache *s)
>> +{
>> +	struct kmem_cache *c;
>> +
>> +	if (!IS_ENABLED(CONFIG_MEMCG_KMEM)) {
>> +		kmem_cache_shrink(s);
>> +		return 0;
>> +	}
>> +	if (!is_root_cache(s))
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * The caller should have a reference to the root cache and so
>> +	 * we don't need to take the slab_mutex. We have to take the
>> +	 * slab_mutex, however, to iterate the memcg caches.
>> +	 */
>> +	get_online_cpus();
>> +	get_online_mems();
>> +	kasan_cache_shrink(s);
>> +	__kmem_cache_shrink(s);
>> +
>> +	mutex_lock(&slab_mutex);
>> +	for_each_memcg_cache(c, s) {
>> +		/*
>> +		 * Don't need to shrink deactivated memcg caches.
>> +		 */
>> +		if (s->flags & SLAB_DEACTIVATED)
>> +			continue;
>> +		kasan_cache_shrink(c);
>> +		__kmem_cache_shrink(c);
>> +	}
>> +	mutex_unlock(&slab_mutex);
>> +	put_online_mems();
>> +	put_online_cpus();
>> +	return 0;
>> +}
>> +
>>  bool slab_is_available(void)
>>  {
>>  	return slab_state >= UP;
> I'm wondering how long this could take, i.e. how long we hold slab_mutex 
> while we traverse each cache and shrink it.

It will depends on how many memcg caches are there. Actually, I have
been thinking about using the show method to show the time spent in the
last shrink operation. I am just not sure if it is worth doing. What do
you think?

-Longman

