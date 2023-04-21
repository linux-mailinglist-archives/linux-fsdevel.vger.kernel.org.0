Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2286EB4BA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Apr 2023 00:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbjDUWaZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 18:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjDUWaY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 18:30:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8261A1BF0;
        Fri, 21 Apr 2023 15:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=HB77AFqGG2aBz+Earrmv/XakHzRKihV+YVKN5AMto9w=; b=4FAhsMmpd9R2NNkxWh/EOySpZr
        3xMTf/cJ0+PNnJ2jbCGrZ6Gm69S6q3oAJkQ5yxUgkzhcpqqnYZvVCHMRG8Q44ftomMGgGmtsv/8/X
        hLnbhCDJuUrYaDwBuiiHWOQXrGjbspvupGp/eN9bsdk3b24WwsY/XkPvVT5hwOMnBBpGjaVdxENjr
        JoSB/n2YtzxQjl7qJQXY3ceKtXXJY4bChFW37Up6awJh/gBfz/LWtS/CSRHQfrPbEyn5NMMZ8oBKk
        1goaCU9P4Fulz/XxFCHiY4WPfQQd0fy3A/4pu1F6QjPYE6VPjaXVeuxuTCdmZo1zkvy/1rmg6rqcb
        /nt47FEw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ppzGj-00BxAj-0p;
        Fri, 21 Apr 2023 22:30:17 +0000
Date:   Fri, 21 Apr 2023 15:30:17 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Matthew Wilcox <willy@infradead.org>, agk@redhat.com,
        snitzer@kernel.org, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, christoph.boehmwalder@linbit.com,
        hch@infradead.org, djwong@kernel.org, minchan@kernel.org,
        senozhatsky@chromium.org, patches@lists.linux.dev,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dm-devel@redhat.com, drbd-dev@lists.linbit.com,
        linux-kernel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
        da.gomez@samsung.com, kbusch@kernel.org
Subject: Re: [PATCH 3/5] iomap: simplify iomap_init() with PAGE_SECTORS
Message-ID: <ZEMOeb9Bt60jxV+d@bombadil.infradead.org>
References: <20230421195807.2804512-1-mcgrof@kernel.org>
 <20230421195807.2804512-4-mcgrof@kernel.org>
 <ZELuiBNNHTk4EdxH@casper.infradead.org>
 <ZEMH9h/cd9Cp1t+X@bombadil.infradead.org>
 <47688c1d-9cf1-3e08-1f1d-a051b25d010e@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <47688c1d-9cf1-3e08-1f1d-a051b25d010e@kernel.dk>
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

On Fri, Apr 21, 2023 at 04:24:57PM -0600, Jens Axboe wrote:
> On 4/21/23 4:02 PM, Luis Chamberlain wrote:
> > On Fri, Apr 21, 2023 at 09:14:00PM +0100, Matthew Wilcox wrote:
> >> On Fri, Apr 21, 2023 at 12:58:05PM -0700, Luis Chamberlain wrote:
> >>> Just use the PAGE_SECTORS generic define. This produces no functional
> >>> changes. While at it use left shift to simplify this even further.
> >>
> >> How is FOO << 2 simpler than FOO * 4?
> >>
> >>> -	return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
> >>> +	return bioset_init(&iomap_ioend_bioset, PAGE_SECTORS << 2,
> > 
> > We could just do:
> > 
> > 
> > -	return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
> > +	return bioset_init(&iomap_ioend_bioset, 4 * PAGE_SECTORS,
> > 
> > The shift just seemed optimal if we're just going to change it.
> 
> It's going to generate the same code, but the multiplication is arguably
> easier to read (or harder to misread).

Then let's stick with the 4 * PAGE_SECTORS. Let me know if you need another
patch.

  Luis
