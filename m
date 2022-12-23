Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E26665529A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Dec 2022 17:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiLWQPI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Dec 2022 11:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbiLWQPG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Dec 2022 11:15:06 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F5B3EAEF;
        Fri, 23 Dec 2022 08:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FOq+IQwreCAb5o5To4xtNwUVGrFfO+bGPhpkASaB1VQ=; b=ecOqksS/Qv7xqVgyuhb9U6fLLC
        mXCeg0KLXrUw9c3jhI8vITWaPjJc8jxilQlvNuI9QIJ2zEQrn2hEZELq/76mnzJ8LzouIaDlVGiv3
        y5pFiChIOHF3ytLdNb5U29o/wYDLFJNAVI9DIAPtpsSzRajVSsX9Rve7Z4Gh6ko6t847Go83gzFdB
        94dchHeXeM6EQTkX4569O15CFh+ICJOc6TatTkNURH4qXfDj7n12xYGGTYtU6JYzwCqhMdIgtJiJT
        SEGGO+QUHXcfDqkjBXT4rBWJgK27jPfLh5DyaHg6CxNPiLwHLQ8Zwa3zH0YCFw2Gu+fe53NuvpQ7e
        yHGfVvrw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p8khL-009riT-04; Fri, 23 Dec 2022 16:15:03 +0000
Date:   Fri, 23 Dec 2022 08:15:02 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        willy@infradead.org
Subject: Re: [PATCH] [RFC] iomap: zeroing needs to be pagecache aware
Message-ID: <Y6XUBhYnH4P9oRt8@infradead.org>
References: <20221201005214.3836105-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201005214.3836105-1-david@fromorbit.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 01, 2022 at 11:52:14AM +1100, Dave Chinner wrote:
>  	folio = __filemap_get_folio(iter->inode->i_mapping, pos >> PAGE_SHIFT,
>  			fgp, mapping_gfp_mask(iter->inode->i_mapping));
>  	if (!folio) {
> -		status = (iter->flags & IOMAP_NOWAIT) ? -EAGAIN : -ENOMEM;
> +		if (!(fgp & FGP_CREAT))
> +			status = -ENODATA;
> +		else if (iter->flags & IOMAP_NOWAIT)
> +			status = -EAGAIN;
> +		else
> +			status = -ENOMEM;

Trying to reverse engineer the error case based on the flags passed
seems a bit problematic, even if I think for now it mostl still
works as !FGP_CREAT is exclusive vs IOMAP_NOWAIT.

Matthew, what do you think of switching __filemap_get_folio to an
ERR_PTR return and return actual cause?  Or do we have too many
callers and need ____filemap_get_folio (urrg..)?

> +		status = iomap_write_begin(iter, pos, bytes, &folio, fgp);
> +		if (status) {
> +			if (status == -ENODATA) {
> +				/*
> +				 * No folio was found, so skip to the start of
> +				 * the next potential entry in the page cache
> +				 * and continue from there.
> +				 */
> +				if (bytes > PAGE_SIZE - offset_in_page(pos))
> +					bytes = PAGE_SIZE - offset_in_page(pos);
> +				goto loop_continue;
> +			}
>  			return status;
> +		}

Nit: I'd check for -ENODATA one level of identation out to keep
the nesting limited:

		status = iomap_write_begin(iter, pos, bytes, &folio, fgp);
		if (status == -ENODATA) {
			...
			goto loop_continue;
		}
		if (status)
 			return status;
