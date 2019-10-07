Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6809ACE985
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2019 18:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbfJGQn0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Oct 2019 12:43:26 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:24622 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727830AbfJGQn0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Oct 2019 12:43:26 -0400
Received: from pps.filterd (m0122332.ppops.net [127.0.0.1])
        by mx0a-00190b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x97Gg6XM019016;
        Mon, 7 Oct 2019 17:43:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=m1ZZO0oGKh4F7rNmv47ldCs8BqJL8+I4Z8ctXCpYIv4=;
 b=Vh3OScJDBGDy3Lkl5tcNSCDhiKUmyZzihm+5Cvk+KR7YfHmvl9/DeJDBgiw6+NmAd7JL
 nuOEktFHlEkZtO/wFw0WRLbM4HWfqLQYgNNkq9UOTKujqtVeJxstZPTiepalTWrTPhlU
 etqio0/a2JjuocYX/2c6i5CFi0tu4boFytLXO0PpBzbzTrBq5YkvC9pXyB+SKyWIgO5G
 Z0XX/TcoL979ffIT4j0zcAHPhcb0F/bmTCPCq4dzXt7Bcj1sVtT3FA1AK6ExZaI4oo9l
 Yamd2E+FtRp1hF3q85Fc93zvxHhFpLDEC/IoXIP1BCqxFs8WdanS8CDdKXYk+jqtqovx CA== 
Received: from prod-mail-ppoint4 (prod-mail-ppoint4.akamai.com [96.6.114.87] (may be forged))
        by mx0a-00190b01.pphosted.com with ESMTP id 2vek7j3xpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Oct 2019 17:43:11 +0100
Received: from pps.filterd (prod-mail-ppoint4.akamai.com [127.0.0.1])
        by prod-mail-ppoint4.akamai.com (8.16.0.27/8.16.0.27) with SMTP id x97GH3GJ000623;
        Mon, 7 Oct 2019 12:43:09 -0400
Received: from prod-mail-relay15.akamai.com ([172.27.17.40])
        by prod-mail-ppoint4.akamai.com with ESMTP id 2veph2j3sv-1;
        Mon, 07 Oct 2019 12:43:08 -0400
Received: from [172.29.170.83] (bos-lpjec.kendall.corp.akamai.com [172.29.170.83])
        by prod-mail-relay15.akamai.com (Postfix) with ESMTP id ADCBB20064;
        Mon,  7 Oct 2019 16:43:07 +0000 (GMT)
Subject: Re: [PATCH RESEND v4] fs/epoll: Remove unnecessary wakeups of nested
 epoll that in ET mode
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>, hev <r@hev.cc>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Davide Libenzi <davidel@xmailserver.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Eric Wong <e@80x24.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sridhar Samudrala <sridhar.samudrala@intel.com>,
        linux-kernel@vger.kernel.org
References: <20190925015603.10939-1-r@hev.cc>
 <20190927192915.6ec24ad706258de99470a96e@linux-foundation.org>
 <c0a96dd89d0a361d8061b8c356b57ed2@suse.de>
 <9ca02c9b-85b7-dced-9c82-1fc453c49b8a@akamai.com>
 <9a82925ff7dfc314d36b3d36e54316a8@suse.de>
From:   Jason Baron <jbaron@akamai.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jbaron@akamai.com; prefer-encrypt=mutual; keydata=
 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
 JeQ7iQ==
