Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8AF5642CD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Jul 2022 23:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiGBVCm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Jul 2022 17:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiGBVCm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Jul 2022 17:02:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67377AE75
        for <linux-fsdevel@vger.kernel.org>; Sat,  2 Jul 2022 14:02:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E6E0B80689
        for <linux-fsdevel@vger.kernel.org>; Sat,  2 Jul 2022 21:02:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D8FC34114;
        Sat,  2 Jul 2022 21:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656795758;
        bh=QioJjCzp+SkY0ElWm4OGRNypVktFJuC9HCRN6UZfDPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CeKp+9bZ5oMaolgoIOAIAh00pv9r+oMzTp3QXPYwW1QSNgvox8Z1nndlo6pYkzfOb
         iMtb6EmMVijxGbJxFsOUBFlUOTxBGQ1RNXGxSIFfz3U7Cl+rx+R6KHuV0+Vxd6SNQm
         gvwsAPYbKCZrjMny8G0dVHDSSRVrQ80zV/N7TxdLSe7YF44xCRFpwCADOhr+f+npFG
         UsDvjyMdwwWdAaFLm2V4/IhVNEQP1r0NLDQhAziA8bHMqScwmbD/fmVy1oDfJvpNb3
         PsdXGZzri75YlXvisf52h8+aDXB1KYZbG3xKNABGsFeML9JctbBGQDUfCaVul95Dpm
         RC7PuR230hipA==
Date:   Sat, 2 Jul 2022 15:02:35 -0600
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
Message-ID: <YsCya887Tc1/tZHe@kbusch-mbp.dhcp.thefacebook.com>
References: <Yr8xmNMEOJke6NOx@ZenIV>
 <Yr80qNeRhFtPb/f3@kbusch-mbp.dhcp.thefacebook.com>
 <Yr838ci8FUsiZlSW@ZenIV>
 <Yr85AaNqNAEr+5ve@ZenIV>
 <Yr8/LLXaEIa7KPDT@kbusch-mbp.dhcp.thefacebook.com>
 <Yr9GNfmeO/xCjzD4@ZenIV>
 <Yr9KzV6u2iTPPQmq@kbusch-mbp.dhcp.thefacebook.com>
 <Yr9OZJ9Usn24XYFG@ZenIV>
 <Yr9Rhem4LH3i978m@kbusch-mbp.dhcp.thefacebook.com>
 <Yr/ZPpai40fgEFfk@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr/ZPpai40fgEFfk@ZenIV>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 02, 2022 at 06:35:58AM +0100, Al Viro wrote:
> On Fri, Jul 01, 2022 at 01:56:53PM -0600, Keith Busch wrote:
> 
> > Validating user requests gets really messy if we allow arbitrary segment
> > lengths. This particular patch just enables arbitrary address alignment, but
> > segment size is still required to be a block size. You found the commit that
> > enforces that earlier, "iov: introduce iov_iter_aligned", two commits prior.
> 
> BTW, where do you check it for this caller?
> 	fs/zonefs/super.c:786:  ret = bio_iov_iter_get_pages(bio, from);
> Incidentally, we have an incorrect use of iov_iter_truncate() in that one (compare
> with iomap case, where we reexpand it afterwards)...
> 
> I still don't get the logics of those round-downs.  You've *already* verified
> that each segment is a multiple of logical block size.  And you are stuffing
> as much as you can into bio, covering the data for as many segments as you
> can.  Sure, you might end up e.g. running into an unmapped page at wrong
> offset (since your requirements for initial offsets might be milder than
> logical block size).  Or you might run out of pages bio would take.  Either
> might put the end of bio at the wrong offset.

It is strange this function allows the possibility that bio_iov_add_page() can
fail. There's no reason to grab more pages that exceed the bio_full() condition
(ignoring the special ZONE_APPEND case for the moment).

I think it will make more sense if we clean that part up first so the size for
all successfully gotten pages can skip subsequent bio add page checks, and make
the error handling unnecessary.
 
> So why not trim it down *after* you are done adding pages into it?  And do it
> once, outside of the loop.  IDGI...  Validation is already done; I'm not
> suggesting to allow weird segment lengths or to change behaviour of your
> iov_iter_is_aligned() in any other way.

I may have misunderstood your previous suggestion, but I still think this is
the right way to go. The ALIGN_DOWN in its current location ensures the size
we're appending to the bio is acceptable before we even start. It's easier to
prevent adding pages to a bio IO than to back them out later. The latter would
need something like a special cased version of bio_truncate().

Anyway, I have some changes testing right now that I think will fix up the
issues you've raised, and make the rest a bit more clear. I'll send them for
consideration this weekend if all is succesful.

> Put it another way, is there any possibility for __bio_iov_iter_get_pages() to
> do a non-trivial round-down on anything other than the last iteration of that
> loop?
