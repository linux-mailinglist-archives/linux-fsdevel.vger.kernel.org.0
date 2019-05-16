Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE623201E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 10:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfEPI7Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 04:59:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:34894 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726383AbfEPI60 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 04:58:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 60C54AE8A;
        Thu, 16 May 2019 08:58:24 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Azat Khuzhin <azat@libevent.org>, Roman Penyaev <rpenyaev@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/13] epoll: support pollable epoll from userspace
Date:   Thu, 16 May 2019 10:57:57 +0200
Message-Id: <20190516085810.31077-1-rpenyaev@suse.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

This is v3 which introduces pollable epoll from userspace.

v3:
 - Measurements made, represented below.

 - Fix alignment for epoll_uitem structure on all 64-bit archs except
   x86-64. epoll_uitem should be always 16 bit, proper BUILD_BUG_ON
   is added. (Linus)

 - Check pollflags explicitly on 0 inside work callback, and do nothing
   if 0.

v2:
 - No reallocations, the max number of items (thus size of the user ring)
   is specified by the caller.

 - Interface is simplified: -ENOSPC is returned on attempt to add a new
   epoll item if number is reached the max, nothing more.

 - Alloced pages are accounted using user->locked_vm and limited to
   RLIMIT_MEMLOCK value.

 - EPOLLONESHOT is handled.

This series introduces pollable epoll from userspace, i.e. user creates
epfd with a new EPOLL_USERPOLL flag, mmaps epoll descriptor, gets header
and ring pointers and then consumes ready events from a ring, avoiding
epoll_wait() call.  When ring is empty, user has to call epoll_wait()
in order to wait for new events.  epoll_wait() returns -ESTALE if user
ring has events in the ring (kind of indication, that user has to consume
events from the user ring first, I could not invent anything better than
returning -ESTALE).

For user header and user ring allocation I used vmalloc_user().  I found
that it is much easy to reuse remap_vmalloc_range_partial() instead of
dealing with page cache (like aio.c does).  What is also nice is that
virtual address is properly aligned on SHMLBA, thus there should not be
any d-cache aliasing problems on archs with vivt or vipt caches.

** Measurements

In order to measure polling from userspace libevent was modified [1] and
bench_http benchmark (client and server) was used:

 o EPOLLET, original epoll:

    20000 requests in 0.551306 sec. (36277.49 throughput)
    Each took about 5.54 msec latency
    1600000bytes read. 0 errors.

 o EPOLLET + polling from userspace:

    20000 requests in 0.475585 sec. (42053.47 throughput)
    Each took about 4.78 msec latency
    1600000bytes read. 0 errors.

So harvesting events from userspace gives 15% gain.  Though bench_http
is not ideal benchmark, but at least it is the part of libevent and was
easy to modify.

Worth to mention that uepoll is very sensible to CPU, e.g. the gain above
is observed on desktop "Intel(R) Core(TM) i7-6820HQ CPU @ 2.70GHz", but on
"Intel(R) Xeon(R) Silver 4110 CPU @ 2.10GHz" measurements are almost the
same for both runs.

** Limitations
    
1. Expect always EPOLLET flag for new epoll items (Edge Triggered behavior)
     obviously we can't call vfs_epoll() from userpace to have level
     triggered behaviour.
    
2. No support for EPOLLWAKEUP
     events are consumed from userspace, thus no way to call __pm_relax()
    
3. No support for EPOLLEXCLUSIVE
     If device does not pass pollflags to wake_up() there is no way to
     call poll() from the context under spinlock, thus special work is
     scheduled to offload polling.  In this specific case we can't
     support exclusive wakeups, because we do not know actual result
     of scheduled work and have to wake up every waiter.

** Principle of operation

* Basic structures shared with userspace:

In order to consume events from userspace all inserted items should be
stored in items array, which has original epoll_event field and u32
field for keeping ready events, i.e. each item has the following struct:

 struct epoll_uitem {
    __poll_t ready_events;
    struct epoll_event event;
 };
 BUILD_BUG_ON(sizeof(struct epoll_uitem) != 16);

