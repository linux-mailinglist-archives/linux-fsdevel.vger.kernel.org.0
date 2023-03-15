Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B865F6BB926
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 17:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjCOQKR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 12:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbjCOQJg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:09:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4D3A27F;
        Wed, 15 Mar 2023 09:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=narI0Kzzf814XY8EFz2CHLlHOwVpJgEJht5/vy7eNPg=; b=QPZrdM9w8rQ7+F0DIyWNH69HBa
        WqivpYrlq9+bf1aQAZoGwRpPki/msVvMlC4cxTdD1gfLpnjd5mZdjVLDT8K92whqduduTJqUQgQ9X
        M824RtUrRn6WaRvqVtJApcVFhdluWsjwQ6hedSKpBzGqDwzol58496pVh0GaYlatw5hHJN8k/APLJ
        TFgOp2+UlsQyp0qsU+3pso9VgwhHaqt8EDBNe3cpPlHlNyRGk8Zlg332G3lXfZXG2Pc/uTCpLkcCT
        7wYPygjWvJ7DtE/qMescqFHNE8cNf70qCP4nu6PltvUWhE1CPrd2muYclIdjQo1LCx+D+pcUPVGFl
        6vDnlirQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pcTgE-00DyRp-IK; Wed, 15 Mar 2023 16:08:46 +0000
Date:   Wed, 15 Mar 2023 16:08:46 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Pankaj Raghav <p.raghav@samsung.com>, hubcap@omnibond.com,
        senozhatsky@chromium.org, martin@omnibond.com, minchan@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, axboe@kernel.dk,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, gost.dev@samsung.com, mcgrof@kernel.org,
        devel@lists.orangefs.org
Subject: Re: [RFC PATCH 2/3] mpage: use bio_for_each_folio_all in
 mpage_end_io()
Message-ID: <ZBHtjrk52/TTPU/F@casper.infradead.org>
References: <20230315123233.121593-1-p.raghav@samsung.com>
 <CGME20230315123235eucas1p1bd62cb2aab435727880769f2e57624fd@eucas1p1.samsung.com>
 <20230315123233.121593-3-p.raghav@samsung.com>
 <64a5e85e-4018-ed7d-29d4-db12af290899@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64a5e85e-4018-ed7d-29d4-db12af290899@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 15, 2023 at 03:52:15PM +0100, Hannes Reinecke wrote:
> On 3/15/23 13:32, Pankaj Raghav wrote:
> > Use bio_for_each_folio_all to iterate through folios in a bio so that
> > the folios can be directly passed to the folio_endio() function.
> > +	bio_for_each_folio_all(fi, bio)
> > +		folio_endio(fi.folio, bio_op(bio),
> > +			    blk_status_to_errno(bio->bi_status));
> >   	bio_put(bio);
> >   }
> 
> Ah. Here it is.
> 
> I would suggest merge these two patches.

The right way to have handled this patch series was:

1. Introduce a new folio_endio() [but see Christoph's mail on why we
shouldn't do that]
2-n convert callers to use folios directly
n+1 remove page_endio() entirely.

Note that patch n+1 might not be part of this patch series; sometimes
it takes a while to convert all callers to use folios.

I very much dislike the way this was done by pushing the page_folio()
call into each of the callers because it makes the entire series hard to
review.
