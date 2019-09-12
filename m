Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48B30B15E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 23:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbfILVhc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 17:37:32 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:41018 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728630AbfILVhb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 17:37:31 -0400
Received: from pps.filterd (m0122332.ppops.net [127.0.0.1])
        by mx0a-00190b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8CLM1cU007332;
        Thu, 12 Sep 2019 22:37:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=euhEg/mbs+WcguSgE16Vn0LdaCX/L5nyr5rgMtyjdiw=;
 b=aJrYwOHSAy9gKZh11Iwbs88b113Pb93hJC6lplkQYwMAsmPEsgsalwVVL+E0Wr1tJ2Gs
 pqYNeRnT2a9gjo00E4mWRkRyALiBdLxwsOpXpMOmF5g3yGhkZZKKCKt3Upm1fLy9EIxV
 iOSyqWqi7DnVxGa4dtYs1qpIA5dqKylPuWSJrkN4QcB2AjDDNiHFv4oCR4nXYa1YEgwY
 8s3hzCxX1ZW6nRSd+XvsDqEpBqODolK7Cv5z0cbq2zMwDb/T9R3qYt9EZ424S5mskJQ2
 u2w6S9rqJloKrDcJLZhAdkx8QxPCK3cVuFo183rK2fUrxShNQFhn1MdhFqVz+a682VTf pw== 
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61] (may be forged))
        by mx0a-00190b01.pphosted.com with ESMTP id 2uytck8w68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Sep 2019 22:37:14 +0100
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
        by prod-mail-ppoint6.akamai.com (8.16.0.27/8.16.0.27) with SMTP id x8CLW3hb003903;
        Thu, 12 Sep 2019 17:37:13 -0400
Received: from prod-mail-relay10.akamai.com ([172.27.118.251])
        by prod-mail-ppoint6.akamai.com with ESMTP id 2uyth10ady-1;
        Thu, 12 Sep 2019 17:37:13 -0400
Received: from [172.29.170.83] (bos-lpjec.kendall.corp.akamai.com [172.29.170.83])
        by prod-mail-relay10.akamai.com (Postfix) with ESMTP id 58A221FCDB;
        Thu, 12 Sep 2019 21:37:13 +0000 (GMT)
Subject: Re: [PATCH RESEND] fs/epoll: fix the edge-triggered mode for nested
 epoll
To:     Heiher <r@hev.cc>
Cc:     Roman Penyaev <rpenyaev@suse.de>, linux-fsdevel@vger.kernel.org,
        Eric Wong <e@80x24.org>, Al Viro <viro@zeniv.linux.org.uk>,
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
 <341df9eb-7e8e-98c8-5183-402bdfff7d59@akamai.com>
 <CAHirt9hra2tA_OPNSow+CgD_CF2Z11ZqGG=1P45noqtdMtWuJw@mail.gmail.com>
 <CAHirt9j+DSR+uP-SBLHn0ika86uixSOPLXft+vVj5G5Ge0xr5w@mail.gmail.com>
 <CAHirt9iZAj67FVnhd9ORp2Sk2xAXHDrJ2BANf4VrtM4dLWv9ww@mail.gmail.com>
 <d5914273597707b8780d188688fe0ac2@suse.de>
 <6fd44437-fdd8-3be3-a2ef-6c3534d4e954@akamai.com>
 <CAHirt9gtCssDsS6NjfxSociPObL6vwL7ygCWjgZZYegsUt4YOg@mail.gmail.com>
From:   Jason Baron <jbaron@akamai.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jbaron@akamai.com; prefer-encrypt=mutual; keydata=
 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
 JeQ7iQ==
