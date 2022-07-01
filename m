Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC635628B7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 04:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbiGACHe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 22:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiGACHb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 22:07:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2885B45066
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 19:07:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 384ECB82C79
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Jul 2022 02:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BDEBC34115;
        Fri,  1 Jul 2022 02:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656641247;
        bh=rTtxZPTE2Iq1dSyV8m3YH9DMrL1cXJwTlW2DojXHFks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dtmVO6BXnrX4AP/J79h7ta+01QUm12TGoPkqlAFgNA9mDez48jsJblKPcsSCEO5hj
         Pm1t6v1tSG5RtjYPEjaBpnJO0xp8XujnddqnQwY18XaZ4IYadCjwNftpYViBYJZSET
         fAR1u5O+4nxhSdiDOevrfgrIHJzLXLqIrRHY9rFAs3U7xaB6Ov9Q6TJcrtI1DmwFar
         M0udV3G4e7x7pIYsjpLnm3aevZRnn6vlT7fPPS/yawrWD3OJEzAPjyOyCUy9PANM9Q
         SU0aE7b/bGcJ8Bs9SG8vuPRyBUFihXX7BSkmNMNuL8aZLzsIH7TxwLdV9QrOi75OYb
         Yq/oOSaPDDTMg==
Date:   Thu, 30 Jun 2022 20:07:24 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [block.git conflicts] Re: [PATCH 37/44] block: convert to
 advancing variants of iov_iter_get_pages{,_alloc}()
Message-ID: <Yr5W3G19zUQuCA7R@kbusch-mbp.dhcp.thefacebook.com>
References: <YrKWRCOOWXPHRCKg@ZenIV>
 <20220622041552.737754-1-viro@zeniv.linux.org.uk>
 <20220622041552.737754-37-viro@zeniv.linux.org.uk>
 <Yr4fj0uGfjX5ZvDI@ZenIV>
 <Yr4mKJvzdrUsssTh@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr4mKJvzdrUsssTh@ZenIV>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 30, 2022 at 11:39:36PM +0100, Al Viro wrote:
> On Thu, Jun 30, 2022 at 11:11:27PM +0100, Al Viro wrote:
> 
> > ... and the first half of that thing conflicts with "block: relax direct
> > io memory alignment" in -next...
> 
> BTW, looking at that commit - are you sure that bio_put_pages() on failure
> exit will do the right thing?  We have grabbed a bunch of page references;
> the amount if DIV_ROUND_UP(offset + size, PAGE_SIZE).  And that's before
> your
>                 size = ALIGN_DOWN(size, bdev_logical_block_size(bio->bi_bdev));

Thanks for the catch, it does look like a page reference could get leaked here.

> in there.  IMO the following would be more obviously correct:
>         size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
>         if (unlikely(size <= 0))
>                 return size ? size : -EFAULT;
> 
> 	nr_pages = DIV_ROUND_UP(size + offset, PAGE_SIZE);
> 	size = ALIGN_DOWN(size, bdev_logical_block_size(bio->bi_bdev));
> 
>         for (left = size, i = 0; left > 0; left -= len, i++) {
> ...
>                 if (ret) {
> 			while (i < nr_pages)
> 				put_page(pages[i++]);
>                         return ret;
>                 }
> ...
> 
> and get rid of bio_put_pages() entirely.  Objections?


I think that makes sense. I'll give your idea a test run tomorrow.
