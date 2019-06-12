Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5B2448EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 19:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393446AbfFMRME (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 13:12:04 -0400
Received: from mga01.intel.com ([192.55.52.88]:41922 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729072AbfFLWMS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 18:12:18 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2019 15:12:17 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga004.jf.intel.com with ESMTP; 12 Jun 2019 15:12:16 -0700
Date:   Wed, 12 Jun 2019 15:13:36 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jan Kara <jack@suse.cz>, Dan Williams <dan.j.williams@intel.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Jeff Layton <jlayton@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH RFC 00/10] RDMA/FS DAX truncate proposal
Message-ID: <20190612221336.GA27080@iweiny-DESK2.sc.intel.com>
References: <20190606104203.GF7433@quack2.suse.cz>
 <20190606195114.GA30714@ziepe.ca>
 <20190606222228.GB11698@iweiny-DESK2.sc.intel.com>
 <20190607103636.GA12765@quack2.suse.cz>
 <20190607121729.GA14802@ziepe.ca>
 <20190607145213.GB14559@iweiny-DESK2.sc.intel.com>
 <20190612102917.GB14578@quack2.suse.cz>
 <20190612114721.GB3876@ziepe.ca>
 <20190612120907.GC14578@quack2.suse.cz>
 <20190612191421.GM3876@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612191421.GM3876@ziepe.ca>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 12, 2019 at 04:14:21PM -0300, Jason Gunthorpe wrote:
> On Wed, Jun 12, 2019 at 02:09:07PM +0200, Jan Kara wrote:
> > On Wed 12-06-19 08:47:21, Jason Gunthorpe wrote:
> > > On Wed, Jun 12, 2019 at 12:29:17PM +0200, Jan Kara wrote:
> > > 
> > > > > > The main objection to the current ODP & DAX solution is that very
> > > > > > little HW can actually implement it, having the alternative still
> > > > > > require HW support doesn't seem like progress.
> > > > > > 
> > > > > > I think we will eventually start seein some HW be able to do this
> > > > > > invalidation, but it won't be universal, and I'd rather leave it
> > > > > > optional, for recovery from truely catastrophic errors (ie my DAX is
> > > > > > on fire, I need to unplug it).
> > > > > 
> > > > > Agreed.  I think software wise there is not much some of the devices can do
> > > > > with such an "invalidate".
> > > > 
> > > > So out of curiosity: What does RDMA driver do when userspace just closes
> > > > the file pointing to RDMA object? It has to handle that somehow by aborting
> > > > everything that's going on... And I wanted similar behavior here.
> > > 
> > > It aborts *everything* connected to that file descriptor. Destroying
> > > everything avoids creating inconsistencies that destroying a subset
> > > would create.
> > > 
> > > What has been talked about for lease break is not destroying anything
> > > but very selectively saying that one memory region linked to the GUP
> > > is no longer functional.
> > 
> > OK, so what I had in mind was that if RDMA app doesn't play by the rules
> > and closes the file with existing pins (and thus layout lease) we would
> > force it to abort everything. Yes, it is disruptive but then the app didn't
> > obey the rule that it has to maintain file lease while holding pins. Thus
> > such situation should never happen unless the app is malicious / buggy.
> 
> We do have the infrastructure to completely revoke the entire
> *content* of a FD (this is called device disassociate). It is
> basically close without the app doing close. But again it only works
> with some drivers. However, this is more likely something a driver
> could support without a HW change though.
> 
> It is quite destructive as it forcibly kills everything RDMA related
> the process(es) are doing, but it is less violent than SIGKILL, and
> there is perhaps a way for the app to recover from this, if it is
> coded for it.

I don't think many are...  I think most would effectively be "killed" if this
happened to them.

> 
> My preference would be to avoid this scenario, but if it is really
> necessary, we could probably build it with some work.
> 
> The only case we use it today is forced HW hot unplug, so it is rarely
> used and only for an 'emergency' like use case.

I'd really like to avoid this as well.  I think it will be very confusing for
RDMA apps to have their context suddenly be invalid.  I think if we have a way
for admins to ID who is pinning a file the admin can take more appropriate
action on those processes.   Up to and including killing the process.

Ira

