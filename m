Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836BD6497BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Dec 2022 02:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbiLLBqv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Dec 2022 20:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbiLLBqs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Dec 2022 20:46:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68C7D102
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Dec 2022 17:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670809550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hZR9z6VBNznO4iAg8I+edvN08p/s9GeIUmTOh/2RVqg=;
        b=PwV3fJJemWNlnduYozwn3A8r593mtYbAM9eMNbvmS//hcKZyQoilkXOj1+AtKTW5WRRcUn
        TbuwdkrM94zSRmuzEn0sMEFCh46npnfztefGii01EbBBfrJxDn85U83ehbBX2aDJ3AoKjZ
        TV5PVFCUCFm4AQIsamPPB7u/aZLt7rQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-638-mjfA3An2OGKV8qwinkFlTg-1; Sun, 11 Dec 2022 20:45:49 -0500
X-MC-Unique: mjfA3An2OGKV8qwinkFlTg-1
Received: by mail-pj1-f72.google.com with SMTP id om16-20020a17090b3a9000b002216006cbffso432488pjb.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Dec 2022 17:45:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hZR9z6VBNznO4iAg8I+edvN08p/s9GeIUmTOh/2RVqg=;
        b=j0W24K7bnPQgZi0XseUF5sV7t0WLW3Y1VY0yJFABuzfPxDoUtRgygerpkXd0EHDZBB
         M0Q1vPGDOdUwP+ANSc3cdRA12sbl+NYL9wisipqksFhGYtu+PQwKyRFD8BivSJmh1ZFq
         1nEeAOB6mbS3m8NDSRrgpW+jrBpcS5kXFkGfcjGfMqVHsNJJ1GCPnS5YlPFDeUTc/Ma8
         wNP6CcvGR524hY/TsSntT1C+ZaVfbSpv1w5v1ZR5iApnrK/g18uKwsractRkRv2F2esW
         Untq2k347lHmP35wS1ZJwKxLc9TF5lt9av2HnLSoOrBmJoGVor/F2J4xzHvn4n7KCHxe
         rXAg==
X-Gm-Message-State: ANoB5pngd+ZQNYHajVrc1ytHK5tqxLBkYADuyJ8bHhHRWVdqDYe2cfsd
        El176fYTAj19wePgLtwuwnvSTV9KBcDABbWG5HINJ7DnLwudlXkS7diLM6rcNfwF2MsR3r7ZOL0
        bMBGImTAIDRJ8sRFh2mFs3Pvq+g==
X-Received: by 2002:a17:90b:4f47:b0:20d:bd60:c30f with SMTP id pj7-20020a17090b4f4700b0020dbd60c30fmr14546071pjb.12.1670809548164;
        Sun, 11 Dec 2022 17:45:48 -0800 (PST)
X-Google-Smtp-Source: AA0mqf69qw7rDQjgSoktCuOZ5HSA8jydQE9FOHmvd4604m+oC/JUHA9qmWlUHQlS6SclkYD+4niwkA==
X-Received: by 2002:a17:90b:4f47:b0:20d:bd60:c30f with SMTP id pj7-20020a17090b4f4700b0020dbd60c30fmr14546049pjb.12.1670809547832;
        Sun, 11 Dec 2022 17:45:47 -0800 (PST)
Received: from ?IPV6:2403:580e:4b40:0:7968:2232:4db8:a45e? (2403-580e-4b40--7968-2232-4db8-a45e.ip6.aussiebb.net. [2403:580e:4b40:0:7968:2232:4db8:a45e])
        by smtp.gmail.com with ESMTPSA id 73-20020a63064c000000b0047915d582ccsm4033891pgg.20.2022.12.11.17.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Dec 2022 17:45:47 -0800 (PST)
Message-ID: <39fb293c-cb9d-0a57-e2d7-2b2776247c94@redhat.com>
Date:   Mon, 12 Dec 2022 09:45:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 2/5] pid: split cyclic id allocation cursor from idr
Content-Language: en-US
To:     Brian Foster <bfoster@redhat.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     onestero@redhat.com, willy@infradead.org, ebiederm@redhat.com
References: <20221202171620.509140-1-bfoster@redhat.com>
 <20221202171620.509140-3-bfoster@redhat.com>
From:   Ian Kent <ikent@redhat.com>
In-Reply-To: <20221202171620.509140-3-bfoster@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/12/22 01:16, Brian Foster wrote:
> As a next step in separating pid allocation from the idr, split off
> the cyclic pid allocation cursor from the idr. Lift the cursor value
> into the struct pid_namespace. Note that this involves temporarily
> open-coding the cursor increment on allocation, but this is cleaned
> up in the subsequent patch.
>
> Signed-off-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Brian Foster <bfoster@redhat.com>


Reviewed-by: Ian Kent <raven@themaw.net>

