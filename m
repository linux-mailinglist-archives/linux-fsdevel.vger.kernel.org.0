Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F3657D22B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jul 2022 19:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiGURDn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jul 2022 13:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiGURDl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jul 2022 13:03:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA9D52E77;
        Thu, 21 Jul 2022 10:03:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EBD14B8258F;
        Thu, 21 Jul 2022 17:03:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C82C3411E;
        Thu, 21 Jul 2022 17:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658423017;
        bh=MEAgg5xlrSHfw/vB4g6gAKIOOIm5YlQdbo6WnU3fPZg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=An2Lwwt92uepwUVcj/p4G2J4HnEQIBfCm/MNLeQVKlwYrJ+NeK5RKbOGjr3rMNxRL
         LksKCwP1/f1kK8cqD31t8+SRx0pjGAuSuaNJUo5oJ6QDPSyCwCPfrZxEQTBj80JigI
         3pE4fYDkQGVmR/s3T8Ilms7GC2eS+aiJLiKqjgVgLvodEM1PWsQHuERpMo8r3+YTTE
         zBFzWE7ahkjDal9SMOujhg/uYj/zxGxcglDRnhsHoIp3CjFAuvhsEDMRLyBpKQyOn0
         d/EY9aEGbBhRHDyqsYSHApK8+bi004OLTI2XwcArTX3e5XaFx6saku/hfkreJdeALZ
         oLsRJYlFGDxWQ==
Message-ID: <b4fc03c6c770e0f91f546619741c6a98361f2316.camel@kernel.org>
Subject: Re: should we make "-o iversion" the default on ext4 ?
From:   Jeff Layton <jlayton@kernel.org>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>
Date:   Thu, 21 Jul 2022 13:03:35 -0400
In-Reply-To: <20220721140606.btqznsqqdpn4h3wm@fedora>
References: <69ac1d3ef0f63b309204a570ef4922d2684ed7f9.camel@kernel.org>
         <20220720141546.46l2d7bxwukjhtl7@fedora>
         <ad7218a41fa8ac26911a9ccb79c87609d4279fea.camel@kernel.org>
         <20220720152257.t67grnm4wdi3dpld@fedora>
         <5533aca629bf17b517e33f0b7edb02550b7548a7.camel@kernel.org>
         <20220721140606.btqznsqqdpn4h3wm@fedora>
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

On Thu, 2022-07-21 at 16:06 +0200, Lukas Czerner wrote:
> On Wed, Jul 20, 2022 at 12:42:11PM -0400, Jeff Layton wrote:
> > On Wed, 2022-07-20 at 17:22 +0200, Lukas Czerner wrote:
> >=20
> > >  But not zero, at least
> > > every time the inode is loaded from disk it is scheduled for i_versio=
n
> > > update on the next attempted increment. Could that have an effect on
> > > some particular common workload you can think of?
> > >=20
> >=20
> > FWIW, it's doubtful that you'd even notice this. You'd almost certainly
> > be updating the mtime or ctime on the next change anyway, so updating
> > the i_version in that case is basically free. You will probably need to
> > do some a few extra atomic in-memory operations, but that's probably no=
t
> > noticeable in something I/O constrained.
> >=20
> > >=20
> > > Could you provide some performance numbers for iversion case?
> > >=20
> >=20
> > I'm writing to a LVM volume on a no-name-brand ssd I have sitting
> > around. fio jobfile is here:
>=20
> That's very simplistic test, but fair enough. I've ran 10 iterations of
> xfstests with and without iversion and there is no significant
> difference, in fact it's all well within run by run variation. That's
> true in aggregate as well for individual tests.
>=20

Yeah. This change was most evident with small I/O sizes, so if there is
an effect here it'll likely show up there.
=20
> However there are problems to solve before we attempt to make it a
> default. With -o iversion ext4/026 and generic/622 fails. The ext4/026
> seems to be a real bug and I am not sure about the other one yet.
>=20
> I'll look into it.
>=20

Interesting, thanks. Lack of testing with that option enabled is
probably another good reason to go ahead and make it the default. Let me
know what you find.

