Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADD25190D8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 May 2022 00:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243241AbiECV4n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 17:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiECV4n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 17:56:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B813A731;
        Tue,  3 May 2022 14:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JcnlWMZDo8becF5tPAKdj7IhoEHH9wsLov8mueY7Jvc=; b=KgPf624OfIhQS61Ep3S4mM9bSd
        nnaWvh68q5cT1cktnVLfWzM+yYwrmPI+ahcUYtozHICKnk3tQgEra86jpknK8J60v2rYJQAjx66oY
        ZdIm1gQ2cr3niuxHDVliCvJLy9ESROkZUMsKb6zcT6BfFaF1uWfOloO6Q6Xw7SanPbX4vAZUZ5WVV
        0BFis4bZz5ij6fle9T+QIfdGEFVJbwUXuAEgvbBhHtPGZ45yErwPXtKgkD/rXyE4Tu4z+Rf32hh5Z
        /wwf/WvGWDVf/LBH+CKe6nr/vnnXD9B/KwbPxDOAA72hEKBdgbqq40hT5CdM/xffSrQd7udgxwY0+
        pVKPtYhw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nm0S3-00FzVt-PA; Tue, 03 May 2022 21:52:59 +0000
Date:   Tue, 3 May 2022 22:52:59 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: iomap_write_end cleanup
Message-ID: <YnGkO9zpuzahiI0F@casper.infradead.org>
References: <20220503213727.3273873-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503213727.3273873-1-agruenba@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 03, 2022 at 11:37:27PM +0200, Andreas Gruenbacher wrote:
> In iomap_write_end(), only call iomap_write_failed() on the byte range
> that has failed.  This should improve code readability, but doesn't fix
> an actual bug because iomap_write_failed() is called after updating the
> file size here and it only affects the memory beyond the end of the
> file.

I can't find a way to set 'ret' to anything other than 0 or len.  I know
the code is written to make it look like we can return a short write,
but I can't see a way to do it.

> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  fs/iomap/buffered-io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 358ee1fb6f0d..8fb9b2797fc5 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -734,7 +734,7 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
>  	folio_put(folio);
>  
>  	if (ret < len)
> -		iomap_write_failed(iter->inode, pos, len);
> +		iomap_write_failed(iter->inode, pos + ret, len - ret);
>  	return ret;
>  }
>  
> -- 
> 2.35.1
> 
