Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8F9B158226
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2020 19:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgBJSSw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 13:18:52 -0500
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127]:53904 "EHLO
        mx0b-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726809AbgBJSSv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:18:51 -0500
Received: from pps.filterd (m0050102.ppops.net [127.0.0.1])
        by m0050102.ppops.net-00190b01. (8.16.0.42/8.16.0.42) with SMTP id 01AIF933004262;
        Mon, 10 Feb 2020 18:18:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=j84QYG7QfjXasGEY9698cV/qPK0gHvVJTOp0hrDGLNI=;
 b=IOZjsXuivE7Ox28KlWNruxzfxbBHBO46qW14o5Wz0Cyy0WQwp4bA3YSVdisXtNJvBUSs
 iYG0ATVJ2CSx8TSrHKtfWdbE3Bkrwc/MWIaTenJhWwizh403kfVMSkillS+hOmgLeQ5r
 NU8vvWnEw5e9fAUSGnGkcFLKrpXvXitq2xNmjRTvdqqbsHSFpnpv6ttMGKVDwb5FJ51m
 SKePr3bJ3HVxUkhwetEMCYfAbhxm/tdNHQQjTB9Ts0lb4eP3zxPzwatmwdtZgx53pccW
 TCYPm7AlinBtcZBbJqCdqJZxsfqA+GnTLyByr8Om+4a73stNa/Y4kmZDsrXDTdof6K0q dQ== 
Received: from prod-mail-ppoint3 (prod-mail-ppoint3.akamai.com [96.6.114.86] (may be forged))
        by m0050102.ppops.net-00190b01. with ESMTP id 2y35c1sk77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Feb 2020 18:18:43 +0000
Received: from pps.filterd (prod-mail-ppoint3.akamai.com [127.0.0.1])
        by prod-mail-ppoint3.akamai.com (8.16.0.27/8.16.0.27) with SMTP id 01AIHVcJ010824;
        Mon, 10 Feb 2020 13:18:42 -0500
Received: from prod-mail-relay15.akamai.com ([172.27.17.40])
        by prod-mail-ppoint3.akamai.com with ESMTP id 2y1s72hyf4-1;
        Mon, 10 Feb 2020 13:18:42 -0500
Received: from [172.28.3.71] (bos-lpjec.145bw.corp.akamai.com [172.28.3.71])
        by prod-mail-relay15.akamai.com (Postfix) with ESMTP id 1D28121F50;
        Mon, 10 Feb 2020 18:18:42 +0000 (GMT)
Subject: Re: [PATCH v2 2/3] epoll: ep->wq can be woken up unlocked in certain
 cases
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Max Neunhoeffer <max@arangodb.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Christopher Kohlhoff <chris.kohlhoff@clearpool.io>,
        Davidlohr Bueso <dbueso@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200210094123.389854-1-rpenyaev@suse.de>
 <20200210094123.389854-2-rpenyaev@suse.de>
From:   Jason Baron <jbaron@akamai.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jbaron@akamai.com; prefer-encrypt=mutual; keydata=
 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
 JeQ7iQ==
Message-ID: <ce0d0c49-7d62-3a5d-7bc7-5b72611f1867@akamai.com>
Date:   Mon, 10 Feb 2020 13:16:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200210094123.389854-2-rpenyaev@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-02-10_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002100136
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-10_06:2020-02-10,2020-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1011 bulkscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002100136
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2/10/20 4:41 AM, Roman Penyaev wrote:
> Now ep->lock is responsible for wqueue serialization, thus if ep->lock
> is taken on write path, wake_up_locked() can be invoked.
> 
> Though, read path is different.  Since concurrent cpus can enter the
> wake up function it needs to be internally serialized, thus wake_up()
> variant is used which implies internal spin lock.
> 
> Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
> Cc: Max Neunhoeffer <max@arangodb.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Christopher Kohlhoff <chris.kohlhoff@clearpool.io>
> Cc: Davidlohr Bueso <dbueso@suse.de>
> Cc: Jason Baron <jbaron@akamai.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  Nothing interesting in v2:
>      changed the comment a bit
> 
>  fs/eventpoll.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index eee3c92a9ebf..6e218234bd4a 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -1173,7 +1173,7 @@ static inline bool chain_epi_lockless(struct epitem *epi)
>   * Another thing worth to mention is that ep_poll_callback() can be called
>   * concurrently for the same @epi from different CPUs if poll table was inited
>   * with several wait queues entries.  Plural wakeup from different CPUs of a
> - * single wait queue is serialized by wq.lock, but the case when multiple wait
> + * single wait queue is serialized by ep->lock, but the case when multiple wait
>   * queues are used should be detected accordingly.  This is detected using
>   * cmpxchg() operation.
>   */
> @@ -1248,6 +1248,12 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
>  				break;
>  			}
>  		}
> +		/*
> +		 * Since here we have the read lock (ep->lock) taken, plural
> +		 * wakeup from different CPUs can occur, thus we call wake_up()
> +		 * variant which implies its own lock on wqueue. All other paths
> +		 * take write lock.
> +		 */
>  		wake_up(&ep->wq);
>  	}
>  	if (waitqueue_active(&ep->poll_wait))
> @@ -1551,7 +1557,7 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
>  
>  		/* Notify waiting tasks that events are available */
>  		if (waitqueue_active(&ep->wq))
> -			wake_up(&ep->wq);
> +			wake_up_locked(&ep->wq);


So I think this will now hit the 'lockdep_assert_held()' in
__wake_up_common()? I agree that its correct, but I think it will
confuse lockdep here...

Thanks,

-Jason
