Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B682012C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 17:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404036AbgFSP4d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 11:56:33 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58444 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392422AbgFSP4b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:56:31 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05JFq3bi170918;
        Fri, 19 Jun 2020 15:56:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=N6oqYfCHp2QV/JmQ5LTSA79FMCO+5ovjIc8N1hvqNII=;
 b=jwcPp93u21clgfcXb8amGQARxjsXxNDJMa5eOGgNveCmOAFbN8qjQT4FS/8lgasOk/j9
 R7ErM8Bs8ONT0q5t+QDEoF1aX7qfN49Jk3pUd5TFHc9jQtMqp2cBHH0GEiU39LxzqcrR
 mMCQCl/OEHGcZPLC/O0RJVowgo+EwVsZxilrRC0kqFp/y/G8ToHnrlsvMX4vF1Hz0sRN
 wwec7UpU3iHZ/xva2LEyFu8/8wabBmr+UyUjPVUuw7JWiD3QBZpycNlvTn3+jCRMdxQB
 sxWAncWKGlBWwrc6V3TvhJpizC1QnYUDD7/XyZ9efthMEddYFsRldrrhUFRmuyAf+7Y1 9w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 31q6607fbj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Jun 2020 15:56:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05JFqadD159790;
        Fri, 19 Jun 2020 15:56:24 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 31q66d78mc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Jun 2020 15:56:24 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05JFuNPN010644;
        Fri, 19 Jun 2020 15:56:23 GMT
Received: from dhcp-10-159-240-10.vpn.oracle.com (/10.159.240.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 19 Jun 2020 08:56:23 -0700
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
From:   Junxiao Bi <junxiao.bi@oracle.com>
Message-ID: <caa9adf6-e1bb-167b-6f59-d17fd587d4fa@oracle.com>
Date:   Fri, 19 Jun 2020 08:56:21 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87bllf87ve.fsf_-_@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9657 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006190116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9657 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0 impostorscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006190116
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Eric,

The patch didn't improve lock contention.

    PerfTop:   48925 irqs/sec  kernel:95.6%  exact: 100.0% lost: 0/0 
drop: 0/0 [4000Hz cycles],  (all, 104 CPUs)
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 


     69.66%  [kernel]                                        [k] 
native_queued_spin_lock_slowpath
      1.93%  [kernel]                                        [k] 
_raw_spin_lock
      1.24%  [kernel]                                        [k] 
page_counter_cancel
      0.70%  [kernel]                                        [k] 
do_syscall_64
      0.62%  [kernel]                                        [k] 
find_idlest_group.isra.96
      0.57%  [kernel]                                        [k] 
queued_write_lock_slowpath
      0.56%  [kernel]                                        [k] d_walk
      0.45%  [kernel]                                        [k] 
clear_page_erms
      0.44%  [kernel]                                        [k] 
syscall_return_via_sysret
      0.40%  [kernel]                                        [k] 
entry_SYSCALL_64
      0.38%  [kernel]                                        [k] 
refcount_dec_not_one
      0.37%  [kernel]                                        [k] 
propagate_protected_usage
      0.33%  [kernel]                                        [k] 
unmap_page_range
      0.33%  [kernel]                                        [k] 
select_collect
      0.32%  [kernel]                                        [k] memcpy_erms
      0.30%  [kernel]                                        [k] 
proc_task_readdir
      0.27%  [kernel]                                        [k] 
_raw_spin_lock_irqsave

Thanks,

Junxiao.

On 6/19/20 7:09 AM, ebiederm@xmission.com wrote:
> Junxiao Bi <junxiao.bi@oracle.com> reported:
>> When debugging some performance issue, i found that thousands of threads exit
>> around same time could cause a severe spin lock contention on proc dentry
>> "/proc/$parent_process_pid/task/", that's because threads needs to clean up
>> their pid file from that dir when exit.
> Matthew Wilcox <willy@infradead.org> reported:
>> We've looked at a few different ways of fixing this problem.
> The flushing of the proc dentries from the dcache is an optmization,
> and is not necessary for correctness.  Eventually cache pressure will
> cause the dentries to be freed even if no flushing happens.  Some
> light testing when I refactored the proc flushg[1] indicated that at
> least the memory footprint is easily measurable.
>
> An optimization that causes a performance problem due to a thundering
> herd of threads is no real optimization.
>
> Modify the code to only flush the /proc/<tgid>/ directory when all
> threads in a process are killed at once.  This continues to flush
> practically everything when the process is reaped as the threads live
> under /proc/<tgid>/task/<tid>.
>
> There is a rare possibility that a debugger will access /proc/<tid>/,
> which this change will no longer flush, but I believe such accesses
> are sufficiently rare to not be observed in practice.
>
> [1] 7bc3e6e55acf ("proc: Use a list of inodes to flush from proc")
> Link: https://lkml.kernel.org/r/54091fc0-ca46-2186-97a8-d1f3c4f3877b@oracle.com
> Reported-by: Masahiro Yamada <masahiroy@kernel.org>
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>
> I am still waiting for word on how this affects performance, but this is
> a clean version that should avoid the thundering herd problem in
> general.
>
>
>   kernel/exit.c | 19 +++++++++++++++----
>   1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/exit.c b/kernel/exit.c
> index cebae77a9664..567354550d62 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -151,8 +151,8 @@ void put_task_struct_rcu_user(struct task_struct *task)
>   
>   void release_task(struct task_struct *p)
>   {
> +	struct pid *flush_pid = NULL;
>   	struct task_struct *leader;
> -	struct pid *thread_pid;
>   	int zap_leader;
>   repeat:
>   	/* don't need to get the RCU readlock here - the process is dead and
> @@ -165,7 +165,16 @@ void release_task(struct task_struct *p)
>   
>   	write_lock_irq(&tasklist_lock);
>   	ptrace_release_task(p);
> -	thread_pid = get_pid(p->thread_pid);
> +
> +	/*
> +	 * When all of the threads are exiting wait until the end
> +	 * and flush everything.
> +	 */
> +	if (thread_group_leader(p))
> +		flush_pid = get_pid(task_tgid(p));
> +	else if (!(p->signal->flags & SIGNAL_GROUP_EXIT))
> +		flush_pid = get_pid(task_pid(p));
> +
>   	__exit_signal(p);
>   
>   	/*
> @@ -188,8 +197,10 @@ void release_task(struct task_struct *p)
>   	}
>   
>   	write_unlock_irq(&tasklist_lock);
> -	proc_flush_pid(thread_pid);
> -	put_pid(thread_pid);
> +	if (flush_pid) {
> +		proc_flush_pid(flush_pid);
> +		put_pid(flush_pid);
> +	}
>   	release_thread(p);
>   	put_task_struct_rcu_user(p);
>   
