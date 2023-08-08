Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5E67736F7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 04:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjHHCog (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 22:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjHHCof (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 22:44:35 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C361FE2
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Aug 2023 19:44:15 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bc8045e09dso1996805ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Aug 2023 19:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1691462655; x=1692067455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZ3n364wJBBn5i6olC7X8xOphz5aoEwi3PPn9Humxy4=;
        b=c9iOPpy41VC6QSzv5vLbmCPsxZB2K7hAItf8MEtryT/BAlfvdA0UPM4PAg3DtN7rr+
         GFW2nm1AoLFEe5zmSSiqyIhn92P6iecybeuExkqa7jbnj+LEVM1LioV7SZGiR/8Kzy2+
         mJYrJW8XMi2+dbRvP7Xg6QuSzUnp/yHkq29M7vbAYNrF1NokfShgkpn7COiSBb38dkF0
         MWE0ZNG9ZS4LzaWgVeAy0Pmh7etHcKYaOYLW+oCVP3Q2zlcEbOnfLG0lI+GjqQwBJGqv
         OKDqkP3u3mDYRaZI2hDArPl64kIP09oRYh791qhymi4aMBqJthtqlGcAIAw7e+Im4Q2d
         AiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691462655; x=1692067455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZ3n364wJBBn5i6olC7X8xOphz5aoEwi3PPn9Humxy4=;
        b=eEgkUSalg3+wOckgUMYRS+YcsdgRRi4iK+2WQ9vS+KAsfqAvqi1stVi2rt/3xTQ7z+
         +dLAVEvFoVWhVqkfCr8vzFNJOSsMT0wlFxN1srUwwgQ6IETWEMgg3L09rf419fF97VCP
         4EvOkzULfQxSUaYeorQYyShWXDFZHZBcBvPl968S8M3bAPreBq7vNSEisf7jUOKfJ70c
         5BS4aW+uo9r6oaEciVLSMYE0vw1gNOBoJewXqfxUZTATbZMilidBfTkKo4eaZtDd7Db9
         VFMaYc0Fljfxlxg9uKg8Rr5ZiDabiFSWW0oFKOUoqb2ILfm6mTRlwwD89F5KuYlJq3IY
         GiPQ==
X-Gm-Message-State: AOJu0YxRaKiYDA5lyu9mzLMS5ecGEIjBcOk1x4V24Lh9WP4y8sMEylga
        N8q/ZB3thDGDW20NSZt2sAD5rQ==
X-Google-Smtp-Source: AGHT+IEZT2gUmOSYrkIbMjP5ySF6z1UEt5Q+o+GMN8zU98oO9pgzqqi+i8QK+swPthTlPTk4WQ36Qw==
X-Received: by 2002:a17:902:7287:b0:1b3:f5c7:4e75 with SMTP id d7-20020a170902728700b001b3f5c74e75mr9699662pll.58.1691462654669;
        Mon, 07 Aug 2023 19:44:14 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-166-213.pa.nsw.optusnet.com.au. [49.180.166.213])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902e80200b001b893b689a0sm7632067plg.84.2023.08.07.19.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 19:44:14 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qTChf-002XBg-27;
        Tue, 08 Aug 2023 12:44:11 +1000
Date:   Tue, 8 Aug 2023 12:44:11 +1000
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
Subject: Re: [PATCH v4 46/48] mm: shrinker: make memcg slab shrink lockless
Message-ID: <ZNGr+1orhHaBORJG@dread.disaster.area>
References: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
 <20230807110936.21819-47-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807110936.21819-47-zhengqi.arch@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 07, 2023 at 07:09:34PM +0800, Qi Zheng wrote:
> Like global slab shrink, this commit also uses refcount+RCU method to make
> memcg slab shrink lockless.

This patch does random code cleanups amongst the actual RCU changes.
Can you please move the cleanups to a spearate patch to reduce the
noise in this one?

> diff --git a/mm/shrinker.c b/mm/shrinker.c
> index d318f5621862..fee6f62904fb 100644
> --- a/mm/shrinker.c
> +++ b/mm/shrinker.c
> @@ -107,6 +107,12 @@ static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
>  					 lockdep_is_held(&shrinker_rwsem));
>  }
>  
> +static struct shrinker_info *shrinker_info_rcu(struct mem_cgroup *memcg,
> +					       int nid)
> +{
> +	return rcu_dereference(memcg->nodeinfo[nid]->shrinker_info);
> +}

This helper doesn't add value. It doesn't tell me that
rcu_read_lock() needs to be held when it is called, for one....

