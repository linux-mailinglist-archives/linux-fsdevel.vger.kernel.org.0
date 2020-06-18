Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAE41FFDDA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 00:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731945AbgFRWRk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 18:17:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55716 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731935AbgFRWRj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 18:17:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05IM840c009933;
        Thu, 18 Jun 2020 22:17:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : from :
 subject : message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=47dOQpqiKGfsW/QjCgUZPqBcNDXW/hGNuK+7RNWRugA=;
 b=HM6VqxOV6rTi6psG2HNf3jHycDosE7YJ23H5fzAFhzPiecRw+bSSdRS2HKfVN1UUvqGt
 9hyw+kTAAuLUbvXsv3FkiWEpJMvpwQ7LrmMmbuRdrAsFVQCqCyjC+4ixVTkRIjfMG6as
 XWX9AQZ0YKejPtF2851ciuYhMV15dxnA1kn6N1Vr06M9zGFurdAro5LH+4nMe52nv1cZ
 1uWRw9NxgP9sO741AZ1VMhd/GWP/ipK+Qmh7yGNIKmpmJlkK6nicDbt6li6UNg0LUC+p
 pkYxQOkbR8xontB6d2+fA/3BqnlzMo5Pi1RlMnID5tSksqGUaNHGxrzUqXLeTZ+7Mj7s pg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 31q6603r9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 18 Jun 2020 22:17:36 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05IMDnHP041001;
        Thu, 18 Jun 2020 22:17:36 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 31q661hyy4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jun 2020 22:17:36 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05IMHZ7u022436;
        Thu, 18 Jun 2020 22:17:35 GMT
Received: from dhcp-10-159-251-35.vpn.oracle.com (/10.159.251.35)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 18 Jun 2020 15:17:35 -0700
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     adobriyan@gmail.com, Matthew Wilcox <matthew.wilcox@oracle.com>,
        Srinivas Eeda <SRINIVAS.EEDA@oracle.com>,
        "joe.jin@oracle.com" <joe.jin@oracle.com>
From:   Junxiao Bi <junxiao.bi@oracle.com>
Subject: severe proc dentry lock contention
Message-ID: <54091fc0-ca46-2186-97a8-d1f3c4f3877b@oracle.com>
Date:   Thu, 18 Jun 2020 15:17:33 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9656 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 adultscore=0
 suspectscore=13 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006180169
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9656 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 clxscore=1011 mlxlogscore=999 suspectscore=13 impostorscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006180168
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

When debugging some performance issue, i found that thousands of threads 
exit around same time could cause a severe spin lock contention on proc 
dentry "/proc/$parent_process_pid/task/", that's because threads needs 
to clean up their pid file from that dir when exit. Check the following 
standalone test case that simulated the case and perf top result on v5.7 
kernel. Any idea on how to fix this?


    PerfTop:   48891 irqs/sec  kernel:95.6%  exact: 100.0% lost: 0/0 
drop: 0/0 [4000Hz cycles],  (all, 72 CPUs)
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 


     66.10%  [kernel]                               [k] 
native_queued_spin_lock_slowpath
      1.13%  [kernel]                               [k] _raw_spin_lock
      0.84%  [kernel]                               [k] clear_page_erms
      0.82%  [kernel]                               [k] 
queued_write_lock_slowpath
      0.64%  [kernel]                               [k] proc_task_readdir
      0.61%  [kernel]                               [k] 
find_idlest_group.isra.95
      0.61%  [kernel]                               [k] 
syscall_return_via_sysret
      0.55%  [kernel]                               [k] entry_SYSCALL_64
      0.49%  [kernel]                               [k] memcpy_erms
      0.46%  [kernel]                               [k] update_cfs_group
      0.41%  [kernel]                               [k] get_pid_task
      0.39%  [kernel]                               [k] 
_raw_spin_lock_irqsave
      0.37%  [kernel]                               [k] 
__list_del_entry_valid
      0.34%  [kernel]                               [k] 
get_page_from_freelist
      0.34%  [kernel]                               [k] __d_lookup
      0.32%  [kernel]                               [k] update_load_avg
      0.31%  libc-2.17.so                           [.] get_next_seq
      0.27%  [kernel]                               [k] avc_has_perm_noaudit
      0.26%  [kernel]                               [k] __sched_text_start
      0.25%  [kernel]                               [k] 
