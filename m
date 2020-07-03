Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC8F213970
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jul 2020 13:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbgGCLiF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jul 2020 07:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgGCLiE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jul 2020 07:38:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B2FC08C5C1;
        Fri,  3 Jul 2020 04:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jxMY/sjYHPMgsXoKZcO2Tjpd8qcWk4ZLnlW1zPQiZos=; b=SD5J6vFT+1Tw0Wjw31plD9IXaw
        LrSALOLcDbthbfpf9zjSDSLF6Xuq76HDWRsI0492sDO15gYcMKQb4pFpEuaH17S++AxwGzxGqXX9/
        BA5N1nuRbSLEFyYUX+zdvpIzPZajaNCTnVCfuuxb08WMRzNLXAwZ7weBv/lw1mpdUtiwKpGxsJyAY
        Zkz43tmgB1qbFYJFkhiY5CiBqJvpMeLe46rF3juS6d0yswVl2Wb5muNOlb/9nULj0yYbSTUfgxrUY
        ku6lmsJzMRqxGed1HT+Izr3xmPlxlCLLea3YyLqjFnQPhoHKK8nlUAi9JOjYgDQSAH8YsP1EkbHs2
        vPBPqM/w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrK13-000083-2w; Fri, 03 Jul 2020 11:38:01 +0000
Date:   Fri, 3 Jul 2020 12:38:01 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 2/2] gfs2: Rework read and page fault locking
Message-ID: <20200703113801.GD25523@casper.infradead.org>
References: <20200703095325.1491832-1-agruenba@redhat.com>
 <20200703095325.1491832-3-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703095325.1491832-3-agruenba@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 03, 2020 at 11:53:25AM +0200, Andreas Gruenbacher wrote:
> So far, gfs2 has taken the inode glocks inside the ->readpage and
> ->readahead address space operations.  Since commit d4388340ae0b ("fs:
> convert mpage_readpages to mpage_readahead"), gfs2_readahead is passed
> the pages to read ahead locked.  With that, the current holder of the
> inode glock may be trying to lock one of those pages while
> gfs2_readahead is trying to take the inode glock, resulting in a
> deadlock.
> 
> Fix that by moving the lock taking to the higher-level ->read_iter file
> and ->fault vm operations.  This also gets rid of an ugly lock inversion
> workaround in gfs2_readpage.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

> -/**
> - * __gfs2_readpage - readpage
> - * @file: The file to read a page for
> - * @page: The page to read
> - *
> - * This is the core of gfs2's readpage. It's used by the internal file
> - * reading code as in that case we already hold the glock. Also it's
> - * called by gfs2_readpage() once the required lock has been granted.
> - */
> -
>  static int __gfs2_readpage(void *file, struct page *page)

You could go a little further and rename this function to plain
gfs2_readpage().

gfs2_internal_read() should switch from read_cache_page() to
read_mapping_page().

>  {
>  	struct gfs2_inode *ip = GFS2_I(page->mapping->host);
>  	struct gfs2_sbd *sdp = GFS2_SB(page->mapping->host);
> -
>  	int error;
>  
>  	if (i_blocksize(page->mapping->host) == PAGE_SIZE &&
> @@ -505,36 +494,11 @@ static int __gfs2_readpage(void *file, struct page *page)
>   * gfs2_readpage - read a page of a file
>   * @file: The file to read
>   * @page: The page of the file
> - *
> - * This deals with the locking required. We have to unlock and
> - * relock the page in order to get the locking in the right
> - * order.
>   */

I'd drop the kernel-doc comments on method implementations entirely,
unless there's something useful to say ... which there isn't any more
(yay!)

> @@ -598,16 +562,9 @@ static void gfs2_readahead(struct readahead_control *rac)
>  {
>  	struct inode *inode = rac->mapping->host;
>  	struct gfs2_inode *ip = GFS2_I(inode);
> -	struct gfs2_holder gh;
>  
> -	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
> -	if (gfs2_glock_nq(&gh))
> -		goto out_uninit;
>  	if (!gfs2_is_stuffed(ip))
>  		mpage_readahead(rac, gfs2_block_map);

I think you probably want to make this:

	if (i_blocksize(page->mapping->host) == PAGE_SIZE &&
	    !page_has_buffers(page))
		error = iomap_readahead(rac, &gfs2_iomap_ops);
	else if (!gfs2_is_stuffed(ip))
		error = mpage_readahead(rac, gfs2_block_map);

... but I understand not wanting to make that change at this point
in the release cycle.

I'm happy for the patches to go in as-is, just wanted to point out these
improvements that could be made.
