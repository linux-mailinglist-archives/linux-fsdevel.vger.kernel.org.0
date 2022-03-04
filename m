Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E964CE011
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Mar 2022 23:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiCDWLA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Mar 2022 17:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiCDWK7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Mar 2022 17:10:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF348CE925;
        Fri,  4 Mar 2022 14:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HuyErcKtu69AHqki1H1pbEavQ4LL5YiG7O6LJZgqirM=; b=e272eZzJJ1BoHlixvu8OcAt5FO
        s5dArlh7ggGL4rdUafaCgGhUm4gKNcrMoz3fsgSxphw/IlOiPOEoKqsAd6Dr4gDFiiArKGgWYmIqb
        iVsVSupitJabKuN11ocZLLN2iPqHQ3vwhSEpQ+DGr8j2Ym/ZmnrAJKpO9U1MT2gTjgb6EnRaxu2ZL
        IUJwkb1PB5x3/Sht4SrOJCLikPieCGC8I880YpTTPW1m7InktonJP+OKJUS8GueiWxpvktHzdeOFY
        OnkNdQVi41ivVG84eTf/6ojPhDnBvlqjNHaU6tDuBUAigjp56Rxg6aD/laNpvGPXlhlOmKh9xLg1H
        bO9KPsiQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQG7k-00CBQJ-2m; Fri, 04 Mar 2022 22:10:08 +0000
Date:   Fri, 4 Mar 2022 14:10:08 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        lsf-pc@lists.linux-foundation.org,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Keith Busch <Keith.Busch@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [LSF/MM/BPF BoF] BoF for Zoned Storage
Message-ID: <YiKOQM+HMZXnArKT@bombadil.infradead.org>
References: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
 <20220304001022.GJ3927073@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304001022.GJ3927073@dread.disaster.area>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 04, 2022 at 11:10:22AM +1100, Dave Chinner wrote:
> On Wed, Mar 02, 2022 at 04:56:54PM -0800, Luis Chamberlain wrote:
> > Thinking proactively about LSFMM, regarding just Zone storage..
> > 
> > I'd like to propose a BoF for Zoned Storage. The point of it is
> > to address the existing point points we have and take advantage of
> > having folks in the room we can likely settle on things faster which
> > otherwise would take years.
> > 
> > I'll throw at least one topic out:
> > 
> >   * Raw access for zone append for microbenchmarks:
> >   	- are we really happy with the status quo?
> > 	- if not what outlets do we have?
> > 
> > I think the nvme passthrogh stuff deserves it's own shared
> > discussion though and should not make it part of the BoF.
> 
> Reading through the discussion on this thread, perhaps this session
> should be used to educate application developers about how to use
> ZoneFS so they never need to manage low level details of zone
> storage such as enumerating zones, controlling write pointers
> safely for concurrent IO, performing zone resets, etc.

I'm not even sure users are really aware that given cap can be different
than zone size and btrfs uses zone size to compute size, the size is a
flat out lie.

modprobe null_blk nr_devices=0
mkdir /sys/kernel/config/nullb/nullb0
echo 0 > /sys/kernel/config/nullb/nullb0/completion_nsec
echo 0 > /sys/kernel/config/nullb/nullb0/irqmode
echo 2 > /sys/kernel/config/nullb/nullb0/queue_mode
echo 1024 > /sys/kernel/config/nullb/nullb0/hw_queue_depth
echo 1 > /sys/kernel/config/nullb/nullb0/memory_backed
echo 1 > /sys/kernel/config/nullb/nullb0/zoned

echo 128 > /sys/kernel/config/nullb/nullb0/zone_size
# 6 zones are implied, we are saying 768 for the full storage size..
# but...
echo 768 > /sys/kernel/config/nullb/nullb0/size

# If we force capacity to be way less than the zone sizes, btrfs still
# uses the zone size to do its data / metadata size computation...
echo 32 > /sys/kernel/config/nullb/nullb0/zone_capacity

# No conventional zones
echo 0 > /sys/kernel/config/nullb/nullb0/zone_nr_conv

echo 1 > /sys/kernel/config/nullb/nullb0/power
echo mq-deadline > /sys/block/nullb0/queue/scheduler

# mkfs.btrfs -f -d single -m single /dev/nullb0
Label:              (null)
UUID:               e725782a-d2d3-4c02-97fd-0501de117323
Node size:          16384
Sector size:        4096
Filesystem size:    768.00MiB
Block group profiles:
  Data:             single          128.00MiB
    Metadata:         single          128.00MiB
      System:           single          128.00MiB
      SSD detected:       yes
      Zoned device:       yes
        Zone size:        128.00MiB
	Incompat features:  extref, skinny-metadata, no-holes, zoned
	Runtime features:   free-space-tree
	Checksum:           crc32c
	Number of devices:  1
	Devices:
	   ID        SIZE  PATH
	       1   768.00MiB  /dev/nullb0

# mount /dev/nullb0 /mnt
# btrfs fi show
Label: none  uuid: e725782a-d2d3-4c02-97fd-0501de117323
        Total devices 1 FS bytes used 144.00KiB
	        devid    1 size 768.00MiB used 384.00MiB path
		/dev/nullb0

# btrfs fi df /mnt
Data, single: total=128.00MiB, used=0.00B
System, single: total=128.00MiB, used=16.00KiB
Metadata, single: total=128.00MiB, used=128.00KiB
GlobalReserve, single: total=3.50MiB, used=0.00B

Since btrfs already has "real size" problems this existing
design takes this a bit further without a fix either. I suspect
quite a bit of puzzled users will be unhappy that even though
ZNS claims to kill overprovisioning we're now somehow lying
about size. I'm not even sure this might be good for the
filesystem / metadata.

  Luis
