Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8302D2AAA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 13:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbgLHMYI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 07:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729388AbgLHMYH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 07:24:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48261C061794;
        Tue,  8 Dec 2020 04:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UNxXJNXqQX33pzDKLkLUQwPsiKXBBcwJYZRxFVbPnps=; b=O/IQVntJZbkpB69wJ39eyVCtkh
        JJARkVk4MvbcQkuYX8rGTsvb5Rnge7YOct0s4PSHnT8xJQQ3Z3HO/eEacoUd8ngR4xNlDzEYf0XEA
        Y1fuio0PpOhmsPUHvCz0tsnCrzYCRFQ7/NXClDyiron7GGQy5BKz9xb48TpFc969jU7mPY48b8tr9
        IiEkGx4OcDfrwzT/IxJum56BPO5ug6IBVYKBxLTiz+zeZm2T9WaKxY1B2hLi/WIdV2LHpG0tebefB
        CzhZR/bwnsyYY+guh6tWs2ghinTb9ieumMIQFRnzfmwVXsrNClVsLUjiC/UUyMCoFu7tsdcYRybJ4
        RFGAsSLQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmc1U-0002xv-Sc; Tue, 08 Dec 2020 12:23:16 +0000
Date:   Tue, 8 Dec 2020 12:23:16 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     ira.weiny@intel.com
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
Message-ID: <20201208122316.GH7338@casper.infradead.org>
References: <20201207225703.2033611-1-ira.weiny@intel.com>
 <20201207225703.2033611-3-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207225703.2033611-3-ira.weiny@intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 07, 2020 at 02:57:03PM -0800, ira.weiny@intel.com wrote:
> Placing these functions in 'highmem.h' is suboptimal especially with the
> changes being proposed in the functionality of kmap.  From a caller
> perspective including/using 'highmem.h' implies that the functions
> defined in that header are only required when highmem is in use which is
> increasingly not the case with modern processors.  Some headers like
> mm.h or string.h seem ok but don't really portray the functionality
> well.  'pagemap.h', on the other hand, makes sense and is already
> included in many of the places we want to convert.

pagemap.h is for the page cache.  It's not for "random page
functionality".  Yes, I know it's badly named.  No, I don't want to
rename it.  These helpers should go in highmem.h along with zero_user().
