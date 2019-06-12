Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB0514250E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2019 14:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438621AbfFLMJN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jun 2019 08:09:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:44682 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405581AbfFLMJM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:09:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 83424AE27;
        Wed, 12 Jun 2019 12:09:09 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A86331E4328; Wed, 12 Jun 2019 14:09:07 +0200 (CEST)
Date:   Wed, 12 Jun 2019 14:09:07 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jan Kara <jack@suse.cz>, Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
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
Message-ID: <20190612120907.GC14578@quack2.suse.cz>
References: <20190606014544.8339-1-ira.weiny@intel.com>
 <20190606104203.GF7433@quack2.suse.cz>
 <20190606195114.GA30714@ziepe.ca>
 <20190606222228.GB11698@iweiny-DESK2.sc.intel.com>
 <20190607103636.GA12765@quack2.suse.cz>
 <20190607121729.GA14802@ziepe.ca>
 <20190607145213.GB14559@iweiny-DESK2.sc.intel.com>
 <20190612102917.GB14578@quack2.suse.cz>
 <20190612114721.GB3876@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612114721.GB3876@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 12-06-19 08:47:21, Jason Gunthorpe wrote:
> On Wed, Jun 12, 2019 at 12:29:17PM +0200, Jan Kara wrote:
> 
> > > > The main objection to the current ODP & DAX solution is that very
> > > > little HW can actually implement it, having the alternative still
> > > > require HW support doesn't seem like progress.
> > > > 
> > > > I think we will eventually start seein some HW be able to do this
> > > > invalidation, but it won't be universal, and I'd rather leave it
> > > > optional, for recovery from truely catastrophic errors (ie my DAX is
> > > > on fire, I need to unplug it).
> > > 
> > > Agreed.  I think software wise there is not much some of the devices can do
> > > with such an "invalidate".
> > 
> > So out of curiosity: What does RDMA driver do when userspace just closes
> > the file pointing to RDMA object? It has to handle that somehow by aborting
> > everything that's going on... And I wanted similar behavior here.
> 
> It aborts *everything* connected to that file descriptor. Destroying
> everything avoids creating inconsistencies that destroying a subset
> would create.
> 
> What has been talked about for lease break is not destroying anything
> but very selectively saying that one memory region linked to the GUP
> is no longer functional.

OK, so what I had in mind was that if RDMA app doesn't play by the rules
and closes the file with existing pins (and thus layout lease) we would
force it to abort everything. Yes, it is disruptive but then the app didn't
obey the rule that it has to maintain file lease while holding pins. Thus
such situation should never happen unless the app is malicious / buggy.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