> -Lukas
>=20
> >=20
> > [global]
> > name=3Dfio-seq-write
> > filename=3Dfio-seq-write
> > rw=3Dwrite
> > bs=3D4k
> > direct=3D0
> > numjobs=3D1
> > time_based
> > runtime=3D300
> >=20
> > [file1]
> > size=3D1G
> > ioengine=3Dlibaio
> > iodepth=3D16
> >=20
> > iversion support disabled:
> >=20
> > $ fio ./4k-write.fio
> > file1: (g=3D0): rw=3Dwrite, bs=3D(R) 4096B-4096B, (W) 4096B-4096B, (T) =
4096B-4096B, ioengine=3Dlibaio, iodepth=3D16
> > fio-3.27
> > Starting 1 process
> > file1: Laying out IO file (1 file / 1024MiB)
> > Jobs: 1 (f=3D1): [W(1)][100.0%][w=3D52.5MiB/s][w=3D13.4k IOPS][eta 00m:=
00s]
> > file1: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D10056: Wed Jul 20 12:28=
:21 2022
> >   write: IOPS=3D96.3k, BW=3D376MiB/s (394MB/s)(110GiB/300001msec); 0 zo=
ne resets
> >     slat (nsec): min=3D1112, max=3D5727.5k, avg=3D1917.70, stdev=3D1300=
.30
> >     clat (nsec): min=3D1112, max=3D2146.5M, avg=3D156067.38, stdev=3D15=
568002.13
> >      lat (usec): min=3D3, max=3D2146.5k, avg=3D158.03, stdev=3D15568.00
> >     clat percentiles (usec):
> >      |  1.00th=3D[   36],  5.00th=3D[   36], 10.00th=3D[   37], 20.00th=
=3D[   37],
> >      | 30.00th=3D[   38], 40.00th=3D[   38], 50.00th=3D[   38], 60.00th=
=3D[   39],
> >      | 70.00th=3D[   39], 80.00th=3D[   40], 90.00th=3D[   42], 95.00th=
=3D[   44],
> >      | 99.00th=3D[   52], 99.50th=3D[   59], 99.90th=3D[   77], 99.95th=
=3D[   88],
> >      | 99.99th=3D[  169]
> >    bw (  KiB/s): min=3D15664, max=3D1599456, per=3D100.00%, avg=3D89776=
1.07, stdev=3D504329.17, samples=3D257
> >    iops        : min=3D 3916, max=3D399864, avg=3D224440.26, stdev=3D12=
6082.33, samples=3D257
> >   lat (usec)   : 2=3D0.01%, 4=3D0.01%, 10=3D0.01%, 20=3D0.01%, 50=3D98.=
80%
> >   lat (usec)   : 100=3D1.18%, 250=3D0.02%, 500=3D0.01%
> >   lat (msec)   : 10=3D0.01%, 2000=3D0.01%, >=3D2000=3D0.01%
> >   cpu          : usr=3D5.45%, sys=3D23.92%, ctx=3D78418, majf=3D0, minf=
=3D14
> >   IO depths    : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D100.0%, 3=
2=3D0.0%, >=3D64=3D0.0%
> >      submit    : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, =
64=3D0.0%, >=3D64=3D0.0%
> >      complete  : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.1%, 32=3D0.0%, =
64=3D0.0%, >=3D64=3D0.0%
> >      issued rwts: total=3D0,28889786,0,0 short=3D0,0,0,0 dropped=3D0,0,=
0,0
> >      latency   : target=3D0, window=3D0, percentile=3D100.00%, depth=3D=
16
> >=20
> > Run status group 0 (all jobs):
> >   WRITE: bw=3D376MiB/s (394MB/s), 376MiB/s-376MiB/s (394MB/s-394MB/s), =
io=3D110GiB (118GB), run=3D300001-300001msec
> >=20
> > Disk stats (read/write):
> >     dm-7: ios=3D0/22878, merge=3D0/0, ticks=3D0/373254, in_queue=3D3732=
54, util=3D43.89%, aggrios=3D0/99746, aggrmerge=3D0/9246, aggrticks=3D0/140=
6831, aggrin_queue=3D1408420, aggrutil=3D73.56%
> >   sda: ios=3D0/99746, merge=3D0/9246, ticks=3D0/1406831, in_queue=3D140=
8420, util=3D73.56%
> >=20
> > mounted with -o iversion:
> >=20
> > $ fio ./4k-write.fio
> > file1: (g=3D0): rw=3Dwrite, bs=3D(R) 4096B-4096B, (W) 4096B-4096B, (T) =
4096B-4096B, ioengine=3Dlibaio, iodepth=3D16
> > fio-3.27
> > Starting 1 process
> > Jobs: 1 (f=3D1): [W(1)][100.0%][eta 00m:00s]                         =
=20
> > file1: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D10369: Wed Jul 20 12:33=
:57 2022
> >   write: IOPS=3D96.2k, BW=3D376MiB/s (394MB/s)(110GiB/300001msec); 0 zo=
ne resets
> >     slat (nsec): min=3D1112, max=3D1861.5k, avg=3D1994.58, stdev=3D890.=
78
> >     clat (nsec): min=3D1392, max=3D2113.3M, avg=3D156252.71, stdev=3D15=
409487.99
> >      lat (usec): min=3D3, max=3D2113.3k, avg=3D158.30, stdev=3D15409.49
> >     clat percentiles (usec):
> >      |  1.00th=3D[   37],  5.00th=3D[   38], 10.00th=3D[   38], 20.00th=
=3D[   38],
> >      | 30.00th=3D[   39], 40.00th=3D[   39], 50.00th=3D[   40], 60.00th=
=3D[   40],
> >      | 70.00th=3D[   41], 80.00th=3D[   42], 90.00th=3D[   43], 95.00th=
=3D[   45],
> >      | 99.00th=3D[   53], 99.50th=3D[   60], 99.90th=3D[   79], 99.95th=
=3D[   90],
> >      | 99.99th=3D[  174]
> >    bw (  KiB/s): min=3D  304, max=3D1540000, per=3D100.00%, avg=3D87072=
7.42, stdev=3D499371.78, samples=3D265
> >    iops        : min=3D   76, max=3D385000, avg=3D217681.82, stdev=3D12=
4842.94, samples=3D265
> >   lat (usec)   : 2=3D0.01%, 4=3D0.01%, 10=3D0.01%, 20=3D0.01%, 50=3D98.=
49%
> >   lat (usec)   : 100=3D1.48%, 250=3D0.02%, 500=3D0.01%
> >   lat (msec)   : 2=3D0.01%, 2000=3D0.01%, >=3D2000=3D0.01%
> >   cpu          : usr=3D5.71%, sys=3D24.49%, ctx=3D52874, majf=3D0, minf=
=3D18
> >   IO depths    : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D100.0%, 3=
2=3D0.0%, >=3D64=3D0.0%
> >      submit    : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, =
64=3D0.0%, >=3D64=3D0.0%
> >      complete  : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.1%, 32=3D0.0%, =
64=3D0.0%, >=3D64=3D0.0%
> >      issued rwts: total=3D0,28856695,0,0 short=3D0,0,0,0 dropped=3D0,0,=
0,0
> >      latency   : target=3D0, window=3D0, percentile=3D100.00%, depth=3D=
16
> >=20
> > Run status group 0 (all jobs):
> >   WRITE: bw=3D376MiB/s (394MB/s), 376MiB/s-376MiB/s (394MB/s-394MB/s), =
io=3D110GiB (118GB), run=3D300001-300001msec
> >=20
> > Disk stats (read/write):
> >     dm-7: ios=3D1/16758, merge=3D0/0, ticks=3D2/341817, in_queue=3D3418=
19, util=3D47.93%, aggrios=3D1/98153, aggrmerge=3D0/5691, aggrticks=3D2/139=
9496, aggrin_queue=3D1400893, aggrutil=3D73.42%
> >   sda: ios=3D1/98153, merge=3D0/5691, ticks=3D2/1399496, in_queue=3D140=
0893, util=3D73.42%
> >=20
> > --=20
> > Jeff Layton <jlayton@kernel.org>
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
