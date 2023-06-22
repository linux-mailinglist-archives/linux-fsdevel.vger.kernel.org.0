Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6411373A46F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 17:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbjFVPMJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jun 2023 11:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjFVPMH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:12:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F69410F4;
        Thu, 22 Jun 2023 08:12:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 05F651FDD2;
        Thu, 22 Jun 2023 15:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687446723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DxyEqnSQyZKokKZ2LU3qC8/yrgR0FWi1mwbmN5xCk9E=;
        b=N9B19ELEkGrxV0suLxXhGZQpBLV2Yb7u7uZXemMcT2Ad1Ns9qHJoy72l2ulfj/9tDqlLBb
        GVFwd6rBAVc5H15+Kb7yFySUdw5/Q+tDegqObQNCQUjja9lcvWjOK2f2isXuCAjrFX5YBO
        5+wd+oOgRBQuiRPGEInEXCDzdjlKZqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687446723;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DxyEqnSQyZKokKZ2LU3qC8/yrgR0FWi1mwbmN5xCk9E=;
        b=n5V8ZHTPzF9VGJZMIFTWsPNIcgfy7jzHlKJbRGMIHWOaWYvwD7wX3oB3QALl4YmQglroUj
        lTp+6+OznWDE/zCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A96C013905;
        Thu, 22 Jun 2023 15:12:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tmWdKMJklGScKwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 22 Jun 2023 15:12:02 +0000
Message-ID: <cf0d9b12-6491-bf23-b464-9d01e5781203@suse.cz>
Date:   Thu, 22 Jun 2023 17:12:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 24/29] mm: vmscan: make global slab shrink lockless
Content-Language: en-US
To:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        david@fromorbit.com, tkhai@ya.ru, roman.gushchin@linux.dev,
        djwong@kernel.org, brauner@kernel.org, paulmck@kernel.org,
        tytso@mit.edu
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, dm-devel@redhat.com,
        linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20230622085335.77010-1-zhengqi.arch@bytedance.com>
 <20230622085335.77010-25-zhengqi.arch@bytedance.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230622085335.77010-25-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/22/23 10:53, Qi Zheng wrote:
