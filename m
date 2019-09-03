Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7B18A75FF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 23:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfICVNa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 17:13:30 -0400
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127]:56938 "EHLO
        mx0b-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726394AbfICVNa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 17:13:30 -0400
Received: from pps.filterd (m0050096.ppops.net [127.0.0.1])
        by m0050096.ppops.net-00190b01. (8.16.0.42/8.16.0.42) with SMTP id x83L814m023834;
        Tue, 3 Sep 2019 22:13:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=gPWVbkgN08R1ppDLHnfL+6CZi4CX6Wpq1jATwHiD4Nk=;
 b=WkwZSfqqnJ+xvmiTxc8aUaJUHXCNqgTcWBhyy0M4Olpcg4uy6VYl17wJBxXLreeA6VcU
 1oqx0Ij8PBSjruKDK24LRXYd+SvsIp03mgiM0SucDEJhQpx/L63jzOL6jcE4ZE6rsqsb
 9BwxR0BKLkLHlMF87NUi8HGRhz+/Pv0T78YVnYqNLCLH6XvLBTmrC0QaAZoEgZWY5ncH
 uTOjaTSRl8mOtdWwf3W/XhMitrjXPmJSvHTrPUVD3ll4eQK8OTSWj4YMflqanLZZLdTW
 JRNieOPthJGap2V8e9wR2VRRZZ6v/9anpBW/ga06xZcQwLMEjNtdZi61VOEevRyVNXEP KA== 
Received: from prod-mail-ppoint4 (prod-mail-ppoint4.akamai.com [96.6.114.87] (may be forged))
        by m0050096.ppops.net-00190b01. with ESMTP id 2uqha7yytm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Sep 2019 22:13:13 +0100
Received: from pps.filterd (prod-mail-ppoint4.akamai.com [127.0.0.1])
        by prod-mail-ppoint4.akamai.com (8.16.0.27/8.16.0.27) with SMTP id x83L2N5V005892;
        Tue, 3 Sep 2019 17:13:12 -0400
Received: from prod-mail-relay14.akamai.com ([172.27.17.39])
        by prod-mail-ppoint4.akamai.com with ESMTP id 2uqm80p4bh-1;
        Tue, 03 Sep 2019 17:13:12 -0400
Received: from [172.29.170.83] (bos-lpjec.kendall.corp.akamai.com [172.29.170.83])
        by prod-mail-relay14.akamai.com (Postfix) with ESMTP id 1D6B180E97;
        Tue,  3 Sep 2019 21:13:11 +0000 (GMT)
Subject: Re: [PATCH RESEND] fs/epoll: fix the edge-triggered mode for nested
 epoll
To:     Roman Penyaev <rpenyaev@suse.de>, hev <r@hev.cc>
Cc:     linux-fsdevel@vger.kernel.org, e@80x24.org,
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
From:   Jason Baron <jbaron@akamai.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jbaron@akamai.com; prefer-encrypt=mutual; keydata=
 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
 JeQ7iQ==
