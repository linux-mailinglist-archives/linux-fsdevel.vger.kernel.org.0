Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9E491572B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2020 11:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbgBJKQe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 05:16:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:43448 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbgBJKQe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 05:16:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 570C7B17A;
        Mon, 10 Feb 2020 10:16:31 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DE6281E0E2C; Mon, 10 Feb 2020 11:16:29 +0100 (CET)
Date:   Mon, 10 Feb 2020 11:16:29 +0100
From:   Jan Kara <jack@suse.cz>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 10/12] mm/gup: /proc/vmstat: pin_user_pages (FOLL_PIN)
 reporting
Message-ID: <20200210101629.GC12923@quack2.suse.cz>
References: <20200207033735.308000-1-jhubbard@nvidia.com>
 <20200207033735.308000-11-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207033735.308000-11-jhubbard@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 06-02-20 19:37:33, John Hubbard wrote:
> @@ -2258,6 +2268,8 @@ static int record_subpages(struct page *page, unsigned long addr,
>  
>  static void put_compound_head(struct page *page, int refs, unsigned int flags)
>  {
> +	int orig_refs = refs;
> +
>  	if (flags & FOLL_PIN) {
>  		if (hpage_pincount_available(page))
>  			hpage_pincount_sub(page, refs);
> @@ -2273,6 +2285,8 @@ static void put_compound_head(struct page *page, int refs, unsigned int flags)
>  	if (refs > 1)
>  		page_ref_sub(page, refs - 1);
>  	put_page(page);
> +
> +	mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_RELEASED, orig_refs);
>  }

Still not quite happy about this :) Now you update NR_FOLL_PIN_RELEASED
even if 'flags' don't have FOLL_PIN set. You need to have the
mod_node_page_state() inside the "if (flags & FOLL_PIN)" branch above...

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
