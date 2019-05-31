Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6254330C25
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 11:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfEaJ4W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 05:56:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44530 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfEaJ4V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 05:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=T/f6xtXjUGNf45hEkflxN0bquHarry9NS4GCdXw6I0M=; b=GVEIhX3ihMVMz7nHk3GGeL09f
        HpIxgJJZhhrAKwMZ4dijsJ8DMeE6iK95J1jTSmWa5qSQIlILadqiYaMe4n8iGKQpz/HMnaEw3+AtV
        1ayEHsRH7QaTKuAaqUbkq2r18KHKCbI+BzcKF6M5oQDvRWeDd9zHfeWdOMA7Ug4bMUK2nZwEUFfyb
        Cm577lhPr/B+QDoV6qDDG5JjstK9TmJRXpgp4TcStnBmAXKYvLPRmcU2Cnnxdl8OxfyDHwM3Ct6nJ
        zm6fAlJckmI4XHnZZfgWA3WXjTbI0g+LSb6Vu16/NbAXRuqL8P0eg2CH7iJRf1aKUg7I/vY0+d9RY
        cOuWieZ1w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hWeGo-0002Vc-O9; Fri, 31 May 2019 09:56:18 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 511FA201D5AB1; Fri, 31 May 2019 11:56:16 +0200 (CEST)
Date:   Fri, 31 May 2019 11:56:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     azat@libevent.org, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/13] epoll: call ep_add_event_to_uring() from
 ep_poll_callback()
Message-ID: <20190531095616.GD17637@hirez.programming.kicks-ass.net>
References: <20190516085810.31077-1-rpenyaev@suse.de>
 <20190516085810.31077-8-rpenyaev@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516085810.31077-8-rpenyaev@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 16, 2019 at 10:58:04AM +0200, Roman Penyaev wrote:
> Each ep_poll_callback() is called when fd calls wakeup() on epfd.
> So account new event in user ring.
> 
> The tricky part here is EPOLLONESHOT.  Since we are lockless we
> have to be deal with ep_poll_callbacks() called in paralle, thus
> use cmpxchg to clear public event bits and filter out concurrent
> call from another cpu.
> 
> Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 2f551c005640..55612da9651e 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -1407,6 +1407,29 @@ struct file *get_epoll_tfile_raw_ptr(struct file *file, int tfd,
>  }
>  #endif /* CONFIG_CHECKPOINT_RESTORE */
>  
> +/**
> + * Atomically clear public event bits and return %true if the old value has
> + * public event bits set.
> + */
> +static inline bool ep_clear_public_event_bits(struct epitem *epi)
> +{
> +	__poll_t old, flags;
> +
> +	/*
> +	 * Here we race with ourselves and with ep_modify(), which can
> +	 * change the event bits.  In order not to override events updated
> +	 * by ep_modify() we have to do cmpxchg.
> +	 */
> +
> +	old = epi->event.events;
> +	do {
> +		flags = old;
> +	} while ((old = cmpxchg(&epi->event.events, flags,
> +				flags & EP_PRIVATE_BITS)) != flags);
> +
> +	return flags & ~EP_PRIVATE_BITS;
> +}

AFAICT epi->event.events also has normal writes to it, eg. in
ep_modify(). A number of architectures cannot handle concurrent normal
writes and cmpxchg() to the same variable.

