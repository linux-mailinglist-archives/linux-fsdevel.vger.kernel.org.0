Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B22D37AFF1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 22:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhEKUIF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 16:08:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229548AbhEKUIF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 16:08:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 88B6B611AE;
        Tue, 11 May 2021 20:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620763618;
        bh=GMDFSjsIjWB+iPagsYJizd5wdqS9xQPEFTxQ1sTHr2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eJRJmNZ0nAS7bu3eEAfplKA4bL4RYmJaQwxKlS2nUSJhVEgP8pf/jW2Ie9+NBLFIH
         GX8g43gxpausQ1wRedXdO2/fCEHAYtK8optGkS93yG4N45Sn/GH77d+gAudSx4fz2V
         MRglEJimTcYzHmnHi/OSoG6KieE30s1kOxPiws0PrUZqvH4LlfQgl5/4Gwe/3fURN4
         hfrmy4kPG/Q1n7hR3yiFZoxqgz26EmFwQ9JmELQ5Nb8nVcs3EXor+epNAR/3QG4ADC
         yCTb33X9pM/5HDi3iiKbp4fA0XYK/GtqgMkumTGsfHKCpAbtvsxT+2mobcUoZSmFvt
         mdo2PKb8CkFVg==
Date:   Tue, 11 May 2021 13:06:56 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2] vfs/dedupe: Pass file pointer to read_mapping_page
Message-ID: <20210511200656.GD8606@magnolia>
References: <20210511184019.1802090-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511184019.1802090-1-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 11, 2021 at 07:40:19PM +0100, Matthew Wilcox (Oracle) wrote:
> Some filesystems (mostly networking) need a valid file pointer for
> their ->readpage operation to supply credentials.  Since there are no
> bug reports, I assume none of them currently support deduplication.
> It's just as easy to pass the struct file around as it is to pass the
> struct inode around, and it sets a good example for other users as well
> as being good future-proofing.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Sorry for getting this wrong from the start, or "Yay fixes!" :)

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/remap_range.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/remap_range.c b/fs/remap_range.c
> index e4a5fdd7ad7b..56f44a9b4ab6 100644
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
> +					 struct file *dest, loff_t destoff,
>  					 loff_t len, bool *is_same)
>  {
>  	loff_t src_poff;
> @@ -244,8 +244,8 @@ static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
>  		 * someone is invalidating pages on us and we lose.
>  		 */
>  		if (!PageUptodate(src_page) || !PageUptodate(dest_page) ||
> -		    src_page->mapping != src->i_mapping ||
> -		    dest_page->mapping != dest->i_mapping) {
> +		    src_page->mapping != src->f_mapping ||
> +		    dest_page->mapping != dest->f_mapping) {
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
