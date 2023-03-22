Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F796C475C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 11:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjCVKS3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 06:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjCVKS2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 06:18:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA79A5DCB0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 03:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679480255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o1+6B+/0H/fu85Bj7QPMte1NsMQ4eZHLaHKZd7KoZx0=;
        b=dpP3Wl4ZwwwPCM5GVWyukm/KnMkcE6kR7C1/+QXHjTm5ZqZKStT//qfPGOKh89v5jVhemu
        zwv/3nxkHyDq+qdKTlBd1RY+C5jq3tNnxKUye9/E6rguYzSUd6d6nZAqY72XWB5EN5LCum
        7IMzG/nfw+63xkJfMwyQ5feMVZliP5E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-6nORCHWmP_ua3bSCsrLsXw-1; Wed, 22 Mar 2023 06:17:31 -0400
X-MC-Unique: 6nORCHWmP_ua3bSCsrLsXw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CED58185A790;
        Wed, 22 Mar 2023 10:17:30 +0000 (UTC)
Received: from localhost (ovpn-13-195.pek2.redhat.com [10.72.13.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9CA41140EBF4;
        Wed, 22 Mar 2023 10:17:29 +0000 (UTC)
Date:   Wed, 22 Mar 2023 18:17:25 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v4 3/4] iov_iter: add copy_page_to_iter_atomic()
Message-ID: <ZBrVtcqATRybF/hW@MiWiFi-R3L-srv>
References: <cover.1679431886.git.lstoakes@gmail.com>
 <31482908634cbb68adafedb65f0b21888c194a1b.1679431886.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31482908634cbb68adafedb65f0b21888c194a1b.1679431886.git.lstoakes@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03/21/23 at 08:54pm, Lorenzo Stoakes wrote:
> Provide an atomic context equivalent for copy_page_to_iter(). This eschews
> the might_fault() check copies memory in the same way that
> copy_page_from_iter_atomic() does.
> 
> This functions assumes a non-compound page, however this mimics the
> existing behaviour of copy_page_from_iter_atomic(). I am keeping the
> behaviour consistent between the two, deferring any such change to an
> explicit folio-fication effort.
> 
> This is being added in order that an iteratable form of vread() can be
> implemented with known prefaulted pages to avoid the need for mutex
> locking.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  include/linux/uio.h |  2 ++
>  lib/iov_iter.c      | 28 ++++++++++++++++++++++++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/include/linux/uio.h b/include/linux/uio.h
> index 27e3fd942960..fab07103090f 100644
> --- a/include/linux/uio.h
> +++ b/include/linux/uio.h
> @@ -154,6 +154,8 @@ static inline struct iovec iov_iter_iovec(const struct iov_iter *iter)
>  
>  size_t copy_page_from_iter_atomic(struct page *page, unsigned offset,
>  				  size_t bytes, struct iov_iter *i);
> +size_t copy_page_to_iter_atomic(struct page *page, unsigned offset,
> +				size_t bytes, struct iov_iter *i);
>  void iov_iter_advance(struct iov_iter *i, size_t bytes);
>  void iov_iter_revert(struct iov_iter *i, size_t bytes);
>  size_t fault_in_iov_iter_readable(const struct iov_iter *i, size_t bytes);
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 274014e4eafe..48ca1c5dfc04 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -821,6 +821,34 @@ size_t copy_page_from_iter_atomic(struct page *page, unsigned offset, size_t byt
>  }
>  EXPORT_SYMBOL(copy_page_from_iter_atomic);
>  
> +size_t copy_page_to_iter_atomic(struct page *page, unsigned offset, size_t bytes,
> +				struct iov_iter *i)
> +{
> +	char *kaddr = kmap_local_page(page);

I am a little confused about the name of this new function. In its
conterpart, copy_page_from_iter_atomic(), kmap_atomic()/kunmpa_atomic()
are used. With them, if CONFIG_HIGHMEM=n, it's like below:

static inline void *kmap_atomic(struct page *page)
{
        if (IS_ENABLED(CONFIG_PREEMPT_RT))
                migrate_disable();
        else
                preempt_disable();
        pagefault_disable();
        return page_address(page);
}

But kmap_local_page() is only having page_address(), the code block
between kmap_local_page() and kunmap_local() is also atomic, it's a
little messy in my mind.

static inline void *kmap_local_page(struct page *page)
{
        return page_address(page);
}

> +	char *p = kaddr + offset;
> +	size_t copied = 0;
> +
> +	if (!page_copy_sane(page, offset, bytes) ||
> +	    WARN_ON_ONCE(i->data_source))
> +		goto out;
> +
> +	if (unlikely(iov_iter_is_pipe(i))) {
> +		copied = copy_page_to_iter_pipe(page, offset, bytes, i);
> +		goto out;
> +	}
> +
> +	iterate_and_advance(i, bytes, base, len, off,
> +		copyout(base, p + off, len),
> +		memcpy(base, p + off, len)
> +	)
> +	copied = bytes;
> +
> +out:
> +	kunmap_local(kaddr);
> +	return copied;
> +}
> +EXPORT_SYMBOL(copy_page_to_iter_atomic);
> +
>  static void pipe_advance(struct iov_iter *i, size_t size)
>  {
>  	struct pipe_inode_info *pipe = i->pipe;
> -- 
> 2.39.2
> 

