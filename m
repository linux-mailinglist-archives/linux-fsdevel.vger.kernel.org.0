Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5278331505
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 20:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfEaS6V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 14:58:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:49128 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726439AbfEaS6U (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 14:58:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8C600AEA3;
        Fri, 31 May 2019 18:58:19 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 31 May 2019 20:58:19 +0200
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     azat@libevent.org, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/13] epoll: introduce helpers for adding/removing
 events to uring
In-Reply-To: <20190531165144.GE2606@hirez.programming.kicks-ass.net>
References: <20190516085810.31077-1-rpenyaev@suse.de>
 <20190516085810.31077-7-rpenyaev@suse.de>
 <20190531095607.GC17637@hirez.programming.kicks-ass.net>
 <274e29d102133f3be1f309c66cb0af36@suse.de>
 <20190531125636.GZ2606@hirez.programming.kicks-ass.net>
 <98e74ceeefdffc9b50fb33e597d270f7@suse.de>
 <20190531165144.GE2606@hirez.programming.kicks-ass.net>
Message-ID: <9e13f80872e5b6c96e9cd3343e27b1f1@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-05-31 18:51, Peter Zijlstra wrote:
> On Fri, May 31, 2019 at 04:21:30PM +0200, Roman Penyaev wrote:
> 
>> The ep_add_event_to_uring() is lockless, thus I can't increase tail 
>> after,
>> I need to reserve the index slot, where to write to.  I can use shadow 
>> tail,
>> which is not seen by userspace, but I have to guarantee that tail is 
>> updated
>> with shadow tail *after* all callers of ep_add_event_to_uring() are 
>> left.
>> That is possible, please see the code below, but it adds more 
>> complexity:
>> 
>> (code was tested on user side, thus has c11 atomics)
>> 
>> static inline void add_event__kernel(struct ring *ring, unsigned bit)
>> {
>>         unsigned i, cntr, commit_cntr, *item_idx, tail, old;
>> 
>>         i = __atomic_fetch_add(&ring->cntr, 1, __ATOMIC_ACQUIRE);
>>         item_idx = &ring->user_itemsindex[i % ring->nr];
>> 
>>         /* Update data */
>>         *item_idx = bit;
>> 
>>         commit_cntr = __atomic_add_fetch(&ring->commit_cntr, 1,
>> __ATOMIC_RELEASE);
>> 
>>         tail = ring->user_header->tail;
>>         rmb();
>>         do {
>>                 cntr = ring->cntr;
>>                 if (cntr != commit_cntr)
>>                         /* Someone else will advance tail */
>>                         break;
>> 
>>                 old = tail;
>> 
>>         } while ((tail =
>> __sync_val_compare_and_swap(&ring->user_header->tail, old, cntr)) != 
>> old);
>> }
> 
> Yes, I'm well aware of that particular problem (see
> kernel/events/ring_buffer.c:perf_output_put_handle for instance).

I'll take a look, thanks.

> But like you show, it can be done. It also makes the thing wait-free, 
> as
> opposed to merely lockless.

You think it's better?  I did not like this variant from the very
beginning because of the unnecessary complexity.  But maybe you're
right.  No busy loops on user side makes it wait-free.  And also
I can avoid c11 in kernel using cmpxchg along with atomic_t.

--
Roman


