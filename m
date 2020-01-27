Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEACB14A2F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 12:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbgA0LXu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 06:23:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:41032 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729530AbgA0LXt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 06:23:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 51770AFF0;
        Mon, 27 Jan 2020 11:06:25 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 356041E0E4E; Mon, 27 Jan 2020 12:06:24 +0100 (CET)
Date:   Mon, 27 Jan 2020 12:06:24 +0100
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
        Vlastimil Babka <vbabka@suse.cz>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 1/3] mm/gup: track FOLL_PIN pages
Message-ID: <20200127110624.GD19414@quack2.suse.cz>
References: <20200125021115.731629-1-jhubbard@nvidia.com>
 <20200125021115.731629-2-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200125021115.731629-2-jhubbard@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 24-01-20 18:11:13, John Hubbard wrote:
> +static __maybe_unused struct page *try_grab_compound_head(struct page *page,
> +							  int refs,
> +							  unsigned int flags)
> +{
> +	if (flags & FOLL_GET)
> +		return try_get_compound_head(page, refs);
> +	else if (flags & FOLL_PIN) {
> +		int orig_refs = refs;
> +
> +		/*
> +		 * When pinning a compound page of order > 1 (which is what
> +		 * hpage_pincount_available() checks for), use an exact count to
> +		 * track it, via hpage_pincount_inc/_dec().
> +		 *
> +		 * However, be sure to *also* increment the normal page refcount
> +		 * field at least once, so that the page really is pinned.
> +		 */
> +		if (!hpage_pincount_available(page))
> +			refs *= GUP_PIN_COUNTING_BIAS;
> +
> +		page = try_get_compound_head(page, refs);
> +		if (!page)
> +			return NULL;
> +
> +		if (hpage_pincount_available(page))
> +			hpage_pincount_inc(page);

Umm, adding just 1 to pincount looks dangerous to me as
try_grab_compound_head() would not compose - you could not release
references acquired by try_grab_compound_head() with refs==2 by two calls
to put_compound_head() with refs==1. So I'd rather have here:
hpage_pincount_add(page, refs) and similarly in put_compound_head().
Otherwise the patch looks good to me from a quick look.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
