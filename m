Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F596A44FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 15:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjB0Ope (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 09:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjB0Opd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 09:45:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4021820682;
        Mon, 27 Feb 2023 06:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WHlGPMlhmQhls5CrvpHbn4RzyZ0OA10s0RB2VJXkfDc=; b=nhM1whikAgFj+vbpfnVeXY4oZY
        2vaGmpG5WPadKmsXWSJvTVN0HGNsG938uwJMOoDec3U3tmmvMz9KN2imgIYkuSrRWKIoAt1uINXkf
        d6QPAqlGXaY5YcU5bipS0QEKB8oquvo9rYL6pH7LG40EsaeFQB6pUUcBv2bGKIvEIhmD7ybmp58bK
        fy2rfHjPwEzaXBLcuV+UvfMepAY8tZPZ+RbaVLwstFi6isym9EmPKSGrq0gvhWAh0zGmHGwx+EcKB
        reCDUiICba0ySCfvlJkiDN/ho6hmwanYd9S7kNGnEUr87rIQQr09fuptXLjkwQDMyqp9Nv1Y6mi0G
        tQgqfF8Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWekp-000BPv-2R; Mon, 27 Feb 2023 14:45:27 +0000
Date:   Mon, 27 Feb 2023 14:45:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, Amit Shah <amit@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] splice: Prevent gifting of multipage folios
Message-ID: <Y/zCB43mmeZ/vSbz@casper.infradead.org>
References: <2734058.1677507812@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2734058.1677507812@warthog.procyon.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 27, 2023 at 02:23:32PM +0000, David Howells wrote:
>     
> Don't let parts of multipage folios be gifted by (vm)splice into a pipe as
> the other end may only be expecting single-page gifts (fuse and virtio
> console for example).
> 
> replace_page_cache_folio(), for example, will do the wrong thing if it
> tries to replace a single paged folio with a multipage folio.
> 
> Try to avoid this by making add_to_pipe() remove the gift flag on multipage
> folios.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

What should the Fixes: here be?  This was already possible with THPs
(both anon and tmpfs backed) long before I introduced folios.

> cc: Matthew Wilcox <willy@infradead.org>
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
> index 2e76dbb81a8f..33caa28a86e4 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -240,6 +240,8 @@ ssize_t add_to_pipe(struct pipe_inode_info *pipe, struct pipe_buffer *buf)
>  	} else if (pipe_full(head, tail, pipe->max_usage)) {
>  		ret = -EAGAIN;
>  	} else {
> +		if (folio_nr_pages(page_folio(buf->page)) > 1)
> +			buf->flags &= ~PIPE_BUF_FLAG_GIFT;

		if (PageCompound(buf->page))
			buf->flags &= ~PIPE_BUF_FLAG_GIFT;

would be simpler and more backportable.

