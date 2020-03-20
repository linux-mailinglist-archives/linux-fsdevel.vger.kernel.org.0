Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0DB18D789
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Mar 2020 19:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgCTSoU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Mar 2020 14:44:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:43150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgCTSoU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Mar 2020 14:44:20 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9895A2051A;
        Fri, 20 Mar 2020 18:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584729860;
        bh=5pZqAya2TSGOpl920vnSvHi9jKtNxmt64mv8PAdFI3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VyRgr5LelhylhzZlcVYEomgTosDPQP2hFACxdbSh1g8cxdYQj8CURPVdAol5gz7Rg
         ExBTz35Q8O5vnKTi+DibRxVv6t5mUtWBLawcyZ38iKpEQsk8AEImcLdLmORUJEYHIs
         e+oJ5iVBFhvWYyFYTKBJXTMNGFlzAY6GTvEUiHMY=
Date:   Fri, 20 Mar 2020 11:44:18 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v9 21/25] ext4: Pass the inode to ext4_mpage_readpages
Message-ID: <20200320184418.GH851@sol.localdomain>
References: <20200320142231.2402-1-willy@infradead.org>
 <20200320142231.2402-22-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320142231.2402-22-willy@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 20, 2020 at 07:22:27AM -0700, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> This function now only uses the mapping argument to look up the inode,
> and both callers already have the inode, so just pass the inode instead
> of the mapping.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> ---
>  fs/ext4/ext4.h     | 2 +-
>  fs/ext4/inode.c    | 4 ++--
>  fs/ext4/readpage.c | 3 +--
>  3 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 1570a0b51b73..bc1b34ba6eab 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3278,7 +3278,7 @@ static inline void ext4_set_de_type(struct super_block *sb,
>  }
>  
>  /* readpages.c */
> -extern int ext4_mpage_readpages(struct address_space *mapping,
> +extern int ext4_mpage_readpages(struct inode *inode,
>  		struct readahead_control *rac, struct page *page);
>  extern int __init ext4_init_post_read_processing(void);
>  extern void ext4_exit_post_read_processing(void);
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index d674c5f9066c..4f3703c1408d 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3226,7 +3226,7 @@ static int ext4_readpage(struct file *file, struct page *page)
>  		ret = ext4_readpage_inline(inode, page);
>  
>  	if (ret == -EAGAIN)
> -		return ext4_mpage_readpages(page->mapping, NULL, page);
> +		return ext4_mpage_readpages(inode, NULL, page);
>  
>  	return ret;
>  }
> @@ -3239,7 +3239,7 @@ static void ext4_readahead(struct readahead_control *rac)
>  	if (ext4_has_inline_data(inode))
>  		return;
>  
> -	ext4_mpage_readpages(rac->mapping, rac, NULL);
> +	ext4_mpage_readpages(inode, rac, NULL);
>  }
>  
>  static void ext4_invalidatepage(struct page *page, unsigned int offset,
> diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
> index 66275f25235d..5761e9961682 100644
> --- a/fs/ext4/readpage.c
> +++ b/fs/ext4/readpage.c
> @@ -221,13 +221,12 @@ static inline loff_t ext4_readpage_limit(struct inode *inode)
>  	return i_size_read(inode);
>  }
>  
> -int ext4_mpage_readpages(struct address_space *mapping,
> +int ext4_mpage_readpages(struct inode *inode,
>  		struct readahead_control *rac, struct page *page)
>  {
>  	struct bio *bio = NULL;
>  	sector_t last_block_in_bio = 0;
>  
> -	struct inode *inode = mapping->host;
>  	const unsigned blkbits = inode->i_blkbits;
>  	const unsigned blocks_per_page = PAGE_SIZE >> blkbits;
>  	const unsigned blocksize = 1 << blkbits;
> -- 

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
