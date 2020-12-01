Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6082CB117
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 00:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgLAXu0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 18:50:26 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:51762 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgLAXuZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 18:50:25 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B1NkfoS159095;
        Tue, 1 Dec 2020 23:49:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=zYc/7KhhD/QqsLlcBZlfwXaD6nCsAYdTZXO0MGw6Xek=;
 b=JYej3CBPea6auedNJn7kva61gHkZj8qJwRzQcP3szCl3lBbOMB6QgPLPYqU/kJ55S6kt
 xfwG1+uU4+OSRD9KPqp6U8XkHLXqpkXr26SPVURu+Xc6IjAhxuGfhBm0jO1aIWbxt8HW
 gxefyKPsglbM7oA0A+5m10Wfkf1xS6MmZN88kvvMbJHZvIuxXWYV8wUyNwdV4sz/ne5R
 nry+DmQX+PxBGHCKv0/YRfs7XPigzV00zx6Pfw8tn/bFIzhJVra5yw44Nykowf9d+SXH
 XXlLloah7HsrCdN2Yx4/MWtChAxr5svnMKhSU5AIq7kjj2Lj73u2asacPdPtnafLbveQ ig== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 353egkncgp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 01 Dec 2020 23:49:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B1NkPx8072471;
        Tue, 1 Dec 2020 23:49:18 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 35404nhr7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Dec 2020 23:49:18 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B1Nn9XC006999;
        Tue, 1 Dec 2020 23:49:10 GMT
Received: from localhost (/10.159.227.169)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Dec 2020 15:49:09 -0800
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] proc: Allow pid_revalidate() during LOOKUP_RCU
In-Reply-To: <87zh2yh8ti.fsf@x220.int.ebiederm.org>
References: <20201130200619.84819-1-stephen.s.brennan@oracle.com>
 <87zh2yh8ti.fsf@x220.int.ebiederm.org>
Date:   Tue, 01 Dec 2020 15:49:07 -0800
Message-ID: <87zh2xjde4.fsf@stepbren-lnx.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9822 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=800 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012010140
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9822 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=1
 phishscore=0 mlxlogscore=810 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012010140
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:
> Stephen Brennan <stephen.s.brennan@oracle.com> writes:
>
>> The pid_revalidate() function requires dropping from RCU into REF lookup
>> mode. When many threads are resolving paths within /proc in parallel,
>> this can result in heavy spinlock contention as each thread tries to
>> grab a reference to the /proc dentry (and drop it shortly thereafter).
>>
>> Allow the pid_revalidate() function to execute under LOOKUP_RCU. When
>> updates must be made to the inode due to the owning task performing
>> setuid(), drop out of RCU and into REF mode.
>
> So rather than get_task_rcu_user.  I think what we want is a function
> that verifies task->rcu_users > 0.
>
> Which frankly is just "pid_task(proc_pid(inode), PIDTYPE_PID)".
>
> Which is something that we can do unconditionally in pid_revalidate.
>
> Skipping the update of the inode is probably the only thing that needs
> to be skipped.
>
> It looks like the code can safely rely on the the security_task_to_inode
> in proc_pid_make_inode and remove the security_task_to_inode in
> pid_update_inode.
>

This makes sense, I'll get rid of the get_task_rcu_user() stuff in a v2.

>
>> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
>> ---
>>
>> I'd like to use this patch as an RFC on this approach for reducing spinlock
>> contention during many parallel path lookups in the /proc filesystem. The
>> contention can be triggered by, for example, running ~100 parallel instances of
>> "TZ=/etc/localtime ps -fe >/dev/null" on a 100CPU machine. The %sys utilization
>> in such a case reaches around 90%, and profiles show two code paths with high
>> utilization:
>
> Do you have a real world work-load that is behaves something like this
> micro benchmark?  I am just curious how severe the problem you are
> trying to solve is.
>

We have seen this issue occur internally with monitoring scripts
(perhaps a bit misconfigured, I'll admit). However I don't have an exact
sample workload that I can give you.

Thanks,
Stephen