selinux_inode_permission
      0.25%  [kernel]                               [k] __slab_free
      0.24%  [kernel]                               [k] detach_entity_cfs_rq
      0.23%  [kernel]                               [k] zap_pte_range
      0.22%  [kernel]                               [k] 
_find_next_bit.constprop.1
      0.22%  libc-2.17.so                           [.] vfprintf
      0.20%  libc-2.17.so                           [.] _int_malloc
      0.19%  [kernel]                               [k] _raw_spin_lock_irq
      0.18%  [kernel]                               [k] rb_erase
      0.18%  [kernel]                               [k] pid_revalidate
      0.18%  [kernel]                               [k] lockref_get_not_dead
      0.18%  [kernel]                               [k] 
__alloc_pages_nodemask
      0.17%  [kernel]                               [k] set_task_cpu
      0.17%  libc-2.17.so                           [.] __strcoll_l
      0.17%  [kernel]                               [k] do_syscall_64
      0.17%  [kernel]                               [k] __vmalloc_node_range
      0.17%  libc-2.17.so                           [.] _IO_vfscanf
      0.17%  [kernel]                               [k] refcount_dec_not_one
      0.15%  [kernel]                               [k] __task_pid_nr_ns
      0.15%  [kernel]                               [k] 
native_irq_return_iret
      0.15%  [kernel]                               [k] free_pcppages_bulk
      0.14%  [kernel]                               [k] kmem_cache_alloc
      0.14%  [kernel]                               [k] link_path_walk
      0.14%  libc-2.17.so                           [.] _int_free
      0.14%  [kernel]                               [k] 
__update_load_avg_cfs_rq
      0.14%  perf.5.7.0-master.20200601.ol7.x86_64  [.] 0x00000000000eac29
      0.13%  [kernel]                               [k] kmem_cache_free
      0.13%  [kernel]                               [k] number
      0.13%  [kernel]                               [k] memset_erms
      0.12%  [kernel]                               [k] proc_pid_status
      0.12%  [kernel]                               [k] __d_lookup_rcu


=========== runme.sh ==========

#!/bin/bash

threads=${1:-10000}
prog=proc_race
while [ 1 ]; do ./$prog $threads; done &

while [ 1 ]; do
     pid=`ps aux | grep $prog | grep -v grep| awk '{print $2}'`
     if [ -z $pid ]; then continue; fi
     threadnum=`ls -l /proc/$pid/task | wc -l`
     if [ $threadnum -gt $threads ]; then
         echo kill $pid
         kill -9 $pid
     fi
done


===========proc_race.c=========


#include <pthread.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <ctype.h>

#define handle_error_en(en, msg) \
     do { errno = en; perror(msg); exit(EXIT_FAILURE); } while (0)

#define handle_error(msg) \
     do { perror(msg); exit(EXIT_FAILURE); } while (0)

struct thread_info {
     pthread_t thread_id;
     int       thread_num;
};

static void *child_thread()
{
     int i;

     while (1) { if (!(i++ % 1000000)) sleep(1);}
     return NULL;
}

int main(int argc, char *argv[])
{
     int s, tnum, opt, num_threads;
     struct thread_info *tinfo;
     void *res;

     if (argc == 2)
         num_threads = atoi(argv[1]);
     else
         num_threads = 10000;

     tinfo = calloc(num_threads, sizeof(struct thread_info));
     if (tinfo == NULL)
         handle_error("calloc");


     for (tnum = 0; tnum < num_threads; tnum++) {
         tinfo[tnum].thread_num = tnum + 1;

         s = pthread_create(&tinfo[tnum].thread_id, NULL,
                 &child_thread, NULL);
         if (s != 0)
             handle_error_en(s, "pthread_create");
     }

     for (tnum = 0; tnum < num_threads; tnum++) {
         s = pthread_join(tinfo[tnum].thread_id, &res);
         if (s != 0)
             handle_error_en(s, "pthread_join");

         free(res);
     }

     free(tinfo);
     exit(EXIT_SUCCESS);
}

==========

Thanks,

Junxiao.

