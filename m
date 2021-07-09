Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDFD3C1E49
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jul 2021 06:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhGIEcR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jul 2021 00:32:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229441AbhGIEcR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jul 2021 00:32:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 93C086141A;
        Fri,  9 Jul 2021 04:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625804974;
        bh=3HNn/xpvrZs3tcQEA38VgCXMxppLux+mv+RaiGJT62o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S8NikfcmWmLYq+Tm7M1Flyuykyp8G4aXyYNFZ23Y3tc1Pf3ug0qhLUbg4M4dLRean
         HdJunqhcBJdDXtvC+KE+k+8JkROEg2rSz7V85mnyzGfFLEHrBrCV9Q8tYTg3cBNrWh
         P9yOKB/LhfnOzq7yosXNV78BgTCRLqi8apDFYOVv6B48lCeGGDSVACjBfHS4XTkZYW
         jeaIz8iH+QRf+3vigvmOI+ptxeCHMQCswbxSw79r5WesKlakxE4uWlz6q9AezL6KVX
         eA/RpHdViYBfh3o+ID6wSgWDfkmfLah98oEF/uS6WVmJubh3sUuyUaUU5w4yDNsr2r
         lzamKJX/hCMqg==
Date:   Thu, 8 Jul 2021 21:29:34 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com
Subject: Re: [PATCH v3 3/3] iomap: Don't create iomap_page objects in
 iomap_page_mkwrite_actor
Message-ID: <20210709042934.GV11588@locust>
References: <20210707115524.2242151-1-agruenba@redhat.com>
 <20210707115524.2242151-4-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707115524.2242151-4-agruenba@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 07, 2021 at 01:55:24PM +0200, Andreas Gruenbacher wrote:
> Now that we create those objects in iomap_writepage_map when needed,
> there's no need to pre-create them in iomap_page_mkwrite_actor anymore.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

I'd like to stage this series as a bugfix branch against -rc1 next week,
if there are no other objections?

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 6330dabc451e..9f45050b61dd 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -999,7 +999,6 @@ iomap_page_mkwrite_actor(struct inode *inode, loff_t pos, loff_t length,
>  		block_commit_write(page, 0, length);
>  	} else {
>  		WARN_ON_ONCE(!PageUptodate(page));
> -		iomap_page_create(inode, page);
>  		set_page_dirty(page);
>  	}
>  
> -- 
> 2.26.3
> 
