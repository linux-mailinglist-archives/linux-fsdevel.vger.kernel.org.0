Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7561F8D204
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2019 13:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfHNLVi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 07:21:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:59084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbfHNLVi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 07:21:38 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBA7C2083B;
        Wed, 14 Aug 2019 11:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565781697;
        bh=lKWyQhJZrTeR2mP8gMp1Sv43C4kaU0ItcD8UjHsGR64=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=GoyIEeuy2aBMsczZxEjc418vIh6+C2Y2j1zEoa7vlM8xwuZ9K4Lx8mUTo+P3ENh3z
         i4MieExVH35FpkJHKYrGnkalqrRJH19Pu0e79zbx70z//5lRJAjmuuStGEMPll9gj8
         tcxu2X2I5qV6B/uj35CVsKOn4wUIaS2xvX5qVcac=
Message-ID: <1ba29bfa22f82e6d880ab31c3835047f3353f05a.camel@kernel.org>
Subject: Re: [RFC PATCH v2 01/19] fs/locks: Export F_LAYOUT lease to user
 space
From:   Jeff Layton <jlayton@kernel.org>
To:     Dave Chinner <david@fromorbit.com>, Ira Weiny <ira.weiny@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>, linux-xfs@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org
Date:   Wed, 14 Aug 2019 07:21:34 -0400
In-Reply-To: <20190814080547.GJ6129@dread.disaster.area>
References: <20190809225833.6657-1-ira.weiny@intel.com>
         <20190809225833.6657-2-ira.weiny@intel.com>
         <20190809235231.GC7777@dread.disaster.area>
         <20190812173626.GB19746@iweiny-DESK2.sc.intel.com>
         <20190814080547.GJ6129@dread.disaster.area>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2019-08-14 at 18:05 +1000, Dave Chinner wrote:
> On Mon, Aug 12, 2019 at 10:36:26AM -0700, Ira Weiny wrote:
> > On Sat, Aug 10, 2019 at 09:52:31AM +1000, Dave Chinner wrote:
> > > On Fri, Aug 09, 2019 at 03:58:15PM -0700, ira.weiny@intel.com wrote:
> > > > +	/*
> > > > +	 * NOTE on F_LAYOUT lease
> > > > +	 *
> > > > +	 * LAYOUT lease types are taken on files which the user knows that
> > > > +	 * they will be pinning in memory for some indeterminate amount of
> > > > +	 * time.
> > > 
> > > Indeed, layout leases have nothing to do with pinning of memory.
> > 
> > Yep, Fair enough.  I'll rework the comment.
> > 
> > > That's something an application taht uses layout leases might do,
> > > but it largely irrelevant to the functionality layout leases
> > > provide. What needs to be done here is explain what the layout lease
> > > API actually guarantees w.r.t. the physical file layout, not what
> > > some application is going to do with a lease. e.g.
> > > 
> > > 	The layout lease F_RDLCK guarantees that the holder will be
> > > 	notified that the physical file layout is about to be
> > > 	changed, and that it needs to release any resources it has
> > > 	over the range of this lease, drop the lease and then
> > > 	request it again to wait for the kernel to finish whatever
> > > 	it is doing on that range.
> > > 
> > > 	The layout lease F_RDLCK also allows the holder to modify
> > > 	the physical layout of the file. If an operation from the
> > > 	lease holder occurs that would modify the layout, that lease
> > > 	holder does not get notification that a change will occur,
> > > 	but it will block until all other F_RDLCK leases have been
> > > 	released by their holders before going ahead.
> > > 
> > > 	If there is a F_WRLCK lease held on the file, then a F_RDLCK
> > > 	holder will fail any operation that may modify the physical
> > > 	layout of the file. F_WRLCK provides exclusive physical
> > > 	modification access to the holder, guaranteeing nothing else
> > > 	will change the layout of the file while it holds the lease.
> > > 
> > > 	The F_WRLCK holder can change the physical layout of the
> > > 	file if it so desires, this will block while F_RDLCK holders
> > > 	are notified and release their leases before the
> > > 	modification will take place.
> > > 
> > > We need to define the semantics we expose to userspace first.....

Absolutely.

> > 
> > Agreed.  I believe I have implemented the semantics you describe above.  Do I
> > have your permission to use your verbiage as part of reworking the comment and
> > commit message?
> 
> Of course. :)
> 
> Cheers,
> 

I'll review this in more detail soon, but subsequent postings of the set
should probably also go to linux-api mailing list. This is a significant
API change. It might not also hurt to get the glibc folks involved here
too since you'll probably want to add the constants to the headers there
as well.

Finally, consider going ahead and drafting a patch to the fcntl(2)
manpage if you think you have the API mostly nailed down. This API is a
little counterintuitive (i.e. you can change the layout with an F_RDLCK
lease), so it will need to be very clearly documented. I've also found
that when creating a new API, documenting it tends to help highlight its
warts and areas where the behavior is not clearly defined.

-- 
Jeff Layton <jlayton@kernel.org>

