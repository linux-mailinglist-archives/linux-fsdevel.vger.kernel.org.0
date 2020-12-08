Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9172D2FE6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 17:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730428AbgLHQi4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 11:38:56 -0500
Received: from mga06.intel.com ([134.134.136.31]:28073 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726810AbgLHQi4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 11:38:56 -0500
IronPort-SDR: GnUxrQ9zHboXsgQzKdFP/C8Y0q/OX5lEarL6nAYAFpS6yc/vWdGBIH9qvYA/pDyymCsOuhggNd
 hwdE/5SAZRiQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="235521620"
X-IronPort-AV: E=Sophos;i="5.78,402,1599548400"; 
   d="scan'208";a="235521620"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 08:38:15 -0800
IronPort-SDR: vPkcZMeeZqXh6vd54T+E2QmFjfZ9AMaNHqWZAt/Wd0xuv0YZVDnmUEugJUuxnLBhX7DJaqzCIo
 wq1ybT1+EV6g==
X-IronPort-AV: E=Sophos;i="5.78,402,1599548400"; 
   d="scan'208";a="437442250"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 08:38:15 -0800
Date:   Tue, 8 Dec 2020 08:38:14 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
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
Message-ID: <20201208163814.GN1563847@iweiny-DESK2.sc.intel.com>
References: <20201207225703.2033611-1-ira.weiny@intel.com>
 <20201207225703.2033611-3-ira.weiny@intel.com>
 <20201208122316.GH7338@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208122316.GH7338@casper.infradead.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 08, 2020 at 12:23:16PM +0000, Matthew Wilcox wrote:
> On Mon, Dec 07, 2020 at 02:57:03PM -0800, ira.weiny@intel.com wrote:
> > Placing these functions in 'highmem.h' is suboptimal especially with the
> > changes being proposed in the functionality of kmap.  From a caller
> > perspective including/using 'highmem.h' implies that the functions
> > defined in that header are only required when highmem is in use which is
> > increasingly not the case with modern processors.  Some headers like
> > mm.h or string.h seem ok but don't really portray the functionality
> > well.  'pagemap.h', on the other hand, makes sense and is already
> > included in many of the places we want to convert.
> 
> pagemap.h is for the page cache.  It's not for "random page
> functionality".  Yes, I know it's badly named.  No, I don't want to
> rename it.  These helpers should go in highmem.h along with zero_user().

I could have sworn you suggested pagemap.h.  But I can't find the evidence on
lore.  :-/   hehehe...

In the end the code does not care.  I have a distaste for highmem.h because it
is no longer for 'high memory'.  And I think a number of driver writers who are
targeting 64bit platforms just don't care any more.  So as we head toward
memory not being mapped by the kernel for other reasons I think highmem needs
to be 'rebranded' if not renamed.

Ira
