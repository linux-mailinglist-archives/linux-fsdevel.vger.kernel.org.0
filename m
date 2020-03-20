Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 272FB18D7EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Mar 2020 19:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbgCTSwl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Mar 2020 14:52:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:46960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727210AbgCTSwk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Mar 2020 14:52:40 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A87620775;
        Fri, 20 Mar 2020 18:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584730359;
        bh=3gbE+VlmfoN5OPIi14o+iI+EIYlVydyt9rn3Y0AvnsY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DRP5T0p/QJ3Eo+pOi6lUoz/NYAigZgi8TtvZjTzfHQ8g8KelV4xmxmhMYNwPEnhOr
         jaoWnNJhMTgDQ5E65odJ0yXJp9dcxGm+62eg5najbweP0lRbI54UDJTXPJXqLKn/F1
         CPgqcXc4KjgX4h9bEPayy9PiHh2SFNg2cqPbd3s0=
Date:   Fri, 20 Mar 2020 11:52:38 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-xfs@vger.kernel.org,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-mm@kvack.org, ocfs2-devel@oss.oracle.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v9 23/25] f2fs: Pass the inode to f2fs_mpage_readpages
Message-ID: <20200320185238.GJ851@sol.localdomain>
References: <20200320142231.2402-1-willy@infradead.org>
 <20200320142231.2402-24-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320142231.2402-24-willy@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 20, 2020 at 07:22:29AM -0700, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> This function now only uses the mapping argument to look up the inode,
> and both callers already have the inode, so just pass the inode instead
> of the mapping.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> ---
>  fs/f2fs/data.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 237dff36fe73..c8b042979fc4 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2159,12 +2159,11 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
>   * use ->readpage() or do the necessary surgery to decouple ->readpages()
>   * from read-ahead.
>   */
> -static int f2fs_mpage_readpages(struct address_space *mapping,
> +static int f2fs_mpage_readpages(struct inode *inode,
>  		struct readahead_control *rac, struct page *page)
>  {
>  	struct bio *bio = NULL;
>  	sector_t last_block_in_bio = 0;
> -	struct inode *inode = mapping->host;
>  	struct f2fs_map_blocks map;
>  #ifdef CONFIG_F2FS_FS_COMPRESSION
>  	struct compress_ctx cc = {
> @@ -2276,7 +2275,7 @@ static int f2fs_read_data_page(struct file *file, struct page *page)
>  	if (f2fs_has_inline_data(inode))
>  		ret = f2fs_read_inline_data(inode, page);
>  	if (ret == -EAGAIN)
> -		ret = f2fs_mpage_readpages(page_file_mapping(page), NULL, page);
> +		ret = f2fs_mpage_readpages(inode, NULL, page);
>  	return ret;
>  }
>  
> @@ -2293,7 +2292,7 @@ static void f2fs_readahead(struct readahead_control *rac)
>  	if (f2fs_has_inline_data(inode))
>  		return;
>  
> -	f2fs_mpage_readpages(rac->mapping, rac, NULL);
> +	f2fs_mpage_readpages(inode, rac, NULL);
>  }
>  
>  int f2fs_encrypt_one_page(struct f2fs_io_info *fio)
> -- 

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
