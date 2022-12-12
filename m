Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B107B6497BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Dec 2022 02:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiLLBpX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Dec 2022 20:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLLBpW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Dec 2022 20:45:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA0AD102
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Dec 2022 17:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670809465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C6lnvE9j+zbJeeVsnn0eGEObFI9vcSZBxmPcZEEAOdw=;
        b=VSWOTeQfQRNVHoELL5dtDcYK9vZ/AlrY1EcoTTMz+PNprvAVwINgh0qvsnWcP5YZzqEAV+
        35WB7p5fU+/ENVa3aJDMIm8vM108z0TOfIYAYoSSTkVdnCrtVkY8eMf3D3t5GIi/GTY07t
        GQAWWVdhbM7i5yvQgdiRtAX7EbQqg+0=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-621-XsexTr6-M2WOk-FRdfXA2w-1; Sun, 11 Dec 2022 20:44:22 -0500
X-MC-Unique: XsexTr6-M2WOk-FRdfXA2w-1
Received: by mail-pf1-f200.google.com with SMTP id z8-20020aa79588000000b00576e8050ec9so7163542pfj.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Dec 2022 17:44:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C6lnvE9j+zbJeeVsnn0eGEObFI9vcSZBxmPcZEEAOdw=;
        b=uyYE4bcXrPLKcqXWLGBwA1NFLnTbrLYsiBa2JldJ9fEoLRqB1TCSlmNqFUlUSax/2D
         HxaWs+K8U4h1ZpX2AzqGrxilr/BsN/rS2/1JigeTeyP6z9N1mPk3gH6yA5KuVjYXvjsj
         QbhkaT6gIMli8OQ37gECfazUrwGuSBuDX4CAt447B5gXHZsOPtW2tvwrr0JkHgH4a+kC
         Wdg8uIgChAaJNouhjokgproI46koBpUsaxiWuNI07ce7ddt5kOF8FT/52hK+9RLiR+Ye
         ZAzh2UBUAjM38SVohLBt3m4CtaoS8ESYIRv4cbF7mD3zzy2AiHZiWPp58oYczJrhv7mU
         unug==
X-Gm-Message-State: ANoB5pm47NfYjkAuHWdcR0NG/BehMnhw9k0N7/L0ptc4fLE/IQN4nWPp
        zyl2ewayRa4bYmXm/BIdwwYSGnlzd0hD3PSBP7chVH/SKTYCJz24JDd12a5CVcxQrQcEjZgloms
        OIVXInAiq7j79IkDaURZwAHI3SA==
X-Received: by 2002:a05:6a00:a07:b0:573:3de7:89a with SMTP id p7-20020a056a000a0700b005733de7089amr20821149pfh.4.1670809461638;
        Sun, 11 Dec 2022 17:44:21 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6WmgTNapO/j5cpu+TsVxeXtT+pLntMUrL+qqkyMeZrI53KprTGtIWNbMFh4D8WW2Q1TPvngQ==
X-Received: by 2002:a05:6a00:a07:b0:573:3de7:89a with SMTP id p7-20020a056a000a0700b005733de7089amr20821133pfh.4.1670809461318;
        Sun, 11 Dec 2022 17:44:21 -0800 (PST)
Received: from ?IPV6:2403:580e:4b40:0:7968:2232:4db8:a45e? (2403-580e-4b40--7968-2232-4db8-a45e.ip6.aussiebb.net. [2403:580e:4b40:0:7968:2232:4db8:a45e])
        by smtp.gmail.com with ESMTPSA id g28-20020aa79ddc000000b00573769811d6sm4534577pfq.44.2022.12.11.17.44.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Dec 2022 17:44:20 -0800 (PST)
Message-ID: <669b0d70-6c56-272c-f6bc-586a2b720baa@redhat.com>
Date:   Mon, 12 Dec 2022 09:44:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 1/5] pid: replace pidmap_lock with xarray lock
To:     Brian Foster <bfoster@redhat.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     onestero@redhat.com, willy@infradead.org, ebiederm@redhat.com
References: <20221202171620.509140-1-bfoster@redhat.com>
 <20221202171620.509140-2-bfoster@redhat.com>
Content-Language: en-US
From:   Ian Kent <ikent@redhat.com>
In-Reply-To: <20221202171620.509140-2-bfoster@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/12/22 01:16, Brian Foster wrote:
> As a first step to changing the struct pid tracking code from the
> idr over to the xarray, replace the custom pidmap_lock spinlock with
> the internal lock associated with the underlying xarray. This is
> effectively equivalent to using idr_lock() and friends, but since
> the goal is to disentangle from the idr, move directly to the
> underlying xarray api.
>
> Signed-off-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Brian Foster <bfoster@redhat.com>

The xa array switch looks simpler than I expected, looks good.

Reviewed-by: Ian Kent <raven@themaw.net>

