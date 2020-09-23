Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B4627503C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 07:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgIWFRD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Sep 2020 01:17:03 -0400
Received: from verein.lst.de ([213.95.11.211]:47202 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbgIWFRD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Sep 2020 01:17:03 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CB89E68AFE; Wed, 23 Sep 2020 07:16:58 +0200 (CEST)
Date:   Wed, 23 Sep 2020 07:16:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        hch@lst.de, johannes.thumshirn@wdc.com, dsterba@suse.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 04/15] iomap: Call inode_dio_end() before
 generic_write_sync()
Message-ID: <20200923051658.GA14957@lst.de>
References: <20200921144353.31319-1-rgoldwyn@suse.de> <20200921144353.31319-5-rgoldwyn@suse.de> <20bf949a-7237-8409-4230-cddb430026a9@toxicpanda.com> <20200922163156.GD7949@magnolia> <20200922214934.GC12096@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922214934.GC12096@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 23, 2020 at 07:49:34AM +1000, Dave Chinner wrote:
> I did point out in the previous thread that this actually means that
> inode_dio_wait() now has inconsistent wait semantics for O_DSYNC
> writes. If it's a pure overwrite and we hit the FUA path, the
> O_DSYNC write will be complete and guaranteed to be on stable storage
> before the IO completes. If the inode is metadata dirty, then the IO
> will now be signalled complete *before* the data and metadata are
> flushed to stable storage.
> 
> Hence, from the perspective of writes to *stable* storage, this
> makes the ordering of O_DSYNC DIO against anything waiting for it to
> complete to be potentially inconsistent at the stable storage level.
> 
> That's an extremely subtle change of behaviour, and something that
> would be largely impossible to test or reproduce. And, really, I
> don't like having this sort of "oh, it should be fine" handwavy
> justification when we are talking about data integrity operations...

... and I replied with a detailed analysis of what it is fine, and
how this just restores the behavior we historically had before
switching to the iomap direct I/O code.  Although if we want to go
into the fine details we did not have the REQ_FUA path back then,
but that does not change the analysis.
