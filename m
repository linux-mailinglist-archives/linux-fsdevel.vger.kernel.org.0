Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFCD6AC8C7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Mar 2023 17:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjCFQyp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 11:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCFQyo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:54:44 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC594391D;
        Mon,  6 Mar 2023 08:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mJSF1Ywx6z0mGMzdYzVD02f9wlhXiIbZLi0DEBUkFeU=; b=4W+naTxVvLaKelVIlzOADVjTbz
        zbCaq2xAMhoc7OJy1f/RCDyXZT4VA4nFUh6Ad2O9b6XMv5hTB0DjrLhd1nhvy2vGf2JAbiCGAefDa
        1ERMrudAE+Nc4OleRwkXKoYBxjgignNHljhMKq7xs8taw1O7hhPFBCBrfRNuL7ggu7hcmWqVUnypN
        YHZCRxKHA2Cza5puDW/i46JF61Yl8qFc/6rsFrLut8hhD4XmTKXHRvR6Y3WYX8b25O+MVt9V6wMBu
        Lf9p6vplwjrvaI4z1gec6K+JUzilD9SJVASZdkLIYX566D/ZMoycan7ww4Yad0wBdNQBU4fiwtFg5
        vv97/kng==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pZE58-00E0hR-CA; Mon, 06 Mar 2023 16:53:02 +0000
Date:   Mon, 6 Mar 2023 08:53:02 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 01/21] fs: readahead_begin() to call before locking folio
Message-ID: <ZAYaboLpVfTC71+3@infradead.org>
References: <cover.1677793433.git.rgoldwyn@suse.com>
 <4b8c7d11d7440523dba12205a88b7d43f61a07b1.1677793433.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b8c7d11d7440523dba12205a88b7d43f61a07b1.1677793433.git.rgoldwyn@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 02, 2023 at 04:24:46PM -0600, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> The btrfs filesystem needs to lock the extents before locking folios
> to be read from disk. So, introduce a function in
> address_space_operaitons, called btrfs_readahead_begin() which is called
> before the folio are allocateed and locked.

Please Cc the mm and fsdevel and willy on these kinds of changes.

But I'd also like to take this opportunity to ask what the rationale
behind the extent locking for reads in btrfs is to start with.

All other file systems rely on filemap_invalidate_lock_shared for
locking page reads vs invalidates and it seems to work great.  btrfs
creates a lot of overhead with the extent locking, and introduces
a lot of additional trouble like the readahead code here, or the problem
with O_DIRECT writes that read from the same region that Boris recently
fixed.

Maybe we can think really hard and find a way to normalize the locking
and simply both btrfs and common infrastructure?

> ---
>  include/linux/fs.h | 1 +
>  mm/readahead.c     | 3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c1769a2c5d70..6b650db57ca3 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -363,6 +363,7 @@ struct address_space_operations {
>  	/* Mark a folio dirty.  Return true if this dirtied it */
>  	bool (*dirty_folio)(struct address_space *, struct folio *);
>  
> +	void (*readahead_begin)(struct readahead_control *);
>  	void (*readahead)(struct readahead_control *);
>  
>  	int (*write_begin)(struct file *, struct address_space *mapping,
> diff --git a/mm/readahead.c b/mm/readahead.c
> index b10f0cf81d80..6924d5fed350 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -520,6 +520,9 @@ void page_cache_ra_order(struct readahead_control *ractl,
>  			new_order--;
>  	}
>  
> +	if (mapping->a_ops->readahead_begin)
> +		mapping->a_ops->readahead_begin(ractl);
> +
>  	filemap_invalidate_lock_shared(mapping);
>  	while (index <= limit) {
>  		unsigned int order = new_order;
> -- 
> 2.39.2
> 
---end quoted text---
