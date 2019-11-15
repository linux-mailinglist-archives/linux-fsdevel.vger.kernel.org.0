Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA143FD237
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 02:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbfKOBJA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 20:09:00 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53690 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727224AbfKOBJA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 20:09:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573780135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pAC9sF4Sg7zbkVmIeSz2qQx1GVOjEP6vMrR4AZWXU7A=;
        b=ZiMkzMTthrIng1cBZd34ttUlgluEJE449hBT/LURYQw2l+eLurkkMZoAAfqSN4YJ7cER8b
        RYV5j4IZ6AqBBwE1P3EyDM/0F1q32hKTPzcYdx68EdjQD0+I4z8JuzhoE0860Haqzzzqa/
        vz1SGu3y+iNxoQbhK+9u7PV5nXGThDE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-u9-cnLMMP5KPQBStERXZpQ-1; Thu, 14 Nov 2019 20:08:43 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D55C1100550E;
        Fri, 15 Nov 2019 01:08:41 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2993C600C9;
        Fri, 15 Nov 2019 01:08:28 +0000 (UTC)
Date:   Fri, 15 Nov 2019 09:08:24 +0800
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
Message-ID: <20191115010824.GC4847@ming.t460p>
References: <20191114113153.GB4213@ming.t460p>
 <20191114235415.GL4614@dread.disaster.area>
MIME-Version: 1.0
In-Reply-To: <20191114235415.GL4614@dread.disaster.area>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: u9-cnLMMP5KPQBStERXZpQ-1
X-Mimecast-Spam-Score: 0
Content-Type: multipart/mixed; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=WINDOWS-1252
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On Fri, Nov 15, 2019 at 10:54:15AM +1100, Dave Chinner wrote:
> On Thu, Nov 14, 2019 at 07:31:53PM +0800, Ming Lei wrote:
> > Hi Guys,
> >=20
> > It is found that single AIO thread is migrated crazely by scheduler, an=
d
> > the migrate period can be < 10ms. Follows the test a):
> >=20
> > =09- run single job fio[1] for 30 seconds:
> > =09./xfs_complete 512
> > =09
> > =09- observe fio io thread migration via bcc trace[2], and the migratio=
n
> > =09times can reach 5k ~ 10K in above test. In this test, CPU utilizatio=
n
> > =09is 30~40% on the CPU running fio IO thread.
>=20
> Using the default scheduler tunings:
>=20
> kernel.sched_wakeup_granularity_ns =3D 4000000
> kernel.sched_min_granularity_ns =3D 3000000
>=20
> I'm not seeing any migrations at all on a 16p x86-64 box. Even with
> the tunings you suggest:
>=20
> =09sysctl kernel.sched_min_granularity_ns=3D10000000
> =09sysctl kernel.sched_wakeup_granularity_ns=3D15000000
>=20
> There are no migrations at all.

Looks I forget to pass $BS to the fio command line in the script posted,
please try the following script again and run './xfs_complete 512' first.

[1] xfs_complete: one fio script for running single job overwrite aio on XF=
S
#!/bin/bash

BS=3D$1
NJOBS=3D1
QD=3D128
DIR=3D/mnt/xfs
BATCH=3D1
VERIFY=3D"sha3-512"

sysctl kernel.sched_wakeup_granularity_ns
sysctl kernel.sched_min_granularity_ns

rmmod scsi_debug;modprobe scsi_debug dev_size_mb=3D6144 ndelay=3D41000 dix=
=3D1 dif=3D2
DEV=3D`ls -d /sys/bus/pseudo/drivers/scsi_debug/adapter*/host*/target*/*/bl=
ock/* | head -1 | xargs basename`
DEV=3D"/dev/"$DEV

mkfs.xfs -f $DEV
[ ! -d $DIR ] && mkdir -p $DIR
mount $DEV $DIR

fio --readwrite=3Drandwrite --filesize=3D5g \
    --overwrite=3D1 \
    --filename=3D$DIR/fiofile \
    --runtime=3D30s --time_based \
    --ioengine=3Dlibaio --direct=3D1 --bs=3D$BS --iodepth=3D$QD \
    --iodepth_batch_submit=3D$BATCH \
    --iodepth_batch_complete_min=3D$BATCH \
    --numjobs=3D$NJOBS \
    --verify=3D$VERIFY \
    --name=3D/hana/fsperf/foo

umount $DEV
rmmod scsi_debug


When running './xfs_complete 512', lots of fio migration can be observed
via bcc trace:

