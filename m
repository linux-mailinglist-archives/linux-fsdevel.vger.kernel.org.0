Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA2A24C98E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 03:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgHUBdS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 21:33:18 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55902 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgHUBdP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 21:33:15 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07L1VYl9196084;
        Fri, 21 Aug 2020 01:33:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 references : message-id : date : mime-version : in-reply-to : content-type
 : content-transfer-encoding; s=corp-2020-01-29;
 bh=4f39ilxG/P91jdcgJcf8p0b7eqgnXUdee/GH7LdbOJ4=;
 b=Rk/dJVKLbYXZEspKU6vvM70WOMG41jCBUQBPMXQupOgEXAw1kgy/TOVGWSOWsnqfG5A+
 nvnJtOq8OPRflwsgAjFeNALc+VQ8rUEFFJqSbkiiHAQn/jrNAsO8jB49euv+Thf1dNPy
 McaCVXYIiqkSqMaKzb1Ng+qrOklU6/aqJMdVabOnHZzVi134G0X5ODCIxn8ZwQvF6X6H
 tgbVSiw++AFNfBHGId5gHHGE/ut6WMm6cfGbJlb5mDMtkBSEWbNhWmBRBtnuZYHDDnA9
 NjnFRBn4rPuPHe6hruBRVWhq7wLOd79HsYc/qqjDelN2lic4WcU/g5f+nQ83WvghRkQ9 hQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 3322bjgb2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Aug 2020 01:33:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07L1RsXi129929;
        Fri, 21 Aug 2020 01:33:14 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 330pvqj671-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Aug 2020 01:33:14 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07L1XChW021130;
        Fri, 21 Aug 2020 01:33:13 GMT
Received: from [10.191.7.165] (/10.191.7.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Aug 2020 18:33:12 -0700
Subject: Re: [PATCH 2/2] writeback: use DEFINE_WAIT_BIT instead of DEFINE_WAIT
 for bit wait queue
From:   Jacob Wen <jian.w.wen@oracle.com>
To:     linux-fsdevel@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org
References: <20200813050552.26856-1-jian.w.wen@oracle.com>
 <20200813050552.26856-2-jian.w.wen@oracle.com>
Message-ID: <0137e0a8-e5c4-2ea0-12e7-2d5a19f827c1@oracle.com>
Date:   Fri, 21 Aug 2020 09:33:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200813050552.26856-2-jian.w.wen@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9719 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 malwarescore=0 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008210011
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9719 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008210012
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
>   fs/fs-writeback.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index a605c3dddabc..3bf751b33b48 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1354,16 +1354,16 @@ void inode_wait_for_writeback(struct inode *inode)
>   static void inode_sleep_on_writeback(struct inode *inode)
>   	__releases(inode->i_lock)
>   {
> -	DEFINE_WAIT(wait);
> +	DEFINE_WAIT_BIT(wait, &inode->i_state, __I_SYNC);
>   	wait_queue_head_t *wqh = bit_waitqueue(&inode->i_state, __I_SYNC);
>   	int sleep;
>   
> -	prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
> +	prepare_to_wait(wqh, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
>   	sleep = inode->i_state & I_SYNC;
>   	spin_unlock(&inode->i_lock);
>   	if (sleep)
>   		schedule();
> -	finish_wait(wqh, &wait);
> +	finish_wait(wqh, &wait.wq_entry);
>   }
>   
>   /*
