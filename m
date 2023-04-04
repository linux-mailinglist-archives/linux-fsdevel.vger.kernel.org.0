Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3066D66CA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 17:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbjDDPHN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 11:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbjDDPHM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 11:07:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DB94208;
        Tue,  4 Apr 2023 08:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+xJx4n5fddFyIFFs3SdXnORgMAqZS8Ci75rQNLy446k=; b=rFcI21jKpPc9azebBgljlpKjUt
        qaU36x2REP/7febP8y1I/U1MUjGKukxFvQ9jkDUnP6nlav/TCkhFNIr66m+bWJvPJIUV4fHUlOWQs
        2kv99JKeyqasNjykpcqoZTauDxW+prYc5FahlOpfz0/qqW7zY3a6M4G4gu7zUcLEG4LCxdtAiQmR9
        1HaHdqQjE1cktt8L8Os43sQIP7K3kn5jV9l4zFSUPH8MHZ/U4n60J9x8aFRXClPra0ASxHQRWigDf
        bgG2ZTNYVKwirYWvL5gbcAHseIy9nwp0QDt62ahuGCVAecGEXhJTqzQLHbknDf64gaDXyQ0hKRWw0
        Cf/fBj6Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pjiFL-001vy7-2q;
        Tue, 04 Apr 2023 15:06:55 +0000
Date:   Tue, 4 Apr 2023 08:06:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     axboe@kernel.dk, minchan@kernel.org, martin@omnibond.com,
        hubcap@omnibond.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
        senozhatsky@chromium.org, akpm@linux-foundation.org,
        willy@infradead.org, hch@lst.de, devel@lists.orangefs.org,
        mcgrof@kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, gost.dev@samsung.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] zram: always chain bio to the parent in
 read_from_bdev_async
Message-ID: <ZCw9Dxdd0C95EUza@infradead.org>
References: <20230403132221.94921-1-p.raghav@samsung.com>
 <CGME20230403132223eucas1p2a27e8239b8bda4fc16b675a9473fd61f@eucas1p2.samsung.com>
 <20230403132221.94921-2-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403132221.94921-2-p.raghav@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 03, 2023 at 03:22:17PM +0200, Pankaj Raghav wrote:
> zram_bvec_read() is called with the bio set to NULL only in
> writeback_store() function. When a writeback is triggered,
> zram_bvec_read() is called only if ZRAM_WB flag is not set. That will
> result only calling zram_read_from_zspool() in __zram_bvec_read().
> 
> rw_page callback used to call read_from_bdev_async with a NULL parent
> bio but that has been removed since commit 3222d8c2a7f8
> ("block: remove ->rw_page").
> 
> We can now safely always call bio_chain() as read_from_bdev_async() will
> be called with a parent bio set. A WARN_ON_ONCE is added if this function
> is called with parent set to NULL.

I'm pretty sure this is wrong.  I've now sent a series to untangle
and fix up the zram I/O path, which should address the underlying
issue here.

It will obviously conflict with this patch, so maybe the best thing is
to get the other page_endio removals into their respective maintainer
trees, and then just do the final removal of the unused function after
-rc1.
