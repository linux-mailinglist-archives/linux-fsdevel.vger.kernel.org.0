Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087C92CDD96
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 19:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502112AbgLCSZs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 13:25:48 -0500
Received: from mga06.intel.com ([134.134.136.31]:48382 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502109AbgLCSZs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 13:25:48 -0500
IronPort-SDR: Wz80Pepfadsapr9z5+7kR8TorwCrcXys6lSG3FzxCWjm5kXDPWu6h89TYySb7rPgLNurQt+R1I
 xd9Ci4o53h6g==
X-IronPort-AV: E=McAfee;i="6000,8403,9824"; a="234854261"
X-IronPort-AV: E=Sophos;i="5.78,390,1599548400"; 
   d="scan'208";a="234854261"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 10:25:06 -0800
IronPort-SDR: 1yZ6ymN8T1Ru5eWK//GwNd0draYxhFs3e3pHjha5XL21vzCJ0JYjmIZPD/XgmhI3I+/Mc4Ybv7
 bQ4yqVHtbb5Q==
X-IronPort-AV: E=Sophos;i="5.78,390,1599548400"; 
   d="scan'208";a="482069934"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 10:25:05 -0800
Date:   Thu, 3 Dec 2020 10:25:05 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Howells <dhowells@redhat.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Steve French <sfrench@samba.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Brian King <brking@us.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/17] mm/highmem: Lift memcpy_[to|from]_page and
 memset_page to core
Message-ID: <20201203182505.GD1563847@iweiny-DESK2.sc.intel.com>
References: <20201124060755.1405602-1-ira.weiny@intel.com>
 <20201124060755.1405602-2-ira.weiny@intel.com>
 <160648238432.10416.12405581766428273347@jlahtine-mobl.ger.corp.intel.com>
 <20201127132006.GY4327@casper.infradead.org>
 <160672815223.3453.2374529656870007787@jlahtine-mobl.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160672815223.3453.2374529656870007787@jlahtine-mobl.ger.corp.intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 30, 2020 at 11:22:32AM +0200, Joonas Lahtinen wrote:
> Quoting Matthew Wilcox (2020-11-27 15:20:06)
> > On Fri, Nov 27, 2020 at 03:06:24PM +0200, Joonas Lahtinen wrote:
> > > Quoting ira.weiny@intel.com (2020-11-24 08:07:39)
> > > > From: Ira Weiny <ira.weiny@intel.com>
> > > > 
> > > > Working through a conversion to a call such as kmap_thread() revealed
> > > > many places where the pattern kmap/memcpy/kunmap occurred.
> > > > 
> > > > Eric Biggers, Matthew Wilcox, Christoph Hellwig, Dan Williams, and Al
> > > > Viro all suggested putting this code into helper functions.  Al Viro
> > > > further pointed out that these functions already existed in the iov_iter
> > > > code.[1]
> > > > 
> > > > Placing these functions in 'highmem.h' is suboptimal especially with the
> > > > changes being proposed in the functionality of kmap.  From a caller
> > > > perspective including/using 'highmem.h' implies that the functions
> > > > defined in that header are only required when highmem is in use which is
> > > > increasingly not the case with modern processors.  Some headers like
> > > > mm.h or string.h seem ok but don't really portray the functionality
> > > > well.  'pagemap.h', on the other hand, makes sense and is already
> > > > included in many of the places we want to convert.
> > > > 
> > > > Another alternative would be to create a new header for the promoted
> > > > memcpy functions, but it masks the fact that these are designed to copy
> > > > to/from pages using the kernel direct mappings and complicates matters
> > > > with a new header.
> > > > 
> > > > Lift memcpy_to_page(), memcpy_from_page(), and memzero_page() to
> > > > pagemap.h.
> > > > 
> > > > Also, add a memcpy_page(), memmove_page, and memset_page() to cover more
> > > > kmap/mem*/kunmap. patterns.
> > > > 
> > > > [1] https://lore.kernel.org/lkml/20201013200149.GI3576660@ZenIV.linux.org.uk/
> > > >     https://lore.kernel.org/lkml/20201013112544.GA5249@infradead.org/
> > > > 
> > > > Cc: Dave Hansen <dave.hansen@intel.com>
> > > > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > > > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > > > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > > > Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> > > > Suggested-by: Eric Biggers <ebiggers@kernel.org>
> > > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > <SNIP>
> > > 
> > > > +static inline void memset_page(struct page *page, int val, size_t offset, size_t len)
> > > > +{
> > > > +       char *addr = kmap_atomic(page);
> > > > +       memset(addr + offset, val, len);
> > > > +       kunmap_atomic(addr);
> > > > +}
> > > 
> > > Other functions have (page, offset) pair. Insertion of 'val' in the middle here required
> > > to take a double look during review.
> > 
> > Let's be explicit here.  Your suggested order is:
> > 
> >         (page, offset, val, len)
> > 
> > right?  I think I would prefer that to (page, val, offset, len).
> 
> Yeah, I think that would be most consistent order.

Yes as I have been reworking these I have found it odd as well.  I'm going to
swap it around.  Been learning Coccinelle which has helped find other
instances...  So V2 is taking a bit of time.

Thanks,
Ira

