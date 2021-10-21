Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F7E436181
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 14:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbhJUMWn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 08:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbhJUMWk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 08:22:40 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A93AC06161C;
        Thu, 21 Oct 2021 05:20:25 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id h27so335798ila.5;
        Thu, 21 Oct 2021 05:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JBZA7h821UDoNe6u9N8hKjn2lRh+fECy1IFHIdadzHg=;
        b=SO7UWBCo7a79vM25sMwUtZnLfUErr7rfoL37QfYL79ER3yDQtOS6+1LwXccriaCajf
         chXXgHN9tSEBRIea2F0zne8slE7GskZJT8pIq9Ikx7OE8bLmDEobtm7GGQnJ2Aw1N0gY
         URAwGg9lpDdqoCjkBvrGx1SMeap34/SUANnape6EB9oPPIpjEaxLAtajkUQZFoo5gZmt
         jVF7Lo3VsChHKNERUtaJ1ZQcVZmNxQhx1vIRASPAwUrQwtejepgfvOAIUbBiyk9gf3rz
         BKrao0GQDMNRF2nJUFo/aqvCZlrf6JZckRhuQplvJfSQCJ7VEGl0gtoYok1+NLFWfajC
         dyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JBZA7h821UDoNe6u9N8hKjn2lRh+fECy1IFHIdadzHg=;
        b=0gowQZGe9vEcCN96yDba6W1LV5lpDM0y8hvLlaSw+JEDR6X0Oy97/AD0sJ5s2BnO0W
         j96VCNVbPdigKWAs8/7oMtoUH9pgmGCF1d/oKdiSyetzbpNX0hMpcyH0mytYxl9L3JWn
         wFiCsx2NnrvHFVZUNUO4e8KlWuJencHmtR95JZuXaP8au8DXMiEtvhV0lmPffVqrk7rV
         0o3ufgpmqOoFCHChf0L+d+LmWsG/JnCqmRJUtSvW6eDqq1fOEO+DW9IHjac4ClpriSS1
         NT4iTpsODoT8fjNNKpKIWmPspChQ7eyG5akpH/ronsZcLyThyRGRMldtlAwPbdJIkQlA
         8YVA==
X-Gm-Message-State: AOAM530REhBBE94tovg6mpEjFD34UAOaGRiGZmk7tRG6MyT7iwFdpSKk
        3F1JED2IK3YtKHS3N8Ywp483+Wrwp9JezqAHW24=
X-Google-Smtp-Source: ABdhPJzLVv5NvPGHRYZGPyQVAXElIFuVfnuuHDOjWW3HloI/SBtJSbktaLDEP8iLpI4Mv1e1xKBR2LFEb+wBn77V2OQ=
X-Received: by 2002:a05:6e02:1526:: with SMTP id i6mr3159634ilu.299.1634818824315;
 Thu, 21 Oct 2021 05:20:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAOOPZo52azGXN-BzWamA38Gu=EkqZScLufM1VEgDuosPoH6TWA@mail.gmail.com>
 <20211020173729.GF16460@quack2.suse.cz> <CAOOPZo43cwh5ujm3n-r9Bih=7gS7Oav0B=J_8AepWDgdeBRkYA@mail.gmail.com>
 <20211021080304.GB5784@quack2.suse.cz> <61712B10.2060408@huawei.com>
In-Reply-To: <61712B10.2060408@huawei.com>
From:   Zhengyuan Liu <liuzhengyuang521@gmail.com>
Date:   Thu, 21 Oct 2021 20:20:13 +0800
Message-ID: <CAOOPZo4p8yWGc+ZsTE-cq=cjOxN_=_deb=ttTtmEup8MM6Kjrg@mail.gmail.com>
Subject: Re: Problem with direct IO
To:     yebin <yebin10@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, tytso@mit.edu,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org,
        =?UTF-8?B?5YiY5LqR?= <liuyun01@kylinos.cn>,
        Zhengyuan Liu <liuzhengyuan@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 21, 2021 at 4:55 PM yebin <yebin10@huawei.com> wrote:
