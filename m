Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58FA52CA55
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 05:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbiESD1h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 23:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiESD1g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 23:27:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943E156C2A;
        Wed, 18 May 2022 20:27:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A9D2B8229B;
        Thu, 19 May 2022 03:27:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABAE4C385A5;
        Thu, 19 May 2022 03:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652930853;
        bh=pC4WUU0L6zz8KUWa0LlCC6LzwytyWrhm4VDMyuj0edI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q8a53JiMQcYvaV4XdhihonFeKnsH39gqVeviTNeuVwOfU3xG6EwOBP/OAC2PnwZ4s
         SGR5fGSCk0HIyzSEZG/AaRrzivZm437ZRSKuiQnIJqKzAb1lP9aqAv/6odMnbldSvk
         PRqGiD+7tF08p0Hgr0lBpVQjtr0hTeju2r0bTlyPDHhtLD6XmeioBrBgZklX4AK4hE
         hn+Lo/jcU2J5oPVLGq03A60HjtoEzCXwM6LEK9HPnXssurSQmDooFiJ6cyyfXiTGBU
         bNDsYGPLlcH9Kc0sBaBq+eH1K1o+jr6yUYo6SbWIhCsruukgjpqdIPYL/JqV88yNWY
         OMxmYd81sKtMA==
Date:   Wed, 18 May 2022 20:27:31 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com
Subject: Re: [PATCHv2 3/3] block: relax direct io memory alignment
Message-ID: <YoW5Iy+Vbk4Rv3zT@sol.localdomain>
References: <20220518171131.3525293-1-kbusch@fb.com>
 <20220518171131.3525293-4-kbusch@fb.com>
 <YoWL+T8JiIO5Ln3h@sol.localdomain>
 <YoWWtwsiKGqoTbVU@kbusch-mbp.dhcp.thefacebook.com>
 <YoWjBxmKDQC1mCIz@sol.localdomain>
 <YoWkiCdduzyQxHR+@kbusch-mbp.dhcp.thefacebook.com>
 <YoWmi0mvoIk3CfQN@sol.localdomain>
 <YoWqlqIzBcYGkcnu@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoWqlqIzBcYGkcnu@kbusch-mbp.dhcp.thefacebook.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 18, 2022 at 08:25:26PM -0600, Keith Busch wrote:
> On Wed, May 18, 2022 at 07:08:11PM -0700, Eric Biggers wrote:
> > On Wed, May 18, 2022 at 07:59:36PM -0600, Keith Busch wrote:
> > > I'm aware that spanning pages can cause bad splits on the bi_max_vecs
> > > condition, but I believe it's well handled here. Unless I'm terribly confused,
> > > which is certainly possible, I think you may have missed this part of the
> > > patch:
> > > 
> > > @@ -1223,6 +1224,8 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
> > >  	pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
> > > 
> > >  	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
> > > +	if (size > 0)
> > > +		size = ALIGN_DOWN(size, queue_logical_block_size(q));
> > >  	if (unlikely(size <= 0))
> > >  		return size ? size : -EFAULT;
> > > 
> > 
> > That makes the total length of each "batch" of pages be a multiple of the
> > logical block size, but individual logical blocks within that batch can still be
> > divided into multiple bvecs in the loop just below it:
> 
> I understand that, but the existing code conservatively assumes all pages are
> physically discontiguous and wouldn't have requested more pages if it didn't
> have enough bvecs for each of them:
> 
> 	unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
> 
> So with the segment alignment guarantee, and ensured available bvec space, the
> created bio will always be a logical block size multiple.
> 
> If we need to split it later due to some other constraint, we'll only split on
> a logical block size, even if its in the middle of a bvec.
> 

So the bio ends up with a total length that is a multiple of the logical block
size, but the lengths of the individual bvecs in the bio are *not* necessarily
multiples of the logical block size.  That's the problem.

Note, there's also lots of code that assumes that bio_vec::bv_len is a multiple
of 512.  That was implied by it being a multiple of the logical block size.  But
the DMA alignment can be much lower, like 8 bytes (see nvme_set_queue_limits()).

- Eric
