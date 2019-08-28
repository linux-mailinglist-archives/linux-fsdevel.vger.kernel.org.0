Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85B3AA0930
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2019 20:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfH1SCS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Aug 2019 14:02:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:52450 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726603AbfH1SCS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Aug 2019 14:02:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A3773AF57;
        Wed, 28 Aug 2019 18:02:16 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id F26761E4362; Wed, 28 Aug 2019 20:02:15 +0200 (CEST)
Date:   Wed, 28 Aug 2019 20:02:15 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>, jack@suse.cz,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, aneesh.kumar@linux.ibm.com
Subject: Re: [PATCH 0/5] ext4: direct IO via iomap infrastructure
Message-ID: <20190828180215.GE22343@quack2.suse.cz>
References: <20190813122723.AE6264C040@d06av22.portsmouth.uk.ibm.com>
 <20190821131405.GC24417@poseidon.bobrowski.net>
 <20190822120015.GA3330@poseidon.bobrowski.net>
 <20190822141126.70A94A407B@d06av23.portsmouth.uk.ibm.com>
 <20190824031830.GB2174@poseidon.bobrowski.net>
 <20190824035554.GA1037502@magnolia>
 <20190824230427.GA32012@infradead.org>
 <20190827095221.GA1568@poseidon.bobrowski.net>
 <20190828120509.GC22165@poseidon.bobrowski.net>
 <20190828142729.GB24857@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828142729.GB24857@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 28-08-19 10:27:29, Theodore Y. Ts'o wrote:
> On Wed, Aug 28, 2019 at 10:05:11PM +1000, Matthew Bobrowski wrote:
> > > What is not clear to me at this point though is whether it is still
> > > necessary to explicitly track unwritten extents via in-core inode
> > > attributes i.e. ->i_unwritten and ->i_state_flags under the new direct
> > > IO code path implementation, which makes use of the iomap
> > > infrastructure. Or, whether we can get away with simply not using
> > > these in-core inode attributes and rely just on checks against the
> > > extent record directly, as breifly mentioned by Darrick. I would think
> > > that this type of check would be enough, however the checks around
> > > whether the inode is currently undergoing direct IO were implemented
> > > at some point, so there must be a reason for having them
> > > (a9b8241594add)?
> 
> The original reason why we created the DIO_STATE_UNWRITTEN flag was a
> fast path, where the common case is writing blocks to an existing
> location in a file where the blocks are already allocated, and marked
> as written.  So consulting the on-disk extent tree to determine
> whether unwritten extents need to be converted and/or split is
> certainly doable.  However, it's expensive for the common case.  So
> having a hint whether we need to schedule a workqueue to possibly
> convert an unwritten region is helpful.  If we can just free the bio
> and exit the I/O completion handler without having to take shared
> locks to examine the on-disk extent tree, so much the better.

Yes, but for determining whether extent conversion on IO completion is
needed we now use IOMAP_DIO_UNWRITTEN flag iomap infrastructure provides to
us. So we don't have to track this internally in ext4 anymore.

> > Maybe it's a silly question, although I'm wanting to clarify my
> > understanding around why it is that when we either try prepend or
> > append to an existing extent, we don't permit merging of extents if
> 
> If I recall correctly, the reason for this check was mainly the
> concern that we would end up merging an extent that we would then have
> to split later on (when the direct I/O completed).
> 
> To be honest, i'm not 100% sure what would happen if we removed that
> restriction; it might be that things would work just fine (just slower
> in some workloads), or whether there is some hidden dependency that
> would explode.  I suspect we'd have to try the experiment to be sure.

As far as I remember the concern was that extent split may need block
allocation and we may not have enough free blocks to do it. These days we
have some blocks reserved in the filesystem to accomodate unexpected extent
splits so this shouldn't happen anymore so the only real concern is the
wasted performance due to unnecessary extent merge & split. Kind of a
stress test for this would be to fire of lots of sequential AIO DIO
requests against a hole in a file.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
