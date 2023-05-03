Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243D86F595E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 15:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjECNxz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 09:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjECNxy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 09:53:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CA459F7
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 May 2023 06:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683121985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IXVN9njL58i0gdsYraIjStXx8q1dlH84VTerQaHWg8E=;
        b=SUc55hwUdaHwyMfFUF9FMEBIrie/MHL+7CY8GnefM+OGO7r6GXd7uRVjgRmyT0fK5t+Mpj
        kAMnyrBKsGsQaSEikyUacnYX+cFljycSbQaODTFNalC/FNRjG2SzkjEZIX9bHqhqn8EOn+
        9UekJQc+bzUH4EDvYpxediMsmdPklmc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-569-b2ch48CAOYKYY3aTTnc_8Q-1; Wed, 03 May 2023 09:53:00 -0400
X-MC-Unique: b2ch48CAOYKYY3aTTnc_8Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F60E103B7EA;
        Wed,  3 May 2023 13:53:00 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8049F1410DD7;
        Wed,  3 May 2023 13:52:59 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 8011C426F3D60; Wed,  3 May 2023 10:52:36 -0300 (-03)
Date:   Wed, 3 May 2023 10:52:36 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Frederic Weisbecker <frederic@kernel.org>,
        Leonardo Bras <leobras@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>, P J P <ppandit@redhat.com>
Subject: Re: [PATCH v4] fs/buffer.c: update per-CPU bh_lru cache via RCU
Message-ID: <ZFJnJFxzfshWJQEz@tpad>
References: <ZCXipBvmhAC1+eRi@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZCXipBvmhAC1+eRi@tpad>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Friendly ping ?

