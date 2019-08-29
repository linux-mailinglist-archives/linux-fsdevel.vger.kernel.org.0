Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3C33A267A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 20:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbfH2SwR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 14:52:17 -0400
Received: from mga17.intel.com ([192.55.52.151]:43358 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727798AbfH2SwR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:52:17 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 11:52:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,444,1559545200"; 
   d="scan'208";a="180965850"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga008.fm.intel.com with ESMTP; 29 Aug 2019 11:52:15 -0700
Date:   Thu, 29 Aug 2019 11:52:15 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
        linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Dave Chinner <david@fromorbit.com>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 06/19] fs/ext4: Teach dax_layout_busy_page() to
 operate on a sub-range
Message-ID: <20190829185215.GC18249@iweiny-DESK2.sc.intel.com>
References: <20190809225833.6657-1-ira.weiny@intel.com>
 <20190809225833.6657-7-ira.weiny@intel.com>
 <20190823151826.GB11009@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823151826.GB11009@redhat.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 23, 2019 at 11:18:26AM -0400, Vivek Goyal wrote:
> On Fri, Aug 09, 2019 at 03:58:20PM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Callers of dax_layout_busy_page() are only rarely operating on the
> > entire file of concern.
> > 
> > Teach dax_layout_busy_page() to operate on a sub-range of the
> > address_space provided.  Specifying 0 - ULONG_MAX however, will continue
> > to operate on the "entire file" and XFS is split out to a separate patch
> > by this method.
> > 
> > This could potentially speed up dax_layout_busy_page() as well.
> 
> I need this functionality as well for virtio_fs and posted a patch for
> this.
> 
> https://lkml.org/lkml/2019/8/21/825
> 
> Given this is an optimization which existing users can benefit from already,
> this patch could probably be pushed upstream independently.

I'm ok with that.

However, this patch does not apply cleanly to head as I had some other
additions to dax.h.

> 
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > Changes from RFC v1
> > 	Fix 0-day build errors
> > 
> >  fs/dax.c            | 15 +++++++++++----
> >  fs/ext4/ext4.h      |  2 +-
> >  fs/ext4/extents.c   |  6 +++---
> >  fs/ext4/inode.c     | 19 ++++++++++++-------
> >  fs/xfs/xfs_file.c   |  3 ++-
> >  include/linux/dax.h |  6 ++++--
> >  6 files changed, 33 insertions(+), 18 deletions(-)
> > 
> > diff --git a/fs/dax.c b/fs/dax.c
> > index a14ec32255d8..3ad19c384454 100644
> > --- a/fs/dax.c
> > +++ b/fs/dax.c
> > @@ -573,8 +573,11 @@ bool dax_mapping_is_dax(struct address_space *mapping)
> >  EXPORT_SYMBOL_GPL(dax_mapping_is_dax);
> >  
> >  /**
> > - * dax_layout_busy_page - find first pinned page in @mapping
> > + * dax_layout_busy_page - find first pinned page in @mapping within
> > + *                        the range @off - @off + @len
> >   * @mapping: address space to scan for a page with ref count > 1
> > + * @off: offset to start at
> > + * @len: length to scan through
> >   *
> >   * DAX requires ZONE_DEVICE mapped pages. These pages are never
> >   * 'onlined' to the page allocator so they are considered idle when
> > @@ -587,9 +590,13 @@ EXPORT_SYMBOL_GPL(dax_mapping_is_dax);
> >   * to be able to run unmap_mapping_range() and subsequently not race
> >   * mapping_mapped() becoming true.
> >   */
> > -struct page *dax_layout_busy_page(struct address_space *mapping)
> > +struct page *dax_layout_busy_page(struct address_space *mapping,
> > +				  loff_t off, loff_t len)
> >  {
> > -	XA_STATE(xas, &mapping->i_pages, 0);
> > +	unsigned long start_idx = off >> PAGE_SHIFT;
> > +	unsigned long end_idx = (len == ULONG_MAX) ? ULONG_MAX
> > +				: start_idx + (len >> PAGE_SHIFT);
> > +	XA_STATE(xas, &mapping->i_pages, start_idx);
> >  	void *entry;
> >  	unsigned int scanned = 0;
> >  	struct page *page = NULL;
> > @@ -612,7 +619,7 @@ struct page *dax_layout_busy_page(struct address_space *mapping)
> >  	unmap_mapping_range(mapping, 0, 0, 1);
> 
> Should we unmap only those pages which fall in the range specified by caller.
> Unmapping whole file seems to be less efficient.

Seems reasonable to me.  I was focused on getting pages which were busy not
necessarily on what got unmapped.  So I did not consider this.  Thanks for the
suggestion.

However, I don't understand the math you do for length?  Is this comment/code
correct?

+  /* length is being calculated from lstart and not start.
+   * This is due to behavior of unmap_mapping_range(). If
+   * start is say 4094 and end is on 4093 then want to
+   * unamp two pages, idx 0 and 1. But unmap_mapping_range()
+   * will unmap only page at idx 0. If we calculate len
+   * from the rounded down start, this problem should not
+   * happen.
+   */
+  len = end - lstart + 1;


How can end (4093) be < start (4094)?  Is that valid?  And why would a start of
4094 unmap idx 0?

Ira

