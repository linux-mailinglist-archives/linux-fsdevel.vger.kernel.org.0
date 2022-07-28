Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56042584864
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jul 2022 00:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiG1WsP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jul 2022 18:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiG1WsN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jul 2022 18:48:13 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A8B84F65E;
        Thu, 28 Jul 2022 15:48:12 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-20-138.pa.nsw.optusnet.com.au [49.195.20.138])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id BDCD662CC74;
        Fri, 29 Jul 2022 08:48:06 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oHCIV-006TpR-LO; Fri, 29 Jul 2022 08:48:03 +1000
Date:   Fri, 29 Jul 2022 08:48:03 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Mel Gorman <mgorman@suse.de>
Subject: Re: remove iomap_writepage v2
Message-ID: <20220728224803.GZ3861211@dread.disaster.area>
References: <20220719041311.709250-1-hch@lst.de>
 <20220728111016.uwbaywprzkzne7ib@quack3>
 <YuKam52dkTGycay2@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuKam52dkTGycay2@casper.infradead.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=OJNEYQWB c=1 sm=1 tr=0 ts=62e3122a
        a=cxZHBGNDieHvTKNp/pucQQ==:117 a=cxZHBGNDieHvTKNp/pucQQ==:17
        a=kj9zAlcOel0A:10 a=RgO8CyIxsXoA:10 a=7-415B0cAAAA:8
        a=daDVLCEH9rD64MzAnTUA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 28, 2022 at 03:18:03PM +0100, Matthew Wilcox wrote:
> On Thu, Jul 28, 2022 at 01:10:16PM +0200, Jan Kara wrote:
> > Hi Christoph!
> > 
> > On Tue 19-07-22 06:13:07, Christoph Hellwig wrote:
> > > this series removes iomap_writepage and it's callers, following what xfs
> > > has been doing for a long time.
> > 
> > So this effectively means "no writeback from page reclaim for these
> > filesystems" AFAICT (page migration of dirty pages seems to be handled by
> > iomap_migrate_page()) which is going to make life somewhat harder for
> > memory reclaim when memory pressure is high enough that dirty pages are
> > reaching end of the LRU list. I don't expect this to be a problem on big
> > machines but it could have some undesirable effects for small ones
> > (embedded, small VMs). I agree per-page writeback has been a bad idea for
> > efficiency reasons for at least last 10-15 years and most filesystems
> > stopped dealing with more complex situations (like block allocation) from
> > ->writepage() already quite a few years ago without any bug reports AFAIK.
> > So it all seems like a sensible idea from FS POV but are MM people on board
> > or at least aware of this movement in the fs land?
> 
> I mentioned it during my folio session at LSFMM, but didn't put a huge
> emphasis on it.
> 
> For XFS, writeback should already be in progress on other pages if
> we're getting to the point of trying to call ->writepage() in vmscan.
> Surely this is also true for other filesystems?

Yes.

It's definitely true for btrfs, too, because btrfs_writepage does:

static int btrfs_writepage(struct page *page, struct writeback_control *wbc)
{
        struct inode *inode = page->mapping->host;
        int ret;

        if (current->flags & PF_MEMALLOC) {
                redirty_page_for_writepage(wbc, page);
                unlock_page(page);
                return 0;
        }
....

It also rejects all calls to write dirty pages from memory reclaim
contexts.

ext4 will also reject writepage calls from memory allocation if
block allocation is required (due to delayed allocation) or
unwritten extents need converting to written. i.e. if it has to run
blocking transactions.

So all three major filesystems will either partially or wholly
reject ->writepage calls from memory reclaim context.

IOWs, if memory reclaim is depending on ->writepage() to make
reclaim progress, it's not working as advertised on the vast
majority of production Linux systems....

The reality is that ->writepage is a relic of a bygone era of OS and
filesystem design. It was useful in the days where writing a dirty
page just involved looking up the bufferhead attached to the page to
get the disk mapping and then submitting it for IO.

Those days are long gone - filesystems have complex IO submission
paths now that have to handle delayed allocation, copy-on-write,
unwritten extents, have unbound memory demand, etc. All the
filesystems that support these 1990s era filesystem technologies
simply turn off ->writepage in memory reclaim contexts.

Hence for the vast majority of linux users (i.e. everyone using
ext4, btrfs and XFS), ->writepage no longer plays any part in memory
reclaim on their systems.

So why should we try to maintain the fiction that ->writepage is
required functionality in a filesystem when it clearly isn't?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
