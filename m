Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7A61FFEC1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 01:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgFRXj7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 19:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbgFRXj6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 19:39:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A38C06174E;
        Thu, 18 Jun 2020 16:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=xVgYnEdgAFHTs+nHrdH7aFVHFB4jUEehtYybUXoVPqU=; b=iLkuI0Rx7uZO85pIBQkwO4+iZu
        CQZXDISHNVl+UlKu3rV5wgTkQjLiJlGSnw2FDuPc3dlvD/zKhL4FGJ8K/GCRRvgQAgxsmRehLMfoE
        pFIO6WhTlEjz80gqMCp2YQG4+E927DPahJRnKAABA7uYErFOV1OmZksCuacxTv4W9OPPAo/hMobku
        Hs2azdhlElROexWFhUPOOkPItMFLtGms+Byyp6RQ8p7NT4yvlGsWxLVbA2BM4o1/NVG/Nxx/BVG8M
        gtfID5qfAkBmNtNkny5xz7G5wRmpmGErQwQv18blehGCWXixSWlVX2Te16rm4ElTvtghAAtz+diey
        TyMRC6bg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jm48U-0004EV-7i; Thu, 18 Jun 2020 23:39:58 +0000
Date:   Thu, 18 Jun 2020 16:39:58 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Junxiao Bi <junxiao.bi@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <matthew.wilcox@oracle.com>,
        Srinivas Eeda <SRINIVAS.EEDA@oracle.com>,
        "joe.jin@oracle.com" <joe.jin@oracle.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: severe proc dentry lock contention
Message-ID: <20200618233958.GV8681@bombadil.infradead.org>
References: <54091fc0-ca46-2186-97a8-d1f3c4f3877b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54091fc0-ca46-2186-97a8-d1f3c4f3877b@oracle.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 18, 2020 at 03:17:33PM -0700, Junxiao Bi wrote:
> When debugging some performance issue, i found that thousands of threads
> exit around same time could cause a severe spin lock contention on proc
> dentry "/proc/$parent_process_pid/task/", that's because threads needs to
> clean up their pid file from that dir when exit. Check the following
> standalone test case that simulated the case and perf top result on v5.7
> kernel. Any idea on how to fix this?

Thanks, Junxiao.

We've looked at a few different ways of fixing this problem.

Even though the contention is within the dcache, it seems like a usecase
that the dcache shouldn't be optimised for -- generally we do not have
hundreds of CPUs removing dentries from a single directory in parallel.