>  static int expand_one_shrinker_info(struct mem_cgroup *memcg, int new_size,
>  				    int old_size, int new_nr_max)
>  {
> @@ -198,7 +204,7 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
>  		struct shrinker_info_unit *unit;
>  
>  		rcu_read_lock();
> -		info = rcu_dereference(memcg->nodeinfo[nid]->shrinker_info);
> +		info = shrinker_info_rcu(memcg, nid);

... whilst the original code here was obviously correct.

>  		unit = info->unit[shriner_id_to_index(shrinker_id)];
>  		if (!WARN_ON_ONCE(shrinker_id >= info->map_nr_max)) {
>  			/* Pairs with smp mb in shrink_slab() */
> @@ -211,7 +217,7 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
>  
>  static DEFINE_IDR(shrinker_idr);
>  
> -static int prealloc_memcg_shrinker(struct shrinker *shrinker)
> +static int shrinker_memcg_alloc(struct shrinker *shrinker)

Cleanups in a separate patch.

> @@ -253,10 +258,15 @@ static long xchg_nr_deferred_memcg(int nid, struct shrinker *shrinker,
>  {
>  	struct shrinker_info *info;
>  	struct shrinker_info_unit *unit;
> +	long nr_deferred;
>  
> -	info = shrinker_info_protected(memcg, nid);
> +	rcu_read_lock();
> +	info = shrinker_info_rcu(memcg, nid);
>  	unit = info->unit[shriner_id_to_index(shrinker->id)];
> -	return atomic_long_xchg(&unit->nr_deferred[shriner_id_to_offset(shrinker->id)], 0);
> +	nr_deferred = atomic_long_xchg(&unit->nr_deferred[shriner_id_to_offset(shrinker->id)], 0);
> +	rcu_read_unlock();
> +
> +	return nr_deferred;
>  }

This adds two rcu_read_lock() sections to every call to
do_shrink_slab(). It's not at all clear ifrom any of the other code
that do_shrink_slab() now has internal rcu_read_lock() sections....

> @@ -464,18 +480,23 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>  	if (!mem_cgroup_online(memcg))
>  		return 0;
>  
> -	if (!down_read_trylock(&shrinker_rwsem))
> -		return 0;
> -
> -	info = shrinker_info_protected(memcg, nid);
> +again:
> +	rcu_read_lock();
> +	info = shrinker_info_rcu(memcg, nid);
>  	if (unlikely(!info))
>  		goto unlock;
>  
> -	for (; index < shriner_id_to_index(info->map_nr_max); index++) {
> +	if (index < shriner_id_to_index(info->map_nr_max)) {
>  		struct shrinker_info_unit *unit;
>  
>  		unit = info->unit[index];
>  
> +		/*
> +		 * The shrinker_info_unit will not be freed, so we can
> +		 * safely release the RCU lock here.
> +		 */
> +		rcu_read_unlock();

Why - what guarantees that the shrinker_info_unit exists at this
point? We hold no reference to it, we hold no reference to any
shrinker, etc. What provides this existence guarantee?

> +
>  		for_each_set_bit(offset, unit->map, SHRINKER_UNIT_BITS) {
>  			struct shrink_control sc = {
>  				.gfp_mask = gfp_mask,
> @@ -485,12 +506,14 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>  			struct shrinker *shrinker;
>  			int shrinker_id = calc_shrinker_id(index, offset);
>  
> +			rcu_read_lock();
>  			shrinker = idr_find(&shrinker_idr, shrinker_id);
> -			if (unlikely(!shrinker || !(shrinker->flags & SHRINKER_REGISTERED))) {
> -				if (!shrinker)
> -					clear_bit(offset, unit->map);
> +			if (unlikely(!shrinker || !shrinker_try_get(shrinker))) {
> +				clear_bit(offset, unit->map);
> +				rcu_read_unlock();
>  				continue;
>  			}
> +			rcu_read_unlock();
>  
>  			/* Call non-slab shrinkers even though kmem is disabled */
>  			if (!memcg_kmem_online() &&
> @@ -523,15 +546,20 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>  					set_shrinker_bit(memcg, nid, shrinker_id);
>  			}
>  			freed += ret;
> -
> -			if (rwsem_is_contended(&shrinker_rwsem)) {
> -				freed = freed ? : 1;
> -				goto unlock;
> -			}
> +			shrinker_put(shrinker);

Ok, so why is this safe to call without holding the rcu read lock?
The global shrinker has to hold the rcu_read_lock() whilst calling
shrinker_put() to guarantee the validity of the list next pointer,
but we don't hold off RCU here so what guarantees a racing global
shrinker walk doesn't trip over this shrinker_put() call dropping
the refcount to zero and freeing occuring in a different context...


> +		/*
> +		 * We have already exited the read-side of rcu critical section
> +		 * before calling do_shrink_slab(), the shrinker_info may be
> +		 * released in expand_one_shrinker_info(), so reacquire the
> +		 * shrinker_info.
> +		 */
> +		index++;
> +		goto again;

With that, what makes the use of shrinker_info in
xchg_nr_deferred_memcg() in do_shrink_slab() coherent and valid?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
