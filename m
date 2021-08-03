Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4793DEFAA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 16:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236507AbhHCOEl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 10:04:41 -0400
Received: from mga06.intel.com ([134.134.136.31]:31223 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236342AbhHCOEh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 10:04:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="274752332"
X-IronPort-AV: E=Sophos;i="5.84,291,1620716400"; 
   d="scan'208";a="274752332"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 07:04:24 -0700
X-IronPort-AV: E=Sophos;i="5.84,291,1620716400"; 
   d="scan'208";a="441189062"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.41])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 07:04:18 -0700
Date:   Tue, 3 Aug 2021 22:22:26 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, Jan Kara <jack@suse.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com,
        Mel Gorman <mgorman@techsingularity.net>,
        0day robot <lkp@intel.com>
Subject: Re: [fsnotify] 4c40d6efc8: unixbench.score -3.3% regression
Message-ID: <20210803142225.GA28609@xsang-OptiPlex-9020>
References: <20210720155944.1447086-9-krisman@collabora.com>
 <20210731063818.GB18773@xsang-OptiPlex-9020>
 <CAOQ4uxgtke-jK3a1SxowdEhObw8rDuUXB-DSGCr-M1uVMWarww@mail.gmail.com>
 <CAOQ4uxh+do6SVyYCcNSM+7dqzSRU_Y-AXYuMyti4ESkmLdm5zQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxh+do6SVyYCcNSM+7dqzSRU_Y-AXYuMyti4ESkmLdm5zQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Amir,

On Sat, Jul 31, 2021 at 07:27:19PM +0300, Amir Goldstein wrote:
> On Sat, Jul 31, 2021 at 12:27 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Sat, Jul 31, 2021 at 9:20 AM kernel test robot <oliver.sang@intel.com> wrote:
> > >
> > >
> > >
> > > Greeting,
> > >
> > > FYI, we noticed a -3.3% regression of unixbench.score due to commit:
> > >
> > >
> > > commit: 4c40d6efc8b22b88a45c335ffd6d25b55d769f5b ("[PATCH v4 08/16] fsnotify: pass arguments of fsnotify() in struct fsnotify_event_info")
> > > url: https://github.com/0day-ci/linux/commits/Gabriel-Krisman-Bertazi/File-system-wide-monitoring/20210721-001444
> > > base: https://git.kernel.org/cgit/linux/kernel/git/jack/linux-fs.git fsnotify
> > >
> > > in testcase: unixbench
> > > on test machine: 96 threads 2 sockets Intel(R) Xeon(R) CPU @ 2.30GHz with 128G memory
> > > with following parameters:
> > >
> > >         runtime: 300s
> > >         nr_task: 1
> > >         test: pipe
> > >         cpufreq_governor: performance
> > >         ucode: 0x4003006
> > >
> > > test-description: UnixBench is the original BYTE UNIX benchmark suite aims to test performance of Unix-like system.
> > > test-url: https://github.com/kdlucas/byte-unixbench
> > >
> > > In addition to that, the commit also has significant impact on the following tests:
> > >
> > > +------------------+-------------------------------------------------------------------------------------+
> > > | testcase: change | will-it-scale: will-it-scale.per_thread_ops -1.3% regression                        |
> > > | test machine     | 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
> > > | test parameters  | cpufreq_governor=performance                                                        |
> > > |                  | mode=thread                                                                         |
> > > |                  | nr_task=100%                                                                        |
> > > |                  | test=eventfd1                                                                       |
> > > |                  | ucode=0x5003006                                                                     |
> > > +------------------+-------------------------------------------------------------------------------------+
> > >
> > >
> > > If you fix the issue, kindly add following tag
> > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > >
> >
> > Gabriel,
> >
> > It looks like my change throws away much of the performance gain for
> > small IO on pipes without any watches that was achieved by commit
> > 71d734103edf ("fsnotify: Rearrange fast path to minimise overhead
> > when there is no watcher").
> >
> > I think the way to fix it is to lift the optimization in __fsnotify()
> > to the fsnotify_parent() inline wrapper as Mel considered doing
> > but was not sure it was worth the effort at the time.
> >
> > It's not completely trivial. I think it requires setting a flag
> > MNT_FSNOTIFY_WATCHED when there are watches on the
> > vfsmount. I will look into it.
> >
> 
> Oliver,
> 
> Would it be possible to request a re-test with the branch:
> https://github.com/amir73il/linux fsnotify-perf
> 
> The patch at the tip of that branch is the one this regression report
> has blamed.
> 
> My expectation is that the patch at fsnotify-perf^ ("fsnotify: optimize the
> case of no marks of any type") will improve performance of the test case
> compared to baseline (v5.14-rc3) and that the patch at the tip of fsnotify-perf
> would not regress performance.

we tested this branch and the results meet your expectation.

fsnotify-perf^ improves performance comparing to v5.14-rc3. tip is a little worse
than its parent (-3.3%), but still better than v5.14-rc3.

below is detail data.


=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase/ucode:
  gcc-9/performance/x86_64-rhel-8.3/1/debian-10.4-x86_64-20200603.cgz/300s/lkp-csl-2sp4/pipe/unixbench/0x4003006

commit: 
  v5.14-rc3
  23050d041 ("fsnotify: optimize the case of no marks of any type")
  7446ba772 ("fsnotify: pass arguments of fsnotify() in struct fsnotify_event_info")

       v5.14-rc3 23050d0419441a02185e4ed5170 7446ba772ae107ab937cd04e880 
---------------- --------------------------- --------------------------- 
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \  
      1562            +8.0%       1688            +4.5%       1633        unixbench.score
    390.37            +0.0%     390.37            -0.0%     390.36        unixbench.time.elapsed_time
    390.37            +0.0%     390.37            -0.0%     390.36        unixbench.time.elapsed_time.max
    113.78 ± 91%    -100.0%       0.00           -84.4%      17.78 ±282%  unixbench.time.file_system_inputs
      3445 ± 89%    -100.0%       0.00           -82.6%     600.89 ±282%  unixbench.time.file_system_outputs
    560.89 ± 10%      -1.4%     553.00 ±  6%      -5.8%     528.22 ±  3%  unixbench.time.involuntary_context_switches
     10032            -0.3%      10001            -0.2%      10008        unixbench.time.maximum_resident_set_size
     50139            +0.1%      50173            -0.0%      50119        unixbench.time.minor_page_faults
      4096            +0.0%       4096            +0.0%       4096        unixbench.time.page_size
     76.00            +0.0%      76.00            +0.0%      76.00        unixbench.time.percent_of_cpu_this_job_got
    261.71            -0.9%     259.28            -0.8%     259.60        unixbench.time.system_time
     36.96            +6.5%      39.38            +5.5%      39.01        unixbench.time.user_time
    903.67 ±  5%      -6.7%     843.17            -5.1%     858.00 ±  4%  unixbench.time.voluntary_context_switches
 7.585e+08            +8.1%  8.198e+08            +4.5%  7.928e+08        unixbench.workload
 3.646e+10            -0.2%   3.64e+10            +0.5%  3.665e+10        cpuidle..time
  72938593 ±  9%      -2.4%   71214588 ± 11%      +2.7%   74876854        cpuidle..usage
    427.95            -0.0%     427.80            +0.0%     428.09        uptime.boot
     39776            -0.2%      39703            +0.4%      39920        uptime.idle
     35.32            -0.1%      35.28            +0.1%      35.37        boot-time.boot
     16.63            +0.1%      16.64            +0.3%      16.68        boot-time.dhcp
      2897            -0.2%       2890            +1.0%       2926        boot-time.idle
      0.97            +0.3%       0.98            +0.2%       0.98        boot-time.smp_boot
     97.59            -0.2       97.44            +0.3       97.93        mpstat.cpu.all.idle%
      0.00 ±  5%      -0.0        0.00 ±  5%      +0.0        0.00 ±  5%  mpstat.cpu.all.iowait%
      1.48 ± 25%      +0.1        1.62 ± 19%      -0.3        1.16 ±  6%  mpstat.cpu.all.irq%
      0.08 ± 25%      +0.0        0.09 ± 23%      -0.0        0.06 ±  6%  mpstat.cpu.all.soft%
      0.72            -0.0        0.72            -0.0        0.72        mpstat.cpu.all.sys%
      0.12            +0.0        0.13            +0.0        0.13        mpstat.cpu.all.usr%
      0.00          -100.0%       0.00          -100.0%       0.00        numa-numastat.node0.interleave_hit
    508271 ± 22%      -3.5%     490587 ± 15%      +2.8%     522300 ± 14%  numa-numastat.node0.local_node
    568022 ± 18%      -3.8%     546713 ± 13%      +3.8%     589704 ± 14%  numa-numastat.node0.numa_hit
     59789 ± 50%      -6.0%      56188 ± 47%     +12.7%      67391 ± 34%  numa-numastat.node0.other_node
      0.00          -100.0%       0.00          -100.0%       0.00        numa-numastat.node1.interleave_hit
    433905 ± 25%      +4.2%     452129 ± 16%      -3.3%     419730 ± 18%  numa-numastat.node1.local_node
    460898 ± 22%      +4.7%     482594 ± 15%      -4.7%     439025 ± 19%  numa-numastat.node1.numa_hit
     26971 ±112%     +13.3%      30571 ± 86%     -28.1%      19405 ±118%  numa-numastat.node1.other_node
    390.37            +0.0%     390.37            -0.0%     390.36        time.elapsed_time
    390.37            +0.0%     390.37            -0.0%     390.36        time.elapsed_time.max
    113.78 ± 91%    -100.0%       0.00           -84.4%      17.78 ±282%  time.file_system_inputs
      3445 ± 89%    -100.0%       0.00           -82.6%     600.89 ±282%  time.file_system_outputs
    560.89 ± 10%      -1.4%     553.00 ±  6%      -5.8%     528.22 ±  3%  time.involuntary_context_switches
     10032            -0.3%      10001            -0.2%      10008        time.maximum_resident_set_size
     50139            +0.1%      50173            -0.0%      50119        time.minor_page_faults
      4096            +0.0%       4096            +0.0%       4096        time.page_size
     76.00            +0.0%      76.00            +0.0%      76.00        time.percent_of_cpu_this_job_got
    261.71            -0.9%     259.28            -0.8%     259.60        time.system_time
     36.96            +6.5%      39.38            +5.5%      39.01        time.user_time
    903.67 ±  5%      -6.7%     843.17            -5.1%     858.00 ±  4%  time.voluntary_context_switches
     96.78            -0.5%      96.33            +0.3%      97.11        vmstat.cpu.id
      1.56 ± 31%      +7.1%       1.67 ± 28%     -35.7%       1.00        vmstat.cpu.sy
      0.00          -100.0%       0.00          -100.0%       0.00        vmstat.cpu.us
      9.44 ± 89%    -100.0%       0.00           -80.0%       1.89 ±282%  vmstat.io.bi
      4.11 ± 89%    -100.0%       0.00           -81.1%       0.78 ±282%  vmstat.io.bo
      7.89 ± 44%     -49.3%       4.00           -39.4%       4.78 ± 46%  vmstat.memory.buff
   2508417            -0.1%    2504846            -0.1%    2505666        vmstat.memory.cache
 1.278e+08            +0.0%  1.278e+08            +0.0%  1.278e+08        vmstat.memory.free
      0.00          -100.0%       0.00          -100.0%       0.00        vmstat.procs.b
      0.00          -100.0%       0.00          -100.0%       0.00        vmstat.procs.r
      1488 ±  2%      +1.4%       1509 ±  9%      -0.7%       1478 ±  3%  vmstat.system.cs
    185829 ±  9%      -1.7%     182747 ± 11%      +3.3%     192023        vmstat.system.in
     67.11 ± 13%      +2.2%      68.58 ± 12%     -14.9%      57.11 ±  2%  turbostat.Avg_MHz
      3.87 ± 24%      +0.3        4.17 ± 20%      -0.9        2.97 ±  4%  turbostat.Busy%
      1794 ± 13%      -6.4%       1679 ±  9%      +7.4%       1927 ±  5%  turbostat.Bzy_MHz
    774994 ±129%     +47.6%    1143588 ±194%     -11.3%     687474 ±264%  turbostat.C1
      0.33 ±169%      +0.1        0.39 ±308%      -0.1        0.19 ±271%  turbostat.C1%
  52685178 ± 37%     -10.0%   47392459 ± 44%     +40.0%   73744498 ±  2%  turbostat.C1E
     53.64 ± 70%     -10.1       43.52 ± 87%     +42.8       96.44        turbostat.C1E%
  19397931 ± 87%     +16.4%   22575610 ± 70%     -98.1%     371152 ± 18%  turbostat.C6
     42.98 ± 88%      +9.9       52.84 ± 70%     -42.2        0.77 ± 26%  turbostat.C6%
     86.37 ± 12%      -4.2%      82.74 ± 12%     +12.3%      97.00        turbostat.CPU%c1
      9.76 ±100%     +34.1%      13.09 ± 74%     -99.7%       0.03 ± 41%  turbostat.CPU%c6
     54.56 ±  2%      -3.0%      52.92 ±  3%      -1.2%      53.89 ±  3%  turbostat.CoreTmp
  72993878 ±  9%      -1.7%   71782914 ± 11%      +3.4%   75452294        turbostat.IRQ
      6.37 ±110%     +36.5%       8.69 ± 80%     -99.9%       0.00 ±282%  turbostat.Pkg%pc2
      1.16 ±121%     +52.8%       1.78 ± 82%    -100.0%       0.00        turbostat.Pkg%pc6
     54.89 ±  2%      -3.3%      53.08 ±  3%      -1.8%      53.89 ±  3%  turbostat.PkgTmp
    107.25 ±  4%      -2.5%     104.52            +0.3%     107.56 ±  2%  turbostat.PkgWatt
     40.75            -0.6%      40.52            +0.1%      40.80        turbostat.RAMWatt
      2295            -0.0%       2294            +0.0%       2295        turbostat.TSC_MHz
     11595 ±  4%      -4.0%      11130 ±  3%      -4.1%      11123 ±  3%  meminfo.Active
     10946 ±  2%      +0.1%      10953 ±  3%      -0.9%      10846 ±  3%  meminfo.Active(anon)
    648.56 ± 63%     -72.8%     176.58 ±  2%     -57.2%     277.44 ± 87%  meminfo.Active(file)
    184807            +0.1%     184995            +0.6%     185867        meminfo.AnonHugePages
    260664            +0.4%     261637            +0.6%     262146        meminfo.AnonPages
      7.89 ± 44%     -49.3%       4.00           -39.4%       4.78 ± 46%  meminfo.Buffers
   2404339            -0.1%    2400789            -0.1%    2401307        meminfo.Cached
    201222            +0.1%     201365            +0.1%     201340        meminfo.CmaFree
    204800            +0.0%     204800            +0.0%     204800        meminfo.CmaTotal
  65839596            +0.0%   65839596            +0.0%   65839596        meminfo.CommitLimit
    365007            +0.1%     365193            -0.0%     364843        meminfo.Committed_AS
 1.221e+08            -0.1%   1.22e+08            -0.7%  1.213e+08        meminfo.DirectMap1G
  13069880 ± 14%      +1.1%   13207381 ± 15%      +6.3%   13888398 ± 17%  meminfo.DirectMap2M
    822421 ±  4%      -2.6%     801429 ±  3%      -0.4%     819463 ±  5%  meminfo.DirectMap4k
      1.11 ± 89%    -100.0%       0.00           -80.0%       0.22 ±282%  meminfo.Dirty
      2048            +0.0%       2048            +0.0%       2048        meminfo.Hugepagesize
    273336            -0.8%     271017            -0.6%     271801        meminfo.Inactive
    270008            +0.3%     270869            +0.4%     271018        meminfo.Inactive(anon)
      3327 ± 85%     -95.6%     147.25           -76.5%     782.89 ±229%  meminfo.Inactive(file)
    104056            -0.0%     104033            +0.3%     104340        meminfo.KReclaimable
     16407            +0.6%      16499            +0.8%      16546        meminfo.KernelStack
     35129            +0.3%      35223            +0.1%      35172        meminfo.Mapped
 1.272e+08            +0.0%  1.272e+08            +0.0%  1.272e+08        meminfo.MemAvailable
 1.278e+08            +0.0%  1.278e+08            +0.0%  1.278e+08        meminfo.MemFree
 1.317e+08            +0.0%  1.317e+08            +0.0%  1.317e+08        meminfo.MemTotal
   3891419            -0.1%    3887765            -0.1%    3888354        meminfo.Memused
      1100 ± 65%     +18.3%       1301 ± 55%      +0.1%       1101 ± 65%  meminfo.Mlocked
      4027            +0.0%       4028            -0.3%       4014        meminfo.PageTables
     47685            -0.0%      47665            -0.3%      47541        meminfo.Percpu
    104056            -0.0%     104033            +0.3%     104340        meminfo.SReclaimable
    195896            -0.2%     195533            +0.4%     196756        meminfo.SUnreclaim
     20527            +0.0%      20537            -0.8%      20362        meminfo.Shmem
    299953            -0.1%     299567            +0.4%     301097        meminfo.Slab
   2380001            +0.0%    2380119            +0.0%    2380047        meminfo.Unevictable
 3.436e+10            +0.0%  3.436e+10            +0.0%  3.436e+10        meminfo.VmallocTotal
    170334            +0.1%     170435            +0.1%     170510        meminfo.VmallocUsed
      0.11 ±282%    -100.0%       0.00          -100.0%       0.00        meminfo.Writeback
   4253511            +0.0%    4253640            -0.1%    4248176        meminfo.max_used_kB
      3331 ± 46%     +11.1%       3702 ± 41%     +12.9%       3761 ± 42%  numa-meminfo.node0.Active
      2685 ± 53%     +31.8%       3539 ± 42%     +31.3%       3526 ± 41%  numa-meminfo.node0.Active(anon)
    645.44 ± 63%     -74.9%     161.92 ± 30%     -63.6%     234.78 ±115%  numa-meminfo.node0.Active(file)
    176640 ±  4%      -9.6%     159633 ± 30%     -14.9%     150241 ± 38%  numa-meminfo.node0.AnonHugePages
    235558 ±  3%      -8.4%     215743 ± 27%     -13.9%     202732 ± 35%  numa-meminfo.node0.AnonPages
    243183 ±  4%      -6.7%     226936 ± 26%     -13.7%     209848 ± 32%  numa-meminfo.node0.AnonPages.max
      0.44 ±187%    -100.0%       0.00          -100.0%       0.00        numa-meminfo.node0.Dirty
   1649175 ± 58%     +20.8%    1992434 ± 38%     +27.9%    2109828 ± 31%  numa-meminfo.node0.FilePages
    244464 ±  3%     -10.0%     220102 ± 28%     -14.8%     208186 ± 33%  numa-meminfo.node0.Inactive
    242388 ±  3%      -9.3%     219966 ± 28%     -14.4%     207445 ± 33%  numa-meminfo.node0.Inactive(anon)
      2075 ±128%     -93.5%     134.92 ± 30%     -64.3%     740.33 ±240%  numa-meminfo.node0.Inactive(file)
     65344 ± 23%      +6.2%      69380 ± 24%      +7.1%      70004 ± 18%  numa-meminfo.node0.KReclaimable
      9492 ±  4%      -1.6%       9338 ±  5%      -8.6%       8674 ±  7%  numa-meminfo.node0.KernelStack
     25629 ± 41%      +8.4%      27785 ± 34%     +12.1%      28733 ± 29%  numa-meminfo.node0.Mapped
  63052050            -0.4%   62775986            -0.6%   62655763        numa-meminfo.node0.MemFree
  65665512            +0.0%   65665512            +0.0%   65665512        numa-meminfo.node0.MemTotal
   2613460 ± 38%     +10.6%    2889524 ± 28%     +15.2%    3009747 ± 23%  numa-meminfo.node0.MemUsed
    831.11 ± 92%     +45.9%       1212 ± 64%     +26.2%       1049 ± 73%  numa-meminfo.node0.Mlocked
      3019 ±  5%      -6.8%       2813 ± 21%     -13.4%       2615 ± 26%  numa-meminfo.node0.PageTables
     65344 ± 23%      +6.2%      69380 ± 24%      +7.1%      70004 ± 18%  numa-meminfo.node0.SReclaimable
    114422 ±  7%      -5.1%     108617 ± 12%      -7.7%     105637 ±  8%  numa-meminfo.node0.SUnreclaim
      9968 ± 44%     -17.9%       8180 ± 59%     -12.7%       8702 ± 57%  numa-meminfo.node0.Shmem
    179767 ±  8%      -1.0%     177998 ± 15%      -2.3%     175641 ± 11%  numa-meminfo.node0.Slab
   1636644 ± 59%     +21.2%    1984121 ± 38%     +28.3%    2100300 ± 31%  numa-meminfo.node0.Unevictable
      0.11 ±282%    -100.0%       0.00          -100.0%       0.00        numa-meminfo.node0.Writeback
      8243 ± 16%     -10.1%       7411 ± 21%     -10.9%       7347 ± 22%  numa-meminfo.node1.Active
      8240 ± 16%     -10.2%       7397 ± 21%     -11.4%       7304 ± 22%  numa-meminfo.node1.Active(anon)
      3.11 ±187%    +371.4%      14.67 ±331%   +1271.4%      42.67 ±187%  numa-meminfo.node1.Active(file)
      8134 ± 95%    +211.4%      25330 ±193%    +337.7%      35606 ±163%  numa-meminfo.node1.AnonHugePages
     25161 ± 30%     +82.6%      45942 ±131%    +136.3%      59456 ±120%  numa-meminfo.node1.AnonPages
     51771 ± 22%     +39.7%      72336 ± 82%     +67.2%      86537 ± 80%  numa-meminfo.node1.AnonPages.max
      0.67 ±141%    -100.0%       0.00           -66.7%       0.22 ±282%  numa-meminfo.node1.Dirty
    755159 ±128%     -45.9%     408353 ±189%     -61.4%     291472 ±224%  numa-meminfo.node1.FilePages
     28934 ± 29%     +76.2%      50974 ±121%    +120.0%      63661 ±109%  numa-meminfo.node1.Inactive
     27681 ± 30%     +84.1%      50962 ±121%    +129.8%      63618 ±108%  numa-meminfo.node1.Inactive(anon)
      1252 ±185%     -99.0%      12.33 ±331%     -96.6%      42.44 ±146%  numa-meminfo.node1.Inactive(file)
     38709 ± 37%     -10.5%      34650 ± 50%     -11.3%      34333 ± 39%  numa-meminfo.node1.KReclaimable
      6917 ±  5%      +3.5%       7160 ±  8%     +13.8%       7872 ±  8%  numa-meminfo.node1.KernelStack
      9521 ±110%     -21.6%       7460 ±125%     -32.2%       6452 ±132%  numa-meminfo.node1.Mapped
  64734839            +0.4%   65014696            +0.6%   65134389        numa-meminfo.node1.MemFree
  66013684            +0.0%   66013684            +0.0%   66013684        numa-meminfo.node1.MemTotal
   1278843 ± 79%     -21.9%     998986 ± 83%     -31.2%     879293 ± 79%  numa-meminfo.node1.MemUsed
    267.67 ±189%     -67.2%      87.67 ±175%     -81.2%      50.33 ±240%  numa-meminfo.node1.Mlocked
      1007 ± 16%     +20.5%       1213 ± 50%     +38.9%       1399 ± 49%  numa-meminfo.node1.PageTables
     38709 ± 37%     -10.5%      34650 ± 50%     -11.3%      34333 ± 39%  numa-meminfo.node1.SReclaimable
     81477 ± 12%      +6.7%      86919 ± 18%     +11.8%      91120 ± 11%  numa-meminfo.node1.SUnreclaim
     10546 ± 40%     +17.1%      12352 ± 38%     +10.4%      11647 ± 41%  numa-meminfo.node1.Shmem
    120186 ± 12%      +1.2%     121570 ± 24%      +4.4%     125454 ± 18%  numa-meminfo.node1.Slab
    743356 ±130%     -46.7%     395996 ±195%     -62.4%     279745 ±233%  numa-meminfo.node1.Unevictable
    392.00            +0.0%     392.00            +0.0%     392.00        proc-vmstat.cma_alloc_success
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.compact_isolated
    385.67 ±  5%      -2.7%     375.42 ±  4%      -0.4%     384.22 ±  5%  proc-vmstat.direct_map_level2_splits
      9.56 ± 18%      +0.3%       9.58 ± 22%      +7.0%      10.22 ± 22%  proc-vmstat.direct_map_level3_splits
      2734 ±  2%      +0.1%       2737 ±  3%      -0.8%       2711 ±  3%  proc-vmstat.nr_active_anon
    161.78 ± 63%     -73.1%      43.58 ±  2%     -57.5%      68.78 ± 88%  proc-vmstat.nr_active_file
     65169            +0.4%      65410            +0.6%      65536        proc-vmstat.nr_anon_pages
     89.78            -0.0%      89.75            +0.7%      90.44        proc-vmstat.nr_anon_transparent_hugepages
    444.00 ± 89%    -100.0%       0.00           -82.5%      77.78 ±282%  proc-vmstat.nr_dirtied
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.nr_dirty
   3174707            +0.0%    3174712            +0.0%    3174717        proc-vmstat.nr_dirty_background_threshold
   6357177            +0.0%    6357187            +0.0%    6357197        proc-vmstat.nr_dirty_threshold
    601084            -0.1%     600197            -0.1%     600327        proc-vmstat.nr_file_pages
     50305            +0.1%      50341            +0.1%      50335        proc-vmstat.nr_free_cma
  31946873            +0.0%   31947836            +0.0%   31947701        proc-vmstat.nr_free_pages
     67505            +0.3%      67718            +0.4%      67754        proc-vmstat.nr_inactive_anon
    831.33 ± 85%     -95.6%      36.25           -76.5%     195.33 ±229%  proc-vmstat.nr_inactive_file
     16409            +0.5%      16497            +0.8%      16547        proc-vmstat.nr_kernel_stack
      8782            +0.3%       8805            +0.1%       8793        proc-vmstat.nr_mapped
    274.44 ± 65%     +18.4%     324.83 ± 55%      +0.2%     274.89 ± 65%  proc-vmstat.nr_mlock
      1006            -0.0%       1006            -0.3%       1003        proc-vmstat.nr_page_table_pages
      5129            +0.1%       5133            -0.8%       5090        proc-vmstat.nr_shmem
     26013            -0.0%      26007            +0.3%      26084        proc-vmstat.nr_slab_reclaimable
     48974            -0.2%      48883            +0.4%      49188        proc-vmstat.nr_slab_unreclaimable
    595000            +0.0%     595029            +0.0%     595011        proc-vmstat.nr_unevictable
    444.00 ± 89%    -100.0%       0.00           -82.5%      77.78 ±282%  proc-vmstat.nr_written
      2734 ±  2%      +0.1%       2737 ±  3%      -0.8%       2711 ±  3%  proc-vmstat.nr_zone_active_anon
    161.78 ± 63%     -73.1%      43.58 ±  2%     -57.5%      68.78 ± 88%  proc-vmstat.nr_zone_active_file
     67505            +0.3%      67718            +0.4%      67754        proc-vmstat.nr_zone_inactive_anon
    831.33 ± 85%     -95.6%      36.25           -76.5%     195.33 ±229%  proc-vmstat.nr_zone_inactive_file
    595000            +0.0%     595029            +0.0%     595011        proc-vmstat.nr_zone_unevictable
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.nr_zone_write_pending
    528.00 ±166%    +144.6%       1291 ±202%      +7.7%     568.56 ±251%  proc-vmstat.numa_hint_faults
    297.78 ±238%    +117.2%     646.75 ±301%     -82.6%      51.78 ± 33%  proc-vmstat.numa_hint_faults_local
   1033052            +0.1%    1034106            +0.5%    1037901        proc-vmstat.numa_hit
     58.67 ± 35%      -1.8%      57.58 ± 37%      -5.3%      55.56 ± 36%  proc-vmstat.numa_huge_pte_updates
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.numa_interleave
    946308            +0.2%     948540            +0.5%     951201        proc-vmstat.numa_local
     86760            -0.0%      86760            +0.0%      86797        proc-vmstat.numa_other
    684.11 ±252%    +224.6%       2220 ±241%    +257.7%       2447 ±280%  proc-vmstat.numa_pages_migrated
     32541 ± 38%      +6.3%      34605 ± 48%      -4.9%      30940 ± 53%  proc-vmstat.numa_pte_updates
      3208 ±  8%      -6.3%       3005 ±  9%      -4.6%       3060 ±  8%  proc-vmstat.pgactivate
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.pgalloc_dma
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.pgalloc_dma32
   1035736            +0.0%    1035978            +0.0%    1035903        proc-vmstat.pgalloc_normal
   1168271            +0.2%    1170241            +0.1%    1169796        proc-vmstat.pgfault
   1070341            +0.1%    1071645            +0.1%    1071935        proc-vmstat.pgfree
    684.11 ±252%    +224.6%       2220 ±241%    +257.7%       2447 ±280%  proc-vmstat.pgmigrate_success
      3763 ± 89%    -100.0%       0.00           -80.1%     750.22 ±282%  proc-vmstat.pgpgin
      1789 ± 89%    -100.0%       0.00           -82.5%     313.78 ±282%  proc-vmstat.pgpgout
     83209            +0.0%      83237            +0.7%      83775        proc-vmstat.pgreuse
     97.22            -0.3%      96.92            -0.1%      97.11        proc-vmstat.thp_collapse_alloc
      0.78 ±157%     -35.7%       0.50 ±223%     -85.7%       0.11 ±282%  proc-vmstat.thp_deferred_split_page
     12.33 ±  5%      +0.7%      12.42 ±  5%      -2.7%      12.00        proc-vmstat.thp_fault_alloc
      0.89 ±245%    +246.9%       3.08 ±322%    +325.0%       3.78 ±282%  proc-vmstat.thp_migration_success
      0.78 ±157%     -35.7%       0.50 ±223%     -85.7%       0.11 ±282%  proc-vmstat.thp_split_pmd
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.thp_zero_page_alloc
    113.11            +0.9%     114.17            +0.7%     113.89        proc-vmstat.unevictable_pgs_culled
    586.00            +0.0%     586.00            +0.0%     586.00        proc-vmstat.unevictable_pgs_mlocked
    671.00 ± 53%     +31.8%     884.58 ± 42%     +31.3%     881.11 ± 41%  numa-vmstat.node0.nr_active_anon
    161.00 ± 63%     -75.2%      39.92 ± 30%     -63.8%      58.22 ±116%  numa-vmstat.node0.nr_active_file
     58889 ±  3%      -8.4%      53935 ± 27%     -13.9%      50683 ± 35%  numa-vmstat.node0.nr_anon_pages
     85.67 ±  4%      -9.6%      77.42 ± 30%     -14.9%      72.89 ± 39%  numa-vmstat.node0.nr_anon_transparent_hugepages
    376.67 ± 89%    -100.0%       0.00           -82.7%      65.11 ±282%  numa-vmstat.node0.nr_dirtied
      0.00          -100.0%       0.00          -100.0%       0.00        numa-vmstat.node0.nr_dirty
    412293 ± 58%     +20.8%     498108 ± 38%     +27.9%     527456 ± 31%  numa-vmstat.node0.nr_file_pages
     50305            +0.1%      50341            +0.1%      50335        numa-vmstat.node0.nr_free_cma
  15763023            -0.4%   15693998            -0.6%   15663929        numa-vmstat.node0.nr_free_pages
     60596 ±  3%      -9.2%      54991 ± 28%     -14.4%      51861 ± 33%  numa-vmstat.node0.nr_inactive_anon
    518.78 ±128%     -93.6%      33.17 ± 30%     -64.4%     184.78 ±241%  numa-vmstat.node0.nr_inactive_file
      0.00          -100.0%       0.00          -100.0%       0.00        numa-vmstat.node0.nr_isolated_anon
      9491 ±  4%      -1.6%       9341 ±  5%      -8.6%       8676 ±  7%  numa-vmstat.node0.nr_kernel_stack
      6408 ± 41%      +8.4%       6946 ± 34%     +12.1%       7184 ± 29%  numa-vmstat.node0.nr_mapped
    207.56 ± 93%     +45.9%     302.83 ± 64%     +26.2%     261.89 ± 73%  numa-vmstat.node0.nr_mlock
    753.89 ±  5%      -6.7%     703.67 ± 21%     -13.3%     653.78 ± 26%  numa-vmstat.node0.nr_page_table_pages
      2492 ± 44%     -17.9%       2044 ± 59%     -12.7%       2175 ± 57%  numa-vmstat.node0.nr_shmem
     16335 ± 23%      +6.2%      17344 ± 24%      +7.1%      17500 ± 18%  numa-vmstat.node0.nr_slab_reclaimable
     28605 ±  7%      -5.1%      27153 ± 12%      -7.7%      26408 ±  8%  numa-vmstat.node0.nr_slab_unreclaimable
    409160 ± 59%     +21.2%     496029 ± 38%     +28.3%     525074 ± 31%  numa-vmstat.node0.nr_unevictable
      0.00          -100.0%       0.00          -100.0%       0.00        numa-vmstat.node0.nr_writeback
    376.44 ± 89%    -100.0%       0.00           -82.7%      65.11 ±282%  numa-vmstat.node0.nr_written
    671.00 ± 53%     +31.8%     884.58 ± 42%     +31.3%     881.11 ± 41%  numa-vmstat.node0.nr_zone_active_anon
    161.00 ± 63%     -75.2%      39.92 ± 30%     -63.8%      58.22 ±116%  numa-vmstat.node0.nr_zone_active_file
     60596 ±  3%      -9.2%      54991 ± 28%     -14.4%      51861 ± 33%  numa-vmstat.node0.nr_zone_inactive_anon
    518.78 ±128%     -93.6%      33.17 ± 30%     -64.4%     184.78 ±241%  numa-vmstat.node0.nr_zone_inactive_file
    409160 ± 59%     +21.2%     496029 ± 38%     +28.3%     525074 ± 31%  numa-vmstat.node0.nr_zone_unevictable
      0.00          -100.0%       0.00          -100.0%       0.00        numa-vmstat.node0.nr_zone_write_pending
   1661451 ± 13%      +2.6%    1704304 ± 15%      +5.4%    1751623 ± 12%  numa-vmstat.node0.numa_hit
      3894 ±  8%      +0.3%       3905 ±  5%      -0.6%       3872 ±  6%  numa-vmstat.node0.numa_interleave
   1598537 ± 14%      +2.9%    1645037 ± 16%      +5.1%    1680768 ± 12%  numa-vmstat.node0.numa_local
     62954 ± 49%      -4.3%      60267 ± 44%     +12.6%      70856 ± 30%  numa-vmstat.node0.numa_other
      2060 ± 16%     -10.2%       1849 ± 21%     -11.4%       1825 ± 22%  numa-vmstat.node1.nr_active_anon
      0.67 ±187%    +450.0%       3.67 ±331%   +1500.0%      10.67 ±187%  numa-vmstat.node1.nr_active_file
      6291 ± 30%     +82.6%      11487 ±131%    +136.3%      14866 ±120%  numa-vmstat.node1.nr_anon_pages
      3.44 ±105%    +243.5%      11.83 ±201%    +383.9%      16.67 ±171%  numa-vmstat.node1.nr_anon_transparent_hugepages
      7.00 ±141%    -100.0%       0.00           -66.7%       2.33 ±282%  numa-vmstat.node1.nr_dirtied
      0.00          -100.0%       0.00          -100.0%       0.00        numa-vmstat.node1.nr_dirty
    188791 ±128%     -45.9%     102090 ±189%     -61.4%      72868 ±224%  numa-vmstat.node1.nr_file_pages
  16183708            +0.4%   16253674            +0.6%   16283582        numa-vmstat.node1.nr_free_pages
      6923 ± 30%     +84.1%      12744 ±121%    +129.8%      15907 ±108%  numa-vmstat.node1.nr_inactive_anon
    313.11 ±185%     -99.0%       3.08 ±331%     -96.6%      10.56 ±147%  numa-vmstat.node1.nr_inactive_file
      6916 ±  5%      +3.5%       7159 ±  8%     +13.8%       7874 ±  8%  numa-vmstat.node1.nr_kernel_stack
      2381 ±110%     -21.6%       1866 ±125%     -32.2%       1613 ±132%  numa-vmstat.node1.nr_mapped
     66.89 ±189%     -67.2%      21.92 ±175%     -81.2%      12.56 ±241%  numa-vmstat.node1.nr_mlock
    251.33 ± 15%     +20.5%     302.75 ± 50%     +39.3%     350.11 ± 49%  numa-vmstat.node1.nr_page_table_pages
      2638 ± 40%     +17.1%       3089 ± 38%     +10.4%       2912 ± 41%  numa-vmstat.node1.nr_shmem
      9677 ± 37%     -10.5%       8662 ± 50%     -11.3%       8582 ± 39%  numa-vmstat.node1.nr_slab_reclaimable
     20368 ± 12%      +6.7%      21729 ± 18%     +11.8%      22779 ± 11%  numa-vmstat.node1.nr_slab_unreclaimable
    185838 ±130%     -46.7%      98998 ±195%     -62.4%      69935 ±233%  numa-vmstat.node1.nr_unevictable
      7.00 ±141%    -100.0%       0.00           -66.7%       2.33 ±282%  numa-vmstat.node1.nr_written
      2060 ± 16%     -10.2%       1849 ± 21%     -11.4%       1825 ± 22%  numa-vmstat.node1.nr_zone_active_anon
      0.67 ±187%    +450.0%       3.67 ±331%   +1500.0%      10.67 ±187%  numa-vmstat.node1.nr_zone_active_file
      6923 ± 30%     +84.1%      12743 ±121%    +129.8%      15907 ±108%  numa-vmstat.node1.nr_zone_inactive_anon
    313.11 ±185%     -99.0%       3.08 ±331%     -96.6%      10.56 ±147%  numa-vmstat.node1.nr_zone_inactive_file
    185838 ±130%     -46.7%      98998 ±195%     -62.4%      69935 ±233%  numa-vmstat.node1.nr_zone_unevictable
      0.00          -100.0%       0.00          -100.0%       0.00        numa-vmstat.node1.nr_zone_write_pending
    923522 ± 24%      -4.1%     886107 ± 29%      -9.2%     838695 ± 26%  numa-vmstat.node1.numa_hit
      3652 ±  8%      -0.1%       3650 ±  6%      +0.9%       3685 ±  6%  numa-vmstat.node1.numa_interleave
    886782 ± 26%      -4.5%     846839 ± 32%      -8.7%     810030 ± 25%  numa-vmstat.node1.numa_local
     36727 ± 84%      +7.2%      39378 ± 68%     -21.7%      28741 ± 76%  numa-vmstat.node1.numa_other
     13.36 ± 85%     +28.8%      17.20 ± 67%     -89.9%       1.36 ±  3%  perf-stat.i.MPKI
 9.529e+08            -1.6%   9.38e+08            -2.1%  9.327e+08        perf-stat.i.branch-instructions
      2.12 ± 53%      +0.3        2.37 ± 48%      -1.2        0.92        perf-stat.i.branch-miss-rate%
  12593796 ± 34%      -0.6%   12517767 ± 34%     -37.8%    7836536        perf-stat.i.branch-misses
      5.54 ± 36%      -0.5        5.07 ± 41%      +2.6        8.12 ±  5%  perf-stat.i.cache-miss-rate%
   1100829 ± 63%     +15.7%    1273764 ± 52%     -69.8%     332573 ±  7%  perf-stat.i.cache-misses
  27486243 ± 77%     +23.0%   33803685 ± 62%     -85.7%    3933550 ±  3%  perf-stat.i.cache-references
      1422 ±  2%      +1.5%       1443 ±  9%      -0.6%       1414 ±  3%  perf-stat.i.context-switches
      1.94 ± 26%      +6.6%       2.07 ± 25%     -30.5%       1.35 ±  3%  perf-stat.i.cpi
     96002            +0.0%      96003            +0.0%      96002        perf-stat.i.cpu-clock
 5.879e+09 ± 14%      +1.5%  5.968e+09 ± 14%     -17.4%  4.854e+09 ±  3%  perf-stat.i.cpu-cycles
     98.53            +0.0%      98.54            +0.1%      98.64        perf-stat.i.cpu-migrations
     10513 ± 68%     -18.8%       8541 ± 74%     +61.8%      17015 ±  8%  perf-stat.i.cycles-between-cache-misses
      0.15 ± 89%      +0.0        0.18 ± 71%      -0.1        0.00 ±  9%  perf-stat.i.dTLB-load-miss-rate%
    882684 ± 88%     +16.5%    1027981 ± 71%     -98.4%      14258 ±  8%  perf-stat.i.dTLB-load-misses
 1.433e+09            +0.0%  1.434e+09            -0.7%  1.423e+09        perf-stat.i.dTLB-loads
      0.03 ± 86%      +0.0        0.04 ± 69%      -0.0        0.00 ±  2%  perf-stat.i.dTLB-store-miss-rate%
    112250 ± 83%     +15.1%     129192 ± 67%     -93.3%       7499        perf-stat.i.dTLB-store-misses
  8.75e+08            -3.8%  8.418e+08            -5.3%  8.285e+08        perf-stat.i.dTLB-stores
     76.52 ±  6%      -0.5       75.98 ±  6%      -3.5       73.02        perf-stat.i.iTLB-load-miss-rate%
   5320929           -18.5%    4337810 ±  4%      +0.8%    5364196        perf-stat.i.iTLB-load-misses
   1210384 ± 24%     -11.2%    1074564 ± 26%     +19.4%    1444799 ±  2%  perf-stat.i.iTLB-loads
  4.83e+09            -1.1%  4.775e+09            -1.7%  4.747e+09        perf-stat.i.instructions
    980.79 ±  2%     +19.7%       1174 ±  6%      -2.7%     954.36        perf-stat.i.instructions-per-iTLB-miss
      0.80 ± 12%      -1.9%       0.79 ± 13%     +13.9%       0.92 ±  2%  perf-stat.i.ipc
      0.61 ± 22%      +5.4%       0.64 ± 17%      +5.0%       0.64 ± 23%  perf-stat.i.major-faults
      0.06 ± 14%      +1.5%       0.06 ± 14%     -17.4%       0.05 ±  3%  perf-stat.i.metric.GHz
    313.74 ± 75%     +23.1%     386.17 ± 61%     -82.1%      56.26 ±  2%  perf-stat.i.metric.K/sec
     33.96            -1.5%      33.45            -2.3%      33.17        perf-stat.i.metric.M/sec
      2694            -0.0%       2694            +0.1%       2696        perf-stat.i.minor-faults
     86.80 ±  2%      +0.5       87.28 ±  2%      +3.7       90.50        perf-stat.i.node-load-miss-rate%
     58546 ± 16%      +5.7%      61885 ± 17%     +24.1%      72659 ±  8%  perf-stat.i.node-load-misses
     11768 ±  8%      -1.6%      11585 ±  8%     -15.6%       9928 ± 16%  perf-stat.i.node-loads
     73.58 ± 16%      -0.4       73.15 ± 25%     +13.8       87.41 ± 17%  perf-stat.i.node-store-miss-rate%
     25184 ± 14%      +6.3%      26770 ± 28%     +20.4%      30317 ± 19%  perf-stat.i.node-store-misses
     11083 ± 36%      +3.4%      11464 ± 50%     -44.3%       6175 ± 72%  perf-stat.i.node-stores
      2695            -0.0%       2694            +0.1%       2697        perf-stat.i.page-faults
     96002            +0.0%      96003            +0.0%      96002        perf-stat.i.task-clock
      5.71 ± 77%     +24.1%       7.09 ± 62%     -85.5%       0.83 ±  3%  perf-stat.overall.MPKI
      1.32 ± 34%      +0.0        1.34 ± 34%      -0.5        0.84        perf-stat.overall.branch-miss-rate%
      5.70 ± 38%      -0.5        5.18 ± 43%      +2.7        8.45 ±  5%  perf-stat.overall.cache-miss-rate%
      1.22 ± 14%      +2.6%       1.25 ± 14%     -16.0%       1.02 ±  2%  perf-stat.overall.cpi
      9179 ± 65%     -18.8%       7449 ± 70%     +59.8%      14669 ±  7%  perf-stat.overall.cycles-between-cache-misses
      0.06 ± 88%      +0.0        0.07 ± 71%      -0.1        0.00 ±  8%  perf-stat.overall.dTLB-load-miss-rate%
      0.01 ± 83%      +0.0        0.02 ± 67%      -0.0        0.00        perf-stat.overall.dTLB-store-miss-rate%
     81.65 ±  4%      -1.2       80.41 ±  4%      -2.9       78.78        perf-stat.overall.iTLB-load-miss-rate%
    907.89           +21.6%       1103 ±  5%      -2.5%     885.40 ±  2%  perf-stat.overall.instructions-per-iTLB-miss
      0.84 ± 14%      -2.5%       0.82 ± 15%     +16.7%       0.98 ±  2%  perf-stat.overall.ipc
     82.90 ±  3%      +1.0       83.91 ±  3%      +5.0       87.92 ±  2%  perf-stat.overall.node-load-miss-rate%
     69.61 ± 15%      -0.0       69.61 ± 23%     +13.0       82.57 ± 17%  perf-stat.overall.node-store-miss-rate%
      2484            -8.6%       2271            -6.0%       2335        perf-stat.overall.path-length
 9.504e+08            -1.6%  9.354e+08            -2.1%  9.303e+08        perf-stat.ps.branch-instructions
  12563461 ± 34%      -0.6%   12486690 ± 34%     -37.8%    7817966        perf-stat.ps.branch-misses
   1098102 ± 63%     +15.7%    1270644 ± 52%     -69.8%     331694 ±  7%  perf-stat.ps.cache-misses
  27418760 ± 77%     +23.0%   33722634 ± 62%     -85.7%    3923602 ±  3%  perf-stat.ps.cache-references
      1418 ±  2%      +1.5%       1439 ±  9%      -0.6%       1410 ±  3%  perf-stat.ps.context-switches
     95755            +0.0%      95755            +0.0%      95755        perf-stat.ps.cpu-clock
 5.864e+09 ± 14%      +1.5%  5.952e+09 ± 14%     -17.4%  4.841e+09 ±  3%  perf-stat.ps.cpu-cycles
     98.28            +0.0%      98.28            +0.1%      98.39        perf-stat.ps.cpu-migrations
    880507 ± 88%     +16.5%    1025511 ± 71%     -98.4%      14222 ±  8%  perf-stat.ps.dTLB-load-misses
 1.429e+09            +0.0%   1.43e+09            -0.7%   1.42e+09        perf-stat.ps.dTLB-loads
    111971 ± 83%     +15.1%     128879 ± 67%     -93.3%       7478        perf-stat.ps.dTLB-store-misses
 8.727e+08            -3.8%  8.394e+08            -5.3%  8.264e+08        perf-stat.ps.dTLB-stores
   5306748           -18.5%    4326031 ±  4%      +0.8%    5350615        perf-stat.ps.iTLB-load-misses
   1207238 ± 24%     -11.2%    1071729 ± 26%     +19.4%    1441083 ±  2%  perf-stat.ps.iTLB-loads
 4.817e+09            -1.2%  4.762e+09            -1.7%  4.735e+09        perf-stat.ps.instructions
      0.61 ± 22%      +5.4%       0.64 ± 17%      +5.1%       0.64 ± 23%  perf-stat.ps.major-faults
      2687            -0.0%       2686            +0.1%       2689        perf-stat.ps.minor-faults
     58400 ± 16%      +5.7%      61728 ± 17%     +24.1%      72475 ±  8%  perf-stat.ps.node-load-misses
     11737 ±  8%      -1.6%      11551 ±  8%     -15.6%       9900 ± 16%  perf-stat.ps.node-loads
     25118 ± 14%      +6.3%      26701 ± 28%     +20.4%      30237 ± 19%  perf-stat.ps.node-store-misses
     11051 ± 36%      +3.4%      11430 ± 50%     -44.3%       6155 ± 72%  perf-stat.ps.node-stores
      2687            -0.0%       2687            +0.1%       2689        perf-stat.ps.page-faults
     95755            +0.0%      95755            +0.0%      95755        perf-stat.ps.task-clock
 1.885e+12            -1.2%  1.862e+12            -1.8%  1.852e+12        perf-stat.total.instructions
      0.01 ± 50%     +10.2%       0.01 ± 46%     -20.5%       0.01 ± 31%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.00 ±161%    +221.9%       0.01 ±104%     -41.7%       0.00 ±142%  perf-sched.sch_delay.avg.ms.cleaner_kthread.kthread.ret_from_fork
      0.00        +1.7e+98%       0.00 ±331%  +3.3e+98%       0.00 ±282%  perf-sched.sch_delay.avg.ms.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.part
      0.02 ±129%     -45.2%       0.01 ± 19%     -50.4%       0.01 ± 11%  perf-sched.sch_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.01 ± 49%      +6.5%       0.01 ± 52%     -36.4%       0.01 ± 22%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      0.01 ± 14%     -12.3%       0.01 ± 32%      +7.5%       0.01 ± 30%  perf-sched.sch_delay.avg.ms.do_syslog.part.0.kmsg_read.vfs_read
      0.01 ± 24%   +5694.8%       0.34 ±325%     -28.3%       0.00 ±  9%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.01 ± 60%     +17.4%       0.01 ± 55%     -47.8%       0.00        perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.00 ±282%    -100.0%       0.00          +250.0%       0.00 ±282%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.00          +1e+99%       0.00 ±212%  +5.6e+98%       0.00 ±191%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.00 ± 35%      +3.1%       0.00 ± 91%     -25.0%       0.00 ± 35%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00 ±282%    -100.0%       0.00           +75.0%       0.00 ±282%  perf-sched.sch_delay.avg.ms.futex_wait_queue_me.futex_wait.do_futex.__x64_sys_futex
      0.00        +3.3e+98%       0.00 ±331%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.io_schedule.__lock_page.pagecache_get_page.shmem_getpage_gfp
      0.00 ±282%     +82.1%       0.00 ±169%    +200.0%       0.00 ±170%  perf-sched.sch_delay.avg.ms.io_schedule.__lock_page_killable.filemap_fault.__do_fault
      0.00 ± 52%     +22.4%       0.00 ± 48%     -52.6%       0.00        perf-sched.sch_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.00 ±168%     -51.4%       0.00 ±224%     -73.0%       0.00 ±282%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__flush_work.lru_add_drain_all.khugepaged
      0.00 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.copy_page_to_iter.pipe_read.new_sync_read
      0.00        +2.5e+98%       0.00 ±331%  +3.3e+98%       0.00 ±282%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00 ±282%    +800.0%       0.00 ±316%      +0.0%       0.00 ±282%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.pipe_read.new_sync_read
      0.00 ±282%    +275.0%       0.00 ±234%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.pipe_write.new_sync_write
      0.00        +1.7e+98%       0.00 ±331%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.01 ±111%     +51.3%       0.02 ± 90%     -49.6%       0.01 ± 17%  perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork
      0.00          -100.0%       0.00        +7.8e+98%       0.00 ±282%  perf-sched.sch_delay.avg.ms.rwsem_down_read_slowpath.down_read_killable.__access_remote_vm.proc_pid_cmdline_read
      0.00          -100.0%       0.00          +1e+99%       0.00 ±282%  perf-sched.sch_delay.avg.ms.rwsem_down_read_slowpath.down_read_killable.mm_access.proc_mem_open
      0.01 ± 34%     +19.6%       0.01 ± 36%     -15.1%       0.01 ± 28%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.01 ±101%    +137.9%       0.02 ± 94%     -33.3%       0.01 ± 27%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
      0.01 ± 27%      +4.5%       0.01 ± 33%     -26.2%       0.01 ± 16%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      0.03 ± 62%     -20.1%       0.02 ± 32%     -46.2%       0.02 ± 37%  perf-sched.sch_delay.avg.ms.schedule_timeout.__skb_wait_for_more_packets.unix_dgram_recvmsg.__sys_recvfrom
      0.01 ± 40%      -9.0%       0.01 ± 37%     -32.5%       0.01 ± 21%  perf-sched.sch_delay.avg.ms.schedule_timeout.io_schedule_timeout.wait_for_completion_io_timeout.blk_execute_rq
      0.01 ± 33%     +11.4%       0.01 ± 29%     -32.3%       0.01 ±  6%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.00        +7.2e+99%       0.01 ± 85%  +3.7e+99%       0.00 ±145%  perf-sched.sch_delay.avg.ms.schedule_timeout.khugepaged.kthread.ret_from_fork
      0.02 ± 81%      -0.2%       0.02 ± 79%     -50.0%       0.01 ± 27%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.00 ±208%    +228.1%       0.01 ± 86%     -37.5%       0.00 ±144%  perf-sched.sch_delay.avg.ms.schedule_timeout.transaction_kthread.kthread.ret_from_fork
      0.01 ± 91%     +71.2%       0.02 ± 69%      +0.0%       0.01 ± 37%  perf-sched.sch_delay.avg.ms.schedule_timeout.wait_for_completion.__flush_work.lru_add_drain_all
      0.00 ± 36%      -0.6%       0.00 ± 33%      -7.5%       0.00 ± 35%  perf-sched.sch_delay.avg.ms.schedule_timeout.wait_for_completion_interruptible.usb_stor_control_thread.kthread
      0.01 ± 25%     +27.4%       0.01 ± 70%     -19.4%       0.01 ± 18%  perf-sched.sch_delay.avg.ms.schedule_timeout.wait_for_completion_interruptible_timeout.usb_stor_msg_common.usb_stor_bulk_transfer_buf
      0.01 ± 35%     -10.9%       0.01 ± 13%     -26.6%       0.01 ±  7%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.00 ± 19%      +1.1%       0.00 ± 19%     -17.4%       0.00 ± 14%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
      0.01 ± 11%      +8.2%       0.01 ± 14%     -12.4%       0.01 ±  4%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork
      0.02 ± 32%      +4.7%       0.02 ± 40%     -38.5%       0.01 ± 11%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.00 ±161%    +221.9%       0.01 ±104%     -41.7%       0.00 ±142%  perf-sched.sch_delay.max.ms.cleaner_kthread.kthread.ret_from_fork
      0.00        +1.7e+98%       0.00 ±331%  +3.3e+98%       0.00 ±282%  perf-sched.sch_delay.max.ms.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.part
      0.02 ±129%     -47.5%       0.01 ± 19%     -51.0%       0.01 ±  8%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.02 ± 54%      +1.7%       0.02 ± 32%     -36.2%       0.01 ± 28%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      0.01 ± 21%     -13.1%       0.01 ± 37%      +6.3%       0.01 ± 41%  perf-sched.sch_delay.max.ms.do_syslog.part.0.kmsg_read.vfs_read
      0.04 ± 45%  +1.9e+05%      83.41 ±331%     -49.1%       0.02 ± 26%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.06 ± 91%     +50.4%       0.09 ± 65%     -82.7%       0.01 ± 21%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.00 ±282%    -100.0%       0.00          +250.0%       0.00 ±282%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.00        +1.1e+99%       0.00 ±197%  +6.7e+98%       0.00 ±187%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.01 ± 18%     +71.2%       0.01 ±129%      -5.7%       0.01 ± 38%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00 ±282%    -100.0%       0.00           +83.3%       0.00 ±282%  perf-sched.sch_delay.max.ms.futex_wait_queue_me.futex_wait.do_futex.__x64_sys_futex
      0.00        +3.3e+98%       0.00 ±331%    -100.0%       0.00        perf-sched.sch_delay.max.ms.io_schedule.__lock_page.pagecache_get_page.shmem_getpage_gfp
      0.00 ±282%     +82.1%       0.00 ±169%    +200.0%       0.00 ±170%  perf-sched.sch_delay.max.ms.io_schedule.__lock_page_killable.filemap_fault.__do_fault
      0.09 ± 76%     +23.3%       0.11 ± 60%     -77.4%       0.02 ± 31%  perf-sched.sch_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.00 ±168%     -51.4%       0.00 ±224%     -73.0%       0.00 ±282%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__flush_work.lru_add_drain_all.khugepaged
      0.00 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.copy_page_to_iter.pipe_read.new_sync_read
      0.00        +2.5e+98%       0.00 ±331%  +3.3e+98%       0.00 ±282%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00 ±282%    +512.5%       0.00 ±310%     -33.3%       0.00 ±282%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.pipe_read.new_sync_read
      0.00 ±282%     +50.0%       0.00 ±204%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.pipe_write.new_sync_write
      0.00        +1.7e+98%       0.00 ±331%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.03 ± 66%      +5.3%       0.03 ± 72%     -53.1%       0.01 ±  7%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      0.04 ±106%   +1724.8%       0.71 ±308%     -64.7%       0.01 ± 31%  perf-sched.sch_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork
      0.00          -100.0%       0.00        +7.8e+98%       0.00 ±282%  perf-sched.sch_delay.max.ms.rwsem_down_read_slowpath.down_read_killable.__access_remote_vm.proc_pid_cmdline_read
      0.00          -100.0%       0.00          +1e+99%       0.00 ±282%  perf-sched.sch_delay.max.ms.rwsem_down_read_slowpath.down_read_killable.mm_access.proc_mem_open
      0.03 ± 64%     +52.1%       0.05 ± 73%     -39.5%       0.02 ± 22%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.02 ±122%    +164.8%       0.05 ± 95%     -25.6%       0.01 ± 64%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
      0.02 ± 32%     +56.4%       0.04 ± 60%     -16.3%       0.02 ± 29%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      0.03 ± 62%     -20.1%       0.02 ± 32%     -46.2%       0.02 ± 37%  perf-sched.sch_delay.max.ms.schedule_timeout.__skb_wait_for_more_packets.unix_dgram_recvmsg.__sys_recvfrom
      0.02 ± 23%     +25.0%       0.02 ± 32%     -12.7%       0.02 ± 40%  perf-sched.sch_delay.max.ms.schedule_timeout.io_schedule_timeout.wait_for_completion_io_timeout.blk_execute_rq
      0.02 ± 46%      +9.2%       0.02 ± 35%     -27.5%       0.02 ± 23%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.00        +7.2e+99%       0.01 ± 85%  +3.7e+99%       0.00 ±145%  perf-sched.sch_delay.max.ms.schedule_timeout.khugepaged.kthread.ret_from_fork
      1.37 ±190%     -93.8%       0.09 ± 62%     -58.2%       0.57 ±273%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.00 ±208%    +228.1%       0.01 ± 86%     -37.5%       0.00 ±144%  perf-sched.sch_delay.max.ms.schedule_timeout.transaction_kthread.kthread.ret_from_fork
      0.01 ± 86%     +66.9%       0.02 ± 63%      -9.8%       0.01 ± 37%  perf-sched.sch_delay.max.ms.schedule_timeout.wait_for_completion.__flush_work.lru_add_drain_all
      0.01 ± 28%     +11.9%       0.01 ± 18%     -13.4%       0.01 ± 22%  perf-sched.sch_delay.max.ms.schedule_timeout.wait_for_completion_interruptible.usb_stor_control_thread.kthread
      0.02 ± 43%     +39.0%       0.03 ± 76%     -34.3%       0.01 ± 14%  perf-sched.sch_delay.max.ms.schedule_timeout.wait_for_completion_interruptible_timeout.usb_stor_msg_common.usb_stor_bulk_transfer_buf
      1.26 ±274%     -97.3%       0.03 ± 21%     -97.6%       0.03 ± 10%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.01 ± 46%     +54.7%       0.02 ± 88%     -51.0%       0.01 ± 48%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
      3.19            +0.2%       3.19            +0.6%       3.21        perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork
      0.01 ± 44%    +226.9%       0.02 ±215%     -32.1%       0.00 ± 11%  perf-sched.total_sch_delay.average.ms
      4.66 ± 57%   +1759.5%      86.69 ±317%     -27.0%       3.40 ± 16%  perf-sched.total_sch_delay.max.ms
    204.07 ±  6%      +0.8%     205.63 ±  8%      -1.6%     200.85 ± 10%  perf-sched.total_wait_and_delay.average.ms
      7199 ±  7%      -0.4%       7167 ±  9%      +2.2%       7355 ± 11%  perf-sched.total_wait_and_delay.count.ms
      9988            +0.0%       9992            -0.4%       9945        perf-sched.total_wait_and_delay.max.ms
    204.07 ±  6%      +0.8%     205.61 ±  8%      -1.6%     200.85 ± 10%  perf-sched.total_wait_time.average.ms
      9988            +0.0%       9992            -0.4%       9945        perf-sched.total_wait_time.max.ms
    899.74            -0.0%     899.72            -0.0%     899.71        perf-sched.wait_and_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    682.12 ±  4%      -0.3%     680.00 ±  3%      -0.8%     676.62 ±  4%  perf-sched.wait_and_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
    272.57 ±  3%      +1.5%     276.71 ±  3%      +1.2%     275.98 ±  3%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      4.63 ±  3%      +1.1%       4.68 ±  3%      -2.7%       4.50        perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
     62.06            -0.3%      61.89            -1.2%      61.34        perf-sched.wait_and_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
     17.16 ± 17%      +5.3%      18.07            -7.1%      15.94 ± 24%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      3.50 ± 36%      +6.8%       3.74 ±  8%      -0.4%       3.49 ± 36%  perf-sched.wait_and_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork
      0.00          -100.0%       0.00       +6.3e+104%     634.38 ±282%  perf-sched.wait_and_delay.avg.ms.rwsem_down_read_slowpath.down_read_killable.__access_remote_vm.proc_pid_cmdline_read
    307.19 ± 57%     -18.0%     251.87 ± 73%     -11.1%     272.95 ± 54%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
    950.15            -0.2%     948.36            -0.3%     947.48        perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
    431.49 ± 29%      -8.9%     393.21            +8.0%     466.20 ± 30%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      1428 ± 20%     -14.7%       1218 ± 42%      -2.9%       1386 ± 21%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.io_schedule_timeout.wait_for_completion_io_timeout.blk_execute_rq
    478.66            -0.1%     478.15            +0.0%     478.80        perf-sched.wait_and_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
     12.17 ± 43%     +10.5%      13.44 ± 38%      +6.9%      13.01 ± 46%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
    829.27 ±  3%      -1.2%     819.18            -1.2%     819.16        perf-sched.wait_and_delay.avg.ms.schedule_timeout.wait_for_completion_interruptible_timeout.usb_stor_msg_common.usb_stor_bulk_transfer_buf
    747.87            +0.4%     751.10            -1.3%     737.79        perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.00 ± 19%      +1.1%       0.00 ± 19%     -17.4%       0.00 ± 14%  perf-sched.wait_and_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
    368.31 ±  4%      -1.0%     364.47 ±  4%      +1.6%     374.25 ±  3%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork
     10.00            +0.0%      10.00            +0.0%      10.00        perf-sched.wait_and_delay.count.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     13.22 ±  4%      +0.2%      13.25 ±  3%      +0.8%      13.33 ±  5%  perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
    254.56            -0.4%     253.42            +0.1%     254.89        perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    246.44 ±  3%      -0.8%     244.58 ±  2%      +2.6%     252.89        perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      2501            +0.2%       2507            +1.5%       2538        perf-sched.wait_and_delay.count.pipe_read.new_sync_read.vfs_read.ksys_read
      1045 ±  2%      +0.2%       1048 ±  2%      +1.0%       1056        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
    156.89 ± 69%     +56.4%     245.33 ± 84%     +30.5%     204.78 ± 88%  perf-sched.wait_and_delay.count.rcu_gp_kthread.kthread.ret_from_fork
      0.00          -100.0%       0.00       +1.1e+101%       0.11 ±282%  perf-sched.wait_and_delay.count.rwsem_down_read_slowpath.down_read_killable.__access_remote_vm.proc_pid_cmdline_read
     20.00 ± 67%     -22.5%      15.50 ± 86%      -2.2%      19.56 ± 64%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      6.00            +0.0%       6.00            +0.0%       6.00        perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
     23.44 ±  5%      -2.3%      22.92            +0.9%      23.67 ±  6%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
     10.00            +0.0%      10.00            +0.0%      10.00        perf-sched.wait_and_delay.count.schedule_timeout.io_schedule_timeout.wait_for_completion_io_timeout.blk_execute_rq
     39.78            -2.0%      39.00 ±  2%      +0.6%      40.00        perf-sched.wait_and_delay.count.schedule_timeout.kcompactd.kthread.ret_from_fork
    986.56 ± 57%     -12.7%     861.25 ± 59%      +4.4%       1030 ± 72%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      9.89 ±  3%      +1.1%      10.00            +1.1%      10.00        perf-sched.wait_and_delay.count.schedule_timeout.wait_for_completion_interruptible_timeout.usb_stor_msg_common.usb_stor_bulk_transfer_buf
      1241 ±  2%      +0.2%       1244 ±  2%      +0.8%       1251        perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork
     71.56            -0.2%      71.42            +0.2%      71.67        perf-sched.wait_and_delay.count.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
    533.44 ±  3%      +0.1%     534.17 ±  2%      -0.1%     532.78 ±  2%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork
    999.83            +0.0%     999.84            -0.0%     999.81        perf-sched.wait_and_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1000            +0.0%       1000            -0.0%       1000        perf-sched.wait_and_delay.max.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      2750 ± 55%      +7.2%       2948 ± 60%     +24.4%       3420 ± 51%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      1000            +0.0%       1000            -0.0%       1000        perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      3004            +0.0%       3004            -0.0%       3003        perf-sched.wait_and_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      8994 ± 31%     +11.1%       9992           -11.1%       7995 ± 46%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      4.49 ± 35%     +18.2%       5.31 ± 15%      -0.9%       4.45 ± 35%  perf-sched.wait_and_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork
      0.00          -100.0%       0.00       +6.3e+104%     634.38 ±282%  perf-sched.wait_and_delay.max.ms.rwsem_down_read_slowpath.down_read_killable.__access_remote_vm.proc_pid_cmdline_read
      2091 ±124%     -33.3%       1395 ±139%     -37.6%       1305 ±133%  perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      5700            -0.2%       5690            -0.3%       5684        perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
      1994 ±140%     -49.8%       1001           +47.9%       2950 ±123%  perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      2047            -5.5%       1935 ± 14%      +0.0%       2047        perf-sched.wait_and_delay.max.ms.schedule_timeout.io_schedule_timeout.wait_for_completion_io_timeout.blk_execute_rq
    505.02            +0.0%     505.03            -0.0%     505.01        perf-sched.wait_and_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
    304.90 ± 44%      -9.6%     275.59 ± 51%      +0.0%     305.00 ± 52%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      2048            +0.0%       2048            +0.0%       2048        perf-sched.wait_and_delay.max.ms.schedule_timeout.wait_for_completion_interruptible_timeout.usb_stor_msg_common.usb_stor_bulk_transfer_buf
      1585 ± 32%      +1.9%       1615 ± 31%      -7.3%       1469 ± 35%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.01 ± 46%     +56.2%       0.02 ± 86%     -51.0%       0.01 ± 48%  perf-sched.wait_and_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
      5388 ± 31%     -16.1%       4522 ± 36%     -11.8%       4751 ± 29%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork
    899.73            -0.0%     899.71            -0.0%     899.70        perf-sched.wait_time.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1.57 ± 10%      +6.1%       1.67 ±  8%      +1.6%       1.60 ± 11%  perf-sched.wait_time.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
    682.11 ±  4%      -0.3%     679.99 ±  3%      -0.8%     676.62 ±  4%  perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      1.59 ± 10%      +5.7%       1.68 ±  8%      +1.0%       1.60 ± 11%  perf-sched.wait_time.avg.ms.do_syslog.part.0.kmsg_read.vfs_read
    272.57 ±  3%      +1.4%     276.37 ±  3%      +1.2%     275.97 ±  3%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      4.62 ±  3%      +1.1%       4.67 ±  3%      -2.6%       4.50        perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.01 ±106%     -60.5%       0.00 ±223%     -21.1%       0.01 ±113%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.01 ± 21%     +11.4%       0.01 ± 28%     +12.9%       0.01 ± 23%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.04 ±282%    -100.0%       0.00           -14.8%       0.03 ±282%  perf-sched.wait_time.avg.ms.futex_wait_queue_me.futex_wait.do_futex.__x64_sys_futex
     62.06            -0.3%      61.88            -1.2%      61.33        perf-sched.wait_time.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.01 ±149%      +5.9%       0.01 ±133%     -39.7%       0.00 ±174%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.copy_page_from_iter.pipe_write.new_sync_write
      0.01 ± 87%     -56.4%       0.01 ±160%     -60.9%       0.00 ±179%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.copy_page_to_iter.pipe_read.new_sync_read
      0.01 ± 70%     -27.3%       0.01 ± 73%     -60.8%       0.01 ±141%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.pipe_read.new_sync_read
      0.02 ± 61%     -16.4%       0.01 ± 88%     +21.6%       0.02 ± 40%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.pipe_write.new_sync_write
     17.15 ± 17%      +5.3%      18.07            -7.1%      15.94 ± 24%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      3.49 ± 36%      +6.7%       3.72 ±  8%     +10.8%       3.86 ±  7%  perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork
      0.00          -100.0%       0.00       +6.3e+104%     634.38 ±282%  perf-sched.wait_time.avg.ms.rwsem_down_read_slowpath.down_read_killable.__access_remote_vm.proc_pid_cmdline_read
      0.00          -100.0%       0.00       +1.2e+100%       0.01 ±282%  perf-sched.wait_time.avg.ms.rwsem_down_read_slowpath.down_read_killable.mm_access.proc_mem_open
    314.20 ± 52%     -15.5%     265.53 ± 63%      -9.8%     283.48 ± 45%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
    950.14            -0.2%     948.34            -0.3%     947.47        perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
    431.49 ± 29%      -8.9%     393.20            +8.0%     466.20 ± 30%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      5.50 ± 61%     -23.1%       4.23 ±107%      +4.9%       5.77 ± 96%  perf-sched.wait_time.avg.ms.schedule_timeout.__skb_wait_for_more_packets.unix_dgram_recvmsg.__sys_recvfrom
      1428 ± 20%     -14.7%       1218 ± 42%      -2.9%       1386 ± 21%  perf-sched.wait_time.avg.ms.schedule_timeout.io_schedule_timeout.wait_for_completion_io_timeout.blk_execute_rq
    478.65            -0.1%     478.14            +0.0%     478.80        perf-sched.wait_time.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.01 ± 33%     +20.3%       0.01 ± 63%      +6.3%       0.01 ± 60%  perf-sched.wait_time.avg.ms.schedule_timeout.khugepaged.kthread.ret_from_fork
     12.15 ± 43%     +10.5%      13.43 ± 38%      +7.0%      13.00 ± 46%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.00 ±188%     +41.7%       0.00 ±192%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.wait_for_completion.__flush_work.lru_add_drain_all
      0.00 ±191%     +88.6%       0.01 ±141%     -31.4%       0.00 ±206%  perf-sched.wait_time.avg.ms.schedule_timeout.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      0.08 ± 18%      +2.2%       0.09 ±  7%      +7.5%       0.09 ±  2%  perf-sched.wait_time.avg.ms.schedule_timeout.wait_for_completion_interruptible.usb_stor_control_thread.kthread
    829.26 ±  3%      -1.2%     819.17            -1.2%     819.15        perf-sched.wait_time.avg.ms.schedule_timeout.wait_for_completion_interruptible_timeout.usb_stor_msg_common.usb_stor_bulk_transfer_buf
    747.87            +0.4%     751.09            -1.3%     737.78        perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
    368.29 ±  4%      -1.0%     364.46 ±  4%      +1.6%     374.24 ±  3%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork
    999.81            +0.0%     999.82            -0.0%     999.80        perf-sched.wait_time.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      3.14 ± 10%      +6.1%       3.33 ±  8%      +1.6%       3.19 ± 11%  perf-sched.wait_time.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      1000            +0.0%       1000            -0.0%       1000        perf-sched.wait_time.max.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      3.17 ± 10%      +5.7%       3.35 ±  8%      +1.0%       3.21 ± 11%  perf-sched.wait_time.max.ms.do_syslog.part.0.kmsg_read.vfs_read
      2750 ± 55%      +7.2%       2948 ± 60%     +24.4%       3420 ± 51%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      1000            +0.0%       1000            -0.0%       1000        perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.01 ± 98%     -62.5%       0.00 ±201%     -25.0%       0.01 ±112%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.03 ± 16%      -2.1%       0.03 ± 12%      -8.7%       0.03 ±  3%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.13 ±282%    -100.0%       0.00           -25.1%       0.10 ±282%  perf-sched.wait_time.max.ms.futex_wait_queue_me.futex_wait.do_futex.__x64_sys_futex
      3004            +0.0%       3004            -0.0%       3003        perf-sched.wait_time.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.01 ±141%      -0.0%       0.01 ±129%     -49.4%       0.00 ±174%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.copy_page_from_iter.pipe_write.new_sync_write
      0.01 ± 84%     -44.1%       0.01 ±160%     -57.4%       0.01 ±178%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.copy_page_to_iter.pipe_read.new_sync_read
      0.02 ± 63%     -11.2%       0.02 ± 72%     -49.1%       0.01 ±122%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.pipe_read.new_sync_read
      0.02 ± 54%     -30.1%       0.01 ± 83%      +8.4%       0.02 ± 37%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.pipe_write.new_sync_write
      8994 ± 31%     +11.1%       9992           -11.1%       7995 ± 46%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      4.48 ± 35%     +12.6%       5.04            +9.2%       4.89 ±  6%  perf-sched.wait_time.max.ms.rcu_gp_kthread.kthread.ret_from_fork
      0.00          -100.0%       0.00       +6.3e+104%     634.38 ±282%  perf-sched.wait_time.max.ms.rwsem_down_read_slowpath.down_read_killable.__access_remote_vm.proc_pid_cmdline_read
      0.00          -100.0%       0.00       +1.2e+100%       0.01 ±282%  perf-sched.wait_time.max.ms.rwsem_down_read_slowpath.down_read_killable.mm_access.proc_mem_open
      2156 ±118%     -29.2%       1525 ±121%     -34.9%       1403 ±119%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      5700            -0.2%       5690            -0.3%       5684        perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
      1994 ±140%     -49.8%       1001           +47.9%       2950 ±123%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      5.50 ± 61%     -23.1%       4.23 ±107%      +4.9%       5.77 ± 96%  perf-sched.wait_time.max.ms.schedule_timeout.__skb_wait_for_more_packets.unix_dgram_recvmsg.__sys_recvfrom
      2047            -5.5%       1935 ± 14%      +0.0%       2047        perf-sched.wait_time.max.ms.schedule_timeout.io_schedule_timeout.wait_for_completion_io_timeout.blk_execute_rq
    505.01            +0.0%     505.01            -0.0%     505.00        perf-sched.wait_time.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.01 ± 33%     +20.3%       0.01 ± 63%      +6.3%       0.01 ± 60%  perf-sched.wait_time.max.ms.schedule_timeout.khugepaged.kthread.ret_from_fork
    304.86 ± 44%      -9.6%     275.56 ± 51%      +0.0%     304.99 ± 52%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.00 ±204%     +32.7%       0.00 ±186%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.wait_for_completion.__flush_work.lru_add_drain_all
      0.00 ±191%     +88.6%       0.01 ±141%     -31.4%       0.00 ±206%  perf-sched.wait_time.max.ms.schedule_timeout.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      0.10 ±  6%      -3.1%       0.09 ±  5%      -1.4%       0.10 ±  4%  perf-sched.wait_time.max.ms.schedule_timeout.wait_for_completion_interruptible.usb_stor_control_thread.kthread
      2048            +0.0%       2048            +0.0%       2048        perf-sched.wait_time.max.ms.schedule_timeout.wait_for_completion_interruptible_timeout.usb_stor_msg_common.usb_stor_bulk_transfer_buf
      1585 ± 32%      +1.9%       1615 ± 31%      -7.3%       1469 ± 35%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.00        +4.2e+98%       0.00 ±331%    -100.0%       0.00        perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
      5388 ± 31%     -16.1%       4522 ± 36%     -11.8%       4751 ± 29%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork
    190513            -0.0%     190442            -0.0%     190445        slabinfo.Acpi-Operand.active_objs
      3401            -0.0%       3400            -0.0%       3400        slabinfo.Acpi-Operand.active_slabs
    190523            -0.0%     190457            -0.0%     190457        slabinfo.Acpi-Operand.num_objs
      3401            -0.0%       3400            -0.0%       3400        slabinfo.Acpi-Operand.num_slabs
      1403 ± 11%      -0.3%       1399 ±  8%      -7.5%       1297 ±  8%  slabinfo.Acpi-Parse.active_objs
     19.22 ± 11%      -0.3%      19.17 ±  8%      -7.5%      17.78 ±  8%  slabinfo.Acpi-Parse.active_slabs
      1403 ± 11%      -0.3%       1399 ±  8%      -7.5%       1297 ±  8%  slabinfo.Acpi-Parse.num_objs
     19.22 ± 11%      -0.3%      19.17 ±  8%      -7.5%      17.78 ±  8%  slabinfo.Acpi-Parse.num_slabs
      4840 ±  4%      -3.2%       4686 ±  3%      +0.1%       4846 ±  3%  slabinfo.Acpi-State.active_objs
     94.56 ±  4%      -3.6%      91.17 ±  3%      -0.1%      94.44 ±  2%  slabinfo.Acpi-State.active_slabs
      4840 ±  4%      -3.2%       4686 ±  3%      +0.1%       4846 ±  3%  slabinfo.Acpi-State.num_objs
     94.56 ±  4%      -3.6%      91.17 ±  3%      -0.1%      94.44 ±  2%  slabinfo.Acpi-State.num_slabs
    202.67 ±  7%      -3.9%     194.67 ±  4%      -5.3%     192.00        slabinfo.RAW.active_objs
      6.33 ±  7%      -3.9%       6.08 ±  4%      -5.3%       6.00        slabinfo.RAW.active_slabs
    202.67 ±  7%      -3.9%     194.67 ±  4%      -5.3%     192.00        slabinfo.RAW.num_objs
      6.33 ±  7%      -3.9%       6.08 ±  4%      -5.3%       6.00        slabinfo.RAW.num_slabs
    104.00            +0.0%     104.00            +0.0%     104.00        slabinfo.RAWv6.active_objs
      4.00            +0.0%       4.00            +0.0%       4.00        slabinfo.RAWv6.active_slabs
    104.00            +0.0%     104.00            +0.0%     104.00        slabinfo.RAWv6.num_objs
      4.00            +0.0%       4.00            +0.0%       4.00        slabinfo.RAWv6.num_slabs
     56.00            -4.2%      53.67 ±  9%      +0.0%      56.00        slabinfo.TCP.active_objs
      4.00            -4.2%       3.83 ±  9%      +0.0%       4.00        slabinfo.TCP.active_slabs
     56.00            -4.2%      53.67 ±  9%      +0.0%      56.00        slabinfo.TCP.num_objs
      4.00            -4.2%       3.83 ±  9%      +0.0%       4.00        slabinfo.TCP.num_slabs
     39.00            -2.8%      37.92 ±  9%      +0.0%      39.00        slabinfo.TCPv6.active_objs
      3.00            -2.8%       2.92 ±  9%      +0.0%       3.00        slabinfo.TCPv6.active_slabs
     39.00            -2.8%      37.92 ±  9%      +0.0%      39.00        slabinfo.TCPv6.num_objs
      3.00            -2.8%       2.92 ±  9%      +0.0%       3.00        slabinfo.TCPv6.num_slabs
    162.11 ±  8%      +1.7%     164.83 ±  8%      -1.8%     159.22 ± 10%  slabinfo.UDPv6.active_objs
      6.22 ± 10%      +1.8%       6.33 ±  9%      -1.8%       6.11 ± 12%  slabinfo.UDPv6.active_slabs
    162.11 ±  8%      +1.7%     164.83 ±  8%      -1.8%     159.22 ± 10%  slabinfo.UDPv6.num_objs
      6.22 ± 10%      +1.8%       6.33 ±  9%      -1.8%       6.11 ± 12%  slabinfo.UDPv6.num_slabs
      1838 ± 15%      -1.3%       1815 ± 16%      +6.4%       1955 ± 12%  slabinfo.UNIX.active_objs
     60.89 ± 15%      -1.5%      60.00 ± 16%      +6.2%      64.67 ± 12%  slabinfo.UNIX.active_slabs
      1838 ± 15%      -1.3%       1815 ± 16%      +6.4%       1955 ± 12%  slabinfo.UNIX.num_objs
     60.89 ± 15%      -1.5%      60.00 ± 16%      +6.2%      64.67 ± 12%  slabinfo.UNIX.num_slabs
     25542 ±  4%      +2.5%      26173 ±  3%      +2.5%      26173 ±  4%  slabinfo.anon_vma.active_objs
    554.67 ±  4%      +2.5%     568.58 ±  3%      +2.5%     568.44 ±  4%  slabinfo.anon_vma.active_slabs
     25542 ±  4%      +2.5%      26190 ±  3%      +2.5%      26173 ±  4%  slabinfo.anon_vma.num_objs
    554.67 ±  4%      +2.5%     568.58 ±  3%      +2.5%     568.44 ±  4%  slabinfo.anon_vma.num_slabs
     60511 ± 10%      -1.1%      59846 ±  7%      +2.7%      62150 ±  7%  slabinfo.anon_vma_chain.active_objs
    947.78 ± 10%      -1.0%     938.00 ±  7%      +2.7%     973.67 ±  7%  slabinfo.anon_vma_chain.active_slabs
     60690 ± 10%      -1.0%      60066 ±  7%      +2.7%      62344 ±  7%  slabinfo.anon_vma_chain.num_objs
    947.78 ± 10%      -1.0%     938.00 ±  7%      +2.7%     973.67 ±  7%  slabinfo.anon_vma_chain.num_slabs
    231.00 ± 16%      -2.3%     225.75 ± 13%      -2.0%     226.33 ± 16%  slabinfo.bdev_cache.active_objs
     11.00 ± 16%      -2.3%      10.75 ± 13%      -2.0%      10.78 ± 16%  slabinfo.bdev_cache.active_slabs
    231.00 ± 16%      -2.3%     225.75 ± 13%      -2.0%     226.33 ± 16%  slabinfo.bdev_cache.num_objs
     11.00 ± 16%      -2.3%      10.75 ± 13%      -2.0%      10.78 ± 16%  slabinfo.bdev_cache.num_slabs
    105.33 ± 27%     -16.5%      88.00 ± 30%     -14.6%      90.00 ± 28%  slabinfo.biovec-128.active_objs
      6.22 ± 24%     -11.6%       5.50 ± 30%     -10.7%       5.56 ± 26%  slabinfo.biovec-128.active_slabs
    105.33 ± 27%     -16.5%      88.00 ± 30%     -14.6%      90.00 ± 28%  slabinfo.biovec-128.num_objs
      6.22 ± 24%     -11.6%       5.50 ± 30%     -10.7%       5.56 ± 26%  slabinfo.biovec-128.num_slabs
    304.89 ± 12%      +1.5%     309.33 ± 15%      +8.1%     329.67 ± 10%  slabinfo.biovec-64.active_objs
      9.33 ± 11%      +3.6%       9.67 ± 15%      +9.5%      10.22 ± 10%  slabinfo.biovec-64.active_slabs
    304.89 ± 12%      +1.5%     309.33 ± 15%      +8.1%     329.67 ± 10%  slabinfo.biovec-64.num_objs
      9.33 ± 11%      +3.6%       9.67 ± 15%      +9.5%      10.22 ± 10%  slabinfo.biovec-64.num_slabs
     97.78 ± 17%     -19.5%      78.67 ±  5%     -17.8%      80.33 ± 15%  slabinfo.biovec-max.active_objs
     12.00 ± 16%     -18.1%       9.83 ±  5%     -16.7%      10.00 ± 14%  slabinfo.biovec-max.active_slabs
     97.78 ± 17%     -19.5%      78.67 ±  5%     -17.8%      80.33 ± 15%  slabinfo.biovec-max.num_objs
     12.00 ± 16%     -18.1%       9.83 ±  5%     -16.7%      10.00 ± 14%  slabinfo.biovec-max.num_slabs
     49.89 ± 92%    -100.0%       0.00           -77.1%      11.44 ±282%  slabinfo.btrfs_delayed_tree_ref.active_objs
      0.89 ± 98%    -100.0%       0.00           -75.0%       0.22 ±282%  slabinfo.btrfs_delayed_tree_ref.active_slabs
     49.89 ± 92%    -100.0%       0.00           -77.1%      11.44 ±282%  slabinfo.btrfs_delayed_tree_ref.num_objs
      0.89 ± 98%    -100.0%       0.00           -75.0%       0.22 ±282%  slabinfo.btrfs_delayed_tree_ref.num_slabs
    167.44 ± 59%     -66.6%      56.00           -53.3%      78.22 ± 80%  slabinfo.btrfs_extent_map.active_objs
      2.67 ± 55%     -62.5%       1.00           -50.0%       1.33 ± 70%  slabinfo.btrfs_extent_map.active_slabs
    167.44 ± 59%     -66.6%      56.00           -53.3%      78.22 ± 80%  slabinfo.btrfs_extent_map.num_objs
      2.67 ± 55%     -62.5%       1.00           -50.0%       1.33 ± 70%  slabinfo.btrfs_extent_map.num_slabs
    145.89 ± 21%     -23.2%     112.00           -23.6%     111.44 ± 19%  slabinfo.btrfs_inode.active_objs
      4.78 ± 16%     -16.3%       4.00           -18.6%       3.89 ± 14%  slabinfo.btrfs_inode.active_slabs
    145.89 ± 21%     -23.2%     112.00           -23.6%     111.44 ± 19%  slabinfo.btrfs_inode.num_objs
      4.78 ± 16%     -16.3%       4.00           -18.6%       3.89 ± 14%  slabinfo.btrfs_inode.num_slabs
     29.22 ± 97%    -100.0%       0.00           -75.3%       7.22 ±282%  slabinfo.btrfs_ordered_extent.active_objs
      0.33 ±141%    -100.0%       0.00           -66.7%       0.11 ±282%  slabinfo.btrfs_ordered_extent.active_slabs
     29.22 ± 97%    -100.0%       0.00           -75.3%       7.22 ±282%  slabinfo.btrfs_ordered_extent.num_objs
      0.33 ±141%    -100.0%       0.00           -66.7%       0.11 ±282%  slabinfo.btrfs_ordered_extent.num_slabs
    517.22 ± 13%     -25.9%     383.33 ± 14%      -3.7%     498.22 ± 13%  slabinfo.buffer_head.active_objs
     12.78 ± 14%     -26.3%       9.42 ± 15%      -4.3%      12.22 ± 15%  slabinfo.buffer_head.active_slabs
    517.22 ± 13%     -25.9%     383.33 ± 14%      -3.7%     498.22 ± 13%  slabinfo.buffer_head.num_objs
     12.78 ± 14%     -26.3%       9.42 ± 15%      -4.3%      12.22 ± 15%  slabinfo.buffer_head.num_slabs
      6567 ±  3%      +2.9%       6761 ±  5%      -0.7%       6519 ±  3%  slabinfo.cred_jar.active_objs
    155.44 ±  3%      +3.0%     160.08 ±  5%      -0.6%     154.56 ±  3%  slabinfo.cred_jar.active_slabs
      6567 ±  3%      +2.9%       6761 ±  5%      -0.7%       6519 ±  3%  slabinfo.cred_jar.num_objs
    155.44 ±  3%      +3.0%     160.08 ±  5%      -0.6%     154.56 ±  3%  slabinfo.cred_jar.num_slabs
     42.00            +0.0%      42.00            +0.0%      42.00        slabinfo.dax_cache.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.dax_cache.active_slabs
     42.00            +0.0%      42.00            +0.0%      42.00        slabinfo.dax_cache.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.dax_cache.num_slabs
    129308 ±  2%      -0.5%     128608 ±  2%      +0.5%     129967 ±  3%  slabinfo.dentry.active_objs
      3115 ±  2%      -0.5%       3098 ±  3%      +0.7%       3137 ±  2%  slabinfo.dentry.active_slabs
    130891 ±  2%      -0.5%     130174 ±  3%      +0.7%     131776 ±  2%  slabinfo.dentry.num_objs
      3115 ±  2%      -0.5%       3098 ±  3%      +0.7%       3137 ±  2%  slabinfo.dentry.num_slabs
     32.00            +0.0%      32.00            +0.0%      32.00        slabinfo.dma-kmalloc-512.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.dma-kmalloc-512.active_slabs
     32.00            +0.0%      32.00            +0.0%      32.00        slabinfo.dma-kmalloc-512.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.dma-kmalloc-512.num_slabs
     30.00            +0.0%      30.00            +0.0%      30.00        slabinfo.dmaengine-unmap-128.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-128.active_slabs
     30.00            +0.0%      30.00            +0.0%      30.00        slabinfo.dmaengine-unmap-128.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-128.num_slabs
      1784 ± 11%     +12.8%       2012 ± 11%      -6.7%       1664 ± 14%  slabinfo.dmaengine-unmap-16.active_objs
     42.11 ± 11%     +12.6%      47.42 ± 12%      -6.9%      39.22 ± 14%  slabinfo.dmaengine-unmap-16.active_slabs
      1784 ± 11%     +12.8%       2012 ± 11%      -6.7%       1664 ± 14%  slabinfo.dmaengine-unmap-16.num_objs
     42.11 ± 11%     +12.6%      47.42 ± 12%      -6.9%      39.22 ± 14%  slabinfo.dmaengine-unmap-16.num_slabs
     15.00            +0.0%      15.00            +0.0%      15.00        slabinfo.dmaengine-unmap-256.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-256.active_slabs
     15.00            +0.0%      15.00            +0.0%      15.00        slabinfo.dmaengine-unmap-256.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-256.num_slabs
     20864 ± 11%      +1.5%      21184 ±  9%      -2.5%      20343 ± 16%  slabinfo.ep_head.active_objs
     81.33 ± 11%      +1.6%      82.67 ±  9%      -2.3%      79.44 ± 16%  slabinfo.ep_head.active_slabs
     20864 ± 11%      +1.5%      21184 ±  9%      -2.5%      20343 ± 16%  slabinfo.ep_head.num_objs
     81.33 ± 11%      +1.6%      82.67 ±  9%      -2.3%      79.44 ± 16%  slabinfo.ep_head.num_slabs
      1070 ±  8%      +6.5%       1141 ±  6%      +3.0%       1103 ±  8%  slabinfo.file_lock_cache.active_objs
     28.44 ±  8%      +6.6%      30.33 ±  6%      +3.1%      29.33 ±  9%  slabinfo.file_lock_cache.active_slabs
      1070 ±  8%      +6.5%       1141 ±  6%      +3.0%       1103 ±  8%  slabinfo.file_lock_cache.num_objs
     28.44 ±  8%      +6.6%      30.33 ±  6%      +3.1%      29.33 ±  9%  slabinfo.file_lock_cache.num_slabs
      4040 ±  5%      -1.8%       3965 ±  5%      -0.7%       4011 ±  4%  slabinfo.files_cache.active_objs
     87.11 ±  5%      -1.8%      85.50 ±  6%      -0.5%      86.67 ±  4%  slabinfo.files_cache.active_slabs
      4040 ±  5%      -1.8%       3965 ±  5%      -0.7%       4011 ±  4%  slabinfo.files_cache.num_objs
     87.11 ±  5%      -1.8%      85.50 ±  6%      -0.5%      86.67 ±  4%  slabinfo.files_cache.num_slabs
     27299 ±  3%      +0.8%      27509 ±  5%      +1.2%      27628 ±  5%  slabinfo.filp.active_objs
    874.11 ±  3%      +1.6%     888.33 ±  6%      +1.4%     886.11 ±  4%  slabinfo.filp.active_slabs
     27988 ±  3%      +1.6%      28442 ±  6%      +1.4%      28372 ±  4%  slabinfo.filp.num_objs
    874.11 ±  3%      +1.6%     888.33 ±  6%      +1.4%     886.11 ±  4%  slabinfo.filp.num_slabs
      3029 ± 14%      -1.3%       2990 ± 13%      -4.1%       2904 ± 14%  slabinfo.fsnotify_mark_connector.active_objs
     23.33 ± 15%      -2.1%      22.83 ± 12%      -3.8%      22.44 ± 14%  slabinfo.fsnotify_mark_connector.active_slabs
      3029 ± 14%      -1.3%       2990 ± 13%      -4.1%       2904 ± 14%  slabinfo.fsnotify_mark_connector.num_objs
     23.33 ± 15%      -2.1%      22.83 ± 12%      -3.8%      22.44 ± 14%  slabinfo.fsnotify_mark_connector.num_slabs
     30779            -0.1%      30762            -0.2%      30722        slabinfo.ftrace_event_field.active_objs
    362.11            -0.1%     361.92            -0.2%     361.44        slabinfo.ftrace_event_field.active_slabs
     30779            -0.1%      30762            -0.2%      30722        slabinfo.ftrace_event_field.num_objs
    362.11            -0.1%     361.92            -0.2%     361.44        slabinfo.ftrace_event_field.num_slabs
    106.00            +0.0%     106.00            +0.0%     106.00        slabinfo.hugetlbfs_inode_cache.active_objs
      2.00            +0.0%       2.00            +0.0%       2.00        slabinfo.hugetlbfs_inode_cache.active_slabs
    106.00            +0.0%     106.00            +0.0%     106.00        slabinfo.hugetlbfs_inode_cache.num_objs
      2.00            +0.0%       2.00            +0.0%       2.00        slabinfo.hugetlbfs_inode_cache.num_slabs
     85772            +0.1%      85889            +0.1%      85851        slabinfo.inode_cache.active_objs
      1562            +0.1%       1564            +0.1%       1563        slabinfo.inode_cache.active_slabs
     85947            +0.1%      86055            +0.1%      86029        slabinfo.inode_cache.num_objs
      1562            +0.1%       1564            +0.1%       1563        slabinfo.inode_cache.num_slabs
     85009            -0.1%      84887            -0.2%      84859        slabinfo.kernfs_node_cache.active_objs
      2656            -0.1%       2652            -0.2%       2651        slabinfo.kernfs_node_cache.active_slabs
     85009            -0.1%      84887            -0.2%      84859        slabinfo.kernfs_node_cache.num_objs
      2656            -0.1%       2652            -0.2%       2651        slabinfo.kernfs_node_cache.num_slabs
      1819 ± 14%      -2.2%       1780 ±  8%      -4.6%       1735 ±  9%  slabinfo.khugepaged_mm_slot.active_objs
     49.89 ± 14%      -2.3%      48.75 ±  8%      -5.1%      47.33 ±  9%  slabinfo.khugepaged_mm_slot.active_slabs
      1819 ± 14%      -2.2%       1780 ±  8%      -4.6%       1735 ±  9%  slabinfo.khugepaged_mm_slot.num_objs
     49.89 ± 14%      -2.3%      48.75 ±  8%      -5.1%      47.33 ±  9%  slabinfo.khugepaged_mm_slot.num_slabs
      5340            -1.0%       5289            -1.0%       5289        slabinfo.kmalloc-128.active_objs
    167.56            -0.9%     166.00            -0.9%     166.00        slabinfo.kmalloc-128.active_slabs
      5368            -1.0%       5315            -0.9%       5318        slabinfo.kmalloc-128.num_objs
    167.56            -0.9%     166.00            -0.9%     166.00        slabinfo.kmalloc-128.num_slabs
     35224            -0.0%      35211            -0.4%      35094        slabinfo.kmalloc-16.active_objs
    137.78            +0.0%     137.83            -0.2%     137.44        slabinfo.kmalloc-16.active_slabs
     35271            +0.0%      35285            -0.2%      35185        slabinfo.kmalloc-16.num_objs
    137.78            +0.0%     137.83            -0.2%     137.44        slabinfo.kmalloc-16.num_slabs
      5246            -0.0%       5245            +0.0%       5248        slabinfo.kmalloc-192.active_objs
    127.78            +0.6%     128.50            +0.7%     128.67        slabinfo.kmalloc-192.active_slabs
      5375            +0.4%       5397            +0.5%       5404        slabinfo.kmalloc-192.num_objs
    127.78            +0.6%     128.50            +0.7%     128.67        slabinfo.kmalloc-192.num_slabs
      5297 ±  3%      -1.4%       5220 ±  2%      -1.6%       5212        slabinfo.kmalloc-1k.active_objs
    166.11 ±  2%      -1.3%     163.92 ±  2%      -1.4%     163.78        slabinfo.kmalloc-1k.active_slabs
      5334 ±  3%      -1.4%       5260 ±  2%      -1.6%       5250        slabinfo.kmalloc-1k.num_objs
    166.11 ±  2%      -1.3%     163.92 ±  2%      -1.4%     163.78        slabinfo.kmalloc-1k.num_slabs
      9590 ±  4%      +1.4%       9720 ±  5%      +1.1%       9697 ±  4%  slabinfo.kmalloc-256.active_objs
    299.33 ±  4%      +1.3%     303.33 ±  5%      +1.2%     302.78 ±  4%  slabinfo.kmalloc-256.active_slabs
      9590 ±  4%      +1.4%       9720 ±  5%      +1.1%       9698 ±  4%  slabinfo.kmalloc-256.num_objs
    299.33 ±  4%      +1.3%     303.33 ±  5%      +1.2%     302.78 ±  4%  slabinfo.kmalloc-256.num_slabs
      5215 ±  3%      +2.1%       5325 ±  5%      +3.3%       5387 ±  3%  slabinfo.kmalloc-2k.active_objs
    329.89 ±  3%      +2.3%     337.42 ±  5%      +3.3%     340.78 ±  3%  slabinfo.kmalloc-2k.active_slabs
      5285 ±  3%      +2.3%       5404 ±  5%      +3.3%       5461 ±  3%  slabinfo.kmalloc-2k.num_objs
    329.89 ±  3%      +2.3%     337.42 ±  5%      +3.3%     340.78 ±  3%  slabinfo.kmalloc-2k.num_slabs
     67287            +0.9%      67884            +0.1%      67360        slabinfo.kmalloc-32.active_objs
    526.44            +0.9%     531.08            +0.0%     526.67        slabinfo.kmalloc-32.active_slabs
     67456            +0.9%      68072            +0.1%      67505        slabinfo.kmalloc-32.num_objs
    526.44            +0.9%     531.08            +0.0%     526.67        slabinfo.kmalloc-32.num_slabs
      1906            -0.7%       1893            -0.5%       1897        slabinfo.kmalloc-4k.active_objs
    242.89            -0.7%     241.25            -0.5%     241.67        slabinfo.kmalloc-4k.active_slabs
      1947            -0.6%       1935            -0.4%       1938        slabinfo.kmalloc-4k.num_objs
    242.89            -0.7%     241.25            -0.5%     241.67        slabinfo.kmalloc-4k.num_slabs
     15912 ±  4%      -0.5%      15837 ±  3%      -1.2%      15721 ±  2%  slabinfo.kmalloc-512.active_objs
    499.22 ±  4%      -0.5%     496.92 ±  3%      -1.1%     493.67 ±  2%  slabinfo.kmalloc-512.active_slabs
     15993 ±  4%      -0.5%      15914 ±  3%      -1.1%      15813 ±  2%  slabinfo.kmalloc-512.num_objs
    499.22 ±  4%      -0.5%     496.92 ±  3%      -1.1%     493.67 ±  2%  slabinfo.kmalloc-512.num_slabs
     50201            -0.5%      49952            -0.3%      50039        slabinfo.kmalloc-64.active_objs
    787.33            -0.5%     783.25            -0.4%     784.33        slabinfo.kmalloc-64.active_slabs
     50425            -0.5%      50169            -0.4%      50230        slabinfo.kmalloc-64.num_objs
    787.33            -0.5%     783.25            -0.4%     784.33        slabinfo.kmalloc-64.num_slabs
     53715            +0.2%      53832            -0.1%      53682        slabinfo.kmalloc-8.active_objs
    107.56            +0.6%     108.25 ±  2%      -0.1%     107.44 ±  2%  slabinfo.kmalloc-8.active_slabs
     55068            +0.7%      55466 ±  2%      +0.1%      55115        slabinfo.kmalloc-8.num_objs
    107.56            +0.6%     108.25 ±  2%      -0.1%     107.44 ±  2%  slabinfo.kmalloc-8.num_slabs
    779.44            -0.1%     778.75            -0.1%     778.78        slabinfo.kmalloc-8k.active_objs
    200.56            -0.1%     200.42            -0.1%     200.44        slabinfo.kmalloc-8k.active_slabs
    804.11            -0.1%     803.67            -0.1%     803.22        slabinfo.kmalloc-8k.num_objs
    200.56            -0.1%     200.42            -0.1%     200.44        slabinfo.kmalloc-8k.num_slabs
      7532 ±  3%      +3.7%       7807 ±  3%      +5.7%       7961 ±  2%  slabinfo.kmalloc-96.active_objs
    180.78 ±  3%      +3.7%     187.50 ±  3%      +5.8%     191.22 ±  3%  slabinfo.kmalloc-96.active_slabs
      7612 ±  3%      +3.7%       7896 ±  3%      +5.7%       8048 ±  2%  slabinfo.kmalloc-96.num_objs
    180.78 ±  3%      +3.7%     187.50 ±  3%      +5.8%     191.22 ±  3%  slabinfo.kmalloc-96.num_slabs
    362.44 ± 30%      +6.8%     387.25 ± 33%      -2.2%     354.33 ± 23%  slabinfo.kmalloc-cg-16.active_objs
      1.22 ± 34%     -11.4%       1.08 ± 25%     -18.2%       1.00        slabinfo.kmalloc-cg-16.active_slabs
    362.44 ± 30%      +6.8%     387.25 ± 33%      -2.2%     354.33 ± 23%  slabinfo.kmalloc-cg-16.num_objs
      1.22 ± 34%     -11.4%       1.08 ± 25%     -18.2%       1.00        slabinfo.kmalloc-cg-16.num_slabs
      3251 ±  8%      -0.4%       3239 ±  7%      +0.2%       3256 ±  6%  slabinfo.kmalloc-cg-192.active_objs
     76.78 ±  8%      -0.3%      76.58 ±  7%      +0.3%      77.00 ±  6%  slabinfo.kmalloc-cg-192.active_slabs
      3251 ±  8%      -0.4%       3239 ±  7%      +0.2%       3256 ±  6%  slabinfo.kmalloc-cg-192.num_objs
     76.78 ±  8%      -0.3%      76.58 ±  7%      +0.3%      77.00 ±  6%  slabinfo.kmalloc-cg-192.num_slabs
      3356 ±  7%      -1.8%       3296 ±  6%      -1.5%       3306 ±  6%  slabinfo.kmalloc-cg-1k.active_objs
    104.22 ±  7%      -1.0%     103.17 ±  6%      -1.3%     102.89 ±  6%  slabinfo.kmalloc-cg-1k.active_slabs
      3356 ±  7%      -1.1%       3320 ±  6%      -1.5%       3306 ±  6%  slabinfo.kmalloc-cg-1k.num_objs
    104.22 ±  7%      -1.0%     103.17 ±  6%      -1.3%     102.89 ±  6%  slabinfo.kmalloc-cg-1k.num_slabs
    502.22 ±  6%      +4.8%     526.25 ±  7%      +7.1%     537.78 ± 13%  slabinfo.kmalloc-cg-256.active_objs
     15.11 ±  7%      +4.2%      15.75 ±  8%      +7.4%      16.22 ± 13%  slabinfo.kmalloc-cg-256.active_slabs
    502.22 ±  6%      +4.8%     526.25 ±  7%      +7.1%     537.78 ± 13%  slabinfo.kmalloc-cg-256.num_objs
     15.11 ±  7%      +4.2%      15.75 ±  8%      +7.4%      16.22 ± 13%  slabinfo.kmalloc-cg-256.num_slabs
    305.22 ± 11%      -8.6%     278.83 ± 15%      -9.9%     275.11 ±  8%  slabinfo.kmalloc-cg-2k.active_objs
     18.56 ± 10%     -10.2%      16.67 ± 16%     -11.4%      16.44 ±  9%  slabinfo.kmalloc-cg-2k.active_slabs
    305.22 ± 11%      -8.6%     278.83 ± 15%      -9.9%     275.11 ±  8%  slabinfo.kmalloc-cg-2k.num_objs
     18.56 ± 10%     -10.2%      16.67 ± 16%     -11.4%      16.44 ±  9%  slabinfo.kmalloc-cg-2k.num_slabs
     10395 ± 10%      -0.7%      10326 ±  9%      +4.5%      10868 ±  6%  slabinfo.kmalloc-cg-32.active_objs
     80.67 ± 10%      -0.8%      80.00 ±  9%      +4.4%      84.22 ±  5%  slabinfo.kmalloc-cg-32.active_slabs
     10395 ± 10%      -0.7%      10326 ±  9%      +4.5%      10868 ±  6%  slabinfo.kmalloc-cg-32.num_objs
     80.67 ± 10%      -0.8%      80.00 ±  9%      +4.4%      84.22 ±  5%  slabinfo.kmalloc-cg-32.num_slabs
    768.00            +0.0%     768.00            +0.0%     768.00        slabinfo.kmalloc-cg-4k.active_objs
     96.00            +0.0%      96.00            +0.0%      96.00        slabinfo.kmalloc-cg-4k.active_slabs
    768.00            +0.0%     768.00            +0.0%     768.00        slabinfo.kmalloc-cg-4k.num_objs
     96.00            +0.0%      96.00            +0.0%      96.00        slabinfo.kmalloc-cg-4k.num_slabs
      3068            -0.2%       3063            +0.0%       3068        slabinfo.kmalloc-cg-512.active_objs
     95.89            -0.2%      95.67            +0.0%      95.89        slabinfo.kmalloc-cg-512.active_slabs
      3068            -0.2%       3063            +0.0%       3068        slabinfo.kmalloc-cg-512.num_objs
     95.89            -0.2%      95.67            +0.0%      95.89        slabinfo.kmalloc-cg-512.num_slabs
      1855 ±  9%      +0.7%       1869 ±  6%      -1.3%       1830 ±  8%  slabinfo.kmalloc-cg-64.active_objs
     28.22 ±  9%      +0.7%      28.42 ±  7%      -0.8%      28.00 ±  9%  slabinfo.kmalloc-cg-64.active_slabs
      1855 ±  9%      +0.7%       1869 ±  6%      -1.3%       1830 ±  8%  slabinfo.kmalloc-cg-64.num_objs
     28.22 ±  9%      +0.7%      28.42 ±  7%      -0.8%      28.00 ±  9%  slabinfo.kmalloc-cg-64.num_slabs
     49606            -0.2%      49523            -0.2%      49511        slabinfo.kmalloc-cg-8.active_objs
     96.67            -0.3%      96.42            -0.1%      96.56        slabinfo.kmalloc-cg-8.active_slabs
     49606            -0.2%      49523            -0.2%      49511        slabinfo.kmalloc-cg-8.num_objs
     96.67            -0.3%      96.42            -0.1%      96.56        slabinfo.kmalloc-cg-8.num_slabs
     35.00            -2.9%      34.00 ±  5%      -1.3%      34.56 ±  3%  slabinfo.kmalloc-cg-8k.active_objs
      8.00            -3.1%       7.75 ±  5%      -1.4%       7.89 ±  3%  slabinfo.kmalloc-cg-8k.active_slabs
     35.00            -2.9%      34.00 ±  5%      -1.3%      34.56 ±  3%  slabinfo.kmalloc-cg-8k.num_objs
      8.00            -3.1%       7.75 ±  5%      -1.4%       7.89 ±  3%  slabinfo.kmalloc-cg-8k.num_slabs
    447.00 ± 10%      -5.5%     422.50 ± 11%      -2.1%     437.67 ±  6%  slabinfo.kmalloc-cg-96.active_objs
      9.67 ± 11%      -6.0%       9.08 ± 12%      -2.3%       9.44 ±  7%  slabinfo.kmalloc-cg-96.active_slabs
    447.00 ± 10%      -5.5%     422.50 ± 11%      -2.1%     437.67 ±  6%  slabinfo.kmalloc-cg-96.num_objs
      9.67 ± 11%      -6.0%       9.08 ± 12%      -2.3%       9.44 ±  7%  slabinfo.kmalloc-cg-96.num_slabs
      1144 ± 24%      +6.2%       1216 ± 10%      +1.9%       1166 ± 17%  slabinfo.kmalloc-rcl-128.active_objs
     36.00 ± 22%      +5.6%      38.00 ± 10%      +1.2%      36.44 ± 17%  slabinfo.kmalloc-rcl-128.active_slabs
      1152 ± 22%      +5.6%       1216 ± 10%      +1.2%       1166 ± 17%  slabinfo.kmalloc-rcl-128.num_objs
     36.00 ± 22%      +5.6%      38.00 ± 10%      +1.2%      36.44 ± 17%  slabinfo.kmalloc-rcl-128.num_slabs
     93.33 ± 18%     -13.8%      80.50 ± 14%      -5.0%      88.67 ± 14%  slabinfo.kmalloc-rcl-192.active_objs
      2.22 ± 18%     -13.8%       1.92 ± 14%      -5.0%       2.11 ± 14%  slabinfo.kmalloc-rcl-192.active_slabs
     93.33 ± 18%     -13.8%      80.50 ± 14%      -5.0%      88.67 ± 14%  slabinfo.kmalloc-rcl-192.num_objs
      2.22 ± 18%     -13.8%       1.92 ± 14%      -5.0%       2.11 ± 14%  slabinfo.kmalloc-rcl-192.num_slabs
      7850 ±  4%      +1.5%       7969 ±  3%      +1.3%       7954 ±  4%  slabinfo.kmalloc-rcl-64.active_objs
    123.33 ±  4%      +0.9%     124.50 ±  3%      +1.6%     125.33 ±  3%  slabinfo.kmalloc-rcl-64.active_slabs
      7936 ±  4%      +1.1%       8021 ±  3%      +1.5%       8059 ±  3%  slabinfo.kmalloc-rcl-64.num_objs
    123.33 ±  4%      +0.9%     124.50 ±  3%      +1.6%     125.33 ±  3%  slabinfo.kmalloc-rcl-64.num_slabs
      2616 ± 20%      +0.5%       2630 ± 18%      -2.9%       2540 ± 19%  slabinfo.kmalloc-rcl-96.active_objs
     62.11 ± 20%      +0.2%      62.25 ± 18%      -2.9%      60.33 ± 19%  slabinfo.kmalloc-rcl-96.active_slabs
      2616 ± 20%      +0.5%       2630 ± 18%      -2.9%       2540 ± 19%  slabinfo.kmalloc-rcl-96.num_objs
     62.11 ± 20%      +0.2%      62.25 ± 18%      -2.9%      60.33 ± 19%  slabinfo.kmalloc-rcl-96.num_slabs
    387.56 ±  8%      -0.2%     386.67 ±  9%      +0.0%     387.56 ±  9%  slabinfo.kmem_cache.active_objs
     12.11 ±  8%      -0.2%      12.08 ±  9%      +0.0%      12.11 ±  9%  slabinfo.kmem_cache.active_slabs
    387.56 ±  8%      -0.2%     386.67 ±  9%      +0.0%     387.56 ±  9%  slabinfo.kmem_cache.num_objs
     12.11 ±  8%      -0.2%      12.08 ±  9%      +0.0%      12.11 ±  9%  slabinfo.kmem_cache.num_slabs
    787.78 ±  7%      +0.5%     791.33 ±  7%      +0.0%     787.78 ±  7%  slabinfo.kmem_cache_node.active_objs
     12.78 ±  7%      +0.4%      12.83 ±  7%      +0.0%      12.78 ±  7%  slabinfo.kmem_cache_node.active_slabs
    817.78 ±  7%      +0.4%     821.33 ±  7%      +0.0%     817.78 ±  7%  slabinfo.kmem_cache_node.num_objs
     12.78 ±  7%      +0.4%      12.83 ±  7%      +0.0%      12.78 ±  7%  slabinfo.kmem_cache_node.num_slabs
     18770 ±  2%      +0.4%      18836            +1.2%      18997        slabinfo.lsm_file_cache.active_objs
    109.44 ±  2%      +0.4%     109.83            +1.2%     110.78        slabinfo.lsm_file_cache.active_slabs
     18770 ±  2%      +0.4%      18836            +1.2%      18997        slabinfo.lsm_file_cache.num_objs
    109.44 ±  2%      +0.4%     109.83            +1.2%     110.78        slabinfo.lsm_file_cache.num_slabs
      2960 ±  2%      -0.5%       2944 ±  3%      +0.3%       2969 ±  3%  slabinfo.mm_struct.active_objs
     98.00 ±  2%      -0.3%      97.67 ±  3%      +0.3%      98.33 ±  2%  slabinfo.mm_struct.active_slabs
      2960 ±  2%      -0.5%       2944 ±  3%      +0.3%       2969 ±  3%  slabinfo.mm_struct.num_objs
     98.00 ±  2%      -0.3%      97.67 ±  3%      +0.3%      98.33 ±  2%  slabinfo.mm_struct.num_slabs
      1112 ±  6%      -9.1%       1010 ±  8%      -8.5%       1017 ±  8%  slabinfo.mnt_cache.active_objs
     21.11 ±  6%      -9.6%      19.08 ±  8%     -10.0%      19.00 ±  8%  slabinfo.mnt_cache.active_slabs
      1112 ±  6%      -9.1%       1010 ±  8%      -8.5%       1017 ±  8%  slabinfo.mnt_cache.num_objs
     21.11 ±  6%      -9.6%      19.08 ±  8%     -10.0%      19.00 ±  8%  slabinfo.mnt_cache.num_slabs
     34.00            +0.0%      34.00            +0.0%      34.00        slabinfo.mqueue_inode_cache.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.mqueue_inode_cache.active_slabs
     34.00            +0.0%      34.00            +0.0%      34.00        slabinfo.mqueue_inode_cache.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.mqueue_inode_cache.num_slabs
    768.00            +0.0%     768.00            +0.0%     768.00        slabinfo.names_cache.active_objs
     96.00            +0.0%      96.00            +0.0%      96.00        slabinfo.names_cache.active_slabs
    768.00            +0.0%     768.00            +0.0%     768.00        slabinfo.names_cache.num_objs
     96.00            +0.0%      96.00            +0.0%      96.00        slabinfo.names_cache.num_slabs
     34.00            +0.0%      34.00            +0.0%      34.00        slabinfo.nfs_read_data.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.nfs_read_data.active_slabs
     34.00            +0.0%      34.00            +0.0%      34.00        slabinfo.nfs_read_data.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.nfs_read_data.num_slabs
    124.00            +0.0%     124.00            +0.0%     124.00        slabinfo.numa_policy.active_objs
      2.00            +0.0%       2.00            +0.0%       2.00        slabinfo.numa_policy.active_slabs
    124.00            +0.0%     124.00            +0.0%     124.00        slabinfo.numa_policy.num_objs
      2.00            +0.0%       2.00            +0.0%       2.00        slabinfo.numa_policy.num_slabs
      8212 ±  9%      -0.8%       8145 ±  7%      +4.0%       8538 ±  5%  slabinfo.pde_opener.active_objs
     80.00 ±  9%      -1.0%      79.17 ±  7%      +3.9%      83.11 ±  5%  slabinfo.pde_opener.active_slabs
      8212 ±  9%      -0.8%       8145 ±  7%      +4.0%       8538 ±  5%  slabinfo.pde_opener.num_objs
     80.00 ±  9%      -1.0%      79.17 ±  7%      +3.9%      83.11 ±  5%  slabinfo.pde_opener.num_slabs
      4075            -0.9%       4037 ±  2%      +0.2%       4084        slabinfo.perf_event.active_objs
    153.89            -0.8%     152.67            +0.2%     154.22        slabinfo.perf_event.active_slabs
      4166            -0.8%       4133            +0.1%       4172        slabinfo.perf_event.num_objs
    153.89            -0.8%     152.67            +0.2%     154.22        slabinfo.perf_event.num_slabs
      4703 ±  3%      +3.2%       4852 ±  3%      +1.1%       4757 ±  4%  slabinfo.pid.active_objs
    146.11 ±  3%      +3.2%     150.83 ±  3%      +1.1%     147.78 ±  4%  slabinfo.pid.active_slabs
      4703 ±  3%      +3.2%       4852 ±  3%      +1.1%       4757 ±  4%  slabinfo.pid.num_objs
    146.11 ±  3%      +3.2%     150.83 ±  3%      +1.1%     147.78 ±  4%  slabinfo.pid.num_slabs
      1509 ±  8%      -4.0%       1449 ±  8%      +4.9%       1584 ±  5%  slabinfo.pool_workqueue.active_objs
     46.56 ±  8%      -3.7%      44.83 ±  8%      +5.5%      49.11 ±  6%  slabinfo.pool_workqueue.active_slabs
      1509 ±  8%      -3.8%       1451 ±  8%      +5.1%       1587 ±  5%  slabinfo.pool_workqueue.num_objs
     46.56 ±  8%      -3.7%      44.83 ±  8%      +5.5%      49.11 ±  6%  slabinfo.pool_workqueue.num_slabs
      2930            -1.5%       2887            -1.1%       2898 ±  2%  slabinfo.proc_dir_entry.active_objs
     69.78            -1.5%      68.75            -1.1%      69.00 ±  2%  slabinfo.proc_dir_entry.active_slabs
      2930            -1.5%       2887            -1.1%       2898 ±  2%  slabinfo.proc_dir_entry.num_objs
     69.78            -1.5%      68.75            -1.1%      69.00 ±  2%  slabinfo.proc_dir_entry.num_slabs
     14278            +1.0%      14427            +0.3%      14325        slabinfo.proc_inode_cache.active_objs
    290.89            +1.1%     294.17            +0.4%     292.00        slabinfo.proc_inode_cache.active_slabs
     14282            +1.0%      14431            +0.4%      14339        slabinfo.proc_inode_cache.num_objs
    290.89            +1.1%     294.17            +0.4%     292.00        slabinfo.proc_inode_cache.num_slabs
     27516            +0.2%      27564            -0.2%      27449        slabinfo.radix_tree_node.active_objs
    491.56            +0.0%     491.67            -0.4%     489.67        slabinfo.radix_tree_node.active_slabs
     27553            +0.0%      27564            -0.4%      27452        slabinfo.radix_tree_node.num_objs
    491.56            +0.0%     491.67            -0.4%     489.67        slabinfo.radix_tree_node.num_slabs
     78.33 ± 12%      +0.5%      78.75 ±  8%      -4.3%      75.00        slabinfo.request_queue.active_objs
      5.22 ± 12%      +0.5%       5.25 ±  8%      -4.3%       5.00        slabinfo.request_queue.active_slabs
     78.33 ± 12%      +0.5%      78.75 ±  8%      -4.3%      75.00        slabinfo.request_queue.num_objs
      5.22 ± 12%      +0.5%       5.25 ±  8%      -4.3%       5.00        slabinfo.request_queue.num_slabs
     51.00            +0.0%      51.00            +0.0%      51.00        slabinfo.rpc_inode_cache.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.rpc_inode_cache.active_slabs
     51.00            +0.0%      51.00            +0.0%      51.00        slabinfo.rpc_inode_cache.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.rpc_inode_cache.num_slabs
    924.44 ±  2%      +0.1%     925.33 ±  2%      -1.2%     913.78        slabinfo.scsi_sense_cache.active_objs
     28.89 ±  2%      +0.1%      28.92 ±  2%      -1.2%      28.56        slabinfo.scsi_sense_cache.active_slabs
    924.44 ±  2%      +0.1%     925.33 ±  2%      -1.2%     913.78        slabinfo.scsi_sense_cache.num_objs
     28.89 ±  2%      +0.1%      28.92 ±  2%      -1.2%      28.56        slabinfo.scsi_sense_cache.num_slabs
      3264            +0.0%       3264            +0.0%       3264        slabinfo.seq_file.active_objs
     96.00            +0.0%      96.00            +0.0%      96.00        slabinfo.seq_file.active_slabs
      3264            +0.0%       3264            +0.0%       3264        slabinfo.seq_file.num_objs
     96.00            +0.0%      96.00            +0.0%      96.00        slabinfo.seq_file.num_slabs
      4731 ±  6%      +3.3%       4887 ±  6%      +6.9%       5056 ±  7%  slabinfo.shmem_inode_cache.active_objs
    102.56 ±  7%      +3.0%     105.67 ±  6%      +6.7%     109.44 ±  7%  slabinfo.shmem_inode_cache.active_slabs
      4731 ±  6%      +3.3%       4887 ±  6%      +6.9%       5056 ±  7%  slabinfo.shmem_inode_cache.num_objs
    102.56 ±  7%      +3.0%     105.67 ±  6%      +6.7%     109.44 ±  7%  slabinfo.shmem_inode_cache.num_slabs
      2217 ±  4%      -2.7%       2156 ±  4%      -0.9%       2198 ±  4%  slabinfo.sighand_cache.active_objs
    148.11 ±  3%      -2.6%     144.25 ±  4%      -1.1%     146.56 ±  4%  slabinfo.sighand_cache.active_slabs
      2232 ±  3%      -2.6%       2173 ±  4%      -1.1%       2208 ±  4%  slabinfo.sighand_cache.num_objs
    148.11 ±  3%      -2.6%     144.25 ±  4%      -1.1%     146.56 ±  4%  slabinfo.sighand_cache.num_slabs
      4292 ±  4%      +1.2%       4344 ±  5%      +0.3%       4304 ±  4%  slabinfo.signal_cache.active_objs
    152.67 ±  4%      +1.8%     155.42 ±  5%      +0.3%     153.11 ±  4%  slabinfo.signal_cache.active_slabs
      4292 ±  4%      +1.9%       4372 ±  5%      +0.3%       4304 ±  4%  slabinfo.signal_cache.num_objs
    152.67 ±  4%      +1.8%     155.42 ±  5%      +0.3%     153.11 ±  4%  slabinfo.signal_cache.num_slabs
    313.00 ± 25%      -3.7%     301.33 ± 14%      +6.6%     333.67 ± 14%  slabinfo.skbuff_fclone_cache.active_objs
      9.33 ± 23%      +0.9%       9.42 ± 14%     +10.7%      10.33 ± 14%  slabinfo.skbuff_fclone_cache.active_slabs
    313.00 ± 25%      -3.7%     301.33 ± 14%      +6.6%     333.67 ± 14%  slabinfo.skbuff_fclone_cache.num_objs
      9.33 ± 23%      +0.9%       9.42 ± 14%     +10.7%      10.33 ± 14%  slabinfo.skbuff_fclone_cache.num_slabs
      4730 ±  7%      -4.1%       4535 ±  6%      -5.8%       4456 ±  4%  slabinfo.skbuff_head_cache.active_objs
    147.56 ±  7%      -4.1%     141.50 ±  6%      -5.7%     139.11 ±  4%  slabinfo.skbuff_head_cache.active_slabs
      4730 ±  7%      -4.1%       4535 ±  6%      -5.8%       4456 ±  4%  slabinfo.skbuff_head_cache.num_objs
    147.56 ±  7%      -4.1%     141.50 ±  6%      -5.7%     139.11 ±  4%  slabinfo.skbuff_head_cache.num_slabs
      3053 ± 14%      -0.2%       3048 ± 13%      +5.4%       3218 ±  9%  slabinfo.sock_inode_cache.active_objs
     78.00 ± 14%      +0.0%      78.00 ± 13%      +5.4%      82.22 ± 10%  slabinfo.sock_inode_cache.active_slabs
      3053 ± 14%      -0.2%       3048 ± 13%      +5.4%       3218 ±  9%  slabinfo.sock_inode_cache.num_objs
     78.00 ± 14%      +0.0%      78.00 ± 13%      +5.4%      82.22 ± 10%  slabinfo.sock_inode_cache.num_slabs
      1432 ± 14%      +3.3%       1479 ±  8%      +1.0%       1445 ± 12%  slabinfo.task_delay_info.active_objs
     27.89 ± 14%      +2.2%      28.50 ±  8%      +0.8%      28.11 ± 12%  slabinfo.task_delay_info.active_slabs
      1432 ± 14%      +3.3%       1479 ±  8%      +1.0%       1445 ± 12%  slabinfo.task_delay_info.num_objs
     27.89 ± 14%      +2.2%      28.50 ±  8%      +0.8%      28.11 ± 12%  slabinfo.task_delay_info.num_slabs
      1328 ±  7%      +2.9%       1366 ± 10%      +7.9%       1433 ±  4%  slabinfo.task_group.active_objs
     28.33 ±  7%      +3.2%      29.25 ± 10%      +7.8%      30.56 ±  5%  slabinfo.task_group.active_slabs
      1328 ±  7%      +2.9%       1366 ± 10%      +7.9%       1433 ±  4%  slabinfo.task_group.num_objs
     28.33 ±  7%      +3.2%      29.25 ± 10%      +7.8%      30.56 ±  5%  slabinfo.task_group.num_slabs
      1260            +0.5%       1265            +0.9%       1271        slabinfo.task_struct.active_objs
      1266            +0.5%       1272            +0.9%       1277        slabinfo.task_struct.active_slabs
      1266            +0.5%       1272            +0.9%       1277        slabinfo.task_struct.num_objs
      1266            +0.5%       1272            +0.9%       1277        slabinfo.task_struct.num_slabs
    294.33 ± 10%      -7.2%     273.00 ±  8%      -1.7%     289.33 ± 12%  slabinfo.taskstats.active_objs
      6.33 ± 10%      -7.9%       5.83 ±  9%      -1.8%       6.22 ± 12%  slabinfo.taskstats.active_slabs
    294.33 ± 10%      -7.2%     273.00 ±  8%      -1.7%     289.33 ± 12%  slabinfo.taskstats.num_objs
      6.33 ± 10%      -7.9%       5.83 ±  9%      -1.8%       6.22 ± 12%  slabinfo.taskstats.num_slabs
      3069 ±  5%      -1.7%       3017 ±  3%      -1.5%       3022 ±  3%  slabinfo.trace_event_file.active_objs
     66.22 ±  5%      -1.5%      65.25 ±  2%      -1.2%      65.44 ±  3%  slabinfo.trace_event_file.active_slabs
      3069 ±  5%      -1.7%       3017 ±  3%      -1.5%       3022 ±  3%  slabinfo.trace_event_file.num_objs
     66.22 ±  5%      -1.5%      65.25 ±  2%      -1.2%      65.44 ±  3%  slabinfo.trace_event_file.num_slabs
     33.00            +0.0%      33.00            +0.0%      33.00        slabinfo.tw_sock_TCP.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.tw_sock_TCP.active_slabs
     33.00            +0.0%      33.00            +0.0%      33.00        slabinfo.tw_sock_TCP.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.tw_sock_TCP.num_slabs
     54128 ±  7%      -3.8%      52087 ±  6%      +1.9%      55144 ±  5%  slabinfo.vm_area_struct.active_objs
      1355 ±  7%      -3.7%       1304 ±  6%      +2.0%       1382 ±  5%  slabinfo.vm_area_struct.active_slabs
     54236 ±  7%      -3.7%      52216 ±  6%      +2.0%      55300 ±  5%  slabinfo.vm_area_struct.num_objs
      1355 ±  7%      -3.7%       1304 ±  6%      +2.0%       1382 ±  5%  slabinfo.vm_area_struct.num_slabs
     21955            +0.4%      22037            -0.1%      21932 ±  2%  slabinfo.vmap_area.active_objs
    343.00            +0.4%     344.50            -0.0%     342.89 ±  2%  slabinfo.vmap_area.active_slabs
     21992            +0.4%      22071            -0.1%      21972 ±  2%  slabinfo.vmap_area.num_objs
    343.00            +0.4%     344.50            -0.0%     342.89 ±  2%  slabinfo.vmap_area.num_slabs
     42.00            +0.0%      42.00            +0.0%      42.00        slabinfo.xfrm_state.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.xfrm_state.active_slabs
     42.00            +0.0%      42.00            +0.0%      42.00        slabinfo.xfrm_state.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.xfrm_state.num_slabs
     66.46 ±  8%      -1.7       64.80 ±  9%      -6.3       60.12 ±  5%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     66.50 ±  8%      -1.6       64.85 ±  9%      -6.3       60.15 ±  5%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     66.50 ±  8%      -1.6       64.85 ±  9%      -6.3       60.15 ±  5%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     17.94 ±  8%      -1.0       16.93 ±  6%      -0.3       17.64 ±  8%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     60.15 ±  9%      -1.0       59.19 ± 10%      -6.6       53.59 ±  5%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     59.34 ±  9%      -1.0       58.37 ± 10%      -6.5       52.82 ±  6%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
     14.53 ±  9%      -0.8       13.73 ±  5%      -0.6       13.97 ± 10%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle
     67.00 ±  8%      -0.7       66.27 ±  6%      -6.3       60.69 ±  5%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      4.98 ± 15%      -0.7        4.30 ± 14%      +0.4        5.37 ±  7%  perf-profile.calltrace.cycles-pp.menu_select.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      9.81 ±  8%      -0.5        9.31 ±  5%      -0.4        9.41 ± 10%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      2.54 ± 27%      -0.5        2.05 ± 33%      +0.5        2.99 ± 12%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry.start_secondary
      9.50 ±  8%      -0.5        9.02 ±  5%      -0.3        9.24 ± 10%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      1.98 ± 36%      -0.5        1.52 ± 44%      +0.5        2.52 ± 13%  perf-profile.calltrace.cycles-pp.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry
      0.90 ± 70%      -0.4        0.53 ±127%      +0.6        1.46 ± 22%  perf-profile.calltrace.cycles-pp.timekeeping_max_deferment.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.do_idle
      8.52 ± 23%      -0.3        8.18 ± 13%      +1.1        9.66 ± 13%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.86 ± 58%      -0.3        0.57 ± 98%      +0.4        1.24 ± 23%  perf-profile.calltrace.cycles-pp.tick_nohz_irq_exit.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      2.65 ± 14%      -0.3        2.36 ± 12%      +0.2        2.80 ± 14%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      3.25 ± 15%      -0.3        2.97 ± 13%      +0.3        3.53 ± 15%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      3.14 ± 15%      -0.3        2.86 ± 13%      +0.3        3.42 ± 15%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      2.94 ± 15%      -0.3        2.66 ± 13%      +0.2        3.17 ± 14%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      4.00 ± 15%      -0.3        3.74 ± 13%      +0.4        4.43 ± 14%  perf-profile.calltrace.cycles-pp.read
      2.35 ± 34%      -0.3        2.10 ± 44%      +0.6        2.98 ± 15%  perf-profile.calltrace.cycles-pp.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.24 ±112%      -0.2        0.00            +0.2        0.42 ± 72%  perf-profile.calltrace.cycles-pp.anon_pipe_buf_release.pipe_read.new_sync_read.vfs_read.ksys_read
      0.78 ± 71%      -0.2        0.55 ±101%      +0.4        1.21 ± 24%  perf-profile.calltrace.cycles-pp.ktime_get.tick_nohz_irq_exit.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      3.00 ± 12%      -0.2        2.78 ±  9%      -0.3        2.67 ±  8%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
      9.50 ± 23%      -0.2        9.29 ± 13%      +1.4       10.91 ± 12%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.61 ± 12%      -0.2        3.41 ±  9%      -0.4        3.21 ±  8%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.19 ±141%      -0.2        0.00            -0.2        0.00        perf-profile.calltrace.cycles-pp.fsnotify.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.26 ± 54%      -0.2        1.08 ± 83%      +0.5        1.79 ± 26%  perf-profile.calltrace.cycles-pp.ktime_get.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      5.66 ± 13%      -0.2        5.49 ± 12%      -0.9        4.76 ±  7%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      3.10 ± 12%      -0.2        2.94 ± 13%      +0.6        3.65 ± 13%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      2.55 ± 13%      -0.2        2.39 ± 14%      +0.5        3.03 ± 12%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.82 ± 40%      -0.2        0.66 ± 14%      +0.1        0.90 ± 15%  perf-profile.calltrace.cycles-pp.security_file_permission.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.19 ± 13%      -0.2        3.04 ± 13%      +0.6        3.77 ± 13%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
      2.23 ± 12%      -0.2        2.08 ±  8%      -0.2        2.08 ±  7%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      3.24 ± 13%      -0.1        3.09 ± 11%      -0.5        2.77 ±  8%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      2.86 ± 13%      -0.1        2.72 ± 13%      +0.5        3.37 ± 12%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      3.93 ± 14%      -0.1        3.80 ± 13%      +0.7        4.67 ± 11%  perf-profile.calltrace.cycles-pp.write
      0.28 ±114%      -0.1        0.16 ±173%      +0.2        0.45 ± 74%  perf-profile.calltrace.cycles-pp.calc_global_load_tick.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer
      1.78 ± 12%      -0.1        1.66 ±  7%      -0.1        1.68 ±  8%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.62 ±  7%      -0.1        0.51 ± 46%      -0.1        0.53 ± 36%  perf-profile.calltrace.cycles-pp.load_balance.rebalance_domains.__softirqentry_text_start.irq_exit_rcu.sysvec_apic_timer_interrupt
      0.94 ± 22%      -0.1        0.83 ± 19%      +0.1        1.07 ±  7%  perf-profile.calltrace.cycles-pp.lapic_next_deadline.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      1.59 ± 10%      -0.1        1.51 ±  9%      -0.1        1.51 ± 10%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
      0.12 ±187%      -0.1        0.04 ±331%      -0.1        0.00        perf-profile.calltrace.cycles-pp.rcu_idle_exit.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      1.01 ± 11%      -0.1        0.94 ±  9%      -0.0        0.98 ±  8%  perf-profile.calltrace.cycles-pp.rebalance_domains.__softirqentry_text_start.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.06 ±282%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.fsnotify.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.06 ±282%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp._raw_spin_trylock.rebalance_domains.__softirqentry_text_start.irq_exit_rcu.sysvec_apic_timer_interrupt
      0.06 ±282%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.update_rq_clock.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer
      0.18 ±142%      -0.0        0.14 ±173%      -0.2        0.00        perf-profile.calltrace.cycles-pp.hrtimer_update_next_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.12 ±187%      -0.0        0.09 ±223%      -0.1        0.06 ±282%  perf-profile.calltrace.cycles-pp.mutex_unlock.pipe_read.new_sync_read.vfs_read.ksys_read
      0.41 ± 99%      -0.0        0.39 ± 92%      +0.2        0.59 ± 62%  perf-profile.calltrace.cycles-pp.ktime_get_update_offsets_now.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.92 ± 13%      -0.0        0.90 ± 17%      -0.1        0.84 ± 13%  perf-profile.calltrace.cycles-pp.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.26 ±112%      +0.0        0.26 ±120%      -0.3        0.00        perf-profile.calltrace.cycles-pp.rcu_sched_clock_irq.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
      0.18 ±142%      +0.0        0.19 ±142%      +0.1        0.31 ± 90%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.pipe_read.new_sync_read.vfs_read.ksys_read
      0.00            +0.0        0.04 ±331%      +0.2        0.18 ±142%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_safe_stack
      0.56 ± 38%      +0.0        0.60 ± 33%      +0.2        0.77 ± 37%  perf-profile.calltrace.cycles-pp.security_file_permission.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.12 ±282%      +0.0        0.16 ±223%      +0.2        0.28 ±144%  perf-profile.calltrace.cycles-pp.ktime_get.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +0.0        0.04 ±331%      +0.0        0.00        perf-profile.calltrace.cycles-pp.ktime_get.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.00            +0.0        0.05 ±331%      +0.2        0.17 ±141%  perf-profile.calltrace.cycles-pp.mutex_unlock.pipe_write.new_sync_write.vfs_write.ksys_write
      0.00            +0.0        0.05 ±331%      +0.2        0.24 ±112%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.pipe_write.new_sync_write.vfs_write.ksys_write
      0.90 ± 26%      +0.1        0.95 ± 17%      -0.4        0.52 ± 82%  perf-profile.calltrace.cycles-pp.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.96 ± 25%      +0.1        1.01 ± 15%      -0.2        0.73 ± 36%  perf-profile.calltrace.cycles-pp.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.40 ± 72%      +0.1        0.46 ± 61%      +0.2        0.65 ± 38%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.12 ±187%      +0.1        0.18 ±141%      +0.4        0.50 ± 55%  perf-profile.calltrace.cycles-pp.common_file_perm.security_file_permission.vfs_read.ksys_read.do_syscall_64
      0.78 ± 39%      +0.1        0.86 ± 17%      +0.2        0.99 ± 15%  perf-profile.calltrace.cycles-pp.atime_needs_update.touch_atime.pipe_read.new_sync_read.vfs_read
      0.00            +0.1        0.09 ±223%      +0.1        0.12 ±187%  perf-profile.calltrace.cycles-pp.find_busiest_group.load_balance.rebalance_domains.__softirqentry_text_start.irq_exit_rcu
      0.19 ±142%      +0.1        0.28 ±100%      +0.3        0.51 ± 55%  perf-profile.calltrace.cycles-pp.common_file_perm.security_file_permission.vfs_write.ksys_write.do_syscall_64
      0.76 ± 39%      +0.1        0.85 ± 18%      +0.2        0.96 ± 14%  perf-profile.calltrace.cycles-pp.mutex_lock.pipe_read.new_sync_read.vfs_read.ksys_read
      0.59 ± 36%      +0.1        0.69 ± 16%      +0.1        0.71 ± 38%  perf-profile.calltrace.cycles-pp.__fget_light.__fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.12 ±187%      +0.1        0.23 ±118%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__remove_hrtimer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.72 ± 40%      +0.1        0.83 ± 20%      +0.3        1.03 ± 18%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.33 ± 91%      +0.1        0.46 ± 59%      +0.4        0.68 ± 10%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__wake_up_common_lock.pipe_write.new_sync_write.vfs_write
      0.66 ± 37%      +0.1        0.79 ± 17%      +0.2        0.84 ± 17%  perf-profile.calltrace.cycles-pp.__fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.43 ± 32%      +0.1        1.56 ± 24%      +0.4        1.86 ± 21%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyin.copy_page_from_iter.pipe_write.new_sync_write
      0.60 ± 39%      +0.1        0.74 ± 13%      +0.2        0.83 ± 11%  perf-profile.calltrace.cycles-pp.__fget_light.__fdget_pos.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.68 ± 31%      +0.1        1.82 ± 25%      +0.7        2.38 ± 16%  perf-profile.calltrace.cycles-pp.copyin.copy_page_from_iter.pipe_write.new_sync_write.vfs_write
      0.67 ± 39%      +0.1        0.82 ± 13%      +0.3        0.93 ± 12%  perf-profile.calltrace.cycles-pp.__fdget_pos.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.89 ± 39%      +0.1        1.04 ± 16%      +0.3        1.18 ± 15%  perf-profile.calltrace.cycles-pp.touch_atime.pipe_read.new_sync_read.vfs_read.ksys_read
      0.67 ± 38%      +0.2        0.82 ± 16%      +0.3        0.99 ± 16%  perf-profile.calltrace.cycles-pp.mutex_lock.pipe_write.new_sync_write.vfs_write.ksys_write
      1.06 ± 25%      +0.2        1.21 ± 15%      +0.3        1.35 ± 15%  perf-profile.calltrace.cycles-pp.__entry_text_start
      0.21 ±143%      +0.2        0.37 ± 85%      -0.2        0.00        perf-profile.calltrace.cycles-pp.io_serial_in.wait_for_xmitr.serial8250_console_putchar.uart_console_write.serial8250_console_write
      0.92 ± 21%      +0.2        1.08 ± 14%      +0.3        1.23 ±  7%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.pipe_write.new_sync_write.vfs_write.ksys_write
      0.35 ±114%      +0.2        0.52 ± 73%      -0.3        0.00        perf-profile.calltrace.cycles-pp.wait_for_xmitr.serial8250_console_putchar.uart_console_write.serial8250_console_write.console_unlock
      0.35 ±114%      +0.2        0.52 ± 73%      -0.3        0.00        perf-profile.calltrace.cycles-pp.serial8250_console_putchar.uart_console_write.serial8250_console_write.console_unlock.vprintk_emit
      0.36 ±114%      +0.2        0.54 ± 73%      -0.4        0.00        perf-profile.calltrace.cycles-pp.uart_console_write.serial8250_console_write.console_unlock.vprintk_emit.printk
      0.37 ±114%      +0.2        0.55 ± 73%      -0.4        0.00        perf-profile.calltrace.cycles-pp.serial8250_console_write.console_unlock.vprintk_emit.printk.irq_work_single
      0.38 ±114%      +0.2        0.57 ± 73%      -0.4        0.00        perf-profile.calltrace.cycles-pp.irq_work_run_list.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work
      0.38 ±114%      +0.2        0.57 ± 73%      -0.4        0.00        perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.cpuidle_enter_state
      0.38 ±114%      +0.2        0.57 ± 73%      -0.4        0.00        perf-profile.calltrace.cycles-pp.irq_work_single.irq_work_run_list.irq_work_run.__sysvec_irq_work.sysvec_irq_work
      0.38 ±114%      +0.2        0.57 ± 73%      -0.4        0.00        perf-profile.calltrace.cycles-pp.printk.irq_work_single.irq_work_run_list.irq_work_run.__sysvec_irq_work
      0.38 ±114%      +0.2        0.57 ± 73%      -0.4        0.00        perf-profile.calltrace.cycles-pp.vprintk_emit.printk.irq_work_single.irq_work_run_list.irq_work_run
      0.38 ±114%      +0.2        0.57 ± 73%      -0.4        0.00        perf-profile.calltrace.cycles-pp.console_unlock.vprintk_emit.printk.irq_work_single.irq_work_run_list
      1.82 ± 31%      +0.2        2.01 ± 24%      +0.5        2.27 ± 13%  perf-profile.calltrace.cycles-pp.copyout.copy_page_to_iter.pipe_read.new_sync_read.vfs_read
      0.38 ±114%      +0.2        0.57 ± 73%      -0.4        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      0.38 ±114%      +0.2        0.57 ± 73%      -0.4        0.00        perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.cpuidle_enter_state.cpuidle_enter.do_idle
      0.38 ±114%      +0.2        0.57 ± 73%      -0.4        0.00        perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.cpuidle_enter_state.cpuidle_enter
      0.20 ±141%      +0.2        0.41 ± 72%      +0.4        0.58 ± 37%  perf-profile.calltrace.cycles-pp.file_update_time.pipe_write.new_sync_write.vfs_write.ksys_write
      0.29 ±113%      +0.2        0.53 ± 50%      +0.3        0.61 ± 36%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret
      3.16 ± 20%      +0.3        3.41 ± 13%      +0.8        3.94 ± 11%  perf-profile.calltrace.cycles-pp.copy_page_from_iter.pipe_write.new_sync_write.vfs_write.ksys_write
      8.16 ± 19%      +0.3        8.42 ± 14%      +1.6        9.80 ±  8%  perf-profile.calltrace.cycles-pp.pipe_read.new_sync_read.vfs_read.ksys_read.do_syscall_64
      1.43 ± 27%      +0.3        1.70 ± 23%      +0.4        1.83 ± 17%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyout.copy_page_to_iter.pipe_read.new_sync_read
      3.19 ± 19%      +0.3        3.48 ± 12%      +0.5        3.74 ± 10%  perf-profile.calltrace.cycles-pp.copy_page_to_iter.pipe_read.new_sync_read.vfs_read.ksys_read
      8.69 ± 19%      +0.4        9.06 ± 14%      +1.7       10.44 ±  8%  perf-profile.calltrace.cycles-pp.new_sync_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.23 ± 21%      +0.5        8.72 ± 12%      +2.0       10.23 ± 13%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     20.32 ± 22%      +0.5       20.83 ± 13%      +4.0       24.32 ± 13%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.23 ± 21%      +0.6        9.85 ± 13%      +2.2       11.43 ± 13%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     20.93 ± 22%      +0.7       21.59 ± 13%      +4.2       25.14 ± 13%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     40.56 ± 12%      +0.7       41.30 ±  9%      -5.7       34.83 ± 10%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      8.34 ± 19%      +0.8        9.10 ± 13%      +2.3       10.67 ±  8%  perf-profile.calltrace.cycles-pp.pipe_write.new_sync_write.vfs_write.ksys_write.do_syscall_64
      8.94 ± 18%      +0.8        9.74 ± 13%      +2.5       11.41 ±  8%  perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.30 ± 90%      +0.8        1.15 ±260%      -0.2        0.06 ±282%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_kernel
      0.31 ± 90%      +0.9        1.20 ±248%      -0.1        0.17 ±141%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_kernel.secondary_startup_64_no_verify
      0.41 ± 71%      +0.9        1.32 ±222%      -0.0        0.39 ± 71%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_kernel.secondary_startup_64_no_verify
      0.41 ± 71%      +0.9        1.32 ±222%      -0.0        0.39 ± 71%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_kernel.secondary_startup_64_no_verify
      0.41 ± 71%      +0.9        1.32 ±222%      -0.0        0.39 ± 71%  perf-profile.calltrace.cycles-pp.start_kernel.secondary_startup_64_no_verify
     66.50 ±  8%      -1.6       64.85 ±  9%      -6.3       60.15 ±  5%  perf-profile.children.cycles-pp.start_secondary
      1.46 ± 22%      -1.5        0.00            -1.5        0.00        perf-profile.children.cycles-pp.fsnotify
     16.66 ±  8%      -0.9       15.76 ±  5%      -0.4       16.29 ±  9%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     14.78 ±  9%      -0.8       13.97 ±  5%      -0.5       14.25 ± 10%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
     67.00 ±  8%      -0.7       66.27 ±  6%      -6.3       60.69 ±  5%  perf-profile.children.cycles-pp.do_idle
     67.00 ±  8%      -0.7       66.27 ±  6%      -6.3       60.69 ±  5%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     67.00 ±  8%      -0.7       66.27 ±  6%      -6.3       60.69 ±  5%  perf-profile.children.cycles-pp.cpu_startup_entry
      5.07 ± 15%      -0.7        4.38 ± 14%      +0.4        5.45 ±  7%  perf-profile.children.cycles-pp.menu_select
     11.22 ± 19%      -0.6       10.58 ± 13%      +1.3       12.49 ±  8%  perf-profile.children.cycles-pp.vfs_read
      9.98 ±  8%      -0.5        9.48 ±  5%      -0.4        9.62 ± 10%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      2.58 ± 27%      -0.5        2.09 ± 33%      +0.5        3.04 ± 12%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      9.68 ±  8%      -0.5        9.20 ±  5%      -0.2        9.46 ± 10%  perf-profile.children.cycles-pp.hrtimer_interrupt
     12.49 ± 19%      -0.5       12.02 ± 13%      +1.6       14.11 ±  8%  perf-profile.children.cycles-pp.ksys_read
      2.04 ± 35%      -0.5        1.57 ± 43%      +0.5        2.56 ± 14%  perf-profile.children.cycles-pp.tick_nohz_next_event
      2.99 ± 42%      -0.4        2.59 ± 57%      +0.9        3.91 ± 29%  perf-profile.children.cycles-pp.ktime_get
      0.97 ± 59%      -0.3        0.67 ± 86%      +0.5        1.47 ± 22%  perf-profile.children.cycles-pp.timekeeping_max_deferment
      0.57 ± 23%      -0.3        0.30 ± 23%      +0.2        0.74 ± 17%  perf-profile.children.cycles-pp.anon_pipe_buf_release
      4.20 ± 15%      -0.2        3.95 ± 13%      +0.5        4.68 ± 13%  perf-profile.children.cycles-pp.read
      2.40 ± 33%      -0.2        2.16 ± 43%      +0.6        3.04 ± 15%  perf-profile.children.cycles-pp.clockevents_program_event
      1.92 ± 21%      -0.2        1.69 ± 13%      +0.3        2.23 ± 12%  perf-profile.children.cycles-pp.security_file_permission
      0.90 ± 52%      -0.2        0.67 ± 70%      +0.3        1.25 ± 23%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      3.08 ± 12%      -0.2        2.86 ±  9%      -0.3        2.76 ±  8%  perf-profile.children.cycles-pp.update_process_times
      3.69 ± 12%      -0.2        3.48 ±  9%      -0.4        3.31 ±  7%  perf-profile.children.cycles-pp.tick_sched_timer
      5.80 ± 13%      -0.2        5.61 ± 12%      -0.9        4.91 ±  7%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      2.29 ± 12%      -0.2        2.12 ±  8%      -0.2        2.13 ±  7%  perf-profile.children.cycles-pp.irq_exit_rcu
      3.30 ± 14%      -0.1        3.15 ± 11%      -0.5        2.85 ±  7%  perf-profile.children.cycles-pp.tick_sched_handle
      4.14 ± 15%      -0.1        3.99 ± 13%      +0.8        4.92 ± 11%  perf-profile.children.cycles-pp.write
      0.49 ± 34%      -0.1        0.35 ± 55%      +0.1        0.61 ± 23%  perf-profile.children.cycles-pp.calc_global_load_tick
      1.82 ± 12%      -0.1        1.69 ±  8%      -0.1        1.72 ±  7%  perf-profile.children.cycles-pp.__softirqentry_text_start
      0.73 ± 13%      -0.1        0.62 ± 19%      +0.1        0.79 ± 15%  perf-profile.children.cycles-pp.read_tsc
      0.98 ± 22%      -0.1        0.88 ± 20%      +0.2        1.13 ±  6%  perf-profile.children.cycles-pp.lapic_next_deadline
      1.65 ± 10%      -0.1        1.56 ±  9%      -0.1        1.56 ± 10%  perf-profile.children.cycles-pp.scheduler_tick
      0.90 ± 28%      -0.1        0.82 ± 30%      +0.2        1.05 ± 11%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.62 ± 38%      -0.1        0.55 ± 41%      +0.1        0.71 ± 32%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      1.02 ± 12%      -0.1        0.95 ±  9%      -0.0        1.01 ±  8%  perf-profile.children.cycles-pp.rebalance_domains
     60.60 ±  9%      -0.0       60.55 ±  7%      -6.5       54.06 ±  5%  perf-profile.children.cycles-pp.cpuidle_enter
      0.30 ± 29%      -0.0        0.25 ± 20%      +0.0        0.31 ± 24%  perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
     60.57 ±  9%      -0.0       60.53 ±  7%      -6.6       54.02 ±  5%  perf-profile.children.cycles-pp.cpuidle_enter_state
      0.60 ±  8%      -0.0        0.56 ± 13%      -0.0        0.57 ±  8%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.30 ± 28%      -0.0        0.26 ± 19%      +0.0        0.32 ± 23%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.29 ± 45%      -0.0        0.25 ± 18%      +0.0        0.34 ± 19%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.03 ±282%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.__mod_lruvec_page_state
      0.66 ±  7%      -0.0        0.63 ± 11%      -0.0        0.64 ± 10%  perf-profile.children.cycles-pp.load_balance
      0.03 ±282%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.page_add_new_anon_rmap
      0.04 ± 75%      -0.0        0.02 ±173%      -0.0        0.02 ±141%  perf-profile.children.cycles-pp.sched_setaffinity
      0.03 ±282%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.__mod_lruvec_state
      0.03 ±282%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.__mod_node_page_state
      0.43 ± 10%      -0.0        0.40 ± 13%      +0.0        0.44 ± 12%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.17 ± 59%      -0.0        0.14 ± 41%      +0.0        0.19 ± 61%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.03 ±282%      -0.0        0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.wp_page_copy
      0.15 ± 64%      -0.0        0.13 ± 40%      +0.0        0.17 ± 68%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.05 ± 57%      -0.0        0.02 ±119%      -0.0        0.03 ±117%  perf-profile.children.cycles-pp.schedule
      0.13 ± 75%      -0.0        0.11 ± 55%      +0.0        0.15 ± 69%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.10 ± 52%      -0.0        0.08 ± 20%      +0.0        0.12 ± 71%  perf-profile.children.cycles-pp.mmput
      0.10 ± 52%      -0.0        0.08 ± 20%      +0.0        0.12 ± 71%  perf-profile.children.cycles-pp.exit_mmap
      0.15 ± 64%      -0.0        0.13 ± 40%      +0.0        0.17 ± 67%  perf-profile.children.cycles-pp.exc_page_fault
      0.03 ± 92%      -0.0        0.01 ±174%      -0.0        0.03 ±113%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.24 ± 30%      -0.0        0.22 ± 34%      -0.1        0.16 ± 10%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.09 ± 24%      -0.0        0.07 ± 41%      -0.0        0.08 ± 49%  perf-profile.children.cycles-pp.__schedule
      0.14 ± 22%      -0.0        0.12 ± 36%      +0.0        0.14 ± 29%  perf-profile.children.cycles-pp.trigger_load_balance
      0.14 ± 69%      -0.0        0.12 ± 47%      +0.0        0.16 ± 65%  perf-profile.children.cycles-pp.handle_mm_fault
      0.37 ± 12%      -0.0        0.35 ± 17%      +0.0        0.38 ± 16%  perf-profile.children.cycles-pp._raw_spin_lock
      0.10 ± 21%      -0.0        0.08 ± 38%      -0.0        0.10 ± 23%  perf-profile.children.cycles-pp.idle_cpu
      0.95 ± 13%      -0.0        0.93 ± 17%      -0.1        0.87 ± 13%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.12 ± 49%      -0.0        0.10 ± 39%      -0.1        0.05 ± 56%  perf-profile.children.cycles-pp.irq_work_needs_cpu
      0.11 ± 21%      -0.0        0.09 ± 29%      +0.0        0.16 ± 64%  perf-profile.children.cycles-pp.bprm_execve
      0.37 ± 15%      -0.0        0.36 ± 18%      -0.0        0.37 ± 12%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.03 ±114%      -0.0        0.01 ±173%      -0.0        0.00        perf-profile.children.cycles-pp.__intel_pmu_disable_all
      0.44 ± 10%      -0.0        0.42 ± 13%      -0.1        0.37 ± 12%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.08 ± 19%      -0.0        0.06 ± 37%      -0.0        0.06 ± 80%  perf-profile.children.cycles-pp.process_interval
      0.03 ±184%      -0.0        0.02 ±142%      -0.0        0.02 ±187%  perf-profile.children.cycles-pp.unmap_page_range
      0.17 ± 21%      -0.0        0.16 ± 22%      -0.0        0.14 ± 16%  perf-profile.children.cycles-pp.error_entry
      0.04 ± 60%      -0.0        0.03 ±101%      +0.0        0.05 ± 59%  perf-profile.children.cycles-pp.do_filp_open
      0.08 ± 20%      -0.0        0.06 ± 37%      -0.0        0.06 ± 65%  perf-profile.children.cycles-pp.__libc_start_main
      0.08 ± 20%      -0.0        0.06 ± 37%      -0.0        0.06 ± 65%  perf-profile.children.cycles-pp.run_builtin
      0.14 ± 22%      -0.0        0.13 ± 23%      +0.0        0.18 ± 57%  perf-profile.children.cycles-pp.do_execveat_common
      0.08 ± 19%      -0.0        0.06 ± 37%      -0.0        0.06 ± 80%  perf-profile.children.cycles-pp.cmd_stat
      0.08 ± 19%      -0.0        0.06 ± 37%      -0.0        0.06 ± 80%  perf-profile.children.cycles-pp.dispatch_events
      0.04 ± 91%      -0.0        0.02 ±118%      +0.1        0.09 ± 99%  perf-profile.children.cycles-pp.begin_new_exec
      0.09 ± 22%      -0.0        0.08 ± 30%      +0.0        0.14 ± 71%  perf-profile.children.cycles-pp.load_elf_binary
      0.05 ± 58%      -0.0        0.03 ±108%      -0.0        0.01 ±187%  perf-profile.children.cycles-pp.update_dl_rq_load_avg
      0.04 ± 57%      -0.0        0.03 ±101%      +0.0        0.05 ± 59%  perf-profile.children.cycles-pp.path_openat
      0.14 ± 22%      -0.0        0.13 ± 23%      +0.0        0.18 ± 56%  perf-profile.children.cycles-pp.__x64_sys_execve
      0.10 ± 22%      -0.0        0.08 ± 30%      +0.0        0.14 ± 71%  perf-profile.children.cycles-pp.exec_binprm
      0.07 ± 95%      -0.0        0.05 ± 49%      -0.0        0.05 ± 57%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.07 ± 95%      -0.0        0.05 ± 49%      -0.0        0.05 ± 57%  perf-profile.children.cycles-pp.do_group_exit
      0.07 ± 95%      -0.0        0.05 ± 49%      -0.0        0.05 ± 57%  perf-profile.children.cycles-pp.do_exit
      0.46 ±  9%      -0.0        0.45 ± 14%      +0.0        0.46 ± 13%  perf-profile.children.cycles-pp.find_busiest_group
      0.08 ± 65%      -0.0        0.06 ± 91%      +0.0        0.10 ± 75%  perf-profile.children.cycles-pp.note_gp_changes
      0.07 ± 22%      -0.0        0.06 ± 37%      -0.0        0.05 ± 79%  perf-profile.children.cycles-pp.read_counters
      0.02 ±141%      -0.0        0.00 ±331%      -0.0        0.01 ±190%  perf-profile.children.cycles-pp.setlocale
      0.40 ± 23%      -0.0        0.39 ± 26%      -0.1        0.30 ± 17%  perf-profile.children.cycles-pp.rcu_idle_exit
      0.03 ±184%      -0.0        0.02 ±142%      -0.0        0.02 ±147%  perf-profile.children.cycles-pp.unmap_vmas
      0.09 ± 46%      -0.0        0.08 ± 40%      +0.0        0.09 ± 47%  perf-profile.children.cycles-pp.rcu_dynticks_eqs_enter
      0.02 ±282%      -0.0        0.01 ±223%      -0.0        0.02 ±187%  perf-profile.children.cycles-pp.zap_pte_range
      0.14 ± 21%      -0.0        0.13 ± 23%      +0.0        0.18 ± 57%  perf-profile.children.cycles-pp.execve
      0.04 ± 75%      -0.0        0.03 ±101%      +0.0        0.08 ± 22%  perf-profile.children.cycles-pp.rcu_read_unlock_strict
      0.01 ±282%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.asm_common_interrupt
      0.01 ±282%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.common_interrupt
      0.01 ±187%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.hrtimer_run_queues
      0.01 ±187%      -0.0        0.00            +0.0        0.01 ±188%  perf-profile.children.cycles-pp.try_to_wake_up
      0.32 ± 18%      -0.0        0.31 ± 21%      +0.0        0.36 ±  8%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.08 ± 62%      -0.0        0.07 ± 59%      -0.0        0.04 ± 94%  perf-profile.children.cycles-pp.x86_pmu_disable
      0.44 ± 19%      -0.0        0.44 ± 18%      -0.1        0.34 ± 13%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.01 ±190%      -0.0        0.01 ±331%      -0.0        0.00        perf-profile.children.cycles-pp.rcu_gp_kthread
      0.01 ±188%      -0.0        0.00 ±331%      +0.0        0.02 ±142%  perf-profile.children.cycles-pp.balance_fair
      0.01 ±188%      -0.0        0.00 ±331%      +0.0        0.02 ±147%  perf-profile.children.cycles-pp.newidle_balance
      0.10 ± 87%      -0.0        0.09 ± 80%      -0.1        0.03 ±113%  perf-profile.children.cycles-pp.irq_work_tick
      0.09 ± 29%      -0.0        0.09 ± 52%      -0.0        0.05 ± 56%  perf-profile.children.cycles-pp.menu_reflect
      0.15 ± 14%      -0.0        0.15 ± 17%      +0.0        0.16 ± 19%  perf-profile.children.cycles-pp.hrtimer_get_next_event
      0.01 ±187%      -0.0        0.00 ±331%      +0.0        0.02 ±112%  perf-profile.children.cycles-pp.can_stop_idle_tick
      0.05 ± 97%      -0.0        0.05 ± 76%      -0.0        0.02 ±142%  perf-profile.children.cycles-pp.do_nocb_deferred_wakeup
      0.65 ± 15%      -0.0        0.65 ± 17%      +0.1        0.75 ±  8%  perf-profile.children.cycles-pp.native_sched_clock
      0.01 ±282%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.net_rx_action
      0.01 ±282%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.__napi_poll
      0.01 ±282%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.i40e_napi_poll
      0.12 ± 19%      -0.0        0.12 ± 23%      +0.0        0.12 ± 28%  perf-profile.children.cycles-pp.main
      0.13 ± 38%      -0.0        0.13 ± 59%      +0.0        0.15 ± 54%  perf-profile.children.cycles-pp.rcu_core
      0.01 ±282%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.force_qs_rnp
      0.01 ±282%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.timerqueue_iterate_next
      0.01 ±282%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp._dl_addr
      0.01 ±282%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.enqueue_task_fair
      0.01 ±282%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.copy_strings
      0.01 ±282%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.pick_next_task_fair
      0.01 ±282%      -0.0        0.00            +0.0        0.01 ±282%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.01 ±282%      -0.0        0.00            +0.0        0.01 ±282%  perf-profile.children.cycles-pp.tlb_flush_mmu
      0.09 ± 23%      -0.0        0.09 ± 28%      +0.0        0.10 ± 22%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.07 ± 86%      -0.0        0.06 ± 56%      +0.0        0.11 ± 37%  perf-profile.children.cycles-pp.tick_sched_do_timer
      0.05 ±105%      -0.0        0.04 ± 96%      +0.0        0.08 ± 66%  perf-profile.children.cycles-pp.timekeeping_advance
      0.07 ± 53%      -0.0        0.07 ± 65%      -0.0        0.07 ± 44%  perf-profile.children.cycles-pp.get_cpu_device
      0.05 ± 72%      -0.0        0.05 ±108%      +0.0        0.07 ± 41%  perf-profile.children.cycles-pp.do_fault
      0.04 ± 78%      -0.0        0.04 ± 89%      +0.0        0.06 ± 66%  perf-profile.children.cycles-pp.do_sys_open
      0.01 ±282%      -0.0        0.00 ±331%      -0.0        0.00        perf-profile.children.cycles-pp.ksoftirqd_running
      0.11 ± 21%      -0.0        0.10 ± 23%      -0.0        0.11 ± 14%  perf-profile.children.cycles-pp._find_next_bit
      0.20 ± 22%      -0.0        0.20 ± 18%      +0.0        0.22 ± 13%  perf-profile.children.cycles-pp.rw_verify_area
      0.04 ± 79%      -0.0        0.04 ± 89%      +0.0        0.06 ± 66%  perf-profile.children.cycles-pp.do_sys_openat2
      0.24 ± 33%      -0.0        0.23 ± 39%      -0.1        0.14 ± 32%  perf-profile.children.cycles-pp.ret_from_fork
      0.01 ±188%      -0.0        0.01 ±223%      +0.0        0.03 ± 93%  perf-profile.children.cycles-pp.link_path_walk
      0.07 ± 68%      -0.0        0.06 ± 51%      -0.0        0.02 ±192%  perf-profile.children.cycles-pp.rcu_eqs_enter
      0.03 ±112%      -0.0        0.03 ±123%      +0.0        0.03 ± 90%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      0.05 ± 94%      -0.0        0.05 ± 74%      -0.1        0.00        perf-profile.children.cycles-pp.intel_pmu_disable_all
      0.01 ±282%      -0.0        0.00 ±331%      -0.0        0.00        perf-profile.children.cycles-pp.timer_clear_idle
      0.01 ±282%      -0.0        0.00 ±331%      +0.0        0.01 ±282%  perf-profile.children.cycles-pp.tick_nohz_idle_retain_tick
      0.01 ±282%      -0.0        0.00 ±331%      +0.0        0.01 ±282%  perf-profile.children.cycles-pp.schedule_idle
      0.23 ± 35%      -0.0        0.23 ± 40%      -0.1        0.13 ± 33%  perf-profile.children.cycles-pp.kthread
      0.01 ±187%      -0.0        0.01 ±227%      +0.0        0.02 ±142%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      0.01 ±187%      -0.0        0.01 ±227%      +0.0        0.02 ±144%  perf-profile.children.cycles-pp.update_group_capacity
      0.01 ±282%      -0.0        0.01 ±331%      +0.0        0.01 ±187%  perf-profile.children.cycles-pp.next_uptodate_page
      0.01 ±282%      -0.0        0.01 ±331%      -0.0        0.00        perf-profile.children.cycles-pp.__note_gp_changes
      0.01 ±282%      -0.0        0.01 ±331%      -0.0        0.00        perf-profile.children.cycles-pp.tick_nohz_idle_got_tick
      0.03 ±113%      -0.0        0.02 ±122%      +0.0        0.03 ± 91%  perf-profile.children.cycles-pp.do_mmap
      0.01 ±187%      -0.0        0.01 ±230%      -0.0        0.00        perf-profile.children.cycles-pp.perf_ctx_unlock
      0.25 ± 24%      -0.0        0.25 ± 26%      -0.0        0.20 ± 23%  perf-profile.children.cycles-pp.rcu_eqs_exit
      0.00            +0.0        0.00            +0.0        0.01 ±282%  perf-profile.children.cycles-pp.read@plt
      0.00            +0.0        0.00            +0.0        0.01 ±282%  perf-profile.children.cycles-pp.page_remove_rmap
      0.00            +0.0        0.00            +0.0        0.01 ±282%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      0.00            +0.0        0.00            +0.0        0.01 ±282%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.00            +0.0        0.00            +0.0        0.01 ±282%  perf-profile.children.cycles-pp.__lookup_slow
      0.00            +0.0        0.00            +0.0        0.01 ±282%  perf-profile.children.cycles-pp.rcu_do_batch
      0.00            +0.0        0.00            +0.0        0.01 ±282%  perf-profile.children.cycles-pp.timekeeping_update
      0.00            +0.0        0.00            +0.0        0.01 ±282%  perf-profile.children.cycles-pp.cpuidle_select
      0.00            +0.0        0.00            +0.0        0.01 ±282%  perf-profile.children.cycles-pp.path_lookupat
      0.00            +0.0        0.00            +0.0        0.01 ±282%  perf-profile.children.cycles-pp.release_pages
      0.00            +0.0        0.00            +0.0        0.01 ±282%  perf-profile.children.cycles-pp.filename_lookup
      0.00            +0.0        0.00            +0.0        0.03 ±282%  perf-profile.children.cycles-pp.unlink_anon_vmas
      0.00            +0.0        0.00            +0.0        0.03 ±282%  perf-profile.children.cycles-pp.free_pgtables
      0.01 ±282%      +0.0        0.01 ±224%      -0.0        0.00        perf-profile.children.cycles-pp.arch_cpu_idle_exit
      0.12 ± 15%      +0.0        0.12 ± 20%      +0.0        0.12 ± 15%  perf-profile.children.cycles-pp.cpumask_next_and
      0.02 ±197%      +0.0        0.02 ±146%      +0.0        0.04 ± 74%  perf-profile.children.cycles-pp.profile_tick
      0.02 ±142%      +0.0        0.02 ±145%      +0.0        0.02 ±143%  perf-profile.children.cycles-pp.mmap_region
      0.06 ± 95%      +0.0        0.06 ± 75%      -0.0        0.02 ±142%  perf-profile.children.cycles-pp.tick_check_broadcast_expired
      0.12 ± 24%      +0.0        0.12 ± 24%      -0.0        0.09 ± 36%  perf-profile.children.cycles-pp.tick_nohz_tick_stopped
      0.06 ± 45%      +0.0        0.06 ± 65%      +0.0        0.07 ± 42%  perf-profile.children.cycles-pp.irqentry_exit
      0.04 ± 91%      +0.0        0.04 ±106%      +0.0        0.06 ± 42%  perf-profile.children.cycles-pp.filemap_map_pages
      0.77 ± 13%      +0.0        0.77 ± 15%      +0.1        0.88 ±  7%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.32 ± 12%      +0.0        0.32 ± 16%      +0.0        0.36 ± 16%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.09 ± 63%      +0.0        0.10 ± 44%      -0.1        0.03 ±114%  perf-profile.children.cycles-pp.irqtime_account_process_tick
      0.14 ± 66%      +0.0        0.14 ± 49%      -0.1        0.03 ±112%  perf-profile.children.cycles-pp.native_apic_mem_write
      0.01 ±187%      +0.0        0.02 ±177%      -0.0        0.01 ±282%  perf-profile.children.cycles-pp.account_process_tick
      0.02 ±114%      +0.0        0.03 ±122%      -0.0        0.00        perf-profile.children.cycles-pp.rcu_needs_cpu
      0.01 ±282%      +0.0        0.01 ±224%      +0.0        0.01 ±282%  perf-profile.children.cycles-pp.sched_clock_idle_wakeup_event
      0.01 ±282%      +0.0        0.01 ±224%      +0.0        0.02 ±145%  perf-profile.children.cycles-pp.walk_component
      0.05 ± 92%      +0.0        0.05 ± 73%      -0.0        0.01 ±282%  perf-profile.children.cycles-pp.restore_regs_and_return_to_kernel
      0.00            +0.0        0.00 ±331%      +0.0        0.00        perf-profile.children.cycles-pp.cpu_latency_qos_limit
      0.00            +0.0        0.00 ±331%      +0.0        0.00        perf-profile.children.cycles-pp.rcu_segcblist_ready_cbs
      0.00            +0.0        0.00 ±331%      +0.0        0.00        perf-profile.children.cycles-pp.__libc_read
      0.00            +0.0        0.00 ±331%      +0.0        0.03 ±282%  perf-profile.children.cycles-pp.do_anonymous_page
      0.02 ±143%      +0.0        0.02 ±145%      -0.0        0.01 ±187%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.01 ±282%      +0.0        0.01 ±223%      +0.0        0.02 ±111%  perf-profile.children.cycles-pp.dup_mm
      0.17 ± 40%      +0.0        0.18 ± 18%      -0.1        0.10 ± 17%  perf-profile.children.cycles-pp.rb_next
      0.00            +0.0        0.01 ±331%      +0.0        0.00        perf-profile.children.cycles-pp.__alloc_pages
      0.28 ± 27%      +0.0        0.29 ± 18%      -0.0        0.24 ± 13%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.00            +0.0        0.01 ±331%      +0.0        0.00        perf-profile.children.cycles-pp.cpuidle_get_cpu_driver
      0.03 ± 90%      +0.0        0.04 ± 74%      -0.0        0.01 ±282%  perf-profile.children.cycles-pp.hrtimer_forward
      0.45 ± 29%      +0.0        0.46 ± 39%      -0.1        0.34 ± 19%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.05 ± 77%      +0.0        0.06 ± 49%      +0.0        0.07 ± 63%  perf-profile.children.cycles-pp.__x64_sys_write
      0.04 ± 92%      +0.0        0.05 ± 95%      -0.0        0.01 ±282%  perf-profile.children.cycles-pp.pm_qos_read_value
      0.03 ±114%      +0.0        0.04 ± 86%      +0.0        0.04 ± 72%  perf-profile.children.cycles-pp.kill_fasync
      0.01 ±187%      +0.0        0.02 ±142%      -0.0        0.00        perf-profile.children.cycles-pp.rcu_nocb_flush_deferred_wakeup
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.io_serial_out
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.error_return
      0.02 ±143%      +0.0        0.03 ±121%      -0.0        0.00        perf-profile.children.cycles-pp.leave_mm
      0.01 ±187%      +0.0        0.02 ±142%      +0.0        0.02 ±143%  perf-profile.children.cycles-pp.sched_clock
      0.00            +0.0        0.01 ±223%      +0.0        0.02 ±141%  perf-profile.children.cycles-pp.dup_mmap
      0.11 ± 56%      +0.0        0.12 ± 47%      -0.1        0.04 ± 72%  perf-profile.children.cycles-pp.rb_insert_color
      0.26 ± 17%      +0.0        0.27 ± 12%      +0.0        0.29 ± 12%  perf-profile.children.cycles-pp.rcu_all_qs
      0.01 ±188%      +0.0        0.02 ±119%      -0.0        0.00        perf-profile.children.cycles-pp.rcu_is_cpu_rrupt_from_idle
      0.06 ± 41%      +0.0        0.07 ± 41%      +0.0        0.08 ± 25%  perf-profile.children.cycles-pp.__libc_fork
      0.11 ± 26%      +0.0        0.13 ± 28%      -0.0        0.09 ± 45%  perf-profile.children.cycles-pp.rcu_dynticks_eqs_exit
      0.27 ± 26%      +0.0        0.28 ± 23%      +0.1        0.34 ± 18%  perf-profile.children.cycles-pp.make_kuid
      0.35 ± 22%      +0.0        0.37 ± 19%      -0.1        0.29 ±  8%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.58 ± 21%      +0.0        0.60 ± 14%      +0.0        0.60 ± 13%  perf-profile.children.cycles-pp.__might_fault
      0.30 ± 32%      +0.0        0.32 ± 35%      -0.1        0.16 ± 15%  perf-profile.children.cycles-pp.enqueue_hrtimer
      0.26 ± 16%      +0.0        0.27 ± 15%      +0.0        0.26 ± 18%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.27 ± 34%      +0.0        0.29 ± 36%      -0.1        0.14 ± 18%  perf-profile.children.cycles-pp.timerqueue_add
      0.16 ± 27%      +0.0        0.18 ± 23%      +0.1        0.21 ± 18%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.43 ± 17%      +0.0        0.45 ± 14%      -0.0        0.39 ± 13%  perf-profile.children.cycles-pp.update_rq_clock
      0.03 ±113%      +0.0        0.04 ± 74%      +0.0        0.04 ± 92%  perf-profile.children.cycles-pp.rcu_nmi_exit
      0.33 ± 23%      +0.0        0.35 ± 19%      -0.0        0.28 ± 10%  perf-profile.children.cycles-pp.update_blocked_averages
      0.03 ±120%      +0.0        0.05 ± 87%      -0.0        0.00        perf-profile.children.cycles-pp.check_tsc_unstable
      0.03 ±114%      +0.0        0.05 ± 72%      -0.0        0.00        perf-profile.children.cycles-pp.rcu_irq_enter
      0.13 ± 19%      +0.0        0.15 ± 18%      +0.0        0.16 ± 19%  perf-profile.children.cycles-pp.call_cpuidle
      0.42 ± 29%      +0.0        0.44 ± 23%      -0.1        0.31 ± 16%  perf-profile.children.cycles-pp.hrtimer_update_next_event
      0.05 ± 89%      +0.0        0.07 ± 80%      -0.0        0.01 ±187%  perf-profile.children.cycles-pp.cpuidle_not_available
      0.02 ±145%      +0.0        0.04 ± 88%      -0.0        0.00        perf-profile.children.cycles-pp.cpuidle_reflect
      0.02 ±114%      +0.0        0.04 ± 73%      -0.0        0.00        perf-profile.children.cycles-pp.task_tick_idle
      0.13 ± 70%      +0.0        0.15 ± 66%      -0.1        0.03 ± 90%  perf-profile.children.cycles-pp.drm_fb_helper_damage_work
      0.05 ± 76%      +0.0        0.07 ± 39%      +0.0        0.05 ± 57%  perf-profile.children.cycles-pp.update_rt_rq_load_avg
      0.03 ±118%      +0.0        0.05 ± 47%      +0.0        0.04 ± 92%  perf-profile.children.cycles-pp.__wake_up_sync_key
      0.00            +0.0        0.02 ±206%      +0.0        0.02 ±141%  perf-profile.children.cycles-pp.poll_idle
      0.13 ± 70%      +0.0        0.15 ± 66%      -0.1        0.03 ± 90%  perf-profile.children.cycles-pp.memcpy_toio
      0.13 ± 71%      +0.0        0.15 ± 65%      -0.1        0.03 ± 91%  perf-profile.children.cycles-pp.irqentry_enter
      0.13 ± 55%      +0.0        0.15 ± 46%      -0.1        0.02 ±197%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.20 ± 35%      +0.0        0.23 ± 27%      -0.1        0.15 ± 20%  perf-profile.children.cycles-pp.__hrtimer_get_next_event
      0.84 ± 23%      +0.0        0.86 ± 17%      +0.2        1.04 ± 11%  perf-profile.children.cycles-pp.__might_sleep
      0.74 ± 21%      +0.0        0.76 ± 21%      +0.2        0.93 ± 13%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.23 ± 31%      +0.0        0.26 ± 24%      +0.1        0.32 ± 24%  perf-profile.children.cycles-pp.ktime_get_coarse_real_ts64
      0.09 ± 23%      +0.0        0.12 ± 37%      -0.0        0.08 ± 35%  perf-profile.children.cycles-pp.rb_erase
      0.16 ± 73%      +0.0        0.18 ± 48%      -0.1        0.05 ± 55%  perf-profile.children.cycles-pp.tick_check_oneshot_broadcast_this_cpu
      0.06 ±102%      +0.0        0.09 ± 66%      -0.0        0.01 ±187%  perf-profile.children.cycles-pp.rcu_nmi_enter
      0.01 ±188%      +0.0        0.04 ± 91%      +0.0        0.05 ± 56%  perf-profile.children.cycles-pp.copy_process
      0.41 ± 23%      +0.0        0.44 ± 18%      +0.1        0.53 ± 13%  perf-profile.children.cycles-pp.map_id_range_down
      0.11 ± 79%      +0.0        0.14 ± 52%      -0.1        0.03 ± 91%  perf-profile.children.cycles-pp.delay_tsc
      0.46 ± 26%      +0.0        0.49 ± 17%      +0.2        0.65 ± 12%  perf-profile.children.cycles-pp.aa_file_perm
      0.13 ± 29%      +0.0        0.16 ± 44%      +0.0        0.16 ± 22%  perf-profile.children.cycles-pp.iov_iter_init
      0.03 ±113%      +0.0        0.06 ± 51%      +0.0        0.06 ± 43%  perf-profile.children.cycles-pp.__do_sys_clone
      0.03 ±113%      +0.0        0.06 ± 51%      +0.0        0.06 ± 43%  perf-profile.children.cycles-pp.kernel_clone
      0.15 ± 61%      +0.0        0.18 ± 46%      -0.1        0.06 ± 46%  perf-profile.children.cycles-pp.worker_thread
      0.01 ±282%      +0.0        0.04 ± 88%      -0.0        0.01 ±282%  perf-profile.children.cycles-pp.sched_idle_set_state
      0.02 ±114%      +0.0        0.06 ±206%      +0.0        0.03 ± 93%  perf-profile.children.cycles-pp.seq_read_iter
      0.00            +0.0        0.03 ±331%      +0.0        0.00        perf-profile.children.cycles-pp.node_read_vmstat
      0.28 ± 25%      +0.0        0.31 ± 19%      +0.1        0.35 ± 11%  perf-profile.children.cycles-pp.timestamp_truncate
      0.00            +0.0        0.03 ±331%      +0.0        0.00        perf-profile.children.cycles-pp.sysfs_kf_seq_show
      0.00            +0.0        0.03 ±331%      +0.0        0.00        perf-profile.children.cycles-pp.dev_attr_show
      0.14 ± 68%      +0.0        0.17 ± 46%      -0.1        0.06 ± 42%  perf-profile.children.cycles-pp.process_one_work
      0.00            +0.0        0.03 ±331%      +0.0        0.01 ±282%  perf-profile.children.cycles-pp.fold_vm_numa_events
      0.05 ± 76%      +0.0        0.08 ± 26%      +0.0        0.06 ± 58%  perf-profile.children.cycles-pp.tick_program_event
      0.30 ± 30%      +0.0        0.34 ± 33%      -0.1        0.19 ± 21%  perf-profile.children.cycles-pp.timerqueue_del
      0.17 ± 55%      +0.0        0.20 ± 40%      -0.1        0.10 ± 29%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.18 ± 76%      +0.0        0.22 ± 48%      -0.1        0.06 ± 40%  perf-profile.children.cycles-pp.update_ts_time_stats
      1.06 ± 13%      +0.0        1.10 ± 13%      +0.2        1.30 ±  6%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.02 ±112%      +0.0        0.06 ± 18%      +0.0        0.06 ± 45%  perf-profile.children.cycles-pp.__x64_sys_read
      0.38 ± 34%      +0.0        0.42 ± 35%      -0.2        0.23 ± 19%  perf-profile.children.cycles-pp.__remove_hrtimer
      0.52 ± 14%      +0.0        0.56 ± 14%      +0.1        0.62 ± 11%  perf-profile.children.cycles-pp.__cond_resched
      0.98 ± 25%      +0.0        1.02 ± 15%      -0.2        0.76 ± 34%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.21 ± 27%      +0.0        0.25 ± 19%      +0.1        0.28 ± 13%  perf-profile.children.cycles-pp.__wake_up_common
      0.30 ± 18%      +0.0        0.35 ± 18%      +0.1        0.36 ± 10%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.23 ± 24%      +0.0        0.28 ± 19%      +0.1        0.34 ± 15%  perf-profile.children.cycles-pp.make_kgid
      0.93 ± 26%      +0.0        0.98 ± 17%      -0.2        0.70 ± 38%  perf-profile.children.cycles-pp.tick_irq_enter
      0.83 ± 22%      +0.1        0.88 ± 15%      +0.2        1.01 ± 11%  perf-profile.children.cycles-pp.___might_sleep
      0.46 ± 65%      +0.1        0.52 ± 48%      -0.3        0.16 ± 23%  perf-profile.children.cycles-pp.io_serial_in
      1.12 ± 19%      +0.1        1.18 ± 17%      +0.3        1.43 ± 13%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.17 ± 69%      +0.1        0.24 ± 52%      -0.1        0.05 ± 73%  perf-profile.children.cycles-pp.run_posix_cpu_timers
      0.80 ± 22%      +0.1        0.87 ± 16%      +0.2        1.02 ± 12%  perf-profile.children.cycles-pp.current_time
      1.01 ± 19%      +0.1        1.08 ± 15%      +0.2        1.18 ±  8%  perf-profile.children.cycles-pp.mutex_unlock
      0.44 ± 21%      +0.1        0.51 ± 18%      +0.2        0.62 ± 20%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
     26.91 ± 18%      +0.1       26.99 ± 13%      +4.9       31.82 ±  8%  perf-profile.children.cycles-pp.do_syscall_64
      0.56 ± 66%      +0.1        0.65 ± 48%      -0.4        0.21 ± 14%  perf-profile.children.cycles-pp.serial8250_console_putchar
      0.58 ± 66%      +0.1        0.66 ± 47%      -0.4        0.21 ± 14%  perf-profile.children.cycles-pp.wait_for_xmitr
      0.62 ± 22%      +0.1        0.72 ± 19%      +0.2        0.83 ± 11%  perf-profile.children.cycles-pp.file_update_time
      0.58 ± 66%      +0.1        0.67 ± 47%      -0.4        0.21 ± 13%  perf-profile.children.cycles-pp.uart_console_write
      0.60 ± 65%      +0.1        0.69 ± 47%      -0.4        0.22 ± 13%  perf-profile.children.cycles-pp.serial8250_console_write
      0.62 ± 65%      +0.1        0.72 ± 46%      -0.4        0.23 ± 12%  perf-profile.children.cycles-pp.irq_work_run
      0.62 ± 65%      +0.1        0.72 ± 46%      -0.4        0.23 ± 12%  perf-profile.children.cycles-pp.printk
      0.62 ± 65%      +0.1        0.72 ± 46%      -0.4        0.23 ± 12%  perf-profile.children.cycles-pp.vprintk_emit
      0.62 ± 65%      +0.1        0.72 ± 46%      -0.4        0.23 ± 12%  perf-profile.children.cycles-pp.console_unlock
      0.62 ± 65%      +0.1        0.72 ± 46%      -0.4        0.23 ± 12%  perf-profile.children.cycles-pp.asm_sysvec_irq_work
      0.62 ± 65%      +0.1        0.72 ± 46%      -0.4        0.23 ± 12%  perf-profile.children.cycles-pp.sysvec_irq_work
      0.62 ± 65%      +0.1        0.72 ± 46%      -0.4        0.23 ± 12%  perf-profile.children.cycles-pp.__sysvec_irq_work
      0.62 ± 65%      +0.1        0.72 ± 46%      -0.4        0.23 ± 12%  perf-profile.children.cycles-pp.irq_work_single
      1.10 ± 19%      +0.1        1.20 ± 15%      +0.3        1.41 ± 12%  perf-profile.children.cycles-pp.atime_needs_update
      0.64 ± 65%      +0.1        0.74 ± 45%      -0.4        0.25 ± 12%  perf-profile.children.cycles-pp.irq_work_run_list
      1.19 ± 17%      +0.1        1.30 ± 14%      +0.3        1.45 ±  7%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      1.25 ± 19%      +0.1        1.39 ± 14%      +0.3        1.59 ± 11%  perf-profile.children.cycles-pp.touch_atime
      1.12 ± 21%      +0.1        1.26 ± 13%      +0.4        1.57 ± 14%  perf-profile.children.cycles-pp.common_file_perm
      2.06 ± 18%      +0.1        2.21 ± 15%      +0.5        2.60 ± 11%  perf-profile.children.cycles-pp.mutex_lock
      1.23 ± 16%      +0.2        1.39 ± 13%      +0.4        1.60 ±  6%  perf-profile.children.cycles-pp.__wake_up_common_lock
      1.67 ± 17%      +0.2        1.84 ± 13%      +0.4        2.04 ±  9%  perf-profile.children.cycles-pp.__fget_light
      1.76 ± 17%      +0.2        1.94 ± 16%      +0.5        2.21 ±  8%  perf-profile.children.cycles-pp.__entry_text_start
      1.94 ± 20%      +0.2        2.13 ± 14%      +0.5        2.43 ± 12%  perf-profile.children.cycles-pp.copyin
      1.95 ± 17%      +0.2        2.17 ± 14%      +0.5        2.41 ±  7%  perf-profile.children.cycles-pp.__fdget_pos
     27.76 ± 18%      +0.2       27.97 ± 13%      +5.1       32.91 ±  8%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      2.05 ± 20%      +0.2        2.29 ± 14%      +0.4        2.43 ±  9%  perf-profile.children.cycles-pp.copyout
      3.22 ± 20%      +0.2        3.47 ± 12%      +0.8        4.02 ± 11%  perf-profile.children.cycles-pp.copy_page_from_iter
      8.26 ± 19%      +0.3        8.52 ± 14%      +1.7        9.92 ±  8%  perf-profile.children.cycles-pp.pipe_read
      3.27 ± 19%      +0.3        3.58 ± 12%      +0.6        3.84 ± 10%  perf-profile.children.cycles-pp.copy_page_to_iter
     10.87 ± 18%      +0.3       11.19 ± 13%      +2.4       13.31 ±  8%  perf-profile.children.cycles-pp.vfs_write
      2.39 ± 18%      +0.3        2.71 ± 15%      +0.6        3.01 ±  8%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      8.75 ± 19%      +0.4        9.11 ± 13%      +1.8       10.51 ±  8%  perf-profile.children.cycles-pp.new_sync_read
      3.80 ± 19%      +0.4        4.22 ± 14%      +0.8        4.61 ± 10%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
     12.12 ± 18%      +0.5       12.61 ± 13%      +2.7       14.84 ±  8%  perf-profile.children.cycles-pp.ksys_write
     40.83 ± 12%      +0.7       41.57 ±  9%      -5.8       35.07 ± 10%  perf-profile.children.cycles-pp.intel_idle
      8.46 ± 18%      +0.8        9.22 ± 13%      +2.4       10.82 ±  8%  perf-profile.children.cycles-pp.pipe_write
      8.99 ± 18%      +0.8        9.78 ± 13%      +2.5       11.46 ±  8%  perf-profile.children.cycles-pp.new_sync_write
      0.51 ± 32%      +0.9        1.42 ±205%      +0.0        0.54 ± 13%  perf-profile.children.cycles-pp.start_kernel
      1.41 ± 22%      -1.4        0.00            -1.4        0.00        perf-profile.self.cycles-pp.fsnotify
      2.41 ± 52%      -0.3        2.07 ± 70%      +0.8        3.26 ± 34%  perf-profile.self.cycles-pp.ktime_get
      0.95 ± 60%      -0.3        0.66 ± 90%      +0.5        1.47 ± 22%  perf-profile.self.cycles-pp.timekeeping_max_deferment
      0.57 ± 23%      -0.3        0.30 ± 22%      +0.2        0.73 ± 17%  perf-profile.self.cycles-pp.anon_pipe_buf_release
      2.15 ± 11%      -0.2        1.96 ± 22%      +0.0        2.15 ±  6%  perf-profile.self.cycles-pp.menu_select
      0.49 ± 35%      -0.1        0.34 ± 57%      +0.1        0.61 ± 23%  perf-profile.self.cycles-pp.calc_global_load_tick
      0.56 ± 40%      -0.1        0.42 ± 40%      +0.1        0.64 ± 19%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.98 ± 22%      -0.1        0.88 ± 20%      +0.1        1.13 ±  6%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.71 ± 12%      -0.1        0.61 ± 18%      +0.1        0.76 ± 14%  perf-profile.self.cycles-pp.read_tsc
      0.60 ± 22%      -0.1        0.51 ± 11%      +0.1        0.70 ±  7%  perf-profile.self.cycles-pp.vfs_read
      0.55 ± 33%      -0.1        0.46 ± 33%      +0.0        0.57 ± 32%  perf-profile.self.cycles-pp.update_process_times
      2.44 ±  8%      -0.1        2.37 ± 11%      +0.0        2.48 ±  9%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.89 ± 28%      -0.1        0.82 ± 30%      +0.2        1.05 ± 11%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.25 ± 39%      -0.1        0.20 ± 31%      +0.1        0.31 ± 25%  perf-profile.self.cycles-pp.tsc_verify_tsc_adjust
      0.40 ± 22%      -0.1        0.35 ± 20%      +0.2        0.59 ± 11%  perf-profile.self.cycles-pp.security_file_permission
      1.08 ± 17%      -0.0        1.04 ± 22%      +0.2        1.25 ±  6%  perf-profile.self.cycles-pp.pipe_read
      0.57 ± 18%      -0.0        0.54 ± 21%      +0.1        0.69 ± 14%  perf-profile.self.cycles-pp.vfs_write
      0.31 ± 12%      -0.0        0.28 ± 13%      -0.0        0.31 ± 14%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.46 ± 45%      -0.0        0.43 ± 49%      +0.1        0.59 ± 41%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.09 ± 27%      -0.0        0.06 ± 41%      -0.0        0.04 ± 74%  perf-profile.self.cycles-pp.cpuidle_governor_latency_req
      0.36 ± 29%      -0.0        0.34 ± 21%      +0.1        0.47 ± 16%  perf-profile.self.cycles-pp.do_syscall_64
      0.26 ± 19%      -0.0        0.24 ± 29%      -0.1        0.21 ±  9%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.10 ± 54%      -0.0        0.08 ± 54%      -0.1        0.04 ± 74%  perf-profile.self.cycles-pp.irq_work_needs_cpu
      0.09 ± 25%      -0.0        0.06 ± 52%      -0.0        0.07 ± 42%  perf-profile.self.cycles-pp.tick_nohz_get_sleep_length
      0.36 ± 13%      -0.0        0.34 ± 17%      +0.0        0.37 ± 15%  perf-profile.self.cycles-pp._raw_spin_lock
      0.41 ± 28%      -0.0        0.38 ± 41%      -0.1        0.31 ± 16%  perf-profile.self.cycles-pp.rcu_sched_clock_irq
      0.27 ± 27%      -0.0        0.24 ± 18%      +0.0        0.31 ± 17%  perf-profile.self.cycles-pp.write
      0.13 ± 32%      -0.0        0.11 ± 49%      +0.0        0.14 ± 36%  perf-profile.self.cycles-pp.__softirqentry_text_start
      0.08 ± 25%      -0.0        0.06 ± 48%      -0.0        0.07 ± 44%  perf-profile.self.cycles-pp.tick_sched_timer
      0.27 ± 48%      -0.0        0.25 ± 18%      +0.1        0.34 ± 19%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.12 ± 24%      -0.0        0.11 ± 37%      +0.0        0.13 ± 25%  perf-profile.self.cycles-pp.trigger_load_balance
      0.11 ± 22%      -0.0        0.10 ± 37%      -0.0        0.10 ± 31%  perf-profile.self.cycles-pp.rcu_idle_exit
      0.15 ± 31%      -0.0        0.13 ± 44%      -0.0        0.11 ± 23%  perf-profile.self.cycles-pp.rcu_eqs_exit
      0.10 ± 21%      -0.0        0.08 ± 38%      +0.0        0.10 ± 23%  perf-profile.self.cycles-pp.idle_cpu
      0.03 ± 96%      -0.0        0.02 ±142%      +0.0        0.06 ± 58%  perf-profile.self.cycles-pp.rcu_read_unlock_strict
      0.01 ±187%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.__intel_pmu_disable_all
      0.05 ± 58%      -0.0        0.03 ±108%      -0.0        0.01 ±187%  perf-profile.self.cycles-pp.update_dl_rq_load_avg
      0.15 ± 20%      -0.0        0.14 ± 21%      -0.0        0.12 ± 17%  perf-profile.self.cycles-pp.error_entry
      0.15 ± 21%      -0.0        0.14 ± 29%      -0.0        0.12 ± 28%  perf-profile.self.cycles-pp.__sysvec_apic_timer_interrupt
      0.09 ± 46%      -0.0        0.08 ± 40%      +0.0        0.09 ± 47%  perf-profile.self.cycles-pp.rcu_dynticks_eqs_enter
      0.13 ± 24%      -0.0        0.12 ± 22%      -0.0        0.11 ± 20%  perf-profile.self.cycles-pp.rebalance_domains
      0.01 ±187%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.hrtimer_run_queues
      0.05 ± 96%      -0.0        0.04 ± 90%      -0.0        0.01 ±187%  perf-profile.self.cycles-pp.do_nocb_deferred_wakeup
      0.14 ± 28%      -0.0        0.13 ± 28%      +0.0        0.14 ± 19%  perf-profile.self.cycles-pp.__might_fault
      0.08 ± 21%      -0.0        0.07 ± 18%      -0.0        0.06 ± 45%  perf-profile.self.cycles-pp.hrtimer_next_event_without
      0.32 ± 18%      -0.0        0.31 ± 21%      +0.0        0.36 ±  8%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.13 ± 21%      -0.0        0.12 ± 26%      -0.0        0.11 ± 20%  perf-profile.self.cycles-pp.load_balance
      0.20 ± 30%      -0.0        0.19 ± 35%      -0.0        0.15 ± 28%  perf-profile.self.cycles-pp.perf_mux_hrtimer_handler
      0.08 ± 62%      -0.0        0.07 ± 59%      -0.0        0.04 ± 94%  perf-profile.self.cycles-pp.x86_pmu_disable
      0.11 ± 29%      -0.0        0.10 ± 55%      -0.1        0.04 ± 72%  perf-profile.self.cycles-pp.timerqueue_del
      0.63 ± 16%      -0.0        0.62 ± 19%      +0.1        0.73 ±  8%  perf-profile.self.cycles-pp.native_sched_clock
      0.01 ±187%      -0.0        0.00 ±331%      +0.0        0.02 ±112%  perf-profile.self.cycles-pp.can_stop_idle_tick
      0.27 ± 11%      -0.0        0.27 ± 28%      -0.1        0.20 ± 14%  perf-profile.self.cycles-pp.__hrtimer_run_queues
      0.09 ± 50%      -0.0        0.09 ± 20%      +0.0        0.11 ± 25%  perf-profile.self.cycles-pp.copyout
      0.09 ± 88%      -0.0        0.08 ± 78%      -0.1        0.02 ±112%  perf-profile.self.cycles-pp.irq_work_tick
      0.11 ± 21%      -0.0        0.10 ± 23%      -0.0        0.10 ± 12%  perf-profile.self.cycles-pp._find_next_bit
      0.02 ±112%      -0.0        0.02 ±144%      -0.0        0.02 ±187%  perf-profile.self.cycles-pp.note_gp_changes
      0.01 ±282%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp._dl_addr
      0.01 ±282%      -0.0        0.00            +0.0        0.01 ±282%  perf-profile.self.cycles-pp.tick_nohz_idle_retain_tick
      0.01 ±282%      -0.0        0.00            +0.0        0.03 ±119%  perf-profile.self.cycles-pp.cpuidle_enter
      0.06 ± 67%      -0.0        0.06 ± 63%      -0.0        0.02 ±190%  perf-profile.self.cycles-pp.rcu_eqs_enter
      0.24 ± 16%      -0.0        0.23 ± 18%      +0.1        0.29 ± 16%  perf-profile.self.cycles-pp.hrtimer_interrupt
      0.10 ± 22%      -0.0        0.09 ± 49%      -0.0        0.08 ± 24%  perf-profile.self.cycles-pp.update_blocked_averages
      0.01 ±188%      -0.0        0.01 ±223%      +0.0        0.01 ±188%  perf-profile.self.cycles-pp.find_busiest_group
      0.01 ±282%      -0.0        0.00 ±331%      -0.0        0.00        perf-profile.self.cycles-pp.ksoftirqd_running
      0.07 ± 53%      -0.0        0.07 ± 65%      -0.0        0.06 ± 42%  perf-profile.self.cycles-pp.get_cpu_device
      0.15 ± 31%      -0.0        0.15 ± 37%      -0.1        0.08 ± 18%  perf-profile.self.cycles-pp.sysvec_apic_timer_interrupt
      0.15 ± 30%      -0.0        0.15 ± 24%      +0.0        0.20 ± 18%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.01 ±282%      -0.0        0.00 ±331%      -0.0        0.00        perf-profile.self.cycles-pp.timer_clear_idle
      0.01 ±187%      -0.0        0.01 ±227%      +0.0        0.02 ±144%  perf-profile.self.cycles-pp.update_group_capacity
      0.01 ±282%      -0.0        0.01 ±331%      +0.0        0.01 ±187%  perf-profile.self.cycles-pp.next_uptodate_page
      0.01 ±190%      -0.0        0.01 ±173%      -0.0        0.00        perf-profile.self.cycles-pp.intel_pmu_disable_all
      0.12 ± 45%      -0.0        0.12 ± 39%      -0.0        0.09 ± 21%  perf-profile.self.cycles-pp.get_next_timer_interrupt
      0.01 ±282%      -0.0        0.01 ±331%      -0.0        0.00        perf-profile.self.cycles-pp.tick_nohz_idle_got_tick
      0.00            +0.0        0.00            +0.0        0.01 ±187%  perf-profile.self.cycles-pp.__wake_up_sync_key
      0.02 ±145%      +0.0        0.02 ±119%      +0.0        0.04 ± 72%  perf-profile.self.cycles-pp.make_kuid
      0.02 ±197%      +0.0        0.02 ±146%      +0.0        0.04 ± 74%  perf-profile.self.cycles-pp.profile_tick
      0.07 ± 69%      +0.0        0.08 ± 26%      -0.1        0.02 ±150%  perf-profile.self.cycles-pp.hrtimer_update_next_event
      0.04 ± 92%      +0.0        0.04 ± 85%      -0.0        0.00        perf-profile.self.cycles-pp.restore_regs_and_return_to_kernel
      0.06 ± 96%      +0.0        0.06 ± 76%      -0.0        0.01 ±188%  perf-profile.self.cycles-pp.tick_check_broadcast_expired
      0.18 ± 22%      +0.0        0.18 ± 20%      +0.0        0.21 ± 15%  perf-profile.self.cycles-pp.rw_verify_area
      0.01 ±190%      +0.0        0.02 ±179%      +0.0        0.03 ± 91%  perf-profile.self.cycles-pp.__x64_sys_write
      0.09 ± 62%      +0.0        0.10 ± 46%      -0.1        0.03 ±114%  perf-profile.self.cycles-pp.irqtime_account_process_tick
      0.10 ± 29%      +0.0        0.10 ± 23%      -0.0        0.08 ± 22%  perf-profile.self.cycles-pp.irq_exit_rcu
      0.32 ± 12%      +0.0        0.32 ± 16%      +0.0        0.36 ± 16%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.17 ± 30%      +0.0        0.17 ± 41%      -0.1        0.09 ± 23%  perf-profile.self.cycles-pp.timerqueue_add
      0.31 ± 25%      +0.0        0.32 ± 17%      +0.1        0.37 ± 16%  perf-profile.self.cycles-pp.current_time
      0.01 ±188%      +0.0        0.02 ±175%      -0.0        0.01 ±282%  perf-profile.self.cycles-pp.account_process_tick
      0.10 ± 19%      +0.0        0.11 ± 36%      -0.0        0.10 ± 32%  perf-profile.self.cycles-pp.sched_clock_cpu
      0.00            +0.0        0.00 ±331%      +0.0        0.00        perf-profile.self.cycles-pp.hrtimer_get_next_event
      0.00            +0.0        0.00 ±331%      +0.0        0.00        perf-profile.self.cycles-pp.__note_gp_changes
      0.00            +0.0        0.00 ±331%      +0.0        0.00        perf-profile.self.cycles-pp.run_rebalance_domains
      0.00            +0.0        0.00 ±331%      +0.0        0.00        perf-profile.self.cycles-pp.enqueue_hrtimer
      0.00            +0.0        0.00 ±331%      +0.0        0.00        perf-profile.self.cycles-pp.rcu_segcblist_ready_cbs
      0.00            +0.0        0.00 ±331%      +0.0        0.01 ±282%  perf-profile.self.cycles-pp.fold_vm_numa_events
      0.00            +0.0        0.00 ±331%      +0.0        0.03 ±114%  perf-profile.self.cycles-pp.timekeeping_advance
      0.16 ± 31%      +0.0        0.16 ± 33%      -0.1        0.08 ± 41%  perf-profile.self.cycles-pp.scheduler_tick
      0.02 ±144%      +0.0        0.02 ±144%      -0.0        0.00        perf-profile.self.cycles-pp.rcu_needs_cpu
      0.02 ±142%      +0.0        0.02 ±145%      -0.0        0.01 ±187%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.18 ± 12%      +0.0        0.18 ± 22%      +0.0        0.21 ± 11%  perf-profile.self.cycles-pp.rcu_all_qs
      0.01 ±282%      +0.0        0.01 ±230%      -0.0        0.00        perf-profile.self.cycles-pp.perf_ctx_unlock
      0.02 ±112%      +0.0        0.03 ±103%      -0.0        0.01 ±282%  perf-profile.self.cycles-pp.hrtimer_forward
      0.00            +0.0        0.01 ±331%      +0.0        0.00        perf-profile.self.cycles-pp.cpuidle_get_cpu_driver
      0.28 ± 27%      +0.0        0.28 ± 18%      -0.0        0.24 ± 13%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.01 ±187%      +0.0        0.02 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.rcu_core
      0.08 ± 24%      +0.0        0.08 ± 27%      -0.0        0.06 ± 58%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.08 ± 41%      +0.0        0.09 ± 23%      -0.0        0.07 ± 54%  perf-profile.self.cycles-pp.tick_nohz_tick_stopped
      0.04 ± 92%      +0.0        0.05 ± 95%      -0.0        0.01 ±282%  perf-profile.self.cycles-pp.pm_qos_read_value
      0.43 ± 22%      +0.0        0.43 ± 14%      +0.1        0.52 ± 13%  perf-profile.self.cycles-pp.new_sync_read
      0.03 ±114%      +0.0        0.04 ± 86%      +0.0        0.04 ± 72%  perf-profile.self.cycles-pp.kill_fasync
      0.13 ± 76%      +0.0        0.14 ± 50%      -0.1        0.03 ±113%  perf-profile.self.cycles-pp.native_apic_mem_write
      0.08 ± 41%      +0.0        0.09 ± 36%      +0.0        0.12 ± 20%  perf-profile.self.cycles-pp.copyin
      0.03 ±115%      +0.0        0.04 ± 73%      -0.0        0.01 ±187%  perf-profile.self.cycles-pp.tick_sched_handle
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.io_serial_out
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.error_return
      0.18 ± 30%      +0.0        0.18 ± 34%      +0.0        0.19 ± 25%  perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.01 ±282%      +0.0        0.01 ±174%      -0.0        0.00        perf-profile.self.cycles-pp.rcu_nocb_flush_deferred_wakeup
      0.02 ±143%      +0.0        0.03 ±101%      +0.0        0.06 ± 56%  perf-profile.self.cycles-pp.irq_enter_rcu
      0.02 ±142%      +0.0        0.03 ±122%      -0.0        0.00        perf-profile.self.cycles-pp.leave_mm
      0.05 ± 95%      +0.0        0.06 ± 80%      -0.1        0.00        perf-profile.self.cycles-pp.irqentry_enter
      0.02 ±143%      +0.0        0.03 ±101%      -0.0        0.00        perf-profile.self.cycles-pp.tick_nohz_irq_exit
      0.10 ± 56%      +0.0        0.11 ± 47%      -0.1        0.03 ± 91%  perf-profile.self.cycles-pp.rb_insert_color
      0.01 ±188%      +0.0        0.02 ±119%      -0.0        0.00        perf-profile.self.cycles-pp.rcu_irq_enter
      0.24 ± 18%      +0.0        0.25 ± 16%      -0.0        0.24 ± 17%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.07 ± 87%      +0.0        0.08 ± 72%      -0.0        0.03 ±118%  perf-profile.self.cycles-pp.__remove_hrtimer
      0.13 ± 31%      +0.0        0.15 ± 31%      -0.0        0.09 ± 20%  perf-profile.self.cycles-pp.__hrtimer_get_next_event
      0.12 ± 18%      +0.0        0.14 ± 20%      +0.0        0.15 ± 20%  perf-profile.self.cycles-pp.call_cpuidle
      0.45 ± 21%      +0.0        0.46 ± 18%      +0.1        0.53 ± 12%  perf-profile.self.cycles-pp.new_sync_write
      0.09 ± 25%      +0.0        0.10 ± 24%      -0.0        0.09 ± 47%  perf-profile.self.cycles-pp.clockevents_program_event
      0.02 ±142%      +0.0        0.03 ±105%      +0.0        0.05 ± 56%  perf-profile.self.cycles-pp.make_kgid
      0.05 ± 96%      +0.0        0.06 ± 57%      -0.0        0.01 ±187%  perf-profile.self.cycles-pp.menu_reflect
      0.26 ± 18%      +0.0        0.27 ± 17%      +0.1        0.32 ± 17%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.35 ± 23%      +0.0        0.36 ± 20%      -0.1        0.27 ± 14%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.05 ± 89%      +0.0        0.06 ± 83%      -0.0        0.01 ±190%  perf-profile.self.cycles-pp.cpuidle_not_available
      0.00            +0.0        0.01 ±174%      +0.0        0.00        perf-profile.self.cycles-pp.rcu_is_cpu_rrupt_from_idle
      0.03 ±124%      +0.0        0.05 ± 77%      -0.0        0.00        perf-profile.self.cycles-pp.rcu_nmi_enter
      0.16 ± 38%      +0.0        0.17 ± 20%      -0.1        0.10 ± 21%  perf-profile.self.cycles-pp.rb_next
      0.03 ±117%      +0.0        0.05 ± 87%      -0.0        0.00        perf-profile.self.cycles-pp.check_tsc_unstable
      0.10 ± 24%      +0.0        0.12 ± 25%      -0.0        0.08 ± 45%  perf-profile.self.cycles-pp.rcu_dynticks_eqs_exit
      0.02 ±114%      +0.0        0.04 ± 73%      -0.0        0.00        perf-profile.self.cycles-pp.task_tick_idle
      0.07 ± 85%      +0.0        0.09 ± 46%      -0.1        0.02 ±142%  perf-profile.self.cycles-pp.update_ts_time_stats
      0.00            +0.0        0.02 ±195%      +0.0        0.02 ±141%  perf-profile.self.cycles-pp.poll_idle
      0.02 ±148%      +0.0        0.04 ± 89%      -0.0        0.00        perf-profile.self.cycles-pp.cpuidle_reflect
      0.12 ± 32%      +0.0        0.14 ± 21%      +0.0        0.14 ± 25%  perf-profile.self.cycles-pp.iov_iter_init
      0.00            +0.0        0.02 ±143%      +0.0        0.03 ±156%  perf-profile.self.cycles-pp.main
      0.42 ± 16%      +0.0        0.44 ± 16%      -0.0        0.39 ±  9%  perf-profile.self.cycles-pp.do_idle
      0.05 ± 76%      +0.0        0.07 ± 39%      +0.0        0.05 ± 57%  perf-profile.self.cycles-pp.update_rt_rq_load_avg
      0.00            +0.0        0.02 ±145%      +0.0        0.01 ±282%  perf-profile.self.cycles-pp.__x64_sys_read
      0.08 ± 33%      +0.0        0.10 ± 24%      -0.0        0.06 ± 56%  perf-profile.self.cycles-pp.update_rq_clock
      0.01 ±282%      +0.0        0.03 ±103%      -0.0        0.01 ±282%  perf-profile.self.cycles-pp.sched_idle_set_state
      0.13 ± 70%      +0.0        0.15 ± 66%      -0.1        0.03 ± 90%  perf-profile.self.cycles-pp.memcpy_toio
      0.21 ± 29%      +0.0        0.23 ± 24%      +0.1        0.30 ± 24%  perf-profile.self.cycles-pp.ktime_get_coarse_real_ts64
      0.69 ± 22%      +0.0        0.71 ± 21%      +0.2        0.88 ± 14%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.09 ± 28%      +0.0        0.11 ± 47%      -0.0        0.07 ± 47%  perf-profile.self.cycles-pp.rb_erase
      0.01 ±188%      +0.0        0.04 ± 86%      +0.0        0.04 ± 91%  perf-profile.self.cycles-pp.rcu_nmi_exit
      0.13 ± 57%      +0.0        0.15 ± 46%      -0.1        0.02 ±197%  perf-profile.self.cycles-pp.perf_event_task_tick
      0.15 ± 74%      +0.0        0.18 ± 48%      -0.1        0.04 ± 72%  perf-profile.self.cycles-pp.tick_check_oneshot_broadcast_this_cpu
      0.71 ± 25%      +0.0        0.74 ± 16%      +0.2        0.87 ± 13%  perf-profile.self.cycles-pp.__might_sleep
      0.11 ± 79%      +0.0        0.14 ± 52%      -0.1        0.03 ± 91%  perf-profile.self.cycles-pp.delay_tsc
      0.07 ± 62%      +0.0        0.10 ± 19%      -0.0        0.06 ± 39%  perf-profile.self.cycles-pp.tick_irq_enter
      0.16 ± 56%      +0.0        0.19 ± 41%      -0.1        0.09 ± 30%  perf-profile.self.cycles-pp.nr_iowait_cpu
      0.62 ± 22%      +0.0        0.65 ± 14%      +0.1        0.76 ± 12%  perf-profile.self.cycles-pp.copy_page_from_iter
      0.24 ± 20%      +0.0        0.27 ± 24%      +0.1        0.32 ± 12%  perf-profile.self.cycles-pp.read
      0.22 ± 20%      +0.0        0.26 ± 14%      +0.0        0.27 ± 21%  perf-profile.self.cycles-pp.atime_needs_update
      0.67 ± 17%      +0.0        0.70 ± 13%      +0.2        0.82 ± 14%  perf-profile.self.cycles-pp.copy_page_to_iter
      0.05 ± 75%      +0.0        0.08 ± 24%      +0.0        0.06 ± 56%  perf-profile.self.cycles-pp.tick_program_event
      0.38 ± 23%      +0.0        0.42 ± 18%      +0.1        0.49 ± 13%  perf-profile.self.cycles-pp.map_id_range_down
      0.38 ± 27%      +0.0        0.42 ± 20%      +0.1        0.52 ± 12%  perf-profile.self.cycles-pp.aa_file_perm
      0.32 ± 25%      +0.0        0.36 ± 21%      +0.1        0.40 ± 12%  perf-profile.self.cycles-pp.__fdget_pos
      0.25 ± 26%      +0.0        0.29 ± 18%      +0.1        0.32 ± 12%  perf-profile.self.cycles-pp.timestamp_truncate
      0.24 ± 18%      +0.0        0.28 ± 21%      +0.1        0.34 ± 16%  perf-profile.self.cycles-pp.file_update_time
      0.82 ± 21%      +0.0        0.86 ± 15%      +0.2        0.99 ± 12%  perf-profile.self.cycles-pp.___might_sleep
      0.24 ± 25%      +0.0        0.28 ± 24%      +0.1        0.31 ± 16%  perf-profile.self.cycles-pp.__wake_up_common_lock
      1.03 ± 13%      +0.0        1.07 ± 13%      +0.2        1.27 ±  5%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.25 ± 23%      +0.0        0.29 ± 17%      +0.1        0.30 ± 21%  perf-profile.self.cycles-pp.__cond_resched
      0.19 ± 30%      +0.0        0.24 ± 18%      +0.1        0.26 ± 15%  perf-profile.self.cycles-pp.__wake_up_common
      0.30 ± 25%      +0.0        0.34 ± 16%      +0.1        0.39 ± 21%  perf-profile.self.cycles-pp.ksys_read
      1.43 ± 21%      +0.0        1.48 ± 15%      +0.4        1.84 ±  9%  perf-profile.self.cycles-pp.pipe_write
      0.29 ± 19%      +0.0        0.34 ± 17%      +0.1        0.35 ± 11%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.14 ± 21%      +0.1        0.19 ± 18%      +0.0        0.18 ± 20%  perf-profile.self.cycles-pp.touch_atime
      0.46 ± 65%      +0.1        0.52 ± 48%      -0.3        0.16 ± 23%  perf-profile.self.cycles-pp.io_serial_in
      0.17 ± 69%      +0.1        0.24 ± 52%      -0.1        0.05 ± 73%  perf-profile.self.cycles-pp.run_posix_cpu_timers
      0.44 ± 21%      +0.1        0.51 ± 18%      +0.2        0.62 ± 20%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.95 ± 19%      +0.1        1.03 ± 16%      +0.2        1.14 ±  8%  perf-profile.self.cycles-pp.mutex_unlock
      0.29 ± 17%      +0.1        0.37 ± 18%      +0.1        0.38 ± 17%  perf-profile.self.cycles-pp.ksys_write
      0.67 ± 21%      +0.1        0.77 ± 14%      +0.3        0.97 ± 16%  perf-profile.self.cycles-pp.common_file_perm
      0.86 ± 19%      +0.1        0.98 ± 14%      +0.2        1.08 ± 12%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.14 ± 18%      +0.1        1.26 ± 13%      +0.3        1.41 ±  6%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      1.13 ± 20%      +0.1        1.26 ± 14%      +0.3        1.44 ± 15%  perf-profile.self.cycles-pp.mutex_lock
      1.61 ± 17%      +0.2        1.77 ± 13%      +0.4        1.97 ±  8%  perf-profile.self.cycles-pp.__fget_light
      1.37 ± 19%      +0.2        1.54 ± 15%      +0.3        1.72 ± 11%  perf-profile.self.cycles-pp.__entry_text_start
      2.35 ± 17%      +0.3        2.67 ± 15%      +0.6        2.96 ±  9%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      3.79 ± 20%      +0.4        4.21 ± 14%      +0.8        4.60 ± 10%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
     40.82 ± 12%      +0.7       41.56 ±  9%      -5.8       35.07 ± 10%  perf-profile.self.cycles-pp.intel_idle
    872.33 ±  2%      -2.7%     848.42            -2.6%     849.22 ±  2%  softirqs.BLOCK
      5.22 ±170%    +251.1%      18.33 ± 93%    +114.9%      11.22 ±116%  softirqs.CPU0.BLOCK
      1.00            +0.0%       1.00            +0.0%       1.00        softirqs.CPU0.HI
    497.67 ±256%     -89.2%      53.92 ±302%     -99.1%       4.44 ± 98%  softirqs.CPU0.NET_RX
      9.33 ±170%     -26.8%       6.83 ±213%     +41.7%      13.22 ±137%  softirqs.CPU0.NET_TX
     21651 ± 19%     +13.7%      24626 ± 46%      +7.3%      23227 ± 20%  softirqs.CPU0.RCU
     54004 ±  5%      +2.1%      55129 ±  2%      +2.9%      55586 ±  3%  softirqs.CPU0.SCHED
    113.33            +0.7%     114.17 ±  3%      -0.3%     113.00        softirqs.CPU0.TASKLET
      1472 ±  3%     +10.2%       1623 ± 14%      +0.8%       1484 ±  3%  softirqs.CPU0.TIMER
      4.33 ±200%    +413.5%      22.25 ±125%    +338.5%      19.00 ±106%  softirqs.CPU1.BLOCK
      1538 ±274%     -99.9%       1.83 ±283%     -99.6%       5.56 ±150%  softirqs.CPU1.NET_RX
      4.33 ±274%     -94.2%       0.25 ±238%     -92.3%       0.33 ±282%  softirqs.CPU1.NET_TX
     21072 ± 21%     +10.8%      23348 ± 52%      +4.3%      21976 ± 19%  softirqs.CPU1.RCU
     51548 ±  4%      -5.5%      48735 ± 21%      +2.0%      52598 ± 13%  softirqs.CPU1.SCHED
      0.00       +1.7e+101%       0.17 ±223% +1.1e+101%       0.11 ±282%  softirqs.CPU1.TASKLET
    538.44 ±119%     -71.1%     155.83 ±162%     -35.4%     347.78 ±165%  softirqs.CPU1.TIMER
     26.89 ±131%     +17.1%      31.50 ±240%     -27.7%      19.44 ±123%  softirqs.CPU10.BLOCK
      1.00            +0.0%       1.00            +0.0%       1.00        softirqs.CPU10.HI
    108.33 ±157%     -90.5%      10.33 ±213%     -29.2%      76.67 ±276%  softirqs.CPU10.NET_RX
      0.11 ±282%     -25.0%       0.08 ±331%    +100.0%       0.22 ±187%  softirqs.CPU10.NET_TX
     20571 ± 23%      +6.2%      21838 ± 41%      -6.1%      19313 ± 23%  softirqs.CPU10.RCU
     50168 ±  2%      -4.6%      47875 ± 17%      -2.1%      49115 ± 11%  softirqs.CPU10.SCHED
    646.78            +0.1%     647.50            +0.1%     647.11        softirqs.CPU10.TASKLET
    266.67 ±159%    +758.7%       2289 ±318%    +715.0%       2173 ±269%  softirqs.CPU10.TIMER
      1.00 ±221%   +1383.3%      14.83 ±217%   +1777.8%      18.78 ±172%  softirqs.CPU11.BLOCK
     33.11 ±203%      -9.1%      30.08 ±318%     -77.2%       7.56 ±207%  softirqs.CPU11.NET_RX
      0.00       +1.7e+101%       0.17 ±331% +1.1e+101%       0.11 ±282%  softirqs.CPU11.NET_TX
     20971 ± 23%     +12.6%      23603 ± 47%      +4.7%      21964 ± 19%  softirqs.CPU11.RCU
     50429            +2.4%      51637 ±  3%      -0.0%      50420 ±  3%  softirqs.CPU11.SCHED
      2.33 ± 28%     -17.9%       1.92 ± 14%     +85.7%       4.33 ±152%  softirqs.CPU11.TASKLET
    178.44 ±137%      -5.6%     168.50 ±177%     -39.4%     108.22 ± 75%  softirqs.CPU11.TIMER
      3.89 ±141%      +7.1%       4.17 ±276%     -91.4%       0.33 ±282%  softirqs.CPU12.BLOCK
      4.00 ±189%   +6756.2%     274.25 ±330%  +1.8e+05%       7060 ±270%  softirqs.CPU12.NET_RX
      0.44 ±111%     -43.8%       0.25 ±173%     -25.0%       0.33 ±199%  softirqs.CPU12.NET_TX
     19443 ± 28%     +15.3%      22422 ± 53%      +6.5%      20701 ± 23%  softirqs.CPU12.RCU
     49929 ±  3%      +0.5%      50185 ± 12%      +1.8%      50838 ±  3%  softirqs.CPU12.SCHED
      3.78 ±118%     -40.4%       2.25 ± 26%      +5.9%       4.00 ±141%  softirqs.CPU12.TASKLET
    889.89 ±262%     -83.3%     148.17 ±125%     -89.6%      92.89 ±108%  softirqs.CPU12.TIMER
     17.44 ±241%      -4.0%      16.75 ±225%     -93.0%       1.22 ±255%  softirqs.CPU13.BLOCK
      3504 ±277%     -99.3%      24.42 ±296%     -99.1%      32.00 ±243%  softirqs.CPU13.NET_RX
      0.56 ±123%     -10.0%       0.50 ±129%    +100.0%       1.11 ± 66%  softirqs.CPU13.NET_TX
     20901 ± 22%     +10.4%      23076 ± 50%      -1.5%      20582 ± 20%  softirqs.CPU13.RCU
     45582 ± 16%     +12.5%      51261 ±  4%     +12.1%      51099        softirqs.CPU13.SCHED
      3.78 ±144%     -36.0%       2.42 ± 61%     -38.2%       2.33 ± 63%  softirqs.CPU13.TASKLET
     79.33 ± 56%    +471.4%     453.33 ±137%    +185.9%     226.78 ±151%  softirqs.CPU13.TIMER
     14.67 ±275%     -14.8%      12.50 ±166%     -93.9%       0.89 ±282%  softirqs.CPU14.BLOCK
     81.33 ±193%   +2217.8%       1885 ±329%     -78.1%      17.78 ±266%  softirqs.CPU14.NET_RX
      0.56 ± 89%     -10.0%       0.50 ±129%     +40.0%       0.78 ± 80%  softirqs.CPU14.NET_TX
     20560 ± 23%     +16.1%      23879 ± 52%      +8.7%      22343 ± 18%  softirqs.CPU14.RCU
     50616            -5.1%      48032 ± 17%      +1.1%      51162        softirqs.CPU14.SCHED
      3.89 ±156%     +26.4%       4.92 ±133%     -42.9%       2.22 ± 28%  softirqs.CPU14.TASKLET
    647.44 ±185%     -72.8%     176.08 ±146%     -62.6%     241.89 ±166%  softirqs.CPU14.TIMER
     16.67 ±222%     -21.5%      13.08 ±266%     -17.3%      13.78 ±277%  softirqs.CPU15.BLOCK
     17.56 ±272%     +62.3%      28.50 ±216%    +340.5%      77.33 ±212%  softirqs.CPU15.NET_RX
      0.33 ±141%      +0.0%       0.33 ±141%     +66.7%       0.56 ±172%  softirqs.CPU15.NET_TX
     19950 ± 27%     +15.0%      22933 ± 50%      +8.3%      21600 ± 23%  softirqs.CPU15.RCU
     50579 ±  2%      -0.1%      50535 ±  7%      +1.0%      51103        softirqs.CPU15.SCHED
      1.56 ± 53%     +55.4%       2.42 ± 85%      +0.0%       1.56 ± 53%  softirqs.CPU15.TASKLET
      1753 ±267%     -92.0%     140.42 ±164%     -92.1%     139.22 ±192%  softirqs.CPU15.TIMER
     60.11 ±175%      +8.8%      65.42 ±168%     -66.9%      19.89 ±180%  softirqs.CPU16.BLOCK
      2.89 ±258%     +18.3%       3.42 ±140%   +3023.1%      90.22 ±243%  softirqs.CPU16.NET_RX
      0.44 ±215%      -6.2%       0.42 ±118%      +0.0%       0.44 ±154%  softirqs.CPU16.NET_TX
     18033 ± 23%     +11.8%      20167 ± 50%      +3.4%      18642 ± 19%  softirqs.CPU16.RCU
     48483 ± 15%      +4.0%      50422 ± 10%      -4.3%      46395 ± 20%  softirqs.CPU16.SCHED
      1.22 ± 92%     +63.6%       2.00 ± 73%      +9.1%       1.33 ± 93%  softirqs.CPU16.TASKLET
    587.89 ±228%     +78.7%       1050 ±245%     -85.1%      87.67 ±119%  softirqs.CPU16.TIMER
     46.89 ±184%     +65.8%      77.75 ± 94%     +16.4%      54.56 ±150%  softirqs.CPU17.BLOCK
     10.89 ±162%    +641.6%      80.75 ±325%     +54.1%      16.78 ±158%  softirqs.CPU17.NET_RX
      0.89 ±134%     -71.9%       0.25 ±173%     +25.0%       1.11 ±107%  softirqs.CPU17.NET_TX
     17551 ± 22%     +17.2%      20564 ± 53%      +3.3%      18130 ± 23%  softirqs.CPU17.RCU
     47778 ± 14%      +4.4%      49870 ± 15%      +7.5%      51369 ± 21%  softirqs.CPU17.SCHED
      0.56 ±149%    +125.0%       1.25 ±198%     +80.0%       1.00 ±188%  softirqs.CPU17.TASKLET
    373.33 ±213%     -66.0%     126.75 ±194%     -87.9%      45.33 ± 58%  softirqs.CPU17.TIMER
     71.56 ±112%      +9.0%      78.00 ±113%     -49.1%      36.44 ±164%  softirqs.CPU18.BLOCK
     12.22 ±262%     +51.4%      18.50 ±293%    +220.0%      39.11 ±270%  softirqs.CPU18.NET_RX
      0.78 ±169%    +339.3%       3.42 ±314%     -42.9%       0.44 ±154%  softirqs.CPU18.NET_TX
     17352 ± 20%     +10.6%      19187 ± 51%      +0.8%      17488 ± 22%  softirqs.CPU18.RCU
     47274 ± 19%      +6.9%      50542 ±  6%     +15.1%      54431 ± 28%  softirqs.CPU18.SCHED
      0.89 ±171%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU18.TASKLET
    301.00 ±198%     -25.9%     223.08 ±194%     +77.5%     534.33 ±230%  softirqs.CPU18.TIMER
     29.22 ±224%     +30.9%      38.25 ±220%     +27.8%      37.33 ±178%  softirqs.CPU19.BLOCK
     38.22 ±272%   +9118.2%       3523 ±331%     -87.5%       4.78 ±166%  softirqs.CPU19.NET_RX
      0.56 ±191%     +50.0%       0.83 ±128%     -60.0%       0.22 ±187%  softirqs.CPU19.NET_TX
     17525 ± 23%     +12.2%      19668 ± 51%      +1.3%      17748 ± 24%  softirqs.CPU19.RCU
     49855 ±  3%      -0.3%      49684 ± 28%      +2.7%      51197 ±  2%  softirqs.CPU19.SCHED
      4.89 ±261%     -96.6%       0.17 ±331%     -90.9%       0.44 ±187%  softirqs.CPU19.TASKLET
      1106 ±259%     -84.7%     168.75 ±228%     -89.0%     121.89 ±102%  softirqs.CPU19.TIMER
      1.56 ±260%     +28.6%       2.00 ±206%    +535.7%       9.89 ±140%  softirqs.CPU2.BLOCK
      3.56 ±145%   +1243.0%      47.75 ±307%   +2353.1%      87.22 ±259%  softirqs.CPU2.NET_RX
      0.22 ±282%     -62.5%       0.08 ±331%    +200.0%       0.67 ±122%  softirqs.CPU2.NET_TX
     21418 ± 19%      +8.5%      23245 ± 54%      +0.3%      21483 ± 19%  softirqs.CPU2.RCU
     48241 ± 10%      +4.4%      50354 ± 12%      +7.0%      51620        softirqs.CPU2.SCHED
      0.33 ±200%   +1325.0%       4.75 ±225%    +600.0%       2.33 ±240%  softirqs.CPU2.TASKLET
    411.11 ±104%     +14.9%     472.33 ±265%     -71.9%     115.33 ± 54%  softirqs.CPU2.TIMER
      5.33 ±158%     +20.3%       6.42 ±176%     -68.8%       1.67 ±174%  softirqs.CPU20.BLOCK
      1.78 ±173%   +6068.8%     109.67 ±234%   +1018.8%      19.89 ±277%  softirqs.CPU20.NET_RX
      0.11 ±282%    +125.0%       0.25 ±173%    -100.0%       0.00        softirqs.CPU20.NET_TX
     18789 ± 23%     +11.4%      20928 ± 55%      -1.4%      18518 ± 21%  softirqs.CPU20.RCU
     51234 ± 18%      +0.2%      51352 ±  3%      -7.0%      47661 ± 15%  softirqs.CPU20.SCHED
      0.00       +1.7e+101%       0.17 ±331%   +1e+102%       1.00 ±221%  softirqs.CPU20.TASKLET
    105.67 ±110%     +79.0%     189.17 ±228%     +99.2%     210.44 ±152%  softirqs.CPU20.TIMER
      4.56 ±227%     +59.1%       7.25 ±208%     -97.6%       0.11 ±282%  softirqs.CPU21.BLOCK
      1.44 ± 92%    +176.9%       4.00 ±257%     +53.8%       2.22 ±251%  softirqs.CPU21.NET_RX
      0.44 ±154%     -43.8%       0.25 ±173%     -75.0%       0.11 ±282%  softirqs.CPU21.NET_TX
     18074 ± 23%     +15.6%      20893 ± 54%      +5.8%      19130 ± 21%  softirqs.CPU21.RCU
     49770 ±  6%      +3.6%      51564 ±  3%      +0.7%      50132 ±  5%  softirqs.CPU21.SCHED
      2.22 ±282%     -88.8%       0.25 ±238%    -100.0%       0.00        softirqs.CPU21.TASKLET
    504.89 ±235%     -52.3%     241.00 ±178%     -72.5%     138.67 ±195%  softirqs.CPU21.TIMER
      2.22 ±267%      +5.0%       2.33 ±254%    +120.0%       4.89 ± 98%  softirqs.CPU22.BLOCK
      0.67 ±122%   +8087.5%      54.58 ±297%    +166.7%       1.78 ±190%  softirqs.CPU22.NET_RX
      0.33 ±200%     +50.0%       0.50 ±129%     -66.7%       0.11 ±282%  softirqs.CPU22.NET_TX
     18024 ± 21%     +14.1%      20557 ± 54%      +3.0%      18569 ± 18%  softirqs.CPU22.RCU
     50204 ±  3%      -1.1%      49631 ± 13%      +1.9%      51172        softirqs.CPU22.SCHED
      2.11 ±219%     -88.2%       0.25 ±238%     -84.2%       0.33 ±200%  softirqs.CPU22.TASKLET
     65.33 ± 82%    +606.8%     461.75 ±180%    +338.3%     286.33 ±192%  softirqs.CPU22.TIMER
      5.33 ±172%     -43.8%       3.00 ±203%     -22.9%       4.11 ±147%  softirqs.CPU23.BLOCK
     34.33 ±223%      -5.6%      32.42 ±272%    +802.3%     309.78 ±222%  softirqs.CPU23.NET_RX
      0.44 ±154%     -25.0%       0.33 ±254%     -50.0%       0.22 ±187%  softirqs.CPU23.NET_TX
     18366 ± 23%     +10.5%      20296 ± 48%      +1.2%      18578 ± 21%  softirqs.CPU23.RCU
     48464 ± 10%      +7.6%      52163 ± 14%      +6.4%      51576 ±  2%  softirqs.CPU23.SCHED
      0.22 ±282%    +912.5%       2.25 ±331%     -50.0%       0.11 ±282%  softirqs.CPU23.TASKLET
    111.11 ± 65%     +61.0%     178.92 ±173%      +7.4%     119.33 ±114%  softirqs.CPU23.TIMER
      0.56 ±282%     +65.0%       0.92 ±300%   +1500.0%       8.89 ±278%  softirqs.CPU24.BLOCK
     28.44 ±205%    +365.5%     132.42 ±223%    +383.2%     137.44 ±220%  softirqs.CPU24.NET_RX
      4.44 ±282%    +192.5%      13.00 ±140%    +195.0%      13.11 ±141%  softirqs.CPU24.NET_TX
     18437 ± 21%     +18.9%      21923 ± 56%      -7.2%      17109 ± 22%  softirqs.CPU24.RCU
     51590            -0.7%      51247 ±  4%      -1.6%      50774 ±  2%  softirqs.CPU24.SCHED
      2.00 ±265%    -100.0%       0.00           -16.7%       1.67 ±262%  softirqs.CPU24.TASKLET
    797.56 ±168%     -39.9%     479.08 ±122%     -35.0%     518.67 ±142%  softirqs.CPU24.TIMER
      0.22 ±282%   +5787.5%      13.08 ±219%   +5450.0%      12.33 ±277%  softirqs.CPU25.BLOCK
    807.56 ±282%     -99.1%       7.17 ±327%     -98.6%      11.56 ±168%  softirqs.CPU25.NET_RX
      0.00          -100.0%       0.00       +3.3e+101%       0.33 ±200%  softirqs.CPU25.NET_TX
     17665 ± 16%     +17.4%      20734 ± 58%      -6.3%      16545 ± 21%  softirqs.CPU25.RCU
     51798 ±  3%      +0.4%      51981 ±  2%      +3.4%      53542 ± 15%  softirqs.CPU25.SCHED
      3.11 ±187%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU25.TASKLET
    387.78 ±129%     +79.4%     695.83 ±123%     +73.5%     672.78 ±118%  softirqs.CPU25.TIMER
     17.44 ±251%     -78.5%       3.75 ±307%     -72.6%       4.78 ±240%  softirqs.CPU26.BLOCK
      0.00       +1.4e+102%       1.42 ±234%    -100.0%       0.00        softirqs.CPU26.NET_RX
      0.00       +8.3e+100%       0.08 ±331%    -100.0%       0.00        softirqs.CPU26.NET_TX
     18487 ± 17%     +21.5%      22467 ± 55%     -14.5%      15800 ± 26%  softirqs.CPU26.RCU
     50992 ±  2%      +0.3%      51166 ±  6%      -7.0%      47409 ± 14%  softirqs.CPU26.SCHED
      2.00            +4.2%       2.08 ± 13%      +5.6%       2.11 ± 14%  softirqs.CPU26.TASKLET
     72.00 ± 91%    +792.9%     642.92 ±105%   +2374.5%       1781 ±272%  softirqs.CPU26.TIMER
      3.78 ±282%     -16.2%       3.17 ±322%     -82.4%       0.67 ±234%  softirqs.CPU27.BLOCK
     31.56 ±281%     -81.5%       5.83 ±326%     -88.0%       3.78 ±264%  softirqs.CPU27.NET_RX
      0.00          -100.0%       0.00       +2.2e+101%       0.22 ±282%  softirqs.CPU27.NET_TX
     17296 ± 17%     +16.1%      20084 ± 61%      -6.3%      16205 ± 32%  softirqs.CPU27.RCU
     51298 ±  2%      -6.6%      47917 ± 15%     -12.2%      45035 ± 20%  softirqs.CPU27.SCHED
      1.67 ± 39%     +10.0%       1.83 ± 30%     +93.3%       3.22 ±108%  softirqs.CPU27.TASKLET
    442.78 ±239%     +36.3%     603.58 ±164%    +141.7%       1070 ±257%  softirqs.CPU27.TIMER
      7.56 ±282%     -96.7%       0.25 ±173%     -86.8%       1.00 ±282%  softirqs.CPU28.BLOCK
    120.22 ±258%     -82.2%      21.42 ±233%     -31.2%      82.67 ±282%  softirqs.CPU28.NET_RX
     18663 ± 17%     +17.7%      21964 ± 58%     -10.3%      16741 ± 22%  softirqs.CPU28.RCU
     51875 ± 11%      -0.0%      51867 ±  6%      -2.5%      50572 ±  3%  softirqs.CPU28.SCHED
      2.11 ± 78%     -17.1%       1.75 ± 34%     -15.8%       1.78 ± 23%  softirqs.CPU28.TASKLET
    228.11 ±227%     +61.8%     369.17 ±162%     -37.7%     142.22 ±227%  softirqs.CPU28.TIMER
      0.89 ±208%   +3106.2%      28.50 ±229%     -25.0%       0.67 ±234%  softirqs.CPU29.BLOCK
      5.00 ±282%     -53.3%       2.33 ±247%    +722.2%      41.11 ±258%  softirqs.CPU29.NET_RX
      0.11 ±282%     -25.0%       0.08 ±331%    +100.0%       0.22 ±282%  softirqs.CPU29.NET_TX
     18572 ± 16%     +19.9%      22267 ± 59%      -9.4%      16819 ± 23%  softirqs.CPU29.RCU
     51629 ±  2%      -0.1%      51595 ±  2%      -0.0%      51605 ±  6%  softirqs.CPU29.SCHED
      2.11 ± 14%      -5.3%       2.00            +5.3%       2.22 ± 28%  softirqs.CPU29.TASKLET
    244.56 ±213%     -53.0%     114.92 ±109%     -74.9%      61.33 ±113%  softirqs.CPU29.TIMER
      0.33 ±200%   +2650.0%       9.17 ±131%   +1833.3%       6.44 ±206%  softirqs.CPU3.BLOCK
     19.44 ±228%     -78.1%       4.25 ±210%    +761.1%     167.44 ±276%  softirqs.CPU3.NET_RX
      0.11 ±282%   +3050.0%       3.50 ±314%    +100.0%       0.22 ±187%  softirqs.CPU3.NET_TX
     21276 ± 24%      +9.8%      23363 ± 44%      +3.4%      21996 ± 21%  softirqs.CPU3.RCU
     49871 ± 18%      +4.9%      52335 ±  2%     +10.2%      54960 ± 16%  softirqs.CPU3.SCHED
      0.33 ±199%     +50.0%       0.50 ±129%    -100.0%       0.00        softirqs.CPU3.TASKLET
    600.00 ±199%     -30.9%     414.50 ±141%     -27.4%     435.67 ±126%  softirqs.CPU3.TIMER
     12.33 ±274%     -68.2%       3.92 ±286%    +172.1%      33.56 ±158%  softirqs.CPU30.BLOCK
      0.11 ±282%   +8675.0%       9.75 ±182%   +8400.0%       9.44 ±282%  softirqs.CPU30.NET_RX
      0.00       +2.5e+101%       0.25 ±238%    -100.0%       0.00        softirqs.CPU30.NET_TX
     17107 ± 17%     +17.4%      20084 ± 55%      -4.5%      16336 ± 25%  softirqs.CPU30.RCU
     51445 ±  2%      +2.7%      52822 ±  9%      -3.8%      49475 ±  2%  softirqs.CPU30.SCHED
      1.78 ± 35%      -6.2%       1.67 ± 44%      +6.2%       1.89 ± 16%  softirqs.CPU30.TASKLET
    228.67 ±223%     -13.1%     198.75 ±277%     -63.0%      84.56 ± 88%  softirqs.CPU30.TIMER
      7.78 ±185%     -28.2%       5.58 ±218%     -91.4%       0.67 ±158%  softirqs.CPU31.BLOCK
      7008 ±282%     -97.4%     185.58 ±200%     -99.9%       6.33 ±271%  softirqs.CPU31.NET_RX
      0.00          -100.0%       0.00       +1.1e+101%       0.11 ±282%  softirqs.CPU31.NET_TX
     18292 ± 18%     +18.8%      21733 ± 59%      -7.6%      16905 ± 24%  softirqs.CPU31.RCU
     51179 ±  2%      -6.3%      47945 ± 25%      -1.2%      50579 ±  5%  softirqs.CPU31.SCHED
      3.67 ±128%     -47.7%       1.92 ± 14%     -48.5%       1.89 ± 16%  softirqs.CPU31.TASKLET
    885.33 ±253%     -78.6%     189.58 ±235%     -95.8%      37.33 ± 84%  softirqs.CPU31.TIMER
     12.33 ±277%     -96.6%       0.42 ±267%     -23.4%       9.44 ±188%  softirqs.CPU32.BLOCK
     66.44 ±240%    +118.4%     145.08 ±127%     -99.8%       0.11 ±282%  softirqs.CPU32.NET_RX
     23106 ± 22%     +19.7%      27663 ± 61%     -19.2%      18679 ± 23%  softirqs.CPU32.RCU
     52990 ± 11%      -3.9%      50906 ±  6%      -1.3%      52284 ± 10%  softirqs.CPU32.SCHED
      2.67 ± 70%     -25.0%       2.00           -25.0%       2.00        softirqs.CPU32.TASKLET
    688.44 ±244%     -95.8%      28.83 ± 98%     -89.8%      70.33 ±105%  softirqs.CPU32.TIMER
      0.44 ±187%     +50.0%       0.67 ±215%    +875.0%       4.33 ±259%  softirqs.CPU33.BLOCK
    112.11 ±191%     -95.8%       4.75 ±273%    -100.0%       0.00        softirqs.CPU33.NET_RX
     22133 ± 19%     +19.2%      26379 ± 58%     -16.0%      18594 ± 22%  softirqs.CPU33.RCU
     50935 ±  2%      -0.2%      50829 ±  4%      -2.7%      49547 ±  2%  softirqs.CPU33.SCHED
      1.56 ± 53%     +28.6%       2.00           +28.6%       2.00        softirqs.CPU33.TASKLET
     44.11 ±151%     -46.7%      23.50 ± 47%     +21.7%      53.67 ±109%  softirqs.CPU33.TIMER
      0.67 ±282%    +487.5%       3.92 ±223%     +50.0%       1.00 ±200%  softirqs.CPU34.BLOCK
      7.33 ±250%    +633.0%      53.75 ±331%     -93.9%       0.44 ±187%  softirqs.CPU34.NET_RX
      0.11 ±282%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU34.NET_TX
     21628 ± 16%     +26.4%      27330 ± 57%      -9.2%      19641 ± 21%  softirqs.CPU34.RCU
     51610 ±  2%      -0.1%      51580 ±  2%      -9.0%      46955 ± 13%  softirqs.CPU34.SCHED
      6.44 ±239%     -92.2%       0.50 ±173%     -25.9%       4.78 ±268%  softirqs.CPU34.TASKLET
      2043 ±146%     -91.9%     166.25 ±242%     -94.6%     109.89 ±151%  softirqs.CPU34.TIMER
     10.56 ±184%     +57.9%      16.67 ±250%      -3.2%      10.22 ±187%  softirqs.CPU35.BLOCK
      1.00 ±249%    +191.7%       2.92 ±226%  +19222.2%     193.22 ±282%  softirqs.CPU35.NET_RX
      0.11 ±282%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU35.NET_TX
     22703 ± 20%     +20.3%      27309 ± 58%     -13.7%      19603 ± 23%  softirqs.CPU35.RCU
     51171 ±  2%      -3.7%      49279 ±  9%      -2.7%      49780        softirqs.CPU35.SCHED
      0.22 ±282%     -25.0%       0.17 ±331%    -100.0%       0.00        softirqs.CPU35.TASKLET
     41.33 ±156%     +78.0%      73.58 ±188%     +58.6%      65.56 ±142%  softirqs.CPU35.TIMER
      7.56 ±282%     +82.0%      13.75 ±236%     -54.4%       3.44 ±244%  softirqs.CPU36.BLOCK
    103.67 ±195%     -54.7%      47.00 ±331%    +797.0%     929.89 ±272%  softirqs.CPU36.NET_RX
      0.00          -100.0%       0.00       +2.2e+101%       0.22 ±282%  softirqs.CPU36.NET_TX
     20295 ± 19%     +14.5%      23244 ± 57%     -10.5%      18174 ± 24%  softirqs.CPU36.RCU
     51071 ±  3%      +0.8%      51499 ±  2%      -4.5%      48757 ±  3%  softirqs.CPU36.SCHED
      0.00          -100.0%       0.00       +5.6e+101%       0.56 ±282%  softirqs.CPU36.TASKLET
    642.78 ±112%     -25.3%     480.42 ±159%      -1.6%     632.44 ±228%  softirqs.CPU36.TIMER
     12.22 ±277%     -64.5%       4.33 ±190%     +58.2%      19.33 ±281%  softirqs.CPU37.BLOCK
      0.22 ±187%  +86375.0%     192.17 ±314%   +6550.0%      14.78 ±196%  softirqs.CPU37.NET_RX
      0.00       +8.3e+100%       0.08 ±331% +1.1e+101%       0.11 ±282%  softirqs.CPU37.NET_TX
     22730 ± 19%      +9.7%      24937 ± 61%     -17.9%      18653 ± 26%  softirqs.CPU37.RCU
     50830 ±  2%      -4.9%      48343 ± 23%      -9.4%      46045 ± 16%  softirqs.CPU37.SCHED
      0.00       +5.8e+101%       0.58 ±331%    -100.0%       0.00        softirqs.CPU37.TASKLET
    202.33 ±201%    +468.5%       1150 ±317%     -13.6%     174.78 ±188%  softirqs.CPU37.TIMER
      0.67 ±282%   +1350.0%       9.67 ±196%   +4083.3%      27.89 ±132%  softirqs.CPU38.BLOCK
    151.33 ±271%    +127.3%     344.00 ±327%     -68.9%      47.11 ±282%  softirqs.CPU38.NET_RX
      0.11 ±282%     -25.0%       0.08 ±331%    -100.0%       0.00        softirqs.CPU38.NET_TX
     23513 ± 22%     +19.8%      28159 ± 60%     -18.0%      19278 ± 23%  softirqs.CPU38.RCU
     49645 ±  8%      +4.1%      51680 ±  2%      +0.5%      49891        softirqs.CPU38.SCHED
      0.44 ±282%     -81.2%       0.08 ±331%     -25.0%       0.33 ±282%  softirqs.CPU38.TASKLET
     46.78 ±130%     +21.7%      56.92 ±138%     +63.7%      76.56 ±122%  softirqs.CPU38.TIMER
      0.00         +1e+102%       1.00 ±187% +3.3e+101%       0.33 ±200%  softirqs.CPU39.BLOCK
    172.56 ±272%     -87.3%      21.92 ±322%     -36.4%     109.78 ±282%  softirqs.CPU39.NET_RX
      0.00       +1.7e+101%       0.17 ±331% +1.1e+101%       0.11 ±282%  softirqs.CPU39.NET_TX
     21125 ± 18%     +19.1%      25169 ± 58%      -7.9%      19447 ± 22%  softirqs.CPU39.RCU
     48596 ± 15%      +6.0%      51506 ±  2%      +1.3%      49216 ±  3%  softirqs.CPU39.SCHED
     22.78 ± 53%    +140.4%      54.75 ±109%    +182.0%      64.22 ±187%  softirqs.CPU39.TIMER
      0.11 ±282%   +5525.0%       6.25 ±204%   +2200.0%       2.56 ±212%  softirqs.CPU4.BLOCK
     19.56 ±181%    +423.7%     102.42 ±301%     -98.3%       0.33 ±141%  softirqs.CPU4.NET_RX
      0.22 ±187%     +12.5%       0.25 ±238%      +0.0%       0.22 ±187%  softirqs.CPU4.NET_TX
     20875 ± 23%     +11.6%      23302 ± 43%      +7.0%      22337 ± 18%  softirqs.CPU4.RCU
     45490 ± 23%     +10.7%      50378 ± 13%      +3.9%      47260 ± 26%  softirqs.CPU4.SCHED
      4.56 ±237%     -81.7%       0.83 ±206%     -92.7%       0.33 ±200%  softirqs.CPU4.TASKLET
    116.00 ±170%   +1145.8%       1445 ±301%      +1.8%     118.11 ± 82%  softirqs.CPU4.TIMER
      0.44 ±282%   +1906.2%       8.92 ±331%   +1425.0%       6.78 ±233%  softirqs.CPU40.BLOCK
     60.78 ±281%     +40.7%      85.50 ±331%     +14.6%      69.67 ±282%  softirqs.CPU40.NET_RX
     23462 ± 22%     +17.0%      27444 ± 56%     -18.7%      19072 ± 26%  softirqs.CPU40.RCU
     48447 ± 15%      +6.3%      51489 ±  2%      +2.8%      49806        softirqs.CPU40.SCHED
      0.89 ±245%    -100.0%       0.00           +75.0%       1.56 ±282%  softirqs.CPU40.TASKLET
     52.89 ±187%    +156.2%     135.50 ±138%    +309.7%     216.67 ±130%  softirqs.CPU40.TIMER
      5.78 ±282%     -94.2%       0.33 ±187%     -78.8%       1.22 ±230%  softirqs.CPU41.BLOCK
     28.78 ±245%     -97.1%       0.83 ±331%    +149.8%      71.89 ±261%  softirqs.CPU41.NET_RX
      0.00          -100.0%       0.00       +1.1e+101%       0.11 ±282%  softirqs.CPU41.NET_TX
     23735 ± 22%     +15.0%      27296 ± 64%     -17.5%      19571 ± 22%  softirqs.CPU41.RCU
     51396            -3.2%      49734 ± 13%      -2.7%      50020        softirqs.CPU41.SCHED
      0.11 ±282%    +200.0%       0.33 ±331%    -100.0%       0.00        softirqs.CPU41.TASKLET
    206.11 ±213%    +383.0%     995.50 ±295%     +48.8%     306.67 ±217%  softirqs.CPU41.TIMER
      0.44 ±215%   +2018.8%       9.42 ±231%   +2175.0%      10.11 ±268%  softirqs.CPU42.BLOCK
      8.11 ±282%    +379.8%      38.92 ±317%     -78.1%       1.78 ±282%  softirqs.CPU42.NET_RX
     18961 ± 21%      +6.5%      20187 ± 50%      -2.2%      18547 ± 24%  softirqs.CPU42.RCU
     48638 ± 15%      +5.5%      51325 ±  2%      +1.4%      49334 ±  2%  softirqs.CPU42.SCHED
      0.11 ±282%    -100.0%       0.00         +4500.0%       5.11 ±282%  softirqs.CPU42.TASKLET
    215.44 ±223%     -40.5%     128.17 ±148%    +125.9%     486.67 ±260%  softirqs.CPU42.TIMER
      0.11 ±282%    -100.0%       0.00        +16300.0%      18.22 ±198%  softirqs.CPU43.BLOCK
      0.00       +4.9e+102%       4.92 ±331% +7.3e+102%       7.33 ±207%  softirqs.CPU43.NET_RX
      0.00       +1.7e+101%       0.17 ±331% +3.3e+101%       0.33 ±199%  softirqs.CPU43.NET_TX
     19958 ± 18%     +16.6%      23280 ± 55%      -3.5%      19264 ± 20%  softirqs.CPU43.RCU
     51940 ±  5%      -1.1%      51365 ±  2%      -9.4%      47042 ± 16%  softirqs.CPU43.SCHED
     75.11 ±205%     -55.2%      33.67 ± 72%    +117.9%     163.67 ±150%  softirqs.CPU43.TIMER
      9.89 ±196%     -11.5%       8.75 ±307%     -41.6%       5.78 ±258%  softirqs.CPU44.BLOCK
     16.67 ±282%    +113.5%      35.58 ±324%    +200.7%      50.11 ±280%  softirqs.CPU44.NET_RX
      0.00       +8.3e+100%       0.08 ±331%    -100.0%       0.00        softirqs.CPU44.NET_TX
     23808 ± 22%     +17.9%      28063 ± 59%     -23.1%      18306 ± 21%  softirqs.CPU44.RCU
     51398 ±  2%      +2.1%      52483 ±  3%      -5.5%      48556 ±  9%  softirqs.CPU44.SCHED
      0.22 ±282%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU44.TASKLET
    103.67 ±130%     +63.6%     169.58 ±233%   +1330.4%       1482 ±268%  softirqs.CPU44.TIMER
     23.89 ±119%     -94.8%       1.25 ±251%     -50.2%      11.89 ±259%  softirqs.CPU45.BLOCK
      0.00         +1e+104%     104.17 ±256% +9.6e+102%       9.56 ±279%  softirqs.CPU45.NET_RX
     23605 ± 20%     +16.3%      27443 ± 56%     -18.7%      19201 ± 24%  softirqs.CPU45.RCU
     51184 ±  2%      -2.7%      49820 ± 13%      -4.5%      48873 ±  4%  softirqs.CPU45.SCHED
      0.00       +2.2e+102%       2.25 ±232%    -100.0%       0.00        softirqs.CPU45.TASKLET
    205.11 ±242%     -55.5%      91.33 ±159%     +52.9%     313.56 ±264%  softirqs.CPU45.TIMER
     27.67 ±180%     -90.7%       2.58 ±309%     -99.6%       0.11 ±282%  softirqs.CPU46.BLOCK
     54.11 ±253%     +26.0%      68.17 ±243%     -98.4%       0.89 ±282%  softirqs.CPU46.NET_RX
      0.00       +8.3e+100%       0.08 ±331%    -100.0%       0.00        softirqs.CPU46.NET_TX
     23097 ± 24%     +20.3%      27785 ± 59%     -15.3%      19569 ± 23%  softirqs.CPU46.RCU
     51665            -0.1%      51620 ±  2%      -6.6%      48260 ± 11%  softirqs.CPU46.SCHED
      0.00          -100.0%       0.00       +1.3e+102%       1.33 ±234%  softirqs.CPU46.TASKLET
    392.11 ±177%     -38.8%     239.83 ±229%      -4.1%     375.89 ±165%  softirqs.CPU46.TIMER
      0.44 ±187%   +2412.5%      11.17 ±250%   +1800.0%       8.44 ±254%  softirqs.CPU47.BLOCK
      9.22 ±184%     +32.8%      12.25 ±199%     -88.0%       1.11 ±252%  softirqs.CPU47.NET_RX
     13.00 ±141%     -50.6%       6.42 ±223%     -66.7%       4.33 ±274%  softirqs.CPU47.NET_TX
     21654 ± 23%     +19.9%      25967 ± 54%     -10.9%      19286 ± 25%  softirqs.CPU47.RCU
     46124 ± 15%      -8.0%      42423 ± 17%      -8.1%      42378 ± 24%  softirqs.CPU47.SCHED
      1.44 ±282%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU47.TASKLET
    366.22 ±254%     -79.0%      77.08 ± 94%     -88.3%      42.78 ± 59%  softirqs.CPU47.TIMER
      2.67 ±282%     -65.6%       0.92 ±331%    +287.5%      10.33 ±144%  softirqs.CPU48.BLOCK
     71.33 ±271%     -99.2%       0.58 ±130%     -97.0%       2.11 ±157%  softirqs.CPU48.NET_RX
      0.22 ±187%    +125.0%       0.50 ±129%   +2050.0%       4.78 ±253%  softirqs.CPU48.NET_TX
     19990 ± 19%     +13.3%      22642 ± 50%      +1.5%      20283 ± 24%  softirqs.CPU48.RCU
     42280 ± 17%      -7.1%      39299 ± 31%      +2.2%      43231 ± 26%  softirqs.CPU48.SCHED
      0.22 ±282%    -100.0%       0.00         +2150.0%       5.00 ±275%  softirqs.CPU48.TASKLET
    331.44 ±156%    +139.1%     792.58 ±198%     -51.0%     162.44 ±128%  softirqs.CPU48.TIMER
      3.00 ±282%     +36.1%       4.08 ±192%     +11.1%       3.33 ±187%  softirqs.CPU49.BLOCK
     54.67 ±273%  +15359.6%       8451 ±256%     -95.5%       2.44 ±114%  softirqs.CPU49.NET_RX
      0.67 ±100%     -87.5%       0.08 ±331%     -66.7%       0.22 ±187%  softirqs.CPU49.NET_TX
     19479 ± 21%     +15.4%      22474 ± 54%      +5.4%      20534 ± 25%  softirqs.CPU49.RCU
     42715 ± 19%     +17.0%      49974 ±  9%     +16.5%      49775 ±  6%  softirqs.CPU49.SCHED
      0.44 ±154%     -81.2%       0.08 ±331%     -75.0%       0.11 ±282%  softirqs.CPU49.TASKLET
    143.78 ± 57%     +63.2%     234.58 ±105%    +661.7%       1095 ±107%  softirqs.CPU49.TIMER
      7.33 ±119%    -100.0%       0.00           -87.9%       0.89 ±282%  softirqs.CPU5.BLOCK
      1343 ±282%     -97.6%      32.25 ±318%     -99.8%       3.33 ±272%  softirqs.CPU5.NET_RX
      0.22 ±282%    -100.0%       0.00           -50.0%       0.11 ±282%  softirqs.CPU5.NET_TX
     21258 ± 23%     +14.4%      24314 ± 54%      +3.4%      21979 ± 21%  softirqs.CPU5.RCU
     51415 ±  5%      +1.0%      51909            -1.5%      50665 ±  6%  softirqs.CPU5.SCHED
      0.11 ±282%   +3725.0%       4.25 ±303%    +400.0%       0.56 ±149%  softirqs.CPU5.TASKLET
    109.44 ± 89%    +203.3%     331.92 ±167%    +139.1%     261.67 ±201%  softirqs.CPU5.TIMER
      0.11 ±282%  +16550.0%      18.50 ±188%      +0.0%       0.11 ±282%  softirqs.CPU50.BLOCK
     10.44 ±256%   +1192.6%     135.00 ±323%     +47.9%      15.44 ±273%  softirqs.CPU50.NET_RX
      0.22 ±187%     +50.0%       0.33 ±141%     +50.0%       0.33 ±141%  softirqs.CPU50.NET_TX
     20329 ± 20%     +13.3%      23040 ± 54%      +1.2%      20571 ± 23%  softirqs.CPU50.RCU
     46651 ± 10%      +7.2%      50007 ±  7%      +7.3%      50046 ±  2%  softirqs.CPU50.SCHED
      0.22 ±187%    +125.0%       0.50 ±152%    +100.0%       0.44 ±154%  softirqs.CPU50.TASKLET
    132.78 ± 71%    +253.1%     468.83 ±135%    +131.5%     307.44 ±192%  softirqs.CPU50.TIMER
     38.11 ±178%     -87.5%       4.75 ±209%     -97.7%       0.89 ±282%  softirqs.CPU51.BLOCK
     58.11 ±273%    +154.4%     147.83 ±241%     +39.2%      80.89 ±229%  softirqs.CPU51.NET_RX
      0.22 ±187%     +50.0%       0.33 ±141%    +150.0%       0.56 ±123%  softirqs.CPU51.NET_TX
     20816 ± 22%     +10.3%      22963 ± 46%      +0.3%      20872 ± 26%  softirqs.CPU51.RCU
     49448 ±  2%      +3.9%      51390 ±  3%      -8.4%      45296 ± 20%  softirqs.CPU51.SCHED
      1.44 ±237%    +107.7%       3.00 ±209%     -53.8%       0.67 ±158%  softirqs.CPU51.TASKLET
    105.56 ± 68%    +183.5%     299.25 ±154%    +676.8%     820.00 ±255%  softirqs.CPU51.TIMER
      1.22 ±203%    +350.0%       5.50 ±215%    +218.2%       3.89 ±219%  softirqs.CPU52.BLOCK
      1.56 ±125%   +4367.9%      69.50 ±260%    +114.3%       3.33 ± 94%  softirqs.CPU52.NET_RX
      0.44 ±154%     -43.8%       0.25 ±238%     -25.0%       0.33 ±141%  softirqs.CPU52.NET_TX
     21237 ± 21%     +12.0%      23783 ± 50%      +3.4%      21951 ± 23%  softirqs.CPU52.RCU
     47366 ± 14%      +9.0%      51649 ±  2%      +2.5%      48552 ± 14%  softirqs.CPU52.SCHED
      0.00          -100.0%       0.00       +2.1e+102%       2.11 ±234%  softirqs.CPU52.TASKLET
     81.44 ±106%     +45.8%     118.75 ± 59%    +133.3%     190.00 ±120%  softirqs.CPU52.TIMER
      9.33 ±187%     -84.8%       1.42 ±310%     -84.5%       1.44 ±282%  softirqs.CPU53.BLOCK
      5.00 ±163%     -41.7%       2.92 ±175%     -51.1%       2.44 ±169%  softirqs.CPU53.NET_RX
      0.44 ±111%      -6.2%       0.42 ±118%     +50.0%       0.67 ±100%  softirqs.CPU53.NET_TX
     20792 ± 22%     +14.4%      23780 ± 51%      +3.3%      21471 ± 23%  softirqs.CPU53.RCU
     46769 ± 13%      +6.2%      49665 ± 13%      +6.9%      50017 ±  5%  softirqs.CPU53.SCHED
      0.22 ±187%    +987.5%       2.42 ±331%     -50.0%       0.11 ±282%  softirqs.CPU53.TASKLET
    117.11 ± 85%    +247.6%     407.08 ±146%     +21.0%     141.67 ±122%  softirqs.CPU53.TIMER
      0.00         +8e+102%       8.00 ±197% +1.3e+103%      12.78 ±174%  softirqs.CPU54.BLOCK
      6.56 ±209%    +632.2%      48.00 ±322%     -54.2%       3.00 ±167%  softirqs.CPU54.NET_RX
      4.89 ±268%     -94.9%       0.25 ±173%     -93.2%       0.33 ±141%  softirqs.CPU54.NET_TX
     20183 ± 21%     +13.5%      22898 ± 50%      +9.4%      22080 ± 20%  softirqs.CPU54.RCU
     46601 ± 15%      +2.4%      47742 ± 19%      +8.4%      50502 ±  4%  softirqs.CPU54.SCHED
      0.44 ±187%     -62.5%       0.17 ±223%     -50.0%       0.22 ±282%  softirqs.CPU54.TASKLET
    146.44 ±101%    +138.3%     349.00 ±155%      -1.4%     144.44 ± 89%  softirqs.CPU54.TIMER
      1.11 ±226%    +342.5%       4.92 ±235%    +900.0%      11.11 ±279%  softirqs.CPU55.BLOCK
      0.33 ±141%   +2150.0%       7.50 ±168%  +20033.3%      67.11 ±280%  softirqs.CPU55.NET_RX
      0.11 ±282%    +425.0%       0.58 ±163%      +0.0%       0.11 ±282%  softirqs.CPU55.NET_TX
     20608 ± 20%     +15.0%      23702 ± 50%      +4.7%      21585 ± 22%  softirqs.CPU55.RCU
     48731 ±  3%      +3.3%      50331 ±  5%     -11.3%      43227 ± 28%  softirqs.CPU55.SCHED
      0.00       +2.2e+102%       2.25 ±228% +2.2e+101%       0.22 ±282%  softirqs.CPU55.TASKLET
    320.67 ±183%     -70.1%      95.83 ±100%     -16.6%     267.56 ±137%  softirqs.CPU55.TIMER
      2.89 ±172%     -13.5%       2.50 ±182%    +150.0%       7.22 ±277%  softirqs.CPU56.BLOCK
     21.56 ±266%     -88.0%       2.58 ±176%  +33677.3%       7280 ±282%  softirqs.CPU56.NET_RX
      0.33 ±200%     -50.0%       0.17 ±223%     +33.3%       0.44 ±111%  softirqs.CPU56.NET_TX
     21164 ± 22%     +10.4%      23370 ± 48%      +0.8%      21339 ± 20%  softirqs.CPU56.RCU
     48675 ±  5%      +0.2%      48780 ± 20%      +4.2%      50711 ±  3%  softirqs.CPU56.SCHED
      0.22 ±282%     -25.0%       0.17 ±331%     -50.0%       0.11 ±282%  softirqs.CPU56.TASKLET
    214.33 ±105%     +33.4%     285.83 ±174%     -61.7%      82.00 ± 64%  softirqs.CPU56.TIMER
      1.11 ±172%     +35.0%       1.50 ±195%      +0.0%       1.11 ±177%  softirqs.CPU57.BLOCK
    149.56 ±217%     -99.1%       1.33 ±184%     -95.8%       6.22 ±260%  softirqs.CPU57.NET_RX
      0.56 ±123%     -25.0%       0.42 ±153%     -20.0%       0.44 ±111%  softirqs.CPU57.NET_TX
     20817 ± 22%     +14.3%      23799 ± 46%      +4.7%      21804 ± 21%  softirqs.CPU57.RCU
     49647 ±  3%      -2.1%      48601 ± 19%      -0.4%      49442 ±  6%  softirqs.CPU57.SCHED
      0.44 ±187%    +143.8%       1.08 ±233%    -100.0%       0.00        softirqs.CPU57.TASKLET
    190.44 ±212%     +82.6%     347.75 ± 93%     -42.3%     109.89 ± 76%  softirqs.CPU57.TIMER
      6.00 ±150%    +312.5%      24.75 ±212%    +177.8%      16.67 ±136%  softirqs.CPU58.BLOCK
      1.33 ±180%  +13093.8%     175.92 ±312%   +4366.7%      59.56 ±233%  softirqs.CPU58.NET_RX
      0.33 ±141%      +0.0%       0.33 ±141%     -66.7%       0.11 ±282%  softirqs.CPU58.NET_TX
     20906 ± 20%     +11.7%      23343 ± 48%      -5.2%      19815 ± 24%  softirqs.CPU58.RCU
     46451 ± 12%      +6.2%      49321 ± 12%      +8.9%      50595 ±  2%  softirqs.CPU58.SCHED
      0.00       +2.9e+102%       2.92 ±331% +5.6e+101%       0.56 ±191%  softirqs.CPU58.TASKLET
     66.11 ± 48%    +123.1%     147.50 ±122%   +1255.0%     895.78 ±249%  softirqs.CPU58.TIMER
      0.33 ±141%   +4175.0%      14.25 ±284%   +1000.0%       3.67 ±273%  softirqs.CPU59.BLOCK
      0.67 ±187%   +3250.0%      22.33 ±262%   +2116.7%      14.78 ±178%  softirqs.CPU59.NET_RX
      0.22 ±187%    +237.5%       0.75 ±155%      +0.0%       0.22 ±187%  softirqs.CPU59.NET_TX
     20703 ± 21%     +14.0%      23604 ± 46%      +7.1%      22180 ± 22%  softirqs.CPU59.RCU
     46586 ± 13%      +9.1%      50845 ± 10%      +8.0%      50294 ±  4%  softirqs.CPU59.SCHED
      0.22 ±282%     +12.5%       0.25 ±331%    +300.0%       0.89 ±282%  softirqs.CPU59.TASKLET
    224.89 ±172%     -27.4%     163.17 ±107%     -35.2%     145.67 ± 49%  softirqs.CPU59.TIMER
      7.44 ±214%     -89.9%       0.75 ±293%     -83.6%       1.22 ±210%  softirqs.CPU6.BLOCK
      5556 ±282%     -99.2%      42.50 ±316%     -98.4%      91.00 ±165%  softirqs.CPU6.NET_RX
      0.11 ±282%     +50.0%       0.17 ±223%    +400.0%       0.56 ±191%  softirqs.CPU6.NET_TX
     20684 ± 24%     +15.8%      23947 ± 53%      +4.1%      21539 ± 19%  softirqs.CPU6.RCU
     50588 ±  2%      -1.9%      49627 ± 12%      -4.2%      48466 ± 13%  softirqs.CPU6.SCHED
      2.11 ±282%     +18.4%       2.50 ±223%     -84.2%       0.33 ±199%  softirqs.CPU6.TASKLET
    226.22 ±169%     +72.6%     390.50 ±199%     -77.9%      49.89 ± 49%  softirqs.CPU6.TIMER
      3.44 ±252%     -32.3%       2.33 ±143%      +3.2%       3.56 ±221%  softirqs.CPU60.BLOCK
    141.11 ±280%     -63.4%      51.58 ±288%     +13.5%     160.22 ±142%  softirqs.CPU60.NET_RX
      0.67 ± 70%     -50.0%       0.33 ±141%     -66.7%       0.22 ±187%  softirqs.CPU60.NET_TX
     21003 ± 23%      +5.1%      22068 ± 51%      +1.3%      21276 ± 24%  softirqs.CPU60.RCU
     48251 ±  4%      +4.1%      50244 ±  5%      +5.1%      50702 ±  3%  softirqs.CPU60.SCHED
      0.22 ±282%     +87.5%       0.42 ±182%    -100.0%       0.00        softirqs.CPU60.TASKLET
    201.44 ± 95%    +121.0%     445.25 ±226%      -6.7%     188.00 ± 59%  softirqs.CPU60.TIMER
      3.33 ±140%     +37.5%       4.58 ±215%    +153.3%       8.44 ±160%  softirqs.CPU61.BLOCK
    101.78 ±277%     -26.5%      74.83 ±319%     -96.2%       3.89 ±135%  softirqs.CPU61.NET_RX
      0.56 ±149%     -10.0%       0.50 ±129%      +0.0%       0.56 ± 89%  softirqs.CPU61.NET_TX
     21236 ± 21%     +10.2%      23410 ± 49%      +0.8%      21415 ± 23%  softirqs.CPU61.RCU
     47194 ± 11%      +8.3%      51129 ±  3%      +7.4%      50685 ±  2%  softirqs.CPU61.SCHED
      3.00 ±248%     -16.7%       2.50 ±214%     -59.3%       1.22 ± 92%  softirqs.CPU61.TASKLET
    115.22 ±117%    +167.9%     308.67 ±182%     +81.3%     208.89 ± 67%  softirqs.CPU61.TIMER
     31.00 ±153%     -83.6%       5.08 ±235%     -59.1%      12.67 ±282%  softirqs.CPU62.BLOCK
    179.00 ±213%    +155.4%     457.08 ±195%     -96.1%       7.00 ±228%  softirqs.CPU62.NET_RX
      0.00       +5.8e+101%       0.58 ±147% +4.4e+101%       0.44 ±154%  softirqs.CPU62.NET_TX
     20841 ± 19%     +12.4%      23426 ± 49%      +5.7%      22027 ± 20%  softirqs.CPU62.RCU
     49538 ±  3%      -0.1%      49489 ± 13%      +3.8%      51441 ±  2%  softirqs.CPU62.SCHED
      1.89 ±247%     -69.1%       0.58 ±130%      +0.0%       1.89 ±212%  softirqs.CPU62.TASKLET
    103.78 ± 56%    +345.6%     462.42 ±194%      +3.7%     107.67 ± 70%  softirqs.CPU62.TIMER
      4.78 ±138%     -73.8%       1.25 ±308%     -97.7%       0.11 ±282%  softirqs.CPU63.BLOCK
     90.11 ±264%     +54.0%     138.75 ±239%   +1030.1%       1018 ±282%  softirqs.CPU63.NET_RX
      0.33 ±200%     -25.0%       0.25 ±173%     -66.7%       0.11 ±282%  softirqs.CPU63.NET_TX
     20934 ± 21%     +11.4%      23326 ± 47%      +3.2%      21602 ± 23%  softirqs.CPU63.RCU
     49439 ±  4%      +2.5%      50673 ±  4%      +4.0%      51398 ±  2%  softirqs.CPU63.SCHED
      1.78 ±229%    +125.0%       4.00 ±265%    -100.0%       0.00        softirqs.CPU63.TASKLET
    109.22 ± 58%    +158.6%     282.50 ±171%    +269.9%     404.00 ±146%  softirqs.CPU63.TIMER
      2.22 ±183%    +380.0%      10.67 ±309%    -100.0%       0.00        softirqs.CPU64.BLOCK
     27.11 ±275%    +183.4%      76.83 ±313%     -87.3%       3.44 ±161%  softirqs.CPU64.NET_RX
      0.22 ±187%     +50.0%       0.33 ±331%     -50.0%       0.11 ±282%  softirqs.CPU64.NET_TX
     18361 ± 21%     +13.9%      20906 ± 54%      +0.8%      18513 ± 21%  softirqs.CPU64.RCU
     50247 ±  2%      +2.7%      51620 ±  2%      +1.7%      51079 ±  2%  softirqs.CPU64.SCHED
      0.22 ±282%    +612.5%       1.58 ±242%      +0.0%       0.22 ±282%  softirqs.CPU64.TASKLET
    386.89 ±141%     -67.9%     124.00 ±127%     -65.9%     131.89 ±105%  softirqs.CPU64.TIMER
      0.22 ±187%   +2225.0%       5.17 ±256%    -100.0%       0.00        softirqs.CPU65.BLOCK
     10.11 ±198%    +339.3%      44.42 ±284%     -25.3%       7.56 ±204%  softirqs.CPU65.NET_RX
      0.11 ±282%     +50.0%       0.17 ±223%    +100.0%       0.22 ±187%  softirqs.CPU65.NET_TX
     17654 ± 18%     +16.4%      20540 ± 55%      +2.5%      18102 ± 24%  softirqs.CPU65.RCU
     49228 ±  3%      +3.7%      51069 ±  4%      -0.8%      48848 ± 16%  softirqs.CPU65.SCHED
      0.22 ±282%    +387.5%       1.08 ±278%    +750.0%       1.89 ±282%  softirqs.CPU65.TASKLET
    200.00 ± 83%     -25.3%     149.33 ± 87%     +18.8%     237.56 ±151%  softirqs.CPU65.TIMER
      5.11 ±269%     +53.3%       7.83 ±157%    +402.2%      25.67 ±180%  softirqs.CPU66.BLOCK
     14.78 ±266%    +171.2%      40.08 ±327%     -12.0%      13.00 ±264%  softirqs.CPU66.NET_RX
      0.22 ±282%     +50.0%       0.33 ±187%      +0.0%       0.22 ±187%  softirqs.CPU66.NET_TX
     16719 ± 22%     +12.2%      18755 ± 53%      +6.7%      17832 ± 24%  softirqs.CPU66.RCU
     46999 ± 14%      +5.3%      49508 ±  8%      +4.7%      49199 ±  9%  softirqs.CPU66.SCHED
      0.00          -100.0%       0.00       +3.3e+101%       0.33 ±282%  softirqs.CPU66.TASKLET
      1302 ±180%     -50.6%     643.58 ±241%     -85.8%     185.11 ± 89%  softirqs.CPU66.TIMER
      6.11 ±217%     +28.2%       7.83 ±170%     +20.0%       7.33 ±216%  softirqs.CPU67.BLOCK
      9.44 ±143%   +1015.3%     105.33 ±306%     -97.6%       0.22 ±282%  softirqs.CPU67.NET_RX
      0.89 ±134%     -71.9%       0.25 ±173%    -100.0%       0.00        softirqs.CPU67.NET_TX
     17631 ± 20%     +11.2%      19609 ± 52%      -0.3%      17576 ± 25%  softirqs.CPU67.RCU
     45003 ± 20%     +14.4%      51465 ±  4%      +7.9%      48537 ± 15%  softirqs.CPU67.SCHED
      2.22 ±162%     -43.8%       1.25 ±331%     -35.0%       1.44 ±282%  softirqs.CPU67.TASKLET
    705.78 ±132%     -79.2%     146.67 ± 89%     -52.8%     333.22 ±149%  softirqs.CPU67.TIMER
      4.78 ±275%     +20.3%       5.75 ±261%    -100.0%       0.00        softirqs.CPU68.BLOCK
     66.56 ±257%     -92.7%       4.83 ±258%     +19.5%      79.56 ±275%  softirqs.CPU68.NET_RX
      4.44 ±274%     -94.4%       0.25 ±238%     -90.0%       0.44 ±154%  softirqs.CPU68.NET_TX
     18043 ± 22%     +15.3%      20800 ± 56%      +2.7%      18530 ± 21%  softirqs.CPU68.RCU
     47181 ± 13%     +10.4%      52110 ±  2%      +7.7%      50821 ±  4%  softirqs.CPU68.SCHED
      2.33 ±282%     -78.6%       0.50 ±173%    -100.0%       0.00        softirqs.CPU68.TASKLET
     88.56 ± 56%    +768.4%     769.00 ±177%    +227.9%     290.33 ±170%  softirqs.CPU68.TIMER
      0.00       +6.7e+101%       0.67 ±331%   +1e+102%       1.00 ±249%  softirqs.CPU69.BLOCK
      1.11 ±166%    +380.0%       5.33 ±177%   +6210.0%      70.11 ±275%  softirqs.CPU69.NET_RX
      0.22 ±282%     +87.5%       0.42 ±182%     +50.0%       0.33 ±199%  softirqs.CPU69.NET_TX
     18237 ± 20%     +12.2%      20456 ± 58%      +1.0%      18425 ± 21%  softirqs.CPU69.RCU
     48624 ±  6%      +3.3%      50227 ±  6%      -1.4%      47924 ± 11%  softirqs.CPU69.SCHED
      0.00       +2.5e+101%       0.25 ±238%    -100.0%       0.00        softirqs.CPU69.TASKLET
    334.78 ±137%     -60.8%     131.33 ± 46%     -72.4%      92.56 ± 70%  softirqs.CPU69.TIMER
      7.56 ±157%     -92.3%       0.58 ±283%     -29.4%       5.33 ±244%  softirqs.CPU7.BLOCK
      0.89 ±245%    +659.4%       6.75 ±280%    +437.5%       4.78 ±151%  softirqs.CPU7.NET_RX
      0.00       +8.3e+100%       0.08 ±331% +3.3e+101%       0.33 ±282%  softirqs.CPU7.NET_TX
     20425 ± 20%     +14.5%      23387 ± 52%      +1.3%      20696 ± 22%  softirqs.CPU7.RCU
     49348 ±  4%      -0.1%      49313 ± 13%      +0.5%      49578 ±  9%  softirqs.CPU7.SCHED
      0.56 ±172%     -40.0%       0.33 ±223%     -80.0%       0.11 ±282%  softirqs.CPU7.TASKLET
    172.56 ±124%    +111.2%     364.42 ±183%     +86.9%     322.44 ±218%  softirqs.CPU7.TIMER
      1.78 ±263%     -20.3%       1.42 ±224%      +0.0%       1.78 ±245%  softirqs.CPU70.BLOCK
      3.00 ±191%  +23094.4%     695.83 ±330%   +3229.6%      99.89 ±177%  softirqs.CPU70.NET_RX
      0.22 ±282%     +12.5%       0.25 ±173%      +0.0%       0.22 ±282%  softirqs.CPU70.NET_TX
     17653 ± 20%     +15.5%      20391 ± 56%      -3.3%      17071 ± 30%  softirqs.CPU70.RCU
     49553 ±  3%      -8.3%      45424 ± 21%      +3.0%      51034        softirqs.CPU70.SCHED
      2.33 ±239%     -85.7%       0.33 ±187%     -76.2%       0.56 ±191%  softirqs.CPU70.TASKLET
    421.78 ±245%    +164.7%       1116 ±206%    +430.9%       2239 ±185%  softirqs.CPU70.TIMER
      7.78 ±191%     -81.8%       1.42 ±271%     -78.6%       1.67 ±241%  softirqs.CPU71.BLOCK
      2.67 ±231%  +71793.8%       1917 ±320%   +3870.8%     105.89 ±281%  softirqs.CPU71.NET_RX
      0.22 ±187%     -62.5%       0.08 ±331%     -50.0%       0.11 ±282%  softirqs.CPU71.NET_TX
     18238 ± 19%     +12.2%      20454 ± 55%      +1.7%      18548 ± 20%  softirqs.CPU71.RCU
     48137 ±  7%      +2.1%      49163 ± 12%      +6.4%      51236 ±  2%  softirqs.CPU71.SCHED
      0.00       +5.7e+102%       5.67 ±248% +1.1e+101%       0.11 ±282%  softirqs.CPU71.TASKLET
    501.22 ±163%     -20.6%     398.00 ±171%     -62.0%     190.44 ±125%  softirqs.CPU71.TIMER
      6.00 ±156%    +158.3%      15.50 ±225%     -40.7%       3.56 ±245%  softirqs.CPU72.BLOCK
      6.78 ±198%     -47.1%       3.58 ±265%  +53473.8%       3631 ±281%  softirqs.CPU72.NET_RX
      0.00       +3.6e+102%       3.58 ±298% +4.4e+102%       4.44 ±282%  softirqs.CPU72.NET_TX
     18811 ± 19%     +13.1%      21281 ± 56%      -9.5%      17018 ± 24%  softirqs.CPU72.RCU
     51911 ±  2%      +0.2%      51997            -4.3%      49701 ±  3%  softirqs.CPU72.SCHED
      0.11 ±282%    +575.0%       0.75 ±238%    -100.0%       0.00        softirqs.CPU72.TASKLET
    163.22 ±205%      +8.4%     177.00 ± 81%     -42.9%      93.22 ± 93%  softirqs.CPU72.TIMER
     15.56 ±278%     -97.3%       0.42 ±228%     +22.1%      19.00 ±176%  softirqs.CPU73.BLOCK
     94.22 ±282%     -61.0%      36.75 ±329%     -70.2%      28.11 ±252%  softirqs.CPU73.NET_RX
      0.00          -100.0%       0.00       +1.1e+101%       0.11 ±282%  softirqs.CPU73.NET_TX
     17225 ± 17%     +18.7%      20450 ± 56%      -4.8%      16401 ± 24%  softirqs.CPU73.RCU
     50971 ±  4%      +1.3%      51651 ±  3%      -5.5%      48158 ±  5%  softirqs.CPU73.SCHED
      1.44 ±282%    -100.0%       0.00            +0.0%       1.44 ±219%  softirqs.CPU73.TASKLET
    284.67 ±180%     -32.5%     192.08 ±154%     -55.0%     128.11 ± 84%  softirqs.CPU73.TIMER
     24.00 ±282%     -98.3%       0.42 ±153%     -96.8%       0.78 ±240%  softirqs.CPU74.BLOCK
     60.89 ±282%     -88.9%       6.75 ±242%     -27.0%      44.44 ±279%  softirqs.CPU74.NET_RX
      0.00          -100.0%       0.00       +1.1e+101%       0.11 ±282%  softirqs.CPU74.NET_TX
     17655 ± 14%     +18.6%      20931 ± 60%      -6.8%      16461 ± 23%  softirqs.CPU74.RCU
     51131 ±  3%      +1.6%      51924 ±  3%      -2.6%      49785 ±  6%  softirqs.CPU74.SCHED
      0.67 ±282%     -87.5%       0.08 ±331%     -83.3%       0.11 ±282%  softirqs.CPU74.TASKLET
    989.67 ±256%     +14.5%       1133 ±244%     -73.7%     259.89 ±144%  softirqs.CPU74.TIMER
      2.89 ±187%      -4.8%       2.75 ±290%    +819.2%      26.56 ±148%  softirqs.CPU75.BLOCK
      0.00       +3.3e+101%       0.33 ±331% +7.1e+103%      71.33 ±243%  softirqs.CPU75.NET_RX
     17115 ± 16%     +18.2%      20225 ± 57%      -3.4%      16532 ± 22%  softirqs.CPU75.RCU
     51071 ±  3%      -1.3%      50404 ±  6%      -3.6%      49217 ±  2%  softirqs.CPU75.SCHED
      0.00       +8.3e+100%       0.08 ±331%   +5e+102%       5.00 ±184%  softirqs.CPU75.TASKLET
    248.56 ±234%     -73.6%      65.58 ± 85%     -30.4%     172.89 ±208%  softirqs.CPU75.TIMER
      5.56 ±270%     +42.5%       7.92 ±252%     -64.0%       2.00 ±141%  softirqs.CPU76.BLOCK
      5.44 ±282%    +686.7%      42.83 ±330%    +740.8%      45.78 ±282%  softirqs.CPU76.NET_RX
      0.22 ±282%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU76.NET_TX
     18363 ± 19%     +16.4%      21372 ± 58%      -8.1%      16880 ± 23%  softirqs.CPU76.RCU
     51183 ±  3%      +0.6%      51507 ±  4%      -3.7%      49313 ±  2%  softirqs.CPU76.SCHED
      0.11 ±282%   +4775.0%       5.42 ±331%    -100.0%       0.00        softirqs.CPU76.TASKLET
     84.33 ±141%    +383.6%     407.83 ±277%     -54.2%      38.67 ± 81%  softirqs.CPU76.TIMER
     16.00 ±212%     -90.6%       1.50 ±331%     -73.6%       4.22 ±274%  softirqs.CPU77.BLOCK
      1.89 ±282%    +822.1%      17.42 ±308%  +4.2e+05%       7941 ±250%  softirqs.CPU77.NET_RX
      0.00       +8.3e+100%       0.08 ±331%    -100.0%       0.00        softirqs.CPU77.NET_TX
     18240 ± 19%     +20.5%      21987 ± 57%     -10.3%      16362 ± 27%  softirqs.CPU77.RCU
     49828 ±  9%      +0.6%      50104 ± 11%      -0.1%      49756 ±  3%  softirqs.CPU77.SCHED
      0.00       +8.3e+100%       0.08 ±331%    -100.0%       0.00        softirqs.CPU77.TASKLET
    843.33 ±245%     -84.6%     130.00 ±183%     +51.1%       1274 ±191%  softirqs.CPU77.TIMER
      8.56 ±258%     -24.0%       6.50 ±327%    +258.4%      30.67 ±160%  softirqs.CPU78.BLOCK
      0.11 ±282%   +1550.0%       1.83 ±331%    +500.0%       0.67 ±282%  softirqs.CPU78.NET_RX
      0.00       +1.7e+101%       0.17 ±331%    -100.0%       0.00        softirqs.CPU78.NET_TX
     17327 ± 18%     +15.8%      20059 ± 55%      -5.2%      16433 ± 24%  softirqs.CPU78.RCU
     50752 ±  4%      +1.6%      51546 ±  3%      -5.1%      48160 ±  3%  softirqs.CPU78.SCHED
      0.11 ±282%     -25.0%       0.08 ±331%    -100.0%       0.00        softirqs.CPU78.TASKLET
     80.00 ±130%     -41.5%      46.83 ± 95%      +3.3%      82.67 ± 90%  softirqs.CPU78.TIMER
      0.78 ±240%     -46.4%       0.42 ±331%    -100.0%       0.00        softirqs.CPU79.BLOCK
    321.33 ±149%     -63.1%     118.50 ±310%    -100.0%       0.00        softirqs.CPU79.NET_RX
     18585 ± 18%     +15.3%      21429 ± 57%      -9.5%      16824 ± 23%  softirqs.CPU79.RCU
     50722 ±  3%      +2.0%      51726 ±  2%      -3.7%      48848 ±  2%  softirqs.CPU79.SCHED
      1.56 ±196%     -89.3%       0.17 ±331%    -100.0%       0.00        softirqs.CPU79.TASKLET
     66.22 ±122%     -45.3%      36.25 ± 92%     -32.7%      44.56 ±106%  softirqs.CPU79.TIMER
      5.78 ±195%     -36.5%       3.67 ±229%    +407.7%      29.33 ±214%  softirqs.CPU8.BLOCK
      1.44 ±166%     -82.7%       0.25 ±173%   +3592.3%      53.33 ±253%  softirqs.CPU8.NET_RX
      0.33 ±199%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU8.NET_TX
     21261 ± 19%      +9.2%      23211 ± 48%      +2.2%      21734 ± 22%  softirqs.CPU8.RCU
     43950 ± 20%     +16.7%      51281 ± 15%     +14.8%      50469 ± 22%  softirqs.CPU8.SCHED
      0.11 ±282%     -25.0%       0.08 ±331%    -100.0%       0.00        softirqs.CPU8.TASKLET
    199.33 ±180%     -72.3%      55.25 ± 78%    +173.0%     544.22 ±174%  softirqs.CPU8.TIMER
      0.78 ±282%    +103.6%       1.58 ±295%   +1685.7%      13.89 ±241%  softirqs.CPU80.BLOCK
     17.33 ±282%      -1.4%      17.08 ±329%    +301.9%      69.67 ±270%  softirqs.CPU80.NET_RX
     23593 ± 22%     +15.0%      27127 ± 58%     -20.4%      18791 ± 22%  softirqs.CPU80.RCU
     51390 ±  2%      -5.5%      48538 ± 15%      -2.7%      49995        softirqs.CPU80.SCHED
      0.00          -100.0%       0.00          -100.0%       0.00        softirqs.CPU80.TASKLET
    107.00 ±132%     -52.8%      50.50 ±116%     -38.6%      65.67 ±113%  softirqs.CPU80.TIMER
     18.33 ±183%     -96.8%       0.58 ±247%     -70.9%       5.33 ±282%  softirqs.CPU81.BLOCK
      0.11 ±282%   +1175.0%       1.42 ±245%  +54100.0%      60.22 ±261%  softirqs.CPU81.NET_RX
      0.00          -100.0%       0.00          -100.0%       0.00        softirqs.CPU81.NET_TX
     21889 ± 20%     +17.1%      25637 ± 56%     -14.9%      18619 ± 21%  softirqs.CPU81.RCU
     50839 ±  4%      +0.2%      50926 ±  5%      -6.1%      47717 ±  4%  softirqs.CPU81.SCHED
      0.11 ±282%     -25.0%       0.08 ±331%    -100.0%       0.00        softirqs.CPU81.TASKLET
     99.00 ± 87%     -49.6%      49.92 ±114%     -39.2%      60.22 ± 75%  softirqs.CPU81.TIMER
      9.89 ±193%     -99.2%       0.08 ±331%     -77.5%       2.22 ±223%  softirqs.CPU82.BLOCK
      0.11 ±282%   +1250.0%       1.50 ±312%  +51200.0%      57.00 ±282%  softirqs.CPU82.NET_RX
     22805 ± 20%     +16.6%      26581 ± 55%     -16.3%      19076 ± 22%  softirqs.CPU82.RCU
     51203 ±  3%      +1.5%      51948 ±  3%      -4.2%      49036 ±  3%  softirqs.CPU82.SCHED
      0.11 ±282%   +2750.0%       3.17 ±331%    -100.0%       0.00        softirqs.CPU82.TASKLET
     79.67 ± 94%     -53.0%      37.42 ±142%     -23.7%      60.78 ± 97%  softirqs.CPU82.TIMER
     22.56 ±195%     -61.9%       8.58 ±182%     -87.7%       2.78 ±282%  softirqs.CPU83.BLOCK
     73.44 ±200%     -83.3%      12.25 ±321%     -39.2%      44.67 ±203%  softirqs.CPU83.NET_RX
     22459 ± 20%     +17.4%      26362 ± 57%     -13.4%      19459 ± 22%  softirqs.CPU83.RCU
     49530 ±  8%      +4.6%      51808 ±  2%      -1.6%      48732 ±  5%  softirqs.CPU83.SCHED
     28.44 ± 35%     +87.2%      53.25 ±135%    +105.5%      58.44 ±109%  softirqs.CPU83.TIMER
      1.89 ±166%    +147.1%       4.67 ±300%    -100.0%       0.00        softirqs.CPU84.BLOCK
      0.00          -100.0%       0.00       +1.9e+103%      18.67 ±187%  softirqs.CPU84.NET_RX
     20524 ± 20%     +12.4%      23060 ± 53%      -5.6%      19380 ± 24%  softirqs.CPU84.RCU
     50684 ±  4%      -4.9%      48189 ± 14%      -9.4%      45896 ± 14%  softirqs.CPU84.SCHED
    210.56 ±225%     -78.3%      45.75 ±123%     -62.1%      79.78 ± 92%  softirqs.CPU84.TIMER
      4.00 ±227%     +20.8%       4.83 ±257%    +180.6%      11.22 ±173%  softirqs.CPU85.BLOCK
     18.89 ±187%    +449.7%     103.83 ±222%     -95.3%       0.89 ±282%  softirqs.CPU85.NET_RX
      0.00          -100.0%       0.00       +1.1e+101%       0.11 ±282%  softirqs.CPU85.NET_TX
     22675 ± 22%     +12.8%      25586 ± 56%     -17.4%      18722 ± 24%  softirqs.CPU85.RCU
     50500 ±  4%      +2.5%      51753 ±  3%      -4.6%      48159 ±  3%  softirqs.CPU85.SCHED
      0.00          -100.0%       0.00       +5.2e+102%       5.22 ±276%  softirqs.CPU85.TASKLET
    192.44 ±212%     -55.7%      85.33 ±162%     -56.6%      83.44 ±130%  softirqs.CPU85.TIMER
     28.78 ±205%     -95.1%       1.42 ±183%     -20.5%      22.89 ±154%  softirqs.CPU86.BLOCK
      0.00       +9.4e+103%      93.58 ±239%    -100.0%       0.00        softirqs.CPU86.NET_RX
     23468 ± 23%     +17.7%      27632 ± 59%     -18.7%      19079 ± 22%  softirqs.CPU86.RCU
     51158 ±  3%      +1.5%      51945 ±  2%      -3.2%      49525 ±  2%  softirqs.CPU86.SCHED
      1.67 ±282%     -95.0%       0.08 ±331%     -93.3%       0.11 ±282%  softirqs.CPU86.TASKLET
    112.44 ±145%     -48.3%      58.17 ±122%     -30.9%      77.67 ± 81%  softirqs.CPU86.TIMER
      5.11 ±179%     +67.9%       8.58 ±293%    +154.3%      13.00 ±259%  softirqs.CPU87.BLOCK
     19.22 ±282%     -92.2%       1.50 ±312%     -80.9%       3.67 ±282%  softirqs.CPU87.NET_RX
      0.00          -100.0%       0.00       +3.3e+101%       0.33 ±282%  softirqs.CPU87.NET_TX
     20720 ± 19%     +17.6%      24371 ± 55%      -8.6%      18935 ± 20%  softirqs.CPU87.RCU
     50865 ±  3%      +1.5%      51645 ±  3%      -3.1%      49272 ±  2%  softirqs.CPU87.SCHED
      0.00          -100.0%       0.00       +3.3e+102%       3.33 ±252%  softirqs.CPU87.TASKLET
    181.33 ±161%     -49.3%      92.00 ± 79%     +25.9%     228.22 ±216%  softirqs.CPU87.TIMER
      7.78 ±225%      -6.8%       7.25 ±278%     -67.1%       2.56 ±282%  softirqs.CPU88.BLOCK
    287.44 ±282%     -81.0%      54.58 ±297%     -90.9%      26.22 ±282%  softirqs.CPU88.NET_RX
      0.22 ±282%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU88.NET_TX
     23299 ± 20%     +14.6%      26695 ± 54%     -18.0%      19106 ± 24%  softirqs.CPU88.RCU
     51078 ±  4%      +1.6%      51904 ±  2%      -4.8%      48622 ±  9%  softirqs.CPU88.SCHED
      0.00          -100.0%       0.00       +2.1e+102%       2.11 ±282%  softirqs.CPU88.TASKLET
     60.56 ±120%    +252.2%     213.25 ±226%    +292.1%     237.44 ±220%  softirqs.CPU88.TIMER
      5.33 ±243%     -25.0%       4.00 ±288%     -85.4%       0.78 ±240%  softirqs.CPU89.BLOCK
      6.67 ±247%    +271.2%      24.75 ±331%     -96.7%       0.22 ±187%  softirqs.CPU89.NET_RX
      0.00          -100.0%       0.00          -100.0%       0.00        softirqs.CPU89.NET_TX
     23476 ± 24%     +17.6%      27608 ± 57%     -16.3%      19639 ± 24%  softirqs.CPU89.RCU
     49036 ± 14%      +5.6%      51782 ±  3%      +0.5%      49280 ±  2%  softirqs.CPU89.SCHED
      0.00          -100.0%       0.00       +4.4e+101%       0.44 ±282%  softirqs.CPU89.TASKLET
    128.11 ±109%     -45.8%      69.42 ± 93%     -41.8%      74.56 ± 93%  softirqs.CPU89.TIMER
      8.44 ±188%    -100.0%       0.00           -68.4%       2.67 ±200%  softirqs.CPU9.BLOCK
     72.44 ±230%    +685.1%     568.75 ±226%     -99.4%       0.44 ±111%  softirqs.CPU9.NET_RX
      0.33 ±200%     -50.0%       0.17 ±223%     -66.7%       0.11 ±282%  softirqs.CPU9.NET_TX
     20699 ± 24%     +15.2%      23836 ± 41%      +2.1%      21140 ± 21%  softirqs.CPU9.RCU
     50649 ±  2%      +3.6%      52473            -2.9%      49177 ±  8%  softirqs.CPU9.SCHED
      2.89 ±216%     -39.4%       1.75 ±298%    -100.0%       0.00        softirqs.CPU9.TASKLET
     92.22 ± 78%   +1024.8%       1037 ±242%     -23.3%      70.78 ± 75%  softirqs.CPU9.TIMER
      8.11 ±261%     +54.1%      12.50 ±319%     -95.9%       0.33 ±200%  softirqs.CPU90.BLOCK
    359.11 ±282%   +1414.5%       5438 ±331%    -100.0%       0.00        softirqs.CPU90.NET_RX
     19034 ± 22%      +6.5%      20270 ± 49%      -1.0%      18843 ± 22%  softirqs.CPU90.RCU
     50884 ±  4%      +0.9%      51339 ±  2%      -5.3%      48199 ±  3%  softirqs.CPU90.SCHED
      0.00       +8.3e+100%       0.08 ±331% +1.1e+101%       0.11 ±282%  softirqs.CPU90.TASKLET
     95.67 ±125%     -13.3%      82.92 ± 80%     -44.4%      53.22 ±117%  softirqs.CPU90.TIMER
      0.56 ±282%   +1640.0%       9.67 ±214%   +5420.0%      30.67 ±226%  softirqs.CPU91.BLOCK
      6891 ±282%    -100.0%       0.08 ±331%    -100.0%       0.00        softirqs.CPU91.NET_RX
      0.33 ±199%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU91.NET_TX
     19717 ± 20%     +15.3%      22737 ± 52%      -5.3%      18663 ± 21%  softirqs.CPU91.RCU
     51094 ±  3%      +1.3%      51781 ±  2%      -2.9%      49634 ±  4%  softirqs.CPU91.SCHED
      0.00       +8.3e+100%       0.08 ±331% +1.1e+101%       0.11 ±282%  softirqs.CPU91.TASKLET
    131.78 ±134%     +45.1%     191.25 ±222%     +60.6%     211.67 ±217%  softirqs.CPU91.TIMER
      0.22 ±282%   +2712.5%       6.25 ±229%   +3600.0%       8.22 ±261%  softirqs.CPU92.BLOCK
      0.33 ±282%     -25.0%       0.25 ±331%   +6000.0%      20.33 ±272%  softirqs.CPU92.NET_RX
     23495 ± 23%     +16.3%      27316 ± 57%     -16.7%      19581 ± 25%  softirqs.CPU92.RCU
     51247 ±  2%      -2.5%      49961 ± 12%      -5.7%      48323 ±  8%  softirqs.CPU92.SCHED
     74.78 ±122%     -41.9%      43.42 ± 75%     -38.2%      46.22 ±134%  softirqs.CPU92.TIMER
     16.89 ±280%     -97.5%       0.42 ±331%     -80.3%       3.33 ±251%  softirqs.CPU93.BLOCK
      1368 ±206%     -83.4%     227.08 ±327%    -100.0%       0.00        softirqs.CPU93.NET_RX
     22947 ± 24%     +16.2%      26665 ± 57%     -17.3%      18973 ± 23%  softirqs.CPU93.RCU
     50793 ±  3%      +1.9%      51751 ±  2%      -4.0%      48766 ±  3%  softirqs.CPU93.SCHED
      0.00       +1.3e+102%       1.33 ±331% +1.6e+102%       1.56 ±260%  softirqs.CPU93.TASKLET
    360.44 ±227%     -77.2%      82.08 ±193%     -90.4%      34.67 ± 83%  softirqs.CPU93.TIMER
      0.78 ±169%     -25.0%       0.58 ±203%    +200.0%       2.33 ±198%  softirqs.CPU94.BLOCK
     23193 ± 23%     +16.4%      26990 ± 57%     -16.6%      19335 ± 23%  softirqs.CPU94.RCU
     51088 ±  3%      +1.8%      52010 ±  2%      -4.0%      49067 ±  2%  softirqs.CPU94.SCHED
      0.00       +1.7e+101%       0.17 ±223% +4.8e+102%       4.78 ±254%  softirqs.CPU94.TASKLET
     76.78 ±122%    +233.1%     255.75 ±202%     +20.3%      92.33 ±145%  softirqs.CPU94.TIMER
      6.89 ±244%     +40.3%       9.67 ±192%     -35.5%       4.44 ±195%  softirqs.CPU95.BLOCK
      0.22 ±187%   +1437.5%       3.42 ±305%      +0.0%       0.22 ±187%  softirqs.CPU95.NET_TX
     22570 ± 19%     +16.1%      26201 ± 52%     -13.0%      19642 ± 24%  softirqs.CPU95.RCU
     41358 ± 28%     -15.6%      34889 ± 27%      -2.6%      40276 ± 25%  softirqs.CPU95.SCHED
      3.11 ±196%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU95.TASKLET
     71.89 ± 61%    +450.6%     395.83 ±142%    +120.7%     158.67 ± 86%  softirqs.CPU95.TIMER
      2.00            +0.0%       2.00            +0.0%       2.00        softirqs.HI
     32269 ± 81%     -15.2%      27360 ±102%      -3.4%      31156 ± 92%  softirqs.NET_RX
     59.44 ±  2%      -2.6%      57.92 ±  2%      +3.6%      61.56 ±  8%  softirqs.NET_TX
   1949585 ± 18%     +14.8%    2237679 ± 53%      -5.0%    1852982 ± 21%  softirqs.RCU
   4756610            +1.6%    4831530 ±  2%      -0.3%    4741884        softirqs.SCHED
    860.44            -0.0%     860.42            -0.2%     858.44        softirqs.TASKLET
     30885 ±  9%      +4.3%      32212 ± 27%      -2.9%      29995 ± 13%  softirqs.TIMER
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.0:IO-APIC.2-edge.timer
     48.11 ±282%     -32.4%      32.50 ±264%     -92.4%       3.67 ±254%  interrupts.100:PCI-MSI.31981633-edge.i40e-eth0-TxRx-64
     16.33 ±192%    +428.1%      86.25 ±293%     -12.2%      14.33 ±208%  interrupts.101:PCI-MSI.31981634-edge.i40e-eth0-TxRx-65
     28.11 ±282%    +161.2%      73.42 ±330%     -32.4%      19.00 ±262%  interrupts.102:PCI-MSI.31981635-edge.i40e-eth0-TxRx-66
     18.67 ±152%    +954.9%     196.92 ±307%     -97.6%       0.44 ±187%  interrupts.103:PCI-MSI.31981636-edge.i40e-eth0-TxRx-67
     74.67 ±251%     -90.4%       7.17 ±331%    +108.2%     155.44 ±282%  interrupts.104:PCI-MSI.31981637-edge.i40e-eth0-TxRx-68
      0.00       +8.6e+102%       8.58 ±229%   +1e+104%     100.11 ±282%  interrupts.105:PCI-MSI.31981638-edge.i40e-eth0-TxRx-69
      4.33 ±282%  +32007.7%       1391 ±330%   +2859.0%     128.22 ±198%  interrupts.106:PCI-MSI.31981639-edge.i40e-eth0-TxRx-70
      3.78 ±264%  +92041.9%       3480 ±319%   +5494.1%     211.33 ±282%  interrupts.107:PCI-MSI.31981640-edge.i40e-eth0-TxRx-71
     13.44 ±200%     -54.1%       6.17 ±307%  +53891.7%       7258 ±282%  interrupts.108:PCI-MSI.31981641-edge.i40e-eth0-TxRx-72
    189.00 ±282%     -61.3%      73.08 ±331%     -70.5%      55.67 ±250%  interrupts.109:PCI-MSI.31981642-edge.i40e-eth0-TxRx-73
    103.56 ±282%     -87.7%      12.75 ±243%     -14.3%      88.78 ±279%  interrupts.110:PCI-MSI.31981643-edge.i40e-eth0-TxRx-74
      0.44 ±187%     -25.0%       0.33 ±223%  +29050.0%     129.56 ±242%  interrupts.111:PCI-MSI.31981644-edge.i40e-eth0-TxRx-75
      8.78 ±274%    +861.7%      84.42 ±331%    +946.8%      91.89 ±282%  interrupts.112:PCI-MSI.31981645-edge.i40e-eth0-TxRx-76
      3.33 ±282%    +955.0%      35.17 ±306%  +4.7e+05%      15833 ±251%  interrupts.113:PCI-MSI.31981646-edge.i40e-eth0-TxRx-77
      0.00       +3.8e+102%       3.83 ±331% +1.7e+102%       1.67 ±262%  interrupts.114:PCI-MSI.31981647-edge.i40e-eth0-TxRx-78
    573.11 ±161%     -71.8%     161.67 ±302%    -100.0%       0.00        interrupts.115:PCI-MSI.31981648-edge.i40e-eth0-TxRx-79
     35.11 ±280%      -1.3%      34.67 ±325%    +295.9%     139.00 ±271%  interrupts.116:PCI-MSI.31981649-edge.i40e-eth0-TxRx-80
      0.44 ±187%    +593.8%       3.08 ±238%  +26925.0%     120.11 ±262%  interrupts.117:PCI-MSI.31981650-edge.i40e-eth0-TxRx-81
      0.22 ±282%   +1100.0%       2.67 ±309%  +50000.0%     111.33 ±281%  interrupts.118:PCI-MSI.31981651-edge.i40e-eth0-TxRx-82
    144.56 ±200%     -83.0%      24.58 ±321%     -37.8%      89.89 ±202%  interrupts.119:PCI-MSI.31981652-edge.i40e-eth0-TxRx-83
      0.22 ±282%    +200.0%       0.67 ±141%  +15750.0%      35.22 ±184%  interrupts.120:PCI-MSI.31981653-edge.i40e-eth0-TxRx-84
     34.78 ±187%    +455.4%     193.17 ±218%     -99.4%       0.22 ±282%  interrupts.121:PCI-MSI.31981654-edge.i40e-eth0-TxRx-85
      0.00       +1.8e+104%     176.08 ±243% +1.1e+101%       0.11 ±282%  interrupts.122:PCI-MSI.31981655-edge.i40e-eth0-TxRx-86
     38.56 ±282%     -93.5%       2.50 ±331%     -79.8%       7.78 ±269%  interrupts.123:PCI-MSI.31981656-edge.i40e-eth0-TxRx-87
    564.11 ±282%     -80.6%     109.17 ±298%     -90.7%      52.56 ±282%  interrupts.124:PCI-MSI.31981657-edge.i40e-eth0-TxRx-88
     11.44 ±240%    +334.7%      49.75 ±330%     -95.1%       0.56 ±191%  interrupts.125:PCI-MSI.31981658-edge.i40e-eth0-TxRx-89
    538.78 ±282%   +1919.0%      10877 ±331%    -100.0%       0.22 ±187%  interrupts.126:PCI-MSI.31981659-edge.i40e-eth0-TxRx-90
     13770 ±282%    -100.0%       0.08 ±331%    -100.0%       0.00        interrupts.127:PCI-MSI.31981660-edge.i40e-eth0-TxRx-91
      0.89 ±215%     -62.5%       0.33 ±223%   +4400.0%      40.00 ±279%  interrupts.128:PCI-MSI.31981661-edge.i40e-eth0-TxRx-92
      2715 ±206%     -83.3%     454.17 ±327%    -100.0%       0.00        interrupts.129:PCI-MSI.31981662-edge.i40e-eth0-TxRx-93
    382.00            +0.1%     382.33            +0.2%     382.89        interrupts.293:PCI-MSI.327680-edge.xhci_hcd
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.295:PCI-MSI.65536-edge.ioat-msix
      0.00       +3.2e+103%      31.83 ±223%    -100.0%       0.00        interrupts.296:PCI-MSI.288768-edge.ahci[0000:00:11.5]
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.297:PCI-MSI.67584-edge.ioat-msix
     21.22 ±282%    -100.0%       0.00          -100.0%       0.00        interrupts.298:PCI-MSI.288768-edge.ahci[0000:00:11.5]
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.298:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.298:PCI-MSI.69632-edge.ioat-msix
      0.00       +1.6e+103%      15.92 ±331%    -100.0%       0.00        interrupts.299:PCI-MSI.288768-edge.ahci[0000:00:11.5]
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.299:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.299:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.29:PCI-MSI.48791552-edge.PCIe.PME,pciehp
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.300:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.300:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00       +2.1e+103%      21.22 ±282%  interrupts.301:PCI-MSI.288768-edge.ahci[0000:00:11.5]
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.301:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.301:PCI-MSI.75776-edge.ioat-msix
      0.00       +1.6e+103%      15.92 ±331%    -100.0%       0.00        interrupts.302:PCI-MSI.288768-edge.ahci[0000:00:11.5]
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.302:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.302:PCI-MSI.77824-edge.ioat-msix
     21.33 ±282%    -100.0%       0.00            -0.5%      21.22 ±282%  interrupts.303:PCI-MSI.288768-edge.ahci[0000:00:11.5]
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.303:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.303:PCI-MSI.79872-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.304:PCI-MSI.79872-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.305:PCI-MSI.67174400-edge.ioat-msix
     63.67 ±141%     -25.0%      47.75 ±173%     +33.3%      84.89 ±111%  interrupts.306:PCI-MSI.288768-edge.ahci[0000:00:11.5]
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.306:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.307:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.307:PCI-MSI.67176448-edge.ioat-msix
     21.22 ±282%     +50.0%      31.83 ±223%    -100.0%       0.00        interrupts.308:PCI-MSI.288768-edge.ahci[0000:00:11.5]
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.308:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.308:PCI-MSI.67178496-edge.ioat-msix
     21.22 ±282%     -25.0%      15.92 ±331%    -100.0%       0.00        interrupts.309:PCI-MSI.288768-edge.ahci[0000:00:11.5]
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.309:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.309:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.309:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.30:PCI-MSI.48807936-edge.PCIe.PME,pciehp
      0.00       +1.6e+103%      15.92 ±331% +2.1e+103%      21.22 ±282%  interrupts.310:PCI-MSI.288768-edge.ahci[0000:00:11.5]
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.310:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.310:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.310:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00       +2.1e+103%      21.22 ±282%  interrupts.311:PCI-MSI.288768-edge.ahci[0000:00:11.5]
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.311:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.311:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.311:PCI-MSI.67184640-edge.ioat-msix
     21.22 ±282%    -100.0%       0.00          -100.0%       0.00        interrupts.312:PCI-MSI.288768-edge.ahci[0000:00:11.5]
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.312:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.312:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.312:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.313:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.313:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.313:PCI-MSI.67188736-edge.ioat-msix
     21.22 ±282%     -25.0%      15.92 ±331%      +0.5%      21.33 ±282%  interrupts.314:PCI-MSI.288768-edge.ahci[0000:00:11.5]
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.314:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.314:PCI-MSI.67188736-edge.ioat-msix
     43.89 ± 89%    -100.0%       0.00           -81.5%       8.11 ±282%  interrupts.315:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.315:PCI-MSI.67188736-edge.ioat-msix
    969.11 ±263%     -89.3%     103.42 ±316%     -99.8%       2.22 ± 89%  interrupts.36:PCI-MSI.31981569-edge.i40e-eth0-TxRx-0
      3070 ±274%     -99.9%       3.33 ±314%     -99.7%       9.89 ±162%  interrupts.37:PCI-MSI.31981570-edge.i40e-eth0-TxRx-1
      3.89 ±240%   +2315.0%      93.92 ±311%   +4357.1%     173.33 ±261%  interrupts.38:PCI-MSI.31981571-edge.i40e-eth0-TxRx-2
     38.44 ±231%     -90.9%       3.50 ±331%    +181.8%     108.33 ±270%  interrupts.39:PCI-MSI.31981572-edge.i40e-eth0-TxRx-3
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.3:IO-APIC.3-edge
     34.78 ±189%    +482.5%     202.58 ±304%     -99.4%       0.22 ±282%  interrupts.40:PCI-MSI.31981573-edge.i40e-eth0-TxRx-4
      2667 ±282%     -97.6%      63.42 ±325%     -99.8%       5.78 ±282%  interrupts.41:PCI-MSI.31981574-edge.i40e-eth0-TxRx-5
     11109 ±282%     -99.2%      84.50 ±317%     -98.4%     176.56 ±165%  interrupts.42:PCI-MSI.31981575-edge.i40e-eth0-TxRx-6
      1.44 ±282%    +690.4%      11.42 ±331%    +507.7%       8.78 ±150%  interrupts.43:PCI-MSI.31981576-edge.i40e-eth0-TxRx-7
      2.00 ±265%     -83.3%       0.33 ±223%   +5216.7%     106.33 ±255%  interrupts.44:PCI-MSI.31981577-edge.i40e-eth0-TxRx-8
    143.78 ±232%    +416.9%     743.25 ±221%     -99.9%       0.11 ±282%  interrupts.45:PCI-MSI.31981578-edge.i40e-eth0-TxRx-9
    206.67 ±157%     -91.1%      18.33 ±224%     -28.0%     148.89 ±280%  interrupts.46:PCI-MSI.31981579-edge.i40e-eth0-TxRx-10
     64.78 ±206%     -10.2%      58.17 ±330%     -76.5%      15.22 ±201%  interrupts.47:PCI-MSI.31981580-edge.i40e-eth0-TxRx-11
      6.78 ±205%   +7985.2%     548.00 ±331%  +2.1e+05%      14116 ±271%  interrupts.48:PCI-MSI.31981581-edge.i40e-eth0-TxRx-12
      6939 ±277%     -99.5%      31.25 ±286%     -99.4%      42.67 ±239%  interrupts.49:PCI-MSI.31981582-edge.i40e-eth0-TxRx-13
     49.33 ±  6%      -0.3%      49.17 ±  6%      -1.1%      48.78 ±  5%  interrupts.4:IO-APIC.4-edge.ttyS0
    158.44 ±195%   +2058.4%       3419 ±329%     -84.0%      25.33 ±278%  interrupts.50:PCI-MSI.31981583-edge.i40e-eth0-TxRx-14
     34.11 ±282%     +60.5%      54.75 ±221%    +225.7%     111.11 ±212%  interrupts.51:PCI-MSI.31981584-edge.i40e-eth0-TxRx-15
      5.00 ±282%      -1.7%       4.92 ±224%   +3397.8%     174.89 ±250%  interrupts.52:PCI-MSI.31981585-edge.i40e-eth0-TxRx-16
     17.33 ±187%    +499.0%     103.83 ±326%     +41.0%      24.44 ±200%  interrupts.53:PCI-MSI.31981586-edge.i40e-eth0-TxRx-17
     21.11 ±282%     +64.6%      34.75 ±314%    +266.8%      77.44 ±274%  interrupts.54:PCI-MSI.31981587-edge.i40e-eth0-TxRx-18
     69.67 ±280%  +10011.4%       7044 ±331%     -88.7%       7.89 ±187%  interrupts.55:PCI-MSI.31981588-edge.i40e-eth0-TxRx-19
      1.56 ±282%  +11032.1%     173.17 ±226%   +2428.6%      39.33 ±281%  interrupts.56:PCI-MSI.31981589-edge.i40e-eth0-TxRx-20
      2.00 ±174%    +216.7%       6.33 ±286%     +83.3%       3.67 ±282%  interrupts.57:PCI-MSI.31981590-edge.i40e-eth0-TxRx-21
      0.00       +8.4e+103%      83.67 ±296% +2.8e+102%       2.78 ±258%  interrupts.58:PCI-MSI.31981591-edge.i40e-eth0-TxRx-22
     66.67 ±231%      -6.6%      62.25 ±285%    +767.5%     578.33 ±239%  interrupts.59:PCI-MSI.31981592-edge.i40e-eth0-TxRx-23
     54.78 ±213%    +314.1%     226.83 ±238%    +235.9%     184.00 ±242%  interrupts.60:PCI-MSI.31981593-edge.i40e-eth0-TxRx-24
      1582 ±282%     -99.2%      13.25 ±327%     -98.8%      19.67 ±186%  interrupts.61:PCI-MSI.31981594-edge.i40e-eth0-TxRx-25
      0.00       +2.8e+102%       2.83 ±245% +2.2e+101%       0.22 ±282%  interrupts.62:PCI-MSI.31981595-edge.i40e-eth0-TxRx-26
     63.22 ±281%     -83.5%      10.42 ±331%     -87.9%       7.67 ±264%  interrupts.63:PCI-MSI.31981596-edge.i40e-eth0-TxRx-27
    210.89 ±257%     -93.3%      14.17 ±304%     -21.5%     165.56 ±281%  interrupts.64:PCI-MSI.31981597-edge.i40e-eth0-TxRx-28
      9.00 ±267%     -63.9%       3.25 ±313%    +807.4%      81.67 ±261%  interrupts.65:PCI-MSI.31981598-edge.i40e-eth0-TxRx-29
      0.00       +1.8e+103%      18.33 ±174% +1.8e+103%      17.67 ±278%  interrupts.66:PCI-MSI.31981599-edge.i40e-eth0-TxRx-30
     14016 ±282%     -97.8%     306.33 ±202%     -99.9%      11.44 ±270%  interrupts.67:PCI-MSI.31981600-edge.i40e-eth0-TxRx-31
    102.11 ±233%    +177.2%     283.08 ±127%     -99.8%       0.22 ±282%  interrupts.68:PCI-MSI.31981601-edge.i40e-eth0-TxRx-32
    219.67 ±193%     -95.8%       9.17 ±262%    -100.0%       0.00        interrupts.69:PCI-MSI.31981602-edge.i40e-eth0-TxRx-33
     11.78 ±242%    +698.8%      94.08 ±331%     -92.5%       0.89 ±215%  interrupts.70:PCI-MSI.31981603-edge.i40e-eth0-TxRx-34
      2.11 ±251%    +136.8%       5.00 ±228%  +18221.1%     386.78 ±282%  interrupts.71:PCI-MSI.31981604-edge.i40e-eth0-TxRx-35
    207.78 ±195%     -61.7%      79.58 ±331%    +793.1%       1855 ±272%  interrupts.72:PCI-MSI.31981605-edge.i40e-eth0-TxRx-36
      0.22 ±282%  +1.7e+05%     378.75 ±315%  +12000.0%      26.89 ±194%  interrupts.73:PCI-MSI.31981606-edge.i40e-eth0-TxRx-37
    182.33 ±265%    +276.7%     686.92 ±327%     -48.2%      94.44 ±282%  interrupts.74:PCI-MSI.31981607-edge.i40e-eth0-TxRx-38
    344.67 ±273%     -89.5%      36.25 ±319%     -51.7%     166.56 ±282%  interrupts.75:PCI-MSI.31981608-edge.i40e-eth0-TxRx-39
    101.89 ±282%     +15.3%     117.50 ±331%     +27.0%     129.44 ±282%  interrupts.76:PCI-MSI.31981609-edge.i40e-eth0-TxRx-40
     37.89 ±223%     -94.3%       2.17 ±278%     +91.2%      72.44 ±244%  interrupts.77:PCI-MSI.31981610-edge.i40e-eth0-TxRx-41
     16.67 ±278%    +357.0%      76.17 ±319%     -77.3%       3.78 ±273%  interrupts.78:PCI-MSI.31981611-edge.i40e-eth0-TxRx-42
      0.00       +8.5e+102%       8.50 ±324% +1.2e+103%      12.22 ±210%  interrupts.79:PCI-MSI.31981612-edge.i40e-eth0-TxRx-43
     33.78 ±280%    +112.2%      71.67 ±323%    +195.4%      99.78 ±282%  interrupts.80:PCI-MSI.31981613-edge.i40e-eth0-TxRx-44
      0.00       +1.7e+104%     165.42 ±254% +1.7e+103%      17.44 ±282%  interrupts.81:PCI-MSI.31981614-edge.i40e-eth0-TxRx-45
    108.67 ±252%      +9.2%     118.67 ±234%     -98.2%       2.00 ±282%  interrupts.82:PCI-MSI.31981615-edge.i40e-eth0-TxRx-46
     11.33 ±245%     +80.1%      20.42 ±223%     -95.1%       0.56 ±226%  interrupts.83:PCI-MSI.31981616-edge.i40e-eth0-TxRx-47
    134.22 ±273%     -99.8%       0.33 ±223%     -99.5%       0.67 ±200%  interrupts.84:PCI-MSI.31981617-edge.i40e-eth0-TxRx-48
     56.56 ±277%  +20032.9%      11386 ±233%     -94.5%       3.11 ±162%  interrupts.85:PCI-MSI.31981618-edge.i40e-eth0-TxRx-49
     18.67 ±262%   +1340.2%     268.83 ±324%     +60.7%      30.00 ±282%  interrupts.86:PCI-MSI.31981619-edge.i40e-eth0-TxRx-50
    114.33 ±278%     +23.7%     141.42 ±195%     +37.4%     157.11 ±236%  interrupts.87:PCI-MSI.31981620-edge.i40e-eth0-TxRx-51
      1.44 ±193%   +8196.2%     119.83 ±295%    +284.6%       5.56 ±119%  interrupts.88:PCI-MSI.31981621-edge.i40e-eth0-TxRx-52
      5.22 ±282%     -18.6%       4.25 ±227%     -42.6%       3.00 ±282%  interrupts.89:PCI-MSI.31981622-edge.i40e-eth0-TxRx-53
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.8:IO-APIC.8-edge.rtc0
      9.89 ±234%    +852.2%      94.17 ±329%     -66.3%       3.33 ±282%  interrupts.90:PCI-MSI.31981623-edge.i40e-eth0-TxRx-54
      0.56 ±149%   +2450.0%      14.17 ±179%  +23960.0%     133.67 ±282%  interrupts.91:PCI-MSI.31981624-edge.i40e-eth0-TxRx-55
     33.78 ±282%     -92.6%       2.50 ±308%  +43009.5%      14561 ±282%  interrupts.92:PCI-MSI.31981625-edge.i40e-eth0-TxRx-56
    289.89 ±219%     -99.4%       1.67 ±297%     -96.7%       9.67 ±275%  interrupts.93:PCI-MSI.31981626-edge.i40e-eth0-TxRx-57
      0.00       +3.5e+104%     349.58 ±315% +1.2e+104%     115.44 ±238%  interrupts.94:PCI-MSI.31981627-edge.i40e-eth0-TxRx-58
      0.00       +4.1e+103%      40.75 ±288% +2.6e+103%      26.11 ±187%  interrupts.95:PCI-MSI.31981628-edge.i40e-eth0-TxRx-59
    281.22 ±281%     -64.3%     100.42 ±296%      +7.5%     302.22 ±141%  interrupts.96:PCI-MSI.31981629-edge.i40e-eth0-TxRx-60
    201.89 ±279%     -26.8%     147.75 ±323%     -97.2%       5.67 ±162%  interrupts.97:PCI-MSI.31981630-edge.i40e-eth0-TxRx-61
    349.11 ±217%    +161.4%     912.42 ±195%     -96.9%      10.89 ±276%  interrupts.98:PCI-MSI.31981631-edge.i40e-eth0-TxRx-62
    178.22 ±268%     +48.2%     264.17 ±242%   +1035.8%       2024 ±282%  interrupts.99:PCI-MSI.31981632-edge.i40e-eth0-TxRx-63
     95682 ± 20%      -2.6%      93152 ± 26%     +35.9%     130063 ± 14%  interrupts.CAL:Function_call_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU0.0:IO-APIC.2-edge.timer
      0.22 ±187%     +12.5%       0.25 ±173%     +50.0%       0.33 ±141%  interrupts.CPU0.119:PCI-MSI.31981652-edge.i40e-eth0-TxRx-83
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU0.301:PCI-MSI.75776-edge.ioat-msix
    969.00 ±263%     -89.3%     103.25 ±316%     -99.8%       2.11 ± 95%  interrupts.CPU0.36:PCI-MSI.31981569-edge.i40e-eth0-TxRx-0
      0.11 ±282%    -100.0%       0.00          +100.0%       0.22 ±187%  interrupts.CPU0.71:PCI-MSI.31981604-edge.i40e-eth0-TxRx-35
      1946 ±166%     -55.4%     867.75 ±116%     +47.5%       2872 ±190%  interrupts.CPU0.CAL:Function_call_interrupts
    774652 ±  3%      -6.7%     722676 ± 18%      +1.2%     783713        interrupts.CPU0.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU0.MCP:Machine_check_polls
     90.56 ± 37%    +144.6%     221.50 ±189%     -14.0%      77.89 ± 12%  interrupts.CPU0.NMI:Non-maskable_interrupts
     90.56 ± 37%    +144.6%     221.50 ±189%     -14.0%      77.89 ± 12%  interrupts.CPU0.PMI:Performance_monitoring_interrupts
     13.00 ± 51%    +241.0%      44.33 ±172%      +5.1%      13.67 ± 73%  interrupts.CPU0.RES:Rescheduling_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU0.RTR:APIC_ICR_read_retries
      1.89 ± 76%     +54.4%       2.92 ±116%     +88.2%       3.56 ± 44%  interrupts.CPU0.TLB:TLB_shootdowns
      0.11 ±282%    +200.0%       0.33 ±141%    +200.0%       0.33 ±141%  interrupts.CPU1.120:PCI-MSI.31981653-edge.i40e-eth0-TxRx-84
      3070 ±274%     -99.9%       3.25 ±322%     -99.7%       9.56 ±166%  interrupts.CPU1.37:PCI-MSI.31981570-edge.i40e-eth0-TxRx-1
      0.33 ±141%    -100.0%       0.00           -33.3%       0.22 ±187%  interrupts.CPU1.72:PCI-MSI.31981605-edge.i40e-eth0-TxRx-36
    547.78 ± 20%     +72.0%     942.33 ± 69%    +840.1%       5149 ±248%  interrupts.CPU1.CAL:Function_call_interrupts
      0.00       +8.3e+100%       0.08 ±331%    -100.0%       0.00        interrupts.CPU1.IWI:IRQ_work_interrupts
    774552 ±  3%      -6.7%     722476 ± 18%      +1.2%     783803        interrupts.CPU1.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU1.MCP:Machine_check_polls
     84.33 ± 26%    +611.5%     600.00 ±238%    +157.2%     216.89 ±188%  interrupts.CPU1.NMI:Non-maskable_interrupts
     84.33 ± 26%    +611.5%     600.00 ±238%    +157.2%     216.89 ±188%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
     22.22 ± 49%      +1.3%      22.50 ± 62%     -39.0%      13.56 ± 72%  interrupts.CPU1.RES:Rescheduling_interrupts
      1.67 ± 74%      +0.0%       1.67 ±143%    +120.0%       3.67 ± 38%  interrupts.CPU1.TLB:TLB_shootdowns
      0.11 ±282%     +50.0%       0.17 ±223%    -100.0%       0.00        interrupts.CPU10.129:PCI-MSI.31981662-edge.i40e-eth0-TxRx-93
    382.00            +0.1%     382.33            +0.2%     382.89        interrupts.CPU10.293:PCI-MSI.327680-edge.xhci_hcd
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU10.298:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU10.315:PCI-MSI.376832-edge.ahci[0000:00:17.0]
    206.44 ±157%     -91.1%      18.33 ±224%     -28.0%     148.67 ±280%  interrupts.CPU10.46:PCI-MSI.31981579-edge.i40e-eth0-TxRx-10
      0.00       +8.3e+100%       0.08 ±331%    -100.0%       0.00        interrupts.CPU10.81:PCI-MSI.31981614-edge.i40e-eth0-TxRx-45
    564.33 ±  9%      +0.3%     565.92 ±  8%    +190.5%       1639 ±162%  interrupts.CPU10.CAL:Function_call_interrupts
    774527 ±  3%      -6.7%     722599 ± 18%      +1.2%     783661        interrupts.CPU10.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU10.MCP:Machine_check_polls
     94.44 ± 30%      -1.2%      93.33 ± 36%     -17.9%      77.56 ± 10%  interrupts.CPU10.NMI:Non-maskable_interrupts
     94.44 ± 30%      -1.2%      93.33 ± 36%     -17.9%      77.56 ± 10%  interrupts.CPU10.PMI:Performance_monitoring_interrupts
     30.67 ± 80%   +2062.2%     663.08 ±318%    +147.1%      75.78 ±214%  interrupts.CPU10.RES:Rescheduling_interrupts
      1.44 ±118%     +38.5%       2.00 ±145%    +169.2%       3.89 ± 47%  interrupts.CPU10.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU11.298:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU11.298:PCI-MSI.69632-edge.ioat-msix
      0.00       +1.6e+103%      15.92 ±331%    -100.0%       0.00        interrupts.CPU11.299:PCI-MSI.288768-edge.ahci[0000:00:11.5]
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU11.299:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU11.299:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU11.300:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU11.303:PCI-MSI.79872-edge.ioat-msix
     64.56 ±207%     -10.2%      58.00 ±331%     -76.8%      15.00 ±205%  interrupts.CPU11.47:PCI-MSI.31981580-edge.i40e-eth0-TxRx-11
      0.33 ±141%     -50.0%       0.17 ±223%     -66.7%       0.11 ±282%  interrupts.CPU11.82:PCI-MSI.31981615-edge.i40e-eth0-TxRx-46
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU11.8:IO-APIC.8-edge.rtc0
    825.44 ± 88%     +45.0%       1196 ±109%     -33.7%     547.00 ±  2%  interrupts.CPU11.CAL:Function_call_interrupts
      0.00       +8.3e+100%       0.08 ±331% +1.1e+101%       0.11 ±282%  interrupts.CPU11.IWI:IRQ_work_interrupts
    774519 ±  3%      -6.7%     722533 ± 18%      +1.2%     783775        interrupts.CPU11.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU11.MCP:Machine_check_polls
    108.89 ± 14%    +354.2%     494.58 ±267%    +547.0%     704.56 ±249%  interrupts.CPU11.NMI:Non-maskable_interrupts
    108.89 ± 14%    +354.2%     494.58 ±267%    +547.0%     704.56 ±249%  interrupts.CPU11.PMI:Performance_monitoring_interrupts
     27.89 ±104%     -14.5%      23.83 ± 91%     -34.7%      18.22 ± 39%  interrupts.CPU11.RES:Rescheduling_interrupts
      2.00 ± 97%     +12.5%       2.25 ±134%    +111.1%       4.22 ± 39%  interrupts.CPU11.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU12.295:PCI-MSI.65536-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU12.299:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU12.299:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU12.300:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU12.300:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU12.301:PCI-MSI.75776-edge.ioat-msix
     21.22 ±282%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU12.306:PCI-MSI.288768-edge.ahci[0000:00:11.5]
      6.67 ±208%   +8116.2%     547.75 ±331%  +2.1e+05%      14116 ±271%  interrupts.CPU12.48:PCI-MSI.31981581-edge.i40e-eth0-TxRx-12
      5.67 ±282%     +50.0%       8.50 ±223%     +90.2%      10.78 ±187%  interrupts.CPU12.4:IO-APIC.4-edge.ttyS0
      0.00       +8.3e+100%       0.08 ±331% +1.1e+101%       0.11 ±282%  interrupts.CPU12.83:PCI-MSI.31981616-edge.i40e-eth0-TxRx-47
    557.44 ±  5%      -3.0%     540.67 ±  5%    +238.2%       1885 ±177%  interrupts.CPU12.CAL:Function_call_interrupts
    774602 ±  3%      -6.7%     722477 ± 18%      +1.2%     783722        interrupts.CPU12.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU12.MCP:Machine_check_polls
     92.67 ± 28%    +115.1%     199.33 ±180%     -19.5%      74.56 ± 18%  interrupts.CPU12.NMI:Non-maskable_interrupts
     92.67 ± 28%    +115.1%     199.33 ±180%     -19.5%      74.56 ± 18%  interrupts.CPU12.PMI:Performance_monitoring_interrupts
    200.56 ±256%     -84.9%      30.33 ± 88%     -89.8%      20.44 ± 52%  interrupts.CPU12.RES:Rescheduling_interrupts
      2.44 ±109%      -8.0%       2.25 ±117%     +77.3%       4.33 ± 42%  interrupts.CPU12.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU13.295:PCI-MSI.65536-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU13.298:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU13.300:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU13.300:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00       +2.1e+103%      21.22 ±282%  interrupts.CPU13.301:PCI-MSI.288768-edge.ahci[0000:00:11.5]
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU13.301:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU13.301:PCI-MSI.75776-edge.ioat-msix
      0.00       +1.6e+103%      15.92 ±331%    -100.0%       0.00        interrupts.CPU13.302:PCI-MSI.288768-edge.ahci[0000:00:11.5]
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU13.302:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU13.315:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.11 ±282%     +50.0%       0.17 ±223%      +0.0%       0.11 ±282%  interrupts.CPU13.36:PCI-MSI.31981569-edge.i40e-eth0-TxRx-0
      6939 ±277%     -99.6%      31.08 ±288%     -99.4%      42.56 ±240%  interrupts.CPU13.49:PCI-MSI.31981582-edge.i40e-eth0-TxRx-13
     11.67 ±187%     -27.9%       8.42 ±224%      -7.6%      10.78 ±187%  interrupts.CPU13.4:IO-APIC.4-edge.ttyS0
      0.00       +1.7e+101%       0.17 ±223% +1.1e+101%       0.11 ±282%  interrupts.CPU13.84:PCI-MSI.31981617-edge.i40e-eth0-TxRx-48
    878.00 ± 57%     -37.8%     546.50 ±  2%     -15.8%     739.11 ± 74%  interrupts.CPU13.CAL:Function_call_interrupts
      0.11 ±282%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU13.IWI:IRQ_work_interrupts
    774539 ±  3%      -6.7%     722427 ± 18%      +1.2%     783671        interrupts.CPU13.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU13.MCP:Machine_check_polls
    980.44 ±172%     -70.1%     293.25 ±217%     -92.5%      73.44 ± 18%  interrupts.CPU13.NMI:Non-maskable_interrupts
    980.44 ±172%     -70.1%     293.25 ±217%     -92.5%      73.44 ± 18%  interrupts.CPU13.PMI:Performance_monitoring_interrupts
     19.67 ± 68%    +147.0%      48.58 ±135%    +132.2%      45.67 ±125%  interrupts.CPU13.RES:Rescheduling_interrupts
      1.67 ±109%     +35.0%       2.25 ±140%    +166.7%       4.44 ± 30%  interrupts.CPU13.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU14.295:PCI-MSI.65536-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU14.300:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU14.301:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU14.301:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU14.302:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU14.302:PCI-MSI.77824-edge.ioat-msix
     21.33 ±282%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU14.303:PCI-MSI.288768-edge.ahci[0000:00:11.5]
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU14.303:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU14.303:PCI-MSI.79872-edge.ioat-msix
      0.00       +8.3e+100%       0.08 ±331% +3.3e+101%       0.33 ±141%  interrupts.CPU14.37:PCI-MSI.31981570-edge.i40e-eth0-TxRx-1
     10.78 ±187%     -21.9%       8.42 ±224%    -100.0%       0.00        interrupts.CPU14.4:IO-APIC.4-edge.ttyS0
    158.22 ±195%   +2061.5%       3419 ±329%     -84.1%      25.11 ±281%  interrupts.CPU14.50:PCI-MSI.31981583-edge.i40e-eth0-TxRx-14
      0.00       +1.7e+101%       0.17 ±223% +2.2e+101%       0.22 ±187%  interrupts.CPU14.85:PCI-MSI.31981618-edge.i40e-eth0-TxRx-49
    709.22 ± 61%     -25.7%     526.67 ± 10%     -21.3%     558.44 ±  6%  interrupts.CPU14.CAL:Function_call_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU14.IWI:IRQ_work_interrupts
    774500 ±  3%      -6.7%     722695 ± 18%      +1.2%     783694        interrupts.CPU14.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU14.MCP:Machine_check_polls
    145.67 ± 94%      -0.5%     144.92 ±102%     -55.5%      64.78 ± 40%  interrupts.CPU14.NMI:Non-maskable_interrupts
    145.67 ± 94%      -0.5%     144.92 ±102%     -55.5%      64.78 ± 40%  interrupts.CPU14.PMI:Performance_monitoring_interrupts
     76.78 ±147%     -47.3%      40.50 ± 74%     -74.7%      19.44 ± 49%  interrupts.CPU14.RES:Rescheduling_interrupts
      1.44 ±113%     +32.7%       1.92 ±146%    +176.9%       4.00 ± 35%  interrupts.CPU14.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU15.301:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU15.302:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU15.302:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00       +2.1e+103%      21.22 ±282%  interrupts.CPU15.303:PCI-MSI.288768-edge.ahci[0000:00:11.5]
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU15.303:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU15.303:PCI-MSI.79872-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU15.304:PCI-MSI.79872-edge.ioat-msix
     21.22 ±282%     -25.0%      15.92 ±331%    -100.0%       0.00        interrupts.CPU15.309:PCI-MSI.288768-edge.ahci[0000:00:11.5]
      0.00          -100.0%       0.00       +4.4e+101%       0.44 ±111%  interrupts.CPU15.38:PCI-MSI.31981571-edge.i40e-eth0-TxRx-2
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU15.3:IO-APIC.3-edge
      0.00       +7.7e+102%       7.67 ±223%    -100.0%       0.00        interrupts.CPU15.4:IO-APIC.4-edge.ttyS0
     34.00 ±282%     +60.0%      54.42 ±223%    +226.5%     111.00 ±213%  interrupts.CPU15.51:PCI-MSI.31981584-edge.i40e-eth0-TxRx-15
      0.22 ±187%     -25.0%       0.17 ±223%     -50.0%       0.11 ±282%  interrupts.CPU15.86:PCI-MSI.31981619-edge.i40e-eth0-TxRx-50
      1272 ±158%     -19.3%       1026 ± 73%     -52.8%     600.56 ± 25%  interrupts.CPU15.CAL:Function_call_interrupts
      0.00       +8.3e+100%       0.08 ±331%    -100.0%       0.00        interrupts.CPU15.IWI:IRQ_work_interrupts
    774611 ±  3%      -6.7%     722447 ± 18%      +1.2%     783698        interrupts.CPU15.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU15.MCP:Machine_check_polls
     93.89 ± 29%    +499.7%     563.08 ±271%     -35.5%      60.56 ± 36%  interrupts.CPU15.NMI:Non-maskable_interrupts
     93.89 ± 29%    +499.7%     563.08 ±271%     -35.5%      60.56 ± 36%  interrupts.CPU15.PMI:Performance_monitoring_interrupts
    366.78 ±273%     -93.9%      22.25 ± 66%     -94.9%      18.78 ± 69%  interrupts.CPU15.RES:Rescheduling_interrupts
      2.00 ± 97%      +0.0%       2.00 ±148%    +116.7%       4.33 ± 40%  interrupts.CPU15.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU16.295:PCI-MSI.65536-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU16.297:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU16.302:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU16.303:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU16.303:PCI-MSI.79872-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU16.304:PCI-MSI.79872-edge.ioat-msix
      0.00       +1.6e+103%      15.92 ±331% +4.2e+103%      42.44 ±187%  interrupts.CPU16.306:PCI-MSI.288768-edge.ahci[0000:00:11.5]
     21.22 ±282%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU16.308:PCI-MSI.288768-edge.ahci[0000:00:11.5]
      0.00          -100.0%       0.00       +2.1e+103%      21.22 ±282%  interrupts.CPU16.310:PCI-MSI.288768-edge.ahci[0000:00:11.5]
      0.00       +1.6e+103%      15.92 ±331% +2.1e+103%      21.33 ±282%  interrupts.CPU16.314:PCI-MSI.288768-edge.ahci[0000:00:11.5]
      9.33 ±282%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU16.315:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.33 ±141%    -100.0%       0.00           -66.7%       0.11 ±282%  interrupts.CPU16.39:PCI-MSI.31981572-edge.i40e-eth0-TxRx-3
      0.00          -100.0%       0.00       +5.7e+102%       5.67 ±282%  interrupts.CPU16.4:IO-APIC.4-edge.ttyS0
      5.00 ±282%      -5.0%       4.75 ±224%   +3395.6%     174.78 ±251%  interrupts.CPU16.52:PCI-MSI.31981585-edge.i40e-eth0-TxRx-16
      0.22 ±187%     -62.5%       0.08 ±331%     -50.0%       0.11 ±282%  interrupts.CPU16.87:PCI-MSI.31981620-edge.i40e-eth0-TxRx-51
      1913 ±199%     -50.2%     952.92 ±117%     -43.9%       1072 ± 64%  interrupts.CPU16.CAL:Function_call_interrupts
    774609 ±  3%      -6.7%     722394 ± 18%      +1.2%     783588        interrupts.CPU16.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU16.MCP:Machine_check_polls
    104.00 ± 26%      -1.8%     102.08 ± 26%     -36.5%      66.00 ± 30%  interrupts.CPU16.NMI:Non-maskable_interrupts
    104.00 ± 26%      -1.8%     102.08 ± 26%     -36.5%      66.00 ± 30%  interrupts.CPU16.PMI:Performance_monitoring_interrupts
    111.00 ±239%     -47.2%      58.58 ±123%     -88.8%      12.44 ± 76%  interrupts.CPU16.RES:Rescheduling_interrupts
      1.67 ±109%     +45.0%       2.42 ±124%    +153.3%       4.22 ± 24%  interrupts.CPU16.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU17.295:PCI-MSI.65536-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU17.303:PCI-MSI.79872-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU17.304:PCI-MSI.79872-edge.ioat-msix
     21.22 ±282%     -25.0%      15.92 ±331%      +0.0%      21.22 ±282%  interrupts.CPU17.306:PCI-MSI.288768-edge.ahci[0000:00:11.5]
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU17.307:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.00       +3.2e+103%      31.83 ±223%    -100.0%       0.00        interrupts.CPU17.308:PCI-MSI.288768-edge.ahci[0000:00:11.5]
      0.00       +1.6e+103%      15.92 ±331%    -100.0%       0.00        interrupts.CPU17.310:PCI-MSI.288768-edge.ahci[0000:00:11.5]
      0.00          -100.0%       0.00       +2.1e+103%      21.22 ±282%  interrupts.CPU17.311:PCI-MSI.288768-edge.ahci[0000:00:11.5]
     21.22 ±282%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU17.312:PCI-MSI.288768-edge.ahci[0000:00:11.5]
     21.22 ±282%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU17.314:PCI-MSI.288768-edge.ahci[0000:00:11.5]
      9.00 ±282%    -100.0%       0.00            -9.9%       8.11 ±282%  interrupts.CPU17.315:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU17.3:IO-APIC.3-edge
      0.33 ±141%     -50.0%       0.17 ±223%     -66.7%       0.11 ±282%  interrupts.CPU17.40:PCI-MSI.31981573-edge.i40e-eth0-TxRx-4
     17.33 ±187%    +499.0%     103.83 ±326%     +40.4%      24.33 ±200%  interrupts.CPU17.53:PCI-MSI.31981586-edge.i40e-eth0-TxRx-17
      0.22 ±187%    -100.0%       0.00           -50.0%       0.11 ±282%  interrupts.CPU17.88:PCI-MSI.31981621-edge.i40e-eth0-TxRx-52
    644.00 ± 47%    +314.1%       2666 ±263%   +1194.3%       8335 ±235%  interrupts.CPU17.CAL:Function_call_interrupts
      0.00       +2.5e+101%       0.25 ±238%    -100.0%       0.00        interrupts.CPU17.IWI:IRQ_work_interrupts
    774589 ±  3%      -6.7%     722419 ± 18%      +1.2%     783648        interrupts.CPU17.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU17.MCP:Machine_check_polls
    105.89 ± 19%    +377.7%     505.83 ±261%     -34.0%      69.89 ± 28%  interrupts.CPU17.NMI:Non-maskable_interrupts
    105.89 ± 19%    +377.7%     505.83 ±261%     -34.0%      69.89 ± 28%  interrupts.CPU17.PMI:Performance_monitoring_interrupts
     58.33 ±204%     -65.3%      20.25 ± 70%     -81.1%      11.00 ± 30%  interrupts.CPU17.RES:Rescheduling_interrupts
      1.56 ±113%     +50.0%       2.33 ±132%    +228.6%       5.11 ± 17%  interrupts.CPU17.TLB:TLB_shootdowns
     21.22 ±282%     -25.0%      15.92 ±331%      +0.0%      21.22 ±282%  interrupts.CPU18.306:PCI-MSI.288768-edge.ahci[0000:00:11.5]
      8.56 ±282%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU18.315:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU18.3:IO-APIC.3-edge
      0.11 ±282%     +50.0%       0.17 ±223%    -100.0%       0.00        interrupts.CPU18.41:PCI-MSI.31981574-edge.i40e-eth0-TxRx-5
     21.11 ±282%     +64.2%      34.67 ±314%    +265.8%      77.22 ±274%  interrupts.CPU18.54:PCI-MSI.31981587-edge.i40e-eth0-TxRx-18
      0.00          -100.0%       0.00       +1.1e+101%       0.11 ±282%  interrupts.CPU18.89:PCI-MSI.31981622-edge.i40e-eth0-TxRx-53
      3956 ±154%     -33.9%       2613 ±224%    +171.8%      10754 ±259%  interrupts.CPU18.CAL:Function_call_interrupts
      0.00       +8.3e+100%       0.08 ±331%    -100.0%       0.00        interrupts.CPU18.IWI:IRQ_work_interrupts
    774468 ±  3%      -6.7%     722385 ± 18%      +1.2%     783567        interrupts.CPU18.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU18.MCP:Machine_check_polls
    102.78 ± 16%    +511.8%     628.75 ±265%    +245.8%     355.44 ±224%  interrupts.CPU18.NMI:Non-maskable_interrupts
    102.78 ± 16%    +511.8%     628.75 ±265%    +245.8%     355.44 ±224%  interrupts.CPU18.PMI:Performance_monitoring_interrupts
     20.22 ± 47%    +137.0%      47.92 ±121%    +161.0%      52.78 ±180%  interrupts.CPU18.RES:Rescheduling_interrupts
      2.00 ± 94%     +33.3%       2.67 ±122%    +133.3%       4.67 ± 17%  interrupts.CPU18.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU19.297:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU19.302:PCI-MSI.77824-edge.ioat-msix
      8.67 ±282%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU19.315:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU19.3:IO-APIC.3-edge
      0.00       +8.3e+100%       0.08 ±331% +5.6e+101%       0.56 ± 89%  interrupts.CPU19.42:PCI-MSI.31981575-edge.i40e-eth0-TxRx-6
      5.11 ±282%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU19.4:IO-APIC.4-edge.ttyS0
     69.44 ±281%  +10043.2%       7043 ±331%     -88.8%       7.78 ±187%  interrupts.CPU19.55:PCI-MSI.31981588-edge.i40e-eth0-TxRx-19
      0.00       +1.7e+101%       0.17 ±223%    -100.0%       0.00        interrupts.CPU19.90:PCI-MSI.31981623-edge.i40e-eth0-TxRx-54
    556.56 ±  6%   +1092.4%       6636 ±224%    +200.0%       1669 ±127%  interrupts.CPU19.CAL:Function_call_interrupts
    774599 ±  3%      -6.7%     722577 ± 18%      +1.2%     783636        interrupts.CPU19.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU19.MCP:Machine_check_polls
    108.22 ± 19%      -8.3%      99.25 ± 26%     -33.6%      71.89 ± 26%  interrupts.CPU19.NMI:Non-maskable_interrupts
    108.22 ± 19%      -8.3%      99.25 ± 26%     -33.6%      71.89 ± 26%  interrupts.CPU19.PMI:Performance_monitoring_interrupts
    240.00 ±262%     -93.6%      15.33 ± 68%     -92.4%      18.33 ±108%  interrupts.CPU19.RES:Rescheduling_interrupts
      1.78 ±101%     +59.4%       2.83 ±147%    +162.5%       4.67 ± 34%  interrupts.CPU19.TLB:TLB_shootdowns
      0.00       +1.7e+101%       0.17 ±223% +1.1e+101%       0.11 ±282%  interrupts.CPU2.121:PCI-MSI.31981654-edge.i40e-eth0-TxRx-85
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU2.297:PCI-MSI.67584-edge.ioat-msix
      3.89 ±240%   +2315.0%      93.92 ±311%   +4345.7%     172.89 ±261%  interrupts.CPU2.38:PCI-MSI.31981571-edge.i40e-eth0-TxRx-2
      0.11 ±282%    +200.0%       0.33 ±141%    +100.0%       0.22 ±187%  interrupts.CPU2.73:PCI-MSI.31981606-edge.i40e-eth0-TxRx-37
    649.33 ± 25%     +31.8%     855.58 ± 66%     -13.0%     565.00 ±  5%  interrupts.CPU2.CAL:Function_call_interrupts
    774442 ±  3%      -6.7%     722580 ± 18%      +1.2%     783803        interrupts.CPU2.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU2.MCP:Machine_check_polls
    654.78 ±159%     -85.1%      97.75 ± 24%     -50.4%     325.00 ±218%  interrupts.CPU2.NMI:Non-maskable_interrupts
    654.78 ±159%     -85.1%      97.75 ± 24%     -50.4%     325.00 ±218%  interrupts.CPU2.PMI:Performance_monitoring_interrupts
     15.67 ± 64%    +233.5%      52.25 ±229%     -26.2%      11.56 ± 83%  interrupts.CPU2.RES:Rescheduling_interrupts
      3.00 ±115%     -33.3%       2.00 ±132%     +55.6%       4.67 ± 48%  interrupts.CPU2.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU20.295:PCI-MSI.65536-edge.ioat-msix
      0.11 ±282%    -100.0%       0.00          +200.0%       0.33 ±141%  interrupts.CPU20.43:PCI-MSI.31981576-edge.i40e-eth0-TxRx-7
      5.11 ±282%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU20.4:IO-APIC.4-edge.ttyS0
      1.44 ±282%  +11876.9%     173.00 ±226%   +2607.7%      39.11 ±281%  interrupts.CPU20.56:PCI-MSI.31981589-edge.i40e-eth0-TxRx-20
      0.33 ±141%     -25.0%       0.25 ±173%     -33.3%       0.22 ±187%  interrupts.CPU20.91:PCI-MSI.31981624-edge.i40e-eth0-TxRx-55
      6289 ±233%     -89.3%     670.08 ± 38%     -90.4%     605.22 ± 28%  interrupts.CPU20.CAL:Function_call_interrupts
      0.11 ±282%    -100.0%       0.00          +100.0%       0.22 ±187%  interrupts.CPU20.IWI:IRQ_work_interrupts
    774446 ±  3%      -6.7%     722456 ± 18%      +1.2%     783709        interrupts.CPU20.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU20.MCP:Machine_check_polls
    841.89 ±182%     -88.3%      98.17 ± 30%     -18.4%     687.11 ±249%  interrupts.CPU20.NMI:Non-maskable_interrupts
    841.89 ±182%     -88.3%      98.17 ± 30%     -18.4%     687.11 ±249%  interrupts.CPU20.PMI:Performance_monitoring_interrupts
     19.11 ± 80%    +142.0%      46.25 ±196%     +66.3%      31.78 ± 96%  interrupts.CPU20.RES:Rescheduling_interrupts
      1.67 ±116%     +35.0%       2.25 ±145%    +180.0%       4.67 ± 36%  interrupts.CPU20.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU21.295:PCI-MSI.65536-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU21.298:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU21.3:IO-APIC.3-edge
      0.11 ±282%     +50.0%       0.17 ±223%    +100.0%       0.22 ±187%  interrupts.CPU21.44:PCI-MSI.31981577-edge.i40e-eth0-TxRx-8
      1.67 ±187%    +270.0%       6.17 ±294%    +120.0%       3.67 ±282%  interrupts.CPU21.57:PCI-MSI.31981590-edge.i40e-eth0-TxRx-21
      0.00       +8.3e+100%       0.08 ±331% +2.2e+101%       0.22 ±187%  interrupts.CPU21.92:PCI-MSI.31981625-edge.i40e-eth0-TxRx-56
    931.00 ±115%     -38.1%     576.58 ± 18%     -34.5%     609.78 ± 29%  interrupts.CPU21.CAL:Function_call_interrupts
      0.00       +8.3e+100%       0.08 ±331%    -100.0%       0.00        interrupts.CPU21.IWI:IRQ_work_interrupts
    774438 ±  3%      -6.7%     722473 ± 18%      +1.2%     783660        interrupts.CPU21.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU21.MCP:Machine_check_polls
    148.44 ± 84%     -30.2%     103.67 ± 30%     -54.8%      67.11 ± 33%  interrupts.CPU21.NMI:Non-maskable_interrupts
    148.44 ± 84%     -30.2%     103.67 ± 30%     -54.8%      67.11 ± 33%  interrupts.CPU21.PMI:Performance_monitoring_interrupts
     50.67 ±211%     -43.3%      28.75 ± 72%     -38.2%      31.33 ± 65%  interrupts.CPU21.RES:Rescheduling_interrupts
      1.56 ±101%     +39.3%       2.17 ±151%    +221.4%       5.00 ± 18%  interrupts.CPU21.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU22.295:PCI-MSI.65536-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU22.297:PCI-MSI.67584-edge.ioat-msix
      0.44 ±111%     -62.5%       0.17 ±223%     -75.0%       0.11 ±282%  interrupts.CPU22.45:PCI-MSI.31981578-edge.i40e-eth0-TxRx-9
      0.00       +8.4e+103%      83.50 ±297% +2.7e+102%       2.67 ±269%  interrupts.CPU22.58:PCI-MSI.31981591-edge.i40e-eth0-TxRx-22
      0.11 ±282%     -25.0%       0.08 ±331%    -100.0%       0.00        interrupts.CPU22.93:PCI-MSI.31981626-edge.i40e-eth0-TxRx-57
    515.56 ± 11%     +15.9%     597.42 ± 31%     +36.1%     701.78 ± 42%  interrupts.CPU22.CAL:Function_call_interrupts
    774528 ±  3%      -6.7%     722580 ± 18%      +1.2%     783639        interrupts.CPU22.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU22.MCP:Machine_check_polls
    104.00 ± 16%      -6.4%      97.33 ± 25%     -35.7%      66.89 ± 33%  interrupts.CPU22.NMI:Non-maskable_interrupts
    104.00 ± 16%      -6.4%      97.33 ± 25%     -35.7%      66.89 ± 33%  interrupts.CPU22.PMI:Performance_monitoring_interrupts
      9.67 ± 35%    +461.2%      54.25 ±220%    +129.9%      22.22 ±115%  interrupts.CPU22.RES:Rescheduling_interrupts
      1.44 ±103%     +90.4%       2.75 ±123%    +238.5%       4.89 ± 15%  interrupts.CPU22.TLB:TLB_shootdowns
      0.00       +1.6e+103%      15.92 ±331%    -100.0%       0.00        interrupts.CPU23.296:PCI-MSI.288768-edge.ahci[0000:00:11.5]
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU23.297:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU23.3:IO-APIC.3-edge
      0.22 ±187%    -100.0%       0.00            +0.0%       0.22 ±187%  interrupts.CPU23.46:PCI-MSI.31981579-edge.i40e-eth0-TxRx-10
      0.00          -100.0%       0.00       +5.7e+102%       5.67 ±282%  interrupts.CPU23.4:IO-APIC.4-edge.ttyS0
     66.22 ±232%      -6.3%      62.08 ±285%    +773.0%     578.11 ±239%  interrupts.CPU23.59:PCI-MSI.31981592-edge.i40e-eth0-TxRx-23
      0.00       +1.7e+101%       0.17 ±223%    -100.0%       0.00        interrupts.CPU23.94:PCI-MSI.31981627-edge.i40e-eth0-TxRx-58
      1293 ±164%    +267.3%       4749 ±290%     -58.1%     542.11 ±  5%  interrupts.CPU23.CAL:Function_call_interrupts
      0.22 ±187%     -25.0%       0.17 ±223%    -100.0%       0.00        interrupts.CPU23.IWI:IRQ_work_interrupts
    774462 ±  3%      -6.4%     725129 ± 18%      +1.2%     783628        interrupts.CPU23.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU23.MCP:Machine_check_polls
      1249 ±171%     -44.3%     696.25 ±213%     -94.2%      72.22 ± 29%  interrupts.CPU23.NMI:Non-maskable_interrupts
      1249 ±171%     -44.3%     696.25 ±213%     -94.2%      72.22 ± 29%  interrupts.CPU23.PMI:Performance_monitoring_interrupts
     16.78 ± 90%     +54.0%      25.83 ± 56%     -26.5%      12.33 ± 64%  interrupts.CPU23.RES:Rescheduling_interrupts
      2.56 ± 94%     +14.1%       2.92 ±118%     +78.3%       4.56 ± 25%  interrupts.CPU23.TLB:TLB_shootdowns
     54.44 ±214%    +316.3%     226.67 ±238%    +238.0%     184.00 ±242%  interrupts.CPU24.60:PCI-MSI.31981593-edge.i40e-eth0-TxRx-24
    783.67 ± 88%      -0.6%     778.75 ± 95%     -17.1%     649.44 ± 43%  interrupts.CPU24.CAL:Function_call_interrupts
      0.44 ±154%     -25.0%       0.33 ±141%    -100.0%       0.00        interrupts.CPU24.IWI:IRQ_work_interrupts
    742136 ± 15%      +3.6%     769181 ±  3%      +5.6%     783608        interrupts.CPU24.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU24.MCP:Machine_check_polls
    142.44 ± 42%      -7.9%     131.25 ± 50%     -58.1%      59.67 ± 36%  interrupts.CPU24.NMI:Non-maskable_interrupts
    142.44 ± 42%      -7.9%     131.25 ± 50%     -58.1%      59.67 ± 36%  interrupts.CPU24.PMI:Performance_monitoring_interrupts
     32.00 ±140%     -66.7%      10.67 ± 76%     -61.5%      12.33 ±131%  interrupts.CPU24.RES:Rescheduling_interrupts
      1.44 ±108%     +44.2%       2.08 ±149%    +261.5%       5.22 ± 19%  interrupts.CPU24.TLB:TLB_shootdowns
      1582 ±282%     -99.2%      13.17 ±329%     -98.8%      19.56 ±187%  interrupts.CPU25.61:PCI-MSI.31981594-edge.i40e-eth0-TxRx-25
      1717 ±194%     -35.5%       1107 ± 96%    +324.6%       7291 ±205%  interrupts.CPU25.CAL:Function_call_interrupts
      0.00       +1.7e+101%       0.17 ±223% +1.1e+101%       0.11 ±282%  interrupts.CPU25.IWI:IRQ_work_interrupts
    743048 ± 15%      +3.5%     769173 ±  4%      +5.5%     783645        interrupts.CPU25.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU25.MCP:Machine_check_polls
    121.67 ± 35%      -3.2%     117.83 ± 51%     -46.6%      65.00 ± 34%  interrupts.CPU25.NMI:Non-maskable_interrupts
    121.67 ± 35%      -3.2%     117.83 ± 51%     -46.6%      65.00 ± 34%  interrupts.CPU25.PMI:Performance_monitoring_interrupts
     14.78 ±124%     +31.4%      19.42 ± 80%     -21.8%      11.56 ± 66%  interrupts.CPU25.RES:Rescheduling_interrupts
      1.89 ±101%     +14.7%       2.17 ±138%    +170.6%       5.11 ± 25%  interrupts.CPU25.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU26.305:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU26.306:PCI-MSI.67174400-edge.ioat-msix
      0.00       +2.8e+102%       2.75 ±243% +1.1e+101%       0.11 ±282%  interrupts.CPU26.62:PCI-MSI.31981595-edge.i40e-eth0-TxRx-26
    535.89          +169.4%       1443 ±119%    +186.5%       1535 ±179%  interrupts.CPU26.CAL:Function_call_interrupts
    742092 ± 15%      +3.6%     769143 ±  3%      +5.6%     783610        interrupts.CPU26.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU26.MCP:Machine_check_polls
    121.00 ± 33%      +1.8%     123.17 ± 40%     -47.9%      63.00 ± 28%  interrupts.CPU26.NMI:Non-maskable_interrupts
    121.00 ± 33%      +1.8%     123.17 ± 40%     -47.9%      63.00 ± 28%  interrupts.CPU26.PMI:Performance_monitoring_interrupts
      7.56 ± 44%    +161.4%      19.75 ± 74%    +480.9%      43.89 ±237%  interrupts.CPU26.RES:Rescheduling_interrupts
      2.00 ±102%      -8.3%       1.83 ±163%    +150.0%       5.00 ± 29%  interrupts.CPU26.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU27.307:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU27.308:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU27.309:PCI-MSI.67176448-edge.ioat-msix
     63.00 ±282%     -83.5%      10.42 ±331%     -88.4%       7.33 ±273%  interrupts.CPU27.63:PCI-MSI.31981596-edge.i40e-eth0-TxRx-27
    966.00 ±126%     -15.3%     818.17 ± 66%     +24.5%       1202 ±161%  interrupts.CPU27.CAL:Function_call_interrupts
      0.11 ±282%     -25.0%       0.08 ±331%    -100.0%       0.00        interrupts.CPU27.IWI:IRQ_work_interrupts
    742143 ± 15%      +3.6%     769182 ±  4%      +5.6%     783623        interrupts.CPU27.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU27.MCP:Machine_check_polls
    125.33 ± 37%    +397.7%     623.75 ±267%     -47.5%      65.78 ± 24%  interrupts.CPU27.NMI:Non-maskable_interrupts
    125.33 ± 37%    +397.7%     623.75 ±267%     -47.5%      65.78 ± 24%  interrupts.CPU27.PMI:Performance_monitoring_interrupts
     14.78 ± 90%    +131.8%      34.25 ± 66%    +179.7%      41.33 ±196%  interrupts.CPU27.RES:Rescheduling_interrupts
      2.22 ± 98%      -2.5%       2.17 ±146%    +115.0%       4.78 ± 32%  interrupts.CPU27.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU28.307:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU28.308:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU28.308:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU28.309:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU28.310:PCI-MSI.67178496-edge.ioat-msix
    210.89 ±257%     -93.3%      14.17 ±304%     -21.6%     165.33 ±282%  interrupts.CPU28.64:PCI-MSI.31981597-edge.i40e-eth0-TxRx-28
      4658 ±167%     -60.0%       1862 ±233%     -59.7%       1877 ±185%  interrupts.CPU28.CAL:Function_call_interrupts
    742109 ± 15%      +3.6%     769079 ±  4%      +5.6%     783584        interrupts.CPU28.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU28.MCP:Machine_check_polls
    122.00 ± 34%      +1.6%     123.92 ± 36%     -45.7%      66.22 ± 24%  interrupts.CPU28.NMI:Non-maskable_interrupts
    122.00 ± 34%      +1.6%     123.92 ± 36%     -45.7%      66.22 ± 24%  interrupts.CPU28.PMI:Performance_monitoring_interrupts
     16.00 ± 80%     +25.5%      20.08 ± 64%     -25.7%      11.89 ±144%  interrupts.CPU28.RES:Rescheduling_interrupts
      2.56 ± 86%      -5.4%       2.42 ±139%    +100.0%       5.11 ± 29%  interrupts.CPU28.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU29.309:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU29.309:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU29.310:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU29.311:PCI-MSI.67180544-edge.ioat-msix
      8.78 ±274%     -63.9%       3.17 ±322%    +829.1%      81.56 ±261%  interrupts.CPU29.65:PCI-MSI.31981598-edge.i40e-eth0-TxRx-29
      1037 ±136%     -47.9%     540.42 ±  5%    +272.5%       3864 ±165%  interrupts.CPU29.CAL:Function_call_interrupts
      0.11 ±282%    +275.0%       0.42 ±206%    -100.0%       0.00        interrupts.CPU29.IWI:IRQ_work_interrupts
    742047 ± 15%      +3.6%     769129 ±  3%      +5.6%     783578        interrupts.CPU29.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU29.MCP:Machine_check_polls
    125.89 ± 35%     +13.1%     142.33 ± 47%     -50.1%      62.78 ± 24%  interrupts.CPU29.NMI:Non-maskable_interrupts
    125.89 ± 35%     +13.1%     142.33 ± 47%     -50.1%      62.78 ± 24%  interrupts.CPU29.PMI:Performance_monitoring_interrupts
      6.11 ± 71%    +100.5%      12.25 ± 86%     -25.5%       4.56 ± 52%  interrupts.CPU29.RES:Rescheduling_interrupts
      2.22 ±105%      +8.7%       2.42 ±139%    +140.0%       5.33 ± 21%  interrupts.CPU29.TLB:TLB_shootdowns
      0.00       +8.3e+100%       0.08 ±331% +1.1e+101%       0.11 ±282%  interrupts.CPU3.122:PCI-MSI.31981655-edge.i40e-eth0-TxRx-86
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU3.297:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU3.298:PCI-MSI.69632-edge.ioat-msix
     38.11 ±232%     -90.8%       3.50 ±331%    +184.0%     108.22 ±270%  interrupts.CPU3.39:PCI-MSI.31981572-edge.i40e-eth0-TxRx-3
      0.22 ±187%     -25.0%       0.17 ±223%     -50.0%       0.11 ±282%  interrupts.CPU3.74:PCI-MSI.31981607-edge.i40e-eth0-TxRx-38
      4407 ±225%     -81.7%     806.25 ± 74%     +66.4%       7331 ±246%  interrupts.CPU3.CAL:Function_call_interrupts
    774494 ±  3%      -6.7%     722513 ± 18%      +1.2%     783510        interrupts.CPU3.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU3.MCP:Machine_check_polls
    103.56 ± 17%      -8.4%      94.83 ± 27%     -27.7%      74.89 ± 17%  interrupts.CPU3.NMI:Non-maskable_interrupts
    103.56 ± 17%      -8.4%      94.83 ± 27%     -27.7%      74.89 ± 17%  interrupts.CPU3.PMI:Performance_monitoring_interrupts
     71.89 ±245%     -75.7%      17.50 ± 98%     -75.1%      17.89 ±118%  interrupts.CPU3.RES:Rescheduling_interrupts
      1.44 ± 92%     +84.6%       2.67 ±150%    +153.8%       3.67 ± 34%  interrupts.CPU3.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU30.310:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU30.310:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU30.311:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU30.312:PCI-MSI.67182592-edge.ioat-msix
      0.00       +1.8e+103%      18.17 ±176% +1.8e+103%      17.56 ±280%  interrupts.CPU30.66:PCI-MSI.31981599-edge.i40e-eth0-TxRx-30
    637.44 ± 45%    +453.4%       3527 ±273%     -16.0%     535.22 ±  4%  interrupts.CPU30.CAL:Function_call_interrupts
      0.22 ±187%     -25.0%       0.17 ±223%    -100.0%       0.00        interrupts.CPU30.IWI:IRQ_work_interrupts
    742040 ± 15%      +3.7%     769199 ±  3%      +5.6%     783637        interrupts.CPU30.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU30.MCP:Machine_check_polls
    129.89 ± 36%      +1.5%     131.83 ± 41%     -45.6%      70.67 ± 17%  interrupts.CPU30.NMI:Non-maskable_interrupts
    129.89 ± 36%      +1.5%     131.83 ± 41%     -45.6%      70.67 ± 17%  interrupts.CPU30.PMI:Performance_monitoring_interrupts
     11.00 ± 83%     +50.0%      16.50 ±144%     -34.3%       7.22 ± 91%  interrupts.CPU30.RES:Rescheduling_interrupts
      2.22 ±105%      +8.7%       2.42 ±134%    +110.0%       4.67 ± 31%  interrupts.CPU30.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU31.310:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU31.311:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU31.311:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU31.312:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU31.313:PCI-MSI.67184640-edge.ioat-msix
     14016 ±282%     -97.8%     306.08 ±202%     -99.9%      11.33 ±273%  interrupts.CPU31.67:PCI-MSI.31981600-edge.i40e-eth0-TxRx-31
    852.56 ±103%    +250.6%       2989 ±236%    +192.3%       2491 ±221%  interrupts.CPU31.CAL:Function_call_interrupts
      0.11 ±282%     +50.0%       0.17 ±223%    -100.0%       0.00        interrupts.CPU31.IWI:IRQ_work_interrupts
    742048 ± 15%      +3.7%     769150 ±  3%      +5.6%     783615        interrupts.CPU31.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU31.MCP:Machine_check_polls
    126.11 ± 32%      -2.5%     122.92 ± 42%     -39.6%      76.11 ± 16%  interrupts.CPU31.NMI:Non-maskable_interrupts
    126.11 ± 32%      -2.5%     122.92 ± 42%     -39.6%      76.11 ± 16%  interrupts.CPU31.PMI:Performance_monitoring_interrupts
     21.22 ±201%     -44.2%      11.83 ±128%     -55.0%       9.56 ±110%  interrupts.CPU31.RES:Rescheduling_interrupts
      2.00 ±120%     +20.8%       2.42 ±139%    +172.2%       5.44 ± 23%  interrupts.CPU31.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU32.311:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU32.312:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU32.312:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU32.313:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU32.314:PCI-MSI.67186688-edge.ioat-msix
    102.00 ±233%    +177.3%     282.83 ±127%     -99.9%       0.11 ±282%  interrupts.CPU32.68:PCI-MSI.31981601-edge.i40e-eth0-TxRx-32
      4767 ±236%     -88.7%     540.17            -4.7%       4541 ±251%  interrupts.CPU32.CAL:Function_call_interrupts
    742042 ± 15%      +3.6%     769101 ±  3%      +5.6%     783647        interrupts.CPU32.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU32.MCP:Machine_check_polls
    122.11 ± 31%      +1.8%     124.25 ± 35%     -35.8%      78.44 ± 13%  interrupts.CPU32.NMI:Non-maskable_interrupts
    122.11 ± 31%      +1.8%     124.25 ± 35%     -35.8%      78.44 ± 13%  interrupts.CPU32.PMI:Performance_monitoring_interrupts
     38.33 ±210%     -60.7%      15.08 ±152%     -75.7%       9.33 ± 84%  interrupts.CPU32.RES:Rescheduling_interrupts
      1.78 ±114%     +31.2%       2.33 ±150%    +181.2%       5.00 ± 31%  interrupts.CPU32.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU33.312:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU33.313:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU33.313:PCI-MSI.67188736-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU33.314:PCI-MSI.67188736-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU33.315:PCI-MSI.67188736-edge.ioat-msix
    219.56 ±193%     -95.9%       8.92 ±270%    -100.0%       0.00        interrupts.CPU33.69:PCI-MSI.31981602-edge.i40e-eth0-TxRx-33
    531.78 ± 15%    +106.9%       1100 ±169%      +2.1%     543.11        interrupts.CPU33.CAL:Function_call_interrupts
      0.00       +1.7e+101%       0.17 ±223% +1.1e+101%       0.11 ±282%  interrupts.CPU33.IWI:IRQ_work_interrupts
    742063 ± 15%      +3.6%     769096 ±  3%      +5.6%     783632        interrupts.CPU33.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU33.MCP:Machine_check_polls
    120.00 ± 33%    +359.0%     550.83 ±259%     -30.4%      83.56 ± 20%  interrupts.CPU33.NMI:Non-maskable_interrupts
    120.00 ± 33%    +359.0%     550.83 ±259%     -30.4%      83.56 ± 20%  interrupts.CPU33.PMI:Performance_monitoring_interrupts
     12.00 ± 86%     +16.7%      14.00 ±111%     +27.8%      15.33 ± 82%  interrupts.CPU33.RES:Rescheduling_interrupts
      1.89 ±104%     +23.5%       2.33 ±138%    +176.5%       5.22 ± 28%  interrupts.CPU33.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU34.313:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU34.314:PCI-MSI.67188736-edge.ioat-msix
     11.67 ±245%    +706.4%      94.08 ±331%     -94.3%       0.67 ±234%  interrupts.CPU34.70:PCI-MSI.31981603-edge.i40e-eth0-TxRx-34
    997.67 ±127%     -44.4%     555.17 ± 17%     -32.2%     676.11 ± 51%  interrupts.CPU34.CAL:Function_call_interrupts
    742089 ± 15%      +3.6%     769096 ±  4%      +5.6%     783695        interrupts.CPU34.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU34.MCP:Machine_check_polls
    123.89 ± 31%      -8.9%     112.92 ± 40%     -39.0%      75.56 ± 12%  interrupts.CPU34.NMI:Non-maskable_interrupts
    123.89 ± 31%      -8.9%     112.92 ± 40%     -39.0%      75.56 ± 12%  interrupts.CPU34.PMI:Performance_monitoring_interrupts
     24.67 ±127%     -56.1%      10.83 ±131%     -61.7%       9.44 ± 56%  interrupts.CPU34.RES:Rescheduling_interrupts
      2.22 ± 94%      +1.2%       2.25 ±145%    +140.0%       5.33 ± 26%  interrupts.CPU34.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU35.314:PCI-MSI.67188736-edge.ioat-msix
      2.00 ±265%    +150.0%       5.00 ±228%  +19227.8%     386.56 ±282%  interrupts.CPU35.71:PCI-MSI.31981604-edge.i40e-eth0-TxRx-35
    543.44 ±  5%     +96.5%       1067 ±159%      +1.0%     549.11 ±  8%  interrupts.CPU35.CAL:Function_call_interrupts
      0.22 ±187%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU35.IWI:IRQ_work_interrupts
    742075 ± 15%      +3.6%     769098 ±  4%      +5.6%     783608        interrupts.CPU35.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU35.MCP:Machine_check_polls
    131.33 ± 38%     -11.5%     116.17 ± 41%     -41.3%      77.11 ± 12%  interrupts.CPU35.NMI:Non-maskable_interrupts
    131.33 ± 38%     -11.5%     116.17 ± 41%     -41.3%      77.11 ± 12%  interrupts.CPU35.PMI:Performance_monitoring_interrupts
     13.67 ± 85%     -22.0%      10.67 ±113%     -24.4%      10.33 ± 74%  interrupts.CPU35.RES:Rescheduling_interrupts
      2.00 ±113%     +25.0%       2.50 ±146%    +205.6%       6.11 ± 43%  interrupts.CPU35.TLB:TLB_shootdowns
    207.44 ±195%     -61.6%      79.58 ±331%    +794.4%       1855 ±272%  interrupts.CPU36.72:PCI-MSI.31981605-edge.i40e-eth0-TxRx-36
    542.33 ±  2%     +40.8%     763.42 ± 97%     +60.5%     870.33 ±109%  interrupts.CPU36.CAL:Function_call_interrupts
      0.00       +1.7e+101%       0.17 ±223%    -100.0%       0.00        interrupts.CPU36.IWI:IRQ_work_interrupts
    742038 ± 15%      +3.7%     769131 ±  4%      +5.6%     783606        interrupts.CPU36.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU36.MCP:Machine_check_polls
    120.67 ± 34%      +0.1%     120.83 ± 46%    +139.8%     289.33 ±211%  interrupts.CPU36.NMI:Non-maskable_interrupts
    120.67 ± 34%      +0.1%     120.83 ± 46%    +139.8%     289.33 ±211%  interrupts.CPU36.PMI:Performance_monitoring_interrupts
      8.78 ± 72%     +88.0%      16.50 ±144%    +246.8%      30.44 ±173%  interrupts.CPU36.RES:Rescheduling_interrupts
      1.78 ± 94%     +35.9%       2.42 ±137%    +187.5%       5.11 ± 26%  interrupts.CPU36.TLB:TLB_shootdowns
      0.11 ±282%  +3.4e+05%     378.42 ±315%  +23900.0%      26.67 ±196%  interrupts.CPU37.73:PCI-MSI.31981606-edge.i40e-eth0-TxRx-37
    542.22 ±  2%     +12.5%     609.75 ± 34%      +3.1%     559.11 ±  7%  interrupts.CPU37.CAL:Function_call_interrupts
      0.11 ±282%     -25.0%       0.08 ±331%      +0.0%       0.11 ±282%  interrupts.CPU37.IWI:IRQ_work_interrupts
    742093 ± 15%      +3.6%     769102 ±  4%      +5.6%     783496        interrupts.CPU37.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU37.MCP:Machine_check_polls
    127.00 ± 38%      -9.1%     115.50 ± 52%     -34.1%      83.67 ± 29%  interrupts.CPU37.NMI:Non-maskable_interrupts
    127.00 ± 38%      -9.1%     115.50 ± 52%     -34.1%      83.67 ± 29%  interrupts.CPU37.PMI:Performance_monitoring_interrupts
      8.00 ± 33%    +141.7%      19.33 ±112%     +77.8%      14.22 ± 81%  interrupts.CPU37.RES:Rescheduling_interrupts
      1.78 ±101%     +50.0%       2.67 ±138%    +212.5%       5.56 ± 22%  interrupts.CPU37.TLB:TLB_shootdowns
    182.11 ±265%    +277.1%     686.75 ±327%     -48.2%      94.33 ±282%  interrupts.CPU38.74:PCI-MSI.31981607-edge.i40e-eth0-TxRx-38
    535.78            +0.4%     537.75            +1.7%     545.11        interrupts.CPU38.CAL:Function_call_interrupts
      0.11 ±282%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU38.IWI:IRQ_work_interrupts
    742247 ± 15%      +3.6%     769074 ±  3%      +5.6%     783741        interrupts.CPU38.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU38.MCP:Machine_check_polls
    125.89 ± 34%     -11.4%     111.58 ± 46%     -39.4%      76.33 ± 13%  interrupts.CPU38.NMI:Non-maskable_interrupts
    125.89 ± 34%     -11.4%     111.58 ± 46%     -39.4%      76.33 ± 13%  interrupts.CPU38.PMI:Performance_monitoring_interrupts
     19.44 ±142%     -45.6%      10.58 ±100%      -1.7%      19.11 ±103%  interrupts.CPU38.RES:Rescheduling_interrupts
      2.11 ± 95%     +22.4%       2.58 ±130%    +168.4%       5.67 ± 22%  interrupts.CPU38.TLB:TLB_shootdowns
    344.44 ±273%     -89.5%      36.25 ±319%     -51.6%     166.56 ±282%  interrupts.CPU39.75:PCI-MSI.31981608-edge.i40e-eth0-TxRx-39
    536.67            +0.6%     539.83            +1.4%     544.00        interrupts.CPU39.CAL:Function_call_interrupts
    742253 ± 15%      +3.6%     769164 ±  3%      +5.6%     783614        interrupts.CPU39.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU39.MCP:Machine_check_polls
    116.78 ± 40%      -5.7%     110.17 ± 46%     -33.5%      77.67 ± 14%  interrupts.CPU39.NMI:Non-maskable_interrupts
    116.78 ± 40%      -5.7%     110.17 ± 46%     -33.5%      77.67 ± 14%  interrupts.CPU39.PMI:Performance_monitoring_interrupts
      9.44 ± 76%     +87.1%      17.67 ±152%     +61.2%      15.22 ± 49%  interrupts.CPU39.RES:Rescheduling_interrupts
      2.22 ± 94%     +20.0%       2.67 ±127%    +160.0%       5.78 ± 32%  interrupts.CPU39.TLB:TLB_shootdowns
      0.11 ±282%    -100.0%       0.00          +200.0%       0.33 ±141%  interrupts.CPU4.123:PCI-MSI.31981656-edge.i40e-eth0-TxRx-87
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU4.298:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU4.29:PCI-MSI.48791552-edge.PCIe.PME,pciehp
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU4.302:PCI-MSI.77824-edge.ioat-msix
     34.44 ±191%    +487.7%     202.42 ±304%     -99.7%       0.11 ±282%  interrupts.CPU4.40:PCI-MSI.31981573-edge.i40e-eth0-TxRx-4
      0.22 ±187%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU4.75:PCI-MSI.31981608-edge.i40e-eth0-TxRx-39
    621.33 ± 23%     +40.4%     872.50 ± 53%     +73.5%       1077 ±103%  interrupts.CPU4.CAL:Function_call_interrupts
    774520 ±  3%      -6.7%     722765 ± 18%      +1.2%     783742        interrupts.CPU4.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU4.MCP:Machine_check_polls
     94.89 ± 21%      +5.6%     100.25 ± 25%     -14.8%      80.89 ± 15%  interrupts.CPU4.NMI:Non-maskable_interrupts
     94.89 ± 21%      +5.6%     100.25 ± 25%     -14.8%      80.89 ± 15%  interrupts.CPU4.PMI:Performance_monitoring_interrupts
     27.00 ±183%    +156.2%      69.17 ±188%     -37.9%      16.78 ± 97%  interrupts.CPU4.RES:Rescheduling_interrupts
      1.33 ±106%     +37.5%       1.83 ±150%    +158.3%       3.44 ± 30%  interrupts.CPU4.TLB:TLB_shootdowns
    101.78 ±282%     +15.4%     117.50 ±331%     +27.2%     129.44 ±282%  interrupts.CPU40.76:PCI-MSI.31981609-edge.i40e-eth0-TxRx-40
    543.89 ±  4%      +5.8%     575.17 ± 15%     +12.4%     611.56 ± 31%  interrupts.CPU40.CAL:Function_call_interrupts
    742032 ± 15%      +3.7%     769181 ±  3%      +5.6%     783633        interrupts.CPU40.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU40.MCP:Machine_check_polls
    117.89 ± 40%      -1.9%     115.67 ± 44%     -35.6%      75.89 ± 14%  interrupts.CPU40.NMI:Non-maskable_interrupts
    117.89 ± 40%      -1.9%     115.67 ± 44%     -35.6%      75.89 ± 14%  interrupts.CPU40.PMI:Performance_monitoring_interrupts
      7.11 ± 79%     +69.9%      12.08 ± 50%    +120.3%      15.67 ± 96%  interrupts.CPU40.RES:Rescheduling_interrupts
      2.33 ± 85%      +7.1%       2.50 ±125%    +147.6%       5.78 ± 29%  interrupts.CPU40.TLB:TLB_shootdowns
     37.56 ±225%     -94.9%       1.92 ±300%     +92.3%      72.22 ±245%  interrupts.CPU41.77:PCI-MSI.31981610-edge.i40e-eth0-TxRx-41
    571.11 ± 18%     +38.9%     793.00 ± 95%      -4.8%     543.44        interrupts.CPU41.CAL:Function_call_interrupts
      0.11 ±282%     -25.0%       0.08 ±331%    -100.0%       0.00        interrupts.CPU41.IWI:IRQ_work_interrupts
    742021 ± 15%      +3.6%     769093 ±  3%      +5.6%     783628        interrupts.CPU41.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU41.MCP:Machine_check_polls
    127.11 ± 37%      -5.5%     120.08 ± 44%     -38.3%      78.44 ± 16%  interrupts.CPU41.NMI:Non-maskable_interrupts
    127.11 ± 37%      -5.5%     120.08 ± 44%     -38.3%      78.44 ± 16%  interrupts.CPU41.PMI:Performance_monitoring_interrupts
      9.89 ± 71%    +465.4%      55.92 ±186%     +22.5%      12.11 ± 59%  interrupts.CPU41.RES:Rescheduling_interrupts
      2.33 ±104%      +7.1%       2.50 ±113%    +138.1%       5.56 ± 28%  interrupts.CPU41.TLB:TLB_shootdowns
     16.44 ±280%    +363.2%      76.17 ±319%     -78.4%       3.56 ±282%  interrupts.CPU42.78:PCI-MSI.31981611-edge.i40e-eth0-TxRx-42
    587.78 ± 29%      -1.7%     577.75 ± 22%     +31.4%     772.22 ± 83%  interrupts.CPU42.CAL:Function_call_interrupts
      0.00       +8.3e+100%       0.08 ±331%    -100.0%       0.00        interrupts.CPU42.IWI:IRQ_work_interrupts
    742138 ± 15%      +3.6%     769180 ±  4%      +5.6%     783669        interrupts.CPU42.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU42.MCP:Machine_check_polls
    114.22 ± 31%      +4.8%     119.67 ± 47%     -37.7%      71.11 ± 22%  interrupts.CPU42.NMI:Non-maskable_interrupts
    114.22 ± 31%      +4.8%     119.67 ± 47%     -37.7%      71.11 ± 22%  interrupts.CPU42.PMI:Performance_monitoring_interrupts
     15.00 ±115%     +12.8%      16.92 ± 90%    +152.6%      37.89 ±202%  interrupts.CPU42.RES:Rescheduling_interrupts
      2.11 ± 95%     +18.4%       2.50 ±127%    +157.9%       5.44 ± 27%  interrupts.CPU42.TLB:TLB_shootdowns
      0.00       +8.4e+102%       8.42 ±328% +1.2e+103%      12.22 ±210%  interrupts.CPU43.79:PCI-MSI.31981612-edge.i40e-eth0-TxRx-43
      2710 ±226%     -77.4%     613.17 ± 21%     -79.9%     543.44        interrupts.CPU43.CAL:Function_call_interrupts
    742228 ± 15%      +3.6%     769138 ±  4%      +5.6%     783603        interrupts.CPU43.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU43.MCP:Machine_check_polls
    107.89 ± 33%      +4.7%     113.00 ± 42%     -31.2%      74.22 ± 23%  interrupts.CPU43.NMI:Non-maskable_interrupts
    107.89 ± 33%      +4.7%     113.00 ± 42%     -31.2%      74.22 ± 23%  interrupts.CPU43.PMI:Performance_monitoring_interrupts
     26.33 ±136%     -65.8%       9.00 ±106%     -48.5%      13.56 ± 78%  interrupts.CPU43.RES:Rescheduling_interrupts
      2.11 ± 93%     +22.4%       2.58 ±127%    +168.4%       5.67 ± 23%  interrupts.CPU43.TLB:TLB_shootdowns
     33.56 ±281%    +112.6%      71.33 ±324%    +196.7%      99.56 ±282%  interrupts.CPU44.80:PCI-MSI.31981613-edge.i40e-eth0-TxRx-44
    543.44 ±  2%    +271.5%       2018 ±231%    +133.0%       1266 ±161%  interrupts.CPU44.CAL:Function_call_interrupts
    742102 ± 15%      +3.6%     769068 ±  4%      +5.6%     783686        interrupts.CPU44.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU44.MCP:Machine_check_polls
    123.44 ± 32%      -5.0%     117.33 ± 45%    +133.9%     288.78 ±212%  interrupts.CPU44.NMI:Non-maskable_interrupts
    123.44 ± 32%      -5.0%     117.33 ± 45%    +133.9%     288.78 ±212%  interrupts.CPU44.PMI:Performance_monitoring_interrupts
      9.67 ± 95%     -27.6%       7.00 ± 57%    +274.7%      36.22 ±116%  interrupts.CPU44.RES:Rescheduling_interrupts
      2.11 ± 93%     +50.0%       3.17 ± 99%    +168.4%       5.67 ± 23%  interrupts.CPU44.TLB:TLB_shootdowns
      0.00       +1.7e+104%     165.33 ±254% +1.7e+103%      17.44 ±282%  interrupts.CPU45.81:PCI-MSI.31981614-edge.i40e-eth0-TxRx-45
    537.78            +0.5%     540.33           +14.0%     613.11 ± 32%  interrupts.CPU45.CAL:Function_call_interrupts
      0.00       +8.3e+100%       0.08 ±331%    -100.0%       0.00        interrupts.CPU45.IWI:IRQ_work_interrupts
    742106 ± 15%      +3.6%     769107 ±  3%      +5.6%     783593        interrupts.CPU45.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU45.MCP:Machine_check_polls
    121.00 ± 34%      -1.3%     119.42 ± 47%     -41.5%      70.78 ± 24%  interrupts.CPU45.NMI:Non-maskable_interrupts
    121.00 ± 34%      -1.3%     119.42 ± 47%     -41.5%      70.78 ± 24%  interrupts.CPU45.PMI:Performance_monitoring_interrupts
     10.00 ± 64%     -41.7%       5.83 ± 88%     +65.6%      16.56 ± 72%  interrupts.CPU45.RES:Rescheduling_interrupts
      2.44 ± 79%     +26.1%       3.08 ±104%    +150.0%       6.11 ± 21%  interrupts.CPU45.TLB:TLB_shootdowns
    108.33 ±253%      +9.4%     118.50 ±235%     -98.3%       1.89 ±282%  interrupts.CPU46.82:PCI-MSI.31981615-edge.i40e-eth0-TxRx-46
    537.89 ±  7%      +0.5%     540.75            +1.0%     543.44        interrupts.CPU46.CAL:Function_call_interrupts
      0.11 ±282%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU46.IWI:IRQ_work_interrupts
    742087 ± 15%      +3.6%     769137 ±  3%      +5.6%     783596        interrupts.CPU46.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU46.MCP:Machine_check_polls
    113.33 ± 44%      +4.4%     118.33 ± 45%     -37.2%      71.22 ± 23%  interrupts.CPU46.NMI:Non-maskable_interrupts
    113.33 ± 44%      +4.4%     118.33 ± 45%     -37.2%      71.22 ± 23%  interrupts.CPU46.PMI:Performance_monitoring_interrupts
      9.44 ± 85%     +20.0%      11.33 ±122%     -55.3%       4.22 ± 62%  interrupts.CPU46.RES:Rescheduling_interrupts
      2.56 ± 78%     +30.4%       3.33 ±101%    +139.1%       6.11 ± 14%  interrupts.CPU46.TLB:TLB_shootdowns
     11.33 ±245%     +79.4%      20.33 ±224%     -96.1%       0.44 ±282%  interrupts.CPU47.83:PCI-MSI.31981616-edge.i40e-eth0-TxRx-47
    906.78 ± 52%     -19.9%     726.75 ± 14%     -20.6%     719.78 ± 11%  interrupts.CPU47.CAL:Function_call_interrupts
      0.33 ±141%     -50.0%       0.17 ±223%    -100.0%       0.00        interrupts.CPU47.IWI:IRQ_work_interrupts
    742100 ± 15%      +3.6%     769147 ±  3%      +5.6%     783659        interrupts.CPU47.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU47.MCP:Machine_check_polls
    124.33 ± 47%      +3.5%     128.67 ± 49%     -43.8%      69.89 ± 30%  interrupts.CPU47.NMI:Non-maskable_interrupts
    124.33 ± 47%      +3.5%     128.67 ± 49%     -43.8%      69.89 ± 30%  interrupts.CPU47.PMI:Performance_monitoring_interrupts
     19.67 ±126%     -17.8%      16.17 ± 86%     +61.0%      31.67 ±149%  interrupts.CPU47.RES:Rescheduling_interrupts
      2.89 ± 73%     +26.9%       3.67 ± 91%    +115.4%       6.22 ± 18%  interrupts.CPU47.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU48.295:PCI-MSI.65536-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU48.3:IO-APIC.3-edge
      0.22 ±187%     -25.0%       0.17 ±223%      +0.0%       0.22 ±187%  interrupts.CPU48.47:PCI-MSI.31981580-edge.i40e-eth0-TxRx-11
      0.00          -100.0%       0.00       +5.1e+102%       5.11 ±282%  interrupts.CPU48.4:IO-APIC.4-edge.ttyS0
    134.22 ±273%     -99.9%       0.17 ±223%     -99.6%       0.56 ±226%  interrupts.CPU48.84:PCI-MSI.31981617-edge.i40e-eth0-TxRx-48
      0.00       +1.7e+101%       0.17 ±223%    -100.0%       0.00        interrupts.CPU48.95:PCI-MSI.31981628-edge.i40e-eth0-TxRx-59
    589.89 ± 21%     +46.8%     865.75 ±120%      -3.7%     568.00 ± 11%  interrupts.CPU48.CAL:Function_call_interrupts
      0.00       +8.3e+100%       0.08 ±331%    -100.0%       0.00        interrupts.CPU48.IWI:IRQ_work_interrupts
    774480 ±  3%      -6.7%     722507 ± 18%      +1.2%     783708        interrupts.CPU48.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU48.MCP:Machine_check_polls
     93.78 ± 31%    +434.7%     501.42 ±261%     -27.4%      68.11 ± 27%  interrupts.CPU48.NMI:Non-maskable_interrupts
     93.78 ± 31%    +434.7%     501.42 ±261%     -27.4%      68.11 ± 27%  interrupts.CPU48.PMI:Performance_monitoring_interrupts
     19.89 ± 72%     +37.8%      27.42 ±143%     -64.8%       7.00 ±104%  interrupts.CPU48.RES:Rescheduling_interrupts
      3.67 ±126%     -31.8%       2.50 ±124%     +51.5%       5.56 ± 22%  interrupts.CPU48.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU49.295:PCI-MSI.65536-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU49.3:IO-APIC.3-edge
      0.11 ±282%    +125.0%       0.25 ±173%    +100.0%       0.22 ±187%  interrupts.CPU49.48:PCI-MSI.31981581-edge.i40e-eth0-TxRx-12
     56.56 ±277%  +20032.6%      11386 ±233%     -94.9%       2.89 ±178%  interrupts.CPU49.85:PCI-MSI.31981618-edge.i40e-eth0-TxRx-49
      0.22 ±187%     -25.0%       0.17 ±223%     +50.0%       0.33 ±141%  interrupts.CPU49.96:PCI-MSI.31981629-edge.i40e-eth0-TxRx-60
    852.33 ± 69%      -8.7%     777.83 ± 91%     -35.6%     548.67 ±  2%  interrupts.CPU49.CAL:Function_call_interrupts
    774464 ±  3%      -6.7%     722496 ± 18%      +1.2%     783587        interrupts.CPU49.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU49.MCP:Machine_check_polls
    100.44 ± 22%    +311.8%     413.58 ±194%     -13.2%      87.22 ± 67%  interrupts.CPU49.NMI:Non-maskable_interrupts
    100.44 ± 22%    +311.8%     413.58 ±194%     -13.2%      87.22 ± 67%  interrupts.CPU49.PMI:Performance_monitoring_interrupts
     12.67 ± 50%     +40.1%      17.75 ± 95%    +171.9%      34.44 ±162%  interrupts.CPU49.RES:Rescheduling_interrupts
      2.22 ± 98%      -2.5%       2.17 ±144%    +175.0%       6.11 ± 36%  interrupts.CPU49.TLB:TLB_shootdowns
      0.00       +3.3e+101%       0.33 ±141% +1.1e+101%       0.11 ±282%  interrupts.CPU5.124:PCI-MSI.31981657-edge.i40e-eth0-TxRx-88
     21.22 ±282%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU5.298:PCI-MSI.288768-edge.ahci[0000:00:11.5]
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU5.298:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU5.299:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU5.30:PCI-MSI.48807936-edge.PCIe.PME,pciehp
      2667 ±282%     -97.6%      63.25 ±325%     -99.8%       5.78 ±282%  interrupts.CPU5.41:PCI-MSI.31981574-edge.i40e-eth0-TxRx-5
      0.11 ±282%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU5.76:PCI-MSI.31981609-edge.i40e-eth0-TxRx-40
      3265 ±232%     -80.0%     653.50 ± 39%     -75.1%     811.56 ± 79%  interrupts.CPU5.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.1e+101%       0.11 ±282%  interrupts.CPU5.IWI:IRQ_work_interrupts
    774423 ±  3%      -6.7%     722634 ± 18%      +1.2%     783690        interrupts.CPU5.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU5.MCP:Machine_check_polls
     85.56 ± 32%     +14.3%      97.75 ± 26%    +650.8%     642.33 ±253%  interrupts.CPU5.NMI:Non-maskable_interrupts
     85.56 ± 32%     +14.3%      97.75 ± 26%    +650.8%     642.33 ±253%  interrupts.CPU5.PMI:Performance_monitoring_interrupts
      5.56 ± 68%    +611.0%      39.50 ±194%     +52.0%       8.44 ± 84%  interrupts.CPU5.RES:Rescheduling_interrupts
      1.56 ± 80%     +28.6%       2.00 ±139%    +214.3%       4.89 ± 61%  interrupts.CPU5.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU50.297:PCI-MSI.67584-edge.ioat-msix
      0.33 ±141%     -50.0%       0.17 ±223%     -66.7%       0.11 ±282%  interrupts.CPU50.49:PCI-MSI.31981582-edge.i40e-eth0-TxRx-13
      0.00          -100.0%       0.00       +5.7e+102%       5.67 ±282%  interrupts.CPU50.4:IO-APIC.4-edge.ttyS0
     18.44 ±265%   +1356.6%     268.67 ±325%     +62.0%      29.89 ±282%  interrupts.CPU50.86:PCI-MSI.31981619-edge.i40e-eth0-TxRx-50
      0.11 ±282%    +125.0%       0.25 ±173%    +200.0%       0.33 ±141%  interrupts.CPU50.97:PCI-MSI.31981630-edge.i40e-eth0-TxRx-61
    542.78 ±  2%      -0.4%     540.58            +2.4%     555.78 ±  4%  interrupts.CPU50.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.1e+101%       0.11 ±282%  interrupts.CPU50.IWI:IRQ_work_interrupts
    774379 ±  3%      -6.7%     722434 ± 18%      +1.2%     783727        interrupts.CPU50.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU50.MCP:Machine_check_polls
    763.78 ±168%     -87.4%      96.17 ± 35%     -31.5%     523.22 ±241%  interrupts.CPU50.NMI:Non-maskable_interrupts
    763.78 ±168%     -87.4%      96.17 ± 35%     -31.5%     523.22 ±241%  interrupts.CPU50.PMI:Performance_monitoring_interrupts
     21.78 ±101%     -41.8%      12.67 ±128%     -26.0%      16.11 ±140%  interrupts.CPU50.RES:Rescheduling_interrupts
      2.89 ±134%     -22.1%       2.25 ±139%    +100.0%       5.78 ± 19%  interrupts.CPU50.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU51.295:PCI-MSI.65536-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU51.297:PCI-MSI.67584-edge.ioat-msix
      8.33 ±282%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU51.315:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU51.3:IO-APIC.3-edge
      0.22 ±187%    -100.0%       0.00            +0.0%       0.22 ±187%  interrupts.CPU51.50:PCI-MSI.31981583-edge.i40e-eth0-TxRx-14
    114.11 ±278%     +23.9%     141.33 ±195%     +37.6%     157.00 ±236%  interrupts.CPU51.87:PCI-MSI.31981620-edge.i40e-eth0-TxRx-51
      0.11 ±282%    +350.0%       0.50 ±100%      +0.0%       0.11 ±282%  interrupts.CPU51.98:PCI-MSI.31981631-edge.i40e-eth0-TxRx-62
    913.11 ± 79%     -41.0%     539.08            -0.4%     909.78 ±109%  interrupts.CPU51.CAL:Function_call_interrupts
    774452 ±  3%      -6.7%     722596 ± 18%      +1.2%     783589        interrupts.CPU51.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU51.MCP:Machine_check_polls
    101.67 ± 15%      +0.2%     101.83 ± 29%     -25.0%      76.22 ± 22%  interrupts.CPU51.NMI:Non-maskable_interrupts
    101.67 ± 15%      +0.2%     101.83 ± 29%     -25.0%      76.22 ± 22%  interrupts.CPU51.PMI:Performance_monitoring_interrupts
      9.11 ± 54%    +122.3%      20.25 ±166%    +529.3%      57.33 ±213%  interrupts.CPU51.RES:Rescheduling_interrupts
      2.33 ± 92%     +10.7%       2.58 ±128%    +104.8%       4.78 ± 23%  interrupts.CPU51.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU52.295:PCI-MSI.65536-edge.ioat-msix
      0.00          -100.0%       0.00       +5.1e+102%       5.11 ±282%  interrupts.CPU52.4:IO-APIC.4-edge.ttyS0
      0.11 ±282%    +200.0%       0.33 ±141%      +0.0%       0.11 ±282%  interrupts.CPU52.51:PCI-MSI.31981584-edge.i40e-eth0-TxRx-15
      1.22 ±203%   +9704.5%     119.83 ±295%    +345.5%       5.44 ±121%  interrupts.CPU52.88:PCI-MSI.31981621-edge.i40e-eth0-TxRx-52
      0.22 ±187%     -62.5%       0.08 ±331%     -50.0%       0.11 ±282%  interrupts.CPU52.99:PCI-MSI.31981632-edge.i40e-eth0-TxRx-63
    811.11 ± 71%     -33.3%     541.33           -28.4%     580.56 ± 17%  interrupts.CPU52.CAL:Function_call_interrupts
      0.00       +8.3e+100%       0.08 ±331%    -100.0%       0.00        interrupts.CPU52.IWI:IRQ_work_interrupts
    774498 ±  3%      -6.7%     722808 ± 18%      +1.2%     783640        interrupts.CPU52.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU52.MCP:Machine_check_polls
    102.67 ± 18%      +0.0%     102.67 ± 31%     -27.2%      74.78 ± 22%  interrupts.CPU52.NMI:Non-maskable_interrupts
    102.67 ± 18%      +0.0%     102.67 ± 31%     -27.2%      74.78 ± 22%  interrupts.CPU52.PMI:Performance_monitoring_interrupts
      8.33 ± 47%    +119.0%      18.25 ±137%    +120.0%      18.33 ±162%  interrupts.CPU52.RES:Rescheduling_interrupts
      2.33 ± 78%     +21.4%       2.83 ±122%    +133.3%       5.44 ± 21%  interrupts.CPU52.TLB:TLB_shootdowns
      0.00       +1.7e+101%       0.17 ±223% +2.2e+101%       0.22 ±187%  interrupts.CPU53.100:PCI-MSI.31981633-edge.i40e-eth0-TxRx-64
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU53.3:IO-APIC.3-edge
      0.00       +4.3e+102%       4.33 ±331%    -100.0%       0.00        interrupts.CPU53.4:IO-APIC.4-edge.ttyS0
      0.00       +1.7e+101%       0.17 ±223% +1.1e+101%       0.11 ±282%  interrupts.CPU53.52:PCI-MSI.31981585-edge.i40e-eth0-TxRx-16
      5.22 ±282%     -18.6%       4.25 ±227%     -44.7%       2.89 ±282%  interrupts.CPU53.89:PCI-MSI.31981622-edge.i40e-eth0-TxRx-53
    540.00 ±  2%     +12.4%     607.17 ± 34%      +1.5%     547.89 ±  2%  interrupts.CPU53.CAL:Function_call_interrupts
      0.00       +8.3e+100%       0.08 ±331% +2.2e+101%       0.22 ±282%  interrupts.CPU53.IWI:IRQ_work_interrupts
    774539 ±  3%      -6.7%     722657 ± 18%      +1.2%     783620        interrupts.CPU53.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU53.MCP:Machine_check_polls
     99.22 ± 26%     +12.1%     111.25 ± 33%    +295.9%     392.78 ±231%  interrupts.CPU53.NMI:Non-maskable_interrupts
     99.22 ± 26%     +12.1%     111.25 ± 33%    +295.9%     392.78 ±231%  interrupts.CPU53.PMI:Performance_monitoring_interrupts
      9.89 ± 63%    +219.4%      31.58 ±142%     +31.5%      13.00 ±127%  interrupts.CPU53.RES:Rescheduling_interrupts
      2.22 ± 89%     +16.2%       2.58 ±135%    +140.0%       5.33 ± 27%  interrupts.CPU53.TLB:TLB_shootdowns
      0.22 ±187%     -62.5%       0.08 ±331%     -50.0%       0.11 ±282%  interrupts.CPU54.101:PCI-MSI.31981634-edge.i40e-eth0-TxRx-65
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU54.297:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU54.298:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU54.3:IO-APIC.3-edge
      5.89 ±282%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU54.4:IO-APIC.4-edge.ttyS0
      0.00          -100.0%       0.00       +1.1e+101%       0.11 ±282%  interrupts.CPU54.53:PCI-MSI.31981586-edge.i40e-eth0-TxRx-17
      9.89 ±234%    +850.6%      94.00 ±329%     -66.3%       3.33 ±282%  interrupts.CPU54.90:PCI-MSI.31981623-edge.i40e-eth0-TxRx-54
    535.67          +104.0%       1093 ±112%      -0.0%     535.56 ±  5%  interrupts.CPU54.CAL:Function_call_interrupts
      0.00       +8.3e+100%       0.08 ±331%    -100.0%       0.00        interrupts.CPU54.IWI:IRQ_work_interrupts
    774484 ±  3%      -6.7%     722929 ± 18%      +1.2%     783621        interrupts.CPU54.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU54.MCP:Machine_check_polls
     95.56 ± 26%    +163.6%     251.92 ±218%    +134.0%     223.56 ±186%  interrupts.CPU54.NMI:Non-maskable_interrupts
     95.56 ± 26%    +163.6%     251.92 ±218%    +134.0%     223.56 ±186%  interrupts.CPU54.PMI:Performance_monitoring_interrupts
      7.44 ± 63%    +376.9%      35.50 ±128%     +62.7%      12.11 ± 75%  interrupts.CPU54.RES:Rescheduling_interrupts
      2.78 ± 84%      +5.0%       2.92 ±120%    +116.0%       6.00 ± 56%  interrupts.CPU54.TLB:TLB_shootdowns
      0.11 ±282%     -25.0%       0.08 ±331%      +0.0%       0.11 ±282%  interrupts.CPU55.102:PCI-MSI.31981635-edge.i40e-eth0-TxRx-66
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU55.295:PCI-MSI.65536-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU55.298:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU55.3:IO-APIC.3-edge
      0.00       +8.3e+100%       0.08 ±331% +2.2e+101%       0.22 ±187%  interrupts.CPU55.54:PCI-MSI.31981587-edge.i40e-eth0-TxRx-18
      0.22 ±187%   +6162.5%      13.92 ±180%  +59950.0%     133.44 ±282%  interrupts.CPU55.91:PCI-MSI.31981624-edge.i40e-eth0-TxRx-55
    547.56 ±  3%      +1.0%     553.00 ±  5%     +18.6%     649.44 ± 40%  interrupts.CPU55.CAL:Function_call_interrupts
      0.00       +8.3e+100%       0.08 ±331% +1.1e+101%       0.11 ±282%  interrupts.CPU55.IWI:IRQ_work_interrupts
    774560 ±  3%      -6.7%     722465 ± 18%      +1.2%     783715        interrupts.CPU55.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU55.MCP:Machine_check_polls
    314.33 ±196%     -68.8%      98.00 ± 37%     +86.2%     585.33 ±246%  interrupts.CPU55.NMI:Non-maskable_interrupts
    314.33 ±196%     -68.8%      98.00 ± 37%     +86.2%     585.33 ±246%  interrupts.CPU55.PMI:Performance_monitoring_interrupts
     26.00 ±135%     -50.3%      12.92 ±128%     -49.1%      13.22 ±131%  interrupts.CPU55.RES:Rescheduling_interrupts
      2.44 ± 88%      -4.5%       2.33 ±130%    +136.4%       5.78 ± 15%  interrupts.CPU55.TLB:TLB_shootdowns
      0.44 ±111%     -81.2%       0.08 ±331%     -50.0%       0.22 ±187%  interrupts.CPU56.103:PCI-MSI.31981636-edge.i40e-eth0-TxRx-67
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU56.298:PCI-MSI.69632-edge.ioat-msix
      0.00       +4.2e+102%       4.17 ±331%    -100.0%       0.00        interrupts.CPU56.4:IO-APIC.4-edge.ttyS0
      0.22 ±187%     +50.0%       0.33 ±141%     -50.0%       0.11 ±282%  interrupts.CPU56.55:PCI-MSI.31981588-edge.i40e-eth0-TxRx-19
     33.78 ±282%     -92.8%       2.42 ±319%  +43008.9%      14561 ±282%  interrupts.CPU56.92:PCI-MSI.31981625-edge.i40e-eth0-TxRx-56
    834.00 ± 99%      +3.6%     864.25 ±103%     -34.5%     545.89        interrupts.CPU56.CAL:Function_call_interrupts
    774616 ±  3%      -6.7%     722502 ± 18%      +1.2%     783645        interrupts.CPU56.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU56.MCP:Machine_check_polls
    100.56 ± 19%      -1.8%      98.75 ± 28%     -25.9%      74.56 ± 20%  interrupts.CPU56.NMI:Non-maskable_interrupts
    100.56 ± 19%      -1.8%      98.75 ± 28%     -25.9%      74.56 ± 20%  interrupts.CPU56.PMI:Performance_monitoring_interrupts
     18.89 ± 91%     +28.8%      24.33 ±131%     -47.6%       9.89 ± 74%  interrupts.CPU56.RES:Rescheduling_interrupts
      2.89 ± 91%     -16.3%       2.42 ±145%    +103.8%       5.89 ± 12%  interrupts.CPU56.TLB:TLB_shootdowns
      0.11 ±282%    -100.0%       0.00            +0.0%       0.11 ±282%  interrupts.CPU57.104:PCI-MSI.31981637-edge.i40e-eth0-TxRx-68
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU57.295:PCI-MSI.65536-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU57.299:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU57.3:IO-APIC.3-edge
      0.00       +3.8e+102%       3.83 ±331%    -100.0%       0.00        interrupts.CPU57.4:IO-APIC.4-edge.ttyS0
      0.11 ±282%     +50.0%       0.17 ±223%    +100.0%       0.22 ±187%  interrupts.CPU57.56:PCI-MSI.31981589-edge.i40e-eth0-TxRx-20
    289.78 ±219%     -99.5%       1.58 ±313%     -96.7%       9.67 ±275%  interrupts.CPU57.93:PCI-MSI.31981626-edge.i40e-eth0-TxRx-57
      1141 ±100%     -52.5%     541.83           -45.2%     625.78 ± 36%  interrupts.CPU57.CAL:Function_call_interrupts
      0.00       +8.3e+100%       0.08 ±331% +1.1e+101%       0.11 ±282%  interrupts.CPU57.IWI:IRQ_work_interrupts
    774466 ±  3%      -6.7%     722530 ± 18%      +1.2%     783693        interrupts.CPU57.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU57.MCP:Machine_check_polls
     96.00 ± 25%      +0.3%      96.25 ± 33%    +534.5%     609.11 ±245%  interrupts.CPU57.NMI:Non-maskable_interrupts
     96.00 ± 25%      +0.3%      96.25 ± 33%    +534.5%     609.11 ±245%  interrupts.CPU57.PMI:Performance_monitoring_interrupts
      8.78 ± 71%      +6.3%       9.33 ±125%    +103.8%      17.89 ±125%  interrupts.CPU57.RES:Rescheduling_interrupts
      2.33 ± 90%      -3.6%       2.25 ±143%    +128.6%       5.33 ± 12%  interrupts.CPU57.TLB:TLB_shootdowns
      0.00       +2.5e+101%       0.25 ±173% +1.1e+101%       0.11 ±282%  interrupts.CPU58.105:PCI-MSI.31981638-edge.i40e-eth0-TxRx-69
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU58.297:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU58.3:IO-APIC.3-edge
      0.33 ±141%     -50.0%       0.17 ±223%    -100.0%       0.00        interrupts.CPU58.57:PCI-MSI.31981590-edge.i40e-eth0-TxRx-21
      0.00       +3.5e+104%     349.42 ±315% +1.2e+104%     115.44 ±238%  interrupts.CPU58.94:PCI-MSI.31981627-edge.i40e-eth0-TxRx-58
    894.44 ±113%     -38.6%     549.17 ±  3%     +19.8%       1071 ±142%  interrupts.CPU58.CAL:Function_call_interrupts
      0.00       +8.3e+100%       0.08 ±331%    -100.0%       0.00        interrupts.CPU58.IWI:IRQ_work_interrupts
    774497 ±  3%      -6.7%     722640 ± 18%      +1.2%     783760        interrupts.CPU58.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU58.MCP:Machine_check_polls
    101.44 ± 15%      -5.0%      96.33 ± 40%     -22.1%      79.00 ± 10%  interrupts.CPU58.NMI:Non-maskable_interrupts
    101.44 ± 15%      -5.0%      96.33 ± 40%     -22.1%      79.00 ± 10%  interrupts.CPU58.PMI:Performance_monitoring_interrupts
      5.00 ± 43%     +78.3%       8.92 ± 74%    +268.9%      18.44 ±116%  interrupts.CPU58.RES:Rescheduling_interrupts
      2.11 ±105%     +42.1%       3.00 ±120%    +163.2%       5.56 ± 14%  interrupts.CPU58.TLB:TLB_shootdowns
      0.11 ±282%    +350.0%       0.50 ±100%      +0.0%       0.11 ±282%  interrupts.CPU59.106:PCI-MSI.31981639-edge.i40e-eth0-TxRx-70
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU59.297:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU59.3:IO-APIC.3-edge
      0.00       +1.7e+101%       0.17 ±223% +1.1e+101%       0.11 ±282%  interrupts.CPU59.58:PCI-MSI.31981591-edge.i40e-eth0-TxRx-22
      0.00       +4.1e+103%      40.58 ±289% +2.6e+103%      26.11 ±187%  interrupts.CPU59.95:PCI-MSI.31981628-edge.i40e-eth0-TxRx-59
    543.22 ±  2%    +311.4%       2234 ±248%      +0.6%     546.33        interrupts.CPU59.CAL:Function_call_interrupts
      0.00       +1.7e+101%       0.17 ±223% +1.1e+101%       0.11 ±282%  interrupts.CPU59.IWI:IRQ_work_interrupts
    774502 ±  3%      -6.7%     722579 ± 18%      +1.2%     783773        interrupts.CPU59.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU59.MCP:Machine_check_polls
     95.00 ± 30%    +144.9%     232.67 ±183%    +496.7%     566.89 ±244%  interrupts.CPU59.NMI:Non-maskable_interrupts
     95.00 ± 30%    +144.9%     232.67 ±183%    +496.7%     566.89 ±244%  interrupts.CPU59.PMI:Performance_monitoring_interrupts
     16.00 ±135%     -28.6%      11.42 ± 82%     -32.6%      10.78 ± 86%  interrupts.CPU59.RES:Rescheduling_interrupts
      2.33 ± 96%     +42.9%       3.33 ±109%    +133.3%       5.44 ± 23%  interrupts.CPU59.TLB:TLB_shootdowns
      0.00       +1.7e+101%       0.17 ±223% +2.2e+101%       0.22 ±187%  interrupts.CPU6.125:PCI-MSI.31981658-edge.i40e-eth0-TxRx-89
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU6.297:PCI-MSI.67584-edge.ioat-msix
     11109 ±282%     -99.2%      84.42 ±317%     -98.4%     176.00 ±166%  interrupts.CPU6.42:PCI-MSI.31981575-edge.i40e-eth0-TxRx-6
      0.33 ±141%     -25.0%       0.25 ±173%     -33.3%       0.22 ±187%  interrupts.CPU6.77:PCI-MSI.31981610-edge.i40e-eth0-TxRx-41
    795.44 ± 80%     +44.0%       1145 ±110%     -24.6%     599.67 ± 13%  interrupts.CPU6.CAL:Function_call_interrupts
      0.00       +8.3e+100%       0.08 ±331%    -100.0%       0.00        interrupts.CPU6.IWI:IRQ_work_interrupts
    774651 ±  3%      -6.7%     722932 ± 18%      +1.2%     783584        interrupts.CPU6.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU6.MCP:Machine_check_polls
    104.67 ± 20%    +468.5%     595.00 ±282%     +14.3%     119.67 ±113%  interrupts.CPU6.NMI:Non-maskable_interrupts
    104.67 ± 20%    +468.5%     595.00 ±282%     +14.3%     119.67 ±113%  interrupts.CPU6.PMI:Performance_monitoring_interrupts
     17.00 ± 80%    +271.6%      63.17 ±208%      +8.5%      18.44 ± 84%  interrupts.CPU6.RES:Rescheduling_interrupts
      1.56 ±105%     +23.2%       1.92 ±142%    +150.0%       3.89 ± 35%  interrupts.CPU6.TLB:TLB_shootdowns
      0.11 ±282%     +50.0%       0.17 ±223%    +100.0%       0.22 ±187%  interrupts.CPU60.107:PCI-MSI.31981640-edge.i40e-eth0-TxRx-71
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU60.295:PCI-MSI.65536-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU60.3:IO-APIC.3-edge
      0.44 ±111%     -62.5%       0.17 ±223%     -50.0%       0.22 ±187%  interrupts.CPU60.59:PCI-MSI.31981592-edge.i40e-eth0-TxRx-23
    281.00 ±281%     -64.3%     100.25 ±296%      +7.4%     301.89 ±142%  interrupts.CPU60.96:PCI-MSI.31981629-edge.i40e-eth0-TxRx-60
    864.11 ±107%     -36.6%     548.25 ±  3%      -3.3%     835.89 ± 87%  interrupts.CPU60.CAL:Function_call_interrupts
    774542 ±  3%      -6.7%     722360 ± 18%      +1.2%     783781        interrupts.CPU60.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU60.MCP:Machine_check_polls
     88.56 ± 36%     +15.7%     102.42 ± 58%     -11.4%      78.44 ± 18%  interrupts.CPU60.NMI:Non-maskable_interrupts
     88.56 ± 36%     +15.7%     102.42 ± 58%     -11.4%      78.44 ± 18%  interrupts.CPU60.PMI:Performance_monitoring_interrupts
     15.89 ±132%    +134.4%      37.25 ±205%     -21.7%      12.44 ± 49%  interrupts.CPU60.RES:Rescheduling_interrupts
      1.89 ±112%     +19.1%       2.25 ±135%    +182.4%       5.33 ± 19%  interrupts.CPU60.TLB:TLB_shootdowns
      0.22 ±187%     -25.0%       0.17 ±223%     -50.0%       0.11 ±282%  interrupts.CPU61.108:PCI-MSI.31981641-edge.i40e-eth0-TxRx-72
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU61.295:PCI-MSI.65536-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU61.297:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU61.298:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU61.3:IO-APIC.3-edge
      0.00       +3.8e+102%       3.83 ±331%    -100.0%       0.00        interrupts.CPU61.4:IO-APIC.4-edge.ttyS0
      0.33 ±141%     -50.0%       0.17 ±223%    -100.0%       0.00        interrupts.CPU61.60:PCI-MSI.31981593-edge.i40e-eth0-TxRx-24
    201.78 ±279%     -26.9%     147.50 ±324%     -97.4%       5.33 ±172%  interrupts.CPU61.97:PCI-MSI.31981630-edge.i40e-eth0-TxRx-61
      1844 ±146%     -71.3%     528.92 ± 10%     -67.1%     607.00 ± 28%  interrupts.CPU61.CAL:Function_call_interrupts
      0.11 ±282%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU61.IWI:IRQ_work_interrupts
    774551 ±  3%      -6.7%     722486 ± 18%      +1.2%     783806        interrupts.CPU61.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU61.MCP:Machine_check_polls
    799.33 ±191%     -73.6%     211.33 ±196%     -91.2%      70.67 ± 25%  interrupts.CPU61.NMI:Non-maskable_interrupts
    799.33 ±191%     -73.6%     211.33 ±196%     -91.2%      70.67 ± 25%  interrupts.CPU61.PMI:Performance_monitoring_interrupts
     19.44 ±125%      +5.9%      20.58 ±133%     -38.3%      12.00 ± 79%  interrupts.CPU61.RES:Rescheduling_interrupts
      2.67 ± 75%     -12.5%       2.33 ±137%    +112.5%       5.67 ± 22%  interrupts.CPU61.TLB:TLB_shootdowns
      0.33 ±141%     -75.0%       0.08 ±331%     -33.3%       0.22 ±187%  interrupts.CPU62.109:PCI-MSI.31981642-edge.i40e-eth0-TxRx-73
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU62.297:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU62.299:PCI-MSI.71680-edge.ioat-msix
      0.11 ±282%     -25.0%       0.08 ±331%      +0.0%       0.11 ±282%  interrupts.CPU62.61:PCI-MSI.31981594-edge.i40e-eth0-TxRx-25
    349.00 ±217%    +161.3%     911.92 ±195%     -96.9%      10.78 ±279%  interrupts.CPU62.98:PCI-MSI.31981631-edge.i40e-eth0-TxRx-62
    545.33 ±  3%      +0.2%     546.67 ±  4%     +19.1%     649.22 ± 40%  interrupts.CPU62.CAL:Function_call_interrupts
    774524 ±  3%      -6.7%     722603 ± 18%      +1.2%     783769        interrupts.CPU62.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU62.MCP:Machine_check_polls
    235.67 ±177%     -42.2%     136.17 ± 88%     -71.1%      68.22 ± 29%  interrupts.CPU62.NMI:Non-maskable_interrupts
    235.67 ±177%     -42.2%     136.17 ± 88%     -71.1%      68.22 ± 29%  interrupts.CPU62.PMI:Performance_monitoring_interrupts
     10.00 ± 55%     +85.0%      18.50 ±184%      -1.1%       9.89 ± 83%  interrupts.CPU62.RES:Rescheduling_interrupts
      2.33 ± 85%      +3.6%       2.42 ±126%    +133.3%       5.44 ± 23%  interrupts.CPU62.TLB:TLB_shootdowns
      0.00       +2.5e+101%       0.25 ±173% +1.1e+101%       0.11 ±282%  interrupts.CPU63.110:PCI-MSI.31981643-edge.i40e-eth0-TxRx-74
      0.00       +8.3e+100%       0.08 ±331% +1.1e+101%       0.11 ±282%  interrupts.CPU63.62:PCI-MSI.31981595-edge.i40e-eth0-TxRx-26
    178.00 ±268%     +48.4%     264.08 ±242%   +1037.1%       2024 ±282%  interrupts.CPU63.99:PCI-MSI.31981632-edge.i40e-eth0-TxRx-63
    536.56           +67.8%     900.58 ± 97%      +3.6%     556.11 ±  6%  interrupts.CPU63.CAL:Function_call_interrupts
    774640 ±  3%      -6.7%     722593 ± 18%      +1.2%     783749        interrupts.CPU63.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU63.MCP:Machine_check_polls
     98.89 ± 27%    +199.3%     296.00 ±229%     -36.6%      62.67 ± 35%  interrupts.CPU63.NMI:Non-maskable_interrupts
     98.89 ± 27%    +199.3%     296.00 ±229%     -36.6%      62.67 ± 35%  interrupts.CPU63.PMI:Performance_monitoring_interrupts
     12.00 ± 60%     +26.4%      15.17 ± 81%     -26.9%       8.78 ± 61%  interrupts.CPU63.RES:Rescheduling_interrupts
      2.89 ± 68%     -13.5%       2.50 ±119%     +92.3%       5.56 ± 26%  interrupts.CPU63.TLB:TLB_shootdowns
     48.11 ±282%     -32.8%      32.33 ±265%     -92.8%       3.44 ±272%  interrupts.CPU64.100:PCI-MSI.31981633-edge.i40e-eth0-TxRx-64
      0.22 ±187%     -62.5%       0.08 ±331%    -100.0%       0.00        interrupts.CPU64.111:PCI-MSI.31981644-edge.i40e-eth0-TxRx-75
      0.00       +1.6e+103%      15.92 ±331%    -100.0%       0.00        interrupts.CPU64.296:PCI-MSI.288768-edge.ahci[0000:00:11.5]
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU64.297:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU64.298:PCI-MSI.69632-edge.ioat-msix
      0.22 ±187%    -100.0%       0.00           +50.0%       0.33 ±141%  interrupts.CPU64.63:PCI-MSI.31981596-edge.i40e-eth0-TxRx-27
    624.67 ± 26%     +50.5%     940.42 ± 96%     +24.4%     777.00 ± 53%  interrupts.CPU64.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.1e+101%       0.11 ±282%  interrupts.CPU64.IWI:IRQ_work_interrupts
    774613 ±  3%      -6.7%     722509 ± 18%      +1.2%     783840        interrupts.CPU64.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU64.MCP:Machine_check_polls
    100.22 ± 26%     -13.4%      86.83 ± 34%     -33.5%      66.67 ± 43%  interrupts.CPU64.NMI:Non-maskable_interrupts
    100.22 ± 26%     -13.4%      86.83 ± 34%     -33.5%      66.67 ± 43%  interrupts.CPU64.PMI:Performance_monitoring_interrupts
     12.44 ± 89%      -0.9%      12.33 ± 54%     -29.5%       8.78 ± 55%  interrupts.CPU64.RES:Rescheduling_interrupts
      3.00 ± 98%     -11.1%       2.67 ±108%     +81.5%       5.44 ± 19%  interrupts.CPU64.TLB:TLB_shootdowns
     16.11 ±196%    +434.8%      86.17 ±293%     -11.7%      14.22 ±210%  interrupts.CPU65.101:PCI-MSI.31981634-edge.i40e-eth0-TxRx-65
      0.11 ±282%     -25.0%       0.08 ±331%    +100.0%       0.22 ±187%  interrupts.CPU65.112:PCI-MSI.31981645-edge.i40e-eth0-TxRx-76
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU65.298:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU65.300:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00       +2.2e+101%       0.22 ±187%  interrupts.CPU65.64:PCI-MSI.31981597-edge.i40e-eth0-TxRx-28
    563.00 ±  3%      -5.1%     534.08 ± 11%     +29.6%     729.44 ± 49%  interrupts.CPU65.CAL:Function_call_interrupts
    774537 ±  3%      -6.7%     722512 ± 18%      +1.2%     783856        interrupts.CPU65.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU65.MCP:Machine_check_polls
    102.44 ± 18%    +119.5%     224.92 ±190%     -35.9%      65.67 ± 33%  interrupts.CPU65.NMI:Non-maskable_interrupts
    102.44 ± 18%    +119.5%     224.92 ±190%     -35.9%      65.67 ± 33%  interrupts.CPU65.PMI:Performance_monitoring_interrupts
     12.22 ± 77%     -16.8%      10.17 ± 82%     -36.4%       7.78 ± 80%  interrupts.CPU65.RES:Rescheduling_interrupts
      2.56 ± 78%      +7.6%       2.75 ±109%    +156.5%       6.56 ± 38%  interrupts.CPU65.TLB:TLB_shootdowns
     28.00 ±282%    +161.9%      73.33 ±331%     -32.5%      18.89 ±264%  interrupts.CPU66.102:PCI-MSI.31981635-edge.i40e-eth0-TxRx-66
      0.00       +1.7e+101%       0.17 ±223% +3.3e+101%       0.33 ±141%  interrupts.CPU66.113:PCI-MSI.31981646-edge.i40e-eth0-TxRx-77
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU66.298:PCI-MSI.69632-edge.ioat-msix
      0.22 ±187%     -62.5%       0.08 ±331%     -50.0%       0.11 ±282%  interrupts.CPU66.65:PCI-MSI.31981598-edge.i40e-eth0-TxRx-29
    716.44 ± 63%      +6.5%     762.75 ± 87%     -18.2%     586.11 ± 15%  interrupts.CPU66.CAL:Function_call_interrupts
    774568 ±  3%      -6.7%     722454 ± 18%      +1.2%     783635        interrupts.CPU66.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU66.MCP:Machine_check_polls
     98.56 ± 26%    +437.9%     530.08 ±210%    +286.4%     380.78 ±236%  interrupts.CPU66.NMI:Non-maskable_interrupts
     98.56 ± 26%    +437.9%     530.08 ±210%    +286.4%     380.78 ±236%  interrupts.CPU66.PMI:Performance_monitoring_interrupts
     58.22 ±185%      -8.3%      53.42 ±269%     -77.3%      13.22 ±135%  interrupts.CPU66.RES:Rescheduling_interrupts
      2.44 ± 92%      +5.7%       2.58 ±118%    +113.6%       5.22 ± 29%  interrupts.CPU66.TLB:TLB_shootdowns
     18.22 ±154%    +980.2%     196.83 ±307%     -98.8%       0.22 ±187%  interrupts.CPU67.103:PCI-MSI.31981636-edge.i40e-eth0-TxRx-67
      0.00       +8.3e+100%       0.08 ±331% +2.2e+101%       0.22 ±187%  interrupts.CPU67.114:PCI-MSI.31981647-edge.i40e-eth0-TxRx-78
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU67.297:PCI-MSI.67584-edge.ioat-msix
      5.11 ±282%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU67.4:IO-APIC.4-edge.ttyS0
      0.00       +1.7e+101%       0.17 ±223% +1.1e+101%       0.11 ±282%  interrupts.CPU67.66:PCI-MSI.31981599-edge.i40e-eth0-TxRx-30
    827.56 ± 95%     +63.1%       1349 ±195%     +19.8%     991.67 ±125%  interrupts.CPU67.CAL:Function_call_interrupts
    774578 ±  3%      -6.7%     722688 ± 18%      +1.2%     783762        interrupts.CPU67.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU67.MCP:Machine_check_polls
    107.89 ± 18%      -7.5%      99.75 ± 27%     -35.2%      69.89 ± 32%  interrupts.CPU67.NMI:Non-maskable_interrupts
    107.89 ± 18%      -7.5%      99.75 ± 27%     -35.2%      69.89 ± 32%  interrupts.CPU67.PMI:Performance_monitoring_interrupts
     26.89 ±173%     -58.8%      11.08 ±113%     -65.7%       9.22 ± 68%  interrupts.CPU67.RES:Rescheduling_interrupts
      2.89 ± 82%     -22.1%       2.25 ±123%    +107.7%       6.00 ± 17%  interrupts.CPU67.TLB:TLB_shootdowns
     74.56 ±252%     -90.4%       7.17 ±331%    +108.3%     155.33 ±282%  interrupts.CPU68.104:PCI-MSI.31981637-edge.i40e-eth0-TxRx-68
      0.11 ±282%     +50.0%       0.17 ±223%    -100.0%       0.00        interrupts.CPU68.115:PCI-MSI.31981648-edge.i40e-eth0-TxRx-79
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU68.297:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU68.299:PCI-MSI.71680-edge.ioat-msix
      0.11 ±282%    +125.0%       0.25 ±173%      +0.0%       0.11 ±282%  interrupts.CPU68.67:PCI-MSI.31981600-edge.i40e-eth0-TxRx-31
    645.89 ± 24%      -6.9%     601.58 ± 31%     +81.4%       1171 ± 98%  interrupts.CPU68.CAL:Function_call_interrupts
      0.11 ±282%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU68.IWI:IRQ_work_interrupts
    774540 ±  3%      -6.7%     722502 ± 18%      +1.2%     783678        interrupts.CPU68.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU68.MCP:Machine_check_polls
    945.78 ±200%     -89.6%      98.50 ± 27%     -77.3%     214.67 ±181%  interrupts.CPU68.NMI:Non-maskable_interrupts
    945.78 ±200%     -89.6%      98.50 ± 27%     -77.3%     214.67 ±181%  interrupts.CPU68.PMI:Performance_monitoring_interrupts
     30.00 ±141%    +159.7%      77.92 ±233%     -34.4%      19.67 ± 60%  interrupts.CPU68.RES:Rescheduling_interrupts
      2.00 ± 74%     +41.7%       2.83 ±122%    +183.3%       5.67 ± 18%  interrupts.CPU68.TLB:TLB_shootdowns
      0.00       +8.3e+102%       8.33 ±232%   +1e+104%     100.00 ±282%  interrupts.CPU69.105:PCI-MSI.31981638-edge.i40e-eth0-TxRx-69
      0.22 ±187%     +50.0%       0.33 ±141%    +100.0%       0.44 ±111%  interrupts.CPU69.116:PCI-MSI.31981649-edge.i40e-eth0-TxRx-80
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU69.3:IO-APIC.3-edge
      0.11 ±282%    +125.0%       0.25 ±173%      +0.0%       0.11 ±282%  interrupts.CPU69.68:PCI-MSI.31981601-edge.i40e-eth0-TxRx-32
    563.00 ±  8%     +47.6%     831.08 ±111%     +19.1%     670.44 ± 47%  interrupts.CPU69.CAL:Function_call_interrupts
    774477 ±  3%      -6.7%     722587 ± 18%      +1.2%     783831        interrupts.CPU69.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU69.MCP:Machine_check_polls
    245.67 ±164%     -59.5%      99.58 ± 22%     -71.4%      70.22 ± 36%  interrupts.CPU69.NMI:Non-maskable_interrupts
    245.67 ±164%     -59.5%      99.58 ± 22%     -71.4%      70.22 ± 36%  interrupts.CPU69.PMI:Performance_monitoring_interrupts
     12.67 ± 89%     +14.5%      14.50 ±104%     +94.7%      24.67 ± 66%  interrupts.CPU69.RES:Rescheduling_interrupts
      2.78 ± 75%      +5.0%       2.92 ±107%     +88.0%       5.22 ± 21%  interrupts.CPU69.TLB:TLB_shootdowns
      0.11 ±282%     -25.0%       0.08 ±331%    +100.0%       0.22 ±187%  interrupts.CPU7.126:PCI-MSI.31981659-edge.i40e-eth0-TxRx-90
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU7.297:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU7.299:PCI-MSI.71680-edge.ioat-msix
      1.33 ±282%    +756.2%      11.42 ±331%    +533.3%       8.44 ±154%  interrupts.CPU7.43:PCI-MSI.31981576-edge.i40e-eth0-TxRx-7
      0.22 ±187%    -100.0%       0.00            +0.0%       0.22 ±187%  interrupts.CPU7.78:PCI-MSI.31981611-edge.i40e-eth0-TxRx-42
    961.67 ± 80%     -36.6%     609.58 ± 34%     -25.0%     720.78 ± 44%  interrupts.CPU7.CAL:Function_call_interrupts
      0.22 ±282%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU7.IWI:IRQ_work_interrupts
    774552 ±  3%      -6.7%     722407 ± 18%      +1.2%     783708        interrupts.CPU7.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU7.MCP:Machine_check_polls
    764.22 ±250%     -87.6%      94.50 ± 32%     -65.4%     264.22 ±199%  interrupts.CPU7.NMI:Non-maskable_interrupts
    764.22 ±250%     -87.6%      94.50 ± 32%     -65.4%     264.22 ±199%  interrupts.CPU7.PMI:Performance_monitoring_interrupts
     26.56 ±107%     +18.6%      31.50 ±161%     -38.1%      16.44 ± 75%  interrupts.CPU7.RES:Rescheduling_interrupts
      2.00 ± 88%      +4.2%       2.08 ±149%    +100.0%       4.00 ± 33%  interrupts.CPU7.TLB:TLB_shootdowns
      4.22 ±282%  +32840.8%       1390 ±330%   +2934.2%     128.11 ±198%  interrupts.CPU70.106:PCI-MSI.31981639-edge.i40e-eth0-TxRx-70
      0.22 ±187%     -25.0%       0.17 ±223%     -50.0%       0.11 ±282%  interrupts.CPU70.117:PCI-MSI.31981650-edge.i40e-eth0-TxRx-81
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU70.297:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU70.298:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU70.3:IO-APIC.3-edge
      0.11 ±282%    +125.0%       0.25 ±173%    -100.0%       0.00        interrupts.CPU70.69:PCI-MSI.31981602-edge.i40e-eth0-TxRx-33
    549.22 ±  3%      +7.8%     591.92 ± 22%    +125.8%       1240 ±133%  interrupts.CPU70.CAL:Function_call_interrupts
    774504 ±  3%      -6.7%     722659 ± 18%      +1.2%     783673        interrupts.CPU70.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU70.MCP:Machine_check_polls
    101.89 ± 15%      +2.2%     104.08 ± 23%     -34.5%      66.78 ± 29%  interrupts.CPU70.NMI:Non-maskable_interrupts
    101.89 ± 15%      +2.2%     104.08 ± 23%     -34.5%      66.78 ± 29%  interrupts.CPU70.PMI:Performance_monitoring_interrupts
     69.56 ±257%    +111.2%     146.92 ±190%     +46.2%     101.67 ±236%  interrupts.CPU70.RES:Rescheduling_interrupts
      2.67 ± 86%      +3.1%       2.75 ±111%    +108.3%       5.56 ± 12%  interrupts.CPU70.TLB:TLB_shootdowns
      3.67 ±273%  +94829.5%       3480 ±319%   +5657.6%     211.11 ±282%  interrupts.CPU71.107:PCI-MSI.31981640-edge.i40e-eth0-TxRx-71
      0.11 ±282%     -25.0%       0.08 ±331%      +0.0%       0.11 ±282%  interrupts.CPU71.118:PCI-MSI.31981651-edge.i40e-eth0-TxRx-82
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU71.297:PCI-MSI.67584-edge.ioat-msix
      0.11 ±282%    -100.0%       0.00          +100.0%       0.22 ±187%  interrupts.CPU71.70:PCI-MSI.31981603-edge.i40e-eth0-TxRx-34
    545.67 ±  3%      +0.7%     549.50 ±  5%    +306.3%       2216 ±213%  interrupts.CPU71.CAL:Function_call_interrupts
      0.00       +8.3e+100%       0.08 ±331%    -100.0%       0.00        interrupts.CPU71.IWI:IRQ_work_interrupts
    774504 ±  3%      -6.4%     725220 ± 17%      +1.2%     783668        interrupts.CPU71.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU71.MCP:Machine_check_polls
    739.56 ±160%     +13.7%     840.58 ±213%     -90.2%      72.22 ± 27%  interrupts.CPU71.NMI:Non-maskable_interrupts
    739.56 ±160%     +13.7%     840.58 ±213%     -90.2%      72.22 ± 27%  interrupts.CPU71.PMI:Performance_monitoring_interrupts
     17.56 ±139%    +191.0%      51.08 ±144%     -50.6%       8.67 ± 83%  interrupts.CPU71.RES:Rescheduling_interrupts
      2.33 ± 96%      +7.1%       2.50 ±117%    +147.6%       5.78 ± 19%  interrupts.CPU71.TLB:TLB_shootdowns
     13.22 ±202%     -54.6%       6.00 ±312%  +54798.3%       7258 ±282%  interrupts.CPU72.108:PCI-MSI.31981641-edge.i40e-eth0-TxRx-72
      1332 ±169%     -51.3%     648.83 ± 49%     -56.0%     586.00 ± 10%  interrupts.CPU72.CAL:Function_call_interrupts
      0.11 ±282%    +200.0%       0.33 ±141%    -100.0%       0.00        interrupts.CPU72.IWI:IRQ_work_interrupts
    742073 ± 15%      +3.7%     769160 ±  3%      +5.6%     783675        interrupts.CPU72.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU72.MCP:Machine_check_polls
    129.67 ± 38%      +5.8%     137.25 ± 50%     -49.7%      65.22 ± 33%  interrupts.CPU72.NMI:Non-maskable_interrupts
    129.67 ± 38%      +5.8%     137.25 ± 50%     -49.7%      65.22 ± 33%  interrupts.CPU72.PMI:Performance_monitoring_interrupts
     12.00 ± 88%     +63.9%      19.67 ±101%     -30.6%       8.33 ± 80%  interrupts.CPU72.RES:Rescheduling_interrupts
      3.11 ± 80%     -11.6%       2.75 ±111%     +89.3%       5.89 ± 14%  interrupts.CPU72.TLB:TLB_shootdowns
    188.67 ±282%     -61.3%      73.00 ±331%     -70.6%      55.44 ±251%  interrupts.CPU73.109:PCI-MSI.31981642-edge.i40e-eth0-TxRx-73
    582.22 ± 21%      -4.9%     553.67 ±  4%      -6.7%     543.33 ±  6%  interrupts.CPU73.CAL:Function_call_interrupts
      0.11 ±282%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU73.IWI:IRQ_work_interrupts
    742997 ± 15%      +3.5%     769176 ±  4%      +5.5%     783661        interrupts.CPU73.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU73.MCP:Machine_check_polls
    119.89 ± 45%      -2.5%     116.92 ± 45%     -47.3%      63.22 ± 34%  interrupts.CPU73.NMI:Non-maskable_interrupts
    119.89 ± 45%      -2.5%     116.92 ± 45%     -47.3%      63.22 ± 34%  interrupts.CPU73.PMI:Performance_monitoring_interrupts
     11.33 ± 85%     +27.9%      14.50 ± 68%     -42.2%       6.56 ± 44%  interrupts.CPU73.RES:Rescheduling_interrupts
      3.11 ± 73%      +7.1%       3.33 ± 92%     +85.7%       5.78 ± 21%  interrupts.CPU73.TLB:TLB_shootdowns
    103.56 ±282%     -87.9%      12.50 ±248%     -14.4%      88.67 ±279%  interrupts.CPU74.110:PCI-MSI.31981643-edge.i40e-eth0-TxRx-74
    596.89 ± 25%      +4.2%     621.83 ± 29%    +362.2%       2758 ±217%  interrupts.CPU74.CAL:Function_call_interrupts
    742194 ± 15%      +3.6%     769228 ±  4%      +5.6%     783704        interrupts.CPU74.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU74.MCP:Machine_check_polls
    113.11 ± 39%      +6.1%     120.00 ± 44%     -42.4%      65.11 ± 33%  interrupts.CPU74.NMI:Non-maskable_interrupts
    113.11 ± 39%      +6.1%     120.00 ± 44%     -42.4%      65.11 ± 33%  interrupts.CPU74.PMI:Performance_monitoring_interrupts
     33.22 ±128%    +214.0%     104.33 ±280%     -58.2%      13.89 ±127%  interrupts.CPU74.RES:Rescheduling_interrupts
      3.11 ± 63%      -3.6%       3.00 ±104%    +107.1%       6.44 ± 24%  interrupts.CPU74.TLB:TLB_shootdowns
      0.22 ±187%     +12.5%       0.25 ±238%  +58200.0%     129.56 ±242%  interrupts.CPU75.111:PCI-MSI.31981644-edge.i40e-eth0-TxRx-75
    548.67 ±  5%      -0.2%     547.50 ±  2%    +108.5%       1143 ±133%  interrupts.CPU75.CAL:Function_call_interrupts
      0.11 ±282%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU75.IWI:IRQ_work_interrupts
    742124 ± 15%      +3.6%     769144 ±  4%      +5.6%     783651        interrupts.CPU75.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU75.MCP:Machine_check_polls
    119.00 ± 43%     +62.3%     193.08 ±131%     -44.7%      65.78 ± 26%  interrupts.CPU75.NMI:Non-maskable_interrupts
    119.00 ± 43%     +62.3%     193.08 ±131%     -44.7%      65.78 ± 26%  interrupts.CPU75.PMI:Performance_monitoring_interrupts
      8.78 ± 64%     +49.1%      13.08 ± 70%     +26.6%      11.11 ±153%  interrupts.CPU75.RES:Rescheduling_interrupts
      3.78 ± 51%     -20.6%       3.00 ± 95%     +55.9%       5.89 ± 14%  interrupts.CPU75.TLB:TLB_shootdowns
      8.67 ±278%    +873.1%      84.33 ±331%    +957.7%      91.67 ±282%  interrupts.CPU76.112:PCI-MSI.31981645-edge.i40e-eth0-TxRx-76
    519.78 ± 11%     +48.9%     773.92 ± 98%      +5.3%     547.22        interrupts.CPU76.CAL:Function_call_interrupts
      0.11 ±282%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU76.IWI:IRQ_work_interrupts
    742164 ± 15%      +3.6%     769187 ±  4%      +5.6%     783638        interrupts.CPU76.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU76.MCP:Machine_check_polls
    118.56 ± 42%      -3.8%     114.00 ± 42%     -43.8%      66.67 ± 26%  interrupts.CPU76.NMI:Non-maskable_interrupts
    118.56 ± 42%      -3.8%     114.00 ± 42%     -43.8%      66.67 ± 26%  interrupts.CPU76.PMI:Performance_monitoring_interrupts
      6.22 ± 67%    +304.5%      25.17 ±172%     +46.4%       9.11 ± 69%  interrupts.CPU76.RES:Rescheduling_interrupts
      3.22 ± 65%      -1.7%       3.17 ± 91%     +75.9%       5.67 ± 22%  interrupts.CPU76.TLB:TLB_shootdowns
      3.33 ±282%    +950.0%      35.00 ±307%  +4.7e+05%      15833 ±251%  interrupts.CPU77.113:PCI-MSI.31981646-edge.i40e-eth0-TxRx-77
    815.22 ± 50%      +1.8%     829.83 ±115%     +44.3%       1176 ±121%  interrupts.CPU77.CAL:Function_call_interrupts
    742115 ± 15%      +3.6%     769173 ±  4%      +5.6%     783644        interrupts.CPU77.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU77.MCP:Machine_check_polls
    108.67 ± 40%     +11.2%     120.83 ± 45%     -29.9%      76.22 ± 13%  interrupts.CPU77.NMI:Non-maskable_interrupts
    108.67 ± 40%     +11.2%     120.83 ± 45%     -29.9%      76.22 ± 13%  interrupts.CPU77.PMI:Performance_monitoring_interrupts
     31.22 ±138%     -75.7%       7.58 ± 89%     -19.9%      25.00 ±160%  interrupts.CPU77.RES:Rescheduling_interrupts
      3.89 ± 73%      -7.9%       3.58 ±106%     +60.0%       6.22 ± 18%  interrupts.CPU77.TLB:TLB_shootdowns
      0.00       +3.8e+102%       3.75 ±331% +1.4e+102%       1.44 ±282%  interrupts.CPU78.114:PCI-MSI.31981647-edge.i40e-eth0-TxRx-78
    523.00 ± 12%      +3.3%     540.42            +9.4%     572.33 ± 14%  interrupts.CPU78.CAL:Function_call_interrupts
      0.22 ±187%     -62.5%       0.08 ±331%    -100.0%       0.00        interrupts.CPU78.IWI:IRQ_work_interrupts
    742116 ± 15%      +3.7%     769233 ±  3%      +5.6%     783672        interrupts.CPU78.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU78.MCP:Machine_check_polls
    112.89 ± 54%      +7.6%     121.42 ± 43%     -36.5%      71.67 ± 19%  interrupts.CPU78.NMI:Non-maskable_interrupts
    112.89 ± 54%      +7.6%     121.42 ± 43%     -36.5%      71.67 ± 19%  interrupts.CPU78.PMI:Performance_monitoring_interrupts
      7.56 ± 73%      +3.7%       7.83 ± 92%     -16.2%       6.33 ± 55%  interrupts.CPU78.RES:Rescheduling_interrupts
      3.89 ± 72%     -16.4%       3.25 ± 98%     +57.1%       6.11 ± 17%  interrupts.CPU78.TLB:TLB_shootdowns
    573.00 ±161%     -71.8%     161.50 ±303%    -100.0%       0.00        interrupts.CPU79.115:PCI-MSI.31981648-edge.i40e-eth0-TxRx-79
    541.67 ±  2%      -0.2%     540.42           +72.3%     933.44 ±108%  interrupts.CPU79.CAL:Function_call_interrupts
      0.11 ±282%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU79.IWI:IRQ_work_interrupts
    742169 ± 15%      +3.6%     769208 ±  3%      +5.6%     783746        interrupts.CPU79.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU79.MCP:Machine_check_polls
    116.56 ± 41%      +6.2%     123.75 ± 35%     -46.2%      62.67 ± 29%  interrupts.CPU79.NMI:Non-maskable_interrupts
    116.56 ± 41%      +6.2%     123.75 ± 35%     -46.2%      62.67 ± 29%  interrupts.CPU79.PMI:Performance_monitoring_interrupts
      6.78 ± 74%     +15.6%       7.83 ± 41%     +42.6%       9.67 ±106%  interrupts.CPU79.RES:Rescheduling_interrupts
      3.89 ± 47%      -7.9%       3.58 ± 99%     +57.1%       6.11 ± 24%  interrupts.CPU79.TLB:TLB_shootdowns
      0.00       +8.3e+100%       0.08 ±331%    -100.0%       0.00        interrupts.CPU8.127:PCI-MSI.31981660-edge.i40e-eth0-TxRx-91
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU8.315:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      1.89 ±282%     -91.2%       0.17 ±223%   +5517.6%     106.11 ±255%  interrupts.CPU8.44:PCI-MSI.31981577-edge.i40e-eth0-TxRx-8
      0.00       +8.3e+100%       0.08 ±331%    -100.0%       0.00        interrupts.CPU8.79:PCI-MSI.31981612-edge.i40e-eth0-TxRx-43
    624.56 ± 23%    +413.6%       3207 ±238%   +1183.2%       8014 ±254%  interrupts.CPU8.CAL:Function_call_interrupts
    774520 ±  3%      -6.7%     722476 ± 18%      +1.2%     783724        interrupts.CPU8.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU8.MCP:Machine_check_polls
     85.22 ± 22%     +16.0%      98.83 ± 24%      -8.3%      78.11 ±  9%  interrupts.CPU8.NMI:Non-maskable_interrupts
     85.22 ± 22%     +16.0%      98.83 ± 24%      -8.3%      78.11 ±  9%  interrupts.CPU8.PMI:Performance_monitoring_interrupts
     15.89 ± 39%     -39.7%       9.58 ± 90%    +269.9%      58.78 ±209%  interrupts.CPU8.RES:Rescheduling_interrupts
      1.33 ±106%     +50.0%       2.00 ±139%    +225.0%       4.33 ± 21%  interrupts.CPU8.TLB:TLB_shootdowns
     34.89 ±281%      -1.6%      34.33 ±328%    +297.1%     138.56 ±272%  interrupts.CPU80.116:PCI-MSI.31981649-edge.i40e-eth0-TxRx-80
    655.22 ± 51%     -15.2%     555.50 ±  7%     -13.5%     566.89 ± 10%  interrupts.CPU80.CAL:Function_call_interrupts
    742107 ± 15%      +3.6%     769179 ±  3%      +5.6%     783643        interrupts.CPU80.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU80.MCP:Machine_check_polls
    115.44 ± 37%      +2.7%     118.58 ± 38%     -36.0%      73.89 ± 14%  interrupts.CPU80.NMI:Non-maskable_interrupts
    115.44 ± 37%      +2.7%     118.58 ± 38%     -36.0%      73.89 ± 14%  interrupts.CPU80.PMI:Performance_monitoring_interrupts
     12.11 ±115%      +9.4%      13.25 ±140%     -20.2%       9.67 ± 57%  interrupts.CPU80.RES:Rescheduling_interrupts
      4.11 ± 50%     -14.9%       3.50 ± 81%     +43.2%       5.89 ± 29%  interrupts.CPU80.TLB:TLB_shootdowns
      0.22 ±187%   +1212.5%       2.92 ±243%  +53900.0%     120.00 ±262%  interrupts.CPU81.117:PCI-MSI.31981650-edge.i40e-eth0-TxRx-81
    537.22            +1.5%     545.33 ±  3%     +56.3%     839.44 ± 88%  interrupts.CPU81.CAL:Function_call_interrupts
    742230 ± 15%      +3.6%     769205 ±  3%      +5.6%     783634        interrupts.CPU81.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU81.MCP:Machine_check_polls
    114.44 ± 39%    +205.0%     349.00 ±223%     -30.0%      80.11 ± 13%  interrupts.CPU81.NMI:Non-maskable_interrupts
    114.44 ± 39%    +205.0%     349.00 ±223%     -30.0%      80.11 ± 13%  interrupts.CPU81.PMI:Performance_monitoring_interrupts
      8.78 ± 65%     +52.8%      13.42 ±121%     +54.4%      13.56 ± 90%  interrupts.CPU81.RES:Rescheduling_interrupts
      3.67 ± 51%     -13.6%       3.17 ± 99%     +48.5%       5.44 ± 17%  interrupts.CPU81.TLB:TLB_shootdowns
      0.11 ±282%   +2225.0%       2.58 ±320%    +1e+05%     111.22 ±282%  interrupts.CPU82.118:PCI-MSI.31981651-edge.i40e-eth0-TxRx-82
    539.00 ±  2%      -1.4%     531.58 ±  6%    +125.6%       1215 ±154%  interrupts.CPU82.CAL:Function_call_interrupts
      0.00       +8.3e+100%       0.08 ±331%    -100.0%       0.00        interrupts.CPU82.IWI:IRQ_work_interrupts
    742047 ± 15%      +3.7%     769234 ±  3%      +5.6%     783642        interrupts.CPU82.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU82.MCP:Machine_check_polls
    118.78 ± 36%      -5.5%     112.25 ± 47%     -36.2%      75.78 ± 12%  interrupts.CPU82.NMI:Non-maskable_interrupts
    118.78 ± 36%      -5.5%     112.25 ± 47%     -36.2%      75.78 ± 12%  interrupts.CPU82.PMI:Performance_monitoring_interrupts
      8.56 ± 50%     -22.1%       6.67 ± 52%      +0.0%       8.56 ± 78%  interrupts.CPU82.RES:Rescheduling_interrupts
      3.56 ± 59%     -10.9%       3.17 ± 91%     +71.9%       6.11 ± 14%  interrupts.CPU82.TLB:TLB_shootdowns
    144.33 ±201%     -83.1%      24.33 ±324%     -38.0%      89.56 ±202%  interrupts.CPU83.119:PCI-MSI.31981652-edge.i40e-eth0-TxRx-83
    563.44 ± 19%      -4.0%     540.92           +18.6%     668.44 ± 48%  interrupts.CPU83.CAL:Function_call_interrupts
      0.11 ±282%    +275.0%       0.42 ±153%    -100.0%       0.00        interrupts.CPU83.IWI:IRQ_work_interrupts
    742088 ± 15%      +3.7%     769199 ±  4%      +5.6%     783671        interrupts.CPU83.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU83.MCP:Machine_check_polls
    122.67 ± 43%     +13.0%     138.58 ± 48%     -45.0%      67.44 ± 25%  interrupts.CPU83.NMI:Non-maskable_interrupts
    122.67 ± 43%     +13.0%     138.58 ± 48%     -45.0%      67.44 ± 25%  interrupts.CPU83.PMI:Performance_monitoring_interrupts
     10.00 ± 73%     -29.2%       7.08 ± 96%     +36.7%      13.67 ±106%  interrupts.CPU83.RES:Rescheduling_interrupts
      4.11 ± 63%     -18.9%       3.33 ± 97%     +54.1%       6.33 ± 14%  interrupts.CPU83.TLB:TLB_shootdowns
      0.11 ±282%    +200.0%       0.33 ±141%  +31300.0%      34.89 ±186%  interrupts.CPU84.120:PCI-MSI.31981653-edge.i40e-eth0-TxRx-84
    683.22 ± 40%     -20.7%     542.08           -15.0%     580.89 ±  8%  interrupts.CPU84.CAL:Function_call_interrupts
      0.22 ±187%    -100.0%       0.00            +0.0%       0.22 ±282%  interrupts.CPU84.IWI:IRQ_work_interrupts
    742084 ± 15%      +3.7%     769249 ±  4%      +5.6%     783664        interrupts.CPU84.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU84.MCP:Machine_check_polls
    129.67 ± 40%      -3.1%     125.67 ± 35%    +474.2%     744.56 ±256%  interrupts.CPU84.NMI:Non-maskable_interrupts
    129.67 ± 40%      -3.1%     125.67 ± 35%    +474.2%     744.56 ±256%  interrupts.CPU84.PMI:Performance_monitoring_interrupts
     15.00 ±145%     -30.6%      10.42 ± 99%     +88.1%      28.22 ±191%  interrupts.CPU84.RES:Rescheduling_interrupts
      3.89 ± 57%      -5.7%       3.67 ± 77%     +40.0%       5.44 ± 34%  interrupts.CPU84.TLB:TLB_shootdowns
     34.78 ±187%    +455.0%     193.00 ±218%     -99.7%       0.11 ±282%  interrupts.CPU85.121:PCI-MSI.31981654-edge.i40e-eth0-TxRx-85
    534.67 ± 15%     +12.7%     602.33 ± 26%     +26.7%     677.33 ± 45%  interrupts.CPU85.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.1e+101%       0.11 ±282%  interrupts.CPU85.IWI:IRQ_work_interrupts
    742148 ± 15%      +3.6%     769165 ±  4%      +5.6%     783771        interrupts.CPU85.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU85.MCP:Machine_check_polls
    119.00 ± 40%      +0.3%     119.33 ± 42%     -35.9%      76.22 ± 37%  interrupts.CPU85.NMI:Non-maskable_interrupts
    119.00 ± 40%      +0.3%     119.33 ± 42%     -35.9%      76.22 ± 37%  interrupts.CPU85.PMI:Performance_monitoring_interrupts
      6.44 ± 67%    +105.6%      13.25 ±161%     +37.9%       8.89 ± 78%  interrupts.CPU85.RES:Rescheduling_interrupts
      3.78 ± 49%      -0.7%       3.75 ± 77%     +85.3%       7.00 ± 19%  interrupts.CPU85.TLB:TLB_shootdowns
      0.00       +1.8e+104%     176.00 ±244%    -100.0%       0.00        interrupts.CPU86.122:PCI-MSI.31981655-edge.i40e-eth0-TxRx-86
    702.67 ± 48%     +20.9%     849.50 ±119%     +29.4%     909.00 ± 81%  interrupts.CPU86.CAL:Function_call_interrupts
      0.11 ±282%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU86.IWI:IRQ_work_interrupts
    742225 ± 15%      +3.6%     769189 ±  4%      +5.6%     783591        interrupts.CPU86.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU86.MCP:Machine_check_polls
    121.33 ± 41%      -2.7%     118.00 ± 44%     -42.9%      69.22 ± 29%  interrupts.CPU86.NMI:Non-maskable_interrupts
    121.33 ± 41%      -2.7%     118.00 ± 44%     -42.9%      69.22 ± 29%  interrupts.CPU86.PMI:Performance_monitoring_interrupts
     16.56 ±125%     -47.1%       8.75 ± 73%     -46.3%       8.89 ± 62%  interrupts.CPU86.RES:Rescheduling_interrupts
      3.78 ± 49%      -0.7%       3.75 ± 78%     +70.6%       6.44 ± 19%  interrupts.CPU86.TLB:TLB_shootdowns
     38.44 ±282%     -93.5%       2.50 ±331%     -80.6%       7.44 ±278%  interrupts.CPU87.123:PCI-MSI.31981656-edge.i40e-eth0-TxRx-87
    554.44 ±  3%      +0.0%     554.58 ±  3%      -4.2%     530.89 ± 11%  interrupts.CPU87.CAL:Function_call_interrupts
    742363 ± 15%      +3.6%     769240 ±  3%      +5.6%     783735        interrupts.CPU87.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU87.MCP:Machine_check_polls
    119.22 ± 41%      -1.6%     117.33 ± 44%     -39.1%      72.56 ± 21%  interrupts.CPU87.NMI:Non-maskable_interrupts
    119.22 ± 41%      -1.6%     117.33 ± 44%     -39.1%      72.56 ± 21%  interrupts.CPU87.PMI:Performance_monitoring_interrupts
     13.33 ± 68%      -4.4%      12.75 ±105%     -45.0%       7.33 ± 51%  interrupts.CPU87.RES:Rescheduling_interrupts
      3.78 ± 44%      +5.9%       4.00 ± 70%     +79.4%       6.78 ± 25%  interrupts.CPU87.TLB:TLB_shootdowns
    564.11 ±282%     -80.7%     108.83 ±299%     -90.7%      52.44 ±282%  interrupts.CPU88.124:PCI-MSI.31981657-edge.i40e-eth0-TxRx-88
    911.56 ±114%      +0.0%     912.00 ±102%     -23.9%     693.67 ± 51%  interrupts.CPU88.CAL:Function_call_interrupts
      0.00       +8.3e+100%       0.08 ±331%    -100.0%       0.00        interrupts.CPU88.IWI:IRQ_work_interrupts
    742075 ± 15%      +3.7%     769202 ±  3%      +5.6%     783720        interrupts.CPU88.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU88.MCP:Machine_check_polls
    117.11 ± 39%      +4.7%     122.58 ± 40%     -42.2%      67.67 ± 30%  interrupts.CPU88.NMI:Non-maskable_interrupts
    117.11 ± 39%      +4.7%     122.58 ± 40%     -42.2%      67.67 ± 30%  interrupts.CPU88.PMI:Performance_monitoring_interrupts
      7.89 ± 71%     +82.7%      14.42 ± 76%     -16.9%       6.56 ± 62%  interrupts.CPU88.RES:Rescheduling_interrupts
      4.00 ± 47%      -8.3%       3.67 ± 72%     +58.3%       6.33 ± 27%  interrupts.CPU88.TLB:TLB_shootdowns
     11.44 ±240%    +333.3%      49.58 ±331%     -97.1%       0.33 ±200%  interrupts.CPU89.125:PCI-MSI.31981658-edge.i40e-eth0-TxRx-89
    541.78 ±  2%      +2.0%     552.75 ±  3%      +1.0%     547.00        interrupts.CPU89.CAL:Function_call_interrupts
      0.11 ±282%     -25.0%       0.08 ±331%      +0.0%       0.11 ±282%  interrupts.CPU89.IWI:IRQ_work_interrupts
    742048 ± 15%      +3.7%     769141 ±  3%      +5.6%     783643        interrupts.CPU89.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU89.MCP:Machine_check_polls
    125.11 ± 42%      -2.0%     122.67 ± 47%     -40.3%      74.67 ± 38%  interrupts.CPU89.NMI:Non-maskable_interrupts
    125.11 ± 42%      -2.0%     122.67 ± 47%     -40.3%      74.67 ± 38%  interrupts.CPU89.PMI:Performance_monitoring_interrupts
     18.67 ±159%     -42.4%      10.75 ± 84%     -73.2%       5.00 ± 73%  interrupts.CPU89.RES:Rescheduling_interrupts
      3.56 ± 40%     +19.5%       4.25 ± 63%    +100.0%       7.11 ± 12%  interrupts.CPU89.TLB:TLB_shootdowns
      0.11 ±282%     +50.0%       0.17 ±223%    +100.0%       0.22 ±187%  interrupts.CPU9.128:PCI-MSI.31981661-edge.i40e-eth0-TxRx-92
    143.33 ±233%    +418.4%     743.08 ±221%    -100.0%       0.00        interrupts.CPU9.45:PCI-MSI.31981578-edge.i40e-eth0-TxRx-9
      0.22 ±187%     +50.0%       0.33 ±141%      +0.0%       0.22 ±187%  interrupts.CPU9.80:PCI-MSI.31981613-edge.i40e-eth0-TxRx-44
    729.78 ± 67%     +43.1%       1044 ±113%     +42.2%       1037 ±131%  interrupts.CPU9.CAL:Function_call_interrupts
    774586 ±  3%      -6.7%     722508 ± 18%      +1.2%     783681        interrupts.CPU9.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU9.MCP:Machine_check_polls
    104.00 ± 18%     -13.0%      90.50 ± 30%    +323.3%     440.22 ±231%  interrupts.CPU9.NMI:Non-maskable_interrupts
    104.00 ± 18%     -13.0%      90.50 ± 30%    +323.3%     440.22 ±231%  interrupts.CPU9.PMI:Performance_monitoring_interrupts
     12.44 ± 64%   +1876.8%     246.00 ±306%     +27.7%      15.89 ± 75%  interrupts.CPU9.RES:Rescheduling_interrupts
      1.56 ±109%     +23.2%       1.92 ±138%    +185.7%       4.44 ± 28%  interrupts.CPU9.TLB:TLB_shootdowns
    538.67 ±282%   +1919.4%      10877 ±331%    -100.0%       0.00        interrupts.CPU90.126:PCI-MSI.31981659-edge.i40e-eth0-TxRx-90
    542.56            +1.3%     549.50 ±  3%      +8.0%     585.89 ± 18%  interrupts.CPU90.CAL:Function_call_interrupts
      0.11 ±282%     -25.0%       0.08 ±331%    -100.0%       0.00        interrupts.CPU90.IWI:IRQ_work_interrupts
    742180 ± 15%      +3.6%     769219 ±  4%      +5.6%     783638        interrupts.CPU90.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU90.MCP:Machine_check_polls
    126.44 ± 39%      +0.2%     126.67 ± 39%     -47.6%      66.22 ± 27%  interrupts.CPU90.NMI:Non-maskable_interrupts
    126.44 ± 39%      +0.2%     126.67 ± 39%     -47.6%      66.22 ± 27%  interrupts.CPU90.PMI:Performance_monitoring_interrupts
     10.89 ± 93%     +24.7%      13.58 ±119%      -2.0%      10.67 ± 78%  interrupts.CPU90.RES:Rescheduling_interrupts
      4.22 ± 33%      -3.3%       4.08 ± 66%     +50.0%       6.33 ± 28%  interrupts.CPU90.TLB:TLB_shootdowns
     13770 ±282%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU91.127:PCI-MSI.31981660-edge.i40e-eth0-TxRx-91
    907.89 ±114%     -36.3%     578.58 ± 14%     -32.9%     609.33 ± 25%  interrupts.CPU91.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.1e+101%       0.11 ±282%  interrupts.CPU91.IWI:IRQ_work_interrupts
    742276 ± 15%      +3.6%     769195 ±  4%      +5.6%     783673        interrupts.CPU91.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU91.MCP:Machine_check_polls
    113.56 ± 40%      +5.2%     119.42 ± 41%     -31.3%      78.00 ± 29%  interrupts.CPU91.NMI:Non-maskable_interrupts
    113.56 ± 40%      +5.2%     119.42 ± 41%     -31.3%      78.00 ± 29%  interrupts.CPU91.PMI:Performance_monitoring_interrupts
     17.11 ±108%     -56.7%       7.42 ± 62%     -50.6%       8.44 ± 75%  interrupts.CPU91.RES:Rescheduling_interrupts
      4.11 ± 31%      +9.5%       4.50 ± 65%     +64.9%       6.78 ± 11%  interrupts.CPU91.TLB:TLB_shootdowns
      0.78 ±240%     -78.6%       0.17 ±223%   +5014.3%      39.78 ±280%  interrupts.CPU92.128:PCI-MSI.31981661-edge.i40e-eth0-TxRx-92
    558.33 ±  6%     +11.8%     624.33 ± 42%     +26.0%     703.22 ± 60%  interrupts.CPU92.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +2.2e+101%       0.22 ±282%  interrupts.CPU92.IWI:IRQ_work_interrupts
    742166 ± 15%      +3.6%     769146 ±  4%      +5.6%     783625        interrupts.CPU92.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU92.MCP:Machine_check_polls
    117.78 ± 38%      -1.2%     116.33 ± 45%    +534.5%     747.33 ±255%  interrupts.CPU92.NMI:Non-maskable_interrupts
    117.78 ± 38%      -1.2%     116.33 ± 45%    +534.5%     747.33 ±255%  interrupts.CPU92.PMI:Performance_monitoring_interrupts
      8.44 ± 83%     -23.0%       6.50 ± 61%     +39.5%      11.78 ± 98%  interrupts.CPU92.RES:Rescheduling_interrupts
      4.89 ± 28%      -8.0%       4.50 ± 51%     +29.5%       6.33 ± 36%  interrupts.CPU92.TLB:TLB_shootdowns
      2715 ±206%     -83.3%     454.00 ±327%    -100.0%       0.00        interrupts.CPU93.129:PCI-MSI.31981662-edge.i40e-eth0-TxRx-93
    725.00 ± 64%     -25.5%     540.00 ± 13%     -24.3%     549.11        interrupts.CPU93.CAL:Function_call_interrupts
    742161 ± 15%      +3.6%     769136 ±  4%      +5.6%     783658        interrupts.CPU93.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU93.MCP:Machine_check_polls
    117.44 ± 40%      -2.9%     114.00 ± 44%     -39.5%      71.11 ± 22%  interrupts.CPU93.NMI:Non-maskable_interrupts
    117.44 ± 40%      -2.9%     114.00 ± 44%     -39.5%      71.11 ± 22%  interrupts.CPU93.PMI:Performance_monitoring_interrupts
     15.56 ±112%     -45.9%       8.42 ± 69%     -62.1%       5.89 ± 85%  interrupts.CPU93.RES:Rescheduling_interrupts
      4.67 ± 24%     +10.7%       5.17 ± 45%     +69.0%       7.89 ± 17%  interrupts.CPU93.TLB:TLB_shootdowns
    595.11 ± 12%      +3.5%     616.17 ± 39%      -7.0%     553.33        interrupts.CPU94.CAL:Function_call_interrupts
    742121 ± 15%      +3.6%     769155 ±  3%      +5.6%     783729        interrupts.CPU94.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU94.MCP:Machine_check_polls
    117.00 ± 39%      -0.2%     116.75 ± 44%     -39.0%      71.33 ± 23%  interrupts.CPU94.NMI:Non-maskable_interrupts
    117.00 ± 39%      -0.2%     116.75 ± 44%     -39.0%      71.33 ± 23%  interrupts.CPU94.PMI:Performance_monitoring_interrupts
      8.78 ± 35%     +26.3%      11.08 ±101%     -68.4%       2.78 ± 62%  interrupts.CPU94.RES:Rescheduling_interrupts
      4.78 ± 19%      +9.9%       5.25 ± 40%     +58.1%       7.56 ± 11%  interrupts.CPU94.TLB:TLB_shootdowns
    519.33 ±  5%      +9.3%     567.42 ± 16%      +1.0%     524.56 ± 13%  interrupts.CPU95.CAL:Function_call_interrupts
      0.22 ±187%     -25.0%       0.17 ±223%    -100.0%       0.00        interrupts.CPU95.IWI:IRQ_work_interrupts
    742181 ± 15%      +3.6%     769213 ±  3%      +5.6%     783671        interrupts.CPU95.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU95.MCP:Machine_check_polls
    133.33 ± 43%      -6.1%     125.25 ± 52%     -45.4%      72.78 ± 31%  interrupts.CPU95.NMI:Non-maskable_interrupts
    133.33 ± 43%      -6.1%     125.25 ± 52%     -45.4%      72.78 ± 31%  interrupts.CPU95.PMI:Performance_monitoring_interrupts
     12.33 ± 80%     -16.9%      10.25 ± 64%     -20.7%       9.78 ±106%  interrupts.CPU95.RES:Rescheduling_interrupts
      0.11 ±282%    +275.0%       0.42 ±153%    +200.0%       0.33 ±200%  interrupts.CPU95.TLB:TLB_shootdowns
      4.56 ± 61%     +15.2%       5.25 ± 47%     -48.8%       2.33 ± 28%  interrupts.IWI:IRQ_work_interrupts
  72801215 ±  9%      -1.6%   71607644 ± 11%      +3.3%   75232525        interrupts.LOC:Local_timer_interrupts
     96.00            +0.0%      96.00            +0.0%      96.00        interrupts.MCP:Machine_check_polls
     17999 ± 16%      +1.6%      18282 ± 19%     -18.4%      14696 ± 10%  interrupts.NMI:Non-maskable_interrupts
     17999 ± 16%      +1.6%      18282 ± 19%     -18.4%      14696 ± 10%  interrupts.PMI:Performance_monitoring_interrupts
      2608 ± 45%     +22.0%       3182 ± 82%     -33.7%       1730 ± 13%  interrupts.RES:Rescheduling_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.RTR:APIC_ICR_read_retries
    243.78 ± 68%      +7.8%     262.75 ±106%    +111.3%     515.22 ± 14%  interrupts.TLB:TLB_shootdowns

> 
> Thanks,
> Amir.
