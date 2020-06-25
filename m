Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76FD620A804
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jun 2020 00:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407438AbgFYWLt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jun 2020 18:11:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58940 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406185AbgFYWLt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jun 2020 18:11:49 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05PM75Rx095108;
        Thu, 25 Jun 2020 22:11:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=FOsPKOBw8JhBn7MlrPdKjynMw6RX6AWuVSV+m5pQ4/k=;
 b=dYO26/q3z86pxUqvnodnz99HOvO2iW2f9CciZ0wwtTUNZXRTDzZU4J/REh3plp5MfHME
 vXKiIhLZmQOoClW4JGUNfQrcpQk+YTMldkfYu25+fAZQq3gEKdM1F6sL0EYx9PJRz3/J
 513lT9SdkS21k6J7cYPDK1GOXV3evNWQjh4gNCgfPiasFrzE3F6odS+h8lgA5yzXnlLZ
 S6pLaNXgkf2Rfw7+XUEGx4594TWxwYQfbdeU+3rCfB6kIYG8fd8kZOcCKOIi8sXZzssM
 77zvABjuswfPpt0meVuXmGs3dIqKep1gLxAZnWlFJvkVWbGgEJ7h0ew8vJ6r/iHrl1Lr ag== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 31uut5u32w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 Jun 2020 22:11:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05PM8HFV067379;
        Thu, 25 Jun 2020 22:11:24 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 31uur9nj7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jun 2020 22:11:24 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05PMBJYD019214;
        Thu, 25 Jun 2020 22:11:19 GMT
Received: from dhcp-10-159-245-149.vpn.oracle.com (/10.159.245.149)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 25 Jun 2020 22:11:18 +0000
Subject: Re: [PATCH] proc: Avoid a thundering herd of threads freeing proc
 dentries
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <matthew.wilcox@oracle.com>,
        Srinivas Eeda <SRINIVAS.EEDA@oracle.com>,
        "joe.jin@oracle.com" <joe.jin@oracle.com>,
        Wengang Wang <wen.gang.wang@oracle.com>
References: <20200618233958.GV8681@bombadil.infradead.org>
 <877dw3apn8.fsf@x220.int.ebiederm.org>
 <2cf6af59-e86b-f6cc-06d3-84309425bd1d@oracle.com>
 <87bllf87ve.fsf_-_@x220.int.ebiederm.org>
 <caa9adf6-e1bb-167b-6f59-d17fd587d4fa@oracle.com>
 <87k1036k9y.fsf@x220.int.ebiederm.org>
 <68a1f51b-50bf-0770-2367-c3e1b38be535@oracle.com>
 <87blle4qze.fsf@x220.int.ebiederm.org>
 <20200620162752.GF8681@bombadil.infradead.org>
 <39e9f488-110c-588d-d977-413da3dc5dfa@oracle.com>
 <20200623004756.GE21350@casper.infradead.org>
From:   Junxiao Bi <junxiao.bi@oracle.com>
Message-ID: <5421d6d6-1b00-865a-a992-e2337f044188@oracle.com>
Date:   Thu, 25 Jun 2020 15:11:17 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200623004756.GE21350@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9663 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 suspectscore=3 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006250129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9663 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0 suspectscore=3
 phishscore=0 impostorscore=0 cotscore=-2147483648 priorityscore=1501
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006250129
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/22/20 5:47 PM, Matthew Wilcox wrote:

