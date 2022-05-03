Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1E5518688
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 16:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236953AbiECO0r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 10:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232563AbiECO0q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 10:26:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7828D2CE0F;
        Tue,  3 May 2022 07:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ju/iZlZ6jgMS2d2Zf1pbk2pGv50CqxHpXJ4XfKDnyxk=; b=4WxTR4r5SLFRqYcVsX21RJsKWd
        jTyedjdpAKqfrahSRntw9agyRRi+2eO7wRAd7VH+BB6WdkS8paLrmtitebFwiEFRxzKLqeyTHKAgi
        aJoMhejL4HiEgH8hgAZ+xVvn5soDCjLxrGeEDEv0gwvpuLWU4bCnCWb0Pl7bpsz5QWlUPMC1RNyea
        KZajp9BGEAWcdPTB7P/2whFHfWw/NeP9EtasdhLzDcsbGXkip1fXvZ5tIWJtNJ0a43mjL6xkcJ8jl
        f20umpGcPnzH+GUiHk1RwqP7KGFxIWJLt5N8Du6NBrzkfwKHgYFPoC3TJ8P9OR6n7kwFdEyJhVo7V
        Z42+5uQg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nltQn-006F1Q-TM; Tue, 03 May 2022 14:23:13 +0000
Date:   Tue, 3 May 2022 07:23:13 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com,
        linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 3/3] fs: Change the type of filler_t
Message-ID: <YnE60WTzSzxt9OxY@infradead.org>
References: <20220502054159.3471078-1-willy@infradead.org>
 <20220502054159.3471078-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502054159.3471078-4-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 02, 2022 at 06:41:59AM +0100, Matthew Wilcox (Oracle) wrote:
