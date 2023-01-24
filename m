Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F2A679BF1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 15:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbjAXOdL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 09:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbjAXOdK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:33:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869C512879
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 06:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674570742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ssi9a0fXxukUDI5CAe/hc0P8ZWaxCEQMPLMC242trI4=;
        b=Nw3ykDVhrrJwMjOkxQba3LpXpg4gE5A8D2jcgh1FPlnwYoJVht3NamJ8TsAVV6K0Q8TsX9
        5BzJxtahJesTsWDf2w4EwPr5AO/17BS9w6HIUAN3A18brDs5bV2W8vfdplCbWb2IRDoe5m
        iFJcKdknwFhIMInAOhrONcHQQAH83kc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-408-g5vjHFiXMbGhLrtDsu9Amg-1; Tue, 24 Jan 2023 09:32:21 -0500
X-MC-Unique: g5vjHFiXMbGhLrtDsu9Amg-1
Received: by mail-wm1-f71.google.com with SMTP id az37-20020a05600c602500b003da50af44b3so9288161wmb.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 06:32:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ssi9a0fXxukUDI5CAe/hc0P8ZWaxCEQMPLMC242trI4=;
        b=PG/Vjd4fa2whrTF2NsQtopGr4UDQF/NXSMhStVNyHFLtHHFyZ8dfwa0aGveQYzJ+24
         VeixraKEko/gUZLrfBs6onJg+u5Z/ptgukBD6jimeDmErHO3o2jxY/F5Ipzatorsf6Ei
         3hrdd8jP2gZSYGpCrDAAeeuRt1FmLrZmdtlZbYAwTACxBXRxDKyWbpvi4YZ8Gh7PZpxE
         KFkuGiVhoLPuiMYCQULlhh/IF9hZMYboVEWss7sBVdvhx7DWeXAvwZg6DK6hC2DGj8gw
         W40P6pQ82Q33btJA/xyimLRh2w6DeJvn3JfYOZ8IZWrfaydJ890vxbiiwgN5LPvlkIVa
         iCOw==
X-Gm-Message-State: AFqh2kofpUF2MKjm0Ga83mT8kNROGB8ia4n4BuszwDO1Q0O7wOjOoeYm
        PdlgvoTFZteqHdE7mrizSxpHvNCC+z/e9bEnpHY3reBN3p8FmGPL6JaQyiB8P4oivBonDh6qifK
        OZbUWH06haIrc2rxIUqlHsdWNLQ==
X-Received: by 2002:a05:600c:d2:b0:3da:f475:6480 with SMTP id u18-20020a05600c00d200b003daf4756480mr28402435wmm.7.1674570739982;
        Tue, 24 Jan 2023 06:32:19 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtRWlNcvst1DEvQuLfVrVHZBU0A4XvHlCjyUiRVH7rVJzvE+jdvk8iKpcXJsytHRXeuqnR1Ag==
X-Received: by 2002:a05:600c:d2:b0:3da:f475:6480 with SMTP id u18-20020a05600c00d200b003daf4756480mr28402409wmm.7.1674570739663;
        Tue, 24 Jan 2023 06:32:19 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:9d00:9303:90ce:6dcb:2bc9? (p200300cbc7079d00930390ce6dcb2bc9.dip0.t-ipconnect.de. [2003:cb:c707:9d00:9303:90ce:6dcb:2bc9])
        by smtp.gmail.com with ESMTPSA id b5-20020a05600c150500b003cffd3c3d6csm2064367wmg.12.2023.01.24.06.32.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 06:32:19 -0800 (PST)
Message-ID: <2431ffa0-4a37-56a2-17fa-74a5f681bcb8@redhat.com>
Date:   Tue, 24 Jan 2023 15:32:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v8 07/10] block: Switch to pinning pages.
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20230123173007.325544-1-dhowells@redhat.com>
 <20230123173007.325544-8-dhowells@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230123173007.325544-8-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 23.01.23 18:30, David Howells wrote:
> Add BIO_PAGE_PINNED to indicate that the pages in a bio are pinned
> (FOLL_PIN) and that the pin will need removing.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Jan Kara <jack@suse.cz>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: Logan Gunthorpe <logang@deltatee.com>
> cc: linux-block@vger.kernel.org
> ---
> 
> Notes:
>      ver #8)
>       - Move the infrastructure to clean up pinned pages to this patch [hch].
>       - Put BIO_PAGE_PINNED before BIO_PAGE_REFFED as the latter should
>         probably be removed at some point.  FOLL_PIN can then be renumbered
>         first.
> 
>   block/bio.c               |  7 ++++---
>   block/blk.h               | 28 ++++++++++++++++++++++++++++
>   include/linux/bio.h       |  3 ++-
>   include/linux/blk_types.h |  1 +
>   4 files changed, 35 insertions(+), 4 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 40c2b01906da..6f98bcfc0c92 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1170,13 +1170,14 @@ bool bio_add_folio(struct bio *bio, struct folio *folio, size_t len,
>   
>   void __bio_release_pages(struct bio *bio, bool mark_dirty)
>   {
> +	unsigned int gup_flags = bio_to_gup_flags(bio);
>   	struct bvec_iter_all iter_all;
>   	struct bio_vec *bvec;
>   
>   	bio_for_each_segment_all(bvec, bio, iter_all) {
>   		if (mark_dirty && !PageCompound(bvec->bv_page))
>   			set_page_dirty_lock(bvec->bv_page);
> -		put_page(bvec->bv_page);
> +		page_put_unpin(bvec->bv_page, gup_flags);
>   	}
>   }
>   EXPORT_SYMBOL_GPL(__bio_release_pages);
> @@ -1496,8 +1497,8 @@ void bio_set_pages_dirty(struct bio *bio)
>    * the BIO and re-dirty the pages in process context.
>    *
>    * It is expected that bio_check_pages_dirty() will wholly own the BIO from
> - * here on.  It will run one put_page() against each page and will run one
> - * bio_put() against the BIO.
> + * here on.  It will run one page_put_unpin() against each page and will run
> + * one bio_put() against the BIO.
>    */
>   
>   static void bio_dirty_fn(struct work_struct *work);
> diff --git a/block/blk.h b/block/blk.h
> index 4c3b3325219a..294044d696e0 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -425,6 +425,34 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
>   		struct page *page, unsigned int len, unsigned int offset,
>   		unsigned int max_sectors, bool *same_page);
>   
> +/*
> + * Set the cleanup mode for a bio from an iterator and the extraction flags.
> + */
> +static inline void bio_set_cleanup_mode(struct bio *bio, struct iov_iter *iter)
> +{
> +	unsigned int cleanup_mode = iov_iter_extract_mode(iter);
> +
> +	if (cleanup_mode & FOLL_GET)
> +		bio_set_flag(bio, BIO_PAGE_REFFED);
> +	if (cleanup_mode & FOLL_PIN)
> +		bio_set_flag(bio, BIO_PAGE_PINNED);

Can FOLL_GET ever happen?

IOW, can't this even be

if (user_backed_iter(iter))
	bio_set_flag(bio, BIO_PAGE_PINNED);

-- 
Thanks,

David / dhildenb

