Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B19DEBB800
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2019 17:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfIWPej (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Sep 2019 11:34:39 -0400
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127]:7482 "EHLO
        mx0b-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725911AbfIWPej (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Sep 2019 11:34:39 -0400
Received: from pps.filterd (m0050102.ppops.net [127.0.0.1])
        by m0050102.ppops.net-00190b01. (8.16.0.42/8.16.0.42) with SMTP id x8NFWrRe015948;
        Mon, 23 Sep 2019 16:34:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=dtuqnbitt6pdhvEimCvQOhV8X7Mxa4rkrwI+PucysPA=;
 b=jlQZ3y91fPg6/JpzJb6BQsFREP8isMJGbVr4Rs16q6TyGdAEFZaRpMZOIGcXUIJLagJ9
 +wfsrgDQXJJ9WQtHyenwEpnKeSI/BepEVkH4GXlCDhRG7CeRyToYFiNug+3SQrXjTyco
 yHnsmnBgMq0fFWIB3o/TcmK4Jk2fG9cCo64LUxB2Q8zoa+IihvvH1T7GP35TEbBfZhri
 hawV6y+RPxsbwqXQCzfHX4FZUqPwP+zHpz9uQWzJ91y21WzBOsjjLF4k7BHTLD/mzxVk
 UF9DKoR7+fEPk9nvkpIQ2uGKUOaEhZSX6QElLSJ4quKMUeNioGuCFdNwpel1A4xm9kAK bQ== 
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18] (may be forged))
        by m0050102.ppops.net-00190b01. with ESMTP id 2v58xdspry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Sep 2019 16:34:20 +0100
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
        by prod-mail-ppoint1.akamai.com (8.16.0.27/8.16.0.27) with SMTP id x8NFKmsS028564;
        Mon, 23 Sep 2019 11:34:19 -0400
Received: from prod-mail-relay10.akamai.com ([172.27.118.251])
        by prod-mail-ppoint1.akamai.com with ESMTP id 2v5f6wgvq1-1;
        Mon, 23 Sep 2019 11:34:19 -0400
Received: from [172.29.170.83] (bos-lpjec.kendall.corp.akamai.com [172.29.170.83])
        by prod-mail-relay10.akamai.com (Postfix) with ESMTP id 1D0B420221;
        Mon, 23 Sep 2019 15:34:19 +0000 (GMT)
Subject: Re: [PATCH RESEND v2] fs/epoll: Remove unnecessary wakeups of nested
 epoll that in ET mode
From:   Jason Baron <jbaron@akamai.com>
To:     hev <r@hev.cc>, linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davide Libenzi <davidel@xmailserver.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Eric Wong <e@80x24.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Roman Penyaev <rpenyaev@suse.de>,
        Sridhar Samudrala <sridhar.samudrala@intel.com>,
        linux-kernel@vger.kernel.org