>
>
>
> On 2021/10/21 16:03, Jan Kara wrote:
>
> On Thu 21-10-21 10:21:55, Zhengyuan Liu wrote:
>
> On Thu, Oct 21, 2021 at 1:37 AM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 13-10-21 09:46:46, Zhengyuan Liu wrote:
>
> we are encounting following Mysql crash problem while importing tables :
>
>     2021-09-26T11:22:17.825250Z 0 [ERROR] [MY-013622] [InnoDB] [FATAL]
>     fsync() returned EIO, aborting.
>     2021-09-26T11:22:17.825315Z 0 [ERROR] [MY-013183] [InnoDB]
>     Assertion failure: ut0ut.cc:555 thread 281472996733168
>
> At the same time , we found dmesg had following message:
>
>     [ 4328.838972] Page cache invalidation failure on direct I/O.
>     Possible data corruption due to collision with buffered I/O!
>     [ 4328.850234] File: /data/mysql/data/sysbench/sbtest53.ibd PID:
>     625 Comm: kworker/42:1
>
> Firstly, we doubled Mysql has operating the file with direct IO and
> buffered IO interlaced, but after some checking we found it did only
> do direct IO using aio. The problem is exactly from direct-io
> interface (__generic_file_write_iter) itself.
>
> ssize_t __generic_file_write_iter()
> {
> ...
>         if (iocb->ki_flags & IOCB_DIRECT) {
>                 loff_t pos, endbyte;
>
>                 written =3D generic_file_direct_write(iocb, from);
>                 /*
>                  * If the write stopped short of completing, fall back to
>                  * buffered writes.  Some filesystems do this for writes =
to
>                  * holes, for example.  For DAX files, a buffered write w=
ill
>                  * not succeed (even if it did, DAX does not handle dirty
>                  * page-cache pages correctly).
>                  */
>                 if (written < 0 || !iov_iter_count(from) || IS_DAX(inode)=
)
>                         goto out;
>
>                 status =3D generic_perform_write(file, from, pos =3D iocb=
->ki_pos);
> ...
> }
>
> From above code snippet we can see that direct io could fall back to
> buffered IO under certain conditions, so even Mysql only did direct IO
> it could interleave with buffered IO when fall back occurred. I have
> no idea why FS(ext3) failed the direct IO currently, but it is strange
> __generic_file_write_iter make direct IO fall back to buffered IO, it
> seems  breaking the semantics of direct IO.
>
> The reproduced  environment is:
> Platform:  Kunpeng 920 (arm64)
> Kernel: V5.15-rc
> PAGESIZE: 64K
> Mysql:  V8.0
> Innodb_page_size: default(16K)
>
> Thanks for report. I agree this should not happen. How hard is this to
> reproduce? Any idea whether the fallback to buffered IO happens because
> iomap_dio_rw() returns -ENOTBLK or because it returns short write?
>
> It is easy to reproduce in my test environment, as I said in the previous
> email replied to Andrew this problem is related to kernel page size.
>
> Ok, can you share a reproducer?
>
> Can you post output of "dumpe2fs -h <device>" for the filesystem where th=
e
> problem happens? Thanks!
>
> Sure, the output is:
>
> # dumpe2fs -h /dev/sda3
> dumpe2fs 1.45.3 (14-Jul-2019)
> Filesystem volume name:   <none>
> Last mounted on:          /data
> Filesystem UUID:          09a51146-b325-48bb-be63-c9df539a90a1
> Filesystem magic number:  0xEF53
> Filesystem revision #:    1 (dynamic)
> Filesystem features:      has_journal ext_attr resize_inode dir_index
> filetype needs_recovery sparse_super large_file
>
> Thanks for the data. OK, a filesystem without extents. Does your test by
> any chance try to do direct IO to a hole in a file? Because that is not
> (and never was) supported without extents. Also the fact that you don't s=
ee
> the problem with ext4 (which means extents support) would be pointing in
> that direction.
>
> Honza
>
>
> I try to reprodeuce this issue as follows, maybe this is just one scenari=
o :
> step1:  Modify  kernel code, add delay in dio_complete and dio_bio_end_ai=
o
> step2:  mkfs.ext4 /dev/sda
> step3:  mount /dev/sda  /home/test
> step4:  fio -filename=3D/home/test/test  -direct=3D0 -buffered=3D1 -iodep=
th 1 -thread -rw=3Dwrite -rwmixread=3D70 -ioengine=3Dlibaio -bs=3D4k -size=
=3D16k -numjobs=3D1 -name=3Dtest_r_w
> step5:  fio -filename=3D/home/test/test  -direct=3D1 -buffered=3D0 -iodep=
th 1 -thread -rw=3Dwrite -rwmixread=3D70 -ioengine=3Dlibaio -bs=3D4k -size=
=3D4k -numjobs=3D1 -name=3Dtest_r_w &
> step6:  fio -filename=3D/home/test/test  -direct=3D0 -buffered=3D1 -iodep=
th 1 -thread -rw=3Dwrite -rwmixread=3D70 -ioengine=3Dlibaio -bs=3D4k -size=
=3D16k -numjobs=3D1 -name=3Dtest_r_w

Hi, yebin

Thanks for your test case,  but it is not the same problem. The scenario yo=
u
described here is some thing the kernel design for, since you are intending=
 to
interleave buffered IO and direct IO, please look at this two patch:

332391a (=E2=80=9Cfs: Fix page cache inconsistency when mixing buffered and=
 AIO DIO=E2=80=9D)
5a9d929 (=E2=80=9Ciomap: report collisions between directio and buffered
writes to userspace=E2=80=9D)

>
> Kernel modification base on v4.19:
> diff --git a/fs/direct-io.c b/fs/direct-io.c
> +#include <linux/delay.h>
>
> /**
> @@ -305,6 +307,8 @@ static ssize_t dio_complete(struct dio *dio, ssize_t =
ret, unsigned int flags)
>          * end_io() when necessary, otherwise a racing buffer read would =
cache
>          * zeros from unwritten extents.
>          */
> +       printk("%s: before invalidate page \n", __func__);
> +       mdelay(10 * 1000);
>         if (flags & DIO_COMPLETE_INVALIDATE &&
>             ret > 0 && dio->op =3D=3D REQ_OP_WRITE &&
>             dio->inode->i_mapping->nrpages) {
> @@ -314,6 +318,7 @@ static ssize_t dio_complete(struct dio *dio, ssize_t =
ret, unsigned int flags)
>                 if (err)
>                         dio_warn_stale_pagecache(dio->iocb->ki_filp);
>         }
> +       printk("%s: end invalidate page \n", __func__);
>
>         inode_dio_end(dio->inode);
>
> @@ -371,10 +378,17 @@ static void dio_bio_end_aio(struct bio *bio)
>                  * went in between AIO submission and completion into the
>                  * same region.
>                  */
> +               printk("%s:start to  sleep 5s.... \n", __func__);
> +               mdelay(10 * 1000);
> +               printk("%s: endto  sleep, defer_completion=3D%d op=3D%d n=
rpages=3D%d\n",
> +                       __func__,dio->defer_completion, dio->op, dio->ino=
de->i_mapping->nrpages);
> +
>                 if (dio->result)
>                         defer_completion =3D dio->defer_completion ||
>                                            (dio->op =3D=3D REQ_OP_WRITE &=
&
>                                             dio->inode->i_mapping->nrpage=
s);
> +               printk("%s: dio=3D%px defer_completion=3D%d\n",
> +                       __func__, dio, defer_completion);
>                 if (defer_completion) {
>                         INIT_WORK(&dio->complete_work, dio_aio_complete_w=
ork);
>                         queue_work(dio->inode->i_sb->s_dio_done_wq,
>
>
> Reproduce result =EF=BC=9A
> s=3D1 -name=3Dtest_r_w=3Dwrite -rwmixread=3D70 -ioengine=3Dlibaio -bs=3D4=
k -size=3D16k -numjob
> test_r_w: (g=3D0): rw=3Dwrite, bs=3D(R) 4096B-4096B, (W) 4096B-4096B, (T)=
 4096B-4096B, ioengine=3Dlibaio, iodepth=3D1
> fio-3.7
> Starting 1 thread
> test_r_w: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D2083: Sun Sep 26 03:18=
:06 2021
>   write: IOPS=3D444, BW=3D1778KiB/s (1820kB/s)(16.0KiB/9msec)
>     slat (usec): min=3D1294, max=3D3789, avg=3D2007.88, stdev=3D1191.07
>     clat (nsec): min=3D2304, max=3D28645, avg=3D9918.75, stdev=3D12574.80
>      lat (usec): min=3D1298, max=3D3824, avg=3D2020.36, stdev=3D1206.00
>     clat percentiles (nsec):
>      |  1.00th=3D[ 2320],  5.00th=3D[ 2320], 10.00th=3D[ 2320], 20.00th=
=3D[ 2320],
>      | 30.00th=3D[ 2960], 40.00th=3D[ 2960], 50.00th=3D[ 2960], 60.00th=
=3D[ 5792],
>      | 70.00th=3D[ 5792], 80.00th=3D[28544], 90.00th=3D[28544], 95.00th=
=3D[28544],
>      | 99.00th=3D[28544], 99.50th=3D[28544], 99.90th=3D[28544], 99.95th=
=3D[28544],
>      | 99.99th=3D[28544]
>   lat (usec)   : 4=3D50.00%, 10=3D25.00%, 50=3D25.00%
>   cpu          : usr=3D0.00%, sys=3D87.50%, ctx=3D0, majf=3D0, minf=3D1
>   IO depths    : 1=3D100.0%, 2=3D0.0%, 4=3D0.0%, 8=3D0.0%, 16=3D0.0%, 32=
=3D0.0%, >=3D64=3D0.0%
>      submit    : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=
=3D0.0%, >=3D64=3D0.0%
>      complete  : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=
=3D0.0%, >=3D64=3D0.0%
>      issued rwts: total=3D0,4,0,0 short=3D0,0,0,0 dropped=3D0,0,0,0
>      latency   : target=3D0, window=3D0, percentile=3D100.00%, depth=3D1
>
> Run status group 0 (all jobs):
>   WRITE: bw=3D1778KiB/s (1820kB/s), 1778KiB/s-1778KiB/s (1820kB/s-1820kB/=
s), io=3D16.0KiB (16.4kB), run=3D9-9msec
>
> Disk stats (read/write):
>   sda: ios=3D0/0, merge=3D0/0, ticks=3D0/0, in_queue=3D0, util=3D0.00%
> =3D1 -name=3Dtest_r_w &write -rwmixread=3D70 -ioengine=3Dlibaio -bs=3D4k =
-size=3D4k -numjobs
> [1] 2087
> [root@localhost home]# test_r_w: (g=3D0): rw=3Dwrite, bs=3D(R) 4096B-4096=
B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=3Dlibaio, iodepth=3D1
> fio-3.7
> Starting 1 thread
>
> [root@localhost home]# [ 1475.286928] ext4_file_write_iter: start lock in=
ode
> [ 1475.288807] ext4_file_write_iter: unlock inode
> [ 1475.290402] dio_bio_end_aio:start to  sleep 5s....
>
> s=3D1 -name=3Dtest_r_w=3Dwrite -rwmixread=3D70 -ioengine=3Dlibaio -bs=3D4=
k -size=3D16k -numjob
> test_r_w: (g=3D0): rw=3Dwrite, bs=3D(R) 4096B-4096B, (W) 4096B-4096B, (T)=
 4096B-4096B, ioengine=3Dlibaio, iodepth=3D1
> fio-3.7
> Starting 1 thread
> Jobs: 1 (f=3D0): [f(1)][-.-%][r=3D0KiB/s,w=3D0KiB/s][r=3D0,w=3D0 IOPS][et=
a 00m:00s]
> Jobs: 1 (f=3D0): [f(1)][-.-%][r=3D0KiB/s,w=3D0KiB/s][r=3D0,w=3D0 IOPS][et=
a 00m:00s]
> [ 1485.292939] dio_bio_end_aio: endto  sleep, defer_completion=3D0 op=3D1=
 nrpages=3D4
> [ 1485.293888] dio_bio_end_aio: dio=3Dffff88839aff5200 defer_completion=
=3D1
> [ 1485.294821] dio_aio_complete_work: dio=3Dffff88839aff5200...
> Jobs: 1 (f=3D1): [W(1)][-.-%][r=3D0KiB/s,w=3D0KiB/s][r[ 1485.296539] dio_=
complete: before invalidate page
> [ 1495.298472] Page cache invalidation failure on direct I/O.  Possible d=
ata corruption due to collision with buffered I/O!     -->detect  buffer io=
 and direct io conflict.
> [ 1495.302746] File: /home/test/test PID: 493 Comm: kworker/3:2
> [ 1495.303508] CPU: 3 PID: 493 Comm: kworker/3:2 Not tainted 4.19.90-dirt=
y #96
> [ 1495.304386] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S ?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproject.org-3.fc31 04/01/2=
014
> Jobs: 1 (f=3D1): [[ 1495.306050] Workqueue: dio/sda dio_aio_complete_work
> W(1)][-.-%][r=3D0K
> [ 1495.316879] dio_complete: end invalidate page
> test_r_w: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D2092: Sun Sep 26 03:18=
:37 2021
>   write: IOPS=3D266, BW=3D1067KiB/s (1092kB/s)(16.0KiB/15msec)
>     slat (usec): min=3D2001, max=3D3101, avg=3D2691.97, stdev=3D480.07
>     clat (nsec): min=3D2058, max=3D12337, avg=3D5999.50, stdev=3D4456.54
>      lat (usec): min=3D2004, max=3D3116, avg=3D2700.11, stdev=3D484.22
>     clat percentiles (nsec):
>      |  1.00th=3D[ 2064],  5.00th=3D[ 2064], 10.00th=3D[ 2064], 20.00th=
=3D[ 2064],
>      | 30.00th=3D[ 4080], 40.00th=3D[ 4080], 50.00th=3D[ 4080], 60.00th=
=3D[ 5536],
>      | 70.00th=3D[ 5536], 80.00th=3D[12352], 90.00th=3D[12352], 95.00th=
=3D[12352],
>      | 99.00th=3D[12352], 99.50th=3D[12352], 99.90th=3D[12352], 99.95th=
=3D[12352],
>      | 99.99th=3D[12352]
>   lat (usec)   : 4=3D25.00%, 10=3D50.00%, 20=3D25.00%
>   cpu          : usr=3D0.00%, sys=3D100.00%, ctx=3D1, majf=3D0, minf=3D1
>   IO depths    : 1=3D100.0%, 2=3D0.0%, 4=3D0.0%, 8=3D0.0%, 16=3D0.0%, 32=
=3D0.0%, >=3D64=3D0.0%
>      submit    : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=
=3D0.0%, >=3D64=3D0.0%
>      complete  : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=
=3D0.0%, >=3D64=3D0.0%
>      issued rwts: total=3D0,4,0,0 short=3D0,0,0,0 dropped=3D0,0,0,0
>      latency   : target=3D0, window=3D0, percentile=3D100.00%, depth=3D1
>
> Run status group 0 (all jobs):
>   WRITE: bw=3D1067KiB/s (1092kB/s), 1067KiB/s-1067KiB/s (1092kB/s-1092kB/=
s), io=3D16.0KiB (16.4kB), run=3D15-15msec
>
> Disk stats (read/write):
>   sda: ios=3D0/0, merge=3D0/0, ticks=3D0/0, in_queue=3D0, util=3D0.00%
>
> test_r_w: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D2089: Sun Sep 26 03:18=
:37 2021
>   write: IOPS=3D0, BW=3D204B/s (204B/s)(4096B/20033msec)
>     slat (nsec): min=3D3358.7k, max=3D3358.7k, avg=3D3358748.00, stdev=3D=
 0.00
>     clat (nsec): min=3D20027M, max=3D20027M, avg=3D20027265355.00, stdev=
=3D 0.00
>      lat (nsec): min=3D20031M, max=3D20031M, avg=3D20030627283.00, stdev=
=3D 0.00
>     clat percentiles (msec):
>      |  1.00th=3D[17113],  5.00th=3D[17113], 10.00th=3D[17113], 20.00th=
=3D[17113],
>      | 30.00th=3D[17113], 40.00th=3D[17113], 50.00th=3D[17113], 60.00th=
=3D[17113],
>      | 70.00th=3D[17113], 80.00th=3D[17113], 90.00th=3D[17113], 95.00th=
=3D[17113],
>      | 99.00th=3D[17113], 99.50th=3D[17113], 99.90th=3D[17113], 99.95th=
=3D[17113],
>      | 99.99th=3D[17113]
>   cpu          : usr=3D0.00%, sys=3D0.02%, ctx=3D2, majf=3D0, minf=3D1
>   IO depths    : 1=3D100.0%, 2=3D0.0%, 4=3D0.0%, 8=3D0.0%, 16=3D0.0%, 32=
=3D0.0%, >=3D64=3D0.0%
>      submit    : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=
=3D0.0%, >=3D64=3D0.0%
>      complete  : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=
=3D0.0%, >=3D64=3D0.0%
>      issued rwts: total=3D0,1,0,0 short=3D0,0,0,0 dropped=3D0,0,0,0
>      latency   : target=3D0, window=3D0, percentile=3D100.00%, depth=3D1
>
> Run status group 0 (all jobs):
>   WRITE: bw=3D204B/s (204B/s), 204B/s-204B/s (204B/s-204B/s), io=3D4096B =
(4096B), run=3D20033-20033msec
>
> Disk stats (read/write):
>   sda: ios=3D0/5, merge=3D0/1, ticks=3D0/10018, in_queue=3D10015, util=3D=
36.98%
>
>
>
