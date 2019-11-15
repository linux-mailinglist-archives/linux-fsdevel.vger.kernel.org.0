Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B95A0FD6BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 08:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfKOHJG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 02:09:06 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34372 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726182AbfKOHJF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 02:09:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573801744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0heYp1A4SIHfSmO0saLgLXMa8wFv5TYVrqbH9eYhTI0=;
        b=YUbA3yAG3eSMTpPq9xupQdn2s6V3aLnKToVE2+vO8vPMKTGMpq+8kVumvzC8eFnqvY8d/b
        lbA0l3k6RvCMkx3fRynMsFJ1IUWc/pJ9GMxE8Q6323jf9d9Zp9DMPcST3vUUslKg2b2fwf
        1ui9F0G6nlGxsj5zOwDBy+BjpIwk3kk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-LSrVJqZuOCmcXzlqPoqnow-1; Fri, 15 Nov 2019 02:09:01 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E3C0477;
        Fri, 15 Nov 2019 07:08:59 +0000 (UTC)
Received: from ming.t460p (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9441F67E59;
        Fri, 15 Nov 2019 07:08:47 +0000 (UTC)
Date:   Fri, 15 Nov 2019 15:08:43 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
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
Message-ID: <20191115070843.GA24246@ming.t460p>
References: <20191114113153.GB4213@ming.t460p>
 <20191114235415.GL4614@dread.disaster.area>
 <20191115010824.GC4847@ming.t460p>
 <20191115045634.GN4614@dread.disaster.area>
MIME-Version: 1.0
In-Reply-To: <20191115045634.GN4614@dread.disaster.area>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: LSrVJqZuOCmcXzlqPoqnow-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 15, 2019 at 03:56:34PM +1100, Dave Chinner wrote:
> On Fri, Nov 15, 2019 at 09:08:24AM +0800, Ming Lei wrote:
> > Hi Dave,
> >=20
> > On Fri, Nov 15, 2019 at 10:54:15AM +1100, Dave Chinner wrote:
> > > On Thu, Nov 14, 2019 at 07:31:53PM +0800, Ming Lei wrote:
> > > > Hi Guys,
> > > >=20
> > > > It is found that single AIO thread is migrated crazely by scheduler=
, and
> > > > the migrate period can be < 10ms. Follows the test a):
> > > >=20
> > > > =09- run single job fio[1] for 30 seconds:
> > > > =09./xfs_complete 512
> > > > =09
> > > > =09- observe fio io thread migration via bcc trace[2], and the migr=
ation
> > > > =09times can reach 5k ~ 10K in above test. In this test, CPU utiliz=
ation
> > > > =09is 30~40% on the CPU running fio IO thread.
> > >=20
> > > Using the default scheduler tunings:
> > >=20
> > > kernel.sched_wakeup_granularity_ns =3D 4000000
> > > kernel.sched_min_granularity_ns =3D 3000000
> > >=20
> > > I'm not seeing any migrations at all on a 16p x86-64 box. Even with
> > > the tunings you suggest:
> > >=20
> > > =09sysctl kernel.sched_min_granularity_ns=3D10000000
> > > =09sysctl kernel.sched_wakeup_granularity_ns=3D15000000
> > >=20
> > > There are no migrations at all.
> >=20
> > Looks I forget to pass $BS to the fio command line in the script posted=
,
> > please try the following script again and run './xfs_complete 512' firs=
t.
>=20
> So I ran 4kB IOs instead of 512 byte IOs. Shouldn't make any
> difference, really - it'll still be CPU bound...

In 512 block size test, the CPU utilization of fio IO thread is reduced to
40%, which is more like IO bound.

