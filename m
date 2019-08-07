Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D49B784A3F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2019 13:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfHGLBt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Aug 2019 07:01:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:39552 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726269AbfHGLBt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Aug 2019 07:01:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F3BFCAE48;
        Wed,  7 Aug 2019 11:01:47 +0000 (UTC)
Date:   Wed, 7 Aug 2019 13:01:47 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     john.hubbard@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Black <daniel@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH 1/3] mm/mlock.c: convert put_page() to put_user_page*()
Message-ID: <20190807110147.GT11812@dhcp22.suse.cz>
References: <20190805222019.28592-1-jhubbard@nvidia.com>
 <20190805222019.28592-2-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190805222019.28592-2-jhubbard@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 05-08-19 15:20:17, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 
> For pages that were retained via get_user_pages*(), release those pages
> via the new put_user_page*() routines, instead of via put_page() or
> release_pages().

Hmm, this is an interesting code path. There seems to be a mix of pages
in the game. We get one page via follow_page_mask but then other pages
in the range are filled by __munlock_pagevec_fill and that does a direct
pte walk. Is using put_user_page correct in this case? Could you explain
why in the changelog?

> This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
> ("mm: introduce put_user_page*(), placeholder versions").
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Daniel Black <daniel@linux.ibm.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Jérôme Glisse <jglisse@redhat.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  mm/mlock.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/mlock.c b/mm/mlock.c
> index a90099da4fb4..b980e6270e8a 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -345,7 +345,7 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
>  				get_page(page); /* for putback_lru_page() */
>  				__munlock_isolated_page(page);
>  				unlock_page(page);
> -				put_page(page); /* from follow_page_mask() */
> +				put_user_page(page); /* from follow_page_mask() */
>  			}
>  		}
>  	}
> @@ -467,7 +467,7 @@ void munlock_vma_pages_range(struct vm_area_struct *vma,
>  		if (page && !IS_ERR(page)) {
>  			if (PageTransTail(page)) {
>  				VM_BUG_ON_PAGE(PageMlocked(page), page);
> -				put_page(page); /* follow_page_mask() */
> +				put_user_page(page); /* follow_page_mask() */
>  			} else if (PageTransHuge(page)) {
>  				lock_page(page);
>  				/*
> @@ -478,7 +478,7 @@ void munlock_vma_pages_range(struct vm_area_struct *vma,
>  				 */
>  				page_mask = munlock_vma_page(page);
>  				unlock_page(page);
> -				put_page(page); /* follow_page_mask() */
> +				put_user_page(page); /* follow_page_mask() */
>  			} else {
>  				/*
>  				 * Non-huge pages are handled in batches via
> -- 
> 2.22.0

-- 
Michal Hocko
SUSE Labs
