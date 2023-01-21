Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2040A67666B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 14:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjAUNHx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 08:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjAUNHw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 08:07:52 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845D85FF7;
        Sat, 21 Jan 2023 05:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h38rVeQQMBfQzoUhfoAzFr4F8hjsgaO+ehHdHYEzIRQ=; b=36l70iQ579yXxTkbmz5v8IUwI8
        dnY1RHAis4/kPbZ4s1dTWo7GGfM9+PsYDTvA/Y7tnUMkk6QtsFs4q3RKtjxDRhwuxuddoTGXyhO21
        k3JOYcYvcpXRAS+o1eh4SKp7tAljXABwtv1V+QRSwm37U6FUjpYQGnNiK3mHnqLPE6Ta8oKvy3hRT
        ORbZCwTOtTrIkfJNbScpHez+noQTh1b6xZCPAw/hInfsoARdweG+zT4biwF7CgnJ7WfbNp/FVNG4p
        OKs8PWLCIAssIuDfFuv/kE3kFIh5X1L2FKd5gvAIiVG8zCLBH27F4ZOhEXG6tctvKDIol7/AKT43h
        hsATTidw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJDam-00Dswd-Q5; Sat, 21 Jan 2023 13:07:32 +0000
Date:   Sat, 21 Jan 2023 05:07:32 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 6/8] block: Make bio structs pin pages rather than
 ref'ing if appropriate
Message-ID: <Y8vjlH+w1sNBPJjU@infradead.org>
References: <20230120175556.3556978-1-dhowells@redhat.com>
 <20230120175556.3556978-7-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120175556.3556978-7-dhowells@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This really does three things:
 
 1) add the BIO_PAGE_PINNED infrastructure
 2) convert bio_iov_iter_get_pages to use iov_iter_extract_pages
 3) convert bio_map_user_iov to use iov_iter_extract_pages

so it should be three pages, with the first one also containing
what is in your previous patch.

> @@ -1183,7 +1185,7 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
>  	bio_for_each_segment_all(bvec, bio, iter_all) {
>  		if (mark_dirty && !PageCompound(bvec->bv_page))
>  			set_page_dirty_lock(bvec->bv_page);
> -		put_page(bvec->bv_page);
> +		bio_release_page(bio, bvec->bv_page);

This can be micro-optimized a bit by only doing the flags conversion
once.

