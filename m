Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C853CCDFB5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2019 12:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfJGKyh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Oct 2019 06:54:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:52556 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727317AbfJGKyg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Oct 2019 06:54:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A8ACEAD79;
        Mon,  7 Oct 2019 10:54:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 07 Oct 2019 12:54:32 +0200
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Jason Baron <jbaron@akamai.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, hev <r@hev.cc>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Davide Libenzi <davidel@xmailserver.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Eric Wong <e@80x24.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sridhar Samudrala <sridhar.samudrala@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v4] fs/epoll: Remove unnecessary wakeups of nested
 epoll that in ET mode
In-Reply-To: <9ca02c9b-85b7-dced-9c82-1fc453c49b8a@akamai.com>
References: <20190925015603.10939-1-r@hev.cc>
 <20190927192915.6ec24ad706258de99470a96e@linux-foundation.org>
 <c0a96dd89d0a361d8061b8c356b57ed2@suse.de>
 <9ca02c9b-85b7-dced-9c82-1fc453c49b8a@akamai.com>
Message-ID: <9a82925ff7dfc314d36b3d36e54316a8@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-10-03 18:13, Jason Baron wrote:
> On 9/30/19 7:55 AM, Roman Penyaev wrote:
>> On 2019-09-28 04:29, Andrew Morton wrote:
>>> On Wed, 25 Sep 2019 09:56:03 +0800 hev <r@hev.cc> wrote:
>>> 
>>>> From: Heiher <r@hev.cc>
>>>> 
>>>> Take the case where we have:
>>>> 
>>>>         t0
>>>>          | (ew)
>>>>         e0
>>>>          | (et)
>>>>         e1
>>>>          | (lt)
>>>>         s0
>>>> 
>>>> t0: thread 0
>>>> e0: epoll fd 0
>>>> e1: epoll fd 1
>>>> s0: socket fd 0
>>>> ew: epoll_wait
>>>> et: edge-trigger
>>>> lt: level-trigger
>>>> 
>>>> We only need to wakeup nested epoll fds if something has been queued
>>>> to the
>>>> overflow list, since the ep_poll() traverses the rdllist during
>>>> recursive poll
>>>> and thus events on the overflow list may not be visible yet.
>>>> 
>>>> Test code:
>>> 
>>> Look sane to me.  Do you have any performance testing results which
>>> show a benefit?
>>> 
>>> epoll maintainership isn't exactly a hive of activity nowadays :(
>>> Roman, would you please have time to review this?
>> 
>> So here is my observation: current patch does not fix the described
>> problem (double wakeup) for the case, when new event comes exactly
>> to the ->ovflist.  According to the patch this is the desired 
>> intention:
>> 
>>    /*
>>     * We only need to wakeup nested epoll fds if something has been 
>> queued
>>     * to the overflow list, since the ep_poll() traverses the rdllist
>>     * during recursive poll and thus events on the overflow list may 
>> not be
>>     * visible yet.
>>     */
>>     if (nepi != NULL)
>>        pwake++;
>> 
>>     ....
>> 
>>     if (pwake == 2)
>>        ep_poll_safewake(&ep->poll_wait);
>> 
>> 
>> but this actually means that we repeat the same behavior (double 
>> wakeup)
>> but only for the case, when event comes to the ->ovflist.
>> 
>> How to reproduce? Can be easily done (ok, not so easy but it is 
>> possible
>> to try): to the given userspace test we need to add one more socket 
>> and
>> immediately fire the event:
>> 
>>     e.events = EPOLLIN;
>>     if (epoll_ctl(efd[1], EPOLL_CTL_ADD, s2fd[0], &e) < 0)
>>        goto out;
>> 
>>     /*
>>      * Signal any fd to let epoll_wait() to call ep_scan_ready_list()
>>      * in order to "catch" it there and add new event to ->ovflist.
>>      */
>>      if (write(s2fd[1], "w", 1) != 1)
>>         goto out;
>> 
>> That is done in order to let the following epoll_wait() call to invoke
>> ep_scan_ready_list(), where we can "catch" and insert new event 
>> exactly
>> to the ->ovflist. In order to insert event exactly in the correct list
>> I introduce artificial delay.
>> 
>> Modified test and kernel patch is below.  Here is the output of the
>> testing tool with some debug lines from kernel:
>> 
>>   # ~/devel/test/edge-bug
>>   [   59.263178] ### sleep 2
>>   >> write to sock
>>   [   61.318243] ### done sleep
>>   [   61.318991] !!!!!!!!!!! ep_poll_safewake(&ep->poll_wait);
>> events_in_rdllist=1, events_in_ovflist=1
>>   [   61.321204] ### sleep 2
>>   [   63.398325] ### done sleep
>>   error: What?! Again?!
>> 
>> First epoll_wait() call (ep_scan_ready_list()) observes 2 events
>> (see "!!!!!!!!!!! ep_poll_safewake" output line), exactly what we
>> wanted to achieve, so eventually ep_poll_safewake() is called again
>> which leads to double wakeup.
>> 
>> In my opinion current patch as it is should be dropped, it does not
>> fix the described problem but just hides it.
>> 
>> --

