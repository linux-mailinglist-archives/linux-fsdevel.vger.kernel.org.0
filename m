Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B455221FBC7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 21:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731063AbgGNTEZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 15:04:25 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53036 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730936AbgGNS4C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:56:02 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06EIg5nH123000;
        Tue, 14 Jul 2020 18:55:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=zBSFWFJmK6H6QUNUzT1isFDg2o5kHAYgey+PVkvmy3A=;
 b=0gYbMbZrTAKzqSs2uR5NW6kMPhqX/DyK3rUF6liKEMQa3koTon0ow0cqknhFyywpq/wA
 Rbf/qWKjaJ6oUkh3kA1XsauNCBe+9dwPXZE3JFMZBXQxAkYtBmrQGc1m0FP+gxMUyLn0
 mgTDeZfuIu9cyZ72cuAFJVAbMqgNJhwuLKrHAtiO7qOofQIb6rbeujmg2k/vcVEwYZNw
 bLg1guO8SSaA9zbBn9BMaq+I6V8CHulxgINt7q0/q13i8CLZyasB/SxLvYfz7bCgp8ia
 WagyEEEtcsMNbdU3R+4qLGlmEC4+4sPX8nuFkIaIA8kgmcIZ7u2DG3JyG65JAC1Eb3s1 1w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 3274ur7afj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Jul 2020 18:55:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06EIhbb1092521;
        Tue, 14 Jul 2020 18:55:45 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 327q0ps5x5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jul 2020 18:55:45 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06EIthgF006460;
        Tue, 14 Jul 2020 18:55:43 GMT
Received: from OracleT490.vogsphere (/73.203.30.179)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Jul 2020 11:55:42 -0700
Subject: Re: [PATCH 0/2] iowait and idle fixes in /proc/stat
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tglx@linutronix.de
Cc:     fweisbec@gmail.com, mingo@kernel.org, adobriyan@gmail.com
References: <20200610210549.61193-1-tom.hromatka@oracle.com>
From:   Tom Hromatka <tom.hromatka@oracle.com>
Message-ID: <85937052-fcdf-8bd7-83ec-831a51e320cb@oracle.com>
Date:   Tue, 14 Jul 2020 12:55:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200610210549.61193-1-tom.hromatka@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9682 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007140133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9682 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007140133
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ping.

Thanks.

Tom


On 6/10/20 3:05 PM, Tom Hromatka wrote:
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

