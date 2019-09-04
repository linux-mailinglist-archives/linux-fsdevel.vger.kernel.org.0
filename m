Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 788DFA81D1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 14:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfIDMCs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Sep 2019 08:02:48 -0400
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127]:22484 "EHLO
        mx0b-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725965AbfIDMCs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Sep 2019 08:02:48 -0400
Received: from pps.filterd (m0050102.ppops.net [127.0.0.1])
        by m0050102.ppops.net-00190b01. (8.16.0.42/8.16.0.42) with SMTP id x84C2Z5H032625;
        Wed, 4 Sep 2019 13:02:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=V9/3e5gJQjgeuPpDdnqDwnlbylICVQ3lV6JtCdSgcOI=;
 b=TRtk1xKHKdb8hUbbI7IOM9hebKzgCN1Jw0IQmVP6Cqhf27TlADYdTncGse9uK3v8GhpZ
 duql6WuW7Sz/gOgOIW4pZJz+W9kQ3UL/ydG3npcNs1eGJTpFTqVi5Ai/anIT6ZWhpdOj
 sB0o7+9Hq4cmh6BoewHmSBnjqll5OhSycMG5vfdrhmAHEt8hfHvMTpE3oFo6q5ZH/6lr
 jQ0xRxBFFNfRkfqS7jgrqZ6PcGmlmEILfVKVQlBRNElTJTTXbNyGzv0A8HCZyIPpQhh3
 4MB8azQGnExwWD2GtvgljY8pnXnMZjzE6S+tM9VQv3fn+xooBeR+FhuCUlc72Dza4PX4 Cg== 
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60] (may be forged))
        by m0050102.ppops.net-00190b01. with ESMTP id 2uqdye3d7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Sep 2019 13:02:35 +0100
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
        by prod-mail-ppoint5.akamai.com (8.16.0.27/8.16.0.27) with SMTP id x84Bkukb022640;
        Wed, 4 Sep 2019 05:02:34 -0700
Received: from prod-mail-relay10.akamai.com ([172.27.118.251])
        by prod-mail-ppoint5.akamai.com with ESMTP id 2uqpv8ekkh-1;
        Wed, 04 Sep 2019 05:02:34 -0700
Received: from [0.0.0.0] (prod-ssh-gw01.bos01.corp.akamai.com [172.27.119.138])
        by prod-mail-relay10.akamai.com (Postfix) with ESMTP id D65481FCAE;
        Wed,  4 Sep 2019 12:02:33 +0000 (GMT)
Subject: Re: [PATCH RESEND] fs/epoll: fix the edge-triggered mode for nested
 epoll
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     hev <r@hev.cc>, linux-fsdevel@vger.kernel.org, e@80x24.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davide Libenzi <davidel@xmailserver.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sridhar Samudrala <sridhar.samudrala@intel.com>,
        linux-kernel@vger.kernel.org
