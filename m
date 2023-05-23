Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877BC70D70A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 10:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236124AbjEWIRV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 04:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235998AbjEWIQu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 04:16:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9262100;
        Tue, 23 May 2023 01:14:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B0F2A227CB;
        Tue, 23 May 2023 08:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684829686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y02gCNG6nB7w0gfklw/xrdsXliSx5WrraC17AwM4gKw=;
        b=A/c+L4fsgh9XmiD4U2hQFFz9/xuUiNcxFyugib8R28iHYDJ1f/h5K672yWFy1C4G2DrrBu
        VQr7nwA1jool8uQXnDLMrWn3KT/EFQmNkEIA67u7G09XoSTnJtHwPHG6/yxrwu5ERXUcB5
        y8NhxA8/Rh48gBQyMmNzUAOrroMTdYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684829686;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y02gCNG6nB7w0gfklw/xrdsXliSx5WrraC17AwM4gKw=;
        b=80dI5OQVdJmpQdTVK+hQwadzSM56Yi19Gm/nwRkojTYVAR9/NPSS4ODrfR/MFoKZOHAg96
        Npckv2kfDZhncoDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9BA9A13A10;
        Tue, 23 May 2023 08:14:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id J77vJfZ1bGSgNAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 23 May 2023 08:14:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2515FA075D; Tue, 23 May 2023 10:14:46 +0200 (CEST)
Date:   Tue, 23 May 2023 10:14:46 +0200
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
Subject: Re: [PATCH v21 6/6] block: convert bio_map_user_iov to use
 iov_iter_extract_pages
Message-ID: <20230523081446.qny4fmk5vlg3sxmg@quack3>
References: <20230522205744.2825689-1-dhowells@redhat.com>
 <20230522205744.2825689-7-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522205744.2825689-7-dhowells@redhat.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 22-05-23 21:57:44, David Howells wrote:
> This will pin pages or leave them unaltered rather than getting a ref on
> them as appropriate to the iterator.
> 
> The pages need to be pinned for DIO rather than having refs taken on them
> to prevent VM copy-on-write from malfunctioning during a concurrent fork()
> (the result of the I/O could otherwise end up being visible to/affected by
> the child process).
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
> ---

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> Notes:
>     ver #10)
>      - Drop bio_set_cleanup_mode(), open coding it instead.
>     
>     ver #8)
>      - Split the patch up a bit [hch].
>      - We should only be using pinned/non-pinned pages and not ref'd pages,
>        so adjust the comments appropriately.
>     
>     ver #7)
>      - Don't treat BIO_PAGE_REFFED/PINNED as being the same as FOLL_GET/PIN.
>     
>     ver #5)
>      - Transcribe the FOLL_* flags returned by iov_iter_extract_pages() to
>        BIO_* flags and got rid of bi_cleanup_mode.
>      - Replaced BIO_NO_PAGE_REF to BIO_PAGE_REFFED in the preceding patch.
> 
>  block/blk-map.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/block/blk-map.c b/block/blk-map.c
> index 33d9f6e89ba6..3551c3ff17cf 100644
> --- a/block/blk-map.c
> +++ b/block/blk-map.c
> @@ -281,22 +281,21 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
>  
>  	if (blk_queue_pci_p2pdma(rq->q))
>  		extraction_flags |= ITER_ALLOW_P2PDMA;
> +	if (iov_iter_extract_will_pin(iter))
> +		bio_set_flag(bio, BIO_PAGE_PINNED);
>  
> -	bio_set_flag(bio, BIO_PAGE_REFFED);
>  	while (iov_iter_count(iter)) {
> -		struct page **pages, *stack_pages[UIO_FASTIOV];
> +		struct page *stack_pages[UIO_FASTIOV];
> +		struct page **pages = stack_pages;
>  		ssize_t bytes;
>  		size_t offs;
>  		int npages;
>  
> -		if (nr_vecs <= ARRAY_SIZE(stack_pages)) {
> -			pages = stack_pages;
> -			bytes = iov_iter_get_pages(iter, pages, LONG_MAX,
> -						   nr_vecs, &offs, extraction_flags);
> -		} else {
> -			bytes = iov_iter_get_pages_alloc(iter, &pages,
> -						LONG_MAX, &offs, extraction_flags);
> -		}
> +		if (nr_vecs > ARRAY_SIZE(stack_pages))
> +			pages = NULL;
> +
> +		bytes = iov_iter_extract_pages(iter, &pages, LONG_MAX,
> +					       nr_vecs, extraction_flags, &offs);
>  		if (unlikely(bytes <= 0)) {
>  			ret = bytes ? bytes : -EFAULT;
>  			goto out_unmap;
> @@ -318,7 +317,7 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
>  				if (!bio_add_hw_page(rq->q, bio, page, n, offs,
>  						     max_sectors, &same_page)) {
>  					if (same_page)
> -						put_page(page);
> +						bio_release_page(bio, page);
>  					break;
>  				}
>  
> @@ -330,7 +329,7 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
>  		 * release the pages we didn't map into the bio, if any
>  		 */
>  		while (j < npages)
> -			put_page(pages[j++]);
> +			bio_release_page(bio, pages[j++]);
>  		if (pages != stack_pages)
>  			kvfree(pages);
>  		/* couldn't stuff something into bio? */
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
