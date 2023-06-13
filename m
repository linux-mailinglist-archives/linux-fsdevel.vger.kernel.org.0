Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0D872D8E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 06:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbjFME66 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 00:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239848AbjFME6z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 00:58:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994F710DF;
        Mon, 12 Jun 2023 21:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=w9Q4ob6grJNpQxmfR3jxbApKOAm6KhVd/03nHGNKHrE=; b=NiQHmPBcyeBcEGhUwcUoMeEG15
        d4+MSC7O1EWxlnNYi2e+0oMcvFp4l+V8aRAYxcVza2KFXza3luG+DIkivvQ1AiW0lSNeXriXJlsif
        A/ao4lCDdoAD6cgB94VXL0i2FVwwaXBJzF4kPUhEAN3W3kamh2FpahP+sF2UUGwRMcm81KDzzPFbY
        gruS4eUhAZxkbK5SbpPO8s4BCkVD6lm5HVsMsyuoCqXUwSarMckB3V6RMW2psaG2hrGpIKcRb3bdG
        +gaEM8OkT/qydsE3O+iGVuNLM9VHXtgwQiVDA0PgDtH9LzlonkYQ2l4LtlmTlXMFd9JB251qYObCS
        8DOo6xCw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q8w7K-006vWF-1W;
        Tue, 13 Jun 2023 04:58:54 +0000
Date:   Mon, 12 Jun 2023 21:58:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v3 8/8] iomap: Copy larger chunks from userspace
Message-ID: <ZIf3jom4xteSmj5/@infradead.org>
References: <20230612203910.724378-1-willy@infradead.org>
 <20230612203910.724378-9-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612203910.724378-9-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 12, 2023 at 09:39:10PM +0100, Matthew Wilcox (Oracle) wrote:
> If we have a large folio, we can copy in larger chunks than PAGE_SIZE.
> Start at the maximum page cache size and shrink by half every time we
> hit the "we are short on memory" problem.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/iomap/buffered-io.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index a5d62c9640cf..818dc350ffc5 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -768,6 +768,7 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
>  static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  {
>  	loff_t length = iomap_length(iter);
> +	size_t chunk = PAGE_SIZE << MAX_PAGECACHE_ORDER;

This could overflow if the chunk size ends up bigger than 4GB, but
I guess that's mostly theoretical.

> -		copied = copy_page_from_iter_atomic(page, offset, bytes, i);
> +		copied = copy_page_from_iter_atomic(&folio->page, offset, bytes, i);

Would be nice t avoid the overly long line here

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