Message-ID: <7bb91058-eee8-d0c5-c4b3-e3f6cbda8c0b@akamai.com>
Date:   Thu, 12 Sep 2019 17:36:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHirt9gtCssDsS6NjfxSociPObL6vwL7ygCWjgZZYegsUt4YOg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-12_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909120218
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-12_12:2019-09-11,2019-09-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1909120218
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/11/19 4:19 AM, Heiher wrote:
> Hi,
> 
> On Fri, Sep 6, 2019 at 1:48 AM Jason Baron <jbaron@akamai.com> wrote:
>>
>>
>>
>> On 9/5/19 1:27 PM, Roman Penyaev wrote:
>>> On 2019-09-05 11:56, Heiher wrote:
>>>> Hi,
>>>>
>>>> On Thu, Sep 5, 2019 at 10:53 AM Heiher <r@hev.cc> wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> I created an epoll wakeup test project, listed some possible cases,
>>>>> and any other corner cases needs to be added?
>>>>>
>>>>> https://github.com/heiher/epoll-wakeup/blob/master/README.md
>>>>>
>>>>> On Wed, Sep 4, 2019 at 10:02 PM Heiher <r@hev.cc> wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> On Wed, Sep 4, 2019 at 8:02 PM Jason Baron <jbaron@akamai.com> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 9/4/19 5:57 AM, Roman Penyaev wrote:
>>>>>>>> On 2019-09-03 23:08, Jason Baron wrote:
>>>>>>>>> On 9/2/19 11:36 AM, Roman Penyaev wrote:
>>>>>>>>>> Hi,
>>>>>>>>>>
>>>>>>>>>> This is indeed a bug. (quick side note: could you please
>>>>> remove efd[1]
>>>>>>>>>> from your test, because it is not related to the reproduction
>>>>> of a
>>>>>>>>>> current bug).
>>>>>>>>>>
>>>>>>>>>> Your patch lacks a good description, what exactly you've
>>>>> fixed.  Let
>>>>>>>>>> me speak out loud and please correct me if I'm wrong, my
>>>>> understanding
>>>>>>>>>> of epoll internals has become a bit rusty: when epoll fds are
>>>>> nested
>>>>>>>>>> an attempt to harvest events (ep_scan_ready_list() call)
>>>>> produces a
>>>>>>>>>> second (repeated) event from an internal fd up to an external
>>>>> fd:
>>>>>>>>>>
>>>>>>>>>>      epoll_wait(efd[0], ...):
>>>>>>>>>>        ep_send_events():
>>>>>>>>>>           ep_scan_ready_list(depth=0):
>>>>>>>>>>             ep_send_events_proc():
>>>>>>>>>>                 ep_item_poll():
>>>>>>>>>>                   ep_scan_ready_list(depth=1):
>>>>>>>>>>                     ep_poll_safewake():
>>>>>>>>>>                       ep_poll_callback()
>>>>>>>>>>                         list_add_tail(&epi, &epi->rdllist);
>>>>>>>>>>                         ^^^^^^
>>>>>>>>>>                         repeated event
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> In your patch you forbid wakeup for the cases, where depth !=
>>>>> 0, i.e.
>>>>>>>>>> for all nested cases. That seems clear.  But what if we can
>>>>> go further
>>>>>>>>>> and remove the whole chunk, which seems excessive:
>>>>>>>>>>
>>>>>>>>>> @@ -885,26 +886,11 @@ static __poll_t ep_scan_ready_list(struct
>>>>>>>>>> eventpoll *ep,
>>>>>>>>>>
>>>>>>>>>> -
>>>>>>>>>> -       if (!list_empty(&ep->rdllist)) {
>>>>>>>>>> -               /*
>>>>>>>>>> -                * Wake up (if active) both the eventpoll
>>>>> wait list and
>>>>>>>>>> -                * the ->poll() wait list (delayed after we
>>>>> release the
>>>>>>>>>> lock).
>>>>>>>>>> -                */
>>>>>>>>>> -               if (waitqueue_active(&ep->wq))
>>>>>>>>>> -                       wake_up(&ep->wq);
>>>>>>>>>> -               if (waitqueue_active(&ep->poll_wait))
>>>>>>>>>> -                       pwake++;
>>>>>>>>>> -       }
>>>>>>>>>>         write_unlock_irq(&ep->lock);
>>>>>>>>>>
>>>>>>>>>>         if (!ep_locked)
>>>>>>>>>>                 mutex_unlock(&ep->mtx);
>>>>>>>>>>
>>>>>>>>>> -       /* We have to call this outside the lock */
>>>>>>>>>> -       if (pwake)
>>>>>>>>>> -               ep_poll_safewake(&ep->poll_wait);
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> I reason like that: by the time we've reached the point of
>>>>> scanning events
>>>>>>>>>> for readiness all wakeups from ep_poll_callback have been
>>>>> already fired and
>>>>>>>>>> new events have been already accounted in ready list
>>>>> (ep_poll_callback()
>>>>>>>>>> calls
>>>>>>>>>> the same ep_poll_safewake()). Here, frankly, I'm not 100%
>>>>> sure and probably
>>>>>>>>>> missing some corner cases.
>>>>>>>>>>
>>>>>>>>>> Thoughts?
>>>>>>>>>
>>>>>>>>> So the: 'wake_up(&ep->wq);' part, I think is about waking up
>>>>> other
>>>>>>>>> threads that may be in waiting in epoll_wait(). For example,
>>>>> there may
>>>>>>>>> be multiple threads doing epoll_wait() on the same epoll fd,
>>>>> and the
>>>>>>>>> logic above seems to say thread 1 may have processed say N
>>>>> events and
>>>>>>>>> now its going to to go off to work those, so let's wake up
>>>>> thread 2 now
>>>>>>>>> to handle the next chunk.
>>>>>>>>
>>>>>>>> Not quite. Thread which calls ep_scan_ready_list() processes
>>>>> all the
>>>>>>>> events, and while processing those, removes them one by one
>>>>> from the
>>>>>>>> ready list.  But if event mask is !0 and event belongs to
>>>>>>>> Level Triggered Mode descriptor (let's say default mode) it
>>>>> tails event
>>>>>>>> again back to the list (because we are in level mode, so event
>>>>> should
>>>>>>>> be there).  So at the end of this traversing loop ready list is
>>>>> likely
>>>>>>>> not empty, and if so, wake up again is called for nested epoll
>>>>> fds.
>>>>>>>> But, those nested epoll fds should get already all the
>>>>> notifications
>>>>>>>> from the main event callback ep_poll_callback(), regardless any
>>>>> thread
>>>>>>>> which traverses events.
>>>>>>>>
>>>>>>>> I suppose this logic exists for decades, when Davide (the
>>>>> author) was
>>>>>>>> reshuffling the code here and there.
>>>>>>>>
>>>>>>>> But I do not feel confidence to state that this extra wakeup is
>>>>> bogus,
>>>>>>>> I just have a gut feeling that it looks excessive.
>>>>>>>
>>>>>>> Note that I was talking about the wakeup done on ep->wq not
>>>>> ep->poll_wait.
>>>>>>> The path that I'm concerned about is let's say that there are N
>>>>> events
>>>>>>> queued on the ready list. A thread that was woken up in
>>>>> epoll_wait may
>>>>>>> decide to only process say N/2 of then. Then it will call wakeup
>>>>> on ep->wq
>>>>>>> and this will wakeup another thread to process the remaining N/2.
>>>>> Without
>>>>>>> the wakeup, the original thread isn't going to process the events
>>>>> until
>>>>>>> it finishes with the original N/2 and gets back to epoll_wait().
>>>>> So I'm not
>>>>>>> sure how important that path is but I wanted to at least note the
>>>>> change
>>>>>>> here would impact that behavior.
>>>>>>>
>>>>>>> Thanks,
>>>>>>>
>>>>>>> -Jason
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>> So I think removing all that even for the
>>>>>>>>> depth 0 case is going to change some behavior here. So
>>>>> perhaps, it
>>>>>>>>> should be removed for all depths except for 0? And if so, it
>>>>> may be
>>>>>>>>> better to make 2 patches here to separate these changes.
>>>>>>>>>
>>>>>>>>> For the nested wakeups, I agree that the extra wakeups seem
>>>>> unnecessary
>>>>>>>>> and it may make sense to remove them for all depths. I don't
>>>>> think the
>>>>>>>>> nested epoll semantics are particularly well spelled out, and
>>>>> afaict,
>>>>>>>>> nested epoll() has behaved this way for quite some time. And
>>>>> the current
>>>>>>>>> behavior is not bad in the way that a missing wakeup or false
>>>>> negative
>>>>>>>>> would be.
>>>>>>>>
>>>>>>>> That's 100% true! For edge mode extra wake up is not a bug, not
>>>>> optimal
>>>>>>>> for userspace - yes, but that can't lead to any lost wakeups.
>>>>>>>>
>>>>>>>> --
>>>>>>>> Roman
>>>>>>>>
>>>>>>
>>>>>> I tried to remove the whole chunk of code that Roman said, and it
>>>>>> seems that there
>>>>>> are no obvious problems with the two test programs below:
>>>>
>>>> I recall this message, the test case 9/25/26 of epoll-wakeup (on
>>>> github) are failed while
>>>> the whole chunk are removed.
>>>>
>>>> Apply the original patch, all tests passed.
>>>
>>>
>>> These are failing on my bare 5.2.0-rc2
>>>
>>> TEST  bin/epoll31       FAIL
>>> TEST  bin/epoll46       FAIL
>>> TEST  bin/epoll50       FAIL
>>> TEST  bin/epoll32       FAIL
>>> TEST  bin/epoll19       FAIL
>>> TEST  bin/epoll27       FAIL
>>> TEST  bin/epoll42       FAIL
>>> TEST  bin/epoll34       FAIL
>>> TEST  bin/epoll48       FAIL
>>> TEST  bin/epoll40       FAIL
>>> TEST  bin/epoll20       FAIL
>>> TEST  bin/epoll28       FAIL
>>> TEST  bin/epoll38       FAIL
>>> TEST  bin/epoll52       FAIL
>>> TEST  bin/epoll24       FAIL
>>> TEST  bin/epoll23       FAIL
>>>
>>>
>>> These are failing if your patch is applied:
>>> (my 5.2.0-rc2 is old? broken?)
>>>
>>> TEST  bin/epoll46       FAIL
>>> TEST  bin/epoll42       FAIL
>>> TEST  bin/epoll34       FAIL
>>> TEST  bin/epoll48       FAIL
>>> TEST  bin/epoll40       FAIL
>>> TEST  bin/epoll44       FAIL
>>> TEST  bin/epoll38       FAIL
>>>
>>> These are failing if "ep_poll_safewake(&ep->poll_wait)" is not called,
>>> but wakeup(&ep->wq); is still invoked:
>>>
>>> TEST  bin/epoll46       FAIL
>>> TEST  bin/epoll42       FAIL
>>> TEST  bin/epoll34       FAIL
>>> TEST  bin/epoll40       FAIL
>>> TEST  bin/epoll44       FAIL
>>> TEST  bin/epoll38       FAIL
>>>
>>> So at least 48 has been "fixed".
>>>
>>> These are failing if the whole chunk is removed, like your
>>> said 9,25,26 are among which do not pass:
>>>
>>> TEST  bin/epoll26       FAIL
>>> TEST  bin/epoll42       FAIL
>>> TEST  bin/epoll34       FAIL
>>> TEST  bin/epoll9        FAIL
>>> TEST  bin/epoll48       FAIL
>>> TEST  bin/epoll40       FAIL
>>> TEST  bin/epoll25       FAIL
>>> TEST  bin/epoll44       FAIL
>>> TEST  bin/epoll38       FAIL
>>>
>>> This can be a good test suite, probably can be added to kselftests?
> 
> Thank you, I have updated epoll-tests to fix these issues. I think this is good
> news if we can added to kselftests. ;)
> 
>>>
>>> --
>>> Roman
>>>
>>
>>
>> Indeed, I just tried the same test suite and I am seeing similar
>> failures - it looks like its a bit timing dependent. It looks like all
>> the failures are caused by a similar issue. For example, take epoll34:
>>
>>          t0   t1
>>      (ew) |    | (ew)
>>          e0    |
>>       (lt) \  /
>>              |
>>             e1
>>              | (et)
>>             s0
>>
>>
>> The test is trying to assert that an epoll_wait() on e1 and and
>> epoll_wait() on e0 both return 1 event for EPOLLIN. However, the
>> epoll_wait on e1 is done in a thread and it can happen before or after
>> the epoll_wait() is called against e0. If the epoll_wait() on e1 happens
>> first then because its attached as 'et', it consumes the event. So that
>> there is no longer an event reported at e0. I think that is reasonable
>> semantics here. However if the wait on e0 happens after the wait on e1
>> then the test will pass as both waits will see the event. Thus, a patch
>> like this will 'fix' this testcase:
>>
>> --- a/src/epoll34.c
>> +++ b/src/epoll34.c
>> @@ -59,15 +59,15 @@ int main(int argc, char *argv[])
>>         if (epoll_ctl(efd[0], EPOLL_CTL_ADD, efd[1], &e) < 0)
>>                 goto out;
>>
>> -       if (pthread_create(&tw, NULL, thread_handler, NULL) < 0)
>> -               goto out;
>> -
>>         if (pthread_create(&te, NULL, emit_handler, NULL) < 0)
>>                 goto out;
>>
>>         if (epoll_wait(efd[0], &e, 1, 500) == 1)
>>                 count++;
>>
>> +       if (pthread_create(&tw, NULL, thread_handler, NULL) < 0)
>> +               goto out;
>> +
>>         if (pthread_join(tw, NULL) < 0)
>>                 goto out;
>>
>>
>> I found all the other failures to be of similar origin. I suspect Heiher
>> didn't see failures due to the thread timings here.
> 
> Thank you. I also found a multi-threaded concurrent accumulation problem,
> and that has been changed to atomic operations. I think we should allow two
> different behaviors to be passed because they are all correctly.
> 
> thread 2:
> if (epoll_wait(efd[1], &e, 1, 500) == 1)
>     __sync_fetch_and_or(&count, 1);
> 
> thread1:
> if (epoll_wait(efd[0], &e, 1, 500) == 1)
>     __sync_fetch_and_or(&count, 2);
> 
> check:
> if ((count != 1) && (count != 3))
>     goto out;
> 
>>
>> I also found that all the testcases pass if we leave the wakeup(&ep->wq)
>> call for the depth 0 case (and remove the pwake part).
> 
> So, We need to keep the wakeup(&ep-wq) for all depth, and only
> wakeup(&ep->poll_wait)
> for depth 0 and/or ep->rdlist from empty to be not empty?
> 

Yes, so my thinking is yes, leave the wakeup(&ep->wq) for all depths. It
may not strictly be necessary for depths > 0 but I do have some concerns
about it and doesn't affect this specific case. So I would leave it for
all depths and if you want to remove it for depths > 0, its a separate
patch.

I'm now not sure its really safe to remove the wakeup(&ep->poll_wait)
either. Take the case where we have:

       (et)  (lt)
t0---e0---e1----s0


Let's say there is thread t1 also doing epoll_wait() on e1. Now, let's
say s0 fires an event and wakes up t1. While t1 is reaping events from
t1 its calling ep_scan_ready_list() and while its processing the events
it drops the ep->lock and more events get queued to the overflow list.
Now, let's say t0 wakes up from epoll_wait() it will not see any of the
events queued to e1 yet (since they are not on the readylist yet). Thus,
t0 goes back to sleep and I think can miss an event here. So I think
that's what the wakeup(&ep->poll_wait) is about.

What I think we can do to fix the original case, is that perhaps in that
case where events get queued to the overflow list we do in fact do the
wakeup(&ep->poll_wait). So perhaps, we can just have variable that
checks if there is anything in the overflow list, and if so do the
wakeup(&ep->poll_wait) conditional on there being things on the overflow
list. Although I can't say I tried to see if this would work.

That said, I think ep_modify() might also subtlety be dependent on the
current behavior, in that ep_item_poll() uses ep_scan_ready_list() and
when an event is modified it may need to wakeup nested epoll fds to
inform them of events. Thus, perhaps, we would also need an explicit
call to wakeup(&ep->poll_wait) when ep_item_poll() returns events.

Thanks,

-Jason