> ---
>   arch/powerpc/platforms/cell/spufs/sched.c | 2 +-
>   fs/proc/loadavg.c                         | 2 +-
>   include/linux/pid_namespace.h             | 1 +
>   kernel/pid.c                              | 6 ++++--
>   kernel/pid_namespace.c                    | 4 ++--
>   5 files changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/platforms/cell/spufs/sched.c b/arch/powerpc/platforms/cell/spufs/sched.c
> index 99bd027a7f7c..a2ed928d7658 100644
> --- a/arch/powerpc/platforms/cell/spufs/sched.c
> +++ b/arch/powerpc/platforms/cell/spufs/sched.c
> @@ -1072,7 +1072,7 @@ static int show_spu_loadavg(struct seq_file *s, void *private)
>   		LOAD_INT(c), LOAD_FRAC(c),
>   		count_active_contexts(),
>   		atomic_read(&nr_spu_contexts),
> -		idr_get_cursor(&task_active_pid_ns(current)->idr) - 1);
> +		READ_ONCE(task_active_pid_ns(current)->pid_next) - 1);
>   	return 0;
>   }
>   #endif
> diff --git a/fs/proc/loadavg.c b/fs/proc/loadavg.c
> index 817981e57223..2740b31b6461 100644
> --- a/fs/proc/loadavg.c
> +++ b/fs/proc/loadavg.c
> @@ -22,7 +22,7 @@ static int loadavg_proc_show(struct seq_file *m, void *v)
>   		LOAD_INT(avnrun[1]), LOAD_FRAC(avnrun[1]),
>   		LOAD_INT(avnrun[2]), LOAD_FRAC(avnrun[2]),
>   		nr_running(), nr_threads,
> -		idr_get_cursor(&task_active_pid_ns(current)->idr) - 1);
> +		READ_ONCE(task_active_pid_ns(current)->pid_next) - 1);
>   	return 0;
>   }
>   
> diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
> index 07481bb87d4e..82c72482019d 100644
> --- a/include/linux/pid_namespace.h
> +++ b/include/linux/pid_namespace.h
> @@ -18,6 +18,7 @@ struct fs_pin;
>   
>   struct pid_namespace {
>   	struct idr idr;
> +	unsigned int pid_next;
>   	struct rcu_head rcu;
>   	unsigned int pid_allocated;
>   	struct task_struct *child_reaper;
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 3622f8b13143..2e2d33273c8e 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -75,6 +75,7 @@ int pid_max_max = PID_MAX_LIMIT;
>   struct pid_namespace init_pid_ns = {
>   	.ns.count = REFCOUNT_INIT(2),
>   	.idr = IDR_INIT(init_pid_ns.idr),
> +	.pid_next = 0,
>   	.pid_allocated = PIDNS_ADDING,
>   	.level = 0,
>   	.child_reaper = &init_task,
> @@ -208,7 +209,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
>   			 * init really needs pid 1, but after reaching the
>   			 * maximum wrap back to RESERVED_PIDS
>   			 */
> -			if (idr_get_cursor(&tmp->idr) > RESERVED_PIDS)
> +			if (tmp->pid_next > RESERVED_PIDS)
>   				pid_min = RESERVED_PIDS;
>   
>   			/*
> @@ -217,6 +218,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
>   			 */
>   			nr = idr_alloc_cyclic(&tmp->idr, NULL, pid_min,
>   					      pid_max, GFP_ATOMIC);
> +			tmp->pid_next = nr + 1;
>   		}
>   		xa_unlock_irq(&tmp->idr.idr_rt);
>   		idr_preload_end();
> @@ -278,7 +280,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
>   
>   		/* On failure to allocate the first pid, reset the state */
>   		if (tmp == ns && tmp->pid_allocated == PIDNS_ADDING)
> -			idr_set_cursor(&ns->idr, 0);
> +			ns->pid_next = 0;
>   
>   		idr_remove(&tmp->idr, upid->nr);
>   		xa_unlock_irq(&tmp->idr.idr_rt);
> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> index f4f8cb0435b4..a53d20c5c85e 100644
> --- a/kernel/pid_namespace.c
> +++ b/kernel/pid_namespace.c
> @@ -272,12 +272,12 @@ static int pid_ns_ctl_handler(struct ctl_table *table, int write,
>   	 * it should synchronize its usage with external means.
>   	 */
>   
> -	next = idr_get_cursor(&pid_ns->idr) - 1;
> +	next = READ_ONCE(pid_ns->pid_next) - 1;
>   
>   	tmp.data = &next;
>   	ret = proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
>   	if (!ret && write)
> -		idr_set_cursor(&pid_ns->idr, next + 1);
> +		WRITE_ONCE(pid_ns->pid_next, next + 1);
>   
>   	return ret;
>   }

