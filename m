Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213894CE050
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Mar 2022 23:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiCDWnu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Mar 2022 17:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiCDWns (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Mar 2022 17:43:48 -0500
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB9F221E01;
        Fri,  4 Mar 2022 14:42:59 -0800 (PST)
Received: from dread.disaster.area (pa49-186-17-0.pa.vic.optusnet.com.au [49.186.17.0])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 5F4BA52FB90;
        Sat,  5 Mar 2022 09:42:58 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nQGdV-001aSG-Ou; Sat, 05 Mar 2022 09:42:57 +1100
Date:   Sat, 5 Mar 2022 09:42:57 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
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
Message-ID: <20220304224257.GN3927073@dread.disaster.area>
References: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
 <20220304001022.GJ3927073@dread.disaster.area>
 <YiKOQM+HMZXnArKT@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiKOQM+HMZXnArKT@bombadil.infradead.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=622295f3
        a=+dVDrTVfsjPpH/ci3UuFng==:117 a=+dVDrTVfsjPpH/ci3UuFng==:17
        a=kj9zAlcOel0A:10 a=o8Y5sQTvuykA:10 a=7-415B0cAAAA:8
        a=npNClS7MiuqHlMapsjAA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 04, 2022 at 02:10:08PM -0800, Luis Chamberlain wrote:
> On Fri, Mar 04, 2022 at 11:10:22AM +1100, Dave Chinner wrote:
> > On Wed, Mar 02, 2022 at 04:56:54PM -0800, Luis Chamberlain wrote:
> > > Thinking proactively about LSFMM, regarding just Zone storage..
> > > 
> > > I'd like to propose a BoF for Zoned Storage. The point of it is
> > > to address the existing point points we have and take advantage of
> > > having folks in the room we can likely settle on things faster which
> > > otherwise would take years.
> > > 
> > > I'll throw at least one topic out:
> > > 
> > >   * Raw access for zone append for microbenchmarks:
> > >   	- are we really happy with the status quo?
> > > 	- if not what outlets do we have?
> > > 
> > > I think the nvme passthrogh stuff deserves it's own shared
> > > discussion though and should not make it part of the BoF.
> > 
> > Reading through the discussion on this thread, perhaps this session
> > should be used to educate application developers about how to use
> > ZoneFS so they never need to manage low level details of zone
> > storage such as enumerating zones, controlling write pointers
> > safely for concurrent IO, performing zone resets, etc.
> 
> I'm not even sure users are really aware that given cap can be different
> than zone size and btrfs uses zone size to compute size, the size is a
> flat out lie.

Sorry, I don't get what btrfs does with zone management has anything
to do with using Zonefs to get direct, raw IO access to individual
zones. Direct IO on open zone fds is likely more efficient than
doing IO through the standard LBA based block device because ZoneFS
uses iomap_dio_rw() so it only needs to do one mapping operation per
IO instead of one per page in the IO. Nor does it have to manage
buffer heads or other "generic blockdev" functionality that direct
IO access to zoned storage doesn't require.

So whatever you're complaining about that btrfs lies about, does or
doesn't do is irrelevant - Zonefs was written with the express
purpose of getting user applications away from needing to directly
manage zone storage. SO if you have special zone IO management
requirements, work out how they can be supported by zonefs - we
don't need yet another special purpose direct hardware access API
for zone storage when we already have a solid solution to the
problem already.

> modprobe null_blk nr_devices=0
> mkdir /sys/kernel/config/nullb/nullb0
> echo 0 > /sys/kernel/config/nullb/nullb0/completion_nsec
> echo 0 > /sys/kernel/config/nullb/nullb0/irqmode
> echo 2 > /sys/kernel/config/nullb/nullb0/queue_mode
> echo 1024 > /sys/kernel/config/nullb/nullb0/hw_queue_depth
> echo 1 > /sys/kernel/config/nullb/nullb0/memory_backed
> echo 1 > /sys/kernel/config/nullb/nullb0/zoned
> 
> echo 128 > /sys/kernel/config/nullb/nullb0/zone_size
> # 6 zones are implied, we are saying 768 for the full storage size..
> # but...
> echo 768 > /sys/kernel/config/nullb/nullb0/size
> 
> # If we force capacity to be way less than the zone sizes, btrfs still
> # uses the zone size to do its data / metadata size computation...
> echo 32 > /sys/kernel/config/nullb/nullb0/zone_capacity

Then that's just a btrfs zone support bug where it's used the
wrong information to size it's zones. Why not just send a patch to
fix it?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
