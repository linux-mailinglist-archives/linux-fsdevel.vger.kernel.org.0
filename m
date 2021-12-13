Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A65A5471FF4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 05:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbhLMEWr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Dec 2021 23:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbhLMEWn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Dec 2021 23:22:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2704AC06173F;
        Sun, 12 Dec 2021 20:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5VRRrXTMpMMR1uAghzgqAdj8BzkVpuZ2ziBLrA4cdV4=; b=hHj5tkQLGXVF896zpGXpvorbmT
        ZeNp5ygUrTrFdisSuEOLwfYTwId2s25Z+kFrAh3Bfx1sO+hUFUfSrBRebvk3bJTxx9sEBCxskN2+Y
        YDQqZ7RRTWE9uCsWeke+790cXmml4bZs/a0LTmVF3/gQrc8iamJ0JXAvd98bK97f9gl8c8ZUKOqV+
        UuUJxhBXa+r49x8eQpZAO5lumYIZqPGJui1b5Qo3Pbckxw/n4pKhbBDn8wLbe4UqP7zzgV48mCpul
        0RFjFslQkUFDt8dh8faKufMuXOMHQdVNgmhtRzXG2YUbE8ntdKOakzvG6/E8tW4zczFlIyKVbaG5o
        ZrimuKjw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mwcrG-00CR6G-4B; Mon, 13 Dec 2021 04:22:38 +0000
Date:   Mon, 13 Dec 2021 04:22:38 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jan Kara <jack@suse.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Remove inode_congested()
Message-ID: <YbbKjjFzIzSBJWCn@casper.infradead.org>
References: <163936868317.23860.5037433897004720387.stgit@noble.brown>
 <163936886725.23860.2403757518009677424.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163936886725.23860.2403757518009677424.stgit@noble.brown>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 13, 2021 at 03:14:27PM +1100, NeilBrown wrote:
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index fb9584641ac7..540aa0ea67ff 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -989,17 +989,6 @@ static inline int is_page_cache_freeable(struct page *page)
>  	return page_count(page) - page_has_private(page) == 1 + page_cache_pins;
>  }
>  
> -static int may_write_to_inode(struct inode *inode)
> -{
> -	if (current->flags & PF_SWAPWRITE)
> -		return 1;
> -	if (!inode_write_congested(inode))
> -		return 1;
> -	if (inode_to_bdi(inode) == current->backing_dev_info)
> -		return 1;
> -	return 0;
> -}

Why is it safe to get rid of the PF_SWAPWRITE and current->backing_dev_info
checks?

> @@ -1158,8 +1147,6 @@ static pageout_t pageout(struct page *page, struct address_space *mapping)
>  	}
>  	if (mapping->a_ops->writepage == NULL)
>  		return PAGE_ACTIVATE;
> -	if (!may_write_to_inode(mapping->host))
> -		return PAGE_KEEP;
>  
>  	if (clear_page_dirty_for_io(page)) {
>  		int res;
