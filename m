Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4EAE2F3246
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 14:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733196AbhALNyx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 08:54:53 -0500
Received: from smtp180.sjtu.edu.cn ([202.120.2.180]:41076 "EHLO
        smtp180.sjtu.edu.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbhALNyx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 08:54:53 -0500
X-Greylist: delayed 544 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Jan 2021 08:54:47 EST
Received: from mta03.sjtu.edu.cn (mta03.sjtu.edu.cn [202.121.179.7])
        by smtp180.sjtu.edu.cn (Postfix) with ESMTPS id 1F20A1008D5D0;
        Tue, 12 Jan 2021 21:45:01 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mta03.sjtu.edu.cn (Postfix) with ESMTP id 0E02310DC2C;
        Tue, 12 Jan 2021 21:45:01 +0800 (CST)
X-Virus-Scanned: amavisd-new at mta03.sjtu.edu.cn
Received: from mta03.sjtu.edu.cn ([127.0.0.1])
        by localhost (mta03.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nln1cMqzBZfO; Tue, 12 Jan 2021 21:45:00 +0800 (CST)
Received: from mstore107.sjtu.edu.cn (unknown [10.118.0.107])
        by mta03.sjtu.edu.cn (Postfix) with ESMTP id DC9AB10DA5E;
        Tue, 12 Jan 2021 21:45:00 +0800 (CST)
Date:   Tue, 12 Jan 2021 21:45:00 +0800 (CST)
From:   Zhongwei Cai <sunrise_l@sjtu.edu.cn>
To:     Mingkai Dong <mingkaidong@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Eric Sandeen <esandeen@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Wang Jianchao <jianchao.wan9@gmail.com>,
        "Tadakamadla, Rajesh" <rajesh.tadakamadla@hpe.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Message-ID: <2041983017.5681521.1610459100858.JavaMail.zimbra@sjtu.edu.cn>
In-Reply-To: <17045315-CC1F-4165-B8E3-BA55DD16D46B@gmail.com>
References: <alpine.LRH.2.02.2101061245100.30542@file01.intranet.prod.int.rdu2.redhat.com> <20210107151125.GB5270@casper.infradead.org> <17045315-CC1F-4165-B8E3-BA55DD16D46B@gmail.com>
Subject: Re: Expense of read_iter
MIME-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
X-Originating-IP: [58.196.139.16]
X-Mailer: Zimbra 8.8.15_GA_3980 (ZimbraWebClient - FF84 (Win)/8.8.15_GA_3928)
Thread-Topic: Expense of read_iter
Thread-Index: tOQkjpVW00AjdXfPbSr9PJY5OGgUJg==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


I'm working with Mingkai on optimizations for Ext4-dax.
We think that optmizing the read-iter method cannot achieve the
same performance as the read method for Ext4-dax. 
We tried Mikulas's benchmark on Ext4-dax. The overall time and perf
results are listed below:

Overall time of 2^26 4KB read.

Method       Time
read         26.782s
read-iter    36.477s

Perf result, using the read_iter method:

# To display the perf.data header info, please use --header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 1K of event 'cycles'
# Event count (approx.): 13379476464
#
# Overhead  Command  Shared Object     Symbol                                 
# ........  .......  ................  .......................................
#
    20.09%  pread    [kernel.vmlinux]  [k] copy_user_generic_string
     6.58%  pread    [kernel.vmlinux]  [k] iomap_apply
     6.01%  pread    [kernel.vmlinux]  [k] syscall_return_via_sysret
     4.85%  pread    libc-2.31.so      [.] __libc_pread
     3.61%  pread    [kernel.vmlinux]  [k] entry_SYSCALL_64_after_hwframe
     3.25%  pread    [kernel.vmlinux]  [k] _raw_read_lock
     2.80%  pread    [kernel.vmlinux]  [k] entry_SYSCALL_64
     2.71%  pread    [ext4]            [k] ext4_es_lookup_extent
     2.71%  pread    [kernel.vmlinux]  [k] __fsnotify_parent
     2.63%  pread    [kernel.vmlinux]  [k] __srcu_read_unlock
     2.55%  pread    [kernel.vmlinux]  [k] new_sync_read
     2.39%  pread    [ext4]            [k] ext4_iomap_begin
     2.38%  pread    [kernel.vmlinux]  [k] vfs_read
     2.30%  pread    [kernel.vmlinux]  [k] dax_iomap_actor
     2.30%  pread    [kernel.vmlinux]  [k] __srcu_read_lock
     2.14%  pread    [ext4]            [k] ext4_inode_block_valid
     1.97%  pread    [kernel.vmlinux]  [k] _copy_mc_to_iter
     1.97%  pread    [ext4]            [k] ext4_map_blocks
     1.89%  pread    [kernel.vmlinux]  [k] down_read
     1.89%  pread    [kernel.vmlinux]  [k] up_read
     1.65%  pread    [ext4]            [k] ext4_file_read_iter
     1.48%  pread    [kernel.vmlinux]  [k] dax_iomap_rw
     1.48%  pread    [jbd2]            [k] jbd2_transaction_committed
     1.15%  pread    [nd_pmem]         [k] __pmem_direct_access
     1.15%  pread    [kernel.vmlinux]  [k] ksys_pread64
     1.15%  pread    [kernel.vmlinux]  [k] __fget_light
     1.15%  pread    [ext4]            [k] ext4_set_iomap
     1.07%  pread    [kernel.vmlinux]  [k] atime_needs_update
     0.82%  pread    pread             [.] main
     0.82%  pread    [kernel.vmlinux]  [k] do_syscall_64
     0.74%  pread    [kernel.vmlinux]  [k] entry_SYSCALL_64_safe_stack
     0.66%  pread    [kernel.vmlinux]  [k] __x86_indirect_thunk_rax
     0.66%  pread    [nd_pmem]         [k] 0x00000000000001d0
     0.59%  pread    [kernel.vmlinux]  [k] dax_direct_access
     0.58%  pread    [nd_pmem]         [k] 0x00000000000001de
     0.58%  pread    [kernel.vmlinux]  [k] bdev_dax_pgoff
     0.49%  pread    [kernel.vmlinux]  [k] syscall_enter_from_user_mode
     0.49%  pread    [kernel.vmlinux]  [k] exit_to_user_mode_prepare
     0.49%  pread    [kernel.vmlinux]  [k] syscall_exit_to_user_mode
     0.41%  pread    [kernel.vmlinux]  [k] syscall_exit_to_user_mode_prepare
     0.33%  pread    [nd_pmem]         [k] 0x0000000000001083
     0.33%  pread    [kernel.vmlinux]  [k] dax_get_private
     0.33%  pread    [kernel.vmlinux]  [k] timestamp_truncate
     0.33%  pread    [kernel.vmlinux]  [k] percpu_counter_add_batch
     0.33%  pread    [kernel.vmlinux]  [k] copyout_mc
     0.33%  pread    [ext4]            [k] __check_block_validity.constprop.80
     0.33%  pread    [kernel.vmlinux]  [k] touch_atime
     0.25%  pread    [nd_pmem]         [k] 0x000000000000107f
     0.25%  pread    [kernel.vmlinux]  [k] rw_verify_area
     0.25%  pread    [ext4]            [k] ext4_iomap_end
     0.25%  pread    [kernel.vmlinux]  [k] _cond_resched
     0.25%  pread    [kernel.vmlinux]  [k] rcu_all_qs
     0.16%  pread    [kernel.vmlinux]  [k] __fdget
     0.16%  pread    [kernel.vmlinux]  [k] ktime_get_coarse_real_ts64
     0.16%  pread    [kernel.vmlinux]  [k] iov_iter_init
     0.16%  pread    [kernel.vmlinux]  [k] current_time
     0.16%  pread    [nd_pmem]         [k] 0x0000000000001075
     0.16%  pread    [ext4]            [k] ext4_inode_datasync_dirty
     0.16%  pread    [kernel.vmlinux]  [k] copy_mc_to_user
     0.08%  pread    pread             [.] pread@plt
     0.08%  pread    [kernel.vmlinux]  [k] __x86_indirect_thunk_r11
     0.08%  pread    [kernel.vmlinux]  [k] security_file_permission
     0.08%  pread    [kernel.vmlinux]  [k] dax_read_unlock
     0.08%  pread    [kernel.vmlinux]  [k] _raw_spin_unlock_irqrestore
     0.08%  pread    [nd_pmem]         [k] 0x000000000000108f
     0.08%  pread    [nd_pmem]         [k] 0x0000000000001095
     0.08%  pread    [kernel.vmlinux]  [k] rcu_read_unlock_strict
     0.00%  pread    [kernel.vmlinux]  [k] native_write_msr


#
# (Tip: Show current config key-value pairs: perf config --list)
#

Perf result, using the read method we added for Ext4-dax:

# To display the perf.data header info, please use --header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 1K of event 'cycles'
# Event count (approx.): 13364755903
#
# Overhead  Command  Shared Object     Symbol                                 
# ........  .......  ................  .......................................
#
    28.65%  pread    [kernel.vmlinux]  [k] copy_user_generic_string
     7.99%  pread    [ext4]            [k] ext4_dax_read
     6.50%  pread    [kernel.vmlinux]  [k] syscall_return_via_sysret
     5.43%  pread    libc-2.31.so      [.] __libc_pread
     4.45%  pread    [kernel.vmlinux]  [k] entry_SYSCALL_64
     4.20%  pread    [kernel.vmlinux]  [k] down_read
     3.38%  pread    [kernel.vmlinux]  [k] _raw_read_lock
     3.13%  pread    [ext4]            [k] ext4_es_lookup_extent
     3.05%  pread    [kernel.vmlinux]  [k] __srcu_read_lock
     2.72%  pread    [kernel.vmlinux]  [k] __fsnotify_parent
     2.55%  pread    [kernel.vmlinux]  [k] __srcu_read_unlock
     2.47%  pread    [kernel.vmlinux]  [k] vfs_read
     2.31%  pread    [kernel.vmlinux]  [k] entry_SYSCALL_64_after_hwframe
     1.89%  pread    [kernel.vmlinux]  [k] up_read
     1.73%  pread    [ext4]            [k] ext4_map_blocks
     1.65%  pread    pread             [.] main
     1.56%  pread    [kernel.vmlinux]  [k] __fget_light
     1.48%  pread    [ext4]            [k] ext4_inode_block_valid
     1.34%  pread    [kernel.vmlinux]  [k] ksys_pread64
     1.23%  pread    [kernel.vmlinux]  [k] entry_SYSCALL_64_safe_stack
     1.08%  pread    [kernel.vmlinux]  [k] syscall_exit_to_user_mode
     1.07%  pread    [nd_pmem]         [k] __pmem_direct_access
     0.99%  pread    [kernel.vmlinux]  [k] atime_needs_update
     0.91%  pread    [kernel.vmlinux]  [k] security_file_permission
     0.91%  pread    [kernel.vmlinux]  [k] syscall_enter_from_user_mode
     0.66%  pread    [kernel.vmlinux]  [k] timestamp_truncate
     0.58%  pread    [kernel.vmlinux]  [k] ktime_get_coarse_real_ts64
     0.49%  pread    pread             [.] pread@plt
     0.41%  pread    [kernel.vmlinux]  [k] current_time
     0.41%  pread    [kernel.vmlinux]  [k] dax_direct_access
     0.41%  pread    [kernel.vmlinux]  [k] do_syscall_64
     0.41%  pread    [kernel.vmlinux]  [k] exit_to_user_mode_prepare
     0.41%  pread    [kernel.vmlinux]  [k] percpu_counter_add_batch
     0.33%  pread    [kernel.vmlinux]  [k] touch_atime
     0.33%  pread    [ext4]            [k] __check_block_validity.constprop.80
     0.33%  pread    [kernel.vmlinux]  [k] copy_mc_to_user
     0.25%  pread    [kernel.vmlinux]  [k] dax_get_private
     0.25%  pread    [kernel.vmlinux]  [k] rcu_all_qs
     0.25%  pread    [nd_pmem]         [k] 0x0000000000001095
     0.16%  pread    [kernel.vmlinux]  [k] _raw_spin_lock_irqsave
     0.16%  pread    [kernel.vmlinux]  [k] syscall_exit_to_user_mode_prepare
     0.16%  pread    [nd_pmem]         [k] 0x0000000000001083
     0.16%  pread    [kernel.vmlinux]  [k] rw_verify_area
     0.16%  pread    [kernel.vmlinux]  [k] _raw_spin_unlock_irqrestore
     0.16%  pread    [kernel.vmlinux]  [k] __fdget
     0.16%  pread    [kernel.vmlinux]  [k] dax_read_lock
     0.16%  pread    [kernel.vmlinux]  [k] __x86_indirect_thunk_rax
     0.08%  pread    [kernel.vmlinux]  [k] rcu_read_unlock_strict
     0.08%  pread    [kernel.vmlinux]  [k] dax_read_unlock
     0.08%  pread    [kernel.vmlinux]  [k] update_irq_load_avg
     0.08%  pread    [nd_pmem]         [k] 0x000000000000109d
     0.08%  pread    [nd_pmem]         [k] 0x000000000000107a
     0.08%  pread    [kernel.vmlinux]  [k] __x64_sys_pread64
     0.00%  pread    [kernel.vmlinux]  [k] native_write_msr


#
# (Tip: Sample related events with: perf record -e '{cycles,instructions}:S')
#

Note that the overall time of read method is 73.42% of the read-iter method.
If we sum up the percentage of read-iter specific functions (including
ext4_file_read_iter, iomap_apply, dax_iomap_actor, _copy_mc_to_iter,
ext4_iomap_begin, jbd2_transaction_committed, new_sync_read, dax_iomap_rw,
ext4_set_iomap, ext4_iomap_end and iov_iter_init), we will get 20.81%.
In the second trace, ext4_dax_read only consumes 7.99%, which can replace
all these functions.

The overhead mainly consists of two parts. The first is constructing
struct iov_iter and iterating it (i.e., new_sync, _copy_mc_to_iter and
iov_iter_init). The second is the dax io mechanism provided by VFS (i.e.,
dax_iomap_rw, iomap_apply and ext4_iomap_begin).

There could be two approaches to optimizing: 1) implementing the read method
without the complexity of iterators and dax_iomap_rw; 2) optimizing both
iterators and how dax_iomap_rw works. Since dax_iomap_rw requires
ext4_iomap_begin, which further involves the iomap structure and others
(e.g., journaling status locks in Ext4), we think implementing the read
method would be easier.

Thanks,
Zhongwei

