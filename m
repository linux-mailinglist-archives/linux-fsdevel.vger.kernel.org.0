Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAADCEC7D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2019 21:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbfJGTKS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Oct 2019 15:10:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:36224 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728079AbfJGTKR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Oct 2019 15:10:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 16651AE36;
        Mon,  7 Oct 2019 19:10:14 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 07 Oct 2019 21:10:13 +0200
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
In-Reply-To: <56b7c2c2-debc-4e62-904e-f2f1c2e65293@akamai.com>
References: <20190925015603.10939-1-r@hev.cc>
 <20190927192915.6ec24ad706258de99470a96e@linux-foundation.org>
 <c0a96dd89d0a361d8061b8c356b57ed2@suse.de>
 <9ca02c9b-85b7-dced-9c82-1fc453c49b8a@akamai.com>
 <9a82925ff7dfc314d36b3d36e54316a8@suse.de>
 <9ceee722-d2a8-b182-c95a-e7a873b08ca1@akamai.com>
 <cda953c3fec34fe14b231c30c75e57a1@suse.de>
 <56b7c2c2-debc-4e62-904e-f2f1c2e65293@akamai.com>
Message-ID: <addd675e77a7dfc4e78e2bb8757c974b@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-10-07 20:43, Jason Baron wrote:
> On 10/7/19 2:30 PM, Roman Penyaev wrote:
>> On 2019-10-07 18:42, Jason Baron wrote:
>>> On 10/7/19 6:54 AM, Roman Penyaev wrote:
>>>> On 2019-10-03 18:13, Jason Baron wrote:
>>>>> On 9/30/19 7:55 AM, Roman Penyaev wrote:
>>>>>> On 2019-09-28 04:29, Andrew Morton wrote:
>>>>>>> On Wed, 25 Sep 2019 09:56:03 +0800 hev <r@hev.cc> wrote:
>>>>>>> 
>>>>>>>> From: Heiher <r@hev.cc>
>>>>>>>> 
>>>>>>>> Take the case where we have:
>>>>>>>> 
>>>>>>>>         t0
>>>>>>>>          | (ew)
>>>>>>>>         e0
>>>>>>>>          | (et)
>>>>>>>>         e1
>>>>>>>>          | (lt)
>>>>>>>>         s0
>>>>>>>> 
>>>>>>>> t0: thread 0
>>>>>>>> e0: epoll fd 0
>>>>>>>> e1: epoll fd 1
>>>>>>>> s0: socket fd 0
>>>>>>>> ew: epoll_wait
>>>>>>>> et: edge-trigger
>>>>>>>> lt: level-trigger
>>>>>>>> 
>>>>>>>> We only need to wakeup nested epoll fds if something has been 
>>>>>>>> queued
>>>>>>>> to the
>>>>>>>> overflow list, since the ep_poll() traverses the rdllist during
>>>>>>>> recursive poll
>>>>>>>> and thus events on the overflow list may not be visible yet.
>>>>>>>> 
>>>>>>>> Test code:
>>>>>>> 
>>>>>>> Look sane to me.  Do you have any performance testing results 
>>>>>>> which
>>>>>>> show a benefit?
>>>>>>> 
>>>>>>> epoll maintainership isn't exactly a hive of activity nowadays :(
>>>>>>> Roman, would you please have time to review this?
>>>>>> 
>>>>>> So here is my observation: current patch does not fix the 
>>>>>> described
>>>>>> problem (double wakeup) for the case, when new event comes exactly
>>>>>> to the ->ovflist.  According to the patch this is the desired
>>>>>> intention:
>>>>>> 
>>>>>>    /*
>>>>>>     * We only need to wakeup nested epoll fds if something has 
>>>>>> been
>>>>>> queued
>>>>>>     * to the overflow list, since the ep_poll() traverses the 
>>>>>> rdllist
>>>>>>     * during recursive poll and thus events on the overflow list 
>>>>>> may
>>>>>> not be
>>>>>>     * visible yet.
>>>>>>     */
>>>>>>     if (nepi != NULL)
>>>>>>        pwake++;
>>>>>> 
>>>>>>     ....
>>>>>> 
>>>>>>     if (pwake == 2)
>>>>>>        ep_poll_safewake(&ep->poll_wait);
>>>>>> 
>>>>>> 
>>>>>> but this actually means that we repeat the same behavior (double
>>>>>> wakeup)
>>>>>> but only for the case, when event comes to the ->ovflist.
>>>>>> 
>>>>>> How to reproduce? Can be easily done (ok, not so easy but it is
>>>>>> possible
>>>>>> to try): to the given userspace test we need to add one more 
>>>>>> socket
>>>>>> and
>>>>>> immediately fire the event:
>>>>>> 
>>>>>>     e.events = EPOLLIN;
>>>>>>     if (epoll_ctl(efd[1], EPOLL_CTL_ADD, s2fd[0], &e) < 0)
>>>>>>        goto out;
>>>>>> 
>>>>>>     /*
>>>>>>      * Signal any fd to let epoll_wait() to call 
>>>>>> ep_scan_ready_list()
>>>>>>      * in order to "catch" it there and add new event to 
>>>>>> ->ovflist.
>>>>>>      */
>>>>>>      if (write(s2fd[1], "w", 1) != 1)
>>>>>>         goto out;
>>>>>> 
>>>>>> That is done in order to let the following epoll_wait() call to 
>>>>>> invoke
>>>>>> ep_scan_ready_list(), where we can "catch" and insert new event
>>>>>> exactly
>>>>>> to the ->ovflist. In order to insert event exactly in the correct 
>>>>>> list
>>>>>> I introduce artificial delay.
>>>>>> 
>>>>>> Modified test and kernel patch is below.  Here is the output of 
>>>>>> the
>>>>>> testing tool with some debug lines from kernel:
>>>>>> 
>>>>>>   # ~/devel/test/edge-bug
>>>>>>   [   59.263178] ### sleep 2
>>>>>>   >> write to sock
>>>>>>   [   61.318243] ### done sleep
>>>>>>   [   61.318991] !!!!!!!!!!! ep_poll_safewake(&ep->poll_wait);
>>>>>> events_in_rdllist=1, events_in_ovflist=1
>>>>>>   [   61.321204] ### sleep 2
>>>>>>   [   63.398325] ### done sleep
>>>>>>   error: What?! Again?!
>>>>>> 
>>>>>> First epoll_wait() call (ep_scan_ready_list()) observes 2 events
>>>>>> (see "!!!!!!!!!!! ep_poll_safewake" output line), exactly what we
>>>>>> wanted to achieve, so eventually ep_poll_safewake() is called 
>>>>>> again
>>>>>> which leads to double wakeup.
>>>>>> 
>>>>>> In my opinion current patch as it is should be dropped, it does 
>>>>>> not
>>>>>> fix the described problem but just hides it.
>>>>>> 
>>>>>> --
>>>> 
>>>> Hi Jason,
>>>> 
>>>>> 
>>>>> Yes, there are 2 wakeups in the test case you describe, but if the
>>>>> second event (write to s1fd) gets queued after the first call to
>>>>> epoll_wait(), we are going to get 2 wakeups anyways.
>>>> 
>>>> Yes, exactly, for this reason I print out the number of events 
>>>> observed
>>>> on first wait, there should be 1 (rdllist) and 1 (ovflist), 
>>>> otherwise
>>>> this is another case, when second event comes exactly after first
>>>> wait, which is legitimate wakeup.
>>>> 
>>>>> So yes, there may
>>>>> be a slightly bigger window with this patch for 2 wakeups, but its
>>>>> small
>>>>> and I tried to be conservative with the patch - I'd rather get an
>>>>> occasional 2nd wakeup then miss one. Trying to debug missing 
>>>>> wakeups
>>>>> isn't always fun...
>>>>> 
>>>>> That said, the reason for propagating events that end up on the
>>>>> overflow
>>>>> list was to prevent the race of the wakee not seeing events because
>>>>> they
>>>>> were still on the overflow list. In the testcase, imagine if there
>>>>> was a
>>>>> thread doing epoll_wait() on efd[0], and then a write happends on 
>>>>> s1fd.
>>>>> I thought it was possible then that a 2nd thread doing epoll_wait() 
>>>>> on
>>>>> efd[1], wakes up, checks efd[0] and sees no events because they are
>>>>> still potentially on the overflow list. However, I think that case 
>>>>> is
>>>>> not possible because the thread doing epoll_wait() on efd[0] is
>>>>> going to
>>>>> have the ep->mtx, and thus when the thread wakes up on efd[1], its
>>>>> going
>>>>> to have to be ordered because its also grabbing the ep->mtx 
>>>>> associated
>>>>> with efd[0].
>>>>> 
>>>>> So I think its safe to do the following if we want to go further 
>>>>> than
>>>>> the proposed patch, which is what you suggested earlier in the 
>>>>> thread
>>>>> (minus keeping the wakeup on ep->wq).
>>>> 
>>>> Then I do not understand why we need to keep ep->wq wakeup?
>>>> @wq and @poll_wait are almost the same with only one difference:
>>>> @wq is used when you sleep on it inside epoll_wait() and the other
>>>> is used when you nest epoll fd inside epoll fd.  Either you wake
>>>> both up either you don't this at all.
>>>> 
>>>> ep_poll_callback() does wakeup explicitly, ep_insert() and 
>>>> ep_modify()
>>>> do wakeup explicitly, so what are the cases when we need to do 
>>>> wakeups
>>>> from ep_scan_ready_list()?
>>> 
>>> Hi Roman,
>>> 
>>> So the reason I was saying not to drop the ep->wq wakeup was that I 
>>> was
>>> thinking about a usecase where you have multi-threads say thread A 
>>> and
>>> thread B which are doing epoll_wait() on the same epfd. Now, the 
>>> threads
>>> both call epoll_wait() and are added as exclusive to ep->wq. Now a 
>>> bunch
>>> of events happen and thread A is woken up. However, thread A may only
>>> process a subset of the events due to its 'maxevents' parameter. In 
>>> that
>>> case, I was thinking that the wakeup on ep->wq might be helpful, 
>>> because
>>> in the absence of subsequent events, thread B can now start 
>>> processing
>>> the rest, instead of waiting for the next event to be queued.
>>> 
>>> However, I was thinking about the state of things before:
>>> 86c0517 fs/epoll: deal with wait_queue only once
>>> 
>>> Before that patch, thread A would have been removed from eq->wq 
>>> before
>>> the wakeup call, thus waking up thread B. However, now that thread A
>>> stays on the queue during the call to ep_send_events(), I believe the
>>> wakeup would only target thread A, which doesn't help since its 
>>> already
>>> checking for events. So given the state of things I think you are 
>>> right
>>> in that its not needed. However, I wonder if not removing from the
>>> ep->wq affects the multi-threaded case I described. Its been around
>>> since 5.0, so probably not, but it would be a more subtle performance
>>> difference.
>> 
>> Now I understand what you mean. You want to prevent "idling" of 
>> events,
>> while thread A is busy with the small portion of events (portion is 
>> equal
>> to maxevents).  On next iteration thread A will pick up the rest, no
>> doubts,
>> but would be nice to give a chance to thread B immediately to deal 
>> with the
>> rest.  Ok, makes sense.
> 
> Exactly, I don't believe its racy as is - but it seems like it would be
> good to wakeup other threads that may be waiting. That said, this logic
> was removed as I pointed out. So I'm not sure we need to tie this 
> change
> to the current one - but it may be a nice addition.
> 
>> 
>> But what if to make this wakeup explicit if we have more events to 
>> process?
>> (nothing is tested, just a guess)
>> 
>> @@ -255,6 +255,7 @@ struct ep_pqueue {
>>  struct ep_send_events_data {
>>         int maxevents;
>>         struct epoll_event __user *events;
>> +       bool have_more;
>>         int res;
>>  };
>> @@ -1783,14 +1768,17 @@ static __poll_t ep_send_events_proc(struct
>> eventpoll *ep, struct list_head *head
>>  }
>> 
>>  static int ep_send_events(struct eventpoll *ep,
>> -                         struct epoll_event __user *events, int 
>> maxevents)
>> +                         struct epoll_event __user *events, int 
>> maxevents,
>> +                         bool *have_more)
>>  {
>> -       struct ep_send_events_data esed;
>> -
>> -       esed.maxevents = maxevents;
>> -       esed.events = events;
>> +       struct ep_send_events_data esed = {
>> +               .maxevents = maxevents,
>> +               .events = events,
>> +       };
>> 
>>         ep_scan_ready_list(ep, ep_send_events_proc, &esed, 0, false);
>> +       *have_more = esed.have_more;
>> +
>>         return esed.res;
>>  }
>> 
>> @@ -1827,7 +1815,7 @@ static int ep_poll(struct eventpoll *ep, struct
>> epoll_event __user *events,
>>  {
>>         int res = 0, eavail, timed_out = 0;
>>         u64 slack = 0;
>> -       bool waiter = false;
>> +       bool waiter = false, have_more;
>>         wait_queue_entry_t wait;
>>         ktime_t expires, *to = NULL;
>> 
>> @@ -1927,7 +1915,8 @@ static int ep_poll(struct eventpoll *ep, struct
>> epoll_event __user *events,
>>          * more luck.
>>          */
>>         if (!res && eavail &&
>> -           !(res = ep_send_events(ep, events, maxevents)) && 
>> !timed_out)
>> +           !(res = ep_send_events(ep, events, maxevents, &have_more)) 
>> &&
>> +           !timed_out)
>>                 goto fetch_events;
>> 
>>         if (waiter) {
>> @@ -1935,6 +1924,12 @@ static int ep_poll(struct eventpoll *ep, struct
>> epoll_event __user *events,
>>                 __remove_wait_queue(&ep->wq, &wait);
>>                 spin_unlock_irq(&ep->wq.lock);
>>         }
>> +       /*
>> +        * We were not able to process all the events, so immediately
>> +        * wakeup other waiter.
>> +        */
>> +       if (res > 0 && have_more && waitqueue_active(&ep->wq))
>> +               wake_up(&ep->wq);
>> 
>>         return res;
>>  }
>> 
>> 
> 
> Ok, yeah I like making it explicit. Looks like you are missing the
> changes to ep_scan_ready_list(), but I think the general approach makes
> sense.

Yeah, missed the hunk:

@@ -1719,8 +1704,10 @@ static __poll_t ep_send_events_proc(struct 
eventpoll *ep, struct list_head *head
         lockdep_assert_held(&ep->mtx);

         list_for_each_entry_safe(epi, tmp, head, rdllink) {
-               if (esed->res >= esed->maxevents)
+               if (esed->res >= esed->maxevents) {
+                       esed->have_more = true;
                         break;
+               }

> Although I really didn't have a test case that motivated this -
> its just was sort of noting this change in behavior while reviewing the
> current change.
> 
>> PS. So what we decide with the original patch?  Remove the whole 
>> branch?
>> 
> 
> For fwiw, I'm ok removing the whole branch as you proposed.

Then probably Heiher could resend once more. Heiher, can you, please?

> And I think the above change can go in separately (if we decide we want 
> it). I don't
> think they need to be tied together. I also want to make sure this
> change gets a full linux-next cycle, so I think it should target 5.5 at
> this point.

Sure, this explicit ->wq wakeup is a separate patch, which should be
covered with some benchmarks.  I can try to cook something out in order
to get numbers.

--
Roman

