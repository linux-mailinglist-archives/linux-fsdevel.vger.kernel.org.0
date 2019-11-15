Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C46B4FD3D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 05:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfKOE4p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 23:56:45 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:54470 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726549AbfKOE4p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 23:56:45 -0500
Received: from dread.disaster.area (pa49-181-255-80.pa.nsw.optusnet.com.au [49.181.255.80])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 757C63A126C;
        Fri, 15 Nov 2019 15:56:36 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iVTes-000703-KI; Fri, 15 Nov 2019 15:56:34 +1100
Date:   Fri, 15 Nov 2019 15:56:34 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: single aio thread is migrated crazily by scheduler
Message-ID: <20191115045634.GN4614@dread.disaster.area>
References: <20191114113153.GB4213@ming.t460p>
 <20191114235415.GL4614@dread.disaster.area>
 <20191115010824.GC4847@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115010824.GC4847@ming.t460p>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=XqaD5fcB6dAc7xyKljs8OA==:117 a=XqaD5fcB6dAc7xyKljs8OA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=MeAgGD-zjQ4A:10
        a=7-415B0cAAAA:8 a=YA4SRm3-OJPy1tlrI5wA:9 a=Aj6MW7hUX1EADMvn:21
        a=IWKxPDfHLwVYwAi0:21 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 15, 2019 at 09:08:24AM +0800, Ming Lei wrote:
> Hi Dave,
> 
> On Fri, Nov 15, 2019 at 10:54:15AM +1100, Dave Chinner wrote:
> > On Thu, Nov 14, 2019 at 07:31:53PM +0800, Ming Lei wrote:
> > > Hi Guys,
> > > 
> > > It is found that single AIO thread is migrated crazely by scheduler, and
> > > the migrate period can be < 10ms. Follows the test a):
> > > 
> > > 	- run single job fio[1] for 30 seconds:
> > > 	./xfs_complete 512
> > > 	
> > > 	- observe fio io thread migration via bcc trace[2], and the migration
> > > 	times can reach 5k ~ 10K in above test. In this test, CPU utilization
> > > 	is 30~40% on the CPU running fio IO thread.
> > 
> > Using the default scheduler tunings:
> > 
> > kernel.sched_wakeup_granularity_ns = 4000000
> > kernel.sched_min_granularity_ns = 3000000
> > 
> > I'm not seeing any migrations at all on a 16p x86-64 box. Even with
> > the tunings you suggest:
> > 
> > 	sysctl kernel.sched_min_granularity_ns=10000000
> > 	sysctl kernel.sched_wakeup_granularity_ns=15000000
> > 
> > There are no migrations at all.
> 
> Looks I forget to pass $BS to the fio command line in the script posted,
> please try the following script again and run './xfs_complete 512' first.

So I ran 4kB IOs instead of 512 byte IOs. Shouldn't make any
difference, really - it'll still be CPU bound...

<snip script>

> In my test just done, the migration count is 12K in 30s fio running.
> Sometimes the number can be quite less, but most of times, the number
> is very big(> 5k).

With my iomap-dio-overwrite patch and 512 byte IOs:

$ sudo trace-cmd show |grep sched_migrate_task |wc -l
112
$ sudo trace-cmd show |grep sched_migrate_task |grep fio |wc -l
22

Without the iomap-dio-overwrite patch:

$ sudo trace-cmd show |grep sched_migrate_task |wc -l
99
$ sudo trace-cmd show |grep sched_migrate_task |grep fio |wc -l
9
$

There are -less- migrations when using the workqueue for everything.
But it's so low in either case that it's just noise.

Performance is identical for the two patches...

> > > BTW, the tests are run on latest linus tree(5.4-rc7) in KVM guest, and the
> > > fio test is created for simulating one real performance report which is
> > > proved to be caused by frequent aio submission thread migration.
> > 
> > What is the underlying hardware? I'm running in a 16p KVM guest on a
> > 16p/32t x86-64 using 5.4-rc7, and I don't observe any significant
> > CPU migration occurring at all from your test workload.
> 
> It is a KVM guest, which is running on my Lenova T460p Fedora 29 laptop,
> and the host kernel is 5.2.18-100.fc29.x86_64, follows the guest info:

Ok, so what are all the custom distro kernel tunings that userspace
does for the kernel?

> [root@ktest-01 ~]# lscpu
> Architecture:        x86_64
> CPU op-mode(s):      32-bit, 64-bit
> Byte Order:          Little Endian
> CPU(s):              8
> On-line CPU(s) list: 0-7
> Thread(s) per core:  1
> Core(s) per socket:  4
> Socket(s):           2
> NUMA node(s):        2

