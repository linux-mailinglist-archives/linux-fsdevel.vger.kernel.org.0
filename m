Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F24269192
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Sep 2020 18:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgINQcU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 12:32:20 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41028 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgINQcO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 12:32:14 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08EGPXrX112214;
        Mon, 14 Sep 2020 16:31:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Evh2jsniAFKHtrc5+Oi5f7q5JnurDPbwp2ePFfWfGgA=;
 b=g4+VVkynB3PXXkpaEe3vbY2N5Hj/gkN3QmlYB+JVQ/RmurzmNnTZnPMuhRI4p76N61ui
 BabxXQh9sUugesUMD9B8aFk3gxlCfJ94SXfrqk1CEqLe06eIlMomnTvaQHdPf1zy1fnl
 CVvEFdNPOIiBO6fFA+y1/apY9n9nMzy7BYoPB5ImJCu2zi5nAUTQrfQoH/9Bgsicvh11
 4ca41Qp1xXBq4c3b1+7eZV9H289lZyxZnmqn/pvBSqEz0LUT1W+RxYKxdDZkhI7blt8D
 L28lrqlBpLUZkNsPy2FMHgjM+EXNPHrTgxGDkEauxcH9Bj6IQrR1hQ/ks1Yaxjtx7hVv FQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 33gnrqqqb2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Sep 2020 16:31:56 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08EGTtNW142320;
        Mon, 14 Sep 2020 16:31:56 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 33h7wmennp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Sep 2020 16:31:55 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08EGVsWH013859;
        Mon, 14 Sep 2020 16:31:54 GMT
Received: from OracleT490.vogsphere (/73.203.30.179)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 14 Sep 2020 16:31:54 +0000
Subject: Re: [RESEND PATCH 0/2] iowait and idle fixes in /proc/stat
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        adobriyan@gmail.com
References: <20200909144122.77210-1-tom.hromatka@oracle.com>
From:   Tom Hromatka <tom.hromatka@oracle.com>
Message-ID: <11c8b2ee-7d87-ae0b-c11b-71a052865000@oracle.com>
Date:   Mon, 14 Sep 2020 10:31:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200909144122.77210-1-tom.hromatka@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9744 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009140133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9744 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009140132
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks for your time and  feedback, Thomas and Alexey.  I'll
address the comments and send out a v2 in the next couple
days.

Thanks!

Tom


On 9/9/20 8:41 AM, Tom Hromatka wrote:
> A customer is using /proc/stat to track cpu usage in a VM and noted
> that the iowait and idle times behave strangely when a cpu goes
> offline and comes back online.
>
> This patchset addresses two issues that can cause iowait and idle
> to fluctuate up and down.  With these changes, cpu iowait and idle
> now only monotonically increase.
>
> Tom Hromatka (2):
>    tick-sched: Do not clear the iowait and idle times
>    /proc/stat: Simplify iowait and idle calculations when cpu is offline
>
>   fs/proc/stat.c           | 24 ++++++------------------
>   kernel/time/tick-sched.c |  9 +++++++++
>   2 files changed, 15 insertions(+), 18 deletions(-)
>

