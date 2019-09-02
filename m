Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 309C8A5AA6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 17:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbfIBPhA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 11:37:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:48684 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725806AbfIBPhA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 11:37:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CD57AACC9;
        Mon,  2 Sep 2019 15:36:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 02 Sep 2019 17:36:54 +0200
From:   Roman Penyaev <rpenyaev@suse.de>
To:     hev <r@hev.cc>
Cc:     linux-fsdevel@vger.kernel.org, e@80x24.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davide Libenzi <davidel@xmailserver.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jason Baron <jbaron@akamai.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sridhar Samudrala <sridhar.samudrala@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] fs/epoll: fix the edge-triggered mode for nested
 epoll
In-Reply-To: <20190902052034.16423-1-r@hev.cc>
References: <20190902052034.16423-1-r@hev.cc>
Message-ID: <0cdc9905efb9b77b159e09bee17d3ad4@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This is indeed a bug. (quick side note: could you please remove efd[1]
from your test, because it is not related to the reproduction of a
current bug).

Your patch lacks a good description, what exactly you've fixed.  Let
me speak out loud and please correct me if I'm wrong, my understanding
of epoll internals has become a bit rusty: when epoll fds are nested
an attempt to harvest events (ep_scan_ready_list() call) produces a
second (repeated) event from an internal fd up to an external fd:

      epoll_wait(efd[0], ...):
        ep_send_events():
           ep_scan_ready_list(depth=0):
             ep_send_events_proc():
                 ep_item_poll():
                   ep_scan_ready_list(depth=1):
                     ep_poll_safewake():
                       ep_poll_callback()
                         list_add_tail(&epi, &epi->rdllist);
                         ^^^^^^
                         repeated event


In your patch you forbid wakeup for the cases, where depth != 0, i.e.
for all nested cases. That seems clear.  But what if we can go further
and remove the whole chunk, which seems excessive:

@@ -885,26 +886,11 @@ static __poll_t ep_scan_ready_list(struct 
eventpoll *ep,

-
-       if (!list_empty(&ep->rdllist)) {
-               /*
-                * Wake up (if active) both the eventpoll wait list and
-                * the ->poll() wait list (delayed after we release the 
lock).
-                */
-               if (waitqueue_active(&ep->wq))
-                       wake_up(&ep->wq);
-               if (waitqueue_active(&ep->poll_wait))
-                       pwake++;
-       }
         write_unlock_irq(&ep->lock);

         if (!ep_locked)
                 mutex_unlock(&ep->mtx);

-       /* We have to call this outside the lock */
-       if (pwake)
-               ep_poll_safewake(&ep->poll_wait);


I reason like that: by the time we've reached the point of scanning 
events
for readiness all wakeups from ep_poll_callback have been already fired 
and
new events have been already accounted in ready list (ep_poll_callback() 
calls
the same ep_poll_safewake()). Here, frankly, I'm not 100% sure and 
probably
missing some corner cases.

Thoughts?

PS.  You call list_empty(&ep->rdllist) without ep->lock taken, that is 
fine,
      but you should be _careful_, so list_empty_careful(&ep->rdllist) 
call
      instead.

--
Roman



On 2019-09-02 07:20, hev wrote:
> From: Heiher <r@hev.cc>
> 
> The structure of event pools:
>  efd[1]: { efd[2] (EPOLLIN) }        efd[0]: { efd[2] (EPOLLIN | 
> EPOLLET) }
>                |                                   |
>                +-----------------+-----------------+
>                                  |
>                                  v
>                              efd[2]: { sfd[0] (EPOLLIN) }
> 
> When sfd[0] to be readable:
>  * the epoll_wait(efd[0], ..., 0) should return efd[2]'s events on 
> first call,
>    and returns 0 on next calls, because efd[2] is added in 
> edge-triggered mode.
>  * the epoll_wait(efd[1], ..., 0) should returns efd[2]'s events on 
> every calls
>    until efd[2] is not readable (epoll_wait(efd[2], ...) => 0), because 
> efd[1]
>    is added in level-triggered mode.
>  * the epoll_wait(efd[2], ..., 0) should returns sfd[0]'s events on 
> every calls
>    until sfd[0] is not readable (read(sfd[0], ...) => EAGAIN), because 
> sfd[0]
>    is added in level-triggered mode.
> 
> Test code:
>  #include <stdio.h>
>  #include <unistd.h>
>  #include <sys/epoll.h>
>  #include <sys/socket.h>
> 
>  int main(int argc, char *argv[])
>  {
>  	int sfd[2];
>  	int efd[3];
>  	int nfds;
>  	struct epoll_event e;
> 
>  	if (socketpair(AF_UNIX, SOCK_STREAM, 0, sfd) < 0)
>  		goto out;
> 
>  	efd[0] = epoll_create(1);
>  	if (efd[0] < 0)
>  		goto out;
> 
>  	efd[1] = epoll_create(1);
>  	if (efd[1] < 0)
>  		goto out;
> 
>  	efd[2] = epoll_create(1);
>  	if (efd[2] < 0)
>  		goto out;
> 
>  	e.events = EPOLLIN;
>  	if (epoll_ctl(efd[2], EPOLL_CTL_ADD, sfd[0], &e) < 0)
>  		goto out;
> 
>  	e.events = EPOLLIN;
>  	if (epoll_ctl(efd[1], EPOLL_CTL_ADD, efd[2], &e) < 0)
>  		goto out;
> 
>  	e.events = EPOLLIN | EPOLLET;
>  	if (epoll_ctl(efd[0], EPOLL_CTL_ADD, efd[2], &e) < 0)
>  		goto out;
> 
>  	if (write(sfd[1], "w", 1) != 1)
>  		goto out;
> 
>  	nfds = epoll_wait(efd[0], &e, 1, 0);
>  	if (nfds != 1)
>  		goto out;
> 
>  	nfds = epoll_wait(efd[0], &e, 1, 0);
>  	if (nfds != 0)
>  		goto out;
> 
>  	nfds = epoll_wait(efd[1], &e, 1, 0);
>  	if (nfds != 1)
>  		goto out;
> 
>  	nfds = epoll_wait(efd[1], &e, 1, 0);
>  	if (nfds != 1)
>  		goto out;
> 
>  	nfds = epoll_wait(efd[2], &e, 1, 0);
>  	if (nfds != 1)
>  		goto out;
> 
>  	nfds = epoll_wait(efd[2], &e, 1, 0);
>  	if (nfds != 1)
>  		goto out;
> 
>  	close(efd[2]);
>  	close(efd[1]);
>  	close(efd[0]);
>  	close(sfd[0]);
>  	close(sfd[1]);
> 
>  	printf("PASS\n");
>  	return 0;
> 
>  out:
>  	printf("FAIL\n");
>  	return -1;
>  }
> 
> Cc: Al Viro <viro@ZenIV.linux.org.uk>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Davide Libenzi <davidel@xmailserver.org>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Eric Wong <e@80x24.org>
> Cc: Jason Baron <jbaron@akamai.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Roman Penyaev <rpenyaev@suse.de>
> Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: hev <r@hev.cc>
> ---
>  fs/eventpoll.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index d7f1f5011fac..a44cb27c636c 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -672,6 +672,7 @@ static __poll_t ep_scan_ready_list(struct eventpoll 
> *ep,
>  {
>  	__poll_t res;
>  	int pwake = 0;
> +	int nwake = 0;
>  	struct epitem *epi, *nepi;
>  	LIST_HEAD(txlist);
> 
> @@ -685,6 +686,9 @@ static __poll_t ep_scan_ready_list(struct eventpoll 
> *ep,
>  	if (!ep_locked)
>  		mutex_lock_nested(&ep->mtx, depth);
> 
> +	if (!depth || list_empty(&ep->rdllist))
> +		nwake = 1;
> +
>  	/*
>  	 * Steal the ready list, and re-init the original one to the
>  	 * empty list. Also, set ep->ovflist to NULL so that events
> @@ -739,7 +743,7 @@ static __poll_t ep_scan_ready_list(struct eventpoll 
> *ep,
>  	list_splice(&txlist, &ep->rdllist);
>  	__pm_relax(ep->ws);
> 
> -	if (!list_empty(&ep->rdllist)) {
> +	if (nwake && !list_empty(&ep->rdllist)) {
>  		/*
>  		 * Wake up (if active) both the eventpoll wait list and
>  		 * the ->poll() wait list (delayed after we release the lock).