> The shrinker_rwsem is a global read-write lock in
> shrinkers subsystem, which protects most operations
> such as slab shrink, registration and unregistration
> of shrinkers, etc. This can easily cause problems in
> the following cases.
> 
> 1) When the memory pressure is high and there are many
>    filesystems mounted or unmounted at the same time,
>    slab shrink will be affected (down_read_trylock()
>    failed).
> 
>    Such as the real workload mentioned by Kirill Tkhai:
> 
>    ```
>    One of the real workloads from my experience is start
>    of an overcommitted node containing many starting
>    containers after node crash (or many resuming containers
>    after reboot for kernel update). In these cases memory
>    pressure is huge, and the node goes round in long reclaim.
>    ```
> 
> 2) If a shrinker is blocked (such as the case mentioned
>    in [1]) and a writer comes in (such as mount a fs),
>    then this writer will be blocked and cause all
>    subsequent shrinker-related operations to be blocked.
> 
> Even if there is no competitor when shrinking slab, there
> may still be a problem. If we have a long shrinker list
> and we do not reclaim enough memory with each shrinker,
> then the down_read_trylock() may be called with high
> frequency. Because of the poor multicore scalability of
> atomic operations, this can lead to a significant drop
> in IPC (instructions per cycle).
> 
> We used to implement the lockless slab shrink with
> SRCU [1], but then kernel test robot reported -88.8%
> regression in stress-ng.ramfs.ops_per_sec test case [2],
> so we reverted it [3].
> 
> This commit uses the refcount+RCU method [4] proposed by
> by Dave Chinner to re-implement the lockless global slab
> shrink. The memcg slab shrink is handled in the subsequent
> patch.
> 
> Currently, the shrinker instances can be divided into
> the following three types:
> 
> a) global shrinker instance statically defined in the kernel,
> such as workingset_shadow_shrinker.
> 
> b) global shrinker instance statically defined in the kernel
> modules, such as mmu_shrinker in x86.
> 
> c) shrinker instance embedded in other structures.
> 
> For case a, the memory of shrinker instance is never freed.
> For case b, the memory of shrinker instance will be freed
> after the module is unloaded. But we will call synchronize_rcu()
> in free_module() to wait for RCU read-side critical section to
> exit. For case c, the memory of shrinker instance will be
> dynamically freed by calling kfree_rcu(). So we can use
> rcu_read_{lock,unlock}() to ensure that the shrinker instance
> is valid.
> 
> The shrinker::refcount mechanism ensures that the shrinker
> instance will not be run again after unregistration. So the
> structure that records the pointer of shrinker instance can be
> safely freed without waiting for the RCU read-side critical
> section.
> 
> In this way, while we implement the lockless slab shrink, we
> don't need to be blocked in unregister_shrinker() to wait
> RCU read-side critical section.
> 
> The following are the test results:
> 
> stress-ng --timeout 60 --times --verify --metrics-brief --ramfs 9 &
> 
> 1) Before applying this patchset:
> 
>  setting to a 60 second run per stressor
>  dispatching hogs: 9 ramfs
>  stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s
>                            (secs)    (secs)    (secs)   (real time) (usr+sys time)
>  ramfs            880623     60.02      7.71    226.93     14671.45        3753.09
>  ramfs:
>           1 System Management Interrupt
>  for a 60.03s run time:
>     5762.40s available CPU time
>        7.71s user time   (  0.13%)
>      226.93s system time (  3.94%)
>      234.64s total time  (  4.07%)
>  load average: 8.54 3.06 2.11
>  passed: 9: ramfs (9)
>  failed: 0
>  skipped: 0
>  successful run completed in 60.03s (1 min, 0.03 secs)
> 
> 2) After applying this patchset:
> 
>  setting to a 60 second run per stressor
>  dispatching hogs: 9 ramfs
>  stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s
>                            (secs)    (secs)    (secs)   (real time) (usr+sys time)
>  ramfs            847562     60.02      7.44    230.22     14120.66        3566.23
>  ramfs:
>           4 System Management Interrupts
>  for a 60.12s run time:
>     5771.95s available CPU time
>        7.44s user time   (  0.13%)
>      230.22s system time (  3.99%)
>      237.66s total time  (  4.12%)
>  load average: 8.18 2.43 0.84
>  passed: 9: ramfs (9)
>  failed: 0
>  skipped: 0
>  successful run completed in 60.12s (1 min, 0.12 secs)
> 
> We can see that the ops/s has hardly changed.
> 
> [1]. https://lore.kernel.org/lkml/20230313112819.38938-1-zhengqi.arch@bytedance.com/
> [2]. https://lore.kernel.org/lkml/202305230837.db2c233f-yujie.liu@intel.com/
> [3]. https://lore.kernel.org/all/20230609081518.3039120-1-qi.zheng@linux.dev/
> [4]. https://lore.kernel.org/lkml/ZIJhou1d55d4H1s0@dread.disaster.area/
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  include/linux/shrinker.h |  6 ++++++
>  mm/vmscan.c              | 33 ++++++++++++++-------------------
>  2 files changed, 20 insertions(+), 19 deletions(-)
> 
> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> index 7bfeb2f25246..b0c6c2df9db8 100644
> --- a/include/linux/shrinker.h
> +++ b/include/linux/shrinker.h
> @@ -74,6 +74,7 @@ struct shrinker {
>  
>  	refcount_t refcount;
>  	struct completion completion_wait;
> +	struct rcu_head rcu;
>  
>  	void *private_data;
>  
> @@ -123,6 +124,11 @@ struct shrinker *shrinker_alloc_and_init(count_objects_cb count,
>  void shrinker_free(struct shrinker *shrinker);
>  void unregister_and_free_shrinker(struct shrinker *shrinker);
>  
> +static inline bool shrinker_try_get(struct shrinker *shrinker)
> +{
> +	return refcount_inc_not_zero(&shrinker->refcount);
> +}
> +
>  static inline void shrinker_put(struct shrinker *shrinker)
>  {
>  	if (refcount_dec_and_test(&shrinker->refcount))
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 6f9c4750effa..767569698946 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -57,6 +57,7 @@
>  #include <linux/khugepaged.h>
>  #include <linux/rculist_nulls.h>
>  #include <linux/random.h>
> +#include <linux/rculist.h>
>  
>  #include <asm/tlbflush.h>
>  #include <asm/div64.h>
> @@ -742,7 +743,7 @@ void register_shrinker_prepared(struct shrinker *shrinker)
>  	down_write(&shrinker_rwsem);
>  	refcount_set(&shrinker->refcount, 1);
>  	init_completion(&shrinker->completion_wait);
> -	list_add_tail(&shrinker->list, &shrinker_list);
> +	list_add_tail_rcu(&shrinker->list, &shrinker_list);
>  	shrinker->flags |= SHRINKER_REGISTERED;
>  	shrinker_debugfs_add(shrinker);
>  	up_write(&shrinker_rwsem);
> @@ -800,7 +801,7 @@ void unregister_shrinker(struct shrinker *shrinker)
>  	wait_for_completion(&shrinker->completion_wait);
>  
>  	down_write(&shrinker_rwsem);
> -	list_del(&shrinker->list);
> +	list_del_rcu(&shrinker->list);
>  	shrinker->flags &= ~SHRINKER_REGISTERED;
>  	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
>  		unregister_memcg_shrinker(shrinker);
> @@ -845,7 +846,7 @@ EXPORT_SYMBOL(shrinker_free);
>  void unregister_and_free_shrinker(struct shrinker *shrinker)
>  {
>  	unregister_shrinker(shrinker);
> -	kfree(shrinker);
> +	kfree_rcu(shrinker, rcu);
>  }
>  EXPORT_SYMBOL(unregister_and_free_shrinker);
>  
> @@ -1067,33 +1068,27 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>  	if (!mem_cgroup_disabled() && !mem_cgroup_is_root(memcg))
>  		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
>  
> -	if (!down_read_trylock(&shrinker_rwsem))
> -		goto out;
> -
> -	list_for_each_entry(shrinker, &shrinker_list, list) {
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(shrinker, &shrinker_list, list) {
>  		struct shrink_control sc = {
>  			.gfp_mask = gfp_mask,
>  			.nid = nid,
>  			.memcg = memcg,
>  		};
>  
> +		if (!shrinker_try_get(shrinker))
> +			continue;
> +		rcu_read_unlock();

I don't think you can do this unlock?

> +
>  		ret = do_shrink_slab(&sc, shrinker, priority);
>  		if (ret == SHRINK_EMPTY)
>  			ret = 0;
>  		freed += ret;
> -		/*
> -		 * Bail out if someone want to register a new shrinker to
> -		 * prevent the registration from being stalled for long periods
> -		 * by parallel ongoing shrinking.
> -		 */
> -		if (rwsem_is_contended(&shrinker_rwsem)) {
> -			freed = freed ? : 1;
> -			break;
> -		}
> -	}
>  
> -	up_read(&shrinker_rwsem);
> -out:
> +		rcu_read_lock();

That new rcu_read_lock() won't help AFAIK, the whole
list_for_each_entry_rcu() needs to be under the single rcu_read_lock() to be
safe.

IIUC this is why Dave in [4] suggests unifying shrink_slab() with
shrink_slab_memcg(), as the latter doesn't iterate the list but uses IDR.

> +		shrinker_put(shrinker);
> +	}
> +	rcu_read_unlock();
>  	cond_resched();
>  	return freed;
>  }

