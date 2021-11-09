Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E8544A647
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 06:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbhKIF33 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 00:29:29 -0500
Received: from mga04.intel.com ([192.55.52.120]:7969 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232345AbhKIF32 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 00:29:28 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10162"; a="231101482"
X-IronPort-AV: E=Sophos;i="5.87,219,1631602800"; 
   d="scan'208";a="231101482"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 21:26:42 -0800
X-IronPort-AV: E=Sophos;i="5.87,219,1631602800"; 
   d="scan'208";a="491526669"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 21:26:41 -0800
Date:   Mon, 8 Nov 2021 21:26:41 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        david <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dax: Introduce normal and recovery dax operation
 modes
Message-ID: <20211109052640.GG3538886@iweiny-DESK2.sc.intel.com>
References: <20211106011638.2613039-1-jane.chu@oracle.com>
 <20211106011638.2613039-2-jane.chu@oracle.com>
 <CAPcyv4jcgFxgoXFhWL9+BReY8vFtgjb_=Lfai-adFpdzc4-35Q@mail.gmail.com>
 <63f89475-7a1f-e79e-7785-ba996211615b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63f89475-7a1f-e79e-7785-ba996211615b@oracle.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 08, 2021 at 09:02:29PM +0000, Jane Chu wrote:
> On 11/6/2021 9:48 AM, Dan Williams wrote:
> > On Fri, Nov 5, 2021 at 6:17 PM Jane Chu <jane.chu@oracle.com> wrote:
> >>
> >> Introduce DAX_OP_NORMAL and DAX_OP_RECOVERY operation modes to
> >> {dax_direct_access, dax_copy_from_iter, dax_copy_to_iter}.
> >> DAX_OP_NORMAL is the default or the existing mode, and
> >> DAX_OP_RECOVERY is a new mode for data recovery purpose.
> >>
> >> When dax-FS suspects dax media error might be encountered
> >> on a read or write, it can enact the recovery mode read or write
> >> by setting DAX_OP_RECOVERY in the aforementioned APIs. A read
> >> in recovery mode attempts to fetch as much data as possible
> >> until the first poisoned page is encountered. A write in recovery
> >> mode attempts to clear poison(s) in a page-aligned range and
> >> then write the user provided data over.
> >>
> >> DAX_OP_NORMAL should be used for all non-recovery code path.
> >>
> >> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> > [..]
> >> diff --git a/include/linux/dax.h b/include/linux/dax.h
> >> index 324363b798ec..931586df2905 100644
> >> --- a/include/linux/dax.h
> >> +++ b/include/linux/dax.h
> >> @@ -9,6 +9,10 @@
> >>   /* Flag for synchronous flush */
> >>   #define DAXDEV_F_SYNC (1UL << 0)
> >>
> >> +/* dax operation mode dynamically set by caller */
> >> +#define        DAX_OP_NORMAL           0
> > 
> > Perhaps this should be called DAX_OP_FAILFAST?
> 
> Sure.
> 
> > 
> >> +#define        DAX_OP_RECOVERY         1
> >> +
> >>   typedef unsigned long dax_entry_t;
> >>
> >>   struct dax_device;
> >> @@ -22,8 +26,8 @@ struct dax_operations {
> >>           * logical-page-offset into an absolute physical pfn. Return the
> >>           * number of pages available for DAX at that pfn.
> >>           */
> >> -       long (*direct_access)(struct dax_device *, pgoff_t, long,
> >> -                       void **, pfn_t *);
> >> +       long (*direct_access)(struct dax_device *, pgoff_t, long, int,
> > 
> > Would be nice if that 'int' was an enum, but I'm not sure a new
> > parameter is needed at all, see below...
> 
> Let's do your suggestion below. :)
> 
> > 
> >> +                               void **, pfn_t *);
> >>          /*
> >>           * Validate whether this device is usable as an fsdax backing
> >>           * device.
> >> @@ -32,10 +36,10 @@ struct dax_operations {
> >>                          sector_t, sector_t);
> >>          /* copy_from_iter: required operation for fs-dax direct-i/o */
> >>          size_t (*copy_from_iter)(struct dax_device *, pgoff_t, void *, size_t,
> >> -                       struct iov_iter *);
> >> +                       struct iov_iter *, int);
> > 
> > I'm not sure the flag is needed here as the "void *" could carry a
> > flag in the pointer to indicate that is a recovery kaddr.
> 
> Agreed.

Not sure if this is implied but I would like some macros or other helper
functions to check these flags hidden in the addresses.

For me I'm a bit scared about having flags hidden in the address like this
because I can't lead to some confusions IMO.

But if we have some macros or other calls which can make this more obvious of
what is going on I think that would help.

Apologies if this was what you were already going to do...  :-D

Ira

> 
> > 
> >>          /* copy_to_iter: required operation for fs-dax direct-i/o */
> >>          size_t (*copy_to_iter)(struct dax_device *, pgoff_t, void *, size_t,
> >> -                       struct iov_iter *);
> >> +                       struct iov_iter *, int);
> > 
> > Same comment here.
> > 
> >>          /* zero_page_range: required operation. Zero page range   */
> >>          int (*zero_page_range)(struct dax_device *, pgoff_t, size_t);
> >>   };
> >> @@ -186,11 +190,11 @@ static inline void dax_read_unlock(int id)
> >>   bool dax_alive(struct dax_device *dax_dev);
> >>   void *dax_get_private(struct dax_device *dax_dev);
> >>   long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
> >> -               void **kaddr, pfn_t *pfn);
> >> +               int mode, void **kaddr, pfn_t *pfn);
> > 
> > How about dax_direct_access() calling convention stays the same, but
> > the kaddr is optionally updated to carry a flag in the lower unused
> > bits. So:
> > 
> > void **kaddr = NULL; /* caller only cares about the pfn */
> > 
> > void *failfast = NULL;
> > void **kaddr = &failfast; /* caller wants -EIO not recovery */
> > 
> > void *recovery = (void *) DAX_OP_RECOVERY;
> > void **kaddr = &recovery; /* caller wants to carefully access page(s)
> > containing poison */
> > 
> 
> Got it.
> 
> thanks!
> -jane
> 
