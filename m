Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75FB3A8708
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 19:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbhFORDW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 13:03:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229493AbhFORDV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:03:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D08AF6191D;
        Tue, 15 Jun 2021 17:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623776476;
        bh=4Q6Y92fZRj5flc5Yj9xaqIZbvJ/uU2szW1HxWt+GQLY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=G8ZskKxWkXu1RWN+HV8uT1RobA+yOjtJ+fz5j+8eAJEn9DgyVD1YOOGC+rUoSa4VV
         iU+waWLffTNuv7Iosi4ZqwVewVqRSBfzAXkLwCaZnAY3zEcOizOjI5g1AC8VnsyBxp
         Wehf9TlxT/NtIc4SzW7/MwNmp3ciDY/4AJ+KlSHf9fuWCHmR0y48Zxpsr8sYD6Oxzh
         wq09cM4aYYKl/3i1KAyTRhILPl/c/YylzUii7VW/T7rdrOmIssvd3aekkE6tdBuIVf
         IKMEfiblZTNDdvoy+s7v5V6K/jeTHyBFSyE3tNe3V5slJ/cCJziQYmwhQrLppuTj0Y
         hFaFA5K1d8CzA==
Message-ID: <a962b43f746fcedc61364cc9244e0be79af203ed.camel@kernel.org>
Subject: Re: [PATCH 3/3] netfs: fix test for whether we can skip read when
 writing beyond EOF
From:   Jeff Layton <jlayton@kernel.org>
To:     "open list:CEPH DISTRIBUTED..." <ceph-devel@vger.kernel.org>
Cc:     Andrew W Elble <aweits@rit.edu>, ceph-devel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        willy@infradead.org
Date:   Tue, 15 Jun 2021 13:01:14 -0400
In-Reply-To: <162367683365.460125.4467036947364047314.stgit@warthog.procyon.org.uk>
References: <162367681795.460125.11729955608839747375.stgit@warthog.procyon.org.uk>
         <162367683365.460125.4467036947364047314.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-06-14 at 14:20 +0100, David Howells wrote:
> From: Jeff Layton <jlayton@kernel.org>
> 
> It's not sufficient to skip reading when the pos is beyond the EOF.
> There may be data at the head of the page that we need to fill in
> before the write.
> 
> Add a new helper function that corrects and clarifies the logic of
> when we can skip reads, and have it only zero out the part of the page
> that won't have data copied in for the write.
> 
> Finally, don't set the page Uptodate after zeroing. It's not up to date
> since the write data won't have been copied in yet.
> 
> [DH made the following changes:
> 
>  - Prefixed the new function with "netfs_".
> 
>  - Don't call zero_user_segments() for a full-page write.
> 
>  - Altered the beyond-last-page check to avoid a DIV instruction and got
>    rid of then-redundant zero-length file check.
> ]
> 
> Fixes: e1b1240c1ff5f ("netfs: Add write_begin helper")
> Reported-by: Andrew W Elble <aweits@rit.edu>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: ceph-devel@vger.kernel.org
> Link: https://lore.kernel.org/r/20210613233345.113565-1-jlayton@kernel.org/
> ---
> 
>  fs/netfs/read_helper.c |   49 +++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 36 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
> index 725614625ed4..70a5b1a19a50 100644
> --- a/fs/netfs/read_helper.c
> +++ b/fs/netfs/read_helper.c
> @@ -1011,12 +1011,42 @@ int netfs_readpage(struct file *file,
>  }
>  EXPORT_SYMBOL(netfs_readpage);
>  
> -static void netfs_clear_thp(struct page *page)
> +/**
> + * netfs_skip_page_read - prep a page for writing without reading first
> + * @page: page being prepared
> + * @pos: starting position for the write
> + * @len: length of write
> + *
> + * In some cases, write_begin doesn't need to read at all:
> + * - full page write
> + * - write that lies in a page that is completely beyond EOF
> + * - write that covers the the page from start to EOF or beyond it
> + *
> + * If any of these criteria are met, then zero out the unwritten parts
> + * of the page and return true. Otherwise, return false.
> + */
> +static noinline bool netfs_skip_page_read(struct page *page, loff_t pos, size_t len)
>  {
> -	unsigned int i;
> +	struct inode *inode = page->mapping->host;
> +	loff_t i_size = i_size_read(inode);
> +	size_t offset = offset_in_thp(page, pos);
> +
> +	/* Full page write */
> +	if (offset == 0 && len >= thp_size(page))
> +		return true;
> +
> +	/* pos beyond last page in the file */
> +	if (pos - offset >= i_size)
> +		goto zero_out;
> +
> +	/* Write that covers from the start of the page to EOF or beyond */
> +	if (offset == 0 && (pos + len) >= i_size)
> +		goto zero_out;
>  
> -	for (i = 0; i < thp_nr_pages(page); i++)
> -		clear_highpage(page + i);
> +	return false;
> +zero_out:
> +	zero_user_segments(page, 0, offset, offset + len, thp_size(page));
> +	return true;
>  }
>  
>  /**
> @@ -1024,7 +1054,7 @@ static void netfs_clear_thp(struct page *page)
>   * @file: The file to read from
>   * @mapping: The mapping to read from
>   * @pos: File position at which the write will begin
> - * @len: The length of the write in this page
> + * @len: The length of the write (may extend beyond the end of the page chosen)
>   * @flags: AOP_* flags
>   * @_page: Where to put the resultant page
>   * @_fsdata: Place for the netfs to store a cookie
> @@ -1061,8 +1091,6 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
>  	struct inode *inode = file_inode(file);
>  	unsigned int debug_index = 0;
>  	pgoff_t index = pos >> PAGE_SHIFT;
> -	int pos_in_page = pos & ~PAGE_MASK;
> -	loff_t size;
>  	int ret;
>  
>  	DEFINE_READAHEAD(ractl, file, NULL, mapping, index);
> @@ -1090,13 +1118,8 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
>  	 * within the cache granule containing the EOF, in which case we need
>  	 * to preload the granule.
>  	 */
> -	size = i_size_read(inode);
>  	if (!ops->is_cache_enabled(inode) &&
> -	    ((pos_in_page == 0 && len == thp_size(page)) ||
> -	     (pos >= size) ||
> -	     (pos_in_page == 0 && (pos + len) >= size))) {
> -		netfs_clear_thp(page);
> -		SetPageUptodate(page);
> +	    netfs_skip_page_read(page, pos, len)) {
>  		netfs_stat(&netfs_n_rh_write_zskip);
>  		goto have_page_no_wait;
>  	}
> 
> 

I've gone ahead and merged this into the ceph/testing branch since it is
a data corruptor. Once this patch goes into mainline, we'll drop that
patch and rebase onto that commit.
-- 
Jeff Layton <jlayton@kernel.org>

