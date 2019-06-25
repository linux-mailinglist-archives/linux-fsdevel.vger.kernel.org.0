Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6256652966
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2019 12:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfFYKZm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 06:25:42 -0400
Received: from verein.lst.de ([213.95.11.211]:33555 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbfFYKZm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 06:25:42 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id D2C6D68C7B; Tue, 25 Jun 2019 12:25:08 +0200 (CEST)
Date:   Tue, 25 Jun 2019 12:25:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/12] xfs: don't preallocate a transaction for file
 size updates
Message-ID: <20190625102507.GA1986@lst.de>
References: <20190624055253.31183-1-hch@lst.de> <20190624055253.31183-8-hch@lst.de> <20190624161720.GQ5387@magnolia> <20190624231523.GC7777@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624231523.GC7777@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 25, 2019 at 09:15:23AM +1000, Dave Chinner wrote:
> > So, uh, how much of a hit do we take for having to allocate a
> > transaction for a file size extension?  Particularly since we can
> > combine those things now?
> 
> Unless we are out of log space, the transaction allocation and free
> should be largely uncontended and so it's just a small amount of CPU
> usage. i.e it's a slab allocation/free and then lockless space
> reservation/free. If we are out of log space, then we sleep waiting
> for space - the issue really comes down to where it is better to
> sleep in that case....

I see the general point, but we'll still have the same issue with
unwritten extent conversion and cow completions, and I don't remember
seeing any issue in that regard.  And we'd hit exactly that case
with random writes to preallocated or COW files, i.e. the typical image
file workload.
