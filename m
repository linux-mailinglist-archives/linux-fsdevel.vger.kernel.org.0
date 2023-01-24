Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22D4679BCB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 15:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbjAXO23 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 09:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbjAXO22 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:28:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B88445BCF
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 06:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674570453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZyAxobF1qNVquK9cF8yBjkUFIH4Q3hiUITFtn4KIDno=;
        b=QPA+dw+ekTmjXMrwZVBTZtpb2HHu/kyanInRPFqyPM9GzteWfLnmM1SmF8NXijiqPzAB6I
        ZOVKaZiuILS6mM5Ucwt4tOZoA74y0DpdnG+X/DoXqWQUS2mCgs72Ycos7UYJP31uN6y8Wb
        AOjDZqyIcary6cuTudPCrCd3I6WIQOc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-119-79lWI_SHPLmRIO8mIwwJKQ-1; Tue, 24 Jan 2023 09:27:32 -0500
X-MC-Unique: 79lWI_SHPLmRIO8mIwwJKQ-1
Received: by mail-wm1-f69.google.com with SMTP id m10-20020a05600c3b0a00b003dafe7451deso9272059wms.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 06:27:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZyAxobF1qNVquK9cF8yBjkUFIH4Q3hiUITFtn4KIDno=;
        b=yanfILtim7mFlnm578NcOD63UMXAScQfNKcHavt2P5nfQdeADFGcwzL7vmgRirFClS
         Hq9iXBLFyfbhc+qluAgJ1v+wKUfoTV+nH4TnQmF6IZY8jA48TcnBJXCDxNbtgBlzt9fg
         EY0sOwEmsVvs2YQRYA/sq/IPpWSzB7VDrt2UatdZjW8rEY19aI/Qv3oPsfRrq054L6T/
         dNp9z/DYxa046MjE3rB8Cl0skzdl+PutNoaZFn6Rz1BCrgt2WkARnbqTIUceN38JhAk/
         QBuUJZ4+HAJ5/wpLEsDwRCI7rEJiS8pCSsacU5z10mT2paKmqPaznPBKh4Gu0MIvhvCJ
         q2Tg==
X-Gm-Message-State: AO0yUKU2RgGqPRYj57nSq94bhCm4myjJJIOGbjy9hEEzDr40uf6L1mZT
        OBLg3/h3ovZxmzRwdhFbXBn2jlVn32Rx8iLqbiPZT1L58rszftjZutSAG97oz9evkkyclUYun7h
        lMhXpxLiIEyzHaSyHbZmxtF0fIw==
X-Received: by 2002:adf:fe41:0:b0:2bf:b193:a7da with SMTP id m1-20020adffe41000000b002bfb193a7damr1733729wrs.62.1674570451411;
        Tue, 24 Jan 2023 06:27:31 -0800 (PST)
X-Google-Smtp-Source: AK7set/EicOHCs/Yau1zOAae6LMmUT+31XWXn0cg9ISoVZqXbXS3/76TT+KTgqLPzXmxMOy4yagRUA==
X-Received: by 2002:adf:fe41:0:b0:2bf:b193:a7da with SMTP id m1-20020adffe41000000b002bfb193a7damr1733712wrs.62.1674570451100;
        Tue, 24 Jan 2023 06:27:31 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:9d00:9303:90ce:6dcb:2bc9? (p200300cbc7079d00930390ce6dcb2bc9.dip0.t-ipconnect.de. [2003:cb:c707:9d00:9303:90ce:6dcb:2bc9])
        by smtp.gmail.com with ESMTPSA id h17-20020a5d4311000000b002bdfcd8c77csm1964874wrq.101.2023.01.24.06.27.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 06:27:30 -0800 (PST)
Message-ID: <1b1eb3d8-c6b4-b264-1baa-1b3eb088173d@redhat.com>
Date:   Tue, 24 Jan 2023 15:27:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v8 02/10] iov_iter: Add a function to extract a page list
 from an iterator
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org
References: <20230123173007.325544-1-dhowells@redhat.com>
 <20230123173007.325544-3-dhowells@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230123173007.325544-3-dhowells@redhat.com>
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