/usr/share/bcc/tools/trace -C -t  't:sched:sched_migrate_task "%s/%d cpu %d=
->%d", args->comm,args->pid,args->orig_cpu,args->dest_cpu' | grep fio

...
69.13495 2   23      23      kworker/2:0     sched_migrate_task b'fio'/866 =
cpu 2->0
69.13513 0   13      13      kworker/0:1     sched_migrate_task b'fio'/866 =
cpu 0->2
69.86733 2   23      23      kworker/2:0     sched_migrate_task b'fio'/866 =
cpu 2->3
70.20730 3   134     134     kworker/3:1     sched_migrate_task b'fio'/866 =
cpu 3->0
70.21131 0   13      13      kworker/0:1     sched_migrate_task b'fio'/866 =
cpu 0->1
70.21733 1   112     112     kworker/1:1     sched_migrate_task b'fio'/866 =
cpu 1->2
70.29528 2   23      23      kworker/2:0     sched_migrate_task b'fio'/866 =
cpu 2->0
70.29769 0   13      13      kworker/0:1     sched_migrate_task b'fio'/866 =
cpu 0->2
70.36332 2   23      23      kworker/2:0     sched_migrate_task b'fio'/866 =
cpu 2->3
70.41924 3   134     134     kworker/3:1     sched_migrate_task b'fio'/866 =
cpu 3->2
70.78572 2   23      23      kworker/2:0     sched_migrate_task b'fio'/866 =
cpu 2->0
70.79061 0   13      13      kworker/0:1     sched_migrate_task b'fio'/866 =
cpu 0->2
70.91526 2   23      23      kworker/2:0     sched_migrate_task b'fio'/866 =
cpu 2->0
70.91607 0   13      13      kworker/0:1     sched_migrate_task b'fio'/866 =
cpu 0->2
...

In my test just done, the migration count is 12K in 30s fio running.
Sometimes the number can be quite less, but most of times, the number
is very big(> 5k).

Also attaches my kernel config.

> During the overwrite phase of the test, I'm seeing 66% fio usage,
> 28% system time and of that, only 3% of the CPU time is in the IO
> completion workqueue time. It's all running on the one CPU, and it's
> running at about 15,000 context switches per second.. I'm not seeing
> any CPU migrations at all, despite the workload being completely CPU
> bound on a single CPU.

In my test VM, in case of 4K block size(./xfs_complete 4k), when the
following kernel parameters are passed in:

 =09sysctl kernel.sched_min_granularity_ns=3D10000000
 =09sysctl kernel.sched_wakeup_granularity_ns=3D15000000

'top -H' shows that fio consumes ~100% CPU, and the fio IO thread is
migrated very frequently.

>=20
> This is the typical output from top:
>=20
> Tasks: 262 total,   2 running, 260 sleeping,   0 stopped,   0 zombie
> %Cpu0  :  0.0 us,  0.3 sy,  0.0 ni, 99.7 id,  0.0 wa,  0.0 hi,  0.0 si,  =
0.0 st
> %Cpu1  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  =
0.0 st
> %Cpu2  :  0.0 us,  0.3 sy,  0.0 ni, 99.7 id,  0.0 wa,  0.0 hi,  0.0 si,  =
0.0 st
> %Cpu3  : 66.2 us, 27.8 sy,  0.0 ni,  0.0 id,  0.0 wa,  0.0 hi,  6.0 si,  =
0.0 st
> %Cpu4  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  =
0.0 st
> %Cpu5  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  =
0.0 st
> %Cpu6  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  =
0.0 st
> %Cpu7  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  =
0.0 st
> %Cpu8  :  0.0 us,  0.0 sy,  0.0 ni, 99.7 id,  0.0 wa,  0.0 hi,  0.3 si,  =
0.0 st
> %Cpu9  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  =
0.0 st
> %Cpu10 :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  =
0.0 st
> %Cpu11 :  0.0 us,  0.3 sy,  0.0 ni, 99.7 id,  0.0 wa,  0.0 hi,  0.0 si,  =
0.0 st
> %Cpu12 :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  =
0.0 st
> %Cpu13 :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  =
0.0 st
> %Cpu14 :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  =
0.0 st
> %Cpu15 :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  =
0.0 st
> MiB Mem :  16005.3 total,   8737.7 free,   6762.5 used,    505.2 buff/cac=
he
> MiB Swap:    486.3 total,    486.3 free,      0.0 used.   8640.3 avail Me=
m=20
>=20
>     PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ CO=
MMAND
>    5554 root      20   0  672064  15356   1392 R  97.0   0.1   0:17.85 fi=
o
>    1388 root      20   0       0      0      0 I   3.0   0.0   0:01.39 kw=
orker/3:1-dio/sdb
>    5552 root      20   0  661364 275380 271992 S   0.7   1.7   0:15.88 fi=
o
>    4891 dave      20   0   15572   5876   4600 S   0.3   0.0   0:00.56 ss=
hd
>    4933 dave      20   0   11732   4276   3296 R   0.3   0.0   0:01.30 to=
p
>=20
> i.e. it runs entirely on CPU 3 for the whole 30s measurement period.
>=20
> And the number of migrate task events:
>=20
> $ sudo trace-cmd start -e sched_migrate_task
> $ sudo ./run_test.sh
> .....
> $ sudo trace-cmd show |grep fio
>      kworker/1:1-1252  [001] d..2  2002.792659: sched_migrate_task: comm=
=3Dfio pid=3D5689 prio=3D120 orig_cpu=3D5 dest_cpu=3D1
>      rcu_preempt-11    [011] d..2  2004.202624: sched_migrate_task: comm=
=3Dfio pid=3D5689 prio=3D120 orig_cpu=3D1 dest_cpu=3D11
>      rcu_preempt-11    [006] d..2  2008.364481: sched_migrate_task: comm=
=3Dfio pid=3D5689 prio=3D120 orig_cpu=3D11 dest_cpu=3D6
>           <idle>-0     [007] dNs2  2009.209480: sched_migrate_task: comm=
=3Dfio pid=3D5689 prio=3D120 orig_cpu=3D6 dest_cpu=3D7
> $
>=20
> And top tells me these fio processes are consuming CPU:
>=20
>    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COM=
MAND                                                                       =
          =20
