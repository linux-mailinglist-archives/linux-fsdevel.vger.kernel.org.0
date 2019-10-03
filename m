Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34E13CA136
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2019 17:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730225AbfJCPhn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Oct 2019 11:37:43 -0400
Received: from fieldses.org ([173.255.197.46]:41654 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727302AbfJCPhn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Oct 2019 11:37:43 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 195AB322; Thu,  3 Oct 2019 11:37:43 -0400 (EDT)
Date:   Thu, 3 Oct 2019 11:37:43 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: Lease semantic proposal
Message-ID: <20191003153743.GA24657@fieldses.org>
References: <20190923190853.GA3781@iweiny-DESK2.sc.intel.com>
 <5d5a93637934867e1b3352763da8e3d9f9e6d683.camel@kernel.org>
 <20191001181659.GA5500@iweiny-DESK2.sc.intel.com>
 <2b42cf4ae669cedd061c937103674babad758712.camel@kernel.org>
 <20191002192711.GA21386@fieldses.org>
 <df9022f0f5d18d71f37ed494a05eaa4509cf0a68.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df9022f0f5d18d71f37ed494a05eaa4509cf0a68.camel@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 02, 2019 at 04:35:55PM -0400, Jeff Layton wrote:
> On Wed, 2019-10-02 at 15:27 -0400, J. Bruce Fields wrote:
> > On Wed, Oct 02, 2019 at 08:28:40AM -0400, Jeff Layton wrote:
> > > For the byte ranges, the catch there is that extending the userland
> > > interface for that later will be difficult.
> > 
> > Why would it be difficult?
> 
> Legacy userland code that wanted to use byte range enabled layouts would
> have to be rebuilt to take advantage of them. If we require a range from
> the get-go, then they will get the benefit of them once they're
> available.

I can't see writing byte-range code for a kernel that doesn't support
that yet.  How would I test it?

> > > What I'd probably suggest
> > > (and what would jive with the way pNFS works) would be to go ahead and
> > > add an offset and length to the arguments and result (maybe also
> > > whence?).
> > 
> > Why not add new commands with range arguments later if it turns out to
> > be necessary?
> 
> We could do that. It'd be a little ugly, IMO, simply because then we'd
> end up with two interfaces that do almost the exact same thing.
> 
> Should byte-range layouts at that point conflict with non-byte range
> layouts, or should they be in different "spaces" (a'la POSIX and flock
> locks)? When it's all one interface, those sorts of questions sort of
> answer themselves. When they aren't we'll have to document them clearly
> and I think the result will be more confusing for userland programmers.

I was hoping they'd be in the same space, with the old interface just
defined to deal in locks with range [0,∞).

I'm just worried about getting the interface wrong if it's specified
without being implemented.  Maybe this is straightforward enough that
there's not a risk, I don't know.

--b.

