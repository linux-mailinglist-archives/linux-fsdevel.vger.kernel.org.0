Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4F5366216
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 00:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbhDTWNe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 18:13:34 -0400
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:58935 "EHLO
        mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233769AbhDTWNd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 18:13:33 -0400
Received: from dread.disaster.area (pa49-181-239-12.pa.nsw.optusnet.com.au [49.181.239.12])
        by mail107.syd.optusnet.com.au (Postfix) with ESMTPS id 2F6351140E9A;
        Wed, 21 Apr 2021 08:12:56 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lYyc3-00HVy8-BZ; Wed, 21 Apr 2021 08:12:55 +1000
Date:   Wed, 21 Apr 2021 08:12:55 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        Ted Tso <tytso@mit.edu>, Christoph Hellwig <hch@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH 0/7 RFC v3] fs: Hole punch vs page cache filling races
Message-ID: <20210420221255.GX63242@dread.disaster.area>
References: <20210413105205.3093-1-jack@suse.cz>
 <20210419152008.GD2531743@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210419152008.GD2531743@casper.infradead.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_f
        a=gO82wUwQTSpaJfP49aMSow==:117 a=gO82wUwQTSpaJfP49aMSow==:17
        a=kj9zAlcOel0A:10 a=3YhXtTcJ-WEA:10 a=7-415B0cAAAA:8
        a=pdA6XN1g6aLBFY80ifEA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 19, 2021 at 04:20:08PM +0100, Matthew Wilcox wrote:
> On Tue, Apr 13, 2021 at 01:28:44PM +0200, Jan Kara wrote:
> > Also when writing the documentation I came across one question: Do we mandate
> > i_mapping_sem for truncate + hole punch for all filesystems or just for
> > filesystems that support hole punching (or other complex fallocate operations)?
> > I wrote the documentation so that we require every filesystem to use
> > i_mapping_sem. This makes locking rules simpler, we can also add asserts when
> > all filesystems are converted. The downside is that simple filesystems now pay
> > the overhead of the locking unnecessary for them. The overhead is small
> > (uncontended rwsem acquisition for truncate) so I don't think we care and the
> > simplicity is worth it but I wanted to spell this out.
> 
> What do we actually get in return for supporting these complex fallocate
> operations?  Someone added them for a reason, but does that reason
> actually benefit me?  Other than running xfstests, how many times has
> holepunch been called on your laptop in the last week?

Quite a lot, actually.

> I don't want to
> incur even one extra instruction per I/O operation to support something
> that happens twice a week; that's a bad tradeoff.

Hole punching gets into all sorts of interesting places. For
example, did you know that issuing fstrim (discards) or "write
zeroes" on a file-backed loopback device will issue hole punches to
the underlying file? nvmet does the same. Userspace iscsi server
implementations (e.g. TGT) do the same thing and have for a long
time. NFSv4 servers issue hole punching based on client side
requests, too.

Then there's Kubernetes management tools. Samba. Qemu. Libvirt.
Mysql. Network-Manager. Gluster. Chromium. RocksDB. Swift. Systemd.
The list of core system infrastructure we have that uses hole
punching is quite large...

So, really, hole punching is something that happens a lot and in
many unexpected places. You can argue that your laptop doesn't use
it, but that really doesn't matter in the bigger scheme of things.
Hole punching is something applications expect to work and not
corrupt data....

> Can we implement holepunch as a NOP?  Or return -ENOTTY?  Those both
> seem like better solutions than adding an extra rwsem to every inode.

We've already added this extra i_rwsem to ext4 and XFS - it's a sunk
cost for almost every production machine out there in the wild. It
needs to be made generic so we can optimise the implementation and
not have to implement a unicorn in every filesystem to work around
the fact the page cache and page faults have no internal
serialisation mechanism against filesystem operations that directly
manipulate and invalidate large ranges of the backing storage the
page cache sits over.

> Failing that, is there a bigger hammer we can use on the holepunch side
> (eg preventing all concurrent accesses while the holepunch is happening)
> to reduce the overhead on the read side?

That's what we currently do and what Jan is trying to refine....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