Message-ID: <7075dd44-feea-a52f-ddaa-087d7bb2c4f6@akamai.com>
Date:   Tue, 3 Sep 2019 17:08:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0cdc9905efb9b77b159e09bee17d3ad4@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-03_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909030212
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-03_04:2019-09-03,2019-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0 clxscore=1011
 phishscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1909030213
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/2/19 11:36 AM, Roman Penyaev wrote:
> Hi,
> 
> This is indeed a bug. (quick side note: could you please remove efd[1]
> from your test, because it is not related to the reproduction of a
> current bug).
> 
> Your patch lacks a good description, what exactly you've fixed.  Let
> me speak out loud and please correct me if I'm wrong, my understanding
> of epoll internals has become a bit rusty: when epoll fds are nested
> an attempt to harvest events (ep_scan_ready_list() call) produces a
> second (repeated) event from an internal fd up to an external fd:
> 
>      epoll_wait(efd[0], ...):
>        ep_send_events():
>           ep_scan_ready_list(depth=0):
>             ep_send_events_proc():
>                 ep_item_poll():
>                   ep_scan_ready_list(depth=1):
>                     ep_poll_safewake():
>                       ep_poll_callback()
>                         list_add_tail(&epi, &epi->rdllist);
>                         ^^^^^^
>                         repeated event
> 
> 
> In your patch you forbid wakeup for the cases, where depth != 0, i.e.
> for all nested cases. That seems clear.  But what if we can go further
> and remove the whole chunk, which seems excessive:
> 
> @@ -885,26 +886,11 @@ static __poll_t ep_scan_ready_list(struct
> eventpoll *ep,
> 
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
> 
> 
> I reason like that: by the time we've reached the point of scanning events
> for readiness all wakeups from ep_poll_callback have been already fired and
> new events have been already accounted in ready list (ep_poll_callback()
> calls
> the same ep_poll_safewake()). Here, frankly, I'm not 100% sure and probably
> missing some corner cases.
> 
> Thoughts?

So the: 'wake_up(&ep->wq);' part, I think is about waking up other
threads that may be in waiting in epoll_wait(). For example, there may
be multiple threads doing epoll_wait() on the same epoll fd, and the
logic above seems to say thread 1 may have processed say N events and
now its going to to go off to work those, so let's wake up thread 2 now
to handle the next chunk. So I think removing all that even for the
depth 0 case is going to change some behavior here. So perhaps, it
should be removed for all depths except for 0? And if so, it may be
better to make 2 patches here to separate these changes.

For the nested wakeups, I agree that the extra wakeups seem unnecessary
and it may make sense to remove them for all depths. I don't think the
nested epoll semantics are particularly well spelled out, and afaict,
nested epoll() has behaved this way for quite some time. And the current
behavior is not bad in the way that a missing wakeup or false negative
would be. It woulbe be good to better understand the use-case more here
and to try and spell out the nested semantics more clearly?

Thanks,

-Jason


> 
> PS.  You call list_empty(&ep->rdllist) without ep->lock taken, that is
> fine,
>      but you should be _careful_, so list_empty_careful(&ep->rdllist) call
>      instead.
> 
> -- 
> Roman
> 
> 
> 
> On 2019-09-02 07:20, hev wrote:
>> From: Heiher <r@hev.cc>
>>
>> The structure of event pools:
>>  efd[1]: { efd[2] (EPOLLIN) }        efd[0]: { efd[2] (EPOLLIN |
>> EPOLLET) }
>>                |                                   |
>>                +-----------------+-----------------+
>>                                  |
>>                                  v
>>                              efd[2]: { sfd[0] (EPOLLIN) }
>>
>> When sfd[0] to be readable:
>>  * the epoll_wait(efd[0], ..., 0) should return efd[2]'s events on
>> first call,
>>    and returns 0 on next calls, because efd[2] is added in
>> edge-triggered mode.
>>  * the epoll_wait(efd[1], ..., 0) should returns efd[2]'s events on
>> every calls
>>    until efd[2] is not readable (epoll_wait(efd[2], ...) => 0),
>> because efd[1]
>>    is added in level-triggered mode.
>>  * the epoll_wait(efd[2], ..., 0) should returns sfd[0]'s events on
>> every calls
>>    until sfd[0] is not readable (read(sfd[0], ...) => EAGAIN), because
>> sfd[0]
>>    is added in level-triggered mode.
>>
>> Test code:
>>  #include <stdio.h>
>>  #include <unistd.h>
>>  #include <sys/epoll.h>
>>  #include <sys/socket.h>
>>
>>  int main(int argc, char *argv[])
>>  {
>>      int sfd[2];
>>      int efd[3];
>>      int nfds;
>>      struct epoll_event e;
>>
>>      if (socketpair(AF_UNIX, SOCK_STREAM, 0, sfd) < 0)
>>          goto out;
>>
>>      efd[0] = epoll_create(1);
>>      if (efd[0] < 0)
>>          goto out;
>>
>>      efd[1] = epoll_create(1);
>>      if (efd[1] < 0)
>>          goto out;
>>
>>      efd[2] = epoll_create(1);
>>      if (efd[2] < 0)
>>          goto out;
>>
>>      e.events = EPOLLIN;
>>      if (epoll_ctl(efd[2], EPOLL_CTL_ADD, sfd[0], &e) < 0)
>>          goto out;
>>
>>      e.events = EPOLLIN;
>>      if (epoll_ctl(efd[1], EPOLL_CTL_ADD, efd[2], &e) < 0)
>>          goto out;
>>
>>      e.events = EPOLLIN | EPOLLET;
>>      if (epoll_ctl(efd[0], EPOLL_CTL_ADD, efd[2], &e) < 0)
>>          goto out;
>>
>>      if (write(sfd[1], "w", 1) != 1)
>>          goto out;
>>
>>      nfds = epoll_wait(efd[0], &e, 1, 0);
>>      if (nfds != 1)
>>          goto out;
>>
>>      nfds = epoll_wait(efd[0], &e, 1, 0);
>>      if (nfds != 0)
>>          goto out;
>>
>>      nfds = epoll_wait(efd[1], &e, 1, 0);
>>      if (nfds != 1)
>>          goto out;
>>
>>      nfds = epoll_wait(efd[1], &e, 1, 0);
>>      if (nfds != 1)
>>          goto out;
>>
>>      nfds = epoll_wait(efd[2], &e, 1, 0);
>>      if (nfds != 1)
>>          goto out;
>>
>>      nfds = epoll_wait(efd[2], &e, 1, 0);
>>      if (nfds != 1)
>>          goto out;
>>
>>      close(efd[2]);
>>      close(efd[1]);
>>      close(efd[0]);
>>      close(sfd[0]);
>>      close(sfd[1]);
>>
>>      printf("PASS\n");
>>      return 0;
>>
>>  out:
>>      printf("FAIL\n");
>>      return -1;
>>  }
>>
>> Cc: Al Viro <viro@ZenIV.linux.org.uk>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Davide Libenzi <davidel@xmailserver.org>
>> Cc: Davidlohr Bueso <dave@stgolabs.net>
>> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
>> Cc: Eric Wong <e@80x24.org>
>> Cc: Jason Baron <jbaron@akamai.com>
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>> Cc: Roman Penyaev <rpenyaev@suse.de>
>> Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-fsdevel@vger.kernel.org
>> Signed-off-by: hev <r@hev.cc>
>> ---
>>  fs/eventpoll.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
>> index d7f1f5011fac..a44cb27c636c 100644
>> --- a/fs/eventpoll.c
>> +++ b/fs/eventpoll.c
>> @@ -672,6 +672,7 @@ static __poll_t ep_scan_ready_list(struct
>> eventpoll *ep,
>>  {
>>      __poll_t res;
>>      int pwake = 0;
>> +    int nwake = 0;
>>      struct epitem *epi, *nepi;
>>      LIST_HEAD(txlist);
>>
>> @@ -685,6 +686,9 @@ static __poll_t ep_scan_ready_list(struct
>> eventpoll *ep,
>>      if (!ep_locked)
>>          mutex_lock_nested(&ep->mtx, depth);
>>
>> +    if (!depth || list_empty(&ep->rdllist))
>> +        nwake = 1;
>> +
>>      /*
>>       * Steal the ready list, and re-init the original one to the
>>       * empty list. Also, set ep->ovflist to NULL so that events
>> @@ -739,7 +743,7 @@ static __poll_t ep_scan_ready_list(struct
>> eventpoll *ep,
>>      list_splice(&txlist, &ep->rdllist);
>>      __pm_relax(ep->ws);
>>
>> -    if (!list_empty(&ep->rdllist)) {
>> +    if (nwake && !list_empty(&ep->rdllist)) {
>>          /*
>>           * Wake up (if active) both the eventpoll wait list and
>>           * the ->poll() wait list (delayed after we release the lock).
> 