>    5695 root      20   0  663872   7120   1324 R  97.7   0.0   0:03.48 fi=
o                                                                          =
           =20
>    5689 root      20   0  661356 275512 272128 S   0.3   1.7   0:15.46 fi=
o                                                                          =
           =20
>=20
> So, the fio process that got migrated 4 times in 30s is the fio
> process that isn't doing any of the work.
>=20
> There's no migration going on here at all on a vanilla kernel on
> a Debian userspace, with or without the suggested scheduler
> tunings.
>=20
> > =09- after applying the debug patch[3] to queue XFS completion work on
> > =09other CPU(not current CPU), the above crazy fio IO thread migration
> > =09can't be observed.
> >
> > IMO, it is normal for user to saturate aio thread, since this way may
> > save context switch.
> >=20
> > Guys, any idea on the crazy aio thread migration?
>=20
> It doesn't happen on x86-64 with a current TOT vanilla kernel and
> a debian userspace.
>=20
> What userspace are you testing with?

Fedora 29.

>=20
> > BTW, the tests are run on latest linus tree(5.4-rc7) in KVM guest, and =
the
> > fio test is created for simulating one real performance report which is
> > proved to be caused by frequent aio submission thread migration.
>=20
> What is the underlying hardware? I'm running in a 16p KVM guest on a
> 16p/32t x86-64 using 5.4-rc7, and I don't observe any significant
> CPU migration occurring at all from your test workload.

It is a KVM guest, which is running on my Lenova T460p Fedora 29 laptop,
and the host kernel is 5.2.18-100.fc29.x86_64, follows the guest info:

[root@ktest-01 ~]# lscpu
Architecture:        x86_64
CPU op-mode(s):      32-bit, 64-bit
Byte Order:          Little Endian
CPU(s):              8
On-line CPU(s) list: 0-7
Thread(s) per core:  1
Core(s) per socket:  4
Socket(s):           2
NUMA node(s):        2
Vendor ID:           GenuineIntel
CPU family:          6
Model:               94
Model name:          Intel(R) Core(TM) i7-6820HQ CPU @ 2.70GHz
Stepping:            3
CPU MHz:             2712.000
BogoMIPS:            5424.00
Virtualization:      VT-x
Hypervisor vendor:   KVM
Virtualization type: full
L1d cache:           32K
L1i cache:           32K
L2 cache:            4096K
L3 cache:            16384K
NUMA node0 CPU(s):   0-3
NUMA node1 CPU(s):   4-7
Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge m=
ca cmov pat pse36 clflush mmxp
[root@ktest-01 ~]# uname -a
Linux ktest-01 5.4.0-rc5-00367-gac8d20c84c47 #1532 SMP Thu Nov 14 19:13:25 =
CST 2019 x86_64 x86_64 x86_64x

