Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330CE3676A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Apr 2021 03:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235262AbhDVBID (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 21:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhDVBH6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 21:07:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08830C06174A;
        Wed, 21 Apr 2021 18:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VRNWJ7dwbgZwlJyhYfwGgpaJzbScF/7s6fzKyBnonnk=; b=WtR6qF+FGYDnWHNpr57Amm2uZk
        ZgQuQYsiGxtuRwxgwalTqgLJID5Xudtgan2AHAeyR9GnxsHku9D0Au88l9Yp1FylXEuang+V9AgNX
        W3Ut/B+QNa7FXpswe5iQmJQD9vUJjTRdu50fGl/hVEJe0wwvYUD2gfscP4OrpgURDThZCrZcqHGMv
        kSuC25KwvxN7vHm3opYhbdp+aUt+SXdxC01mzy3FZ4ZtUtw0V2EYvk6lib5d+5gUZU57+zncdBD+M
        gEZpNUh8Wxziorc+1auBCeqSuHK9fWV/5G6Rc5c2EQxU7fpo67nO6zwkUGXMLMnTI84qzCHt7DsBy
        99LU24HA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lZNna-00HGPa-Uh; Thu, 22 Apr 2021 01:06:35 +0000
Date:   Thu, 22 Apr 2021 02:06:30 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Dave Chinner <dchinner@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm/filemap: fix find_lock_entries hang on 32-bit THP
Message-ID: <20210422010630.GK3596236@casper.infradead.org>
References: <alpine.LSU.2.11.2104211723580.3299@eggly.anvils>
 <alpine.LSU.2.11.2104211735430.3299@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2104211735430.3299@eggly.anvils>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 21, 2021 at 05:37:33PM -0700, Hugh Dickins wrote:
> -		if (!xa_is_value(page) && PageTransHuge(page))
> -			xas_set(&xas, page->index + thp_nr_pages(page));
> +		if (!xa_is_value(page) && PageTransHuge(page)) {
> +			unsigned int nr_pages = thp_nr_pages(page);
> +
> +			/* Final THP may cross MAX_LFS_FILESIZE on 32-bit */
> +			xas_set(&xas, page->index + nr_pages);
> +			if (xas.xa_index < nr_pages)
> +				break;
> +		}

Aargh.  We really need to get the multi-index support in; this works
perfectly when the xas_set() hack isn't needed any more.
