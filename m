Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB1452C9C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 04:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbiESCZd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 22:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiESCZc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 22:25:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E8C19F81;
        Wed, 18 May 2022 19:25:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B35A061879;
        Thu, 19 May 2022 02:25:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A16C385A5;
        Thu, 19 May 2022 02:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652927130;
        bh=TydeY+jtKnJsH8MD4u7T9PDCuCkyRPCbzKN2YzuDzCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C7KUr50bcjN0SR7p08PFvWwjd1+HJGvsNNpzRB54ByPt15479RBA02nbID94vp8nZ
         jMQm/+4KzwoqtsqyZK/OqPRzcxO4IvtVXAg0Iww459TkSioSG7MI8XHI4/EQL8bfhR
         v3yi9qxwFBRqoxlJ+kEflQoQabpP0hsZuglx2vXyl+FE7wTnAfPjAxiQo4EqiWXkUS
         BohNM5ghRi5FD1ceNeAs8q/HHNrH1JjMQk0c9LRDob027dxV5lUJaDFL8EeA3ni+rr
         lPVpyBmWLyCmJHri0YF8uk6Ry3pM/gEbjH7gnrdOO285qHBj7nCz2b501FueVeq0Jr
         EcoE0faimbCgA==
Date:   Wed, 18 May 2022 20:25:26 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com
Subject: Re: [PATCHv2 3/3] block: relax direct io memory alignment
Message-ID: <YoWqlqIzBcYGkcnu@kbusch-mbp.dhcp.thefacebook.com>
References: <20220518171131.3525293-1-kbusch@fb.com>
 <20220518171131.3525293-4-kbusch@fb.com>
 <YoWL+T8JiIO5Ln3h@sol.localdomain>
 <YoWWtwsiKGqoTbVU@kbusch-mbp.dhcp.thefacebook.com>
 <YoWjBxmKDQC1mCIz@sol.localdomain>
 <YoWkiCdduzyQxHR+@kbusch-mbp.dhcp.thefacebook.com>
 <YoWmi0mvoIk3CfQN@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoWmi0mvoIk3CfQN@sol.localdomain>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 18, 2022 at 07:08:11PM -0700, Eric Biggers wrote:
> On Wed, May 18, 2022 at 07:59:36PM -0600, Keith Busch wrote:
> > I'm aware that spanning pages can cause bad splits on the bi_max_vecs
> > condition, but I believe it's well handled here. Unless I'm terribly confused,
> > which is certainly possible, I think you may have missed this part of the
> > patch:
> > 
> > @@ -1223,6 +1224,8 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
> >  	pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
> > 
> >  	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
> > +	if (size > 0)
> > +		size = ALIGN_DOWN(size, queue_logical_block_size(q));
> >  	if (unlikely(size <= 0))
> >  		return size ? size : -EFAULT;
> > 
> 
> That makes the total length of each "batch" of pages be a multiple of the
> logical block size, but individual logical blocks within that batch can still be
> divided into multiple bvecs in the loop just below it:

I understand that, but the existing code conservatively assumes all pages are
physically discontiguous and wouldn't have requested more pages if it didn't
have enough bvecs for each of them:

	unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;

So with the segment alignment guarantee, and ensured available bvec space, the
created bio will always be a logical block size multiple.

If we need to split it later due to some other constraint, we'll only split on
a logical block size, even if its in the middle of a bvec.

> 	for (left = size, i = 0; left > 0; left -= len, i++) {
> 		struct page *page = pages[i];
> 
> 		len = min_t(size_t, PAGE_SIZE - offset, left);
> 
> 		if (__bio_try_merge_page(bio, page, len, offset, &same_page)) {
> 			if (same_page)
> 				put_page(page);
> 		} else {
> 			if (WARN_ON_ONCE(bio_full(bio, len))) {
> 				bio_put_pages(pages + i, left, offset);
> 				return -EINVAL;
> 			}
> 			__bio_add_page(bio, page, len, offset);
> 		}
> 		offset = 0;
> 	}
> 
> - Eric