References: <20190902052034.16423-1-r@hev.cc>
 <0cdc9905efb9b77b159e09bee17d3ad4@suse.de>
 <7075dd44-feea-a52f-ddaa-087d7bb2c4f6@akamai.com>
 <23659bc3e5f80efe9746aefd4d6791e8@suse.de>
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <341df9eb-7e8e-98c8-5183-402bdfff7d59@akamai.com>
Date:   Wed, 4 Sep 2019 08:02:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <23659bc3e5f80efe9746aefd4d6791e8@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-04_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909040121
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-04_03:2019-09-03,2019-09-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 clxscore=1015 mlxscore=0
 adultscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1909040124
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/4/19 5:57 AM, Roman Penyaev wrote:
> On 2019-09-03 23:08, Jason Baron wrote:
>> On 9/2/19 11:36 AM, Roman Penyaev wrote:
>>> Hi,
>>>
>>> This is indeed a bug. (quick side note: could you please remove efd[1]
>>> from your test, because it is not related to the reproduction of a
>>> current bug).
>>>
>>> Your patch lacks a good description, what exactly you've fixed.  Let
>>> me speak out loud and please correct me if I'm wrong, my understanding
>>> of epoll internals has become a bit rusty: when epoll fds are nested
>>> an attempt to harvest events (ep_scan_ready_list() call) produces a
>>> second (repeated) event from an internal fd up to an external fd:
>>>
>>>      epoll_wait(efd[0], ...):
>>>        ep_send_events():
>>>           ep_scan_ready_list(depth=0):
>>>             ep_send_events_proc():
>>>                 ep_item_poll():
>>>                   ep_scan_ready_list(depth=1):
>>>                     ep_poll_safewake():
>>>                       ep_poll_callback()
>>>                         list_add_tail(&epi, &epi->rdllist);
>>>                         ^^^^^^
>>>                         repeated event
>>>
>>>
>>> In your patch you forbid wakeup for the cases, where depth != 0, i.e.
>>> for all nested cases. That seems clear.  But what if we can go further
>>> and remove the whole chunk, which seems excessive:
>>>
>>> @@ -885,26 +886,11 @@ static __poll_t ep_scan_ready_list(struct
>>> eventpoll *ep,
>>>
>>> -
>>> -       if (!list_empty(&ep->rdllist)) {
>>> -               /*
>>> -                * Wake up (if active) both the eventpoll wait list and
>>> -                * the ->poll() wait list (delayed after we release the
>>> lock).
>>> -                */
>>> -               if (waitqueue_active(&ep->wq))
>>> -                       wake_up(&ep->wq);
>>> -               if (waitqueue_active(&ep->poll_wait))
>>> -                       pwake++;
>>> -       }
>>>         write_unlock_irq(&ep->lock);
>>>
>>>         if (!ep_locked)
>>>                 mutex_unlock(&ep->mtx);
>>>
>>> -       /* We have to call this outside the lock */
>>> -       if (pwake)
>>> -               ep_poll_safewake(&ep->poll_wait);
>>>
>>>
>>> I reason like that: by the time we've reached the point of scanning events
>>> for readiness all wakeups from ep_poll_callback have been already fired and
>>> new events have been already accounted in ready list (ep_poll_callback()
>>> calls
>>> the same ep_poll_safewake()). Here, frankly, I'm not 100% sure and probably
>>> missing some corner cases.
>>>
>>> Thoughts?
>>
>> So the: 'wake_up(&ep->wq);' part, I think is about waking up other
>> threads that may be in waiting in epoll_wait(). For example, there may
>> be multiple threads doing epoll_wait() on the same epoll fd, and the
>> logic above seems to say thread 1 may have processed say N events and
>> now its going to to go off to work those, so let's wake up thread 2 now
>> to handle the next chunk.
> 
> Not quite. Thread which calls ep_scan_ready_list() processes all the
> events, and while processing those, removes them one by one from the
> ready list.  But if event mask is !0 and event belongs to
> Level Triggered Mode descriptor (let's say default mode) it tails event
> again back to the list (because we are in level mode, so event should
> be there).  So at the end of this traversing loop ready list is likely
> not empty, and if so, wake up again is called for nested epoll fds.
> But, those nested epoll fds should get already all the notifications
> from the main event callback ep_poll_callback(), regardless any thread
> which traverses events.
> 
> I suppose this logic exists for decades, when Davide (the author) was
> reshuffling the code here and there.
> 
> But I do not feel confidence to state that this extra wakeup is bogus,
> I just have a gut feeling that it looks excessive.

Note that I was talking about the wakeup done on ep->wq not ep->poll_wait.
The path that I'm concerned about is let's say that there are N events
queued on the ready list. A thread that was woken up in epoll_wait may
decide to only process say N/2 of then. Then it will call wakeup on ep->wq
and this will wakeup another thread to process the remaining N/2. Without
the wakeup, the original thread isn't going to process the events until
it finishes with the original N/2 and gets back to epoll_wait(). So I'm not
sure how important that path is but I wanted to at least note the change
here would impact that behavior.

Thanks,

-Jason


> 
>> So I think removing all that even for the
>> depth 0 case is going to change some behavior here. So perhaps, it
>> should be removed for all depths except for 0? And if so, it may be
>> better to make 2 patches here to separate these changes.
>>
>> For the nested wakeups, I agree that the extra wakeups seem unnecessary
>> and it may make sense to remove them for all depths. I don't think the
>> nested epoll semantics are particularly well spelled out, and afaict,
>> nested epoll() has behaved this way for quite some time. And the current
>> behavior is not bad in the way that a missing wakeup or false negative
>> would be.
> 
> That's 100% true! For edge mode extra wake up is not a bug, not optimal
> for userspace - yes, but that can't lead to any lost wakeups.
> 
> -- 
> Roman
> 
