Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B7275B179
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 16:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjGTOpW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 10:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjGTOpU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 10:45:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59F326BF;
        Thu, 20 Jul 2023 07:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8WAJT9WDMLEvcf61yGGorsrPggYGaOW5RZCuMk69rE0=; b=SkOAYLLGGTGtbots/O5bylvoXP
        UuDt0Y4Ba3M4eyPVgki65V6/Q96dGxf4yFNLZwAWQQGhKg/0i0qLxC1FMe/fANdxhnIf+wlegGmro
        FsueXRs0/J3HyF3Mlj2/GX9ZC8gIJnj0yy1QuObbvJEU2ef2XWIRhHtFZyZCnYxuiok+sSydyMgNQ
        ByvNAHFOU2XlGG/EY5WrMjTYuOU2AZjRrRNIbRlLiKqQKtfZSBMKYGExCsxAKdxBdj2P31sqvGnM+
        0oCT81YxqelH0PK1vI3K9foHjgfzBAEJ3s1Y6rw5c3kxuQT4kIBHLhwYmBE+Ni3308Dz6KXjHTxc3
        aKA+eivg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qMUtz-000BQQ-Om; Thu, 20 Jul 2023 14:45:11 +0000
Date:   Thu, 20 Jul 2023 15:45:11 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] fs: add CONFIG_BUFFER_HEAD
Message-ID: <ZLlId9+kXl5Tb7wj@casper.infradead.org>
References: <20230720140452.63817-1-hch@lst.de>
 <20230720140452.63817-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720140452.63817-7-hch@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 20, 2023 at 04:04:52PM +0200, Christoph Hellwig wrote:
> @@ -400,7 +391,8 @@ static int blkdev_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  	iomap->type = IOMAP_MAPPED;
>  	iomap->addr = iomap->offset;
>  	iomap->length = isize - iomap->offset;
> -	iomap->flags |= IOMAP_F_BUFFER_HEAD;
> +	if (IS_ENABLED(CONFIG_BUFFER_HEAD))
> +		iomap->flags |= IOMAP_F_BUFFER_HEAD;

Wouldn't it be simpler to do ...

+#ifdef CONFIG_BUFFER_HEAD
 #define IOMAP_F_BUFFER_HEAD     (1U << 4)
+#else
+#define IOMAP_F_BUFFER_HEAD	0
+#endif

in include/linux/iomap.h ?

> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 0607790827b48a..6dc585c010c020 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -41,6 +41,12 @@ static inline struct iomap_page *to_iomap_page(struct folio *folio)
>  	return NULL;
>  }
>  
> +static inline bool iomap_use_buffer_heads(const struct iomap *iomap)
> +{
> +	return IS_ENABLED(CONFIG_BUFFER_HEAD) &&
> +		(iomap->flags & IOMAP_F_BUFFER_HEAD);
> +}

... because this function then goes away.

> @@ -675,7 +681,7 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
>  
>  	if (srcmap->type == IOMAP_INLINE)
>  		status = iomap_write_begin_inline(iter, folio);
> -	else if (srcmap->flags & IOMAP_F_BUFFER_HEAD)
> +	else if (iomap_use_buffer_heads(srcmap))

... as this will be optimised away.

