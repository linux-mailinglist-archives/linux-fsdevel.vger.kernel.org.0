Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC1337AAF1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 17:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbhEKPmE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 11:42:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:39166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231761AbhEKPmE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 11:42:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 58CAF6162B;
        Tue, 11 May 2021 15:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620747657;
        bh=Qc/g4ZmQv/PiVDGt+9+0sy95v1f2YPuW215OyGw4hU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RvsIoYM0kbnR0qVgJx4yn2ssV+SbFyhLMKo7Zh6CEIfxIVbzLS5pO/uS5KLoN3uXf
         ojpkQORByNS2oOyizKk1mDWnj/KrnkrHjQwZmMp0HARsPb6zc++gQyeEzAorOIRqfA
         j8lHHsP0A1Vi3a+YCu4Fs4dRIglWOwhpB37mQgdzP6YdtRxHXC/W/PQl+pSuR+kwOc
         fQjgCYor/gXc5HENEZfr9c0MLw/dUQ6gQn5kRTOzmHD7JfWI/GwXQE9sr3nGMXIruJ
         Zl7sKtPrUa379GXNHgtpKb+ckp2qXB3O3U2E57YeOQ4a2W7HWYBrXcUPpUXD5Ysq/y
         11dnh1/wDAD3g==
Date:   Tue, 11 May 2021 08:40:56 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        dhowells@redhat.com, marc.dionne@auristor.com,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH] vfs/dedupe: Pass file pointer to read_mapping_page
Message-ID: <20210511154056.GA8543@magnolia>
References: <20210511145608.1759501-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511145608.1759501-1-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 11, 2021 at 03:56:08PM +0100, Matthew Wilcox (Oracle) wrote:
> Some filesystems (eg AFS) need a valid file pointer for their ->readpage
> operation.  Presumably none of them currently support deduplication,
> but it's just as easy to pass the struct file around as it is to pass
> the struct inode around, and it sets a good example for other users.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/remap_range.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/remap_range.c b/fs/remap_range.c
> index e4a5fdd7ad7b..982ba89aeeb6 100644
> --- a/fs/remap_range.c
> +++ b/fs/remap_range.c
> @@ -158,11 +158,11 @@ static int generic_remap_check_len(struct inode *inode_in,
>  }
>  
>  /* Read a page's worth of file data into the page cache. */
> -static struct page *vfs_dedupe_get_page(struct inode *inode, loff_t offset)
> +static struct page *vfs_dedupe_get_page(struct file *file, loff_t offset)
>  {
>  	struct page *page;
>  
> -	page = read_mapping_page(inode->i_mapping, offset >> PAGE_SHIFT, NULL);
> +	page = read_mapping_page(file->f_mapping, offset >> PAGE_SHIFT, file);
>  	if (IS_ERR(page))
>  		return page;
>  	if (!PageUptodate(page)) {
> @@ -199,8 +199,8 @@ static void vfs_unlock_two_pages(struct page *page1, struct page *page2)
>   * Compare extents of two files to see if they are the same.
>   * Caller must have locked both inodes to prevent write races.
>   */
> -static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
> -					 struct inode *dest, loff_t destoff,
> +static int vfs_dedupe_file_range_compare(struct file *src, loff_t srcoff,
> +					 struct file *dst, loff_t destoff,

I kinda wish you'd maintained the name pairing here.  Why does destoff
go with dst instead of dst/dstoff or dest/destoff?

FWIW I try to vary the name lengths for similar variables these days,
because while my eyes are /fairly/ quick to distingiush 's' and 'd',
they're even faster if the width of the entire word is different.

(And yes, I had to break myself of the 'columns-must-line-up' habit.)

Using this method I've caught a few stupid variable name mixups in the
exchange-range code by doing a quick scan while ld takes an eternity to
link vmlinux together.

That aside, passing file pointers in seems like a good idea to me.

--D

>  					 loff_t len, bool *is_same)
>  {
>  	loff_t src_poff;
> @@ -229,7 +229,7 @@ static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
>  			error = PTR_ERR(src_page);
>  			goto out_error;
>  		}
> -		dest_page = vfs_dedupe_get_page(dest, destoff);
> +		dest_page = vfs_dedupe_get_page(dst, destoff);
>  		if (IS_ERR(dest_page)) {
>  			error = PTR_ERR(dest_page);
>  			put_page(src_page);
> @@ -244,8 +244,8 @@ static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
>  		 * someone is invalidating pages on us and we lose.
>  		 */
>  		if (!PageUptodate(src_page) || !PageUptodate(dest_page) ||
> -		    src_page->mapping != src->i_mapping ||
> -		    dest_page->mapping != dest->i_mapping) {
> +		    src_page->mapping != src->f_mapping ||
> +		    dest_page->mapping != dst->f_mapping) {
>  			same = false;
>  			goto unlock;
>  		}
> @@ -351,8 +351,8 @@ int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
>  	if (remap_flags & REMAP_FILE_DEDUP) {
>  		bool		is_same = false;
>  
> -		ret = vfs_dedupe_file_range_compare(inode_in, pos_in,
> -				inode_out, pos_out, *len, &is_same);
> +		ret = vfs_dedupe_file_range_compare(file_in, pos_in,
> +				file_out, pos_out, *len, &is_same);
>  		if (ret)
>  			return ret;
>  		if (!is_same)
> -- 
> 2.30.2
> 