And the following is a header, which is seen by userspace:

 struct epoll_uheader {
    u32 magic;          /* epoll user header magic */
    u32 header_length;  /* length of the header + items */
    u32 index_length;   /* length of the index ring, always pow2 */
    u32 max_items_nr;   /* max num of items */
    u32 head;           /* updated by userland */
    u32 int tail;       /* updated by kernel */

	struct epoll_uitem items[] __aligned(128);
 };

 /* Header is 128 bytes, thus items are aligned on CPU cache */
 BUILD_BUG_ON(sizeof(struct epoll_uheader) != 128);

In order to poll epfd from userspace application has to call:

   epoll_create2(EPOLL_USERPOLL, max_items_nr);

Ready events are kept in a ring buffer, which is simply an index table,
where each element points to an item in a header:

 unsinged int *user_index;

* How is new event accounted on kernel side?  Hot it is consumed from
* userspace?

When new event comes for some epoll item kernel does the following:

 struct epoll_uitem *uitem;

 /* Each item has a bit (index in user items array), discussed later */
 uitem = user_header->items[epi->bit];

 if (!atomic_fetch_or(uitem->ready_events, pollflags)) {
     i = atomic_add(&ep->user_header->tail, 1);

     item_idx = &user_index[i & index_mask];

     /* Signal with a bit, user spins on index expecting value > 0 */
     *item_idx = idx + 1;

    /*
     * Want index update be flushed from CPU write buffer and
     * immediately visible on userspace side to avoid long busy
     * loops.
     */
     smp_wmb();
 }

Important thing here is that ring can't infinitely grow and corrupt other
elements, because kernel always checks that item was marked as ready, so
userspace has to clear ready_events field.

On userside events the following code should be used in order to consume
events:

 tail = READ_ONCE(header->tail);
 for (i = 0; header->head != tail; header->head++) {
     item_idx_ptr = &index[idx & indeces_mask];

     /*
      * Spin here till we see valid index
      */
     while (!(idx = __atomic_load_n(item_idx_ptr, __ATOMIC_ACQUIRE)))
         ;

     item = &header->items[idx - 1];

     /*
      * Mark index as invalid, that is for userspace only, kernel does not care
      * and will refill this pointer only when observes that event is cleared,
      * which happens below.
      */
     *item_idx_ptr = 0;

     /*
      * Fetch data first, if event is cleared by the kernel we drop the data
      * returning false.
      */
     event->data = item->event.data;
     event->events = __atomic_exchange_n(&item->ready_events, 0,
                         __ATOMIC_RELEASE);

 }

* How new epoll item gets its index inside user items array?

Kernel has a bitmap for that and gets free bit on attempt to insert a new
epoll item.  When bitmap is full -ENOSPC is returned.

* Is there any testing app available?

There is a small app [2] which starts many threads with many event fds and
produces many events, while single consumer fetches them from userspace
and goes to kernel from time to time in order to wait.

[1] https://github.com/libevent/libevent/pull/801
[2] https://github.com/rouming/test-tools/blob/master/userpolled-epoll.c


Roman Penyaev (13):
  epoll: move private helpers from a header to the source
  epoll: introduce user structures for polling from userspace
  epoll: allocate user header and user events ring for polling from
    userspace
  epoll: some sanity flags checks for epoll syscalls for polling from
    userspace
  epoll: offload polling to a work in case of epfd polled from userspace
  epoll: introduce helpers for adding/removing events to uring
  epoll: call ep_add_event_to_uring() from ep_poll_callback()
  epoll: support polling from userspace for ep_insert()
  epoll: support polling from userspace for ep_remove()
  epoll: support polling from userspace for ep_modify()
  epoll: support polling from userspace for ep_poll()
  epoll: support mapping for epfd when polled from userspace
  epoll: implement epoll_create2() syscall

 arch/x86/entry/syscalls/syscall_32.tbl |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 fs/eventpoll.c                         | 714 ++++++++++++++++++++++---
 include/linux/syscalls.h               |   1 +
 include/uapi/asm-generic/unistd.h      |   4 +-
 include/uapi/linux/eventpoll.h         |  46 +-
 kernel/sys_ni.c                        |   1 +
 7 files changed, 669 insertions(+), 99 deletions(-)

Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
-- 
2.21.0

