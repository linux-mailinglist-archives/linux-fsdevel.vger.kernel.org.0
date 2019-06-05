Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 980C0356C2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2019 08:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfFEGRF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jun 2019 02:17:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:59672 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726554AbfFEGRE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jun 2019 02:17:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3C086AEA0;
        Wed,  5 Jun 2019 06:17:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 05 Jun 2019 08:17:02 +0200
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Azat Khuzhin <azat@libevent.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/13] epoll: support pollable epoll from userspace
In-Reply-To: <3d9903f6-ebf8-6b8b-6251-b3a305dc9f19@kernel.dk>
References: <20190516085810.31077-1-rpenyaev@suse.de>
 <a2a88f4f-d104-f565-4d6e-1dddc7f79a05@kernel.dk>
 <1d47ee76735f25ae5e91e691195f7aa5@suse.de>
 <e552262b-2069-075e-f7db-cec19a12a363@kernel.dk>
 <8b3bade3c5fffdd8f1ab24940258d4e1@suse.de>
 <3d9903f6-ebf8-6b8b-6251-b3a305dc9f19@kernel.dk>
Message-ID: <abf62eeb1b0be93404967c1e98190e83@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-05-31 23:09, Jens Axboe wrote:
> On 5/31/19 1:45 PM, Roman Penyaev wrote:
>> On 2019-05-31 18:54, Jens Axboe wrote:
>>> On 5/31/19 10:02 AM, Roman Penyaev wrote:
>>>> On 2019-05-31 16:48, Jens Axboe wrote:
>>>>> On 5/16/19 2:57 AM, Roman Penyaev wrote:
>>>>>> Hi all,
>>>>>> 
>>>>>> This is v3 which introduces pollable epoll from userspace.
>>>>>> 
>>>>>> v3:
>>>>>>     - Measurements made, represented below.
>>>>>> 
>>>>>>     - Fix alignment for epoll_uitem structure on all 64-bit archs
>>>>>> except
>>>>>>       x86-64. epoll_uitem should be always 16 bit, proper
>>>>>> BUILD_BUG_ON
>>>>>>       is added. (Linus)
>>>>>> 
>>>>>>     - Check pollflags explicitly on 0 inside work callback, and do
>>>>>> nothing
>>>>>>       if 0.
>>>>>> 
>>>>>> v2:
>>>>>>     - No reallocations, the max number of items (thus size of the
>>>>>> user
>>>>>> ring)
>>>>>>       is specified by the caller.
>>>>>> 
>>>>>>     - Interface is simplified: -ENOSPC is returned on attempt to 
>>>>>> add
>>>>>> a
>>>>>> new
>>>>>>       epoll item if number is reached the max, nothing more.
>>>>>> 
>>>>>>     - Alloced pages are accounted using user->locked_vm and 
>>>>>> limited
>>>>>> to
>>>>>>       RLIMIT_MEMLOCK value.
>>>>>> 
>>>>>>     - EPOLLONESHOT is handled.
>>>>>> 
>>>>>> This series introduces pollable epoll from userspace, i.e. user
>>>>>> creates
>>>>>> epfd with a new EPOLL_USERPOLL flag, mmaps epoll descriptor, gets
>>>>>> header
>>>>>> and ring pointers and then consumes ready events from a ring,
>>>>>> avoiding
>>>>>> epoll_wait() call.  When ring is empty, user has to call
>>>>>> epoll_wait()
>>>>>> in order to wait for new events.  epoll_wait() returns -ESTALE if
>>>>>> user
>>>>>> ring has events in the ring (kind of indication, that user has to
>>>>>> consume
>>>>>> events from the user ring first, I could not invent anything 
>>>>>> better
>>>>>> than
>>>>>> returning -ESTALE).
>>>>>> 
>>>>>> For user header and user ring allocation I used vmalloc_user().  I
>>>>>> found
>>>>>> that it is much easy to reuse remap_vmalloc_range_partial() 
>>>>>> instead
>>>>>> of
>>>>>> dealing with page cache (like aio.c does).  What is also nice is
>>>>>> that
>>>>>> virtual address is properly aligned on SHMLBA, thus there should 
>>>>>> not
>>>>>> be
>>>>>> any d-cache aliasing problems on archs with vivt or vipt caches.
>>>>> 
>>>>> Why aren't we just adding support to io_uring for this instead? 
>>>>> Then
>>>>> we
>>>>> don't need yet another entirely new ring, that's is just a little
>>>>> different from what we have.
>>>>> 
>>>>> I haven't looked into the details of your implementation, just
>>>>> curious
>>>>> if there's anything that makes using io_uring a non-starter for 
>>>>> this
>>>>> purpose?
>>>> 
>>>> Afaict the main difference is that you do not need to recharge an fd
>>>> (submit new poll request in terms of io_uring): once fd has been 
>>>> added
>>>> to
>>>> epoll with epoll_ctl() - we get events.  When you have thousands of
>>>> fds
>>>> -
>>>> that should matter.
>>>> 
>>>> Also interesting question is how difficult to modify existing event
>>>> loops
>>>> in event libraries in order to support recharging (EPOLLONESHOT in
>>>> terms
>>>> of epoll).
>>>> 
>>>> Maybe Azat who maintains libevent can shed light on this (currently 
>>>> I
>>>> see
>>>> that libevent does not support "EPOLLONESHOT" logic).
>>> 
>>> In terms of existing io_uring poll support, which is what I'm 
>>> guessing
>>> you're referring to, it is indeed just one-shot.
>> 
>> Yes, yes.
>> 
>>> But there's no reason  why we can't have it persist until explicitly
>>> canceled with POLL_REMOVE.
>> 
>> It seems not so easy.  The main problem is that with only a ring it is
>> impossible to figure out on kernel side what event bits have been
>> already
>> seen by the userspace and what bits are new.  So every new cqe has to
>> be added to a completion ring on each wake_up_interruptible() call.
>> (I mean when fd wants to report that something is ready).
>> 
>> IMO that can lead to many duplicate events (tens? hundreds? honestly 
>> no
>> idea), which userspace has to handle with subsequent read/write calls.
>> It can kill all performance benefits of a uring.
>> 
>> In uepoll this is solved with another piece of shared memory, where
>> userspace atomically clears bits and kernel side sets bits.  If kernel
>> observes that bits were set (i.e. userspace has not seen this event)
>> - new index is added to a ring.
> 
> Those are good points.
> 
>> Can we extend the io_uring API to support this behavior?  Also would
>> be great if we can make event path lockless.  On a big number of fds
>> and frequent events - this matters, please take a look, recently I
>> did some measurements:  https://lkml.org/lkml/2018/12/12/305
> 
> Yeah, I'd be happy to entertain that idea, and lockless completions as
> well. We already do that for polled IO, but consider any "normal"
> completion to be IRQ driven and hence need locking.

I would like to contribute as much as I can. "Subscription" on events
along with lockless ring seems reasonable to do for io_uring. I still
tend to think that uepoll and io_uring poll can coexist, at least
because it can be difficult to adopt current event libraries to async
nature of "add fd" / "remove add" requests of the io_uring, e.g. when
epoll_ctl() is called in order to remove fd, the caller expects no
events come after epoll_ctl() returns. Async behavior can break the
event loop. What can help is ability to wait on particular request,
which seems not possible without ugly tricks, right? (Under ugly tricks
I mean something as: wait for any event, traverse the completion ring
in order to meet particular completion, repeat if nothing is found).

Also epoll_ctl() can be called from another thread in order to
add/remove fd, and I suppose that is also successfully used by event
loop libraries or users of these libraries (not quite sure though, but
can imagine why it can be useful). To fix that will require introducing
locks on submission path of io_uring callers (I mean on user side,
inside these libraries), which can impact performance for generic
cases (only submission though).

What I want to say is that polling using io_uring can be used in some
new io/event stacks, but adoption of current event libraries can be
non trivial, where old plain epoll with a ring can be an easiest way.
But of course that's only my speculation.

--
Roman