>=20
> <snip script>
>=20
> > In my test just done, the migration count is 12K in 30s fio running.
> > Sometimes the number can be quite less, but most of times, the number
> > is very big(> 5k).
>=20
> With my iomap-dio-overwrite patch and 512 byte IOs:
>=20
> $ sudo trace-cmd show |grep sched_migrate_task |wc -l
> 112
> $ sudo trace-cmd show |grep sched_migrate_task |grep fio |wc -l
> 22
>=20
> Without the iomap-dio-overwrite patch:
>=20
> $ sudo trace-cmd show |grep sched_migrate_task |wc -l
> 99
> $ sudo trace-cmd show |grep sched_migrate_task |grep fio |wc -l
> 9
> $
>=20
> There are -less- migrations when using the workqueue for everything.
> But it's so low in either case that it's just noise.
>=20
> Performance is identical for the two patches...

I can reproduce the issue with 4k block size on another RH system, and
the login info of that system has been shared to you in RH BZ.

1)
sysctl kernel.sched_min_granularity_ns=3D10000000
sysctl kernel.sched_wakeup_granularity_ns=3D15000000

2)
./xfs_complete 4k

Then you should see 1k~1.5k fio io thread migration in above test,
either v5.4-rc7(build with rhel8 config) or RHEL 4.18 kernel.

Not reproduced the issue with 512 block size on the RH system yet,
maybe it is related with my kernel config.

>=20
> > > > BTW, the tests are run on latest linus tree(5.4-rc7) in KVM guest, =
and the
> > > > fio test is created for simulating one real performance report whic=
h is
> > > > proved to be caused by frequent aio submission thread migration.
> > >=20
> > > What is the underlying hardware? I'm running in a 16p KVM guest on a
> > > 16p/32t x86-64 using 5.4-rc7, and I don't observe any significant
> > > CPU migration occurring at all from your test workload.
> >=20
> > It is a KVM guest, which is running on my Lenova T460p Fedora 29 laptop=
,
> > and the host kernel is 5.2.18-100.fc29.x86_64, follows the guest info:
>=20
> Ok, so what are all the custom distro kernel tunings that userspace
> does for the kernel?

It is standard Fedora 29.

>=20
> > [root@ktest-01 ~]# lscpu
> > Architecture:        x86_64
> > CPU op-mode(s):      32-bit, 64-bit
> > Byte Order:          Little Endian
> > CPU(s):              8
> > On-line CPU(s) list: 0-7
> > Thread(s) per core:  1
> > Core(s) per socket:  4
> > Socket(s):           2
> > NUMA node(s):        2
>=20
> Curious. You've configured it as two CPU sockets. If you make it a
> single socket, do your delay problems go away?  The snippet of trace
> output you showed indicated it bouncing around CPUs on a single node
> (cpus 0-3), so maybe it has something to do with way the scheduler
> is interacting with non-zero NUMA distances...

I don't see that is a problem wrt. this issue, given the issue can
be reproduced on other system too.

>=20
> > Vendor ID:           GenuineIntel
> > CPU family:          6
> > Model:               94
> > Model name:          Intel(R) Core(TM) i7-6820HQ CPU @ 2.70GHz
> > Stepping:            3
> > CPU MHz:             2712.000
> > BogoMIPS:            5424.00
> > Virtualization:      VT-x
> > Hypervisor vendor:   KVM
> > Virtualization type: full
> > L1d cache:           32K
> > L1i cache:           32K
> > L2 cache:            4096K
> > L3 cache:            16384K
> > NUMA node0 CPU(s):   0-3
> > NUMA node1 CPU(s):   4-7
> > Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr p=
ge mca cmov pat pse36 clflush mmxp
>=20
> That seems like a very minimal set of CPU flags - looks like you are
> not actually passing the actual host CPU capabilities through to the
> guest. That means it will be doing the slowest, most generic
> spectre/meltdown mitigations, right?

The above line is just trunated by the console terminal.

