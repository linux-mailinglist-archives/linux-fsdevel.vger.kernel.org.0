Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32CC773685
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 04:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjHHCY3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 22:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjHHCY0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 22:24:26 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD1719B7
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Aug 2023 19:24:14 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b9c5e07c1bso46334825ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Aug 2023 19:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1691461454; x=1692066254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HUGk8Gm4qWKcvYyYW1oMdtOdnxgdWZtLrf0WmvG8aOg=;
        b=E8R/sNcxrOK1IUnWWdPxuHAURfzEKsQXFvPF/8WoYIocyBzrOF6C/15wk0bBTyq8fp
         w+9skh2POsCjChG96SdxCE1ukUJoo7U6iUCJoOHux3qHabiPQt2q8GYhzVnnqh4Ia8gf
         otMrpF/u+4+6GZvnjfH9iZQVLX7oYyO80eB3aSg/65gqSdDxQ6TBQ0eTbg/7hck8CRIR
         N2poqJrxPUv+xHM8+kwldwyyrpY8ClA2gjcNqxK3I6Rjaxj3f+CIGTw2aTNSrwyrBhAC
         fS1NWvmq7XKVFcVROA15iTu7BqzTlMOOgRsfusR61dD9uCRFfNfvH5SixHmdTB0ZZ2at
         NUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691461454; x=1692066254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUGk8Gm4qWKcvYyYW1oMdtOdnxgdWZtLrf0WmvG8aOg=;
        b=ESiOct7pbsY59CtpH/fQdN2Cfpb0zvnhKCquR1WaybrIpmazNRboc5znvUaMgltt7t
         mJXhe86KuTfEKa9XAGqxMlbj0pUxiTKzcEo0IoWbtyPfzIoOgWucKjV9cHFUEJzlMpOQ
         xLsFkwjc9BUezWJuwLka6eWMoVwYQdPtUq9S4+4iDIbscZmifXKjccqVTPwyQ9z20QlP
         W16nDMf9gLgUWwSFFRhi11eK55kGliKmVe/NWUqxXaJYiymV8S7wqfx9J0dzC+qP31yc
         cYTekLLyz/G0A05/3RJi5kW6YwikAAta7GVwn3XWrrgvugS3AenFCshLEysN8M+HUD0F
         JLAg==
X-Gm-Message-State: AOJu0YzeU9v6/NuDI4ZfKqlK92ZaZnryErK4UEgmHbsQVSo6DPiubdy9
        x+ccLhgVm29hNESYPo3xWqqRHQ==
X-Google-Smtp-Source: AGHT+IEzrDGpXyLCXRNBmZGxK80nBmbnZ3Zc29NdEkVzSJ3QNXEJvOFh13D52+77LsVxnWz7HKqTHA==
X-Received: by 2002:a17:902:8692:b0:1b9:d307:c1df with SMTP id g18-20020a170902869200b001b9d307c1dfmr10722096plo.17.1691461453690;
        Mon, 07 Aug 2023 19:24:13 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-166-213.pa.nsw.optusnet.com.au. [49.180.166.213])
        by smtp.gmail.com with ESMTPSA id h17-20020a170902f55100b001b864add154sm7583543plf.154.2023.08.07.19.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 19:24:13 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qTCOH-002Wjl-2u;
        Tue, 08 Aug 2023 12:24:09 +1000
Date:   Tue, 8 Aug 2023 12:24:09 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     akpm@linux-foundation.org, tkhai@ya.ru, vbabka@suse.cz,
        roman.gushchin@linux.dev, djwong@kernel.org, brauner@kernel.org,
        paulmck@kernel.org, tytso@mit.edu, steven.price@arm.com,
        cel@kernel.org, senozhatsky@chromium.org, yujie.liu@intel.com,
        gregkh@linuxfoundation.org, muchun.song@linux.dev,
        simon.horman@corigine.com, dlemoal@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        rcu@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 45/48] mm: shrinker: make global slab shrink lockless
Message-ID: <ZNGnSbiPN0lDLpSW@dread.disaster.area>
References: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
 <20230807110936.21819-46-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807110936.21819-46-zhengqi.arch@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 07, 2023 at 07:09:33PM +0800, Qi Zheng wrote:
> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> index eb342994675a..f06225f18531 100644
> --- a/include/linux/shrinker.h
> +++ b/include/linux/shrinker.h
> @@ -4,6 +4,8 @@
>  
>  #include <linux/atomic.h>
>  #include <linux/types.h>
> +#include <linux/refcount.h>
> +#include <linux/completion.h>
>  
>  #define SHRINKER_UNIT_BITS	BITS_PER_LONG
>  
> @@ -87,6 +89,10 @@ struct shrinker {
>  	int seeks;	/* seeks to recreate an obj */
>  	unsigned flags;
>  
> +	refcount_t refcount;
> +	struct completion done;
> +	struct rcu_head rcu;

Documentation, please. What does the refcount protect, what does the
completion provide, etc.

> +
>  	void *private_data;
>  
>  	/* These are for internal use */
> @@ -120,6 +126,17 @@ struct shrinker *shrinker_alloc(unsigned int flags, const char *fmt, ...);
>  void shrinker_register(struct shrinker *shrinker);
>  void shrinker_free(struct shrinker *shrinker);
>  
> +static inline bool shrinker_try_get(struct shrinker *shrinker)
> +{
> +	return refcount_inc_not_zero(&shrinker->refcount);
> +}
> +
> +static inline void shrinker_put(struct shrinker *shrinker)
> +{
> +	if (refcount_dec_and_test(&shrinker->refcount))
> +		complete(&shrinker->done);
> +}
> +
>  #ifdef CONFIG_SHRINKER_DEBUG
>  extern int __printf(2, 3) shrinker_debugfs_rename(struct shrinker *shrinker,
>  						  const char *fmt, ...);
> diff --git a/mm/shrinker.c b/mm/shrinker.c
> index 1911c06b8af5..d318f5621862 100644
> --- a/mm/shrinker.c
> +++ b/mm/shrinker.c
> @@ -2,6 +2,7 @@
>  #include <linux/memcontrol.h>
>  #include <linux/rwsem.h>
>  #include <linux/shrinker.h>
> +#include <linux/rculist.h>
>  #include <trace/events/vmscan.h>
>  
>  #include "internal.h"
> @@ -577,33 +578,42 @@ unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
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
> +
> +		/*
> +		 * We can safely unlock the RCU lock here since we already
> +		 * hold the refcount of the shrinker.
> +		 */
> +		rcu_read_unlock();
> +
>  		ret = do_shrink_slab(&sc, shrinker, priority);
>  		if (ret == SHRINK_EMPTY)
>  			ret = 0;
>  		freed += ret;
> +
>  		/*
> -		 * Bail out if someone want to register a new shrinker to
> -		 * prevent the registration from being stalled for long periods
> -		 * by parallel ongoing shrinking.
> +		 * This shrinker may be deleted from shrinker_list and freed
> +		 * after the shrinker_put() below, but this shrinker is still
> +		 * used for the next traversal. So it is necessary to hold the
> +		 * RCU lock first to prevent this shrinker from being freed,
> +		 * which also ensures that the next shrinker that is traversed
> +		 * will not be freed (even if it is deleted from shrinker_list
> +		 * at the same time).
>  		 */

This needs to be moved to the head of the function, and document
the whole list walk, get, put and completion parts of the algorithm
that make it safe. There's more to this than "we hold a reference
count", especially the tricky "we might see the shrinker before it
is fully initialised" case....


.....
>  void shrinker_free(struct shrinker *shrinker)
>  {
>  	struct dentry *debugfs_entry = NULL;
> @@ -686,9 +712,18 @@ void shrinker_free(struct shrinker *shrinker)
>  	if (!shrinker)
>  		return;
>  
> +	if (shrinker->flags & SHRINKER_REGISTERED) {
> +		shrinker_put(shrinker);
> +		wait_for_completion(&shrinker->done);
> +	}

Needs a comment explaining why we need to wait here...
> +
>  	down_write(&shrinker_rwsem);
>  	if (shrinker->flags & SHRINKER_REGISTERED) {
> -		list_del(&shrinker->list);
> +		/*
> +		 * Lookups on the shrinker are over and will fail in the future,
> +		 * so we can now remove it from the lists and free it.
> +		 */

.... rather than here after the wait has been done and provided the
guarantee that no shrinker is running or will run again...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
