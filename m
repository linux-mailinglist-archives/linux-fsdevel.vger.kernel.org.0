Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF8030D47
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 13:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfEaLW4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 07:22:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:51444 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726002AbfEaLW4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 07:22:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 09B2EAD05;
        Fri, 31 May 2019 11:22:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 31 May 2019 13:22:54 +0200
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     azat@libevent.org, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/13] epoll: call ep_add_event_to_uring() from
 ep_poll_callback()
In-Reply-To: <20190531095616.GD17637@hirez.programming.kicks-ass.net>
References: <20190516085810.31077-1-rpenyaev@suse.de>
 <20190516085810.31077-8-rpenyaev@suse.de>
 <20190531095616.GD17637@hirez.programming.kicks-ass.net>
Message-ID: <98971429dc36e8a2e3417af1744de2b2@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-05-31 11:56, Peter Zijlstra wrote:
> On Thu, May 16, 2019 at 10:58:04AM +0200, Roman Penyaev wrote:
>> Each ep_poll_callback() is called when fd calls wakeup() on epfd.
>> So account new event in user ring.
>> 
>> The tricky part here is EPOLLONESHOT.  Since we are lockless we
>> have to be deal with ep_poll_callbacks() called in paralle, thus
>> use cmpxchg to clear public event bits and filter out concurrent
>> call from another cpu.
>> 
>> Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Al Viro <viro@zeniv.linux.org.uk>
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>> Cc: linux-fsdevel@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> 
>> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
>> index 2f551c005640..55612da9651e 100644
>> --- a/fs/eventpoll.c
>> +++ b/fs/eventpoll.c
>> @@ -1407,6 +1407,29 @@ struct file *get_epoll_tfile_raw_ptr(struct 
>> file *file, int tfd,
>>  }
>>  #endif /* CONFIG_CHECKPOINT_RESTORE */
>> 
>> +/**
>> + * Atomically clear public event bits and return %true if the old 
>> value has
>> + * public event bits set.
>> + */
>> +static inline bool ep_clear_public_event_bits(struct epitem *epi)
>> +{
>> +	__poll_t old, flags;
>> +
>> +	/*
>> +	 * Here we race with ourselves and with ep_modify(), which can
>> +	 * change the event bits.  In order not to override events updated
>> +	 * by ep_modify() we have to do cmpxchg.
>> +	 */
>> +
>> +	old = epi->event.events;
>> +	do {
>> +		flags = old;
>> +	} while ((old = cmpxchg(&epi->event.events, flags,
>> +				flags & EP_PRIVATE_BITS)) != flags);
>> +
>> +	return flags & ~EP_PRIVATE_BITS;
>> +}
> 
> AFAICT epi->event.events also has normal writes to it, eg. in
> ep_modify(). A number of architectures cannot handle concurrent normal
> writes and cmpxchg() to the same variable.

Yes, we race with the current function and with ep_modify().  Then, 
ep_modify()
should do something as the following:

-	epi->event.events = event->events
+	xchg(&epi->event.events, event->events);

Is that ok?

Just curious: what are these archs?

Thanks.

--
Roman



