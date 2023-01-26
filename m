Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2E867C721
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 10:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236838AbjAZJ0V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 04:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236814AbjAZJ0U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 04:26:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211BDE8
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 01:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674725133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HJxMbaMUqhqeVp88riEJqy2L3rUVZ+LeaPKhJKipiFU=;
        b=jQhXjKPYRzRRelPTqx2p4d1tX+3JiMHJE7q3gwtwrPZml76im3TfbV2LDzE+GFVqSeB7j5
        hRuZgMINhmoT+maX5Uzgvho16mSH6fhndNU5TAIb+U8/mR0fq/2l85vSAz5FfS2VGnfE5J
        wtIqmwS2el8myPTSjEnw23FxaARFUb8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-220-prh3jVZSPeGV7d0Q0YIZ0g-1; Thu, 26 Jan 2023 04:25:31 -0500
X-MC-Unique: prh3jVZSPeGV7d0Q0YIZ0g-1
Received: by mail-wm1-f70.google.com with SMTP id 9-20020a05600c228900b003daf72fc827so742107wmf.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 01:25:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HJxMbaMUqhqeVp88riEJqy2L3rUVZ+LeaPKhJKipiFU=;
        b=5QZFTfkT6hWkG2Au1KCUMI4NTucCgLEckuZJeQjXV9zUqZWbkCejUVOOrXvtLA6/Yo
         /3js2ucW25nkfmq6I5ND4XMyD/JPSRm8ZtQazbVh84bIN7UUGo9I0pC9ah0vthaQUlA9
         71U3+VEWj8GAusMdf7eq6WbN+rorXQXUJBw0MTq03mCd3mCqCNwK9DffsqASJx6rCxTj
         OsRGy6uLgy9StSPt/X6gSTdrLawVF9BNzGgygYWSztzPbpcN52rOjbiek7jQuX5LsplU
         VX9JWcENRkqoit3hYDNzFiiMUbpBC/HRh/32G8UleGNOuHblwbkjV7kIvvCkVg10F2oJ
         GexA==
X-Gm-Message-State: AFqh2kpi9omCypA2RANAZdGYFEMfiHjuIYzH89JLxsLLrMS3qjrn0STc
        peMjjktRt0jpWBHbswDsED1ZdMu5ssFfq9EfNOt+p1RKbaMrN6MqS2aCdWprqi4378Z9nRizpAL
        t1E53BtGwDJDdkgcpqTzW6OsROA==
X-Received: by 2002:a05:600c:202:b0:3da:f80d:7230 with SMTP id 2-20020a05600c020200b003daf80d7230mr34631787wmi.8.1674725130560;
        Thu, 26 Jan 2023 01:25:30 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsF+CPq/pYLt+G2uzsh9Vpxfez30amaf1R+Ru5j+9YNhRLrWVC7in0V4m/WVq1SfZ43j3OaoQ==
X-Received: by 2002:a05:600c:202:b0:3da:f80d:7230 with SMTP id 2-20020a05600c020200b003daf80d7230mr34631766wmi.8.1674725130238;
        Thu, 26 Jan 2023 01:25:30 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id x12-20020a05600c2d0c00b003db15b1fb3csm902990wmf.13.2023.01.26.01.25.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 01:25:29 -0800 (PST)
Message-ID: <af0e448a-9559-32c0-cc59-10b159459495@redhat.com>
Date:   Thu, 26 Jan 2023 10:25:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v10 1/8] iov_iter: Define flags to qualify page
 extraction.
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
References: <20230125210657.2335748-1-dhowells@redhat.com>
 <20230125210657.2335748-2-dhowells@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230125210657.2335748-2-dhowells@redhat.com>
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

On 25.01.23 22:06, David Howells wrote:
> Define flags to qualify page extraction to pass into iov_iter_*_pages*()
> rather than passing in FOLL_* flags.
> 
> For now only a flag to allow peer-to-peer DMA is supported.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Logan Gunthorpe <logang@deltatee.com>
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-block@vger.kernel.org
> ---
> 
[...]

> +++ b/include/linux/uio.h
> @@ -252,12 +252,12 @@ void iov_iter_xarray(struct iov_iter *i, unsigned int direction, struct xarray *
>   		     loff_t start, size_t count);
>   ssize_t iov_iter_get_pages(struct iov_iter *i, struct page **pages,
>   		size_t maxsize, unsigned maxpages, size_t *start,
> -		unsigned gup_flags);
> +		unsigned extraction_flags);
>   ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
>   			size_t maxsize, unsigned maxpages, size_t *start);
>   ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
>   		struct page ***pages, size_t maxsize, size_t *start,
> -		unsigned gup_flags);
> +		unsigned extraction_flags);
>   ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i, struct page ***pages,
>   			size_t maxsize, size_t *start);
>   int iov_iter_npages(const struct iov_iter *i, int maxpages);
> @@ -360,4 +360,7 @@ static inline void iov_iter_ubuf(struct iov_iter *i, unsigned int direction,
>   	};
>   }
>   
> +/* Flags for iov_iter_get/extract_pages*() */
> +#define ITER_ALLOW_P2PDMA	0x01	/* Allow P2PDMA on the extracted pages */

Just a note that the usage of new __bitwise types instead of "unsigned" 
is encouraged for flags.

See rmap_t in include/linux/rmap.h as an example.

Apart from that LGTM.

-- 
Thanks,

David / dhildenb

