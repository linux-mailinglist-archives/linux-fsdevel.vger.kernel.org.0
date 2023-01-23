Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFDA2677A26
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 12:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjAWL3f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 06:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjAWL3d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 06:29:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208D7234CE
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jan 2023 03:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674473324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZX5Hy9BPLoGgTqpi/nKPSetncHjmIrp5YM4+B525Z+s=;
        b=I2oRuOmA0pxj6DvLOef8g+1jhSG/wQeUpNcV4+kKhDDnr1MnmbNpGQHb0yB/HvE/K+YQYS
        byQg4lYZca0kgEPysl/kWl6SQ3dkzRKvrne+3MWthLzDEFKURYMpF2IMuSQV9F4yVkieTV
        uwBg6jtKUe/rnkpJg8HV8H2gmW6abs8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-410-iWxzCIpWOOCArcJ_Mu396g-1; Mon, 23 Jan 2023 06:28:43 -0500
X-MC-Unique: iWxzCIpWOOCArcJ_Mu396g-1
Received: by mail-wr1-f71.google.com with SMTP id o15-20020a5d684f000000b002be540246e1so1352280wrw.22
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jan 2023 03:28:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZX5Hy9BPLoGgTqpi/nKPSetncHjmIrp5YM4+B525Z+s=;
        b=4jlkwd6Kbs2XfQQX9DzUEs/7F7TAPKzRQgYPwrtJNakj+vgOHTVAB/jLX1ymntm9b5
         FxTv4n3ecezZfiygfiO/gkldPQlQDi90cVZK0JhVNtVVzBizvWXRaa3F8er0GkEGjoLM
         brwkgv40BGJH1/1zmMwkMSJvDtVk6RJ/Rs5Yx/sHf5U0iJzW15g6bdQ/vgYLT7cFUoT9
         x55omdjOdykHNS99n77tNhM6bRQvZ63SMGBK3Fn2489P8GK9hkhYL92/8z5jbfehhAd8
         Kqty4qhM0/FHO4OaH7INeRT3WXk3e0KuM0c6Z6zcD5ZyxMe49GkJoVCwpwCdYxZF3JGP
         J+xQ==
X-Gm-Message-State: AFqh2krXdPLvgJDuBLE75jFf49TDZMpRj7Zc52RkIF6YI2USDYWdrVfl
        5l/IBqW1n02pzjaq6VV/QZR74nruewZXOoQaWCRc3IwQjc6nRc8SuE30Qkx9jJCF+VHaM0bnJiV
        QSp3LSRKJzuR8QLf/Fip7Dw3rTw==
X-Received: by 2002:a5d:4388:0:b0:293:1868:3a15 with SMTP id i8-20020a5d4388000000b0029318683a15mr22903781wrq.34.1674473321827;
        Mon, 23 Jan 2023 03:28:41 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvsZvlYF/jZLofTOnAYPcXTpB66JeK+sIp1VC7T9xXsAa4KWrWUh7F1iBjJxzgN6kKKZJ/VjA==
X-Received: by 2002:a5d:4388:0:b0:293:1868:3a15 with SMTP id i8-20020a5d4388000000b0029318683a15mr22903763wrq.34.1674473321523;
        Mon, 23 Jan 2023 03:28:41 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:1100:65a0:c03a:142a:f914? (p200300cbc704110065a0c03a142af914.dip0.t-ipconnect.de. [2003:cb:c704:1100:65a0:c03a:142a:f914])
        by smtp.gmail.com with ESMTPSA id q15-20020a5d574f000000b00272c0767b4asm4103815wrw.109.2023.01.23.03.28.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 03:28:41 -0800 (PST)
Message-ID: <246ba813-698b-8696-7f4d-400034a3380b@redhat.com>
Date:   Mon, 23 Jan 2023 12:28:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v7 2/8] iov_iter: Add a function to extract a page list
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
References: <20230120175556.3556978-1-dhowells@redhat.com>
 <20230120175556.3556978-3-dhowells@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230120175556.3556978-3-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 20.01.23 18:55, David Howells wrote:
> Add a function, iov_iter_extract_pages(), to extract a list of pages from
> an iterator.  The pages may be returned with a reference added or a pin
> added or neither, depending on the type of iterator and the direction of
> transfer.  The caller must pass FOLL_READ_FROM_MEM or FOLL_WRITE_TO_MEM
> as part of gup_flags to indicate how the iterator contents are to be used.
> 
> Add a second function, iov_iter_extract_mode(), to determine how the
> cleanup should be done.
> 
> There are three cases:
> 
>   (1) Transfer *into* an ITER_IOVEC or ITER_UBUF iterator.
> 
>       Extracted pages will have pins obtained on them (but not references)
>       so that fork() doesn't CoW the pages incorrectly whilst the I/O is in
>       progress.
> 
>       iov_iter_extract_mode() will return FOLL_PIN for this case.  The
>       caller should use something like unpin_user_page() to dispose of the
>       page.
> 
>   (2) Transfer is *out of* an ITER_IOVEC or ITER_UBUF iterator.
> 
>       Extracted pages will have references obtained on them, but not pins.
> 
>       iov_iter_extract_mode() will return FOLL_GET.  The caller should use
>       something like put_page() for page disposal.
> 
>   (3) Any other sort of iterator.
> 
>       No refs or pins are obtained on the page, the assumption is made that
>       the caller will manage page retention.  ITER_ALLOW_P2PDMA is not
>       permitted.
> 
>       iov_iter_extract_mode() will return 0.  The pages don't need
>       additional disposal.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: Christoph Hellwig <hch@lst.de>
> cc: John Hubbard <jhubbard@nvidia.com>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> Link: https://lore.kernel.org/r/166920903885.1461876.692029808682876184.stgit@warthog.procyon.org.uk/ # v2
> Link: https://lore.kernel.org/r/166997421646.9475.14837976344157464997.stgit@warthog.procyon.org.uk/ # v3
> Link: https://lore.kernel.org/r/167305163883.1521586.10777155475378874823.stgit@warthog.procyon.org.uk/ # v4
> Link: https://lore.kernel.org/r/167344728530.2425628.9613910866466387722.stgit@warthog.procyon.org.uk/ # v5
> Link: https://lore.kernel.org/r/167391053207.2311931.16398133457201442907.stgit@warthog.procyon.org.uk/ # v6
> ---
> 
> Notes:
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
>   include/linux/uio.h |  28 +++
>   lib/iov_iter.c      | 424 ++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 452 insertions(+)
> 
> diff --git a/include/linux/uio.h b/include/linux/uio.h
> index 46d5080314c6..a4233049ab7a 100644
> --- a/include/linux/uio.h
> +++ b/include/linux/uio.h
> @@ -363,4 +363,32 @@ static inline void iov_iter_ubuf(struct iov_iter *i, unsigned int direction,
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
> + * @extract_flags: How the iterator is to be used
> + *
> + * Examine the iterator and @extract_flags and indicate by returning FOLL_PIN,
> + * FOLL_GET or 0 as to how, if at all, pages extracted from the iterator will
> + * be retained by the extraction function.
> + *
> + * FOLL_GET indicates that the pages will have a reference taken on them that
> + * the caller must put.  This can be done for DMA/async DIO write from a page.
> + *
> + * FOLL_PIN indicates that the pages will have a pin placed in them that the
> + * caller must unpin.  This is must be done for DMA/async DIO read to a page to
> + * avoid CoW problems in fork.
> + *
> + * 0 indicates that no measures are taken and that it's up to the caller to
> + * retain the pages.
> + */
> +#define iov_iter_extract_mode(iter, extract_flags) \
> +	(user_backed_iter(iter) ?				\
> +	 (iter->data_source == ITER_SOURCE) ?			\
> +	 FOLL_GET : FOLL_PIN : 0)
> +
>

How does this work align with the goal of no longer using FOLL_GET for 
O_DIRECT? We should get rid of any FOLL_GET usage for accessing page 
content.

@John, any comments?

-- 
Thanks,

David / dhildenb

