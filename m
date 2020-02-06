Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32FF2154653
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 15:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgBFOg3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 09:36:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:49540 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727861AbgBFOg3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 09:36:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CDD29AC91;
        Thu,  6 Feb 2020 14:36:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 862E01E0DEB; Thu,  6 Feb 2020 15:36:27 +0100 (CET)
Date:   Thu, 6 Feb 2020 15:36:27 +0100
From:   Jan Kara <jack@suse.cz>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 8/8] xarray: Don't clear marks in xas_store()
Message-ID: <20200206143627.GA26114@quack2.suse.cz>
References: <20200204142514.15826-1-jack@suse.cz>
 <20200204142514.15826-9-jack@suse.cz>
 <20200205184344.GB28298@ziepe.ca>
 <20200205215904.GT8731@bombadil.infradead.org>
 <20200206134904.GD25297@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206134904.GD25297@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 06-02-20 09:49:04, Jason Gunthorpe wrote:
> On Wed, Feb 05, 2020 at 01:59:04PM -0800, Matthew Wilcox wrote:
> 
> > > How is RCU mark reading used anyhow?
> > 
> > We iterate over pages in the page cache with, eg, the dirty bit set.
> > This bug will lead to the loop terminating early and failing to find
> > dirty pages that it should.
> 
> But the inhernetly weak sync of marks and pointers means that
> iteration will miss some dirty pages and return some clean pages. It
> is all OK for some reason?

Yes. The reason is - the definitive source of dirtiness is in page flags so
if iteration returns more pages, we don't care. WRT missing pages we only
need to make sure pages that were dirty before the iteration started are
returned and the current code fulfills that.

> > > Actually the clearing of marks by xa_store(, NULL) is creating a very
> > > subtle bug in drivers/infiniband/core/device.c :( Can you add a Fixes
> > > line too:
> > > 
> > > ib_set_client_data() is assuming the marks for the entry will not
> > > change, but if the caller passed in NULL they get wrongly reset, and
> > > three call sites pass in NULL:
> > >  drivers/infiniband/ulp/srpt/ib_srpt.c
> > >  net/rds/ib.c
> > >  net/smc/smc_ib.c
> > > Fixes: 0df91bb67334 ("RDMA/devices: Use xarray to store the client_data")
> > 
> > There's no bug here.
> > 
> > If you're actually storing NULL in the array, then the marks would go
> > away.  That's inherent -- imagine you have an array with a single entry
> > at 64.  Then you store NULL there.  That causes the node to be deleted,
> > and the marks must necessarily disappear with it -- there's nowhere to
> > store them!
> 
> Ah, it is allocating! These little behavior differences are tricky to
> remember over with infrequent use :(

Yeah, that's why I'd prefer if NULL was not "special value" at all and if
someone wanted to remove index from xarray he'd always have to use a
special function. My patches go towards that direction but not the full way
because there's still xa_cmpxchg() whose users use the fact that NULL is in
fact 'erase'.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
