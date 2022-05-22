Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4820B530527
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 May 2022 20:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbiEVS16 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 May 2022 14:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350219AbiEVS0B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 May 2022 14:26:01 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8C6EB1
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 11:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7mfcSc6El5emS1pWXoZJ7ZRKvgTUNMA64rxeps25vqc=; b=FoVkttD1HTPpH+e8HsKv8t1c87
        QjsLP+0q4F4da/vOj6z8Zos1fZF5gwtPycxntYt/LcAYIi+KlBR8G4FSD/JF/WUVGF3Fqj6gdxoHT
        wx7cV63Ib+SXDkpuePOkzSUeJ7r+UXyuUsEGkTA4MGj8SD9UbQZLBhdIeSm6nSNMYyKH96pyclUhN
        zjh/WEqtoswZRzRXsIoyoAkvfnvmSMjFPG9QLu+4yTEQaN+mufAguaDNrxfD8m0AeyMxhZo57L74q
        tgut0nLLf5LwK7Uf9eVtPkvF5n7AP81DyJSLl3yA2vHRWBwAZhDkc2iD8UQAf1E6SLV/ygQwT3sat
        5fpKKWWw==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nsqH5-00HGAy-I3; Sun, 22 May 2022 18:25:55 +0000
Date:   Sun, 22 May 2022 18:25:55 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Message-ID: <YoqAM1RnN/er6GDP@zeniv-ca.linux.org.uk>
References: <YooPLyv578I029ij@casper.infradead.org>
 <YooSEKClbDemxZVy@zeniv-ca.linux.org.uk>
 <Yoobb6GZPbNe7s0/@casper.infradead.org>
 <20220522114540.GA20469@lst.de>
 <e563d92f-7236-fbde-14ee-1010740a0983@kernel.dk>
 <YooxLS8Lrt6ErwIM@zeniv-ca.linux.org.uk>
 <96aa35fc-3ff7-a3a1-05b5-9fae5c9c1067@kernel.dk>
 <Yoo1q1+ZRrjBP2y3@zeniv-ca.linux.org.uk>
 <e2bb980b-42e8-27dc-cb6b-51dfb90d7e0a@kernel.dk>
 <7abc2e36-f2f3-e89c-f549-9edd6633b4a1@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7abc2e36-f2f3-e89c-f549-9edd6633b4a1@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 22, 2022 at 12:06:24PM -0600, Jens Axboe wrote:
>  	union {
> +		size_t uaddr_len;

WTF for?

> +#define iterate_uaddr(i, n, base, len, off, STEP) {		\
> +	size_t off = 0;						\
> +	size_t skip = i->iov_offset;				\
> +	len = min(n, i->uaddr_len - skip);			\

How would you ever get offset past the size?  Note that we do
keep track of amount of space left...

> -	if (iter_is_iovec(i))
> +	if (!i->nofault)
>  		might_fault();

Nope.  Sorry, but by default nofault will be false for *all* types.
It's not "I won't fault", it's "pass FOLL_NOFAULT to g_u_p".

> -	if (iov_iter_is_bvec(i) || iov_iter_is_kvec(i) || iov_iter_is_xarray(i)) {
> +	if (iov_iter_is_bvec(i) || iov_iter_is_kvec(i) ||
> +	    iter_is_uaddr(i) || iov_iter_is_xarray(i)) {
>  		void *kaddr = kmap_local_page(page);
>  		size_t wanted = _copy_to_iter(kaddr + offset, bytes, i);
>  		kunmap_local(kaddr);

Nope.  This is bogus - _copy_to_iter() *can* legitimately fault for those, so
the same considerations as for iovec apply.

> @@ -900,7 +934,8 @@ size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
>  		return 0;
>  	if (likely(iter_is_iovec(i)))
>  		return copy_page_from_iter_iovec(page, offset, bytes, i);
> -	if (iov_iter_is_bvec(i) || iov_iter_is_kvec(i) || iov_iter_is_xarray(i)) {
> +	if (iov_iter_is_bvec(i) || iov_iter_is_kvec(i) ||
> +	    iter_is_uaddr(i) || iov_iter_is_xarray(i)) {

Ditto.

> @@ -1319,6 +1368,14 @@ unsigned long iov_iter_alignment(const struct iov_iter *i)
>  	if (iov_iter_is_bvec(i))
>  		return iov_iter_alignment_bvec(i);
>  
> +	if (iter_is_uaddr(i)) {
> +		size_t len = i->count - i->iov_offset;
> +
> +		if (len)
> +			return (unsigned long) i->uaddr + i->iov_offset;

Huh?  iov_iter_alignment() wants the worse of beginning and end, if there's
any data at all.

> @@ -1527,6 +1584,9 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
>  	if (!maxsize)
>  		return 0;
>  
> +	if (WARN_ON_ONCE(iter_is_uaddr(i)))
> +		return 0;

So no DIO read(2) or write(2) anymore?  Harsh...

> @@ -1652,6 +1712,8 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
>  		maxsize = i->count;
>  	if (!maxsize)
>  		return 0;
> +	if (WARN_ON_ONCE(iter_is_uaddr(i)))
> +		return 0;

Ditto.

> +	if (iter_is_uaddr(i)) {
> +		unsigned long uaddr = (unsigned long) i->uaddr;
> +		unsigned long start, end;
> +
> +		end = (uaddr + i->count - i->iov_offset + PAGE_SIZE - 1)
> +				>> PAGE_SHIFT;
> +		start = uaddr >> PAGE_SHIFT;
> +		return min_t(int, end - start, maxpages);

Nope.  The value is wrong (sanity check - decrement the base and increment
iov_offset by the same amount; the range of addresses is the same,
and the same should go for the result; yours fails that test).

FWIW, here it's
        if (likely(iter_is_ubuf(i))) {
		unsigned offs = offset_in_page(i->ubuf + i->iov_offset);
		int npages = DIV_ROUND_UP(offs + i->count, PAGE_SIZE);
		return min(npages, maxpages);
	}

BTW, you've missed iov_iter_gap_alignment()...
