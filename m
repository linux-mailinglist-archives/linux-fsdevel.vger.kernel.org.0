Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A842ACFDE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 07:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbgKJGkT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 01:40:19 -0500
Received: from mga01.intel.com ([192.55.52.88]:3263 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgKJGkS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 01:40:18 -0500
IronPort-SDR: fxqGk4ajbC35T1lFheb8Beqjkw+qfPLte9oWPDDxIZrbMvF/vfvlEDLlyGdjFk/g/iIOfErkKp
 lP2miT1oXDyQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9800"; a="187888217"
X-IronPort-AV: E=Sophos;i="5.77,465,1596524400"; 
   d="yaml'?scan'208";a="187888217"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 22:40:11 -0800
IronPort-SDR: cRr98CJO54JAZWYKSgE4ZdtTP5+IPHCG54VC3UB0BT3SRMjLrn6k+QxVuXMFVmxw2I/uHcTPQm
 LWjoZi84sYwA==
X-IronPort-AV: E=Sophos;i="5.77,465,1596524400"; 
   d="yaml'?scan'208";a="541205916"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 22:40:05 -0800
Date:   Tue, 10 Nov 2020 14:54:37 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Wonhyuk Yang <vvghjk1234@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, Wonhyuk Yang <vvghjk1234@gmail.com>,
        0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        ying.huang@intel.com, feng.tang@intel.com, zhengjun.xing@intel.com
Subject: [fuse]  51ac7c8929:  fio.read_iops -88.2% regression
Message-ID: <20201110065437.GC3197@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Y5rl02BVI9TCfPar"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201103124349.16722-1-vvghjk1234@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Y5rl02BVI9TCfPar
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Greeting,

FYI, we noticed a -88.2% regression of fio.read_iops due to commit:


commit: 51ac7c8929fb43cdb4d046674ba61926711318a2 ("[PATCH] fuse: fix panic in __readahead_batch()")
url: https://github.com/0day-ci/linux/commits/Wonhyuk-Yang/fuse-fix-panic-in-__readahead_batch/20201103-204539
base: https://git.kernel.org/cgit/linux/kernel/git/mszeredi/fuse.git for-next

in testcase: fio-basic
on test machine: 192 threads Intel(R) Xeon(R) CPU @ 2.20GHz with 192G memory
with following parameters:

	runtime: 300s
	nr_task: 8t
	disk: 1SSD
	fs: btrfs
	rw: randread
	bs: 2M
	ioengine: sync
	test_size: 256g
	cpufreq_governor: performance
	ucode: 0x4002f01

test-description: Fio is a tool that will spawn a number of threads or processes doing a particular type of I/O action as specified by the user.
test-url: https://github.com/axboe/fio

In addition to that, the commit also has significant impact on the following tests:

+------------------+----------------------------------------------------------------------+
| testcase: change | fio-basic: fio.read_iops -88.5% regression                           |
| test machine     | 192 threads Intel(R) Xeon(R) CPU @ 2.20GHz with 192G memory          |
| test parameters  | bs=4k                                                                |
|                  | cpufreq_governor=performance                                         |
|                  | disk=1SSD                                                            |
|                  | fs=btrfs                                                             |
|                  | ioengine=libaio                                                      |
|                  | nr_task=8t                                                           |
|                  | runtime=300s                                                         |
|                  | rw=read                                                              |
|                  | test_size=256g                                                       |
|                  | ucode=0x4002f01                                                      |
+------------------+----------------------------------------------------------------------+
| testcase: change | fio-basic: fio.read_iops -62.1% regression                           |
| test machine     | 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 256G memory |
| test parameters  | bs=2M                                                                |
|                  | cpufreq_governor=performance                                         |
|                  | disk=2pmem                                                           |
|                  | fs=btrfs                                                             |
|                  | ioengine=sync                                                        |
|                  | nr_task=50%                                                          |
|                  | runtime=200s                                                         |
|                  | rw=randread                                                          |
|                  | test_size=100G                                                       |
|                  | time_based=tb                                                        |
|                  | ucode=0x5002f01                                                      |
+------------------+----------------------------------------------------------------------+


If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>


Details are as below:
-------------------------------------------------------------------------------------------------->


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install job.yaml  # job file is attached in this email
        bin/lkp run     job.yaml

=========================================================================================
bs/compiler/cpufreq_governor/disk/fs/ioengine/kconfig/nr_task/rootfs/runtime/rw/tbox_group/test_size/testcase/ucode:
  2M/gcc-9/performance/1SSD/btrfs/sync/x86_64-rhel-8.3/8t/debian-10.4-x86_64-20200603.cgz/300s/randread/lkp-csl-2ap1/256g/fio-basic/0x4002f01

commit: 
  42d3e2d041 ("virtiofs: calculate number of scatter-gather elements accurately")
  51ac7c8929 ("fuse: fix panic in __readahead_batch()")

42d3e2d041f08d1f 51ac7c8929fb43cdb4d046674ba 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
           :4           12%           0:4     perf-profile.children.cycles-pp.error_entry
           :4           11%           0:4     perf-profile.self.cycles-pp.error_entry
         %stddev     %change         %stddev
             \          |                \  
     98.99           -99.0        0.00        fio.latency_10ms%
      0.01 ±100%      +0.1        0.07 ±107%  fio.latency_20ms%
      0.01 ±  2%      -0.0        0.00        fio.latency_2ms%
      1.00 ± 18%      -1.0        0.00        fio.latency_4ms%
      3220           -88.2%     381.12        fio.read_bw_MBps
   5292032          +865.9%   51118080        fio.read_clat_90%_us
   5406720          +906.1%   54394880        fio.read_clat_95%_us
   5701632          +962.1%   60555264        fio.read_clat_99%_us
   4963004          +745.8%   41978072        fio.read_clat_mean_us
    333355 ±  7%   +1938.3%    6794809 ±  2%  fio.read_clat_stddev
      1610           -88.2%     190.56        fio.read_iops
     82.90          +263.6%     301.44        fio.time.elapsed_time
     82.90          +263.6%     301.44        fio.time.elapsed_time.max
 5.369e+08           -56.4%  2.342e+08        fio.time.file_system_inputs
    167.25 ±  3%     -51.0%      82.00        fio.time.percent_of_cpu_this_job_got
    106.61 ±  3%    +102.4%     215.80        fio.time.system_time
   9442982 ±  9%    +210.3%   29304650        fio.time.voluntary_context_switches
    131072           -56.4%      57173        fio.workload
     94.04            +1.7%      95.68        iostat.cpu.idle
      3.12           -37.4%       1.95 ±  4%  iostat.cpu.iowait
    359.82           +60.5%     577.52        uptime.boot
     66818           +58.8%     106077        uptime.idle
      3.19            -1.2        1.96 ±  4%  mpstat.cpu.all.iowait%
      1.21 ±  3%      -0.7        0.52        mpstat.cpu.all.sys%
      0.21 ±  3%      -0.1        0.07 ±  2%  mpstat.cpu.all.usr%
  89740606 ±  3%   +1942.9%  1.833e+09        cpuidle.C1.time
   1020242 ±  5%   +4906.5%   51078519        cpuidle.C1.usage
  33329290          +290.9%  1.303e+08 ± 17%  cpuidle.C1E.usage
   9634017 ±  7%    +724.5%   79434890 ±  5%  cpuidle.POLL.time
   5866644 ±  7%    +290.6%   22913634 ±  6%  cpuidle.POLL.usage
      8038 ±113%    -100.0%       0.00        numa-numastat.node1.numa_foreign
  23996473 ± 21%     -62.5%    9007786 ± 61%  numa-numastat.node1.numa_miss
  24019895 ± 21%     -62.4%    9023497 ± 61%  numa-numastat.node1.other_node
  12823709 ± 27%    -100.0%       0.00        numa-numastat.node2.numa_miss
  12847082 ± 27%     -99.8%      31127        numa-numastat.node2.other_node
   3121342           -87.7%     383907        vmstat.io.bi
  98157361 ± 11%     -48.6%   50426905 ±  9%  vmstat.memory.cache
  97548398 ± 11%     +49.1%  1.454e+08 ±  3%  vmstat.memory.free
      6.00           +16.7%       7.00        vmstat.procs.b
      4.00           -68.8%       1.25 ± 34%  vmstat.procs.r
    225281 ±  9%     +67.5%     377339        vmstat.system.cs
    447105            +8.0%     482833        vmstat.system.in
      2342          +207.9%       7214 ±  5%  meminfo.Active(anon)
  97121757 ± 11%     -48.5%   50055371 ±  9%  meminfo.Cached
  96127296 ± 11%     -49.0%   49041706 ±  9%  meminfo.Inactive
  94744696 ± 12%     -49.7%   47646302 ± 10%  meminfo.Inactive(file)
    402386           -38.3%     248163        meminfo.KReclaimable
  98175544 ± 11%     +48.3%  1.456e+08 ±  3%  meminfo.MemFree
  99551094 ± 11%     -47.6%   52165788 ±  9%  meminfo.Memused
    402386           -38.3%     248163        meminfo.SReclaimable
    710948           -22.3%     552457        meminfo.Slab
   1989821 ± 10%     -84.6%     305820 ±  7%  meminfo.max_used_kB
    179547 ± 17%     -32.0%     122116 ± 36%  numa-meminfo.node0.KReclaimable
    179547 ± 17%     -32.0%     122116 ± 36%  numa-meminfo.node0.SReclaimable
  29884942 ± 12%     -68.5%    9412882 ± 68%  numa-meminfo.node1.FilePages
  29716910 ± 12%     -69.2%    9152590 ± 70%  numa-meminfo.node1.Inactive
  29360507 ± 11%     -70.0%    8811495 ± 71%  numa-meminfo.node1.Inactive(file)
    117886 ± 24%     -56.1%      51711 ± 40%  numa-meminfo.node1.KReclaimable
  19044419 ± 19%    +108.0%   39612398 ± 16%  numa-meminfo.node1.MemFree
  30490035 ± 12%     -67.5%    9922056 ± 65%  numa-meminfo.node1.MemUsed
    117886 ± 24%     -56.1%      51711 ± 40%  numa-meminfo.node1.SReclaimable
    183161 ± 22%     -32.9%     122979 ± 22%  numa-meminfo.node1.Slab
      9639 ± 28%     -33.7%       6391 ±  2%  numa-meminfo.node2.Mapped
    293.00 ± 77%   +1079.9%       3457 ± 18%  numa-meminfo.node3.Active(anon)
      1520 ± 79%  +18657.6%     285162 ±169%  numa-meminfo.node3.Shmem
     44717 ± 17%     -31.7%      30531 ± 36%  numa-vmstat.node0.nr_slab_reclaimable
   7433552 ± 12%     -68.3%    2355545 ± 68%  numa-vmstat.node1.nr_file_pages
   4798967 ± 19%    +106.3%    9900790 ± 16%  numa-vmstat.node1.nr_free_pages
   7301629 ± 11%     -69.8%    2205345 ± 71%  numa-vmstat.node1.nr_inactive_file
     29238 ± 24%     -55.8%      12933 ± 40%  numa-vmstat.node1.nr_slab_reclaimable
   7301696 ± 11%     -69.8%    2205345 ± 71%  numa-vmstat.node1.nr_zone_inactive_file
     53564 ± 62%     -99.2%     413.75 ±164%  numa-vmstat.node1.workingset_nodes
      2408 ± 28%     -33.6%       1598 ±  2%  numa-vmstat.node2.nr_mapped
     31.25 ±173%    +288.0%     121.25 ± 18%  numa-vmstat.node2.nr_mlock
     72.75 ± 77%   +1091.1%     866.50 ± 18%  numa-vmstat.node3.nr_active_anon
     31.25 ±173%    +243.2%     107.25 ± 17%  numa-vmstat.node3.nr_mlock
    379.50 ± 79%  +18686.2%      71293 ±169%  numa-vmstat.node3.nr_shmem
     72.75 ± 77%   +1091.1%     866.50 ± 18%  numa-vmstat.node3.nr_zone_active_anon
     34625 ±  2%     -23.9%      26335 ±  3%  slabinfo.Acpi-State.active_objs
    799.25 ±  6%     -35.0%     519.75 ±  3%  slabinfo.Acpi-State.active_slabs
     40801 ±  6%     -35.0%      26540 ±  3%  slabinfo.Acpi-State.num_objs
    799.25 ±  6%     -35.0%     519.75 ±  3%  slabinfo.Acpi-State.num_slabs
      3672            -7.1%       3411 ±  4%  slabinfo.kmalloc-4k.active_objs
      3767            -7.4%       3489 ±  4%  slabinfo.kmalloc-4k.num_objs
     43205           -12.4%      37858 ±  2%  slabinfo.kmalloc-512.active_objs
     44154           -11.5%      39081 ±  2%  slabinfo.kmalloc-512.num_objs
     14661 ± 18%     +40.0%      20525 ± 11%  slabinfo.proc_inode_cache.active_objs
     15048 ± 18%     +38.9%      20909 ± 10%  slabinfo.proc_inode_cache.num_objs
    560122           -51.7%     270365        slabinfo.radix_tree_node.active_objs
     10004           -51.7%       4830        slabinfo.radix_tree_node.active_slabs
    560242           -51.7%     270509        slabinfo.radix_tree_node.num_objs
     10004           -51.7%       4830        slabinfo.radix_tree_node.num_slabs
     20051           +32.9%      26644 ±  2%  slabinfo.vmap_area.active_objs
    313.50           +33.0%     417.00 ±  2%  slabinfo.vmap_area.active_slabs
     20086           +33.0%      26710 ±  2%  slabinfo.vmap_area.num_objs
    313.50           +33.0%     417.00 ±  2%  slabinfo.vmap_area.num_slabs
    113868 ± 50%    +118.9%     249261 ± 37%  proc-vmstat.compact_daemon_migrate_scanned
    842092 ± 30%     +99.7%    1682016 ± 19%  proc-vmstat.compact_free_scanned
    114524 ± 50%    +119.6%     251529 ± 37%  proc-vmstat.compact_migrate_scanned
    577.00 ± 24%     -51.2%     281.75 ± 23%  proc-vmstat.kswapd_high_wmark_hit_quickly
    585.50          +207.9%       1802 ±  5%  proc-vmstat.nr_active_anon
     71649            -4.9%      68165        proc-vmstat.nr_anon_pages
    111.75            -3.4%     108.00        proc-vmstat.nr_anon_transparent_hugepages
  24300213 ± 11%     -48.5%   12516619 ±  9%  proc-vmstat.nr_file_pages
  24523917 ± 11%     +48.4%   36387344 ±  3%  proc-vmstat.nr_free_pages
    345660            +1.0%     349089        proc-vmstat.nr_inactive_anon
  23705931 ± 12%     -49.7%   11914111 ±  9%  proc-vmstat.nr_inactive_file
     28507 ±  2%      -4.4%      27260        proc-vmstat.nr_kernel_stack
    279585            +2.4%     286356        proc-vmstat.nr_mapped
    274750            +3.0%     282918        proc-vmstat.nr_shmem
    100636           -38.3%      62043        proc-vmstat.nr_slab_reclaimable
    585.50          +207.9%       1802 ±  5%  proc-vmstat.nr_zone_active_anon
    345682            +1.0%     349093        proc-vmstat.nr_zone_inactive_anon
  23706146 ± 12%     -49.7%   11914152 ±  9%  proc-vmstat.nr_zone_inactive_file
  43905066 ± 25%     -75.2%   10867889 ± 25%  proc-vmstat.numa_foreign
      1117 ± 31%     -55.6%     495.75 ± 28%  proc-vmstat.numa_hint_faults
    828.00 ± 26%     -63.4%     303.25 ± 56%  proc-vmstat.numa_hint_faults_local
  43905066 ± 25%     -75.2%   10867889 ± 25%  proc-vmstat.numa_miss
  43998459 ± 25%     -75.1%   10961431 ± 25%  proc-vmstat.numa_other
      3825           +29.5%       4953 ±  6%  proc-vmstat.pgactivate
    688303 ± 27%     -59.1%     281795 ± 57%  proc-vmstat.pgalloc_dma32
  67322783           -54.9%   30342562        proc-vmstat.pgalloc_normal
    898962           +90.3%    1710406        proc-vmstat.pgfault
  26679862 ± 16%     -67.9%    8556739 ± 20%  proc-vmstat.pgfree
 2.684e+08           -56.4%  1.171e+08        proc-vmstat.pgpgin
  25964738 ± 17%     -72.4%    7178398 ± 24%  proc-vmstat.pgscan_file
  25964016 ± 17%     -72.4%    7178398 ± 24%  proc-vmstat.pgscan_kswapd
  25964722 ± 17%     -72.4%    7178380 ± 24%  proc-vmstat.pgsteal_file
  25964000 ± 17%     -72.4%    7178380 ± 24%  proc-vmstat.pgsteal_kswapd
    145319 ± 30%     -70.7%      42528 ± 42%  proc-vmstat.workingset_nodes
      0.60 ± 18%  +2.6e+05%       1557 ± 13%  sched_debug.cfs_rq:/.exec_clock.avg
     10.26 ± 21%  +67553.6%       6939 ±  6%  sched_debug.cfs_rq:/.exec_clock.max
      0.00       +1.2e+104%     123.33 ± 19%  sched_debug.cfs_rq:/.exec_clock.min
      1.76 ± 14%  +1.1e+05%       1962 ±  9%  sched_debug.cfs_rq:/.exec_clock.stddev
      6653 ±113%    +315.9%      27671 ± 19%  sched_debug.cfs_rq:/.load.avg
    999.75 ± 11%     -28.5%     714.62 ± 15%  sched_debug.cfs_rq:/.load_avg.max
    160.30 ± 22%     -34.1%     105.62 ± 13%  sched_debug.cfs_rq:/.load_avg.stddev
     68186 ±  4%     +42.5%      97155 ±  9%  sched_debug.cfs_rq:/.min_vruntime.avg
      0.09 ±  8%     -36.2%       0.06 ± 17%  sched_debug.cfs_rq:/.nr_running.avg
      0.29 ±  5%     -24.4%       0.22 ±  9%  sched_debug.cfs_rq:/.nr_running.stddev
      0.00       +8.3e+101%       0.83 ±  3%  sched_debug.cfs_rq:/.nr_spread_over.avg
      0.00       +2.4e+102%       2.42 ± 15%  sched_debug.cfs_rq:/.nr_spread_over.max
      0.00       +4.4e+101%       0.44 ± 13%  sched_debug.cfs_rq:/.nr_spread_over.stddev
    249.65           -68.6%      78.40 ± 12%  sched_debug.cfs_rq:/.runnable_avg.avg
      1050 ± 16%     -36.8%     663.99 ±  4%  sched_debug.cfs_rq:/.runnable_avg.max
    273.88 ± 11%     -57.7%     115.93 ±  5%  sched_debug.cfs_rq:/.runnable_avg.stddev
    248.94           -68.6%      78.19 ± 12%  sched_debug.cfs_rq:/.util_avg.avg
      1050 ± 16%     -36.8%     663.99 ±  4%  sched_debug.cfs_rq:/.util_avg.max
    273.99 ± 11%     -57.7%     115.96 ±  5%  sched_debug.cfs_rq:/.util_avg.stddev
     22.29 ± 13%     -73.3%       5.95 ± 28%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    487.00 ±  4%     -62.4%     183.23 ±  9%  sched_debug.cfs_rq:/.util_est_enqueued.max
     95.31 ±  7%     -69.6%      28.97 ± 17%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
      1963 ± 17%    +529.3%      12354 ±  5%  sched_debug.cpu.avg_idle.min
    276195           +45.7%     402331 ±  3%  sched_debug.cpu.clock.avg
    276208           +45.7%     402342 ±  3%  sched_debug.cpu.clock.max
    276184           +45.7%     402322 ±  3%  sched_debug.cpu.clock.min
    275931           +44.9%     399732 ±  3%  sched_debug.cpu.clock_task.avg
    276180           +45.4%     401488 ±  3%  sched_debug.cpu.clock_task.max
    267347           +46.1%     390564 ±  3%  sched_debug.cpu.clock_task.min
      1008 ±  6%     +28.7%       1298 ± 14%  sched_debug.cpu.clock_task.stddev
    167.98 ±  6%     -42.6%      96.34 ±  7%  sched_debug.cpu.curr->pid.avg
      3587          +115.5%       7729 ±  4%  sched_debug.cpu.curr->pid.max
      0.00 ±  9%     -47.8%       0.00 ±  7%  sched_debug.cpu.next_balance.stddev
      0.05 ±  7%     -53.5%       0.02 ± 13%  sched_debug.cpu.nr_running.avg
      0.23 ±  6%     -33.2%       0.15 ±  8%  sched_debug.cpu.nr_running.stddev
     41794 ±  4%    +594.3%     290161 ±  9%  sched_debug.cpu.nr_switches.avg
   1272426 ± 14%     +96.1%    2494971 ±  8%  sched_debug.cpu.nr_switches.max
    749.50 ± 26%     +90.5%       1427 ±  3%  sched_debug.cpu.nr_switches.min
    172249 ±  9%    +224.8%     559408 ± 11%  sched_debug.cpu.nr_switches.stddev
      0.01 ± 33%    +299.4%       0.03 ±  3%  sched_debug.cpu.nr_uninterruptible.avg
      9.82 ± 53%  +2.6e+06%     251971 ± 10%  sched_debug.cpu.sched_count.avg
      1267 ± 73%  +1.6e+05%    1990203 ±  9%  sched_debug.cpu.sched_count.max
      0.00       +4.8e+104%     476.40 ±  9%  sched_debug.cpu.sched_count.min
     99.59 ± 68%    +5e+05%     500457 ±  8%  sched_debug.cpu.sched_count.stddev
      4.95 ± 52%  +2.5e+06%     125908 ± 10%  sched_debug.cpu.sched_goidle.avg
    636.00 ± 73%  +1.6e+05%     994888 ±  9%  sched_debug.cpu.sched_goidle.max
      0.00       +1.7e+104%     174.53 ±  9%  sched_debug.cpu.sched_goidle.min
     49.98 ± 68%    +5e+05%     250203 ±  8%  sched_debug.cpu.sched_goidle.stddev
      7.57 ± 63%  +1.7e+06%     125906 ± 10%  sched_debug.cpu.ttwu_count.avg
      1080 ± 69%  +1.4e+05%    1564399 ± 10%  sched_debug.cpu.ttwu_count.max
      0.00       +1.7e+104%     167.17 ±  9%  sched_debug.cpu.ttwu_count.min
     82.64 ± 69%  +3.9e+05%     318703 ±  8%  sched_debug.cpu.ttwu_count.stddev
      0.09 ± 24%  +2.1e+06%       1884 ± 11%  sched_debug.cpu.ttwu_local.avg
      6.00 ± 48%  +6.6e+05%      39709 ± 12%  sched_debug.cpu.ttwu_local.max
      0.00       +1.7e+104%     165.31 ±  9%  sched_debug.cpu.ttwu_local.min
      0.57 ± 33%    +1e+06%       5883 ± 10%  sched_debug.cpu.ttwu_local.stddev
    276186           +45.7%     402323 ±  3%  sched_debug.cpu_clk
    275313           +45.8%     401449 ±  3%  sched_debug.ktime
    276570           +45.6%     402697 ±  3%  sched_debug.sched_clk
 1.561e+09 ±  3%     -24.7%  1.176e+09        perf-stat.i.branch-instructions
      0.73 ±  2%      +0.8        1.58 ± 53%  perf-stat.i.branch-miss-rate%
  11223704           +65.4%   18565879 ± 53%  perf-stat.i.branch-misses
     31.76 ±  4%     -21.6       10.16 ± 37%  perf-stat.i.cache-miss-rate%
  62849935 ±  5%     -84.1%    9983533 ± 19%  perf-stat.i.cache-misses
 1.976e+08 ±  2%     -42.9%  1.129e+08 ± 38%  perf-stat.i.cache-references
    231362 ±  9%     +64.7%     380956        perf-stat.i.context-switches
      2.03 ±  3%     +24.8%       2.54 ±  5%  perf-stat.i.cpi
 1.633e+10 ±  2%     -12.5%  1.429e+10 ±  5%  perf-stat.i.cpu-cycles
    201.27            +4.0%     209.36        perf-stat.i.cpu-migrations
    330.60 ±  2%    +393.1%       1630 ± 25%  perf-stat.i.cycles-between-cache-misses
      0.00 ±  3%      +0.1        0.06 ±154%  perf-stat.i.dTLB-load-miss-rate%
 2.495e+09 ±  2%     -36.9%  1.573e+09        perf-stat.i.dTLB-loads
 1.133e+09 ±  2%     -25.3%  8.456e+08        perf-stat.i.dTLB-stores
     52.73           -16.7       36.01        perf-stat.i.iTLB-load-miss-rate%
   5287524           +33.2%    7040682 ±  6%  perf-stat.i.iTLB-load-misses
   4717927          +165.9%   12544600 ±  5%  perf-stat.i.iTLB-loads
 8.163e+09 ±  2%     -31.3%  5.609e+09        perf-stat.i.instructions
      1536 ±  2%     -47.8%     801.99 ±  6%  perf-stat.i.instructions-per-iTLB-miss
      0.53 ±  3%     -24.2%       0.40 ±  5%  perf-stat.i.ipc
      3388           -72.6%     929.71        perf-stat.i.major-faults
      0.09 ±  2%     -12.5%       0.07 ±  5%  perf-stat.i.metric.GHz
      0.47 ± 13%    +141.9%       1.14 ± 41%  perf-stat.i.metric.K/sec
     28.14 ±  2%     -31.1%      19.39        perf-stat.i.metric.M/sec
      3780            -2.8%       3675        perf-stat.i.minor-faults
   5819081 ± 22%     -82.7%    1006105 ± 16%  perf-stat.i.node-load-misses
   2264579 ± 34%     -84.5%     350533 ±118%  perf-stat.i.node-loads
     18.07 ± 16%     +17.0       35.09 ±  5%  perf-stat.i.node-store-miss-rate%
    548763 ± 23%     -66.9%     181824 ± 10%  perf-stat.i.node-store-misses
   2475598 ± 26%     -85.9%     349482 ± 16%  perf-stat.i.node-stores
      7168           -35.8%       4604        perf-stat.i.page-faults
      0.72 ±  2%      +0.9        1.58 ± 53%  perf-stat.overall.branch-miss-rate%
     31.80 ±  4%     -21.7       10.10 ± 37%  perf-stat.overall.cache-miss-rate%
      2.00 ±  3%     +27.2%       2.55 ±  5%  perf-stat.overall.cpi
    260.50 ±  3%    +472.7%       1491 ± 21%  perf-stat.overall.cycles-between-cache-misses
      0.00 ±  3%      +0.1        0.06 ±154%  perf-stat.overall.dTLB-load-miss-rate%
     52.84           -16.9       35.94        perf-stat.overall.iTLB-load-miss-rate%
      1543 ±  2%     -48.2%     800.16 ±  6%  perf-stat.overall.instructions-per-iTLB-miss
      0.50 ±  3%     -21.2%       0.39 ±  5%  perf-stat.overall.ipc
     18.46 ± 15%     +16.0       34.43 ±  4%  perf-stat.overall.node-store-miss-rate%
   5145611 ±  2%    +475.0%   29587240        perf-stat.overall.path-length
 1.542e+09 ±  3%     -24.0%  1.172e+09        perf-stat.ps.branch-instructions
  11088333           +66.9%   18503999 ± 53%  perf-stat.ps.branch-misses
  62081099 ±  5%     -84.0%    9950189 ± 19%  perf-stat.ps.cache-misses
 1.951e+08 ±  2%     -42.3%  1.125e+08 ± 38%  perf-stat.ps.cache-references
    228507 ±  9%     +66.2%     379670        perf-stat.ps.context-switches
 1.614e+10 ±  2%     -11.8%  1.424e+10 ±  5%  perf-stat.ps.cpu-cycles
    198.86            +4.9%     208.67        perf-stat.ps.cpu-migrations
 2.464e+09 ±  2%     -36.4%  1.568e+09        perf-stat.ps.dTLB-loads
 1.119e+09 ±  2%     -24.7%  8.428e+08        perf-stat.ps.dTLB-stores
   5223493           +34.3%    7017095 ±  6%  perf-stat.ps.iTLB-load-misses
   4660961          +168.2%   12502415 ±  5%  perf-stat.ps.iTLB-loads
 8.064e+09 ±  2%     -30.7%   5.59e+09        perf-stat.ps.instructions
      3364           -72.3%     930.38        perf-stat.ps.major-faults
      3735            -1.9%       3662        perf-stat.ps.minor-faults
   5747438 ± 22%     -82.6%    1002773 ± 16%  perf-stat.ps.node-load-misses
   2237417 ± 34%     -84.4%     349366 ±118%  perf-stat.ps.node-loads
    542133 ± 23%     -66.6%     181241 ± 10%  perf-stat.ps.node-store-misses
   2445326 ± 26%     -85.8%     348318 ± 16%  perf-stat.ps.node-stores
      7099           -35.3%       4593        perf-stat.ps.page-faults
 6.744e+11 ±  2%    +150.8%  1.692e+12        perf-stat.total.instructions
     28155 ±  6%     +94.2%      54665 ±  8%  softirqs.CPU0.SCHED
     13609 ± 24%    +258.6%      48808 ± 50%  softirqs.CPU1.RCU
     16581 ± 27%    +170.3%      44826 ±  9%  softirqs.CPU1.SCHED
     10829 ±  5%    +298.4%      43144 ± 26%  softirqs.CPU10.RCU
     17419 ± 15%    +178.3%      48475 ± 13%  softirqs.CPU10.SCHED
      8886 ±  8%    +358.2%      40718 ± 34%  softirqs.CPU100.RCU
     14235 ± 21%    +206.3%      43606 ± 11%  softirqs.CPU100.SCHED
      9179 ± 10%    +342.8%      40648 ± 32%  softirqs.CPU101.RCU
     13033          +225.5%      42421 ±  8%  softirqs.CPU101.SCHED
      8673 ±  2%    +371.5%      40893 ± 35%  softirqs.CPU102.RCU
     12633 ±  2%    +225.6%      41129 ±  3%  softirqs.CPU102.SCHED
      8864 ±  5%    +348.2%      39728 ± 35%  softirqs.CPU103.RCU
     13131 ±  6%    +210.0%      40709 ±  4%  softirqs.CPU103.SCHED
      9742 ± 15%    +309.8%      39925 ± 36%  softirqs.CPU104.RCU
     14209 ± 17%    +189.4%      41125 ±  4%  softirqs.CPU104.SCHED
      9300 ±  9%    +321.9%      39241 ± 31%  softirqs.CPU105.RCU
     13107 ±  3%    +177.9%      36431 ± 22%  softirqs.CPU105.SCHED
      9001 ±  8%    +334.1%      39080 ± 32%  softirqs.CPU106.RCU
     12124 ± 13%    +233.7%      40458 ±  4%  softirqs.CPU106.SCHED
      9570 ± 15%    +321.1%      40300 ± 37%  softirqs.CPU107.RCU
     13090 ±  6%    +212.7%      40938 ±  3%  softirqs.CPU107.SCHED
     10022 ± 13%    +305.8%      40672 ± 36%  softirqs.CPU108.RCU
     12232 ± 21%    +234.0%      40858 ±  3%  softirqs.CPU108.SCHED
     10443 ± 13%    +285.7%      40285 ± 39%  softirqs.CPU109.RCU
     13776 ±  4%    +196.6%      40860 ±  5%  softirqs.CPU109.SCHED
     15723 ± 58%    +210.5%      48821 ± 31%  softirqs.CPU11.RCU
      9475 ± 11%    +313.9%      39218 ± 33%  softirqs.CPU110.RCU
     12467 ± 21%    +227.7%      40851 ±  3%  softirqs.CPU110.SCHED
      9242 ± 11%    +323.2%      39113 ± 38%  softirqs.CPU111.RCU
     13284 ±  6%    +211.7%      41410 ±  3%  softirqs.CPU111.SCHED
      8818 ±  9%    +299.8%      35259 ± 31%  softirqs.CPU112.RCU
     13744 ±  4%    +199.2%      41125 ±  4%  softirqs.CPU112.SCHED
      8364 ± 15%    +320.8%      35197 ± 34%  softirqs.CPU113.RCU
     13700 ±  5%    +167.7%      36668 ± 22%  softirqs.CPU113.SCHED
      8372 ± 10%    +311.2%      34428 ± 29%  softirqs.CPU114.RCU
     13321 ±  7%    +205.0%      40636 ±  3%  softirqs.CPU114.SCHED
      9096 ±  9%    +291.3%      35598 ± 31%  softirqs.CPU115.RCU
     13680 ± 17%    +200.0%      41044 ±  4%  softirqs.CPU115.SCHED
      8491 ± 11%    +312.5%      35021 ± 34%  softirqs.CPU116.RCU
     13109 ±  5%    +211.4%      40816 ±  4%  softirqs.CPU116.SCHED
      8518 ±  8%    +288.6%      33100 ± 36%  softirqs.CPU117.RCU
     13231 ±  6%    +207.6%      40700 ±  3%  softirqs.CPU117.SCHED
      8632 ± 11%    +299.6%      34492 ± 33%  softirqs.CPU118.RCU
     13322 ±  6%    +206.0%      40761 ±  3%  softirqs.CPU118.SCHED
      8642 ± 10%    +305.1%      35011 ± 28%  softirqs.CPU119.RCU
     13347 ±  6%    +205.6%      40785 ±  3%  softirqs.CPU119.SCHED
     19807 ± 49%    +110.4%      41680 ± 32%  softirqs.CPU12.RCU
      8167 ±  6%    +314.3%      33834 ± 31%  softirqs.CPU120.RCU
     10242 ± 31%    +300.0%      40965 ±  2%  softirqs.CPU120.SCHED
      8076 ± 10%    +314.3%      33461 ± 27%  softirqs.CPU121.RCU
     12776          +221.1%      41026 ±  4%  softirqs.CPU121.SCHED
      7689 ±  8%    +321.3%      32397 ± 25%  softirqs.CPU122.RCU
     12780          +223.5%      41341 ±  6%  softirqs.CPU122.SCHED
      7664 ±  7%    +340.3%      33748 ± 31%  softirqs.CPU123.RCU
     12843          +219.7%      41059 ±  3%  softirqs.CPU123.SCHED
      7675 ±  7%    +333.3%      33256 ± 32%  softirqs.CPU124.RCU
     12774          +221.7%      41099 ±  4%  softirqs.CPU124.SCHED
      7831 ±  5%    +331.2%      33764 ± 31%  softirqs.CPU125.RCU
     12927          +216.7%      40935 ±  3%  softirqs.CPU125.SCHED
      7678 ±  6%    +334.6%      33375 ± 32%  softirqs.CPU126.RCU
     12825          +219.4%      40958 ±  3%  softirqs.CPU126.SCHED
      7857 ± 10%    +325.0%      33394 ± 30%  softirqs.CPU127.RCU
     12729          +225.3%      41416 ±  4%  softirqs.CPU127.SCHED
      8706 ±  9%    +399.8%      43514 ± 35%  softirqs.CPU128.RCU
     12682          +252.2%      44665 ± 17%  softirqs.CPU128.SCHED
      8549 ±  9%    +378.4%      40898 ± 36%  softirqs.CPU129.RCU
     10657 ± 33%    +284.9%      41026 ±  3%  softirqs.CPU129.SCHED
     10431 ± 10%    +361.3%      48118 ± 25%  softirqs.CPU13.RCU
     13931 ± 29%    +297.8%      55426 ± 28%  softirqs.CPU13.SCHED
    189.25 ±122%   +7746.0%      14848 ± 72%  softirqs.CPU13.TIMER
      8720 ± 10%    +387.4%      42503 ± 34%  softirqs.CPU130.RCU
     12768          +220.2%      40886 ±  3%  softirqs.CPU130.SCHED
      8754 ± 10%    +358.9%      40179 ± 38%  softirqs.CPU131.RCU
     12814          +217.1%      40640 ±  2%  softirqs.CPU131.SCHED
      8822 ± 11%    +355.3%      40169 ± 37%  softirqs.CPU132.RCU
     12807          +218.0%      40731 ±  2%  softirqs.CPU132.SCHED
      8558 ±  9%    +346.1%      38175 ± 32%  softirqs.CPU133.RCU
     12794          +217.9%      40674        softirqs.CPU133.SCHED
      8690 ±  8%    +353.2%      39385 ± 38%  softirqs.CPU134.RCU
     12726          +217.4%      40389 ±  3%  softirqs.CPU134.SCHED
      8598 ±  8%    +354.4%      39073 ± 38%  softirqs.CPU135.RCU
     12791          +216.7%      40516 ±  2%  softirqs.CPU135.SCHED
      8642 ± 10%    +370.9%      40697 ± 35%  softirqs.CPU136.RCU
     12761          +217.3%      40493 ±  2%  softirqs.CPU136.SCHED
      8720 ± 10%    +355.5%      39721 ± 38%  softirqs.CPU137.RCU
     12793          +216.5%      40490 ±  2%  softirqs.CPU137.SCHED
      8735 ± 10%    +357.0%      39916 ± 39%  softirqs.CPU138.RCU
     12836          +216.2%      40583 ±  2%  softirqs.CPU138.SCHED
      8646 ±  9%    +373.0%      40893 ± 38%  softirqs.CPU139.RCU
     12763          +218.4%      40632 ±  2%  softirqs.CPU139.SCHED
      9886 ± 16%    +315.7%      41102 ± 32%  softirqs.CPU14.RCU
     13742 ± 10%    +191.4%      40042 ±  4%  softirqs.CPU14.SCHED
      8536 ±  9%    +360.6%      39324 ± 38%  softirqs.CPU140.RCU
     12760          +219.0%      40711 ±  2%  softirqs.CPU140.SCHED
      8493 ± 10%    +366.8%      39648 ± 37%  softirqs.CPU141.RCU
     12752          +219.7%      40764 ±  2%  softirqs.CPU141.SCHED
      8731 ±  9%    +353.2%      39571 ± 38%  softirqs.CPU142.RCU
     12784          +217.6%      40603 ±  2%  softirqs.CPU142.SCHED
      8825 ± 12%    +347.4%      39483 ± 37%  softirqs.CPU143.RCU
     12787          +217.7%      40624 ±  2%  softirqs.CPU143.SCHED
      9382 ± 10%    +350.3%      42249 ± 39%  softirqs.CPU144.RCU
     11627 ± 17%    +222.6%      37511 ± 16%  softirqs.CPU144.SCHED
      8755 ± 11%    +369.8%      41132 ± 38%  softirqs.CPU145.RCU
     12890          +181.6%      36305 ± 22%  softirqs.CPU145.SCHED
      8832 ± 10%    +345.6%      39354 ± 35%  softirqs.CPU146.RCU
     13097 ±  3%    +207.5%      40269 ±  2%  softirqs.CPU146.SCHED
      8680 ± 10%    +380.8%      41739 ± 40%  softirqs.CPU147.RCU
     12805          +218.5%      40782 ±  2%  softirqs.CPU147.SCHED
      8803 ± 10%    +372.2%      41570 ± 42%  softirqs.CPU148.RCU
     12876          +214.5%      40489 ±  2%  softirqs.CPU148.SCHED
      8762 ± 10%    +376.6%      41763 ± 41%  softirqs.CPU149.RCU
     12834          +216.3%      40599 ±  2%  softirqs.CPU149.SCHED
      9296 ±  5%    +339.2%      40829 ± 40%  softirqs.CPU15.RCU
     11269 ± 18%    +254.7%      39971 ±  5%  softirqs.CPU15.SCHED
      8805 ± 10%    +379.5%      42219 ± 41%  softirqs.CPU150.RCU
     12861          +215.6%      40586 ±  2%  softirqs.CPU150.SCHED
      8777 ±  9%    +375.9%      41771 ± 37%  softirqs.CPU151.RCU
     12869          +200.1%      38614 ± 11%  softirqs.CPU151.SCHED
      8741 ± 10%    +385.9%      42475 ± 39%  softirqs.CPU152.RCU
     12967 ±  2%    +215.4%      40903 ±  2%  softirqs.CPU152.SCHED
      8669 ± 10%    +382.1%      41798 ± 39%  softirqs.CPU153.RCU
     12783          +216.6%      40468 ±  2%  softirqs.CPU153.SCHED
      8604 ± 11%    +386.8%      41885 ± 40%  softirqs.CPU154.RCU
     12882          +215.2%      40599 ±  2%  softirqs.CPU154.SCHED
      8581 ± 10%    +380.7%      41256 ± 42%  softirqs.CPU155.RCU
     12919          +213.8%      40539 ±  2%  softirqs.CPU155.SCHED
      8574 ± 13%    +391.1%      42108 ± 43%  softirqs.CPU156.RCU
     13122 ±  2%    +208.9%      40539 ±  2%  softirqs.CPU156.SCHED
      8710 ±  9%    +357.2%      39821 ± 31%  softirqs.CPU157.RCU
     12823          +217.6%      40723 ±  2%  softirqs.CPU157.SCHED
      8840 ± 10%    +376.8%      42146 ± 38%  softirqs.CPU158.RCU
     11642 ± 17%    +248.3%      40553 ±  2%  softirqs.CPU158.SCHED
      8741 ± 11%    +377.4%      41731 ± 40%  softirqs.CPU159.RCU
     12894          +217.4%      40923        softirqs.CPU159.SCHED
     10687 ± 28%    +236.6%      35974 ± 24%  softirqs.CPU16.RCU
     16011 ± 36%    +168.5%      42984 ±  9%  softirqs.CPU16.SCHED
      8942 ± 16%    +316.6%      37248 ± 31%  softirqs.CPU160.RCU
     12776          +216.4%      40424 ±  2%  softirqs.CPU160.SCHED
      8337 ± 12%    +364.5%      38727 ± 37%  softirqs.CPU161.RCU
     11642 ± 18%    +247.1%      40408 ±  2%  softirqs.CPU161.SCHED
      8292 ± 12%    +366.4%      38679 ± 37%  softirqs.CPU162.RCU
     11658 ± 18%    +248.1%      40585        softirqs.CPU162.SCHED
      8770 ± 13%    +346.6%      39162 ± 36%  softirqs.CPU163.RCU
     12851 ±  2%    +215.4%      40531 ±  2%  softirqs.CPU163.SCHED
      8300 ± 13%    +364.8%      38575 ± 36%  softirqs.CPU164.RCU
     12796          +217.1%      40584 ±  2%  softirqs.CPU164.SCHED
      8304 ± 12%    +366.6%      38743 ± 36%  softirqs.CPU165.RCU
     12790          +217.5%      40605 ±  2%  softirqs.CPU165.SCHED
      8217 ± 13%    +367.2%      38392 ± 36%  softirqs.CPU166.RCU
     12815          +217.0%      40618 ±  2%  softirqs.CPU166.SCHED
      8227 ± 13%    +354.4%      37382 ± 33%  softirqs.CPU167.RCU
     12898          +213.8%      40478 ±  2%  softirqs.CPU167.SCHED
      8929 ± 22%    +356.8%      40791 ± 27%  softirqs.CPU168.RCU
     14337 ± 13%    +180.1%      40159 ±  4%  softirqs.CPU168.SCHED
      9588 ± 30%    +273.2%      35784 ± 36%  softirqs.CPU169.RCU
     12206 ± 18%    +231.2%      40429        softirqs.CPU169.SCHED
      8433 ±  2%    +313.4%      34863 ± 28%  softirqs.CPU17.RCU
     12538 ±  2%    +220.0%      40121 ±  4%  softirqs.CPU17.SCHED
     14684 ± 48%    +135.9%      34642 ± 34%  softirqs.CPU170.RCU
     14155 ±  6%    +183.9%      40189 ±  2%  softirqs.CPU170.SCHED
      8857 ± 17%    +327.0%      37819 ± 32%  softirqs.CPU171.RCU
     13488 ±  8%    +201.1%      40613        softirqs.CPU171.SCHED
      8489 ± 11%    +327.1%      36262 ± 37%  softirqs.CPU172.RCU
     13383 ±  3%    +211.5%      41684 ±  4%  softirqs.CPU172.SCHED
      9491 ± 37%    +287.0%      36734 ± 35%  softirqs.CPU173.RCU
     14461 ± 19%    +181.5%      40709        softirqs.CPU173.SCHED
      8949 ± 21%    +308.5%      36557 ± 38%  softirqs.CPU174.RCU
     14129 ± 10%    +184.7%      40232        softirqs.CPU174.SCHED
      9764 ± 27%    +272.0%      36326 ± 35%  softirqs.CPU175.RCU
     13278 ±  6%    +184.5%      37771 ± 24%  softirqs.CPU175.SCHED
     10007 ± 25%    +295.9%      39618 ± 41%  softirqs.CPU176.RCU
     13646 ± 11%    +194.5%      40190 ±  2%  softirqs.CPU176.SCHED
      8861 ±  9%    +347.7%      39671 ± 39%  softirqs.CPU177.RCU
     13077 ±  4%    +207.8%      40253        softirqs.CPU177.SCHED
      9491 ± 17%    +327.7%      40594 ± 41%  softirqs.CPU178.RCU
     13038 ±  2%    +210.7%      40512 ±  2%  softirqs.CPU178.SCHED
      9646 ± 13%    +317.8%      40302 ± 42%  softirqs.CPU179.RCU
     13143          +208.0%      40481 ±  2%  softirqs.CPU179.SCHED
      9495 ± 11%    +261.0%      34284 ± 30%  softirqs.CPU18.RCU
     13072 ±  7%    +206.5%      40060 ±  4%  softirqs.CPU18.SCHED
      9491 ± 14%    +311.6%      39062 ± 33%  softirqs.CPU180.RCU
     13619 ±  5%    +177.2%      37752 ± 23%  softirqs.CPU180.SCHED
      9434 ± 14%    +358.1%      43217 ± 27%  softirqs.CPU181.RCU
     13811 ±  7%    +207.0%      42402 ±  4%  softirqs.CPU181.SCHED
      9980 ± 15%    +304.9%      40412 ± 40%  softirqs.CPU182.RCU
     15174 ± 18%    +170.1%      40979 ±  2%  softirqs.CPU182.SCHED
      9520 ± 16%    +351.7%      43004 ± 33%  softirqs.CPU183.RCU
     13216 ±  6%    +235.5%      44337 ± 16%  softirqs.CPU183.SCHED
      9691 ± 10%    +313.0%      40023 ± 42%  softirqs.CPU184.RCU
     14127 ± 11%    +185.1%      40270 ±  2%  softirqs.CPU184.SCHED
      9677 ± 13%    +328.8%      41496 ± 38%  softirqs.CPU185.RCU
     14189 ±  6%    +183.6%      40237 ±  2%  softirqs.CPU185.SCHED
     11456 ± 45%    +226.1%      37355 ± 34%  softirqs.CPU186.RCU
     13875 ± 10%    +181.2%      39011        softirqs.CPU186.SCHED
      8975 ± 12%    +341.8%      39648 ± 41%  softirqs.CPU187.RCU
     13462 ±  4%    +197.7%      40084 ±  2%  softirqs.CPU187.SCHED
     11438 ± 48%    +250.6%      40099 ± 41%  softirqs.CPU188.RCU
     13465 ±  5%    +201.2%      40555        softirqs.CPU188.SCHED
      8793 ±  8%    +351.8%      39726 ± 39%  softirqs.CPU189.RCU
     13190 ±  2%    +210.1%      40903 ±  2%  softirqs.CPU189.SCHED
      8908 ±  6%    +280.1%      33861 ± 29%  softirqs.CPU19.RCU
     12827 ±  3%    +212.6%      40105 ±  4%  softirqs.CPU19.SCHED
      9377 ± 14%    +355.8%      42747 ± 37%  softirqs.CPU190.RCU
     15467 ± 29%    +166.5%      41224 ±  2%  softirqs.CPU190.SCHED
      9811 ± 18%    +305.3%      39762 ± 40%  softirqs.CPU191.RCU
     12995          +212.3%      40586        softirqs.CPU191.SCHED
     11833 ± 28%    +265.0%      43192 ± 35%  softirqs.CPU2.RCU
     14422 ± 18%    +183.2%      40844 ±  6%  softirqs.CPU2.SCHED
      9443 ±  9%    +262.7%      34254 ± 28%  softirqs.CPU20.RCU
     11335 ± 18%    +254.7%      40201 ±  4%  softirqs.CPU20.SCHED
      8807 ±  5%    +263.1%      31979 ± 36%  softirqs.CPU21.RCU
     12631 ±  4%    +225.0%      41050 ±  3%  softirqs.CPU21.SCHED
      8967 ±  3%    +283.8%      34416 ± 32%  softirqs.CPU22.RCU
     12550 ±  3%    +223.7%      40629 ±  3%  softirqs.CPU22.SCHED
      9185 ± 11%    +265.8%      33601 ± 28%  softirqs.CPU23.RCU
     13890 ± 15%    +186.5%      39792 ±  4%  softirqs.CPU23.SCHED
      9166 ±  8%    +299.4%      36608 ± 28%  softirqs.CPU24.RCU
     12326          +228.3%      40470 ±  6%  softirqs.CPU24.SCHED
      8373 ±  5%    +345.7%      37319 ± 29%  softirqs.CPU25.RCU
      8428 ±  6%    +282.5%      32235 ± 23%  softirqs.CPU26.RCU
     12422 ±  2%    +219.7%      39715 ±  4%  softirqs.CPU26.SCHED
      8420 ±  6%    +301.5%      33811 ± 30%  softirqs.CPU27.RCU
     12381          +220.9%      39731 ±  4%  softirqs.CPU27.SCHED
      8433 ±  6%    +301.2%      33836 ± 31%  softirqs.CPU28.RCU
     12522 ±  2%    +217.0%      39697 ±  4%  softirqs.CPU28.SCHED
      8403 ±  5%    +304.3%      33978 ± 30%  softirqs.CPU29.RCU
     12537 ±  2%    +217.3%      39783 ±  4%  softirqs.CPU29.SCHED
     10175 ±  8%    +312.3%      41951 ± 35%  softirqs.CPU3.RCU
     13461 ±  7%    +201.5%      40583 ±  5%  softirqs.CPU3.SCHED
      8753 ± 10%    +274.9%      32819 ± 34%  softirqs.CPU30.RCU
     12332 ±  2%    +229.9%      40682 ±  4%  softirqs.CPU30.SCHED
      8481 ±  4%    +288.2%      32921 ± 28%  softirqs.CPU31.RCU
     12350 ±  2%    +222.0%      39767 ±  4%  softirqs.CPU31.SCHED
      9504 ±  8%    +338.2%      41643 ± 35%  softirqs.CPU32.RCU
     12387          +223.2%      40040 ±  5%  softirqs.CPU32.SCHED
      9363 ±  8%    +332.1%      40459 ± 36%  softirqs.CPU33.RCU
     12368 ±  2%    +222.9%      39934 ±  4%  softirqs.CPU33.SCHED
      9413 ±  8%    +320.7%      39601 ± 36%  softirqs.CPU34.RCU
     12378 ±  2%    +221.5%      39792 ±  4%  softirqs.CPU34.SCHED
      9351 ±  8%    +333.4%      40522 ± 37%  softirqs.CPU35.RCU
     12373 ±  2%    +220.9%      39707 ±  4%  softirqs.CPU35.SCHED
      9479 ±  8%    +328.3%      40602 ± 36%  softirqs.CPU36.RCU
     12425          +219.4%      39685 ±  4%  softirqs.CPU36.SCHED
      9455 ±  8%    +310.9%      38853 ± 30%  softirqs.CPU37.RCU
     12395          +221.8%      39892 ±  3%  softirqs.CPU37.SCHED
      9396 ±  7%    +330.8%      40480 ± 35%  softirqs.CPU38.RCU
     12440          +218.9%      39667 ±  4%  softirqs.CPU38.SCHED
      9406 ±  8%    +331.2%      40561 ± 36%  softirqs.CPU39.RCU
     12386          +220.8%      39737 ±  4%  softirqs.CPU39.SCHED
     10891 ± 10%    +260.8%      39299 ± 37%  softirqs.CPU4.RCU
     12664 ±  7%    +223.2%      40936 ±  5%  softirqs.CPU4.SCHED
      9190 ±  8%    +334.9%      39969 ± 34%  softirqs.CPU40.RCU
     12378          +226.9%      40467 ±  6%  softirqs.CPU40.SCHED
      9425 ±  8%    +332.7%      40777 ± 35%  softirqs.CPU41.RCU
     12396          +225.5%      40347 ±  3%  softirqs.CPU41.SCHED
      9487 ±  8%    +351.2%      42803 ± 36%  softirqs.CPU42.RCU
     12444          +219.2%      39718 ±  4%  softirqs.CPU42.SCHED
      9470 ±  9%    +334.1%      41108 ± 38%  softirqs.CPU43.RCU
     12515 ±  2%    +216.6%      39623 ±  4%  softirqs.CPU43.SCHED
      9441 ± 10%    +329.9%      40588 ± 36%  softirqs.CPU44.RCU
     12400 ±  2%    +222.1%      39947 ±  4%  softirqs.CPU44.SCHED
      9300 ± 10%    +330.2%      40007 ± 35%  softirqs.CPU45.RCU
     12475          +190.8%      36280 ± 22%  softirqs.CPU45.SCHED
      9377 ±  8%    +329.3%      40255 ± 37%  softirqs.CPU46.RCU
     12494          +217.4%      39651 ±  4%  softirqs.CPU46.SCHED
      8895 ± 14%    +349.4%      39976 ± 35%  softirqs.CPU47.RCU
     12790 ±  2%    +210.3%      39686 ±  4%  softirqs.CPU47.SCHED
      9848 ± 16%    +359.9%      45293 ± 36%  softirqs.CPU48.RCU
     12757 ±  3%    +220.1%      40834 ±  4%  softirqs.CPU48.SCHED
      9521 ±  7%    +361.1%      43906 ± 34%  softirqs.CPU49.RCU
     12549 ±  2%    +220.2%      40185 ±  2%  softirqs.CPU49.SCHED
      9929 ±  5%    +315.3%      41237 ± 33%  softirqs.CPU5.RCU
     12731 ±  4%    +216.8%      40339 ±  5%  softirqs.CPU5.SCHED
      9683 ±  7%    +321.9%      40857 ± 33%  softirqs.CPU50.RCU
     12608 ±  2%    +216.4%      39895 ±  3%  softirqs.CPU50.SCHED
      9570 ±  8%    +349.7%      43039 ± 37%  softirqs.CPU51.RCU
     12810 ±  3%    +213.3%      40136 ±  2%  softirqs.CPU51.SCHED
      9310 ±  9%    +359.7%      42797 ± 38%  softirqs.CPU52.RCU
     12486 ±  2%    +220.9%      40072 ±  3%  softirqs.CPU52.SCHED
      9421 ±  8%    +348.2%      42224 ± 40%  softirqs.CPU53.RCU
     12777 ±  3%    +212.1%      39876 ±  2%  softirqs.CPU53.SCHED
      9290 ±  8%    +358.8%      42620 ± 40%  softirqs.CPU54.RCU
     12517 ±  2%    +218.8%      39906 ±  3%  softirqs.CPU54.SCHED
      9406 ±  9%    +352.2%      42535 ± 38%  softirqs.CPU55.RCU
     12474 ±  2%    +221.0%      40039 ±  3%  softirqs.CPU55.SCHED
      9449 ± 11%    +353.9%      42887 ± 39%  softirqs.CPU56.RCU
     12754 ±  6%    +214.3%      40083 ±  3%  softirqs.CPU56.SCHED
      9226 ±  9%    +361.2%      42554 ± 38%  softirqs.CPU57.RCU
     12437 ±  2%    +221.2%      39945 ±  2%  softirqs.CPU57.SCHED
      9765 ±  8%    +336.5%      42626 ± 38%  softirqs.CPU58.RCU
     12442 ±  2%    +221.5%      40005 ±  3%  softirqs.CPU58.SCHED
      9370 ±  8%    +355.5%      42683 ± 39%  softirqs.CPU59.RCU
     12520 ±  2%    +219.0%      39939 ±  3%  softirqs.CPU59.SCHED
     10076 ±  8%    +307.2%      41032 ± 35%  softirqs.CPU6.RCU
     13078 ±  9%    +207.7%      40235 ±  4%  softirqs.CPU6.SCHED
      8834 ± 15%    +385.6%      42897 ± 41%  softirqs.CPU60.RCU
     12700 ±  2%    +214.1%      39891 ±  3%  softirqs.CPU60.SCHED
      9345 ±  8%    +326.5%      39858 ± 31%  softirqs.CPU61.RCU
     12552 ±  2%    +217.7%      39886 ±  3%  softirqs.CPU61.SCHED
      9352 ±  8%    +358.2%      42847 ± 44%  softirqs.CPU62.RCU
     12482 ±  2%    +219.9%      39926 ±  2%  softirqs.CPU62.SCHED
      9385 ±  8%    +344.1%      41677 ± 40%  softirqs.CPU63.RCU
     12638 ±  2%    +214.6%      39754 ±  2%  softirqs.CPU63.SCHED
      8930 ± 10%    +318.3%      37355 ± 32%  softirqs.CPU64.RCU
     12523 ±  2%    +217.4%      39750 ±  3%  softirqs.CPU64.SCHED
      9025 ± 11%    +330.7%      38875 ± 37%  softirqs.CPU65.RCU
     12466 ±  2%    +219.9%      39879 ±  2%  softirqs.CPU65.SCHED
      9385 ± 13%    +320.0%      39421 ± 36%  softirqs.CPU66.RCU
     13933 ± 16%    +191.7%      40648 ±  3%  softirqs.CPU66.SCHED
      9079 ± 10%    +332.8%      39294 ± 37%  softirqs.CPU67.RCU
     12540 ±  2%    +222.6%      40456 ±  3%  softirqs.CPU67.SCHED
      8842 ± 11%    +341.5%      39041 ± 35%  softirqs.CPU68.RCU
     12495 ±  2%    +220.3%      40026 ±  2%  softirqs.CPU68.SCHED
      9006 ±  9%    +336.4%      39303 ± 35%  softirqs.CPU69.RCU
     12545 ±  2%    +221.0%      40266 ±  3%  softirqs.CPU69.SCHED
      9798 ±  5%    +338.8%      42990 ± 37%  softirqs.CPU7.RCU
     12556 ±  5%    +219.5%      40117 ±  5%  softirqs.CPU7.SCHED
      8929 ± 10%    +330.0%      38397 ± 36%  softirqs.CPU70.RCU
     12511 ±  2%    +219.1%      39919 ±  3%  softirqs.CPU70.SCHED
      8823 ± 11%    +325.0%      37501 ± 34%  softirqs.CPU71.RCU
     12547 ±  2%    +217.2%      39795 ±  2%  softirqs.CPU71.SCHED
     17004 ± 48%    +173.6%      46531 ± 19%  softirqs.CPU72.RCU
     14057 ± 10%    +162.5%      36899 ± 18%  softirqs.CPU72.SCHED
     12132 ± 33%    +225.3%      39467 ± 27%  softirqs.CPU73.RCU
     12923 ± 21%    +204.9%      39403 ±  2%  softirqs.CPU73.SCHED
      9913 ± 20%    +293.3%      38987 ± 23%  softirqs.CPU74.RCU
     13082 ±  3%    +199.9%      39231 ±  2%  softirqs.CPU74.SCHED
      9111 ± 12%    +301.1%      36540 ± 36%  softirqs.CPU75.RCU
     13318 ±  9%    +194.1%      39173 ±  3%  softirqs.CPU75.SCHED
      9245 ± 11%    +297.0%      36701 ± 36%  softirqs.CPU76.RCU
     13034 ±  5%    +200.8%      39205 ±  3%  softirqs.CPU76.SCHED
      9223 ± 14%    +296.7%      36593 ± 37%  softirqs.CPU77.RCU
     13156 ±  7%    +175.7%      36270 ± 15%  softirqs.CPU77.SCHED
      9978 ± 13%    +273.2%      37239 ± 37%  softirqs.CPU78.RCU
     13145 ±  5%    +198.4%      39227 ±  3%  softirqs.CPU78.SCHED
      9745 ±  8%    +273.5%      36396 ± 36%  softirqs.CPU79.RCU
     13170 ±  9%    +196.5%      39047 ±  3%  softirqs.CPU79.SCHED
     10066 ± 11%    +308.7%      41137 ± 35%  softirqs.CPU8.RCU
     11972 ±  5%    +233.6%      39937 ±  4%  softirqs.CPU8.SCHED
      9063 ± 10%    +348.1%      40615 ± 39%  softirqs.CPU80.RCU
     12587 ±  2%    +210.4%      39074 ±  3%  softirqs.CPU80.SCHED
     10588 ± 30%    +282.5%      40501 ± 38%  softirqs.CPU81.RCU
     12554          +211.8%      39146 ±  3%  softirqs.CPU81.SCHED
      9372 ±  8%    +339.0%      41144 ± 40%  softirqs.CPU82.RCU
     12776          +207.5%      39290 ±  3%  softirqs.CPU82.SCHED
     15213 ± 66%    +171.7%      41330 ± 40%  softirqs.CPU83.RCU
     13182 ±  7%    +199.0%      39415 ±  3%  softirqs.CPU83.SCHED
      9362 ±  8%    +328.9%      40155 ± 36%  softirqs.CPU84.RCU
     12712 ±  4%    +208.5%      39220 ±  2%  softirqs.CPU84.SCHED
      9331 ±  8%    +330.7%      40189 ± 34%  softirqs.CPU85.RCU
     12529          +214.6%      39421 ±  2%  softirqs.CPU85.SCHED
      9884 ± 13%    +312.3%      40752 ± 40%  softirqs.CPU86.RCU
     12738 ±  2%    +208.4%      39280 ±  2%  softirqs.CPU86.SCHED
      9213 ±  7%    +335.4%      40111 ± 38%  softirqs.CPU87.RCU
     12458          +212.5%      38939 ±  3%  softirqs.CPU87.SCHED
     10914 ± 25%    +277.8%      41231 ± 40%  softirqs.CPU88.RCU
     14967 ± 28%    +129.8%      34394 ± 19%  softirqs.CPU88.SCHED
     10548 ± 22%    +289.5%      41090 ± 40%  softirqs.CPU89.RCU
     13800 ± 16%    +183.0%      39053 ±  3%  softirqs.CPU89.SCHED
     10261 ±  8%    +291.1%      40133 ± 37%  softirqs.CPU9.RCU
     13468 ± 10%    +197.1%      40012 ±  5%  softirqs.CPU9.SCHED
     10368 ± 18%    +270.2%      38384 ± 32%  softirqs.CPU90.RCU
     13740 ± 15%    +183.1%      38899 ±  3%  softirqs.CPU90.SCHED
     11888 ± 37%    +238.7%      40271 ± 35%  softirqs.CPU91.RCU
     11182 ± 25%    +277.9%      42257 ± 37%  softirqs.CPU92.RCU
     13511 ±  5%    +191.1%      39328 ±  3%  softirqs.CPU92.SCHED
     10250 ± 14%    +298.5%      40849 ± 38%  softirqs.CPU93.RCU
     13479 ±  4%    +191.2%      39253 ±  3%  softirqs.CPU93.SCHED
     10556 ± 13%    +290.6%      41234 ± 41%  softirqs.CPU94.RCU
     13241 ±  5%    +197.5%      39399 ±  3%  softirqs.CPU94.SCHED
     11587 ± 30%    +252.2%      40808 ± 38%  softirqs.CPU95.RCU
     13480 ±  7%    +148.2%      33454 ± 18%  softirqs.CPU95.SCHED
     10291 ± 20%    +273.8%      38473 ± 36%  softirqs.CPU96.RCU
     13645 ± 13%    +132.9%      31773 ± 18%  softirqs.CPU96.SCHED
     11548 ± 14%    +243.4%      39650 ± 36%  softirqs.CPU97.RCU
     15151 ± 26%    +144.3%      37011 ± 23%  softirqs.CPU97.SCHED
      9698 ±  7%    +324.2%      41137 ± 36%  softirqs.CPU98.RCU
     12767 ± 24%    +225.5%      41557 ±  6%  softirqs.CPU98.SCHED
      8787 ±  3%    +358.6%      40301 ± 37%  softirqs.CPU99.RCU
     13025 ±  5%    +222.7%      42038 ±  7%  softirqs.CPU99.SCHED
   1839829 ±  7%    +311.8%    7576022 ± 35%  softirqs.RCU
   2536782          +204.9%    7735859        softirqs.SCHED
     55678 ± 19%     +50.7%      83934 ± 13%  softirqs.TIMER
    196.75 ± 26%    +976.4%       2117 ± 56%  interrupts.31:PCI-MSI.524289-edge.eth0-TxRx-0
    311.75 ± 49%   +1363.4%       4562 ±114%  interrupts.34:PCI-MSI.524292-edge.eth0-TxRx-3
    169.50          +258.7%     608.00        interrupts.9:IO-APIC.9-fasteoi.acpi
   3805227 ± 13%     -81.8%     693390        interrupts.CAL:Function_call_interrupts
    169374          +258.4%     607027        interrupts.CPU0.LOC:Local_timer_interrupts
      2.00 ±122%  +19862.5%     399.25 ± 93%  interrupts.CPU0.NMI:Non-maskable_interrupts
      2.00 ±122%  +19862.5%     399.25 ± 93%  interrupts.CPU0.PMI:Performance_monitoring_interrupts
    169.50          +258.7%     608.00        interrupts.CPU1.9:IO-APIC.9-fasteoi.acpi
    168794          +259.6%     606972        interrupts.CPU1.LOC:Local_timer_interrupts
      0.00       +2.5e+104%     250.25 ± 68%  interrupts.CPU1.NMI:Non-maskable_interrupts
      0.00       +2.5e+104%     250.25 ± 68%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
      3.25 ± 39%   +2107.7%      71.75 ± 84%  interrupts.CPU1.TLB:TLB_shootdowns
    196.75 ± 26%    +976.4%       2117 ± 56%  interrupts.CPU10.31:PCI-MSI.524289-edge.eth0-TxRx-0
    168751          +260.6%     608470        interrupts.CPU10.LOC:Local_timer_interrupts
    887.50 ±  5%   +2127.2%      19766 ± 63%  interrupts.CPU100.CAL:Function_call_interrupts
    168734          +259.8%     607161        interrupts.CPU100.LOC:Local_timer_interrupts
      0.75 ±110%  +80033.3%     601.00 ± 58%  interrupts.CPU100.NMI:Non-maskable_interrupts
      0.75 ±110%  +80033.3%     601.00 ± 58%  interrupts.CPU100.PMI:Performance_monitoring_interrupts
      2.75 ± 78%  +6.1e+05%      16700 ± 65%  interrupts.CPU100.RES:Rescheduling_interrupts
    168717          +259.8%     607042        interrupts.CPU101.LOC:Local_timer_interrupts
      0.00       +8.4e+104%     836.75 ± 80%  interrupts.CPU101.NMI:Non-maskable_interrupts
      0.00       +8.4e+104%     836.75 ± 80%  interrupts.CPU101.PMI:Performance_monitoring_interrupts
    134.00 ±171%  +14656.3%      19773 ± 69%  interrupts.CPU101.RES:Rescheduling_interrupts
    168685          +259.9%     607074        interrupts.CPU102.LOC:Local_timer_interrupts
    168678          +260.4%     607878        interrupts.CPU103.LOC:Local_timer_interrupts
      0.00       +6.3e+104%     629.75 ± 89%  interrupts.CPU103.NMI:Non-maskable_interrupts
      0.00       +6.3e+104%     629.75 ± 89%  interrupts.CPU103.PMI:Performance_monitoring_interrupts
    168681          +259.9%     607078        interrupts.CPU104.LOC:Local_timer_interrupts
      0.00       +5.3e+104%     533.75 ± 88%  interrupts.CPU104.NMI:Non-maskable_interrupts
      0.00       +5.3e+104%     533.75 ± 88%  interrupts.CPU104.PMI:Performance_monitoring_interrupts
    168662          +259.9%     606989        interrupts.CPU105.LOC:Local_timer_interrupts
    168780          +259.7%     607024        interrupts.CPU106.LOC:Local_timer_interrupts
    168663          +260.1%     607395        interrupts.CPU107.LOC:Local_timer_interrupts
    168673          +260.1%     607372        interrupts.CPU108.LOC:Local_timer_interrupts
    168679          +260.7%     608414        interrupts.CPU109.LOC:Local_timer_interrupts
    168690          +261.3%     609427        interrupts.CPU11.LOC:Local_timer_interrupts
    168677          +260.0%     607235        interrupts.CPU110.LOC:Local_timer_interrupts
      0.25 ±173%  +1.6e+05%     412.25 ± 58%  interrupts.CPU110.NMI:Non-maskable_interrupts
      0.25 ±173%  +1.6e+05%     412.25 ± 58%  interrupts.CPU110.PMI:Performance_monitoring_interrupts
    168676          +260.2%     607637        interrupts.CPU111.LOC:Local_timer_interrupts
    168698          +259.8%     606997        interrupts.CPU112.LOC:Local_timer_interrupts
    168708          +259.9%     607197        interrupts.CPU113.LOC:Local_timer_interrupts
    168676          +259.9%     607105        interrupts.CPU114.LOC:Local_timer_interrupts
      0.25 ±173%  +3.8e+05%     960.50 ± 52%  interrupts.CPU114.NMI:Non-maskable_interrupts
      0.25 ±173%  +3.8e+05%     960.50 ± 52%  interrupts.CPU114.PMI:Performance_monitoring_interrupts
    168647          +259.9%     606942        interrupts.CPU115.LOC:Local_timer_interrupts
      0.00       +7.1e+104%     714.25 ± 65%  interrupts.CPU115.NMI:Non-maskable_interrupts
      0.00       +7.1e+104%     714.25 ± 65%  interrupts.CPU115.PMI:Performance_monitoring_interrupts
    168664          +259.9%     606950        interrupts.CPU116.LOC:Local_timer_interrupts
    168662          +259.9%     606957        interrupts.CPU117.LOC:Local_timer_interrupts
    168665          +259.9%     606949        interrupts.CPU118.LOC:Local_timer_interrupts
    168749          +259.7%     607012        interrupts.CPU119.LOC:Local_timer_interrupts
    168770          +262.2%     611266        interrupts.CPU12.LOC:Local_timer_interrupts
    168670          +259.8%     606912        interrupts.CPU120.LOC:Local_timer_interrupts
    168658          +259.9%     607019        interrupts.CPU121.LOC:Local_timer_interrupts
    168653          +259.9%     606921        interrupts.CPU122.LOC:Local_timer_interrupts
    168654          +259.9%     606937        interrupts.CPU123.LOC:Local_timer_interrupts
    168651          +259.9%     606891        interrupts.CPU124.LOC:Local_timer_interrupts
    168655          +259.9%     606945        interrupts.CPU125.LOC:Local_timer_interrupts
    168661          +259.8%     606918        interrupts.CPU126.LOC:Local_timer_interrupts
    168662          +259.9%     606941        interrupts.CPU127.LOC:Local_timer_interrupts
    168645          +259.9%     606923        interrupts.CPU128.LOC:Local_timer_interrupts
    168665          +259.8%     606939        interrupts.CPU129.LOC:Local_timer_interrupts
    311.75 ± 49%   +1363.4%       4562 ±114%  interrupts.CPU13.34:PCI-MSI.524292-edge.eth0-TxRx-3
    168749          +261.0%     609148        interrupts.CPU13.LOC:Local_timer_interrupts
      0.25 ±173%  +2.4e+05%     599.50 ± 80%  interrupts.CPU13.NMI:Non-maskable_interrupts
      0.25 ±173%  +2.4e+05%     599.50 ± 80%  interrupts.CPU13.PMI:Performance_monitoring_interrupts
      2.75 ± 69%  +58036.4%       1598 ± 60%  interrupts.CPU13.RES:Rescheduling_interrupts
    168651          +259.9%     606923        interrupts.CPU130.LOC:Local_timer_interrupts
    168650          +259.9%     606922        interrupts.CPU131.LOC:Local_timer_interrupts
    168649          +259.9%     606921        interrupts.CPU132.LOC:Local_timer_interrupts
    168648          +259.9%     606991        interrupts.CPU133.LOC:Local_timer_interrupts
    168665          +259.9%     607001        interrupts.CPU134.LOC:Local_timer_interrupts
    168658          +259.9%     606933        interrupts.CPU135.LOC:Local_timer_interrupts
    168650          +259.9%     606927        interrupts.CPU136.LOC:Local_timer_interrupts
    168653          +259.8%     606898        interrupts.CPU137.LOC:Local_timer_interrupts
    168633          +259.9%     606926        interrupts.CPU138.LOC:Local_timer_interrupts
    168651          +259.9%     606922        interrupts.CPU139.LOC:Local_timer_interrupts
    168780          +259.8%     607192        interrupts.CPU14.LOC:Local_timer_interrupts
      0.00       +2.9e+104%     291.00 ± 36%  interrupts.CPU14.NMI:Non-maskable_interrupts
      0.00       +2.9e+104%     291.00 ± 36%  interrupts.CPU14.PMI:Performance_monitoring_interrupts
    847.25 ±  3%     +16.6%     988.00 ± 12%  interrupts.CPU140.CAL:Function_call_interrupts
    168641          +259.9%     607001        interrupts.CPU140.LOC:Local_timer_interrupts
    855.75 ±  3%    +164.7%       2265 ±101%  interrupts.CPU141.CAL:Function_call_interrupts
    168644          +259.9%     606993        interrupts.CPU141.LOC:Local_timer_interrupts
      0.50 ±173%  +25300.0%     127.00 ± 18%  interrupts.CPU141.NMI:Non-maskable_interrupts
      0.50 ±173%  +25300.0%     127.00 ± 18%  interrupts.CPU141.PMI:Performance_monitoring_interrupts
    855.75 ±  3%     +42.1%       1216 ± 40%  interrupts.CPU142.CAL:Function_call_interrupts
    168645          +259.9%     606961        interrupts.CPU142.LOC:Local_timer_interrupts
    168642          +259.9%     607011        interrupts.CPU143.LOC:Local_timer_interrupts
      0.50 ±173%  +24350.0%     122.25 ± 20%  interrupts.CPU143.NMI:Non-maskable_interrupts
      0.50 ±173%  +24350.0%     122.25 ± 20%  interrupts.CPU143.PMI:Performance_monitoring_interrupts
    168700          +259.8%     606903        interrupts.CPU144.LOC:Local_timer_interrupts
    168671          +259.8%     606949        interrupts.CPU145.LOC:Local_timer_interrupts
    168651          +259.8%     606876        interrupts.CPU146.LOC:Local_timer_interrupts
    168634          +259.9%     606935        interrupts.CPU147.LOC:Local_timer_interrupts
    168636          +259.9%     606907        interrupts.CPU148.LOC:Local_timer_interrupts
      0.25 ±173%  +61900.0%     155.00 ± 32%  interrupts.CPU148.NMI:Non-maskable_interrupts
      0.25 ±173%  +61900.0%     155.00 ± 32%  interrupts.CPU148.PMI:Performance_monitoring_interrupts
    168648          +259.9%     606923        interrupts.CPU149.LOC:Local_timer_interrupts
    168755          +259.7%     606956        interrupts.CPU15.LOC:Local_timer_interrupts
      0.25 ±173%  +1.6e+05%     405.50 ± 69%  interrupts.CPU15.NMI:Non-maskable_interrupts
      0.25 ±173%  +1.6e+05%     405.50 ± 69%  interrupts.CPU15.PMI:Performance_monitoring_interrupts
     20.50 ±115%   +8467.1%       1756 ± 60%  interrupts.CPU15.RES:Rescheduling_interrupts
    168654          +259.9%     606919        interrupts.CPU150.LOC:Local_timer_interrupts
    168656          +259.9%     606916        interrupts.CPU151.LOC:Local_timer_interrupts
    168627          +259.9%     606919        interrupts.CPU152.LOC:Local_timer_interrupts
    168631          +259.9%     606907        interrupts.CPU153.LOC:Local_timer_interrupts
      0.50 ±173%  +1.5e+06%       7302 ±173%  interrupts.CPU153.RES:Rescheduling_interrupts
    168632          +259.9%     606907        interrupts.CPU154.LOC:Local_timer_interrupts
      1.00 ± 70%  +7.4e+05%       7432 ±173%  interrupts.CPU154.RES:Rescheduling_interrupts
    168632          +260.6%     608163        interrupts.CPU155.LOC:Local_timer_interrupts
    168632          +260.0%     607152        interrupts.CPU156.LOC:Local_timer_interrupts
    168656          +260.0%     607083        interrupts.CPU157.LOC:Local_timer_interrupts
    168642          +260.5%     608009        interrupts.CPU158.LOC:Local_timer_interrupts
      1.75 ±173%  +12971.4%     228.75 ± 77%  interrupts.CPU158.NMI:Non-maskable_interrupts
      1.75 ±173%  +12971.4%     228.75 ± 77%  interrupts.CPU158.PMI:Performance_monitoring_interrupts
      0.75 ±173%  +7.5e+05%       5620 ±167%  interrupts.CPU158.RES:Rescheduling_interrupts
    168632          +259.9%     606992        interrupts.CPU159.LOC:Local_timer_interrupts
      0.25 ±173%  +2.2e+06%       5381 ±173%  interrupts.CPU159.RES:Rescheduling_interrupts
    168746          +259.8%     607196        interrupts.CPU16.LOC:Local_timer_interrupts
      0.25 ±173%  +2.6e+05%     639.00 ± 94%  interrupts.CPU16.NMI:Non-maskable_interrupts
      0.25 ±173%  +2.6e+05%     639.00 ± 94%  interrupts.CPU16.PMI:Performance_monitoring_interrupts
     26.50 ±144%    +300.0%     106.00 ± 57%  interrupts.CPU16.TLB:TLB_shootdowns
    168633          +259.9%     606979        interrupts.CPU160.LOC:Local_timer_interrupts
      0.50 ±173%  +6.7e+05%       3362 ±173%  interrupts.CPU160.RES:Rescheduling_interrupts
    168632          +260.0%     607013        interrupts.CPU161.LOC:Local_timer_interrupts
    168633          +259.9%     606922        interrupts.CPU162.LOC:Local_timer_interrupts
      0.25 ±173%    +1e+06%       2529 ±173%  interrupts.CPU162.RES:Rescheduling_interrupts
    168632          +259.9%     606933        interrupts.CPU163.LOC:Local_timer_interrupts
    168630          +259.9%     606939        interrupts.CPU164.LOC:Local_timer_interrupts
      0.75 ±110%  +4.6e+05%       3465 ±173%  interrupts.CPU164.RES:Rescheduling_interrupts
    168632          +259.9%     606920        interrupts.CPU165.LOC:Local_timer_interrupts
    168633          +259.9%     606905        interrupts.CPU166.LOC:Local_timer_interrupts
    168654          +259.9%     606906        interrupts.CPU167.LOC:Local_timer_interrupts
    168678          +259.9%     607057        interrupts.CPU168.LOC:Local_timer_interrupts
      0.00       +1.2e+104%     123.75 ± 18%  interrupts.CPU168.NMI:Non-maskable_interrupts
      0.00       +1.2e+104%     123.75 ± 18%  interrupts.CPU168.PMI:Performance_monitoring_interrupts
    168691          +259.8%     606961        interrupts.CPU169.LOC:Local_timer_interrupts
      0.00       +1.2e+104%     124.25 ± 15%  interrupts.CPU169.NMI:Non-maskable_interrupts
      0.00       +1.2e+104%     124.25 ± 15%  interrupts.CPU169.PMI:Performance_monitoring_interrupts
    168729          +259.8%     607027        interrupts.CPU17.LOC:Local_timer_interrupts
      0.25 ±173%  +4.1e+05%       1034 ± 71%  interrupts.CPU17.NMI:Non-maskable_interrupts
      0.25 ±173%  +4.1e+05%       1034 ± 71%  interrupts.CPU17.PMI:Performance_monitoring_interrupts
     34.00 ±168%  +18279.4%       6249 ± 63%  interrupts.CPU17.RES:Rescheduling_interrupts
    168656          +259.9%     606935        interrupts.CPU170.LOC:Local_timer_interrupts
      0.00       +1.2e+104%     123.75 ± 15%  interrupts.CPU170.NMI:Non-maskable_interrupts
      0.00       +1.2e+104%     123.75 ± 15%  interrupts.CPU170.PMI:Performance_monitoring_interrupts
    168643          +259.9%     606965        interrupts.CPU171.LOC:Local_timer_interrupts
      0.00       +1.1e+104%     107.00 ± 35%  interrupts.CPU171.NMI:Non-maskable_interrupts
      0.00       +1.1e+104%     107.00 ± 35%  interrupts.CPU171.PMI:Performance_monitoring_interrupts
    168656          +259.9%     606921        interrupts.CPU172.LOC:Local_timer_interrupts
      0.00       +1.2e+104%     120.75 ± 17%  interrupts.CPU172.NMI:Non-maskable_interrupts
      0.00       +1.2e+104%     120.75 ± 17%  interrupts.CPU172.PMI:Performance_monitoring_interrupts
    168625          +259.9%     606952        interrupts.CPU173.LOC:Local_timer_interrupts
      0.00       +1.1e+104%     108.25 ± 35%  interrupts.CPU173.NMI:Non-maskable_interrupts
      0.00       +1.1e+104%     108.25 ± 35%  interrupts.CPU173.PMI:Performance_monitoring_interrupts
    168641          +259.9%     606929        interrupts.CPU174.LOC:Local_timer_interrupts
      0.00       +1.1e+104%     109.25 ± 37%  interrupts.CPU174.NMI:Non-maskable_interrupts
      0.00       +1.1e+104%     109.25 ± 37%  interrupts.CPU174.PMI:Performance_monitoring_interrupts
    168705          +259.8%     606940        interrupts.CPU175.LOC:Local_timer_interrupts
      0.00       +1.1e+104%     109.00 ± 37%  interrupts.CPU175.NMI:Non-maskable_interrupts
      0.00       +1.1e+104%     109.00 ± 37%  interrupts.CPU175.PMI:Performance_monitoring_interrupts
    168689          +259.8%     606919        interrupts.CPU176.LOC:Local_timer_interrupts
      0.00       +1.1e+104%     107.50 ± 35%  interrupts.CPU176.NMI:Non-maskable_interrupts
      0.00       +1.1e+104%     107.50 ± 35%  interrupts.CPU176.PMI:Performance_monitoring_interrupts
    168652          +259.9%     606920        interrupts.CPU177.LOC:Local_timer_interrupts
    168632          +259.9%     606989        interrupts.CPU178.LOC:Local_timer_interrupts
      1.00 ±173%   +9375.0%      94.75 ± 47%  interrupts.CPU178.NMI:Non-maskable_interrupts
      1.00 ±173%   +9375.0%      94.75 ± 47%  interrupts.CPU178.PMI:Performance_monitoring_interrupts
    168665          +259.8%     606916        interrupts.CPU179.LOC:Local_timer_interrupts
      0.75 ±173%  +12466.7%      94.25 ± 48%  interrupts.CPU179.NMI:Non-maskable_interrupts
      0.75 ±173%  +12466.7%      94.25 ± 48%  interrupts.CPU179.PMI:Performance_monitoring_interrupts
    168721          +259.8%     607018        interrupts.CPU18.LOC:Local_timer_interrupts
      0.50 ±173%  +1.8e+05%     920.75 ± 51%  interrupts.CPU18.NMI:Non-maskable_interrupts
      0.50 ±173%  +1.8e+05%     920.75 ± 51%  interrupts.CPU18.PMI:Performance_monitoring_interrupts
    168644          +259.9%     606875        interrupts.CPU180.LOC:Local_timer_interrupts
    168667          +259.9%     606968        interrupts.CPU181.LOC:Local_timer_interrupts
      0.00       +9.9e+103%      99.50 ± 53%  interrupts.CPU181.NMI:Non-maskable_interrupts
      0.00       +9.9e+103%      99.50 ± 53%  interrupts.CPU181.PMI:Performance_monitoring_interrupts
    168628          +260.0%     606999        interrupts.CPU182.LOC:Local_timer_interrupts
      0.00       +9.4e+103%      93.75 ± 46%  interrupts.CPU182.NMI:Non-maskable_interrupts
      0.00       +9.4e+103%      93.75 ± 46%  interrupts.CPU182.PMI:Performance_monitoring_interrupts
    168650          +259.9%     606931        interrupts.CPU183.LOC:Local_timer_interrupts
    168628          +259.9%     606909        interrupts.CPU184.LOC:Local_timer_interrupts
      0.00       +1.1e+104%     106.00 ± 32%  interrupts.CPU184.NMI:Non-maskable_interrupts
      0.00       +1.1e+104%     106.00 ± 32%  interrupts.CPU184.PMI:Performance_monitoring_interrupts
    168630          +259.9%     606919        interrupts.CPU185.LOC:Local_timer_interrupts
      2.00 ±173%   +5250.0%     107.00 ± 34%  interrupts.CPU185.NMI:Non-maskable_interrupts
      2.00 ±173%   +5250.0%     107.00 ± 34%  interrupts.CPU185.PMI:Performance_monitoring_interrupts
    168625          +259.9%     606945        interrupts.CPU186.LOC:Local_timer_interrupts
      1.25 ±173%   +8420.0%     106.50 ± 34%  interrupts.CPU186.NMI:Non-maskable_interrupts
      1.25 ±173%   +8420.0%     106.50 ± 34%  interrupts.CPU186.PMI:Performance_monitoring_interrupts
    168661          +259.9%     606940        interrupts.CPU187.LOC:Local_timer_interrupts
      0.00       +1.1e+104%     106.50 ± 34%  interrupts.CPU187.NMI:Non-maskable_interrupts
      0.00       +1.1e+104%     106.50 ± 34%  interrupts.CPU187.PMI:Performance_monitoring_interrupts
    168635          +259.9%     606935        interrupts.CPU188.LOC:Local_timer_interrupts
      0.25 ±173%  +42000.0%     105.25 ± 32%  interrupts.CPU188.NMI:Non-maskable_interrupts
      0.25 ±173%  +42000.0%     105.25 ± 32%  interrupts.CPU188.PMI:Performance_monitoring_interrupts
    168638          +259.9%     606914        interrupts.CPU189.LOC:Local_timer_interrupts
      0.00         +1e+104%     105.00 ± 32%  interrupts.CPU189.NMI:Non-maskable_interrupts
      0.00         +1e+104%     105.00 ± 32%  interrupts.CPU189.PMI:Performance_monitoring_interrupts
    168726          +259.7%     606992        interrupts.CPU19.LOC:Local_timer_interrupts
    168647          +259.9%     606922        interrupts.CPU190.LOC:Local_timer_interrupts
      0.00       +1.2e+104%     120.75 ± 17%  interrupts.CPU190.NMI:Non-maskable_interrupts
      0.00       +1.2e+104%     120.75 ± 17%  interrupts.CPU190.PMI:Performance_monitoring_interrupts
    168641          +259.9%     606936        interrupts.CPU191.LOC:Local_timer_interrupts
      1.25 ± 34%   +8700.0%     110.00 ± 34%  interrupts.CPU191.NMI:Non-maskable_interrupts
      1.25 ± 34%   +8700.0%     110.00 ± 34%  interrupts.CPU191.PMI:Performance_monitoring_interrupts
    169156          +258.8%     606948        interrupts.CPU2.LOC:Local_timer_interrupts
      0.00       +3.9e+104%     386.75 ± 88%  interrupts.CPU2.NMI:Non-maskable_interrupts
      0.00       +3.9e+104%     386.75 ± 88%  interrupts.CPU2.PMI:Performance_monitoring_interrupts
    170472          +256.1%     607033        interrupts.CPU20.LOC:Local_timer_interrupts
    168724          +259.9%     607157        interrupts.CPU21.LOC:Local_timer_interrupts
     25.00 ±157%    +352.0%     113.00 ± 49%  interrupts.CPU21.TLB:TLB_shootdowns
    168621          +260.0%     607076        interrupts.CPU22.LOC:Local_timer_interrupts
     21.50 ±149%  +25544.2%       5513 ± 61%  interrupts.CPU22.RES:Rescheduling_interrupts
    841.50 ±  3%    +409.8%       4290 ± 37%  interrupts.CPU23.CAL:Function_call_interrupts
    168697          +260.0%     607230        interrupts.CPU23.LOC:Local_timer_interrupts
      5.00 ±150%  +71625.0%       3586 ± 63%  interrupts.CPU23.RES:Rescheduling_interrupts
    168669          +259.8%     606943        interrupts.CPU24.LOC:Local_timer_interrupts
      0.00         +9e+103%      90.00 ± 25%  interrupts.CPU24.NMI:Non-maskable_interrupts
      0.00         +9e+103%      90.00 ± 25%  interrupts.CPU24.PMI:Performance_monitoring_interrupts
    168670          +259.9%     606997        interrupts.CPU25.LOC:Local_timer_interrupts
    168723          +259.8%     607024        interrupts.CPU26.LOC:Local_timer_interrupts
      0.25 ±173%  +34500.0%      86.50 ± 25%  interrupts.CPU26.NMI:Non-maskable_interrupts
      0.25 ±173%  +34500.0%      86.50 ± 25%  interrupts.CPU26.PMI:Performance_monitoring_interrupts
    168697          +259.8%     606962        interrupts.CPU27.LOC:Local_timer_interrupts
    168699          +259.8%     606973        interrupts.CPU28.LOC:Local_timer_interrupts
    168711          +259.8%     607024        interrupts.CPU29.LOC:Local_timer_interrupts
      0.25 ±173%  +44500.0%     111.50 ± 36%  interrupts.CPU29.NMI:Non-maskable_interrupts
      0.25 ±173%  +44500.0%     111.50 ± 36%  interrupts.CPU29.PMI:Performance_monitoring_interrupts
    168698          +260.5%     608141        interrupts.CPU3.LOC:Local_timer_interrupts
     60.00 ±160%   +3653.8%       2252 ± 78%  interrupts.CPU3.RES:Rescheduling_interrupts
    168681          +259.8%     606996        interrupts.CPU30.LOC:Local_timer_interrupts
      0.25 ±173%  +49300.0%     123.50 ± 20%  interrupts.CPU30.NMI:Non-maskable_interrupts
      0.25 ±173%  +49300.0%     123.50 ± 20%  interrupts.CPU30.PMI:Performance_monitoring_interrupts
    168713          +259.7%     606946        interrupts.CPU31.LOC:Local_timer_interrupts
    168730          +259.7%     606975        interrupts.CPU32.LOC:Local_timer_interrupts
    168679          +259.9%     607025        interrupts.CPU33.LOC:Local_timer_interrupts
      0.25 ±173%  +45100.0%     113.00 ± 36%  interrupts.CPU33.NMI:Non-maskable_interrupts
      0.25 ±173%  +45100.0%     113.00 ± 36%  interrupts.CPU33.PMI:Performance_monitoring_interrupts
    168699          +259.8%     606971        interrupts.CPU34.LOC:Local_timer_interrupts
    168704          +259.8%     606960        interrupts.CPU35.LOC:Local_timer_interrupts
    168681          +259.9%     607038        interrupts.CPU36.LOC:Local_timer_interrupts
    168661          +259.9%     606954        interrupts.CPU37.LOC:Local_timer_interrupts
    168704          +259.8%     606956        interrupts.CPU38.LOC:Local_timer_interrupts
    168705          +259.8%     607066        interrupts.CPU39.LOC:Local_timer_interrupts
    168707          +260.2%     607705        interrupts.CPU4.LOC:Local_timer_interrupts
      0.00       +6.8e+104%     675.25 ± 48%  interrupts.CPU4.NMI:Non-maskable_interrupts
      0.00       +6.8e+104%     675.25 ± 48%  interrupts.CPU4.PMI:Performance_monitoring_interrupts
    168574          +260.0%     606944        interrupts.CPU40.LOC:Local_timer_interrupts
    168686          +259.8%     606946        interrupts.CPU41.LOC:Local_timer_interrupts
    168712          +259.7%     606941        interrupts.CPU42.LOC:Local_timer_interrupts
    168695          +259.8%     606939        interrupts.CPU43.LOC:Local_timer_interrupts
    168668          +259.9%     606964        interrupts.CPU44.LOC:Local_timer_interrupts
    168682          +259.8%     606925        interrupts.CPU45.LOC:Local_timer_interrupts
      0.25 ±173%  +50200.0%     125.75 ± 19%  interrupts.CPU45.NMI:Non-maskable_interrupts
      0.25 ±173%  +50200.0%     125.75 ± 19%  interrupts.CPU45.PMI:Performance_monitoring_interrupts
    825.75 ±  3%     +81.8%       1501 ± 71%  interrupts.CPU46.CAL:Function_call_interrupts
    168693          +259.8%     606968        interrupts.CPU46.LOC:Local_timer_interrupts
    168751          +259.7%     606960        interrupts.CPU47.LOC:Local_timer_interrupts
    168668          +259.9%     606953        interrupts.CPU48.LOC:Local_timer_interrupts
      1.50 ± 74%  +1.1e+05%       1719 ±172%  interrupts.CPU48.RES:Rescheduling_interrupts
    168715          +259.8%     606992        interrupts.CPU49.LOC:Local_timer_interrupts
      1.00 ± 70%    +1e+05%       1047 ±172%  interrupts.CPU49.RES:Rescheduling_interrupts
    168759          +259.8%     607195        interrupts.CPU5.LOC:Local_timer_interrupts
    168712          +259.8%     606970        interrupts.CPU50.LOC:Local_timer_interrupts
      0.25 ±173%  +90100.0%     225.50 ± 77%  interrupts.CPU50.NMI:Non-maskable_interrupts
      0.25 ±173%  +90100.0%     225.50 ± 77%  interrupts.CPU50.PMI:Performance_monitoring_interrupts
    168711          +259.8%     606978        interrupts.CPU51.LOC:Local_timer_interrupts
      0.25 ±173%  +70700.0%     177.00 ± 49%  interrupts.CPU51.NMI:Non-maskable_interrupts
      0.25 ±173%  +70700.0%     177.00 ± 49%  interrupts.CPU51.PMI:Performance_monitoring_interrupts
    168718          +259.8%     606971        interrupts.CPU52.LOC:Local_timer_interrupts
      0.25 ±173%  +83400.0%     208.75 ± 68%  interrupts.CPU52.NMI:Non-maskable_interrupts
      0.25 ±173%  +83400.0%     208.75 ± 68%  interrupts.CPU52.PMI:Performance_monitoring_interrupts
      0.75 ± 57%  +1.3e+05%     971.25 ±171%  interrupts.CPU52.RES:Rescheduling_interrupts
    168713          +259.7%     606923        interrupts.CPU53.LOC:Local_timer_interrupts
    168711          +259.7%     606929        interrupts.CPU54.LOC:Local_timer_interrupts
    168690          +259.8%     607009        interrupts.CPU55.LOC:Local_timer_interrupts
    168702          +259.8%     606938        interrupts.CPU56.LOC:Local_timer_interrupts
     44.00 ± 58%    +116.5%      95.25 ± 20%  interrupts.CPU56.TLB:TLB_shootdowns
    168696          +260.6%     608264        interrupts.CPU57.LOC:Local_timer_interrupts
     13.50 ±164%   +4885.2%     673.00 ±163%  interrupts.CPU57.RES:Rescheduling_interrupts
    168688          +260.2%     607578        interrupts.CPU58.LOC:Local_timer_interrupts
      0.00       +2.8e+104%     275.00 ± 94%  interrupts.CPU58.NMI:Non-maskable_interrupts
      0.00       +2.8e+104%     275.00 ± 94%  interrupts.CPU58.PMI:Performance_monitoring_interrupts
    168673          +260.6%     608310        interrupts.CPU59.LOC:Local_timer_interrupts
      0.25 ±173%  +2.1e+05%     537.25 ±171%  interrupts.CPU59.RES:Rescheduling_interrupts
    168744          +259.8%     607104        interrupts.CPU6.LOC:Local_timer_interrupts
      0.25 ±173%  +1.8e+05%     438.00 ±112%  interrupts.CPU6.NMI:Non-maskable_interrupts
      0.25 ±173%  +1.8e+05%     438.00 ±112%  interrupts.CPU6.PMI:Performance_monitoring_interrupts
    168715          +260.0%     607440        interrupts.CPU60.LOC:Local_timer_interrupts
    168678          +259.8%     606941        interrupts.CPU61.LOC:Local_timer_interrupts
      2.00 ± 35%  +14050.0%     283.00 ±170%  interrupts.CPU61.RES:Rescheduling_interrupts
    168690          +259.8%     606956        interrupts.CPU62.LOC:Local_timer_interrupts
      0.75 ± 57%  +28500.0%     214.50 ±170%  interrupts.CPU62.RES:Rescheduling_interrupts
    168674          +259.8%     606946        interrupts.CPU63.LOC:Local_timer_interrupts
    168671          +259.8%     606947        interrupts.CPU64.LOC:Local_timer_interrupts
    168667          +260.0%     607231        interrupts.CPU65.LOC:Local_timer_interrupts
    168665          +259.9%     607031        interrupts.CPU66.LOC:Local_timer_interrupts
    168713          +259.8%     606964        interrupts.CPU67.LOC:Local_timer_interrupts
      0.00       +2.6e+105%       2551 ±173%  interrupts.CPU67.RES:Rescheduling_interrupts
    168659          +259.9%     606929        interrupts.CPU68.LOC:Local_timer_interrupts
    168687          +259.8%     606938        interrupts.CPU69.LOC:Local_timer_interrupts
    169564          +258.7%     608293        interrupts.CPU7.LOC:Local_timer_interrupts
      0.00       +4.6e+104%     456.25 ± 98%  interrupts.CPU7.NMI:Non-maskable_interrupts
      0.00       +4.6e+104%     456.25 ± 98%  interrupts.CPU7.PMI:Performance_monitoring_interrupts
    168688          +259.8%     606937        interrupts.CPU70.LOC:Local_timer_interrupts
    168676          +259.8%     606938        interrupts.CPU71.LOC:Local_timer_interrupts
      0.25 ±173%  +57000.0%     142.75 ± 23%  interrupts.CPU71.NMI:Non-maskable_interrupts
      0.25 ±173%  +57000.0%     142.75 ± 23%  interrupts.CPU71.PMI:Performance_monitoring_interrupts
    168693          +259.8%     606916        interrupts.CPU72.LOC:Local_timer_interrupts
      0.00       +1.2e+104%     123.50 ± 18%  interrupts.CPU72.NMI:Non-maskable_interrupts
      0.00       +1.2e+104%     123.50 ± 18%  interrupts.CPU72.PMI:Performance_monitoring_interrupts
    168726          +259.7%     606965        interrupts.CPU73.LOC:Local_timer_interrupts
      0.00       +1.2e+104%     123.25 ± 18%  interrupts.CPU73.NMI:Non-maskable_interrupts
      0.00       +1.2e+104%     123.25 ± 18%  interrupts.CPU73.PMI:Performance_monitoring_interrupts
    168707          +259.8%     606983        interrupts.CPU74.LOC:Local_timer_interrupts
      0.00       +1.2e+104%     122.75 ± 17%  interrupts.CPU74.NMI:Non-maskable_interrupts
      0.00       +1.2e+104%     122.75 ± 17%  interrupts.CPU74.PMI:Performance_monitoring_interrupts
    168698          +259.8%     606950        interrupts.CPU75.LOC:Local_timer_interrupts
      0.00       +1.2e+104%     121.25 ± 18%  interrupts.CPU75.NMI:Non-maskable_interrupts
      0.00       +1.2e+104%     121.25 ± 18%  interrupts.CPU75.PMI:Performance_monitoring_interrupts
    168712          +259.8%     606950        interrupts.CPU76.LOC:Local_timer_interrupts
      0.00       +1.2e+104%     121.25 ± 18%  interrupts.CPU76.NMI:Non-maskable_interrupts
      0.00       +1.2e+104%     121.25 ± 18%  interrupts.CPU76.PMI:Performance_monitoring_interrupts
    168693          +259.8%     606954        interrupts.CPU77.LOC:Local_timer_interrupts
      0.00       +1.2e+104%     122.25 ± 19%  interrupts.CPU77.NMI:Non-maskable_interrupts
      0.00       +1.2e+104%     122.25 ± 19%  interrupts.CPU77.PMI:Performance_monitoring_interrupts
    170544          +255.9%     606947        interrupts.CPU78.LOC:Local_timer_interrupts
      0.00       +1.2e+104%     123.25 ± 20%  interrupts.CPU78.NMI:Non-maskable_interrupts
      0.00       +1.2e+104%     123.25 ± 20%  interrupts.CPU78.PMI:Performance_monitoring_interrupts
    168699          +259.8%     607008        interrupts.CPU79.LOC:Local_timer_interrupts
    169606          +258.1%     607319        interrupts.CPU8.LOC:Local_timer_interrupts
      0.50 ±173%  +75750.0%     379.25 ± 95%  interrupts.CPU8.NMI:Non-maskable_interrupts
      0.50 ±173%  +75750.0%     379.25 ± 95%  interrupts.CPU8.PMI:Performance_monitoring_interrupts
     23.50 ±141%   +9778.7%       2321 ± 66%  interrupts.CPU8.RES:Rescheduling_interrupts
    168703          +259.8%     606952        interrupts.CPU80.LOC:Local_timer_interrupts
    168709          +259.8%     606982        interrupts.CPU81.LOC:Local_timer_interrupts
      0.00       +1.3e+104%     128.00 ± 27%  interrupts.CPU81.NMI:Non-maskable_interrupts
      0.00       +1.3e+104%     128.00 ± 27%  interrupts.CPU81.PMI:Performance_monitoring_interrupts
    168687          +259.8%     606959        interrupts.CPU82.LOC:Local_timer_interrupts
      0.50 ±100%  +24150.0%     121.25 ± 19%  interrupts.CPU82.NMI:Non-maskable_interrupts
      0.50 ±100%  +24150.0%     121.25 ± 19%  interrupts.CPU82.PMI:Performance_monitoring_interrupts
    168679          +259.8%     606951        interrupts.CPU83.LOC:Local_timer_interrupts
      0.00       +1.2e+104%     121.00 ± 20%  interrupts.CPU83.NMI:Non-maskable_interrupts
      0.00       +1.2e+104%     121.00 ± 20%  interrupts.CPU83.PMI:Performance_monitoring_interrupts
    168663          +259.9%     606951        interrupts.CPU84.LOC:Local_timer_interrupts
    168673          +259.9%     607002        interrupts.CPU85.LOC:Local_timer_interrupts
    168675          +259.8%     606966        interrupts.CPU86.LOC:Local_timer_interrupts
    168677          +259.8%     606895        interrupts.CPU87.LOC:Local_timer_interrupts
    168689          +259.8%     606974        interrupts.CPU88.LOC:Local_timer_interrupts
      0.00       +1.1e+104%     106.25 ± 35%  interrupts.CPU88.NMI:Non-maskable_interrupts
      0.00       +1.1e+104%     106.25 ± 35%  interrupts.CPU88.PMI:Performance_monitoring_interrupts
    168659          +259.9%     606957        interrupts.CPU89.LOC:Local_timer_interrupts
      0.00       +1.1e+104%     107.75 ± 36%  interrupts.CPU89.NMI:Non-maskable_interrupts
      0.00       +1.1e+104%     107.75 ± 36%  interrupts.CPU89.PMI:Performance_monitoring_interrupts
    168716          +260.0%     607387        interrupts.CPU9.LOC:Local_timer_interrupts
      0.25 ±173%  +1.6e+05%     397.25 ± 52%  interrupts.CPU9.NMI:Non-maskable_interrupts
      0.25 ±173%  +1.6e+05%     397.25 ± 52%  interrupts.CPU9.PMI:Performance_monitoring_interrupts
    168658          +259.9%     606957        interrupts.CPU90.LOC:Local_timer_interrupts
      0.00       +1.1e+104%     106.00 ± 35%  interrupts.CPU90.NMI:Non-maskable_interrupts
      0.00       +1.1e+104%     106.00 ± 35%  interrupts.CPU90.PMI:Performance_monitoring_interrupts
    168660          +259.9%     606942        interrupts.CPU91.LOC:Local_timer_interrupts
      0.00         +1e+104%     100.50 ± 30%  interrupts.CPU91.NMI:Non-maskable_interrupts
      0.00         +1e+104%     100.50 ± 30%  interrupts.CPU91.PMI:Performance_monitoring_interrupts
    168672          +259.8%     606942        interrupts.CPU92.LOC:Local_timer_interrupts
      0.00       +1.1e+104%     106.00 ± 35%  interrupts.CPU92.NMI:Non-maskable_interrupts
      0.00       +1.1e+104%     106.00 ± 35%  interrupts.CPU92.PMI:Performance_monitoring_interrupts
    168651          +259.9%     606950        interrupts.CPU93.LOC:Local_timer_interrupts
      0.00       +1.1e+104%     105.75 ± 34%  interrupts.CPU93.NMI:Non-maskable_interrupts
      0.00       +1.1e+104%     105.75 ± 34%  interrupts.CPU93.PMI:Performance_monitoring_interrupts
    168656          +259.9%     606957        interrupts.CPU94.LOC:Local_timer_interrupts
      0.00       +1.1e+104%     106.75 ± 35%  interrupts.CPU94.NMI:Non-maskable_interrupts
      0.00       +1.1e+104%     106.75 ± 35%  interrupts.CPU94.PMI:Performance_monitoring_interrupts
    168661          +259.9%     606948        interrupts.CPU95.LOC:Local_timer_interrupts
    168661          +260.2%     607475        interrupts.CPU96.LOC:Local_timer_interrupts
      0.25 ±173%  +1.6e+05%     408.50 ± 64%  interrupts.CPU96.NMI:Non-maskable_interrupts
      0.25 ±173%  +1.6e+05%     408.50 ± 64%  interrupts.CPU96.PMI:Performance_monitoring_interrupts
    168700          +259.8%     606972        interrupts.CPU97.LOC:Local_timer_interrupts
      0.00       +2.4e+104%     241.50 ± 41%  interrupts.CPU97.NMI:Non-maskable_interrupts
      0.00       +2.4e+104%     241.50 ± 41%  interrupts.CPU97.PMI:Performance_monitoring_interrupts
    196.25 ±147%  +10433.6%      20672 ± 70%  interrupts.CPU97.RES:Rescheduling_interrupts
    169384          +258.5%     607305        interrupts.CPU98.LOC:Local_timer_interrupts
      0.00       +4.3e+104%     430.25 ± 84%  interrupts.CPU98.NMI:Non-maskable_interrupts
      0.00       +4.3e+104%     430.25 ± 84%  interrupts.CPU98.PMI:Performance_monitoring_interrupts
     86.75 ±109%  +21072.9%      18367 ± 66%  interrupts.CPU98.RES:Rescheduling_interrupts
    168699          +259.9%     607066        interrupts.CPU99.LOC:Local_timer_interrupts
  32393442          +259.8%  1.166e+08        interrupts.LOC:Local_timer_interrupts
     18.25 ± 24%  +2.7e+05%      49248 ± 13%  interrupts.NMI:Non-maskable_interrupts
     18.25 ± 24%  +2.7e+05%      49248 ± 13%  interrupts.PMI:Performance_monitoring_interrupts
     52709 ± 28%    +920.4%     537823 ±  9%  interrupts.RES:Rescheduling_interrupts
     37.58 ± 58%     -29.8        7.78 ±  5%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     33.03 ± 53%     -25.3        7.78 ±  5%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     17.43 ±100%     -17.4        0.00        perf-profile.calltrace.cycles-pp.show_interrupts.seq_read.proc_reg_read.vfs_read.ksys_read
     17.42 ±100%     -17.4        0.00        perf-profile.calltrace.cycles-pp.proc_reg_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     17.42 ±100%     -17.4        0.00        perf-profile.calltrace.cycles-pp.seq_read.proc_reg_read.vfs_read.ksys_read.do_syscall_64
     11.42 ± 38%     -11.4        0.00        perf-profile.calltrace.cycles-pp.__libc_start_main
     11.42 ± 38%     -11.4        0.00        perf-profile.calltrace.cycles-pp.main.__libc_start_main
     11.42 ± 38%     -11.4        0.00        perf-profile.calltrace.cycles-pp.run_builtin.main.__libc_start_main
     11.42 ± 38%     -11.4        0.00        perf-profile.calltrace.cycles-pp.cmd_record.run_builtin.main.__libc_start_main
      9.15 ± 23%      -9.1        0.00        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.perf_mmap__read_head.perf_mmap__push.record__mmap_read_evlist.cmd_record
      9.15 ± 23%      -9.1        0.00        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.perf_mmap__read_head.perf_mmap__push.record__mmap_read_evlist
      9.15 ± 23%      -9.1        0.00        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.perf_mmap__read_head.perf_mmap__push
      9.15 ± 23%      -9.1        0.00        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.perf_mmap__read_head
      9.15 ± 23%      -9.1        0.00        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      9.15 ± 23%      -9.1        0.00        perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      9.15 ± 23%      -9.1        0.00        perf-profile.calltrace.cycles-pp.__do_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      9.15 ± 23%      -9.1        0.00        perf-profile.calltrace.cycles-pp.record__mmap_read_evlist.cmd_record.run_builtin.main.__libc_start_main
      9.15 ± 23%      -9.1        0.00        perf-profile.calltrace.cycles-pp.perf_mmap__push.record__mmap_read_evlist.cmd_record.run_builtin.main
      9.15 ± 23%      -9.1        0.00        perf-profile.calltrace.cycles-pp.perf_mmap__read_head.perf_mmap__push.record__mmap_read_evlist.cmd_record.run_builtin
      7.88 ±102%      -7.9        0.00        perf-profile.calltrace.cycles-pp.seq_printf.show_interrupts.seq_read.proc_reg_read.vfs_read
      7.88 ±102%      -7.9        0.00        perf-profile.calltrace.cycles-pp.seq_vprintf.seq_printf.show_interrupts.seq_read.proc_reg_read
      7.48 ± 61%      -7.5        0.00        perf-profile.calltrace.cycles-pp.perf_mmap_fault.__do_fault.do_fault.__handle_mm_fault.handle_mm_fault
      7.07 ± 64%      -7.1        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.07 ± 64%      -7.1        0.00        perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.07 ± 64%      -7.1        0.00        perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.07 ± 64%      -7.1        0.00        perf-profile.calltrace.cycles-pp.mmput.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      7.07 ± 64%      -7.1        0.00        perf-profile.calltrace.cycles-pp.exit_mmap.mmput.do_exit.do_group_exit.__x64_sys_exit_group
      6.21 ±119%      -6.2        0.00        perf-profile.calltrace.cycles-pp.zap_pte_range.unmap_page_range.unmap_vmas.exit_mmap.mmput
      6.21 ±119%      -6.2        0.00        perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.mmput.do_exit.do_group_exit
      6.21 ±119%      -6.2        0.00        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.mmput.do_exit
      5.61 ±103%      -5.6        0.00        perf-profile.calltrace.cycles-pp.vsnprintf.seq_vprintf.seq_printf.show_interrupts.seq_read
      5.40 ±102%      -5.4        0.00        perf-profile.calltrace.cycles-pp.release_pages.tlb_flush_mmu.tlb_finish_mmu.exit_mmap.mmput
      5.40 ±102%      -5.4        0.00        perf-profile.calltrace.cycles-pp.tlb_finish_mmu.exit_mmap.mmput.do_exit.do_group_exit
      5.40 ±102%      -5.4        0.00        perf-profile.calltrace.cycles-pp.tlb_flush_mmu.tlb_finish_mmu.exit_mmap.mmput.do_exit
      0.00            +0.6        0.59 ± 10%  perf-profile.calltrace.cycles-pp.blk_mq_submit_bio.submit_bio_noacct.submit_bio.btrfs_map_bio.btrfs_submit_bio_hook
      0.00            +0.6        0.65 ± 10%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyout.copy_page_to_iter.generic_file_buffered_read.new_sync_read
      0.00            +0.6        0.65 ± 11%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.__queue_work
      0.00            +0.6        0.65 ± 10%  perf-profile.calltrace.cycles-pp.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_on_stack
      0.00            +0.6        0.65 ± 12%  perf-profile.calltrace.cycles-pp.btrfs_lock_and_flush_ordered_range.extent_read_full_page.generic_file_buffered_read.new_sync_read.vfs_read
      0.00            +0.7        0.65 ± 10%  perf-profile.calltrace.cycles-pp.copyout.copy_page_to_iter.generic_file_buffered_read.new_sync_read.vfs_read
      0.00            +0.7        0.67 ± 17%  perf-profile.calltrace.cycles-pp.unwind_next_frame.arch_stack_walk.stack_trace_save_tsk.__account_scheduler_latency.enqueue_entity
      0.00            +0.7        0.71 ± 11%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.__queue_work.queue_work_on
      0.00            +0.7        0.72 ± 11%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.__queue_work.queue_work_on.btrfs_end_bio
      0.00            +0.7        0.72 ±  6%  perf-profile.calltrace.cycles-pp.rebalance_domains.__softirqentry_text_start.asm_call_on_stack.do_softirq_own_stack.irq_exit_rcu
      0.00            +0.7        0.74 ±  9%  perf-profile.calltrace.cycles-pp.copy_page_to_iter.generic_file_buffered_read.new_sync_read.vfs_read.ksys_read
      0.00            +0.8        0.76 ± 19%  perf-profile.calltrace.cycles-pp.endio_readpage_release_extent.end_bio_extent_readpage.end_workqueue_fn.btrfs_work_helper.process_one_work
      0.00            +0.8        0.79 ±  9%  perf-profile.calltrace.cycles-pp.submit_bio_noacct.submit_bio.btrfs_map_bio.btrfs_submit_bio_hook.submit_one_bio
      0.00            +0.8        0.80 ±  9%  perf-profile.calltrace.cycles-pp.submit_bio.btrfs_map_bio.btrfs_submit_bio_hook.submit_one_bio.extent_read_full_page
      0.00            +0.9        0.85 ± 21%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
      0.00            +0.9        0.92 ± 16%  perf-profile.calltrace.cycles-pp.arch_stack_walk.stack_trace_save_tsk.__account_scheduler_latency.enqueue_entity.enqueue_task_fair
      0.00            +1.0        1.01 ±  5%  perf-profile.calltrace.cycles-pp.__sched_text_start.schedule.io_schedule.__lock_page_killable.generic_file_buffered_read
      0.00            +1.0        1.03 ±  6%  perf-profile.calltrace.cycles-pp.schedule.io_schedule.__lock_page_killable.generic_file_buffered_read.new_sync_read
      0.00            +1.0        1.03 ± 46%  perf-profile.calltrace.cycles-pp.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.00            +1.1        1.06 ± 16%  perf-profile.calltrace.cycles-pp.stack_trace_save_tsk.__account_scheduler_latency.enqueue_entity.enqueue_task_fair.ttwu_do_activate
      0.00            +1.1        1.11 ±  8%  perf-profile.calltrace.cycles-pp.btrfs_search_slot.btrfs_lookup_csum.btrfs_lookup_bio_sums.btrfs_submit_bio_hook.submit_one_bio
      0.00            +1.1        1.12 ±  5%  perf-profile.calltrace.cycles-pp.io_schedule.__lock_page_killable.generic_file_buffered_read.new_sync_read.vfs_read
      0.00            +1.2        1.19 ± 11%  perf-profile.calltrace.cycles-pp.try_to_wake_up.__queue_work.queue_work_on.btrfs_end_bio.blk_update_request
      0.00            +1.2        1.21 ±  7%  perf-profile.calltrace.cycles-pp.btrfs_lookup_csum.btrfs_lookup_bio_sums.btrfs_submit_bio_hook.submit_one_bio.extent_read_full_page
      0.00            +1.2        1.21 ± 39%  perf-profile.calltrace.cycles-pp.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00            +1.3        1.31 ± 13%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.asm_call_on_stack.do_softirq_own_stack.irq_exit_rcu.sysvec_apic_timer_interrupt
      0.00            +1.3        1.31 ±  5%  perf-profile.calltrace.cycles-pp.__lock_page_killable.generic_file_buffered_read.new_sync_read.vfs_read.ksys_read
      0.00            +1.3        1.32 ± 13%  perf-profile.calltrace.cycles-pp.asm_call_on_stack.do_softirq_own_stack.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +1.3        1.33 ± 14%  perf-profile.calltrace.cycles-pp.do_softirq_own_stack.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.00            +1.4        1.40 ±  6%  perf-profile.calltrace.cycles-pp.btrfs_map_bio.btrfs_submit_bio_hook.submit_one_bio.extent_read_full_page.generic_file_buffered_read
      0.00            +1.6        1.56 ± 31%  perf-profile.calltrace.cycles-pp.__account_scheduler_latency.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up
      0.00            +1.6        1.60 ± 11%  perf-profile.calltrace.cycles-pp.__queue_work.queue_work_on.btrfs_end_bio.blk_update_request.blk_mq_end_request
      0.00            +1.6        1.60 ±  8%  perf-profile.calltrace.cycles-pp.btrfs_lookup_bio_sums.btrfs_submit_bio_hook.submit_one_bio.extent_read_full_page.generic_file_buffered_read
      0.00            +1.6        1.61 ± 27%  perf-profile.calltrace.cycles-pp.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_on_stack.sysvec_apic_timer_interrupt
      0.00            +1.6        1.62 ± 18%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00            +1.6        1.63 ± 10%  perf-profile.calltrace.cycles-pp.queue_work_on.btrfs_end_bio.blk_update_request.blk_mq_end_request.nvme_irq
      0.00            +1.7        1.70 ± 16%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.wake_page_function
      0.00            +1.7        1.73 ± 23%  perf-profile.calltrace.cycles-pp.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry
      0.00            +1.8        1.77 ± 10%  perf-profile.calltrace.cycles-pp.btrfs_end_bio.blk_update_request.blk_mq_end_request.nvme_irq.__handle_irq_event_percpu
      0.00            +1.8        1.83 ± 17%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.wake_page_function.__wake_up_common
      0.00            +1.9        1.85 ± 16%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.wake_page_function.__wake_up_common.wake_up_page_bit
      0.00            +1.9        1.88 ± 10%  perf-profile.calltrace.cycles-pp.blk_update_request.blk_mq_end_request.nvme_irq.__handle_irq_event_percpu.handle_irq_event_percpu
      0.00            +1.9        1.93 ± 36%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
      0.00            +1.9        1.94 ± 10%  perf-profile.calltrace.cycles-pp.blk_mq_end_request.nvme_irq.__handle_irq_event_percpu.handle_irq_event_percpu.handle_irq_event
      0.00            +2.0        1.97 ± 37%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.00            +2.2        2.19 ±  9%  perf-profile.calltrace.cycles-pp.nvme_irq.__handle_irq_event_percpu.handle_irq_event_percpu.handle_irq_event.handle_edge_irq
      0.00            +2.2        2.20 ±  8%  perf-profile.calltrace.cycles-pp.__handle_irq_event_percpu.handle_irq_event_percpu.handle_irq_event.handle_edge_irq.asm_call_on_stack
      0.00            +2.3        2.26 ±  9%  perf-profile.calltrace.cycles-pp.handle_irq_event_percpu.handle_irq_event.handle_edge_irq.asm_call_on_stack.common_interrupt
      0.00            +2.3        2.33 ± 16%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry.start_secondary
      0.00            +2.4        2.40 ±  8%  perf-profile.calltrace.cycles-pp.handle_irq_event.handle_edge_irq.asm_call_on_stack.common_interrupt.asm_common_interrupt
      0.00            +2.5        2.48 ± 26%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_on_stack
      0.00            +2.5        2.49 ±  9%  perf-profile.calltrace.cycles-pp.handle_edge_irq.asm_call_on_stack.common_interrupt.asm_common_interrupt.cpuidle_enter_state
      0.00            +2.5        2.49 ±  9%  perf-profile.calltrace.cycles-pp.asm_call_on_stack.common_interrupt.asm_common_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00            +2.6        2.65 ± 16%  perf-profile.calltrace.cycles-pp.try_to_wake_up.wake_page_function.__wake_up_common.wake_up_page_bit.end_bio_extent_readpage
      0.00            +2.7        2.68 ± 16%  perf-profile.calltrace.cycles-pp.wake_page_function.__wake_up_common.wake_up_page_bit.end_bio_extent_readpage.end_workqueue_fn
      0.00            +2.7        2.68 ±  9%  perf-profile.calltrace.cycles-pp.common_interrupt.asm_common_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle
      0.00            +2.7        2.70 ±  9%  perf-profile.calltrace.cycles-pp.asm_common_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      0.00            +2.7        2.75 ± 16%  perf-profile.calltrace.cycles-pp.__wake_up_common.wake_up_page_bit.end_bio_extent_readpage.end_workqueue_fn.btrfs_work_helper
      0.00            +2.9        2.95 ± 15%  perf-profile.calltrace.cycles-pp.wake_up_page_bit.end_bio_extent_readpage.end_workqueue_fn.btrfs_work_helper.process_one_work
      0.00            +3.1        3.08 ±  6%  perf-profile.calltrace.cycles-pp.btrfs_submit_bio_hook.submit_one_bio.extent_read_full_page.generic_file_buffered_read.new_sync_read
      0.00            +3.1        3.09 ±  6%  perf-profile.calltrace.cycles-pp.submit_one_bio.extent_read_full_page.generic_file_buffered_read.new_sync_read.vfs_read
      0.00            +3.6        3.62 ± 37%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      0.00            +3.8        3.78 ± 26%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_on_stack.sysvec_apic_timer_interrupt
      0.00            +4.0        4.04 ± 16%  perf-profile.calltrace.cycles-pp.end_bio_extent_readpage.end_workqueue_fn.btrfs_work_helper.process_one_work.worker_thread
      0.00            +4.2        4.22 ±  6%  perf-profile.calltrace.cycles-pp.extent_read_full_page.generic_file_buffered_read.new_sync_read.vfs_read.ksys_read
      0.00            +4.3        4.30 ± 16%  perf-profile.calltrace.cycles-pp.end_workqueue_fn.btrfs_work_helper.process_one_work.worker_thread.kthread
      0.00            +4.4        4.40 ± 16%  perf-profile.calltrace.cycles-pp.btrfs_work_helper.process_one_work.worker_thread.kthread.ret_from_fork
      0.00            +5.2        5.16 ± 16%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork
      0.00            +6.0        6.01 ± 17%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork
      0.00            +6.6        6.56 ± 14%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +6.6        6.59 ± 15%  perf-profile.calltrace.cycles-pp.ret_from_fork
      0.00            +6.6        6.59 ± 15%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
      0.00            +6.7        6.71 ± 14%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.asm_call_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.00            +6.7        6.74 ± 14%  perf-profile.calltrace.cycles-pp.asm_call_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00            +7.7        7.68 ±  6%  perf-profile.calltrace.cycles-pp.generic_file_buffered_read.new_sync_read.vfs_read.ksys_read.do_syscall_64
      0.00            +7.7        7.68 ±  6%  perf-profile.calltrace.cycles-pp.new_sync_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +8.7        8.71 ± 27%  perf-profile.calltrace.cycles-pp.menu_select.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
      0.00           +10.5       10.49 ± 12%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle
      0.00           +18.2       18.16 ± 16%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     45.17 ± 44%     +26.0       71.18 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
     47.25 ± 47%     +35.7       82.93        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
     47.25 ± 47%     +35.8       83.01        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64
     47.25 ± 47%     +35.8       83.01        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64
     47.25 ± 47%     +36.5       83.71        perf-profile.calltrace.cycles-pp.secondary_startup_64
     43.60 ± 53%     -35.6        8.02 ±  5%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     39.05 ± 47%     -31.1        8.00 ±  5%  perf-profile.children.cycles-pp.do_syscall_64
     17.42 ±100%     -17.4        0.00        perf-profile.children.cycles-pp.proc_reg_read
     17.42 ±100%     -17.4        0.01 ±173%  perf-profile.children.cycles-pp.seq_read
     15.76 ±102%     -15.8        0.00        perf-profile.children.cycles-pp.show_interrupts
     11.61 ± 86%     -11.6        0.00        perf-profile.children.cycles-pp.do_group_exit
     11.61 ± 86%     -11.6        0.00        perf-profile.children.cycles-pp.do_exit
     11.61 ± 86%     -11.6        0.00        perf-profile.children.cycles-pp.mmput
     11.61 ± 86%     -11.6        0.00        perf-profile.children.cycles-pp.exit_mmap
     11.42 ± 38%     -11.4        0.00        perf-profile.children.cycles-pp.cmd_record
     11.42 ± 38%     -11.4        0.03 ±105%  perf-profile.children.cycles-pp.__libc_start_main
     11.42 ± 38%     -11.4        0.03 ±105%  perf-profile.children.cycles-pp.main
     11.42 ± 38%     -11.4        0.03 ±105%  perf-profile.children.cycles-pp.run_builtin
      9.15 ± 23%      -9.1        0.00        perf-profile.children.cycles-pp.__do_fault
      9.15 ± 23%      -9.1        0.00        perf-profile.children.cycles-pp.record__mmap_read_evlist
      9.15 ± 23%      -9.1        0.00        perf-profile.children.cycles-pp.perf_mmap__push
      9.15 ± 23%      -9.1        0.00        perf-profile.children.cycles-pp.perf_mmap__read_head
      9.15 ± 23%      -9.1        0.01 ±173%  perf-profile.children.cycles-pp.do_fault
      9.15 ± 23%      -9.1        0.07 ± 30%  perf-profile.children.cycles-pp.__handle_mm_fault
      9.15 ± 23%      -9.1        0.07 ± 22%  perf-profile.children.cycles-pp.handle_mm_fault
      9.15 ± 23%      -9.1        0.07 ± 22%  perf-profile.children.cycles-pp.exc_page_fault
      9.15 ± 23%      -9.1        0.07 ± 22%  perf-profile.children.cycles-pp.do_user_addr_fault
      9.15 ± 23%      -9.1        0.08 ± 19%  perf-profile.children.cycles-pp.asm_exc_page_fault
      7.88 ±102%      -7.9        0.00        perf-profile.children.cycles-pp.seq_printf
      7.88 ±102%      -7.9        0.00        perf-profile.children.cycles-pp.seq_vprintf
      7.48 ± 61%      -7.5        0.00        perf-profile.children.cycles-pp.perf_mmap_fault
      7.07 ± 64%      -7.1        0.00        perf-profile.children.cycles-pp.__x64_sys_exit_group
      6.21 ±119%      -6.2        0.00        perf-profile.children.cycles-pp.zap_pte_range
      6.21 ±119%      -6.2        0.00        perf-profile.children.cycles-pp.unmap_vmas
      6.21 ±119%      -6.2        0.00        perf-profile.children.cycles-pp.unmap_page_range
      5.84 ±116%      -5.8        0.00        perf-profile.children.cycles-pp.walk_component
      5.61 ±103%      -5.6        0.00        perf-profile.children.cycles-pp.vsnprintf
      5.40 ±102%      -5.4        0.00        perf-profile.children.cycles-pp.release_pages
      5.40 ±102%      -5.4        0.00        perf-profile.children.cycles-pp.tlb_finish_mmu
      5.40 ±102%      -5.4        0.00        perf-profile.children.cycles-pp.tlb_flush_mmu
      3.75 ±101%      -3.8        0.00        perf-profile.children.cycles-pp.__lookup_slow
      0.00            +0.1        0.06 ± 22%  perf-profile.children.cycles-pp.read
      0.00            +0.1        0.06 ± 14%  perf-profile.children.cycles-pp.__x64_sys_execve
      0.00            +0.1        0.06 ± 14%  perf-profile.children.cycles-pp.do_execveat_common
      0.00            +0.1        0.06 ± 14%  perf-profile.children.cycles-pp.execve
      0.00            +0.1        0.06 ± 14%  perf-profile.children.cycles-pp._cond_resched
      0.00            +0.1        0.06 ± 14%  perf-profile.children.cycles-pp.free_extent_buffer
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.blk_mq_rq_ctx_init
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.update_stats_enqueue_sleeper
      0.00            +0.1        0.06 ± 16%  perf-profile.children.cycles-pp.__sbitmap_queue_get
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.bio_associate_blkg
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.blk_mq_start_request
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.rmqueue_bulk
      0.00            +0.1        0.06 ± 20%  perf-profile.children.cycles-pp.in_sched_functions
      0.00            +0.1        0.07 ± 39%  perf-profile.children.cycles-pp.rcu_gp_kthread
      0.00            +0.1        0.07 ± 17%  perf-profile.children.cycles-pp.mem_cgroup_charge
      0.00            +0.1        0.07 ± 17%  perf-profile.children.cycles-pp.place_entity
      0.00            +0.1        0.07 ± 12%  perf-profile.children.cycles-pp.__list_add_valid
      0.00            +0.1        0.07 ± 12%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.reweight_entity
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.__might_fault
      0.00            +0.1        0.07 ± 31%  perf-profile.children.cycles-pp.irqtime_account_process_tick
      0.00            +0.1        0.07 ± 20%  perf-profile.children.cycles-pp.mark_page_accessed
      0.00            +0.1        0.07 ± 15%  perf-profile.children.cycles-pp.mark_extent_buffer_accessed
      0.00            +0.1        0.07 ± 11%  perf-profile.children.cycles-pp.btrfs_verify_level_key
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp._find_next_bit
      0.00            +0.1        0.08 ± 14%  perf-profile.children.cycles-pp.cpumask_next_and
      0.00            +0.1        0.08 ± 20%  perf-profile.children.cycles-pp.tick_check_broadcast_expired
      0.00            +0.1        0.08 ± 14%  perf-profile.children.cycles-pp.trigger_load_balance
      0.00            +0.1        0.08 ± 14%  perf-profile.children.cycles-pp.btrfs_bio_counter_sub
      0.00            +0.1        0.08 ± 10%  perf-profile.children.cycles-pp.btrfs_comp_cpu_keys
      0.00            +0.1        0.08 ± 10%  perf-profile.children.cycles-pp.__unwind_start
      0.00            +0.1        0.08 ± 15%  perf-profile.children.cycles-pp.update_cfs_rq_h_load
      0.00            +0.1        0.08 ± 17%  perf-profile.children.cycles-pp.kernel_text_address
      0.00            +0.1        0.08 ± 21%  perf-profile.children.cycles-pp.update_cfs_group
      0.00            +0.1        0.08 ± 24%  perf-profile.children.cycles-pp.blk_mq_get_tag
      0.00            +0.1        0.09 ± 13%  perf-profile.children.cycles-pp.bvec_alloc
      0.00            +0.1        0.09 ± 55%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.00            +0.1        0.09 ± 52%  perf-profile.children.cycles-pp.tick_nohz_tick_stopped
      0.00            +0.1        0.09 ± 11%  perf-profile.children.cycles-pp.idle_cpu
      0.00            +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.finish_task_switch
      0.00            +0.1        0.10 ± 15%  perf-profile.children.cycles-pp.pick_next_entity
      0.00            +0.1        0.10 ± 21%  perf-profile.children.cycles-pp.__blk_mq_alloc_request
      0.00            +0.1        0.10 ±  8%  perf-profile.children.cycles-pp.__x86_indirect_thunk_rax
      0.00            +0.1        0.10 ± 18%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.00            +0.1        0.10 ± 16%  perf-profile.children.cycles-pp.orc_find
      0.00            +0.1        0.10 ± 27%  perf-profile.children.cycles-pp.rb_erase
      0.00            +0.1        0.10 ± 18%  perf-profile.children.cycles-pp.get_cpu_device
      0.00            +0.1        0.10 ± 25%  perf-profile.children.cycles-pp.free_extent_state
      0.00            +0.1        0.10 ± 14%  perf-profile.children.cycles-pp.lru_cache_add
      0.00            +0.1        0.11 ± 25%  perf-profile.children.cycles-pp.menu_reflect
      0.00            +0.1        0.11 ± 10%  perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.00            +0.1        0.11 ± 12%  perf-profile.children.cycles-pp.__kernel_text_address
      0.00            +0.1        0.11 ±  7%  perf-profile.children.cycles-pp.btrfs_release_path
      0.00            +0.1        0.11 ± 12%  perf-profile.children.cycles-pp.rmqueue
      0.00            +0.1        0.11 ± 19%  perf-profile.children.cycles-pp.resched_curr
      0.00            +0.1        0.11 ± 20%  perf-profile.children.cycles-pp.delayacct_end
      0.00            +0.1        0.11 ±  9%  perf-profile.children.cycles-pp.rcu_dynticks_eqs_enter
      0.00            +0.1        0.11 ± 17%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.00            +0.1        0.11 ± 17%  perf-profile.children.cycles-pp.btrfs_get_extent
      0.00            +0.1        0.11 ± 11%  perf-profile.children.cycles-pp.down_read
      0.00            +0.1        0.11 ±  3%  perf-profile.children.cycles-pp.account_entity_dequeue
      0.00            +0.1        0.11 ±  7%  perf-profile.children.cycles-pp.btrfs_free_path
      0.00            +0.1        0.11 ± 11%  perf-profile.children.cycles-pp.stack_trace_consume_entry_nosched
      0.00            +0.1        0.11 ± 45%  perf-profile.children.cycles-pp.io_serial_in
      0.00            +0.1        0.11 ±  9%  perf-profile.children.cycles-pp.unlock_page
      0.00            +0.1        0.12 ±  9%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.00            +0.1        0.12 ± 24%  perf-profile.children.cycles-pp.insert_work
      0.00            +0.1        0.12 ± 11%  perf-profile.children.cycles-pp.alloc_extent_state
      0.00            +0.1        0.13 ± 21%  perf-profile.children.cycles-pp.note_gp_changes
      0.00            +0.1        0.13 ± 24%  perf-profile.children.cycles-pp.rcu_dynticks_eqs_exit
      0.00            +0.1        0.13 ± 10%  perf-profile.children.cycles-pp.update_curr
      0.00            +0.1        0.13 ± 20%  perf-profile.children.cycles-pp.__hrtimer_get_next_event
      0.00            +0.1        0.13 ± 49%  perf-profile.children.cycles-pp.rb_next
      0.00            +0.1        0.13 ± 15%  perf-profile.children.cycles-pp.unwind_get_return_address
      0.00            +0.1        0.14 ±  8%  perf-profile.children.cycles-pp.cache_state_if_flags
      0.00            +0.1        0.14 ± 64%  perf-profile.children.cycles-pp.timerqueue_add
      0.00            +0.1        0.14 ± 13%  perf-profile.children.cycles-pp.generic_bin_search
      0.00            +0.1        0.14 ± 11%  perf-profile.children.cycles-pp.find_get_entry
      0.00            +0.1        0.14 ± 25%  perf-profile.children.cycles-pp._raw_read_lock
      0.00            +0.1        0.14 ±  7%  perf-profile.children.cycles-pp.mempool_alloc
      0.00            +0.1        0.15 ± 12%  perf-profile.children.cycles-pp.pagecache_get_page
      0.00            +0.1        0.15 ± 24%  perf-profile.children.cycles-pp.account_entity_enqueue
      0.00            +0.2        0.15 ± 11%  perf-profile.children.cycles-pp.__radix_tree_lookup
      0.00            +0.2        0.15 ± 58%  perf-profile.children.cycles-pp.enqueue_hrtimer
      0.00            +0.2        0.16 ± 12%  perf-profile.children.cycles-pp.xas_load
      0.00            +0.2        0.16 ± 49%  perf-profile.children.cycles-pp.serial8250_console_putchar
      0.00            +0.2        0.16 ±  8%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.00            +0.2        0.16 ± 49%  perf-profile.children.cycles-pp.wait_for_xmitr
      0.00            +0.2        0.16 ± 21%  perf-profile.children.cycles-pp.check_preempt_curr
      0.00            +0.2        0.16 ± 48%  perf-profile.children.cycles-pp.uart_console_write
      0.00            +0.2        0.17 ± 34%  perf-profile.children.cycles-pp.calc_global_load_tick
      0.00            +0.2        0.17 ± 22%  perf-profile.children.cycles-pp.bio_free
      0.00            +0.2        0.17 ± 25%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.00            +0.2        0.17 ± 48%  perf-profile.children.cycles-pp.serial8250_console_write
      0.00            +0.2        0.17 ± 11%  perf-profile.children.cycles-pp.read_extent_buffer
      0.00            +0.2        0.17 ± 17%  perf-profile.children.cycles-pp.__add_to_page_cache_locked
      0.00            +0.2        0.17 ±  2%  perf-profile.children.cycles-pp.bio_alloc_bioset
      0.00            +0.2        0.17 ± 50%  perf-profile.children.cycles-pp.asm_sysvec_irq_work
      0.00            +0.2        0.17 ± 50%  perf-profile.children.cycles-pp.sysvec_irq_work
      0.00            +0.2        0.17 ± 50%  perf-profile.children.cycles-pp.__sysvec_irq_work
      0.00            +0.2        0.17 ± 50%  perf-profile.children.cycles-pp.irq_work_run
      0.00            +0.2        0.17 ± 50%  perf-profile.children.cycles-pp.irq_work_single
      0.00            +0.2        0.17 ± 50%  perf-profile.children.cycles-pp.printk
      0.00            +0.2        0.17 ± 50%  perf-profile.children.cycles-pp.vprintk_emit
      0.00            +0.2        0.17 ± 50%  perf-profile.children.cycles-pp.console_unlock
      0.00            +0.2        0.17 ± 19%  perf-profile.children.cycles-pp.ttwu_do_wakeup
      0.00            +0.2        0.17 ± 55%  perf-profile.children.cycles-pp.timerqueue_del
      0.00            +0.2        0.18 ± 10%  perf-profile.children.cycles-pp.btrfs_root_node
      0.00            +0.2        0.18 ± 12%  perf-profile.children.cycles-pp.__lookup_extent_mapping
      0.00            +0.2        0.18 ± 10%  perf-profile.children.cycles-pp.__orc_find
      0.00            +0.2        0.18 ± 12%  perf-profile.children.cycles-pp.___might_sleep
      0.00            +0.2        0.18 ±  7%  perf-profile.children.cycles-pp.btrfs_get_io_geometry
      0.00            +0.2        0.18 ±  5%  perf-profile.children.cycles-pp.submit_bio_checks
      0.00            +0.2        0.18 ± 28%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.00            +0.2        0.18 ± 52%  perf-profile.children.cycles-pp.irq_work_run_list
      0.00            +0.2        0.19 ± 15%  perf-profile.children.cycles-pp.rcu_eqs_enter
      0.00            +0.2        0.19 ± 32%  perf-profile.children.cycles-pp.rcu_core
      0.00            +0.2        0.19 ±  3%  perf-profile.children.cycles-pp.btrfs_bio_alloc
      0.00            +0.2        0.20 ± 11%  perf-profile.children.cycles-pp.call_cpuidle
      0.00            +0.2        0.20 ± 19%  perf-profile.children.cycles-pp.update_blocked_averages
      0.00            +0.2        0.20 ±  7%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.00            +0.2        0.20 ±  6%  perf-profile.children.cycles-pp.nvme_queue_rq
      0.00            +0.2        0.20 ±  8%  perf-profile.children.cycles-pp.btrfs_get_chunk_map
      0.00            +0.2        0.21 ± 24%  perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
      0.00            +0.2        0.21 ±  5%  perf-profile.children.cycles-pp.btrfs_read_lock_root_node
      0.00            +0.2        0.21 ± 16%  perf-profile.children.cycles-pp.merge_state
      0.00            +0.2        0.21 ±  5%  perf-profile.children.cycles-pp.submit_extent_page
      0.00            +0.2        0.22 ± 20%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.00            +0.2        0.22 ± 58%  perf-profile.children.cycles-pp.__remove_hrtimer
      0.00            +0.2        0.22 ±  8%  perf-profile.children.cycles-pp.__blk_mq_try_issue_directly
      0.00            +0.2        0.22 ± 22%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.00            +0.2        0.23 ±  8%  perf-profile.children.cycles-pp.blk_mq_try_issue_directly
      0.00            +0.2        0.23 ±  7%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.00            +0.2        0.23 ± 12%  perf-profile.children.cycles-pp.__slab_free
      0.00            +0.2        0.24 ± 20%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.00            +0.2        0.25 ± 22%  perf-profile.children.cycles-pp.update_ts_time_stats
      0.00            +0.2        0.25 ± 15%  perf-profile.children.cycles-pp.run_local_timers
      0.00            +0.2        0.25 ± 16%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.00            +0.3        0.25 ± 19%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.00            +0.3        0.27 ±  7%  perf-profile.children.cycles-pp.__switch_to
      0.00            +0.3        0.27 ±  9%  perf-profile.children.cycles-pp.find_extent_buffer
      0.00            +0.3        0.28 ± 13%  perf-profile.children.cycles-pp.add_to_page_cache_lru
      0.00            +0.3        0.29 ± 10%  perf-profile.children.cycles-pp.__irqentry_text_start
      0.00            +0.3        0.29 ± 17%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.00            +0.3        0.29 ±  9%  perf-profile.children.cycles-pp.__switch_to_asm
      0.00            +0.3        0.30 ± 10%  perf-profile.children.cycles-pp.hrtimer_get_next_event
      0.00            +0.3        0.31 ± 24%  perf-profile.children.cycles-pp.rcu_eqs_exit
      0.00            +0.3        0.31 ± 13%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.00            +0.3        0.33 ±  5%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.00            +0.3        0.33 ± 19%  perf-profile.children.cycles-pp.clear_state_bit
      0.00            +0.3        0.34 ± 29%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.00            +0.4        0.37 ± 12%  perf-profile.children.cycles-pp.kmem_cache_free
      0.00            +0.4        0.38 ± 16%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.00            +0.4        0.39 ± 13%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.00            +0.4        0.43 ± 24%  perf-profile.children.cycles-pp.__clear_extent_bit
      0.00            +0.4        0.44 ±  6%  perf-profile.children.cycles-pp.__btrfs_map_block
      0.00            +0.5        0.45 ±  6%  perf-profile.children.cycles-pp.set_next_entity
      0.00            +0.5        0.46 ±  5%  perf-profile.children.cycles-pp.__do_readpage
      0.00            +0.5        0.48 ± 78%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.00            +0.5        0.49 ± 14%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.00            +0.5        0.50 ± 17%  perf-profile.children.cycles-pp.rcu_idle_exit
      0.00            +0.5        0.51 ±  5%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.00            +0.5        0.52 ± 10%  perf-profile.children.cycles-pp.update_load_avg
      0.00            +0.5        0.52 ±  7%  perf-profile.children.cycles-pp.read_block_for_search
      0.00            +0.6        0.55 ± 15%  perf-profile.children.cycles-pp.__etree_search
      0.00            +0.6        0.57 ±  9%  perf-profile.children.cycles-pp.force_page_cache_readahead
      0.00            +0.6        0.57 ±  9%  perf-profile.children.cycles-pp.page_cache_readahead_unbounded
      0.00            +0.6        0.58 ± 15%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.00            +0.6        0.58 ± 34%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.00            +0.6        0.59 ±  2%  perf-profile.children.cycles-pp.dequeue_entity
      0.00            +0.6        0.59 ± 10%  perf-profile.children.cycles-pp.blk_mq_submit_bio
      0.00            +0.6        0.59 ± 13%  perf-profile.children.cycles-pp.lock_extent_bits
      0.00            +0.6        0.64 ±  3%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.00            +0.6        0.65 ± 12%  perf-profile.children.cycles-pp.btrfs_lock_and_flush_ordered_range
      0.00            +0.6        0.65 ± 10%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      0.00            +0.7        0.66 ± 10%  perf-profile.children.cycles-pp.copyout
      0.00            +0.7        0.68 ± 11%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.00            +0.7        0.69 ±  3%  perf-profile.children.cycles-pp.native_sched_clock
      0.00            +0.7        0.70 ± 92%  perf-profile.children.cycles-pp.start_kernel
      0.00            +0.7        0.72 ±  7%  perf-profile.children.cycles-pp.update_rq_clock
      0.00            +0.7        0.73 ±  5%  perf-profile.children.cycles-pp.rebalance_domains
      0.00            +0.7        0.73 ±  3%  perf-profile.children.cycles-pp.sched_clock
      0.00            +0.7        0.73 ±  8%  perf-profile.children.cycles-pp.read_tsc
      0.00            +0.7        0.74 ±  9%  perf-profile.children.cycles-pp.copy_page_to_iter
      0.00            +0.8        0.76 ± 46%  perf-profile.children.cycles-pp.timekeeping_max_deferment
      0.00            +0.8        0.76 ± 39%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.00            +0.8        0.76 ± 19%  perf-profile.children.cycles-pp.endio_readpage_release_extent
      0.00            +0.8        0.79 ±  9%  perf-profile.children.cycles-pp.submit_bio_noacct
      0.00            +0.8        0.80 ±  9%  perf-profile.children.cycles-pp.submit_bio
      0.00            +0.8        0.81 ±  6%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.00            +0.9        0.87 ± 20%  perf-profile.children.cycles-pp.scheduler_tick
      0.00            +1.0        0.96 ± 17%  perf-profile.children.cycles-pp.unwind_next_frame
      0.00            +1.0        1.00 ± 16%  perf-profile.children.cycles-pp.__set_extent_bit
      0.00            +1.1        1.06 ±  8%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.00            +1.1        1.11 ± 42%  perf-profile.children.cycles-pp.tick_irq_enter
      0.00            +1.1        1.12 ±  8%  perf-profile.children.cycles-pp.btrfs_search_slot
      0.00            +1.1        1.12 ±  5%  perf-profile.children.cycles-pp.io_schedule
      0.00            +1.2        1.21 ±  7%  perf-profile.children.cycles-pp.btrfs_lookup_csum
      0.00            +1.2        1.23 ±  7%  perf-profile.children.cycles-pp._raw_spin_lock
      0.00            +1.3        1.31 ± 35%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.00            +1.3        1.31 ± 16%  perf-profile.children.cycles-pp.arch_stack_walk
      0.00            +1.3        1.32 ±  5%  perf-profile.children.cycles-pp.__lock_page_killable
      0.00            +1.3        1.34 ± 13%  perf-profile.children.cycles-pp.__softirqentry_text_start
      0.00            +1.4        1.35 ± 14%  perf-profile.children.cycles-pp.do_softirq_own_stack
      0.00            +1.4        1.40 ±  6%  perf-profile.children.cycles-pp.btrfs_map_bio
      0.00            +1.6        1.61 ±  7%  perf-profile.children.cycles-pp.btrfs_lookup_bio_sums
      0.00            +1.6        1.61 ± 15%  perf-profile.children.cycles-pp.stack_trace_save_tsk
      0.00            +1.6        1.64 ± 27%  perf-profile.children.cycles-pp.clockevents_program_event
      0.00            +1.7        1.67 ± 11%  perf-profile.children.cycles-pp.__queue_work
      0.00            +1.7        1.69 ± 17%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.00            +1.7        1.69 ±  9%  perf-profile.children.cycles-pp.schedule
      0.00            +1.7        1.71 ± 11%  perf-profile.children.cycles-pp.queue_work_on
      0.00            +1.8        1.75 ± 22%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.00            +1.8        1.84 ± 11%  perf-profile.children.cycles-pp.btrfs_end_bio
      0.00            +2.0        1.96 ± 16%  perf-profile.children.cycles-pp.__account_scheduler_latency
      0.00            +2.0        1.96 ± 11%  perf-profile.children.cycles-pp.blk_update_request
      0.00            +2.0        1.98 ± 36%  perf-profile.children.cycles-pp.update_process_times
      0.00            +2.0        1.99 ± 37%  perf-profile.children.cycles-pp.tick_sched_handle
      0.00            +2.0        2.03 ± 11%  perf-profile.children.cycles-pp.blk_mq_end_request
      0.00            +2.3        2.30 ±  9%  perf-profile.children.cycles-pp.nvme_irq
      0.00            +2.3        2.31 ±  9%  perf-profile.children.cycles-pp.__handle_irq_event_percpu
      0.00            +2.3        2.35 ± 16%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.00            +2.4        2.38 ±  9%  perf-profile.children.cycles-pp.handle_irq_event_percpu
      0.00            +2.5        2.53 ± 26%  perf-profile.children.cycles-pp.tick_sched_timer
      0.00            +2.5        2.53 ±  9%  perf-profile.children.cycles-pp.handle_irq_event
      0.00            +2.6        2.59 ± 15%  perf-profile.children.cycles-pp.enqueue_entity
      0.00            +2.6        2.62 ±  9%  perf-profile.children.cycles-pp.handle_edge_irq
      0.00            +2.7        2.68 ± 16%  perf-profile.children.cycles-pp.wake_page_function
      0.00            +2.8        2.79 ± 15%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.00            +2.8        2.80 ± 15%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.00            +2.8        2.81 ± 10%  perf-profile.children.cycles-pp.common_interrupt
      0.00            +2.8        2.84 ± 10%  perf-profile.children.cycles-pp.asm_common_interrupt
      0.00            +3.0        2.95 ± 16%  perf-profile.children.cycles-pp.wake_up_page_bit
      0.00            +3.1        3.08 ±  6%  perf-profile.children.cycles-pp.btrfs_submit_bio_hook
      0.00            +3.1        3.09 ±  6%  perf-profile.children.cycles-pp.submit_one_bio
      0.00            +3.4        3.38 ± 29%  perf-profile.children.cycles-pp.ktime_get
      0.00            +3.6        3.63 ± 36%  perf-profile.children.cycles-pp.poll_idle
      0.00            +3.9        3.85 ± 26%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.00            +4.0        4.04 ± 16%  perf-profile.children.cycles-pp.end_bio_extent_readpage
      0.00            +4.2        4.22 ±  6%  perf-profile.children.cycles-pp.extent_read_full_page
      0.00            +4.3        4.30 ± 16%  perf-profile.children.cycles-pp.end_workqueue_fn
      0.00            +4.4        4.40 ± 16%  perf-profile.children.cycles-pp.btrfs_work_helper
      0.00            +5.2        5.16 ± 16%  perf-profile.children.cycles-pp.process_one_work
      0.00            +6.0        6.02 ± 16%  perf-profile.children.cycles-pp.worker_thread
      0.00            +6.6        6.59 ± 15%  perf-profile.children.cycles-pp.kthread
      0.00            +6.6        6.59 ± 15%  perf-profile.children.cycles-pp.ret_from_fork
      0.00            +6.7        6.66 ± 13%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.00            +6.8        6.82 ± 14%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.00            +7.7        7.68 ±  6%  perf-profile.children.cycles-pp.generic_file_buffered_read
      0.00            +7.7        7.70 ±  6%  perf-profile.children.cycles-pp.new_sync_read
      0.00            +8.8        8.76 ± 26%  perf-profile.children.cycles-pp.menu_select
      0.00           +10.7       10.66 ± 12%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.00           +11.0       10.98 ±  8%  perf-profile.children.cycles-pp.asm_call_on_stack
      0.00           +14.6       14.62 ± 11%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     45.17 ± 44%     +26.6       71.79 ±  4%  perf-profile.children.cycles-pp.cpuidle_enter_state
     45.17 ± 44%     +26.7       71.84 ±  4%  perf-profile.children.cycles-pp.cpuidle_enter
     47.25 ± 47%     +35.8       83.01        perf-profile.children.cycles-pp.start_secondary
     47.25 ± 47%     +36.4       83.69        perf-profile.children.cycles-pp.do_idle
     47.25 ± 47%     +36.5       83.71        perf-profile.children.cycles-pp.secondary_startup_64
     47.25 ± 47%     +36.5       83.71        perf-profile.children.cycles-pp.cpu_startup_entry
      6.21 ±119%      -6.2        0.00        perf-profile.self.cycles-pp.zap_pte_range
      5.40 ±102%      -5.4        0.00        perf-profile.self.cycles-pp.release_pages
      4.36 ±100%      -4.4        0.00        perf-profile.self.cycles-pp.perf_mmap_fault
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.update_stats_enqueue_sleeper
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.finish_task_switch
      0.00            +0.1        0.06 ± 17%  perf-profile.self.cycles-pp.tick_nohz_get_sleep_length
      0.00            +0.1        0.06 ± 17%  perf-profile.self.cycles-pp.sched_clock
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.__list_add_valid
      0.00            +0.1        0.06 ± 20%  perf-profile.self.cycles-pp.place_entity
      0.00            +0.1        0.07 ± 17%  perf-profile.self.cycles-pp.clockevents_program_event
      0.00            +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.__unwind_start
      0.00            +0.1        0.07 ± 16%  perf-profile.self.cycles-pp.mark_page_accessed
      0.00            +0.1        0.07 ± 12%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.00            +0.1        0.07 ±  6%  perf-profile.self.cycles-pp.reweight_entity
      0.00            +0.1        0.07 ± 21%  perf-profile.self.cycles-pp.tick_check_broadcast_expired
      0.00            +0.1        0.07 ± 31%  perf-profile.self.cycles-pp.irqtime_account_process_tick
      0.00            +0.1        0.07 ± 19%  perf-profile.self.cycles-pp.btrfs_search_slot
      0.00            +0.1        0.07 ± 42%  perf-profile.self.cycles-pp.sched_clock_cpu
      0.00            +0.1        0.07 ± 35%  perf-profile.self.cycles-pp.menu_reflect
      0.00            +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.__x86_indirect_thunk_rax
      0.00            +0.1        0.08 ±  6%  perf-profile.self.cycles-pp._find_next_bit
      0.00            +0.1        0.08 ± 11%  perf-profile.self.cycles-pp.btrfs_comp_cpu_keys
      0.00            +0.1        0.08 ± 20%  perf-profile.self.cycles-pp.__wake_up_common
      0.00            +0.1        0.08 ± 22%  perf-profile.self.cycles-pp.generic_bin_search
      0.00            +0.1        0.08 ± 33%  perf-profile.self.cycles-pp.rcu_eqs_enter
      0.00            +0.1        0.08 ± 15%  perf-profile.self.cycles-pp.update_cfs_rq_h_load
      0.00            +0.1        0.08 ±  8%  perf-profile.self.cycles-pp.cpuidle_governor_latency_req
      0.00            +0.1        0.08 ± 25%  perf-profile.self.cycles-pp.update_cfs_group
      0.00            +0.1        0.08 ± 10%  perf-profile.self.cycles-pp.__do_readpage
      0.00            +0.1        0.08 ± 21%  perf-profile.self.cycles-pp.__queue_work
      0.00            +0.1        0.08 ± 28%  perf-profile.self.cycles-pp.enqueue_entity
      0.00            +0.1        0.09 ± 14%  perf-profile.self.cycles-pp.__hrtimer_get_next_event
      0.00            +0.1        0.09 ± 27%  perf-profile.self.cycles-pp.rb_erase
      0.00            +0.1        0.09 ± 55%  perf-profile.self.cycles-pp.perf_event_task_tick
      0.00            +0.1        0.09 ± 12%  perf-profile.self.cycles-pp.__softirqentry_text_start
      0.00            +0.1        0.09 ± 35%  perf-profile.self.cycles-pp.get_next_timer_interrupt
      0.00            +0.1        0.09 ±  7%  perf-profile.self.cycles-pp.schedule
      0.00            +0.1        0.09 ± 11%  perf-profile.self.cycles-pp.idle_cpu
      0.00            +0.1        0.09 ± 20%  perf-profile.self.cycles-pp.pick_next_entity
      0.00            +0.1        0.09 ±  8%  perf-profile.self.cycles-pp.btrfs_lookup_bio_sums
      0.00            +0.1        0.09 ± 15%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.00            +0.1        0.10 ± 15%  perf-profile.self.cycles-pp.orc_find
      0.00            +0.1        0.10 ±  4%  perf-profile.self.cycles-pp.update_curr
      0.00            +0.1        0.10 ± 14%  perf-profile.self.cycles-pp.worker_thread
      0.00            +0.1        0.10 ± 18%  perf-profile.self.cycles-pp.get_cpu_device
      0.00            +0.1        0.10 ± 25%  perf-profile.self.cycles-pp.free_extent_state
      0.00            +0.1        0.10 ± 22%  perf-profile.self.cycles-pp.insert_work
      0.00            +0.1        0.10 ± 21%  perf-profile.self.cycles-pp.resched_curr
      0.00            +0.1        0.11 ± 10%  perf-profile.self.cycles-pp.down_read
      0.00            +0.1        0.11 ± 12%  perf-profile.self.cycles-pp.rcu_dynticks_eqs_enter
      0.00            +0.1        0.11 ± 12%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.00            +0.1        0.11 ± 13%  perf-profile.self.cycles-pp.rebalance_domains
      0.00            +0.1        0.11 ± 30%  perf-profile.self.cycles-pp.tick_sched_timer
      0.00            +0.1        0.11        perf-profile.self.cycles-pp.account_entity_dequeue
      0.00            +0.1        0.11 ± 17%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.00            +0.1        0.11 ± 11%  perf-profile.self.cycles-pp.unlock_page
      0.00            +0.1        0.11 ±  9%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.00            +0.1        0.11 ± 45%  perf-profile.self.cycles-pp.io_serial_in
      0.00            +0.1        0.12 ± 47%  perf-profile.self.cycles-pp.nvme_irq
      0.00            +0.1        0.12 ± 19%  perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.00            +0.1        0.12 ± 18%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.00            +0.1        0.12 ± 48%  perf-profile.self.cycles-pp.rb_next
      0.00            +0.1        0.12 ± 27%  perf-profile.self.cycles-pp.rcu_dynticks_eqs_exit
      0.00            +0.1        0.13 ± 12%  perf-profile.self.cycles-pp.hrtimer_interrupt
      0.00            +0.1        0.13 ± 38%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.00            +0.1        0.13 ±  9%  perf-profile.self.cycles-pp.cache_state_if_flags
      0.00            +0.1        0.14 ± 15%  perf-profile.self.cycles-pp.xas_load
      0.00            +0.1        0.14 ± 18%  perf-profile.self.cycles-pp.kmem_cache_free
      0.00            +0.1        0.14 ± 24%  perf-profile.self.cycles-pp._raw_read_lock
      0.00            +0.1        0.14 ± 26%  perf-profile.self.cycles-pp.account_entity_enqueue
      0.00            +0.1        0.15 ± 12%  perf-profile.self.cycles-pp.__radix_tree_lookup
      0.00            +0.1        0.15 ± 26%  perf-profile.self.cycles-pp.perf_mux_hrtimer_handler
      0.00            +0.1        0.15 ± 42%  perf-profile.self.cycles-pp.__hrtimer_run_queues
      0.00            +0.2        0.16 ±  6%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.00            +0.2        0.16 ± 19%  perf-profile.self.cycles-pp.rcu_eqs_exit
      0.00            +0.2        0.16 ± 35%  perf-profile.self.cycles-pp.calc_global_load_tick
      0.00            +0.2        0.17 ± 11%  perf-profile.self.cycles-pp.read_extent_buffer
      0.00            +0.2        0.17 ± 13%  perf-profile.self.cycles-pp.process_one_work
      0.00            +0.2        0.17 ±  8%  perf-profile.self.cycles-pp.__lock_page_killable
      0.00            +0.2        0.17 ± 20%  perf-profile.self.cycles-pp.__account_scheduler_latency
      0.00            +0.2        0.17 ±  8%  perf-profile.self.cycles-pp.rcu_idle_exit
      0.00            +0.2        0.18 ± 14%  perf-profile.self.cycles-pp.___might_sleep
      0.00            +0.2        0.18 ± 10%  perf-profile.self.cycles-pp.btrfs_root_node
      0.00            +0.2        0.18 ± 12%  perf-profile.self.cycles-pp.__lookup_extent_mapping
      0.00            +0.2        0.18 ± 10%  perf-profile.self.cycles-pp.__orc_find
      0.00            +0.2        0.18 ± 31%  perf-profile.self.cycles-pp.tsc_verify_tsc_adjust
      0.00            +0.2        0.18 ± 28%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.00            +0.2        0.19 ± 18%  perf-profile.self.cycles-pp.update_load_avg
      0.00            +0.2        0.19 ± 13%  perf-profile.self.cycles-pp.call_cpuidle
      0.00            +0.2        0.19 ± 20%  perf-profile.self.cycles-pp.try_to_wake_up
      0.00            +0.2        0.19 ±  9%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.00            +0.2        0.20 ±  5%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.00            +0.2        0.20 ± 19%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.00            +0.2        0.20 ±  9%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.00            +0.2        0.21 ± 17%  perf-profile.self.cycles-pp.end_bio_extent_readpage
      0.00            +0.2        0.22 ± 13%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.00            +0.2        0.23 ± 11%  perf-profile.self.cycles-pp.__slab_free
      0.00            +0.2        0.23 ± 18%  perf-profile.self.cycles-pp.run_local_timers
      0.00            +0.2        0.23 ± 21%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.00            +0.2        0.25 ± 16%  perf-profile.self.cycles-pp.nr_iowait_cpu
      0.00            +0.3        0.26 ± 14%  perf-profile.self.cycles-pp.stack_trace_save_tsk
      0.00            +0.3        0.26 ±  8%  perf-profile.self.cycles-pp.__switch_to
      0.00            +0.3        0.27 ± 26%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.00            +0.3        0.29 ± 17%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.00            +0.3        0.29 ±  8%  perf-profile.self.cycles-pp.__switch_to_asm
      0.00            +0.3        0.31 ± 13%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.00            +0.4        0.36 ± 11%  perf-profile.self.cycles-pp.set_next_entity
      0.00            +0.4        0.41 ± 38%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.00            +0.4        0.41 ± 10%  perf-profile.self.cycles-pp.update_rq_clock
      0.00            +0.4        0.44 ± 83%  perf-profile.self.cycles-pp.rcu_sched_clock_irq
      0.00            +0.5        0.49 ± 40%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.00            +0.5        0.51 ± 11%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.00            +0.5        0.54 ± 12%  perf-profile.self.cycles-pp.generic_file_buffered_read
      0.00            +0.5        0.54 ± 15%  perf-profile.self.cycles-pp.__etree_search
      0.00            +0.6        0.57 ± 16%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.00            +0.6        0.62 ± 19%  perf-profile.self.cycles-pp.unwind_next_frame
      0.00            +0.6        0.65 ± 10%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      0.00            +0.6        0.65 ± 10%  perf-profile.self.cycles-pp.__sched_text_start
      0.00            +0.7        0.65 ±  7%  perf-profile.self.cycles-pp.do_idle
      0.00            +0.7        0.66 ±  2%  perf-profile.self.cycles-pp.native_sched_clock
      0.00            +0.7        0.71 ±  9%  perf-profile.self.cycles-pp.read_tsc
      0.00            +0.7        0.74 ± 47%  perf-profile.self.cycles-pp.timekeeping_max_deferment
      0.00            +1.0        1.03 ±  8%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.00            +1.1        1.06 ±  9%  perf-profile.self.cycles-pp._raw_spin_lock
      0.00            +2.7        2.72 ± 35%  perf-profile.self.cycles-pp.ktime_get
      0.00            +3.5        3.47 ± 36%  perf-profile.self.cycles-pp.poll_idle
      0.00            +6.1        6.05 ± 34%  perf-profile.self.cycles-pp.menu_select
      0.00            +6.8        6.76 ± 39%  perf-profile.self.cycles-pp.cpuidle_enter_state


                                                                                
                                 fio.read_bw_MBps                               
                                                                                
  3500 +--------------------------------------------------------------------+   
       |.+.+..+.+.+.+..+.+.+.+.+..+.+.+.+..+.+.+.+..+.+.+.+.+..+.+.+.+..+.+.|   
  3000 |-+                                                                  |   
       |                                                                    |   
  2500 |-+                                                                  |   
       |                                                                    |   
  2000 |-+                                                                  |   
       |                                                                    |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
       |                                                                    |   
   500 |-+        O O  O O O O O  O O O O  O O O O  O O O                   |   
       | O    O O                                                           |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                   fio.read_iops                                
                                                                                
  1800 +--------------------------------------------------------------------+   
       |.+.+..+.+.+.+..+.+.+.+.+..+.+.+.+..+.+.+.+..+.+.+.+.+..+.+.+.+..+.+.|   
  1600 |-+                                                                  |   
  1400 |-+                                                                  |   
       |                                                                    |   
  1200 |-+                                                                  |   
  1000 |-+                                                                  |   
       |                                                                    |   
   800 |-+                                                                  |   
   600 |-+                                                                  |   
       |                                                                    |   
   400 |-+                                                                  |   
   200 |-+                                                                  |   
       | O    O O O O  O O O O O  O O O O  O O O O  O O O                   |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                 fio.read_clat_mean_us                          
                                                                                
    5e+07 +-----------------------------------------------------------------+   
  4.5e+07 |-O   O  O                                                        |   
          |          O O O O O O O  O O O O O O O O  O O O                  |   
    4e+07 |-+                                                               |   
  3.5e+07 |-+                                                               |   
          |                                                                 |   
    3e+07 |-+                                                               |   
  2.5e+07 |-+                                                               |   
    2e+07 |-+                                                               |   
          |                                                                 |   
  1.5e+07 |-+                                                               |   
    1e+07 |-+                                                               |   
          |                                                                 |   
    5e+06 |.+.+.+..+.+.+.+.+.+.+.+..+.+.+.+.+.+.+.+..+.+.+.+.+.+.+.+..+.+.+.|   
        0 +-----------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                fio.read_clat_stddev                            
                                                                                
  9e+06 +-------------------------------------------------------------------+   
        |                              O                                    |   
  8e+06 |-+                                                                 |   
  7e+06 |-O    O O   O O    O O O O  O   O   O    O   O                     |   
        |          O      O                O   O    O   O                   |   
  6e+06 |-+                                                                 |   
  5e+06 |-+                                                                 |   
        |                                                                   |   
  4e+06 |-+                                                                 |   
  3e+06 |-+                                                                 |   
        |                                                                   |   
  2e+06 |-+                                                                 |   
  1e+06 |-+                                                                 |   
        |.+.  .+.+.+.+.  .+.+.+.+.+..+.+.+.+. .+.. .+. .+.+.. .+.+.+.+..+.  |   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                fio.read_clat_90__us                            
                                                                                
  6e+07 +-------------------------------------------------------------------+   
        | O    O O                     O                                    |   
  5e+07 |-+        O O O  O O O O O  O   O O O O  O O O O                   |   
        |                                                                   |   
        |                                                                   |   
  4e+07 |-+                                                                 |   
        |                                                                   |   
  3e+07 |-+                                                                 |   
        |                                                                   |   
  2e+07 |-+                                                                 |   
        |                                                                   |   
        |                                                                   |   
  1e+07 |-+                                                                 |   
        |.+.+..+.+.+.+.+..+.+.+.+.+..+.+.+.+.+.+..+.+.+.+.+..+.+.+.+.+..+.+.|   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                fio.read_clat_95__us                            
                                                                                
  6e+07 +-------------------------------------------------------------------+   
        |          O O O  O O O O O  O O O O O O  O O O O                   |   
  5e+07 |-+                                                                 |   
        |                                                                   |   
        |                                                                   |   
  4e+07 |-+                                                                 |   
        |                                                                   |   
  3e+07 |-+                                                                 |   
        |                                                                   |   
  2e+07 |-+                                                                 |   
        |                                                                   |   
        |                                                                   |   
  1e+07 |-+                                                                 |   
        |.+.+..+.+.+.+.+..+.+.+.+.+..+.+.+.+.+.+..+.+.+.+.+..+.+.+.+.+..+.+.|   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                fio.read_clat_99__us                            
                                                                                
  7e+07 +-------------------------------------------------------------------+   
        | O    O O     O               O                                    |   
  6e+07 |-+        O O    O O O O O  O   O O O O  O O O O                   |   
        |                                                                   |   
  5e+07 |-+                                                                 |   
        |                                                                   |   
  4e+07 |-+                                                                 |   
        |                                                                   |   
  3e+07 |-+                                                                 |   
        |                                                                   |   
  2e+07 |-+                                                                 |   
        |                                                                   |   
  1e+07 |-+                                                                 |   
        |.+.+..+.+.+.+.+..+.+.+.+.+..+.+.+.+.+.+..+.+.+.+.+..+.+.+.+.+..+.+.|   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                    fio.workload                                
                                                                                
  140000 +------------------------------------------------------------------+   
         |.+.+.+..+.+.+.+.+.+..+.+.+.+.+.+..+.+.+.+.+.+..+.+.+.+.+.+..+.+.+.|   
  120000 |-+                                                                |   
         |                                                                  |   
  100000 |-+                                                                |   
         |                                                                  |   
   80000 |-+                                                                |   
         |                                                                  |   
   60000 |-+        O O O O O  O O O O O O  O O O O O O  O                  |   
         | O   O  O                                                         |   
   40000 |-+                                                                |   
         |                                                                  |   
   20000 |-+                                                                |   
         |                                                                  |   
       0 +------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                               fio.time.system_time                             
                                                                                
  300 +---------------------------------------------------------------------+   
      | O    O O                                                            |   
  250 |-+                                                                   |   
      |             O O                                                     |   
      |          O      O O  O O O O  O O O O  O O O O  O                   |   
  200 |-+                                                                   |   
      |                                                                     |   
  150 |-+                                                                   |   
      |            .+.        .+.+.                           +..           |   
  100 |.+..+.+.+.+.   +.+.+..+     +..+.+.+.  .+. .+.+..+.+. +   +.+.+.+..+.|   
      |                                     +.   +          +               |   
      |                                                                     |   
   50 |-+                                                                   |   
      |                                                                     |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                       fio.time.percent_of_cpu_this_job_got                     
                                                                                
  200 +---------------------------------------------------------------------+   
  180 |-+ .+       .+   +.     +.+.                           +..           |   
      |.+.  + .+.+.  + +  +.. +    +..+.            .+.. .+  :    .+.+.+..+.|   
  160 |-+    +        +      +          +.+.+..+.+.+    +  + :   +          |   
  140 |-+                                                   +               |   
      |                                                                     |   
  120 |-+                                                                   |   
  100 |-O    O O                                                            |   
   80 |-+        O  O O O O  O O O O  O O O O  O O O O  O                   |   
      |                                                                     |   
   60 |-+                                                                   |   
   40 |-+                                                                   |   
      |                                                                     |   
   20 |-+                                                                   |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                               fio.time.elapsed_time                            
                                                                                
  350 +---------------------------------------------------------------------+   
      |                                                                     |   
  300 |-O    O O O  O O O O  O O O O  O O O O  O O O O  O                   |   
      |                                                                     |   
  250 |-+                                                                   |   
      |                                                                     |   
  200 |-+                                                                   |   
      |                                                                     |   
  150 |-+                                                                   |   
      |                                                                     |   
  100 |-+                                                                   |   
      |.+..+.+.+.+..+.+.+.+..+.+.+.+..+.+.+.+..+.+.+.+..+.+.+.+..+.+.+.+..+.|   
   50 |-+                                                                   |   
      |                                                                     |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                             fio.time.elapsed_time.max                          
                                                                                
  350 +---------------------------------------------------------------------+   
      |                                                                     |   
  300 |-O    O O O  O O O O  O O O O  O O O O  O O O O  O                   |   
      |                                                                     |   
  250 |-+                                                                   |   
      |                                                                     |   
  200 |-+                                                                   |   
      |                                                                     |   
  150 |-+                                                                   |   
      |                                                                     |   
  100 |-+                                                                   |   
      |.+..+.+.+.+..+.+.+.+..+.+.+.+..+.+.+.+..+.+.+.+..+.+.+.+..+.+.+.+..+.|   
   50 |-+                                                                   |   
      |                                                                     |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                          fio.time.voluntary_context_switches                   
                                                                                
    3e+07 +-----------------------------------------------------------------+   
          | O                                                               |   
  2.5e+07 |-+   O  O                                                        |   
          |                                                                 |   
          |                                                                 |   
    2e+07 |-+                                                               |   
          |                                                                 |   
  1.5e+07 |-+                                                               |   
          |                +     +..+   +                      +            |   
    1e+07 |-+.+    +   +  : :   :    : : +            .+   +  : + .+..+. .+.|   
          |.+  + .. + + + : :   :    : :  +.+. .+.  .+  + + + :  +      +   |   
          |     +    +   +   +.+      +       +   +.     +   +              |   
    5e+06 |-+                                                               |   
          |                                                                 |   
        0 +-----------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                             fio.time.file_system_inputs                        
                                                                                
  6e+08 +-------------------------------------------------------------------+   
        |.+.+..+.+.+.+.+..+.+.+.+.+..+.+.+.+.+.+..+.+.+.+.+..+.+.+.+.+..+.+.|   
  5e+08 |-+                                                                 |   
        |                                                                   |   
        |                                                                   |   
  4e+08 |-+                                                                 |   
        |                                                                   |   
  3e+08 |-+                                                                 |   
        |                   O                O        O                     |   
  2e+08 |-O    O O O O O  O   O O O  O O O O   O  O O   O                   |   
        |                                                                   |   
        |                                                                   |   
  1e+08 |-+                                                                 |   
        |                                                                   |   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                 fio.latency_2ms_                               
                                                                                
  0.07 +--------------------------------------------------------------------+   
       |      :                                                             |   
  0.06 |-+    :                                                             |   
       |     : :                                                            |   
       |     : :                                                            |   
  0.05 |-+   : :                                                            |   
       |     : :                                                            |   
  0.04 |-+   : :                                                            |   
       |    :  :                                                            |   
  0.03 |-+  :   :                                                           |   
       |    :   :                                                           |   
       |    :   :              +                                            |   
  0.02 |-+ :    +.            + +       +..                    +            |   
       |   :      +.    .+. .+   +     +           .+.       .. + .+.       |   
  0.01 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                 fio.latency_4ms_                               
                                                                                
  2.2 +---------------------------------------------------------------------+   
      |                                                                     |   
    2 |-+                                                          +        |   
      |                                                            :        |   
  1.8 |-+                                                          :        |   
      |:                                +                         : :       |   
  1.6 |:+                        +      :                         : :       |   
      |:                         ::    : :                        : :       |   
  1.4 |:+                       : :    : :                        : :       |   
      |:         +..            :  :   : :                       :  :  +    |   
  1.2 |-:       +              :   +..:   :                      +   :: :   |   
      | :     .+    +.        .+      +   +    +        +.     ..    :: :   |   
    1 |-+.. .+        +.+.+..+             + .. + .+   +  +. .+      +   :  |   
      |    +                                +    +  + +     +            : .|   
  0.8 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                 fio.latency_10ms_                              
                                                                                
  99.2 +--------------------------------------------------------------------+   
       |  .+..                               +   +.. + :   .+..           : |   
    99 |-+            .+.+.+.+.             + + +   +  : .+    +     +   :  |   
       | :    +.+   +.         +     .+    +   +        +       +    :+  :  |   
  98.8 |-:       + +            :   + :    :                     +   : +:   |   
       |:         +             :   :  :  :                      :  :   +   |   
  98.6 |:+                       : :   :  :                       : :       |   
       |:                        : :   : :                        : :       |   
  98.4 |:+                        :    : :                        : :       |   
       |:                         +     :                         : :       |   
  98.2 |-+                              +                          :        |   
       |                                                           :        |   
    98 |-+                                                         +        |   
       |                                                                    |   
  97.8 +--------------------------------------------------------------------+   
                                                                                
                                                                                
[*] bisect-good sample
[O] bisect-bad  sample

***************************************************************************************************
lkp-csl-2ap1: 192 threads Intel(R) Xeon(R) CPU @ 2.20GHz with 192G memory
=========================================================================================
bs/compiler/cpufreq_governor/disk/fs/ioengine/kconfig/nr_task/rootfs/runtime/rw/tbox_group/test_size/testcase/ucode:
  4k/gcc-9/performance/1SSD/btrfs/libaio/x86_64-rhel-8.3/8t/debian-10.4-x86_64-20200603.cgz/300s/read/lkp-csl-2ap1/256g/fio-basic/0x4002f01

commit: 
  42d3e2d041 ("virtiofs: calculate number of scatter-gather elements accurately")
  51ac7c8929 ("fuse: fix panic in __readahead_batch()")

42d3e2d041f08d1f 51ac7c8929fb43cdb4d046674ba 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
           :4           25%           1:4     last_state.is_incomplete_run
           :4            9%           0:4     perf-profile.children.cycles-pp.error_entry
           :4            7%           0:4     perf-profile.self.cycles-pp.error_entry
         %stddev     %change         %stddev
             \          |                \  
      0.01            +0.0        0.05 ±  3%  fio.latency_1000us%
     58.70 ±  5%     -58.7        0.01        fio.latency_100us%
      0.17 ± 13%      +3.6        3.80 ±  6%  fio.latency_10ms%
      0.01            -0.0        0.00        fio.latency_10us%
      1.12 ±  7%      -1.1        0.01        fio.latency_20ms%
      0.01            -0.0        0.00        fio.latency_20us%
      2.33 ± 14%      -2.3        0.01        fio.latency_250us%
      0.04 ± 12%     +14.8       14.81        fio.latency_2ms%
      0.04 ± 13%     +81.3       81.33        fio.latency_4ms%
      0.24 ± 22%      -0.2        0.00 ±141%  fio.latency_50ms%
     37.36 ±  8%     -37.3        0.01        fio.latency_50us%
      3200           -88.5%     368.72        fio.read_bw_MBps
     80896         +4362.4%    3609941        fio.read_clat_90%_us
     93696 ±  2%   +4020.9%    3861162        fio.read_clat_95%_us
  14680064           -67.0%    4838741        fio.read_clat_99%_us
    301929          +770.3%    2627738        fio.read_clat_mean_us
   2015141           -64.4%     717417 ±  2%  fio.read_clat_stddev
    819420           -88.5%      94392        fio.read_iops
      9180          +812.2%      83738        fio.read_slat_mean_us
    364376           -86.2%      50323 ±  3%  fio.read_slat_stddev
     83.39          +261.4%     301.42        fio.time.elapsed_time
     83.39          +261.4%     301.42        fio.time.elapsed_time.max
 5.369e+08           -57.8%  2.265e+08        fio.time.file_system_inputs
      3316            +4.8%       3476        fio.time.minor_page_faults
    249.00           -61.2%      96.67 ±  2%  fio.time.percent_of_cpu_this_job_got
    145.62           +51.0%     219.95        fio.time.system_time
     62.43           +15.5%      72.14 ±  8%  fio.time.user_time
   1218403 ± 16%   +2226.8%   28349804        fio.time.voluntary_context_switches
  67108864           -57.8%   28317876        fio.workload
    423.34           +51.4%     641.05        uptime.boot
     78882           +50.1%     118375        uptime.idle
     93.62            +2.6%      96.06        iostat.cpu.idle
      2.78           -38.4%       1.71 ±  8%  iostat.cpu.iowait
      3.21 ± 11%     -34.3%       2.11 ±  4%  iostat.cpu.system
      2.85            -1.1        1.72 ±  8%  mpstat.cpu.all.iowait%
      1.52            -1.0        0.57 ± 11%  mpstat.cpu.all.sys%
      0.39 ±  2%      -0.3        0.12 ±  6%  mpstat.cpu.all.usr%
  79576247 ± 22%   +2523.4%  2.088e+09 ± 16%  cpuidle.C1.time
    714244 ± 18%   +9263.4%   66877393 ± 35%  cpuidle.C1.usage
 1.014e+10 ± 53%    +349.8%  4.561e+10 ± 22%  cpuidle.C1E.time
  26656420 ± 24%    +322.3%  1.126e+08 ± 20%  cpuidle.C1E.usage
   2610657 ± 13%   +2639.4%   71517281 ±  7%  cpuidle.POLL.time
   1010267 ± 16%   +1878.1%   19983681 ±  6%  cpuidle.POLL.usage
  51649617 ± 12%     -78.2%   11262444 ± 70%  numa-numastat.node0.numa_foreign
     37000 ± 62%    +592.3%     256154 ± 59%  numa-numastat.node1.local_node
     68152 ± 34%    +306.5%     277030 ± 50%  numa-numastat.node1.numa_hit
      6934 ±120%    -100.0%       0.00        numa-numastat.node2.numa_foreign
  18925794 ±  7%     -93.9%    1148305 ±105%  numa-numastat.node2.numa_miss
  18933735 ±  7%     -93.8%    1179422 ±102%  numa-numastat.node2.other_node
   7969324 ± 12%    -100.0%       0.00        numa-numastat.node3.numa_miss
   8000427 ± 12%     -99.7%      20828 ± 70%  numa-numastat.node3.other_node
     93.75            +2.0%      95.67        vmstat.cpu.id
   3094434           -88.0%     372197        vmstat.io.bi
    129.25 ± 52%     -79.4%      26.67 ± 10%  vmstat.io.bo
 1.076e+08 ±  2%     -48.1%   55885053 ±  6%  vmstat.memory.cache
  88011340 ±  2%     +59.0%  1.399e+08 ±  2%  vmstat.memory.free
      5.00           +40.0%       7.00        vmstat.procs.b
      4.75 ± 17%     -71.9%       1.33 ± 35%  vmstat.procs.r
     31489 ± 14%   +1063.1%     366252        vmstat.system.cs
    407197           +17.8%     479641        vmstat.system.in
      2304          +222.1%       7423        meminfo.Active(anon)
 1.064e+08 ±  2%     -47.8%   55524182 ±  6%  meminfo.Cached
 1.052e+08 ±  2%     -48.3%   54385240 ±  6%  meminfo.Inactive
 1.039e+08 ±  2%     -49.0%   53013478 ±  6%  meminfo.Inactive(file)
    406281           -40.5%     241822        meminfo.KReclaimable
  88873913 ±  2%     +57.6%    1.4e+08 ±  2%  meminfo.MemFree
 1.089e+08 ±  2%     -47.0%   57686822 ±  6%  meminfo.Memused
    406281           -40.5%     241822        meminfo.SReclaimable
    717879           -23.8%     547130        meminfo.Slab
   2114553 ±  2%     -83.7%     345069 ±  4%  meminfo.max_used_kB
     18816 ±  3%     -53.2%       8803 ±  9%  slabinfo.Acpi-State.active_objs
    377.00 ±  3%     -54.4%     172.00 ±  9%  slabinfo.Acpi-State.active_slabs
     19249 ±  3%     -54.3%       8803 ±  9%  slabinfo.Acpi-State.num_objs
    377.00 ±  3%     -54.4%     172.00 ±  9%  slabinfo.Acpi-State.num_slabs
      8288 ±  3%     -16.9%       6888 ± 15%  slabinfo.eventpoll_pwq.active_objs
      8288 ±  3%     -16.9%       6888 ± 15%  slabinfo.eventpoll_pwq.num_objs
      4011 ±  2%     -13.6%       3467 ±  3%  slabinfo.kmalloc-4k.active_objs
      4197 ±  2%     -15.7%       3540 ±  3%  slabinfo.kmalloc-4k.num_objs
     44684 ±  2%     -16.0%      37530        slabinfo.kmalloc-512.active_objs
    712.00           -14.9%     606.00        slabinfo.kmalloc-512.active_slabs
     45598           -14.9%      38808        slabinfo.kmalloc-512.num_objs
    712.00           -14.9%     606.00        slabinfo.kmalloc-512.num_slabs
     17780 ±  4%     +13.6%      20196 ±  6%  slabinfo.proc_inode_cache.num_objs
    556781           -54.0%     256000        slabinfo.radix_tree_node.active_objs
      9943           -54.0%       4573        slabinfo.radix_tree_node.active_slabs
    556829           -54.0%     256123        slabinfo.radix_tree_node.num_objs
      9943           -54.0%       4573        slabinfo.radix_tree_node.num_slabs
     20191           +30.1%      26270        slabinfo.vmap_area.active_objs
     20195           +30.1%      26272 ±  2%  slabinfo.vmap_area.num_objs
    955.25 ± 46%    +182.3%       2696 ± 24%  numa-meminfo.node0.Active(anon)
  42695581           -31.6%   29184934 ± 43%  numa-meminfo.node0.FilePages
  42312999           -32.2%   28706595 ± 43%  numa-meminfo.node0.Inactive
  41334368           -31.8%   28171371 ± 43%  numa-meminfo.node0.Inactive(file)
    154092 ± 13%     -30.6%     106908 ± 24%  numa-meminfo.node0.KReclaimable
   5624468          +240.8%   19170212 ± 66%  numa-meminfo.node0.MemFree
  43530395           -31.1%   29984645 ± 42%  numa-meminfo.node0.MemUsed
    154092 ± 13%     -30.6%     106908 ± 24%  numa-meminfo.node0.SReclaimable
  34486669 ±  2%     -63.3%   12648282 ± 69%  numa-meminfo.node1.FilePages
  34167203 ±  3%     -63.6%   12429699 ± 70%  numa-meminfo.node1.Inactive
  34135527 ±  3%     -64.8%   12026392 ± 70%  numa-meminfo.node1.Inactive(file)
    135129 ± 14%     -62.4%      50828 ± 49%  numa-meminfo.node1.KReclaimable
  14436720 ±  6%    +152.3%   36430755 ± 24%  numa-meminfo.node1.MemFree
  35097734 ±  2%     -62.7%   13103700 ± 67%  numa-meminfo.node1.MemUsed
    135129 ± 14%     -62.4%      50828 ± 49%  numa-meminfo.node1.SReclaimable
    211447 ±  7%     -48.3%     109334 ± 27%  numa-meminfo.node1.Slab
  22936883 ±  6%     -97.6%     554893 ± 59%  numa-meminfo.node2.FilePages
  22729009 ±  6%     -98.5%     336477 ± 94%  numa-meminfo.node2.Inactive
  22421108 ±  5%     -98.6%     308115 ±105%  numa-meminfo.node2.Inactive(file)
     84899 ±  6%     -75.5%      20768 ± 16%  numa-meminfo.node2.KReclaimable
  26051855 ±  5%     +86.4%   48559740        numa-meminfo.node2.MemFree
  23482603 ±  6%     -95.8%     974718 ± 33%  numa-meminfo.node2.MemUsed
     84899 ±  6%     -75.5%      20768 ± 16%  numa-meminfo.node2.SReclaimable
    144047 ±  7%     -46.8%      76576 ±  5%  numa-meminfo.node2.Slab
    506.00 ± 76%    +484.3%       2956 ± 34%  numa-meminfo.node3.Active
    308.50 ± 79%    +823.8%       2850 ± 40%  numa-meminfo.node3.Active(anon)
    239.00 ± 46%    +182.1%     674.33 ± 24%  numa-vmstat.node0.nr_active_anon
  10677173           -31.6%    7297895 ± 43%  numa-vmstat.node0.nr_file_pages
   1402804          +241.5%    4790942 ± 66%  numa-vmstat.node0.nr_free_pages
  10337166           -31.8%    7044815 ± 43%  numa-vmstat.node0.nr_inactive_file
     38551 ± 13%     -30.7%      26728 ± 24%  numa-vmstat.node0.nr_slab_reclaimable
    239.00 ± 46%    +182.1%     674.33 ± 24%  numa-vmstat.node0.nr_zone_active_anon
  10337197           -31.8%    7044815 ± 43%  numa-vmstat.node0.nr_zone_inactive_file
     27004 ±172%     -99.5%     134.67 ± 22%  numa-vmstat.node0.workingset_nodes
   8631606 ±  2%     -63.3%    3165798 ± 69%  numa-vmstat.node1.nr_file_pages
   3599208 ±  6%    +152.9%    9103979 ± 24%  numa-vmstat.node1.nr_free_pages
   8543810 ±  3%     -64.8%    3010436 ± 70%  numa-vmstat.node1.nr_inactive_file
     33905 ± 14%     -62.5%      12721 ± 49%  numa-vmstat.node1.nr_slab_reclaimable
   8543889 ±  3%     -64.8%    3010444 ± 70%  numa-vmstat.node1.nr_zone_inactive_file
   6307089 ±160%     -95.1%     308652 ± 63%  numa-vmstat.node2.nr_dirtied
   5755241 ±  6%     -97.6%     139337 ± 59%  numa-vmstat.node2.nr_file_pages
   6491911 ±  5%     +87.0%   12139348        numa-vmstat.node2.nr_free_pages
   5626290 ±  5%     -98.6%      77642 ±105%  numa-vmstat.node2.nr_inactive_file
     21367 ±  6%     -75.7%       5192 ± 16%  numa-vmstat.node2.nr_slab_reclaimable
   6307089 ±160%     -95.1%     308652 ± 63%  numa-vmstat.node2.nr_written
   5626330 ±  5%     -98.6%      77641 ±105%  numa-vmstat.node2.nr_zone_inactive_file
      1236 ±122%    -100.0%       0.00        numa-vmstat.node2.numa_foreign
  13242091 ± 73%     -97.1%     387847 ± 69%  numa-vmstat.node2.numa_miss
  13318951 ± 73%     -96.2%     503268 ± 53%  numa-vmstat.node2.numa_other
     16617 ± 15%    -100.0%       0.67 ±141%  numa-vmstat.node2.workingset_nodes
     77.25 ± 79%    +824.3%     714.00 ± 40%  numa-vmstat.node3.nr_active_anon
     77.25 ± 79%    +824.3%     714.00 ± 40%  numa-vmstat.node3.nr_zone_active_anon
   1421063 ± 12%    -100.0%       0.00        numa-vmstat.node3.numa_miss
   1535457 ± 11%     -93.2%     104892 ± 13%  numa-vmstat.node3.numa_other
    587.25 ± 17%     -70.7%     172.33 ± 31%  proc-vmstat.kswapd_high_wmark_hit_quickly
    189.00 ± 57%     -61.6%      72.67 ± 36%  proc-vmstat.kswapd_low_wmark_hit_quickly
    574.75          +222.4%       1853 ±  2%  proc-vmstat.nr_active_anon
     95024            -2.1%      92992        proc-vmstat.nr_active_file
     64654            -4.4%      61803        proc-vmstat.nr_anon_pages
    102.75            -2.4%     100.33        proc-vmstat.nr_anon_transparent_hugepages
  26515589 ±  2%     -47.7%   13868081 ±  6%  proc-vmstat.nr_file_pages
  22291428 ±  2%     +57.1%   35022812 ±  2%  proc-vmstat.nr_free_pages
  25892615 ±  2%     -48.9%   13239785 ±  6%  proc-vmstat.nr_inactive_file
    279788            +2.7%     287366        proc-vmstat.nr_mapped
      1423            -1.4%       1403        proc-vmstat.nr_page_table_pages
    277047            +2.4%     283816        proc-vmstat.nr_shmem
    101259           -40.3%      60422        proc-vmstat.nr_slab_reclaimable
    574.75          +222.4%       1853 ±  2%  proc-vmstat.nr_zone_active_anon
     95024            -2.1%      92992        proc-vmstat.nr_zone_active_file
  25892816 ±  2%     -48.9%   13239797 ±  6%  proc-vmstat.nr_zone_inactive_file
  51574349 ± 12%     -70.3%   15328324 ± 14%  proc-vmstat.numa_foreign
  51508815 ± 12%     -70.2%   15328324 ± 14%  proc-vmstat.numa_miss
  51602246 ± 12%     -70.1%   15421813 ± 14%  proc-vmstat.numa_other
     22178            +4.5%      23176        proc-vmstat.numa_pte_updates
      1922 ±  8%     +63.1%       3134 ±  6%  proc-vmstat.pgactivate
  67738855           -56.7%   29356597        proc-vmstat.pgalloc_normal
    894478           +90.5%    1703750        proc-vmstat.pgfault
  23926349 ±  2%     -81.2%    4487960 ± 25%  proc-vmstat.pgfree
 2.684e+08           -57.8%  1.132e+08        proc-vmstat.pgpgin
  23260386 ±  3%     -85.6%    3348393 ± 32%  proc-vmstat.pgscan_file
  23260386 ±  3%     -85.6%    3348393 ± 32%  proc-vmstat.pgscan_kswapd
  23260347 ±  3%     -85.6%    3348356 ± 32%  proc-vmstat.pgsteal_file
  23260347 ±  3%     -85.6%    3348356 ± 32%  proc-vmstat.pgsteal_kswapd
    108558 ±  8%     -87.1%      14026 ±100%  proc-vmstat.workingset_nodes
 2.228e+09           -43.6%  1.257e+09        perf-stat.i.branch-instructions
     52.39 ± 17%     -39.3       13.09 ±  8%  perf-stat.i.cache-miss-rate%
  88967995 ±  2%     -86.7%   11834283 ±  8%  perf-stat.i.cache-misses
 1.757e+08 ± 21%     -48.3%   90891895        perf-stat.i.cache-references
     32448 ± 14%   +1037.4%     369060        perf-stat.i.context-switches
      1.72 ±  4%     +45.6%       2.50 ±  4%  perf-stat.i.cpi
 1.908e+10 ±  3%     -20.9%   1.51e+10 ±  4%  perf-stat.i.cpu-cycles
    199.82            +5.3%     210.35        perf-stat.i.cpu-migrations
    290.64 ±  6%    +365.1%       1351 ± 15%  perf-stat.i.cycles-between-cache-misses
 3.489e+09           -52.0%  1.675e+09        perf-stat.i.dTLB-loads
 1.673e+09           -45.7%  9.091e+08        perf-stat.i.dTLB-stores
     62.14 ±  2%     -25.0       37.11 ±  3%  perf-stat.i.iTLB-load-miss-rate%
   6988491 ± 11%     +30.1%    9091627 ±  4%  perf-stat.i.iTLB-load-misses
   4253372 ± 13%    +263.1%   15442957        perf-stat.i.iTLB-loads
 1.152e+10           -47.8%  6.018e+09        perf-stat.i.instructions
      1669 ± 12%     -60.2%     665.22 ±  4%  perf-stat.i.instructions-per-iTLB-miss
      0.64 ±  4%     -36.3%       0.41 ±  4%  perf-stat.i.ipc
      3366           -72.4%     930.20        perf-stat.i.major-faults
      0.10 ±  3%     -20.8%       0.08 ±  4%  perf-stat.i.metric.GHz
      0.86 ± 24%     +84.5%       1.59 ± 16%  perf-stat.i.metric.K/sec
     39.57           -48.0%      20.57        perf-stat.i.metric.M/sec
      3728            -1.6%       3667        perf-stat.i.minor-faults
  19073403 ± 11%     -92.6%    1409993 ± 16%  perf-stat.i.node-load-misses
   6818393 ± 39%     -94.6%     367502 ± 85%  perf-stat.i.node-loads
    478621 ± 20%     -72.9%     129732 ±  7%  perf-stat.i.node-store-misses
    235691 ± 15%     -70.8%      68705 ± 17%  perf-stat.i.node-stores
      7094           -35.2%       4597        perf-stat.i.page-faults
     52.58 ± 17%     -39.6       13.02 ±  8%  perf-stat.overall.cache-miss-rate%
      1.66 ±  4%     +51.5%       2.51 ±  3%  perf-stat.overall.cpi
    214.63 ±  4%    +500.3%       1288 ± 11%  perf-stat.overall.cycles-between-cache-misses
     62.23 ±  2%     -25.2       37.04 ±  3%  perf-stat.overall.iTLB-load-miss-rate%
      1672 ± 12%     -60.3%     663.27 ±  4%  perf-stat.overall.instructions-per-iTLB-miss
      0.60 ±  3%     -34.0%       0.40 ±  4%  perf-stat.overall.ipc
     14304          +347.4%      63996        perf-stat.overall.path-length
 2.201e+09           -43.1%  1.253e+09        perf-stat.ps.branch-instructions
  87891271 ±  2%     -86.6%   11794944 ±  8%  perf-stat.ps.cache-misses
 1.736e+08 ± 21%     -47.8%   90586273        perf-stat.ps.cache-references
     32059 ± 14%   +1047.3%     367810        perf-stat.ps.context-switches
 1.885e+10 ±  3%     -20.2%  1.505e+10 ±  4%  perf-stat.ps.cpu-cycles
    197.43            +6.2%     209.65        perf-stat.ps.cpu-migrations
 3.447e+09           -51.6%  1.669e+09        perf-stat.ps.dTLB-loads
 1.652e+09           -45.2%   9.06e+08        perf-stat.ps.dTLB-stores
   6904469 ± 11%     +31.2%    9061078 ±  4%  perf-stat.ps.iTLB-load-misses
   4202379 ± 13%    +266.2%   15390849        perf-stat.ps.iTLB-loads
 1.138e+10           -47.3%  5.998e+09        perf-stat.ps.instructions
      3337           -72.1%     932.14        perf-stat.ps.major-faults
  18839707 ± 11%     -92.5%    1405326 ± 15%  perf-stat.ps.node-load-misses
   6738529 ± 39%     -94.6%     366286 ± 85%  perf-stat.ps.node-loads
    472853 ± 20%     -72.6%     129330 ±  7%  perf-stat.ps.node-store-misses
    232927 ± 15%     -70.6%      68495 ± 17%  perf-stat.ps.node-stores
      7021           -34.7%       4588        perf-stat.ps.page-faults
   9.6e+11           +88.8%  1.812e+12        perf-stat.total.instructions
    442.80 ± 57%    +466.9%       2510 ± 33%  sched_debug.cfs_rq:/.exec_clock.avg
     34.54 ± 81%    +278.6%     130.76 ±  5%  sched_debug.cfs_rq:/.exec_clock.min
      1175 ± 57%    +117.7%       2559 ± 17%  sched_debug.cfs_rq:/.exec_clock.stddev
    965.25 ± 23%     -29.0%     685.49 ±  2%  sched_debug.cfs_rq:/.load_avg.max
     78004 ± 11%     +22.8%      95818 ±  6%  sched_debug.cfs_rq:/.min_vruntime.avg
      0.00 ± 99%  +33068.6%       0.43 ±127%  sched_debug.cfs_rq:/.nr_spread_over.avg
      0.25 ±100%    +735.6%       2.09 ± 42%  sched_debug.cfs_rq:/.nr_spread_over.max
      0.02 ±100%   +1664.8%       0.32 ± 49%  sched_debug.cfs_rq:/.nr_spread_over.stddev
    194.49 ± 31%     -60.9%      76.12 ± 15%  sched_debug.cfs_rq:/.runnable_avg.avg
      1037 ± 16%     -36.0%     663.72 ±  4%  sched_debug.cfs_rq:/.runnable_avg.max
    216.31 ± 24%     -45.0%     118.96 ±  3%  sched_debug.cfs_rq:/.runnable_avg.stddev
    193.79 ± 31%     -60.8%      75.89 ± 15%  sched_debug.cfs_rq:/.util_avg.avg
      1037 ± 16%     -36.1%     663.06 ±  4%  sched_debug.cfs_rq:/.util_avg.max
    216.16 ± 24%     -45.0%     118.85 ±  4%  sched_debug.cfs_rq:/.util_avg.stddev
     18.45 ± 33%     -67.0%       6.09 ± 17%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    387.00 ± 19%     -52.9%     182.42 ±  2%  sched_debug.cfs_rq:/.util_est_enqueued.max
     72.77 ± 24%     -59.5%      29.46 ±  8%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    207466 ± 17%     +25.1%     259443        sched_debug.cpu.avg_idle.stddev
    361629 ±  5%     +32.4%     478921 ±  3%  sched_debug.cpu.clock.avg
    361639 ±  5%     +32.4%     478931 ±  3%  sched_debug.cpu.clock.max
    361618 ±  5%     +32.4%     478913 ±  3%  sched_debug.cpu.clock.min
    360969 ±  4%     +32.0%     476491 ±  3%  sched_debug.cpu.clock_task.avg
    361408 ±  4%     +32.2%     477918 ±  3%  sched_debug.cpu.clock_task.max
    352788 ±  5%     +32.8%     468568 ±  3%  sched_debug.cpu.clock_task.min
    860.44 ±  6%     +16.3%       1000 ±  7%  sched_debug.cpu.clock_task.stddev
      4363 ± 10%     +86.2%       8126 ±  5%  sched_debug.cpu.curr->pid.max
      0.00 ± 16%     -28.0%       0.00 ±  8%  sched_debug.cpu.next_balance.stddev
      0.05 ± 24%     -52.1%       0.02 ±  9%  sched_debug.cpu.nr_running.avg
      0.21 ± 12%     -32.7%       0.14 ±  3%  sched_debug.cpu.nr_running.stddev
     23908 ± 13%   +1103.1%     287640 ±  9%  sched_debug.cpu.nr_switches.avg
    615990 ± 15%    +327.8%    2634930 ±  8%  sched_debug.cpu.nr_switches.max
    735.00 ± 19%     +80.2%       1324 ± 16%  sched_debug.cpu.nr_switches.min
     80678 ± 12%    +628.9%     588062 ±  8%  sched_debug.cpu.nr_switches.stddev
      0.02 ± 32%     +89.6%       0.03 ±  2%  sched_debug.cpu.nr_uninterruptible.avg
    -15.88           +52.9%     -24.28        sched_debug.cpu.nr_uninterruptible.min
      3707 ± 59%   +7130.8%     268047 ± 10%  sched_debug.cpu.sched_count.avg
     94244 ± 60%   +2251.7%    2216322 ±  8%  sched_debug.cpu.sched_count.max
     88.62 ± 57%    +485.7%     519.06 ± 10%  sched_debug.cpu.sched_count.min
     14819 ± 61%   +3619.1%     551153 ± 12%  sched_debug.cpu.sched_count.stddev
      1839 ± 59%   +7182.9%     133939 ± 10%  sched_debug.cpu.sched_goidle.avg
     47095 ± 60%   +2252.5%    1107918 ±  8%  sched_debug.cpu.sched_goidle.max
     33.25 ± 57%    +470.4%     189.64 ± 10%  sched_debug.cpu.sched_goidle.min
      7407 ± 61%   +3619.7%     275546 ± 12%  sched_debug.cpu.sched_goidle.stddev
      1835 ± 59%   +7196.5%     133937 ± 10%  sched_debug.cpu.ttwu_count.avg
     46170 ± 62%   +3699.1%    1754076 ± 13%  sched_debug.cpu.ttwu_count.max
     30.50 ± 57%    +497.9%     182.37 ±  9%  sched_debug.cpu.ttwu_count.min
      7305 ± 63%   +4865.9%     362794 ± 13%  sched_debug.cpu.ttwu_count.stddev
     81.61 ± 57%   +2521.5%       2139 ± 19%  sched_debug.cpu.ttwu_local.avg
      3110 ± 61%   +1468.5%      48787 ± 15%  sched_debug.cpu.ttwu_local.max
     29.75 ± 57%    +506.6%     180.47 ± 10%  sched_debug.cpu.ttwu_local.min
    246.63 ± 59%   +2728.7%       6976 ± 20%  sched_debug.cpu.ttwu_local.stddev
    361621 ±  5%     +32.4%     478914 ±  3%  sched_debug.cpu_clk
    360748 ±  5%     +32.5%     478040 ±  3%  sched_debug.ktime
    361974 ±  5%     +32.4%     479296 ±  3%  sched_debug.sched_clk
     61.25 ±  5%   +2930.2%       1856 ± 62%  interrupts.33:PCI-MSI.524291-edge.eth0-TxRx-2
    171.00          +254.8%     606.67        interrupts.9:IO-APIC.9-fasteoi.acpi
    476084 ± 12%     +35.9%     646984 ±  2%  interrupts.CAL:Function_call_interrupts
    171601          +253.0%     605811        interrupts.CPU0.LOC:Local_timer_interrupts
      0.00       +1.7e+104%     168.33 ± 20%  interrupts.CPU0.NMI:Non-maskable_interrupts
      0.00       +1.7e+104%     168.33 ± 20%  interrupts.CPU0.PMI:Performance_monitoring_interrupts
    171.00          +254.8%     606.67        interrupts.CPU1.9:IO-APIC.9-fasteoi.acpi
    170366          +255.6%     605898        interrupts.CPU1.LOC:Local_timer_interrupts
      3.00 ± 84%  +12733.3%     385.00 ±106%  interrupts.CPU1.NMI:Non-maskable_interrupts
      3.00 ± 84%  +12733.3%     385.00 ±106%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
    169967          +260.7%     613047        interrupts.CPU10.LOC:Local_timer_interrupts
      0.00       +3.3e+104%     332.00 ± 53%  interrupts.CPU10.NMI:Non-maskable_interrupts
      0.00       +3.3e+104%     332.00 ± 53%  interrupts.CPU10.PMI:Performance_monitoring_interrupts
    169883          +256.7%     605918        interrupts.CPU100.LOC:Local_timer_interrupts
      0.00       +4.3e+104%     426.33 ± 52%  interrupts.CPU100.NMI:Non-maskable_interrupts
      0.00       +4.3e+104%     426.33 ± 52%  interrupts.CPU100.PMI:Performance_monitoring_interrupts
      6136 ±148%    +231.1%      20320 ± 65%  interrupts.CPU101.CAL:Function_call_interrupts
    169887          +256.6%     605834        interrupts.CPU101.LOC:Local_timer_interrupts
      0.00       +7.2e+104%     724.33 ± 66%  interrupts.CPU101.NMI:Non-maskable_interrupts
      0.00       +7.2e+104%     724.33 ± 66%  interrupts.CPU101.PMI:Performance_monitoring_interrupts
    169916          +256.5%     605798        interrupts.CPU102.LOC:Local_timer_interrupts
      0.00       +7.8e+104%     778.00 ± 69%  interrupts.CPU102.NMI:Non-maskable_interrupts
      0.00       +7.8e+104%     778.00 ± 69%  interrupts.CPU102.PMI:Performance_monitoring_interrupts
    169905          +256.6%     605839        interrupts.CPU103.LOC:Local_timer_interrupts
    169893          +256.6%     605807        interrupts.CPU104.LOC:Local_timer_interrupts
    169995          +256.4%     605820        interrupts.CPU105.LOC:Local_timer_interrupts
    170006          +258.1%     608713        interrupts.CPU106.LOC:Local_timer_interrupts
      0.00       +6.7e+104%     669.00 ± 61%  interrupts.CPU106.NMI:Non-maskable_interrupts
      0.00       +6.7e+104%     669.00 ± 61%  interrupts.CPU106.PMI:Performance_monitoring_interrupts
    169911          +256.8%     606194        interrupts.CPU107.LOC:Local_timer_interrupts
    169894          +257.0%     606509        interrupts.CPU108.LOC:Local_timer_interrupts
    169902          +257.1%     606803        interrupts.CPU109.LOC:Local_timer_interrupts
    169905          +257.6%     607589        interrupts.CPU11.LOC:Local_timer_interrupts
    169912          +256.8%     606204        interrupts.CPU110.LOC:Local_timer_interrupts
    169896          +256.9%     606390        interrupts.CPU111.LOC:Local_timer_interrupts
      0.00       +6.6e+104%     662.00 ± 66%  interrupts.CPU111.NMI:Non-maskable_interrupts
      0.00       +6.6e+104%     662.00 ± 66%  interrupts.CPU111.PMI:Performance_monitoring_interrupts
    169896          +256.6%     605888        interrupts.CPU112.LOC:Local_timer_interrupts
    169896          +256.7%     606101        interrupts.CPU113.LOC:Local_timer_interrupts
      0.00       +3.6e+104%     359.00 ± 53%  interrupts.CPU113.NMI:Non-maskable_interrupts
      0.00       +3.6e+104%     359.00 ± 53%  interrupts.CPU113.PMI:Performance_monitoring_interrupts
    169972          +256.7%     606223        interrupts.CPU114.LOC:Local_timer_interrupts
    169960          +256.6%     606079        interrupts.CPU115.LOC:Local_timer_interrupts
      0.00       +9.4e+104%     937.33 ± 61%  interrupts.CPU115.NMI:Non-maskable_interrupts
      0.00       +9.4e+104%     937.33 ± 61%  interrupts.CPU115.PMI:Performance_monitoring_interrupts
    169910          +256.6%     605952        interrupts.CPU116.LOC:Local_timer_interrupts
    169908          +257.0%     606576        interrupts.CPU117.LOC:Local_timer_interrupts
    169892          +256.6%     605867        interrupts.CPU118.LOC:Local_timer_interrupts
      0.00         +2e+104%     201.00 ± 46%  interrupts.CPU118.NMI:Non-maskable_interrupts
      0.00         +2e+104%     201.00 ± 46%  interrupts.CPU118.PMI:Performance_monitoring_interrupts
    169808          +256.8%     605837        interrupts.CPU119.LOC:Local_timer_interrupts
     61.25 ±  5%   +2930.2%       1856 ± 62%  interrupts.CPU12.33:PCI-MSI.524291-edge.eth0-TxRx-2
    169920          +256.6%     605886        interrupts.CPU12.LOC:Local_timer_interrupts
      0.25 ±173%  +1.6e+05%     406.00 ± 77%  interrupts.CPU12.NMI:Non-maskable_interrupts
      0.25 ±173%  +1.6e+05%     406.00 ± 77%  interrupts.CPU12.PMI:Performance_monitoring_interrupts
    169834          +256.4%     605225        interrupts.CPU120.LOC:Local_timer_interrupts
      0.00       +1.2e+104%     122.00 ±  8%  interrupts.CPU120.NMI:Non-maskable_interrupts
      0.00       +1.2e+104%     122.00 ±  8%  interrupts.CPU120.PMI:Performance_monitoring_interrupts
    169740          +256.7%     605502        interrupts.CPU121.LOC:Local_timer_interrupts
      0.00       +1.2e+104%     118.67 ±  8%  interrupts.CPU121.NMI:Non-maskable_interrupts
      0.00       +1.2e+104%     118.67 ±  8%  interrupts.CPU121.PMI:Performance_monitoring_interrupts
    169861          +256.4%     605373        interrupts.CPU122.LOC:Local_timer_interrupts
    169845          +256.1%     604895        interrupts.CPU123.LOC:Local_timer_interrupts
    169841          +256.4%     605291        interrupts.CPU124.LOC:Local_timer_interrupts
    169851          +256.4%     605311        interrupts.CPU125.LOC:Local_timer_interrupts
      0.00       +1.2e+104%     119.00 ±  7%  interrupts.CPU125.NMI:Non-maskable_interrupts
      0.00       +1.2e+104%     119.00 ±  7%  interrupts.CPU125.PMI:Performance_monitoring_interrupts
    169866          +256.4%     605348        interrupts.CPU126.LOC:Local_timer_interrupts
      0.00       +1.2e+104%     119.00 ±  8%  interrupts.CPU126.NMI:Non-maskable_interrupts
      0.00       +1.2e+104%     119.00 ±  8%  interrupts.CPU126.PMI:Performance_monitoring_interrupts
    169838          +256.5%     605518        interrupts.CPU127.LOC:Local_timer_interrupts
      0.00       +1.2e+104%     118.67 ±  7%  interrupts.CPU127.NMI:Non-maskable_interrupts
      0.00       +1.2e+104%     118.67 ±  7%  interrupts.CPU127.PMI:Performance_monitoring_interrupts
    169833          +256.5%     605511        interrupts.CPU128.LOC:Local_timer_interrupts
      0.00       +1.3e+104%     128.33 ±  7%  interrupts.CPU128.NMI:Non-maskable_interrupts
      0.00       +1.3e+104%     128.33 ±  7%  interrupts.CPU128.PMI:Performance_monitoring_interrupts
    169852          +256.5%     605453        interrupts.CPU129.LOC:Local_timer_interrupts
      0.00       +1.2e+104%     118.00 ±  7%  interrupts.CPU129.NMI:Non-maskable_interrupts
      0.00       +1.2e+104%     118.00 ±  7%  interrupts.CPU129.PMI:Performance_monitoring_interrupts
    171039          +254.2%     605802        interrupts.CPU13.LOC:Local_timer_interrupts
      0.50 ±173%  +1.5e+05%     741.00 ± 79%  interrupts.CPU13.NMI:Non-maskable_interrupts
      0.50 ±173%  +1.5e+05%     741.00 ± 79%  interrupts.CPU13.PMI:Performance_monitoring_interrupts
    169834          +256.5%     605488        interrupts.CPU130.LOC:Local_timer_interrupts
      0.00       +1.2e+104%     118.33 ±  8%  interrupts.CPU130.NMI:Non-maskable_interrupts
      0.00       +1.2e+104%     118.33 ±  8%  interrupts.CPU130.PMI:Performance_monitoring_interrupts
    169836          +256.5%     605531        interrupts.CPU131.LOC:Local_timer_interrupts
    169862          +256.5%     605590        interrupts.CPU132.LOC:Local_timer_interrupts
    169878          +256.5%     605570        interrupts.CPU133.LOC:Local_timer_interrupts
    169866          +256.4%     605431        interrupts.CPU134.LOC:Local_timer_interrupts
    169838          +256.5%     605505        interrupts.CPU135.LOC:Local_timer_interrupts
      0.25 ±173%  +51366.7%     128.67 ±  6%  interrupts.CPU135.NMI:Non-maskable_interrupts
      0.25 ±173%  +51366.7%     128.67 ±  6%  interrupts.CPU135.PMI:Performance_monitoring_interrupts
    169839          +255.9%     604411        interrupts.CPU136.LOC:Local_timer_interrupts
      0.00       +1.2e+104%     117.00 ±  7%  interrupts.CPU136.NMI:Non-maskable_interrupts
      0.00       +1.2e+104%     117.00 ±  7%  interrupts.CPU136.PMI:Performance_monitoring_interrupts
    169838          +256.5%     605472        interrupts.CPU137.LOC:Local_timer_interrupts
    174.00 ± 11%     -10.5%     155.67 ±  9%  interrupts.CPU137.TLB:TLB_shootdowns
    169838          +256.4%     605348        interrupts.CPU138.LOC:Local_timer_interrupts
    169857          +256.3%     605242        interrupts.CPU139.LOC:Local_timer_interrupts
    169846          +256.7%     605827        interrupts.CPU14.LOC:Local_timer_interrupts
     34.00 ±163%   +5757.8%       1991 ± 70%  interrupts.CPU14.RES:Rescheduling_interrupts
    169837          +256.4%     605357        interrupts.CPU140.LOC:Local_timer_interrupts
    169837          +256.3%     605199        interrupts.CPU141.LOC:Local_timer_interrupts
    169837          +256.4%     605373        interrupts.CPU142.LOC:Local_timer_interrupts
      0.00       +1.2e+104%     117.67 ±  7%  interrupts.CPU142.NMI:Non-maskable_interrupts
      0.00       +1.2e+104%     117.67 ±  7%  interrupts.CPU142.PMI:Performance_monitoring_interrupts
    169836          +256.4%     605343        interrupts.CPU143.LOC:Local_timer_interrupts
      0.00       +1.2e+104%     117.67 ±  7%  interrupts.CPU143.NMI:Non-maskable_interrupts
      0.00       +1.2e+104%     117.67 ±  7%  interrupts.CPU143.PMI:Performance_monitoring_interrupts
    169870          +256.2%     605028        interrupts.CPU144.LOC:Local_timer_interrupts
    169868          +256.4%     605374        interrupts.CPU145.LOC:Local_timer_interrupts
    169844          +256.4%     605392        interrupts.CPU146.LOC:Local_timer_interrupts
    169875          +256.3%     605260        interrupts.CPU147.LOC:Local_timer_interrupts
    169848          +256.4%     605282        interrupts.CPU148.LOC:Local_timer_interrupts
      1.50 ±173%   +8077.8%     122.67 ±  8%  interrupts.CPU148.NMI:Non-maskable_interrupts
      1.50 ±173%   +8077.8%     122.67 ±  8%  interrupts.CPU148.PMI:Performance_monitoring_interrupts
    169846          +256.4%     605331        interrupts.CPU149.LOC:Local_timer_interrupts
      1.50 ±173%   +8188.9%     124.33 ±  5%  interrupts.CPU149.NMI:Non-maskable_interrupts
      1.50 ±173%   +8188.9%     124.33 ±  5%  interrupts.CPU149.PMI:Performance_monitoring_interrupts
    169918          +257.8%     608044        interrupts.CPU15.LOC:Local_timer_interrupts
      0.25 ±173%  +2.4e+05%     610.33 ± 62%  interrupts.CPU15.NMI:Non-maskable_interrupts
      0.25 ±173%  +2.4e+05%     610.33 ± 62%  interrupts.CPU15.PMI:Performance_monitoring_interrupts
    169848          +256.4%     605335        interrupts.CPU150.LOC:Local_timer_interrupts
    168.50 ± 64%     -54.1%      77.33 ± 24%  interrupts.CPU150.TLB:TLB_shootdowns
    169847          +256.4%     605415        interrupts.CPU151.LOC:Local_timer_interrupts
    169840          +256.4%     605365        interrupts.CPU152.LOC:Local_timer_interrupts
    169862          +256.4%     605457        interrupts.CPU153.LOC:Local_timer_interrupts
    169855          +256.3%     605225        interrupts.CPU154.LOC:Local_timer_interrupts
    169835          +256.3%     605164        interrupts.CPU155.LOC:Local_timer_interrupts
      0.00       +9.6e+103%      95.67 ± 25%  interrupts.CPU155.NMI:Non-maskable_interrupts
      0.00       +9.6e+103%      95.67 ± 25%  interrupts.CPU155.PMI:Performance_monitoring_interrupts
    188.25 ± 54%     -53.4%      87.67 ± 16%  interrupts.CPU155.TLB:TLB_shootdowns
    169843          +256.4%     605345        interrupts.CPU156.LOC:Local_timer_interrupts
    169838          +256.4%     605380        interrupts.CPU157.LOC:Local_timer_interrupts
    169839          +256.4%     605374        interrupts.CPU158.LOC:Local_timer_interrupts
    169843          +256.4%     605310        interrupts.CPU159.LOC:Local_timer_interrupts
    839.50 ±  3%    +644.7%       6251 ± 42%  interrupts.CPU16.CAL:Function_call_interrupts
    169928          +256.5%     605859        interrupts.CPU16.LOC:Local_timer_interrupts
      0.25 ±173%    +3e+05%     754.00 ±115%  interrupts.CPU16.NMI:Non-maskable_interrupts
      0.25 ±173%    +3e+05%     754.00 ±115%  interrupts.CPU16.PMI:Performance_monitoring_interrupts
      0.75 ±110%  +7.2e+05%       5427 ± 78%  interrupts.CPU16.RES:Rescheduling_interrupts
    169841          +256.4%     605349        interrupts.CPU160.LOC:Local_timer_interrupts
    169832          +256.4%     605310        interrupts.CPU161.LOC:Local_timer_interrupts
    169842          +256.3%     605130        interrupts.CPU162.LOC:Local_timer_interrupts
    169847          +256.3%     605164        interrupts.CPU163.LOC:Local_timer_interrupts
    169866          +256.3%     605225        interrupts.CPU164.LOC:Local_timer_interrupts
      0.50 ±173%  +15300.0%      77.00 ± 37%  interrupts.CPU164.NMI:Non-maskable_interrupts
      0.50 ±173%  +15300.0%      77.00 ± 37%  interrupts.CPU164.PMI:Performance_monitoring_interrupts
    169842          +256.3%     605193        interrupts.CPU165.LOC:Local_timer_interrupts
    169834          +256.4%     605264        interrupts.CPU166.LOC:Local_timer_interrupts
    169841          +256.4%     605275        interrupts.CPU167.LOC:Local_timer_interrupts
      0.25 ±173%  +38433.3%      96.33 ± 23%  interrupts.CPU167.NMI:Non-maskable_interrupts
      0.25 ±173%  +38433.3%      96.33 ± 23%  interrupts.CPU167.PMI:Performance_monitoring_interrupts
    183.00 ± 61%     -68.9%      57.00 ± 71%  interrupts.CPU167.TLB:TLB_shootdowns
    169879          +255.9%     604617        interrupts.CPU168.LOC:Local_timer_interrupts
    169843          +256.3%     605134        interrupts.CPU169.LOC:Local_timer_interrupts
    170692          +254.9%     605864        interrupts.CPU17.LOC:Local_timer_interrupts
      0.25 ±173%  +1.5e+05%     368.00 ± 55%  interrupts.CPU17.NMI:Non-maskable_interrupts
      0.25 ±173%  +1.5e+05%     368.00 ± 55%  interrupts.CPU17.PMI:Performance_monitoring_interrupts
    598.25 ± 26%   +1525.5%       9724 ±128%  interrupts.CPU170.CAL:Function_call_interrupts
    169887          +255.2%     603367        interrupts.CPU170.LOC:Local_timer_interrupts
      0.75 ± 57%  +1.4e+06%      10361 ±141%  interrupts.CPU170.RES:Rescheduling_interrupts
    169862          +255.4%     603718        interrupts.CPU171.LOC:Local_timer_interrupts
    169839          +256.0%     604603        interrupts.CPU172.LOC:Local_timer_interrupts
    169839          +256.0%     604583        interrupts.CPU173.LOC:Local_timer_interrupts
      0.25 ±173%  +1.2e+05%     293.00 ± 79%  interrupts.CPU173.NMI:Non-maskable_interrupts
      0.25 ±173%  +1.2e+05%     293.00 ± 79%  interrupts.CPU173.PMI:Performance_monitoring_interrupts
    169859          +255.6%     604026        interrupts.CPU174.LOC:Local_timer_interrupts
    169765          +256.6%     605313        interrupts.CPU175.LOC:Local_timer_interrupts
    169842          +256.4%     605345        interrupts.CPU176.LOC:Local_timer_interrupts
    169858          +256.7%     605912        interrupts.CPU177.LOC:Local_timer_interrupts
    169827          +256.3%     605063        interrupts.CPU178.LOC:Local_timer_interrupts
      0.00         +1e+106%      10371 ±141%  interrupts.CPU178.RES:Rescheduling_interrupts
    169843          +257.1%     606478        interrupts.CPU179.LOC:Local_timer_interrupts
      1036 ± 25%    +242.1%       3544 ± 35%  interrupts.CPU18.CAL:Function_call_interrupts
    170165          +256.0%     605816        interrupts.CPU18.LOC:Local_timer_interrupts
      0.25 ±173%  +2.8e+05%     694.00 ± 72%  interrupts.CPU18.NMI:Non-maskable_interrupts
      0.25 ±173%  +2.8e+05%     694.00 ± 72%  interrupts.CPU18.PMI:Performance_monitoring_interrupts
    169833          +256.8%     605912        interrupts.CPU180.LOC:Local_timer_interrupts
    169831          +255.7%     604062        interrupts.CPU181.LOC:Local_timer_interrupts
      0.25 ±173%  +55100.0%     138.00 ± 49%  interrupts.CPU181.NMI:Non-maskable_interrupts
      0.25 ±173%  +55100.0%     138.00 ± 49%  interrupts.CPU181.PMI:Performance_monitoring_interrupts
      0.75 ± 57%  +9.9e+05%       7415 ±141%  interrupts.CPU181.RES:Rescheduling_interrupts
    169825          +255.4%     603619        interrupts.CPU182.LOC:Local_timer_interrupts
    169828          +255.2%     603179        interrupts.CPU183.LOC:Local_timer_interrupts
    169825          +254.8%     602509        interrupts.CPU184.LOC:Local_timer_interrupts
      0.25 ±173%    +3e+06%       7499 ±141%  interrupts.CPU184.RES:Rescheduling_interrupts
    169830          +254.5%     602126        interrupts.CPU185.LOC:Local_timer_interrupts
    169846          +255.4%     603578        interrupts.CPU186.LOC:Local_timer_interrupts
    169827          +254.9%     602798        interrupts.CPU187.LOC:Local_timer_interrupts
      0.50 ±173%  +1.8e+06%       8824 ±141%  interrupts.CPU187.RES:Rescheduling_interrupts
    169826          +254.9%     602778        interrupts.CPU188.LOC:Local_timer_interrupts
    169786          +255.6%     603687        interrupts.CPU189.LOC:Local_timer_interrupts
    170000          +256.3%     605704        interrupts.CPU19.LOC:Local_timer_interrupts
      0.25 ±173%    +4e+05%       1009 ± 62%  interrupts.CPU19.NMI:Non-maskable_interrupts
      0.25 ±173%    +4e+05%       1009 ± 62%  interrupts.CPU19.PMI:Performance_monitoring_interrupts
      1.50 ± 74%  +3.1e+05%       4654 ± 71%  interrupts.CPU19.RES:Rescheduling_interrupts
    169826          +255.3%     603453        interrupts.CPU190.LOC:Local_timer_interrupts
    169882          +255.8%     604379        interrupts.CPU191.LOC:Local_timer_interrupts
      1.50 ± 33%  +18166.7%     274.00 ± 73%  interrupts.CPU191.NMI:Non-maskable_interrupts
      1.50 ± 33%  +18166.7%     274.00 ± 73%  interrupts.CPU191.PMI:Performance_monitoring_interrupts
    170152          +256.1%     605883        interrupts.CPU2.LOC:Local_timer_interrupts
      1.75 ±109%  +18166.7%     319.67 ± 98%  interrupts.CPU2.NMI:Non-maskable_interrupts
      1.75 ±109%  +18166.7%     319.67 ± 98%  interrupts.CPU2.PMI:Performance_monitoring_interrupts
    170236          +255.9%     605827        interrupts.CPU20.LOC:Local_timer_interrupts
      0.25 ±173%  +1.9e+05%     483.33 ± 87%  interrupts.CPU20.NMI:Non-maskable_interrupts
      0.25 ±173%  +1.9e+05%     483.33 ± 87%  interrupts.CPU20.PMI:Performance_monitoring_interrupts
      3.25 ± 88%  +74289.7%       2417 ± 81%  interrupts.CPU20.RES:Rescheduling_interrupts
    169933          +256.7%     606165        interrupts.CPU21.LOC:Local_timer_interrupts
    170367          +255.6%     605874        interrupts.CPU22.LOC:Local_timer_interrupts
      1.25 ±173%  +16993.3%     213.67 ± 56%  interrupts.CPU22.NMI:Non-maskable_interrupts
      1.25 ±173%  +16993.3%     213.67 ± 56%  interrupts.CPU22.PMI:Performance_monitoring_interrupts
      1.75 ± 74%    +2e+05%       3525 ± 82%  interrupts.CPU22.RES:Rescheduling_interrupts
    169908          +256.6%     605873        interrupts.CPU23.LOC:Local_timer_interrupts
      0.00       +1.6e+104%     161.00 ± 24%  interrupts.CPU23.NMI:Non-maskable_interrupts
      0.00       +1.6e+104%     161.00 ± 24%  interrupts.CPU23.PMI:Performance_monitoring_interrupts
    169908          +256.3%     605309        interrupts.CPU24.LOC:Local_timer_interrupts
    169920          +256.4%     605584        interrupts.CPU25.LOC:Local_timer_interrupts
    169898          +256.4%     605483        interrupts.CPU26.LOC:Local_timer_interrupts
      0.00       +1.2e+104%     118.33 ±  8%  interrupts.CPU26.NMI:Non-maskable_interrupts
      0.00       +1.2e+104%     118.33 ±  8%  interrupts.CPU26.PMI:Performance_monitoring_interrupts
    169915          +256.0%     604909        interrupts.CPU27.LOC:Local_timer_interrupts
      0.00       +1.3e+104%     133.00 ± 18%  interrupts.CPU27.NMI:Non-maskable_interrupts
      0.00       +1.3e+104%     133.00 ± 18%  interrupts.CPU27.PMI:Performance_monitoring_interrupts
    169900          +256.3%     605368        interrupts.CPU28.LOC:Local_timer_interrupts
    169887          +256.3%     605306        interrupts.CPU29.LOC:Local_timer_interrupts
    169936          +256.5%     605840        interrupts.CPU3.LOC:Local_timer_interrupts
      0.00       +8.3e+104%     831.67 ± 62%  interrupts.CPU3.NMI:Non-maskable_interrupts
      0.00       +8.3e+104%     831.67 ± 62%  interrupts.CPU3.PMI:Performance_monitoring_interrupts
    169894          +256.3%     605413        interrupts.CPU30.LOC:Local_timer_interrupts
      0.25 ±173%  +47366.7%     118.67 ±  8%  interrupts.CPU30.NMI:Non-maskable_interrupts
      0.25 ±173%  +47366.7%     118.67 ±  8%  interrupts.CPU30.PMI:Performance_monitoring_interrupts
    169879          +256.5%     605569        interrupts.CPU31.LOC:Local_timer_interrupts
    169877          +256.4%     605479        interrupts.CPU32.LOC:Local_timer_interrupts
    169875          +256.4%     605470        interrupts.CPU33.LOC:Local_timer_interrupts
    169882          +256.4%     605520        interrupts.CPU34.LOC:Local_timer_interrupts
    169871          +256.5%     605549        interrupts.CPU35.LOC:Local_timer_interrupts
    169860          +256.5%     605531        interrupts.CPU36.LOC:Local_timer_interrupts
    169855          +256.5%     605522        interrupts.CPU37.LOC:Local_timer_interrupts
    169854          +256.5%     605474        interrupts.CPU38.LOC:Local_timer_interrupts
      0.25 ±173%  +47633.3%     119.33 ±  6%  interrupts.CPU38.NMI:Non-maskable_interrupts
      0.25 ±173%  +47633.3%     119.33 ±  6%  interrupts.CPU38.PMI:Performance_monitoring_interrupts
    169875          +256.4%     605484        interrupts.CPU39.LOC:Local_timer_interrupts
     74.25 ± 21%     +96.6%     146.00 ± 19%  interrupts.CPU39.TLB:TLB_shootdowns
    170093          +256.2%     605862        interrupts.CPU4.LOC:Local_timer_interrupts
      0.50 ±173%  +84300.0%     422.00 ± 52%  interrupts.CPU4.NMI:Non-maskable_interrupts
      0.50 ±173%  +84300.0%     422.00 ± 52%  interrupts.CPU4.PMI:Performance_monitoring_interrupts
      2.25 ±127%   +1796.3%      42.67 ±120%  interrupts.CPU4.TLB:TLB_shootdowns
    169876          +255.8%     604461        interrupts.CPU40.LOC:Local_timer_interrupts
      0.00       +1.2e+104%     116.33 ±  7%  interrupts.CPU40.NMI:Non-maskable_interrupts
      0.00       +1.2e+104%     116.33 ±  7%  interrupts.CPU40.PMI:Performance_monitoring_interrupts
    169882          +256.4%     605525        interrupts.CPU41.LOC:Local_timer_interrupts
    169872          +256.4%     605376        interrupts.CPU42.LOC:Local_timer_interrupts
      0.00       +1.2e+104%     118.67 ±  7%  interrupts.CPU42.NMI:Non-maskable_interrupts
      0.00       +1.2e+104%     118.67 ±  7%  interrupts.CPU42.PMI:Performance_monitoring_interrupts
    169876          +256.4%     605376        interrupts.CPU43.LOC:Local_timer_interrupts
      0.00       +1.2e+104%     119.33 ±  8%  interrupts.CPU43.NMI:Non-maskable_interrupts
      0.00       +1.2e+104%     119.33 ±  8%  interrupts.CPU43.PMI:Performance_monitoring_interrupts
     63.25 ± 22%     +96.0%     124.00 ± 13%  interrupts.CPU43.TLB:TLB_shootdowns
    169881          +256.4%     605508        interrupts.CPU44.LOC:Local_timer_interrupts
    169876          +256.3%     605294        interrupts.CPU45.LOC:Local_timer_interrupts
      0.00       +1.2e+104%     119.33 ±  8%  interrupts.CPU45.NMI:Non-maskable_interrupts
      0.00       +1.2e+104%     119.33 ±  8%  interrupts.CPU45.PMI:Performance_monitoring_interrupts
    169874          +256.4%     605394        interrupts.CPU46.LOC:Local_timer_interrupts
    169860          +256.4%     605351        interrupts.CPU47.LOC:Local_timer_interrupts
    169872          +256.2%     605055        interrupts.CPU48.LOC:Local_timer_interrupts
    169889          +256.3%     605338        interrupts.CPU49.LOC:Local_timer_interrupts
    169976          +256.5%     605936        interrupts.CPU5.LOC:Local_timer_interrupts
      0.50 ±173%  +99633.3%     498.67 ± 55%  interrupts.CPU5.NMI:Non-maskable_interrupts
      0.50 ±173%  +99633.3%     498.67 ± 55%  interrupts.CPU5.PMI:Performance_monitoring_interrupts
    169976          +256.1%     605336        interrupts.CPU50.LOC:Local_timer_interrupts
    169891          +256.3%     605342        interrupts.CPU51.LOC:Local_timer_interrupts
    169885          +256.3%     605365        interrupts.CPU52.LOC:Local_timer_interrupts
      1.25 ±103%   +9260.0%     117.00 ±129%  interrupts.CPU52.RES:Rescheduling_interrupts
    169884          +256.3%     605346        interrupts.CPU53.LOC:Local_timer_interrupts
    169875          +256.4%     605391        interrupts.CPU54.LOC:Local_timer_interrupts
    169862          +256.4%     605397        interrupts.CPU55.LOC:Local_timer_interrupts
    169867          +256.4%     605434        interrupts.CPU56.LOC:Local_timer_interrupts
    169879          +256.4%     605517        interrupts.CPU57.LOC:Local_timer_interrupts
    169916          +256.2%     605262        interrupts.CPU58.LOC:Local_timer_interrupts
    169869          +256.3%     605225        interrupts.CPU59.LOC:Local_timer_interrupts
    171783          +252.7%     605813        interrupts.CPU6.LOC:Local_timer_interrupts
      0.25 ±173%    +3e+05%     743.00 ± 74%  interrupts.CPU6.NMI:Non-maskable_interrupts
      0.25 ±173%    +3e+05%     743.00 ± 74%  interrupts.CPU6.PMI:Performance_monitoring_interrupts
    169873          +256.4%     605408        interrupts.CPU60.LOC:Local_timer_interrupts
    169878          +256.4%     605434        interrupts.CPU61.LOC:Local_timer_interrupts
    169883          +256.4%     605408        interrupts.CPU62.LOC:Local_timer_interrupts
    169907          +256.3%     605339        interrupts.CPU63.LOC:Local_timer_interrupts
      0.25 ±173%  +46700.0%     117.00 ±  7%  interrupts.CPU63.NMI:Non-maskable_interrupts
      0.25 ±173%  +46700.0%     117.00 ±  7%  interrupts.CPU63.PMI:Performance_monitoring_interrupts
    169868          +256.4%     605358        interrupts.CPU64.LOC:Local_timer_interrupts
    169887          +256.3%     605375        interrupts.CPU65.LOC:Local_timer_interrupts
    169874          +256.3%     605186        interrupts.CPU66.LOC:Local_timer_interrupts
    169863          +256.2%     605022        interrupts.CPU67.LOC:Local_timer_interrupts
    169871          +256.3%     605249        interrupts.CPU68.LOC:Local_timer_interrupts
      0.25 ±173%  +38966.7%      97.67 ± 30%  interrupts.CPU68.NMI:Non-maskable_interrupts
      0.25 ±173%  +38966.7%      97.67 ± 30%  interrupts.CPU68.PMI:Performance_monitoring_interrupts
    169867          +256.3%     605240        interrupts.CPU69.LOC:Local_timer_interrupts
    169948          +256.5%     605858        interrupts.CPU7.LOC:Local_timer_interrupts
      0.00       +8.1e+104%     811.67 ± 77%  interrupts.CPU7.NMI:Non-maskable_interrupts
      0.00       +8.1e+104%     811.67 ± 77%  interrupts.CPU7.PMI:Performance_monitoring_interrupts
    169873          +256.3%     605316        interrupts.CPU70.LOC:Local_timer_interrupts
    169926          +256.3%     605395        interrupts.CPU71.LOC:Local_timer_interrupts
      0.25 ±173%  +30166.7%      75.67 ± 26%  interrupts.CPU71.NMI:Non-maskable_interrupts
      0.25 ±173%  +30166.7%      75.67 ± 26%  interrupts.CPU71.PMI:Performance_monitoring_interrupts
    169850          +256.0%     604683        interrupts.CPU72.LOC:Local_timer_interrupts
      0.00       +4.6e+104%     460.67 ±112%  interrupts.CPU72.NMI:Non-maskable_interrupts
      0.00       +4.6e+104%     460.67 ±112%  interrupts.CPU72.PMI:Performance_monitoring_interrupts
    169911          +256.3%     605372        interrupts.CPU73.LOC:Local_timer_interrupts
    169912          +255.1%     603385        interrupts.CPU74.LOC:Local_timer_interrupts
      0.25 ±173%    +1e+05%     254.00 ± 72%  interrupts.CPU74.NMI:Non-maskable_interrupts
      0.25 ±173%    +1e+05%     254.00 ± 72%  interrupts.CPU74.PMI:Performance_monitoring_interrupts
    169867          +255.2%     603423        interrupts.CPU75.LOC:Local_timer_interrupts
      0.25 ±173%  +6.9e+05%       1721 ±141%  interrupts.CPU75.RES:Rescheduling_interrupts
    169872          +255.4%     603702        interrupts.CPU76.LOC:Local_timer_interrupts
    169858          +255.7%     604203        interrupts.CPU77.LOC:Local_timer_interrupts
      0.25 ±173%  +90966.7%     227.67 ± 85%  interrupts.CPU77.NMI:Non-maskable_interrupts
      0.25 ±173%  +90966.7%     227.67 ± 85%  interrupts.CPU77.PMI:Performance_monitoring_interrupts
    169878          +255.4%     603701        interrupts.CPU78.LOC:Local_timer_interrupts
    169847          +256.1%     604859        interrupts.CPU79.LOC:Local_timer_interrupts
      2.00 ± 35%  +77950.0%       1561 ±141%  interrupts.CPU79.RES:Rescheduling_interrupts
    169956          +256.5%     605874        interrupts.CPU8.LOC:Local_timer_interrupts
    169864          +256.3%     605299        interrupts.CPU80.LOC:Local_timer_interrupts
      0.25 ±173%  +74566.7%     186.67 ± 74%  interrupts.CPU80.NMI:Non-maskable_interrupts
      0.25 ±173%  +74566.7%     186.67 ± 74%  interrupts.CPU80.PMI:Performance_monitoring_interrupts
    169872          +255.9%     604511        interrupts.CPU81.LOC:Local_timer_interrupts
      0.25 ±173%  +76433.3%     191.33 ± 75%  interrupts.CPU81.NMI:Non-maskable_interrupts
      0.25 ±173%  +76433.3%     191.33 ± 75%  interrupts.CPU81.PMI:Performance_monitoring_interrupts
    169854          +256.2%     604953        interrupts.CPU82.LOC:Local_timer_interrupts
      0.00       +9.2e+104%     918.33 ±141%  interrupts.CPU82.RES:Rescheduling_interrupts
    169866          +256.3%     605161        interrupts.CPU83.LOC:Local_timer_interrupts
    169873          +256.3%     605226        interrupts.CPU84.LOC:Local_timer_interrupts
    169864          +255.3%     603595        interrupts.CPU85.LOC:Local_timer_interrupts
      1.50 ±110%  +24522.2%     369.33 ±139%  interrupts.CPU85.RES:Rescheduling_interrupts
    169857          +255.2%     603319        interrupts.CPU86.LOC:Local_timer_interrupts
      0.25 ±173%  +1.3e+05%     327.67 ±140%  interrupts.CPU86.RES:Rescheduling_interrupts
    169846          +255.1%     603208        interrupts.CPU87.LOC:Local_timer_interrupts
      0.25 ±173%  +69500.0%     174.00 ±137%  interrupts.CPU87.RES:Rescheduling_interrupts
    169865          +255.1%     603260        interrupts.CPU88.LOC:Local_timer_interrupts
      1.00 ±122%  +39700.0%     398.00 ±138%  interrupts.CPU88.RES:Rescheduling_interrupts
    169858          +254.5%     602151        interrupts.CPU89.LOC:Local_timer_interrupts
    169929          +256.5%     605861        interrupts.CPU9.LOC:Local_timer_interrupts
      0.50 ±100%  +1.2e+05%     614.67 ± 82%  interrupts.CPU9.NMI:Non-maskable_interrupts
      0.50 ±100%  +1.2e+05%     614.67 ± 82%  interrupts.CPU9.PMI:Performance_monitoring_interrupts
    842.25 ±  4%    +129.5%       1933 ± 56%  interrupts.CPU90.CAL:Function_call_interrupts
    169851          +255.4%     603597        interrupts.CPU90.LOC:Local_timer_interrupts
    169845          +254.9%     602786        interrupts.CPU91.LOC:Local_timer_interrupts
      0.25 ±173%  +4.6e+05%       1144 ±141%  interrupts.CPU91.RES:Rescheduling_interrupts
    169845          +254.9%     602815        interrupts.CPU92.LOC:Local_timer_interrupts
    169845          +255.5%     603742        interrupts.CPU93.LOC:Local_timer_interrupts
      0.25 ±173%  +2.9e+05%     735.33 ±117%  interrupts.CPU93.NMI:Non-maskable_interrupts
      0.25 ±173%  +2.9e+05%     735.33 ±117%  interrupts.CPU93.PMI:Performance_monitoring_interrupts
    169850          +255.4%     603587        interrupts.CPU94.LOC:Local_timer_interrupts
    169883          +255.8%     604393        interrupts.CPU95.LOC:Local_timer_interrupts
    169892          +256.6%     605793        interrupts.CPU96.LOC:Local_timer_interrupts
      0.00       +1.6e+104%     163.67 ± 33%  interrupts.CPU96.NMI:Non-maskable_interrupts
      0.00       +1.6e+104%     163.67 ± 33%  interrupts.CPU96.PMI:Performance_monitoring_interrupts
      5.75 ±123%  +1.1e+05%       6462 ± 71%  interrupts.CPU96.RES:Rescheduling_interrupts
    169903          +256.6%     605855        interrupts.CPU97.LOC:Local_timer_interrupts
      0.75 ± 57%  +54255.6%     407.67 ± 93%  interrupts.CPU97.NMI:Non-maskable_interrupts
      0.75 ± 57%  +54255.6%     407.67 ± 93%  interrupts.CPU97.PMI:Performance_monitoring_interrupts
    169929          +256.5%     605809        interrupts.CPU98.LOC:Local_timer_interrupts
      0.25 ±173%  +1.4e+05%     344.00 ± 83%  interrupts.CPU98.NMI:Non-maskable_interrupts
      0.25 ±173%  +1.4e+05%     344.00 ± 83%  interrupts.CPU98.PMI:Performance_monitoring_interrupts
    211.25 ± 34%     -53.5%      98.33 ± 87%  interrupts.CPU98.TLB:TLB_shootdowns
    169905          +256.6%     605867        interrupts.CPU99.LOC:Local_timer_interrupts
      0.00       +1.2e+105%       1222 ± 71%  interrupts.CPU99.NMI:Non-maskable_interrupts
      0.00       +1.2e+105%       1222 ± 71%  interrupts.CPU99.PMI:Performance_monitoring_interrupts
  32623267          +256.2%  1.162e+08        interrupts.LOC:Local_timer_interrupts
     19.50 ± 13%  +2.7e+05%      52981 ±  5%  interrupts.NMI:Non-maskable_interrupts
     19.50 ± 13%  +2.7e+05%      52981 ±  5%  interrupts.PMI:Performance_monitoring_interrupts
      9284 ± 21%   +6401.2%     603584 ±  6%  interrupts.RES:Rescheduling_interrupts
     36631 ± 39%     +85.8%      68056 ±  6%  softirqs.CPU0.RCU
     33525 ± 12%     +85.1%      62041 ±  9%  softirqs.CPU0.SCHED
     19649 ± 24%    +139.1%      46978 ± 15%  softirqs.CPU1.RCU
     26756 ± 32%    +115.0%      57528 ± 12%  softirqs.CPU1.SCHED
      4302 ±105%     -69.8%       1298 ± 26%  softirqs.CPU10.NET_RX
     16827 ± 29%    +121.6%      37283 ±  3%  softirqs.CPU10.RCU
     24170 ± 28%     +91.8%      46359 ±  7%  softirqs.CPU10.SCHED
     14268 ± 15%    +139.8%      34212 ± 11%  softirqs.CPU100.RCU
     14298 ± 31%    +200.0%      42891 ±  3%  softirqs.CPU100.SCHED
     11778 ± 13%    +189.6%      34104 ±  7%  softirqs.CPU101.RCU
     13765 ± 27%    +216.3%      43547 ±  4%  softirqs.CPU101.SCHED
     10820 ± 15%    +216.2%      34212 ±  9%  softirqs.CPU102.RCU
     13358 ±  4%    +208.9%      41261        softirqs.CPU102.SCHED
     10795 ± 15%    +227.8%      35381 ± 17%  softirqs.CPU103.RCU
     11576 ± 12%    +248.7%      40362 ±  2%  softirqs.CPU103.SCHED
     11397 ± 13%    +191.7%      33249 ±  9%  softirqs.CPU104.RCU
     13062 ±  2%    +209.2%      40395 ±  3%  softirqs.CPU104.SCHED
     11028 ± 10%    +204.2%      33552 ±  7%  softirqs.CPU105.RCU
     13743 ± 10%    +223.1%      44409 ±  9%  softirqs.CPU105.SCHED
     11569 ±  8%    +190.9%      33649 ± 11%  softirqs.CPU106.RCU
     15613 ± 14%    +171.5%      42392 ±  4%  softirqs.CPU106.SCHED
     12111 ± 15%    +174.3%      33225 ± 11%  softirqs.CPU107.RCU
     13330 ±  3%    +206.1%      40802 ±  3%  softirqs.CPU107.SCHED
     11766 ± 13%    +191.1%      34245 ± 10%  softirqs.CPU108.RCU
     13375 ±  7%    +216.1%      42278 ±  6%  softirqs.CPU108.SCHED
     11734 ±  5%    +189.8%      34003 ±  6%  softirqs.CPU109.RCU
     14477 ± 16%    +191.7%      42226 ±  5%  softirqs.CPU109.SCHED
     14512 ± 16%    +155.0%      37011 ± 11%  softirqs.CPU11.RCU
     22234 ± 21%    +103.1%      45147 ±  5%  softirqs.CPU11.SCHED
     12623 ± 10%    +165.3%      33489 ± 11%  softirqs.CPU110.RCU
     15760 ± 25%    +165.0%      41762 ±  6%  softirqs.CPU110.SCHED
     12076 ± 10%    +166.3%      32159 ±  9%  softirqs.CPU111.RCU
     13461 ± 23%    +204.4%      40981 ±  3%  softirqs.CPU111.SCHED
     10369 ±  5%    +195.4%      30630 ±  9%  softirqs.CPU112.RCU
     13079          +208.5%      40355 ±  3%  softirqs.CPU112.SCHED
     11855 ± 18%    +152.9%      29987 ± 10%  softirqs.CPU113.RCU
     14311 ± 12%    +180.2%      40104 ±  3%  softirqs.CPU113.SCHED
     10268 ±  4%    +185.2%      29283 ± 12%  softirqs.CPU114.RCU
     12062 ± 14%    +232.0%      40045 ±  3%  softirqs.CPU114.SCHED
      9673 ± 12%    +214.4%      30416 ± 10%  softirqs.CPU115.RCU
     13065 ±  2%    +209.3%      40407 ±  4%  softirqs.CPU115.SCHED
     10535 ±  6%    +177.0%      29185 ± 13%  softirqs.CPU116.RCU
     13502 ±  5%    +196.1%      39980 ±  3%  softirqs.CPU116.SCHED
     10554 ± 15%    +184.4%      30014 ± 11%  softirqs.CPU117.RCU
     12562 ± 20%    +221.4%      40378 ±  3%  softirqs.CPU117.SCHED
     10137 ± 15%    +200.1%      30419 ± 12%  softirqs.CPU118.RCU
     13698 ±  9%    +195.6%      40495 ±  5%  softirqs.CPU118.SCHED
     10339 ± 13%    +188.9%      29871 ± 11%  softirqs.CPU119.RCU
     12917          +210.3%      40082 ±  3%  softirqs.CPU119.SCHED
    603.00 ± 78%   +1413.8%       9128 ±103%  softirqs.CPU12.NET_RX
     12244 ± 17%    +242.5%      41935 ± 25%  softirqs.CPU12.RCU
     15097 ± 23%    +307.9%      61581 ± 33%  softirqs.CPU12.SCHED
      9325 ±  9%    +219.7%      29811 ± 16%  softirqs.CPU120.RCU
     12722 ±  5%    +220.6%      40784 ±  4%  softirqs.CPU120.SCHED
      9951 ± 18%    +188.1%      28669 ± 14%  softirqs.CPU121.RCU
     12003 ± 19%    +241.2%      40951        softirqs.CPU121.SCHED
      9129 ±  8%    +213.5%      28621 ± 14%  softirqs.CPU122.RCU
     13016 ±  3%    +210.8%      40453 ±  3%  softirqs.CPU122.SCHED
     10132 ± 15%    +174.7%      27834 ± 19%  softirqs.CPU123.RCU
     13532 ±  8%    +206.9%      41535        softirqs.CPU123.SCHED
      9178 ± 11%    +211.3%      28574 ± 15%  softirqs.CPU124.RCU
     12857 ±  2%    +214.7%      40458 ±  3%  softirqs.CPU124.SCHED
      9601 ± 10%    +197.7%      28585 ± 15%  softirqs.CPU125.RCU
     13327 ±  5%    +203.4%      40441 ±  3%  softirqs.CPU125.SCHED
      9281 ± 10%    +211.5%      28914 ± 15%  softirqs.CPU126.RCU
     14298 ± 18%    +183.0%      40465 ±  3%  softirqs.CPU126.SCHED
      9234 ±  9%    +209.3%      28560 ± 16%  softirqs.CPU127.RCU
     12925 ±  2%    +212.6%      40408 ±  3%  softirqs.CPU127.SCHED
     11014 ± 17%    +193.3%      32300 ± 15%  softirqs.CPU128.RCU
     14016 ± 13%    +188.8%      40472 ±  3%  softirqs.CPU128.SCHED
     11931 ± 20%    +165.6%      31693 ± 14%  softirqs.CPU129.RCU
     13026 ±  4%    +209.9%      40375 ±  3%  softirqs.CPU129.SCHED
     13170 ±  5%    +202.3%      39814 ±  8%  softirqs.CPU13.RCU
     17537 ± 16%    +193.2%      51425 ± 10%  softirqs.CPU13.SCHED
     11612 ± 10%    +179.0%      32394 ± 14%  softirqs.CPU130.RCU
     13316 ±  7%    +203.5%      40418 ±  3%  softirqs.CPU130.SCHED
     12309 ± 18%    +164.2%      32517 ± 15%  softirqs.CPU131.RCU
     12875 ±  2%    +214.7%      40518 ±  3%  softirqs.CPU131.SCHED
     11593 ±  9%    +181.9%      32686 ± 15%  softirqs.CPU132.RCU
     13091 ±  3%    +209.9%      40564 ±  4%  softirqs.CPU132.SCHED
     10074 ± 13%    +217.8%      32014 ± 15%  softirqs.CPU133.RCU
     12732          +217.6%      40434 ±  3%  softirqs.CPU133.SCHED
     10895 ± 15%    +196.4%      32296 ± 14%  softirqs.CPU134.RCU
     12807 ±  2%    +216.1%      40484 ±  3%  softirqs.CPU134.SCHED
     10547 ± 18%    +206.1%      32290 ± 13%  softirqs.CPU135.RCU
     12829          +217.4%      40720 ±  3%  softirqs.CPU135.SCHED
     10936 ± 13%    +193.5%      32098 ± 16%  softirqs.CPU136.RCU
     13228 ±  6%    +205.9%      40461 ±  3%  softirqs.CPU136.SCHED
     10847 ± 17%    +200.8%      32625 ± 14%  softirqs.CPU137.RCU
     12920 ±  2%    +212.6%      40387 ±  3%  softirqs.CPU137.SCHED
     10933 ± 17%    +197.9%      32567 ± 14%  softirqs.CPU138.RCU
     13002          +212.9%      40684 ±  3%  softirqs.CPU138.SCHED
     10768 ± 18%    +206.1%      32959 ± 13%  softirqs.CPU139.RCU
     12790 ±  2%    +216.1%      40431 ±  3%  softirqs.CPU139.SCHED
     11498 ±  9%    +203.7%      34921 ±  9%  softirqs.CPU14.RCU
     13065 ±  3%    +233.7%      43601 ±  6%  softirqs.CPU14.SCHED
     10696 ± 20%    +195.4%      31596 ± 13%  softirqs.CPU140.RCU
     12715          +217.4%      40363 ±  3%  softirqs.CPU140.SCHED
     10439 ± 18%    +206.3%      31973 ± 14%  softirqs.CPU141.RCU
     12768 ±  3%    +216.3%      40383 ±  3%  softirqs.CPU141.SCHED
     11393 ± 13%    +182.4%      32171 ± 14%  softirqs.CPU142.RCU
     13086 ±  2%    +209.3%      40475 ±  3%  softirqs.CPU142.SCHED
     12556 ± 22%    +159.6%      32594 ± 17%  softirqs.CPU143.RCU
     11898 ± 15%    +242.0%      40692 ±  2%  softirqs.CPU143.SCHED
     10549 ± 17%    +222.5%      34016 ± 14%  softirqs.CPU144.RCU
     10903 ± 29%    +222.6%      35170 ± 26%  softirqs.CPU144.SCHED
     10132 ± 16%    +226.7%      33100 ± 15%  softirqs.CPU145.RCU
     12723 ±  2%    +219.9%      40702 ±  3%  softirqs.CPU145.SCHED
      9413 ± 18%    +246.2%      32593 ± 15%  softirqs.CPU146.RCU
     12727 ±  2%    +219.1%      40607 ±  3%  softirqs.CPU146.SCHED
     10519 ± 18%    +213.0%      32926 ± 14%  softirqs.CPU147.RCU
     12819 ±  2%    +215.9%      40501 ±  3%  softirqs.CPU147.SCHED
     10367 ± 18%    +219.5%      33129 ± 14%  softirqs.CPU148.RCU
     12863 ±  2%    +215.3%      40558 ±  3%  softirqs.CPU148.SCHED
     10315 ± 18%    +222.5%      33269 ± 14%  softirqs.CPU149.RCU
     12807 ±  2%    +217.2%      40627 ±  3%  softirqs.CPU149.SCHED
     11400 ±  6%    +217.3%      36178 ±  8%  softirqs.CPU15.RCU
     13103 ±  4%    +224.6%      42535 ±  6%  softirqs.CPU15.SCHED
     10600 ± 19%    +217.9%      33696 ± 15%  softirqs.CPU150.RCU
     13383 ±  6%    +203.1%      40560 ±  3%  softirqs.CPU150.SCHED
     10350 ± 17%    +219.6%      33077 ± 14%  softirqs.CPU151.RCU
     12904 ±  2%    +214.6%      40603 ±  3%  softirqs.CPU151.SCHED
     10471 ± 19%    +212.7%      32745 ± 13%  softirqs.CPU152.RCU
     12730 ±  2%    +218.9%      40595 ±  3%  softirqs.CPU152.SCHED
     10324 ± 18%    +221.8%      33222 ± 15%  softirqs.CPU153.RCU
     12802 ±  2%    +216.5%      40513 ±  3%  softirqs.CPU153.SCHED
      9876 ± 20%    +228.2%      32415 ± 14%  softirqs.CPU154.RCU
     12860 ±  2%    +215.2%      40535 ±  3%  softirqs.CPU154.SCHED
     11943 ± 31%    +167.8%      31979 ± 14%  softirqs.CPU155.RCU
     12805 ±  2%    +216.2%      40495 ±  3%  softirqs.CPU155.SCHED
     10499 ± 19%    +210.3%      32573 ± 14%  softirqs.CPU156.RCU
     13130 ±  2%    +209.7%      40659 ±  3%  softirqs.CPU156.SCHED
      9992 ± 14%    +226.1%      32587 ± 14%  softirqs.CPU157.RCU
     12727 ±  2%    +218.8%      40572 ±  3%  softirqs.CPU157.SCHED
     10054 ± 15%    +225.0%      32675 ± 13%  softirqs.CPU158.RCU
     12754 ±  2%    +218.3%      40589 ±  3%  softirqs.CPU158.SCHED
     10167 ± 18%    +226.4%      33189 ± 15%  softirqs.CPU159.RCU
     12811 ±  2%    +216.7%      40575 ±  3%  softirqs.CPU159.SCHED
      9837 ±  5%    +206.0%      30099 ± 11%  softirqs.CPU16.RCU
     12740          +213.5%      39938 ±  2%  softirqs.CPU16.SCHED
      9990 ± 15%    +206.2%      30593 ± 12%  softirqs.CPU160.RCU
     12747 ±  2%    +218.1%      40547 ±  3%  softirqs.CPU160.SCHED
      9801 ± 13%    +210.5%      30430 ± 12%  softirqs.CPU161.RCU
     12779 ±  2%    +217.8%      40612 ±  3%  softirqs.CPU161.SCHED
      9747 ± 13%    +211.3%      30340 ± 12%  softirqs.CPU162.RCU
     12826 ±  2%    +217.5%      40727 ±  3%  softirqs.CPU162.SCHED
      9781 ± 11%    +215.9%      30902 ± 12%  softirqs.CPU163.RCU
     12800          +219.1%      40848 ±  2%  softirqs.CPU163.SCHED
      9762 ± 12%    +213.1%      30565 ± 13%  softirqs.CPU164.RCU
     12779 ±  2%    +218.6%      40716 ±  3%  softirqs.CPU164.SCHED
      9782 ± 13%    +217.5%      31060 ± 16%  softirqs.CPU165.RCU
     12790 ±  2%    +236.6%      43050 ±  9%  softirqs.CPU165.SCHED
      9694 ± 13%    +210.8%      30134 ± 12%  softirqs.CPU166.RCU
     12810          +216.7%      40568 ±  3%  softirqs.CPU166.SCHED
      9610 ± 12%    +213.6%      30137 ± 12%  softirqs.CPU167.RCU
     12857          +216.0%      40630 ±  3%  softirqs.CPU167.SCHED
      9709 ± 11%    +203.5%      29469 ± 11%  softirqs.CPU168.RCU
     10859 ± 33%    +267.6%      39916 ±  3%  softirqs.CPU168.SCHED
      9438 ± 11%    +206.8%      28957 ± 11%  softirqs.CPU169.RCU
     12927 ±  2%    +206.5%      39625 ±  3%  softirqs.CPU169.SCHED
      9824 ±  8%    +202.4%      29705 ± 10%  softirqs.CPU17.RCU
     12811          +211.7%      39936 ±  3%  softirqs.CPU17.SCHED
      9085 ±  8%    +222.7%      29317 ± 11%  softirqs.CPU170.RCU
     12826 ±  2%    +210.4%      39812 ±  3%  softirqs.CPU170.SCHED
      9490 ± 13%    +207.6%      29190 ± 10%  softirqs.CPU171.RCU
     12792 ±  2%    +212.2%      39939 ±  3%  softirqs.CPU171.SCHED
      9569 ± 11%    +208.3%      29506 ± 11%  softirqs.CPU172.RCU
     12945 ±  2%    +206.9%      39727 ±  3%  softirqs.CPU172.SCHED
      9438 ± 13%    +203.9%      28682 ± 11%  softirqs.CPU173.RCU
     11618 ± 18%    +242.4%      39785 ±  3%  softirqs.CPU173.SCHED
      9577 ± 12%    +205.5%      29254 ± 11%  softirqs.CPU174.RCU
     12822 ±  2%    +209.3%      39655 ±  3%  softirqs.CPU174.SCHED
      9402 ± 11%    +209.2%      29069 ± 12%  softirqs.CPU175.RCU
     12779 ±  2%    +210.4%      39670 ±  3%  softirqs.CPU175.SCHED
      9926 ± 17%    +214.8%      31246 ± 13%  softirqs.CPU176.RCU
     12758 ±  2%    +170.6%      34523 ± 23%  softirqs.CPU176.SCHED
     10011 ± 15%    +208.9%      30926 ± 12%  softirqs.CPU177.RCU
     12759 ±  2%    +209.6%      39509 ±  3%  softirqs.CPU177.SCHED
     10282 ± 18%    +199.2%      30769 ± 12%  softirqs.CPU178.RCU
     12886 ±  2%    +210.3%      39988 ±  3%  softirqs.CPU178.SCHED
     10192 ± 18%    +176.7%      28203 ± 15%  softirqs.CPU179.RCU
     12841 ±  2%    +220.3%      41134 ±  4%  softirqs.CPU179.SCHED
      9773 ±  8%    +197.2%      29047 ± 12%  softirqs.CPU18.RCU
     12681          +218.5%      40386 ±  4%  softirqs.CPU18.SCHED
      9956 ± 14%    +208.1%      30677 ± 12%  softirqs.CPU180.RCU
     12788 ±  2%    +208.8%      39488 ±  4%  softirqs.CPU180.SCHED
     10320 ± 18%    +203.6%      31330 ± 12%  softirqs.CPU181.RCU
     13483 ±  7%    +192.9%      39496 ±  4%  softirqs.CPU181.SCHED
     10265 ± 19%    +198.1%      30600 ± 11%  softirqs.CPU182.RCU
     13003 ±  2%    +205.6%      39741 ±  3%  softirqs.CPU182.SCHED
      9730 ± 12%    +221.5%      31289 ± 12%  softirqs.CPU183.RCU
     12831 ±  2%    +210.3%      39821 ±  3%  softirqs.CPU183.SCHED
      9991 ± 16%    +212.3%      31208 ± 11%  softirqs.CPU184.RCU
     12866 ±  2%    +211.6%      40089 ±  3%  softirqs.CPU184.SCHED
     10296 ± 15%    +201.8%      31070 ± 10%  softirqs.CPU185.RCU
     12889 ±  2%    +213.9%      40466 ±  3%  softirqs.CPU185.SCHED
      9617 ± 10%    +223.8%      31138 ± 12%  softirqs.CPU186.RCU
     12835 ±  2%    +212.1%      40053 ±  2%  softirqs.CPU186.SCHED
     10282 ± 16%    +203.4%      31199 ± 13%  softirqs.CPU187.RCU
     12780 ±  2%    +208.8%      39471 ±  4%  softirqs.CPU187.SCHED
     10426 ± 21%    +195.8%      30836 ± 12%  softirqs.CPU188.RCU
     12904 ±  2%    +208.1%      39754 ±  3%  softirqs.CPU188.SCHED
     10030 ± 15%    +207.6%      30857 ± 12%  softirqs.CPU189.RCU
     12842 ±  2%    +210.5%      39870 ±  4%  softirqs.CPU189.SCHED
      9632 ±  7%    +209.3%      29798 ± 10%  softirqs.CPU19.RCU
     12998 ±  4%    +184.3%      36954 ± 11%  softirqs.CPU19.SCHED
     10144 ± 17%    +200.9%      30524 ± 12%  softirqs.CPU190.RCU
     12961 ±  2%    +207.3%      39826 ±  3%  softirqs.CPU190.SCHED
     10709 ± 18%    +180.2%      30007 ± 12%  softirqs.CPU191.RCU
     11762 ± 17%    +237.0%      39633 ±  3%  softirqs.CPU191.SCHED
     16992 ± 16%    +176.1%      46915 ± 23%  softirqs.CPU2.RCU
     17620 ± 13%    +129.1%      40372 ± 11%  softirqs.CPU2.SCHED
      9554 ±  8%    +205.9%      29227 ± 12%  softirqs.CPU20.RCU
     12521          +262.9%      45442 ± 18%  softirqs.CPU20.SCHED
      9598 ±  4%    +201.3%      28916 ± 12%  softirqs.CPU21.RCU
     12150 ±  7%    +226.7%      39699 ±  4%  softirqs.CPU21.SCHED
     10349 ± 11%    +186.4%      29640 ± 13%  softirqs.CPU22.RCU
     13369 ±  7%    +195.6%      39514 ±  4%  softirqs.CPU22.SCHED
     10204 ± 12%    +182.7%      28849 ± 14%  softirqs.CPU23.RCU
     12898 ±  5%    +206.9%      39586 ±  4%  softirqs.CPU23.SCHED
      9993 ± 14%    +194.6%      29439 ± 14%  softirqs.CPU24.RCU
     12906 ±  2%    +212.8%      40372 ±  3%  softirqs.CPU24.SCHED
      9325 ±  5%    +210.2%      28925 ± 12%  softirqs.CPU25.RCU
     12737          +215.3%      40157 ±  3%  softirqs.CPU25.SCHED
     10754 ± 14%    +170.8%      29122 ± 13%  softirqs.CPU26.RCU
     12486          +220.9%      40074 ±  3%  softirqs.CPU26.SCHED
      9784 ± 11%    +197.2%      29078 ± 13%  softirqs.CPU27.RCU
     12952 ±  4%    +210.7%      40245 ±  3%  softirqs.CPU27.SCHED
     10418 ±  9%    +182.4%      29419 ± 12%  softirqs.CPU28.RCU
     12735 ±  3%    +214.8%      40090 ±  3%  softirqs.CPU28.SCHED
      9696 ± 11%    +201.0%      29181 ± 13%  softirqs.CPU29.RCU
     12504 ±  2%    +222.3%      40300 ±  3%  softirqs.CPU29.SCHED
     12736 ±  7%    +181.8%      35891 ±  8%  softirqs.CPU3.RCU
     13222 ±  8%    +211.3%      41161 ±  2%  softirqs.CPU3.SCHED
     10090 ± 14%    +190.4%      29306 ± 13%  softirqs.CPU30.RCU
     11627 ± 17%    +246.4%      40273 ±  3%  softirqs.CPU30.SCHED
      9557 ± 10%    +202.3%      28896 ± 13%  softirqs.CPU31.RCU
     12655 ±  3%    +217.8%      40222 ±  3%  softirqs.CPU31.SCHED
     11424 ± 15%    +191.9%      33343 ± 13%  softirqs.CPU32.RCU
     11713 ± 17%    +243.9%      40282 ±  3%  softirqs.CPU32.SCHED
     11324 ± 15%    +189.4%      32773 ± 13%  softirqs.CPU33.RCU
     12622 ±  2%    +218.4%      40187 ±  3%  softirqs.CPU33.SCHED
     11099 ± 15%    +194.0%      32633 ± 13%  softirqs.CPU34.RCU
     12589 ±  2%    +220.3%      40318 ±  3%  softirqs.CPU34.SCHED
     11387 ± 16%    +190.7%      33103 ± 13%  softirqs.CPU35.RCU
     12582 ±  3%    +219.7%      40220 ±  3%  softirqs.CPU35.SCHED
     11448 ± 13%    +191.0%      33310 ± 13%  softirqs.CPU36.RCU
     12926 ±  3%    +211.0%      40204 ±  3%  softirqs.CPU36.SCHED
     10827 ± 10%    +205.5%      33082 ± 13%  softirqs.CPU37.RCU
     12649 ±  2%    +217.6%      40176 ±  3%  softirqs.CPU37.SCHED
     11100 ± 14%    +199.0%      33195 ± 12%  softirqs.CPU38.RCU
     12598 ±  3%    +218.2%      40086 ±  3%  softirqs.CPU38.SCHED
     11406 ± 13%    +190.0%      33076 ± 13%  softirqs.CPU39.RCU
     12620 ±  2%    +219.0%      40258 ±  3%  softirqs.CPU39.SCHED
     11841 ±  3%    +190.4%      34385 ±  7%  softirqs.CPU4.RCU
     13277 ±  9%    +168.1%      35601 ± 22%  softirqs.CPU4.SCHED
     11483 ± 10%    +182.8%      32478 ± 12%  softirqs.CPU40.RCU
     13043 ±  4%    +166.9%      34807 ± 25%  softirqs.CPU40.SCHED
     11484 ± 17%    +190.8%      33394 ± 11%  softirqs.CPU41.RCU
     12879 ±  2%    +211.2%      40081 ±  3%  softirqs.CPU41.SCHED
     11570 ± 14%    +186.9%      33201 ± 14%  softirqs.CPU42.RCU
     13137 ±  6%    +206.0%      40196 ±  3%  softirqs.CPU42.SCHED
     13205 ± 20%    +152.2%      33301 ± 13%  softirqs.CPU43.RCU
     12846 ±  3%    +212.1%      40096 ±  3%  softirqs.CPU43.SCHED
     11334 ± 14%    +189.8%      32850 ± 12%  softirqs.CPU44.RCU
     12770 ±  2%    +214.9%      40216 ±  3%  softirqs.CPU44.SCHED
     11320 ± 12%    +188.2%      32623 ± 10%  softirqs.CPU45.RCU
     13263 ±  8%    +202.2%      40085 ±  3%  softirqs.CPU45.SCHED
     11467 ± 14%    +185.9%      32781 ± 13%  softirqs.CPU46.RCU
     13569 ± 11%    +196.7%      40265 ±  3%  softirqs.CPU46.SCHED
     11431 ± 18%    +187.8%      32893 ± 13%  softirqs.CPU47.RCU
     12678 ±  2%    +217.3%      40222 ±  3%  softirqs.CPU47.SCHED
     10940 ± 17%    +209.0%      33805 ± 13%  softirqs.CPU48.RCU
     12423          +225.2%      40403 ±  3%  softirqs.CPU48.SCHED
     11022 ± 13%    +203.3%      33425 ± 12%  softirqs.CPU49.RCU
     12798 ±  3%    +215.7%      40400 ±  3%  softirqs.CPU49.SCHED
     11735 ±  4%    +196.9%      34844 ±  9%  softirqs.CPU5.RCU
     14244 ± 15%    +185.8%      40713 ±  3%  softirqs.CPU5.SCHED
      9335 ± 22%    +256.2%      33256 ± 12%  softirqs.CPU50.RCU
     12978 ±  2%    +213.7%      40706 ±  3%  softirqs.CPU50.SCHED
     10789 ± 16%    +206.0%      33017 ± 12%  softirqs.CPU51.RCU
     12547 ±  3%    +221.6%      40351 ±  3%  softirqs.CPU51.SCHED
     10994 ± 14%    +203.9%      33409 ± 13%  softirqs.CPU52.RCU
     12721 ±  2%    +216.6%      40268 ±  3%  softirqs.CPU52.SCHED
     10736 ± 17%    +209.9%      33276 ± 13%  softirqs.CPU53.RCU
     12541 ±  3%    +219.6%      40077 ±  2%  softirqs.CPU53.SCHED
     10737 ± 16%    +208.8%      33154 ± 12%  softirqs.CPU54.RCU
     12523 ±  3%    +220.0%      40077 ±  2%  softirqs.CPU54.SCHED
     10687 ± 15%    +210.5%      33185 ± 12%  softirqs.CPU55.RCU
     12563 ±  3%    +220.3%      40238 ±  3%  softirqs.CPU55.SCHED
     10993 ± 20%    +200.3%      33011 ± 12%  softirqs.CPU56.RCU
     12700 ±  5%    +217.1%      40269 ±  3%  softirqs.CPU56.SCHED
     10679 ± 16%    +209.3%      33030 ± 12%  softirqs.CPU57.RCU
     12555 ±  3%    +218.6%      39997 ±  2%  softirqs.CPU57.SCHED
      9916 ± 20%    +231.0%      32818 ± 13%  softirqs.CPU58.RCU
     12676 ±  3%    +218.5%      40377 ±  3%  softirqs.CPU58.SCHED
     10761 ± 18%    +207.5%      33088 ± 13%  softirqs.CPU59.RCU
     12530 ±  3%    +220.6%      40173 ±  2%  softirqs.CPU59.SCHED
     11429 ±  4%    +201.8%      34498 ±  6%  softirqs.CPU6.RCU
     12908 ±  2%    +218.9%      41160 ±  5%  softirqs.CPU6.SCHED
     10689 ± 18%    +207.2%      32835 ± 13%  softirqs.CPU60.RCU
     12522 ±  3%    +220.5%      40140 ±  2%  softirqs.CPU60.SCHED
     10400 ± 13%    +217.7%      33037 ± 13%  softirqs.CPU61.RCU
     12460 ±  3%    +224.3%      40409 ±  3%  softirqs.CPU61.SCHED
     10450 ± 13%    +215.0%      32914 ± 13%  softirqs.CPU62.RCU
     12492 ±  3%    +222.4%      40280 ±  3%  softirqs.CPU62.SCHED
     10662 ± 17%    +207.3%      32760 ± 13%  softirqs.CPU63.RCU
     12572 ±  3%    +221.2%      40386 ±  3%  softirqs.CPU63.SCHED
     10288 ±  9%    +200.5%      30917 ± 13%  softirqs.CPU64.RCU
     12467 ±  3%    +223.3%      40302 ±  3%  softirqs.CPU64.SCHED
     10385 ± 10%    +195.9%      30726 ± 14%  softirqs.CPU65.RCU
     12480 ±  3%    +222.6%      40262 ±  3%  softirqs.CPU65.SCHED
     10318 ± 11%    +199.8%      30936 ± 12%  softirqs.CPU66.RCU
     12576 ±  3%    +221.0%      40377 ±  3%  softirqs.CPU66.SCHED
     10432 ± 11%    +198.7%      31161 ± 11%  softirqs.CPU67.RCU
     12607 ±  3%    +222.5%      40660        softirqs.CPU67.SCHED
     10353 ± 11%    +196.5%      30699 ± 13%  softirqs.CPU68.RCU
     12530 ±  3%    +221.4%      40271 ±  3%  softirqs.CPU68.SCHED
     10565 ± 12%    +191.6%      30807 ± 13%  softirqs.CPU69.RCU
     12859 ±  6%    +213.8%      40353 ±  2%  softirqs.CPU69.SCHED
     12157 ±  2%    +189.2%      35155 ±  5%  softirqs.CPU7.RCU
     12718 ±  4%    +211.4%      39609 ±  4%  softirqs.CPU7.SCHED
     10365 ± 12%    +195.9%      30669 ± 13%  softirqs.CPU70.RCU
     12655 ±  3%    +218.7%      40332 ±  3%  softirqs.CPU70.SCHED
     10205 ± 10%    +199.0%      30511 ± 12%  softirqs.CPU71.RCU
     12514 ±  2%    +222.1%      40307 ±  3%  softirqs.CPU71.SCHED
     10395 ±  9%    +204.3%      31634 ± 10%  softirqs.CPU72.RCU
     12935 ±  2%    +206.2%      39604 ±  3%  softirqs.CPU72.SCHED
     10183 ±  9%    +195.7%      30116 ± 12%  softirqs.CPU73.RCU
     12864 ±  4%    +205.0%      39233 ±  3%  softirqs.CPU73.SCHED
      9830 ±  9%    +204.3%      29914 ± 11%  softirqs.CPU74.RCU
     11347 ± 16%    +246.9%      39366 ±  3%  softirqs.CPU74.SCHED
     10232 ± 12%    +194.8%      30170 ± 11%  softirqs.CPU75.RCU
     11691 ± 19%    +238.6%      39591 ±  2%  softirqs.CPU75.SCHED
     10019 ± 11%    +202.9%      30350 ± 12%  softirqs.CPU76.RCU
     11498 ± 18%    +244.1%      39569 ±  2%  softirqs.CPU76.SCHED
     10260 ± 10%    +187.1%      29456 ± 11%  softirqs.CPU77.RCU
     13011 ±  4%    +202.8%      39393 ±  3%  softirqs.CPU77.SCHED
     10130 ± 11%    +189.9%      29369 ± 12%  softirqs.CPU78.RCU
     12691 ±  3%    +209.3%      39249 ±  3%  softirqs.CPU78.SCHED
      9998 ± 10%    +201.3%      30129 ± 12%  softirqs.CPU79.RCU
     12638 ±  3%    +210.9%      39296 ±  3%  softirqs.CPU79.SCHED
     11062 ±  6%    +188.9%      31958 ± 11%  softirqs.CPU8.RCU
     12684          +208.4%      39117 ±  4%  softirqs.CPU8.SCHED
     10540 ± 14%    +194.4%      31029 ± 12%  softirqs.CPU80.RCU
     12594 ±  4%    +212.0%      39298 ±  4%  softirqs.CPU80.SCHED
     10500 ± 14%    +191.9%      30648 ± 11%  softirqs.CPU81.RCU
     12600 ±  3%    +210.5%      39120 ±  3%  softirqs.CPU81.SCHED
     10765 ± 15%    +184.0%      30575 ± 11%  softirqs.CPU82.RCU
     12617 ±  3%    +210.4%      39168 ±  2%  softirqs.CPU82.SCHED
     11128 ± 21%    +170.1%      30057 ± 11%  softirqs.CPU83.RCU
     13436 ± 13%    +193.2%      39393 ±  3%  softirqs.CPU83.SCHED
     10636 ± 13%    +187.5%      30575 ± 12%  softirqs.CPU84.RCU
     11565 ± 19%    +237.8%      39073 ±  3%  softirqs.CPU84.SCHED
     10528 ± 13%    +186.9%      30203 ± 11%  softirqs.CPU85.RCU
     12610 ±  3%    +209.1%      38978 ±  3%  softirqs.CPU85.SCHED
     10605 ± 15%    +178.8%      29572 ± 11%  softirqs.CPU86.RCU
     12633 ±  3%    +212.3%      39450 ±  4%  softirqs.CPU86.SCHED
     10181 ±  9%    +194.6%      29991 ± 11%  softirqs.CPU87.RCU
     12632 ±  3%    +209.4%      39088 ±  3%  softirqs.CPU87.SCHED
     10606 ± 14%    +186.0%      30335 ± 11%  softirqs.CPU88.RCU
     12631 ±  3%    +210.3%      39197 ±  3%  softirqs.CPU88.SCHED
     10696 ± 15%    +182.3%      30197 ± 11%  softirqs.CPU89.RCU
     12647 ±  2%    +209.9%      39197 ±  3%  softirqs.CPU89.SCHED
     12105 ± 12%    +170.5%      32738 ±  9%  softirqs.CPU9.RCU
     13608 ±  4%    +196.1%      40299 ±  3%  softirqs.CPU9.SCHED
     10155 ±  9%    +196.7%      30132 ± 11%  softirqs.CPU90.RCU
     12574 ±  4%    +211.4%      39149 ±  3%  softirqs.CPU90.SCHED
     10706 ± 16%    +183.3%      30328 ± 11%  softirqs.CPU91.RCU
     12651 ±  4%    +208.1%      38979 ±  4%  softirqs.CPU91.SCHED
     10770 ± 16%    +177.7%      29907 ± 11%  softirqs.CPU92.RCU
     12723 ±  5%    +207.8%      39157 ±  3%  softirqs.CPU92.SCHED
     10564 ± 14%    +181.8%      29772 ± 10%  softirqs.CPU93.RCU
     12505 ±  3%    +214.5%      39331 ±  3%  softirqs.CPU93.SCHED
     10547 ± 14%    +184.7%      30032 ± 11%  softirqs.CPU94.RCU
     12610 ±  3%    +211.2%      39238 ±  3%  softirqs.CPU94.SCHED
     10561 ± 14%    +189.2%      30546 ± 12%  softirqs.CPU95.RCU
     12646 ±  3%    +108.4%      26350 ± 10%  softirqs.CPU95.SCHED
     10757 ± 10%    +218.1%      34217 ± 15%  softirqs.CPU96.RCU
     14108 ± 25%    +128.7%      32271 ± 11%  softirqs.CPU97.RCU
     16322 ± 22%    +118.0%      35589 ± 24%  softirqs.CPU97.SCHED
     10842 ±  6%    +207.7%      33356 ± 10%  softirqs.CPU98.RCU
     14074 ±  2%    +193.6%      41320 ±  2%  softirqs.CPU98.SCHED
     11158 ± 15%    +192.0%      32581 ±  9%  softirqs.CPU99.RCU
     13123 ± 14%    +213.4%      41123        softirqs.CPU99.SCHED
   2089598 ± 11%    +194.2%    6147567 ± 11%  softirqs.RCU
   2534223          +206.8%    7775620        softirqs.SCHED
     52065 ± 12%     +65.5%      86153 ± 15%  softirqs.TIMER
     27.21 ±  4%     -27.2        0.00        perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.get_signal.arch_do_signal.exit_to_user_mode_prepare
     35.12 ± 45%     -27.1        8.07 ±  9%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     21.21 ± 47%     -21.2        0.00        perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
     21.21 ± 47%     -21.0        0.19 ±141%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
     20.21 ± 58%     -20.2        0.00        perf-profile.calltrace.cycles-pp.arch_do_signal.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
     20.21 ± 58%     -20.2        0.00        perf-profile.calltrace.cycles-pp.get_signal.arch_do_signal.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
     20.21 ± 58%     -20.2        0.00        perf-profile.calltrace.cycles-pp.do_group_exit.get_signal.arch_do_signal.exit_to_user_mode_prepare.syscall_exit_to_user_mode
     18.07 ± 59%     -18.1        0.00        perf-profile.calltrace.cycles-pp.task_work_run.do_exit.do_group_exit.get_signal.arch_do_signal
     18.07 ± 59%     -18.1        0.00        perf-profile.calltrace.cycles-pp.__fput.task_work_run.do_exit.do_group_exit.get_signal
     15.82 ± 63%     -15.8        0.00        perf-profile.calltrace.cycles-pp.perf_release.__fput.task_work_run.do_exit.do_group_exit
     15.82 ± 63%     -15.8        0.00        perf-profile.calltrace.cycles-pp.perf_event_release_kernel.perf_release.__fput.task_work_run.do_exit
     10.29 ± 67%     -10.3        0.00        perf-profile.calltrace.cycles-pp.perf_remove_from_context.perf_event_release_kernel.perf_release.__fput.task_work_run
     10.29 ± 67%     -10.3        0.00        perf-profile.calltrace.cycles-pp.event_function_call.perf_remove_from_context.perf_event_release_kernel.perf_release.__fput
     10.29 ± 67%     -10.3        0.00        perf-profile.calltrace.cycles-pp.smp_call_function_single.event_function_call.perf_remove_from_context.perf_event_release_kernel.perf_release
      9.52 ± 94%      -9.5        0.00        perf-profile.calltrace.cycles-pp.proc_reg_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.52 ± 94%      -9.5        0.00        perf-profile.calltrace.cycles-pp.seq_read.proc_reg_read.vfs_read.ksys_read.do_syscall_64
      9.14 ±127%      -9.1        0.00        perf-profile.calltrace.cycles-pp.mmput.do_exit.do_group_exit.get_signal.arch_do_signal
      9.14 ±127%      -9.1        0.00        perf-profile.calltrace.cycles-pp.exit_mmap.mmput.do_exit.do_group_exit.get_signal
      6.57 ±100%      -6.6        0.00        perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.mmput.do_exit.do_group_exit
      6.57 ±100%      -6.6        0.00        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.mmput.do_exit
      6.57 ±100%      -6.6        0.00        perf-profile.calltrace.cycles-pp.zap_pte_range.unmap_page_range.unmap_vmas.exit_mmap.mmput
     13.91 ± 61%      -6.1        7.81 ±  6%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.57 ±107%      -5.6        0.00        perf-profile.calltrace.cycles-pp.page_remove_rmap.zap_pte_range.unmap_page_range.unmap_vmas.exit_mmap
      5.52 ± 63%      -5.5        0.00        perf-profile.calltrace.cycles-pp._free_event.perf_event_release_kernel.perf_release.__fput.task_work_run
      5.52 ± 63%      -5.5        0.00        perf-profile.calltrace.cycles-pp.sw_perf_event_destroy._free_event.perf_event_release_kernel.perf_release.__fput
      5.50 ±100%      -5.5        0.00        perf-profile.calltrace.cycles-pp.perf_mmap__read_head.perf_mmap__push.record__mmap_read_evlist.cmd_record.run_builtin
      4.50 ±101%      -4.5        0.00        perf-profile.calltrace.cycles-pp.__libc_start_main
      4.50 ±101%      -4.5        0.00        perf-profile.calltrace.cycles-pp.main.__libc_start_main
      4.50 ±101%      -4.5        0.00        perf-profile.calltrace.cycles-pp.run_builtin.main.__libc_start_main
      4.50 ±101%      -4.5        0.00        perf-profile.calltrace.cycles-pp.cmd_record.run_builtin.main.__libc_start_main
      4.50 ±101%      -4.5        0.00        perf-profile.calltrace.cycles-pp.record__mmap_read_evlist.cmd_record.run_builtin.main.__libc_start_main
      4.50 ±101%      -4.5        0.00        perf-profile.calltrace.cycles-pp.perf_mmap__push.record__mmap_read_evlist.cmd_record.run_builtin.main
      0.00            +0.6        0.57 ± 11%  perf-profile.calltrace.cycles-pp.page_cache_readahead_unbounded.generic_file_buffered_read.aio_read.__io_submit_one.io_submit_one
      0.00            +0.6        0.60 ± 10%  perf-profile.calltrace.cycles-pp.schedule.worker_thread.kthread.ret_from_fork
      0.00            +0.6        0.60 ±  7%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__sched_text_start.schedule_idle.do_idle.cpu_startup_entry
      0.00            +0.6        0.61 ±  7%  perf-profile.calltrace.cycles-pp.blk_mq_submit_bio.submit_bio_noacct.submit_bio.btrfs_map_bio.btrfs_submit_bio_hook
      0.00            +0.6        0.63 ±  8%  perf-profile.calltrace.cycles-pp.endio_readpage_release_extent.end_bio_extent_readpage.end_workqueue_fn.btrfs_work_helper.process_one_work
      0.00            +0.6        0.65 ±  7%  perf-profile.calltrace.cycles-pp.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_on_stack
      0.00            +0.7        0.68 ±  7%  perf-profile.calltrace.cycles-pp.rebalance_domains.__softirqentry_text_start.asm_call_on_stack.do_softirq_own_stack.irq_exit_rcu
      0.00            +0.7        0.69 ± 18%  perf-profile.calltrace.cycles-pp.tick_nohz_irq_exit.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00            +0.7        0.69 ±  7%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.__queue_work
      0.00            +0.7        0.75 ±  7%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.__queue_work.queue_work_on
      0.00            +0.8        0.75 ±  7%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.__queue_work.queue_work_on.btrfs_end_bio
      0.00            +0.8        0.83 ±  7%  perf-profile.calltrace.cycles-pp.unwind_next_frame.arch_stack_walk.stack_trace_save_tsk.__account_scheduler_latency.enqueue_entity
      0.00            +0.8        0.83 ±  6%  perf-profile.calltrace.cycles-pp.submit_bio_noacct.submit_bio.btrfs_map_bio.btrfs_submit_bio_hook.submit_one_bio
      0.00            +0.8        0.84 ±  6%  perf-profile.calltrace.cycles-pp.submit_bio.btrfs_map_bio.btrfs_submit_bio_hook.submit_one_bio.extent_read_full_page
      0.00            +0.9        0.88 ± 12%  perf-profile.calltrace.cycles-pp.timekeeping_max_deferment.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.do_idle
      0.00            +0.9        0.90 ±  8%  perf-profile.calltrace.cycles-pp.__sched_text_start.schedule.io_schedule.__lock_page_killable.generic_file_buffered_read
      0.00            +0.9        0.92 ±  7%  perf-profile.calltrace.cycles-pp.schedule.io_schedule.__lock_page_killable.generic_file_buffered_read.aio_read
      0.00            +0.9        0.94 ±  7%  perf-profile.calltrace.cycles-pp.io_schedule.__lock_page_killable.generic_file_buffered_read.aio_read.__io_submit_one
      0.00            +1.0        1.01 ± 17%  perf-profile.calltrace.cycles-pp.ktime_get.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_on_stack
      0.00            +1.0        1.05 ± 10%  perf-profile.calltrace.cycles-pp.btrfs_search_slot.btrfs_lookup_csum.btrfs_lookup_bio_sums.btrfs_submit_bio_hook.submit_one_bio
      0.00            +1.1        1.09 ±  7%  perf-profile.calltrace.cycles-pp.arch_stack_walk.stack_trace_save_tsk.__account_scheduler_latency.enqueue_entity.enqueue_task_fair
      0.00            +1.1        1.11 ±  9%  perf-profile.calltrace.cycles-pp.btrfs_lookup_csum.btrfs_lookup_bio_sums.btrfs_submit_bio_hook.submit_one_bio.extent_read_full_page
      0.00            +1.1        1.14 ±  7%  perf-profile.calltrace.cycles-pp.__lock_page_killable.generic_file_buffered_read.aio_read.__io_submit_one.io_submit_one
      0.00            +1.2        1.16 ±  6%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.asm_call_on_stack.do_softirq_own_stack.irq_exit_rcu.sysvec_apic_timer_interrupt
      0.00            +1.2        1.16 ±  5%  perf-profile.calltrace.cycles-pp.asm_call_on_stack.do_softirq_own_stack.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +1.2        1.17 ±  5%  perf-profile.calltrace.cycles-pp.do_softirq_own_stack.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.00            +1.2        1.19 ± 28%  perf-profile.calltrace.cycles-pp.ktime_get.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +1.2        1.21 ±  3%  perf-profile.calltrace.cycles-pp.__sched_text_start.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      0.00            +1.2        1.24 ±  7%  perf-profile.calltrace.cycles-pp.try_to_wake_up.__queue_work.queue_work_on.btrfs_end_bio.blk_update_request
      0.00            +1.2        1.24 ±  3%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
      0.00            +1.3        1.26 ±  7%  perf-profile.calltrace.cycles-pp.stack_trace_save_tsk.__account_scheduler_latency.enqueue_entity.enqueue_task_fair.ttwu_do_activate
      0.00            +1.3        1.30 ± 25%  perf-profile.calltrace.cycles-pp.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.00            +1.4        1.36 ±  5%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00            +1.4        1.42 ±  9%  perf-profile.calltrace.cycles-pp.btrfs_map_bio.btrfs_submit_bio_hook.submit_one_bio.extent_read_full_page.generic_file_buffered_read
      0.00            +1.5        1.45 ± 22%  perf-profile.calltrace.cycles-pp.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00            +1.5        1.52 ±  9%  perf-profile.calltrace.cycles-pp.btrfs_lookup_bio_sums.btrfs_submit_bio_hook.submit_one_bio.extent_read_full_page.generic_file_buffered_read
      0.00            +1.5        1.55 ±  9%  perf-profile.calltrace.cycles-pp.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_on_stack.sysvec_apic_timer_interrupt
      0.00            +1.6        1.65 ±  6%  perf-profile.calltrace.cycles-pp.__queue_work.queue_work_on.btrfs_end_bio.blk_update_request.blk_mq_end_request
      0.00            +1.7        1.68 ±  6%  perf-profile.calltrace.cycles-pp.queue_work_on.btrfs_end_bio.blk_update_request.blk_mq_end_request.nvme_irq
      0.00            +1.7        1.72 ± 12%  perf-profile.calltrace.cycles-pp.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry
      0.00            +1.8        1.80 ±  6%  perf-profile.calltrace.cycles-pp.btrfs_end_bio.blk_update_request.blk_mq_end_request.nvme_irq.__handle_irq_event_percpu
      0.00            +1.8        1.85 ± 19%  perf-profile.calltrace.cycles-pp.__account_scheduler_latency.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up
      0.00            +1.9        1.90 ±  7%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.wake_page_function
      0.00            +1.9        1.94 ±  7%  perf-profile.calltrace.cycles-pp.blk_update_request.blk_mq_end_request.nvme_irq.__handle_irq_event_percpu.handle_irq_event_percpu
      0.00            +2.0        2.01 ±  6%  perf-profile.calltrace.cycles-pp.blk_mq_end_request.nvme_irq.__handle_irq_event_percpu.handle_irq_event_percpu.handle_irq_event
      0.00            +2.0        2.04 ±  7%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.wake_page_function.__wake_up_common
      0.00            +2.1        2.05 ±  7%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.wake_page_function.__wake_up_common.wake_up_page_bit
      0.00            +2.2        2.25 ±  6%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry.start_secondary
      0.00            +2.3        2.28 ±  4%  perf-profile.calltrace.cycles-pp.nvme_irq.__handle_irq_event_percpu.handle_irq_event_percpu.handle_irq_event.handle_edge_irq
      0.00            +2.3        2.30 ±  4%  perf-profile.calltrace.cycles-pp.__handle_irq_event_percpu.handle_irq_event_percpu.handle_irq_event.handle_edge_irq.asm_call_on_stack
      0.00            +2.4        2.38 ±  4%  perf-profile.calltrace.cycles-pp.handle_irq_event_percpu.handle_irq_event.handle_edge_irq.asm_call_on_stack.common_interrupt
      0.00            +2.5        2.51 ±  4%  perf-profile.calltrace.cycles-pp.handle_irq_event.handle_edge_irq.asm_call_on_stack.common_interrupt.asm_common_interrupt
      0.00            +2.6        2.61 ±  4%  perf-profile.calltrace.cycles-pp.handle_edge_irq.asm_call_on_stack.common_interrupt.asm_common_interrupt.cpuidle_enter_state
      0.00            +2.6        2.61 ±  4%  perf-profile.calltrace.cycles-pp.asm_call_on_stack.common_interrupt.asm_common_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00            +2.8        2.80 ±  4%  perf-profile.calltrace.cycles-pp.common_interrupt.asm_common_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle
      0.00            +2.8        2.82 ±  4%  perf-profile.calltrace.cycles-pp.asm_common_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      0.00            +2.9        2.85 ±  7%  perf-profile.calltrace.cycles-pp.try_to_wake_up.wake_page_function.__wake_up_common.wake_up_page_bit.end_bio_extent_readpage
      0.00            +2.9        2.88 ±  6%  perf-profile.calltrace.cycles-pp.wake_page_function.__wake_up_common.wake_up_page_bit.end_bio_extent_readpage.end_workqueue_fn
      0.00            +3.0        2.95 ±  7%  perf-profile.calltrace.cycles-pp.__wake_up_common.wake_up_page_bit.end_bio_extent_readpage.end_workqueue_fn.btrfs_work_helper
      0.00            +3.0        3.04 ±  9%  perf-profile.calltrace.cycles-pp.btrfs_submit_bio_hook.submit_one_bio.extent_read_full_page.generic_file_buffered_read.aio_read
      0.00            +3.1        3.06 ±  9%  perf-profile.calltrace.cycles-pp.submit_one_bio.extent_read_full_page.generic_file_buffered_read.aio_read.__io_submit_one
      0.00            +3.1        3.14 ±  7%  perf-profile.calltrace.cycles-pp.wake_up_page_bit.end_bio_extent_readpage.end_workqueue_fn.btrfs_work_helper.process_one_work
      0.00            +3.4        3.37 ± 21%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      0.00            +3.9        3.93 ±  7%  perf-profile.calltrace.cycles-pp.extent_read_full_page.generic_file_buffered_read.aio_read.__io_submit_one.io_submit_one
      0.00            +4.1        4.12 ±  7%  perf-profile.calltrace.cycles-pp.end_bio_extent_readpage.end_workqueue_fn.btrfs_work_helper.process_one_work.worker_thread
      0.00            +4.4        4.41 ±  8%  perf-profile.calltrace.cycles-pp.end_workqueue_fn.btrfs_work_helper.process_one_work.worker_thread.kthread
      0.00            +4.5        4.51 ±  8%  perf-profile.calltrace.cycles-pp.btrfs_work_helper.process_one_work.worker_thread.kthread.ret_from_fork
      1.00 ±173%      +4.7        5.74 ± 11%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +5.3        5.32 ±  8%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork
      0.00            +5.8        5.84 ± 11%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.asm_call_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.00            +5.9        5.87 ± 11%  perf-profile.calltrace.cycles-pp.asm_call_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00            +6.2        6.22 ±  8%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork
      0.00            +6.5        6.54 ±  4%  perf-profile.calltrace.cycles-pp.ret_from_fork
      0.00            +6.5        6.54 ±  4%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
      0.00            +6.7        6.70 ±  7%  perf-profile.calltrace.cycles-pp.generic_file_buffered_read.aio_read.__io_submit_one.io_submit_one.__x64_sys_io_submit
      0.00            +6.9        6.91 ±  7%  perf-profile.calltrace.cycles-pp.aio_read.__io_submit_one.io_submit_one.__x64_sys_io_submit.do_syscall_64
      0.00            +7.0        6.99 ±  7%  perf-profile.calltrace.cycles-pp.__io_submit_one.io_submit_one.__x64_sys_io_submit.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +7.3        7.27 ±  6%  perf-profile.calltrace.cycles-pp.io_submit_one.__x64_sys_io_submit.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +7.4        7.39 ±  6%  perf-profile.calltrace.cycles-pp.__x64_sys_io_submit.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +9.5        9.52 ± 11%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle
      0.00           +10.6       10.56 ± 13%  perf-profile.calltrace.cycles-pp.menu_select.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
      0.00           +17.2       17.16 ± 11%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     44.12 ± 35%     +21.9       66.00 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
     44.12 ± 35%     +25.2       69.33 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
     44.12 ± 35%     +38.6       82.69        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
     44.12 ± 35%     +38.6       82.75        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64
     44.12 ± 35%     +38.6       82.76        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64
     44.12 ± 35%     +38.9       83.06        perf-profile.calltrace.cycles-pp.secondary_startup_64
     43.38 ± 18%     -35.1        8.32 ±  9%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     29.46 ±  5%     -29.4        0.03 ± 70%  perf-profile.children.cycles-pp.do_group_exit
     29.46 ±  5%     -29.4        0.03 ± 70%  perf-profile.children.cycles-pp.do_exit
     28.21 ±  8%     -28.2        0.02 ±141%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
     27.21 ±  4%     -27.2        0.00        perf-profile.children.cycles-pp.arch_do_signal
     27.21 ±  4%     -27.2        0.00        perf-profile.children.cycles-pp.get_signal
     21.21 ± 47%     -21.0        0.24 ±108%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
     19.07 ± 58%     -19.1        0.00        perf-profile.children.cycles-pp.task_work_run
     18.07 ± 59%     -18.1        0.00        perf-profile.children.cycles-pp.__fput
     15.82 ± 63%     -15.8        0.00        perf-profile.children.cycles-pp.perf_release
     15.82 ± 63%     -15.8        0.00        perf-profile.children.cycles-pp.perf_event_release_kernel
     22.16 ± 48%     -14.1        8.04 ±  6%  perf-profile.children.cycles-pp.do_syscall_64
     10.29 ± 67%     -10.3        0.00        perf-profile.children.cycles-pp.perf_remove_from_context
     10.29 ± 67%     -10.3        0.00        perf-profile.children.cycles-pp.event_function_call
     10.29 ± 67%     -10.3        0.00        perf-profile.children.cycles-pp.smp_call_function_single
      9.52 ± 94%      -9.5        0.00        perf-profile.children.cycles-pp.proc_reg_read
      9.52 ± 94%      -9.5        0.00        perf-profile.children.cycles-pp.seq_read
      6.57 ±100%      -6.6        0.00        perf-profile.children.cycles-pp.unmap_vmas
      6.57 ±100%      -6.6        0.00        perf-profile.children.cycles-pp.unmap_page_range
      6.57 ±100%      -6.6        0.00        perf-profile.children.cycles-pp.zap_pte_range
      6.52 ± 69%      -6.5        0.00        perf-profile.children.cycles-pp.seq_printf
      6.52 ± 69%      -6.5        0.00        perf-profile.children.cycles-pp.seq_vprintf
      6.52 ± 69%      -6.5        0.00        perf-profile.children.cycles-pp.vsnprintf
      5.57 ±107%      -5.6        0.00        perf-profile.children.cycles-pp.page_remove_rmap
      5.52 ± 63%      -5.5        0.00        perf-profile.children.cycles-pp._free_event
      5.52 ± 63%      -5.5        0.00        perf-profile.children.cycles-pp.sw_perf_event_destroy
      4.50 ±101%      -4.5        0.00        perf-profile.children.cycles-pp.cmd_record
      4.50 ±101%      -4.5        0.00        perf-profile.children.cycles-pp.record__mmap_read_evlist
      4.50 ±101%      -4.5        0.00        perf-profile.children.cycles-pp.perf_mmap__push
      4.50 ±101%      -4.5        0.00        perf-profile.children.cycles-pp.perf_mmap__read_head
      4.50 ±101%      -4.5        0.02 ±141%  perf-profile.children.cycles-pp.__libc_start_main
      4.50 ±101%      -4.5        0.02 ±141%  perf-profile.children.cycles-pp.main
      4.50 ±101%      -4.5        0.02 ±141%  perf-profile.children.cycles-pp.run_builtin
      4.27 ±100%      -4.3        0.00        perf-profile.children.cycles-pp.swevent_hlist_put_cpu
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.read_pages
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__check_object_size
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.blk_throtl_bio
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.__crc32c_pcl_intel_finup
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.__blk_queue_split
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.cpus_share_cache
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.unlock_page
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.btrfs_bio_counter_inc_blocked
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.cpuidle_not_available
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.btrfs_find_ordered_sum
      0.00            +0.1        0.06 ± 16%  perf-profile.children.cycles-pp.trigger_load_balance
      0.00            +0.1        0.06 ± 16%  perf-profile.children.cycles-pp._find_next_bit
      0.00            +0.1        0.06 ± 16%  perf-profile.children.cycles-pp.available_idle_cpu
      0.00            +0.1        0.06 ± 16%  perf-profile.children.cycles-pp.bio_endio
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.irqtime_account_process_tick
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.cpumask_next_and
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.force_qs_rnp
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.update_cfs_group
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.rb_erase
      0.00            +0.1        0.06 ± 19%  perf-profile.children.cycles-pp.mem_cgroup_charge
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.mark_extent_buffer_accessed
      0.00            +0.1        0.06 ± 14%  perf-profile.children.cycles-pp.tick_nohz_tick_stopped
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.blk_mq_rq_ctx_init
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp._cond_resched
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.execve
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.btrfs_readpage_end_io_hook
      0.00            +0.1        0.07 ± 14%  perf-profile.children.cycles-pp.tick_check_broadcast_expired
      0.00            +0.1        0.07 ± 18%  perf-profile.children.cycles-pp.count_range_bits
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.idle_cpu
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.update_stats_enqueue_sleeper
      0.00            +0.1        0.07 ± 20%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.00            +0.1        0.07 ± 11%  perf-profile.children.cycles-pp.__list_add_valid
      0.00            +0.1        0.07 ± 20%  perf-profile.children.cycles-pp.__wake_up_common_lock
      0.00            +0.1        0.07 ± 20%  perf-profile.children.cycles-pp.___perf_sw_event
      0.00            +0.1        0.07 ± 11%  perf-profile.children.cycles-pp.newidle_balance
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.blk_mq_start_request
      0.00            +0.1        0.07 ± 11%  perf-profile.children.cycles-pp.stack_access_ok
      0.00            +0.1        0.07 ± 11%  perf-profile.children.cycles-pp.rcu_gp_kthread
      0.00            +0.1        0.07 ± 23%  perf-profile.children.cycles-pp.in_sched_functions
      0.00            +0.1        0.07 ± 17%  perf-profile.children.cycles-pp.btrfs_verify_level_key
      0.00            +0.1        0.07 ± 12%  perf-profile.children.cycles-pp.clean_io_failure
      0.00            +0.1        0.07 ± 17%  perf-profile.children.cycles-pp.timerqueue_add
      0.00            +0.1        0.07 ± 12%  perf-profile.children.cycles-pp.security_file_permission
      0.00            +0.1        0.07 ± 28%  perf-profile.children.cycles-pp.free_extent_buffer
      0.00            +0.1        0.08 ± 16%  perf-profile.children.cycles-pp.get_cpu_device
      0.00            +0.1        0.08 ± 16%  perf-profile.children.cycles-pp.reweight_entity
      0.00            +0.1        0.08 ± 22%  perf-profile.children.cycles-pp.btrfs_comp_cpu_keys
      0.00            +0.1        0.08 ± 12%  perf-profile.children.cycles-pp.blk_mq_get_tag
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.00            +0.1        0.08 ± 12%  perf-profile.children.cycles-pp.__pagevec_lru_add_fn
      0.00            +0.1        0.08 ± 20%  perf-profile.children.cycles-pp.__might_sleep
      0.00            +0.1        0.08 ± 17%  perf-profile.children.cycles-pp.btrfs_bio_counter_sub
      0.00            +0.1        0.08 ± 10%  perf-profile.children.cycles-pp.bio_associate_blkg
      0.00            +0.1        0.08 ± 20%  perf-profile.children.cycles-pp.update_cfs_rq_h_load
      0.00            +0.1        0.08 ± 14%  perf-profile.children.cycles-pp.menu_reflect
      0.00            +0.1        0.08 ± 20%  perf-profile.children.cycles-pp.rmqueue
      0.00            +0.1        0.08 ± 11%  perf-profile.children.cycles-pp.bvec_alloc
      0.00            +0.1        0.08 ± 11%  perf-profile.children.cycles-pp.alloc_extent_state
      0.00            +0.1        0.09 ± 23%  perf-profile.children.cycles-pp.rb_next
      0.00            +0.1        0.09 ±  5%  perf-profile.children.cycles-pp.__unwind_start
      0.00            +0.1        0.09 ± 15%  perf-profile.children.cycles-pp.__blk_mq_alloc_request
      0.00            +0.1        0.09 ± 15%  perf-profile.children.cycles-pp.down_read
      0.00            +0.1        0.09 ±  9%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.00            +0.1        0.09        perf-profile.children.cycles-pp.io_serial_in
      0.00            +0.1        0.09        perf-profile.children.cycles-pp.finish_task_switch
      0.00            +0.1        0.09 ± 15%  perf-profile.children.cycles-pp.kernel_text_address
      0.00            +0.1        0.09 ± 15%  perf-profile.children.cycles-pp.enqueue_hrtimer
      0.00            +0.1        0.09 ± 24%  perf-profile.children.cycles-pp.__x86_indirect_thunk_rax
      0.00            +0.1        0.09 ± 18%  perf-profile.children.cycles-pp.resched_curr
      0.00            +0.1        0.09 ± 13%  perf-profile.children.cycles-pp.orc_find
      0.00            +0.1        0.09 ± 22%  perf-profile.children.cycles-pp.btrfs_get_extent
      0.00            +0.1        0.10 ± 17%  perf-profile.children.cycles-pp.pagevec_lru_move_fn
      0.00            +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.pick_next_entity
      0.00            +0.1        0.10 ± 16%  perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.00            +0.1        0.10 ± 16%  perf-profile.children.cycles-pp.rcu_dynticks_eqs_exit
      0.00            +0.1        0.10 ± 14%  perf-profile.children.cycles-pp.__hrtimer_get_next_event
      0.00            +0.1        0.10 ±  8%  perf-profile.children.cycles-pp.rcu_dynticks_eqs_enter
      0.00            +0.1        0.10 ± 12%  perf-profile.children.cycles-pp.note_gp_changes
      0.00            +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.account_entity_dequeue
      0.00            +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.calc_global_load_tick
      0.00            +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.delayacct_end
      0.00            +0.1        0.11 ±  8%  perf-profile.children.cycles-pp.insert_work
      0.00            +0.1        0.11 ± 26%  perf-profile.children.cycles-pp.crc_104
      0.00            +0.1        0.11 ± 15%  perf-profile.children.cycles-pp.lru_cache_add
      0.00            +0.1        0.11 ± 19%  perf-profile.children.cycles-pp.generic_bin_search
      0.00            +0.1        0.11 ±  7%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.00            +0.1        0.11 ±  8%  perf-profile.children.cycles-pp.free_extent_state
      0.00            +0.1        0.11 ± 29%  perf-profile.children.cycles-pp.crc_42
      0.00            +0.1        0.12 ± 10%  perf-profile.children.cycles-pp.timerqueue_del
      0.00            +0.1        0.12 ± 14%  perf-profile.children.cycles-pp.serial8250_console_putchar
      0.00            +0.1        0.12 ± 18%  perf-profile.children.cycles-pp.wait_for_xmitr
      0.00            +0.1        0.12 ± 11%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.00            +0.1        0.12        perf-profile.children.cycles-pp.__kernel_text_address
      0.00            +0.1        0.12 ± 15%  perf-profile.children.cycles-pp.uart_console_write
      0.00            +0.1        0.12 ± 19%  perf-profile.children.cycles-pp.btrfs_release_path
      0.00            +0.1        0.12 ±  3%  perf-profile.children.cycles-pp.update_curr
      0.00            +0.1        0.13 ±  3%  perf-profile.children.cycles-pp.lookup_ioctx
      0.00            +0.1        0.13 ±  7%  perf-profile.children.cycles-pp._raw_read_lock
      0.00            +0.1        0.13 ± 16%  perf-profile.children.cycles-pp.asm_sysvec_irq_work
      0.00            +0.1        0.13 ± 16%  perf-profile.children.cycles-pp.sysvec_irq_work
      0.00            +0.1        0.13 ± 16%  perf-profile.children.cycles-pp.__sysvec_irq_work
      0.00            +0.1        0.13 ± 16%  perf-profile.children.cycles-pp.irq_work_run
      0.00            +0.1        0.13 ± 16%  perf-profile.children.cycles-pp.irq_work_single
      0.00            +0.1        0.13 ± 16%  perf-profile.children.cycles-pp.printk
      0.00            +0.1        0.13 ± 16%  perf-profile.children.cycles-pp.vprintk_emit
      0.00            +0.1        0.13 ± 16%  perf-profile.children.cycles-pp.console_unlock
      0.00            +0.1        0.13 ± 16%  perf-profile.children.cycles-pp.serial8250_console_write
      0.00            +0.1        0.13 ± 18%  perf-profile.children.cycles-pp.stack_trace_consume_entry_nosched
      0.00            +0.1        0.13 ± 17%  perf-profile.children.cycles-pp.btrfs_free_path
      0.00            +0.1        0.13 ±  7%  perf-profile.children.cycles-pp.find_get_entry
      0.00            +0.1        0.13 ±  3%  perf-profile.children.cycles-pp.__might_fault
      0.00            +0.1        0.13 ± 12%  perf-profile.children.cycles-pp.rcu_core
      0.00            +0.1        0.14 ± 10%  perf-profile.children.cycles-pp.pagecache_get_page
      0.00            +0.1        0.14 ± 10%  perf-profile.children.cycles-pp.irq_work_run_list
      0.00            +0.1        0.14 ± 20%  perf-profile.children.cycles-pp.read_extent_buffer
      0.00            +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.cache_state_if_flags
      0.00            +0.1        0.14 ± 14%  perf-profile.children.cycles-pp.__remove_hrtimer
      0.00            +0.1        0.15 ± 11%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.00            +0.1        0.15 ± 17%  perf-profile.children.cycles-pp.__lookup_extent_mapping
      0.00            +0.1        0.15 ±  8%  perf-profile.children.cycles-pp.mempool_alloc
      0.00            +0.1        0.15 ±  8%  perf-profile.children.cycles-pp.unwind_get_return_address
      0.00            +0.1        0.15        perf-profile.children.cycles-pp.btrfs_root_node
      0.00            +0.2        0.16 ± 15%  perf-profile.children.cycles-pp.check_preempt_curr
      0.00            +0.2        0.16 ± 18%  perf-profile.children.cycles-pp.xas_load
      0.00            +0.2        0.16 ±  7%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.00            +0.2        0.17 ±  7%  perf-profile.children.cycles-pp.aio_read_events
      0.00            +0.2        0.17 ±  7%  perf-profile.children.cycles-pp.rcu_eqs_enter
      0.00            +0.2        0.17 ± 10%  perf-profile.children.cycles-pp.ttwu_do_wakeup
      0.00            +0.2        0.17 ± 12%  perf-profile.children.cycles-pp.__add_to_page_cache_locked
      0.00            +0.2        0.17 ± 14%  perf-profile.children.cycles-pp.account_entity_enqueue
      0.00            +0.2        0.17 ± 13%  perf-profile.children.cycles-pp.btrfs_get_io_geometry
      0.00            +0.2        0.17 ±  5%  perf-profile.children.cycles-pp.read_events
      0.00            +0.2        0.17 ±  2%  perf-profile.children.cycles-pp.bio_alloc_bioset
      0.00            +0.2        0.18 ± 16%  perf-profile.children.cycles-pp.run_local_timers
      0.00            +0.2        0.18 ±  2%  perf-profile.children.cycles-pp.__radix_tree_lookup
      0.00            +0.2        0.18 ± 15%  perf-profile.children.cycles-pp.bio_free
      0.00            +0.2        0.18 ±  7%  perf-profile.children.cycles-pp.btrfs_read_lock_root_node
      0.00            +0.2        0.18 ± 13%  perf-profile.children.cycles-pp.__orc_find
      0.00            +0.2        0.19 ± 17%  perf-profile.children.cycles-pp.btrfs_get_chunk_map
      0.00            +0.2        0.19 ± 15%  perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
      0.00            +0.2        0.19 ±  4%  perf-profile.children.cycles-pp.btrfs_bio_alloc
      0.00            +0.2        0.19 ± 12%  perf-profile.children.cycles-pp.submit_bio_checks
      0.00            +0.2        0.19 ±  2%  perf-profile.children.cycles-pp.update_blocked_averages
      0.00            +0.2        0.19 ± 12%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.00            +0.2        0.20 ±  8%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.00            +0.2        0.20 ±  7%  perf-profile.children.cycles-pp.__etree_search
      0.00            +0.2        0.20 ± 10%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.00            +0.2        0.20 ±  4%  perf-profile.children.cycles-pp.call_cpuidle
      0.00            +0.2        0.20 ± 14%  perf-profile.children.cycles-pp.nvme_queue_rq
      0.00            +0.2        0.21 ±  6%  perf-profile.children.cycles-pp.update_ts_time_stats
      0.00            +0.2        0.21 ±  3%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.00            +0.2        0.21 ±  3%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.00            +0.2        0.21 ± 10%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.00            +0.2        0.22 ±  9%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.00            +0.2        0.22 ±  5%  perf-profile.children.cycles-pp.merge_state
      0.00            +0.2        0.22 ±  3%  perf-profile.children.cycles-pp.submit_extent_page
      0.00            +0.2        0.22 ± 10%  perf-profile.children.cycles-pp.___might_sleep
      0.00            +0.2        0.22 ±  4%  perf-profile.children.cycles-pp.rcu_eqs_exit
      0.00            +0.2        0.23 ±  9%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.00            +0.2        0.23 ± 14%  perf-profile.children.cycles-pp.__blk_mq_try_issue_directly
      0.00            +0.2        0.24 ± 13%  perf-profile.children.cycles-pp.blk_mq_try_issue_directly
      0.00            +0.2        0.24 ± 11%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.00            +0.2        0.24 ± 27%  perf-profile.children.cycles-pp.crc_128
      0.00            +0.3        0.26 ± 10%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.00            +0.3        0.26 ±  3%  perf-profile.children.cycles-pp.do_io_getevents
      0.00            +0.3        0.27 ±  4%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.00            +0.3        0.27 ±  6%  perf-profile.children.cycles-pp.hrtimer_get_next_event
      0.00            +0.3        0.28 ±  5%  perf-profile.children.cycles-pp.find_busiest_group
      0.00            +0.3        0.28 ±  5%  perf-profile.children.cycles-pp.add_to_page_cache_lru
      0.00            +0.3        0.28 ±  2%  perf-profile.children.cycles-pp.__x64_sys_io_getevents
      0.00            +0.3        0.28 ±  5%  perf-profile.children.cycles-pp.__switch_to_asm
      0.00            +0.3        0.28 ± 16%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.00            +0.3        0.29 ± 10%  perf-profile.children.cycles-pp.__irqentry_text_start
      0.00            +0.3        0.29 ±  7%  perf-profile.children.cycles-pp.__switch_to
      0.00            +0.3        0.29 ±  8%  perf-profile.children.cycles-pp.find_extent_buffer
      0.00            +0.3        0.29 ± 10%  perf-profile.children.cycles-pp.__slab_free
      0.00            +0.3        0.30 ± 17%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.00            +0.3        0.30 ± 24%  perf-profile.children.cycles-pp.start_kernel
      0.00            +0.3        0.31 ±  3%  perf-profile.children.cycles-pp.clear_state_bit
      0.00            +0.3        0.33 ± 13%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.00            +0.3        0.33 ± 13%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.00            +0.3        0.33 ±  6%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.00            +0.4        0.36 ±  5%  perf-profile.children.cycles-pp.lock_extent_bits
      0.00            +0.4        0.36 ±  6%  perf-profile.children.cycles-pp.__clear_extent_bit
      0.00            +0.4        0.37 ±  3%  perf-profile.children.cycles-pp.load_balance
      0.00            +0.4        0.40 ± 17%  perf-profile.children.cycles-pp.__btrfs_map_block
      0.00            +0.4        0.40 ±  2%  perf-profile.children.cycles-pp.rcu_idle_exit
      0.00            +0.4        0.40 ±  7%  perf-profile.children.cycles-pp.copyout
      0.00            +0.4        0.41 ±  5%  perf-profile.children.cycles-pp.btrfs_lock_and_flush_ordered_range
      0.00            +0.4        0.43 ±  8%  perf-profile.children.cycles-pp.__do_readpage
      0.00            +0.4        0.43 ±  9%  perf-profile.children.cycles-pp.set_next_entity
      0.00            +0.4        0.44 ±  7%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      0.00            +0.4        0.44 ± 11%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.00            +0.4        0.45 ±  3%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.00            +0.5        0.50 ±  5%  perf-profile.children.cycles-pp.copy_page_to_iter
      0.00            +0.5        0.51 ±  3%  perf-profile.children.cycles-pp.update_load_avg
      0.00            +0.5        0.51 ±  4%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.00            +0.5        0.52 ±  3%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.00            +0.5        0.53 ±  6%  perf-profile.children.cycles-pp.dequeue_entity
      0.00            +0.5        0.54 ± 10%  perf-profile.children.cycles-pp.read_block_for_search
      0.00            +0.6        0.57 ± 11%  perf-profile.children.cycles-pp.page_cache_readahead_unbounded
      0.00            +0.6        0.60 ±  9%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.00            +0.6        0.61 ±  7%  perf-profile.children.cycles-pp.blk_mq_submit_bio
      0.00            +0.6        0.63 ±  3%  perf-profile.children.cycles-pp.native_sched_clock
      0.00            +0.6        0.63 ±  8%  perf-profile.children.cycles-pp.endio_readpage_release_extent
      0.00            +0.6        0.63 ±  9%  perf-profile.children.cycles-pp.read_tsc
      0.00            +0.6        0.65 ±  3%  perf-profile.children.cycles-pp.__set_extent_bit
      0.00            +0.7        0.66 ±  4%  perf-profile.children.cycles-pp.sched_clock
      0.00            +0.7        0.66 ±  2%  perf-profile.children.cycles-pp.update_rq_clock
      0.00            +0.7        0.67 ±  6%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.00            +0.7        0.70 ±  7%  perf-profile.children.cycles-pp.rebalance_domains
      0.00            +0.7        0.71 ±  6%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.00            +0.7        0.72 ± 16%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.00            +0.7        0.73 ±  5%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.00            +0.8        0.83 ±  6%  perf-profile.children.cycles-pp.submit_bio_noacct
      0.00            +0.8        0.84 ±  6%  perf-profile.children.cycles-pp.submit_bio
      0.00            +0.9        0.87 ± 42%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.00            +0.9        0.89 ± 12%  perf-profile.children.cycles-pp.timekeeping_max_deferment
      0.00            +0.9        0.94 ±  7%  perf-profile.children.cycles-pp.io_schedule
      0.00            +1.1        1.05 ± 10%  perf-profile.children.cycles-pp.btrfs_search_slot
      0.00            +1.1        1.05 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.00            +1.1        1.11 ±  9%  perf-profile.children.cycles-pp.btrfs_lookup_csum
      0.00            +1.1        1.14 ±  6%  perf-profile.children.cycles-pp.unwind_next_frame
      0.00            +1.1        1.14 ±  7%  perf-profile.children.cycles-pp.__lock_page_killable
      0.00            +1.2        1.19 ±  5%  perf-profile.children.cycles-pp.__softirqentry_text_start
      0.00            +1.2        1.20 ±  5%  perf-profile.children.cycles-pp.do_softirq_own_stack
      0.00            +1.2        1.24 ±  3%  perf-profile.children.cycles-pp.schedule_idle
      0.00            +1.4        1.38 ± 22%  perf-profile.children.cycles-pp.tick_irq_enter
      0.00            +1.4        1.43 ±  9%  perf-profile.children.cycles-pp.btrfs_map_bio
      0.00            +1.4        1.45 ±  5%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.00            +1.5        1.52 ±  9%  perf-profile.children.cycles-pp.btrfs_lookup_bio_sums
      0.00            +1.5        1.53 ±  6%  perf-profile.children.cycles-pp.arch_stack_walk
      0.00            +1.6        1.55 ±  5%  perf-profile.children.cycles-pp.schedule
      0.00            +1.6        1.57 ± 20%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.00            +1.6        1.59 ±  9%  perf-profile.children.cycles-pp.clockevents_program_event
      0.00            +1.7        1.74 ±  7%  perf-profile.children.cycles-pp.__queue_work
      0.00            +1.7        1.74 ± 12%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.00            +1.8        1.78 ±  7%  perf-profile.children.cycles-pp.queue_work_on
      0.00            +1.8        1.85 ±  6%  perf-profile.children.cycles-pp.stack_trace_save_tsk
      0.00            +1.9        1.90 ±  6%  perf-profile.children.cycles-pp.btrfs_end_bio
      0.00            +2.0        2.04 ±  7%  perf-profile.children.cycles-pp.blk_update_request
      0.00            +2.1        2.12 ±  6%  perf-profile.children.cycles-pp.blk_mq_end_request
      0.00            +2.2        2.20 ±  6%  perf-profile.children.cycles-pp.__account_scheduler_latency
      0.00            +2.3        2.27 ±  6%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.00            +2.4        2.41 ±  4%  perf-profile.children.cycles-pp.nvme_irq
      0.00            +2.4        2.42 ±  4%  perf-profile.children.cycles-pp.__handle_irq_event_percpu
      0.00            +2.5        2.51 ±  4%  perf-profile.children.cycles-pp.handle_irq_event_percpu
      0.00            +2.6        2.65 ±  4%  perf-profile.children.cycles-pp.handle_irq_event
      0.00            +2.7        2.74 ±  4%  perf-profile.children.cycles-pp.__sched_text_start
      0.00            +2.7        2.75 ±  4%  perf-profile.children.cycles-pp.handle_edge_irq
      0.00            +2.8        2.84 ±  7%  perf-profile.children.cycles-pp.enqueue_entity
      0.00            +2.9        2.88 ±  6%  perf-profile.children.cycles-pp.wake_page_function
      0.00            +2.9        2.95 ±  4%  perf-profile.children.cycles-pp.common_interrupt
      0.00            +3.0        2.98 ±  7%  perf-profile.children.cycles-pp.__wake_up_common
      0.00            +3.0        2.98 ±  4%  perf-profile.children.cycles-pp.asm_common_interrupt
      0.00            +3.0        3.04 ±  9%  perf-profile.children.cycles-pp.btrfs_submit_bio_hook
      0.00            +3.0        3.05 ±  7%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.00            +3.1        3.06 ±  9%  perf-profile.children.cycles-pp.submit_one_bio
      0.00            +3.1        3.06 ±  7%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.00            +3.2        3.15 ±  7%  perf-profile.children.cycles-pp.wake_up_page_bit
      0.00            +3.4        3.39 ± 21%  perf-profile.children.cycles-pp.poll_idle
      0.00            +3.8        3.79 ± 20%  perf-profile.children.cycles-pp.ktime_get
      0.00            +3.9        3.93 ±  7%  perf-profile.children.cycles-pp.extent_read_full_page
      0.00            +4.1        4.12 ±  7%  perf-profile.children.cycles-pp.end_bio_extent_readpage
      0.00            +4.4        4.41 ±  8%  perf-profile.children.cycles-pp.end_workqueue_fn
      0.00            +4.5        4.50 ±  6%  perf-profile.children.cycles-pp.try_to_wake_up
      0.00            +4.5        4.51 ±  8%  perf-profile.children.cycles-pp.btrfs_work_helper
      1.00 ±173%      +4.9        5.89 ± 11%  perf-profile.children.cycles-pp.hrtimer_interrupt
      1.00 ±173%      +5.0        5.98 ± 10%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.00            +5.3        5.32 ±  8%  perf-profile.children.cycles-pp.process_one_work
      0.00            +6.2        6.23 ±  8%  perf-profile.children.cycles-pp.worker_thread
      0.00            +6.5        6.54 ±  4%  perf-profile.children.cycles-pp.ret_from_fork
      0.00            +6.5        6.54 ±  4%  perf-profile.children.cycles-pp.kthread
      0.00            +6.7        6.71 ±  7%  perf-profile.children.cycles-pp.generic_file_buffered_read
      0.00            +6.9        6.91 ±  7%  perf-profile.children.cycles-pp.aio_read
      0.00            +7.0        7.00 ±  7%  perf-profile.children.cycles-pp.__io_submit_one
      0.00            +7.3        7.28 ±  6%  perf-profile.children.cycles-pp.io_submit_one
      0.00            +7.4        7.39 ±  6%  perf-profile.children.cycles-pp.__x64_sys_io_submit
      1.00 ±173%      +8.7        9.74 ± 11%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      1.00 ±173%      +9.1       10.08 ±  5%  perf-profile.children.cycles-pp.asm_call_on_stack
      0.00           +10.6       10.64 ± 13%  perf-profile.children.cycles-pp.menu_select
      1.00 ±173%     +12.7       13.71 ±  6%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     44.12 ± 35%     +25.4       69.54 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter_state
     44.12 ± 35%     +25.5       69.58 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter
     44.12 ± 35%     +38.6       82.76        perf-profile.children.cycles-pp.start_secondary
     44.12 ± 35%     +38.9       83.04        perf-profile.children.cycles-pp.do_idle
     44.12 ± 35%     +38.9       83.06        perf-profile.children.cycles-pp.secondary_startup_64
     44.12 ± 35%     +38.9       83.06        perf-profile.children.cycles-pp.cpu_startup_entry
     10.29 ± 67%     -10.3        0.00        perf-profile.self.cycles-pp.smp_call_function_single
      5.57 ±107%      -5.6        0.00        perf-profile.self.cycles-pp.page_remove_rmap
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.submit_bio_checks
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.tick_nohz_tick_stopped
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.perf_event_task_tick
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.__sysvec_apic_timer_interrupt
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.tick_irq_enter
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.update_stats_enqueue_sleeper
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.__blk_queue_split
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.cpus_share_cache
      0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.stack_access_ok
      0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.cpuidle_not_available
      0.00            +0.1        0.06 ± 16%  perf-profile.self.cycles-pp._find_next_bit
      0.00            +0.1        0.06 ± 16%  perf-profile.self.cycles-pp.available_idle_cpu
      0.00            +0.1        0.06 ± 13%  perf-profile.self.cycles-pp.finish_task_switch
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.lookup_ioctx
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.irqtime_account_process_tick
      0.00            +0.1        0.06 ± 13%  perf-profile.self.cycles-pp.sched_clock_cpu
      0.00            +0.1        0.06 ± 13%  perf-profile.self.cycles-pp.check_preempt_curr
      0.00            +0.1        0.06 ± 13%  perf-profile.self.cycles-pp.update_cfs_group
      0.00            +0.1        0.06 ± 19%  perf-profile.self.cycles-pp.menu_reflect
      0.00            +0.1        0.06 ± 19%  perf-profile.self.cycles-pp.tick_check_broadcast_expired
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.stack_trace_consume_entry_nosched
      0.00            +0.1        0.06 ± 19%  perf-profile.self.cycles-pp.generic_bin_search
      0.00            +0.1        0.07 ± 25%  perf-profile.self.cycles-pp.btrfs_comp_cpu_keys
      0.00            +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.idle_cpu
      0.00            +0.1        0.07 ± 20%  perf-profile.self.cycles-pp.__might_sleep
      0.00            +0.1        0.07 ± 20%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.00            +0.1        0.07 ± 11%  perf-profile.self.cycles-pp.__list_add_valid
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.rcu_eqs_enter
      0.00            +0.1        0.07 ± 11%  perf-profile.self.cycles-pp.__unwind_start
      0.00            +0.1        0.07 ± 11%  perf-profile.self.cycles-pp.get_next_timer_interrupt
      0.00            +0.1        0.07 ± 17%  perf-profile.self.cycles-pp.get_cpu_device
      0.00            +0.1        0.08 ± 16%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.00            +0.1        0.08 ± 16%  perf-profile.self.cycles-pp.reweight_entity
      0.00            +0.1        0.08 ± 26%  perf-profile.self.cycles-pp.rb_next
      0.00            +0.1        0.08 ± 12%  perf-profile.self.cycles-pp.enqueue_entity
      0.00            +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.00            +0.1        0.08 ± 22%  perf-profile.self.cycles-pp.__hrtimer_get_next_event
      0.00            +0.1        0.08 ± 17%  perf-profile.self.cycles-pp.down_read
      0.00            +0.1        0.08        perf-profile.self.cycles-pp.tick_sched_timer
      0.00            +0.1        0.08 ± 20%  perf-profile.self.cycles-pp.update_cfs_rq_h_load
      0.00            +0.1        0.08 ± 10%  perf-profile.self.cycles-pp.io_submit_one
      0.00            +0.1        0.08 ± 10%  perf-profile.self.cycles-pp.cpuidle_governor_latency_req
      0.00            +0.1        0.08 ± 39%  perf-profile.self.cycles-pp.btrfs_search_slot
      0.00            +0.1        0.08 ± 11%  perf-profile.self.cycles-pp.__wake_up_common
      0.00            +0.1        0.08 ±  5%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.00            +0.1        0.08 ±  5%  perf-profile.self.cycles-pp.__do_readpage
      0.00            +0.1        0.09 ± 10%  perf-profile.self.cycles-pp.update_curr
      0.00            +0.1        0.09 ± 14%  perf-profile.self.cycles-pp.__softirqentry_text_start
      0.00            +0.1        0.09        perf-profile.self.cycles-pp.pick_next_entity
      0.00            +0.1        0.09 ±  9%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.00            +0.1        0.09        perf-profile.self.cycles-pp.io_serial_in
      0.00            +0.1        0.09 ± 13%  perf-profile.self.cycles-pp.rcu_dynticks_eqs_exit
      0.00            +0.1        0.09 ± 10%  perf-profile.self.cycles-pp.worker_thread
      0.00            +0.1        0.09 ±  5%  perf-profile.self.cycles-pp.insert_work
      0.00            +0.1        0.09 ± 18%  perf-profile.self.cycles-pp.resched_curr
      0.00            +0.1        0.09 ± 13%  perf-profile.self.cycles-pp.btrfs_lookup_bio_sums
      0.00            +0.1        0.09 ± 13%  perf-profile.self.cycles-pp.orc_find
      0.00            +0.1        0.10 ±  4%  perf-profile.self.cycles-pp.account_entity_dequeue
      0.00            +0.1        0.10 ±  4%  perf-profile.self.cycles-pp.rcu_dynticks_eqs_enter
      0.00            +0.1        0.10 ± 16%  perf-profile.self.cycles-pp.__queue_work
      0.00            +0.1        0.10 ±  4%  perf-profile.self.cycles-pp.calc_global_load_tick
      0.00            +0.1        0.11 ± 26%  perf-profile.self.cycles-pp.crc_104
      0.00            +0.1        0.11 ±  4%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.00            +0.1        0.11 ± 29%  perf-profile.self.cycles-pp.crc_42
      0.00            +0.1        0.11 ±  8%  perf-profile.self.cycles-pp.free_extent_state
      0.00            +0.1        0.11 ±  4%  perf-profile.self.cycles-pp.__hrtimer_run_queues
      0.00            +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.rcu_eqs_exit
      0.00            +0.1        0.12 ± 14%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.00            +0.1        0.12 ±  6%  perf-profile.self.cycles-pp.hrtimer_interrupt
      0.00            +0.1        0.12 ±  6%  perf-profile.self.cycles-pp.rebalance_domains
      0.00            +0.1        0.12 ± 11%  perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.00            +0.1        0.12 ± 11%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.00            +0.1        0.12 ± 10%  perf-profile.self.cycles-pp._raw_read_lock
      0.00            +0.1        0.14 ± 24%  perf-profile.self.cycles-pp.xas_load
      0.00            +0.1        0.14 ± 19%  perf-profile.self.cycles-pp.read_extent_buffer
      0.00            +0.1        0.14 ± 15%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.00            +0.1        0.14 ±  5%  perf-profile.self.cycles-pp.cache_state_if_flags
      0.00            +0.1        0.14 ± 60%  perf-profile.self.cycles-pp.nvme_irq
      0.00            +0.1        0.15 ± 17%  perf-profile.self.cycles-pp.__lookup_extent_mapping
      0.00            +0.1        0.15 ±  3%  perf-profile.self.cycles-pp.btrfs_root_node
      0.00            +0.2        0.15 ± 16%  perf-profile.self.cycles-pp.kmem_cache_free
      0.00            +0.2        0.16 ± 21%  perf-profile.self.cycles-pp.__radix_tree_lookup
      0.00            +0.2        0.16 ± 10%  perf-profile.self.cycles-pp.account_entity_enqueue
      0.00            +0.2        0.16 ± 17%  perf-profile.self.cycles-pp.run_local_timers
      0.00            +0.2        0.16 ±  5%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.00            +0.2        0.17 ± 12%  perf-profile.self.cycles-pp.__account_scheduler_latency
      0.00            +0.2        0.17 ± 20%  perf-profile.self.cycles-pp.perf_mux_hrtimer_handler
      0.00            +0.2        0.17 ±  4%  perf-profile.self.cycles-pp.rcu_idle_exit
      0.00            +0.2        0.17 ± 19%  perf-profile.self.cycles-pp.tsc_verify_tsc_adjust
      0.00            +0.2        0.17 ± 19%  perf-profile.self.cycles-pp.process_one_work
      0.00            +0.2        0.17 ± 11%  perf-profile.self.cycles-pp.rcu_sched_clock_irq
      0.00            +0.2        0.18 ± 13%  perf-profile.self.cycles-pp.__orc_find
      0.00            +0.2        0.19 ± 10%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.00            +0.2        0.19 ±  4%  perf-profile.self.cycles-pp.call_cpuidle
      0.00            +0.2        0.19 ± 17%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.00            +0.2        0.19 ± 12%  perf-profile.self.cycles-pp.__lock_page_killable
      0.00            +0.2        0.19 ±  8%  perf-profile.self.cycles-pp.__etree_search
      0.00            +0.2        0.20 ±  8%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.00            +0.2        0.20 ± 13%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.00            +0.2        0.20 ±  6%  perf-profile.self.cycles-pp.update_load_avg
      0.00            +0.2        0.20 ±  2%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.00            +0.2        0.20 ±  2%  perf-profile.self.cycles-pp.try_to_wake_up
      0.00            +0.2        0.20 ±  4%  perf-profile.self.cycles-pp.end_bio_extent_readpage
      0.00            +0.2        0.21 ±  9%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.00            +0.2        0.21 ± 11%  perf-profile.self.cycles-pp.nr_iowait_cpu
      0.00            +0.2        0.22 ±  9%  perf-profile.self.cycles-pp.___might_sleep
      0.00            +0.2        0.23 ± 25%  perf-profile.self.cycles-pp.crc_128
      0.00            +0.2        0.24 ± 11%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.00            +0.3        0.28 ±  8%  perf-profile.self.cycles-pp.stack_trace_save_tsk
      0.00            +0.3        0.28 ± 10%  perf-profile.self.cycles-pp.__slab_free
      0.00            +0.3        0.28 ±  8%  perf-profile.self.cycles-pp.__switch_to
      0.00            +0.3        0.28 ±  5%  perf-profile.self.cycles-pp.__switch_to_asm
      0.00            +0.3        0.28 ± 16%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.00            +0.3        0.32 ± 17%  perf-profile.self.cycles-pp.generic_file_buffered_read
      0.00            +0.3        0.33 ± 13%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.00            +0.3        0.33 ± 10%  perf-profile.self.cycles-pp.set_next_entity
      0.00            +0.3        0.34 ± 37%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.00            +0.4        0.40 ±  4%  perf-profile.self.cycles-pp.update_rq_clock
      0.00            +0.4        0.43 ±  8%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      0.00            +0.5        0.46 ±  3%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.00            +0.5        0.51 ±  4%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.00            +0.5        0.54        perf-profile.self.cycles-pp.__sched_text_start
      0.00            +0.5        0.54 ±  3%  perf-profile.self.cycles-pp.do_idle
      0.00            +0.6        0.61 ±  2%  perf-profile.self.cycles-pp.native_sched_clock
      0.00            +0.6        0.62 ±  8%  perf-profile.self.cycles-pp.read_tsc
      0.00            +0.8        0.79 ±  5%  perf-profile.self.cycles-pp.unwind_next_frame
      0.00            +0.8        0.79 ± 46%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.00            +0.9        0.89 ± 11%  perf-profile.self.cycles-pp.timekeeping_max_deferment
      0.00            +1.0        1.03 ±  5%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.00            +3.2        3.22 ± 22%  perf-profile.self.cycles-pp.poll_idle
      0.00            +3.2        3.23 ± 24%  perf-profile.self.cycles-pp.ktime_get
      0.00            +7.3        7.31 ± 28%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.00            +8.1        8.09 ± 16%  perf-profile.self.cycles-pp.menu_select



***************************************************************************************************
lkp-csl-2sp6: 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 256G memory
=========================================================================================
bs/compiler/cpufreq_governor/disk/fs/ioengine/kconfig/nr_task/rootfs/runtime/rw/tbox_group/test_size/testcase/time_based/ucode:
  2M/gcc-9/performance/2pmem/btrfs/sync/x86_64-rhel-8.3/50%/debian-10.4-x86_64-20200603.cgz/200s/randread/lkp-csl-2sp6/100G/fio-basic/tb/0x5002f01

commit: 
  42d3e2d041 ("virtiofs: calculate number of scatter-gather elements accurately")
  51ac7c8929 ("fuse: fix panic in __readahead_batch()")

42d3e2d041f08d1f 51ac7c8929fb43cdb4d046674ba 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.01 ± 26%      -0.0        0.00        fio.latency_100ms%
     46.79           -46.8        0.04 ±112%  fio.latency_10ms%
      2.69 ±  2%     +96.9       99.63        fio.latency_20ms%
      7.00 ±  2%      -7.0        0.00        fio.latency_2ms%
     38.06           -38.1        0.00        fio.latency_4ms%
      5.45            -5.1        0.33 ±100%  fio.latency_50ms%
     15254           -62.1%       5788        fio.read_bw_MBps
   8339456          +120.8%   18415616 ±  4%  fio.read_clat_90%_us
  20709376           -10.4%   18546688 ±  4%  fio.read_clat_95%_us
  27459584           -30.8%   19005440 ±  3%  fio.read_clat_99%_us
   5642419          +189.9%   16357757        fio.read_clat_mean_us
   5325837           -72.4%    1472504 ± 25%  fio.read_clat_stddev
      7627           -62.1%       2894        fio.read_iops
 6.255e+09           -62.1%  2.371e+09        fio.time.file_system_inputs
    274773           -88.0%      32890 ±  2%  fio.time.involuntary_context_switches
      4622           -17.5%       3813 ±  2%  fio.time.percent_of_cpu_this_job_got
      9293           -17.5%       7666 ±  2%  fio.time.system_time
     23.33 ±  2%     -50.6%      11.52        fio.time.user_time
  37557268 ±  6%    +683.0%  2.941e+08        fio.time.voluntary_context_switches
   1527165           -62.1%     578942        fio.workload
     18676           -12.7%      16309        uptime.idle
     38.00           -13.4%      32.90 ±  4%  iostat.cpu.idle
     61.79            +8.4%      66.96 ±  2%  iostat.cpu.system
     17238 ± 22%    +207.3%      52972 ±  8%  meminfo.CmaFree
    207430            -9.8%     187197        meminfo.KReclaimable
   1478550 ±  3%    +234.6%    4947809 ± 13%  meminfo.MemFree
    207430            -9.8%     187197        meminfo.SReclaimable
     37.40            -5.1       32.28 ±  4%  mpstat.cpu.all.idle%
      1.34            -0.4        0.95        mpstat.cpu.all.irq%
      0.14 ±  2%      -0.0        0.12        mpstat.cpu.all.soft%
     60.92            +5.6       66.53 ±  2%  mpstat.cpu.all.sys%
      0.14            -0.1        0.07        mpstat.cpu.all.usr%
  19783200 ±  2%     -10.0%   17805952 ±  3%  numa-meminfo.node0.Inactive(file)
    108725           -12.6%      95009 ±  3%  numa-meminfo.node0.KReclaimable
    808531 ±  6%    +221.0%    2595261 ± 14%  numa-meminfo.node0.MemFree
    108725           -12.6%      95009 ±  3%  numa-meminfo.node0.SReclaimable
    673448 ±  3%    +247.6%    2341230 ± 18%  numa-meminfo.node1.MemFree
  66938240 ±  6%   +1396.6%  1.002e+09 ±  8%  cpuidle.C1.time
  10805756 ±  6%   +1027.9%  1.219e+08 ±  3%  cpuidle.C1.usage
 6.258e+09 ±  7%     -41.5%   3.66e+09 ±  9%  cpuidle.C1E.time
  23568776 ±  2%    +518.8%  1.458e+08        cpuidle.C1E.usage
  64773816 ±  7%   +1041.1%  7.391e+08 ±  3%  cpuidle.POLL.time
  19977024 ±  7%    +909.9%  2.018e+08 ±  3%  cpuidle.POLL.usage
     42013           +34.1%      56344 ±  3%  slabinfo.Acpi-State.active_objs
    883.25           +32.4%       1169 ±  5%  slabinfo.Acpi-State.active_slabs
     45070           +32.4%      59664 ±  5%  slabinfo.Acpi-State.num_objs
    883.25           +32.4%       1169 ±  5%  slabinfo.Acpi-State.num_slabs
      4716           -11.4%       4177        slabinfo.radix_tree_node.active_slabs
    263722           -11.3%     233941        slabinfo.radix_tree_node.num_objs
      4716           -11.4%       4177        slabinfo.radix_tree_node.num_slabs
     37.75           -13.9%      32.50 ±  5%  vmstat.cpu.id
     61.00            +9.0%      66.50 ±  2%  vmstat.cpu.sy
  15256755           -61.9%    5812130        vmstat.io.bi
   1504822 ±  2%    +228.3%    4940120 ± 13%  vmstat.memory.free
     58.50            +9.8%      64.25 ±  2%  vmstat.procs.r
    398141 ±  5%    +711.0%    3228775        vmstat.system.cs
    230478           +28.4%     295957        vmstat.system.in
 3.458e+08           -67.8%  1.114e+08 ±  3%  numa-numastat.node0.local_node
  54017296 ±  7%     -30.4%   37614645 ±  8%  numa-numastat.node0.numa_foreign
 3.458e+08           -67.8%  1.114e+08 ±  3%  numa-numastat.node0.numa_hit
  35882335 ± 16%     -61.9%   13670664 ± 31%  numa-numastat.node0.numa_miss
  35890142 ± 16%     -61.9%   13678445 ± 31%  numa-numastat.node0.other_node
  3.47e+08           -61.2%  1.346e+08 ±  3%  numa-numastat.node1.local_node
  35882335 ± 16%     -61.9%   13670664 ± 31%  numa-numastat.node1.numa_foreign
 3.471e+08           -61.2%  1.346e+08 ±  3%  numa-numastat.node1.numa_hit
  54017296 ±  7%     -30.4%   37614645 ±  8%  numa-numastat.node1.numa_miss
  54040855 ±  7%     -30.4%   37638252 ±  8%  numa-numastat.node1.other_node
    203512 ±  6%    +217.9%     646960 ± 14%  numa-vmstat.node0.nr_free_pages
   4944635 ±  2%     -10.0%    4452470 ±  3%  numa-vmstat.node0.nr_inactive_file
    171.00 ±  5%     -94.6%       9.25 ± 20%  numa-vmstat.node0.nr_isolated_file
     27184           -12.6%      23756 ±  3%  numa-vmstat.node0.nr_slab_reclaimable
   4944298 ±  2%      -9.9%    4453036 ±  3%  numa-vmstat.node0.nr_zone_inactive_file
  26460773 ±  5%     -30.7%   18334786 ±  8%  numa-vmstat.node0.numa_foreign
 1.927e+08 ±  5%     -60.4%   76392920 ± 13%  numa-vmstat.node0.numa_hit
 1.927e+08 ±  5%     -60.4%   76350772 ± 13%  numa-vmstat.node0.numa_local
  17691943 ± 21%     -64.4%    6296818 ± 26%  numa-vmstat.node0.numa_miss
  17736906 ± 21%     -64.3%    6339002 ± 27%  numa-vmstat.node0.numa_other
      4329 ± 20%    +201.8%      13065 ±  6%  numa-vmstat.node1.nr_free_cma
    169561 ±  2%    +245.5%     585916 ± 18%  numa-vmstat.node1.nr_free_pages
    155.75 ±  4%     -88.3%      18.25 ± 24%  numa-vmstat.node1.nr_isolated_file
  17693047 ± 21%     -64.4%    6296954 ± 26%  numa-vmstat.node1.numa_foreign
 1.807e+08 ±  5%     -58.7%   74640242 ± 15%  numa-vmstat.node1.numa_hit
 1.806e+08 ±  5%     -58.7%   74503831 ± 15%  numa-vmstat.node1.numa_local
  26462189 ±  5%     -30.7%   18335161 ±  8%  numa-vmstat.node1.numa_miss
  26595681 ±  5%     -30.5%   18471597 ±  7%  numa-vmstat.node1.numa_other
     18339           +69.4%      31060 ±  6%  numa-vmstat.node1.workingset_nodes
    117130          -100.0%      10.00 ±127%  proc-vmstat.allocstall_movable
   2081217 ± 27%     -77.6%     466219 ± 27%  proc-vmstat.compact_daemon_free_scanned
    963367 ± 16%     -27.0%     702980 ± 20%  proc-vmstat.compact_daemon_migrate_scanned
   6012168 ± 22%    +483.7%   35093462 ± 22%  proc-vmstat.compact_free_scanned
   1240761 ± 24%    +792.1%   11069184 ± 21%  proc-vmstat.compact_isolated
   1572266 ± 18%    +321.6%    6628003 ± 20%  proc-vmstat.compact_migrate_scanned
     19.50 ± 22%    +666.7%     149.50 ±  9%  proc-vmstat.kswapd_high_wmark_hit_quickly
  10625223            -7.9%    9791106        proc-vmstat.nr_file_pages
      4345 ± 21%    +202.8%      13158 ±  7%  proc-vmstat.nr_free_cma
    371486 ±  3%    +232.1%    1233873 ± 14%  proc-vmstat.nr_free_pages
  10054343            -8.3%    9218176        proc-vmstat.nr_inactive_file
    328.50           -91.8%      27.00 ±  9%  proc-vmstat.nr_isolated_file
     51844            -9.7%      46796        proc-vmstat.nr_slab_reclaimable
  10054114            -8.3%    9219485        proc-vmstat.nr_zone_inactive_file
  89852061 ±  2%     -43.1%   51158845 ± 13%  proc-vmstat.numa_foreign
      6915 ± 22%     -54.4%       3153 ± 69%  proc-vmstat.numa_hint_faults_local
 6.924e+08           -64.5%  2.455e+08 ±  3%  proc-vmstat.numa_hit
 6.924e+08           -64.5%  2.455e+08 ±  3%  proc-vmstat.numa_local
  89852061 ±  2%     -43.1%   51158845 ± 13%  proc-vmstat.numa_miss
  89883579 ±  2%     -43.0%   51190334 ± 13%  proc-vmstat.numa_other
    386931 ±  9%     -13.0%     336724        proc-vmstat.numa_pte_updates
  27758562           -71.3%    7959471 ±  5%  proc-vmstat.pgalloc_dma32
 7.552e+08           -61.6%  2.897e+08        proc-vmstat.pgalloc_normal
 7.746e+08           -62.2%  2.932e+08        proc-vmstat.pgfree
    644954 ± 23%    +761.5%    5556255 ± 21%  proc-vmstat.pgmigrate_success
 3.128e+09           -62.1%  1.185e+09        proc-vmstat.pgpgin
      3713 ±  5%     -89.7%     381.75 ± 34%  proc-vmstat.pgrotated
 2.972e+08          -100.0%      20915 ±149%  proc-vmstat.pgscan_direct
 3.721e+08           -63.0%  1.375e+08 ±  4%  proc-vmstat.pgscan_file
  74853369 ±  5%     +83.7%  1.375e+08 ±  4%  proc-vmstat.pgscan_kswapd
 2.972e+08          -100.0%      20915 ±149%  proc-vmstat.pgsteal_direct
  3.72e+08           -63.0%  1.375e+08 ±  4%  proc-vmstat.pgsteal_file
  74850877 ±  5%     +83.7%  1.375e+08 ±  4%  proc-vmstat.pgsteal_kswapd
     53455 ±  6%     -18.1%      43762 ±  4%  proc-vmstat.slabs_scanned
     40864           +32.8%      54276 ±  6%  proc-vmstat.workingset_nodes
    421.17 ± 55%    +896.4%       4196 ± 22%  sched_debug.cfs_rq:/.MIN_vruntime.avg
     34045 ± 61%    +153.6%      86338 ±  9%  sched_debug.cfs_rq:/.MIN_vruntime.max
      3710 ± 57%    +370.6%      17463 ± 12%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
     41182 ± 19%     +28.6%      52980 ± 18%  sched_debug.cfs_rq:/.exec_clock.avg
     49145 ± 18%     +20.6%      59264 ± 18%  sched_debug.cfs_rq:/.exec_clock.max
     33186 ± 20%     +33.9%      44446 ± 18%  sched_debug.cfs_rq:/.exec_clock.min
    474771 ±  5%     +15.1%     546356 ±  3%  sched_debug.cfs_rq:/.load.avg
    399.85 ±  6%     +15.6%     462.32 ±  4%  sched_debug.cfs_rq:/.load_avg.avg
    293.40 ±  3%     -21.0%     231.83 ± 10%  sched_debug.cfs_rq:/.load_avg.stddev
    421.17 ± 55%    +896.4%       4196 ± 22%  sched_debug.cfs_rq:/.max_vruntime.avg
     34045 ± 61%    +153.6%      86338 ±  9%  sched_debug.cfs_rq:/.max_vruntime.max
      3710 ± 57%    +370.6%      17463 ± 12%  sched_debug.cfs_rq:/.max_vruntime.stddev
     68758 ± 15%     +17.4%      80717 ± 12%  sched_debug.cfs_rq:/.min_vruntime.avg
     56638 ± 17%     +20.4%      68183 ± 11%  sched_debug.cfs_rq:/.min_vruntime.min
      0.50 ±  5%     +15.8%       0.58 ±  2%  sched_debug.cfs_rq:/.nr_running.avg
    485.77 ±  5%     +15.0%     558.65        sched_debug.cfs_rq:/.runnable_avg.avg
    344.21 ±  3%     -23.6%     263.09 ±  3%  sched_debug.cfs_rq:/.runnable_avg.stddev
    484.50 ±  5%     +15.2%     557.94        sched_debug.cfs_rq:/.util_avg.avg
    343.23 ±  2%     -23.4%     262.87 ±  3%  sched_debug.cfs_rq:/.util_avg.stddev
    327.50 ±  6%     +16.9%     382.79 ±  2%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    293.32 ±  4%     -13.5%     253.86 ±  2%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    474126 ±  2%     -42.1%     274683 ± 13%  sched_debug.cpu.avg_idle.avg
      1293 ±  8%     +89.7%       2453 ± 11%  sched_debug.cpu.avg_idle.min
    382291           -23.8%     291251 ±  2%  sched_debug.cpu.avg_idle.stddev
      1159 ±  6%     -17.1%     961.24 ±  8%  sched_debug.cpu.curr->pid.avg
      0.00 ±  4%     -18.7%       0.00 ±  7%  sched_debug.cpu.next_balance.stddev
    424212 ± 10%    +497.1%    2532998 ± 20%  sched_debug.cpu.nr_switches.avg
    609672 ±  9%    +436.5%    3271095 ± 16%  sched_debug.cpu.nr_switches.max
    276162 ± 14%    +542.4%    1774102 ± 23%  sched_debug.cpu.nr_switches.min
     66505 ± 14%    +333.5%     288330 ±  9%  sched_debug.cpu.nr_switches.stddev
      0.01 ± 35%    +896.9%       0.07 ± 24%  sched_debug.cpu.nr_uninterruptible.avg
    422579 ± 10%    +499.5%    2533431 ± 20%  sched_debug.cpu.sched_count.avg
    603336 ± 10%    +441.5%    3266920 ± 16%  sched_debug.cpu.sched_count.max
    275302 ± 14%    +545.3%    1776633 ± 23%  sched_debug.cpu.sched_count.min
     65911 ± 14%    +336.0%     287374 ±  9%  sched_debug.cpu.sched_count.stddev
    210020 ± 10%    +502.4%    1265125 ± 20%  sched_debug.cpu.sched_goidle.avg
    300105 ± 10%    +443.9%    1632378 ± 16%  sched_debug.cpu.sched_goidle.max
    136685 ± 14%    +548.4%     886285 ± 23%  sched_debug.cpu.sched_goidle.min
     32829 ± 14%    +338.3%     143888 ±  9%  sched_debug.cpu.sched_goidle.stddev
    211462 ± 10%    +499.6%    1267948 ± 20%  sched_debug.cpu.ttwu_count.avg
    331370 ±  8%    +486.7%    1944040 ± 14%  sched_debug.cpu.ttwu_count.max
    107092 ± 13%    +554.7%     701140 ± 24%  sched_debug.cpu.ttwu_count.min
     49072 ± 15%    +377.4%     234248 ±  4%  sched_debug.cpu.ttwu_count.stddev
      1164 ± 20%     -56.4%     508.01 ± 19%  sched_debug.cpu.ttwu_local.avg
      1696 ± 18%     -24.0%       1289 ± 15%  sched_debug.cpu.ttwu_local.max
    788.77 ± 24%     -74.1%     204.65 ± 27%  sched_debug.cpu.ttwu_local.min
    166.30 ± 13%     +36.4%     226.91 ± 17%  sched_debug.cpu.ttwu_local.stddev
     30.09           -40.5%      17.89        perf-stat.i.MPKI
 9.435e+09           +36.7%   1.29e+10        perf-stat.i.branch-instructions
      0.43            +0.2        0.59        perf-stat.i.branch-miss-rate%
  39243230           +91.8%   75279647        perf-stat.i.branch-misses
     67.47           -42.2       25.22        perf-stat.i.cache-miss-rate%
 1.029e+09           -73.1%  2.772e+08        perf-stat.i.cache-misses
 1.521e+09           -27.8%  1.099e+09        perf-stat.i.cache-references
    403537 ±  5%    +708.2%    3261327        perf-stat.i.context-switches
      3.37            -2.7%       3.28        perf-stat.i.cpi
  1.69e+11           +18.8%  2.008e+11        perf-stat.i.cpu-cycles
    260.98           +34.6%     351.32 ±  7%  perf-stat.i.cpu-migrations
    173.57          +321.7%     732.04        perf-stat.i.cycles-between-cache-misses
  1.35e+10           +19.9%  1.618e+10        perf-stat.i.dTLB-loads
      0.03 ±  2%      -0.0        0.01 ± 35%  perf-stat.i.dTLB-store-miss-rate%
   1876487 ±  2%     -48.6%     963835 ± 38%  perf-stat.i.dTLB-store-misses
  6.71e+09           +17.3%  7.874e+09        perf-stat.i.dTLB-stores
     56.48           -36.8       19.70 ±  4%  perf-stat.i.iTLB-load-miss-rate%
   4669576 ±  2%    +351.3%   21075349 ±  4%  perf-stat.i.iTLB-load-misses
   3633331         +2300.6%   87221546        perf-stat.i.iTLB-loads
 5.038e+10           +21.5%   6.12e+10        perf-stat.i.instructions
     11166 ±  2%     -74.0%       2901 ±  4%  perf-stat.i.instructions-per-iTLB-miss
      0.30            +2.2%       0.31        perf-stat.i.ipc
      1411            -1.4%       1391        perf-stat.i.major-faults
      1.76           +18.8%       2.09        perf-stat.i.metric.GHz
      0.07            -2.5%       0.07        perf-stat.i.metric.K/sec
    327.94           +21.4%     398.08        perf-stat.i.metric.M/sec
     27.07 ±  3%     +41.3       68.39        perf-stat.i.node-load-miss-rate%
  35964730 ±  2%     -56.8%   15544702 ±  3%  perf-stat.i.node-load-misses
 1.006e+08           -92.6%    7397999 ±  3%  perf-stat.i.node-loads
     21.47 ±  2%     +11.2       32.67 ±  5%  perf-stat.i.node-store-miss-rate%
  36494165 ±  2%     -54.1%   16746783 ±  6%  perf-stat.i.node-store-misses
 1.356e+08           -75.3%   33480057        perf-stat.i.node-stores
     30.21           -40.6%      17.96        perf-stat.overall.MPKI
      0.42            +0.2        0.58 ±  2%  perf-stat.overall.branch-miss-rate%
     67.66           -42.4       25.22        perf-stat.overall.cache-miss-rate%
      3.36            -2.3%       3.28        perf-stat.overall.cpi
    164.18          +341.1%     724.23        perf-stat.overall.cycles-between-cache-misses
      0.03 ±  3%      -0.0        0.01 ± 39%  perf-stat.overall.dTLB-store-miss-rate%
     56.23           -36.8       19.46 ±  4%  perf-stat.overall.iTLB-load-miss-rate%
     10794 ±  2%     -73.0%       2910 ±  4%  perf-stat.overall.instructions-per-iTLB-miss
      0.30            +2.3%       0.30        perf-stat.overall.ipc
     26.35 ±  3%     +41.4       67.75        perf-stat.overall.node-load-miss-rate%
     21.22 ±  2%     +12.1       33.31 ±  4%  perf-stat.overall.node-store-miss-rate%
   6663430          +219.0%   21254860        perf-stat.overall.path-length
 9.386e+09           +36.7%  1.283e+10        perf-stat.ps.branch-instructions
  39034136           +91.9%   74901707        perf-stat.ps.branch-misses
 1.024e+09           -73.1%  2.758e+08        perf-stat.ps.cache-misses
 1.514e+09           -27.8%  1.093e+09        perf-stat.ps.cache-references
    401792 ±  5%    +707.6%    3244911        perf-stat.ps.context-switches
 1.682e+11           +18.8%  1.998e+11        perf-stat.ps.cpu-cycles
    259.93           +34.6%     349.76 ±  7%  perf-stat.ps.cpu-migrations
 1.343e+10           +19.9%   1.61e+10        perf-stat.ps.dTLB-loads
   1865632 ±  2%     -48.6%     959045 ± 38%  perf-stat.ps.dTLB-store-misses
 6.676e+09           +17.3%  7.834e+09        perf-stat.ps.dTLB-stores
   4646543 ±  2%    +351.3%   20969372 ±  4%  perf-stat.ps.iTLB-load-misses
   3616554         +2299.6%   86782611        perf-stat.ps.iTLB-loads
 5.012e+10           +21.5%   6.09e+10        perf-stat.ps.instructions
  35781043 ±  2%     -56.8%   15466533 ±  3%  perf-stat.ps.node-load-misses
 1.001e+08           -92.6%    7361127 ±  3%  perf-stat.ps.node-loads
  36358157 ±  2%     -54.2%   16662088 ±  6%  perf-stat.ps.node-store-misses
  1.35e+08           -75.3%   33311794        perf-stat.ps.node-stores
 1.018e+13           +20.9%  1.231e+13        perf-stat.total.instructions
     15670 ± 20%     +95.5%      30629 ± 10%  softirqs.CPU0.RCU
     29773 ±  2%    +142.5%      72186 ±  4%  softirqs.CPU0.SCHED
     10084 ± 15%    +155.1%      25721 ±  7%  softirqs.CPU1.RCU
     25160          +178.6%      70084 ±  4%  softirqs.CPU1.SCHED
      8576 ±  5%    +179.9%      24003 ±  2%  softirqs.CPU10.RCU
     22397 ±  8%    +211.6%      69781 ±  3%  softirqs.CPU10.SCHED
      7936 ±  6%    +209.7%      24580 ±  3%  softirqs.CPU11.RCU
     21006 ±  3%    +230.0%      69325 ±  3%  softirqs.CPU11.SCHED
      8546 ± 10%    +180.9%      24005 ±  2%  softirqs.CPU12.RCU
     21370 ±  2%    +218.6%      68093        softirqs.CPU12.SCHED
      8310 ±  4%    +187.5%      23889 ±  4%  softirqs.CPU13.RCU
     23201 ±  6%    +193.2%      68023 ±  6%  softirqs.CPU13.SCHED
      8779 ±  2%    +178.0%      24409 ±  4%  softirqs.CPU14.RCU
     22747 ± 10%    +204.1%      69168 ±  2%  softirqs.CPU14.SCHED
      8317 ±  5%    +185.8%      23771 ±  4%  softirqs.CPU15.RCU
     21548 ±  5%    +209.7%      66744        softirqs.CPU15.SCHED
      8695 ±  4%    +196.8%      25808 ±  4%  softirqs.CPU16.RCU
     21530 ±  4%    +227.8%      70577 ±  5%  softirqs.CPU16.SCHED
      8500 ±  5%    +195.2%      25094 ±  4%  softirqs.CPU17.RCU
     22703 ±  3%    +204.1%      69030 ±  5%  softirqs.CPU17.SCHED
      8971 ±  9%    +178.0%      24939        softirqs.CPU18.RCU
     22355 ±  4%    +205.5%      68288 ±  2%  softirqs.CPU18.SCHED
      8438 ±  7%    +194.7%      24869 ±  3%  softirqs.CPU19.RCU
     22486 ±  2%    +193.3%      65960 ±  2%  softirqs.CPU19.SCHED
      9375 ±  7%    +164.3%      24781 ±  6%  softirqs.CPU2.RCU
     24102 ±  7%    +182.3%      68052        softirqs.CPU2.SCHED
      8425 ± 10%    +191.7%      24581 ±  6%  softirqs.CPU20.RCU
     20975 ±  2%    +234.6%      70188 ±  3%  softirqs.CPU20.SCHED
      7933 ±  4%    +204.3%      24140 ±  7%  softirqs.CPU21.RCU
     21882 ±  5%    +212.8%      68447 ±  4%  softirqs.CPU21.SCHED
      8792 ±  5%    +180.6%      24673 ±  4%  softirqs.CPU22.RCU
     21958 ±  4%    +207.6%      67544        softirqs.CPU22.SCHED
      8230 ±  3%    +200.8%      24754 ±  4%  softirqs.CPU23.RCU
     21497 ±  3%    +215.9%      67908        softirqs.CPU23.SCHED
     22255 ±  7%    +180.7%      62474 ±  4%  softirqs.CPU24.SCHED
      8195 ± 10%    +199.3%      24525 ±  3%  softirqs.CPU25.RCU
     22593          +192.5%      66087 ±  2%  softirqs.CPU25.SCHED
      8127 ± 10%    +196.5%      24101 ±  2%  softirqs.CPU26.RCU
     21736 ±  7%    +198.0%      64765 ±  5%  softirqs.CPU26.SCHED
      8528 ± 15%    +180.0%      23876 ±  4%  softirqs.CPU27.RCU
     23129 ±  3%    +188.5%      66734 ±  4%  softirqs.CPU27.SCHED
      9345 ± 26%    +159.1%      24212 ±  3%  softirqs.CPU28.RCU
     24804 ± 22%    +166.0%      65984 ±  3%  softirqs.CPU28.SCHED
      7936 ± 10%    +203.4%      24081 ±  3%  softirqs.CPU29.RCU
     22371 ±  5%    +191.3%      65176 ±  2%  softirqs.CPU29.SCHED
      8725 ±  8%    +188.3%      25150 ±  7%  softirqs.CPU3.RCU
     21948 ±  3%    +217.5%      69680 ±  2%  softirqs.CPU3.SCHED
      9080 ± 11%    +162.6%      23843 ±  2%  softirqs.CPU30.RCU
     24934 ± 21%    +165.7%      66259 ±  3%  softirqs.CPU30.SCHED
      7594 ±  8%    +219.8%      24284        softirqs.CPU31.RCU
     22557 ±  2%    +191.9%      65855 ±  3%  softirqs.CPU31.SCHED
      7953 ±  5%    +202.5%      24061 ±  3%  softirqs.CPU32.RCU
     23087 ±  2%    +191.2%      67226 ±  4%  softirqs.CPU32.SCHED
      8181 ± 10%    +197.8%      24362 ±  4%  softirqs.CPU33.RCU
     23168 ±  4%    +193.6%      68020 ±  3%  softirqs.CPU33.SCHED
      8319 ±  9%    +199.0%      24874 ±  5%  softirqs.CPU34.RCU
     22187 ±  3%    +205.8%      67857 ±  5%  softirqs.CPU34.SCHED
      9526 ± 40%    +149.5%      23765 ±  4%  softirqs.CPU35.RCU
     23613 ± 14%    +185.5%      67406 ±  2%  softirqs.CPU35.SCHED
      8245 ±  9%    +187.0%      23661 ±  3%  softirqs.CPU36.RCU
     21281 ±  3%    +217.4%      67542        softirqs.CPU36.SCHED
      8479 ±  4%    +181.7%      23888 ±  2%  softirqs.CPU37.RCU
     21263 ±  4%    +210.8%      66094 ±  2%  softirqs.CPU37.SCHED
      8499 ±  7%    +181.3%      23911 ±  3%  softirqs.CPU38.RCU
     23136 ± 12%    +186.0%      66179 ±  2%  softirqs.CPU38.SCHED
      8320 ±  7%    +190.4%      24159 ±  5%  softirqs.CPU39.RCU
     20777          +229.7%      68501 ±  6%  softirqs.CPU39.SCHED
      8729 ± 15%    +174.9%      23994 ±  3%  softirqs.CPU4.RCU
     22364 ±  4%    +208.7%      69039 ±  2%  softirqs.CPU4.SCHED
      7748 ±  3%    +207.4%      23815 ±  4%  softirqs.CPU40.RCU
     21757 ±  5%    +202.9%      65910 ±  3%  softirqs.CPU40.SCHED
      8050 ± 10%    +196.8%      23892 ±  7%  softirqs.CPU41.RCU
     21989          +209.0%      67957 ±  4%  softirqs.CPU41.SCHED
      7915 ± 11%    +201.5%      23869 ±  4%  softirqs.CPU42.RCU
     21589 ±  3%    +209.6%      66850 ±  2%  softirqs.CPU42.SCHED
      7881 ±  7%    +203.8%      23944 ±  3%  softirqs.CPU43.RCU
     21761 ±  3%    +200.3%      65353 ±  4%  softirqs.CPU43.SCHED
      8105 ± 13%    +192.1%      23678 ±  2%  softirqs.CPU44.RCU
     23793 ± 10%    +179.9%      66597 ±  2%  softirqs.CPU44.SCHED
      7951 ±  6%    +231.7%      26374 ±  7%  softirqs.CPU45.RCU
     22375 ±  9%    +202.2%      67626 ±  6%  softirqs.CPU45.SCHED
      7293 ± 13%    +222.9%      23547 ±  3%  softirqs.CPU46.RCU
     22681 ±  4%    +183.6%      64335 ±  3%  softirqs.CPU46.SCHED
      8098 ±  4%    +195.3%      23916 ±  3%  softirqs.CPU47.RCU
     20490 ±  5%    +155.1%      52263 ± 25%  softirqs.CPU47.SCHED
     17126 ± 30%     +96.0%      33566 ± 19%  softirqs.CPU48.RCU
     21470 ±  5%    +219.7%      68647 ±  4%  softirqs.CPU48.SCHED
      8547 ±  6%    +182.2%      24122 ±  3%  softirqs.CPU49.RCU
     21695 ±  3%    +232.9%      72233 ±  3%  softirqs.CPU49.SCHED
      8282 ±  8%    +187.8%      23835 ±  4%  softirqs.CPU5.RCU
     22320          +207.7%      68686        softirqs.CPU5.SCHED
      8961 ±  9%    +171.5%      24327 ±  2%  softirqs.CPU50.RCU
     21782 ±  4%    +228.4%      71528 ±  3%  softirqs.CPU50.SCHED
      9230 ± 24%    +162.4%      24217 ±  3%  softirqs.CPU51.RCU
     26943 ± 27%    +160.2%      70105 ±  2%  softirqs.CPU51.SCHED
      8306 ± 11%    +183.8%      23572 ±  4%  softirqs.CPU52.RCU
     21731 ±  4%    +216.4%      68763 ±  7%  softirqs.CPU52.SCHED
      8392 ±  9%    +186.2%      24018 ±  3%  softirqs.CPU53.RCU
     21498          +223.3%      69516 ±  3%  softirqs.CPU53.SCHED
      8399 ±  8%    +178.0%      23355 ±  2%  softirqs.CPU54.RCU
     21670 ± 11%    +226.0%      70650 ±  5%  softirqs.CPU54.SCHED
      7949 ±  6%    +195.6%      23495 ±  3%  softirqs.CPU55.RCU
     22783          +201.3%      68640        softirqs.CPU55.SCHED
      8179 ±  5%    +193.9%      24035 ±  6%  softirqs.CPU56.RCU
     21404 ±  5%    +235.1%      71730 ±  3%  softirqs.CPU56.SCHED
      8749 ±  4%    +172.3%      23826        softirqs.CPU57.RCU
     20953 ±  5%    +233.5%      69886 ±  3%  softirqs.CPU57.SCHED
      8119 ± 10%    +210.2%      25186 ± 12%  softirqs.CPU58.RCU
     22999          +204.3%      69982 ±  4%  softirqs.CPU58.SCHED
      7860 ±  9%    +197.2%      23363 ±  5%  softirqs.CPU59.RCU
     22977 ±  3%    +199.2%      68755 ±  3%  softirqs.CPU59.SCHED
      7923 ±  7%    +210.0%      24560 ±  6%  softirqs.CPU6.RCU
     23113 ±  4%    +198.6%      69023 ±  3%  softirqs.CPU6.SCHED
      8032 ± 10%    +197.3%      23883 ±  4%  softirqs.CPU60.RCU
     22186          +216.4%      70190 ±  2%  softirqs.CPU60.SCHED
      8515 ± 16%    +177.1%      23599 ±  4%  softirqs.CPU61.RCU
     23006 ± 10%    +203.5%      69813 ±  3%  softirqs.CPU61.SCHED
      8971 ±  6%    +166.9%      23947 ±  3%  softirqs.CPU62.RCU
     23046 ±  9%    +197.2%      68482 ±  6%  softirqs.CPU62.SCHED
      8202 ±  5%    +191.1%      23877 ±  4%  softirqs.CPU63.RCU
     22863 ±  8%    +210.0%      70865 ±  2%  softirqs.CPU63.SCHED
      7854 ±  5%    +209.4%      24302 ±  5%  softirqs.CPU64.RCU
     22694 ±  3%    +202.4%      68626 ±  3%  softirqs.CPU64.SCHED
      8781 ± 11%    +178.8%      24485 ±  4%  softirqs.CPU65.RCU
     22468 ±  3%    +209.5%      69539 ±  4%  softirqs.CPU65.SCHED
      8516 ±  6%    +188.2%      24540 ±  3%  softirqs.CPU66.RCU
     22488          +208.1%      69296 ±  3%  softirqs.CPU66.SCHED
      7766 ±  8%    +225.1%      25251 ±  2%  softirqs.CPU67.RCU
     21700          +230.8%      71784 ±  8%  softirqs.CPU67.SCHED
      7786 ±  5%    +220.1%      24920 ±  4%  softirqs.CPU68.RCU
     21984 ±  5%    +208.3%      67775 ±  2%  softirqs.CPU68.SCHED
      8714 ± 11%    +182.4%      24611 ±  6%  softirqs.CPU69.RCU
     21589 ±  6%    +224.2%      69988        softirqs.CPU69.SCHED
      8160 ±  3%    +197.7%      24292 ±  4%  softirqs.CPU7.RCU
     21704          +218.8%      69195 ±  3%  softirqs.CPU7.SCHED
      8325 ±  9%    +188.1%      23988 ±  2%  softirqs.CPU70.RCU
     22627 ±  3%    +201.1%      68131 ±  3%  softirqs.CPU70.SCHED
      7990 ±  3%    +197.7%      23788 ±  3%  softirqs.CPU71.RCU
     22470 ±  3%    +206.5%      68877 ±  5%  softirqs.CPU71.SCHED
      7700 ±  4%    +250.1%      26957 ± 15%  softirqs.CPU72.RCU
     22086 ±  5%    +214.6%      69474 ±  3%  softirqs.CPU72.SCHED
      7841 ±  5%    +210.0%      24307 ±  2%  softirqs.CPU73.RCU
     22637 ±  2%    +206.5%      69378        softirqs.CPU73.SCHED
      7891 ± 12%    +202.9%      23903 ±  4%  softirqs.CPU74.RCU
     23459 ± 10%    +195.9%      69408 ±  4%  softirqs.CPU74.SCHED
      8739 ±  6%    +178.2%      24310 ±  2%  softirqs.CPU75.RCU
     23028 ± 10%    +203.6%      69908 ±  3%  softirqs.CPU75.SCHED
      8829 ± 18%    +171.2%      23945 ±  2%  softirqs.CPU76.RCU
     25323 ±  8%    +168.0%      67863 ±  3%  softirqs.CPU76.SCHED
      7592 ±  5%    +222.6%      24495 ±  2%  softirqs.CPU77.RCU
     22899 ±  6%    +200.0%      68699 ±  3%  softirqs.CPU77.SCHED
      7662 ±  5%    +211.1%      23834 ±  4%  softirqs.CPU78.RCU
     22893 ±  4%    +201.1%      68934 ±  4%  softirqs.CPU78.SCHED
      7999 ±  8%    +197.3%      23786 ±  4%  softirqs.CPU79.RCU
     22724 ±  4%    +203.4%      68936 ±  2%  softirqs.CPU79.SCHED
      8416 ±  5%    +204.3%      25612 ± 14%  softirqs.CPU8.RCU
     22625 ±  2%    +217.1%      71743 ± 12%  softirqs.CPU8.SCHED
      8262 ±  3%    +183.8%      23451 ±  3%  softirqs.CPU80.RCU
     22139          +209.7%      68569 ±  4%  softirqs.CPU80.SCHED
      8063 ±  8%    +191.7%      23520 ±  2%  softirqs.CPU81.RCU
     22007 ± 12%    +219.2%      70249 ±  4%  softirqs.CPU81.SCHED
      8383 ±  7%    +184.5%      23850 ±  3%  softirqs.CPU82.RCU
     22538          +203.6%      68436        softirqs.CPU82.SCHED
      7623 ±  7%    +210.9%      23700 ±  3%  softirqs.CPU83.RCU
     22431 ±  8%    +201.3%      67579        softirqs.CPU83.SCHED
      7070 ±  3%    +237.6%      23866 ±  4%  softirqs.CPU84.RCU
     23895 ±  3%    +176.5%      66066        softirqs.CPU84.SCHED
      7970 ±  6%    +191.1%      23203 ±  4%  softirqs.CPU85.RCU
     23627 ±  3%    +185.2%      67392 ±  3%  softirqs.CPU85.SCHED
      7397 ±  7%    +214.7%      23280 ±  4%  softirqs.CPU86.RCU
     22409 ±  5%    +200.8%      67415 ±  4%  softirqs.CPU86.SCHED
      7833 ±  3%    +202.5%      23695 ±  3%  softirqs.CPU87.RCU
     24074          +180.9%      67630 ±  3%  softirqs.CPU87.SCHED
      7922 ±  9%    +199.1%      23694 ±  2%  softirqs.CPU88.RCU
     22811 ±  7%    +197.9%      67967 ±  2%  softirqs.CPU88.SCHED
      7975 ± 12%    +191.7%      23268 ±  4%  softirqs.CPU89.RCU
     22681          +194.6%      66816 ±  3%  softirqs.CPU89.SCHED
      7920 ±  5%    +207.2%      24334 ±  2%  softirqs.CPU9.RCU
     23639 ±  6%    +190.0%      68554 ±  3%  softirqs.CPU9.SCHED
      7860 ±  5%    +191.3%      22897 ±  4%  softirqs.CPU90.RCU
     25046 ±  9%    +167.2%      66915 ±  6%  softirqs.CPU90.SCHED
      8138 ±  4%    +188.7%      23492 ±  2%  softirqs.CPU91.RCU
     23223 ±  4%    +186.1%      66448 ±  6%  softirqs.CPU91.SCHED
      8133 ±  6%    +184.2%      23112        softirqs.CPU92.RCU
     22447 ±  6%    +193.8%      65957 ±  4%  softirqs.CPU92.SCHED
      8294 ±  8%    +182.4%      23423 ±  2%  softirqs.CPU93.RCU
     23356 ±  5%    +180.2%      65452 ±  2%  softirqs.CPU93.SCHED
      9349 ± 26%    +143.9%      22799 ±  2%  softirqs.CPU94.RCU
     21707 ±  3%    +203.1%      65789 ±  5%  softirqs.CPU94.SCHED
      7797 ±  3%    +190.9%      22679 ±  4%  softirqs.CPU95.RCU
     23125 ±  4%    +178.7%      64461 ±  3%  softirqs.CPU95.SCHED
    815328          +186.1%    2332962 ±  3%  softirqs.RCU
   2173381          +200.6%    6533968 ±  2%  softirqs.SCHED
   6461840 ±  5%    +137.8%   15367210        interrupts.CAL:Function_call_interrupts
     62482 ±  3%     +91.2%     119495 ±  9%  interrupts.CPU0.CAL:Function_call_interrupts
      7671          +510.4%      46828 ±  4%  interrupts.CPU0.RES:Rescheduling_interrupts
     65626 ±  5%     +78.5%     117123 ± 11%  interrupts.CPU1.CAL:Function_call_interrupts
      5178 ± 26%     +40.6%       7279 ±  2%  interrupts.CPU1.NMI:Non-maskable_interrupts
      5178 ± 26%     +40.6%       7279 ±  2%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
      7815 ±  4%    +637.0%      57598 ± 10%  interrupts.CPU1.RES:Rescheduling_interrupts
     75387 ±  9%    +110.8%     158940 ± 11%  interrupts.CPU10.CAL:Function_call_interrupts
      8391 ±  6%    +474.2%      48182 ± 11%  interrupts.CPU10.RES:Rescheduling_interrupts
     75020 ±  7%     +99.4%     149565 ±  9%  interrupts.CPU11.CAL:Function_call_interrupts
      8972 ±  5%    +432.9%      47810 ±  4%  interrupts.CPU11.RES:Rescheduling_interrupts
     71085 ±  9%    +106.4%     146689 ±  9%  interrupts.CPU12.CAL:Function_call_interrupts
      7850 ±  7%    +529.7%      49430 ±  9%  interrupts.CPU12.RES:Rescheduling_interrupts
     76917 ±  9%     +89.0%     145387 ± 15%  interrupts.CPU13.CAL:Function_call_interrupts
      9042 ±  9%    +435.3%      48406 ± 12%  interrupts.CPU13.RES:Rescheduling_interrupts
     67031 ± 18%    +128.1%     152903 ± 18%  interrupts.CPU14.CAL:Function_call_interrupts
      7842 ± 21%    +580.1%      53336 ±  3%  interrupts.CPU14.RES:Rescheduling_interrupts
     74704 ±  8%     +92.5%     143770 ± 13%  interrupts.CPU15.CAL:Function_call_interrupts
      8797 ± 10%    +441.1%      47601 ±  9%  interrupts.CPU15.RES:Rescheduling_interrupts
     76029 ± 10%    +108.3%     158350 ±  6%  interrupts.CPU16.CAL:Function_call_interrupts
      9290 ±  9%    +414.1%      47758 ± 12%  interrupts.CPU16.RES:Rescheduling_interrupts
     67351 ± 10%    +115.1%     144852 ± 12%  interrupts.CPU17.CAL:Function_call_interrupts
      8128 ± 10%    +495.9%      48438 ±  6%  interrupts.CPU17.RES:Rescheduling_interrupts
     72167 ± 15%     +96.6%     141901 ± 13%  interrupts.CPU18.CAL:Function_call_interrupts
      8869 ± 14%    +481.4%      51564 ±  7%  interrupts.CPU18.RES:Rescheduling_interrupts
     74094 ±  6%     +62.0%     120008 ±  8%  interrupts.CPU19.CAL:Function_call_interrupts
      8636 ±  8%    +493.5%      51253 ± 15%  interrupts.CPU19.RES:Rescheduling_interrupts
     70762 ±  8%     +70.4%     120588 ±  7%  interrupts.CPU2.CAL:Function_call_interrupts
      8652 ± 10%    +516.1%      53306 ±  5%  interrupts.CPU2.RES:Rescheduling_interrupts
     80765 ±  8%     +85.5%     149834 ±  9%  interrupts.CPU20.CAL:Function_call_interrupts
      8775 ±  7%    +468.1%      49853 ±  8%  interrupts.CPU20.RES:Rescheduling_interrupts
     75757 ±  4%     +70.4%     129117 ±  4%  interrupts.CPU21.CAL:Function_call_interrupts
      9022 ±  5%    +485.4%      52818 ± 13%  interrupts.CPU21.RES:Rescheduling_interrupts
     77143 ±  4%     +72.7%     133262 ± 10%  interrupts.CPU22.CAL:Function_call_interrupts
      9361 ±  6%    +455.8%      52033 ±  3%  interrupts.CPU22.RES:Rescheduling_interrupts
     76663 ± 10%     +80.9%     138654 ±  9%  interrupts.CPU23.CAL:Function_call_interrupts
      8985 ± 10%    +436.3%      48189 ±  7%  interrupts.CPU23.RES:Rescheduling_interrupts
     52836 ± 18%    +128.0%     120489 ± 12%  interrupts.CPU24.CAL:Function_call_interrupts
      6618 ± 14%    +699.8%      52931 ±  7%  interrupts.CPU24.RES:Rescheduling_interrupts
     61810 ±  8%    +124.7%     138913 ± 14%  interrupts.CPU25.CAL:Function_call_interrupts
      7370 ±  7%    +657.5%      55828 ±  9%  interrupts.CPU25.RES:Rescheduling_interrupts
     64896 ±  5%    +110.4%     136551 ± 23%  interrupts.CPU26.CAL:Function_call_interrupts
      7767 ±  7%    +580.1%      52827 ±  6%  interrupts.CPU26.RES:Rescheduling_interrupts
     63923 ± 20%    +185.6%     182583 ± 13%  interrupts.CPU27.CAL:Function_call_interrupts
      7074 ± 16%    +603.3%      49752 ±  6%  interrupts.CPU27.RES:Rescheduling_interrupts
     64866 ±  3%    +136.4%     153344 ±  2%  interrupts.CPU28.CAL:Function_call_interrupts
      7735 ±  2%    +577.1%      52374 ±  6%  interrupts.CPU28.RES:Rescheduling_interrupts
     60315 ±  7%    +151.4%     151645 ±  9%  interrupts.CPU29.CAL:Function_call_interrupts
      4076 ± 24%     +73.5%       7073 ±  3%  interrupts.CPU29.NMI:Non-maskable_interrupts
      4076 ± 24%     +73.5%       7073 ±  3%  interrupts.CPU29.PMI:Performance_monitoring_interrupts
      7158 ±  6%    +605.4%      50495 ±  3%  interrupts.CPU29.RES:Rescheduling_interrupts
     71859 ± 17%     +90.3%     136755 ±  9%  interrupts.CPU3.CAL:Function_call_interrupts
      4613 ± 37%     +51.5%       6988 ±  5%  interrupts.CPU3.NMI:Non-maskable_interrupts
      4613 ± 37%     +51.5%       6988 ±  5%  interrupts.CPU3.PMI:Performance_monitoring_interrupts
      8466 ± 16%    +537.4%      53962 ±  7%  interrupts.CPU3.RES:Rescheduling_interrupts
     68775 ± 11%    +144.0%     167835 ± 13%  interrupts.CPU30.CAL:Function_call_interrupts
      6027 ±  3%     +15.5%       6961 ±  5%  interrupts.CPU30.NMI:Non-maskable_interrupts
      6027 ±  3%     +15.5%       6961 ±  5%  interrupts.CPU30.PMI:Performance_monitoring_interrupts
      7993 ± 11%    +514.6%      49127 ± 10%  interrupts.CPU30.RES:Rescheduling_interrupts
     64139          +133.8%     149979 ± 13%  interrupts.CPU31.CAL:Function_call_interrupts
      4972 ± 16%     +38.8%       6902 ±  3%  interrupts.CPU31.NMI:Non-maskable_interrupts
      4972 ± 16%     +38.8%       6902 ±  3%  interrupts.CPU31.PMI:Performance_monitoring_interrupts
      7708 ±  3%    +596.2%      53665 ± 13%  interrupts.CPU31.RES:Rescheduling_interrupts
     64103 ±  5%    +136.3%     151479 ±  8%  interrupts.CPU32.CAL:Function_call_interrupts
      4219 ± 34%     +55.8%       6575 ±  6%  interrupts.CPU32.NMI:Non-maskable_interrupts
      4219 ± 34%     +55.8%       6575 ±  6%  interrupts.CPU32.PMI:Performance_monitoring_interrupts
      7688 ±  6%    +678.7%      59869 ± 10%  interrupts.CPU32.RES:Rescheduling_interrupts
     63761 ± 14%    +156.7%     163667 ± 12%  interrupts.CPU33.CAL:Function_call_interrupts
      7642 ± 18%    +640.4%      56590 ±  2%  interrupts.CPU33.RES:Rescheduling_interrupts
     61956 ± 17%    +189.9%     179589 ±  9%  interrupts.CPU34.CAL:Function_call_interrupts
      7322 ± 10%    +550.1%      47601 ± 10%  interrupts.CPU34.RES:Rescheduling_interrupts
     71778 ±  5%    +119.7%     157708 ±  7%  interrupts.CPU35.CAL:Function_call_interrupts
      5888 ±  6%     +20.5%       7094 ±  3%  interrupts.CPU35.NMI:Non-maskable_interrupts
      5888 ±  6%     +20.5%       7094 ±  3%  interrupts.CPU35.PMI:Performance_monitoring_interrupts
      7996 ±  8%    +566.3%      53280 ±  5%  interrupts.CPU35.RES:Rescheduling_interrupts
     67930 ±  8%    +132.0%     157585 ±  4%  interrupts.CPU36.CAL:Function_call_interrupts
      8362 ±  9%    +550.3%      54380 ± 11%  interrupts.CPU36.RES:Rescheduling_interrupts
     64255 ±  2%    +127.3%     146059 ± 10%  interrupts.CPU37.CAL:Function_call_interrupts
      3961 ± 35%     +74.6%       6915 ± 10%  interrupts.CPU37.NMI:Non-maskable_interrupts
      3961 ± 35%     +74.6%       6915 ± 10%  interrupts.CPU37.PMI:Performance_monitoring_interrupts
      7748 ±  3%    +568.4%      51792 ±  5%  interrupts.CPU37.RES:Rescheduling_interrupts
     66536 ± 12%    +149.2%     165819 ± 11%  interrupts.CPU38.CAL:Function_call_interrupts
      7702 ±  7%    +580.4%      52413 ± 11%  interrupts.CPU38.RES:Rescheduling_interrupts
    153.50 ± 58%     -70.7%      45.00 ± 62%  interrupts.CPU38.TLB:TLB_shootdowns
     65924 ± 13%    +151.9%     166082 ±  8%  interrupts.CPU39.CAL:Function_call_interrupts
      8108 ± 15%    +510.1%      49467 ± 11%  interrupts.CPU39.RES:Rescheduling_interrupts
     76391 ± 12%    +101.3%     153777 ±  6%  interrupts.CPU4.CAL:Function_call_interrupts
      8664 ± 12%    +496.2%      51654 ± 12%  interrupts.CPU4.RES:Rescheduling_interrupts
     68685 ±  5%    +138.2%     163639 ± 10%  interrupts.CPU40.CAL:Function_call_interrupts
      5402 ± 29%     +33.0%       7185 ±  4%  interrupts.CPU40.NMI:Non-maskable_interrupts
      5402 ± 29%     +33.0%       7185 ±  4%  interrupts.CPU40.PMI:Performance_monitoring_interrupts
      8082          +513.9%      49620 ± 12%  interrupts.CPU40.RES:Rescheduling_interrupts
     70783 ±  5%    +138.5%     168792 ± 11%  interrupts.CPU41.CAL:Function_call_interrupts
      5138 ± 19%     +38.5%       7119 ±  4%  interrupts.CPU41.NMI:Non-maskable_interrupts
      5138 ± 19%     +38.5%       7119 ±  4%  interrupts.CPU41.PMI:Performance_monitoring_interrupts
      8072 ±  5%    +500.2%      48449 ±  6%  interrupts.CPU41.RES:Rescheduling_interrupts
     66897 ±  4%    +136.5%     158196 ± 14%  interrupts.CPU42.CAL:Function_call_interrupts
      7621 ±  5%    +596.2%      53055 ± 11%  interrupts.CPU42.RES:Rescheduling_interrupts
     70130 ±  9%    +122.9%     156338 ±  5%  interrupts.CPU43.CAL:Function_call_interrupts
      5875           +15.3%       6776 ±  3%  interrupts.CPU43.NMI:Non-maskable_interrupts
      5875           +15.3%       6776 ±  3%  interrupts.CPU43.PMI:Performance_monitoring_interrupts
      8239 ±  9%    +460.4%      46172 ±  8%  interrupts.CPU43.RES:Rescheduling_interrupts
     64338 ± 20%    +156.0%     164724 ±  8%  interrupts.CPU44.CAL:Function_call_interrupts
      7639 ± 18%    +553.6%      49931 ± 10%  interrupts.CPU44.RES:Rescheduling_interrupts
     66684 ±  6%    +153.8%     169276 ± 12%  interrupts.CPU45.CAL:Function_call_interrupts
      8162 ±  6%    +485.0%      47750 ±  9%  interrupts.CPU45.RES:Rescheduling_interrupts
     55347 ± 13%    +151.7%     139305 ± 16%  interrupts.CPU46.CAL:Function_call_interrupts
      5729 ± 11%     +21.1%       6935 ±  4%  interrupts.CPU46.NMI:Non-maskable_interrupts
      5729 ± 11%     +21.1%       6935 ±  4%  interrupts.CPU46.PMI:Performance_monitoring_interrupts
      6426 ± 14%    +645.2%      47890 ± 12%  interrupts.CPU46.RES:Rescheduling_interrupts
     65869 ±  7%    +132.5%     153168 ±  5%  interrupts.CPU47.CAL:Function_call_interrupts
      8029 ±  6%    +482.3%      46761 ±  7%  interrupts.CPU47.RES:Rescheduling_interrupts
     67064 ± 15%    +124.6%     150593 ± 21%  interrupts.CPU48.CAL:Function_call_interrupts
      9017 ± 13%    +351.4%      40703 ± 10%  interrupts.CPU48.RES:Rescheduling_interrupts
     77798 ± 19%    +136.5%     184004 ± 20%  interrupts.CPU49.CAL:Function_call_interrupts
      9994 ± 14%    +369.7%      46941 ±  5%  interrupts.CPU49.RES:Rescheduling_interrupts
     73739 ±  8%     +97.0%     145296 ± 17%  interrupts.CPU5.CAL:Function_call_interrupts
      8842 ±  6%    +494.7%      52585 ±  6%  interrupts.CPU5.RES:Rescheduling_interrupts
     73318 ±  3%    +144.9%     179562 ± 10%  interrupts.CPU50.CAL:Function_call_interrupts
      9432          +386.9%      45930 ±  6%  interrupts.CPU50.RES:Rescheduling_interrupts
     68248 ±  6%    +140.9%     164432 ± 18%  interrupts.CPU51.CAL:Function_call_interrupts
      6073 ±  3%     +15.4%       7007 ±  6%  interrupts.CPU51.NMI:Non-maskable_interrupts
      6073 ±  3%     +15.4%       7007 ±  6%  interrupts.CPU51.PMI:Performance_monitoring_interrupts
      8417 ±  7%    +502.3%      50693 ± 10%  interrupts.CPU51.RES:Rescheduling_interrupts
     71973 ± 12%    +126.8%     163244 ± 15%  interrupts.CPU52.CAL:Function_call_interrupts
      9330 ± 12%    +440.5%      50436 ± 16%  interrupts.CPU52.RES:Rescheduling_interrupts
     67274 ± 13%    +133.1%     156802 ± 19%  interrupts.CPU53.CAL:Function_call_interrupts
      5331 ± 22%     +35.1%       7204 ±  4%  interrupts.CPU53.NMI:Non-maskable_interrupts
      5331 ± 22%     +35.1%       7204 ±  4%  interrupts.CPU53.PMI:Performance_monitoring_interrupts
      8861 ± 13%    +433.3%      47258 ± 11%  interrupts.CPU53.RES:Rescheduling_interrupts
     82620 ± 10%    +118.1%     180162 ±  8%  interrupts.CPU54.CAL:Function_call_interrupts
      4802 ± 35%     +50.8%       7241 ±  2%  interrupts.CPU54.NMI:Non-maskable_interrupts
      4802 ± 35%     +50.8%       7241 ±  2%  interrupts.CPU54.PMI:Performance_monitoring_interrupts
      9923 ± 10%    +368.4%      46480 ± 12%  interrupts.CPU54.RES:Rescheduling_interrupts
     73712 ± 13%     +95.6%     144151 ± 21%  interrupts.CPU55.CAL:Function_call_interrupts
      8785 ± 12%    +521.9%      54642 ±  8%  interrupts.CPU55.RES:Rescheduling_interrupts
     77875 ± 10%    +124.7%     175009 ±  8%  interrupts.CPU56.CAL:Function_call_interrupts
      9816 ±  8%    +419.8%      51021 ± 15%  interrupts.CPU56.RES:Rescheduling_interrupts
     80922 ±  6%    +105.3%     166166 ±  5%  interrupts.CPU57.CAL:Function_call_interrupts
      6245 ± 10%     +15.7%       7224 ±  3%  interrupts.CPU57.NMI:Non-maskable_interrupts
      6245 ± 10%     +15.7%       7224 ±  3%  interrupts.CPU57.PMI:Performance_monitoring_interrupts
      9697 ±  4%    +413.4%      49784 ± 10%  interrupts.CPU57.RES:Rescheduling_interrupts
     76213 ± 10%    +125.6%     171938 ±  8%  interrupts.CPU58.CAL:Function_call_interrupts
      6388 ± 10%     +14.4%       7310 ±  5%  interrupts.CPU58.NMI:Non-maskable_interrupts
      6388 ± 10%     +14.4%       7310 ±  5%  interrupts.CPU58.PMI:Performance_monitoring_interrupts
      9450 ± 14%    +367.0%      44134 ± 11%  interrupts.CPU58.RES:Rescheduling_interrupts
     72911 ±  3%    +111.6%     154296 ± 16%  interrupts.CPU59.CAL:Function_call_interrupts
      8808 ±  7%    +479.8%      51072 ± 17%  interrupts.CPU59.RES:Rescheduling_interrupts
     66354 ±  5%    +139.4%     158841 ± 17%  interrupts.CPU6.CAL:Function_call_interrupts
      7697 ±  5%    +561.3%      50900 ± 15%  interrupts.CPU6.RES:Rescheduling_interrupts
     81740 ± 10%     +87.3%     153137 ±  8%  interrupts.CPU60.CAL:Function_call_interrupts
      4568 ± 35%     +51.9%       6940 ±  5%  interrupts.CPU60.NMI:Non-maskable_interrupts
      4568 ± 35%     +51.9%       6940 ±  5%  interrupts.CPU60.PMI:Performance_monitoring_interrupts
      9565 ±  8%    +441.9%      51840 ±  5%  interrupts.CPU60.RES:Rescheduling_interrupts
     69341 ± 18%    +156.0%     177533 ± 17%  interrupts.CPU61.CAL:Function_call_interrupts
      6129 ±  7%     +15.4%       7072 ±  4%  interrupts.CPU61.NMI:Non-maskable_interrupts
      6129 ±  7%     +15.4%       7072 ±  4%  interrupts.CPU61.PMI:Performance_monitoring_interrupts
      8767 ± 12%    +426.5%      46157 ±  9%  interrupts.CPU61.RES:Rescheduling_interrupts
     86763 ±  9%     +94.0%     168290 ± 13%  interrupts.CPU62.CAL:Function_call_interrupts
     10296 ± 12%    +362.6%      47628 ± 12%  interrupts.CPU62.RES:Rescheduling_interrupts
     71344 ±  4%    +129.2%     163538 ± 12%  interrupts.CPU63.CAL:Function_call_interrupts
      8951 ±  8%    +402.2%      44956 ± 11%  interrupts.CPU63.RES:Rescheduling_interrupts
     72821 ± 17%    +110.7%     153423 ± 17%  interrupts.CPU64.CAL:Function_call_interrupts
      8627 ± 13%    +460.1%      48321 ±  8%  interrupts.CPU64.RES:Rescheduling_interrupts
     74883 ± 13%    +110.1%     157305 ± 11%  interrupts.CPU65.CAL:Function_call_interrupts
      9271 ± 12%    +427.9%      48938 ± 16%  interrupts.CPU65.RES:Rescheduling_interrupts
     62315 ± 19%    +121.5%     138023 ±  7%  interrupts.CPU66.CAL:Function_call_interrupts
      6302 ±  5%     +14.4%       7211 ±  3%  interrupts.CPU66.NMI:Non-maskable_interrupts
      6302 ±  5%     +14.4%       7211 ±  3%  interrupts.CPU66.PMI:Performance_monitoring_interrupts
      8467 ± 18%    +596.3%      58956 ± 13%  interrupts.CPU66.RES:Rescheduling_interrupts
     67318 ±  4%    +132.3%     156406 ±  4%  interrupts.CPU67.CAL:Function_call_interrupts
      8298 ±  5%    +503.5%      50078 ±  9%  interrupts.CPU67.RES:Rescheduling_interrupts
     78315 ± 11%     +89.1%     148106 ± 17%  interrupts.CPU68.CAL:Function_call_interrupts
      9417 ± 12%    +428.5%      49769 ± 11%  interrupts.CPU68.RES:Rescheduling_interrupts
     68241 ± 12%    +126.0%     154226 ±  8%  interrupts.CPU69.CAL:Function_call_interrupts
      8653 ± 15%    +483.2%      50465 ± 21%  interrupts.CPU69.RES:Rescheduling_interrupts
     77888 ± 10%     +95.9%     152618 ± 16%  interrupts.CPU7.CAL:Function_call_interrupts
      8923 ± 13%    +470.0%      50861 ± 12%  interrupts.CPU7.RES:Rescheduling_interrupts
     64160 ±  6%    +146.2%     157945 ±  8%  interrupts.CPU70.CAL:Function_call_interrupts
      4963 ± 17%     +40.2%       6959 ±  3%  interrupts.CPU70.NMI:Non-maskable_interrupts
      4963 ± 17%     +40.2%       6959 ±  3%  interrupts.CPU70.PMI:Performance_monitoring_interrupts
      8199 ±  3%    +440.4%      44310 ± 13%  interrupts.CPU70.RES:Rescheduling_interrupts
     67900 ± 21%    +150.4%     170008 ± 13%  interrupts.CPU71.CAL:Function_call_interrupts
      4817 ± 22%     +46.4%       7052 ±  7%  interrupts.CPU71.NMI:Non-maskable_interrupts
      4817 ± 22%     +46.4%       7052 ±  7%  interrupts.CPU71.PMI:Performance_monitoring_interrupts
      8244 ± 19%    +404.9%      41623 ± 18%  interrupts.CPU71.RES:Rescheduling_interrupts
     62613 ±  7%    +179.3%     174884 ±  6%  interrupts.CPU72.CAL:Function_call_interrupts
      8114 ± 10%    +521.0%      50393 ±  4%  interrupts.CPU72.RES:Rescheduling_interrupts
     62090 ± 18%    +217.4%     197098 ±  4%  interrupts.CPU73.CAL:Function_call_interrupts
      5809 ±  9%     +22.5%       7118 ±  5%  interrupts.CPU73.NMI:Non-maskable_interrupts
      5809 ±  9%     +22.5%       7118 ±  5%  interrupts.CPU73.PMI:Performance_monitoring_interrupts
      7776 ± 17%    +521.9%      48357 ±  5%  interrupts.CPU73.RES:Rescheduling_interrupts
     58227 ± 10%    +243.9%     200238 ±  6%  interrupts.CPU74.CAL:Function_call_interrupts
      7384 ± 12%    +516.3%      45512 ±  6%  interrupts.CPU74.RES:Rescheduling_interrupts
     69629 ±  6%    +190.7%     202400 ±  7%  interrupts.CPU75.CAL:Function_call_interrupts
      8531 ± 12%    +447.7%      46724 ±  8%  interrupts.CPU75.RES:Rescheduling_interrupts
     57700 ± 11%    +211.6%     179780 ±  4%  interrupts.CPU76.CAL:Function_call_interrupts
      7624 ± 10%    +528.7%      47936 ±  8%  interrupts.CPU76.RES:Rescheduling_interrupts
     62365 ± 20%    +187.5%     179291 ± 10%  interrupts.CPU77.CAL:Function_call_interrupts
      8018 ± 22%    +526.7%      50257 ± 10%  interrupts.CPU77.RES:Rescheduling_interrupts
     56065 ± 15%    +239.2%     190155 ±  3%  interrupts.CPU78.CAL:Function_call_interrupts
      7374 ± 17%    +551.3%      48029 ±  7%  interrupts.CPU78.RES:Rescheduling_interrupts
     58344 ± 16%    +227.7%     191205 ± 11%  interrupts.CPU79.CAL:Function_call_interrupts
      7673 ± 13%    +531.7%      48470 ±  8%  interrupts.CPU79.RES:Rescheduling_interrupts
     63713 ± 11%     +99.0%     126816 ± 14%  interrupts.CPU8.CAL:Function_call_interrupts
      5635 ± 15%     +21.7%       6856 ± 10%  interrupts.CPU8.NMI:Non-maskable_interrupts
      5635 ± 15%     +21.7%       6856 ± 10%  interrupts.CPU8.PMI:Performance_monitoring_interrupts
      7455 ±  7%    +658.9%      56577 ± 15%  interrupts.CPU8.RES:Rescheduling_interrupts
     62262 ±  7%    +211.7%     194081 ± 11%  interrupts.CPU80.CAL:Function_call_interrupts
      8055 ±  9%    +508.0%      48980 ± 14%  interrupts.CPU80.RES:Rescheduling_interrupts
     62107 ±  5%    +223.1%     200685 ±  8%  interrupts.CPU81.CAL:Function_call_interrupts
      7997 ±  6%    +527.6%      50188 ±  4%  interrupts.CPU81.RES:Rescheduling_interrupts
     58154 ± 16%    +223.9%     188345 ±  4%  interrupts.CPU82.CAL:Function_call_interrupts
      7577 ± 20%    +591.6%      52408 ± 10%  interrupts.CPU82.RES:Rescheduling_interrupts
     57799 ± 18%    +186.1%     165388 ±  4%  interrupts.CPU83.CAL:Function_call_interrupts
      7374 ± 15%    +608.7%      52263 ±  8%  interrupts.CPU83.RES:Rescheduling_interrupts
     52668 ±  6%    +180.0%     147478 ± 18%  interrupts.CPU84.CAL:Function_call_interrupts
      6894 ± 13%    +691.3%      54552 ± 14%  interrupts.CPU84.RES:Rescheduling_interrupts
     56922 ± 18%    +212.6%     177963 ±  7%  interrupts.CPU85.CAL:Function_call_interrupts
      7087 ± 16%    +569.0%      47412 ±  7%  interrupts.CPU85.RES:Rescheduling_interrupts
     63435 ± 16%    +184.4%     180388 ± 11%  interrupts.CPU86.CAL:Function_call_interrupts
      7862 ± 17%    +556.8%      51644 ±  8%  interrupts.CPU86.RES:Rescheduling_interrupts
     58376 ±  8%    +175.6%     160868 ± 13%  interrupts.CPU87.CAL:Function_call_interrupts
      7412 ±  6%    +591.8%      51280 ± 10%  interrupts.CPU87.RES:Rescheduling_interrupts
     58583 ± 18%    +228.6%     192483 ±  4%  interrupts.CPU88.CAL:Function_call_interrupts
      7296 ± 20%    +603.3%      51316 ± 12%  interrupts.CPU88.RES:Rescheduling_interrupts
    171.00 ± 85%     -60.7%      67.25 ± 45%  interrupts.CPU88.TLB:TLB_shootdowns
     55645 ±  9%    +208.2%     171478 ±  5%  interrupts.CPU89.CAL:Function_call_interrupts
      6986 ± 10%    +609.7%      49584 ±  8%  interrupts.CPU89.RES:Rescheduling_interrupts
     70936 ± 11%     +90.8%     135311 ± 10%  interrupts.CPU9.CAL:Function_call_interrupts
      8034 ± 11%    +573.0%      54068 ±  9%  interrupts.CPU9.RES:Rescheduling_interrupts
     61533 ± 11%    +188.6%     177579 ± 11%  interrupts.CPU90.CAL:Function_call_interrupts
      7865 ± 13%    +480.7%      45675 ±  9%  interrupts.CPU90.RES:Rescheduling_interrupts
     59174 ±  5%    +185.2%     168767 ± 15%  interrupts.CPU91.CAL:Function_call_interrupts
      7323 ±  6%    +559.8%      48317 ±  9%  interrupts.CPU91.RES:Rescheduling_interrupts
     56706 ±  9%    +212.7%     177312 ±  9%  interrupts.CPU92.CAL:Function_call_interrupts
      7276 ±  8%    +538.4%      46457 ±  7%  interrupts.CPU92.RES:Rescheduling_interrupts
     52732 ± 15%    +233.0%     175590 ±  6%  interrupts.CPU93.CAL:Function_call_interrupts
      6903 ± 14%    +531.9%      43620 ±  5%  interrupts.CPU93.RES:Rescheduling_interrupts
     61510 ± 14%    +196.2%     182199 ± 10%  interrupts.CPU94.CAL:Function_call_interrupts
      7943 ± 10%    +458.5%      44363 ±  8%  interrupts.CPU94.RES:Rescheduling_interrupts
     45697 ± 17%    +251.5%     160608 ± 12%  interrupts.CPU95.CAL:Function_call_interrupts
      6351 ± 16%    +580.3%      43209 ± 12%  interrupts.CPU95.RES:Rescheduling_interrupts
    534452 ±  4%     +15.5%     617222 ±  6%  interrupts.NMI:Non-maskable_interrupts
    534452 ±  4%     +15.5%     617222 ±  6%  interrupts.PMI:Performance_monitoring_interrupts
    787457 ±  5%    +507.8%    4786140 ±  4%  interrupts.RES:Rescheduling_interrupts
     45.25 ±  4%     -44.1        1.16 ±  3%  perf-profile.calltrace.cycles-pp.force_page_cache_readahead.generic_file_buffered_read.new_sync_read.vfs_read.ksys_read
     45.25 ±  4%     -44.1        1.16 ±  3%  perf-profile.calltrace.cycles-pp.page_cache_readahead_unbounded.force_page_cache_readahead.generic_file_buffered_read.new_sync_read.vfs_read
     62.72 ±  4%     -24.3       38.42 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     62.71 ±  4%     -24.3       38.42 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     21.76 ±  6%     -21.8        0.00        perf-profile.calltrace.cycles-pp.__alloc_pages_nodemask.page_cache_readahead_unbounded.force_page_cache_readahead.generic_file_buffered_read.new_sync_read
     55.94 ±  4%     -18.2       37.73 ±  3%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     55.94 ±  4%     -18.2       37.73 ±  3%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     55.92 ±  4%     -18.2       37.73 ±  3%  perf-profile.calltrace.cycles-pp.new_sync_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     55.91 ±  4%     -18.2       37.73 ±  3%  perf-profile.calltrace.cycles-pp.generic_file_buffered_read.new_sync_read.vfs_read.ksys_read.do_syscall_64
     15.28 ±  5%     -15.3        0.00        perf-profile.calltrace.cycles-pp.__alloc_pages_slowpath.__alloc_pages_nodemask.page_cache_readahead_unbounded.force_page_cache_readahead.generic_file_buffered_read
     15.10 ±  3%     -15.1        0.00        perf-profile.calltrace.cycles-pp.read_pages.page_cache_readahead_unbounded.force_page_cache_readahead.generic_file_buffered_read.new_sync_read
     15.09 ±  3%     -15.1        0.00        perf-profile.calltrace.cycles-pp.extent_readahead.read_pages.page_cache_readahead_unbounded.force_page_cache_readahead.generic_file_buffered_read
     14.65 ±  6%     -14.7        0.00        perf-profile.calltrace.cycles-pp.try_to_free_pages.__alloc_pages_slowpath.__alloc_pages_nodemask.page_cache_readahead_unbounded.force_page_cache_readahead
     14.64 ±  6%     -14.6        0.00        perf-profile.calltrace.cycles-pp.shrink_node.do_try_to_free_pages.try_to_free_pages.__alloc_pages_slowpath.__alloc_pages_nodemask
     14.64 ±  6%     -14.6        0.00        perf-profile.calltrace.cycles-pp.do_try_to_free_pages.try_to_free_pages.__alloc_pages_slowpath.__alloc_pages_nodemask.page_cache_readahead_unbounded
     14.53 ±  6%     -14.5        0.00        perf-profile.calltrace.cycles-pp.shrink_lruvec.shrink_node.do_try_to_free_pages.try_to_free_pages.__alloc_pages_slowpath
     14.52 ±  6%     -14.5        0.00        perf-profile.calltrace.cycles-pp.shrink_inactive_list.shrink_lruvec.shrink_node.do_try_to_free_pages.try_to_free_pages
     11.63 ±  7%     -11.6        0.00        perf-profile.calltrace.cycles-pp.shrink_page_list.shrink_inactive_list.shrink_lruvec.shrink_node.do_try_to_free_pages
     12.36 ±  3%     -10.7        1.70 ±  3%  perf-profile.calltrace.cycles-pp.pmem_do_read.pmem_submit_bio.submit_bio_noacct.submit_bio.btrfs_map_bio
     12.24 ±  3%     -10.6        1.67 ±  3%  perf-profile.calltrace.cycles-pp.__memcpy_mcsafe.pmem_do_read.pmem_submit_bio.submit_bio_noacct.submit_bio
      8.70 ±  3%      -8.7        0.00        perf-profile.calltrace.cycles-pp.__do_readpage.extent_readahead.read_pages.page_cache_readahead_unbounded.force_page_cache_readahead
      8.10 ±  3%      -8.1        0.00        perf-profile.calltrace.cycles-pp.submit_extent_page.__do_readpage.extent_readahead.read_pages.page_cache_readahead_unbounded
      8.04 ±  7%      -7.4        0.61 ±  3%  perf-profile.calltrace.cycles-pp.add_to_page_cache_lru.page_cache_readahead_unbounded.force_page_cache_readahead.generic_file_buffered_read.new_sync_read
      7.08 ±  3%      -7.1        0.00        perf-profile.calltrace.cycles-pp.submit_one_bio.submit_extent_page.__do_readpage.extent_readahead.read_pages
      7.08 ±  3%      -7.1        0.00        perf-profile.calltrace.cycles-pp.btrfs_submit_bio_hook.submit_one_bio.submit_extent_page.__do_readpage.extent_readahead
      6.96 ±  3%      -7.0        0.00        perf-profile.calltrace.cycles-pp.btrfs_map_bio.btrfs_submit_bio_hook.submit_one_bio.submit_extent_page.__do_readpage
      6.95 ±  3%      -6.9        0.00        perf-profile.calltrace.cycles-pp.submit_bio.btrfs_map_bio.btrfs_submit_bio_hook.submit_one_bio.submit_extent_page
      6.63 ±  8%      -6.6        0.00        perf-profile.calltrace.cycles-pp.btrfs_releasepage.shrink_page_list.shrink_inactive_list.shrink_lruvec.shrink_node
      6.53 ±  8%      -6.5        0.00        perf-profile.calltrace.cycles-pp.try_release_extent_mapping.btrfs_releasepage.shrink_page_list.shrink_inactive_list.shrink_lruvec
      6.36 ± 10%      -6.4        0.00        perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages_nodemask.page_cache_readahead_unbounded.force_page_cache_readahead.generic_file_buffered_read
      7.36 ±  3%      -6.2        1.14        perf-profile.calltrace.cycles-pp.copyout.copy_page_to_iter.generic_file_buffered_read.new_sync_read.vfs_read
      7.47 ±  3%      -6.2        1.26        perf-profile.calltrace.cycles-pp.copy_page_to_iter.generic_file_buffered_read.new_sync_read.vfs_read.ksys_read
      6.76 ± 10%      -6.2        0.57 ± 62%  perf-profile.calltrace.cycles-pp.__x64_sys_fadvise64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.76 ± 10%      -6.2        0.57 ± 62%  perf-profile.calltrace.cycles-pp.ksys_fadvise64_64.__x64_sys_fadvise64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.76 ± 10%      -6.2        0.57 ± 62%  perf-profile.calltrace.cycles-pp.generic_fadvise.ksys_fadvise64_64.__x64_sys_fadvise64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.75 ± 10%      -6.2        0.57 ± 62%  perf-profile.calltrace.cycles-pp.invalidate_mapping_pages.generic_fadvise.ksys_fadvise64_64.__x64_sys_fadvise64.do_syscall_64
      7.31 ±  3%      -6.2        1.13        perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyout.copy_page_to_iter.generic_file_buffered_read.new_sync_read
      6.14 ±  8%      -6.1        0.00        perf-profile.calltrace.cycles-pp.lru_cache_add.add_to_page_cache_lru.page_cache_readahead_unbounded.force_page_cache_readahead.generic_file_buffered_read
      6.08 ± 10%      -6.1        0.00        perf-profile.calltrace.cycles-pp.rmqueue.get_page_from_freelist.__alloc_pages_nodemask.page_cache_readahead_unbounded.force_page_cache_readahead
      6.06 ±  8%      -6.1        0.00        perf-profile.calltrace.cycles-pp.pagevec_lru_move_fn.lru_cache_add.add_to_page_cache_lru.page_cache_readahead_unbounded.force_page_cache_readahead
      5.75 ±  4%      -5.8        0.00        perf-profile.calltrace.cycles-pp.submit_one_bio.extent_readahead.read_pages.page_cache_readahead_unbounded.force_page_cache_readahead
      5.75 ±  4%      -5.7        0.00        perf-profile.calltrace.cycles-pp.btrfs_submit_bio_hook.submit_one_bio.extent_readahead.read_pages.page_cache_readahead_unbounded
      5.75 ± 11%      -5.7        0.00        perf-profile.calltrace.cycles-pp.rmqueue_bulk.rmqueue.get_page_from_freelist.__alloc_pages_nodemask.page_cache_readahead_unbounded
      5.65 ±  4%      -5.6        0.00        perf-profile.calltrace.cycles-pp.btrfs_map_bio.btrfs_submit_bio_hook.submit_one_bio.extent_readahead.read_pages
      5.63 ±  4%      -5.6        0.00        perf-profile.calltrace.cycles-pp.submit_bio.btrfs_map_bio.btrfs_submit_bio_hook.submit_one_bio.extent_readahead
      5.20 ±  9%      -5.2        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.pagevec_lru_move_fn.lru_cache_add.add_to_page_cache_lru.page_cache_readahead_unbounded
      5.15 ±  9%      -5.2        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.pagevec_lru_move_fn.lru_cache_add.add_to_page_cache_lru
      4.97 ± 12%      -5.0        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.rmqueue_bulk.rmqueue.get_page_from_freelist.__alloc_pages_nodemask
      4.96 ± 12%      -5.0        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.rmqueue_bulk.rmqueue.get_page_from_freelist
      1.46 ±  5%      -0.7        0.78 ± 22%  perf-profile.calltrace.cycles-pp.kswapd.kthread.ret_from_fork
      1.46 ±  5%      -0.7        0.78 ± 22%  perf-profile.calltrace.cycles-pp.balance_pgdat.kswapd.kthread.ret_from_fork
      1.46 ±  5%      -0.7        0.78 ± 22%  perf-profile.calltrace.cycles-pp.shrink_node.balance_pgdat.kswapd.kthread.ret_from_fork
      1.44 ±  5%      -0.7        0.77 ± 22%  perf-profile.calltrace.cycles-pp.shrink_lruvec.shrink_node.balance_pgdat.kswapd.kthread
      1.44 ±  5%      -0.7        0.77 ± 22%  perf-profile.calltrace.cycles-pp.shrink_inactive_list.shrink_lruvec.shrink_node.balance_pgdat.kswapd
      1.12 ±  4%      -0.5        0.67 ± 22%  perf-profile.calltrace.cycles-pp.shrink_page_list.shrink_inactive_list.shrink_lruvec.shrink_node.balance_pgdat
      0.00            +0.6        0.62 ±  2%  perf-profile.calltrace.cycles-pp.__set_extent_bit.endio_readpage_release_extent.end_bio_extent_readpage.end_workqueue_fn.btrfs_work_helper
      0.00            +0.6        0.63 ±  3%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__sched_text_start.schedule.io_schedule
      0.00            +0.7        0.69 ±  3%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__sched_text_start.schedule.io_schedule.__lock_page_killable
      0.00            +0.7        0.70 ±  3%  perf-profile.calltrace.cycles-pp.find_extent_buffer.read_block_for_search.btrfs_search_slot.btrfs_lookup_csum.btrfs_lookup_bio_sums
      0.00            +0.7        0.71 ±  2%  perf-profile.calltrace.cycles-pp.__set_extent_bit.lock_extent_bits.btrfs_lock_and_flush_ordered_range.extent_read_full_page.generic_file_buffered_read
      0.00            +0.7        0.72 ±  2%  perf-profile.calltrace.cycles-pp.lock_extent_bits.btrfs_lock_and_flush_ordered_range.extent_read_full_page.generic_file_buffered_read.new_sync_read
      0.00            +0.7        0.73 ±  3%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__sched_text_start.schedule_idle.do_idle.cpu_startup_entry
      0.00            +0.7        0.73 ±  3%  perf-profile.calltrace.cycles-pp.__do_readpage.extent_read_full_page.generic_file_buffered_read.new_sync_read.vfs_read
      0.00            +0.8        0.78 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_lock_and_flush_ordered_range.extent_read_full_page.generic_file_buffered_read.new_sync_read.vfs_read
      0.00            +1.0        0.97 ±  4%  perf-profile.calltrace.cycles-pp.__btrfs_map_block.btrfs_map_bio.btrfs_submit_bio_hook.submit_one_bio.extent_read_full_page
      0.00            +1.1        1.05        perf-profile.calltrace.cycles-pp.unwind_next_frame.arch_stack_walk.stack_trace_save_tsk.__account_scheduler_latency.enqueue_entity
      0.00            +1.1        1.06 ± 15%  perf-profile.calltrace.cycles-pp.menu_select.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
      0.00            +1.1        1.15        perf-profile.calltrace.cycles-pp.endio_readpage_release_extent.end_bio_extent_readpage.end_workqueue_fn.btrfs_work_helper.process_one_work
      0.00            +1.2        1.20 ±  4%  perf-profile.calltrace.cycles-pp.read_block_for_search.btrfs_search_slot.btrfs_lookup_csum.btrfs_lookup_bio_sums.btrfs_submit_bio_hook
      0.00            +1.4        1.40        perf-profile.calltrace.cycles-pp.__sched_text_start.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      0.00            +1.4        1.43        perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
      0.00            +1.5        1.45        perf-profile.calltrace.cycles-pp.arch_stack_walk.stack_trace_save_tsk.__account_scheduler_latency.enqueue_entity.enqueue_task_fair
      0.00            +1.6        1.60 ±  2%  perf-profile.calltrace.cycles-pp.__sched_text_start.schedule.io_schedule.__lock_page_killable.generic_file_buffered_read
      0.00            +1.6        1.62 ±  2%  perf-profile.calltrace.cycles-pp.schedule.io_schedule.__lock_page_killable.generic_file_buffered_read.new_sync_read
      0.00            +1.7        1.69        perf-profile.calltrace.cycles-pp.stack_trace_save_tsk.__account_scheduler_latency.enqueue_entity.enqueue_task_fair.ttwu_do_activate
      0.00            +1.7        1.73 ±  2%  perf-profile.calltrace.cycles-pp.io_schedule.__lock_page_killable.generic_file_buffered_read.new_sync_read.vfs_read
      0.00            +1.9        1.87 ±  8%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__account_scheduler_latency.enqueue_entity.enqueue_task_fair
      0.00            +2.2        2.19 ±  7%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__account_scheduler_latency.enqueue_entity.enqueue_task_fair.ttwu_do_activate
      0.00            +2.2        2.23 ±  2%  perf-profile.calltrace.cycles-pp.__lock_page_killable.generic_file_buffered_read.new_sync_read.vfs_read.ksys_read
      0.00            +2.4        2.41 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.worker_thread.kthread.ret_from_fork
      0.00            +2.4        2.43 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.worker_thread.kthread.ret_from_fork
      0.00            +2.6        2.65 ±  6%  perf-profile.calltrace.cycles-pp.btrfs_search_slot.btrfs_lookup_csum.btrfs_lookup_bio_sums.btrfs_submit_bio_hook.submit_one_bio
      0.00            +2.8        2.77 ±  6%  perf-profile.calltrace.cycles-pp.btrfs_lookup_csum.btrfs_lookup_bio_sums.btrfs_submit_bio_hook.submit_one_bio.extent_read_full_page
      0.00            +3.8        3.83 ±  5%  perf-profile.calltrace.cycles-pp.btrfs_lookup_bio_sums.btrfs_submit_bio_hook.submit_one_bio.extent_read_full_page.generic_file_buffered_read
      0.00            +4.1        4.07 ±  5%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      0.00            +4.2        4.24 ±  4%  perf-profile.calltrace.cycles-pp.__account_scheduler_latency.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up
      0.00            +5.0        4.99 ±  4%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.wake_page_function
      0.00            +5.3        5.25 ±  4%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.wake_page_function.__wake_up_common
      0.00            +5.3        5.27 ±  4%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.wake_page_function.__wake_up_common.wake_up_page_bit
      0.15 ±173%      +6.3        6.48 ±  3%  perf-profile.calltrace.cycles-pp.try_to_wake_up.wake_page_function.__wake_up_common.wake_up_page_bit.end_bio_extent_readpage
      0.16 ±173%      +6.4        6.57 ±  3%  perf-profile.calltrace.cycles-pp.wake_page_function.__wake_up_common.wake_up_page_bit.end_bio_extent_readpage.end_workqueue_fn
      0.16 ±173%      +6.5        6.68 ±  3%  perf-profile.calltrace.cycles-pp.__wake_up_common.wake_up_page_bit.end_bio_extent_readpage.end_workqueue_fn.btrfs_work_helper
      2.25 ±  6%      +6.6        8.89 ±  2%  perf-profile.calltrace.cycles-pp.end_bio_extent_readpage.end_workqueue_fn.btrfs_work_helper.process_one_work.worker_thread
      0.17 ±173%      +6.9        7.07 ±  3%  perf-profile.calltrace.cycles-pp.wake_up_page_bit.end_bio_extent_readpage.end_workqueue_fn.btrfs_work_helper.process_one_work
      2.28 ±  6%      +7.2        9.44 ±  2%  perf-profile.calltrace.cycles-pp.end_workqueue_fn.btrfs_work_helper.process_one_work.worker_thread.kthread
      2.29 ±  6%      +7.3        9.64 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_work_helper.process_one_work.worker_thread.kthread.ret_from_fork
     12.56 ±  3%     +12.2       24.80 ±  3%  perf-profile.calltrace.cycles-pp.pmem_submit_bio.submit_bio_noacct.submit_bio.btrfs_map_bio.btrfs_submit_bio_hook
     12.57 ±  3%     +12.5       25.04 ±  3%  perf-profile.calltrace.cycles-pp.submit_bio_noacct.submit_bio.btrfs_map_bio.btrfs_submit_bio_hook.submit_one_bio
      0.00           +20.6       20.61 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.process_one_work.worker_thread.kthread
      0.00           +20.8       20.77 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.process_one_work.worker_thread.kthread.ret_from_fork
      0.00           +21.4       21.39 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__queue_work.queue_work_on.btrfs_end_bio
      0.00           +21.6       21.57 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__queue_work.queue_work_on.btrfs_end_bio.pmem_submit_bio
      0.00           +22.5       22.49 ±  3%  perf-profile.calltrace.cycles-pp.__queue_work.queue_work_on.btrfs_end_bio.pmem_submit_bio.submit_bio_noacct
      0.00           +22.7       22.66 ±  3%  perf-profile.calltrace.cycles-pp.queue_work_on.btrfs_end_bio.pmem_submit_bio.submit_bio_noacct.submit_bio
      0.00           +22.9       22.85 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_end_bio.pmem_submit_bio.submit_bio_noacct.submit_bio.btrfs_map_bio
      0.00           +25.1       25.05 ±  3%  perf-profile.calltrace.cycles-pp.submit_bio.btrfs_map_bio.btrfs_submit_bio_hook.submit_one_bio.extent_read_full_page
      0.00           +26.4       26.43 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_map_bio.btrfs_submit_bio_hook.submit_one_bio.extent_read_full_page.generic_file_buffered_read
      2.33 ±  6%     +28.8       31.13 ±  3%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork
      0.00           +30.4       30.44 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_submit_bio_hook.submit_one_bio.extent_read_full_page.generic_file_buffered_read.new_sync_read
      0.00           +30.5       30.45 ±  3%  perf-profile.calltrace.cycles-pp.submit_one_bio.extent_read_full_page.generic_file_buffered_read.new_sync_read.vfs_read
      4.00 ±  5%     +31.0       34.98 ±  3%  perf-profile.calltrace.cycles-pp.ret_from_fork
      4.00 ±  5%     +31.0       34.98 ±  3%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
      2.46 ±  6%     +31.7       34.13 ±  2%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork
      0.00           +32.0       31.99 ±  3%  perf-profile.calltrace.cycles-pp.extent_read_full_page.generic_file_buffered_read.new_sync_read.vfs_read.ksys_read
     45.25 ±  4%     -44.1        1.16 ±  3%  perf-profile.children.cycles-pp.force_page_cache_readahead
     45.25 ±  4%     -44.1        1.16 ±  3%  perf-profile.children.cycles-pp.page_cache_readahead_unbounded
     62.81 ±  4%     -24.3       38.47 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     62.81 ±  4%     -24.3       38.46 ±  2%  perf-profile.children.cycles-pp.do_syscall_64
     21.84 ±  6%     -21.5        0.35 ±  3%  perf-profile.children.cycles-pp.__alloc_pages_nodemask
     55.94 ±  4%     -18.2       37.74 ±  3%  perf-profile.children.cycles-pp.vfs_read
     55.94 ±  4%     -18.2       37.74 ±  3%  perf-profile.children.cycles-pp.ksys_read
     55.92 ±  4%     -18.2       37.73 ±  3%  perf-profile.children.cycles-pp.generic_file_buffered_read
     55.92 ±  4%     -18.2       37.73 ±  3%  perf-profile.children.cycles-pp.new_sync_read
     16.14 ±  5%     -15.4        0.78 ± 22%  perf-profile.children.cycles-pp.shrink_node
     15.33 ±  5%     -15.3        0.00        perf-profile.children.cycles-pp.__alloc_pages_slowpath
     16.02 ±  5%     -15.2        0.77 ± 22%  perf-profile.children.cycles-pp.shrink_lruvec
     16.00 ±  5%     -15.2        0.77 ± 22%  perf-profile.children.cycles-pp.shrink_inactive_list
     15.09 ±  3%     -15.1        0.00        perf-profile.children.cycles-pp.extent_readahead
     15.10 ±  3%     -15.0        0.10 ±  4%  perf-profile.children.cycles-pp.read_pages
     14.69 ±  6%     -14.7        0.00        perf-profile.children.cycles-pp.try_to_free_pages
     14.69 ±  6%     -14.7        0.00        perf-profile.children.cycles-pp.do_try_to_free_pages
     12.79 ±  6%     -12.1        0.67 ± 21%  perf-profile.children.cycles-pp.shrink_page_list
     12.36 ±  3%     -10.7        1.70 ±  3%  perf-profile.children.cycles-pp.pmem_do_read
     12.27 ±  3%     -10.6        1.68 ±  3%  perf-profile.children.cycles-pp.__memcpy_mcsafe
      8.71 ±  3%      -8.0        0.73 ±  2%  perf-profile.children.cycles-pp.__do_readpage
      8.11 ±  3%      -7.7        0.43        perf-profile.children.cycles-pp.submit_extent_page
      8.04 ±  7%      -7.4        0.62 ±  4%  perf-profile.children.cycles-pp.add_to_page_cache_lru
      7.58 ±  7%      -7.2        0.38 ±  6%  perf-profile.children.cycles-pp.btrfs_releasepage
      7.39 ±  7%      -7.1        0.33 ±  7%  perf-profile.children.cycles-pp.try_release_extent_mapping
     10.55 ±  7%      -7.0        3.59 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      6.95 ±  9%      -6.6        0.31 ±  3%  perf-profile.children.cycles-pp.get_page_from_freelist
      6.64 ± 10%      -6.4        0.25 ±  4%  perf-profile.children.cycles-pp.rmqueue
      7.36 ±  3%      -6.2        1.14        perf-profile.children.cycles-pp.copyout
      7.48 ±  3%      -6.2        1.27        perf-profile.children.cycles-pp.copy_page_to_iter
      7.35 ±  3%      -6.2        1.14        perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      6.76 ± 10%      -6.1        0.68 ± 29%  perf-profile.children.cycles-pp.__x64_sys_fadvise64
      6.76 ± 10%      -6.1        0.68 ± 29%  perf-profile.children.cycles-pp.ksys_fadvise64_64
      6.76 ± 10%      -6.1        0.68 ± 29%  perf-profile.children.cycles-pp.generic_fadvise
      6.76 ± 10%      -6.1        0.68 ± 29%  perf-profile.children.cycles-pp.invalidate_mapping_pages
      6.23 ± 10%      -6.0        0.18 ±  4%  perf-profile.children.cycles-pp.rmqueue_bulk
      6.14 ±  8%      -5.9        0.26 ±  5%  perf-profile.children.cycles-pp.lru_cache_add
      6.09 ±  8%      -5.9        0.23 ±  6%  perf-profile.children.cycles-pp.pagevec_lru_move_fn
      5.11 ±  5%      -4.8        0.35 ±  6%  perf-profile.children.cycles-pp.__remove_mapping
      4.91 ± 12%      -4.7        0.26 ± 27%  perf-profile.children.cycles-pp.release_pages
      4.82 ± 13%      -4.6        0.24 ± 28%  perf-profile.children.cycles-pp.__pagevec_release
      3.23 ±  7%      -3.1        0.12 ±  5%  perf-profile.children.cycles-pp.test_range_bit
      3.82 ±  7%      -3.1        0.71 ±  2%  perf-profile.children.cycles-pp.__clear_extent_bit
      2.80 ±  9%      -2.6        0.23 ±  6%  perf-profile.children.cycles-pp.free_unref_page_list
      2.66 ± 10%      -2.5        0.18 ±  6%  perf-profile.children.cycles-pp.free_pcppages_bulk
      2.17 ±  4%      -2.0        0.14 ±  3%  perf-profile.children.cycles-pp.crc_128
      1.87 ±  4%      -1.5        0.35        perf-profile.children.cycles-pp.__add_to_page_cache_locked
      1.74 ±  4%      -1.4        0.36        perf-profile.children.cycles-pp.__list_del_entry_valid
      1.19 ±  3%      -1.1        0.08 ±  5%  perf-profile.children.cycles-pp.crc_42
      1.20            -1.0        0.23 ±  8%  perf-profile.children.cycles-pp.__delete_from_page_cache
      1.05 ±  3%      -0.8        0.23 ±  4%  perf-profile.children.cycles-pp.pagecache_get_page
      1.03 ±  3%      -0.8        0.22 ±  3%  perf-profile.children.cycles-pp.find_get_entry
      0.85 ±  3%      -0.7        0.12 ±  5%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.86 ±  4%      -0.7        0.14 ±  3%  perf-profile.children.cycles-pp.mem_cgroup_charge
      1.46 ±  5%      -0.7        0.78 ± 22%  perf-profile.children.cycles-pp.kswapd
      1.46 ±  5%      -0.7        0.78 ± 22%  perf-profile.children.cycles-pp.balance_pgdat
      0.73 ±  3%      -0.5        0.19 ±  8%  perf-profile.children.cycles-pp.xas_store
      0.68 ±  4%      -0.5        0.16 ±  6%  perf-profile.children.cycles-pp.__pagevec_lru_add_fn
      0.67 ±  5%      -0.5        0.15 ± 29%  perf-profile.children.cycles-pp.remove_mapping
      0.85 ±  2%      -0.5        0.38 ±  5%  perf-profile.children.cycles-pp.btrfs_get_io_geometry
      0.53 ±  5%      -0.5        0.07 ±  6%  perf-profile.children.cycles-pp.__mod_memcg_state
      0.52 ±  2%      -0.4        0.08 ±  5%  perf-profile.children.cycles-pp.crc_104
      0.71 ±  6%      -0.4        0.28 ±  6%  perf-profile.children.cycles-pp.xas_load
      0.48 ±  3%      -0.4        0.07 ± 11%  perf-profile.children.cycles-pp.unaccount_page_cache_page
      0.43 ±  5%      -0.4        0.04 ± 57%  perf-profile.children.cycles-pp.crc_112
      0.45 ±  3%      -0.4        0.08 ± 23%  perf-profile.children.cycles-pp.isolate_lru_pages
      0.50 ±  3%      -0.4        0.14 ± 31%  perf-profile.children.cycles-pp.invalidate_inode_page
      0.41 ±  8%      -0.4        0.05 ± 62%  perf-profile.children.cycles-pp.pagevec_lookup_entries
      0.41 ±  8%      -0.4        0.05 ± 62%  perf-profile.children.cycles-pp.find_get_entries
      0.41 ±  3%      -0.3        0.07 ± 13%  perf-profile.children.cycles-pp.mem_cgroup_uncharge_list
      0.73            -0.3        0.44 ±  5%  perf-profile.children.cycles-pp.btrfs_get_chunk_map
      0.33 ±  4%      -0.3        0.04 ± 58%  perf-profile.children.cycles-pp.uncharge_batch
      0.34 ±  3%      -0.3        0.07 ± 19%  perf-profile.children.cycles-pp.xas_create
      0.29 ±  4%      -0.3        0.03 ±100%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.29 ±  4%      -0.3        0.03 ±100%  perf-profile.children.cycles-pp.page_counter_cancel
      0.32 ±  2%      -0.2        0.07 ±  6%  perf-profile.children.cycles-pp.try_charge
      0.25            -0.2        0.06 ± 14%  perf-profile.children.cycles-pp.xas_init_marks
      0.22 ±  3%      -0.2        0.05 ±  8%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.25 ±  7%      -0.2        0.08 ±  5%  perf-profile.children.cycles-pp.xa_load
      0.29            -0.1        0.16 ±  4%  perf-profile.children.cycles-pp.unlock_page
      0.21 ±  2%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.free_extent_map
      0.20 ±  5%      -0.1        0.07        perf-profile.children.cycles-pp.__crc32c_pcl_intel_finup
      0.18 ±  6%      -0.1        0.06        perf-profile.children.cycles-pp.kernel_fpu_begin
      0.29 ±  2%      -0.1        0.19 ± 13%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.21 ±  2%      -0.1        0.12 ±  3%  perf-profile.children.cycles-pp.tick_sched_timer
      0.19            -0.1        0.11 ±  4%  perf-profile.children.cycles-pp.tick_sched_handle
      0.19            -0.1        0.11 ±  4%  perf-profile.children.cycles-pp.update_process_times
      0.20 ±  5%      -0.1        0.12 ±  4%  perf-profile.children.cycles-pp.clean_io_failure
      0.13            -0.1        0.07 ±  7%  perf-profile.children.cycles-pp.scheduler_tick
      0.20 ±  7%      -0.1        0.14 ±  3%  perf-profile.children.cycles-pp.btrfs_readpage_end_io_hook
      0.17 ±  4%      -0.1        0.12 ±  3%  perf-profile.children.cycles-pp.count_range_bits
      0.15 ±  8%      -0.0        0.12        perf-profile.children.cycles-pp.check_data_csum
      0.22 ±  3%      -0.0        0.19 ±  5%  perf-profile.children.cycles-pp.__lookup_extent_mapping
      0.14 ±  3%      -0.0        0.12 ±  5%  perf-profile.children.cycles-pp.__softirqentry_text_start
      0.08 ±  6%      -0.0        0.06        perf-profile.children.cycles-pp.bio_add_page
      0.07 ± 12%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp._cond_resched
      0.08 ±  5%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.newidle_balance
      0.11 ±  4%      +0.0        0.15 ±  5%  perf-profile.children.cycles-pp.free_extent_state
      0.06 ±  6%      +0.0        0.11 ±  6%  perf-profile.children.cycles-pp.do_softirq_own_stack
      0.05            +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.__might_sleep
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.rcu_all_qs
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.stack_access_ok
      0.00            +0.1        0.05 ±  9%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.rebalance_domains
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.rcu_eqs_exit
      0.00            +0.1        0.06 ± 20%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.in_sched_functions
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.btrfs_buffer_uptodate
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.account_entity_enqueue
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.btrfs_bio_wq_end_io
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.call_cpuidle
      0.08 ± 10%      +0.1        0.15 ±  2%  perf-profile.children.cycles-pp.__list_add_valid
      0.01 ±173%      +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.___slab_alloc
      0.08 ±  6%      +0.1        0.14 ± 15%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.place_entity
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.flush_smp_call_function_from_idle
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.bio_associate_blkg
      0.00            +0.1        0.07 ± 11%  perf-profile.children.cycles-pp.rcu_eqs_enter
      0.01 ±173%      +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.__slab_alloc
      0.00            +0.1        0.08 ± 11%  perf-profile.children.cycles-pp.move_linked_works
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.blk_throtl_bio
      0.00            +0.1        0.08 ±  8%  perf-profile.children.cycles-pp.update_stats_enqueue_sleeper
      0.00            +0.1        0.08 ±  8%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.00            +0.1        0.08 ± 19%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.00            +0.1        0.08 ± 15%  perf-profile.children.cycles-pp.btrfs_set_path_blocking
      0.56 ±  4%      +0.1        0.65 ±  9%  perf-profile.children.cycles-pp.asm_call_on_stack
      0.00            +0.1        0.09        perf-profile.children.cycles-pp.account_entity_dequeue
      0.00            +0.1        0.09 ±  7%  perf-profile.children.cycles-pp.available_idle_cpu
      0.00            +0.1        0.09        perf-profile.children.cycles-pp.__might_fault
      0.00            +0.1        0.09 ±  7%  perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.00            +0.1        0.09 ±  8%  perf-profile.children.cycles-pp.select_idle_sibling
      0.00            +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.alloc_btrfs_bio
      0.00            +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.__kmalloc
      0.00            +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.update_ts_time_stats
      0.00            +0.1        0.09 ± 14%  perf-profile.children.cycles-pp.hrtimer_get_next_event
      0.00            +0.1        0.10 ±  5%  perf-profile.children.cycles-pp.__wake_up_common_lock
      0.00            +0.1        0.10 ±  5%  perf-profile.children.cycles-pp.rcu_idle_exit
      0.00            +0.1        0.10 ±  5%  perf-profile.children.cycles-pp.insert_state
      0.00            +0.1        0.10 ± 18%  perf-profile.children.cycles-pp.check_setget_bounds
      0.00            +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.___perf_sw_event
      0.00            +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.00            +0.1        0.10 ±  8%  perf-profile.children.cycles-pp.update_cfs_rq_h_load
      0.42 ±  3%      +0.1        0.52        perf-profile.children.cycles-pp.clear_state_bit
      0.00            +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.__unwind_start
      0.00            +0.1        0.11 ±  4%  perf-profile.children.cycles-pp.btrfs_get_extent
      0.00            +0.1        0.11 ±  4%  perf-profile.children.cycles-pp.btrfs_comp_cpu_keys
      0.00            +0.1        0.11 ±  4%  perf-profile.children.cycles-pp.resched_curr
      0.00            +0.1        0.11 ±  6%  perf-profile.children.cycles-pp.btrfs_put_bbio
      0.00            +0.1        0.11 ±  7%  perf-profile.children.cycles-pp.kernel_text_address
      0.00            +0.1        0.11 ±  7%  perf-profile.children.cycles-pp.mark_extent_buffer_accessed
      0.00            +0.1        0.11 ±  7%  perf-profile.children.cycles-pp.pick_next_entity
      0.15 ±  3%      +0.1        0.26 ±  4%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.00            +0.1        0.12 ±  3%  perf-profile.children.cycles-pp.orc_find
      0.12 ±  6%      +0.1        0.24        perf-profile.children.cycles-pp.___might_sleep
      0.60 ±  4%      +0.1        0.72        perf-profile.children.cycles-pp.__etree_search
      0.00            +0.1        0.12 ±  3%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.00            +0.1        0.12 ±  6%  perf-profile.children.cycles-pp.reweight_entity
      0.00            +0.1        0.12 ±  4%  perf-profile.children.cycles-pp.update_cfs_group
      0.00            +0.1        0.13 ± 13%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.00            +0.1        0.13 ±  3%  perf-profile.children.cycles-pp.stack_trace_consume_entry_nosched
      0.00            +0.1        0.13 ± 20%  perf-profile.children.cycles-pp.btrfs_tree_read_lock
      0.00            +0.1        0.14 ± 10%  perf-profile.children.cycles-pp.read_tsc
      0.00            +0.1        0.14 ±  5%  perf-profile.children.cycles-pp.__kernel_text_address
      0.00            +0.1        0.14 ±  5%  perf-profile.children.cycles-pp.bio_endio
      0.00            +0.1        0.15 ±  3%  perf-profile.children.cycles-pp.btrfs_bio_counter_inc_blocked
      0.00            +0.1        0.15 ±  3%  perf-profile.children.cycles-pp.btrfs_find_ordered_sum
      0.00            +0.1        0.15 ± 11%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.00            +0.2        0.15 ±  4%  perf-profile.children.cycles-pp.btrfs_get_64
      0.00            +0.2        0.15 ±  4%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.00            +0.2        0.15 ± 12%  perf-profile.children.cycles-pp.btrfs_verify_level_key
      0.11 ±  4%      +0.2        0.26 ± 11%  perf-profile.children.cycles-pp.ktime_get
      0.00            +0.2        0.16 ±  2%  perf-profile.children.cycles-pp.check_preempt_curr
      0.00            +0.2        0.17 ±  5%  perf-profile.children.cycles-pp.delayacct_end
      0.00            +0.2        0.17 ±  3%  perf-profile.children.cycles-pp.ttwu_do_wakeup
      0.00            +0.2        0.17 ± 14%  perf-profile.children.cycles-pp.btrfs_tree_read_lock_atomic
      0.00            +0.2        0.17 ±  4%  perf-profile.children.cycles-pp.cache_state_if_flags
      0.00            +0.2        0.17 ±  4%  perf-profile.children.cycles-pp.unwind_get_return_address
      0.05 ±  8%      +0.2        0.23 ±  2%  perf-profile.children.cycles-pp.finish_task_switch
      0.03 ±100%      +0.2        0.20 ±  4%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.01 ±173%      +0.2        0.19 ±  4%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.00            +0.2        0.18 ±  2%  perf-profile.children.cycles-pp.bvec_alloc
      0.00            +0.2        0.18 ±  8%  perf-profile.children.cycles-pp.pwq_activate_delayed_work
      0.04 ± 58%      +0.2        0.23 ±  4%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.00            +0.2        0.19 ±  5%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.00            +0.2        0.19 ±  3%  perf-profile.children.cycles-pp.btrfs_bio_counter_sub
      0.06 ± 14%      +0.2        0.25 ±  4%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.00            +0.2        0.20 ±  2%  perf-profile.children.cycles-pp.__switch_to
      0.00            +0.2        0.20 ±  5%  perf-profile.children.cycles-pp.submit_bio_checks
      0.00            +0.2        0.20 ±  5%  perf-profile.children.cycles-pp.generic_bin_search
      0.00            +0.2        0.20 ±  9%  perf-profile.children.cycles-pp.native_sched_clock
      0.00            +0.2        0.20 ±  2%  perf-profile.children.cycles-pp.__orc_find
      0.00            +0.2        0.21 ± 11%  perf-profile.children.cycles-pp.sched_clock
      0.00            +0.2        0.22 ± 13%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.00            +0.2        0.22 ±  4%  perf-profile.children.cycles-pp.__switch_to_asm
      0.25 ±  7%      +0.2        0.47 ±  2%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.00            +0.2        0.23 ±  3%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.00            +0.2        0.23 ± 10%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.00            +0.2        0.23 ±  5%  perf-profile.children.cycles-pp.read_extent_buffer
      0.05 ±  8%      +0.2        0.28 ±  2%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.00            +0.2        0.25 ±  9%  perf-profile.children.cycles-pp.btrfs_tree_read_unlock
      0.00            +0.3        0.26 ±  4%  perf-profile.children.cycles-pp.__radix_tree_lookup
      0.00            +0.3        0.26 ±  3%  perf-profile.children.cycles-pp.update_curr
      0.07            +0.3        0.33        perf-profile.children.cycles-pp.merge_state
      0.05 ±  8%      +0.3        0.32        perf-profile.children.cycles-pp.update_rq_clock
      0.00            +0.3        0.27 ±  3%  perf-profile.children.cycles-pp.mempool_alloc
      0.00            +0.3        0.27        perf-profile.children.cycles-pp.bio_free
      0.00            +0.3        0.27 ±  5%  perf-profile.children.cycles-pp.pwq_dec_nr_in_flight
      0.00            +0.3        0.28 ±  4%  perf-profile.children.cycles-pp.down_read
      0.00            +0.3        0.29 ±  5%  perf-profile.children.cycles-pp.insert_work
      0.00            +0.3        0.32 ±  2%  perf-profile.children.cycles-pp.bio_alloc_bioset
      0.00            +0.3        0.34 ±  3%  perf-profile.children.cycles-pp.btrfs_bio_alloc
      0.00            +0.4        0.35 ±  2%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.00            +0.4        0.37 ±  2%  perf-profile.children.cycles-pp.free_extent_buffer
      0.00            +0.4        0.38 ± 13%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.00            +0.4        0.41 ±  2%  perf-profile.children.cycles-pp.__slab_free
      0.00            +0.4        0.43 ± 10%  perf-profile.children.cycles-pp.btrfs_root_node
      0.00            +0.4        0.45 ±  3%  perf-profile.children.cycles-pp.btrfs_free_path
      0.00            +0.4        0.45 ±  3%  perf-profile.children.cycles-pp.btrfs_release_path
      0.01 ±173%      +0.5        0.52 ±  2%  perf-profile.children.cycles-pp.set_next_entity
      0.18 ±  2%      +0.5        0.70        perf-profile.children.cycles-pp.kmem_cache_free
      0.00            +0.6        0.57 ± 12%  perf-profile.children.cycles-pp.btrfs_read_lock_root_node
      0.15 ±  8%      +0.6        0.72 ±  2%  perf-profile.children.cycles-pp.lock_extent_bits
      0.17 ±  8%      +0.6        0.79 ±  3%  perf-profile.children.cycles-pp.btrfs_lock_and_flush_ordered_range
      0.06 ± 11%      +0.6        0.69 ±  3%  perf-profile.children.cycles-pp.dequeue_entity
      0.04 ± 58%      +0.7        0.71 ±  4%  perf-profile.children.cycles-pp.find_extent_buffer
      0.10 ± 12%      +0.7        0.77 ±  2%  perf-profile.children.cycles-pp.update_load_avg
      0.07 ± 13%      +0.7        0.74 ±  3%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.14 ±  5%      +0.7        0.89 ±  2%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.00            +1.0        0.97 ±  4%  perf-profile.children.cycles-pp.__btrfs_map_block
      0.17 ±  4%      +1.0        1.15        perf-profile.children.cycles-pp.endio_readpage_release_extent
      0.11 ± 14%      +1.0        1.11        perf-profile.children.cycles-pp.unwind_next_frame
      0.07 ± 15%      +1.0        1.08 ± 15%  perf-profile.children.cycles-pp.menu_select
      0.22 ±  6%      +1.1        1.34        perf-profile.children.cycles-pp.__set_extent_bit
      0.07 ± 10%      +1.1        1.20 ±  4%  perf-profile.children.cycles-pp.read_block_for_search
      0.16 ± 11%      +1.3        1.45 ±  2%  perf-profile.children.cycles-pp.schedule_idle
      0.16 ± 14%      +1.4        1.55        perf-profile.children.cycles-pp.arch_stack_walk
      0.19 ± 13%      +1.6        1.79        perf-profile.children.cycles-pp.stack_trace_save_tsk
      0.13 ± 16%      +1.6        1.73 ±  2%  perf-profile.children.cycles-pp.io_schedule
      0.24 ±  9%      +1.6        1.86 ±  2%  perf-profile.children.cycles-pp.schedule
      0.00            +2.2        2.23 ±  2%  perf-profile.children.cycles-pp.__lock_page_killable
      0.11 ±  4%      +2.6        2.66 ±  6%  perf-profile.children.cycles-pp.btrfs_search_slot
      0.11 ±  4%      +2.7        2.77 ±  6%  perf-profile.children.cycles-pp.btrfs_lookup_csum
      0.40 ±  8%      +2.8        3.19 ±  2%  perf-profile.children.cycles-pp.__sched_text_start
      0.21 ±  3%      +3.6        3.84 ±  5%  perf-profile.children.cycles-pp.btrfs_lookup_bio_sums
      0.23 ± 19%      +3.9        4.12 ±  5%  perf-profile.children.cycles-pp.poll_idle
      0.31 ± 16%      +4.4        4.66 ±  4%  perf-profile.children.cycles-pp.__account_scheduler_latency
      0.41 ± 16%      +5.1        5.52 ±  4%  perf-profile.children.cycles-pp.enqueue_entity
      0.43 ± 16%      +5.3        5.73 ±  4%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.43 ± 16%      +5.3        5.75 ±  4%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.47 ± 20%      +6.1        6.57 ±  3%  perf-profile.children.cycles-pp.wake_page_function
      0.48 ± 20%      +6.2        6.69 ±  3%  perf-profile.children.cycles-pp.__wake_up_common
      0.57 ± 15%      +6.6        7.16 ±  2%  perf-profile.children.cycles-pp.try_to_wake_up
      2.26 ±  6%      +6.6        8.89 ±  2%  perf-profile.children.cycles-pp.end_bio_extent_readpage
      0.51 ± 20%      +6.7        7.21 ±  3%  perf-profile.children.cycles-pp.wake_up_page_bit
      2.28 ±  6%      +7.2        9.44 ±  2%  perf-profile.children.cycles-pp.end_workqueue_fn
      2.29 ±  6%      +7.3        9.64 ±  2%  perf-profile.children.cycles-pp.btrfs_work_helper
     12.79 ±  7%      +9.5       22.29 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock
     12.56 ±  3%     +12.2       24.80 ±  3%  perf-profile.children.cycles-pp.pmem_submit_bio
     12.57 ±  3%     +12.5       25.05 ±  3%  perf-profile.children.cycles-pp.submit_bio_noacct
     12.58 ±  3%     +12.5       25.05 ±  3%  perf-profile.children.cycles-pp.submit_bio
     12.60 ±  3%     +13.8       26.43 ±  3%  perf-profile.children.cycles-pp.btrfs_map_bio
     12.83 ±  3%     +17.6       30.44 ±  3%  perf-profile.children.cycles-pp.btrfs_submit_bio_hook
     12.83 ±  3%     +17.6       30.46 ±  3%  perf-profile.children.cycles-pp.submit_one_bio
      2.95 ±  3%     +20.6       23.53 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_irq
     25.15 ±  6%     +21.8       46.99 ±  3%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.11 ±  6%     +22.4       22.49 ±  3%  perf-profile.children.cycles-pp.__queue_work
      0.11 ±  6%     +22.6       22.67 ±  3%  perf-profile.children.cycles-pp.queue_work_on
      0.12 ±  5%     +22.7       22.85 ±  3%  perf-profile.children.cycles-pp.btrfs_end_bio
      2.33 ±  6%     +28.8       31.14 ±  3%  perf-profile.children.cycles-pp.process_one_work
      4.00 ±  5%     +31.0       34.98 ±  3%  perf-profile.children.cycles-pp.ret_from_fork
      4.00 ±  5%     +31.0       34.98 ±  3%  perf-profile.children.cycles-pp.kthread
      2.46 ±  6%     +31.7       34.13 ±  2%  perf-profile.children.cycles-pp.worker_thread
      0.00           +32.0       31.99 ±  3%  perf-profile.children.cycles-pp.extent_read_full_page
     12.14 ±  3%     -10.5        1.66 ±  3%  perf-profile.self.cycles-pp.__memcpy_mcsafe
      7.29 ±  3%      -6.2        1.14        perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      2.16 ±  4%      -2.0        0.14 ±  3%  perf-profile.self.cycles-pp.crc_128
      1.73 ±  4%      -1.4        0.36 ±  2%  perf-profile.self.cycles-pp.__list_del_entry_valid
      1.83 ±  2%      -1.3        0.50        perf-profile.self.cycles-pp.generic_file_buffered_read
      1.19 ±  3%      -1.1        0.08 ±  5%  perf-profile.self.cycles-pp.crc_42
      1.11 ±  3%      -0.7        0.40        perf-profile.self.cycles-pp.end_bio_extent_readpage
      0.80 ±  3%      -0.7        0.10 ±  7%  perf-profile.self.cycles-pp.find_get_entry
      0.69 ±  3%      -0.6        0.13 ±  3%  perf-profile.self.cycles-pp.free_pcppages_bulk
      0.52 ±  5%      -0.5        0.07 ±  7%  perf-profile.self.cycles-pp.__mod_memcg_state
      0.52 ±  3%      -0.4        0.08 ±  5%  perf-profile.self.cycles-pp.crc_104
      0.43 ±  5%      -0.4        0.04 ± 57%  perf-profile.self.cycles-pp.crc_112
      0.61 ±  6%      -0.4        0.24 ±  6%  perf-profile.self.cycles-pp.xas_load
      0.37 ±  8%      -0.3        0.03 ±102%  perf-profile.self.cycles-pp.find_get_entries
      0.33 ±  4%      -0.3        0.05 ±  9%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.27 ±  6%      -0.2        0.03 ±100%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.28 ±  5%      -0.2        0.04 ± 60%  perf-profile.self.cycles-pp.xas_create
      0.28 ±  4%      -0.2        0.06        perf-profile.self.cycles-pp.__add_to_page_cache_locked
      0.32            -0.2        0.12 ±  7%  perf-profile.self.cycles-pp.__do_readpage
      0.25 ±  7%      -0.2        0.07 ± 11%  perf-profile.self.cycles-pp.__pagevec_lru_add_fn
      0.17 ±  4%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.release_pages
      0.17            -0.1        0.03 ±102%  perf-profile.self.cycles-pp.shrink_page_list
      0.29 ±  2%      -0.1        0.15 ±  3%  perf-profile.self.cycles-pp.unlock_page
      0.21 ±  3%      -0.1        0.08 ±  8%  perf-profile.self.cycles-pp.btrfs_get_chunk_map
      0.21            -0.1        0.08 ±  5%  perf-profile.self.cycles-pp.free_extent_map
      0.17 ±  6%      -0.1        0.06        perf-profile.self.cycles-pp.kernel_fpu_begin
      0.15 ±  3%      -0.1        0.06 ± 11%  perf-profile.self.cycles-pp.xas_store
      0.12 ±  6%      -0.0        0.08 ± 10%  perf-profile.self.cycles-pp.rmqueue_bulk
      0.06            -0.0        0.03 ±100%  perf-profile.self.cycles-pp.rb_next
      0.21 ±  2%      -0.0        0.19 ±  4%  perf-profile.self.cycles-pp.__lookup_extent_mapping
      0.08 ±  5%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.__clear_extent_bit
      0.09 ±  4%      +0.0        0.13 ± 11%  perf-profile.self.cycles-pp.ktime_get
      0.10 ±  4%      +0.0        0.14 ±  5%  perf-profile.self.cycles-pp.free_extent_state
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.btrfs_work_helper
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.btrfs_bio_counter_inc_blocked
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.stack_access_ok
      0.00            +0.1        0.05 ±  9%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.read_block_for_search
      0.08 ± 10%      +0.1        0.14        perf-profile.self.cycles-pp.__list_add_valid
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.btrfs_lookup_csum
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.call_cpuidle
      0.01 ±173%      +0.1        0.08 ±  5%  perf-profile.self.cycles-pp.__might_sleep
      0.00            +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.account_entity_enqueue
      0.00            +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.00            +0.1        0.07 ±  6%  perf-profile.self.cycles-pp.dequeue_entity
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.stack_trace_consume_entry_nosched
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.place_entity
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.queue_work_on
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.finish_task_switch
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.___slab_alloc
      0.00            +0.1        0.08 ±  8%  perf-profile.self.cycles-pp.update_stats_enqueue_sleeper
      0.00            +0.1        0.08 ±  8%  perf-profile.self.cycles-pp.__set_extent_bit
      0.00            +0.1        0.08        perf-profile.self.cycles-pp.select_task_rq_fair
      0.00            +0.1        0.08 ±  5%  perf-profile.self.cycles-pp.___perf_sw_event
      0.00            +0.1        0.09 ± 17%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.00            +0.1        0.09 ±  4%  perf-profile.self.cycles-pp.pwq_dec_nr_in_flight
      0.00            +0.1        0.09 ±  4%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.00            +0.1        0.09 ± 20%  perf-profile.self.cycles-pp.btrfs_verify_level_key
      0.00            +0.1        0.09        perf-profile.self.cycles-pp.account_entity_dequeue
      0.00            +0.1        0.09 ±  7%  perf-profile.self.cycles-pp.available_idle_cpu
      0.00            +0.1        0.09 ±  4%  perf-profile.self.cycles-pp.worker_thread
      0.00            +0.1        0.10 ± 21%  perf-profile.self.cycles-pp.check_setget_bounds
      0.00            +0.1        0.10 ±  4%  perf-profile.self.cycles-pp.__unwind_start
      0.00            +0.1        0.10 ±  4%  perf-profile.self.cycles-pp.wake_up_page_bit
      0.00            +0.1        0.10 ±  8%  perf-profile.self.cycles-pp.generic_bin_search
      0.00            +0.1        0.10 ±  4%  perf-profile.self.cycles-pp.btrfs_submit_bio_hook
      0.00            +0.1        0.10 ±  4%  perf-profile.self.cycles-pp.schedule
      0.00            +0.1        0.10 ±  4%  perf-profile.self.cycles-pp.btrfs_comp_cpu_keys
      0.00            +0.1        0.10 ±  4%  perf-profile.self.cycles-pp.newidle_balance
      0.00            +0.1        0.10 ±  8%  perf-profile.self.cycles-pp.update_cfs_rq_h_load
      0.00            +0.1        0.11 ± 10%  perf-profile.self.cycles-pp.pwq_activate_delayed_work
      0.00            +0.1        0.11 ±  4%  perf-profile.self.cycles-pp.resched_curr
      0.00            +0.1        0.11 ±  6%  perf-profile.self.cycles-pp.orc_find
      0.00            +0.1        0.11 ±  6%  perf-profile.self.cycles-pp.btrfs_find_ordered_sum
      0.00            +0.1        0.11 ±  6%  perf-profile.self.cycles-pp.btrfs_put_bbio
      0.00            +0.1        0.11 ±  7%  perf-profile.self.cycles-pp.pick_next_entity
      0.00            +0.1        0.12        perf-profile.self.cycles-pp.__wake_up_common
      0.59 ±  4%      +0.1        0.71        perf-profile.self.cycles-pp.__etree_search
      0.11 ±  9%      +0.1        0.24 ±  3%  perf-profile.self.cycles-pp.___might_sleep
      0.00            +0.1        0.12 ±  3%  perf-profile.self.cycles-pp.update_cfs_group
      0.00            +0.1        0.12 ±  3%  perf-profile.self.cycles-pp.nr_iowait_cpu
      0.00            +0.1        0.12 ±  6%  perf-profile.self.cycles-pp.reweight_entity
      0.00            +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.bio_endio
      0.00            +0.1        0.13 ±  9%  perf-profile.self.cycles-pp.read_tsc
      0.00            +0.1        0.13 ± 12%  perf-profile.self.cycles-pp.btrfs_search_slot
      0.15 ±  5%      +0.1        0.30 ±  3%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.08            +0.1        0.22 ±  4%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.00            +0.2        0.15 ±  5%  perf-profile.self.cycles-pp.enqueue_entity
      0.00            +0.2        0.16 ±  5%  perf-profile.self.cycles-pp.cache_state_if_flags
      0.12            +0.2        0.29        perf-profile.self.cycles-pp.kmem_cache_free
      0.00            +0.2        0.18 ±  3%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.00            +0.2        0.18 ±  2%  perf-profile.self.cycles-pp.__switch_to
      0.00            +0.2        0.19 ±  2%  perf-profile.self.cycles-pp.update_curr
      0.00            +0.2        0.20 ± 10%  perf-profile.self.cycles-pp.native_sched_clock
      0.00            +0.2        0.20 ±  2%  perf-profile.self.cycles-pp.__orc_find
      0.00            +0.2        0.20 ±  4%  perf-profile.self.cycles-pp.__queue_work
      0.00            +0.2        0.21        perf-profile.self.cycles-pp.enqueue_task_fair
      0.00            +0.2        0.22        perf-profile.self.cycles-pp.update_rq_clock
      0.00            +0.2        0.22 ±  3%  perf-profile.self.cycles-pp.stack_trace_save_tsk
      0.00            +0.2        0.22 ±  3%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.00            +0.2        0.22 ±  4%  perf-profile.self.cycles-pp.__switch_to_asm
      0.00            +0.2        0.23 ±  4%  perf-profile.self.cycles-pp.insert_work
      0.00            +0.2        0.23 ±  3%  perf-profile.self.cycles-pp.read_extent_buffer
      0.59 ±  3%      +0.2        0.82 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      0.03 ±100%      +0.2        0.26 ±  4%  perf-profile.self.cycles-pp.btrfs_lookup_bio_sums
      0.00            +0.2        0.23 ± 13%  perf-profile.self.cycles-pp.do_idle
      0.00            +0.2        0.24 ±  4%  perf-profile.self.cycles-pp.__lock_page_killable
      0.00            +0.2        0.25 ±  9%  perf-profile.self.cycles-pp.btrfs_tree_read_unlock
      0.00            +0.2        0.25 ±  4%  perf-profile.self.cycles-pp.__radix_tree_lookup
      0.05 ±  8%      +0.3        0.31 ±  2%  perf-profile.self.cycles-pp.update_load_avg
      0.01 ±173%      +0.3        0.27 ±  3%  perf-profile.self.cycles-pp.try_to_wake_up
      0.00            +0.3        0.26 ±  2%  perf-profile.self.cycles-pp.down_read
      0.13 ±  5%      +0.3        0.41 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.00            +0.3        0.30        perf-profile.self.cycles-pp.process_one_work
      0.00            +0.3        0.30 ±  2%  perf-profile.self.cycles-pp.free_extent_buffer
      0.00            +0.3        0.33 ±  2%  perf-profile.self.cycles-pp.set_next_entity
      0.00            +0.3        0.34 ±  3%  perf-profile.self.cycles-pp.find_extent_buffer
      0.00            +0.3        0.35 ±  2%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.01 ±173%      +0.4        0.36 ±  5%  perf-profile.self.cycles-pp.__account_scheduler_latency
      0.00            +0.4        0.40 ±  2%  perf-profile.self.cycles-pp.__slab_free
      0.00            +0.4        0.42 ± 10%  perf-profile.self.cycles-pp.btrfs_root_node
      0.00            +0.6        0.57 ± 17%  perf-profile.self.cycles-pp.menu_select
      0.07 ± 12%      +0.6        0.65 ±  2%  perf-profile.self.cycles-pp.__sched_text_start
      0.06 ± 11%      +0.7        0.72        perf-profile.self.cycles-pp.unwind_next_frame
      0.44 ±  4%      +0.7        1.17 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.23 ± 19%      +3.8        4.03 ±  5%  perf-profile.self.cycles-pp.poll_idle
     25.12 ±  6%     +21.9       46.99 ±  3%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


Thanks,
Oliver Sang


--Y5rl02BVI9TCfPar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.9.0-rc3-00030-g51ac7c8929fb43"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.9.0-rc3 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-15) 9.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=90300
CONFIG_LD_VERSION=235000000
CONFIG_CLANG_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
# CONFIG_EXPERT is not set
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_BPF_LSM is not set
CONFIG_BPF_SYSCALL=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
CONFIG_X86_AMD_PLATFORM_DEVICE=y
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_XEN=y
# CONFIG_XEN_PV is not set
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
# CONFIG_XEN_PVH is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
CONFIG_PERF_EVENTS_AMD_POWER=m
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_I8K=m
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_AMD_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_UMIP=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
CONFIG_ACPI_APEI_ERST_DEBUG=y
CONFIG_DPTF_POWER=m
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
CONFIG_PMIC_OPREGION=y
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_MMCONF_FAM10H=y
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# CONFIG_X86_SYSFB is not set
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
# end of Binary Emulations

#
# Firmware Drivers
#
CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
CONFIG_APPLE_PROPERTIES=y
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
CONFIG_KVM_AMD=m
CONFIG_KVM_AMD_SEV=y
CONFIG_KVM_MMU_AUDIT=y
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_OPROFILE=m
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
CONFIG_BLK_WBT=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
CONFIG_BLK_WBT_MQ=y
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_MQ_RDMA=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
# CONFIG_ZSWAP_DEFAULT_ON is not set
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
# CONFIG_ZSMALLOC_PGTABLE_MAPPING is not set
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DEVICE=y
CONFIG_DEV_PAGEMAP_OPS=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_FRAME_VECTOR=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_MAPPING_DIRTY_HELPERS=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
# CONFIG_SMC is not set
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
CONFIG_NETLABEL=y
# CONFIG_MPTCP is not set
# CONFIG_MPTCP_KUNIT_TESTS is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_COMMON=m
CONFIG_NF_LOG_NETDEV=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_COUNTER=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_OBJREF=m
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
# CONFIG_NFT_XFRM is not set
CONFIG_NFT_SOCKET=m
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_TARGET_HL is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=m
# CONFIG_NFT_BRIDGE_META is not set
CONFIG_NFT_BRIDGE_REJECT=m
CONFIG_NF_LOG_BRIDGE=m
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
CONFIG_TIPC=m
# CONFIG_TIPC_MEDIA_IB is not set
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
# CONFIG_6LOWPAN_NHC is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
# CONFIG_NET_SCH_FQ_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_ETS is not set
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="fq_codel"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
CONFIG_NET_EMATCH_IPSET=m
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
# CONFIG_NET_ACT_IPT is not set
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_MPLS is not set
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
# CONFIG_NET_ACT_CONNMARK is not set
# CONFIG_NET_ACT_CTINFO is not set
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
# CONFIG_NET_ACT_GATE is not set
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
CONFIG_CAN_EMS_PCI=m
# CONFIG_CAN_F81601 is not set
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_PLX_PCI=m
# CONFIG_CAN_SJA1000_ISA is not set
CONFIG_CAN_SJA1000_PLATFORM=m
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB2 is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

CONFIG_BT=m
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_HIDP=m
CONFIG_BT_HS=y
CONFIG_BT_LE=y
# CONFIG_BT_6LOWPAN is not set
# CONFIG_BT_LEDS is not set
# CONFIG_BT_MSFTEXT is not set
CONFIG_BT_DEBUGFS=y
# CONFIG_BT_SELFTEST is not set

#
# Bluetooth device drivers
#
# CONFIG_BT_HCIBTUSB is not set
# CONFIG_BT_HCIBTSDIO is not set
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_ATH3K=y
# CONFIG_BT_HCIUART_INTEL is not set
# CONFIG_BT_HCIUART_AG6XX is not set
# CONFIG_BT_HCIBCM203X is not set
# CONFIG_BT_HCIBPA10X is not set
# CONFIG_BT_HCIBFUSB is not set
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
# CONFIG_BT_MRVL_SDIO is not set
# CONFIG_BT_MTKSDIO is not set
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_XEN is not set
# CONFIG_NET_9P_RDMA is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_BW is not set
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=m
# CONFIG_XEN_PCIDEV_FRONTEND is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=m
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y
CONFIG_PCI_HYPERV_INTERFACE=m

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_PM_QOS_KUNIT_TEST is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_KUNIT_DRIVER_PE_TEST=y
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=y
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SKD is not set
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_XEN_BLKDEV_FRONTEND=m
CONFIG_VIRTIO_BLK=y
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
# CONFIG_NVME_RDMA is not set
CONFIG_NVME_FC=m
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
# CONFIG_NVME_TARGET_RDMA is not set
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=m
CONFIG_PVPANIC=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_HDCP is not set
CONFIG_VMWARE_VMCI=m

#
# Intel MIC & related support
#
# CONFIG_INTEL_MIC_BUS is not set
# CONFIG_SCIF_BUS is not set
# CONFIG_VOP_BUS is not set
# end of Intel MIC & related support

# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=m
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_XEN_SCSI_FRONTEND is not set
CONFIG_HYPERV_STORAGE=m
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
# CONFIG_SCSI_GDTH is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
CONFIG_MD_CLUSTER=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
# CONFIG_DM_ZONED is not set
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_ISCSI_TARGET=m
# CONFIG_SBP_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_NET_VRF is not set
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_FIRESTREAM is not set
# CONFIG_ATM_ZATM is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_AMBASSADOR is not set
# CONFIG_ATM_HORIZON is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_MDIO=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
# CONFIG_AMD_XGBE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_NET_VENDOR_AURORA is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
CONFIG_TIGON3=y
CONFIG_TIGON3_HWMON=y
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBE_DCB is not set
CONFIG_IXGBE_IPSEC=y
# CONFIG_IXGBEVF is not set
CONFIG_I40E=y
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
# CONFIG_IGC is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
CONFIG_SKGE=y
# CONFIG_SKGE_DEBUG is not set
# CONFIG_SKGE_GENESIS is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
CONFIG_YELLOWFIN=m
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
CONFIG_8139CP=y
CONFIG_8139TOO=y
CONFIG_8139TOO_PIO=y
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_THUNDER is not set
# CONFIG_MDIO_XPCS is not set
CONFIG_PHYLIB=y
# CONFIG_LED_TRIGGER_PHY is not set

#
# MII PHY device drivers
#
# CONFIG_ADIN_PHY is not set
# CONFIG_AMD_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AX88796B_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_FIXED_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
CONFIG_USB_CATC=y
CONFIG_USB_KAWETH=y
CONFIG_USB_PEGASUS=y
CONFIG_USB_RTL8150=y
CONFIG_USB_RTL8152=m
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
CONFIG_USB_NET_CDCETHER=y
CONFIG_USB_NET_CDC_EEM=y
CONFIG_USB_NET_CDC_NCM=y
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
CONFIG_USB_NET_DM9601=y
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
CONFIG_USB_NET_SMSC75XX=y
CONFIG_USB_NET_SMSC95XX=y
CONFIG_USB_NET_GL620A=y
CONFIG_USB_NET_NET1080=y
CONFIG_USB_NET_PLUSB=y
CONFIG_USB_NET_MCS7830=y
CONFIG_USB_NET_RNDIS_HOST=y
CONFIG_USB_NET_CDC_SUBSET_ENABLE=y
CONFIG_USB_NET_CDC_SUBSET=y
# CONFIG_USB_ALI_M5632 is not set
# CONFIG_USB_AN2720 is not set
CONFIG_USB_BELKIN=y
CONFIG_USB_ARMLINUX=y
# CONFIG_USB_EPSON2888 is not set
# CONFIG_USB_KC2190 is not set
CONFIG_USB_NET_ZAURUS=y
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_HSO is not set
CONFIG_USB_NET_INT51X1=y
CONFIG_USB_IPHETH=y
CONFIG_USB_SIERRA_NET=y
# CONFIG_USB_VL600 is not set
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
# CONFIG_MT7601U is not set
# CONFIG_MT76x0U is not set
# CONFIG_MT76x0E is not set
# CONFIG_MT76x2E is not set
# CONFIG_MT76x2U is not set
# CONFIG_MT7603E is not set
# CONFIG_MT7615E is not set
# CONFIG_MT7663U is not set
# CONFIG_MT7663S is not set
# CONFIG_MT7915E is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
CONFIG_MAC80211_HWSIM=m
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
CONFIG_IEEE802154_DRIVERS=m
# CONFIG_IEEE802154_FAKELB is not set
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set
CONFIG_XEN_NETDEV_FRONTEND=y
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_HYPERV_NET is not set
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set
CONFIG_NVM=y
# CONFIG_NVM_PBLK is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_POLLDEV=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F54 is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=64
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK=m
CONFIG_SYNCLINKMP=m
CONFIG_SYNCLINK_GT=m
# CONFIG_ISI is not set
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
# CONFIG_TRACE_SINK is not set
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set
CONFIG_NVRAM=y
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=8192
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
# CONFIG_TCG_XEN is not set
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# end of Character devices

# CONFIG_RANDOM_TRUST_CPU is not set
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
# CONFIG_DP83640_PHY is not set
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=m
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
CONFIG_PINCTRL_INTEL=m
CONFIG_PINCTRL_BROXTON=m
CONFIG_PINCTRL_CANNONLAKE=m
CONFIG_PINCTRL_CEDARFORK=m
CONFIG_PINCTRL_DENVERTON=m
# CONFIG_PINCTRL_EMMITSBURG is not set
CONFIG_PINCTRL_GEMINILAKE=m
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
CONFIG_PINCTRL_LEWISBURG=m
CONFIG_PINCTRL_SUNRISEPOINT=m
# CONFIG_PINCTRL_TIGERLAKE is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_AMDPT=m
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_XILINX is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_W1 is not set
# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_SMB347=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
# CONFIG_SENSORS_AMD_ENERGY is not set
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_MLXREG_FAN is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
# CONFIG_SENSORS_MAX20730 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_PKG_TEMP_THERMAL=m
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m
# CONFIG_INT3406_THERMAL is not set
CONFIG_PROC_THERMAL_MMIO_RAPL=y
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_MLX_WDT is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=m
CONFIG_SP5100_TCO=m
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set
CONFIG_XEN_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=m
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
# CONFIG_IR_SHARP_DECODER is not set
CONFIG_IR_MCE_KBD_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_IR_IMON_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_RC_DEVICES=y
# CONFIG_RC_ATI_REMOTE is not set
CONFIG_IR_ENE=m
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
# CONFIG_IR_STREAMZAP is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_TTUSBIR is not set
# CONFIG_RC_LOOPBACK is not set
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
CONFIG_IR_SIR=m
# CONFIG_RC_XBOX_DVD is not set
# CONFIG_IR_TOY is not set
CONFIG_MEDIA_CEC_SUPPORT=y
# CONFIG_CEC_CH7322 is not set
# CONFIG_CEC_SECO is not set
# CONFIG_USB_PULSE8_CEC is not set
# CONFIG_USB_RAINSHADOW_CEC is not set
CONFIG_MEDIA_SUPPORT=m
# CONFIG_MEDIA_SUPPORT_FILTER is not set
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_PLATFORM_SUPPORT=y
CONFIG_MEDIA_TEST_SUPPORT=y
# end of Media device types

#
# Media core support
#
CONFIG_VIDEO_DEV=m
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=m
# end of Media core support

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2=m
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
# end of Video4Linux options

#
# Media controller options
#
# CONFIG_MEDIA_CONTROLLER_DVB is not set
# end of Media controller options

#
# Digital TV options
#
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set
# end of Digital TV options

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
CONFIG_RADIO_ADAPTERS=y
# CONFIG_RADIO_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_USB_MR800 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SHARK is not set
# CONFIG_RADIO_SHARK2 is not set
# CONFIG_USB_KEENE is not set
# CONFIG_USB_RAREMONO is not set
# CONFIG_USB_MA901 is not set
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_WL1273 is not set
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set
# CONFIG_SDR_PLATFORM_DRIVERS is not set

#
# MMC/SDIO DVB adapters
#
# CONFIG_SMS_SDIO_DRV is not set
# CONFIG_V4L_TEST_DRIVERS is not set

#
# FireWire (IEEE 1394) Adapters
#
# CONFIG_DVB_FIREDTV is not set
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# Audio decoders, processors and mixers
#
# CONFIG_VIDEO_TVAUDIO is not set
# CONFIG_VIDEO_TDA7432 is not set
# CONFIG_VIDEO_TDA9840 is not set
# CONFIG_VIDEO_TEA6415C is not set
# CONFIG_VIDEO_TEA6420 is not set
# CONFIG_VIDEO_MSP3400 is not set
# CONFIG_VIDEO_CS3308 is not set
# CONFIG_VIDEO_CS5345 is not set
# CONFIG_VIDEO_CS53L32A is not set
# CONFIG_VIDEO_TLV320AIC23B is not set
# CONFIG_VIDEO_UDA1342 is not set
# CONFIG_VIDEO_WM8775 is not set
# CONFIG_VIDEO_WM8739 is not set
# CONFIG_VIDEO_VP27SMPX is not set
# CONFIG_VIDEO_SONY_BTF_MPX is not set
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
# CONFIG_VIDEO_SAA6588 is not set
# end of RDS decoders

#
# Video decoders
#
# CONFIG_VIDEO_ADV7180 is not set
# CONFIG_VIDEO_ADV7183 is not set
# CONFIG_VIDEO_ADV7604 is not set
# CONFIG_VIDEO_ADV7842 is not set
# CONFIG_VIDEO_BT819 is not set
# CONFIG_VIDEO_BT856 is not set
# CONFIG_VIDEO_BT866 is not set
# CONFIG_VIDEO_KS0127 is not set
# CONFIG_VIDEO_ML86V7667 is not set
# CONFIG_VIDEO_SAA7110 is not set
# CONFIG_VIDEO_SAA711X is not set
# CONFIG_VIDEO_TC358743 is not set
# CONFIG_VIDEO_TVP514X is not set
# CONFIG_VIDEO_TVP5150 is not set
# CONFIG_VIDEO_TVP7002 is not set
# CONFIG_VIDEO_TW2804 is not set
# CONFIG_VIDEO_TW9903 is not set
# CONFIG_VIDEO_TW9906 is not set
# CONFIG_VIDEO_TW9910 is not set
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
# CONFIG_VIDEO_SAA717X is not set
# CONFIG_VIDEO_CX25840 is not set
# end of Video decoders

#
# Video encoders
#
# CONFIG_VIDEO_SAA7127 is not set
# CONFIG_VIDEO_SAA7185 is not set
# CONFIG_VIDEO_ADV7170 is not set
# CONFIG_VIDEO_ADV7175 is not set
# CONFIG_VIDEO_ADV7343 is not set
# CONFIG_VIDEO_ADV7393 is not set
# CONFIG_VIDEO_ADV7511 is not set
# CONFIG_VIDEO_AD9389B is not set
# CONFIG_VIDEO_AK881X is not set
# CONFIG_VIDEO_THS8200 is not set
# end of Video encoders

#
# Video improvement chips
#
# CONFIG_VIDEO_UPD64031A is not set
# CONFIG_VIDEO_UPD64083 is not set
# end of Video improvement chips

#
# Audio/Video compression chips
#
# CONFIG_VIDEO_SAA6752HS is not set
# end of Audio/Video compression chips

#
# SDR tuner chips
#
# CONFIG_SDR_MAX2175 is not set
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_THS7303 is not set
# CONFIG_VIDEO_M52790 is not set
# CONFIG_VIDEO_I2C is not set
# CONFIG_VIDEO_ST_MIPID02 is not set
# end of Miscellaneous helper chips

#
# Camera sensor devices
#
# CONFIG_VIDEO_HI556 is not set
# CONFIG_VIDEO_IMX219 is not set
# CONFIG_VIDEO_IMX258 is not set
# CONFIG_VIDEO_IMX274 is not set
# CONFIG_VIDEO_IMX290 is not set
# CONFIG_VIDEO_IMX319 is not set
# CONFIG_VIDEO_IMX355 is not set
# CONFIG_VIDEO_OV2640 is not set
# CONFIG_VIDEO_OV2659 is not set
# CONFIG_VIDEO_OV2680 is not set
# CONFIG_VIDEO_OV2685 is not set
# CONFIG_VIDEO_OV2740 is not set
# CONFIG_VIDEO_OV5647 is not set
# CONFIG_VIDEO_OV6650 is not set
# CONFIG_VIDEO_OV5670 is not set
# CONFIG_VIDEO_OV5675 is not set
# CONFIG_VIDEO_OV5695 is not set
# CONFIG_VIDEO_OV7251 is not set
# CONFIG_VIDEO_OV772X is not set
# CONFIG_VIDEO_OV7640 is not set
# CONFIG_VIDEO_OV7670 is not set
# CONFIG_VIDEO_OV7740 is not set
# CONFIG_VIDEO_OV8856 is not set
# CONFIG_VIDEO_OV9640 is not set
# CONFIG_VIDEO_OV9650 is not set
# CONFIG_VIDEO_OV13858 is not set
# CONFIG_VIDEO_VS6624 is not set
# CONFIG_VIDEO_MT9M001 is not set
# CONFIG_VIDEO_MT9M032 is not set
# CONFIG_VIDEO_MT9M111 is not set
# CONFIG_VIDEO_MT9P031 is not set
# CONFIG_VIDEO_MT9T001 is not set
# CONFIG_VIDEO_MT9T112 is not set
# CONFIG_VIDEO_MT9V011 is not set
# CONFIG_VIDEO_MT9V032 is not set
# CONFIG_VIDEO_MT9V111 is not set
# CONFIG_VIDEO_SR030PC30 is not set
# CONFIG_VIDEO_NOON010PC30 is not set
# CONFIG_VIDEO_M5MOLS is not set
# CONFIG_VIDEO_RDACM20 is not set
# CONFIG_VIDEO_RJ54N1 is not set
# CONFIG_VIDEO_S5K6AA is not set
# CONFIG_VIDEO_S5K6A3 is not set
# CONFIG_VIDEO_S5K4ECGX is not set
# CONFIG_VIDEO_S5K5BAF is not set
# CONFIG_VIDEO_SMIAPP is not set
# CONFIG_VIDEO_ET8EK8 is not set
# CONFIG_VIDEO_S5C73M3 is not set
# end of Camera sensor devices

#
# Lens drivers
#
# CONFIG_VIDEO_AD5820 is not set
# CONFIG_VIDEO_AK7375 is not set
# CONFIG_VIDEO_DW9714 is not set
# CONFIG_VIDEO_DW9768 is not set
# CONFIG_VIDEO_DW9807_VCM is not set
# end of Lens drivers

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
# CONFIG_VIDEO_LM3560 is not set
# CONFIG_VIDEO_LM3646 is not set
# end of Flash devices

#
# SPI helper chips
#
# CONFIG_VIDEO_GS1662 is not set
# end of SPI helper chips

#
# Media SPI Adapters
#
CONFIG_CXD2880_SPI_DRV=m
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_MSI001=m
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_R820T=m
CONFIG_MEDIA_TUNER_MXL301RF=m
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_TDA18271C2DD=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_MT312=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_TDA10071=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
CONFIG_DVB_S5H1432=m
CONFIG_DVB_DRXD=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
CONFIG_DVB_DIB9000=m
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_RTL2832_SDR=m
CONFIG_DVB_SI2168=m
CONFIG_DVB_ZD1301_DEMOD=m
CONFIG_DVB_CXD2880=m

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_S5H1411=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=m
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=m
CONFIG_DVB_MN88443X=m

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=m
CONFIG_DVB_LNBH25=m
CONFIG_DVB_LNBH29=m
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=m
CONFIG_DVB_LGS8GL5=m
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m
CONFIG_DVB_HORUS3A=m
CONFIG_DVB_ASCOT2E=m
CONFIG_DVB_HELENE=m

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m
CONFIG_DVB_SP2=m
# end of Customise DVB Frontends

#
# Tools to develop new frontends
#
# CONFIG_DVB_DUMMY_FE is not set
# end of Media ancillary drivers

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_TTM_DMA_PAGE_POOL=y
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_GVT=y
CONFIG_DRM_I915_GVT_KVMGT=m
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_VMWGFX=m
CONFIG_DRM_VMWGFX_FBCON=y
CONFIG_DRM_GMA500=m
CONFIG_DRM_GMA600=y
CONFIG_DRM_GMA3600=y
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_QXL=m
CONFIG_DRM_BOCHS=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_XEN is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_XEN_FBDEV_FRONTEND is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=64
# CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=m
CONFIG_HID_CHICONY=m
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=m
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

#
# I2C HID support
#
CONFIG_I2C_HID=m
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=m
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_CDNS3 is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
# CONFIG_USB_SERIAL_AIRCABLE is not set
# CONFIG_USB_SERIAL_ARK3116 is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_CH341 is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_CP210X is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
# CONFIG_USB_SERIAL_GARMIN is not set
# CONFIG_USB_SERIAL_IPW is not set
# CONFIG_USB_SERIAL_IUU is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_METRO is not set
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
# CONFIG_USB_SERIAL_MXUPORT is not set
# CONFIG_USB_SERIAL_NAVMAN is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_OTI6858 is not set
# CONFIG_USB_SERIAL_QCAUX is not set
# CONFIG_USB_SERIAL_QUALCOMM is not set
# CONFIG_USB_SERIAL_SPCP8X5 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
# CONFIG_USB_SERIAL_SYMBOL is not set
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
# CONFIG_USB_SERIAL_OPTION is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_SERIAL_OPTICON is not set
# CONFIG_USB_SERIAL_XSENS_MT is not set
# CONFIG_USB_SERIAL_WISHBONE is not set
# CONFIG_USB_SERIAL_SSU100 is not set
# CONFIG_USB_SERIAL_QT2 is not set
# CONFIG_USB_SERIAL_UPD78F0730 is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
# CONFIG_USB_ATM is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_TYPEC_TPS6598X is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MMC_REALTEK_PCI is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_ACCESSIBILITY is not set
CONFIG_INFINIBAND=m
CONFIG_INFINIBAND_USER_MAD=m
CONFIG_INFINIBAND_USER_ACCESS=m
CONFIG_INFINIBAND_USER_MEM=y
CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
CONFIG_INFINIBAND_ADDR_TRANS=y
CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
# CONFIG_INFINIBAND_MTHCA is not set
# CONFIG_INFINIBAND_EFA is not set
# CONFIG_INFINIBAND_I40IW is not set
# CONFIG_MLX4_INFINIBAND is not set
# CONFIG_INFINIBAND_OCRDMA is not set
# CONFIG_INFINIBAND_USNIC is not set
# CONFIG_INFINIBAND_BNXT_RE is not set
# CONFIG_INFINIBAND_RDMAVT is not set
CONFIG_RDMA_RXE=m
CONFIG_RDMA_SIW=m
CONFIG_INFINIBAND_IPOIB=m
# CONFIG_INFINIBAND_IPOIB_CM is not set
CONFIG_INFINIBAND_IPOIB_DEBUG=y
# CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set
CONFIG_INFINIBAND_SRP=m
CONFIG_INFINIBAND_SRPT=m
# CONFIG_INFINIBAND_ISER is not set
# CONFIG_INFINIBAND_ISERT is not set
# CONFIG_INFINIBAND_RTRS_CLIENT is not set
# CONFIG_INFINIBAND_RTRS_SERVER is not set
# CONFIG_INFINIBAND_OPA_VNIC is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=m
CONFIG_EDAC_GHES=y
CONFIG_EDAC_AMD64=m
# CONFIG_EDAC_AMD64_ERROR_INJECTION is not set
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RX6110 is not set
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
# CONFIG_RTC_DRV_RV3029_HWMON is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
# CONFIG_INTEL_IDXD is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_XILINX_ZYNQMP_DPDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# end of DMABUF options

CONFIG_DCA=m
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_UIO_HV_GENERIC=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_VFIO_MDEV_DEVICE=m
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_MEM=m
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
# CONFIG_XEN_BALLOON is not set
CONFIG_XEN_DEV_EVTCHN=m
# CONFIG_XEN_BACKEND is not set
CONFIG_XENFS=m
CONFIG_XEN_COMPAT_XENFS=y
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
# CONFIG_XEN_GNTDEV is not set
# CONFIG_XEN_GRANT_DEV_ALLOC is not set
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
# CONFIG_XEN_PVCALLS_FRONTEND is not set
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
# end of Xen driver support

# CONFIG_GREYBUS is not set
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_ALIENWARE_WMI is not set
# CONFIG_HUAWEI_WMI is not set
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m
CONFIG_MXM_WMI=m
# CONFIG_PEAQ_WMI is not set
# CONFIG_XIAOMI_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
CONFIG_DCDBAS=m
CONFIG_DELL_SMBIOS=m
CONFIG_DELL_SMBIOS_WMI=y
# CONFIG_DELL_SMBIOS_SMM is not set
CONFIG_DELL_LAPTOP=m
CONFIG_DELL_RBTN=m
CONFIG_DELL_RBU=m
CONFIG_DELL_SMO8800=m
CONFIG_DELL_WMI=m
CONFIG_DELL_WMI_DESCRIPTOR=m
CONFIG_DELL_WMI_AIO=m
CONFIG_DELL_WMI_LED=m
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
CONFIG_HP_WIRELESS=m
CONFIG_HP_WMI=m
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_INTEL_ATOMISP2_PM is not set
CONFIG_INTEL_HID_EVENT=m
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_MENLOW is not set
CONFIG_INTEL_OAKTRAIL=m
CONFIG_INTEL_VBTN=m
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_I2C_MULTI_INSTANTIATE is not set
CONFIG_MLX_PLATFORM=m
CONFIG_INTEL_IPS=m
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
CONFIG_INTEL_PMC_CORE=m
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
CONFIG_PMC_ATOM=y
# CONFIG_MFD_CROS_EC is not set
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
# CONFIG_MLXREG_IO is not set
CONFIG_HAVE_CLK=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOASID=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
CONFIG_AMD_IOMMU=y
CONFIG_AMD_IOMMU_V2=m
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
# CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON is not set
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Aspeed SoC drivers
#
# end of Aspeed SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_BLK=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_DEV_DAX_PMEM_COMPAT=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# HW tracing support
#
CONFIG_STM=m
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_EXT4_KUNIT_TESTS=m
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_REPAIR=y
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
CONFIG_F2FS_FS_SECURITY=y
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_IO_TRACE is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
# CONFIG_ZONEFS_FS is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_QUOTACTL_COMPAT=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
CONFIG_MINIX_FS=m
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_SUNRPC_XPRT_RDMA=m
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_WEAK_PW_HASH=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SMB_DIRECT is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_9P_FS=y
CONFIG_9P_FS_POSIX_ACL=y
# CONFIG_9P_FS_SECURITY is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITY_WRITABLE_HOOKS=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
# CONFIG_SECURITY_INFINIBAND is not set
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=9
CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=256
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
# CONFIG_SECURITY_APPARMOR_KUNIT_TEST is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
# CONFIG_IMA_TEMPLATE is not set
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
# CONFIG_IMA_WRITE_POLICY is not set
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=y
# CONFIG_IMA_ARCH_POLICY is not set
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
# CONFIG_IMA_APPRAISE_MODSIG is not set
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# CONFIG_CRYPTO_CURVE25519_X86 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=m
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ESSIV=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_XXHASH=m
CONFIG_CRYPTO_BLAKE2B=m
# CONFIG_CRYPTO_BLAKE2S is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_POLY1305_X86_64=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_RMD256=m
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_DES3_EDE_X86_64=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SALSA20=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CHACHA20_X86_64=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
CONFIG_CRYPTO_USER_API_AEAD=y
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
# CONFIG_CRYPTO_LIB_BLAKE2S is not set
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=m
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=m
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=y
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
# CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
CONFIG_CRYPTO_DEV_NITROX=m
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=m
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
# CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=m
# CONFIG_PRIME_NUMBERS is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_DMA_VIRT_OPS=y
CONFIG_SWIOTLB=y
CONFIG_DMA_COHERENT_POOL=y
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=200
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_DIMLIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_UACCESS_MCSAFE=y
CONFIG_ARCH_STACKWALK=y
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# CONFIG_KASAN is not set
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
# CONFIG_WW_MUTEX_SELFTEST is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
CONFIG_RCU_PERF_TEST=m
CONFIG_RCU_TORTURE_TEST=m
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_X86_DECODER_SELFTEST=y
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
CONFIG_KUNIT=y
# CONFIG_KUNIT_DEBUGFS is not set
CONFIG_KUNIT_TEST=m
CONFIG_KUNIT_EXAMPLE_TEST=m
# CONFIG_KUNIT_ALL_TESTS is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
# CONFIG_FAIL_MMC_REQUEST is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_STRSCPY is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_BITFIELD is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
CONFIG_TEST_BPF=m
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
CONFIG_SYSCTL_KUNIT_TEST=m
CONFIG_LIST_KUNIT_TEST=m
# CONFIG_LINEAR_RANGES_TEST is not set
# CONFIG_BITS_TEST is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_LIVEPATCH is not set
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_HMM is not set
# CONFIG_TEST_FPU is not set
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--Y5rl02BVI9TCfPar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='fio-basic'
	export testcase='fio-basic'
	export category='benchmark'
	export runtime=300
	export nr_task=8
	export job_origin='/lkp-src/allot/cyclic:p1:linux-devel:devel-hourly/lkp-csl-2ap1/fio-basic-1ssd-nvme-read.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-csl-2ap1'
	export tbox_group='lkp-csl-2ap1'
	export kconfig='x86_64-rhel-8.3'
	export submit_id='5fa994c8614353152e9af336'
	export job_file='/lkp/jobs/scheduled/lkp-csl-2ap1/fio-basic-2M-performance-1SSD-btrfs-sync-8t-300s-randread-256g-ucode=0x4002f01-monitor=3472ca3d-debian-10.4-x86_64-20200603.cgz--20201110-5422-1nlnrzo-2.yaml'
	export id='d70849181b4e36bbe28ee8dc7b12d9dbad074fdb'
	export queuer_version='/lkp-src'
	export model='Cascade Lake'
	export nr_node=4
	export nr_cpu=192
	export memory='192G'
	export nr_ssd_partitions=1
	export ssd_partitions='/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF738001A24P0IGN-part4'
	export rootfs_partition='/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF738001A24P0IGN-part3'
	export kernel_cmdline_hw='acpi_rsdp=0x68005014'
	export brand='Intel(R) Xeon(R) CPU @ 2.20GHz'
	export need_kconfig='CONFIG_BLK_DEV_SD
CONFIG_SCSI
CONFIG_BLOCK=y
CONFIG_SATA_AHCI
CONFIG_SATA_AHCI_PLATFORM
CONFIG_ATA
CONFIG_PCI=y
CONFIG_BTRFS_FS'
	export commit='51ac7c8929fb43cdb4d046674ba61926711318a2'
	export need_kconfig_hw='CONFIG_IGB=y
CONFIG_BLK_DEV_NVME'
	export ucode='0x4002f01'
	export enqueue_time='2020-11-10 03:13:13 +0800'
	export _id='5fa994c8614353152e9af336'
	export _rt='/result/fio-basic/2M-performance-1SSD-btrfs-sync-8t-300s-randread-256g-ucode=0x4002f01-monitor=3472ca3d/lkp-csl-2ap1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/51ac7c8929fb43cdb4d046674ba61926711318a2'
	export user='lkp'
	export compiler='gcc-9'
	export head_commit='afc4a0d0c0e4e9e353c8c9b0359ba9548d4b7d90'
	export base_commit='3cea11cd5e3b00d91caf0b4730194039b45c5891'
	export branch='linux-review/Wonhyuk-Yang/fuse-fix-panic-in-__readahead_batch/20201103-204539'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export monitor_sha='3472ca3d'
	export result_root='/result/fio-basic/2M-performance-1SSD-btrfs-sync-8t-300s-randread-256g-ucode=0x4002f01-monitor=3472ca3d/lkp-csl-2ap1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/51ac7c8929fb43cdb4d046674ba61926711318a2/3'
	export scheduler_version='/lkp/lkp/.src-20201106-094319'
	export LKP_SERVER='internal-lkp-server'
	export arch='x86_64'
	export max_uptime=3600
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-csl-2ap1/fio-basic-2M-performance-1SSD-btrfs-sync-8t-300s-randread-256g-ucode=0x4002f01-monitor=3472ca3d-debian-10.4-x86_64-20200603.cgz--20201110-5422-1nlnrzo-2.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3
branch=linux-review/Wonhyuk-Yang/fuse-fix-panic-in-__readahead_batch/20201103-204539
commit=51ac7c8929fb43cdb4d046674ba61926711318a2
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/51ac7c8929fb43cdb4d046674ba61926711318a2/vmlinuz-5.9.0-rc3-00030-g51ac7c8929fb43
acpi_rsdp=0x68005014
max_uptime=3600
RESULT_ROOT=/result/fio-basic/2M-performance-1SSD-btrfs-sync-8t-300s-randread-256g-ucode=0x4002f01-monitor=3472ca3d/lkp-csl-2ap1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/51ac7c8929fb43cdb4d046674ba61926711318a2/3
LKP_SERVER=internal-lkp-server
nokaslr
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/51ac7c8929fb43cdb4d046674ba61926711318a2/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20200709.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fio_20200714.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/fio-x86_64-3.15-1_20200907.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20200723.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-c85fb28b6f99-1_20201008.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20200610.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.10.0-rc2-wt-05559-gafc4a0d0c0e4'
	export repeat_to=4
	export schedule_notify_address=
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/51ac7c8929fb43cdb4d046674ba61926711318a2/vmlinuz-5.9.0-rc3-00030-g51ac7c8929fb43'
	export dequeue_time='2020-11-10 03:26:52 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-csl-2ap1/fio-basic-2M-performance-1SSD-btrfs-sync-8t-300s-randread-256g-ucode=0x4002f01-monitor=3472ca3d-debian-10.4-x86_64-20200603.cgz--20201110-5422-1nlnrzo-2.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_setup nr_ssd=1 $LKP_SRC/setup/disk

	run_setup fs='btrfs' $LKP_SRC/setup/fs

	run_setup rw='randread' bs='2M' ioengine='sync' test_size='256g' $LKP_SRC/setup/fio-setup-basic

	run_setup $LKP_SRC/setup/cpufreq_governor 'performance'

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
	run_monitor $LKP_SRC/monitors/wrapper uptime
	run_monitor $LKP_SRC/monitors/wrapper iostat
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper vmstat
	run_monitor $LKP_SRC/monitors/wrapper numa-numastat
	run_monitor $LKP_SRC/monitors/wrapper numa-vmstat
	run_monitor $LKP_SRC/monitors/wrapper numa-meminfo
	run_monitor $LKP_SRC/monitors/wrapper proc-vmstat
	run_monitor $LKP_SRC/monitors/wrapper proc-stat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper slabinfo
	run_monitor $LKP_SRC/monitors/wrapper interrupts
	run_monitor $LKP_SRC/monitors/wrapper lock_stat
	run_monitor $LKP_SRC/monitors/wrapper latency_stats
	run_monitor $LKP_SRC/monitors/wrapper softirqs
	run_monitor $LKP_SRC/monitors/one-shot/wrapper bdi_dev_mapping
	run_monitor $LKP_SRC/monitors/wrapper diskstats
	run_monitor $LKP_SRC/monitors/wrapper nfsstat
	run_monitor $LKP_SRC/monitors/wrapper cpuidle
	run_monitor $LKP_SRC/monitors/wrapper cpufreq-stats
	run_monitor $LKP_SRC/monitors/wrapper sched_debug
	run_monitor $LKP_SRC/monitors/wrapper perf-stat
	run_monitor $LKP_SRC/monitors/wrapper mpstat
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper perf-profile
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test $LKP_SRC/tests/wrapper fio
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper fio
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper boot-time
	$LKP_SRC/stats/wrapper uptime
	$LKP_SRC/stats/wrapper iostat
	$LKP_SRC/stats/wrapper vmstat
	$LKP_SRC/stats/wrapper numa-numastat
	$LKP_SRC/stats/wrapper numa-vmstat
	$LKP_SRC/stats/wrapper numa-meminfo
	$LKP_SRC/stats/wrapper proc-vmstat
	$LKP_SRC/stats/wrapper meminfo
	$LKP_SRC/stats/wrapper slabinfo
	$LKP_SRC/stats/wrapper interrupts
	$LKP_SRC/stats/wrapper lock_stat
	$LKP_SRC/stats/wrapper latency_stats
	$LKP_SRC/stats/wrapper softirqs
	$LKP_SRC/stats/wrapper diskstats
	$LKP_SRC/stats/wrapper nfsstat
	$LKP_SRC/stats/wrapper cpuidle
	$LKP_SRC/stats/wrapper sched_debug
	$LKP_SRC/stats/wrapper perf-stat
	$LKP_SRC/stats/wrapper mpstat
	$LKP_SRC/stats/wrapper perf-profile

	$LKP_SRC/stats/wrapper time fio.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--Y5rl02BVI9TCfPar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/fio-basic-1ssd-nvme-read.yaml
suite: fio-basic
testcase: fio-basic
category: benchmark
runtime: 300s
nr_task: 8t
disk: 1SSD
fs: btrfs
fio-setup-basic:
  rw: randread
  bs: 2M
  ioengine: sync
  test_size: 256g
fio: 
job_origin: "/lkp-src/allot/cyclic:p1:linux-devel:devel-hourly/lkp-csl-2ap1/fio-basic-1ssd-nvme-read.yaml"

#! queue options
queue_cmdline_keys:
- branch
- commit
- queue_at_least_once
queue: bisect
testbox: lkp-csl-2ap1
tbox_group: lkp-csl-2ap1
kconfig: x86_64-rhel-8.3
submit_id: 5fa9218a6143530dd3773881
job_file: "/lkp/jobs/scheduled/lkp-csl-2ap1/fio-basic-2M-performance-1SSD-btrfs-sync-8t-300s-randread-256g-ucode=0x4002f01-monitor=3472ca3d-debian-10.4-x86_64-20200603.cgz--20201109-3539-m35frk-0.yaml"
id: 4ffe788ae1d2fbbe6c9d8bdaa95fbe4e5575886c
queuer_version: "/lkp-src"

#! hosts/lkp-csl-2ap1
model: Cascade Lake
nr_node: 4
nr_cpu: 192
memory: 192G
nr_ssd_partitions: 1
ssd_partitions: "/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF738001A24P0IGN-part4"
rootfs_partition: "/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF738001A24P0IGN-part3"
kernel_cmdline_hw: acpi_rsdp=0x68005014
brand: Intel(R) Xeon(R) CPU @ 2.20GHz

#! include/category/benchmark
kmsg: 
boot-time: 
uptime: 
iostat: 
heartbeat: 
vmstat: 
numa-numastat: 
numa-vmstat: 
numa-meminfo: 
proc-vmstat: 
proc-stat: 
meminfo: 
slabinfo: 
interrupts: 
lock_stat: 
latency_stats: 
softirqs: 
bdi_dev_mapping: 
diskstats: 
nfsstat: 
cpuidle: 
cpufreq-stats: 
sched_debug: 
perf-stat: 
mpstat: 
perf-profile: 

#! include/category/ALL
cpufreq_governor: performance

#! include/disk/nr_ssd
need_kconfig:
- CONFIG_BLK_DEV_SD
- CONFIG_SCSI
- CONFIG_BLOCK=y
- CONFIG_SATA_AHCI
- CONFIG_SATA_AHCI_PLATFORM
- CONFIG_ATA
- CONFIG_PCI=y
- CONFIG_BTRFS_FS

#! include/queue/cyclic
commit: 51ac7c8929fb43cdb4d046674ba61926711318a2

#! include/testbox/lkp-csl-2ap1
need_kconfig_hw:
- CONFIG_IGB=y
- CONFIG_BLK_DEV_NVME
ucode: '0x4002f01'

#! include/fs/OTHERS
enqueue_time: 2020-11-09 19:01:31.209791417 +08:00
_id: 5fa9218a6143530dd3773881
_rt: "/result/fio-basic/2M-performance-1SSD-btrfs-sync-8t-300s-randread-256g-ucode=0x4002f01-monitor=3472ca3d/lkp-csl-2ap1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/51ac7c8929fb43cdb4d046674ba61926711318a2"

#! schedule options
user: lkp
compiler: gcc-9
head_commit: afc4a0d0c0e4e9e353c8c9b0359ba9548d4b7d90
base_commit: 3cea11cd5e3b00d91caf0b4730194039b45c5891
branch: linux-devel/devel-hourly-2020110520
rootfs: debian-10.4-x86_64-20200603.cgz
monitor_sha: 3472ca3d
result_root: "/result/fio-basic/2M-performance-1SSD-btrfs-sync-8t-300s-randread-256g-ucode=0x4002f01-monitor=3472ca3d/lkp-csl-2ap1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/51ac7c8929fb43cdb4d046674ba61926711318a2/0"
scheduler_version: "/lkp/lkp/.src-20201106-094319"
LKP_SERVER: internal-lkp-server
arch: x86_64
max_uptime: 3600
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-csl-2ap1/fio-basic-2M-performance-1SSD-btrfs-sync-8t-300s-randread-256g-ucode=0x4002f01-monitor=3472ca3d-debian-10.4-x86_64-20200603.cgz--20201109-3539-m35frk-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- branch=linux-devel/devel-hourly-2020110520
- commit=51ac7c8929fb43cdb4d046674ba61926711318a2
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/51ac7c8929fb43cdb4d046674ba61926711318a2/vmlinuz-5.9.0-rc3-00030-g51ac7c8929fb43
- acpi_rsdp=0x68005014
- max_uptime=3600
- RESULT_ROOT=/result/fio-basic/2M-performance-1SSD-btrfs-sync-8t-300s-randread-256g-ucode=0x4002f01-monitor=3472ca3d/lkp-csl-2ap1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/51ac7c8929fb43cdb4d046674ba61926711318a2/0
- LKP_SERVER=internal-lkp-server
- nokaslr
- selinux=0
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/51ac7c8929fb43cdb4d046674ba61926711318a2/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20200709.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fio_20200714.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/fio-x86_64-3.15-1_20200907.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20200723.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-c85fb28b6f99-1_20201008.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20200610.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20201103-101238/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 5.4.0-0.bpo.4-amd64
repeat_to: 2
schedule_notify_address: 

#! user overrides
queue_at_least_once: 0
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/51ac7c8929fb43cdb4d046674ba61926711318a2/vmlinuz-5.9.0-rc3-00030-g51ac7c8929fb43"
dequeue_time: 2020-11-09 22:25:22.739907402 +08:00

#! /lkp/lkp/.src-20201106-094319/include/site/inn
job_state: finished
loadavg: 6.88 5.74 2.77 1/1354 13423
start_time: '1604931617'
end_time: '1604931918'
version: "/lkp/lkp/.src-20201106-094356:b434b679-dirty:05b264436-dirty"

--Y5rl02BVI9TCfPar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

dmsetup remove_all
wipefs -a --force /dev/nvme0n1p4
mkfs -t btrfs /dev/nvme0n1p4
mkdir -p /fs/nvme0n1p4
mount -t btrfs /dev/nvme0n1p4 /fs/nvme0n1p4

for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

echo '[global]
bs=2M
ioengine=sync
iodepth=32
size=34359738368
nr_files=1
filesize=34359738368
direct=0
runtime=300
invalidate=1
fallocate=posix
io_size=34359738368
file_service_type=roundrobin
random_distribution=random
group_reporting
pre_read=0

[task_0]
rw=randread
directory=/fs/nvme0n1p4
numjobs=8' | fio --output-format=json -

--Y5rl02BVI9TCfPar--
