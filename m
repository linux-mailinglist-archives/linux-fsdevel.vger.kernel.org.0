Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AADE1583B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2020 20:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgBJTbi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 14:31:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:47864 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727003AbgBJTbh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 14:31:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 120E6AFB2;
        Mon, 10 Feb 2020 19:31:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 10 Feb 2020 20:31:34 +0100
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Jason Baron <jbaron@akamai.com>
Cc:     Max Neunhoeffer <max@arangodb.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Christopher Kohlhoff <chris.kohlhoff@clearpool.io>,
        Davidlohr Bueso <dbueso@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] epoll: ep->wq can be woken up unlocked in certain
 cases
In-Reply-To: <ce0d0c49-7d62-3a5d-7bc7-5b72611f1867@akamai.com>
References: <20200210094123.389854-1-rpenyaev@suse.de>
 <20200210094123.389854-2-rpenyaev@suse.de>
 <ce0d0c49-7d62-3a5d-7bc7-5b72611f1867@akamai.com>
Message-ID: <759221a1a1a7b36c47011fa05bba20df@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-02-10 19:16, Jason Baron wrote:
> On 2/10/20 4:41 AM, Roman Penyaev wrote:
>> Now ep->lock is responsible for wqueue serialization, thus if ep->lock
>> is taken on write path, wake_up_locked() can be invoked.
>> 
>> Though, read path is different.  Since concurrent cpus can enter the
>> wake up function it needs to be internally serialized, thus wake_up()
>> variant is used which implies internal spin lock.
>> 
>> Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
>> Cc: Max Neunhoeffer <max@arangodb.com>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: Christopher Kohlhoff <chris.kohlhoff@clearpool.io>
>> Cc: Davidlohr Bueso <dbueso@suse.de>
>> Cc: Jason Baron <jbaron@akamai.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: linux-fsdevel@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>  Nothing interesting in v2:
>>      changed the comment a bit
>> 
>>  fs/eventpoll.c | 12 +++++++++---
>>  1 file changed, 9 insertions(+), 3 deletions(-)
>> 
>> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
>> index eee3c92a9ebf..6e218234bd4a 100644
>> --- a/fs/eventpoll.c
>> +++ b/fs/eventpoll.c
>> @@ -1173,7 +1173,7 @@ static inline bool chain_epi_lockless(struct 
>> epitem *epi)
>>   * Another thing worth to mention is that ep_poll_callback() can be 
>> called
>>   * concurrently for the same @epi from different CPUs if poll table 
>> was inited
>>   * with several wait queues entries.  Plural wakeup from different 
>> CPUs of a
>> - * single wait queue is serialized by wq.lock, but the case when 
>> multiple wait
>> + * single wait queue is serialized by ep->lock, but the case when 
>> multiple wait
>>   * queues are used should be detected accordingly.  This is detected 
>> using
>>   * cmpxchg() operation.
>>   */
>> @@ -1248,6 +1248,12 @@ static int ep_poll_callback(wait_queue_entry_t 
>> *wait, unsigned mode, int sync, v
>>  				break;
>>  			}
>>  		}
>> +		/*
>> +		 * Since here we have the read lock (ep->lock) taken, plural
>> +		 * wakeup from different CPUs can occur, thus we call wake_up()
>> +		 * variant which implies its own lock on wqueue. All other paths
>> +		 * take write lock.
>> +		 */
>>  		wake_up(&ep->wq);
>>  	}
>>  	if (waitqueue_active(&ep->poll_wait))
>> @@ -1551,7 +1557,7 @@ static int ep_insert(struct eventpoll *ep, const 
>> struct epoll_event *event,
>> 
>>  		/* Notify waiting tasks that events are available */
>>  		if (waitqueue_active(&ep->wq))
>> -			wake_up(&ep->wq);
>> +			wake_up_locked(&ep->wq);
> 
> 
> So I think this will now hit the 'lockdep_assert_held()' in
> __wake_up_common()? I agree that its correct, but I think it will
> confuse lockdep here...

Argh! True. And I do not see any neat way to shut up lockdep here
(Calling lock_acquire() manually seems not an option for such minor
thing).

Then this optimization is not needed, patch is cancelled.

Thanks for noting that.

--
Roman

