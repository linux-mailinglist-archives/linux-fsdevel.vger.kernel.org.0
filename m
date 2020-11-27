Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1E442C66AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Nov 2020 14:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbgK0NVK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Nov 2020 08:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729402AbgK0NVK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Nov 2020 08:21:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B257C0613D1;
        Fri, 27 Nov 2020 05:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=da54PXozPjm/EiAuixh+YkNgFXGB4rDLTyepbBzA2dg=; b=KWyx1YxC2nmhmtUDOgtptiYfoB
        DBlXqBO8lAYi82F1oTeGeg2nSXKnjj08jQo5fYlD1qSAIuqD8371atETcszq4NDVrqkDcuY2sFnmd
        s7134C6ZpaZot5dOYPXIzMrVFwqJ1CcMMjrThl35Wf9Uzbo4hCGLaE7xJgD5rmR3haPT9TFVUdDEn
        UELctJd41vXMh9FS+KC6/8N7FeSZlQ4AapfDD3xCC2QL362xPvm+ou2TWbfrNdLYVp2Kn3O2/b8A4
        mhXS4paxUp385fxxNnd0RY8/OGS2HSiWf61TRyZJVpmHm0NFSOJLHABVXZ+XuD1+sS8tqFEFH/Yhs
        SUGuneFQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kidfT-0007Mn-0i; Fri, 27 Nov 2020 13:20:07 +0000
Date:   Fri, 27 Nov 2020 13:20:06 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, ira.weiny@intel.com,
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
Message-ID: <20201127132006.GY4327@casper.infradead.org>
References: <20201124060755.1405602-1-ira.weiny@intel.com>
 <20201124060755.1405602-2-ira.weiny@intel.com>
 <160648238432.10416.12405581766428273347@jlahtine-mobl.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160648238432.10416.12405581766428273347@jlahtine-mobl.ger.corp.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 27, 2020 at 03:06:24PM +0200, Joonas Lahtinen wrote:
> Quoting ira.weiny@intel.com (2020-11-24 08:07:39)
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Working through a conversion to a call such as kmap_thread() revealed
> > many places where the pattern kmap/memcpy/kunmap occurred.
> > 
> > Eric Biggers, Matthew Wilcox, Christoph Hellwig, Dan Williams, and Al
> > Viro all suggested putting this code into helper functions.  Al Viro
> > further pointed out that these functions already existed in the iov_iter
> > code.[1]
> > 
> > Placing these functions in 'highmem.h' is suboptimal especially with the
> > changes being proposed in the functionality of kmap.  From a caller
> > perspective including/using 'highmem.h' implies that the functions
> > defined in that header are only required when highmem is in use which is
> > increasingly not the case with modern processors.  Some headers like
> > mm.h or string.h seem ok but don't really portray the functionality
> > well.  'pagemap.h', on the other hand, makes sense and is already
> > included in many of the places we want to convert.
> > 
> > Another alternative would be to create a new header for the promoted
> > memcpy functions, but it masks the fact that these are designed to copy
> > to/from pages using the kernel direct mappings and complicates matters
> > with a new header.
> > 
> > Lift memcpy_to_page(), memcpy_from_page(), and memzero_page() to
> > pagemap.h.
> > 
> > Also, add a memcpy_page(), memmove_page, and memset_page() to cover more
> > kmap/mem*/kunmap. patterns.
> > 
> > [1] https://lore.kernel.org/lkml/20201013200149.GI3576660@ZenIV.linux.org.uk/
> >     https://lore.kernel.org/lkml/20201013112544.GA5249@infradead.org/
> > 
> > Cc: Dave Hansen <dave.hansen@intel.com>
> > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> > Suggested-by: Eric Biggers <ebiggers@kernel.org>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> <SNIP>
> 
> > +static inline void memset_page(struct page *page, int val, size_t offset, size_t len)
> > +{
> > +       char *addr = kmap_atomic(page);
> > +       memset(addr + offset, val, len);
> > +       kunmap_atomic(addr);
> > +}
> 
> Other functions have (page, offset) pair. Insertion of 'val' in the middle here required
> to take a double look during review.

Let's be explicit here.  Your suggested order is:

	(page, offset, val, len)

right?  I think I would prefer that to (page, val, offset, len).
