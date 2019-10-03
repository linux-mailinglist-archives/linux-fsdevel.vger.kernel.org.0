Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8F7DC9A57
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2019 11:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbfJCJAw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Oct 2019 05:00:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:50004 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727611AbfJCJAv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Oct 2019 05:00:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 60B8DB144;
        Thu,  3 Oct 2019 09:00:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 534081E4810; Thu,  3 Oct 2019 11:01:10 +0200 (CEST)
Date:   Thu, 3 Oct 2019 11:01:10 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: Lease semantic proposal
Message-ID: <20191003090110.GC17911@quack2.suse.cz>
References: <20190923190853.GA3781@iweiny-DESK2.sc.intel.com>
 <5d5a93637934867e1b3352763da8e3d9f9e6d683.camel@kernel.org>
 <20191001181659.GA5500@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001181659.GA5500@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 01-10-19 11:17:00, Ira Weiny wrote:
> On Mon, Sep 23, 2019 at 04:17:59PM -0400, Jeff Layton wrote:
> > On Mon, 2019-09-23 at 12:08 -0700, Ira Weiny wrote:
> > 
> > Will userland require any special privileges in order to set an
> > F_UNBREAK lease? This seems like something that could be used for DoS. I
> > assume that these will never time out.
> 
> Dan and I discussed this some more and yes I think the uid of the process needs
> to be the owner of the file.  I think that is a reasonable mechanism.

Honestly, I'm not convinced anything more than open-for-write should be
required. Sure unbreakable lease may result in failing truncate and other
ops but as we discussed at LFS/MM, this is not hugely different from
executing a file resulting in ETXTBUSY for any truncate attempt (even from
root). So sufficiently priviledged user has to be able to easily find which
process(es) owns the lease so that he can kill it / take other
administrative action to release the lease. But that's about it.
 
> > How will we deal with the case where something is is squatting on an
> > F_UNBREAK lease and isn't letting it go?
> 
> That is a good question.  I had not considered someone taking the UNBREAK
> without pinning the file.

IMHO the same answer as above - sufficiently priviledged user should be
able to easily find the process holding the lease and kill it. Given the
lease owner has to have write access to the file, he better should be from
the same "security domain"...

> > Leases are technically "owned" by the file description -- we can't
> > necessarily trace it back to a single task in a threaded program. The
> > kernel task that set the lease may have exited by the time we go
> > looking.
> > 
> > Will we be content trying to determine this using /proc/locks+lsof, etc,
> > or will we need something better?
> 
> I think using /proc/locks is our best bet.  Similar to my intention to report
> files being pinned.[1]
> 
> In fact should we consider files with F_UNBREAK leases "pinned" and just report
> them there?

As Jeff wrote later, /proc/locks is not enough. You need PID(s) which have
access to the lease and hold it alive. Your /proc/<pid>/ files you had in your
patches should do that, shouldn't they? Maybe they were not tied to the
right structure... They really need to be tied to the existence of a lease.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