>=20
> > [3] test patch for queuing xfs completetion on other CPU
> >=20
> > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > index 1fc28c2da279..bdc007a57706 100644
> > --- a/fs/iomap/direct-io.c
> > +++ b/fs/iomap/direct-io.c
> > @@ -158,9 +158,14 @@ static void iomap_dio_bio_end_io(struct bio *bio)
> >  =09=09=09blk_wake_io_task(waiter);
> >  =09=09} else if (dio->flags & IOMAP_DIO_WRITE) {
> >  =09=09=09struct inode *inode =3D file_inode(dio->iocb->ki_filp);
> > +=09=09=09unsigned cpu =3D cpumask_next(smp_processor_id(),
> > +=09=09=09=09=09cpu_online_mask);
> > +
> > +=09=09=09if (cpu >=3D nr_cpu_ids)
> > +=09=09=09=09cpu =3D 0;
> > =20
> >  =09=09=09INIT_WORK(&dio->aio.work, iomap_dio_complete_work);
> > -=09=09=09queue_work(inode->i_sb->s_dio_done_wq, &dio->aio.work);
> > +=09=09=09queue_work_on(cpu, inode->i_sb->s_dio_done_wq, &dio->aio.work=
);
> >  =09=09} else {
> >  =09=09=09iomap_dio_complete_work(&dio->aio.work);
> >  =09=09}
>=20
> So, can you test the patch I sent you a while back that avoided
> using the completion workqueue for pure overwrites? Does that make
> your whacky scheduler behaviour go away, or does it still reschedule
> like crazy?

Last time, I found that your patch V3 doesn't work as expected since the tr=
ace
message of 'overwrite completion' isn't observed when running the external
test case. Seems not see your further response after I reported it to you.

Will try this patch again.