We could fix this within procfs.  We don't have a great patch yet, but
the current approach we're looking at allows only one thread at a time
to call dput() on any /proc/*/task directory.

We could also look at fixing this within the scheduler.  Only allowing
one CPU to run the threads of an exiting process would fix this particular
problem, but might have other consequences.

I was hoping that 7bc3e6e55acf would fix this, but that patch is in 5.7,
so that hope is ruled out.

> 
>    PerfTop:   48891 irqs/sec  kernel:95.6%  exact: 100.0% lost: 0/0 drop:
> 0/0 [4000Hz cycles],  (all, 72 CPUs)
> ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
> 
> 
>     66.10%  [kernel]                               [k]
> native_queued_spin_lock_slowpath
>      1.13%  [kernel]                               [k] _raw_spin_lock
>      0.84%  [kernel]                               [k] clear_page_erms
>      0.82%  [kernel]                               [k]
> queued_write_lock_slowpath
>      0.64%  [kernel]                               [k] proc_task_readdir
>      0.61%  [kernel]                               [k]
> find_idlest_group.isra.95
>      0.61%  [kernel]                               [k]
> syscall_return_via_sysret
>      0.55%  [kernel]                               [k] entry_SYSCALL_64
>      0.49%  [kernel]                               [k] memcpy_erms
>      0.46%  [kernel]                               [k] update_cfs_group
>      0.41%  [kernel]                               [k] get_pid_task
>      0.39%  [kernel]                               [k]
> _raw_spin_lock_irqsave
>      0.37%  [kernel]                               [k]
> __list_del_entry_valid
>      0.34%  [kernel]                               [k]
> get_page_from_freelist
>      0.34%  [kernel]                               [k] __d_lookup
>      0.32%  [kernel]                               [k] update_load_avg
>      0.31%  libc-2.17.so                           [.] get_next_seq
>      0.27%  [kernel]                               [k] avc_has_perm_noaudit
>      0.26%  [kernel]                               [k] __sched_text_start
>      0.25%  [kernel]                               [k]
> selinux_inode_permission
>      0.25%  [kernel]                               [k] __slab_free
>      0.24%  [kernel]                               [k] detach_entity_cfs_rq
>      0.23%  [kernel]                               [k] zap_pte_range
>      0.22%  [kernel]                               [k]
> _find_next_bit.constprop.1
>      0.22%  libc-2.17.so                           [.] vfprintf
>      0.20%  libc-2.17.so                           [.] _int_malloc
>      0.19%  [kernel]                               [k] _raw_spin_lock_irq
>      0.18%  [kernel]                               [k] rb_erase
>      0.18%  [kernel]                               [k] pid_revalidate
>      0.18%  [kernel]                               [k] lockref_get_not_dead
>      0.18%  [kernel]                               [k]
> __alloc_pages_nodemask
>      0.17%  [kernel]                               [k] set_task_cpu
>      0.17%  libc-2.17.so                           [.] __strcoll_l
>      0.17%  [kernel]                               [k] do_syscall_64
>      0.17%  [kernel]                               [k] __vmalloc_node_range
>      0.17%  libc-2.17.so                           [.] _IO_vfscanf
>      0.17%  [kernel]                               [k] refcount_dec_not_one
>      0.15%  [kernel]                               [k] __task_pid_nr_ns
>      0.15%  [kernel]                               [k]
> native_irq_return_iret
>      0.15%  [kernel]                               [k] free_pcppages_bulk
>      0.14%  [kernel]                               [k] kmem_cache_alloc
>      0.14%  [kernel]                               [k] link_path_walk
>      0.14%  libc-2.17.so                           [.] _int_free
>      0.14%  [kernel]                               [k]
> __update_load_avg_cfs_rq
>      0.14%  perf.5.7.0-master.20200601.ol7.x86_64  [.] 0x00000000000eac29
>      0.13%  [kernel]                               [k] kmem_cache_free
>      0.13%  [kernel]                               [k] number
>      0.13%  [kernel]                               [k] memset_erms
>      0.12%  [kernel]                               [k] proc_pid_status
>      0.12%  [kernel]                               [k] __d_lookup_rcu
> 
> 
> =========== runme.sh ==========
> 
> #!/bin/bash
> 
> threads=${1:-10000}
> prog=proc_race
> while [ 1 ]; do ./$prog $threads; done &
> 
> while [ 1 ]; do
>     pid=`ps aux | grep $prog | grep -v grep| awk '{print $2}'`
>     if [ -z $pid ]; then continue; fi
>     threadnum=`ls -l /proc/$pid/task | wc -l`
>     if [ $threadnum -gt $threads ]; then
>         echo kill $pid
>         kill -9 $pid
>     fi
> done
> 
> 
> ===========proc_race.c=========
> 
> 
> #include <pthread.h>
> #include <string.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <errno.h>
> #include <ctype.h>
> 
> #define handle_error_en(en, msg) \
>     do { errno = en; perror(msg); exit(EXIT_FAILURE); } while (0)
> 
> #define handle_error(msg) \
>     do { perror(msg); exit(EXIT_FAILURE); } while (0)
> 
> struct thread_info {
>     pthread_t thread_id;
>     int       thread_num;
> };
> 
> static void *child_thread()
> {
>     int i;
> 
>     while (1) { if (!(i++ % 1000000)) sleep(1);}
>     return NULL;
> }
> 
> int main(int argc, char *argv[])
> {
>     int s, tnum, opt, num_threads;
>     struct thread_info *tinfo;
>     void *res;
> 
>     if (argc == 2)
>         num_threads = atoi(argv[1]);
>     else
>         num_threads = 10000;
> 
>     tinfo = calloc(num_threads, sizeof(struct thread_info));
>     if (tinfo == NULL)
>         handle_error("calloc");
> 
> 
>     for (tnum = 0; tnum < num_threads; tnum++) {
>         tinfo[tnum].thread_num = tnum + 1;
> 
>         s = pthread_create(&tinfo[tnum].thread_id, NULL,
>                 &child_thread, NULL);
>         if (s != 0)
>             handle_error_en(s, "pthread_create");
>     }
> 
>     for (tnum = 0; tnum < num_threads; tnum++) {
>         s = pthread_join(tinfo[tnum].thread_id, &res);
>         if (s != 0)
>             handle_error_en(s, "pthread_join");
> 
>         free(res);
>     }
> 
>     free(tinfo);
>     exit(EXIT_SUCCESS);
> }
> 
> ==========
> 
> Thanks,
> 
> Junxiao.
> 
