Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9E36D0AEE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 11:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbfJIJVL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 05:21:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:60082 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725935AbfJIJVL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:21:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 47633AD00;
        Wed,  9 Oct 2019 09:21:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 09 Oct 2019 11:21:07 +0200
From:   Roman Penyaev <rpenyaev@suse.de>
To:     hev <r@hev.cc>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davide Libenzi <davidel@xmailserver.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Eric Wong <e@80x24.org>, Jason Baron <jbaron@akamai.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sridhar Samudrala <sridhar.samudrala@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v5] fs/epoll: Remove unnecessary wakeups of nested
 epoll
In-Reply-To: <20191009060516.3577-1-r@hev.cc>
References: <20191009060516.3577-1-r@hev.cc>
Message-ID: <0911c1130bb79fd8c8e266bc7701b251@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-10-09 08:05, hev wrote:
> From: Heiher <r@hev.cc>
> 
> Take the case where we have:
> 
>         t0
>          | (ew)
>         e0
>          | (et)
>         e1
>          | (lt)
>         s0
> 
> t0: thread 0
> e0: epoll fd 0
> e1: epoll fd 1
> s0: socket fd 0
> ew: epoll_wait
> et: edge-trigger
> lt: level-trigger
> 
> We remove unnecessary wakeups to prevent the nested epoll that working 
> in edge-
> triggered mode to waking up continuously.
> 
> Test code:
>  #include <unistd.h>
>  #include <sys/epoll.h>
>  #include <sys/socket.h>
> 
>  int main(int argc, char *argv[])
>  {
>  	int sfd[2];
>  	int efd[2];
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
>  	e.events = EPOLLIN;
>  	if (epoll_ctl(efd[1], EPOLL_CTL_ADD, sfd[0], &e) < 0)
>  		goto out;
> 
>  	e.events = EPOLLIN | EPOLLET;
>  	if (epoll_ctl(efd[0], EPOLL_CTL_ADD, efd[1], &e) < 0)
>  		goto out;
> 
>  	if (write(sfd[1], "w", 1) != 1)
>  		goto out;
> 
>  	if (epoll_wait(efd[0], &e, 1, 0) != 1)
>  		goto out;
> 
>  	if (epoll_wait(efd[0], &e, 1, 0) != 0)
>  		goto out;
> 
>  	close(efd[0]);
>  	close(efd[1]);
>  	close(sfd[0]);
>  	close(sfd[1]);
> 
>  	return 0;
> 
>  out:
>  	return -1;
>  }
> 
> More tests:
>  https://github.com/heiher/epoll-wakeup
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
>  fs/eventpoll.c | 16 ----------------
>  1 file changed, 16 deletions(-)
> 
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index c4159bcc05d9..75fccae100b5 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -671,7 +671,6 @@ static __poll_t ep_scan_ready_list(struct eventpoll 
> *ep,
>  			      void *priv, int depth, bool ep_locked)
>  {
>  	__poll_t res;
> -	int pwake = 0;
>  	struct epitem *epi, *nepi;
>  	LIST_HEAD(txlist);
> 
> @@ -738,26 +737,11 @@ static __poll_t ep_scan_ready_list(struct 
> eventpoll *ep,
>  	 */
>  	list_splice(&txlist, &ep->rdllist);
>  	__pm_relax(ep->ws);
> -
> -	if (!list_empty(&ep->rdllist)) {
> -		/*
> -		 * Wake up (if active) both the eventpoll wait list and
> -		 * the ->poll() wait list (delayed after we release the lock).
> -		 */
> -		if (waitqueue_active(&ep->wq))
> -			wake_up(&ep->wq);
> -		if (waitqueue_active(&ep->poll_wait))
> -			pwake++;
> -	}
>  	write_unlock_irq(&ep->lock);
> 
>  	if (!ep_locked)
>  		mutex_unlock(&ep->mtx);
> 
> -	/* We have to call this outside the lock */
> -	if (pwake)
> -		ep_poll_safewake(&ep->poll_wait);
> -
>  	return res;
>  }

This looks good to me.  Heiher, mind to make kselftest out of your test 
suite?

Reviewed-by: Roman Penyaev <rpenyaev@suse.de>

--
Roman



