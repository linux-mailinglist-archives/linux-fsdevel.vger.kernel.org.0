Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840B570D70E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 10:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236143AbjEWIRz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 04:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235772AbjEWIRH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 04:17:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D01171C;
        Tue, 23 May 2023 01:15:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D48F72041D;
        Tue, 23 May 2023 08:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684829707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zWw/T7rwHSimbHVkp4+v1OXRQuiFSOj6e4gDbi9lREQ=;
        b=wtDzdDHF0Br+Uhki4HbRPGxLQHhofVARenTOezF6rYvQZUaOIr0HVmKsJY1msqQUAdlSDh
        wMlvrekipOTP82oP0mfkAKzDhsiG+TzIUIdBeFcOu3HnL/5F0rFa4ibSovcUVeX60vOIzh
        zkI3AjuT45ZFzF82C2oY5lPgfaLnscs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684829707;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zWw/T7rwHSimbHVkp4+v1OXRQuiFSOj6e4gDbi9lREQ=;
        b=l9fYplhWdg84Mz1JKrEpNHtgWMMrq1aMVNg3sxRvkeugy/F6jeuMJkgqIUR8ldgSs9qd3O
        P8Gm9UvhV9FvRuCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BFDD513A10;
        Tue, 23 May 2023 08:15:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lj7RLgt2bGTdNAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 23 May 2023 08:15:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 49B4AA075D; Tue, 23 May 2023 10:15:07 +0200 (CEST)
Date:   Tue, 23 May 2023 10:15:07 +0200
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
Subject: Re: [PATCH v21 5/6] block: Convert bio_iov_iter_get_pages to use
 iov_iter_extract_pages
Message-ID: <20230523081507.sjzaau75hhw3oyul@quack3>
References: <20230522205744.2825689-1-dhowells@redhat.com>
 <20230522205744.2825689-6-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522205744.2825689-6-dhowells@redhat.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 22-05-23 21:57:43, David Howells wrote:
> This will pin pages or leave them unaltered rather than getting a ref on
> them as appropriate to the iterator.
> 
> The pages need to be pinned for DIO rather than having refs taken on them to
> prevent VM copy-on-write from malfunctioning during a concurrent fork() (the
> result of the I/O could otherwise end up being affected by/visible to the
> child process).
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
>  block/bio.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 17bd01ecde36..798cc4cf3bd2 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1205,7 +1205,7 @@ static int bio_iov_add_page(struct bio *bio, struct page *page,
>  	}
>  
>  	if (same_page)
> -		put_page(page);
> +		bio_release_page(bio, page);
>  	return 0;
>  }
>  
> @@ -1219,7 +1219,7 @@ static int bio_iov_add_zone_append_page(struct bio *bio, struct page *page,
>  			queue_max_zone_append_sectors(q), &same_page) != len)
>  		return -EINVAL;
>  	if (same_page)
> -		put_page(page);
> +		bio_release_page(bio, page);
>  	return 0;
>  }
>  
> @@ -1230,10 +1230,10 @@ static int bio_iov_add_zone_append_page(struct bio *bio, struct page *page,
>   * @bio: bio to add pages to
>   * @iter: iov iterator describing the region to be mapped
>   *
> - * Pins pages from *iter and appends them to @bio's bvec array. The
> - * pages will have to be released using put_page() when done.
> - * For multi-segment *iter, this function only adds pages from the
> - * next non-empty segment of the iov iterator.
> + * Extracts pages from *iter and appends them to @bio's bvec array.  The pages
> + * will have to be cleaned up in the way indicated by the BIO_PAGE_PINNED flag.
> + * For a multi-segment *iter, this function only adds pages from the next
> + * non-empty segment of the iov iterator.
>   */
>  static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  {
> @@ -1265,9 +1265,9 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  	 * result to ensure the bio's total size is correct. The remainder of
>  	 * the iov data will be picked up in the next bio iteration.
>  	 */
> -	size = iov_iter_get_pages(iter, pages,
> -				  UINT_MAX - bio->bi_iter.bi_size,
> -				  nr_pages, &offset, extraction_flags);
> +	size = iov_iter_extract_pages(iter, &pages,
> +				      UINT_MAX - bio->bi_iter.bi_size,
> +				      nr_pages, extraction_flags, &offset);
>  	if (unlikely(size <= 0))
>  		return size ? size : -EFAULT;
>  
> @@ -1300,7 +1300,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  	iov_iter_revert(iter, left);
>  out:
>  	while (i < nr_pages)
> -		put_page(pages[i++]);
> +		bio_release_page(bio, pages[i++]);
>  
>  	return ret;
>  }
> @@ -1335,7 +1335,8 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  		return 0;
>  	}
>  
> -	bio_set_flag(bio, BIO_PAGE_REFFED);
> +	if (iov_iter_extract_will_pin(iter))
> +		bio_set_flag(bio, BIO_PAGE_PINNED);
>  	do {
>  		ret = __bio_iov_iter_get_pages(bio, iter);
>  	} while (!ret && iov_iter_count(iter) && !bio_full(bio, 0));
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
