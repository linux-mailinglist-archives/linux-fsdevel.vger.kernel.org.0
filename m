Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131AD57BB98
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 18:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbiGTQmR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jul 2022 12:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiGTQmP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jul 2022 12:42:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3833131DE0;
        Wed, 20 Jul 2022 09:42:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC0AA61DBC;
        Wed, 20 Jul 2022 16:42:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A35C3411E;
        Wed, 20 Jul 2022 16:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658335333;
        bh=mTegQOzIOpQxL50GoSaaIccRcKu47GFhDUvoenat/Qg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mIclhrT24YNQZ3U+0rGjxi30uz/kfkify821mfC9Vtx1WfGwFTIrOVmlMYZ3p51fT
         zEh2H0tRApJK0TqoXUII/UekMgl8qMic9B6zEgUBucqt4LmxFZSWRBxXpOJYeP+AJO
         0geBGHLasD8V/PjQnHMiA0WGOCUzcCFOWnbKl4X69nSr2gxTX9SukEPUJCMER8kpzE
         cHYwFCI0PzjXhSaeXe8DcajUI/PpgCBSXeGj2XEzji/lvGg+sTaUC8kqlzrbjobttt
         qQd13dT+kkieVKcU+HhhYbCQCCDrIfCs6IG6qOjzAqH2p3nBwz+5AifXq9NA8OOMZr
         2RUGmW+mLHvOw==
Message-ID: <5533aca629bf17b517e33f0b7edb02550b7548a7.camel@kernel.org>
Subject: Re: should we make "-o iversion" the default on ext4 ?
From:   Jeff Layton <jlayton@kernel.org>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>
Date:   Wed, 20 Jul 2022 12:42:11 -0400
In-Reply-To: <20220720152257.t67grnm4wdi3dpld@fedora>
References: <69ac1d3ef0f63b309204a570ef4922d2684ed7f9.camel@kernel.org>
         <20220720141546.46l2d7bxwukjhtl7@fedora>
         <ad7218a41fa8ac26911a9ccb79c87609d4279fea.camel@kernel.org>
         <20220720152257.t67grnm4wdi3dpld@fedora>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2022-07-20 at 17:22 +0200, Lukas Czerner wrote:

>  But not zero, at least
> every time the inode is loaded from disk it is scheduled for i_version
> update on the next attempted increment. Could that have an effect on
> some particular common workload you can think of?
>=20

FWIW, it's doubtful that you'd even notice this. You'd almost certainly
be updating the mtime or ctime on the next change anyway, so updating
the i_version in that case is basically free. You will probably need to
do some a few extra atomic in-memory operations, but that's probably not
noticeable in something I/O constrained.

>=20
> Could you provide some performance numbers for iversion case?
>=20

I'm writing to a LVM volume on a no-name-brand ssd I have sitting
around. fio jobfile is here:

[global]
name=3Dfio-seq-write
filename=3Dfio-seq-write
rw=3Dwrite
bs=3D4k
direct=3D0
numjobs=3D1
time_based
runtime=3D300

[file1]
size=3D1G
ioengine=3Dlibaio
iodepth=3D16

iversion support disabled:

