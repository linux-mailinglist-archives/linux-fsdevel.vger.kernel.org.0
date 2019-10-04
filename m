Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D881CDF04
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2019 12:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbfJGKQV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Oct 2019 06:16:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:58894 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727755AbfJGKQV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Oct 2019 06:16:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 688B2B206;
        Mon,  7 Oct 2019 10:16:18 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E6A461E4813; Fri,  4 Oct 2019 09:51:00 +0200 (CEST)
Date:   Fri, 4 Oct 2019 09:51:00 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: Lease semantic proposal
Message-ID: <20191004075100.GA12412@quack2.suse.cz>
References: <20190923190853.GA3781@iweiny-DESK2.sc.intel.com>
 <20190923222620.GC16973@dread.disaster.area>
 <20190925234602.GB12748@iweiny-DESK2.sc.intel.com>
 <20190930084233.GO16973@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930084233.GO16973@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 30-09-19 18:42:33, Dave Chinner wrote:
> On Wed, Sep 25, 2019 at 04:46:03PM -0700, Ira Weiny wrote:
> > On Tue, Sep 24, 2019 at 08:26:20AM +1000, Dave Chinner wrote:
> > > Hence, AFIACT, the above definition of a F_RDLCK|F_LAYOUT lease
> > > doesn't appear to be compatible with the semantics required by
> > > existing users of layout leases.
> > 
> > I disagree.  Other than the addition of F_UNBREAK, I think this is consistent
> > with what is currently implemented.  Also, by exporting all this to user space
> > we can now write tests for it independent of the RDMA pinning.
> 
> The current usage of F_RDLCK | F_LAYOUT by the pNFS code allows
> layout changes to occur to the file while the layout lease is held.

I remember you saying that in the past conversations. But I agree with Ira
that I don't see where in the code this would be implemented. AFAICS
break_layout() called from xfs_break_leased_layouts() simply breaks all the
leases with F_LAYOUT set attached to the inode... Now I'm not any expert on
file leases but what am I missing?

> IOWs, your definition of F_RDLCK | F_LAYOUT not being allowed
> to change the is in direct contradition to existing users.
> 
> I've said this several times over the past few months now: shared
> layout leases must allow layout modifications to be made. Only
> allowing an exclusive layout lease to modify the layout rules out
> many potential use cases for direct data placement and p2p DMA
> applications, not to mention conflicts with the existing pNFS usage.
> Layout leases need to support more than just RDMA, and tailoring the
> API to exactly the immediate needs of RDMA is just going to make it
> useless for anything else.

I agree we should not tailor the layout lease definition to just RDMA
usecase. But let's talk about the semantics once our confusion about how
pNFS currently uses layout leases is clear out.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