Hi Jason,

> 
> Yes, there are 2 wakeups in the test case you describe, but if the
> second event (write to s1fd) gets queued after the first call to
> epoll_wait(), we are going to get 2 wakeups anyways.

Yes, exactly, for this reason I print out the number of events observed
on first wait, there should be 1 (rdllist) and 1 (ovflist), otherwise
this is another case, when second event comes exactly after first
wait, which is legitimate wakeup.

> So yes, there may
> be a slightly bigger window with this patch for 2 wakeups, but its 
> small
> and I tried to be conservative with the patch - I'd rather get an
> occasional 2nd wakeup then miss one. Trying to debug missing wakeups
> isn't always fun...
> 
> That said, the reason for propagating events that end up on the 
> overflow
> list was to prevent the race of the wakee not seeing events because 
> they
> were still on the overflow list. In the testcase, imagine if there was 
> a
> thread doing epoll_wait() on efd[0], and then a write happends on s1fd.
> I thought it was possible then that a 2nd thread doing epoll_wait() on
> efd[1], wakes up, checks efd[0] and sees no events because they are
> still potentially on the overflow list. However, I think that case is
> not possible because the thread doing epoll_wait() on efd[0] is going 
> to
> have the ep->mtx, and thus when the thread wakes up on efd[1], its 
> going
> to have to be ordered because its also grabbing the ep->mtx associated
> with efd[0].
> 
> So I think its safe to do the following if we want to go further than
> the proposed patch, which is what you suggested earlier in the thread
> (minus keeping the wakeup on ep->wq).

Then I do not understand why we need to keep ep->wq wakeup?
@wq and @poll_wait are almost the same with only one difference:
@wq is used when you sleep on it inside epoll_wait() and the other
is used when you nest epoll fd inside epoll fd.  Either you wake
both up either you don't this at all.

ep_poll_callback() does wakeup explicitly, ep_insert() and ep_modify()
do wakeup explicitly, so what are the cases when we need to do wakeups
from ep_scan_ready_list()?

I would still remove the whole branch:


--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -671,7 +671,6 @@ static __poll_t ep_scan_ready_list(struct eventpoll 
*ep,
                               void *priv, int depth, bool ep_locked)
  {
         __poll_t res;
-       int pwake = 0;
         struct epitem *epi, *nepi;
         LIST_HEAD(txlist);

@@ -738,26 +737,11 @@ static __poll_t ep_scan_ready_list(struct 
eventpoll *ep,
          */
         list_splice(&txlist, &ep->rdllist);
         __pm_relax(ep->ws);
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
-
         return res;
  }

--
Roman