$ fio ./4k-write.fio
file1: (g=3D0): rw=3Dwrite, bs=3D(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096=
B-4096B, ioengine=3Dlibaio, iodepth=3D16
fio-3.27
Starting 1 process
file1: Laying out IO file (1 file / 1024MiB)
Jobs: 1 (f=3D1): [W(1)][100.0%][w=3D52.5MiB/s][w=3D13.4k IOPS][eta 00m:00s]
file1: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D10056: Wed Jul 20 12:28:21 =
2022
  write: IOPS=3D96.3k, BW=3D376MiB/s (394MB/s)(110GiB/300001msec); 0 zone r=
esets
    slat (nsec): min=3D1112, max=3D5727.5k, avg=3D1917.70, stdev=3D1300.30
    clat (nsec): min=3D1112, max=3D2146.5M, avg=3D156067.38, stdev=3D155680=
02.13
     lat (usec): min=3D3, max=3D2146.5k, avg=3D158.03, stdev=3D15568.00
    clat percentiles (usec):
     |  1.00th=3D[   36],  5.00th=3D[   36], 10.00th=3D[   37], 20.00th=3D[=
   37],
     | 30.00th=3D[   38], 40.00th=3D[   38], 50.00th=3D[   38], 60.00th=3D[=
   39],
     | 70.00th=3D[   39], 80.00th=3D[   40], 90.00th=3D[   42], 95.00th=3D[=
   44],
     | 99.00th=3D[   52], 99.50th=3D[   59], 99.90th=3D[   77], 99.95th=3D[=
   88],
     | 99.99th=3D[  169]
   bw (  KiB/s): min=3D15664, max=3D1599456, per=3D100.00%, avg=3D897761.07=
, stdev=3D504329.17, samples=3D257
   iops        : min=3D 3916, max=3D399864, avg=3D224440.26, stdev=3D126082=
.33, samples=3D257
  lat (usec)   : 2=3D0.01%, 4=3D0.01%, 10=3D0.01%, 20=3D0.01%, 50=3D98.80%
  lat (usec)   : 100=3D1.18%, 250=3D0.02%, 500=3D0.01%
  lat (msec)   : 10=3D0.01%, 2000=3D0.01%, >=3D2000=3D0.01%
  cpu          : usr=3D5.45%, sys=3D23.92%, ctx=3D78418, majf=3D0, minf=3D1=
4
  IO depths    : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D100.0%, 32=3D=
0.0%, >=3D64=3D0.0%
     submit    : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=
=3D0.0%, >=3D64=3D0.0%
     complete  : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.1%, 32=3D0.0%, 64=
=3D0.0%, >=3D64=3D0.0%
     issued rwts: total=3D0,28889786,0,0 short=3D0,0,0,0 dropped=3D0,0,0,0
     latency   : target=3D0, window=3D0, percentile=3D100.00%, depth=3D16

Run status group 0 (all jobs):
  WRITE: bw=3D376MiB/s (394MB/s), 376MiB/s-376MiB/s (394MB/s-394MB/s), io=
=3D110GiB (118GB), run=3D300001-300001msec

Disk stats (read/write):
    dm-7: ios=3D0/22878, merge=3D0/0, ticks=3D0/373254, in_queue=3D373254, =
util=3D43.89%, aggrios=3D0/99746, aggrmerge=3D0/9246, aggrticks=3D0/1406831=
, aggrin_queue=3D1408420, aggrutil=3D73.56%
  sda: ios=3D0/99746, merge=3D0/9246, ticks=3D0/1406831, in_queue=3D1408420=
, util=3D73.56%

mounted with -o iversion:

$ fio ./4k-write.fio
file1: (g=3D0): rw=3Dwrite, bs=3D(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096=
B-4096B, ioengine=3Dlibaio, iodepth=3D16
fio-3.27
Starting 1 process
Jobs: 1 (f=3D1): [W(1)][100.0%][eta 00m:00s]                         =20
file1: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D10369: Wed Jul 20 12:33:57 =
2022
  write: IOPS=3D96.2k, BW=3D376MiB/s (394MB/s)(110GiB/300001msec); 0 zone r=
esets
    slat (nsec): min=3D1112, max=3D1861.5k, avg=3D1994.58, stdev=3D890.78
    clat (nsec): min=3D1392, max=3D2113.3M, avg=3D156252.71, stdev=3D154094=
87.99
     lat (usec): min=3D3, max=3D2113.3k, avg=3D158.30, stdev=3D15409.49
    clat percentiles (usec):
     |  1.00th=3D[   37],  5.00th=3D[   38], 10.00th=3D[   38], 20.00th=3D[=
   38],
     | 30.00th=3D[   39], 40.00th=3D[   39], 50.00th=3D[   40], 60.00th=3D[=
   40],
     | 70.00th=3D[   41], 80.00th=3D[   42], 90.00th=3D[   43], 95.00th=3D[=
   45],
     | 99.00th=3D[   53], 99.50th=3D[   60], 99.90th=3D[   79], 99.95th=3D[=
   90],
     | 99.99th=3D[  174]
   bw (  KiB/s): min=3D  304, max=3D1540000, per=3D100.00%, avg=3D870727.42=
, stdev=3D499371.78, samples=3D265
   iops        : min=3D   76, max=3D385000, avg=3D217681.82, stdev=3D124842=
.94, samples=3D265
  lat (usec)   : 2=3D0.01%, 4=3D0.01%, 10=3D0.01%, 20=3D0.01%, 50=3D98.49%
  lat (usec)   : 100=3D1.48%, 250=3D0.02%, 500=3D0.01%
  lat (msec)   : 2=3D0.01%, 2000=3D0.01%, >=3D2000=3D0.01%
  cpu          : usr=3D5.71%, sys=3D24.49%, ctx=3D52874, majf=3D0, minf=3D1=
8
  IO depths    : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D100.0%, 32=3D=
0.0%, >=3D64=3D0.0%
     submit    : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=
=3D0.0%, >=3D64=3D0.0%
     complete  : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.1%, 32=3D0.0%, 64=
=3D0.0%, >=3D64=3D0.0%
     issued rwts: total=3D0,28856695,0,0 short=3D0,0,0,0 dropped=3D0,0,0,0
     latency   : target=3D0, window=3D0, percentile=3D100.00%, depth=3D16

Run status group 0 (all jobs):
  WRITE: bw=3D376MiB/s (394MB/s), 376MiB/s-376MiB/s (394MB/s-394MB/s), io=
=3D110GiB (118GB), run=3D300001-300001msec

Disk stats (read/write):
    dm-7: ios=3D1/16758, merge=3D0/0, ticks=3D2/341817, in_queue=3D341819, =
util=3D47.93%, aggrios=3D1/98153, aggrmerge=3D0/5691, aggrticks=3D2/1399496=
, aggrin_queue=3D1400893, aggrutil=3D73.42%
  sda: ios=3D1/98153, merge=3D0/5691, ticks=3D2/1399496, in_queue=3D1400893=
, util=3D73.42%

--=20
Jeff Layton <jlayton@kernel.org>
