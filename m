Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070861B719F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 12:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgDXKL1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Apr 2020 06:11:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:44062 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726698AbgDXKL1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Apr 2020 06:11:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D8C84AED7;
        Fri, 24 Apr 2020 10:11:23 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 24 Apr 2020 12:11:23 +0200
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Khazhismel Kumykov <khazhy@google.com>
Cc:     viro@zeniv.linux.org.uk, akpm@linux-foundation.org, r@hev.cc,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eventpoll: fix missing wakeup for ovflist in
 ep_poll_callback
In-Reply-To: <20200424025057.118641-1-khazhy@google.com>
References: <20200424025057.118641-1-khazhy@google.com>
Message-ID: <2bd5fcb37337dd7248a5cb245bf8dde9@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Khazhismel,

That seems to be correct. The patch you refer 339ddb53d373
relies on callback path, which *should* wake up, not the path
which harvests events (thus unnecessary wakeups).  When we add
a new event to the ->ovflist nobody wakes up the waiters,
thus missing wakeup. You are right.

May I suggest a small change in order to avoid one new goto?
We can add a new event in either ->ovflist or ->rdllist and
then wakeup should happen. So simple 'else if' branch should
do things right, something like the following:

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 8c596641a72b..7d566667c6ad 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1171,6 +1171,10 @@ static inline bool chain_epi_lockless(struct 
epitem *epi)
  {
         struct eventpoll *ep = epi->ep;

+       /* Fast preliminary check */
+       if (epi->next != EP_UNACTIVE_PTR)
+               return false;
+
         /* Check that the same epi has not been just chained from 
another CPU */
         if (cmpxchg(&epi->next, EP_UNACTIVE_PTR, NULL) != 
EP_UNACTIVE_PTR)
                 return false;
@@ -1237,16 +1241,13 @@ static int ep_poll_callback(wait_queue_entry_t 
*wait, unsigned mode, int sync, v
          * chained in ep->ovflist and requeued later on.
          */
         if (READ_ONCE(ep->ovflist) != EP_UNACTIVE_PTR) {
-               if (epi->next == EP_UNACTIVE_PTR &&
-                   chain_epi_lockless(epi))
+               if (chain_epi_lockless(epi))
                         ep_pm_stay_awake_rcu(epi);
-               goto out_unlock;
         }
-
-       /* If this file is already in the ready list we exit soon */
-       if (!ep_is_linked(epi) &&
-           list_add_tail_lockless(&epi->rdllink, &ep->rdllist)) {
-               ep_pm_stay_awake_rcu(epi);
+       /* Otherwise take usual path and add event to ready list */
+       else if (!ep_is_linked(epi)) {
+               if (list_add_tail_lockless(&epi->rdllink, &ep->rdllist))
+                       ep_pm_stay_awake_rcu(epi);
         }


I also moved 'epi->next == EP_UNACTIVE_PTR' check directly
to the chain_epi_lockless, where it should be.

This is minor, of course, you are free to keep it as is.

Reviewed-by: Roman Penyaev <rpenyaev@suse.de>

--
Roman


On 2020-04-24 04:50, Khazhismel Kumykov wrote:
> In the event that we add to ovflist, before 339ddb53d373 we would be
> woken up by ep_scan_ready_list, and did no wakeup in ep_poll_callback.
> With that wakeup removed, if we add to ovflist here, we may never wake
> up. Rather than adding back the ep_scan_ready_list wakeup - which was
> resulting un uncessary wakeups, trigger a wake-up in ep_poll_callback.
> 
> We noticed that one of our workloads was missing wakeups starting with
> 339ddb53d373 and upon manual inspection, this wakeup seemed missing to
> me. With this patch added, we no longer see missing wakeups. I haven't
> yet tried to make a small reproducer, but the existing kselftests in
> filesystem/epoll passed for me with this patch.
> 
> Fixes: 339ddb53d373 ("fs/epoll: remove unnecessary wakeups of nested 
> epoll")
> Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
> ---
>  fs/eventpoll.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 8c596641a72b..40cc89559cf6 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -1240,7 +1240,7 @@ static int ep_poll_callback(wait_queue_entry_t
> *wait, unsigned mode, int sync, v
>  		if (epi->next == EP_UNACTIVE_PTR &&
>  		    chain_epi_lockless(epi))
>  			ep_pm_stay_awake_rcu(epi);
> -		goto out_unlock;
> +		goto out_wakeup_unlock;
>  	}
> 
>  	/* If this file is already in the ready list we exit soon */
> @@ -1249,6 +1249,7 @@ static int ep_poll_callback(wait_queue_entry_t
> *wait, unsigned mode, int sync, v
>  		ep_pm_stay_awake_rcu(epi);
>  	}
> 
> +out_wakeup_unlock:
>  	/*
>  	 * Wake up ( if active ) both the eventpoll wait list and the 
> ->poll()
>  	 * wait list.

