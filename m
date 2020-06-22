Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B36203D9B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 19:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729866AbgFVRQT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 13:16:19 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54982 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729605AbgFVRQS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 13:16:18 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05MHCK42001951;
        Mon, 22 Jun 2020 17:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=ci1IJQ0RoehL2DDOcJn9MgU2FhV6BbVz7B8OziZTtFk=;
 b=zwn0HsJnSJe8xXH/vKWdlwfzxVXYUUKTXv2xUH7PR4Ngf4wuAR+zNc0h/QfVM17ndQ3L
 kdQjVXW9oRyzp93BvTtEgyCNNa4u3hfww0hdMgN/KGD5NEaCJVMpXfyCbGH+1DBpni6R
 CLywCs+2VbSO+9JJaqvR3Lo6JU6VrtEP6rLhImEQy1b4X4hgKaFWJOBfdNa0WA7vpVgg
 IPlZrf8gN7rccezMwkbL8BTM9MQFU2hpza4/5hOXwrVLGcZmfjpIQLJ+us0i97T/KiDW
 eaqEYQKI8sfMMAPWTzgvz1JJieC0Yfo20QUbfnxvR3BRfyanwk8HVvXxc20jeZLiSVIW 7A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 31sebbgmwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Jun 2020 17:16:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05MHDbYr034023;
        Mon, 22 Jun 2020 17:16:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 31sv1m3avr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Jun 2020 17:16:08 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05MHG7b9020609;
        Mon, 22 Jun 2020 17:16:07 GMT
Received: from dhcp-10-159-159-167.vpn.oracle.com (/10.159.159.167)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Jun 2020 17:16:07 +0000
Subject: Re: [PATCH] proc: Avoid a thundering herd of threads freeing proc
 dentries
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <matthew.wilcox@oracle.com>,
        Srinivas Eeda <SRINIVAS.EEDA@oracle.com>,
        "joe.jin@oracle.com" <joe.jin@oracle.com>,
        Wengang Wang <wen.gang.wang@oracle.com>
References: <54091fc0-ca46-2186-97a8-d1f3c4f3877b@oracle.com>
 <20200618233958.GV8681@bombadil.infradead.org>
 <877dw3apn8.fsf@x220.int.ebiederm.org>
 <2cf6af59-e86b-f6cc-06d3-84309425bd1d@oracle.com>
 <87bllf87ve.fsf_-_@x220.int.ebiederm.org>
 <caa9adf6-e1bb-167b-6f59-d17fd587d4fa@oracle.com>
 <87k1036k9y.fsf@x220.int.ebiederm.org>
 <68a1f51b-50bf-0770-2367-c3e1b38be535@oracle.com>
 <87blle4qze.fsf@x220.int.ebiederm.org>
 <20200620162752.GF8681@bombadil.infradead.org>
 <39e9f488-110c-588d-d977-413da3dc5dfa@oracle.com>
 <87d05r2kl3.fsf@x220.int.ebiederm.org>
From:   Junxiao Bi <junxiao.bi@oracle.com>
Message-ID: <c7fcf5f6-b289-96a6-0e1b-0969254c0f22@oracle.com>
Date:   Mon, 22 Jun 2020 10:16:05 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87d05r2kl3.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9660 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=960
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=3 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006220120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9660 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=963 cotscore=-2147483648 mlxscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=3 clxscore=1015
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006220120
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/22/20 8:20 AM, ebiederm@xmission.com wrote:

> If I understand correctly, the Java VM is not exiting.  Just some of
> it's threads.
>
> That is a very different problem to deal with.  That are many
> optimizations that are possible when_all_  of the threads are exiting
> that are not possible when_many_  threads are exiting.
>
> Do you know if it is simply the cpu time or if it is the lock contention
> that is the problem?  If it is simply the cpu time we should consider if
> some of the locks that can be highly contended should become mutexes.
> Or perhaps something like Matthew's cpu pinning idea.

The problem is high %sys time.

Thanks,

Junxiao.

