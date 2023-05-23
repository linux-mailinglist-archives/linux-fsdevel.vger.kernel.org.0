Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5AC170D6C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 10:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235685AbjEWIKG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 04:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236099AbjEWIJm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 04:09:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6526E5C;
        Tue, 23 May 2023 01:08:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 07E2C2041B;
        Tue, 23 May 2023 08:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684829325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+dEVVbvNrEYxHr4b/vv5A6cTh8OogUJDKNko7MtzH3g=;
        b=aqMp1lCSDbRRddYRBHCTzgZ8x1pcGP1ICj8oT4unMeLI5CnphXMKLrBRpZ8cLmiW5m3sCY
        WeOiDgGdSZ+NKlLvTwbYdwdBaQAwX1+PsaFg8vEQkHvY/8P4JhZtJMhoc6cmh4zoiyQjew
        RoTL2lw9yc1D3Ur55S/L9aihQPQo1vo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684829325;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+dEVVbvNrEYxHr4b/vv5A6cTh8OogUJDKNko7MtzH3g=;
        b=85tYuyPi+5yLNN+ZI7057j42rnEVNsfXfZ4tHlK3EXP7KbqEhAAAAMKpvtPHvPPqQXevj2
        nQ+SP7q+8zjv1UDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ED42B13A10;
        Tue, 23 May 2023 08:08:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4o3rOYx0bGTrMQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 23 May 2023 08:08:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8C0CCA075D; Tue, 23 May 2023 10:08:44 +0200 (CEST)
Date:   Tue, 23 May 2023 10:08:44 +0200
From:   Jan Kara <jack@suse.cz>
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v21 4/6] block: Add BIO_PAGE_PINNED and associated
 infrastructure
Message-ID: <20230523080844.uxj3q244bcb3cot3@quack3>
References: <20230522205744.2825689-1-dhowells@redhat.com>
 <20230522205744.2825689-5-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522205744.2825689-5-dhowells@redhat.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 22-05-23 21:57:42, David Howells wrote:
> Add BIO_PAGE_PINNED to indicate that the pages in a bio are pinned
> (FOLL_PIN) and that the pin will need removing.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Jan Kara <jack@suse.cz>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: Logan Gunthorpe <logang@deltatee.com>
> cc: linux-block@vger.kernel.org

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> Notes:
>     ver #10)
>      - Drop bio_set_cleanup_mode(), open coding it instead.
>     
>     ver #9)
>      - Only consider pinning in bio_set_cleanup_mode().  Ref'ing pages in
>        struct bio is going away.
>      - page_put_unpin() is removed; call unpin_user_page() and put_page()
>        directly.
>      - Use bio_release_page() in __bio_release_pages().
>      - BIO_PAGE_PINNED and BIO_PAGE_REFFED can't both be set, so use if-else
>        when testing both of them.
>     
>     ver #8)
>      - Move the infrastructure to clean up pinned pages to this patch [hch].
>      - Put BIO_PAGE_PINNED before BIO_PAGE_REFFED as the latter should
>        probably be removed at some point.  FOLL_PIN can then be renumbered
>        first.
> 
>  block/bio.c               |  6 +++---
>  block/blk.h               | 12 ++++++++++++
>  include/linux/bio.h       |  3 ++-
>  include/linux/blk_types.h |  1 +
>  4 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 8516adeaea26..17bd01ecde36 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1169,7 +1169,7 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
>  	bio_for_each_segment_all(bvec, bio, iter_all) {
>  		if (mark_dirty && !PageCompound(bvec->bv_page))
>  			set_page_dirty_lock(bvec->bv_page);
> -		put_page(bvec->bv_page);
> +		bio_release_page(bio, bvec->bv_page);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(__bio_release_pages);
> @@ -1489,8 +1489,8 @@ void bio_set_pages_dirty(struct bio *bio)
>   * the BIO and re-dirty the pages in process context.
>   *
>   * It is expected that bio_check_pages_dirty() will wholly own the BIO from
> - * here on.  It will run one put_page() against each page and will run one
> - * bio_put() against the BIO.
> + * here on.  It will unpin each page and will run one bio_put() against the
> + * BIO.
>   */
>  
>  static void bio_dirty_fn(struct work_struct *work);
> diff --git a/block/blk.h b/block/blk.h
> index 45547bcf1119..e1ded2ccb3ca 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -420,6 +420,18 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
>  		struct page *page, unsigned int len, unsigned int offset,
>  		unsigned int max_sectors, bool *same_page);
>  
> +/*
> + * Clean up a page appropriately, where the page may be pinned, may have a
> + * ref taken on it or neither.
> + */
> +static inline void bio_release_page(struct bio *bio, struct page *page)
> +{
> +	if (bio_flagged(bio, BIO_PAGE_PINNED))
> +		unpin_user_page(page);
> +	else if (bio_flagged(bio, BIO_PAGE_REFFED))
> +		put_page(page);
> +}
> +
>  struct request_queue *blk_alloc_queue(int node_id);
>  
>  int disk_scan_partitions(struct gendisk *disk, fmode_t mode);
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 0922729acd26..8588bcfbc6ef 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -488,7 +488,8 @@ void zero_fill_bio(struct bio *bio);
>  
>  static inline void bio_release_pages(struct bio *bio, bool mark_dirty)
>  {
> -	if (bio_flagged(bio, BIO_PAGE_REFFED))
> +	if (bio_flagged(bio, BIO_PAGE_REFFED) ||
> +	    bio_flagged(bio, BIO_PAGE_PINNED))
>  		__bio_release_pages(bio, mark_dirty);
>  }
>  
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index dfd2c2cb909d..8ef209e3aa96 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -323,6 +323,7 @@ struct bio {
>   * bio flags
>   */
>  enum {
> +	BIO_PAGE_PINNED,	/* Unpin pages in bio_release_pages() */
>  	BIO_PAGE_REFFED,	/* put pages in bio_release_pages() */
>  	BIO_CLONED,		/* doesn't own data */
>  	BIO_BOUNCED,		/* bio is a bounce bio */
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
