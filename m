Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561212D2FF5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 17:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730330AbgLHQlo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 11:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730257AbgLHQln (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 11:41:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1CEC0613D6;
        Tue,  8 Dec 2020 08:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NMqhQXFvhSVNTGBBUTvkzNDsEmmLv8BXIjRUXuQR1PA=; b=fBKqRdzNgO2taBufpfsIv0owb3
        dpe3g7A1vOOMY9UhPDDZLHc0LOlsC+LIBDhlRZPvwlmXQQZsjmaf5RghYYPebuC6nmmQz5sQyB6HT
        DcX996N8PGX5dcDGGObL4aUq4bkgB5hXwh5vxVS050YetMTvrpVEkvTBB2g4czES2FFZ8CQnOYzr5
        7otWfELANedPzbfZjAvum3+TKQgAjs2plkyVMoH5hCZMdnojfqQal7GnTaAMBmZoBkrn3/T5+AxVY
        o3cqjMiFJmfqw/uWHZFY2+Xzi7ys4OhEjUu4gwvaTpdndanwNnlInNs9eKHroS+AZ46IpgqoQrVAT
        sA/qA0Aw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmg2p-0001el-FN; Tue, 08 Dec 2020 16:40:55 +0000
Date:   Tue, 8 Dec 2020 16:40:55 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V2 2/2] mm/highmem: Lift memcpy_[to|from]_page to core
Message-ID: <20201208164055.GI7338@casper.infradead.org>
References: <20201207225703.2033611-1-ira.weiny@intel.com>
 <20201207225703.2033611-3-ira.weiny@intel.com>
 <20201208122316.GH7338@casper.infradead.org>
 <20201208163814.GN1563847@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208163814.GN1563847@iweiny-DESK2.sc.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 08, 2020 at 08:38:14AM -0800, Ira Weiny wrote:
> On Tue, Dec 08, 2020 at 12:23:16PM +0000, Matthew Wilcox wrote:
> > On Mon, Dec 07, 2020 at 02:57:03PM -0800, ira.weiny@intel.com wrote:
> > > Placing these functions in 'highmem.h' is suboptimal especially with the
> > > changes being proposed in the functionality of kmap.  From a caller
> > > perspective including/using 'highmem.h' implies that the functions
> > > defined in that header are only required when highmem is in use which is
> > > increasingly not the case with modern processors.  Some headers like
> > > mm.h or string.h seem ok but don't really portray the functionality
> > > well.  'pagemap.h', on the other hand, makes sense and is already
> > > included in many of the places we want to convert.
> > 
> > pagemap.h is for the page cache.  It's not for "random page
> > functionality".  Yes, I know it's badly named.  No, I don't want to
> > rename it.  These helpers should go in highmem.h along with zero_user().
> 
> I could have sworn you suggested pagemap.h.  But I can't find the evidence on
> lore.  :-/   hehehe...
> 
> In the end the code does not care.  I have a distaste for highmem.h because it
> is no longer for 'high memory'.  And I think a number of driver writers who are
> targeting 64bit platforms just don't care any more.  So as we head toward
> memory not being mapped by the kernel for other reasons I think highmem needs
> to be 'rebranded' if not renamed.

Rename highmem.h to kmap.h?
