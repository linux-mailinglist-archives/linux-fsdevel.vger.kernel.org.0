Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF554CE07B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Mar 2022 23:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiCDW4b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Mar 2022 17:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiCDW4a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Mar 2022 17:56:30 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E52222FD92;
        Fri,  4 Mar 2022 14:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wbD//7TjcScQs+hFckWtsVDx0BjrXZzwzlVXZvi3eho=; b=IfaPUt9ZPFCQjNc/qlSoB/E8C8
        jjpv7Ih7gxo9d1M8NPSDQMRZ2OhNOYrcdZr844tS+errbT/UqqrpYA9CebayQ6xwBNbPSxUeMGtFm
        bE4/fCf1etxdDiv+5Jqz18tnN1mf/VHJJUzQgGApFWgegizzwI8zgZC4Z5Tk/NC/3Ir8VraaXEdyO
        QQoSmNXD9JIx8T7Li03bV8XLeL2rs8cma1DxJ3oY2/pgasPCHzz7sfM24yrhBSbmSVVSek8mFwgnW
        ZeEHPHN2e+xHTKSejMsc8CrG4Iixr87MT96FxH+srgwHULwFcKTLlGCMtxyN7fyVuBaFmVkWhPZXf
        dORTLXjw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQGpm-00CFrE-CW; Fri, 04 Mar 2022 22:55:38 +0000
Date:   Fri, 4 Mar 2022 14:55:38 -0800
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
Message-ID: <YiKY6pMczvRuEovI@bombadil.infradead.org>
References: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
 <20220304001022.GJ3927073@dread.disaster.area>
 <YiKOQM+HMZXnArKT@bombadil.infradead.org>
 <20220304224257.GN3927073@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304224257.GN3927073@dread.disaster.area>
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

On Sat, Mar 05, 2022 at 09:42:57AM +1100, Dave Chinner wrote:
> On Fri, Mar 04, 2022 at 02:10:08PM -0800, Luis Chamberlain wrote:
> > On Fri, Mar 04, 2022 at 11:10:22AM +1100, Dave Chinner wrote:
> > > On Wed, Mar 02, 2022 at 04:56:54PM -0800, Luis Chamberlain wrote:
> > > > Thinking proactively about LSFMM, regarding just Zone storage..
> > > > 
> > > > I'd like to propose a BoF for Zoned Storage. The point of it is
> > > > to address the existing point points we have and take advantage of
> > > > having folks in the room we can likely settle on things faster which
> > > > otherwise would take years.
> > > > 
> > > > I'll throw at least one topic out:
> > > > 
> > > >   * Raw access for zone append for microbenchmarks:
> > > >   	- are we really happy with the status quo?
> > > > 	- if not what outlets do we have?
> > > > 
> > > > I think the nvme passthrogh stuff deserves it's own shared
> > > > discussion though and should not make it part of the BoF.
> > > 
> > > Reading through the discussion on this thread, perhaps this session
> > > should be used to educate application developers about how to use
> > > ZoneFS so they never need to manage low level details of zone
> > > storage such as enumerating zones, controlling write pointers
> > > safely for concurrent IO, performing zone resets, etc.
> > 
> > I'm not even sure users are really aware that given cap can be different
> > than zone size and btrfs uses zone size to compute size, the size is a
> > flat out lie.
> 
> Sorry, I don't get what btrfs does with zone management has anything
> to do with using Zonefs to get direct, raw IO access to individual
> zones.

You are right for direct raw access. My point was that even for
filesystem use design I don't think the communication is clear on
expectations. Similar computation need to be managed by fileystem
design, for instance.

> Direct IO on open zone fds is likely more efficient than
> doing IO through the standard LBA based block device because ZoneFS
> uses iomap_dio_rw() so it only needs to do one mapping operation per
> IO instead of one per page in the IO. Nor does it have to manage
> buffer heads or other "generic blockdev" functionality that direct
> IO access to zoned storage doesn't require.
>
> So whatever you're complaining about that btrfs lies about, does or
> doesn't do is irrelevant - Zonefs was written with the express
> purpose of getting user applications away from needing to directly
> manage zone storage.

I think it ended that way, I can't say it was the goal from the start.
Seems the raw block patches had some support and in the end zonefs
was presented as a possible outlet.

> SO if you have special zone IO management
> requirements, work out how they can be supported by zonefs - we
> don't need yet another special purpose direct hardware access API
> for zone storage when we already have a solid solution to the
> problem already.

If this is fairly decided. Then that's that.

Calling zonefs solid though is a stretch.

> > modprobe null_blk nr_devices=0
> > mkdir /sys/kernel/config/nullb/nullb0
> > echo 0 > /sys/kernel/config/nullb/nullb0/completion_nsec
> > echo 0 > /sys/kernel/config/nullb/nullb0/irqmode
> > echo 2 > /sys/kernel/config/nullb/nullb0/queue_mode
> > echo 1024 > /sys/kernel/config/nullb/nullb0/hw_queue_depth
> > echo 1 > /sys/kernel/config/nullb/nullb0/memory_backed
> > echo 1 > /sys/kernel/config/nullb/nullb0/zoned
> > 
> > echo 128 > /sys/kernel/config/nullb/nullb0/zone_size
> > # 6 zones are implied, we are saying 768 for the full storage size..
> > # but...
> > echo 768 > /sys/kernel/config/nullb/nullb0/size
> > 
> > # If we force capacity to be way less than the zone sizes, btrfs still
> > # uses the zone size to do its data / metadata size computation...
> > echo 32 > /sys/kernel/config/nullb/nullb0/zone_capacity
> 
> Then that's just a btrfs zone support bug where it's used the
> wrong information to size it's zones. Why not just send a patch to
> fix it?

This can change the format of existing created filesystems. And so
if this change is welcomed I think we would need to be explicit
about its support.

  Luis
