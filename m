Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674BD21D233
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 10:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgGMItm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 04:49:42 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7844 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725830AbgGMItl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 04:49:41 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0755AD09E27BF9228CF5;
        Mon, 13 Jul 2020 16:49:35 +0800 (CST)
Received: from [127.0.0.1] (10.67.76.251) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Mon, 13 Jul 2020
 16:49:27 +0800
Subject: Re: [fs] 936e92b615: unixbench.score 32.3% improvement
To:     kernel test robot <rong.a.chen@intel.com>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Will Deacon" <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Boqun Feng <boqun.feng@gmail.com>,
        Yuqi Jin <jinyuqi@huawei.com>, <lkp@lists.01.org>
References: <20200708072346.GL3874@shao2-debian>
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
Message-ID: <2b5fc62e-0248-e8f5-2aac-7355a2933dcd@hisilicon.com>
Date:   Mon, 13 Jul 2020 16:49:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200708072346.GL3874@shao2-debian>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.76.251]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi maintainers,

This issue is debugged on Huawei Kunpeng 920 which is an ARM64 platform and we also do more tests
on x86 platform.
Since Rong has also reported the improvement on x86，it seems necessary for us to do it.
Any comments on it?

Thanks,
Shaokun

在 2020/7/8 15:23, kernel test robot 写道:
> Greeting,
> 
> FYI, we noticed a 32.3% improvement of unixbench.score due to commit:
> 
> 
> commit: 936e92b615e212d08eb74951324bef25ba564c34 ("[PATCH RESEND] fs: Move @f_count to different cacheline with @f_mode")
> url: https://github.com/0day-ci/linux/commits/Shaokun-Zhang/fs-Move-f_count-to-different-cacheline-with-f_mode/20200624-163511
> base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 5e857ce6eae7ca21b2055cca4885545e29228fe2
> 
> in testcase: unixbench
> on test machine: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
> with following parameters:
> 
> 	runtime: 300s
> 	nr_task: 30%
> 	test: syscall
> 	cpufreq_governor: performance
> 	ucode: 0x5002f01
> 
> test-description: UnixBench is the original BYTE UNIX benchmark suite aims to test performance of Unix-like system.
> test-url: https://github.com/kdlucas/byte-unixbench
> 
> 
> 
> 
> 
> Details are as below:
> -------------------------------------------------------------------------------------------------->
> 
> 
> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install job.yaml  # job file is attached in this email
>         bin/lkp run     job.yaml
> 
> =========================================================================================
> compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase/ucode:
>   gcc-9/performance/x86_64-rhel-7.6/30%/debian-x86_64-20191114.cgz/300s/lkp-csl-2ap3/syscall/unixbench/0x5002f01
> 
> commit: 
>   5e857ce6ea ("Merge branch 'hch' (maccess patches from Christoph Hellwig)")
>   936e92b615 ("fs: Move @f_count to different cacheline with @f_mode")
> 
> 5e857ce6eae7ca21 936e92b615e212d08eb74951324 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>       2297 ±  2%     +32.3%       3038        unixbench.score
>     171.74           +34.8%     231.55        unixbench.time.user_time
>  1.366e+09           +32.6%  1.812e+09        unixbench.workload
>      26472 ±  6%   +1270.0%     362665 ±158%  cpuidle.C1.usage
>       0.25 ±  2%      +0.1        0.33        mpstat.cpu.all.usr%
>       8.32 ± 43%    +129.7%      19.12 ± 63%  sched_debug.cpu.clock.stddev
>       8.32 ± 43%    +129.7%      19.12 ± 63%  sched_debug.cpu.clock_task.stddev
>       2100 ±  2%     -15.6%       1772 ±  9%  sched_debug.cpu.nr_switches.min
>     373.34 ±  3%     +12.4%     419.48 ±  6%  sched_debug.cpu.ttwu_local.stddev
>       2740 ± 12%     -72.3%     757.75 ±105%  numa-vmstat.node0.nr_inactive_anon
>       3139 ±  8%     -69.9%     946.25 ± 97%  numa-vmstat.node0.nr_shmem
>       2740 ± 12%     -72.3%     757.75 ±105%  numa-vmstat.node0.nr_zone_inactive_anon
>     373.75 ± 51%    +443.3%       2030 ± 26%  numa-vmstat.node2.nr_inactive_anon
>     496.00 ± 19%    +366.1%       2311 ± 29%  numa-vmstat.node2.nr_shmem
>     373.75 ± 51%    +443.3%       2030 ± 26%  numa-vmstat.node2.nr_zone_inactive_anon
>      13728 ± 13%    +148.1%      34056 ± 46%  numa-vmstat.node3.nr_active_anon
>      78558           +11.3%      87431 ±  6%  numa-vmstat.node3.nr_file_pages
>       9939 ±  8%     +19.7%      11902 ± 13%  numa-vmstat.node3.nr_shmem
>      13728 ± 13%    +148.1%      34056 ± 46%  numa-vmstat.node3.nr_zone_active_anon
>      11103 ± 13%     -71.2%       3201 ± 99%  numa-meminfo.node0.Inactive
>      10962 ± 12%     -72.3%       3032 ±105%  numa-meminfo.node0.Inactive(anon)
>       8551 ± 31%     -29.4%       6034 ± 18%  numa-meminfo.node0.Mapped
>      12560 ±  8%     -69.9%       3786 ± 97%  numa-meminfo.node0.Shmem
>       1596 ± 51%    +415.6%       8230 ± 24%  numa-meminfo.node2.Inactive
>       1496 ± 51%    +442.8%       8122 ± 26%  numa-meminfo.node2.Inactive(anon)
>       1984 ± 19%    +366.1%       9248 ± 29%  numa-meminfo.node2.Shmem
>      54929 ± 13%    +148.0%     136212 ± 46%  numa-meminfo.node3.Active
>      54929 ± 13%    +148.0%     136206 ± 46%  numa-meminfo.node3.Active(anon)
>     314216           +11.3%     349697 ±  6%  numa-meminfo.node3.FilePages
>     747907 ±  2%     +15.2%     861672 ±  9%  numa-meminfo.node3.MemUsed
>      39744 ±  8%     +19.7%      47580 ± 13%  numa-meminfo.node3.Shmem
>      13.94 ±  6%     -13.9        0.00        perf-profile.calltrace.cycles-pp.dnotify_flush.filp_close.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.00            +0.7        0.66 ±  8%  perf-profile.calltrace.cycles-pp.__x64_sys_umask.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      31.64 ±  8%      +3.4       35.08 ±  5%  perf-profile.calltrace.cycles-pp.__fget_files.ksys_dup.__x64_sys_dup.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       6.82 ±  8%      +5.6       12.41 ± 12%  perf-profile.calltrace.cycles-pp.fput_many.filp_close.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      23.54 ± 58%     +12.7       36.27 ±  5%  perf-profile.calltrace.cycles-pp.ksys_dup.__x64_sys_dup.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      23.54 ± 58%     +12.7       36.29 ±  5%  perf-profile.calltrace.cycles-pp.__x64_sys_dup.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      13.98 ±  6%     -14.0        0.00        perf-profile.children.cycles-pp.dnotify_flush
>      39.81 ±  6%     -10.8       28.96 ±  9%  perf-profile.children.cycles-pp.filp_close
>      40.13 ±  6%     -10.7       29.44 ±  9%  perf-profile.children.cycles-pp.__x64_sys_close
>       0.15 ± 10%      -0.0        0.13 ±  8%  perf-profile.children.cycles-pp.scheduler_tick
>       0.05 ±  8%      +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.__x64_sys_getuid
>       0.10 ±  7%      +0.0        0.12 ±  8%  perf-profile.children.cycles-pp.__prepare_exit_to_usermode
>       0.44 ±  7%      +0.1        0.56 ±  6%  perf-profile.children.cycles-pp.syscall_return_via_sysret
>      31.78 ±  8%      +3.4       35.22 ±  5%  perf-profile.children.cycles-pp.__fget_files
>      32.52 ±  8%      +3.7       36.27 ±  5%  perf-profile.children.cycles-pp.ksys_dup
>      32.54 ±  8%      +3.8       36.30 ±  5%  perf-profile.children.cycles-pp.__x64_sys_dup
>       6.86 ±  7%      +5.6       12.45 ± 12%  perf-profile.children.cycles-pp.fput_many
>      13.91 ±  6%     -13.9        0.00        perf-profile.self.cycles-pp.dnotify_flush
>      18.05 ±  5%      -1.6       16.41 ±  7%  perf-profile.self.cycles-pp.filp_close
>       0.06 ±  6%      +0.0        0.08 ±  8%  perf-profile.self.cycles-pp.__prepare_exit_to_usermode
>       0.09 ±  9%      +0.0        0.11 ±  7%  perf-profile.self.cycles-pp.do_syscall_64
>       0.16 ±  9%      +0.0        0.20 ±  4%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
>       0.30 ±  8%      +0.1        0.36 ±  7%  perf-profile.self.cycles-pp.entry_SYSCALL_64
>       0.44 ±  7%      +0.1        0.56 ±  6%  perf-profile.self.cycles-pp.syscall_return_via_sysret
>      31.61 ±  8%      +3.4       35.00 ±  5%  perf-profile.self.cycles-pp.__fget_files
>       6.81 ±  7%      +5.6       12.38 ± 12%  perf-profile.self.cycles-pp.fput_many
>      36623 ±  3%     +11.5%      40822 ±  7%  softirqs.CPU100.SCHED
>      16499 ± 40%     +27.8%      21088 ± 35%  softirqs.CPU122.RCU
>      16758 ± 41%     +30.0%      21781 ± 35%  softirqs.CPU126.RCU
>     178.25 ± 11%   +7718.2%      13936 ±168%  softirqs.CPU13.NET_RX
>      40883 ±  4%      -6.9%      38055 ±  2%  softirqs.CPU132.SCHED
>      16029 ± 41%     +35.9%      21789 ± 33%  softirqs.CPU144.RCU
>      16220 ± 43%     +32.4%      21484 ± 35%  softirqs.CPU145.RCU
>      16393 ± 39%     +29.9%      21301 ± 32%  softirqs.CPU146.RCU
>      16217 ± 39%     +29.8%      21055 ± 35%  softirqs.CPU147.RCU
>      37011 ± 12%     +12.4%      41589 ±  5%  softirqs.CPU149.SCHED
>      16127 ± 41%     +34.5%      21685 ± 34%  softirqs.CPU150.RCU
>      16131 ± 41%     +32.3%      21333 ± 35%  softirqs.CPU151.RCU
>      16558 ± 37%     +28.2%      21230 ± 34%  softirqs.CPU152.RCU
>      15863 ± 40%     +34.1%      21266 ± 32%  softirqs.CPU153.RCU
>      16044 ± 41%     +32.7%      21286 ± 34%  softirqs.CPU154.RCU
>      16057 ± 40%     +34.9%      21658 ± 33%  softirqs.CPU155.RCU
>      16352 ± 39%     +31.0%      21423 ± 33%  softirqs.CPU156.RCU
>      16006 ± 39%     +33.4%      21348 ± 32%  softirqs.CPU158.RCU
>      16300 ± 41%     +32.0%      21521 ± 34%  softirqs.CPU161.RCU
>      37546 ±  4%     +13.5%      42605 ±  3%  softirqs.CPU161.SCHED
>      16411 ± 41%     +33.4%      21894 ± 33%  softirqs.CPU162.RCU
>      16329 ± 41%     +32.9%      21704 ± 35%  softirqs.CPU163.RCU
>      16517 ± 39%     +29.8%      21441 ± 34%  softirqs.CPU164.RCU
>      16227 ± 41%     +32.3%      21471 ± 34%  softirqs.CPU165.RCU
>      16347 ± 40%     +31.4%      21481 ± 35%  softirqs.CPU166.RCU
>      16360 ± 43%     +32.2%      21631 ± 35%  softirqs.CPU167.RCU
>      36986           +11.3%      41148 ±  6%  softirqs.CPU167.SCHED
>      16218 ± 44%     +34.7%      21843 ± 33%  softirqs.CPU189.RCU
>      16501 ± 39%     +32.0%      21783 ± 33%  softirqs.CPU52.RCU
>      17101 ± 41%     +29.4%      22121 ± 35%  softirqs.CPU68.RCU
>  1.087e+09           +20.9%  1.314e+09        perf-stat.i.branch-instructions
>   19778787           +22.1%   24144895 ± 16%  perf-stat.i.branch-misses
>      22.88           -17.7%      18.84 ±  2%  perf-stat.i.cpi
>  1.635e+09           +23.6%  2.021e+09        perf-stat.i.dTLB-loads
>      20648 ±  2%    +218.4%      65736 ±110%  perf-stat.i.dTLB-store-misses
>  1.023e+09           +24.8%  1.276e+09        perf-stat.i.dTLB-stores
>      78.10            +1.4       79.54        perf-stat.i.iTLB-load-miss-rate%
>   16169669            +8.2%   17493234        perf-stat.i.iTLB-load-misses
>  5.364e+09           +21.3%  6.507e+09        perf-stat.i.instructions
>     369.33           +11.8%     413.03 ±  5%  perf-stat.i.instructions-per-iTLB-miss
>       0.41 ±  2%     +83.3%       0.76 ± 16%  perf-stat.i.metric.K/sec
>      19.79           +23.2%      24.39        perf-stat.i.metric.M/sec
>    4460149 ±  2%     -45.1%    2447884 ± 14%  perf-stat.i.node-load-misses
>     241219 ±  2%     -58.8%      99443 ± 47%  perf-stat.i.node-loads
>    1679821 ±  2%      -4.4%    1605611 ±  3%  perf-stat.i.node-store-misses
>      25.91           -17.6%      21.36        perf-stat.overall.cpi
>      82.51            +1.7       84.17        perf-stat.overall.iTLB-load-miss-rate%
>     331.21           +12.2%     371.62        perf-stat.overall.instructions-per-iTLB-miss
>       0.04           +21.3%       0.05        perf-stat.overall.ipc
>       1566            -8.4%       1435        perf-stat.overall.path-length
>  1.089e+09           +21.0%  1.318e+09        perf-stat.ps.branch-instructions
>   19801099           +21.7%   24102537 ± 15%  perf-stat.ps.branch-misses
>  1.641e+09           +23.6%  2.028e+09        perf-stat.ps.dTLB-loads
>      20512 ±  2%    +212.7%      64142 ±109%  perf-stat.ps.dTLB-store-misses
>  1.027e+09           +24.8%  1.282e+09        perf-stat.ps.dTLB-stores
>   16239916            +8.2%   17567773        perf-stat.ps.iTLB-load-misses
>  5.378e+09           +21.4%  6.527e+09        perf-stat.ps.instructions
>    4485062 ±  2%     -45.2%    2458026 ± 14%  perf-stat.ps.node-load-misses
>     242388 ±  2%     -59.0%      99493 ± 47%  perf-stat.ps.node-loads
>    1689890 ±  2%      -4.5%    1614182 ±  3%  perf-stat.ps.node-store-misses
>  2.139e+12           +21.5%    2.6e+12        perf-stat.total.instructions
>     288.00 ± 13%   +8910.9%      25951 ±168%  interrupts.34:PCI-MSI.524292-edge.eth0-TxRx-3
>       2042 ± 57%    +190.2%       5927 ± 26%  interrupts.CPU1.NMI:Non-maskable_interrupts
>       2042 ± 57%    +190.2%       5927 ± 26%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
>       3.75 ± 34%   +2373.3%      92.75 ±130%  interrupts.CPU100.TLB:TLB_shootdowns
>       3510 ± 88%     -85.1%     522.00 ±124%  interrupts.CPU107.NMI:Non-maskable_interrupts
>       3510 ± 88%     -85.1%     522.00 ±124%  interrupts.CPU107.PMI:Performance_monitoring_interrupts
>       3813 ± 74%     -73.3%       1018 ±150%  interrupts.CPU110.NMI:Non-maskable_interrupts
>       3813 ± 74%     -73.3%       1018 ±150%  interrupts.CPU110.PMI:Performance_monitoring_interrupts
>       4536 ± 51%     -97.1%     131.50 ±  8%  interrupts.CPU111.NMI:Non-maskable_interrupts
>       4536 ± 51%     -97.1%     131.50 ±  8%  interrupts.CPU111.PMI:Performance_monitoring_interrupts
>       4476 ± 47%     -97.5%     113.00 ± 19%  interrupts.CPU112.NMI:Non-maskable_interrupts
>       4476 ± 47%     -97.5%     113.00 ± 19%  interrupts.CPU112.PMI:Performance_monitoring_interrupts
>       3522 ± 36%     +92.7%       6787 ± 16%  interrupts.CPU120.NMI:Non-maskable_interrupts
>       3522 ± 36%     +92.7%       6787 ± 16%  interrupts.CPU120.PMI:Performance_monitoring_interrupts
>       2888 ± 66%    +117.5%       6283 ± 21%  interrupts.CPU123.NMI:Non-maskable_interrupts
>       2888 ± 66%    +117.5%       6283 ± 21%  interrupts.CPU123.PMI:Performance_monitoring_interrupts
>       3109 ± 61%    +132.5%       7230 ±  7%  interrupts.CPU124.NMI:Non-maskable_interrupts
>       3109 ± 61%    +132.5%       7230 ±  7%  interrupts.CPU124.PMI:Performance_monitoring_interrupts
>       1067 ± 19%     -21.6%     836.50        interrupts.CPU125.CAL:Function_call_interrupts
>     288.00 ± 13%   +8910.9%      25951 ±168%  interrupts.CPU13.34:PCI-MSI.524292-edge.eth0-TxRx-3
>     244.25 ± 96%     -95.3%      11.50 ± 95%  interrupts.CPU13.TLB:TLB_shootdowns
>       2056 ±117%    +206.3%       6298 ± 20%  interrupts.CPU130.NMI:Non-maskable_interrupts
>       2056 ±117%    +206.3%       6298 ± 20%  interrupts.CPU130.PMI:Performance_monitoring_interrupts
>     831.50           +21.4%       1009 ± 13%  interrupts.CPU133.CAL:Function_call_interrupts
>       8.00 ± 29%    +634.4%      58.75 ±119%  interrupts.CPU133.RES:Rescheduling_interrupts
>       1629 ±159%    +265.3%       5952 ± 29%  interrupts.CPU139.NMI:Non-maskable_interrupts
>       1629 ±159%    +265.3%       5952 ± 29%  interrupts.CPU139.PMI:Performance_monitoring_interrupts
>       1660 ±159%    +161.0%       4332 ± 61%  interrupts.CPU141.NMI:Non-maskable_interrupts
>       1660 ±159%    +161.0%       4332 ± 61%  interrupts.CPU141.PMI:Performance_monitoring_interrupts
>     882.75 ±147%    +542.5%       5671 ± 38%  interrupts.CPU143.NMI:Non-maskable_interrupts
>     882.75 ±147%    +542.5%       5671 ± 38%  interrupts.CPU143.PMI:Performance_monitoring_interrupts
>       2600 ± 29%     +68.8%       4389 ± 47%  interrupts.CPU144.NMI:Non-maskable_interrupts
>       2600 ± 29%     +68.8%       4389 ± 47%  interrupts.CPU144.PMI:Performance_monitoring_interrupts
>       1494 ± 20%     +91.3%       2859 ± 29%  interrupts.CPU147.NMI:Non-maskable_interrupts
>       1494 ± 20%     +91.3%       2859 ± 29%  interrupts.CPU147.PMI:Performance_monitoring_interrupts
>       3657 ± 54%     -96.3%     133.75 ±  8%  interrupts.CPU15.NMI:Non-maskable_interrupts
>       3657 ± 54%     -96.3%     133.75 ±  8%  interrupts.CPU15.PMI:Performance_monitoring_interrupts
>       5165 ± 40%     -97.8%     115.00 ± 26%  interrupts.CPU16.NMI:Non-maskable_interrupts
>       5165 ± 40%     -97.8%     115.00 ± 26%  interrupts.CPU16.PMI:Performance_monitoring_interrupts
>      34.00 ±125%     -84.6%       5.25 ± 49%  interrupts.CPU186.RES:Rescheduling_interrupts
>       1033 ± 24%     -19.0%     836.75        interrupts.CPU190.CAL:Function_call_interrupts
>      68.00 ± 28%     +55.5%     105.75 ±  9%  interrupts.CPU26.RES:Rescheduling_interrupts
>     882.25 ±  4%      +6.3%     937.75 ±  7%  interrupts.CPU32.CAL:Function_call_interrupts
>     139.25 ± 96%     -74.0%      36.25 ± 72%  interrupts.CPU32.TLB:TLB_shootdowns
>     848.25 ±130%    +368.9%       3977 ± 56%  interrupts.CPU35.NMI:Non-maskable_interrupts
>     848.25 ±130%    +368.9%       3977 ± 56%  interrupts.CPU35.PMI:Performance_monitoring_interrupts
>     958.25 ± 11%     -10.6%     856.75        interrupts.CPU36.CAL:Function_call_interrupts
>       1903 ± 72%    +127.9%       4337 ± 23%  interrupts.CPU41.NMI:Non-maskable_interrupts
>       1903 ± 72%    +127.9%       4337 ± 23%  interrupts.CPU41.PMI:Performance_monitoring_interrupts
>       1320 ±158%    +245.4%       4560 ± 32%  interrupts.CPU47.NMI:Non-maskable_interrupts
>       1320 ±158%    +245.4%       4560 ± 32%  interrupts.CPU47.PMI:Performance_monitoring_interrupts
>     837.50            +5.2%     881.25 ±  4%  interrupts.CPU61.CAL:Function_call_interrupts
>       1074 ± 28%     -22.1%     836.50        interrupts.CPU69.CAL:Function_call_interrupts
>       1042 ± 12%     -18.7%     847.50 ±  2%  interrupts.CPU86.CAL:Function_call_interrupts
> 
> 
>                                                                                 
>                                   unixbench.score                               
>                                                                                 
>   3200 +--------------------------------------------------------------------+   
>        |                 O             O        O                           |   
>   3000 |-+    O O           O   O  O O    O O O                             |   
>        | O  O      O   O                                                    |   
>        |                      O                                             |   
>   2800 |-+                                                                  |   
>        |                                                                    |   
>   2600 |-+                                                                  |   
>        |                                                                    |   
>   2400 |-+                                                                  |   
>        |      +.+..   .+.+..+.         +..+. .+.  .+. .+..+.+.+..+.+.+.  .+.|   
>        |.+.. +      .+        +.+..+. +     +   +.   +                 +.   |   
>   2200 |-+  +      +                 +                                      |   
>        |                                                                    |   
>   2000 +--------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                                   unixbench.workload                            
>                                                                                 
>   1.9e+09 +-----------------------------------------------------------------+   
>           |                 O O          O        O                         |   
>   1.8e+09 |-+    O O              O O  O   O O O                            |   
>           | O O      O   O      O                                           |   
>   1.7e+09 |-+                                                               |   
>           |                                                                 |   
>   1.6e+09 |-+                                                               |   
>           |                                                                 |   
>   1.5e+09 |-+                                                               |   
>           |                                                                 |   
>   1.4e+09 |-+    +.+    .+..+.+          +.+. .+.. .+.   .+..+. .+. .+..   .|   
>           |.+. ..   :  +       + .+.+.. +    +    +   +.+      +   +    +.+ |   
>   1.3e+09 |-+ +     : +         +      +                                    |   
>           |          +                                                      |   
>   1.2e+09 +-----------------------------------------------------------------+   
>                                                                                 
>                                                                                 
> [*] bisect-good sample
> [O] bisect-bad  sample
> 
> 
> 
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are provided
> for informational purposes only. Any difference in system hardware or software
> design or configuration may affect actual performance.
> 
> 
> Thanks,
> Rong Chen
> 

