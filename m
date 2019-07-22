Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFB47004C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2019 14:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbfGVM45 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jul 2019 08:56:57 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:9059 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727164AbfGVM45 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jul 2019 08:56:57 -0400
X-Greylist: delayed 603 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Jul 2019 08:56:55 EDT
Subject: Re: [PATCH] mm, slab: Extend slab/shrink to shrink all the memcg
 caches
To:     Waiman Long <longman@redhat.com>, Christoph Lameter <cl@linux.com>,
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
CC:     <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <20190702183730.14461-1-longman@redhat.com>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <71ab6307-9484-fdd3-fe6d-d261acf7c4a5@sony.com>
Date:   Mon, 22 Jul 2019 14:46:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190702183730.14461-1-longman@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-SEG-SpamProfiler-Analysis: v=2.3 cv=L6RjvNb8 c=1 sm=1 tr=0 a=T5MYTZSj1jWyQccoVcawfw==:117 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=0o9FgrsRnhwA:10 a=20KFwNOVAAAA:8 a=Z4Rwk6OoAAAA:8 a=hTz6g4Jj1mwQyzJQMEoA:9 a=QEXdDO2ut3YA:10 a=aA9c7OsbRBYA:10 a=HkZW87K1Qel5hWWM3VKY:22
X-SEG-SpamProfiler-Score: 0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/2/19 8:37 PM, Waiman Long wrote:
> Currently, a value of '1" is written to /sys/kernel/slab/<slab>/shrink
> file to shrink the slab by flushing all the per-cpu slabs and free
> slabs in partial lists. This applies only to the root caches, though.
>
> Extends this capability by shrinking all the child memcg caches and
> the root cache when a value of '2' is written to the shrink sysfs file.
>
> On a 4-socket 112-core 224-thread x86-64 system after a parallel kernel
> build, the the amount of memory occupied by slabs before shrinking
> slabs were:
>
>  # grep task_struct /proc/slabinfo
>  task_struct         7114   7296   7744    4    8 : tunables    0    0
>  0 : slabdata   1824   1824      0
>  # grep "^S[lRU]" /proc/meminfo
>  Slab:            1310444 kB
>  SReclaimable:     377604 kB
>  SUnreclaim:       932840 kB
>
> After shrinking slabs:
>
>  # grep "^S[lRU]" /proc/meminfo
>  Slab:             695652 kB
>  SReclaimable:     322796 kB
>  SUnreclaim:       372856 kB
>  # grep task_struct /proc/slabinfo
>  task_struct         2262   2572   7744    4    8 : tunables    0    0
>  0 : slabdata    643    643      0


What is the time between this measurement points? Should not the shrinked memory show up as reclaimable?


> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  Documentation/ABI/testing/sysfs-kernel-slab | 10 +++--
>  mm/slab.h                                   |  1 +
>  mm/slab_common.c                            | 43 +++++++++++++++++++++
>  mm/slub.c                                   |  2 +
>  4 files changed, 52 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-kernel-slab b/Documentation/ABI/testing/sysfs-kernel-slab
> index 29601d93a1c2..2a3d0fc4b4ac 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-slab
> +++ b/Documentation/ABI/testing/sysfs-kernel-slab
> @@ -429,10 +429,12 @@ KernelVersion:	2.6.22
>  Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
>  		Christoph Lameter <cl@linux-foundation.org>
>  Description:
> -		The shrink file is written when memory should be reclaimed from
> -		a cache.  Empty partial slabs are freed and the partial list is
> -		sorted so the slabs with the fewest available objects are used
> -		first.
> +		A value of '1' is written to the shrink file when memory should
> +		be reclaimed from a cache.  Empty partial slabs are freed and
> +		the partial list is sorted so the slabs with the fewest
> +		available objects are used first.  When a value of '2' is
> +		written, all the corresponding child memory cgroup caches
> +		should be shrunk as well.  All other values are invalid.
>  
>  What:		/sys/kernel/slab/cache/slab_size
>  Date:		May 2007
> diff --git a/mm/slab.h b/mm/slab.h
> index 3b22931bb557..a16b2c7ff4dd 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -174,6 +174,7 @@ int __kmem_cache_shrink(struct kmem_cache *);
>  void __kmemcg_cache_deactivate(struct kmem_cache *s);
>  void __kmemcg_cache_deactivate_after_rcu(struct kmem_cache *s);
>  void slab_kmem_cache_release(struct kmem_cache *);
> +int kmem_cache_shrink_all(struct kmem_cache *s);
>  
>  struct seq_file;
>  struct file;
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 464faaa9fd81..493697ba1da5 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -981,6 +981,49 @@ int kmem_cache_shrink(struct kmem_cache *cachep)
>  }
>  EXPORT_SYMBOL(kmem_cache_shrink);
>  
> +/**
> + * kmem_cache_shrink_all - shrink a cache and all its memcg children
> + * @s: The root cache to shrink.
> + *
> + * Return: 0 if successful, -EINVAL if not a root cache
> + */
> +int kmem_cache_shrink_all(struct kmem_cache *s)
> +{
> +	struct kmem_cache *c;
> +
> +	if (!IS_ENABLED(CONFIG_MEMCG_KMEM)) {
> +		kmem_cache_shrink(s);
> +		return 0;
> +	}
> +	if (!is_root_cache(s))
> +		return -EINVAL;
> +
> +	/*
> +	 * The caller should have a reference to the root cache and so
> +	 * we don't need to take the slab_mutex. We have to take the
> +	 * slab_mutex, however, to iterate the memcg caches.
> +	 */
> +	get_online_cpus();
> +	get_online_mems();
> +	kasan_cache_shrink(s);
> +	__kmem_cache_shrink(s);
> +
> +	mutex_lock(&slab_mutex);
> +	for_each_memcg_cache(c, s) {
> +		/*
> +		 * Don't need to shrink deactivated memcg caches.
> +		 */
> +		if (s->flags & SLAB_DEACTIVATED)
> +			continue;
> +		kasan_cache_shrink(c);
> +		__kmem_cache_shrink(c);
> +	}
> +	mutex_unlock(&slab_mutex);
> +	put_online_mems();
> +	put_online_cpus();
> +	return 0;
> +}
> +
>  bool slab_is_available(void)
>  {
>  	return slab_state >= UP;
> diff --git a/mm/slub.c b/mm/slub.c
> index a384228ff6d3..5d7b0004c51f 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5298,6 +5298,8 @@ static ssize_t shrink_store(struct kmem_cache *s,
>  {
>  	if (buf[0] == '1')
>  		kmem_cache_shrink(s);
> +	else if (buf[0] == '2')
> +		kmem_cache_shrink_all(s);
>  	else
>  		return -EINVAL;
>  	return length;


