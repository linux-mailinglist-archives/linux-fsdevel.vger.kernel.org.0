Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534982772F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 15:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgIXNpk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 09:45:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:59776 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727973AbgIXNpk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 09:45:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 856DEACF5;
        Thu, 24 Sep 2020 13:45:38 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id EEFC11E12F7; Thu, 24 Sep 2020 11:00:21 +0200 (CEST)
Date:   Thu, 24 Sep 2020 11:00:21 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, ecryptfs@vger.kernel.org,
        linux-um@lists.infradead.org, linux-mtd@lists.infradead.org,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 12/13] udf: Tell the VFS that readpage was synchronous
Message-ID: <20200924090021.GE27019@quack2.suse.cz>
References: <20200917151050.5363-1-willy@infradead.org>
 <20200917151050.5363-13-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917151050.5363-13-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 17-09-20 16:10:49, Matthew Wilcox (Oracle) wrote:
> The udf inline data readpage implementation was already synchronous,
> so use AOP_UPDATED_PAGE to avoid cycling the page lock.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
> ---
>  fs/udf/file.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/udf/file.c b/fs/udf/file.c
> index 628941a6b79a..52bbe92d7c43 100644
> --- a/fs/udf/file.c
> +++ b/fs/udf/file.c
> @@ -61,9 +61,8 @@ static int udf_adinicb_readpage(struct file *file, struct page *page)
>  {
>  	BUG_ON(!PageLocked(page));
>  	__udf_adinicb_readpage(page);
> -	unlock_page(page);
>  
> -	return 0;
> +	return AOP_UPDATED_PAGE;
>  }
>  
>  static int udf_adinicb_writepage(struct page *page,
> -- 
> 2.28.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
