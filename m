Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB64BC203C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2019 13:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbfI3Lzy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Sep 2019 07:55:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:59430 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730045AbfI3Lzx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Sep 2019 07:55:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8BA42ABB1;
        Mon, 30 Sep 2019 11:55:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 30 Sep 2019 13:55:48 +0200
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     hev <r@hev.cc>, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Davide Libenzi <davidel@xmailserver.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Eric Wong <e@80x24.org>, Jason Baron <jbaron@akamai.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sridhar Samudrala <sridhar.samudrala@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v4] fs/epoll: Remove unnecessary wakeups of nested
 epoll that in ET mode
In-Reply-To: <20190927192915.6ec24ad706258de99470a96e@linux-foundation.org>
References: <20190925015603.10939-1-r@hev.cc>
 <20190927192915.6ec24ad706258de99470a96e@linux-foundation.org>
Message-ID: <c0a96dd89d0a361d8061b8c356b57ed2@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-09-28 04:29, Andrew Morton wrote:
> On Wed, 25 Sep 2019 09:56:03 +0800 hev <r@hev.cc> wrote:
> 
>> From: Heiher <r@hev.cc>
>> 
>> Take the case where we have:
>> 
>>         t0
>>          | (ew)
>>         e0
>>          | (et)
>>         e1
>>          | (lt)
>>         s0
>> 
>> t0: thread 0
>> e0: epoll fd 0
>> e1: epoll fd 1
>> s0: socket fd 0
>> ew: epoll_wait
>> et: edge-trigger
>> lt: level-trigger
>> 
>> We only need to wakeup nested epoll fds if something has been queued 
>> to the
>> overflow list, since the ep_poll() traverses the rdllist during 
>> recursive poll
>> and thus events on the overflow list may not be visible yet.
>> 
>> Test code:
> 
> Look sane to me.  Do you have any performance testing results which
> show a benefit?
> 
> epoll maintainership isn't exactly a hive of activity nowadays :(
> Roman, would you please have time to review this?

So here is my observation: current patch does not fix the described
problem (double wakeup) for the case, when new event comes exactly
to the ->ovflist.  According to the patch this is the desired intention:

    /*
     * We only need to wakeup nested epoll fds if something has been 
queued
     * to the overflow list, since the ep_poll() traverses the rdllist
     * during recursive poll and thus events on the overflow list may not 
be
     * visible yet.
     */
     if (nepi != NULL)
        pwake++;

     ....

     if (pwake == 2)
        ep_poll_safewake(&ep->poll_wait);


but this actually means that we repeat the same behavior (double wakeup)
but only for the case, when event comes to the ->ovflist.

How to reproduce? Can be easily done (ok, not so easy but it is possible
to try): to the given userspace test we need to add one more socket and
immediately fire the event:

     e.events = EPOLLIN;
     if (epoll_ctl(efd[1], EPOLL_CTL_ADD, s2fd[0], &e) < 0)
        goto out;

     /*
      * Signal any fd to let epoll_wait() to call ep_scan_ready_list()
      * in order to "catch" it there and add new event to ->ovflist.
      */
      if (write(s2fd[1], "w", 1) != 1)
         goto out;

That is done in order to let the following epoll_wait() call to invoke
ep_scan_ready_list(), where we can "catch" and insert new event exactly
to the ->ovflist. In order to insert event exactly in the correct list
I introduce artificial delay.

Modified test and kernel patch is below.  Here is the output of the
testing tool with some debug lines from kernel:

   # ~/devel/test/edge-bug
   [   59.263178] ### sleep 2
   >> write to sock
   [   61.318243] ### done sleep
   [   61.318991] !!!!!!!!!!! ep_poll_safewake(&ep->poll_wait); 
events_in_rdllist=1, events_in_ovflist=1
   [   61.321204] ### sleep 2
   [   63.398325] ### done sleep
   error: What?! Again?!

First epoll_wait() call (ep_scan_ready_list()) observes 2 events
(see "!!!!!!!!!!! ep_poll_safewake" output line), exactly what we
wanted to achieve, so eventually ep_poll_safewake() is called again
which leads to double wakeup.

In my opinion current patch as it is should be dropped, it does not
fix the described problem but just hides it.

--
Roman


######### USERSPACE ##########

#include <unistd.h>
#include <sys/epoll.h>
#include <sys/socket.h>
#include <stdio.h>
#include <pthread.h>

static void *do_thread(void *arg)
{
	int s = *(int *)arg;

	sleep(1);
	printf(">> write to sock\n");
	write(s, "w", 1);
}