References: <20190919092413.11141-1-r@hev.cc>
 <4379abe0-9f81-21b6-11ae-6eb3db79eeff@akamai.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jbaron@akamai.com; prefer-encrypt=mutual; keydata=
 xsFNBFnyIJMBEADamFSO/WCelO/HZTSNbJ1YU9uoEUwmypV2TvyrTrXULcAlH1sXVHS3pNdR
 I/koZ1V7Ruew5HJC4K9Z5Fuw/RHYWcnQz2X+dSL6rX3BwRZEngjA4r/GDi0EqIdQeQQWCAgT
 VLWnIenNgmEDCoFQjFny5NMNL+i8SA6hPPRdNjxDowDhbFnkuVUBp1DBqPjHpXMzf3UYsZZx
 rxNY5YKFNLCpQb1cZNsR2KXZYDKUVALN3jvjPYReWkqRptOSQnvfErikwXRgCTasWtowZ4cu
 hJFSM5Asr/WN9Wy6oPYObI4yw+KiiWxiAQrfiQVe7fwznStaYxZ2gZmlSPG/Y2/PyoCWYbNZ
 mJ/7TyED5MTt22R7dqcmrvko0LIpctZqHBrWnLTBtFXZPSne49qGbjzzHywZ0OqZy9nqdUFA
 ZH+DALipwVFnErjEjFFRiwCWdBNpIgRrHd2bomlyB5ZPiavoHprgsV5ZJNal6fYvvgCik77u
 6QgE4MWfhf3i9A8Dtyf8EKQ62AXQt4DQ0BRwhcOW5qEXIcKj33YplyHX2rdOrD8J07graX2Q
 2VsRedNiRnOgcTx5Zl3KARHSHEozpHqh7SsthoP2yVo4A3G2DYOwirLcYSCwcrHe9pUEDhWF
 bxdyyESSm/ysAVjvENsdcreWJqafZTlfdOCE+S5fvC7BGgZu7QARAQABzR9KYXNvbiBCYXJv
 biA8amJhcm9uQGFrYW1haS5jb20+wsF+BBMBAgAoBQJZ8iCTAhsDBQkJZgGABgsJCAcDAgYV
 CAIJCgsEFgIDAQIeAQIXgAAKCRC4s7mct4u0M9E0EADBxyL30W9HnVs3x7umqUbl+uBqbBIS
 GIvRdMDIJXX+EEA6c82ElV2cCOS7dvE3ssG1jRR7g3omW7qEeLdy/iQiJ/qGNdcf0JWHYpmS
 ThZP3etrl5n7FwLm+51GPqD0046HUdoVshRs10qERDo+qnvMtTdXsfk8uoQ5lyTSvgX4s1H1
 ppN1BfkG10epsAtjOJJlBoV9e92vnVRIUTnDeTVXfK11+hT5hjBxxs7uS46wVbwPuPjMlbSa
 ifLnt7Jz590rtzkeGrUoM5SKRL4DVZYNoAVFp/ik1fe53Wr5GJZEgDC3SNGS/u+IEzEGCytj
 gejvv6KDs3KcTVSp9oJ4EIZRmX6amG3dksXa4W2GEQJfPfV5+/FR8IOg42pz9RpcET32AL1n
 GxWzY4FokZB0G6eJ4h53DNx39/zaGX1i0cH+EkyZpfgvFlBWkS58JRFrgY25qhPZiySRLe0R
 TkUcQdqdK77XDJN5zmUP5xJgF488dGKy58DcTmLoaBTwuCnX2OF+xFS4bCHJy93CluyudOKs
 e4CUCWaZ2SsrMRuAepypdnuYf3DjP4DpEwBeLznqih4hMv5/4E/jMy1ZMdT+Q8Qz/9pjEuVF
 Yz2AXF83Fqi45ILNlwRjCjdmG9oJRJ+Yusn3A8EbCtsi2g443dKBzhFcmdA28m6MN9RPNAVS
 ucz3Oc7BTQRZ8iCTARAA2uvxdOFjeuOIpayvoMDFJ0v94y4xYdYGdtiaqnrv01eOac8msBKy
 4WRNQ2vZeoilcrPxLf2eRAfsA4dx8Q8kOPvVqDc8UX6ttlHcnwxkH2X4XpJJliA6jx29kBOc
 oQOeL9R8c3CWL36dYbosZZwHwY5Jjs7R6TJHx1FlF9mOGIPxIx3B5SuJLsm+/WPZW1td7hS0
 Alt4Yp8XWW8a/X765g3OikdmvnJryTo1s7bojmwBCtu1TvT0NrX5AJId4fELlCTFSjr+J3Up
 MnmkTSyovPkj8KcvBU1JWVvMnkieqrhHOmf2qdNMm61LGNG8VZQBVDMRg2szB79p54DyD+qb
 gTi8yb0MFqNvXGRnU/TZmLlxblHA4YLMAuLlJ3Y8Qlw5fJ7F2U1Xh6Z6m6YCajtsIF1VkUhI
 G2dSAigYpe6wU71Faq1KHp9C9VsxlnSR1rc4JOdj9pMoppzkjCphyX3eV9eRcfm4TItTNTGJ
 7DAUQHYS3BVy1fwyuSDIJU/Jrg7WWCEzZkS4sNcBz0/GajYFM7Swybn/VTLtCiioThw4OQIw
 9Afb+3sB9WR86B7N7sSUTvUArknkNDFefTJJLMzEboRMJBWzpR5OAyLxCWwVSQtPp0IdiIC2
 KGF3QXccv/Q9UkI38mWvkilr3EWAOJnPgGCM/521axcyWqXsqNtIxpUAEQEAAcLBZQQYAQIA
 DwUCWfIgkwIbDAUJCWYBgAAKCRC4s7mct4u0M+AsD/47Q9Gi+HmLyqmaaLBzuI3mmU4vDn+f
 50A/U9GSVTU/sAN83i1knpv1lmfG2DgjLXslU+NUnzwFMLI3QsXD3Xx/hmdGQnZi9oNpTMVp
 tG5hE6EBPsT0BM6NGbghBsymc827LhfYICiahOR/iv2yv6nucKGBM51C3A15P8JgfJcngEnM
 fCKRuQKWbRDPC9dEK9EBglUYoNPVNL7AWJWKAbVQyCCsJzLBgh9jIfmZ9GClu8Sxi0vu/PpA
 DSDSJuc9wk+m5mczzzwd4Y6ly9+iyk/CLNtqjT4sRMMV0TCl8ichxlrdt9rqltk22HXRF7ng
 txomp7T/zRJAqhH/EXWI6CXJPp4wpMUjEUd1B2+s1xKypq//tChF+HfUU4zXUyEXY8nHl6lk
 hFjW/geTcf6+i6mKaxGY4oxuIjF1s2Ak4J3viSeYfTDBH/fgUzOGI5siBhHWvtVzhQKHfOxg
 i8t1q09MJY6je8l8DLEIWTHXXDGnk+ndPG3foBucukRqoTv6AOY49zjrt6r++sujjkE4ax8i
 ClKvS0n+XyZUpHFwvwjSKc+UV1Q22BxyH4jRd1paCrYYurjNG5guGcDDa51jIz69rj6Q/4S9
 Pizgg49wQXuci1kcC1YKjV2nqPC4ybeT6z/EuYTGPETKaegxN46vRVoE2RXwlVk+vmadVJlG
 JeQ7iQ==