>=20
> I haven't posted that patch to the list because I can't prove it
> makes any difference to performance in any workload on any hardware
> I've tested it on. I just tested it on your workload, and it makes
> no different to behaviour or performance. It's definitely hitting
> the non-workqueue completion path:
>=20
> $ sudo trace-cmd show | grep overwrite |head -1
>              fio-4526  [009] ..s.   180.361089: iomap_dio_bio_end_io: ove=
rwrite completion
> $ sudo trace-cmd show | grep overwrite |wc -l
> 51295
> $
>=20
> so it's pretty clear that whatever is going on is not obviously a
> problem with workqueues or the way iomap does completions. Patch is
> attached below for you to test. You will need to pull commit
> 7684e2c4384d ("iomap: iomap that extends beyond EOF should be marked
> dirty") from the iomap for-next branch to ensure this patch
> functions correctly.
>=20
> Cheers,
>=20
> -Dave.
> --=20
> Dave Chinner
> david@fromorbit.com
>=20
> iomap: don't defer completion of pure AIO+DIO overwrites
>=20
> From: Dave Chinner <dchinner@redhat.com>
>=20
> We have a workload issuing 4k sequential AIO+DIOs in batches (yeah,
> really silly thing to do when you could just emit a single large
> IO) that is showing some interesting performance anomalies. i.e.
> massive performance regressions that go away when the workload is
> straced because it changes AIO completion scheduling and submission
> batch sizes....
>=20
> Older kernels that don't have the iomap DIO code don't show the same
> regression, and they complete the AIO-DIO in the the bio completion
> context rather than deferring it to a workqueue like iomap does.
>=20
> Hence, for pure overwrites that don't require any metadata updates
> on IO completion, including file size, call the IO completion
> directly rather than deferring it to the completion workqueue. THe
> IOMAP_DIO_OVERWRITE flag is added to tell ->end_io implementations
> that they are running in bio completion context and that they should
> not have any update work to do. This leverages the iomap FUA
> optimisations that allow FUA writes to be issued when no metadata
> updates are required to be synced to disk during IO completion.
>=20
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  fs/iomap/direct-io.c  | 26 ++++++++++++++++++++------
>  fs/xfs/xfs_file.c     |  3 +++
>  include/linux/iomap.h |  8 ++++++++
>  3 files changed, 31 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 49bf9780e3ed..a89b29306794 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -159,8 +159,14 @@ static void iomap_dio_bio_end_io(struct bio *bio)
>  =09=09} else if (dio->flags & IOMAP_DIO_WRITE) {
>  =09=09=09struct inode *inode =3D file_inode(dio->iocb->ki_filp);
> =20
> -=09=09=09INIT_WORK(&dio->aio.work, iomap_dio_complete_work);
> -=09=09=09queue_work(inode->i_sb->s_dio_done_wq, &dio->aio.work);
> +=09=09=09if ((dio->flags & IOMAP_DIO_OVERWRITE) &&
> +=09=09=09     !inode->i_mapping->nrpages) {
> +=09=09=09=09trace_printk("overwrite completion\n");
> +=09=09=09=09iomap_dio_complete_work(&dio->aio.work);
> +=09=09=09} else {
> +=09=09=09=09INIT_WORK(&dio->aio.work, iomap_dio_complete_work);
> +=09=09=09=09queue_work(inode->i_sb->s_dio_done_wq, &dio->aio.work);
> +=09=09=09}
>  =09=09} else {
>  =09=09=09iomap_dio_complete_work(&dio->aio.work);
>  =09=09}
> @@ -229,10 +235,12 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos=
, loff_t length,
>  =09=09 * the underlying device supports FUA. This allows us to avoid
>  =09=09 * cache flushes on IO completion.
>  =09=09 */
> -=09=09if (!(iomap->flags & (IOMAP_F_SHARED|IOMAP_F_DIRTY)) &&
> -=09=09    (dio->flags & IOMAP_DIO_WRITE_FUA) &&
> -=09=09    blk_queue_fua(bdev_get_queue(iomap->bdev)))
> -=09=09=09use_fua =3D true;
> +=09=09if (!(iomap->flags & (IOMAP_F_SHARED|IOMAP_F_DIRTY))) {
> +=09=09=09dio->flags |=3D IOMAP_DIO_OVERWRITE;
> +=09=09=09if ((dio->flags & IOMAP_DIO_WRITE_FUA) &&
> +=09=09=09    blk_queue_fua(bdev_get_queue(iomap->bdev)))
> +=09=09=09=09use_fua =3D true;
> +=09=09}
>  =09}
> =20
>  =09/*
> @@ -511,9 +519,15 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *it=
er,
>  =09/*
>  =09 * If all the writes we issued were FUA, we don't need to flush the
>  =09 * cache on IO completion. Clear the sync flag for this case.
> +=09 *
> +=09 * If we are doing an overwrite and need to sync and FUA cannot be us=
ed,
> +=09 * clear the overwrite flag to ensure the completion is run via the
> +=09 * workqueue rather than directly.
>  =09 */
>  =09if (dio->flags & IOMAP_DIO_WRITE_FUA)
>  =09=09dio->flags &=3D ~IOMAP_DIO_NEED_SYNC;
> +=09if (dio->flags & IOMAP_DIO_NEED_SYNC)
> +=09=09dio->flags &=3D ~IOMAP_DIO_OVERWRITE;
> =20
>  =09WRITE_ONCE(iocb->ki_cookie, dio->submit.cookie);
>  =09WRITE_ONCE(iocb->private, dio->submit.last_queue);
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 525b29b99116..794dea2f1dc3 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -395,6 +395,9 @@ xfs_dio_write_end_io(
>  =09 */
>  =09XFS_STATS_ADD(ip->i_mount, xs_write_bytes, size);
> =20
> +=09if (flags & IOMAP_DIO_OVERWRITE)
> +=09=09return 0;
> +
>  =09/*
>  =09 * We can allocate memory here while doing writeback on behalf of
>  =09 * memory reclaim.  To avoid memory allocation deadlocks set the
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 8b09463dae0d..009c5969a2ef 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -249,6 +249,14 @@ int iomap_writepages(struct address_space *mapping,
>  #define IOMAP_DIO_UNWRITTEN=09(1 << 0)=09/* covers unwritten extent(s) *=
/
>  #define IOMAP_DIO_COW=09=09(1 << 1)=09/* covers COW extent(s) */
> =20
> +/*
> + * IOMAP_DIO_OVERWRITE indicates a pure overwrite that requires no metad=
ata
> + * updates on completion. It also indicates that the completion is runni=
ng in
> + * the hardware IO completion context (e.g. softirq) rather than on a sc=
hedules
> + * workqueue.
> + */
> +#define IOMAP_DIO_OVERWRITE=09(1 << 2)
> +
>  struct iomap_dio_ops {
>  =09int (*end_io)(struct kiocb *iocb, ssize_t size, int error,
>  =09=09      unsigned flags);
>=20

Just run a quick test several times after applying the above patch, and loo=
ks it
does make a big difference in test './xfs_complete 512' wrt. fio io thread =
migration.


thanks,
Ming

--GvXjxJ+pjyke8COw
Content-Type: application/gzip
Content-Disposition: attachment; filename="config.gz"
Content-Transfer-Encoding: base64

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
dFb2nP7ZTieUnsX/AYoAOf1AogEA
--GvXjxJ+pjyke8COw--

