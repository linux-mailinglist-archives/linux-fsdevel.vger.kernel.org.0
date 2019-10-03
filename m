Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B903CAA73
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2019 19:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404364AbfJCRF0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Oct 2019 13:05:26 -0400
Received: from mga18.intel.com ([134.134.136.126]:14911 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393369AbfJCRFZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Oct 2019 13:05:25 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 10:05:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,253,1566889200"; 
   d="scan'208";a="392014697"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga005.fm.intel.com with ESMTP; 03 Oct 2019 10:05:23 -0700
Date:   Thu, 3 Oct 2019 10:05:23 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        Dave Chinner <david@fromorbit.com>,
        Theodore Ts'o <tytso@mit.edu>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: Lease semantic proposal
Message-ID: <20191003170523.GC31174@iweiny-DESK2.sc.intel.com>
References: <20190923190853.GA3781@iweiny-DESK2.sc.intel.com>
 <5d5a93637934867e1b3352763da8e3d9f9e6d683.camel@kernel.org>
 <20191001181659.GA5500@iweiny-DESK2.sc.intel.com>
 <20191003090110.GC17911@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003090110.GC17911@quack2.suse.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 03, 2019 at 11:01:10AM +0200, Jan Kara wrote:
> On Tue 01-10-19 11:17:00, Ira Weiny wrote:
> > On Mon, Sep 23, 2019 at 04:17:59PM -0400, Jeff Layton wrote:
> > > On Mon, 2019-09-23 at 12:08 -0700, Ira Weiny wrote:
> > > 
> > > Will userland require any special privileges in order to set an
> > > F_UNBREAK lease? This seems like something that could be used for DoS. I
> > > assume that these will never time out.
> > 
> > Dan and I discussed this some more and yes I think the uid of the process needs
> > to be the owner of the file.  I think that is a reasonable mechanism.
> 
> Honestly, I'm not convinced anything more than open-for-write should be
> required. Sure unbreakable lease may result in failing truncate and other
> ops but as we discussed at LFS/MM, this is not hugely different from
> executing a file resulting in ETXTBUSY for any truncate attempt (even from
> root). So sufficiently priviledged user has to be able to easily find which
> process(es) owns the lease so that he can kill it / take other
> administrative action to release the lease. But that's about it.

Well that was kind of what I was thinking.  However I wanted to be careful
about requiring write permission when doing a F_RDLCK.  I think that it has to
be clearly documented _why_ write permission is required.

>  
> > > How will we deal with the case where something is is squatting on an
> > > F_UNBREAK lease and isn't letting it go?
> > 
> > That is a good question.  I had not considered someone taking the UNBREAK
> > without pinning the file.
> 
> IMHO the same answer as above - sufficiently priviledged user should be
> able to easily find the process holding the lease and kill it. Given the
> lease owner has to have write access to the file, he better should be from
> the same "security domain"...
> 
> > > Leases are technically "owned" by the file description -- we can't
> > > necessarily trace it back to a single task in a threaded program. The
> > > kernel task that set the lease may have exited by the time we go
> > > looking.
> > > 
> > > Will we be content trying to determine this using /proc/locks+lsof, etc,
> > > or will we need something better?
> > 
> > I think using /proc/locks is our best bet.  Similar to my intention to report
> > files being pinned.[1]
> > 
> > In fact should we consider files with F_UNBREAK leases "pinned" and just report
> > them there?
> 
> As Jeff wrote later, /proc/locks is not enough. You need PID(s) which have
> access to the lease and hold it alive. Your /proc/<pid>/ files you had in your
> patches should do that, shouldn't they? Maybe they were not tied to the
> right structure... They really need to be tied to the existence of a lease.

Yes, sorry.  I misspoke above.

Right now /proc/<pid>/file_pins indicates that the file is pinned by GUP.  I
think it may be reasonable to extend that to any file which has F_UNBREAK
specified.  'file_pins' may be the wrong name when we include F_UNBREAK'ed
leased files, so I will think on the name.  But I think this is possible and
desired.

Ira

