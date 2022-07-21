Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672B657CCD5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jul 2022 16:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiGUOG2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jul 2022 10:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiGUOGX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:06:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7BCB61F602
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jul 2022 07:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658412381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=thw1S0e0Dg+KcPwvjZ5RpwYG+skkK1oazdujMWDMVCc=;
        b=H9xv3dg6TyXa6Id1Fns0FeoFkGQmLhT+YRArEit4zhXhdqBiYrBJ8gfYXA/YDEVSOK3YmA
        G/Lo7lxI/D/744nFJZ6MmjMb9w8YZQenCy/XD9+t9ohJPF6kXAMg0fO7MvUeR0iW/+SffJ
        gGdGTQCKeTCcq9XQzpV0mMMSVOp8cLU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-eLm3LXfOPwqouxzbLDmtuQ-1; Thu, 21 Jul 2022 10:06:10 -0400
X-MC-Unique: eLm3LXfOPwqouxzbLDmtuQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ECEF33806649;
        Thu, 21 Jul 2022 14:06:09 +0000 (UTC)
Received: from fedora (unknown [10.40.194.108])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C44DF40D2962;
        Thu, 21 Jul 2022 14:06:08 +0000 (UTC)
Date:   Thu, 21 Jul 2022 16:06:06 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>
Subject: Re: should we make "-o iversion" the default on ext4 ?
Message-ID: <20220721140606.btqznsqqdpn4h3wm@fedora>
References: <69ac1d3ef0f63b309204a570ef4922d2684ed7f9.camel@kernel.org>
 <20220720141546.46l2d7bxwukjhtl7@fedora>
 <ad7218a41fa8ac26911a9ccb79c87609d4279fea.camel@kernel.org>
 <20220720152257.t67grnm4wdi3dpld@fedora>
 <5533aca629bf17b517e33f0b7edb02550b7548a7.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5533aca629bf17b517e33f0b7edb02550b7548a7.camel@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 20, 2022 at 12:42:11PM -0400, Jeff Layton wrote:
> On Wed, 2022-07-20 at 17:22 +0200, Lukas Czerner wrote:
> 
> >  But not zero, at least
> > every time the inode is loaded from disk it is scheduled for i_version
> > update on the next attempted increment. Could that have an effect on
> > some particular common workload you can think of?
> > 
> 
> FWIW, it's doubtful that you'd even notice this. You'd almost certainly
> be updating the mtime or ctime on the next change anyway, so updating
> the i_version in that case is basically free. You will probably need to
> do some a few extra atomic in-memory operations, but that's probably not
> noticeable in something I/O constrained.
> 
> > 
> > Could you provide some performance numbers for iversion case?
> > 
> 
> I'm writing to a LVM volume on a no-name-brand ssd I have sitting
> around. fio jobfile is here:

That's very simplistic test, but fair enough. I've ran 10 iterations of
xfstests with and without iversion and there is no significant
difference, in fact it's all well within run by run variation. That's
true in aggregate as well for individual tests.

However there are problems to solve before we attempt to make it a
default. With -o iversion ext4/026 and generic/622 fails. The ext4/026
seems to be a real bug and I am not sure about the other one yet.

I'll look into it.

-Lukas