int main(int argc, char *argv[])
{
	int s1fd[2];
	int s2fd[2];
	int efd[2];
	struct epoll_event e;

	if (socketpair(AF_UNIX, SOCK_STREAM, 0, s1fd) < 0)
		goto out;
	if (socketpair(AF_UNIX, SOCK_STREAM, 0, s2fd) < 0)
		goto out;

	efd[0] = epoll_create(1);
	if (efd[0] < 0)
		goto out;

	efd[1] = epoll_create(1);
	if (efd[1] < 0)
		goto out;

	e.events = EPOLLIN;
	if (epoll_ctl(efd[1], EPOLL_CTL_ADD, s1fd[0], &e) < 0)
		goto out;

	e.events = EPOLLIN;
	if (epoll_ctl(efd[1], EPOLL_CTL_ADD, s2fd[0], &e) < 0)
		goto out;

	e.events = EPOLLIN | EPOLLET;
	if (epoll_ctl(efd[0], EPOLL_CTL_ADD, efd[1], &e) < 0)
		goto out;

	/*
	 * Signal any fd to let epoll_wait() to call ep_scan_ready_list()
	 * in order to "catch" it there and add new event to ->ovflist.
	 */
	if (write(s2fd[1], "w", 1) != 1)
		goto out;

	pthread_t thr;
	pthread_create(&thr, NULL, do_thread, &s1fd[1]);
	if (epoll_wait(efd[0], &e, 1, 0) != 1) {
		goto out;
	}
	pthread_join(thr, NULL);

	if (epoll_wait(efd[0], &e, 1, 0) != 0) {
		printf("error: What?! Again?!\n");
		goto out;
	}

	return 0;

out:
	return -1;
}


######### KERNEL ##########

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 8bc064630be0..edba7ab45083 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -39,6 +39,8 @@
  #include <linux/rculist.h>
  #include <net/busy_poll.h>

+static bool is_send_events_call;
+
  /*
   * LOCKING:
   * There are three level of locking required by epoll :
@@ -672,6 +674,8 @@ static __poll_t ep_scan_ready_list(struct eventpoll 
*ep,
  	__poll_t res;
  	int pwake = 0;
  	struct epitem *epi, *nepi;
+	unsigned events_in_rdllist = 0;
+	unsigned events_in_ovflist = 0;
  	LIST_HEAD(txlist);

  	lockdep_assert_irqs_enabled();
@@ -693,23 +697,52 @@ static __poll_t ep_scan_ready_list(struct 
eventpoll *ep,
  	 * in a lockless way.
  	 */
  	write_lock_irq(&ep->lock);
+
+	/* XXX Count events */
+	if (!strcmp("edge-bug", current->comm) && depth) {
+		struct list_head *l;
+		list_for_each(l, &ep->rdllist)
+			events_in_rdllist++;
+	}
  	list_splice_init(&ep->rdllist, &txlist);
  	WRITE_ONCE(ep->ovflist, NULL);
  	write_unlock_irq(&ep->lock);

+	if (!strcmp("edge-bug", current->comm) && depth && 
is_send_events_call) {
+		/*
+		 * XXX Introduce delay to let userspace fire event
+		 * XXX directly to ovflist.
+		 */
+		pr_err("### sleep 2\n");
+		msleep(2000);
+		pr_err("### done sleep\n");
+	}
+
+
  	/*
  	 * Now call the callback function.
  	 */
  	res = (*sproc)(ep, &txlist, priv);

  	write_lock_irq(&ep->lock);
+	nepi = READ_ONCE(ep->ovflist);
+	/*
+	 * We only need to wakeup nested epoll fds if something has been 
queued
+	 * to the overflow list, since the ep_poll() traverses the rdllist
+	 * during recursive poll and thus events on the overflow list may not 
be
+	 * visible yet.
+	 */
+	if (nepi != NULL)
+		pwake++;
  	/*
  	 * During the time we spent inside the "sproc" callback, some
  	 * other events might have been queued by the poll callback.
  	 * We re-insert them inside the main ready-list here.
  	 */
-	for (nepi = READ_ONCE(ep->ovflist); (epi = nepi) != NULL;
+	for (; (epi = nepi) != NULL;
  	     nepi = epi->next, epi->next = EP_UNACTIVE_PTR) {
+		/* XXX Count events */
+		events_in_ovflist++;
  		/*
  		 * We need to check if the item is already in the list.
  		 * During the "sproc" callback execution time, items are
@@ -754,8 +787,11 @@ static __poll_t ep_scan_ready_list(struct eventpoll 
*ep,
  		mutex_unlock(&ep->mtx);

  	/* We have to call this outside the lock */
-	if (pwake)
+	if (pwake == 2) {
+		pr_err("!!!!!!!!!!! ep_poll_safewake(&ep->poll_wait); 
events_in_rdllist=%d, events_in_ovflist=%d\n",
+		       events_in_rdllist, events_in_ovflist);
  		ep_poll_safewake(&ep->poll_wait);
+	}

  	return res;
  }
@@ -1925,9 +1961,16 @@ static int ep_poll(struct eventpoll *ep, struct 
epoll_event __user *events,
  	 * there's still timeout left over, we go trying again in search of
  	 * more luck.
  	 */
+
+	/* XXX Catch only ep_scan_ready_list() called from here */
+	if (!strcmp("edge-bug", current->comm))
+		is_send_events_call = 1;
  	if (!res && eavail &&
-	    !(res = ep_send_events(ep, events, maxevents)) && !timed_out)
+	    !(res = ep_send_events(ep, events, maxevents)) && !timed_out) {
+		is_send_events_call = 0;
  		goto fetch_events;
+	}
+	is_send_events_call = 0;

  	if (waiter) {
  		spin_lock_irq(&ep->wq.lock);

