Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FDC7775E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 12:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbjHJKgo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 06:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjHJKgn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:36:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DAEF2;
        Thu, 10 Aug 2023 03:36:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E3FD63B15;
        Thu, 10 Aug 2023 10:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50214C433C8;
        Thu, 10 Aug 2023 10:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691663801;
        bh=7STLk6rer7/WorIAWuagccGXb4zGN98HldySsPD3+No=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aOqymy5dDQqmV9rwAQp+pXXD+NaZr6GDNhX/UT9tK6WVqRjj4OV9iyu4J9kCV1Qlj
         WN0MZjoZ0V8KAyYHdK7UwKO+kpDIWABFo7rM/yqA5kM59kTLHBSujtWEJnFKLnXsj9
         x9Xk7/lFdAFfAbq+8aCLM8F6CHBJNVoTjKxpqqavQuyBpsV+7kAaF/Eipd+7fe56T6
         QmO40r3DpfMHZ+Puz+zSCSv0Lh3nv9qtY1mo5pxYKe3VRalw8FgcQcVETvdhtS9ktO
         VtaRip1Aa2lVui1QNDmC0JIxMOUS4sjhCqNOYPcrnjjf/mvHQV4EJynaV3zYlSu3yt
         j3IfyzHH8EReQ==
Date:   Thu, 10 Aug 2023 12:36:38 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Dave Chinner <david@fromorbit.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Leonardo Bras <leobras@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>, P J P <ppandit@redhat.com>
Subject: Re: [PATCH] fs/buffer.c: disable per-CPU buffer_head cache for
 isolated CPUs
Message-ID: <ZNS9tqX9s7NbQq3c@lothringen>
References: <ZJtBrybavtb1x45V@tpad>
 <ZM11z1Jxqrwk47e9@lothringen>
 <ZM2PvQJd7kRyWnAZ@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZM2PvQJd7kRyWnAZ@tpad>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 04, 2023 at 08:54:37PM -0300, Marcelo Tosatti wrote:
> > So what happens if they ever do I/O then? Like if they need to do
> > some prep work before entering an isolated critical section?
> 
> Then instead of going through the per-CPU LRU buffer_head cache
> (__find_get_block), isolated CPUs will work as if their per-CPU
> cache is always empty, going through the slowpath 
> (__find_get_block_slow). The algorithm is:
> 
> /*
>  * Perform a pagecache lookup for the matching buffer.  If it's there, refresh
>  * it in the LRU and mark it as accessed.  If it is not present then return
>  * NULL
>  */
> struct buffer_head *
> __find_get_block(struct block_device *bdev, sector_t block, unsigned size)
> {
>         struct buffer_head *bh = lookup_bh_lru(bdev, block, size);
> 
>         if (bh == NULL) {
>                 /* __find_get_block_slow will mark the page accessed */
>                 bh = __find_get_block_slow(bdev, block);
>                 if (bh)
>                         bh_lru_install(bh);
>         } else
>                 touch_buffer(bh);
> 
>         return bh;
> }
> EXPORT_SYMBOL(__find_get_block);
> 
> I think the performance difference between the per-CPU LRU cache
> VS __find_get_block_slow was much more significant when the cache 
> was introduced. Nowadays its only 26ns (moreover modern filesystems 
> do not use buffer_head's).

Sounds good then!

Acked-by: Frederic Weisbecker <frederic@kernel.org>

Thanks!
