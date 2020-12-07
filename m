Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5082D1E5C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 00:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgLGX1l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 18:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbgLGX1l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 18:27:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3949C061749;
        Mon,  7 Dec 2020 15:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=efNDHUK0kIQReg6gaBBlG6h4xr6jASmtw1EOBKXAyLk=; b=oGXIksxSLHfNq7Nd/dxPiETxai
        mZtQiABwOFbH8NXwaWami88IxDL1hfJ4dv7e7Q+LbAUNozIpP5+zIxMLJwyTb95LgXSFNQFFKv07t
        qOM246LaVu4VWp64BOg1lBAfdF3iOr7e+nxZtJBoKT+vet7S2MgLxSgzHHmJIXaBEvBk6Hl4YuexJ
        oPAdoLlJEm2lmEP9Q72FEaFRqf6ECFzVqauCUiH6nFIYWy76i0T/fi+i5xymYslOjPd+ye72PRyrC
        MIAcklDxsQADXt6YHuzm3eLs7DKjwNYcU8Ae0/ouGCc2dY8JAbRd3Vh0ZUPiTLt7hnxE5rIm1mKaV
        5CNKN6/A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmPu5-0001ze-EJ; Mon, 07 Dec 2020 23:26:49 +0000
Date:   Mon, 7 Dec 2020 23:26:49 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     ira.weiny@intel.com
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V2 2/2] mm/highmem: Lift memcpy_[to|from]_page to core
Message-ID: <20201207232649.GD7338@casper.infradead.org>
References: <20201207225703.2033611-1-ira.weiny@intel.com>
 <20201207225703.2033611-3-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207225703.2033611-3-ira.weiny@intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 07, 2020 at 02:57:03PM -0800, ira.weiny@intel.com wrote:
> +static inline void memcpy_page(struct page *dst_page, size_t dst_off,
> +			       struct page *src_page, size_t src_off,
> +			       size_t len)
> +{
> +	char *dst = kmap_local_page(dst_page);
> +	char *src = kmap_local_page(src_page);

I appreciate you've only moved these, but please add:

	BUG_ON(dst_off + len > PAGE_SIZE || src_off + len > PAGE_SIZE);

> +	memcpy(dst + dst_off, src + src_off, len);
> +	kunmap_local(src);
> +	kunmap_local(dst);
> +}
> +
> +static inline void memmove_page(struct page *dst_page, size_t dst_off,
> +			       struct page *src_page, size_t src_off,
> +			       size_t len)
> +{
> +	char *dst = kmap_local_page(dst_page);
> +	char *src = kmap_local_page(src_page);

	BUG_ON(dst_off + len > PAGE_SIZE || src_off + len > PAGE_SIZE);

> +	memmove(dst + dst_off, src + src_off, len);
> +	kunmap_local(src);
> +	kunmap_local(dst);
> +}
> +
> +static inline void memcpy_from_page(char *to, struct page *page, size_t offset, size_t len)
> +{
> +	char *from = kmap_local_page(page);

	BUG_ON(offset + len > PAGE_SIZE);

> +	memcpy(to, from + offset, len);
> +	kunmap_local(from);
> +}
> +
> +static inline void memcpy_to_page(struct page *page, size_t offset, const char *from, size_t len)
> +{
> +	char *to = kmap_local_page(page);

	BUG_ON(offset + len > PAGE_SIZE);

> +	memcpy(to + offset, from, len);
> +	kunmap_local(to);
> +}
> +
> +static inline void memset_page(struct page *page, size_t offset, int val, size_t len)
> +{
> +	char *addr = kmap_local_page(page);

	BUG_ON(offset + len > PAGE_SIZE);

> +	memset(addr + offset, val, len);
> +	kunmap_local(addr);
> +}
> +
>  #endif /* _LINUX_PAGEMAP_H */
