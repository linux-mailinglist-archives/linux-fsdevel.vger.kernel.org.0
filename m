Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49646EB45A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Apr 2023 00:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbjDUWCl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 18:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbjDUWCj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 18:02:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E884B10FF;
        Fri, 21 Apr 2023 15:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zJtElQBBcdjQLKuTgcAUU6SVKeCB/u/2QO+HYPXJ5yM=; b=TZu/Zi5uyNmtM3AYC5F+uKMVsg
        hHiw+cqzzyEH5I7hS1byjWvZbtD93wTW5QBG4M2KWk+B9WNSSwm8v8mi/Pnh/wNHKblwtRlS/KMzQ
        Ay3jyrkfXj38Eh37M4Cv7VwmsBNNmqrv9OwKF8lm0f+wSW4Om7abWzDRmsfs9KuyHuU0Imx3Q0AER
        ZAbNWgHZn5tbTJvEdgqX6vx58Jc1AstSfU9BdUtC5U+O8zrXvOcpy1sMmYqObWFFEt0xJw9Ase7ZL
        24pyTndrtdkUUd3SbhFseygDv/Okmg+4zGC/X9a2KfIdvJud/46SLd6TpOspXAPAEoF1aQEjJW7ON
        WDwf8KDw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ppypq-00Bv2r-1H;
        Fri, 21 Apr 2023 22:02:30 +0000
Date:   Fri, 21 Apr 2023 15:02:30 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        christoph.boehmwalder@linbit.com, hch@infradead.org,
        djwong@kernel.org, minchan@kernel.org, senozhatsky@chromium.org,
        patches@lists.linux.dev, linux-block@vger.kernel.org,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
        drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        hare@suse.de, p.raghav@samsung.com, da.gomez@samsung.com,
        kbusch@kernel.org
Subject: Re: [PATCH 3/5] iomap: simplify iomap_init() with PAGE_SECTORS
Message-ID: <ZEMH9h/cd9Cp1t+X@bombadil.infradead.org>
References: <20230421195807.2804512-1-mcgrof@kernel.org>
 <20230421195807.2804512-4-mcgrof@kernel.org>
 <ZELuiBNNHTk4EdxH@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZELuiBNNHTk4EdxH@casper.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 21, 2023 at 09:14:00PM +0100, Matthew Wilcox wrote:
> On Fri, Apr 21, 2023 at 12:58:05PM -0700, Luis Chamberlain wrote:
> > Just use the PAGE_SECTORS generic define. This produces no functional
> > changes. While at it use left shift to simplify this even further.
> 
> How is FOO << 2 simpler than FOO * 4?
> 
> > -	return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
> > +	return bioset_init(&iomap_ioend_bioset, PAGE_SECTORS << 2,

We could just do:


-	return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
+	return bioset_init(&iomap_ioend_bioset, 4 * PAGE_SECTORS,

The shift just seemed optimal if we're just going to change it.

  Luis