On 23.01.23 18:29, David Howells wrote:
> Add a function, iov_iter_extract_pages(), to extract a list of pages from
> an iterator.  The pages may be returned with a pin added or nothing,
> depending on the type of iterator.
> 
> Add a second function, iov_iter_extract_mode(), to determine how the
> cleanup should be done.
> 
> There are two cases:
> 
>   (1) ITER_IOVEC or ITER_UBUF iterator.
> 
>       Extracted pages will have pins (FOLL_PIN) obtained on them so that a
>       concurrent fork() will forcibly copy the page so that DMA is done
>       to/from the parent's buffer and is unavailable to/unaffected by the
>       child process.
> 
>       iov_iter_extract_mode() will return FOLL_PIN for this case.  The
>       caller should use something like folio_put_unpin() to dispose of the
>       page.
> 
>   (2) Any other sort of iterator.
> 
>       No refs or pins are obtained on the page, the assumption is made that
>       the caller will manage page retention.
> 
>       iov_iter_extract_mode() will return 0.  The pages don't need
>       additional disposal.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: Christoph Hellwig <hch@lst.de>
> cc: John Hubbard <jhubbard@nvidia.com>
> cc: David Hildenbrand <david@redhat.com>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> ---
> 
> Notes:
>      ver #8)
>       - It seems that all DIO is supposed to be done under FOLL_PIN now, and not
>         FOLL_GET, so switch to only using pin_user_pages() for user-backed
>         iters.
>       - Wrap an argument in brackets in the iov_iter_extract_mode() macro.
>       - Drop the extract_flags argument to iov_iter_extract_mode() for now
>         [hch].
>      
>      ver #7)
>       - Switch to passing in iter-specific flags rather than FOLL_* flags.
>       - Drop the direction flags for now.
>       - Use ITER_ALLOW_P2PDMA to request FOLL_PCI_P2PDMA.
>       - Disallow use of ITER_ALLOW_P2PDMA with non-user-backed iter.
>       - Add support for extraction from KVEC-type iters.
>       - Use iov_iter_advance() rather than open-coding it.
>       - Make BVEC- and KVEC-type skip over initial empty vectors.
>      
>      ver #6)
>       - Add back the function to indicate the cleanup mode.
>       - Drop the cleanup_mode return arg to iov_iter_extract_pages().
>       - Pass FOLL_SOURCE/DEST_BUF in gup_flags.  Check this against the iter
>         data_source.
>      
>      ver #4)
>       - Use ITER_SOURCE/DEST instead of WRITE/READ.
>       - Allow additional FOLL_* flags, such as FOLL_PCI_P2PDMA to be passed in.
>      
>      ver #3)
>       - Switch to using EXPORT_SYMBOL_GPL to prevent indirect 3rd-party access
>         to get/pin_user_pages_fast()[1].
> 
>   include/linux/uio.h |  22 +++
>   lib/iov_iter.c      | 320 ++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 342 insertions(+)
> 
> diff --git a/include/linux/uio.h b/include/linux/uio.h
> index 46d5080314c6..a8165335f8da 100644
> --- a/include/linux/uio.h
> +++ b/include/linux/uio.h
> @@ -363,4 +363,26 @@ static inline void iov_iter_ubuf(struct iov_iter *i, unsigned int direction,
>   /* Flags for iov_iter_get/extract_pages*() */
>   #define ITER_ALLOW_P2PDMA	0x01	/* Allow P2PDMA on the extracted pages */
>   
> +ssize_t iov_iter_extract_pages(struct iov_iter *i, struct page ***pages,
> +			       size_t maxsize, unsigned int maxpages,
> +			       unsigned int extract_flags, size_t *offset0);
> +
> +/**
> + * iov_iter_extract_mode - Indicate how pages from the iterator will be retained
> + * @iter: The iterator
> + *
> + * Examine the iterator and indicate by returning FOLL_PIN or 0 as to how, if
> + * at all, pages extracted from the iterator will be retained by the extraction
> + * function.
> + *
> + * FOLL_PIN indicates that the pages will have a pin placed in them that the
> + * caller must unpin.  This is must be done for DMA/async DIO to force fork()
> + * to forcibly copy a page for the child (the parent must retain the original
> + * page).
> + *
> + * 0 indicates that no measures are taken and that it's up to the caller to
> + * retain the pages.
> + */
> +#define iov_iter_extract_mode(iter) (user_backed_iter(iter) ? FOLL_PIN : 0)
> +

Does it make sense to move that to the patch where it is needed? (do we 
need it at all anymore?)

-- 
Thanks,

David / dhildenb

