Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD68A7FDE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 11:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbfIDJ5s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Sep 2019 05:57:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:37556 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726010AbfIDJ5s (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Sep 2019 05:57:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4AB52B647;
        Wed,  4 Sep 2019 09:57:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 04 Sep 2019 11:57:45 +0200
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Jason Baron <jbaron@akamai.com>
Cc:     hev <r@hev.cc>, linux-fsdevel@vger.kernel.org, e@80x24.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davide Libenzi <davidel@xmailserver.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sridhar Samudrala <sridhar.samudrala@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] fs/epoll: fix the edge-triggered mode for nested
 epoll
In-Reply-To: <7075dd44-feea-a52f-ddaa-087d7bb2c4f6@akamai.com>
References: <20190902052034.16423-1-r@hev.cc>
 <0cdc9905efb9b77b159e09bee17d3ad4@suse.de>
 <7075dd44-feea-a52f-ddaa-087d7bb2c4f6@akamai.com>
Message-ID: <23659bc3e5f80efe9746aefd4d6791e8@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-09-03 23:08, Jason Baron wrote:
> On 9/2/19 11:36 AM, Roman Penyaev wrote:
>> Hi,
>> 
>> This is indeed a bug. (quick side note: could you please remove efd[1]
>> from your test, because it is not related to the reproduction of a
>> current bug).
>> 
>> Your patch lacks a good description, what exactly you've fixed.  Let
>> me speak out loud and please correct me if I'm wrong, my understanding
>> of epoll internals has become a bit rusty: when epoll fds are nested
>> an attempt to harvest events (ep_scan_ready_list() call) produces a
>> second (repeated) event from an internal fd up to an external fd:
>> 
>>      epoll_wait(efd[0], ...):
>>        ep_send_events():
>>           ep_scan_ready_list(depth=0):
>>             ep_send_events_proc():
>>                 ep_item_poll():
>>                   ep_scan_ready_list(depth=1):
>>                     ep_poll_safewake():
>>                       ep_poll_callback()
>>                         list_add_tail(&epi, &epi->rdllist);
>>                         ^^^^^^
>>                         repeated event
>> 
>> 
>> In your patch you forbid wakeup for the cases, where depth != 0, i.e.
>> for all nested cases. That seems clear.  But what if we can go further
>> and remove the whole chunk, which seems excessive:
>> 
>> @@ -885,26 +886,11 @@ static __poll_t ep_scan_ready_list(struct
>> eventpoll *ep,
>> 
>> -
>> -       if (!list_empty(&ep->rdllist)) {
>> -               /*
>> -                * Wake up (if active) both the eventpoll wait list 
>> and
>> -                * the ->poll() wait list (delayed after we release 
>> the
>> lock).
>> -                */
>> -               if (waitqueue_active(&ep->wq))
>> -                       wake_up(&ep->wq);
>> -               if (waitqueue_active(&ep->poll_wait))
>> -                       pwake++;
>> -       }
>>         write_unlock_irq(&ep->lock);
>> 
>>         if (!ep_locked)
>>                 mutex_unlock(&ep->mtx);
>> 
>> -       /* We have to call this outside the lock */
>> -       if (pwake)
>> -               ep_poll_safewake(&ep->poll_wait);
>> 
>> 
>> I reason like that: by the time we've reached the point of scanning 
>> events
>> for readiness all wakeups from ep_poll_callback have been already 
>> fired and
>> new events have been already accounted in ready list 
>> (ep_poll_callback()
>> calls
>> the same ep_poll_safewake()). Here, frankly, I'm not 100% sure and 
>> probably
>> missing some corner cases.
>> 
>> Thoughts?
> 
> So the: 'wake_up(&ep->wq);' part, I think is about waking up other
> threads that may be in waiting in epoll_wait(). For example, there may
> be multiple threads doing epoll_wait() on the same epoll fd, and the
> logic above seems to say thread 1 may have processed say N events and
> now its going to to go off to work those, so let's wake up thread 2 now
> to handle the next chunk.

Not quite. Thread which calls ep_scan_ready_list() processes all the
events, and while processing those, removes them one by one from the
ready list.  But if event mask is !0 and event belongs to
Level Triggered Mode descriptor (let's say default mode) it tails event
again back to the list (because we are in level mode, so event should
be there).  So at the end of this traversing loop ready list is likely
not empty, and if so, wake up again is called for nested epoll fds.
But, those nested epoll fds should get already all the notifications
from the main event callback ep_poll_callback(), regardless any thread
which traverses events.

I suppose this logic exists for decades, when Davide (the author) was
reshuffling the code here and there.

But I do not feel confidence to state that this extra wakeup is bogus,
I just have a gut feeling that it looks excessive.

> So I think removing all that even for the
> depth 0 case is going to change some behavior here. So perhaps, it
> should be removed for all depths except for 0? And if so, it may be
> better to make 2 patches here to separate these changes.
> 
> For the nested wakeups, I agree that the extra wakeups seem unnecessary
> and it may make sense to remove them for all depths. I don't think the
> nested epoll semantics are particularly well spelled out, and afaict,
> nested epoll() has behaved this way for quite some time. And the 
> current
> behavior is not bad in the way that a missing wakeup or false negative
> would be.

That's 100% true! For edge mode extra wake up is not a bug, not optimal
for userspace - yes, but that can't lead to any lost wakeups.

--
Roman