> By making filler_t the same as read_folio, we can use the same function
> for both in gfs2.  We can push the use of folios down one more level
> in jffs2 and nfs.  We also increase type safety for future users of the
> various read_cache_page() family of functions by forcing the parameter
> to be a pointer to struct file (or NULL).
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/gfs2/aops.c          | 29 +++++++++++------------------
>  fs/jffs2/file.c         |  9 ++++-----
>  fs/jffs2/gc.c           |  2 +-
>  fs/jffs2/os-linux.h     |  2 +-
>  fs/nfs/symlink.c        | 14 +++++++-------
>  include/linux/pagemap.h |  6 +++---
>  mm/filemap.c            | 40 ++++++++++++++++++++--------------------
>  7 files changed, 47 insertions(+), 55 deletions(-)
> 
> diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
> index 340bf5d0e835..1016631bcbdc 100644
> --- a/fs/gfs2/aops.c
> +++ b/fs/gfs2/aops.c
> @@ -464,21 +464,24 @@ static int stuffed_readpage(struct gfs2_inode *ip, struct page *page)
>  	return 0;
>  }
>  
> -
> -static int __gfs2_readpage(void *file, struct page *page)
> +/**
> + * gfs2_read_folio - read a folio from a file
> + * @file: The file to read
> + * @folio: The folio in the file
> + */
> +static int gfs2_read_folio(struct file *file, struct folio *folio)
>  {
> -	struct folio *folio = page_folio(page);
> -	struct inode *inode = page->mapping->host;
> +	struct inode *inode = folio->mapping->host;
>  	struct gfs2_inode *ip = GFS2_I(inode);
>  	struct gfs2_sbd *sdp = GFS2_SB(inode);
>  	int error;
>  
>  	if (!gfs2_is_jdata(ip) ||
> -	    (i_blocksize(inode) == PAGE_SIZE && !page_has_buffers(page))) {
> +	    (i_blocksize(inode) == PAGE_SIZE && !folio_buffers(folio))) {
>  		error = iomap_read_folio(folio, &gfs2_iomap_ops);
>  	} else if (gfs2_is_stuffed(ip)) {
> -		error = stuffed_readpage(ip, page);
> -		unlock_page(page);
> +		error = stuffed_readpage(ip, &folio->page);
> +		folio_unlock(folio);
>  	} else {
>  		error = mpage_read_folio(folio, gfs2_block_map);
>  	}
> @@ -489,16 +492,6 @@ static int __gfs2_readpage(void *file, struct page *page)
>  	return error;
>  }
>  
> -/**
> - * gfs2_read_folio - read a folio from a file
> - * @file: The file to read
> - * @folio: The folio in the file
> - */
> -static int gfs2_read_folio(struct file *file, struct folio *folio)
> -{
> -	return __gfs2_readpage(file, &folio->page);
> -}
> -
>  /**
>   * gfs2_internal_read - read an internal file
>   * @ip: The gfs2 inode
> @@ -523,7 +516,7 @@ int gfs2_internal_read(struct gfs2_inode *ip, char *buf, loff_t *pos,
>  		amt = size - copied;
>  		if (offset + size > PAGE_SIZE)
>  			amt = PAGE_SIZE - offset;
> -		page = read_cache_page(mapping, index, __gfs2_readpage, NULL);
> +		page = read_cache_page(mapping, index, gfs2_read_folio, NULL);
>  		if (IS_ERR(page))
>  			return PTR_ERR(page);
>  		p = kmap_atomic(page);
> diff --git a/fs/jffs2/file.c b/fs/jffs2/file.c
> index 492fb2da0403..ba86acbe12d3 100644
> --- a/fs/jffs2/file.c
> +++ b/fs/jffs2/file.c
> @@ -110,21 +110,20 @@ static int jffs2_do_readpage_nolock (struct inode *inode, struct page *pg)
>  	return ret;
>  }
>  
> -int jffs2_do_readpage_unlock(void *data, struct page *pg)
> +int __jffs2_read_folio(struct file *file, struct folio *folio)
>  {
> -	int ret = jffs2_do_readpage_nolock(pg->mapping->host, pg);
> -	unlock_page(pg);
> +	int ret = jffs2_do_readpage_nolock(folio->mapping->host, &folio->page);
> +	folio_unlock(folio);
>  	return ret;
>  }
>  
> -
>  static int jffs2_read_folio(struct file *file, struct folio *folio)
>  {
>  	struct jffs2_inode_info *f = JFFS2_INODE_INFO(folio->mapping->host);
>  	int ret;
>  
>  	mutex_lock(&f->sem);
> -	ret = jffs2_do_readpage_unlock(file, &folio->page);
> +	ret = __jffs2_read_folio(file, folio);
>  	mutex_unlock(&f->sem);
>  	return ret;
>  }
> diff --git a/fs/jffs2/gc.c b/fs/jffs2/gc.c
> index a53bac7569b6..5c6602f3c189 100644
> --- a/fs/jffs2/gc.c
> +++ b/fs/jffs2/gc.c
> @@ -1327,7 +1327,7 @@ static int jffs2_garbage_collect_dnode(struct jffs2_sb_info *c, struct jffs2_era
>  	 * trying to write out, read_cache_page() will not deadlock. */
>  	mutex_unlock(&f->sem);
>  	page = read_cache_page(inode->i_mapping, start >> PAGE_SHIFT,
> -			       jffs2_do_readpage_unlock, NULL);
> +			       __jffs2_read_folio, NULL);
>  	if (IS_ERR(page)) {
>  		pr_warn("read_cache_page() returned error: %ld\n",
>  			PTR_ERR(page));
> diff --git a/fs/jffs2/os-linux.h b/fs/jffs2/os-linux.h
> index 173eccac691d..921d782583d6 100644
> --- a/fs/jffs2/os-linux.h
> +++ b/fs/jffs2/os-linux.h
> @@ -155,7 +155,7 @@ extern const struct file_operations jffs2_file_operations;
>  extern const struct inode_operations jffs2_file_inode_operations;
>  extern const struct address_space_operations jffs2_file_address_operations;
>  int jffs2_fsync(struct file *, loff_t, loff_t, int);
> -int jffs2_do_readpage_unlock(void *data, struct page *pg);
> +int __jffs2_read_folio(struct file *file, struct folio *folio);
>  
>  /* ioctl.c */
>  long jffs2_ioctl(struct file *, unsigned int, unsigned long);
> diff --git a/fs/nfs/symlink.c b/fs/nfs/symlink.c
> index 8b53538bcc75..0e27a2e4e68b 100644
> --- a/fs/nfs/symlink.c
> +++ b/fs/nfs/symlink.c
> @@ -26,21 +26,21 @@
>   * and straight-forward than readdir caching.
>   */
>  
> -static int nfs_symlink_filler(void *data, struct page *page)
> +static int nfs_symlink_filler(struct file *file, struct folio *folio)
>  {
> -	struct inode *inode = page->mapping->host;
> +	struct inode *inode = folio->mapping->host;
>  	int error;
>  
> -	error = NFS_PROTO(inode)->readlink(inode, page, 0, PAGE_SIZE);
> +	error = NFS_PROTO(inode)->readlink(inode, &folio->page, 0, PAGE_SIZE);
>  	if (error < 0)
>  		goto error;
> -	SetPageUptodate(page);
> -	unlock_page(page);
> +	folio_mark_uptodate(folio);
> +	folio_unlock(folio);
>  	return 0;
>  
>  error:
> -	SetPageError(page);
> -	unlock_page(page);
> +	folio_set_error(folio);
> +	folio_unlock(folio);
>  	return -EIO;
>  }
>  
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index b70192f56454..831b28dab01a 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -492,7 +492,7 @@ static inline gfp_t readahead_gfp_mask(struct address_space *x)
>  	return mapping_gfp_mask(x) | __GFP_NORETRY | __GFP_NOWARN;
>  }
>  
> -typedef int filler_t(void *, struct page *);
> +typedef int filler_t(struct file *, struct folio *);
>  
>  pgoff_t page_cache_next_miss(struct address_space *mapping,
>  			     pgoff_t index, unsigned long max_scan);
> @@ -747,9 +747,9 @@ static inline struct page *grab_cache_page(struct address_space *mapping,
>  }
>  
>  struct folio *read_cache_folio(struct address_space *, pgoff_t index,
> -		filler_t *filler, void *data);
> +		filler_t *filler, struct file *file);
>  struct page *read_cache_page(struct address_space *, pgoff_t index,
> -		filler_t *filler, void *data);
> +		filler_t *filler, struct file *file);
>  extern struct page * read_cache_page_gfp(struct address_space *mapping,
>  				pgoff_t index, gfp_t gfp_mask);
>  
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 079f8cca7959..81a0ed08a82c 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3483,7 +3483,7 @@ EXPORT_SYMBOL(generic_file_mmap);
>  EXPORT_SYMBOL(generic_file_readonly_mmap);
>  
>  static struct folio *do_read_cache_folio(struct address_space *mapping,
> -		pgoff_t index, filler_t filler, void *data, gfp_t gfp)
> +		pgoff_t index, filler_t filler, struct file *file, gfp_t gfp)
>  {
>  	struct folio *folio;
>  	int err;
> @@ -3504,9 +3504,9 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
>  
>  filler:
>  		if (filler)
> -			err = filler(data, &folio->page);
> +			err = filler(file, folio);
>  		else
> -			err = mapping->a_ops->read_folio(data, folio);
> +			err = mapping->a_ops->read_folio(file, folio);

Wouldn't it just make sense to just pass mapping->a_ops->read_folio as
the filler here from the callers that currently pass NULL?

Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
