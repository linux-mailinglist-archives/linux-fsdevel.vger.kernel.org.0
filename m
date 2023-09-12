Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318F179C831
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 09:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbjILHa5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 03:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjILHa4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:30:56 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAD8B9;
        Tue, 12 Sep 2023 00:30:52 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4ff8f2630e3so8985464e87.1;
        Tue, 12 Sep 2023 00:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694503851; x=1695108651; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9TtWYBN3Js8MaUa6ket6IpV+Bas2UrWYZ7r9GmcPHzk=;
        b=hfrgKc2d/H+2ZgjCxefyl2sIKXbzgm82nTyZkli6YkCg4OgM6QxNfia8EQXQ63ds7s
         RJTAyUCJ7VdaDV7ff6djKs7rhs7S5ruCz8hIjFW7gZHq9FLSC/D3oCWYXcre4HbFbXD2
         ZhuQFKIWjVjHffh1Ne4359y9XmtB6OFBitFp8ihcDyncPueAci/4w72vkHF3SUi0fAtR
         XtEdpmJIGKWDZuHSNewV1SZyIIMqFmqLCZUJ3WCC+XDwdVHfpQ10oYEkUm+8VgPE481l
         GxAO8/O2/utRE+Q5zVwe8lauG15FDyeGrfCbNw9/aB7P30BeAFzRSlBnxKpyzjQ6iZQV
         SpNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694503851; x=1695108651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9TtWYBN3Js8MaUa6ket6IpV+Bas2UrWYZ7r9GmcPHzk=;
        b=wXrPmXOwUMGtpwdS7WEj95yQlPRtJC+jv9gINOIqe+HhInojcJQhX+dy80lG7B81tg
         gX7aAoyLhg/nf1Vu2l4kxslrFA1iqgfo1R42wDcyeqeqJO6Ayfo5syaIxVvSHg9+ncns
         q2a9acx8aIwV8MDMw3j3JOmNA4r8o9z5O9LhjnghnalyOQ6KKQAJpQmwk5zXKVHuAu9F
         /OQNYQjvyeRZWofXDtcVvOV6NRcn+634B49n9T2aSKaVy4frdAAyNlqvY1VXIccmQ8V/
         uUKu1LAwT3XvN45gQWVDp67sDRHGE9try4YQQX6aqKgxHAqXe8CIOprDBNYUVPwmc63C
         oaNQ==
X-Gm-Message-State: AOJu0YxDtR37cBofQ05yjSJ4Zl++RkYn5g5CjW6RJ6jXaKfYgTbs1csG
        rFkgfwKnwULrChww6A6W5VI=
X-Google-Smtp-Source: AGHT+IFRU1BCT1/fxyolNXviRB2kjmrF3gbcVkz2ZdPqlwGiM/W8fLNYBMB1va+dE1XIWrPYf8LuHQ==
X-Received: by 2002:a05:6512:15a3:b0:4fb:7cea:882a with SMTP id bp35-20020a05651215a300b004fb7cea882amr11611840lfb.3.1694503850597;
        Tue, 12 Sep 2023 00:30:50 -0700 (PDT)
Received: from pc636 ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id d25-20020ac244d9000000b004ff947bea2asm1653864lfm.54.2023.09.12.00.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 00:30:50 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 12 Sep 2023 09:30:47 +0200
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Muchun Song <songmuchun@bytedance.com>, rcu@vger.kernel.org
Subject: Re: [PATCH v6 16/45] rcu: dynamically allocate the rcu-kfree shrinker
Message-ID: <ZQATp6yFd/GXY9hN@pc636>
References: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
 <20230911094444.68966-17-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911094444.68966-17-zhengqi.arch@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 11, 2023 at 05:44:15PM +0800, Qi Zheng wrote:
> Use new APIs to dynamically allocate the rcu-kfree shrinker.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> CC: rcu@vger.kernel.org
> ---
>  kernel/rcu/tree.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index cb1caefa8bd0..06e2ed495c02 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3449,13 +3449,6 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>  	return freed == 0 ? SHRINK_STOP : freed;
>  }
>  
> -static struct shrinker kfree_rcu_shrinker = {
> -	.count_objects = kfree_rcu_shrink_count,
> -	.scan_objects = kfree_rcu_shrink_scan,
> -	.batch = 0,
> -	.seeks = DEFAULT_SEEKS,
> -};
> -
>  void __init kfree_rcu_scheduler_running(void)
>  {
>  	int cpu;
> @@ -4931,6 +4924,7 @@ static void __init kfree_rcu_batch_init(void)
>  {
>  	int cpu;
>  	int i, j;
> +	struct shrinker *kfree_rcu_shrinker;
>  
>  	/* Clamp it to [0:100] seconds interval. */
>  	if (rcu_delay_page_cache_fill_msec < 0 ||
> @@ -4962,8 +4956,17 @@ static void __init kfree_rcu_batch_init(void)
>  		INIT_DELAYED_WORK(&krcp->page_cache_work, fill_page_cache_func);
>  		krcp->initialized = true;
>  	}
> -	if (register_shrinker(&kfree_rcu_shrinker, "rcu-kfree"))
> -		pr_err("Failed to register kfree_rcu() shrinker!\n");
> +
> +	kfree_rcu_shrinker = shrinker_alloc(0, "rcu-kfree");
> +	if (!kfree_rcu_shrinker) {
> +		pr_err("Failed to allocate kfree_rcu() shrinker!\n");
> +		return;
> +	}
> +
> +	kfree_rcu_shrinker->count_objects = kfree_rcu_shrink_count;
> +	kfree_rcu_shrinker->scan_objects = kfree_rcu_shrink_scan;
> +
> +	shrinker_register(kfree_rcu_shrinker);
>  }
>  
>  void __init rcu_init(void)
> -- 
> 2.30.2
> 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Makes sense to me. Thank you for improving it.

--
Uladzislau Rezki
