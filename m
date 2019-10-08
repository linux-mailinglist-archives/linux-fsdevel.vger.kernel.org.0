Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F26C3CF67D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 11:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730324AbfJHJ4C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 05:56:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:53680 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730180AbfJHJ4B (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 05:56:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1D28FAF76;
        Tue,  8 Oct 2019 09:55:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 08 Oct 2019 11:55:58 +0200
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
Message-ID: <f2083f2862f9c2197576900ae0771e32@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-10-07 20:43, Jason Baron wrote:

[...]

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

[...]

> And I think the above change can go in separately (if we decide we want 
> it).

Hi Jason,

I did measurements using Eric's test http://yhbt.net/eponeshotmt.c
(8 writers, 8 waiters;  1 writer, 8 waiters) and tested the impact
of outrunning wakeup: I do not see any difference. Since write events
are constantly coming, next waiter will be woken up anyway by the
following write event.  In order to have some perf gain probably writes
should happen with some interval: produce bunch of events, sleep,
produce bunch of events, sleep, etc, which seems can bring something
only if writer is accidentally synchronized with waiters. Not a clean
way of perf improvement.

--
Roman


