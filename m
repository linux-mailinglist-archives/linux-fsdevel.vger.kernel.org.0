Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8360A4C2982
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 11:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbiBXK3g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 05:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbiBXK3f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 05:29:35 -0500
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F5D11E1484;
        Thu, 24 Feb 2022 02:29:05 -0800 (PST)
Received: from dread.disaster.area (pa49-186-17-0.pa.vic.optusnet.com.au [49.186.17.0])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 377EB10E3F4B;
        Thu, 24 Feb 2022 21:29:01 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nNBMr-00FpGo-82; Thu, 24 Feb 2022 21:29:01 +1100
Date:   Thu, 24 Feb 2022 21:29:01 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>, linux-ext4@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <dchinner@redhat.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Johannes Thumshirn <jth@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [REPORT] kernel BUG at fs/ext4/inode.c:2620 - page_buffers()
Message-ID: <20220224102901.GN59715@dread.disaster.area>
References: <Yg0m6IjcNmfaSokM@google.com>
 <82d0f4e4-c911-a245-4701-4712453592d9@nvidia.com>
 <Yg8bxiz02WBGf6qO@mit.edu>
 <Yg9QGm2Rygrv+lMj@kroah.com>
 <YhbE2nocBMtLc27C@mit.edu>
 <20220224014842.GM59715@dread.disaster.area>
 <YhcAcfY1pZTl3sId@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhcAcfY1pZTl3sId@mit.edu>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=62175def
        a=+dVDrTVfsjPpH/ci3UuFng==:117 a=+dVDrTVfsjPpH/ci3UuFng==:17
        a=kj9zAlcOel0A:10 a=oGFeUVbbRNcA:10 a=7-415B0cAAAA:8
        a=nNeadVlkB5BEUYMxFkMA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 23, 2022 at 10:50:09PM -0500, Theodore Ts'o wrote:
> On Thu, Feb 24, 2022 at 12:48:42PM +1100, Dave Chinner wrote:
> > > Fair enough; on the other hand, we could also view this as making ext4
> > > more robust against buggy code in other subsystems, and while other
> > > file systems may be losing user data if they are actually trying to do
> > > remote memory access to file-backed memory, apparently other file
> > > systems aren't noticing and so they're not crashing.
> > 
> > Oh, we've noticed them, no question about that.  We've got bug
> > reports going back years for systems being crashed, triggering BUGs
> > and/or corrupting data on both XFS and ext4 filesystems due to users
> > trying to run RDMA applications with file backed pages.
> 
> Is this issue causing XFS to crash?  I didn't know that.

I have no idea if crashes nowdays -  go back a few years before and
search for XFS BUGging out in ->invalidate_page (or was it
->release_page?) because of unexpected dirty pages. I think it could
also trigger BUGs in writeback when ->writepages tripped over a
dirty page without a delayed allocation mapping over the hole...

We were pretty aggressive about telling people reporting such issues
that they get to keep all the borken bits to themselves and to stop
wasting our time with unsolvable problems caused by their
broken-by-design RDMA applications. Hence people have largely
stopped bothering us with random filesystem crashes on systems using
RDMA on file-backed pages...

> I tried the Syzbot reproducer with XFS mounted, and it didn't trigger
> any crashes.  I'm sure data was getting corrupted, but I figured I
> should bring ext4 to the XFS level of "at least we're not reliably
> killing the kernel".

Oh, well, good to know XFS didn't die a horrible death immediately.
Thanks for checking, Ted.

> On ext4, an unprivileged process can use process_vm_writev(2) to crash
> the system.  I don't know how quickly we can get a fix into mm/gup.c,
> but if some other kernel path tries calling set_page_dirty() on a
> file-backed page without first asking permission from the file system,
> it seems to be nice if the file system doesn't BUG() --- as near as I
> can tell, xfs isn't crashing in this case, but ext4 is.

iomap is probably refusing to map holes for writepage - we've
cleaned up most of the weird edge cases to return errors, so I'm
guessing iomap is just ignoring such pages these days.

Yeah, see iomap_writepage_map():

                error = wpc->ops->map_blocks(wpc, inode, pos);
                if (error)
                        break;
                if (WARN_ON_ONCE(wpc->iomap.type == IOMAP_INLINE))
                        continue;
                if (wpc->iomap.type == IOMAP_HOLE)
                        continue;

Yeah, so if writeback maps a hole rather than converts a delalloc
region to IOMAP_MAPPED, it'll just skip over the block/page.  IIRC,
they essentially become uncleanable pages, and I think eventually
inode reclaim will just toss them out of memory.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