On Thu, Mar 30, 2023 at 04:27:32PM -0300, Marcelo Tosatti wrote:
> 
> For certain types of applications (for example PLC software or
> RAN processing), upon occurrence of an event, it is necessary to
> complete a certain task in a maximum amount of time (deadline).
> 
> One way to express this requirement is with a pair of numbers, 
> deadline time and execution time, where:
> 
> 	* deadline time: length of time between event and deadline.
> 	* execution time: length of time it takes for processing of event
> 			  to occur on a particular hardware platform
> 			  (uninterrupted).
> 
> The particular values depend on use-case. For the case
> where the realtime application executes in a virtualized
> guest, an IPI which must be serviced in the host will cause 
> the following sequence of events:
> 
> 	1) VM-exit
> 	2) execution of IPI (and function call)
> 	3) VM-entry
> 
> Which causes an excess of 50us latency as observed by cyclictest
> (this violates the latency requirement of vRAN application with 1ms TTI,
> for example).
> 
> invalidate_bh_lrus calls an IPI on each CPU that has non empty
> per-CPU cache:
> 
> 	on_each_cpu_cond(has_bh_in_lru, invalidate_bh_lru, NULL, 1);
> 
> To avoid the IPI, free the per-CPU caches remotely via RCU.
> Two bh_lrus structures for each CPU are allocated: one is being
> used (assigned to per-CPU bh_lru pointer), and the other is
> being freed (or idle).
> 
> An alternative solution would be to protect the fast path 
> (__find_get_block) with a per-CPU spinlock. Then grab the 
> lock from invalidate_bh_lru, when evaluating whether a given
> CPUs buffer_head cache should be invalidated.
> This solution would slow down the fast path.
> 
> Numbers (16 vCPU guest) for the following test:
> 
> for i in `seq 0 50`;
> 	mount -o loop alpine-standard-3.17.1-x86_64.iso /mnt/loop
> 	umount /mnt/loop
> done
> 
> Where the time being measured is time between invalidate_bh_lrus 
> function call start and return.
> 
> Unpatched: average is 2us
> 	     ┌                                        ┐
> [ 0.0,  2.0) ┤████████████████████████▊ 53
> [ 2.0,  4.0) ┤████████████████████████████████████  77
> [ 4.0,  6.0) ┤████████▍ 18
> [ 6.0,  8.0) ┤▌ 1
> [ 8.0, 10.0) ┤  0
> [10.0, 12.0) ┤  0
> [12.0, 14.0) ┤▌ 1
> [14.0, 16.0) ┤  0
> [16.0, 18.0) ┤▌ 1
> 	     └                                        ┘
> 			   Frequency
> 
> Patched: average is 16us
> 
> 	     ┌                                        ┐
> [ 0.0, 10.0) ┤██████████████████▍ 35
> [10.0, 20.0) ┤████████████████████████████████████  69
> [20.0, 30.0) ┤██████████████████▍ 35
> [30.0, 40.0) ┤████▎ 8
> [40.0, 50.0) ┤█▌ 3
> [50.0, 60.0) ┤█▏ 2
> 	     └                                        ┘
> 			   Frequency
> 
> The fact that invalidate_bh_lru() is now serialized should not be 
> an issue, since invalidate_bdev does:
> 
> /* Invalidate clean unused buffers and pagecache. */
> void invalidate_bdev(struct block_device *bdev)
> {
> 	struct address_space *mapping = bdev->bd_inode->i_mapping;
> 
> 	if (mapping->nrpages) {
> 		invalidate_bh_lrus();
> 		lru_add_drain_all();    /* make sure all lru add caches are flushed */
> 		invalidate_mapping_pages(mapping, 0, -1);
> 	}
> }
> 
> Where lru_add_drain_all() is serialized by a single mutex lock
> (and there have been no reported use cases where this
> serialization is an issue).
> 
> Regarding scalability, considering the results above where 
> it takes 16us to execute invalidate_bh_lrus on 16 CPUs
> (where 8us are taken by synchronize_rcu_expedited),
> we can assume 500ns per CPU. For a system with 
> 1024 CPUs, we can infer 8us + 1024*500ns ~= 500us
> (which seems acceptable).
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> ---
> 
> v4: improved changelog, no code change	(Dave Chinner)
> v3: fix CPU hotplug
> v2: fix sparse warnings (kernel test robot)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 9e1e2add541e..e9b4d579eff0 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1246,7 +1246,21 @@ struct bh_lru {
>  	struct buffer_head *bhs[BH_LRU_SIZE];
>  };
>  
> -static DEFINE_PER_CPU(struct bh_lru, bh_lrus) = {{ NULL }};
> +
> +/*
> + * Allocate two bh_lrus structures for each CPU. bh_lru points to the
> + * one that is currently in use, and the update path does
> + * (consider cpu->bh_lru = bh_lrus[0]).
> + *
> + * cpu->bh_lrup = bh_lrus[1]
> + * synchronize_rcu()
> + * free bh's in bh_lrus[0]
> + */
> +static unsigned int bh_lru_idx;
> +static DEFINE_PER_CPU(struct bh_lru, bh_lrus[2]) = {{{ NULL }}, {{NULL}}};
> +static DEFINE_PER_CPU(struct bh_lru __rcu *, bh_lrup);
> +
> +static DEFINE_MUTEX(bh_lru_invalidate_mutex);
>  
>  #ifdef CONFIG_SMP
>  #define bh_lru_lock()	local_irq_disable()
> @@ -1288,16 +1302,19 @@ static void bh_lru_install(struct buffer_head *bh)
>  		return;
>  	}
>  
> -	b = this_cpu_ptr(&bh_lrus);
> +	rcu_read_lock();
> +	b = rcu_dereference(per_cpu(bh_lrup, smp_processor_id()));
>  	for (i = 0; i < BH_LRU_SIZE; i++) {
>  		swap(evictee, b->bhs[i]);
>  		if (evictee == bh) {
> +			rcu_read_unlock();
>  			bh_lru_unlock();
>  			return;
>  		}
>  	}
>  
>  	get_bh(bh);
> +	rcu_read_unlock();
>  	bh_lru_unlock();
>  	brelse(evictee);
>  }
> @@ -1309,28 +1326,32 @@ static struct buffer_head *
>  lookup_bh_lru(struct block_device *bdev, sector_t block, unsigned size)
>  {
>  	struct buffer_head *ret = NULL;
> +	struct bh_lru *lru;
>  	unsigned int i;
>  
>  	check_irqs_on();
>  	bh_lru_lock();
> +	rcu_read_lock();
> +
> +	lru = rcu_dereference(per_cpu(bh_lrup, smp_processor_id()));
>  	for (i = 0; i < BH_LRU_SIZE; i++) {
> -		struct buffer_head *bh = __this_cpu_read(bh_lrus.bhs[i]);
> +		struct buffer_head *bh = lru->bhs[i];
>  
>  		if (bh && bh->b_blocknr == block && bh->b_bdev == bdev &&
>  		    bh->b_size == size) {
>  			if (i) {
>  				while (i) {
> -					__this_cpu_write(bh_lrus.bhs[i],
> -						__this_cpu_read(bh_lrus.bhs[i - 1]));
> +					lru->bhs[i] = lru->bhs[i - 1];
>  					i--;
>  				}
> -				__this_cpu_write(bh_lrus.bhs[0], bh);
> +				lru->bhs[0] = bh;
>  			}
>  			get_bh(bh);
>  			ret = bh;
>  			break;
>  		}
>  	}
> +	rcu_read_unlock();
>  	bh_lru_unlock();
>  	return ret;
>  }
> @@ -1424,35 +1445,54 @@ static void __invalidate_bh_lrus(struct bh_lru *b)
>  		b->bhs[i] = NULL;
>  	}
>  }
> -/*
> - * invalidate_bh_lrus() is called rarely - but not only at unmount.
> - * This doesn't race because it runs in each cpu either in irq
> - * or with preempt disabled.
> - */
> -static void invalidate_bh_lru(void *arg)
> -{
> -	struct bh_lru *b = &get_cpu_var(bh_lrus);
> -
> -	__invalidate_bh_lrus(b);
> -	put_cpu_var(bh_lrus);
> -}
>  
>  bool has_bh_in_lru(int cpu, void *dummy)
>  {
> -	struct bh_lru *b = per_cpu_ptr(&bh_lrus, cpu);
> +	struct bh_lru *b;
>  	int i;
> -	
> +
> +	rcu_read_lock();
> +	b = rcu_dereference(per_cpu(bh_lrup, cpu));
>  	for (i = 0; i < BH_LRU_SIZE; i++) {
> -		if (b->bhs[i])
> +		if (b->bhs[i]) {
> +			rcu_read_unlock();
>  			return true;
> +		}
>  	}
>  
> +	rcu_read_unlock();
>  	return false;
>  }
>  
> +/*
> + * invalidate_bh_lrus() is called rarely - but not only at unmount.
> + */
>  void invalidate_bh_lrus(void)
>  {
> -	on_each_cpu_cond(has_bh_in_lru, invalidate_bh_lru, NULL, 1);
> +	int cpu, oidx;
> +
> +	mutex_lock(&bh_lru_invalidate_mutex);
> +	cpus_read_lock();
> +	oidx = bh_lru_idx;
> +	bh_lru_idx++;
> +	if (bh_lru_idx >= 2)
> +		bh_lru_idx = 0;
> +
> +	/* Assign the per-CPU bh_lru pointer */
> +	for_each_online_cpu(cpu)
> +		rcu_assign_pointer(per_cpu(bh_lrup, cpu),
> +				   per_cpu_ptr(&bh_lrus[bh_lru_idx], cpu));
> +	synchronize_rcu_expedited();
> +
> +	for_each_online_cpu(cpu) {
> +		struct bh_lru *b = per_cpu_ptr(&bh_lrus[oidx], cpu);
> +
> +		bh_lru_lock();
> +		__invalidate_bh_lrus(b);
> +		bh_lru_unlock();
> +	}
> +	cpus_read_unlock();
> +	mutex_unlock(&bh_lru_invalidate_mutex);
>  }
>  EXPORT_SYMBOL_GPL(invalidate_bh_lrus);
>  
> @@ -1465,8 +1505,10 @@ void invalidate_bh_lrus_cpu(void)
>  	struct bh_lru *b;
>  
>  	bh_lru_lock();
> -	b = this_cpu_ptr(&bh_lrus);
> +	rcu_read_lock();
> +	b = rcu_dereference(per_cpu(bh_lrup, smp_processor_id()));
>  	__invalidate_bh_lrus(b);
> +	rcu_read_unlock();
>  	bh_lru_unlock();
>  }
>  
> @@ -2968,15 +3010,25 @@ void free_buffer_head(struct buffer_head *bh)
>  }
>  EXPORT_SYMBOL(free_buffer_head);
>  
> +static int buffer_cpu_online(unsigned int cpu)
> +{
> +	rcu_assign_pointer(per_cpu(bh_lrup, cpu),
> +			   per_cpu_ptr(&bh_lrus[bh_lru_idx], cpu));
> +	return 0;
> +}
> +
>  static int buffer_exit_cpu_dead(unsigned int cpu)
>  {
>  	int i;
> -	struct bh_lru *b = &per_cpu(bh_lrus, cpu);
> +	struct bh_lru *b;
>  
> +	rcu_read_lock();
> +	b = rcu_dereference(per_cpu(bh_lrup, cpu));
>  	for (i = 0; i < BH_LRU_SIZE; i++) {
>  		brelse(b->bhs[i]);
>  		b->bhs[i] = NULL;
>  	}
> +	rcu_read_unlock();
>  	this_cpu_add(bh_accounting.nr, per_cpu(bh_accounting, cpu).nr);
>  	per_cpu(bh_accounting, cpu).nr = 0;
>  	return 0;
> @@ -3069,7 +3121,7 @@ EXPORT_SYMBOL(__bh_read_batch);
>  void __init buffer_init(void)
>  {
>  	unsigned long nrpages;
> -	int ret;
> +	int ret, cpu;
>  
>  	bh_cachep = kmem_cache_create("buffer_head",
>  			sizeof(struct buffer_head), 0,
> @@ -3077,6 +3129,11 @@ void __init buffer_init(void)
>  				SLAB_MEM_SPREAD),
>  				NULL);
>  
> +	cpus_read_lock();
> +	for_each_online_cpu(cpu)
> +		rcu_assign_pointer(per_cpu(bh_lrup, cpu), per_cpu_ptr(&bh_lrus[0], cpu));
> +	cpus_read_unlock();
> +
>  	/*
>  	 * Limit the bh occupancy to 10% of ZONE_NORMAL
>  	 */
> @@ -3085,4 +3142,7 @@ void __init buffer_init(void)
>  	ret = cpuhp_setup_state_nocalls(CPUHP_FS_BUFF_DEAD, "fs/buffer:dead",
>  					NULL, buffer_exit_cpu_dead);
>  	WARN_ON(ret < 0);
> +	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "fs/buffer:online",
> +					NULL, buffer_cpu_online);
> +	WARN_ON(ret < 0);
>  }
> 
> 

