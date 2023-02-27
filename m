Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAB06A467B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 16:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjB0Pxt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 10:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjB0Pxs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 10:53:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A7014203;
        Mon, 27 Feb 2023 07:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bvlf1VHk1x4xvDwdfAsxAYn57xQifDzQAqPs7VXtqzU=; b=khClbTP3Xxn/WqZX1ADFyDyk49
        kABJLMHLHQ/wE1ANrAXKWpa8ZZ0I2rTp+JhXWfm8oPnPXYQ2Fbi7hsjbJIQvTCiEguKibtlkdY2vH
        nQ6ANLtWvATjbtbhEvnvxHqwyUeQL5RRWfkjvHifqOkv105JaHnYiXLssxEAvMiAYxNNboFes5pVN
        lDuac9+LGbvzVOGdolueCGrWkSQPU2R/XRMFJj+ekB7Wq+vjuF0VRAD5XoniVMuwZCxj7xcNrtLiX
        uYpfYRrWrlyz9FnGCumC8T1W34GrTpBT2Pclc/q+3CpXbovlFr5Gpo74wnuzcmMvojXaWZcZuitea
        gyxopwEQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWfop-000DxZ-R5; Mon, 27 Feb 2023 15:53:39 +0000
Date:   Mon, 27 Feb 2023 15:53:39 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@suse.de>, Miklos Szeredi <miklos@szeredi.hu>,
        Amit Shah <amit@kernel.org>, linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH v2] splice: Prevent gifting of multipage folios
Message-ID: <Y/zSA+eSjJityj1/@casper.infradead.org>
References: <2740801.1677513063@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2740801.1677513063@warthog.procyon.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 27, 2023 at 03:51:03PM +0000, David Howells wrote:
>     
> Don't let parts of compound pages/multipage folios be gifted by (vm)splice
> into a pipe as the other end may only be expecting single-page gifts (fuse
> and virtio console for example).
> 
> replace_page_cache_folio(), for example, will do the wrong thing if it
> tries to replace a single paged folio with a multipage folio.
> 
> Try to avoid this by making add_to_pipe() remove the gift flag on multipage
> folios.
> 
> Fixes: 7afa6fd037e5 ("[PATCH] vmsplice: allow user to pass in gift pages")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Matthew Wilcox <willy@infradead.org>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: stable@vger.kernel.org

> cc: Jens Axboe <axboe@suse.de>
> cc: Miklos Szeredi <miklos@szeredi.hu>
> cc: Amit Shah <amit@kernel.org>
> cc: linux-fsdevel@vger.kernel.org
> cc: virtualization@lists.linux-foundation.org
> cc: linux-mm@kvack.org
> ---
>  fs/splice.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/splice.c b/fs/splice.c
> index 2e76dbb81a8f..8bbd7794d9f0 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -240,6 +240,8 @@ ssize_t add_to_pipe(struct pipe_inode_info *pipe, struct pipe_buffer *buf)
>  	} else if (pipe_full(head, tail, pipe->max_usage)) {
>  		ret = -EAGAIN;
>  	} else {
> +		if (PageCompound(buf->page))
> +			buf->flags &= ~PIPE_BUF_FLAG_GIFT;
>  		pipe->bufs[head & mask] = *buf;
>  		pipe->head = head + 1;
>  		return buf->len;
> 