> 
> [global]
> name=fio-seq-write
> filename=fio-seq-write
> rw=write
> bs=4k
> direct=0
> numjobs=1
> time_based
> runtime=300
> 
> [file1]
> size=1G
> ioengine=libaio
> iodepth=16
> 
> iversion support disabled:
> 
> $ fio ./4k-write.fio
> file1: (g=0): rw=write, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
> fio-3.27
> Starting 1 process
> file1: Laying out IO file (1 file / 1024MiB)
> Jobs: 1 (f=1): [W(1)][100.0%][w=52.5MiB/s][w=13.4k IOPS][eta 00m:00s]
> file1: (groupid=0, jobs=1): err= 0: pid=10056: Wed Jul 20 12:28:21 2022
>   write: IOPS=96.3k, BW=376MiB/s (394MB/s)(110GiB/300001msec); 0 zone resets
>     slat (nsec): min=1112, max=5727.5k, avg=1917.70, stdev=1300.30
>     clat (nsec): min=1112, max=2146.5M, avg=156067.38, stdev=15568002.13
>      lat (usec): min=3, max=2146.5k, avg=158.03, stdev=15568.00
>     clat percentiles (usec):
>      |  1.00th=[   36],  5.00th=[   36], 10.00th=[   37], 20.00th=[   37],
>      | 30.00th=[   38], 40.00th=[   38], 50.00th=[   38], 60.00th=[   39],
>      | 70.00th=[   39], 80.00th=[   40], 90.00th=[   42], 95.00th=[   44],
>      | 99.00th=[   52], 99.50th=[   59], 99.90th=[   77], 99.95th=[   88],
>      | 99.99th=[  169]
>    bw (  KiB/s): min=15664, max=1599456, per=100.00%, avg=897761.07, stdev=504329.17, samples=257
>    iops        : min= 3916, max=399864, avg=224440.26, stdev=126082.33, samples=257
>   lat (usec)   : 2=0.01%, 4=0.01%, 10=0.01%, 20=0.01%, 50=98.80%
>   lat (usec)   : 100=1.18%, 250=0.02%, 500=0.01%
>   lat (msec)   : 10=0.01%, 2000=0.01%, >=2000=0.01%
>   cpu          : usr=5.45%, sys=23.92%, ctx=78418, majf=0, minf=14
>   IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
>      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
>      complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
>      issued rwts: total=0,28889786,0,0 short=0,0,0,0 dropped=0,0,0,0
>      latency   : target=0, window=0, percentile=100.00%, depth=16
> 
> Run status group 0 (all jobs):
>   WRITE: bw=376MiB/s (394MB/s), 376MiB/s-376MiB/s (394MB/s-394MB/s), io=110GiB (118GB), run=300001-300001msec
> 
> Disk stats (read/write):
>     dm-7: ios=0/22878, merge=0/0, ticks=0/373254, in_queue=373254, util=43.89%, aggrios=0/99746, aggrmerge=0/9246, aggrticks=0/1406831, aggrin_queue=1408420, aggrutil=73.56%
>   sda: ios=0/99746, merge=0/9246, ticks=0/1406831, in_queue=1408420, util=73.56%
> 
> mounted with -o iversion:
> 
> $ fio ./4k-write.fio
> file1: (g=0): rw=write, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
> fio-3.27
> Starting 1 process
> Jobs: 1 (f=1): [W(1)][100.0%][eta 00m:00s]                          
> file1: (groupid=0, jobs=1): err= 0: pid=10369: Wed Jul 20 12:33:57 2022
>   write: IOPS=96.2k, BW=376MiB/s (394MB/s)(110GiB/300001msec); 0 zone resets
>     slat (nsec): min=1112, max=1861.5k, avg=1994.58, stdev=890.78
>     clat (nsec): min=1392, max=2113.3M, avg=156252.71, stdev=15409487.99
>      lat (usec): min=3, max=2113.3k, avg=158.30, stdev=15409.49
>     clat percentiles (usec):
>      |  1.00th=[   37],  5.00th=[   38], 10.00th=[   38], 20.00th=[   38],
>      | 30.00th=[   39], 40.00th=[   39], 50.00th=[   40], 60.00th=[   40],
>      | 70.00th=[   41], 80.00th=[   42], 90.00th=[   43], 95.00th=[   45],
>      | 99.00th=[   53], 99.50th=[   60], 99.90th=[   79], 99.95th=[   90],
>      | 99.99th=[  174]
>    bw (  KiB/s): min=  304, max=1540000, per=100.00%, avg=870727.42, stdev=499371.78, samples=265
>    iops        : min=   76, max=385000, avg=217681.82, stdev=124842.94, samples=265
>   lat (usec)   : 2=0.01%, 4=0.01%, 10=0.01%, 20=0.01%, 50=98.49%
>   lat (usec)   : 100=1.48%, 250=0.02%, 500=0.01%
>   lat (msec)   : 2=0.01%, 2000=0.01%, >=2000=0.01%
>   cpu          : usr=5.71%, sys=24.49%, ctx=52874, majf=0, minf=18
>   IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
>      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
>      complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
>      issued rwts: total=0,28856695,0,0 short=0,0,0,0 dropped=0,0,0,0
>      latency   : target=0, window=0, percentile=100.00%, depth=16
> 
> Run status group 0 (all jobs):
>   WRITE: bw=376MiB/s (394MB/s), 376MiB/s-376MiB/s (394MB/s-394MB/s), io=110GiB (118GB), run=300001-300001msec
> 
> Disk stats (read/write):
>     dm-7: ios=1/16758, merge=0/0, ticks=2/341817, in_queue=341819, util=47.93%, aggrios=1/98153, aggrmerge=0/5691, aggrticks=2/1399496, aggrin_queue=1400893, aggrutil=73.42%
>   sda: ios=1/98153, merge=0/5691, ticks=2/1399496, in_queue=1400893, util=73.42%
> 
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

