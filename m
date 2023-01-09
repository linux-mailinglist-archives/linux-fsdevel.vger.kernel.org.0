Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A35662801
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 15:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjAIODx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 09:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237296AbjAIODY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 09:03:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1A7218D;
        Mon,  9 Jan 2023 06:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4fPc+b48YVFON+GFi5+tyom3A+8g29LdvgwOn9C6KLA=; b=Jo9RnxR7WL5y4iij9mTfw8hQBF
        jLg2xGBamflC+5gdBYgPQ+sg5qhQcIjVRfwthweBshVo7YBpxRX2QxbxxbSuI8RDpw4JcQIf5V37j
        FVIiXiObAfc3E6/xr7FNpma61QH4zXzNgZshZSCvbHTww8Gdh7IFK8+F+YD3D8NAO0fP6fPFwK6G2
        9PHXjQa7A49GE9JIxsoc9n4QtUGD4BVTuysKX6yoea6Q5ZFfPMQjGNMvg9jqTrqdXjT+b/GjHh7TZ
        7frbhhF9akLeQ2uOJPcHfEIeUfuMGB3k5aNDW44L8QpFkSuKBZDAdnQGlpXaKZyCh1TX1Fv+Agd5H
        vg1C5Dow==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pEsji-002KvU-Ld; Mon, 09 Jan 2023 14:02:50 +0000
Date:   Mon, 9 Jan 2023 14:02:50 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jeff Layton <jlayton@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 02/11] filemap: Remove filemap_check_and_keep_errors()
Message-ID: <Y7weinAVLt0uPRa8@casper.infradead.org>
References: <20230109051823.480289-1-willy@infradead.org>
 <20230109051823.480289-3-willy@infradead.org>
 <36311b962209353333be4c8ceaf0e0823ef9f228.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36311b962209353333be4c8ceaf0e0823ef9f228.camel@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 09, 2023 at 08:48:49AM -0500, Jeff Layton wrote:
> On Mon, 2023-01-09 at 05:18 +0000, Matthew Wilcox (Oracle) wrote:
> > Convert both callers to use the "new" errseq infrastructure.
> 
> I looked at making this sort of change across the board alongside the
> original wb_err patches, but I backed off at the time.
> 
> With the above patch, this function will no longer report a writeback
> error that occurs before the sample. Given that writeback can happen at
> any time, that seemed like it might be an undesirable change, and I
> didn't follow through.
> 
> It is true that the existing flag-based code may miss errors too, if
> multiple tasks are test_and_clear'ing the bits, but I think the above is
> even more likely to happen, esp. under memory pressure.
> 
> To do this right, we probably need to look at these callers and have
> them track a long-term errseq_t "since" value before they ever dirty the
> pages, and then continually check-and-advance vs. that.
> 
> For instance, the main caller of the above function is jbd2. Would it be
> reasonable to add in a new errseq_t value to the jnode for tracking
> errors?

Doesn't b4678df184b3 address this problem?  If nobody has seen the
error, we return 0 instead of the current value of wb_err, ensuring
that somebody always sees the error.
