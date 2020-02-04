Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4326D1518FA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2020 11:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgBDKlp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 05:41:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:51882 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbgBDKlp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 05:41:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 656B0B066;
        Tue,  4 Feb 2020 10:41:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 04 Feb 2020 11:41:42 +0100
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Max Neunhoeffer <max@arangodb.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Christopher Kohlhoff <chris.kohlhoff@clearpool.io>,
        Davidlohr Bueso <dbueso@suse.de>,
        Jason Baron <jbaron@akamai.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] epoll: fix possible lost wakeup on epoll_ctl() path
In-Reply-To: <20200203205907.291929-1-rpenyaev@suse.de>
References: <20200203205907.291929-1-rpenyaev@suse.de>
Message-ID: <51f29f23a4d996810bfad12b9634ee12@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Andrew,

Could you please suggest me, do I need to include Reported-by tag,
or reference to the bug is enough?

--
Roman

On 2020-02-03 21:59, Roman Penyaev wrote:
> This fixes possible lost wakeup introduced by the a218cc491420.
> Originally modifications to ep->wq were serialized by ep->wq.lock,
> but in the a218cc491420 new rw lock was introduced in order to
> relax fd event path, i.e. callers of ep_poll_callback() function.
> 
> After the change ep_modify and ep_insert (both are called on
> epoll_ctl() path) were switched to ep->lock, but ep_poll
> (epoll_wait) was using ep->wq.lock on wqueue list modification.
> 
> The bug doesn't lead to any wqueue list corruptions, because wake up
> path and list modifications were serialized by ep->wq.lock
> internally, but actual waitqueue_active() check prior wake_up()
> call can be reordered with modification of ep ready list, thus
> wake up can be lost.
> 
> Current patch replaces ep->wq.lock with the ep->lock for wqueue
> modifications, thus wake up path always observes activeness of
> the wqueue correcty.
> 
> Fixes: a218cc491420 ("epoll: use rwlock in order to reduce
> ep_poll_callback() contention")
> References: https://bugzilla.kernel.org/show_bug.cgi?id=205933
> Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
> Cc: Max Neunhoeffer <max@arangodb.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Christopher Kohlhoff <chris.kohlhoff@clearpool.io>
> Cc: Davidlohr Bueso <dbueso@suse.de>
> Cc: Jason Baron <jbaron@akamai.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  fs/eventpoll.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index b041b66002db..eee3c92a9ebf 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -1854,9 +1854,9 @@ static int ep_poll(struct eventpoll *ep, struct
> epoll_event __user *events,
>  		waiter = true;
>  		init_waitqueue_entry(&wait, current);
> 
> -		spin_lock_irq(&ep->wq.lock);
> +		write_lock_irq(&ep->lock);
>  		__add_wait_queue_exclusive(&ep->wq, &wait);
> -		spin_unlock_irq(&ep->wq.lock);
> +		write_unlock_irq(&ep->lock);
>  	}
> 
>  	for (;;) {
> @@ -1904,9 +1904,9 @@ static int ep_poll(struct eventpoll *ep, struct
> epoll_event __user *events,
>  		goto fetch_events;
> 
>  	if (waiter) {
> -		spin_lock_irq(&ep->wq.lock);
> +		write_lock_irq(&ep->lock);
>  		__remove_wait_queue(&ep->wq, &wait);
> -		spin_unlock_irq(&ep->wq.lock);
> +		write_unlock_irq(&ep->lock);
>  	}
> 
>  	return res;