Message-ID: <9ceee722-d2a8-b182-c95a-e7a873b08ca1@akamai.com>
Date:   Mon, 7 Oct 2019 12:42:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9a82925ff7dfc314d36b3d36e54316a8@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-07_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910070155
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-07_03:2019-10-07,2019-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 clxscore=1011
 malwarescore=0 impostorscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1910070156
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 10/7/19 6:54 AM, Roman Penyaev wrote:
> On 2019-10-03 18:13, Jason Baron wrote:
>> On 9/30/19 7:55 AM, Roman Penyaev wrote:
>>> On 2019-09-28 04:29, Andrew Morton wrote:
>>>> On Wed, 25 Sep 2019 09:56:03 +0800 hev <r@hev.cc> wrote:
>>>>
>>>>> From: Heiher <r@hev.cc>
>>>>>
>>>>> Take the case where we have:
>>>>>
>>>>>         t0
>>>>>          | (ew)
>>>>>         e0
>>>>>          | (et)
>>>>>         e1
>>>>>          | (lt)
>>>>>         s0
>>>>>
>>>>> t0: thread 0
>>>>> e0: epoll fd 0
>>>>> e1: epoll fd 1
>>>>> s0: socket fd 0
>>>>> ew: epoll_wait
>>>>> et: edge-trigger
>>>>> lt: level-trigger
>>>>>
>>>>> We only need to wakeup nested epoll fds if something has been queued
>>>>> to the
>>>>> overflow list, since the ep_poll() traverses the rdllist during
>>>>> recursive poll
>>>>> and thus events on the overflow list may not be visible yet.
>>>>>
>>>>> Test code:
>>>>
>>>> Look sane to me.  Do you have any performance testing results which
>>>> show a benefit?
>>>>
>>>> epoll maintainership isn't exactly a hive of activity nowadays :(
>>>> Roman, would you please have time to review this?
>>>
>>> So here is my observation: current patch does not fix the described
>>> problem (double wakeup) for the case, when new event comes exactly
>>> to the ->ovflist.  According to the patch this is the desired intention:
>>>
>>>    /*
>>>     * We only need to wakeup nested epoll fds if something has been
>>> queued
>>>     * to the overflow list, since the ep_poll() traverses the rdllist
>>>     * during recursive poll and thus events on the overflow list may
>>> not be
>>>     * visible yet.
>>>     */
>>>     if (nepi != NULL)
>>>        pwake++;
>>>
>>>     ....
>>>
>>>     if (pwake == 2)
>>>        ep_poll_safewake(&ep->poll_wait);
>>>
>>>
>>> but this actually means that we repeat the same behavior (double wakeup)
>>> but only for the case, when event comes to the ->ovflist.
>>>
>>> How to reproduce? Can be easily done (ok, not so easy but it is possible
>>> to try): to the given userspace test we need to add one more socket and
>>> immediately fire the event:
>>>
>>>     e.events = EPOLLIN;
>>>     if (epoll_ctl(efd[1], EPOLL_CTL_ADD, s2fd[0], &e) < 0)
>>>        goto out;
>>>
>>>     /*
>>>      * Signal any fd to let epoll_wait() to call ep_scan_ready_list()
>>>      * in order to "catch" it there and add new event to ->ovflist.
>>>      */
>>>      if (write(s2fd[1], "w", 1) != 1)
>>>         goto out;
>>>
>>> That is done in order to let the following epoll_wait() call to invoke
>>> ep_scan_ready_list(), where we can "catch" and insert new event exactly
>>> to the ->ovflist. In order to insert event exactly in the correct list
>>> I introduce artificial delay.
>>>
>>> Modified test and kernel patch is below.  Here is the output of the
>>> testing tool with some debug lines from kernel:
>>>
>>>   # ~/devel/test/edge-bug
>>>   [   59.263178] ### sleep 2
>>>   >> write to sock
>>>   [   61.318243] ### done sleep
>>>   [   61.318991] !!!!!!!!!!! ep_poll_safewake(&ep->poll_wait);
>>> events_in_rdllist=1, events_in_ovflist=1
>>>   [   61.321204] ### sleep 2
>>>   [   63.398325] ### done sleep
>>>   error: What?! Again?!
>>>
>>> First epoll_wait() call (ep_scan_ready_list()) observes 2 events
>>> (see "!!!!!!!!!!! ep_poll_safewake" output line), exactly what we
>>> wanted to achieve, so eventually ep_poll_safewake() is called again
>>> which leads to double wakeup.
>>>
>>> In my opinion current patch as it is should be dropped, it does not
>>> fix the described problem but just hides it.
>>>
>>> -- 
> 
> Hi Jason,
> 
>>
>> Yes, there are 2 wakeups in the test case you describe, but if the
>> second event (write to s1fd) gets queued after the first call to
>> epoll_wait(), we are going to get 2 wakeups anyways.
> 
> Yes, exactly, for this reason I print out the number of events observed
> on first wait, there should be 1 (rdllist) and 1 (ovflist), otherwise
> this is another case, when second event comes exactly after first
> wait, which is legitimate wakeup.
> 
>> So yes, there may
>> be a slightly bigger window with this patch for 2 wakeups, but its small
>> and I tried to be conservative with the patch - I'd rather get an
>> occasional 2nd wakeup then miss one. Trying to debug missing wakeups
>> isn't always fun...
>>
>> That said, the reason for propagating events that end up on the overflow
>> list was to prevent the race of the wakee not seeing events because they
>> were still on the overflow list. In the testcase, imagine if there was a
>> thread doing epoll_wait() on efd[0], and then a write happends on s1fd.
>> I thought it was possible then that a 2nd thread doing epoll_wait() on
>> efd[1], wakes up, checks efd[0] and sees no events because they are
>> still potentially on the overflow list. However, I think that case is
>> not possible because the thread doing epoll_wait() on efd[0] is going to
>> have the ep->mtx, and thus when the thread wakes up on efd[1], its going
>> to have to be ordered because its also grabbing the ep->mtx associated
>> with efd[0].
>>
>> So I think its safe to do the following if we want to go further than
>> the proposed patch, which is what you suggested earlier in the thread
>> (minus keeping the wakeup on ep->wq).
> 
> Then I do not understand why we need to keep ep->wq wakeup?
> @wq and @poll_wait are almost the same with only one difference:
> @wq is used when you sleep on it inside epoll_wait() and the other
> is used when you nest epoll fd inside epoll fd.  Either you wake
> both up either you don't this at all.
> 
> ep_poll_callback() does wakeup explicitly, ep_insert() and ep_modify()
> do wakeup explicitly, so what are the cases when we need to do wakeups
> from ep_scan_ready_list()?

