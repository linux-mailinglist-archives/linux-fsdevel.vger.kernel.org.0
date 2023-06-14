Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38523730640
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 19:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbjFNRqk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 13:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235725AbjFNRqX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 13:46:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0CA1BF0;
        Wed, 14 Jun 2023 10:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ccor7pCUyeHuohUFguz/94LEXy2CeDKMfVNImYw/2xs=; b=WP8o/Gd6ofmwBkr90I56yvDowq
        2ZxE+QZp+1mRTHckU1u4sTjEEnkozm7BzGDTVfh1mEYTbS44RKmXHNUiwQZNrJ0o8x3zq2DHbcxec
        2CG1n7JGTI/tQ2IKb+hKecQWfuMjnPLNi6Y9G8RkxIAr6zkdmrcgcUXQAI31OLTdQjPmWljGvbFB3
        Pz3xBwEqZ83X/hISFgXRzLPZXyv0eGn/ROazn6GsGfe/PCIwqQdpYDy/bco6H6fbk7z4YmauNq0OJ
        yHnuJLe77AZijoldDKa2VmwYYkm+NPxKLCseUFoZL39eP3qbz6SzqPF/vuoZTUbonH0msurqZJajM
        8MKjI0AA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q9UZY-006bNt-H8; Wed, 14 Jun 2023 17:46:20 +0000
Date:   Wed, 14 Jun 2023 18:46:20 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 0/7] RFC: high-order folio support for I/O
Message-ID: <ZIn87E+fvFvpiYxp@casper.infradead.org>
References: <20230614114637.89759-1-hare@suse.de>
 <cd816905-0e3e-6397-1a6f-fd4d29dfc739@suse.de>
 <ZInGbz6X/ZQAwdRx@casper.infradead.org>
 <b3fa1b77-d120-f86b-e02f-f79b6d13efcc@suse.de>
 <cfa191cc-47e4-5b61-bf4f-33ebd52fa783@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfa191cc-47e4-5b61-bf4f-33ebd52fa783@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 14, 2023 at 05:35:02PM +0200, Hannes Reinecke wrote:
> Hmm. And for that I'm hitting include/linux/pagemap.h:1250 pretty
> consistently; something's going haywire with readahead.

Is that this one?

        VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);

in __readahead_folio()

> Matthew, are you sure that this one:
> 
> /**
> 
>  * readahead_length - The number of bytes in this readahead request.
> 
>  * @rac: The readahead request.
> 
>  */
> static inline size_t readahead_length(struct readahead_control *rac)
> {
>         return rac->_nr_pages * PAGE_SIZE;
> }
> 
> is tenable for large folios?
> Especially as we have in mm/readahead.c:499
> 
>         ractl->_nr_pages += 1UL << order;
> 
> Hmm?

Yes.  nr_pages really is the number of pages.

I'm somewhat surprised you're not hitting:

                VM_BUG_ON_FOLIO(index & (folio_nr_pages(folio) - 1), folio);

in __filemap_add_folio().  Maybe the filesystems in question always
access indices which are naturally aligned to the block size.
