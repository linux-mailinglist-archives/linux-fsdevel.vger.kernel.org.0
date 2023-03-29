Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0CCB6CF7C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 01:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjC2Xx2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 19:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjC2Xx2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 19:53:28 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF091FD2;
        Wed, 29 Mar 2023 16:53:27 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id EB2DC68C7B; Thu, 30 Mar 2023 01:53:22 +0200 (CEST)
Date:   Thu, 30 Mar 2023 01:53:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, martin@omnibond.com,
        axboe@kernel.dk, minchan@kernel.org, akpm@linux-foundation.org,
        hubcap@omnibond.com, viro@zeniv.linux.org.uk,
        senozhatsky@chromium.org, brauner@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        mcgrof@kernel.org, linux-block@vger.kernel.org,
        gost.dev@samsung.com, linux-mm@kvack.org, devel@lists.orangefs.org
Subject: Re: [PATCH 1/5] zram: remove the call to page_endio in the bio
 end_io handler
Message-ID: <20230329235322.GA1891@lst.de>
References: <20230328112716.50120-1-p.raghav@samsung.com> <CGME20230328112718eucas1p214a859cfb3d7b45523356bcc16c373b1@eucas1p2.samsung.com> <20230328112716.50120-2-p.raghav@samsung.com> <ZCMFcTHkTe/1WapL@casper.infradead.org> <5865a840-cb5e-ead1-f168-100869081f84@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5865a840-cb5e-ead1-f168-100869081f84@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 28, 2023 at 06:17:11PM +0200, Pankaj Raghav wrote:
> >>  	if (!parent)
> >> -		bio->bi_end_io = zram_page_end_io;
> >> +		bio->bi_end_io = zram_read_end_io;
> > 
> > Can we just do:
> > 
> > 	if (!parent)
> > 		bio->bi_end_io = bio_put;
> > 
> 
> Looks neat. I will wait for Christoph to comment whether just a bio_put() call
> is enough in this case for non-chained bios before making this change for the
> next version.

It is enough in the sense of keeping the previous behavior there.
It is not enough in the sense that the code is still broken as the
callers is never notified of the read completion.  So I think for the
purpose of your series we're fine and can go ahead with this version
for now.

> 
> Thanks.
---end quoted text---
