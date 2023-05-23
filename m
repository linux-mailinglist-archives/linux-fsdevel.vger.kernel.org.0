Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA16870D6B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 10:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236022AbjEWIIc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 04:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236052AbjEWIIH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 04:08:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92199E64;
        Tue, 23 May 2023 01:07:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 073F82041E;
        Tue, 23 May 2023 08:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684829261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0wGcfOfd6nV+e+2j2HmOyRi8LKJabDurCag/9oAnpHY=;
        b=pdiqQbjbdtVFLjV3mMYN3Qeq5kEgiIPjwHzwb2kOnVWmLwNcmjK4cOD0YieNyXCWfaqxP5
        /1Wbqs56VvW0hy2hULLaG3zygcEv7lcJ+JTxxLrOK8A+zJ744fbMkYOIymb6A9PungE5EA
        nM4AAaVppuRFgCLifJ4I/0EahxnKyrY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684829261;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0wGcfOfd6nV+e+2j2HmOyRi8LKJabDurCag/9oAnpHY=;
        b=Kr8JgWOTkrVNdprb7S17RGPXtiah7P5e/k8F3TmqZRph5c4IYYPrhsIZMd2OWlpTY9LXs2
        nlBh4bPk9CTMvODA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EC26A13A10;
        Tue, 23 May 2023 08:07:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9z+gOUx0bGRgMQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 23 May 2023 08:07:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8E579A075D; Tue, 23 May 2023 10:07:40 +0200 (CEST)
Date:   Tue, 23 May 2023 10:07:40 +0200
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
Subject: Re: [PATCH v21 3/6] block: Replace BIO_NO_PAGE_REF with
 BIO_PAGE_REFFED with inverted logic
Message-ID: <20230523080740.jpqdcwyzws3drwyr@quack3>
References: <20230522205744.2825689-1-dhowells@redhat.com>
 <20230522205744.2825689-4-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522205744.2825689-4-dhowells@redhat.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 22-05-23 21:57:41, David Howells wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> Replace BIO_NO_PAGE_REF with a BIO_PAGE_REFFED flag that has the inverted
> meaning is only set when a page reference has been acquired that needs to
> be released by bio_release_pages().
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: David Howells <dhowells@redhat.com>
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
>     ver #8)
>      - Split out from another patch [hch].
>      - Don't default to BIO_PAGE_REFFED [hch].
>     
>     ver #5)
>      - Split from patch that uses iov_iter_extract_pages().
> 
>  block/bio.c               | 2 +-
>  block/blk-map.c           | 1 +
>  fs/direct-io.c            | 2 ++
>  fs/iomap/direct-io.c      | 1 -
>  include/linux/bio.h       | 2 +-
>  include/linux/blk_types.h | 2 +-
>  6 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 043944fd46eb..8516adeaea26 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1191,7 +1191,6 @@ void bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)
>  	bio->bi_io_vec = (struct bio_vec *)iter->bvec;
>  	bio->bi_iter.bi_bvec_done = iter->iov_offset;
>  	bio->bi_iter.bi_size = size;
> -	bio_set_flag(bio, BIO_NO_PAGE_REF);
>  	bio_set_flag(bio, BIO_CLONED);
>  }
>  
> @@ -1336,6 +1335,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  		return 0;
>  	}
>  
> +	bio_set_flag(bio, BIO_PAGE_REFFED);
>  	do {
>  		ret = __bio_iov_iter_get_pages(bio, iter);
>  	} while (!ret && iov_iter_count(iter) && !bio_full(bio, 0));
> diff --git a/block/blk-map.c b/block/blk-map.c
> index 04c55f1c492e..33d9f6e89ba6 100644
> --- a/block/blk-map.c
> +++ b/block/blk-map.c
> @@ -282,6 +282,7 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
>  	if (blk_queue_pci_p2pdma(rq->q))
>  		extraction_flags |= ITER_ALLOW_P2PDMA;
>  
> +	bio_set_flag(bio, BIO_PAGE_REFFED);
>  	while (iov_iter_count(iter)) {
>  		struct page **pages, *stack_pages[UIO_FASTIOV];
>  		ssize_t bytes;
> diff --git a/fs/direct-io.c b/fs/direct-io.c
> index 0b380bb8a81e..ad20f3428bab 100644
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -402,6 +402,8 @@ dio_bio_alloc(struct dio *dio, struct dio_submit *sdio,
>  		bio->bi_end_io = dio_bio_end_aio;
>  	else
>  		bio->bi_end_io = dio_bio_end_io;
> +	/* for now require references for all pages */
> +	bio_set_flag(bio, BIO_PAGE_REFFED);
>  	sdio->bio = bio;
>  	sdio->logical_offset_in_bio = sdio->cur_page_fs_offset;
>  }
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 66a9f10e3207..08873f0627dd 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -203,7 +203,6 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
>  	bio->bi_private = dio;
>  	bio->bi_end_io = iomap_dio_bio_end_io;
>  
> -	bio_set_flag(bio, BIO_NO_PAGE_REF);
>  	__bio_add_page(bio, page, len, 0);
>  	iomap_dio_submit_bio(iter, dio, bio, pos);
>  }
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 7f53be035cf0..0922729acd26 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -488,7 +488,7 @@ void zero_fill_bio(struct bio *bio);
>  
>  static inline void bio_release_pages(struct bio *bio, bool mark_dirty)
>  {
> -	if (!bio_flagged(bio, BIO_NO_PAGE_REF))
> +	if (bio_flagged(bio, BIO_PAGE_REFFED))
>  		__bio_release_pages(bio, mark_dirty);
>  }
>  
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 740afe80f297..dfd2c2cb909d 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -323,7 +323,7 @@ struct bio {
>   * bio flags
>   */
>  enum {
> -	BIO_NO_PAGE_REF,	/* don't put release vec pages */
> +	BIO_PAGE_REFFED,	/* put pages in bio_release_pages() */
>  	BIO_CLONED,		/* doesn't own data */
>  	BIO_BOUNCED,		/* bio is a bounce bio */
>  	BIO_QUIET,		/* Make BIO Quiet */
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