Message-ID: <5042e1e0-f49a-74c8-61f8-6903288110ac@akamai.com>
Date:   Mon, 23 Sep 2019 11:33:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4379abe0-9f81-21b6-11ae-6eb3db79eeff@akamai.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-23_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909230145
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-23_05:2019-09-23,2019-09-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 spamscore=0 impostorscore=0 adultscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1909230147
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/20/19 12:00 PM, Jason Baron wrote:
> On 9/19/19 5:24 AM, hev wrote:
>> From: Heiher <r@hev.cc>
>>
>> Take the case where we have:
>>
>>         t0
>>          | (ew)
>>         e0
>>          | (et)
>>         e1
>>          | (lt)
>>         s0
>>
>> t0: thread 0
>> e0: epoll fd 0
>> e1: epoll fd 1
>> s0: socket fd 0
>> ew: epoll_wait
>> et: edge-trigger
>> lt: level-trigger
>>
>> When s0 fires an event, e1 catches the event, and then e0 catches an event from
>> e1. After this, There is a thread t0 do epoll_wait() many times on e0, it should
>> only get one event in total, because e1 is a dded to e0 in edge-triggered mode.
>>
>> This patch only allows the wakeup(&ep->poll_wait) in ep_scan_ready_list under
>> two conditions:
>>
>>  1. depth == 0.
>>  2. There have event is added to ep->ovflist during processing.
>>
>> Test code:
>>  #include <unistd.h>
>>  #include <sys/epoll.h>
>>  #include <sys/socket.h>
>>
>>  int main(int argc, char *argv[])
>>  {
>>  	int sfd[2];
>>  	int efd[2];
>>  	struct epoll_event e;
>>
>>  	if (socketpair(AF_UNIX, SOCK_STREAM, 0, sfd) < 0)
>>  		goto out;
>>
>>  	efd[0] = epoll_create(1);
>>  	if (efd[0] < 0)
>>  		goto out;
>>
>>  	efd[1] = epoll_create(1);
>>  	if (efd[1] < 0)
>>  		goto out;
>>
>>  	e.events = EPOLLIN;
>>  	if (epoll_ctl(efd[1], EPOLL_CTL_ADD, sfd[0], &e) < 0)
>>  		goto out;
>>
>>  	e.events = EPOLLIN | EPOLLET;
>>  	if (epoll_ctl(efd[0], EPOLL_CTL_ADD, efd[1], &e) < 0)
>>  		goto out;
>>
>>  	if (write(sfd[1], "w", 1) != 1)
>>  		goto out;
>>
>>  	if (epoll_wait(efd[0], &e, 1, 0) != 1)
>>  		goto out;
>>
>>  	if (epoll_wait(efd[0], &e, 1, 0) != 0)
>>  		goto out;
>>
>>  	close(efd[0]);
>>  	close(efd[1]);
>>  	close(sfd[0]);
>>  	close(sfd[1]);
>>
>>  	return 0;
>>
>>  out:
>>  	return -1;
>>  }
>>
>> More tests:
>>  https://github.com/heiher/epoll-wakeup
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
>>  fs/eventpoll.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
>> index c4159bcc05d9..fa71468dbd51 100644
>> --- a/fs/eventpoll.c
>> +++ b/fs/eventpoll.c
>> @@ -685,6 +685,9 @@ static __poll_t ep_scan_ready_list(struct eventpoll *ep,
>>  	if (!ep_locked)
>>  		mutex_lock_nested(&ep->mtx, depth);
>>  
>> +	if (!depth || list_empty_careful(&ep->rdllist))
>> +		pwake++;
>> +
>>  	/*
>>  	 * Steal the ready list, and re-init the original one to the
>>  	 * empty list. Also, set ep->ovflist to NULL so that events
>> @@ -755,7 +758,7 @@ static __poll_t ep_scan_ready_list(struct eventpoll *ep,
>>  		mutex_unlock(&ep->mtx);
>>  
>>  	/* We have to call this outside the lock */
>> -	if (pwake)
>> +	if (pwake == 2)
>>  		ep_poll_safewake(&ep->poll_wait);
>>  
>>  	return res;
>>
> 
> 
> Hi,
> 
> I was thinking more like the following. I tried it using your test-suite
> and it seems to work. What do you think?
> 
> Thanks,
> 
> -Jason
> 
> 
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index d7f1f50..662136b 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -712,6 +712,15 @@ static __poll_t ep_scan_ready_list(struct eventpoll
> *ep,
>         for (nepi = READ_ONCE(ep->ovflist); (epi = nepi) != NULL;
>              nepi = epi->next, epi->next = EP_UNACTIVE_PTR) {
>                 /*
> +                * We only need to wakeup nested epoll fds if
> +                * if something has been queued to the overflow list,
> +                * since the ep_poll() traverses the rdllist during
> +                * recursive poll and thus events on the overflow list
> +                * may not be visible yet.
> +                */
> +               if (!pwake)
> +                       pwake++;
> +               /*
>                  * We need to check if the item is already in the list.
>                  * During the "sproc" callback execution time, items are
>                  * queued into ->ovflist but the "txlist" might already
> @@ -755,7 +764,7 @@ static __poll_t ep_scan_ready_list(struct eventpoll *ep,
>                 mutex_unlock(&ep->mtx);
> 
>         /* We have to call this outside the lock */
> -       if (pwake)
> +       if (pwake == 2)
>                 ep_poll_safewake(&ep->poll_wait);
> 
>         return res;
> 
> 


Also, probably better to not have that 'if' in the loop, so how about
the following?


diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index d7f1f50..ed0d8da 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -704,12 +704,21 @@ static __poll_t ep_scan_ready_list(struct
eventpoll *ep,
        res = (*sproc)(ep, &txlist, priv);

        write_lock_irq(&ep->lock);
+       nepi = READ_ONCE(ep->ovflist);
+       /*
+        * We only need to wakeup nested epoll fds if something has been
queued
+        * to the overflow list, since the ep_poll() traverses the rdllist
+        * during recursive poll and thus events on the overflow list
may not be
+        * visible yet.
+        */
+       if (nepi != NULL)
+               pwake++;
        /*
         * During the time we spent inside the "sproc" callback, some
         * other events might have been queued by the poll callback.
         * We re-insert them inside the main ready-list here.
         */
-       for (nepi = READ_ONCE(ep->ovflist); (epi = nepi) != NULL;
+       for (; (epi = nepi) != NULL;
             nepi = epi->next, epi->next = EP_UNACTIVE_PTR) {
                /*
                 * We need to check if the item is already in the list.
@@ -755,7 +764,7 @@ static __poll_t ep_scan_ready_list(struct eventpoll *ep,
                mutex_unlock(&ep->mtx);

        /* We have to call this outside the lock */
-       if (pwake)
+       if (pwake == 2)
                ep_poll_safewake(&ep->poll_wait);

        return res;

