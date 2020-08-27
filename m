Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94EB22540F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 10:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgH0Ifz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 04:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgH0Ify (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 04:35:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F180BC061264;
        Thu, 27 Aug 2020 01:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1MBOvjB+9m0M7w4PQdZ2NOCfksOiohzbEbMFMspbqoc=; b=QW3Qe/NlFGPNasZPafhuJ7jcdn
        8OHUxL+KZ3L/ZK90HAdySeBpBxqH+oQMwUYY2ybWhjl6ySP4LXESV9Ky+fFPP+kBPufC5QuRsX5Op
        5WS0EzX3egRn8JFShjXtd9q1PF9BfDdMq/HKI5ZtUVspNwVs6O38Dw2b/zGCBgxyOE9rLkxAGk0Wk
        gUt+9/HB0x5wLyg0ZnvHLDuG58nqnVFFeVCqcdILhDiVP/ndQEh4jmuyz/h+vUhmO+F4X6mjFKca/
        JuBA8ecVSCcH+nbv/AtSxmFZgBKgl/bK58IBvsF1yDv77smtLkq3766whaoQMmr9pLSG/3+LBnYfW
        JSQ2cCyQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBDNw-0003ns-Gs; Thu, 27 Aug 2020 08:35:52 +0000
Date:   Thu, 27 Aug 2020 09:35:52 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] iomap: Convert read_count to byte count
Message-ID: <20200827083552.GC11067@infradead.org>
References: <20200824145511.10500-1-willy@infradead.org>
 <20200824145511.10500-7-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824145511.10500-7-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> @@ -269,20 +263,17 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  	if (ctx->bio && bio_end_sector(ctx->bio) == sector)
>  		is_contig = true;
>  
> -
>  	/*
> -	 * If we start a new segment we need to increase the read count, and we
> -	 * need to do so before submitting any previous full bio to make sure
> -	 * that we don't prematurely unlock the page.
> +	 * We need to increase the read count before submitting any
> +	 * previous bio to make sure that we don't prematurely unlock
> +	 * the page.
>  	 */
>  	if (iop)
> -		atomic_inc(&iop->read_count);
> +		atomic_add(plen, &iop->read_count);
> +
> +	if (is_contig &&
> +	    __bio_try_merge_page(ctx->bio, page, plen, poff, &same_page))
> +		goto done;
>  
>  	if (!ctx->bio || !is_contig || bio_full(ctx->bio, plen)) {

I think we can simplify this a bit by reordering the checks:

 	if (iop)
		atomic_add(plen, &iop->read_count);

  	if (ctx->bio && bio_end_sector(ctx->bio) == sector)
		if (__bio_try_merge_page(ctx->bio, page, plen, poff,
				&same_page))
			goto done;
		is_contig = true;
	}

	if (!is_contig || bio_full(ctx->bio, plen)) {
		// the existing case to allocate a new bio
	}

Also I think read_count should be renamed to be more descriptive,
something like read_bytes_pending?  Same for the write side.
