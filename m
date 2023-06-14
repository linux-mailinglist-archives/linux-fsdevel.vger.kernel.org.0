Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2F373004F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 15:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245062AbjFNNpe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 09:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236740AbjFNNpd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:45:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7F81BFD;
        Wed, 14 Jun 2023 06:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Az+mDoXTt1ZnhjFATyvU/a3dOhH49ucjiGQ0gL0+ANg=; b=RKBXtJ3rosx+y5/NSJ6Z/5qIMD
        musumP15B57eQzfxQxgURyADh7zy+xNuVkXXZk3UHtZhZrqs/8WaV8pPQj6mpkQzaJgZcilAIScmz
        CnIAiCC5kSeEykvXtcBPOXunuWLCXqe917HMq/k6nKwrrS/Pq1nYzXUjpFbSqcwzZo4AqPyDhs6QB
        lquxKykMmi3aMXnx1wOJjzum8mAxB7ctynkQ6OS3SjPxq3a+ZXbioxvsUlAnGbegD1eyKZK7FnWFG
        v3AMBWfV4q/Uampn/k2wHyz7Zf9eVbiAvlsDFYRP+MVPebg6QSvZv6jEMsIG3S5rrTMWX76eEiy63
        Bj+efrFg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q9QoU-006NaI-KS; Wed, 14 Jun 2023 13:45:30 +0000
Date:   Wed, 14 Jun 2023 14:45:30 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 2/7] brd: convert to folios
Message-ID: <ZInEeq1lfDUxye58@casper.infradead.org>
References: <20230614114637.89759-1-hare@suse.de>
 <20230614114637.89759-3-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614114637.89759-3-hare@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 14, 2023 at 01:46:32PM +0200, Hannes Reinecke wrote:
>  /*
> - * Each block ramdisk device has a xarray brd_pages of pages that stores
> - * the pages containing the block device's contents. A brd page's ->index is
> - * its offset in PAGE_SIZE units. This is similar to, but in no way connected
> - * with, the kernel's pagecache or buffer cache (which sit above our block
> - * device).
> + * Each block ramdisk device has a xarray of folios that stores the folios
> + * containing the block device's contents. A brd folio's ->index is its offset
> + * in PAGE_SIZE units. This is similar to, but in no way connected with,
> + * the kernel's pagecache or buffer cache (which sit above our block device).

Having read my way to the end of the series, I can now circle back and
say this comment is wrong.  The folio->index is its offset in PAGE_SIZE
units if the sector size is <= PAGE_SIZE, otherwise it's the offset in
sector size units.  This is _different from_ the pagecache which uses
PAGE_SIZE units and multi-index entries in the XArray.

> @@ -144,29 +143,29 @@ static int copy_to_brd_setup(struct brd_device *brd, sector_t sector, size_t n,
>  static void copy_to_brd(struct brd_device *brd, const void *src,
>  			sector_t sector, size_t n)
>  {
> -	struct page *page;
> +	struct folio *folio;
>  	void *dst;
>  	unsigned int offset = (sector & (PAGE_SECTORS-1)) << SECTOR_SHIFT;
>  	size_t copy;
>  
>  	copy = min_t(size_t, n, PAGE_SIZE - offset);
> -	page = brd_lookup_page(brd, sector);
> -	BUG_ON(!page);
> +	folio = brd_lookup_folio(brd, sector);
> +	BUG_ON(!folio);
>  
> -	dst = kmap_atomic(page);
> -	memcpy(dst + offset, src, copy);
> -	kunmap_atomic(dst);
> +	dst = kmap_local_folio(folio, offset);
> +	memcpy(dst, src, copy);
> +	kunmap_local(dst);

This should use memcpy_to_folio(), which doesn't exist yet.
Compile-tested patch incoming shortly ...

> +	folio = brd_lookup_folio(brd, sector);
> +	if (folio) {
> +		src = kmap_local_folio(folio, offset);
> +		memcpy(dst, src, copy);
> +		kunmap_local(src);

And this will need memcpy_from_folio(), patch for that incoming too.

> @@ -226,15 +225,15 @@ static int brd_do_bvec(struct brd_device *brd, struct page *page,
>  			goto out;
>  	}
>  
> -	mem = kmap_atomic(page);
> +	mem = kmap_local_folio(folio, off);
>  	if (!op_is_write(opf)) {
> -		copy_from_brd(mem + off, brd, sector, len);
> -		flush_dcache_page(page);
> +		copy_from_brd(mem, brd, sector, len);
> +		flush_dcache_folio(folio);

Nngh.  This will need to be a more complex loop.  I don't think we can
do a simple abstraction here.  Perhaps you can base it on the two
patches you're about to see?

