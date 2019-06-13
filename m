Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAF4D4446B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 18:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730815AbfFMQhA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 12:37:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:35270 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730526AbfFMHRx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 03:17:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 45815AF05;
        Thu, 13 Jun 2019 07:17:50 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 051E71E4328; Thu, 13 Jun 2019 09:17:47 +0200 (CEST)
Date:   Thu, 13 Jun 2019 09:17:47 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>,
        Ira Weiny <ira.weiny@intel.com>, Theodore Ts'o <tytso@mit.edu>,
        Jeff Layton <jlayton@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH RFC 00/10] RDMA/FS DAX truncate proposal
Message-ID: <20190613071746.GA26505@quack2.suse.cz>
References: <20190606104203.GF7433@quack2.suse.cz>
 <20190606195114.GA30714@ziepe.ca>
 <20190606222228.GB11698@iweiny-DESK2.sc.intel.com>
 <20190607103636.GA12765@quack2.suse.cz>
 <20190607121729.GA14802@ziepe.ca>
 <20190607145213.GB14559@iweiny-DESK2.sc.intel.com>
 <20190612102917.GB14578@quack2.suse.cz>
 <20190612114721.GB3876@ziepe.ca>
 <20190612120907.GC14578@quack2.suse.cz>
 <CAPcyv4ikn219XUgHwsPdYp06vBNAJB9Rk-hjZA-fYT4GB3gi+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4ikn219XUgHwsPdYp06vBNAJB9Rk-hjZA-fYT4GB3gi+w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 12-06-19 11:41:53, Dan Williams wrote:
> On Wed, Jun 12, 2019 at 5:09 AM Jan Kara <jack@suse.cz> wrote:
> >
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
> When you say 'close' do you mean the final release of the fd? The vma
> keeps a reference to a 'struct file' live even after the fd is closed.

When I say 'close', I mean a call to ->release file operation which happens
when the last reference to struct file is dropped. I.e., when all file
descriptors and vmas (and possibly other places holding struct file
reference) are gone.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
