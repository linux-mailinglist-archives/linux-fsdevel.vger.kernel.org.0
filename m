Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41EC24C98C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 03:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgHUBcR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 21:32:17 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38450 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgHUBcQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 21:32:16 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07L1RQuA169617;
        Fri, 21 Aug 2020 01:32:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 references : message-id : date : mime-version : in-reply-to : content-type
 : content-transfer-encoding; s=corp-2020-01-29;
 bh=uIhfs7+1C8pqessy29+fcC/6JOmkc8hDIhW6tbNi4HQ=;
 b=C6d0k9O+YmVvUZJQ6ShUbWm1W0k0EMb6tPIU9pkqTeomj4CTJR1P+xLC9WrH9/4yywcY
 4cUIVRzOKYCjbKoAFNcjGaMM+MNmVGPSgorWgrrUPWxb/oXipjwRMSTU7btTIzNVWjQT
 Cr7difwoq/iXfNgnVb7ieoJRcQJmkZ1MlQ8H5TNvn9QASnlrDcjwpjbo+FgbY2+DO+Ze
 sAkVajhK7e2gM+nk6hNCNMoiVp+zEHDP9fmY3IWSUxjriK6vUyMCxtbid91fAQ4lzSft
 qbPyMj/rL68kUpvHIZEU/Zq1jQuq2Q1B7Qn1CxF92KG7Jmb6zlzxGUHxFpmbYbRaHn5/ eg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 32x8bnknc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Aug 2020 01:32:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07L1T3OU104164;
        Fri, 21 Aug 2020 01:32:14 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 32xsn221qd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Aug 2020 01:32:14 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07L1WDEM020880;
        Fri, 21 Aug 2020 01:32:14 GMT
Received: from [10.191.7.165] (/10.191.7.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Aug 2020 18:32:13 -0700
Subject: Re: [PATCH 1/2] block: use DEFINE_WAIT_BIT instead of DEFINE_WAIT for
 bit wait queue
From:   Jacob Wen <jian.w.wen@oracle.com>
To:     linux-fsdevel@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org
References: <20200813050552.26856-1-jian.w.wen@oracle.com>
Message-ID: <3eff2c13-640e-6686-9a79-70c97e9fdfa5@oracle.com>
Date:   Fri, 21 Aug 2020 09:32:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200813050552.26856-1-jian.w.wen@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9719 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008210011
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9719 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 clxscore=1011 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008210011
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Can I have a review?

On 8/13/20 1:05 PM, Jacob Wen wrote:
> DEFINE_WAIT_BIT uses wake_bit_function() which is able to avoid
> false-wakeups due to possible hash collisions in the bit wait table.
>
> Signed-off-by: Jacob Wen <jian.w.wen@oracle.com>
> ---
>   fs/block_dev.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 0ae656e022fd..ba4fad08cdaf 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -1062,12 +1062,12 @@ static int bd_prepare_to_claim(struct block_device *bdev,
>   	/* if claiming is already in progress, wait for it to finish */
>   	if (whole->bd_claiming) {
>   		wait_queue_head_t *wq = bit_waitqueue(&whole->bd_claiming, 0);
> -		DEFINE_WAIT(wait);
> +		DEFINE_WAIT_BIT(wait, &whole->bd_claiming, 0);
>   
> -		prepare_to_wait(wq, &wait, TASK_UNINTERRUPTIBLE);
> +		prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
>   		spin_unlock(&bdev_lock);
>   		schedule();
> -		finish_wait(wq, &wait);
> +		finish_wait(wq, &wait.wq_entry);
>   		spin_lock(&bdev_lock);
>   		goto retry;
>   	}
