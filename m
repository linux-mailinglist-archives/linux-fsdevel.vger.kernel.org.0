Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2034764F86
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 11:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbjG0JXq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 05:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234643AbjG0JXW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:23:22 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6593AA9
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 02:13:22 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6748a616e17so195958b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 02:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690449201; x=1691054001;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ab3i02uMNDVjAVrJgavtDQnv7B+TbSMr9u4LPtdCXIk=;
        b=DcofMrRnwJynNkdGxtjH9DqKXau2yqZGatjPtAtzn+O56nMmwXuVd7ToeAQUojKhyr
         PVIHt52Ove4HfRkW5Jz6nWPZD9BmVLc7SbBBPIeMe8wFyfKaQIk+EbU0k3nRPfOKNwBh
         oCNv2ZD1HFVJTkxvMKWyxXL9Onk9dGrGolbp1H25aJz81J4GYNUwPghcXVGUuE5zAHUa
         mP22aBPwBQ4pP/D5mY0ghxG8TnuQLNORwYORdeX0ZvQJ20+Z3LaIninEXnknTqruUQCo
         Za3jxS8cFIItCGBaY6f3hGkZx+gttPFDrR9vIxhOGVxid7Al6RP9znkmq9WOz9AcYgeV
         IdKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690449201; x=1691054001;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ab3i02uMNDVjAVrJgavtDQnv7B+TbSMr9u4LPtdCXIk=;
        b=WtWzre3uuExY0WaNMcDmQJ7TjikJHNpiPsdoqSjtYcrf8woKZi0b0O7p6dLPjA6+mb
         I+ToPt3o6vpuultYw2Sz7oydNm3aSL6OxAf8Bfx+OxA9Ucs4/jM56om0Eu9+i18k0Ifc
         rDTFp4LDP4P0TnUGMUb1qSgQfgMhHAd7ZwDKzWENxBbzpKpvzvitAlBZXlmiDxsnz/a0
         HltPDxx151LBY8fpwX51kvQV6lvcjMHTw+RZRO2z1G7VQI9u/tKfiBbnG9om7fBDeIdz
         p7qeuq0GEUwtvaG3RFp/71LG0izDGh0vl3oQZ8+kUG2z89oeWM8ilxv8KnxZZNRPRRym
         LVkg==
X-Gm-Message-State: ABy/qLbxTvKJ0hhiN0lqMIsR0OyEmpPVmztR9bHnVnXOAPvXEYSgKptR
        EOhO1pXeCxVKbQj7pOo4jxeW5Q==
X-Google-Smtp-Source: APBJJlGBn5Xl2QFHzxgRMihSAaLd28csKz8Em946xGdOgBfe3ljiGqu5+YaMyvDFvdIkqmZPd3zpbQ==
X-Received: by 2002:a05:6a00:4792:b0:668:834d:4bd with SMTP id dh18-20020a056a00479200b00668834d04bdmr4787709pfb.0.1690449201600;
        Thu, 27 Jul 2023 02:13:21 -0700 (PDT)
Received: from [10.70.252.135] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id m26-20020a056a00165a00b006687b41c4dasm1017146pfc.110.2023.07.27.02.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 02:13:21 -0700 (PDT)
Message-ID: <961f6055-a395-8490-4c22-765a30668460@bytedance.com>
Date:   Thu, 27 Jul 2023 17:13:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 27/49] dm: dynamically allocate the dm-bufio shrinker
Content-Language: en-US
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
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
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
References: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
 <20230727080502.77895-28-zhengqi.arch@bytedance.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20230727080502.77895-28-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/7/27 16:04, Qi Zheng wrote:
> In preparation for implementing lockless slab shrink, use new APIs to
> dynamically allocate the dm-bufio shrinker, so that it can be freed
> asynchronously using kfree_rcu(). Then it doesn't need to wait for RCU
> read-side critical section when releasing the struct dm_bufio_client.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> ---
>   drivers/md/dm-bufio.c | 26 +++++++++++++++-----------
>   1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
> index bc309e41d074..5a9124b83d53 100644
> --- a/drivers/md/dm-bufio.c
> +++ b/drivers/md/dm-bufio.c
> @@ -963,7 +963,7 @@ struct dm_bufio_client {
>   
>   	sector_t start;
>   
> -	struct shrinker shrinker;
> +	struct shrinker *shrinker;
>   	struct work_struct shrink_work;
>   	atomic_long_t need_shrink;
>   
> @@ -2368,7 +2368,7 @@ static unsigned long dm_bufio_shrink_scan(struct shrinker *shrink, struct shrink
>   {
>   	struct dm_bufio_client *c;
>   
> -	c = container_of(shrink, struct dm_bufio_client, shrinker);
> +	c = shrink->private_data;
>   	atomic_long_add(sc->nr_to_scan, &c->need_shrink);
>   	queue_work(dm_bufio_wq, &c->shrink_work);
>   
> @@ -2377,7 +2377,7 @@ static unsigned long dm_bufio_shrink_scan(struct shrinker *shrink, struct shrink
>   
>   static unsigned long dm_bufio_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
>   {
> -	struct dm_bufio_client *c = container_of(shrink, struct dm_bufio_client, shrinker);
> +	struct dm_bufio_client *c = shrink->private_data;
>   	unsigned long count = cache_total(&c->cache);
>   	unsigned long retain_target = get_retain_buffers(c);
>   	unsigned long queued_for_cleanup = atomic_long_read(&c->need_shrink);
> @@ -2490,15 +2490,19 @@ struct dm_bufio_client *dm_bufio_client_create(struct block_device *bdev, unsign
>   	INIT_WORK(&c->shrink_work, shrink_work);
>   	atomic_long_set(&c->need_shrink, 0);
>   
> -	c->shrinker.count_objects = dm_bufio_shrink_count;
> -	c->shrinker.scan_objects = dm_bufio_shrink_scan;
> -	c->shrinker.seeks = 1;
> -	c->shrinker.batch = 0;
> -	r = register_shrinker(&c->shrinker, "dm-bufio:(%u:%u)",
> -			      MAJOR(bdev->bd_dev), MINOR(bdev->bd_dev));
> -	if (r)
> +	c->shrinker = shrinker_alloc(0, "dm-bufio:(%u:%u)",
> +				     MAJOR(bdev->bd_dev), MINOR(bdev->bd_dev));
> +	if (!c->shrinker)

Here should set r to -ENOMEM, will fix.

>   		goto bad;
>   
> +	c->shrinker->count_objects = dm_bufio_shrink_count;
> +	c->shrinker->scan_objects = dm_bufio_shrink_scan;
> +	c->shrinker->seeks = 1;
> +	c->shrinker->batch = 0;
> +	c->shrinker->private_data = c;
> +
> +	shrinker_register(c->shrinker);
> +
>   	mutex_lock(&dm_bufio_clients_lock);
>   	dm_bufio_client_count++;
>   	list_add(&c->client_list, &dm_bufio_all_clients);
> @@ -2537,7 +2541,7 @@ void dm_bufio_client_destroy(struct dm_bufio_client *c)
>   
>   	drop_buffers(c);
>   
> -	unregister_shrinker(&c->shrinker);
> +	shrinker_free(c->shrinker);
>   	flush_work(&c->shrink_work);
>   
>   	mutex_lock(&dm_bufio_clients_lock);
