Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C334B6D6D2D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 21:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235910AbjDDTbf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 15:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235844AbjDDTbe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 15:31:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3933A2111;
        Tue,  4 Apr 2023 12:31:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6820630C3;
        Tue,  4 Apr 2023 19:31:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0787C433EF;
        Tue,  4 Apr 2023 19:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1680636692;
        bh=iZeD7ZRu9tfSGLuTP62t6auaUEfXlLmcKZ7Z2/qHEMQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NKpoyy+Yq6eqQbNYmjxqL2awnOyyHtD9l6JPyLyvHjgVoziqxs+++3YxXj1ILg3s7
         fThj6+7nxfFmT1cgl4T8Z52FbVv3E1+An1mGocVyxA8KAphD8aJqEfobzBt3Jhc7l5
         zcR20po358bnNrXE8ln3SnUEFC/KX/yu2Asz1XdU=
Date:   Tue, 4 Apr 2023 12:31:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk,
        minchan@kernel.org, martin@omnibond.com, hubcap@omnibond.com,
        brauner@kernel.org, viro@zeniv.linux.org.uk,
        senozhatsky@chromium.org, willy@infradead.org, hch@lst.de,
        devel@lists.orangefs.org, mcgrof@kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, gost.dev@samsung.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] zram: always chain bio to the parent in
 read_from_bdev_async
Message-Id: <20230404123131.6e8fca22b0a484c8c152492a@linux-foundation.org>
In-Reply-To: <ZCw9Dxdd0C95EUza@infradead.org>
References: <20230403132221.94921-1-p.raghav@samsung.com>
        <CGME20230403132223eucas1p2a27e8239b8bda4fc16b675a9473fd61f@eucas1p2.samsung.com>
        <20230403132221.94921-2-p.raghav@samsung.com>
        <ZCw9Dxdd0C95EUza@infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 4 Apr 2023 08:06:55 -0700 Christoph Hellwig <hch@infradead.org> wrote:

> On Mon, Apr 03, 2023 at 03:22:17PM +0200, Pankaj Raghav wrote:
> > zram_bvec_read() is called with the bio set to NULL only in
> > writeback_store() function. When a writeback is triggered,
> > zram_bvec_read() is called only if ZRAM_WB flag is not set. That will
> > result only calling zram_read_from_zspool() in __zram_bvec_read().
> > 
> > rw_page callback used to call read_from_bdev_async with a NULL parent
> > bio but that has been removed since commit 3222d8c2a7f8
> > ("block: remove ->rw_page").
> > 
> > We can now safely always call bio_chain() as read_from_bdev_async() will
> > be called with a parent bio set. A WARN_ON_ONCE is added if this function
> > is called with parent set to NULL.
> 
> I'm pretty sure this is wrong.

Thanks, I'll drop this v2 series.

>  I've now sent a series to untangle
> and fix up the zram I/O path, which should address the underlying
> issue here.

I can't find that series.

> It will obviously conflict with this patch, so maybe the best thing is
> to get the other page_endio removals into their respective maintainer
> trees, and then just do the final removal of the unused function after
> -rc1.
