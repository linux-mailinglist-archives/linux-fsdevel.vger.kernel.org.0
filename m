Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C28563D65C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 19:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235742AbhGZQsD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 12:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236125AbhGZQsA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 12:48:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F19C0F26E9;
        Mon, 26 Jul 2021 10:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Vqs3NN7xHX7VuOasPLpzjTGLT3AH9xa8Uq7MQmQ6U4c=; b=FHZjLR+NROgvBqw4Rm7M0EuXpa
        Kq6UeMFn2BtIU2GMt1yXDOwsIQZHALmf+/OE6I98Khff0DHRw8lbz4cZx6pl/fT02klNbbERY4Wl9
        73UDsnMBCMKydcqtpoq0Np+twUCVzutn0wWZQI/9BkedfPwQ93MnGgGoGg3D/rErUq5MwHPDXsvC6
        xHMFpHwVQJg3ZVRYJxwGD6376R4w+aik2waOk0pqxN1RhLFxH8wb8tB4GqkYfawx4Ut2aFgesDBw3
        rcviwx77AEEexcFpnrw6y66YYaEkaDUyP0NlaE8/MYGc7IVElytXGb805x+X6gnoa/0v6x6P+Ej9l
        Cx7Uu3RA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m84GP-00EExM-FX; Mon, 26 Jul 2021 17:19:47 +0000
Date:   Mon, 26 Jul 2021 18:19:37 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] fs: reduce pointers while using file_ra_state_init()
Message-ID: <YP7uqRrXsbCqTpfx@casper.infradead.org>
References: <20210726164647.brx3l2ykwv3zz7vr@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726164647.brx3l2ykwv3zz7vr@fiona>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 26, 2021 at 11:46:47AM -0500, Goldwyn Rodrigues wrote:
> Simplification.
> 
> file_ra_state_init() take struct address_space *, just to use inode
> pointer by dereferencing from mapping->host.
> 
> The callers also derive mapping either by file->f_mapping, or
> even file->f_mapping->host->i_mapping.
> 
> Change file_ra_state_init() to accept struct inode * to reduce pointer
> dereferencing, both in the callee and the caller.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

(some adjacent comments)

> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index 4806295116d8..c43bf9915cda 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -351,7 +351,7 @@ static void readahead_cache(struct inode *inode)
>  	if (!ra)
>  		return;
>  
> -	file_ra_state_init(ra, inode->i_mapping);
> +	file_ra_state_init(ra, inode);
>  	last_index = (i_size_read(inode) - 1) >> PAGE_SHIFT;
>  
>  	page_cache_sync_readahead(inode->i_mapping, ra, NULL, 0, last_index);

Why does btrfs allocate a file_ra_state using kmalloc instead of
on the stack?

> +++ b/include/linux/fs.h
> @@ -3260,7 +3260,7 @@ extern long do_splice_direct(struct file *in, loff_t *ppos, struct file *out,
>  
>  
>  extern void
> -file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping);
> +file_ra_state_init(struct file_ra_state *ra, struct inode *inode);

This should move to pagemap.h (and lose the extern).
I'd put it near the definition of VM_READAHEAD_PAGES.

> diff --git a/mm/readahead.c b/mm/readahead.c
> index d589f147f4c2..3541941df5e7 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -31,9 +31,9 @@
>   * memset *ra to zero.
>   */
>  void
> -file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping)
> +file_ra_state_init(struct file_ra_state *ra, struct inode *inode)
>  {
> -	ra->ra_pages = inode_to_bdi(mapping->host)->ra_pages;
> +	ra->ra_pages = inode_to_bdi(inode)->ra_pages;
>  	ra->prev_pos = -1;
>  }
>  EXPORT_SYMBOL_GPL(file_ra_state_init);

I'm not entirely sure why this function is out-of-line, tbh.
Would it make more sense for it to be static inline in a header?
