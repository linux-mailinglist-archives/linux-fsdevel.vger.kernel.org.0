Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8647B37952
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 18:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbfFFQPw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 12:15:52 -0400
Received: from mga02.intel.com ([134.134.136.20]:55622 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729165AbfFFQPv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 12:15:51 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jun 2019 09:15:50 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga006.fm.intel.com with ESMTP; 06 Jun 2019 09:15:50 -0700
Date:   Thu, 6 Jun 2019 09:17:02 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Dan Williams <dan.j.williams@intel.com>,
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
Subject: Re: [PATCH RFC 07/10] fs/ext4: Fail truncate if pages are GUP pinned
Message-ID: <20190606161702.GA11374@iweiny-DESK2.sc.intel.com>
References: <20190606014544.8339-1-ira.weiny@intel.com>
 <20190606014544.8339-8-ira.weiny@intel.com>
 <20190606105855.GG7433@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606105855.GG7433@quack2.suse.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 06, 2019 at 12:58:55PM +0200, Jan Kara wrote:
> On Wed 05-06-19 18:45:40, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > If pages are actively gup pinned fail the truncate operation.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >  fs/ext4/inode.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index 75f543f384e4..1ded83ec08c0 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -4250,6 +4250,9 @@ int ext4_break_layouts(struct inode *inode, loff_t offset, loff_t len)
> >  		if (!page)
> >  			return 0;
> >  
> > +		if (page_gup_pinned(page))
> > +			return -ETXTBSY;
> > +
> >  		error = ___wait_var_event(&page->_refcount,
> >  				atomic_read(&page->_refcount) == 1,
> >  				TASK_INTERRUPTIBLE, 0, 0,
> 
> This caught my eye. Does this mean that now truncate for a file which has
> temporary gup users (such buffers for DIO) can fail with ETXTBUSY?

I thought about that before and I _thought_ I had accounted for it.  But I
think you are right...

>
> That
> doesn't look desirable.

No not desirable at all...  Ah it just dawned on my why I thought it was ok...
I was wrong.  :-/

> If we would mandate layout lease while pages are
> pinned as I suggested, this could be dealt with by checking for leases with
> pins (breaking such lease would return error and not break it) and if
> breaking leases succeeds (i.e., there are no long-term pinned pages), we'd
> just wait for the remaining references as we do now.

Agreed.

But I'm going to respond with some of the challenges of this (and ideas I had)
when replying to your other email.

Ira

> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