> On Sun, Jun 21, 2020 at 10:15:39PM -0700, Junxiao Bi wrote:
>> On 6/20/20 9:27 AM, Matthew Wilcox wrote:
>>> On Fri, Jun 19, 2020 at 05:42:45PM -0500, Eric W. Biederman wrote:
>>>> Junxiao Bi <junxiao.bi@oracle.com> writes:
>>>>> Still high lock contention. Collect the following hot path.
>>>> A different location this time.
>>>>
>>>> I know of at least exit_signal and exit_notify that take thread wide
>>>> locks, and it looks like exit_mm is another.  Those don't use the same
>>>> locks as flushing proc.
>>>>
>>>>
>>>> So I think you are simply seeing a result of the thundering herd of
>>>> threads shutting down at once.  Given that thread shutdown is fundamentally
>>>> a slow path there is only so much that can be done.
>>>>
>>>> If you are up for a project to working through this thundering herd I
>>>> expect I can help some.  It will be a long process of cleaning up
>>>> the entire thread exit process with an eye to performance.
>>> Wengang had some tests which produced wall-clock values for this problem,
>>> which I agree is more informative.
>>>
>>> I'm not entirely sure what the customer workload is that requires a
>>> highly threaded workload to also shut down quickly.  To my mind, an
>>> overall workload is normally composed of highly-threaded tasks that run
>>> for a long time and only shut down rarely (thus performance of shutdown
>>> is not important) and single-threaded tasks that run for a short time.
>> The real workload is a Java application working in server-agent mode, issue
>> happened in agent side, all it do is waiting works dispatching from server
>> and execute. To execute one work, agent will start lots of short live
>> threads, there could be a lot of threads exit same time if there were a lots
>> of work to execute, the contention on the exit path caused a high %sys time
>> which impacted other workload.
> How about this for a micro?  Executes in about ten seconds on my laptop.
> You might need to tweak it a bit to get better timing on a server.
>
> // gcc -pthread -O2 -g -W -Wall
> #include <pthread.h>
> #include <unistd.h>
>
> void *worker(void *arg)
> {
> 	int i = 0;
> 	int *p = arg;
>
> 	for (;;) {
> 		while (i < 1000 * 1000) {
> 			i += *p;
> 		}
> 		sleep(1);
> 	}
> }
>
> int main(int argc, char **argv)
> {
> 	pthread_t threads[20][100];

Tuning 100 to 1000 here and the following 2 loops.

Test it on 2-socket server with 104 cpu. Perf is similar on v5.7 and 
v5.7 with Eric's fix. The spin lock was shifted to spin lock in futex, 
so the fix didn't help.


     46.41%     0.11%  perf_test        [kernel.kallsyms] [k] 
entry_SYSCALL_64_after_hwframe
             |
              --46.30%--entry_SYSCALL_64_after_hwframe
                        |
                         --46.12%--do_syscall_64
                                   |
                                   |--30.47%--__x64_sys_futex
                                   |          |
                                   |           --30.45%--do_futex
                                   |                     |
                                   | |--18.04%--futex_wait
                                   |                     | |
                                   |                     | 
|--16.94%--futex_wait_setup
                                   |                     | |          |
                                   |                     | |           
--16.61%--_raw_spin_lock
                                   |                     | 
|                     |
                                   |                     | 
|                      --16.30%--native_queued_spin_lock_slowpath
                                   |                     | 
|                                |
                                   |                     | 
|                                 --0.81%--call_function_interrupt
                                   |                     | 
|                                           |
                                   |                     | | 
--0.79%--smp_call_function_interrupt
                                   |                     | 
|                                                      |
                                   |                     | | 
--0.62%--generic_smp_call_function_single_interrupt
                                   |                     | |
                                   | |           
--1.04%--futex_wait_queue_me
                                   | |                     |
                                   | |                      
--0.96%--schedule
                                   | |                                |
                                   | |                                 
--0.94%--__schedule
                                   | 
|                                           |
                                   | | --0.51%--pick_next_task_fair
                                   |                     |
                                   | --12.38%--futex_wake
                                   | |
                                   | |--11.00%--_raw_spin_lock
                                   | |          |
                                   | |           
--10.76%--native_queued_spin_lock_slowpath
                                   | |                     |
                                   | |                      
--0.55%--call_function_interrupt
                                   | |                                |
                                   | | --0.53%--smp_call_function_interrupt
                                   | |
|                                 --1.11%--wake_up_q
|                                           |
| --1.10%--try_to_wake_up
                                   |


Result of v5.7

=========

[root@jubi-bm-ol8 upstream]# time ./perf_test

real    0m4.850s
user    0m14.499s
sys    0m12.116s
[root@jubi-bm-ol8 upstream]# time ./perf_test

real    0m4.949s
user    0m14.285s
sys    0m18.408s
[root@jubi-bm-ol8 upstream]# time ./perf_test

real    0m4.885s
user    0m14.193s
sys    0m17.888s
[root@jubi-bm-ol8 upstream]# time ./perf_test

real    0m4.872s
user    0m14.451s
sys    0m18.717s
[root@jubi-bm-ol8 upstream]# uname -a
Linux jubi-bm-ol8 5.7.0-1700.20200601.el8uek.base.x86_64 #1 SMP Fri Jun 
19 07:41:06 PDT 2020 x86_64 x86_64 x86_64 GNU/Linux


Result of v5.7 with Eric's fix

=================

[root@jubi-bm-ol8 upstream]# time ./perf_test

real    0m4.889s
user    0m14.215s
sys    0m16.203s
[root@jubi-bm-ol8 upstream]# time ./perf_test

real    0m4.872s
user    0m14.431s
sys    0m17.737s
[root@jubi-bm-ol8 upstream]# time ./perf_test

real    0m4.908s
user    0m14.274s
sys    0m15.377s
[root@jubi-bm-ol8 upstream]# time ./perf_test

real    0m4.937s
user    0m14.632s
sys    0m16.255s
[root@jubi-bm-ol8 upstream]# uname -a
Linux jubi-bm-ol8 5.7.0-1700.20200601.el8uek.procfix.x86_64 #1 SMP Fri 
Jun 19 07:42:16 PDT 2020 x86_64 x86_64 x86_64 GNU/Linux

Thanks,

Junxiao.

> 	int i, j, one = 1;
>
> 	for (i = 0; i < 1000; i++) {
> 		for (j = 0; j < 100; j++)
> 			pthread_create(&threads[i % 20][j], NULL, worker, &one);
> 		if (i < 5)
> 			continue;
> 		for (j = 0; j < 100; j++)
> 			pthread_cancel(threads[(i - 5) %20][j]);
> 	}
>
> 	return 0;
> }
