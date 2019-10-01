Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46B74C423F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2019 23:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfJAVB7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Oct 2019 17:01:59 -0400
Received: from mga06.intel.com ([134.134.136.31]:60837 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726973AbfJAVB6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Oct 2019 17:01:58 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 14:01:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,572,1559545200"; 
   d="scan'208";a="343108957"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga004.jf.intel.com with ESMTP; 01 Oct 2019 14:01:57 -0700
Date:   Tue, 1 Oct 2019 14:01:57 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-mm@kvack.org, Jeff Layton <jlayton@kernel.org>,
        Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: Lease semantic proposal
Message-ID: <20191001210156.GB5500@iweiny-DESK2.sc.intel.com>
References: <20190923190853.GA3781@iweiny-DESK2.sc.intel.com>
 <20190923222620.GC16973@dread.disaster.area>
 <20190925234602.GB12748@iweiny-DESK2.sc.intel.com>
 <20190930084233.GO16973@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930084233.GO16973@dread.disaster.area>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 30, 2019 at 06:42:33PM +1000, Dave Chinner wrote:
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

This was not my understanding.

> IOWs, your definition of F_RDLCK | F_LAYOUT not being allowed
> to change the is in direct contradition to existing users.
> 
> I've said this several times over the past few months now: shared
> layout leases must allow layout modifications to be made.

I don't understand what the point of having a layout lease is then?

>
> Only
> allowing an exclusive layout lease to modify the layout rules out
> many potential use cases for direct data placement and p2p DMA
> applications,

How?  I think that having a typical design pattern of multiple readers
and only a single writer would actually make all these use cases easier.

> not to mention conflicts with the existing pNFS usage.

I apologize for not understanding this.  My reading of the code is that layout
changes require the read layout to be broken prior to proceeding.

The break layout code does this by creating a F_WRLCK of type FL_LAYOUT which
conflicts with the F_RDLCK of type FL_LAYOUT...

int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
{
...
        struct file_lock *new_fl, *fl, *tmp;
...

        new_fl = lease_alloc(NULL, want_write ? F_WRLCK : F_RDLCK, 0);
        if (IS_ERR(new_fl))
                return PTR_ERR(new_fl);
        new_fl->fl_flags = type;
...
        list_for_each_entry_safe(fl, tmp, &ctx->flc_lease, fl_list) {
                if (!leases_conflict(fl, new_fl))
                        continue;
...
}

type == FL_LAYOUT from the call here.

static inline int break_layout(struct inode *inode, bool wait)
{
        smp_mb();
        if (inode->i_flctx && !list_empty_careful(&inode->i_flctx->flc_lease))
                return __break_lease(inode,
                                wait ? O_WRONLY : O_WRONLY | O_NONBLOCK,
                                FL_LAYOUT);
        return 0;
}       

Also, I don't see any code which limits the number of read layout holders which
can be present and all of them will be revoked by the above code.

What am I missing?

Ira