> ---
>   kernel/pid.c | 79 ++++++++++++++++++++++++++--------------------------
>   1 file changed, 40 insertions(+), 39 deletions(-)
>
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 3fbc5e46b721..3622f8b13143 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -86,22 +86,6 @@ struct pid_namespace init_pid_ns = {
>   };
>   EXPORT_SYMBOL_GPL(init_pid_ns);
>   
> -/*
> - * Note: disable interrupts while the pidmap_lock is held as an
> - * interrupt might come in and do read_lock(&tasklist_lock).
> - *
> - * If we don't disable interrupts there is a nasty deadlock between
> - * detach_pid()->free_pid() and another cpu that does
> - * spin_lock(&pidmap_lock) followed by an interrupt routine that does
> - * read_lock(&tasklist_lock);
> - *
> - * After we clean up the tasklist_lock and know there are no
> - * irq handlers that take it we can leave the interrupts enabled.
> - * For now it is easier to be safe than to prove it can't happen.
> - */
> -
> -static  __cacheline_aligned_in_smp DEFINE_SPINLOCK(pidmap_lock);
> -
>   void put_pid(struct pid *pid)
>   {
>   	struct pid_namespace *ns;
> @@ -129,10 +113,11 @@ void free_pid(struct pid *pid)
>   	int i;
>   	unsigned long flags;
>   
> -	spin_lock_irqsave(&pidmap_lock, flags);
>   	for (i = 0; i <= pid->level; i++) {
>   		struct upid *upid = pid->numbers + i;
>   		struct pid_namespace *ns = upid->ns;
> +
> +		xa_lock_irqsave(&ns->idr.idr_rt, flags);
>   		switch (--ns->pid_allocated) {
>   		case 2:
>   		case 1:
> @@ -150,8 +135,8 @@ void free_pid(struct pid *pid)
>   		}
>   
>   		idr_remove(&ns->idr, upid->nr);
> +		xa_unlock_irqrestore(&ns->idr.idr_rt, flags);
>   	}
> -	spin_unlock_irqrestore(&pidmap_lock, flags);
>   
>   	call_rcu(&pid->rcu, delayed_put_pid);
>   }
> @@ -206,7 +191,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
>   		}
>   
>   		idr_preload(GFP_KERNEL);
> -		spin_lock_irq(&pidmap_lock);
> +		xa_lock_irq(&tmp->idr.idr_rt);
>   
>   		if (tid) {
>   			nr = idr_alloc(&tmp->idr, NULL, tid,
> @@ -233,7 +218,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
>   			nr = idr_alloc_cyclic(&tmp->idr, NULL, pid_min,
>   					      pid_max, GFP_ATOMIC);
>   		}
> -		spin_unlock_irq(&pidmap_lock);
> +		xa_unlock_irq(&tmp->idr.idr_rt);
>   		idr_preload_end();
>   
>   		if (nr < 0) {
> @@ -266,34 +251,38 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
>   	INIT_HLIST_HEAD(&pid->inodes);
>   
>   	upid = pid->numbers + ns->level;
> -	spin_lock_irq(&pidmap_lock);
> -	if (!(ns->pid_allocated & PIDNS_ADDING))
> -		goto out_unlock;
>   	for ( ; upid >= pid->numbers; --upid) {
> +		tmp = upid->ns;
> +
> +		xa_lock_irq(&tmp->idr.idr_rt);
> +		if (tmp == ns && !(tmp->pid_allocated & PIDNS_ADDING)) {
> +			xa_unlock_irq(&tmp->idr.idr_rt);
> +			put_pid_ns(ns);
> +			goto out_free;
> +		}
> +
>   		/* Make the PID visible to find_pid_ns. */
> -		idr_replace(&upid->ns->idr, pid, upid->nr);
> -		upid->ns->pid_allocated++;
> +		idr_replace(&tmp->idr, pid, upid->nr);
> +		tmp->pid_allocated++;
> +		xa_unlock_irq(&tmp->idr.idr_rt);
>   	}
> -	spin_unlock_irq(&pidmap_lock);
>   
>   	return pid;
>   
> -out_unlock:
> -	spin_unlock_irq(&pidmap_lock);
> -	put_pid_ns(ns);
> -
>   out_free:
> -	spin_lock_irq(&pidmap_lock);
>   	while (++i <= ns->level) {
>   		upid = pid->numbers + i;
> -		idr_remove(&upid->ns->idr, upid->nr);
> -	}
> +		tmp = upid->ns;
>   
> -	/* On failure to allocate the first pid, reset the state */
> -	if (ns->pid_allocated == PIDNS_ADDING)
> -		idr_set_cursor(&ns->idr, 0);
> +		xa_lock_irq(&tmp->idr.idr_rt);
>   
> -	spin_unlock_irq(&pidmap_lock);
> +		/* On failure to allocate the first pid, reset the state */
> +		if (tmp == ns && tmp->pid_allocated == PIDNS_ADDING)
> +			idr_set_cursor(&ns->idr, 0);
> +
> +		idr_remove(&tmp->idr, upid->nr);
> +		xa_unlock_irq(&tmp->idr.idr_rt);
> +	}
>   
>   	kmem_cache_free(ns->pid_cachep, pid);
>   	return ERR_PTR(retval);
> @@ -301,9 +290,9 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
>   
>   void disable_pid_allocation(struct pid_namespace *ns)
>   {
> -	spin_lock_irq(&pidmap_lock);
> +	xa_lock_irq(&ns->idr.idr_rt);
>   	ns->pid_allocated &= ~PIDNS_ADDING;
> -	spin_unlock_irq(&pidmap_lock);
> +	xa_unlock_irq(&ns->idr.idr_rt);
>   }
>   
>   struct pid *find_pid_ns(int nr, struct pid_namespace *ns)
> @@ -647,6 +636,18 @@ SYSCALL_DEFINE2(pidfd_open, pid_t, pid, unsigned int, flags)
>   	return fd;
>   }
>   
> +/*
> + * Note: disable interrupts while the xarray lock is held as an interrupt might
> + * come in and do read_lock(&tasklist_lock).
> + *
> + * If we don't disable interrupts there is a nasty deadlock between
> + * detach_pid()->free_pid() and another cpu that does xa_lock() followed by an
> + * interrupt routine that does read_lock(&tasklist_lock);
> + *
> + * After we clean up the tasklist_lock and know there are no irq handlers that
> + * take it we can leave the interrupts enabled.  For now it is easier to be safe
> + * than to prove it can't happen.
> + */
>   void __init pid_idr_init(void)
>   {
>   	/* Verify no one has done anything silly: */

