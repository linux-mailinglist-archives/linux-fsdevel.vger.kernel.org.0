Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74CAA4D0F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2019 16:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732020AbfFTOw5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jun 2019 10:52:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:60284 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726675AbfFTOw5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jun 2019 10:52:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 327B0AE32;
        Thu, 20 Jun 2019 14:52:55 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AF6F01E434F; Thu, 20 Jun 2019 16:52:54 +0200 (CEST)
Date:   Thu, 20 Jun 2019 16:52:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Jeff Layton <jlayton@kernel.org>, linux-xfs@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH RFC 00/10] RDMA/FS DAX truncate proposal
Message-ID: <20190620145254.GJ30243@quack2.suse.cz>
References: <20190606014544.8339-1-ira.weiny@intel.com>
 <20190606104203.GF7433@quack2.suse.cz>
 <20190606220329.GA11698@iweiny-DESK2.sc.intel.com>
 <20190607110426.GB12765@quack2.suse.cz>
 <20190607182534.GC14559@iweiny-DESK2.sc.intel.com>
 <20190608001036.GF14308@dread.disaster.area>
 <20190612123751.GD32656@bombadil.infradead.org>
 <20190613002555.GH14363@dread.disaster.area>
 <20190613152755.GI32656@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613152755.GI32656@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 13-06-19 08:27:55, Matthew Wilcox wrote:
> On Thu, Jun 13, 2019 at 10:25:55AM +1000, Dave Chinner wrote:
> > e.g. Process A has an exclusive layout lease on file F. It does an
> > IO to file F. The filesystem IO path checks that Process A owns the
> > lease on the file and so skips straight through layout breaking
> > because it owns the lease and is allowed to modify the layout. It
> > then takes the inode metadata locks to allocate new space and write
> > new data.
> > 
> > Process B now tries to write to file F. The FS checks whether
> > Process B owns a layout lease on file F. It doesn't, so then it
> > tries to break the layout lease so the IO can proceed. The layout
> > breaking code sees that process A has an exclusive layout lease
> > granted, and so returns -ETXTBSY to process B - it is not allowed to
> > break the lease and so the IO fails with -ETXTBSY.
> 
> This description doesn't match the behaviour that RDMA wants either.
> Even if Process A has a lease on the file, an IO from Process A which
> results in blocks being freed from the file is going to result in the
> RDMA device being able to write to blocks which are now freed (and
> potentially reallocated to another file).

I think you're partially wrong here. You are correct that the lease won't
stop process A from doing truncate on the file. *But* there are still page
pins in existence so truncate will block on waiting for these pins to go
away (after all this is a protection that guards all short-term page pin
users). So there is no problem with blocks being freed under the RDMA app.
Yes, the app will effectively deadlock and sysadmin has to kill it. IMO an
acceptable answer for doing something stupid and unsupportable...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
