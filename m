Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED177200828
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 13:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732803AbgFSL4D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 07:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732225AbgFSL4B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 07:56:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E19C06174E;
        Fri, 19 Jun 2020 04:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qkiSuMBHq1jJPg79H69BLQzOTNgh3NSXy1sjSUD7sso=; b=YmQH+Tq34JCOA4Fpp+Ct6KEZnt
        8L0h3XQhFTfcl+EZx9PD/QmFfjIZnpy4HoPgNnfBqHv64Iq5KfuRrtvHpLcfBtAlvvzZLZIa6wd8f
        WBdUMayWL2szYgJzuQAOr0qIZuM5ocftxFPIzNGVjJSWVMSlvpoZeOYI4S4AGQO8Nb0yis8YPFDTs
        gFrJkRAnXtTDuea5wOUzzuns5noEUpSfRbZfvMS0JhmrqudLco3NaWgMJzebBPpoOvVOvwgRaFW3F
        NclEHximP3q4U57rebPA25c4PcGKBj5TM+IBkvwcGuWphYM+ITP6Po2I7wixaC/wuvOd6BghDK1It
        5dgYN/wg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmFcc-0002c8-O0; Fri, 19 Jun 2020 11:55:50 +0000
Date:   Fri, 19 Jun 2020 04:55:50 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-mm@kvack.org, ocfs2-devel@oss.oracle.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] gfs2: Rework read and page fault locking
Message-ID: <20200619115550.GY8681@bombadil.infradead.org>
References: <20200619093916.1081129-1-agruenba@redhat.com>
 <20200619093916.1081129-3-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619093916.1081129-3-agruenba@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 19, 2020 at 11:39:16AM +0200, Andreas Gruenbacher wrote:
>  static int gfs2_readpage(struct file *file, struct page *page)
>  {
> -	struct address_space *mapping = page->mapping;
> -	struct gfs2_inode *ip = GFS2_I(mapping->host);
> -	struct gfs2_holder gh;
>  	int error;
>  
> -	unlock_page(page);
> -	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
> -	error = gfs2_glock_nq(&gh);
> -	if (unlikely(error))
> -		goto out;
> -	error = AOP_TRUNCATED_PAGE;
> -	lock_page(page);
> -	if (page->mapping == mapping && !PageUptodate(page))
> -		error = __gfs2_readpage(file, page);
> -	else
> -		unlock_page(page);
> -	gfs2_glock_dq(&gh);
> -out:
> -	gfs2_holder_uninit(&gh);
> -	if (error && error != AOP_TRUNCATED_PAGE)
> +	error = __gfs2_readpage(file, page);
> +	if (error)
>  		lock_page(page);
>  	return error;

I don't think this is right.  If you return an error from ->readpage, I'm
pretty sure you're supposed to unlock that page.  Looking at
generic_file_buffered_read():

                error = mapping->a_ops->readpage(filp, page);
                if (unlikely(error)) {
                        if (error == AOP_TRUNCATED_PAGE) {
                                put_page(page);
                                error = 0;
                                goto find_page;
                        }
                        goto readpage_error;
                }
...
readpage_error:
                put_page(page);
                goto out;
...
out:
        ra->prev_pos = prev_index;
        ra->prev_pos <<= PAGE_SHIFT;
        ra->prev_pos |= prev_offset;

        *ppos = ((loff_t)index << PAGE_SHIFT) + offset;
        file_accessed(filp);
        return written ? written : error;

so we don't call unlock_page() in generic code, which means the next time
we try to get this page, we'll do ...

                page = find_get_page(mapping, index);
...
                if (!PageUptodate(page)) {
                        error = wait_on_page_locked_killable(page);
and presumably we'll wait forever because nobody is going to unlock this
page?

> @@ -598,16 +582,9 @@ static void gfs2_readahead(struct readahead_control *rac)
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
> -	gfs2_glock_dq(&gh);
> -out_uninit:
> -	gfs2_holder_uninit(&gh);
>  }

Not for this patch, obviously, but why do you go to the effort of using
iomap_readpage() to implement gfs2_readpage(), but don't use iomap for
gfs2_readahead()?  Far more pages are brought in through ->readahead
than are brought in through ->readpage.

>  static ssize_t gfs2_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  {
> +	struct gfs2_inode *ip;
> +	struct gfs2_holder gh;
> +	size_t written = 0;
>  	ssize_t ret;
>  
> +	gfs2_holder_mark_uninitialized(&gh);
>  	if (iocb->ki_flags & IOCB_DIRECT) {
>  		ret = gfs2_file_direct_read(iocb, to);

Again, future work, but you probably want to pass in &gh here so you
don't have to eat up another 32 bytes or so of stack space on an unused
gfs2_holder.

>  		if (likely(ret != -ENOTBLK))
>  			return ret;
>  		iocb->ki_flags &= ~IOCB_DIRECT;
>  	}
> -	return generic_file_read_iter(iocb, to);
> +	iocb->ki_flags |= IOCB_CACHED;
> +	ret = generic_file_read_iter(iocb, to);
> +	iocb->ki_flags &= ~IOCB_CACHED;
> +	if (ret >= 0) {
> +		if (!iov_iter_count(to))
> +			return ret;
> +		written = ret;
> +	} else {
> +		switch(ret) {
> +		case -EAGAIN:
> +			if (iocb->ki_flags & IOCB_NOWAIT)
> +				return ret;
> +			break;
> +		case -ECANCELED:
> +			break;
> +		default:
> +			return ret;
> +		}
> +	}

I'm wondering if we want to do this in common code rather than making it
something special only a few filesystems do (either because they care
about workloads with many threads accessing the same file, or because
their per-file locks are very heavy-weight).

