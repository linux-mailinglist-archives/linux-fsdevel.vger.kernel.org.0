Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58DB1FFF3D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 02:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbgFSA16 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 20:27:58 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37290 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgFSA15 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 20:27:57 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05J0M2u0004756;
        Fri, 19 Jun 2020 00:27:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=mZHm+L5Ei1oR1XqCOi3sReF6y81eXJTuWYq1i07VHxc=;
 b=YuKX4BOpzlRKsrGXHMuPk/Yi06HFsG8RxziPXHMVeobCjvE6vkITeNYsd2g7VHDWuXqG
 dUJdhwrfVho+sWi/FpqTcnGKQtEiZuAa7LQosMRTjZ3qZFrdtUf0CSMnpBaoc36Wqqhf
 OUTQX5lxW6qNFMM6MydbVHVK3rrZuOkD46a2v7NfYoUnTpSIq99xrRpe3wxaNDAzm/3W
 Vw9O3QFU43p5dX+JFqTxt8EAtLrdAjQ4sdp9fePBkVIac9hQdi/7woRFQHekSXYXXCyZ
 zhrYZsf3CK6pQxI2X9ehtCfsTve3+gngerXudw3wSagIEzsX3NTNCuyGqj3UqM4Ejdga cQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 31qg35a2m0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Jun 2020 00:27:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05J0JEVO167553;
        Fri, 19 Jun 2020 00:27:46 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 31q66qm8u9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Jun 2020 00:27:45 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05J0Rj3G017571;
        Fri, 19 Jun 2020 00:27:45 GMT
Received: from dhcp-10-159-251-35.vpn.oracle.com (/10.159.251.35)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 18 Jun 2020 17:27:45 -0700
Subject: Re: severe proc dentry lock contention
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <matthew.wilcox@oracle.com>,
        Srinivas Eeda <SRINIVAS.EEDA@oracle.com>,
        "joe.jin@oracle.com" <joe.jin@oracle.com>
References: <54091fc0-ca46-2186-97a8-d1f3c4f3877b@oracle.com>
 <20200618233958.GV8681@bombadil.infradead.org>
 <877dw3apn8.fsf@x220.int.ebiederm.org>
From:   Junxiao Bi <junxiao.bi@oracle.com>
Message-ID: <2cf6af59-e86b-f6cc-06d3-84309425bd1d@oracle.com>
Date:   Thu, 18 Jun 2020 17:27:43 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <877dw3apn8.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9656 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=3
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006190000
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9656 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 clxscore=1011 malwarescore=0 impostorscore=0 adultscore=0
 cotscore=-2147483648 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 suspectscore=3 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006190000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/18/20 5:02 PM, ebiederm@xmission.com wrote:

> Matthew Wilcox <willy@infradead.org> writes:
>
>> On Thu, Jun 18, 2020 at 03:17:33PM -0700, Junxiao Bi wrote:
>>> When debugging some performance issue, i found that thousands of threads
>>> exit around same time could cause a severe spin lock contention on proc
>>> dentry "/proc/$parent_process_pid/task/", that's because threads needs to
>>> clean up their pid file from that dir when exit. Check the following
>>> standalone test case that simulated the case and perf top result on v5.7
>>> kernel. Any idea on how to fix this?
>> Thanks, Junxiao.
>>
>> We've looked at a few different ways of fixing this problem.
>>
>> Even though the contention is within the dcache, it seems like a usecase
>> that the dcache shouldn't be optimised for -- generally we do not have
>> hundreds of CPUs removing dentries from a single directory in parallel.
>>
>> We could fix this within procfs.  We don't have a great patch yet, but
>> the current approach we're looking at allows only one thread at a time
>> to call dput() on any /proc/*/task directory.
>>
>> We could also look at fixing this within the scheduler.  Only allowing
>> one CPU to run the threads of an exiting process would fix this particular
>> problem, but might have other consequences.
>>
>> I was hoping that 7bc3e6e55acf would fix this, but that patch is in 5.7,
>> so that hope is ruled out.
> Does anyone know if problem new in v5.7?  I am wondering if I introduced
> this problem when I refactored the code or if I simply churned the code
> but the issue remains effectively the same.
It's not new issue, we see it in old kernel like v4.14
>
> Can you try only flushing entries when the last thread of the process is
> reaped?  I think in practice we would want to be a little more
> sophisticated but it is a good test case to see if it solves the issue.

Thank you. i will try and let you know.

Thanks,

Junxiao.

>
> diff --git a/kernel/exit.c b/kernel/exit.c
> index cebae77a9664..d56e4eb60bdd 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -152,7 +152,7 @@ void put_task_struct_rcu_user(struct task_struct *task)
>   void release_task(struct task_struct *p)
>   {
>   	struct task_struct *leader;
> -	struct pid *thread_pid;
> +	struct pid *thread_pid = NULL;
>   	int zap_leader;
>   repeat:
>   	/* don't need to get the RCU readlock here - the process is dead and
> @@ -165,7 +165,8 @@ void release_task(struct task_struct *p)
>   
>   	write_lock_irq(&tasklist_lock);
>   	ptrace_release_task(p);
> -	thread_pid = get_pid(p->thread_pid);
> +	if (p == p->group_leader)
> +		thread_pid = get_pid(p->thread_pid);
>   	__exit_signal(p);
>   
>   	/*
> @@ -188,8 +189,10 @@ void release_task(struct task_struct *p)
>   	}
>   
>   	write_unlock_irq(&tasklist_lock);
> -	proc_flush_pid(thread_pid);
> -	put_pid(thread_pid);
> +	if (thread_pid) {
> +		proc_flush_pid(thread_pid);
> +		put_pid(thread_pid);
> +	}
>   	release_thread(p);
>   	put_task_struct_rcu_user(p);
>   
