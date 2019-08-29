Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58D8AA11D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 08:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbfH2GgP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 02:36:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40996 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfH2GgP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 02:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6ZKZa5hSMyLHv6xLpJiz9k1EsszZdKKsEOVr1o0T8zI=; b=HVK2/OylhsOIfK+T9ZRGZr5so
        d9KUjw/GBIRsWH9jViIx8pu/Fk5ovr6r7y3flYq308m3C/sgfBsvMYYjM/qXXyQYppZoMfJoEWBD5
        rjD0/tFY1VEzf3ofwUh3twPbXnDaGIeMA6rsAuoPMeDvSBBfvwFmEV9DmfEHtaDp3hS610Y36uWc8
        +i/j50c6Z7TAKHGT9UGkbBDb1g7kqibNzlMJGuHkFbRjf6BT1NmwvFsLt94SmZVJilkLfrIfSRy3y
        Gu1IpLEmr+I2LVCXJC3xB91zQ/8xLNDsB2DzMvaqzm2rkjwi4nVIrRrHu6COPqlWn5UuPI24M5RxK
        cOPcdJ0JQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i3E2S-0007LA-Jx; Thu, 29 Aug 2019 06:36:08 +0000
Date:   Wed, 28 Aug 2019 23:36:08 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, aneesh.kumar@linux.ibm.com
Subject: Re: [PATCH 0/5] ext4: direct IO via iomap infrastructure
Message-ID: <20190829063608.GA17426@infradead.org>
References: <20190821131405.GC24417@poseidon.bobrowski.net>
 <20190822120015.GA3330@poseidon.bobrowski.net>
 <20190822141126.70A94A407B@d06av23.portsmouth.uk.ibm.com>
 <20190824031830.GB2174@poseidon.bobrowski.net>
 <20190824035554.GA1037502@magnolia>
 <20190824230427.GA32012@infradead.org>
 <20190827095221.GA1568@poseidon.bobrowski.net>
 <20190828120509.GC22165@poseidon.bobrowski.net>
 <20190828142729.GB24857@mit.edu>
 <20190828180215.GE22343@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828180215.GE22343@quack2.suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 28, 2019 at 08:02:15PM +0200, Jan Kara wrote:
> > The original reason why we created the DIO_STATE_UNWRITTEN flag was a
> > fast path, where the common case is writing blocks to an existing
> > location in a file where the blocks are already allocated, and marked
> > as written.  So consulting the on-disk extent tree to determine
> > whether unwritten extents need to be converted and/or split is
> > certainly doable.  However, it's expensive for the common case.  So
> > having a hint whether we need to schedule a workqueue to possibly
> > convert an unwritten region is helpful.  If we can just free the bio
> > and exit the I/O completion handler without having to take shared
> > locks to examine the on-disk extent tree, so much the better.
> 
> Yes, but for determining whether extent conversion on IO completion is
> needed we now use IOMAP_DIO_UNWRITTEN flag iomap infrastructure provides to
> us. So we don't have to track this internally in ext4 anymore.

Exactly.  As mentioned before the ioend to track unwritten thing was
in XFS by the time ext4 copied the ioend approach. but we actually got
rid of that long before the iomap conversion.  Maybe to make everything
easier to understand and bisect you might want to get rid of the ioend
for direct I/O in ext4 as a prep path as well.

The relevant commit is: 273dda76f757 ("xfs: don't use ioends for direct
write completions")

> > To be honest, i'm not 100% sure what would happen if we removed that
> > restriction; it might be that things would work just fine (just slower
> > in some workloads), or whether there is some hidden dependency that
> > would explode.  I suspect we'd have to try the experiment to be sure.
> 
> As far as I remember the concern was that extent split may need block
> allocation and we may not have enough free blocks to do it. These days we
> have some blocks reserved in the filesystem to accomodate unexpected extent
> splits so this shouldn't happen anymore so the only real concern is the
> wasted performance due to unnecessary extent merge & split. Kind of a
> stress test for this would be to fire of lots of sequential AIO DIO
> requests against a hole in a file.

Well, you can always add a don't merge flag to the actual allocation.
You might still get a merge for pathological case (fallocate adjacent
to a dio write just submitted), but if the merging is such a performance
over head here is easy ways to avoid it for the common case.
