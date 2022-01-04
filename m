Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE001483C24
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jan 2022 08:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbiADHJB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jan 2022 02:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbiADHJA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jan 2022 02:09:00 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9C7C061761;
        Mon,  3 Jan 2022 23:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=I882NzauQGXLjuI/i1qh0BNtaLV5MK8W8+b5TPgZlTM=; b=ySEzd+8PegA1+4ObKwW7OIJu3/
        aRPi+Ef1O8UP2Ajmln4zDfL+3VcNgfwJpjcrZpOrNnsZ7dvUK2dU2uAtWdmbR41KeEzw6RvP8s3l4
        N1/N0OLqpOqoH8fXV4YhKfTNaxT61QJXiNol2EakMB0ptvVLKyGDyQmg5bLTMrO1WIwRuQtnHvsdt
        /rzpwl8RN/V4GZiVMf6oHAWPWDeScIOkRKsgZeD00clfd6UaWWG89J46zzC/H6azPp27R2bSGiYur
        OkrHwVV9l8reNV+BWxX66AKS1EtbXA8fyxUwFsSyv+SRBOiN/YC0oPhJoLM3gSzDgRjtt2Pj5Dibk
        5HXTNIrQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n4dwE-00AUa2-3u; Tue, 04 Jan 2022 07:08:54 +0000
Date:   Mon, 3 Jan 2022 23:08:54 -0800
From:   "hch@infradead.org" <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "bfoster@redhat.com" <bfoster@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH] iomap: Address soft lockup in iomap_finish_ioend()
Message-ID: <YdPyhpdxykDscMtJ@infradead.org>
References: <20211230193522.55520-1-trondmy@kernel.org>
 <Yc5f/C1I+N8MPHcd@casper.infradead.org>
 <6f746786a3928844fbe644e7e409008b4f50c239.camel@hammerspace.com>
 <20220101035516.GE945095@dread.disaster.area>
 <fb964769132eb01ed4e8b67d6972d50ee3387e24.camel@hammerspace.com>
 <20220103220310.GG945095@dread.disaster.area>
 <9f51fa6169f4c67d54dd8563b52c540c94c7703a.camel@hammerspace.com>
 <20220104012215.GH945095@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104012215.GH945095@dread.disaster.area>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 04, 2022 at 12:22:15PM +1100, Dave Chinner wrote:
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1098,6 +1098,15 @@ iomap_ioend_can_merge(struct iomap_ioend *ioend, struct iomap_ioend *next)
>  		return false;
>  	if (ioend->io_offset + ioend->io_size != next->io_offset)
>  		return false;
> +	/*
> +	 * Do not merge physically discontiguous ioends. The filesystem
> +	 * completion functions will have to iterate the physical
> +	 * discontiguities even if we merge the ioends at a logical level, so
> +	 * we don't gain anything by merging physical discontiguities here.
> +	 */
> +	if (ioend->io_inline_bio.bi_iter.bi_sector + (ioend->io_size >> 9) !=

This open codes bio_end_sector()

> +	    next->io_inline_bio.bi_iter.bi_sector)

But more importantly I don't think just using the inline_bio makes sense
here as the ioend can have multiple bios.  Fortunately we should always
have the last built bio available in ->io_bio.

> +		return false;
>  	return true;
>  }
>  
> @@ -1241,6 +1250,13 @@ iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t offset,
>  		return false;
>  	if (sector != bio_end_sector(wpc->ioend->io_bio))
>  		return false;
> +	/*
> +	 * Limit ioend bio chain lengths to minimise IO completion latency. This
> +	 * also prevents long tight loops ending page writeback on all the pages
> +	 * in the ioend.
> +	 */
> +	if (wpc->ioend->io_size >= 4096 * PAGE_SIZE)
> +		return false;

And this stops making sense with the impending additions of large folio
support.  I think we need to count the pages/folios instead as the
operations are once per page/folio.
