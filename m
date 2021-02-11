Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B623195B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Feb 2021 23:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhBKWRt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Feb 2021 17:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhBKWRs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Feb 2021 17:17:48 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E2EC061574;
        Thu, 11 Feb 2021 14:17:08 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id z6so4611429pfq.0;
        Thu, 11 Feb 2021 14:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7PN+xYXlj8kgRJMJ+MQ+hUbkTJOWzNeBYDPvx/DNPXc=;
        b=uIHFK7L11lzphzThVk+l5AtSJBNPtuSElxYohoXVmVYPiwk7q0GXcj90UYsEhB94f2
         Ckf2i5GCVpn1v937R4iAzifVyD6bLi2eEZZIrKxaM7b/0KAZRssti7nWRtE3LULXgMIr
         GLuY72i7q9sJiseE8KGlblhLMTb9TjdzhGsU3D3bpCSVsc3Vp5kwXZPSoDmPrZBA8gUG
         pAkzWVkDgS2uXz9QHyHZkMBjyNQ1dpGbsgYXVCS0wfc7+eKOEpPolKjk46ALNGx5LzD/
         1wIWxHmaPW86jy8l2TjVHZAfgqAwF3stFJV2i+p8KEFjsTMo2cgexZDOiHcRfaJ1PCkH
         ZbrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=7PN+xYXlj8kgRJMJ+MQ+hUbkTJOWzNeBYDPvx/DNPXc=;
        b=EeZl3F+2HC4wkhQmafKy12I9Tdz1pDisU460Ip9S5YGACjIRbpW80fbWgTz2Nz4m0w
         RdDiaAjC/ng0yaQSWeEJR7SzpseiQfD5sVt08gRg518pZOYbPb/MWF9hzyEeTuMsNpVq
         wfF4J28xuJgtPmCzv/umO3GZYIwSoWHfjpNYCtNpuP3pOXe46mgkdO4dYfy/5ldt5Ixs
         Eo4uWyqN/yKkQTZXY3a+E0nExJhWt0D7GC5HaxatcA/6MseoNYwKjIuqbO9ipAa7mukd
         C3j5/mWyDdfbvil69nR7DYIX2qAfWvhHJVrlfEveE8lZxo9Ptr/+l5DRD2O2jU+tPGi+
         pqig==
X-Gm-Message-State: AOAM532E6JMBHTBQElgBweXXwFKf9v8OpZBy0IjQTM/meGivyD7sxk+6
        u6ZRO8BRMi5JhNiovgB1aywzyWOyWes=
X-Google-Smtp-Source: ABdhPJzuLRt1n1vVb4iLiq5BZOj8WzwMxglXa7GYOwN6rCdNwjJuNzJzAbBPB+U81a5WST4PNONbJA==
X-Received: by 2002:aa7:8d0d:0:b029:1d7:3c52:e1f6 with SMTP id j13-20020aa78d0d0000b02901d73c52e1f6mr145911pfe.39.1613081828162;
        Thu, 11 Feb 2021 14:17:08 -0800 (PST)
Received: from google.com ([2620:15c:211:201:2149:cbd5:4673:bc93])
        by smtp.gmail.com with ESMTPSA id t9sm5959026pji.34.2021.02.11.14.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 14:17:07 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 11 Feb 2021 14:17:05 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Chris Goldsworthy <cgoldswo@codeaurora.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2] [RFC] mm: fs: Invalidate BH LRU during page migration
Message-ID: <YCWs4ZJ9xk7h6reT@google.com>
References: <cover.1613020616.git.cgoldswo@codeaurora.org>
 <c083b0ab6e410e33ca880d639f90ef4f6f3b33ff.1613020616.git.cgoldswo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c083b0ab6e410e33ca880d639f90ef4f6f3b33ff.1613020616.git.cgoldswo@codeaurora.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 10, 2021 at 09:35:40PM -0800, Chris Goldsworthy wrote:
> Pages containing buffer_heads that are in one of the per-CPU
> buffer_head LRU caches will be pinned and thus cannot be migrated.
> This can prevent CMA allocations from succeeding, which are often used
> on platforms with co-processors (such as a DSP) that can only use
> physically contiguous memory. It can also prevent memory
> hot-unplugging from succeeding, which involves migrating at least
> MIN_MEMORY_BLOCK_SIZE bytes of memory, which ranges from 8 MiB to 1
> GiB based on the architecture in use.
> 
> Correspondingly, invalidate the BH LRU caches before a migration
> starts and stop any buffer_head from being cached in the LRU caches,
> until migration has finished.
> 
> Signed-off-by: Chris Goldsworthy <cgoldswo@codeaurora.org>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  fs/buffer.c                 | 54 +++++++++++++++++++++++++++++++++++++++++++--
>  include/linux/buffer_head.h |  8 +++++++
>  include/linux/migrate.h     |  2 ++
>  mm/migrate.c                | 19 ++++++++++++++++
>  mm/page_alloc.c             |  3 +++
>  mm/swap.c                   |  7 +++++-
>  6 files changed, 90 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 96c7604..634e474 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1274,6 +1274,10 @@ struct bh_lru {
>  
>  static DEFINE_PER_CPU(struct bh_lru, bh_lrus) = {{ NULL }};
>  
> +/* These are used to control the BH LRU invalidation during page migration */
> +static struct cpumask lru_needs_invalidation;
> +static bool bh_lru_disabled = false;
> +
>  #ifdef CONFIG_SMP
>  #define bh_lru_lock()	local_irq_disable()
>  #define bh_lru_unlock()	local_irq_enable()
> @@ -1292,7 +1296,9 @@ static inline void check_irqs_on(void)
>  /*
>   * Install a buffer_head into this cpu's LRU.  If not already in the LRU, it is
>   * inserted at the front, and the buffer_head at the back if any is evicted.
> - * Or, if already in the LRU it is moved to the front.
> + * Or, if already in the LRU it is moved to the front. Note that if LRU is
> + * disabled because of an ongoing page migration, we won't insert bh into the
> + * LRU.
>   */
>  static void bh_lru_install(struct buffer_head *bh)
>  {
> @@ -1303,6 +1309,9 @@ static void bh_lru_install(struct buffer_head *bh)
>  	check_irqs_on();
>  	bh_lru_lock();
>  
> +	if (bh_lru_disabled)
> +		goto out;
> +
>  	b = this_cpu_ptr(&bh_lrus);
>  	for (i = 0; i < BH_LRU_SIZE; i++) {
>  		swap(evictee, b->bhs[i]);
> @@ -1313,6 +1322,7 @@ static void bh_lru_install(struct buffer_head *bh)
>  	}
>  
>  	get_bh(bh);
> +out:
>  	bh_lru_unlock();
>  	brelse(evictee);
>  }
> @@ -1328,6 +1338,10 @@ lookup_bh_lru(struct block_device *bdev, sector_t block, unsigned size)
>  
>  	check_irqs_on();
>  	bh_lru_lock();
> +
> +	if (bh_lru_disabled)
> +		goto out;
> +
>  	for (i = 0; i < BH_LRU_SIZE; i++) {
>  		struct buffer_head *bh = __this_cpu_read(bh_lrus.bhs[i]);
>  
> @@ -1346,6 +1360,7 @@ lookup_bh_lru(struct block_device *bdev, sector_t block, unsigned size)
>  			break;
>  		}
>  	}
> +out:
>  	bh_lru_unlock();
>  	return ret;
>  }
> @@ -1446,7 +1461,7 @@ EXPORT_SYMBOL(__bread_gfp);
>   * This doesn't race because it runs in each cpu either in irq
>   * or with preempt disabled.
>   */
> -static void invalidate_bh_lru(void *arg)
> +void invalidate_bh_lru(void *arg)
>  {
>  	struct bh_lru *b = &get_cpu_var(bh_lrus);
>  	int i;
> @@ -1477,6 +1492,41 @@ void invalidate_bh_lrus(void)
>  }
>  EXPORT_SYMBOL_GPL(invalidate_bh_lrus);
>  
> +bool need_bh_lru_invalidation(int cpu)
> +{
> +	return cpumask_test_cpu(cpu, &lru_needs_invalidation);
> +}
> +
> +void bh_lru_disable(void)
> +{
> +	int cpu;
> +
> +	bh_lru_disabled = true;

What happens if the function is nested? Shouldn't we make it count?
So only disble when the count is zero.
