Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A380031592
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 21:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfEaTpF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 15:45:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:55000 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727147AbfEaTpF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 15:45:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D2426AE76;
        Fri, 31 May 2019 19:45:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 31 May 2019 21:45:02 +0200
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Azat Khuzhin <azat@libevent.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/13] epoll: support pollable epoll from userspace
In-Reply-To: <e552262b-2069-075e-f7db-cec19a12a363@kernel.dk>
References: <20190516085810.31077-1-rpenyaev@suse.de>
 <a2a88f4f-d104-f565-4d6e-1dddc7f79a05@kernel.dk>
 <1d47ee76735f25ae5e91e691195f7aa5@suse.de>
 <e552262b-2069-075e-f7db-cec19a12a363@kernel.dk>
Message-ID: <8b3bade3c5fffdd8f1ab24940258d4e1@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-05-31 18:54, Jens Axboe wrote:
> On 5/31/19 10:02 AM, Roman Penyaev wrote:
>> On 2019-05-31 16:48, Jens Axboe wrote:
>>> On 5/16/19 2:57 AM, Roman Penyaev wrote:
>>>> Hi all,
>>>> 
>>>> This is v3 which introduces pollable epoll from userspace.
>>>> 
>>>> v3:
>>>>    - Measurements made, represented below.
>>>> 
>>>>    - Fix alignment for epoll_uitem structure on all 64-bit archs 
>>>> except
>>>>      x86-64. epoll_uitem should be always 16 bit, proper 
>>>> BUILD_BUG_ON
>>>>      is added. (Linus)
>>>> 
>>>>    - Check pollflags explicitly on 0 inside work callback, and do
>>>> nothing
>>>>      if 0.
>>>> 
>>>> v2:
>>>>    - No reallocations, the max number of items (thus size of the 
>>>> user
>>>> ring)
>>>>      is specified by the caller.
>>>> 
>>>>    - Interface is simplified: -ENOSPC is returned on attempt to add 
>>>> a
>>>> new
>>>>      epoll item if number is reached the max, nothing more.
>>>> 
>>>>    - Alloced pages are accounted using user->locked_vm and limited 
>>>> to
>>>>      RLIMIT_MEMLOCK value.
>>>> 
>>>>    - EPOLLONESHOT is handled.
>>>> 
>>>> This series introduces pollable epoll from userspace, i.e. user
>>>> creates
>>>> epfd with a new EPOLL_USERPOLL flag, mmaps epoll descriptor, gets
>>>> header
>>>> and ring pointers and then consumes ready events from a ring, 
>>>> avoiding
>>>> epoll_wait() call.  When ring is empty, user has to call 
>>>> epoll_wait()
>>>> in order to wait for new events.  epoll_wait() returns -ESTALE if 
>>>> user
>>>> ring has events in the ring (kind of indication, that user has to
>>>> consume
>>>> events from the user ring first, I could not invent anything better
>>>> than
>>>> returning -ESTALE).
>>>> 
>>>> For user header and user ring allocation I used vmalloc_user().  I
>>>> found
>>>> that it is much easy to reuse remap_vmalloc_range_partial() instead 
>>>> of
>>>> dealing with page cache (like aio.c does).  What is also nice is 
>>>> that
>>>> virtual address is properly aligned on SHMLBA, thus there should not
>>>> be
>>>> any d-cache aliasing problems on archs with vivt or vipt caches.
>>> 
>>> Why aren't we just adding support to io_uring for this instead? Then 
>>> we
>>> don't need yet another entirely new ring, that's is just a little
>>> different from what we have.
>>> 
>>> I haven't looked into the details of your implementation, just 
>>> curious
>>> if there's anything that makes using io_uring a non-starter for this
>>> purpose?
>> 
>> Afaict the main difference is that you do not need to recharge an fd
>> (submit new poll request in terms of io_uring): once fd has been added
>> to
>> epoll with epoll_ctl() - we get events.  When you have thousands of 
>> fds
>> -
>> that should matter.
>> 
>> Also interesting question is how difficult to modify existing event
>> loops
>> in event libraries in order to support recharging (EPOLLONESHOT in 
>> terms
>> of epoll).
>> 
>> Maybe Azat who maintains libevent can shed light on this (currently I
>> see
>> that libevent does not support "EPOLLONESHOT" logic).
> 
> In terms of existing io_uring poll support, which is what I'm guessing
> you're referring to, it is indeed just one-shot.

Yes, yes.

> But there's no reason  why we can't have it persist until explicitly
> canceled with POLL_REMOVE.

It seems not so easy.  The main problem is that with only a ring it is
impossible to figure out on kernel side what event bits have been 
already
seen by the userspace and what bits are new.  So every new cqe has to
be added to a completion ring on each wake_up_interruptible() call.
(I mean when fd wants to report that something is ready).

IMO that can lead to many duplicate events (tens? hundreds? honestly no
idea), which userspace has to handle with subsequent read/write calls.
It can kill all performance benefits of a uring.

In uepoll this is solved with another piece of shared memory, where
userspace atomically clears bits and kernel side sets bits.  If kernel
observes that bits were set (i.e. userspace has not seen this event)
- new index is added to a ring.

Can we extend the io_uring API to support this behavior?  Also would
be great if we can make event path lockless.  On a big number of fds
and frequent events - this matters, please take a look, recently I
did some measurements:  https://lkml.org/lkml/2018/12/12/305

--
Roman