Curious. You've configured it as two CPU sockets. If you make it a
single socket, do your delay problems go away?  The snippet of trace
output you showed indicated it bouncing around CPUs on a single node
(cpus 0-3), so maybe it has something to do with way the scheduler
is interacting with non-zero NUMA distances...

> Vendor ID:           GenuineIntel
> CPU family:          6
> Model:               94
> Model name:          Intel(R) Core(TM) i7-6820HQ CPU @ 2.70GHz
> Stepping:            3
> CPU MHz:             2712.000
> BogoMIPS:            5424.00
> Virtualization:      VT-x
> Hypervisor vendor:   KVM
> Virtualization type: full
> L1d cache:           32K
> L1i cache:           32K
> L2 cache:            4096K
> L3 cache:            16384K
> NUMA node0 CPU(s):   0-3
> NUMA node1 CPU(s):   4-7
> Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmxp

That seems like a very minimal set of CPU flags - looks like you are
not actually passing the actual host CPU capabilities through to the
guest. That means it will be doing the slowest, most generic
spectre/meltdown mitigations, right?

Also, shouldn't lscpu be telling us all the CPU bug mitigations in
place?

From my test system:

Architecture:                    x86_64
CPU op-mode(s):                  32-bit, 64-bit
Byte Order:                      Little Endian
Address sizes:                   40 bits physical, 48 bits virtual
CPU(s):                          16
On-line CPU(s) list:             0-15
Thread(s) per core:              1
Core(s) per socket:              1
Socket(s):                       16
NUMA node(s):                    1
Vendor ID:                       GenuineIntel
CPU family:                      6
Model:                           45
Model name:                      Intel(R) Xeon(R) CPU E5-4620 0 @ 2.20GHz
Stepping:                        7
CPU MHz:                         2199.998
BogoMIPS:                        4399.99
Virtualization:                  VT-x
Hypervisor vendor:               KVM
Virtualization type:             full
L1d cache:                       512 KiB
L1i cache:                       512 KiB
L2 cache:                        64 MiB
L3 cache:                        256 MiB
NUMA node0 CPU(s):               0-15
Vulnerability L1tf:              Mitigation; PTE Inversion; VMX flush not necessary, SMT disabled
Vulnerability Mds:               Mitigation; Clear CPU buffers; SMT Host state unknown
Vulnerability Meltdown:          Vulnerable
Vulnerability Spec store bypass: Mitigation; Speculative Store Bypass disabled via prctl and seccomp
Vulnerability Spectre v1:        Mitigation; usercopy/swapgs barriers and __user pointer sanitization
Vulnerability Spectre v2:        Vulnerable, IBPB: disabled, STIBP: disabled
Flags:                           fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ss syscall nx pdpe1gb rdtscp l
                                 m constant_tsc arch_perfmon rep_good nopl xtopology cpuid tsc_known_freq pni pclmulqdq vmx ssse3 cx16 pcid sse4_1 sse4_2 x2apic 
                                 popcnt tsc_deadline_timer aes xsave avx hypervisor lahf_lm cpuid_fault ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpi
                                 d tsc_adjust xsaveopt arat umip md_clear arch_capabilities

So, to rule out that it has something to do with kernel config,
I just ran up a kernel built with your config.gz, and the problem
does not manifest. The only difference was a few drivers I needed to
boot my test VMs, and I was previously not using paravirt spinlocks.

So, I still can't reproduce the problem. Indeed, the workload gets
nowhere near single CPU bound with your config - it's using half the
CPU for the same performance:

%Cpu2  : 19.8 us, 28.2 sy,  0.0 ni,  0.0 id, 52.0 wa,  0.0 hi,  0.0 %si,  0.0 st

Basically, it's spending half it's time waiting on IO. If I wind the
delay down to 1000ns:

%Cpu1  : 42.2 us, 42.2 sy,  0.0 ni,  0.0 id,  0.0 wa,  0.0 hi, 15.6 %si,  0.0 st

it spends an awful lot of time in soft-interrupt, but is back to
being CPU bound.

Despite this, I still don't see any significant amount of task
migration. In fact, I see a lot less with your kernel config that I
do with my original kernel config, because the CPU load was far
lower.

> Just run a quick test several times after applying the above patch, and looks it
> does make a big difference in test './xfs_complete 512' wrt. fio io thread migration.

There's something very different about your system, and it doesn't
appear to be a result of the kernel code itself. I think you're
going to have to do all the testing at the moment, Ming, because
it's clear that my test systems do not show up the problems even
when using the same kernel config as you do...

If you reconfig you kvm setup to pass all the native host side cpu
flags through to the guest, does the problem go away? I think adding
"-cpu host" to your qemu command line will do that...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
