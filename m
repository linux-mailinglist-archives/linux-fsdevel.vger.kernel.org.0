Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 210C647A647
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Dec 2021 09:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238085AbhLTIyC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Dec 2021 03:54:02 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:15942 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238060AbhLTIyB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Dec 2021 03:54:01 -0500
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JHYG52T9bzZdkV;
        Mon, 20 Dec 2021 16:50:53 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 20 Dec 2021 16:53:57 +0800
Subject: Re: [PATCH -next] sysctl: returns -EINVAL when a negative value is
 passed to proc_doulongvec_minmax
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <keescook@chromium.org>, <yzaikin@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <yukuai3@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Baokun Li <libaokun1@huawei.com>
References: <20211209085635.1288737-1-libaokun1@huawei.com>
 <Yb+kHuIFnCKcfM5l@bombadil.infradead.org>
From:   "libaokun (A)" <libaokun1@huawei.com>
Message-ID: <4b2cba44-b18a-dd93-b288-c6a487e4857a@huawei.com>
Date:   Mon, 20 Dec 2021 16:53:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <Yb+kHuIFnCKcfM5l@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

在 2021/12/20 5:29, Luis Chamberlain 写道:
> On Thu, Dec 09, 2021 at 04:56:35PM +0800, Baokun Li wrote:
>> When we pass a negative value to the proc_doulongvec_minmax() function,
>> the function returns 0, but the corresponding interface value does not
>> change.
>>
>> we can easily reproduce this problem with the following commands:
>>      `cd /proc/sys/fs/epoll`
>>      `echo -1 > max_user_watches; echo $?; cat max_user_watches`
>>
>> This function requires a non-negative number to be passed in, so when
>> a negative number is passed in, -EINVAL is returned.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>>   kernel/sysctl.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
>> index 7f07b058b180..537d2f75faa0 100644
>> --- a/kernel/sysctl.c
>> +++ b/kernel/sysctl.c
>> @@ -1149,10 +1149,9 @@ static int __do_proc_doulongvec_minmax(void *data, struct ctl_table *table,
>>   					     sizeof(proc_wspace_sep), NULL);
>>   			if (err)
>>   				break;
>> -			if (neg)
>> -				continue;
>> +
>>   			val = convmul * val / convdiv;
>> -			if ((min && val < *min) || (max && val > *max)) {
>> +			if (neg || (min && val < *min) || (max && val > *max)) {
>>   				err = -EINVAL;
>>   				break;
>>   			}
> I'd much prefer if we stick to the pattern:
>
> err = proc_get_long(...);
> if (err || neg) {
> 	err = -EINVAL;
> 	break;
> }
>
> Look at the other proc_get_long() uses.
>
> But otherwise yes we should do this, please Cc Andrew Morton in your
> next patch and I'll Ack it. Also extend the commit log to include that
> proc_get_long() always returns -EINVAL on error and so we embrace the
> pattern already used in other places where we also check for a negative
> value and it is not allowed.

I will send a patch V2 with the changes suggested by you. Thank you!

>
> Did you get to inspect all other unsigned proc calls? If not feel free,
> and thanks for your patch!!!
A total of 91 interfaces are involved.
82 interfaces related to proc_doulongvec_minmax.
9 related to proc_doulongvec_ms_jiffies_minmax.

Before this patch is installed, three interfaces are faulty.
     /proc/sys/vm/dirty_background_bytes
     /proc/sys/vm/dirty_bytes
     /proc/sys/vm/overcommit_kbytes
The three interfaces have corresponding *_ratio interfaces,
Take dirty_bytes as an example.
If the value of dirty_ratio is not 0, the value of dirty_bytes is 0.
In this case, the value -1 is transferred to dirty_bytes,
and the value of dirty_bytes is still 0.
However, because the return value is 0, dirty_ratio is also set to 0.
This is true of all three interfaces, which can cause some problems.

All involved interfaces are as follows:
```
/proc/sys/vm/cmm_pages
/proc/sys/vm/cmm_timed_pages
/proc/sys/vm/cmm_pages
/proc/sys/vm/cmm_timed_pages
/proc/sys/vm/cmm_pages
/proc/sys/vm/cmm_timed_pages
/proc/sys/fs/file-nr
/proc/sys/fs/inode-nr | inode-state
/proc/sys/fs/nfs/nlm_grace_period
/proc/sys/fs/nfs/nlm_timeout
/proc/sys/fs/fanotify/max_user_groups
/proc/sys/fs/fanotify/max_user_marks
/proc/sys/fs/inotify/max_user_instances
/proc/sys/fs/inotify/max_user_watches
/proc/sys/fs/quota/lookups
/proc/sys/fs/quota/drops
/proc/sys/fs/quota/reads
/proc/sys/fs/quota/writes
/proc/sys/fs/quota/cache_hits
/proc/sys/fs/quota/allocated_dquots
/proc/sys/fs/quota/free_dquots
/proc/sys/fs/quota/syncs
/proc/sys/kernel/shmmax
/proc/sys/kernel/shmall
/proc/sys/kernel/hung_task_check_interval_secs
/proc/sys/kernel/hung_task_timeout_secs
/proc/sys/kernel/tainted
/proc/sys/kernel/panic_print
/proc/sys/kernel/acpi_video_flags
/proc/sys/kernel/user_reserve_kbytes
/proc/sys/kernel/admin_reserve_kbytes
/proc/sys/kernel/file-max
/proc/sys/kernel/aio-nr
/proc/sys/kernel/aio-max-nr
/proc/sys/kernel/pipe-user-pages-hard
/proc/sys/kernel/pipe-user-pages-soft
/proc/sys/user/max_cgroup_namespaces
/proc/sys/user/max_user_namespaces
/proc/sys/user/max_pid_namespaces
/proc/sys/user/max_uts_namespaces
/proc/sys/user/max_ipc_namespaces
/proc/sys/user/max_net_namespaces
/proc/sys/user/max_mnt_namespaces
/proc/sys/user/max_time_namespaces
/proc/sys/user/max_inotify_instances
/proc/sys/user/max_inotify_watches
/proc/sys/user/max_fanotify_groups
/proc/sys/user/max_fanotify_marks
/proc/sys/kernel/bset
/proc/sys/kernel/inheritable
/proc/sys/kernel/nr_hugepages
/proc/sys/kernel/nr_hugepages_mempolicy
/proc/sys/kernel/nr_overcommit_hugepages
/proc/sys/vm/dirty_background_bytes
/proc/sys/vm/dirty_bytes
/proc/sys/vm/overcommit_kbytes
/proc/sys/net/core/bpf_jit_limit
/proc/sys/net/dccp/default/seq_window
/proc/sys/net/decnet/decnet_mem
/proc/sys/net/ieee802154/6lowpan/6lowpanfrag_high_thresh
/proc/sys/net/ieee802154/6lowpan/6lowpanfrag_low_thresh
/proc/sys/net/ipv4/ipfrag_high_thresh
/proc/sys/net/ipv4/ipfrag_low_thresh
/proc/sys/net/ipv4/tcp_mem
/proc/sys/net/ipv4/udp_mem
/proc/sys/net/ipv4/tcp_comp_sack_delay_ns
/proc/sys/net/ipv4/tcp_comp_sack_slack_ns
/proc/sys/net/netfilter/nf_conntrack_frag6_low_thresh
/proc/sys/net/netfilter/nf_conntrack_frag6_high_thresh
/proc/sys/net/ipv6/ip6frag_high_thresh
/proc/sys/net/ipv6/ip6frag_low_thresh
/proc/sys/net/ipv6/ioam6_id_wide
/proc/sys/net/ipv4/vs/sync_qlen_max
/proc/sys/net/rds/ib/max_send_wr
/proc/sys/net/rds/ib/max_recv_wr
/proc/sys/net/rds/ib/max_unsignaled_wr
/proc/sys/net/rds/ib/max_recv_allocation
/proc/sys/net/sctp/sctp_mem
/proc/sys/net/sctp/max_autoclose
/proc/sys/net/tipc/sk_filter
/proc/sys/net/tipc/bc_retruni
/proc/sys/vm/mmap_min_addr
/proc/parport/*/timeslice
/proc/parport/default/timeslice
/proc/sys/net/rds/reconnect_min_delay_ms
/proc/sys/net/rds/reconnect_max_delay_ms
/proc/sys/net/rxrpc/req_ack_delay
/proc/sys/net/rxrpc/soft_ack_delay
/proc/sys/net/rxrpc/idle_ack_delay
/proc/sys/net/rxrpc/idle_conn_expiry
/proc/sys/net/rxrpc/idle_conn_fast_expiry
```
> Curious do you have docs on Hulk Robot?

Hulk Robot is Huawei's internal test framework. It contains many things.

Here is, test whether the return values corresponding to the five cases 
0, -1, min-1, max+1, and normal are normal.


This is found when we test the parameter range of the self-developed 
ulong interface.

That is, we simply transfer a negative value and find that 0 is 
returned. After analysis,

it is found that only the returned value is incorrect, and the value in 
the interface does not change.

>
>    Luis
> .


-- 
With Best Regards,
Baokun Li