Hi Roman,

So the reason I was saying not to drop the ep->wq wakeup was that I was
thinking about a usecase where you have multi-threads say thread A and
thread B which are doing epoll_wait() on the same epfd. Now, the threads
both call epoll_wait() and are added as exclusive to ep->wq. Now a bunch
of events happen and thread A is woken up. However, thread A may only
process a subset of the events due to its 'maxevents' parameter. In that
case, I was thinking that the wakeup on ep->wq might be helpful, because
in the absence of subsequent events, thread B can now start processing
the rest, instead of waiting for the next event to be queued.

However, I was thinking about the state of things before:
86c0517 fs/epoll: deal with wait_queue only once

Before that patch, thread A would have been removed from eq->wq before
the wakeup call, thus waking up thread B. However, now that thread A
stays on the queue during the call to ep_send_events(), I believe the
wakeup would only target thread A, which doesn't help since its already
checking for events. So given the state of things I think you are right
in that its not needed. However, I wonder if not removing from the
ep->wq affects the multi-threaded case I described. Its been around
since 5.0, so probably not, but it would be a more subtle performance
difference.

Thanks,

-Jason




> 
> I would still remove the whole branch:
> 
> 
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -671,7 +671,6 @@ static __poll_t ep_scan_ready_list(struct eventpoll
> *ep,
>                               void *priv, int depth, bool ep_locked)
>  {
>         __poll_t res;
> -       int pwake = 0;
>         struct epitem *epi, *nepi;
>         LIST_HEAD(txlist);
> 
> @@ -738,26 +737,11 @@ static __poll_t ep_scan_ready_list(struct
> eventpoll *ep,
>          */
>         list_splice(&txlist, &ep->rdllist);
>         __pm_relax(ep->ws);
> -
> -       if (!list_empty(&ep->rdllist)) {
> -               /*
> -                * Wake up (if active) both the eventpoll wait list and
> -                * the ->poll() wait list (delayed after we release the
> lock).
> -                */
> -               if (waitqueue_active(&ep->wq))
> -                       wake_up(&ep->wq);
> -               if (waitqueue_active(&ep->poll_wait))
> -                       pwake++;
> -       }
>         write_unlock_irq(&ep->lock);
> 
>         if (!ep_locked)
>                 mutex_unlock(&ep->mtx);
> 
> -       /* We have to call this outside the lock */
> -       if (pwake)
> -               ep_poll_safewake(&ep->poll_wait);
> -
>         return res;
>  }
> 
> -- 
> Roman
> 
> 
> 