>=20
> Also, shouldn't lscpu be telling us all the CPU bug mitigations in
> place?
>=20
> From my test system:
>=20
> Architecture:                    x86_64
> CPU op-mode(s):                  32-bit, 64-bit
> Byte Order:                      Little Endian
> Address sizes:                   40 bits physical, 48 bits virtual
> CPU(s):                          16
> On-line CPU(s) list:             0-15
> Thread(s) per core:              1
> Core(s) per socket:              1
> Socket(s):                       16
> NUMA node(s):                    1
> Vendor ID:                       GenuineIntel
> CPU family:                      6
> Model:                           45
> Model name:                      Intel(R) Xeon(R) CPU E5-4620 0 @ 2.20GHz
> Stepping:                        7
> CPU MHz:                         2199.998
> BogoMIPS:                        4399.99
> Virtualization:                  VT-x
> Hypervisor vendor:               KVM
> Virtualization type:             full
> L1d cache:                       512 KiB
> L1i cache:                       512 KiB
> L2 cache:                        64 MiB
> L3 cache:                        256 MiB
> NUMA node0 CPU(s):               0-15
> Vulnerability L1tf:              Mitigation; PTE Inversion; VMX flush not=
 necessary, SMT disabled
> Vulnerability Mds:               Mitigation; Clear CPU buffers; SMT Host =
state unknown
> Vulnerability Meltdown:          Vulnerable
> Vulnerability Spec store bypass: Mitigation; Speculative Store Bypass dis=
abled via prctl and seccomp
> Vulnerability Spectre v1:        Mitigation; usercopy/swapgs barriers and=
 __user pointer sanitization
> Vulnerability Spectre v2:        Vulnerable, IBPB: disabled, STIBP: disab=
led
> Flags:                           fpu vme de pse tsc msr pae mce cx8 apic =
sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ss syscall nx pdp=
e1gb rdtscp l
>                                  m constant_tsc arch_perfmon rep_good nop=
l xtopology cpuid tsc_known_freq pni pclmulqdq vmx ssse3 cx16 pcid sse4_1 s=
se4_2 x2apic=20
>                                  popcnt tsc_deadline_timer aes xsave avx =
hypervisor lahf_lm cpuid_fault ssbd ibrs ibpb stibp tpr_shadow vnmi flexpri=
ority ept vpi
>                                  d tsc_adjust xsaveopt arat umip md_clear=
 arch_capabilities
>=20
> So, to rule out that it has something to do with kernel config,
> I just ran up a kernel built with your config.gz, and the problem
> does not manifest. The only difference was a few drivers I needed to
> boot my test VMs, and I was previously not using paravirt spinlocks.
>=20
> So, I still can't reproduce the problem. Indeed, the workload gets
> nowhere near single CPU bound with your config - it's using half the
> CPU for the same performance:
>=20
> %Cpu2  : 19.8 us, 28.2 sy,  0.0 ni,  0.0 id, 52.0 wa,  0.0 hi,  0.0 %si, =
 0.0 st
>=20
> Basically, it's spending half it's time waiting on IO. If I wind the
> delay down to 1000ns:
>=20
> %Cpu1  : 42.2 us, 42.2 sy,  0.0 ni,  0.0 id,  0.0 wa,  0.0 hi, 15.6 %si, =
 0.0 st
>=20
> it spends an awful lot of time in soft-interrupt, but is back to
> being CPU bound.
>=20
> Despite this, I still don't see any significant amount of task
> migration. In fact, I see a lot less with your kernel config that I
> do with my original kernel config, because the CPU load was far
> lower.
>=20
> > Just run a quick test several times after applying the above patch, and=
 looks it
> > does make a big difference in test './xfs_complete 512' wrt. fio io thr=
ead migration.
>=20
> There's something very different about your system, and it doesn't
> appear to be a result of the kernel code itself. I think you're
> going to have to do all the testing at the moment, Ming, because
> it's clear that my test systems do not show up the problems even
> when using the same kernel config as you do...
>=20
> If you reconfig you kvm setup to pass all the native host side cpu
> flags through to the guest, does the problem go away? I think adding
> "-cpu host" to your qemu command line will do that...

Please login to the RH system I shared to you, and you will see the
issue.


Thanks,
Ming

