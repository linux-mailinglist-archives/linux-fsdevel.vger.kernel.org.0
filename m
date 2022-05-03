Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FA45190A1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 23:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243100AbiECVsN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 17:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238169AbiECVsI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 17:48:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431F441625;
        Tue,  3 May 2022 14:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3kZQrcKSvNN25QXUtIV/pIqvcz6ABm2ldpp+seuRKQQ=; b=v1Z2vq+0O/BU3lhpTEQ/+ksIrc
        ai2fo/xQD4c6ky1atjbCvqWwbZDGkTk+ffBBlbiCXw1ZpTrKrmkyI9gwvE8/3aWrd/Cw/9k1Zj011
        nY610TVYLU+W1ftZ/IviINRRqPPavG4zlPn9EBpgYaiUwm9b5Wqj7SUy3s+Gb9zWV+iNs9zV/ioar
        wgICiH1ebX2Sv24OuVN0ao5AxuMhxZ8JXDXpq2/k2elxgvgF4zdWVgYn2ImYGeocUrfUWYeHa7aBs
        vg0yxQaCQHYpc5Ft4xGjTqrhZyj2XWYRasPRW/szCmUZptGiN35m5wpHKEXYzMMnHyt191c/2CkWS
        zV1LJnOw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nm0Jl-00Fz8T-8v; Tue, 03 May 2022 21:44:25 +0000
Date:   Tue, 3 May 2022 22:44:25 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: iomap_write_failed fix
Message-ID: <YnGiOVCSfHP0iOBo@casper.infradead.org>
References: <20220503213645.3273828-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503213645.3273828-1-agruenba@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 03, 2022 at 11:36:45PM +0200, Andreas Gruenbacher wrote:
> The @lend parameter of truncate_pagecache_range() should be the offset
> of the last byte of the hole, not the first byte beyond it.
> 
> Fixes: ae259a9c8593 ("fs: introduce iomap infrastructure")

Hm, yes, this is _true_, but it's a fix without importance (except maybe
for an overflow case?)  Look at the condition this is called in.  We
aren't punching out an extra byte in the page cache because we're
punching beyond the end of the file.

It should be fixed because people copy-and-paste code.  But it's not
urgent, and doesn't need to be backported.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  fs/iomap/buffered-io.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 8ce8720093b9..358ee1fb6f0d 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -531,7 +531,8 @@ iomap_write_failed(struct inode *inode, loff_t pos, unsigned len)
>  	 * write started inside the existing inode size.
>  	 */
>  	if (pos + len > i_size)
> -		truncate_pagecache_range(inode, max(pos, i_size), pos + len);
> +		truncate_pagecache_range(inode, max(pos, i_size),
> +					 pos + len - 1);
>  }
>  
>  static int iomap_read_folio_sync(loff_t block_start, struct folio *folio,
> -- 
> 2.35.1
> 
