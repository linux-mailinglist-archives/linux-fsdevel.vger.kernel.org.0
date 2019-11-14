Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB782FC561
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2019 12:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfKNLcZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 06:32:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50494 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726002AbfKNLcY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 06:32:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573731143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ydfF/6rph5aw0S+dXQ7vAdmn1cldyijsWjA+3qHaIds=;
        b=FF70Oc4hEF3xKikQlCqbWTTmntnVPs6Ioez5mPEqLUOoh5XFzvEmMr/tlhpfaqnZQ/9l1C
        sqrL2nAaVBOl6aDJeywoAqvsualCyOK+O2cr5ED//6obRXVsEKXz+yqd9DHqeZH86cwE02
        XQ410Qhxj2RY8u3uF7+Jk8sNhqw7OoU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-SvsZNX8EO-qCTEECn5opRQ-1; Thu, 14 Nov 2019 06:32:20 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 929F0190743E;
        Thu, 14 Nov 2019 11:32:18 +0000 (UTC)
Received: from ming.t460p (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EBDAA77645;
        Thu, 14 Nov 2019 11:31:57 +0000 (UTC)
Date:   Thu, 14 Nov 2019 19:31:53 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jeff Moyer <jmoyer@redhat.com>, Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>
Subject: single aio thread is migrated crazily by scheduler
Message-ID: <20191114113153.GB4213@ming.t460p>
MIME-Version: 1.0
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: SvsZNX8EO-qCTEECn5opRQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Guys,

It is found that single AIO thread is migrated crazely by scheduler, and
the migrate period can be < 10ms. Follows the test a):

=09- run single job fio[1] for 30 seconds:
=09./xfs_complete 512
=09
=09- observe fio io thread migration via bcc trace[2], and the migration
=09times can reach 5k ~ 10K in above test. In this test, CPU utilization
=09is 30~40% on the CPU running fio IO thread.
=09
=09- after applying the debug patch[3] to queue XFS completion work on
=09other CPU(not current CPU), the above crazy fio IO thread migration
=09can't be observed.

And the similar result can be observed in the following test b) too:

=09- set sched parameters:
=09=09sysctl kernel.sched_min_granularity_ns=3D10000000
=09=09sysctl kernel.sched_wakeup_granularity_ns=3D15000000
=09
=09=09which is usually done by 'tuned-adm profile network-throughput'
=09
=09- run single job fio aio[1] for 30 seconds:
=09  ./xfs_complete 4k=20
=09
=09- observe fio io thread migration[2], and similar crazy migration
=09can be observed too. In this test, CPU utilization is close to 100%
=09on the CPU for running fio IO thread
=09
=09- the debug patch[3] still makes a big difference on this test wrt.
=09fio IO thread migration.

For test b), I thought that load balance may be triggered when
single fio IO thread takes the CPU by ~100%, meantime XFS's queue_work()
schedules WQ worker thread on the current CPU, since all other CPUs
are idle. When the fio IO thread is migrated to new CPU, the same steps
can be repeated again.

But for test a), I have no idea why fio IO thread is still migrated so
frequently since the CPU isn't saturated at all.

IMO, it is normal for user to saturate aio thread, since this way may
save context switch.

Guys, any idea on the crazy aio thread migration?

BTW, the tests are run on latest linus tree(5.4-rc7) in KVM guest, and the
fio test is created for simulating one real performance report which is
proved to be caused by frequent aio submission thread migration.


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
    --ioengine=3Dlibaio --direct=3D1 --bs=3D4k --iodepth=3D$QD \
    --iodepth_batch_submit=3D$BATCH \
    --iodepth_batch_complete_min=3D$BATCH \
    --numjobs=3D$NJOBS \
    --verify=3D$VERIFY \
    --name=3D/hana/fsperf/foo

umount $DEV
rmmod scsi_debug


[2] observe fio migration via bcc trace:
/usr/share/bcc/tools/trace -C -t  't:sched:sched_migrate_task "%s/%d cpu %d=
->%d", args->comm,args->pid,args->orig_cpu,args->dest_cpu' | grep fio=20

[3] test patch for queuing xfs completetion on other CPU

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 1fc28c2da279..bdc007a57706 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -158,9 +158,14 @@ static void iomap_dio_bio_end_io(struct bio *bio)
 =09=09=09blk_wake_io_task(waiter);
 =09=09} else if (dio->flags & IOMAP_DIO_WRITE) {
 =09=09=09struct inode *inode =3D file_inode(dio->iocb->ki_filp);
+=09=09=09unsigned cpu =3D cpumask_next(smp_processor_id(),
+=09=09=09=09=09cpu_online_mask);
+
+=09=09=09if (cpu >=3D nr_cpu_ids)
+=09=09=09=09cpu =3D 0;
=20
 =09=09=09INIT_WORK(&dio->aio.work, iomap_dio_complete_work);
-=09=09=09queue_work(inode->i_sb->s_dio_done_wq, &dio->aio.work);
+=09=09=09queue_work_on(cpu, inode->i_sb->s_dio_done_wq, &dio->aio.work);
 =09=09} else {
 =09=09=09iomap_dio_complete_work(&dio->aio.work);
 =09=09}

Thanks,
Ming

