Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA8876D938
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 23:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjHBVKM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 17:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjHBVKK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 17:10:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D90626B6
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 14:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691010558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QQAGfU5e9UTA0c2sotTEgDofXJonpv1BnUJnwBpzohg=;
        b=ZJUdCMVJmTVNJX4/QKLhjh0bDXMj23eRbUVhtJOvzl0C0D6s0/QpR8b/HZsAxGs/hqFj3m
        0zIiCe+9ewXYt/L+/3UA11hK0CZCplNBKyYGJ28oxH8GM4wL54moPMXTflt4f4EP1f86QI
        GpSxh2/ijJM7f+3anq1+2g3ympz1R9w=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-xCq9QaxjOpaGZo2TxAhhug-1; Wed, 02 Aug 2023 17:09:15 -0400
X-MC-Unique: xCq9QaxjOpaGZo2TxAhhug-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6DB513C0219A;
        Wed,  2 Aug 2023 21:09:14 +0000 (UTC)
Received: from [10.22.18.41] (unknown [10.22.18.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 10083F7FB0;
        Wed,  2 Aug 2023 21:09:14 +0000 (UTC)
Message-ID: <11d39248-31fc-c625-7c06-341f0146bd67@redhat.com>
Date:   Wed, 2 Aug 2023 17:09:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 11/20] locking/osq: Export osq_(lock|unlock)
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
References: <20230712211115.2174650-1-kent.overstreet@linux.dev>
 <20230712211115.2174650-12-kent.overstreet@linux.dev>
 <bb77f456-8804-b63a-7868-19e0cd9e697f@redhat.com>
 <20230802204407.lk5mnj7ua6idddbd@moria.home.lan>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230802204407.lk5mnj7ua6idddbd@moria.home.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/2/23 16:44, Kent Overstreet wrote:
> On Wed, Aug 02, 2023 at 04:16:12PM -0400, Waiman Long wrote:
>> On 7/12/23 17:11, Kent Overstreet wrote:
>>> These are used by bcachefs's six locks.
>>>
>>> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Cc: Ingo Molnar <mingo@redhat.com>
>>> Cc: Waiman Long <longman@redhat.com>
>>> Cc: Boqun Feng <boqun.feng@gmail.com>
>>> ---
>>>    kernel/locking/osq_lock.c | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
>>> index d5610ad52b..b752ec5cc6 100644
>>> --- a/kernel/locking/osq_lock.c
>>> +++ b/kernel/locking/osq_lock.c
>>> @@ -203,6 +203,7 @@ bool osq_lock(struct optimistic_spin_queue *lock)
>>>    	return false;
>>>    }
>>> +EXPORT_SYMBOL_GPL(osq_lock);
>>>    void osq_unlock(struct optimistic_spin_queue *lock)
>>>    {
>>> @@ -230,3 +231,4 @@ void osq_unlock(struct optimistic_spin_queue *lock)
>>>    	if (next)
>>>    		WRITE_ONCE(next->locked, 1);
>>>    }
>>> +EXPORT_SYMBOL_GPL(osq_unlock);
>> Have you considered extending the current rw_semaphore to support a SIX lock
>> semantics? There are a number of instances in the kernel that a up_read() is
>> followed by a down_write(). Basically, the code try to upgrade the lock from
>> read to write. I have been thinking about adding a upgrade_read() API to do
>> that. However, the concern that I had was that another writer may come in
>> and make modification before the reader can be upgraded to have exclusive
>> write access and will make the task to repeat what has been done in the read
>> lock part. By adding a read with intent to upgrade to write, we can have
>> that guarantee.
> It's been discussed, Linus had the same thought.
>
> But it'd be a massive change to the rw semaphore code; this "read with
> intent" really is a third lock state which needs all the same
> lock/trylock/unlock paths, and with the way rw semaphore has separate
> entry points for read and write it'd be a _ton_ of new code. It really
> touches everything - waitlist handling included.

Yes, it is a major change, but I had done that before and it is 
certainly doable. There are spare bits in the low byte of rwsem->count 
that can be used as an intent bit. We also need to add a new 
rwsem_wake_type for that for waitlist handling.


>
> And six locks have several other features that bcachefs needs, and other
> users may also end up wanting, that rw semaphores don't have; the two
> main features being a percpu read lock mode and support for an external
> cycle detector (which requires exposing lock waitlists, with some
> guarantees about how those waitlists are used).

Can you provide more information about those features?

>
>> With that said, I would prefer to keep osq_{lock/unlock} for internal use by
>> some higher level locking primitives - mutex, rwsem and rt_mutex.
> Yeah, I'm aware, but it seems like exposing osq_(lock|unlock) is the
> most palatable solution for now. Long term, I'd like to get six locks
> promoted to kernel/locking.

Your SIX overlaps with rwsem in term of features. So we will have to 
somehow merge them instead of having 2 APIs with somewhat similar 
functionality.

Cheers,
Longman

>

