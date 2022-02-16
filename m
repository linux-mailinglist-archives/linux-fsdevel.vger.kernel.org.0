Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2894B8F9C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Feb 2022 18:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237275AbiBPRq2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Feb 2022 12:46:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiBPRq1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Feb 2022 12:46:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C782B100F;
        Wed, 16 Feb 2022 09:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VbUBhMXlxHu1hd9TNvXiS+teJ/r1jPmqMT3yZi5DiXA=; b=YFMvYdQjx1CUVz3+iDv8dWZBQn
        TFKDs1U168DEQITKZe9AaZx16SKrXTx2ksq/NMGVl2W0EEwQuncChNlonnFXmyWZzd7nO4br2waQp
        FIgkLzZrsrUvnq4nuBcjXKyy1fnyqNj0lXhyCpSmqyKt5ZGUkkIfJBO65Hk2cQ3ChaRe9XHHz6jPB
        M8XvXJn08fOJCd660xA/nwi0ZEmXjq1ZazXF393WWBkQ9c0yMG9Hvb8tcJwbOf9eiruvfcfTVHanP
        CvnueVd5fYDaynrO0Gp+6KNCoLblmKTPC7IS0DJIQdOQwx2xahxTeVrMwQOJITjRwRUbk2Li5Ykps
        tZvmgLqw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKONT-00Eupq-5V; Wed, 16 Feb 2022 17:46:07 +0000
Date:   Wed, 16 Feb 2022 17:46:07 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Sachin Sant <sachinp@linux.ibm.com>, linux-xfs@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, riteshh@linux.ibm.com,
        linux-next@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [next-20220215] WARNING at fs/iomap/buffered-io.c:75 with
 xfstests
Message-ID: <Yg04X73lr5YK5kwH@casper.infradead.org>
References: <5AD0BD6A-2C31-450A-924E-A581CD454073@linux.ibm.com>
 <20220216173504.GM8313@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216173504.GM8313@magnolia>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 16, 2022 at 09:35:04AM -0800, Darrick J. Wong wrote:
> On Wed, Feb 16, 2022 at 12:55:02PM +0530, Sachin Sant wrote:
> > [ 2547.662818] ------------[ cut here ]------------
> > [ 2547.662832] WARNING: CPU: 24 PID: 2463718 at fs/iomap/buffered-io.c:75 iomap_page_release+0x1b0/0x1e0
> 
> ...and I think this is complaining about this debugging test in
> iomap_page_release:
> 
> 	WARN_ON_ONCE(bitmap_full(iop->uptodate, nr_blocks) !=
> 			folio_test_uptodate(folio));
> 
> which checks that we're not releasing or invalidating a page that's
> partially uptodate on a blocksize < pagesize filesystem (or so I gather
> from "POWER10 LPAR" (64k pages?) and "XFS" (4k blocks?))...

This happens _all_ _the_ _time_ in my testing.  If your block size is
less than page size, you can expect it.

What it's supposed to be testing is that we remembered to set the
uptodate flag once all blocks in this page are uptodate.  What's
tripping the check is iomap_writepage_map()'s stupid clearing of the
uptodate flag on the folio:

        if (unlikely(error)) {
...
                if (!count) {
                        folio_clear_uptodate(folio);
                        folio_unlock(folio);
                        goto done;

What particularly annoys me about this is that the folio _was_ uptodate,
and it was dirty, so it has newer data in it than is on disk, but we're
going to re-read the folio from disk and throw away that user data.

> Given that in this case we've already cleared SB_ACTIVE from the
> superblock s_flags, I wonder if we could amend that code to read:
> 
> 	if (inode->i_sb->s_flags & SB_ACTIVE)
> 		WARN_ON_ONCE(bitmap_full(iop->uptodate, nr_blocks) !=
> 				folio_test_uptodate(folio));
> 
> Since we don't really care about memory pages that aren't fully up to
> date if we're in the midst of freeing all the incore filesystem state.
> 
> Thoughts?

Seems like papering over a bad design decision to me.
