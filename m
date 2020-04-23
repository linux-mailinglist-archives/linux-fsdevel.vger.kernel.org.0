Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C411B6002
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 17:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbgDWP6z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 11:58:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:44140 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729072AbgDWP6z (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 11:58:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7C3EBAD0E;
        Thu, 23 Apr 2020 15:58:53 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id ABCA71E0E52; Thu, 23 Apr 2020 17:58:53 +0200 (CEST)
Date:   Thu, 23 Apr 2020 17:58:53 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 09/11] mm: Convert writeback BUG to WARN_ON
Message-ID: <20200423155853.GC28707@quack2.suse.cz>
References: <20200416220130.13343-1-willy@infradead.org>
 <20200416220130.13343-10-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416220130.13343-10-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 16-04-20 15:01:28, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> If this BUG() ever triggers, we'll have a dead system with no particular
> information.  Dumping the page will give us a fighting chance of debugging
> the problem, and I think it's safe for us to just continue if we try
> to clear the writeback bit on a page which already has the writeback
> bit clear.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/filemap.c        | 4 +---
>  mm/page-writeback.c | 5 +++++
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index b7c5d2402370..401b24d980ba 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1293,9 +1293,7 @@ void end_page_writeback(struct page *page)
>  		rotate_reclaimable_page(page);
>  	}
>  
> -	if (!test_clear_page_writeback(page))
> -		BUG();
> -
> +	test_clear_page_writeback(page);
>  	smp_mb__after_atomic();
>  	wake_up_page(page, PG_writeback);
>  }
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 7326b54ab728..ebaf0d8263a6 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2718,6 +2718,11 @@ int test_clear_page_writeback(struct page *page)
>  	struct lruvec *lruvec;
>  	int ret;
>  
> +	if (WARN_ON(!PageWriteback(page))) {
> +		dump_page(page, "!writeback");
> +		return false;
> +	}
> +

WARN_ON_ONCE() here perhaps? I don't think dumping more pages will bring
that much value...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
