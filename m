Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 685F712AAFF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2019 09:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfLZIhf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Dec 2019 03:37:35 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56621 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726378AbfLZIhf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Dec 2019 03:37:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577349452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jfbrd9Z7j74xAHhDaL9AjCoXjd1Y0h7EWv4zCc5ymZY=;
        b=LscU9r5r20e2lgC5ZrHNzxP6tXv5Kga0z8DkKRVsBeNgov2w1PBc90wi1F8lx1R60qTyTQ
        vI4wZ4+CiMB+SB/lMHcNPg7V+C2rXgH8RgvB27ma2k3H5toCBASvrtAU5O887uEQYx0ZSm
        4nm3Qc00dQd6fKr9Z2WsVutnnOCgc9M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-tUAIxXGPPKKwhZCfc1EHbA-1; Thu, 26 Dec 2019 03:37:28 -0500
X-MC-Unique: tUAIxXGPPKKwhZCfc1EHbA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2EA85477;
        Thu, 26 Dec 2019 08:37:25 +0000 (UTC)
Received: from ming.t460p (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6988360BEC;
        Thu, 26 Dec 2019 08:37:10 +0000 (UTC)
Date:   Thu, 26 Dec 2019 16:37:06 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Andrea Vai <andrea.vai@unipv.it>,
        "Schmid, Carsten" <Carsten_Schmid@mentor.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        USB list <linux-usb@vger.kernel.org>,
        SCSI development list <linux-scsi@vger.kernel.org>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        Hannes Reinecke <hare@suse.com>,
        Omar Sandoval <osandov@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: AW: Slow I/O on USB media after commit
 f664a3cc17b7d0a2bc3b3ab96181e1029b0ec0e6
Message-ID: <20191226083706.GA17974@ming.t460p>
References: <20191223130828.GA25948@ming.t460p>
 <20191223162619.GA3282@mit.edu>
 <4c85fd3f2ec58694cc1ff7ab5c88d6e11ab6efec.camel@unipv.it>
 <20191223172257.GB3282@mit.edu>
 <bb5d395fe47f033be0b8ed96cbebf8867d2416c4.camel@unipv.it>
 <20191223195301.GC3282@mit.edu>
 <20191224012707.GA13083@ming.t460p>
 <20191225051722.GA119634@mit.edu>
 <20191226022702.GA2901@ming.t460p>
 <20191226033057.GA10794@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191226033057.GA10794@mit.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 25, 2019 at 10:30:57PM -0500, Theodore Y. Ts'o wrote:
> On Thu, Dec 26, 2019 at 10:27:02AM +0800, Ming Lei wrote:
> > Maybe we need to be careful for HDD., since the request count in sche=
duler
> > queue is double of in-flight request count, and in theory NCQ should =
only
> > cover all in-flight 32 requests. I will find a sata HDD., and see if
> > performance drop can be observed in the similar 'cp' test.
>=20
> Please try to measure it, but I'd be really surprised if it's
> significant with with modern HDD's.

Just find one machine with AHCI SATA, and run the following xfs
overwrite test:

#!/bin/bash
DIR=3D$1
echo 3 > /proc/sys/vm/drop_caches
fio --readwrite=3Dwrite --filesize=3D5g --overwrite=3D1 --filename=3D$DIR=
/fiofile \
        --runtime=3D60s --time_based --ioengine=3Dpsync --direct=3D0 --bs=
=3D4k
		--iodepth=3D128 --numjobs=3D2 --group_reporting=3D1 --name=3Doverwrite

FS is xfs, and disk is LVM over AHCI SATA with NCQ(depth 32), because the
machine is picked up from RH beaker, and it is the only disk in the box.

#lsblk
NAME                            MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sda                               8:0    0 931.5G  0 disk=20
=E2=94=9C=E2=94=80sda1                            8:1    0     1G  0 part=
 /boot
=E2=94=94=E2=94=80sda2                            8:2    0 930.5G  0 part=
=20
  =E2=94=9C=E2=94=80rhel_hpe--ml10gen9--01-root 253:0    0    50G  0 lvm =
 /
  =E2=94=9C=E2=94=80rhel_hpe--ml10gen9--01-swap 253:1    0   3.9G  0 lvm =
 [SWAP]
  =E2=94=94=E2=94=80rhel_hpe--ml10gen9--01-home 253:2    0 876.6G  0 lvm =
 /home


kernel: 3a7ea2c483a53fc("scsi: provide mq_ops->busy() hook") which is
the previous commit of f664a3cc17b7 ("scsi: kill off the legacy IO path")=
.

            |scsi_mod.use_blk_mq=3DN |scsi_mod.use_blk_mq=3DY |
-----------------------------------------------------------
throughput: |244MB/s               |169MB/s               |
-----------------------------------------------------------

Similar result can be observed on v5.4 kernel(184MB/s) with same test
steps.


> That because they typically have
> a queue depth of 16, and a max_sectors_kb of 32767 (e.g., just under
> 32 MiB).  Sort seeks are typically 1-2 ms, with full stroke seeks
> 8-10ms.  Typical sequential write speeds on a 7200 RPM drive is
> 125-150 MiB/s.  So suppose every other request sent to the HDD is from
> the other request stream.  The disk will chose the 8 requests from its
> queue that are contiguous, and so it will be writing around 256 MiB,
> which will take 2-3 seconds.  If it then needs to spend between 1 and
> 10 ms seeking to another location of the disk, before it writes the
> next 256 MiB, the worst case overhead of that seek is 10ms / 2s, or
> 0.5%.  That may very well be within your measurements' error bars.

Looks you assume that disk seeking just happens once when writing around
256MB. This assumption may not be true, given all data can be in page
cache before writing. So when two tasks are submitting IOs concurrently,
IOs from each single task is sequential, and NCQ may order the current ba=
tch
submitted from the two streams. However disk seeking may still be needed
for the next batch handled by NCQ.

> And of course, note that in real life, we are very *often* writing to
> multiple files in parallel, for example, during a "make -j16" while
> building the kernel.  Writing a single large file is certainly
> something people do (but even there people who are burning a 4G DVD
> rip are often browsing the web while they are waiting for it to
> complete, and the browser will be writing cache files, etc.).  So
> whether or not this is something where we should be stressing over
> this specific workload is going to be quite debateable.

Thanks,=20
Ming

