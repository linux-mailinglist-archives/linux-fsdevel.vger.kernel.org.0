Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51898202F68
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 07:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgFVFQV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 01:16:21 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56900 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgFVFQU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 01:16:20 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05M52HFY130522;
        Mon, 22 Jun 2020 05:15:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=6XhL61uLBRsGx4qqMyCILKTmquZ28D8Zmwjf5hvNpqU=;
 b=JINrqbh6lenpOpaHRClW2mmHVaEQrXJBbRa/7+tvBd4SZImgmaB+tbTAHuovamFpSF67
 D/PDrEf8UTlcpw2io7YFlzjKCF+cuiTzCwN5NE1IH7f1J7egeEj13cpODW/q1WkcBKie
 tZ5KeabloQLlaNcv4ErRsEuLnyET1vEv5IpUed50bwnioO7lHrDanG5o5vDk40v8gKe7
 A4UQ7tRpZ6WbfGBkCO6uN2QfA+u+Hd/2WXhd9RXQYsqboZeo8Sh9T+IFF7vOAbcUGrcE
 4rGD72fsKwYYFZjvL3zNrCv9MdDYBHn9ocCT3K8qlQdiD5PlsmMtPty8jbcG+z+83JEl DA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 31sebbca28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Jun 2020 05:15:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05M54250096345;
        Mon, 22 Jun 2020 05:15:50 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 31sv7pev7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Jun 2020 05:15:49 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05M5FfKI003483;
        Mon, 22 Jun 2020 05:15:41 GMT
Received: from Junxiaos-MacBook-Pro.local (/73.231.9.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Jun 2020 05:15:41 +0000
Subject: Re: [PATCH] proc: Avoid a thundering herd of threads freeing proc
 dentries
To:     Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
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
From:   Junxiao Bi <junxiao.bi@oracle.com>
Message-ID: <39e9f488-110c-588d-d977-413da3dc5dfa@oracle.com>
Date:   Sun, 21 Jun 2020 22:15:39 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200620162752.GF8681@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9659 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006220038
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9659 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 cotscore=-2147483648 mlxscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006220038
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/20/20 9:27 AM, Matthew Wilcox wrote:

> On Fri, Jun 19, 2020 at 05:42:45PM -0500, Eric W. Biederman wrote:
>> Junxiao Bi <junxiao.bi@oracle.com> writes:
>>> Still high lock contention. Collect the following hot path.
>> A different location this time.
>>
>> I know of at least exit_signal and exit_notify that take thread wide
>> locks, and it looks like exit_mm is another.  Those don't use the same
>> locks as flushing proc.
>>
>>
>> So I think you are simply seeing a result of the thundering herd of
>> threads shutting down at once.  Given that thread shutdown is fundamentally
>> a slow path there is only so much that can be done.
>>
>> If you are up for a project to working through this thundering herd I
>> expect I can help some.  It will be a long process of cleaning up
>> the entire thread exit process with an eye to performance.
> Wengang had some tests which produced wall-clock values for this problem,
> which I agree is more informative.
>
> I'm not entirely sure what the customer workload is that requires a
> highly threaded workload to also shut down quickly.  To my mind, an
> overall workload is normally composed of highly-threaded tasks that run
> for a long time and only shut down rarely (thus performance of shutdown
> is not important) and single-threaded tasks that run for a short time.

The real workload is a Java application working in server-agent mode, 
issue happened in agent side, all it do is waiting works dispatching 
from server and execute. To execute one work, agent will start lots of 
short live threads, there could be a lot of threads exit same time if 
there were a lots of work to execute, the contention on the exit path 
caused a high %sys time which impacted other workload.

Thanks,

Junxiao.

>
> Understanding this workload is important to my next suggestion, which
> is that rather than searching for all the places in the exit path which
> contend on a single spinlock, we simply set the allowed CPUs for an
> exiting task to include only the CPU that this thread is running on.
> It will probably run faster to take the threads down in series on one
> CPU rather than take them down in parallel across many CPUs (or am I
> mistaken?  Is there inherently a lot of parallelism in the thread
> exiting process?)
