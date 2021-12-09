Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869A946DFB3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 01:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhLIAwX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Dec 2021 19:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241530AbhLIAwX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Dec 2021 19:52:23 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADEFC061746;
        Wed,  8 Dec 2021 16:48:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0EAD9CE241A;
        Thu,  9 Dec 2021 00:48:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 250B5C00446;
        Thu,  9 Dec 2021 00:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639010927;
        bh=WsxKFZfmUF5jsQBFumbyPYG8kjxmh12OoF2z3/ongNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d1hRbBwue1BZSsJqyXSB2Ht9NUmFhq++n7WpI4LQy4/9ifcuFplimOuHzoHGJ+Lg9
         PP8xHhe7m9S8oy/PEbXbSW0fGII7Y6DEM1kkh1tQbChw8xDDEFlFoD4o9mdqGt1AOo
         2rKSczd5O3tAeXxyBVV06EKq+O3Vi38Ct+8+3hzZaVAPq2+JE5L1l44o+29nE2sKAX
         N1ccZnvKGaQSMnsiJuiCoWQBWZilLPb4gvXF9+IyxDYWVQaMh1LwdccRpCoO4CEPfm
         QjcUtgWTIxPHZddaeq/A7r1rpI515/U7CYlhoTo59rVEXiZ/xTashFKd5yB2AY0uW3
         gFzCYx8sjKGyA==
Date:   Wed, 8 Dec 2021 16:48:46 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dan.j.williams@intel.com, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] iomap: turn the byte variable in iomap_zero_iter into a
 ssize_t
Message-ID: <20211209004846.GA69193@magnolia>
References: <20211208091203.2927754-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208091203.2927754-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 10:12:03AM +0100, Christoph Hellwig wrote:
> bytes also hold the return value from iomap_write_end, which can contain
> a negative error value.  As bytes is always less than the page size even
> the signed type can hold the entire possible range.
> 
> Fixes: c6f40468657d ("fsdax: decouple zeroing from the iomap buffered I/O code")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index b1511255b4df8..ac040d607f4fe 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -883,7 +883,7 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  
>  	do {
>  		unsigned offset = offset_in_page(pos);
> -		size_t bytes = min_t(u64, PAGE_SIZE - offset, length);
> +		ssize_t bytes = min_t(u64, PAGE_SIZE - offset, length);
>  		struct page *page;
>  		int status;
>  
> -- 
> 2.30.2
> 
