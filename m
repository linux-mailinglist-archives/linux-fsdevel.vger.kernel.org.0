Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E364560DC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 01:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbiF2Xzq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jun 2022 19:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbiF2Xzp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jun 2022 19:55:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA26926AC3;
        Wed, 29 Jun 2022 16:55:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D74D61E8B;
        Wed, 29 Jun 2022 23:55:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7924DC34114;
        Wed, 29 Jun 2022 23:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1656546943;
        bh=GKhkxjzbryUn63yqgSQ8KNnNHPo39huHp9zEOfZ06is=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mz1a22WOM7p6N+j2hEd3epdHXmPpLzn3TocOBeWOGuw/Osl2pXsqRzPKBGHaA5hLE
         T+/m7W9E5L02k/Bmn/YXgQuZXnU9vyWb6zRekxdDyaWNFdikbG+ynX5FxmfZhjFh61
         2P5fBAuYO25TCDAniyBuv7dra8nngX8V8lggyKLs=
Date:   Wed, 29 Jun 2022 16:55:42 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Benjamin Segall <bsegall@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Jason Baron <jbaron@akamai.com>,
        Khazhismel Kumykov <khazhy@google.com>, Heiher <r@hev.cc>
Subject: Re: [RESEND RFC PATCH] epoll: autoremove wakers even more
 aggressively
Message-Id: <20220629165542.da7fc8a2a5dbd53cf99572aa@linux-foundation.org>
In-Reply-To: <xm26fsjotqda.fsf@google.com>
References: <xm26fsjotqda.fsf@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 15 Jun 2022 14:24:23 -0700 Benjamin Segall <bsegall@google.com> wrote:

> If a process is killed or otherwise exits while having active network
> connections and many threads waiting on epoll_wait, the threads will all
> be woken immediately, but not removed from ep->wq. Then when network
> traffic scans ep->wq in wake_up, every wakeup attempt will fail, and
> will not remove the entries from the list.
> 
> This means that the cost of the wakeup attempt is far higher than usual,
> does not decrease, and this also competes with the dying threads trying
> to actually make progress and remove themselves from the wq.
> 
> Handle this by removing visited epoll wq entries unconditionally, rather
> than only when the wakeup succeeds - the structure of ep_poll means that
> the only potential loss is the timed_out->eavail heuristic, which now
> can race and result in a redundant ep_send_events attempt. (But only
> when incoming data and a timeout actually race, not on every timeout)
>

Thanks.  I added people from 412895f03cbf96 ("epoll: atomically remove
wait entry on wake up") to cc.  Hopefully someone there can help review
and maybe test this.


> 
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index e2daa940ebce..8b56b94e2f56 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -1745,10 +1745,25 @@ static struct timespec64 *ep_timeout_to_timespec(struct timespec64 *to, long ms)
>  	ktime_get_ts64(&now);
>  	*to = timespec64_add_safe(now, *to);
>  	return to;
>  }
>  
> +/*
> + * autoremove_wake_function, but remove even on failure to wake up, because we
> + * know that default_wake_function/ttwu will only fail if the thread is already
> + * woken, and in that case the ep_poll loop will remove the entry anyways, not
> + * try to reuse it.
> + */
> +static int ep_autoremove_wake_function(struct wait_queue_entry *wq_entry,
> +				       unsigned int mode, int sync, void *key)
> +{
> +	int ret = default_wake_function(wq_entry, mode, sync, key);
> +
> +	list_del_init(&wq_entry->entry);
> +	return ret;
> +}
> +
>  /**
>   * ep_poll - Retrieves ready events, and delivers them to the caller-supplied
>   *           event buffer.
>   *
>   * @ep: Pointer to the eventpoll context.
> @@ -1826,12 +1841,19 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
>  		 * chance to harvest new event. Otherwise wakeup can be
>  		 * lost. This is also good performance-wise, because on
>  		 * normal wakeup path no need to call __remove_wait_queue()
>  		 * explicitly, thus ep->lock is not taken, which halts the
>  		 * event delivery.
> +		 *
> +		 * In fact, we now use an even more aggressive function that
> +		 * unconditionally removes, because we don't reuse the wait
> +		 * entry between loop iterations. This lets us also avoid the
> +		 * performance issue if a process is killed, causing all of its
> +		 * threads to wake up without being removed normally.
>  		 */
>  		init_wait(&wait);
> +		wait.func = ep_autoremove_wake_function;
>  
>  		write_lock_irq(&ep->lock);
>  		/*
>  		 * Barrierless variant, waitqueue_active() is called under
>  		 * the same lock on wakeup ep_poll_callback() side, so it
> -- 
> 2.36.1.476.g0c4daa206d-goog
